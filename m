Return-Path: <linux-fsdevel+bounces-1709-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CD7D57DDDD2
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 09:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CAB05B210A4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 08:42:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E8956AB2;
	Wed,  1 Nov 2023 08:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="BjzxwKuj"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B482446BD
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 08:42:25 +0000 (UTC)
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E46A8F4;
	Wed,  1 Nov 2023 01:42:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.com;
	s=s31663417; t=1698828120; x=1699432920; i=quwenruo.btrfs@gmx.com;
	bh=zq6Zl/mAidxoE3lDq4bcrM/fcCVvY2Dbax0/CGaHsp4=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
	 In-Reply-To;
	b=BjzxwKujjV4XqNoJWjucXS+FESGwp6MMPnBbg4UhjFIKJWmnEvZvGlSZU5FcIkvD
	 +jpU7euvSfUGcZhoqOxZbtmViHLwqjSQqZIwo+j7stLBrn1IuBjzErppH+0zNsGcu
	 LVO/jZMz/EzQKkcjAXznHRtb7Qj7rlOKTlYgMSxoBp9Al9M/yVwhtyRFtyhDtxC4B
	 mejoouu3HqhAqLrFVHtWmYFNoL3Mqh1qVQIPnjioF/uJau8SePUCtWe4Bdx0zUpRV
	 RWSAJlTrBk0OX0wF8LPUNUMXQ/i0gDk9RmHTxKgQhl6UBUWWS3EzDr28ivq8K3FCQ
	 RXAxAPX7RZYQQsA0fw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.117] ([122.151.37.21]) by mail.gmx.net (mrgmx105
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1M8QWG-1r2Wdr3GzY-004Rdz; Wed, 01
 Nov 2023 09:42:00 +0100
Message-ID: <590e421a-a209-41b6-ad96-33b3d1789643@gmx.com>
Date: Wed, 1 Nov 2023 19:11:53 +1030
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
References: <20231025135048.36153-1-amir73il@gmail.com>
 <ZTk1ffCMDe9GrJjC@infradead.org> <20231025210654.GA2892534@perftesting>
 <ZTtOmWEx5neNKkez@infradead.org> <20231027131726.GA2915471@perftesting>
 <ZT+uxSEh+nTZ2DEY@infradead.org>
 <20231031-faktor-wahlparty-5daeaf122c5e@brauner>
 <ZUDxli5HTwDP6fqu@infradead.org>
 <20231031-anorak-sammeln-8b1c4264f0db@brauner>
 <ZUE0CWQWdpGHm81L@infradead.org>
 <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
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
In-Reply-To: <20231101-nutzwert-hackbeil-bbc2fa2898ae@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RZGRlnQHQVyyyAXWSF//BMuocp53soy2+qjiRp+3n1MIanSzZ5k
 z0OUVLAmNBaxaDesJK8GGLmKyXT9FPSoMHdltd58nL2t/e9XRiynAb0E8zhdIEf+K990M5o
 yKxAeFlXx/DaYBfkI7UTt+Jv+CCtQiuklEyVarBZfRE+69+h+HvLfy+zoJLAO1t0O6eOEeb
 rCB/LsPNxdTCs0dGm/8kA==
UI-OutboundReport: notjunk:1;M01:P0:NLRpCcK+XbU=;4+r/MQ23LchZz/TA3sUBj5HRxFv
 ficKpvzkA/mKRFGtaxOF5/k1E0B9DM1dYr9d1ZvVTAjiNKtL4F0BPUTPoCaox8RDeS1Ge4ugO
 eipKzrspMFnZhJ+dNu8zKpsHea/uPpP0OX/WOBbpdljMT3258HhvB6aZ9zc4D0MFyv63vwGqD
 MsOHF17eVHHVOEiHcfqUeaiLWOgD4IwunHi7jHrXXdX581dBXKx5FiOhSbDLoj9dISMOxziO2
 1433c5ZyZvSZ58g0g5TBQ0dUC9lHLCZKJwsuebBdl4i/lrk9UPA6KmP8mRNJ7D+ajKu4U5bNx
 AgD7fxGiZKhBPIqOliU+9fQ5CYlRFsxanBye+QxSPThRuxMkk1eiu74mJYfjSYmU3hjDVMKQ+
 7piBz7FbeDVIJjhvKMo1zTydJKqv8e1GPVUFK7vRYEk6maJVwUC/GCDfxZOyVhp4EyjAEFjJ2
 6HVJ+LK9NUS9mBVM8OYazyiqZTbhKA1LXT1FwSx9yGUNHuz+n9YGBle0yLoqgCjG3qXPZQAgR
 8BqSINGk6LTfLUmwk8doi22pNiNeBv0VaeE4i+EztWZHv7uOAfcvuZK1SH3RoNhaT+21XBHew
 3srBowrngPtA4EBMM2lC0on8giYo3aSZ0p4Dr2j1pdta1J54YSLJUiQIl89SjNXcuCOe2kXiv
 zzmub42l/CUEU3qlcGK0CYRIFDY+r6bQrudiAI+pRIA0s8Es3wC3v1abZJxEvswwp7QbOQODz
 ui9eMrlIr1dbjVRE3wTfk+VxnRu64YNePUtjvRzTT8hr3EttkJKfd2CHyuQIpX7KEqgRIREZi
 u7TbUdNTO7NKvbmxfswNEXmC0ceUB6d6zgnXZn2W0PEC5f5dFqFjG7ymNSvDLY/TIyR9f0stI
 FZiLVX6zY6FW1SWGshbpNEFE4xqoaXjwnQyhWvYzKB+Kw0QxfawouzfivRIE2way8kz6i/09C
 S8alOOkVYDzPBRyxfBnP8N8UwEw=



On 2023/11/1 18:46, Christian Brauner wrote:
> On Tue, Oct 31, 2023 at 10:06:17AM -0700, Christoph Hellwig wrote:
>> On Tue, Oct 31, 2023 at 01:50:46PM +0100, Christian Brauner wrote:
>>> So this is effectively a request for:
>>>
>>> btrfs subvolume create /mnt/subvol1
>>>
>>> to create vfsmounts? IOW,
>>>
>>> mkfs.btrfs /dev/sda
>>> mount /dev/sda /mnt
>>> btrfs subvolume create /mnt/subvol1
>>> btrfs subvolume create /mnt/subvol2
>>>
>>> would create two new vfsmounts that are exposed in /proc/<pid>/mountin=
fo
>>> afterwards?
>>
>> Yes.
>>
>>> That might be odd. Because these vfsmounts aren't really mounted, no?
>>
>> Why aren't they?
>>
>>> And so you'd be showing potentially hundreds of mounts in
>>> /proc/<pid>/mountinfo that you can't unmount?
>>
>> Why would you not allow them to be unmounted?
>>
>>> And even if you treat them as mounted what would unmounting mean?
>>
>> The code in btrfs_lookup_dentry that does a hand crafted version
>> of the file system / subvolume crossing (the location.type !=3D
>> BTRFS_INODE_ITEM_KEY one) would not be executed.
>
> So today, when we do:
>
> mkfs.btrfs -f /dev/sda
> mount -t btrfs /dev/sda /mnt
> btrfs subvolume create /mnt/subvol1
> btrfs subvolume create /mnt/subvol2
>
> Then all subvolumes are always visible under /mnt.
> IOW, you can't hide them other than by overmounting or destroying them.
>
> If we make subvolumes vfsmounts then we very likely alter this behavior
> and I see two obvious options:
>
> (1) They are fake vfsmounts that can't be unmounted:
>
>      umount /mnt/subvol1 # returns -EINVAL
>
>      This retains the invariant that every subvolume is always visible
>      from the filesystems root, i.e., /mnt will include /mnt/subvol{1,}

I'd like to go this option. But I still have a question.

How do we properly unmount a btrfs?
Do we have some other way to record which subvolume is really mounted
and which is just those place holder?


>
> (2) They are proper vfsmounts:
>
>      umount /mnt/subvol1 # succeeds
>
>      This retains standard semantics for userspace about anything that
>      shows up in /proc/<pid>/mountinfo but means that after
>      umount /mnt/subvol1 succeeds, /mnt/subvol1 won't be accessible from
>      the filesystem root /mnt anymore.
>
> Both options can be made to work from a purely technical perspective,
> I'm asking which one it has to be because it isn't clear just from the
> snippets in this thread.
>
> One should also point out that if each subvolume is a vfsmount, then say
> a btrfs filesystems with 1000 subvolumes which is mounted from the root:
>
> mount -t btrfs /dev/sda /mnt
>
> could be exploded into 1000 individual mounts. Which many users might no=
t want.

Can we make it dynamic? AKA, the btrfs_insert_fs_root() is the perfect
timing here.

That would greatly reduce the initial vfsmount explode, but I'm not sure
if it's possible to add vfsmount halfway.

Thanks,
Qu
>
> So I would expect that we would need to default to mounting without
> subvolumes accessible, and a mount option to mount with all subvolumes
> mounted, idk:
>
> mount -t btrfs -o tree /dev/sda /mnt
>
> or sm.
>
> I agree that mapping subvolumes to vfsmounts sounds like the natural
> thing to do.
>
> But if we do e.g., (2) then this surely needs to be a Kconfig and/or a
> mount option to avoid breaking userspace (And I'm pretty sure that btrfs
> will end up supporting both modes almost indefinitely.).

