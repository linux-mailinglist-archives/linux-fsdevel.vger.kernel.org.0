Return-Path: <linux-fsdevel+bounces-41651-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D56CA3410A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 14:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E1A0188E47D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Feb 2025 13:59:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 869E8242903;
	Thu, 13 Feb 2025 13:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hh/YvuLY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="pTlNu1G/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4C98269809;
	Thu, 13 Feb 2025 13:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739455044; cv=fail; b=hz3JRi/N/g6dmH/oqEybcOOU11TjjAPD5a+dWvpfueuWFUhXDzq/ro38sTrfuUmSv88CaMPBbH7RgAWVJY+C1fsEId2n5ER+x+sfRii1VjLcqN0ZWYOZ0Yxhi1b3FBe7UNHnB0abAhgkLWQs2F/qnOWbqzUgbpjlkBhkcrCtpoI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739455044; c=relaxed/simple;
	bh=Xy6yPk6VzfqWA5WmUEgwqoJemkbQRT60E0wCTcwXMTE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=N/McMJOkaakhTBBp7JoFLLT+gvGewkg7yNPwU6TLHf6AnifdjtBBtnnH88H3h284TgSp6WNY3n2FJfzlGD/9r9Ipyj/JnmVNb/hOSCUXAoIBFkpHBku6VyJyPJRmrpfM33miNjAVkakWoG5iMxYSOSe7vVyr7LXnZ0ZmEnI7xMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hh/YvuLY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=pTlNu1G/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51D8fkRO026854;
	Thu, 13 Feb 2025 13:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=OcocZYq+Xi6IU2svgf1TfAoJAcmRYgj71DAkmMz5BtY=; b=
	hh/YvuLYIiI58nItzhSmaspQ7PVE5rPWfoLumube3rl68hB2cJxsi624v40YkyBi
	XJVAeIG2lL63PR5sPb6Bfc6FAlh9kbxDRTY/LBkxnuNJp4LdbfdcXN0e+FMN0yIX
	AO+gk+17Ymh8rIsw3jSZlDl7WDI/qodtkmEv4Xy7RgEJ4z6hwO/18d2DtxX5sgbp
	a/wTCmuqMo1IG/2zwTT0tMOd4QTfLzAD5dR2ILCJ83w7IGcffRixP2OYbK1fpnr9
	0/5eGP4T4YMBI0r7PfSmB2qJuZ5wPnn6K8MpE76WJiRbYsuydqoOwaWX2MnXDMr7
	AjLRPiSQAQNjHNO0MLTExg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44p0tg9qhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 51DCwq5n026955;
	Thu, 13 Feb 2025 13:57:13 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2176.outbound.protection.outlook.com [104.47.57.176])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44nwqbprcm-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 13:57:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SbAcl4dLNP/fqjOJsLrypKMhngvVlCpZCzQH2ouE8k1O406SA85LSoGSK55FTjBEWzrw2i773JuN+VESu/2UXBfNMRP12X2XOrVmXgQhHUNl3tmmDOqlQ69kElwfMgTK8WOhFtbBMdpkBi97rwNn+tiMMV2dKKvRTYHNSCrUkpn6kMC6U0CejoO018OEMoOUFJpYq440O6jknK5Uo2VbtWndyzrrWM+MXDkG4ImC8ENxnCVk0YW7kcgpWXWVJlNkHSDJDpnRtX5DHf3eyxkzK9zBUiyw81B2jwXHfd07+QuyMbr4Ft77yd4SxQNo35FVvc45JI1hsyN2LrzhbAT5aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OcocZYq+Xi6IU2svgf1TfAoJAcmRYgj71DAkmMz5BtY=;
 b=AnedCN/pFnjb3xhemKlU0zW5J18INFlBt7QzV/De8H7pMIzbSlg4ioXC770KypRxVe4Qu7+yXcMO+jMzNFquJOnnBYtXGst+Nn5yALLmSMdvDbfCZP+MVfP9pgCqNrEDQSrIRfc/eSkGCpN3xBd6sfAgXoeq5bicDqDZv9rJJFpv+7EAYgkffEMnqOH2q68b9ufPnqAKUx7xGIXyhx+OTIW1F4Vnc9cgTiQ9nHKs284PfPNrJVSPYT+IO1k+uwapkIHFHEaWqLk9gVul+22uf1ITrkg0fz9G6SN4/8RQ9YVqVUm9YicuFrtzgEOXBBO3DJYV/CWY622eAKqpwMw/sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OcocZYq+Xi6IU2svgf1TfAoJAcmRYgj71DAkmMz5BtY=;
 b=pTlNu1G/qX5ST2fGutNN2cG6s+AX18DNomUYMlm+6mcJm1zUMYD9wFgP3vcSdAk4TqCnP8Q2tGOgHZ4jPz/RdceYlKMHrA9f/nEn3pQkid14y5TIml1r3rL9htoDgE16kWyEDy7TCkdcUgmQJPCKEIuoGW1aa/4vE6cDCtUdSxE=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB7125.namprd10.prod.outlook.com (2603:10b6:8:f0::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8445.13; Thu, 13 Feb 2025 13:57:10 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8445.013; Thu, 13 Feb 2025
 13:57:10 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com, tytso@mit.edu,
        linux-ext4@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v2 07/11] xfs: iomap CoW-based atomic write support
