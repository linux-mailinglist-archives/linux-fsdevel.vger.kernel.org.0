Return-Path: <linux-fsdevel+bounces-59202-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8994B360C6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 15:03:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34A925E0DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Aug 2025 12:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514881F1534;
	Tue, 26 Aug 2025 12:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YvFpZOsA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DJRqsuLh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D809F1FBCB1;
	Tue, 26 Aug 2025 12:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756213177; cv=fail; b=JF9H79DZWQ7YTYcaSi37N/m0+zyEyoM3+gitRKGjLHrCfftnrZmpyWXIK4ypXkVc0vnjxXc3Db88QkR4aG4k8/KNmkilUEf8A3jfFDqUU5W+AEcYxtHtqAfyRGDStK/o1YZes88meeMQRrYYWSMFx1Mwb5VWAgAK9nkSO+F4hAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756213177; c=relaxed/simple;
	bh=yHa+OlithOubuhrSbihyV2V95H3FxgT0HoUMZAzrS94=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=SqBS1kpVVO6FDYL0Z7v1GNSmI7qfYMGqounVotv4bLUjt14xwCv+Y7mUxU1Oxjfx4tWPaJ4wXliZ7Mg1pECln013M1LbYzFNL2w+/ZFrZFr23SNh/YV6mCKo3ZqAjhwFkf+12hVPKsinmjlwRB7bCPGvwL0qF789elHoJR1Jd5U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YvFpZOsA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DJRqsuLh; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCINpY025999;
	Tue, 26 Aug 2025 12:58:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=piUYna5MMycQmIIM8f
	aui5hu33PzFMRFbTlnai+G6Yk=; b=YvFpZOsAgF/iN/3UnMXViA5cgEbkkdG0XN
	CChd+UUDfhOwtrmwfJGd1+Qi+C21MIZy3WTAzJPKYIw8rlMdFRCwGRcX7BvS/Vio
	g2Dlp7vjpkSq1slRmQfI0cjb4G3btJAxqf3+Weqe/5KYAJMM4TB8qsGVz3R11i2t
	y9LdwKm2mnsXbeyz9Xhr78XpKI3gnY7TrSKWdFsV4dPBEaWQDs4CJzJyapAjcxkb
	MlA8dy2ipa3bFh0hg3Lgba7PEitgVONwLTnf/kQ/8EvHwbYa/HC1QwENtADBrTa4
	gkOeRidz2RSF9xo67K7lKIA+MHP+sjlkX5cwXekQNeo8Xs13drNg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48q5pt4e7v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 12:58:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57QCVSJD005002;
	Tue, 26 Aug 2025 12:58:27 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011010.outbound.protection.outlook.com [40.93.194.10])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48q439p7um-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 26 Aug 2025 12:58:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xRgkGSW5MbA+PvCeROUw6P8nlY4Dcmv+JU4MviON1MD1XjryhChyCOoL2Qnr5U7epBOzbH7FMRJzedA8LPpr2BnSAx8uvOzoY00gWPtdIFmSaikS8B4jNE+6C6YqkEpuElCEM+4GdDQm86AzCg6IIFlCXWVnIc4jAXDyV6KIb2/izn1b71Y0Od32Aad+Lx6INRhRlUr0wWd9JjdtOSh3GXQydDVjRCbQyCYomluoirwHEBA+WHgc/uZJdHIJeC+Vgk9qUN3fmgTVx5DfFHW9s+NBB83qkUZbMIi95rz1EAhe4VSk3GxVJgedV+KsbwlT1q0XtvSWTyZN9TZx3QKrdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=piUYna5MMycQmIIM8faui5hu33PzFMRFbTlnai+G6Yk=;
 b=wyq0u+zKsdUjaxBfo1JaN+TN8IjbH0hQYIYdMLsr2eK/GuxVHz62UjGmK5NbNUUDMAjdIDzgk3b2oqravsCKrQjP9Ejl7Z3ALmDhULXIYVzgb1K7f6VcFvIm/DOn/FUL6E9KMh80zdB0DnLDKJIWDN6DQEjZSjPdLldUvDtJmdHXelXg4kWadIow/L9c+ymkWp7EtyeDU0DRx+MQzXHSY/zoFUpB6lyBxruPXquOrSN83CNULFy9WtqOhDr+lQBB9o5Jiit116QHLVq2ZboirYWL7n7GUT78eOQ61Bs90wkBhzm8nX/bFZ0M0uhSZEwdOtabQXOpwb82xWrW0a+Daw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=piUYna5MMycQmIIM8faui5hu33PzFMRFbTlnai+G6Yk=;
 b=DJRqsuLhlRnYTmTiGL2iCwOpTYyvYuwXeabuALehgqvBZdTbSPgUdpY+rkauowIKmTvY5rQ5clpUKzhoexxQii1XihQUgleQnmunl0bWrOUJH6iqVeDF5fNHMTnrFD3xg2VswRE3H4rtJBIkJB/NlMOw0IxxYPiRXba+VtR1Kjk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:143::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Tue, 26 Aug
 2025 12:58:19 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 12:58:19 +0000
