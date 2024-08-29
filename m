Return-Path: <linux-fsdevel+bounces-27881-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3118E964AA5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 17:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B30B21F24BC5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Aug 2024 15:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4284C1B5EBE;
	Thu, 29 Aug 2024 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MLiY2oZn";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y0LTJX+4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A81E61B3F1C;
	Thu, 29 Aug 2024 15:50:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724946658; cv=fail; b=SFsMAuAokD/Nq1SIvx7W2mfMGWaFCfISL11T6mdaZIsSggjenN1vN2eXbT9xlcnPUrU/cz9xgVTrrK9pL1hc6tAXiOLFrfdMHEiK4z+9RieBVAQ37eHGr4QxIbbAeG7ThwC0z3AgSvTgzoXPilpTY3TSg0S8Zd+B+6JpHQNkj0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724946658; c=relaxed/simple;
	bh=M1s2NKgtvKxvfibLKWvAp9qkJVBetMWZp2PhJFO5vho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OGo/yTCRFrRL36xGXfmx2QGGm1SR5RNTP0VilvNrrKidWMAgsfKmy7J8FxMCBkG2BV4NNO4wEpFi8O4sL9jkoEN/GvuJVQttHPVlqmXK3jl5IEXjN6CEpIj5E+wjc318ivIFa6xXrL9Jb3eIZuDaUv0HMSFegC7qtswrTyXb5qI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MLiY2oZn; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y0LTJX+4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47TED4tA019700;
	Thu, 29 Aug 2024 15:50:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=nGnxxxuhb0E6cjq
	8s1/mml8sjCguL6ssVOBcaMTWLJ8=; b=MLiY2oZnfyTMCOyETr1fnfiyRqjlgfE
	iIG30lx24NvZCgf6NzE+9PJLH5xFg74kAC7hmPXnNWHWmAqx1xMwOa6zAY8SXWgX
	x/h6Iw+MQ4ZjnLXrX8giUxvuPfDWmyPUHOCXU2G300q/bagJ6wrDznImRSB8YHmx
	lpGDliAcPaShUQbmM8YPcgodPABtdHY25T4/Cs9xqe2Pxf1cAG0aaNPb/4RxOO++
	SnPiCpQOhD59hXxa0peaBE/JG/uEkrEblDbOleiY+L6VemH7saH0/OZ5NNJHfJsb
	hABSmr2Bwml3eHpD4P643M5DBYVLEjAlo+vYSHVfWMEwCr8cP61UJqA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 41athxrc5g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:50:50 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47TErvgC035389;
	Thu, 29 Aug 2024 15:50:49 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4189sw65x4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Aug 2024 15:50:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mesVTOmo5MFRWvh9GGP5HM2pjSEFdfvDal7Y8J+Dvg1hJKBvmPKvh5wb14t+/tDPPgrYtWZSXaIsTab+jL6rGxLWa8pBjzYu+auAD/78a40tFYTMtOtY7AZAOaCU8JWYT8DysPkO/hYdLwGz6yPcdLOYddeckfiePR0Go5vnXhkR26tDtU0ITaAESPmIvyXwOBNK42vNfszGDsjD6qdKQpj0Q1zjaPZQ7pFwZK2wIdPGYa+OgA1bmGQxFGdwLSom/apPnSHjWApXCLOMnZQj+Q//WX3f5CW/TiwpeEWDdt2OOMHQtaCdt7lKzanWyoRGrvYerUGZVtm3r6DI20+Vdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGnxxxuhb0E6cjq8s1/mml8sjCguL6ssVOBcaMTWLJ8=;
 b=Gxx0ZEP3boFNNkYsNLoGZBsdWCCSavadBRF3pGdtJ8/QP70JGEB8+2UnLi1nsJGI6EvrqE/0dDFPG1wKB0uRYN951HRyTOsMMWcTRdmuH/zqqiVogn759MaEh2qa6jyORCNI8vx9CkkD+dK7PZcb52lwVftfyN3px+oGZWaTJmLpHfCRap949t5pRpsKlE0JUj0S+uVhv2WooqSO3oqbcB+jbOXGQosUAh8BwkRHbHG2+0VK0Qf15LLOA4LkVJhJpoe6JhQ7KIwgY18vmetzJybk04pbj3NRD1Xj3FXkNQUYsS+rtmwmGzX4Vb47xpNdKPB6h4r4IwveQHyndq2LTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGnxxxuhb0E6cjq8s1/mml8sjCguL6ssVOBcaMTWLJ8=;
 b=Y0LTJX+4b7V/QVzdhd1e1VqSksm9IjUXPaHNBNee4smzOKcN28JfOiP04TiyRkMYX4gGZgilQp51jMqkKMV82reXA5RAWd36nQDJ8sosDlOUlPZtBI2UyYlJ4WTe9GhUMRunm0z6W3MgJRFeRCfxoThgzVNmTh7vkeujDgM0XbI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB7341.namprd10.prod.outlook.com (2603:10b6:8:f8::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.19; Thu, 29 Aug
 2024 15:50:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.7918.017; Thu, 29 Aug 2024
 15:50:47 +0000
Date: Thu, 29 Aug 2024 11:50:44 -0400
From: Chuck Lever <chuck.lever@oracle.com>
To: Mike Snitzer <snitzer@kernel.org>
Cc: linux-nfs@vger.kernel.org, Jeff Layton <jlayton@kernel.org>,
        Anna Schumaker <anna@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>, NeilBrown <neilb@suse.de>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v14 12/25] SUNRPC: add svcauth_map_clnt_to_svc_cred_local
