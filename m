Return-Path: <linux-fsdevel+bounces-62125-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF8B84CBE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 15:27:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9CCA01B282A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 13:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9700630C611;
	Thu, 18 Sep 2025 13:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="EDr1zZi+";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ee7tZRmW"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A3330C37A;
	Thu, 18 Sep 2025 13:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758202002; cv=fail; b=Y/whbpsg52UJO2LIRrOWES5/IlC732Ze+XpWBFHRLYYM0wkWB0gW7lLfSY+SokGnjvcEENsu0xWTxoxEhY8rWUsaQ3nTwO8KCuN8IH2+gngOTt9Wp6UHclUG0/i8T6ht550mdcUq6vrfY4jOUfCC42hYzVTwVIVCPJKbO3blq6g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758202002; c=relaxed/simple;
	bh=8BdygEqtUQEOb2eagg8uY7gvnyGtUOlXxS4mWVqe5nA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=E7CYNFFTABp9ukDhCFmTY8Iarv1s/OjXzoj0OmeJg8dPSGdjtDMf/v987iozCgcdWozfjSC5IvnA28WJHiqw8l92Hym1LhnYWPQipM6DrihlNuhE1vW6aWWSfHEVQAP0tYCY8+MswX5812qmHRJOe+WHY/wq/kGGs+hUlX0B80Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=EDr1zZi+; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ee7tZRmW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7fvsY007031;
	Thu, 18 Sep 2025 13:26:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=zorK4pVen2JQiEi5iO
	7oaZWNWeAt+PeDKTmmEgclWWA=; b=EDr1zZi+Fa1NkFVrJo5AInETQDYSErroRC
	3QdPkmElh9iRV8ebHD6NxkVSqpZVMhQquKPyJyEz7QHZ6ao3y/rE1oyfTsr8Zq6Q
	w6k9F9F1wAw7RRwgMiAyRM28eEOARbz0u6kbN8+1kCu/fXhwB8kvqJwrJ0xx2q3o
	3Mt4hz7hW8CxRGZN6oGqrGhtGvH1XMEPVwEcJxpKQlrMUCUxJy4pE9wvntLFv5YO
	EPm6d5JPRmc+nx+3nrdm7cEP7K0oJEIrXmUCisAFKxbX86ymMAGDHkn3sDa/6yLw
	flZSgVT6oLRDV/4JLyptDIVr2nxKHAGqQeCVGPbFBWUb3zpAbaGg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kbh70-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:26:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58ID6MB6027324;
	Thu, 18 Sep 2025 13:26:11 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011041.outbound.protection.outlook.com [52.101.57.41])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2ndhmh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 13:26:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jblEPLpCsPjs9YU3ue7KQYTal1uOWQ/hAic/WB40MN8O9OUtaKbik4gr3b9Zt6fX92SQBiaqHvvGAa9yMRatwkSF85GfwfNTqQYwPrqm6w6F8wB1f+o3ydG2isZweoBsHJFHXnOl44YGpHmQBFufJmy9H5fhOWe+OCMVXF0VuTQoCUT8wEtGcqq4pM5K6sK7pDsJD+KXUq1i5iJrATgu7xiOSVo9a/SHhGlX0TVxtrTiEmlFsY86Yj21kfu4VAqXetcsdlQtvEBvyZC25gyUqZj/S64GtwuVr8XYxMy9hAQqzV2aHvC4yvzCo79J1NxeaW0W3IJ8042bC6EphR7ULA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zorK4pVen2JQiEi5iO7oaZWNWeAt+PeDKTmmEgclWWA=;
 b=tnM8uUTow1kVIfEkne/1Epm5j5sZtmGcAtI5S7sR1XOhND/u1N6RJED0K8ttmxBKxekEE6P9eqZxhtAnCeGPRaz2+b6+o9QQv8tFIe1VqpFDLANd/kgMDfbc1hmZiBOIUp37XM4MF2jNv8a6vQnuvMSt+TLoufx7nBvtvsWudAr0WYBZXQ7IhNTV9vs/rdU9A7BYjUhIn6nrmNzmnCamCP8aqLPEXeU0vd/kQh4B4298N7M38e+m21IYvr/TEvfrcIbRDD45h6E88MKGPnUTuKA1hMKqYA7vZxNg/H9kQbFpGRqJBRFf4Zb1oGnwXo5RC85QFW/OOndI6s+eJ+8z8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zorK4pVen2JQiEi5iO7oaZWNWeAt+PeDKTmmEgclWWA=;
 b=ee7tZRmWGYZmQIjqR53gQoQn2IHEa63E+PLBgDkqMbN6tzJqZQVe3NUfOyKTyM2qDKe1opbTlGJPROaMIRxqNYCtN7fSvKTPo3lI/YNhpxjRxoyL6SzOR43iHBwWM7CB7485wdQ1k78rgVYx1yBghfXnaKlbneyCCS8Z+gv3Pc8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by CH0PR10MB4923.namprd10.prod.outlook.com (2603:10b6:610:da::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Thu, 18 Sep
 2025 13:26:07 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 13:26:07 +0000
Date: Thu, 18 Sep 2025 14:26:04 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Kalesh Singh <kaleshsingh@google.com>
Cc: akpm@linux-foundation.org, minchan@kernel.org, david@redhat.com,
        Liam.Howlett@oracle.com, rppt@kernel.org, pfalcato@suse.de,
        kernel-team@android.com, android-mm@google.com,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>, Jann Horn <jannh@google.com>,
        Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2 3/7] mm: introduce vma_count_remaining()
