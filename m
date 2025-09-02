Return-Path: <linux-fsdevel+bounces-59938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B55BB3F523
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 08:16:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E39B1894ED2
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 06:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C71FC2E1758;
	Tue,  2 Sep 2025 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NvGXBScK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="l9u+F8mC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8929C221271
	for <linux-fsdevel@vger.kernel.org>; Tue,  2 Sep 2025 06:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756793781; cv=fail; b=Y6B+644xf0ueelbNNhItLH6eOj8SWXMiacCrcoQdWZcpolFL8sELveyHOLWNf1NbJcCD6WUIIXwjaZuobuQTGzq1k1Oot14mCLJKgka+CQOWO34qiRlYJFY/pRXNEqKs39i9U9xle31IjV+60THPWo7xRuWnaKdve1EARy7NiLA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756793781; c=relaxed/simple;
	bh=V5km1gZ+b9mFodIY0BXuh/kETq+mRsv0GZX9D4FgKEo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=JbAmGQh2IiP9Rzu1MsS8OLLuC+NoZYQ93dVle5fJVUDzeiCefTXtFrUNaqsyWgtnjdoEwlzMtZhGk5mD95uYu/WK591+HEtXac6JNslNJlWGs+OjUzPaC0hUp8ayRQqi37ZeJdbJyDmTZu4RalfZkBi5/4eEmyk+YSfbnJbf52s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NvGXBScK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=l9u+F8mC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5824g0JQ013750;
	Tue, 2 Sep 2025 06:16:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=Mg6IzuLcA7RiyzFXGN
	ULMvYs/qhJwArFm1wJEGaE4wc=; b=NvGXBScKlqd0iP21++DPF2ovF7mqTjhr9m
	Hrj8pJpsGF8rNVsEFQqP2PngLc3IK7WCSikche2fy3s0fqqur/F7YCBMHzFf+8W4
	dEEcR5kiPzYJwir66Mv4XzjUCvlJjJtfnuH5xDhXuRaNdjPlgQI4Gz/Koiosmsdn
	prsb/+RjBPP8PJyH5+YEVks7f0xlMaUCDdBDRsKe8+XADaU7QgeqY3cv505fdYcr
	MPnfYLNf+NyVgyXgCMI688690bCufaLwXPHnl2+O6fTOe+KPBOfzkzAmbjDmqM0+
	IBXt70EtGYcTx/IUevmQG/Bc4lCD5PvS95uGNm0rGVuJZNBuOZvQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48ushgu9tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:16:15 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58260XPC004294;
	Tue, 2 Sep 2025 06:16:14 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02on2070.outbound.protection.outlook.com [40.107.95.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr8ptp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 06:16:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0EA3mQ5Z/29Ek++TKUQu5HrBxsk86ViJzqXfDmToGot6n11aRPoN6da/MJGMsMwt3XO+DugcfXENgFVeftSNx+i/ymEdU2n6uRFASBDeVxh45fFFI9BfY4TPdsNQpBwcBKu2Rrqya79YttoCD3c2NgfWwAc0SWReFeqy00dhbLh0PyCyIfVMf0mYdIMv092LhIuQV0ZHOghQC0lJskq7D2P8Xdu8phiUSH22pdEmA5WXLJnPH+KbWe6pHN3DG84WXv7Mv2K1BB7Oqd51hepuTa9DKBCRRus++QeHVTg5voE9kG7pFzIadvo8DkPq9nVmbT/1dAo1AkiSwvYqLsnHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mg6IzuLcA7RiyzFXGNULMvYs/qhJwArFm1wJEGaE4wc=;
 b=ZvSOVEJPe4lW/eMfWnxNrzyU5JYnv+nkiXBpPZonZJaD4Aoipy2F5jXOO1YAh87jLbjz8qMqg/OPI26Cc1mVz1dRtNZJjveijJjXram6okrJbz2Uz9jbu7CS01EMJ+b3Lozhi1jaKHGnB/ATxO7yb8KllXVd6RHrDpqRmi9VgFPbYSvDdz6sAyVtg1jIDVQ+G/BI+U4LmDcTdX+qDgwnKEZ+emnwfmO38+mlm/QJSirvgyT7Wf1xUWOUwwSey327oDAQ8jHi4rzTvfdlGpK1Yzq4xRCWzLX2rXkGmCpjgflF11SQ7QWNSw0CCK1SnfdY1+W+O33AA8wxFl16yPeTOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mg6IzuLcA7RiyzFXGNULMvYs/qhJwArFm1wJEGaE4wc=;
 b=l9u+F8mCUjZfT68kSS7w9DQ14m+eyuMHq5TM4poI6+XS9M+/F+rxCS4OrN/nePYSB9vQNmj2UpoDjrsjy1BTM9I7HVNP5zBSx4YUdu0vNNUxctM85muxSokntKGkKgyWv1FqqpFxEoG32vcnyn/CH8gqJNZ0zZ+RRvi+iLhp3bo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5928.namprd10.prod.outlook.com (2603:10b6:8:84::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.16; Tue, 2 Sep
 2025 06:16:10 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 06:16:10 +0000
Date: Tue, 2 Sep 2025 07:16:06 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Max Kellermann <max.kellermann@ionos.com>
Cc: akpm@linux-foundation.org, david@redhat.com, axelrasmussen@google.com,
        yuanchu@google.com, willy@infradead.org, hughd@google.com,
        mhocko@suse.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, vishal.moola@gmail.com, linux@armlinux.org.uk,
        James.Bottomley@hansenpartnership.com, deller@gmx.de,
        agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
        hca@linux.ibm.com, gor@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, davem@davemloft.net, andreas@gaisler.com,
        dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, chris@zankel.net, jcmvbkbc@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        weixugc@google.com, baolin.wang@linux.alibaba.com, rientjes@google.com,
        shakeel.butt@linux.dev, thuth@redhat.com, broonie@kernel.org,
        osalvador@suse.de, jfalempe@redhat.com, mpe@ellerman.id.au,
        nysal@linux.ibm.com, linux-arm-kernel@lists.infradead.org,
        linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v6 10/12] mm: constify various inline functions for
 improved const-correctness
Message-ID: <5ba768c1-5c23-4d3e-ae76-5f2d31483793@lucifer.local>
References: <20250901205021.3573313-1-max.kellermann@ionos.com>
 <20250901205021.3573313-11-max.kellermann@ionos.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250901205021.3573313-11-max.kellermann@ionos.com>
X-ClientProxiedBy: LO2P123CA0011.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:a6::23) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5928:EE_
X-MS-Office365-Filtering-Correlation-Id: 2921e06a-73ef-4e0e-59bd-08dde9e835ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UdS4BmPdECIFIXhDcD5k5I7EWRvZlVXFV4IUmeTJjqajjZ0227bGdAzwO8sN?=
 =?us-ascii?Q?LM7b1Pwwe5EexkYcb3H86bx0tiv7fJfpyZqm0TU++cljMhVG/A0HIKDJF3dW?=
 =?us-ascii?Q?CHsTb54rnjiRbCVI5giDVRjWqUaofK80Eg770bBdz+hV8TwxxFm6ccaSgZxt?=
 =?us-ascii?Q?4JdYtCagJO0xrBoIFJ4xlezNTYQ/mOVaTrD085X1Eu9OkAK5yxKKsbaq7YAs?=
 =?us-ascii?Q?Raoi0AVazZyCioC7p84exGC8ShusHn87nY+XeQAiDOUn6U1rPtKDXgIsatGz?=
 =?us-ascii?Q?EvlCwJnYSOLvhaWWiCO7aMHszPd+O3J6S2Hh6ufbkJEn4E8h0QIaSE7anBnp?=
 =?us-ascii?Q?LmFfpqtl3HA1P4UBmLh0X7w9ZVLvhaUt5MhusZ17ncMwC8+5ra6MM3XgsmIr?=
 =?us-ascii?Q?FgnZL9puX6YDr+SYRvB5R0Ld2clFlWapMLJ1Ew2xdSC55awgH4xfvh4Lm5AA?=
 =?us-ascii?Q?h/qZlfW4ZGf7d8cTqyPqE7Sn3FTw+WsGgzeCCCXFJ5/jne/1JVVglzxSS+lY?=
 =?us-ascii?Q?pVilZVP03N2LBFWZQNlBU4k2r0ta9siqjPNsOyTv56Rm4xM9WX+gi1swiZYG?=
 =?us-ascii?Q?lCdYdtMl0YSBRyrYS2lxMjcn4lsLNfVAtphioz2CnTPrmUicZsMMp9eSE9OF?=
 =?us-ascii?Q?/uZO+txLFZw59i3QYusziPWhl36rAlM5EyusWb9O8lIhI8Z7+7oOXdJ92rVD?=
 =?us-ascii?Q?ZAI9Pokf8nF82s/JLcxq9iC/rtIokUIXdBigDvSd5b8HT9eJ1cWRi1NpdEsJ?=
 =?us-ascii?Q?OjDIuaAif/KA+daO4i8gdiyfVCVBr8yHte3j4pC/6fziywntAgjyFUQjIggJ?=
 =?us-ascii?Q?CVjy4VbUdISsjWNGy5PclpQ78pV5f/Mdf4cai3zuaPs512Kl653L3uENx+0N?=
 =?us-ascii?Q?B7uIvSVNJ7u5NrUGCdiPAMOsWT/ix7nEoeNlVo8Hk2iLvosp6SIKqfw3sJxD?=
 =?us-ascii?Q?Bj5sTFylAmJrysj34rlj6Fz+BKFNtShz2ZJyqGWL4Xn939IfubRucCC6zaef?=
 =?us-ascii?Q?5EI33iNmc30N0r6dddAC6O4bXq2OeysYyMKv6zzevuzOT7oZi6goAu0KKuzd?=
 =?us-ascii?Q?XA7s/KiR1YO+bIWZ1L0YXrHjYbcoW2EnnAFtTzl8Z5pk6R1Y9fB3Cnv5X4KQ?=
 =?us-ascii?Q?UFMgwfbu5ZQCIDDKhPYIBiJt78+adugX1Ir2IA7Gm26RXZxnY120Nov+tZPM?=
 =?us-ascii?Q?qOLQ9I04a4Y0CdcgjmxstLhaYsk0mL0Xrm8NerDtV9isWdoExERnl/FN7y/i?=
 =?us-ascii?Q?UJmtNU5Q9lCpEzEC/GThKO824gyGO2n2wRlJVuLM8LIgu3ZH5AvYLfHYks+/?=
 =?us-ascii?Q?GgXHlUpI3VOnwwW7lu8z2rDnV5KTbP34P0/vLyCPZYJuuZcZ3HKFXYYDnK04?=
 =?us-ascii?Q?9bBD3tD1ZCdhfv5V/kS8RCDDO2wsMT2LiNL1Wr3zq+WlJPAAdYqQfkazLmNE?=
 =?us-ascii?Q?Wy1jnRINK4o=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?h1akrbL8cyUqukNYPgj46XFdwgp/ZjJx+nRd91KydL97dE+cfAtrszY11CuZ?=
 =?us-ascii?Q?wHe60Gfxc9y3BoKqaGDZXiCCStt1ZEP1UxSxIfPgohPDeGmhZmwQiWyetLCV?=
 =?us-ascii?Q?B1mvsahKga6K0lVz4n4uG6Bto4Ticpd2mtLdEeo38SEWq5xbbPCyL2scfUqe?=
 =?us-ascii?Q?4Rze2GNPAscnOu1H3GQ2TyMErXA0rjoA1ozUPnDa9XVUScmLTijx3mxu5WTK?=
 =?us-ascii?Q?bym5m0y0imnGZmIqAtJjx1e33windZaB63spOrjrkGVvaFV8/+I/os+2pVBx?=
 =?us-ascii?Q?WfXsxLLktefpCvoOfROC+5PyRus/GAJp+WyWDipjQxst1Uvfy0AyY8UVck2N?=
 =?us-ascii?Q?FkkGjQ1ycwmfewSqx8Mnfln4aei+utCAMuqrzJSMmakvKnTa1UNqk7ZjVZIo?=
 =?us-ascii?Q?cuPLav7XQbpEv1wPtTQRkUYLcX263yylmGKafouXOQkZ51UcIh5ZiIgKcEKV?=
 =?us-ascii?Q?KfETQAwdqikS8Wrmdf8GrsP7/p7BnWT7BVYe0nvsq2MZKfSnw52V6rvNtM7L?=
 =?us-ascii?Q?OhbX7uRQ8UB92X7/Lu07HUvVXMeZieuKR+9m8bncNr+eaCtTT4G/VeoqtC4g?=
 =?us-ascii?Q?s7r/TUd+yCqT9kg5oDrN2HTMB9ikn4kZ/0+HzX8Hd9JVa/U2TPmWyn/UwTkE?=
 =?us-ascii?Q?pWBlFIAvBoQNNg6dPMKR3jy/0E0l0L5Z3+gikE9Lz7e0xRvzzDkykunX471X?=
 =?us-ascii?Q?ZZ3PtgM16ff95aRW0DqP2BzH6NcK3Yd5L0TsLpIX06Y7Flw3h5nYEhTDRSz9?=
 =?us-ascii?Q?hyNMyRdNfmB062PdYPp97kJo5F1nPsBsyJJ6TrbfiMEvIg/37zCqUscandO2?=
 =?us-ascii?Q?yUMK9io+jglY/xfhXN0T/b0jM1caSEEP1qGy1Fcz4nGpqqA/msTtJLyRFH40?=
 =?us-ascii?Q?XLliaALRiN8h9RCzf4WZhsUmpq1N0Rcm1x6wG4jimOx4Gr8oj1zs8VPh7Qnv?=
 =?us-ascii?Q?VbQyP4rOqN68IGWOkbd9oVa4OnxtkvXpguL3jiFrVSice6WVJgymbBsj/Qu8?=
 =?us-ascii?Q?qww3SsQv08fKd5r8CImEgdgdv0e7+2nUISi6sYogKmC2AP8fvHfaAtyKhquC?=
 =?us-ascii?Q?0y3EiIW3S4kvE7520FUeD/HYmDHKCFOQFzL6gAvDlJ6sr/90vvdrjKyjuD+k?=
 =?us-ascii?Q?Ka1D24Nt0vj4PDYJd4QSq7NfwXeNsOgGf0F8L383kHuVabyikqCa9TIOyXy+?=
 =?us-ascii?Q?A0mX5T56/t6BJbSb3qYnzusqi4pJj+z6H7IYA/aB6ARIkkkLlJuMnl0ZAWO2?=
 =?us-ascii?Q?CW5uu2+1pMp6ff8/x98c4Hs344kQ0y2vQ9HRrFvbH+lt4vBR3rZQDZDVooQ5?=
 =?us-ascii?Q?WWgbWYf5uMaXyLwuco8xfhENHNo506/KBeVOrieNdrKQvB392B3S0Snesj8A?=
 =?us-ascii?Q?ZTf6jDYf8YE/IGClmOucQGP+OTPqZqvWdd8B5MeyUXvydnS6g+6/JUhtdndK?=
 =?us-ascii?Q?T/nmIkjH59oFCmG4uFG3SeZJq48zCodfXiqvbRO8OVB1xO01jcoj9pD+zUwI?=
 =?us-ascii?Q?WBzvBTGsTUB/Nnzn6vBE8U1xl/HPWR0EG4u3neG0s7ZuaGj5Qj+L8TK0nTwx?=
 =?us-ascii?Q?VIrSBUIMIMZqjgBL3VNboQqzNBIUknZjuVpB7woOOQfEJaFOTW8KkXod/xoO?=
 =?us-ascii?Q?vA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JMYNyBthVd3F7jN1A000emoqKFrLpCuPX6HytGLGpyTIhd/4IJTIXPN2KyTzMY0SOVzZz4Qumle+2eoElgPPuJtHo6Hqop/U5IRqdD49BwEGs+1FvF2jx2Ahphv1wUFe7wYQvw5d5BV9SMb+6lXRai6HkM+swyIgTmb9qVUaRHNG+7bRidl7KKSrEgycg3cl7JzrN34kU9V5N6O/0Oj4MpDZyjMbu1QNjAQrHe9zAMzZlkJp7O/kkRkIiA3UlaY38yZvwNlSv6b0aqBQ2QwVOLjO/AbNcgUP9r/m0/mSVugVuS1AM0yWBcnO+W/c1PDtoB+GIAa8cqmxpMswx2Kcw5z/jBiIUWvQeSTOWrJrgQwYRkT9KLn0A8/JdWNMdohmHNjPRaLHjKO6e6/20M0LrnDSTb3FBtnkaURXLBkFdmg4itSR5qGJ+Ls9ksLrnZxr9Z+C2ImuC7M08bJoY5EMIggQuLPgIBgbKWRgwySxRPlz3LBOXH843YL8mrf/AJGqEwqv3/UmbuQPttAteez7QYggh7EHDlsSWnHHTYx2deIvJ7dziUiLbRiHlwFXgFzjSFy+MRyQUk/yiT2feO7Y5YrCf35nTfK6EQwfTRZEHbo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2921e06a-73ef-4e0e-59bd-08dde9e835ea
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 06:16:10.3334
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LCsVH3C3hNcAnDzTc3wVqpbT1KyVy3j1WXISoi9TWKFmzeEO5wUWFe4PHZ4UXZ3qBK1myLiymKSPkQjOx0kcKMCiJs7r/of+RvuYMERdtUU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5928
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_01,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509020060
X-Proofpoint-ORIG-GUID: 5j85VVwJj2SApJ9vsZ-Ge_kOpSVNaaKc
X-Authority-Analysis: v=2.4 cv=YKifyQGx c=1 sm=1 tr=0 ts=68b68baf b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=52u9k6-QHIpcbhxlR9sA:9 a=CjuIK1q_8ugA:10
 a=-El7cUbtino8hM1DCn8D:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX3YeshEk5CQpf
 uEhxdGa+Rmvc+skK9UPJRxgedczBjS3pIopq7msQc/P9JPjJ4CTHRUZHVbeQPAg1UUsiWekhMsO
 BxEUGeWwYBnHIJHD6u6dpd5F81i/CcY+ssHZDosU/Zd/9YSUkxytAf9ec6I2jDxmcTjwmZAQ/Td
 5dSQBuzajbJyewzE5QUN1QTktRMf2yz1qpzIxNtInfVBjkFzft79Cykn9rWSsojk7H2uMLh+gFG
 3yl5Aei0n8gh48r5Vw1W5PwbaV69Ol9alZfN4+Ex5qnb6Wm5bkafAOt7Wh6evNZEpWh4ahGAZW6
 80o58ppPzYsIiwld4exMGiw+L/UbIpvTuIXqh8GyaUBB5wIfFb3MKug6jOh0Fgysk395ayOXbnP
 Coyo3SQa
