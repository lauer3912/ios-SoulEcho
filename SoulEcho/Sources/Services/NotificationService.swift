import Foundation
import UserNotifications

class NotificationService {

    static let shared = NotificationService()

    private let center = UNUserNotificationCenter.current()
    private let dailyKarmaIdentifier = "com.ggsheng.SoulEcho.dailyKarma"

    private init() {}

    // MARK: - Request Authorization

    func requestAuthorization(completion: @escaping (Bool) -> Void) {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print("Notification auth error: \(error)")
            }
            DispatchQueue.main.async {
                completion(granted)
            }
        }
    }

    // MARK: - Check Authorization Status

    func checkAuthorizationStatus(completion: @escaping (Bool) -> Void) {
        center.getNotificationSettings { settings in
            DispatchQueue.main.async {
                completion(settings.authorizationStatus == .authorized)
            }
        }
    }

    // MARK: - Schedule Daily Karma Reminder

    func scheduleDailyKarmaReminder(at hour: Int = 9, minute: Int = 0) {
        // Remove existing
        center.removePendingNotificationRequests(withIdentifiers: [dailyKarmaIdentifier])

        // Create trigger: daily at specified time
        let trigger = UNCalendarNotificationTrigger(
            dateMatching: DateComponents(hour: hour, minute: minute),
            repeats: true
        )

        let content = UNMutableNotificationContent()
        content.title = "🔮 Soul Echo"
        content.body = "✨ Your soul awaits. Discover your past life karma today!"
        content.sound = .default
        content.badge = 1

        let request = UNNotificationRequest(
            identifier: dailyKarmaIdentifier,
            content: content,
            trigger: trigger
        )

        center.add(request) { error in
            if let error = error {
                print("Failed to schedule notification: \(error)")
            } else {
                print("Daily karma reminder scheduled for \(hour):\(String(format: "%02d", minute))")
            }
        }
    }

    // MARK: - Cancel Notifications

    func cancelDailyReminder() {
        center.removePendingNotificationRequests(withIdentifiers: [dailyKarmaIdentifier])
    }

    // MARK: - UserDefaults Persistence

    var isNotificationEnabled: Bool {
        get { UserDefaults.standard.bool(forKey: "SoulEcho.notificationsEnabled") }
        set { UserDefaults.standard.set(newValue, forKey: "SoulEcho.notificationsEnabled") }
    }

    var notificationHour: Int {
        get { UserDefaults.standard.integer(forKey: "SoulEcho.notificationHour") }
        set { UserDefaults.standard.set(newValue, forKey: "SoulEcho.notificationHour") }
    }

    var notificationMinute: Int {
        get { UserDefaults.standard.integer(forKey: "SoulEcho.notificationMinute") }
        set { UserDefaults.standard.set(newValue, forKey: "SoulEcho.notificationMinute") }
    }

    // MARK: - Toggle With Persistence

    func toggleNotifications(enabled: Bool, hour: Int = 9, minute: Int = 0, completion: @escaping (Bool) -> Void) {
        if enabled {
            requestAuthorization { [weak self] granted in
                guard let self = self else { return }
                if granted {
                    self.isNotificationEnabled = true
                    self.notificationHour = hour
                    self.notificationMinute = minute
                    self.scheduleDailyKarmaReminder(at: hour, minute: minute)
                    completion(true)
                } else {
                    self.isNotificationEnabled = false
                    completion(false)
                }
            }
        } else {
            isNotificationEnabled = false
            cancelDailyReminder()
            completion(true)
        }
    }

    // MARK: - Restore Scheduled Notifications (on app launch)

    func restoreScheduledNotifications() {
        if isNotificationEnabled {
            let hour = notificationHour > 0 ? notificationHour : 9
            let minute = notificationMinute
            scheduleDailyKarmaReminder(at: hour, minute: minute)
        }
    }
}
