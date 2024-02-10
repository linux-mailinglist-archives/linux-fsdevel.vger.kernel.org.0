Return-Path: <linux-fsdevel+bounces-11044-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D82D85038D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 09:48:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 955D81F23588
	for <lists+linux-fsdevel@lfdr.de>; Sat, 10 Feb 2024 08:48:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42DE8358A5;
	Sat, 10 Feb 2024 08:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="qIU57IBH"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4181928DA4;
	Sat, 10 Feb 2024 08:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707554925; cv=none; b=d399pwsVowUqjdKIqhk8ZFlqt3j5stwUJEnJTmy+fehoJpimSUmu7b8rS9DVyJH+f6SWxeUqG0S6B/Hc0U/AUcpeAecPvGSdFlBupaPCJAi3oA3prGOx+YoyHuovN925HlW+yhdUtMVP589SUI09onrikx7EevVyZ8X4DghBNsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707554925; c=relaxed/simple;
	bh=by42dogj3zUmkKNyU1HJbDJGDyfM4sSev9s3YWrABgQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k2OHXgKP+IXJK+Xl2Kh/cC//V3SAqp4pSZ5ejKfsMGzeha5DEaiVGacXgMLamvQ/iJlw/toFq5k+zi2MS2GdneQLAyznjlZG524eZj+Y1TYgE0SJ5Hh18a/hYhbD/AtviMrHrSLCwJBa7HuybPjJqM+h7m1TxBgj4c4UYRgIW4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=qIU57IBH; arc=none smtp.client-ip=212.227.17.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1707554915; x=1708159715; i=quwenruo.btrfs@gmx.com;
	bh=by42dogj3zUmkKNyU1HJbDJGDyfM4sSev9s3YWrABgQ=;
	h=X-UI-Sender-Class:Date:Subject:To:References:From:In-Reply-To;
	b=qIU57IBHWbi8iO4qZ5lgyMQYMaRNMQcIxYZjg8iXc/T9iUpnvT8QnOUOeDK//f2I
	 AKhSnMjvMiuz/37W7NBRfeB1m48wGiCpZrb43/G3fuLZlgJE1PBJP0js0vtYti9yh
	 5t9ViUg34rxVgVdD5BhPxpjlZy+MDTcqZn4Z1UNSDi+U7Mup7OaI8r4wrigPMARuX
	 +plxuOogEHFRQj90FMZ4MNNZ74Ervfx+RmQDV3j+rVrkN7MfY10PeL1G06nA1H+NV
	 TdhUC4/MhvIcHF4loCP7TM5z+4x4eWczbb3J3FJuZP4/CLfaJ2EB6Am7pdOjOqeY0
	 6srTk+WTq+qzNltHrQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([159.196.52.54]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MhU5b-1r3E6j1uJX-00eb1k; Sat, 10
 Feb 2024 09:48:35 +0100
Message-ID: <9175d10b-035c-4151-80bc-f76bddc194ba@gmx.com>
Date: Sat, 10 Feb 2024 19:18:29 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [syzbot] Monthly btrfs report (Feb 2024)
Content-Language: en-US
To: syzbot <syzbot+listad2f01a497df9ab5d719@syzkaller.appspotmail.com>,
 clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org, syzkaller-bugs@googlegroups.com
References: <000000000000c47db50610f92cf9@google.com>
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00iVQUJDToH
 pgAKCRDCPZHzoSX+qNKACACkjDLzCvcFuDlgqCiS4ajHAo6twGra3uGgY2klo3S4JespWifr
 BLPPak74oOShqNZ8yWzB1Bkz1u93Ifx3c3H0r2vLWrImoP5eQdymVqMWmDAq+sV1Koyt8gXQ
 XPD2jQCrfR9nUuV1F3Z4Lgo+6I5LjuXBVEayFdz/VYK63+YLEAlSowCF72Lkz06TmaI0XMyj
 jgRNGM2MRgfxbprCcsgUypaDfmhY2nrhIzPUICURfp9t/65+/PLlV4nYs+DtSwPyNjkPX72+
 LdyIdY+BqS8cZbPG5spCyJIlZonADojLDYQq4QnufARU51zyVjzTXMg5gAttDZwTH+8LbNI4
 mm2YzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCY00ibgUJDToHvwAK
 CRDCPZHzoSX+qK6vB/9yyZlsS+ijtsvwYDjGA2WhVhN07Xa5SBBvGCAycyGGzSMkOJcOtUUf
 tD+ADyrLbLuVSfRN1ke738UojphwkSFj4t9scG5A+U8GgOZtrlYOsY2+cG3R5vjoXUgXMP37
 INfWh0KbJodf0G48xouesn08cbfUdlphSMXujCA8y5TcNyRuNv2q5Nizl8sKhUZzh4BascoK
 DChBuznBsucCTAGrwPgG4/ul6HnWE8DipMKvkV9ob1xJS2W4WJRPp6QdVrBWJ9cCdtpR6GbL
 iQi22uZXoSPv/0oUrGU+U5X4IvdnvT+8viPzszL5wXswJZfqfy8tmHM85yjObVdIG6AlnrrD
In-Reply-To: <000000000000c47db50610f92cf9@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:epPBEk7HpEzTDkp3gxgPXB0p5toGWaSyAiNyjzgQaWFKoPJA8BV
 8sjRR/aSiS57nYrCqwlTM7yc0uy0TLd+Iq+S7XyLRjqYQVIupT0s3uuk0Wkppb5t6aRltAn
 TF6jTKInsguQGsStA2Itq3qYLaRQ2glafsz8Za8F2XhfjN/Mgf0SlN2VBu9GrDXMJJ3FKeE
 h/xxTMnZqZ7ZHuo3bgooA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:VuQ85KAy/UU=;5dkLB88JIXoOxzUzjUYzALMv++T
 6969Ys3tEqB3KkgoHy0FFubm+tjoutwdNOm8b1WYUUdr0TWtvaolMLUim4l/fDWYZ0qjodGB8
 BOLfj/pqC4ZE2+qtvZJ2SgiXYOeZaAXdrRxYf/P4KxB9MKkNxsh10/axsFhlbDFyoWQZBKqXs
 77F7Oue+EukCDm3QkQEYRuppq3YaWwCysieWrYwV50p+zvhvaxdFVJ2ZEs/oW3HWLnbGIO4MQ
 E0+omnffuKdmVY+ehU6CoWBe+hl47+aF9gqO93JlLvaZKoeciuAJh+qftWq8IZMIsND22Ylir
 aG8rixE+Ut28AL9BQ3webVAmNEQ+htpK0d3M0aTondJe+E/FJt7mxYiuX2HE6Z+cX5Sq1YBrO
 cAPXQ4TrU55Ku2d4dFTmetjnHitFb0pDhFjDj6Jg+542yk+IhV1N/tV8/KZZdi2mbylNtmezy
 ARtCWZ5f3qwHaWzdqbtN29+OuMWTozZS13FFklUUGyfIHJq2FNGTbuac7qoH7aEfYU3cSAygc
 /E2vS7gUkZbAJichq3v44TXDEXV/8YtCKO9lf6CdMvi86X2tjTIISiH1XKOTUlSOEMSC0qHgF
 dU8hPx/dou0F2ABPO8+D/zvYI8+U3qrMbcT6m3IWWEPWqABbHtDGdhO+npSNJzkA6FeHQbHe+
 DLjk5sOle8SUbCelew5geld6wk7DQOGIHYdTh57dlDYm8lRzmg7GJZUXjROxLceIMdfggK1JN
 K+Bs8D3Vs7qmIIp/uUp4Sfn70QqgOuazwhGBuACSWBFpxzH2MllFuJNG6GDqg/bbDyn5dGAcN
 YYAmJvsCbYXtigLWB/KpeElUQ68knhtWocCRIeBcKKCho=



On 2024/2/10 07:27, syzbot wrote:
> Hello btrfs maintainers/developers,
>
> This is a 31-day syzbot report for the btrfs subsystem.
> All related reports/information can be found at:
> https://syzkaller.appspot.com/upstream/s/btrfs
>
> During the period, 1 new issues were detected and 1 were fixed.
> In total, 43 issues are still open and 51 have been fixed so far.
>
> Some of the still happening issues:
>
> Ref  Crashes Repro Title
> <1>  5804    Yes   kernel BUG in close_ctree
>                     https://syzkaller.appspot.com/bug?extid=3D2665d678ff=
fcc4608e18

I'm not sure why, but I never had a good experience reproducing the bug
using the C reproduer.

Furthermore, for this particular case, using that C reproducer only
reduced tons of duplicated dmesg of:

[  162.264838] btrfs: Unknown parameter 'noinode_cache'
[  162.308573] loop0: detected capacity change from 0 to 32768
[  162.308964] btrfs: Unknown parameter 'noinode_cache'
[  162.313582] loop1: detected capacity change from 0 to 32768
[  162.314070] btrfs: Unknown parameter 'noinode_cache'
[  162.323629] loop3: detected capacity change from 0 to 32768
[  162.324000] btrfs: Unknown parameter 'noinode_cache'
[  162.328046] loop2: detected capacity change from 0 to 32768
[  162.328417] btrfs: Unknown parameter 'noinode_cache'

Unlike the latest report which shows a lot of other things.

Anyone can help verifying the C reproducer?
Or I'm doing something wrong withe the reproducer?

Thanks,
Qu
> <2>  2636    Yes   WARNING in btrfs_space_info_update_bytes_may_use
>                     https://syzkaller.appspot.com/bug?extid=3D8edfa01e46=
fd9fe3fbfb
> <3>  251     Yes   INFO: task hung in lock_extent
>                     https://syzkaller.appspot.com/bug?extid=3Deaa05fbc75=
63874b7ad2
> <4>  245     Yes   WARNING in btrfs_chunk_alloc
>                     https://syzkaller.appspot.com/bug?extid=3De8e56d5d31=
d38b5b47e7
> <5>  224     Yes   WARNING in btrfs_remove_chunk
>                     https://syzkaller.appspot.com/bug?extid=3De8582cc168=
81ec70a430
> <6>  125     Yes   kernel BUG in insert_state_fast
>                     https://syzkaller.appspot.com/bug?extid=3D9ce4a36127=
ca92b59677
> <7>  99      Yes   kernel BUG in btrfs_free_tree_block
>                     https://syzkaller.appspot.com/bug?extid=3Da306f914b4=
d01b3958fe
> <8>  88      Yes   kernel BUG in set_state_bits
>                     https://syzkaller.appspot.com/bug?extid=3Db9d2e54d23=
01324657ed
> <9>  79      Yes   WARNING in btrfs_commit_transaction (2)
>                     https://syzkaller.appspot.com/bug?extid=3Ddafbca0e20=
fbc5946925
> <10> 74      Yes   WARNING in btrfs_put_transaction
>                     https://syzkaller.appspot.com/bug?extid=3D3706b1df47=
f2464f0c1e
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> To disable reminders for individual bugs, reply with the following comma=
nd:
> #syz set <Ref> no-reminders
>
> To change bug's subsystems, reply with:
> #syz set <Ref> subsystems: new-subsystem
>
> You may send multiple commands in a single email message.
>

