Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8222CB244
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Dec 2020 02:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbgLBBY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Dec 2020 20:24:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727154AbgLBBY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Dec 2020 20:24:58 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAD8C0613D4;
        Tue,  1 Dec 2020 17:24:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=mD85UbhtyukYDJcTCzGhzPvfI1JWKEBbqyiuxqWmjGw=; b=wW1COTIsA6c+axy822mi9QdlfF
        cWWPMIoSvtDDsLl0eBX5PttewLNjFppp2iBh3JdKRDRgHGVEHJh1TPwTkIMUM6VH5151CNiG+L45Q
        7n0tqnJVwg2brfZr5hOo985THNkEaR+nR9ccJ19NviWnZB+MZ6T61wCTXOUnvMo/Dnr+wRQvcdsNO
        HbJmcDJUJqGPNgFkjHQ8SN6Hn8utkt4EK7YduxsH0sDaZKc1WgvcEAgE48NtkqtZRCTN6PAfnC7ug
        3sMVoYYMqnh7wvHrKqKc8ZzZMH0xxa+4D9xu+nAU1oKOaaiOkUNRu7zoNOswfh7zHYcl/chp/dFQX
        HgozkMLg==;
Received: from [2601:1c0:6280:3f0::1494] (helo=smtpauth.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kkGsP-00015m-FB; Wed, 02 Dec 2020 01:24:15 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        David Howells <dhowells@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: mount_api: change kernel log wording
Date:   Tue,  1 Dec 2020 17:24:09 -0800
Message-Id: <20201202012409.19194-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change wording to say that messages are logged to the kernel log
buffer instead of to dmesg. dmesg is just one program that can
print the kernel log buffer.

Fixes: 7d6ab823d646 ("vfs: Update mount API docs")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: David Howells <dhowells@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
---
 Documentation/filesystems/mount_api.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20201201.orig/Documentation/filesystems/mount_api.rst
+++ linux-next-20201201/Documentation/filesystems/mount_api.rst
@@ -774,7 +774,7 @@ process the parameters it is given.
      should just be set to lie inside the low-to-high range.
 
      If all is good, true is returned.  If the table is invalid, errors are
-     logged to dmesg and false is returned.
+     logged to the kernel log buffer and false is returned.
 
    * ::
 
@@ -782,7 +782,7 @@ process the parameters it is given.
 
      This performs some validation checks on a parameter description.  It
      returns true if the description is good and false if it is not.  It will
-     log errors to dmesg if validation fails.
+     log errors to the kernel log buffer if validation fails.
 
    * ::
 
