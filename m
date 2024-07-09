Return-Path: <linux-fsdevel+bounces-23388-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9971A92BAAA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 15:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 051E3B28E1F
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Jul 2024 13:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5F15E5C0;
	Tue,  9 Jul 2024 13:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JdASX8bi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kjUry5I3"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A2727713;
	Tue,  9 Jul 2024 13:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720530499; cv=fail; b=jNjjd1bYu06L09FuAfPRpYyW6dBHjL9Qo3pwYVHCoBXYv2JJBbm1FIfFUgcdk1NzPj9tQpxVCblwWNOJtF+MyBa8lsuFj9J7NOAa5UaAPfzmnbV6jyDKtBIoIFST6Jq3nvktF/OttppBn0VFqPpLKzHMZQh7iYhlLIjbHp/6v+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720530499; c=relaxed/simple;
	bh=kPEWE8oHj7DIirbDMU0RGmogSc4IfuUMeC25uIRO6Y4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=DRXlpQaRLEGm6Qu0akOVTfvvpKW49o7w/leyhS6KbAvLJOL226soUbH96BuygLDSo77QZ4A/SkdL4HRUqkcAV2LxnMfJ9z6heqr3Ypsjiw/vwGQ3sU00JQob/2lDf4ja1M0GMxd3yNQdTHG3DQjpJNrkIcum/WIfucwRrb441CQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JdASX8bi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kjUry5I3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469CT33P000824;
	Tue, 9 Jul 2024 13:07:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	date:from:to:cc:subject:message-id:references:content-type
	:in-reply-to:mime-version; s=corp-2023-11-20; bh=4Ev30IA+xtFxR4L
	HzBo0s+kAxvV8AyGQj6eu9k85SAc=; b=JdASX8biaDIjEdvfH1Cn15bgacGjSdb
	UBfhcPwCJCXat0nUlEULeEy1X1XhcMjAd2SUjDTMK84f3FwznY/wS9f8Xct7bMBN
	/ee5WOmn6kb0HGbdS6aGRGeK0bBOZ0TmtS9wGfMcX0eJ5sUKIoWsGGPj/3N7L9/f
	lj1rlysd0oB4Gok+ScI/CP1lkzWxwXJai3l11Z52wAiXjlQGqB/rJnIKmnILG3qB
	PcN8IP99zrgAqgPJVTA8K5xtnQHnv74C547JCzFPoEdO4D/SL/1mJSZZtan8sb+n
	GvnKW1FDnbH8tutYlLRUuGmW7ksXguVrJuP1DdiRroG1TLn8TV4pw7Q==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 406wkccu63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:07:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 469C7uL1027500;
	Tue, 9 Jul 2024 13:07:43 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2173.outbound.protection.outlook.com [104.47.55.173])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 407tttmuv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 09 Jul 2024 13:07:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfETUIJLNnJmBfsZLArdML0Xv4d44FDxvBk3d56L7qICCdK40G0MDhfkbWFqUrDLPEng470GexxvuXr7gb7gtU5rJBq68z8NVD7rh/lwucfoVIE+hH1egY4+LK0hD5Hi739BRq5uEsZvoQxqahAKXvDAn/FUWeM98sy9IuY3d79eQ+HGiu27+sdNmgVi6pR3E9u8jJ6VYS301TWCJB3nBBtbfnrDwhvXpufn/zTg3NvecEnn5SVkGf0TWTUUdUrM9ZeKE5FBr4U6P5vkKtx+CzacFSKWlUsj+7ttTpjBfDBFey3h6SwjHU+XVXXbxsZdRhepehu3WlUnU1FA+3cFHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Ev30IA+xtFxR4LHzBo0s+kAxvV8AyGQj6eu9k85SAc=;
 b=gY/2kwLseP7lD7Nin/11SWQd/kiWayBIjNhUOPnXTSmx/GFc9dnvhyNSQnIn0ryVxEM7qtom6l0yRVKrUK7hiwxKtVlrivbl6ptZZLt8W/BXU5g9bbcmrtmmwTXi+C8/elNiJ0pR9Mzl81GX9Z+oYHYCOShFzvs93AGhxyBWsHCw/01TZqHWeYcOyJUhb+S+6F4UXsgKU4f2elQVUyEhcu/bk4Epwz8NSB23BasROuAwikPQzG4IvWNq+nJpU8P3C66D2n+U3W6yUaP3HZhmvD/H3mo7MQbX+TsmJInXMlZsY91HJRrG4dZD6uGnSRZ4QsNrsYCPyeHjEuVVRuUAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Ev30IA+xtFxR4LHzBo0s+kAxvV8AyGQj6eu9k85SAc=;
 b=kjUry5I38s/ASrbGL4TdRW41vtriXZ8n12b6E8QBNp3pyE0TrGR+dbxNNu33I1St4/k6rMD/V5PisWVub+7osWr0r8jGmldbC3WYkyZ+XWaC8mb27VHbdot/mSHy5j0KA3NtVl/fNnfmwci2gFdHfDTpJby6v1Nx6ZWoKdlVaw8=
