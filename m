Return-Path: <linux-fsdevel+bounces-68924-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B863EC68C6F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id 33AA728A26
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:19:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BE334679A;
	Tue, 18 Nov 2025 10:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="TR68TXqj";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iIwDjg9Z"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE3134320F;
	Tue, 18 Nov 2025 10:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461172; cv=fail; b=WemqXc79aLFMANp/h7kZwiecfdvRmoCSYts3GaUx4/sAxGRO7x2xYeubUOk9gv7EseQWqHsMF2RrcA+yBfW7fhwpgwTg2Gsky6zqqYtGGcwA1Nt5Rb4C7ArIqVxg/TKmK7Xt7LCFTIQbROCtMv2zWIy2X00cxKBXJ8BPFHcHKjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461172; c=relaxed/simple;
	bh=d2FNTytGtZ53VKN9zIBZcTNUa0rj1LNB4pUrzR9/tNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UtS2iWszv8pHhEuM4477HltZnW4iEfkDT0F7sWuY2UO0dwsxDeXVMm7pBvDBRJdRwJtcaZE5cRoBT2pnFkltGyTky7eqHa4MF5Ae6NxZ58ROeJcCTuD8gQ8Rwf8TLQlu9v3rPptwk/nwexMZ78Z3fPCZxRRCJsub5zg19omeiwU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=TR68TXqj; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iIwDjg9Z; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CDe1007841;
	Tue, 18 Nov 2025 10:18:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=qsb5wH3T3F6rhGHk7DsnRdSMIQc4F3lgVOnHE0S143o=; b=
	TR68TXqjSePgA09QOgx8fQt6rnzp+PujL8NN/HDwzz1FZBrMRjz55bmfzoYB6f9u
	+8O50Sq5T3nqak/InjK9C1GzzwJDaguXdAuNYfqVXyeJi8oAOw8tiy0MCroPyMf3
	5xWRrnVX3xtLsOHq9jtHQ/07cQyQ+Ia+THCxP5bDSUmL8mBxjd0DxMu4iXjE9z67
	Gv+L780hJhCjsJbLk4HEVp5/In0xLs+qLtH+9onGb8taDLsug7PtLzEfiZLaGSti
	TkUXGkXgrA/UDXlAXFnaqjbHmOB+61bmSVRLQnRhTZc9RNNlU2EcehZroWd/svMN
	of/UjUrK7BRHBZRSvel3vw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbvgyw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:39 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9NsrV040040;
	Tue, 18 Nov 2025 10:18:39 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011045.outbound.protection.outlook.com [40.93.194.45])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyk8qpj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bW04fsgsQ4ANdEX00urwnkrGRGfO2AIc5poXEoH8HH0rvZZsBnZdHyuWd//rhh8EF06IZFfkjt7lQSVzgjQJ0ZeL+dd1tomILJPE4gS/HozHnG7rGtY++Zmu7klKjO3N42hmoQU6+wNYs898drkEdSVb6Xcp1n0jDDwuBMMboUafEbRircLz3htFkOrAaR4+NeSLSSrkZYLVawJ1NMNJcJc9tUZfiuVKtiIETcsygyE1yEiDvJ1oJyAOnhcAe0IBdljxEsk2I+nS64QM2vIQrEzkVnYrHLukRc1eN+jdsUJv9bH7BJcczeTtqi5uuqNPJxtt6ciX3wKoe3ZuKyNDPA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qsb5wH3T3F6rhGHk7DsnRdSMIQc4F3lgVOnHE0S143o=;
 b=uaMfKxjNj2PfgB9ivSpFRZmdgQs+iwzdao4tghqWoGvPWimO/Rek2gHpXw37jihr89qd47l47Kb/cAMgBmjM600pLMKmEvRv+fRE9c6U1OUtoUJRMWwV6PGERrOxHXMvpzzAv/547UcOxsUDsmCkc40HBZYPLZ4a9wg9T5Duz/td58+y8ZLr3Jjpe+/oYhq2uhyY6FpGAtUGiTwQg+VssrcCgOD/HiObRiyrWpwQvewbQRDlSvbUnOEQxayqVouxhBE9GmlidkjDhSvJ8tfXZFNFvtsidaOQCqG2CMf3QvVWze2L8jbXxSsSIy1n6ROqgdfo4F1DTjTRv0AXGdZraw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qsb5wH3T3F6rhGHk7DsnRdSMIQc4F3lgVOnHE0S143o=;
 b=iIwDjg9Z6WMpVI0UbVrY+QhSoDyf3Dv6f8LYOxMngBwPjOW/2ncjbglKEdp6+i8FySdTdinBkpeBT+UAuNZtddKz/KyvbBoI/PxSFeGeZb7oOlNgr1ASbl56CHctSbjA6Uzfa39InkphaeKyGz2MC/+DOET1hoSCy3vs5NjQ9o0=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:24 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:24 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Jonathan Corbet <corbet@lwn.net>, David Hildenbrand <david@redhat.com>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Jann Horn <jannh@google.com>, Pedro Falcato <pfalcato@suse.de>,
        Zi Yan <ziy@nvidia.com>, Baolin Wang <baolin.wang@linux.alibaba.com>,
        Nico Pache <npache@redhat.com>, Ryan Roberts <ryan.roberts@arm.com>,
        Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>,
        Lance Yang <lance.yang@linux.dev>, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-mm@kvack.org, linux-trace-kernel@vger.kernel.org,
        linux-kselftest@vger.kernel.org, Andrei Vagin <avagin@gmail.com>
