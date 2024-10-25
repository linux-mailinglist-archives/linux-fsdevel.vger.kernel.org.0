Return-Path: <linux-fsdevel+bounces-32991-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F3CF9B127E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Oct 2024 00:19:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 097A7B22064
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9B8420EA55;
	Fri, 25 Oct 2024 22:18:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eIzzoldl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="WnczgBfn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8996B217F29;
	Fri, 25 Oct 2024 22:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729894731; cv=fail; b=dsxW9jPWHQYCE0nmzoh+qncIeL402M5m93bdYUiMsDzYczMW3INVwBtGp8V9dhOh0OPhTteU3GUoVnlqSAvafSrS52EQSb5OKZ2L1mhVc81XzgNROW8yf5eS8sua3k6lqKzrKn438Swqgpku83LeeHXJlt2G6NWd/xEVkRFwA7k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729894731; c=relaxed/simple;
	bh=wczjE7Py3axZNRzewI49qetccpwng7xL46Z8Kj29Ayo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Hn35z83EuQNNLDOd+gPBAMc4dKJUwKBREp60w86mxy+2SE4HhjRkE/kgvNhGWFZT+KIk8iLE/AWxUftKjT2nB00s/F9vTW+2ttOe0zw6/A0IVj2tO+iT9ff9P8EMvQ2gfvxuImP/MNiEzdiRoIgCJhLAVTDQTzGkIw/c1LoNgOA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eIzzoldl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=WnczgBfn; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PJdTDW004855;
	Fri, 25 Oct 2024 22:18:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=wczjE7Py3axZNRzewI49qetccpwng7xL46Z8Kj29Ayo=; b=
	eIzzoldlBpm2kU/dHwFkk62qQNlNWhF3pDRH0ScWNi2jMgzw0T0+RZUavOmCjbL6
	7+0ecuUg4tQ1M9C3P2c2SFPg1+1TydMsMADdPej8Hm95Cs00/ZQXTRcs5nwEjL6V
	1cCQssolf9+FQNsG98Ed6I9KtIEEX6gDSOQavBYVirL2AAMDB22vraduhocQKgDU
	qIxy6lVEbI6ggrPoy6dK7kFUE9lbi1/T6YxFUpKPk1ijgvAjU9biXPyhenAiGyZN
	Rpe03ceHUX/F9iF1zBsc6Dl7kGOHDk0oQ4SxqnpgTiVjEfBSjHj4nbReY/6Mzgs7
	B++IIwL37gMesEBAe+BEPw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c5asp1jv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 22:18:30 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PMHAgK021086;
	Fri, 25 Oct 2024 22:18:14 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 42emhnxdtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 22:18:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qYa7ZjJxJZrP8y7GqB1P/eD7V2paTf5Pm88cPkTKfCFmZc3ieQMLUiQcsiJ87Un5HRtgacYvWXNsUNclVOlhXBmOsPbAG3T5ngGB6YhWqO2WZYiWqKQj/hqz6kl6UVlgR5vkH8twq5I2h2GVL/ZizeL4WyhJhDWXC5X68Uk3Y0BYasBzU2SuhKvcsBj8ttUyL5EGVkd55+QRsw5oqj2sZ4tP+DKCqopfFCZ01EVQNTGubyWYXZH6N5svRyuvdmPy5hcFA6uej8/3vdznzc8AJcsPnxOhh6Q/xSAM27vKxlBKbiQOBOvYXNbbAODY4NzWYXalffJQnHVeNjlrXNbmbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wczjE7Py3axZNRzewI49qetccpwng7xL46Z8Kj29Ayo=;
 b=hZQgrif2ya69vNqlv5/85wnnlR5xCS7VDlC4ivEcciRkb2gl51vK1k5nL+BcU7xB6aqKQBIYmNt6eUi+U1WgFnriNgQOpzuS7iqMUS9t/sH8r86E1uw+4OY1NeQzxuNli4hPhGXSZx5ajhF9UL1Om/lKL677vpxSzZpLrf4O29rNWQj7nTbXE1aB06c9b3wPxKy1my+yfWN18Ps2BZc+72Zqkn5y2vNZ3Ix5mNuArSwHLUP4jKwr1HRstW9cPJ38yCKMQB+qeI4EvvgzXTwkHYQbGNzMVrsnGF11q58Wubt4E8YrxHcEET/4CApQIbqVBzfDYqgctF2D98Dc78bjMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wczjE7Py3axZNRzewI49qetccpwng7xL46Z8Kj29Ayo=;
 b=WnczgBfnC4Yhjn1T3iDO6QDsuD9WGMg9Xri0ImR9tVNq28jyy9kle6qvdgiGbRHZZ9oSe+a9CYTU1ryiYhNjNhruoK+PK7m141JaHYiydQ/zMaqFrYAJr6aDGoZ1OE7dIX/XEkDIGlYDepMmQ5d6PfdbfkH3fOLrPVFVg9Mvgg0=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by IA0PR10MB7381.namprd10.prod.outlook.com (2603:10b6:208:442::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 22:18:02 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 22:18:02 +0000
Date: Fri, 25 Oct 2024 23:17:59 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: John Hubbard <jhubbard@nvidia.com>
Cc: Pedro Falcato <pedro.falcato@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <16e58180-16c1-45b9-b93b-e722bf686b43@lucifer.local>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
 <828674d9-e862-4438-86b6-61977f4cf3b5@nvidia.com>
 <CAKbZUD0fxczjSJo34MnWRNT4M6HTfWN0DRXr9CFe_+cKJW_mog@mail.gmail.com>
 <e5ac648b-88d7-4fa6-8eb4-d061a4b2baac@nvidia.com>
 <31dd0e52-9868-4cb4-aec6-d8749cdd2560@lucifer.local>
 <9de8d876-5729-454b-bf8c-8b0ec8f8ffc1@nvidia.com>
 <239456b7-4045-46cd-a2e7-8445dd6640c6@lucifer.local>
 <330c0dae-fa8a-49e5-94b4-25b915f74e37@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <330c0dae-fa8a-49e5-94b4-25b915f74e37@nvidia.com>
X-ClientProxiedBy: LO4P123CA0404.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:189::13) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|IA0PR10MB7381:EE_
X-MS-Office365-Filtering-Correlation-Id: 0370c8e3-1a8b-4d32-d6d6-08dcf542e425
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|1800799024|376014|366016|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dzMwMlUrem85cXNhNlBSS0lpdGxYTUpoVmJhRWhHWHVwYXdLc2IxM2RVejRq?=
 =?utf-8?B?L1NLaUlUMEs1cGpmbWtwM2Eyb1ZuU3RMZVZNWDRDb2FBQmQxUnZZd3M4bHA5?=
 =?utf-8?B?cWlILytzTlR5TmZTUzUyTGhHckl6bkNkWEJHMUhhSGYreWZpb0lXMFN4NVlk?=
 =?utf-8?B?ODlSdjlUTWYyTWVNQ202VWs5VVBzdXlnRm9GNkxWMGoydktta2dXdGFOaE5y?=
 =?utf-8?B?blYxN2xhTFZ6NXNEOUpoODY1YnFCZ25mMW1JTG5TRkdySFFQWXFMUGpBM3Qw?=
 =?utf-8?B?RE85dTdnSDN5WUdKdTdhRnlDVjhlbVQzWjNnL0xZSUMveWpHa1E1aEtoZzJO?=
 =?utf-8?B?d0N3a2xhTzFCTkkvNmpYYk0wY2VoeFBEdXF1WGc1bVVHRTZLZ290eUFaTW9x?=
 =?utf-8?B?cDdKU3QvQXBkd0w2eVoyeWtCYjlkUzR6MFB2VDZ3eFo5dkk2RVRKc1NvaC9E?=
 =?utf-8?B?YXdENTh4YnRxZG1EMTZaUVpnQTFsVTZ1RFBWOThKQi9JOGJkZi81bnhBcXpG?=
 =?utf-8?B?dGFxa29peUd4UnN0K294OElPVjEyVEg1L3BndFFWVmFiZGVqWFIvZ0xMNkFy?=
 =?utf-8?B?ZDFVS3JZZ3I4V0xtWHVxZHdTRUxnaUE1RmpYQ2t3d1NGNDEwckRDbVppYTAv?=
 =?utf-8?B?d2pVOGJXVjIwTVp0RVNndGFLN1R2aXR3SjRYaWpQWVM2b0g1VTczOE5xakth?=
 =?utf-8?B?Y0JBbTRCYm5kVFg3NGNGQ011MTRqYnJ1QjUrY2pyd2hsYU9udzQrWVhhaE9I?=
 =?utf-8?B?ekZoaHJzZmdJMWVQN3EvdUxwaHliSEh5eHFxKzV2MXBDb25wSlJyK3dDaFFo?=
 =?utf-8?B?dnJRRU0wNHZRQkIxMXZSc1ZTeWFCYnlLY2tFZS90Si9jV1VieUlKUUFVSm9J?=
 =?utf-8?B?cktieHZjN24rVmp0ckx1Nms4d2F0ZE9ZbzV0bmUvS01xY1pvdVMyK28zVU9q?=
 =?utf-8?B?Nkd6cERRSkFyM0N1Ni9UT3cyUFRiVjd3TWp4Vjl5TG5ZNUdwQUlWUm9iczN3?=
 =?utf-8?B?OU9UemVUWXB6QUxad0VUa3FDclhlZmtOSWVGbm5vMHVUb3p0VVhlZkdvOWJE?=
 =?utf-8?B?S1c0b2xRNDlweEk0Tit5R29wNVVIRXZpTnRiRjl6MDNTMFNOM2pJcGNxVXBI?=
 =?utf-8?B?Z0JYMWtxZ2IxcFRyUUJWU01mdmwyaUcydEkycHlTak04VGVrNWt0MjJrNUYz?=
 =?utf-8?B?UjJIV0wwd01zcDc0OWNTa1RoQWh4dzk0cmdyZ2wvT0poTDBja1F6WWtIWXcz?=
 =?utf-8?B?Qk1Yb3ZnM1pSbTgza0I5VHpnQVV3dmZOV3hObzlxNysyQVlxWVRhK0FmbTVI?=
 =?utf-8?B?bVlDNFZVckF2dkJKaFMxTzlpSEIyZHQ3MXRzanFiamdyV3N5VlN4ZU5jejRJ?=
 =?utf-8?B?TUNpc1hMcFFWSUMxRmpsanJWdUxSL1Y4cjJYWitBREJZUlVGR2J2TmtsQTBh?=
 =?utf-8?B?OFJDRmQ5bHB5UmcybGxuRTJKSkpBdHU2WUlId3ZSMDZ0WnIybXlIT1cxOTQ2?=
 =?utf-8?B?K3BGamR6Nnh2cjdEMkJkdUtvL3ZaL0lBajNYUDVrSTJkY1AyQ2FBU3c3QUFa?=
 =?utf-8?B?aTNsSUZhUkc1YmRXRElZMDhTdDJiVTVzTnAzYTAzR3ZGVWNQWGNoNHdwTVIx?=
 =?utf-8?B?aHVmVmJoN3RMZU8vdHQ1anZzaGw5TmF6VVpwd3BlRklHL1hQd3UzS3l4UFFG?=
 =?utf-8?B?cUo0d1Z1TDlLR1JUY1kzOUtpT1B1RzFwOEVXQUJpZExlcWk2cGNLS1lpOWJ0?=
 =?utf-8?Q?gFn/U9dSB1aKEMGoPCNdNBivtBbuCs3OwkoGLmT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(1800799024)(376014)(366016)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bUwwVFlmOXkybGh6UThlb3pxOXMvZFRWSEFka3JnaFpHR0RVeWVMejRNVldM?=
 =?utf-8?B?d2tVbk1rZzMrMzJuOUJEUGpQZnNaZkYwZ2NDVG42STg1NXVmaWs0QkN2eVBH?=
 =?utf-8?B?dm9FcDdYZ1l4MjB1VExKTjQ3Y1kvSFk4cG8wOWJvS09JeWNMVjMzaFk2L1RU?=
 =?utf-8?B?cTJhZjd5R2p4K0JFMUk1WmFYVGNFZWF3bllyckVEK2hrVmRYUjhLaCtrd1Rs?=
 =?utf-8?B?dFcwcDJPbHV4TlE4SlZpaFkvM2FuM3FpejNBUENiYTVIaFQ1ZEVTZVZWSWZO?=
 =?utf-8?B?aDVObitHRko0MUxCSkpVVUVPNStLenAxSGRpcE1vMzhCZzNnZ2pMTE1vR1dO?=
 =?utf-8?B?WU9zK0Jid1VCejgvZ3k0MUJBNEJkSVE0S2d1cEhzKzVOOE40WDRDZElTa2lZ?=
 =?utf-8?B?VjVJcGFGQzlKUDNMeWN6MlhPRDRWYTEwWnBhY0VCU2dnUmI1Mk9qcnorSVZp?=
 =?utf-8?B?WkZsNVhrMzRjd09NV3FlcDVwQUJseGw3ejBTa2JSSnVJS0ZNaEpmOGJaU2pP?=
 =?utf-8?B?V1ZCQXhkSTdkV0VuMzhTUE5Zd1A0SkxCeTY1VUsxL2V0M3NsSlphVFRQRW5K?=
 =?utf-8?B?RHFMcFlWQ2k3TmlYSEgycWtieUhFZ0VwZFdCaHNVdFIwaDNaRzdnR3cxVjh6?=
 =?utf-8?B?cXh0V3VieS82RHZTYUYzOHptSFFnd2tVY3hVNzlrVmlJK2RWMmZQdVlwQ3BF?=
 =?utf-8?B?aW9TR3p6cGp3TkErVC9ieFNBcGdScytHNys3K29QK3FzSVExWEFSdDJ6ZWdk?=
 =?utf-8?B?Z0oxYVVDRHpZMWVjTGkyNlIxbVFjbmFaeXIvbkVidmFjc0N5MnhGRktuL3Vz?=
 =?utf-8?B?TThxUE1NUmwrWXZJOENKNlA5K3NFMFU5T0hna05qemp5bEQ1RmVhV2MzWTdr?=
 =?utf-8?B?QS90OTlQQzdzYnI3U1ZNNlV3R2xyWklwRktmR1BUNGhhMklPM1VWMkI3UjYx?=
 =?utf-8?B?dkk1L2k2dm84MTFhbXRWMUg4a1VpU2pmY1Y5SG9DeXJlak9uMUZtR25XbmNp?=
 =?utf-8?B?anNDdk0vayt6c2ZyNWYxeXZ3VmVmcXFJQlM0UXFHV1Z4T1g1ZXJRaTNjUHI1?=
 =?utf-8?B?akNEWHM2cStqS2lQc1FNWVh2c0JRRUV5cjZTTlNZZUc1c2I1UUQ4ZXkzNXBQ?=
 =?utf-8?B?RE5nek9kOEhia2lRamVIamp5dWlwL0l1Z3l5SFMwWUpLYUlObm1uZjQ1aWIr?=
 =?utf-8?B?ZjdyeCtYRDE2RysvOHBGVVFJVmVqOE5Pc2lqT2hremxzWHZraGxWWm5HTUk3?=
 =?utf-8?B?QXlaNmxpVzFVeEFMY0UxRHpMVEp2UmFyWHBXaVJabnJYRDJBWTYvQmVrTnB6?=
 =?utf-8?B?cFhhUThGTVlkTVFFbmNQWnVXWWwzaEtkZzFNQU51UDRTVXNjNDRmbnQ2TFVy?=
 =?utf-8?B?U2pSQ20wS1oyMUdveUxRQmZVOXVtcUIveUxsemp3SXRIS0NtU3V3NHUrck1t?=
 =?utf-8?B?M2N0YjFIb0xvbDhzOEdtZGlrRnFPdHEvYzhHcWdtVHd1M2VuemNkY3R1d3Zl?=
 =?utf-8?B?dlpYamw4RVlqVUt0Q25HNFg1S2Z0dzEyc2g5cnc5bzQ5cDNvZXJMQ05Qanh1?=
 =?utf-8?B?M3o2cG5LTjdzeVl3aU9OemZYdHpyWW5vRTBJSy9WOUFEMHI1Y1ZEUDBEb1ZH?=
 =?utf-8?B?b21xOFI3Yk10VlFQZjZoUzhQcFYvWmVmQXN6UUJ2MVpHUXZmMHlUQkI4MjU3?=
 =?utf-8?B?VUlidjhZdDQ5UmZ3ZXlSamx0a0RUTXY5RU44Y3RWRHdxL2RUeFhQZklsK1Aw?=
 =?utf-8?B?djNxRTQ1bUVuVWhTaENNQWJndDNMNzQyWkM2UENEWlY5ZHQ3cUVRczVRRGF5?=
 =?utf-8?B?MWRJL1I3aGFoQ2QxNUtjYW5weFFueUF2L3IrUFFnSDAybVYwTWEzRmFIaWN0?=
 =?utf-8?B?U1ZtczVsQXVjd3pKaU9mMDQwRkhwcW5pWU1PSU5jM1RNRkFqd3JpTFB5K3Nr?=
 =?utf-8?B?MnFCejBjcWlsVFNyaksyVWxyUTd1YktIL1BubEhSbFVMbU5BeUJGeVBldHJ1?=
 =?utf-8?B?QXJyeVAzbFRUaFZsT3U0V3F2SjB5YnRsK1pmNTJhYkdJbWZLU3A3TXYrT2lH?=
 =?utf-8?B?cDhpaEI4ZnF3dnlMdWZJb3Zzb0FnbmxXMWVTcFc0Ni9IYjZMNUdNczU1L2xh?=
 =?utf-8?B?NXVYNFZqcnBiSzh5dkVLR1JPYnk3VUt3ZzdWWlZnaXNaQzlsV3JrWFZ6ZlJx?=
 =?utf-8?B?OW5PYUxhSDRjdUhlNGRsVk1SQXM0dVVqTFd2d0VHeTZOdkZtL3RPc0xCNS9R?=
 =?utf-8?B?VmhtQUppODRHWjVYR0w2VjJkZVFnPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PoNc774y1Qn3Izts0eECQG4pj4BBcLhFXEDoWt5D5YwkP4aMkJ5Xgau4fsZcNFoD6hEgkzJswh0K4ApbtvW3qYqlcG8u1+kxfm3bwoqFsW+s0DWaJTi8KN+/JNxCS4pvwR4qplpEUvSjcMvkf2RlGYL1biYL7ZkSc/9viy1wD6eYlIIlFQP/MlNQFpqEl8DBFkWj8UpNUEOudwkRtm6+gdHwGgv+NVxN6U10/AicOB2BfJrH2zKJEujhHX4TMpO5JZcBxXcwCpHzM5m09o7gPpx14mR5HrmfJ5ll9QdK8bkaa1FuTqXajxFQEKylwR591HCJiC3As2KuaX/u11UqhXCtI/jMTvWDzJMZzwVik3IoES8watqeJmX4GQTCSVK290Dd6sYWM7vDFFOKu3RHU4CvWefaYgGjc39i7DWZCf2Wordwu3T8BcXzNPfeaA9qyFVCBRvo3SzfbiY0OGJ+w309tUKIwwj+2Acje+gu86bdAITKU49AqJeWk98ZCR6XtAXjx7Hq77QeycXnLuX6ShXy9GAK7e5XXApMNMzUVX5ZNu0EaSi/yxAPdL3lo++bGfA9LZjKPLq5Mz0n9hSrNcFZ/J173gGDxrzinuLpntc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0370c8e3-1a8b-4d32-d6d6-08dcf542e425
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 22:18:02.5531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AlQ39rmuNweHDo3V5EKvNf+b/7Oo3azfVoKaQeHDQI1/wRt19zNi3X8fKrWEXRQA9THqttX/JtS5IJ8i5cqnXyTnvqEFpWI8A0g3NF5nNuY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7381
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_14,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 mlxscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250173
X-Proofpoint-GUID: U1o4U5cwCy-sOrdsDOxWxi6Ruc3MUAOJ
X-Proofpoint-ORIG-GUID: U1o4U5cwCy-sOrdsDOxWxi6Ruc3MUAOJ

