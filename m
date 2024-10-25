Return-Path: <linux-fsdevel+bounces-32886-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC7299B036A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 15:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E6441F23419
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Oct 2024 13:09:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 707851632F9;
	Fri, 25 Oct 2024 13:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FgDQR/nq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="HAL9r1AX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23DCD1632CC;
	Fri, 25 Oct 2024 13:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729861741; cv=fail; b=fPwv3nwaZBr4FACIETsTHiJdpFri+JfqzJCo2+9eNGDmdW1uoEyEE9G58xD62ErTqRRMe/qNmnld3wBcaSILuGs8BBQkBmAfLonJn5VACGQuYM6fqvJ1IiGPsrRJkI9qYDTXkzvGyN1SPfv3ZGukrY2F5k94WGCeCwIWpKoIySc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729861741; c=relaxed/simple;
	bh=Bsf3nVVkkGwbdyKnJk6Luk/36QYv5dHZ/Paa53BRzgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=QZuKKzgMNnjNkHN2MFoIAf++J9OrZsmZl31sEkwvb0cLghrg6Ab6nCvO8LVG9KIOCRzRx5s1Gdx56lhIo3NVmOWqnBD2vM3TYtfskWShbHOraT/5nrxgR2nayJV8y+mBY5RpBmymw+60bYNMrWUcmbBd8iBhpjJ+QqbbwHYd0rw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FgDQR/nq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=HAL9r1AX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49PCTgAn011181;
	Fri, 25 Oct 2024 13:08:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/eb3w19mVSbyptUA7mXlXyGxzvKStg5sigePqVqe+lw=; b=
	FgDQR/nqfVtZoYw1/DL2zOHuTDoebrYugj2emQTZfiYpEWoMpdsWTanMAsGVV59U
	4vr5sJJqFLT9um1mPrsEh3XbEUuhMN55YjH3/0NgWuNoGTnlOIpvFjB7Y2zHrOYq
	LtGe+27c/E5GgKZdiwClwKfpgceTDha5LkAhbxS8Tqm2DLJnqKughSCpgy48J6Hp
	vKijCha7GsV+wpCRsnrFU5oo95wDNtNgOVu/gzeQtw1o4kZLuxZ+Jmb5dATRZ74d
	dgCVZdjqQZs+gpqMd4pJ1CWJKOmKIqbd8SLyr9+fINhNLnM6EapUEWf3+9E7H4GG
	EzycLFRUHY8FQ+c1HjeXzA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42c55v4wxb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:08:42 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 49PC29sE008663;
	Fri, 25 Oct 2024 13:08:41 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2174.outbound.protection.outlook.com [104.47.73.174])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42g36afvmq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Oct 2024 13:08:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FOZdzMrhJBdYF630JXKNVlLzWObabf0uZqESvk3VqpbgzVFHcD//2AZcccTR8kSV7ovTOSpiGRZ4sZOdQK0hVJkB3X3OpeNihJg2NMp9fDgy63FcxzQSW6++Mok5wOT1nYPdqFOg7IQltyiB5RHBK16XGbyvBCf85bu5j42k/gisvsOMytRBHiHvXoeTd+qNsOlrSTVehRLU/XgZ9gauJObzMnh2O28hsP9oja2zg4it9NM16jU7Sjdr0sSWUdSgUs4k9gHOle81rkvny7SAn5IcLofE368k7OgeD87qMBXf3aGlXz+k+fkhLYf7n6zVYqzdWmaVMReOPy0gy1kzkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/eb3w19mVSbyptUA7mXlXyGxzvKStg5sigePqVqe+lw=;
 b=SaTWCfWOEplqvQxU3jZZB16v2YIx0s/8XMUq2R7SphZaEx9XquYnX1Zvfd01z2+hAbSpX+vxHr0fN7Q7gyOXe+3qQvg78Bpowatzmm+jnNB6sD2VuoIoIHttIs6zBz5hBD2FR7GIQd941xHU5nT5ixrBXagjYtQyS774juY1wNCYLgsNUqaO77FzZtmYDwzrxKwJHfZZmHxIz1E08OeOcNMHk2QRHxmc7mDjFynPPYzEbUCtivht01rMwtjpdgjXJ4QSNBE4t1zjCJci52TAciZaPnHH1TZivwFLYumMs7Dscz8pQhuYKv60SgpgxMGdBolnenZsMyiHrbfFaLr9Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/eb3w19mVSbyptUA7mXlXyGxzvKStg5sigePqVqe+lw=;
 b=HAL9r1AXB1xStUl6zw/4SFELZyN/z1jFt/J/QPgo37UUHTlpmDu37OMVQ5m9DZ5+gaJ+ez9aRvixJTw3Wj5kZVhqaXC6S6yl/RKRQqDlMYXYR3nxNLZr/s9yu5Tle4Jglk83i/tkCGrZCwoR9zfWhgEJUXlOx7V0eTmIKM3g49k=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by CH0PR10MB4956.namprd10.prod.outlook.com (2603:10b6:610:c9::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8093.21; Fri, 25 Oct
 2024 13:08:38 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8093.014; Fri, 25 Oct 2024
 13:08:38 +0000
Date: Fri, 25 Oct 2024 14:08:34 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pedro.falcato@gmail.com>
Cc: Christian Brauner <christian@brauner.io>, Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kselftest@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, linux-kernel@vger.kernel.org,
        Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>
Subject: Re: [PATCH v5 2/5] pidfd: add PIDFD_SELF_* sentinels to refer to own
 thread/process
Message-ID: <d3c21e16-61cd-4a93-8fef-6282d78e3672@lucifer.local>
References: <cover.1729848252.git.lorenzo.stoakes@oracle.com>
 <788fdfcc9ef602b408951d68097918d6ae379395.1729848252.git.lorenzo.stoakes@oracle.com>
 <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKbZUD2ZB+U3GKJftfRH_2ejNja26v38OLVE2Lbfn_1KSOKhNQ@mail.gmail.com>
X-ClientProxiedBy: LO4P123CA0131.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::10) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|CH0PR10MB4956:EE_
X-MS-Office365-Filtering-Correlation-Id: e8105c81-d58a-4095-cd48-08dcf4f623b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|10070799003|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K3BWcStwSG9Cam9xU0NiaG1hbU14WFFhM0MxZU4yUmE3ekVZVEtRVFJKQS8x?=
 =?utf-8?B?b1hzOExwWXQrNUtOR2FKR0t2bFl4SlB4TGhwV3k0QkppZDBiTWthc25WeU8r?=
 =?utf-8?B?T1phNUROVVlBZnlDVUJhMU9rZndRWkJwRStZSmxROStyaTF2OTNQcFVyd3Az?=
 =?utf-8?B?Nk5xa3BRRit5RlArVG9HVVZNSEEza21MbVhVaUFnT1U4OUk2K2QwWjcwWW1l?=
 =?utf-8?B?M3VHREFzYnNzRTJ5ZlZhSDUwUXRmMmlFK0FZR1BtYU5vT0FoMmp3WWkyWW9L?=
 =?utf-8?B?L1NiQ3l4Z1FXaFNGc1BGNW05REJiUGFQOFBtejlWWkJxSXNTb3dMRFVwODY5?=
 =?utf-8?B?eitySXZDVVQyYkVrWmFMYnFDMktwSW54T2Vub3ZLZXNuQnlGMFliZlJ2bmJY?=
 =?utf-8?B?Z3I3SlNONC95MXJFMDFRZm4vVHQvSnNwc29UR2JKcUNzeFhla1NFUVBBRWRK?=
 =?utf-8?B?bDZJZHV1L3FsRTh3NnZ3d05GYk94NU5qb0syZmV0S3VYV1podkxtYnMzS0Fk?=
 =?utf-8?B?MzBOUEo5bTFGd3V1TFRMdUE2eW1pZ1F2NDY5N2ZXK1c4dDg1MkdpeTR0ZjU1?=
 =?utf-8?B?OXJzZ0M1ZEJTOTlLd242MFFhUTBSZ1R0dXlpdHlMK2p2K0VEL3VBRVFiVC9q?=
 =?utf-8?B?MEJNTVA0K2k5MDllYWtsNXRvU3EyNkxBZmt2SWtWRE9pR29KTGtic1A0R0p2?=
 =?utf-8?B?RjdveVR0SnloZDBYc2hpZnNrVW5NdURZL1c3WElFTEVwUmEwQk02VEM0SGt1?=
 =?utf-8?B?TzJicG1EbjAzS1ROSStsVnEvNGs3aTVUTXNrRjB6S1BqcHRBS016WjRVaEJn?=
 =?utf-8?B?bVgrS2ROMjAvQnhsWDliVXFNdlljK2h1TUZEa2NacW41Rm9LaWN6dlYwNTRn?=
 =?utf-8?B?aVlRNVdkRDhnSURCTkJZSkk2QXpWdXl6V0NzS295dkM0TGYvb09DclNDYlV3?=
 =?utf-8?B?RFNqaEhkc0RSR1RLaU1LdHhWUEI5OFUzMUprWDYzU0tPVDN5Y2tpdmIrM3Ni?=
 =?utf-8?B?cjhlVG9lU2RYRml6SDR2WHdCR1Y3b3FZVmtLVHJHK0daWDNnOWE4dFJseW1s?=
 =?utf-8?B?RFdSVGRCRTh3MVJIRjBBWC9wc0dTZ2lURUJtTDQ0K0ZFbWxkaUdsUllmQktF?=
 =?utf-8?B?YU1nRVV6allyMEw4WWYvMWI4dzIzMjgvVEpYSGJFUEQxSWNpSnk1YTRjdG1U?=
 =?utf-8?B?ajJnTUVseFdaQWJleUIyQzhLdncvbExYUUJvT05wQ1UxKytkZ1cwNll6SnJr?=
 =?utf-8?B?MGttRG55VThLNmN6ZHdodytxbkl0M3JCS2lzM1J1bUVOZ1kwUHNoRDdhRDNu?=
 =?utf-8?B?OW9RVGpFQjlQc3EwNVVTUklwUEc1VUhJZkRFM2pOcjFPcjhNc0tmbGliMXk5?=
 =?utf-8?B?NnBLZFR2STUzRmpLQzJVSERFdjRtd1UxQlNtTFJiTnE1SElMOEs3a0Noa1VG?=
 =?utf-8?B?VUUxb2lEbGtLOU9INU8wRm9EZTRpSmJXL1poK1hiT09rc1pCSG05MEUrNGRa?=
 =?utf-8?B?T1ZDYVBzMmtYL0JWTWthcUJBbUxWWG0xR2pOQWtmYW51UmNUUysvNDQzNE1U?=
 =?utf-8?B?U2RDUFhTUlpxVmtnWFg3aVZQQ0t4Qm1aMXNIZ3ZnL25HT3ZEVmRrcFRza044?=
 =?utf-8?B?b2h1NmFUcndlbjJPQTcxRHVGbURCV2tzaHJEWTk1VTlvRmRyNGZtNmdlOEhU?=
 =?utf-8?B?NkpkcW9OMm4xQzJJM0RhaTFWODVzanZXOWtqbHM1WklUa094NWp3M2xBWmh6?=
 =?utf-8?Q?y8NxxMphn01zD+nwvnEIEUCCGiNntYmDjH+WTUc?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?K0JPS2R0TzhzV3hRandzL3BNY3EzbWsvSWliN2twQmpMZlRVT1dFOGxhQ3Fy?=
 =?utf-8?B?eWhUWTZJMlBkRmJBL3ZQamVtNGttY3M4NjU4NkZ4RlI1dEtuLzdWQys4bkRT?=
 =?utf-8?B?YjN4RlFqaHQwODkwRTBNWXJSU1dYMzJvWUgydkJSa3I4ZzBhUXk2SEd3aU42?=
 =?utf-8?B?TktiaEF3UFpOSUI5WXQ3N3BoV0dJOTBKMmluSVh0UWFJdmNHbzlQZm16aExG?=
 =?utf-8?B?WU1IWEZCS3lBNE1CSkNjMHJFTER3ajJNQ2Q4V0ZZV3UvTHZabldMUHhyMFd0?=
 =?utf-8?B?ekJDRGVSZ0F4TkFHbEdMUVMrWVY3b3puTW1JY1Fka1VVdWVTMW1WdWlQaStX?=
 =?utf-8?B?SlpkcGM2c0x1bHZKQ1BUbmN3TFViTS9Fby9PUDZKRndUenBlMXk1VGVpMVZN?=
 =?utf-8?B?Tnc0dXVIcGZES2NYUmVTQm1Fc3BRcWRYejZYUDBESTNrVnZERVdEbEowTm5Z?=
 =?utf-8?B?aERvS3luNjIwWCtrWWN3TGV3bmtVbFNndjdOMnl2N1RrYmwvN1NZU04vMHNs?=
 =?utf-8?B?K2pBaGNwekN6SkxmM0pGQU9uQVNsbWJUQWR2K04wNVlQZ3g1QTYzbktzaU53?=
 =?utf-8?B?elVWYWcybDdsbXFZSWFlRG9UVFpTenJkRDNUMUQvR1hsbmpYZEVSM2hsZCtO?=
 =?utf-8?B?eGNmcVFEd2xzNDRzVkFzbTRQMDF3Q3IySW5zOFpzYU5WUHgzRCtJcU5iYXd5?=
 =?utf-8?B?a1ZOZGszMmRuWTZOS0Y4bXlXeWl5bTNUNndYV0lLOE11WHVMRCtseEE5TkI2?=
 =?utf-8?B?SGNwbktYcnRNS3ZBaWhDY09iL1dMc3FIaGxmZEdCUnJPaE5VeGZsMmZiQ2Fl?=
 =?utf-8?B?NE1pNWdraFoyUEhkUjhyanVhS3U3NHJENFJvcnJ2YjlNMjZaRFNKV1RHNHlR?=
 =?utf-8?B?ZTYvWGtZTEVCbEVxLzk0OEpNQnlPWW1iVDFiOURveEVSUGk1YklVN21XOHQ4?=
 =?utf-8?B?Y3Y5RC9BT1hzS0R4eG5tWm81eTRJVHJVaVJXVjJTdGVPZEdEYlpmYzEyTlJy?=
 =?utf-8?B?Nk1CUkFZNDFZUnByLzdMeHh1M1Rja3JEUjJNUWwvYjQxZ1NsZkFGY3ZISFVE?=
 =?utf-8?B?S3BwVFF5Z2xXOGl3dDZmeVkzNEoyR210RjJoNjRqWTdaeENGamhLUEFxUU92?=
 =?utf-8?B?Y1ZXay96U25nR252V0Z6K1RRUHNDSENPaWI1QmlOYllJRmtiWmY0MlhaaUxX?=
 =?utf-8?B?bUlRTlUrZy9MNGpTaWVNWXdvY0JKYkxSWUp1eTRaNkVxQ2IweDdPRFhQQ1hn?=
 =?utf-8?B?UEFsTlZyenYwclllUlN3aTA4K24vdUJaSDcrSllxS1hTNng3c2wvcXB6Wmor?=
 =?utf-8?B?MHVDbkRiZnNkOFVFYUZ5RnlIbVlIZDIzWWllNVgxOXNoOG02TzNmMXhSRzBJ?=
 =?utf-8?B?Zml3WlE5MmtCcGF3cHExWWltVWxweUM3cGNhR1MvYVJVNDh6YmsvQWJweTl5?=
 =?utf-8?B?ZWxqQSsrbVJmVmlTeGtVa2trS2paSnBNdnVoRFBOSmJVbEF0MFZISDNoTmo4?=
 =?utf-8?B?dWVXQlgzL2NRcnlmQWwrR1V5cThjM0ZsYlBNNitjQkZxWWZnV0RTczhwSFl2?=
 =?utf-8?B?bmZaVTRkUk5MNHY5S1VzNHhPbG8wSlV4VDU4alJ2TEUyY1R4Zmo1cHY0c21Z?=
 =?utf-8?B?ejAybG1OcVliT2QvQ2RFMXNYS0o1cEdWckxGbG82cTdLamoySGdFOC9nMHVi?=
 =?utf-8?B?V0NBL05sazVrcGllb3RBZTZPQ0lCWkNhUW55VFJnL2FQRDRtUTU4YUxnRVFD?=
 =?utf-8?B?SlpBT2N2WTBWV3RyaEx3NzR0TzE1OUZFQmQwdlVRVW11Qm53a2RCN3hJbkNm?=
 =?utf-8?B?QVZSOGZpaFI0cHBvc2Y2aXE4U2RuN0NSYjJYd1FHOU54Nnd2WmdSMThwQXJS?=
 =?utf-8?B?OHY2UFY1WU9xVTlta0RqWFN4Njd5MlluTnhUSzBWT2kvdFo4YTc0VE45WHdH?=
 =?utf-8?B?MWlXdVhXbTNGbTVCWlFlYnlrblg1V1VqaFhGa201LzIvREVBZGlzMWkvSWNL?=
 =?utf-8?B?cWxsWTBkem1LTitucS9QQkprdDZ3dEdTdGd1OUo2eEVlK2lTVVdXMDQ3cTRv?=
 =?utf-8?B?WDhpemcyV1RNSFZ6WG5pb1NQclA4RElOWDFSc09aeWp0ajVmQzUwSHNucHFX?=
 =?utf-8?B?citnSmdrNkNBSThCUHJ1L3ZRZGZObnhpcHFXcUdOOWg0eSs1RVhxTTJBUXJL?=
 =?utf-8?B?YkppNjJiekphWCs1UzQ5NzFYR1d2aGhqNjZUQ0RrZllYZEFBNWFaRTl3bGNC?=
 =?utf-8?B?M2dJeTE4OXozckdwc1Q4ZzNDVHpBPT0=?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	j1+kRke4+jFSBbcUrKR9E77JY1aSAHHWihkpCjPb8ujrx+uEBGyrNhWvbOwZ1Rlku1X+QPI58Z2ecanY/4X3vSBq7jap8qeDpMXTsBxEIZVD4UKC87ZVOzHKocvp9PxuE6JFSeRMtmEk+J/DLg6cq2UHJc5HpLOVa8pkUIdhrdlJyBXJ1DFtLmguxFlyEkASBoU9VI25V+z10NM+XhM5nVDhChrg6hRI/jLTTQTzMYBbe7v7ZDhubFrqL4QMdcjktnomqIvIxBZSVGnEtIaMamOabC/oGKKeJeXa36TiF5IWNzeJHoGe1hEzETpohtNXk0NjuKyrUrT1lB0Z2e1ynO/QdS/31Q/upd3HrId3Dk/Z8xE3GZxL88nRXRIB2V57CjsG1q4suoZNiz5r1H8WaxpTuyspiS8FH87vuA0pRe+11l+NsC08KW7z8jZDnbDRqiPN3OX9X+b+AAZkk7mnAwOnwVqiqX2i40IRTtMlDQmE9vmVdFGo/oZvIrzBbkfCcAkxY37vxbtRJn8iv8y+b0F9a1ahbyvL2petRomZ+/f7bd921cijtsyKxeUZ0EghvTg/qZhGvnwrkxBTWn+cooIghBRD+0ZXeitNlCt2WpQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8105c81-d58a-4095-cd48-08dcf4f623b9
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2024 13:08:37.9424
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: c+sbhAIZZBtg0SkPAj/Z1EbWtOrZtotdEUqCdYa1oo2rLHQuHP0I/ilIWEwvDeP8glVVGn0xa9wH6obQleLMYGKmS1uJO3faDK+iNW61gMU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4956
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-25_12,2024-10-25_02,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 malwarescore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2410250102
X-Proofpoint-GUID: Z4QH2DD0pPQvvRio8jNJDxoFLW1TKybJ
X-Proofpoint-ORIG-GUID: Z4QH2DD0pPQvvRio8jNJDxoFLW1TKybJ

