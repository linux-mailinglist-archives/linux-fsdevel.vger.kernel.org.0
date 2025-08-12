Return-Path: <linux-fsdevel+bounces-57521-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C446B22C19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:51:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4A187B5B28
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18E62F7442;
	Tue, 12 Aug 2025 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YXDCxfsg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="xySGBnGU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C3D307AD7;
	Tue, 12 Aug 2025 15:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013715; cv=fail; b=Mmj69L/cS6EyA+f0WYgCyBlS0UIw6FQkJNMtick3uW+5/WF6bixC8mI6v6wq4e4BE/oETZfN5lB+vQEG0i8WI1JeZxJ8x9F2SlWbjYoMf/WCwqC0Bg/WOJCrWwlt3qefc+8g3iT20OTvXhv3FtSWdNqhLravGHOSqqBdBkbe0Kw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013715; c=relaxed/simple;
	bh=CfqhRO3B9mLEHXT/NeVlYqJbyw/i7qeKlnkLr4stpzE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qcw4V2YOCl7oV19qUuPoBel5A1sjLQRboDVX0k2/2CnPDrfkTSgju+VGe3JpyGyZIAFaDk3jmMfajPf4A9mY3W4QbzKsmhTDZzZ48AfcMKI8/qOv4/4R7lidyqBgn8u85+IjCMjCqKI/yN8QnvzFdZXpC7cz6RLXyf6Zf8QS7WI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YXDCxfsg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=xySGBnGU; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBx1x002291;
	Tue, 12 Aug 2025 15:47:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=EKTMWV+MizZ9KXsCmUXRWPkCH6B6O8dZ3cApczo27qU=; b=
	YXDCxfsge9cnddrNo6W0j7W4On55T6X6NSW3wnEG6lDsefZz+1OjrWOMrf5xSB6W
	dSwl01D4g68KW0FKXywdTjdUXqvqg23gocqhM1FHbZgQ1ZKGOMl4H5grU1b9d3BU
	vxKdTlasYjKvpskP+dBJiivz2WTIKIzVyxMpZ5ro914K3CaTBv7O5Sa1jX7rb1Ln
	PUx2gqsyQbUf4NefPz5X0QlJ1ePH7i8bO7vqu1PhkgujpWvBovuOeUsr6OfEYy2T
	ibmd5cvESruEzRH1onct8mGXpjIfM3j6j7BZ84d+0dslAKNCsRwcETFq735Bymr/
	7DVOLIzy/Y2lOhA3TnSEIw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dvrfw1m8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:58 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CEKIv0038606;
	Tue, 12 Aug 2025 15:47:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgp972-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r1EESGTC+lWRyxB8E5b3VOuBHXir0gKNJOoPTt8zMn1Wj5xvcHQWCNv3qpOmgI3qMv80Sh76RtNeyxwOFcUixaPOC1e/Ziagev9QxKwDn8mGh9jVGSH+np+uBozbQcjdrPcUdmR0WrquE44vaaujuZomITQ9PmsAZRiHcZA8/bfXQLY6OqM5SbP0OEZNY7IAj4SYp19Hp8M0zJqoze4pfbvNgOiEsjBlvM/z+UGiwoOO2Gh0/wKwsZ9wjRZeQftS0y31BI9a6rGv0v+LaCVMr9R13MVstA5m5sgXOzQQoqv73nLdgmQhxftxORB+29H6E9X2gjndEeZ3UeLCz3rqpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKTMWV+MizZ9KXsCmUXRWPkCH6B6O8dZ3cApczo27qU=;
 b=Xsr112JuQJaBFiEvkx99iDa3cZkrYk7HmQd/DwMMkK4arfGa1+3hbAuuoM/1CV0KsWRBuhxvBjgUaW64XVL3cKvw+dZ2aCOmci4dzeFJ4BPHQC0piQo4ReP+xz+laKu5IIZ4ygo1459m0vEUvNN3B2MUfSD5F9CuAdgbamuiAG87Q3pdWDJniV4eaoPh8+PooeNXuZKMfWuhMiX3t9DiWsasDOW/VLyy9ndqrFqAwGnzqmxc2vd4zsbP21zsCaMIRX+U1JSt/PLF0Mm1nUIGjVA4nRpSciZRShaWg0CTFFPhiiCRrz1xvfQdKlkqpHfVmbMbI2nyqXXH3iHV66xIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKTMWV+MizZ9KXsCmUXRWPkCH6B6O8dZ3cApczo27qU=;
 b=xySGBnGUsROrwcJM6+EoIDBpIK1H2KnpMBbUVNx5bQyS+WCAL/1xzhHW+YaBa9Z2gSNSdeWly45e6uRa+a1bOI1irLhGX3XIChCFx0G/fCchIGz+YDfVOqEnLTcQnMDM2eEM0DsJxF/9MS+h3hzfdIBLPyvPxYzZPKB1d7LxrLk=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:47:52 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:52 +0000
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
Subject: [PATCH 07/10] mm: correct sign-extension issue in MMF_* flag masks
Date: Tue, 12 Aug 2025 16:44:16 +0100
Message-ID: <f92194bee8c92a04fd4c9b2c14c7e65229639300.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007574.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3ed) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 85f640c4-4b1d-45af-29c8-08ddd9b798fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?AxZK819cjwOkYg17E/ez0PZ71KjSTwLsHGcnojx/1xEoFhhgu0K3ggopyC/k?=
 =?us-ascii?Q?StYANlTmN5gLUEsh0zJmYtlYjqXeuUFMyGL4LVizmog2FQVnSTBS1xbTHlbH?=
 =?us-ascii?Q?j4poLvbfa2RnE/nsf7yUltHF0OMlMki/wT6eX8oLPMi5J5kw6D1Ra8x4gaoY?=
 =?us-ascii?Q?MyauUdWjfZjjk8DjJAHq9Hs2erpS6mkWCOZOuFmQLbBXK7i+GXKGUUeZ1i05?=
 =?us-ascii?Q?pb1v0SC/j7nMoI+xNWnWeloKu060+wCyiDTWBKwb1XSgsN/1WYE+LKwl2PqL?=
 =?us-ascii?Q?Jo3Q+lo2il76+SKZU4FVdmkDCwRKXA1WMznuQnevgoHV6aCKrHWnxZA+3rhv?=
 =?us-ascii?Q?hABtj/+GtyusKag2A5LHCzXcKFpEOgRJUG/qXR3QrOF5wokc9ARWSXt+U9Kx?=
 =?us-ascii?Q?u5AhfIiYlqOly5LMe5UeeKAg6wB2Gprc7/JoQlcdxVeT7lBObz9p5SsARVd0?=
 =?us-ascii?Q?bwgCtP+NCU6pZcX9MT+a0OFipcvnrqLyIZ3gsR76m1Whejp6L8iWbwarS75q?=
 =?us-ascii?Q?mSNYUrZSbsZ3tsrG0RmHfyuytChGKaILQxNC3lli11CeErJt58KqXtlufs7g?=
 =?us-ascii?Q?TzwT4rsLTFqCt6qx224I6nSo7VxzYW343qtHJM1N9sXwXhOZcBpm79Ua0r0m?=
 =?us-ascii?Q?iqjdAvdSjymhjJ8K6lPuDIbNimSHIdP0gRKfYBK68jpe+VrVMaiqlW2rbkig?=
 =?us-ascii?Q?BbxGM1OtgXe3f1kJw9eyobbEGucbsTHyWLtaWPMLjNoJFBJ+XmFQVt0iyF6u?=
 =?us-ascii?Q?fYFA8uMB7vKYMFG3FfR0x/x/1R5xlwDKqPXUropy76ZRyQ/BlXlWBqO2nAH4?=
 =?us-ascii?Q?6PbrDG0xq8eSyi90OKm0VzdeyBqbZq2sOvF+J45Ac+yNFpcQg4CqmEtKRQb/?=
 =?us-ascii?Q?qVfiZT0Hi40tQH+zw6Ps9uXrnTMR1kHrOAlBIdrSCms0PcVegj18uccm4eFI?=
 =?us-ascii?Q?seeBRdqCXWrIWtE5Itk3o+r04T6ee/g7dX5Lso6sjr4mHkQGYk40jRNfBaS6?=
 =?us-ascii?Q?Z+Id+wecz2qH4IN2LbGXABhtReyQ36iScMqxHtYGZhb1DhpTPE1805/r2MJq?=
 =?us-ascii?Q?QWzua2Wv7V2mXA9BJmgGDSFE0CXOhJUegCDzFOT24SSKhUkRsia3YwQbK00b?=
 =?us-ascii?Q?1ladlNv3x3+VS4+RKvb2yRKPE4aoglTn7hIj7cE1u8GjpaOW8oZzflW8hDPw?=
 =?us-ascii?Q?qoOHLonMKt+2iVJR9R3oey+ZlkXjfglFidHYopndsrafO7MzDDRqeZpgqJYi?=
 =?us-ascii?Q?nSg7gh6KT/7uY8zi9GrmpCrsvcxslqm11xO8VNuofF4uvv6R4M21awt3JZNP?=
 =?us-ascii?Q?4O6lVheRqWY5KMHLeUFG/SAK4r0xRt123UYXrLS5zqVHA7OtT2p+7qQbeQe7?=
 =?us-ascii?Q?x05zifaR+QZ40YFlbrdZeGzrA9VQoocIQKe7AuTaS/6yjWU8Wj0wydAsJeLH?=
 =?us-ascii?Q?1YjvtQPhvKc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2L4h3MItWGWrkvAHNPq6U2oIlNKw3GBv/XKJs1gq7vy4vfcV61cRaV9plxqY?=
 =?us-ascii?Q?g56IJUJakOX1kJqsnJGQjlsMj/mJuetb30hhpciIstBJvz/cg/UlMdakmFjf?=
 =?us-ascii?Q?GJmhgoyAJ84SYbxu+fHhvpL+zNJHgKbLSmK+Uh0iQPRlbCOCeov35uziyAWo?=
 =?us-ascii?Q?e7gb7IkHwFH2WpBoEh/NEDynj+imFvji5QlWQpTXR1b0Co4jYObBYTcEEMMh?=
 =?us-ascii?Q?ZAmAcWNArubLOHsDc74GSRE5d9XBMy2Ds81yqT7RG94UYLNAWngwT7Bbmwnz?=
 =?us-ascii?Q?sSC5ixN4jBU+7UgSkGc4Ovbi9Br3Gsrhzgq1dvUk3qP9HR9KQW4XsUjadf4y?=
 =?us-ascii?Q?QUa+0wKFNDaHTdopfzDXzJb/j/py2phY59cEftcX+gSe+TXUQ2dv4b46uy7C?=
 =?us-ascii?Q?OQRcFtKR56Qom4SUJARzWZi0TI6VZy48EaMNHhRxQGhkSM8KJGMzIAQUGBjW?=
 =?us-ascii?Q?BzO6t7JgTbYd9E2cXQ3zuzGIu6w8W3vHNvsPJUGYDCl0z1MiKGKcPq5P6Mqm?=
 =?us-ascii?Q?Rc1nmiWfdo5wEWa0BCtXqA92R388+4PMr0EIVsVM585WUWH/ovTwGhUkbg5s?=
 =?us-ascii?Q?yYVCgy8eklX7KiTDJ9AL8bEHc5A2XAh+tbw2eTTF4rlsd8gW7GD9WY8MF/6F?=
 =?us-ascii?Q?u9Q0QjZw+fb6OHvloa9FVZIPG0oilXHogZegZf+aLqWk0dEnRtlvThvLhOoK?=
 =?us-ascii?Q?QyABLiEeBGAEJgDx89XXJPOzAcVt1+OteU8ppsQ5jxq0dBE8E8IXkY9u7xAv?=
 =?us-ascii?Q?TAuK+gpe7fH1YnyimK9+yP8h3VOFd2DfkobDI45Yi1JQ+cwl1iVxmGK/vcXG?=
 =?us-ascii?Q?wKMPI1r8ZOFFNqpt5MRHAajI3p/hmsSlogqtirjWCxqneLKjpnUY8VkMP4wn?=
 =?us-ascii?Q?mw0hcE33MMAIxoQ5ry4MrK8a7qlagErarIt9VfZgfvsS72kw+Le+ymkmRRbJ?=
 =?us-ascii?Q?hkVMTCOKlixIfp2D4F/8puMQBoT2u1Eg4JVhftdu90q8XT9+Mkvc2jp+FUVZ?=
 =?us-ascii?Q?x+nHlDC0C4wlJJ19a67fuVD5RHlHEceelz8pfLXjc7xPnRw6pz2VU43kyZrr?=
 =?us-ascii?Q?UiOv5yVm91PM9WhVNM4mKgt4MFR9sW3BXZkiaHxuWc/rAGwjZrmHWO4TBvj6?=
 =?us-ascii?Q?4Otn1ckBAVQ3efdH0ErJzxkoSHAkk3LngVFaLH+K1slML29gYZTWZ6HZMEWl?=
 =?us-ascii?Q?MTakDyyMmuB6kmgH6T8/+u7n/9T/znlGjrToBkcmFJIKGwvNpqZDg6G2TQCE?=
 =?us-ascii?Q?vN6QOOhoXdTHlfm379ddekKJHXxvm3vd9fP9KtrpCh8ElFoH+c+xGPPGSdYW?=
 =?us-ascii?Q?VcJPml+c+ahpcDFm+JTUwEE9U/1FqZEjfqkK5WMDGUseWIyIhDUEuUUNoHep?=
 =?us-ascii?Q?8+rLsdLHHDBvsVKXswrJaP5A2eq7vt1HZvlg/njR+AJKJauyU1sJgSnck2Rl?=
 =?us-ascii?Q?+kSiy5Pu9DozDmxiaWJMByagMvcR9RHJ13Oo6D53YLvQd4jrPQwQ+J9M0I6E?=
 =?us-ascii?Q?/vC+botSa3Y1tZZDpvquRodIa641c1kcm3O5EI52vYhgBJhhNtXA1kVfBkah?=
 =?us-ascii?Q?yMPNHED1SFQ1mFfSZGAlA6N0wKSCCDKmnuwvaw7zVIOmClmTbzni3A73PTSZ?=
 =?us-ascii?Q?yA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	y5f4zoaIkcgw6m3E+McqUedR7ks8kUa3JWVAIsgjAFHFAB02R5rw/7R1oC53lKjvPyM8KAGjGpU1mb2hTTMSgfz6JgTIv1cRM4FKht2G882Tbu4PrzxkpVUJt1wTJnwU46vQNsrcRpgQWSo2c/89e3yjnqmDC0DBso5ioUe6qZHGPUWGicYNIcbXMIX3pviqdsvGI5PGCwV2R6l/NHqk+rtGzjzHp/7zlUM3GuTryd1edTgaXXPdXmUxiuoCGpXccu2N39ngDVunXWGQqmp9Nh5LJ4sGbuepPKH7YyebSWwrsAz0Vcted6f54TFAE7oTh8digyWfg9jIBlopy6iWAtb/Jkbu03SqwbT8vmRXD9ox/OuyuYRwYUgPSPktYHnK5n5MoMPyUilYRayPu3Z+KEZ7e5QeWdB6PLz1CEsk1w82YYoEgWV4o3VuZ0fVX6l5v480CK5ah93iWq1hxcY2hB1O37Q4o4QVipEFk+Qvh4MzvIX5i1i+Z45+JNqesHDam096kUCgiF76XvLO5qAyQpvPI4YCvc6uhtVljspUf9ry2WbjYRNHdhQ0N+Gaj445V3dOGkwdgCmS+wJZH/ctgSi9h3Oo6t1XYgQ9Yjw+BC4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85f640c4-4b1d-45af-29c8-08ddd9b798fb
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:52.6547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H6bdEbO3ycJl07j3fhNMtuO3SoJmUu0/Iu91fFSkIuOpt0MBaG6L2xdPM0I6CWA6WiDVEcgmKYLYFbNr51mKiIt3eM5fdV8jZh+49lrOzRo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Authority-Analysis: v=2.4 cv=B/S50PtM c=1 sm=1 tr=0 ts=689b622e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=ClgePVbc09Q9qcuFiq0A:9 cc=ntf
 awl=host:12070
