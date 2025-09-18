Return-Path: <linux-fsdevel+bounces-62138-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0474DB8558D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 16:50:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C65817A8C5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Sep 2025 14:49:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C873123AE87;
	Thu, 18 Sep 2025 14:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lbU3SiG5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XUIJoHTE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACBD1DDE9;
	Thu, 18 Sep 2025 14:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758206949; cv=fail; b=pgfw2CYXb3Rl5xI/J2y9fVYXkSCc4qp9L8HI5/dS1uqkMd4KKAhy9JtUhgPam1wx/+0HJFhELny9B0AXPcdr1NuWkbZ8yUWX5LCR07N0hY6bucAvYJWw7zYBm6KyCeE3wUVJ0QBTeBI16oMUX8mRqFnrl8Xy6XFhx83CSSDlvT4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758206949; c=relaxed/simple;
	bh=uHhREnKpqrM98ptvHxubtDCy1yk1WBuElsE0a9XvtAs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=jBdn3GOU2tSN4ufi0jiICeTPI4Wn2IIocdk52lNAh7XDTgBLUR0q5lUXp8ui3F/cNYiSvPFhjTve7DdXYpG2CVT/0YPeYGgsoAZiFZ8NskSXUyjcs92u3gSVg0ibPaTxSOe9WMbLry7+VSKsj5GnERMGE3kYyXHASwQxIEjDWDc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=lbU3SiG5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XUIJoHTE; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58I7fv76007031;
	Thu, 18 Sep 2025 14:48:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=E56pj9KBj4Yilbs22z
	3ljyp71HivMlGr5tJQvlL9lts=; b=lbU3SiG5KZU/yRTyFKiUr1pFuNKfPK4zLj
	doYHjdtctkw+yz+1bE0Xf8QlWhJUrfxDTWHjtzijSGz8eA5Mz0bqIdec8WhfdlRH
	jke8rIy0Fgvn9vhLqcIHIjuTYwVqFJtREkrFAyNg0xiHGdH4jgbZ8mNDJI4lduTE
	7pPDvR0EyfeyVYqQyp2g3Hf3COaXiM6CALuOkJlpGpB25tOs9baKNJ7R2fDY0dZy
	OGuvYVSlII+SNyLpwazL7yIW/+fhA+T06Rjtmd2EKKiSfarbwbN3S1fm91496NIf
	HIKPCYaXhtOkShDauyzXilIqAq2L9c22Ie+jDzF5KA7AuE/2EhrQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497g0kbqeg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:48:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IDru7V028744;
	Thu, 18 Sep 2025 14:48:28 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010071.outbound.protection.outlook.com [52.101.193.71])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 494y2f7yev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 14:48:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IhVVBjQaDpX+Lo6EYYmRs43iWvHHqTEO5AalRaGmDiQDW4w7FiJrhxmCrhBgDYHvh1w3+J0A+8UpF28QGAmpImWodlRyEwmK80R+XXMMpHoQQXXtHHDNPp6K8lFTWSo4nzA+xFDZsBlbh7HKVfhWZ8hDXpG6UOEl+M5TZMQHC5u7Bo5eJ7qvDJ5ERhMoR5xTEq/inyyWD9rbjn4lrknuCC4TV3CT6UKWOPKuVWQxj97FKwYA0F0CPtSmgKie7MkNJVGIoGsqV7E4njBkgsnWDDOckBJekxCVPPpe1EyOOEwU5VxSZttEAeqfYrgAAvqHJ+PYBJANEo4UQkBAVY+/XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E56pj9KBj4Yilbs22z3ljyp71HivMlGr5tJQvlL9lts=;
 b=nK+Tuki2AlBoMHoNajXUlZZ/2iA9Ly8dyNa6IfoGwziaa3u8/ZAZiTPppE/8QP/v7ki3Ks+xh/HeQUe6DQIPP4xoH7zF1FXl8Y1jCaxF6/FxnE5XxdICI2AEOyyjKuhAQOf4bizZUfDl3xNI0TrMfK6SoSk6fDwac1kzlbL/lzM3S8CttPuUqmcSGwifIDa055yLOyiH7z6Bz+k4HphwriNo2TQdECd5IRD1BPmMZB3nhlJF5RguUuHPz51/RdqGpZwJgjht6T9RlHIsgbqunJrwJ6YnUEXr//3y9ZkK93RFF+eZDC4fo8dR60FDhoeLB6zc2MTBlmL/jJZpDBdIBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=E56pj9KBj4Yilbs22z3ljyp71HivMlGr5tJQvlL9lts=;
 b=XUIJoHTE15UvHHfVVDWsNK42HjP9p0xeYCBOupPTtXM02MNXXhtdXF8raVCNyiI2O9Yis8lgIb0cCxmvrN3y9gMIIoyVwgNt93QmrCqXybFmMqkVHBGVnoOAsg/H7k0bpjjqsuJHMZy4fr6MyCFQKp2qeAUm43S7tY4plJOA+c8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH3PPFAEC321F49.namprd10.prod.outlook.com (2603:10b6:518:1::7be) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.19; Thu, 18 Sep
 2025 14:48:17 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%2]) with mapi id 15.20.9137.012; Thu, 18 Sep 2025
 14:48:17 +0000