On Fri, Oct 25, 2024 at 01:50:12PM +0100, Pedro Falcato wrote:
> On Fri, Oct 25, 2024 at 10:41 AM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> >
> > It is useful to be able to utilise the pidfd mechanism to reference the
> > current thread or process (from a userland point of view - thread group
> > leader from the kernel's point of view).
> >
> > Therefore introduce PIDFD_SELF_THREAD to refer to the current thread, and
> > PIDFD_SELF_THREAD_GROUP to refer to the current thread group leader.
> >
> > For convenience and to avoid confusion from userland's perspective we alias
> > these:
> >
> > * PIDFD_SELF is an alias for PIDFD_SELF_THREAD - This is nearly always what
> >   the user will want to use, as they would find it surprising if for
> >   instance fd's were unshared()'d and they wanted to invoke pidfd_getfd()
> >   and that failed.
> >
> > * PIDFD_SELF_PROCESS is an alias for PIDFD_SELF_THREAD_GROUP - Most users
> >   have no concept of thread groups or what a thread group leader is, and
> >   from userland's perspective and nomenclature this is what userland
> >   considers to be a process.
> >
> > Due to the refactoring of the central __pidfd_get_pid() function we can
> > implement this functionality centrally, providing the use of this sentinel
> > in most functionality which utilises pidfd's.
> >
> > We need to explicitly adjust kernel_waitid_prepare() to permit this (though
> > it wouldn't really make sense to use this there, we provide the ability for
> > consistency).
> >
> > We explicitly disallow use of this in setns(), which would otherwise have
> > required explicit custom handling, as it doesn't make sense to set the
> > current calling thread to join the namespace of itself.
> >
> > As the callers of pidfd_get_pid() expect an increased reference count on
> > the pid we do so in the self case, reducing churn and avoiding any breakage
> > from existing logic which decrements this reference count.
> >
> > This change implicitly provides PIDFD_SELF_* support in the waitid(P_PIDFS,
> > ...), process_madvise(), process_mrelease(), pidfd_send_signal(), and
> > pidfd_getfd() system calls.
> >
> > Things such as polling a pidfs and general fd operations are not supported,
> > this strictly provides the sentinel for APIs which explicitly accept a
> > pidfd.
> >
> > Reviewed-by: Shakeel Butt <shakeel.butt@linux.dev>
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >  include/linux/pid.h        |  8 ++++--
> >  include/uapi/linux/pidfd.h | 15 +++++++++++
> >  kernel/exit.c              |  3 ++-
> >  kernel/nsproxy.c           |  1 +
> >  kernel/pid.c               | 51 ++++++++++++++++++++++++--------------
> >  5 files changed, 57 insertions(+), 21 deletions(-)
> >
> > diff --git a/include/linux/pid.h b/include/linux/pid.h
> > index d466890e1b35..3b2ac7567a88 100644
> > --- a/include/linux/pid.h
> > +++ b/include/linux/pid.h
> > @@ -78,11 +78,15 @@ struct file;
> >   * __pidfd_get_pid() - Retrieve a pid associated with the specified pidfd.
> >   *
> >   * @pidfd:      The pidfd whose pid we want, or the fd of a /proc/<pid> file if
> > - *              @alloc_proc is also set.
> > + *              @alloc_proc is also set, or PIDFD_SELF_* to refer to the current
> > + *              thread or thread group leader.
> >   * @allow_proc: If set, then an fd of a /proc/<pid> file can be passed instead
> >   *              of a pidfd, and this will be used to determine the pid.
> > +
> >   * @flags:      Output variable, if non-NULL, then the file->f_flags of the
> > - *              pidfd will be set here.
> > + *              pidfd will be set here or If PIDFD_SELF_THREAD is set, this is
> > + *              set to PIDFD_THREAD, otherwise if PIDFD_SELF_THREAD_GROUP then
> > + *              this is set to zero.
> >   *
> >   * Returns: If successful, the pid associated with the pidfd, otherwise an
> >   *          error.
> > diff --git a/include/uapi/linux/pidfd.h b/include/uapi/linux/pidfd.h
> > index 565fc0629fff..0ca2ebf906fd 100644
> > --- a/include/uapi/linux/pidfd.h
> > +++ b/include/uapi/linux/pidfd.h
> > @@ -29,4 +29,19 @@
> >  #define PIDFD_GET_USER_NAMESPACE              _IO(PIDFS_IOCTL_MAGIC, 9)
> >  #define PIDFD_GET_UTS_NAMESPACE               _IO(PIDFS_IOCTL_MAGIC, 10)
> >
> > +/*
> > + * Special sentinel values which can be used to refer to the current thread or
> > + * thread group leader (which from a userland perspective is the process).
> > + */
> > +#define PIDFD_SELF             PIDFD_SELF_THREAD
> > +#define PIDFD_SELF_PROCESS     PIDFD_SELF_THREAD_GROUP
> > +
> > +#define PIDFD_SELF_THREAD      -100 /* Current thread. */
>
> This conflicts with AT_FDCWD, might be worth changing?
>
> > +#define PIDFD_SELF_THREAD_GROUP        -200 /* Current thread group leader. */
>
> We might want to pick some range outside of the negative errno space
> (-4096 IIRC), since we have plenty of values to pick from (2^31 at
> least).

This is entirely up to Christian, I used the values he suggested in
review. But I agree we should probably find one that doesn't conflict and
is outside that range.

>
> > +static inline int pidfd_is_self_sentinel(pid_t pid)
> > +{
> > +       return pid == PIDFD_SELF_THREAD || pid == PIDFD_SELF_THREAD_GROUP;
> > +}
>
> Do we want this in the uapi header? Even if this is useful, it might
> come with several drawbacks such as breaking scripts that parse kernel
> headers (and a quick git grep suggests we do have static inlines in
> headers, but in rather obscure ones) and breaking C89:
>
> <source>:8:8: error: unknown type name 'inline'
>     8 | static inline int pidfd_is_self_sentinel(pid_t pid)
>
> :)

