Return-Path: <linux-fsdevel+bounces-59882-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 703E4B3EA63
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 17:30:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E78467A3EB1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 15:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52B9036996E;
	Mon,  1 Sep 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gnkApBhS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FLSDyj6K"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE0D9369960
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756739709; cv=fail; b=XjgRz4t8hnBiGlpTIqzGD7suogV1EbhtFyVQZ5R1Kz/C/L7WL1TzzpeEiDNG3MCL5vczAh7AQBMvxjr7Gxq8GumYMb+uEId1VD+B+AoP6BPNLH9xulvu0Az5OwQRtg77S4iwCYqdH7g3yqYzB+gh0l+rQXlaYjnC8HAoxHPjZsM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756739709; c=relaxed/simple;
	bh=2IU1uWgiBjKTwN5PEI26TsBzxkaa7UgKBofnvsmevtg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=G1asEIWBbaFvGFZrA6gNit441h6g1LgXkjk8Kx1wCjT4hBkyvgLsED/YZrh3SbaI4jdQE0KFwYTMwIVU2KrX3w5Dq8M+PSOjV5XlsOHWSkJVG+2V/Znuej0ORd5qKT5OE0HDkWT3qo4HcnaUPMgv8AvGS+Q/YnNkS50LpE3h0LA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gnkApBhS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FLSDyj6K; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fwIb000592;
	Mon, 1 Sep 2025 15:15:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=VmmkZHzWr1BGTeCbr/N9dfadXqgrYClCXaTmSE/Klxs=; b=
	gnkApBhSJSfSo1Iv5SlO9J1Nx+D5U5A7c5ec+C8PudFarTmPHRJSU2EPh/2/Jqq4
	+0E3U8CV7i3wbrVBgoqa5xFyLHOR1kFJMUfb7CiCUnmwcdnchuRjX5FYm/kRL/WP
	tH/JQEZ/I4bN++VgoeXqJMOgpFDjaihlJHxpkHnYjXIodF/hysWA06Gckm2aGicA
	wo9Q/bmm8UfBX4awEszHvJ40edpkIFITIDoGwgYlfe3pmxwItvknCsIz6Xb9oL1l
	rBK/272ty79Wmc6fRKsZ5VeJhMn6FjCCCyDghs5u2kl0kFoS5bQa0p5xKihUGA0j
	thGAJDOu9lgsAqMrLbrEsQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usmnamud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 15:15:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581DgGdf028910;
	Mon, 1 Sep 2025 15:15:03 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2078.outbound.protection.outlook.com [40.107.100.78])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqr88nd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 15:15:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S+0SHjHa+FQVgm7jgSyxualsogds6jOArewFpW09RVmwraNcHfSnf71fMCk4wofkfiEly8jcFNKSD4B8EsCCuTCPrCoEde8Uw+JKNHPdROVt/qZuwi+ZIdOA1hezStA8RqN7zJkffBIoL6Gqnusq+O1hd6lndDv4uAXL4W89JdnluxFWO46Z+MFMsHuzFW+SmSraJ+ljJInnBkMCEeAo0W9dbtq9zbchfxO9D31trPkaSWOohupiiKWFkgRLYD7mL3r9I5TaZ8p8uUtYdjealaNBNvkhqKDDnAszg+Jrc38uL0mJHxzZjRTF9Eal28uEqz0AAQ6rtuDr6KMEwHeKNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VmmkZHzWr1BGTeCbr/N9dfadXqgrYClCXaTmSE/Klxs=;
 b=Al1y/xYqxOGrDnSzAE9x3iB1WZYGUvRNdTfsIdeUHr3Gj/Ll8zswP/K4VVC9gr2AqbLl7TbSxQXXVQ1XPztd3qvicfZ3VjxppT1ZkPPNRqDn+YVZRn2TiBtelJT9PpwlRtrccb2CMXNUEk6QyyLfxD78yI34NTO3LfGPs1nlcyy7q04JK36ycoKbrNWytw5Trk5rHBS4WaLiWTJVszdTRz74UQQ8CCRaIvDx9k4kHy2du6ctP3V18E5NRbJCFmJhOZLWkSyJCS5Nt5HDw4rhl0fXHdqUTEx+w7/A/27WFB8zLQLL1eTwqOOLObOvpvQZuCFnNKVfrUtDeD25L+92LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VmmkZHzWr1BGTeCbr/N9dfadXqgrYClCXaTmSE/Klxs=;
 b=FLSDyj6KgJ0NTs5KXGK+nGxiR99JaqsgTdwmM9warPQ3nHDx6dgGPljgFKhHT+zOc+MkBoh9jTgyHsJavKCbw8qHK+1/OsM89iGTZgG/0HiXIagvG5adJ/tStwXO0/Iv7UwIPpuQhz8rh8nDHGAVOA1v4IaDyaBqxbMk+aBqD0U=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Mon, 1 Sep
 2025 15:15:00 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 15:15:00 +0000
