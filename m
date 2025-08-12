Return-Path: <linux-fsdevel+bounces-57524-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA9AB22C26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 17:52:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06E3F1AA08A6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Aug 2025 15:50:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0255C2F8BC1;
	Tue, 12 Aug 2025 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VJUmmNEK";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FusTsk2N"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF55307AC9;
	Tue, 12 Aug 2025 15:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755013723; cv=fail; b=lCRcRpIusiJyOMUbN2XI08ZLSE6ebSjB3imgT8U1v4M3iSok0ZIwYekBNh93NLSsXvBA5OUl01NQvQs/Eul35mVPW+2+ud2SIBEquVX7lOp/1/rqowyYP9kIuSl/F6AtftRRu0scK7LI96JU/aW58VrVF9SJI1oD0F4IyyIYGSk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755013723; c=relaxed/simple;
	bh=Ucb8mPw8SNMTfAuB+S27eb45fRPyxy9Bpb2pZb1I0tM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HXVCiLsJncY0WQpmLkO5zdNl+eYkmu7G/LRNK2CrCxJr1KI7hMY/Nuzm+j6t8lUvF3/Gzu6o+G1At8+8IOs1Zol29/mox4QTAUgIv8L7tA6VUsF6xMmplbURFGB+y/iFMiwEDqfiLitcnG7giQ6RUhzy7FFDoUW23q9XUdxaDNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VJUmmNEK; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FusTsk2N; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57CDBweY025255;
	Tue, 12 Aug 2025 15:48:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ufr7W+sTl/1LuOsSG7ZNmW6pdNfc/pMlp4wqRssUxv4=; b=
	VJUmmNEKnN0trbxrc1JkkW+3/ppZhLhOtK7OlaezPsMN4HqKXyOaQusJZ97UVRQ3
	ig/skzD0m4e/o3zdTK8TZNoUxWJIJ74aa53r/kYCaABYnH+3cIxqpFGbTqo3yB79
	2hAbsdEQ0pIb6BL56ycjR5cOlnlLCUItgdpPTCy2bpbelzzMjQwYhI2W49CACuFe
	IbZmfR/HTsCWMIveNYOnsrqCI/iK4qMPDeZ9HgW6S9DAMUwhykfWt47LLWGgbBao
	rjA+CR9VDbvvyOXIcWFaMCH2I2XGuGJdwcbpJStPnAN0uxI7kEKJQF9Ft/LDlioD
	FKf2jbuz+yqbVfU1YTWstw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dwxv50m7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:48:04 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57CFIdxq009646;
	Tue, 12 Aug 2025 15:48:03 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsgenuu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 Aug 2025 15:48:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dBfytWdB15wybY24V3oQ0TxaXL/Oncv+IRZw1n6M5TnCLYrQfD7LjSuwNFzHsulYrRkxnkXO2qWjdYWqW5P1X7/ro16VaOfG0WndglHwYa/0XwGZpOSsMpUYrM9ogSpdLX4cdL8QaXp7/dO0zdvThMfBoy49qeKKUsji3VbsmvLGBGYp9BELwGBK9JP06dE1kiALXdIWNw9T0aWG4Xnbn6cYs7byXOXC8uF29FRcTfHdaLl9j/DPTazqGGdWzHGzVKSWMSbJPofPU2sCkW8V5scm0AQ6sGf6G2XMCEoqrpjnNdByY+0678XNKlqhurFN4QFyXYYosmAOgqKyMgHC9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ufr7W+sTl/1LuOsSG7ZNmW6pdNfc/pMlp4wqRssUxv4=;
 b=hBY3y+j7zqCkqyrZnqeB6Z9G4GLqmwWiBSRm1Ki5vHxOYeEFCl8gAxXZ2ornYwiI/lHWvOjF7eQ5kkRfyNB+Jb3nFntJhJe0dybUMSpJfRI4KWENWtitG4CNHKG32oJgxSQHmtiSlTRt7S8VrBDGdqIenXae52cpORQKneXWT18o1qQ2rijXuJLEmcqZ6JxK6VDYk9rrXsvOoDGL+mPkq7s6eL3Wn94/ggEiBh6EgRSc52TeK+08XiIXTow/iRVVGSQshFOy5ie2Cd/Y2dk1512JrMgFlPj3hYdGmeQNRdtvXct0Y0rdEWWzbRe9fWAzHUVbbyNuPBgfrsSOH/m6Qg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ufr7W+sTl/1LuOsSG7ZNmW6pdNfc/pMlp4wqRssUxv4=;
 b=FusTsk2NRp/qkgteTPMf10GUdAxhNhtnM82KElKk8kdJ73lqkQAVTN7HUHfulAsVFlmYP3XijAYnoP7TCk0yuh9YRGZGyfoKLJIkSn6CYlrYNQjBdHJIHyoDdWuK14Vzz5EsGnbk5De9v13AVUQQSj02gnnGiCIgAoNO+JXvuXA=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by SN7PR10MB6383.namprd10.prod.outlook.com (2603:10b6:806:26d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Tue, 12 Aug
 2025 15:48:00 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%5]) with mapi id 15.20.9031.012; Tue, 12 Aug 2025
 15:48:00 +0000
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
Subject: [PATCH 09/10] mm: convert remaining users to mm_flags_*() accessors
Date: Tue, 12 Aug 2025 16:44:18 +0100
Message-ID: <cc67a56f9a8746a8ec7d9791853dc892c1c33e0b.1755012943.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
References: <cover.1755012943.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: GV2PEPF00007566.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:401::3f4) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|SN7PR10MB6383:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fb71452-b93b-4631-98ff-08ddd9b79dbd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?6QV5CdsXwIM9BzsTKhHEQXQQrqeIDztaVTkE/yrlC+b7Eiv7I3SU6MNKZliF?=
 =?us-ascii?Q?i8DOXvZYT4jtCX6vVTwF22Ak8t1pw5clW78plInhi/KHLWmZHf1UT4w//f8o?=
 =?us-ascii?Q?lAdeM/IRnl5sZOwI6SKD5fkD4cK/bPKtIAF1o1eI0xwH1Co8F1/7pDiaucEE?=
 =?us-ascii?Q?UiipuCKVNcwlXb+cPG5RdpKWWZS0jSYMUvL4nHN9au9/Kh7Zt80iXG0vgIHM?=
 =?us-ascii?Q?+IjVwo2k8Hhl4BOzD2To5EdGTu3/dLH4oimI8GW9339dNT+J+TumPd4WDqPN?=
 =?us-ascii?Q?xeChc6JuVkoR6viTo7wAT/XuFrtuLXsFDdWR5Z65ZoWBWN2F+22d4+53NB6M?=
 =?us-ascii?Q?nerV+f+13hfudA1vi+3wOu0IqJ1UeTyhTDb0Lj2PYPt1ncDJk7ipqLt/X/M8?=
 =?us-ascii?Q?IUaQRAEcEARSoM89bMdbW2CZlhKSWbyqPfZX1GKkngKbpJbfLXbXeDd9NCWW?=
 =?us-ascii?Q?7uv2hOD2XyJ6jDrJmQUBXTKrWPJWVpKY2xCKx8kyFbBUzD55yUB3iWZZWJPU?=
 =?us-ascii?Q?BXfpCJ28g+1iff0WXODjprlw9xoXYxewZo/V0LYThcRDloqfcVJLGed2zb/J?=
 =?us-ascii?Q?Ibe2ImdsAYnBRCV4WX+s11F5aImO+b1gsfzOy1J9Wt3KWPYXC8Ss4ngg6cUe?=
 =?us-ascii?Q?SscPWBQNnq6eLC82BNMdbpu8K01Ij4ZUUSQLsLBk89d6JH6v3qnv+03iuFAp?=
 =?us-ascii?Q?Sz4D6FmBpUMQ6ggtHKk0l6KyNJtkwd530IROBW5WOdRl9rEH7V+nLYL+Op3S?=
 =?us-ascii?Q?tMVZ/K128pUnmF8Ua8CSWCmpXdvLHebR3GxjJQ4eFwZ/CBl+no7DIrBJIuGt?=
 =?us-ascii?Q?r8tsLXjmKGY1JbRdLj/P5Xereo6Y4qHeqiZXOWJFX6aTsMNHsySCUE5wlBFs?=
 =?us-ascii?Q?eagd9ILURzRhT0eSrF648i/ST1hsfYmKwDpFDcd6Gg8RP8TdtHR61aROXUwb?=
 =?us-ascii?Q?VYZN7zqzs+5/4rWnG2DUucvUszs6NQ/2prTYwKFiFrq3rC4onXzmsOKDoy2F?=
 =?us-ascii?Q?F1TWxsuxRqNHTfHMicUGBv5Z5hsXtbUm3o65FRsm3hvP0CKLAVucFONZVEjW?=
 =?us-ascii?Q?Yq5IQqizrpBE0mGSWc7R6nhTXR1l9UQj7Yow8U1zoLAmnh/JHEY4flLvDG2d?=
 =?us-ascii?Q?KwV55OZH19bCoJalJ/FjYRurQ11+HKem9/Jbh5KOwbXCv4LM1h2s+gsBh9A0?=
 =?us-ascii?Q?kzJ0je64xxE7L5hYcx+INYMdlrR84YDa9WOXnRn7vyhG1WcdaXk9/lMCNHIN?=
 =?us-ascii?Q?oJKjNNG8QvjClJg6i1ENtj+j+3h3U3xuqvYFyZkHd+QghbyaOnu8Su7pgyOE?=
 =?us-ascii?Q?S7JPPY9yPmGmHYmmj+3KHGi2vWchXp0T17Nwo5m0RDBuyjH54ckYKHSqXPL9?=
 =?us-ascii?Q?xfi7bajSvXz1dFybT4bGobYWQECE7VmWo03aGF+79KCsDLYJiLGrEVfl1Dn2?=
 =?us-ascii?Q?V+oW01vdwoo=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?J8ZUeLvlFiKN7U5w0gryC2b0IT47SpDo+U82Kqb8xHLCwMmIn17OlM+vB29H?=
 =?us-ascii?Q?PQFLgMll9ZS1mPv6GoKVDnLyAa2qvfYPUj59tfbTN+8njukypr33MfGQASuh?=
 =?us-ascii?Q?DTjdVptbdSPWx0I/Jd0Ook+7LuaOde4/P5VQbtjQAzWogrn65ooXpoBjRIf8?=
 =?us-ascii?Q?ymaSucMqBHZ2xG97BoLqXBaDtq7s8MA4hJz2q6flOkWkl6uLRajUVSAMFwG/?=
 =?us-ascii?Q?wgWfHRcg0KoCZE/V7EcMlpR5E56pSQuSjfcoE81IP+CEMGfuoPgcm/xX9B8R?=
 =?us-ascii?Q?wMnWt8BFg1nl2CcXdIyAXfRMvO9KkjCWcL0onZGipadMGyygk0xtkWb5NNl+?=
 =?us-ascii?Q?AU03vcW8qgTNF0BESizqPiUp4QgZWp7zFXEWj/9ZBfHioHBvyIDdi7Uplcdn?=
 =?us-ascii?Q?Pqmks0aZbZmfS9JhkBlDGfdtnvzBLXDlOcWS20Ny3J3FY/NCNDlkiuf1Nk2E?=
 =?us-ascii?Q?sO3zjxtl3BYGeM08vVx5IgeZuLDCfyht2pnHJwIvNh5bIORqmRTXpHPESuka?=
 =?us-ascii?Q?l7Z3Pinf9xxoQIfryoXqy0kyLTyrUwMylD1jXC9QCfUoZaesPzeQEDesX66X?=
 =?us-ascii?Q?RfFITPfkqZpguh7UPXXQKItqce8jRzJ2LTFQE9z9XKKjUcttJyjDN8YStfyi?=
 =?us-ascii?Q?RSj1sTb7FBKiH/8Xl15orvwEoeGzbHlXzA2FbUNsTkv2QSipzd8X0VhekRNu?=
 =?us-ascii?Q?fPDxb7IJSyI8fbMhzIC0+vpjw7Qj4c+kb/eoRkeQ+d1ZKDp+RlED16IghSfn?=
 =?us-ascii?Q?zjjWsnec/jYPi4TGpDs3dYq1ZdXjpr1G5E720C+h1b7K971eO3NLzWPM25y7?=
 =?us-ascii?Q?0+ejNQkfpkWHWqM95f69Lh1vUlGm7qAq6CYCciGMFbDXeOU+YJgK1OGnoO2S?=
 =?us-ascii?Q?SSkNwqS2ALB+GLyrhNWmRsTRN6dlUao5IVjSC2kqHpWxPRVc3ncPcexiu8Xz?=
 =?us-ascii?Q?BJYswcxqpNHuQgAxTJzpBsGF7/ePyVHFvjQuU4ftDNMGK4V0rprTzdBm3FJu?=
 =?us-ascii?Q?Gj60OuijGURX/t82X1n20FZZg4FTsFHpvjX5AJCXOy7qLlXA0IEGavEB1Qip?=
 =?us-ascii?Q?1KFJ63Aj/YfbCnCEz2mei2LGlZtrVlshEGqLVyTmZ7IDsh50w1SBDOU6Xrbh?=
 =?us-ascii?Q?fFl0IZ8mecXDOQoNKzv2vmP4nASexOyv+4R431d/HtXe/yrHEqtc5YdtnHTd?=
 =?us-ascii?Q?+LNLmAJYi/3vYNuXp3hZv1+7T2WRmX926nU8pujRdSxCheIKYRtKXFJa5xVy?=
 =?us-ascii?Q?pnVNOYUHozjt+4DajnrEwAyweDHINXpV1+dvGgzNdXAr6mqU4a6BoqqXux71?=
 =?us-ascii?Q?ZDfDBsx1PdWlaLhlvi7jNnEGDGz3WWdvGr7VePFb6pfia8K4JkktRoQz/qiM?=
 =?us-ascii?Q?HRaLrmF+jkWAwqB4sz9cKYmz48IjmlbEtO4oV1x9uWxKtmHndkzS2NSKR66f?=
 =?us-ascii?Q?ZiZ0WSmFPAcw42lv516HAn4LIB+jfcOBRl2IRCAmmFZZOTAy9dravUOiJY6R?=
 =?us-ascii?Q?YyX13EmnGGLNWkLvHI3Gs1EuQdP7Fzvy8r1yZQF/EJyr0tmyDI9XiYNixqkf?=
 =?us-ascii?Q?6LHW3I+wCQhaM2VN958NBckgYILeh/oRA/ukvCio1iYxvJW6xzYGbJPNajBC?=
 =?us-ascii?Q?mg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	7tbNTEL7IViQ3HOGAEBqDoPm+CW7bDzluLSD76+7P87lhbi+Gv8n130hKyidRT9lc62qsdsTnfy6CWBEmJH6PAUeyV0TeUI+MssVdy7n0s3q6A/QOM/Uoq2MgSjTqXqSF4CiPSKa8UpUrpq3TZB4k1xO3i4P1krD+cg2dCe5rhxzMclPZ77fc0widoKQ6VDH/tClZ+e+8nMt1eWnTsjEcr9756RH44bjgBpcJ7EVcAN+3SKSqqjlC2J8G3Zgiyd51bf+KSaamd45iZPlJsYRPxaQXTjBIeAPWnywvg/l4L0UOA2LQ4e/a3ogcFYxB6O9DsByOIwzw1n74azPCp2eJ9f0n9D+pYWgyIURVo7exLBiMmtvrDwOhgLiibN3H/ENVDog3J7HsBECKnqB4oRy1BKZH1PfBs6AVB2LDTS8LaavXd6wAftRx+6EmvcZ1bi/Oo8SlV4Efy2ZGXRWKCziVmseYJ17YsS6zrspDA25Ievwg6VLNO1+IXp4aCIDBFoBKoFmHLk9b70m21uu7JH3VdBEMjDtJKXi/B3Vg8E7D7RGxW0bPiLAvX+hiKnhr4HXMT3ggXb2whuQudfIXS7j2bA4hwBn2i35rdEPa+GoJ0E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fb71452-b93b-4631-98ff-08ddd9b79dbd
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2025 15:48:00.5885
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: U0LwZXm3wVtnZGJZEpa/eKH5lXd+Z7X7OoETBNPXYwm9FIsSiKFz/a60lErSfSdwUWifQ7R45w3WJOMeuPfT0FOw67ZCe4syI7hpJOxdDLQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6383
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-12_07,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 mlxscore=0 phishscore=0 spamscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2507300000 definitions=main-2508120152
X-Proofpoint-GUID: cIR_ZM1-eCJeAIySKiy1liZ2enG8cFK5
X-Proofpoint-ORIG-GUID: cIR_ZM1-eCJeAIySKiy1liZ2enG8cFK5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEyMDE1MiBTYWx0ZWRfX5h5kF84y3kib
 JvT+p4jTruPlgRSMS0YHhjeIyQl7QxcIzss3Scg4dNlP+QCjHAAEa3o/Z8JXEntzMesH2wAkVaD
 KHbdKDtIqDPpDDaIntVv0JGGXDsh1YUHEf8GoMKjXoYV5oItCz9JngWjOrXuIK++azbxToVoFaF
 od9hwwjBxkzPvkxizcX4hMg8utBaiLOeNIQra+9vwLFs2un9vS4ZM2g2ayu/U70ExAa6czsfNlO
 bY/WPN7pkFNmnRE52ZoWOB8SXmRkdLqaLVEtc2zcvxTo4C9WtDtyhvKdVn/jf+SrYdTCRBCNKDm
 hJZ96RanJ+Nfu4Lmu96CqDB+Serg0BV1FsX2sYNmVHzgiqGEKTmldUUg7cadMczNCC7TWe3NRD5
 OVJkG1Mei6plrvjUFeY9CSYJGMRWE8PnAx9tbDC9Em+1v1NYbLNcGMHoCig0J4s4XEmGoTTc
