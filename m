Return-Path: <linux-fsdevel+bounces-57516-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BC32B22C00
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A04003A8EEE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:48:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4739A30AAD0;
	Tue, 12 Aug 2025 15:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="W0bptYwl";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YaQJopiP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED109307AD0;
	Tue, 12 Aug 2025 15:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013699; cv=fail; b=XVg6d/DPLFeGra1NA6BTo6vi+DM70YjVLZATxvCRq3GgECLnKu3ief3u5diLsqcbztdUL8QVm/NPsoS6X4hU7/dq3C9GNn0pq0nAItyhzT1TZ6/Cl/dufuBLN9HMWll33OMo8eNj3Q4q6DbXYkJZO+mDscWxY0W9gpIPGGzA/is=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013699; c=relaxed/simple;
	bh=U1ICUI4Tc+s3oi7vsvLwAOGthFT+G72enw4Q6xUQKGU=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=pAoVcGwd2CP7rvI7t49cYbC5V8nxYNU7bY5utgD0nAvLdA7RFg0FgGY/JWs+CxtkqSLTUTd4Ug7n73Jlx3/HWDFZjhPQTFKqPL2l27xaj8nUW2Qt02lNY17peHJy6FRZ1P9nn3mRTgnix9r67k4N72OwvlQFjcZvbYQwZdCB3xQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=W0bptYwl; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YaQJopiP; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBwlQ012369;
	Tue, 12 Aug 2025 15:47:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=corp-2025-04-25; bh=Q6L2hCwysftzBCRi
	GqrF4YNBf2tavN9m/GZdmGycchQ=; b=W0bptYwlBpTnK4Rw5WjCb7+FFN1DEQAJ
	UxdbJup5xRp8OMHVlpxTos116z6HY7Xvc5kmGH9yboESlsTDvi9V2cMbpKwlGbPz
	55X2XtBgHyzEzrO3EwSY/9bMf867cQX+FC0DnaVgfahl0edIdPwXRm2OP7WhF+w3
	ndVjOfHalcGRe6xbpoXly3DmyXaGlvrgi/2dJOkdpN2RO3bTcaWytPiBNskaLDC9
	1Z5W7eg5PvPRErEDPeF6YQwGAIYmP51FY7eTPJMmsysK2uHLCLXlq3EWVXV9yujD
	YvP1fddn2F9kIricx4cK9RHb2uE7wa83M4kOen4ZbODRke7dbLLwrw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dw44w2tn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:29 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFCB8b017597;
	Tue, 12 Aug 2025 15:47:28 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsa4xv6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:47:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VAfOku+drR0V9rWPwi0n3f7tZeVRZUK29C9Kam+c8WJr7jSw+ee7cPX1hB30/Jzl56El3tz2jfLDIsmToVtt1GZ8AJRX7YmpIr52FV5RtM0aeVMtYHY2tMrPQY5PVpWDeqEIZR/zwDA+a8s4eiO4lAXFgrLZi6rzP1ss4C38pzrhrtgRXDH2pKlZaG7tXp1lkXVOSp7UPQsfOqpaWk+ZtsQugMcOCX4JqIXsuC/3mH6NyQ6DzjjgoF/jehuJPyJ2KcDeQjxEXhuEIqbexVSQV04iYBfksHVSlGFvWJ4//qvbeOwR62tYybYXDkvU94RUOE+h/HoeIWVBYkbt+7vcgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q6L2hCwysftzBCRiGqrF4YNBf2tavN9m/GZdmGycchQ=;
 b=KTfC1GUB3SNUeLxy5OOYR1S2j8fReVPB9+1beIxQ73KWXPdKBUVsDiHibGTC8U2p/7WPmtgBBSJDRCsxzQsuINmQIrUVa3MwqqKLrhO1lFYFKOOtwc7zeFz7Ml+GlWzqgGp7x2ldpBrTRDxYEd6QHbn7FwiN5Aeg0Np9hurug0LIyztK9ML8LtwKFO4umEGHZTHvJ8hFuJuAaRzDW9gGYjkwbcYRprZ9hfu8alMehG8OX+3QJjl6ULqvF+Z6PepIL0QHDyt4jsHadNWCJ0s0nwO+rP8b/yQ4XtGaX7NoV1ewoqbQX3G3DlepsC9AUz8lo9e7MS9BOPsKQbsUMvYLyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q6L2hCwysftzBCRiGqrF4YNBf2tavN9m/GZdmGycchQ=;
 b=YaQJopiPlTCHfaE/YehvUumL88fVnQ+T9Tdz+W3TvaziKzs/3BoG2KCp4f2Ey59ieMbEl3zBmrCTZjHNSLkgZstyOalo9JTHsGPigpSo8hcCycJDr3gUb4D+Cj5avjydqUsttl6nY3FtbN/XnjISJIAbXblDR4YhuVhF7nkyu8c=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by DS7PR10MB5901.namprd10.prod.outlook.com (2603:10b6:8:87::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.21; Tue, 12 Aug 2025 15:47:23 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:47:23 +0000
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
Subject: [PATCH 00/10] mm: make mm->flags a bitmap and 64-bit on all arches
Date: Tue, 12 Aug 2025 16:44:09 +0100
Message-ID: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GVZP280CA0059.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:150:271::8) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|DS7PR10MB5901:EE_
X-MS-Office365-Filtering-Correlation-Id: c81307d0-201a-4109-55b0-08ddd9b787d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?RrjwSHau6mJv/K0crqdpHa4KfLDJqW65jZrhw6bqjJp5v8a5hzhlCTVoZP1R?=
 =?us-ascii?Q?VFdRA9SqJx3Tx8cz/JJyS4Lp0Y0KiPXZWVWQEo70vrU37uAx3Prgc41A9DfM?=
 =?us-ascii?Q?gy6/tkZmWrn7+Fe57iBxju8LZrPHo58ZnFWmbiFe+XpOhgEE+grXcaPBXJ3p?=
 =?us-ascii?Q?ZAt9YRWo8LDhtHoqtiGfaKFTnNJNTPxPsduVaupwIzALh5EVXg/qv27uj+6J?=
 =?us-ascii?Q?5VJtwXfi3RULU7fIO4XIUORfpvm2k8XQoVS1oYiPy+c58EU80pjD/QYTmovw?=
 =?us-ascii?Q?2RRyCsY3+3yltZ0HTg3VA8UCH6Z8YooIWEuF7NC1ZiCToHXtJi/jO2owMQFr?=
 =?us-ascii?Q?ld/8cvhv9+zu3mihYJ+pvV7o7kb7xKzWFyjpm+A256+toJ3BFrKCF7GbnCur?=
 =?us-ascii?Q?ujeb+92/MUsLTJjc4ltvLMn1oofq1dLarMoZ7MCxWq7bUvlbAPs1XMRulC6z?=
 =?us-ascii?Q?ozjEiktKP+EGcpucpGQCjbQjqGeawhlAXaE2JOiz90YARkk3peHAkdXjq/MI?=
 =?us-ascii?Q?pX08XwgyVWpFNduXOYDYgn71yT6Udmw6b9FNA4uFIuAVnWv85efQos9tIxIA?=
 =?us-ascii?Q?plrGvQfE+m4cXVELqJGY99+y4gIVlT27jW3doJdk1awgcS4bKxEmvKKWQS4K?=
 =?us-ascii?Q?kojWJasMWrEfYbprmfTKeHuQ7p72P+Opqr+PbjaC6UQJEmdINceLb1iYa6jR?=
 =?us-ascii?Q?6peXxFJQEJZNNiGp54oWDTt7FQd28e0wW5pyIEW10+9o+D79MO3ordjCGwOL?=
 =?us-ascii?Q?AteQP+TBIQRR1JUy/FokW3FA3sG1bUfT1eIQ1vuPgyzER7vDTqt278qsc1tD?=
 =?us-ascii?Q?nMzIGnZOlYufPaWfBgo9K1ZgJdw+f3U9wuWrfYlaeX4ObpARwTdgbEppvfq3?=
 =?us-ascii?Q?dqu7EY9MQdwpye36FX8Zsxc8UbudR3ygBJDIezPDsC/SqHEE4bJpvym+qcw2?=
 =?us-ascii?Q?OO3NYx7lBsrDJg9kEfQ8PR3IG6Qe7+UtgxZEiv6xBagyzdDVihig7Qe8KeL2?=
 =?us-ascii?Q?3VSqLV6IagDTR78HdbD67tO8ibpOG5Rh5F0BIRAOy8t5ax5YrkRr6KLGk/6M?=
 =?us-ascii?Q?GbAYsXbvDPhNQcrTEWWGCR2WO6QWpZzUN/SnjalUI2P1OOi2FR9EQxoP+xsE?=
 =?us-ascii?Q?ccQgiWJcPkpQveQy98rAioiki6Le9TpTa2833jtbz32b4q1k19YQ2r9shOSw?=
 =?us-ascii?Q?HAmghv6Vuqa5ga4z13xm3CH1uRl3ImUayIluf8wJLCYp+Wfe8D6zNvFuqf+a?=
 =?us-ascii?Q?v3IUMM9S4RvJuw66rFZgpI8HjSujirkVkGSeN7S6sYp6SEb9BQP1EWJhinDB?=
 =?us-ascii?Q?MyXeVb1Id21EcvKbIEMOMLtwIsqu9tT0dBF8ixqR0tio8wf8VSKA0JktO9J5?=
 =?us-ascii?Q?bmZbMysCKDr07p50CUfPySz7IkKFHnOluDxWbITHp/+7sxNyOIFe33w0Nido?=
 =?us-ascii?Q?o/22pu/aoas=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Oer/+GCKfTsfJxWriCXPQWuaq8/sNRG7YiziozobG/U4muHzTzJRoUZfA0Dl?=
 =?us-ascii?Q?5rsaK1TEkdS3bb3Mx9kGAFFs3AUCCi89H1MpsnoqE0LgHNfYOg8qvA8oBNOp?=
 =?us-ascii?Q?3aiUKSjtTtGyy6xbUmRL4oQ2/LdtseIAIpRy+O5e5c2jDA1xWN6wgfidG9ET?=
 =?us-ascii?Q?V7En0c341x6oovvEgTztuJOiLII6q8VicsgLqLtvrrOwESfohAyRGgxcbYim?=
 =?us-ascii?Q?KQeb3/dzXTK4/U6s4J08xoatEJ6m4EyXgT3D+xToQXilj3kb8DsLphaE0AMA?=
 =?us-ascii?Q?UR/zA5t+aJ1F/EQbAM4NGWRiGOl4sP5dZM1F9lhwsgldA7Gs6o8KtX1Tdj9R?=
 =?us-ascii?Q?ESW6RsSXRB9+l/3x9O9h38qfKDx6vrQfLIF5Q3eTxK7OacJ+6mh3M/y2CxhT?=
 =?us-ascii?Q?JoFjn8WsqvWYPNr/P3J11UGLyB0cvsJzb768siWa2H8mnk+l4nwXnxG4IySl?=
 =?us-ascii?Q?9/xOVail8KjuYBOsBPnq4BPpImALgvJd+wmFG2OrCt/6tlzdOHzfo2kGzyCc?=
 =?us-ascii?Q?e2gQl6415jeAcvIcVfdnQyUCfLsJeEfwoR8sHw5ooa7qDaLMFM+zIhXzyBP0?=
 =?us-ascii?Q?dg0pEZcl7yQn5gYQmZr0LMgvRogWfjpIP9S3jJRD7sVMYvIymgTuhT2AybS3?=
 =?us-ascii?Q?v8YXOEfNWaJffsmC+f2qJrbvx03azYxNZtI/DG0LfAx6Mlw1FRvCYI92U/np?=
 =?us-ascii?Q?NDTgPkbFubP8S05xb7wyiucsP+wLhs1oszBy5HhC2AYoQg2/ig3ipT1f1cWW?=
 =?us-ascii?Q?VehnKzbPwoiHZ+Zulk5lIfSLeTH8qGFZ/OLfrAC2sskwHQcRR/XX7gjEYteg?=
 =?us-ascii?Q?GsziO8e+fSsmNMw6xDJ/pBNTKTH+9oLLB5PcX+T/Et4FPxDwjM1D/+q+dHRt?=
 =?us-ascii?Q?xLhUpJyUnHAN3EZiOVOoBb2ATgM6obQetzgiVM01e0l/xzec2+n955jWufuQ?=
 =?us-ascii?Q?KQc/JaBrc7/pWqBCbOjIzZ8MMzfQhjCJ/VVysUau3yAj8vcPWY0wdO1s36+0?=
 =?us-ascii?Q?ZVDjU2RmPMVOQ9nLAwLA47W4UBUs9nw9qNxinGDUpug0xCgFBnN7HdegrXdm?=
 =?us-ascii?Q?gT3v/0AD80SrEyBKqFTMWUCyHlws1DumFEGsr9numErxLN2BHTDpe/klW95V?=
 =?us-ascii?Q?moLKencotU3dprkcb2KtrM0/JLddjWgL0hlfwX68b8vNcdIzr/ZkTi9meqen?=
 =?us-ascii?Q?DVMugaUf16a4sq06ybGfTCwf3tNnIgWaK3D53ov5ySy53sFi4dMmjBUEgI6Q?=
 =?us-ascii?Q?RUhy+xZc5SyZJa9FigMQN4LMRAlmCx4GFeDt0b/AEHLvxfKrZfa9D3vCVeG8?=
 =?us-ascii?Q?WgSBCCXPGJCMfRiHrXK4W8wryyXGyS2g4j4zY9xlQG/XE3Zp8/Eo/vrfzlqe?=
 =?us-ascii?Q?Wz4PKIZhrbPc+iJ3QV+dHG0KtBQbxBzusWYNhxMRgeLS7qSuAdVJKVq1Eloi?=
 =?us-ascii?Q?HG29HnPiYTykHwL75f+X6bB72zoZr9dykEgN/enC1c0ObnejHC4yhhWBSI/T?=
 =?us-ascii?Q?HkOe+4knu7/73qlSAnggtFHgK+zEEw3IgcIcq9Vulfxm7BLT2SfV2HOWtVmo?=
 =?us-ascii?Q?bW6R3ymc6m3dcXYAZYv42SBnJREZIJs7fZGzyiUW1TXL9xANP2b+/0jCR8Y/?=
 =?us-ascii?Q?sA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wRYMFPW2yUBwXfvD7BggXbNLQ9RHw9o43/zaIdFeOXAs3rZMy3EmWDJL1a78bZlKLzl/j3tPxXJS4nlbAQlMy2OxKSHNdsH2b49dUOxu/RoQSjiDaiOU8xC83wj031s6s9wWPlFb6JHbK39yfAsx6+NCTUOcnZXuGwAVEilARRRfcTfr5oMxbkfC6GfcjqO7KjooycER/R2y5lSsKzg42N4vkkYNK99kNtoLMWf/mXjUg3SRMYhd/wGRiKIlMprsyoA8CaXSWQ8NBUsbdkBS2xCn13GWzXstDMwRxmjzBcw2DLXanIMaGGlklJqclt72UFx1rmfMNMR3tXZSskZxO/7J96puTcMzcscENsL0alDr9ef7N6/tWkayDa7ngGK+hjTMtNT2gzDSOee6NZhKv5Toqrx4mBFzkjfhEZA//UDdfDIkRPZ/bylbEAIem+bnChWQ4Jxj2cy2e9qriRPhNv9PYFARYrpLCPwDsf55npzF2PlHnf6AS978v9pFIdbvPDMqZgXlKi1LjVk00ou/Oe23Y79DmiSB3LTgn1VDHsK+B8+i8348mxK8K+AIK1Ae0HhV1SigUREHauvkR5DcNqSSuYWfhpdqT5pPsf2zAQo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c81307d0-201a-4109-55b0-08ddd9b787d0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:47:23.8456
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jKpwHaEdugtLrE8ockL9pZjHMntn87a5b6tGnsWV4Qs+1xQopBbH4wld8ReowBWLInHYwhQRnxbjxe1PPsrDGhGUhce7Jsz3M3OfwJIlCl4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5901
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 mlxlogscore=826 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508120152
X-Proofpoint-ORIG-GUID: 2EXVDhXjyaB482mu88lsDH3pbqcglQ2y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX8tZNOU83OJrr
 cruAT+wSVOmi+StoDsDbwccibzfj0cVFixmre9rM9reucFZtpxLpKYIlADhoQWoOWrir8JOeItj
 ld/y5TEyPQqPEVFtMkD7sBaqpHY6uyf61UmrnWzA+u69C6DlP7XEt4Vs8MrQPDDqPR7tOfY5xAO
 orOr0pwoyQhPDfdgCwsNIT0JB5u1X3wSwb6Gl+AcLbhMzKHuVhtlxNpxwRy6lPYOmYCK/gssK9/
 VTdJqlaTwv7KrPewhLPk5JHyV8MLNIdm9c+A4pTUHMQ4fS1um/G9nQBugWBJSMXvKpxfwjDsf1F
 pMhXxTmTmQmekfBjbtNSPjyIU8oVdLDxZIj585m30NgWKrzpZHWZLdDWbJb1QDm4UxIGl/DP2XI
 WbpHtD4o+Jbchn6ytdeXQ+NkOR6Pp5vyjRBdNRiWHMv5OvNBG56ulRR5o9R2H9+mjOc1+4XK
