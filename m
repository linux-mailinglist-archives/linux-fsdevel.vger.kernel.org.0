Return-Path: <linux-fsdevel+bounces-4804-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59843804021
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 21:38:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 844661C20A9D
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E381835EEE
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Dec 2023 20:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="it/kGPer"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F213CE
	for <linux-fsdevel@vger.kernel.org>; Mon,  4 Dec 2023 12:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701720314;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=/a2NWnkwNV6kuDWtWA2Ptr/wrmd/v0sF7Da3RN4Y3MI=;
	b=it/kGPertPoK0Tp7RqMH9D+WJl6OymxRTgMCS5hM38sh290ETzk+S7Z09EhxPVcX5OjKND
	4+DxFPGmwnqsBz4Bz8Xpqkw3F53MeMVnQRHua+jruvJx6u6mSlTxUup+0x6ezVV+lrN4YD
	6CnulSc/3DDc4qDVBQneo+7GRmBPiqY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-jK5msx4ONyuuKmQyViljjQ-1; Mon, 04 Dec 2023 15:05:11 -0500
X-MC-Unique: jK5msx4ONyuuKmQyViljjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0EEB9811000;
	Mon,  4 Dec 2023 20:05:11 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.175])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 741591C060AE;
	Mon,  4 Dec 2023 20:05:10 +0000 (UTC)
Date: Mon, 4 Dec 2023 21:05:08 +0100
From: Karel Zak <kzak@redhat.com>
To: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39.3
Message-ID: <20231204200508.mtdmxgrsvhux7m7s@ws.net.home>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

The util-linux stable release v2.39.3 is available at
 
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39/
 
Feedback and bug reports, as always, are welcomed.
 
  Karel




util-linux v2.39.3 Release Notes
================================
 
Changes between v2.39.2 and v2.39.3
-----------------------------------

autotools:
   - fix AC_DEFINE_UNQUOTED() use  [Karel Zak]
   - fix librtas check  [Karel Zak]
   - fix typos  [Karel Zak]
blkid:
   - fix call to err_exclusive_options  [Thomas Weiﬂschuh]
blkpr:
   - store return value of getopt_long in int  [Thomas Weiﬂschuh]
build-sys:
   - fix libmount/src/hooks.c use  [Karel Zak]
disk-utils:
   - add SPDX and Copyright notices  [Karel Zak]
docs:
   - add SPDX to boilerplate.c  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
   - use HTTPS for GitHub clone URLs  [Jakub Wilk]
include:
   - add DragonFlyBSD GPT partition types  [Thomas Weiﬂschuh]
include/audit-arch:
   - add missing SPDX  [Karel Zak]
ldattach:
   - don't call exit() from signal handler  [Thomas Weiﬂschuh]
lib/env:
   - avoid underflow of read_all_alloc() return value  [Thomas Weiﬂschuh]
lib/idcache:
   - always gracefully handle null cache  [Thomas Weiﬂschuh]
lib/path:
   - Set errno in case of fgets failure  [Tobias Stoeckmann]
   - fix possible out of boundary access  [Tobias Stoeckmann]
   - fix typos  [Tobias Stoeckmann]
   - set errno in case of error  [Tobias Stoeckmann]
libblkid:
   - (bcachefs) adapt to major.minor version  [Thomas Weiﬂschuh]
   - (bcachefs) add support for sub-device labels  [Thomas Weiﬂschuh]
   - (bcachefs) fix compiler warning [-Werror=sign-compare]  [Karel Zak]
   - (bcachefs) fix not detecting large superblocks  [Colin Gillespie]
   - (bcachefs) fix size validation  [Thomas Weiﬂschuh]
   - (jmicron_raid) avoid modifying shared buffer  [Thomas Weiﬂschuh]
   - (jmicron_raid) use checksum APIs  [Thomas Weiﬂschuh]
   - (ntfs) validate that sector_size is a power of two  [Thomas Weiﬂschuh]
   - (probe) handle probe without chain gracefully  [Thomas Weiﬂschuh]
   - (vfat) avoid modifying shared buffer  [Thomas Weiﬂschuh]
   - (vxfs) report endianness  [Thomas Weiﬂschuh]
   - (zonefs) avoid modifying shared buffer  [Thomas Weiﬂschuh]
   - avoid memory leak of cachefile path  [Thomas Weiﬂschuh]
   - exfat  fix fail to find volume label  [Yuezhang Mo]
   - reset errno before calling probefuncs  [Thomas Weiﬂschuh]
libfdisk:
   - handle allocation failure in fdisk_new_partition  [Thomas Weiﬂschuh]
   - reset errno before calling read()  [Thomas Weiﬂschuh]
libmount:
   - Fix regression when mounting with atime  [Filipe Manana]
   - accept '\' as escape for options separator  [Karel Zak]
   - fix possible NULL dereference [coverity scan]  [Karel Zak]
   - fix statx() includes  [Karel Zak]
   - gracefully handle NULL path in mnt_resolve_target()  [Thomas Weiﬂschuh]
   - improve mnt_table_next_child_fs()  [Karel Zak]
   - make.stx_mnt_id use more robust  [Karel Zak]
   - report statx in features list  [Karel Zak]
libsmartcols:
   - handle nameless tables in export format  [Thomas Weiﬂschuh]
libuuid:
   - avoid truncate clocks.txt to improve performance  [Goldwyn Rodrigues]
libuuid/src/gen_uuid.c:
   - fix cs_min declaration  [Fabrice Fontaine]
login:
   - Use pid_t for child_pid  [Tobias Stoeckmann]
   - move comment  [Tobias Stoeckmann]
losetup:
   - fix JSON MAJ MIN  [Karel Zak]
lscpu:
   - Use 4K buffer size instead of BUFSIZ  [Khem Raj]
   - fix caches separator for --parse=<list>  [Karel Zak]
   - Add Phytium FTC862 cpu model. fix:
lsfd:
   - (man) fix the form for the optional argument of --inet option  [Masatake YAMATO]
   - avoid undefined behavior  [Thomas Weiﬂschuh]
   - fix memory leak in append_filter_expr()  [Karel Zak]
lslogins:
   - (man) fix -y option formatting  [Thomas Weiﬂschuh]
   - fix realloc() loop allocation size  [Thomas Weiﬂschuh]
meson:
   - install wall executable with group 'tty'  [Christian Hesse]
   - install write executable with group 'tty'  [Christian Hesse]
more:
   - avoid out-of-bound access  [Thomas Weiﬂschuh]
po:
   - add ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - merge changes  [Karel Zak]
   - update es.po (from translationproject.org)  [Antonio Ceballos Roa]
po-man:
   - merge changes  [Karel Zak]
script-playutils:
   - close filestream in case ignore_line() fails  [Thomas Weiﬂschuh]
setpriv:
   - fix group argument completion  [Thomas Weiﬂschuh]
setterm:
   - avoid restoring flags from uninitialized memory  [Chris Hofstaedtler]
tests:
   - add ts_skip_docker  [Thomas Weiﬂschuh]
   - skip broken tests on docker  [Thomas Weiﬂschuh]
umount:
   - handle bindmounts during --recursive  [Thomas Weiﬂschuh]

- Add Phytium FTC310 & FTC664 support  [zuoqian]
- Fix man page for col to correct documentation error  [Connor-GH]
- Update col.c to fix option mistake  [Connor-GH]
- Use empty libuser config file.  [Anatoly Pugachev]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com


