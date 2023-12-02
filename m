Return-Path: <linux-fsdevel+bounces-4696-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C50801F0C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 23:32:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8BF1C2074C
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E15B224D1
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Dec 2023 22:32:30 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-oo1-f71.google.com (mail-oo1-f71.google.com [209.85.161.71])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE42C4
	for <linux-fsdevel@vger.kernel.org>; Sat,  2 Dec 2023 13:33:05 -0800 (PST)
Received: by mail-oo1-f71.google.com with SMTP id 006d021491bc7-587a58f3346so4203598eaf.1
        for <linux-fsdevel@vger.kernel.org>; Sat, 02 Dec 2023 13:33:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701552784; x=1702157584;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zKqRgYm0AgRjE4xdVrUEcvGqaGktrF3meejJYcgoL68=;
        b=JWkKsnloJ3t6DULtOKTEGhnO5oKPWdyb7ya8LEecPfxauzqWiG9fdkVZ/XP6TGW+YO
         b7nEXT5Dbf5qwPEIiNZCZs+cEhSUYc/GAYs+BO3jD8FmMO11lCekMGoE7CEullw3gaH5
         1jc3RKgTWAF412Ks/MUi1kt31+glhbPQK3NZxUKjkOyfjxt1aoPoBV0Vg7wLDQUThFOX
         RKDh9RqFeSePjoL0LUeuRGmrvu49oHL2xo4e7wFUaDPrQx8kvDrm+EsiX6NF1SkW9ZmH
         5EP2487wjAqgkev0hmtGCxOJtw1TWM3RG5j//CHYBuFgWhu70i8/Ac8UW9TQOx0djvbQ
         2+0Q==
X-Gm-Message-State: AOJu0YzkKmmhbR/KQgupLkupA0Fwb62uF11FXDHQht11RSCQcUyk47kO
	Uvzt/pzTMkhSNrlO+uSBs94oSEuUcRxAXqLCi+lFC65SCKu0
X-Google-Smtp-Source: AGHT+IFqucHa4qMk8RwcwCv8DbQzN4BAF0j4cNTlp1+iRF4gCgFVtyQXoYcZ5tycjVuxqOzZsBm5nFDyG77vYxFKL9qzpSe1l8Zl
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:b243:0:b0:58d:6882:9000 with SMTP id
 i3-20020a4ab243000000b0058d68829000mr1032039ooo.0.1701552784595; Sat, 02 Dec
 2023 13:33:04 -0800 (PST)
Date: Sat, 02 Dec 2023 13:33:04 -0800
In-Reply-To: <000000000000f0bfe70605025941@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000004ae32c060b8da1dc@google.com>
Subject: Re: [syzbot] [gfs2?] kernel BUG in gfs2_quota_cleanup
From: syzbot <syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com>
To: agruenba@redhat.com, eadavis@qq.com, gfs2@lists.linux.dev, 
	juntong.deng@outlook.com, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, rpeterso@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit bdcb8aa434c6d36b5c215d02a9ef07551be25a37
Author: Juntong Deng <juntong.deng@outlook.com>
Date:   Sun Oct 29 21:10:06 2023 +0000

    gfs2: Fix slab-use-after-free in gfs2_qd_dealloc

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=169c7b52e80000
start commit:   994d5c58e50e Merge tag 'hardening-v6.7-rc4' of git://git.k..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=159c7b52e80000
console output: https://syzkaller.appspot.com/x/log.txt?x=119c7b52e80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c2c74446ab4f0028
dashboard link: https://syzkaller.appspot.com/bug?extid=3b6e67ac2b646da57862
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1268c086e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164b3faae80000

Reported-by: syzbot+3b6e67ac2b646da57862@syzkaller.appspotmail.com
Fixes: bdcb8aa434c6 ("gfs2: Fix slab-use-after-free in gfs2_qd_dealloc")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

