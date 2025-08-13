Return-Path: <linux-fsdevel+bounces-57727-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FDE8B24C94
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 16:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 520DD3A7705
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Aug 2025 14:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 357522F0674;
	Wed, 13 Aug 2025 14:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="V2/tNTDp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xOTMEwZT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1F511D54D8;
	Wed, 13 Aug 2025 14:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755096944; cv=fail; b=u5VxSNFbd3Fxe9GkfjYog550qtHFooxSLJ+W4MODO4lYfsZ4pbSfft760SLFzIZzie7w58ev91QPiiBKqXDlg22rzahfFkcAvYMziVDV/o9PPGvJwHinAVk6eeC6EnBgDDvnK2ORfNWWKoO4vtwl+BmYUBCgPXdVVXuC5Wkym+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755096944; c=relaxed/simple;
	bh=wKQWo1q/CO4WcxpjgG+rcNyQD900rksog+QJWR7pH8s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=FnGc1ZD1534ctCDKg2tWSkn6d7yLnnCBF+NptSiPuoDbxx/+C77NzkWE15+NNj0cwaI4EdoV4qKJIsmzWhSBsg5jUP9go+ZJkQMcPO7qou7nfLoK64Ote7H/nbt2HHurwf52BZVsmYSYOyZk8ASrOPQGw3XDdIDsXld/xLSArcw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=V2/tNTDp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xOTMEwZT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57DDNFt3013930;
	Wed, 13 Aug 2025 14:54:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=vlee77bq4d091PF/v2
	bjdMjptsU79DwY+RVr/ZsszVw=; b=V2/tNTDp5BDjuQq2MHI6YQhsQxAyCSrhVY
	t1oqnnzgQ3H0JtptaMy5VLHSnsI71Az/QBWxRbmJktbVLCqVUIWNP0riCR1JLdr7
	nM1QNCZF5ME8xcTVkJ/SDgR4PPSXPorEaogfPJX4dEAFBeqy7vzIgOHWCeSGWwiR
	U9yLn7prD6KG8hcLR/NfAjg18QUkDQRxFFLwxbtzToizDQ9gzZStVAlpN3kEu2Z+
	j0AiRvpzryocVAZg7FyFfjBdcF67Cv6oIYK7zNhMnT+8mSSv/q0UHo9YqD/NM7s1
	xWNj1YDHk4hUwrv1ABqjcyZ+Dx051ZaQX/qacg+RgoakyYJEzpYQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvx4fsr6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:54:45 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57DEftmZ017597;
	Wed, 13 Aug 2025 14:54:44 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10on2070.outbound.protection.outlook.com [40.107.94.70])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsbgmhb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 Aug 2025 14:54:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hNU2VvQsD0Oc8fXuhigwOcKxiUH3VUI9Mj1FLuq9lon2Dr5ZEmh6rw/20ceMkmGGG0RHK2+QaaI5RmdYl7SzD6JDa9U8xBD5D1Ntlr339tYVZpCnAb5uYfzFIx9IfX4uoAGjQsVALMdfjlPWbhWUOib8BnGUXamFFfgCxLMVpv2um8W8LX0fqx9fhdk4xbVH1sgyIlG+ejEGIpiHig7f98phuZb/f0qN5Nj+8k6DUfxlINz0z+ShOHOfahF18DWRGLw9edr/I+NhuSmsN1VYR5dAbDRzpo+JMsvkJjoNJR/bk6TCDkh/JvBEGRMuifZy8iGYfg7Br25gqgu17ljhsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vlee77bq4d091PF/v2bjdMjptsU79DwY+RVr/ZsszVw=;
 b=L7LLj0v5BB3nkE3J8CKp6l97sYYi8QHBbwG13Z++t9ro3AyWlGoERH8XdsS1XFBOGtS/+3yCxX0KCslQZfofQiRb9XaY+d+E7Z2pSMv+VhnpInFzNl0hFlYlFb+qtQEJ9JVE1OlNUKMx/ptHMCM/xG8rBvFcu+JwSjNfZXrrH2QWnWamDPi/nyvDUa9oDgtGr0ebBOWNtQwygW7LZ7sIu76A+bWDzIcFMtHfunENGw2g3GYUEU3Az6EWr8vmrfgzYo6VG/SoXFO01TtiApJUhDmwbVFF8HIv8lmT3UU7XnkoXqtQzaTsAkN2P/whe1fnv4c079uedTLf4CQYSWweRg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vlee77bq4d091PF/v2bjdMjptsU79DwY+RVr/ZsszVw=;
 b=xOTMEwZTHSMjtPQxQ4NeFuniS1uJ8nrec/CO1j8DMFUIkw2r/Gx99qfm98Q8qtPKqlV5gYDWAAl4LrA/MrSs2Z7NFSVw4ziTWT95wbSDLWJW57PsTQL52MBzK1HshssjqCkJnBhHiEStzo0RhQHTBowT7S9LS1gKJe4qKUv2o2k=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH3PR10MB7833.namprd10.prod.outlook.com (2603:10b6:610:1ad::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 14:54:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 14:54:40 +0000
Date: Wed, 13 Aug 2025 15:54:38 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Usama Arif <usamaarif642@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, david@redhat.com,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org, corbet@lwn.net,
        rppt@kernel.org, surenb@google.com, mhocko@suse.com,
        hannes@cmpxchg.org, baohua@kernel.org, shakeel.butt@linux.dev,
        riel@surriel.com, ziy@nvidia.com, laoar.shao@gmail.com,
        dev.jain@arm.com, baolin.wang@linux.alibaba.com, npache@redhat.com,
        Liam.Howlett@oracle.com, ryan.roberts@arm.com, vbabka@suse.cz,
        jannh@google.com, Arnd Bergmann <arnd@arndb.de>, sj@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        kernel-team@meta.com
Subject: Re: [PATCH v4 6/7] selftests: prctl: introduce tests for disabling
 THPs completely
Message-ID: <4ec21eaf-b728-43c6-9f11-841a367b9794@lucifer.local>
References: <20250813135642.1986480-1-usamaarif642@gmail.com>
 <20250813135642.1986480-7-usamaarif642@gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250813135642.1986480-7-usamaarif642@gmail.com>
X-ClientProxiedBy: LO4P123CA0131.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::10) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH3PR10MB7833:EE_
X-MS-Office365-Filtering-Correlation-Id: 77a42c1e-5fa1-4030-8969-08ddda7954d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Nd54hA54Qeh81KjOJoVMtf2zYfS/SHcwYPPH463hke5mI4Rp/R1vkXQ8HUaT?=
 =?us-ascii?Q?D3yCxl5ik1F/ukXTNbeIta4FlhisWz/t+zgexVsIJh9qk/bJav/PiXs3e4wr?=
 =?us-ascii?Q?WZ/zdtA2C6E9qY82PxO6YKBFfOrBZeADmrBit+aoaD3P5fXLIuBGFSYhBkVc?=
 =?us-ascii?Q?U0zlAvYNkjyr2gffacGE5B3/LzbgCbK3KyM4tyJ3QouaIWF2Nv1Y5RlqyX/x?=
 =?us-ascii?Q?SFO5JSZdePr6vCec3UBKxf6TH7JOwNEVbZPPdSp+zzNehO4Wn/tmwDhvlKSw?=
 =?us-ascii?Q?wroggABtSkzLa+I+kOm1Xim67VnZso8PSGSvFnOrPic6ya+E1E0a97SAbaqF?=
 =?us-ascii?Q?InZP+23sOem2I7WI98WH3ZkeONJOSARO2TvOqa26SN3do5BiSmEsuXfeuzZd?=
 =?us-ascii?Q?kvB7Hmxp5QqokzGlGMCG684zopodQ4IfyXKZhUNwDba0S5piJ/ITHSyLl8ea?=
 =?us-ascii?Q?+fFVq8qt6Eg8MrXsPpf4OPqeJIBsedFAwcZRtC3rAJ2H7WG++N0pCZyx0vie?=
 =?us-ascii?Q?2C5TsM27xBR66E+HgyDulxcm/8KvYOruuMK84ZJ3qe7D9C/8r7FloabymQTa?=
 =?us-ascii?Q?TvAjPcNf0mOiy1YZJEzrOy//wZkjLD2zildyDU2Wu+CUfOMhn2duyIyoqS7g?=
 =?us-ascii?Q?b+cO5evp/DNe1cZcao5uw/i6KGkj9miqRs0Uey8HPm46204ATX2Y3Q7vwi+5?=
 =?us-ascii?Q?0Q1wpO6anJAvVSCjtO6F9GYXzLyYIyLnEQFu9qLDumQcFbnRcOCn4vmrYJDU?=
 =?us-ascii?Q?oOS4ed0Rmc2FvV6phUhhVS9rpCgxuY6x9btHpfSsu5hT99prPMTmecOsH8aB?=
 =?us-ascii?Q?2ZEH9bLuKN6mTQI381fj3RZ9mUqYFMf89ZaiNCJvTftBP79jmVajZdDqD+Z6?=
 =?us-ascii?Q?z4tGVqJTkLg37Cs5vx698IcUqB/0xhVt59fSdXOkJycc3Hoxh2m9yAz06R5h?=
 =?us-ascii?Q?vbXjVA7BngEkG5wXqfdsQ3UmKA3nT3RBZvnpEqkfJyUL/0z3+KrTmSxDp2vh?=
 =?us-ascii?Q?Pnq9IbO9aNZvwKSBAxeP/4C69wmrvd+daYIj0d/we6hmGcitSVsi+whQFx85?=
 =?us-ascii?Q?Po4s5Jr1f/p8eGGLn0gIlkHk4qZFk6uFNM+z34ALqYjBDeYiuuf2/7gF+s8b?=
 =?us-ascii?Q?uqkW7MEYcCiH/K2tQE9TA+3xzHu/JmWWFK4LgIXot988W7g3Re2J4niw8Qsh?=
 =?us-ascii?Q?BzbY8/yqjXeJqyfmrckKljs2Pa/nItETq6qtfTV9fFwtu6mJON9Kw5vDRsCF?=
 =?us-ascii?Q?w3BgYdGu4HOL38to+EIqYT1lhNz6J0Go+CEFQ5pnMZeTbBqHMJiAkrZUsp+q?=
 =?us-ascii?Q?HC8khcD6cwQREKjQgjpxHPtJteoy/UJP5Au/akiylEiq6tuK/tAtgFeIi5+X?=
 =?us-ascii?Q?CCbYGWP+U33A5nwwz1rQWD2VnaCksoOIrkn3fA0G0rx9Q8+r4ggjOkjnHvHo?=
 =?us-ascii?Q?sJuWbYdx7xU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?TQ5EOYTP6/dnz4RbaBet2DdoJfO+e5es8n8l/a7x95poQpVbWx4JJEN+Saoc?=
 =?us-ascii?Q?6dKUIVXCs9AgziU4Sl3BJ8boPvu//yj9ZhXhp5yVLLMSBmc7QO97QLR9MRec?=
 =?us-ascii?Q?eFeugePW3Evjmli758jGH2bCGmcDymgJYgXbjTx+Gm4DnAfX36BpS4+ERmWg?=
 =?us-ascii?Q?WMEbpfrJTgBFATXtUXOXF0LIlfOafTnx6oiOGWfVYxUzNiGLCevAINz4rpCl?=
 =?us-ascii?Q?PVkn35yeIz3rzIfW8xOYyq0lMgDl0dIwd+0LYldSEeFeysgdAPa7XoN+BZ6D?=
 =?us-ascii?Q?+b9Ikp2APYwWOe7Du9p3EUZTyKphQ9ZwzzZKl0duW/XUQQyfDq49Bo/ZJV7W?=
 =?us-ascii?Q?5VGGSgE1tAaSC+dUePBAuBeX3oQh/OYt7Eyv+JALu8jKU3oG5J12nZKks+RB?=
 =?us-ascii?Q?G5R0jxjbOrh5afazTWh15diSQgJBabdXVTIgr/bkInifqvjYnvPvHIkCRVgm?=
 =?us-ascii?Q?3byuO/m4809MuWuv5Xt9a1tai0rjpJqn7L8GEWibMMxvtOgcI7YWxh4YTn5O?=
 =?us-ascii?Q?V3WDLWOdkbNqE3zFk/hvfYWCeRjP9DwySRrceF86gWk/h4y9srVOCQPMyS0t?=
 =?us-ascii?Q?+oTvLEGy1LX1D1aSo+meT5p22ClwWEEYhogk7s6uRAHpXvHezvGAV+USdtZ1?=
 =?us-ascii?Q?eTFfZXwjuQ6MoGdD28SE/XfHGKmU/eU+WSWIWsWL5rB1QcA3yssSS0ttUTjN?=
 =?us-ascii?Q?hQrK11Dz05EecATVA7m1DgPVYs9xdMHkp1cB4XhMTjyrC8oL1JZ39pnjD61I?=
 =?us-ascii?Q?n0LP13Do2fqb/OCHjIVKXkVGbtUU26ImNFpCFUqGeQUUxMJ0mYM64KoQoy6r?=
 =?us-ascii?Q?Mp7/ZFBk+SgG+QCU6m7qXWnfX8p7l+Vnm6tCgkh8LuQVmD19G5799l7FhyBa?=
 =?us-ascii?Q?4fgxD+8vU7JjpXX1rFiPbUWjD0leA7iTgiWZPOU1FrRkcDBmExDWXc7fRPh2?=
 =?us-ascii?Q?M234NgLcwzKI+LMMwh1gXCpjq2QdxjgSqnMigs4XvGQwj8a1JoX7jCmOjr60?=
 =?us-ascii?Q?aVqOhquJ3oW8KGsHrPJNSBSDF+r0tkQQ5UF5uQm+RvwwvJJHJ5DWWjrOAdmu?=
 =?us-ascii?Q?SoE4uJjBJQ/i27eiADo2kH5ifBwmmTJ/e1E2vOehstqLqrhB2jOUrKPEuSCk?=
 =?us-ascii?Q?iQuCVdMCBavOrgNx87WXJ6DDpSIgOtP6rnuVSx6l9/2EZ+V/UzTC57I7iI5E?=
 =?us-ascii?Q?cSy+eFL5cMqm1JsaYKRYO30LS2DBVHBwKva8OH1Dg5Lcw7mOkQNuGoKwIANF?=
 =?us-ascii?Q?EQuC32ooitsUTNn8xKS5VksoCIsFSyH3EnUBPEfmX2ltsQ7ueNIMt91U9q45?=
 =?us-ascii?Q?FcPIval+UhrI7MvX/hdLn8MQFWv3UNucB0E8eWYRGmBxdKKKM7+dBjRQW9T5?=
 =?us-ascii?Q?6dR1/c7rmGq2HfOKukUQBjVcnPJLxfN1zMPWvwyGPliXMNvZ+GTlgBR5BxDf?=
 =?us-ascii?Q?wV8BlFg8X7NFXDwPZ+suoPZwYDpiDU+fbtJKL+y05a6IgiR+Dp76UdWpjU21?=
 =?us-ascii?Q?sUCaACL8VprmdLZqe7ujUNXa15fBXhhZzdLS0dtcy+o/HFNRcMAOzfs/AA0h?=
 =?us-ascii?Q?dFh9kZeTpsTlX0v7pU3t+RVB63lTqWDAUbkz/hM8zKAuPy+EasOYvAQI+sia?=
 =?us-ascii?Q?Pg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zv+7mdY8oOUWmS6LosrxKmTdp/VUflLtcekk+NDoqZm7VdysQtVswXhY7aCCZ6mLGGtUjCUBmpBKaJ1XNdoYeJ7ht98DG2BnMzx4i3BXgILYikvy5UjaJdOPTpdMLEht/2fuqueku5R0d/bu3COebz7Uq+FT0RO1I133AgNUrYE06BNJakrXR6QlSnOAnVBHrZo24xfUByw5Etp7jKYx89Wc5dX/oMy3OTn3UJyCXHS/xQggGGUetsIpzFDuebBqNZj1UAD65ZcY2ITQ1kF/sqbMxQ6AYgYJRCe78N5wnvQ2VDaetS9SbY6xrrhmniX+nSHB8z3x0Y3znMQ6AY5M9n/Mt5JBsCWkHDzV9teV0PinpK7nL13YxLaiiRzsS6OWOANiLaMxe71qx/oAuy7kblteYFeQFq18I/OFKR4ya76w6CjCnif/ZjPj90WBNFK0QErL2ksMBV9u0fUGZ9Rnp41FGgWh2YFAfLtUYcBRl5HVaRSik7OhRZPDKQtm27AfIn/efEAeldECZOCgvrJaha5RfwCz/anrBZZGkdkgYQ8ToVouwgnGF/jWcYhqmrRknP2sXtSGKsEb7p1XBmYy0rwuGjWhrhoqT2fwFl2REas=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77a42c1e-5fa1-4030-8969-08ddda7954d4
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 14:54:40.6546
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j869piVd19IEpmHcY4iC+wQyhpEaD/So94hpVKT/2d5YnomHCdbNNCC+i2IxlLKJHQRk1R0jTHx5CkJnRkrdqD8fv+XEIq0eRRKR0uxQCU0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7833
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-13_01,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508130140
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEzMDE0MCBTYWx0ZWRfX9HLzQ6H/wh9O
 VQ9jDnerF5PcMeyUvoxaP24UQ8ASMdAbuG+N2pgk9RN8iEzaApmH+PAXezjtCB3XvW9VrUKwz55
 lo4pkPtZ6Oji4yAXRxJIZ1MtfGIB3e7lXqbbL3l+x3y7f4J0icaJVW1Xpr+LIdoqL62shHW9RuC
 4wKX8hti1KCgWF62dmKKjXI3CA2nzjy3FPLlhptOnPWP/ZyDJogn/LPPgsAjCDGwUeWUfEoSSVt
 Ztzxm+4cKZLOsNpgsP7R7q9L3FEJCiHtkfwlIk9bzsbPIipBsWgvTXsTca0VkQ1ix3tVBWbW6ue
 eGabv3uRDvKAr641C72JNki1M3Bq6UivK/1p2tKt6dqGb/DzfVSGDUJoKRALLBXYJhmjAnFwkHY
 EHeQU4hZKlHLSyxuATibvSxJ13Q1MFkJGl6JL/3XRTU9WsVulFUbdw4UURS3yhf/leGriW6l