On Fri, Oct 25, 2024 at 02:51:29PM -0700, John Hubbard wrote:
> On 10/25/24 2:09 PM, Lorenzo Stoakes wrote:
> > On Fri, Oct 25, 2024 at 01:31:49PM -0700, John Hubbard wrote:
> > > On 10/25/24 12:49 PM, Lorenzo Stoakes wrote:
> > > > On Fri, Oct 25, 2024 at 11:44:34AM -0700, John Hubbard wrote:
> > > > > On 10/25/24 11:38 AM, Pedro Falcato wrote:
> > > > > > On Fri, Oct 25, 2024 at 6:41 PM John Hubbard <jhubbard@nvidia.com> wrote:
> > > ...
> > > I'll admit to being easily cowed by "you're breaking userspace" arguments.
> > > Even when they start to get rather absurd. Because I can't easily tell where
> > > the line is.
> > >
> > > Maybe "-std=c89 -pedantic" is on the other side of the line. I'd like it
> > > to be! :)
> >
> > Well, apparently not...
>
> Why not? Your arguments are clear and reasonable. Why shouldn't they prevail?
>
> Please don't think that I have some sort of firm position here. I'm simply
> looking for the right answer. And if that's different than something I
> proposed earlier, no problem. The best answer should win.


>
> ...
> > > > The bike shed should be blue! Wait no no, it should be red... Hang on
> > > > yellow yes! Yellow's great!
> > >
> > > Putting a header in the right location, so as to avoid breakage here or
> > > there, is not bikeshedding. Sorry.
> >
> > There are 312 uses of "static inline" already in UAPI headers, not all
> > quite as obscure as claimed.
> >
>
> OK, good. Let's lead with that. It seems very clear, then, that a new one
> won't cause a problem.

