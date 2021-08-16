Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADA263ED7E0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 Aug 2021 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbhHPNrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 Aug 2021 09:47:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:41524 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231308AbhHPNrG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 Aug 2021 09:47:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629121593;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=3+2CPPVNiLbbkvD0700s3MjZBti+X1rB8bf9dsclTrk=;
        b=e8MCvMUoVg3vPej3kLe/Cq/h/PzzDHMJ+P/+IBLmVvdoi/ZLoSrUlLcLSOwS7//Z/5fAuf
        ADMhxNfsBpUaX7q6nNIM5fgViT2mLbpsONI/GNHsNe2eVh6F+M1lv81CnW0kT7GqrnvuCF
        /uc5d9lQjwhjVHMH6jxgdgikLT4bCbs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-IY96OcNMMLK2okNQrI881w-1; Mon, 16 Aug 2021 09:46:32 -0400
X-MC-Unique: IY96OcNMMLK2okNQrI881w-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 11CB51009607;
        Mon, 16 Aug 2021 13:46:31 +0000 (UTC)
Received: from ws.net.home (ovpn-112-16.ams2.redhat.com [10.36.112.16])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 435A02C00F;
        Mon, 16 Aug 2021 13:46:30 +0000 (UTC)
Date:   Mon, 16 Aug 2021 15:46:27 +0200
From:   Karel Zak <kzak@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        util-linux@vger.kernel.org
Subject: [ANNOUNCE] util-linux v2.37.2
Message-ID: <20210816134627.kzuyn4yewvhxjd75@ws.net.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


The util-linux stable release v2.37.2 is available at
      
  http://www.kernel.org/pub/linux/utils/util-linux/v2.37
      
Feedback and bug reports, as always, are welcomed.
 
  Karel



util-linux 2.37.2 Release Notes
===============================

blockdev:
   - allow for larger values for start sector  [Thomas Abraham]
   - use snprintf() rather than sprintf()  [Karel Zak]
docs:
   - fix info about LIBSMARTCOLS_DEBUG_PADDING  [Karel Zak]
   - update AUTHORS file  [Karel Zak]
lib/pwdutils:
   - don't use getlogin(3).  [Érico Nogueira]
   - use assert to check correct usage.  [Érico Nogueira]
libfdisk:
   - (dos) don't ignore MBR+FAT use-case  [Karel Zak]
   - (dos) support partition and MBR overlap  [Karel Zak]
libmount:
   - don't use setgroups at all()  [Karel Zak]
   - fix setgroups() use  [Karel Zak]
logger:
   - use xgetlogin from pwdutils.  [Érico Nogueira]
losetup:
   - use LOOP_CONFIGURE in a more robust way  [Karel Zak]
lscpu:
   - Add Phytium FT-2000+ & S2500 support  [panchenbo]
   - Add Phytium aarch64 cpupart  [panchenbo]
   - fix NULL dereference  [Karel Zak]
   - fix compilation against librtas  [Karel Zak]
mount:
   - mount.8 don't consider additional mounts as experimental  [Karel Zak]
po:
   - add sk.po (from translationproject.org)  [Jose Riha]
   - merge changes  [Karel Zak]
   - update pl.po (from translationproject.org)  [Jakub Bogusz]
prlimit:
   - fix compiler warning [-Wmaybe-uninitialized]  [Karel Zak]
sulogin:
   - fix getpasswd()  [Karel Zak]
sys-utils/ipcutils:
   - be careful when call calloc() for uint64 nmembs  [Karel Zak]
wall:
   - use xgetlogin.  [Érico Nogueira]

-- 
 Karel Zak  <kzak@redhat.com>
 http://karelzak.blogspot.com

