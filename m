Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC63621412D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727838AbgGCVoN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgGCVoM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:44:12 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 306D6C061794;
        Fri,  3 Jul 2020 14:44:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=incZpa5IzYuxKoiVY1wfaG2NDrHQ8Af3HlDfc4ZtKDk=; b=KEMj7EoGqSbPuk7g2qxJF1qUP/
        CY6kqOAsh2Juj8iQvnuFEy2bV69j9JSGthAPu2m68ycrMUgtQM72hXhI6P/dQTowSl0qhQYAi19fG
        KPgIaXtFNhbtYxo2657TsAWYkg4bHcxNFwDVQ2ZPeoMCoI8SehbPfp/UPte4cgP8uaa4Bi+8yQVnA
        EdGeZBlNiZ3yPuC4TFSgkBJPUMfS2/0nHSRbTBk/Eh7WgpMt5zPHsB2LMC0CMrlkLwDFIbTj5szCn
        t0gH80gG70GITOIlbUZY4Oudy0vu59YfhplxD9y3riRQuMaUf+oBfyWccwA5NI+1XdA+fvi9XceNV
        e1WJ04ow==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTc-0006uZ-W1; Fri, 03 Jul 2020 21:44:10 +0000
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
Subject: [PATCH 07/10] Documentation: filesystems: overlayfs: drop doubled word
Date:   Fri,  3 Jul 2020 14:43:22 -0700
Message-Id: <20200703214325.31036-8-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "the".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-unionfs@vger.kernel.org
---
 Documentation/filesystems/overlayfs.rst |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200701.orig/Documentation/filesystems/overlayfs.rst
+++ linux-next-20200701/Documentation/filesystems/overlayfs.rst
@@ -328,7 +328,7 @@ the time of copy (on-demand vs. up-front
 Multiple lower layers
 ---------------------
 
-Multiple lower layers can now be given using the the colon (":") as a
+Multiple lower layers can now be given using the colon (":") as a
 separator character between the directory names.  For example:
 
   mount -t overlay overlay -olowerdir=/lower1:/lower2:/lower3 /merged
