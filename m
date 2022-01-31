Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D57E24A4F6B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 31 Jan 2022 20:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376311AbiAaT3Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 31 Jan 2022 14:29:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359797AbiAaT3Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:29:16 -0500
X-Greylist: delayed 329 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 31 Jan 2022 11:29:15 PST
Received: from mail.namespace.at (mail.namespace.at [IPv6:2a01:190:1801:100::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE72AC061714;
        Mon, 31 Jan 2022 11:29:15 -0800 (PST)
Date:   Mon, 31 Jan 2022 20:23:37 +0100
From:   Chris Hofstaedtler <zeha@debian.org>
To:     Karel Zak <kzak@redhat.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: Re: [ANNOUNCE] util-linux v2.38-rc1
Message-ID: <20220131192337.lzpofr4pz3lhgtl3@zeha.at>
References: <20220131151432.mfk62bwskotc6w64@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220131151432.mfk62bwskotc6w64@ws.net.home>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hello,

* Karel Zak <kzak@redhat.com> [220131 16:15]:
> 
> The util-linux release v2.38-rc1 is available at
>      
>   http://www.kernel.org/pub/linux/utils/util-linux/v2.38/
>      
> Feedback and bug reports, as always, are welcomed.

Thanks.

Some lsfd tests appear to fail in a Debian sbuild build environment,
in that they differ in the expected/actual values of DEV[STR] (see
below). I did not find time to investigate this closer, but thought
it would be best to report it sooner than later.

Best,
Chris

---snip---
     script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file
   commands: /<<PKGBUILDDIR>>/
    helpers: /<<PKGBUILDDIR>>/
    sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
    top dir: /<<PKGBUILDDIR>>/tests
       self: /<<PKGBUILDDIR>>/tests/ts/lsfd
  test name: mkfds-ro-regular-file
  test desc: read-only regular file
  component: lsfd
  namespace: lsfd/mkfds-ro-regular-file
    verbose: yes
     output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file
  error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.err
  exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.exit_code
   valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file.vgdump
   expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file{.err}
 mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file-mnt

         lsfd: read-only regular file         ... FAILED (lsfd/mkfds-ro-regular-file)
========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-ro-regular-file =================
================= OUTPUT =====================
     1  ABC         3  r--  REG /etc/passwd   1
     2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
     3  PID[RUN]: 0
     4  PID[STR]: 0
     5  INODE[RUN]: 0
     6  INODE[STR]: 0
     7  UID[RUN]: 0
     8  UID[STR]: 0
     9  USER[RUN]: 0
    10  USER[STR]: 0
    11  SIZE[RUN]: 0
    12  SIZE[STR]: 0
    13  MNTID[RUN]: 0
    14  DEV[RUN]: 0
    15  FINDMNT[RUN]: 0
    16  DEV[STR]: 1
================= EXPECTED ===================
     1  ABC         3  r--  REG /etc/passwd   1
     2  COMMAND,ASSOC,MODE,TYPE,NAME,POS: 0
     3  PID[RUN]: 0
     4  PID[STR]: 0
     5  INODE[RUN]: 0
     6  INODE[STR]: 0
     7  UID[RUN]: 0
     8  UID[STR]: 0
     9  USER[RUN]: 0
    10  USER[STR]: 0
    11  SIZE[RUN]: 0
    12  SIZE[STR]: 0
    13  MNTID[RUN]: 0
    14  DEV[RUN]: 0
    15  FINDMNT[RUN]: 0
    16  DEV[STR]: 0
================= O/E diff ===================
--- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-ro-regular-file    2022-01-31 19:12:43.802603811 +0000
+++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-ro-regular-file  2022-01-31 14:57:47.000000000 +0000
@@ -13,4 +13,4 @@
 MNTID[RUN]: 0
 DEV[RUN]: 0
 FINDMNT[RUN]: 0
-DEV[STR]: 1
+DEV[STR]: 0
==============================================

     script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device
   commands: /<<PKGBUILDDIR>>/
    helpers: /<<PKGBUILDDIR>>/
    sub dir: /<<PKGBUILDDIR>>/tests/ts/lsfd
    top dir: /<<PKGBUILDDIR>>/tests
       self: /<<PKGBUILDDIR>>/tests/ts/lsfd
  test name: mkfds-rw-character-device
  test desc: character device with O_RDWR
  component: lsfd
  namespace: lsfd/mkfds-rw-character-device
    verbose: yes
     output: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device
  error log: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.err
  exit code: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.exit_code
   valgrind: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device.vgdump
   expected: /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device{.err}
 mountpoint: /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device-mnt

         lsfd: character device with O_RDWR   ... FAILED (lsfd/mkfds-rw-character-device)
========= script: /<<PKGBUILDDIR>>/tests/ts/lsfd/mkfds-rw-character-device =================
================= OUTPUT =====================
     1      3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
     2  ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
     3  MNTID[RUN]: 0
     4  DEV[RUN]: 0
     5  FINDMNT[RUN]: 0
     6  DEV[STR]: 1
================= EXPECTED ===================
     1      3  rw-  CHR /dev/zero  mem:5   0     1:5    mem    char  1:5
     2  ASSOC,MODE,TYPE,NAME,SOURCE,POS,MAJ:MIN,CHRDRV,DEVTYPE,RDEV: 0
     3  MNTID[RUN]: 0
     4  DEV[RUN]: 0
     5  FINDMNT[RUN]: 0
     6  DEV[STR]: 0
================= O/E diff ===================
--- /<<PKGBUILDDIR>>/tests/output/lsfd/mkfds-rw-character-device        2022-01-31 19:12:44.358597427 +0000
+++ /<<PKGBUILDDIR>>/tests/expected/lsfd/mkfds-rw-character-device      2022-01-31 14:57:47.000000000 +0000
@@ -3,4 +3,4 @@
 MNTID[RUN]: 0
 DEV[RUN]: 0
 FINDMNT[RUN]: 0
-DEV[STR]: 1
+DEV[STR]: 0
==============================================

---snip---

