Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2DEA3D25A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jul 2021 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbhGVNoK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jul 2021 09:44:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:34519 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232317AbhGVNoI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jul 2021 09:44:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626963881;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=xxRxJnSuUSBg6S3Mu6d9msoL1c9ep8RmoIwicFHckLo=;
        b=HixSCSHIQJwsTBxJ1eJEFvsG4oyfhVVgVgUA+n8J88jb30Ep9dWjyGRmGQr/ocQFqi9Nx5
        rEe2l/LAInU1FAv9kvDqf4YKo8uUmlwIsDsui8e4m1sgff0c1yYdYg3tGPJxaTP92g10QQ
        754q50nywBTyJ2ZRPi1iJcS7ydYteqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-329-Ct5bAETdOJK754ythEqN7g-1; Thu, 22 Jul 2021 10:24:33 -0400
X-MC-Unique: Ct5bAETdOJK754ythEqN7g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 881D61026200;
        Thu, 22 Jul 2021 14:24:32 +0000 (UTC)
Received: from ws.net.home (ovpn-113-182.ams2.redhat.com [10.36.113.182])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8EBCC60C05;
        Thu, 22 Jul 2021 14:24:31 +0000 (UTC)
Date:   Thu, 22 Jul 2021 16:24:28 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.37.1
Message-ID: <20210722142428.5dbmkxhu7jjqbzfy@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux stable release v2.37.1 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.37/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux 2.37.1 Release Notes
===============================

agetty:
   - do not use atol()  [Karel Zak]
blockdev:
   - improve arguments parsing (remove atoi)  [Karel Zak]
build-sys:
   - Update configure.ac  [Alex Xu]
   - add generated man-pages to distribution tarball  [Karel Zak]
   - display cryptsetup status after ./configure  [Luca Boccassi]
   - fix {release-version} man pages  [Karel Zak]
   - install hardlink bash-completion  [Karel Zak]
   - make re-use of generated man-pages more robust  [Karel Zak]
   - use $LIBS rather than LDFLAGS  [Karel Zak]
cfdisk:
   - do not use atoi()  [Karel Zak]
   - optimize mountpoint detection for PARTUUID  [Karel Zak]
dmesg:
   - fix indentation in man page  [Platon Pronko]
   - fix possible memory leak [coverity scan]  [Karel Zak]
   - remove  condition [lgtm scan]  [Karel Zak]
docs:
   - add uclampset to AUTHORS file  [Karel Zak]
   - fix typo in v2.37-ReleaseNotes  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
eject:
   - add __format__ attribute  [Karel Zak]
   - do not use atoi()  [Karel Zak]
fdisk:
   - do not print error message when partition reordering is not needed  [Pali Rohár]
   - move reorder diag messages to fdisk_reorder_partitions()  [Pali Rohár]
findmnt:
   - (verify) fix cache related memory leaks on --nocanonicalize [coverity scan]  [Karel Zak]
   - (verify) fix memory leak [asan]  [Karel Zak]
   - add __format__ attribute  [Karel Zak]
fsck:
   - check errno after strto..()  [Karel Zak]
   - do not use atoi()  [Karel Zak]
fsck.cramfs:
   - use open+fstat rather than stat+open  [Karel Zak]
fstrim:
   - clean return code on --quiet-unsupported  [Karel Zak]
hardlink:
   - remove pcre2posix.h support  [Karel Zak]
hexdump:
   - correctly display signed single byte integers  [Samir Benmendil]
   - do not use atoi()  [Karel Zak]
hwclock:
   - check errno after strto..()  [Karel Zak]
   - close adjtime on write error [coverity scan]  [Karel Zak]
   - fix ul_path_scanf() use  [Karel Zak]
include/c:
   - add __format__ attribute  [Karel Zak]
   - add drop_permissions(), consolidate UID/GID reset  [Karel Zak]
include/path:
   - add __format__attribute  [Karel Zak]
include/strutils:
   - cleanup strto..() functions  [Karel Zak]
   - consolidate string to number conversion  [Karel Zak]
   - fix __format__attribute  [Karel Zak]
   - fix heap-buffer-overflow in normalize_whitespace()  [Karel Zak]
include/strv:
   - fix format attributes  [Karel Zak]
ipcs:
   - check errno after strto..()  [Karel Zak]
   - do not use atoi()  [Karel Zak]
kill:
   - check errno after strto..()  [Karel Zak]
ldattach:
   - add __format__ attribute  [Karel Zak]
lib/loopdev:
   - perform retry on EAGAIN  [Karel Zak]
