Return-Path: <linux-fsdevel+bounces-54930-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A51BB056D8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 11:41:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4054D7A46AF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 09:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B2892D63FC;
	Tue, 15 Jul 2025 09:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="L3lt5iIV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hE8ABetb"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA6326D4CF;
	Tue, 15 Jul 2025 09:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752572480; cv=fail; b=B0HFBQUzsvnALPLF9Slq6L6mXZxBpyQ/p80f3w7TazuLJmP02yjpIjL0csZ6pWNMBKjMAl7hfs5eIIvFt0WtINfdkMFANSEwj+W6MRLh1/SlqWZkriqg3kbQrH6pvsQFuPqdfdibh7WlbWQmGWj4lgVMhNYBCFZmloVmncXTOyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752572480; c=relaxed/simple;
	bh=mCvt3WXv7RG1BYatDk8T862WQEBITZZTfIjkxeiVlvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=O0pJFGPWBtf0ewqPp68DVBT/YK/FKaVp5FrmvutKvrGFkEKbYUKiyaESZPP4hH9xjfXJr28RgFnqsFJetovWlOhySOMteG5dxG4F6DJ8drwMHIeu2TUHnjOX1rgTRv+yvDsU5M5O/DfNFTPR3jwTZoFLM2NpwRcIYAnE15MPSbA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=L3lt5iIV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hE8ABetb; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56F9Z6V1008277;
	Tue, 15 Jul 2025 09:40:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=mCvt3WXv7RG1BYatDk
	8T862WQEBITZZTfIjkxeiVlvg=; b=L3lt5iIVR8OxrqKCPtvFOkkKSQby0tQtkJ
	skFnZQ2mR0jTFTiKdIdMf2zGVR5pUtOBJIk/UNuRXVuoTR+g6S8nlCGSyztCRvCm
	vJwk70YGJw0b+DxITlmv9VwrMnNw0rxxQGAqWniJhzc5hM1+CO70x8lakNhcOFyD
	pi/V+7vQJeiqSxge366QnizNbtPTxqLTS9+TExcerNr1AL4hlEyu1aFr+4ui7NDB
	JFcHDKn7sW5STNpEOQ7iVqmMvxLnwCawUEXVbngE6ggKQFUwflDceJm63m4J9+PY
	F7C+4ovdyYDa5aR/whmO5HGMtARb96/xQy37I2+7+UQ4sMYmoG8Q==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhx7xgf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:40:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56F7Uf35028956;
	Tue, 15 Jul 2025 09:40:43 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10on2053.outbound.protection.outlook.com [40.107.92.53])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue59fxmf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 09:40:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OLatd2AVTNMInMDbIMcpMZgLekviQoNP1wIZ5FFd3cVmFK5ggyiSU8s66TDfMrq9w3CTV3BTGG0RUuN7qAlqlOrZfYUI0Aw09WqdZbttkVKhXJ3675Wes6Yly/1xjy9AnYOlVyPXttj/7UAMgDtywNNeIKgdScfdmBdHknnfgAROCnnGRlIM+PWPb0Jgg5FAgW+9pBInwCohBrZ5pJZ/u6fcsMXY35jWSfXGSUh6o4R3x/NyG3v9tyGNdG1TilLU3TtQxq5Bl7Cqbd1kOyjQ+ONrm0MQaAIYr3Fw7ltnmriyoSpuLYkGfQTcO/N3H9gEJudIYvOqhjaJvB5MsQquPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mCvt3WXv7RG1BYatDk8T862WQEBITZZTfIjkxeiVlvg=;
 b=Ix7xVy1KkxggrOpd2PZVM7+LLK6sjjJCq1R0SGg0cra+ktWXu4dqJnx5L9Y8eVroZBnyFNads+8xeaDmJgXHCFXpxZ2/WhfG2756DvRyD7gPIvDFopHGdaKu20ZFhJu7VBJ4ZtaCYCHp/Ry55k55aDvQkKb9dRjoA1zdiGTtes1lv6bddEa1RaQKe46wXjMANXhmhrLdRCMbgcFpSw55fpyoJQPEY2j2fZvAxkUzB8eEEY1+BazadWPv7PcK8/fkr6b2rLV0tzV+mtR+8ffVFct34eoJadii0P76RiBqrTg4qFE4I/MuGsh0ZZ0ChnlQrKtAQwXAkzOF0LG724ioag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mCvt3WXv7RG1BYatDk8T862WQEBITZZTfIjkxeiVlvg=;
 b=hE8ABetbvFdgac2XQVZuoi61adiWlV9iQgzbamjdcTtAi4qClBvfkqZxgJyYo832d5di5/VbZoVGqluaVoK9kx7OgiUUPXuLI3gx+EJSLQsveUta0Wt0q2bUu51YoTYnd3y7PBljN6xQ0JmfuxWmFlSx8jz6ZkS53C7kOUAhT70=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SA1PR10MB7553.namprd10.prod.outlook.com (2603:10b6:806:376::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Tue, 15 Jul
 2025 09:40:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 09:40:40 +0000
Date: Tue, 15 Jul 2025 10:40:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Suren Baghdasaryan <surenb@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org,
        david@redhat.com, peterx@redhat.com, jannh@google.com,
        hannes@cmpxchg.org, mhocko@kernel.org, paulmck@kernel.org,
        shuah@kernel.org, adobriyan@gmail.com, brauner@kernel.org,
        josef@toxicpanda.com, yebin10@huawei.com, linux@weissschuh.net,
        willy@infradead.org, osalvador@suse.de, andrii@kernel.org,
        ryan.roberts@arm.com, christophe.leroy@csgroup.eu,
        tjmercier@google.com, kaleshsingh@google.com, aha310510@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v6 7/8] fs/proc/task_mmu: read proc/pid/maps under
 per-vma lock
