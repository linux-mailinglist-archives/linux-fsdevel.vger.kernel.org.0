Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6AFEEF5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Apr 2019 05:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729987AbfD3DIm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Apr 2019 23:08:42 -0400
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:54251 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729883AbfD3DIm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Apr 2019 23:08:42 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id C90185286;
        Mon, 29 Apr 2019 23:08:40 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Mon, 29 Apr 2019 23:08:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=7ZjSg1VNx7gjXl0+m
        rA9pDXnHVsQsem51MPfG6t0rRU=; b=t64AZFUCeiB3BcAGjwP5+9A45B/1VVLSp
        j7Cy8t4Up7fen9CTDvtRGuhxrneh3AtiYuk5c+1H1OVWZU4RDJqeADhx/SB3X5lu
        s36i+EMEYqYk1L6HVlnyZO+YRs2dJBfuSjE6jOadoCJc/4ELtUegS1SjXMfvoVrY
        cMOAS8hmyuxdvQScuW192hULgF4sQHey94cuV4FhrVno+/kX7OTR95m2KPSDi9hz
        +Dv7b40hOgrOE0TTgN5BDLvvL8lm83DRNO1d7BREf1vjK+qFidVEyxUhoVWelcFQ
        KLI7Uq2w4VlmoSVuM9R+ipexxy3efhDiAY8bjpsAVo1zkaydgnuyQ==
X-ME-Sender: <xms:NrzHXF7BIDeD-jSMI20ye9UHeYpHcdfAmAdQ0vyncTZXeb3iH0LK_g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrieefgdeikecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvffufffkofgggfestdekredtredttdenucfhrhhomhepfdfvohgsihhnucev
    rdcujfgrrhguihhnghdfuceothhosghinheskhgvrhhnvghlrdhorhhgqeenucffohhmrg
    hinhepkhgvrhhnvghlrdhorhhgnecukfhppeduvddurdeggedrvdeftddrudekkeenucfr
    rghrrghmpehmrghilhhfrhhomhepthhosghinheskhgvrhhnvghlrdhorhhgnecuvehluh
    hsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:NrzHXNzSJxudlMFy9eD1bPa1fzTRy9os8DmPfMmCvi-EQYN5pK0uYg>
    <xmx:NrzHXEQwZeWw4m5ZcLREUjqR5JS9H8kOL3uj_44_NwpneGt7dHvkgw>
    <xmx:NrzHXMWyDHp327PV71QdztchNwJ00TlGRFWekXYWaSyUOYROiaRYXA>
    <xmx:OLzHXGJ06uxdmfNFU25_gEWeN0UxiELGOrl4z8DGDmKxvIrKbBDPDg>
Received: from eros.localdomain (ppp121-44-230-188.bras2.syd2.internode.on.net [121.44.230.188])
        by mail.messagingengine.com (Postfix) with ESMTPA id D315D103CA;
        Mon, 29 Apr 2019 23:08:30 -0400 (EDT)
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
Subject: [RFC PATCH v4 00/15] Slab Movable Objects (SMO)
Date:   Tue, 30 Apr 2019 13:07:31 +1000
Message-Id: <20190430030746.26102-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Another iteration of the SMO patch set, updates to this version are
restricted to the dcache patch #14.

Applies on top of Linus' tree (tag: v5.1-rc6).

This is a patch set implementing movable objects within the SLUB
allocator.  This is work based on Christopher Lameter's patch set:

 https://lore.kernel.org/patchwork/project/lkml/list/?series=377335

The original code logic is from that set and implemented by Christopher.
Clean up, refactoring, documentation, and additional features by myself.
Responsibility for any bugs remaining falls solely with myself.

Changes to this version:

Re-write the dcache Slab Movable Objects isolate/migrate functions.
Based on review/suggestions by Alexander on the last version.

In this version the isolate function loops over the object vector and
builds a shrink list for all objects that have refcount==0 AND are NOT
on anyone else's shrink list.  A pointer to this list is returned from
the isolate function and passed to the migrate function (by the SMO
infrastructure).  The dentry migration function d_partial_shrink()
simply calls shrink_dentry_list() on the received shrink list pointer
and frees the memory associated with the list_head.

