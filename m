Return-Path: <linux-fsdevel+bounces-1984-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4204C7E134A
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 13:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B537CB20DC9
	for <lists+linux-fsdevel@lfdr.de>; Sun,  5 Nov 2023 12:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4EAFBA39;
	Sun,  5 Nov 2023 12:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F82vozot"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60E8BA29
	for <linux-fsdevel@vger.kernel.org>; Sun,  5 Nov 2023 12:06:06 +0000 (UTC)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EB8B3;
	Sun,  5 Nov 2023 04:06:05 -0800 (PST)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-577fff1cae6so2604074a12.1;
        Sun, 05 Nov 2023 04:06:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699185965; x=1699790765; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+w1i/v4UPAlhIXRslgzOpEs80WLFkJ6aHgRVZH/4zw=;
        b=F82vozotLuqi74qPR5n6AEqLCaHSwLbbePfUnFwPZZuvINqPFthsy+ps7fw7HVvwSL
         0d+051MpinuuEEORV2zzZ6N2XSX6I3q0q94uPLKto7tpP/6i/nBld53vGtPGEncS+x2q
         piQUojaHGdFX1YOfFPui8NHX+lIgScQdwhdyZBweaL9JoffFfX+nMQJS83SWBvG3VQQ1
         EC1z+ksOAratQNOvmxJDheRnQtfs5EoF+KkcjBFfCxIdwIUh6LoBzByRHwVcIlWR3EGz
         HWXtXa/dKQD/v7FvyDLzT8WDe3yLpV0AUnTjIdAwIC0zMu9LlcmWQPT35RtsVw25EETq
         yTig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699185965; x=1699790765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M+w1i/v4UPAlhIXRslgzOpEs80WLFkJ6aHgRVZH/4zw=;
        b=K010BBSuBG6jDcuQj444sxCd/gW2Oh5NI5mw0awkb7pQRP2nmtt7V5q89yECMJZzA/
         Moonxbl1VkfT5jCBHyCjWG2bGSQA8RI/ed9J9nrHuSaoccXygZLZn7sSSgqNjYVHAMhn
         wWr8Qb+BwhOiVdQFHl54TRc8sngRHL8AvVBt8ATLBzl1w6o+pXEb39MwCrsqit0XgtR6
         qzGHXdre9mwUhuK9f6UD9de/T+KIXP2AURfEquo/BK2NRQExPslyCFrd7bMN/zACsnAT
         nuaIoCcOgHtPbqXU1UIsuxiLNng3JJ9dQs1LfNBBRNqjW23ecT+l/N46jmc6AtN857iS
         WcaA==
X-Gm-Message-State: AOJu0YyIRtO2gjub5VLRvELKoi9sBAi7ofSriXT3wCF/wxFCq1JizMdc
	jweoF3oyHGT2qQLCHS6kmlo=
X-Google-Smtp-Source: AGHT+IF7bzDwjE0oCGRcQJFFTvTNsEghZKz9FfL+rhj07x366ieY+HVKRDzZ6kvz+pwFJ5PwscU+XA==
X-Received: by 2002:a05:6a20:9390:b0:159:e4ab:15ce with SMTP id x16-20020a056a20939000b00159e4ab15cemr11886756pzh.15.1699185964567;
        Sun, 05 Nov 2023 04:06:04 -0800 (PST)
Received: from debian.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id x16-20020aa793b0000000b006c344c9f8bfsm3989561pff.87.2023.11.05.04.06.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Nov 2023 04:06:03 -0800 (PST)
Received: by debian.me (Postfix, from userid 1000)
	id 276A08BA2876; Sun,  5 Nov 2023 19:05:57 +0700 (WIB)
