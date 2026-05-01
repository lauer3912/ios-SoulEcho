import UIKit

class PastLifeResultViewController: UIViewController {

    private let name: String
    private let birthDate: Date
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let shareButton = UIButton(type: .system)

    private let archetypes = ["Warrior", "Healer", "Seeker", "Magician", "Ruler", "Sage", "Explorer", "Lover", "Creator", "Provider", "Transformer", "Innocent"]
    private let locations = ["Medieval England", "Ancient Rome", "Imperial China", "Ancient Egypt", "Renaissance Florence", "Colonial America", "Samurai Japan", "Viking Scandinavia", "Persian Empire", "Maya Civilization"]
    private let deathReasons = ["Battle in the Crusades", "Peaceful passing at 83", "Protecting loved ones", "At sea during a storm", "Ancient plague", "Royal intrigue", "Searching for treasure", "A great love story's end"]

    init(name: String, birthDate: Date) {
        self.name = name
        self.birthDate = birthDate
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) { fatalError() }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        generateResult()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        navigationController?.navigationBar.isHidden = false

        // Back button
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "chevron.left"), style: .plain, target: self, action: #selector(goBack))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"), style: .plain, target: self, action: #selector(shareResult))

        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        contentView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(contentView)

        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }

    private func generateResult() {
        let archetype = archetypes.randomElement()!
        let location = locations.randomElement()!
        let deathReason = deathReasons.randomElement()!
        let karma = Int.random(in: 45...98)
        let lessons = ["Courage", "Loyalty", "Sacrifice", "Wisdom", "Love", "Perseverance"].shuffled().prefix(3)
        let era = ["12th Century", "15th Century", "3rd Century BC", "8th Century", "17th Century"].randomElement()!

        // Soul archetype card
        let card = makeCard()
        contentView.addSubview(card)

        let archetypeLabel = UILabel()
        archetypeLabel.text = "\(archetype) · \(era)"
        archetypeLabel.font = .systemFont(ofSize: 11, weight: .medium)
        archetypeLabel.textColor = UIColor(hex: "#FCD34D") ?? .yellow
        archetypeLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(archetypeLabel)

        let locationLabel = UILabel()
        locationLabel.text = "📍 \(location)"
        locationLabel.font = .systemFont(ofSize: 14)
        locationLabel.textColor = .white.withAlphaComponent(0.8)
        locationLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(locationLabel)

        // Karma score
        let karmaCard = makeKarmaCard(score: karma)
        contentView.addSubview(karmaCard)

        // Life lessons
        let lessonsCard = makeLessonsCard(lessons: Array(lessons))
        contentView.addSubview(lessonsCard)

        // Death reason
        let deathCard = makeDeathCard(reason: deathReason, era: era)
        contentView.addSubview(deathCard)

        // Read full story button
        let storyBtn = UIButton(type: .system)
        storyBtn.setTitle("🔓 Read Full Story (Premium)", for: .normal)
        storyBtn.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        storyBtn.backgroundColor = UIColor(hex: "#6B3FA0")?.withAlphaComponent(0.3)
        storyBtn.setTitleColor(UIColor(hex: "#FCD34D") ?? .yellow, for: .normal)
        storyBtn.layer.cornerRadius = 20
        storyBtn.layer.borderWidth = 1
        storyBtn.layer.borderColor = UIColor(hex: "#6B3FA0")?.withAlphaComponent(0.5).cgColor
        storyBtn.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(storyBtn)

        // Layout
        NSLayoutConstraint.activate([
            card.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            card.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            card.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            archetypeLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 20),
            archetypeLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            archetypeLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20),

            locationLabel.topAnchor.constraint(equalTo: archetypeLabel.bottomAnchor, constant: 8),
            locationLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -20),
            locationLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -20),

            karmaCard.topAnchor.constraint(equalTo: card.bottomAnchor, constant: 16),
            karmaCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            karmaCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            lessonsCard.topAnchor.constraint(equalTo: karmaCard.bottomAnchor, constant: 16),
            lessonsCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lessonsCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            deathCard.topAnchor.constraint(equalTo: lessonsCard.bottomAnchor, constant: 16),
            deathCard.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            deathCard.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),

            storyBtn.topAnchor.constraint(equalTo: deathCard.bottomAnchor, constant: 30),
            storyBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            storyBtn.widthAnchor.constraint(equalToConstant: 260),
            storyBtn.heightAnchor.constraint(equalToConstant: 44),
            storyBtn.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -40)
        ])
    }

    private func makeCard() -> UIView {
        let card = UIView()
        card.backgroundColor = UIColor.white.withAlphaComponent(0.05)
        card.layer.cornerRadius = 20
        card.layer.borderWidth = 1
        card.layer.borderColor = (UIColor(hex: "#FCD34D") ?? .yellow).withAlphaComponent(0.2).cgColor
        card.translatesAutoresizingMaskIntoConstraints = false
        return card
    }

    private func makeKarmaCard(score: Int) -> UIView {
        let card = makeCard()

        let titleLabel = UILabel()
        titleLabel.text = "Karma Score"
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#FCD34D") ?? .yellow
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(titleLabel)

        let scoreLabel = UILabel()
        scoreLabel.text = "\(score)/100"
        scoreLabel.font = .systemFont(ofSize: 32, weight: .heavy)
        scoreLabel.textColor = .white
        scoreLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(scoreLabel)

        let subtitleLabel = UILabel()
        subtitleLabel.text = score > 80 ? "✨ Enlightened Soul" : score > 60 ? "⭐ Evolved Soul" : "🌱 Growing Soul"
        subtitleLabel.font = .systemFont(ofSize: 12)
        subtitleLabel.textColor = .white.withAlphaComponent(0.6)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(subtitleLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),

            scoreLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            scoreLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            scoreLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16),

            subtitleLabel.centerYAnchor.constraint(equalTo: scoreLabel.centerYAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16)
        ])

        return card
    }

    private func makeLessonsCard(lessons: [String]) -> UIView {
        let card = makeCard()

        let titleLabel = UILabel()
        titleLabel.text = "Life Lessons"
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#FCD34D") ?? .yellow
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(titleLabel)

        let tagsStack = UIStackView()
        tagsStack.axis = .horizontal
        tagsStack.spacing = 8
        tagsStack.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(tagsStack)

        for lesson in lessons {
            let tag = UILabel()
            tag.text = lesson
            tag.font = .systemFont(ofSize: 12, weight: .medium)
            tag.textColor = .white
            tag.backgroundColor = (UIColor(hex: "#6B3FA0") ?? .purple).withAlphaComponent(0.3)
            tag.layer.cornerRadius = 10
            tag.clipsToBounds = true
            tag.textAlignment = .center
            tag.layer.borderWidth = 1
            tag.layer.borderColor = (UIColor(hex: "#6B3FA0") ?? .purple).withAlphaComponent(0.4).cgColor
            tag.translatesAutoresizingMaskIntoConstraints = false
            tag.heightAnchor.constraint(equalToConstant: 28).isActive = true
            tag.widthAnchor.constraint(greaterThanOrEqualToConstant: 60).isActive = true
            tagsStack.addArrangedSubview(tag)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),

            tagsStack.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            tagsStack.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            tagsStack.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])

        return card
    }

    private func makeDeathCard(reason: String, era: String) -> UIView {
        let card = makeCard()

        let titleLabel = UILabel()
        titleLabel.text = "How You Died"
        titleLabel.font = .systemFont(ofSize: 13, weight: .bold)
        titleLabel.textColor = UIColor(hex: "#FCD34D") ?? .yellow
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(titleLabel)

        let bodyLabel = UILabel()
        bodyLabel.text = "\(reason), \(era)"
        bodyLabel.font = .systemFont(ofSize: 15)
        bodyLabel.textColor = .white.withAlphaComponent(0.8)
        bodyLabel.numberOfLines = 0
        bodyLabel.translatesAutoresizingMaskIntoConstraints = false
        card.addSubview(bodyLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: card.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),

            bodyLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            bodyLabel.leadingAnchor.constraint(equalTo: card.leadingAnchor, constant: 16),
            bodyLabel.trailingAnchor.constraint(equalTo: card.trailingAnchor, constant: -16),
            bodyLabel.bottomAnchor.constraint(equalTo: card.bottomAnchor, constant: -16)
        ])

        return card
    }

    @objc private func goBack() {
        navigationController?.popViewController(animated: true)
    }

    @objc private func shareResult() {
        let text = "My past life was a \(archetypes.randomElement()!) in \(locations.randomElement()!)! What's your past life? Discover with Soul Echo 🔮"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        present(activityVC, animated: true)
    }
}
