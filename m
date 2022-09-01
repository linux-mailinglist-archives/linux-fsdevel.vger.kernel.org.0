Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A1165A89CE
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 02:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbiIAA2m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 20:28:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiIAA2i (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 20:28:38 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0992107C52;
        Wed, 31 Aug 2022 17:28:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=j0HvPtELhH3B71uPg+RoqV/ydt8FuGjBSysvzMxQlCE=; b=bsHxTyn4JVY22blRnvC8UcfNri
        bHP70HiTpbP59JKneE75L8iZ3h7LXhCKW8bL6yPBZhJ8qG3lfvv565pU+Fswh/3hjd8clIH014LwY
        i/cLz+NBFDDae8CYdrnWZ+hhrVKz+vCnT7vh6/wkvCCTv8tO066H7VkwwrT2apY/cUPvHVHQlPdhP
        eJ4KNl74rUbaJQRo2S+QcleBlfPGUbU0OWO+9F+VBzUyDLf7o6lL1pogPy4pNAbzQTr0N5YuEHxf/
        74ysh1xTDDZ4SnKrMNHR6t1K+E/qOLG7F6mg8uUotHEqq0sWup2Ki3vfWPbnIR5x83sGcHEg3r4kV
        EtnP2voA==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oTY4R-005Zgq-10; Thu, 01 Sep 2022 00:28:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        "Darrick J . Wong" <djwong@kernel.org>
Subject: [PATCH v2] Documentation: filesystems: correct possessive "its"
Date:   Wed, 31 Aug 2022 17:28:28 -0700
Message-Id: <20220901002828.25102-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Change occurrences of "it's" that are possessive to "its"
so that they don't read as "it is".

For f2fs.rst, reword one description for better clarity.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-xfs@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Theodore Ts'o <tytso@mit.edu>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>
Reviewed-by: Darrick J. Wong <djwong@kernel.org>
Reviewed-by: "Christian Brauner (Microsoft)" <brauner@kernel.org>
---
v2: Reword the compress_log_size description.
    Rebase (the xfs file changed).
    Add Reviewed-by: tags.

Thanks for Al and Ted for suggesting rewording the f2fs.rst description.

 Documentation/filesystems/f2fs.rst                       |    5 ++---
 Documentation/filesystems/idmappings.rst                 |    2 +-
 Documentation/filesystems/qnx6.rst                       |    2 +-
 Documentation/filesystems/xfs-delayed-logging-design.rst |    6 +++---
 4 files changed, 7 insertions(+), 8 deletions(-)

--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -286,9 +286,8 @@ compress_algorithm=%s:%d Control compres
 			 algorithm	level range
 			 lz4		3 - 16
 			 zstd		1 - 22
-compress_log_size=%u	 Support configuring compress cluster size, the size will
-			 be 4KB * (1 << %u), 16KB is minimum size, also it's
-			 default size.
+compress_log_size=%u	 Support configuring compress cluster size. The size will
+			 be 4KB * (1 << %u). The default and minimum sizes are 16KB.
 compress_extension=%s	 Support adding specified extension, so that f2fs can enable
 			 compression on those corresponding files, e.g. if all files
 			 with '.ext' has high compression rate, we can set the '.ext'
--- a/Documentation/filesystems/idmappings.rst
+++ b/Documentation/filesystems/idmappings.rst
@@ -661,7 +661,7 @@ idmappings::
  mount idmapping:      u0:k10000:r10000
 
 Assume a file owned by ``u1000`` is read from disk. The filesystem maps this id
-to ``k21000`` according to it's idmapping. This is what is stored in the
+to ``k21000`` according to its idmapping. This is what is stored in the
 inode's ``i_uid`` and ``i_gid`` fields.
 
 When the caller queries the ownership of this file via ``stat()`` the kernel
--- a/Documentation/filesystems/qnx6.rst
+++ b/Documentation/filesystems/qnx6.rst
@@ -176,7 +176,7 @@ Then userspace.
 The requirement for a static, fixed preallocated system area comes from how
 qnx6fs deals with writes.
 
-Each superblock got it's own half of the system area. So superblock #1
+Each superblock got its own half of the system area. So superblock #1
 always uses blocks from the lower half while superblock #2 just writes to
 blocks represented by the upper half bitmap system area bits.
 
--- a/Documentation/filesystems/xfs-delayed-logging-design.rst
+++ b/Documentation/filesystems/xfs-delayed-logging-design.rst
@@ -551,14 +551,14 @@ Essentially, this shows that an item tha
 and relogged, so any tracking must be separate to the AIL infrastructure. As
 such, we cannot reuse the AIL list pointers for tracking committed items, nor
 can we store state in any field that is protected by the AIL lock. Hence the
-committed item tracking needs it's own locks, lists and state fields in the log
+committed item tracking needs its own locks, lists and state fields in the log
 item.
 
 Similar to the AIL, tracking of committed items is done through a new list
 called the Committed Item List (CIL).  The list tracks log items that have been
 committed and have formatted memory buffers attached to them. It tracks objects
 in transaction commit order, so when an object is relogged it is removed from
-it's place in the list and re-inserted at the tail. This is entirely arbitrary
+its place in the list and re-inserted at the tail. This is entirely arbitrary
 and done to make it easy for debugging - the last items in the list are the
 ones that are most recently modified. Ordering of the CIL is not necessary for
 transactional integrity (as discussed in the next section) so the ordering is
@@ -884,7 +884,7 @@ pin the object the first time it is inse
 the CIL during a transaction commit, then we do not pin it again. Because there
 can be multiple outstanding checkpoint contexts, we can still see elevated pin
 counts, but as each checkpoint completes the pin count will retain the correct
-value according to it's context.
+value according to its context.
 
 Just to make matters slightly more complex, this checkpoint level context
 for the pin count means that the pinning of an item must take place under the
