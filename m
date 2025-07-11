Return-Path: <linux-fsdevel+bounces-54630-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98412B01AD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 13:42:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC9671CA78A4
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Jul 2025 11:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB762D541C;
	Fri, 11 Jul 2025 11:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="XN+Lzez/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="atB3Buug"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8C82D3726;
	Fri, 11 Jul 2025 11:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752234010; cv=fail; b=tmMC+R8leKlGfz1HJnTPlvO2u6aN0SssqXQ+IPvdezj01aX1z3uXG0U7Mj3cIyMSCSiF7omeJBzbvAyw1Xy9T13gw8qaLw7ijWB9p5OH+B0HGbPgrkN3ujQhymnc0K1HH19QkW8bvAQdstznLXaLU/38X1qxlYYhAw8pNa3lBp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752234010; c=relaxed/simple;
	bh=qvDeyu2j/V+3Ww3PP1EeZ8gUvslOVXxC1xd/HHIYyto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R/JR0cVvXwlN1hr8ATIc4CUmzSmvVyTlwEKkmcLJKdUbBMg6F6Su4KhW0Z7Mf4XwikURQFsA0Vri3u1yMNj+mZI6Q0Ygg1Tffu/XtH5VQtf5vQjDbL+EaSEnLoQkLP7E8UEYkVHaVthTZDpTSYcuHNewphc4U4LWmdaTgNyCmOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=XN+Lzez/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=atB3Buug; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56BAvd9w006757;
	Fri, 11 Jul 2025 11:38:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=2spJPZHboE0uUrbzUzBLK2KsaJH71zkyXMumgVwJwlc=; b=
	XN+Lzez/GHKhlwziIwajRI6BUwBHt9RWrFIZLzs55v9y6HyCyuKbpc/YtebsO2qa
	PLdPaR/PuHWasuXm2lM9Yl3u1xhfXJGBv53LD3PFCPX5vIeX4YZApyAIALru5GtC
	8WhUbiQO+QIzgnqD+5oIyZiRp2qIO6SfDwz9saIn+lLIyJXdG3gVXcMdJpOfML3o
	+ZKKnw6ZOLxLgRkipJ0s689Lq9vyB/yOxDo3Q+LJW+BGuqNd1RCNPua9sYUkMkI6
	ciFw7IyLyzOAyb3fQFzrkAvEfyRFOn3ItT6sE8fr+SC1VI6uWta5k6W7naKUxslx
	rpT+0pvWAb6oJLSMyziaiA==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47u1abg1q9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56B9TxDP027448;
	Fri, 11 Jul 2025 11:38:52 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2046.outbound.protection.outlook.com [40.107.100.46])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ptgdf06k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Jul 2025 11:38:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fkuCkuCsCJQu2igBtx08hHFhfTKnOmxmQp3i1v8UNovMNOrbC/EgzkYmET0vzm0Im4trikMNk2bNba17Ze1yhvrJNwGYKGD/3twICOLP2mwnMgo2D6S/W65ghBAsT93N1xgKnBZB1yD6uUgJ2QdvZCbuzV0ErWlAppUDmHZICy172Ha3CfKfbg/Wc1leXo/GDBQzBD8RuUrQje83t4F97r71qhgxx6tT5nQMzU4HgCuHfxVbcE9ngSOZugcM5xUzNc6IR9agxhSMjiHEW7lUjb1TVfwqhKDP8qFwlPspHtsTWLzGdDT5ghEeTRcsX3CEZzQGgvHoJ8K1xcM0SMDPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2spJPZHboE0uUrbzUzBLK2KsaJH71zkyXMumgVwJwlc=;
 b=iQoJa7qj+5EW6LtTyV0A/v2VB6/PbCpirjLhB2gIS7rBAb5s0jmIZ+aGbQEjX+7H1EKTXxHUaJN9N9Ej0CqSzamtZYPEsODqpCITlMtZmr9EVpZvir0iALTbERBID+t7YO3gxyIWvoxh+ipLJyLARlqMHP96uojDeqlfpnYKA5PEXORTKGcEFAqpSgp6CPtEEKGuNToxNfiTh71YIQJiJIPFb7WMhIa5DnIOiXVS3UgKAtY9ktKoc2hJNd3n53XJdSmTrYgIGo/pjPV9evCZSQCg3T8GuNucu7d11f2BaGJncCg8Vtzs75chnrhHNQ/Ec6w4rQbdN4SLVS1h6W7OVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2spJPZHboE0uUrbzUzBLK2KsaJH71zkyXMumgVwJwlc=;
 b=atB3Buugx9wdY5WKz13WxjHb90iPIWB+8UfvsIf8hwps9w1twlkEslskqGyeiA1CZECc4u7u0Q8zA4EnDSl/xEqDhuetX3n8+AQEOoCv/3g1LDBeTmoBK0udd4/bd6qD8OUthCmImJVs1EobW85bcS5bF1OhJ8vf3eRTOgSdXi4=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by DM4PR10MB6696.namprd10.prod.outlook.com (2603:10b6:8:110::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Fri, 11 Jul
 2025 11:38:49 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%4]) with mapi id 15.20.8901.024; Fri, 11 Jul 2025
 11:38:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Peter Xu <peterx@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Rik van Riel <riel@surriel.com>,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: [PATCH v3 10/10] tools/testing/selftests: extend mremap_test to test multi-VMA mremap
