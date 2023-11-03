Return-Path: <linux-fsdevel+bounces-1910-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98AD17E0031
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 11:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A107281E73
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Nov 2023 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CCC14299;
	Fri,  3 Nov 2023 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB6414002
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 10:22:27 +0000 (UTC)
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com [209.85.167.198])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F87D4C
	for <linux-fsdevel@vger.kernel.org>; Fri,  3 Nov 2023 03:22:22 -0700 (PDT)
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-3b3ebbbdb1aso2835533b6e.2
        for <linux-fsdevel@vger.kernel.org>; Fri, 03 Nov 2023 03:22:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699006941; x=1699611741;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vW0KEqPNNJIso/cnw+xQDqj8FClModaPNPhY7C7BkL4=;
        b=Rhmke7HoNVKX73K8RqRaN3DIw85Zy8uyC5mQTScxfGA6PGqGvuRT+JcTj4C0/XwgbI
         VACVH4Kz4RhoPAVUk+HFaWsGC8fV7PefKTd6/49yB1ish4GYUSxxKO85Src7DrBCeJAV
         lLA2B2Ky1DXT6EsUDsWHEWAThkX0QJDWyDbEMl5f1vkDO3cUMnIC+pNzeGPfNEf1mYRH
         J0amoRBcfP8CaYBK1/VPYzj9+r9PlANqPrCDC2dKqWlcNOZWeh2aiRevV0VPXiLJOHhd
         hZCKG96d27Y2YRSjRaPCs/9W2BgY8n6/YyNfoyFkft9OQI802cBJtrfHlR8yJDG2Xrle
         yTVw==
X-Gm-Message-State: AOJu0YxVBzF9ILxBqsEhL7fncJc2IRtHeF9n3PF5DAvNiVbVYdH92o25
	8O3quG61+nFby0OuvQCgbm5jEUFkEu7OsK7RePWJb2qrof3T
X-Google-Smtp-Source: AGHT+IFZK2q6ypq/7RXSMlSaODwy1MIDOUy9zPLACOry0IqFLPjPG9pbj1TDx0sReOPaILHlmM4QOl+/9XSQ6RSEaINVNXWS+TnX
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6808:128a:b0:3ae:5aab:a6f3 with SMTP id
 a10-20020a056808128a00b003ae5aaba6f3mr7785282oiw.5.1699006941543; Fri, 03 Nov
 2023 03:22:21 -0700 (PDT)
Date: Fri, 03 Nov 2023 03:22:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000038c4fa06093ce1d0@google.com>
Subject: [syzbot] Monthly jfs report (Nov 2023)
From: syzbot <syzbot+list84080861d145927aa825@syzkaller.appspotmail.com>
To: jfs-discussion@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, shaggy@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello jfs maintainers/developers,

This is a 31-day syzbot report for the jfs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/jfs

During the period, 1 new issues were detected and 1 were fixed.
In total, 47 issues are still open and 23 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  1274    Yes   general protection fault in lmLogSync (2)
                   https://syzkaller.appspot.com/bug?extid=e14b1036481911ae4d77
<2>  1173    Yes   UBSAN: array-index-out-of-bounds in xtInsert
                   https://syzkaller.appspot.com/bug?extid=55a7541cfd25df68109e
<3>  935     Yes   kernel BUG in jfs_evict_inode
                   https://syzkaller.appspot.com/bug?extid=9c0c58ea2e4887ab502e
<4>  767     Yes   general protection fault in write_special_inodes
                   https://syzkaller.appspot.com/bug?extid=c732e285f8fc38d15916
<5>  563     Yes   WARNING in inc_nlink (3)
                   https://syzkaller.appspot.com/bug?extid=2b3af42c0644df1e4da9
<6>  419     Yes   kernel BUG in txUnlock
                   https://syzkaller.appspot.com/bug?extid=a63afa301d1258d09267
<7>  396     Yes   UBSAN: array-index-out-of-bounds in txCommit
                   https://syzkaller.appspot.com/bug?extid=0558d19c373e44da3c18
<8>  269     Yes   general protection fault in jfs_flush_journal
                   https://syzkaller.appspot.com/bug?extid=194bfe3476f96782c0b6
<9>  231     Yes   UBSAN: array-index-out-of-bounds in dbAllocBits
                   https://syzkaller.appspot.com/bug?extid=ae2f5a27a07ae44b0f17
<10> 224     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

