Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB71F6B8AE9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Mar 2023 07:03:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229880AbjCNGDw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Mar 2023 02:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjCNGDv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Mar 2023 02:03:51 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A9DD22DCD;
        Mon, 13 Mar 2023 23:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=v68GIYES2MYrxUUcQdRYlXXOAg7VrI8cvYXhh6/PdTs=; b=zpRRknJt7q5k0sIiXbOjKTEIZh
        H+h0cz/AhWTuxKanvTvFsbCPJoBkZulmuL7XWkMCySzZOMQYiYmZWDrNWMFMIn1y+zV++1FuAsNSL
        GU025jUywsCXq7SuXMb9hx7Ellj5G3HHmxt5oC6VSxPWb4hMDlN90XrkfckwdEPkkjwNGojOF1RpE
        iCU2xnoawZG+CQSUPUHJ4ygj7iLSF13M4tZjLIrxJE0wnpgo9IJhBwE1mHq4k7EyY8HrQwdw/dg1z
        riI2lAYuCAWE2lBqgIrDXX+DxSDlXhHVyVl2rvWx9sWBWyUtXONxKtLKFS52x3cyC6Bh8mcpYBDl2
        znaLlOcQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pbxlD-00992D-T5; Tue, 14 Mar 2023 06:03:47 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: [PATCH] Documentation: fs/proc: corrections and update
Date:   Mon, 13 Mar 2023 23:03:47 -0700
Message-Id: <20230314060347.605-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Update URL for the latest online version of this document.
Correct "files" to "fields" in a few places.
Update /proc/scsi, /proc/stat, and /proc/fs/ext4 information.
Drop /usr/src/ from the location of the kernel source tree.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org
---
 Documentation/filesystems/proc.rst |   44 ++++++++++++++-------------
 1 file changed, 23 insertions(+), 21 deletions(-)

diff -- a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
--- a/Documentation/filesystems/proc.rst
+++ b/Documentation/filesystems/proc.rst
@@ -85,7 +85,7 @@ contact Bodo  Bauer  at  bb@ricochet.net
 document.
 
 The   latest   version    of   this   document   is    available   online   at
-http://tldp.org/LDP/Linux-Filesystem-Hierarchy/html/proc.html
+https://www.kernel.org/doc/html/latest/filesystems/proc.html
 
 If  the above  direction does  not works  for you,  you could  try the  kernel
 mailing  list  at  linux-kernel@vger.kernel.org  and/or try  to  reach  me  at
@@ -232,7 +232,7 @@ asynchronous manner and the value may no
 snapshot of a moment, you can see /proc/<pid>/smaps file and scan page table.
 It's slow but very precise.
 
-.. table:: Table 1-2: Contents of the status files (as of 4.19)
+.. table:: Table 1-2: Contents of the status fields (as of 4.19)
 
  ==========================  ===================================================
  Field                       Content
@@ -305,7 +305,7 @@ It's slow but very precise.
  ==========================  ===================================================
 
 
-.. table:: Table 1-3: Contents of the statm files (as of 2.6.8-rc3)
+.. table:: Table 1-3: Contents of the statm fields (as of 2.6.8-rc3)
 
  ======== ===============================	==============================
  Field    Content
@@ -323,7 +323,7 @@ It's slow but very precise.
  ======== ===============================	==============================
 
 
-.. table:: Table 1-4: Contents of the stat files (as of 2.6.30-rc7)
+.. table:: Table 1-4: Contents of the stat fields (as of 2.6.30-rc7)
 
   ============= ===============================================================
   Field         Content
@@ -1321,9 +1321,9 @@ many times the slaves link has failed.
 1.4 SCSI info
 -------------
 
-If you  have  a  SCSI  host adapter in your system, you'll find a subdirectory
-named after  the driver for this adapter in /proc/scsi. You'll also see a list
-of all recognized SCSI devices in /proc/scsi::
+If you have a SCSI or ATA host adapter in your system, you'll find a
+subdirectory named after the driver for this adapter in /proc/scsi.
+You'll also see a list of all recognized SCSI devices in /proc/scsi::
 
   >cat /proc/scsi/scsi
   Attached devices:
@@ -1449,16 +1449,18 @@ Various pieces   of  information about
 since the system first booted.  For a quick look, simply cat the file::
 
   > cat /proc/stat
-  cpu  2255 34 2290 22625563 6290 127 456 0 0 0
-  cpu0 1132 34 1441 11311718 3675 127 438 0 0 0
-  cpu1 1123 0 849 11313845 2614 0 18 0 0 0
-  intr 114930548 113199788 3 0 5 263 0 4 [... lots more numbers ...]
-  ctxt 1990473
-  btime 1062191376
-  processes 2915
-  procs_running 1
+  cpu  237902850 368826709 106375398 1873517540 1135548 0 14507935 0 0 0
+  cpu0 60045249 91891769 26331539 468411416 495718 0 5739640 0 0 0
+  cpu1 59746288 91759249 26609887 468860630 312281 0 4384817 0 0 0
+  cpu2 59489247 92985423 26904446 467808813 171668 0 2268998 0 0 0
+  cpu3 58622065 92190267 26529524 468436680 155879 0 2114478 0 0 0
+  intr 8688370575 8 3373 0 0 0 0 0 0 1 40791 0 0 353317 0 0 0 0 224789828 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 190974333 41958554 123983334 43 0 224593 0 0 0 <more 0's deleted>
+  ctxt 22848221062
+  btime 1605316999
+  processes 746787147
+  procs_running 2
   procs_blocked 0
-  softirq 183433 0 21755 12 39 1137 231 21459 2263
+  softirq 12121874454 100099120 3938138295 127375644 2795979 187870761 0 173808342 3072582055 52608 224184354
 
 The very first  "cpu" line aggregates the  numbers in all  of the other "cpuN"
 lines.  These numbers identify the amount of time the CPU has spent performing
@@ -1520,8 +1522,8 @@ softirq.
 Information about mounted ext4 file systems can be found in
 /proc/fs/ext4.  Each mounted filesystem will have a directory in
 /proc/fs/ext4 based on its device name (i.e., /proc/fs/ext4/hdc or
-/proc/fs/ext4/dm-0).   The files in each per-device directory are shown
-in Table 1-12, below.
+/proc/fs/ext4/sda9 or /proc/fs/ext4/dm-0).   The files in each per-device
+directory are shown in Table 1-12, below.
 
 .. table:: Table 1-12: Files in /proc/fs/ext4/<devname>
 
@@ -1601,12 +1603,12 @@ can inadvertently  disrupt  your  system
 documentation and  source  before actually making adjustments. In any case, be
 very careful  when  writing  to  any  of these files. The entries in /proc may
 change slightly between the 2.1.* and the 2.2 kernel, so if there is any doubt
-review the kernel documentation in the directory /usr/src/linux/Documentation.
+review the kernel documentation in the directory linux/Documentation.
 This chapter  is  heavily  based  on the documentation included in the pre 2.2
 kernels, and became part of it in version 2.2.1 of the Linux kernel.
 
-Please see: Documentation/admin-guide/sysctl/ directory for descriptions of these
-entries.
+Please see: Documentation/admin-guide/sysctl/ directory for descriptions of
+these entries.
 
 Summary
 -------
