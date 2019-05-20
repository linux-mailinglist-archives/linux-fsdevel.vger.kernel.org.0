Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C43A722B40
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 07:41:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727437AbfETFld (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 01:41:33 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:60019 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725601AbfETFlc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 01:41:32 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id D6EB41160B;
        Mon, 20 May 2019 01:41:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 20 May 2019 01:41:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :in-reply-to:message-id:mime-version:references:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; bh=pvmcntUKaLFWeIKV28cwZMSwwZ0f8GZCwK0RuRd6vxw=; b=Tp/kx4vO
        UsH3lifxwz1hf6IIZvoCuYCbS3N/bxeIEVJczgn7f7NSK3ljq+hzZo75SxFHhs61
        eLKytTBmVNQeJfPJx0AqskyqdiYk4kRZD/sDasZgyVCdPfTew11AAqBLFyvz3ZiL
        gEoATFHVziwmgiSWPSPgNIBzkGFdMSk/oKmmb9a9XNpVoRjO6Eg08rYHYIw93/h6
        avf2LrUg+U9Sj6kHhjdlMRyWFY3YosBdV2e46UtDbn3yVm3YtKtj2mHDUyv0SF41
        tWoioUGzJWBWyPx/TgE7scZXI6laUj3o5rFiu1lZOANRvRPYxV6XVkLIO1yKT8El
        xjvjA4jOCg5H/w==
X-ME-Sender: <xms:Cz7iXF2ceonTc1MTLpyFy7_yETIfJipMjVUHW4kZ1vTH_7KN0QZ3bw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtjedguddtudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufffkofgjfhgggfestdekredtredttdenucfhrhhomhepfdfvohgs
    ihhnucevrdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenuc
    fkphepuddvgedrudeiledrudehiedrvddtfeenucfrrghrrghmpehmrghilhhfrhhomhep
    thhosghinheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgepvd
X-ME-Proxy: <xmx:Cz7iXDK4xz1HSpbPhUmlrahE4BKa0oW2wB4YcmU158qk3pK_FnIS9Q>
    <xmx:Cz7iXNl6aPGjcaqlu6VlxiMcVecndGcYo7iUQVMhKzCuaUA_5MgxEw>
    <xmx:Cz7iXJP49d9iPxz-K9gMLROM_-gWZrSWN3_CmXA9cydkbiwsdRKCVw>
    <xmx:Cz7iXMuOis1jY3FSM9AHvZDNX2zz_izaaamv8wYPTOw-S8MfHr1Cjg>
Received: from eros.localdomain (124-169-156-203.dyn.iinet.net.au [124.169.156.203])
        by mail.messagingengine.com (Postfix) with ESMTPA id BA1B18005B;
        Mon, 20 May 2019 01:41:24 -0400 (EDT)
From:   "Tobin C. Harding" <tobin@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     "Tobin C. Harding" <tobin@kernel.org>,
        Roman Gushchin <guro@fb.com>,
        Alexander Viro <viro@ftp.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Pekka Enberg <penberg@cs.helsinki.fi>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christopher Lameter <cl@linux.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RFC PATCH v5 03/16] slub: Sort slab cache list
Date:   Mon, 20 May 2019 15:40:04 +1000
Message-Id: <20190520054017.32299-4-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190520054017.32299-1-tobin@kernel.org>
References: <20190520054017.32299-1-tobin@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

It is advantageous to have all defragmentable slabs together at the
beginning of the list of slabs so that there is no need to scan the
complete list. Put defragmentable caches first when adding a slab cache
and others last.

Co-developed-by: Christoph Lameter <cl@linux.com>
Signed-off-by: Tobin C. Harding <tobin@kernel.org>
---
 mm/slab_common.c | 2 +-
 mm/slub.c        | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/slab_common.c b/mm/slab_common.c
index 58251ba63e4a..db5e9a0b1535 100644
--- a/mm/slab_common.c
+++ b/mm/slab_common.c
@@ -393,7 +393,7 @@ static struct kmem_cache *create_cache(const char *name,
 		goto out_free_cache;
 
 	s->refcount = 1;
-	list_add(&s->list, &slab_caches);
+	list_add_tail(&s->list, &slab_caches);
 	memcg_link_cache(s);
 out:
 	if (err)
diff --git a/mm/slub.c b/mm/slub.c
index 1c380a2bc78a..66d474397c0f 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -4333,6 +4333,8 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 		return;
 	}
 
+	mutex_lock(&slab_mutex);
+
 	s->isolate = isolate;
 	s->migrate = migrate;
 
@@ -4341,6 +4343,10 @@ void kmem_cache_setup_mobility(struct kmem_cache *s,
 	 * to disable fast cmpxchg based processing.
 	 */
 	s->flags &= ~__CMPXCHG_DOUBLE;
+
+	list_move(&s->list, &slab_caches);	/* Move to top */
+
+	mutex_unlock(&slab_mutex);
 }
 EXPORT_SYMBOL(kmem_cache_setup_mobility);
 
-- 
2.21.0

