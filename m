Return-Path: <linux-fsdevel+bounces-40738-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BC31A270D3
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 13:03:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FB43A5B21
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Feb 2025 12:03:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAEB211494;
	Tue,  4 Feb 2025 12:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="S7SrDJcv";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Eil4EH9B"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8320DD7B;
	Tue,  4 Feb 2025 12:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738670536; cv=fail; b=omnmUByL/UfZrIf2IQGCNN6isqkNgckVQyS6TtG6/GEjmZEVmPUktiP8qyZtmMR6HaXHlLvTXznVxL90blBOyR0keBK5nRZf3rJNTWO/+Gwadb+ePFduaCVLmVRqA3r+w3X/GxSv0dc3IiuDkfW/mF2LYST79NVMF4Z8fXwZBE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738670536; c=relaxed/simple;
	bh=I+3y2WX76jcSbkopRcOCaoiR1i7aktuR2wNooxmEmFs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=luoAP6D0JyuRGTLOciisjN7Md6rZCHCLh1gahkfhdsurp4Zf1/Hqefz9Kp6fIeoEC6t+yWmtwZt9wW83rxWpjQKb1JEsr5Yx0fwTDXvJVB8gsJ5ONI5OWvUX6MCyYxCNvEMKbZA2kqvuMKcb8fu0pLlXhC2XHEMmdRcIrp3NYgA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=S7SrDJcv; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Eil4EH9B; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 514BfgQb011187;
	Tue, 4 Feb 2025 12:01:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=6HM2aeNeWSn4BRDpOA/EfiMomlNorF+UAPSQcVaDLxw=; b=
	S7SrDJcvrh57VnVPgxTkutdBcjpq0D4UH938jprPciM2no2GnJUa1/RTJ0Q00iO5
	QMtSAXDnxrrjJRlxJT6c1gHrLkJ2ijqgXZ5/vctER4IBe/Z3DGJ7+yjNSDDO6SO7
	JKdg99oBIgiT5cFhLBDAxVUA8urN+Gzl8otMDFiLbHnM8/RWzRzwXOMDBj/aYRWg
	n5m+f40oLFbjFsF6DwfqJ/h4NLn69jzZ1ECuQU5fjNzTJqiVlQaSQXgxT/lXdCmn
	KLYlU459aqDsKKoLvqzXuSXQq+iT/bPbasZwZ98Ktin4uVQw95U0l1vx4FT0mXzp
	GPXSqD9WNz+XgvJh6vp7Lg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44hfcgvruf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:49 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 514BA7w8036476;
	Tue, 4 Feb 2025 12:01:49 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2174.outbound.protection.outlook.com [104.47.57.174])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44j8fm3ygr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 04 Feb 2025 12:01:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kX9kWGiYighXDiEpyUajeYhR8Mq0tye2tFwUl0vd6LluTOBHZnWPpoj4VIFyBMwKjr5e0UJKxtWWKlCf2B41XRhOJrwsmyBi4F8QK9pcavaRVLJ6v9fKqsS0A+McU8xf8EKpUQE80eYouidxRB7aoCtUi/DKB44Yy8jBWwi4yXjXDgJSMMbZV7fKXtct3AX6Rs0kY8H4l0IIg4L6MM2t0qZ6sN0FCNTq/OYOCbhjppNffn/VR/5KEkomAJme2J2V5ISOzVfFQJ0//b68+plggfUkMX8D7Xwuxa//nVeo47M+tKnC1CGRJJjfB5o3EJ0793B7Dmr/OgY+E7MT7eU5pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HM2aeNeWSn4BRDpOA/EfiMomlNorF+UAPSQcVaDLxw=;
 b=zVrUR3e2EExX7WD4Aymjp8lDS/wOr9IxrbqngnMHOfYOT3RqzyqKBg0Eyb3lmks2b9jd9lahgdcAuUT7RKn+VeUkZwOPnZqpczrIALO0awlF83olYZWLhhNzTE9gepNHn2WD6H+6l09iB53leICFyEmlf5bQlSmAzw9mAmmD0WHwjksrMGZzAu1/obFY+hWMq75pJ48D7BXnLAyjZ6o9KXbdETy8QmCu/3hmxClUdYvFYG0YFvrRECOGWLSTr1FcKnIAIQuu/g/Sbrh4PiAYiA/RujJ9UnOD25s4Fdm9dRVJMHCrggSrzZsXZFylo0kFJ/rfs7Jt6kgxzl0nhlSg0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HM2aeNeWSn4BRDpOA/EfiMomlNorF+UAPSQcVaDLxw=;
 b=Eil4EH9BFwPpW0LxPgp8GCPhoYxI6nm5SUsEoRW6tFmgJRMnbgBwo1RGpUlrqen/zTw75rpmlXNzDjCddDqs2h4I39F1BSeUS28U8Aq8Kgxs153u7vMyh/92WYt5EHjXdBpsl2VruydWIsUzalDpAiuha91aZybfSEpYeKX4y90=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7648.namprd10.prod.outlook.com (2603:10b6:610:179::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Tue, 4 Feb
 2025 12:01:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8398.021; Tue, 4 Feb 2025
 12:01:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: brauner@kernel.org, djwong@kernel.org, cem@kernel.org, dchinner@redhat.com,
        hch@lst.de
Cc: linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com,
        John Garry <john.g.garry@oracle.com>
Subject: [PATCH RFC 03/10] iomap: Support CoW-based atomic writes
Date: Tue,  4 Feb 2025 12:01:20 +0000
Message-Id: <20250204120127.2396727-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20250204120127.2396727-1-john.g.garry@oracle.com>
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MN2PR07CA0003.namprd07.prod.outlook.com
 (2603:10b6:208:1a0::13) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7648:EE_
X-MS-Office365-Filtering-Correlation-Id: 42260a8e-ce14-4ecd-1d07-08dd4513b2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7Ifvwb5yx7otd+/twHh7Zm7Ex1YWC127HBKWbCqkgsJAM0SlIFSr4kQJYzRE?=
 =?us-ascii?Q?CJfnSF/Ujsf/z18cUn4GekrOzXCF4s+0DiZhZCNSIWGtLdcE1Qjrf2nPBWyJ?=
 =?us-ascii?Q?D145chg4PCUH2HQjX/4RQxE7tVAQQyOVs5th9gk8nTOf34/uI1oDR4rIm2sB?=
 =?us-ascii?Q?GhSG+7mgRTrsPv7K0xWDM6aVwtD3LZljzjWOwrzqxQbSe0yWRR+oiiMwdCPC?=
 =?us-ascii?Q?rbRHpmlZHY8XSy1G1Rdnb3nbfZervRw8bG8OSCgcRCJnV3WJ1duWjXDiR61i?=
 =?us-ascii?Q?S2NyJWanU2co13kDnpvDoex0rZi4rebAj9AtH/1Bn6Y4BwZIHCKlsB7QlllH?=
 =?us-ascii?Q?blhb87CbUoczo3P5YPqeY24eQxkXopWMyVxpoFF1PPjk+jFV9O1tS8T3WNSu?=
 =?us-ascii?Q?WiwBYi/0yjQpQbnyjR7QmOxiOPWdIwu1azSiseF1KQ2L8yu0XSgqByLnCbRJ?=
 =?us-ascii?Q?gO1X2qWvDzbYIvClx+pG/RfUCg0Xni54Gx4HYA7MOgEQay0xpwdZrq/pDf9l?=
 =?us-ascii?Q?IXjs+GZBbhOwiEJY2Xjj87KMdHFGCE1pS3SXgXfEO8S5RfgkjhmSQpa8eRdu?=
 =?us-ascii?Q?qxQM1BrrPOj/8ru642s2/ntSbktlAh0LU1W949SwrOmR8ETJndkX6SI7XrN3?=
 =?us-ascii?Q?mfAHRGO/NgZ8TgZ6qeUjs/tfBIhZRN/XiS0GHSKzuEKfSkDvRMgxSdJzIqqd?=
 =?us-ascii?Q?IrV4deAwUgCbT8jb2SCnMWxVI1wUZR9l2+wDaRENjG6jcKuoZNFSu4eFl5HH?=
 =?us-ascii?Q?nZ+dDjqSgZ/vbxSwjvfSXbsej0qVUvGpWMmu9yJ/sLuBhNwkI30pOIM1QLDE?=
 =?us-ascii?Q?wV4HnVwZDCNLYlD8zZHL188cD14SPI93c6rNmR0KDLGpApCQgvHhHW0oZn5i?=
 =?us-ascii?Q?SWvKwJaUuPa6t+SM6XMMHqDi/ffs6eeErGfIYn51G7Ejha1O18ivHtxCqXl6?=
 =?us-ascii?Q?LTel+EJqVjOgSKsgSpjjE7XeGSjmXsJYmzky3o6fjMVLKlv/mrxyFi0nJuCW?=
 =?us-ascii?Q?7eARdQ3qQ5Rjp6aLLGnN06H30c+ONYndjVK07cmDwSRMyN4WmEfdC9zDN+Nh?=
 =?us-ascii?Q?vkJyIdzw6DRMesq3WNyx2UiOtAIpHGXOdmh6ljvAP3enaytuMJUTmEUotfbV?=
 =?us-ascii?Q?rQqdg/9SUV1vVza6rFaNkeIks8gXEAtXR3HId7fQYI4hYVMU81fFinjEwFhK?=
 =?us-ascii?Q?yfV7my1f/wTvW2oT0lWh+atCgAyx8T8rNvzIGem/c+l5l95u8CXKqhz4Ii1Q?=
 =?us-ascii?Q?ifaYOVyI+sf6z4dUZd3OQSyDvhRUWeSnm7JRTrzuw1eJNnfqXTNnFukGvahN?=
 =?us-ascii?Q?T5IkULBc3YSYuXeQZpBBxlfPhNwLzufTHYEeWlAFRDyBBWFsQx8t1k8xlYtP?=
 =?us-ascii?Q?L4Z2TyQtJngtXx0EVrGTMSsainsL?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tjEuvaYWWXGDq3mbltJjSvC4XjZajM23uWfFtiI8X0M6Qph2hvxyDlY43YPo?=
 =?us-ascii?Q?7OWNAgr4jaTDQ+cyztwB4TJ+NthfhuCTzkMvSXM8F0txgZ9bj3jY0mvaEGhh?=
 =?us-ascii?Q?GREaB6m/xRJbeG+/t9Gd/3CTaYaPPJBotN/9V1m0ayPOGtdc6uHdprzS+9ts?=
 =?us-ascii?Q?vNKb1To2qH6KqZx4VfH6hjfV9UPphaj+P9pje+eQtNZ3+7opAwP0RVL5W4vZ?=
 =?us-ascii?Q?AjzclYSl6LwIDkEa792PGiTRTcJzVHc4SCTmU5LfgTrZRpRsUjaWyrHOAiLC?=
 =?us-ascii?Q?vuaj68u7eIX/jNtUDhmEBeXDosIisgKSTg2Mf7pPY4bJy2RiEhIB3L7MPfiu?=
 =?us-ascii?Q?tZgBOTPHwPdmilGLkIdsscIRFzEWrgNPs4fLdgRyQ4ngOyiEeAhr/aeYqN2u?=
 =?us-ascii?Q?fPcrUukDvrAcRhB3HspOcSPaidG+HGgwRUeY93TyejuX6ZR07rP7R4TVKlno?=
 =?us-ascii?Q?AHuM3ieCAkFPJ2LdDbWrTS8/ptMFXexRefTi1BxBz5F0zUjV8HkNCxfe99Hx?=
 =?us-ascii?Q?O05EeVoCyfy0vHPi+iFEWvYDx2Oxfw/VzTqjDbBQkiSvXECDM03HJeaZNPTU?=
 =?us-ascii?Q?KX0F8ketnEEvwBYM4j8mCffNjqvB8ilCpddVXjhfgpMaV3KSD3POhswmRdA2?=
 =?us-ascii?Q?JiYTSxVvm5QDWDdoIEpiPJRrWilJAl6YQixCdeNMPMHg8nBYwbC/IqKmLFTx?=
 =?us-ascii?Q?mWgnAN37a12hwRMro/cyNkQMzpcZSUk4aGTRzRtkJfkECMyq05iyelH+GiDS?=
 =?us-ascii?Q?/2HMmVVdDOcofp4k9p4tC5HAwf3XlALp72PyTiattH4ItG54hO6kAB3t5Em0?=
 =?us-ascii?Q?1vD4b4pnc7bUMvwUtbIbNhxyNEy0A1BPhnj33yzjIlvqgyrqenngrNnFpk0L?=
 =?us-ascii?Q?N32uarWbGyywoCeWm3jwIw0I8eQEs7YQS129gUQK/SzoRoU/057bGNYfRx8G?=
 =?us-ascii?Q?BNEH7Yx2qwPkyiQVo1YmJahYjZVYq33tHpd0edyRUPWH+adGGfCk/tp94D+G?=
 =?us-ascii?Q?zcOSBQx+KnihSgpvf/iPSN++tEXF6iv2smYqScQiG+ZBSqGHIURjeUBQR7XN?=
 =?us-ascii?Q?L8Mutzpbevva3l7sKS5lng1SFw5mAXi2fUuGti9RzYNnOL+Odj28kMLX8faO?=
 =?us-ascii?Q?/jZ448i4GUH65TOLiFsFUQzjf8XaW3e7ZUonZVLq2RzknL7D49QqTVHvB61X?=
 =?us-ascii?Q?q4X6hkPaYRvTYnmgnGuEek1HwAiKi/gUVKZsvnbc3fjPd7J0mEvSmya5T0+l?=
 =?us-ascii?Q?fGMKUult2ITWfo2HwPtcvxrd4gfXc0X+2YxHZONE7QzWaQ8lHybk8YsWxiZl?=
 =?us-ascii?Q?yzkHJPhpiEbkmhCzPuXuTMf9mQnwA1lZm9NFc587J3GLtU4sJS5GNjexHCA4?=
 =?us-ascii?Q?q19lkZIsmOkJ3KU63RtkvW5BQPzxZQKP47OOAitl//ZEhIDwtEVP6/8EKDxd?=
 =?us-ascii?Q?YvLiBi5PXvYqibEsSnzB3V+PoFo/tT+WBLGBi1p+wHvhK/jOPzCwL0QrkoXS?=
 =?us-ascii?Q?CNHOepZk/AtgKrXqFv/DBhCPPmXo0jcCnkQTWqv12ko0bFHU6PbrZoG4H+KJ?=
 =?us-ascii?Q?JS0TzjtDFZtkJrVHb93hrClJMZtQokr3EO9zVNtywwHfNjiF8I4GAk7A1224?=
 =?us-ascii?Q?PA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	skfaIdunmQCSzR4/7zT3jIiHf7FqJ2H86HSr87lPJMU+DbYenGQBEp7Qmu+HEldOCcNdNAl+R6c3Pj/KOM6fTNE3jeKuKkKHWcFwNvGjvjZQWI0x+flWskFEdl2Z5S56qQUseyUWHnRhKgrNTJHDO78fmIa5CGh7SEDaRRqUWlhkO7bmJl+SAuVuhjqJsDlYT8T92ItKn8L8m8X3BGcAdBxZQfruMnSVxM29LMw8TLaxMhwSq7y9gnXvF5j1Pbo7PXxsvb4qlH7r80zueSBttRZd0nVMPCF8fWv7oR0LM0c6fK8FyBrYIn+0nUWvIs7pwPqPVVSozJDQi2fVBvRg1xAUBXPs6B8DJL7MklctY+jwJuOs9QomdQC5CL2AaTld5nT931IH71aIs5QKbgl16grizs3/ovKPRy588nMErNDwdxqAx9qpzc2UWJuP4091McIt5rnyma9VetP7tfryn/8PUvq5BhSILcfTdhNhe/zoBfE/C4Ij0tgdDYpgqz1Dn+x7KNouGDXboqRRbRHd5SvZ8IH4+940FXfiHSPiRlonD2vFjeWAUSqpF2KMGVfVXmkQFwK/peHvrE6S0MMGYezwCnyaM8rkGw+cIlRmiAM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42260a8e-ce14-4ecd-1d07-08dd4513b2ba
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Feb 2025 12:01:46.3224
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KJDN23W/7vODe2V1x2XAIComVks4IRnNgUBEaI8pStQ04FQPv6c2O1PmoZ+XI/dOkcFAUxrSe6k1J4aRNDaryA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7648
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-04_05,2025-01-31_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 phishscore=0
 suspectscore=0 adultscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502040096
X-Proofpoint-GUID: eQoVkYhd8lRXEYfWEF_WvQr4Y9EdhwZp
X-Proofpoint-ORIG-GUID: eQoVkYhd8lRXEYfWEF_WvQr4Y9EdhwZp

Currently atomic write support requires dedicated HW support. This imposes
a restriction on the filesystem that disk blocks need to be aligned and
contiguously mapped to FS blocks to issue atomic writes.

XFS has no method to guarantee FS block alignment. As such, atomic writes
are currently limited to 1x FS block there.

To allow deal with the scenario that we are issuing an atomic write over
misaligned or discontiguous data blocks larger atomic writes - and raise
the atomic write limit - support a CoW-based software emulated atomic
write mode.

For this special mode, the FS will reserve blocks for that data to be
written and then atomically map that data in once the data has been
commited to disk.

It is the responsibility of the FS to detect discontiguous atomic writes
and switch to IOMAP_DIO_ATOMIC_COW mode and retry the write.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 fs/iomap/direct-io.c  | 23 ++++++++++++++++-------
 include/linux/iomap.h |  9 +++++++++
 2 files changed, 25 insertions(+), 7 deletions(-)

diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index 3dd883dd77d2..e63b5096bcd8 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -271,7 +271,7 @@ static int iomap_dio_zero(const struct iomap_iter *iter, struct iomap_dio *dio,
  * clearing the WRITE_THROUGH flag in the dio request.
  */
 static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic)
+		const struct iomap *iomap, bool use_fua, bool atomic_bio)
 {
 	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
 
@@ -283,7 +283,7 @@ static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
 		opflags |= REQ_FUA;
 	else
 		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic)