Date: Sun, 5 Nov 2023 19:05:57 +0700
From: Bagas Sanjaya <bagasdotme@gmail.com>
To: Donald Buczek <buczek@molgen.mpg.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Filesystems Development <linux-fsdevel@vger.kernel.org>,
	Linux NFS <linux-nfs@vger.kernel.org>,
	Linux RAID <linux-raid@vger.kernel.org>,
	Linux XFS <linux-xfs@vger.kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>,
	Neil Brown <neilb@suse.de>, Olga Kornievskaia <kolga@netapp.com>,
	Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>,
	Song Liu <song@kernel.org>,
	Chandan Babu R <chandan.babu@oracle.com>,
	Darrick J. Wong <djwong@kernel.org>
Subject: Re: Heisenbug: I/O freeze can be resolved by cat $task/cmdline of
 unrelated process
Message-ID: <ZUeFJbEjlcRQfXkA@debian.me>
References: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="ccKSW1Z806xRUPUW"
Content-Disposition: inline
In-Reply-To: <77184fcc-46ab-4d69-b163-368264fa49f7@molgen.mpg.de>


--ccKSW1Z806xRUPUW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 05, 2023 at 10:40:02AM +0100, Donald Buczek wrote:
> Hello, experts,
>=20
> we have a strange new problem on a backup server (high metadata I/O 24/7,=
 xfs -> mdraid). The system worked for years and with v5.15.86 for 8 month.=
 Then we've updated to 6.1.52 and after a few hours it froze: No more I/O a=
ctivity to one of its filesystems, processes trying to access it blocked un=
til we reboot.
>=20
> Of course, at first we blamed the kernel as this happened after an upgrad=
e. But after several experiments with different kernel versions, we've retu=
rned to the v5.15.86 kernel we used before, but still experienced the probl=
em. Then we suspected, that a microcode update (for AMD EPYC 7261), which h=
appened as a side effect of the first reboot, might be the culprit and remo=
ved it. That didn't fix it either. For all I can say, all software is back =
to the state which worked before.
>=20

By what?

> Now the strange part: What we usually do, when we have a situation like t=
his, is that we run a script which takes several procfs and sysfs informati=
on which happened to be useful in the past. It was soon discovered, that ju=
st running this script unblocks the system. I/O continues as if nothing eve=
r happened. Then we singled-stepped the operations of the script to find ou=
t, what action exactly gets the system to resume. It is this part:
>=20
>     for task in /proc/*/task/*; do
>         echo  "# # $task: $(cat $task/comm) : $(cat $task/cmdline | xargs=
 -0 echo)"
>         cmd cat $task/stack
>     done
>=20
> which can further be reduced to
>=20
>     for task in /proc/*/task/*; do echo $task $(cat $task/cmdline | xargs=
 -0 echo); done
>=20
> This is absolutely reproducible. Above line unblocks the system reliably.
>=20
> Another remarkable thing: We've modified above code to do the processes s=
lowly one by one and checking after each step if I/O resumed. And each time=
 we've tested that, it was one of the 64 nfsd processes (but not the very f=
irst one tried). While the systems exports filesystems, we have absolutely =
no reason to assume, that any client actually tries to access this nfs serv=
er. Additionally, when the full script is run, the stack traces show all nf=
sd tasks in their normal idle state ( [<0>] svc_recv+0x7bd/0x8d0 [sunrpc] ).
>=20

What's so special with that one nfsd process?

> Does anybody have an idea, how a `cat /proc/PID/cmdline` on a specific as=
sumed-to-be-idle nfsd thread could have such an "healing" effect?
>=20
> I'm well aware, that, for example, a hardware problem might result in jus=
t anything and that the question might not be answerable at all. If so: ple=
ase excuse the noise.
>=20

Confused...

--=20
An old man doll... just what I always wanted! - Clara

--ccKSW1Z806xRUPUW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZUeFIQAKCRD2uYlJVVFO
o58qAQDAfhvqG37JAeAfcnwBbf5OYKGw9K2VBkpRFyxBx6bBwQEA58bw106D84pN
3KGluu5vI+omD5Or3jL4OoAGm63RrAo=
=xybc
-----END PGP SIGNATURE-----

--ccKSW1Z806xRUPUW--

