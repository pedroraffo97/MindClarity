//
//  MeditationClass.swift
//  MindClarity
//
//  Created by Pedro Raffo Leon on 19.01.24.
//

import Foundation

struct MeditationVideo: Identifiable, Encodable, Decodable, Hashable {
    var videoName: String
    var videoDescription: String
    var videoLink: String
    var id: UUID = UUID()
}

class MeditationContent: ObservableObject {
    @Published var meditation_Content_Videos: [MeditationVideo] = [
     meditationVideo1, 
     meditationVideo2,
     meditationVideo3
    ]
}

// Meditation Videos

var meditationVideo1 = MeditationVideo (
    videoName: "Free Short Meditation: Release Stress and Anxious Thoughts",
    videoDescription: "Learn to be present with the feeling of stress and tension being released.",
    videoLink: "https://www.youtube.com/watch?v=nFkHV7LfVUc"
)

var meditationVideo2 = MeditationVideo (
    videoName: "10-Minute Meditation to Reframe Stress",
    videoDescription: """
This video mentions a free experience that is no longer available. Please visit headspace.com for current free trials and available discounts.Stress takes on many forms, especially when a day has felt particularly challenging. Nothing can change the circumstances, but this exercise teaches you how to notice what you're holding onto and how to drop the preoccupying storyline, allowing you to reframe stressful situations.
""",
    videoLink: "https://www.youtube.com/watch?v=sG7DBA-mgFY"
)

var meditationVideo3 = MeditationVideo(
    videoName: "Free Five Minute Guided Meditation with Eve",
    videoDescription: """
How can I make time to meditate if I’m so busy with daily responsibilities? How do I practice self-care if my schedule is too hectic for meditation? In this calming meditation guided by Headspace Meditation and Mindfulness Teacher Eve Prieto, we’ll learn to practice self-compassion and prioritize taking care of ourselves by making time for “me time,” especially for caregivers and people who provide care to others. We’ll take a few minutes to be kind to ourselves with a self-care mindfulness exercise so that we can take a break, rest, relax, and continue to show up for the people in our lives. 

""",
    videoLink: "https://www.youtube.com/watch?v=pB_qUY1dPrs"
)