X-Proofpoint-GUID: 5j85VVwJj2SApJ9vsZ-Ge_kOpSVNaaKc

On Mon, Sep 01, 2025 at 10:50:19PM +0200, Max Kellermann wrote:
> We select certain test functions plus folio_migrate_refs() from
> mm_inline.h which either invoke each other, functions that are already
> const-ified, or no further functions.
>
> It is therefore relatively trivial to const-ify them, which
> provides a basis for further const-ification further up the call
> stack.
>
> One exception is the function folio_migrate_refs() which does write to
> the "new" folio pointer; there, only the "old" folio pointer is being
> constified; only its "flags" field is read, but nothing written.
>
> Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

LGTM, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  include/linux/mm_inline.h | 25 +++++++++++++------------
>  1 file changed, 13 insertions(+), 12 deletions(-)
>
> diff --git a/include/linux/mm_inline.h b/include/linux/mm_inline.h
> index 150302b4a905..d6c1011b38f2 100644
> --- a/include/linux/mm_inline.h
> +++ b/include/linux/mm_inline.h
> @@ -25,7 +25,7 @@
>   * 0 if @folio is a normal anonymous folio, a tmpfs folio or otherwise
>   * ram or swap backed folio.
>   */
> -static inline int folio_is_file_lru(struct folio *folio)
> +static inline int folio_is_file_lru(const struct folio *folio)
>  {
>  	return !folio_test_swapbacked(folio);
>  }
> @@ -84,7 +84,7 @@ static __always_inline void __folio_clear_lru_flags(struct folio *folio)
>   * Return: The LRU list a folio should be on, as an index
>   * into the array of LRU lists.
>   */
> -static __always_inline enum lru_list folio_lru_list(struct folio *folio)
> +static __always_inline enum lru_list folio_lru_list(const struct folio *folio)
>  {
>  	enum lru_list lru;
>
> @@ -141,7 +141,7 @@ static inline int lru_tier_from_refs(int refs, bool workingset)
>  	return workingset ? MAX_NR_TIERS - 1 : order_base_2(refs);
>  }
>
> -static inline int folio_lru_refs(struct folio *folio)
> +static inline int folio_lru_refs(const struct folio *folio)
>  {
>  	unsigned long flags = READ_ONCE(folio->flags.f);
>
> @@ -154,14 +154,14 @@ static inline int folio_lru_refs(struct folio *folio)
>  	return ((flags & LRU_REFS_MASK) >> LRU_REFS_PGOFF) + 1;
>  }
>
> -static inline int folio_lru_gen(struct folio *folio)
> +static inline int folio_lru_gen(const struct folio *folio)
>  {
>  	unsigned long flags = READ_ONCE(folio->flags.f);
>
>  	return ((flags & LRU_GEN_MASK) >> LRU_GEN_PGOFF) - 1;
>  }
>
> -static inline bool lru_gen_is_active(struct lruvec *lruvec, int gen)
> +static inline bool lru_gen_is_active(const struct lruvec *lruvec, int gen)
>  {
>  	unsigned long max_seq = lruvec->lrugen.max_seq;
>
> @@ -217,12 +217,13 @@ static inline void lru_gen_update_size(struct lruvec *lruvec, struct folio *foli
>  	VM_WARN_ON_ONCE(lru_gen_is_active(lruvec, old_gen) && !lru_gen_is_active(lruvec, new_gen));
>  }
>
> -static inline unsigned long lru_gen_folio_seq(struct lruvec *lruvec, struct folio *folio,
> +static inline unsigned long lru_gen_folio_seq(const struct lruvec *lruvec,
> +					      const struct folio *folio,
>  					      bool reclaiming)
>  {
>  	int gen;
>  	int type = folio_is_file_lru(folio);
> -	struct lru_gen_folio *lrugen = &lruvec->lrugen;
> +	const struct lru_gen_folio *lrugen = &lruvec->lrugen;
>
>  	/*
>  	 * +-----------------------------------+-----------------------------------+
> @@ -302,7 +303,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
>  	return true;
>  }
>
> -static inline void folio_migrate_refs(struct folio *new, struct folio *old)
> +static inline void folio_migrate_refs(struct folio *new, const struct folio *old)
>  {
>  	unsigned long refs = READ_ONCE(old->flags.f) & LRU_REFS_MASK;
>
> @@ -330,7 +331,7 @@ static inline bool lru_gen_del_folio(struct lruvec *lruvec, struct folio *folio,
>  	return false;
>  }
>
> -static inline void folio_migrate_refs(struct folio *new, struct folio *old)
> +static inline void folio_migrate_refs(struct folio *new, const struct folio *old)
>  {
>
>  }
> @@ -508,7 +509,7 @@ static inline void dec_tlb_flush_pending(struct mm_struct *mm)
>  	atomic_dec(&mm->tlb_flush_pending);
>  }
>
> -static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
> +static inline bool mm_tlb_flush_pending(const struct mm_struct *mm)
>  {
>  	/*
>  	 * Must be called after having acquired the PTL; orders against that
> @@ -521,7 +522,7 @@ static inline bool mm_tlb_flush_pending(struct mm_struct *mm)
>  	return atomic_read(&mm->tlb_flush_pending);
>  }
>
> -static inline bool mm_tlb_flush_nested(struct mm_struct *mm)
> +static inline bool mm_tlb_flush_nested(const struct mm_struct *mm)
>  {
>  	/*
>  	 * Similar to mm_tlb_flush_pending(), we must have acquired the PTL
> @@ -605,7 +606,7 @@ pte_install_uffd_wp_if_needed(struct vm_area_struct *vma, unsigned long addr,
>  	return false;
>  }
>
> -static inline bool vma_has_recency(struct vm_area_struct *vma)
> +static inline bool vma_has_recency(const struct vm_area_struct *vma)
>  {
>  	if (vma->vm_flags & (VM_SEQ_READ | VM_RAND_READ))
>  		return false;
> --
> 2.47.2
>