Right, sorry I thought I had made this point earlier, perhaps in a sub-thread of
a thread of thread. It felt as if you guys were acting as if that were
immaterial, which is why I highlighted it again.

>
> > Specifically requiring me and only me to support ansi C89 for a theorised
> > scenario is in my opinion bikeshedding, but I don't want to get into an
> > argument about something so petty :)
>
> An argument about the definition of bikeshedding sounds delightfully
> recursive, but yes, let's not. :)

:)

>
> ...
> > > > ANyway if you guys feel strong enough about this, I'll respin again and
> > > > just open-code this trivial check where it's used.
> > >
> > > No strong feelings, just hoping to help make a choice that gets you
> > > closer to getting your patches committed.
> >
> > I mean, you are saying I am breaking things and implying the series is
> > blocked on this, that sounds like a strong opinion, but again I'm not going
> > to argue.
>
> Actually, Pedro's request kicked this off, and I was hoping to dismiss
> it--again, in order to help move things along. My opinion is that we
> should shun ancient toolchains and ancient systems whenever possible.
>
> Somehow that got turned into "I'm trying to block the patchset". Really,
> whatever works, follows The Rules (whatever we eventually understand
> them to be), and doesn't cause someone *else* to come out of the
> woodwork and claim a problem, is fine with me.