Date: Fri, 11 Jul 2025 12:38:24 +0100
Message-ID: <d9c6ef51fc73138ab523e0867a3fc654b88b4a1a.1752232673.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
References: <cover.1752232673.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0566.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:33b::16) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|DM4PR10MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: 853f060e-df67-4da0-5df0-08ddc06f810f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kpXOoccrclVl8wyIbPPc6fjetHd6VioKPZEp3yeBONKB69PXP0TjcPUHtDuS?=
 =?us-ascii?Q?NmYFhrLV8DT4nPLe9E8IYcoS//776oCVgdIcSHaJdct/i6nMcRwcBSv8qmuI?=
 =?us-ascii?Q?6gaJSsNa6l+J0zjrb5ftSb/kaNXz4INYN1VSCmLNWPTbtdE+cDpjVe/ugXBm?=
 =?us-ascii?Q?weQ40QHNPg0GJHEFRHjL05/z0pdK+7oGW5WTny6ACvNKMygg9BD3FuULNSDt?=
 =?us-ascii?Q?J9d3QndOXZ07ORlE+iMTsRLcMYqSRZ/beTRLUD+IGSF7aVN/7V54132j4cPi?=
 =?us-ascii?Q?SOfZRr+7RyZVNTB3xBWeRLfgW7v00PpNOZyJUw1EUOOe8CeXsgLUv7fJeuAM?=
 =?us-ascii?Q?3i3i3y0STk4GaSuYuoPTf3mtL3tV6h7htnir3Xczb8tOYE9frEiHH8ZzD1FK?=
 =?us-ascii?Q?x2eeikn2586QCDcz6FOoZbqxTDIu6s5I3mGGpsXtrdBIvnigqN/MaxHJ2pEd?=
 =?us-ascii?Q?ftEooAhq0DCDcNcNMhZZpRXGK8JbZifRLjalz3tAt4cFnPmxtfpZTk/cDGqB?=
 =?us-ascii?Q?yX1ZODDAtLMrcGxez/euxPVySydjHOTpUti8W0uYgwnYsj8HzGClP9kXkjvK?=
 =?us-ascii?Q?jwlA+LveH3ewgnOKHK8yC8SZwz/dngwa5UojIMR104RsmtsIb+3NEACvq8gO?=
 =?us-ascii?Q?YCiBhlcKEb7ex1iN+7ZPcRFD3uzpgqd8ozhHJlFgrro4rdjx9qC5nbnJWPKU?=
 =?us-ascii?Q?9MidZcE/JMGi8BlhKRNLshntp03Le5ffv5H2ZBGMAbPgnXbekvz4GrfkQnwg?=
 =?us-ascii?Q?eOYrJLCcXxdfzgqkvyLBpz7QLs6HqEAaggGaL0BiGe0/y7UPbP6322mXtXc7?=
 =?us-ascii?Q?3U/Rc5mwlwrwCTEPC7BxjGQhovUR9yk5hk3rYePby4bc03P2f9eOl6cydTs7?=
 =?us-ascii?Q?D9nFEfu+X8vBf2A1xo4DIWBACuElVkxxt7/A+9tVELb2QufAx8MCYAOQx90k?=
 =?us-ascii?Q?TUGMY1L0i7b+jSzn5GeMj+7j7ocs7XXZoSUy+EMB/TVhXnWL/bZld8g44Crr?=
 =?us-ascii?Q?34APZ7LVsrORPOT8R/2CogNWg3hjzdwUMYlSUIhnmCy/8qYrgRZDcN1fwxRz?=
 =?us-ascii?Q?9tIT3ageX78lhF2Bf3HGQVZoLa8ZAl4eCp6ggHFgyGNIaOBUeIB5i0hixaK/?=
 =?us-ascii?Q?wAm8TflaLsUOVNgfX0Kw5CC+JBndiHI5JEcAERZ7fwNOFtJIfJUaNiR0F4R0?=
 =?us-ascii?Q?Bp64sE/dGtcN9bJiWXDYJg9OhvDbJzUA6QhD3byNOXxMJ9XCH12Ia9sCtw5f?=
 =?us-ascii?Q?aKVKdukuz0PBKmDqjX2Ewxmvt1mGBrlFMw75x9bjaA4sjO9shpT/nfde5vBG?=
 =?us-ascii?Q?r9/3jfCMa7bF5Hbnp0j734z8NEx9XaQfMN5Qh0rABTuO2+SyB6TPRK0vMvqe?=
 =?us-ascii?Q?DBNGd2jtZn07yIgcI/Di6ET1p3EkeUlJtMMhkYJ6xhqnjl6ghUcQLmYtyRwp?=
 =?us-ascii?Q?AzoYI5o9Aa0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NTXOgjozFa0DIDjqi9tFp4u9G6KmcDsVOir/wkZue1mROeFJWszMbUG9PVu7?=
 =?us-ascii?Q?1UWq4qUv0RomJEI4d5cQccv7S+NNWkNA6Yf6Lr/Em9IFj/t8h8mtkitOglum?=
 =?us-ascii?Q?vBWKYXDAxmvYMtxUHRC9n61VzvA8FPamBShhMI1ueP1HkMYoB7iIxpWp4TG1?=
 =?us-ascii?Q?r/gPnxGMEceHtoSPgghkEXd6LDxkcTkzTSyTJBuNWkDd2oYq0BLiV7WE/CqS?=
 =?us-ascii?Q?0TPXGwru+VExHDwnOW3Zy6YhvpNGyPyPbbB1ctWNpRCHsxrketjuGTJwTaPB?=
 =?us-ascii?Q?9+Z1lEfyS2fCqpTqBh+h5JwrXMZqoEZrB3RH+yYnJjTYjoyvixdURVj3Fydh?=
 =?us-ascii?Q?/m33YWZ1tFsK1FJPQJdR3ajLJ1vY4kD2HKh672x5jWNSt2kR3/jDCqBACiaX?=
 =?us-ascii?Q?2+Vm+l1bXlDpEpgmZi4SFrLCPO6Db3iUZr1LqlfAE1WndUpLdqVDZU0HLswv?=
 =?us-ascii?Q?2ulpfYU0pVYhVctUGSlY+sWIpdzgFpelxZRJFE26jSZc2f6BufSs6S5Cm5g9?=
 =?us-ascii?Q?ZQ9ayfvJNUgB+T2RDYdOEV0DP7AJKcDKzpbeJ4MceipGa2VdlB9M50tfTJ/x?=
 =?us-ascii?Q?hd0SQw2txCVVQOksccQh8YFTP9mW1PUJqdzLMdG5wzyZScIMJ5eIr2b+S69F?=
 =?us-ascii?Q?hqrEH0nV/HNT98EEwsLUAm9WiJIZkFSI0X+rWaYhgehGMCVxqxRoCJi24uE/?=
 =?us-ascii?Q?Bm1UyM18Amph9xXKCDbqGD8ZwIRE/GJLhACRJ2GRSoFfE3YzQ/lUO0X9OpYE?=
 =?us-ascii?Q?fbziNG7WJglvG0TJzrGGHld1aNbBV+0h7NsoYhTqhJNhcuZDLlo5RWPlOS4h?=
 =?us-ascii?Q?AVomNMKTZu2e8BZtbto/SrMeH6UH1DwXDPvk/nhX1d5qik+JWNFlwTlr/c9A?=
 =?us-ascii?Q?Rhrr9bASxr/SImocCampX3fUww2b5SjBfSqV6Y8UKa4i8TOmmhyMQoxewhZ7?=
 =?us-ascii?Q?L9kBFnvw02plBcyLCfzqRQU6Dv22e8K/+jMJN1X32jIYgBVVGn+4lR6lxGy1?=
 =?us-ascii?Q?yeMHR1WdnTbw4ryM8myZ0BRpyxXapzKfBBf6hlqh/kJW0BAHRTRyET+9bmpn?=
 =?us-ascii?Q?pHxBcjZk+sFBBLg5W4AyxXhEqJ6l8WePFBxIH12b2VZIaZ0ndqfBvKeIuHok?=
 =?us-ascii?Q?Yxl5sHHP8EB4YwzqW8o7QxfEUFJ9A5ZaPpGiFwoE5cY6MeXATv5FrxvecJKO?=
 =?us-ascii?Q?HEvJH4zjwEKDQNWy/uhTZLXXguA/aplkIh6w/gFY9BhB5dE0yTBB4MxAF+/P?=
 =?us-ascii?Q?v8fwfbKu6orXkrrIe8ewwprHLbafg7koTVCLDJ+g5Ta6z6QwT3e6EFg9AA9U?=
 =?us-ascii?Q?c0M3Wo7g3epqES3zvYNuDbqn3lqcCn4ofT2bTnnXw4cTQZ6sit/IGAHRYqXP?=
 =?us-ascii?Q?wzRQPEXgIRit8f9IlPplga68euontaTW6XitsxIpNrzSYN2K5VaeeSDyF9RW?=
 =?us-ascii?Q?jOzfRUqkHSJE2T8TAWsrScYMFPZUECT12YRT92bZlp2Z7+ShnEMv0KE+QzJk?=
 =?us-ascii?Q?singfUyUVECo43y7z83T4qmo3KlBgRzLPznD8SQxIbsOBQqMCeLsL879Y91C?=
 =?us-ascii?Q?UlXJ86PsUj4Ub5OHzCd+tYfjrl0gzWebf8ylrhSs4wG18XdjkbPpBupwSlb6?=
 =?us-ascii?Q?ig=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nD8p8AfFdFdPlLdj6rrJY7TD3GNUFr+qLG2tCL58f8RH+Ovb9hU7KKZ1pMWcQoYOP6kgYacP250FTTfCPjGyB4OlXV9kLeRfbvs5px28Rys1XRYkZNBNl5uMfsx024lkQx9Is1YdK+815zq4srWUVCA+pr+PS9EdV2x4Y4z8OCMmnvbNKesXIg4phKj/UuXVDTdaXxL/xGBGdY4KGAnTILKiWALtpgr4I3WHiYHPTduo1+0WLTGsxmLFnumi2nne5wJiER5q12eLb4WBs+ZUUfFSoYEkkpnrszz/Z7ndW1Ovk3BgfTpSiAiMQ3Bjs7h/6xfLfpQNZ81OuYS82vs9W+6CUhdV42FvTKFW1WtzC10naf4PyDXKPzS+JSYr7aSJS6h2IuIoOmfY97sLBP9hjXyAB8Wbdswifyzr1XzULAjK/DsCXGLDM55LMvYgHE2/k2el89T93l2LjWmvXCIdKNnB+5+dgx/hImO8EP8Zv4+3svRfVtx0tDHQhGl3oP2ZiObb8tB6KithrrZE9PDOcyVVFCCztezX4ZlG/jFAj2rsZrz0A3HvSA5Aih+P8boynKi8RaTz9ZAHVMxHdmydLFEyOycvN96q5hzicQpiaeM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853f060e-df67-4da0-5df0-08ddc06f810f
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jul 2025 11:38:49.6163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4IlcVQZy4QOAzD9en07gP0uROk3KTJkJf+Pl3ySVtOu3LNRhCMPq87C9dWtZWKLno1e6P4JhskYDJ7N2EOKA2OFIaTeIFYYJyVoBWPAWhyg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6696
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-11_03,2025-07-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507110082
X-Proofpoint-GUID: CkWpOopSDicvRNNWUpMOK7PRKKsQrzai
X-Authority-Analysis: v=2.4 cv=JoHxrN4C c=1 sm=1 tr=0 ts=6870f7cd b=1 cx=c_pps a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=GuY5gsdr9MwsYxRlPWUA:9 cc=ntf awl=host:12061
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzExMDA4MiBTYWx0ZWRfX64KMgDqb49xz 0ZXW5OHtqBbSiqk+scos5M39vtXT/5zM0og1KCKSPMwN2xkgTGx4yHS61qCtWTc8fTdrwmEYTvu ujWcnCURDawwdWclsoVJzj5O8isXKxgnWit/5mo2Gu13c6ozcQhy3eR9WUpV94c/iJ/GKVJD1W9
 2PrZ8FLn0Q9rQ5eWNOcVlAaPZMSIk3+/OG+VmQJq+u4FabNQwfdtgcwbpGNOz0D6F4RtTb2TUxk FQ/VMvfCaoo8NF0paflDXXeIbH0az0ZHjmtPs6xFCvBMzbNb5c+oo1Uqx0kf9smESHCItRvOJxB SuM1sX9ojZgQgKMArDkSOBKPlfkxEM/RsaYenX5v577DWDYMUmNGBglPX03bGU5uJKO+HaxP3ec
 9XnazLhy2SdOIBzmmCuZVNwg1hzcnpoRAmiH164prS0Mze4WkhvxF0+Jgcn8ksu+U/vNutKf
