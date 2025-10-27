import UIKit

public class DualProgressView: UIView {

    // MARK: - UI Components
    private let secondaryProgressView: UIProgressView = {
        let progress = UIProgressView(progressViewStyle: .default)
        progress.translatesAutoresizingMaskIntoConstraints = false
        progress.trackTintColor = UIColor.systemGray5
        progress.progressTintColor = UIColor.systemGray3
        return progress
    }()

    private let primarySlider: UISlider = {
        let slider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.minimumTrackTintColor = UIColor.systemBlue
        slider.maximumTrackTintColor = .clear
        slider.isContinuous = true
        return slider
    }()

    // MARK: - Properties
    var primaryProgress: Float {
        get { primarySlider.value }
        set { primarySlider.value = newValue }
    }

    var secondaryProgress: Float {
        get { secondaryProgressView.progress }
        set { secondaryProgressView.setProgress(newValue, animated: true) }
    }

    var onPrimaryProgressChanged: ((Float) -> Void)?

    // MARK: - Initialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }

    // MARK: - Setup
    private func setupView() {
        addSubview(secondaryProgressView)
        addSubview(primarySlider)

        NSLayoutConstraint.activate([
            // Secondary progress view constraints
            secondaryProgressView.leadingAnchor.constraint(equalTo: leadingAnchor),
            secondaryProgressView.trailingAnchor.constraint(equalTo: trailingAnchor),
            secondaryProgressView.centerYAnchor.constraint(equalTo: centerYAnchor),

            // Primary slider constraints
            primarySlider.leadingAnchor.constraint(equalTo: leadingAnchor),
            primarySlider.trailingAnchor.constraint(equalTo: trailingAnchor),
            primarySlider.centerYAnchor.constraint(equalTo: centerYAnchor),
            primarySlider.topAnchor.constraint(equalTo: topAnchor),
            primarySlider.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        primarySlider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
    }

    @objc private func sliderValueChanged() {
        onPrimaryProgressChanged?(primarySlider.value)
    }

    // MARK: - Public Methods
    func setPrimaryProgress(_ progress: Float, animated: Bool) {
        primarySlider.setValue(progress, animated: animated)
    }

    func setPrimaryColor(_ color: UIColor) {
        primarySlider.minimumTrackTintColor = color
    }

    func setSecondaryProgress(_ progress: Float, animated: Bool) {
        secondaryProgressView.setProgress(progress, animated: animated)
    }

    func setSecondaryColor(_ color: UIColor) {
        secondaryProgressView.progressTintColor = color
    }
}
