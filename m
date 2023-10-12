Return-Path: <linux-fsdevel+bounces-181-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD5E7C701B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 16:11:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C36F1C210A9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 12 Oct 2023 14:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E07EA30FA1;
	Thu, 12 Oct 2023 14:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=jagalactic.com header.i=@jagalactic.com header.b="AHwHf/Sc";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="JeHnrzoI"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49D4530F80
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 14:11:03 +0000 (UTC)
Received: from a11-77.smtp-out.amazonses.com (a11-77.smtp-out.amazonses.com [54.240.11.77])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1032291
	for <linux-fsdevel@vger.kernel.org>; Thu, 12 Oct 2023 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rjayupzefgi7e6fmzxcxe4cv4arrjs35; d=jagalactic.com; t=1697119857;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id;
	bh=06+A+Lwel4vw/jfjX8u3x/pI6DzxkHO6EhEhZY9kd8s=;
	b=AHwHf/Scwcgi7xfh56rkgz7ZXn0ykvxuIasSzwzvtR/wb5tLo1cFikTAWrgKVCLU
	z6zBBbbUPaxdGGG7a77vJMqnyya3L56s2Hd6y6miYaICnBLwa8TLR9XDJVzkhbcvvrN
	RdIeP2ft3PCC18t8I+7egMI1C4HriCerFLZK/y2k=
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=224i4yxa5dv7c2xz3womw6peuasteono; d=amazonses.com; t=1697119857;
	h=Subject:From:To:Cc:Date:Mime-Version:Content-Type:Content-Transfer-Encoding:In-Reply-To:References:Message-Id:Feedback-ID;
	bh=06+A+Lwel4vw/jfjX8u3x/pI6DzxkHO6EhEhZY9kd8s=;
	b=JeHnrzoI4e0j05l9SP4xIPxoFsQKwXAwcid9P36PRMPIJE1jxVnjLqxKOn1f861G
	P1ZLRA0ROJkX4zC/qA28GV+GwD2Dyf7goxe3hbzPaWOjwOOoo01OBuqrGCxw4UBwn1B
	zrFnOLsZ1x6d7y33h0IuvAPmR9V1QumUKfpDZXSs=
Subject: Re: Question about fuse dax support
From: =?UTF-8?Q?John_Groves?= <john@jagalactic.com>
To: =?UTF-8?Q?Miklos_Szeredi?= <miklos@szeredi.hu>
Cc: 
	=?UTF-8?Q?linux-fsdevel=40vger=2Ekernel=2Eorg?= <linux-fsdevel@vger.kernel.org>, 
	=?UTF-8?Q?jgroves=40micron=2Ecom?= <jgroves@micron.com>, 
	=?UTF-8?Q?Amir_Goldstein?= <amir73il@gmail.com>, 
	=?UTF-8?Q?fuse-devel=40lists=2Esourceforge=2Enet?= <fuse-devel@lists.sourceforge.net>
Date: Thu, 12 Oct 2023 14:10:57 +0000
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
In-Reply-To: 
 <CAJfpegsvhbmAYD22Y981BiV8ut7QfZbRZMvGY7Vs-hCM2L+=dQ@mail.gmail.com>
References: <nx43owwj2x46rfidyi7iziv2dbw3licpjn24ff5sv76nuoe3dt@seenck6dhbz7> 
 <0100018b0631277b-799ea048-5215-4993-a327-65f1b50fb169-000000@email.amazonses.com> 
 <CAJfpegsvhbmAYD22Y981BiV8ut7QfZbRZMvGY7Vs-hCM2L+=dQ@mail.gmail.com> 
 <eeokvydlogqzlhjrjcf4knvazklizjk4tdd2kkb3qvgy7orfke@ijorgccnytsg>