Date: Thu, 18 Sep 2025 15:48:15 +0100
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
Subject: Re: [PATCH v2 4/7] mm: rename mm_struct::map_count to vma_count
Message-ID: <1eaf4156-9c8b-4a59-88e5-1f04fbebfa10@lucifer.local>
References: <20250915163838.631445-1-kaleshsingh@google.com>
 <20250915163838.631445-5-kaleshsingh@google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915163838.631445-5-kaleshsingh@google.com>
X-ClientProxiedBy: LO2P265CA0338.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:d::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH3PPFAEC321F49:EE_
X-MS-Office365-Filtering-Correlation-Id: e550662a-bd3b-4117-017f-08ddf6c26718
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|366016|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?r0GzjjCEk5Qp9qMJ+OfIlkt5oygO9QmpyKb2CH4fJK0cWY7anU5DXMxuZ4Mi?=
 =?us-ascii?Q?TwhOMclx5QnuCzeE1TjoCB4FlMxMJtPiMr8HrEQzPSNPH4PyY7qcnOEWvNaH?=
 =?us-ascii?Q?rGWejNJFKc1KvrgFclEc7SGc6xQVHga913hegoxCnGNcODkmnwxMSl90qIT/?=
 =?us-ascii?Q?xlkY1JA8Zpor8svP4nLT44x4HoaA8q60Bn7WJZ0Z+X//pM+hmzzIWn4bFkgd?=
 =?us-ascii?Q?BhztVUdSJ6iDrOhq4EsyJ5qbdNpSN7/AzLjVdcR4ObIBmlt/Ly3G9apN2TAH?=
 =?us-ascii?Q?4wyOaNOLVi8x0Ehf4dONyjcISljdV4+B0iumJpPiAVrGeWsZLgDqJtXX4ovS?=
 =?us-ascii?Q?tdYQweFOD8ez6FhIrJwrdLG7cKyuQ71+V8iHumCJ+sldJVJXL+9RCJqB3CEp?=
 =?us-ascii?Q?KgLylrdJ0MYxn09yn/fsawlj9O8oSJKXfRFtaPJDCoi8yoa3BNmrZr2KLCdy?=
 =?us-ascii?Q?xZrg6YXPlrx4j2dom52MN8n2CtVTXVTFbSkHuChJZ6v6TkEfqklMyglJS0V4?=
 =?us-ascii?Q?LssU8EWr3TpjdXrti78XwEN4FNtm0oHFl0oAv1sTY8aQOPqDr9ZFIM8qq18S?=
 =?us-ascii?Q?bG7+GIyS2RY7pz6QFUqvEIyp6kiilD6iw9TPh6arH+AG0L+m65QJZJiAUcyU?=
 =?us-ascii?Q?FP1beFBher8XRvE+LWftl+P9kEcuI5pk9tFkg0WryWfx49vtrZIQkLIwI9Xr?=
 =?us-ascii?Q?my4ghCu43t61Xsm+5VaPdUh6Hx+dN0MqlPEIZiW8AgmX/TWd85d39b5157nw?=
 =?us-ascii?Q?uSV/dgo1oP1ZGXv5R8nuHybGsGvO+0CAPyhEffRAIYeRH3rT0snqHRETgcli?=
 =?us-ascii?Q?Bn/dbm07ALEJBFZdwj2qB9NR6ANPW7zDRgWr6bn/z58Pm+OVoG/1Eyg7Pu00?=
 =?us-ascii?Q?ik/wHfFHMLwIPurq35EgqrykrQhG5mchh2lICkbhmve03GdojNOuck3/yu5d?=
 =?us-ascii?Q?8pqAke32+PdTXDGBbuHFZzHxYtUCqSZHi7oB551/aUldU0P7SRVQ9mbJSfF8?=
 =?us-ascii?Q?LMIR8vPGlw8UuT53fB1d9MnT295lo/PpRHZl0kyUfaUqxt/KoeQuzgN/0pQB?=
 =?us-ascii?Q?5pbJ4FwhpxlKpSsUp3jpqK29tl5VKeMPxY55E7+v7lA6govVyc6OOB6oFWX3?=
 =?us-ascii?Q?tbqbD+Alp/vlu5sYsncUFCmtGHpIfLN7dOHpN+RpTZ1QhYLz2WBHc6Brlgp+?=
 =?us-ascii?Q?rAMg66HcoiRTSE8obuvR4D1ReOM4CSvWC+7yCHLQo9jwRQoHWdhTQpAWLB7X?=
 =?us-ascii?Q?EQmu04WqwSrUEj7GNQGx47K0lo1h1QCRbPcIGmr4EfUKm/7kTI42VhgFEOWf?=
 =?us-ascii?Q?deSnJC5g2+obPdu4rYxBpHKizkd234WH2n7wZyd+qGCP2550yeT08T8m76UQ?=
 =?us-ascii?Q?j3jQGacW5cfJBZ4++pZcnB8bBhAXa0grCuQTS4LM9nTtDLjSkCnebeUYkH4D?=
 =?us-ascii?Q?RfwG5yLGArk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?O1Qe0AEWzxePp7S8Wus2IWceH+Nn/vDUHBtZeQ3hn1dZZuo6azios2aXSLoY?=
 =?us-ascii?Q?t6UwvNN2PQ2U/wUO2mnGrQfPYjMAFoD8kEAsz8Vg20nfq+f5rNW4w3CJqxPT?=
 =?us-ascii?Q?9f3edP0cr7Hrg96LTlig32ZRQ2+Y7Svub+4M/UV9BNjfAEAlnQwz4RdyjLVc?=
 =?us-ascii?Q?Z5nLEQsKQttuzWLIQO7sTDVffyTV26bIjv+MxJBGahR6wyoUXzGdL6466/Aa?=
 =?us-ascii?Q?DMONVIssPArBD+SQGJ6iTcpkKJN5krIwfCrU5XdZgDheOCnl1+iBBJDbLHxG?=
 =?us-ascii?Q?b9d/rctb91jcgiWIPBw6seKUu7vQoUVLCROXP1qiVJF5VUmNt0c0t63PaZXe?=
 =?us-ascii?Q?+c5Qh8VomHJwhf4tbaiGgTvcChwmipnabB93rOUrjo72bMQYMl2WjYQn5c2v?=
 =?us-ascii?Q?hy/rApoisPYuDfYLaV1Cp7mltTW2IukBjNmod0QD7MVtTxHmM49udPNmfl8k?=
 =?us-ascii?Q?/OYuhHaAhtBebCoNpzWFLsT3DhzTVja6qCxgIcu0rpRPB9p74ToXmquSs6cz?=
 =?us-ascii?Q?FtPZp0S1gp5qamRvd9M0QgUa5Sx+NifvXCGPFVOcO6CER+3d3yaM5d883cCW?=
 =?us-ascii?Q?vfRqGleRceyutggj2TFXoxgoReAyW08efgOWFiEqmvvy97N4BH52ZuxqOX/F?=
 =?us-ascii?Q?w/Ta/f+opEI11QeF83Hpgyk72+hLDzyOzgSj5OH+3y5MYx1+UPSson0wwi/u?=
 =?us-ascii?Q?o6ic7RAw2ZKuOrquSmHwHiRJuzefMATMa9daq99Ky5IQ8XR5dNfSvywuZpcL?=
 =?us-ascii?Q?AlL+xO+NBilQIBJduXaXToF7mGXiKGMCgbL/uLkII26LWLf5F3m5J9+qs+W1?=
 =?us-ascii?Q?/2Nsh6GejxXwt96uuk9ykWEzoyVc6aT45im4APYm9JWFjmz2YNKPsMSWWzyz?=
 =?us-ascii?Q?E18aFKY2Pk53gAPvSVzqTMghZa3FYxWnKFO8ujjYEwxCInC+w4FWaYKlRo6Y?=
 =?us-ascii?Q?rwzgR6I71rgLJNjOYLcGLVy6yGvp2GMW9kX5BKXgkbyD9489Thi86zcgyRLO?=
 =?us-ascii?Q?ZaxTpMG6T1e4Ya0vEbaAyGJCsscjHmYcFaRKFGIlrxxxGfuJ1ypD5ouEDWcI?=
 =?us-ascii?Q?IFdUPpbl2RVdAaoODXDlM2AhHXMgIt3IAzce3PaCcO6h92xs4fooHXmoSthI?=
 =?us-ascii?Q?r9ZXU/xvetMV3PqcLOwHVuBgiXBsGLme6a0dAekbtrBJrBbEBduFZZci7Akc?=
 =?us-ascii?Q?hQZqrQ1+/k8lag3MlTpX9aii9dvKKXdEHB+Dbemg5BCTr2n4oeeSosv/RP8m?=
 =?us-ascii?Q?aegzOm/nMlofWRSgkuvfwYfuc2M8SJuFTiz1nYQI/dVwJx/8Ky/xa6KY+T2K?=
 =?us-ascii?Q?Qkh3RuG1VTVTIqpu9wSKNUS5xiQ1RVE9oQR9OsIToMLJfG7YR21QZFMBm0R4?=
 =?us-ascii?Q?B5PFLURbfXFFI027tl6fUyu1fKVGHgEPPCG5+GhtKDYcFfHBVGhXutn0dPI9?=
 =?us-ascii?Q?MKCY00y9GS/7D+SMB58xxWvtnrBaJhlF97vHJCY3mP1GAKNHozZkLSITr9iB?=
 =?us-ascii?Q?XHACo0IC3s4xvsWj++nWtVfePVWzEHf8c2CxYoLqlfgmzB5JbuqFaUTnp/3m?=
 =?us-ascii?Q?rhVJrR+WzdfoeCLLitgnkmL/aQeuZ3Av6BT4iJPk0T25922t48/pPoC8vd1z?=
 =?us-ascii?Q?aw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	GN8ai76yqXol/cRrGqwz7Ez5Ss2IuaKbAGBlMvVoLxi9oz2/tudne29oUw6myHo6GIWUtEt0YKGx0wKdaiOHNOzkwjFlI5cKnZe44zUUx/P7XSqithX1tsW5BFD95JnNLxj5jgXhRu3u3nGp7iqht34vmYGwFhcOuxiGljAtKNFxVNXA8eVEZO1RPg+a89tNWgQDinDTfBDtxBr6FjiN8PwZotsBfwsDyOk7lyuohypXUUwXv31jiYA4Qu2OwTbre9dNfrsgmt5kua+BOr4qOoWfVUGzDpIDqvAqvbnsfrA29DuoSZ75wWV4jN05/ctzM0qkByhHFwvmhlxU7cCGve/bs6BeR7vS/mDphqP+o0axLf1+vOhDn+CNn9No5R0BKQw/TCqKtu3aGsxvD0EMhK6WmuLmhyE49kRqyMCg02iqv2qqOiEci6xhsVzwt7bhpCyH8c8mBibjnF+wpmnn+yLl7JWxXoZvVW6Y0TwUf4SFVDv2w30/YdHIawn3t3YLQ2Yt1hNxhO31lpTaA5xCLsyWgwMr3XRKYANDwJdUGov/IFWs/Mm2l5dp0sFKDavDOqenq5qWDY+fbh/rsMYYd0rPdHJO4kBNpXYy0icQiFM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e550662a-bd3b-4117-017f-08ddf6c26718
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 14:48:17.1886
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vbH7P70md3MyqF7jo00UfEmcSMIM7sgH0s0gsw32lXmTLn7Ugo15+51nRM0hGuJH7J6eIKi8Bljnz/gAmzwCHDwb8F6RWNwWMu3Uk8poeKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPFAEC321F49
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_01,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180133
X-Authority-Analysis: v=2.4 cv=b9Oy4sGx c=1 sm=1 tr=0 ts=68cc1bbd cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=Z4Rwk6OoAAAA:8 a=20KFwNOVAAAA:8
 a=yPCof4ZbAAAA:8 a=VwQbUJbxAAAA:8 a=1XWaLZrsAAAA:8 a=LrvgwbZ2T81xXpV5F8gA:9
 a=CjuIK1q_8ugA:10 a=HkZW87K1Qel5hWWM3VKY:22
