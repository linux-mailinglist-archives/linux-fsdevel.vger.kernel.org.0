Return-Path: <linux-fsdevel+bounces-78269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MGSxHjmznWnURAQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-78269-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:18:33 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 645F918848B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 15:18:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id CB914300CA03
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Feb 2026 14:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A84653A0B0B;
	Tue, 24 Feb 2026 14:18:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g/TffYWs"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DACDF3A0B15
	for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 14:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771942709; cv=none; b=FGTblMAirieJnsgRA8NbH4ae23QQLxX7EW7hD2gArc5DCEesYlk8mnHXYJn6Hzt6zntPDxMifZRbKC8mzxx7yzQGkr/RnO3D3UzORIKKLP3YWjnceeZbrLLs9+w7FEaSpefbONPDEP04twuBjxSHPZuc+wyzSXUS5UQPxUE+ZWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771942709; c=relaxed/simple;
	bh=0TxTDl2lrLDsbD5QUSluMw2fVmi1ZPNluR3giiYMUO4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZcWFDteZw4wGKXCup3+ul1WLYexBfYTdr17H1mjGD60yHQG5fpUt7SjtRhkpcgSK8Z2jKyPOnLAARxRDaJvpAIyDtjfosc/nGO6FN5PYB9cjHQrMLhaVeQEllBY7ckLsSwMT6Hk2tdqq7K6pV+ggKytuFclP6dTSA22yaCqUU9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g/TffYWs; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-797d509a2f5so58171187b3.2
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Feb 2026 06:18:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771942706; x=1772547506; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=l9xsUkOTHtro2f+9uCqA1Js6DrK/S57FLQU4jKd9aLg=;
        b=g/TffYWsQqvkYdIaruN4HNXAelKHiuPJ7Y19o2XFS2rxClkpkR/0abX/AR52QnvYUt
         JrXiQnVcR9x+HKLFEA3VsyvhdrNgnCUAnTb2LCbwILVdRr4Mi2AIwc6xVSa2cwTsRhwo
         vW+XRmwrG2byumTGcp1FG6QxM4EJYXOotzzEJz+BNeaN1q48Kuvv5Q9eyACYU3diib86
         4+aQRj8iRO2eCxj0ZmzjJ1QUQv4xsLAlasgLiggFRGuq4NxDccYk0xBov2KC6cICiHvZ
         C22b070FAWAd6KzFXDtVL6Hgh7pzmqOn71QE50rtQnQAx1rY1GFB22tx6vYMTfwaAdOw
         /YEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771942706; x=1772547506;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9xsUkOTHtro2f+9uCqA1Js6DrK/S57FLQU4jKd9aLg=;
        b=cQBujN94mUTUIaYo2UvSz0s6F5gpH7gBDpY79HFz3r4hN50pM3cR/LZITJn5ZqnCcO
         9RLVc6nR0nw6UXCCpNJtkhFGojuvYBlgAHTit8mcb7eJJcVz9g5/KhhTC63MPXY9tvS+
         67mc17k0kDFdCZqy3VJbC39yWlj73gxitUhMDcJ8GPBqh9fFctgKUMRjXcBAVJIOANRu
         FHUr3B7MT4CwJvHA/A6e1d69Tt4ogx13LU1+wgXsQwodj88wldWj3Yt+gH10FvtsiOaw
         VlcNU96FHpJimkJ2rf8D+89ggeF3PLga/iJFqEkz03wyG+4UcIS22npcTduXK3S7Eiur
         pMhg==
X-Forwarded-Encrypted: i=1; AJvYcCWQKPoRMW3A0bxVAF8dWw2Hj9lBcUFmmcmBl5ZJ/+rPxggPPTGn+x+CHCeJJXtlKWwaSIoCD8L0HlTOhqbN@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxp+Q5xf+OYghjgoIWRpV7jAW1+8WP/mM0eHtEK2MuqPgjwisb
	I3BmvIJu/IO5jgFoNFTe/Ny3b8JySQyk3yy2afhl8CEsoPiyHlWg30xA
