Return-Path: <linux-fsdevel+bounces-68932-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A68C68D47
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 11:28:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0AA673845B6
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Nov 2025 10:21:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEE2834B68C;
	Tue, 18 Nov 2025 10:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qDJMPh/5";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="G/euT4n8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402A43469E6;
	Tue, 18 Nov 2025 10:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763461199; cv=fail; b=BtOUg4IxIxzW0kb11vAz7cObME/0B4thK92O0PnJAx0ARs/bOhKefvFABRZAyXw3c2CXemA7xStyD9IHplfKowh/SAXJ+tnB/CypGCmdwICGPIvkhXrSCbAGfdrm8ZoTGzNW6qT+WqrPmX86Hbn0kAyTYBywD/VzvQEt1CmqecU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763461199; c=relaxed/simple;
	bh=RS6V4xlG7wZJYygEjSqGw5wqQsKkWnk0LWo5GL3GUTs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TAR93MXGhXS+bxcTuoVUPKuxHy7Y+IYP/kOiI9AN8SRPGCH3huH4LnDzmN8VdxXznxGE5eoalTOkR49SjYxQwe6p/lbkw413ocClK42S+34PJEYvMqkqDtBdE41BpciZFzmhZLAofOxD76oUBx3HHeIcrruUu9JrKE37DnRk/N8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qDJMPh/5; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=G/euT4n8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI9CCMr020871;
	Tue, 18 Nov 2025 10:18:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=PnAJBcGpQ3U/PYO6jARlBQ9zTAEYuKnTFX5dhMzNpY0=; b=
	qDJMPh/5IlldnYQuWWPNplxKhT9NR+fuIlCc8MyD/56+XAAj23lImj5fI7WYJupW
	6iR/Vx3gIMoCnZcHDyPVPDFw9SeVhtS/GakmcJqSd/cqDHKjIlcb+bBqJMVBf7cN
	98yh07gXq3Gwx0iKugY6IDBjzw7B8BrGoRpCmUQAZ1JCKfy4xOmYCVtatHfLYPM7
	vbkGJEkeAjcEOAV89uxD9DA+Kmd7MZb6hUGikKPiJpeJzesC1w4xXiENgr+CwMNt
	/1fmXKNBVo2U40Ma91BjlatgGFB9NPNQC+wKS3DB2qpvRacosTTFN2Xh5npk1du2
	7LFVzD+qYO5vhto1rYWJOg==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej8j4j8h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AI8wjfn004268;
	Tue, 18 Nov 2025 10:18:39 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010048.outbound.protection.outlook.com [52.101.61.48])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy8pp85-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:18:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LQXvArIEYcxVzk+VYUKlFMtOYalM/okKVNxxH8hKOnczWldzJ3DnbF/CwatBEFYIYxB3GY5qvMSJx7jw40FUC6PYQ9DfK+DY6kHpoNSDR0MGfE8MzxnPi/xzechMxUiS5cZpQLSOg2spANOTl8uWY7GxnKPhYcU6kyoxMRoltECyAVlKpmqgIkJCH7DI732rjEIpUJWaJLTFOXjcsHJ6Ujb67aj3HzTNTI5ioR65FOJ3/qzSpfEPCWoHBCfpOsWZ3YHAnslawFNgr8NLgERF1FHJn4ucvH2c/jtA+YiDxGfUkDAjdobRTHONmy0QzJ8NcCwozpZkOgobmNIvFVdCKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PnAJBcGpQ3U/PYO6jARlBQ9zTAEYuKnTFX5dhMzNpY0=;
 b=MFg9wnIhznPre50MRMV5wfK+W7YFsiB59sZBZdu6wtxeE+WfjiRlyJyc5elRPUXDw1HXmaHPEpFIZBB9dDQauPcTeh7Iu4kw6kNCEY04OW2NmK6WtnVRNXAmCyG+6jnjzDwv9x/RhRJyVpGp9TEJklEclx911EH5L+xuS7SxFpc1/zE9c87oE20MXvhE/3gPryTpCYCWNNHPR8U1zi9/Ct4GqPtjHxCX1K6a8N6aCJOQ3IxKG2Jyh1IPxYJMx2cFootRUOPVXbqCoqyif0jxoCNWnAlTWgF05VLYSDLJCAcVbaw4OhGAbwnBhjWnO2/r72673avhlmmtKNnuGSg0bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PnAJBcGpQ3U/PYO6jARlBQ9zTAEYuKnTFX5dhMzNpY0=;
 b=G/euT4n8Lvzyl2J8xoFKw0moti4pA4cl4Vi41G+daTo7fRQLOr9yx4AqhkWn9MqEGM7NLc3EZvRIjBSFh5Eq271TwWwWyNjPTbE/FK2HFp3dd7syDKHRrBEFE499YVHtoKpHc0jC2uUlJrq1KAVzJxyyoedQ4tlnJf6JhgjcJYQ=
