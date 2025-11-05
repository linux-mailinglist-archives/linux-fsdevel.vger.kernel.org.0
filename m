Return-Path: <linux-fsdevel+bounces-67190-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 206F8C378A3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 05 Nov 2025 20:49:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 276181A206FB
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Nov 2025 19:49:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FAEF34404E;
	Wed,  5 Nov 2025 19:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DpZQZ8vV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MCjXMat1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9B9343204;
	Wed,  5 Nov 2025 19:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762372111; cv=fail; b=hKXYBvv4X0nhwaE0sJrL0gQJDKQswokmJqRmInYhIFdDOBZYx+wfagpCc6HlijeHtmMHrxJns3sR5itPcnAj0U5iRqVBMKU8bwUDCpbDsVlP86j2h70u0qV1MQizOY9KHVWCdQulZ3UjxwnqRLI4zq8UIL3JtmPSdBiEO5n6IYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762372111; c=relaxed/simple;
	bh=dzcGz//I/6CtaibkfdczdiIk4THKvPDAdgB6S7vt/Bc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=POU92otNj76TPd1BmVrqmtnL/DF87UvfC9kqA0fB+9KN/bvZUZb+TKshz8J6WF8VtV1tmAP566kZZphVKFY88GH8zChLB2gmIamixvBFt5r1inLDVJ/SPnljJb3TdYg56iaWbzf+P7DI5QJYJcsa2dJz2VgMNAP0v0Wx4yZurQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DpZQZ8vV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MCjXMat1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5GoMbg009544;
	Wed, 5 Nov 2025 19:48:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=dzcGz//I/6Ctaibkfd
	czdiIk4THKvPDAdgB6S7vt/Bc=; b=DpZQZ8vV7N5/kYZaL9lXbu6XCivaFJos+L
	Nh7+g5jpfD9rxl6x5VFckiO9tnjvPiFwSNBcQI8IOQTHfUYtpTl0rR4IeWQFu8CR
	i8a7JWooie1krPVtinCjMjiUs6kyztvpqMOJvFMGGt+PcT2MEURAHtpNMGzMgkrz
	+hflBCAolLE391oggG45KSqc0vbo4Dg1agJj5hQei2+vXDP7PBi1uFHWet14WFC9
	GYHPgruA3EVx65PZOF3AXOwn6dSD0CkvQAc/heFq9Huaxbv1njHtacR70dSx1Njq
	JVz5PX4LwN6oyYcZNY/oaAFS1hPA+x+4Z8BF3it3CRy7c7kgpbMw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8aejrc66-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:48:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A5IDncG002730;
	Wed, 5 Nov 2025 19:48:07 GMT
