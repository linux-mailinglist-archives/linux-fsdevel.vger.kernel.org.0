Return-Path: <linux-fsdevel+bounces-57517-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9C7B22C01
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E60B503EA4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A672C2F5304;
	Tue, 12 Aug 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RM42DcKX";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wzT+rkWz"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDBD3074B6;
	Tue, 12 Aug 2025 15:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013700; cv=fail; b=itSTz6Jb/6qhFqnJ62w1ISkJW+PfXlLXmdJMR1NEM86SIngYgreOu3YQnEpVAv5p+E5/TFEBu11KqoD1qquTDwBRdHpU1VSjmb2kpgoZ4x4NWyIyhVfJHZlFLNVjdrduaIA4KmVxExJkeci2dAefhgjV+0GLYPPewkO+VPJ+pmU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013700; c=relaxed/simple;
	bh=cixjAYe3RjZh4/efrNGcNfKEhv2fk/tqRXNWa6Pa0AA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XM/JtJdXpQ3ind6U16zihkpLf75ui7MUAizVGRjlP8TrbblCJXwa0atJ7JIOuzD7mD2GXM4Xj+X6KOFK5Kg7Xd1G1HI6MEYyE6lHTK2kg2o+LOdtlF2uhAzsgy5db5DQ0vf/uTSL+/AWqJKwS479foQI7DUiFCxzeU/X556XD4U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RM42DcKX; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wzT+rkWz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDCPHI013189;
	Tue, 12 Aug 2025 15:47:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=kvIl1wwqB4xCBVSduPHr+/FwnBDRvwG0uk/KaklWS0o=; b=
	RM42DcKXLjK5sU8IyHdqmg+KFecVwXb8SZXkFB+4H1y/RcRojv/0Uyb4mzCMt4f2
	vfzkRc09zelXFPQx3v0UNtSA5V5dyA8A1d+wQh9aoy3a3vbk7bBsaB3k2SMxnajH
	ixM3rgbGm1nMMRurxRknZAYWhgrBhjfnK/Bd48VrpHua1Sy58VHlQrCZn8ikAz4T
	KogpiMHuyTt2Sou/rS0TrBE3+C4OSRcAqrpZpilSEFfrDhJfNsVKQKkn0kG9YWaT
	DLRT1m/1PrWoTHmRPzyzLY6jr6oj7shPdRmiXy8SybGjnUlKD8Fa/lNVGnBgoGUq
	MTnUZqqgwGiy3nnq03i4sw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44w2ue-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:44 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFG3PI038544;
	Tue, 12 Aug 2025 15:47:44 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11on2060.outbound.protection.outlook.com [40.107.223.60])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgp926-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hEWOeCHdA02l5cGKvYpoMxnVUxVchqpI+8rpY9BqTtezqGItePH6HR80wnpvOCa9rKY6ryPI36nNsXGuFJvzAh0AsutFA7Yg1ESLU8C7zCRys8AZzLpiHf325z/KRD4huAIjk+F30TfITW5n8PFGLAV1hUdKWvW093A+0qyP0p3scbfBbFbjmGXoq6y9O6463P3Cg6t+ziuDL3ZoAyKHit0jjzftDWu7iqVynVLH+verBjNGbvmEm8/EoFZcLe/t+bupLtR5Lb5DPc3cDro9rP68s28iTtSGrBX+NIcoOfCkCXZrTrL4yxzMSFe2f7y9LDbzmWMsXWUy4XhfKMkfGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kvIl1wwqB4xCBVSduPHr+/FwnBDRvwG0uk/KaklWS0o=;
 b=VyY+RLkTydbcR3GnJV508st9byKx7MFQTpCrmM9EK9/OVY6ohubCn4IySlDv1ytIjz21eoVz5EuhO8G2GJfWuI2aUqOFKXKd+FrR3uR6V0vgUQ7VToK+tpMT9dqktP3dfTS+lW0ktX+itCizgK65I8HQEy/m5r9GiL4zrjNjwocy0nsXm6S/Iw+qtDxkUSvAUYizxV5chjD1fA3RKrEVbUhhLoCaSU0+yXgXkP0KXhkxwfPLRo8Brjje2ErnORGkEQNQPt5Sa68yA1ukgYTg3NnOL+Vr9ZHeZw32YnES7+5+E/u5b+NfZ0tu2nLCCJ5Y5hFbdZO/+6O3Z4puVTWkQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kvIl1wwqB4xCBVSduPHr+/FwnBDRvwG0uk/KaklWS0o=;
 b=wzT+rkWzkiGNvRXslwT3nXKejJf2T8oXHM66oNULah0CONEtnWK08IctSJehk79T92WQzXgm8e+fJkqNwE/D04Qxu+/mvbVCKcAWxtnZhYS+5X47tJ7pqA34o9YcI3AKpFPVQBNSGOlljPmHA8/q+kmZOHkws1RauYI5F3FFAcU=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6329.namprd10.prod.outlook.com (2603:10b6:806:273::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.21; Tue, 12 Aug
 2025 15:47:40 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:40 +0000
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
Subject: [PATCH 04/10] mm: convert arch-specific code to mm_flags_*() accessors
Date: Tue, 12 Aug 2025 16:44:13 +0100
Message-ID: <6e0a4563fcade8678d0fc99859b3998d4354e82f.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV3PEPF00002BA8.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:144:1:0:6:0:1a) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6329:EE_
X-MS-Office365-Filtering-Correlation-Id: a6afb426-fd17-4e3d-4a69-08ddd9b791b5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?pDbMVEmQsSMoveAavRzr6f2RBdfsUablwnCn4gWaP9TsB11cciLcxQ/NjvNd?=
 =?us-ascii?Q?G8eQ1fNoJdxi+U9rGp4obJa66GK4Rt+ZGINcGgtDvsB3BKwc36pfBlPBrOkx?=
 =?us-ascii?Q?NMFUgB20Lp6ybme58BtAwNhJkbOjEx2fLUA0fMr9xVH4QMFNtvNL0FchfgZx?=
 =?us-ascii?Q?GaCbGv/L3j7/18sJJQsyjyiPRDzYLRsqgK7oAUCUJ1xB8vmUby9xyXLiZ4Jv?=
 =?us-ascii?Q?BLhmqTniZDYcmhoz+myUApvO55/5B2we/d9/IYpJ1W/lAMdpdMy6jhLyua/y?=
 =?us-ascii?Q?nV0aCb2693PX6KDXwuTrgr0Vv8qvVu54DO7IK2lhujrBDTar3Xx5vE6vJttL?=
 =?us-ascii?Q?HmWoAWJKT2VslsFwMAxfEseYoYAmAYoqPIZCGNPxEgCQvoKkOFYUk3dvXCQA?=
 =?us-ascii?Q?TBHVf0046g+NPx33ahrqNgGV8S2juTfHJG7DIm4oIrg7CBxcCfuOjuGlGLzC?=
 =?us-ascii?Q?uZhdEbra/8wLERi+lt/iKLIC+0VQarlA1wUUP1myp4Dxmbs8sz7JTJa2LX2k?=
 =?us-ascii?Q?kqqyYB/DZd7eSTkmoxO4fq3hBE5L8cg3By6v6ZGqZ9MUkUrJPVebk6kTh3sl?=
 =?us-ascii?Q?YB5NPyGEvgtbI8V0osNRv8pchCuonIh52o3DayZVv7U+YLvxAf1adInZqFdl?=
 =?us-ascii?Q?oE/UIgzfOBZUj9jTAqNhrBaEUj/JGQ/3GMCIjh6PstWBbRHIV+njNJ7D8mhF?=
 =?us-ascii?Q?VFaUQbyls+CHA7pA8U9DASpHh3U4rQM1cE6gGWuuG84QdI0KLIIcvLXpvTXh?=
 =?us-ascii?Q?xrYakwcv7eL5FOD5ek4j/hz/hLz8+Q4iF1gDI91Pj52jkjnbUg+sEc5dRmtV?=
 =?us-ascii?Q?C4Tyc5wza5ZulM6oEoV4tQR7/OxF1uS7LGo5mQQOIuvR8hbScpml/jxBFrKt?=
 =?us-ascii?Q?vOUTWERXVtGao9UEuKQpRwKs63bLRv8m5QCVrxV6cm9nl2ipyilpXpwTaD5l?=
 =?us-ascii?Q?kODa9rOWBorwttbEHI81A3b/zB1aGMJHnZ58ONHXwO+4CEFKoALW3CZb08Xd?=
 =?us-ascii?Q?WiYHP9T60mFWdoUouUIvaHGaiBJ3/zgc1WWc3qOSLQwsj797JkzK4Jw755nZ?=
 =?us-ascii?Q?rCwQ5oXfcZQYhyly2bDXMfD8hicBXzD9G91shHvKqHU95/sRvZEHYBs3rr63?=
 =?us-ascii?Q?oTyNa/1VLAXzFKAh5HsuZnCcz/mOKWG9AXJXxBU4QO4TpENlA9jka1qNJMdj?=
 =?us-ascii?Q?6hDwrAAG/AkIO0PsZBUpvAsuhLx1hIIxK4hv4rZVF+DQbtt0ZMbQ12FSIKKd?=
 =?us-ascii?Q?Ur1tJBrI9aEpaR8+IF9IEqmNaBJFXbV1+/iNosP3+ti10EHou5CR4kTHBCyX?=
 =?us-ascii?Q?I1Ufmvl0Jdiv45/PUS1ZxQQGe/Te9MgEy2GgwT50YBK08Nysom1dRDpZCcQE?=
 =?us-ascii?Q?wXphW7qNXm2IeWsyWbjb4xb/b6+upKvQ43496trLu9VBgjmg+rTvqxbvROZd?=
 =?us-ascii?Q?h6EVnFSfRWc=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?pMtemaMO630wAn0s69tqL6FKw42V7ot/VPE2Bcrsrj4Y5iYl+sTKa8OYsCnt?=
 =?us-ascii?Q?6j8xSd+U4xiESPSYGnN7SHKDW/XnCopCqy2FG0yWLIEfX1aQSRHS0tJsGI/O?=
 =?us-ascii?Q?Bw8o2VmQz+PSZ8kyGv4OkvTkmnJl6JcyiEu/Ntk6eTtg18A1RV/FaDHZMZS1?=
 =?us-ascii?Q?sxg7MiOo7HFhz7YaSlR6JR3vI4dhqzSQnZ4wZQ1Uxmeds5qxzX6RBfThCCPs?=
 =?us-ascii?Q?wpBOKokiRkktuOK+AWudieOSnG2Q2GmzvCU78zuPzpauhAAPi4+bFgquh5ss?=
 =?us-ascii?Q?y6VK5cFquX9I8/8o9RwoSkg2H+TBo4BcvQbgKqaJWUVDAykqX0zVzLW8kD59?=
 =?us-ascii?Q?slr5LTBhko18L/zQz1Fnvjep8EKLEJ3R6o7EzzyyINiHYHXlbLyjBosmrF1M?=
 =?us-ascii?Q?3tEjP/QaxI14JfMVarBjUMGpXSUIsICfCwoRCUNu7s429T7CyMA0xV/dOgXj?=
 =?us-ascii?Q?S4WtCp06k1azCpKZLPMMCql+tk7Pr4Xb1e1b64jbvLm1CkpFk2lU8O3vzCOt?=
 =?us-ascii?Q?HeyBxNBjhJ4X/4zg99Rv+XOjrREj2YjOEH1LddN8o+Qc9yTMzAfvOjJNUOc9?=
 =?us-ascii?Q?id+w11rbtVL51gvxiFirlHZjJAYEX4XM4UnuqLyB8Nt5wOE8cwwIIhIdWsOy?=
 =?us-ascii?Q?RaOTXp640TdfhvgC8uHHsdFDkX+k9tCyNov92zisqZuhvbU5tFdU0goEoUSX?=
 =?us-ascii?Q?Z4hgILQ4W/yKzijtcduXDYQ8V9W3ZIYMFPNzWz9dbAU8VtJkatn9F8NjptxK?=
 =?us-ascii?Q?9ndNPI4EKGV24kayrOoHAwretRDcnac9T/kH4Tq4PQFnKRkXFYifGUNoZiCx?=
 =?us-ascii?Q?xtTDyCIfOILLi5KGcuJo8VFXSD4gRbHB6h9tF8N7KDqUAv+iRNICF+K6fW2W?=
 =?us-ascii?Q?G2loluJeQytY31QTRBGG/7rQasAhI2h5DgI+zMR9xe0ZolAuzPwKWkvC8Jrl?=
 =?us-ascii?Q?qo9InZuJWiqEr66dZRHpYkAz96oqTQ2dJVJoJ/zW1H/P9iyZ2/YXXu49UOpV?=
 =?us-ascii?Q?XdDlhvkpZU3AQaQZDOBD3LGW6vRE7Un3+cHPOCGGmyCVRcV5nf9I2Fr8q2Ti?=
 =?us-ascii?Q?FvM3M90O1fFH3GNrD1iOIWifk6EIjGawUWP0O+mTkL5qHzc8BsJGRctVEaiw?=
 =?us-ascii?Q?KV9xf61HUE3FlCCsbYqcnD0m0Pn53LX6X3FGlSFLRNK0hHCm+xVfNJTlJDwy?=
 =?us-ascii?Q?FB3FWYPY/aTaYU3t0ad4meyZiOakBpwuH1A6BtbkcHIwkO5rCsGAW1s5ly2i?=
 =?us-ascii?Q?kKv1tbQuWtOr1CoZfSzJ60o/liYQxV5XVGJd7zVthUPEHacOFO3H7ty8LZOg?=
 =?us-ascii?Q?VENvdGkHIAtoGxhfSGLScQL1RCJDKe/SAjofkOnDjJlGM87v4bCD9rBOdvfu?=
 =?us-ascii?Q?Fmf+4xa6KwsCS4O7g0SAAnLz3DLUEolxYLFVECs92GezKIRmp0J9wNkqQzvF?=
 =?us-ascii?Q?uHB+WYysU3qRnLbt7wQKSU87MHKV9KWuGLeVfeyUgYK9b/lc9m+uRgxbzixY?=
 =?us-ascii?Q?ha6EpmjOgFvVF1Kw5lQaycWHd76EgPAmQk7AcJnOiYfrKnDK6zGD9wNtrJAu?=
 =?us-ascii?Q?2Y2y9FAljdjlwHohyxAOKa9UmcVt0IOCKYXrTfO6+3Lt+jywB94RgNjcvRVN?=
 =?us-ascii?Q?ew=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Jl6nEsMB/xVrFMpizcgufJm3tNnR1/380vYe+lb8zQrcqgdUV5FOGTo641KxReijpRnDpFLsIjpaI0iat1PdRZ6BPlb/LoRfGKtiQX25Bt2oa2U2NYEseh/P9ClDLSK74II5WxnS1CfxJVSsStRX5Gis6T9FwMSE1sFMen2i+pA6dtWIwEd4oR3L3x5lJZLVBm6lO7Nir5S2nT6JWVEbuUkzNhwOLI9QmFwkWIECneYC3OAwjXmQMm55GSl8Zcy7CHNPVnH6Ue2iAMFh/ln4DHd0Ozx1tw45SwBwvnD2J1wjAjfz95g2ZCGUgsU1sdq7ifeQTM7oe4q+dMOMp4IIFjCRSsBsRR13c/fBeDLprY78mNeytus5fzS4hrZU7oK3OXjiQBGoLCU3GoA7i1rTJ3Lz9mAzc6E+QRv7OLlbCSSPtVmopwS0wwjeZW37WV4xmQZ6jSIX4vSVvHrrh6KAncrCYp75ZxmWHpAJqMkgCton95ih+mv/pdSX/BmEw+khBx18+0JJHjvFWh5J+Zmm0hJw2yY5RCn4fP+8tCUDyCvAt5apWTMaknMBA0Fy56UDsTRuaL9Y+uCPq+DHkX0mW3kVA5yqz6VQccmN5TozeF4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a6afb426-fd17-4e3d-4a69-08ddd9b791b5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:40.5613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nW8EWpbqfFTpR6ZhzU4HCAxiUT7LK98Zmo7s37Y3S29W8jDet3zYx9q0mYmMktAJ6sqStA7yn7k7YINxh9ICJ3j4TWTY75MdeOOCZ9/cR2g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6329
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Proofpoint-ORIG-GUID: 2WjLIrO1VfdG14HOxDuEEVrB97TH8sd4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX2JI5w3Zqedxf
 PAew3KhQksY94q3yP2sX+u85vVfOIVJTwRwstUafeAhXtOKl0SOLuOVED5Eo1K3VpTP9VlwpDIr
 UKdoUVVvd7ZU0UnDMS7jxhMmDcMwc2tWYvmCkVRUdhpsptmfqJhH8pjMurjRak/UOHhjCfsK157
 2Dmy7kNz/wRyWznmmZNNTX6K45WDlAfIzWXEViRg7lUSkkoYP96JIXQHw7BrFQ+vcpVMi+7erhN
 XssoMNg7RiEMA3JAttdMULdupvd4E3ATgFXk1cNqUVerQ7VPYmZ3ah/hmwSXzqMQ/5w3A00hTii
 RwdmUVMFJBaZzV4agd0fzbOZkaPpvT5BY85fr/F67R5TfK2N2WDF/lBtMAcBuK+kcP20Vw3bZvA
 XIpz7LOrggUOXsfQybRGAlcJdFvYnVDSslATIClRhadCAxGHUG2ZjkK52bVGiapBlxMgvrsJ
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689b6220 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=D9yTlg5YotqNTrSC_pQA:9 cc=ntf
 awl=host:12070
