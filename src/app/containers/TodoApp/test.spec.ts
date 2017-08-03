import { expect } from 'chai';

describe('localhost page on test-server', function() {
    it('should have the right title', function () {
        browser.url('http://localhost:3001');
        var title = browser.getTitle();
        expect(title).to.equal('Frontend Boilerplate with React and TypeScript');
    });
});