Received: from DM4PR10MB8218.namprd10.prod.outlook.com (2603:10b6:8:1cc::16)
 by IA4PR10MB8756.namprd10.prod.outlook.com (2603:10b6:208:562::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.21; Tue, 18 Nov
 2025 10:18:26 +0000
Received: from DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2]) by DM4PR10MB8218.namprd10.prod.outlook.com
 ([fe80::2650:55cf:2816:5f2%7]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 10:18:26 +0000
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
Subject: [PATCH v4 3/9] mm: update vma_modify_flags() to handle residual flags, document
Date: Tue, 18 Nov 2025 10:17:45 +0000
Message-ID: <23b5b549b0eaefb2922625626e58c2a352f3e93c.1763460113.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
References: <cover.1763460113.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0233.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:315::19) To DM4PR10MB8218.namprd10.prod.outlook.com
 (2603:10b6:8:1cc::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB8218:EE_|IA4PR10MB8756:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b101520-2a17-4fe5-3b0b-08de268bd01c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?E0lZsFGkWI4T5tNJ9T7sy5c0+tskS72mJ1hTyZ+OOyLbF5nXnS2K7C0jLhtK?=
 =?us-ascii?Q?tHLqy5O25pL+utcQRlrYII3OL+W4et117XVHMfpJNybuhUaTW/j3bXt9pQG9?=
 =?us-ascii?Q?RluY+rFEq2psy7fQ4tzE73Th52xcFBp/IC5hxe5t8/+CobAFTHLP4Zqni256?=
 =?us-ascii?Q?tSpIsHpr9CRkTOsW6l+PkPdzvennfGtwgLlLnNc0AEoIAb5++RkNJmNKQ0pK?=
 =?us-ascii?Q?WAmh7VCfgz/0OeoA3G7kEcLk+IFsRr7MMIc7IGBYIyVHG5SpgHM9oxr8L2UR?=
 =?us-ascii?Q?QOZQZzEGCMwaexGZdKUI8FEDWNobTTQLCoF/hyl5tzU0oHncn0JczMYUcMR6?=
 =?us-ascii?Q?Qah/zkWulEYfbKhzD6TynW8tW2T1Cn+zvagL/wIYUyW+HCuPVa8qyepSfTze?=
 =?us-ascii?Q?TQk+FzZrWyU0SNjEREBTqGYOsmc/jX8GXLckufzAQzDBs7sYyw0eM5CCieRN?=
 =?us-ascii?Q?ZFJ3VqcUSO40A6b1z/Vxppgx8jVp5h0Ax0ma+oUdjK+PCz3jeEzwBarGNa3Z?=
 =?us-ascii?Q?wWuaIDzvQVpeAWkD0FBmGkjdlN40OG4KE4mmhAv9srzZGQzB6MmSOcm1ZmaH?=
 =?us-ascii?Q?hB0MFtCOlxifOJhDhZkwvFgvMwk1j+qk9pdzI5U9YhzbTPzZBKvQJYELUUcw?=
 =?us-ascii?Q?EksQEK7WXhTsI4JQ6vYX1r6jBFMVJTtobaQt7f3khhMe1svVhumSY3U+bVgO?=
 =?us-ascii?Q?fVROkGBetIAu3U0LlfvuefqD7Ia+7DAx9o1kCK8nwGaWg11r+K7WOC9U34PZ?=
 =?us-ascii?Q?V1C2JOgswaCcE1Y5CSTCDaAzzKm1h9ImVkLQRkj/kM0B1cC3UpZaiDFQE5UM?=
 =?us-ascii?Q?VED/cb5hip7T3mR5sidUW9wWIVRI0l+xXELLTd0MA2dy3Anru15ei33zvZMO?=
 =?us-ascii?Q?+pki9EvfqZMOB4HC3Mpb4WBZNYMVlwfG/WcTATUCZSJY1TxheyJferwSYOTd?=
 =?us-ascii?Q?Y8nabCpnjSnIhS0B0ywsfB5BPH9uTo5g/PukRoWE8vwioh1bttXSLdFzk3pr?=
 =?us-ascii?Q?eiOSsvj+/SyQadCHmyAo/VR++7BH60DP9NjYBnDZCZTtDTwKDIqgIzlhzzY4?=
 =?us-ascii?Q?Az2/5VPgC2LzFlpM+7ucIELZz2cQhix8rlwKRA2NLmc9+R/s3nhI2SAEeDBP?=
 =?us-ascii?Q?E6iCNwFBx3uiMj9ASqEF2y2PGQ0e/ytCBTLoIHUWJ1aSzrPj29eoon6vQJaN?=
 =?us-ascii?Q?AMeKX9ohbSoK1Kt23khYnmTjAGY4Pq/8RFW86ZNCcem9vPdb6ig7oe0HY4Et?=
 =?us-ascii?Q?up5t7a5qvFfNX48U0WDx98JGHZlwp33C312JHA3F2bJlhaGQ0mq1UsnqKBfk?=
 =?us-ascii?Q?ajBAaP9NNpnNXn4zN0P/02FCbrcQYHWZNOwWINszgDP+iT8Hd59TUEnIb6Q+?=
 =?us-ascii?Q?ditolfwv94V78oLEjNVLtpgrGkH+/1zVkCbxyfwt7cjNG9pPZ/naTEdapUj/?=
 =?us-ascii?Q?J+3+OhW4/ub0oini6KRui6af1ea1d76J?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB8218.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?p89VmQDqKVMNX0Ez+4qA9DHPuRNRuO7TwEMH+RAlpqb1AxihN56fY0iXArc2?=
 =?us-ascii?Q?At/73v0SoQyplk31YOafNPkeByIgYCMdIjDZi4QSnxvHWA/tAmMptoQ3AbFp?=
 =?us-ascii?Q?nGJbeKeJt0ewTrMsmXmX1F8MsPWrjgAI6tHDkIpvd9BX4ypzC8FP7hbbSFCe?=
 =?us-ascii?Q?f5E1LFa5zSSDCUhfJRNM9npiZhWxBOPZRXW8UxMBK1b8gqhk6PheItqBXCSf?=
 =?us-ascii?Q?ZRwezK1PcX/mDIZZrZ9aFyqzRWIqJKCdTeHxFOuXnfXYFj7hLfU5mdiKBnwc?=
 =?us-ascii?Q?oCmpA9RzJBWqkeO2P9e3RniLZznfHlPNMGt/kxLZfgcNyxMbFHmyzOVbvR5d?=
 =?us-ascii?Q?cZI2rdRRj6RMAxECQO5y+PHoREAioE7zLy+5reJGMoyT5vaf/UfvsVp00KhD?=
 =?us-ascii?Q?0XWaRwcMTQr4rjxEQhbnTD7yJGllhifLJtIuS3v5gHvxlGm1EX5CiUK5xdEM?=
 =?us-ascii?Q?CZHTb3CrZk9LeqdgdDfPCeHtvGiDuWx60UHkWeBRiActBRvapxpnXv4JE/qe?=
 =?us-ascii?Q?L9mykV9FaGknRQPGFV9UgfXBhBvqIGoGFGBZYCD/upEhxXQrIoB/WIV42W+7?=
 =?us-ascii?Q?uPCZw263ytULYQ5UHtHkJ/D6HzLK/d0If/LSflF3oYfemM/LfAFzFdjglPsY?=
 =?us-ascii?Q?Z+U/aNSLfKevCZ9MojxzmW38pYiTXVwkWu5iaAcGA4GuoSaD3bIIFYgitNbq?=
 =?us-ascii?Q?bHEcJvxPeBa9lMRMV4k/ICS1FAJTEEtLHy/xpWWzT9kB4PWbpG9NMU8L3rYa?=
 =?us-ascii?Q?dxb6Du6d+T/+QDj3xWFQSY4D9aJbTJx9fBmvusmW6zSvIOlcB3Si+er1bFjB?=
 =?us-ascii?Q?zush9bdR9CFGKhQ7890N58Nl/H+ObrhZEAP7S2O3mrvJ5+jZg1ejnEA4IimD?=
 =?us-ascii?Q?FTFR4sLZBUmRQqF3EfaYsiMXhcLQCNplpZKCmRYQiV+XGH0iC0tu48iYpti4?=
 =?us-ascii?Q?fk2Te/NYU8Rgs+EQeTjNjPNDxT8iRnxqqR+wHaD3ZhNhfUPkHLvZY4wJmW1t?=
 =?us-ascii?Q?vjYaoT1VCloVirIgaMEMFH7D8TsQ8oEf5jKKsTfDrFTS+2lahdaoUve38H6W?=
 =?us-ascii?Q?enzncHc+8a6rR74d+wWfmQI4lRU6T2cXtLdAuaO5rB0B612tn25gpzkIjLdT?=
 =?us-ascii?Q?AS0UVYs1iQ3Jt7U3r9lSrAgBVLvikWQ0c3wAhcvtrjKZZ0FmEIvAi/NCt8aM?=
 =?us-ascii?Q?EN0sdih1w6qVxk+t3XtUi0xgztSWcdWnwAIHmeaauTFFTeUcWaYA+WfJwVXV?=
 =?us-ascii?Q?I/YgIIuadxK6frLw06YSF0zbseGtC/UaX5gok6rh6vU4AdWClNGuP4Wm4mTA?=
 =?us-ascii?Q?vKZJjCZSkBuFC3stmL32SxdAIwGzN2J3FkiX6XTBrTe9oQLFFp9ZSGqL2ank?=
 =?us-ascii?Q?XPbgaKl5MS9JJBAmpLuxmcL+tsXo3F25/Z5ZY/MKBbgsKbFPrheL+6qC9jSU?=
 =?us-ascii?Q?M/D6+mspNIHe9f8eEu2dHG04FUqGjjaFNLtKMBcfdtEQdvbdZfd1JSFckYOe?=
 =?us-ascii?Q?H2W2Ot9toX3oQR+jupaq0Qh4elGt0WpEUSM3gSX9YNuOtpXPavz4442lh9dE?=
 =?us-ascii?Q?sTqN9IoNVBaLrz+X54VDOWBT7ISkv9BCnKlOu3fnp1FeOKC1RN4anYj/wtwe?=
 =?us-ascii?Q?gg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zq2d3K91x8yAQ86/PWakgfJm5r6g2Xs6GfYMF0kXV/RUsgXGgmf9RjUsM1qwKH9WM9UJ3RhJAM0UYZspPuHX3oHFai0v2G7I8hEqhy8YmtJQtCgRpVSzCwSC3sdwLKcLsriTVAN6+ZatrG9WhOBDVjhPsgnabvzBNIjyxnCbcuIG805uif1DEc30TZmwcqYw+7swt+mylatMXVkQH0w7LuGuAxzygzUV5fm8J/XKO2iaZAHMrzOtF19Q5SS261XcccW9PE1+gUS/tt2EazcDDb+oFMpIIsKfjMoa/MQ2ZzOQdPYy6TOBAnwsqO9akX3X4a4cHFT5Hhu6CGRqogITUrJU+hESglGKdKTGHMkoSLnjZ1NeyrDCuqoZ9Zdobg2pZuw4GGZQi+hw6d1w7WnCarBMNk/Lc8R+E3YVhIOed918wt+8/rJKWB3zQhnguRRDRCTzpKiO30VkpK5z4Gx3uCYSzBHWhTjaltANvmW2OVvhiWNlnudmOObDvAX45z7NOxHaAG/j+rgYBfgARF5yYS5lRmJg7Gip23i4yYFC4Fxv7ogcpF/xUMjAnSQHjqA7aPchgEZLHz41Qta//MaIGhSGHRR8jhRvMQYztjKChKc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b101520-2a17-4fe5-3b0b-08de268bd01c
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB8218.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 10:18:26.8630
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FKuvUby7J0qLyjbVm/+IMu+z9JKDdE/3Drs6V2MptjcPd/vwHfUqvH8DqT9hJEJBLMKNUfZFhsTFbSaplQxZ/a7Xf9rUoQ13SNU/nIvPy94=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8756
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_04,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 mlxscore=0 bulkscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511180082
X-Proofpoint-ORIG-GUID: LxSxeTHVR9PLh_G3PcVWRbOPrEJBn8-Z
X-Proofpoint-GUID: LxSxeTHVR9PLh_G3PcVWRbOPrEJBn8-Z
X-Authority-Analysis: v=2.4 cv=I7xohdgg c=1 sm=1 tr=0 ts=691c4800 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=26E9mIcMOp5Dy7kpKFoA:9 a=nl4s5V0KI7Kw-pW0DWrs:22 a=pHzHmUro8NiASowvMSCR:22
 a=xoEH_sTeL_Rfw54TyV31:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfXyiBhVJoCZ9aq
 oYtPSdOYfl3JMSwOQ5Inq904AeHb86NUf71PpgflLRGkXKYMVrD6lcdGA47kpnndoKjwmg4NDBi
 +NlMTt/nyiC++Hi6ZowPOcXqbOFjbvtuIz3CaqJosundFKJZ9k3GM3IEzC7NsCCtYb6g6V7++Gw
 TvRaObOVKS730TYJ+/PiVWaB5lXbxSbRJOjR7XortixWXGmoTgKzofHqtu6DNQ7c+KzgdQnpc4m
 51BNl1Gs3UvGcyKvxZEQeQhF0X9rmeLWxp43XhGGqh/xjYEKIj6oWxulnnn4JTb04PZr1LT5BEe
 ZA94AmxS3qW3AgpFyLAZ70SUYBRq6TAs4D25cWUuVwUlqrQtvVtwjtKmE9WxzGgWbltozZ5kATU
 My9jpPXYQj9J8L5x9LXWCLP/uu+KRg==

The vma_modify_*() family of functions each either perform splits, a merge
or no changes at all in preparation for the requested modification to
occur.

When doing so for a VMA flags change, we currently don't account for any
flags which may remain (for instance, VM_SOFTDIRTY) despite the requested
change in the case that a merge succeeded.

This is made more important by subsequent patches which will introduce the
concept of sticky VMA flags which rely on this behaviour.

This patch fixes this by passing the VMA flags parameter as a pointer and
updating it accordingly on merge and updating callers to accommodate for
this.

Additionally, while we are here, we add kdocs for each of the
vma_modify_*() functions, as the fact that the requested modification is
not performed is confusing so it is useful to make this abundantly
clear.

We also update the VMA userland tests to account for this change.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 mm/madvise.c            |   2 +-
 mm/mlock.c              |   2 +-
 mm/mprotect.c           |   2 +-
 mm/mseal.c              |   9 +--
 mm/vma.c                |  56 ++++++++--------
 mm/vma.h                | 140 +++++++++++++++++++++++++++++-----------
 tools/testing/vma/vma.c |   3 +-
 7 files changed, 144 insertions(+), 70 deletions(-)

diff --git a/mm/madvise.c b/mm/madvise.c
index fb1c86e630b6..0b3280752bfb 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -167,7 +167,7 @@ static int madvise_update_vma(vm_flags_t new_flags,
 			range->start, range->end, anon_name);
 	else
 		vma = vma_modify_flags(&vmi, madv_behavior->prev, vma,
-			range->start, range->end, new_flags);
+			range->start, range->end, &new_flags);
 
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
diff --git a/mm/mlock.c b/mm/mlock.c
index bb0776f5ef7c..2f699c3497a5 100644
--- a/mm/mlock.c
+++ b/mm/mlock.c
@@ -478,7 +478,7 @@ static int mlock_fixup(struct vma_iterator *vmi, struct vm_area_struct *vma,
 		/* don't set VM_LOCKED or VM_LOCKONFAULT and don't count */
 		goto out;
 
-	vma = vma_modify_flags(vmi, *prev, vma, start, end, newflags);
+	vma = vma_modify_flags(vmi, *prev, vma, start, end, &newflags);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out;
diff --git a/mm/mprotect.c b/mm/mprotect.c
index ab4e06cd9a69..db93d3bb1a5e 100644
--- a/mm/mprotect.c
+++ b/mm/mprotect.c
@@ -756,7 +756,7 @@ mprotect_fixup(struct vma_iterator *vmi, struct mmu_gather *tlb,
 		newflags &= ~VM_ACCOUNT;
 	}
 
-	vma = vma_modify_flags(vmi, *pprev, vma, start, end, newflags);
+	vma = vma_modify_flags(vmi, *pprev, vma, start, end, &newflags);
 	if (IS_ERR(vma)) {
 		error = PTR_ERR(vma);
 		goto fail;
diff --git a/mm/mseal.c b/mm/mseal.c
index e5b205562d2e..ae442683c5c0 100644
--- a/mm/mseal.c
+++ b/mm/mseal.c
@@ -66,12 +66,13 @@ static int mseal_apply(struct mm_struct *mm,
 		prev = vma;
 
 	for_each_vma_range(vmi, vma, end) {
-		unsigned long curr_end = MIN(vma->vm_end, end);
+		const unsigned long curr_end = MIN(vma->vm_end, end);
 
 		if (!(vma->vm_flags & VM_SEALED)) {
-			vma = vma_modify_flags(&vmi, prev, vma,
-					curr_start, curr_end,
-					vma->vm_flags | VM_SEALED);
+			vm_flags_t vm_flags = vma->vm_flags | VM_SEALED;
+
+			vma = vma_modify_flags(&vmi, prev, vma, curr_start,
+					       curr_end, &vm_flags);
 			if (IS_ERR(vma))
 				return PTR_ERR(vma);
 			vm_flags_set(vma, VM_SEALED);
diff --git a/mm/vma.c b/mm/vma.c
index 0c5e391fe2e2..47469c036a72 100644
--- a/mm/vma.c
+++ b/mm/vma.c
@@ -1638,25 +1638,35 @@ static struct vm_area_struct *vma_modify(struct vma_merge_struct *vmg)
 	return vma;
 }
 
-struct vm_area_struct *vma_modify_flags(
-	struct vma_iterator *vmi, struct vm_area_struct *prev,
-	struct vm_area_struct *vma, unsigned long start, unsigned long end,
-	vm_flags_t vm_flags)
+struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		vm_flags_t *vm_flags_ptr)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
+	const vm_flags_t vm_flags = *vm_flags_ptr;
+	struct vm_area_struct *ret;
 
 	vmg.vm_flags = vm_flags;
 
-	return vma_modify(&vmg);
+	ret = vma_modify(&vmg);
+	if (IS_ERR(ret))
+		return ret;
+
+	/*
+	 * For a merge to succeed, the flags must match those requested. For
+	 * flags which do not obey typical merge rules (i.e. do not need to
+	 * match), we must let the caller know about them.
+	 */
+	if (vmg.state == VMA_MERGE_SUCCESS)
+		*vm_flags_ptr = ret->vm_flags;
+	return ret;
 }
 
-struct vm_area_struct
-*vma_modify_name(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start,
-		       unsigned long end,
-		       struct anon_vma_name *new_name)
+struct vm_area_struct *vma_modify_name(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		struct anon_vma_name *new_name)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
@@ -1665,12 +1675,10 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
-		   unsigned long start, unsigned long end,
-		   struct mempolicy *new_pol)
+struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		struct mempolicy *new_pol)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
@@ -1679,14 +1687,10 @@ struct vm_area_struct
 	return vma_modify(&vmg);
 }
 
-struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       vm_flags_t vm_flags,
-		       struct vm_userfaultfd_ctx new_ctx,
-		       bool give_up_on_oom)
+struct vm_area_struct *vma_modify_flags_uffd(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, vm_flags_t vm_flags,
+		struct vm_userfaultfd_ctx new_ctx, bool give_up_on_oom)
 {
 	VMG_VMA_STATE(vmg, vmi, prev, vma, start, end);
 
diff --git a/mm/vma.h b/mm/vma.h
index e912d42c428a..75f1d9c7204b 100644
--- a/mm/vma.h
+++ b/mm/vma.h
@@ -263,47 +263,115 @@ void remove_vma(struct vm_area_struct *vma);
 void unmap_region(struct ma_state *mas, struct vm_area_struct *vma,
 		struct vm_area_struct *prev, struct vm_area_struct *next);
 
-/* We are about to modify the VMA's flags. */
-__must_check struct vm_area_struct
-*vma_modify_flags(struct vma_iterator *vmi,
+/**
+ * vma_modify_flags() - Peform any necessary split/merge in preparation for
+ * setting VMA flags to *@vm_flags in the range @start to @end contained within
+ * @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @vm_flags_ptr: A pointer to the VMA flags that the @start to @end range is
+ * about to be set to. On merge, this will be updated to include any additional
+ * flags which remain in place.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * In order to account for VMA flags which may persist (e.g. soft-dirty), the
+ * @vm_flags_ptr parameter points to the requested flags which are then updated
+ * so the caller, should they overwrite any existing flags, correctly retains
+ * these.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its
+ * flags altered to *@vm_flags.
+ */
+__must_check struct vm_area_struct *vma_modify_flags(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end,
+		vm_flags_t *vm_flags_ptr);
+
+/**
+ * vma_modify_name() - Peform any necessary split/merge in preparation for
+ * setting anonymous VMA name to @new_name in the range @start to @end contained
+ * within @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @new_name: The anonymous VMA name that the @start to @end range is about to
+ * be set to.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its
+ * anonymous VMA name changed to @new_name.
+ */
+__must_check struct vm_area_struct *vma_modify_name(struct vma_iterator *vmi,
 		struct vm_area_struct *prev, struct vm_area_struct *vma,
 		unsigned long start, unsigned long end,
-		vm_flags_t vm_flags);
-
-/* We are about to modify the VMA's anon_name. */
-__must_check struct vm_area_struct
-*vma_modify_name(struct vma_iterator *vmi,
-		 struct vm_area_struct *prev,
-		 struct vm_area_struct *vma,
-		 unsigned long start,
-		 unsigned long end,
-		 struct anon_vma_name *new_name);
-
-/* We are about to modify the VMA's memory policy. */
-__must_check struct vm_area_struct
-*vma_modify_policy(struct vma_iterator *vmi,
-		   struct vm_area_struct *prev,
-		   struct vm_area_struct *vma,
+		struct anon_vma_name *new_name);
+
+/**
+ * vma_modify_policy() - Peform any necessary split/merge in preparation for
+ * setting NUMA policy to @new_pol in the range @start to @end contained
+ * within @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @new_pol: The NUMA policy that the @start to @end range is about to be set
+ * to.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its
+ * NUMA policy changed to @new_pol.
+ */
+__must_check struct vm_area_struct *vma_modify_policy(struct vma_iterator *vmi,
+		   struct vm_area_struct *prev, struct vm_area_struct *vma,
 		   unsigned long start, unsigned long end,
 		   struct mempolicy *new_pol);
 
-/* We are about to modify the VMA's flags and/or uffd context. */
-__must_check struct vm_area_struct
-*vma_modify_flags_uffd(struct vma_iterator *vmi,
-		       struct vm_area_struct *prev,
-		       struct vm_area_struct *vma,
-		       unsigned long start, unsigned long end,
-		       vm_flags_t vm_flags,
-		       struct vm_userfaultfd_ctx new_ctx,
-		       bool give_up_on_oom);
-
-__must_check struct vm_area_struct
-*vma_merge_new_range(struct vma_merge_struct *vmg);
-
-__must_check struct vm_area_struct
-*vma_merge_extend(struct vma_iterator *vmi,
-		  struct vm_area_struct *vma,
-		  unsigned long delta);
+/**
+ * vma_modify_flags_uffd() - Peform any necessary split/merge in preparation for
+ * setting VMA flags to @vm_flags and UFFD context to @new_ctx in the range
+ * @start to @end contained within @vma.
+ * @vmi: Valid VMA iterator positioned at @vma.
+ * @prev: The VMA immediately prior to @vma or NULL if @vma is the first.
+ * @vma: The VMA containing the range @start to @end to be updated.
+ * @start: The start of the range to update. May be offset within @vma.
+ * @end: The exclusive end of the range to update, may be offset within @vma.
+ * @vm_flags: The VMA flags that the @start to @end range is about to be set to.
+ * @new_ctx: The userfaultfd context that the @start to @end range is about to
+ * be set to.
+ * @give_up_on_oom: If an out of memory condition occurs on merge, simply give
+ * up on it and treat the merge as best-effort.
+ *
+ * IMPORTANT: The actual modification being requested here is NOT applied,
+ * rather the VMA is perhaps split, perhaps merged to accommodate the change,
+ * and the caller is expected to perform the actual modification.
+ *
+ * Returns: A VMA which contains the range @start to @end ready to have its VMA
+ * flags changed to @vm_flags and its userfaultfd context changed to @new_ctx.
+ */
+__must_check struct vm_area_struct *vma_modify_flags_uffd(struct vma_iterator *vmi,
+		struct vm_area_struct *prev, struct vm_area_struct *vma,
+		unsigned long start, unsigned long end, vm_flags_t vm_flags,
+		struct vm_userfaultfd_ctx new_ctx, bool give_up_on_oom);
+
+__must_check struct vm_area_struct *vma_merge_new_range(struct vma_merge_struct *vmg);
+
+__must_check struct vm_area_struct *vma_merge_extend(struct vma_iterator *vmi,
+		  struct vm_area_struct *vma, unsigned long delta);
 
 void unlink_file_vma_batch_init(struct unlink_vma_file_batch *vb);
 
diff --git a/tools/testing/vma/vma.c b/tools/testing/vma/vma.c
index 656e1c75b711..fd37ce3b2628 100644
--- a/tools/testing/vma/vma.c
+++ b/tools/testing/vma/vma.c
@@ -339,6 +339,7 @@ static bool test_simple_modify(void)
 	struct mm_struct mm = {};
 	struct vm_area_struct *init_vma = alloc_vma(&mm, 0, 0x3000, 0, vm_flags);
 	VMA_ITERATOR(vmi, &mm, 0x1000);
+	vm_flags_t flags = VM_READ | VM_MAYREAD;
 
 	ASSERT_FALSE(attach_vma(&mm, init_vma));
 
@@ -347,7 +348,7 @@ static bool test_simple_modify(void)
 	 * performs the merge/split only.
 	 */
 	vma = vma_modify_flags(&vmi, init_vma, init_vma,
-			       0x1000, 0x2000, VM_READ | VM_MAYREAD);
+			       0x1000, 0x2000, &flags);
 	ASSERT_NE(vma, NULL);
 	/* We modify the provided VMA, and on split allocate new VMAs. */
 	ASSERT_EQ(vma, init_vma);
-- 
2.51.2


