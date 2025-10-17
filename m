Return-Path: <linux-fsdevel+bounces-64427-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC9C1BE7562
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:02:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 57049188DFB8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7F5D2D372E;
	Fri, 17 Oct 2025 09:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ig4YT/kG";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aaqsWH87"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FA8F2522BA;
	Fri, 17 Oct 2025 09:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691756; cv=fail; b=p8rtAnxRYGk6f3rJ9hm8KPHo2bFI0sRXIUPNPIejMBS6xHyqBEMlpVGOBoPeztv35+tojL+G5LZgr5YS760fS9tpYzy+O7fVAdu9xIBTESe85FYdf+uwTLDgkBihdB7B8jJuuhn50rFyfR8dK3GcpljPAkW/imIcj6LjcNOTji8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691756; c=relaxed/simple;
	bh=TxuJATSVYaOIznGNCP/BTyBLTTXu2HSvjJ5B0FmkFpU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=WoEL+F+iBZ50X91Gyzp2L6vMQPGMFBPmZwpYTE0Qe9Mczm6Z9gG8mjiW8p4WWwOaJhNf8s7gZrgGfnRMG8K2Lnn+OWyIogzsNdh22xww2x3uYUPJIceW13qTwbZG9gt8QIJB86hsF8qv0yT8rGp1maEP9liYn70cF87pE9kDfmk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ig4YT/kG; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aaqsWH87; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uI6D008160;
	Fri, 17 Oct 2025 09:01:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=TxuJATSVYaOIznGNCP
	/BTyBLTTXu2HSvjJ5B0FmkFpU=; b=Ig4YT/kGv2rvSmqMxnoGLtZCFrGRLfezjO
	ALKSRgIITblRgBCdqDG2+jivFOFhRWQZrmVqHSVfxMIoQ15TmV9DOul85MCbUCvu
	cABchSRlfGdrYHPUNG8rrAwXmS6qPdwHKDSZJU7yDC1XYJ+Q4QPJGwHaWQpDbdK+
	tXvTF75O+Nv1DfY87Q3n+8C3f5XTlYLrh+w7RVY1zPaFMsYdnJ+7LDC6wgT4seOZ
	IMeA2QMpSdu9oIz6s40pmRg9cFRfYwCFBG9iPojpmvY4+6dU9JLEAwxSrqtwDPN/
	GT5MqRMZf1Zbg1PcwlvQ+dvxGRStuFrwhUmOOD+7pB1KTeQUCmoQ==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdtytm4m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:01:00 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6wlMd024919;
	Fri, 17 Oct 2025 09:01:00 GMT
Received: from bn1pr04cu002.outbound.protection.outlook.com (mail-eastus2azon11010047.outbound.protection.outlook.com [52.101.56.47])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpctshk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:00:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EoluOJhjEzgSADSI+q6CpMgQ4GOXC+i8I7wSLNdVR805poynFtgrrXnUy5qFi1JfpJ0YBRjbOCcbz4xx/RoxKz25dIePxpeiQW4g4vm5k+qSNtooC8uwbaJEv/IqDPpwGyrntZuLgj51LYFwG2FM8WM/Cx4Cfm4xWe9XEmr/8eNjp1uq4EdUsOshDRls6sAPsKe6NmOmPf1dmi7xEHcA2XfyLkNxfFxK8Pw4OH2KQjQ6hHE93yY0FxdEIyPXrOzFlvnH3/m+HJ+gQAyOKKMT915ht2cii+8ojRDaiiqMlCLzedrIHQ8voGBMJeRfokJBgkWV0LKV1bq5nXIi5SpN9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TxuJATSVYaOIznGNCP/BTyBLTTXu2HSvjJ5B0FmkFpU=;
 b=pOGg6c2pfI0oSagJOtMzsRJ/Tqg4immEas+pkaFmtAmd9a0RtMVvTxcJ/P5LrfQj7gRHMzsy4OsPh4JZ2Kglz/C+8KVdOwXFDdj6oR7Kh4ryyajc0Txgo5+RibcvCsFBS3coh7pTNODbpB6wzASLMmhtHae+ItxRj8kNjk4GwVN3EadgPeilr2dojxUvmcC/XMJqlygYOMWTdiMS0Sruf78uU+AIX1fMZChBdA2tVukIYOVyPfXjFp/Bs5rnr2h3G49s5PZasg3Pf3XjhYzqoigScOz/NWEaWVV1D+WYYQXLBhOWpQi8kH0lhUxeAL+ZCg6UGy2PgtybW1e8Zt9JFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TxuJATSVYaOIznGNCP/BTyBLTTXu2HSvjJ5B0FmkFpU=;
 b=aaqsWH87sGa4QKOXuYUqmRdOmD/JZTdcvn0eJtox9sI+V9v6MwH95Y2Fs/tGEhGA1XhD7c5Ep5rhB2xAcKuS6BVs6fLbGzwQQtT8zcSbmn2HuQJh9Uje5dJJTjaVJsPFZFKWOMwSB1wIMPoE8UCPLrjg8OObimuhlSPrau9dGRQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:00:56 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:00:56 +0000
