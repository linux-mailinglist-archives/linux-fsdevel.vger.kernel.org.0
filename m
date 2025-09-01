Return-Path: <linux-fsdevel+bounces-59873-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A855B3E7BF
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 16:49:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F21B83A5887
	for <lists+linux-fsdevel@lfdr.de>; Mon,  1 Sep 2025 14:48:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23540214210;
	Mon,  1 Sep 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="m5uBKnNA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t139Nu8J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C28021A83F9
	for <linux-fsdevel@vger.kernel.org>; Mon,  1 Sep 2025 14:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756738110; cv=fail; b=J5p5TEwP3xnfcBUSAw2Yb72zqZyJU3c3ABOIClZYQSey0BXy0ZFM0iNni+n2tEm756Ainr2M1ex3NXgCzgQrfuODnHA+jZQJ2cN5fkCalpTSXEzA83X+ck/cwcJDRgqpSj2o0BE1QaOf48rR/4nm1iB++SGukFpQbXWDMtQdYYY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756738110; c=relaxed/simple;
	bh=YAF23vIsR1RBVIp0NuFvqBDQT6hP8KcJXOjS/o9m8X8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=u3i+ZkORSvz3vIjEeTRJ36DK0KIj4ZDGfPQEIrhXV1SlsGVfEUQb3MJqUYfIAX/gynHhNRuIp/G/UKmpNsG3VnthjBSXTEq7l0cblQO8uBEPNbeeGFc9ZMprC35ZBv1ywtHX36exI/2PwIzb8jXXZY3MtFgyeoEpCf2N2Jddb+c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=m5uBKnNA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t139Nu8J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5815fnv0018250;
	Mon, 1 Sep 2025 14:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ilWWQc6WyCcSAe9T+u
	WygMqe1L/9zr8YKRUNIh5dQJg=; b=m5uBKnNAJS+PcFVGgQfGYK/PgB134IsvWZ
	XWKjWoAXQSu9TbIErJ3e5UEyHXMpgDRNPqHEg9iwjpmRmEpUn30Ai8vc9m4QvtH2
	2oqKaH7kM0rjQuyKjtl9322TtZqMVghLO8nacDvRl3IUq1Ax3OXFBzj96+54CIN6
	+ghHqe4x36yVA/u+nCY1VEqPBeHGPDXFm1VHjXJhnrl8cT79tdvaNF9WwRJmNruc
	qSM+Q6zgmLpf/YjjPL9ARWmHwag/OjOiVV6eIrspg+OgdGmr3KJho+km3rt2MV09
	dneLwrVjXbtIzxTHHuSmJe00gFXqojhltLOPCIL9g4u1GLr7bSRA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48usm9jmaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:48:25 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 581E0J7B011665;
	Mon, 1 Sep 2025 14:48:24 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010046.outbound.protection.outlook.com [52.101.201.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqre8006-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 01 Sep 2025 14:48:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atrqN6bBafP5ELBffgJps/4uV59QDlwKrhloKf8tQUr+Xkb3IfNSwbHpJBxM8iWp1/bmuUbUscL3Rr3ejrJ6kSbast1JO5JUb/VmnnynXi7Ep8hY3dVL40Tu7e2Jwqsq5MfGVwSgTJUjHSF9B70N0PqVSE2CsheylHDjQTxbD4GF2p2o6FNMKXOZf4FSEbf3rMzG6CBRifMxjAa6aaRMzvBi3prysoy8WksrxBGmgNklZEp9/eY1h6cQw+5p7LQ0+xyWsE16H7eilK7Vl7BREDa4Ai102UekTK30j17lxcapuDuLh94B/kFZ1ASaCZbw7WZ2ki5kvPh/bF3sHi6Hbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ilWWQc6WyCcSAe9T+uWygMqe1L/9zr8YKRUNIh5dQJg=;
 b=ZAhdXd2QeinyXu779wvFVghVZqEjaI6vMEdeERYdSmUx8wFpceFGK5zwMb154EZb/sPBe9t1PxYzYEv/nDuj6Xly5Z/IlC8YL++M6OWNGLXqx8UCeSh4wSi8HIjfQOhTleSjG3v6AMtzCdyX2526qW8++pceEWAbg4WDYItWt06nREYHzsruMKNB+SZLDYW70zpOfGF9IAbP9PNmGz2u31fMuuBlWAEq7k4Uq1TbGdcK3r5EK76vjzSSScjc1KemsMzaJAI9xSiSOYwEQqBP7jM3cI7ZIKdbpqDq1e5ZSUlHnF4XblxbrD7w8ZKK5rUU84Ug7B+Ewb083k2EMMvzLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilWWQc6WyCcSAe9T+uWygMqe1L/9zr8YKRUNIh5dQJg=;
 b=t139Nu8JBozTIFqC3moXWq6waswQcFS7b9cwrmnbqUJ2lDWE9h6NUzzqMHJDXieF8f8hu4OfY4YjdHzwDlTkl6JCBkPLJ2xvMPTB+xyNQs9VLUsVsCoS3BlGsgT2v8l5CFCnrm2lNf9M6S4kEKG67eS21YhflGR5d/VSQ85d21c=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by IA4PR10MB8709.namprd10.prod.outlook.com (2603:10b6:208:56d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.22; Mon, 1 Sep
 2025 14:48:08 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 14:48:08 +0000
Date: Mon, 1 Sep 2025 15:48:05 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Max Kellermann <max.kellermann@ionos.com>, akpm@linux-foundation.org,
        axelrasmussen@google.com, yuanchu@google.com, willy@infradead.org,
        hughd@google.com, mhocko@suse.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Liam.Howlett@oracle.com, vbabka@suse.cz,
        rppt@kernel.org, surenb@google.com, vishal.moola@gmail.com,
        linux@armlinux.org.uk, James.Bottomley@hansenpartnership.com,
        deller@gmx.de, agordeev@linux.ibm.com, gerald.schaefer@linux.ibm.com,
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
Subject: Re: [PATCH v5 07/12] parisc: constify mmap_upper_limit() parameter
 for improved const-correctness
Message-ID: <1c279446-23f9-46a4-bec2-6390c212dff7@lucifer.local>
References: <20250901123028.3383461-1-max.kellermann@ionos.com>
 <20250901123028.3383461-8-max.kellermann@ionos.com>
 <e695b279-0540-494c-99a8-987179979d58@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e695b279-0540-494c-99a8-987179979d58@redhat.com>
X-ClientProxiedBy: GVX0EPF00011B5D.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:8:0:15) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|IA4PR10MB8709:EE_
X-MS-Office365-Filtering-Correlation-Id: 944c4ab3-2dac-4e3b-1436-08dde96690cd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?00XxB/O3P3/YBkXBN9y0KqH+9jHZbf1l8qVVxR5XGt0vMVduDvWc5mms7zXw?=
 =?us-ascii?Q?TziTPWw7SjipMyZqoVg7O6vpectTMrOiJ6mWbmT+PfQ37Pb7ZKgUMdffC7i8?=
 =?us-ascii?Q?XKQFYz3oJqJxSgwpL9XMU32FXJ5gG0Pt8slBk2rbYyDQpfPgfkMBbwo29Kop?=
 =?us-ascii?Q?CxtXhtPkkNMzCFuIrW0ps2BUcOadJwDPZbjAw18XvwUqThWJfPk5O5Hn2uNP?=
 =?us-ascii?Q?llk2N3N8NdlNTn3pp5kbVAtWJyNItpOi6ACwB+PYg/F7uVyL9PwvPiIQC3mI?=
 =?us-ascii?Q?4KlT3yDlba3Fbu1xty+GdFJ4DORb8oyL9JU+BcAX48qQLF2iFiGNlVfMvstj?=
 =?us-ascii?Q?CdPiwCRtN1va03H0gT1hjv5itdS/Sr2ez6K8MKLeaz5H4s1HWtqaZlramCOD?=
 =?us-ascii?Q?IXW17/bv+4FK1HUOdNk7fbekqOC+jNaPdE9diw8+danXalvolfSQPlBjdmy1?=
 =?us-ascii?Q?NJhp4BiCxiBOiRbyGrQQk308BvD7NngusPgG7X1gNcNPrKM4Kzvvw9RuY3Yz?=
 =?us-ascii?Q?IiV0ap91+S6kQq85NNsnNFc9hyJnay+xaZy2DdAnXIAaQSIX6GKg20Th4wBm?=
 =?us-ascii?Q?afZ8nRLPF7nPuZq+Dn11k0LqlFO6FDQ6qrI2K4AF9ItK7J4tB2QYJ6xNKMt2?=
 =?us-ascii?Q?ZdnhpA9HjUwHZenA0IWJpwIZDze47x8TIDiW44C9CrUSmT2W3nY7P3lCTSYT?=
 =?us-ascii?Q?cktc1eOXMqZmnIy4wrdhumypYVDxSpwuLd4a3pbYUUD0i4PkvIKrWNEKAdYZ?=
 =?us-ascii?Q?mpYWTlhd6qprTN/b6tKhscHrB1YND56mr0WTaNaGZXNW+WCIed1Tq8h1qOPc?=
 =?us-ascii?Q?tnvTn3QLyafRxWjTMv+HJwBoCysXYag39IEzU0o7dIxd0WomyQHdIeeLl7o5?=
 =?us-ascii?Q?Gz0ydOWuCf94e2xh5Oq8Lae9Gth0qMoqUTqBx5E2zKw4DuYChgCI67TCV+wV?=
 =?us-ascii?Q?D/lkIv1DkE++ImTReKwPvb1auuTLVD5s9vbsADesUI6hHl3Dvl9ELAaq+9iK?=
 =?us-ascii?Q?mgQfcOOdgZiWzfbRbyVonHLadsvR/A++o9ENPV17zKxy3x18TCC2SnilX2Py?=
 =?us-ascii?Q?joSwP/ZysUtYRdw2IbLj/vePvODZHXUwY0fPxQa5E1X2AG5Nkb1i0yrLC6wA?=
 =?us-ascii?Q?KIBelm6eYwgo9+kf6qgY0ZupmZXbBMa08Iwt6mAS9Wt6ERJCs98+p5yHK22X?=
 =?us-ascii?Q?zuAh7LcOXai95cwjzgWKgkRM8+pv18Kk2rgsf7rZgdvLSSpiqk9/RQ4cmH+b?=
 =?us-ascii?Q?GubZK3h25BQbwro9HrwNxdnNxxyvvjdLSi+V0YLY0vgJG/YnVhhB+/4bnJ3s?=
 =?us-ascii?Q?Y7rTvH24lsCs+f3QgTXC6RNfF2Gflcg6NqZaSsjZwSCmmRkoNnZxWafu332A?=
 =?us-ascii?Q?HPksFFQQveMHCQkc/qSuxHM0ARGz7cE9JkkHmre9qOYNtSgYKUkKDZkPkpP9?=
 =?us-ascii?Q?24FcxAEITZw=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jw+U0Y0i+tcu8H8hz1vyMsgW91lz2c5NOkK+biWNqIJIwihnPzIku1kcuzgg?=
 =?us-ascii?Q?wOuAvSXVMF6OjnDc6IQ3K1KErecBFuEidEIUn5ask7o2xpTRxinqzj7EHtV7?=
 =?us-ascii?Q?CfTsf3/OaenTX0msvrQdQbP4Gr0CbjB1hWwgoCz6YAbFkT0aOHLda8FqOqzL?=
 =?us-ascii?Q?p5UDgqRVOstwlU1zjd3xMsZnrTa2m97UOfqDgAi3cTODGb32YlKv9YTd8YsT?=
 =?us-ascii?Q?LvhLBG+nm2ivZABtx9PiSHmqPHfgd6AOf5xIhJsVkQq1h8m7XTad7nt9Ff+x?=
 =?us-ascii?Q?zQKohND66onJ4eizCxyCSbZdL8nsDeeOFGMnZXzF+V8bLrYgVVYaBKgjJ7jR?=
 =?us-ascii?Q?vFNzrRAdrrCD0eSGxV00R5AUc9SJqD9AY/sojQyj5FyVvHT8xt7u2xYNFEy7?=
 =?us-ascii?Q?32TRG2NjoNPPPT8cH0MI/ikB/1DzKc6zI+ZYQiRjuxBiSYm/zCL1wtiWRUZ5?=
 =?us-ascii?Q?PqbrZkfaclAmB7+I4a12iS+NWOGHmbO8bwNEMh9IAGMarNzn4DWzAoruv6ub?=
 =?us-ascii?Q?H9XPBw6cf7JdzkZdX/iIteJbqHfhPGjSBBdum1SH5zw/d6FmBHJHwbnWJuNY?=
 =?us-ascii?Q?+6qZk2glpy6uOteBX0uB0JvaAfa+q8aCMuS402I4p7RcydNa+2M2XaN5iyM5?=
 =?us-ascii?Q?xV6X179LOo99Ujl3hv3GugyhU/j7nt7u9ZJK9bVy7DkqcVIyteE/mAAurrdn?=
 =?us-ascii?Q?ZKYhf19LhQufVR7jPGcKK2tbSrjnsv8Sun4YsJ/XJe/9WhwA8/j2MU5q3sel?=
 =?us-ascii?Q?DeONdH9w+B+1NDY+LBZ9exz8kHGeMckJTCc27yFMplIcbkMK87WL6+6YcJ4B?=
 =?us-ascii?Q?jukqEY4nlH6WwL2+BkXm9rYxRxfkzAD4W/3PjGnZ3wtLV9Vx2efF/3fd8Jqc?=
 =?us-ascii?Q?W6KmguIpOwhD64FvXfT7podwWpHFDnLFHfjx6TBBwJzzZrlaSQTdY3zi1jTy?=
 =?us-ascii?Q?Nb3J9kTumjki6XcKuUEE/8tHvMztVljC0TDJtLwRkmLENTDxcNV//E6AILqb?=
 =?us-ascii?Q?Cuv0vncAZqY4x29pHHUIW4ehnCu3eX6L9uTe0oCMNkJjjhfQOgQP6tQMEhtk?=
 =?us-ascii?Q?iS1v05H9oC4vKXJy7uM5W0BNxPDk1L5tpQHper14JdHRRpJuSTMLPihYG32D?=
 =?us-ascii?Q?1tdiMdpA5URwdODzecCM9Hc1Zeh4E23CUNCyM/xoYgYuAVbVPH/Kl07SyT5s?=
 =?us-ascii?Q?hqlzCR3EJOWW19CvFakwbX2CdDYaHDtbbwrPImQlK7nN71bK4nsB4OgYYqA6?=
 =?us-ascii?Q?96TonD0rozSP9sRVeoyIDUCS8nU9puyP4HQ+fq3V9Cz9MdMcqmA2Ra9Qzg5Y?=
 =?us-ascii?Q?r1ri+HVcywzGoHaMLRQN6j3WbWQbwsk4Qo/z8Jf8hgxBmjAvzWEcFDCTZ5uq?=
 =?us-ascii?Q?sjYvx3WrNWCdshaDce/WS31ZEp26Rc0grUso0IkYYUZDOsQ140ZPPWrKtH+k?=
 =?us-ascii?Q?yW+c+IpfUbyHwekcvAoKMLrujDZ0qrFzjqg/fVsHI3qME2zwbtyTZtuegsTv?=
 =?us-ascii?Q?ugaam8/Zm1RpMTeZQfZW1fPvDU9S8CHNnXrrMKBpEJEd/kKIrW4uGvQViBtz?=
 =?us-ascii?Q?qOZjggp99wIs6zpRoZmpTErWmP3w1v11Hn9HkKy4k1CIj1fVMPKwxH00adPA?=
 =?us-ascii?Q?cw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OVVhT+3ulGPc6kshG4U1tSLqtANXh/aCnenfDwVyMrahHnGXen63TrCFSDZoEFoSyUIojmA6f5wPjJmtEtvw6xW8kah52yxE0HatdknHVsnDdC+h6Hoss7qoW15Y7n9LlWs2xSiDZK1oXjtKrkOh7RumRkN8jfOxzoATbYTcT7W8JFp3UOkq0qSPSgPYRkBlF0RrX7W3dr7VJjE1V8FLJPXOIBWlPMH1BrQ+6u1eIoSq49BjEOZGY7LcvRwdO9GrUuPJgahwUxyv+JFJ9DYBILz36PzwfYRwO9qXvYjyNJotwtdDg4FYMld+9x5ZjArsn6WP4ZvbzD5nNAmbIbpixNMI/4fQg+OFAPim+DQ3hxUZO3n1Z0f4NTIDZJTHSYx1dloSq6IFApCF+laXvQvocmms968OJSB5AJS9iYeAwB1WLgUCGcvBUHXnfN97mGR77Slz6m1By9F5MtYy63u8ZuKeGEG4GL2TWr5Qz/kYmOio+htCLZ3vm9brMO8Iq8yB5qgxFZcmSVKnGP9OGPojt5T3J4mejeOzyn78GogFj9AH6KRE9UF6m/zsskYjWnXjKv0OwtVZ6B9qjJocXoC2V08GeVPe3CKayKTTjNT9JGU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 944c4ab3-2dac-4e3b-1436-08dde96690cd
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 14:48:08.2369
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7IzpmJjmpCgVk8121gZPdayQPMHPqlfo6+5k7qXwf/0KfjDhxcomsIBR+1Ol4ah1X7jKXm7WMW1lfBfvW38JE0FNxQBLYeShvLyiwi8nzWk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-01_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=974 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509010157
X-Proofpoint-GUID: YwaEFYDnaK1fNwzqqgvwTZlBm9j4H8XX
X-Authority-Analysis: v=2.4 cv=I7xlRMgg c=1 sm=1 tr=0 ts=68b5b239 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=UgJECxHJAAAA:8 a=pGLkceISAAAA:8
 a=sXzRxonBVRT1uE2SJDYA:9 a=CjuIK1q_8ugA:10 a=-El7cUbtino8hM1DCn8D:22 cc=ntf
 awl=host:12068
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMSBTYWx0ZWRfX9iq/djloRt/W
 yNi1paZHkZbCHgc/ZRDI/kJMD2ts6HPj9IqjYZtdTIxfdTvET3Xs+/zix85++E0UVkBoVMq9+LW
 nqpRlBod3lEvuq6WZpya56JRNEHcTWz+vQGZ7r0ejeJVSiIfzHFqKrvYhwxPB2EyQxlqgs7W5+C
 3ZrUXc3KAVQNbaGj3CV/5n71NJ5kn5UFXUkaNOSGjlYQ4VML2kKN9ClWTdPbq90MaZa6LXqnyy/
 Qm2qpvMQJEwTz5+74ybAHN8NKjo8VU+pB1FBCsuWDZhVCxN3FcqP97mUZ6dqysMNxwQ/pQG1azo
 5izzG6ffkdV7TO5DONFFuWKx9TyuEeVIeKdkPLuOGqU3oUpprXyTywXYHL3Axs21gNCnqqM/7eR
 V0Z5gpTyZDhJZ4JL5YQKArcz4tbK5w==
X-Proofpoint-ORIG-GUID: YwaEFYDnaK1fNwzqqgvwTZlBm9j4H8XX

On Mon, Sep 01, 2025 at 03:55:00PM +0200, David Hildenbrand wrote:
> On 01.09.25 14:30, Max Kellermann wrote:
> > This piece is necessary to make the `rlim_stack` parameter to
> > mmap_base() const.
> >
> > Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
> > Reviewed-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> > ---
> >   arch/parisc/include/asm/processor.h | 2 +-
> >   arch/parisc/kernel/sys_parisc.c     | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/parisc/include/asm/processor.h b/arch/parisc/include/asm/processor.h
> > index 4c14bde39aac..dd0b5e199559 100644
> > --- a/arch/parisc/include/asm/processor.h
> > +++ b/arch/parisc/include/asm/processor.h
> > @@ -48,7 +48,7 @@
> >   #ifndef __ASSEMBLER__
> >   struct rlimit;
> > -unsigned long mmap_upper_limit(struct rlimit *rlim_stack);
> > +unsigned long mmap_upper_limit(const struct rlimit *rlim_stack);
> >   unsigned long calc_max_stack_size(unsigned long stack_max);
>
> *const like in the other case?

Ditto :>)

>
> --
> Cheers
>
> David / dhildenb
>

