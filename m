Return-Path: <linux-fsdevel+bounces-57522-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4237B22C18
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:51:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ACE550495B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B772F7474;
	Tue, 12 Aug 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WZ8ZWODT";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xIs3FiuX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32EB2F7453;
	Tue, 12 Aug 2025 15:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013720; cv=fail; b=iZerwHJ1mKbWinr2IuTjio0FMEF+IVgK4+6BHTm9uMp3sJs7DlU8aOT5QiGqwWmQKV9UZm11TOtRuMUMdLbqhktpTrrF6WQ09yN++oQe0DG/aaGpJ/JsUEo+1eC4d1ACOPJ4ji3PwwcpboTc6nhoH+AvHRZFPCiQdBNZFLtkdp8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013720; c=relaxed/simple;
	bh=2uH0V+DOV3aGmsVIPri/EZvdpj1HZWRkxFc9pR1QrIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rpy06R0YvVO1FTJLiS0LMoDitTy+cIyKq4OX0bTeL4KVoyQUEGV4cU5KZphKoVCQDjJqxxe4wZWWsmheFln9aV2RFYGvGq9x444u1nLmqhQGlhMneNSzvPY9z45iVSbhdwMV5S4XqPgXkp+YP2uoZFkuRI7lDRdd+g4sy8Vzsw8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WZ8ZWODT; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xIs3FiuX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBxpc007830;
	Tue, 12 Aug 2025 15:48:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=WSvLrpSRd21C8AAsJ+WZWD7g1XGXisq6bGAA/zFNeHM=; b=
	WZ8ZWODTATFk/ygXpLlislZlYgfZNjFXZUp6FNaErNRkPvoWXcpZJheLT+QXXp1E
	m/xjRAmKkDmpxae4NDGLml33onx8Hqp0c8HKo0a01JUuDhDum+S9w9KqVfdFJlx/
	26p8fN9giBxbas2OnOcnuJbdg6uPNp0gpTmUDI5vgPx0c/9/DsvML2lp+n2l3bG/
	o2S+ibXGWadlwCZHAbLnvQbH5mWFyfh177S/nPPPHJRitV2jqrK4rqjJq5x42RRV
	2migbLfLWmiIpdbCrc4HSSubF0jOEhVbLvor86ARkYrrqRPWVXTX7/KGOcIvcS50
	dlBMPP5CCnh1xuVQ/tMQ5Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxvwvx9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:48:01 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CEOHva009872;
	Tue, 12 Aug 2025 15:48:00 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2056.outbound.protection.outlook.com [40.107.236.56])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgensh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:48:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KQrmweJQLhuvaYpGhJsBiprW///6xs4FoxuOWDsDBUDYbYFaKpbsPJWHa5rAMVng8NRr/oiYU44RdHe4FKSfAHMZO5OLIwrLpd/8evHanvzZT63w4YWa13GH+rhpprDdEFkp6G7PpyQTRmDh0rNjHtPOqMdlUtOE1Odmxg5QK6g2Sr/vvgPKDsMsvIYcmE5xc+zt7tJOjM3Ot5Uup3RhRSo4/VFnCz2vPGwQOHrdDj7vu7m51ZTYfa7CvHcsIzmeiHY9kPFpp9dGFRL7pPN6tEnSggesgKrRgchhflNqov2exWCV5QTdDGxWJkct6RQk9hLBPZtysCtGtyHwI91e7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WSvLrpSRd21C8AAsJ+WZWD7g1XGXisq6bGAA/zFNeHM=;
 b=oqijFRITr++vKZVjG85X+9+LbIeyWFQGinDctWpjGEl0T2WPHlSg6H6AWkcC0sZhEOZGtLE80LS9rPV44tRJf6efmmgVta6SR9W8kZFg53WlwD2J37X4mcWXsst450fJRRa641ZXmsH4u61Nd9H0dwC4jag8N4bsROz4qYntPbfHUaNB8Nry0TiJGMKHKrOK4zF/tONoSAQVjPqTYKEjNIJvAZlzrnKX/GFgbWj/aDjRMYt58MDf6C/6jO17FVhYf/PbFp84EXVXmBvvILoIx2UF5dWO59TiM0jFignySFJwsYPKy/qWyzDylJwbzzHG8pSWKZiygF2p395C5gCv4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WSvLrpSRd21C8AAsJ+WZWD7g1XGXisq6bGAA/zFNeHM=;
 b=xIs3FiuXiaZzAlEJlwkBD4kk2LD6iEy4zXFURRZbpOLFFqkJO6fsoBTDCTAkla5xwbRDAwMVeK7+EMOvteifz5ltxltdfbuELrRYbyk9F1FM8urzZkyk+lvZGCRep14PZTp3Tl8AmPtpp3YahSpNo/7k1uhwJ0Tub8pRI6FbBv8=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:47:57 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:57 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
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
        Kees Cook <kees@kernel.org>, David Hildenbrand <david@redhat.com>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
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
Subject: [PATCH 08/10] mm: update fork mm->flags initialisation to use bitmap
Date: Tue, 12 Aug 2025 16:44:17 +0100
Message-ID: <9fb8954a7a0f0184f012a8e66f8565bcbab014ba.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0073.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:274::14) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: a6413413-6afc-40ab-4218-08ddd9b79b92
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iyCU69hVXVi8sGkcxzZPgEkM8sUuWj4XC9HycJ39isbF+Mg8HPc26ebGTO6v?=
 =?us-ascii?Q?oNU98o2mr6zLfcLB5wRA3Fbzzxx6qYiaRmH7jjFsa2qsD1TJv4ZfG+3MJMdX?=
 =?us-ascii?Q?6x/Nu3EOxKJri3KYhy9hudBYgPOLXsLb3fI+lRwC4L6dHguRvG+XgWfU3KQi?=
 =?us-ascii?Q?vIIIBT0varByxAUP4tsDVO8qP/iBvIwk31786eTIuUj6i6dnmKPv4skIRv//?=
 =?us-ascii?Q?AwKSt9eA2g2j1czBlIwztwQZxfkicn59u2VOKAlf7kH7utaPDYYMQv2eoH1Y?=
 =?us-ascii?Q?4t2tNgcVLAb/kKdYKY2BkxTC5NSdzK5Oru/Dr4dBA1JxkVuZNm7e1x9bUDBg?=
 =?us-ascii?Q?rtfW6yEoqE0klkbYiq0H3IilhD8eYX1KQrDulGGfKnmyuJMOQpXNqP88LLEL?=
 =?us-ascii?Q?Pf5dPH2V+9LBJoLS0oZQyTrhI5Wq49d/oxck4+mWu9Cil+rjfugDO0CXf5tm?=
 =?us-ascii?Q?iHty1BDb1cFWUPvNPJ/D7Zf2BoNe8DrhUhgVfBFlVJLtB9a/IYv5G0JOf1TF?=
 =?us-ascii?Q?xaVXm1gbNxhCHdYloySrkinNkP8zwpqXjlQmocSxS31UO99S7vsvoJpeaX+3?=
 =?us-ascii?Q?908XbE9gQTAM+gE6h+syVaycqr4eIKmkbGPBawZNpDJH4PlE1eWBCfqUGYLW?=
 =?us-ascii?Q?c40PSZ3gAXOZunpqMjtNaTte6nIgfza3b9FyTF/btwZu4dZSgKfltOlRqYHB?=
 =?us-ascii?Q?rapYaes3LSBYbDENyF8aKS3vfdOdDjDju6gzHog3avnI9Tw8tOJYY7LptoUz?=
 =?us-ascii?Q?jYkKuz3xqut1IWT9qiYl9983PuG0yHc/ioLwAPVNSglUUjWNSnx+dPq3auOG?=
 =?us-ascii?Q?A5ZeQwh/qeO8J8iPBhwRKvPbZH0Tiq1culca5EoZz0e4ERKybc3j7skbFa59?=
 =?us-ascii?Q?dTwWh6agSp9gvzLoH1Ro931tyHb9ob8POEL3YC+sWt98DnWsvLegAl6MoP9O?=
 =?us-ascii?Q?EhuG7RVVsGByXrwOJ531xzJuSiRzTFuqDq37JWU6p/X42zqhdJLprg5x/9cs?=
 =?us-ascii?Q?HpkOKlaAKmpWP1ZSgYfQ4RScibqb0JggnwzlViZao6IN48nXk6bBZVG51YZs?=
 =?us-ascii?Q?xJG4RyKLZVj5Ekjt3749AnWNeT9Lw1XBzOp9o7w9ErCRsIyK9l7oDvWH/Q0c?=
 =?us-ascii?Q?YBmqD+j6yW1E1xQSI6CIPWbamtuftj2iq28y8Bg9nMRqqix3VTsjwfnPhPKJ?=
 =?us-ascii?Q?b8a/rWe18BJOPshwYCLm5DA5U6MJw8fBjpf7WD6Hj0zuIPbYPeSojRaLz4Nm?=
 =?us-ascii?Q?vwo+4ONqQ+Wfalc4Wd1KWhDW8EAmlJHK88ixaBkWUqYzkwxFTaprVkaG3OMe?=
 =?us-ascii?Q?HoMzdXoGN6RAyUHS0UDpvwmWSPB5c8yVIR1BXPckYMP2iyxDs9K4lJb4aEX5?=
 =?us-ascii?Q?BzjW5fM23EcRcRtPaKqDQUI8NR4bquKf8m0P4jhcFTcdwgxetFNwZqxpN2hV?=
 =?us-ascii?Q?ItwKp3Oybd4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?juwhf5TCuy3kCxXqmJL/pM5Mw38bzP1ho1EgnwUH3Jd8dBJS2/GfqAQPnc/Q?=
 =?us-ascii?Q?ji4DRr76hxSlQplvt+Uen2qfOU7GGnmZLhvk9O9/a/waOpDBz9mr+8J/U1Ug?=
 =?us-ascii?Q?XR+Yt/k2jmknffX3+9XInlgI3REqOmPmTdWduU6DwfH5Q3/El73RbAs70MNg?=
 =?us-ascii?Q?F7aHq+eNEX/Vik1umAtEKDbG09ByzdOzLMB2pePKUvQRmp0FVUFBz6TW23FV?=
 =?us-ascii?Q?nHA2hvojIseGHgqHFTEimdSZS/Pj123AhDSovIqu9q/KM1SWMb9j5BLwAt3/?=
 =?us-ascii?Q?iYzb2dF08g7vSAIgr4P7CKH7gCBwCG+gSYyFNxLYzQaqBeECILouLgHE1mY0?=
 =?us-ascii?Q?5t7Pf0h6NDs5GSi/BMsFuLH6MaS5/HOIh0w1/vzxTiL3boNP6fUj5A4DUIF0?=
 =?us-ascii?Q?hWl09WxBKj9ZtbBmdDaoCxBiMFhsAoIiOxTh9Tk1tjfvluzhMKzQeZMlQtKz?=
 =?us-ascii?Q?cTUwvXr11Y/W4+gRIi6OGzJf5t5Y+w6YMIKSKF7ulujJMaM5uyME7Qmq3tA7?=
 =?us-ascii?Q?PamR2yhM5xzrPfwupZ1o/qh4sQcvyfb2hgzrIvkuWyytCgerHsRPss9XaA2P?=
 =?us-ascii?Q?/u4X0g92SefpQ1j4eT9tHQklgNiKVk9gXvW59AXMMY8W2JyCXaVeLW/yXoC3?=
 =?us-ascii?Q?L3iVFpl0pAWivKr8caadIiRMABXaz3KS0M19YYltd8b0XXRO+3aeMut44fDY?=
 =?us-ascii?Q?3GHMI1UFPXu17l3GgemM/q5NAXxtFygwJnxUW6ZnZB55m2l5jZgh3plrOHsS?=
 =?us-ascii?Q?VLTxsS17WCaDmUW5oUp/kvIozrX40q9rU23S5vIEbHOxwOp3jF2Z0H1dfPJt?=
 =?us-ascii?Q?SXxnuV+EKThYb/LakKYKo3MS/CRmSMtn0WLBG3nSJR8+g+hN/MNEA8p5XwKO?=
 =?us-ascii?Q?0Yj3lhqOMRyyXYfA3lOqTs/ygAEqMU1faK25WKzgnmNmInh/GDn1uA9CezyW?=
 =?us-ascii?Q?IBb8eOUocNLp25vvW4iCCQgRzYFE7L8KAMrUkxH/luxb5NBTmUJg7e8xGZ4P?=
 =?us-ascii?Q?FUKM5vvFLPyy218iZOZRBpkRRK4UMEXUJNiTAg48Rh/7Ks5inHR5m6YJLnL4?=
 =?us-ascii?Q?PDWW10sfiCQ8/aPzeExiABe4S3hEvzwK6X39EQmab65DUtwtNwpjVqaP8zUk?=
 =?us-ascii?Q?EIba8A03XVaZXBzbx/H1Tp0+WKEqY3flsUYiPmlwvXxYMHEcpUH2iP4igski?=
 =?us-ascii?Q?PDBeJxWNAT3Mm7jUYaAEXU8xlM+kHmhuVjCoWzdr/GBtlFPgFa6K8kLs5m1M?=
 =?us-ascii?Q?tri4xgTsd0tQYbu1hcm4d6lLegGIix9qfa+am+LJUFU5KQskYddmxw02CB6T?=
 =?us-ascii?Q?QCJjwAU8vThmU2bWGjjmlO73rHq5isivlaowSgpCHow8mhHYysrHb0f34Oxz?=
 =?us-ascii?Q?rjq9MsOf8F+lOMG0RNRdDTijcAv2IGxtLZUTpYLlJGpXpWIy/LVIcOcufDZP?=
 =?us-ascii?Q?4+/GVGdqJNdV4jKND4wxS/zpBPoaqeBWbfei3rzPmBpMu/w5a12592xeIyhq?=
 =?us-ascii?Q?FM3CSnOgn2bJkH8KVaElA12HojehCQ5snDkCN/27E63ET1JTJIcy1M0mVPZn?=
 =?us-ascii?Q?4+oioDALO7QIHhioHfmzxebauVcU0DOCZfV57k5qxZ9g+/aJeGbLPZ5KWeWK?=
 =?us-ascii?Q?cA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cPsTrMsftcOWXRLu7RKwtL4rkp8bx/ac2DOtLCH4sZZl7VG6/wjnsZq0J+P9oDMKNQ+V/fYISbzMia6mdTRLJk92KFc9T4m11OHgpt0SE50qD436hLb4SAsD2h6Ib/1cu6qdGP46DM+HulnhrzccIVDUaMwjxE20fEkgWgYRiYpm8HIjXyfW+dJ1bVs1VbHsfUGGtw8ytT2v4T0oz1bskik96ZPFSonXmAkAxW3pPYfDeRS0gqvpcwSlbkrahHG4m6tt98kpl84qlvjoN71H5fqiX17clTUESwNdLpD8bcCVKOzKa9H0pVkD+VA//R4triRwH0ORyYHF0d0MIu50yg4kWYtE8QFinLJgXAcC+PhXZubijODWSGrG2yjRM7WaYSuI217wB4hBEG4im68nBJ0Iy6LfT//7y5uXDyMu7SHniWUcqDF3JkgHobmlrOu3ctJ14ILr7cUCc1bv+SG1cmmE3sgPWzBjKENLSzyUR7i920ub6EdQaeI9np/YxENGVUZSGFh7FxPETYuUk0R6WqmFSyVO7EhM/vH9DDwMMXqCNjdWgzgTe/j1sXNkFzh3gKGq87hOJAuvMrkhC3h5GdsAnFpEsfbeck5eMLEGDDE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6413413-6afc-40ab-4218-08ddd9b79b92
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:56.9446
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ACDDcOWKJECKXi1RXCid1xtr0XRRZ328h03Ydnyqf1eEmSzpBZ6dhjeLLhg6I7cRqIBoRHf53I19nsRj2lggtz7zIK7ST/JH+1QCmR4XAqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120152
X-Proofpoint-GUID: lwzUYi2wxpVI0gFOEsczmjENRs2H_s6D
X-Proofpoint-ORIG-GUID: lwzUYi2wxpVI0gFOEsczmjENRs2H_s6D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfXyhaZM79ESjhD
 gW7op/vg7tAd4ZcXUKZ1h1fOJLZGmP7tZHoiCwcD6g+Rb+yRW4uXFhxfHcGj6+AKgcGb2d19FrB
 YpLxguPkBmFT8A+VzCnxHLk+tm7XksonWvJnRZ2s5RCpdP41p5xhLCQC3gHymvNWvym3ahIWVKm
 +KFTTJqg8RjCORVMJeO6iKVV9KZi4TzFztojC+IIvYRnbG+u6pMs7CY47INNX2UYuKF0Z7wScFG
 ijNG1CpX4RhO0UMCvAD1PhuET3tMb2RkfQC8jQAzSDV4TueRkBld7X2TABAiL9lUvuBxGXNLTNq
 5e2GExuuUr+g4BNDeIg4K/LCB3eqEYAjm5M0ZPZRmSUWUbtv0D8hG+dL5K5TKSAq25A7bKMN8zw
 L4tzesDJROtUfw5WhlO1VWUT+lDhbBlapvaKRuO3GBS+ZTDnAHr7fYyX1Nf5AeQZk7siGMT4
