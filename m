Return-Path: <linux-fsdevel+bounces-2065-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 21F9B7E1EA9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 11:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 40C321C20B08
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Nov 2023 10:41:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0161798F;
	Mon,  6 Nov 2023 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="EBLhY6yQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A87F21429F
	for <linux-fsdevel@vger.kernel.org>; Mon,  6 Nov 2023 10:41:44 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7DA94;
	Mon,  6 Nov 2023 02:41:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699267281; x=1699872081; i=quwenruo.btrfs@gmx.com;
	bh=zDmt8q84D9OoK76MwK6439tCuu+XDUD/IeENQ/pjFjs=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=EBLhY6yQX2ObqtErRccO3b/EvpK9sHx4ulBWxdpxnaZJ/lk4RJOOvLbu8KZuS2Sa
	 B+3XZidLKyRY0t9p4nA7t4Sj8x/WPRjECAsF1FiaDQJbYi8vIMvMaXazK6mHw3iRI
	 aqKA98FnN18/JywTs36xqkup8RVcItuyqRLi0OXsPI/1XWjCUUEqSojH28TVt/rUj
	 p1ZZwjm8PjARDfDmn8yKfuHnSrwdapC3mbwVKbQqFaZqF5B834C7LwMW1RTqIAecy
	 2csj/BvrB036L/UK5e5W6wn/hR6Ck3iKlu3sck46YYr3LaJorIrG2cmn6EBGAOzcz
	 TaJorq7Bv84PCKKo6g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MiaYJ-1rfM8N1n3X-00fhkV; Mon, 06
 Nov 2023 11:41:21 +0100
Message-ID: <49454bf2-af6e-4dcf-b9a1-22acbfdc756d@gmx.com>
Date: Mon, 6 Nov 2023 21:11:14 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
To: Christian Brauner <brauner@kernel.org>,
 Christoph Hellwig <hch@infradead.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Amir Goldstein <amir73il@gmail.com>,
 Jan Kara <jack@suse.cz>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
 <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
 <20231101-neigen-storch-cde3b0671902@brauner>
 <20231102051349.GA3292886@perftesting>
 <20231102-schafsfell-denkzettel-08da41113e24@brauner>
 <ZUUDmu8fTB0hyCQR@infradead.org>
 <20231103-kursleiter-proklamieren-aae0a02aa1a4@brauner>
 <ZUibZgoQa9eNRsk4@infradead.org>
 <20231106-fragment-geweigert-1d80138523e5@brauner>
Content-Language: en-US
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
In-Reply-To: <20231106-fragment-geweigert-1d80138523e5@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:k/n4tuVWQQ6azLzPwj5+9qdbZvehQVe3QogutnJhAHpBEtpc2iB
 r6ZEyn4M2wkmT3IYSpUd6dT3TAEyqTw9PSYFbRFvsyi1iGskLMyq5MLo+5pUr9HWPXqrIf9
 F0nWGcMRHAwPYw4NZgvSwjvlR7sX4zDyHinkz28RzQJnQfpH/HxfxNyrW8kUchkKBnO7bwC
 nFyW1pJTZiqQDLOJup09Q==
UI-OutboundReport: notjunk:1;M01:P0:6gQ1wss+0m8=;wsFbKd6pumUgabpjNNhjpdmmRoB
 49X4OVZtqj12vXelInCDoV6mqsKYsRJ97Jd0+mR0oKgTvzGh7nhDCxbZAAEtPy92F9HYpolJ3
 4hdUlh//2jTLFbziWhQ+TZ2shzsg6LJg4EcLu9+8lbgIk3aPTCsbnAk7z7Uf6u0Ex4sh18lLt
 x/RjM+6HwhOKN5nAinvm6222FMTISJlrIKlanhH8aKNJmWgNyaxOI4ory5wCVRKdARpRmewUB
 v6dhRFOAbc3FeK3ugkf7vqJ4Nub5OsSX4/JBQpC3jxKWG9rmh298xInG7b5UKXC41q6w7/7mL
 7LSWu7N23ties2//Xts3H7iQoIJ/XkKk+KHkFuh2/RM4lFu69VJ9V3aOzHBiFsGV9hjoTbPUA
 TzMIw/2i9YzPj5sdqFyHmaqRBMoW95wDsp8xC6ekH0X5w/mB5EQh7ndBoHWUrR9k341U5ODne
 Mt/NLGNXuvULx5FXQSQ2I2i0clVB8+5jOgQk1QwVxaWbHYnU6fY0lBR6/T95AuhE6iomQDt/2
 5rusWlgWpHVdafrYCZWNCqugi1uR1gOVbPxHm/DObrt/fZBsfyuYz424K94AkmCcd5C95ZJgm
 mVCsDPEvUxopsPg39G16TkQVXFM2W1E19FbVlP7z2ZifqSWfVF9DyBWb9ojYjG6eLiZJMwnIf
 Q9JrBXniLYxPgHk6WpxQOFFMFDWRdvXyxf19L1H9nc2BGK9ntsQB6LxfRAb6Av/UrzO54OEZs
 ZjgQTtMIVrvNcOIpG3ICbgTcb/jy8hGOq3XLOlc8HATX/6nICtBARR3fJAIcd7d1wkD/Vk/iK
 EpJiUZJTveYz6cLmbHEpyZd/1zuWeRIdXBtd+km/hfL4/aDp0fl+4UsslSdj1wKosqjrM24Gj
 CuB0ASkTR7tFCQQGVbP+7SimQ/BJGmKf0Yh45aXDrEzxv7iPc8nIUjQvgFxriJBOj7eQXnEpe
 IjBRZcfHF+7zQEwCufgLcfxwjwA=