Message-ID: <19d46c33-bd5e-41d1-88ad-3db071fa1bed@lucifer.local>
References: <CAJuCfpGegZkgmnGd_kAsR8Wh5SRv_gtDxKbfHdjpG491u5U5fA@mail.gmail.com>
 <f60a932f-71c0-448f-9434-547caa630b72@suse.cz>
 <CAJuCfpE2H9-kRz6xSC43Ja0dmW+drcJa29hwQwQ53HRsuqRnwg@mail.gmail.com>
 <3b3521f6-30c8-419e-9615-9228f539251e@suse.cz>
 <CAJuCfpEgwdbEXKoMyMFiTHJMV15_g77-7N-m6ykReHLjD9rFLQ@mail.gmail.com>
 <bulkje7nsdfikukca4g6lqnwda6ll7eu2pcdn5bdhkqeyl7auh@yzzc6xkqqllm>
 <CAJuCfpFKNm6CEcfkuy+0o-Qu8xXppCFbOcYVXUFLeg10ztMFPw@mail.gmail.com>
 <CAJuCfpG_dRLVDv1DWveJWS5cQS0ADEVAeBxJ=5MaPQFNEvQ1+g@mail.gmail.com>
 <CAJuCfpH0HzM97exh92mpkuimxaen2Qh+tj_tZ=QBHQfi-3ejLQ@mail.gmail.com>
 <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5ec10376-6a5f-4a94-9880-e59f1b6d425f@suse.cz>