X-Authority-Analysis: v=2.4 cv=KJZaDEFo c=1 sm=1 tr=0 ts=689b6234 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=2OwXVqhp2XgA:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=urWiDTc8nT0oivSZmOMA:9 cc=ntf
 awl=host:12069

As part of the effort to move to mm->flags becoming a bitmap field, convert
existing users to making use of the mm_flags_*() accessors which will, when
the conversion is complete, be the only means of accessing mm_struct flags.

No functional change intended.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/proc/array.c    | 2 +-
 fs/proc/base.c     | 4 ++--
 fs/proc/task_mmu.c | 2 +-
 kernel/fork.c      | 2 +-
 4 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/proc/array.c b/fs/proc/array.c
index d6a0369caa93..c286dc12325e 100644
--- a/fs/proc/array.c
+++ b/fs/proc/array.c
@@ -422,7 +422,7 @@ static inline void task_thp_status(struct seq_file *m, struct mm_struct *mm)
 	bool thp_enabled = IS_ENABLED(CONFIG_TRANSPARENT_HUGEPAGE);
 
 	if (thp_enabled)
-		thp_enabled = !test_bit(MMF_DISABLE_THP, &mm->flags);
+		thp_enabled = !mm_flags_test(MMF_DISABLE_THP, mm);
 	seq_printf(m, "THP_enabled:\t%d\n", thp_enabled);
 }
 