X-Authority-Analysis: v=2.4 cv=eIsTjGp1 c=1 sm=1 tr=0 ts=689ca735 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=UVCitKIF3lZ3565sXv8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: tMiErU8qT5Z1JkugdnKEJWUWYNW9-c7q
X-Proofpoint-ORIG-GUID: tMiErU8qT5Z1JkugdnKEJWUWYNW9-c7q

On Wed, Aug 13, 2025 at 02:55:41PM +0100, Usama Arif wrote:
> The test will set the global system THP setting to never, madvise
> or always depending on the fixture variant and the 2M setting to
> inherit before it starts (and reset to original at teardown).
> The fixture setup will also test if PR_SET_THP_DISABLE prctl call can
> be made to disable all THPs and skip if it fails.
>
> This tests if the process can:
> - successfully get the policy to disable THPs completely.
> - never get a hugepage when the THPs are completely disabled
>   with the prctl, including with MADV_HUGE and MADV_COLLAPSE.
> - successfully reset the policy of the process.
> - after reset, only get hugepages with:
>   - MADV_COLLAPSE when policy is set to never.
>   - MADV_HUGE and MADV_COLLAPSE when policy is set to madvise.
>   - always when policy is set to "always".
> - repeat the above tests in a forked process to make sure
>   the policy is carried across forks.
>
> Signed-off-by: Usama Arif <usamaarif642@gmail.com>
> Acked-by: David Hildenbrand <david@redhat.com>

