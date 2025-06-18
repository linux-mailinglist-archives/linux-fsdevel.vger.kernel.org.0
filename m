Return-Path: <linux-fsdevel+bounces-52109-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E3D3ADF719
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 21:46:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9024C7ADAB0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Jun 2025 19:44:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8F2219E8D;
	Wed, 18 Jun 2025 19:46:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YF1S2BcC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="aQkWmmW+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F70213E85;
	Wed, 18 Jun 2025 19:46:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750275963; cv=fail; b=iQ444M3L6CKlqvk6qzTOgfVuUA2fdCEQlsf4EEOHSZVZPHQ+6740lCFwjL04CiYu69lL9wIa89GeAK8XQuu0YPLVFjdLscQaf5Ml/aSA8hl2In+9f3xGsrtQzgke9zhAI7BF1t6O2I+3JA2zecNqucof4XY/x824+XbVD4Y0Ldk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750275963; c=relaxed/simple;
	bh=2R9ErOZHQkV1IzP47cAAOdv60Y9u9YB7HZocqQg0WMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QqRdTmTehF8JYUyaHsHVYrSQV/Zu0u6WE0XKpzYiCJa8hi/w39vaX66P9qi7hq4v8CWE/3IbyViGdXFZpsx5PvFb6jXotSp4KzPdr7CVuVNMQEn+ovCeHXxL7X45SvKlY58adV3Arfs7HGPUP5Kyxld76NvmAzvge9A3uRCwrgo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YF1S2BcC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=aQkWmmW+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55IHfa3F020631;
	Wed, 18 Jun 2025 19:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+snDW9vrAMfrxdGryvDOSSN59VnKS/fh6c3ddOAkMTs=; b=
	YF1S2BcCKsRXdBS7dBh2Zp2nz4k5wnLoPCauO6GJMZ2jumkTPrZtXablVN2uQWzK
	gZ+CXjx5GtabaVPne0NnwitWXzqz40Pcc87RtNdPFxZbPBF2ZJo4IfWWOjxCrPlX
	o3478csFCC9wxoGgLGJsOZ/pGo9y5EpguCDbGYF7xg9+CavJF1yaJEiDBgm8Klm8
	mv27SylsfnRJCxWtzngc9AW5vG+HC9uv1m1iQt3dOlhs8ngcNusaPtEGWAfor+0w
	lg1TESfOJLJYDlLjBae68jyqUu2nVTm1yFekTYhInciJPcMBxueQhvyvhKj0eIqB
	MQCWHBHKSvzZsFO0IS+pwQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 478yp4rmq3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55IIbnNA035067;
	Wed, 18 Jun 2025 19:43:28 GMT
Received: from ch5pr02cu005.outbound.protection.outlook.com (mail-northcentralusazon11012065.outbound.protection.outlook.com [40.107.200.65])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 478yhau6sk-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Jun 2025 19:43:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nIbCH36Fz1ZaG/uokSyE3VKtsnBSH0BltjM1l5/ihWIquttICyuzNBbicUePN6w5Npho6ZJDmY59D0nl0c6WrsyRkip+h6/25LG9epVUtP+Lk6JIL3tN3gAQcuR6jUVzI/KqQR09OaD+t7WVnx/lVwOJByrKgWKWcRpex6vzzTYWAcznYz8lSu13NZ9omLA2zdSx4idT+BnC66kU00wLYQ7REAyB2usf2aq1GiR5EQMslcAFoYoQNRNh0SAa5KE0C6J9DMxudxIoS+q3ROwEpg6gnDMG96e4xjthzKIuIweqN2Ec2ALquOhQnsgTHqBTWmcAR0e8ZL7qvzvn+48eSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+snDW9vrAMfrxdGryvDOSSN59VnKS/fh6c3ddOAkMTs=;
 b=an0ldImlEwG+JFRxYkAJDayC3Q9ebArs7qLfqA4JDN0CnbWxzGV6A5NAjMAC9LwnapXjI0zYgAu0h78WYe5TRwshWIYpS9qMu35+ohlkJU4MuMhsrf28PS477r8XvLQMzPCsiMwXPMEZl5vikM/6LNQlXzuib0D5wk+NYAQ2u2UM+W4Am4dTnxWjzCkBgN7ULhPoUI6Ll/k/E8qX0EXPsAsfY6lwOwU+S2V70URRQa81N6ajg9kI9GfANzpNNFUOWvHbqA+v3+lqhtIQJRKL82zX6MVYk2OR/wGsCIp2CB/lfm9fFw1u9ReJUdPLz26yDqulih+ijPbPeUd3LKJtHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+snDW9vrAMfrxdGryvDOSSN59VnKS/fh6c3ddOAkMTs=;
 b=aQkWmmW+pVVByw2nhVHsNvyL+QGhJ+PvEwQfdOz/zvGWlsFLBFRN26SNr6BBM9p6kaBja1HMAVasH763hQnX4Ip7DJT2zX1/qC9qQ8wKU/NBvE0G+2WOHQzqoB0XizPhmAHWOE7grOM2+p/IFojbyCzeGX+Rip8lz37jxuIRWg8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DM4PR10MB6717.namprd10.prod.outlook.com (2603:10b6:8:113::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.29; Wed, 18 Jun
 2025 19:43:22 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%6]) with mapi id 15.20.8857.019; Wed, 18 Jun 2025
 19:43:22 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Rik van Riel <riel@surriel.com>, Harry Yoo <harry.yoo@oracle.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Muchun Song <muchun.song@linux.dev>,
        Oscar Salvador <osalvador@suse.de>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Johannes Weiner <hannes@cmpxchg.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-sgx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        nvdimm@lists.linux.dev, linux-trace-kernel@vger.kernel.org
