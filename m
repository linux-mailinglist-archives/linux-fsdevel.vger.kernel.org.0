Return-Path: <linux-fsdevel+bounces-47298-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27966A9B9B9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 23:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42BB0468106
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Apr 2025 21:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 634D2292936;
	Thu, 24 Apr 2025 21:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KggXawYf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dmBKUa0m"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A860C28F937;
	Thu, 24 Apr 2025 21:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745529368; cv=fail; b=JOnKo4OiM2xiZ6bLWCGyS7Fa0TesJC1gSJ8wvoQofhhMfpU210jm3x4cAv+9pjPyp7nX5NsYotfeGg9NP96rodcZ4vy3G+FoLWIQezrSY55Tijhr8nNq4LqnWj99dQ3VEoxdCrQ2FzwDfPfd32AGBDSBDl6LWto8Dwo+4KnsmyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745529368; c=relaxed/simple;
	bh=wRIklGps7osMNu1O9HzhWBZupoHOuyoh70XG26+ZYz0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jBFcH4eg90Z8apUhPJm8Roz1fITqn8NB8bqbiHjxVDK1sKLgvfAtRh0x5QpoT4G2hrh561EIM75ydm7NACZSgiNI4EUo9wvlq2pjTw1f+ZuIIHddNRE9KHVfAGKpOE1z/44bDswGrqbVB34+lgBBdyZhA8PDukH5ld0PApbnW5A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=KggXawYf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dmBKUa0m; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53OJgFc7012251;
	Thu, 24 Apr 2025 21:15:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=1WJwhaM3Ah6VxiU817bwU9dqKKHHLV6dhxQPqZs3Lxo=; b=
	KggXawYfdLDw56NdsoJi1tshnmfkVEWr5LUk3wklkS0SujGxt0jYg91s3JCAQVdS
	Ek31RX993QwBFf1n20PlyL3MuLK1DO34vOkw4cgyujGGm+uGmTTUcZevMmWT2nr+
	tdGebXkQJzSJthyv120p2J39e+EwWQe59dMo7gfhu5vSEDc7CA0fdnpp1RzrfyF/
	BDaD3Ty1aRScUX4e72xJ/woek8JtrYYGxdM5QXYj6PhGl0kvxgmh1d+9E3RvEQzd
	5VKYFIx8I3tcwjxX6k+A28TmwSTxKcZawMc3cybkB4Vyx4O/jW9Ueny/JCJ55ET4
	W48YVVlp0xp7rvCzYj9oHQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 467upe07hb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53OKp9eA031703;
	Thu, 24 Apr 2025 21:15:46 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2048.outbound.protection.outlook.com [104.47.70.48])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 467gfrxs02-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Apr 2025 21:15:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u6BPvg5IYvpic+ap3dvwebyRhnlCFIJBvUCboTShQbl6/MNNeIT200PavuWz8v4VNyOerp6Gnx/mBTjQC4gTOTVMVTSK8tjQRpMVRURYlFTqqbQiHY1SFdKJ8FV2LoIKJM5ODYyMJwI3cpPEGEeNiELNCw9nOQlKcNXiGuexJbCzVvTEaysPTW8P50+7eXh8wRlzlxbC8VRfF99OZ9mvxGI4nIzmQ4JhytcRD2hqnZvbPdqGW9RnZXazFzr2ltDnqeai8vGF12jPAExHgeHcwZT2xDQ4hgd72YVNgoNic2LVlYffCeHkTkUpG9W8aeF/Yo3j4IDnk4epiUvrCmZCBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1WJwhaM3Ah6VxiU817bwU9dqKKHHLV6dhxQPqZs3Lxo=;
 b=qj0Rjfrh8hTmN+jRI8DxHi3V5Uq9+VdwqwopED1kF/ttY7cV06/ASSMLHYFwubKoVfpVgg6/aaKdUB+XgmtkPBdTtvt6A5Z7Oh2fWrfSezuZ2b6uxsk0NVSn0s4DKwD4StKHoD+WCUNDuHPd7sAWw2EgoOKZXgVGtMCTb0WM2yAWVX2mGx6F+6VY7j7cKCGePBkU5dg7ZmudR61UbuSDyHVtTwqztO96Ancc5Ce5u40QqOVwu86nFBPN6vXtfeXIzKZMSTjELnYg3JRVZ9UcfcQax1/he4VeUocnvX/RSeWx5BUvf+4Ke7bju2XkRuEaXs5fbWUzyqJvIV1B6jvYnQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1WJwhaM3Ah6VxiU817bwU9dqKKHHLV6dhxQPqZs3Lxo=;
 b=dmBKUa0mqDYCrLJ9zEpo+QIRsaUX95l7y5IVrTIxacT7YtSOT+00yNjcZ5CTEGWc9Z+NWFWjQJ9azMHzgP4R7WBAQW4XfyRG53J22QRev73ghvK27cidNjVQ7ijNd2B2h0t07eL6izgpLfZMMeohOo4otkglAteJkZ2feNaoT+E=