Date: Tue, 26 Aug 2025 13:58:15 +0100
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
Subject: Re: [PATCH 02/10] mm: convert core mm to mm_flags_*() accessors
Message-ID: <1e256f98-aaca-4203-b036-a0e5884914c3@lucifer.local>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
 <1eb2266f4408798a55bda00cb04545a3203aa572.1755012943.git.lorenzo.stoakes@oracle.com>
 <c62fe93f-e4f8-4048-81ff-3f01bd64671b@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c62fe93f-e4f8-4048-81ff-3f01bd64671b@redhat.com>
X-ClientProxiedBy: MM0P280CA0031.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:b::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|PH0PR10MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dbfea43-369a-4308-34aa-08dde4a03b2e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?gOKUvbATKtTMhHBYKaZjowGis2Fr1grcWoPVtr3J34PBrYy03XADFN1Y67xo?=
 =?us-ascii?Q?svnXttK+btcTZKwe8c5L2X0HIRxPtegwgvFEbgI+eu9Z+q48RTmVQZ4f24oM?=
 =?us-ascii?Q?V8SXLtuonpKd3+6qQpxl287L7bIx0TlzQm/9poP3rfbr+QU+65HtFTzXxmmO?=
 =?us-ascii?Q?HwVM6/9PKawImWcmgEtsCIMUW3S1VVusmWwa7Ns3E986ez1zuRma2D37rKCn?=
 =?us-ascii?Q?ng4g4JLqxQauCOWYWxcEkC7+1GFbRc4H53MJkL5GX2KiS1fufZ5ILdPdqG4k?=
 =?us-ascii?Q?VtEl7beRZSj8pQIiWJDQm5eazsgcdw6FzfLO/ceU6VkS/AeeMvhj+nWdYsVi?=
 =?us-ascii?Q?VJSNsoEPNOBqzbQ0yub56uQ1eRpPxl+nNaG95EoueuhDPjY5nsCflVpoUA4x?=
 =?us-ascii?Q?AhGbnosfkjAvQm5+57f9EgQzzsmCSawPTUrM4eTE/MFWhRUkGkgTFRZNXYgy?=
 =?us-ascii?Q?o0zjvTOqxvMk3c463tpaNKffYpzTpc6md+2UYlHPgI0iU5k1HUm8ZKPp9Zb1?=
 =?us-ascii?Q?fZ9bRTR/PybRnm9CUbrKxG03iJQxskm86qpmu3u8dJvY1s9wzhtbzctOBu3J?=
 =?us-ascii?Q?ALIPeSJ2QvJD9r/gUqhD5tvIQiZ/YlRhyJok6p2FS7G8l1vInaqnwwI7xk4k?=
 =?us-ascii?Q?FDtTmvmREUNh7SLh8G70tnDM2vXTv1mMtbcsOQRAyhKFZI/FBTbnHAuW0xjp?=
 =?us-ascii?Q?enjxK4/dn4jvpjTb5alTJ/RYi5nd1eIhDLmIAsOXvPHB/YVHzy+TmoOiiHcr?=
 =?us-ascii?Q?tjZD5xdZ25xJCsVSy84PNOoG3VXqH95/5QjcIE6QgZtsMcCYJdKaX6cSG1Em?=
 =?us-ascii?Q?AwBwAe8jWJXDQ47rle8xiOob3IT65w23FG5MRqsdv64F5vxL6EX4XkcW5bH8?=
 =?us-ascii?Q?XKYOeeUMbP2RhLXm+Oju6yD/yQeIZgorXlBrqUiJmGLL4nkfPJ5SvnUMfqZj?=
 =?us-ascii?Q?h9KbLnAYUHx/dE1ETWAdIMcLXqpc/KNI1iOHEgU+LI/faW5AnCRkfer8Y3Bo?=
 =?us-ascii?Q?rzD6MNCvb9gtjlHo4s9Gso8rXwvU7f/w34vjBrpQ+WRCUkGNZhMKilXSKKtc?=
 =?us-ascii?Q?ruabUrjTjlVhBCP8Al1PuhzyQipz8aiBfWvUTwAXIbblp26RWpkjpKdK41ug?=
 =?us-ascii?Q?aAM/LJxjh46BD7WgkGual2pW7NyhnDZazDnOskTsFCa2jqqAYGjlIZXoOMxu?=
 =?us-ascii?Q?wCO6MKCrbUJIyZznZb48yjteCFyrrFnHWPUOwzOr/f8N6kfkDiP1o/RSFCsC?=
 =?us-ascii?Q?ilHfg4QoE9cVBbrz14hW/NVXkFc6jh7HOeScfAZalPHG7hgKfa9JEAabL2MP?=
 =?us-ascii?Q?cHozjTzsQNUBWnEimkj0nArPzjQ/2B/7yIpS0v98orVMHKXeBGy79x6Wtc43?=
 =?us-ascii?Q?xTg9FqMnRX628LPJJk09mPdwSQnMLkzXhEYEii7CIYPrLtr9Gp4vPvZa5BHD?=
 =?us-ascii?Q?vkg13Qo70OI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XdayoAqYw4SOSzOmKy/g0QJAW47RZxhZmcjiyaQ5Z1NVvFPxCn7ga/cJevyk?=
 =?us-ascii?Q?ZUTuzeVc4wZzfT9fOY1wy2tBzWyNXqW0SeL1Jp0NrzTkoGJwTJjSRDobkyU3?=
 =?us-ascii?Q?8/XZyN9E1zb8+X/3URI09YnhzSMLBhsmBtToGPwpP3v4FQLJ+uLGvZHraM1z?=
 =?us-ascii?Q?/xwJvqRMgr0yzhR/vDKFxIezfc5Gd+24WT1HPzPdPuAe8HtJlITJ2/khjmbD?=
 =?us-ascii?Q?fAHRKjf3Ouzckxu6Ym2AQLnP+ULkXvcfGmEYLjwSp67VNnYyrrrULyKB8MwV?=
 =?us-ascii?Q?ysT7l/Cif97bZkW/zNUa3lel/L9sGCkv0yEI9Mul3mgcEge4DuzMAQP66NBG?=
 =?us-ascii?Q?5Mcuup/6eiSvrozZWYDjUTrJzXLmi+lcHHnD4y9BmLT6lHlgquEMj4F6YrRC?=
 =?us-ascii?Q?10/6hEHlerkzTQDq+g0sXzaxhWtoI3yrk30ukflokLrI4Bl2cHYmeSgxdQFa?=
 =?us-ascii?Q?K6s5XyUAruEfEwrt0X1FVXF1aUAx1AteaMChUg4Y9Os6U+EFmy1f4umhuDAf?=
 =?us-ascii?Q?eR3+v55BjUwe4iZH29LOGwwji5ByweBl2KxZeAZb52k4XSvwKuK61JMOgZP7?=
 =?us-ascii?Q?KPE542FynaS5YpSUng6F1/3zPUJdZtLuW9yst/oFcceouZuDDpTRQZZYrXJW?=
 =?us-ascii?Q?Jq7Q89iR7C2XD5PYFCw9wkgxa8Dadu4uxceEDWG7YNYuO6qt6SdmYMBnBGav?=
 =?us-ascii?Q?cfMXl96pWWffErmLp2CzvL6QjZHG5HJzoGH47gkaYHNeYZtAmmQYBTxvCfp8?=
 =?us-ascii?Q?iICge9pCtEWGijalBOaRUnuq9QtO66FlupGp+5VWdJ1BCV8aw40WgB3kIIT8?=
 =?us-ascii?Q?TbK8XYim45+Ul6QJ+/efYOLkjC3ha0Vxhp8HSdpEQaKhfWK6PXMUHqteoe/y?=
 =?us-ascii?Q?WF935bQFWECkaT0eyapddG5a1+BDp8aFsmT///Rf+VB1TTR/pW3LhgRha9qA?=
 =?us-ascii?Q?V5SQkKuRm3dCuogxEZu7lE0hWM9hAQEzgKF0gRrpXOPZzNG3aZuu45SQNhDp?=
 =?us-ascii?Q?AWv8Sd473I41o010BBRBILrzNi8H3iD2k4X7j76wq3/hNX7Vq2gHbJzPjDIz?=
 =?us-ascii?Q?JEsFSP4R/RgazGc4mh2d5fNn7U3SsVbTvT9lBNGgIXGxfKKrOBgKREUK5mi2?=
 =?us-ascii?Q?Cm5uOkEiP7a+Y8gVCHxnS33SABhq26jQsPFYjuEvay+PJsG7N0Jkr+a8WOC4?=
 =?us-ascii?Q?tdf6+LnX0PKH1crl87tQpHVQ8C4Prl5yVnE7ULLQ+NFrNKG1AMi7qB1KPvXQ?=
 =?us-ascii?Q?noTcWPLh7k8J8Br5rMw0tauivlFMXbuLxTinTxua7TlKCPJzFbe1XSzAoEl+?=
 =?us-ascii?Q?8DtzH9o++J4PvZJ5seJrBJU2oxiPy5sfvcWCbgoQ9injKdC+w/jifdI8Xmxx?=
 =?us-ascii?Q?4FsQEquyQnPe1Poqr4ZmbIuwR/PWW+/TRVzOY5ph2omuqZSo9CX3yCZEm3Ro?=
 =?us-ascii?Q?iCNrpQqGvSVYRcCSzS3DYzx1hgtz9YOmo1josG392V5pwfKEtnKOKR+LAHux?=
 =?us-ascii?Q?hVaWbn5Oh3QWfags0dngv/SCaEyXo9WtzFrQlAQVZUGfICLBi8lF5L+l4flu?=
 =?us-ascii?Q?W47IzYaUr0x68RvTf3VQKQNZ/dS83vlMJQutGPPmUll6rh+1OsJldZJP68uN?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NxRyQ9WheJiIbTtcJDxfLVTrGBCd1e86OdGVLQK11Kvrh/O6+pJyDMtKv5Yo76woxP6X3QoVpZW8MMRqSxrMNiRE3+VOyw7/sYLoq5Sd1FHq/DX+EcDfbVYVDBS0D8kOG2PLXWgV/QllpSm0nD+PS6HaHPDy8y/gowFMKV1V2fZlVI22FBYj7gMAGyv2FgX0bEpeMud1ktzueMAvyoRiTfC/oeRNSwUgB7n7ASB0pF+cpbpOw4xJyx2xZD/wUy+42iGOLmY1UPOS+jicqTOE5WL4xX32aNK00wAvM+xl0eBb3E9MKk25vuEa8j6gZLsuVjckMRTN4X3rRGsGyY11M8e7pzfMbb093Npxf56F6kQFjPrZbR4+cF9csU3+Gp8nx9lxk8Lz0bwQ2rDMocRjNW5PnP+4iXXryXKspCBuIz2rCyE8aWOo4q4e1BxKUKt933Uca3erE84746aBWes221FA8bSpt/UPsdMpZ2FbeOI8/OnR77errk8Q95uGefBdEbtnLez/HZmVu30o5Ujjx9mkDiIPnQ3xOB4j417Uii0BiueQzMWsQlJjExDXFtXbPL8CTjsPftcKk/ZzLjQLUF5awgIZEUSsujFuz7CmwS0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dbfea43-369a-4308-34aa-08dde4a03b2e
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 12:58:19.5964
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YWqmaSqupHxDLNlosxOdcJrvom9N3zfzTzpR8wVlhdmcrMK3VcMZnK3luYbjZP3Ii08UT/hZq31sbIhEDbCv0zdhG6SdL4RCsT7PdaxS++k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-26_02,2025-08-26_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 suspectscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508260114
X-Proofpoint-ORIG-GUID: h_fHNEKZkaBltp6NbJzuKV8R38H3I8lu
X-Proofpoint-GUID: h_fHNEKZkaBltp6NbJzuKV8R38H3I8lu
X-Authority-Analysis: v=2.4 cv=EcXIQOmC c=1 sm=1 tr=0 ts=68adaf74 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=20KFwNOVAAAA:8
 a=SKC4cPUdhrHzPjPfhaEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAzMCBTYWx0ZWRfX5cE7jE7jMpqU
 dYhG9gCOh5dYQ4+oerCYzeNj7VELH8r9M1eY0uiMqQOTtPzXIj/semfu7XqDrXqc20+L2t85iF1
 NhXUGa+EzVqKPU+3BM4RUuFUEfz9kM1Ov9d5SS7npJf6jHXm2MGI+MgntVFa1IM5psR65Zdjap/
 nIuS59mSEvN5wlpdyny5qy4wZ1AKNnyA1n8cOUGnfM5L7BG6fUkLesmAprc7LgTWQ3YtoyORLwr
 X6xFtp9/2DoUWKo+QzNUi6ti2fUtGQJdawW0DauqpU84Jz99nCiGh20eT1D4Bk8TDYzgoudEo4E
 l1NpUumwqMjxoXFoxX4XXZ4BjhVzBDOFtqlQU995IDG3Gid3GxomplkeOI2nF4Q9TKsm2trq+FE
 sT5rTlGr

