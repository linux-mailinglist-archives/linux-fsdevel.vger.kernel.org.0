Return-Path: <linux-fsdevel+bounces-42342-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ADB2BA40AF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 19:27:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E0C80189B84A
	for <lists+linux-fsdevel@lfdr.de>; Sat, 22 Feb 2025 18:27:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8363920AF6D;
	Sat, 22 Feb 2025 18:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RGZjIBKV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="bZK46vVe"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF886433A8
	for <linux-fsdevel@vger.kernel.org>; Sat, 22 Feb 2025 18:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740248819; cv=fail; b=mt6s36yipMyOKz9l/7Lm8RwOihv28aF+2PYP169Rq2IgRxAE4PmxvSCvauIvuEtM0XsML7uNQhdLor1XSZAjVMLWt4CvKVmYLGxb8N7kKJ63RG6+4fx5jAxhpO7hmLSm3vyo3YMhAW80CNMPtqDsaADt1hHjXPvdjauC7TkK1A0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740248819; c=relaxed/simple;
	bh=9h656OOa0hir40SPDjqgGBbjOsE+HCmS3tUWYulZMaI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=seNarfSnJn/xl2/wlLmO06ENF6GCrFtD2HYA5u3zbTuTZVFRcfNuJwZj6Tvr1sTdShYb5Q429/P3zSWYiQhmDPc/7eeRuISM4reX6+8GjLH/sBGOMLbaCj7Jn975OkyMy7i9cLyFHNnd3B+wHxXQgTUU1UhakaMYG8ipK8yhAs0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RGZjIBKV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=bZK46vVe; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51MHtEjP005860;
	Sat, 22 Feb 2025 18:26:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=h0J9+2fmdkfJaKfj3F
	9JyXd8nBRuZr9ZSnBKTlm2sm4=; b=RGZjIBKVRuClOjD1tOXg3DiRgYZbyhpalJ
	cdV6MBW3pwqrThU7lWSnMIAnED9IV44BIq0k2yjpR42eNC9AfatxZuz7+qZNBWTb
	b8nXwrTHAwCn1bADEwLCRuo8w/u8cozFADXwjJpZGnT+LRM/VDiFwMF2YYlvrNZo
	5s8tVHHp/PexJAKCHZLIllLbfWpgrQs7KokLbhcU4cnZ532Dh2ZoseftgmmqiFHI
	IzGLhG2bZt/v1bkrlBdr4rXXK5nP+dByUbtdYszdcTzZ9t91qaxllwWO3FdAYJAH
	ts/K3Vbt6Jc4S7C32tqwWLgfEkZDN0CgMbYj2FczMdmrwx5GjfDw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44y5c28fq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 18:26:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51MFXUZH024503;
	Sat, 22 Feb 2025 18:26:42 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2170.outbound.protection.outlook.com [104.47.59.170])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44y5167k3a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 22 Feb 2025 18:26:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jx64Kyq5RNAo/AdnFx7ku04+x/PPb/5ljskDgHSFC37imGXE25vcS3h28kLH+7Jge6eqGmst9dr0I2ArLDVFap9Ib1t4ky/dVX0blbwT556eYUF1qGMCjiO07dwbfb5e1HgfB9oJ5ZS3gOJHwbIBzAdZCAwCmZYzCjN39BOugRxGTn0BzVFFcqRdFwAesHjoGzlzs/diIT8H0Jnhq24csOwR+sPClIYRww2vc3mGuXDDEVoMC4LFfXocRpUBdXZ4vBhD/NxHeoPHZ/yh3/hUaW67TF37foP6gGaMv08nR+E+ekvd2l89dlfv1PNiHGcuLV8EQvq80gelBEbapt91RA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h0J9+2fmdkfJaKfj3F9JyXd8nBRuZr9ZSnBKTlm2sm4=;
 b=tK94z352dWZ0zGH8S0ovg2zV859q9gnlh+Q/dglG58JKbtSmptzt1/9X8B6qfSc/KRLRiQrFjvwPo8HV9dYy+qFRu1nAqs+JBJXuMsPnkgik7TmKC+xX+hlx1bPG4RaYYSLqBnUMt0WxuJjl+tE6yURGhPz0iCpnuZiWZzvzVbh96lAvXpu4cSqRWIAhq1lyuRDnoCCw9QepG8ppljri/o18DUIiueOC1rYqtgSaDavk6eqhLKmmLlL+CMEAwuqU22Dou7WQjsg1LpPCTIR7JOdhcC5K5IngS9rahvjQnTTIX8deTIm4XTvQhyiQM6d662yQobz9Fx5NTmZc4y0QBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h0J9+2fmdkfJaKfj3F9JyXd8nBRuZr9ZSnBKTlm2sm4=;
 b=bZK46vVeQ/RWqmKmQV/NJ4wDv9erwjlWWdtwp4ltUWZW+cysmNz3+XZFzLYAsUeHmiIADSkHKL++SjUsBCoXik7Wm1QqfA08CaQdbfucZQJi7hZ1oXBtTOYBnTHtxO2Xk6vy9peKqATnJRfJXMQCCsNR1EuHoUGeWlZYHGH9IFs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by DS7PR10MB7156.namprd10.prod.outlook.com (2603:10b6:8:e0::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.16; Sat, 22 Feb 2025 18:26:37 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%5]) with mapi id 15.20.8466.015; Sat, 22 Feb 2025
 18:26:37 +0000
