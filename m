Return-Path: <linux-fsdevel+bounces-55597-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C96C6B0C4F9
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 15:16:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89A5171C35
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Jul 2025 13:16:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEDB02D663B;
	Mon, 21 Jul 2025 13:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LRDaqCur";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xc/fbJgM"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8D32146A66;
	Mon, 21 Jul 2025 13:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753103796; cv=fail; b=W/fjY0ug+rIc3m8KCOGxoaLQHG1fWpx6fJ7VcXnDQGu+cg78DLodTeS7haY+/U8TH+EA2/8MnxyS05C10haWLZNoHf/uwZPsqTymT2ryS7y1HmUhlYWS1lfcsIzwrMYFiBn3b57tm7um3uqwcFIhgwxR9Gwubq5Wyh/bgDheTTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753103796; c=relaxed/simple;
	bh=PUaETVANWyPHHHLi2JuXHFy1rftiHs6xhBtRzJDs+Us=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=UWPA0n8fJvLSuxQhAXTqDMH/Yq7wwmL9yFuMJjcmWT7GyOWVpYzpjYDAk+q0BQEHb5gOkwhu4F/TohgoCCOic91ZirfjH3r2MW8N1jjbC47ddaI26Nsm8pkkbCfSyzXmlz7dPW1jLb/X+JXP8zCmkYhxIPnMjSWCo0OYJzirb8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LRDaqCur; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xc/fbJgM; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCNCaY028651;
	Mon, 21 Jul 2025 13:16:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vcSjdx+9L0nxNpOCGN
	Y184HxgVlzp0meBngnd/9yMF4=; b=LRDaqCurPKApvaqvAwac61FD911ZOxJJH/
	Ebd7wO4tCHK9aOOA+E4g+xdAqVd08ZXJwId1fg/mN+HOa+ESgaqDblrBsy9EZAhD
	jhDvqC1PmG7GCbh5tykmmYvqz6BqewZlsVzvnsoMEW36681nYbg40IHO0QQqs4r0
	Yhb380MRFwjIMaHQwsWpZU54fW5D6wgTz4PiVaJl3qwsk+G33qjRy2dvuvfTmksd
	c7qybDnt/lszGlkUKAT3r7UAa8Y+AOBhajShu9+eeIDpXx5hQxxEkS/h3yp5MoUQ
	bNmRn4PrOQGar88dZlwz18nUzLgALpZuCy1bYesKGaLbir/rFPlg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48057qtnak-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 13:16:00 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56LCUOah014657;
	Mon, 21 Jul 2025 13:16:00 GMT
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013053.outbound.protection.outlook.com [40.107.201.53])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4801tea9wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 21 Jul 2025 13:16:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r6ZJQS2AG+sY4s/3lgeRwJcok1WbiCwnguPISk4jbrDRIHsNjMxWuo8NUiZWKOY2jSwVAdM/2zZgSh2PFLkKIZuyW/AmmWx4kPvA7S6fhGfGQVp1/nmW2FkVslDVY9CI8FF9379cjcffA6kF4mXEhmSOX1aAuWGhDXfE7mDatCIanIvvLQy2YB51yCt2/PX+nLwbJ8Y13zzrv6TNiVFgg1DtKLVWCmQXX/iVBzzXsayWKNYbFA6wIycoTBeIXweRNFgnJLldF13WIvhfR2WQVhda81oc7LNjFXcEC3qJhcjOOVadAx0m7BOZBcbBgj2GW9wY/zvB6OnLf0WMfwhyBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vcSjdx+9L0nxNpOCGNY184HxgVlzp0meBngnd/9yMF4=;
 b=Q5zkT/zTmljldiricIrKSI9jSYKTSn4RUoq0qFLi15rp55RvoyckFmA6fy7gNxBItGjDvgdsmctoamGUeK1tYayl81YpxYZlP28vjGXK/ySgHF3zSNgHxYV6RVftcaC3p3ilA0QXHnX9dEZBmc9O3zN1XK7LIaP/anxNXwi9na/r+z2VPkwdwg4f2WKeRtZHedAb6t0FfILKkvwd7uxlhTHCe73TTz42EZd+9QQXJu/DOG4YieUEKhC74dZblkj7/+Tlrcf70v74PMeO7D5Ull5WBJUfyCc4qQh2+rpLMlFi8vo1ae6YWZvHMWR7C0lmXkxMriDZkDGrxO8p9yEUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vcSjdx+9L0nxNpOCGNY184HxgVlzp0meBngnd/9yMF4=;
 b=xc/fbJgMOhfXM6hbgfJpT+9kEB5yQTSqAvaOm/Svs2U8uEkzVkb6kcHMIN90aLAQWWJi7E8jyJNTLnvWqWwCVsNskm73pQA2Mv96ddGmx48wmTyV48NJVtecUBW6jNf9xt3M8BsYdGGgwmbCAoAuZqVPIXr9GfTDdgTHc922Nw8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7694.namprd10.prod.outlook.com (2603:10b6:510:2e5::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Mon, 21 Jul
 2025 13:15:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%4]) with mapi id 15.20.8943.029; Mon, 21 Jul 2025
 13:15:57 +0000
Date: Mon, 21 Jul 2025 14:15:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Usama Arif <usamaarif642@gmail.com>, SeongJae Park <sj@kernel.org>,
        Jann Horn <jannh@google.com>, Yafang Shao <laoar.shao@gmail.com>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH POC] prctl: extend PR_SET_THP_DISABLE to optionally
 exclude VM_HUGEPAGE
Message-ID: <803a927e-1c36-4934-9cda-a700acdaad0d@lucifer.local>
References: <20250721090942.274650-1-david@redhat.com>
 <686d2658-a06e-46cb-af22-440b75ac34ed@lucifer.local>
 <ff53959b-a402-4030-b11a-dc19fe36ee4e@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff53959b-a402-4030-b11a-dc19fe36ee4e@redhat.com>
X-ClientProxiedBy: LO4P123CA0667.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7694:EE_
X-MS-Office365-Filtering-Correlation-Id: cc868047-340d-4b08-6981-08ddc858babf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nQCK9kUg/Dh0mEaTm4e8EUko0dWc2j64jC0hiUcGVIuH1xc2wSGbLFIO5/xP?=
 =?us-ascii?Q?zkt2QweHXb73rjg6iEHxp5Lmv46vcrpJpjyzvhEWNehpviwVjQhZZK/1LHyi?=
 =?us-ascii?Q?DScWi36MEK8wTs7bs374oi0XcH/em2UcJbe/Amgk2gCzGRPOfIrKRM6f7H9P?=
 =?us-ascii?Q?ANfon658LS02UKkYAM7Q7EemTJeZBVSvbIWq6+6eHI3qS6+Z4P4zFC9dWQ22?=
 =?us-ascii?Q?oiKQaii51DIdW3GFBtWVaD2RE8Chuul4EAIpa0dr3STznTjNpG3nv29XKXdM?=
 =?us-ascii?Q?JpSUNu3YAAJhQQQORE+bM52HeLULp0fINldlf8PeJjwO36SLGePDAhGuCzQw?=
 =?us-ascii?Q?iC7QiVD9TrWsyw4+DisdoQJIzUXjJ4WjzKGZALbG/W04BE2tD0DB2IdcZtgO?=
 =?us-ascii?Q?7mSf0gc0WhCCzjgrsyuI4KQ4GotMxTLe5xqjDQnx3d1iyb2/kCc8/jBX8NLv?=
 =?us-ascii?Q?sfzZ37O+eLygd9PYermh8sfbOZg/Pyv4F8PUWnrtYIbyv7fMcY80RfvIvOm7?=
 =?us-ascii?Q?rAUlFHuHX2wEyXKMRgmaao76HMdtnLdbxvqP6zRd9P+RVkoOklcGdKPIXWYO?=
 =?us-ascii?Q?Vwj3xEnxag7pSzYfVeeDsZw+1/uoRqS+5K/+h7nUq/19jqu5dAD9dl+Wqzdc?=
 =?us-ascii?Q?wgJTaR5oclL87/sgyOIdcLykpq8VpAMDgN8XQOCUczi0gbSRiFrTqwKrfXfo?=
 =?us-ascii?Q?N1uQpS7Qu61qwvPrvDyyt21rRdLYvGo7eTR5StnoXgNucXLAc2iI7T8yUyip?=
 =?us-ascii?Q?ujIaixlaoHAWISRtFdaN91azAfPiq63LS9BXXtMTflZ0bi7WLF30HhJd8IqI?=
 =?us-ascii?Q?PZohfg5mTfuwITflh3rimKru/InioV40ww7cHKgfVZJKgDADWkL/fD5q+bu2?=
 =?us-ascii?Q?BL/mhpyC7vmiqi8pg1GvHAQACBB4NDKRqkgUjQeswGUxbFplHxhjQX4KACGi?=
 =?us-ascii?Q?To2RLf9+XccbJ4JN7SVgV4f21sIc9nB96PRF+hw7bkpkq+Z2CO/KFFGC7MJZ?=
 =?us-ascii?Q?hGxB3DMCPOp9ctevfSC3dFQgMduNvRTKBdbxjER7Gn+Nj4cALspnPtM7mU46?=
 =?us-ascii?Q?0dUPwZ3lkQKL2K9BrnN6niFv45O7qijhoNl3qiZX2j3LGcDRi8FWjFSgp7hJ?=
 =?us-ascii?Q?Qy9v12qx7ZZifHP0YInSgG03eh8H7C0lnNcoP3hJRpLjqmeHpwXFnVtEpuHP?=
 =?us-ascii?Q?1L31kGobK3O4k45u4AenBhbfMMPmUVq3rm/YH3Ciir/Y3kybRdS7UGi57OyI?=
 =?us-ascii?Q?fXZvm/8gB4Q6jKfUXhT620yCw+2zjCiSvGV7zAdxafopkbRNBYQ1F6IgyEMU?=
 =?us-ascii?Q?6tZv38aHangeLnRZ8X4F03WgSuKIeaX2agOi0aie1CkyWPffvs/m04ZaZeK5?=
 =?us-ascii?Q?0Q2ns5ACA6y3ayZOt4GIsvhRIcsL73sxpGIIf8BQGBfEh2e486+isbVS//EG?=
 =?us-ascii?Q?eduSJTm4Q5I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?rtmCu+G0+rt09sQgkPxu8A2a2m/LBkRsotzNq4dZUxt1P11fcsHzb0ZnNk/f?=
 =?us-ascii?Q?OuuUoXl6YzBz3/PoOEWTaH6H0G/hfSKOaQO4rO0Gfoz3XjAH6kTxeux1U/WA?=
 =?us-ascii?Q?U59SrtoT7MawT2njetFkvjeq6caP8KvK9d5zTf6qh9SvkO/cyzdvGtK8ZlQu?=
 =?us-ascii?Q?DqadAuwPRHN6bFvYIK64ALabpdBcCXZpixT37fV9UVACQcNZFu2t3YhlsD1h?=
 =?us-ascii?Q?2UiFZHApq6aHB9zTNxE8loOrAYwqTqLQvCIL15A1fxi/QrEUYoWgFg45ieCi?=
 =?us-ascii?Q?Wrbo5t/NvNf+/qIVtaKNzKGzdUI+/ErP+xHgFEHCGRsrg2ZyYLyiTOhkEYkK?=
 =?us-ascii?Q?zILdgEHoNKneY4LbVUzgkKSstNN+IPOQ1w+29+ecHsXGCY1vcHsWVDzEz/8j?=
 =?us-ascii?Q?nmqDhcrp2HYaG1t5SsnHQITXmpN0E3w2BqL09aW3i+kNBqIYUA1qHSykgTXc?=
 =?us-ascii?Q?SzxhLftDR750Yt0PpvBFZlLtOmM4N3uiI5E3RySjqliBILfto2IpEubaihZ/?=
 =?us-ascii?Q?anpGvGfTzZAxZ6ZcwHHcRNQ0IgrdC2J7nfOomv74fdm7BCFuA8TER95vlxAH?=
 =?us-ascii?Q?lUqt5RLpzMepFBdWE3QPt6QkvvQdxu/PGmVn8/z5A6ZGoUZjATovbf8oJHP9?=
 =?us-ascii?Q?pYf8kHYcwBeKR5euGMDazBkyD+Hhprxhd8Q75r0nm91vZ51udZ17b+y1sTta?=
 =?us-ascii?Q?xlSfeZ1MnLr5fZwVuLXgG0vZ75jjSNjrU/Si6s+a+Rq5O6ZG7mi5xBYqtwNm?=
 =?us-ascii?Q?F0/O/mOQrUMXRzuMpyGDX4zoc9KOj3ktcSBcAq6VFSxXkdHDv6iDbYIbWQ0p?=
 =?us-ascii?Q?27DTffME3+5jM+p8zQA8rng2O5OWICjoKm70qcZwAUpEgcBNPN00YAU5Njt+?=
 =?us-ascii?Q?rhSPlsDOEIOhFCBavPgBRYAbrkQ90dM/t/xBLXwbLvfmWDR++5b27PUTIYK2?=
 =?us-ascii?Q?/oB1mFf68fEK5qnO9XNJ/iURTyhX8OJ0CozB/BQFsCJ/llzKt3oF5+YqYrcW?=
 =?us-ascii?Q?kbZ0t7RoAb6tkd63na3dcX8kihkwxyoam2Pnd7cGa0JiWM0VU74RKU8WuLJ0?=
 =?us-ascii?Q?RF3OQSvsx1pyR891oaCH8uCf5ZNSr5C2DVi2luEEgDrHXQyAfN8nmHN+m+oj?=
 =?us-ascii?Q?plV8Y0tWb4o1QkqCXgO1t4wqJjdxrhtqfB09GcESPJYXE0iwcH1ZoYI+b1eL?=
 =?us-ascii?Q?3/fxi4u1WPdklHUUZNqxpC1d2oa1kLkVXTbUhLjxOuD65HhR0pEgKHDvo4Bd?=
 =?us-ascii?Q?LL7/4JjmRFN+v/FR1j+dcJdDDNm5fh51f34Wj8ks3TcPX2QVQYAVqp1Rgm2I?=
 =?us-ascii?Q?dweCcRmxxZgTLqVHyqg5B2oGFLUYC1F3SgynljuG65Rpc/ofR8UJRUzDZSsd?=
 =?us-ascii?Q?TCZ7n/js1le9wRQDQkmLCSP9WS0utQxJH96nbOG9AOaZ7+JzChjuMsXXuHZR?=
 =?us-ascii?Q?21BcbrwymzkVOnCalc5ZHZEUgT5341BCAxg69M0ozDR4anknumpkCtM7Uha6?=
 =?us-ascii?Q?yV/3K1EvMOVs8j9zZAnNeuq/9W/jNIq1OX/NjhMa0xS3bkY7Fs84kjbo9DOx?=
 =?us-ascii?Q?pxnLFzEz6GYKYx0ZlkM44XZj9C2k+VGtfY0P701qDmEh2lR9d2XivO3hi/8C?=
 =?us-ascii?Q?iQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	be3CHJ9V5rPb8fsfXUMWEXy5CYeEc3NZlkJs1jHfFhZkjcdb5sdFs0ml7Rj/kCEAg58Bhxfi28I7nwcOqJzak3hD8bUujfMB6xK+UJA2LYenhJ8pE+CFAHyOY1xS/u77rqFqapiXCSmNz76w/TXAVt/kfQ68Qn7p5d3uvl5qTo3lSwPB/CXu0ImqbgMngL+Vgtt4pqIRuPzpdlnl/xZWvzIFRWtZ8olSZZ4hDCiGNi3QvC1AIveppirObgFNHV1JtbCMZeQpUcXDyCv4Keee1MxNGFjr19b4HcGIdiS1Gnq6MJh2SGTFTd62qAZFhBYJxoi1yO9IXan4mKbmHSw3xnpndjcgfRaAMa1paz4xjowjNtRJv/7AMNY8s4tyaUohNzgklWxUUDQCQgg1y9xE9L/2yZXDenUsWd7o9t9DaUts/nhZVTc7r2/5TPevW877cs+shJ6IYvfoNT+5+4d2IsXGJqUyTsEm7LqiVflJVsynFR1rE7yYqxsUJ++L4bZu0o8HDVWC7xiwkbxFBclDzphH5REVDLvtjduv4KVAxRR4CDkAuwMWquYBOVRUMIx9g/v7pf9c3f8ogiMnOUufhMLSgF1r+++B4/n7lOzoHaE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc868047-340d-4b08-6981-08ddc858babf
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 13:15:57.4139
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aU9Tum+quZvpzvm3wfVmgaHRVOmg/T4pHHdK3G3dF/kGlv2znQ1CiAl0fC2xDPT7FzAoFjayox+BuMagnHKOsOsVspp3u8HJfOSS5UvIrNs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7694
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-21_03,2025-07-21_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 bulkscore=0
 suspectscore=0 mlxscore=0 phishscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507210114
