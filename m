Return-Path: <linux-fsdevel+bounces-38121-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEACF9FC5F3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 16:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 290201882389
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2024 15:46:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 059D815443F;
	Wed, 25 Dec 2024 15:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b="GzzwiWH1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161122619;
	Wed, 25 Dec 2024 15:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735141575; cv=none; b=uSEGXHqVAShrb8HMrpOOmrnjYpFFGTzMg8hRyu1miBLtQZgKhqo+OkQHF1R9wAayIwdUEVdaF8v3QKv49qk8jg0/yKLvYFV7cXswOW6YW2lRt2PEjEZBAy2AgoJMgqEcU15iJR1lCDH9XbfkHcfIYzMFO90s2pdK2nYDFSI4j/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735141575; c=relaxed/simple;
	bh=wTZB0wUr6Wx0D7X91KZ0JvwlyMVTBs+P+lojwH8Ndyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hrek+2sa3rrYcHRmXvPoMgPt6oT7o/n01Crl2VKIudDjWbaBdLLoSke+0fHJwGno7o3T2npixvR0SdR2Mm9DVwM1jIstCbZ44iw/KI8Xx2gexyrS7FDblyoqLNJbdFzpJxnggXRaGAdcAi5TUX/HEtSOtKxs5mcnbAmG92R1jP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com; spf=pass smtp.mailfrom=uniontech.com; dkim=pass (1024-bit key) header.d=uniontech.com header.i=@uniontech.com header.b=GzzwiWH1; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniontech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniontech.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uniontech.com;
	s=onoh2408; t=1735141538;
	bh=wTZB0wUr6Wx0D7X91KZ0JvwlyMVTBs+P+lojwH8Ndyc=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=GzzwiWH1Hj5ZHEkHxrO50Xu7i6LGMPrxt05OeTK0eGwJuMS3H5naxMO856e/0O0bh
	 2t1bbAuWbam5H7oTEF7MFSgKX3636V2FI8UXewQnIlTOS4iEocJduOYYBvkKeILoOB
	 mTJjnveNfJvKoiyz91x0P2TddhkayXF8R/THK+/s=
