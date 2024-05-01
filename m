Return-Path: <linux-fsdevel+bounces-18395-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F01E8B8479
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 05:17:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 07AC9283623
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 May 2024 03:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE5EF22097;
	Wed,  1 May 2024 03:17:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="mIDxnyJF";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wQza1Uzp"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 497D053A9
	for <linux-fsdevel@vger.kernel.org>; Wed,  1 May 2024 03:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714533429; cv=fail; b=VaEssohIUdunGyC1rdhgL5HU5f7WWoR+u4t2yo7xJxFSEKzpqp5Xu1stZ3S63+nvpsrBa/+M8IC7ClvThEeqkQukWCAj7lyv8vwtI2qEIkhn2uFw6kp39IxMuYtJxyHf7aNxuGlCyzflLkkIiEAyxpzx+//xoyOp+GvlX2jDLU0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714533429; c=relaxed/simple;
	bh=zVnYogvZMNrQ+eUGeezP+p0890vgC8gVOE26BLVqEdo=;
	h=Date:From:To:Cc:Subject:Message-ID:Content-Type:
	 Content-Disposition:MIME-Version; b=h0/hXLEArlREvMuBEojxGZdZzm5wiO1tnxxwwJkr8tXvy49J/NX0gtQLBNKEWnD3BA3rGRJ3B4dT9pUaDzWUD8tD10tNiVe7IHLoppVFEBVq/pjQx2j+2mQkAceBbkqBtUDerj8YNHXzlAI+Edtt8IQOiPwsBXAhdVWDdBamavI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=mIDxnyJF; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wQza1Uzp; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4412hrP1019783;
	Wed, 1 May 2024 03:17:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2023-11-20;
 bh=+2KGBsQXnFMdbPJXbuEUi8z7Bqj9ehQMASvMTf/JEb8=;
 b=mIDxnyJF+wN93Jezi1ca/spvDcvtvh0cvmahq3GI4kBUJDQz2BMkask1fgLTCty+LgQf
 6qVC78WNmVU6ZCUH6QWOJ2KbdI4n0KMdMWq6DgpHuiHjYgFYOHBemwYLsQNNupxyc+e+
 8a0o/NAFrGCWi8DLWXmPndK82vekQVwDpkM7kj4p8VW2Di0MLCTKEl1EqwpNBwjrku3M
 iNKM2uOdyiqFXGBxZiDXmKWedpWAPiR9Bv7RNoxGdR7fsbYP9Cn/Wdj7rG4hiE0Fx+Kc
 Fv9/T4crjvUs+iW5aLLhxRKNbHW3poTUqrFUb+NMp1rhooUAjqYjbxPCsOWh3dRbnX2L 6g== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xrsdepfx8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 03:16:59 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4410lShm034589;
	Wed, 1 May 2024 03:16:59 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2100.outbound.protection.outlook.com [104.47.70.100])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3xu4c04fmg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 01 May 2024 03:16:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IE4YhC4+a07Ruk1m3CtqOnusIgDRalt0W7WKB+7EmHaIw4Sin7zrlqgoI+trTVUXfwkr5MmW3dqTGgs2QlhMESVStgE2bbf5UVH5VGKhsJlwmaexdjvx6D0lAAEzM7SgdMkM4LeUCmTiz3wrMA5a45hllxlowLFft4A/mjin2mYTpgWFSg71MTHHKPTNFpGLqiJo4jISmtrB1c5FAsSIYP2Cgv/eN9k4sIOnXAmHUY1KjkyUhIbfF+V2egCNcvT7Oo3NeQDfQsfMpPY0F14XzyVIwBBlwMJnZ95NvJS9lxP3wWR1yAm62bPwa/C9cMX9DrMsR46fOmmHFz1gxGM9Kw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+2KGBsQXnFMdbPJXbuEUi8z7Bqj9ehQMASvMTf/JEb8=;
 b=U1Ic/0cmUDXvXeMtpm3rR2XE7ZRNcg0nVUgV9SQ88hHcxIItG3w1+BgJ6NU8LA6/FDsNP6xrgFb4/JNpdKKH7IwvoRTxwlUGb779PrenY0pvqkKb8ygnr+4bofBfUtPJA9jtwMMm4smuQXFGUGsmf0jxLvglTnWS1f96IakNYg80+gUSBK2FCv7Ue/Nyh7Kss9Lr5JB9sViKQKE3twJnkdaSqBoLJYKxkJFdk4h88+rkef8cegrQh1yMvv0IiyJqLbhPxl9xST+1dDEaSpNWvzhUowuzAZYw/edgyTUVcJU4O05MuC9rIvN3niKWmN/qUkuroDS5GkuyglOZxWMOow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+2KGBsQXnFMdbPJXbuEUi8z7Bqj9ehQMASvMTf/JEb8=;
 b=wQza1UzpGkeyDeH0MQZOiiXXxoSBju+2sC3R2iz0GQR6eJJU0oO4YLUX8rRDqtzwRix4i6pw9jezkq70CpqLZfq7yrER6/kguqIdb6B5OFWtgokPr/Fy02kyjR0nVNs1N+b4X1VSAifwktiznG+aJZC+fqeva0enW3yL4Wbbw6Q=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.36; Wed, 1 May
 2024 03:16:57 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%7]) with mapi id 15.20.7519.031; Wed, 1 May 2024
 03:16:57 +0000
