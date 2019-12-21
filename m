Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C286128840
	for <lists+linux-fsdevel@lfdr.de>; Sat, 21 Dec 2019 09:43:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbfLUInC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 21 Dec 2019 03:43:02 -0500
Received: from mail-il1-f197.google.com ([209.85.166.197]:56696 "EHLO
        mail-il1-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725845AbfLUInC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 21 Dec 2019 03:43:02 -0500
Received: by mail-il1-f197.google.com with SMTP id 12so9558469iln.23
        for <linux-fsdevel@vger.kernel.org>; Sat, 21 Dec 2019 00:43:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to;
        bh=xU44G83IDVYmN3c7FdaPJTALb5/aKinaCWXRoF+LTv0=;
        b=FeBr27gTR6nz52vk4zBgct0ZONURCi7dEILeT94oj2G9cCsIzHcIMb35rxzGOiTDb0
         XzRPd9gHxnqFEkWlQLLxH/gSln/32J0PABp2tQPDnCrz3sd8CNaaQIVsC8+0F75h0su3
         sGFHo8QyOROBEW+m+CSxNwh2podl34tQLpt/MGh9Cj1elOyO79pp/OboVR5da908YBJE
         ryY5CjElzDJVeQ6m6ZuN/Zv7H6Y4TtvWkyL28i4CdO6taVxzsdbgbzv3ll7/6sa8pjIM
         OoyqIOcJGlWbmL4GL/iNHd2vV5Ej3Zzhe9aMExbvhWXt5qUnHlH1MFnPVTHrM59W6ZQt
         1s3w==
X-Gm-Message-State: APjAAAUbibt+hNme9AUHQEwl8SYvfqxqObgK0tAk02ko3UzM4xiiI4xE
        PDORdT6OL5pgYf5FuAyUW01ChxPm47lhn2NkHV0WrMTYB3oN
X-Google-Smtp-Source: APXvYqyuTa0ejKszQhq4t1cDUBFdclRyWYWGgRzHUDUmQVrVTb5aXX9IU8liJ2nc0RY4emELLWHbwalTEI6xVDJ0PpVmRGT9Mtvt
MIME-Version: 1.0
X-Received: by 2002:a6b:4407:: with SMTP id r7mr11525660ioa.160.1576917781568;
 Sat, 21 Dec 2019 00:43:01 -0800 (PST)
Date:   Sat, 21 Dec 2019 00:43:01 -0800
In-Reply-To: <000000000000b09d8c059a3240be@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000035eda1059a32c80f@google.com>
Subject: Re: WARNING in percpu_ref_exit (2)
From:   syzbot <syzbot+8c4a14856e657b43487c@syzkaller.appspotmail.com>
To:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"; format=flowed; delsp=yes
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

syzbot has bisected this bug to:

commit cbb537634780172137459dead490d668d437ef4d
Author: Jens Axboe <axboe@kernel.dk>
Date:   Mon Dec 9 18:22:50 2019 +0000

     io_uring: avoid ring quiesce for fixed file set unregister and update

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1118aac1e00000
start commit:   7ddd09fc Add linux-next specific files for 20191220
git tree:       linux-next
final crash:    https://syzkaller.appspot.com/x/report.txt?x=1318aac1e00000
console output: https://syzkaller.appspot.com/x/log.txt?x=1518aac1e00000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f183b01c3088afc6
dashboard link: https://syzkaller.appspot.com/bug?extid=8c4a14856e657b43487c
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b8f351e00000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b51925e00000

Reported-by: syzbot+8c4a14856e657b43487c@syzkaller.appspotmail.com
Fixes: cbb537634780 ("io_uring: avoid ring quiesce for fixed file set  
unregister and update")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection
