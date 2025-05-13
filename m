Return-Path: <linux-fsdevel+bounces-48895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34A73AB55E9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 15:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 028D51B45C8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 May 2025 13:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7691928FA80;
	Tue, 13 May 2025 13:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pyOCc+qc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="c495IHvK"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2F22857EB;
	Tue, 13 May 2025 13:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747142610; cv=fail; b=frDl/sb2YKFkd/Zlpc7YxcUQbY4m/CDUc1snPWU4IFXlNeXoyPhMhJxUXvdFBmb0PQIe2D+wbCVwLmbQ8K7mQeB2lkX8w+hk0wKYAkhvUNhOLGOSzMTWfDsdQTGtFs6SS6BeNMRND8oZoWHQiUJtfLVjaWcLx34RfUaooIqd+Fw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747142610; c=relaxed/simple;
	bh=K/VXfgkLazmrbpDmShEThajXzFWAnz0g5oQmFT1/NtI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jh7UPGoJZik4wEIEleQzZfraZhKWhGnUIzEuVRtvIIcHzj8U6QQ0Fl9F9/NGA2ID1IdbVJWNzpdPAAW/E2GltdHv7H7ytA5F+w0Ye+Da3MH+380H4UKY9Qkuw0v6h04L4IPx9S1HjAStqBRaZTSpZmKmw73tEOHVXrPWp46H1XU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=pyOCc+qc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=c495IHvK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54DCHPQP026295;
	Tue, 13 May 2025 13:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=wDrhGxkEK3SxX2k0rj
	ctXeuDyvqCf7mQGUFS+9ScLoc=; b=pyOCc+qce7Cz7XAk5rDMGgPewwKtIdQ4jD
	z6g4eI/Hq/6pcocpQ5VvotqSDKaK+snWhnSg085oCoHQm9aFZ0VolqlIbgWDaxMC
	qe8FrfZ34Fuokvykl3YkWennuPRzVt9C3bnnsEGRCB2/gd/9vmHt+mhz83qg2vqf
	L6k1lICt/bZJgiIejLfaRvG/eXo2Bqaf2vhIZ0qaglDIcgsI23kLIDWsJISIboRi
	i2XdvKHDiNObuMBUBOwihx6BrqMa9CBYewV5WwlCFrBfTFDzC+G2GiKpJlCe6IYq
	9fj3w63nldeCuf/3dXUENaLpT6GnYZDXvRw02QC8SkJo6fZQaaTA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46j0epmpu2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:23:09 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54DChuEt002426;
	Tue, 13 May 2025 13:23:08 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2046.outbound.protection.outlook.com [104.47.70.46])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 46jwx4a99d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 13:23:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U/9sC3bnffAsHamwoCoM6Q/f7dkKr/ICICqc3zBECop0LbTIgCLLTtt9Ncfdtt73+P0mECizM02zzvjCjGDW9AiuY1xglykq3ETdIB+mnscZiWqe7lQ/JhlqTQ7JRI4x2ntMUUuTE6b47NXsv9OxoSPev0np8aWWY3Q4GK2949rPZ2Awkp3F7MzqfeeVQsCOHIKG/Z5bQsUkMUFlP2f+nSm7X+yYgZLiRpFza/OL6jP7Y/iw7afKzMAXwCFgjplChrCsVMozcwxmFrJOFB0ZYB0xh0cTS63ryJNAiOuH2/YbS9esUDDQhw99YefTa1T6oogIoVX6/bEUUCTV4vdB8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDrhGxkEK3SxX2k0rjctXeuDyvqCf7mQGUFS+9ScLoc=;
 b=EjERXJMmdXym622nkuwLs+ug/nATBC01vvzgy3sWGxmzRUjjV8HoDinUbdBzClUdy3a1Hup/Z/PYwV72ssXxooi2w5vfBqsev/v2HCOKSa51MJfzAmS94T5C+u9C12Shp19I04haLEdqIRl5tURfj3Q6gT9UtSr10DpqniDR2bpXOTMapTVzDzzXM+MP7XNRFjeSYdYZ7VQx2Wx5X/0DYo/1wL4UVy/1/XuVUzGO2lmAgI3eh0m3tNiCA1CoLubP3VX9/fwumZ5vwc1n2zhddl0tAqnIjdKQzeaKmUX3chMiE7oiJbZQqfJ7coN9lCrMKaH3PNX2Ow9cGwtXn9Kd4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDrhGxkEK3SxX2k0rjctXeuDyvqCf7mQGUFS+9ScLoc=;
 b=c495IHvKKomXvaiDrFjkTJgcgZHOvSlNncRIVuHbo4YzUgkXqSisyGAqlgYBEyDFzx9mafm3oUG96UtQrkKaiPCtf/4BxvvZxaZz1k6ahVCA+FGiI55309vLb3sEms2C2NEAKyxzLXYnKfIyYRMmOm8G18z75ELWr67d2PYoNbQ=