On Tue, Aug 26, 2025 at 02:50:03PM +0200, David Hildenbrand wrote:
> On 12.08.25 17:44, Lorenzo Stoakes wrote:
> > As part of the effort to move to mm->flags becoming a bitmap field, convert
> > existing users to making use of the mm_flags_*() accessors which will, when
> > the conversion is complete, be the only means of accessing mm_struct flags.
> >
> > This will result in the debug output being that of a bitmap output, which
> > will result in a minor change here, but since this is for debug only, this
> > should have no bearing.
> >
> > Otherwise, no functional changes intended.
> >
> > Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
> > ---
>
>
> > diff --git a/mm/oom_kill.c b/mm/oom_kill.c
> > index 25923cfec9c6..17650f0b516e 100644
> > --- a/mm/oom_kill.c
> > +++ b/mm/oom_kill.c
> > @@ -1,7 +1,7 @@
> >   // SPDX-License-Identifier: GPL-2.0-only
> >   /*
> >    *  linux/mm/oom_kill.c
> > - *
> > + *
>
> ^ unrelated change

Whoops! This is my editor removing trailing space...

I mean may as well leave in tbh for this case I think :)

>
> Acked-by: David Hildenbrand <david@redhat.com>

Thanks for this + other acks! :)

>
> --
> Cheers
>
> David / dhildenb
>

Cheers, Lorenzo

