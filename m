Return-Path: <linux-fsdevel+bounces-47393-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB4BA9CEE1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 18:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C335188C8D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Apr 2025 16:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 525AB205ABA;
	Fri, 25 Apr 2025 16:48:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="f8+qu7eS";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="O5RMfr6J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FFEA1F37CE;
	Fri, 25 Apr 2025 16:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745599703; cv=fail; b=WzUbCL4YIfKGywOZ3w0K/N21sWRZkQZrafV25anRhX7pdNPM1d/GRtS22P/swvP28S7U9uwuHWAgWu6jHjEy0ocA5nb0UVjOvYPpPr6FNG66ABY+NgQf4n3ol2MNOT3kIUd2RZ8NK98rRDJc6sffHO3Y9iFcZC1HswBDV/GJUtQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745599703; c=relaxed/simple;
	bh=LMpX8C8Ui+a+rloZh8nJ5YZBruJUwYX90q2MRK05DP8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=SN+rhLufgwrDHz5SRikD8JmhO0GAZixCwWiDqvu7alnW0wSnd43YJ/fpmJk6D5Z0UbJRgq/SLJZcqaG3L2rMfez8vqmONoT5MHdKudUln/ANjdzWNj41oNTbz9fC/AYmf3rtXS3KgML2/MIi/XfpG26qxfNLKcQnR95Qy+X45mw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=f8+qu7eS; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=O5RMfr6J; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53PFqVvZ008392;
	Fri, 25 Apr 2025 16:45:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=HyIZAqpO9OlgNvAlTLIS3XO23n2SyAVEO8JDPB21/Sg=; b=
	f8+qu7eSeVei12ZzXDWz/mJjveP6syKb6bXO1a29YzelEVytPVjY/UFnpQACeRpu
	8Ehnp5L4mvRWpNyUUMk+LAoxo2p8Lx+Kdq3qPXoSRsyMjP0e9a/vjqV1KCIrANML
	47zoPkCp9MMcmUJmjg3UIWiBnMo8A1XUvkqVMsb7KixA/Ry0UZ2rRYAwAnpBMlqF
	82uCJU+Om/LQJrYu7rGZJ+YURq0YakINPgdSkdI2pWXuP7ac0+KW4ZaBhU4Lssnw
	9YSKHEC0ApRj1Kbqwo+mOcIpZDhxgbLTHE8vurMhnFrSXJVOsxQMKLqTZYcGuc/u
	O434C9/xagZMYuy2borRHQ==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 468d45r9ff-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53PF4l1j013866;
	Fri, 25 Apr 2025 16:45:50 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazlp17013079.outbound.protection.outlook.com [40.93.1.79])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jxrvdbm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Apr 2025 16:45:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nsoTtVRH+U0Jx9sdyJjbCuNUg91kQneyK72U+EVjFj7okkrDjnEKrByaxT5E/b+YG0y0z5iqh3x48jw+e8/gq4AfpwvCGgdntdazLPM65L0UIYqare0L6yypUjG8a00C8pIMfo3iKd6a2UEEtm1kHRZjGRBf97SNd+5sSTmQ3tpN9lq7MTQnC19n++qlj1X9rghd3P/TP6SDpuOczGUojLxeaGAxYO6v5UuKBwxSHDjGnNARrkGUvMNGfCFa15SICul05lVeT5+5AQjY2aFhk1lJ+ipXX+VA3PjPPtawF4YuhDgM1RYdNy15DWZxKgzGAIXbbMvVUFI9cdCoDPG9tA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HyIZAqpO9OlgNvAlTLIS3XO23n2SyAVEO8JDPB21/Sg=;
 b=OlMqwIN84xvgYZIbvtK9t8CaY9Nua+RY1ct8IxE1W31fwo/hcfaMSqskXcJsbtEnOuEU0OoTs5cJbGSx400SzGd8j7LOTr22dIWBfiFP0quCX8Bq9jhwqhFre6sNGsgj0ZOTcKxgKpTAewhBtRkArLhcIjtlmGlK8uvn54qQF/zwpjyxVDKAt8uToCV44OSy6a/zyTJv2QmYiz9/6rjFsTrSXMA4xFkouV+QGiueTtaaW91AT4Vn2EJ1sn+qbCob7DQJJIwWld86ucAC5IFxMvkeCBdppNgiuY/mZq1indVmKZkfq3z2f/WQnxa9XCtpqi3vJgA8nw+G0IItLQjMiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HyIZAqpO9OlgNvAlTLIS3XO23n2SyAVEO8JDPB21/Sg=;
 b=O5RMfr6JIXzwtOm3z3daaN6cKowFeb7b79fmndpgEqpjzI35UK18aFJWQPAg0nuaUF6tKlCPtlrjqJzvWaMGcpPe/nvJWMGXxJXaRE3j+2arI96jR0NbpXZy5hElkrLUaNkASvgdN3H29QnEsZGsQ3IOHWBoc6e4Bih2HiXl2jM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH7PR10MB5699.namprd10.prod.outlook.com (2603:10b6:510:127::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Fri, 25 Apr
 2025 16:45:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8678.025; Fri, 25 Apr 2025
 16:45:48 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk,
        jack@suse.cz, cem@kernel.org
Cc: linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v9 09/15] xfs: add xfs_atomic_write_cow_iomap_begin()
Date: Fri, 25 Apr 2025 16:44:58 +0000
Message-Id: <20250425164504.3263637-10-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250425164504.3263637-1-john.g.garry@oracle.com>
References: <20250425164504.3263637-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY5PR03CA0013.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::23) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH7PR10MB5699:EE_
X-MS-Office365-Filtering-Correlation-Id: bb83c878-8df5-40c0-83c7-08dd8418a16c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8MVYQHy4OYn3CvUzJJS0jaRAXR3DdYnwkxu5AOzTf8tnjBVOfOefvDa5pxlR?=
 =?us-ascii?Q?AGqJyNftAy4xS3sQ59zjPU5up/ZYCknn2jxK2AxiDzvyVcFyjVHYR0kl5oQb?=
 =?us-ascii?Q?lPDFXMYY70l7N8g/PaDYOBYX8ZRE24gkQ9N4t95309XeOuYuVYEtLoR4gUNd?=
 =?us-ascii?Q?8uaY1OHODMcKtdxXWMXvQH7csL/gpnmv3Y5GNda7cnY1Bj0C7Xrut1VDRf/h?=
 =?us-ascii?Q?bDBL5+7A5INlBFr06HeZx4hXCTbQ6LWCR3QX0ahQ3Typ7iqEqV7uhmvT5fGx?=
 =?us-ascii?Q?sJQ+AHWyDPEMp70ZRrjGVDZ+r/Ow4jREIeKXWnClbevU7MEkCcy6uHnpSIYV?=
 =?us-ascii?Q?FFadrBc05Xl4QL0kU0c/9NDmJE7tXjnpIy+l81TVJdS7Msq/qODPD+wWdt1q?=
 =?us-ascii?Q?907SKtHkmyfFDCrg8xUJvFdugW7JtN/A4mwEAutv1T8RIG7dLTSa5DAulEX7?=
 =?us-ascii?Q?rFFYkjnIkhdC173vftAySIfDVsXdMeC7DrGkaMHNHVvQMbTrYhv5Wf3E96ea?=
 =?us-ascii?Q?kvT7MoeT8kW6qoCULEeZdpEY4uz0o282HKYverPJ2I8gi3Bg3KnTY7CK7oHD?=
 =?us-ascii?Q?Oi5OHAryJM9TtZHZQvQHRXRRF5wHz56IqBHit5HXoj/D0r8pMBrPmkaJ9evY?=
 =?us-ascii?Q?DTc0QpORID6sTp6HElBD7l7G4XidNdo9g0dZFyFBsnvtz3F2sVGLR+gX9Db0?=
 =?us-ascii?Q?FTmtbumE8ysgvvF5er7gHc9y/EfUKSSln4pzdLDtKWzSwz7cu2u9q45S9cKB?=
 =?us-ascii?Q?bOAh8xg+DqNRytjQOk4hf2bftAA89CBMz+XXu9iRXEL2bg5hncCsFM299WqB?=
 =?us-ascii?Q?3+XOs7GOxidNp89tJKflsFdXZi6oDP7DZUXbnYF3Rbb7Y/MSe8nrSObJnZdr?=
 =?us-ascii?Q?0iaAUds/JBsU0lwsW/7tsIeNVz61gGMkFtBvGImgSuRjR7TgAiOFQNFl5lqX?=
 =?us-ascii?Q?OWb0N/TJb5M0WMHyGpq6HOKJ9gv0GP3zgL15UpIo36qK09qkeLrY8Ot/CA5/?=
 =?us-ascii?Q?EF2rpPnO9lmat69yxwz9DHJq3U4Mb8yXnP/YbHzKmpLmdybEEuJWbrlYiBBM?=
 =?us-ascii?Q?I69OXGs+hh3yqJWANVeLkC2hB6RsUblkj694NLPPYuLi7fLGCCLJXvTC81Jo?=
 =?us-ascii?Q?JZleD3ioXA5fdGwkUgcafIyRNjxzjHHLtNIRIDtYqvbF6HEf1L8jncMGp0ty?=
 =?us-ascii?Q?vWVjeJ/DshquQI1JEhHLO5syoO9Q+95ogiIxT894XdBM2qcb//x6OLvpE138?=
 =?us-ascii?Q?DyP2O+1qr3ewYLy+G+xKAIpGcOnNjrnR6KhdyABp9z4THTiXGou21UZLJOjz?=
 =?us-ascii?Q?4RbQrf56wBey/gwFrXeWx08lDCZE6DhByy9a2fNrgPs/O0huKPkf8HECWIDB?=
 =?us-ascii?Q?Jpdgx6+MFCjgOdWHMbjShUKur8M1EvFN7FdrC+PeCChGrEJs62i+0UbUWfdy?=
 =?us-ascii?Q?meDac2mnRt4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?v31ZS3ej30d4DujlsHgXTF6c/KhshQz+oRsEFq/xruoQvRLFa4zH2/B2uWFU?=
 =?us-ascii?Q?VDoSSJoOATNV5MDwhuti50vIgsi07/zUqi3k3hrTe5sk4/PcfEGkjrKQnz3J?=
 =?us-ascii?Q?M0bGUkVeqj+IE5GOlYb0AhioMgagEdpkhLXYE6FuzIKN149ywW3Oi3HZVsrt?=
 =?us-ascii?Q?aV8OVYmtb1NNUXXfs+Ix8Fzw2I8VMcXxCxUlk0nVmbBiXvI7A1XpT8x/X13n?=
 =?us-ascii?Q?0/68nzdfJOvz4sfcYH8Y3+wXRxxtDUCjHbTLBf0MPaNGIeIcUTq9W66KFIdk?=
 =?us-ascii?Q?CfIQ2IW9oWvBm9nqur4wBw9SFeqSL4fSZfk2mpf3nikY20eJ3qv7yfYU/fBv?=
 =?us-ascii?Q?BTawZS4QLL4etL5wGtCuZRHdEnFb8sPn2dJrPWAJ2VUvgT6MJCu3bLd41W0a?=
 =?us-ascii?Q?DXQ4Bob1nJlQ7mV/EZSEZTbBDak8kpWfOpSwQdZlzZg//JFCtvzCgFnETgX1?=
 =?us-ascii?Q?tdYYcxpPYHQHEddlxVoist8+FSkCEATbF3Fjp3uTZ75JbC4lw5fe1fkbnVCN?=
 =?us-ascii?Q?2ZSYwnOtagu+gBmmMtMJE8O43cViCRq3OVzzNQ0B8nOQJgXStErqOHKV3rLy?=
 =?us-ascii?Q?221jMe+qkkIHAWi0VoLlFRDJya4aW+m1W5pfXs+1/32Hn7ZE70q5WgV/rcJj?=
 =?us-ascii?Q?zFRk8cT1UVaam2MruYSa16brhp3owyJjQPuCxAq/ea3DuKY0e0rIsOWWB3XR?=
 =?us-ascii?Q?vfU4PFxQ0ghnF/nRFCvlSttvOgvf6txLsAupTjKADvNig+WOTb+m5OOsyAkQ?=
 =?us-ascii?Q?6mY55pCcIHp6B5qd2HZY9s34/VREmSDi25ECl1/kabQRfhtIcTATXLNTo+xg?=
 =?us-ascii?Q?zvcs1FSkrRYECFR3JKnS+XIWr2w4Gv4VQEe8NRH9fFwUuoAG9Dkt9dRFFl91?=
 =?us-ascii?Q?9z/CNvNpgjC9UP7S/8JuqJss5Z3SPZYl3uYG1qtko0QZ11Dx5Z6fYyXWQLcy?=
 =?us-ascii?Q?wblelEoDRa6h1Mk6ZzeAY6VyE8d8CdQI5rfLJbYv1gpGLoTq8s2hs2bZ/5WE?=
 =?us-ascii?Q?mcDw7melu6gU6iUCHTRcklfbisgLMcnefv8HfLgdOKePeTnhU2DQE7u6kE6o?=
 =?us-ascii?Q?m9g2QIPaOCZOVphwVtP789uZkKb05Ohdq9OubnGCnDGcBAvyQR6hYZcUQ9Rx?=
 =?us-ascii?Q?MqxYVt/dzz454scX0F2ixVeQlg46x8Ar/cdP5Ka41+E/yeIjjrRXg9AKMKxh?=
 =?us-ascii?Q?vpPTck+nMqQJkmUtpHq/1yj2OMNaVe1uU3YRQhDJ+z9kBmdwjqN72LlgcEsT?=
 =?us-ascii?Q?PLW44CZIq5s/PZ4C58ZpwJUMayoxYH8+7nxV3ZPDqLCx2b3vSSfmM12GCIiP?=
 =?us-ascii?Q?NwR76HWyTJcIjToCOcjEyfFQONYIfESJWQ4EUPMRzN59cMTBF+qsc2x5fn9O?=
 =?us-ascii?Q?auyHh0gqMVp8eH6WmXB0qK9BodP+Em17xj8sA2Jfbs1X1OyyvlwYnkPjSRVV?=
 =?us-ascii?Q?6S++1zldF5IlypAAwNpnN2XK9QuG6FUws9TFFYCt/Zj+IMbn34Fp2bS1uUAK?=
 =?us-ascii?Q?5lvVkeIAfiTs/Z7U9ibqeDhJdFtifPVHGElOTvXfJcBkKG6BP1RZ4vobs64z?=
 =?us-ascii?Q?N28DSq6ZzTNundJH6kqI1ttabBM7uR5PzC0MInl9aKE6P6xWmTt5TDJgdHUN?=
 =?us-ascii?Q?3Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mkLaUtO3KCxWShHmw9y6r78s0/QjO/Le8Q/zz0q1OgPHeUU7wHKUtsFq0/Qx2gLSqEaUxYeSLO4+Z9QKrlVyzEVnNpKYXwx+MM9zzlPDLMWU2K7aFNosq5MWP/Ld1UcM9P9e40Yce6fOTqXdWF9BXoUz6TfGfLv6FzRtxLCVL8HrqDDZCs41LcW2eNZ5kEoE/pp/cx6/2Ha0N6SEolSAJUOnaUa2vyMgIjkrhV0iljtnxGB5ITwKhVB2h9D0L/n7VTm7tNRoaEnu2OlHebxA6VAnRYFqtcGr0ct7x5dJmibdzUPGvjtE7B9JtOswTnZje3aTWtS2EHWuIlsivnlqh+I31NG7wbeNVx/QBuQdsR3GCEL4hejfu2xlO0Uk+OOq6Cx+inXjrQR31HZ6c23CmEi0/ezpew5iGMT2IDxhS9wNGtMsvO6XsN20oOX2UVgfhKkQS/eRZE1Bptm+HpStPvLURklPRPSunprysGFwuqpkHH9rYCOsd4I1EN/gjMjRtCzA+7Uc7rYCcKLS7LRP8ivgj2HS2akRpEpNnGSGE1SbSz+eODmD8EKS4ZeS6WvaiS1w/DJekaAkftcO3RlV93IcGrMY4+rbRW+9uBvccaU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb83c878-8df5-40c0-83c7-08dd8418a16c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 16:45:48.0641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDhKrBVbVrgV0QWKQFYNyVHf3kJEfwmyHNMnNIk+A46HgnQBkHmAJjeaFLzIzDncWwKoJnkHCmugKaCLkmNnaw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB5699
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-25_05,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 adultscore=0
 phishscore=0 mlxlogscore=999 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504250118