+	if (atomic_bio)
 		opflags |= REQ_ATOMIC;
 
 	return opflags;
@@ -301,13 +301,19 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 	blk_opf_t bio_opf;
 	struct bio *bio;
 	bool need_zeroout = false;
+	bool atomic_bio = false;
 	bool use_fua = false;
 	int nr_pages, ret = 0;
 	size_t copied = 0;
 	size_t orig_count;
 
-	if (atomic && length != iter->len)
-		return -EINVAL;
+	if (atomic) {
+		if (!(iomap->flags & IOMAP_F_ATOMIC_COW)) {
+			if (length != iter->len)
+				return -EINVAL;
+			atomic_bio = true;
+		}
+	}
 
 	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
 	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
@@ -318,7 +324,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		need_zeroout = true;
 	}
 
-	if (iomap->flags & IOMAP_F_SHARED)
+	if (iomap->flags & (IOMAP_F_SHARED | IOMAP_F_ATOMIC_COW))
 		dio->flags |= IOMAP_DIO_COW;
 
 	if (iomap->flags & IOMAP_F_NEW) {
@@ -383,7 +389,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 			goto out;
 	}
 
-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic);
+	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_bio);
 
 	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
 	do {
@@ -416,7 +422,7 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
 		}
 
 		n = bio->bi_iter.bi_size;
