Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 141963276E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Jun 2019 06:27:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbfFCE1h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Jun 2019 00:27:37 -0400
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:33637 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726352AbfFCE1h (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Jun 2019 00:27:37 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 8BCE61320;
        Mon,  3 Jun 2019 00:27:36 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Mon, 03 Jun 2019 00:27:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:date:from
        :message-id:mime-version:subject:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; bh=vJh10jP5FQHItH6L9
        0Py3lEvHZ/YcRQDomptsbrqx1k=; b=cGJAgqDK4X3UwkO5q/nqsgdDIUL+3g+T7
        yOP7wvHPzMshGTs4EBqY/HLso9/s+2AsL4ErSs2lXX/HSyNWJg39aBKJ8gDsbCnZ
        JvZANmHV90OEkIjEFzGO8otjzE2HGE8B91WeUh4SW9YUuRkdfW5qF4XQcBEttPJ1
        tHTD6Li6d3KZY3ehdFSuwurjCy3rMIU725vlLbeede5CUhbSTy2RycM4MzpXRZx3
        HiSZ6GHSX6GzCixFMoVKdbXcrGx1jTHEf+Kzkc4gsOCWHhWc4he1j6lonBFXEfCB
        pnq5rdTIDtS6cwpZ0YPhUZV/ZJty0mdDzEjAm+hvsGtHU+eVs6Jmw==
X-ME-Sender: <xms:taH0XJm-3njHVnq-PvAmoiysRTAjt8ODP8RYwNqgVzZTA6eRCwLnNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddrudefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvufffkffoggfgsedtkeertdertddtnecuhfhrohhmpedfvfhosghinhcu
    vedrucfjrghrughinhhgfdcuoehtohgsihhnsehkvghrnhgvlhdrohhrgheqnecukfhppe
    duvdegrddugeelrdduudefrdefieenucfrrghrrghmpehmrghilhhfrhhomhepthhosghi
    nheskhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
X-ME-Proxy: <xmx:taH0XIGlni124F3v1b5nTtOWPr8guPIJ41zHOlM2u01qUjsE812YUQ>
    <xmx:taH0XJHh9E5LC8S6czHkgzSc-T7PdnclIIL4PKuisAG-Yxb00aK80g>
    <xmx:taH0XFPM-bp9AdMfoRIIXbTcoJjYOB9u8vSdsWu80e3WIYJYv4xwmg>
    <xmx:uKH0XPpEMWMUGal3kXzZB_SQjNF623F2joUdwbczXIb9rWxTu-q8HA>
Received: from eros.localdomain (124-149-113-36.dyn.iinet.net.au [124.149.113.36])
        by mail.messagingengine.com (Postfix) with ESMTPA id F3FE88005B;
        Mon,  3 Jun 2019 00:27:26 -0400 (EDT)
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
        Miklos Szeredi <mszeredi@redhat.com>,
        Andreas Dilger <adilger@dilger.ca>,
        Waiman Long <longman@redhat.com>,
        Tycho Andersen <tycho@tycho.ws>, Theodore Ts'o <tytso@mit.edu>,
        Andi Kleen <ak@linux.intel.com>,
        David Chinner <david@fromorbit.com>,
        Nick Piggin <npiggin@gmail.com>,
        Rik van Riel <riel@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/15] Slab Movable Objects (SMO)
Date:   Mon,  3 Jun 2019 14:26:22 +1000
Message-Id: <20190603042637.2018-1-tobin@kernel.org>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

TL;DR - Add object migration (SMO) to the SLUB allocator and implement
object migration for the XArray and the dcache. 

Thanks for you patience with all the RFC's of this patch set.  Here it
is, ready for prime time.

Internal fragmentation can occur within pages used by the slub
allocator.  Under some workloads large numbers of pages can be used by
partial slab pages.  This under-utilisation is bad simply because it
wastes memory but also because if the system is under memory pressure
higher order allocations may become difficult to satisfy.  If we can
defrag slab caches we can alleviate these problems.

In order to be able to defrag slab chaches we need to be able to migrate
objects to a new slab.  Slab object migration is the core functionality
added by this patch series.

