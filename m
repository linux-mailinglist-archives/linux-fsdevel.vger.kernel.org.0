Return-Path: <linux-fsdevel+bounces-2757-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DABE7E8CA2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 21:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A6911C20866
	for <lists+linux-fsdevel@lfdr.de>; Sat, 11 Nov 2023 20:48:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 400981CFB3;
	Sat, 11 Nov 2023 20:48:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="ZwRxKRMg"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0CB1B274;
	Sat, 11 Nov 2023 20:48:49 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09CC42D73;
	Sat, 11 Nov 2023 12:48:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1699735704; x=1700340504; i=quwenruo.btrfs@gmx.com;
	bh=TgFPOslhJOQ9qs98yLRjNcSGkGecPQbUrWbyHjijZdU=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=ZwRxKRMgIl1MWZzW6+omuPubI6dfNBN034QeH00rW/4OQnI8FJQCrjabePshr0Lq
	 HaVibQI0xVVKaBAP8Ta/ELZyHXuLIarDKwuwyevy7biuv6RKx6TMasY2Bdxx9mI4E
	 a7icdjopw1Z3wYJyOdPCoBtVEkKfYRfx7k9HR8VjWQ3EagC/Jh3PHKHDgkUt9ocEr
	 3rOatIoZDJfB+CxZgRVGLqCxtLtF/vp/xhFVxBJXJQdqghFrBp+H6/IdEqCORL3M7
	 gjXsbCanxYAXtbJlQi6yl7Z9R/m9M9fMHMvMbVEmrsE2Yyb5QkUYpK13VRtKNi1CR
	 ScM9LSEwXYmxZGQAzg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MyKDU-1rKQDc0kCy-00yhg8; Sat, 11
 Nov 2023 21:48:24 +0100
Message-ID: <ae67f48e-a1f3-4d45-8eca-fa42f0fcb5b8@gmx.com>
Date: Sun, 12 Nov 2023 07:18:16 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test 305230142ae0
To: Edward Adam Davis <eadavis@qq.com>, willy@infradead.org
Cc: boris@bur.io, clm@fb.com, dsterba@suse.com, josef@toxicpanda.com,
 linux-btrfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 syzbot+4d81015bc10889fd12ea@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com
References: <ZU8dS0dlOGOblbxf@casper.infradead.org>
 <tencent_82622979A3A74448177BF772E6D1736E4305@qq.com>
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
In-Reply-To: <tencent_82622979A3A74448177BF772E6D1736E4305@qq.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+hLGTdZv3iptvCjS7ha0sAWDfEJNPI6Tt7PTlZss1eGzxUEnRDA
 3Y3H3z9bpaGlJernznmFPWY6HDdNErxaot1rS+0Y/k/2EyRP1tnSLCmrHCMotDpZZyHrsa3
 89UPcS+V+j5Nn7XmsivFDk2KBg1uwj+yiSunvkSbjdaiuD2rjsyKNO0duPLeU/lkE+9jcKj
 daTlkl/s972FmKs6f95gg==