X-Proofpoint-ORIG-GUID: VjVhl5aR6Zk1nkCxh-y5Z2u8d97ai6JT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX6iJ8U7BK9B8f
 ztD8z0F80aKrX6xSKqMLhAi2MKDrUEQOHNrtQqQ5bR4hAvLj0wpa1+GhqXeHGJJDfythgcGK2d0
 H3bRpGQz8UbRGnOjVPuh4YnlU2IvuASrnyL9LJbf5TSQOzvrlaSWfS07kPuKKLXCmaG/AC6V8aN
 kbhpe4SJAIMV1U4UgfyumHcmL7l9RzbU/FY7HsB1Vbe1pcXA+vUSKgC+Inb0cvJiTp8BLooiNyf
 QIGG1VF6lOUcplLKWfwrUAMeJzoN/OMDISB/i5S3TMfhbelu+V58oUrICtWKNNTze76bAvqBMZ6
 eagYQZfG8NHCDLvkcv6Lh6IYR4XT3fmYSqt8+JC8xiwBExl9BaO2/3EmDpcxHEoejvIm001HAUE
 1KElHzZbQMmQQTKrWdiTRW+EGHpT5tRckI+NO8y7RtKqe0mP9vPoZEufb1MJgIaDDV4cTIau
X-Proofpoint-GUID: VjVhl5aR6Zk1nkCxh-y5Z2u8d97ai6JT

