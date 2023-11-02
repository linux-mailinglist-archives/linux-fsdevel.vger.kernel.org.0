Return-Path: <linux-fsdevel+bounces-1793-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E399C7DED66
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 08:33:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 723C2B2121B
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Nov 2023 07:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01B5263DD;
	Thu,  2 Nov 2023 07:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="VfdSPl8r"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B8763C6
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:33:11 +0000 (UTC)
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C17A12C
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 00:33:03 -0700 (PDT)
Received: from epcas2p2.samsung.com (unknown [182.195.41.54])
	by mailout4.samsung.com (KnoxPortal) with ESMTP id 20231102073258epoutp048eee0f55e5998cd805ac812852f3a8ed~Tvfz_Ot8F2492224922epoutp04V
	for <linux-fsdevel@vger.kernel.org>; Thu,  2 Nov 2023 07:32:58 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20231102073258epoutp048eee0f55e5998cd805ac812852f3a8ed~Tvfz_Ot8F2492224922epoutp04V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1698910378;
	bh=2uq5roYA4bWfG77dHMjfTPvdeRh/sgiL6PttJPkNnY4=;
	h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
	b=VfdSPl8rmfkcmAu1Wn6KwAv47s+nj0C9jx+u17LMq2+RRDnxpgqmLMbDk0/dGZ68M
	 iNefLHOSGEvbZF9KE3++m6Bcc/P+pmEr2jeqhD9ifz4o1etHHUM07itstuvfub6GJJ
	 X9hgcLMUa0w4d3eou192oyPE1zdosw2Px4KnEEzE=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
	epcas2p3.samsung.com (KnoxPortal) with ESMTP id
	20231102073257epcas2p3a697640ebe49bc897c2b1220d8bd8d6a~TvfzLGdGt2967329673epcas2p3E;
	Thu,  2 Nov 2023 07:32:57 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.102]) by
	epsnrtp3.localdomain (Postfix) with ESMTP id 4SLbFP29hlz4x9QB; Thu,  2 Nov
	2023 07:32:57 +0000 (GMT)
X-AuditID: b6c32a48-1d26ea8000002587-47-654350a991a5
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
	epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
	4A.E8.09607.9A053456; Thu,  2 Nov 2023 16:32:57 +0900 (KST)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) (2) [PATCH v3 01/14] fs: Move enum rw_hint into a new header
 file
Reply-To: daejun7.park@samsung.com
Sender: Daejun Park <daejun7.park@samsung.com>
From: Daejun Park <daejun7.park@samsung.com>
To: Bart Van Assche <bvanassche@acm.org>, Daejun Park
	<daejun7.park@samsung.com>, KANCHAN JOSHI <joshi.k@samsung.com>, Jens Axboe
	<axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "Martin K .
 Petersen" <martin.petersen@oracle.com>, Christoph Hellwig <hch@lst.de>,
	Niklas Cassel <Niklas.Cassel@wdc.com>, Avri Altman <Avri.Altman@wdc.com>,
	Bean Huo <huobean@gmail.com>, Jan Kara <jack@suse.cz>, Christian Brauner
	<brauner@kernel.org>, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu
	<chao@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>, Jeff Layton
	<jlayton@kernel.org>, Chuck Lever <chuck.lever@oracle.com>, Seonghun Kim
	<seonghun-sui.kim@samsung.com>, Jorn Lee <lunar.lee@samsung.com>, Sung-Jun
	Park <sungjun07.park@samsung.com>, Hyunji Jeon <hyunji.jeon@samsung.com>,
	Dongwoo Kim <dongwoo7565.kim@samsung.com>, Seongcheol Hong
	<sc01.hong@samsung.com>, Jaeheon Lee <jaeheon7.lee@samsung.com>, Wonjong
	Song <wj3.song@samsung.com>, JinHwan Park <jh.i.park@samsung.com>, Yonggil
	Song <yonggil.song@samsung.com>, Soonyoung Kim <overmars.kim@samsung.com>,
	Shinwoo Park <sw_kr.park@samsung.com>, Seokhwan Kim <sukka.kim@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <c06b2624-b05b-48d4-840d-beb208aa33dc@acm.org>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20231102073155epcms2p3d1e288b7b81e213fbb32ecc0cc48e094@epcms2p3>