Message-ID: <ZtCY1HSpn9MGgwg9@tissot.1015granger.net>
References: <20240829010424.83693-1-snitzer@kernel.org>
 <20240829010424.83693-13-snitzer@kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240829010424.83693-13-snitzer@kernel.org>
X-ClientProxiedBy: CH0PR03CA0300.namprd03.prod.outlook.com
 (2603:10b6:610:e6::35) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: 72676df7-eee6-4285-b901-08dcc842592e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yq7PY1rzWXhkRKW0Rj0Bz3H+rCFdz24+Qa+uiPZRrh6fu8Egh0GnbIcrMqlK?=
 =?us-ascii?Q?ilEl0tNnDxzG4xaOq0Hj7nBm4RioL7IiGZLK2YOAOCT/Y58wJnSkY1xtMWUV?=
 =?us-ascii?Q?mJFo31mQdVveFacHG6cVANvfc+9ErbhgSu6+ReXLoMlGX3nT8Q9nPUo15diL?=
 =?us-ascii?Q?Z33lEQoY/OArQghpzd5lrrG9hS6q7QJmdCLRJ2f0q0/A0Rrani4t2oljHNRu?=
 =?us-ascii?Q?+dX9tm3Jm5wAb3QzjdrDldsk9AhXybkW02biarsqYz2j0BUorBJ2egofAHfd?=
 =?us-ascii?Q?i5UKKOsysp8PwbJfuRv+0mHsT33VdEPNGpVbTkmXhLpzUZxCaCouF++XnxAc?=
 =?us-ascii?Q?xbp/OrRGNn4fN/mG0WhPAo0F/7+nLaLW/Et9qhlEZSDpy54mvaOaXGRJ8b9W?=
 =?us-ascii?Q?Vav/mulGrlsrYdi3FeTt8Q+F5bymk17hiLczgYxISiqKGQerSntMKCwEhrlj?=
 =?us-ascii?Q?mdQndartJP8Cj3L2Ai9Fw/H4dT6bCLd5P8YwFqU9m13R5GotYI/Kd4fokj63?=
 =?us-ascii?Q?FCjUVcar3HvQJo5NhDIP/EsVeiv9wgiVw1KXUDsyvs6VxUA/kn5YQt6tHCqV?=
 =?us-ascii?Q?zQryemimChb0olft2oiFUd4kFo0WcyGcSzoml7aMAbmAXAbX0HAbctOpG6AW?=
 =?us-ascii?Q?X9k+zx8Ic+uFBF1RmX0ls1n7GTtt5hRH4sRD3wbNrR9MN7wRUq3QozynK0vb?=
 =?us-ascii?Q?EOGxdAWfROkoX0BuwSowmS7Vmk6HEVb4SPtlb/CPO1VHqnnfprB56n1G1UuU?=
 =?us-ascii?Q?geKvdPnCF0FDOWLIwBSESoAQlVLpvbH1cQd4234XvcXMVWNqwfq0x6MRreJv?=
 =?us-ascii?Q?YJtEUSzKYbvFFbhHQPmOqNdBXn1wxWKEtSImTeRPHGFNx0SRvvcBSR8ely/k?=
 =?us-ascii?Q?WZ15fWBC1yq1xf138efNR0g19grn2bICz/xXIJOKgcAvMZFn+W20txBKREck?=
 =?us-ascii?Q?CvvuJ6sAntd3IIcIzyKYv2RertQiLShf6sGQx1gl0l9w2lWSlTCtD34wDPeq?=
 =?us-ascii?Q?f+wXTcaMOrz8Peczk5yN5Kwqu6hTETXvkQEnXe8sbfSi5U4TlmJxlYHbYW2M?=
 =?us-ascii?Q?Zfl+d/VQItKOEkWPT/lxAngmVGYP4EUFRol8GU5uhdZjVqJXd0jKJBxHnNkT?=
 =?us-ascii?Q?u1M0baoaIGBLNMGbV7EbGf3iGofCVlYztHJ1U6BjOXgR7seQFh7xnWKZBic3?=
 =?us-ascii?Q?EFJh2ACXQ475JdgF/7O5Oxo+va7/z0N/C0Vj6Sa07Cbl12LyZF2y/lm/ETnW?=
 =?us-ascii?Q?p94Nt3zlIQW9xYwcr3J273PSpI1rtcO3VCPxmiKqi3H4rkthZfCNz1f3WJ0k?=
 =?us-ascii?Q?unXzm5MNe/yP6huyU+r1G/O/xMLdd0k6OlKkMig1Sb6OGw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?I0oVz8wiPcCniGYCGncBnmmdUTd5yYPgATLdxOiJcnl1YUDUy4Xq04ZqWg6o?=
 =?us-ascii?Q?ZQKgnWHzvk9VBX4PvJRgd7juBttXREERUA+QSylKb7CQzuHtxdaKIZ1WUf7S?=
 =?us-ascii?Q?C5CV7/WWYgbVpWJlpiaJvz9drbUybUFOfhs7HgyUDTm1/0uSO2+WxhRQYZIY?=
 =?us-ascii?Q?7qI4+VWSOCaqaPCenODXD4/JR0KxO5KMXO6Y7McxO7T0bR65z/U0uPayvfuj?=
 =?us-ascii?Q?DaMjdR8fpPjjneM4+CzzC5slWA0Fca33sYnaQy6pQBBzel1X9bVYOIrj6SZI?=
 =?us-ascii?Q?NL949f50yNu4e7nMlwdS/U+bgdOD4pjqmFjFerxmluCjTRI4PpuH4XP1eygU?=
 =?us-ascii?Q?4vaMZ9xkCALWaF0uj3chaDuOUR96tE0BU8jEZbegMhMb8LYMLHDS0Wfq9PUl?=
 =?us-ascii?Q?iNORAhRb6tCFGu6dB8CDY8U74ig9LPg2ATiULbhCGwSNo/MM6vrrlf3G6L3a?=
 =?us-ascii?Q?Dmzh0Nz3XkQf31Y8nU+vqcHI6Jo6QALPfc/ne4SXN2ylzj6M4NDGp6PxBdiL?=
 =?us-ascii?Q?ek7TZwhVA803Ztv3x9Q49EB47exSdqnRU2LqkyIsKQaCoK0y8P6nKyLoC2i1?=
 =?us-ascii?Q?xPP7piqFfxwepCDgz4CHZGXkIwRYxFNtn8JNk7kDvdr04t0rhHvVUbjPEPVL?=
 =?us-ascii?Q?CpP/w/qjViAFDubMW6ZHhj19N6g26zzjH+HzqdtWf7cl+63+vGU0KZ6LqzCH?=
 =?us-ascii?Q?z34iG6dGkHLVBe07HnPbCtTIk5m/G0YWOriE2u5HDQqGIiLdnYMwT/UkUVxk?=
 =?us-ascii?Q?duxVPXRBb9AVvk0Rxkvh/WL79cifHkIDnCUSWCD8M9bbycYGkce3sE8niJNj?=
 =?us-ascii?Q?8zazUkc3RAQal2AoJWdaF1788xPqU0wmVhw1l/7fjRcOM4qI0osUelmzWEYV?=
 =?us-ascii?Q?X9oEKpBn6xZR/FOobU/8c4ruTmSTmmkODZ/jyniBb9zF8E5NNgHNMGM+bQ1N?=
 =?us-ascii?Q?EmxJA3KGfynV96X+KnlV5FnKGoo/xJ7d+/wcPKQAUX+olu7Rtp39xzkILAMt?=
 =?us-ascii?Q?oQuze1odidHdXdsNQvsHRkIRUs3bvbsCd7RbUIsfIBMx6yRcQYkaw67xgqjN?=
 =?us-ascii?Q?VK1Pp3Ufhy5fq5iouc1R7zl8Gi+VsLx3OMp8bj5eVGSPvc2+ybmLAVEzMZpm?=
 =?us-ascii?Q?JedVC3ZBzQ6+sqUKf2nI7EIpQFetixfJ7hmMFuz5uqQq7+Ff3FTmSNbEPQpM?=
 =?us-ascii?Q?gWE/LadxI9dUBk48sQ6qHFoJvxpVgC9EUq2WQk3stGFm5SzSeU8ldG0BoUyI?=
 =?us-ascii?Q?Q3jWxKe/tlPF9oO8cWoXIdFGdee5u405CRu6wdoMTVTIDj9j799jgEZkTOL6?=
 =?us-ascii?Q?EhtauHuIeZ/hYIDLx39B12bEboEvT7oy5kQs/dh7rdLNEDShTS/PjoxyRlxH?=
 =?us-ascii?Q?n5TAOinVy3/EopyZpj9Tw7iD2O89RnD0hbwi4rtPFWuaGlUH48xOO/NICAMC?=
 =?us-ascii?Q?akqkouGa+i/AU4qZ27L4XZH1dResCKpS9PBwirnYb7lqIxA9KUbnz3iBoaCF?=
 =?us-ascii?Q?x9wMY/gyFA4vWyKx8Zk+yEUKsSKMEnqkp2qNS/DOKgiJYmWk5Wjb9NorVZQ2?=
 =?us-ascii?Q?tqgX2eAOFokD5uruNsAwa+RXvI4YdhNjih6w9ommlzmprS6YH+2dthtgDUBw?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XpBoimytKFoJcQItBLAgYHoU0Okv5ErhUEwcS2m0V0OPP2JDcpwmqo6GAYklREJrG8PnXQ/GHYmSBZ1MKFH888wbG4Az6gwFzd238xVwNO3UPcqned6sahHAtOYd+LanW8Zn9SA/J7Er/ilvj/hPRWGWRfKjGFc00qUm8c/4EAe2RO2yIcBnOga2ckpUSwxZG+VfgwfR6AuoqJJiCwz7r8RNgMU4gufQFSf2McTPrQ1pCV5H31Vflw5gUbNFv0O7NpW8zyk16IHEe9zKlO4E7uQmxfHb6ahSuTNpliD8sfCKqJPMnnvc/1R9G1yPQJBOATvEEkkTXjmIBNb6QZ689Ch6tYS7q85g2/MaFR/Z2PtSxD4zXfWxh6qV6MN58q+ZJxWZVzjtFsKYZYrAHpcxxQqg7olCbmntMJ8NIH9MTghcYM+xaGiDk3FiTiQmkxqEkN9tOV29g70YfQjLjeOWZIGUkV/yPVE4YC4addOoEIrlK0egpU3wCxZHlIICY0vO5HYTjxzJ5rGgNCHboKKSbsPsA+iqhnoTLSIlOFzYUu6Gf+wJ0QyWKpBB11tK2sdeWuvB5N+94pY+cZEC4NiyLX3UI9p7avR29HFeSIGdn8c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72676df7-eee6-4285-b901-08dcc842592e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2024 15:50:47.0392
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TD32tb7WIqQ+mhXCQs8wwWv8LWQ34XehZwHbNJmNMRALACbmcJOvWWf2q9VqLpLNcpwu5RKr8mUvxxwaelrAww==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7341
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-29_04,2024-08-29_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 spamscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2408290111
X-Proofpoint-GUID: xCSei1ZlTa7RCURtdVVNirOtDOVg2fU7
X-Proofpoint-ORIG-GUID: xCSei1ZlTa7RCURtdVVNirOtDOVg2fU7