Received: from DS0PR10MB7933.namprd10.prod.outlook.com (2603:10b6:8:1b8::15)
 by BY5PR10MB4244.namprd10.prod.outlook.com (2603:10b6:a03:207::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35; Tue, 9 Jul
 2024 13:07:40 +0000
Received: from DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490]) by DS0PR10MB7933.namprd10.prod.outlook.com
 ([fe80::2561:85b0:ae8f:9490%3]) with mapi id 15.20.7741.033; Tue, 9 Jul 2024
 13:07:40 +0000
Date: Tue, 9 Jul 2024 09:07:36 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        Brendan Higgins <brendanhiggins@google.com>,
        David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
Subject: Re: [PATCH v2 1/7] userfaultfd: move core VMA manipulation logic to
 mm/userfaultfd.c
Message-ID: <4v3i2dkez33twngywzvosnc3vwlgxynktqceno3izup4mp46hd@nf6ebzbddnwx>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, SeongJae Park <sj@kernel.org>, Shuah Khan <shuah@kernel.org>, 
	Brendan Higgins <brendanhiggins@google.com>, David Gow <davidgow@google.com>, Rae Moar <rmoar@google.com>
References: <cover.1720121068.git.lorenzo.stoakes@oracle.com>
 <76a0f9c7191544ad9ccd5c156d8c524cde67a894.1720121068.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <76a0f9c7191544ad9ccd5c156d8c524cde67a894.1720121068.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20231103
X-ClientProxiedBy: CH2PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:610:20::32) To DS0PR10MB7933.namprd10.prod.outlook.com
 (2603:10b6:8:1b8::15)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB7933:EE_|BY5PR10MB4244:EE_
