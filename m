Return-Path: <linux-fsdevel+bounces-59212-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F81BB363C9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A08A3C75
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 13:25:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C201833A03C;
	Tue, 26 Aug 2025 13:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WEXHQUdY";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Y/ACx9Ow"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721C433A00A;
	Tue, 26 Aug 2025 13:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756214630; cv=fail; b=gIJL3gr/gjdAFBpUHqAkC1DMdvpD1GSE2YBRNSP4Lxx1dvXw2VrBGMMfsCgff95iy4QNdaeeWlb7e4YqIU22yD/9PEs5pZUfKUwZOzTUBgGWujM1Grl9VNVq4ZBr2tKrPrRyQq29g5See/FjD9ufJilml2gsDsG7+kPHWLu5jJA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756214630; c=relaxed/simple;
	bh=2Y4PL1tI/dbPGdH7UkR2eWtLjWw34v5VuYN7SswO5jo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=MFTGPxS8VqI17uZGUHNzi8hHdzyBYfb/Z6G7XOwOSZevMMNJlo07gYhBv+FUFWbDdxzg+XjtqBB55pSIm8BxqKhJfngpfTDywO1nVDf48aPsTy7atFlW9JPZDqZ77oRcTZ+8XQUXeVHh0aEtMA5IVfZvsnsxvwdDs+71iWEiJNk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WEXHQUdY; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Y/ACx9Ow; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCGvnl022280;
	Tue, 26 Aug 2025 13:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=SxFckTdieuFeOakgpi
	9zzcn33h4B7NoRrISBil6dsnU=; b=WEXHQUdYj6OlNNTUOg3Lzu9alBV05Wpwg/
	UB3Q9YPqwNsDRZJbLMTedekmpApbDyIUawKskxEl6vPIPFC4pT3gQpJIoltVDGr0
	Ejv3Nn6dJN2gq6iqVt5PIhAnzklVpcZfq97J3eBxSvzxaL4hMJz3+Xchl30jQRII
	onfZ/fWOnkLvBkztEAaYq1Rd25SysVtk22DbCR9cJYGPiQX1KqMm4BNtH/pnSHXK
	W1qDYZxasQX2LFVh7EQNaF2AZsthKWXTactLgT3CyorVTHvNUw0MwhUQJXH4TEUz
	rnYVUr6PY3RfLb4eo+6mI7lYuTWO9fUZC5dJx8debLdnx5S/PcLg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q678vdgw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:22:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCU8QQ018999;
	Tue, 26 Aug 2025 13:22:50 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11on2065.outbound.protection.outlook.com [40.107.220.65])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439kfq1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 13:22:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lt8yn+BDIRxPuB4JASw5QBlobTEanpuuFYyxsXqadydScN+I5fYZaW4DkNOrUmdTQaIFMWjZYO/qO3ktrRwr9mpBC0oZdpTL3jdAZ0h08BI8Nje5IDUHSJ4IibTytN9QvfcD+HMGwyEiXS+DHNrQhP4RaIhhRUdG4hxtg78VXilKX7Qza16Lse1xyZYHCkjs3svzkRBUTlmXsBwzAPKrt+tpElv/ziOgOWNMaiTB1UnQ5TApy4rurX4Z6SO420pB0x5SlZzebNt3bv300L0y/EskHY+cJqcZZ9X9eu8tdDEH5/gN0x6WtwgMgmRFgR5Ypr5ITERRFmWEjHfstKjxiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SxFckTdieuFeOakgpi9zzcn33h4B7NoRrISBil6dsnU=;
 b=C7MQhqcg3cSohxd1l3r528NPmcI7vN9S7uaxcPnaO76Vibj1jokGH4hVR4l79I3feFAi29MU/ut5rmjjqApN3dnjbVy8MXxblP0RA38sayfLFUtnps10QNwnzHsEnu4XvWe+fYprD5SQCWjG/9iKAwdb+4wL9NSejb5qfyf//xAskEPWP8kMwzQfeWLjooe3hzsJWAw1SAFhl80qmXpPseBQYLJqXF7WZ4aTBcZ0yp3PMklMeRofq80INJ0Su6NtRc7Zt4ds1Ip2z87lm9g0RdmUWDZt3gjQcICGuJKbfeVWO8sabdH+He6djQXnTmccun5j86yecQ6yBFS/Ae99pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SxFckTdieuFeOakgpi9zzcn33h4B7NoRrISBil6dsnU=;
 b=Y/ACx9OwslSAKR02OX40QsdIb02Fpo80TzwpQo7BhmLhBY/4JfJaJvp2JF/NyetQa1KpD/TzolAbGhk98pKv/y44lLo0i9K+LCIJWCrQWX2H+6n0Q+zHl/vgBny+dBPw31i8CpCIpEBkgQrwQms2ZpM3yafZ4jGa+FS4IHr2DHg=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH7PR10MB7106.namprd10.prod.outlook.com (2603:10b6:510:268::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 13:22:46 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 13:22:46 +0000
Date: Tue, 26 Aug 2025 14:22:43 +0100
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: David Hildenbrand <david@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Andreas Larsson <andreas@gaisler.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Kees Cook <kees@kernel.org>, Zi Yan <ziy@nvidia.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Xu Xin <xu.xin16@zte.com.cn>,
        Chengming Zhou <chengming.zhou@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeel.butt@linux.dev>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Oleg Nesterov <oleg@redhat.com>, Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>,
        Peter Xu <peterx@redhat.com>, Jann Horn <jannh@google.com>,
        Pedro Falcato <pfalcato@suse.de>, Matthew Wilcox <willy@infradead.org>,
        Mateusz Guzik <mjguzik@gmail.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Subject: Re: [PATCH 10/10] mm: replace mm->flags with bitmap entirely and set
 to 64 bits
Message-ID: <7fe98bec-a750-4005-a308-ae7a7afc0e3b@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <e1f6654e016d36c43959764b01355736c5cbcdf8.1755012943.git.lorenzo.stoakes@oracle.com>
 <c0b20bf5-5224-4aa4-b76e-22c6826c3632@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c0b20bf5-5224-4aa4-b76e-22c6826c3632@redhat.com>
X-ClientProxiedBy: LO4P302CA0005.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::13) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH7PR10MB7106:EE_
X-MS-Office365-Filtering-Correlation-Id: ec6b23ef-f312-4c41-8376-08dde4a3a56b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|7416014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?lxfPLbfbNyhzb/6xq5Kb2UO3M4aIWApfqpL/Xr35e29ncU6gOhZA40qk6IVT?=
 =?us-ascii?Q?ko1mbiTowEBjrv+g8pg6338gC8Z7HrZ1YvJxPiU9Ack+2bMtN1DWxoXqpv1s?=
 =?us-ascii?Q?9QHD9pQInGJu191TNGBf4QLK11Zx7cvaDc7R1IeCsED6Z2l+KpLAct9uBksU?=
 =?us-ascii?Q?R5IzzEC17UFLfHG9fKwuj+M8XqaSeAyaIgjJ+SzqbcgOJwmCOMyFYmqK4elw?=
 =?us-ascii?Q?F60lHacMw3u5C6+8z7dD5XHiQio+88nmlRZaLz53VIvIoG2tR2YWYrwIgVO0?=
 =?us-ascii?Q?dLGvxuDDlOE+GbOxdlVMF4iOWCv9lADVECu8Mz4t7j0/vVXbdR/UcCwqRl9k?=
 =?us-ascii?Q?k7FoqzDWpI1ydJ4KvNUr4eYuo9jW1yzZfCQqC6ALr6hcLSMvM3NI/FjF/iwO?=
 =?us-ascii?Q?JmDb0qjb3ZXdVs2HxqilQP7GrpxBgePi2BsunwssKQSEf7K9tcNcAHwlKLAZ?=
 =?us-ascii?Q?7baWXrCt+xH4wTsffqe61KQtlJX3e75JvZkNvCy/uwn9iM9i3laofzpnHspo?=
 =?us-ascii?Q?Vy47N8RWXLJqCC5lYT+MD+GcLRGS0cZcOM0ppeKNP4n7vGyqIyvO6ubmcRsF?=
 =?us-ascii?Q?JgbcLwaGPVtbB+2h44B7xh5Tw7ibeNmNsB0KeYLEL7Ka5EQOpq0yo+BNQdIy?=
 =?us-ascii?Q?ePHFunZLNfBj2Hnq/5AALLpFk/r/yqw4+JkPbqvtlp51Ee+Ntm9jt7w000eS?=
 =?us-ascii?Q?6QAsRI0TqZ0kk7fOov9zchsdeDvKlsKeK7ym4tK8JssuuTD9BY5phtmHHmI9?=
 =?us-ascii?Q?6TAjb5wlN6KjyoXBnxsKUSd1A0Qik4ugg5yx8wbFCPoi0kQknzj2MHLJQW6S?=
 =?us-ascii?Q?n3qiLgesVlvzlfX63U3LNTleGmrKTFQA7XERTTvCCEi+d6n5O69da8IA6hIB?=
 =?us-ascii?Q?8QWxqhToaQ+LAjaIQjriYENootQFxQApOVXnO84p7m5Qu0lqNfohjuXOo18B?=
 =?us-ascii?Q?YPv0yGnpktK6cWph9hC5VyTlB2fPWAlo/vaK80uSGpqLQWjQ4kC1nYCr5hJ7?=
 =?us-ascii?Q?ryx3g1VXxDzBeEb4+O99a4EKYQHU44O9oe0WbTSGBCmpIP91w4ipF/PxOIua?=
 =?us-ascii?Q?u1CxBO+Jl9vuoNAaWxxqoBWVrLd8hqfaI9uKWLrV7w9U3PktIPpgsbw1k0Yc?=
 =?us-ascii?Q?S4XthWoz6vtdBn3Yr7BBfhooK3Ow+aEFYTXggAb9ZE6H99poqfGM8SXKMiIy?=
 =?us-ascii?Q?D0ftxKzHp1On6a1pGbptCZNCriOfaX64EdhtyhobCCWkHDavwwfiR/2C89yD?=
 =?us-ascii?Q?U6Y3vs4o5LZAM86fY36+v1/anTgffvQSH1mA3K+SvI5Q4WBwVHbCvUIV9+WS?=
 =?us-ascii?Q?H7M8/7umyzllc84lG5s+AbGGk45gq5V/dWGkB/rYuaHI+uFZ+rvprTh+bWoY?=
 =?us-ascii?Q?+qWIFhNhtV4tCILV1igKF2vpFRQuAooIa+ZgZyv4I8jIjfLjbg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nUqMieSRGmrnNHA3FmpLFBMG/tkJaLReGIi77LAorP45leHmJmoejWS36S5n?=
 =?us-ascii?Q?wlbbkcw/aRqwTyvpxdQKHdoeVlhRHnPEU42IdOVZXwUxm66I+ivPl1US0tKF?=
 =?us-ascii?Q?jpUIouRc4wY++U/LVep1zx7iW/guqY+8wdy1ye7W4hHBkQTTO31bLajUAw+8?=
 =?us-ascii?Q?oFgqoXk/l4xkp0pTcz+Xhc0bx33mZXPhQtQHnuteedVBfE55mSIPgVV5OS7x?=
 =?us-ascii?Q?QiXDH3cvMuhoc8L9WDwYOEj+R69qBNq/yqf7TAqRY8wmkBYD3JRoYxm/768P?=
 =?us-ascii?Q?9PPuE/k0iryhMZTknsigM+tEWDeqBg4c3Gfie9CF9CRqtwDuO1vSn/U20c6y?=
 =?us-ascii?Q?A92+6gUNTKewpuygZ14zZJY+CpJ1R+F3IMqQ3vkSVnnf59MHhpd2UxwjAozW?=
 =?us-ascii?Q?cwazzKwhaqmkZQGiD30S44m0i2tlaBhzZVCaHFyx7i1KeYtt63EACmf6tryl?=
 =?us-ascii?Q?oEdLc+WYEk3gl7aITPpON84wuqrQsT+0FL18FZCvamMMjSYgZ2uPgQd9CeyF?=
 =?us-ascii?Q?4A7oNLQa4UIK0NfCCxbPGDDeEZ6WFpY1YU21I+UQIZh+f1zo2WmsZt4sHP8i?=
 =?us-ascii?Q?REVUPC1a6mp9Ib/eltPDxmwMNm/V6ASrk7djOE+s2wubg4rOQv9tVS2nWePF?=
 =?us-ascii?Q?6gOycHIc8NBKESIX6A2o0clXv1mqe+2WUSs7SJ5057U3rx3BopaGxit2WeN8?=
 =?us-ascii?Q?zF3xmRgh6EPImmO/EzMmiuswUV6vz7YWt8sEjt2Tg2Qp8iOzfiPfTM5MD+lm?=
 =?us-ascii?Q?H7mrIKq85MWiPMlt7opZvaHMNWggBUb8puTKlU0ec842oEC1b77ddLkqSuey?=
 =?us-ascii?Q?1i7oOn0gdlPskhmJ+YBHrBr8UU/rwnOCFLU3QB8FHViXp4TTAKeKenYt1Flq?=
 =?us-ascii?Q?MPQGI+5LY88LGrO8jRWmy1xDI1eVOysWL9L9vqsIA/LPnZqronIFbeTcH8uK?=
 =?us-ascii?Q?Pu0+lhuF8XavRGfaDlimLKc9Hv7aT9pscn7S/N1x1UAQ+oO7tsaTKiWcqA7h?=
 =?us-ascii?Q?+N/UUTp+KLFC2sAKNqhHzu9IpToUckXSjwxWjnaM79RxxLWysQddSqyB8Ixs?=
 =?us-ascii?Q?imsiqgyg52FwNSzkMkATlndrWVNlFiCmSEYtccPn/qYPtERjAb5pd2Ht1X7I?=
 =?us-ascii?Q?Sy3+2FYTcuRHT78wKafE2hnooKLT2VLRnkzuhvpaEv1hUiUGeoyulx/rZOUM?=
 =?us-ascii?Q?cdLX0DsOMEnbqx43gv+q33La88UP0KX5eESshP9MS3LYsNTdrqHWVUFB0F3e?=
 =?us-ascii?Q?0SBsLqyKiebRgvAct6yaBvjE9t7jLFtVm6MrNaQHAYA7Pksk0P6ZYBorlkkO?=
 =?us-ascii?Q?PVd0Ox0lOhYlzND2T0W25AxTRxqzsMQQzUYfsapVmz67LlhlNTCHJtQFsXtp?=
 =?us-ascii?Q?FgVQRCKVeoHJnm+CLGXb8ad5aEB5qOaNR2dXzUJIA8d78+/Gupj5lDs2hl2w?=
 =?us-ascii?Q?oI8lS793/Vr3ziO+0BbomnJa24cterUoP3lSBtzbloATB1GSHLg+oLzgd4Am?=
 =?us-ascii?Q?ksP+z2E51A838A4c3qIzSU/FsenoMkeYMxomKg5+lpmkSRrKoHEbWdqbRqte?=
 =?us-ascii?Q?OrQcYCYfNM1SN3wVMSTWTj1GpuI1nNNLb/uy07aSMFOYG00zyoqnVEXpKJa4?=
 =?us-ascii?Q?eQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kU/fdYVfatuZlEvQw+8SFE9X0zix6MCcRUdPU3MbPBz8pSYlGmA0pAA1hwA2TsMGmoSr41LEg3fFFzoZNfuk/zjm3a8kEMdk1X5TuVHJceOZHiWV1CM6Vf2a5/zREq/bTecv3Y16TQGlJ86XdKaiw19e6jsNNrHUOITQt7C4Jgqvum1rkU8/lFZREOG6VNuAQK0mDcaNvP/BUWHaMlkK50SvD/rreyEFNRWTvOqoz0gF4KpS84rbCLo137vCycFMErLIemIjftyyFgF6J16V7Ae1QJWajhJS47PBMYKS1acAQWxEerDfU/4mZWJms+VbK0yf6sPkrScLLCFgk/+1OsL0jX+iHtO4vjjNrhTki9uJCTVoe5jpsqPCghUFd3EDO1PQrsmVXT6COCZLJ6b0o+72tKd9m3/vQjJEhkRaBynQoQVakrDTH40NIvwYXcf4fvHeNzTSD3cs07DOCPut32ll/wKEYXRHh7180syqQP53q9Zqmccs4eVzgkBlNKxkgzZg23Z6H4t1rp5FO5pl4OfxFjvYpNEUykSO+QRw2GDcU1orouxCSq0oc03CUNAMZFTtjKGzKiF+nBYLAklywUWqJhqv/nXNjGcrevfJqtg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec6b23ef-f312-4c41-8376-08dde4a3a56b
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 13:22:46.3291
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YjSmkeMOXt11jGpa8JO+2JVBQtPRGAPFUv62uqWqK4Q4KgkHhhY3GlQWzgoyVb6o13ItG3Z3IByj+pa5sB4xSw68Y8+OY9mIozLcdgLzM/E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB7106
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 mlxscore=0 phishscore=0 bulkscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260117
X-Proofpoint-GUID: KLlXlwv29i5oYyTdTdGBQuyhMcv9ISFo
X-Proofpoint-ORIG-GUID: KLlXlwv29i5oYyTdTdGBQuyhMcv9ISFo
X-Authority-Analysis: v=2.4 cv=NrLRc9dJ c=1 sm=1 tr=0 ts=68adb52b cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=Bp1wAUAPrRk47IPy81UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzNSBTYWx0ZWRfX4LGCZzdaX2xQ
 qzd/mzEGBLHIYtDwnhrrUJelQtX6dz5/Qq9XjsrA3E6+X0S0wsfZZoQINkHRTmlIJwkWc0rmI7R
 DOHExUGwojRlVdbE1Cabm7BHKFuyhs9nUP3gwaEk9dtpmIfABV8xCau1jzlRFVg5bkOQ3sce11W
 j10mdULQBiJyCFBnGE2Z0C/euEOiTig1do0a7E9+76sCDkSnGYbKkP9fQuC7269meZFg8Y8+jws
 udU/ETyiUttpc0Fgg9xLQBi1wx7JEnm6r3d5+GnphirwFFM1nBCSGUZB86EXMyGAfDaGmp9J4fV
 uJWC6/SM9f3IfnFYq0nff4w4Y2rh9WIjplHqcuwNxgTXnvVbV9bm5YSdHnctSiIfl7yedRvJ6nl
 ppRn2cnS

On Tue, Aug 26, 2025 at 03:14:46PM +0200, David Hildenbrand wrote:
> On 12.08.25 17:44, Lorenzo Stoakes wrote:
> > Now we have updated all users of mm->flags to use the bitmap accessors,
> > repalce it with the bitmap version entirely.
> >
> > We are then able to move to having 64 bits of mm->flags on both 32-bit and
> > 64-bit architectures.
> >
> > We also update the VMA userland tests to ensure that everything remains
> > functional there.
> >
> > No functional changes intended, other than there now being 64 bits of
> > available mm_struct flags.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
> >   include/linux/mm.h               | 12 ++++++------
> >   include/linux/mm_types.h         | 14 +++++---------
> >   include/linux/sched/coredump.h   |  2 +-
> >   tools/testing/vma/vma_internal.h | 19 +++++++++++++++++--
> >   4 files changed, 29 insertions(+), 18 deletions(-)
>
> The vma test code duplication is still making me sad ... but I'll get over
> it I'm sure.

Yeah ;) I do want to work on seeing if I can do something more about this in
future as I intend to do more with those tests but all time-dependent obviously!

>
> Acked-by: David Hildenbrand <david@redhat.com>

Cheers!

>
> --
> Cheers
>
> David / dhildenb
>

