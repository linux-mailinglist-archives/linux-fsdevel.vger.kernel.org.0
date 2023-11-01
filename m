Return-Path: <linux-fsdevel+bounces-1704-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C76D7DDCC7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 07:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303871C20D66
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Nov 2023 06:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD1F1C27;
	Wed,  1 Nov 2023 06:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="BA2e/S9O"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5820610EF
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:40:22 +0000 (UTC)
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB311F3
	for <linux-fsdevel@vger.kernel.org>; Tue, 31 Oct 2023 23:40:15 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20231101064012epoutp035a9ca467b19d11d488a59d7ffaf8de05~TbIdKF4Ha2144821448epoutp03P
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 Nov 2023 06:40:12 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20231101064012epoutp035a9ca467b19d11d488a59d7ffaf8de05~TbIdKF4Ha2144821448epoutp03P
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698820812;
	bh=8yNlhLTEKwXnXCWRDcTizx48AgBy5iolZ54MBLaU7ro=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=BA2e/S9O7YcCRFFBtoXgbtRa79BwI6/+wSGe9DfXXTCvKUmGghg10S8IfM4YsCg9Q
	 lTjD2YBe1dRRELOyXYXDgKMZJKC4kvNA4aR7zP/FDPf1k9BBXBHCg8BjqXbscb6tGe
	 ibvdvI1A3a8NU5UxrJDZMRlc1hkhtSGGAaSePhWQ=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas2p2.samsung.com (KnoxPortal) with ESMTP id
	20231101064011epcas2p20469e45892158fcd62133878954443d1~TbIcMEZza3083630836epcas2p21;
	Wed,  1 Nov 2023 06:40:11 +0000 (GMT)
Received: from epsmges2p2.samsung.com (unknown [182.195.36.97]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4SKy6z0lxjz4x9QF; Wed,  1 Nov
	2023 06:40:11 +0000 (GMT)
X-AuditID: b6c32a46-fcdfd70000002596-f8-6541f2ca8ce7
Received: from epcas2p4.samsung.com ( [182.195.41.56]) by
	epsmges2p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	64.E1.09622.AC2F1456; Wed,  1 Nov 2023 15:40:10 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH v3 01/14] fs: Move enum rw_hint into a new header
 file
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>, KANCHAN JOSHI
	<joshi.k@samsung.com>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>, Avri Altman <Avri.Altman@wdc.com>,
	Bean Huo <huobean@gmail.com>, Daejun Park <daejun7.park@samsung.com>, Jan
	Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, Jaegeuk Kim
	<jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>, Alexander Viro
	<viro@zeniv.linux.org.uk>, Jeff Layton <jlayton@kernel.org>, Chuck Lever
	<chuck.lever@oracle.com>, Seonghun Kim <seonghun-sui.kim@samsung.com>, Jorn
	Lee <lunar.lee@samsung.com>, Sung-Jun Park <sungjun07.park@samsung.com>,
	Hyunji Jeon <hyunji.jeon@samsung.com>, Dongwoo Kim
	<dongwoo7565.kim@samsung.com>, Seongcheol Hong <sc01.hong@samsung.com>,
	Jaeheon Lee <jaeheon7.lee@samsung.com>, Wonjong Song <wj3.song@samsung.com>,
	JinHwan Park <jh.i.park@samsung.com>, Yonggil Song
	<yonggil.song@samsung.com>, Soonyoung Kim <overmars.kim@samsung.com>,
	Shinwoo Park <sw_kr.park@samsung.com>, Seokhwan Kim <sukka.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <9b0990ec-a3c9-48c0-b312-8c07c727e326@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231101063910epcms2p18f991db15958f246fa1654f2d412e176@epcms2p1>