X-Authority-Analysis: v=2.4 cv=MNRgmNZl c=1 sm=1 tr=0 ts=687e3d91 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=yPCof4ZbAAAA:8 a=4qlYrgqfQ3gvM0pljQkA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12061
X-Proofpoint-ORIG-GUID: gdH79BSLNc6SJ928eye_aGF_qkd5TxM8
X-Proofpoint-GUID: gdH79BSLNc6SJ928eye_aGF_qkd5TxM8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIxMDExOCBTYWx0ZWRfX8eHu/h4QjHty
 koWiYX4kctTvJoeUAoDvTUDh6maKhrABezd8y2s+TcIpyxaelJJPu34NAu7D9hQQ60oO8GMoNZL
 GieFeMMg5Nr1Qf9mX50rX1aCH2LLtw8+bTBYuOw4yH+k9JC72AL09g9rVvg/xILUxdXOlxgZo81
 WziheIUhIzmNWzKzqzlIqSuh60xh65oh/UVazwsoxjHNqg1MZGXUV+vqbIWkHZ90nqwUncZNA6A
 7J+izETMtCuVxs9tz3qgY3AO3dLeDhBR7AvccGKdd2Jlm3GNn7+iT7UL2MmdbAYJ35cUFskI0AN
 +PlLRIxByBMqSIoGW0S04NbyCyQrd1SYLeDiZR3xBliNPMZVBlg1JZLK5BaIPCXthvNeUsvQqCn
 ETxMK4B7bS4khKAXVDhDMngXuTJg3m21sFpVqeMUjctgH92k/nJ19c+jRF7G8W1UyAFWzayn