Some nits below but this looks sensible, so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

> ---
>  tools/testing/selftests/mm/.gitignore         |   1 +
>  tools/testing/selftests/mm/Makefile           |   1 +
>  .../testing/selftests/mm/prctl_thp_disable.c  | 168 ++++++++++++++++++
>  tools/testing/selftests/mm/thp_settings.c     |   9 +-
>  tools/testing/selftests/mm/thp_settings.h     |   1 +
>  5 files changed, 179 insertions(+), 1 deletion(-)
>  create mode 100644 tools/testing/selftests/mm/prctl_thp_disable.c
>
> diff --git a/tools/testing/selftests/mm/.gitignore b/tools/testing/selftests/mm/.gitignore
> index e7b23a8a05fe2..eb023ea857b31 100644
> --- a/tools/testing/selftests/mm/.gitignore
> +++ b/tools/testing/selftests/mm/.gitignore
> @@ -58,3 +58,4 @@ pkey_sighandler_tests_32
>  pkey_sighandler_tests_64
>  guard-regions
>  merge
> +prctl_thp_disable
> diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
> index d75f1effcb791..bd5d17beafa64 100644
> --- a/tools/testing/selftests/mm/Makefile
> +++ b/tools/testing/selftests/mm/Makefile
> @@ -87,6 +87,7 @@ TEST_GEN_FILES += on-fault-limit
>  TEST_GEN_FILES += pagemap_ioctl
>  TEST_GEN_FILES += pfnmap
>  TEST_GEN_FILES += process_madv
> +TEST_GEN_FILES += prctl_thp_disable
>  TEST_GEN_FILES += thuge-gen
>  TEST_GEN_FILES += transhuge-stress
>  TEST_GEN_FILES += uffd-stress
> diff --git a/tools/testing/selftests/mm/prctl_thp_disable.c b/tools/testing/selftests/mm/prctl_thp_disable.c
> new file mode 100644
> index 0000000000000..8845e9f414560
> --- /dev/null
> +++ b/tools/testing/selftests/mm/prctl_thp_disable.c
> @@ -0,0 +1,168 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Basic tests for PR_GET/SET_THP_DISABLE prctl calls
> + *
> + * Author(s): Usama Arif <usamaarif642@gmail.com>
> + */
> +#include <stdio.h>
> +#include <stdlib.h>
> +#include <string.h>
> +#include <unistd.h>
> +#include <sys/mman.h>
> +#include <sys/prctl.h>
> +#include <sys/wait.h>
> +
> +#include "../kselftest_harness.h"
> +#include "thp_settings.h"
> +#include "vm_util.h"
> +
> +enum thp_collapse_type {
> +	THP_COLLAPSE_NONE,
> +	THP_COLLAPSE_MADV_HUGEPAGE,	/* MADV_HUGEPAGE before access */
> +	THP_COLLAPSE_MADV_COLLAPSE,	/* MADV_COLLAPSE after access */
> +};
> +
> +/*
> + * Function to mmap a buffer, fault it in, madvise it appropriately (before
> + * page fault for MADV_HUGE, and after for MADV_COLLAPSE), and check if the
> + * mmap region is huge.
> + * Returns:
> + * 0 if test doesn't give hugepage
> + * 1 if test gives a hugepage
> + * -errno if mmap fails
> + */
> +static int test_mmap_thp(enum thp_collapse_type madvise_buf, size_t pmdsize)
> +{
> +	char *mem, *mmap_mem;
> +	size_t mmap_size;
> +	int ret;
> +
> +	/* For alignment purposes, we need twice the THP size. */
> +	mmap_size = 2 * pmdsize;
> +	mmap_mem = (char *)mmap(NULL, mmap_size, PROT_READ | PROT_WRITE,
> +				    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
> +	if (mmap_mem == MAP_FAILED)
> +		return -errno;
> +
> +	/* We need a THP-aligned memory area. */
> +	mem = (char *)(((uintptr_t)mmap_mem + pmdsize) & ~(pmdsize - 1));
> +
> +	if (madvise_buf == THP_COLLAPSE_MADV_HUGEPAGE)
> +		madvise(mem, pmdsize, MADV_HUGEPAGE);
> +
> +	/* Ensure memory is allocated */
> +	memset(mem, 1, pmdsize);
> +
> +	if (madvise_buf == THP_COLLAPSE_MADV_COLLAPSE)
> +		madvise(mem, pmdsize, MADV_COLLAPSE);
> +
> +	/* HACK: make sure we have a separate VMA that we can check reliably. */
> +	mprotect(mem, pmdsize, PROT_READ);

I mean you won't be _absolutely_ sure of this, as you might merge with an
adjacent read-only VMA.

The best way is always to map a PROT_NONE mapping first, then perform a
MAP_FIXED mapping into it.

Given 2 * PMD should guarantee at least 1 alligned PMD you can use, you could
do:

	char *reserve, *mem, *mmap_mem;

	...

	(set mmap_size)

	/* Reserve space so we don't get any unexpected merges around us. */

	reserve = mmap(NULL, 2 * pagesize + mmap_size, PROT_NONE, MAP_PRIVATE | MAP_ANON, -1, 0);
	if (reserve == MAP_FAILED)
		return -errno;

	mmap_mem = mmap(&reserved[pagesize], mmap_size, PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANON | MAP_FIXED, -1, 0);
	...

You could then do your 'hack' (which is not really a hack, just fine I think).

> +
> +	ret = check_huge_anon(mem, 1, pmdsize);
> +	munmap(mmap_mem, mmap_size);
> +	return ret;
> +}
> +
> +static void prctl_thp_disable_completely_test(struct __test_metadata *const _metadata,
> +					      size_t pmdsize,
> +					      enum thp_enabled thp_policy)
> +{
> +	ASSERT_EQ(prctl(PR_GET_THP_DISABLE, NULL, NULL, NULL, NULL), 1);
> +
> +	/* tests after prctl overrides global policy */
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize), 0);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize), 0);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 0);
> +
> +	/* Reset to global policy */
> +	ASSERT_EQ(prctl(PR_SET_THP_DISABLE, 0, NULL, NULL, NULL), 0);
> +
> +	/* tests after prctl is cleared, and only global policy is effective */
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_NONE, pmdsize),
> +		  thp_policy == THP_ALWAYS ? 1 : 0);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_HUGEPAGE, pmdsize),
> +		  thp_policy == THP_NEVER ? 0 : 1);
> +
> +	ASSERT_EQ(test_mmap_thp(THP_COLLAPSE_MADV_COLLAPSE, pmdsize), 1);
> +}
> +
> +FIXTURE(prctl_thp_disable_completely)
> +{
> +	struct thp_settings settings;
> +	size_t pmdsize;
> +};
> +
> +FIXTURE_VARIANT(prctl_thp_disable_completely)
> +{
> +	enum thp_enabled thp_policy;
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, never)
> +{
> +	.thp_policy = THP_NEVER,
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, madvise)
> +{
> +	.thp_policy = THP_MADVISE,
> +};
> +
> +FIXTURE_VARIANT_ADD(prctl_thp_disable_completely, always)
> +{
> +	.thp_policy = THP_ALWAYS,
> +};
> +

