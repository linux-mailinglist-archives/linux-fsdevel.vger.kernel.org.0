Return-Path: <linux-fsdevel+bounces-43667-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1B0DA5A350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 19:42:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 83444188E350
	for <lists+linux-fsdevel@lfdr.de>; Mon, 10 Mar 2025 18:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0740923E23D;
	Mon, 10 Mar 2025 18:40:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YaSHy0zp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Tp7MEbPz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7573123C8AE;
	Mon, 10 Mar 2025 18:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741632034; cv=fail; b=pTW6pqqiugFHVavAH+MqiZqQf/ko9NR9E06ocBKRD/Y34togjmbRf+C5ymP2ivaOifUmtUdoB8FRE8Kuuz+Tc3YKvqxukmeY6gRX6j+AJN9gYFU+cc0u+Zj2QJjLqFYYQKXjVoQ1x+D1/vYg8fnc7RWeFKsDcXdQiiyJRVaNzKI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741632034; c=relaxed/simple;
	bh=bU7fqdOo/emgxJstj3e6ACOHqCBaf8b4sP7S5GLQcZs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsYgS9pX9SP+G3MFjLh0j9D4C2CkrVdtXzokUARRgLYqU4trDAHKkUek7c+KlYPQhLw+rXlxEOVWfadKMfKMTEDEERfmVnidfesfc3MxiKyMQzbEH9vMR9ca4uIPxh1HiYuT2EfHE0+JG8YTceb4aA9IJcR7WeqAUZ7TtbU/Ly0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YaSHy0zp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Tp7MEbPz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52AGfhYR032608;
	Mon, 10 Mar 2025 18:40:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=MDxOfXQBu1M5TFfI6RU4lqavyFel+3D1RNvns2GQgjs=; b=
	YaSHy0zpwXZQLpUQMTyliHbs2UuDG2SlU1LJyiGBqWOojUtdnfN4A0X52UpSclJB
	uSjTE0B/O/TqBGPK50yaY7nEHNgyrcQQfqFDHH4m6sP2MaJ2/RF4lUaRzFvPwZZq
	XyEcx3RawqggM7Z+Ox1IdxJ0/urxxAYVngG9iMbvxlE5FxY+xel7/v+ZM6nUII5j
	GQ8ZMUBxX1awa2er3khDlfNqN5LVORRAC4H5tQ2085osrPU/81AQ5i9KdQtw7hhS
	zYjMBs2VuRLyZjJAN96MmJ1dtik8BgI4L4QfoebCpI4cnBReMslZgM6qiKsrB+A3
	LJY5wONhBaTeCOAWuv1XUw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 458dxck9yy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:25 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52AIEx0P017521;
	Mon, 10 Mar 2025 18:40:24 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2047.outbound.protection.outlook.com [104.47.66.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 458cb80d3m-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Mar 2025 18:40:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Htk58tAFnCgUalaZQ+HmypXyvOFWBnRWDfq3gnVvoU70zFqVkEsEHScFlDuyySEHP/wGAVnLO1Rp27VrjaZZJMRiJ0w2T/6XBTIa0EgY1RSUUrGbdYkxDvNrm3TMCnvWX162mASVKJ1vI1fgoXLFDbM/FV8plo9TYne5vHrB/fWsqJRA1rbbAVMdXQbMnI7gdxrDuMTb7KIAAK1RoSUQV0BwN8ZiFVFFoirIb5FpORgJmemmvBL0qpT9zN3KNfNIfOYDfXXaBcMS8uTVsDzGKW2zxWftQZ34AF2yQnD2EXHuDMzx0wb5PQ6DaEieKHxdg2PgbajQdy4VosOaLVqmlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDxOfXQBu1M5TFfI6RU4lqavyFel+3D1RNvns2GQgjs=;
 b=ErIKS56Nkn/imaCn7TR918zcpo+7s2AXeP4dhM84FqH92QCdu2zr1C9PHPhrIE8ATQ+a7MmJ8K5Y0/4XuaS6Thl6N6UehJUZoPCKHWuUGDbdmW6UOXvIY+00h0BWz4R4uuhdE5wuV8DttQNIg+kqoQUF51VRU4NgHlu5rwpDAyegiNseHXf9FSdq6BhvPfHvCH9GEGAnR5OcJMl/YLNuo+Ba2UzUgXEmH2xMeZsaHzwL7A4y+C/gIX30mzwXV5m47zNzrkuX/n4KXDyLHbtzJwDp7Gj5ouToW4xp8GEXZ+49dAJd9W01aXJBHjH/chRk4D3eSlPI0M4/ETPsjPBaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDxOfXQBu1M5TFfI6RU4lqavyFel+3D1RNvns2GQgjs=;
 b=Tp7MEbPzFI6gn6JHxyOFMZzy1mzOgwu4oKS4r5L8JTx0yVO8MuOlFLK8+d4OiHSyiJlXfPkSp3xBNRppEOYFpBOTbnjh1CpcUV/Fc4PBoFxezeWlZ6iMuC48a4EvadKpo6VdbYCOBy4wSpI++pDzN396dpoSfQNRyRglaukKK0E=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4502.namprd10.prod.outlook.com (2603:10b6:510:31::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.26; Mon, 10 Mar
 2025 18:40:22 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 18:40:21 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
Date: Mon, 10 Mar 2025 18:39:46 +0000
Message-Id: <20250310183946.932054-11-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250310183946.932054-1-john.g.garry@oracle.com>
References: <20250310183946.932054-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0P220CA0021.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:a03:41b::8) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4502:EE_
X-MS-Office365-Filtering-Correlation-Id: b1dfa770-d15b-47c7-f133-08dd60030331
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JEQJaRhqVI0tjY8B2b7+gSjLXA8/v+DbPVJixXTv0sHiG0l/d5jGJTSe3bg0?=
 =?us-ascii?Q?+CKvCSyhxpbbUsM/Jfkkc/GSZcUASY7gpEVuSjSoZOvt5C0vk5oOfQku9y2X?=
 =?us-ascii?Q?Zr61eB5gBviFP/k5g6xqyiQs9j1qDiZ0ON7UvBmHQ3GqJ6fO6Ccz1lCr+o3t?=
 =?us-ascii?Q?T+xaG8E4oXiLMQGbMWdQS2VcCF8VATM1KDVt1MRnllCc72upH8roFOXAFR9Q?=
 =?us-ascii?Q?bjAEw8q+koKasg5hhB1AXrNQoUAkExcSNRaE8YoOzc986wWZ8xl05sYkm5rK?=
 =?us-ascii?Q?pnvNpzxCMG31t+juceEi93ggELXgRStRXaBcn33iV/YP/4e8pXLy3sku1S8W?=
 =?us-ascii?Q?avl3mw1uAsyXDrzPniIZaYgsSnnLlph364a91joaAXaZ66WtCSrVs+LIlUU4?=
 =?us-ascii?Q?0V5xqwHeDh4sY/BW9X4bUc1v5i5u7fTh0Y6CuALKnQXXeoksCE9KJkppzpGo?=
 =?us-ascii?Q?Ni7S2JhI50FIX8sZ5hGQLpb+l3LQpF5LX1JLCznOaLijrek1s64kMweFZtvD?=
 =?us-ascii?Q?QI/DC7/BHklgvHXhnGkD5VZiSDRTwKw6HxP1QblbydWi+WE9z31+KD1vtfPB?=
 =?us-ascii?Q?J9hYuv1Sv5FK4NEJKhbfcfaKweMnsN+OHKjLN1xcgbR6U5Tu4lbi4Tw+dCIQ?=
 =?us-ascii?Q?AB17bHPRgCfvXpgR2RA0Mty7aWhwpZsA5eRimzlsujDygcqYaPYwblAKQNgv?=
 =?us-ascii?Q?qG8Ry9NckxCsd59qz4kBex2mYIU7/9t8epK8/8f41tzn8N19/lXtZr+TQaBZ?=
 =?us-ascii?Q?P+6KpcUXQvv/kL9xLu70gJCVMgilEncnEWDKcXH6fCLOD8P6nPtE1YQK5q8v?=
 =?us-ascii?Q?E6vW6j23GfOnfmpEZmY9Tww4tuGqg7kVwhGj9dv3z3L5LI0A6KxNocGujFQo?=
 =?us-ascii?Q?mTFpsLUMA4CdCDf3Msz6BYXN1991Nzr/cPfq9rhiXLKjIhXpztgXByqOx+IB?=
 =?us-ascii?Q?o+Nft188sbxT0uIu33IyDgmu7pqrZrSQda5xzAY8v3VkyJz0BAov8TdcBpbI?=
 =?us-ascii?Q?GdiaGD6mTXLfkstxMFB0v+tHijDOSdgICymGX9WNNrlkHFDjLjO8u5EtSY6N?=
 =?us-ascii?Q?yPZ2ErD/yh4FEhlLRui3VgzSOPmrEk7Rtn01CKUT5DxLqX/m296FddxnFDXQ?=
 =?us-ascii?Q?SmR6yLAG/qwyXt5BgNbPOg3Y4lgKg8x7r0xH95z6NB4HTHCK0Kl7xw5GoFk8?=
 =?us-ascii?Q?5c2Rx+FYWLUiuecuBoHl75FW02NsQZLbgv0s+CAKJsFhKNMQmlkjeqDcOEjM?=
 =?us-ascii?Q?6oEZy1JIWedoM5JsmQ+6kRrPnuAOpZb9DXe1CdZ8whH6qzNS4CpynLfhnw17?=
 =?us-ascii?Q?oO0MfL9BF+/j69Jdtx27QuFxKkdpTpiLAfno42gewjMwN/H1WS5TwRor1vnU?=
 =?us-ascii?Q?MMlqcycLZADjQr7qPVv1FycslPXE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dMUVOECHsP7pyuUZDdDsUNYKRSvrmMDgXQC8knjWLZwPagIVy0VM5IEbV5AS?=
 =?us-ascii?Q?1Rogqpw8qk2nNZrFx0fxro2SDvTS8IpYgJsPHoP/1B5CK7e5vVxeURjEKZ3D?=
 =?us-ascii?Q?a3QGWIDNEbzeOYB96htgdaXaYffklIrnSalGGAKG0Yz7bFd6QjB6HiT+/huz?=
 =?us-ascii?Q?q3p7+sa0vcRMnqlN1uC2bafzcEObEbhQrt02Q+TDz8jrob8Y6K5iYaJdCd4x?=
 =?us-ascii?Q?o+tpgRVDceHrGULMQ44bKD3HGyjLwiP+ikGj24oqZkG4u8kBBqoicGyO0f6s?=
 =?us-ascii?Q?hO3Jx9q4RyDE/q3/ENEu2NWtVixKBToGvlART67QImaaV3iyvyu2rBqExNs2?=
 =?us-ascii?Q?nPgJJKgO6r8OxdncLcrVL4blieR5ZFowDfJWP2Bjs9+ipxvIdjONjCIREWh2?=
 =?us-ascii?Q?hDWxO053grVnsPg2+CcbFQyUioEWoDiaf5F9PyKa5OJBbQ+PJP47RpBA98dF?=
 =?us-ascii?Q?i/9quj2cqSCf0QipsurHKNvqp1+TCPI2SDPUowXUtntsh4LngDQF1JoyFfsz?=
 =?us-ascii?Q?4/tsOI9uPoHDjJp092cbC7hVSMhcjz/0VoxBxKar/KhNIe+Ftb1obU0QhAtH?=
 =?us-ascii?Q?JnL0P7Q+0HAFXFnTd07QRKRYmt1LE1ibRologz6SGRoq7LSMn4KNJMvckX9t?=
 =?us-ascii?Q?6Jg0CPD6GlDlW3D5zfSoYrz6xZBMmn+MBgjwaMYPuN1ejjQRVkwdEllqUNkW?=
 =?us-ascii?Q?knPsbnWcjG0iF4JPG9DiDIIE/6+bUyFAOx2xcnoL1X3Y38MLNK6HrTlJxy8h?=
 =?us-ascii?Q?gj0zpqPLS+Nv8+1rxj1nu4DlEDYVyolSkT1iV2Fm+Xyd3DsuCaDgmeIuSDms?=
 =?us-ascii?Q?Lhsior+keywX7w5WesxMNoSvwHKJpfeyUyDoKNYwquuWNimbP5cFZTf8vgxx?=
 =?us-ascii?Q?8MxnJcyYiLecsVXIjK8BkZ/D0NqAXsCgPgMXHUILtwuvMWr0+69AvlmBSICF?=
 =?us-ascii?Q?M68ZajD9pCd6CkJLTyJP0wVfE6H4+YnTcicAcvKzDJWKBFDZgcUZBEMr7b9s?=
 =?us-ascii?Q?67UTECx4aGPMpr300ZE++58ueesWXCVn0O/e7ggK4i8lhlIRYEZ9mW6dCFHS?=
 =?us-ascii?Q?0lli/RBIXyuUaZtPadktzbDeJB7M/6MOsFnkDUta4CdWzahlKB00b0NHlEYc?=
 =?us-ascii?Q?0EKhIkc21wrQzfAu8WOYKheXf/qeJAqwIbz43B4gkqTAVVX+zyp/w9ujULum?=
 =?us-ascii?Q?ZpCSILLZJyEpUuFmxnI3TeE23XhZu5L6f+bD17ST/8LhL2y/aaPLZcnrLMrZ?=
 =?us-ascii?Q?fwY+06dXxCLX4F0CqOjSwQIaDHxQ2R26uQhwRu3kV3UoLOT8ZNCnXmcFsuNq?=
 =?us-ascii?Q?xNqaqEDqh0HPBgOIpbSHnrZVF3AbQRw3WnaHljNelmYDiwiZnzrrcVzHBX7u?=
 =?us-ascii?Q?ExFRrjHLZEDi7vIE4r4mPoNphh6bqeH3ld9Zvmr9I4JJX+3JOXM0asemZ958?=
 =?us-ascii?Q?t9+1DNZAGitScLMlqpzJ0+tVw0ShH9NNcf4s1cgPDacmB4iL3z+tLZHlPeux?=
 =?us-ascii?Q?zbGDBN9FTUGUS/3I8DwlV9vPXs7xQ9wnHy+oEWAR4CTPQbesWCabBb1y5JeI?=
 =?us-ascii?Q?NAzBoHIhSH/KKtW2WjjW1L+D3Cyo/dWe6WA080Yv3xf5FpaDfli8PH+onZmR?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	QRo8IYUc1/EgujAvzJSyZyzwQzOhCqJACDjUgusbqRP+YUJcTL0ddltdDOjhDVI/+r5IiWzq7K135tJ8QLx3jmG24Bm9PCb2AITclroyvVn28b+S1dG0Hi1IyEdksjw7RdFuZp756DwdGY02aWLMjZZ7I9Rq2SO+55Fb99dbQNt6r9Sf36T26cdIlh4vMNiWnrSeo5H3B/XvfirBtssRtQ8ra/h+0UEfUXzrJIThAk6IgXgWpG72+NYbCK6iU56kEvMUuVtDr3qomhZ+aJV7Yikn0toUQyvklAfTOoSjAHabbFYf7qD8xrDhzVqDU0q0sSzarPbEJD0W6bsszSRtE6mvvzpxYGK4q2bjask8oTnUOW+A38axwfsn/ruwCKt3SnLHKlxLcGsAfqVDtTCyyV1pb99DuCcV06EsgqnNxVvNu8C3X87LavXgli7Li/egWdj9exc6cF/K5ckaQBiMI5Z3F8Q4D1fTRA92RwZtQWkZg9LZO/yhtFNhU2w2wq3rBWGf/9QHdSAfKG1CfTSC39agdaUl9b0YtK6K+So94xfXei8G0z3SCiFOPZxCKm6WZo7VwUh/LHEkWHQibNDwMkrqwpt0YFQ9JRdruDrFmcU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b1dfa770-d15b-47c7-f133-08dd60030331
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 18:40:21.4195
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0DonTbeJ+Y9OCgGt269R8F9rBM3eOmPo5LWBfHC07kPBgfwLjsAm3sdlkhBwadP6vef24E3Ui5gNjJtoeAJJ+A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4502
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_07,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 adultscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502100000 definitions=main-2503100145
X-Proofpoint-ORIG-GUID: VYfQK-tr0F1y5Loli3yMLGieTntqKuSn
X-Proofpoint-GUID: VYfQK-tr0F1y5Loli3yMLGieTntqKuSn

Dave Chinner thought that names IOMAP_ATOMIC_HW and IOMAP_ATOMIC_SW were
not appropopiate. Specifically because IOMAP_ATOMIC_HW could actually be
realised with a SW-based method in the block or md/dm layers.

So rename to IOMAP_ATOMIC_BIO and IOMAP_ATOMIC_FS.

Also renumber the flags so that the atomic flags are adjacent.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 Documentation/filesystems/iomap/operations.rst |  6 +++---
 fs/ext4/inode.c                                |  2 +-
 fs/iomap/direct-io.c                           | 18 +++++++++---------
 fs/iomap/trace.h                               |  3 ++-
 fs/xfs/xfs_file.c                              |  4 ++--
 fs/xfs/xfs_iomap.c                             | 10 +++++-----
 include/linux/iomap.h                          | 10 +++++-----
 7 files changed, 27 insertions(+), 26 deletions(-)

diff --git a/Documentation/filesystems/iomap/operations.rst b/Documentation/filesystems/iomap/operations.rst
index b08a79d11d9f..f1d9aa767d30 100644
--- a/Documentation/filesystems/iomap/operations.rst
+++ b/Documentation/filesystems/iomap/operations.rst
@@ -514,7 +514,7 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    if the mapping is unwritten and the filesystem cannot handle zeroing
    the unaligned regions without exposing stale contents.
 
- * ``IOMAP_ATOMIC_HW``: This write is being issued with torn-write
+ * ``IOMAP_BIO_ATOMIC``: This write is being issued with torn-write
    protection based on HW-offload support.
    Only a single bio can be created for the write, and the write must
    not be split into multiple I/O requests, i.e. flag REQ_ATOMIC must be
@@ -530,10 +530,10 @@ IOMAP_WRITE`` with any combination of the following enhancements:
    the mapping start disk block must have at least the same alignment as
    the write offset.
 
- * ``IOMAP_ATOMIC_SW``: This write is being issued with torn-write
+ * ``IOMAP_FS_ATOMIC``: This write is being issued with torn-write
    protection via a software mechanism provided by the filesystem.
    All the disk block alignment and single bio restrictions which apply
-   to IOMAP_ATOMIC_HW do not apply here.
+   to IOMAP_BIO_ATOMIC do not apply here.
    SW-based untorn writes would typically be used as a fallback when
    HW-based untorn writes may not be issued, e.g. the range of the write
    covers multiple extents, meaning that it is not possible to issue
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index ba2f1e3db7c7..da385862c1b5 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3467,7 +3467,7 @@ static inline bool ext4_want_directio_fallback(unsigned flags, ssize_t written)
 		return false;
 
 	/* atomic writes are all-or-nothing */
-	if (flags & IOMAP_ATOMIC_HW)
+	if (flags & IOMAP_BIO_ATOMIC)
 		return false;
 
 	/* can only try again if we wrote nothing */
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 5299f70428ef..d728d894bd90 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -317,7 +317,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic_hw)
+		const struct iomap *iomap, bool use_fua, bool bio_atomic)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -329,7 +329,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic_hw)
+	if (bio_atomic)
 		opflags |= REQ_ATOMIC;
 
 	return opflags;