diff --git a/fs/proc/base.c b/fs/proc/base.c
index f0c093c58aaf..b997ceef9135 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -1163,7 +1163,7 @@ static int __set_oom_adj(struct file *file, int oom_adj, bool legacy)
 		struct task_struct *p = find_lock_task_mm(task);
 
 		if (p) {
-			if (test_bit(MMF_MULTIPROCESS, &p->mm->flags)) {
+			if (mm_flags_test(MMF_MULTIPROCESS, p->mm)) {
 				mm = p->mm;
 				mmgrab(mm);
 			}
@@ -3276,7 +3276,7 @@ static int proc_pid_ksm_stat(struct seq_file *m, struct pid_namespace *ns,
 		seq_printf(m, "ksm_merging_pages %lu\n", mm->ksm_merging_pages);
 		seq_printf(m, "ksm_process_profit %ld\n", ksm_process_profit(mm));
 		seq_printf(m, "ksm_merge_any: %s\n",
-				test_bit(MMF_VM_MERGE_ANY, &mm->flags) ? "yes" : "no");
+				mm_flags_test(MMF_VM_MERGE_ANY, mm) ? "yes" : "no");
 		ret = mmap_read_lock_killable(mm);
 		if (ret) {
 			mmput(mm);
diff --git a/fs/proc/task_mmu.c b/fs/proc/task_mmu.c
index e64cf40ce9c4..e8e7bef34531 100644
--- a/fs/proc/task_mmu.c
+++ b/fs/proc/task_mmu.c
@@ -1592,7 +1592,7 @@ static inline bool pte_is_pinned(struct vm_area_struct *vma, unsigned long addr,
 		return false;
 	if (!is_cow_mapping(vma->vm_flags))
 		return false;
-	if (likely(!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags)))
+	if (likely(!mm_flags_test(MMF_HAS_PINNED, vma->vm_mm)))
 		return false;
 	folio = vm_normal_folio(vma, addr, pte);
 	if (!folio)
diff --git a/kernel/fork.c b/kernel/fork.c
index b311caec6419..68c81539193d 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1887,7 +1887,7 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
 
 	/* We need to synchronize with __set_oom_adj */
 	mutex_lock(&oom_adj_mutex);
-	set_bit(MMF_MULTIPROCESS, &tsk->mm->flags);
+	mm_flags_set(MMF_MULTIPROCESS, tsk->mm);
 	/* Update the values in case they were changed after copy_signal */
 	tsk->signal->oom_score_adj = current->signal->oom_score_adj;
 	tsk->signal->oom_score_adj_min = current->signal->oom_score_adj_min;
-- 
2.50.1