Message-ID: <64231ee4-c1a5-41a0-b13e-505a46cf671c@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-4-kaleshsingh@google.com>
 <48c29189-30d5-41fc-ac53-09ce98e87cf4@lucifer.local>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48c29189-30d5-41fc-ac53-09ce98e87cf4@lucifer.local>
X-ClientProxiedBy: LO4P265CA0177.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:312::20) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|CH0PR10MB4923:EE_
X-MS-Office365-Filtering-Correlation-Id: a4cda2d8-8937-4531-d722-08ddf6b6ec7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?13U448JZZFuUQfkWm2fUuOeGefmIoYacoc3MrVQXDPDF3aUJmRnwIosySJcZ?=
 =?us-ascii?Q?dR6Z9MVpcZuu56y2ndHqIbjiJFG6qyJBhLTssLnrsVeWaNBZ52yOl83DHw4M?=
 =?us-ascii?Q?qJVbnTQf0Npv2FO5KyxAvirmbr8UN1kxpvG5FJL3OfDII4dzuB5KWTJWb+0m?=
 =?us-ascii?Q?KcniBjlHSZcvBoMFGDsfj4mkhI3Qqwsq/cpcScM9yV158+GjbsUAUBMG6UqN?=
 =?us-ascii?Q?eGEI6U3W9FbvIXKR4XxvLG2CZM9cwkEt5305Mca8MW5qekucphtllpTy51a4?=
 =?us-ascii?Q?WUyi3UvNchj0aHhCJIUqItj7+cWTRmvUcwY1rd15FXF9gEi8s/Jocsp8mgAv?=
 =?us-ascii?Q?l5K04EPnvIsBJvteNhxzbcaM+Hq8v/67r/LvX8BE9fHafNR4RScQ5fBSo2BM?=
 =?us-ascii?Q?+YE6Alse5fP6vwtLqWKEqDeeZj79wsJOwGwKqHB0N3EUgNYV3FOz7yCWbjut?=
 =?us-ascii?Q?lpc/9vbO07YkEp/wmg83pjpvJXvXJSXYAjV232IK1K13UKGWEtz4A/BqsVrS?=
 =?us-ascii?Q?7h8QM5cZDrll/07T0fa2L7yKxakCAtap+Kx2fj1RiXJKmrtW45Dc0Yo5QRqi?=
 =?us-ascii?Q?4CIuoRbPy5tykBAuD7sWeTzpK44izm+UdiTdf1kCTqB1+ouyWY9bfVxQUlNW?=
 =?us-ascii?Q?J56BKTDdAwtImJ41g6xRYx9HG2XB+QVWh8q7NuIUwpyT0avaH7QhMwxSksjj?=
 =?us-ascii?Q?WdjD7U2vgJAqjdv9Y7UXgE2UGqjNTPqxf3oKcRYj4WOwCmZhEc4+h60CCng2?=
 =?us-ascii?Q?OC7EoFNf7Dqrmye/2qsIKeaoAmgi6FCOYRNNLMRz7ynv+lWUPCvtO1FQersw?=
 =?us-ascii?Q?e1NDJbbyTHyydrfEaVSOlqGVySNhOPJ23i/JSv6lFzr/SS9rwzdkFJK1b95H?=
 =?us-ascii?Q?DXXwVHzAnd6XJsowfVVSmwrOVVsm4xSYnnpVL6bilpenIdjnux1KYpNMATRU?=
 =?us-ascii?Q?AJve7YQfSmmWMQNYzlMfRLZY9f/PTik9rp/je3EcqibGk7dmJhUdncufyC4N?=
 =?us-ascii?Q?n+PEi4f4LwDf7QQp0BO1PnSKMfdgkD1HdC6vz12W90mnmeaHa4Rf9wnRECm4?=
 =?us-ascii?Q?gS66z54ZCmI9CXDF9ovViD/1MDTm5EKLZOM5BwRx7gar/CDjUi/f5BqWy/e4?=
 =?us-ascii?Q?cjkU3KzsOqrkeXkY8+TkB7yPWcQ9DWH36zDpc9lvGpTAzuQTiMYVLu4QnUnE?=
 =?us-ascii?Q?dL06AvTCF1U8zoZBHw6MtKGgGRDcixsHO/NzxqT/Q/2HZz9WDzrEJjoDwpa6?=
 =?us-ascii?Q?5ITh1Tu+3SkAOK9h31M7U1X6X0SRRrRvFO5EYqksABXdz7oho1Stfv0/nr4L?=
 =?us-ascii?Q?nzECcbDpRwTp7ypcHMrpvAwGDqCS2EGm82k86qsuQOskY1hhRLRFOJLFAY+8?=
 =?us-ascii?Q?C3ilqH6r3/FMXhk9cRTivOf2M4dqnO7qiUURw0xcfuL0KVThZKJFH/QriNhn?=
 =?us-ascii?Q?7TqW/tB2ytA=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UzLahSlfcLZQBOZfy4ubSjdjP7EHIIuwpBiafOIoZbYig0ulDb7NX21NHhlt?=
 =?us-ascii?Q?ohS2gmM9xz89PoxV9TQhcGHVW66HvixTdIrNbAy0KOWD/lG+lh3SbYo8gPRu?=
 =?us-ascii?Q?2tc9Tq3iYXiGKGYgJV3mMyhYNBWu4iysykDV4/hVgMhMkRcvPaY4pSnfSU41?=
 =?us-ascii?Q?azpqAU6RV0SIBho/PF94qRZhO92hWTxR7ibi0ycjW7EXm/c/MTLHAOSzhrMw?=
 =?us-ascii?Q?p01OezIj/xYAfX/VuZCF7RN0MNJvoleE71Yz9Xdhp/vVEL+KqStu9q7EqzQ+?=
 =?us-ascii?Q?7F3hOPNm5W6fW0n1b/h2Qv7C4h6l60NDEjfMhyA0bTAUOZ0IfnG+4vnuqQbN?=
 =?us-ascii?Q?eEv7KkZ62foOHNK9PzjyqQCViiSH2jhapAYtqkNbBM3mG3kJIp6reyutlnlK?=
 =?us-ascii?Q?wkGU0jlVuKIl33lkaZb04H9C0vUg60tBqfUnXj9XT+cagQEv1J92DA68UbB/?=
 =?us-ascii?Q?P3j8ocAouZ11CdnkOvLKbp1zqxxfFg/OS96/7ZIywzvT7O2ONK/EKjV5HYtP?=
 =?us-ascii?Q?va560AsqH9daK6gLgIkjE/EI7ocpHDqFiFrMF+xtaGtfSO8JWxkNX013OIy/?=
 =?us-ascii?Q?lq3cVEaWSDxLIBU7kuy1NJOJKCgZ/yNHJo01OoZzoYQ64bi4A5e8RWD9dTVn?=
 =?us-ascii?Q?pcL9jhSVG9bQA/df03H4nH58KVwdHoEhsvEbiBbO6Kq39qGJ6L+9s0OA2Ayr?=
 =?us-ascii?Q?TupcuhY7VHPw1Aowz4F1LGpgO3xSz7tHgTMb7s1tpjUF5UuLvIpkaVsFHtfx?=
 =?us-ascii?Q?M+xFqDXoJvARiLts+9tzr8/74XZGzv/RfIB7jQlsUEbsz9paznKzxIMwtfBI?=
 =?us-ascii?Q?KrY++zIAZlPGpUmebNSVIdkiGCgWAqwmSS/EYeTuk3WGNp+DLcNjWGf3aLuX?=
 =?us-ascii?Q?VBkDpL6+Mwd4VEKch/hiat86ta/XAfvIs9TL7U2PDj2tRd46ngN385KnBs0c?=
 =?us-ascii?Q?Ejxp1BM6mJJ/sB/UEhz7puV6etcRorGuJUZuFw3Ez19gZMmjU4g2312m3I06?=
 =?us-ascii?Q?GUbhOcw2Txsm/Zxuuvl0OVY+E9O4FjjK1BEhL8huaXTjCnWq7rKKSyy63qJh?=
 =?us-ascii?Q?flWIu9j2pxa/1MpDmgff38Xs7feDlz/Jz2n4QwSNs+pxf/up4nwjhWmWvsjp?=
 =?us-ascii?Q?KSuzSyKmHGY1H1fb3GA3hvwsTtuXfiyACjn9nCJbMiDPhYfjolJvnlf9+Dv3?=
 =?us-ascii?Q?f3NSWKybcqqogKBkK73ED8/fMr6fw47dSDR/lmlyPG6+oUOB72wVauLpooGw?=
 =?us-ascii?Q?XBoDJuvLtEdVbAJ0+/TT1kArrt6RVJXQmihKENaXxQh3QvUvm+arEdo61BpS?=
 =?us-ascii?Q?ihS0aAr33uxtV5sSg+LYHjXai6BK2njaKkk08VRRnZlwfWg6enWx9FcY9yPe?=
 =?us-ascii?Q?6O4TTCsN3wF3bNkpBfLVRAUICbrXQ0SVqrMkihjh52Uam5P3QPiXtYTWbk+J?=
 =?us-ascii?Q?9GpsA1LyDI6wIvqZNK2AwArwwOtJCF6N9rq26uOEgdeImYdogOs8ogn0wW3H?=
 =?us-ascii?Q?SKLfK4XvBk6IeyxIm68DLhBclA6bQwnUa+/ZjwEJXHiAsfVDnQ4osSaDoSKW?=
 =?us-ascii?Q?s69MCcigpDadQgSqXdvN1AhCmwMY1q/AuzOJ9fVWLhk6Ue9scNQ5gtfdHbF0?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ZAvmqp4VbbhajlsCmgHA5TUWEWk56yzZAJds1su+DUFSrc9vXUm8b7U7sqhUsCOO2jU9KnBJ4vGP0QZrD55su+f4Wyuseio2TA+tLGQaHBCcrEvyrjJw9JtKSKcYTJegQ0F5aXFVLZONO+WIjct1oT1EEr6uJYalJEZTsyQquWf2WYNDwPNB9fo++JQIi3Ob22faohnHqVzypboVm+yMXFHjwYZHQhxCJdi4K8ltLXbJWSTXJSHzpkW/NYTSilUA9RmIcQWm5Bp+va/CL6EdDK88mOwFyPcNE8yqYblky9sIdI6ryWKIwqdLtHvjj6+sYVo4ZA3rnOZnRyLRxhLP1uBW1r4m/7T+X3qpVvK+VOTtprSG/T8Tqv+dtrg8xbneG38MEPxPqi8myaYU3h1aJwTRMzbyiHsGpsgqgx0k3kZ7UzkxAWl09eItlmB7lrInYO3ib7TS39tS0yiMaCsX/CqM2r8Nux4N1+zX7B8gMkjae7//jDwnMR3o7RH4h0fDVZzbK/f/Bu4W9Q0HkzpzmhdB+2O6mLId3y7G19DlshIfCfxiB6gR04bAJvXnwqARv389eEbGLwYk5d5DoglsYrYtfxDi0eq3aakgxd2ihWQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a4cda2d8-8937-4531-d722-08ddf6b6ec7c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 13:26:06.9348
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1vAR76JcO4nbC4eySaSmla7JgVjEeIvKHKk+nuRE99XlUwjZCsz0CQM2qXzKDCDpNXnOUy6Nc2kIJ9F7buYT+c16N/CgsYd9vTJgx6pt7HI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4923
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 spamscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509180125
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc0874 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=i_GYS7oOrE58P8UH25EA:9
 a=CjuIK1q_8ugA:10 cc=ntf awl=host:12083