Subject: [PATCH v4 2/9] mm: add atomic VMA flags and set VM_MAYBE_GUARD as such
Date: Tue, 18 Nov 2025 10:17:44 +0000
Message-ID: <97e57abed09f2663077ed7a36fb8206e243171a9.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO3P123CA0019.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:388::15) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: ac50dbc3-5450-40d7-5078-08de268bceb5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EpzpSwFgRwt/BVHyDh1mvQTIxiJF5MlZH1Q/JOZoYa81Yp57kCjbaGi8C11H?=
 =?us-ascii?Q?kp7+pQHMoiOTlkGZqGxZzjr/WQ6ywTcc6w5ZrQd5zVnNQDhdGBImoSAcp/t/?=
 =?us-ascii?Q?9ZGUHUx+lxZ7sIhD4nlsRVnRM5PWJCpPNMkh+G8daqapSZ1J3NJBN5JD3oCv?=
 =?us-ascii?Q?DgGR2Wvnfkv9a0s/00GGTq/hc2cBUdIOgzZVPm+rrZTrSqvgMm1N/v8eo2BG?=
 =?us-ascii?Q?IhXbGjByrM7heAg7tJqqCuVcDXigO50OVyeHpgsfcTQBMtG4rLKi19Poo/6Q?=
 =?us-ascii?Q?RHbT6OeB08K2I6womb/rYwuN6I0vFAbkANkJ5BWGzPUOb/OyUWVYpG3wl11t?=
 =?us-ascii?Q?BlrJ85OGx3BZgVxLnnU37InAnLV/bshOde/nri55rx76FCxXmk+WjhvJObHy?=
 =?us-ascii?Q?YxJvq2/RH5kJPttOoZWYc1i+MuSjWSUHGRiG6hK3MScdfOuAsftnCtjWttb8?=
 =?us-ascii?Q?wnNF8EkyPZn7VRsrVYXo3DQOilL/jYbvsN6KgqqPou4V+CPGXhDizrAcGn8r?=
 =?us-ascii?Q?ZU70NqAaj7kaYiN+2WyE5OQ5Fd1to5gAUa8rydPiIlJCI3n4SJ38Sbeee/fl?=
 =?us-ascii?Q?JwYrGXa2+dp1FDBjD2oFDayH9rH7yP118fBl2+a3dpDv0O/EvLwERgxKbjG3?=
 =?us-ascii?Q?0mB+J0gClVeP8aB7R66HNMzbdBJbXJYvpDDRDn5cFTkUzJ+3P7rwxfxJHWCh?=
 =?us-ascii?Q?PR52+OEBxukNfF4iKFUDbb0TRxWZiBM4hPaKj4skn3/7pq6psj6HPUEFYpxi?=
 =?us-ascii?Q?zPJBKRaeaMi8pRIZVkf7EMmkx1a/8z/+00+Bwe4FlpVmBzpOgrh3h/sBDyku?=
 =?us-ascii?Q?NHCqrI5h01gf2oIp5x0/QBinAng+vr+E//4OzYc4gAoIseN2hvbnbG1Iok6V?=
 =?us-ascii?Q?lfuSmmxc9NT1mWwwHCclzDXJwD0vbNqPjrizcJha3DsvLiCEAUXSLvxy5K2U?=
 =?us-ascii?Q?wwRLwzwVAnJ+q41zQFxoa4u0t+pGRkCAlvLNTFUTsPDiS/pLc/OE08t3pZ5d?=
 =?us-ascii?Q?4uMEhWiHPs2T6vepBFb5eBznctHXTECp/kIJIeLLIZ7OF196ZIe/5QL9nzGa?=
 =?us-ascii?Q?JuveiBzv3D+loRHSWeZc0WVOPsdstpXVy3jLGURVmr5uUj9MhEZQaDCBOUPb?=
 =?us-ascii?Q?zPPpNz0vRUhunDn+bEL1r1pXon94g6g518UGVUwad/TEg19DAFci0tT0wkAK?=
 =?us-ascii?Q?IWU84+GZvLso9IDdDrXDERsLebhyjQjkevi2R4+P1ZBKm2RDaqMjYRoishca?=
 =?us-ascii?Q?cC9W+4LAtnhV7xZgBKJ41wc50r6wWGvbNRxsxd0V5JLGrSHf/dq4FNRAJ+vb?=
 =?us-ascii?Q?Rlog/fxC51w5Wa70tcp/Juy2U77rgBmrT44YaBT82Kaf1Xe+VySZyin+U4gM?=
 =?us-ascii?Q?H6sjRsOsFdNcb34JN7wkiVWjWE+9JTSdOTKDyPEX46hcZGudUb9VOkUTM46U?=
 =?us-ascii?Q?AyGnPQE5q/yaGOuQnVSLCy1vUWQ7ROYZ?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1uDnZ3Ghx1qCZZ55fZKLrWHzSToHcR1x2ahRkzMkjcm3vDvdD/HOBfhY3MC7?=
 =?us-ascii?Q?rVFNThSwP7fjwUMXrC14BH+KRsMUJk0GkAZiZnV7QIps20Fyuf2G7VkZ9TYE?=
 =?us-ascii?Q?HiwdtJmQ6MR2JYJ64EeRlKpa+D0aGIRlxbB8AAoStc7vIPUyWUywG6wtw3hA?=
 =?us-ascii?Q?YLHGE2F8mnTPXcf4FUfAGB49/5AShkrA5fDGqs4aWO60vUInfsmAW8dU9S2I?=
 =?us-ascii?Q?0cfPyacOKiG6lVh9uumX0y4mHOHVcJOBphGNp1WYXVWcmq9EJw/Bj9E4nR6X?=
 =?us-ascii?Q?wBmv4wP3TQsz8IKDokpSOBEB7H+mNHglpXBpKqDLJcIeCmOCOOvk1Dubm8i0?=
 =?us-ascii?Q?H+pPf5pxIOOvB/CI3LSP7d1NNbGihYVB3kePS8lqA1bF2r0EL8ylS9gFRQCb?=
 =?us-ascii?Q?wWt9/Fi8Gab781yZgkSesfmYPvbsZArvJRZ5kGt0Za2Kw29GuaqKidUBcruR?=
 =?us-ascii?Q?2gqAmme5yGjpGZc+iekaGlKs91We5xSZyw7l9YxIpkkmVv5lx4nhE61OxLqZ?=
 =?us-ascii?Q?WU6ZeBzvHh1vBbhQG5LCrlTKcTUGbXGVjXyaXQ4U4pRFe0Rj3myLlm2Osr+I?=
 =?us-ascii?Q?hpy3bBDMPVoacZf1e5yVRR8+5PReEEbeZWCxfAlAkVfwQ+EEb1qdVpj3Gqjn?=
 =?us-ascii?Q?xet8yoi4lfvkn3/TsG6GpuUIcTMPqzXs4eIbmOhzl4OaGVCY+UMda11Gghbg?=
 =?us-ascii?Q?G1IlzP0JVnYdEyP6vbqUAGyHPZbW+HGJ1HiI5cvui6pXEKOjgjh9NhSRU3xf?=
 =?us-ascii?Q?4nC0muq0QrdNWZi62BE9r+EKoWNmS0Kz2O6mKbst08jokF06AWwCOncSx9rE?=
 =?us-ascii?Q?jniESZ8fOkw6Ziea1tdmKQrtOLOHnjMGcFQEnWjJrg9U3jkmMahwlybQfOEq?=
 =?us-ascii?Q?sJJk7q+XyRPuvJS1bNTTUTjHSrw0IzQpjfytlY4wiTFgr9GcIOXTqecS4XPN?=
 =?us-ascii?Q?qUpuMoEhQ5GlFjYQYy8rwUlrnnn1r4MU7RY00f0l8iv8v4tRuvUhHrRWLVmL?=
 =?us-ascii?Q?gVLT1HSTjINMKTO6Hojpb695bQ2BeYK5faHQP34x8Dzg2GQWkGCfTpB3Z0sW?=
 =?us-ascii?Q?Spt79cJ3W7DWANBeSdG2+PsqzllF6GP7Shj17cIKJo2zr/+K4r77xjX5bolQ?=
 =?us-ascii?Q?j1JDVRDOa76RPgHneCUDNNwhdD9UnsDLwPYF5ZWQU8Btct70rCurPovsrWCJ?=
 =?us-ascii?Q?lmTD2M8nAW6vTBlXEuz/Ru9rLke9dXXdgiduWMFcGUFwR+aO3EUden2j/yWa?=
 =?us-ascii?Q?anrA4T1Ymw35zwtoStk82Alocl6DhwS9RtIc4cPuiCOJXpVuqLOGiRnDXPnA?=
 =?us-ascii?Q?ZbJGtKM8vxHi6NK+TPb76h+2zqsZoWE3eu6mzSoxMr99eqRq5RjTcxU+H6YH?=
 =?us-ascii?Q?HCD6DeFbHS7cbHfu2/5jG1jGyShMF/K68U+EtyGsn7bF5/2prbVY+q09/ldz?=
 =?us-ascii?Q?6snBpPVGNM4yv8NtbCfzjjuIrLd5U4K4m2JA3vWUNGlchBdf97inJjrBD7ZN?=
 =?us-ascii?Q?/Hk55X1xigTdwO8+hYyLsT9mW44RwUCOF/rMqkX9vnvYXSWMka3/n604oFYS?=
 =?us-ascii?Q?x2q8og9qvwyS1bcl+AsXKiqBA6VL6fXTNy44kEIoWSvRejHnwSXGuvkW8dQp?=
 =?us-ascii?Q?oA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	JxNcFjl7Y63m12x4JFagC4xyNjW11umPWXEQOjpau37U/xI+i72/yEfuQWSZs+eyuKb9dUGHud2saQMn7Q8dHiECxoBf29DkDYeZwDZ6gLW1UyRR3UanFIe43QShRZ8Er/gCRN4qm8SJPyDh2IHh8NkCOiKGRz3cVODAg/1X3ndiHoxz+zMg3Gih87IG6NGLf9N/g42APASlkLHKYxp2HmKTeFuo8eJp8aZ8wOLjbWMVlDBGlVMEV/H5lYmdMyulh6L+3GnHuQt97nms8+PHhidzjR/HbZ1nnBwBgQmeijTLmUkED2lDNSK2OgQrMd6jySl+C/eecA5s7PA/aKXbiDgGCFfbvxepONMBihSNrZ+hnZIC7KZ3rhEdHfBYR4mZBGevAfY3V/WsEUhPeDijj8vzGnPPXcYVLfGJRHtTyTFOFgLpf+3qZLrBTyZ/4Zk8pwlSsKp1xAKA9gek7MLdeh3W0RVvJSQaJu0I1UyiOAZOR1mkBjaEM9kaqcOOXN+qr6XCRcr7BIEmoYyqCmq+vCvtIsgr9YIAvWQLW4sZV1FGvj1s4nhVVJdSkxnT9snLwdf09tKNvjtqCYsvZHP25jtm3tWGwQui4tr5gF4RBrg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ac50dbc3-5450-40d7-5078-08de268bceb5
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:24.4110
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHnue1r6aUOkmwCuymNzrjKhTmfG9jEF3H2Y6PyOhMW2i98ri7c1k2G3wcVmBoo7JR3z7A6TyyvTRFyls6LFeuOZkUVX+CjjySBha/32AV0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0 spamscore=0
 adultscore=0 mlxscore=0 mlxlogscore=995 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511180082
