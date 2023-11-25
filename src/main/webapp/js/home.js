const buttonsWrapper = document.querySelector(".map");
const slides = document.querySelector(".inner");

buttonsWrapper.addEventListener("click", e => {
	if (e.target.nodeName === "BUTTON") {
		Array.from(buttonsWrapper.children).forEach(item =>
			item.classList.remove("active")
		);
		if (e.target.classList.contains("first")) {
			slides.style.transform = "translateX(-0%)";
			e.target.classList.add("active");
		} else if (e.target.classList.contains("second")) {
			slides.style.transform = "translateX(-30%)";
			e.target.classList.add("active");
		} else if (e.target.classList.contains('third')) {
			slides.style.transform = 'translatex(-60.8%)';
			e.target.classList.add('active');
		}
	}
});


document.addEventListener("DOMContentLoaded", function() {
	// Get all the anchor links in the navbar
	var navbarLinks = document.querySelectorAll('.navbar-nav a');

	// Function to check if an element is in the viewport
	function isElementInViewport(el) {
		var rect = el.getBoundingClientRect();
		return (
			rect.top >= 0 &&
			rect.left >= 0 &&
			rect.bottom <= (window.innerHeight || document.documentElement.clientHeight) &&
			rect.right <= (window.innerWidth || document.documentElement.clientWidth)
		);
	}

	// Function to handle scroll event
	function handleScroll() {
		var sections = document.querySelectorAll('section');

		sections.forEach(function(section) {
			var sectionId = section.getAttribute('id');
			var correspondingLink = document.querySelector('.navbar-nav a[href="#' + sectionId + '"]');

			if (section && isElementInViewport(section)) {
				correspondingLink.classList.add('active');
			} else {
				correspondingLink.classList.remove('active');
			}
		});
	}

	// Attach scroll event listener
	window.addEventListener('scroll', handleScroll);

	// Attach click event listener to navbar links
	navbarLinks.forEach(function(link) {
		link.addEventListener('click', function(e) {
			e.preventDefault(); // Prevent default anchor behavior
			var sectionId = link.getAttribute('href').substring(1); // Get section ID from href
			var section = document.getElementById(sectionId);

			// Scroll to the target section
			if (section) {
				window.scrollTo({
					top: section.offsetTop - document.querySelector('.navbar').offsetHeight,
					behavior: 'smooth'
				});
			}
		});
	});
});