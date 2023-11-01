Return-Path: <linux-fsdevel+bounces-1714-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6418A7DDF1E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 11:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9DB6EB2110E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 10:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66020101EC;
	Wed,  1 Nov 2023 10:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2804E6FAB
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 10:13:31 +0000 (UTC)
Received: from mail-ot1-f71.google.com (mail-ot1-f71.google.com [209.85.210.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E21F3
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 03:13:25 -0700 (PDT)
Received: by mail-ot1-f71.google.com with SMTP id 46e09a7af769-6ce2cce763eso806858a34.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 01 Nov 2023 03:13:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698833605; x=1699438405;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H0X5+nC7jNHDCCTzWCwWOWfQ3Z6jzhEzmqgYVwfBxgs=;
        b=lrsBTjNVNhA3dwdhIT6NJDaIW3W0E2FWK5NFkFbUJAa4065Grk5gwsS6J7ss8ojgId
         RbttYwsKiUD3VgR5uH9jXqASd+gPa044gQ6p43ItycTwfZFqvGb1WCm+EKp4sxcfR1h8
         Gv5Zsn/3F4ovDugMrNDOj1My5jzwEhoX149aTbzQQytyhteWE8syycb7s01qBs0RLQ8X
         Rql1hhCb3VqcEkoU+cjZj49FNWyahWr9wtVtHi+xDNGXWMuKIlx8XI57LTjafRVgn7AS
         fTfJQZ/Bqqm+a5ZCdKMWMLnh353J4xpmZh5ni+Db26z0YDcrvjEGlIiupHinEWmlwsFs
         lO2w==
X-Gm-Message-State: AOJu0YwlEOYKffMFKQGuHDW3dPipIPNz/43U2DEXBtpg3nA6lMQvbvux
	z/J+eAiorPdGqqk6p3iLB7cma0/aaHp99i2d+h/Ew6m78VN1
X-Google-Smtp-Source: AGHT+IGFSKBn9JzoyB4reWv8CcgGNMZjtRCfcFyjCHWO02tqqZSwfzmDuaO0vGgnMepapskNikf7cVBGP2rDCjV+nWJppqSTDRz1
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6830:8d6:b0:6c6:2b19:7270 with SMTP id
 z22-20020a05683008d600b006c62b197270mr532346otg.1.1698833605405; Wed, 01 Nov
 2023 03:13:25 -0700 (PDT)
Date: Wed, 01 Nov 2023 03:13:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000953abd0609148558@google.com>
Subject: [syzbot] Monthly ntfs3 report (Oct 2023)
From: syzbot <syzbot+listbc4ef25e49f52c411bed@syzkaller.appspotmail.com>
To: almaz.alexandrovich@paragon-software.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, ntfs3@lists.linux.dev, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello ntfs3 maintainers/developers,

This is a 31-day syzbot report for the ntfs3 subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/ntfs3

During the period, 3 new issues were detected and 0 were fixed.
In total, 56 issues are still open and 28 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  11317   Yes   VFS: Busy inodes after unmount (use-after-free)
                   https://syzkaller.appspot.com/bug?extid=0af00f6a2cba2058b5db
<2>  3613    Yes   KASAN: slab-out-of-bounds Read in ntfs_iget5
                   https://syzkaller.appspot.com/bug?extid=b4084c18420f9fad0b4f
<3>  2014    Yes   possible deadlock in ni_fiemap
                   https://syzkaller.appspot.com/bug?extid=c300ab283ba3bc072439
<4>  1786    Yes   KASAN: out-of-bounds Write in end_buffer_read_sync
                   https://syzkaller.appspot.com/bug?extid=3f7f291a3d327486073c
<5>  1358    Yes   possible deadlock in attr_data_get_block
                   https://syzkaller.appspot.com/bug?extid=36bb70085ef6edc2ebb9
<6>  1347    Yes   possible deadlock in ntfs_set_state
                   https://syzkaller.appspot.com/bug?extid=f91c29a5d5a01ada051a
<7>  825     No    possible deadlock in ntfs_mark_rec_free
                   https://syzkaller.appspot.com/bug?extid=f83f0dbef763c426e3cf
<8>  626     Yes   possible deadlock in mi_read
                   https://syzkaller.appspot.com/bug?extid=bc7ca0ae4591cb2550f9
<9>  531     Yes   possible deadlock in filemap_fault
                   https://syzkaller.appspot.com/bug?extid=7736960b837908f3a81d
<10> 482     Yes   possible deadlock in ntfs_fiemap
                   https://syzkaller.appspot.com/bug?extid=96cee7d33ca3f87eee86

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

