Return-Path: <linux-fsdevel+bounces-34022-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47DC39C2187
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 17:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD642868AA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Nov 2024 16:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E22C1865E3;
	Fri,  8 Nov 2024 16:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="CkY45I8I"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from forward502a.mail.yandex.net (forward502a.mail.yandex.net [178.154.239.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF3147F4A;
	Fri,  8 Nov 2024 16:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.82
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081826; cv=none; b=iin0NOXzKXtrBqtWZHzyISUYtNKlttWHl82WEI61ZvIiUTScGAidrf71WCxusOD8dxgzGQOWrTWbu/REwan1XR1aHpPxrWFeTqBqyjyJ0q2SmujnnVcBzzCj6GavImf26S2Zeq7pdvnreh6Ulu6mxvmxUJSu9iLli0xLG4++ENY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081826; c=relaxed/simple;
	bh=LY7hr9zAy2fZ4pfDaD3EMfl66xmSVyTV8kkleWsJtsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZKeoGMmcLZHbNPzZQpn1mi6V4NRjUulwwsyEl0Tm1YNaPClisU7uS10LF2XmwqRiDpF3Q/WU6KAqx8Cxp3YiuTWkKJgHUlM/F9U3/+H7yNfpiA8xl7Pr1jh6tLFH5E3vYFINm4KwfTiq+ywB6J4Bielx7eo/3y3U1t0iTctO1Jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=CkY45I8I; arc=none smtp.client-ip=178.154.239.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net [IPv6:2a02:6b8:c12:3a8d:0:640:b3b5:0])
	by forward502a.mail.yandex.net (Yandex) with ESMTPS id 2328E61939;
	Fri,  8 Nov 2024 19:03:35 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id V3mYFHMl8mI0-0Q61gtdN;
	Fri, 08 Nov 2024 19:03:33 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1731081813; bh=LY7hr9zAy2fZ4pfDaD3EMfl66xmSVyTV8kkleWsJtsU=;
	h=From:In-Reply-To:Cc:Date:References:To:Subject:Message-ID;
	b=CkY45I8IAtX1SyyVq5OHn3r/Ikf/FFI9hZoiDBQW9vTWbkhhFj2Iz6lQ6289/nEH2
	 1/7pyT+8g5gjtqb4T8no5vy0MDafulFZ7bNtZWv6mk3Ty1MIgUfeXSlWA6JnYlSM2r
	 O23RB5Kn75HRNDYzYbb4/hxlh3KeTF/08t7yFy5k=
Authentication-Results: mail-nwsmtp-smtp-production-main-78.myt.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
Message-ID: <69d70bb9-4c9c-4a7d-a5bf-e5af8c98ba0b@yandex.ru>
Date: Fri, 8 Nov 2024 19:03:30 +0300
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] procfs: avoid some usages of seq_file private data
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
Content-Language: en-US
From: stsp <stsp2@yandex.ru>
In-Reply-To: <618F0D80-F2E1-49C1-AA25-B2C0CC46F519@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

08.11.2024 18:32, Kees Cook пишет:
>
> On November 8, 2024 2:13:38 AM PST, Stas Sergeev <stsp2@yandex.ru> wrote:
>> seq_file private data carries the inode pointer here.
>> Replace
>> `struct inode *inode = m->private;`
>> with:
>> `struct inode *inode = file_inode(m->file);`
>> to avoid the reliance on private data.
> Conceptually this seems good, though I'd expect to see the removal of _setting_ m->private too in this patch.

Sure I can try to do that, perhaps as
an unrelated patch.
Just got scared to post large patches
and deal with potential problems where
I didn't even mean to change anything.

>> This is needed so that `proc_single_show()` can be used by
>> custom fops that utilize seq_file private data for other things.
>> This is used in the next patch.
> Now that next patch is pretty wild. I think using proc is totally wrong for managing uid/gid. If that's going to happen at all, I think it should be tied to pidfd which will already do the correct process lifetime management, etc.
I did the POC with pidfd:

https://lore.kernel.org/lkml/20241101202657.468595-1-stsp2@yandex.ru/T/

For me it was just a random place to
hack a POC on. I then searched for something
more realistic and choose proc/status because
it already carries all the needed info inside.
So in this case it can be read from, validated,
then applied with ioctl.

How exactly do you foresee using pidfd?
I mean, unless I am misunderstanding the
pidfd intention, it is always opened by the
pid of another process. There is no way of
some process to "allow" others opening its
pid, or to even know they did. Is it possible
to use pidfd in such a way that the process
can grant his groups explicitly?
In my POC I had to do a totally silly thing
of opening the _own_ pid and then sending
the resulting fd with SCM_RIGHTS. I don't
think people would do something like that.
What technique do you have in the mind?


