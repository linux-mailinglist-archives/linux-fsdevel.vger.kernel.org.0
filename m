Return-Path: <linux-fsdevel+bounces-39443-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B3CB1A143BC
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 22:09:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5BE168158
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 Jan 2025 21:09:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E805219E97C;
	Thu, 16 Jan 2025 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b="TxKIadWS"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D581E18B464
	for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jan 2025 21:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.17.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737061762; cv=none; b=sKc9+YtStjlvibA+gtuCoN1HTS68ORKdjVnnmXz3yr00x97uqs6dL1KPtVlx23GuykBCt9HB/IgdmstvHfI5mDx4L1YYP7jExsdKr4V6aY50Bg5zC5SC8zZ3966ktBZD8R3ZImkaLG1cuYEU3BBrVLXdFq6Y5SlKesIsVqPkj+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737061762; c=relaxed/simple;
	bh=AdaGm0RD/ZKmpXz4JNADVF8EwqDJHk3KMyCJglTlExw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bfgzsMxXhlP7kGnVLa1KWIbi07I5cf/zeIwFhGwmdeF8jNS9D4sAJ8fvEWcEm7PrgSk3LYg7l6SZzFyozlGdRUOdErx1OaMDqhGY49lPfPT1H3P9iJkaqKQnrmmU2kmsRjSxOqPowav+TdQErif2wxpPcaiT/cey7EQ8r8dJ0eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com; spf=pass smtp.mailfrom=gmx.com; dkim=pass (2048-bit key) header.d=gmx.com header.i=quwenruo.btrfs@gmx.com header.b=TxKIadWS; arc=none smtp.client-ip=212.227.17.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.com;
	s=s31663417; t=1737061753; x=1737666553; i=quwenruo.btrfs@gmx.com;
	bh=0g6F5ZIZOVT/PDcwH7raGOdtADPE4z6Fv+cER3+y/r0=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=TxKIadWSh43CMAMlurDls58sqLVoEH216ry65sB5p/bbwnHTyHlcX8JuuysSsMIx
	 o5eZcMQxWxZte4lOuj+ABYDHMYQeL2GF1oSO7y5JL0gk60RimQ/bHpw7fpI1ehE4P
	 OQDi0jxGcPh+jtro03/zHxiUQgbJhCS5oubUPVASurUAaUhXksZYomuUw0Pv4/8dJ
	 8JSLVPZBxvNxyvPgF1OGFRyciCoyb1z0EL2uyEtfQ/cIDSJSGZz5Sc2khCyfSaLnO
	 CSyot6jWOLoYKp9pXmJExeoRy9tWSkQRqFHmPjKTROvPPK/FlDKzyOIS3ARv6JNT1
	 Weg/omM/bMeKYupgoQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [172.16.0.191] ([159.196.52.54]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1MWAOQ-1u1ZTO3b46-00KVIz; Thu, 16
 Jan 2025 22:09:13 +0100
Message-ID: <98df4904-6b61-4ddb-8df2-706236afcd8e@gmx.com>
Date: Fri, 17 Jan 2025 07:39:09 +1030
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible bug with open between unshare(CLONE_NEWNS) calls
To: Christian Brauner <brauner@kernel.org>, Boris Burkov <boris@bur.io>
Cc: linux-fsdevel@vger.kernel.org, daan.j.demeyer@gmail.com
References: <20250115185608.GA2223535@zen.localdomain>
 <20250116-audienz-wildfremd-04dc1c71a9c3@brauner>
Content-Language: en-US
From: Qu Wenruo <quwenruo.btrfs@gmx.com>
Autocrypt: addr=quwenruo.btrfs@gmx.com; keydata=
 xsBNBFnVga8BCACyhFP3ExcTIuB73jDIBA/vSoYcTyysFQzPvez64TUSCv1SgXEByR7fju3o
 8RfaWuHCnkkea5luuTZMqfgTXrun2dqNVYDNOV6RIVrc4YuG20yhC1epnV55fJCThqij0MRL
 1NxPKXIlEdHvN0Kov3CtWA+R1iNN0RCeVun7rmOrrjBK573aWC5sgP7YsBOLK79H3tmUtz6b
 9Imuj0ZyEsa76Xg9PX9Hn2myKj1hfWGS+5og9Va4hrwQC8ipjXik6NKR5GDV+hOZkktU81G5
 gkQtGB9jOAYRs86QG/b7PtIlbd3+pppT0gaS+wvwMs8cuNG+Pu6KO1oC4jgdseFLu7NpABEB
 AAHNIlF1IFdlbnJ1byA8cXV3ZW5ydW8uYnRyZnNAZ214LmNvbT7CwJQEEwEIAD4CGwMFCwkI
 BwIGFQgJCgsCBBYCAwECHgECF4AWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1YAUJEP5a
 sQAKCRDCPZHzoSX+qF+mB/9gXu9C3BV0omDZBDWevJHxpWpOwQ8DxZEbk9b9LcrQlWdhFhyn
 xi+l5lRziV9ZGyYXp7N35a9t7GQJndMCFUWYoEa+1NCuxDs6bslfrCaGEGG/+wd6oIPb85xo
 naxnQ+SQtYLUFbU77WkUPaaIU8hH2BAfn9ZSDX9lIxheQE8ZYGGmo4wYpnN7/hSXALD7+oun
 tZljjGNT1o+/B8WVZtw/YZuCuHgZeaFdhcV2jsz7+iGb+LsqzHuznrXqbyUQgQT9kn8ZYFNW
 7tf+LNxXuwedzRag4fxtR+5GVvJ41Oh/eygp8VqiMAtnFYaSlb9sjia1Mh+m+OBFeuXjgGlG
 VvQFzsBNBFnVga8BCACqU+th4Esy/c8BnvliFAjAfpzhI1wH76FD1MJPmAhA3DnX5JDORcga
 CbPEwhLj1xlwTgpeT+QfDmGJ5B5BlrrQFZVE1fChEjiJvyiSAO4yQPkrPVYTI7Xj34FnscPj
 /IrRUUka68MlHxPtFnAHr25VIuOS41lmYKYNwPNLRz9Ik6DmeTG3WJO2BQRNvXA0pXrJH1fN
 GSsRb+pKEKHKtL1803x71zQxCwLh+zLP1iXHVM5j8gX9zqupigQR/Cel2XPS44zWcDW8r7B0
 q1eW4Jrv0x19p4P923voqn+joIAostyNTUjCeSrUdKth9jcdlam9X2DziA/DHDFfS5eq4fEv
 ABEBAAHCwHwEGAEIACYCGwwWIQQt33LlpaVbqJ2qQuHCPZHzoSX+qAUCZxF1gQUJEP5a0gAK
 CRDCPZHzoSX+qHGpB/kB8A7M7KGL5qzat+jBRoLwB0Y3Zax0QWuANVdZM3eJDlKJKJ4HKzjo
 B2Pcn4JXL2apSan2uJftaMbNQbwotvabLXkE7cPpnppnBq7iovmBw++/d8zQjLQLWInQ5kNq
 Vmi36kmq8o5c0f97QVjMryHlmSlEZ2Wwc1kURAe4lsRG2dNeAd4CAqmTw0cMIrR6R/Dpt3ma
 +8oGXJOmwWuDFKNV4G2XLKcghqrtcRf2zAGNogg3KulCykHHripG3kPKsb7fYVcSQtlt5R6v
 HZStaZBzw4PcDiaAF3pPDBd+0fIKS6BlpeNRSFG94RYrt84Qw77JWDOAZsyNfEIEE0J6LSR/
In-Reply-To: <20250116-audienz-wildfremd-04dc1c71a9c3@brauner>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:eLSHb1cxfhCb9uAXsrSKQUNIUPzJGMvEHBK6RBRVcZAPmOy08nn
 h6j7ddssVf4qO7mJMBnXeCNaM5V0lOLo/+7+tOCQ8ATchMAdzxzF2EkYX3qguRK0OVqzkfJ
 PO8XxvUe7CxZmUN1rXf3aiS+nwQFpvwd7JnvcQjQRFc4hfXiZfrvin/4y+ylSQA3di99skP
 Xz0SitU8SylUHKZzO80LA==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:dtPDH8z2zxQ=;PI3SK6D7X2icvA3phTnd74ZfYMA
 VEOLYK5C58fMOBntxH5UWv6MA0k+UPD2+4aPELXcSQNy3u5wPJJr9Q2yVRle7OKrTDfIGD9y2
 STYsK3LKlcwIG+WQQ4HR69mmrzVR/cCDFXTcyTPBBLAX85JWynAeM48VhBBoiatBfH2Zfi9mI
 8smkfWq+t29MMSXC735/JWyS+8NFA/PHcccFSNmterlOogkYS0IArr26hF6Wjk3I2voEImUhD
 g2fOQAUZPaKf93bHTT57uFITzdO0x/pfPAQ2XAFvE0ijsjiKwMk1PEEh+Uh3QvfLTaJSongF6
 ygFc0hjgCOU66ScurLWuSGZ1V00HctyHZud1NC4PFTGPRytQWwa/3htEFB4WOsE4gOjn9x418
 ivk7ceJ3K1lUu35F8EXxLINMi4sDZDh8NN/Eio+vPPkmLUWtynRDdqhLl2OQz0z6TIH30DrZ5
 XnyCrOvbZOnjEpovVpLR3cmysQ6RC9wTb6UqRjXHyAEl2eP3wJJkNL+T/+F70ygiVjozkKGWu
 iPGg3nQ74Cmp+0ANFT5KovUgiUU1iWUt83U9DzxP+CDd6LxcJKFgRjnvlfKgRM/lAYsN64qo4
 YXbGYx1FdfYVNPO5k5H0wMSQFWWLdMLVILL/znMvhxOw3yZCFHeFkoF6mF07A12xWtZeFCQ2c
 43ZvwrdgjRgC2bna+o7H2C3cuHmxkyRvcYZvaFgx0WHekMvew57ORdYzI5bZvO1darIVgap17
 qx+4ejaL9bkLoNn3/+qVXtEAtZY76tT/f5RqpMChBtwq7eMKFK5z7e6wykv5G6LZEvLKdum+n
 /kMRYC3LgKlIabTs9aKD+qAGaYus/m1KIpRNg2iWq+fhCAKscaWz6iV5eYFjfxEPMerYj4VIh
 aor0VcXZO2fh6uOMGXQg/+u8Egrve4UJORXBe/Dnh70XG/4pHALLjbix3DeR8xxKW3zc9lDbe
 jbo9yRN05WG/K02WT/Ejp/zjg53pgcL3D4bbavi40oqNv0p8m0Cr4tMhvJ1P9Z3DYqqVXVmKW
 t4EUBNsXl4hffhLShcnBuFyNywRbMyABRdKUrodHJAL/JqHLL7hiTQQoVzLd7i6Z40xS9vlFQ
 tXflHwQ67RPGfUVKffJUuRxQP9y9DzWKVqNnmJLP3TIGSstVDxa25NcixV592u8C0zM/zCZmb
 immtvn5iB+7k4ILzxVXqZ01LREjXRVZ93znzAGyXy9g==



=E5=9C=A8 2025/1/16 21:16, Christian Brauner =E5=86=99=E9=81=93:
> On Wed, Jan 15, 2025 at 10:56:08AM -0800, Boris Burkov wrote:
>> Hello,
>>
>> If we run the following C code:
>>
>> unshare(CLONE_NEWNS);
>> int fd =3D open("/dev/loop0", O_RDONLY)
>> unshare(CLONE_NEWNS);
>>
>> Then after the second unshare, the mount hierarchy created by the first
>> unshare is fully dereferenced and gets torn down, leaving the file
>> pointed to by fd with a broken dentry.
>>
>> Specifically, subsequent calls to d_path on its path resolve to
>> "/loop0". I was able to confirm this with drgn, and it has caused an
>> unexpected failure in mkosi/systemd-repart attempting to mount a btrfs
>> filesystem through such an fd, since btrfs uses d_path to resolve the
>> source device file path fully.
>>
>> I confirmed that this is definitely due to the first unshare mount
>> namespace going away by:
>> 1. printks/bpftrace the copy_root path in the kernel
>> 2. rewriting my test program to fork after the first unshare to keep
>> that namespace referenced. In this case, the fd is not broken after the
>> second unshare.
>>
>>
>> My question is:
>> Is this expected behavior with respect to mount reference counts and
>> namespace teardown?
>>
>> If I mount a filesystem and have a running program with an open file
>> descriptor in that filesystem, I would expect unmounting that filesyste=
m
>> to fail with EBUSY, so it stands to reason that the automatic unmount
>> that happens from tearing down the mount namespace of the first unshare
>> should respect similar semantics and either return EBUSY or at least
>> have the lazy umount behavior and not wreck the still referenced mount
>> objects.
>>
>> If this behavior seems like a bug to people better versed in the
>> expected behavior of namespaces, I would be happy to work on a fix.
>
> It's expected as Al already said. And is_good_dev_path()
> looks pretty hacky...
>
> Wouldn't something like:
>
> bool is_devtmpfs(const struct super_block *sb)
> {
>          return sb->s_type =3D=3D &dev_fs_type;
> }
>
> and then:
>
>          ret =3D kern_path(dev_path, 0, &path);
>          if (ret)
>                  goto out;
>
> 	if (is_devtmpfs(path->mnt->mnt_sb))
> 		// something something
>
> be enough? Or do you specifically need to care where devtmpfs is
> mounted? The current check means that anything that mounts devtmpfs
> somewhere other than /dev would fail that check.

That above checks looks good.

>
> Of course, any standard Linux distribution will mount devtmpfs at /dev
> so it probably won't matter in practice. And contains may make /dev a
> tmpfs mount and bind-mount device nodes in from the host's devtmpfs so
> that would work too with this check.
>
> In other words, I don't get why the /dev prefix check gets you anything?
> If you just verify that the device node is located on devtmpfs you
> should be good.

The original problem is that we can get very weird device path, like
'/proc/<pid>/<fd>' or any blockdev node created by the end user, as
mount source, which can cause various problems in mount_info for end users=
.

Although after v6.8 it looks like there are some other black magics
involved to prevent such block device being passed in.
I tried the same custom block device node, it always resolves to
"/dev/mapper/test-scratch1" in my case (and not even "/dev/dm-3").


However there is still another problem, related to get_canonical_dev_path(=
).

As it still goes d_path(), it will return the path inside the namespace.
Which can be very different from root namespace.

So I'm wondering if we should even bother the device path resolution at
all inside btrfs?
Or the latest fsconfig API is already resolving the path correctly?

Thanks,
Qu