X-Gm-Gg: ATEYQzx9p7+2Ex3ZaMcx7H2NZ44qpLGiRwU4HoTGBFzFSBK26GhfsmeQW2fwdwr23V1
	7cAWMTaCY1vkKcaurYjr2uijPhn6R57U7+XpN2Kjt/h84wwyKN8/9NaDI3Zs9r+KKx3ZU8IRH08
	aAwhXmBVOHbF6LAZK5TGp/BxYbsPBQ9yIxz1y0aGguxmXuzwuxRs+YnhOW/nYAviVS8/A6NhMTA
	/tooWIQ2jw6EtozIMgzzy8n825/1g1PDn7gSFdeX31BEEtzuMpOjmybDfHred+lrATwnYfD45tC
	EC4Xf7V6lgOfUhRU8oFogJp3T0C2dWrQAHAIXK+DSD93yWI4u5YkULz9yO3pnjJaSqieShQ/813
	xgKOvr3gjhAwQOfSi0B6eXl8Z+4sdZmOd8jUrGnZ5XX27gfagTeXJa/3OMlvFFmrk22Uo7R+z4L
	jueB4xwz+6wzbATahl8kPRMPj71bF+P/v8bcVNCUdOUZnQoCM0k2YgViy5mZmN4/bEPgBup7bGV
	/3nz4tmaSXLlLVaY/42MXyumi1z4v9PZqEQyybGNw==
X-Received: by 2002:a05:690c:389:b0:798:5333:ce1c with SMTP id 00721157ae682-7985333d2e4mr37829407b3.23.1771942705443;
        Tue, 24 Feb 2026 06:18:25 -0800 (PST)
