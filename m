Return-Path: <linux-fsdevel+bounces-7774-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1959382A7BF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 07:44:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B0DCDB259E8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jan 2024 06:44:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B22E7291C;
	Thu, 11 Jan 2024 06:44:06 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FEB2EADE
	for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jan 2024 06:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7bc32b1426dso405381139f.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 10 Jan 2024 22:44:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704955444; x=1705560244;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Go7MHHguEsXDJaMiDiMFUZrkJPCJjs8e6jnOcbKt05k=;
        b=NybMGPI9Z8j25lscKqsELPXYSAuH1ZddNUqpKAwj3pkqATuodotZPp1MgAIuDZ4lWT
         RWPHoMiFDMJ99C2gISKSkMUqzSHFfF88sfR1nyQZigsuHOaLHo5K1UkCEnGMcYBO2WOx
         r6/0X2E2X/LcCglvQ6jAgremQLHMeCa0Ezk0D8YltASdIZScSY9fvGKL6SGjR7wjeO2k
         myMiYbpRF6Ux/ZQnzI+EK6GgCpiLE1Q57dN0zsaYXuWBFwjryAqm6RVpHJVdt9ueYRRA
         +RX0oG/s3RMzM9YHj6+9/HBDyzkYyyCC7lYXpGEvCAM0G15c8uxfl4gmZzEvV1G7TcfU
         M6bw==
X-Gm-Message-State: AOJu0YzEQ66ofjIu3Oz09Y8Vk+I3Vddhim9WBAYCxFuoqwGlM7iIYOaH
	HMAUTRfOHzImrXZEZGIzT8UDEWVTDQaVnI1RyGdJigxLnMHc
X-Google-Smtp-Source: AGHT+IHkD2jmO/TL/yOssuiaFNilDxssd908YaoSm12wBNANAvPSwd623sCODi3g2j4cDI1dKtqu1f3WEK5dMfbA4SkkLKacv/vM
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:210:b0:46e:50ab:6a4e with SMTP id
 e16-20020a056638021000b0046e50ab6a4emr31005jaq.3.1704955444335; Wed, 10 Jan
 2024 22:44:04 -0800 (PST)
Date: Wed, 10 Jan 2024 22:44:04 -0800
In-Reply-To: <000000000000fcfb4a05ffe48213@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e1b00060ea5df51@google.com>
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
From: syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, jack@suse.cz, jmorris@namei.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-security-module@vger.kernel.org, paul@paul-moore.com, 
	penguin-kernel@I-love.SAKURA.ne.jp, penguin-kernel@i-love.sakura.ne.jp, 
	serge@hallyn.com, syzkaller-bugs@googlegroups.com, takedakn@nttdata.co.jp, 
	tomoyo-dev-en-owner@lists.osdn.me, tomoyo-dev-en@lists.osdn.me
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit 6f861765464f43a71462d52026fbddfc858239a5
Author: Jan Kara <jack@suse.cz>
Date:   Wed Nov 1 17:43:10 2023 +0000

    fs: Block writes to mounted block devices

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15135c0be80000
start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Block writes to mounted block devices

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