Received: from mw6pr02cu001.outbound.protection.outlook.com (mail-westus2azon11012025.outbound.protection.outlook.com [52.101.48.25])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a58nf0ywv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 05 Nov 2025 19:48:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=djKXWWJsveful8q7j6uBynjahpgBUY63UeWoUDGoqf41z+dqtuqlzR4Tc+rZwPgOhmBg6EUDs5IsGWFS140mGOdXQlxXVzr4T9YFGoeifEE6/oRskep2+XeLaJsl9LCiWDQrzXnq8mig2GHmhew/COdmGi/lJOcUUdCndmH27evMCI+aRv4xEXLePTirGrIpxp07ERgSsTUmFXXueXOhizff1uEKDKalnvnIZU2oppQjzNoGaz7CPkBD1yGAPGUe0sl0I/wvlEatygEBimF7eNNW7z6m6N7qgMmfFjWDR8yG6Gt3fZjpM0A/UL5fea+WCmTbZ0XCoVQgxp6ur1Hcvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dzcGz//I/6CtaibkfdczdiIk4THKvPDAdgB6S7vt/Bc=;
 b=kij6pxD+xriBGaslqVGjucAIFcE4hHxFv4l+gOWHBlU64i3Oi3U1KD/x35FYwDV/EZLo/k+Fdlye00fPk0Efn9KPzivHk4UFoRLOrUSFe9OgTsTG3tnaBpk8F2jsDq28tacPQZeGi7+hnf/8RZASSied07beGxBMS+71y+YBl/JILnMTHCWjyN00enmwR3jKckw2X4UJSXlR+m+8F9zdACShc0mvPh9RCPA+B7Yv+ah7Pvf4JOdQlq9XTAZwrOF0M0xiQKJQjcmTZYHFgaZ7CC9ie15gHLcBaU1iiRE8HamP4oyvL0Wsn1ku4kW+b/6GojSlWg8Vt720enDrZGFHzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dzcGz//I/6CtaibkfdczdiIk4THKvPDAdgB6S7vt/Bc=;
 b=MCjXMat1YhJYTVnhUafOGVx7GesVqqQmJsyKTg5hIyLK9087wKBMQmiVZKo2CdEZPnMXIOo+4T47Y4SOgnuAO9JcFeYPy/bKRQDBfqvxhXHYun7ZcxUDe4DAeMN2jyREMHlYyxt45jhXPPN34aKD2wiHYvcvy39eyFt0TTkOzyI=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB6968.namprd10.prod.outlook.com (2603:10b6:510:279::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.7; Wed, 5 Nov
 2025 19:48:03 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.9275.015; Wed, 5 Nov 2025
 19:48:03 +0000
Date: Wed, 5 Nov 2025 19:48:01 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Vlastimil Babka <vbabka@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>,
        Barry Song <21cnbao@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <29c388b0-df71-4905-b434-ad7c3d5030ce@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
 <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
 <c736tssdw3z57kamh6eqc23gr575q375n2o2nnszih64afnaf7@zwbqremsbhwf>
 <053f3a04-9195-4f8d-8959-42e0c3ba077b@lucifer.local>
 <72ee2324-d599-44b6-92ce-ed0afafed78f@suse.cz>
 <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3ae457cd-6c18-4870-a617-7f937b107cb4@suse.cz>
X-ClientProxiedBy: LO2P265CA0178.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a::22) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB6968:EE_
X-MS-Office365-Filtering-Correlation-Id: 5cfa0f28-92f9-4495-8c5a-08de1ca43bab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?UsSMArLOZwMScC5XZT60P4/73oSoBv/arDlFq5T/BuInYiibHMrVSkG1ODXY?=
 =?us-ascii?Q?1nF7XiwBfmJM47gQzdMZDlj5+99WvgN4OpbmY8il0jsBNObpO0MzgInaPU6m?=
 =?us-ascii?Q?jKILuJbWuPg3eyyCF0Q+iQHM+ffM5zuAawFVZ08Vz/RCZ5O0aui+/gEnIMjU?=
 =?us-ascii?Q?gxyUntSZ1JOpGi5RY/bnrMs6+2K4r7yRbyb+IGqxv6QNFF4xn5MqxjSi4fJP?=
 =?us-ascii?Q?HOLXHJUA51TPpBkdOAkDUSx/cYNWdANwdLQoHZTvnBgD00gzevEZJVF8Ku1s?=
 =?us-ascii?Q?HKDJ7UMVB4xdPK6NzpY7wK2ynS6k4xYkq9hU5PSN/J90g46s+hU3X01r7Ial?=
 =?us-ascii?Q?M5eFXrSpaY6JX7Pp05jWd3+TGyen1ok22buTtAg+Ck3GXr+5Tlq2rR5nLPim?=
 =?us-ascii?Q?yvqXrCnGSQKUw9cTPQY46ux1NJKEVrhqj9yghZNNxGx5d42cbxGO46+0+DiA?=
 =?us-ascii?Q?igeiQZXxajV+xtjmPEper4Vge9CZj6MpV++95/oy6dxfOk6PIkHNUsmEz4UW?=
 =?us-ascii?Q?ilqAjDzp/u3Bmy6JV5SFjMMqS/ugARnZlkhBNRsdzASjoTYGWnuPKsIqaCik?=
 =?us-ascii?Q?ZmqtGdRhEY9Sl45NzGwYJV+37FJ4JTlzagssp+OjHwZvT0hIepGtCXsjEsK+?=
 =?us-ascii?Q?TUNKJpEnvZsiPu1si5MlAH7iMsB2ArESzkQaqyYCY9HwiOLSz/tvK2zgrcR+?=
 =?us-ascii?Q?xyBdn8tUKclv3T7vOzamJbg5NJuTXN2AdIrfc07f63vepOwcNTq+R5wE9utB?=
 =?us-ascii?Q?njEWCY1ChxnQkcEuQYw+ehDuxBAvj12IzbJVJ/PYAjcgdwBljBZ87L3JHNEt?=
 =?us-ascii?Q?dvD8O9bkUqvFCwj94awJpG03slK1z3ZwbHORS4YbZrbCH/q4/GhWaC3y5hSm?=
 =?us-ascii?Q?7hqFAepbfztIJKGPSQTQkRMBafvB1A6FmzVDbwGCN9nSGNJjpZiA619PSJVy?=
 =?us-ascii?Q?/nvQK6vOZ9oRE2JIyc9chrZZ0VciHWgfLkBN2bN5Apc9n5jcwbyiGcjMjvQw?=
 =?us-ascii?Q?T4sQjEJkhDDehvSwWm2NPPlQ3iOwY8zB8MynYL+1xKoumK/EA3T/OwZtkN4Y?=
 =?us-ascii?Q?JlhdNMf/OpQMbyNFcoKeDJzRBTzDzaPGYZX70YA3GLlUlIZvPOnnU/XMc6lx?=
 =?us-ascii?Q?1BZLbaBp8wBBpJqjSG7TQf7Lvlm4P6ft3fsGa8q3ASiD3unol7pKIWfrdP2Y?=
 =?us-ascii?Q?dn4sNh/LkKkZ5bi6WjGkI0U4uNNf8sdPoFAN3gAXWEv5gMI+1HvTpPXPpnO5?=
 =?us-ascii?Q?GsQJu9dxTWPExUkNLNXAsd9SI4AXUE8fIuGlwKCJfmXz40UXpfnCaRdTXgH1?=
 =?us-ascii?Q?ZhpJ6eR8zat9ijFgw3hsZzm6iEHzckNzyUUULkN4m7LF+bhg7xAU7WBLMdQ1?=
 =?us-ascii?Q?bUmNvwdPhfxAsfYXaZYiiqvXomxa/pQofcsaHyH5Tm7bxnjWC+GozRQAHCtW?=
 =?us-ascii?Q?DqfhlDN4/tZMXdYKJZ9eWNoaoz5TRf8w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?HbfV4shwqLdBL8zNwH3FO+rcYkPw4x6a/XxNjkU1WjmO/xS/YdAtb4Y1G/yA?=
 =?us-ascii?Q?6Dfr+kb+RLQWN3v1gY9zBIn8T+W+2chzaaz5G/P3K1h6NVNuR9d1r7S/C263?=
 =?us-ascii?Q?Nhx9LY1M6Tup04AWvH9To8+O7ta3vYeUS9naUnqQD7T0o13rXOyKemGW+qEU?=
 =?us-ascii?Q?46CrFobtmX5UZ6ByEhrj48CFnqE6kqdikPYM283hkGP+mIENwpM776zIcAvm?=
 =?us-ascii?Q?W3XW6OnqzMSKA0XhjGGuwOdKRHEi/IoF4e9V64HjFIZwPF/bIgpVB3LzZoxY?=
 =?us-ascii?Q?/+Q0nOybfeibRZVOUN2GTbPeIRVG22MZyQgC8dlEFBK+AN59n2s0/zui4+nX?=
 =?us-ascii?Q?Hgi73Cyp3Erh1m7uSZslND4yz8y4OSEuqYwXQUGBZSB1pSGERECwj54nzMqe?=
 =?us-ascii?Q?UJMebqvUqiIcfWbgvB7UXj8XyM1usv7bxr8iEdizOcpfH1nPsb36U+Ybw6kh?=
 =?us-ascii?Q?REJSyGBu3W8jZ1v0BADrtlsnBt2RQg1sBSC5kzvuZPtqqQM7QnfpItutZi50?=
 =?us-ascii?Q?br+2c7IMnqgAw19pnb0ajy+gKcTUIk4ujvEjcKGG6YhLmp3F805xziWO6Yvt?=
 =?us-ascii?Q?ql6yTndedBRlezmHln6uoCTO61pbhl695O9Z5Zbbi0iHdrQLpkhOrOLMcG+d?=
 =?us-ascii?Q?yYI74xYh4e4GMtV+Eof7ddZC7jVUcO+Wo3af2EK9co8Kr6g08mp4XPhLzxPe?=
 =?us-ascii?Q?xSLfnJD2xkY/V0DHz3LIliP3TdG6xXa0mT/ylSLX34XTw+wME+JoVYcBDUru?=
 =?us-ascii?Q?w4HYG6shwWFKiXR6wJz93adx1wPH++GJCVOGBiT6M4+iDZCbQ4rvStPYzAUX?=
 =?us-ascii?Q?azzXvdrkiXsfTgVUAf4WW/41Ow7C71DbLiiMEAP6QleTfolvE8NufhJWT1yB?=
 =?us-ascii?Q?Iy9J1KO8V6+1wQlPkgrKjJQVX9TKjECHH/sLzkUw0pIj9Qe7v9fOE1RAf5Zn?=
 =?us-ascii?Q?xtQcUwS5CVg5HFrFD0CyAgJx+tAJHT2jstSvjWJkz3kn/NGS6HvKeNCpC1Oj?=
 =?us-ascii?Q?nOwhW3IckVpN5/8MHIMJmBRvMf/F9P08NXLsOFqTJz37Rvh2AC5N6IvfZzHq?=
 =?us-ascii?Q?tVPSk+3hnlkVZw1sF5oKUKfVyNwwd0FuLACzK9xT1zEp1pFArlIchgkaZewW?=
 =?us-ascii?Q?feqi+8Cjtzha3KFne3XS9efrRxzskcR+Fad6s1++3TiL0g4J3eTxBFPY/v6w?=
 =?us-ascii?Q?21rW08goLZUrL0BcSTX+9DNzq7PpxV2CjIhuFGfRPGm+eof+p5nC4gvjgpyc?=
 =?us-ascii?Q?XUR/04vYadbzuXrQfiLNHZpYrxWINOF7d9Ak+N1ulkvzHHQgN+EExZ0xiPmo?=
 =?us-ascii?Q?OzSvliqHl54FqqM7EdDVXmn0wVO52zopV6KJtWjCFDN3s7Vu2iN/V829walJ?=
 =?us-ascii?Q?JhTZBB+e3slFIT8oswA9bEgIH/LvrW2B1dUDZC1mcjqn0/xOnXRfD22KN72t?=
 =?us-ascii?Q?F9uuR3QR3fBVvk6KEY3R2S74ioid2Sp1Er4Prv68NLPiaIbVxY0iwXqU9VTC?=
 =?us-ascii?Q?3RduoHZfbPPifVwBpWdKywME//wddZ1JrD4HC0NS2IkcfPT+t+BzOswlCqK8?=
 =?us-ascii?Q?Qby3OkD2EW8jQpqqiWG48CVPw8dEJkUFwIOv1FbVnZcTl0x04WjFvefKd7dV?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	a0N+dssOXBz36lY1b85LQr+bbtUhG03OajKwzihl+oS9MD9nc0HL9Hclm+FA9QdpcqokPdmncRh08NxykcD5DdXKWZjRLDR+7XJgdlCBg5eYh/FGNpGtzVCf+6gi/ceijrZX4cVK+NMp7e2hpKbI1t3JAL8tRD+XbNJK1pFFgzy81x2lVSf5MOBxL+hbu1Y3GiJF7/L8FZaYqfx1fVO6uNeqa4etbmvEbR06s6AovD20+PN4FObamVJscCfrTYmcL3R4S9rWxiYjSFcQ6t0KheBlYnlxEzRNH5ZbSWYlOzDWHqTG9HNx6IDjLTqP0rViDY9M+EGRYf6/zbzxvdCqdn1sCjtxYLILU8W3FOmgl1ggRAaY1O5EYRZr7daIBdsiOWJtVX6uNtJheOLUuaMaYzri0WQVvdd3V7QUk3LvZVBU4IB3vRi/Q4gVWf70c5Akbk27tWW/oQbZ//hVT0Pxz+toCDGjqFdTMTIeIadQMkX9yG2Pz0M8XrC9sy7hKLQDSjXdht0i8m2xacgNtynTMKw0QtMFnTAzZBgZ5G6ZC7e+BwDNd0oV2O+GhdQLYgrxjK05HwlUXULf43zCj+FZCOzGTZEwSWNrgeDsTTY+x/I=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5cfa0f28-92f9-4495-8c5a-08de1ca43bab
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 19:48:03.6452
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 36KlyVSFp8jPFyuMqNcqRcnDEdTF5pffINl3XQRF0gKMvh+OKCdtwTQZ47g0QfwKbg1GHalPMVO0pP2z+BvbNr19xwae9QfZ8EkO0+8qmpg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6968
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_07,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 adultscore=0 spamscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511050154
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA1MDEzMCBTYWx0ZWRfX1xGBJZkApFx0
 sVnK6LQYm230d2QN/TfQQ98O6e1XOIdIGnBoX6AYTv/pJQ8MvUJfLjLro5+bK+r8LRxB1z5woEE
 9PyV2FcC8douk3QO5UD/hRp+GdgH5ljQNO6lbNidOj+1+5Py0ROgaa+djokIFmQGxgrgcethy7k
 QEH7eFrvyzoUNKr0pvzLy4CF2I+usAtm5yD40oHkhHmki/N93ZwSoziJe1nyoxf1ffZQvWj1nmb
 5PhnbDRx1lVxsvXVIHBdiE9HFSAvBpu6OGW6KYuFa+/oKpFEPWF3yPk1jbZzQux83Tk7tjllk79
 BtTtXkhkCcXtUiGDEAU0iiOZDZDkDhWh43trI0+yBriEBxTem9M21A/gHGwuyP3mfWbSHg3GTzB
 mlvxCxE50iEistLH0u1SeDrFOUiq1fkx2MFE6LKGvnoUWT/juHs=
