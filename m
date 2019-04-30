Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 06342EF15
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:11:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730030AbfD3DKq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:10:46 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:53603 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729931AbfD3DKq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:10:46 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id BF1FE9A40;
        Mon, 29 Apr 2019 23:10:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:10:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=BJo+tsGYz1UiYdilzcTz+d7vEhUJ+jp/yMih2keKOkE=; b=4Na3wF3I
        x24V1uXx6GIXq0r+bQnjj+1SJ6YVMI1Ebj8HL9tPpVhag1zyRctWPePGEkZkDb4v
        T7JhLPqcmvcj9VujzI05sNPVwfXS0vPhfBS/txTRihZVWGrdwTWDzsjO7tbNbct2
        3ZiYs4yFlIkuKixNaDXTwotfl3aRZjWGc2rDrpHWUu+BnJojeC1RYL+JixYcJUM6
        C+JXs/TIyu6EyE4NieFwVUhgVzxXU7lRlrUVSF4AVEzYyMrFUl3DRRs5ubXilPyO
        Y35PGXi6rcuDrW/6tgzRfGh49RJelBQUWyRdHTfdrpcjbbL9uIz8RkLCWtYrNkDZ
        1TNDxczMcD8R/w==
X-ME-Sender: <xms:tLzHXDuYSrSroGo2gkFEkHVJlCaf-S_10nE0apXTQGzY2pvjrf6d4Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeilecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhn
    ucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucfkph
    epuddvuddrgeegrddvfedtrddukeeknecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohgs
    ihhnsehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpeef
X-ME-Proxy: <xmx:tLzHXNZQsjKKFsknSj4OyF0LAKM_GoPR3BSTJCijC8xBHCQ7HNljNA>
    <xmx:tLzHXIuabIEJy2sJOUJRbV_4ZhsABLIKgLzu7E4FJSXZu_ytLzhA-Q>
    <xmx:tLzHXPFhz4uEu-ZmPczNucHSGXPIFbgY0nBDkQXyUpzUiLTbhgEYgQ>
    <xmx:tLzHXCK8X0308eotLCAl5QQHXJMPI-RGNIDfTHVSva0RHVmQJBb1cw>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id EC48F103C8;
        Mon, 29 Apr 2019 23:10:36 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Matthew Wilcox <willy@infradead.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>,
        "Theodore Ts'o" <tytso@mit.edu>, Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v4 15/15] dcache: Add CONFIG_DCACHE_SMO
Date:   Tue, 30 Apr 2019 13:07:46 +1000
Message-Id: <20190430030746.26102-16-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190430030746.26102-1-tobin@kernel.org>
References: <20190430030746.26102-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

In an attempt to make the SMO patchset as non-invasive as possible add a
config option CONFIG_DCACHE_SMO (under "Memory Management options") for
enabling SMO for the DCACHE.  Whithout this option dcache constructor is
used but no other code is built in, with this option enabled slab
mobility is enabled and the isolate/migrate functions are built in.

Add CONFIG_DCACHE_SMO to guard the partial shrinking of the dcache via
Slab Movable Objects infrastructure.

Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 fs/dcache.c | 4 ++++
 mm/Kconfig  | 7 +++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/dcache.c b/fs/dcache.c
index 3f9daba1cc78..9edce104613b 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -3068,6 +3068,7 @@ void d_tmpfile(struct dentry *dentry, struct inode *inode)
 }
 EXPORT_SYMBOL(d_tmpfile);
 
+#ifdef CONFIG_DCACHE_SMO
 /*
  * d_isolate() - Dentry isolation callback function.
  * @s: The dentry cache.
@@ -3140,6 +3141,7 @@ static void d_partial_shrink(struct kmem_cache *s, void **_unused, int __unused,
 
 	kfree(private);
 }
+#endif	/* CONFIG_DCACHE_SMO */
 
 static __initdata unsigned long dhash_entries;
 static int __init set_dhash_entries(char *str)
@@ -3186,7 +3188,9 @@ static void __init dcache_init(void)
 					   sizeof_field(struct dentry, d_iname),
 					   dcache_ctor);
 
+#ifdef CONFIG_DCACHE_SMO
 	kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);
+#endif
 
 	/* Hash may have been set up in dcache_init_early */
 	if (!hashdist)
diff --git a/mm/Kconfig b/mm/Kconfig
index 47040d939f3b..92fc27ad3472 100644
--- a/mm/Kconfig
+++ b/mm/Kconfig
@@ -265,6 +265,13 @@ config SMO_NODE
        help
          On NUMA systems enable moving objects to and from a specified node.
 
+config DCACHE_SMO
+       bool "Enable Slab Movable Objects for the dcache"
+       depends on SLUB
+       help
+         Under memory pressure we can try to free dentry slab cache objects from
+         the partial slab list if this is enabled.
+
 config PHYS_ADDR_T_64BIT
 	def_bool 64BIT
 
-- 
2.21.0

