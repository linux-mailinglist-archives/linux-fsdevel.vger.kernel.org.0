Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B19F416171F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729736AbgBQQMi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:38 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47306 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729717AbgBQQMf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DgeMFbHb+MCdIgt0dzyI2D6t1+JBcmRlYvY42H1ulsg=; b=oGWbRTY4yzQSOZAXJ1WwTMej+2
        IvWeL4GJ1KS+WyQN8rrGiiDy4mgIpd1Lj20PjAO3vs0n+nlOD6pb3MYzzNQSbiTUKzrn3Z75zbLFv
        /nPfhQ1hnJ1cWFCM6tombviJ9OaLIAQoJdMaoihKgSmCdqhJ4Nd4B/FJ/Z17OuKBdcY3Cbz292V58
        tILIx3cFhA19zHOOD4mU4dSuMdLcxdP8EhvIuzfSzRvHQzI3WsK6Jo2el41JzdlXXRLwabgGzpBVb
        USeXifSfWX4G7ev47L4yoeat962Xb3Jca7XqjhENj7rDXbHJgh4B81Tlbtj682mUuR2BAWXJyyvsT
        abwzVkJw==;
Received: from ip-109-41-129-189.web.vodafone.de ([109.41.129.189] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0d-0006uU-Kv; Mon, 17 Feb 2020 16:12:35 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0b-000fc9-C9; Mon, 17 Feb 2020 17:12:33 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 40/44] docs: filesystems: convert tmpfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:12:26 +0100
Message-Id: <30397a47a78ca59760fbc0fc5f50c5f1002d487a.1581955849.git.mchehab+huawei@kernel.org>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <cover.1581955849.git.mchehab+huawei@kernel.org>
References: <cover.1581955849.git.mchehab+huawei@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

- Add a SPDX header;
- Add a document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add table markups;
- Use :field: markup;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 Documentation/filesystems/index.rst           |  1 +
 .../filesystems/{tmpfs.txt => tmpfs.rst}      | 44 ++++++++++++-------
 2 files changed, 30 insertions(+), 15 deletions(-)
 rename Documentation/filesystems/{tmpfs.txt => tmpfs.rst} (86%)

diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index d583b8b35196..27d37e7712da 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -89,5 +89,6 @@ Documentation for filesystem implementations.
    squashfs
    sysfs
    sysv-fs
+   tmpfs
    virtiofs
    vfat
diff --git a/Documentation/filesystems/tmpfs.txt b/Documentation/filesystems/tmpfs.rst
similarity index 86%
rename from Documentation/filesystems/tmpfs.txt
rename to Documentation/filesystems/tmpfs.rst
index 5ecbc03e6b2f..4e95929301a5 100644
--- a/Documentation/filesystems/tmpfs.txt
+++ b/Documentation/filesystems/tmpfs.rst
@@ -1,3 +1,9 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+=====
+Tmpfs
+=====
+
 Tmpfs is a file system which keeps all files in virtual memory.
 
 
@@ -14,7 +20,7 @@ If you compare it to ramfs (which was the template to create tmpfs)
 you gain swapping and limit checking. Another similar thing is the RAM
 disk (/dev/ram*), which simulates a fixed size hard disk in physical
 RAM, where you have to create an ordinary filesystem on top. Ramdisks
-cannot swap and you do not have the possibility to resize them. 
+cannot swap and you do not have the possibility to resize them.
 
 Since tmpfs lives completely in the page cache and on swap, all tmpfs
 pages will be shown as "Shmem" in /proc/meminfo and "Shared" in
@@ -26,7 +32,7 @@ tmpfs has the following uses:
 
 1) There is always a kernel internal mount which you will not see at
    all. This is used for shared anonymous mappings and SYSV shared
-   memory. 
+   memory.
 
    This mount does not depend on CONFIG_TMPFS. If CONFIG_TMPFS is not
    set, the user visible part of tmpfs is not build. But the internal
@@ -34,7 +40,7 @@ tmpfs has the following uses:
 
 2) glibc 2.2 and above expects tmpfs to be mounted at /dev/shm for
    POSIX shared memory (shm_open, shm_unlink). Adding the following