X-Proofpoint-GUID: LmR2dl0N_j-fvnvwroGwmxlgl3Y8ajtz
X-Proofpoint-ORIG-GUID: LmR2dl0N_j-fvnvwroGwmxlgl3Y8ajtz
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMyBTYWx0ZWRfX+gp9W21Tc1iw
 Y4H8Ufrxes9HRHiLAwQ93SHRr5ZdDk0porjXK79A94KF+7dYakWfX/hPio731OzQZwKU8gXY/3+
 sVmfmQ1Qggr3MhBOkylnB6e6XE1OUlEHpzXZm8ebiKl/ZaP3DG1eyH4nZRfM3SzUxv5/7UtI0Qv
 AjYlRcgroNREMjQWTsNeJkffIAGmHSSM9AO5yMYWYQYxVQHPsCZ5qXnM6xGPXDFzK6jpiWFYtRV
 /+nPUg8ycztJQ7waWXo9JQfT72VsxNxxf9KML9ensm3b9Tao3qlQNleCuZWA4/5t5ZYyjj25ItA
 KNduk/0FSm4vh6Q2QmGzxe5st3gn8BSi8ZLvHofKIysUU65XrR7SlE+MkkfC4vZbYrrD4TG85YP
 ThPyg/Ty

On Mon, Sep 15, 2025 at 09:36:35AM -0700, Kalesh Singh wrote:
> A mechanical rename of the mm_struct->map_count field to
> vma_count; no functional change is intended.
>
> The name "map_count" is ambiguous within the memory management subsystem,
> as it can be confused with the folio/page->_mapcount field, which tracks
> PTE references.
>
> The new name, vma_count, is more precise as this field has always
> counted the number of vm_area_structs associated with an mm_struct.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: David Hildenbrand <david@redhat.com>
> Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>
> Cc: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> Cc: Mike Rapoport <rppt@kernel.org>
> Cc: Minchan Kim <minchan@kernel.org>
> Cc: Pedro Falcato <pfalcato@suse.de>
> Signed-off-by: Kalesh Singh <kaleshsingh@google.com>