Subject: [PATCH 3/3] mm: update architecture and driver code to use vm_flags_t
Date: Wed, 18 Jun 2025 20:42:54 +0100
Message-ID: <b6eb1894abc5555ece80bb08af5c022ef780c8bc.1750274467.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
References: <cover.1750274467.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO0P265CA0004.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:355::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DM4PR10MB6717:EE_
X-MS-Office365-Filtering-Correlation-Id: ac21aa2a-754e-4fad-246e-08ddaea06204
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?yBLeylSxtyY4ckSHDxCLLcYn8OWitmc5Yy052i4Dm+E8PxzXKK/EBpWbZ2je?=
 =?us-ascii?Q?7XZDi25W3BML50yPMBGP1vdw69bijUSmSqroV8vBSh1GTiabU/DDv0uVB+PR?=
 =?us-ascii?Q?VFhzUwg7IOedRdkHpNLQMNmt7Y1E3L4Oewd/vyXwB9Dp/SYQWg8NVorqXtC1?=
 =?us-ascii?Q?XxygAnnAn0oxaxxXBkK1MrwLz30NWxvMlLOBXTVNiEmE+OUo1aP/LKLmqZQj?=
 =?us-ascii?Q?pjVzOsAaS1RaAQ9SZ2jTR93HrV7Jhv3Py1oMAD5VaVJQbvV8McwRLrwJoynf?=
 =?us-ascii?Q?Kmgrn+qi9HFNi+rmr0NJknDhpnkXJMRYW4ED3yoWt0uKDcq12DK1b/oaUQn3?=
 =?us-ascii?Q?VfhwRmaNC9/nHohUbIF1BpRjDJRtVlpaJR8jjvZc1QjCmzJehc9horI2Hebv?=
 =?us-ascii?Q?DginkG+Ndd8Lm55XgJ6wJ9++Z5+pJ6L8Y6Vv1dWaVeko+8yOmPcdiWngnnSr?=
 =?us-ascii?Q?8GFc9Yo+Koxyd3nOtZfH3HfOzeCDIxbD1jyRINfhcdG57Fsvdijh1WHRsHUO?=
 =?us-ascii?Q?1HgYbKeITBzP+9FgZgrRx/RoDp0ihU74XYsB0bR0GQuLrVekpkP3893HAESt?=
 =?us-ascii?Q?ElR4G5LD19as1weH+ni5OYZuaoaSoAZc7m9+ny2YpA+ebA4a6aCYqGq8UNtY?=
 =?us-ascii?Q?1vz/abIWIrSj4EbQpzEGi5Fnecg/1z02btRj9vTbBQQTdSvAjRCpW+Kg1cH8?=
 =?us-ascii?Q?oSxb4gB5YOO0WgpIc3I60Ni0b+UzepulPFgL7xlALFjENu6N1zzD75J/6kyh?=
 =?us-ascii?Q?9m9fY5M5TylCTb3BLsecGccrFUh4+dyHa2HG7ZwwS1E+lsDJrXjTpJzZrIk4?=
 =?us-ascii?Q?VCQNmHdPs+u2A3EawYTQ5fBzYK2TVYc/p5PwqskMte7B/NKBF6Bw+YtNuHxp?=
 =?us-ascii?Q?M5qMprI4rVoy82xkD3YWce2KTK5geKxT2q9vTu28Di3ZRCEdtcT4gVC3pXiG?=
 =?us-ascii?Q?atYRUKaco+0NCrHLq9pKlhkqpX7Kj4u0VcMVjOtPN/iPiKfXLVvahr+yoeGW?=
 =?us-ascii?Q?unkPdyjoZExaG/DpE4VTqzGirHUbYkHbAJKeONuDtfgFSPFtsJ4Tte3OAjfW?=
 =?us-ascii?Q?yGdKK4kd8Oqlyt63Ujzi542Oy09yvLQTrOGThXvUIIcBXwu/O5M1ij4EZapo?=
 =?us-ascii?Q?CP0W1CokB3Vdk6AmkaCLCozmf/6XTW/JQLYqweLhtyVlCy1gE7BTxQwrhbQT?=
 =?us-ascii?Q?2xORqOqJVVpO/YFataQruWt+H0mJJz9vTPKlpM2t7ozccd+d8JTnR/Qi4xBn?=
 =?us-ascii?Q?2ax6FPADvb0nrNu6c4+zKLIaCsQ9yMFR6LbfCZFm6TaRQvKAOo7sK7N8tjdl?=
 =?us-ascii?Q?xAi6GhaIKuXQT5m+Tgwn1QG4+YhcY9Rw5vApGIj7+F9JzmzUvT8UBlCCynAA?=
 =?us-ascii?Q?c6dToxUkaegeXFrQVfWsbdC5IMvJKLIj9K7lVynaLlzDMtNnoVefafFC4BKh?=
 =?us-ascii?Q?Off83KUT1n8=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sFIl9GzxxjgRuHEERcTnsvXUiPWPqN8D/fuV+eOvEH0HGfsS8+4XYMO0aowi?=
 =?us-ascii?Q?YFFRAX5jowqfwF4zNgX8iRLU8Lao+oMDUj+RO56FQPJyARDIUYDHTopRaJ8h?=
 =?us-ascii?Q?05S9slT/C9QMBJ71m5/+Bq3vKoiW5hylvioVBpbwwq84HTX7gGqKaeoW6gE6?=
 =?us-ascii?Q?cM0EHGUaY0mr3Lk8uQnIdomnqlzl9Bf0eKFlvBIMnogQX8a2Vv3oStJ4zkk1?=
 =?us-ascii?Q?M0jWI7fSOjNbZ/npqZ3BYXaX+6KLyQAWN16GA8deIhhqqTohlBrdvgCCrYm5?=
 =?us-ascii?Q?seATJoHHFs8QEVOlPobURq55H2sZKR2Ldkoz8j7szRxcmU1ezGo8UasuF1Ry?=
 =?us-ascii?Q?nnt25sTxk+04f9FYiEsyB4ItCqhAHM2jPZWy/7rHFBqcub6bTOoBM+WaAN4g?=
 =?us-ascii?Q?tgm91JWqXdUQ2BYsN38IawlTvUjcIhvEXtAPFX483/273cJgOgK8eHiUdV4g?=
 =?us-ascii?Q?OjMf5UXHbx2WTEFRNI0Ih9MDlSAkB7cacUY3LeKnd0EuUN+Qq7wxLSaaW531?=
 =?us-ascii?Q?sr7+qnaorPSunRh/+6uSeIz4YmbPyYBrA9bQTG5UaYdU+voFm0NgOW2kbgnP?=
 =?us-ascii?Q?Ew7W+d3TyiR3Bhz7XhqFkmgKZLtg90u4T17IyyBDnk3xEdcv44NVvKpyS6eg?=
 =?us-ascii?Q?CwYjzH5ZRFkrhhRlWLeasvRaQ6nT/nwHMUDgbkPh/umeVi1uSRuhkxAjsu32?=
 =?us-ascii?Q?XBVsqcJenRfoQhGvMKcVLkfTNorBlYC8/7fW2Tubo1FQsA1Rq5MjTzFnQ9xo?=
 =?us-ascii?Q?q6mtL2xLaj0AHbMrEwtN/sFc+NQxw64qE3gKM4CJKYaN72rJYNQJGWgp8kNe?=
 =?us-ascii?Q?3uJ3RNFza1A0jMBvYBc5R6Lz2OzXCQWeFDCOL3+tBsRP/zAr+XSdQuY7ZOJ/?=
 =?us-ascii?Q?BuYkOtQdzVpvu4TVWCtlWMJXug7+YsFfNsVesxXfoFiE/yxvWKPpwGE5Z60n?=
 =?us-ascii?Q?al4qwOz7GOcSyRzlMznOrfYVBFn6FasqzThA6A+/S01j7DUjbMQo9xjCVMl6?=
 =?us-ascii?Q?aJjkXMZw/1UOizsrqK2nLz9Z2HcctvON2jTBV5eOXtp6POQ4bOJ25NYEi/k0?=
 =?us-ascii?Q?XLA6LQztoH2qBi8ayq8qUrT/89ngoHZu3622+X4zDfZfyVXOvwHdyUtkJueN?=
 =?us-ascii?Q?QqzNUXzc+x4zqq28RNx1KA3gKotjoKUDpM8uZ75M7noXdCVt72bZuBfRt5L9?=
 =?us-ascii?Q?XuW73f9xUmdycX0dROyrp18aU3Ipu3GfleU1vEVu26DDiGQnlRs6sRTzuELL?=
 =?us-ascii?Q?JiTZs0mYG52okjXXXEhSzaI3s8Msznj2Fq1mS2rkUnh2IfTHACl6jyLxl8D3?=
 =?us-ascii?Q?wwUXR7Ttp8ADd36fLHObXkWXFz2DTN8DGWnUihQ+8MBQLhzQyi8n9mQWs/YK?=
 =?us-ascii?Q?eITGOcMLByXY3hV6LaCW+HTc638bWIGUdCSuSB2J4ytJyfJeiphLLP1mWmIO?=
 =?us-ascii?Q?3GVITuwsz8Os90eClMkGJwYT1pS4hftIueRdtyy1u2YxolTCz/0LVulzmIAy?=
 =?us-ascii?Q?qkPhe2UwVNzUycNy9oApD7Qw75IHCLnBw4qYTFBv758hvImErz+Uc2obajF2?=
 =?us-ascii?Q?yEbGod2vXz/kCETYDXces9y55GUeWufPXpvi3C7mgEoVGapUvoJYHeuUtODq?=
 =?us-ascii?Q?Xw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	I0cd15zFxw04jwbe7XR2odXTEVVZfuVc+ndyn02e2FWqmBQhnHNk/+hVmKyzDbneUC83NSlB17qhjslFS03h/4rp87xvOWP4Ho0/S2I6zXXiSkcqNXa85tL516iZQAHfgWjiqugiyvGBlG2G1eg9B40ysBnhuHT65BiGsf1v3B8gASrRcFQFN+mnOy5893bAzuyQcIrE8RKArNwKdGYC/hxUhn0J/1kJsSPl0eg4bHwIjv2OWSn/UMF0462CIbKy0tw7ZKXtadiUeLmrAG6HRoW/wCSZObBNv1fOrsBim2qD0dYXgSLJoVx9MqVvbwslnQhkYQRaA3Kaj2kK/cT/JDJmjiHYcwCxKhVI3ntSCqDADqcVJlgLvBrj1GEqDuoyvVALMfBkidsFDIyjoqQajffjv0OqUnUrRUY7z5Z2IlUUKDHMkTPWAuxiP+WQJGHgAvEjLInG7MLTXbULXAQF6Gw9VCHOQNsdyqRK1YU2ICHsfJ+Nsfd2Z3670uaQKVFphCclUO9TIEVsp8r7o5gzvvUDvJjdvblAXBPKPeUt3QYsIkw+gmrteEFHvz5b5ghzS1RaetfEfO1z4WIBULMf+GH10rETmJfagG5yDi3GHnQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac21aa2a-754e-4fad-246e-08ddaea06204
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2025 19:43:21.9821
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WmrODjMv7w84QmPBbuav2EnSoNP4nzweS+Zm0ohXz7jD8uZS0/WrjG+rdkgfU4kpP/7UMLoxaOVdCu46L6+mMucVb9XBjQndJohO9PmO4nE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6717
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_05,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 adultscore=0 phishscore=0 suspectscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506180168
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDE2OCBTYWx0ZWRfX0lz1s/Rrz1NV dZaEpSM8KZvKtcc1Wwb6F7SGjP2Nwo1gXajVyo4O15ZcmZ2q975So9qiQRH57GY8wU8Pn2b75SP gel5w62pZhN4fsUNJqyyM4SKFHW2kzGSLDB00xLjiwmJD+b/wMtWK2c8ybj9T6d09T5O6BkdELj
 a7dc453EACvNq5QnKbpyQ0b/tQI3ryuyDIsn9139qblFz1YcgkplO5pxdvn3ya+SCZjkI7swAHg XjWKWiaT1dRzPcc3UWp81c7wCrmHU8Zy6FvuVw9MaLLI9oW7TYoz3je4cpYsV/3B8v2zEjxTGkV DtiYILjelORfOdNdxC38OFfPjpcoIYcxy0eAZFpXNojN8D4p6jR6KM1yHOsVNM8EValzZQ0v+de
 5c65BcpE4JH28o+c668297Cax5po9bf7Z91eVMGBzn5tZmyfW8XfytzDzqdlBA8nGDMzXCsm