-   line to /etc/fstab should take care of this:
+   line to /etc/fstab should take care of this::
 
 	tmpfs	/dev/shm	tmpfs	defaults	0 0
 
@@ -56,15 +62,17 @@ tmpfs has the following uses:
 
 tmpfs has three mount options for sizing:
 
-size:      The limit of allocated bytes for this tmpfs instance. The 
+=========  ============================================================
+size       The limit of allocated bytes for this tmpfs instance. The
            default is half of your physical RAM without swap. If you
            oversize your tmpfs instances the machine will deadlock
            since the OOM handler will not be able to free that memory.
-nr_blocks: The same as size, but in blocks of PAGE_SIZE.
-nr_inodes: The maximum number of inodes for this instance. The default
+nr_blocks  The same as size, but in blocks of PAGE_SIZE.
+nr_inodes  The maximum number of inodes for this instance. The default
            is half of the number of your physical RAM pages, or (on a
            machine with highmem) the number of lowmem RAM pages,
            whichever is the lower.
+=========  ============================================================
 
 These parameters accept a suffix k, m or g for kilo, mega and giga and
 can be changed on remount.  The size parameter also accepts a suffix %
@@ -82,6 +90,7 @@ tmpfs has a mount option to set the NUMA memory allocation policy for
 all files in that instance (if CONFIG_NUMA is enabled) - which can be
 adjusted on the fly via 'mount -o remount ...'
 
+======================== ==============================================
 mpol=default             use the process allocation policy
                          (see set_mempolicy(2))
 mpol=prefer:Node         prefers to allocate memory from the given Node
@@ -89,6 +98,7 @@ mpol=bind:NodeList       allocates memory only from nodes in NodeList
 mpol=interleave          prefers to allocate from each node in turn
 mpol=interleave:NodeList allocates from each node of NodeList in turn
 mpol=local		 prefers to allocate memory from the local node
+======================== ==============================================
 
 NodeList format is a comma-separated list of decimal numbers and ranges,
 a range being two hyphen-separated decimal numbers, the smallest and
@@ -98,9 +108,9 @@ A memory policy with a valid NodeList will be saved, as specified, for
 use at file creation time.  When a task allocates a file in the file
 system, the mount option memory policy will be applied with a NodeList,
 if any, modified by the calling task's cpuset constraints
-[See Documentation/admin-guide/cgroup-v1/cpusets.rst] and any optional flags, listed
-below.  If the resulting NodeLists is the empty set, the effective memory
-policy for the file will revert to "default" policy.
+[See Documentation/admin-guide/cgroup-v1/cpusets.rst] and any optional flags,
+listed below.  If the resulting NodeLists is the empty set, the effective
+memory policy for the file will revert to "default" policy.
 
 NUMA memory allocation policies have optional flags that can be used in
 conjunction with their modes.  These optional flags can be specified
@@ -109,6 +119,8 @@ See Documentation/admin-guide/mm/numa_memory_policy.rst for a list of
 all available memory allocation policy mode flags and their effect on
 memory policy.
 
+::
+
 	=static		is equivalent to	MPOL_F_STATIC_NODES
 	=relative	is equivalent to	MPOL_F_RELATIVE_NODES
 
@@ -128,9 +140,11 @@ on MountPoint, by 'mount -o remount,mpol=Policy:NodeList MountPoint'.
 To specify the initial root directory you can use the following mount
 options:
 
-mode:	The permissions as an octal number
-uid:	The user id 
-gid:	The group id
+====	==================================
+mode	The permissions as an octal number
+uid	The user id
+gid	The group id
+====	==================================
 
 These options do not have any effect on remount. You can change these
 parameters with chmod(1), chown(1) and chgrp(1) on a mounted filesystem.
@@ -141,9 +155,9 @@ will give you tmpfs instance on /mytmpfs which can allocate 10GB
 RAM/SWAP in 10240 inodes and it is only accessible by root.
 
 
-Author:
+:Author:
    Christoph Rohland <cr@sap.com>, 1.12.01
-Updated:
+:Updated:
    Hugh Dickins, 4 June 2007
-Updated:
+:Updated:
    KOSAKI Motohiro, 16 Mar 2010
-- 
2.24.1