X-Proofpoint-GUID: sSrqlbecZAa3wwrH4TpkWpOwJ8aRtDiI
X-Proofpoint-ORIG-GUID: sSrqlbecZAa3wwrH4TpkWpOwJ8aRtDiI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX7EVN7+R2jQ4y
 fDqAql+mM6oyz+I5FriPgeWG2sXHMU7swT7kilTUvmzQc5dmlmppA2YixvzGRMpaK4Y9Ggd/czC
 xdLXbaZOjcyCUcqrK7mr4xod9WxWr3XfFkb45k3Xe7DjolKnu0bargZIA/cRtps4SQPpuAO+BqG
 sXTlemE1Glh1ERa+D2EbGDnKlzPIdxoQdsenSywkOgpv0wvDiDx+8cOHSCvOSlRVMV6IDdG0CXN
 hcJr/AneXzF/5xhbcSFtGVo2srpvxeYXO544mCLb7eG2aKTy83A1tbTPc9y03u5aujHzghnper6
 Wdd8Rm5NW2PY+uvb9QI7Jm3OJpdtshIukmDp6b7Wnhhmhj3dxkOVg56Zy8xJflTwCw6kVfIS9mi
 J4RUa0Sy2rJuQnOtjL0VuRXLgEaQ1A==

On Thu, Sep 18, 2025 at 02:20:03PM +0100, Lorenzo Stoakes wrote:
> On Mon, Sep 15, 2025 at 09:36:34AM -0700, Kalesh Singh wrote:
> >  include/linux/mm.h               |  2 --
> >  mm/internal.h                    |  2 ++
> >  mm/mmap.c                        | 21 ++++++++++++++++++++-
> >  mm/mremap.c                      |  7 ++++---
> >  mm/nommu.c                       |  2 +-
> >  mm/util.c                        |  1 -
> >  mm/vma.c                         | 10 +++++-----
> >  tools/testing/vma/vma_internal.h |  9 +++++++++
>
> Will look into this properly later, but there's a conflict in vma_internal.h
> atm for mm-new FYI.
>
> > diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> > index 3639aa8dd2b0..52cd7ddc73f4 100644
> > --- a/tools/testing/vma/vma_internal.h
> > +++ b/tools/testing/vma/vma_internal.h
> > @@ -1517,4 +1517,13 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
> >  	return vm_flags;
> >  }
> >
> > +/* Helper to get VMA count capacity */
> > +static int vma_count_remaining(const struct mm_struct *mm)
> > +{
> > +	const int map_count = mm->map_count;
> > +	const int max_count = sysctl_max_map_count;
> > +
> > +	return (max_count > map_count) ? (max_count - map_count) : 0;
> > +}
> > +
> >  #endif	/* __MM_VMA_INTERNAL_H */
> > --
> > 2.51.0.384.g4c02a37b29-goog
> >
>
> Probably because stuff got added at the end... :)

Oh mm/internal.h too, seems that's my mmap_prepare series. FYI