On Wed, Aug 28, 2024 at 09:04:07PM -0400, Mike Snitzer wrote:
> From: Weston Andros Adamson <dros@primarydata.com>
> 
> Add new funtion svcauth_map_clnt_to_svc_cred_local which maps a
> generic cred to a svc_cred suitable for use in nfsd.
> 
> This is needed by the localio code to map nfs client creds to nfs
> server credentials.
> 
> Following from net/sunrpc/auth_unix.c:unx_marshal() it is clear that
> ->fsuid and ->fsgid must be used (rather than ->uid and ->gid).  In
> addition, these uid and gid must be translated with from_kuid_munged()
> so local client uses correct uid and gid when acting as local server.
> 
> Suggested-by: NeilBrown <neilb@suse.de> # to approximate unx_marshal()
> Signed-off-by: Weston Andros Adamson <dros@primarydata.com>
> Signed-off-by: Trond Myklebust <trond.myklebust@hammerspace.com>
> Co-developed-by: Mike Snitzer <snitzer@kernel.org>
> Signed-off-by: Mike Snitzer <snitzer@kernel.org>
> ---
>  include/linux/sunrpc/svcauth.h |  5 +++++
>  net/sunrpc/svcauth.c           | 28 ++++++++++++++++++++++++++++
>  2 files changed, 33 insertions(+)
> 
> diff --git a/include/linux/sunrpc/svcauth.h b/include/linux/sunrpc/svcauth.h
> index 63cf6fb26dcc..2e111153f7cd 100644
> --- a/include/linux/sunrpc/svcauth.h
> +++ b/include/linux/sunrpc/svcauth.h
> @@ -14,6 +14,7 @@
>  #include <linux/sunrpc/msg_prot.h>
>  #include <linux/sunrpc/cache.h>
>  #include <linux/sunrpc/gss_api.h>
> +#include <linux/sunrpc/clnt.h>
>  #include <linux/hash.h>
>  #include <linux/stringhash.h>
>  #include <linux/cred.h>
> @@ -157,6 +158,10 @@ extern enum svc_auth_status svc_set_client(struct svc_rqst *rqstp);
>  extern int	svc_auth_register(rpc_authflavor_t flavor, struct auth_ops *aops);
>  extern void	svc_auth_unregister(rpc_authflavor_t flavor);
>  
> +extern void	svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> +						   const struct cred *,
> +						   struct svc_cred *);
> +
>  extern struct auth_domain *unix_domain_find(char *name);
>  extern void auth_domain_put(struct auth_domain *item);
>  extern struct auth_domain *auth_domain_lookup(char *name, struct auth_domain *new);
> diff --git a/net/sunrpc/svcauth.c b/net/sunrpc/svcauth.c
> index 93d9e949e265..55b4d2874188 100644
> --- a/net/sunrpc/svcauth.c
> +++ b/net/sunrpc/svcauth.c
> @@ -18,6 +18,7 @@
>  #include <linux/sunrpc/svcauth.h>
>  #include <linux/err.h>
>  #include <linux/hash.h>
> +#include <linux/user_namespace.h>
>  
>  #include <trace/events/sunrpc.h>
>  
> @@ -175,6 +176,33 @@ rpc_authflavor_t svc_auth_flavor(struct svc_rqst *rqstp)
>  }
>  EXPORT_SYMBOL_GPL(svc_auth_flavor);
>  
> +/**
> + * svcauth_map_clnt_to_svc_cred_local - maps a generic cred
> + * to a svc_cred suitable for use in nfsd.
> + * @clnt: rpc_clnt associated with nfs client
> + * @cred: generic cred associated with nfs client
> + * @svc: returned svc_cred that is suitable for use in nfsd
> + */
> +void svcauth_map_clnt_to_svc_cred_local(struct rpc_clnt *clnt,
> +					const struct cred *cred,
> +					struct svc_cred *svc)
> +{
> +	struct user_namespace *userns = clnt->cl_cred ?
> +		clnt->cl_cred->user_ns : &init_user_ns;
> +
> +	memset(svc, 0, sizeof(struct svc_cred));
> +
> +	svc->cr_uid = KUIDT_INIT(from_kuid_munged(userns, cred->fsuid));
> +	svc->cr_gid = KGIDT_INIT(from_kgid_munged(userns, cred->fsgid));
> +	svc->cr_flavor = clnt->cl_auth->au_flavor;
> +	if (cred->group_info)
> +		svc->cr_group_info = get_group_info(cred->group_info);
> +	/* These aren't relevant for local (network is bypassed) */
> +	svc->cr_principal = NULL;
> +	svc->cr_gss_mech = NULL;
> +}
> +EXPORT_SYMBOL_GPL(svcauth_map_clnt_to_svc_cred_local);
> +
>  /**************************************************
>   * 'auth_domains' are stored in a hash table indexed by name.
>   * When the last reference to an 'auth_domain' is dropped,
> -- 
> 2.44.0
> 

Reviewed-by: Chuck Lever <chuck.lever@oracle.com>

-- 
Chuck Lever