Date: Wed, 01 Nov 2023 15:39:10 +0900
X-CMS-MailID: 20231101063910epcms2p18f991db15958f246fa1654f2d412e176
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA22TeUzTZxjH/R20BVf4yfkOEyg/NzZkhZZAeT0YGB12wW0kbjGSRezgN0B6
	pcdQRpbiMRCQw42xVJBjhJaCMCpiPXCuHBUGYYugAeVYhHHZcBgzCFTW0jL3x/775JPv8z55
	njcPA3NX030ZaWIFJRMLhCTNBW/rCILs3uUDFKfEsA/Org7RYMNoEQ3Odywj8IfFVQz+VtqP
	wo3RaRTOGoOgbuIY1Oj6nGB9QxcKy/tVKLxmWkPhlbJzKJxsVmPwp76dsOhVDg5X63R02LVh
	psH2kWB4t70Hh/mPDTTYo53Bocb0CoUT68/ocOWyHM71CuH8ih/U5VYg8GJZIw4XXtbicMBi
	coK5eRYMlg50ojEB/IeDcfxb6lE6/2G/kq/XXaTx7wyraPylqRGcX9iqQ/h9VZ10/gu9Hz/n
	fj7K10+a0fjtCen7UylBMiVjUeIkSXKaOCWKjDuaeDAxgsfhsrl7YCTJEgtEVBR56Eg8OzZN
	aN0OyfpKIFRaVbxALidD398vkygVFCtVIldEkZQ0WSiNlIbIBSK5UpwSIqYUe7kcTliENXgy
	PbX2+RIuHfA5/eSXK6gKGffOQ5wZgAgH9eZWzMbuhAEBrdcS8hAGg0nsABaDh017EJ+AAu23
	NHuEBM1/qOl2HwJG/mxEbEwj3gNlD8Y3vSchAnX969YnXRgYYXAGtxZ7MHsvJvgxZwq3805w
	U3Njs9iZ2AcaB/Nodv8uWKm75Mh7geEGM32LF7orETt7ggtj/Y7MDjCxesfh3wRPKvSOvARs
	DGocnAXa7l91cCh4lNuC22f8CLzoPmnTOPE2MGZnozYNiENgtPeoTWNEMKirnsdsGiOCQPPt
	UHtiF+gcwe0JV5DbYaFvzadqWftfNlydRO0cCJpWm9FiZJf69ZrV/+mlft2rCsF0iDcllYtS
	KHmYNOzfj02SiPTI5pHsjjUg35sXQ4wIykCMCGBgpCezIyKGcmcmC85kUjJJokwppORGJMI6
	ZAnm65UksV6ZWJHIDd/DCefxuJFhEZxI0oc5dqEi2Z1IESiodIqSUrKtOpTh7KtC256Rdw/4
	H4+2ZJ9L8Q5Y8dh2uVVabKpuY7+VeT7y62DXPNn4EQ37d/lMyN9Z5QWzbuZ14yy3rVQbKJ17
	48xC3EBNqqKBoS80X9cW97SsH+aEZt32Cj8b4Oo2tf1BTXSJZW3tAz+Wpf5EU/W9AzfaGUXv
	aGGm2anKnCAecznLOy+eerlNk7FcHt3Uf7MjzH/p6brpM0HSJf/8ZZ6PqfrX6SFBbeDw9Rm1
	6OOyFWPCca+nMcGnfg5I0DpNfPj5F6czeoeCg/7KKPtUyeJNfOOsYsKke91d3z163FRpnj/B
	bJ+ufH7MLYoz30UOxNb2FLL1xF7qVMGXdD9N0+EaFi0XiOZIXJ4q4O7GZHLBP9RnK3atBAAA
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3
References: <9b0990ec-a3c9-48c0-b312-8c07c727e326@acm.org>
	<20231017204739.3409052-1-bvanassche@acm.org>
	<20231017204739.3409052-2-bvanassche@acm.org>
	<b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com>
	<CGME20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3@epcms2p1>

Hi Bart,