On Mon, Jul 21, 2025 at 01:45:18PM +0200, David Hildenbrand wrote:
> > >
> > > (2) Stay at THP=none, but have "madvise" or "always" behavior for
> > >      selected workloads.
> > >
> > > (3) Switch from THP=madvise to THP=always, but keep the old behavior
> > >      (THP only when advised) for selected workloads.
> > >
> > > (4) Stay at THP=madvise, but have "always" behavior for selected
> > >      workloads.
> > >
> > > In essence, (2) can be emulated through (1), by setting THP!=none while
> > > disabling THPs for all processes that don't want THPs. It requires
> > > configuring all workloads, but that is a user-space problem to sort out.
> >
> > NIT: Delete 'In essence' here.
>
> I wanted "something" there to not make it look like the list keeps going on
> in a weird way ;)

I mean it's not a big deal :P just have memories of English teachers telling me
off for repetition of such phrases...

> > > While we could emulate (3)+(4) through (1)+(2) by simply disabling THPs
> > > completely for these processes, this scares many THPs in our system
> > > because they could no longer get allocated where they used to be allocated
> > > for: regions flagged as VM_HUGEPAGE. Apparently, that imposes a
> > > problem for relevant workloads, because "not THPs" is certainly worse
> > > than "THPs only when advised".
> >
> > I don't know what you mean by 'scares' many THPs? :P
>
> They are very afraid of not getting allocated :)