Date: Thu, 13 Feb 2025 13:56:15 +0000
Message-Id: <20250213135619.1148432-8-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250213135619.1148432-1-john.g.garry@oracle.com>
References: <20250213135619.1148432-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BN0PR04CA0044.namprd04.prod.outlook.com
 (2603:10b6:408:e8::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB7125:EE_
X-MS-Office365-Filtering-Correlation-Id: 538b06f8-5069-40b7-f4e1-08dd4c364f7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CdeOm/GTIdBrplb1wB7NCyI7MJ612KNHLGmVOoL2dLwaIoQ5m/VmBjSmzK9B?=
 =?us-ascii?Q?ZOT72ccZUbNVprgUU+VCspjDwVoC/KhRa3cbn1/MRDbSpWlNnkox3CMJ9/sY?=
 =?us-ascii?Q?AtifBxyci4Vi/sAFSmMu2I4f8hZ0yDSkp8j8CCjzLtjOOdh3bZMfUEngqqhk?=
 =?us-ascii?Q?jRVjcB3fculQCx6PDBngKIlArQtbYleH0r3QCjKK79ZuQrbz17hfH7iTWIAN?=
 =?us-ascii?Q?d2O+xG8/PYaXxNpCjKqLmpLy7LUR2AlSFV65GP2f3ngYc0Du0WCIYV4+k5J1?=
 =?us-ascii?Q?SCL2YbBRCR/PGXwCz0hXWVQy5Remf93Vkl8yykCekCXfbDVneiefgEsxLQd5?=
 =?us-ascii?Q?0qDUeTH+FeOu5PQqD/C8OYqAx7CTPvZlJZFDNwielv4zZocECvihniUcDsml?=
 =?us-ascii?Q?RDhz6UIpfN8lCwwIkll9zesmbelEIK9GHPaP8YWDBhR+hiLgeOiZ62byYUSk?=
 =?us-ascii?Q?+9H/IpuPUUdaJjoHYzOflNnXjBeapJa4uWPEK0mgqI926kRf5J/7fxGSwKBD?=
 =?us-ascii?Q?unlTWbJGg8+KeQsEnu4qd7Mvi6UtNpJNz7xdwiXyYenhhwJChP+AxqhGSnDP?=
 =?us-ascii?Q?SegYg0XityClMEv/891dcKBr2JULLMJOh4UNtK+Eo0B0Fwze3jPXPnpg0wFZ?=
 =?us-ascii?Q?Ep6aUAETGrN71rtRUpXvjXMKP4plpnVINfqvKrWUmSbk2A5XtxEJd76ojAmt?=
 =?us-ascii?Q?OC8yVr+7WEL1wM/NpIbcBXC8KnGeMdFQ6UQc3X7SPoDrJ2Ph2t+CvmROhIda?=
 =?us-ascii?Q?HQqtFME5zWVa1BOdyVrT95Y0eqYqKQ3q32Qz5NNNsZkAj6yGR/bbUPQoL4i2?=
 =?us-ascii?Q?7adEvIh4uB6rGOOjcSVgyN2YRY8P0du/nnjJqL+LYzFgrj8BnfM+4HVzHaZP?=
 =?us-ascii?Q?lNqBuX+YCG8qSB78h5A8YF6fYDdQh1Oc4pozosOnTc7R964Ju4ZFMXVjGHJk?=
 =?us-ascii?Q?zopJuZYqBkicEv3V7/d0EsNfETZ3bqdZ4PWz4gYTvY2odHTmV/jJJwX/Cs+0?=
 =?us-ascii?Q?mihlNBLcg4e3NCUZHrcdIAO+Af0AuM1gwFNecuTpt7zWqVDyZsfbckDQ0ZsH?=
 =?us-ascii?Q?5fTR9Z9pgmkGQy4EZs16CjUjzc9NM+bTQF8EM7X/WUKgvlV12XcwhmVEuapV?=
 =?us-ascii?Q?q5zcY3moE6ktXOdBqxnfFx78Wu5RL60srPiL5B0ehH6iZJKswGRzqRug1X1M?=
 =?us-ascii?Q?waxmDta5gLwHrTE2TAvScHCPaDtvHG7L7UuGNo9gByk5aselF6Z2c0Oh34DO?=
 =?us-ascii?Q?xWJ1eBKqzAmSlx1ndnOIu0gsdCmA3iHzYQyIHrpwrHPJQoasFnqxihJCxztK?=
 =?us-ascii?Q?+pi96QO2I7UED7hsMjIcfmiG27scMxvhi4GH2PNzYVuuHPqt8EoFfxCzaOE/?=
 =?us-ascii?Q?OpIKsPYTy9E+F/LvryK679hotkaT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qSTtG9AGq/LMWvwNodIOxggy9LNFUe4XLc8YtLw3n8+HC1Umm2qHP4K5LK7P?=
 =?us-ascii?Q?x2CdGRFUbDFHKEvVsZxJqE0sqqIjgjlaB8AfW6DPQYOFdaBiUlDZRNBPHbFR?=
 =?us-ascii?Q?xHa80mqociWFouD97K7dd3Fz9LBxhgHNT6SuPCr2wn52M9Ux5jS0zj97/ixA?=
 =?us-ascii?Q?BW2uSoBBdBfaMVarq3X1HamXPLHTGZkq2lyGJm3WzCV5kWVSRjAeh31J/IKa?=
 =?us-ascii?Q?Bw0bt7+thFA1wy0GxLdwAbbz2WMnZV7VC9pjXXz78lSWGIAxdTRzcOMlJ9j6?=
 =?us-ascii?Q?YFmjqvRywoe25hIHLBVQd0aHRy+2DOxfiRiDXh+OA1g/j+LJmgdjdTRBmd5V?=
 =?us-ascii?Q?Khj0/iMFO55krsKNjJ54sAyXmwFSxgqbarkfWOOJX8vhi+3gmzhZBAMICz2F?=
 =?us-ascii?Q?VK5qrYo5EN1w7Hd4XA3JBJBf3iVkaM7WTwy1GSTVijTyE/v7syNNDHr95Y9y?=
 =?us-ascii?Q?HDWLXXbrnyvxpuD3mKGvyifPSe9KFO7bqyklNWgOLimtwGh/d7B604A7mnE7?=
 =?us-ascii?Q?CLcjxawvlZiggaQ4uiIMb2k0eY++mJvnf0JMo2bqMnKophtwwQ+S2wQQBc93?=
 =?us-ascii?Q?xXkOPOViElfwaQQqopzUV4LhkJgDuvp9uEx0Dmmz/sE7IObvklV4qJDuO6zh?=
 =?us-ascii?Q?wQeXjOUxl9TZx4B1U+2Q51Da/Szfv7c1hKzPJL46ST/GFPO5uNKXcDpfVkNl?=
 =?us-ascii?Q?e3ET6GF/lbadr81KOTpOVJtKq/34oOvtvZkmxR0Nai2ymelYTuK9R1cU1cUK?=
 =?us-ascii?Q?qY+BohpXnERTyuKKAMcmaaP5EUYbGmwYgRQgMIkPDmU5B64V/4YyZmdOxDRA?=
 =?us-ascii?Q?D/vP5rJnHficApQzF7ThPmC1FymaTYIUZa52q06uroDBczTsEHieWQ75a8Mg?=
 =?us-ascii?Q?U5+A/nTxEBvVlnn+mjn/lrHmRTvA6WYPt3fNO1WviIMxPSWN92uX9NjopgY+?=
 =?us-ascii?Q?kHE7Sd2JIRVoy0mTX33Wk+cPAxgWSOnG/qUsyomjY9JP/AxlcS8ATIGRCuxa?=
 =?us-ascii?Q?tCw5+GpknVAwR7rTYzXE/ElM4TtoV6WW9OpixV7psd/FJNUg7Lypypi8zELH?=
 =?us-ascii?Q?Tuob9+s0OY+wSUUWJSHd24IpTcTH9aeQBcTF9CLffDKWfUpRnFWJJ5erkFe2?=
 =?us-ascii?Q?gXCGwcOvC+ERScUyXtl95SEGZDfrYrEZecOgmXrYI0Pc27v3OnJEdTbvM4Hh?=
 =?us-ascii?Q?EDemAMT76KxftXMbfJkjlcfc6oGrQB4nIIoMgRRSasZtusDTui91Kj8/2INn?=
 =?us-ascii?Q?imgV8Y9J8aaq5EgycXjrvSoS2U21ft7C3YkWHH+wuIAyEkm2IwycPjPpkDAB?=
 =?us-ascii?Q?q4ppF6OAQAMs2yQnjcXYm/rq1R55/O8s3n9OwMoChmuODZYUy5NZcX5/p8KX?=
 =?us-ascii?Q?PH6X2GsVSsOv3zaeNkS4+e4ehbVfNYKCOzsG9AR88llNbdgZe8RcCkdYcn8t?=
 =?us-ascii?Q?Xrdf33uWEM5+qdHmqZ3tHdQJH4Bz+0FJvnj/tdeHiomXdInzdwox6MBzpRJR?=
 =?us-ascii?Q?p7NOR+MrnIEJHaH4J7AKPjFrWAq9Exh18+8AAt6kWSnb78k/XuAla3g1If/N?=
 =?us-ascii?Q?8cqVr+EmMto/fvhO6wspkEKBhHmqml2wKLTQJAS6rptTZUoTFSQgnNOsRrrq?=
 =?us-ascii?Q?rw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NsNoyXnFVMXYYIjLUCNgOrrv5ZkBmgPT1VkN9a+ASZ85TnVfF6DL5RYpXbUN7RGtnz1KVvlnI4dhfgtraWApm8qXtrAzInSmq8hr2EgNPzujhxYH3mJRK2DjILcF/WlnYHlNxoQRsKgmzyOlBNE47mYPae9+j8A10d97tdZB8E6BRi5mM+/6VOPqHUizOcMDsFkTbwsCDD/+906paqYaGn39sEQRkbrod9/1tnHwYfFVsjvzF2EoqTQ8yIHiUZA2bDDw/0X0no0Esqc0pv0edbANJpVetTODLynkz2++qh/MeBh0Jf4TpywhPBpFmNfc/QR74Qgs35JGPwtjgA2w7eodJcPgtPLhJAJVn/kFunLe6Q71vce5nl2K1j6tJGFN04y/uC+Ir4fMw8ooXl0ijGdVGmWwdj45t30Wz/Cg+Ztae5zYcLwhV9iNRtWC8Wh/pxMoEFBWrbyWbebecQno0H/MepaEEWdoCM9sU20jZpC/Q5gxW1D5AuovYDiYs6HGP4UCGRLNoIq4N5XHAoiwKcInnQcUBCMjkekB3sCnKobeifLNxEiPMP85zj2XM8BcQJhSqkwp4aFbpFgmd8YOcqYcUfc5Biq0+ZQde9CG504=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538b06f8-5069-40b7-f4e1-08dd4c364f7d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Feb 2025 13:57:10.3562
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JJX47tXa0KuQ5d7VzfV5gn8byVbBfUEpcZeVmrJoy2uE8M6+G0ZVAA7Yt2hd3q54V7WgaRu84/lxNT9HuNo4Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7125
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-13_06,2025-02-13_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2502130106
X-Proofpoint-GUID: t4dFG-irQCVNXU6XdJEIew8R-7fUON69
X-Proofpoint-ORIG-GUID: t4dFG-irQCVNXU6XdJEIew8R-7fUON69

In cases of an atomic write occurs for misaligned or discontiguous disk
blocks, we will use a CoW-based method to issue the atomic write.

So, for that case, return -EAGAIN to request that the write be issued in
CoW atomic write mode. The dio write path should detect this, similar to
how misaligned regalar DIO writes are handled.

For normal HW-based mode, when the range which we are atomic writing to
covers a shared data extent, try to allocate a new CoW fork. However, if
we find that what we allocated does not meet atomic write requirements
in terms of length and alignment, then fallback on the CoW-based mode
for the atomic write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/xfs/xfs_iomap.c | 72 ++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 69 insertions(+), 3 deletions(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index ab79f0080288..c5ecfafbba60 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -795,6 +795,23 @@ imap_spans_range(
 	return true;
 }
 
+static bool
+imap_range_valid_for_atomic_write(
+	struct xfs_bmbt_irec	*imap,
+	xfs_fileoff_t		offset_fsb,
+	xfs_fileoff_t		end_fsb)
+{
+	/* Misaligned start block wrt size */
+	if (!IS_ALIGNED(imap->br_startblock, imap->br_blockcount))
+		return false;
+
+	/* Discontiguous or mixed extents */
+	if (!imap_spans_range(imap, offset_fsb, end_fsb))
+		return false;
+
+	return true;
+}
+
 static int
 xfs_direct_write_iomap_begin(
 	struct inode		*inode,
@@ -809,12 +826,20 @@ xfs_direct_write_iomap_begin(
 	struct xfs_bmbt_irec	imap, cmap;
 	xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
 	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	bool			atomic_cow = flags & IOMAP_ATOMIC_COW;
+	bool			atomic_hw = flags & IOMAP_ATOMIC_HW;
 	int			nimaps = 1, error = 0;
 	bool			shared = false;
 	u16			iomap_flags = 0;
+	xfs_fileoff_t		orig_offset_fsb;
+	xfs_fileoff_t		orig_end_fsb;
+	bool			needs_alloc;
 	unsigned int		lockmode;
 	u64			seq;
 
+	orig_offset_fsb = offset_fsb;
+	orig_end_fsb = end_fsb;
+
 	ASSERT(flags & (IOMAP_WRITE | IOMAP_ZERO));
 
 	if (xfs_is_shutdown(mp))
@@ -832,7 +857,7 @@ xfs_direct_write_iomap_begin(
 	 * COW writes may allocate delalloc space or convert unwritten COW
 	 * extents, so we need to make sure to take the lock exclusively here.
 	 */
-	if (xfs_is_cow_inode(ip))
+	if (xfs_is_cow_inode(ip) || atomic_cow)
 		lockmode = XFS_ILOCK_EXCL;
 	else
 		lockmode = XFS_ILOCK_SHARED;
@@ -857,6 +882,22 @@ xfs_direct_write_iomap_begin(
 	if (error)
 		goto out_unlock;
 
+	if (flags & IOMAP_ATOMIC_COW) {
+		error = xfs_reflink_allocate_cow(ip, &imap, &cmap, &shared,
+				&lockmode,
+				(flags & IOMAP_DIRECT) || IS_DAX(inode), true);
+		/*
+		 * Don't check @shared. For atomic writes, we should error when
+		 * we don't get a CoW fork.
+		 */
+		if (error)
+			goto out_unlock;
+
+		end_fsb = imap.br_startoff + imap.br_blockcount;
+		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
+		goto out_found_cow;
+	}
+
 	if (imap_needs_cow(ip, flags, &imap, nimaps)) {
 		error = -EAGAIN;
 		if (flags & IOMAP_NOWAIT)
@@ -868,13 +909,38 @@ xfs_direct_write_iomap_begin(
 				(flags & IOMAP_DIRECT) || IS_DAX(inode), false);
 		if (error)
 			goto out_unlock;
-		if (shared)
+		if (shared) {
+			if (atomic_hw &&
+			    !imap_range_valid_for_atomic_write(&cmap,
+					orig_offset_fsb, orig_end_fsb)) {
+				error = -EAGAIN;
+				goto out_unlock;
+			}
 			goto out_found_cow;
+		}
 		end_fsb = imap.br_startoff + imap.br_blockcount;
 		length = XFS_FSB_TO_B(mp, end_fsb) - offset;
 	}
 
-	if (imap_needs_alloc(inode, flags, &imap, nimaps))
+	needs_alloc = imap_needs_alloc(inode, flags, &imap, nimaps);
+
+	if (atomic_hw) {
+		error = -EAGAIN;
+		/*
+		 * Use CoW method for when we need to alloc > 1 block,
+		 * otherwise we might allocate less than what we need here and
+		 * have multiple mappings.
+		*/
+		if (needs_alloc && orig_end_fsb - orig_offset_fsb > 1)
+			goto out_unlock;
+
+		if (!imap_range_valid_for_atomic_write(&imap, orig_offset_fsb,
+						orig_end_fsb)) {
+			goto out_unlock;
+		}
+	}
+
+	if (needs_alloc)
 		goto allocate_blocks;
 
 	/*
-- 
2.31.1


