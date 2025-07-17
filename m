Return-Path: <linux-fsdevel+bounces-55273-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 63883B09263
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 18:58:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03C4D1C45B1C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Jul 2025 16:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3053A2FCFFB;
	Thu, 17 Jul 2025 16:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pKW+bsuC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZQWL6yGm"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E522FE36F;
	Thu, 17 Jul 2025 16:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752771454; cv=fail; b=RjBCAq+SYX8wU64E313eT0MrfV0wUwtZWeBlLBMKDLg9+kBTmJVM4qg14iBCJcr1J1CqM6O5ZZypAR11PtLe0GIiPrmasUQdRK26wHq2JInD7twTN18bFS23N2qE0UTwl0bSl3RqxAji1LqREf+1g9M/dvh1iZeKQLDPyg/3ZXQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752771454; c=relaxed/simple;
	bh=qCep204zmBVCCIP/5AfSh9GQcL+Zn/7pBtr+LD7pSAw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=IezLJ/jP+N1sAMIcvhS0FwYBof6GabL0outmEcbzqDQTqX8xBtRbp4jqrNH4cmc2D7r744rMQ4EmNuYaOHLpAQ3N6CSOFFPowKKQKuwEliJzJDfGmGsJdw7uPlMyd591TwQACgk97+Jt++Ok7zb43NV7BiLHQw78KyDsfazXR6o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pKW+bsuC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZQWL6yGm; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56HGBxMn001337;
	Thu, 17 Jul 2025 16:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=oJ02dd50x8VP7VKdvyP+45azUpfpgVwNcuOwMYqGXk0=; b=
	pKW+bsuCZZ8pQZU0N8gA3gG7rYUNXFCaPNJ6mabdELIJBbN14PwWLhE9cH1/wB0r
	1DvszBUjEUgUgbTRfpQDrfngn2a0ZMb0fdEUGxIZrvTafQtKiDesWSFkGsDahta6
	8ixkq977vWJwHwTi7vv7WPgIHZgZ7iOmzVMe2qpJARPPaewLB4k382adE6ffIWTb
	2NGFEnjDQ5NUpvw063WJJhhulcmOil943LLKLPMAGyHMSF6usEAr0rYpF1HLYiy/
	PqQUz25kclSkQnkKRRNOq3l85wGEUGmeSPsgOkM+2UoC6xgss5I9v+8Rxrptqbkj
	yk8tI7K74dlCBGDWFq2YfQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47uhjfc4ey-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:19 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56HG2Vrr023735;
	Thu, 17 Jul 2025 16:56:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12on2060.outbound.protection.outlook.com [40.107.244.60])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ue5cxym4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 16:56:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GQboV6a1EeIEWqjZb3hn4tqORQe+lVaDpr6eNcrIPuq9M+AT4G/pR9BoFY4Ya7c097olcvdUjJEJQtG37x70rlWwZbbhLKs/bugMiiui02YGt8Sp+z3PhGXGXNSKlV8vb65IVK72u+m03cN1NsuvURbwENJs5lZR7hwr4h8rhNgpkOBYlAK8Qt/wOvBMrCN6gThE0tzKFpOmSDGjr34O+1oLktLbgAcHa36TinNs+s1V56skpvqkkXYUj4V/mlx86XaxHJV6XD3iTUuhS5ojaLb9zV1V36Jrz/UO127lnceNcbHxSKIbv5e22GdPjiXA8CbuOMTBJ5dDC32TOpKcng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oJ02dd50x8VP7VKdvyP+45azUpfpgVwNcuOwMYqGXk0=;
 b=rJA00ej2uDuV7nja3lIVZLhN/MkU0GBt8QY1LDYsNRqcFJXQ9uKQ0rh5L3ZkcbmB0/Qz9vBQ3ytxFpXJKmc8CZwmvddByMg/AbVxIRJZsVLjI0//LOXTjNGgjPji1KWLNrGMF9cZdBRiDeLQyB2REggoLrYzBEI9retS0tOzd9ouPLu58I+OoJj5y8vdqzLvpcXBBZeNBHcfduWEpezmn6wd0H+tIqQmfEZ1YZIQShLEGQTldYVeXyQPUFnUUD/ArGaPNPbeRa9fpMqH+iR+2Vf9euBHLPR/jfAkIvQ8Jup8BqDv+xURxbsVm4fw3qdwW8fEOIn+t7bkTYjzRBaCUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oJ02dd50x8VP7VKdvyP+45azUpfpgVwNcuOwMYqGXk0=;
 b=ZQWL6yGmZfQTzy7itBUCH7ekJaKWV849i12HYfaM8TKSPmSHgb/nm2al4M6Ov6dJ9U8N3D2Ou745wgA+natRDLSBULOJ0hV67zflD06VsNJgd4fTegYNFu6kn+X0jLyPd4gdAsoxMssoxOlNt0XLqSZ+bUxk0ljdUTizIFO1tRE=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF66324196D.namprd10.prod.outlook.com (2603:10b6:f:fc00::d22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.39; Thu, 17 Jul
 2025 16:56:15 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8922.037; Thu, 17 Jul 2025
 16:56:15 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org
Subject: [PATCH v4 04/10] mm/mremap: cleanup post-processing stage of mremap
Date: Thu, 17 Jul 2025 17:55:54 +0100
Message-ID: <ebb8f29650b8e343fe98fefc67b3a61a24d1e0f1.1752770784.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
References: <cover.1752770784.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0411.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a0::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF66324196D:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b703e32-dd2d-4110-83be-08ddc552d79d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t7BanIjZV9qTt049cI6UGTOmqbEb3KJcDvjM1rZlqaPCPBnswT5xitWRcdZL?=
 =?us-ascii?Q?zwX/UlfNCE3BpGF+bzz6WZ4leb2BWdtR9VD3gjJbXHII7YOdE6VVvh+8mg4I?=
 =?us-ascii?Q?mvFu8bJOVvXRzIlN7zH5+9HRqOUHZ4VsADnCeKOlTBrXWutd8/xXVksaQzS2?=
 =?us-ascii?Q?o5YegrzMf8ziTLpklCsb1EeWy7/e1LEWu2JeR5t1D/7VMpSGbTNkpcFVApkq?=
 =?us-ascii?Q?WOnlka3NHwsB9SKynrMo31pqEbDos4RohLjidDy3dT2cUkUzvBWWZcqGm7EI?=
 =?us-ascii?Q?IDBKk9NxAnieN1xUURFlwIlkB3LS0nXi6CroWFyxNDJXCzlC09/9PcjyvtpF?=
 =?us-ascii?Q?6HXEB5nVD8qnLFQy7efFrEBcHIv/NmII3Ik9TBd8qJ/h0NRGFCSq26EUd3XC?=
 =?us-ascii?Q?wh/8WleYwvznYZUTIESI5+3HjHfDNYIjFqTUZVFuvv/knjGQLC+s3fAq3lGF?=
 =?us-ascii?Q?QewQhC1erjpXjOdyRVbdsyyy9dqoiQ4oNRyShxq8yA3NNru6aE6crcJFau63?=
 =?us-ascii?Q?2RSqVpBqFKHQLicroKSgSnByTmq0yReo91wZ6Ix80SpWEmydCvN4QVVfHk/P?=
 =?us-ascii?Q?8bKP3Mbqy/wDCK5gWRhotakLG1tNU2zFM5OWUcOJhbh9N5AryxG9BCj0LUnz?=
 =?us-ascii?Q?x3vaM0ipZNbxs/xW8fXvvmZu0vai79KHuYjvoP3C40bfOAm5WYVhJcuHOX/9?=
 =?us-ascii?Q?+05U/uGQVkj2mPUrP3SoVuIcjTgn2nLHsNOjI2sXvJOHFysaUTp9wm+2b0Cb?=
 =?us-ascii?Q?tzzBiSBhiAPQ/7aWrqEwjdrC88yzgM8M/0ZhLl7mAjbmub8+BkS2ZUpld7zF?=
 =?us-ascii?Q?LTHTUqlMWNr5FigcNgxKI94kI/Mc5Pcm8+TvnQuFzP2zqyTVqJ+5id/2WopR?=
 =?us-ascii?Q?qwpAcMm+1CbZakH0ZuyW2Lvn6RlLVitPvbk0SjzAjq+ZSy2JN/qyVnOQMVye?=
 =?us-ascii?Q?B701PimpC4i6TgUF9GnxfGSqlN3WTd28/qKAxE0Hq6YxOPLVT48pwzbF/eWJ?=
 =?us-ascii?Q?dkMFZjOlnGAMuZH4D24P7eob2kek0kV+CbBad4AmHO2iNwv16nvW+taKC4BI?=
 =?us-ascii?Q?xuTi+2qNG/W2vUfNe2q9GLZ0W4PAiObWKsCRgRt309VYo2+jC9iR7RAT/hfy?=
 =?us-ascii?Q?z9QAwp8soYvI/VHZW+/3txCtmOTvamjZC3rngOIHShL2sT5164wphCfBX2P4?=
 =?us-ascii?Q?HtPXSvldkKPSTmWGk09F6nkEq6nANt9v/D60dWiPO8QOFHw+4pvft3yKOATN?=
 =?us-ascii?Q?t/+5XeGSDOuntOy8c+c2WJ6jOEuxYRzp29wGfO4Ew4DrGE2fDlmW93tvFBD2?=
 =?us-ascii?Q?Y4gqUcXDpTTUkQS2y6OhuOlTM3DWxHZd8rmcnK+HlxnaewDkK093HwZ31iJ6?=
 =?us-ascii?Q?SCSbkKSjOlWBFkRo4+u4L9SDL9hkg573nmTTSDqEyuq6IBWOWZ12AoOibkVc?=
 =?us-ascii?Q?WnhghPqPZbY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?joSvn5mGcFsHFK4n0bbtDj+PCOREUHXPzPXbH8qofR2dSAmkBw3xwJWs9PC2?=
 =?us-ascii?Q?hra3Vu00gZyf/wze3mlJ36i+y169QFdXU67PWo1vyopsA4q5YfS0tDyWd360?=
 =?us-ascii?Q?3gVOrAky5v6xlp2BDK97mJnRt9gfQTvPO2kpI0QJMJ64a/s33gjju+4UcLXV?=
 =?us-ascii?Q?7TyUcR67LnYjbtUClTnUxeW7ks2c7IbF1o4IB7fuwkBtmGdsyXRVvFuWjGx/?=
 =?us-ascii?Q?olJe0aGVxLDxlqtLZ1kGV7in28CZd1VdCm3qqRPcD0/s3eFwpVh9L2/nCuZ5?=
 =?us-ascii?Q?iEldOR2yGo0Q7FZnsq2nHIijTlC0Md6XEOXV+V9srN5f54kE/YTSYdvuaUlm?=
 =?us-ascii?Q?uTayJUSAyJIKj06OCqbkIxWuypm/w4NdrpwFTLlbDBnyAIBQWXi9UdGBTSnU?=
 =?us-ascii?Q?+1l1krYcvMHQd3BCkFLtsYGZE48vwbCcXfplySQORslkG+4rQTmEMqmu1rC8?=
 =?us-ascii?Q?FOTaCoeojagsPiDID4geNOvAv8o2oR4B/UqzL9apEEaK0rqip1Km8gExs1hr?=
 =?us-ascii?Q?CM+1VX4tcn/s6RTdROJSsbbNIOGmsBotAwc7Kw04CSTlfda3kMOpzRqCqS7Y?=
 =?us-ascii?Q?nJMmkiSB8GnwpqXXBaJjZG9oVlduK63Aa5nTEuleUs++tSqmSxDcxAJg8Xap?=
 =?us-ascii?Q?fX6TZAB4Bek9LnWKb06rumHkjX8SU2mXGjmoSBA/S28Tysj7RPFY0ILV0zBz?=
 =?us-ascii?Q?aO/jD/Uxr06zVRO9CBsuwC3/KQmxOy/cCw5rqP3VVoKp7cjBczA+oz4Be6gm?=
 =?us-ascii?Q?lOFvqBk4nFe+SPUDvm1oZc4KoDnwPnqRwyuLFws97aC4gYwNUo4DAMKVnU1Y?=
 =?us-ascii?Q?Sl7dkJhjUHIHCRiwhxJqucPXYGjUPHvZKopPKGC+tbZiDw0i72NK03UwqPCb?=
 =?us-ascii?Q?ku67YsnOXDIrmhr1YfOsusXR0oPgElOI9JUWb2wNYycKyK2ZnDa5sDcMQwGx?=
 =?us-ascii?Q?fcYKRffnBY5Lh5uqgWrlSet5EGNT5cURzsXsFhRXghp72K4EsrVvj1eF7lS7?=
 =?us-ascii?Q?hlg2tjZOwifGrIDgfcaNx4SxAAxbpW3gssYx319h01JjzH6VfUG/PxoYRpWe?=
 =?us-ascii?Q?n63me0FlRDlSFhl7wUw1kOijw6vWcs/WVLj++2NV5WEGvIkjObLFPerNGNRY?=
 =?us-ascii?Q?8u/LBd5/lPJBRHEW7eyECUDuYY32dvqnyzIBTlWvp2DiiEVSVCMgyj/XW1lf?=
 =?us-ascii?Q?4XQw5TlZT3aojUVrsT6SaLI7fUwqBzWJrtyCdIEDASimjlRtPvlcwqZRikV8?=
 =?us-ascii?Q?c3V6MtMcu3jkCz2tzKhwiu+dW2Kjb7dR+VBnF7OU+u7X2WLgI/bAz91pr6CM?=
 =?us-ascii?Q?7MfUfv7mNxYVlXKDxGElxDhv6iz56sA0gSI9rdh0njI5hU7bbYlWF98e5o8Z?=
 =?us-ascii?Q?BD/2idUPGRb9tZJ3cwAPCxOTHB6p0D7+UQlAmdJ85tlhyK1NOsVd6ekHnjSM?=
 =?us-ascii?Q?S3TGj2vVe9nt5FLMRve76WcetG5GRaOhzr/vx4oUlHchm1axFRcs4RZsT1BF?=
 =?us-ascii?Q?un9D7ZCw0y1ukglydITPaW87G51EXwW48WTbHbn+smPw10f3857+j2OKRAeO?=
 =?us-ascii?Q?S3sfVRCCtsc3tM0LvXRmBnJwoCW3KGtuu3QXOJ1obEmM0YR+3DGRylNKW31a?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	jvuZkhnpTIVcJAYUebQqUb0g3bYnTlmzvX8v/57dIOJ8Y9Y6YHPSfqSogSFULnFDemGZTnY/CjlgNdkTvNgwzw0RIuhwAGypp/rrFXzakELGlazlACV+jSQN7m3zS+HDFcgDEIeNdJwUx5S+lZTs1kz6JBM5kALvyufb401rRA8kw2Si2+Psq7adry8QXP2nDUWb84eatsUoSq6XCIVk6I5bYUT3/PAmPrssmYHb/TnMN/z9iSoL8wOb0QGvvRCXOGvFGQACl24PzLVjSfCwdyM/j55fC2vtD3RIn2Uw3UrMQDci5Zl5lCWGhHitnC/RtsAsXl4eOGxnJPihvdSq+mkTdm7i3zTjMld0ak0fSaLsygoe23Kw87eNSqVMcA6pS9W0HqLhE42CJofnoLcrvOwvPgj3ltsM14BYDGXyYHrHIhQOjLX7C4JeaWemBBG3cilOiv9Ta7TktKsLxOMzL0CJ87jPl2acBjlDJOwdj0VKzVUP34qJzzP+QS88Zt4H0Mxl8k0VKADf+mARTiXkfncRI4VDHo2NMkDumtWgZF8ehdIOjtsF65WbatUs0lDeytri4VR8FP/VT1YfngC49L2JvQHvPYl7XPY5XrgklV8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b703e32-dd2d-4110-83be-08ddc552d79d
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2025 16:56:15.2599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VEywfrnCqhQfevDmW9XjKdGYxGMuT6jYAGKsMgYaUlaBAui7cinxtEuR+cGJBJWQ1U8GNO7I+54lJcY/LvMPaebDB7aFTZYDgrE3+AyoLkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF66324196D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-17_02,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 malwarescore=0 mlxscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507170149
X-Proofpoint-GUID: dcCPwSgXGpPRZzhZm0I8Bkyb3gBSkJS4
X-Authority-Analysis: v=2.4 cv=O6g5vA9W c=1 sm=1 tr=0 ts=68792b33 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ULdmrcW3YHslXA7JyQcA:9
X-Proofpoint-ORIG-GUID: dcCPwSgXGpPRZzhZm0I8Bkyb3gBSkJS4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE3MDE1MCBTYWx0ZWRfX5Nnak0YGD8mp ACk5LzY6/Td60+P4Jf9RCSafyVrJzBlxzITa+bz+bLT4Bhr0xrctF0APfg+ALXcaeEhdlmvuvBZ Cqy7Y4+aERSjBRX2R7j6pmMYhMHXzJmdjufhZQsliEuI5NUsUOIMa9Pg7AZJCxxvUrnDDqsZhCL
 +YEyI2qG62lkftAOYZll1KuAkTdhPsOHJfvYWJqNu6bLsYdTdYGSSUmWbIh8fa9X99DV9lo9Lce RGxHun22bDtxqa+f81lyR1rmSx3wFA4AhlDnNyQ2h7vWOi13lthBbt/8JFbyAZ3FSZ1dTRiKFoV 5/babAMKytTO1tW+KZ3H/8iwRvf86L5oxSI24sFyDShhLlkx/T3qbdexbvDGjX3FrprTDLotDB8
 grFgc7lGZr8PynHgkDncRwlf0cxhnVAGwMgyv2cEoHPdTEFR9h22LBK4Jfk37sokHcLO5C0r

Separate out the uffd bits so it clear's what's happening.

Don't bother setting vrm->mmap_locked after unlocking, because after this
we are done anyway.

The only time we drop the mmap lock is on VMA shrink, at which point
vrm->new_len will be < vrm->old_len and the operation will not be
performed anyway, so move this code out of the if (vrm->mmap_locked)
block.

All addresses returned by mremap() are page-aligned, so the
offset_in_page() check on ret seems only to be incorrectly trying to
detect whether an error occurred - explicitly check for this.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 mm/mremap.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/mm/mremap.c b/mm/mremap.c
index 60eb0ac8634b..53447761e55d 100644
--- a/mm/mremap.c
+++ b/mm/mremap.c
@@ -1729,6 +1729,15 @@ static int check_prep_vma(struct vma_remap_struct *vrm)
 	return 0;
 }
 