X-Proofpoint-ORIG-GUID: CkWpOopSDicvRNNWUpMOK7PRKKsQrzai

Now that we have added the ability to move multiple VMAs at once, assert
that this functions correctly, both overwriting VMAs and moving backwards
and forwards with merge and VMA invalidation.

Additionally assert that page tables are correctly propagated by setting
random data and reading it back.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/mm/mremap_test.c | 146 ++++++++++++++++++++++-
 1 file changed, 145 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/mm/mremap_test.c b/tools/testing/selftests/mm/mremap_test.c
index bb84476a177f..0a49be11e614 100644
--- a/tools/testing/selftests/mm/mremap_test.c
+++ b/tools/testing/selftests/mm/mremap_test.c
@@ -380,6 +380,149 @@ static void mremap_move_within_range(unsigned int pattern_seed, char *rand_addr)
 		ksft_test_result_fail("%s\n", test_name);
 }
 
+static bool is_multiple_vma_range_ok(unsigned int pattern_seed,
+				     char *ptr, unsigned long page_size)
+{
+	int i;
+
+	srand(pattern_seed);
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		char *buf = &ptr[i * page_size];
+		size_t size = i == 4 ? 2 * page_size : page_size;
+
+		for (j = 0; j < size; j++) {
+			char chr = rand();
+
+			if (chr != buf[j]) {
+				ksft_print_msg("page %d offset %d corrupted, expected %d got %d\n",
+					       i, j, chr, buf[j]);
+				return false;
+			}
+		}
+	}
+
+	return true;
+}
+
+static void mremap_move_multiple_vmas(unsigned int pattern_seed,
+				      unsigned long page_size)
+{
+	char *test_name = "mremap move multiple vmas";
+	const size_t size = 11 * page_size;
+	bool success = true;
+	char *ptr, *tgt_ptr;
+	int i;
+
+	ptr = mmap(NULL, size, PROT_READ | PROT_WRITE,
+		   MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+
+	tgt_ptr = mmap(NULL, 2 * size, PROT_READ | PROT_WRITE,
+		       MAP_PRIVATE | MAP_ANON, -1, 0);
+	if (tgt_ptr == MAP_FAILED) {
+		perror("mmap");
+		success = false;
+		goto out;
+	}
+	if (munmap(tgt_ptr, 2 * size)) {
+		perror("munmap");
+		success = false;
+		goto out_unmap;
+	}
+
+	/*
+	 * Unmap so we end up with:
+	 *
+	 *  0   2   4 5 6   8   10 offset in buffer
+	 * |*| |*| |*****| |*| |*|
+	 * |*| |*| |*****| |*| |*|
+	 *  0   1   2 3 4   5   6  pattern offset
+	 */
+	for (i = 1; i < 10; i += 2) {
+		if (i == 5)
+			continue;
+
+		if (munmap(&ptr[i * page_size], page_size)) {
+			perror("munmap");
+			success = false;
+			goto out_unmap;
+		}
+	}
+
+	srand(pattern_seed);
+
+	/* Set up random patterns. */
+	for (i = 0; i <= 10; i += 2) {
+		int j;
+		size_t size = i == 4 ? 2 * page_size : page_size;
+		char *buf = &ptr[i * page_size];
+
+		for (j = 0; j < size; j++)
+			buf[j] = rand();
+	}
+
+	/* First, just move the whole thing. */
+	if (mremap(ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		success = false;
+		goto out_unmap;
+	}
+	/* Check move was ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Move next to itself. */
+	if (mremap(tgt_ptr, size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, &tgt_ptr[size]) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, &tgt_ptr[size], page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+	/* Map a range to overwrite. */
+	if (mmap(tgt_ptr, size, PROT_NONE,
+		 MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0) == MAP_FAILED) {
+		perror("mmap tgt");
+		success = false;
+		goto out_unmap;
+	}
+	/* Move and overwrite. */
+	if (mremap(&tgt_ptr[size], size, size,
+		   MREMAP_MAYMOVE | MREMAP_FIXED, tgt_ptr) == MAP_FAILED) {
+		perror("mremap");
+		goto out_unmap;
+	}
+	/* Check that the move is ok. */
+	if (!is_multiple_vma_range_ok(pattern_seed, tgt_ptr, page_size)) {
+		success = false;
+		goto out_unmap;
+	}
+
+out_unmap:
+	if (munmap(tgt_ptr, 2 * size))
+		perror("munmap tgt");
+	if (munmap(ptr, size))
+		perror("munmap src");
+
+out:
+	if (success)
+		ksft_test_result_pass("%s\n", test_name);
+	else
+		ksft_test_result_fail("%s\n", test_name);
+}
+
 /* Returns the time taken for the remap on success else returns -1. */
 static long long remap_region(struct config c, unsigned int threshold_mb,
 			      char *rand_addr)
@@ -721,7 +864,7 @@ int main(int argc, char **argv)
 	char *rand_addr;
 	size_t rand_size;
 	int num_expand_tests = 2;
-	int num_misc_tests = 2;
+	int num_misc_tests = 3;
 	struct test test_cases[MAX_TEST] = {};
 	struct test perf_test_cases[MAX_PERF_TEST];
 	int page_size;
@@ -848,6 +991,7 @@ int main(int argc, char **argv)
 
 	mremap_move_within_range(pattern_seed, rand_addr);
 	mremap_move_1mb_from_start(pattern_seed, rand_addr);
+	mremap_move_multiple_vmas(pattern_seed, page_size);
 
 	if (run_perf_tests) {
 		ksft_print_msg("\n%s\n",
-- 
2.50.0