Date: Sat, 22 Feb 2025 18:26:32 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, Jan Kara <jack@suse.cz>
Subject: Re: [LSF/MM/BPF TOPIC] The future of anon_vma
Message-ID: <9c2f802e-d1f9-466d-b5d2-b61e5461da30@lucifer.local>
References: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c87f41ff-a49c-4476-8153-37ff667f47b9@lucifer.local>
X-ClientProxiedBy: LO4P123CA0096.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::11) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|DS7PR10MB7156:EE_
X-MS-Office365-Filtering-Correlation-Id: 19f7670d-ece0-4de5-9b17-08dd536e7169
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cfipVP0sztEwA0d+IuiTcYiB93p9Jx39UrxEPQ1eXXArTLD0O89Ub8gmCSuu?=
 =?us-ascii?Q?dj6/kBK9JG5Mfn20TscgSy6JkkW8PpQIsX3f4P1r7f2ZUFpk8S8veQLy/+dB?=
 =?us-ascii?Q?1Tus6ArP9pZfbh9D8yXwLN0biH9snyOo8Ejbr9Dn5OmoYBsr13R2CoUb/QoH?=
 =?us-ascii?Q?u9NIwnGZg3ipsaw3G9hNRZJI7VDwoCcPfXaO76YBoSBFK5JMVfXaTFppgZre?=
 =?us-ascii?Q?YHr1cXqLIp7SvWiEvBGbxtgx0v8QHr7HIjqqoMiyODC+FSAay1X7FWELD+ti?=
 =?us-ascii?Q?hhGyFOS08l84EiPtfUSURIItzfEASaAssTwb5FxLA+OPmYDgjoe9HtNLEIgx?=
 =?us-ascii?Q?6eJUOkgQdomaGittVMauY623tIndoi9/0DlxKRlBoKHXisSvXKFNCeehaKD4?=
 =?us-ascii?Q?i5/YEkfoNpIJRTxWM652AxRLVXIP8EFJcoPS4lgkCyiSj9TCfDtzMO1loPCV?=
 =?us-ascii?Q?JUVRlhrj5Wmrq3+tXlaPuyfLipvZplNEzcTLmmIPiRiXRg15NUMIS/Y+q3S5?=
 =?us-ascii?Q?OhID7ARMw3MlYACkF8apexcqX892RC/Z/cIqThp17ftLP7gah14uFpG4AN5s?=
 =?us-ascii?Q?ruFiIFcruC9KDNz8VAPteznyoqX6BiBp6hszExALVDCfa6oWtuidQrhb1fb7?=
 =?us-ascii?Q?RQfDmiZFyzRoMkwo7kmsBSFnr11Eqz97GBp/GymEViRPcm4rjVHpl9PqDQ6r?=
 =?us-ascii?Q?Xw2ruzsBDAbdv9dUlZsyKwz67ln9yz0MCC/h72luwsjE/BrusCpwbuKaYVbw?=
 =?us-ascii?Q?xfsMfr/CBoim52geckhnEHIsC8Q0lbUp6nAa6VrPQUJ+uAPcZtQcV+Ymt6sL?=
 =?us-ascii?Q?3eUQ/CngQdBcUZZ+U7wTOe4N//I/+y2zftlnvuEl2t4pMF8DFiyW6ziOTbFz?=
 =?us-ascii?Q?YgN3xp6M5f8aRuU/NM2v6JE2xnPUE0pfr5EVLLhA5ogaVDXamygiUNKgI/Z2?=
 =?us-ascii?Q?KkGG0dlvA5DXvo4lHRFst0M6BV5nyhsA+UE1RyUH17cqtmgjD/5QlubTlCkK?=
 =?us-ascii?Q?l+vVugbDGFxHHtjYTxMvTPZovtV/XvyE+DBZzt+bPCw8d5oRgc71lTXewS6U?=
 =?us-ascii?Q?w2DtG1l4iRgIWv6fiGqXMngwiquSsUBfS3HLPgrLl0j6qbudPdeCtzcP6QeA?=
 =?us-ascii?Q?xcw4zZNaXJjxfxyNKUEoKCp3VkPrjbBs95Yjc7RTV37kdqgYocPlKM3/7jhh?=
 =?us-ascii?Q?h/iV4SiuL8VjfFy40E6cH/G2PY14Vc7IYzz855GFzfLEvXdawHDguj+o5Jhg?=
 =?us-ascii?Q?hWpHNJ38I+5gyhF8JWJCbXDkEClrg7tgjtZrhR+Fw2PTFuYeisXBwfTC4XuV?=
 =?us-ascii?Q?PD7EyYkhdE1tzo2UsUkOGY6OfY/7LtvZsP4Ym+b7Gjl6dxvDoxefddAi7wGj?=
 =?us-ascii?Q?eYSzob5iMSptKB+VzqSvmI9WnEPt?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Xs69PjAbR1/9qNY5Ujq6zPdb2Sfr6GBGRxHRcfIaaCliXdaw4XfieK+1dxgh?=
 =?us-ascii?Q?aJJN0R413L4uBlV5Yby43XYf2HmVhWHkGDLwMomiqEkCxU08c4EfpeDDIV6s?=
 =?us-ascii?Q?20JdEeqDO3FTjhHvHHFqwdzuo1WLZjtqSiiuO/hcMCu1T2ILte9RQolBfVgr?=
 =?us-ascii?Q?55nmQj/zxy62Jf773ltvIQ+D526nBCpPI4N/TIA+tZehWbuVhBY1vUhg7dh/?=
 =?us-ascii?Q?Ncv34z6RMj8iAom3oNp70kBR2L/Tik9VUq2SBEd4pdHDzvBslmzwe5TRGR4h?=
 =?us-ascii?Q?QR5YFevziGp2tTTgbFoqD+7ZAog2F52uPA1TRQGNT2GQJL03hfExgTQig945?=
 =?us-ascii?Q?jwFMBslAGkGq/Ch6rFWPzBB2HDOT6iz2Wm02BwYLkoH0DW0d8b3NI5y0ePcu?=
 =?us-ascii?Q?SPVXFm6WdECi8HCzpMff3VB4DX6B/u3k66B8VdLQrzAUCs1kDWMdG9E0Djbz?=
 =?us-ascii?Q?72hxg4CIYjnJ+KRM5OQ1WSa0zgb9fXrraY2ekhNTuY6ecZv3Lo47+Yhb+pfi?=
 =?us-ascii?Q?qbNFOfGXP3Ks9C0KIANl6rFBqPvWC8a1FAYMz5zijPpL/+nkEz52C24BV8K9?=
 =?us-ascii?Q?JZ7Nts+ZKxRASIL6jzc15mGHudsVhDSrjDmbua285db6LZQ4oZgGc2YgKdhE?=
 =?us-ascii?Q?fgQQCGW87wW6IULkXyfiZFyqWYEW1J/r6h6DTMXZAIKeNe+OZUN8rWcCOm+J?=
 =?us-ascii?Q?bW90Z/NYFCIr1jWx3YJujMXwc5aUKXl5m113/+PTBFOesvkQ/8fCjMaF7Mw4?=
 =?us-ascii?Q?fCvaFuyKDrTZdHJiFdDBzYRkRTGPMPIUoywz3hwECmS/hsEPwhx2kn0o9fTX?=
 =?us-ascii?Q?jvqIDRLuIbQcNfJPSSXBGIfvB66M95VkN8SIInDest7G3lendl+fwIAc+QM+?=
 =?us-ascii?Q?x3gS1IGRTusoY7W5KrHIeG4MLlpq8z+9kfHNg54nDOfRHeO+XlCeHnFIEw1U?=
 =?us-ascii?Q?wvbNSMrwlGuYxgMdxR4EdaZADiqMU7dKbeR4/44NNBnCip6fgof2SLkfBY1E?=
 =?us-ascii?Q?4yT/ZuSOXtj8hDIW+MbDAmodhLr+cXJB4AGqvh70TI8c3zM+3KW3IIjDREuJ?=
 =?us-ascii?Q?pHdp4JtrArJhngJ/lWGo5FdMZpzZ3x627i/KaF/Dk7EapbxJKtTvig3wDsQz?=
 =?us-ascii?Q?N3rf3D+3hljsW3AfuaVcq+g+thnt33MpSlfPu7TnlavKXmgxA28K5g/iRPHH?=
 =?us-ascii?Q?GHadvkDCwe3lka0+ZVDK77Nn+aCo8gVWp4SxE1J6FGb8kpd80zuN9zkOw+yg?=
 =?us-ascii?Q?wZ49s3AaJKrvLx4LasZNk9onmYP6Px33Vp5mVkS/+CA7QGsku+HJExwzfX9W?=
 =?us-ascii?Q?vcbf5eNYZAmgFAY4wo+HiQFlKKC+uOdeS0qlaWVqYyD17kAM5FUXRJjONrIM?=
 =?us-ascii?Q?osjXD4VS039kL2okvXImoWWCPTUzysSYUF5LrOD3MznQfaxjjUZgnSQDrmlM?=
 =?us-ascii?Q?kjLeDbxNNTNIK17lj66qBWH6B/9EizfCRWbTngJtOj57ZAWbC5qIsVtSrbnz?=
 =?us-ascii?Q?Ve4LPrDbNkWqvluF8yKPYn78B0msFomV6cHTRFEDvmXjZ2CAcHWR+JnTLPAh?=
 =?us-ascii?Q?wlLYeK5eaIXqxbrYXOtK/klvsgd4XgkzrcUTArJos6SSXNp+n5lAemA8AOte?=
 =?us-ascii?Q?GA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	eMLPPMBlwLgae3qcRKANftUBSpwBLKBbcHAfIc4nSYHtmg7n/7J48vd8oBxYyUEVm8AEQnl6HHk4+zJWM9GXOjWFDfRlKr5fx2e2aF07q4oPKncUlcFPKff07gXKSNhVvCJ8mLv99ApfpiWz3fet/mH/gDJA3gn7jIwMrb4M80Tr4ybPAO8m4lTkQldw3lhRxBv1tHk75rzfwlfI66oAEwUs5j82+Wu6u6ajIhQJEJLNQJ0g59tIcWa/p+fQalcilgX2/6aQ+5gqo0ZmbkcS3v+xqXyV9JMkcH9QcIzs1tO1PHZTgAwNd1hYE41sR0/+MxdNGkiX5wiMu33Mm0vucUefwmE9jAgM3I4cFVSK2iFlmi9JvwOuwZSr77AFJxCbwc/H4Uj08UFxJsnRILzQ3JvpCGswv01/f13nd//ornjVgg/NzB4rIXlaXZ2rPe5rkXzOt7kVathTgSEfqjIUvHimWVN1tiD8YCgVq3FYJQbsFJ0LqklUz5/3E6tHvZHiNR1VMFu/4fABH+++cOo9inb3rmUqcOyWdZadxc97aUrfv8q2WlX8o5Ad1g56X5t6xI2O8Rm4p/3IcuMc+MUCRtTxCzspYs2rZljSPgZQCxw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 19f7670d-ece0-4de5-9b17-08dd536e7169
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Feb 2025 18:26:37.2051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SCFvqZTGe+LMxGwnLopxb3kIBnvucSQiAOuwKiBUGDF5cC+4g9oZJaZ+0BecS0ILQ4HUrYuAzMnGCayeHeKGmumAodMwp9tPOd1L2EZEL4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7156
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-22_08,2025-02-20_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 adultscore=0 mlxlogscore=903 bulkscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2502220147
X-Proofpoint-ORIG-GUID: JetRyLAt1cx7KtnJ6T4Bgz9XJf8y0TwU
X-Proofpoint-GUID: JetRyLAt1cx7KtnJ6T4Bgz9XJf8y0TwU