Received: from [10.138.34.110] (h69-131-216-128.cncrtn.broadband.dynamic.tds.net. [69.131.216.128])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7982ddd5096sm44365387b3.45.2026.02.24.06.18.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Feb 2026 06:18:24 -0800 (PST)
Message-ID: <3cc6a84f-2f97-49e8-909a-ea69f9a97fb0@gmail.com>
Date: Tue, 24 Feb 2026 09:18:21 -0500
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stgraber@stgraber.org, ksugihara@preferred.jp, utam0k@preferred.jp,
 trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org,
 chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz,
 amir73il@gmail.com, trapexit@spawn.link
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <980c04e5-5685-43a2-a4fb-9d3a842205aa@gmail.com>
 <20260224-bannen-waldlauf-481ad13899a9@brauner>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20260224-bannen-waldlauf-481ad13899a9@brauner>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------ZBOxjPdGeppIf0xTZW02I8AV"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.16 / 15.00];
	SIGNED_PGP(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MIME_GOOD(-0.20)[multipart/signed,multipart/mixed,text/plain];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_UNKNOWN(0.10)[application/pgp-keys];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[mihalicyn.com,lists.linux-foundation.org,futurfusion.io,vger.kernel.org,stgraber.org,preferred.jp,kernel.org,oracle.com,suse.de,szeredi.hu,suse.cz,gmail.com,spawn.link];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-78269-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+,3:+,4:~,5:~];
	RCPT_COUNT_TWELVE(0.00)[18];
	HAS_ATTACHMENT(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[demiobenour@gmail.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 645F918848B
X-Rspamd-Action: no action

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------ZBOxjPdGeppIf0xTZW02I8AV
Content-Type: multipart/mixed; boundary="------------DHdHBd0JoD1R6rsulBgClsnm";
 protected-headers="v1"
Message-ID: <3cc6a84f-2f97-49e8-909a-ea69f9a97fb0@gmail.com>
Date: Tue, 24 Feb 2026 09:18:21 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [LSF/MM/BPF TOPIC] VFS idmappings support in NFS
To: Christian Brauner <brauner@kernel.org>
Cc: Alexander Mikhalitsyn <alexander@mihalicyn.com>,
 lsf-pc@lists.linux-foundation.org, aleksandr.mikhalitsyn@futurfusion.io,
 linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
 stgraber@stgraber.org, ksugihara@preferred.jp, utam0k@preferred.jp,
 trondmy@kernel.org, anna@kernel.org, jlayton@kernel.org,
 chuck.lever@oracle.com, neilb@suse.de, miklos@szeredi.hu, jack@suse.cz,
 amir73il@gmail.com, trapexit@spawn.link
References: <65a53a2d6fcc053edeed688a8c8d580c03bd6f3b.camel@mihalicyn.com>
 <980c04e5-5685-43a2-a4fb-9d3a842205aa@gmail.com>
 <20260224-bannen-waldlauf-481ad13899a9@brauner>
Content-Language: en-US
From: Demi Marie Obenour <demiobenour@gmail.com>
Autocrypt: addr=demiobenour@gmail.com; keydata=
 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
 +MYSfkEjBz0E8CLOcAw7JIwAaeBT
In-Reply-To: <20260224-bannen-waldlauf-481ad13899a9@brauner>

--------------DHdHBd0JoD1R6rsulBgClsnm
Content-Type: multipart/mixed; boundary="------------msZf2pG7qy90pfPr66aDc5S1"

--------------msZf2pG7qy90pfPr66aDc5S1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On 2/24/26 03:54, Christian Brauner wrote:
> On Sat, Feb 21, 2026 at 01:44:26AM -0500, Demi Marie Obenour wrote:
>> On 2/18/26 07:44, Alexander Mikhalitsyn wrote:
>>> Dear friends,
>>>
>>> I would like to propose "VFS idmappings support in NFS" as a topic fo=
r discussion at the LSF/MM/BPF Summit.
>>>
>>> Previously, I worked on VFS idmap support for FUSE/virtiofs [2] and c=
ephfs [1] with support/guidance
>>> from Christian.
>>>
>>> This experience with Cephfs & FUSE has shown that VFS idmap semantics=
, while being very elegant and
>>> intuitive for local filesystems, can be quite challenging to combine =
with network/network-like (e.g. FUSE)
>>> FSes. In case of Cephfs we had to modify its protocol (!) (see [2]) a=
s a part of our agreement with
>>> ceph folks about the right way to support idmaps.
>>>
>>> One obstacle here was that cephfs has some features that are not very=
 Linux-wayish, I would say.
>>> In particular, system administrator can configure path-based UID/GID =
restrictions on a *server*-side (Ceph MDS).
>>> Basically, you can say "I expect UID 1000 and GID 2000 for all files =
under /stuff directory".
>>> The problem here is that these UID/GIDs are taken from a syscall-call=
er's creds (not from (struct file *)->f_cred)
>>> which makes cephfs FDs not very transferable through unix sockets. [3=
]
>>>
>>> These path-based UID/GID restrictions mean that server expects client=
 to send UID/GID with every single request,
>>> not only for those OPs where UID/GID needs to be written to the disk =
(mknod, mkdir, symlink, etc).
>>> VFS idmaps API is designed to prevent filesystems developers from mak=
ing a mistakes when supporting FS_ALLOW_IDMAP.
>>> For example, (struct mnt_idmap *) is not passed to every single i_op,=
 but instead to only those where it can be
>>> used legitimately. Particularly, readlink/listxattr or rmdir are not =
expected to use idmapping information anyhow.
>>>
>>> We've seen very similar challenges with FUSE. Not a long time ago on =
Linux Containers project forum, there
>>> was a discussion about mergerfs (a popular FUSE-based filesystem) & V=
FS idmaps [5]. And I see that this problem
>>> of "caller UID/GID are needed everywhere" still blocks VFS idmaps ado=
ption in some usecases.
>>> Antonio Musumeci (mergerfs maintainer) claimed that in many cases fil=
esystems behind mergerfs may not be fully
>>> POSIX and basically, when mergerfs does IO on the underlying FSes it =
needs to do UID/GID switch to caller's UID/GID
>>> (taken from FUSE request header).
>>>
>>> We don't expect NFS to be any simpler :-) I would say that supporting=
 NFS is a final boss. It would be great
>>> to have a deep technical discussion with VFS/FSes maintainers and dev=
elopers about all these challenges and
>>> make some conclusions and identify a right direction/approach to thes=
e problems. From my side, I'm going
>>> to get more familiar with high-level part of NFS (or even make PoC if=
 time permits), identify challenges,
>>> summarize everything and prepare some slides to navigate/plan discuss=
ion.
>>>
>>> [1] cephfs https://lore.kernel.org/linux-fsdevel/20230807132626.18210=
1-1-aleksandr.mikhalitsyn@canonical.com
>>> [2] cephfs protocol changes https://github.com/ceph/ceph/pull/52575
>>> [3] cephfs & f_cred https://lore.kernel.org/lkml/CAEivzxeZ6fDgYMnjk21=
qXYz13tHqZa8rP-cZ2jdxkY0eX+dOjw@mail.gmail.com/
>>> [4] fuse/virtiofs https://lore.kernel.org/linux-fsdevel/2024090315162=
6.264609-1-aleksandr.mikhalitsyn@canonical.com/
>>> [5]
>>> mergerfshttps://discuss.linuxcontainers.org/t/is-it-the-case-that-you=
-cannot-use-shift-true-for-disk-devices-where-the-source-is-a-mergerfs-mo=
unt-is-there-a-workaround/25336/11?u=3Damikhalitsyn
>>>
>>> Kind regards,
>>> Alexander Mikhalitsyn @ futurfusion.io
>>
>> The secure case (strong authentication) has similar problems to
>> In both cases, there is no way to store the files with the UID/GID/etc=

>=20
> It's easy to support idmapped mounts without user namespaces. They're
> completely decoupled from them already for that purpose so they can
> support id squashing and so on going forward. The only thing that's
> needed is to extend the api so that we can specific mappings to be used=

> for a mount. That's not difficult and there's no need to adhere to any
> inherent limit on the number of mappings that user namespaces have.
>=20
> It's also useful indepent of all that for local filesystems that want t=
o
> expose files with different ownership at different locations without
> getting into namespaces at all.

Virtiofsd needs user namespaces to create a mount unless it runs as
real root.

>> that the VFS says they should have.  The server (NFS) or kernel
>> (virtiofsd) simply will not (and, for security reasons, *must not*)
>> allow this.
>>
>> I proposed a workaround for virtiofsd [1] that I will also propose
>> here: store the mapped UID and GID as a user.* xattr.  This requires
>=20
> xattrs as an ownership side-channel are an absolute clusterfuck. The
> kernel implementation for POSIX ACLs and filesystem capabilities that
> slap ownership information that the VFS must consume on arbitraries
> inodes should be set on fire.I've burned way too many cycles getting
> this into an even remotely acceptable shape and it still sucks to no
> end. Permission checking is a completely nightmare because we need to g=
o
> fetch stuff from disk, cache it in a global format, then do an in-place=

> translation having to parse ownership out of binary data stored
> alongside the inode.

Why is this so bad?  What would be a better way to do this?

> Nowever, if userspace wants to consume ownership information by storing=

> arbitrary ownership information as user.* xattrs then I obviously
> couldn't care less but it won't nest, performance will suck, and it wil=
l
> be brittle to get this right imho.

It can be nested by repeatedly remapping xattrs: user.o, user.o.o,
and so on.  More efficient schemes undoubtedly exist.

Is there a better solution?  The only one I can think of is to include
subordinate UIDs/GIDs in Kerberos tickets, and that fails when the
product of (total users in an installation * number of subordinate
UIDs/GIDs per user) approaches 2^32.  This can happen if both are
65536.

I did suggest replacing UIDs and GIDs with NT-style SIDs, but that
is an absolutely enormous change across the entire system.
--=20
Sincerely,
Demi Marie Obenour (she/her/hers)
--------------msZf2pG7qy90pfPr66aDc5S1
Content-Type: application/pgp-keys; name="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB288B55FFF9C22C1.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xsFNBFp+A0oBEADffj6anl9/BHhUSxGTICeVl2tob7hPDdhHNgPR4C8xlYt5q49y
B+l2nipdaq+4Gk6FZfqC825TKl7eRpUjMriwle4r3R0ydSIGcy4M6eb0IcxmuPYf
bWpr/si88QKgyGSVZ7GeNW1UnzTdhYHuFlk8dBSmB1fzhEYEk0RcJqg4AKoq6/3/
UorR+FaSuVwT7rqzGrTlscnTDlPWgRzrQ3jssesI7sZLm82E3pJSgaUoCdCOlL7M
MPCJwI8JpPlBedRpe9tfVyfu3euTPLPxwcV3L/cfWPGSL4PofBtB8NUU6QwYiQ9H
zx4xOyn67zW73/G0Q2vPPRst8LBDqlxLjbtx/WLR6h3nBc3eyuZ+q62HS1pJ5EvU
T1vjyJ1ySrqtUXWQ4XlZyoEFUfpJxJoN0A9HCxmHGVckzTRl5FMWo8TCniHynNXs
BtDQbabt7aNEOaAJdE7to0AH3T/Bvwzcp0ZJtBk0EM6YeMLtotUut7h2Bkg1b//r
6bTBswMBXVJ5H44Qf0+eKeUg7whSC9qpYOzzrm7+0r9F5u3qF8ZTx55TJc2g656C
9a1P1MYVysLvkLvS4H+crmxA/i08Tc1h+x9RRvqba4lSzZ6/Tmt60DPM5Sc4R0nS
m9BBff0Nm0bSNRS8InXdO1Aq3362QKX2NOwcL5YaStwODNyZUqF7izjK4QARAQAB
zTxEZW1pIE9iZW5vdXIgKElUTCBFbWFpbCBLZXkpIDxhdGhlbmFAaW52aXNpYmxl
dGhpbmdzbGFiLmNvbT7CwY4EEwEIADgWIQR2h02fEza6IlkHHHGyiLVf/5wiwQUC
X6YJvQIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRCyiLVf/5wiwWRhD/0Y
R+YYC5Kduv/2LBgQJIygMsFiRHbR4+tWXuTFqgrxxFSlMktZ6gQrQCWe38WnOXkB
oY6n/5lSJdfnuGd2UagZ/9dkaGMUkqt+5WshLFly4BnP7pSsWReKgMP7etRTwn3S
zk1OwFx2lzY1EnnconPLfPBc6rWG2moA6l0WX+3WNR1B1ndqpl2hPSjT2jUCBWDV
rGOUSX7r5f1WgtBeNYnEXPBCUUM51pFGESmfHIXQrqFDA7nBNiIVFDJTmQzuEqIy
Jl67pKNgooij5mKzRhFKHfjLRAH4mmWZlB9UjDStAfFBAoDFHwd1HL5VQCNQdqEc
/9lZDApqWuCPadZN+pGouqLysesIYsNxUhJ7dtWOWHl0vs7/3qkWmWun/2uOJMQh
ra2u8nA9g91FbOobWqjrDd6x3ZJoGQf4zLqjmn/P514gb697788e573WN/MpQ5XI
Fl7aM2d6/GJiq6LC9T2gSUW4rbPBiqOCeiUx7Kd/sVm41p9TOA7fEG4bYddCfDsN
xaQJH6VRK3NOuBUGeL+iQEVF5Xs6Yp+U+jwvv2M5Lel3EqAYo5xXTx4ls0xaxDCu
fudcAh8CMMqx3fguSb7Mi31WlnZpk0fDuWQVNKyDP7lYpwc4nCCGNKCj622ZSocH
AcQmX28L8pJdLYacv9pU3jPy4fHcQYvmTavTqowGnM08RGVtaSBNYXJpZSBPYmVu
b3VyIChsb3ZlciBvZiBjb2RpbmcpIDxkZW1pb2Jlbm91ckBnbWFpbC5jb20+wsF4
BBMBAgAiBQJafgNKAhsDBgsJCAcDAgYVCAIJCgsEFgIDAQIeAQIXgAAKCRCyiLVf
/5wiwYa/EACv8a2+MMou9cSCNoZBQaU+fTmyzft9hUE+0d5W2UY1RY3OsjFIzm9R
/4SVccfsqOYLEo+S0vQMIIIqFEq3FCpXXwPzyimotps05VA8U3Bd7yseojFygOgK
sAMOAee2RCaDDOnoJue01dfZMzzHPO/TVdp3OvnpWipfv5G1Xg96rwbhMLE3tg6N
xwAHa31Bv4/Xq8CJOoIWvx6fcmZQpz01/lSvsYn0KrfEbTKkuUf0vM9JrCTCP2oz
VNN5BYzqaq2M4r+jmSyeXLim922VOWqGkUEQ85BSEemqrRS06IU6NtEMsF8EWt/b
hWjk/9GDKTcnpdJHTrMxTspExBiNrvpI2t+YPU5B/dJJAUxvmhFrbSIbdB8umBZs
I3AMYrEmpAbh5x7jEjoskUC7uN3o9vpg1oCLS2ePDLtAtyBtbHnkA4xGD7ar8mem
xpH9lY/i+sC6CyyIUWcUDnnagKyJP0m9ks0GLsTeOCA0bft2XA6rD6aaCnMUsndT
ctrab42CV5XypjmC4U1rPJ8JQJUh1/3P48/8sMH+3krxpJ06KNWNFaUbaMTGiltZ
7x9DngklSYrX0T+2G4kVXNmjaljwkoLahwLla2gUWwBSyofXdqyhQdwZsp01KXNQ
UCyT/Pg+aDcm/E7OMV3d4lf7g/CSxiX2GSEe6BlhSz+Lmd7ZJ3g32M1ARGVtaSBN
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
EtJuZYM5blWncBOJCoWMnBEcTEo/viU3GgcVRw=3D=3D
=3Dx94R
-----END PGP PUBLIC KEY BLOCK-----

--------------msZf2pG7qy90pfPr66aDc5S1--

--------------DHdHBd0JoD1R6rsulBgClsnm--

--------------ZBOxjPdGeppIf0xTZW02I8AV
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEopQtqVJW1aeuo9/sszaHOrMp8lMFAmmdsy0ACgkQszaHOrMp
8lP4iQ//QuOVAktg0TdVZFjZTfsPUTipE0qmZW81+u3vjM5lzTc9rcNdUK9xZs4w
wgU6Yjz1QecWc2JTNjqlGs3uE40ENLS6HvAOlEJ+ALLgH4I1ddXZ9UJBJ57/4Iue
9cpA697dXLICFGhFnJSk9xhvOik/Zy6gLQULK/0cIGEQ3JhNGhZ9eNX93P2bQtH3
pDvd54w6BezKwHRpkESvWv7s3Y9Y5q2X/1mGs7zuVqV7/7yEh8FWo8TePMrZvwPW
IxFCo7pLKxkL7Xgt/WoGkxh1fpan5Oj/vuDVI2MjW1FJWVmkj290CdGV6ZGrMwqO
jOnGde7kqeUvGlxmyBxp1hgryDBoJdP+oejTc9YanqlJE9xs/ooRRKqcyzeDMqTr
viLn/XeDhpoP0Fcx2pB1J+CFrZeyIitTMYWejXtLzhACMfxYGMDeki2wxQTj+crJ
Tq/S8SLNru9Ix4UzjhO7+zHfUwVfofwItZr1FzcjVJOz2VNoTgDZc4Q3q6pKtL7a
fGRNm7gtZ2cfJ868UYvpWRyny82ILmL7kcFd9lQtmlYgrKiwTBJ03dPW35zAJYmI
zGvC81Wo8yHW5MYY68aFxbtUCbZdwJjXn6UIsewz1UPGCVLNVD7X5Rc6U/nHgvF8
V+d1SXjKal2KCv2vg/tZN3aItrvfkxqQ3st+P4Tcry9eBEbaRX4=
=z08Q
-----END PGP SIGNATURE-----

--------------ZBOxjPdGeppIf0xTZW02I8AV--

