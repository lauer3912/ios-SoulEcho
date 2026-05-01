import UIKit

class HomeViewController: UIViewController {

    private let titleLabel = UILabel()
    private let subtitleLabel = UILabel()
    private let nameField = UITextField()
    private let datePicker = UIDatePicker()
    private let discoverButton = UIButton(type: .system)
    private let chipsScrollView = UIScrollView()
    private let chipsStack = UIStackView()
    private let particlesView = ParticleBackgroundView()

    private let archetypes = [
        "Warrior ⚔️", "Healer ✨", "Seeker 🔮", "Magician 🧙",
        "Ruler 👑", "Sage 📜", "Explorer 🧭", "Lover 💕"
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }

    private func setupUI() {
        view.backgroundColor = UIColor(hex: "#1A0A2E") ?? .black
        navigationController?.navigationBar.isHidden = true

        // Particle background
        view.addSubview(particlesView)
        particlesView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            particlesView.topAnchor.constraint(equalTo: view.topAnchor),
            particlesView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            particlesView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            particlesView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        // Title
        titleLabel.text = "Soul Echo"
        titleLabel.font = .systemFont(ofSize: 40, weight: .heavy)
        titleLabel.textColor = UIColor(hex: "#FCD34D") ?? .yellow
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)

        // Subtitle
        subtitleLabel.text = "Your Past Life Journey Awaits"
        subtitleLabel.font = .systemFont(ofSize: 14, weight: .light)
        subtitleLabel.textColor = .white.withAlphaComponent(0.6)
        subtitleLabel.textAlignment = .center
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subtitleLabel)

        // Name field
        nameField.placeholder = "Enter your name"
        nameField.font = .systemFont(ofSize: 18)
        nameField.textColor = .white
        nameField.backgroundColor = .white.withAlphaComponent(0.1)
        nameField.layer.cornerRadius = 14
        nameField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        nameField.leftViewMode = .always
        nameField.rightView = UIView(frame: CGRect(x: 0, y: 0, width: 16, height: 0))
        nameField.rightViewMode = .always
        nameField.attributedPlaceholder = NSAttributedString(
            string: "Enter your name",
            attributes: [.foregroundColor: UIColor.white.withAlphaComponent(0.4)]
        )
        nameField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(nameField)

        // Date picker
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = UIColor(hex: "#FCD34D") ?? .yellow
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(datePicker)

        // Discover button
        discoverButton.setTitle("Discover Your Past Life →", for: .normal)
        discoverButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        discoverButton.backgroundColor = UIColor(hex: "#FCD34D") ?? .yellow
        discoverButton.setTitleColor(UIColor(hex: "#1A0A2E") ?? .black, for: .normal)
        discoverButton.layer.cornerRadius = 25
        discoverButton.translatesAutoresizingMaskIntoConstraints = false
        discoverButton.addTarget(self, action: #selector(discoverPastLife), for: .touchUpInside)
        view.addSubview(discoverButton)

        // Example chips
        chipsScrollView.showsHorizontalScrollIndicator = false
        chipsScrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(chipsScrollView)

        chipsStack.axis = .horizontal
        chipsStack.spacing = 10
        chipsStack.translatesAutoresizingMaskIntoConstraints = false
        chipsScrollView.addSubview(chipsStack)

        for archetype in archetypes {
            let chip = makeChip(text: archetype)
            chipsStack.addArrangedSubview(chip)
        }

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),

            nameField.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 50),
            nameField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 24),
            nameField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -24),
            nameField.heightAnchor.constraint(equalToConstant: 54),

            datePicker.topAnchor.constraint(equalTo: nameField.bottomAnchor, constant: 16),
            datePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            discoverButton.topAnchor.constraint(equalTo: datePicker.bottomAnchor, constant: 30),
            discoverButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            discoverButton.widthAnchor.constraint(equalToConstant: 280),
            discoverButton.heightAnchor.constraint(equalToConstant: 50),

            chipsScrollView.topAnchor.constraint(equalTo: discoverButton.bottomAnchor, constant: 40),
            chipsScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            chipsScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            chipsScrollView.heightAnchor.constraint(equalToConstant: 44),

            chipsStack.topAnchor.constraint(equalTo: chipsScrollView.topAnchor),
            chipsStack.bottomAnchor.constraint(equalTo: chipsScrollView.bottomAnchor),
            chipsStack.leadingAnchor.constraint(equalTo: chipsScrollView.leadingAnchor, constant: 24),
            chipsStack.trailingAnchor.constraint(equalTo: chipsScrollView.trailingAnchor, constant: -24),
            chipsStack.heightAnchor.constraint(equalTo: chipsScrollView.heightAnchor)
        ])
    }

    private func makeChip(text: String) -> UIButton {
        let btn = UIButton(type: .system)
        btn.setTitle(text, for: .normal)
        btn.titleLabel?.font = .systemFont(ofSize: 13, weight: .medium)
        btn.setTitleColor(UIColor(hex: "#6B3FA0") ?? .purple, for: .normal)
        btn.backgroundColor = (UIColor(hex: "#6B3FA0") ?? .purple).withAlphaComponent(0.2)
        btn.layer.cornerRadius = 16
        btn.layer.borderWidth = 1
        btn.layer.borderColor = (UIColor(hex: "#6B3FA0") ?? .purple).withAlphaComponent(0.4).cgColor
        btn.contentEdgeInsets = UIEdgeInsets(top: 8, left: 14, bottom: 8, right: 14)
        return btn
    }

    @objc private func discoverPastLife() {
        let name = nameField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        let date = datePicker.date

        let resultVC = PastLifeResultViewController(name: name.isEmpty ? "Mysterious Soul" : name, birthDate: date)
        navigationController?.pushViewController(resultVC, animated: true)
    }
}

// MARK: - Particle Background
class ParticleBackgroundView: UIView {
    private var emitter: CAEmitterLayer?

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupEmitter()
    }

    required init?(coder: NSCoder) { fatalError() }

    private func setupEmitter() {
        emitter = CAEmitterLayer()
        emitter?.emitterPosition = CGPoint(x: bounds.midX, y: -10)
        emitter?.emitterSize = CGSize(width: bounds.width, height: 1)
        emitter?.emitterShape = .line
        emitter?.renderMode = .additive

        let cell = CAEmitterCell()
        cell.birthRate = 3
        cell.lifetime = 8
        cell.velocity = 40
        cell.velocityRange = 20
        cell.emissionLongitude = .pi
        cell.scale = 0.06
        cell.scaleRange = 0.03
        cell.alphaSpeed = -0.1
        cell.contents = UIImage(systemName: "sparkle")?.withTintColor(.white, renderingMode: .alwaysOriginal).cgImage

        emitter?.emitterCells = [cell]
        layer.addSublayer(emitter!)
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        emitter?.emitterPosition = CGPoint(x: bounds.midX, y: -10)
        emitter?.emitterSize = CGSize(width: bounds.width, height: 1)
    }
}
