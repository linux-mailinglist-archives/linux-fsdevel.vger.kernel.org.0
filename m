Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3F6BF1E63F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 May 2019 02:31:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbfEOAaU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 May 2019 20:30:20 -0400
Received: from out5-smtp.messagingengine.com ([66.111.4.29]:46795 "EHLO
        out5-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726604AbfEOAaT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 May 2019 20:30:19 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id C388D2574D;
        Tue, 14 May 2019 20:30:18 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 14 May 2019 20:30:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=orANEqMzXIgVGZXxePffekYMyPICqeToBFW7oY8WfmU=; b=SleR9YEo
        JW5xCCmvg4Eb+fov3kT3Z6bWf11UrljdP0IbFFDZNQAdRIkMsXKuJgXRCbyZlAb3
        jZMKp4JDn4R+oxxvmGqpDRR33yUAmvkAAT28Vr0zqetc/zOhUdgoL+bSYmmo2W8b
        J5v7noZi8KEt9bTIWQw0QuMJPI4NyYYK5J/of/QAOO6/q8vZOV/RzqnyyK2xvTzQ
        hXv/QuvBpx/u65v7lSFqFRm9/Zr79uv6mVR8bcNeRKIScEkrRsR01NPx2MXDV27m
        HsQm60EJ1KrjrjB9XlYntp3a7NDZEelDxYBUFCG4thPO6l7buSjxjMzID1C3MeMD
        PC3cXv31EA1lXQ==
X-ME-Sender: <xms:ml3bXKGahcxcFpJcvz3j_LZad81zf73_8cVzYTl95UdRIRTpJXkMSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrleejgdefiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvvdefrddvuddunecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedv
X-ME-Proxy: <xmx:ml3bXAqyrhI4sZyc9B921D2Z4Ml7LfUfSGqDSQSx306ClY9y-ucBRw>
    <xmx:ml3bXAPCXBKJCo8F4F6NH3nJH6w0DcPw_77snogLNnsUwVB8UfRuHQ>
    <xmx:ml3bXAowHnoUJSlqbsK7OaffnHe9_-1kRQq-iSkATHNI6qVtnzNm5g>
    <xmx:ml3bXDYfcgVc6nwZRT2xc4S8QdYEQN5xwERQ1fOXVXOcrVpYrmaDeA>
Received: from eros.localdomain (ppp121-44-223-211.bras1.syd2.internode.on.net [121.44.223.211])
        by mail.messagingengine.com (Postfix) with ESMTPA id 617D9103CF;
        Tue, 14 May 2019 20:30:15 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Mauro Carvalho Chehab <mchehab@s-opensource.com>,
        Neil Brown <neilb@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 4/9] docs: filesystems: vfs: Use uniform spacing around headings
Date:   Wed, 15 May 2019 10:29:08 +1000
Message-Id: <20190515002913.12586-5-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190515002913.12586-1-tobin@kernel.org>
References: <20190515002913.12586-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Currently spacing before and after headings is non-uniform.  Use two
blank lines before a heading and one after the heading.

Use uniform spacing around headings.

Tested-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 Documentation/filesystems/vfs.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/filesystems/vfs.txt b/Documentation/filesystems/vfs.txt
index 14839bc84d38..ed12d28bda62 100644
--- a/Documentation/filesystems/vfs.txt
+++ b/Documentation/filesystems/vfs.txt
@@ -321,6 +321,7 @@ Whoever sets up the inode is responsible for filling in the "i_op"
 field.  This is a pointer to a "struct inode_operations" which describes
 the methods that can be performed on individual inodes.
 
+
 struct xattr_handlers
 ---------------------
 
@@ -507,6 +508,7 @@ otherwise noted.
   tmpfile: called in the end of O_TMPFILE open().  Optional, equivalent to
 	atomically creating, opening and unlinking a file in given directory.
 
+
 The Address Space Object
 ========================
 
@@ -580,8 +582,10 @@ and the constraints under which it is being done.  It is also used to
 return information back to the caller about the result of a writepage or
 writepages request.
 
+
 Handling errors during writeback
 --------------------------------
+
 Most applications that do buffered I/O will periodically call a file
 synchronization call (fsync, fdatasync, msync or sync_file_range) to
 ensure that data written has made it to the backing store.  When there
@@ -612,6 +616,7 @@ file->fsync operation, they should call file_check_and_advance_wb_err to
 ensure that the struct file's error cursor has advanced to the correct
 point in the stream of errors emitted by the backing device(s).
 
+
 struct address_space_operations
 -------------------------------
 
@@ -1203,9 +1208,11 @@ manipulate dentries:
 	and the dentry is returned.  The caller must use dput()
 	to free the dentry when it finishes using it.
 
+
 Mount Options
 =============
 
+
 Parsing options
 ---------------
 
@@ -1220,6 +1227,7 @@ The <linux/parser.h> header defines an API that helps parse these
 options.  There are plenty of examples on how to use it in existing
 filesystems.
 
+
 Showing options
 ---------------
 
@@ -1241,6 +1249,7 @@ The underlying reason for the above rules is to make sure, that a mount
 can be accurately replicated (e.g. umounting and mounting again) based
 on the information found in /proc/mounts.
 
+
 Resources
 =========
 
-- 
2.21.0