X-Proofpoint-GUID: lPdB-G7pYF3A0p6aumdcR1SWrEV5Bwrh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI1MDExOCBTYWx0ZWRfXzHMEwo+9xoNJ LQG54piA68UurZTI7jsUkDEfBJdpTx9jELdkMKMXG11GcKi9nk/LI0nojCX97scfjhNHwF8JAFx OEWTVcNOaGGWw+yN/vwfzBP5lqof/JOz+1Wj73UQmCZarbRsm1qW/LBCZaa4ofQxMzMRZLkdjMb
 hmeiOV5KRZ6FU0sZ+HO1d/CRfy7KGEX3Yo4+P6MFS2JdPd9AaKoT03rILSBZQGNrtfkRRHuxkSp voeyy8D8KzKIDb1FYY3NKyU8561oInOBYMCN6YjxL54gJXOIVZT/At9D2oxBP4WiIZa9oHs9Urn OfZYNodZbTLIvdlpSDH8+xFcQAN3bbeuvQ/OmfK7sP4yPe/qI/3cOs/qQSPhqVfh1tJZXUM0Y2A p/I68Q2c
X-Proofpoint-ORIG-GUID: lPdB-G7pYF3A0p6aumdcR1SWrEV5Bwrh

For CoW-based atomic writes, reuse the infrastructure for reflink CoW fork
support.