+static void notify_uffd(struct vma_remap_struct *vrm, unsigned long to)
+{
+	struct mm_struct *mm = current->mm;
+
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
+	mremap_userfaultfd_complete(vrm->uf, vrm->addr, to, vrm->old_len);
+	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+}
+
 static unsigned long do_mremap(struct vma_remap_struct *vrm)
 {
 	struct mm_struct *mm = current->mm;
@@ -1754,18 +1763,13 @@ static unsigned long do_mremap(struct vma_remap_struct *vrm)
 	res = vrm_implies_new_addr(vrm) ? mremap_to(vrm) : mremap_at(vrm);
 
 out:
-	if (vrm->mmap_locked) {
+	if (vrm->mmap_locked)
 		mmap_write_unlock(mm);
-		vrm->mmap_locked = false;
-
-		if (!offset_in_page(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
-			mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
-	}
 
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap_early);
-	mremap_userfaultfd_complete(vrm->uf, vrm->addr, res, vrm->old_len);
-	userfaultfd_unmap_complete(mm, vrm->uf_unmap);
+	if (!IS_ERR_VALUE(res) && vrm->mlocked && vrm->new_len > vrm->old_len)
+		mm_populate(vrm->new_addr + vrm->old_len, vrm->delta);
 
+	notify_uffd(vrm, res);
 	return res;
 }
 
-- 
2.50.1