Text is a poor medium, sorry!

I don't mean to say you're doing that purposefully on any level, I mean to
say that, by arguing here over something that feels kind of unimportant, we
are inadvertently doing that.

>
> >
> > As with the requirement that I, only for my part of the change, must fix up
> > test header import, while I disagree I should be doing the fix, I did it
> > anyway as I am accommodating and reasonable.
>
> I agree that pre-existing problems in selftests should not be your
> problem.
>
> By the way, I'm occasionally involved in helping fix up various
> selftest-related problems, especially when they impact mm. Send me a
> note if you have anything in mind that ought to be fixed up, I might be
> able to help head off future grief in that area.

Sure, and I'm passionate about tests (I've written _thousands_ of lines of
tests recently!) I mention this as a related example of something that
feels out of scope.

Equally as the pidfd.h test header already had other instances of exactly
what I did and thus really should have been solved as a separate series
(one that I'd have been happy to do myself), I feel this issue, if truly a
problem should be considered separately.

>
> >
> > So fine - I'll respin and just open-code this as it's trivial and there's
> > no (other) sensible place to put it anyway.
> >
> > A P.S. though - a very NOT theoretical issue with userspace is the import
> > of linux/fcntl.h in pidfd.h which seems to me to have been imported solely
> > for the kernel's sake.
> >
> > A gentle suggestion (it seems I can't win - gentle suggestions are ignored,
> > tongue-in-cheek parody is taken to be mean... but anyway) is to do
>
> Actually, these come across as sarcasm, especially in the context of
> these emails that show you are becoming quite distraught.

Yes, I get that, rather a Brit element to this, to be clear - I am not
distraught, merely mildly perturbed. Again text is a bloody awful medium!

This genuinely was meant to be tongue in cheek, BUT I realise it's a me
issue on this kind of thing - obviously written down like that it comes off
as possibly dripping with a kind of venom that was ABSOLUTELY not intended.

Whereas my intent was a sort of wry smile, 'come on guys this doesn't
matter' thing.

But since this is the second time now that I've said something intended
that way and having been received as quite something different - this is a
me thing - and I will refrain from dalliances into the rhetorical like this
in future!

Apologies if either you or Pedro took offence and I'm fine! Other than this
damn cold that wont' go away...


>
> I've met you several times at the conferences. We get along well. And
> your work is top notch. So please consider that I'm very much supportive
> of you and your work here.

And I consider you one of the loveliest people in the kernel and very very
sharp, and have enjoyed meeting you and your erstwhile colleague Jason :)