It doesn't really make sense to put it anywhere else I don't think.

I'm not sure 'support compilers that don't know what inline is' is a
requirement for UAPI. Nor do I suspect people using such strict ansi-c89
compilers will be importing linux/pidfd.h... :)

Also:

[~/kerndev/kernels/mm/include/uapi/linux]$ ag inline | wc -l
382

I mean yeah 'obscure' or not it seems this is an acceptable thing to do :)

>
> > +
> >  #endif /* _UAPI_LINUX_PIDFD_H */
> > diff --git a/kernel/exit.c b/kernel/exit.c
> > index 619f0014c33b..3eb20f8252ee 100644
> > --- a/kernel/exit.c
> > +++ b/kernel/exit.c
> > @@ -71,6 +71,7 @@
> >  #include <linux/user_events.h>
> >  #include <linux/uaccess.h>
> >
> > +#include <uapi/linux/pidfd.h>
> >  #include <uapi/linux/wait.h>
> >
> >  #include <asm/unistd.h>
> > @@ -1739,7 +1740,7 @@ int kernel_waitid_prepare(struct wait_opts *wo, int which, pid_t upid,
> >                 break;
> >         case P_PIDFD:
> >                 type = PIDTYPE_PID;
> > -               if (upid < 0)
> > +               if (upid < 0 && !pidfd_is_self_sentinel(upid))
> >                         return -EINVAL;
> >
> >                 pid = pidfd_get_pid(upid, &f_flags);
> > diff --git a/kernel/nsproxy.c b/kernel/nsproxy.c
> > index dc952c3b05af..d239f7eeaa1f 100644
> > --- a/kernel/nsproxy.c
> > +++ b/kernel/nsproxy.c
> > @@ -550,6 +550,7 @@ SYSCALL_DEFINE2(setns, int, fd, int, flags)
> >         struct nsset nsset = {};
> >         int err = 0;
> >
> > +       /* If fd is PIDFD_SELF_*, implicitly fail here, as invalid. */
> >         if (!fd_file(f))
> >                 return -EBADF;
> >
> > diff --git a/kernel/pid.c b/kernel/pid.c
> > index 94c97559e5c5..8742157b36f8 100644
> > --- a/kernel/pid.c
> > +++ b/kernel/pid.c
> > @@ -535,33 +535,48 @@ struct pid *find_ge_pid(int nr, struct pid_namespace *ns)
> >  }
> >  EXPORT_SYMBOL_GPL(find_ge_pid);
> >
> > +static struct pid *pidfd_get_pid_self(unsigned int pidfd, unsigned int *flags)
> > +{
> > +       bool is_thread = pidfd == PIDFD_SELF_THREAD;
> > +       enum pid_type type = is_thread ? PIDTYPE_PID : PIDTYPE_TGID;
> > +       struct pid *pid = *task_pid_ptr(current, type);
> > +
> > +       /* The caller expects an elevated reference count. */
> > +       get_pid(pid);
>
> It would be really really nice to avoid the get here, but I imagine
> it'll take some refactoring around put_pid's?

I cover this in the commit message and have addressed it on review already,
but to risk repeating myself :)