Date: Mon, 1 Sep 2025 16:14:58 +0100
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
Subject: Re: [PATCH v5 02/12] mm: constify pagemap related test functions for
 improved const-correctness
Message-ID: <8e3f20bf-eda7-496c-9fb2-60f5f940af22@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-3-max.kellermann@ionos.com>
 <26cb47bb-df98-4bda-a101-3c27298e4452@lucifer.local>
 <CAKPOu+_aj3wA14VaZo8_k+ukw0OafsSz_Bxa120SQbYi4SqR7g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAKPOu+_aj3wA14VaZo8_k+ukw0OafsSz_Bxa120SQbYi4SqR7g@mail.gmail.com>
X-ClientProxiedBy: GV3P280CA0034.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:9::31) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ea331f1-9de0-4c43-1daa-08dde96a51be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QWM1NDVVdm5MdHBtNjE2MTBVTkZ3TXJjRks5RVJOS2V4cDRzd0NSNVdScmgv?=
 =?utf-8?B?eFlsbjRFMmFWc3djNmFrd1JGcFJTaVJSNitSOVlMUjFnN1M5clhmMkhsb2Ji?=
 =?utf-8?B?K3lrd3ErcDZWWGVZdzM4djJWbkxHcmE5M1d6WUlKc0pzNUtDTHVSZXJ3Tmhj?=
 =?utf-8?B?K2s5RWM5UjRJcFd4QVdwMGk2eTA1eUJrTk5ML25keSt3ZndLUlpzM1pKNnJS?=
 =?utf-8?B?eGl2NFdYdHNvcXFDSXFFWXFERktjVFltRG1nOTRrb2hqWThPeFNpOTBNSlk1?=
 =?utf-8?B?QzBLU01JWTlVcUx5VkJFSURwMERpNGpUTGRqb3pTOS9HRG9KMU1CMnVlZlp1?=
 =?utf-8?B?dnpScWJTRFJwMFA0Tnc2OXdpelZBM1VpSUhLVjc2RjBCQjlrd0xQMEZ3eWwz?=
 =?utf-8?B?MUhBQ3hOUmYzc00rdW9DNklaZlgwRVI0S2kwb2xBNERjMUk4VUlaeVVGdzds?=
 =?utf-8?B?Y3c3RXg4WUt1Y0xEVWZDNytocWZWU3BPbU9kZ3ZWNVNXV1o2blkrVG9Tc0VK?=
 =?utf-8?B?bWhhZXJtUG5TeEhSUnlFOW1jOHpQQkwvRUk5Z29PV0xXaHJmVWp1WFcrOFZP?=
 =?utf-8?B?NjVoamVVNlVpLzZzRmFPbEJTUVNFY3duZGNGN2tvSzFkaitxaWNkazFNQUps?=
 =?utf-8?B?MitwcFBOZHNlaGRWL0FQVmFLUzJIYlcvL3ZTemh3aU9KdVBneGhtYnhicVVs?=
 =?utf-8?B?ZmorQUs2KzFuSHJBVXBtT3EwN2lXemxuRnVBVVBxZnZJdkZRRE5QMjA2MFd6?=
 =?utf-8?B?WVo4bjd6VXVNVHFjVy9LbnB3S3A4Y3BqK1RKK2JEVGZ3dmpWaDI4ajlreWQ4?=
 =?utf-8?B?V285SGxZU1FmRnU3bi9NRXZURm9FZnRQS0FXL0plby9wWWdMUk9xL1NVeU95?=
 =?utf-8?B?QngrYmU2OW9lM3JJUHFLOXlwYzRDSkhWR2piemh3b3AreDcxTXJFZzArWFIz?=
 =?utf-8?B?MldLTlFvcDNPbkEzdXgwczA1SllaQ3FMbUVTYkVUWDlkS04rMlRjYlN5QWsz?=
 =?utf-8?B?ekxXRjdVK24rdzVIUUtyeGNxdndRbmRrUUp6QVI4cVRuTmtRV1BiNHU4QWtL?=
 =?utf-8?B?RFpuelArcnlYVkJzMmVXdGpEOHBDbS84MmFLd3ZoblZhVktaMnl6eVh3N1No?=
 =?utf-8?B?YklXdEl5UUgrQWlVTGxMZlZoV0crMVBiRVdWVlpJYkJCbFZQVjhZRFNvVUJL?=
 =?utf-8?B?YVgvdHNpaEdPUHpJMXgrazJ6QlQ3VVpjaUYwYVNMVXBrTjd3WC8vck55alVL?=
 =?utf-8?B?Y2h0OERIWVEwY3dNUUkzV3FuT1J6UmZwQlhLcjJhOWloVjJkQ284QmJSY3lq?=
 =?utf-8?B?VDRNelIxZE9uV1ZoTWdlUTR1U1lnMUVXSm5FUjRVUmw3RkFNNTB3NjdhcmhU?=
 =?utf-8?B?aXk1bno5VkFEdEJSSE1ocStzUmIweTBTbkU3K2NPcjAxWDZQVmRmSkdnSlZq?=
 =?utf-8?B?QTIrVTFYSllLcjM0L2E1MURpOTB0Yy9PY05hTjE0akMzTC9BUjB5eVc3Tm9p?=
 =?utf-8?B?Y05FR2dBMVBkL0sydDk5SXpEaHh5blRSaG5LMlhhakpOSi81aG1mTXBHZ0Ju?=
 =?utf-8?B?L21HMDNlM2tDYld5WGh3ZFpHZVZFWmpTdG5rUGxCWVVCY2JnTU1IblVVRjg4?=
 =?utf-8?B?SHF0YjNHRVJNZlRtZFZoVXFsOFJwdWY4TjZnSUdYczR0UGNBSENmR3ZOb3ZR?=
 =?utf-8?B?ZGJyZGNWMUMzU21UOTdzUFdvMmN1Sm5oamlOMFJmSHAvUW12QjRwZTFKYUNG?=
 =?utf-8?B?NmNCTm1XeFVZRUVsYUd1S0pqUFJVSktxcmYycjV4KzdzSmw2Y1I5SWZwck9I?=
 =?utf-8?B?NEt5TDhPRkZEdmNkUzR6V0lxS0pRbkFEMU9BZk1WVmlyYitFRE9jakNFUUti?=
 =?utf-8?B?Q0VoUE5oUXk2SWlXbFFwamlZZjF4cU90V1lBMDFFNlIxYWl1VFFtdUVRVHJq?=
 =?utf-8?Q?Dt4UYe/h3k8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TG50ckprNmNaSTNueWk3Uk5wUDE0NHliWjI2alVlK2R4am93SDFhOWpJZ2lG?=
 =?utf-8?B?bjJJN1lkeDZOc0RNa2V2NmlBbU8vb3lEUm1uOTBmTzR6QTlaZERJVXVpeVpJ?=
 =?utf-8?B?K0haZWZUMFI5OEJTSGUyQk0zSnlhUHRHS1hLZ3V5RkJPblZXeHRScVllOUpz?=
 =?utf-8?B?QU1RUkZ4YWVrOGlGWHM0aUlYTVJtWVJ1SkREenA0THZuQzQ4dU1GL1E5cm8x?=
 =?utf-8?B?NWt2STlpUUtEcEJVd2NEaTRuaUJmdDN2SUlRajJLS0c2MWNVam01SEFTb2py?=
 =?utf-8?B?YVZuRzYwbFord3lIYXZiSEpON3dpVmN1QnhFK3JqeFR1bGF4MXVWWlcrNHRY?=
 =?utf-8?B?RjJqVFI0Yld3dkdVZ0pXRVVKTzZVZFNIQ0dVRmswQTFtOUplNU96TzlYTldT?=
 =?utf-8?B?Rjk1bVBUT1FhR1FDN21BWWx0eDFHQ2F5SFVhSDhqcG91VGZ6WDJrRkZlZnVQ?=
 =?utf-8?B?aE5YVHdTSVoyY1QwMGFaQmh6eHZqMFFETVJRMlE4RnN5S3ZLU25jQUQ5b2Vz?=
 =?utf-8?B?dTBUdlBVekNOd2w2U2JqaGZxdlpyZmh1WWFUSk1TUTdFZ3hyWVBNSE1GSFZa?=
 =?utf-8?B?ZUY5Y0JITUt4RHhHK0FKZ0tQNnRrVGs0ZXpRT0F5SXhhT3U3Z1pIYVFUcWtu?=
 =?utf-8?B?MFc3cnMrd25oWkhBN3g5SUZ6RVNGZDFQcDlMSitMTGhBRms3K1pDVy8wWUs1?=
 =?utf-8?B?VHJsUGVoNk52dHl1aU1WNmZlVEFFb0NZRGVybG50d0FtbXlXTG5PVzF4ZFBC?=
 =?utf-8?B?eGpJcG1PT012TkltOWNmWVkzaWRnR2QveWpMeURWeW5DeDJmMGpwQ0ZwYWRm?=
 =?utf-8?B?ZjZCczF4MGZmVW11NFB4amMwWE1DNU05UWV3NXNaaUFlZ2JXWlRUdllsd096?=
 =?utf-8?B?MWZrcXVNNVZjZVhhbUNPaEZsQW5aYndhS2U5aC8zU0d6TE1wamRRSFZDN3lz?=
 =?utf-8?B?emdyWWVIQXNSaDF4Rmp6dGhQODFTV0pIa0dIc3dTVEV4K1FuenlpZDJKSUlq?=
 =?utf-8?B?cXR0YmxpM2dud3R3TnhJd0I3Y0FOSTFXOEZEMUZDK2czS2VtQjE1YUoxR1pT?=
 =?utf-8?B?LzBpQU5aM1BoVjNFUi85RWM5ZVordEU2d3VyUU9HRUsyM2VTd0JDSzcrWm5l?=
 =?utf-8?B?SVRXaEh2MnYvS01wdU1NK2dPdW9Rd1dreXFJRUJ5MmdEelRuMzNKaGpxOVJG?=
 =?utf-8?B?OHh4cnpPcG5WVGd1WDhMT05wbTR6MURRcDd6eVNDRmJwSkhGOUppcXJWd3VI?=
 =?utf-8?B?czRqT3FzTkJWSHFaYXhBT2JaRXBIcjRJV1RaQjRDV282Q2JUTC9lRzRTNk9D?=
 =?utf-8?B?bnZsaEhmUWVRcHRXQnVMUHh6d0szMDN0b0ZKZWJOY0tMbXdZb1ZnRXYzTURm?=
 =?utf-8?B?QlMydWI2amFmbk5zSzMvdmlqdXZXeWRRWUIvc2dSdUtPdVpEZjlPSUNTaWUr?=
 =?utf-8?B?YmJpaFU4elV3THVSbUhlWWJENmI1aTRxbFRSanoxaVpqbDJQaE01SWtiUHA0?=
 =?utf-8?B?WjdnbVZVMTVoSjdKUy9VeUdBK3NvaS9QQkJTUUMwV0lxbU90RmZiTDNVSGd4?=
 =?utf-8?B?NWg4a1RtRDlDL1dqS2tpSUdKb3dQTGxvU2M5MEZjTzVVNk1IRzVpS1NwaS9N?=
 =?utf-8?B?OUJ5SjBrcmRZTVplcUpCM3BOYjkvcmVLUCtwUVlHZFo5VGg4NWRqb0xkK2Ru?=
 =?utf-8?B?aDVqQ1BzSWhuYmlzcHd2d3NlU2FBNmFQd1lNNmxuMDh6bWlSVm1ranRwMDBP?=
 =?utf-8?B?Q3RHejlXU3BRMEVtUVp0SVFwYjAxb3FibFIxVjU1V1FBWXBZd1kzV2F2VWZa?=
 =?utf-8?B?NUJQOG13YzNLWWV2ZEx5UkxiRDY2M09WV3pIZEtiNXk3UHhScmFvSVJSSEph?=
 =?utf-8?B?eVZHai9ISERsMVFXODFvZDZQNld6alJwM05ZWlduMzIzUVFiMS9lcnVrS3dL?=
 =?utf-8?B?RkRmYVJHQVRNRExWOTduNHplaFJUOFVEWkF0US9QTFBPdFg2a25wbHl5cnBW?=
 =?utf-8?B?WGxYVFdXSkExNW14TEc3WkhVaVo0YXdmcW53L2dqRTNWeVd1SklHaFR4M0VH?=
 =?utf-8?B?dXRCcGpqNW5HWTRVd2kzNWE5SDBwMElURFFMZkIrOHNVYi9GOHJKZ3hyUmwv?=
 =?utf-8?B?WWRQenlGWWlsZVVkeThCbC96ZGU4MXgyMUZxQmxrQTVnQmFQaXArWHRIdUti?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZnUAE6Zo0mF2kSou9xjT8ch92aoxb21BD3tUl9/2pCFvYRAx4qCFFZTQjxV4F0WHqbl5cC1mQwDq2LResqVeEnYt0CqzPWIW0/AoYaelEMQQPCg/5J6J4DmgNSrPjBwP3hRWYP8KvklAMnqPS2YNUUiL7WgH36ZQRqmitkaOAehLwF63hdTGyxzw3UrQHzROfDA9ZDZVERg6WBazACiQ/mprrJPf60UciqL9ZL0w7tR0G+qVkm39zYMkk8TN7F6MSp1bGy5FDqPLFcLjWRyjnNN7MwWDrVaGa2MzM3gBgQ/NqKt1AC7pt95a/3uNRIIuIjLQCtkWcQkuImZpLNoIkG8ADMwpu6XfsQXFMUQI1Mg3Y1ZpH+YSIfBmxGZMtRimEReD6uL+Qzin4efP2rRJuBNfl1vZ5kSGUiXDi8KoukZMh/Sye9mJ9sciyFV6ey4bDm6grPhXPipumrIC+4CSEfPJ6LF6KgDpnAn/KC9vNupZePcsxgrSNTojMXOg7knumdytSmzNJBr2hVpzxNyUf/fjPnC+l1ZoNAt+JpfkveZiYJP8/LsC+/SnqmLFTr/eR8glh+UBk3YjQEbaWDcFaqn7Ei+/FpnpMxVetzGrWKE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ea331f1-9de0-4c43-1daa-08dde96a51be
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 15:15:00.4259
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zqcB7akHPZ+kEZ/KHjBQ2bazdhuhUxCIhTWcVrQoKtoMRH15irOIrvKVtJF47JPY89tbs0lB/j0AyMM2mhllaS33axw/cw5WE9Kz8EYi5mc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 spamscore=0 phishscore=0 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509010161
X-Proofpoint-GUID: YB8Chyfgewbb42LPXoZWnoXm7b8NaBQS
X-Proofpoint-ORIG-GUID: YB8Chyfgewbb42LPXoZWnoXm7b8NaBQS
X-Authority-Analysis: v=2.4 cv=Of2YDgTY c=1 sm=1 tr=0 ts=68b5b878 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=5PDlR58zHZYZN6OzIqMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13602
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMiBTYWx0ZWRfX77iFv3te+Jw2
 0MAAmrvBLO8tU1X02vJZM0c+rpCKnDuZFHgfUn3y7GbsOuFAwBPar4SMbGzV2XJ9kHYEfiu/6fn
 2onR0SvJmmMh2kusCZmB/DL4hL6Vl2/FzdBlm+mYC4fNLS7R4MrM/woPtQvBAp6Q86pr4AKfDva
 Tcecfheo9iQ8j1GXOJ66l7X9KDQ0b18SQd8+0MWWjgXJUExhLoktcSevoa2DehPZbphUbi53snO
 0EXEHH83Kn2YsHIBvF34cIcWqaq40tjv5gW+g0hclHG5Hhz7pzHoAmdF2iHOm7JyUOZPPgv35Co
 rxjNA9VXGnb/QoFc7hhmxCtp+WFAwGhMDYNTgHiBmMQxMKDS8aJ1UaesL9J8hH9o8vPakO2RE5Z
 fpZ5nSC/fnJKsGc2Un+g2bl7lPlAJA==