X-Authority-Analysis: v=2.4 cv=X9FSKHTe c=1 sm=1 tr=0 ts=689b6211 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=L3UT9OhzIe5qR_WfzkIA:9
X-Proofpoint-GUID: 2EXVDhXjyaB482mu88lsDH3pbqcglQ2y

We are currently in the bizarre situation where we are constrained on the
number of flags we can set in an mm_struct based on whether this is a
32-bit or 64-bit kernel.

This is because mm->flags is an unsigned long field, which is 32-bits on a
32-bit system and 64-bits on a 64-bit system.

In order to keep things functional across both architectures, we do not
permit mm flag bits to be set above flag 31 (i.e. the 32nd bit).

This is a silly situation, especially given how profligate we are in
storing metadata in mm_struct, so let's convert mm->flags into a bitmap and
allow ourselves as many bits as we like.

In order to execute this change, we introduce a new opaque type -
mm_flags_t - which wraps a bitmap.

We go further and mark the bitmap field __private, which forces users to
have to use accessors, which allows us to enforce atomicity rules around
mm->flags (except on those occasions they are not required - fork, etc.)
and makes it far easier to keep track of how mm flags are being utilised.

In order to implement this change sensibly and an an iterative way, we
start by introducing the type with the same bitsize as the current mm flags
(system word size) and place it in union with mm->flags.

