Return-Path: <linux-fsdevel+bounces-55001-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF33B0642F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 18:21:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D5189D3CC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Jul 2025 16:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95A7C1F55FA;
	Tue, 15 Jul 2025 16:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f8yibs0z";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iGKcmBjh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB9C1E5018;
	Tue, 15 Jul 2025 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752596457; cv=fail; b=ZCpsM0LiXUsnXlBQF6pk0f2q15hvLTirViTjb5U+VFwzhqejl7/T44uIRWZnwdjoby0H+lBVQ32Xv5MREllPmd5/bvZZD/c2ZhZTO154d4BLdcnyjFcd2WB0dbX567n2qyGXVE8c2A2DAvitBMk2bHkRZ8k2y7Ajj4SVT3wzPII=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752596457; c=relaxed/simple;
	bh=DTs09psaI1TxkZfY/vvchXuZqSygXXjjHdb5IRxVEjo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WlhRIze0dCkCMvKzCaXxPg91sfC6Kf70FHaIsSWdyhf79cUfg/2bwnE+vQfhfGiHI1Zq8e9xWm3LOKN16++TOI6UV2btMO1hwXhpxSb1+49AkqGMyW0self+RQqrvzpuRArqeaD2jNGRTcuHZdS0YYLkkbGdwq4cYhoHb/RuKuA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f8yibs0z; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iGKcmBjh; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56FDZDHV017569;
	Tue, 15 Jul 2025 16:20:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vS2H4VI5ZYMOGL04lD
	7fLUp87bb58Be2iRpfHHK2xts=; b=f8yibs0z0EvgBrE3cMyjYOEXtI7VfWNVMm
	Vto00V7b0wyaa3byk8HDHu/R+VBswNZcg4WyxJoYZbe4M+jZ1gJt5wytOsKsRlwa
	pUk5LPFliy4Bxg0QJcBg1LZjzb8PUJlC8TrRiTRWo8D94uJ6ltfONDEmUpC+CIqO
	/VBHW86T1MT2BOm6CH4PhH947Sy9idX14HlRmIfVnWo2lrt3STjsrsKe8SdiWe1g
	8E6EIBt7+Sfy4zl+IezbxYEMLsgliZLpx0ouGyVwCAOUV8HZFc3OwAje8SbResVb
	XQ2xl7Y9TO47hlg7Xdi14sX/hk2hFEIgoddjEzD6PuKFnryocSgw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uk66xtpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:20:06 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56FEuBF5030434;
	Tue, 15 Jul 2025 16:20:05 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2068.outbound.protection.outlook.com [40.107.236.68])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5a683k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Jul 2025 16:20:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lFtKfEvcMkC2ZdSVt0DqpcBOtF54ifthDTYlQYF1Hxek+RLu28X6lSJpG1obSeDc1APDJbVF2W1W8/8hdlcVlNutdO78iVSMAHbGkq1XElWvG+GwBU5TDLAfIxWUOXJCl5X4BOI5h6UBRORvqN2e/UPlxAs2oBajeJ+Wf8JxLX6TwNlwXxqiRAqgrylqQiF6qBlUe0LjKjHN8P2jK+0ZKyu54mCm0FYj3NHj5lYU2xRQs1JkYQGIhLEoDBCsaoRIUm7saDh8UZeEqCAoR3WIDQhPq7wL/UMVyY1u1JIwjKsB6+SSAga1cN1mBAoclE38PRSM0ge16jt3g5VHO2VKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vS2H4VI5ZYMOGL04lD7fLUp87bb58Be2iRpfHHK2xts=;
 b=mNzzPcsytrhFFww3LM7cDInlRP9PvxFdMJtuqRnktE8YDxIitZuCkfXQaGNF1HqXG5QKIASm2y3eOucGcT1xEHDF411zRVBj2f/7Vd+qBZgIg87zZ8VlF0dpUw1aP9inzcqSHYYQktoijryuhGeC6O8A4acUl74XYfp4htdQAomLmx1PK1WkoZCLuwTIyj6CwPd2il9Y9VhkYUXvv7EAbayEHh5Q1LxebIfUJLBN3G8bsdNQV50iWU17/wcaWaNgzdnBEk47MMkuD+gdwe8oWxND8pA83KWnW/2IWRJztz+93qAgKAIR7BuDSbPbmbwNMVOlp2KsB/4KfL5nTHPz0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vS2H4VI5ZYMOGL04lD7fLUp87bb58Be2iRpfHHK2xts=;
 b=iGKcmBjhDFXHwl1njqxyC9vr/cCZL0d9yw0cOfsXov7IqZ8++or94ALSAp9YU5ym64DJu+wxi3hsjqq9Z7BZENIvlKXyqhbD1hknXd5yfLvta8ONa8/HnMcVXScKZ6Ei5dd7jRrjo5l7x6gW3PObAZFqd8WFdes+GCptSE88a8c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SJ0PR10MB5615.namprd10.prod.outlook.com (2603:10b6:a03:3d8::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.33; Tue, 15 Jul
 2025 16:19:59 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.023; Tue, 15 Jul 2025
 16:19:58 +0000
Date: Tue, 15 Jul 2025 17:19:54 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: "Pankaj Raghav (Samsung)" <kernel@pankajraghav.com>
Cc: Suren Baghdasaryan <surenb@google.com>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@redhat.com>,
        "H . Peter Anvin" <hpa@zytor.com>, Vlastimil Babka <vbabka@suse.cz>,
        Zi Yan <ziy@nvidia.com>, Mike Rapoport <rppt@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>, Nico Pache <npache@redhat.com>,
        Dev Jain <dev.jain@arm.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
        willy@infradead.org, linux-mm@kvack.org, x86@kernel.org,
        linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        "Darrick J . Wong" <djwong@kernel.org>, mcgrof@kernel.org,
        gost.dev@samsung.com, hch@lst.de, Pankaj Raghav <p.raghav@samsung.com>
Subject: Re: [PATCH v2 5/5] block: use largest_zero_folio in
 __blkdev_issue_zero_pages()
Message-ID: <f7ad4e56-7634-400d-9e7c-3c3b65f9b1d0@lucifer.local>
References: <20250707142319.319642-1-kernel@pankajraghav.com>
 <20250707142319.319642-6-kernel@pankajraghav.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250707142319.319642-6-kernel@pankajraghav.com>
X-ClientProxiedBy: LNXP265CA0023.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:5e::35) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SJ0PR10MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: d7bee8ec-6a2a-48b7-9199-08ddc3bb70fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P20UUgguMlNTjXSBKsCz1os6actsejyfkYErnd70ORoO/c6QyI0DgArI1fxA?=
 =?us-ascii?Q?Vw2X/6Q4rF1wyod1RrLFEpe6jlK5RIDGcqOPVHUfqjcc6ZPLMjtQ+7bDajWK?=
 =?us-ascii?Q?yggwkiI8/JlLX0PnCFcGvH/fg6HHN9DB3ZW+gaQM9Oqu6jAhIw0VQ4N0nLNm?=
 =?us-ascii?Q?lqwzNURDNLCPmtA+3VtUF4dni8jUWhmENbNnjmf0qHDxAv3gtxhEBK+0tLVf?=
 =?us-ascii?Q?L4e+LclX7qfxOxvWde9sAZxI4Myekwil1RdTbuaygYGLada66eXbBEeE67Kh?=
 =?us-ascii?Q?g86YUq0uK/IEo0W7ABX2xL90+kx7bm0eJzUcLmEnmldbHOzWBZSkN8+iabst?=
 =?us-ascii?Q?iHIE2GyywabQHtusCaNJ5XdZ/7cGm2NXZ6yuSJuCqKISl/QPt1Mi3DxQwyRh?=
 =?us-ascii?Q?O7gGj3uiXwxzoC9FjHtgW3XRNksUGeO79Tbgz+qd3gKQYDY65xstxaZI30Sc?=
 =?us-ascii?Q?jlKNYN8O05REiieuJTLB4tB9MTdxF95nX9tJgmizF5lNeNVtIVjaxDYnYcqx?=
 =?us-ascii?Q?sixhvlFxhihWGWRY3MsLAsJtmsqQ4hIUTmPQoR6Ur+w6GCYbJb3myAW0pk5M?=
 =?us-ascii?Q?/weKk1bRVrHNLN6znbMmavMixCcmJxl+sAtLzxoqYtuzJ6c8uZxVeqXfgMsm?=
 =?us-ascii?Q?og2ZRWV+pZI8RUZLuj81QDgvmSp+BdAbYf144AMzRCPZhwvM0ncxT1tSjupb?=
 =?us-ascii?Q?+gVCJatUcJZQenyxiM7uIfXVURqq0BQ6YkvT39th+fTltrtwNS8CfS8J/069?=
 =?us-ascii?Q?IOzx+smwiYUZ8IkhIiVlxXWGtBGbrZiLoEe+Ah+F9k37Jq4WZIWmYU5Sj1hK?=
 =?us-ascii?Q?TwaMPvRLasHVhlw0VLlbFkIQ072M3OYJdu3tzpX+G2aJakFa5dLAR0hBrn/g?=
 =?us-ascii?Q?vgceuV45PCA/dWGXQSMOtTz1MyLRxS1OrpMm7cpO27aFCmjqsSl1pGlLKS8i?=
 =?us-ascii?Q?ONpJLlc2sUgSha6oXjrKiEBk4uRUEW3R/D/iKlLhLDEp+zqELe1+efOanWgj?=
 =?us-ascii?Q?w8PXJNlKYYIEI2xWXHa9hPVmfa1I8O+YI35LGCQuCqW3bSSFXtKt0VjFL3Fy?=
 =?us-ascii?Q?twO6wFgExLTZzqnf9gBKOpdPXDZNl/q71gDV0GhvlU+PkfavoxjJdjOtJncj?=
 =?us-ascii?Q?6uqXrOtFWqU4zEqbtRI8FzENQGa7O9NhYNowAG2yN6B9SfrHba5jyMoSgNka?=
 =?us-ascii?Q?HGDybodpPi4eCK6GvBZvjuXEXROenk3xEOIkXSLsuP0cERZhNcdPwS9HWgVz?=
 =?us-ascii?Q?0nAYkVDpuQooVLAZYp4mGv4eGS5utIgl4DJLDu0mbIC0VziG5kRGZ/RIGaIO?=
 =?us-ascii?Q?XpwKucXnV1zVcPr1Y+A4Gd0uyovukqYv35L3n0iMA93J3NATkFwVUtnKjMsp?=
 =?us-ascii?Q?dT6MF8LjHgPjk1efeclgEYKGYO2ri/40NQF/5hsItvZjYgSdyQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?eytuAIVYrtwBcdJMfneJEsBl62dU9saTy8hOXxybUUd7n1wprF+mT23L3gtk?=
 =?us-ascii?Q?ozYHl+u3tgCKerx+lzutF53prJavz1J4myuL/FLNpDFYWF5xDf+aMnCk1cke?=
 =?us-ascii?Q?xn7wxHNFGGLchUeKXtrXEBIQa+vNwyG5983/IKb87T1wpmZTCzAl8EW8nAVy?=
 =?us-ascii?Q?PlnAhG0UyiqUeo5+TzMfV24qycFrnMt6b13aPGzMo3skrEIfuglgBGeBLPza?=
 =?us-ascii?Q?jgOcLlKVqHpsku3iY0Ks/OpOr3AmKTPNenI5SdRAWIQX/AMo4c4sDmfm+XeY?=
 =?us-ascii?Q?rYKhOWLjJe8Rh/WOY3gPami49TCbl7tOHJcE369CyPG6+eC8V5N4hT1Mt6ua?=
 =?us-ascii?Q?+vywRqc2q3qpMQ1S7cJUlXvDcezibaj/W7B7v55r8TY85V0QTjaHQ/FSVoal?=
 =?us-ascii?Q?9nUyWQKXagCi55cdoFemjdKsoabD33u5SxRulo1UrVpUuHjlBXQthrlWY2d3?=
 =?us-ascii?Q?IInLVmy7CDAUJA24lxR2hWwTFR2oIcPf/bWQfjmRegpgfKkf5X6KUD1AOIXV?=
 =?us-ascii?Q?cVl5tEtVYzKbbA7SRAASJF6GvMOsXT0jX11It2mJVxbvyaRA7zooWC/MZscb?=
 =?us-ascii?Q?82aO9bRtedYwEZmzb9Ednfiy+ai4kZH+1en0NVQGxpVbLWtY/+w36f7CtdKx?=
 =?us-ascii?Q?m+aNaQ2YYyHQ++5zx742gvoKi6F6FhCyPc7PrgWp56UR/QG9qJo4y5+GnHGz?=
 =?us-ascii?Q?VP9Xh39I4vlyh43owlZcZXr1Y0JId3U/liyMFH33rQIdTPe3jIWnnZC66X5E?=
 =?us-ascii?Q?WRm5fN7kwN4x/k/CVv3SYM8mnntX2MoBIDHumaCKrSRqPmMc1Kddyb/lmNzO?=
 =?us-ascii?Q?vmRF+MGVvTaK9Xjgm6/wab0eNDvl/COu4gzAdnVsn6gAK5ycqLIT/xd1Botx?=
 =?us-ascii?Q?9Jqf7kSw+P/UYcxO97IEDH+2uomHt3FPrGEfL3dll5mknUoDUV14FSp5ViwL?=
 =?us-ascii?Q?OESoKGrYI/kuW+A1OnJ0m15hWJxJrZ981FpTjLuKl8f8JtvpH1cLLwwgqXJ5?=
 =?us-ascii?Q?kB0sS3MLPHwPbKN3EIURe91fm/zB8VIGOCGKLnCltl/93R6nxD2ndLwBWgaV?=
 =?us-ascii?Q?iYO3qIyQmEPMJFJElLpUU5U6p8sce1VXxY6Skz9B3RK8Z50CUWdq1B+dLRFC?=
 =?us-ascii?Q?i9cz45ofUNpM0z1q56CKUO5ckBno2pluotY09zvhZXjt4gF5Im1YYZK9U7CZ?=
 =?us-ascii?Q?ynAnbB4npXcqE4dHtSEYn/R0LBmt580ZTO9q2RXqcMPWJotPtMBSsRFbBjc0?=
 =?us-ascii?Q?YwUXWHeJumm1HRsJFSnrHzjOVXghXPZJfrevFsLZM/ILmIUtR3dWIvzrhcSi?=
 =?us-ascii?Q?nrDfn/5z9ZhKLrNh085Ed/BCXCtJk1Ep0SHC/INzIBNtuoU8XjdC4bFe/Mcv?=
 =?us-ascii?Q?LRfgHgE8vfOowlXSAVo+waLRZVH8b5vUPF2qMYJfU7Zev1mF+b3a5uQ+D/Bo?=
 =?us-ascii?Q?igd0w/8DN8h7tU9K64tNVJLovncexSZkGOEGo/k5vohYj04FcbiaKT/tUvj7?=
 =?us-ascii?Q?isBd+9H0OvSlKaopGn7gDndsnvAUU24JeqxLV1RO+Bfd5Vt/cxtuL2Ls8pKF?=
 =?us-ascii?Q?4GbeDAy3aKlZFyQBQQjJpanonCVDcGH0nGKOHEi2Ee5cqH7EGilAZLV6s6Pe?=
 =?us-ascii?Q?Fw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	rXBhQe70ZeLCeChVVIzVaXCusWXjYyOZV866Ge7KKjNURFWjXlAhEL4JjHaFTJXr842fILRprB0w9D/R3G8pM7rrtzTgjwtEIwwGfB4QTEOXWXAk8P5/o9NDydo8FNq/ShFvVJct5HEvvK/PZrFnWLU3PgOw9k+9NhYqqrFvPQXAOn1XWmiK7FUCMckc95KrJhJiKHNxzRU4XcMAor8cIFor8/YC1ZHju9ywdId7ffjhuiOy/Klgd7OuloP7VBc6ZrhBYoNJnaW5Rl6fXMo/W+UnNkTZ/vgeTm9F44MYy0wAYvRyTZ5fj7Zfa2rr6ZSJuwWTL7NtdEx8a4TJT0j94Sm+SPpUFc+szMp+Ib+m11SsCa9XukWiMuUiDcPCRXdfI7HRYL9BQ1uAEecIqwrtERFy5lp2k+XwFmmKM9Mede66qmZHzvTGj5mUErmxWK8hSig81Kvgt300JXNTc7tbpRvZokvi/nIpwj2szIbRw8Y14V4CI0XB7mXqbdoL7cNAsqy4IRjCQqnFvUedyBeqxeGJ8gp8CWDXhL9MmAaWLuSsmsaZav1dqo2OsRCqq3KtYv6hO3+7GsRpfqpOXOUYyM0MRXHRXg/lLRsr2SQrMLg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d7bee8ec-6a2a-48b7-9199-08ddc3bb70fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2025 16:19:57.9259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ggsUrudYkpY3heB8ZM1M16kJZ4KByWp+HljkPk2J+NQ9AkgQ/kmxgknwATxUSs8oyxvE50hKKX1WMYVnKEzM8ZkyM6nNAMByIUONpj+QUH4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5615
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-15_04,2025-07-15_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 suspectscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507150150
X-Proofpoint-ORIG-GUID: YX_aV8v15-9ZP1VBhph0gQkUco-Gx4CI
X-Authority-Analysis: v=2.4 cv=AZGxH2XG c=1 sm=1 tr=0 ts=68767fb6 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=hD80L64hAAAA:8 a=1UyMsDxo8M_lIWwXQ_kA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE1MDE1MCBTYWx0ZWRfX5B2YmPYuG+0G tHwH6nB6yoAHom4LBTubx2bdMNG332Ca0gRZBVBA/wcoTt2YBAUsEBIyvu+hs+UyqMgmluWNd2Z NO7JYKtmhIXeSNBxHDHxdrx7rHN5ocHlVMAyFPFWmXx0RPvwS3APkLvJEAsiHAJRjZt6eN+Lw7B
 H7rTPPM/f1QdoHxVJRZG27AUKzbjVvIGviaQigCtQRTXc929KNeIxMfJRuf6BiMNq9pvL9yorTq C4o1Z8HT5GHveMeB0/wFgU1tU9EyGoQLO98DiegyAspZCEaQNUcqRJ+pLns7S5HFitAb47ogst1 7fQe3s8rqCqYCJBxui1BnyIzx3SPI8R08BFoDiY3kVzpxA9eJ0el1CTR8kzGwD1B71W/lAKYYEK
 gsbgzDnsUxHQ506Ha4ATZ3yyHKL7Mt8xqKtsakOLgLq3pplJ4WUO63zehgY1vEdRsqwr2+oF
