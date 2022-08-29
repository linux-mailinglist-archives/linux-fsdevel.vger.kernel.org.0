Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFE45A583C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Aug 2022 01:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229575AbiH2Xyh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Aug 2022 19:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiH2Xyg (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Aug 2022 19:54:36 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B24CE275;
        Mon, 29 Aug 2022 16:54:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=9jNTVvjMRAW6grFHfLBzo2F+51I1/cIt+X3djvXT2II=; b=T58qP97pKEyA1GKZgxVdQ9glHA
        MPSrOCjD6FQsyq1DA/MJj+EGg1/rMoM3bKlxfpiR4QsXgR1tTGxyh8g+y/brA4Ae0AYNkkrfGaL53
        E7bIR/mKnk+FMW1U6/1RVBZk1nORPnbrd9xs7eJkAXfO6kmTZbaCzQcA1FcAm5GMMzfg7wmA4cO8c
        oFSejiPfXIp4DDOF5SywFtc2LMlpzJZh08RV4SV+POPKIxRWSAlg9HRglc9QXZMQ5yKjuiBquWagV
        iyVRDuaE5VMr+pGTGlyVxmtvgALJUSmbc/WujflaVOdJNGDGF6Lsx1MgSASyuNEDoVAqQJJ08Lrwx
        5XjzLG0g==;
Received: from [2601:1c0:6280:3f0::a6b3] (helo=casper.infradead.org)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oSoaQ-003WLW-OL; Mon, 29 Aug 2022 23:54:35 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-doc@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@kernel.org>
Subject: [PATCH] Documentation: filesystems: correct possessive "its"
Date:   Mon, 29 Aug 2022 16:54:29 -0700
Message-Id: <20220829235429.17902-1-rdunlap@infradead.org>
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

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net
Cc: linux-xfs@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>
Cc: Seth Forshee <sforshee@kernel.org>
---
 Documentation/filesystems/f2fs.rst                       |    2 +-
 Documentation/filesystems/idmappings.rst                 |    2 +-
 Documentation/filesystems/qnx6.rst                       |    2 +-
 Documentation/filesystems/xfs-delayed-logging-design.rst |    6 +++---
 4 files changed, 6 insertions(+), 6 deletions(-)

--- a/Documentation/filesystems/f2fs.rst
+++ b/Documentation/filesystems/f2fs.rst
@@ -287,7 +287,7 @@ compress_algorithm=%s:%d Control compres
 			 lz4		3 - 16
 			 zstd		1 - 22
 compress_log_size=%u	 Support configuring compress cluster size, the size will
-			 be 4KB * (1 << %u), 16KB is minimum size, also it's
+			 be 4KB * (1 << %u), 16KB is minimum size, also its
 			 default size.
 compress_extension=%s	 Support adding specified extension, so that f2fs can enable
 			 compression on those corresponding files, e.g. if all files
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
 
 Just to make matters more slightly more complex, this checkpoint level context
 for the pin count means that the pinning of an item must take place under the