X-ClientProxiedBy: LO0P265CA0002.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SA1PR10MB7553:EE_
X-MS-Office365-Filtering-Correlation-Id: a52cc0aa-af0f-4acc-7ff4-08ddc383a973
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?puvPyFr13HMZcmxsFQ7iS+nS3ONElVicRntcBZg7jJbX76YBj0eQIF6DXgBF?=
 =?us-ascii?Q?Z1BmtO0+xFf4yigmtUwhjYy7hyHDpAjQhhaejrkD0RyZedbjSjE0BJkFFD81?=
 =?us-ascii?Q?+OeUyNQkdUZBpQx9sfm1ONlDGzHsAfC1AZIbOZERBeza5wN/Ah2zUfP8wpUq?=
 =?us-ascii?Q?hxyPnI5qmWyBcR9ikS0cMRYb73/YVeOqs6rl0Zns3s/qv5AYGepkIkH6j2kd?=
 =?us-ascii?Q?/btF2VETMtCxKmNH3GqtxF2aDyihv82JgNInU9ZdpIM2n9meNM6Zx0GsuGdA?=
 =?us-ascii?Q?IqJsPhDcNV7kwKcFblePzq8v9bnYkFr+5xXxTQ3vRrPJRp6rQB8L1M4YZkWD?=
 =?us-ascii?Q?VjOKQ/mXdYo7gnLRqEyoNkTUiNfyBn+0Bp4rHBg3IxUs/zRfS6yjm/qdhdlW?=
 =?us-ascii?Q?SnCOCDmKQZKZqamE4rAseObakhNLKcfKlBntDlu3uO+6WJ6S+BVBMjszGnKm?=
 =?us-ascii?Q?f7223qo9XjA18n9Tz8RKL2hjXiJK0l8b2/r68Nsp4rCdx38ZL2moE6o8egRg?=
 =?us-ascii?Q?r1/SOauyHBUoUeAOdjir4yij7QzOyhwg2JpFQ8FEO3jkMADidsioBlFHUqy1?=
 =?us-ascii?Q?4MKEyXeWvaDoTdoS7LZ2/1fQc60rzMunyVXiafeijIG5UGH2lMe1ZcYiZ5sf?=
 =?us-ascii?Q?eWmpNMT37WYUzEfR1zdDvSJjO5RrV6qvcIQWOOdsQkHV5OjXdBxDpq06qUok?=
 =?us-ascii?Q?vXD9OcHUYDtte44ajDofhtQOKYlozw5ctPsVzFHzD3NuOPWbm0ZvCz8wRfl0?=
 =?us-ascii?Q?+nI22fxql6JQtd+4lXCwMDjn7boZy0SOVm0in3uEDt2tX8z9yHgLfQ///mOJ?=
 =?us-ascii?Q?O5oOe27ph9+Ort1oJtvgIDpneY6YWj+uONnedzBWTVpCVe6vr4I7lmyMgr2I?=
 =?us-ascii?Q?UAfq/V2gUvxJ8Zx0ibf3Gfkh/d6VsQcQw9b1ITqFiO3P5qnaDZJ+rZltfFjS?=
 =?us-ascii?Q?dciTrsLaJfyobjMY3iF6+4YcYifT1HXZ2J/+ATQ0B0ULKyjCEDGXylJJ2q5w?=
 =?us-ascii?Q?lYXwt2NZ2tFquz4xzPzj9kUir20ok1ta9LXMBA99poWAyD33WTLt1Z93t6uu?=
 =?us-ascii?Q?etXKC2UhGxQv1lg55I/A9vmebrA36dZ8Cy53QQT0kXSjTFJhNymdpRdAqSrb?=
 =?us-ascii?Q?ewnkn7EkTrFyodBkyWC4+/OYICRQmQe35KX4r55lt95CwE0VnABhLpT7FXUF?=
 =?us-ascii?Q?a7O6m95wNM3pr11Y9Xresw+TELD2Qbijt0FHCJGAFaSv22U62OQ+JwRekfjA?=
 =?us-ascii?Q?SS7WV/AZBgDKOrSoIq5yjfsB426dj2zQ6E7NC88v5nwoL1f+P/yGvdjhbyiO?=
 =?us-ascii?Q?ll0zVYReqqtqqrSaMKcvh8rzdf9zlpFjV3BYK8Fy5+2g+CiAbSvIz1nCcB5p?=
 =?us-ascii?Q?9W5DRopjuT232vQihCFPE6qk3PubbZxcsyf9bSQMdI7o0JdFYw1iVkkDOHuO?=
 =?us-ascii?Q?QAiungfb/og=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Us4fITru90V4Y04B1xYrhTLSuJU7BGZ2+6x47VpvMQOuc2M35LTajST3IMxR?=
 =?us-ascii?Q?TcsLzlSrpc0sUaQR2vwUbM3Qr9HpjjfCWhBVJxAh3eKhHHoO9pCWG1Hy6MOy?=
 =?us-ascii?Q?adIOe/WhmNn0+mN5dsixBuWvK0+YO5e6vh8C9OvDHGQc6O+Wgj5aFzzpEhlh?=
 =?us-ascii?Q?Yj3Ht8Bs3EinEetE10fsDB6JIOP94nCZR6fqtH+x3d2fn4GvcsmjLnKx8K/G?=
 =?us-ascii?Q?CFA6j3RcyMxi8YXgi11bohRN6pWNh7VZFEc4b1W5eq8/uQe2ujRi1gd8cJJx?=
 =?us-ascii?Q?J+0FnmKcATAthAAafi4Z5P5UfazIIk5/JlGpTG2J+QBIlENYs/jGirKZll6v?=
 =?us-ascii?Q?rTR/Lz42qBTNUnzNo+xZVOsPWtohSHeqEgbYeG0wULRCfBHHBo00g93WDK/E?=
 =?us-ascii?Q?1Dn4ubfa/8nzSAQEdANJCiIfPXAtYDW6f6a1VqB90DJSU8hlFEoph8nbK/yl?=
 =?us-ascii?Q?MnExOGldw34/75TuJ3vedKJiKfXWPn0W6OOifhJ7hVMrsoTP7LiKB80wY9Ac?=
 =?us-ascii?Q?GMQRQ7tTpOcbb2Qv94xtTapGNq6bDYFxYzyx2k1t+d7oalBurf48HWfswBjH?=
 =?us-ascii?Q?iLGdSUrx9XzXdunqyIUA96SWFBb4OY3Wz4wqRpiWx+oESAJZxFZd3Sk5LLlO?=
 =?us-ascii?Q?0jy3hYpLz3isNYRPXZRABRwdP8YPXzC9UIKQjz7C+dDk/Q/3hpYg3TyeHdhR?=
 =?us-ascii?Q?NqQJQEAL1j/RXmeqMyLbPl0VrmsaaKmuJ336/Hw2P8v6GSsMfP6ziDdtlnMi?=
 =?us-ascii?Q?rKKUh64VuS/wqdcZetUtc9U2aPe2Gn7LF/EoQYhsisLcnt7Yj/o3lAXHRqD1?=
 =?us-ascii?Q?YUy1O1y8tj+rprbSeBjLpWEFKcyOxC8PJZHHHmH7qrcAqq9/q8pIHbdc/LjR?=
 =?us-ascii?Q?bkdyThMLbt2GHQS6ZF6hka/qGpG+WyF2M6QoqwbDzwcJMcAvi44hvxUJF2ge?=
 =?us-ascii?Q?876V/u5ZZSn8Wp3a57M70zvWyCszX/hOiWxk0mErJMy1b6wuqAZMk++TzdVX?=
 =?us-ascii?Q?El3VS93e12W3Dx/51HiI0OcH4Ui6Rab7LiLUa286ZC6xWrvRCIkGut55oLm3?=
 =?us-ascii?Q?O50Qq5irDiVP2YmQ55XfgG7sytO3JaCzM5NdNqBolbM+O/0Lu1iO4NehpaGz?=
 =?us-ascii?Q?TMTYHnIC2yzJK5u0Bv1RWwvyiU6Z6S860CVgTkX7XPtUBKjIMlv2aKtk4ZW4?=
 =?us-ascii?Q?Yt5BmBiuk1ERgPB3NO+dZpSb+1yzb8q/y/VDvh6fC/d0VeALksnOqDk+L/LB?=
 =?us-ascii?Q?Nf6VZsmGuQK3H1sGcV7jh70XRf2lm59gamO1MHiRtAw4MI/U0K8bnzQUkhaH?=
 =?us-ascii?Q?6PZqDbtAwlSILZ5R/soUSicKPZY8ZpFdeOH8XeH46DmScF0uFsTkqBgJUvSK?=
 =?us-ascii?Q?Bb52sY9o0rzFDgy0K6IiJB5N+XIrp9+GMxplGIpDAeQDhj0j3eOufM/W449F?=
 =?us-ascii?Q?lUGGFnIa/eavYPTkBjHJraP4H1a1ByYqkGHLhxhHxnzTDx0IaCb6lt7WyD3c?=
 =?us-ascii?Q?luKIwu0O3tSe/TJUMINyb79e3TvMiAV/3y20eGQQWpfHILOs1kycEcjZlRq1?=
 =?us-ascii?Q?4D20ISnoP/toGmd+ehCda3EBlZ4kH4/duMMd3dsPEI7tJ7mwCWsgDJHR8OZ1?=
 =?us-ascii?Q?Cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	58fX1WkEW2a/O5kYEg3ZXPjfqpDqypX/BgKwhaFuUbJmvaLxpOu+dRFu6L1wSfuRAjzMVDtBf5TvB4Ggwz4vOEdL8ogz9WzFd5Fhsbl0JbAwVgWdsHbXqgTajlI8SLQcpKgETDURq6aZ6sM95uuWhk/fX9Nn5FIqF637SQM6y7EFxMxUUXsQd/1QPBBfHEz7RshYtdX0RpLIvOZaXSaTLKUha+wVLuik7qG1DpYeRf7d2R5VAqSjHBP8+3FJpi/wtNQJv8/C1Ii1HQouoMBosNg2ca9tEtPXseMEnWBioZOVOyaOf6Ch1GaFge2glukLak8TjrqnGpv1EovXx1bkAN+Q1iY7YU6wnxTRV0YXjyEwA9Aujdgc7Wvv7Y3Lx33fsafF2b41VofzwD7XU1bHhbXd9U+2B5p0OKEO9TZPbZxBls6chYfhID1/wVdd5EWVqFXwT0Ip8bjRFCevSR/AZvoplC9OhO+c5MWd5rTaontDoHqxYDRtIjPeCWthzPG6qoQYxx6ulQy5eDm/5cgNo/g4Bu52wHeJn31WIL0CU8lCv86HjMjFD9SdJYVw3S44Bdn+Po4K2jJMAf9Ps8Afby+y7JAGDlQ1Q9GCKRV7798=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a52cc0aa-af0f-4acc-7ff4-08ddc383a973
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 09:40:40.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mNfI21opE7ijUGPK4eq2M3wB98Y6SPAjwwXN7TbjmMEfPW/Zo1oSWl9uJYSuP735SQ5UpypFfG8zlJ0vH8z0z86Seks+neA0jt3nZmOMnkI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7553
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-15_01,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 spamscore=0
 suspectscore=0 adultscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507150087