Internal slab fragmentation is a long known problem.  This series does
not claim to completely _fix_ the issue.  Instead we are adding core
code to the SLUB allocator to enable users of the allocator to help
mitigate internal fragmentation.  Object migration is on a per cache
basis, with each cache being able to take advantage of object migration
to varying degrees depending on the nature of the objects stored in the
cache.

Series includes test modules and test code that can be used to verify the
claimed behaviour.

Patch #1 - Adds the callbacks used to enable SMO for a particular cache.

Patch #2 - Updates the slabinfo tool to show operations related to SMO.

Patch #3 - Sorts the cache list putting migratable slabs at front.

Patch #4 - Adds the SMO infrastructure.  This is the core patch of the
           series.

Patch #5, #6 - Further update slabinfo tool for information just added.

Patch #7 - Add a module for testing SMO.

Patch #8 - Add unit test suite in Python utilising test module from #7.

Patch #9 - Add a new slab cache for the XArray (separate from radix tree).

Patch #10 - Implement SMO for the XArray.

Patch #11 - Add module for testing XArray SMO implementation.

Patch #12 - Add a dentry constructor.

Patch #13 - Use SMO to attempt to reduce fragmentation of the dcache by
	    selectively freeing dentry objects.

Patch #14 - Add functionality to move slab objects to a specific NUMA node.

Patch #15 - Add functionality to balance slab objects across all NUMA nodes.

The last RFC (RFCv5 and discussion on it) included code to conditionally
exclude SMO for the dcache.  This has been removed.  IMO it is now not
needed.  Al sufficiently bollock'ed me during development that I believe
the dentry code is good and does not negatively effect the dcache.  If
someone would like to prove me wrong simply remove the call to

    kmem_cache_setup_mobility(dentry_cache, d_isolate, d_partial_shrink);

Testing:

The series has been tested to verify that objects are moved using bare
metal (core i5) and also Qemu.  This has not been tested on big metal or
on NUMA hardware.

I have no measurements on performance gains achievable with this set, I
have just verified that the migration works and does not appear to break
anything.

Patch #14 and #15 depend on

	CONFIG_SLBU_DEBUG_ON or boot with 'slub_debug'

Thanks for taking the time to look at this.

	Tobin


Tobin C. Harding (15):
  slub: Add isolate() and migrate() methods
  tools/vm/slabinfo: Add support for -C and -M options
  slub: Sort slab cache list
  slub: Slab defrag core
  tools/vm/slabinfo: Add remote node defrag ratio output
  tools/vm/slabinfo: Add defrag_used_ratio output
  tools/testing/slab: Add object migration test module
  tools/testing/slab: Add object migration test suite
  lib: Separate radix_tree_node and xa_node slab cache
  xarray: Implement migration function for xa_node objects
  tools/testing/slab: Add XArray movable objects tests
  dcache: Provide a dentry constructor
  dcache: Implement partial shrink via Slab Movable Objects
  slub: Enable moving objects to/from specific nodes
  slub: Enable balancing slabs across nodes

 Documentation/ABI/testing/sysfs-kernel-slab |  14 +
 fs/dcache.c                                 | 105 ++-
 include/linux/slab.h                        |  71 ++
 include/linux/slub_def.h                    |  10 +
 include/linux/xarray.h                      |   3 +
 init/main.c                                 |   2 +
 lib/radix-tree.c                            |   2 +-
 lib/xarray.c                                | 109 ++-
 mm/Kconfig                                  |   7 +
 mm/slab_common.c                            |   2 +-
 mm/slub.c                                   | 827 ++++++++++++++++++--
 tools/testing/slab/Makefile                 |  10 +
 tools/testing/slab/slub_defrag.c            | 567 ++++++++++++++
 tools/testing/slab/slub_defrag.py           | 451 +++++++++++
 tools/testing/slab/slub_defrag_xarray.c     | 211 +++++
 tools/vm/slabinfo.c                         |  51 +-
 16 files changed, 2339 insertions(+), 103 deletions(-)
 create mode 100644 tools/testing/slab/Makefile
 create mode 100644 tools/testing/slab/slub_defrag.c
 create mode 100755 tools/testing/slab/slub_defrag.py
 create mode 100644 tools/testing/slab/slub_defrag_xarray.c

-- 
2.21.0