To be clear - I also have high regard for Pedro who I consider very smart,
and I don't say that lightly.

I mean this _whole series_ is his idea, for instance. I don't just write
series based on an idea on review for just anyone ;)

So this is not at all intended to be a critique of either of you, as I have
the utmost regard for you both...!

>
> I'm still trying to understand why you are recently sending these very
> strong emails (Vlastimil also took some heat), but I see that you also
> mentioned some long hours.

Well some of higher 'strength' have more basis than others that may be my
failing to communicate things quite as intended. We'd have to speak on a
case-by-case basis :)

But in Vlastimil's case, that was absolutely not intended. Again text is a
bad medium!

>
> If my feedback is making things worse here, I'll try to adjust.
> Selftests in general are a frustrating area.

No it's fine, I think just a comms thing here.

Please do carry on reviewing it is all much appreciated... I promise!

>
>
> thanks,
> --
> John Hubbard
>
>
> > something like:
> >
> > #ifdef __KERNEL__
> > #include <linux/fcntl.h>
> > #else
> > #include <fcntl.h>
> > #endif
> >
> > At the top of the pidfd.h header. This must surely sting a _lot_ of people
> > in userland otherwise.
> >
> > But this is out of scope for this change.
>

Anyway on this issue, as I said, and meant - I will respin with this taken
out to alleviate concerns.

The _far_ more pressing issue I think is the one Pedro raised about the
actual PIDFD_SELF* values. I may simply choose some arbitrary ones in the
range specified by Pedro on respin.


Thanks! And I guess I owe you both beers ;)