X-Proofpoint-GUID: YX_aV8v15-9ZP1VBhph0gQkUco-Gx4CI

On Mon, Jul 07, 2025 at 04:23:19PM +0200, Pankaj Raghav (Samsung) wrote:
> From: Pankaj Raghav <p.raghav@samsung.com>
>
> Use largest_zero_folio() in __blkdev_issue_zero_pages().
>
> On systems with CONFIG_STATIC_PMD_ZERO_PAGE enabled, we will end up
> sending larger bvecs instead of multiple small ones.
>
> Noticed a 4% increase in performance on a commercial NVMe SSD which does
> not support OP_WRITE_ZEROES. The device's MDTS was 128K. The performance
> gains might be bigger if the device supports bigger MDTS.
>
> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
> ---
>  block/blk-lib.c | 17 ++++++++++-------
>  1 file changed, 10 insertions(+), 7 deletions(-)
>
> diff --git a/block/blk-lib.c b/block/blk-lib.c
> index 4c9f20a689f7..70a5700b6717 100644
> --- a/block/blk-lib.c
> +++ b/block/blk-lib.c
> @@ -196,6 +196,10 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  		sector_t sector, sector_t nr_sects, gfp_t gfp_mask,
>  		struct bio **biop, unsigned int flags)
>  {
> +	struct folio *zero_folio;
> +
> +	zero_folio = largest_zero_folio();

Just assign this in the decl :)

