Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B4CD21413E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727894AbgGCVoc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:44:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgGCVo1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:44:27 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A02B5C061794;
        Fri,  3 Jul 2020 14:44:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=ILpmrV2eNPdvPeK1dECfENZEkUmBXji6ftIM6D551pA=; b=LxgYlyiPvBUWMgCB8mPS2nWUEx
        q7v6Efl3XLXne3UNqnWGJRg2PGPzBc1ZF9G2OnL9ptKDcQf9xhrMj/jL/+XWcOsD68Bk0MAuKN76b
        VsujYhPeiH2eCar8Hsn8o4BccgaTxFosKGd2FdLyY0gXPS2OXm9p/QXdxPk8eWT3+nUp1J7URpSnU
        dqvC5YRWWotE1l07bt30zbXD8FBAc212qkG+SJKOfJiz7F4idMT0YvGUVCrv4BPxi86OzhOSuMhZA
        +nByh+A/0oXcGRYogct2TVyQJlkIk+BnH1FoUg+C+lcM6RZ4BXAkfQGPzNEVkR8spk+BxbPmNiQ+y
        7Xvn/c8Q==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTt-0006uZ-7v; Fri, 03 Jul 2020 21:44:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        Ian Kent <raven@themaw.net>, autofs@vger.kernel.org,
        David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com,
        Joel Becker <jlbec@evilplan.org>,
        Christoph Hellwig <hch@lst.de>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        "Theodore Y . Ts'o" <tytso@mit.edu>, linux-fscrypt@vger.kernel.org,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-unionfs@vger.kernel.org
Subject: [PATCH 10/10] Documentation: filesystems: vfs: drop doubled words
Date:   Fri,  3 Jul 2020 14:43:25 -0700
Message-Id: <20200703214325.31036-11-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled words "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/vfs.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/filesystems/vfs.rst
+++ linux-next-20200701/Documentation/filesystems/vfs.rst
@@ -392,7 +392,7 @@ Extended attributes are name:value pairs
 ``set``
 	Called by the VFS to set the value of a particular extended
 	attribute.  When the new value is NULL, called to remove a
-	particular extended attribute.  This method is called by the the
+	particular extended attribute.  This method is called by the
 	setxattr(2) and removexattr(2) system calls.
 
 When none of the xattr handlers of a filesystem match the specified
@@ -652,7 +652,7 @@ at any point after PG_Dirty is clear.  O
 PG_Writeback is cleared.
 
 Writeback makes use of a writeback_control structure to direct the
-operations.  This gives the the writepage and writepages operations some
+operations.  This gives the writepage and writepages operations some
 information about the nature of and reason for the writeback request,
 and the constraints under which it is being done.  It is also used to
 return information back to the caller about the result of a writepage or