X-Authority-Analysis: v=2.4 cv=auKyCTZV c=1 sm=1 tr=0 ts=6876221d cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=oLQxp15okELsGQ7GpiMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: ABEk-TFkAotM6wN6JdHNgiUmMGUQIkZU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDA4NyBTYWx0ZWRfX0Gp6yd5l/P3O U/spjNU3fvDncsaxeJIw4TRlQAt2b8yUjL9KIWlTk83xI+JXJ/kvwPdEsL9jdyoL781/n76C/qo 3Gl4zAchce56/H4X9MNJUc8BgmY11z3HppZE5puSqCa8Dujn13E0nDkAoVD4NQN02DnNFSUnlx4
 rfTKTjBx0mwqbGLuDFRvwRvzIL/l1QxgQhuM3nEZdu3t4IyKsHTkZZo/JmTc4Ir7g/5sBftCWjn td50E1qpJFIsYjh3Gz3aSvoZNnvjCGsIy8yUXO0n/1k9vxNInCLNs2VvuC7mM+u8i1PHant/HJ3 A/EwghEK2gI1G8d7Z4d18xdQqBHFLobd82vOEimIxXpslbya2UM2U5sd47QtquVuBvexGCnAJDX
 eQOdGG367YrZie7lPf76+YuD7ejgLhj9mCnvQOvJlfgAiXglMJ4ZLwqBGiK9seU18X8KS2Rt