>On 10/30/23 04:11, Kanchan Joshi wrote:
>> On 10/18/2023 2:17 AM, Bart Van Assche wrote:
>>> +/* Block storage write lifetime hint values. */
>>> +enum rw_hint =7B
>>> +=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20WRITE_LIFE_NOT_SET=C2=A0=20=C2=A0=
=20=C2=A0=20=C2=A0=20=3D=200,=20/*=20RWH_WRITE_LIFE_NOT_SET=20*/=0D=0A>>>=
=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20WRITE_LIFE_NONE=C2=A0=20=C2=A0=20=
=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=201,=20/*=20RWH_W=
RITE_LIFE_NONE=20*/=0D=0A>>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20WRITE_L=
IFE_SHORT=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=202,=20/*=20RWH_WRITE_LIFE=
_SHORT=20*/=0D=0A>>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20WRITE_LIFE_MEDI=
UM=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=203,=20/*=20RWH_WRITE_LIFE_MEDIUM=
=20*/=0D=0A>>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20WRITE_LIFE_LONG=C2=A0=
=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=204,=
=20/*=20RWH_WRITE_LIFE_LONG=20*/=0D=0A>>>=20+=C2=A0=20=C2=A0=20=C2=A0=20=C2=
=A0=20WRITE_LIFE_EXTREME=C2=A0=20=C2=A0=20=C2=A0=20=C2=A0=20=3D=205,=20/*=
=20RWH_WRITE_LIFE_EXTREME=20*/=0D=0A>>>=20+=7D=20__packed;=0D=0A>>>=20+=0D=
=0A>>>=20+static_assert(sizeof(enum=20rw_hint)=20=3D=3D=201);=0D=0A>>=C2=A0=
=0D=0A>>=20Does=20it=20make=20sense=20to=20do=20away=20with=20these,=20and=
=20have=20temperature-neutral=0D=0A>>=20names=20instead=20e.g.,=20WRITE_LIF=
E_1,=20WRITE_LIFE_2?=0D=0A>>=C2=A0=0D=0A>>=20With=20the=20current=20choice:=
=0D=0A>>=20-=20If=20the=20count=20goes=20up=20(beyond=205=20hints),=20infra=
=20can=20scale=20fine=20but=20these=0D=0A>>=20names=20do=20not.=20Imagine=
=20ULTRA_EXTREME=20after=20EXTREME.=0D=0A>>=20-=20Applications=20or=20in-ke=
rnel=20users=20can=20specify=20LONG=20hint=20with=20data=20that=0D=0A>>=20a=
ctually=20has=20a=20SHORT=20lifetime.=20Nothing=20really=20ensures=20that=
=20LONG=20is=0D=0A>>=20really=20LONG.=0D=0A>>=C2=A0=0D=0A>>=20Temperature-n=
eutral=20names=20seem=20more=20generic/scalable=20and=20do=20not=20present=
=0D=0A>>=20the=20unnecessary=20need=20to=20be=20accurate=20with=20relative=
=20temperatures.=0D=0A>=0D=0A>Thanks=20for=20having=20taken=20a=20look=20at=
=20this=20patch=20series.=20Jens=20asked=20for=20data=0D=0A>that=20shows=20=
that=20this=20patch=20series=20improves=20performance.=20Is=20this=0D=0A>so=
mething=20Samsung=20can=20help=20with?=0D=0A=0D=0AWe=20analyzed=20the=20NAN=
D=20block=20erase=20counter=20with=20and=20without=20stream=20separation=0D=
=0Athrough=20a=20long-term=20workload=20in=20F2FS.=0D=0AThe=20analysis=20sh=
owed=20that=20the=20erase=20counter=20is=20reduced=20by=20approximately=204=
0%=20=0D=0Awith=20stream=20seperation.=0D=0ALong-term=20workload=20is=20a=
=20scenario=20where=20erase=20and=20write=20are=20repeated=20by=0D=0Astream=
=20after=20performing=20precondition=20fill=20for=20each=20temperature=20of=
=20F2FS.=0D=0A=0D=0AThanks,=0D=0A=0D=0ADaejun.=0D=0A=0D=0A>=0D=0A>Thanks,=
=0D=0A>=0D=0A>Bart.=0D=0A>=0D=0A>=C2=A0=0D=0A>=C2=A0

