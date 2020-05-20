Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF6151DB71F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 May 2020 16:33:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgETOdS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 May 2020 10:33:18 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:50007 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726718AbgETOdR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 May 2020 10:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589985196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=iZRAuwcPJ6bPQYLnUJ9mjxQKZxaF5A67YUR0o6fULPg=;
        b=ErFyOTw5nP6SMOWHEZ3nM+qd+aaBwWCJSdZkJbrQ+GLPehOqumtaZFWDWYhqClhCmkbCCo
        RYeL408E05p0zpuutSCJxj9lX2OdVWRD7JK6pnUAqIysR27CkqBvP/eIiZdOkl22Aja/eE
        uFnrGdDNPRI9ogIWKPNYYucUH2ZVNvE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-386-Jab3UwLJO9-n46HvmuAwxg-1; Wed, 20 May 2020 10:33:11 -0400
X-MC-Unique: Jab3UwLJO9-n46HvmuAwxg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83DB01B18BC3;
        Wed, 20 May 2020 14:33:10 +0000 (UTC)
Received: from ws.net.home (unknown [10.40.193.102])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 984F75D9E4;
        Wed, 20 May 2020 14:33:09 +0000 (UTC)
Date:   Wed, 20 May 2020 16:33:07 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.35.2
Message-ID: <20200520143307.m46d5u3vdmtrkhd6@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux stable release v2.35.2 is available at
                   
  http://www.kernel.org/pub/linux/utils/util-linux/v2.35/
                   
Feedback and bug reports, as always, are welcomed.
                   
  Karel            


util-linux 2.35.2 Release Notes
===============================

bash-completion:
   - umount explicitly needs gawk  [Wolfram Sang]
blkdiscard:
   - (man) offset and length must be sector aligned  [Lukas Czerner]
blkzone:
   - deny destructive ioctls on busy blockdev  [Johannes Thumshirn]
chsh:
   - (man) fix default behavior description  [Karel Zak]
ctrlaltdel:
   - display error message indicated by errno  [Sami Kerola]
docs:
   - Correct ChangeLog URL to history log.  [Anatoly Pugachev]
   - Fix dead references to kernel documentation  [Yannick Le Pennec]
   - add swap to 1st fstab field  [Karel Zak]
   - kill.1 add note about shell-internal kill implementations  [Sami Kerola]
   - update AUTHORS file  [Karel Zak]
eject:
   - fix compiler warning [-Wformat-overflow]  [Karel Zak]
exfat:
   - Fix parsing exfat label  [Pali Rohár]
fstrim:
   - do not use Protect setting in systemd service  [Karel Zak]
hwclock:
   - fix audit exit status  [Karel Zak]
   - make glibc 2.31 compatible  [J William Piggott, Karel Zak]
ipcs:
   - ipcs.1 ipcs no longer needs read permission on IPC resources  [Michael Kerrisk]
kill:
   - include sys/types.h before checking SYS_pidfd_send_signal  [Sami Kerola]
lib/mangle:
   - check for the NULL string argument  [Gaël PORTAY]
lib/strutils:
   - remove redundant include  [Karel Zak]
libblkid:
   - Fix UTF-16 support in function blkid_encode_to_utf8()  [Pali Rohár]
   - fix compiler warning [-Wsign-compare]  [Karel Zak]
   - fix fstatat() use in blkid__scan_dir()  [Karel Zak]
libfdisk:
   - (script) accept sector-size, ignore unknown headers  [Karel Zak]
   - (script) fix memory leak  [Karel Zak]
   - (script) fix partno_from_devname()  [Karel Zak]
   - (script) fix segmentation fault  [Gaël PORTAY]
   - fix partition calculation for BLKPG_* ioctls  [Karel Zak]
   - remove unwanted assert()  [Karel Zak]
libmount:
   - do not unnecessarily chmod utab.lock  [Tycho Andersen]
   - fix mount -a EBUSY for cifs  [Roberto Bergantinos Corpas]
   - improve smb{2,3} support  [Karel Zak]
   - smb2 is unsupported alias  [Karel Zak]
lsblk:
   - Fall back to ID_SERIAL  [Sven Wiltink]
   - Ignore hidden devices  [Ritika Srivastava]
   - fix -P regression from v2.34  [Karel Zak]
lscpu:
   - Adapt MIPS cpuinfo  [Jiaxun Yang]
   - fix SIGSEGV on archs without drawers & books  [Karel Zak]
   - use official name for HiSilicon tsv110  [Karel Zak]
po:
   - merge changes  [Karel Zak]
   - update hr.po (from translationproject.org)  [Božidar Putanec]
   - update zh_CN.po (from translationproject.org)  [Boyuan Yang]
pylibmount:
   - cleanup and sync UL_RaiseExc  [Karel Zak]
scriptlive:
   - fix man page formatting  [Jakub Wilk]
   - fix typo  [Jakub Wilk]
sfdisk:
   - (man) fix typo  [Gaël PORTAY]
   - fix ref-counting for the script  [Karel Zak]
   - only report I/O errors on --move-data  [Karel Zak]
su, runuser:
   - (man) add more info about PATH and PAM  [Karel Zak]
tests:
   - Fix for misc/fallocate test build failure.  [Mark Hindley]
umount:
   - don't try it as non-suid if not found mountinfo entry  [Karel Zak]
wipefs:
   - fix man page --no-headings short option  [Karel Zak]
write:
   - fix potential string overflow  [Sami Kerola]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