@@ -340,7 +340,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	const struct iomap *iomap = &iter->iomap;
 	struct inode *inode = iter->inode;
 	unsigned int fs_block_size = i_blocksize(inode), pad;
-	bool atomic_hw = iter->flags & IOMAP_ATOMIC_HW;
+	bool bio_atomic = iter->flags & IOMAP_BIO_ATOMIC;
 	const loff_t length = iomap_length(iter);
 	loff_t pos = iter->pos;
 	blk_opf_t bio_opf;
@@ -351,7 +351,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 	u64 copied = 0;
 	size_t orig_count;
 
-	if (atomic_hw && length != iter->len)
+	if (bio_atomic && length != iter->len)
 		return -EINVAL;
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
@@ -428,7 +428,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, bio_atomic);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -461,7 +461,7 @@ static int iomap_dio_bio_iter(struct iomap_iter *iter, struct iomap_dio *dio)
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic_hw && n != length)) {
+		if (WARN_ON_ONCE(bio_atomic && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
@@ -686,10 +686,10 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 			iomi.flags |= IOMAP_OVERWRITE_ONLY;
 		}
 
-		if (dio_flags & IOMAP_DIO_ATOMIC_SW)
-			iomi.flags |= IOMAP_ATOMIC_SW;
+		if (dio_flags & IOMAP_DIO_FS_ATOMIC)
+			iomi.flags |= IOMAP_FS_ATOMIC;
 		else if (iocb->ki_flags & IOCB_ATOMIC)
-			iomi.flags |= IOMAP_ATOMIC_HW;
+			iomi.flags |= IOMAP_BIO_ATOMIC;
 
 		/* for data sync or sync, we need sync completion processing */
 		if (iocb_is_dsync(iocb)) {
diff --git a/fs/iomap/trace.h b/fs/iomap/trace.h
index 69af89044ebd..4b71f1711b69 100644
--- a/fs/iomap/trace.h
+++ b/fs/iomap/trace.h
@@ -99,7 +99,8 @@ DEFINE_RANGE_EVENT(iomap_dio_rw_queued);
 	{ IOMAP_FAULT,		"FAULT" }, \
 	{ IOMAP_DIRECT,		"DIRECT" }, \
 	{ IOMAP_NOWAIT,		"NOWAIT" }, \
-	{ IOMAP_ATOMIC_HW,	"ATOMIC_HW" }
+	{ IOMAP_BIO_ATOMIC,	"ATOMIC_BIO" }, \
+	{ IOMAP_FS_ATOMIC,	"ATOMIC_FS" }
 
 #define IOMAP_F_FLAGS_STRINGS \
 	{ IOMAP_F_NEW,		"NEW" }, \
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 16739c408af3..4ad80179173a 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -755,9 +755,9 @@ xfs_file_dio_write_atomic(
 			&xfs_dio_write_ops, dio_flags, NULL, 0);
 
 	if (ret == -EAGAIN && !(iocb->ki_flags & IOCB_NOWAIT) &&
-	    !(dio_flags & IOMAP_DIO_ATOMIC_SW)) {
+	    !(dio_flags & IOMAP_DIO_FS_ATOMIC)) {
 		xfs_iunlock(ip, iolock);
-		dio_flags = IOMAP_DIO_ATOMIC_SW | IOMAP_DIO_FORCE_WAIT;
+		dio_flags = IOMAP_DIO_FS_ATOMIC | IOMAP_DIO_FORCE_WAIT;
 		iolock = XFS_IOLOCK_EXCL;
 		goto retry;
 	}
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 6c963786530d..71ddd5979091 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -830,7 +830,7 @@ xfs_direct_write_iomap_begin(
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
 	xfs_fileoff_t		orig_end_fsb = end_fsb;
-	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
+	bool			atomic_bio = flags & IOMAP_BIO_ATOMIC;
 	int			nimaps = 1, error = 0;
 	unsigned int		reflink_flags = 0;
 	bool			shared = false;
@@ -895,7 +895,7 @@ xfs_direct_write_iomap_begin(
 		if (error)
 			goto out_unlock;
 		if (shared) {
-			if (atomic_hw &&
+			if (atomic_bio &&
 			    !xfs_bmap_valid_for_atomic_write(&cmap,
 					offset_fsb, end_fsb)) {
 				error = -EAGAIN;
@@ -909,7 +909,7 @@ xfs_direct_write_iomap_begin(
 
 	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
 
-	if (atomic_hw) {
+	if (atomic_bio) {
 		error = -EAGAIN;
 		/*
 		 * Use CoW method for when we need to alloc > 1 block,
@@ -1141,11 +1141,11 @@ xfs_atomic_write_iomap_begin(
 	ASSERT(flags & IOMAP_WRITE);
 	ASSERT(flags & IOMAP_DIRECT);
 
-	if (flags & IOMAP_ATOMIC_SW)
+	if (flags & IOMAP_FS_ATOMIC)
 		return xfs_atomic_write_sw_iomap_begin(inode, offset, length,
 				flags, iomap, srcmap);
 
-	ASSERT(flags & IOMAP_ATOMIC_HW);
+	ASSERT(flags & IOMAP_BIO_ATOMIC);
 	return xfs_direct_write_iomap_begin(inode, offset, length, flags,
 			iomap, srcmap);
 }
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 9cd93530013c..5e44ca17a64a 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -189,9 +189,9 @@ struct iomap_folio_ops {
 #else
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
-#define IOMAP_ATOMIC_HW		(1 << 9) /* HW-based torn-write protection */
-#define IOMAP_DONTCACHE		(1 << 10)
-#define IOMAP_ATOMIC_SW		(1 << 11)/* SW-based torn-write protection */
+#define IOMAP_DONTCACHE		(1 << 9)
+#define IOMAP_BIO_ATOMIC	(1 << 10) /* Use REQ_ATOMIC on single bio */
+#define IOMAP_FS_ATOMIC		(1 << 11) /* FS-based torn-write protection */
 
 struct iomap_ops {
 	/*
@@ -504,9 +504,9 @@ struct iomap_dio_ops {
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
 /*
- * Use software-based torn-write protection.
+ * Use FS-based torn-write protection.
  */
-#define IOMAP_DIO_ATOMIC_SW		(1 << 3)
+#define IOMAP_DIO_FS_ATOMIC		(1 << 3)
 
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
-- 
2.31.1


