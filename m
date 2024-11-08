Return-Path: <linux-fsdevel+bounces-34102-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4B9C26E7
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 22:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AAD1F22480
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 21:06:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7A3D1DFDA2;
	Fri,  8 Nov 2024 21:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="SWeh4s3F"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward501a.mail.yandex.net (forward501a.mail.yandex.net [178.154.239.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED4C1AA1F9;
	Fri,  8 Nov 2024 21:06:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731099983; cv=none; b=Yi3zqHxyHQcXpnwiXObgrF3b22Vy8m6uErSnHbKB2DKGEUTbmzKf+heKbZEY2eX/jWgWJWucU8r0CVbBcV24R0Lx5LLURewi8ufJeUkCbTGc316jb46u18nhp6RydFTC92KtCNe40blQiOieP2rKOpboAfxhon+svAkri4EvnkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731099983; c=relaxed/simple;
	bh=MmNXDzNOgdLQPQuJ1FC3zOjrgDKnuURlbUXYI19ITxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmO/0zr6ap0XoAXOz6mmuQZk546O/WQNdsDvEctJRNe0i52slSUnOi0KYD3vo4tfH2PGPMfxZC8A5jQWw3/tijZTzx1lHjlkH2PPu+lUEPYc/XON540P3P8RxuiA49ig9jdm1P46KYQwsa7Qp+yA0pJ/wP5l68PiHeRKcqmum+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=SWeh4s3F; arc=none smtp.client-ip=178.154.239.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net [IPv6:2a02:6b8:c15:2e15:0:640:bcf8:0])
	by forward501a.mail.yandex.net (Yandex) with ESMTPS id E8B0061652;
	Sat,  9 Nov 2024 00:06:11 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id 96rBAhWjCCg0-EbZkorcQ;
	Sat, 09 Nov 2024 00:06:11 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731099971; bh=klbADpkktAIauI9C2OIs9IU8Pb/Md3IDrF1LX9lzWmk=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=SWeh4s3FhuQvGQtqPbOsRTloRzXkD+ltjj5Gx0dC7d9FjoRBEwKDlKS7BhvLzZQZK
	 Dh+hyWT3P+vk+IN1MiLrM8Se1VAzvrccyw09Abnm2UJXbYS5pBTJtH7wyVQYOaY0Fp
	 W9S30zxGVozi1WaRdFRQ9w/67ZTI6p1YF9y2WArs=
Authentication-Results: mail-nwsmtp-smtp-production-main-84.vla.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <8288a08e-448b-43c2-82dc-59f87d0d9072@yandex.ru>
Date: Sat, 9 Nov 2024 00:06:09 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] procfs: avoid some usages of seq_file private data
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org
Cc: Eric Biederman <ebiederm@xmission.com>, Andy Lutomirski
 <luto@kernel.org>, Aleksa Sarai <cyphar@cyphar.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
 Thomas Gleixner <tglx@linutronix.de>, Jeff Layton <jlayton@kernel.org>,
 John Johansen <john.johansen@canonical.com>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 Casey Schaufler <casey@schaufler-ca.com>,
 Adrian Ratiu <adrian.ratiu@collabora.com>,
 Felix Moessbauer <felix.moessbauer@siemens.com>, Jens Axboe
 <axboe@kernel.dk>, Oleg Nesterov <oleg@redhat.com>,
 "Serge E. Hallyn" <serge@hallyn.com>, linux-fsdevel@vger.kernel.org,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>
References: <20241108101339.1560116-1-stsp2@yandex.ru>
 <20241108101339.1560116-2-stsp2@yandex.ru>
 <618F0D80-F2E1-49C1-AA25-B2C0CC46F519@kernel.org>
From: stsp <stsp2@yandex.ru>
In-Reply-To: <618F0D80-F2E1-49C1-AA25-B2C0CC46F519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

08.11.2024 18:32, Kees Cook пишет:
> On November 8, 2024 2:13:38 AM PST, Stas Sergeev <stsp2@yandex.ru> wrote:
>> seq_file private data carries the inode pointer here.
>> Replace
>> `struct inode *inode = m->private;`
>> with:
>> `struct inode *inode = file_inode(m->file);`
>> to avoid the reliance on private data.
> Conceptually this seems good, though I'd expect to see the removal of _setting_ m->private too in this patch.

Done and sent v3.

>> This is needed so that `proc_single_show()` can be used by
>> custom fops that utilize seq_file private data for other things.
>> This is used in the next patch.
> Now that next patch is pretty wild. I think using proc is totally wrong for managing uid/gid. If that's going to happen at all,

And if not - it would be good if someone
tells how to fix the actual problem then.
I think the closest thing was credfd discussed
here:
https://lkml2.uits.iu.edu/hypermail/linux/kernel/1403.3/01528.html
But /proc/self/status already carries creds,
so what else is it if not credfd? :)
I can't even think of what else the read()
syscall should return on an actual hypothetical
credfd - other than what it returns now when
reading /proc/self/status.


>   I think it should be tied to pidfd which will already do the correct process lifetime management, etc.
Please let me know the exact scheme
you have in mind so that I can try it out.
I don't see any obvious mapping of my
current proposal to pidfd, so I can't guess.

