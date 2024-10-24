module.exports = {
    branches: [
        { name: "master", prerelease: true },
        "prerelease-workaround",
    ],
    plugins: [
        "@semantic-release/commit-analyzer",
        "@semantic-release/release-notes-generator",
        ["@semantic-release/changelog", {
            changelogFile: "CHANGELOG.md",
        }],
        ["@semantic-release/npm", {
            npmPublish: false,
        }],
        ["@semantic-release/git", {
            assets: ["package.json", "CHANGELOG.md"],
            message: "chore(release): ${nextRelease.version}\n\n${nextRelease.notes}",
        }],
        "@semantic-release/github",
    ],
};
