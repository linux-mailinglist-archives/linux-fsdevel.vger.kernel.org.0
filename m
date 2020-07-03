Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30A9F214127
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Jul 2020 23:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgGCVoH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Jul 2020 17:44:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgGCVoG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Jul 2020 17:44:06 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E56DC061794;
        Fri,  3 Jul 2020 14:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=+9BMx8vXl0RZqSK+MgrF6zLZBmku3oa+32qwOecwZUg=; b=rZ/20u0Ti2mJi1e37mKEYHghIH
        60xqLsz5GHX+Pk01aa37T0Cb+T+CwvDTnRTWgjcK6latUX3pIy9dwcRPVCSLqvbBwljN/hr06vHr8
        Q0e+ujHDCDJMcY+VZ/vOLA1y3hf5dhGd6SI5fKUGJ5z5/o6b1eywWjp9IgjzUrEml6fuuom401BOe
        +PBWkK6XoLG4G2ZBP/evAgydhGDU+5KLAuUL4fqxqzZA91ViZleW05VLi5UYv8FlZkWNkDVzYoHSY
        crsyxR+8FY1QnRmGEw4z2r91dHH2gtAFH5axuW4KpwcjGGofQc8HTaaE+Z3QxHWXbyD3bCMyAQ6jk
        p8ZQHPBQ==;
Received: from [2601:1c0:6280:3f0::19c2] (helo=smtpauth.infradead.org)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jrTTX-0006uZ-SN; Fri, 03 Jul 2020 21:44:04 +0000
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
Subject: [PATCH 06/10] Documentation: filesystems: mount_api: drop doubled word
Date:   Fri,  3 Jul 2020 14:43:21 -0700
Message-Id: <20200703214325.31036-7-rdunlap@infradead.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200703214325.31036-1-rdunlap@infradead.org>
References: <20200703214325.31036-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Drop the doubled word "struct".

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/mount_api.rst |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20200701.orig/Documentation/filesystems/mount_api.rst
+++ linux-next-20200701/Documentation/filesystems/mount_api.rst
@@ -213,7 +213,7 @@ The filesystem context points to a table
 		void (*free)(struct fs_context *fc);
 		int (*dup)(struct fs_context *fc, struct fs_context *src_fc);
 		int (*parse_param)(struct fs_context *fc,
-				   struct struct fs_parameter *param);
+				   struct fs_parameter *param);
 		int (*parse_monolithic)(struct fs_context *fc, void *data);
 		int (*get_tree)(struct fs_context *fc);
 		int (*reconfigure)(struct fs_context *fc);
@@ -247,7 +247,7 @@ manage the filesystem context.  They are
    * ::
 
 	int (*parse_param)(struct fs_context *fc,
-			   struct struct fs_parameter *param);
+			   struct fs_parameter *param);
 
      Called when a parameter is being added to the filesystem context.  param
      points to the key name and maybe a value object.  VFS-specific options