Having worked on slides and done further research in this area (I plan to
really attack anon_vma over the coming year it's a real area of interest of
mine), I have decided to modify the topic a little.

Rather than focusing on the possible future ideal very-long-term project of
finding a means of unifying anon + file-backed handling, I'd like to take a
step back and discuss anon_vma in general and then examine:

- short term improvements that I intend to attack shortly (hopefully some
  of which I will have submitted patches for -prior to lsf- as some people
  are apparently adament one should only speak about things one has
  patched).

- medium term improvements that require architectural changes to the
  anon_vma mechanism.

- and long term improvements which is, yes, unifying anon_vma and
  file-backed mappings.

I think this will be more practical and we'll get a better more actionable
discussion out of this approach.

On Wed, Jan 08, 2025 at 10:23:16PM +0000, Lorenzo Stoakes wrote:
> Hi all,
>
> Since time immemorial the kernel has maintained two separate realms within
> mm - that of file-backed mappings and that of anonymous mappings.
>
> Each of these require a reverse mapping from folio to VMA, utilising
> interval trees from an intermediate object referenced by folio->mapping
> back to the VMAs which map it.
>
> In the case of a file-backed mapping, this 'intermediate object' is the
> shared page cache entry, of type struct address_space. It is non-CoW which
> keep things simple(-ish) and the concept is straight-forward - both the
> folio and the VMAs which map the page cache object reference it.
>
> In the case of anonymous memory, things are not quite as simple, as a
> result of CoW. This is further complicated by forking and the very many
> different combinations of CoW'd and non-CoW'd folios that can exist within
> a mapping.
>
> This kind of mapping utilises struct anon_vma objects which as a result of
> this complexity are pretty well entirely concerned with maintaining the
> notion of an anon_vma object rather than describing the underlying memory
> in any way.
>
> Of course we can enter further realms of insan^W^W^W^W^Wcomplexity by
> maintaining a MAP_PRIVATE file-backed mapping where we can experience both
> at once!
>
> The fact that we can have both CoW'd and non-CoW'd folios referencing a VMA
> means that we require -yet another- type, a struct anon_vma_chain,
> maintained on a linked list, to abstract the link between anon_vma objects
> and VMAs, and to provide a means by which one can manage and traverse
> anon_vma objects from the VMA as well as looking them up from the reverse
> mapping.
>
> Maintaining all of this correctly is very fragile, error-prone and
> confusing, not to mention the concerns around maintaining correct locking
> semantics, correctly propagating anonymous VMA state on fork, and trying to
> reuse state to avoid allocating unnecessary memory to maintain all of this
> infrastructure.
>
> An additional consequence of maintaining these two realms is that that
> which straddles them - shmem - becomes something of an enigma -
> file-backed, but existing on the anonymous LRU list and requiring a lot of
> very specific handling.
>
> It is obvious that there is some isomorphism between the representation of
> file systems and anonymous memory, less the CoW handling. However there is
> a concept which exists within file systems which can somewhat bridge the gap
>  - reflinks.
>
> A future where we unify anonymous and file-backed memory mappings would be
> one in which a reflinks were implemented at a general level rather than, as
> they are now, implemented individually within file systems.
>
> I'd like to discuss how feasible doing so might be, whether this is a sane
> line of thought at all, and how a roadmap for working towards the
> elimination of anon_vma as it stands might look.
>
> As with my other proposal, I will gather more concrete information before
> LSF to ensure the discussion is specific, and of course I would be
> interested to discuss the topic in this thread also!
>
> Thanks!