-		if (WARN_ON_ONCE(atomic && n != length)) {
+		if (WARN_ON_ONCE(atomic_bio && n != length)) {
 			/*
 			 * This bio should have covered the complete length,
 			 * which it doesn't, so error. We may need to zero out
@@ -639,6 +645,9 @@ __iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		if (iocb->ki_flags & IOCB_DIO_CALLER_COMP)
 			dio->flags |= IOMAP_DIO_CALLER_COMP;
 
+		if (dio_flags & IOMAP_DIO_ATOMIC_COW)
+			iomi.flags |= IOMAP_ATOMIC_COW;
+
 		if (dio_flags & IOMAP_DIO_OVERWRITE_ONLY) {
 			ret = -EAGAIN;
 			if (iomi.pos >= dio->i_size ||
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 75bf54e76f3b..0a0b6798f517 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -56,6 +56,8 @@ struct vm_fault;
  *
  * IOMAP_F_BOUNDARY indicates that I/O and I/O completions for this iomap must
  * never be merged with the mapping before it.
+ *
+ * IOMAP_F_ATOMIC_COW indicates that we require atomic CoW end IO handling.
  */
 #define IOMAP_F_NEW		(1U << 0)
 #define IOMAP_F_DIRTY		(1U << 1)
@@ -68,6 +70,7 @@ struct vm_fault;
 #endif /* CONFIG_BUFFER_HEAD */
 #define IOMAP_F_XATTR		(1U << 5)
 #define IOMAP_F_BOUNDARY	(1U << 6)
+#define IOMAP_F_ATOMIC_COW	(1U << 7)
 
 /*
  * Flags set by the core iomap code during operations:
@@ -183,6 +186,7 @@ struct iomap_folio_ops {
 #define IOMAP_DAX		0
 #endif /* CONFIG_FS_DAX */
 #define IOMAP_ATOMIC		(1 << 9)
+#define IOMAP_ATOMIC_COW	(1 << 10)
 
 struct iomap_ops {
 	/*
@@ -434,6 +438,11 @@ struct iomap_dio_ops {
  */
 #define IOMAP_DIO_PARTIAL		(1 << 2)
 
+/*
+ * Use CoW-based software emulated atomic write.
+ */
+#define IOMAP_DIO_ATOMIC_COW		(1 << 3)
+
 ssize_t iomap_dio_rw(struct kiocb *iocb, struct iov_iter *iter,
 		const struct iomap_ops *ops, const struct iomap_dio_ops *dops,
 		unsigned int dio_flags, void *private, size_t done_before);
-- 
2.31.1