UI-OutboundReport: notjunk:1;M01:P0:/Bugbo+DcYE=;n3pcwbrm7CrlQo4cmn6tPc0Va5Y
 UCTKFhOLc4MojHJlLhKxbxU06JOe1wDFpunh4gqEnEwg34zY/epnipIxMC+fzXn/10wDRKzlu
 qFQ0TNZoIuXDA0PzaAJZDmrr2q2tc3024jFVUpZkSMQlZjTX95UF5sgvnkEvthdskBxqyH3r0
 EP5p/tdb9JzTqTKS39CHYrPmgLRLFMx9nnVLoGMTQMzGkFpSFN4uWWZ5Z5SLNnehEw9wQtbuE
 /mBGRSP+nbgfPJtsYBCIwkBZJx0fJrdO2oassDW0n1SUPQ0SnOQT7UJprKFGG1+UtHr29fTTW
 EUXU46AoeCLsieCGoF73MLb60UG2vdpgqcrGL0fcjWP0N0zdEKCO9o3YpS1wYZHt2Nj6Tymq1
 ECuYVUSn3XjtmXRuiDGBo64J118qKvmeIC5RP8F+3C4pXZ47lh4Sao9Jfj/s55Zbja26y48gy
 y792VobwF0kaDCIZg3IV1qncPgjqZdIPQn70LYkKAMDF7PI9fIk2aDNhNC7sxJjjVgbhKVLDj
 8jgGBJ52RmAS7zpmD/LEh+ENFu2fzw4TXRs5XvTlXJ12Yab6wJ/jPOG9T3IgaplDfoHAhINri
 8ICHA/8aTSi3Bz+uQyBnpwBi/u7psyGGhK3I1jBOj3QMnBo7ohZdNOoqbUXPrpwh0qfU3iGgU
 6w6yAh9eIweq8PfAeqe9umJQxKPlh2NC2ETxXPdWBBhqkzIh0aoaPxqHUGyTB2/MUyOxSSaTR
 +lmPDT5pnhGVfJivjWtRbSv92TEESTs9Mgc7GJL3Yop1yaB0CmqdJhfP4gskkbJjuhAlMFzz3
 Uj5SrfdlkD5Jqf6xnqp3e8rEtBZfWeMMSyDcgGtDm6FQEnTzeEvz8kEdWxhvQMUnRYPMWx1o2
 JcmgF/2w1QMm/8BqFR74rcPTTd+IYqS2ABtE//RB2qeFfl6s49v9dZ8cXhH5kcHnCebEC3Qsi
 xfMTFdEjjFRZp22e4p9cyBXKG9c=



On 2023/11/11 18:43, Edward Adam Davis wrote:
> On Sat, 11 Nov 2023 06:20:59 +0000, Matthew Wilcox wrote:
>>> +++ b/fs/btrfs/disk-io.c
>>> @@ -4931,7 +4931,8 @@ int btrfs_get_free_objectid(struct btrfs_root *r=
oot, u64 *objectid)
>>>   		goto out;
>>>   	}
>>>
>>> -	*objectid =3D root->free_objectid++;
>>> +	while (find_qgroup_rb(root->fs_info, root->free_objectid++));
>>> +	*objectid =3D root->free_objectid;
>>
>> This looks buggy to me.  Let's say that free_objectid is currently 3.
>>
>> Before, it would assign 3 to *objectid, and increment free_objectid to
>> 4.  After (assuming the loop terminates on first iteration), it will
>> increment free_objectid to 4, then assign 4 to *objectid.
>>
>> I think you meant to write:
>>
>> 	while (find_qgroup_rb(root->fs_info, root->free_objectid))
>> 		root->free_objectid++;
>> 	*objectid =3D root->free_objectid++;
> Yes, your guess is correct.
>>
>> And the lesson here is that more compact code is not necessarily more
>> correct code.
>>
>> (I'm not making any judgement about whether this is the correct fix;
>> I don't understand btrfs well enough to have an opinion.  Just that
>> this is not an equivalent transformation)
> I don't have much knowledge about btrfs too, but one thing is clear: the=
 qgroupid
> taken by create_snapshot() is calculated from btrfs_get_free_ojectid().
> At the same time, when calculating the new value in btrfs_get_free_oject=
id(),
> it is clearly unreasonable to not determine whether the new value exists=
 in the
> qgroup_tree tree.

Nope, it's totally wrong.

Qgroupid is bound to subvolumeid, thus getting a different id for
qgroupid is going to screw the whole thing up.

> Perhaps there are other methods to obtain a new qgroupid, but before obt=
aining
> a new value, it is necessary to perform a duplicate value judgment on qg=
roup_tree,
> otherwise similar problems may still occur.

If you don't really understand the context, the fix is never going to be
correct.

Thanks,
Qu

>
> edward
>
>