X-Authority-Analysis: v=2.4 cv=K5EiHzWI c=1 sm=1 tr=0 ts=685316e1 cx=c_pps a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=KSPAIXy3AxxZGu31Qz0A:9
X-Proofpoint-GUID: Kd221iCLc6u7myuU5Kba9eHugYPIziAP
X-Proofpoint-ORIG-GUID: Kd221iCLc6u7myuU5Kba9eHugYPIziAP

In future we intend to change the vm_flags_t type, so it isn't correct for
architecture and driver code to assume it is unsigned long. Correct this
assumption across the board.

Overall, this patch does not introduce any functional change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/arm/mm/fault.c                |  2 +-
 arch/arm64/include/asm/mman.h      | 10 +++++-----
 arch/arm64/mm/fault.c              |  2 +-
 arch/arm64/mm/mmu.c                |  2 +-
 arch/powerpc/include/asm/mman.h    |  2 +-
 arch/powerpc/include/asm/pkeys.h   |  4 ++--
 arch/powerpc/kvm/book3s_hv_uvmem.c |  2 +-
 arch/sparc/include/asm/mman.h      |  4 ++--
 arch/x86/kernel/cpu/sgx/encl.c     |  8 ++++----
 arch/x86/kernel/cpu/sgx/encl.h     |  2 +-
 tools/testing/vma/vma_internal.h   |  2 +-
 11 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/arch/arm/mm/fault.c b/arch/arm/mm/fault.c