Received: from PH0PR10MB5777.namprd10.prod.outlook.com (2603:10b6:510:128::16)
 by MN2PR10MB4207.namprd10.prod.outlook.com (2603:10b6:208:198::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 13:23:05 +0000
Received: from PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c]) by PH0PR10MB5777.namprd10.prod.outlook.com
 ([fe80::75a8:21cc:f343:f68c%6]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 13:23:05 +0000
Date: Tue, 13 May 2025 09:23:01 -0400
From: "Liam R. Howlett" <Liam.Howlett@oracle.com>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v2 2/3] mm: secretmem: convert to .mmap_prepare() hook
Message-ID: <lbykhkt4sjfb2l4mexgnzq7zumauvi5ycxua666ixvxns4w3qp@pgbo2krrtu2d>
Mail-Followup-To: "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@redhat.com>, Vlastimil Babka <vbabka@suse.cz>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Matthew Wilcox <willy@infradead.org>
References: <cover.1746792520.git.lorenzo.stoakes@oracle.com>
 <0f758474fa6a30197bdf25ba62f898a69d84eef3.1746792520.git.lorenzo.stoakes@oracle.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f758474fa6a30197bdf25ba62f898a69d84eef3.1746792520.git.lorenzo.stoakes@oracle.com>
User-Agent: NeoMutt/20240425
X-ClientProxiedBy: YT4PR01CA0008.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:d1::16) To PH0PR10MB5777.namprd10.prod.outlook.com
 (2603:10b6:510:128::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB5777:EE_|MN2PR10MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: 03f84731-28f4-4af5-b6c6-08dd92214b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1dVMdISlkUYQj7C5LObYE+UiY8sm/HdtRZg9tYm57V/AltxVyQJeTjOMGOag?=
 =?us-ascii?Q?Ylkg04VHdVtTGMYbMhjWvmXqN10eiKbTvcCRlOOISbe6X0PJBtqJcUO9AvXU?=
 =?us-ascii?Q?9vpQ+6VvLWWoWDfcKtx+ExvWD6SpiFvMmLIcLgbUIhhjFv8PHLLmhgb//fcA?=
 =?us-ascii?Q?R5HbmJWgDLOUwQLhLeMr6vZBGGuc0+vBxwkGgB8keWKCuQndwA8FKIEdeXAz?=
 =?us-ascii?Q?O33uvW3CFzzJEgHntFqD+rEghcaVmfyj8RbwLLEcaoHDSGrEO4XK5kkd5qw0?=
 =?us-ascii?Q?l23ZTED/eRWLE1jnRHz9U7ZeX9De/B6VSCfM/09xiKUe75f5qTkXtbLpN+jQ?=
 =?us-ascii?Q?Jom7jUjjrZg58QaQvjGW1HGzb6/MsNdLk65bIhTUuQaTGqAmM9VaqkBUeXPG?=
 =?us-ascii?Q?z3yrIGzfxBY+Fqrhkl3VTGAqfYJVHU94fX8vW4Tvh/tFvXf7+wswLifWaQBD?=
 =?us-ascii?Q?6n5ZtV94sUHMqrlLgsVdOPtfLwcrZeUmh8pNyF19EK67fVU0O7xPdZA7mvye?=
 =?us-ascii?Q?WMg0PLBClVxyvXCOjxaD+MI/ngayK+QNpFF0y1yg53PwiWCp9037qQfwKwzV?=
 =?us-ascii?Q?P1clh/DsPyYdLdjRY4k7PCCCo4AW6PmX3LfJR+HgDU4Jlv9gP29V0MzkR9s6?=
 =?us-ascii?Q?h3ovqHQ8oVJuwmxujnyhq2TAlvBS1MO6pKdMJa0PJrp75lZTTWATg+ojxqId?=
 =?us-ascii?Q?983NxntHbJEFWLc51YxbsGJBvXFYPFgA2VTiNf6KP7qK3y3OdEfC3w8fmm+2?=
 =?us-ascii?Q?k6uNx5OERXRWqrMDRoobJ2SNZCpxGS0Bp6ScvU71s2L1JwblFRHBxW4ShfZt?=
 =?us-ascii?Q?DAFsLTX48jSNBp1FkTlVSUmTUiIm/QT/vmW4U4eSEJ2G2U+ncJpFb2DMRbJN?=
 =?us-ascii?Q?6PsV5Xa28KZT9xS+maTmi4YGtxFVQyTbEgHroHCNvW3MMZZG6/1Cwp8LaDpO?=
 =?us-ascii?Q?k8JuxUfhORP1S7C4cKtlpFs2EtLIxLGdJ8E5bm0c2qZ0R9rqOm7MasB33v4O?=
 =?us-ascii?Q?uapUVOY85F3FU+q1AIulzTTVDa4+n6EkYkuc1jQVWtKMzkgx+s4ZJ3TaWdWK?=
 =?us-ascii?Q?E2eA2n/oAIuwT1xDXi6WQzleFHh8ZgHCFJpchKUyIwutXHVyi8eJ1s990+9V?=
 =?us-ascii?Q?W6PzMcdK5Q6QHvq4Bizi1lDc4C9Ch+ezzGFmhwJzEM2kbYfkk0yHbI8FTNjB?=
 =?us-ascii?Q?GMiUnYeE33N+pph+4+PGig7gxqYKudM6oO90+EpgL0a6IAhGLagxzvFZKWEW?=
 =?us-ascii?Q?VSQ92tfgLpH4xGlAgzK/5isPYwvddNrdJgfkPlQOa+cISje+Ms4LmmwLz1Jm?=
 =?us-ascii?Q?J7AXn3GtcukO+d3eTx5jUzNv2WebuYvIm+cxhZEPtaODzWWtWCea96OiOfgg?=
 =?us-ascii?Q?B8twi+VCRQeGx3LeYSFK5CFoQfdu6mhVMbglVLnxv5l7iW7n5joL2Q3Q6mY3?=
 =?us-ascii?Q?Urdr/0QDEBk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB5777.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cA9QYU0mziSrI0A/zNJIxUrU3YKV+Hap0OsWHwN2KSMr5ql0nI0yh//4IJQN?=
 =?us-ascii?Q?gLbgVtH3yAxLvgvR2q0sKsSJUqdb1iIRHnqSbIkPcZ+JyuOzhOjHWsESmmjc?=
 =?us-ascii?Q?+QrYgwT98IRAuSwQXN62UWoo622Su8MVIaGMxIFgelfS5INkq7LaJAD7my4w?=
 =?us-ascii?Q?6k6X78FIph8dk0PNyG2MOJOISa3OtDoHLRzlZRHBYBePeCzyPiZXmNcqlyOH?=
 =?us-ascii?Q?hS7MuUnbiIRhxOD2wV4JmlOFIgj8MYs/BvHVOVM9RihHyM5q4kaLKKlfGSLB?=
 =?us-ascii?Q?SMSPX4cjZYkZgetNl54t/tCAGVQZXDmP0/tJpRORYYqrcDxK2jvh+Jl7GdWe?=
 =?us-ascii?Q?S6VGQqDkfnToXpqeYbIDoAzawB9t/7gtYIowiljsvi1xmZIqWk5fNCUI0qFK?=
 =?us-ascii?Q?0DF8ueBYWRQrE7GiDmsixSEgrm3+IkTomm8RYTzYNWKC0qKJk9v47FbO9puq?=
 =?us-ascii?Q?XAbbpAmE0gH4rs35ZoWko8/AChhZXXIfysV3pZ6yM9sPiJzTujL5vVN0wlfl?=
 =?us-ascii?Q?8OSIbDKqPrmxgc9sFY0uLivMGeImo8P/WLTp8KMC2y4pHQTFyVEOkqBb8Z1N?=
 =?us-ascii?Q?z/1o2n4yFxyy+kJPwz9k76qmg4bCtAnS67W8sSBd0LxITVeLzAKjPiSL8v2A?=
 =?us-ascii?Q?zwVyarPIBQJNzlDH6MxJReJWxOXvounPFXAzlFO1W5KGT9jYOCEtmbRrXmJM?=
 =?us-ascii?Q?FaT1cv8g0evBi0bJWb8+6BFfS0xX1u/lZ100FbGymwdUGHxj/3q9pv8ifGRI?=
 =?us-ascii?Q?Ym6N6IXwsaoOrFY0ddYX5VecP1eJAuW0Y2baFpN/ACL5wUQg5nfIeH70Z/XO?=
 =?us-ascii?Q?brF3Noj4p+0t5omiuDwm/RsdflBowDv4Nvk4gOZmVQzx0zlDTS4hUEEiuLVY?=
 =?us-ascii?Q?aNeyVhZmyEMFlhi94AV078edyEL62QWHHc4t/yyihtGNJWx04bAD6BBLIlb6?=
 =?us-ascii?Q?b5qgP0JPc86ARljL86nKWvJrF0OglksXq23r4sVoqDtQbCnnzBatDPR2ecg1?=
 =?us-ascii?Q?UqbI1YSLI+AfSFQAbniJ5Pjc7dUVaks8A+17cI7+Iekp5XHCM/KNwf39Zix1?=
 =?us-ascii?Q?eIrhPiLT0gQTgAwdlB8mXE8i2UNUaalEJSl9WxjnlaMqwwuASEgu+oWRVwK2?=
 =?us-ascii?Q?8szNXMTGZjkhdYwUCzJHdg41l28koQeQMkqNc3pDDlrxDpe1vlN9luTqD3EZ?=
 =?us-ascii?Q?/mDZvmHQC56+8a6+VOGiB7A02bgMpnRzVnTge85SmuyKaeVhkOkesG1ol84L?=
 =?us-ascii?Q?cTCC6gYaKMSe+npsUxJOao7S/McfdxDmy3zfyCuUUVtfOE7s5PkraxXg+EWl?=
 =?us-ascii?Q?aYsul3j0kTMS9SuX487Q20faj6plF4H/eNd0QNpinr8pfJgPy0KROQHFCZFW?=
 =?us-ascii?Q?EnmWRPoW2Oc2iqpmzIKB82eV1E+UiHn7LtQNS0JeDYg1IQI3RSLWN467rvQb?=
 =?us-ascii?Q?YacCimUHpVWw7Y3iGmDmUCjz0riPtkgsPFASv2Ug16c5x+4mziDw6QWkkfof?=
 =?us-ascii?Q?lrMNbRLQ0X/f1AXzOcPbBM6c+bFYwmhqia7jH/P+5g+mWR1KhpFycHtfOiXD?=
 =?us-ascii?Q?U8OOG4ERdjZzyy5mwrRmKy1COcNariJbdWImFpdS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Le3S1H5TEAh/F6j1npOESTbcpzjPOPILgx1Dt+hVyG7JGTA42fWRSkMZNS8bgpQhOM1kRbPrY7LkTE4EJho4L+OLZKLttGlDycs5TKyzlnOYkOvtc+2p7MbE+ERBs9DG4NNRl5iOYkS9bu7SQ40uikk9kOwotOxbL4+nuxj3iUemAm4AVg48Os87NByL4j1epqPSXgV0TZl+0JK/J982Zh/HK+n4zPB3IhbvCOiNH7jHG6lZcqYNGH/6LxprhuC4nkkEiPiQCIBvr05rHagtW7JGgSdtFt+d8ma4WsrRFFfDOeXR5XxyUKSHpWsH9tJ5eMeB41EamFtjnSleNOgC1EUPB5tUdDO+rTbNBXrKirzEjCGNRrHGCGWS7IC9IwpyVQUqKb0AtDByY+1Aql3V1DFNEpTLv1gfD8JopVUXb31ApRBKMCfT4pXNIgmrsIcjJKXHX/ARJ6AMUH2xMtHoYuPXXoYOMik8ePTbkyhIIYf0UF+MVavwSzLHqs5WdcAF0jNTd7sA5/sFo1HoZEFCmP3RMxDj2r1MIah8Ie1AQtBXMJd8kG7bxq5jlNfRcqf4VBdTLd4keocWdm4o1PqPYjSVH4kbWQqcQgh0/RxXpjw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03f84731-28f4-4af5-b6c6-08dd92214b7e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB5777.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 May 2025 13:23:05.5965
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Kr+LVUGyUJx89Udr9uOwtIdqGsy4qJbR/wHSYwDXFkQgMbozxAAn16QtAUSifcpt+nw/WBzBNPkxiufD2pMKJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR10MB4207
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-13_01,2025-05-09_01,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 spamscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2505130127
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTEzMDEyNyBTYWx0ZWRfX1VZOEWpv0M6b MEqgyJZ4ZM3Xu1tPUpZgiApXktdxwZ+vCFs/1QGNd2luXa1hooHWeK7HXB9TfCRC8gxtralvQyx h+nKLuTymctzKzFs4MDa39bS/5KTlO4nzAKvX0ZdKdaz2Q7lQlYpb5/Unh1GEev1n1juTV8vaMx
 lNXTvTjhuRDTeNyHh/OPdzLa1DR6Wk36WME/PJCtMK0eufCCsMeYw31BWlaoNTTt4/o3OKnPeJx EDwthUK5jrntjw1i+M00Pb9To15VosCJSwokc6WHs6EqdrfiCB409LRGz50RAQIngz7DcAJ58+R LagAT3lHw6H9ap6kNaVTCFB80cfwUS2p1yD9A8NoUYNL5yCK8Jo6zQx+VjiwJrvSUMP4pnXZ368
 VF9/JVxBHAGhfSpvN+qsyd+dVG0a+dT1rsqkDFPFcVBe8OBRTm0Td2KbwWctrov7gu1S7uN4
X-Authority-Analysis: v=2.4 cv=DO6P4zNb c=1 sm=1 tr=0 ts=682347bd b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=20KFwNOVAAAA:8 a=T14i94LIkQBUvNAvp2gA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: R0GayYVzc9kSuJAFFX68XwQkqjPSKSxB
X-Proofpoint-GUID: R0GayYVzc9kSuJAFFX68XwQkqjPSKSxB

* Lorenzo Stoakes <lorenzo.stoakes@oracle.com> [250509 08:14]:
> Secretmem has a simple .mmap() hook which is easily converted to the new
> .mmap_prepare() callback.
> 
> Importantly, it's a rare instance of an driver that manipulates a VMA which
> is mergeable (that is, not a VM_SPECIAL mapping) while also adjusting VMA
> flags which may adjust mergeability, meaning the retry merge logic might
> impact whether or not the VMA is merged.
> 
> By using .mmap_prepare() there's no longer any need to retry the merge
> later as we can simply set the correct flags from the start.
> 
> This change therefore allows us to remove the retry merge logic in a
> subsequent commit.
> 
> Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Acked-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> Reviewed-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>

> ---
>  mm/secretmem.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/secretmem.c b/mm/secretmem.c
> index 1b0a214ee558..589b26c2d553 100644
> --- a/mm/secretmem.c
> +++ b/mm/secretmem.c
> @@ -120,18 +120,18 @@ static int secretmem_release(struct inode *inode, struct file *file)
>  	return 0;
>  }
>  
> -static int secretmem_mmap(struct file *file, struct vm_area_struct *vma)
> +static int secretmem_mmap_prepare(struct vm_area_desc *desc)
>  {
> -	unsigned long len = vma->vm_end - vma->vm_start;
> +	const unsigned long len = desc->end - desc->start;
>  
> -	if ((vma->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
> +	if ((desc->vm_flags & (VM_SHARED | VM_MAYSHARE)) == 0)
>  		return -EINVAL;
>  
> -	if (!mlock_future_ok(vma->vm_mm, vma->vm_flags | VM_LOCKED, len))
> +	if (!mlock_future_ok(desc->mm, desc->vm_flags | VM_LOCKED, len))
>  		return -EAGAIN;
>  
> -	vm_flags_set(vma, VM_LOCKED | VM_DONTDUMP);
> -	vma->vm_ops = &secretmem_vm_ops;
> +	desc->vm_flags |= VM_LOCKED | VM_DONTDUMP;
> +	desc->vm_ops = &secretmem_vm_ops;
>  
>  	return 0;
>  }
> @@ -143,7 +143,7 @@ bool vma_is_secretmem(struct vm_area_struct *vma)
>  
>  static const struct file_operations secretmem_fops = {
>  	.release	= secretmem_release,
> -	.mmap		= secretmem_mmap,
> +	.mmap_prepare	= secretmem_mmap_prepare,
>  };
>  
>  static int secretmem_migrate_folio(struct address_space *mapping,
> -- 
> 2.49.0
> 