Nice!

> +FIXTURE_SETUP(prctl_thp_disable_completely)
> +{
> +	if (!thp_available())
> +		SKIP(return, "Transparent Hugepages not available\n");
> +
> +	self->pmdsize = read_pmd_pagesize();
> +	if (!self->pmdsize)
> +		SKIP(return, "Unable to read PMD size\n");
> +
> +	if (prctl(PR_SET_THP_DISABLE, 1, NULL, NULL, NULL))
> +		SKIP(return, "Unable to disable THPs completely for the process\n");

Hm, shouldn't this be a test failure?

> +
> +	thp_save_settings();
> +	thp_read_settings(&self->settings);
> +	self->settings.thp_enabled = variant->thp_policy;

Ugh this variable name is horrid, not your fault. I see you've renamed it at
least in the variant field.

That's not one for this series though, one for a follow up.


> +	self->settings.hugepages[sz2ord(self->pmdsize, getpagesize())].enabled = THP_INHERIT;
> +	thp_write_settings(&self->settings);
> +}
> +
> +FIXTURE_TEARDOWN(prctl_thp_disable_completely)
> +{
> +	thp_restore_settings();
> +}
> +
> +TEST_F(prctl_thp_disable_completely, nofork)
> +{
> +	prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
> +}
> +
> +TEST_F(prctl_thp_disable_completely, fork)
> +{
> +	int ret = 0;
> +	pid_t pid;
> +
> +	/* Make sure prctl changes are carried across fork */
> +	pid = fork();
> +	ASSERT_GE(pid, 0);
> +
> +	if (!pid)
> +		prctl_thp_disable_completely_test(_metadata, self->pmdsize, variant->thp_policy);
> +
> +	wait(&ret);
> +	if (WIFEXITED(ret))
> +		ret = WEXITSTATUS(ret);
> +	else
> +		ret = -EINVAL;
> +	ASSERT_EQ(ret, 0);
> +}
> +
> +TEST_HARNESS_MAIN
> diff --git a/tools/testing/selftests/mm/thp_settings.c b/tools/testing/selftests/mm/thp_settings.c
> index bad60ac52874a..574bd0f8ae480 100644
> --- a/tools/testing/selftests/mm/thp_settings.c
> +++ b/tools/testing/selftests/mm/thp_settings.c
> @@ -382,10 +382,17 @@ unsigned long thp_shmem_supported_orders(void)
>  	return __thp_supported_orders(true);
>  }
>
> -bool thp_is_enabled(void)
> +bool thp_available(void)
>  {
>  	if (access(THP_SYSFS, F_OK) != 0)
>  		return false;
> +	return true;
> +}
> +
> +bool thp_is_enabled(void)
> +{
> +	if (!thp_available())
> +		return false;
>
>  	int mode = thp_read_string("enabled", thp_enabled_strings);
>
> diff --git a/tools/testing/selftests/mm/thp_settings.h b/tools/testing/selftests/mm/thp_settings.h
> index 6c07f70beee97..76eeb712e5f10 100644
> --- a/tools/testing/selftests/mm/thp_settings.h
> +++ b/tools/testing/selftests/mm/thp_settings.h
> @@ -84,6 +84,7 @@ void thp_set_read_ahead_path(char *path);
>  unsigned long thp_supported_orders(void);
>  unsigned long thp_shmem_supported_orders(void);
>
> +bool thp_available(void);
>  bool thp_is_enabled(void);
>
>  #endif /* __THP_SETTINGS_H__ */
> --
> 2.47.3
>