Date: Fri, 17 Oct 2025 10:00:53 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: Hugh Dickins <hughd@google.com>, akpm@linux-foundation.org,
        minchan@kernel.org, david@redhat.com, Liam.Howlett@oracle.com,
        rppt@kernel.org, pfalcato@suse.de, kernel-team@android.com,
        android-mm@google.com, stable@vger.kernel.org,
        SeongJae Park <sj@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3 1/5] mm: fix off-by-one error in VMA count limit checks
Message-ID: <bc45ac2d-abb9-4ca4-8da7-c737073aa24e@lucifer.local>
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com>
 <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
 <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_TJvdLxPRC5r+Ae+h2Zmc68B5+s40+413Xo4SjvXH2x2F6hg@mail.gmail.com>
X-ClientProxiedBy: LO4P265CA0243.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:350::7) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f18a2bf-9447-4f56-ac63-08de0d5baef0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+EG/GIBYCj/hppCq/cVKzE9P0ziUFlNW3N9WSSDMMBQ339yLmfa1DhfbTX7h?=
 =?us-ascii?Q?OsI3J+wEZxdfJ5cu9y4ljLpJXAJR87tsXw1hTsifSYGngn13aMvH9aYvE5Wu?=
 =?us-ascii?Q?JOAFwFbkEbuYmwIrnhXUqS6o7+vYjrJ7vbR9HygAOEJEYquLwKKZEQBM/2q5?=
 =?us-ascii?Q?8FsaRJn9HcdjjXVzd5tWgLWYIIY+a2v+xBa+KzhtBse16t3W8MLH1iqu6ZQs?=
 =?us-ascii?Q?POcQLkqC9GuNEaomU64PrE18AClwgAR7luXMGOmKWzBMcEhbARN5lVAvnhzk?=
 =?us-ascii?Q?2gmHl1sIzVyijIMx+3QOzQhUkfdrTaYyRmvaVAwTGsmbbDygFyffSJ7wm+gw?=
 =?us-ascii?Q?o8piHUQclltQP3QHhBiohRp/Q9IZ1RG3F4VajN/5ItBfDdLBKDEzXveD28TC?=
 =?us-ascii?Q?XeyS1MdAm3bKA349f6fifGqudDp1/QHJ+iUfdzFGZbC5/g3n1n4Xrc55k2w3?=
 =?us-ascii?Q?Bw7lbLTNSv1WQOE74QwIBThV+YQSLprNYdpSatiMWq2K7evHaQWvcBJEYwk2?=
 =?us-ascii?Q?UexwVLGHSj13c37zGOAlKOaBdLsT55Ur7vGPahDhlLNRmj7Sm7vt3oC5/xeE?=
 =?us-ascii?Q?dQxv0VCaSJz+jWudVvYpt2yaAa73qp7olqZSB6tzEOu3oeWzm7blLQ3e6US6?=
 =?us-ascii?Q?AUq4xYq9iKEALTzCbYtX4AGbndq4MPi5fXxiXMU617gq7RuuBtmCjtMrehYF?=
 =?us-ascii?Q?Uox3Np0g83l35w4h8byehIvIMPN1apua3BKjqsznWpl6RDQiYvq0xa1Q3ckD?=
 =?us-ascii?Q?congENLhT8HnovhBFChaOBh4rk7Mf2gvGMgEEDJ6UlOOTMy19u7fg/UaHq2g?=
 =?us-ascii?Q?2H9pcDt/jWOAU4JvbvAv0nTAgMQcuzAdCAJMYcXfqEQnlGh1ZzdgAmUy0xvL?=
 =?us-ascii?Q?sQWOdG9ONdov4wXzlBfcbF8J70d57DIzk9VXNqwgG10LwYm6NAChcIQg114a?=
 =?us-ascii?Q?K7eM7TjvhoJ1J0F7G+nQZ9gzet2wEoElMrWxr/UlnP2Fp83tr7alqhClqmcb?=
 =?us-ascii?Q?qnc++BE78XJEC0avxvyg7zH0eHccaKHiWSPDigLSFBcchlGwwonYBD9thb/a?=
 =?us-ascii?Q?GLNPsYIOIIPo0y7PhAmtI2BNSTv7JVf2nqdhB2+HQbukhQru7IrABc7hTo2x?=
 =?us-ascii?Q?fw9tIR9+EGFGrMdrcIuM3ZtkBosDE9h3+iq00cqXBqSIEStHyt6qzQ/vKuZY?=
 =?us-ascii?Q?dGw693feAhluk7Q7JFZbmrGmY/l8hE3LPUKzjSRioG7d5ijxTEnCRgBY8AP3?=
 =?us-ascii?Q?UaNScGVhi+3ZVXzAdPANVPD+ESzZWez9qIfGcWGr4cpm2P2hNSXBXo7tQYcw?=
 =?us-ascii?Q?NOhoQvvbAxx13EK8cg1UFR42KzO6iHFixMQEjvWwXztVvnQhHuyVSmdXyws4?=
 =?us-ascii?Q?meLU8xGX6sY19OUcBPNHvcZqSabP3srsxhzIiSUQPrJwGxG9f+jKDsZlGUlq?=
 =?us-ascii?Q?vHGgPLPQDdOYV5V+WMVMunnnVW02qu2v?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cp1MVji3NZoMjsrcU/BXi5vcUVcHTComeIozBeD1SDN55ry+X68p43DcOTES?=
 =?us-ascii?Q?3kp9R7NTWvpxVBdte0Jot7Nqk5Dipri3mV4hm2Ry4nXlPyisr22loqyac7Yd?=
 =?us-ascii?Q?Hrih9qMJRhWMD7RoNKlfxrxl6gE/lvY5r5RbUbRTrT3cWNK/buQk4COg/Wqz?=
 =?us-ascii?Q?OakmVwsKqgom75m+aMM51up7zn6BqBG4nMOygmYSr3BOH88MqpJKV9dxkipE?=
 =?us-ascii?Q?HQoPp1laavfuC8Fnj8UST3NbTOeQ/KoGTULyoO5og4tCgmbcfBNYct9k/hz+?=
 =?us-ascii?Q?F5Q6pTB+eqpyjWz6ce25RpdhDPJvjd0UGwU7ZTYqusYJ79nJh/SBL3/A5cdB?=
 =?us-ascii?Q?RLJSMqQt2ixXGOcrROoZC4Kg5kUf1OXyMH23/gQla+KkEOQsmmK0xFFZK1Fj?=
 =?us-ascii?Q?+Z9lOmQUssq3aRSNyMAQgK1DoEcXc0oALB5B8e5Y1caKpPr95Fjxm7EIqSBO?=
 =?us-ascii?Q?swezJpj3A9BwMBbCF2HdNqJHIg1Xbcov9+Mv5WkwAVx65U7CLLRAMWbdEApj?=
 =?us-ascii?Q?lIoVhO2gdDiB8GOOLAeW3aZ2E+ieaDXEFSm9AWgixyCrPRXO/wfEVCl7+Hvh?=
 =?us-ascii?Q?ybewHCndoLxxZTND4MJ5J1N2lR+kOH6sznk4xxnOvKT1hKFBcF1ASEcTZb0m?=
 =?us-ascii?Q?C5HPv9KU85lM7fWSucEYwwG7MKeDt7LegpbRpO7lRLmSPDJ/jMn/85RG+7ZF?=
 =?us-ascii?Q?x0zOIpphiKwyRNFXgTwaaGaFTbjWShZqltQS/y4zkU45wM193WlnEtmrPleb?=
 =?us-ascii?Q?tc2ye8pGfDrznUa/0OU3Ri0Z0X1dWu8v0JZPHehT1d+arNnsD2k2rgPwRkIh?=
 =?us-ascii?Q?q+L8poqyB6V7YNbDehDWEuogYKz2/Rdk4gm20lxaIVt/FRoNL0ehyw2qkyIr?=
 =?us-ascii?Q?Wxqc23JHho3y+VQ6OTUo3R3daobUFyhhTK+szdbL4/vSIAbekfjI7WUAWtJJ?=
 =?us-ascii?Q?yH4jLYsVXdbNbiGpLvmJsrQpv0lyN6a1QJTOMNvENoINj0f+D8644phavlkw?=
 =?us-ascii?Q?fTApPJWzxBM/GKFGokkh+Pnt6wEIcPLCERbsQt1VIFe+qmJyWcT5SsWIDcX7?=
 =?us-ascii?Q?Ox63+h5TxuK1NE1dmado3z+Xg/rsrpZb6vDfjg83V8CmPVBoTSBwxvJuW8wV?=
 =?us-ascii?Q?TlY7KLk1wfqjMetwHIEd+3Q3wzA3hACae6iR/pbqkdKNfoTKDjdGUFXfjkQP?=
 =?us-ascii?Q?bIbUXFZwP+kGI6V1p1PXtlTYUe8MrTU0A+GufaPqNYSfuc+Fxse+N3yoBQxg?=
 =?us-ascii?Q?AF7m9d5G/E/JsEFeTyqAY0/rZ5Ca4Hkczv6zmMsUicWQHOJHdbNrMYNIDs/i?=
 =?us-ascii?Q?Pid2qZL3x1pQheA4nCsbRWSRa7qtYYfmZ0r2n4fyQWjilZUUfOhSA1zegXU5?=
 =?us-ascii?Q?UrV9GmXQpyVUqRWP+1L3oqM3QHDaf82RWXJYnvea/3hS0bOvsmu2b3xDA+cu?=
 =?us-ascii?Q?I1WqqtthrLyNjEo2LOjOgcwlYoUf/fU6vn4+kx2LzBbR01SIR5VgUY//a76s?=
 =?us-ascii?Q?NAMdhFIapMdvE+HJ2Askk1b/6BH3f4tZm0L+5z++TndgFvMwNGTBlLsb9wzi?=
 =?us-ascii?Q?nqRg7ea7enOpxf98q22ylqiKRiJJxQy4bFu4uQBogWVni93C097ES0NcvP4G?=
 =?us-ascii?Q?Cg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9lGhN0V0KNRdD4JcVkFFRyf5BDaF6pAVj0fLopLIukRJId/JDckj/5rQdaorh/dBoyT8122hZS9ChvrcvlYjcePp3ID7qxDZHjSiNbK19GgtUGLThSjqVtw3gxDZboEzaW+nncL1Qylu9XLxqcDWAU68jPeQwrOHfYqJmoP/CwxR5DGYzcMTGAb3pk4n+lo/w62fhBUgJFg3dbg35XsDvThOGIhskGQR7rp3eJR7gzFpDKZwm1ViiPoIHVfgJ45RSLAf2lZUHVmIYaFNxrZU2lFOw48NH2Bv45rb7SOffswYhqJqcoOIFnLZLi75MZ4UM7yqTZHX2NHk8t5+B9aTKDqVnmJ9mtta+dwkomY5jJZRNY8amCrl/s8rTxEPHGGlE5nllIj+L+T2h990wAXeGja6XV8yRRVZH5SEvqXkunja70aUK4lhFG5wiMKwAMpdi2A0Jn6QXu9+ma7jFhgma/3dy7joi4xDvA9bvSbcWkMXUYjGt1AavsP1Xx32JdFy+UPKjRbIwInV2OnjgASnIaaOVdJvq/iHtO1vBYHDz3xWPmqRuGIrAIGI3TTHF9fLF9qLzOp/E06oZ/3SL1wolzLAMZ6tVNVfmVQ0Ew1OfNs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f18a2bf-9447-4f56-ac63-08de0d5baef0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:00:56.1971
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Yz4MhjqzLOkXQ4WNUB3QT3loMrD5sX5esnQWLNZ0aw5HNF5pLNnhktZWqpa0qQHgm+iCI4BygOfg/x9QIHQw4gZgdIk95KbPikmMU4pbfBs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 suspectscore=0 spamscore=0 mlxlogscore=824 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510170066
X-Proofpoint-GUID: q2kR8d33d8jV7uUN0X3TfbUG6WKAfm2b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNyBTYWx0ZWRfX9mt7wSkM2imW
 W14y0Hm2zzhA8+BS22+kZsHmojK1ACyWQVpdBr1YrgrpTrSA8XvmI9rG6dpWGWPnjpoP+3P8e9v
 JJkbb4fffjCuwPITXVL8zPyLfCnRGvSJ03xNfoARJL697ABG6X4bG4zKfm63avMERlc3b+9MFnU
 iG5C6oznagaEAWtg9AShaOCKq4jiYIC/e8M+Dcm1tvd750NhVuwToAyc5osOv9iDbn/GYLk2T0j
 Lo9TBFz+zuZJKi3TlN1SFjlrwE4XJh6qvqabKZHBLva/8lU3HLFyoiXrMdDsEI3pvESpua7VMPM
 rZkob5sJg4+kZbAN1RK90Hv1QomjVGqZ+Ujb1nZzKpDTAoYAWYDEbiKiTf5wAGhs2UVbz2+uTHz
 ocHOgbHV/E4o3Fz8g7Hkj4pOL1pteA==
X-Authority-Analysis: v=2.4 cv=OolCCi/t c=1 sm=1 tr=0 ts=68f205cc b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=5EUmVaACWUl__Ca9iekA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: q2kR8d33d8jV7uUN0X3TfbUG6WKAfm2b

On Tue, Oct 14, 2025 at 02:33:05PM -0700, Kalesh Singh wrote:
> I will drop this patch and the patch that introduces the
> vma_count_remaining() helper, as I see your point about it potentially
> being unnecessary overhead.

Please do not drop the helper thanks.

