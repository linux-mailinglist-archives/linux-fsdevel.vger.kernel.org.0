Return-Path: <linux-fsdevel+bounces-1213-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C6D57D7857
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Oct 2023 01:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D01CC28203A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Oct 2023 23:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FD7534CF1;
	Wed, 25 Oct 2023 23:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="bUSQrAC9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF3027EFF
	for <linux-fsdevel@vger.kernel.org>; Wed, 25 Oct 2023 23:02:46 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66D56129;
	Wed, 25 Oct 2023 16:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1698274945; x=1698879745; i=quwenruo.btrfs@gmx.com;
	bh=t8QfgQrUAguQpNC3vJ8kXVDb9X8U3ZmEzWIIrF4UCEY=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=bUSQrAC9JWoDB2Xux12+hKJlkhHDHpyFNqqXf2QY0npAYeNBfkj0ZNaKpVXb+M5g
	 3daJ1cnfYwENu/bXO6/Jqm1kEcsjL82xasliEdo+r/0prOJDU+KQlXoHjEmi1WGcF
	 K8H/Yx7VcNLPvxak8zROD+WnI23maWkCnf68O3zmNcnGAYMKK1bBUcfjxOY8ww2TY
	 GLCciXmmXzkk/TyUe7hvw4+Tin8zP04gsPkvwgsZY4Ryi349XrKNsQLXryK7jTVsu
	 xlN7J0z+3H8MIA8fsDBtzwcb4CdVr9maExNKNLqc6I4pA+rLF202ThpN+aQAG1k1a
	 8FwYoJOYPRZROaFq5g==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.101] ([122.151.37.21]) by mail.gmx.net (mrgmx005
 [212.227.17.184]) with ESMTPSA (Nemesis) id 1M8ykW-1qt0wY0z8o-0067vX; Thu, 26
 Oct 2023 01:02:25 +0200
Message-ID: <628a975f-11a1-47f9-b2f8-8cbcfa812ef6@gmx.com>
Date: Thu, 26 Oct 2023 09:32:11 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] fanotify support for btrfs sub-volumes
Content-Language: en-US
To: Josef Bacik <josef@toxicpanda.com>, Christoph Hellwig <hch@infradead.org>
Cc: Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
 Christian Brauner <brauner@kernel.org>, Chris Mason <clm@fb.com>,
 David Sterba <dsterba@suse.com>, linux-btrfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org> <20231025210654.GA2892534@perftesting>
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
In-Reply-To: <20231025210654.GA2892534@perftesting>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:5rr5bfMpKbBOuNyIaKoh13Iecfs2wIsxx4DUBu+zgfzgoB42g44
 HDjgLVVI57JjWb5HFhdY7r+nbUgDfeNenSQr47GNpJP5yafylEzDGO+IjyDNwRuNLd5RW+b
 ydDnJZNjbfMXHu7Np+NKZ2N0IrSyY04BdalxSaf25ph5iVb+9ydIKyZo5SoQ7X9ZfYRMEl4
 k4SKNuZD2Gmn942O+sFpQ==
UI-OutboundReport: notjunk:1;M01:P0:GMcuwDytY+w=;EqthME9VjzB69SNlV8u1l8FbAGf
 S8fY9U4OMP0hE+0VCQRlPyERiuITFU9h113P0aZ3gvbEaSAtORi+TLjjUSISAz44VqweuR3e8
 b79NJOL09C/s7yeH6d/hFto2GMei90srgb0IHsNdIb7Ry7SkJv7cHjaOvFjUd7efenaF5z8fL
 O9yqj79n1Xc23PvTEDLZxawWnebS6FXbA+b/YvDATKDNoXzMMg09u+wjp6N/0QI5hspAa0KR2
 JgLkD55ydcNPyHYLvyydUKbilARnh4BSoiTL9Tb/FOmACnJjz2WCgQjAA0wuyY+rVDdA5n928
 gALmfPHY9us95PDDJdVBlf+5C7QMaMobMdwOFOel3Rhrh3iaokGHjziaKJYBk+1AieoTuLcbf
 NMYhXDUnbBAjm2/UL0rtXVbFHCb4t88DZSmT39CAqKRUmmhdTPvYix3/nGywTlnSLWW3XeV4a
 AnkduZ7JGwEI4WwCTYr+k0EEenhhVnzN68SJOTji+4gvs/Id44nHkQtQgNK7YFhKNJB2L4HNb
 OxOrXBo+it2fvuM9YL3LpLt/xVWVaCN00wW1n9TRvzACKwLYT3clw4dN5PHe5xlAw7GvYZzcl
 Q+XcRalJDKTMXOTPta+UAMO5gHYNYkfKjHZwboaKSw/sd1yUB/qiSJoD7K6ZBS029cVt1/tCw
 PQRlSLTJw0GF6SAT8CkSIOoefUUoFrJlXhi3pWl+9Jn8kfiK2nhpnJMNuzRJkz2TWRhGL4Q0N
 ETsaKwolQb8VTo6hyvOYq25vj88GszKEG4PvzOnyh+DWkRzhLjWHHOa0m65zsNhrFmQNLT1Z6
 /TRTF/bKDw8LOE4WUgqLxp/fAqfT23saXVC0lT7mTejVNyJiKm5+ub6jMRn5aqybZqXS74oSO
 I/V4LEny/VX3pzbh2ulPO+94nIELyARRP8hAVdSk+2MBZLVGqoZFRHG7rwZ968ck4MAeXr2yL
 89id1b3vpU667d2FyfdVJKi++qI=



