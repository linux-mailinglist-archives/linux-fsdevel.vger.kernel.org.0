Return-Path: <linux-fsdevel+bounces-23281-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F81692A171
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 13:45:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F2DD31F22018
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Jul 2024 11:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 645B77E761;
	Mon,  8 Jul 2024 11:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VUqDR/x8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UHKZFX8V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 474A778C75;
	Mon,  8 Jul 2024 11:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720439098; cv=fail; b=kg9NT6ZrBDc0yJ3p9HWRbQLaqjKdLO6tbtBpJ6bj+e1BZBI7vx7L5rWsE0HybrCqNbbPDjuF8NCPFrD77kJD3SRLagz+9PKOpNIyMLAXbz3G+MQRdgv4rIHolyJBYCVCmQ/HrJCAWuiFoOsjKKwgqku30s7npIWIeSfW4cydjJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720439098; c=relaxed/simple;
	bh=tIU1k6+5ierHaB9xfoAaIM1AsL6e9FpBJWhaSKt5Ruo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=GsMDVqaF5kKslgI9viJ29ydhsoRuaLknZBxVzLVl7piwh9uHN1npXHCPyktqjpbQrsz0eV74oaGdWj/k5Qrtv3mbO/CS6ykgt18hYuyFq5LsBWgYMvf8oCZ/ftVfpP+PKoCiHh2NYuyxclDpZeJOgnkvZCspqLO0niGa8JdA2PA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VUqDR/x8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UHKZFX8V; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4687fT97017381;
	Mon, 8 Jul 2024 11:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=v7AsdXcCPVPAZxrzQhNhlYIKZDnq2FMf+utEDc8C5Kw=; b=
	VUqDR/x8mTOh1VcYwSOMwphKmdyPVVXbL8b+kjXjrwbyNEN+Uo7SqJAKoUAZCQ0L
	wTX3oapawrQ1OORoLBYJj4jhHEbAP4mJTqEzDB+McT6Mq02WR9K4Ee3nDiTd+pDz
	FI81HmMphJdi/NHw7k7cH/O1nD0M+E5TTeSsnvJpJqyGxQh0zEv50IjMdKk6Qd5X
	YCuxukaRX0wDpEIrJ6x+IPh63zVc4UZ2KP1ZpZeAYbbn3Nof5E4WdVbR0Zv4JOfE
	4HCyN71qExS5zNJBNkKNL09f6leyrw9Hb4iAkts7sH2MPrKxzYsFztJUGJJVHNMd
	P+rAwiif5H1y641OgDrOxg==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wknjdpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:49 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 468BUeEQ013665;
	Mon, 8 Jul 2024 11:42:48 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2169.outbound.protection.outlook.com [104.47.57.169])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 407txf990m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 08 Jul 2024 11:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WWnDIelnc97woAMbHsEAn3R7DrCHWvPvXYSeki50V/cOmjRYAjxrOZ2Sm8tRGS08vpzMJhrCGuB59A6PkNVLzlKQtGgiGNwSipMugGhHRNl+6v5iAMD1Ic6ZpV63dPXxrwKCt0W6MEEVa7jo4G07Kf2FCVOF3sxM6DFl4cDg2YLv8depkg5TK17MluIJUPl8+0C3i93g2cQ77W17SCDXNZLPc73UAYuZLZmBRiBn2ayf1kqyX5ti5tcxUfXJlFPsJuvMioxvOcPiWIS/G0EWxYNbTrk6k0TEbYLllxwkM5SdTaNbevAd1TTcP1QDkYu8VV2SKGVO1katYpKz3arBlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=v7AsdXcCPVPAZxrzQhNhlYIKZDnq2FMf+utEDc8C5Kw=;
 b=hxwvzdLrAkyAv5S0cEJbP6KP7Qad71N+RS7R5shwQgaZTi0JtRUxV+QXp42kCaAxd0aitAIXnbiyPydbLGr3PfzBFXzkR3UWKwKc0/HLwiESvb5ydrOTURXXtxJduUYbybMq5PdKYbEqzkbyNvoHZWcgrReMI8ye3aKV90xCiUv8AOQenqlqE9YXjE5Wor6m3ZipjAh5W7+mLAfg9GWz5LULf5GbO+9CZaZJKYhXQFjl6HJ2qlJXMA72mxfUvcH4cEeW+9s90/q/dF3w3bkkfXi5jhDXVSkY15hq6plF6vX48t0xBhI+1uVmow335XmOAjh0oxHN7E+MrcMbPyHsvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=v7AsdXcCPVPAZxrzQhNhlYIKZDnq2FMf+utEDc8C5Kw=;
 b=UHKZFX8V1cwypHhpa8WGtTkzIAyj1AcXRPSZeCScVvC6179/KtJiPwwIj4ou3emsxBTzd3MFKdrHja5rK+r7JsHOHC0rljdfjTPSciFQVZzVFRV4H9ptj53JdA5j4B9X/RVWJFchtbLv4qa0y8BbeHnAQrhaI20OaHBut0SXst4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by PH0PR10MB4454.namprd10.prod.outlook.com (2603:10b6:510:3a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.36; Mon, 8 Jul
 2024 11:42:46 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7741.033; Mon, 8 Jul 2024
 11:42:46 +0000
From: John Garry <john.g.garry@oracle.com>
To: alx@kernel.org
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, axboe@kernel.dk,
        hch@lst.de, djwong@kernel.org, dchinner@redhat.com,
        martin.petersen@oracle.com, John Garry <john.g.garry@oracle.com>
Subject: [PATCH v3 3/3] io_submit.2: Document RWF_ATOMIC
Date: Mon,  8 Jul 2024 11:42:27 +0000
Message-Id: <20240708114227.211195-4-john.g.garry@oracle.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20240708114227.211195-1-john.g.garry@oracle.com>
References: <20240708114227.211195-1-john.g.garry@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BL1P222CA0005.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:208:2c7::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|PH0PR10MB4454:EE_
X-MS-Office365-Filtering-Correlation-Id: 5266b2d3-d29f-4f6a-f16b-08dc9f43163b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?lYh3G8X9XT0Ag9CUCxwfEBBff7oZM37pHbWlmpetd8OPNS9d24l1BDA0M9XI?=
 =?us-ascii?Q?j07FBn82NIX/co4f/cyxWy3wjd67v/Ozmph7fBNc8eBd7psMuzFiqk8iKWUV?=
 =?us-ascii?Q?iLL4z0tDO7K1xNWAwK1sbMcc540epIxN/Jsq6vDipPyzBdE6jYyzGaD9LCgB?=
 =?us-ascii?Q?emqE6LfAfLVyiEl1DhhBmhi99siLDMJkh1G/c3o366cnSauc0cEk1uNrTJxx?=
 =?us-ascii?Q?bFUezH2z+y3k057+H0idnwIVrBf9qPIMs2E2d828nNl079jX/E1uniume2On?=
 =?us-ascii?Q?/KuBII6MCDD2JPccim3Z1dH9v2YzuPRcbcUTQtx2XgNhntydSGlafckbvwvP?=
 =?us-ascii?Q?1MD8tmutNZNL7pOBogV9TrVuAXCmTb2fOY65CA6wlrSz2daUY678lntjZi4D?=
 =?us-ascii?Q?nMHbhGldP+1G7JzkNKzv6jLPompjttzu31nJluM3cXusir34ayoxhYWyvvmx?=
 =?us-ascii?Q?6DsvzcCsLBYYahmUEhhN5mxa9OZik6AAq/yfRZ1ZPXpvrAKse/oecj00Rosi?=
 =?us-ascii?Q?jQ2VTHU4mU9H2+8a7AGkCN3mAJGvNgVSKM00L1KxL2IzyzoliOQksSvcUwU/?=
 =?us-ascii?Q?SdL+Kn4NcSZsoihokOFcl+tmTX0TBkAzIUhnG6wZnfjWBhptz09N2LFprw2l?=
 =?us-ascii?Q?CCrZbBD8Et8uW3Iy6XraMLlPlf5K6PV1Yu92y0ThOKsp9VaVqzh6SVw2gVkj?=
 =?us-ascii?Q?yVgxHh40GLRtgOUm/JjKRy33IF4QzU+rri49waY6DoICiNRtpQ72SSKVaVMB?=
 =?us-ascii?Q?LXgv0BtNhZnOFngwpevVjERs8lPCJt/GkfD7tsRwtDXDRebwpdYcgoweGszW?=
 =?us-ascii?Q?RsNDgPFqE/q18Kmhr5OjiMKBHGAlee8UqdgPDM/Kb0bxDEVieju3RAdYR0lh?=
 =?us-ascii?Q?oZJJXywscHvbjlln0jPhD0ZhCEUrdkdk7KFYC5ZKShlOzLyrfIKCVtyAb3Q+?=
 =?us-ascii?Q?HnVJlrQX99r3ulWpIL5LUq33eY1iClKQT8RWMt54xjx5CpyQeaFbyrbz5Se7?=
 =?us-ascii?Q?9hMI/bifY9YsvkQU/ZOo+GRC/Lf1Fu+ezKPRT5LNVlbbAb7l06j3H4i1wZR8?=
 =?us-ascii?Q?e2AQzt/zXVzcZrYXAP60xIwIF2hIeVaBmaATqvf57241kzHFZrEng397JKHS?=
 =?us-ascii?Q?cPkz5NPoQ0sYeCA3Kq2geMUq+bRrh/I7eB9p07Pk9PWaqQEewnfBMBpG+vU5?=
 =?us-ascii?Q?cz91FFc2tBQ9jJJwAel/24SauhrRLyvU6t+/GgNJKAl+yDFB4nwCOndw8CoP?=
 =?us-ascii?Q?TSVn12zljJ6tkKBll/gEZ8wTJWGvg2ftfII2fRX7CVOnBa1/GMiKQbWIDll8?=
 =?us-ascii?Q?goktYKZ6A7/v8fB5FQwxKLTY+HhBw4ipQu9b9OqJvzY+CA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?rv18cAolxW3FxfTEoAw8EydxgB+91m+rCU75R7H04kgyF8CIed/RyK4iH/Gu?=
 =?us-ascii?Q?SG+Vyw7m42uVUqJjAIb1s/8I9oK7gV+KZpVPL2KLOMHTlw0dNsDLRKJv9pui?=
 =?us-ascii?Q?u5U/Npq/gLPBbdNdMlddazZX1f93/jDpGSPeJ2WWehFFPZ/jOASFGJsrVeXi?=
 =?us-ascii?Q?6wnQeTRZJFIHImmAhPM35UCHpp2nxskXc8osEm5cIbbI4MvcFD/KTm1eY0/x?=
 =?us-ascii?Q?Gd+2qw5HEuQtE1JmqoVCHr/j40okLSl055CDeeO+mpM3z8cz4tjxRZSPYaZP?=
 =?us-ascii?Q?Wl1bzKyZSXM4MfktyDrqau/2NLZZXbPxsnRYgBi1yLrdeIn1L2s2lwPpVl+1?=
 =?us-ascii?Q?6paHkBXWvwsKiZRYcUvIGyazwpOXq7pedEwtj5AJABuMKY7Sm8kyqY8Vf+5D?=
 =?us-ascii?Q?7+UvR+a78w30LB0sdQ6a8Ix5Ph7lm4TCvc78efKii8GcGFZoepw15+slIi0c?=
 =?us-ascii?Q?yv5JHydnnHZwsekqEQ9cNUpwOk976UxywXTQfQwPXO2juW/tZCH/B4lyRkg6?=
 =?us-ascii?Q?kGo/dLWsJR53/NYkJgnuG2aZr2bEp0IbsGnjMcXd7pHGNoVNJy2s9DGdS0Ja?=
 =?us-ascii?Q?DauNn05lHd6gwlMJK/vejNlsssNRe14VM6ZBWZD12GptX4jLn2C2ZXv6YkO6?=
 =?us-ascii?Q?ety9b8NnQzKspR5Ww6zArnrZ74B31ApXTNUzQp/GruGqwQvZDUJVRuPVduWp?=
 =?us-ascii?Q?3q2Xe6V9CN5HRfvFaK6Oj+qNyiy0796LvHEXNdanxB8fZxVfjPNHvpiJvY14?=
 =?us-ascii?Q?z59Bdx/gfmm+4xyyQkABSTNtuYcDt80mQkW7K0HB+Ii9t8YlvsBmulTx9SL8?=
 =?us-ascii?Q?3d72jPyOa0Taxwdn6Cp4R9lpKRAmE2Mkx1vdPcWlKmuxETYc6RKr9lE7OcHH?=
 =?us-ascii?Q?4dEtmX08is1WdkL+UKLC0vVA4dZkMrnr4y4Mi/j76io1yR2+wLKcuoyFF+oz?=
 =?us-ascii?Q?Z/xR/TCelnqjd33XI00/esBPieTt+oUgaTKswKjVUCQ8gO6IVwi0OW8JHX8W?=
 =?us-ascii?Q?XZ/MgUMuOHKNtftWuXA8er1q5DTTqv/ZsntWJO71cd8CtI0/9BVP77UBuY7p?=
 =?us-ascii?Q?RO0FIeUpJ+y3+CY1QCMgZTX9SoEokUaKcQZpSrsk9ZwrbbGSs6mZB7yxn4P3?=
 =?us-ascii?Q?PNwxYQ6hFoGN8pU8+ou+/zFLi4+Yx3CcDVK2vTRYWsVrkVrqS+26WG0rfUBl?=
 =?us-ascii?Q?6Pz4+RcuyLmQMIJz7MvyTujoXWQE5EJ2hSTaj7zcjUe++1mK/6CLYSX+/t7d?=
 =?us-ascii?Q?4+vhU/KAldv8IxE6QEMJSU13lZWFPE3uxpIJpB0VayWMi2cTvjAlbwuSZ2P9?=
 =?us-ascii?Q?x1/6caHTrWvk3v4rziVOo7bKm1/+d3UGMX9nSDWbYm+o5dv4rQ4jgOv/Gp9j?=
 =?us-ascii?Q?6v7IXLWWnUvoa2U+jnFK4b3vGgVs+lRf6CChD4pDpfdTr0Nbd/j8367vGZQp?=
 =?us-ascii?Q?lxJ/RrDE6HTTTFT38Afh2B+jzE32QfSj+msqwDMrZDcM0yUk1CivDHhGFNzu?=
 =?us-ascii?Q?HpycPRfzTXfENOob21CqDfhgqFI8Ar9G47TJkL0xz+ehbMUrEZNlwSzmUi76?=
 =?us-ascii?Q?6xIOHsqldIpuIJAzPs6OHeW/hAaqPE1UqhC62hsSsGuLmRQHBYDUhXmAq+UR?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	i8LPwvsRzoXXsMVt3JoY3jC48RMOaIkrhi5v5ZtVX1BfJtpZ1IkSuVbboYUqi8LkjRteJMCam/KAe+nZxbiGvOTLvafS2YTiSol/U6dTC0TFuE0sOExID3TuYbddfco3MTzJtpSzbq/61y+chTl12677UkIcGETX3C9lbdR1Jpb/GolPrw3nsgC1N8uvmgU2HUJVIf7RpSFHcxMCIyygpp/fQ+HOBZDty1q8uXEHRImX1r0SumTiRf9mcGcrsYekP0MeTqt+Z/6cgd/VwcSEAv5JLoQGT6vp+wz6wbClyl02PN3e4gd/QsfeTqAGDRXiEiihhUDL4XAYbvjDtpoN0Y6cLJgt0GxYVJ+gOP7PaFf3MCLDaw68t2tpb5UhqpTvwb0XSfK/ZycqTTZEnxno991xsSGWkrZowlkOm/UxwXnPyKGSniD7QuTJLbbh3t6mrEfSihJnPymZHgPisNLg51Pq3ThsE2RWRE6UmLiCaG2+nIYOyqKr+SPPdD2kFqy56Jvq+r2CxYhexjvE/ppZ0l+6qURS76Q59j7MU7xbZwgjFZ9V32OurntL+ZMcsV4i+CFea19z4rwlg2BN7jZZJ44Jo+tQGEbKaIYF4YSGYOk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5266b2d3-d29f-4f6a-f16b-08dc9f43163b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 11:42:46.5924
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivMayjrJn2gDdAu5ig5X+OODePzIcaeiNSOn5xZqDzhWf9FXp2zKueM0sVmhi6Oq6kpGzv5STwwy2+kfL4ymeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4454
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_06,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 mlxscore=0 spamscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407080089
X-Proofpoint-GUID: 1mnfvAeb9_CykNwItJBEIa1fbhBRP7b0
X-Proofpoint-ORIG-GUID: 1mnfvAeb9_CykNwItJBEIa1fbhBRP7b0

Document RWF_ATOMIC for asynchronous I/O.

Signed-off-by: John Garry <john.g.garry@oracle.com>
---
 man/man2/io_submit.2 | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/man/man2/io_submit.2 b/man/man2/io_submit.2
index c53ae9aaf..ef6414d24 100644
--- a/man/man2/io_submit.2
+++ b/man/man2/io_submit.2
@@ -140,6 +140,23 @@ as well the description of
 .B O_SYNC
 in
 .BR open (2).
+.TP
+.BR RWF_ATOMIC " (since Linux 6.11)"
+Write a block of data such that a write will never be
+torn from power fail or similar. See the description
+of the flag of the same name in
+.BR pwritev2 (2).
+For usage with
+.BR IOCB_CMD_PWRITEV,
+the upper vector limit is in
+.I stx_atomic_write_segments_max.
+See
+.B STATX_WRITE_ATOMIC
+and
+.I stx_atomic_write_segments_max
+description
+in
+.BR statx (2).
 .RE
 .TP
 .I aio_lio_opcode
-- 
2.31.1


