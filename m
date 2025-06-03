Return-Path: <linux-fsdevel+bounces-50436-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9287BACC2EF
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 11:24:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FBA43A2C5C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Jun 2025 09:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0030128151A;
	Tue,  3 Jun 2025 09:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="el3LRZkO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kmf7FpKT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6EAF2253B0;
	Tue,  3 Jun 2025 09:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748942670; cv=fail; b=lnDWN4nB58plnZyyMGDNddSWjwUFuyVBNOVoOAMF9e/BgTEvXbyN5MORrAIBj6AHurzldi0I5RlYZVcNPkLAgLIQNJQAi4XeBXVXnZ0qFTjiYKW2zG6Cl8oAX127rHAqqQGgiStoxVel8/l31urqKgDjQsj6EtRbAlxDb4tjgEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748942670; c=relaxed/simple;
	bh=CCz3nNwmUl77gEBqULxnVeaW4bG9rQkGxjx/e1EBe6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MbkPAbV6EHszsD23SA9/S70V1DcBVakm2TefA+6d573Z77r+Vl5QQz1Rk7fxasCxXnkPh7tIjiinnWXxG0L5f+4ClAxlCLWE/+LtSUF75Ng1coWHQyHvZuXAHilgMUwG79zOX/TihpaAohH+XKLIWm3LdlPoVgZhLgDQ5sqU1wg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=el3LRZkO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kmf7FpKT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5537uJgp026072;
	Tue, 3 Jun 2025 09:23:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=CCz3nNwmUl77gEBqUL
	xnVeaW4bG9rQkGxjx/e1EBe6I=; b=el3LRZkOmS2dhDfwRSL3rg8Qn/Wtvrmbjd
	/whtaTuHPN3PamGrm0dxOdFEa6Yv0EGP3eCF9TgAXEcRSbwHxoG+0Ivwe3LBTkku
	zCYrn2YI0pfyA5OJFxdX5lZpY6A9vhTTts3AvzBfVnT3H3MKFsXWg3UjgkbH2ej4
	xVKh/9wjdQ1ZP9TIqAeBmFISeI9689dJER4iT54ZnjzpfPaL15e1AoUzQemhYWdL
	zsZ2GtICfYUPsjojaWF+R6bNldC3+SueWLa1nKTRVeTZquKi6g6yFdyNo/laYnPV
	0KJwfWN9Kki8ufjjhH38fUq6bRE9Rl4wQiHDVoyUfd7A8n0BNN9Q==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 471g8bhf1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:23:05 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5537wdwd034516;
	Tue, 3 Jun 2025 09:23:04 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11011029.outbound.protection.outlook.com [40.93.194.29])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46yr791y0u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 03 Jun 2025 09:23:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gm+aPE6oVB+PbBmk5UNGIjVAh8EYssONdRKswplDxstkNNAOaYU6sGMIK2gQE8g+gc4PUKFeC6o6ALx94U/Vhr83fpnn0IbU1C4NkZt6gq4nUWJloK6Q4vavF7pgrMqg6Z+qK2c8yDAIh7yE0R5QOCWyADiMhpVQqNYmU13Zsn0TVtBNrD9c2jMcNZ88mSNDFL68EeRM1SlmJdVONTXBFNCaMbdIHMFpRPo1SmWddC52EQQBZwSh7vU5vsBK3g2I17Yq47K1ZXL4INBm2QNJCl/ilUbcRjSIHEp5COyzTpcTVI39V8UlccDK9rEO5KjD4yW4XhvKdOykrBPqvkrdEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CCz3nNwmUl77gEBqULxnVeaW4bG9rQkGxjx/e1EBe6I=;
 b=q6+QvAKTwX1qIwZz2610y5nxmIDPyg6ON6eAxc22XXawqfOTS7ALM5BrIkQlv9Rgb1Rc6y/GMdwmuB4itU3oU7rhtDNb0BC164YzsQYSYfsRUyfqmeAvezQfEHyKUrBPWA2lQt9XAIpkZE+tq3cSIK/M0Q9yGQt5rmgX3px6ltbEvO8Qx8nlv8QGCgPk2kfqdC1ee5/5RiPSot0eHmwTmRfqcGaj3hLclkwkDRI/dLBfe+7ZhBjHf/EN+6F7iD3OcnjaDQQTv5a+IStaAS98aVwgUNQuRkZyz8y1D0PhITM0+oR8tj54ExtM8DvJdpJLMLc8Mcfg8KT9GMlDlp+/1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CCz3nNwmUl77gEBqULxnVeaW4bG9rQkGxjx/e1EBe6I=;
 b=kmf7FpKTjG+7D7gW3Wc+9nIpioCNcomxebr2JFdrDCko6VTBgTA0GzRR3RWCUsEdvAuqKIAOiaOsquw5d/sEsKMh4tU6H58/sxvB4ubnrMYN9/lsKRIOwGTzwA9FGDfc0NBH+H6Ou+eHSxuRWWkdBWwk6UdmdgMVgfedUhp6R90=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5053.namprd10.prod.outlook.com (2603:10b6:5:3a4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.41; Tue, 3 Jun
 2025 09:23:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8746.041; Tue, 3 Jun 2025
 09:23:00 +0000
Date: Tue, 3 Jun 2025 10:22:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bo Li <libo.gcs85@bytedance.com>
Cc: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, luto@kernel.org,
        kees@kernel.org, akpm@linux-foundation.org, david@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        peterz@infradead.org, dietmar.eggemann@arm.com, hpa@zytor.com,
        acme@kernel.org, namhyung@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, kan.liang@linux.intel.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        Liam.Howlett@oracle.com, vbabka@suse.cz, rppt@kernel.org,
        surenb@google.com, mhocko@suse.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, vschneid@redhat.com,
        jannh@google.com, pfalcato@suse.de, riel@surriel.com,
        harry.yoo@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        yinhongbo@bytedance.com, dengliang.1214@bytedance.com,
        xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
        songmuchun@bytedance.com, yuanzhu@bytedance.com,
        chengguozhu@bytedance.com, sunjiadong.lff@bytedance.com
Subject: Re: [RFC v2 00/35] optimize cost of inter-process communication
Message-ID: <622a2063-a603-4f8b-9881-a6ed934e37c7@lucifer.local>
References: <cover.1748594840.git.libo.gcs85@bytedance.com>
 <8c98c8e0-95e1-4292-8116-79d803962d5f@lucifer.local>
 <CAGX5aN1aogK80L-TVj7+ru66sn-1FN+H5+Z6LJZi0hoj=_gY4A@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAGX5aN1aogK80L-TVj7+ru66sn-1FN+H5+Z6LJZi0hoj=_gY4A@mail.gmail.com>
X-ClientProxiedBy: LO2P265CA0362.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5053:EE_
X-MS-Office365-Filtering-Correlation-Id: 814d84fd-fa8f-482e-f9b2-08dda2803b60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?uugUn3ENXRz44rACu7XOjIpAsHlV56egGO18Dcr7JeMZ2iZQ148cQ3VnaMlD?=
 =?us-ascii?Q?gFJsDoipwV7Uwe9X+ZfwxEqVfD8fh23JFwnW7To/sDAl1f1r1FUwG243eTDD?=
 =?us-ascii?Q?V6m6wcI6HFhWy8yCF5IWrAYbPB+FzN34gNMSU4nSgea9VS+OsOtt7B7AgEcj?=
 =?us-ascii?Q?BITEBJaONqsz82MjIyM3o5XeCxCwm9r9g33EL+by/JVNYpEqldapV1648dKo?=
 =?us-ascii?Q?bVSdg64ZZGhLN59DJCJiKsvLCNjZdyEq7yLMf2pwcR3XTqg30jLXZ2qeehJw?=
 =?us-ascii?Q?zohxPtm9qY+PXMoMKUS1CzwvcsGDMkr35vDuDl0lLT22qRsuGBOiHSGQ1Ikv?=
 =?us-ascii?Q?eNqoE1tJ3fiU0FjTs8Ao0rhY/gQRdNOt6weDgLDcqXZRNDlYPxCuN7TUkiSA?=
 =?us-ascii?Q?c2w4z6Lo45cDDtehHQ6nMSJfJhAO+Lw/niyerENRmvFtAsXP8mr5zpV4bX6j?=
 =?us-ascii?Q?mpXsnKyYSx7ONNN4CdjGltClp/chO7kbLxn9N5z7yPUywxHu+gEIZ1zdx+Ma?=
 =?us-ascii?Q?kCGmqNGcNQfR1KTmD5uzNb0xgT+ZQAzBCuwgzciyuLrld1dKlk5jGLv0EGXY?=
 =?us-ascii?Q?xMzJOF6ojk97HsMWPJCunv6N8lau0y6PqqMlEGq39Nkh567LkQY7jLE//cOb?=
 =?us-ascii?Q?t/PZSLm8NeCBxCnOYjyw9e3kRhJIUz1UMw/GalkC2rYsyNUhfHkFUHi4gDvF?=
 =?us-ascii?Q?GPh/81IQ9zo1g5h/VmpDfImuxFs411GLraznveFW2dXVDvU48lpqiy/Slzbr?=
 =?us-ascii?Q?0qV+Y98fpmD5Vnt0ZEAuf/QpoktYZI9xTCw2V3fR8U7f2+34z3YWQS2rmBxy?=
 =?us-ascii?Q?xW/NUoZVrYyZKQNVXuS6O0G81ZMI0V4jPcqWNJWLwUtH4xjEZi1TaPOuzle+?=
 =?us-ascii?Q?fwLmYbxh3sFj1y7g06iVwbHqes4fC7zf8aUUWw8ZK78lhz0QRAfjw8wC9VYh?=
 =?us-ascii?Q?/Rre5eleSDdKdB71ES+/VszM1LZBewbgPYoi4N1pQhmN2YsLW809w5Y1zpwI?=
 =?us-ascii?Q?M7Qt+s6uMvQf6du3Vr2CrWA0xEcurAn0CFhWvcvPyZOtonDUJdwyOAQg9Ngn?=
 =?us-ascii?Q?leSjQhuq6Spp1tFd4Np3lqCFmhr/OKgYK8kmtU/hDAFf8zfgcIt9FQXsFbJC?=
 =?us-ascii?Q?dcvZ5cEEwspbnlr/g++PSwNzkRWPSNdjaw2vqwiVpTk+ck6j+WdkkrzINR04?=
 =?us-ascii?Q?xSopZc02uC32ZNI6dvgf+tEx5SPfE4MptC2H6QzoL9QVLRAsaV8ZsEsG+WLB?=
 =?us-ascii?Q?CX/SP8+oP0F1FskwsPlv9C1fO8UCQqQ/HxpjRhAFalM0dkbD17+WG8EI1d2Y?=
 =?us-ascii?Q?vzY2K8MhI1XjBDoVKXtSP0qJwOVOF9KzNTXCJUNQ8g6vH0lvYLo+y0rdT+2G?=
 =?us-ascii?Q?v5WmPtGH+ZldHo3UTOtwqFlrz2Xp8I/NDDDOh9hmUn2i12HkwuisMrDWb+Wv?=
 =?us-ascii?Q?SzN6+DS9OzA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hVwfmoIpS2JCRWN/o6u9xutQl2L0XKxfYoFSZ05iBcihSTbquwG4heQsOUre?=
 =?us-ascii?Q?jcwBwNepFgqouGybtwe7nkrZtu53w4F2mVOqOqzU4oB1r32aKTeIVBZg11SE?=
 =?us-ascii?Q?gYCekoM8aftGRSihhz5LkksqNRTnYoy33i9q2Ems/yTuHRPkds84j7o5fjlK?=
 =?us-ascii?Q?SSGfdn1PsGCdywvH9aX0jAFRyTcr0v0jAIE0mBHjmbMEuO9V1P/RlEE46lzG?=
 =?us-ascii?Q?g4xN6Q4VWYYvcg0wXKmSCbhQsHA6yfVwAfecUSuc5VXExZaC2yIFk9NKTmeo?=
 =?us-ascii?Q?HEDjnbbPdxStC7t6qXfxk+Y/gxVK3zyxnC9VDo9cewX1PCzJR8kRaRM58aar?=
 =?us-ascii?Q?JTntMo7IhwaYjIgc5x74j2Qt0fMdO8/8AGyepAPrLT21az2bnFeFI32fD3mK?=
 =?us-ascii?Q?8+4/sDAelJM3eJ/KCm0F/QdWts2rRK9lDIPjTijv9osLlz0IQe5I3cu7gDRb?=
 =?us-ascii?Q?Cm5Z4UMEVOSdE91fRHC6GTRHCQ7/4pTC2i5yve/g1YrtQLlBOwlc/+U6N4FE?=
 =?us-ascii?Q?VxGwUnPvPWqsr2psp6G1WdBHn+N/eSkpX1IBqZAmc6Xz+A1RBmb7t0/hy2Oa?=
 =?us-ascii?Q?kx3mxGUn/fwkd6SxmlCoSgy+OEhplr0z5cKXcpluePjDYytDMxI5FEofLDPR?=
 =?us-ascii?Q?1Mfo6HEpPMocki3tT6HN+zT6QzqptxBD0VmRtbYqCw6NgkknnRysS84+Gs4T?=
 =?us-ascii?Q?lUTAhRXm3FeR8BYoEoTX/0DoyEE7EeDiX/CGMxqXllT3+/x5/5KJB87rFQZE?=
 =?us-ascii?Q?UYrVCdWZTNKvphMKHXhAGQvkSNF+VAF6J57GKdN+OOcdL/KLx1t2BaiJN0AQ?=
 =?us-ascii?Q?owU5n2oeaem0cbtF+4n5K+cog382pmak5Fw5nEgPpQh6i2Nj80v2bUqFyjOJ?=
 =?us-ascii?Q?LMZhLBxxBtjpsPyvPddP0l9GSaq3kgBs0/hFGv2WbPrJl/PetRKV0GrkUYjd?=
 =?us-ascii?Q?7QQ80XJgt65YitBXWuDQfH/fNywNAwSwzGnceg4UD5uDYpO3jIConR+Pi0Ni?=
 =?us-ascii?Q?p5SnRoz4mLJ2IIbEdSlXpXTAtr1xXYrMkJVWyKSP+rkcycvuUfnLRWNF83YO?=
 =?us-ascii?Q?ztDEnBBnpmHVNv8tVTrRHyozVXGRsectz/mrfENVHMGPB/utsbGn4fUrs7k7?=
 =?us-ascii?Q?jBFbGlqkXQSb6BekBk/mDHvF9dsPw4w+0J1kc0afCAEsPySYdmxMm6TFvOgB?=
 =?us-ascii?Q?2cGaymV0YllR39xjdtNfOR8ZLxEBQW6h/CwJ0nkk66eq0NeKpW9f6+EbBKO7?=
 =?us-ascii?Q?4l4F1i3Z1dE35ikRNfQUzVcHo/mSw/OeazHHKwWX62EFKgNxO6HMmuaDUhBj?=
 =?us-ascii?Q?7aThbSjYxLbP5Hp7wtWHPqqX0fkulqeHevDf6UXO/j/F0d+vwWg6EqcSfmsY?=
 =?us-ascii?Q?4jCS2TgFEsv4VeF/zUe5CXrQ/oD7sBhRwIyixf/UM8/RtIrCfrHMTH6PLLKr?=
 =?us-ascii?Q?XmLBVUTCuVD0KH5RTOF/r7l6S+Y4kLeciUi4oYBV8qkuMroEoOC/cDonxyx3?=
 =?us-ascii?Q?k1w3y0eacgUfj6I4N+WeUO7p3BgeCE752SK2oHzWZp9mUVW+Lhup1yYMH5Pk?=
 =?us-ascii?Q?r54AH5c9AOh7+GBGU2yOgrlOAI/QOM7gWXF00zWGKRvM4hHvYG4e+YGAFq/Z?=
 =?us-ascii?Q?/A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HfCOpWh1RimGBAzWG6OQk4ft4vYy0mxjuNIOHzwKe4GDxEeeAdrWXKkMd+IunAvXt8jYPbDtLYpeI9encIsIn0OlYddopGI4asCcftObj19de7YIMVBMVyPvAoIcPalnRCJW6wf0BPranr+0xlVFNvh2fNFc3bxuSm6DSg41WaKyE9Q27/FPmb9TKyBwCwexCMHhpcTny8/ptp2ZpJ2YE8NCSxCJeJyTvcb8oRqB2NSpcsFEFLo9JnLBOx0Yk7D3LLPr/KYFj61YAQnGwL7wjYdqsCEuamFIeKMcsWAxY5IagNVAv5t0xrawksuBMzWuLJW2fzzoyLVI5oCCxJATMo5cGfA9HZmAtj3ikJ+S97c1nsY4cFoNxOH50VcNW7IeYsTtkSwTUqFUUV/hDPAanO7YVdN2ODJc2K6JCcub5i3XFz3IJfGa2cPsMEVtzwLpaWa77986yboUzEHIawlBoCBtw4AbmmC63j+QRVqjN+/qUXvYBS1ld45hnwNK1YbNLKlzomQNpUKn/muvI0/dafkg2sgoUJKQV5AP1Jjp4W8scLQd3oUjxBius7kyx7A8LMKfCIgLSeX1n6a8FoXkzyNyn0N8iPsbYJ5pQJHmcLU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 814d84fd-fa8f-482e-f9b2-08dda2803b60
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 09:23:00.2366
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h1tgCGA0CMHnYXoN1WKsf+Za+IJTaxmx8YL+ai2FqX7kKef0XfZ1q3X0mWpKsHeIMd756D9ddV7TyOt/u86BGiWaHEMTAHmf8q1e+4rG7tM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5053
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=922 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506030081
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDA4MSBTYWx0ZWRfXyD45a3393wjX 7tYvYvrr3XrO9IA+xTXfRYjdjzZJrUqQ8AKCXJv/wTngPUdt+NglQaFT/xEgPO3FT31MPNfCPdS DJTCs4ku+vLOsl1SQQq9KyuiGwQnogjLP/QdbPP2fAp8Gimu3O3QLIM3e2fupm4YgoGCrAsdEXV
 ALqipx56vYasfCWWHAkAb7LRQcJW5YjdYSsqk/JHzZER+cggp5qpip1o41kG9+4jFN508lrUIxk PLeaebA9EySZ7KOpMRjUJNVCt0l0PmSUu70N/vkTg8hRtYS0/opQnRfG7Q8pB+JVzPKGvw1yyhV 51d2gxmc/W290jFzPZDT9YXdjfW2V8qmf2yjDi+P4ZlsEKrK8ItDlCygbBbzH5lnPUOcm24CDbN
 JyerSqt0m1iFdy89sdWPNeTjOpbrYGTPCr/fiD0wDekLKga85tsxMMw78ZixLZJmpCpZmh8G
X-Proofpoint-GUID: ZN17DYYkmRbpZjS5uvhpzjnsnxsECWxD
X-Proofpoint-ORIG-GUID: ZN17DYYkmRbpZjS5uvhpzjnsnxsECWxD
X-Authority-Analysis: v=2.4 cv=H+Dbw/Yi c=1 sm=1 tr=0 ts=683ebef9 b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=weI5y1wsdOZr2Ek6-P8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13207

On Tue, Jun 03, 2025 at 03:22:39AM -0500, Bo Li wrote:
> Hi Lorenzo,
>
> On 5/30/25 5:33 PM, Lorenzo Stoakes wrote:
> > Bo,
> >
> > You have outstanding feedback on your v1 from me and Dave Hansen. I'm not
> > quite sure why you're sending a v2 without responding to that.
> >
> > This isn't how the upstream kernel works...
> >
> > Thanks, Lorenzo
> >
> > On Fri, May 30, 2025 at 05:27:28PM +0800, Bo Li wrote:

[snip]

> Thank you for your feedback! There might be some misunderstanding.
> According to the feedback in RPAL V1, we rebased the RPAL to the latest
> stable kernel and added an introduction section to explain our
> considerations regarding the process isolation of the RPAL architecture.
>
> Thanks!

Hi Bo,

You need to engage in _conversation_ with maintainers, not simply resend
giant RFC's with changes made based on your interpretation of the feedback.

You've not addressed my comments, you've interpreted them to be 'ok do X,
Y, Z', then done them without a word. This is, again, not how upstream
works. You've seemingly ignored Dave altogether.

Others have highlighted it, but let me repeat what they have (in effect)
said - this is just not mergeable upstream in any way shape or form,
sorry.

It's a NAK and there's just no way it's not a NAK, you're doing too many
crazy things here that are just not acceptable, not to mention the issues
people have raised.

You should have engaged with upstream WAY earlier.

It's a pity you've put so much work into this without having done so, but
I'm afraid you're going to have to maintain this out-of-tree indefinitely.

I hope you can at least can take some lessons from this on how best in
future to engage with upstream (early and often! :)

Thanks, Lorenzo

