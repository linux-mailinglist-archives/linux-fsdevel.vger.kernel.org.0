Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237F5589BAA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Aug 2022 14:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239557AbiHDMZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 4 Aug 2022 08:25:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbiHDMZv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 4 Aug 2022 08:25:51 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 640715FAF
        for <linux-fsdevel@vger.kernel.org>; Thu,  4 Aug 2022 05:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659615949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=5U8G0Iu+FSaEXhX0JkIL9GW3P/quH0sDfBjMubxLl48=;
        b=JaroRPIePSFIOH4xiIz+/uBtj9N1ut8IkczVnIiQkN5NixNEpaYPmYSJ4YOiXPaYQjBJip
        XNGonUYUNuS6WzV2dWLJ+LYrEVpw/nKrr7w7vneqndZ3qjzoApcbOl2wTQMfymMV68ewsi
        H/gRNXP9qI2WeW8uaDZgRgZ10UgU8HY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-HplFBhCnPLmwnmqYpqqrMQ-1; Thu, 04 Aug 2022 08:25:46 -0400
X-MC-Unique: HplFBhCnPLmwnmqYpqqrMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 386A2801755;
        Thu,  4 Aug 2022 12:25:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.170])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9548E492C3B;
        Thu,  4 Aug 2022 12:25:43 +0000 (UTC)
Date:   Thu, 4 Aug 2022 14:25:41 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.38.1
Message-ID: <20220804122541.eet3nguw52j2iv3n@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.9
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux stable release v2.38.1 is available at
   
  http://www.kernel.org/pub/linux/utils/util-linux/v2.38
   
Feedback and bug reports, as always, are welcomed.
   
  Karel


util-linux 2.38.1 Release Notes
===============================

BSD:
   - Use byteswap.h and endian.h defined macos when present  [Warner Losh]
column:
   - fix buffer overflow when -l specified  [Karel Zak]
   - fix greedy mode on -l  [Karel Zak]
configure.ac:
   - add lsns option  [Fabrice Fontaine]
dmesg:
   - fix --since and --until  [Karel Zak]
docs:
   - update AUTHORS file  [Karel Zak]
fstrim:
   - Remove all skipped entries before de-duplication  [Scott Shambarger]
   - check for ENOSYS when using --quiet-unsupported  [Narthorn]
hardlink:
   - Document '-c' option in manpage  [FeRD (Frank Dana)]
   - Fix man page docs for '-v/--verbose'  [FeRD (Frank Dana)]
   - Move -c option in --help  [FeRD (Frank Dana)]
   - require statfs_magic.h only when reflink support enabled  [Karel Zak]
   - use info rather than warning message  [Karel Zak]
irqtop:
   - fix compiler warning [-Werror=format-truncation=]  [Karel Zak]
   - remove unused variable  [Karel Zak]
lib/fileutils:
   - fix compiler warning  [Karel Zak]
lib/logindefs:
   - fix compiler warning [-Werror=format-truncation=]  [Karel Zak]
lib/strutils:
   - add ul_strchr_escaped()  [Karel Zak]
libblkid:
   - (bsd) fix buffer pointer use [fuzzing]  [Karel Zak]
   - (hfs) fix label use [fuzzing]  [Karel Zak]
   - (hfs) fix make sure buffer is large enough  [Karel Zak]
   - (mac) make sure block size is large enough [fuzzing]  [Karel Zak]
   - (probe) fix size and offset overflows [fuzzing]  [Karel Zak]
   - (swap) fix magic string memcmp [fuzzing]  [Karel Zak]
   - simplify 'leaf' detection  [Karel Zak]
   - update documentation of BLOCK_SIZE tag  [Andrey Albershteyn]
libfdisk:
   - (gpt) Add UUID for Marvell Armada 3700 Boot partition  [Pali Rohár]
   - meson.build fix typo  [Anatoly Pugachev]
libmount:
   - fix and improve utab update on MS_MOVE  [Karel Zak]
   - when moving a mount point, all sub mount entries in utab should also be updated  [Franck Bui]
libuuid:
   - (man) uuid_copy() -- add missing parenthesis  [Andrew Price]
   - improve cache handling  [d032747]
logger:
   - make sure structured data are escaped  [Karel Zak]
loopdev:
   - set block_size when using LOOP_CONFIGURE  [Hideki EIRAKU]
losetup:
   - Fix typo for the --sector-size docs  [Alberto Ruiz]
lsblk:
   - fix JSON output when without --bytes  [Karel Zak]
lscpu:
   - keep bogomips locale output locale sensitive  [Karel Zak]
lsfd:
   - add static modifier to nodev_table  [Masatake YAMATO]
   - delete __unused__ attribute for an used parameter  [Masatake YAMATO]
   - fix compiler warning [-Werror=maybe-uninitialized]  [Karel Zak]
   - fix crash triggered by an empty filter expression  [Masatake YAMATO]
lsirq:
   - improve --sort IRQ  [Karel Zak]
lslogins:
   - fix free()  invalid pointer  [Karel Zak]
   - improve prefixes interpretation  [Karel Zak]
lsns:
   - (man) add ip-netns to "SEE ALSO" section  [Masatake YAMATO]
   - improve dependence on NS_GET_ ioctls  [Karel Zak]
meson:
   - fix compilation without systemd  [Rosen Penev]
   - fix when HAVE_CLOCK_GETTIME is set  [Nicolas Caramelli]
more:
   - avoid infinite loop on --squeeze  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update de.po (from translationproject.org)  [Mario Blättermann]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update ja.po (from translationproject.org)  [Takeshi Hamasaki]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
po-man:
   - merge changes  [Karel Zak]
   - update fr.po (from translationproject.org)  [Frédéric Marchal]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
sfdiks:
   - (man) fix example  [Karel Zak]
sulogin:
   - fix includes  [Karel Zak]
switch_root:
   - (man) fix return code description  [Karel Zak]
taskset:
   - fix use of  err_affinity()  [csbo98]
tests:
   - don't compile lsfd/mkfds helper on macos, since it's linux only  [Anatoly Pugachev]
   - fdisk/bsd  update expected output for ppc64le  [Chris Hofstaedtler]
   - fix misc/setarch run in a docker environment  [Anatoly Pugachev]
   - make libmount tests more portable  [Karel Zak]
   - report failed tests  [Karel Zak]
unshare:
   - Fix "you (user xxxx) don't exist" error when uid differs from primary gid  [Sol Boucher]
uuidd:
   - allow AF_INET in systemd service  [Karel Zak]
   - remove also PrivateNetwork=yes from systemd service  [Karel Zak]
zramctl:
   - fix compiler warning [-Werror=maybe-uninitialized]  [Karel Zak]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

