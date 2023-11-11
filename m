Return-Path: <linux-fsdevel+bounces-2742-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 237E57E8756
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 02:08:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0DC61F20F59
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 01:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 276621FC4;
	Sat, 11 Nov 2023 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C92A1C3A
	for <linux-fsdevel@vger.kernel.org>; Sat, 11 Nov 2023 01:08:26 +0000 (UTC)
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E606422D
	for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:08:23 -0800 (PST)
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-1cc591d8177so28191005ad.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 10 Nov 2023 17:08:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699664903; x=1700269703;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dwdFPnuTOA9bzSYhfknyestbGOHfAOANZJb099tUQ0g=;
        b=fnaMMVZKZlVqzLzEp3ix5wv3w4a37rP38IpVRrF+eW7d6AJ5RBCzHTLmuRvX2mDNtS
         tr5dFzulI9ccBXCBwm2TqWAE0Pzzb6yB9L44ExCMYKOZ8DCZKBpnuHtcWYj+5kwCWl+h
         EZRECaIpaqQRNCzmJxrqVArTVDB9aUzYsP2kzTaAgyCpH6Y587i0NOy8lMpaEYHCqvq0
         QlfaxXPVm4Bifn6LMVpQ4Ko8L3M3PsmxTR4bAvX/56r0dDFRhtiLkLJ+NkC2KQOlFOAl
         DuFBPtZTlWoTozKXdV3P5lDbMGyviDIzJtRJUbPKWh8lT4ORtyy4DfHJhkvEMV19xtrP
         P2Yg==
X-Gm-Message-State: AOJu0Ywflrzn8B7VWeIZsOeFJde2YQlRt2JavGjj8KmyBksDDys572cI
	pVD7M5qGwbVnT+pP1c6maT4lMAi85qG1oN0Qj2lyDOWRSFVDuAI=
X-Google-Smtp-Source: AGHT+IF+oN9pCGz6CtQwFDycnMrLZbA5yVGGDmNRIscnoKmcaZaQf6Gfo4MxN3Qtqa06MwuRlceEYh0qLKl04qlDjngOhhlEd62X
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a17:903:25cf:b0:1cc:323c:fe4a with SMTP id
 jc15-20020a17090325cf00b001cc323cfe4amr242167plb.12.1699664903193; Fri, 10
 Nov 2023 17:08:23 -0800 (PST)
Date: Fri, 10 Nov 2023 17:08:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000caca800609d612cc@google.com>
Subject: [syzbot] Monthly fs report (Nov 2023)
From: syzbot <syzbot+listd7ef1e6b20cd71d38256@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 2 new issues were detected and 0 were fixed.
In total, 50 issues are still open and 331 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  3631    Yes   BUG: sleeping function called from invalid context in __getblk_gfp
                   https://syzkaller.appspot.com/bug?extid=69b40dc5fd40f32c199f
<2>  1500    Yes   possible deadlock in input_event (2)
                   https://syzkaller.appspot.com/bug?extid=d4c06e848a1c1f9f726f
<3>  359     Yes   BUG: sleeping function called from invalid context in __bread_gfp
                   https://syzkaller.appspot.com/bug?extid=5869fb71f59eac925756
<4>  254     No    KASAN: slab-use-after-free Read in __ext4_iget
                   https://syzkaller.appspot.com/bug?extid=5407ecf3112f882d2ef3
<5>  145     Yes   possible deadlock in pipe_write
                   https://syzkaller.appspot.com/bug?extid=011e4ea1da6692cf881c
<6>  75      Yes   BUG: sleeping function called from invalid context in bdev_getblk
                   https://syzkaller.appspot.com/bug?extid=51c61e2b1259fcd64071
<7>  57      Yes   WARNING in path_openat
                   https://syzkaller.appspot.com/bug?extid=be8872fcb764bf9fea73
<8>  47      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<9>  43      No    INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<10> 40      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