Hopefully if this is all ok I can move on to violating the inode
slab cache :)

FWIW testing on a VM in Qemu brings this mild benefit to the dentry slab
cache with no _apparent_ negatives.

CONFIG_SLUB_DEBUG=y
CONFIG_SLUB=y
CONFIG_SLUB_CPU_PARTIAL=y
CONFIG_SLUB_DEBUG_ON=y
CONFIG_SLUB_STATS=y
CONFIG_SMO_NODE=y
CONFIG_DCACHE_SMO=y

[root@vm ~]# slabinfo  dentry -r | head -n 13

Slabcache: dentry           Aliases:  0 Order :  1 Objects: 38585
** Reclaim accounting active
** Defragmentation at 30%

Sizes (bytes)     Slabs              Debug                Memory
------------------------------------------------------------------------
Object :     192  Total  :    2582   Sanity Checks : On   Total: 21151744
SlabObj:     528  Full   :    2547   Redzoning     : On   Used : 7408320
SlabSiz:    8192  Partial:      35   Poisoning     : On   Loss : 13743424
Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig: 12964560
Align  :       8  Objects:      15   Tracing       : Off  Lpadd:  702304

[root@vm ~]# slabinfo  dentry --shrink
[root@vm ~]# slabinfo  dentry -r | head -n 13

Slabcache: dentry           Aliases:  0 Order :  1 Objects: 38426
** Reclaim accounting active
** Defragmentation at 30%

Sizes (bytes)     Slabs              Debug                Memory
------------------------------------------------------------------------
Object :     192  Total  :    2578   Sanity Checks : On   Total: 21118976
SlabObj:     528  Full   :    2547   Redzoning     : On   Used : 7377792
SlabSiz:    8192  Partial:      31   Poisoning     : On   Loss : 13741184
Loss   :     336  CpuSlab:       0   Tracking      : On   Lalig: 12911136
Align  :       8  Objects:      15   Tracing       : Off  Lpadd:  701216


Please note, this dentry shrink implementation is 'best effort', results
vary.  This is as is expected.  We are trying to unobtrusively shrink
the dentry cache.

thanks,
Tobin.


Tobin C. Harding (15):
  slub: Add isolate() and migrate() methods
  tools/vm/slabinfo: Add support for -C and -M options
  slub: Sort slab cache list
  slub: Slab defrag core
  tools/vm/slabinfo: Add remote node defrag ratio output
  tools/vm/slabinfo: Add defrag_used_ratio output
  tools/testing/slab: Add object migration test module
  tools/testing/slab: Add object migration test suite
  xarray: Implement migration function for objects
  tools/testing/slab: Add XArray movable objects tests
  slub: Enable moving objects to/from specific nodes
  slub: Enable balancing slabs across nodes
  dcache: Provide a dentry constructor
  dcache: Implement partial shrink via Slab Movable Objects
  dcache: Add CONFIG_DCACHE_SMO

 Documentation/ABI/testing/sysfs-kernel-slab |  14 +
 fs/dcache.c                                 | 110 ++-
 include/linux/slab.h                        |  71 ++
 include/linux/slub_def.h                    |  10 +
 lib/radix-tree.c                            |  13 +
 lib/xarray.c                                |  49 ++
 mm/Kconfig                                  |  14 +
 mm/slab_common.c                            |   2 +-
 mm/slub.c                                   | 819 ++++++++++++++++++--
 tools/testing/slab/Makefile                 |  10 +
 tools/testing/slab/slub_defrag.c            | 567 ++++++++++++++
 tools/testing/slab/slub_defrag.py           | 451 +++++++++++
 tools/testing/slab/slub_defrag_xarray.c     | 211 +++++
 tools/vm/slabinfo.c                         |  51 +-
 14 files changed, 2299 insertions(+), 93 deletions(-)
 create mode 100644 tools/testing/slab/Makefile
 create mode 100644 tools/testing/slab/slub_defrag.c
 create mode 100755 tools/testing/slab/slub_defrag.py
 create mode 100644 tools/testing/slab/slub_defrag_xarray.c

-- 
2.21.0