Add ->iomap_begin() callback xfs_atomic_write_cow_iomap_begin() to create
staging mappings in the CoW fork for atomic write updates.

The general steps in the function are as follows:
- find extent mapping in the CoW fork for the FS block range being written
	- if part or full extent is found, proceed to process found extent
	- if no extent found, map in new blocks to the CoW fork
- convert unwritten blocks in extent if required
- update iomap extent mapping and return

The bulk of this function is quite similar to the processing in
xfs_reflink_allocate_cow(), where we try to find an extent mapping; if
none exists, then allocate a new extent in the CoW fork, convert unwritten
blocks, and return a mapping.

Performance testing has shown the XFS_ILOCK_EXCL locking to be quite
a bottleneck, so this is an area which could be optimised in future.

Christoph Hellwig contributed almost all of the code in
xfs_atomic_write_cow_iomap_begin().

Signed-off-by: John Garry <john.g.garry@oracle.com>
Reviewed-by: "Darrick J. Wong" <djwong@kernel.org>
[djwong: add a new xfs_can_sw_atomic_write to convey intent better]
Signed-off-by: "Darrick J. Wong" <djwong@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 fs/xfs/xfs_iomap.c   | 128 +++++++++++++++++++++++++++++++++++++++++++
 fs/xfs/xfs_iomap.h   |   1 +
 fs/xfs/xfs_mount.h   |   5 ++
 fs/xfs/xfs_reflink.c |   2 +-
 fs/xfs/xfs_reflink.h |   2 +
 fs/xfs/xfs_trace.h   |  22 ++++++++
 6 files changed, 159 insertions(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index cb23c8871f81..166fba2ff1ef 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -1022,6 +1022,134 @@ const struct iomap_ops xfs_zoned_direct_write_iomap_ops = {
 };
 #endif /* CONFIG_XFS_RT */
 
+static int
+xfs_atomic_write_cow_iomap_begin(
+	struct inode		*inode,
+	loff_t			offset,
+	loff_t			length,
+	unsigned		flags,
+	struct iomap		*iomap,
+	struct iomap		*srcmap)
+{
+	struct xfs_inode	*ip = XFS_I(inode);
+	struct xfs_mount	*mp = ip->i_mount;
+	const xfs_fileoff_t		offset_fsb = XFS_B_TO_FSBT(mp, offset);
+	xfs_fileoff_t		end_fsb = xfs_iomap_end_fsb(mp, offset, length);
+	xfs_filblks_t		count_fsb = end_fsb - offset_fsb;
+	int			nmaps = 1;
+	xfs_filblks_t		resaligned;
+	struct xfs_bmbt_irec	cmap;
+	struct xfs_iext_cursor	icur;
+	struct xfs_trans	*tp;
+	unsigned int		dblocks = 0, rblocks = 0;
+	int			error;
+	u64			seq;
+
+	ASSERT(flags & IOMAP_WRITE);
+	ASSERT(flags & IOMAP_DIRECT);
+
+	if (xfs_is_shutdown(mp))
+		return -EIO;
+
+	if (!xfs_can_sw_atomic_write(mp)) {
+		ASSERT(xfs_can_sw_atomic_write(mp));
+		return -EINVAL;
+	}
+
+	/* blocks are always allocated in this path */
+	if (flags & IOMAP_NOWAIT)
+		return -EAGAIN;
+
+	trace_xfs_iomap_atomic_write_cow(ip, offset, length);
+
+	xfs_ilock(ip, XFS_ILOCK_EXCL);
+
+	if (!ip->i_cowfp) {
+		ASSERT(!xfs_is_reflink_inode(ip));
+		xfs_ifork_init_cow(ip);
+	}
+
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		goto found;
+	}
+
+	end_fsb = cmap.br_startoff;
+	count_fsb = end_fsb - offset_fsb;
+
+	resaligned = xfs_aligned_fsb_count(offset_fsb, count_fsb,
+			xfs_get_cowextsz_hint(ip));
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+
+	if (XFS_IS_REALTIME_INODE(ip)) {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, 0);
+		rblocks = resaligned;
+	} else {
+		dblocks = XFS_DIOSTRAT_SPACE_RES(mp, resaligned);
+		rblocks = 0;
+	}
+
+	error = xfs_trans_alloc_inode(ip, &M_RES(mp)->tr_write, dblocks,
+			rblocks, false, &tp);
+	if (error)
+		return error;
+
+	/* extent layout could have changed since the unlock, so check again */
+	if (!xfs_iext_lookup_extent(ip, ip->i_cowfp, offset_fsb, &icur, &cmap))
+		cmap.br_startoff = end_fsb;
+	if (cmap.br_startoff <= offset_fsb) {
+		xfs_trim_extent(&cmap, offset_fsb, count_fsb);
+		xfs_trans_cancel(tp);
+		goto found;
+	}
+
+	/*
+	 * Allocate the entire reservation as unwritten blocks.
+	 *
+	 * Use XFS_BMAPI_EXTSZALIGN to hint at aligning new extents according to
+	 * extszhint, such that there will be a greater chance that future
+	 * atomic writes to that same range will be aligned (and don't require
+	 * this COW-based method).
+	 */
+	error = xfs_bmapi_write(tp, ip, offset_fsb, count_fsb,
+			XFS_BMAPI_COWFORK | XFS_BMAPI_PREALLOC |
+			XFS_BMAPI_EXTSZALIGN, 0, &cmap, &nmaps);
+	if (error) {
+		xfs_trans_cancel(tp);
+		goto out_unlock;
+	}
+
+	xfs_inode_set_cowblocks_tag(ip);
+	error = xfs_trans_commit(tp);
+	if (error)
+		goto out_unlock;
+
+found:
+	if (cmap.br_state != XFS_EXT_NORM) {
+		error = xfs_reflink_convert_cow_locked(ip, offset_fsb,
+				count_fsb);
+		if (error)
+			goto out_unlock;
+		cmap.br_state = XFS_EXT_NORM;
+	}
+
+	length = XFS_FSB_TO_B(mp, cmap.br_startoff + cmap.br_blockcount);
+	trace_xfs_iomap_found(ip, offset, length - offset, XFS_COW_FORK, &cmap);
+	seq = xfs_iomap_inode_sequence(ip, IOMAP_F_SHARED);
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return xfs_bmbt_to_iomap(ip, iomap, &cmap, flags, IOMAP_F_SHARED, seq);
+
+out_unlock:
+	xfs_iunlock(ip, XFS_ILOCK_EXCL);
+	return error;
+}
+
+const struct iomap_ops xfs_atomic_write_cow_iomap_ops = {
+	.iomap_begin		= xfs_atomic_write_cow_iomap_begin,
+};
+
 static int
 xfs_dax_write_iomap_end(
 	struct inode		*inode,
diff --git a/fs/xfs/xfs_iomap.h b/fs/xfs/xfs_iomap.h
index d330c4a581b1..674f8ac1b9bd 100644
--- a/fs/xfs/xfs_iomap.h
+++ b/fs/xfs/xfs_iomap.h
@@ -56,5 +56,6 @@ extern const struct iomap_ops xfs_read_iomap_ops;
 extern const struct iomap_ops xfs_seek_iomap_ops;
 extern const struct iomap_ops xfs_xattr_iomap_ops;
 extern const struct iomap_ops xfs_dax_write_iomap_ops;
+extern const struct iomap_ops xfs_atomic_write_cow_iomap_ops;
 
 #endif /* __XFS_IOMAP_H__*/
diff --git a/fs/xfs/xfs_mount.h b/fs/xfs/xfs_mount.h
index e5192c12e7ac..e67bc3e91f98 100644
--- a/fs/xfs/xfs_mount.h
+++ b/fs/xfs/xfs_mount.h
@@ -464,6 +464,11 @@ static inline bool xfs_has_nonzoned(const struct xfs_mount *mp)
 	return !xfs_has_zoned(mp);
 }
 