> +
>  	while (nr_sects) {
>  		unsigned int nr_vecs = __blkdev_sectors_to_bio_pages(nr_sects);
>  		struct bio *bio;
> @@ -208,15 +212,14 @@ static void __blkdev_issue_zero_pages(struct block_device *bdev,
>  			break;
>
>  		do {
> -			unsigned int len, added;
> +			unsigned int len;
>
> -			len = min_t(sector_t,
> -				PAGE_SIZE, nr_sects << SECTOR_SHIFT);
> -			added = bio_add_page(bio, ZERO_PAGE(0), len, 0);
> -			if (added < len)
> +			len = min_t(sector_t, folio_size(zero_folio),
> +				    nr_sects << SECTOR_SHIFT);
> +			if (!bio_add_folio(bio, zero_folio, len, 0))

Hmm, will this work if nr_sects << SECTOR_SHIFT size isn't PMD-aligned?

I guess it actually just copies individual pages in the folio as needed?

Does this actually result in a significant performance improvement? Do we
have numbers for this to justify the series?

>  				break;
> -			nr_sects -= added >> SECTOR_SHIFT;
> -			sector += added >> SECTOR_SHIFT;
> +			nr_sects -= len >> SECTOR_SHIFT;
> +			sector += len >> SECTOR_SHIFT;
>  		} while (nr_sects);
>
>  		*biop = bio_chain_and_submit(*biop, bio);
> --
> 2.49.0
>