On 2023/10/26 07:36, Josef Bacik wrote:
> On Wed, Oct 25, 2023 at 08:34:21AM -0700, Christoph Hellwig wrote:
>> On Wed, Oct 25, 2023 at 04:50:45PM +0300, Amir Goldstein wrote:
>>> Jan,
>>>
>>> This patch set implements your suggestion [1] for handling fanotify
>>> events for filesystems with non-uniform f_fsid.
>>
>> File systems nust never report non-uniform fsids (or st_dev) for that
>> matter.  btrfs is simply broken here and needs to be fixed.
>
> We keep going around and around on this so I'd like to get a set of step=
s laid
> out for us to work towards to resolve this once and for all.
>
> HYSTERICAL RAISINS (why we do st_dev)
> -------------------------------------
>
> Chris made this decision forever ago because things like rsync would scr=
ew up
> with snapshots and end up backing up the same thing over and over again.=
  We saw
> it was using st_dev (as were a few other standard tools) to distinguish =
between
> file systems, so we abused this to make userspace happy.
>
> The other nice thing this provided was a solution for the fact that we r=
e-use
> inode numbers in the file system, as they're unique for the subvolume on=
ly.
>
> PROBLEMS WE WANT TO SOLVE
> -------------------------
>
> 1) Stop abusing st_dev.  We actually want this as btrfs developers becau=
se it's
>     kind of annoying to figure out which device is mounted when st_dev d=
oesn't
>     map to any of the devices in /proc/mounts.
>
> 2) Give user space a way to tell it's on a subvolume, so it can not be c=
onfused
>     by the repeating inode numbers.
>
> POSSIBLE SOLUTIONS
> ------------------
>
> 1) A statx field for subvolume id.  The subvolume id's are unique to the=
 file
>     system, so subvolume id + inode number is unique to the file system.=
  This is
>     a u64, so is nice and easy to export through statx.
> 2) A statx field for the uuid/fsid of the file system.  I'd like this be=
cause
>     again, being able to easily stat a couple of files and tell they're =
on the
>     same file system is a valuable thing.  We have a per-fs uuid that we=
 can
>     export here.
> 3) A statx field for the uuid of the subvolume.  Our subvolumes have the=
ir own
>     unique uuid.  This could be an alternative for the subvolume id opti=
on, or an
>     addition.

No need for a full UUID, just a u64 is good enough.

Although a full UUID for the subvolumes won't hurt and can reduce the
need to call the btrfs specific ioctl just to receive the UUID.


My concern is, such new members would not be utilized by any other fs,
would it cause some compatibility problem?

>
> Either 1 or 3 are necessary to give userspace a way to tell they've wand=
ered
> into a different subvolume.  I'd like to have all 3, but I recognize tha=
t may be
> wishful thinking.  2 isn't necessary, but if we're going to go about mes=
sing
> with statx then I'd like to do it all at once, and I want this for the r=
easons
> stated above.
>
> SEQUENCE OF EVENTS
> ------------------
>
> We do one of the statx changes, that rolls into a real kernel.  We run a=
round
> and submit patches for rsync and anything else we can think of to take a=
dvantage
> of the statx feature.

My main concern is, how older programs could handle this? Like programs
utilizing stat() only, and for whatever reasons they don't bother to add
statx() support.
(Can vary from lack of maintenance to weird compatibility reasons)

Thus we still need such st_dev hack, until there is no real world
programs utilizing vanilla stat() only.
(Which everyone knows it's impossible)

Thanks,
Qu
>
> Then we wait, call it 2 kernel releases after the initial release.  Then=
 we go
> and rip out the dev_t hack. >
> Does this sound like a reasonable path forward to resolve everybody's co=
ncerns?
> I feel like I'm missing some other argument here, but I'm currently on v=
acation
> and can't think of what it is nor have the energy to go look it up at th=
e
> moment.  Thanks,
>
> Josef