Yeah this is nice thanks, LGTM so:

Reviewed-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>

One small comment below, but I think that change can wait for another series
probably.

> ---
>
>  Changes in v2:
>   - map_count is easily confused with _mapcount rename to vma_count, per David
>
>  fs/binfmt_elf.c                  |  2 +-
>  fs/coredump.c                    |  2 +-
>  include/linux/mm_types.h         |  2 +-
>  kernel/fork.c                    |  2 +-
>  mm/debug.c                       |  2 +-
>  mm/mmap.c                        |  6 +++---
>  mm/nommu.c                       |  6 +++---
>  mm/vma.c                         | 24 ++++++++++++------------
>  tools/testing/vma/vma.c          | 32 ++++++++++++++++----------------
>  tools/testing/vma/vma_internal.h |  6 +++---
>  10 files changed, 42 insertions(+), 42 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 264fba0d44bd..52449dec12cb 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -1643,7 +1643,7 @@ static int fill_files_note(struct memelfnote *note, struct coredump_params *cprm
>  	data[0] = count;
>  	data[1] = PAGE_SIZE;
>  	/*
> -	 * Count usually is less than mm->map_count,
> +	 * Count usually is less than mm->vma_count,
>  	 * we need to move filenames down.
>  	 */
>  	n = cprm->vma_count - count;
> diff --git a/fs/coredump.c b/fs/coredump.c
> index 60bc9685e149..8881459c53d9 100644
> --- a/fs/coredump.c
> +++ b/fs/coredump.c
> @@ -1731,7 +1731,7 @@ static bool dump_vma_snapshot(struct coredump_params *cprm)
>
>  	cprm->vma_data_size = 0;
>  	gate_vma = get_gate_vma(mm);
> -	cprm->vma_count = mm->map_count + (gate_vma ? 1 : 0);
> +	cprm->vma_count = mm->vma_count + (gate_vma ? 1 : 0);
>
>  	cprm->vma_meta = kvmalloc_array(cprm->vma_count, sizeof(*cprm->vma_meta), GFP_KERNEL);
>  	if (!cprm->vma_meta) {
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 08bc2442db93..4343be2f9e85 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -1020,7 +1020,7 @@ struct mm_struct {
>  #ifdef CONFIG_MMU
>  		atomic_long_t pgtables_bytes;	/* size of all page tables */
>  #endif
> -		int map_count;			/* number of VMAs */
> +		int vma_count;			/* number of VMAs */
>
>  		spinlock_t page_table_lock; /* Protects page tables and some
>  					     * counters
> diff --git a/kernel/fork.c b/kernel/fork.c
> index c4ada32598bd..8fcbbf947579 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1037,7 +1037,7 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
>  	mmap_init_lock(mm);
>  	INIT_LIST_HEAD(&mm->mmlist);
>  	mm_pgtables_bytes_init(mm);
> -	mm->map_count = 0;
> +	mm->vma_count = 0;
>  	mm->locked_vm = 0;
>  	atomic64_set(&mm->pinned_vm, 0);
>  	memset(&mm->rss_stat, 0, sizeof(mm->rss_stat));
> diff --git a/mm/debug.c b/mm/debug.c
> index b4388f4dcd4d..40fc9425a84a 100644
> --- a/mm/debug.c
> +++ b/mm/debug.c
> @@ -204,7 +204,7 @@ void dump_mm(const struct mm_struct *mm)
>  		mm->pgd, atomic_read(&mm->mm_users),
>  		atomic_read(&mm->mm_count),
>  		mm_pgtables_bytes(mm),
> -		mm->map_count,
> +		mm->vma_count,
>  		mm->hiwater_rss, mm->hiwater_vm, mm->total_vm, mm->locked_vm,
>  		(u64)atomic64_read(&mm->pinned_vm),
>  		mm->data_vm, mm->exec_vm, mm->stack_vm,
> diff --git a/mm/mmap.c b/mm/mmap.c
> index af88ce1fbb5f..c6769394a174 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -1308,7 +1308,7 @@ void exit_mmap(struct mm_struct *mm)
>  		vma = vma_next(&vmi);
>  	} while (vma && likely(!xa_is_zero(vma)));
>
> -	BUG_ON(count != mm->map_count);
> +	BUG_ON(count != mm->vma_count);

Be nice to switch this to a WARN_ON_ONCE()... think David mentioned it though.

But maybe not one for this series...

>
>  	trace_exit_mmap(mm);
>  destroy:
> @@ -1517,7 +1517,7 @@ static int sysctl_max_map_count __read_mostly = DEFAULT_MAX_MAP_COUNT;
>   */
>  int vma_count_remaining(const struct mm_struct *mm)
>  {
> -	const int map_count = mm->map_count;
> +	const int map_count = mm->vma_count;
>  	const int max_count = sysctl_max_map_count;
>
>  	return (max_count > map_count) ? (max_count - map_count) : 0;
> @@ -1828,7 +1828,7 @@ __latent_entropy int dup_mmap(struct mm_struct *mm, struct mm_struct *oldmm)
>  		 */
>  		vma_iter_bulk_store(&vmi, tmp);
>
> -		mm->map_count++;
> +		mm->vma_count++;
>
>  		if (tmp->vm_ops && tmp->vm_ops->open)
>  			tmp->vm_ops->open(tmp);
> diff --git a/mm/nommu.c b/mm/nommu.c
> index dd75f2334812..9ab2e5ca736d 100644
> --- a/mm/nommu.c
> +++ b/mm/nommu.c
> @@ -576,7 +576,7 @@ static void setup_vma_to_mm(struct vm_area_struct *vma, struct mm_struct *mm)
>
>  static void cleanup_vma_from_mm(struct vm_area_struct *vma)
>  {
> -	vma->vm_mm->map_count--;
> +	vma->vm_mm->vma_count--;
>  	/* remove the VMA from the mapping */
>  	if (vma->vm_file) {
>  		struct address_space *mapping;
> @@ -1198,7 +1198,7 @@ unsigned long do_mmap(struct file *file,
>  		goto error_just_free;
>
>  	setup_vma_to_mm(vma, current->mm);
> -	current->mm->map_count++;
> +	current->mm->vma_count++;
>  	/* add the VMA to the tree */
>  	vma_iter_store_new(&vmi, vma);
>
> @@ -1366,7 +1366,7 @@ static int split_vma(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	setup_vma_to_mm(vma, mm);
>  	setup_vma_to_mm(new, mm);
>  	vma_iter_store_new(vmi, new);
> -	mm->map_count++;
> +	mm->vma_count++;
>  	return 0;
>
>  err_vmi_preallocate:
> diff --git a/mm/vma.c b/mm/vma.c
> index df0e8409f63d..64f4e7c867c3 100644
> --- a/mm/vma.c
> +++ b/mm/vma.c
> @@ -352,7 +352,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>  		 * (it may either follow vma or precede it).
>  		 */
>  		vma_iter_store_new(vmi, vp->insert);
> -		mm->map_count++;
> +		mm->vma_count++;
>  	}
>
>  	if (vp->anon_vma) {
> @@ -383,7 +383,7 @@ static void vma_complete(struct vma_prepare *vp, struct vma_iterator *vmi,
>  		}
>  		if (vp->remove->anon_vma)
>  			anon_vma_merge(vp->vma, vp->remove);
> -		mm->map_count--;
> +		mm->vma_count--;
>  		mpol_put(vma_policy(vp->remove));
>  		if (!vp->remove2)
>  			WARN_ON_ONCE(vp->vma->vm_end < vp->remove->vm_end);
> @@ -683,13 +683,13 @@ void validate_mm(struct mm_struct *mm)
>  		}
>  #endif
>  		/* Check for a infinite loop */
> -		if (++i > mm->map_count + 10) {
> +		if (++i > mm->vma_count + 10) {
>  			i = -1;
>  			break;
>  		}
>  	}
> -	if (i != mm->map_count) {
> -		pr_emerg("map_count %d vma iterator %d\n", mm->map_count, i);
> +	if (i != mm->vma_count) {
> +		pr_emerg("vma_count %d vma iterator %d\n", mm->vma_count, i);
>  		bug = 1;
>  	}
>  	VM_BUG_ON_MM(bug, mm);
> @@ -1266,7 +1266,7 @@ static void vms_complete_munmap_vmas(struct vma_munmap_struct *vms,
>  	struct mm_struct *mm;
>
>  	mm = current->mm;
> -	mm->map_count -= vms->vma_count;
> +	mm->vma_count -= vms->vma_count;
>  	mm->locked_vm -= vms->locked_vm;
>  	if (vms->unlock)
>  		mmap_write_downgrade(mm);
> @@ -1340,14 +1340,14 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  	if (vms->start > vms->vma->vm_start) {
>
>  		/*
> -		 * Make sure that map_count on return from munmap() will
> +		 * Make sure that vma_count on return from munmap() will
>  		 * not exceed its limit; but let map_count go just above
>  		 * its limit temporarily, to help free resources as expected.
>  		 */
>  		if (vms->end < vms->vma->vm_end &&
>  		    !vma_count_remaining(vms->vma->vm_mm)) {
>  			error = -ENOMEM;
> -			goto map_count_exceeded;
> +			goto vma_count_exceeded;
>  		}
>
>  		/* Don't bother splitting the VMA if we can't unmap it anyway */
> @@ -1461,7 +1461,7 @@ static int vms_gather_munmap_vmas(struct vma_munmap_struct *vms,
>  modify_vma_failed:
>  	reattach_vmas(mas_detach);
>  start_split_failed:
> -map_count_exceeded:
> +vma_count_exceeded:
>  	return error;
>  }
>
> @@ -1795,7 +1795,7 @@ int vma_link(struct mm_struct *mm, struct vm_area_struct *vma)
>  	vma_start_write(vma);
>  	vma_iter_store_new(&vmi, vma);
>  	vma_link_file(vma);
> -	mm->map_count++;
> +	mm->vma_count++;
>  	validate_mm(mm);
>  	return 0;
>  }
> @@ -2495,7 +2495,7 @@ static int __mmap_new_vma(struct mmap_state *map, struct vm_area_struct **vmap)
>  	/* Lock the VMA since it is modified after insertion into VMA tree */
>  	vma_start_write(vma);
>  	vma_iter_store_new(vmi, vma);
> -	map->mm->map_count++;
> +	map->mm->vma_count++;
>  	vma_link_file(vma);
>
>  	/*
> @@ -2810,7 +2810,7 @@ int do_brk_flags(struct vma_iterator *vmi, struct vm_area_struct *vma,
>  	if (vma_iter_store_gfp(vmi, vma, GFP_KERNEL))
>  		goto mas_store_fail;
>
> -	mm->map_count++;
> +	mm->vma_count++;
>  	validate_mm(mm);
>  out:
>  	perf_event_mmap(vma);
> diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
> index 656e1c75b711..69fa7d14a6c2 100644
> --- a/tools/testing/vma/vma.c
> +++ b/tools/testing/vma/vma.c
> @@ -261,7 +261,7 @@ static int cleanup_mm(struct mm_struct *mm, struct vma_iterator *vmi)
>  	}
>
>  	mtree_destroy(&mm->mm_mt);
> -	mm->map_count = 0;
> +	mm->vma_count = 0;
>  	return count;
>  }
>
> @@ -500,7 +500,7 @@ static bool test_merge_new(void)
>  	INIT_LIST_HEAD(&vma_d->anon_vma_chain);
>  	list_add(&dummy_anon_vma_chain_d.same_vma, &vma_d->anon_vma_chain);
>  	ASSERT_FALSE(merged);
> -	ASSERT_EQ(mm.map_count, 4);
> +	ASSERT_EQ(mm.vma_count, 4);
>
>  	/*
>  	 * Merge BOTH sides.
> @@ -519,7 +519,7 @@ static bool test_merge_new(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 3);
> +	ASSERT_EQ(mm.vma_count, 3);
>
>  	/*
>  	 * Merge to PREVIOUS VMA.
> @@ -536,7 +536,7 @@ static bool test_merge_new(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 3);
> +	ASSERT_EQ(mm.vma_count, 3);
>
>  	/*
>  	 * Merge to NEXT VMA.
> @@ -555,7 +555,7 @@ static bool test_merge_new(void)
>  	ASSERT_EQ(vma->vm_pgoff, 6);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 3);
> +	ASSERT_EQ(mm.vma_count, 3);
>
>  	/*
>  	 * Merge BOTH sides.
> @@ -573,7 +573,7 @@ static bool test_merge_new(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 2);
> +	ASSERT_EQ(mm.vma_count, 2);
>
>  	/*
>  	 * Merge to NEXT VMA.
> @@ -591,7 +591,7 @@ static bool test_merge_new(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0xa);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 2);
> +	ASSERT_EQ(mm.vma_count, 2);
>
>  	/*
>  	 * Merge BOTH sides.
> @@ -608,7 +608,7 @@ static bool test_merge_new(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_EQ(vma->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 1);
> +	ASSERT_EQ(mm.vma_count, 1);
>
>  	/*
>  	 * Final state.
> @@ -967,7 +967,7 @@ static bool test_vma_merge_new_with_close(void)
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_EQ(vma->vm_ops, &vm_ops);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 2);
> +	ASSERT_EQ(mm.vma_count, 2);
>
>  	cleanup_mm(&mm, &vmi);
>  	return true;
> @@ -1017,7 +1017,7 @@ static bool test_merge_existing(void)
>  	ASSERT_EQ(vma->vm_pgoff, 2);
>  	ASSERT_TRUE(vma_write_started(vma));
>  	ASSERT_TRUE(vma_write_started(vma_next));
> -	ASSERT_EQ(mm.map_count, 2);
> +	ASSERT_EQ(mm.vma_count, 2);
>
>  	/* Clear down and reset. */
>  	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> @@ -1045,7 +1045,7 @@ static bool test_merge_existing(void)
>  	ASSERT_EQ(vma_next->vm_pgoff, 2);
>  	ASSERT_EQ(vma_next->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma_next));
> -	ASSERT_EQ(mm.map_count, 1);
> +	ASSERT_EQ(mm.vma_count, 1);
>
>  	/* Clear down and reset. We should have deleted vma. */
>  	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> @@ -1079,7 +1079,7 @@ static bool test_merge_existing(void)
>  	ASSERT_EQ(vma->vm_pgoff, 6);
>  	ASSERT_TRUE(vma_write_started(vma_prev));
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 2);
> +	ASSERT_EQ(mm.vma_count, 2);
>
>  	/* Clear down and reset. */
>  	ASSERT_EQ(cleanup_mm(&mm, &vmi), 2);
> @@ -1108,7 +1108,7 @@ static bool test_merge_existing(void)
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
>  	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma_prev));
> -	ASSERT_EQ(mm.map_count, 1);
> +	ASSERT_EQ(mm.vma_count, 1);
>
>  	/* Clear down and reset. We should have deleted vma. */
>  	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> @@ -1138,7 +1138,7 @@ static bool test_merge_existing(void)
>  	ASSERT_EQ(vma_prev->vm_pgoff, 0);
>  	ASSERT_EQ(vma_prev->anon_vma, &dummy_anon_vma);
>  	ASSERT_TRUE(vma_write_started(vma_prev));
> -	ASSERT_EQ(mm.map_count, 1);
> +	ASSERT_EQ(mm.vma_count, 1);
>
>  	/* Clear down and reset. We should have deleted prev and next. */
>  	ASSERT_EQ(cleanup_mm(&mm, &vmi), 1);
> @@ -1540,7 +1540,7 @@ static bool test_merge_extend(void)
>  	ASSERT_EQ(vma->vm_end, 0x4000);
>  	ASSERT_EQ(vma->vm_pgoff, 0);
>  	ASSERT_TRUE(vma_write_started(vma));
> -	ASSERT_EQ(mm.map_count, 1);
> +	ASSERT_EQ(mm.vma_count, 1);
>
>  	cleanup_mm(&mm, &vmi);
>  	return true;
> @@ -1652,7 +1652,7 @@ static bool test_mmap_region_basic(void)
>  			     0x24d, NULL);
>  	ASSERT_EQ(addr, 0x24d000);
>
> -	ASSERT_EQ(mm.map_count, 2);
> +	ASSERT_EQ(mm.vma_count, 2);
>
>  	for_each_vma(vmi, vma) {
>  		if (vma->vm_start == 0x300000) {
> diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
> index 52cd7ddc73f4..15525b86145d 100644
> --- a/tools/testing/vma/vma_internal.h
> +++ b/tools/testing/vma/vma_internal.h
> @@ -251,7 +251,7 @@ struct mutex {};
>
>  struct mm_struct {
>  	struct maple_tree mm_mt;
> -	int map_count;			/* number of VMAs */
> +	int vma_count;			/* number of VMAs */
>  	unsigned long total_vm;	   /* Total pages mapped */
>  	unsigned long locked_vm;   /* Pages that have PG_mlocked set */
>  	unsigned long data_vm;	   /* VM_WRITE & ~VM_SHARED & ~VM_STACK */
> @@ -1520,10 +1520,10 @@ static inline vm_flags_t ksm_vma_flags(const struct mm_struct *, const struct fi
>  /* Helper to get VMA count capacity */
>  static int vma_count_remaining(const struct mm_struct *mm)
>  {
> -	const int map_count = mm->map_count;
> +	const int vma_count = mm->vma_count;
>  	const int max_count = sysctl_max_map_count;
>
> -	return (max_count > map_count) ? (max_count - map_count) : 0;
> +	return (max_count > vma_count) ? (max_count - vma_count) : 0;
>  }
>
>  #endif	/* __MM_VMA_INTERNAL_H */
> --
> 2.51.0.384.g4c02a37b29-goog
>

