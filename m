Return-Path: <linux-fsdevel+bounces-16087-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0299897CBA
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Apr 2024 01:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91123B296C1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 23:51:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45E8515531D;
	Wed,  3 Apr 2024 23:51:05 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3F1156871
	for <linux-fsdevel@vger.kernel.org>; Wed,  3 Apr 2024 23:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712188264; cv=none; b=dLcdwQhj5pW4eor/oQIqLWe/dsd2F85gjHgrfPr6C/pV/pJECHwe+rAmXcbKWKuJm1owab+2NFF9ER6i3YTi7aoB0rqbhRKOFQLvFM8NeiiieyCGWEL2zNSSqGe9zDgJvwKnVFVG0FHcEfxKfM+jjCeeSD+3lzuTVA8TmciXJOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712188264; c=relaxed/simple;
	bh=7ip0uxWOp6WecD8HYk9xKfo5g7Q5QDWOV6mON1A9o6Q=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IuDVSZRhTldtJHfA6j/TaejmLTDTQXqghT9fJUrfrf0mLba8fUNpZMXAbLFgrYBHyz8NOLRlMRBNrc+mvjAOz946O0xBCT4wpLK9iQz/SfJaTxnMm8vq2cc7HGXvcDqPLEIHy6OPstCe3SG2Al0x3bNvCk3XSo0avRMcGnvFyWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-36660582091so3927335ab.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 03 Apr 2024 16:51:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712188262; x=1712793062;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/jC4YnFvifP/yHXxrC7XuUJyFpMsXOBNgCQBG5wdRFQ=;
        b=LUhqG5T1kVHCDrkA8jx2NKUcCsUPhDGTRZczSFa7B1098o+ftKL68GDgMErJaeWSu4
         ofe08ssjfpdPyA3DAWk1lInJ7PbN/A1949LAAT4Kkniut7bis6cGW4AXK6wwyqJ1xeum
         1CzjbQHM1Rv9IVzHKbDIaQZQXmsa8672IWqC5X/uFdJEonBgzdMZTBE/WkQ1hcoHYNBp
         epome8SnodDmPoLwjCceg0zOQvOxypUqQVffXwa1v8zrujuixHtI+Wh61FMLotf2hsiF
         SZ0xA6vXoaEf8GjDovbO/DkWXpovl/nttQoT2YKkZA3kv5bY6PXIxz+eqhhZ8Yq8p1av
         Jmtw==
X-Forwarded-Encrypted: i=1; AJvYcCUGu5ZXKjhN+Lqt81oRp0K48C4v7HGho9NRU7WJUGQLtSLRN6vLkzerTLKhMEOdbMvQP4JySawig+2HAPkJ6cNk/iog7Od/MHPLNDft1Q==
X-Gm-Message-State: AOJu0YyaidtOqKYdG0uzYsxGRQeOtCS8nDaqUh2J82ad/cosXSD1tqwP
	CD6qOQjFUzcU6qGBv0lJsBSptVL7PWHYasz6GdgRsC9OCwefRubih63z9bg21uQs0xt6DFvHY9x
	HYP7ZLdsVLR8nNTZlch6SFc5ykUyCtcuwd1NAZOrDk+K05bQZTeCv6pc=
X-Google-Smtp-Source: AGHT+IEPilzz/Msv9bs1Mliga9g/dWfYMw9Di7/yPVPKV6N4GrfprHzjRBALpFuinDYc9680MMfz8pX7uCCb8L6K+oyeroVyXbJJ
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:369:f9c6:359d with SMTP id
 y12-20020a056e02178c00b00369f9c6359dmr83958ilu.2.1712188262648; Wed, 03 Apr
 2024 16:51:02 -0700 (PDT)
Date: Wed, 03 Apr 2024 16:51:02 -0700
In-Reply-To: <00000000000098f75506153551a1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000002f2066061539e54b@google.com>
Subject: Re: [syzbot] [kernfs?] possible deadlock in kernfs_fop_llseek
From: syzbot <syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org, 
	valesini@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"

syzbot has bisected this issue to:

commit 0fedefd4c4e33dd24f726b13b5d7c143e2b483be
Author: Valentine Sinitsyn <valesini@yandex-team.ru>
Date:   Mon Sep 25 08:40:12 2023 +0000

    kernfs: sysfs: support custom llseek method for sysfs entries

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17cb5e03180000
start commit:   fe46a7dd189e Merge tag 'sound-6.9-rc1' of git://git.kernel..
git tree:       upstream
final oops:     https://syzkaller.appspot.com/x/report.txt?x=142b5e03180000
console output: https://syzkaller.appspot.com/x/log.txt?x=102b5e03180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d90a36f0cab495a
dashboard link: https://syzkaller.appspot.com/bug?extid=9a5b0ced8b1bfb238b56
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17f1d93d180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15c38139180000

Reported-by: syzbot+9a5b0ced8b1bfb238b56@syzkaller.appspotmail.com
Fixes: 0fedefd4c4e3 ("kernfs: sysfs: support custom llseek method for sysfs entries")

For information about bisection process see: https://goo.gl/tpsmEJ#bisection