index ab01b51de559..46169fe42c61 100644
--- a/arch/arm/mm/fault.c
+++ b/arch/arm/mm/fault.c
@@ -268,7 +268,7 @@ do_page_fault(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
 	int sig, code;
 	vm_fault_t fault;
 	unsigned int flags = FAULT_FLAG_DEFAULT;
-	unsigned long vm_flags = VM_ACCESS_FLAGS;
+	vm_flags_t vm_flags = VM_ACCESS_FLAGS;
 
 	if (kprobe_page_fault(regs, fsr))
 		return 0;
diff --git a/arch/arm64/include/asm/mman.h b/arch/arm64/include/asm/mman.h
index 21df8bbd2668..8770c7ee759f 100644
--- a/arch/arm64/include/asm/mman.h
+++ b/arch/arm64/include/asm/mman.h
@@ -11,10 +11,10 @@
 #include <linux/shmem_fs.h>
 #include <linux/types.h>
 
-static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+static inline vm_flags_t arch_calc_vm_prot_bits(unsigned long prot,
 	unsigned long pkey)
 {
-	unsigned long ret = 0;
+	vm_flags_t ret = 0;
 
 	if (system_supports_bti() && (prot & PROT_BTI))
 		ret |= VM_ARM64_BTI;
@@ -34,8 +34,8 @@ static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
 }
 #define arch_calc_vm_prot_bits(prot, pkey) arch_calc_vm_prot_bits(prot, pkey)
 
-static inline unsigned long arch_calc_vm_flag_bits(struct file *file,
-						   unsigned long flags)
+static inline vm_flags_t arch_calc_vm_flag_bits(struct file *file,
+						unsigned long flags)
 {
 	/*
 	 * Only allow MTE on anonymous mappings as these are guaranteed to be
@@ -68,7 +68,7 @@ static inline bool arch_validate_prot(unsigned long prot,
 }
 #define arch_validate_prot(prot, addr) arch_validate_prot(prot, addr)
 
-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(vm_flags_t vm_flags)
 {
 	if (system_supports_mte()) {
 		/*
diff --git a/arch/arm64/mm/fault.c b/arch/arm64/mm/fault.c
index ec0a337891dd..24be3e632f79 100644
--- a/arch/arm64/mm/fault.c
+++ b/arch/arm64/mm/fault.c
@@ -549,7 +549,7 @@ static int __kprobes do_page_fault(unsigned long far, unsigned long esr,
 	const struct fault_info *inf;
 	struct mm_struct *mm = current->mm;
 	vm_fault_t fault;
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	unsigned int mm_flags = FAULT_FLAG_DEFAULT;
 	unsigned long addr = untagged_addr(far);
 	struct vm_area_struct *vma;
diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index 8fcf59ba39db..248d96349fd0 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -720,7 +720,7 @@ void mark_rodata_ro(void)
 
 static void __init declare_vma(struct vm_struct *vma,
 			       void *va_start, void *va_end,
-			       unsigned long vm_flags)
+			       vm_flags_t vm_flags)
 {
 	phys_addr_t pa_start = __pa_symbol(va_start);
 	unsigned long size = va_end - va_start;
diff --git a/arch/powerpc/include/asm/mman.h b/arch/powerpc/include/asm/mman.h
index 42a51a993d94..912f78a956a1 100644
--- a/arch/powerpc/include/asm/mman.h
+++ b/arch/powerpc/include/asm/mman.h
@@ -14,7 +14,7 @@
 #include <asm/cpu_has_feature.h>
 #include <asm/firmware.h>
 
-static inline unsigned long arch_calc_vm_prot_bits(unsigned long prot,
+static inline vm_flags_t arch_calc_vm_prot_bits(unsigned long prot,
 		unsigned long pkey)
 {
 #ifdef CONFIG_PPC_MEM_KEYS
diff --git a/arch/powerpc/include/asm/pkeys.h b/arch/powerpc/include/asm/pkeys.h
index 59a2c7dbc78f..28e752138996 100644
--- a/arch/powerpc/include/asm/pkeys.h
+++ b/arch/powerpc/include/asm/pkeys.h
@@ -30,9 +30,9 @@ extern u32 reserved_allocation_mask; /* bits set for reserved keys */
 #endif
 
 
-static inline u64 pkey_to_vmflag_bits(u16 pkey)
+static inline vm_flags_t pkey_to_vmflag_bits(u16 pkey)
 {
-	return (((u64)pkey << VM_PKEY_SHIFT) & ARCH_VM_PKEY_FLAGS);
+	return (((vm_flags_t)pkey << VM_PKEY_SHIFT) & ARCH_VM_PKEY_FLAGS);
 }
 
 static inline int vma_pkey(struct vm_area_struct *vma)
diff --git a/arch/powerpc/kvm/book3s_hv_uvmem.c b/arch/powerpc/kvm/book3s_hv_uvmem.c
index 3a6592a31a10..03f8c34fa0a2 100644
--- a/arch/powerpc/kvm/book3s_hv_uvmem.c
+++ b/arch/powerpc/kvm/book3s_hv_uvmem.c
@@ -393,7 +393,7 @@ static int kvmppc_memslot_page_merge(struct kvm *kvm,
 {
 	unsigned long gfn = memslot->base_gfn;
 	unsigned long end, start = gfn_to_hva(kvm, gfn);
-	unsigned long vm_flags;
+	vm_flags_t vm_flags;
 	int ret = 0;
 	struct vm_area_struct *vma;
 	int merge_flag = (merge) ? MADV_MERGEABLE : MADV_UNMERGEABLE;
diff --git a/arch/sparc/include/asm/mman.h b/arch/sparc/include/asm/mman.h
index af9c10c83dc5..3e4bac33be81 100644
--- a/arch/sparc/include/asm/mman.h
+++ b/arch/sparc/include/asm/mman.h
@@ -28,7 +28,7 @@ static inline void ipi_set_tstate_mcde(void *arg)
 }
 
 #define arch_calc_vm_prot_bits(prot, pkey) sparc_calc_vm_prot_bits(prot)
-static inline unsigned long sparc_calc_vm_prot_bits(unsigned long prot)
+static inline vm_flags_t sparc_calc_vm_prot_bits(unsigned long prot)
 {
 	if (adi_capable() && (prot & PROT_ADI)) {
 		struct pt_regs *regs;
@@ -58,7 +58,7 @@ static inline int sparc_validate_prot(unsigned long prot, unsigned long addr)
 /* arch_validate_flags() - Ensure combination of flags is valid for a
  *	VMA.
  */
-static inline bool arch_validate_flags(unsigned long vm_flags)
+static inline bool arch_validate_flags(vm_flags_t vm_flags)
 {
 	/* If ADI is being enabled on this VMA, check for ADI
 	 * capability on the platform and ensure VMA is suitable
diff --git a/arch/x86/kernel/cpu/sgx/encl.c b/arch/x86/kernel/cpu/sgx/encl.c
index 279148e72459..308dbbae6c6e 100644
--- a/arch/x86/kernel/cpu/sgx/encl.c
+++ b/arch/x86/kernel/cpu/sgx/encl.c
@@ -279,7 +279,7 @@ static struct sgx_encl_page *__sgx_encl_load_page(struct sgx_encl *encl,
 
 static struct sgx_encl_page *sgx_encl_load_page_in_vma(struct sgx_encl *encl,
 						       unsigned long addr,
-						       unsigned long vm_flags)
+						       vm_flags_t vm_flags)
 {
 	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
 	struct sgx_encl_page *entry;
@@ -520,9 +520,9 @@ static void sgx_vma_open(struct vm_area_struct *vma)
  * Return: 0 on success, -EACCES otherwise
  */
 int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
-		     unsigned long end, unsigned long vm_flags)
+		     unsigned long end, vm_flags_t vm_flags)
 {
-	unsigned long vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
+	vm_flags_t vm_prot_bits = vm_flags & VM_ACCESS_FLAGS;
 	struct sgx_encl_page *page;
 	unsigned long count = 0;
 	int ret = 0;
@@ -605,7 +605,7 @@ static int sgx_encl_debug_write(struct sgx_encl *encl, struct sgx_encl_page *pag
  */
 static struct sgx_encl_page *sgx_encl_reserve_page(struct sgx_encl *encl,
 						   unsigned long addr,
-						   unsigned long vm_flags)
+						   vm_flags_t vm_flags)
 {
 	struct sgx_encl_page *entry;
 
diff --git a/arch/x86/kernel/cpu/sgx/encl.h b/arch/x86/kernel/cpu/sgx/encl.h
index f94ff14c9486..8ff47f6652b9 100644
--- a/arch/x86/kernel/cpu/sgx/encl.h
+++ b/arch/x86/kernel/cpu/sgx/encl.h
@@ -101,7 +101,7 @@ static inline int sgx_encl_find(struct mm_struct *mm, unsigned long addr,
 }
 
 int sgx_encl_may_map(struct sgx_encl *encl, unsigned long start,
-		     unsigned long end, unsigned long vm_flags);
+		     unsigned long end, vm_flags_t vm_flags);
 
 bool current_is_ksgxd(void);
 void sgx_encl_release(struct kref *ref);
diff --git a/tools/testing/vma/vma_internal.h b/tools/testing/vma/vma_internal.h
index 7919d7141537..b9eb8c889f96 100644
--- a/tools/testing/vma/vma_internal.h
+++ b/tools/testing/vma/vma_internal.h
@@ -1220,7 +1220,7 @@ static inline void vma_set_page_prot(struct vm_area_struct *vma)
 	WRITE_ONCE(vma->vm_page_prot, vm_page_prot);
 }
 
-static inline bool arch_validate_flags(unsigned long)
+static inline bool arch_validate_flags(vm_flags_t)
 {
 	return true;
 }
-- 
2.49.0


