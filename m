Return-Path: <linux-fsdevel+bounces-1911-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 57DAE7E0032
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 11:22:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11272281E1D
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 10:22:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4411427F;
	Fri,  3 Nov 2023 10:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E201401F
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 10:22:27 +0000 (UTC)
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com [209.85.160.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 824B2D54
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 03:22:22 -0700 (PDT)
Received: by mail-oa1-f71.google.com with SMTP id 586e51a60fabf-1f08758b52cso45186fac.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 03:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006942; x=1699611742;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Uc6FYLAopkgJT15uv3TdDC2GDeP4YlXHM2CzEWdADSI=;
        b=T+FMwOr4oawHIyhWqUqBqTcCdz79SBg8uv4dhky2wM1N28Oj1q4eHb9Ca7zuBdQAng
         JMKnbjwUBgs8Djy8AcfkICOETUKXlP1czldOadVSPF9H81ZWx4UVQ+NgToXnaZnyjpyY
         Xw4j1SuvuOwG9FqKIgQ4PELceIvsPX9Zyc4ztMSDOsydxAE6Jei5vx+NSVa9p9Lg7Z69
         VHmB1TuDDwmWOvD2qv8MpGIeIuA3onY6TcgdHB2OqFYfePbQU6JOxwS7SGoUER3OzizJ
         LJKvixbS+icwmuohhT89+xbgXb6wmYBvDRZSPq0/ExBqj21yJjnSkzc/BisSXbBGz/ee
         cdpA==
X-Gm-Message-State: AOJu0Yxnw2a/qIgL6IrM8ayFHPFOHVFeHuZueBZ1YDtDvB84nXh3jPwv
	EmF/+8uEsfU6iBXlfagbPUn/ucrx9G4m24WH4oCQgyyJ9kQPW2Y=
X-Google-Smtp-Source: AGHT+IHvVzI4EkIrE7Q/aziOILbGKGM6tNCR5pFCuO/mUo3q1r8yizrt0z20md0SFWPfyCNGW4h+rt1uIvb1dddismjP0dry5sl3
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6870:3645:b0:1e9:dbd8:b0bd with SMTP id
 v5-20020a056870364500b001e9dbd8b0bdmr9855586oak.10.1699006941834; Fri, 03 Nov
 2023 03:22:21 -0700 (PDT)
Date: Fri, 03 Nov 2023 03:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000003d356f06093ce16b@google.com>
Subject: [syzbot] Monthly reiserfs report (Nov 2023)
From: syzbot <syzbot+listbc495c19bdf2523c9b32@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello reiserfs maintainers/developers,

This is a 31-day syzbot report for the reiserfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/reiserfs

During the period, 1 new issues were detected and 0 were fixed.
In total, 89 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  40677   Yes   KASAN: null-ptr-deref Read in do_journal_end (2)
                   https://syzkaller.appspot.com/bug?extid=845cd8e5c47f2a125683
<2>  5621    Yes   possible deadlock in open_xa_dir
                   https://syzkaller.appspot.com/bug?extid=8fb64a61fdd96b50f3b8
<3>  2433    No    KASAN: slab-out-of-bounds Read in search_by_key (2)
                   https://syzkaller.appspot.com/bug?extid=b3b14fb9f8a14c5d0267
<4>  1506    Yes   kernel BUG at fs/reiserfs/journal.c:LINE!
                   https://syzkaller.appspot.com/bug?extid=6820505ae5978f4f8f2f
<5>  1240    Yes   WARNING in reiserfs_lookup
                   https://syzkaller.appspot.com/bug?extid=392ac209604cc18792e5
<6>  1219    Yes   possible deadlock in mnt_want_write_file
                   https://syzkaller.appspot.com/bug?extid=1047e42179f502f2b0a2
<7>  784     No    KMSAN: uninit-value in reiserfs_new_inode (2)
                   https://syzkaller.appspot.com/bug?extid=6450929faa7a97cd42d1
<8>  354     Yes   possible deadlock in reiserfs_ioctl
                   https://syzkaller.appspot.com/bug?extid=79c303ad05f4041e0dad
<9>  324     Yes   WARNING in journal_end
                   https://syzkaller.appspot.com/bug?extid=d43f346675e449548021
<10> 267     Yes   KASAN: out-of-bounds Read in leaf_paste_entries (2)
                   https://syzkaller.appspot.com/bug?extid=38b79774b6c990637f95

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