X-QQ-mid: bizesmtpip4t1735141367tu7h3oc
X-QQ-Originating-IP: 8My9SmBe/TPnEzR8ckSgw6NQe7hxNFe7FClbC3SSgkk=
Received: from [IPV6:240e:36c:db8:f700:b213:b0 ( [localhost])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 25 Dec 2024 23:42:34 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 16678920617421620273
Message-ID: <D7FF3455CE14824B+a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
Date: Wed, 25 Dec 2024 23:42:29 +0800
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: =?UTF-8?B?TW96aWxsYSBUaHVuZGVyYmlyZCDmtYvor5XniYg=?=
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yushengjin@uniontech.com, zhangdandan@uniontech.com,
 guanwentao@uniontech.com, zhanjun@uniontech.com, oliver.sang@intel.com,
 ebiederm@xmission.com, colin.king@canonical.com, josh@joshtriplett.org,
 penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu,
 jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org,
 jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de,
 oliver@neukum.name, dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de,
 nickpiggin@yahoo.com.au, dhowells@redhat.com, nathans@sgi.com,
 rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de, pbadari@us.ibm.com,
 ak@linux.intel.com, ak@suse.de, davem@davemloft.net, jsipek@cs.sunysb.edu,
 jens.axboe@oracle.com, ramsdell@mitre.org, hch@infradead.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 randy.dunlap@oracle.com, efault@gmx.de, rdunlap@infradead.org,
 haveblue@us.ibm.com, drepper@redhat.com, dm.n9107@gmail.com,
 jblunck@suse.de, davidel@xmailserver.org, mtk.manpages@googlemail.com,
 linux-arch@vger.kernel.org, vda.linux@googlemail.com, jmorris@namei.org,
 serue@us.ibm.com, hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org,
 tony.luck@intel.com, heiko.carstens@de.ibm.com, oleg@redhat.com,
 andi@firstfloor.org, corbet@lwn.net, crquan@gmail.com, mszeredi@suse.cz,
 miklos@szeredi.hu, peterz@infradead.org, a.p.zijlstra@chello.nl,
 earl_chew@agilent.com, npiggin@gmail.com, npiggin@suse.de, julia@diku.dk,
 jaxboe@fusionio.com, nikai@nikai.net, dchinner@redhat.com, davej@redhat.com,
 npiggin@kernel.dk, eric.dumazet@gmail.com, tim.c.chen@linux.intel.com,
 xemul@parallels.com, tj@kernel.org, serge.hallyn@canonical.com,
 gorcunov@openvz.org, levinsasha928@gmail.com, penberg@kernel.org,
 amwang@redhat.com, bcrl@kvack.org, muthu.lkml@gmail.com, muthur@gmail.com,
 mjt@tls.msk.ru, alan@lxorguk.ukuu.org.uk, raven@themaw.net, thomas@m3y3r.de,
 will.deacon@arm.com, will@kernel.org, josef@redhat.com,
 anatol.pomozov@gmail.com, koverstreet@google.com, zab@redhat.com,
 balbi@ti.com, gregkh@linuxfoundation.org, mfasheh@suse.com,
 jlbec@evilplan.org, rusty@rustcorp.com.au, asamymuthupa@micron.com,
 smani@micron.com, sbradshaw@micron.com, jmoyer@redhat.com, sim@hostway.ca,
 ia@cloudflare.com, dmonakhov@openvz.org, ebiggers3@gmail.com,
 socketpair@gmail.com, penguin-kernel@i-love.sakura.ne.jp, w@1wt.eu,
 kirill.shutemov@linux.intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
 vdavydov@virtuozzo.com, hannes@cmpxchg.org, mhocko@kernel.org,
 minchan@kernel.org, deepa.kernel@gmail.com, arnd@arndb.de, balbi@kernel.org,
 swhiteho@redhat.com, konishi.ryusuke@lab.ntt.co.jp, dsterba@suse.com,
 vegard.nossum@oracle.com, axboe@fb.com, pombredanne@nexb.com,
 tglx@linutronix.de, joe.lawrence@redhat.com, mpatocka@redhat.com,
 mcgrof@kernel.org, keescook@chromium.org, linux@dominikbrodowski.net,
 jannh@google.com, shakeelb@google.com, guro@fb.com, willy@infradead.org,
 khlebnikov@yandex-team.ru, kirr@nexedi.com, stern@rowland.harvard.edu,
 elver@google.com, parri.andrea@gmail.com, paulmck@kernel.org,
 rasibley@redhat.com, jstancek@redhat.com, avagin@gmail.com, cai@redhat.com,
 josef@toxicpanda.com, hare@suse.de, colyli@suse.de,
 johannes@sipsolutions.net, sspatil@android.com, alex_y_xu@yahoo.ca,
 mgorman@techsingularity.net, gor@linux.ibm.com, jhubbard@nvidia.com,
 crope@iki.fi, yzaikin@google.com, bfields@fieldses.org, jlayton@kernel.org,
 kernel@tuxforce.de, steve@sk2.org, nixiaoming@huawei.com,
 0x7f454c46@gmail.com, kuniyu@amazon.co.jp, alexander.h.duyck@intel.com,
 kuni1840@gmail.com, soheil@google.com, sridhar.samudrala@intel.com,
 Vincenzo.Frascino@arm.com, chuck.lever@oracle.com, Kevin.Brodsky@arm.com,
 Szabolcs.Nagy@arm.com, David.Laight@aculab.com, Mark.Rutland@arm.com,
 linux-morello@op-lists.linaro.org, Luca.Vizzarro@arm.com,
 max.kellermann@ionos.com, adobriyan@gmail.com, lukas@schauer.dev,
 j.granados@samsung.com, djwong@kernel.org, kent.overstreet@linux.dev,
 linux@weissschuh.net, kstewart@efficios.com
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
From: WangYuli <wangyuli@uniontech.com>
Content-Language: en-US
Autocrypt: addr=wangyuli@uniontech.com; keydata=
 xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSKP+nX39DN
 IVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAxFiEEa1GMzYeuKPkg
 qDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMBAAAKCRDF2h8wRvQL7g0UAQCH
 3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfPbwD/SrncJwwPAL4GiLPEC4XssV6FPUAY
 0rA68eNNI9cJLArOOARmgSyJEgorBgEEAZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7
 VTL0dvPDofBTjFYDAQgHwngEGBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIb
 DAAKCRDF2h8wRvQL7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkU
 o9ERi7qS/hbUdUgtitI89efbY0TVetgDsyeQiwU=
In-Reply-To: <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------WhExkXHB8tH0jp1dn0AUe2nH"
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtpip:uniontech.com:qybglogicsvrgz:qybglogicsvrgz8a-1
X-QQ-XMAILINFO: MgV0zj5pdGzOlcmvH/7T323+xBfWW2ao/6UK0gPLZqnNkVENG9/jAUEt
	mm5Y66vSIDX2UW4U5ALVgDCwNTLRfAjMjaktvgx18lCJrlDPZkehAMYXMBRW3obFlHGiXhV
	suNTb+MVlK2sUAJY8nBzlXSxqrzuV3ZR0y0Sskz8zpJIMk/a9orzcN1cGGSTwTBkaf4jwgc
	ORfDSMJsh7p7z+OV9pB2mQnQk2gRsbtvnw2udSBwXllD+HgI7TO5yRXf1e8eV6ioUAAoBXC
	2GgjKdQRXDF5hEGCPGC6AOjxfHttGW3WDiS8p24J05hf2OcMREsxC3oAexD49clHPyFuhIs
	hLd92/POwB8p4Oysw+mCOuTH+HZMCFg/ko5fEBn87lxbIGm+/npZkwzqzSLyAyNgHsCfOhz
	NiYjZEnPpfX2qUP/Lhw1jmyoc+5HqkCWQkHNX3BeBgXxELyI35N6iYgz7RwDCoDffLcQ4OP
	TsSq7hiGfXRhwGt/7brHvxooTKoKp5q122fPcKRx0T7MwtRUxn7JS8nzC+2balfqXgk49yA
	UeKqnsjB9LYphsFmQ0bmZFR5zGaf4xpuv3y33AnOsyYRPEttUx/XLU4elCS4rmNm4mFVIL6
	fYMc+PYuGAv6UztfIQcgOdWWcnqopog6xOfcdLZLC4H8KtKWBGHTFD++tdbi9sqDLEdTxkB
	xZVPhRh+hwqqb7hc9jg0aVaXAFd2iK1F8dSX9WXl206G9Io8LuHj5P3VInynHZFmu3dnMv7
	nF/OOz2cWID2x8r92mVGo2OcUXc1CMe/Pu5Ke6FOhzWJ5rMMscBDxVCmAUwBfC//mZSSCZK
	g/IzaH5BhCtPMllSvn/GVFWW1GUHyK+A0n4KalH4MlIcuKLds46wvOyeEUyCIWJgvKz3aHP
	0l5RRqvTdEJRsbsjciVBkAD8+ydTWvOBiaAYPxAASZcHohDH6EtqzGAZlKD96siDUyUM1Dr
	nWoK40YjDRWSdIkhr6VxkIFn02FIGzo7pVV3dXaYHWusulxs6l9QdHQMLJeC7DQPn5NrRxR
	z9arhoKqX7M/UEL2MdeKFlPLjjZtGIRCttq8WyBb2fkKfvNkUfRnP2ecNPGnHybOW+ILga4
	q800QWmOLbPuGL20fzMYCviZ6Ylz2SX2QgG92VPTK/fTSsvWe2Al7o=
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
X-QQ-RECHKSPAM: 0

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------WhExkXHB8tH0jp1dn0AUe2nH
Content-Type: multipart/mixed; boundary="------------Pyex4ntCgeLsgIrwDEQ1zvm5";
 protected-headers="v1"
From: WangYuli <wangyuli@uniontech.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kent Overstreet <kent.overstreet@linux.dev>
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
 yushengjin@uniontech.com, zhangdandan@uniontech.com,
 guanwentao@uniontech.com, zhanjun@uniontech.com, oliver.sang@intel.com,
 ebiederm@xmission.com, colin.king@canonical.com, josh@joshtriplett.org,
 penberg@cs.helsinki.fi, manfred@colorfullife.com, mingo@elte.hu,
 jes@sgi.com, hch@lst.de, aia21@cantab.net, arjan@infradead.org,
 jgarzik@pobox.com, neukum@fachschaft.cup.uni-muenchen.de,
 oliver@neukum.name, dada1@cosmosbay.com, axboe@kernel.dk, axboe@suse.de,
 nickpiggin@yahoo.com.au, dhowells@redhat.com, nathans@sgi.com,
 rolandd@cisco.com, tytso@mit.edu, bunk@stusta.de, pbadari@us.ibm.com,
 ak@linux.intel.com, ak@suse.de, davem@davemloft.net, jsipek@cs.sunysb.edu,
 jens.axboe@oracle.com, ramsdell@mitre.org, hch@infradead.org,
 torvalds@linux-foundation.org, akpm@linux-foundation.org,
 randy.dunlap@oracle.com, efault@gmx.de, rdunlap@infradead.org,
 haveblue@us.ibm.com, drepper@redhat.com, dm.n9107@gmail.com,
 jblunck@suse.de, davidel@xmailserver.org, mtk.manpages@googlemail.com,
 linux-arch@vger.kernel.org, vda.linux@googlemail.com, jmorris@namei.org,
 serue@us.ibm.com, hca@linux.ibm.com, rth@twiddle.net, lethal@linux-sh.org,
 tony.luck@intel.com, heiko.carstens@de.ibm.com, oleg@redhat.com,
 andi@firstfloor.org, corbet@lwn.net, crquan@gmail.com, mszeredi@suse.cz,
 miklos@szeredi.hu, peterz@infradead.org, a.p.zijlstra@chello.nl,
 earl_chew@agilent.com, npiggin@gmail.com, npiggin@suse.de, julia@diku.dk,
 jaxboe@fusionio.com, nikai@nikai.net, dchinner@redhat.com, davej@redhat.com,
 npiggin@kernel.dk, eric.dumazet@gmail.com, tim.c.chen@linux.intel.com,
 xemul@parallels.com, tj@kernel.org, serge.hallyn@canonical.com,
 gorcunov@openvz.org, levinsasha928@gmail.com, penberg@kernel.org,
 amwang@redhat.com, bcrl@kvack.org, muthu.lkml@gmail.com, muthur@gmail.com,
 mjt@tls.msk.ru, alan@lxorguk.ukuu.org.uk, raven@themaw.net, thomas@m3y3r.de,
 will.deacon@arm.com, will@kernel.org, josef@redhat.com,
 anatol.pomozov@gmail.com, koverstreet@google.com, zab@redhat.com,
 balbi@ti.com, gregkh@linuxfoundation.org, mfasheh@suse.com,
 jlbec@evilplan.org, rusty@rustcorp.com.au, asamymuthupa@micron.com,
 smani@micron.com, sbradshaw@micron.com, jmoyer@redhat.com, sim@hostway.ca,
 ia@cloudflare.com, dmonakhov@openvz.org, ebiggers3@gmail.com,
 socketpair@gmail.com, penguin-kernel@i-love.sakura.ne.jp, w@1wt.eu,
 kirill.shutemov@linux.intel.com, mhocko@suse.com, vdavydov.dev@gmail.com,
 vdavydov@virtuozzo.com, hannes@cmpxchg.org, mhocko@kernel.org,
 minchan@kernel.org, deepa.kernel@gmail.com, arnd@arndb.de, balbi@kernel.org,
 swhiteho@redhat.com, konishi.ryusuke@lab.ntt.co.jp, dsterba@suse.com,
 vegard.nossum@oracle.com, axboe@fb.com, pombredanne@nexb.com,
 tglx@linutronix.de, joe.lawrence@redhat.com, mpatocka@redhat.com,
 mcgrof@kernel.org, keescook@chromium.org, linux@dominikbrodowski.net,
 jannh@google.com, shakeelb@google.com, guro@fb.com, willy@infradead.org,
 khlebnikov@yandex-team.ru, kirr@nexedi.com, stern@rowland.harvard.edu,
 elver@google.com, parri.andrea@gmail.com, paulmck@kernel.org,
 rasibley@redhat.com, jstancek@redhat.com, avagin@gmail.com, cai@redhat.com,
 josef@toxicpanda.com, hare@suse.de, colyli@suse.de,
 johannes@sipsolutions.net, sspatil@android.com, alex_y_xu@yahoo.ca,
 mgorman@techsingularity.net, gor@linux.ibm.com, jhubbard@nvidia.com,
 crope@iki.fi, yzaikin@google.com, bfields@fieldses.org, jlayton@kernel.org,
 kernel@tuxforce.de, steve@sk2.org, nixiaoming@huawei.com,
 0x7f454c46@gmail.com, kuniyu@amazon.co.jp, alexander.h.duyck@intel.com,
 kuni1840@gmail.com, soheil@google.com, sridhar.samudrala@intel.com,
 Vincenzo.Frascino@arm.com, chuck.lever@oracle.com, Kevin.Brodsky@arm.com,
 Szabolcs.Nagy@arm.com, David.Laight@aculab.com, Mark.Rutland@arm.com,
 linux-morello@op-lists.linaro.org, Luca.Vizzarro@arm.com,
 max.kellermann@ionos.com, adobriyan@gmail.com, lukas@schauer.dev,
 j.granados@samsung.com, djwong@kernel.org, kent.overstreet@linux.dev,
 linux@weissschuh.net, kstewart@efficios.com
Message-ID: <a3218eef-f2b6-4a9b-8daf-1d54c533da50@uniontech.com>
Subject: Re: [RESEND PATCH] fs/pipe: Introduce a check to skip sleeping
 processes during pipe read/write
References: <75B06EE0B67747ED+20241225094202.597305-1-wangyuli@uniontech.com>
 <Z2wI3dmmrhMRT-48@smile.fi.intel.com>
In-Reply-To: <Z2wI3dmmrhMRT-48@smile.fi.intel.com>

--------------Pyex4ntCgeLsgIrwDEQ1zvm5
Content-Type: multipart/mixed; boundary="------------YbkyFbAmv3kxK4VEKPTtvkBC"

--------------YbkyFbAmv3kxK4VEKPTtvkBC
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMjAyNC8xMi8yNSAyMTozMCwgQW5keSBTaGV2Y2hlbmtvIHdyb3RlOg0KDQo+IERvbid0
IHlvdSB0aGluayB0aGUgQ2MgbGlzdCBpcyBhIGJpdCBvdmVybG9hZGVkPw0KDQpIaSwNCg0K
SSBhcG9sb2dpemUgZm9yIGFueSBpbmNvbnZlbmllbmNlIHRoaXMgbWF5IGNhdXNlLg0KDQpJ
IHVuZGVyc3RhbmQgdGhhdCB1bmRlciBub3JtYWwgY2lyY3Vtc3RhbmNlcywgb25lIHdvdWxk
IHNpbXBseSBwYXNzIHRoZSANCm1vZGlmaWVkIGNvZGUgcGF0aCBhcyBhbiBhcmd1bWVudCB0
byB0aGUga2VybmVsJ3MgDQpzY3JpcHRzL2dldF9tYWludGFpbmVyLnBsIHNjcmlwdCB0byBk
ZXRlcm1pbmUgdGhlIGFwcHJvcHJpYXRlIHJlY2lwaWVudHMuDQoNCkhvd2V2ZXIsIGdpdmVu
IHRoZSB2YXN0IGFuZCBjb21wbGV4IG5hdHVyZSBvZiB0aGUgTGludXgga2VybmVsIA0KY29t
bXVuaXR5LCB3aXRoIHRlbnMgb2YgdGhvdXNhbmRzIG9mIGRldmVsb3BlcnMgd29ybGR3aWRl
LCBhbmQgDQpjb25zaWRlcmluZyB0aGUgdmFyeWluZyAiY3VzdG9tcyIgb2YgZGlmZmVyZW50
IHN1YnN5c3RlbXMsIGFzIHdlbGwgYXMgDQp0aW1lIHpvbmUgZGlmZmVyZW5jZXMgYW5kIGlu
ZGl2aWR1YWwgd29yayBoYWJpdHMsIGl0J3Mgbm90IHVuY29tbW9uIGZvciANCnBhdGNoZXMg
dG8gYmUgc2VudCB0byBtYWlsaW5nIGxpc3RzIGFuZCBzdWJzZXF1ZW50bHkgaWdub3JlZCBv
ciBsZWZ0IA0KcGVuZGluZy4NCg0KVGhpcyBwYXRjaCwgZm9yIGV4YW1wbGUsIGhhcyBiZWVu
IHN1Ym1pdHRlZCBtdWx0aXBsZSB0aW1lcyB3aXRob3V0IA0KcmVjZWl2aW5nIGFueSByZXNw
b25zZSwgdW5mb3J0dW5hdGVseS4NCg0KTXkgaW50ZW50aW9uIGlzIHNpbXBseSB0byBzZWVr
IHlvdXIgcmV2aWV3LCBhbmQgdGhhdCBvZiBvdGhlciB0ZWNobmljYWwgDQpleHBlcnRzIGxp
a2UgeW91cnNlbGYsIGJ1dCBJIGNhbm5vdCBiZSBjZXJ0YWluLCBwcmlvciB0byB5b3VyIHJl
c3BvbnNlLCANCndoaWNoIHNwZWNpZmljIGV4cGVydHMgb24gd2hpY2ggbGlzdHMgd291bGQg
YmUgd2lsbGluZyB0byBwcm92aWRlIGZlZWRiYWNrLg0KDQpJIHdvdWxkIGFwcHJlY2lhdGUg
YW55IG90aGVyIHN1Z2dlc3Rpb25zIHlvdSBtYXkgaGF2ZS4NCg0KPj4gVW5peEJlbmNoIFBp
cGUgYmVuY2htYXJrIHJlc3VsdHMgb24gWmhhb3hpbiBLWC1VNjc4MEEgcHJvY2Vzc29yOg0K
Pj4NCj4+IFdpdGggdGhlIG9wdGlvbiBkaXNhYmxlZDogU2luZ2xlLWNvcmU6IDg0MS44LCBN
dWx0aS1jb3JlICg4KTogNDYyMS42DQo+PiBXaXRoIHRoZSBvcHRpb24gZW5hYmxlZDogIFNp
bmdsZS1jb3JlOiA4NzcuOCwgTXVsdGktY29yZSAoOCk6IDQ4NTQuNw0KPj4NCj4+IFNpbmds
ZS1jb3JlIHBlcmZvcm1hbmNlIGltcHJvdmVkIGJ5IDQuMSUsIG11bHRpLWNvcmUgcGVyZm9y
bWFuY2UNCj4+IGltcHJvdmVkIGJ5IDQuOCUuDQo+IC4uLg0KDQpBcyB5b3Uga25vdywgdGhl
IGtlcm5lbCBpcyBleHRyZW1lbHkgc2Vuc2l0aXZlIHRvIHBlcmZvcm1hbmNlLg0KDQpFdmVu
IGEgMSUgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQgY2FuIGxlYWQgdG8gc2lnbmlmaWNhbnQg
ZWZmaWNpZW5jeSANCmdhaW5zIGFuZCByZWR1Y2VkIGNhcmJvbiBlbWlzc2lvbnMgaW4gcHJv
ZHVjdGlvbiBlbnZpcm9ubWVudHMsIGFzIGxvbmcgDQphcyB0aGVyZSBpcyBzdWZmaWNpZW50
IHRlc3RpbmcgYW5kIHRoZW9yZXRpY2FsIGFuYWx5c2lzIHRvIHByb3ZlIHRoYXQgDQp0aGUg
aW1wcm92ZW1lbnQgaXMgcmVhbCBhbmQgbm90IGR1ZSB0byBtZWFzdXJlbWVudCBlcnJvciBv
ciBqaXR0ZXIuDQoNCj4+ICtjb25maWcgUElQRV9TS0lQX1NMRUVQRVINCj4+ICsJYm9vbCAi
U2tpcCBzbGVlcGluZyBwcm9jZXNzZXMgZHVyaW5nIHBpcGUgcmVhZC93cml0ZSINCj4+ICsJ
ZGVmYXVsdCBuDQo+ICduJyBpcyB0aGUgZGVmYXVsdCAnZGVmYXVsdCcsIG5vIG5lZWQgdG8g
aGF2ZSB0aGlzIGxpbmUuDQpPSywgSSdsbCBkcm9wIGl0LiBUaGFua3MuDQo+DQo+PiArCWhl
bHANCj4+ICsJICBUaGlzIG9wdGlvbiBpbnRyb2R1Y2VzIGEgY2hlY2sgd2hldGhlciB0aGUg
c2xlZXAgcXVldWUgd2lsbA0KPj4gKwkgIGJlIGF3YWtlbmVkIGR1cmluZyBwaXBlIHJlYWQv
d3JpdGUuDQo+PiArDQo+PiArCSAgSXQgb2Z0ZW4gbGVhZHMgdG8gYSBwZXJmb3JtYW5jZSBp
bXByb3ZlbWVudC4gSG93ZXZlciwgaW4NCj4+ICsJICBsb3ctbG9hZCBvciBzaW5nbGUtdGFz
ayBzY2VuYXJpb3MsIGl0IG1heSBpbnRyb2R1Y2UgbWlub3INCj4+ICsJICBwZXJmb3JtYW5j
ZSBvdmVyaGVhZC4NCj4+ICsJICBJZiB1bnN1cmUsIHNheSBOLg0KPiBJbGxvZ2ljYWwsIGl0
J3MgYWxyZWFkeSBOIGFzIHlvdSBzdGF0ZWQgYnkgcHV0dGluZyBhIHJlZHVuZGFudCBsaW5l
LCBidXQgYWZ0ZXINCj4gcmVtb3ZpbmcgdGhhdCBsaW5lIGl0IHdpbGwgbWFrZSBzZW5zZS4N
Cj4NCj4gLi4uDQpBcyBub3RlZCwgSSdsbCByZW1vdmUgImRlZmF1bHQgbiIgYXMgaXQgc2Vy
dmVzIG5vIHB1cnBvc2UuDQo+DQo+PiArc3RhdGljIGlubGluZSBib29sDQo+IEhhdmUgeW91
IGJ1aWxkIHRoaXMgd2l0aCBDbGFuZyBhbmQgYG1ha2UgVz0xIC4uLmA/DQoNCkhtbS4uLkkn
dmUgbm90aWNlZCBhIGRpc2NyZXBhbmN5IGluIGtlcm5lbCBjb21waWxhdGlvbiByZXN1bHRz
IHdpdGggYW5kIA0Kd2l0aG91dCAibWFrZSBXPTEiLg0KDQpXaGVuIEkgdXNlIHg4Nl82NF9k
ZWZjb25maWcgYW5kIGNsYW5nLTE5LjEuMSAoVWJ1bnR1IDI0LjEwKSBhbmQgcnVuIA0KIm1h
a2UiLCB0aGVyZSBhcmUgbm8gd2FybmluZ3MuDQoNCkhvd2V2ZXIsIHdoZW4gSSBydW4gIm1h
a2UgVz0xIiwgdGhlIGtlcm5lbCBnZW5lcmF0ZXMgYSBtYXNzaXZlIG51bWJlciBvZiANCmVy
cm9ycywgY2F1c2luZyB0aGUgY29tcGlsYXRpb24gdG8gZmFpbCBwcmVtYXR1cmVseS4NCg0K
ZS5nLg0KDQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gYXJjaC94ODYva2VybmVsL2FzbS1vZmZz
ZXRzLmM6MTQ6DQpJbiBmaWxlIGluY2x1ZGVkIGZyb20gLi9pbmNsdWRlL2xpbnV4L3N1c3Bl
bmQuaDo1Og0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9saW51eC9zd2FwLmg6
OToNCkluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2luY2x1ZGUvbGludXgvbWVtY29udHJvbC5o
OjIxOg0KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC4vaW5jbHVkZS9saW51eC9tbS5oOjIyMjQ6
DQouL2luY2x1ZGUvbGludXgvdm1zdGF0Lmg6NTA0OjQzOiBlcnJvcjogYXJpdGhtZXRpYyBi
ZXR3ZWVuIGRpZmZlcmVudCANCmVudW1lcmF0aW9uIHR5cGVzICgnZW51bSB6b25lX3N0YXRf
aXRlbScgYW5kICdlbnVtIG51bWFfc3RhdF9pdGVtJykgDQpbLVdlcnJvciwtV2VudW0tZW51
bS1jb252ZXJzaW9uXQ0KIMKgIDUwNCB8wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gdm1zdGF0
X3RleHRbTlJfVk1fWk9ORV9TVEFUX0lURU1TICsNCiDCoMKgwqDCoMKgIHzCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfn5+fn5+fn5+
fn5+fn5+fn5+fn5+IF4NCiDCoCA1MDUgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBpdGVtXTsNCiDCoMKgwqDCoMKgIHzCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfn5+fg0K
Li9pbmNsdWRlL2xpbnV4L3Ztc3RhdC5oOjUxMTo0MzogZXJyb3I6IGFyaXRobWV0aWMgYmV0
d2VlbiBkaWZmZXJlbnQgDQplbnVtZXJhdGlvbiB0eXBlcyAoJ2VudW0gem9uZV9zdGF0X2l0
ZW0nIGFuZCAnZW51bSBudW1hX3N0YXRfaXRlbScpIA0KWy1XZXJyb3IsLVdlbnVtLWVudW0t
Y29udmVyc2lvbl0NCiDCoCA1MTEgfMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHZtc3RhdF90
ZXh0W05SX1ZNX1pPTkVfU1RBVF9JVEVNUyArDQogwqDCoMKgwqDCoCB8wqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIH5+fn5+fn5+fn5+
fn5+fn5+fn5+fiBeDQogwqAgNTEyIHzCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgTlJfVk1fTlVNQV9FVkVOVF9JVEVNUyArDQogwqDC
oMKgwqDCoCB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIH5+fn5+fn5+fn5+fn5+fn5+fn5+fn4NCi4vaW5jbHVkZS9saW51eC92bXN0
YXQuaDo1MjQ6NDM6IGVycm9yOiBhcml0aG1ldGljIGJldHdlZW4gZGlmZmVyZW50IA0KZW51
bWVyYXRpb24gdHlwZXMgKCdlbnVtIHpvbmVfc3RhdF9pdGVtJyBhbmQgJ2VudW0gbnVtYV9z
dGF0X2l0ZW0nKSANClstV2Vycm9yLC1XZW51bS1lbnVtLWNvbnZlcnNpb25dDQogwqAgNTI0
IHzCoMKgwqDCoMKgwqDCoMKgIHJldHVybiB2bXN0YXRfdGV4dFtOUl9WTV9aT05FX1NUQVRf
SVRFTVMgKw0KIMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB+fn5+fn5+fn5+fn5+fn5+fn5+fn4gXg0KIMKgIDUy
NSB8wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgIE5SX1ZNX05VTUFfRVZFTlRfSVRFTVMgKw0KIMKgwqDCoMKgwqAgfMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB+fn5+fn5+fn5+
fn5+fn5+fn5+fn5+DQozIGVycm9ycyBnZW5lcmF0ZWQuDQoNCkFuZCBJJ3ZlIG9ic2VydmVk
IHNpbWlsYXIgYmVoYXZpb3Igd2l0aCBnY2MtMTQuMi4wLg0KDQpXaGlsZSBJJ20ga2VlbiBv
biBhZGRyZXNzaW5nIGFzIG1hbnkgcG90ZW50aWFsIGNvbXBpbGUgZXJyb3JzIGFuZCANCndh
cm5pbmdzIGluIHRoZSBrZXJuZWwgYXMgcG9zc2libGUsIGl0IHNlZW1zIGxpa2UgYSBsb25n
LXRlcm0gZW5kZWF2b3IuDQoNClJlZ2FyZGluZyB0aGlzIHNwZWNpZmljIGNvZGUsIEknZCBh
cHByZWNpYXRlIHlvdXIgaW5zaWdodHMgb24gaG93IHRvIA0KaW1wcm92ZSBpdC4NCg0KPg0K
Pj4gK3BpcGVfY2hlY2tfd3FfaGFzX3NsZWVwZXIoc3RydWN0IHdhaXRfcXVldWVfaGVhZCAq
d3FfaGVhZCkNCj4+ICt7DQo+PiArCWlmIChJU19FTkFCTEVEKENPTkZJR19QSVBFX1NLSVBf
U0xFRVBFUikpDQo+PiArCQlyZXR1cm4gd3FfaGFzX3NsZWVwZXIod3FfaGVhZCk7DQo+PiAr
CWVsc2UNCj4gUmVkdW5kYW50Lg0KPg0KPj4gKwkJcmV0dXJuIHRydWU7DQo+IAlpZiAoIWZv
bykNCj4gCQlyZXR1cm4gdHJ1ZTsNCj4NCj4gCXJldHVybiBiYXIoLi4uKTsNCj4NCj4+ICt9
DQoNClllcy4gSSdsbCByZXdvcmsgdGhlIGNvZGUgc3RydWN0dXJlIGhlcmUuIFRoYW5rcy4N
Cg0KVGhhbmtzLA0KLS0gDQpXYW5nWXVsaQ0K
--------------YbkyFbAmv3kxK4VEKPTtvkBC
Content-Type: application/pgp-keys; name="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Disposition: attachment; filename="OpenPGP_0xC5DA1F3046F40BEE.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

xjMEZoEsiBYJKwYBBAHaRw8BAQdAyDPzcbPnchbIhweThfNK1tg1imM+5kgDBJSK
P+nX39DNIVdhbmdZdWxpIDx3YW5neXVsaUB1bmlvbnRlY2guY29tPsKJBBMWCAAx
FiEEa1GMzYeuKPkgqDuvxdofMEb0C+4FAmaBLIgCGwMECwkIBwUVCAkKCwUWAgMB
AAAKCRDF2h8wRvQL7g0UAQCH3mrGM0HzOaARhBeA/Q3AIVfhS010a0MZmPTRGVfP
bwD/SrncJwwPAL4GiLPEC4XssV6FPUAY0rA68eNNI9cJLArOOARmgSyJEgorBgEE
AZdVAQUBAQdA88W4CTLDD9fKwW9PB5yurCNdWNS7VTL0dvPDofBTjFYDAQgHwngE
GBYIACAWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZoEsiQIbDAAKCRDF2h8wRvQL
7sKvAP4mBvm7Zn1OUjFViwkma8IGRGosXAvMUFyOHVcl1RTgFQEAuJkUo9ERi7qS
/hbUdUgtitI89efbY0TVetgDsyeQiwU=3D
=3DBlkq
-----END PGP PUBLIC KEY BLOCK-----

--------------YbkyFbAmv3kxK4VEKPTtvkBC--

--------------Pyex4ntCgeLsgIrwDEQ1zvm5--

--------------WhExkXHB8tH0jp1dn0AUe2nH
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wnsEABYIACMWIQRrUYzNh64o+SCoO6/F2h8wRvQL7gUCZ2wn5QUDAAAAAAAKCRDF2h8wRvQL7pcp
AP9me8ISLBcpHJwkzXCBAEfvjuxMbfD0Z4VJeJZomf9P3AD/YU3UZLFudoSkOuja/nG2RSmFkjU4
Ce95Z5hedZpTxA8=
=zG/A
-----END PGP SIGNATURE-----

--------------WhExkXHB8tH0jp1dn0AUe2nH--