Haha they sound cute!

> >
> > > of having a system-wide config to change PR_SET_THP_DISABLE behavior, but
> > > I just don't like the semantics.
> >
> > What do you mean?
>
> Kconfig option to change the behavior etc. In summary, I don't want to go
> down that path, it all gets weird.

Yeah please don't! :>)


> > > Happy to hear naming suggestions for "PR_THP_DISABLE_EXCEPT_ADVISED" where
> > > we essentially want to say "leave advised regions alone" -- "keep THP
> > > enabled for advised regions",
> >
> > Seems OK to me. I guess the one point of confusion could be people being
> > confused between the THP toggle 'madvise' vs. actually having MADV_HUGEPAGE
> > set, but that's moot, because 'madvise' mode only enables THP if the region
> > has had MADV_HUGEPAGE set.
>
> Right, whatever ends up setting VM_HUGEPAGE.

Yeah this naming is fine iMO.

>
> >
> > >
> > > The only thing I really dislike about this is using another MMF_* flag,
> > > but well, no way around it -- and seems like we could easily support
> > > more than 32 if we want to, or storing this thp information elsewhere.
> >
> > Yes my exact thoughts. But I will be adding a series to change this for VMA
> > flags soon enough, and can potentially do mm flags at the same time...
> >
> > So this shouldn't in the end be as much of a problem.
> >
> > Maybe it's worth holding off on this until I've done that? But at any rate
> > I intend to do those changes next cycle, and this will be a next cycle
> > thing at the earliest anyway.
>
> I don't think this series must be blocked by that. Using a bitmap instead of
> a single "unsigned long" should be fairly easy later -- I did not identify
> any big blockers.