X-Proofpoint-GUID: 9YUnt2O-f3duCxjATJFTX7UK9fpbKDuD
X-Authority-Analysis: v=2.4 cv=JZyxbEKV c=1 sm=1 tr=0 ts=691c47ff b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=_GmWhKkRMyt_Xr-G3xIA:9 cc=ntf awl=host:12099
X-Proofpoint-ORIG-GUID: 9YUnt2O-f3duCxjATJFTX7UK9fpbKDuD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX529o8I1qLZP9
 LPiAc7s3LjlazUGWbPdPf53NJ0A7OdWx/Y/TmeuORVnbjq4Bbs8W3rbNfhPPUUMf/rAG3RDj4DE
 s6eARfv58NP8UbdyEfrvhah4Ok2M7qwS5Kdn5SUj7UsJEizbpCIrc/x+ZH594oIZMRUPjo+bsev
 U+7NzbNLTYMXZK/STgKGPwn2iYeMo3alrvsCdrPC0dN/9mdkwfaM0pZ/5Vyznp33PL4+kVUhdQ5
 34Fkc29dp0Viyc2+v9the5Xu7aYdSP9kZmH9Go8ALG9Tigoauim1mCI5+LXwZoqhEAR4o+qDzOT
 n9JHCLHMlzTYUbzlq3o/xPtXQSgabT1umzgegt3hfPaHbrk7VT/IYfm7dmPMFHTBseySMOl30mh
 0XIflgRO7GnXSTIVIjOLd+ePbi8sp9SLX7f6LCzxElCHR4f/zzE=

