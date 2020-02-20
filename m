Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F3C8D16543B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Feb 2020 02:28:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727211AbgBTB2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 20:28:23 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:46466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726784AbgBTB2W (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 20:28:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:MIME-Version:Date:Message-ID:Subject:From:Cc:To:Sender:Reply-To:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=73nmcgqUsK8bsEX7ojIAyp/zeGNOd9HJyyQcCEeUgtw=; b=ZdqT13ijLg42JzLnXUnN5Hqzb4
        FFIPJJKJJC2Qy5f/phgzwwJ++uiOvstyQ/j4iwGNQ179dqAJ20uQYjrMB7Lcxhz71Qz1eaVKguOSX
        YQxyEcFwG+0iC4uex5Ile1/Wdayhc0HHaNo6A+trj7EoaVUYuk1oTS1UY6SC8BxLGu7D4TmuZbb1c
        AMOiY+a1avqAyNRh2sYsqTbxlygz07hOu43OtjzNv4ScTP2G1zKc4dYY0aKeVvDjpCyks7jiU2t/R
        19dVk4y1lSDUDN2jR6Juzm8wvq7ICFKALYAJsQrarGB4pkRvjhYNfLR1tAwaU0/dqLc+rCyjDHJ06
        xJZDyN9w==;
Received: from [2603:3004:32:9a00::4074]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1j4ada-0003Pm-4l; Thu, 20 Feb 2020 01:28:22 +0000
To:     Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <damien.lemoal@wdc.com>
Cc:     Naohiro Aota <naohiro.aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
From:   Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] zonefs: fix documentation typos etc.
Message-ID: <14e7bd16-c1ec-c863-a15c-fd4f70540d2a@infradead.org>
Date:   Wed, 19 Feb 2020 17:28:21 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix typos, spellos, etc. in zonefs.txt.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Damien Le Moal <Damien.LeMoal@wdc.com>
---
 Documentation/filesystems/zonefs.txt |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

--- linux-next-20200219.orig/Documentation/filesystems/zonefs.txt
+++ linux-next-20200219/Documentation/filesystems/zonefs.txt
@@ -134,7 +134,7 @@ Sequential zone files can only be writte
 end, that is, write operations can only be append writes. Zonefs makes no
 attempt at accepting random writes and will fail any write request that has a
 start offset not corresponding to the end of the file, or to the end of the last
-write issued and still in-flight (for asynchrnous I/O operations).
+write issued and still in-flight (for asynchronous I/O operations).
 
 Since dirty page writeback by the page cache does not guarantee a sequential
 write pattern, zonefs prevents buffered writes and writeable shared mappings
@@ -142,7 +142,7 @@ on sequential files. Only direct I/O wri
 zonefs relies on the sequential delivery of write I/O requests to the device
 implemented by the block layer elevator. An elevator implementing the sequential
 write feature for zoned block device (ELEVATOR_F_ZBD_SEQ_WRITE elevator feature)
-must be used. This type of elevator (e.g. mq-deadline) is the set by default
+must be used. This type of elevator (e.g. mq-deadline) is set by default
 for zoned block devices on device initialization.
 
 There are no restrictions on the type of I/O used for read operations in
@@ -196,7 +196,7 @@ additional conditions that result in I/O
   may still happen in the case of a partial failure of a very large direct I/O
   operation split into multiple BIOs/requests or asynchronous I/O operations.
   If one of the write request within the set of sequential write requests
-  issued to the device fails, all write requests after queued after it will
+  issued to the device fails, all write requests queued after it will
   become unaligned and fail.
 
 * Delayed write errors: similarly to regular block devices, if the device side
@@ -207,7 +207,7 @@ additional conditions that result in I/O
   causing all data to be dropped after the sector that caused the error.
 
 All I/O errors detected by zonefs are notified to the user with an error code
-return for the system call that trigered or detected the error. The recovery
+return for the system call that triggered or detected the error. The recovery
 actions taken by zonefs in response to I/O errors depend on the I/O type (read
 vs write) and on the reason for the error (bad sector, unaligned writes or zone
 condition change).
@@ -222,7 +222,7 @@ condition change).
 * A zone condition change to read-only or offline also always triggers zonefs
   I/O error recovery.
 
-Zonefs minimal I/O error recovery may change a file size and a file access
+Zonefs minimal I/O error recovery may change a file size and file access
 permissions.
 
 * File size changes:
@@ -237,7 +237,7 @@ permissions.
   A file size may also be reduced to reflect a delayed write error detected on
   fsync(): in this case, the amount of data effectively written in the zone may
   be less than originally indicated by the file inode size. After such I/O
-  error, zonefs always fixes a file inode size to reflect the amount of data
+  error, zonefs always fixes the file inode size to reflect the amount of data
   persistently stored in the file zone.
 
 * Access permission changes:
@@ -281,11 +281,11 @@ Further notes:
   permissions to read-only applies to all files. The file system is remounted
   read-only.
 * Access permission and file size changes due to the device transitioning zones
-  to the offline condition are permanent. Remounting or reformating the device
+  to the offline condition are permanent. Remounting or reformatting the device
   with mkfs.zonefs (mkzonefs) will not change back offline zone files to a good
   state.
 * File access permission changes to read-only due to the device transitioning
-  zones to the read-only condition are permanent. Remounting or reformating
+  zones to the read-only condition are permanent. Remounting or reformatting
   the device will not re-enable file write access.
 * File access permission changes implied by the remount-ro, zone-ro and
   zone-offline mount options are temporary for zones in a good condition.
@@ -301,13 +301,13 @@ Mount options
 
 zonefs define the "errors=<behavior>" mount option to allow the user to specify
 zonefs behavior in response to I/O errors, inode size inconsistencies or zone
-condition chages. The defined behaviors are as follow:
+condition changes. The defined behaviors are as follow:
 * remount-ro (default)
 * zone-ro
 * zone-offline
 * repair
 
-The I/O error actions defined for each behavior is detailed in the previous
+The I/O error actions defined for each behavior are detailed in the previous
 section.
 
 Zonefs User Space Tools