X-Authority-Analysis: v=2.4 cv=dpnbC0g4 c=1 sm=1 tr=0 ts=689b6231 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=lIc7FA3TbVCleBZhzpoA:9 cc=ntf
 awl=host:12069

We now need to account for flag initialisation on fork. We retain the
existing logic as much as we can, but dub the existing flag mask legacy.

These flags are therefore required to fit in the first 32-bits of the flags
field.

However, further flag propagation upon fork can be implemented in mm_init()
on a per-flag basis.

We ensure we clear the entire bitmap prior to setting it, and use
__mm_flags_get_word() and __mm_flags_set_word() to manipulate these legacy
fields efficiently.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h | 13 ++++++++++---
 kernel/fork.c            |  7 +++++--
 2 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 38b3fa927997..25577ab39094 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1820,16 +1820,23 @@ enum {
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
 #define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
 
-#define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
+#define MMF_INIT_LEGACY_MASK	(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
 				 MMF_VM_MERGE_ANY_MASK | MMF_TOPDOWN_MASK)
 
-static inline unsigned long mmf_init_flags(unsigned long flags)
+/* Legacy flags must fit within 32 bits. */
+static_assert((u64)MMF_INIT_LEGACY_MASK <= (u64)UINT_MAX);
+
+/*
+ * Initialise legacy flags according to masks, propagating selected flags on
+ * fork. Further flag manipulation can be performed by the caller.
+ */
+static inline unsigned long mmf_init_legacy_flags(unsigned long flags)
 {
 	if (flags & (1UL << MMF_HAS_MDWE_NO_INHERIT))
 		flags &= ~((1UL << MMF_HAS_MDWE) |
 			   (1UL << MMF_HAS_MDWE_NO_INHERIT));
-	return flags & MMF_INIT_MASK;
+	return flags & MMF_INIT_LEGACY_MASK;
 }
 
 #endif /* _LINUX_MM_TYPES_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index c4ada32598bd..b311caec6419 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1056,11 +1056,14 @@ static struct mm_struct *mm_init(struct mm_struct *mm, struct task_struct *p,
 	mm_init_uprobes_state(mm);
 	hugetlb_count_init(mm);
 
+	mm_flags_clear_all(mm);
 	if (current->mm) {
-		mm->flags = mmf_init_flags(current->mm->flags);
+		unsigned long flags = __mm_flags_get_word(current->mm);
+
+		__mm_flags_set_word(mm, mmf_init_legacy_flags(flags));
 		mm->def_flags = current->mm->def_flags & VM_INIT_DEF_MASK;
 	} else {
-		mm->flags = default_dump_filter;
+		__mm_flags_set_word(mm, default_dump_filter);
 		mm->def_flags = 0;
 	}
 
-- 
2.50.1


