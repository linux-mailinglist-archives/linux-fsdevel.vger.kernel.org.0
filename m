Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 08A26161722
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Feb 2020 17:12:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729751AbgBQQMn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Feb 2020 11:12:43 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:47880 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729733AbgBQQMn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Feb 2020 11:12:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Sender:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
        Reply-To:Content-Type:Content-ID:Content-Description;
        bh=5DlpRIloU7pI1YpL6w1ZXXbafs7gsZdrZscTv4RqZFQ=; b=dwYGjObNeijAYFiIsUEj3n9hlC
        ucZ2RllIy3E1UF/0HGAyluCTq8faku0QpvG2WAl/QfWiObw8F/UMVtDQfc01/YjfvfeIdsj99Tptn
        OcTAvq/jacn6m6M4ZH7ewiK/GU8Stjt9XBRP2JsNJgZmnaH8xkMPqQ6YNSF4xtqj7xHz8cjr9q+UR
        5nRqzE9SEncfWdVhpBIXSZjlpFdzv23zf456vefODM08EibgiERk6v5ttF9YYW+0vKp+JV+2yYgg4
        cefTTxes/Nl58WsBpvs/HN8vfC5EtR7PJ134lE3TF2Rt1/F/v/ggUHo3ZqfLyYSovq9cJARohmLW5
        1F/QMCcg==;
Received: from x2f7f83d.dyn.telefonica.de ([2.247.248.61] helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j3j0e-0006uS-OG; Mon, 17 Feb 2020 16:12:42 +0000
Received: from mchehab by bombadil.infradead.org with local (Exim 4.92.3)
        (envelope-from <mchehab@bombadil.infradead.org>)
        id 1j3j0Z-000fZS-Oe; Mon, 17 Feb 2020 17:12:31 +0100
From:   Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
To:     Linux Doc Mailing List <linux-doc@vger.kernel.org>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        linux-fsdevel@vger.kernel.org,
        "Tigran A. Aivazian" <aivazian.tigran@gmail.com>
Subject: [PATCH 07/44] docs: filesystems: convert bfs.txt to ReST
Date:   Mon, 17 Feb 2020 17:11:53 +0100
Message-Id: <93991bcc05e419368ee1e585c81057fb2c7c8d2b.1581955849.git.mchehab+huawei@kernel.org>
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
- Adjust document title;
- Some whitespace fixes and new line breaks;
- Mark literal blocks as such;
- Add it to filesystems/index.rst.

Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
---
 .../filesystems/{bfs.txt => bfs.rst}          | 37 ++++++++++---------
 Documentation/filesystems/index.rst           |  1 +
 2 files changed, 21 insertions(+), 17 deletions(-)
 rename Documentation/filesystems/{bfs.txt => bfs.rst} (71%)

diff --git a/Documentation/filesystems/bfs.txt b/Documentation/filesystems/bfs.rst
similarity index 71%
rename from Documentation/filesystems/bfs.txt
rename to Documentation/filesystems/bfs.rst
index 843ce91a2e40..ce14b9018807 100644
--- a/Documentation/filesystems/bfs.txt
+++ b/Documentation/filesystems/bfs.rst
@@ -1,4 +1,7 @@
-BFS FILESYSTEM FOR LINUX
+.. SPDX-License-Identifier: GPL-2.0
+
+========================
+BFS Filesystem for Linux
 ========================
 
 The BFS filesystem is used by SCO UnixWare OS for the /stand slice, which
@@ -9,22 +12,22 @@ In order to access /stand partition under Linux you obviously need to
 know the partition number and the kernel must support UnixWare disk slices
 (CONFIG_UNIXWARE_DISKLABEL config option). However BFS support does not
 depend on having UnixWare disklabel support because one can also mount
-BFS filesystem via loopback:
+BFS filesystem via loopback::
 
-# losetup /dev/loop0 stand.img
-# mount -t bfs /dev/loop0 /mnt/stand
+    # losetup /dev/loop0 stand.img
+    # mount -t bfs /dev/loop0 /mnt/stand
 
-where stand.img is a file containing the image of BFS filesystem. 
+where stand.img is a file containing the image of BFS filesystem.
 When you have finished using it and umounted you need to also deallocate
-/dev/loop0 device by:
+/dev/loop0 device by::
 
-# losetup -d /dev/loop0
+    # losetup -d /dev/loop0
 
-You can simplify mounting by just typing:
+You can simplify mounting by just typing::
 
-# mount -t bfs -o loop stand.img /mnt/stand
+    # mount -t bfs -o loop stand.img /mnt/stand
 
-this will allocate the first available loopback device (and load loop.o 
+this will allocate the first available loopback device (and load loop.o
 kernel module if necessary) automatically. If the loopback driver is not
 loaded automatically, make sure that you have compiled the module and
 that modprobe is functioning. Beware that umount will not deallocate
@@ -33,21 +36,21 @@ that modprobe is functioning. Beware that umount will not deallocate
 losetup(8). Read losetup(8) manpage for more info.
 
 To create the BFS image under UnixWare you need to find out first which
-slice contains it. The command prtvtoc(1M) is your friend:
+slice contains it. The command prtvtoc(1M) is your friend::
 
-# prtvtoc /dev/rdsk/c0b0t0d0s0
+    # prtvtoc /dev/rdsk/c0b0t0d0s0
 
 (assuming your root disk is on target=0, lun=0, bus=0, controller=0). Then you
 look for the slice with tag "STAND", which is usually slice 10. With this
-information you can use dd(1) to create the BFS image:
+information you can use dd(1) to create the BFS image::
 
-# umount /stand
-# dd if=/dev/rdsk/c0b0t0d0sa of=stand.img bs=512
+    # umount /stand
+    # dd if=/dev/rdsk/c0b0t0d0sa of=stand.img bs=512
 
 Just in case, you can verify that you have done the right thing by checking
-the magic number:
+the magic number::
 
-# od -Ad -tx4 stand.img | more
+    # od -Ad -tx4 stand.img | more
 
 The first 4 bytes should be 0x1badface.
 
diff --git a/Documentation/filesystems/index.rst b/Documentation/filesystems/index.rst
index 98de437f5500..f74e6b273d9f 100644
--- a/Documentation/filesystems/index.rst
+++ b/Documentation/filesystems/index.rst
@@ -53,6 +53,7 @@ Documentation for filesystem implementations.
    autofs
    autofs-mount-control
    befs
+   bfs
    fuse
    overlayfs
    virtiofs
-- 
2.24.1