Yeah that's fine. And I don't know when I will get the bitmap changes done, so
let's not block this with that!

> > > This is *completely* untested and might be utterly broken. It merely
> > > serves as a PoC of what I think could be done. If this ever goes upstream,
> > > we need some kselftests for it, and extensive tests.
> >
> > Well :) I mean we should definitely try this out in anger and it _MUST_
> > have self tests and put under some pressure.
> >
> > Usama, can you attack this and see?
>
> Yes, that's what I am hoping for.

Cool. And of course Usama is best placed to experiment with this approach,
as he can experiment with workloads relevant to this requirement.

>
> >
> > >
> > > [1] https://lore.kernel.org/r/20250507141132.2773275-1-usamaarif642@gmail.com
> > > [2] https://lkml.kernel.org/r/20250515133519.2779639-2-usamaarif642@gmail.com
> > > [3] https://lore.kernel.org/r/cover.1747686021.git.lorenzo.stoakes@oracle.com
> > > [4] https://lkml.kernel.org/r/85778a76-7dc8-4ea8-8827-acb45f74ee05@lucifer.local
> > > [5] https://lkml.kernel.org/r/20250608073516.22415-1-laoar.shao@gmail.com
> > > [6] https://lore.kernel.org/r/CAG48ez3-7EnBVEjpdoW7z5K0hX41nLQN5Wb65Vg-1p8DdXRnjg@mail.gmail.com
> > >
> > > ---
> > >   Documentation/filesystems/proc.rst |  5 +--
> > >   fs/proc/array.c                    |  2 +-
> > >   include/linux/huge_mm.h            | 20 ++++++++---
> > >   include/linux/mm_types.h           | 13 +++----
> > >   include/uapi/linux/prctl.h         |  7 ++++
> > >   kernel/sys.c                       | 58 +++++++++++++++++++++++-------
> > >   mm/khugepaged.c                    |  2 +-
> > >   7 files changed, 78 insertions(+), 29 deletions(-)
> > >
> > > diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> > > index 2971551b72353..915a3e44bc120 100644
> > > --- a/Documentation/filesystems/proc.rst
> > > +++ b/Documentation/filesystems/proc.rst
> > > @@ -291,8 +291,9 @@ It's slow but very precise.
> > >    HugetlbPages                size of hugetlb memory portions
> > >    CoreDumping                 process's memory is currently being dumped
> > >                                (killing the process may lead to a corrupted core)
> > > - THP_enabled		     process is allowed to use THP (returns 0 when
> > > -			     PR_SET_THP_DISABLE is set on the process
> > > + THP_enabled                 process is allowed to use THP (returns 0 when
> > > +                             PR_SET_THP_DISABLE is set on the process to disable
> > > +                             THP completely, not just partially)
> >
> > Hmm but this means we have no way of knowing if it's set for partial
>
> Yes. I briefly thought about indicating another member, but then I thought
> (a) it's ugly and (b) "who cares".
>
> I also thought about just printing "partial" instead of "1", but not sure if
> that would break any parser.

Hm and >1 could break a user who expects this to be 0, 1. We can always add
a new entry if needed.

> > >   {
> > > +	/* Are THPs disabled for this VMA? */
> > > +	if (vm_flags & VM_NOHUGEPAGE)
> > > +		return true;
> > > +	/* Are THPs disabled for all VMAs in the whole process? */
> > > +	if (test_bit(MMF_DISABLE_THP_COMPLETELY, &vma->vm_mm->flags))
> > > +		return true;
> > >   	/*
> > > -	 * Explicitly disabled through madvise or prctl, or some
> > > -	 * architectures may disable THP for some mappings, for
> > > -	 * example, s390 kvm.
> > > +	 * Are THPs disabled only for VMAs where we didn't get an explicit
> > > +	 * advise to use them?
> >
> > Probably fine to drop the rather pernickety reference to s390 kvm here, I
> > mean we don't need to spell out massively specific details in a general
> > handler.
>
> No strong opinion.

I mean what I'm saying is this is fine :P Got no problem wtih removing this
bit of the comment.

>
> >
> > >   	 */
> > > -	return (vm_flags & VM_NOHUGEPAGE) ||
> > > -	       test_bit(MMF_DISABLE_THP, &vma->vm_mm->flags);
> > > +	if (vm_flags & VM_HUGEPAGE)
> > > +		return false;
> > > +	return test_bit(MMF_DISABLE_THP_EXCEPT_ADVISED, &vma->vm_mm->flags);
> > >   }
> > >
> > >   static inline bool thp_disabled_by_hw(void)
> > > diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> > > index 1ec273b066915..a999f2d352648 100644
> > > --- a/include/linux/mm_types.h
> > > +++ b/include/linux/mm_types.h
> > > @@ -1743,19 +1743,16 @@ enum {
> > >   #define MMF_VM_MERGEABLE	16	/* KSM may merge identical pages */
> > >   #define MMF_VM_HUGEPAGE		17	/* set when mm is available for khugepaged */
> > >
> > > -/*
> > > - * This one-shot flag is dropped due to necessity of changing exe once again
> > > - * on NFS restore
> > > - */
> > > -//#define MMF_EXE_FILE_CHANGED	18	/* see prctl_set_mm_exe_file() */
> > > +#define MMF_HUGE_ZERO_PAGE	18      /* mm has ever used the global huge zero page */
> > >
> > >   #define MMF_HAS_UPROBES		19	/* has uprobes */
> > >   #define MMF_RECALC_UPROBES	20	/* MMF_HAS_UPROBES can be wrong */
> > >   #define MMF_OOM_SKIP		21	/* mm is of no interest for the OOM killer */
> > >   #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
> > > -#define MMF_HUGE_ZERO_PAGE	23      /* mm has ever used the global huge zero page */
> > > -#define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
> > > -#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
> > > +#define MMF_DISABLE_THP_EXCEPT_ADVISED	23	/* no THP except for VMAs with VM_HUGEPAGE */
> > > +#define MMF_DISABLE_THP_COMPLETELY	24	/* no THP for all VMAs */
> > > +#define MMF_DISABLE_THP_MASK	((1 << MMF_DISABLE_THP_COMPLETELY) |\
> > > +				 (1 << MMF_DISABLE_THP_EXCEPT_ADVISED))
> >
> > It feels a bit sigh to have to use up low-supply mm flags for this. But
> > again, I should be attacking this shortage soon enough.
> >
> > Are we not going ahead with Barry's series that was going to use one of
> > these in the end?
>
> Whoever gets acked first ;)

;)

>
> >
> > >   #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
> > >   #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
> > >   /*
> > > diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
> > > index 43dec6eed559a..1949bb9270d48 100644
> > > --- a/include/uapi/linux/prctl.h
> > > +++ b/include/uapi/linux/prctl.h
> > > @@ -177,7 +177,14 @@ struct prctl_mm_map {
> > >
> > >   #define PR_GET_TID_ADDRESS	40
> > >
> > > +/*
> > > + * Flags for PR_SET_THP_DISABLE are only applicable when disabling. Bit 0
> > > + * is reserved, so PR_GET_THP_DISABLE can return 1 when no other flags were
> > > + * specified for PR_SET_THP_DISABLE.
> > > + */
> >
> > Probably worth specifying that you're just returning the flags here.
>
> Yes.
>
> Thanks!

Cheers!

>
> --
> Cheers,
>
> David / dhildenb
>

Cheers, Lorenzo

