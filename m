Return-Path: <linux-fsdevel+bounces-57514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05832B22BEA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:44:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03150503B81
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E633302CBE;
	Tue, 12 Aug 2025 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cE3YONNC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="jl2jSyvy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F746289353;
	Tue, 12 Aug 2025 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013442; cv=fail; b=IyYNlTzN6VfXiEwBfCwdV2UTWXi6vk1ttXGV9fGdi6Y86oCitWSLQNNTuLV+YTRwEsK6T+nUc+2ZsVkGqIu9h1Gko+fkWtr8dHx+0Yab3bEnhCuFAurGK8cD+ZXL1KwO5XHZS91qR+7HThECKpP3f2ZYMDOz9eHXY8jqmkasjLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013442; c=relaxed/simple;
	bh=q2lujLJMhpnNWblUPacJwCe4KxL+QWfpLTIIHU81lUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=K91kn+MB6vlMvuikCBGminlkdNiFbg23ZxmKdPavG3HzxoB+K5N28mGMbry26xDvC020qYLWE62LKrHU7k54zJOpV8qQpaE8MUVn32Qwb0Ig2eXCLFMeV70TpkP87bNDXzqof7xry+q6vKbQYVSH1MBUo0+nA1nahWzFzXNOsVo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cE3YONNC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=jl2jSyvy; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBvVx015970;
	Tue, 12 Aug 2025 15:43:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=72u2/VhsFAla8/Z1Ol
	fMF0ud1uCJAhS4+kvP9cOzAVU=; b=cE3YONNCaRvExidIloLmPBMuNXnK1K50kr
	mjg+6u+uTbNhK5L1AaaGFZOxI7XjIvZCplmQD3L2K8R9bNrJXZ+TjQvEXxNYep0P
	3PHL+b6PGDxL+SrZ/a4CHuP6Bjx+oGiLZoswZqQIc4lAnblrmJ8CfvPViPrQ+KxJ
	ZwN9pomiLUJPlQzdnW5ophOLzx1Bc5u8yYtX5JICq7WMou6YbQ8QOj2dv3RS8Qxn
	PH/3QawmlG8kz27MEeS/vt+K9weDJ/svsx10skRr3nGaeD2dj8t7MlC+wj2oxR/E
	THYM5Y1/W9nAbvtIVnV4VFieNKcdbxWiCXROAL17MRO06vTN/+hA==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf537s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:43:17 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CE7eXZ038715;
	Tue, 12 Aug 2025 15:43:16 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgp2tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:43:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tnKWcNzZsAJSLdYDNywDAMq9cknvnEug1+0Bgf/10n+AQqokpn1TMpPOkbuiP/8pR3B4+YbpHEisNZIGYXpZa0t1/hb1nRo91evG/D3BaxbTxCxZTbhEb4db0I2wKrVUxH0JGHYp+bAzVmrYlYslYEqtAiyaV65eMjTwbVjeUX+Q48lC0HIxG876OteYxsYDnzwKJixN6kjZsJDEoqmK6282R+l7pzf3s24lQbxLVI0spim7p89cXxl/AjHusLaR14etzkBiro0uG134J0ekrLq1fuPxkUfj+aGk/Y2oTCDn04THAG8lIjiQl29L1PAtaN/zi+6P9dfMTZ3eBHNIqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=72u2/VhsFAla8/Z1OlfMF0ud1uCJAhS4+kvP9cOzAVU=;
 b=WrBoeWN30gGBfSPfkICKchOHz7W1fc4F3Z5Eh5bp0jvOXhVcf3RYL8hJsMl8h8vVS7x2BJ9aa2hXaGn4H6joNchMTkYP5egtxB1zro0CQRsB1PTpy/i9aS5HemTpA08vbvR/PKwqdp+Dcs+bFFlk8pymoyFAy8Z+Yc8Uy9noGGNsPHI7rfIc1Ppf9g3Tykh+dy87okZ83Blw16bnXu6IAk8HXcW0RvxFX+k7Q0uS/5A8Rh+IjHTP5ehX7Y+2dQHe5BuYyPoirUsJqa6FCxFK3vZRAfODkmh9BSgNhb8NT+8/RjpWGOAcBkHgdyGq3eFsVEiQaZB3Si5jZZx7RPG5fg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=72u2/VhsFAla8/Z1OlfMF0ud1uCJAhS4+kvP9cOzAVU=;
 b=jl2jSyvyzSagcrhx3i+Yettkq1Y32j0rW+Sn296Ccn7jNszYzMT6/BLu1J4IwOvSaWSzzje/2h0dF9byR2Ie+WWQJ2nzuhyQ6c1ZcHP/JABlDQmTauo+Ks3pSWdg8YvHBoJ4OJY/oNpfVzwmGm+hUjvYYOQMgsKoojhxJf44Kz8=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by LV8PR10MB7726.namprd10.prod.outlook.com (2603:10b6:408:1e8::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Tue, 12 Aug
 2025 15:42:47 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:42:47 +0000
Date: Tue, 12 Aug 2025 11:42:43 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: SeongJae Park <sj@kernel.org>, Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
        Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
        Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>,
        Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org
Subject: Re: [PATCH v2] mm: remove redundant __GFP_NOWARN
Message-ID: <ycqvuhtqzci44smufdffsfnn2n7smul3rx3iqhgi3y4ka4ytjt@io6pozoxkkum>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Qianfeng Rong <rongqianfeng@vivo.com>, SeongJae Park <sj@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
	Will Deacon <will@kernel.org>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	Nick Piggin <npiggin@gmail.com>, Peter Zijlstra <peterz@infradead.org>, 
	David Hildenbrand <david@redhat.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Rik van Riel <riel@surriel.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Harry Yoo <harry.yoo@oracle.com>, Uladzislau Rezki <urezki@gmail.com>, damon@lists.linux.dev, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-arch@vger.kernel.org
References: <20250812135225.274316-1-rongqianfeng@vivo.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250812135225.274316-1-rongqianfeng@vivo.com>
User-Agent: NeoMutt/20250510
X-ClientProxiedBy: YQBPR0101CA0273.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:68::22) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|LV8PR10MB7726:EE_
X-MS-Office365-Filtering-Correlation-Id: c2f7391a-c242-4e58-ead7-08ddd9b6e311
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RUOt/xSCpu6G/9WR3GNW9FDXra141S7yefPtdwraaLihlCNCAvgDy/wWxKhg?=
 =?us-ascii?Q?d3BfJ8e2GOQigIguAl+nvzAGUl/cNqloMcCNRsB1qD/6MqbO04qxBAbjRxII?=
 =?us-ascii?Q?nBsgXIPj+OVLyZ5cIDGygd51bs4h9T5x93WHw78qc9CqNpnfJoxYX2XesZOt?=
 =?us-ascii?Q?h6vY32aNLk49Y7U/N1cJIhD/xwGlA321QUg6PQAP+1gEc71zZcRBxFB/w9DA?=
 =?us-ascii?Q?NmSqamOynb3hgyh2TA5Wmr0jbVxnZqPkKTArIfKixAlUlVDJlxlD6to6NGhW?=
 =?us-ascii?Q?h47YcTXqWfodn3AJyOO1qL3vPwJzT5k6/5mqyW/XKcSMmEJLapoxAUtkJVGm?=
 =?us-ascii?Q?6813b6lCBkeqWXuFmjyW7DFcHyWkNXpkFukQ+TgGyO9J6OY/vNmcTOiVffC2?=
 =?us-ascii?Q?jg1st5V4Axe4tqZrPqY1Mqil1B8GXD0kc7ByZdNfFEZvRi9QcYqTnbbpTO3w?=
 =?us-ascii?Q?uqLIJ+KjV0pEQ7jaV7vv1PrTj33A/eBI9x2+tUajXkG/1JiDUb7mPsho1I0O?=
 =?us-ascii?Q?ZjNweHdywa7IZWd/vrghm6sw/8oC98MAhamRe5zmp7iVZaAX0xvPscqFUW+Y?=
 =?us-ascii?Q?MP+/F6QMdxjbPnD4dcH/RAhCawr+jwQFXxELM8dDyRVt2MlyKZVF9Xu4LcbC?=
 =?us-ascii?Q?wj30/amwiyEA6LOJreqKRmgD9YO9Szt5S6IAmbcLP/6g/N2aDgvobhqS0gfd?=
 =?us-ascii?Q?q9FLoR7nWJZ4FmAgPFiczVpalUPWYKdQ21PNjjO4HY+yhkS8yCmlHWiFQz90?=
 =?us-ascii?Q?pk9cBARy6YR75pw2AAqGGmhSSD+/epKQ3Y5KLDYbA72rVKLkaLeUY29RBrfI?=
 =?us-ascii?Q?nB+tfoNeDto+Y2kcyz9eCDOULwn6Q+hhXkPKQTkodGLaIYgsGFSKJPQn4f0i?=
 =?us-ascii?Q?MYxz74L8r0rF42nNCyjFzzUsDB57a7OUEBKewWxDQk4Oa7p849nOwP3nGHBo?=
 =?us-ascii?Q?aFUd7HOMNoyGv6nXBkL+SM7HjFuHy6dgYQhkMClMP2642Dbn7ES58i+NZs4N?=
 =?us-ascii?Q?06u0h5z9e8kx6zOrOPx/bBlilM7I2lw30e7EPdO8BO/YALipL+YPrb89l+Qc?=
 =?us-ascii?Q?CpY2P7ttkJgJ1S4onr5I7kp+P2LB2XNFCKf8ZocuXgMZpuy5w8pWNKdDaIv3?=
 =?us-ascii?Q?zM3wY9VIfb/AE8p6mQWo/GHFlSeFDVBmgV6Zj5W5e3CsbcUuXZv42hlanu5M?=
 =?us-ascii?Q?oIe405j8nIQiELjrjic/aQiUKOcvHnBQFmm6+gLYxKe3unTbg5elUEKsnP1h?=
 =?us-ascii?Q?Jq8Geg1jGlfM4qLj6x5YT0gQa8+KRXdgH79Of24rYJygcKTYgFwBwm5xCmS2?=
 =?us-ascii?Q?NMbQ9wspKzypBYbA6PmaNyDqSFCW84mjs7MI0kZV0LMfXWYu8ezTvpSB/y2c?=
 =?us-ascii?Q?xh9l2MoUBkauP9oBsDfKorwZKoNEyGqjoIJkdasKwQ7izy5ERSg4PP3VOSkj?=
 =?us-ascii?Q?J4qd3yyh6a4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?PbLrcg2IJCh9mxklw7rG5BgfoZ5mrUIZXesfAsOCeLm90ouA/9hEGWOrztzq?=
 =?us-ascii?Q?p9B2v9vgXc5bPNfSphbyCZiCTRFY4pO76TrwDi3Gx5XAlT33aSHKREIVWfpm?=
 =?us-ascii?Q?XWpgEzUedZDUw1aHWko57ehFp6ovteA+LlSc8skeVU+3ReCKO7cDEogYD9Kg?=
 =?us-ascii?Q?QfUNViz0b3n36xnZU/LHUtqpsS5SQo6MrL+jGA/g48qNKm6SbY20/cRqB+gO?=
 =?us-ascii?Q?Axu6CbjBYzIQ7YHPFgZpMfiChmXGLgBuGRTF7giZuWTwfP2BazkKFLOFQzFu?=
 =?us-ascii?Q?A2ZDtjMhYUweKk5RLsOzPc82OIUnawgSuaxIfDQO0iJ8Wy4K+dniuqyx6Ha9?=
 =?us-ascii?Q?QI4Nqer7XjkVq2S8VzkS+5gT9jVtQGFlQBBEZQheXv6yb+jHvyHHrCsyp6/5?=
 =?us-ascii?Q?ye8RpmrD0tPZgSc6SgLw624DoZ7OeqrsgfzXyX7d43mUjexrP80L2ayI5NIb?=
 =?us-ascii?Q?EhPLDL+b6X80IspMc17MwFhuonwhcsozHP+Wi2sKTJFhEMALhvDCf0M7ulAV?=
 =?us-ascii?Q?VGVRZZMIxKkDWQV/bsc+86C8M+mUqYMX+CScjHHyKvBp9W9yNDK81EiLWW2s?=
 =?us-ascii?Q?kOBBWPGkDrEvnXNaS/Hv5HepUHIaBuOLu0HfEN/qrcDaT2XQQRKdPcxLmuJX?=
 =?us-ascii?Q?rAb42YM+emB6GR1q/E9o2kWX3S+3vwrDsS3atuc7h3LDbRxRx3CgptVizAmk?=
 =?us-ascii?Q?mYoQ+uf5Ur1kvVqAKPDmdMRkZRWOQVqc/VV4tBVqgyMv+7IZWNAiELzKBbiu?=
 =?us-ascii?Q?avoNWRieoIcUSBCdoX06NiAUUoQh0oNIBuCEiUR+U+l8qIECpCfDeu3nn5Tx?=
 =?us-ascii?Q?XF2Ql60AIWVlsziNuquYO7vdmGVsUw1xYm6nZFisAWxpplR5rAQNebYAczfa?=
 =?us-ascii?Q?0OVyMgzRM0rirsExrMBNt7fStMPpCrf85jIateO53KuMxx9P+Appsm0HO9w+?=
 =?us-ascii?Q?lhPSsTWYEtTap0npnz2ekKWNVY9WrnBUuaOhCTd8yw1I8fQaMdV7KsQpx8yC?=
 =?us-ascii?Q?46I05MWkkPX7/GY1hivttAGeUGaIwj8XpDLqpfhEpTDT+8rDq0OsFhza0CFf?=
 =?us-ascii?Q?HAy8lFNbp9MCs2DC6InnKUsVgi6oStqQd2D528YK3RZXkX+06sK4rtG7WSCn?=
 =?us-ascii?Q?j6tAOfhOLthBset5uvt2GSOqOaNrojv1ne0BdEkNdtUuQv6x/L8qO2B2OYpb?=
 =?us-ascii?Q?io9HY7NeFgOasnMaKm8l1EcfD02je+A9FqeLuCVEN/NaaIygpHtWBxPzV1vd?=
 =?us-ascii?Q?cRkmhgXvQPrZdbZwdihu/E7TbmsUhE4Nb9FvVbevFy5Sxn+YOsGOaPmzML2D?=
 =?us-ascii?Q?RCaL5RttCazwT1c1yXCsYvd3HWQytxkZg+Ytm654zaGSRCnQ4Tt2+JGL0EGy?=
 =?us-ascii?Q?xTxGVvtnjaflfsEPBXmHPHev02givk/ELNDQA9TmukfgV6kZmWnLSeRQAnWW?=
 =?us-ascii?Q?IiffpcwW7iNVnyyENQthxthO5j2jKbWYb0HR0YkrZeDfX18hJVfW1Tv+zXQA?=
 =?us-ascii?Q?MEmDESENhTnKvoAd3OjPCqUc/bbM/yp5voh5cAM4sQAQQbVJfA79wnIoUnvw?=
 =?us-ascii?Q?cOoiBJlRxiEDIhCsgOb5/ilzE7b2SoAz8t1alxQ0MEQ/rSxA457PR/M5ZMaN?=
 =?us-ascii?Q?wQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	0+8w4o4Riu/NLlfmeBY9B9+ul6xVtcK8R0DWXLV9jmpsnm80je9vIpszJ5mgfj9s1fOdDwBsWZkvhbsUR95WYs8+WnWczxGv7DMTl47wHgxQecyf5UiDs7QZpraaT4UHoavSumFERQZQ8nfZg8oz74dcU4mZytsBtcZFb6YcuiZomXNkPMekyfOwMF3WnSNsMwPndOh/kqQcfBhwzBcUTln3UezluG4BqMYW1VR45JvFzwOnJOoy/Ae8bKGMV5kf99kVLHMNnbw7CH/xQMYaiDuBIEOzEUsvjjzUjUFKiEaN1YyyVgbVzn/PzXSHToMZSV9SfxFodRnHFHxL7QF1yV5SsAFar+2sibCgIl/iu3onpRnE7QndHfpMx+hse1V9pcTT9w7NuBjCzL7X0ZVb2ZPc6dE6aNpS5TwfCMqHPSiSJbhVGdUnW0+rnEMJM7akSaNUekPW5jLeAgWY3aN459RB/OLJHMrg7/l8OZHf8C/kMEQXYc10Zav75Q2TIgA+Q1qhkGm5GrohUktzz9qkyVzIlAPS5Jp2eqGGnNNwCKOSGYjepAgWGRArufUxWv/BIU1pv9vx9lzoOOJknZgbDx/Ip+h9IS6sM+fNBEo4Wfc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f7391a-c242-4e58-ead7-08ddd9b6e311
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:42:47.4963
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PTd3TCpbB/ltLkqqS3XJzZxgFQzmceHby8FZ3mVAt3mhsJsFiOnaxcpxvRlTVnuevfUNOaQD8Ep0Sji99BPh2Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR10MB7726
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Proofpoint-GUID: 68v_4wNI9FhpCCmqqIB-tTRVUfkIbgse
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfXw+bz9y1k2rJY
 Abbha7nIX+mJs3eg/fH1nIvAPkfquCBW8ZbmiLyXRgEW9wAKzw3Ah7/1cuP7oQJmwoHrxSL6XkW
 aN8s8Wdqt4tMgsfAUZLLZDhEsYBMl6g6pwfmQda4HC8IlAdgvxypkRr1ffr6zBcu9qVw67840dQ
 LEctK9zUwiK4eHJDqMg3Xqr3XAa5hJk9ND4sUWyqAlVaDK/hBHN/sEN+a5fI17bzjCSoYieCk5X
 h1GbX31TlariIss/77B8IfotBTKTKsAxJDXpWZlvpP4xfuqkCnOlHBQN6NRFDt4eUGfYgOroz+V
 iqT5j0FaTF30ho9TkJlnSl0TbYcvMsmqbB4kRgrsKTdLbAqUjtkPbInhYaTMMRqmyXN3aDl2wF9
 e2kxDP39zOQ68VtpAMGuDC8cd4UUS6GHtocJGJbjhPurDSyKVZWO15eiMJPDCUMU7oJc2+rP
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=689b6115 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=1WtWmnkvAAAA:8 a=yPCof4ZbAAAA:8
 a=FxGaXRssHhVewV9F5S8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: 68v_4wNI9FhpCCmqqIB-tTRVUfkIbgse

