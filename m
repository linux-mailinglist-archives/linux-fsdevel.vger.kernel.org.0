Return-Path: <linux-fsdevel+bounces-64428-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBEE1BE759B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 11:04:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8171893131
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Oct 2025 09:04:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06DF82D5925;
	Fri, 17 Oct 2025 09:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="UWb/bP7y";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MS3YvpUo"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8565C2D29CF;
	Fri, 17 Oct 2025 09:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760691850; cv=fail; b=VYyQ5+POTi9kjmR1HNCh+NFttK4WrHtlHjzgINF3Sf7bGBE3uDi6HRSf1eNM6ipQdxBjAtURHiEaa5HL8SsoDGkIs9XPfDTz4VM9IvFQqoXLZ85gwR7Yp1ZB/ST8B2V07Bk3cfYYSOP6pu3apluFKgcTF2Lc4MQQic1qUd8kl1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760691850; c=relaxed/simple;
	bh=yUrXA0gUSGmBniFQr0VA5oJ0YaP0ZlpdG0SyYfFgqQQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=OFpQSZrLbx0e0wGnlRD5kIZvHjDK94JBbGIH4GU3EQvhSbC82K+VelfXptm6LXJPRihJOJ5SM36UKZapOSggxeNXKQwelPKJneTUy/9hwY0RyevjarVtc0nf9eVQMMol8iSkTZnYCRlxGSOCz+Wftt9ysSaPRT1BlOfp92A3OeU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=UWb/bP7y; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MS3YvpUo; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59H7uQAX029351;
	Fri, 17 Oct 2025 09:00:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=KbCY97W87G2lEKThQV
	st1nRgGL3XdD7eCfrGoBwyeyo=; b=UWb/bP7yWVnTE8dV5aZQnTNYcUorA8bxSd
	UXwcgNMGBteJ8oUNkG1t3G6pc6+wRQc4KajrG4HXX/gK34RalrAOmrCpcOAwpOak
	lGTVFLqEyDCE1A8mqlzLjUrqj7j8jWLmQK7XjTiuRxT5Q+8itrXHZMew/QoNFTvH
	s284iBkWxEhFUtfUxUkzksf5vyCcAs1DGWRSBZZyN9XbNiJ/yc/rk7z0nawRIYxi
	ek+BoAKil7zs4+4pU/H57pdDYhh8kYeUnAC3WlDkNP3nBR7+ekgP0Kmlb0feTTw0
	JXGuzuAlabKR0Z+mktquhx/7qfHDcgMBugwgS9Xc92fZpMQfXmdg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49qdncah4e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:00:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59H6Ww2p025967;
	Fri, 17 Oct 2025 09:00:26 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010002.outbound.protection.outlook.com [52.101.46.2])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49qdpju07d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 17 Oct 2025 09:00:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JMlNUm4lIADQrCzDlcWilvreG6jIedwvcxCHBxWIPRTv2y3elLU38zXmy6ey3uGzb/tk+7s0gFCbcUbLebIFuSLGxyoUh+9eqXuzPQMf9tRAWHFSvieL4r6QohqUU3dxPFJvQNIe+xBZdsXVQUOBEmnU9bEA1E2ID1q80UCIQoL6Kb2OWcBbIJsSx0sLFyHhEuFquwAnhM5haUbum/KlcZNwMQX11d6JE8ZD0lmRXp1/6moq9zheCey7210IKEmGRr8UMK+j+RftRy6KGJHchKUEU8+0tmGnyPWx8xbQMEiOvga/hhQd6KLe1taKRdLDxkh3Tc7DbxVesKFY/keJSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KbCY97W87G2lEKThQVst1nRgGL3XdD7eCfrGoBwyeyo=;
 b=la6VZ3N5H2I/hGMDFh9osnRFz9rR2FAoLbeqFqnjB/ePxQE20sX2hnUDv6Pc/u1OQvLOlu8waheatchgjSh9E3we23d/Aoa8u2lGF3ACAOhMgdKIgsLC9J6WV8iVYXn0qf3KfE34bdPsqL3yAuYkX30hnaoRj/wfcq+pJCJCaBdXswFY9pvvjyBTM9fENvfnOrLP2DEOIUDpHC8ROvDy/cKsCmY4xn7hHVowj75wtkxzs7UWyYLO63wovZPjk061ad9bpc4zsmDL29bSN2Jo2Ol2D6GYwLRKWlUS/p4Socsei7HEXXa/ihoomPj6kAVoYtOvHrh3eBi7eGnAll5tQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KbCY97W87G2lEKThQVst1nRgGL3XdD7eCfrGoBwyeyo=;
 b=MS3YvpUoqI+7tmeH4k/aVIb9ky9V4EmVMjRErwnDgEF4xSv96MImzwjpcV1Wv815edp1O7QVQw4pSUblilEqY+RyqlDT7HV57xT5cZzo0YuwTDqQG6gFJzyOlcWHs0fy5cg3cDd0Erhy7C2epUuZPzbQocQwly/I2zZE2kx22ZY=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS4PPF3B1F60C81.namprd10.prod.outlook.com (2603:10b6:f:fc00::d17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 09:00:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9228.011; Fri, 17 Oct 2025
 09:00:22 +0000
Date: Fri, 17 Oct 2025 10:00:20 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Hugh Dickins <hughd@google.com>
Cc: Kalesh Singh <kaleshsingh@google.com>, akpm@linux-foundation.org,
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
Message-ID: <098b030b-9d5a-4b1c-ab44-55bad474e70f@lucifer.local>
References: <20251013235259.589015-1-kaleshsingh@google.com>
 <20251013235259.589015-2-kaleshsingh@google.com>
 <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <144f3ee6-1a5f-57fc-d5f8-5ce54a3ac139@google.com>
X-ClientProxiedBy: LO4P265CA0272.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:37a::12) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS4PPF3B1F60C81:EE_
X-MS-Office365-Filtering-Correlation-Id: a4c0d4d3-835c-4a70-953d-08de0d5b9b00
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1byi+RaGRGwyLcbzaOpqWYtYiT4sznK/vcOwlABKkLaVX4NVkMMDFTziAfCl?=
 =?us-ascii?Q?nS3ca1gL0vwYOjJJoOP0KEgZWVYXNNWgonNn5HT4Y99cDAwfEPyBXzxR/pAA?=
 =?us-ascii?Q?HJUj/KwK1gZ/D3teErQ99iaRJtJKD7z9XaMxuGkHy6is0lZ65rH13NzVjJq/?=
 =?us-ascii?Q?o0pzkvRRvNwd82s1e1S+ML5HgjQq3JrTjQgTnWQPgcWYfe+oNOnPmcnduBZU?=
 =?us-ascii?Q?S70tZwZb1Mx8W/HA2N/7kBp7tEgDm5Xlh/gv8So7B8bKR9Aom2v7Mh+QAj6J?=
 =?us-ascii?Q?x8vXvGvaVRXN/tg3Y8plJqo32G7jxwvzGXHGEeXnwtweY4+ta7007ewBvBVl?=
 =?us-ascii?Q?WlHKn910pIh8CBlOtcQ5hu7TOuxVGC0uHmW9NvaOdP5LfZuLRTxmO7QnCcP2?=
 =?us-ascii?Q?n3RKgeWBHck811gFHrqSsL/6w0lPHSeFrJpCoiqBiiUi7D6ziJbxhyTWQ5Ip?=
 =?us-ascii?Q?pFpFZmOkY4ALhRwNBFZav8Wu1e3LHoOCCYXTfb+ZqCczHnCUUK5Yn7W0iTE2?=
 =?us-ascii?Q?tA7CwYlXKAb9aXxEbFSQyjLpRXnWPG6x26RYrW1PYC61yu02Se1AjL+vdL4M?=
 =?us-ascii?Q?q9iNfruw3+fH9ohyDU1yPJ7ptyO0UanY3wCrgMYYepVcVMq6nm2Ta+gvRMOc?=
 =?us-ascii?Q?tOf5c5kaiLSBnjRXmVlk/URri/1Wav0AnxLBRebZllNYHU9o1bWJ2X4DjpJ1?=
 =?us-ascii?Q?dxiQ1Oeo7RPhZg09b+GruTdl1d4+3eh1NMDYbER6fjjSBQoJBxfv2IetIru4?=
 =?us-ascii?Q?3Vi0BZf6KF6j7NHMuZ6d7rlmdUevEoyXQDm5nJhqMHyg3/Tan6IG+vToWPbi?=
 =?us-ascii?Q?KhDfYb5Y/n0eRQ8yhyYzzCMRnMOObNhej0TZRxjTy0+d6bAeVkH4UJjHGj0s?=
 =?us-ascii?Q?GaUFByV3fads2e/nR/Ndpy6CwVf+v+5K41jrifXCYomTpykFjdUI16Ih06Go?=
 =?us-ascii?Q?Xj9ttIy/JYEX6PiA4eqgpo8sEEVa7Nh5JeHBUQrcKP4eX/r88bl67QO7KHPQ?=
 =?us-ascii?Q?PdMSf4crm2lnL6IRFVasfXJ4KdOdrxCb2ueA7+nJTp+5WUn6yThldgsWakxK?=
 =?us-ascii?Q?giu/rocGH7DjaNwlZR9v5rQLf9YFC6sO47jujgKZSAUOgjlUsWaob3u8Mwta?=
 =?us-ascii?Q?uh8jl+1n3hLTFbPfgZf4DzY4T+9h55GH8MNirZ7M3i1yEyxvgnYEhb7PeDWI?=
 =?us-ascii?Q?FF34OS6Fb2ts1XteDdcSfdeXPiSxSDVKKtapzWuCTXSLUvo10becxTg0QEHc?=
 =?us-ascii?Q?3ynMtJwg86Zx9Q80ZV48TE9yilXsaAlwR08Xt5WMTQpJKf9IcaPjEHNhUodj?=
 =?us-ascii?Q?uh1zgrxriyqDzPW/xjk+b04C5OalUml7xyRYEUlMheSPiX+pzqHNBC0YXGmZ?=
 =?us-ascii?Q?Ziuh527tHJOd/Xlr57RRYUsSzJtP1hwRnRkVlYHZ5R+tbLCAhSc0uQwTev6d?=
 =?us-ascii?Q?seJ7LFLNH/YirOd3R26OsoAMAeHVQ/FT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wK8snhsK2yB1EKw/RXiRRFmcUGsbgOV7JVQDbx/d2wdEMXKTy29t0++JZ7W8?=
 =?us-ascii?Q?j8AVL0jWV2RYe8t3g95mWakzMMOc7c2KN+rjH19zUjCWvprCgNaXSFeRfC98?=
 =?us-ascii?Q?UIL9b467T+UkxtqmIB/U7TnWT+rhlUsy5mpPzKDJNeS7TqgvoX0a/DAPjVVD?=
 =?us-ascii?Q?Kchc5gAP0pSWkTEqoPEVv4EYVYeuOGl8T2OBwSvAZZbZ0AH2n2I3eAT/Lq9S?=
 =?us-ascii?Q?H/Im/twMVm0OJ+uTcj9/Z2MNcYFhf+pjaxr4dYCQ6XbSR6vcrnMtiIR5Km65?=
 =?us-ascii?Q?uohcaNeWfuVsHOwUigeqsFfEo7e6O73vdL1RfgFU7sMB9cp7ldR6I2mxlbvO?=
 =?us-ascii?Q?uMAYp5DT4rP7XP4zPmxA484icS8vwkNA33NOiYxmySXAYTVO/IYJGbZrxAIS?=
 =?us-ascii?Q?j02EvdY1dk4PU7IlyC6ax0PxbpbDbuKq0579nmwFZmXkLgKqF5ooU9BkijJv?=
 =?us-ascii?Q?tSFroMmE1IgP/jw3ckIxu0SULJViTCIYGqS6/RO9I/6OCxbC8EcVxfT8aIWH?=
 =?us-ascii?Q?keoqMpi8J1dJUQOT7bkAlotY1/xqrbweiILFMfF4t3cgSffDFALxkBNSBy1E?=
 =?us-ascii?Q?FbjuR07f8LHAW2X8E/Qp16efzfmEaG4qMOHdO6jGmRd7rmVdvAo+8n0dfYU/?=
 =?us-ascii?Q?Q4OfpYHCEmhTMqrHa8W8/MWI8VdvbLTbRJA9GVqTzbghtOzXUgzKZlsPmi+7?=
 =?us-ascii?Q?jjAp9Jm3UtykeyOizHrBDzyoANkFO1XSYkIABiRroQuxhbQo08cw7O/p62SO?=
 =?us-ascii?Q?E/cLKXkXOoTbtg9vj8dOp9qYxfDep5XoQ9/JDlsIbHAUby8sUzenr8YWO4gl?=
 =?us-ascii?Q?uUsg/b3tZzUSE+JGfK9pyJ17lkYscrBVQ0V4jSp3RKNAPdCsG7QfA+CiZVsg?=
 =?us-ascii?Q?ZrgfZLOKjfzM/hZ0dLbhWEbe8N4XC8Q2jUkmdsF6RR7zJ1L4B0nMdk3EJlwi?=
 =?us-ascii?Q?mNoVye3yXS4W0ven6MMIz4lt5WnXzk+jQknKjGY7LgmPdMwN/8P/j1x8by7o?=
 =?us-ascii?Q?p8sdskJS6C8g6HSAWxxvjYmZBczvsJJ77h2hwPYxmvSXk7MrTVmd9lx7UtDF?=
 =?us-ascii?Q?we5kDA2VX8KlGKdzpzSiYOUlidSOWHswacplWOzyNybPQ0vCz6EswuQGRThU?=
 =?us-ascii?Q?N0nZALn+2lX84Z4t6h9zASUlyRiPCY4kyfko9xVmiKKnn1QhncSs58gpD2xH?=
 =?us-ascii?Q?ximLbF2GEsX4wlRspiHNqN1TFfpc3znkWMzjp2GH8n8MuUGBwnXQwT6WWiGe?=
 =?us-ascii?Q?8PFHrxV9Z3DCjPkQJR7Xx1fTzwxtkZFYuO/TmOy3yMhPDV79iYhog/5JU1aa?=
 =?us-ascii?Q?Jir32vgvr1NuNwMAUOszx6SRDh+HG/bArvT2bfwiMhXYBpL08KEjlMhi3f+Z?=
 =?us-ascii?Q?/ErR6bAVcD2L9kIWV7AAYRVxXOrE3bR4Qnbd1jLuqrVSeAnT6HMOVINfONkm?=
 =?us-ascii?Q?aRJUspxGm/WVRf6bV188gWdbjORl19htx5H9FGtwOHzV0wMl2ZdgZcmk8zX9?=
 =?us-ascii?Q?mSWilBOpHU5zlhr9/61g2SNYko5aPNe7UqwDF0ba4rHR6190ltDTHLlyZ8v1?=
 =?us-ascii?Q?novF4pe/k5g0cYWs+Glw2u6bvBDIAFTYnJiFIHYAiCqlVzdYunIZskGvtxzJ?=
 =?us-ascii?Q?LA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KRiSGvxcWPJ6lNgo7J3vGs/IwpxrUpXkl7o3dZDnZFu0619XlxsnOny4y4y/eSXp+9OtsFQnS2nMvQPBLL7hIpyZyfl9ZM33pk+JKV7XSJEqc/7O7NHwJOs6viTdtCnDm1d7kXtdKGllrOO69vrUgwkthBKUhd6wj3+uTUIzRVHAVWjUQPHcWFpGo/8+cHImmG4dteSC3YOz+OCcyg9/VcOBL50MV3/iEj02KI1vkiUEXrPaj0/snilqw4X4zZAVe1jR7Zin04RwcdU8EFpO97EPv+10DU3Yn15d2Rkyjv89G7d5/28+/4Pm+Hl9/zhq5f+JkW59glR1LdSTfWuhO+aX+IXHzYYP9BRNfdVIZjlVBr06kXsgbQ+2cq6GvhIGzJ38tMd5vGOwaCpJoK+3qH0sJISRGXvi4FYkZH2CVv3cCX+tZOqsTl4CTKqr/8i3VEhnGatSU3Rsf2TnXAyt/ROD8YY9gRkcUt+h30VoajpPOvjqQbd3d3YMO4BjxhKkkAjUJpYjTGwKFYp0qJeO0r1QkDLEO0OtFib8hfg8SQzwuqsRykmemD24hr3EohxSdzB0ODoN2+qiNjJpYKCiuAa7eA8DGYDTnNnyz49ydfk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4c0d4d3-835c-4a70-953d-08de0d5b9b00
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 09:00:22.7672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mYBQLPdACpEEAaQuhLE8/PFa2Xz9a7LPvJolYfNDuCf7xSWm8lSzjEUfY6pJCB9mEDy6Mpos9VUqxhZZPWRuEJg/2ANTVbOeVCOua+3Eick=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PPF3B1F60C81
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-17_03,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 mlxscore=0 spamscore=0 suspectscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510020000 definitions=main-2510170066
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNiBTYWx0ZWRfX9F1llmOjGo9v
 WtObXC0Gz507GLf483rA2o3KL/RsK8PL3Qq2Yj+iTdQTf/aoUrFOMDL5vyUFE6W4swAcd6mvoN/
 +E69uW+VEBsuFnOG1UkZR2BQyMy/BuTtWhvZaa5E6O6qURwI+kugIQYJMIaP7vp2ZEIUx+YPspY
 Ohrk9M9yhxPNkcy1pkwTKdHolh0B0oWBnrxOAxqBCXXgYpWmxA07ZB+zTl82Hu6kR+elBRBfOLo
 Nk1COnUrHbaW2bOW1NYlR3+F17pijtjwU2OkrDDpV82g5C7PdymrbUYT2yh6h1rfMLLfSNJGgoh
 rJEiztsWyFF0TYqH62dD6bvZ1yQUFFpbK1OnIZmqrhirG5GlfQZcSoyEukk61+L0UCI4VR/o9B1
 tMHldjJc+i6pejfyxPquba9UwVsU5j9l6RLykyyspxH8BQlSV6o=
