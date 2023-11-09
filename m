Return-Path: <linux-fsdevel+bounces-2621-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D611B7E7154
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 19:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 054D71C20C26
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EDAF34CEC;
	Thu,  9 Nov 2023 18:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CA0F341BF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 18:23:27 +0000 (UTC)
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com [209.85.210.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51DB30CF
	for <linux-fsdevel@vger.kernel.org>; Thu,  9 Nov 2023 10:23:26 -0800 (PST)
Received: by mail-pf1-f197.google.com with SMTP id d2e1a72fcca58-6b31cb3cc7eso1177409b3a.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 09 Nov 2023 10:23:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699554206; x=1700159006;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MqZmZaQnQHMv/T08XsHu4/lwHim+riyuEWyefi56ZZQ=;
        b=ZlWXfatRIoOpdwbjnkzqbNgaJ6rtZH7GYGyzyF1W+hEGEGzllp/9fwpMTTJ9iM73VA
         bIzNOjlyTf2M6ECRGXI8uJoyR0UnV0vCVVCp9JBgXh+wxcxSAMQuxbCiEs34xjPvWInF
         YSrbcI5MOn4e7jSjJWbmqubJy+jjhBnKQ7B9h4jKwGev+TUvdep+0y7Qgaf8AszviX9y
         NLwHkslVCay2vpJ4AGSbOG6YtACJfoaDd6Ou/uOBaPBehxO+kJJUmiR4eqecQTMjsr4A
         XsykJR7X12tb5DDbWWA7eXnxp1ihXEoMQOagC3Ciw2xrgQnqz4qSPGgItohhRjAD4Jcu
         8ltQ==
X-Gm-Message-State: AOJu0YwyCIb+krPQaDCujdoAiHsV9koTr5IjMHSfQKVb317XRBgtB0Tb
	9DaRiY4s4ZKN0oZnQ78dZV5ulDqi5ncmg1gZd+9fCcbNk6KQ
X-Google-Smtp-Source: AGHT+IG9LKwcLSJ1suW3rUPoiF7yaD9jW9LcNQLeKR4EMZtRNJaPpjUd38ipJcktoR/1FhOyahobkb1LoYUREkyXQo9t93gyVwxj
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6a00:850a:b0:690:29c0:ef51 with SMTP id
 ha10-20020a056a00850a00b0069029c0ef51mr18126pfb.1.1699554206425; Thu, 09 Nov
 2023 10:23:26 -0800 (PST)
Date: Thu, 09 Nov 2023 10:23:26 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c0279e0609bc4c7a@google.com>
Subject: [syzbot] Monthly udf report (Nov 2023)
From: syzbot <syzbot+liste6fcb39e599cf6bcae03@syzkaller.appspotmail.com>
To: jack@suse.com, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello udf maintainers/developers,

This is a 31-day syzbot report for the udf subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/udf

During the period, 0 new issues were detected and 0 were fixed.
In total, 14 issues are still open and 18 have been fixed so far.

Some of the still happening issues:

Ref Crashes Repro Title
<1> 1759    Yes   WARNING in udf_truncate_extents
                  https://syzkaller.appspot.com/bug?extid=43fc5ba6dcb33e3261ca
<2> 103     Yes   KASAN: use-after-free Write in udf_close_lvid
                  https://syzkaller.appspot.com/bug?extid=60864ed35b1073540d57
<3> 28      Yes   WARNING in udf_new_block
                  https://syzkaller.appspot.com/bug?extid=cc717c6c5fee9ed6e41d
<4> 15      Yes   WARNING in invalidate_bh_lru
                  https://syzkaller.appspot.com/bug?extid=9743a41f74f00e50fc77
<5> 13      Yes   WARNING in udf_setsize (2)
                  https://syzkaller.appspot.com/bug?extid=db6df8c0f578bc11e50e
<6> 6       Yes   UBSAN: array-index-out-of-bounds in udf_process_sequence
                  https://syzkaller.appspot.com/bug?extid=abb7222a58e4ebc930ad
<7> 5       Yes   KASAN: slab-out-of-bounds Write in udf_adinicb_writepage
                  https://syzkaller.appspot.com/bug?extid=a3db10baf0c0ee459854
<8> 2       Yes   KASAN: slab-use-after-free Read in udf_free_blocks
                  https://syzkaller.appspot.com/bug?extid=0b7937459742a0a4cffd

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