Received: from BL4PR10MB8229.namprd10.prod.outlook.com (2603:10b6:208:4e6::14)
 by PH7PR10MB6225.namprd10.prod.outlook.com (2603:10b6:510:1f2::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.40; Thu, 24 Apr
 2025 21:15:44 +0000
Received: from BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582]) by BL4PR10MB8229.namprd10.prod.outlook.com
 ([fe80::552b:16d2:af:c582%3]) with mapi id 15.20.8678.025; Thu, 24 Apr 2025
 21:15:43 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Kees Cook <kees@kernel.org>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] mm: perform VMA allocation, freeing, duplication in mm
Date: Thu, 24 Apr 2025 22:15:27 +0100
Message-ID: <0f848d59f3eea3dd0c0cdc3920644222c40cffe6.1745528282.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
References: <cover.1745528282.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0040.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ac::9) To BL4PR10MB8229.namprd10.prod.outlook.com
 (2603:10b6:208:4e6::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL4PR10MB8229:EE_|PH7PR10MB6225:EE_
X-MS-Office365-Filtering-Correlation-Id: 239ab0c5-4416-4e0f-bcd5-08dd83752c3c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?X1F4qiVSjAHrgSaSTPm5rjIx/OG0Y0YFSElqEYV/lL1rPNU5MGtjZwHMdQWg?=
 =?us-ascii?Q?bi3mUCM9wg1qkZgV7ZAshCa/RoaL1LZp8i+9imM9KaRqli31Pf0RqFdKfU82?=
 =?us-ascii?Q?+1GMXFv6Cwuz3CSD35uSELpMSXhcShpvwQ6ZDml9W7fxSsrHlVKGpkjzio4T?=
 =?us-ascii?Q?MxiGR8IqmDMLX8KfaPKilOKktZ+z3W4+3ddtdovbKSgVtO0X0w+PYXkshkiw?=
 =?us-ascii?Q?wk+IU26GpyS3vK5bVgocQjKzvl2QcK7KTrt2NHSRPeaLyIqg8ZUoVDRuk/Zi?=
 =?us-ascii?Q?WdW7GQ0HWNbUoxb/KRxD950SsDqEKrxmU2BlwfG4215Ysqad4ppsb/G5yaul?=
 =?us-ascii?Q?uoiJpB4kFDHMAGx4/n8kjrq3rX8Y9BqEPf6bhB2JPhABMJ8mf4GHHlF/95zE?=
 =?us-ascii?Q?exJMskKsWz1ZIfgPK2L0oqjzm/WO0dCKMBK/uL1jHCgPmLz23dkHBue2I2/A?=
 =?us-ascii?Q?P8aXJ2widnsLP+9qfcXj4aVj7CK10MvwS+pOmmGma5WNGR30Da4KRSFOn9l2?=
 =?us-ascii?Q?AJI4jdKMzYtikOE9dEdHFtoyz64FWskbnlePcCldC/TkPMyft8iwVUQ4iCsQ?=
 =?us-ascii?Q?CzQbn20qQ3ROKlT0DBNGukTosEOhdmjqejBPYjIYi+wnyS/oxqoBVhPFU60A?=
 =?us-ascii?Q?v9WsqOKrHUHJXP9Rt2A4+XLDmhMEtkICtGv7Xj/YD+53lhsC1qDgUI2Rg194?=
 =?us-ascii?Q?r1VY9J9HdA5BPPjjDIFq/P4OMihP4lFiSYjqWDL3b0SN2Eh8v/dkJ0eIHNkx?=
 =?us-ascii?Q?uzJnbxI8n+FmxjW/HGLxxXhVxYVxBUjRXz1OYpwK0buqC0YORaMYDE9skHnv?=
 =?us-ascii?Q?8sVrhmw/wjWMur0+ON5TGFNtrfZ83PeHHgjC3me4BOQu3T3tqNyL2Ycr4xe6?=
 =?us-ascii?Q?b/SjFDkVdnymA4G8dVU6bNcshXaqIw0TeI0xk5EhH3VguCHft8zuvsAtui1a?=
 =?us-ascii?Q?uVR9P/6xVfrFRsokkICgjJPy0F1FGpoH+rzmgxZjlGnTm3g6OBXJ3hD5io94?=
 =?us-ascii?Q?enM1nYvNKQuAvzEPlppI/SEYJ/4PRKcVZwbbv4AN56XNIzmdYiXLTpCXQ6yu?=
 =?us-ascii?Q?w4D0tsebvhXwlQ4n4q+uyXDtCzFQIAP79qcaAGsIz21OzvwoKj2pRTGksUtc?=
 =?us-ascii?Q?Je9lplwRpNQitLvbhDce5e2cRZ0ptc/s1bXyZ3dytYJjDGP0GHHzCPCqtRgN?=
 =?us-ascii?Q?U3TrPhk3/ElMI5s5nqhvERyvFPeWGFmwL55Xhrgs4KGKhi2UpDC/YZuKKxPZ?=
 =?us-ascii?Q?4WiHakx2hHErWmcgidnuzGxDL4YceATXZ0E3do9W6fzQEF/PXJT0HhB04eDp?=
 =?us-ascii?Q?IGj174OvVOvqDV5r+dkcdZ8z2MH6GZ3Zy3P445yd1DOOObgApIRpY/9zw9UP?=
 =?us-ascii?Q?3AjRSDIP7PwAtsHnJThI/DHy7mAlqsdiQHdjHUn8bx+8sByutQE4zrjtcYE6?=
 =?us-ascii?Q?65BC78LTGIo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL4PR10MB8229.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JpBEhkxP12ZO+lMP3GFogTMJYEwvXumkLlW2hbACSWBv4wg991rQIs+AYsK0?=
 =?us-ascii?Q?14FJ7rtAUShONpwS33Paaiy+Lmh0xuvGuuhPHhWFAU+LRcGzcqHPL4F3gKN3?=
 =?us-ascii?Q?RhsQmhwrwEcRwstST3WVizTT3G0gkqyopI1C67kSa1kvJaKKXhH2M6ItBynu?=
 =?us-ascii?Q?/KD4dJs10+WG0e1MDQTuIPncQF6BBP4Lv6vEEV1pWnIc/5D/SIXzmTAyGPRf?=
 =?us-ascii?Q?6L5ffKwggkFuuCO8z/iarvos6D6C7La0tqZlEsRnBCcg5/0c69kaPKVjVKbL?=
 =?us-ascii?Q?q9WLb6TgYmBI0cF8eJycxiKQWMWGg9Pv/giKiYYmhUObBaTHMRTWDdtOQdxk?=
 =?us-ascii?Q?zvE0GybRy0UA/1B4rDPvcjHh0n8QTkxKdpdRzXkyCTNg/h0lvKB8o6MpoUz1?=
 =?us-ascii?Q?AvTf2S3bGNUwcKdTWiiL1jW8/4N52MDp9vV+VTGcfsE9j5rjA7i2tpc5owv/?=
 =?us-ascii?Q?CtxspR2dWenEikOc9KWo7zlVkEo41x8t/0nA/kKYwV6R9cA7oFC3f99SQFCW?=
 =?us-ascii?Q?qt/hserNXvSu9grTGlfwdisn2L/m1yBYl10Bm5QpSZuv/MPOWO06pVJgnmid?=
 =?us-ascii?Q?44KxEXykjzZSHYWkPL784kM/DA17Zsdj7XEQ1JW1w9+VO1RNYYe1MZvY1EEO?=
 =?us-ascii?Q?oguLXn6ShHnnx6ukQyaFq+KbJanDLKQLD/noVA/0Fdyd0z+PS7J9lZ1MNgfY?=
 =?us-ascii?Q?nOn1CSFNvNcOLp/j6RepVsTmCBd5EjwcndTwmmUdtVHiR3V7vkD9/CafRcWi?=
 =?us-ascii?Q?4vA9MzjFfqS0hG5fhhlO6sjlqbRgU278WekVd8z+aWvgkHFjUiA7MyeUWQ09?=
 =?us-ascii?Q?98EXbMXRzTbDk2G8IAdtfoeXc5bHTrOUbH1kE2bRVPxHaNkip/9xjFZuev7K?=
 =?us-ascii?Q?8E27zDZ1g/T+UQMLdlRhktR2AtRgKglnGwN53I2hC7/0/QPIs4qCw5mHQOOX?=
 =?us-ascii?Q?4Hn1pSavbkpmLa30VPs7Wk6zwBChEcnvsW6nC1tdRrbWoVTuWO7AJPx0eILW?=
 =?us-ascii?Q?Hu9vUouTgFJ+CjGrG4d4hADdVq/NG7mOjS3QNHNzq2EcHPlQSyrkKfjOdHMo?=
 =?us-ascii?Q?xHceARDYMn33xEw0VcInBrw0VDBSb5r1QFYKqLvN+7C1SDgbJXTYAXxvgUsQ?=
 =?us-ascii?Q?a1+0ETP/cLmVak32yyDLkS8AATsfziims+dvymNwxZfYsoaJI4LJ/1KaXW10?=
 =?us-ascii?Q?KfE04Q4Bfkq6YbguwKRS82u5ZstIqncZfzcF6KHT3ci+qJ1BF3Tmndsbe2Uq?=
 =?us-ascii?Q?oTHATZu2C7ffWXAi6XNVaJBk2ByIQWSOMWnG7aCNOpFZ0Av/slBLTrTxOYSI?=
 =?us-ascii?Q?xz6FVTnGkB/lJ3y3LbbXFHM1JEfHxb7tiuh99zKy0Wsk1NSzVUwMzODJEcbq?=
 =?us-ascii?Q?7p+54W+lCzWKOwXL5gxvRByYld62ONp6KXzfiQlRMptPv+gjwOBxDJSWwi8L?=
 =?us-ascii?Q?oLf63EMJyiim2fwBuIBZVxNYUK1t7JEr6BO3bKCojhWVv2FuX1bvPmRcb+zN?=
 =?us-ascii?Q?FH/Lm4QB59aWpxQ3bxp0p0mWeLm+2gbCDku7IOoCTZCjHrMoSnAK4prEene6?=
 =?us-ascii?Q?IWeTG/r95h26Zoq1PZDzcdXiSRetzPIDTR1WmRDgYviLMMiiBKaxP8EBRbAg?=
 =?us-ascii?Q?Vw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D+FNR2w5YWKR9ENqix5WYl8VUu4lFr2F67EIw/AJ+p1b0KXFZIDSmY9BKXd8ystyYEJ4+k3GycHsvE8hIKh3Ok1WjBklbhP3VXyGLiLSbSgbiIjKuQOXUqOFouHM06dqobbf0NRfbJaNtYv11qJPiVf9NVFS4tnlq+zbHcsknD19YVCDysad8+akgj/keQgGVgJydxD4aQ2pb70dyTM3nq0PTunj2I/2w68FXnkYe1xSzQwYgeItkIH1qvvKNdXS4e+3P/SlnQbVHd0+iB7GRvQh8KqcCGogScFezvj+HrkT9ZbDluVVls3XorXeGL6nbzSKR4M0/EQDgRJYngfOYlj4xqH9PU9VHAFe/edOgwk78iDoZu5rCk+JjuqM7dz1TJdJmkfisMoNfgVYlMu88pKOXrVmaQ4yUKLIBRhsowXWI/eoT+qmq9/9fOWqa7hkTwLxYZbQtbYe+MXYjGZWLjvE6mymEH2HlH6/KGT+qSy8CTUKaijNgOgLbxpWXJqa849AgarBFlW4iggh75rG/+CHuoRAHgGG/0q5oHkrKkOBrQprjiiztu/igIVDqbKHfsPYUjS/cKXUX2emvfk9chvcEcnqkfKB4pok2xLgVtI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 239ab0c5-4416-4e0f-bcd5-08dd83752c3c
X-MS-Exchange-CrossTenant-AuthSource: BL4PR10MB8229.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2025 21:15:43.4380
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4kotbaGkdNqKSQFiYReb4AUc0X46iWGcR6YtEZG5VH+TLzhPY7ChYk81fHOOC2UIYb6RrDW22Kzxv9Z6F5UaVuD63pEouLJlprQWnu2E6As=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6225
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-04-24_09,2025-04-24_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 spamscore=0 mlxlogscore=999 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2504070000 definitions=main-2504240149
X-Proofpoint-ORIG-GUID: i45UHAl-4ip0oAscoslgpZefBOYiEOQm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDI0MDE0OSBTYWx0ZWRfX7ABDMEWGW7EN +YDq08Qfc0skXzk/agtUPHxEN+GOFlTF6LAt+2luE3Rb4OyHohCCWfZRgLTB/18/+vq1nIrqrvH uZSPhj1g519cmAOADW2QYBXxqMa1rTu/Opr97PsPiO2b0qfiIa2UWYclIzDjoRGd/5sZzBPM5Qt
 Tackf22rsXKSjUG0DMjg0NdjSGPWDvGkrEXpBFIpkTex/3XHMPUuBfgEA38HhVRE3gOlwPZUYeF 1EIzRP9umDAPoqISb1wBVipqpG3ahzhU9mpmW3KD+alQLpNk6r1jt7wNCzNWe1GovJ2s8YZjSNm QeYKSvB0crBM4N1btdfqghoKfoyPEVNWHe5g//ftHih5dwfqphOB0foOCAYH4CsEhqQCO9aKTPc nM41Qq36
X-Proofpoint-GUID: i45UHAl-4ip0oAscoslgpZefBOYiEOQm

Right now these are performed in kernel/fork.c which is odd and a violation
of separation of concerns, as well as preventing us from integrating this
and related logic into userland VMA testing going forward, and perhaps more
importantly - enabling us to, in a subsequent commit, make VMA
allocation/freeing a purely internal mm operation.

There is a fly in the ointment - nommu - mmap.c is not compiled if
CONFIG_MMU is not set, and there is no sensible place to put these outside
of that, so we are put in the position of having to duplication some logic
here.

This isn't ideal, but since nommu is a niche use-case, already duplicates a
great deal of mmu logic by its nature and we can eliminate code that is not
applicable to nommu, it seems a worthwhile trade-off.

The intent is to move all this logic to vma.c in a subsequent commit,
rendering VMA allocation, freeing and duplication mm-internal-only and
userland testable.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 kernel/fork.c | 88 ---------------------------------------------------
 mm/mmap.c     | 84 ++++++++++++++++++++++++++++++++++++++++++++++++
 mm/nommu.c    | 67 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 151 insertions(+), 88 deletions(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index 168681fc4b25..ebddc51624ec 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -428,88 +428,9 @@ struct kmem_cache *files_cachep;
 /* SLAB cache for fs_struct structures (tsk->fs) */
 struct kmem_cache *fs_cachep;
 
-/* SLAB cache for vm_area_struct structures */
-static struct kmem_cache *vm_area_cachep;
-
 /* SLAB cache for mm_struct structures (tsk->mm) */
 static struct kmem_cache *mm_cachep;
 
-struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
-{
-	struct vm_area_struct *vma;
-
-	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-	if (!vma)
-		return NULL;
-
-	vma_init(vma, mm);
-
-	return vma;
-}
-
-static void vm_area_init_from(const struct vm_area_struct *src,
-			      struct vm_area_struct *dest)
-{
-	dest->vm_mm = src->vm_mm;
-	dest->vm_ops = src->vm_ops;
-	dest->vm_start = src->vm_start;
-	dest->vm_end = src->vm_end;
-	dest->anon_vma = src->anon_vma;
-	dest->vm_pgoff = src->vm_pgoff;
-	dest->vm_file = src->vm_file;
-	dest->vm_private_data = src->vm_private_data;
-	vm_flags_init(dest, src->vm_flags);
-	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
-	       sizeof(dest->vm_page_prot));
-	/*
-	 * src->shared.rb may be modified concurrently when called from
-	 * dup_mmap(), but the clone will reinitialize it.
-	 */
-	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
-	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
-	       sizeof(dest->vm_userfaultfd_ctx));
-#ifdef CONFIG_ANON_VMA_NAME
-	dest->anon_name = src->anon_name;
-#endif
-#ifdef CONFIG_SWAP
-	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
-	       sizeof(dest->swap_readahead_info));
-#endif
-#ifndef CONFIG_MMU
-	dest->vm_region = src->vm_region;
-#endif
-#ifdef CONFIG_NUMA
-	dest->vm_policy = src->vm_policy;
-#endif
-}
-
-struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
-{
-	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
-
-	if (!new)
-		return NULL;
-
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
-	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
-	vm_area_init_from(orig, new);
-	vma_lock_init(new, true);
-	INIT_LIST_HEAD(&new->anon_vma_chain);
-	vma_numab_state_init(new);
-	dup_anon_vma_name(orig, new);
-
-	return new;
-}
-
-void vm_area_free(struct vm_area_struct *vma)
-{
-	/* The vma should be detached while being destroyed. */
-	vma_assert_detached(vma);
-	vma_numab_state_free(vma);
-	free_anon_vma_name(vma);
-	kmem_cache_free(vm_area_cachep, vma);
-}
-
 static void account_kernel_stack(struct task_struct *tsk, int account)
 {
 	if (IS_ENABLED(CONFIG_VMAP_STACK)) {
@@ -3214,11 +3135,6 @@ void __init mm_cache_init(void)
 
 void __init proc_caches_init(void)
 {
-	struct kmem_cache_args args = {
-		.use_freeptr_offset = true,
-		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
-	};
-
 	sighand_cachep = kmem_cache_create("sighand_cache",
 			sizeof(struct sighand_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
@@ -3235,10 +3151,6 @@ void __init proc_caches_init(void)
 			sizeof(struct fs_struct), 0,
 			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_ACCOUNT,
 			NULL);
-	vm_area_cachep = kmem_cache_create("vm_area_struct",
-			sizeof(struct vm_area_struct), &args,
-			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
-			SLAB_ACCOUNT);
 	mmap_init();
 	nsproxy_cache_init();
 }
diff --git a/mm/mmap.c b/mm/mmap.c
index 1289c6381419..fbddcd082a93 100644
--- a/mm/mmap.c
+++ b/mm/mmap.c
@@ -77,6 +77,82 @@ int mmap_rnd_compat_bits __read_mostly = CONFIG_ARCH_MMAP_RND_COMPAT_BITS;
 static bool ignore_rlimit_data;
 core_param(ignore_rlimit_data, ignore_rlimit_data, bool, 0644);
 
+/* SLAB cache for vm_area_struct structures */
+static struct kmem_cache *vm_area_cachep;
+
+struct vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+
+	return vma;
+}
+
+static void vm_area_init_from(const struct vm_area_struct *src,
+			      struct vm_area_struct *dest)
+{
+	dest->vm_mm = src->vm_mm;
+	dest->vm_ops = src->vm_ops;
+	dest->vm_start = src->vm_start;
+	dest->vm_end = src->vm_end;
+	dest->anon_vma = src->anon_vma;
+	dest->vm_pgoff = src->vm_pgoff;
+	dest->vm_file = src->vm_file;
+	dest->vm_private_data = src->vm_private_data;
+	vm_flags_init(dest, src->vm_flags);
+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
+	       sizeof(dest->vm_page_prot));
+	/*
+	 * src->shared.rb may be modified concurrently when called from
+	 * dup_mmap(), but the clone will reinitialize it.
+	 */
+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
+	memcpy(&dest->vm_userfaultfd_ctx, &src->vm_userfaultfd_ctx,
+	       sizeof(dest->vm_userfaultfd_ctx));
+#ifdef CONFIG_ANON_VMA_NAME
+	dest->anon_name = src->anon_name;
+#endif
+#ifdef CONFIG_SWAP
+	memcpy(&dest->swap_readahead_info, &src->swap_readahead_info,
+	       sizeof(dest->swap_readahead_info));
+#endif
+#ifdef CONFIG_NUMA
+	dest->vm_policy = src->vm_policy;
+#endif
+}
+
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	vm_area_init_from(orig, new);
+	vma_lock_init(new, true);
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+	vma_numab_state_init(new);
+	dup_anon_vma_name(orig, new);
+
+	return new;
+}
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	/* The vma should be detached while being destroyed. */
+	vma_assert_detached(vma);
+	vma_numab_state_free(vma);
+	free_anon_vma_name(vma);
+	kmem_cache_free(vm_area_cachep, vma);
+}
+
 /* Update vma->vm_page_prot to reflect vma->vm_flags. */
 void vma_set_page_prot(struct vm_area_struct *vma)
 {
@@ -1601,9 +1677,17 @@ static const struct ctl_table mmap_table[] = {
 void __init mmap_init(void)
 {
 	int ret;
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
 
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT);
 #ifdef CONFIG_SYSCTL
 	register_sysctl_init("vm", mmap_table);
 #endif
diff --git a/mm/nommu.c b/mm/nommu.c
index 2b4d304c6445..2b3722266222 100644
--- a/mm/nommu.c
+++ b/mm/nommu.c
@@ -53,6 +53,65 @@ static struct kmem_cache *vm_region_jar;
 struct rb_root nommu_region_tree = RB_ROOT;
 DECLARE_RWSEM(nommu_region_sem);
 
+/* SLAB cache for vm_area_struct structures */
+static struct kmem_cache *vm_area_cachep;
+
+vm_area_struct *vm_area_alloc(struct mm_struct *mm)
+{
+	struct vm_area_struct *vma;
+
+	vma = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+	if (!vma)
+		return NULL;
+
+	vma_init(vma, mm);
+
+	return vma;
+}
+
+void vm_area_free(struct vm_area_struct *vma)
+{
+	kmem_cache_free(vm_area_cachep, vma);
+}
+
+static void vm_area_init_from(const struct vm_area_struct *src,
+			      struct vm_area_struct *dest)
+{
+	dest->vm_mm = src->vm_mm;
+	dest->vm_ops = src->vm_ops;
+	dest->vm_start = src->vm_start;
+	dest->vm_end = src->vm_end;
+	dest->anon_vma = src->anon_vma;
+	dest->vm_pgoff = src->vm_pgoff;
+	dest->vm_file = src->vm_file;
+	dest->vm_private_data = src->vm_private_data;
+	vm_flags_init(dest, src->vm_flags);
+	memcpy(&dest->vm_page_prot, &src->vm_page_prot,
+	       sizeof(dest->vm_page_prot));
+	/*
+	 * src->shared.rb may be modified concurrently when called from
+	 * dup_mmap(), but the clone will reinitialize it.
+	 */
+	data_race(memcpy(&dest->shared, &src->shared, sizeof(dest->shared)));
+
+	dest->vm_region = src->vm_region;
+}
+
+struct vm_area_struct *vm_area_dup(struct vm_area_struct *orig)
+{
+	struct vm_area_struct *new = kmem_cache_alloc(vm_area_cachep, GFP_KERNEL);
+
+	if (!new)
+		return NULL;
+
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_flags);
+	ASSERT_EXCLUSIVE_WRITER(orig->vm_file);
+	vm_area_init_from(orig, new);
+	INIT_LIST_HEAD(&new->anon_vma_chain);
+
+	return new;
+}
+
 const struct vm_operations_struct generic_file_vm_ops = {
 };
 
@@ -404,10 +463,18 @@ static const struct ctl_table nommu_table[] = {
 void __init mmap_init(void)
 {
 	int ret;
+	struct kmem_cache_args args = {
+		.use_freeptr_offset = true,
+		.freeptr_offset = offsetof(struct vm_area_struct, vm_freeptr),
+	};
 
 	ret = percpu_counter_init(&vm_committed_as, 0, GFP_KERNEL);
 	VM_BUG_ON(ret);
 	vm_region_jar = KMEM_CACHE(vm_region, SLAB_PANIC|SLAB_ACCOUNT);
+	vm_area_cachep = kmem_cache_create("vm_area_struct",
+			sizeof(struct vm_area_struct), &args,
+			SLAB_HWCACHE_ALIGN|SLAB_PANIC|SLAB_TYPESAFE_BY_RCU|
+			SLAB_ACCOUNT);
 	register_sysctl_init("vm", nommu_table);
 }
 
-- 
2.49.0


