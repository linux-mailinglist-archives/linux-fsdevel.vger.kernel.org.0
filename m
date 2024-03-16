Return-Path: <linux-fsdevel+bounces-14554-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 425F887DA14
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 13:09:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D54CCB21276
	for <lists+linux-fsdevel@lfdr.de>; Sat, 16 Mar 2024 12:09:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5045617BB9;
	Sat, 16 Mar 2024 12:09:28 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A10411CBA
	for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 12:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710590968; cv=none; b=idWwCxBgAbt3IuxgK98vKoOgUoFaYRI0w+eDvuq73raRpCeunIL9I+XzjCIEpMPmy4c2bKqMZ97mlYU873VJ/2s+ZGx6ELGhcAKIBWBaygyFK9jA3NxkhWUc+r/0fhDqpOpLYQFg+sL8G/6lEVNZxX+b/Zr/0HLuh3woGoz/wWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710590968; c=relaxed/simple;
	bh=OFqpG2u95CTHKj3kiWG8U0Pt/ngyH6TQPFJ5yqRP+yg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fbzK4QzLlPnxH9ciwPzKVKjgXCpNwLFAaDaigd+HUioJFnjdcp8go3tms44q+pVlBBGs9oaf5Apax6ill/XO2EL9n6Pd0C6YkyqaWs6M3zEBI9W0AYu8kUiRPMTtojGpX4pOrcY9N9Myi/0DsinUgMbE044Uh+PS55onghBQ4yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-36660582003so42153615ab.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 16 Mar 2024 05:09:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710590965; x=1711195765;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBkvNjKAtbHEtQdfCVzshZvUM62vA91GLq3QAxf7k2g=;
        b=YEzO2m0G74+6uf+vIo9C3noM0NnWLNGaovClrS+5QRP3SmZJBDaay6ENpbk1fH4Z9u
         2mgEFMum/vJ8mV88n7zRw1fy4GhHu0WatBHz3qbR2+VP/ZBc2RY6UaA4VsGwYn+3JxTo
         R5GS4XO/liZxMCqJZB7reRPyCqZqVVv0GIni4Sy7hj7PtQw4JPmLHbgFSEKmhWbOUpEw
         oSeUXzPl8XhFxjDJHzhqkz5cFa11zgU92yi2Lz+eohOybuMgkAvABZPZ2tdY3mZFDwGY
         OjgkMJj6ADaEkZ8pxC+SqNL9f3UGSk0a6wqAD9lbKhvhNePTg3p3MKOP6f3fYuOritQA
         Dmkw==
X-Gm-Message-State: AOJu0Yx1+L9d8EuD354/sF2My/yqYbveMio5FCGA5JUAfI1cQHGCDaF8
	JjHtSnLWdh4RkaxG7m+aFCsmWKOZzCXQ66o8rch9d4Rk6s1DMmEW57gONk88u0rFEw94vRoceEJ
	MWBC18WubAGJbzG+i0Wdl3LAxJ33pbIDVYm8DjS8Ne11IgYu2Lbn6LtIccw==
X-Google-Smtp-Source: AGHT+IHBDSGm6qgrdNZtdCvk0lrhV5I+K23cilpOGSz1XR/vrUcw1YAMgWunfM+R4KQ0ES6QNjpdZngAyZtFZY3Eu9/0VvsVvmiu
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d89:b0:365:5dbd:b956 with SMTP id
 h9-20020a056e021d8900b003655dbdb956mr476433ila.3.1710590965746; Sat, 16 Mar
 2024 05:09:25 -0700 (PDT)
Date: Sat, 16 Mar 2024 05:09:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000de9d170613c5fe46@google.com>
Subject: [syzbot] Monthly fs report (Mar 2024)
From: syzbot <syzbot+listc1ea4dfa31fea8381e9d@syzkaller.appspotmail.com>
To: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello fs maintainers/developers,

This is a 31-day syzbot report for the fs subsystem.
All related reports/information can be found at:
https://syzkaller.appspot.com/upstream/s/fs

During the period, 1 new issues were detected and 1 were fixed.
In total, 40 issues are still open and 341 have been fixed so far.

Some of the still happening issues:

Ref  Crashes Repro Title
<1>  233     No    INFO: task hung in path_openat (7)
                   https://syzkaller.appspot.com/bug?extid=950a0cdaa2fdd14f5bdc
<2>  210     Yes   INFO: task hung in user_get_super (2)
                   https://syzkaller.appspot.com/bug?extid=ba09f4a317431df6cddf
<3>  73      Yes   INFO: task hung in __fdget_pos (4)
                   https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
<4>  62      Yes   INFO: task hung in filename_create (4)
                   https://syzkaller.appspot.com/bug?extid=72c5cf124089bc318016
<5>  45      Yes   INFO: rcu detected stall in sys_clock_adjtime
                   https://syzkaller.appspot.com/bug?extid=25b7addb06e92c482190
<6>  36      Yes   INFO: task hung in synchronize_rcu (4)
                   https://syzkaller.appspot.com/bug?extid=222aa26d0a5dbc2e84fe
<7>  35      Yes   WARNING: proc registration bug in bcm_connect
                   https://syzkaller.appspot.com/bug?extid=df49d48077305d17519a
<8>  21      Yes   BUG: unable to handle kernel NULL pointer dereference in do_pagemap_scan
                   https://syzkaller.appspot.com/bug?extid=f9238a0a31f9b5603fef
<9>  13      Yes   KASAN: use-after-free Read in sysv_new_block
                   https://syzkaller.appspot.com/bug?extid=eda782c229b243c648e9
<10> 3       Yes   WARNING in pagemap_scan_pmd_entry (2)
                   https://syzkaller.appspot.com/bug?extid=0748a3a1931714d970d0

---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

To disable reminders for individual bugs, reply with the following command:
#syz set <Ref> no-reminders

To change bug's subsystems, reply with:
#syz set <Ref> subsystems: new-subsystem

You may send multiple commands in a single email message.