X-Authority-Analysis: v=2.4 cv=R8IO2NRX c=1 sm=1 tr=0 ts=690ba9f9 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=2fn8s1_UY3Wp54dCDo8A:9 a=CjuIK1q_8ugA:10 cc=ntf awl=host:13657
X-Proofpoint-ORIG-GUID: L1rx7QhIKqA1sOtPylXpCYJr-eIEVhX9
X-Proofpoint-GUID: L1rx7QhIKqA1sOtPylXpCYJr-eIEVhX9

On Thu, Oct 30, 2025 at 07:47:34PM +0100, Vlastimil Babka wrote:
> On 10/30/25 19:31, Vlastimil Babka wrote:
> > On 10/30/25 17:43, Lorenzo Stoakes wrote:
> >> On Thu, Oct 30, 2025 at 04:31:56PM +0000, Pedro Falcato wrote:
> >>> On Thu, Oct 30, 2025 at 04:23:58PM +0000, Lorenzo Stoakes wrote:
> >>> > On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> >>> > > On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> >>> > > > Currently, if a user needs to determine if guard regions are present in a
> >>> > > > range, they have to scan all VMAs (or have knowledge of which ones might
> >>> > > > have guard regions).
> >>> > > >
> >>> > > > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> >>> > > > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> >>> > > > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> >>> > > > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> >>> > > > operation at a virtual address level.
> >>> > > >
> >>> > > > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> >>> > > > that guard regions exist in ranges.
> >>> > > >
> >>> > > > This patch remedies the situation by establishing a new VMA flag,
> >>> > > > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> >>> > > > uncertain because we cannot reasonably determine whether a
> >>> > > > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> >>> > > > additionally VMAs may change across merge/split).
> >>> > > >
> >>> > > > We utilise 0x800 for this flag which makes it available to 32-bit
> >>> > > > architectures also, a flag that was previously used by VM_DENYWRITE, which
> >>> > > > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> >>> > > > bee reused yet.
> >>> > > >
> >>> > > > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> >>> > > > lock (and also VMA write lock) whereas previously it did not, but this
> >>> > > > seems a reasonable overhead.
> >>> > >
> >>> > > Do you though? Could it be possible to simply atomically set the flag with
> >>> > > the read lock held? This would make it so we can't split the VMA (and tightly
> >>> >
> >>> > VMA flags are not accessed atomically so no I don't think we can do that in any
> >>> > workable way.
> >>> >
> >>>
> >>> FWIW I think you could work it as an atomic flag and treat those races as benign
> >>> (this one, at least).
> >>
> >> It's not benign as we need to ensure that page tables are correctly propagated
> >> on fork.
> >
> > Could we use MADVISE_VMA_READ_LOCK mode (would be actually an improvement
> > over the current MADVISE_MMAP_READ_LOCK), together with the atomic flag
> > setting? I think the places that could race with us to cause RMW use vma
> > write lock so that would be excluded. Fork AFAICS unfortunately doesn't (for
> > the oldmm) and it probably would't make sense to start doing it. Maybe we
> > could think of something to deal with this special case...
>
> During discussion with Pedro off-list I realized fork takes mmap lock for
> write on the old mm, so if we kept taking mmap sem for read, then vma lock
> for read in addition (which should be cheap enough, also we'd only need it
> in case VM_MAYBE_GUARD is not yet set), and set the flag atomicaly, perhaps
> that would cover all non-bening races?
>
>

So thinking about this again, taking mmap read lock will exclude any VMA write
locks (which must hold mmap write lock), so no need to additionally take VMA
read lock.

Also as mentioned later in thread, the invocation of vma_needs_copy() is
performed under VMA write lock (and this mmap write lock) so no need to read
atomically there either.

As per Pedro, we can treat other races as benign.

Merge/Split etc. are done under VMA write lock so there's no race that matters
there.

The only other place we even care about this flag in is for /proc/$pid/smaps,
but there it'd be benign as you'd happen not to observe the flag being set up at
the point at which a concurrent guard region install is happening - something
that you could race with _anyway_.

As Pedro says, remaining cases where you read flags would be benign, as the
readers should never observe a meaningful torn read being a bitmap and given
this flag only matters on fork and smaps.

So I think just having something that sets atomically with an allow list is
fine, but making that very strict so literally just this flag is allowed
(currently).