Date: Thu, 02 Nov 2023 16:31:55 +0900
X-CMS-MailID: 20231102073155epcms2p3d1e288b7b81e213fbb32ecc0cc48e094
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
X-Brightmail-Tracker: H4sIAAAAAAAAA22Tf1DTdRjH7/uDbcCNvg60D3AQzrSAgI0b7IMBqVB9C0jKs0zPYMe+B8TY
	1jYIjWqXR/wMxGvNRvxKDmSIE4RFosjPwGInBtiBQZBwiDRBMI6dDtrYyP7ov9fzvvfzPPc8
	zz0MjFVO92CkihWUTCwQsWlOuL7Hlx9QHx9FcYwqZzhvGqXBhokSGlzoWUbgN0smDP6iMqBw
	Y2IOhfPdvlA79R6s0w46wPqGPhR+Z1CisLH/MQrL1KdQOKPTYPDcoCcsWc/FoalWS4d9G0Ya
	vDbuD69eu4HDwt/aaPDG+Xs4rOtfR+HUk7t0uHZGDu//LIILa95Qm1eOwHz1BRwu/l2Dw5vm
	fgeYV2DGoOpmL7pvJzk8EkP+qJmgk8OGDLJZm08j28eUNPLh7DhOFrdoEXKwqpdOrjR7k7md
	hSjZPGNE452PpoWnUAIhJfOhxEkSYao4OYIdcyghKiEklMMN4IZBPttHLEinItjRsfEBr6WK
	LNth+2QKRBkWKV4gl7ODIsNlkgwF5ZMikSsi2JRUKJLypYFyQbo8Q5wcKKYUe7kcTnCIxZiY
	lvLlwJCDdNkl60yuka5EclwKEEcGIHhg+voKWoA4MVhEGwIerVVbAgaDSWwD5jZXq8eVOASG
	DGbcyiyCDXS3NHSbHgjGpy8gVqYRLwH1wB90ax03Qo0A0+IqzRpgRLEjyKvW4LZuTHA2d9bO
	nuCHutbNbEfiZXBp4Ve6TX8RrNV+hdl4OxhrMNK3ePGnSsTGbiBn0mD3bANTpna77g7ulDfb
	/RKwMVJn52yg76ywcxC4ndeE24aMA6vGE1YZJ3aD2nKd3RINKgv1myUxwh/UVi9gVjtG+ALd
	lSArAmIX6B3HbQ4XkNdjpm8NqGx6/L/cVjGD2ngPuGjSoaeRXZqni9b8p5fmaa8qBNMiOyip
	PD2ZkgdLef/eNkmS3oxs/okf2YaUGZcCuxGUgXQjgIGx3Zg9IfsoFlMoOHGSkkkSZBkiSt6N
	hFimLMU8tidJLI8mViRweWEcXmgolx8cwuGzn2VO5pQLWUSyQEGlUZSUkm3loQxHDyWa+Zef
	dJSjmBOudJxa3evM0D+IzkQjKn11RU4ftOw2lDBPu66g6HRr6ZhvUeSlgS8+rTrSl/XZyEGv
	lvDQD5X3rgq8ij+pL2otfWdilL+kDNJzJ3auZidGvitQnY/VT3oe66555Zku1YHRu1nrTp6X
	ec+7tGmiVE269Z4/v66m3qx/eMD7rPmk+q3kY9mke2Fj19s7hhPfaPy8LubwwY7VrsLS45cX
	FjrLjsSF1YhCb2FHWf4fua78/vpcbFjfcX/TC4fjmMJHT8ZHF6+/agyOH8q/30HtcW/3Kt3f
	PMt7Tm24OH/l+zvu59KHpEtesw+iids+7wfS1ipE6fxq9se69f3fmljLbFyeIuD6YTK54B98
	LwIWsAQAAA==
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3
References: <c06b2624-b05b-48d4-840d-beb208aa33dc@acm.org>
	<9b0990ec-a3c9-48c0-b312-8c07c727e326@acm.org>
	<20231017204739.3409052-1-bvanassche@acm.org>
	<20231017204739.3409052-2-bvanassche@acm.org>
	<b3058ce6-e297-b4c3-71d4-4b76f76439ba@samsung.com>
	<20231101063910epcms2p18f991db15958f246fa1654f2d412e176@epcms2p1>
	<CGME20231017204823epcas5p2798d17757d381aaf7ad4dd235f3f0da3@epcms2p3>

Hi Bart,

>On 10/31/23 23:39, Daejun Park wrote:
>>> On 10/30/23 04:11, Kanchan Joshi wrote:
>>>> On 10/18/2023 2:17 AM, Bart Van Assche wrote:
>>> Thanks for having taken a look at this patch series. Jens asked for dat=
a
>>> that shows that this patch series improves performance. Is this
>>> something Samsung can help with?
>>=C2=A0=0D=0A>>=20We=20analyzed=20the=20NAND=20block=20erase=20counter=20w=
ith=20and=20without=20stream=20separation=0D=0A>>=20through=20a=20long-term=
=20workload=20in=20F2FS.=0D=0A>>=20The=20analysis=20showed=20that=20the=20e=
rase=20counter=20is=20reduced=20by=20approximately=2040%=0D=0A>>=20with=20s=
tream=20seperation.=0D=0A>>=20Long-term=20workload=20is=20a=20scenario=20wh=
ere=20erase=20and=20write=20are=20repeated=20by=0D=0A>>=20stream=20after=20=
performing=20precondition=20fill=20for=20each=20temperature=20of=20F2FS.=0D=
=0A>=0D=0A>Hi=20Daejun,=0D=0A>=0D=0A>Thank=20you=20for=20having=20shared=20=
this=20data.=20This=20is=20very=20helpful.=20Since=20I'm=0D=0A>not=20famili=
ar=20with=20the=20erase=20counter:=20does=20the=20above=20data=20perhaps=20=
mean=0D=0A>that=20write=20amplification=20is=20reduced=20by=2040%=20in=20th=
e=20workload=20that=20has=20been=0D=0A>examined?=0D=0A=0D=0AWAF=20is=20not=
=20only=20caused=20by=20GC.=20It=20is=20also=20caused=20by=20other=20reason=
s.=0D=0ADuring=20device=20GC,=20the=20valid=20pages=20in=20the=20victim=20b=
lock=20are=20migrated,=20and=20a=0D=0Alower=20erase=20counter=20means=20tha=
t=20the=20effective=20GC=20is=20performed=20by=20selecting=0D=0Aa=20victim=
=20block=20with=20a=20small=20number=20of=20invalid=20pages.=0D=0AThus,=20i=
t=20can=20be=20said=20that=20the=20WAF=20can=20be=20decreased=20about=2040%=
=20by=20selecting=0D=0Afewer=20victim=20blocks=20during=20device=20GC.=0D=
=0A=0D=0AThanks,=0D=0A=0D=0ADaejun=0D=0A=0D=0A>=0D=0A>Thanks,=0D=0A>=0D=0A>=
Bart.=0D=0A