lib/path:
   - (test) fix ul_new_path() use  [Karel Zak]
   - fix possible leak when use ul_path_read_string() [coverity scan]  [Karel Zak]
   - improve ul_path_readlink() to be more robust  [Karel Zak]
libblkid:
   - Add hyphens to UUID string representation in Stratis superblock parsing  [John Baublitz]
   - check errno after strto..()  [Karel Zak]
   - vfat  Fix reading FAT16 boot label and serial id  [Pali Rohár]
   - vfat  Fix reading FAT32 boot label  [Pali Rohár]
libfdisk:
   - add and fix __format__ attributes  [Karel Zak]
libmount:
   - add __format__ attribute  [Karel Zak]
   - check errno after strto..()  [Karel Zak]
libsmartcols:
   - fix bare array on JSON output  [Karel Zak]
libuuid:
   - check errno after strto..()  [Karel Zak]
logger:
   - add __format__ attribute  [Karel Zak]
login:
   - add callback for close_range()  [Karel Zak]
   - fix close_range() use  [Karel Zak]
   - remove obsolete and confusing comment  [Karel Zak]
lsblk:
   - fix formatting in -e option  [ratijas]
   - normalize space in SERIAL and MODEL  [Karel Zak]
   - use ID_MODEL_ENC is possible  [Karel Zak]
lscpu:
   - check errno after strto..()  [Karel Zak]
   - do not use atoi()  [Karel Zak]
   - don't use DMI if executed with --sysroot  [Karel Zak]
   - fix build on powerpc  [Georgy Yakovlev]
lslocks:
   - check errno after strto..()  [Karel Zak]
lslogins:
   - ask for supplementary groups only once [asan]  [Karel Zak]
   - check errno after strto..()  [Karel Zak]
   - consolidate and optimize utmp files use  [Karel Zak]
   - fix memory leak [asan]  [Karel Zak]
   - use sd_journal_get_data() in proper way  [Karel Zak]
lsmem:
   - check errno after strto..()  [Karel Zak]
meson:
   - fix crypt_activate_by_signed_key detection  [Luca Boccassi]
   - fix dlopen support for cryptsetup  [Luca Boccassi]
misc:
   - improve string to number conversions  [Karel Zak]
mkfs.cramfs:
   - add comment to explain readlink() use  [Karel Zak]
mkswap:
   - fix holes detection (infinite loop and/or stack-buffer-underflow)  [Karel Zak]
more:
   - add __format__ attribute  [Karel Zak]
   - fix null-pointer dereference  [Karel Zak]
   - fix setuid/setgid order  [Karel Zak]
mount:
   - fix roothash signature extension in manpage  [Luca Boccassi]
   - man-page; add all overlayfs options  [Tj]
   - mount.8 fix overlayfs nfs_export= indention  [Karel Zak]
mount.8.adoc:
   - Remove context options exclusion  [Thiébaud Weksteen]
   - document SELinux use of nosuid mount flag  [Topi Miettinen]
namei:
   - simplify code  [Karel Zak]
newgrp:
   - fix memory leak [coverity scan]  [Karel Zak]
pg:
   - do not use atoi()  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
   - update pt_BR.po (from translationproject.org)  [Rafael Fontenelle]
   - update sr.po (from translationproject.org)  [Мирослав Николић]
readprofile:
   - check errno after strto..()  [Karel Zak]
rename:
   - use readlink() in more robust way  [Karel Zak]
rfkill:
   - Set scols table name to make the json output valid  [Nicolai Dagestad]
script:
   - add __format__ attribute  [Karel Zak]
sulogin:
   - add missing ifdefs  [Karel Zak]
   - use explicit_bzero() for buffer with password  [Karel Zak]
swapon:
   - do not use atoi()  [Karel Zak]
test/eject:
   - guard asan LD_PRELOAD with use-system-commands check  [Ross Burton]
tests:
   - check correct log file for errors in blkdiscard test  [Ross Burton]
   - don't hardcode /bin/kill in the kill tests  [Ross Burton]
   - fix lsns test on kernels without USER namespaces  [Anatoly Pugachev]
   - mark ul/ul as a known failure  [Ross Burton]
   - skip if scsi_debug model file is not accessible  [Karel Zak]
   - update sfdisk reorder test  [Karel Zak]
tools:
   - report and use LDFLAGS in tools/config-gen  [Karel Zak]
uclampset:
   - Fix left over optind++  [Qais Yousef]
utmpdump:
   - do not use atoi()  [Karel Zak]
verity:
   - fix verity.roothashsig only working as last parameter  [Luca Boccassi]
wall:
   - add __format__ attribute  [Karel Zak]
wipefs:
   - check errno after strto..()  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