There is an issue with the mask declarations in linux/mm_types.h, which
naively do (1 << bit) operations. Unfortunately this results in the 1 being
defaulted as a signed (32-bit) integer.

When the compiler expands the MMF_INIT_MASK bitmask it comes up with:

(((1 << 2) - 1) | (((1 << 9) - 1) << 2) | (1 << 24) | (1 << 28) | (1 << 30)
| (1 << 31))

Which overflows the signed integer to -788,527,105. Implicitly casting this
to an unsigned integer results in sign-expansion, and thus this value
becomes 0xffffffffd10007ff, rather than the intended 0xd10007ff.

While we're limited to a maximum of 32 bits in mm->flags, this isn't an
issue as the remaining bits being masked will always be zero.

However, now we are moving towards having more bits in this flag, this
becomes an issue.

Simply resolve this by using the _BITUL() helper to cast the shifted value
to an unsigned long.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 include/linux/mm_types.h | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
index 46d3fb8935c7..38b3fa927997 100644
--- a/include/linux/mm_types.h
+++ b/include/linux/mm_types.h
@@ -1756,7 +1756,7 @@ enum {
  * the modes are SUID_DUMP_* defined in linux/sched/coredump.h
  */
 #define MMF_DUMPABLE_BITS 2
-#define MMF_DUMPABLE_MASK ((1 << MMF_DUMPABLE_BITS) - 1)
+#define MMF_DUMPABLE_MASK (_BITUL(MMF_DUMPABLE_BITS) - 1)
 /* coredump filter bits */
 #define MMF_DUMP_ANON_PRIVATE	2
 #define MMF_DUMP_ANON_SHARED	3
@@ -1771,13 +1771,13 @@ enum {
 #define MMF_DUMP_FILTER_SHIFT	MMF_DUMPABLE_BITS
 #define MMF_DUMP_FILTER_BITS	9
 #define MMF_DUMP_FILTER_MASK \
-	(((1 << MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
+	((_BITUL(MMF_DUMP_FILTER_BITS) - 1) << MMF_DUMP_FILTER_SHIFT)
 #define MMF_DUMP_FILTER_DEFAULT \
-	((1 << MMF_DUMP_ANON_PRIVATE) |	(1 << MMF_DUMP_ANON_SHARED) |\
-	 (1 << MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
+	(_BITUL(MMF_DUMP_ANON_PRIVATE) | _BITUL(MMF_DUMP_ANON_SHARED) | \
+	 _BITUL(MMF_DUMP_HUGETLB_PRIVATE) | MMF_DUMP_MASK_DEFAULT_ELF)
 
 #ifdef CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS
-# define MMF_DUMP_MASK_DEFAULT_ELF	(1 << MMF_DUMP_ELF_HEADERS)
+# define MMF_DUMP_MASK_DEFAULT_ELF	_BITUL(MMF_DUMP_ELF_HEADERS)
 #else
 # define MMF_DUMP_MASK_DEFAULT_ELF	0
 #endif
@@ -1797,7 +1797,7 @@ enum {
 #define MMF_UNSTABLE		22	/* mm is unstable for copy_from_user */
 #define MMF_HUGE_ZERO_FOLIO	23      /* mm has ever used the global huge zero folio */
 #define MMF_DISABLE_THP		24	/* disable THP for all VMAs */
-#define MMF_DISABLE_THP_MASK	(1 << MMF_DISABLE_THP)
+#define MMF_DISABLE_THP_MASK	_BITUL(MMF_DISABLE_THP)
 #define MMF_OOM_REAP_QUEUED	25	/* mm was queued for oom_reaper */
 #define MMF_MULTIPROCESS	26	/* mm is shared between processes */
 /*
@@ -1810,16 +1810,15 @@ enum {
 #define MMF_HAS_PINNED		27	/* FOLL_PIN has run, never cleared */
 
 #define MMF_HAS_MDWE		28
-#define MMF_HAS_MDWE_MASK	(1 << MMF_HAS_MDWE)
-
+#define MMF_HAS_MDWE_MASK	_BITUL(MMF_HAS_MDWE)
 
 #define MMF_HAS_MDWE_NO_INHERIT	29
 
 #define MMF_VM_MERGE_ANY	30
-#define MMF_VM_MERGE_ANY_MASK	(1 << MMF_VM_MERGE_ANY)
+#define MMF_VM_MERGE_ANY_MASK	_BITUL(MMF_VM_MERGE_ANY)
 
 #define MMF_TOPDOWN		31	/* mm searches top down by default */
-#define MMF_TOPDOWN_MASK	(1 << MMF_TOPDOWN)
+#define MMF_TOPDOWN_MASK	_BITUL(MMF_TOPDOWN)
 
 #define MMF_INIT_MASK		(MMF_DUMPABLE_MASK | MMF_DUMP_FILTER_MASK |\
 				 MMF_DISABLE_THP_MASK | MMF_HAS_MDWE_MASK |\
-- 
2.50.1