X-Proofpoint-GUID: 2WjLIrO1VfdG14HOxDuEEVrB97TH8sd4

As part of the effort to move to mm->flags becoming a bitmap field, convert
existing users to making use of the mm_flags_*() accessors which will, when
the conversion is complete, be the only means of accessing mm_struct flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 arch/s390/mm/mmap.c              | 4 ++--
 arch/sparc/kernel/sys_sparc_64.c | 4 ++--
 arch/x86/mm/mmap.c               | 4 ++--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/s390/mm/mmap.c b/arch/s390/mm/mmap.c
index 40a526d28184..c884b580eb5e 100644
--- a/arch/s390/mm/mmap.c
+++ b/arch/s390/mm/mmap.c
@@ -182,10 +182,10 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	 */
 	if (mmap_is_legacy(rlim_stack)) {
 		mm->mmap_base = mmap_base_legacy(random_factor);
-		clear_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_clear(MMF_TOPDOWN, mm);
 	} else {
 		mm->mmap_base = mmap_base(random_factor, rlim_stack);
-		set_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flag_set(MMF_TOPDOWN, mm);
 	}
 }
 
diff --git a/arch/sparc/kernel/sys_sparc_64.c b/arch/sparc/kernel/sys_sparc_64.c
index c5a284df7b41..785e9909340f 100644
--- a/arch/sparc/kernel/sys_sparc_64.c
+++ b/arch/sparc/kernel/sys_sparc_64.c
@@ -309,7 +309,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 	    gap == RLIM_INFINITY ||
 	    sysctl_legacy_va_layout) {
 		mm->mmap_base = TASK_UNMAPPED_BASE + random_factor;
-		clear_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_clear(MMF_TOPDOWN, mm);
 	} else {
 		/* We know it's 32-bit */
 		unsigned long task_size = STACK_TOP32;
@@ -320,7 +320,7 @@ void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 			gap = (task_size / 6 * 5);
 
 		mm->mmap_base = PAGE_ALIGN(task_size - gap - random_factor);
-		set_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_set(MMF_TOPDOWN, mm);
 	}
 }
 
diff --git a/arch/x86/mm/mmap.c b/arch/x86/mm/mmap.c
index 5ed2109211da..708f85dc9380 100644
--- a/arch/x86/mm/mmap.c
+++ b/arch/x86/mm/mmap.c
@@ -122,9 +122,9 @@ static void arch_pick_mmap_base(unsigned long *base, unsigned long *legacy_base,
 void arch_pick_mmap_layout(struct mm_struct *mm, struct rlimit *rlim_stack)
 {
 	if (mmap_is_legacy())
-		clear_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_clear(MMF_TOPDOWN, mm);
 	else
-		set_bit(MMF_TOPDOWN, &mm->flags);
+		mm_flags_set(MMF_TOPDOWN, mm);
 
 	arch_pick_mmap_base(&mm->mmap_base, &mm->mmap_legacy_base,
 			arch_rnd(mmap64_rnd_bits), task_size_64bit(0),
-- 
2.50.1