On Mon, Sep 01, 2025 at 04:50:50PM +0200, Max Kellermann wrote:
> On Mon, Sep 1, 2025 at 4:25 PM Lorenzo Stoakes
> <lorenzo.stoakes@oracle.com> wrote:
> > 1. (most useful) Const pointer (const <type> *<param>) means that the dereffed
> >    value is const, so *<param> = <val> or <param>-><field> = <val> are prohibited.
>
> Only this was what my initial patch was about.

Right agreed then.

>
> > 2. (less useful) We can't modify the actual pointer value either, so
> >    e.g. <param> = <new param> is prohibited.
>
> This wasn't my idea, it was Andrew Morton's idea, supported by Yuanchu Xie:
>  https://lore.kernel.org/lkml/CAJj2-QHVC0QW_4X95LLAnM=1g6apH==-OXZu65SVeBj0tSUcBg@mail.gmail.com/

Andrew said:

"Not that I'm suggesting that someone go in and make this change."

And Yuanchu said:

"Longer function readability would benefit from that, but it's IMO infeasible to
do so everywhere."

(he also mentions it'd be good if gcc could wran on it).

So this isn't quite true actually.

Let's please just drop this, sorry.

The noise for multiple const params is too much, we can do it on a case-by-case
basis going forward for larger functions.

> You know that because you participated in the discussion. In that

A point of advice given how this series has gone so far - please don't say
things like this :)

I have an extremely heavy review load, and often work 12 hour days. I don't
necessarily see everything though I try to.

I had missed this.

Just add a little civility and empathy it really helps, thanks.

> thread, nobody objected, so I took the time and adjusted all of my
> patches.
> There is some value, but of course it's very small.

Yeah sorry that you had extra work as a result.

But let's please drop this.

>
> Note that I added the value-level "const" only to the implementation,
> never to prototypes, because it would have no effect there.

Right.

Thanks, Lorenzo