We are then able to gradually update users as we go without being forced to
do everything in a single patch.

In the course of working on this series I noticed the MMF_* flag masks
encounter a sign extension bug that, due to the 32-bit limit on mm->flags
thus far, has not caused any issues in practice, but required fixing for
this series.

We must make special dispensation for two cases - coredump and
initailisation on fork, but of which use masks extensively.

Since coredump flags are set in stone, we can safely assume they will
remain in the first 32-bits of the flags. We therefore provide special
non-atomic accessors for this case that access the first system word of
flags, keeping everything there essentially the same.

For mm->flags initialisation on fork, we adjust the logic to ensure all
bits are cleared correctly, and then adjust the existing intialisation
logic, dubbing the implementation utilising flags as legacy.

This means we get the same fast operations as we do now, but in future we
can also choose to update the forking logic to additionally propagate flags
beyond 32-bits across fork.

With this change in place we can, in future, decide to have as many bits as
we please.

Since the size of the bitmap will scale in system word multiples, there
should be no issues with changes in alignment in mm_struct. Additionally,
the really sensitive field (mmap_lock) is located prior to the flags field
so this should have no impact on that either.

Lorenzo Stoakes (10):
  mm: add bitmap mm->flags field
  mm: convert core mm to mm_flags_*() accessors
  mm: convert prctl to mm_flags_*() accessors
  mm: convert arch-specific code to mm_flags_*() accessors
  mm: convert uprobes to mm_flags_*() accessors
  mm: update coredump logic to correctly use bitmap mm flags
  mm: correct sign-extension issue in MMF_* flag masks
  mm: update fork mm->flags initialisation to use bitmap
  mm: convert remaining users to mm_flags_*() accessors
  mm: replace mm->flags with bitmap entirely and set to 64 bits

 arch/s390/mm/mmap.c              |  4 +-
 arch/sparc/kernel/sys_sparc_64.c |  4 +-
 arch/x86/mm/mmap.c               |  4 +-
 fs/coredump.c                    |  4 +-
 fs/exec.c                        |  2 +-
 fs/pidfs.c                       |  7 +++-
 fs/proc/array.c                  |  2 +-
 fs/proc/base.c                   | 12 +++---
 fs/proc/task_mmu.c               |  2 +-
 include/linux/huge_mm.h          |  2 +-
 include/linux/khugepaged.h       |  6 ++-
 include/linux/ksm.h              |  6 +--
 include/linux/mm.h               | 34 +++++++++++++++-
 include/linux/mm_types.h         | 67 +++++++++++++++++++++++++-------
 include/linux/mman.h             |  2 +-
 include/linux/oom.h              |  2 +-
 include/linux/sched/coredump.h   | 21 +++++++++-
 kernel/events/uprobes.c          | 32 +++++++--------
 kernel/fork.c                    |  9 +++--
 kernel/sys.c                     | 16 ++++----
 mm/debug.c                       |  4 +-
 mm/gup.c                         | 10 ++---
 mm/huge_memory.c                 |  8 ++--
 mm/khugepaged.c                  | 10 ++---
 mm/ksm.c                         | 32 +++++++--------
 mm/mmap.c                        |  8 ++--
 mm/oom_kill.c                    | 26 ++++++-------
 mm/util.c                        |  6 +--
 tools/testing/vma/vma_internal.h | 19 ++++++++-
 29 files changed, 239 insertions(+), 122 deletions(-)

--
2.50.1