This patch adds the ability to atomically set VMA flags with only the mmap
read/VMA read lock held.

As this could be hugely problematic for VMA flags in general given that
all other accesses are non-atomic and serialised by the mmap/VMA locks, we
implement this with a strict allow-list - that is, only designated flags
are allowed to do this.

We make VM_MAYBE_GUARD one of these flags.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Reviewed-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
---
 include/linux/mm.h | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 36b9418c00fc..03776aab3837 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -518,6 +518,9 @@ extern unsigned int kobjsize(const void *objp);
 /* This mask represents all the VMA flag bits used by mlock */
 #define VM_LOCKED_MASK	(VM_LOCKED | VM_LOCKONFAULT)
 
+/* These flags can be updated atomically via VMA/mmap read lock. */
+#define VM_ATOMIC_SET_ALLOWED VM_MAYBE_GUARD
+
 /* Arch-specific flags to clear when updating VM flags on protection change */
 #ifndef VM_ARCH_CLEAR
 # define VM_ARCH_CLEAR	VM_NONE
@@ -860,6 +863,47 @@ static inline void vm_flags_mod(struct vm_area_struct *vma,
 	__vm_flags_mod(vma, set, clear);
 }
 
+static inline bool __vma_flag_atomic_valid(struct vm_area_struct *vma,
+				       int bit)
+{
+	const vm_flags_t mask = BIT(bit);
+
+	/* Only specific flags are permitted */
+	if (WARN_ON_ONCE(!(mask & VM_ATOMIC_SET_ALLOWED)))
+		return false;
+
+	return true;
+}
+
+/*
+ * Set VMA flag atomically. Requires only VMA/mmap read lock. Only specific
+ * valid flags are allowed to do this.
+ */
+static inline void vma_flag_set_atomic(struct vm_area_struct *vma, int bit)
+{
+	/* mmap read lock/VMA read lock must be held. */
+	if (!rwsem_is_locked(&vma->vm_mm->mmap_lock))
+		vma_assert_locked(vma);
+
+	if (__vma_flag_atomic_valid(vma, bit))
+		set_bit(bit, &ACCESS_PRIVATE(vma, __vm_flags));
+}
+
+/*
+ * Test for VMA flag atomically. Requires no locks. Only specific valid flags
+ * are allowed to do this.
+ *
+ * This is necessarily racey, so callers must ensure that serialisation is
+ * achieved through some other means, or that races are permissible.
+ */
+static inline bool vma_flag_test_atomic(struct vm_area_struct *vma, int bit)
+{
+	if (__vma_flag_atomic_valid(vma, bit))
+		return test_bit(bit, &vma->vm_flags);
+
+	return false;
+}
+
 static inline void vma_set_anonymous(struct vm_area_struct *vma)
 {
 	vma->vm_ops = NULL;
-- 
2.51.2