X-Proofpoint-GUID: MlOWhF07ViXwl4l00E3AxCJNQHmRwkgg
X-Authority-Analysis: v=2.4 cv=ReCdyltv c=1 sm=1 tr=0 ts=68f205ab b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8 a=yPCof4ZbAAAA:8
 a=1XWaLZrsAAAA:8 a=XRCz9ig3qRNXVpmZX3MA:9 a=CjuIK1q_8ugA:10
 a=HkZW87K1Qel5hWWM3VKY:22 cc=ntf awl=host:12091
X-Proofpoint-ORIG-GUID: MlOWhF07ViXwl4l00E3AxCJNQHmRwkgg

On Mon, Oct 13, 2025 at 11:28:16PM -0700, Hugh Dickins wrote:
> On Mon, 13 Oct 2025, Kalesh Singh wrote:
>
> > The VMA count limit check in do_mmap() and do_brk_flags() uses a
> > strict inequality (>), which allows a process's VMA count to exceed
> > the configured sysctl_max_map_count limit by one.
> >
> > A process with mm->map_count == sysctl_max_map_count will incorrectly
> > pass this check and then exceed the limit upon allocation of a new VMA
> > when its map_count is incremented.
> >
> > Other VMA allocation paths, such as split_vma(), already use the
> > correct, inclusive (>=) comparison.
> >
> > Fix this bug by changing the comparison to be inclusive in do_mmap()
> > and do_brk_flags(), bringing them in line with the correct behavior
> > of other allocation paths.
> >
> > Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> > Cc: <stable@vger.kernel.org>
> > Cc: Andrew Morton <akpm@linux-foundation.org>
> > Cc: David Hildenbrand <david@redhat.com>
> > Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> > Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Cc: Mike Rapoport <rppt@kernel.org>
> > Cc: Minchan Kim <minchan@kernel.org>
> > Cc: Pedro Falcato <pfalcato@suse.de>
> > Reviewed-by: David Hildenbrand <david@redhat.com>
> > Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > Reviewed-by: Pedro Falcato <pfalcato@suse.de>
> > Acked-by: SeongJae Park <sj@kernel.org>
> > Signed-off-by: Kalesh Singh <kaleshsingh@google.com>
> > ---
> >
> > Changes in v3:
> >  - Collect Reviewed-by and Acked-by tags.
> >
> > Changes in v2:
> >  - Fix mmap check, per Pedro
> >
> >  mm/mmap.c | 2 +-
> >  mm/vma.c  | 2 +-
> >  2 files changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/mm/mmap.c b/mm/mmap.c
> > index 644f02071a41..da2cbdc0f87b 100644
> > --- a/mm/mmap.c
> > +++ b/mm/mmap.c
> > @@ -374,7 +374,7 @@ unsigned long do_mmap(struct file *file, unsigned long addr,
> >  		return -EOVERFLOW;
> >
> >  	/* Too many mappings? */
> > -	if (mm->map_count > sysctl_max_map_count)
> > +	if (mm->map_count >= sysctl_max_map_count)
> >  		return -ENOMEM;
> >
> >  	/*
> > diff --git a/mm/vma.c b/mm/vma.c
> > index a2e1ae954662..fba68f13e628 100644
> > --- a/mm/vma.c
> > +++ b/mm/vma.c
> > @@ -2797,7 +2797,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
> >  	if (!may_expand_vm(mm, vm_flags, len >> PAGE_SHIFT))
> >  		return -ENOMEM;
> >
> > -	if (mm->map_count > sysctl_max_map_count)
> > +	if (mm->map_count >= sysctl_max_map_count)
> >  		return -ENOMEM;
> >
> >  	if (security_vm_enough_memory_mm(mm, len >> PAGE_SHIFT))
> > --
> > 2.51.0.760.g7b8bcc2412-goog
>
> Sorry for letting you go so far before speaking up (I had to test what
> I believed to be true, and had hoped that meanwhile one of your many
> illustrious reviewers would say so first, but no): it's a NAK from me.
>
> These are not off-by-ones: at the point of these checks, it is not
> known whether an additional map/vma will have to be added, or the
> addition will be merged into an existing map/vma.  So the checks
> err on the lenient side, letting you get perhaps one more than the
> sysctl said, but not allowing any more than that.
>
> Which is all that matters, isn't it? Limiting unrestrained growth.
>
> In this patch you're proposing to change it from erring on the
> lenient side to erring on the strict side - prohibiting merges
> at the limit which have been allowed for many years.
>
> Whatever one thinks about the merits of erring on the lenient versus
> erring on the strict side, I see no reason to make this change now,
> and most certainly not with a Fixes Cc: stable. There is no danger
> in the current behaviour; there is danger in prohibiting what was
> allowed before.

Thanks for highlighting this, but this is something that people just 'had
to know'. If so many maintainers are unaware that this is a requirement,
this is a sign that this is very unclear.

So as I said to Kalesh elsewhere, this is something we really do need to
comment very clearly.

Or perhaps have as a helper function to _very explicitly_ show that we're
making this allowance.

I do agree we should err on the side of caution, though if you're at a
point where you're _about_ to hit the map count limit you're already
screwed really.

But for the sake of avoiding breaking people who are doing crazy things (or
perhaps I'm not imaginative enough here :) yes let's leave it as is.

But I really _do not_ want to see this global exported so, I think an
appropriate helper function or use of the newly introduced one with a
comment are vital.

>
> As to the remainder of your series: I have to commend you for doing
> a thorough and well-presented job, but I cannot myself see the point in
> changing 21 files for what almost amounts to a max_map_count subsystem.
> I call it misdirected effort, not at all to my taste, which prefers the
> straightforward checks already there; but accept that my taste may be
> out of fashion, so won't stand in the way if others think it worthwhile.

I disagree very much, I see value here.

Avoiding referencing an ugly global is a big win in itself, but
self-documenting code has huge value.

In general mm has had a habit of hiding information as to how things work
for a long time (when writing the book I really had to decode a _lot_ of
this kind of thing).

I think it's time we moved away from this, and tried to make the code as
clear as possible.

>
> Hugh

Cheers, Lorenzo

