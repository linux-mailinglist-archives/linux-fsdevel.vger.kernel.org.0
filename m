Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E172173FC37
	for <lists+linux-fsdevel@lfdr.de>; Tue, 27 Jun 2023 14:54:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230003AbjF0My0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 08:54:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbjF0MyY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:54:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BC371BCD
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 05:53:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1687870425;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=oiS2ZLd5xTYzw9V7aNrU2pwdMi8VnXjBD6gkjizwpN8=;
        b=iUjF8hcHjVVy86ukUU4IMGPQqyYFOtzUXXfovdgiv3tMt73D5JtXbzKRqM7b7JGjdpBEo0
        xG9ghD8cbEDfExEd12Zz6cALmSF1nT2UOmBsqIWqBHhsIq2C70qTPhIqeA5ZWOJaY7CQDJ
        TGdcQU2ucr/F78WO0MCUQs083hy3TyE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-ttLT2izKN-ejuW7POps_HQ-1; Tue, 27 Jun 2023 08:53:44 -0400
X-MC-Unique: ttLT2izKN-ejuW7POps_HQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 18C828C80E9;
        Tue, 27 Jun 2023 12:53:44 +0000 (UTC)
Received: from ws.net.home (unknown [10.45.225.186])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 7F228C00049;
        Tue, 27 Jun 2023 12:53:43 +0000 (UTC)
Date:   Tue, 27 Jun 2023 14:53:41 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.39.1
Message-ID: <20230627125341.uohy47xdqllxiisz@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux stable release v2.39.1 is available at
    
  http://www.kernel.org/pub/linux/utils/util-linux/v2.39/
    
Feedback and bug reports, as always, are welcomed.
    
  Karel



util-linux v2.39.1 Release Notes
================================

The main objective of this maintenance release is to address bugs in libmount and
resolve the regression that occurred due to the v2.39 rewrite for the new kernel
mount interface.

The meson build system has also been enhanced.


Changes between v2.39 and v2.39.1
---------------------------------

blkzone:
   - don't take address of struct blk_zone  [Thomas Weißschuh]
build-sys:
   - add --disable-waitpid  [Frantisek Sumsal]
   - don't call pkg-config --static if unnecessary  [Karel Zak]
   - fix typo in waitpid check  [Thomas Weißschuh]
   - only pass --failure-level if supported  [Thomas Weißschuh]
cal:
   - fix error message for bad -c argument  [Jakub Wilk]
   - fix long option name for -c  [Jakub Wilk]
ci:
   - prevent prompts during installation  [Thomas Weißschuh]
dmesg:
   - make kmsg read() buffer big enough for kernel  [anteater]
docs:
   - update AUTHORS file  [Karel Zak]
enosys:
   - add support for MIPS, PowerPC and ARC  [Thomas Weißschuh]
   - add support for loongarch  [Thomas Weißschuh]
   - add support for sparc  [Thomas Weißschuh]
   - split audit arch detection into dedicated header  [Thomas Weißschuh]
hardlink:
   - (man) add missing comma  [Jakub Wilk]
lib:
   - remove pager.c from libcommon  [Karel Zak]
lib/ include/:
   - cleanup license headers  [Karel Zak]
lib/color-names:
   - fix license header  [Karel Zak]
lib/loopdev:
   - consistently return error values from loopcxt_find_unused()  [Thomas Weißschuh]
   - document function return values  [Thomas Weißschuh]
lib/strutils:
   - fix typo  [Jakub Wilk]
libblkid:
   - (bcache) also calculate checksum over journal buckets  [Thomas Weißschuh]
   - (bcache) extend superblock definition  [Thomas Weißschuh]
   - jfs - avoid undefined shift  [Milan Broz]
libmount:
   - (optlist) correctly detect ro status  [Thomas Weißschuh]
   - always ignore user=<name>  [Karel Zak]
   - check for availability of mount_setattr  [Thomas Weißschuh]
   - cleanup enosys returns from mount hoop  [Karel Zak]
   - don't call hooks after mount.<type> helper  [Karel Zak]
   - don't call mount.<type> helper with usernames  [Karel Zak]
   - don't pass option "defaults" to helper  [Thomas Weißschuh]
   - fix options prepend/insert and merging  [Karel Zak]
   - fix sync options between context and fs structs  [Karel Zak]
   - introduce LIBMOUNT_FORCE_MOUNT2={always,never,auto}  [Karel Zak]
libsmartcols:
   - (samples)  fix format truncation warning  [Thomas Weißschuh]
logger:
   - initialize socket credentials contol union  [Karel Zak]
losetup:
   - deduplicate find_unused() logic  [Thomas Weißschuh]
lsfd:
   - (filter) weakly support ARRAY_STRING and ARRAY_NUMBER json types  [Masatake YAMATO]
   - (tests) fix typo  [Thomas Weißschuh]
   - use ARRAY_STRING for ENDPOINTS column in JSON output mode  [Masatake YAMATO]
meson:
   - add conditionalization for test progs  [Zbigniew Jędrzejewski-Szmek]
   - check for _NL_TIME_WEEK_1STDAY in langinfo.h  [Christian Hesse]
   - conditionalize waitpid  [Zbigniew Jędrzejewski-Szmek]
   - implement HAVE_PTY  [Zbigniew Jędrzejewski-Szmek]
   - include bash-completion for newgrp  [Christian Hesse]
   - include bash-completion for write  [Christian Hesse]
   - install chfn setuid  [Christian Hesse]
   - install chsh setuid  [Christian Hesse]
   - install mount setuid  [Christian Hesse]
   - install newgrp setuid  [Christian Hesse]
   - install su setuid  [Christian Hesse]
   - install symlink for vigr man page  [Christian Hesse]
   - install umount setuid  [Christian Hesse]
   - install wall setgid  [Christian Hesse]
   - install write setgid  [Christian Hesse]
   - require 0.57  [Thomas Weißschuh]
mkfs.minix:
   - handle 64bit time on 32bit system  [Thomas Weißschuh]
po:
   - merge changes  [Karel Zak]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
po-man:
   - add ko.po (from translationproject.org)  [Seong-ho Cho]
   - add ro.po (from translationproject.org)  [Remus-Gabriel Chelu]
   - merge changes  [Karel Zak]
   - update uk.po (from translationproject.org)  [Yuri Chornoivan]
sfdisk:
   - add hint about duplicate UUIDs when use dump  [Karel Zak]
test_enosys:
   - fix build on old kernels  [Thomas Weißschuh]
test_uuidd:
   - make pthread_t formatting more robust  [Thomas Weißschuh]
tests:
   - (lsfd) add a case for verifying ENDPOINTS column output in JSON mode  [Masatake YAMATO]
   - (run.sh) detect builddir from working directory  [Thomas Weißschuh]
   - backport mount_setattr test  [Karel Zak]
   - backport special mount script  [Karel Zak]
   - fix update special mount test output  [Karel Zak]
tools:
   - (asciidoctor) explicitly require extensions module  [Thomas Weißschuh]
unshare:
   - fix error message for unexpected time offsets  [Thomas Weißschuh]
waitpid:
   - only build when pidfd_open is available  [Thomas Weißschuh]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