* Qianfeng Rong <rongqianfeng@vivo.com> [250812 09:52]:
> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT") made
> GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT (e.g.,
> `GFP_NOWAIT | __GFP_NOWARN`) is now redundant.  Let's clean up these
> redundant flags across subsystems.
> 
> No functional changes.
> 
> Reviewed-by: Harry Yoo <harry.yoo@oracle.com>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
> v1->v2:
> - Added a modification to remove redundant __GFP_NOWARN in
>   mm/damon/ops-common.c
> ---
>  mm/damon/ops-common.c | 2 +-
>  mm/filemap.c          | 2 +-
>  mm/mmu_gather.c       | 4 ++--
>  mm/rmap.c             | 2 +-
>  mm/vmalloc.c          | 2 +-
>  5 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/mm/damon/ops-common.c b/mm/damon/ops-common.c
> index 99321ff5cb92..b43595730f08 100644
> --- a/mm/damon/ops-common.c
> +++ b/mm/damon/ops-common.c
> @@ -303,7 +303,7 @@ static unsigned int __damon_migrate_folio_list(
>  		 * instead of migrated.
>  		 */
>  		.gfp_mask = (GFP_HIGHUSER_MOVABLE & ~__GFP_RECLAIM) |
> -			__GFP_NOWARN | __GFP_NOMEMALLOC | GFP_NOWAIT,
> +			__GFP_NOMEMALLOC | GFP_NOWAIT,
>  		.nid = target_nid,
>  	};
>  
> diff --git a/mm/filemap.c b/mm/filemap.c
> index 4e5c9544fee4..c21e98657e0b 100644
> --- a/mm/filemap.c
> +++ b/mm/filemap.c
> @@ -1961,7 +1961,7 @@ struct folio *__filemap_get_folio(struct address_space *mapping, pgoff_t index,
>  			gfp &= ~__GFP_FS;
>  		if (fgp_flags & FGP_NOWAIT) {
>  			gfp &= ~GFP_KERNEL;
> -			gfp |= GFP_NOWAIT | __GFP_NOWARN;
> +			gfp |= GFP_NOWAIT;
>  		}
>  		if (WARN_ON_ONCE(!(fgp_flags & (FGP_LOCK | FGP_FOR_MMAP))))
>  			fgp_flags |= FGP_LOCK;
> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
> index b49cc6385f1f..374aa6f021c6 100644
> --- a/mm/mmu_gather.c
> +++ b/mm/mmu_gather.c
> @@ -32,7 +32,7 @@ static bool tlb_next_batch(struct mmu_gather *tlb)
>  	if (tlb->batch_count == MAX_GATHER_BATCH_COUNT)
>  		return false;
>  
> -	batch = (void *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +	batch = (void *)__get_free_page(GFP_NOWAIT);
>  	if (!batch)
>  		return false;
>  
> @@ -364,7 +364,7 @@ void tlb_remove_table(struct mmu_gather *tlb, void *table)
>  	struct mmu_table_batch **batch = &tlb->batch;
>  
>  	if (*batch == NULL) {
> -		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT | __GFP_NOWARN);
> +		*batch = (struct mmu_table_batch *)__get_free_page(GFP_NOWAIT);
>  		if (*batch == NULL) {
>  			tlb_table_invalidate(tlb);
>  			tlb_remove_table_one(table);
> diff --git a/mm/rmap.c b/mm/rmap.c
> index 568198e9efc2..7baa7385e1ce 100644
> --- a/mm/rmap.c
> +++ b/mm/rmap.c
> @@ -285,7 +285,7 @@ int anon_vma_clone(struct vm_area_struct *dst, struct vm_area_struct *src)
>  	list_for_each_entry_reverse(pavc, &src->anon_vma_chain, same_vma) {
>  		struct anon_vma *anon_vma;
>  
> -		avc = anon_vma_chain_alloc(GFP_NOWAIT | __GFP_NOWARN);
> +		avc = anon_vma_chain_alloc(GFP_NOWAIT);
>  		if (unlikely(!avc)) {
>  			unlock_anon_vma_root(root);
>  			root = NULL;
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 6dbcdceecae1..90c3de1a0417 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -5177,7 +5177,7 @@ static void vmap_init_nodes(void)
>  	int n = clamp_t(unsigned int, num_possible_cpus(), 1, 128);
>  
>  	if (n > 1) {
> -		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT | __GFP_NOWARN);
> +		vn = kmalloc_array(n, sizeof(*vn), GFP_NOWAIT);
>  		if (vn) {
>  			/* Node partition is 16 pages. */
>  			vmap_zone_size = (1 << 4) * PAGE_SIZE;
> -- 
> 2.34.1
> 

