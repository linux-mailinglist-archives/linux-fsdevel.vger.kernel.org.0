Return-Path: <linux-fsdevel+bounces-6873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E1FC81DB6F
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 17:40:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD875281447
	for <lists+linux-fsdevel@lfdr.de>; Sun, 24 Dec 2023 16:40:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356F6D277;
	Sun, 24 Dec 2023 16:40:08 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A443CCA64
	for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 16:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-7ba9fee55d4so301674239f.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 24 Dec 2023 08:40:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703436006; x=1704040806;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ3dtE3cEj3t8PX7zTCW89boYQSV2gt5/WlGrjv/hRY=;
        b=M6l1xCBOiL37+hL0ALHLc5eQ4eBnvbQclBcdRuoxM4wYQf+x175+sCMeMghVEX6Kxn
         6esb4ExbeetNwbch+m03N9MxkCXJXWRCORN8mvucwg5gQhvknlhv7QkfIflYLLXc27+q
         uLHtGo+g5QxY+e0joiQZPcxZ1OcW7ttp7dsab12JUP1k6FltLg9DUZP8bqW1twovt7hU
         CcnKXOCjrnoltTgs0n2xmITWP5UMln3rZc02/7AFAQ3tEOwMvbvG/KFskWmMGuPf0E+H
         ktWm1Cdsw5IvuE94DNNe3q3HCsa+q4tDeENjDYBadrtvHZTO3B7Rama/GYYwhQ+7duk6
         uM4w==
X-Gm-Message-State: AOJu0Yx1nEEi1uFmp4eikYblBH+p0FyiCzwEoSvIQvmKtz/oincu5t8v
	J5x2lHciA2lYYFnWkHaEhGoySeQpYDBQ+LmgRvkynTSCUfBH
X-Google-Smtp-Source: AGHT+IGqnCO5KaDzC+K+VNi8UHEk7h8wMbFhPswwONHLgmnp+xNRwaClUzAiR+nZ1ZcaM+sXms963MDU7uiovAIF+D1+ROqCLdKG
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a02:cb1b:0:b0:46c:fefd:bb37 with SMTP id
 j27-20020a02cb1b000000b0046cfefdbb37mr120454jap.4.1703436005920; Sun, 24 Dec
 2023 08:40:05 -0800 (PST)
Date: Sun, 24 Dec 2023 08:40:05 -0800
In-Reply-To: <0000000000001825ce06047bf2a6@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000007d6a9060d441adc@google.com>
Subject: Re: [syzbot] [reiserfs?] possible deadlock in super_lock
From: syzbot <syzbot+062317ea1d0a6d5e29e7@syzkaller.appspotmail.com>
To: axboe@kernel.dk, brauner@kernel.org, chao@kernel.org, christian@brauner.io, 
	daniel.vetter@ffwll.ch, hch@lst.de, hdanton@sina.com, jack@suse.cz, 
	jaegeuk@kernel.org, jinpu.wang@ionos.com, 
	linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, mairacanal@riseup.net, mcanal@igalia.com, 
	reiserfs-devel@vger.kernel.org, syzkaller-bugs@googlegroups.com, 
	terrelln@fb.com, willy@infradead.org, yukuai3@huawei.com
Content-Type: text/plain; charset="UTF-8"

syzbot suspects this issue was fixed by commit:

commit fd1464105cb37a3b50a72c1d2902e97a71950af8
Author: Jan Kara <jack@suse.cz>
Date:   Wed Oct 18 15:29:24 2023 +0000

    fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14639595e80000
start commit:   2cf0f7156238 Merge tag 'nfs-for-6.6-2' of git://git.linux-..
git tree:       upstream
kernel config:  https://syzkaller.appspot.com/x/.config?x=710dc49bece494df
dashboard link: https://syzkaller.appspot.com/bug?extid=062317ea1d0a6d5e29e7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107e9518680000

If the result looks correct, please mark the issue as fixed by replying with:

#syz fix: fs: Avoid grabbing sb->s_umount under bdev->bd_holder_lock

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