Date: Tue, 30 Apr 2024 23:16:55 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: lsf-pc@lists.linux-foundation.org
Cc: linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Subject: [LSF/MM/BPF TOPIC] Maple Tree Proposed Features
Message-ID: <rqvsoisywsbb326ybechwwgpdrdt57sngr2zwwrbp2riyi7ml5@uppobkrmbxoz>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	lsf-pc@lists.linux-foundation.org, linux-mm@kvack.org, linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: YT4PR01CA0373.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:fd::15) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 273e7ede-3f92-4ca8-ef08-08dc698d28a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|27256008;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?dajXbCK+YVEx4UMIDdACCCoVftE6CMstvKaO2qT3e2rHtQnFw3Yng8a/bQ4x?=
 =?us-ascii?Q?6EkYdFVaBZtDsuLAIoiDzvnfneb0oy9jQKXoIyd1QQmh3lkbm25/fYDk3RE5?=
 =?us-ascii?Q?XHvmVJwKZm//yUykH3Fx3HrXPTV1mfClJ31BMRZxYsdEOuxF5PCFJXHBQIMw?=
 =?us-ascii?Q?OT8pWVEZXtd5cgBvZx0A96JarMS7l/loC1m/WmSUeD5PWIroA1A5CR/gRDBJ?=
 =?us-ascii?Q?nhx47d+0xC2WruUVxRnKN2yBaI+ti0uhR4ZsCOGHFDj4vF9jM94c9wcuTAf8?=
 =?us-ascii?Q?j7Y7XsqbeWYGWN96MqW9ejmMiRg+xvDSKgew7hTfpjTN4ztT9yjZtodkQLfA?=
 =?us-ascii?Q?YN3/j4+NTi99qIgfqmk1CH3gGstsWt6pnHnZps3UdnY8i8RSUI9Lc9SYjofA?=
 =?us-ascii?Q?zDgTnriqvCRvK5nsyPABJbZMW4JzRmtpky3kDI6vA2cOPD4GlXaEBK1JXRQj?=
 =?us-ascii?Q?VGPKqO2n7fgCCJCaEczeIJyMP7XTKmlXZx61eSjsd0ticNzXSv1MS3H5MFUm?=
 =?us-ascii?Q?gT0JFgMK62+0JXSdGE279Mbls622DV8pfecdeCoOIFF1WKT7DrNakYdxMXQA?=
 =?us-ascii?Q?3P9j4WFlydZ4QWoThcHi8aqIzLw7Mkhd1V2VgXFIVbM5dzFl+oZ9DVojjQql?=
 =?us-ascii?Q?/T41Tg0iWsaN05DNFXno8OtThP7NzPvmedk65GVyyeP0lGO2AkMayW7g1eML?=
 =?us-ascii?Q?FuW65QI8gnfQcprjqTV1nZxppcIgNcdiTYX6z2vUkiwB/VTQ+ynd8gjk+xTS?=
 =?us-ascii?Q?0HTd2QGMh/gr5bhPEJ14uurt1yP6gy5EZSVbM3oLSWjJlPrMcEhR69VhJotI?=
 =?us-ascii?Q?sAxKRAPWMk/wnzOarzJq2TAE3Pp57bTyM1QLUDZADDRx6qyLO4r3LCCuiJ1i?=
 =?us-ascii?Q?fZL+4881YhjUEe9LaSm5hFviKYQkhgVV2RuMok0nXgU0lnpwbRO4YfFNL4XP?=
 =?us-ascii?Q?gQ806JQNAcmzuRWuYKIoTYTYIh0Pt+mUmvlIL675743o/syndH/n8C4Pgl17?=
 =?us-ascii?Q?NcEjBendAeFVXabpuM679melnx02x3UlFeFKJvGtuuf5oWgI13XCneNSizQE?=
 =?us-ascii?Q?TrbjH6mLDUUuPoq2LG3shnLC9Hg+SbALgCCH6yLTjjSmumwpF6MbVd70Iaip?=
 =?us-ascii?Q?NTOlbuSVbnuDxxttx1wMpEqttKk6T66/e4T5EB8vEO7frUC2EhVQi0SA/hi5?=
 =?us-ascii?Q?nGZ/BSOwT5BlRp089rKEpnxJ2LctAtmGy3H17xjtxp0rUgxjIOYafNLACw3e?=
 =?us-ascii?Q?sWHxkgZYEuTLym8st82XPPXMVxDfhRgnaq16oA3/Aq7keQmoLSVVdLDOD9mM?=
 =?us-ascii?Q?QAW8oAVLrnJ6swcVuB2NHqI0?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(27256008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?AddKFiVB8n8HFqfWbnw9co7qRnE9PrERQEq/Ni8F6l1S6fL7V/Jc+VDAwwee?=
 =?us-ascii?Q?C3yKjOApIdJPkkycSd5j1hKxEZj9INDVJk3HAQl/SG5TrUn+ebKlqOxv9lDc?=
 =?us-ascii?Q?6M2QxVbaHiUBidg6zDkNZBABwwXTBCh62mRJwS6QnWQrVshMch0/en5UrK+G?=
 =?us-ascii?Q?tOM7FrJs9LaI4PMrvsBADIdah7OfNPlitL7fqCDDw6HZ5UkHbtheLic3fJLz?=
 =?us-ascii?Q?PBZ5Ri7VcOhXX2g2c9MFBqiz1ya06YRQdmRpwQWqY7O20bAg0Ddgh1odo0CY?=
 =?us-ascii?Q?EPK0juEzFZiZu+cTyxLeIcHcNe1tTBfTxPS1vcC1+yQd2FU7hIqsgyGkwr8P?=
 =?us-ascii?Q?C+hXNQba+Wxady7ohDGNDp6PLUwOuBA+OCCPMlTdikdVuSrttpOytK9Ww6uD?=
 =?us-ascii?Q?w9UKtQHj0GiaRe3DVZSh9HwqgW1E8cKKo6pXA/tewdkqg9lJAvARpaB4dCy5?=
 =?us-ascii?Q?E8a8UEOVymMAikbFgEGKXXeECOxQaxsoZfoajurIkFIs4AOilZ1kt96HWmeW?=
 =?us-ascii?Q?a117R4FEpIuGXdloDXy7VVfzKNwL39QVAYhr3Yd8r4uZQ8yj3oL5FqO1dp8G?=
 =?us-ascii?Q?RLMkiq5zZnqIQ5gQGMgrXaRRWljhcN7JF0sbkAlwypoOYnR/aSFi8dmXY4uo?=
 =?us-ascii?Q?FfLGxsQ1YCu9t9sK0AaIw6hH/h3nltGTxZDVZTWhZ9/GYX7X5KX9fnbPXU6z?=
 =?us-ascii?Q?7/YzOP1tTYQlH2Zu7oqbpt3F2cLouHGo5w629SYBYaaPHOxUvbH8Jaqv/I7D?=
 =?us-ascii?Q?JFPV7XoqrYoMsNX47ncbfI6xXmoX3hG+g9QTBiR9wuEImzHT39xf/tRTYKa4?=
 =?us-ascii?Q?GCQOub4Tct/5yl2QSaQvLAzZ4Pvais7j8uGoezqJ5QQtYtt6U6e/V3wNFzuH?=
 =?us-ascii?Q?8jBM3kS8giK7wgxFy+l2HkQbME9YqlsUIchPpRsY9ltM3EstiJ5Pxt2KXdkD?=
 =?us-ascii?Q?HFg/BHdU7PPKDtJlnFxs7F0wWGF+/hZuOjltt2x4XEdOjN0XGE3atApxr9jM?=
 =?us-ascii?Q?2Zt3xF69db+PSoNYzW+i8ZlalCwbjVqhR7VN5ook29CVo9vScFd3hXdYQ86T?=
 =?us-ascii?Q?tZq3wRDludOpT4BQ5f4emt4ls61rPlMx53NvBBuYsG/InVDvV+O4ZMLHQJky?=
 =?us-ascii?Q?5Z5BIhyoDaHKrWs9EU04RuvoSGiPhlI5tBAsLzYZvZ3dEioSXqa6GS65Wjti?=
 =?us-ascii?Q?T6xkwbRr/NuFLIIv8XUP/szocxSONH7VKHbsrdl7/djhhArQIThlKb8Tr3xC?=
 =?us-ascii?Q?EaFKNoDTbvSVjWyqvWfWxD4AvQLuaU6dcFoofcr4hDhX75AjpuPLk+fgut/u?=
 =?us-ascii?Q?gDXpehZ55AtZfdVMl1lk0cZjlu7E8JIfMnAceNT1Ts33xHVvK1BE5MvolR9a?=
 =?us-ascii?Q?C0Os500ucr11ukRAIR7BpNKuumQ3xneqwCchv/mrR6C23DNp9m52wkiZ/YHy?=
 =?us-ascii?Q?QrPHGzgM7xtW18p6kM/cwjgknGefsrdtz9GbBsHZmSnoqGIZQahIMdPWF9Tj?=
 =?us-ascii?Q?cQpufdojYAw6uzrEu8G9KHiFii39FLnTwXOyqoNO3NYAWSEaJpH0/xG+PLQY?=
 =?us-ascii?Q?Xp3PvRrnZYFciFsv43Ph46LtvfIAkS9+zEpwdmdz?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	xZ7tGaukCL3xDct8wgbA1FOXICoAPPhUpYGO2165BEWIuZW93CdejkBmE1uCZXIdiAt0uKrHjtNdDfRcq4P4doUBfnVjYTR/uUYgV7Iv5PAtot0wcC0vgbieGuMN/JKsYyR4EsCEKtZ8NKFYGPBERvYu78ge15nxsoApIEpy8vlGF3t2loTYPMbM6gM8rO5xvbwB5kjMj01S0L3KuU6lyRHKQHUbwAFS7h1xAOVh9nOSqsRkzURQVQvco7P1yWoGcUGBEmC7y2yqhjYjQFPZYTeragHnfURCAZ7all4JrHfHorHUjsUmAwwpRY1wTQFGqwgvgzE+WQrb2nQERlFRAgRLtbDWu8sbdNd6w2EWJeF3Z4jhBx/rXiqXFAcg/YVzmM0YAjCqdQPlK2kLBnB0u14D8vYVxEG1x73a1lQoO22pUSgF/ORKb+t7d0IB9UmDJIAOtOf65LdFcxK63E+A2GRUAPMY6UoRVub931CGmJWfHaWqDXxHYHa1nOxiBR1uCur+7hty4Kd6UYlccdUiYV67ARGy+SCkR5j7lNoTAZTOjCnBkcmNkLyyzko2+NQ1YXPSAdcOFzfRslmGQ2N2iBCn1FNHUmoW+ZYlr5vunAg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 273e7ede-3f92-4ca8-ef08-08dc698d28a6
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2024 03:16:57.4049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yYJ3gnCo+BvT9szofspouAgTSkdWc72fAX18odaTswYNw7Bu45ILNf1t7ZhIKs9gSgH+s/VKz8ApksxXugxenw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_02,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=715 suspectscore=0 mlxscore=0 spamscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2405010023
X-Proofpoint-GUID: O9nkbB5TZnSo5nAOOdWWDa6x3xm-bgJq
X-Proofpoint-ORIG-GUID: O9nkbB5TZnSo5nAOOdWWDa6x3xm-bgJq

Since there is interest (and users) in both the filesystem and mm track,
this could be a joint session.  Although, I'm pretty sure there is not
enough interest for a large session.

I'd like to discuss what functionality people want/need to help their
projects, and if the maple tree is the right solution for those
problems.

I'd also like to go over common use cases of the maple tree that are
emerging and point out common pitfalls, if there is any interest in this
level of discussion.

Thanks,
Liam