X-Mailer: Amazon WorkMail
Thread-Index: AQHZ+IC0O72aZ+HeRa6RJwxZy8QIbwDAkNASASVNs6c=
Thread-Topic: Question about fuse dax support
X-Wm-Sent-Timestamp: 1697119856
Message-ID: <0100018b2439ebf3-a442db6f-f685-4bc4-b4b0-28dc333f6712-000000@email.amazonses.com>
Feedback-ID: 1.us-east-1.LF00NED762KFuBsfzrtoqw+Brn/qlF9OYdxWukAhsl8=:AmazonSES
X-SES-Outgoing: 2023.10.12-54.240.11.77
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 23/10/10 04:06PM, Miklos Szeredi wrote:=0D=0A> On Fri, 6 Oct 2023 at 2=
0:12, John Groves <john@jagalactic.com> wrote:=0D=0A> >=0D=0A> > I see th=
at there is some limited support for dax mapping of fuse files, but=0D=0A=
> > it seems to be specifically for virtiofs. I admit I barely understand=
 that=0D=0A> > use case, but there is another fuse/dax use case that I=E2=
=80=99d like to explore.=0D=0A> > I would appreciate feedback on this, in=
cluding pointers to RTFM material,=0D=0A> > etc.=0D=0A> >=0D=0A> > I=E2=80=
=99m interested in creating a file system interface to fabric-attached sh=
ared=0D=0A> > memory (cxl). Think of a fuse file system that receives met=
adata (how MD is=0D=0A> > distributed is orthogonal) and instantiates fil=
es that are backed by dax=0D=0A> > memory (S_DAX files), such that the sa=
me =E2=80=98data sets=E2=80=99 can be visible as=0D=0A> > mmap-able files=
 on more than one server. I=E2=80=99d like feedback as to whether=0D=0A> =
> this is (or could be) doable via fuse.=0D=0A> >=0D=0A> > Here is the ma=
in rub though. For this to perform adequately, I don=E2=80=99t think=0D=0A=
> > it would be acceptable for each fault to call up to user space to res=
olve=0D=0A> > the dax device & offset. So the kernel side of fuse would n=
eed to cache a=0D=0A> > dax extent list for each file to TLB/page-table m=
isses.=0D=0A> >=0D=0A> > I would appreciate any questions, pointers or fe=
edback.=0D=0A>=20=0D=0A> I think the passthrough patches should take care=
 of this use case as well:=0D=0A>=20=0D=0A> https://lore.kernel.org/all/2=
0230519125705.598234-1-amir73il@gmail.com/=0D=0A> Thanks,=0D=0A> Miklos=0D=
=0A=0D=0AThanks for the reply Miklos.=0D=0A=0D=0AI've looked over that pa=
tch set, and I'm pretty sure it's not what is needed=0D=0Afor my use case=
=2E I can see how my statement above "backed by dax memory=0D=0A(S_DAX fi=
les)" could have implied that there is an S_DAX backing file that=0D=0Afu=
se could use - but there is not already a backing file, just a dax device=
=2E=0D=0A=0D=0ASo it is the fuse file that would need to have the S_DAX f=
lag and handle=0D=0Amapping to an extent list from the dax device (rather=
 than referring to a=0D=0Abacking file that already does this).=0D=0A=0D=0A=
This is a performance-sensitive use case - S_DAX files are for direct acc=
ess=0D=0Ato memory (duh). Posix read/write are supported, but the main us=
e case for=0D=0AS_DAX files is performant mmap. So I think this can only =
be viable if:=0D=0A=0D=0A1) The fuse kernel module supports files with th=
e S_DAX flag, and performs the=0D=0A   appropriate mapping in conjunction=
 with the dax driver (iomap, etc.)=0D=0A2) The fuse kernel module caches =
the extent list of the backing memory=0D=0A   (extents of the form [offse=
t, length] or [device, offset, length]) so that=0D=0A   TLB/page-table fa=
ults could be resolved without calling out to the user=0D=0A   space hand=
ler.=0D=0A=0D=0AMy naive reading of the existence of some sort of fuse/da=
x support for virtiofs=0D=0Asuggested that there might be a way of doing =
this - but I may be wrong about=0D=0Athat.=0D=0A=0D=0APlease let me know =
your thoughts on this.=0D=0A=0D=0AAlso: I will be at Linux Plumbers, and =
I'm speaking about this use case in=0D=0Athe cxl microconference. If you =
will be there, perhaps we can discuss it.=0D=0AAny others interested in d=
iscussing it, here or at Plumbers, please ping me.=0D=0A=0D=0AThanks,=0D=0A=
John Groves=0D=0AMicron=0D=0A=0D=0A

