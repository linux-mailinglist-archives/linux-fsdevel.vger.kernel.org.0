Return-Path: <linux-fsdevel+bounces-66495-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22981C2132B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 17:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60E44561D2F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Oct 2025 16:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70AFC368F38;
	Thu, 30 Oct 2025 16:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jCBgh/P6";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wi2Eqo4t"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA4E366FC7;
	Thu, 30 Oct 2025 16:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761841469; cv=fail; b=iQxQSBEcSfqjkgSoRAmljUpIT3Wb2j1p8i05fbEWTVAS/i5LZngQPJyi/kOLZ3cgWo35P7Vv+NUL8av/LX5VWG9ExszHjQ3ELjaJyBkLQ4RXl4meuuEDdfWbmdlrQZTu/FaBwZnMUTFQmhHLujfjr5dj+pjRtm8IxcpJf+c1Kv8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761841469; c=relaxed/simple;
	bh=IElR+VH9IbiD3IjtaKwKzErXNVFaog90iub3E8K/LX4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Bp1qoUFCVRc76nIi1fHHY5tseQEkE5YD4CdM5hMN3bCBHd4zuhCeVsqu4dwD3qHjXPgAGkQlM7PDZwNEnTWkMHHO1GIRd8MZXbK91e31VDZTcrsXdxGg5muDSbw28kvkVNhGBCl3yjLdChavZDd13mVQFeyJ4kZBOHKaz94VQ8g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jCBgh/P6; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wi2Eqo4t; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59UFYfJW020082;
	Thu, 30 Oct 2025 16:24:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=IElR+VH9IbiD3IjtaK
	wKzErXNVFaog90iub3E8K/LX4=; b=jCBgh/P6Pav7URCeQq+2QAyiZOOyB2gMt1
	3bSeSbNzYGbI2HmRIM8G+CUlLmR7pJBtZnasit3Cwoijj0ANYyfN2kSqmATi8vJO
	CT+8YyqixsJonUZBOAgfhPDhNAavskILmnl9KfOqnRjUW2hhNOPFk+5ZVhp2nl65
	QJnXirpgT/f5B26pnuXVKw6PX10klddyyw5xm5b09OCMbKCsQpW4ZYm2YbFHTtoB
	I2A2r7uPPxWW8GZBco6UDp+Dmn3numwNuZpNLgOkWtrD3QLuCIOUiXUoUgCMfkj2
	H/0fWVqXr4x/wV6j7VTkzXsQougxkEdwxjr3DFh7lhVypqshYddw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a4ascg5mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:24:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59UGMuBf004211;
	Thu, 30 Oct 2025 16:24:08 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010000.outbound.protection.outlook.com [52.101.46.0])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a33wmuu7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Oct 2025 16:24:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g8x198fIAn/CKrheyuMRucQXO96uGm7X2ewz67rnbeO769jFP59RZtb1gwrNSq75tJ0gcmEAiu0PRpss96pQqJQLv55kASLxNNH6N4u2ajRouKk08FEY7oou1kdp/rfuhB7t6oO9G8ixWttfxPWxMUfsBMKhl1kq55oxhA+4Fe0KuZSSoazPPYyZpysZmbBOMdAnrKqyOu4GUZhPnwGjbso2rTksLxj+lFX+AZc8eBYNgs/bezm5b9OUMQKn6wHPP0dKITQtHPyrWW7+JF4laqtg5rM57DZl5Qcy4Hhf135jIW8N+qYwZ9+lIACtQnszMM+kwxgQM9VnyODPaDHfJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IElR+VH9IbiD3IjtaKwKzErXNVFaog90iub3E8K/LX4=;
 b=UA4ZbYhiUpKks1a/aYPpCVmeICessYWGcqbPxAcNoeUbuZcif1CMJZikv28hYVi8tcGiBYX9InoKs3LkeNTLSG0UwWV/oT8ztn9SDGHl+4GmrRvcvs2p6vxy12Kpqlx+BIZ1BoIvE53P4g5DvIE+FRJU1Q8NbeBHm9gXDoNX3HlUQCnk3qZdEByw0/yvXeu3jLMbAKxC1CWckir+bE4jOD1IuL2XFR0FBYGrkrsIvE0PzmKEaUA+3PZcwHE/+d8XZCi7S8Xt3WOwPZ2yH6X3/MCh9ipckNn7KzG9jjNkj5K3532j+TmmgSfZT//8T0grIYpgTPisga7rWOPOPn9KgQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IElR+VH9IbiD3IjtaKwKzErXNVFaog90iub3E8K/LX4=;
 b=Wi2Eqo4tzkAH7meT4OadzsIapDz3W+IkfcwzgUSsZhW0Qwuqyi8p/nA6Dk8HfofKc93MBjkMuynvs75DQebqvR9CDOFNSUq3xiVQ9ZKDTbInBBE4h1KoBJTVtTmpBDugtKPdObZOp2ahs/1SsvqgtOLFRfr8Dkn4XxPDYakiRtc=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS0PR10MB7318.namprd10.prod.outlook.com (2603:10b6:8:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.12; Thu, 30 Oct
 2025 16:24:01 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9253.018; Thu, 30 Oct 2025
 16:24:01 +0000
Date: Thu, 30 Oct 2025 16:23:58 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Pedro Falcato <pfalcato@suse.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: Re: [PATCH 1/3] mm: introduce VM_MAYBE_GUARD and make visible for
 guard regions
Message-ID: <61ae955e-310d-488e-b350-59bb809f06e1@lucifer.local>
References: <cover.1761756437.git.lorenzo.stoakes@oracle.com>
 <7de40603015dee82970f5d37332a6d5af7532063.1761756437.git.lorenzo.stoakes@oracle.com>
 <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xnsn5rfqigbm5ryjtbf2rtfotneiwygzesvyfdxiqrzlyzljdr@tmbht4ggnjcv>
X-ClientProxiedBy: LO4P123CA0261.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:194::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS0PR10MB7318:EE_
X-MS-Office365-Filtering-Correlation-Id: f0e84771-73db-4b15-2194-08de17d0bc12
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?afHdAXk+RPxPIJRq0CiWORKeGyf5HX5wqFqXJx/ucXsfeuEj7D3/T8uDsi4z?=
 =?us-ascii?Q?rA0RODnBfghcd4PadOXaccIXSK2DiDnhawZSD2VhglVQk+67JP9vZI2Re3Fy?=
 =?us-ascii?Q?nMBiPwFGZKCEn7o+yGkdyVRSqEVNHUML47RtqrCFVrHczN/u3qFi3rfhibjD?=
 =?us-ascii?Q?WrW61iQvlBm7EWdL/3oFbq4YC6XEtPVo/SXBJCAuAhjY2NQwydZbmu99yVfC?=
 =?us-ascii?Q?02CKapdlMyzmB950JSCr+2GB5xlw6jQdYIg1y+hNPq+k0lvfH+7XEWO5YzY+?=
 =?us-ascii?Q?qQfo3UB9oENCmQa5RCidh54wlesALVIk+RtLZbcfbRfb9QbO5wKvbNAoxxA9?=
 =?us-ascii?Q?ueaEjxbw1pxI270AUPWm+pWVNqkP4bXLhNyz904ngsBjavBoZF0PzWkdIb+q?=
 =?us-ascii?Q?NRK2eTiccDZpLmAw0gOo6RivgO5GkhEnKVd4k/wMaDr35toHNOq2YEBrC/MB?=
 =?us-ascii?Q?CiROStEy2NHFhsW3sCMMVJQ4bJg6WF3XhbfbBkEf1pE6Epw3JARfMqr0OVF0?=
 =?us-ascii?Q?sfEiIE6bY33j3r3uFtDOPTz8URp/DhvTTZQzTR1syUCh+1apRMABSGri/AWm?=
 =?us-ascii?Q?BaVTtroFiw4L8oP5UUia719QjeAVITmgGeZzVJ7UhKSuvXodkQxyDJ58Eibi?=
 =?us-ascii?Q?Hk1PF19+dF9vyB/EYsnGCGhgYC7XSdbtZFutvHP312xrdVxxVVPTQ4d1oTj0?=
 =?us-ascii?Q?QkE1mAGbxjJA0O98UlhyQkDMMTkVnOisimzdiiuoO0PAt0zFzRXoD6z4Xr3Q?=
 =?us-ascii?Q?HCyc3qyf3gp7A/Vr4zMpVVdIdQ/oV57LdTbn4qv9wB9R+LhsW03nkUjUHA6A?=
 =?us-ascii?Q?lmOEHvjyZJ4oNiXt4pIE2dfnfuy/zH0BZ76Ujv7Ockqrd7FKc0w/rbSx+1/I?=
 =?us-ascii?Q?8mT4KEnbEXF3oULJLoQnRoH5s/rAjpIL4xMsj86bhDFTNqQm2YE+GFDju2l1?=
 =?us-ascii?Q?CsZNeHISY8hWaqp5LSAlQ6Hbp4gAANkH+TajVLddXY1QhZNTtRY6QuGxbY39?=
 =?us-ascii?Q?HBmrhsykb1vd1Yhac0JnNjX9Bm6xOdBcAGlSJDis09cleW0BW4oxVW15sm3P?=
 =?us-ascii?Q?wmk3WLhjR4miQN3gtweujp3b+16wfpzo2pDulSvdPbIyqpGhBrP1K0MdWp39?=
 =?us-ascii?Q?L4yM6SWbyXF8E8hJmojJ+22IYWnuf+BmeEG2PJp0p5Rtas7DLKqTKQWddrDo?=
 =?us-ascii?Q?nsdF0tQNjiAlFAlORyMSumuVXBK4aBuxtOJEWReANAuw93Yt2/bIxSuuW5OM?=
 =?us-ascii?Q?XM6SpimCZCOJU4e/vfIrr1Ae8RCiZzmQxt3EyUAoez9rK4ujlO5Nx5mRIEol?=
 =?us-ascii?Q?eXr2gfxrqIKwt5YxqqL0hZivBF0qYizA/k2vbelZImTIX77gwWVvzi1GdfV6?=
 =?us-ascii?Q?iOSY1T45n28Z2EqwAc8kci+sVx4YVlJ0ImUUF/7Q3DbzVkimGta1CIuRfTQu?=
 =?us-ascii?Q?Ad8fhb6R2ZtvlB6CYbrpHF8eQpxE5l/N?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?WqzYsYs1wc8JUSOMWpAfCX1Dm++Ph919Vdk0r0GLkkwxNi2pch4UPpbrueZA?=
 =?us-ascii?Q?YrA8m9xM/SgVwtwXXQd+aQPr+m+J4Fz4aM0gQ1fQ4AVqJubWUC6k2ZO5D4MD?=
 =?us-ascii?Q?A1emFaaj2BGYof4ob2c6KOSqcXQC9MQSAYDp0zkgEkTw0dWecQxZ+VncGJVx?=
 =?us-ascii?Q?SXFGkC+7Fu2PTZvQ13S5e78jb/y9bLZbyLXCUi4bj79Zhwfcq++lbenAbcb/?=
 =?us-ascii?Q?6yJwfQ7WGvEHiGx5nJX9dhxxp7Z6aXsrgbsP7IPmvPn3fkPiN9Et1EBKOQLS?=
 =?us-ascii?Q?SfXybx0c0etdEVY+YSpeP/Sfi8Q4JyGWZhEC7ny7DaxV47dpr4mDdGFAzu10?=
 =?us-ascii?Q?i58DUxbd3wiOyEiLm5RflHKQXqlaVxzbt9Zo9O7Ky9xdb4qWT2JdHKbgyH3g?=
 =?us-ascii?Q?cd+/yYq/02q6SXxNpzIRW+7GDbDQPGbkwFt6TpLSFb/hpA9dvcNlhrjXc+7D?=
 =?us-ascii?Q?Uz9GEy97BM0Lpltdnfnazm1BjOF7kArZM7VWcgOHmh/VWnXXa66QD7hNlyp9?=
 =?us-ascii?Q?X0awo0xgXGIUfMVAqxYevht+pNDimYUI6gh1vwsdRcG227xkIh67iGdlIlKQ?=
 =?us-ascii?Q?kejAe/aXO2BSQj2tU0zBXyfr+jwTCJDU/xHUr6gaqxQzulE2g0oQOv9GH1nO?=
 =?us-ascii?Q?vX08gr0VOxeE3S2mf9ZxHDV2neMnb5JaZDC+n4f99UfeJxW8m1yGQZpccRGe?=
 =?us-ascii?Q?dWjLpc+H4WczFkJgJv6xHijBFICkt74sZg3ne2ewyvj0lVyCBrwDAVnx50iS?=
 =?us-ascii?Q?qbHkH0J6sB08nbad/9n0MMLsqmrXB5U47+8r/VEvuL31dmFP1IkbnJKn4q6Z?=
 =?us-ascii?Q?ZGLOKX+Ls83hOavzrmzmBa58AwdA51gat8Q166rvgbmKFQ5H6a4Y2/D0jB8W?=
 =?us-ascii?Q?igD0ddJ37e9Lz/QxApsy2g/9uekbhAnFr/Ev5FlYYtzqL6mOyKa6/T+IUVZf?=
 =?us-ascii?Q?FkNkZRy0zkB/L1j2Zp3TrhZazBm28BFpecGXkzefNCuB8OeJFLNOPL4wplFi?=
 =?us-ascii?Q?0Q7RkJaabkK/P9OT67wZisUrdkRpoM3nFBZGThnc8+Zts0GM7ho62tvubMlj?=
 =?us-ascii?Q?lqjSe8FpZpfMEwX2tpLJxDGohQC6vFzFjPvjSylnITxwiBV69TE5+iLHJw3G?=
 =?us-ascii?Q?1vXp4+CIj+EdgnRc3DoxHbBEyaX5nCAslIEaGOktLzbFvo3A8PcQvLFkiqFB?=
 =?us-ascii?Q?GE3C87Z3Y4+mGxLrH4nzE9uhj59i+yfl6SoGE5vy+/l8zGB7PPT2WTSTNAtP?=
 =?us-ascii?Q?Sc7QxHYxCiJ++oInJNxezr/t2gdd9K6MoEEqCmqdShbvAvhSl9ITFJPVOUdU?=
 =?us-ascii?Q?ra9K+wQdZwE3shzBkfn8bSfBvZUimSwzH1KFQiebG0MRojAir41B2Gml6pey?=
 =?us-ascii?Q?9oxEClpVeEMg7+gloN52/EVjo1DTjX8RUmxgX1yv69TxHKorb8r9RSSm4Qo1?=
 =?us-ascii?Q?QgR106ZLB8Gct3P8QXI+sHd6RV/vgTkcHlbH63PtOFdGUE5uHJkWRyVYRLHc?=
 =?us-ascii?Q?q0ydTgM/5c4MN4GDKpQ6xjvac/y0I01/23pKtxAloCUIPqMTMaNaRiaKyCXu?=
 =?us-ascii?Q?04OUnryUGoPpFwbLO+GJYQjk0YlHVLfgswBH3wyY8WgPc1pDI/Cs3DgEAxhY?=
 =?us-ascii?Q?7A=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Gfj8ESvqJVfFGYZigQjhSnhIBhulwg1S2OOFRbZlwoK9zQ5XL5nkyv1h5Jdzqv/St3XgiH4mOup7qT108Q+r01At7yxBSOyj9R6oM+UuTdYzdD0Kvl+fbjmKdfaizafeRPCVJ8aORQuSXEfJ6QCbNQdxc6pJEh2AC8cdIMAOBrWfiD8Et/8mBhp6GghU4PQaIlCzYeTty4f+xHIqnFEa0+qw0q74b5/5FKZ3ZgS4HanMDRhGicEJ75lFRp45PVeHkmXWDKWpMwzeJswAdB0of9XKp14bdy072DFCDWTNblKJFSALZWhPq80Mmm6F6ocgEzgdwk3wuNRBjUa7txXBxgH172BoZmt/hq0DV00wz7anfxabVZ58VQ4yPo6Aq6tP8k5XKxFumTZDK/YFfmlaSk2ftTT0NQaqEA2aD2olWIyAcL++kZFXkXaYwLZXpkDeS72RZHP2zPQhgF1bHlC6MahgZo9xsjerPoffqrGvhRzBQGUSKp/2fPfkcknkeg/K/DK0KAYW5cDYHColHNvbOWNB9QunNgUGZQl17z1Is/xexuC65xSgm8sOvG5vJ1c7TITlT2Ik9Sn/rUCJSAbh6Zj7pjI7xB5BE1Zo/cD4Lw0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f0e84771-73db-4b15-2194-08de17d0bc12
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 16:24:01.0812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j7hSfin9OAEbYJbKDmzb63IiV9Tr0eAlZKoIl7YO3xwHkt8W7xaQybmGHitT/xxMiUOoII8yXeU6ewG5LNlBqeVOvKw/yF6LBYbYUtcX/w4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB7318
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-10-30_05,2025-10-29_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2510300135
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDMwMDEyNyBTYWx0ZWRfXw99xtHdLlTES
 CzuUMrr33BgzI953OJYYyRulWUKGYODoq4akcyWX0Va99+kJYAnljqFXZY7p1h+oJz18CIyx4zF
 Uzx+ddCgejw+apqpjBXFoGPKKokEtK5m/7j/yfonP/iec+4kCvLpJlUQZkDQeA/OINFOh9NMtdO
 yHjYWGhIciZnPKK3pfqMeJA8O65Smn7pjgPhLZu82/XM6hUWPqUu9q5zYdlBYPXU4q5JITPcyS/
 w5Ix6Dd7nAVSxN6ikle/26T4LpzLZ5Fm3ccnGV3dmotZAm+qONNeMhQasjZoUGGFiSk4sfRFw2O
 0uKcms3PAfncUvnr4QiEJo68z+f3b2eZaXhKA1IcG+Y5J6kut/+37XauMr87kDJUAEoqpDlr9i3
 sJ8iE/dDBhh82Dz4DUBUFjOw3zvcgg==
X-Proofpoint-GUID: mzlstbuubh4xw03cSyBZdVSudnjuD1uM
X-Authority-Analysis: v=2.4 cv=BOG+bVQG c=1 sm=1 tr=0 ts=69039129 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=uznqs5Qu6g2rt69a1xUA:9 a=CjuIK1q_8ugA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: mzlstbuubh4xw03cSyBZdVSudnjuD1uM

On Thu, Oct 30, 2025 at 04:16:20PM +0000, Pedro Falcato wrote:
> On Wed, Oct 29, 2025 at 04:50:31PM +0000, Lorenzo Stoakes wrote:
> > Currently, if a user needs to determine if guard regions are present in a
> > range, they have to scan all VMAs (or have knowledge of which ones might
> > have guard regions).
> >
> > Since commit 8e2f2aeb8b48 ("fs/proc/task_mmu: add guard region bit to
> > pagemap") and the related commit a516403787e0 ("fs/proc: extend the
> > PAGEMAP_SCAN ioctl to report guard regions"), users can use either
> > /proc/$pid/pagemap or the PAGEMAP_SCAN functionality to perform this
> > operation at a virtual address level.
> >
> > This is not ideal, and it gives no visibility at a /proc/$pid/smaps level
> > that guard regions exist in ranges.
> >
> > This patch remedies the situation by establishing a new VMA flag,
> > VM_MAYBE_GUARD, to indicate that a VMA may contain guard regions (it is
> > uncertain because we cannot reasonably determine whether a
> > MADV_GUARD_REMOVE call has removed all of the guard regions in a VMA, and
> > additionally VMAs may change across merge/split).
> >
> > We utilise 0x800 for this flag which makes it available to 32-bit
> > architectures also, a flag that was previously used by VM_DENYWRITE, which
> > was removed in commit 8d0920bde5eb ("mm: remove VM_DENYWRITE") and hasn't
> > bee reused yet.
> >
> > The MADV_GUARD_INSTALL madvise() operation now must take an mmap write
> > lock (and also VMA write lock) whereas previously it did not, but this
> > seems a reasonable overhead.
>
> Do you though? Could it be possible to simply atomically set the flag with
> the read lock held? This would make it so we can't split the VMA (and tightly

VMA flags are not accessed atomically so no I don't think we can do that in any
workable way.

I also don't think it's at all necessary, see below.

> define what "may have a guard page"), but it sounds much better than introducing
> lock contention. I don't think it is reasonable to add a write lock to a feature
> that may be used by such things as thread stack allocation, malloc, etc.

What lock contention? It's per-VMA so the contention is limited to the VMA in
question, and only over the span of time you are setting the gaurd region.

When allocating thread stacks you'll be mapping things into memory which... take
the write lock. malloc() if it goes to the kernel will also take the write lock.

So I think you're overly worried about an operation that a. isn't going to be
something that happens all that often, b. when it does, it's at a time when
you'd be taking write locks anyway and c. won't contend important stuff like
page faults for any VMA other than the one having the the guard region
installed.

>
> --
> Pedro

Thanks, Lorenzo

