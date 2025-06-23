Return-Path: <linux-fsdevel+bounces-52507-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 30C99AE39B6
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 11:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BE6841896AD0
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 09:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B9A223301;
	Mon, 23 Jun 2025 09:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Qn6HMuuu";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t4TVi/RO"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21CAF2376F7;
	Mon, 23 Jun 2025 09:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750670223; cv=fail; b=rvqH5HHT/5fw9v5fDLz5M9WgIBVFAitUjJZPgufNlHMRd7CBMQmhP8tY4wqi/whlMi/yAX3glRv20XSl0tjr8huvyU365CUC4yPtllhFI8cIKIqJwV5+aUTXoSsrxj4G9y3XRZECxp5h0DV1wasPDhrXgRfUoN/3n2YSH9BRkHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750670223; c=relaxed/simple;
	bh=GikpSRWmV7iQvvYtRih5edQKRUNCJZXnyt42su5yyKk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sccoy1xn4uIgWWUdff0bsbyvjK33ka5EtO+TfDp6q/D5lP2QnH+mUzp4JzNes1RtUb9UOfsz59EVOV5KYv9bn/QLn/HnBpULQLo+h4OzOBB5O3rmAtDEmj6wpyiUJ0yZ04vTPIeNX16hXEoQnqftZ4ApNDwGS3f9aJLi52iWpro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Qn6HMuuu; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t4TVi/RO; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N8pZLA014720;
	Mon, 23 Jun 2025 09:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=rs1wmqG9HtmCO64eOc
	4LjhE7ruD3WRaLnJFp6ztibUc=; b=Qn6HMuuuk45hk5w1xt6cvaI4tVtMxrUbKP
	nkjZceuXdFA1vobfP+DW+wuF2Za+mUNKSnVIuPDDZVf1P8h6ibLXvlGC0vhzQV8J
	2ph0bUON5fV47HZx4Ru/0Zdx/fA4PYKQto3LdhrT7Zb7zrKmckLz3o81wYAW+7fV
	OIp0RchLRfsk8r5W+5EwxcEBJG/8wG79YvQoxoMCVQSP+TMfLKPMejyNereB2DsP
	WrJsI4Wpqg/CbRiFfRf3D6v5TSKblmThO8PreqaYTI65fSJJlZuaNchGrbTVW46H
	L9xtGs8xsTnnNT15c14T8kJtL9yAI6xOTCoLOc9qeyYnGMDeeydA==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds7uta5y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:16:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N7518x031321;
	Mon, 23 Jun 2025 09:16:40 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 47ehpnkrys-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 09:16:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=plPkSqqKNVFvVXC0dywP32e99x2FYdxdLYny7EfWv5L/cqZ737bfrGbqr8h2U0Vx2huduhoYk7fxpujtOv/QZDbZx4feugfz+QQMQoUZrYRI3aeghPSqqlWTybERvKeS42Km9iPK4Wb26UCky0ZEE676S7mxculc8UpX79ZB7msa19XN+bMM+KDYyGgWSmexE/HkDYf9409j1C8d8QOx5vuZ61YTEg5It18bwSKMqMUm6Q6rYawj+riEvorlzhC9Dosc92L2HOeP4mYnZdtpHTyF0hqptKP/jvjIk2zCtJD11pI0o3svpVQ99dL1CTSXks1IoRkKjQkMhV2H/EX/Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rs1wmqG9HtmCO64eOc4LjhE7ruD3WRaLnJFp6ztibUc=;
 b=rcSus5Mn4Cz0oJih+JHYSrvfdiTzZxGI9HlyVB7MsvxjSG+xFmZJ0E0Fc0ijivqGMy3FhYL3Adu1gvU+/i5XSRuHFMJ+abxvUtNaCB+KH3VK+41ev9W0Hm7HOrGlkiFf1wB+Kl33DDDHQ2zye9EgkvyhBnCQfFUJ9CTFtfhstMja0D2ugzLH2BP8ehIX46nMDL5sp53n4lj6iFHu4BbEgtlTieKX7q0dlyl1ZR7GMqk/YNyj20RH85kWgwu80KTUtwmYMFuV+aEAPgfxL5eyHfgVvRi5lz4kwy+QGtf6cA30eTUhFcOrycQNgd8bNtqczqlAkST48aEC1o/T9nOz6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rs1wmqG9HtmCO64eOc4LjhE7ruD3WRaLnJFp6ztibUc=;
 b=t4TVi/ROv6emCUm4mjil4YwaO76EslVFaRYzKDEmIVtQsbTUCaJ4mnhskrliQllPTkcgApNr+n9Bd+J7zf4uwZTO1e0d4p1Q4PpZdSacV5dRA+Vx2XpUcY8GeoicoWWCk4CziKKGsiRABGI72m2KbTIlXJkF3cQLK3LnZB3aqIo=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA1PR10MB6147.namprd10.prod.outlook.com (2603:10b6:208:3a9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 09:16:37 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 09:16:37 +0000
Date: Mon, 23 Jun 2025 10:16:35 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, David Hildenbrand <david@redhat.com>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Stefan Roesch <shr@devkernel.io>
Subject: Re: [PATCH v3 3/4] mm: prevent KSM from breaking VMA merging for new
 VMAs
Message-ID: <b202f5cc-9ab8-44c7-9214-a87eb7dfb2d5@lucifer.local>
References: <cover.1748537921.git.lorenzo.stoakes@oracle.com>
 <3ba660af716d87a18ca5b4e635f2101edeb56340.1748537921.git.lorenzo.stoakes@oracle.com>
 <5861f8f6-cf5a-4d82-a062-139fb3f9cddb@lucifer.local>
 <20250622123931.30b1739642be8ec1e9ca04e2@linux-foundation.org>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250622123931.30b1739642be8ec1e9ca04e2@linux-foundation.org>
X-ClientProxiedBy: LO6P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:310::18) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA1PR10MB6147:EE_
X-MS-Office365-Filtering-Correlation-Id: e04c8591-db91-4705-ff50-08ddb236a7eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?As+YxJZwdYQJOKX1Ho4a1dR9Y1o7OSiK5w4j9sbFXBFosMxzEIludDIHqV2U?=
 =?us-ascii?Q?5qO5l/rVa1mCqy5T8ooC0uLRj+GTPFZrew7PAFym3fgLHThS+TIcFKFuK4yg?=
 =?us-ascii?Q?ajujAvEUxyUEepqF9vmctnNSJFTSO7WUPu8FylyGbyUli73CD65xJtXfU1VE?=
 =?us-ascii?Q?U9amvlDoBpSm7A2/+X5FGJD12dQ3wQ09wUddil7xUg2QhHB/MHSoDb9n4tTF?=
 =?us-ascii?Q?L6cinNrGigG3Ny2Oc/npQp5tsAoTIipWZQAJHyg/aW7yTKGHOwRk6euGjhJl?=
 =?us-ascii?Q?ry/Zf5SOTKd5dmFBzAWzRTwXsT/GhGegUw8bdsXOMduYd9VbES+NQfcbonEJ?=
 =?us-ascii?Q?EVwGy0HLyCx5ZcGc1wXDFryWrlB+PK4gy5QA4kMlwxdNffk/bprSh8mdVsDo?=
 =?us-ascii?Q?e7ETC2FzDHQhnihUeKiWWDWkD1g6dUdT6rsP7IQc928BwCagcOBsZLHauVta?=
 =?us-ascii?Q?p/TlKMWGZZA3jielKR7fAztQpuW7c7aHnmmIM4zUfvOl0w9OzEcq/0YgcYvH?=
 =?us-ascii?Q?7jmfO5skBfV8S75Jf34iC9fiWzCUF8f+p76QfRf2Gptv/V7ewrvZPEXwcjzI?=
 =?us-ascii?Q?Rsa3f1YMJs57FC0WUAX+g3iLqUrXwrUol+grAk345O2bkXccFZccOb1wW8se?=
 =?us-ascii?Q?gBBlYQlignTi+Vh475gE/coH3a5t13devl/6T8oiD82RBOByfOZK7NULTx6J?=
 =?us-ascii?Q?V4hXq60Tl9DrBGSN3v4Fxasz3+YEtLrpMmyOrshr0NbZospB5sBoUfcV72PF?=
 =?us-ascii?Q?CvahuRX609VsyPM7JKhJgl+zDCMfTyvbz1qeCvKkcESkituo2ItdI9ndSKgU?=
 =?us-ascii?Q?4dddYBavrHiaueBDJsvvg5b35TgCgB4q1XtskYplVQhupb8LcQqzc/izqthY?=
 =?us-ascii?Q?PyLh2nVBYvSQbx9+YiGn4q5GssiAmEwpYpqH31kby/s7yselu7pbd7GmQKg5?=
 =?us-ascii?Q?ydZPJEaOepsTVo5PgPIaQWIZ5SMNFfRY6ZiQXJX8ZjoJ0knLKbwiRXUj+kUw?=
 =?us-ascii?Q?HEA1+gX4iFIX+XMpA41vI0Eetc+inFbdgOPGc6E+aYUlMrTzcsa6nGJ+Eb0j?=
 =?us-ascii?Q?H4RWbiVR81xttsTQiNiaDzneJlFet4dLgqB7tUxHeYCBuzS0ESnpNcJGxGoU?=
 =?us-ascii?Q?pypfCWYxNYQOTkoy7k+ku+P8VGI3UVxUdsoK+a1nTWyL3MnpR2BjkV+ACmiG?=
 =?us-ascii?Q?SjiU6LjyJlBgHU+/o4J69ISJ5mTYFQN3Lw/MqNtJw7OsyBXU/Z4zMnLAjXOp?=
 =?us-ascii?Q?etLbzxFzq+V/UPiLBOFb8zo64WLnlm0KGmfC6GWiLUVMz20f5Z/2beo0qqM8?=
 =?us-ascii?Q?kwRZSXGu8eC3R3nTdQu/fT66jSt7hyLrQgy044UWNdzNCAf81q3Nbyh5O0Df?=
 =?us-ascii?Q?Y1jurGL+0j+wO9BWkbqhGs7W3jOBUtxPqlsH+J4kEPmqZLDARtyKfxBRslyI?=
 =?us-ascii?Q?vnVC8RyeD8c=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sNBClppDaTCOtEOlIgLNOde4vZJJ6rpolblPbUc5X+VSpk2WsaO6JbqEIyuy?=
 =?us-ascii?Q?9nQCE2prMWeoX9XS9D09y9yfDaoDwvvz6Hwniii4+M8G1CDunEf6VyDtUzf6?=
 =?us-ascii?Q?6ZOpPoik0CCtmSWVwmsWWztD9E+jeoIs2v7A+LOnH7EeZWM2e3kgv7Up7hBJ?=
 =?us-ascii?Q?lSqaeCRikNLUHGx5wHYp39gucH4Hz3leTgjny8CX9/E2Hk8ioOhfON5kJ10T?=
 =?us-ascii?Q?dEvHv/rG/jgf1Cja69lD6GjjBv5zf5TTdE6TtHZjD3ZRBgOch2qj2PNhKGUH?=
 =?us-ascii?Q?v7zxiARrxZ4/nL8C+vzj95815z5iQeKzHUtukJvvxW9Xhnx4WRZGX8c7VEX0?=
 =?us-ascii?Q?v9edOSQWHNJ0KG/ABZ8/WXN9zRY3xEPsIepExIe9SYdwb2kqpLjqNPJDv2Os?=
 =?us-ascii?Q?AZOH0U3wXJTDhfByZJOmOVWGJ2eG4p1ZAc/LFtb188j0xBZl/kQI1Z6UjH2j?=
 =?us-ascii?Q?Rjyum4e1FCCrSi1CIqhI+5550TcwwYFlWVP77GBAZDHBLXA2KmFXjgHge73F?=
 =?us-ascii?Q?4B8aiF+L4b3Ga/wGL00zFLMF3lKLYIqkMZl/ugnAri1kGGRPWZBd0I95dEK+?=
 =?us-ascii?Q?rNvCeN9XKvxPHM13qA0e2MV3AzYJc/7/luwvQ0yQK9m7OA+5/z+vByp87Zbf?=
 =?us-ascii?Q?CCXD1nFuMGbWArBn8KO/FtZH6IivT2dum8W6jiOxPms6jhJh13kPdTVo3lPD?=
 =?us-ascii?Q?pnnmJBtMU3rpHm/HzTy2VcE73ylyKNWfw5H5g/YUhP88iLhRhcYyRslQxHn7?=
 =?us-ascii?Q?YiXIEnv68kwrq5n5EDmRzD/u0t9/OC7X0ZGp3/hshtiXGTKlujS1uAFRc/fF?=
 =?us-ascii?Q?1H+87QBPQ7HJrO5AqSL9EFYpUS90eLymqNUTYWHyH6SWPQ/j/urFlttv3XN7?=
 =?us-ascii?Q?ALctl2KzHd2IYP4eea5h8+GrmjOr4aCUwv621mxAdYTGA0UQCzhOcelkGD0z?=
 =?us-ascii?Q?/BL6vjN2XTFRKQ/FgMQBgDK7WFLFt2tqinWnvX9JSOqd0aXHrfLjGlsFXdFP?=
 =?us-ascii?Q?9IV1vZrSPDdZb2Ro4cqrIgv1WB6uPP7ANiv2YepokiqIVaSkYaR6F9az82fS?=
 =?us-ascii?Q?iM8Qypb+KL1hx2iyLr2bBBByzws/+uj97ZpR3O+wpkr/cnUBqkSHbVeNpyui?=
 =?us-ascii?Q?EzX2ikUKBe0qcsMidF9tk48xi01puVzX9+ppUDD/8cUnxA8bt5AhLrPqp0io?=
 =?us-ascii?Q?pn28AVRYqTSdM/s6XyIMayo7iRGRtN8GTEnVw2XPPtpWw+p/JXKSlf60xD5f?=
 =?us-ascii?Q?+WOAp/jTZkYrjGi6sWsWIsC33U3Ulucds2GA/tWPDAHy0c6tU9diI7gkW9qH?=
 =?us-ascii?Q?RAY3AKKudvmDVm3VinFc+wKCdHd7TXEKTiHAhH7UlqIyR8bqlO+KhpiqNQ+u?=
 =?us-ascii?Q?n7rukGsXeb+uvxTpHAGglW2NykYrNssMP7LsNpaiMkBBVpLE5N0cyUF+0T2/?=
 =?us-ascii?Q?rEacmrO6/snrsDW5+7GKxjbhpLQVBuSDN2QImOo2KUhiZcQBqk6DC5LQfS3W?=
 =?us-ascii?Q?K3oCFm1XBgab+SW+kJ1RO6Ns76/U55F3POWjB1PbXLMa5kiKSuM3yS7n4YCL?=
 =?us-ascii?Q?pC5FtrDgMPegJEFJI02bxGgGdDimqRJj/6oWilEqmZLPWQnlDmCuzkXGAUWD?=
 =?us-ascii?Q?qg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mT7UUoVosd6/MYKgQ7vdFEaoAEVD6n1dF4RqC2fC76T5F/Tm7D2Qj2oFsj8p0wkwHxC48gj6iWlytGEoZFXnNHJRf92/WvUUmvKXNQ2foPOey/Pa/4MGzplYYlzHM8eq7/vxoM1dli/OZqVwcN2y2KGz35ZtL2tzsfzE/FvMCrfp0viVdkx+MsHQWshmVQjtLxQ1wvV0QcHK82E25enoWOmZazuCeQrYL0Kb6WfFuo6zqGtze5vlg+7/9iwFpRMGr0SFlBrHpIbnb5h0DnByeMnLDtn9DLWBg8tew65BaTC3dqZ6DJyDjMaGr88TYL0Q5wKR25tlCvK0eUFYTl1KluWG7jN0/1x6x/cWLEfqdXh9jdeza0BhDCf5EXSMpoS9C/Cvvc/zrzAUMca8JKYrY6lJQ5t8gqVu5BpUduIUy+pgq/MEvIlWS4Bejf5BQYppk8mCzy74YckiHF+bfdHTcO1uzBmeQRpTuMDRt2CqptXW0VtywCr09kCKaC3EB1mzFjjfbIJEVPPUL8IPFuShdVkp76B5NydV50ocjrGZUXXgGfmCj4ubtcnMu37evDrM4Ip207fICirXHk0f0VBjyoTgyEDf8mKN47B4Ghp0GSA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e04c8591-db91-4705-ff50-08ddb236a7eb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 09:16:37.3233
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U8ilMObMnWiJ+t6GCJqecaNYy24vExNsqr9KDsPJNcGL5GevoyzjbZydMNgt1TkFM4T+ASJ8AFAMxfdLKDUMUz2JSVAazgz0PHQ0B4hct2E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB6147
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-23_03,2025-06-23_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 bulkscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230054
X-Proofpoint-GUID: -MIeYwtpWfsBfAcDc8daMa6HUklt1hmG
X-Authority-Analysis: v=2.4 cv=CeII5Krl c=1 sm=1 tr=0 ts=68591b79 cx=c_pps a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=wCJ3x3wzeLabxl54qW8A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: -MIeYwtpWfsBfAcDc8daMa6HUklt1hmG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDA1NCBTYWx0ZWRfX91WUCxYuOI+i JJ8ZUSk7J/0KRCmwGSCgjNvAUI2oup886Q2oe34ChxNTmFZ8gCUHgIkhg8fEEEjKaNUx7zHAoz7 CV3E7sZQJPX2VEhHc5REkVsHJl6McdDoEZwInnIN+IAJM2eC+mIJDEM1mdYqFzmbpMuZYRJ96mk
 CryD3JKcJSatsptNtCI4MmYfi3ng3a1fV/FgnSucNHsWnlIVIW7LE3R7rvoR3UgQOz85P4x9t95 rEilZTCCWnk3PdCVlEPtacmmjd1vtdpRFJf3KbXeF+NyX8H9mrnStum5Q6JTUdoLmkpapuhqdJK 23Gd11vOaETPvdqKyCUr1ybHWYJ0hTyIx766BaH68DygfMZAEWfOjNe4CtVrfKK6Vi7h0akU1Nw
 UNpqPW7GU9MXYUPEwgcgo2VljiOLZijVH/wIZRxYaW4JhnKN1Yv0sc7SWnasx70aPpzzocSa