+static inline bool xfs_can_sw_atomic_write(struct xfs_mount *mp)
+{
+	return xfs_has_reflink(mp);
+}
+
 /*
  * Some features are always on for v5 file systems, allow the compiler to
  * eliminiate dead code when building without v4 support.
diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
index bd711c5bb6bb..f5d338916098 100644
--- a/fs/xfs/xfs_reflink.c
+++ b/fs/xfs/xfs_reflink.c
@@ -293,7 +293,7 @@ xfs_bmap_trim_cow(
 	return xfs_reflink_trim_around_shared(ip, imap, shared);
 }
 
-static int
+int
 xfs_reflink_convert_cow_locked(
 	struct xfs_inode	*ip,
 	xfs_fileoff_t		offset_fsb,
diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
index cc4e92278279..379619f24247 100644
--- a/fs/xfs/xfs_reflink.h
+++ b/fs/xfs/xfs_reflink.h
@@ -35,6 +35,8 @@ int xfs_reflink_allocate_cow(struct xfs_inode *ip, struct xfs_bmbt_irec *imap,
 		bool convert_now);
 extern int xfs_reflink_convert_cow(struct xfs_inode *ip, xfs_off_t offset,
 		xfs_off_t count);
+int xfs_reflink_convert_cow_locked(struct xfs_inode *ip,
+		xfs_fileoff_t offset_fsb, xfs_filblks_t count_fsb);
 
 extern int xfs_reflink_cancel_cow_blocks(struct xfs_inode *ip,
 		struct xfs_trans **tpp, xfs_fileoff_t offset_fsb,
diff --git a/fs/xfs/xfs_trace.h b/fs/xfs/xfs_trace.h
index e56ba1963160..9554578c6da4 100644
--- a/fs/xfs/xfs_trace.h
+++ b/fs/xfs/xfs_trace.h
@@ -1657,6 +1657,28 @@ DEFINE_RW_EVENT(xfs_file_direct_write);
 DEFINE_RW_EVENT(xfs_file_dax_write);
 DEFINE_RW_EVENT(xfs_reflink_bounce_dio_write);
 
+TRACE_EVENT(xfs_iomap_atomic_write_cow,
+	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count),
+	TP_ARGS(ip, offset, count),
+	TP_STRUCT__entry(
+		__field(dev_t, dev)
+		__field(xfs_ino_t, ino)
+		__field(xfs_off_t, offset)
+		__field(ssize_t, count)
+	),
+	TP_fast_assign(
+		__entry->dev = VFS_I(ip)->i_sb->s_dev;
+		__entry->ino = ip->i_ino;
+		__entry->offset = offset;
+		__entry->count = count;
+	),
+	TP_printk("dev %d:%d ino 0x%llx pos 0x%llx bytecount 0x%zx",
+		  MAJOR(__entry->dev), MINOR(__entry->dev),
+		  __entry->ino,
+		  __entry->offset,
+		  __entry->count)
+)
+
 DECLARE_EVENT_CLASS(xfs_imap_class,
 	TP_PROTO(struct xfs_inode *ip, xfs_off_t offset, ssize_t count,
 		 int whichfork, struct xfs_bmbt_irec *irec),
-- 
2.31.1