X-Proofpoint-GUID: ABEk-TFkAotM6wN6JdHNgiUmMGUQIkZU

On Tue, Jul 15, 2025 at 10:16:41AM +0200, Vlastimil Babka wrote:
> > Andrew, could you please remove this patchset from mm-unstable for now
> > until I fix the issue and re-post the new version?
>
> Andrew can you do that please? We keep getting new syzbot reports.

I also pinged up top :P just to be extra specially clear...

>
> > The error I got after these fixes is:
>
> I suspect the root cause is the ioctls are not serialized against each other
> (probably not even against read()) and yet we treat m->private as safe to
> work on. Now we have various fields that are dangerous to race on - for
> example locked_vma and iter races would explain a lot of this.
>
> I suspect as long as we used purely seq_file workflow, it did the right
> thing for us wrt serialization, but the ioctl addition violates that. We
> should rather recheck even the code before this series, if dangerous ioctl
> vs read() races are possible. And the ioctl implementation should be
> refactored to use an own per-ioctl-call private context, not the seq_file's
> per-file-open context.

Entirely agree with this analysis. I had a look at most recent report, see:

https://lore.kernel.org/linux-mm/f13cda37-06a0-4281-87d1-042678a38a6b@lucifer.local/

AFAICT we either have to lock around the ioctl or find a new way of storing
per-ioctl state.

We'd probably need to separate out the procmap query stuff to do that
though. Probably.

I don't think a per-priv say lock is necessarily _that_ egregious since are
people _really_ opening this one file and doing multiple parallel queries all
that much?

Anyway this latest report seems entirely about the procmap stuff.