On Sun, Jun 22, 2025 at 12:39:31PM -0700, Andrew Morton wrote:
> On Fri, 20 Jun 2025 13:48:09 +0100 Lorenzo Stoakes <lorenzo.stoakes@oracle.com> wrote:
>
> > Hi Andrew,
> >
> > Sending a fix-patch for this commit due to a reported syzbot issue which
> > highlighted a bug in the implementation.
> >
> > I discuss the syzbot report at [0].
> >
> > [0]: https://lore.kernel.org/all/a55beb72-4288-4356-9642-76ab35a2a07c@lucifer.local/
> >
> > There's a very minor conflict around the map->vm_flags vs. map->flags change,
> > easily resolvable, but if you need a respin let me know.
>
> I actually saw 4 conflicts, fixed various things up and...
>
> > @@ -2487,6 +2496,11 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
> >  	if (error)
> >  		goto free_iter_vma;
> >
> > +	if (!map->check_ksm_early) {
> > +		update_ksm_flags(map);
> > +		vm_flags_init(vma, map->vm_flags);
> > +	}
> > +
>
> Guessing map->flags was intended here, I made that change then unmade
> it in the later mm-update-core-kernel-code-to-use-vm_flags_t-consistently.patch.
>
> I'll do a full rebuild at a couple of bisection points, please check
> that all landed OK.
>

Thanks, appreciate it, apologies for the inconveniece! It all looks good to me
from my side.

Cheers, Lorenzo