On 2023/11/6 20:33, Christian Brauner wrote:
>>> I would feel much more comfortable if the two filesystems that expose
>>> these objects give us something like STATX_SUBVOLUME that userspace ca=
n
>>> raise in the request mask of statx().
>>
>> Except that this doesn't fix any existing code.
>
> But why do we care?
> Current code already does need to know it is on a btrfs subvolume.

Not really, the user space tools doesn't care if it's btrfs or not.

They just check the st_dev, and find at a point the st_dev changed, thus
they know there is a boundary.
They don't care if it's a btrfs subvolume boundary or a regular file
system boundary.

Even if they go statx, they don't really care if it's something called
subvolid or whatever, they just care how to distinguish a boundary.
Maybe it's a fsid/subvolid or whatever combination, they just want a way
to determine the boundary.

And st_dev is the perfect proxy. I don't think there is a better way to
distinguish the boundary, even if we have statx().

> They
> all know that btrfs subvolumes are special. They will need to know that
> btrfs subvolumes are special in the future even if they were vfsmounts.
> They would likely end up with another kind of confusion because suddenly
> vfsmounts have device numbers that aren't associated with the superblock
> that vfsmount belongs to.

This looks like you are asking user space programs (especially legacy
ones) to do special handling for btrfs, which I don't believe is the
standard way.

>
> So nothing is really solved by vfsmounts either. The only thing that we
> achieved is that we somehow accommodated that st_dev hack. And that I
> consider nakable.

I think this is the problem.

If we keep the existing behavior, at least old programs won't complain
and we're still POSIX compatible, but limited number of subvolumes
(which can be more or less worked around, and is there for a while).

If we change the st_dev, firstly to what value? All the same for the
same btrfs? Then a big behavior break.

It's really a compatibility problem, and it would take a long time to
find a acceptable compromise, but never a sudden change.


You can of course complain about the vision that one fs should report
the same st_dev no matter what, but my counter argument is, for
subvolume it's really a different tree for each one, and btrfs is
combining the PV/VG/LV into one layer.

Thus either we go treat subvolumes as LVs, thus they would have
different devices numbers from each other. (just like what we do for
now, and still what I believe we should go)

Or we treat it as a VG, which should still a different device number
from all the PVs. (A made-up device id, but shared between all
subvolumes, and break up the existing behavior)

But never treating a btrfs as a PV, because that makes no sense.
>
>>
>>> If userspace requests STATX_SUBVOLUME in the request mask, the two
>>> filesystems raise STATX_SUBVOLUME in the statx result mask and then al=
so
>>> return the _real_ device number of the superblock and stop exposing th=
at
>>> made up device number.
>>
>> What is a "real" device number?
>
> The device number of the superblock of the btrfs filesystem and not some
> made-up device number.

Then again, which device for a multi-device btrfs?

The lowest devid one? Which can be gone by device rm.
The one used for mount? Which can be gone again.

A made up one? Then what's the difference? We go the VG way, and break
the existing programs, and archive nothing.

Thanks,
Qu

>
> I care about not making a btrfs specific problem the vfs's problem by
> hoisting that whole problem space a level up by mapping subvolumes to
> vfsmounts.

