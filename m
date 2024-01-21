Return-Path: <linux-fsdevel+bounces-8363-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8576F8354F9
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 10:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B83C21C21871
	for <lists+linux-fsdevel@lfdr.de>; Sun, 21 Jan 2024 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE43364B2;
	Sun, 21 Jan 2024 09:14:18 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BC515D0;
	Sun, 21 Jan 2024 09:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705828458; cv=none; b=uca73XhRSoOpHMxZ+u2/v8b3+jSwOsz4KQztAS8MaUIHgZmPifRBp2ofcxsxy0WyWVlkWsOZ2ePqi2lq38dZIoSOZYXAqF7JUQ1jYHDEqQw7uNb9NKN2+o/q7F0fE0x2qolESFHIJF0CbbQGm73sqMj2m8vYzoOEMhQBzpp2jPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705828458; c=relaxed/simple;
	bh=Td9d+m0xjC4n2y33X8sOx/4ELwGjnlLdP6EozkGhBb0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=DyMRZ0fN+mdE7WhT2ZadjB9uFF6qKN7qh1oyfXI0JqGEcI3b6kX/b3uAvRyKmBDQ4w+0xrr7P018ho3VCYRlH9JP6n4LOGxtoRLIIULBJx4DiRv1yemPyXio/T4WpxdYvJ6UAyDS1Fu8Kq2TSzsxTgGtH7L5XEq+WyRs7wnZCjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rRTu9-0000Or-CK; Sun, 21 Jan 2024 10:14:13 +0100
Message-ID: <d5f4c2d7-0a98-4ff8-9848-a34133199450@leemhuis.info>
Date: Sun, 21 Jan 2024 10:14:12 +0100
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [regressions] ntfs3: empty file on update without forced cache
 drop
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <regressions@leemhuis.info>
To: Alexander Viro <viro@zeniv.linux.org.uk>,
 Christian Brauner <brauner@kernel.org>
Cc: ntfs3@lists.linux.dev,
 Linux kernel regressions list <regressions@lists.linux.dev>,
 Kari Argillander <kari.argillander@stargateuniverse.net>,
 Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <138ed123-0f84-4d7a-8a17-67fe2418cf29@leemhuis.info>
 <24aa7a8b-40ed-449b-a722-df4abf65f114@leemhuis.info>
In-Reply-To: <24aa7a8b-40ed-449b-a722-df4abf65f114@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1705828456;17b06d09;
X-HE-SMSGID: 1rRTu9-0000Or-CK

On 05.12.23 13:49, Linux regression tracking (Thorsten Leemhuis) wrote:
> [adding a bunch of people and two lists to the recipients, as Konstantin
> apparently hasn't sent any mail to any lists archived on lore for ~six
> weeks; maybe someone knows what's up or is willing to help out]

[CCing Linus now as well]

JFYI for the VFS maintainers and everyone else who might care:

Konstantin afaics still did not look into below regression. Neither did
anyone else afaics.

But Konstantin is still around, as he recently showed up to post a patch
for review:
https://lore.kernel.org/all/667a5bc4-8cb5-47ce-a7f1-749479b25bec@paragon-software.com/

I replied to it in the hope of catch his attention and make him look at
this regression, but that did not work out.

So it seems we sadly are kinda stuck here. :-/

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)

> On 27.11.23 07:18, Thorsten Leemhuis wrote:
>> Hi, Thorsten here, the Linux kernel's regression tracker.
>>
>> Konstantin, I noticed a regression report in bugzilla.kernel.org.
>> Apparently it's cause by a change of yours.
>>
>> As many (most?) kernel developers don't keep an eye on bugzilla, I
>> decided to forward it by mail. Note, you have to use bugzilla to reach
>> the reporter, as I sadly[1] can not CCed them in mails like this.
>>
>> Quoting from https://bugzilla.kernel.org/show_bug.cgi?id=218180 :
> 
> Konstantin, are you still around? Would be great if you could look into
> this regression, as this sounds somewhat worrying.
> 
>>> The problem I am facing is the following:
>>> 1. I mount an NTFS partition via NTFS3
>>> 2. I create a file
>>> 3. I write to the file
>>> 4. The file is empty
>>> 5. I remount the partition
>>> 6. The file has the changes I made before the remount
>>>
>>> I can avoid the remount by doing:
>>> sudo sysctl vm.drop_caches=3
>>
>> See the ticket for more details. It according to the report happens
>> still happens with 6.7-rc2, but not with 6.1.y. The reporter bisected
>> the problem to ad26a9c84510af ("fs/ntfs3: Fixing wrong logic in
>> attr_set_size and ntfs_fallocate") [v6.2-rc1].
>>
>> Side note: while briefly checking lore for existing problems caused by
>> that change I noticed two syzbot reports about it that apparently nobody
>> looked into:
>>
>> https://lore.kernel.org/all/000000000000bdf37505f1a7fc09@google.com/
>> https://lore.kernel.org/all/00000000000062174006016bc386@google.com/
>> [...]
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