X-MS-Office365-Filtering-Correlation-Id: 760ac0e9-55da-4722-0e23-08dca0181cc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?VrNlHlKZtv8t1PeU0QTwrHKYdyIlueVj12jXMDnDZpk23nL5/Xa68/lLOuRy?=
 =?us-ascii?Q?6N91DYTJkj3sr3yJ4pTycVOh/lUud8wGFHYpXBE6CV/EtxVrGMD8akX79CWT?=
 =?us-ascii?Q?x/hI2/FQIVPPrkApE5vGDBkJSsglMHr6RNv0pBkvzeMJtGd0Mtk/sgQf6E1C?=
 =?us-ascii?Q?B6JkoAQgtZMxhswu/jSEbn9VDBh54dgGCcgkH9iYm0+SVDCP5oxLQEkYpVx0?=
 =?us-ascii?Q?+XhAP6uoi37evlNenllRz5XXjxcgmRfOaoCXpSFwPypfO1uQyL/2jHRxVKDr?=
 =?us-ascii?Q?TCKXLfWCpe9JJ/+DMdBxsB8iSWd20XesNGqaWHj08NldyOe1J8A0TlxBgcGT?=
 =?us-ascii?Q?kbKJfBelKhUPAmCdAoNTOFWUforwUU0HRZE3CTbjQqxWHGeYAejWRf9dIvep?=
 =?us-ascii?Q?2gROCHaPXs6wjeRZ5LGczDR3Xr71ABcWBgCxuiHc3jSAv6576+HP3ovG2uAb?=
 =?us-ascii?Q?tD91AC4h0zJffeMcpkcUOox+PlsgIg7nOb5JZyAPTtNIu6QZelYFrCgVVAfB?=
 =?us-ascii?Q?UCCMXrQ3uB0DQAU95H3VUfZet8xKRaLUAJ5x4GJQEw6tyjuyJ1u3aeGhdliJ?=
 =?us-ascii?Q?mKL9GQmHY9zm7mESQXwjZZZv7s07V6aatxE4jXLdPFaVoavwWg6QA2R3/B6f?=
 =?us-ascii?Q?Mw+cs6yT7gPY3IbnpSTsW+n5GJDt93rM1m9SpcfMPeW62NrgNa65XYsYZR+7?=
 =?us-ascii?Q?UYMeMUoIQiRDEj1DN9u/CXgvfg8dQlJewfC9WtJkh6rBCZTbpHIHTg9c7041?=
 =?us-ascii?Q?udoyErMTEox5K1bHDWFYxRJfwITcRM/2yX9LOm3/5Uh5fd1INQHBJyrNM4Ne?=
 =?us-ascii?Q?ng07jXJsNuO6CEpQwoYeJeX5KY+51ZfdzIGyVdbT6m8bA8S/PPYj0A1ynmdW?=
 =?us-ascii?Q?cZu3KUGSID0wowFzLhmnieVHOTvCKeIFZRLU8R7zy0tL2oBxL1Iskpsn05UA?=
 =?us-ascii?Q?JUFH/3zYwSzahKl/epS+UTbxQ6J68PT/5NcWiqo3ud9DodGGjDVM6m35omuc?=
 =?us-ascii?Q?7gHvgOGFVuJsfrmzPvWzcyziSO0rcxv0A90qy8zM5kByZ7egK6/wVH5KPs6y?=
 =?us-ascii?Q?TuROwu7Es4SWxMiIK5JgC8CFHKl2+HseEKclXG84UhvgS2F0ca9G0ScvP68o?=
 =?us-ascii?Q?sGp/NiezzyVapVAS8FaaOVQSWtXyTZLUy61/g9amJidzHjUaPC6WyvY0oI6t?=
 =?us-ascii?Q?MIfRbcvM8BzBktwh5cUEFKl63VbFfoClqc9d5+nOu9KRkCWn1AM3HwdlCXTF?=
 =?us-ascii?Q?BEm6cVvYVineUtNnb7kQ4HPxx/nwKIqqjkIT9vCpF2iwPNA6jAKGLObp1057?=
 =?us-ascii?Q?/lxQpCg8ixlBUd65/RHOFxlmz5Xhnix72q6jg6pmW92o+Q=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB7933.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?F1tGs9cTHlOVtuXQ3wyk4JmJ1T8JfrKumy4+bOEuVI8g/6zO8uwqhEHwT1lE?=
 =?us-ascii?Q?eGJaVpH2qGx0TI5QVbCrIjhWo1ioNk11eYyx6Yfb7Eq4I0zM4cZTmLnu/TUo?=
 =?us-ascii?Q?4z/dUxEd5uepyDit0RbUt5zaixvTZu0TJdEEK30jDG820ADZ4Yv0yDGdDTd+?=
 =?us-ascii?Q?lesFF2AlMWcXPEbag6G4wYvF8OSzIUL1TLZeSmPpfq7FMEgrYOuer72TybgL?=
 =?us-ascii?Q?5ynULLzgjUnuajPsLQiT2hL9zchfKhJH8fmD99oiOrbI6jJM+sLXQP+XqNZP?=
 =?us-ascii?Q?MLayH86DErO/h21sZ1QbASYVp6CftuiVqC4I9yQ95GBM6MkzGqXbA+HWBYeh?=
 =?us-ascii?Q?CyAgnFnGTUifhQrJfMD30ryR6IOAcNpOyh07qW4ufPN1JQtD/2ccy/Mh0K+z?=
 =?us-ascii?Q?g/JX0ua2klbJmiXuW98lEw66D09Uxukj59aZ7KxKl97yWIf7qAUdyWMuxC0e?=
 =?us-ascii?Q?UZWAEKBdWoGkvrHN1LjKsT3WJ1CrjdfxHgblOSuSGTEXKOQBkhRXfVqU7kgj?=
 =?us-ascii?Q?0i70HZWB1Pbt13fpgEzqpmuo78//JGxo+vA9sjyc1x+bp2Ngm53AFPkOUXZw?=
 =?us-ascii?Q?AhGqXC+IyWp5fZ9c+Wh2IgVnThWtl3V4mt/IOk5uOQnAC7NafvVtqhavGokV?=
 =?us-ascii?Q?QxIaNVPygp0Q7gTGtFKMt6RMocD9txYLI6aaSG+uvip5e6fGJGSIXzl86Tfa?=
 =?us-ascii?Q?p/x1lNkxl4Jbakx1HMj2wXaJrz9l1tfBJJPPD1FXKZPNIpZgaeKQsxUhwoif?=
 =?us-ascii?Q?o1AYGY4wQMQFKlJ1gFx0tXhumthsnpJdYuN6f1tdM1CisJULIPgFhaGpYwBc?=
 =?us-ascii?Q?wB76ozW9fv5jgXv5+hzn7+yyOcYWOLOZoG8rRDgpQISZp54rNa58718Pmjgu?=
 =?us-ascii?Q?+IIxbfFmnTEljk/W9a+5GrImF+ipVbjETggC2HgEOc379KTmjugw7/j09gI7?=
 =?us-ascii?Q?X9gViOHNi9ZP+N6bODy3MV75bD6kqvem9kQ4m6kv1XqyEeUxVgVWYmxdxokQ?=
 =?us-ascii?Q?oMQH5vqueD5NcM7ujVbPhxMwZhV+2gUOmYVm0Tw6DshmMlkDS0nq6FlZ3yo+?=
 =?us-ascii?Q?plreAMMypcpDqS/dlroE4NbyLcHnwGH2Nduf4n3oRLQKAsbkL7qdi/3ZS2pV?=
 =?us-ascii?Q?x0WC4493FHi8EhfbIdipa5kVCK8LeOSWxGAVF134dkpWA1M/aTSzshhJYXzI?=
 =?us-ascii?Q?5CLmMP203YqKEZBDKCEA3Y1R0shZdtKOjWhoKtejl7Vb/0zchl1jVVfOkwWU?=
 =?us-ascii?Q?XTbDLzsnh+jW2azckCK/060X0k1161uE9NrGAgpDgj0opsbVEHrSFq8KMB6T?=
 =?us-ascii?Q?tWJ25vrE27j3G3yvKRw1/gUmA0oEdQoV8BPn9909Wf4dYRyFQJWvxyKoxy+y?=
 =?us-ascii?Q?NhQvAdLemvBimYA0JhfBC4R/1brdyD8otucYXzphZ4REr+UqMzVuJqltzG3I?=
 =?us-ascii?Q?teXS95mqvwqW6aOd8cTwsU6pZZHp21/ssdDa24yuXK4al0lZ9njtIKFj8RQ8?=
 =?us-ascii?Q?U6KK9ISz3UZHfGpaJK0+0hvYugfxuf13nLUCpmA8Wjikr+ljoSAZjm5YQ0KT?=
 =?us-ascii?Q?qHFgarkasyX0bbn8avh6bWN0kZ/ilOGNT8Z0xWdn?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tPL//v08aaY2o8Pg2q04MwbFMoOMz2hYK0Q7UYzv46jp5if3aUUwqhQm7mHGX7uJfgrOO6FpZzYZ1zwfLKMXIArtAiy3uE+lQ3jEVU/m5N4L5QKreYdKof9rvQRWEWO6e4Vgj1VOEoasDRY+GhRPv1r7y0J0BNJ9VkVTGMpOS238OKujaJuXESweUkxvrOy62d42lYFfGz/AvfR7vqTVSlsMVnSs2e8vrOSBP5ANsjx/NBnn8aPthxPT/ZGbQjHlr7iHnQgX7BurQOpbWCpdRQaPsfr4Wz8AMPYqEFlBGXhPuchuQ7TbkHVfEt4NQa18H30n8/1zu2gDabYRtp4IOZLO6CR0lEYXaQhc7MwYw/v5W9ufLzXJVnZd++wjNh6J5os/ZW3kJKpDxlJXHx/h2TMZ/JBGJAgA1fk+SOoQ/w1Keu5j1uKk2MCdjV/FmBQJBHgRLrDd6g0+qOPEFY5d459DQg8YeTLq+fWmPb0453hx7DyHpwtHphlUFJi94raGPJPiot/nAP3ASgAwEFuhHubgRE8L+l5azhIrh80wxT8XdKS1RsHr4SV31NE5R3fyQoSDzIy2xYLYiu0oRWu/ii8cB0R8Wy6bzWCVlYlePg8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 760ac0e9-55da-4722-0e23-08dca0181cc3
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB7933.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2024 13:07:40.3664
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7SdM97aV+p9pN4yR2BKfFXD4S1fqZspU1Eg1uBSwpGebKkXprXpnClVyu0WzvXjpze2oytBZoCuswZyLc2ER8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4244
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_02,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 suspectscore=0
 malwarescore=0 spamscore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2406180000
 definitions=main-2407090083
X-Proofpoint-ORIG-GUID: XjkKjMjnWUq44mtrW2DqoK36f-T2-GCn
X-Proofpoint-GUID: XjkKjMjnWUq44mtrW2DqoK36f-T2-GCn

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [240704 15:28]:
> This patch forms part of a patch series intending to separate out VMA logic
> and render it testable from userspace, which requires that core
> manipulation functions be exposed in an mm/-internal header file.
> 
> In order to do this, we must abstract APIs we wish to test, in this
> instance functions which ultimately invoke vma_modify().
> 
> This patch therefore moves all logic which ultimately invokes vma_modify()
> to mm/userfaultfd.c, trying to transfer code at a functional granularity
> where possible.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

