Return-Path: <linux-fsdevel+bounces-14068-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CA713877499
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 01:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 112B41C209B4
	for <lists+linux-fsdevel@lfdr.de>; Sun, 10 Mar 2024 00:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36B901FBF;
	Sun, 10 Mar 2024 00:52:13 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from www262.sakura.ne.jp (www262.sakura.ne.jp [202.181.97.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07FA51FA0
	for <linux-fsdevel@vger.kernel.org>; Sun, 10 Mar 2024 00:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.181.97.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710031932; cv=none; b=Xl4Fvihymjc8EZM5eRQQvZYnsmARwneG5C89M2ia8RYmD+B5eJ3Ki/PzZHN9q+pv3JrOFXPJkHaShCORzEN6eI1g9K/r+IWrRbV5FACA62sfvxGT1JnwISbN4Tzm7bRd9haA/oH2G7ZR9xsAaThxS7o8g21CBISEHzs7yRGk9kU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710031932; c=relaxed/simple;
	bh=CWXYMjrzDwMXF+i9CzxDios6eRxwiesf/wiAEwACNe4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Iv+Jd8b1Zc/SCRCyHfWGU+ysoG698eRXnl/ei9w6/6LzcE0RzRdPXY8xHt1I9Ba8/QMwrJeTwzSj1qygiqRpdTyB0/rRSwdTpIon/GukLpOZiT/dE6Z6FrGnYKjQGsBAu1NYAvyOYjrXACDjHlNfkvjDp8QLpywA0PBxlNyBc04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp; arc=none smtp.client-ip=202.181.97.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=I-love.SAKURA.ne.jp
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=I-love.SAKURA.ne.jp
Received: from fsav111.sakura.ne.jp (fsav111.sakura.ne.jp [27.133.134.238])
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTP id 42A0q2ve086726;
	Sun, 10 Mar 2024 09:52:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Received: from www262.sakura.ne.jp (202.181.97.72)
 by fsav111.sakura.ne.jp (F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp);
 Sun, 10 Mar 2024 09:52:02 +0900 (JST)
X-Virus-Status: clean(F-Secure/fsigk_smtp/550/fsav111.sakura.ne.jp)
Received: from [192.168.1.6] (M106072142033.v4.enabler.ne.jp [106.72.142.33])
	(authenticated bits=0)
	by www262.sakura.ne.jp (8.15.2/8.15.2) with ESMTPSA id 42A0q2cj086721
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NO);
	Sun, 10 Mar 2024 09:52:02 +0900 (JST)
	(envelope-from penguin-kernel@I-love.SAKURA.ne.jp)
Message-ID: <bbeeb617-6730-4159-80b1-182841925cce@I-love.SAKURA.ne.jp>
Date: Sun, 10 Mar 2024 09:52:01 +0900
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] [hfs] general protection fault in tomoyo_check_acl (3)
Content-Language: en-US
To: Jan Kara <jack@suse.cz>,
        syzbot <syzbot+28aaddd5a3221d7fd709@syzkaller.appspotmail.com>
Cc: axboe@kernel.dk, brauner@kernel.org, jmorris@namei.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org, paul@paul-moore.com,
        serge@hallyn.com, syzkaller-bugs@googlegroups.com
References: <000000000000fcfb4a05ffe48213@google.com>
 <0000000000009e1b00060ea5df51@google.com>
 <20240111092147.ywwuk4vopsml3plk@quack3>
From: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
In-Reply-To: <20240111092147.ywwuk4vopsml3plk@quack3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024/01/11 18:21, Jan Kara wrote:
> On Wed 10-01-24 22:44:04, syzbot wrote:
>> syzbot suspects this issue was fixed by commit:
>>
>> commit 6f861765464f43a71462d52026fbddfc858239a5
>> Author: Jan Kara <jack@suse.cz>
>> Date:   Wed Nov 1 17:43:10 2023 +0000
>>
>>     fs: Block writes to mounted block devices
>>
>> bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15135c0be80000
>> start commit:   a901a3568fd2 Merge tag 'iomap-6.5-merge-1' of git://git.ke..
>> git tree:       upstream
>> kernel config:  https://syzkaller.appspot.com/x/.config?x=7406f415f386e786
>> dashboard link: https://syzkaller.appspot.com/bug?extid=28aaddd5a3221d7fd709
>> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17b5bb80a80000
>> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10193ee7280000
>>
>> If the result looks correct, please mark the issue as fixed by replying with: 
> 
> Makes some sense since fs cannot be corrupted by anybody while it is
> mounted. I just don't see how the reproducer would be corrupting the
> image... Still probably:
> 
> #syz fix: fs: Block writes to mounted block devices
> 
> and we'll see if syzbot can find new ways to tickle some similar problem.
> 
> 								Honza

Since the reproducer is doing open(O_RDWR) before switching loop devices
using ioctl(LOOP_SET_FD/LOOP_CLR_FD), I think that that commit converted
a run many times, multi threaded program into a run once, single threaded
program. That will likely hide all race bugs.

Does that commit also affect open(3) (i.e. open for ioctl only) case?
If that commit does not affect open(3) case, the reproducer could continue
behaving as run many times, multi threaded program that overwrites
filesystem images using ioctl(LOOP_SET_FD/LOOP_CLR_FD), by replacing
open(O_RDWR) with open(3) ?


