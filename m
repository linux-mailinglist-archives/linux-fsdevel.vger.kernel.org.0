Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CD82B44F2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Nov 2020 14:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729344AbgKPNrH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Nov 2020 08:47:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46038 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727260AbgKPNrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Nov 2020 08:47:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605534425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=bOQ386EGmuRJxLwxGFXGhwz/IcgoAFR1YieUcfT/EYk=;
        b=O/1oNukHMW7bXscKGK94qpNWZ+uROKOCSK4e0kPg5/YwOI03w5jxTsZNQpKF3UeF0Rqjl8
        0Ls/0R2+jcfN3BnlKpy8zoDJ92rCaINUUyPgci6bq2Y2TsAOWau7wIo39cuFCvXJd2uiJ1
        WoTWo+yZ6fwaJfCim91I//b0CsxzlYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-57-YCedCoycOOqSkGWieTSo2A-1; Mon, 16 Nov 2020 08:47:00 -0500
X-MC-Unique: YCedCoycOOqSkGWieTSo2A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EB54B18B9F93;
        Mon, 16 Nov 2020 13:46:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.194.248])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 04B9555778;
        Mon, 16 Nov 2020 13:46:10 +0000 (UTC)
Date:   Mon, 16 Nov 2020 14:46:08 +0100
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] stable util-linux v2.36.1
Message-ID: <20201116134608.zhqvvvzkb63oh3tt@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux release v2.36.1 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.36/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel


util-linux 2.36.1 Release Notes
===============================
 
agetty:
   - fix typo in manual page  [Samanta Navarro]
blockdev:
   - fix man page formatting  [Jakub Wilk]
build-sys:
   - exclude GPL from libcommon  [Karel Zak]
build-system:
   - stop looking for %ms and %as  [Evgeny Vereshchagin]
chrt:
   - use SCHED_FLAG_RESET_ON_FORK for sched_setattr()  [Karel Zak]
docs:
   - add hint about make install-strip and link to Documentation/  [Karel Zak]
   - fix typo in v2.36-ReleaseNotes  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
fallocate:
   - fix --dig-holes at end of files  [Gero Treuner]
fdisk:
   - always report fdisk_create_disklabel() errors  [Karel Zak]
   - fix expected test output on alpha  [Chris Hofstaedtler]
flock:
   - keep -E exit status more restrictive  [Karel Zak]
fstrim:
   - remove fstab condition from fstrim.timer  [Dusty Mabe]
hardlink:
   - fix hardlink pcre leak  [Sami Kerola]
hexdump:
   - automatically use -C when called as hd  [Chris Hofstaedtler]
hwclock:
   - add fallback if SYS_settimeofday does not exist  [Karel Zak]
   - fix SYS_settimeofday fallback  [Rosen Penev]
lib:
   - add missing headers to .c files  [Karel Zak]
lib/pager:
   - fix improper use of negative value [coverity scan]  [Sami Kerola]
lib/procutils:
   - use Public Domain for this file  [Karel Zak]
lib/randutils:
   - rename random_get_bytes()  [Sami Kerola]
lib/sysfs:
   - fix doble free [coverity scan]  [Karel Zak]
libblkid:
   - allow a lot of mac partitions  [Samanta Navarro]
   - fix Atari prober logic  [Karel Zak]
   - fix memory leak in config parser  [Samanta Navarro]
   - limit amount of parsed partitions  [Samanta Navarro]
   - make Atari more robust  [Karel Zak]
libfdisk:
   - (gpt) make sure device is large enough  [Karel Zak]
   - (script) don't use sector size if not specified  [Karel Zak]
   - (script) fix possible memory leaks  [Karel Zak]
   - (script) fix possible partno overflow  [Karel Zak]
   - (script) make sure buffer is initialized  [Karel Zak]
   - (script) make sure label is specified  [Karel Zak]
   - add "Linux /usr" and "Linux /usr verity" GPT partition types  [nl6720]
   - add systemd-homed user's home GPT partition type  [nl6720]
   - another parse_line_nameval() cleanup  [Karel Zak]
   - fix fdisk_reread_changes() for extended partitions  [Karel Zak]
   - fix last free sector detection if partition size specified  [Karel Zak]
   - fix typo from 255f5f4c770ebd46a38b58975bd33e33ae87ed24  [Karel Zak]
   - reset context FD on error  [yangzz-97]
libmount:
   - Fix 0x%u usage  [Dr. David Alan Gilbert]
   - do not use pointer as an integer value  [Sami Kerola]
libsmartcols:
   - don't print empty output on empty table in JSON  [Karel Zak]
login:
   - close() only a file descriptor that is open [coverity scan]  [Sami Kerola]
   - ensure getutxid() does not use uninitialized variable [coverity scan]  [Sami Kerola]
losetup:
   - avoid infinite busy loop  [Karel Zak]
   - increase limit of setup attempts  [Karel Zak]
lsblk:
   - fix -T optional argument  [Karel Zak]
   - fix SCSI_IDENT_SERIAL  [Karel Zak]
   - print zero rather than empty SIZE  [Karel Zak]
   - read ID_SCSI_IDENT_SERIAL if available  [Karel Zak]
lscpu:
   - Add FUJITSU aarch64 A64FX cpupart  [Shunsuke Nakamura]
   - Even more Arm part numbers  [Jeremy Linton]
   - avoid segfault on PowerPC systems with valid hardware configurations  [Thomas Abraham]
manpages:
   - fix "The example command" in AVAILABILITY section  [Chris Hofstaedtler]
mount:
   - Add support for "nosymfollow" mount option.  [Mattias Nissler]
pg:
   - fix wcstombs() use  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update cs.po (from translationproject.org)  [Petr Písař]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
sfdisk:
   - (docs) add more information about GPT attribute bits  [Karel Zak]
   - correct --json --dump false exclusive  [Dimitri John Ledkov]
   - do not free device name too soon [coverity scan]  [Sami Kerola]
   - fix backward --move-data  [Karel Zak]
tests:
   - an attempt to get around https //github.com/karelzak/util-linux/issues/1110  [Evgeny Vereshchagin]
   - update atari blkid tests  [Karel Zak]
   - update atari partx tests  [Karel Zak]
unshare:
   - fix bad bit shift operation [coverity scan]  [Sami Kerola]
vipw:
   - fix short write handling in copyfile  [Egor Chelak]
whereis:
   - fix out of boundary read  [Samanta Navarro]
   - support zst compressed man pages  [Samanta Navarro]
wipefs:
   - (man) add hint to erase on partitions and disk  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