Yes it'd be nice, but then you would have to make sure you _always_
unpinned correctly _everywhere_ from here on in, and it makes the behaviour
different for these self modes.

You'd need to change how everyone everywhere puts and... yeah. It's not a
big deal to do a useless ref inc here I don't think, eliminates a class of
bug, and importantly it keeps behaviour identical to if you do a self-pidfd
in the 'manual' way.

I equally dislike this aspect, but doing it this way also enables us to
implement this in this one place and get self pidfd support 'for free'
everywhere.

So I think RoI-wise this is a better proposition than the alternative.

>
> > +       return pid;
> > +}
> > +
> >  struct pid *__pidfd_get_pid(unsigned int pidfd, bool allow_proc,
> >                             unsigned int *flags)
> >  {
> > -       struct pid *pid;
> > -       struct fd f = fdget(pidfd);
> > -       struct file *file = fd_file(f);
> > +       if (pidfd_is_self_sentinel(pidfd)) {
> > +               return pidfd_get_pid_self(pidfd, flags);
> > +       } else {
>
> Skipping the else here might make the rest of the code more legible
> (since the sentinel branch returns anyway...).

This is so we can declare types for the other branch without having to
figure out how to assign the struct fd sensibly.

Normally I'm a big fan of the if (!...) { return ... } guard pattern, but
it's because of the 'types first' requirement of kernel code that I do this
here.

>
> --
> Pedro

