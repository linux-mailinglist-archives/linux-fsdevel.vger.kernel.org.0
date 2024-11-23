Return-Path: <linux-fsdevel+bounces-35635-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC899D6900
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 13:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADE0A281DCA
	for <lists+linux-fsdevel@lfdr.de>; Sat, 23 Nov 2024 12:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4530D189BBB;
	Sat, 23 Nov 2024 12:23:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="enSMUZ7r";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ClitKqUX"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D3B3175D26
	for <linux-fsdevel@vger.kernel.org>; Sat, 23 Nov 2024 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732364631; cv=fail; b=iq4BNoW7XZmDuCpn2ClTgeHjeXEsupfCwr2v12l9BqxmAE/pXICKj2ZYgG+iOcLlmmWeIZvVSBYmgGOwaedPpExOaLoG0C47x54ezhvjYt+S1rum3gq2Zbx02xgnVj3EJg/3PGQ5jhkAP+xGmh//QmsdaAqIR8ZRtGwhS16quB8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732364631; c=relaxed/simple;
	bh=QW27jk+WYrT/a6r9Px/eAv9/Al44ZmykQbqYRhR8Coo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Snf/d00s8LDxrzf9Kw6rCf1fKGIlaxdLDwVUEQRgZlPfdStd0VmGm6PfwGzsiv2p8ddnvRjyj24+hJqshWz/birVZgAYR0hUkDlN/8Yzg9WLfcdIu0J38h2oCMD9DKJvzkGXf3huufj80RXtksjS0LOqndOhitPF6kNg4LDwqWk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=enSMUZ7r; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ClitKqUX; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANBtZUC015603;
	Sat, 23 Nov 2024 12:23:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=8mIJJicI8gaj6Pvpvi
	LVlqBlvq2QlOMP3viptNclw2c=; b=enSMUZ7rn+QYK0hBPQyTMD0ZJVI1XV7cpG
	6QLizw7XIe18TAbd+trGH8dszxw25/Rvefq4fyVWGmStYKPrkFdWBuN/6lND+aPM
	bLrOA44WLGSF7NCLMThw7P0Ga0eggp5d7AveLzeRxW9J9h4WbO0k5EfOj7R4o0nm
	qyNhGBw0EsobvgJp+p9UkK/MO3fKpKDVY9ZHrFkIxjlrgrpQsUYEIW0+MdIXyJGd
	mfouDGYmF3MhTPDAxqlX1r9S7djvJphVCcMCr84huGtffvhCXPfxBk71SosRkjuQ
	tx2oInNIhbjF59Z/0dkNWfJG6OL6xanrnSsb70YnwTQ2EXg70K6Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43384grcfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Nov 2024 12:23:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4ANAg97o027143;
	Sat, 23 Nov 2024 12:23:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam02lp2048.outbound.protection.outlook.com [104.47.56.48])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4335gbxcnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 23 Nov 2024 12:23:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FNwYbMyJs5cm/p7GqQaA37LUU7u5pf2iwVlV4xRiqsZYz9ydpUPp516Pvs7m4DcetgCSl6XW6aCgbbTessJoGJauZY4VzwHkeGEheDMEyLgjQgryABE+pkybm5zm/1TxPSHYD/FrhypmeLoAbIA4FxzaOWjaP5oAfjRnIMMwrW7xvFITOKEKmG7ZCwmbwIRRlgZtlvDAGe4BNrOpQgO5iCYtuMz/QOF8Zo6bOKJihA62oVHfXLBRYNtSHRjoAKRDXxCwhx49UOh8lKrOjdqw6erAjr0BMykKAwdD1XPLRpsL+DetsfZQ7yC3k17GmHc3R/lcAIMFLCEmhdl9OHFMfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8mIJJicI8gaj6PvpviLVlqBlvq2QlOMP3viptNclw2c=;
 b=kiJ8Mm1fs0SQQ47xjAI+laVWuTpLirHS3xyrKiaEr4RRVaJWFkO3U/cbZka02uD3k4/l6Vl4GvkfUqF4MCP4lxlV3Cw0c4y71cL8/tdf2ubD0AeKtORCxpCsN2gR5+d4SrjlC5EFdvo0sVutKXaCxVwGDZPuESexWrXB4BPDHH7VrkCdT92pc3BuWBOk0PrMKexczP3uQEi1HGNniRvUN0GmHOQn5s6sNNkrq8qv8QuytI7FYlIqIJ9yZb1i73vUx81Gxpl93hoB14bMM0YkyVmxrLpKOutCIy1s9JXe7J79Dbh/K/dERb7aT+fZPICWAkMTPph5MyxO/QBdNKGTPQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8mIJJicI8gaj6PvpviLVlqBlvq2QlOMP3viptNclw2c=;
 b=ClitKqUXP9YSOxw+QbIj87d3cb4Xynin+AS98LUJ7CYQ4x4E4zLJg83x+jIEXZYV//GXTNFOlnLETg/Fz6JV84h+j+npj5uaDARGgsS/m8GRBNx1aURkxeiVXpy0M++9bUP7s2KlN3E0MMMubpwPmfA0U9HfClKQVHJnB2u7BOs=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SA1PR10MB7700.namprd10.prod.outlook.com (2603:10b6:806:38f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.22; Sat, 23 Nov
 2024 12:23:14 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%7]) with mapi id 15.20.8158.023; Sat, 23 Nov 2024
 12:23:13 +0000
Date: Sat, 23 Nov 2024 12:23:04 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Bijan Tabatabai <bijan311@gmail.com>
Cc: linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, btabatabai@wisc.edu,
        akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org,
        mingo@redhat.com, Liam Howlett <liam.howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>
Subject: Re: [RFC PATCH 0/4] Add support for File Based Memory Management
Message-ID: <b33f00ed-9c63-48b3-943d-50f517644486@lucifer.local>
References: <20241122203830.2381905-1-btabatabai@wisc.edu>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241122203830.2381905-1-btabatabai@wisc.edu>
X-ClientProxiedBy: LO4P123CA0028.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:151::15) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SA1PR10MB7700:EE_
X-MS-Office365-Filtering-Correlation-Id: 8298ab6b-3369-4365-6a39-08dd0bb99982
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Lso+oYUnyYeb5e+1x5g54nLdWb8cn0NDatkeb1wqfaI0iX4k4yTUt2JWH+B4?=
 =?us-ascii?Q?O/aqxf/2DLVDc6G6SsmPluDxt8Hq4b6sjssuhB80WAk7VeL72mqmW2XT5iel?=
 =?us-ascii?Q?njo9qud3PjEqUffzW9pF7LNPPpSlwTbj5knePBccBKbLNNjxCT/jdHa+De2S?=
 =?us-ascii?Q?wSyBlec0ZjPpN0s4I+vWhNrM3SxUCD8osAW0bxwF8nr2lPEhpjk4DRcqGg3P?=
 =?us-ascii?Q?qlkPrfR9zLV2uqE66TJmjbOpDF6X23mzWCSK2bAy+7s2PHr6XKSRCJqoSYSH?=
 =?us-ascii?Q?WCz9EJKlVIg2GGQPV6XQEgTmOgIPSGPriPQZL/1qJzGi/+O9rxXrDydm9AVp?=
 =?us-ascii?Q?7HiCz3qu6jDH4EWXu9DQP7oIB15Y0lku2YLFe4S/srkswsBt3IC6HAwNmEUv?=
 =?us-ascii?Q?0q3erQfL6GbeqywYnMW59g5MtgRnH1GKYbl8IWps8k8RV+ycxSXKR977ij29?=
 =?us-ascii?Q?BSNxVZ+wKBlvzQ3aGvQeZZaVMQZlxxdHEnxzP/b/i7yttHmr/hc4r24VNU5Z?=
 =?us-ascii?Q?4JP1wgF0FYnVs4CIJSTRQGlct6Fd4YsqPmCoKuqte2pTfuKKwxh2kBVCeb9o?=
 =?us-ascii?Q?Vqu+0XracqkO4rdcX0p7slT387n73OrcMZVr+hHzaycfj5yHiayEtzYuOLc6?=
 =?us-ascii?Q?U6xeJCyuPUl7V6OFMm8up/Jd7H+HjdDsTp5Yd38Vmrykzsz2V4El+3vQ5M0C?=
 =?us-ascii?Q?Og//sDNDw3F1YLYSUAhPDeSMkSZMuOl6VQ3Z24dRjYIH0ai0IN5s6BddsQeu?=
 =?us-ascii?Q?XUWTHG+ULPm0QPVeAdbGn/JgCT8t7E8t/2excE6FqblXPBAz5UafkQTgQH1w?=
 =?us-ascii?Q?Mk8UwZ3UPdQuwdg/ZHSlAvhsXz4yN+0nNvnoxgSJpAE35qJTpqy2MGkYmC8V?=
 =?us-ascii?Q?RxN2CF2T3VndXYp8cxDr5AWn9dFgghpyYj7mk3hXm1rBuv5j5MJQJbcApA0W?=
 =?us-ascii?Q?5GMxsKZngKMK9CTE0ctzvAw2b7cN9ykfdFoI6sXR5dSsmCqh5c1NubGW3jWg?=
 =?us-ascii?Q?3vVKCIRe1KDD/MKZ9cyRe6j9uZHYuGoDdlUzw+Ht45asdB9na96/ZN5z+AOx?=
 =?us-ascii?Q?awzJPlCQDkv9IYZcKBMWZJrIky+SgmPu0l3b3Yj+4UB1T4YhHyzB6nVb1GtZ?=
 =?us-ascii?Q?OBl8ovUTUj6mGqlbmXRa/ot+3Cw3PV7acQY1/QN6xAbKxMGiNjxjHHzWiwmm?=
 =?us-ascii?Q?ZvZzI0s7KDXqAwntq04XPJwmgeke/DavAmvRKorSclaQOjTmsd+5N4MpWM/w?=
 =?us-ascii?Q?XFBM/DyRtbQs7rBn3YKubvviFgierTpkbDnWxV6Kv96N6F7DNTJuMhIz7ptX?=
 =?us-ascii?Q?ad0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?STtXQafZds80JHimjkLdw1OYBJAPKX7To522Yuz+wGZ6670UZk2XAyvpa/Ud?=
 =?us-ascii?Q?AlQgF5CoLUdAeelao1ELeZIweLf7m8xdN4fC+Z73i1MX2xtjBBZUaFL94Bxh?=
 =?us-ascii?Q?nP9TUiVyZjcRRrDQZo/8oJW8Picrpvl+rAke/3CZe2eaPKT04onMKOs8UQur?=
 =?us-ascii?Q?ThkYkiaHvbKiJatBzgvLJcmInlq1CbTW3f1LpCyOenCpJxndR9cMo7diqVX8?=
 =?us-ascii?Q?MQuXH/XbrPdVX9Kpyp6JPCWFdX/IJAvjr/WP05lAtp2cMBgSfZt4dqHwwqQ2?=
 =?us-ascii?Q?DWC+Zq8gbqC/DDEXRwDlVA2841pnLvqTW59MYCbMbQR94slZcjTbd2V4ohB1?=
 =?us-ascii?Q?KNwQDDJ155B0jjCDRW2aJpAt8h45UyaFKU6xOMyCS76ycBNcAzn71uWqI3Bj?=
 =?us-ascii?Q?HfF2suIl+jmiiJXyQ2CKL4jFT4zN5+cS/HyAilH9+oDmKB6HoPllQf0qJLaA?=
 =?us-ascii?Q?SHteDrqT40vsW1yE+wEFCEz8ImMBnszayBLtdXS9NT9epDqh9/PvvFpLriW7?=
 =?us-ascii?Q?xscRzoYToA22Jj5Kij9wfRkFAPyhlISJOwWOB5pI8aAkk7dqD6D5FIo5ZJNe?=
 =?us-ascii?Q?oIQhfyqEaeJbFUyowTo9cLi72QcQ8+j/BQAIPaS8prqu+0eeaDf0+U0AAVMT?=
 =?us-ascii?Q?al2OJ3It5VdtjAbQkfCWe4JxvG58wNmeXhged/erKmoSoI9pgR3gL3r3FUfj?=
 =?us-ascii?Q?GmWh69Narw9FB8WdVa0vVEf7SbwAq9niJ/OBvNDxkZF29vqPDhFwZCCw95WP?=
 =?us-ascii?Q?Hn6/tNxo0ECiNgkdnqlYeMnbGJIhjWCUDXZo8R5wALn9mFx28mmrT2k9+s4T?=
 =?us-ascii?Q?bjSnjuomZi1BlFiPvWbhvcopNdZA/V7Y96ZWIASn6KAf2xqBYkHJ2W6WYXXr?=
 =?us-ascii?Q?yIhgoKppB1MtgtKr6ZUhJtkHa//nIxvK5Hfs+UrtfY7uh4ulOX7SXj7/8ssN?=
 =?us-ascii?Q?QUBNItrvpt3LejD2dE0grufwMNClcz6jY0oeyd1kGj2jSAmwEGWnNdZL55Un?=
 =?us-ascii?Q?WWqD5zXW5ZonhpEutR7/MoesPTzUXfV/NF8M+RSIYzgTh2ihYTIb9E2fi0Td?=
 =?us-ascii?Q?oXMgGaAagDV/dhz27/KkWIc7HkqC4cBymwjJCwjWkr0auNYTDKaLa9lAzDhL?=
 =?us-ascii?Q?2HaqT6HSJZZgjGuDB9ynKFAGKmILiJH/Tpgp+S/9DLufViiPb5QwRcndMzTD?=
 =?us-ascii?Q?AeF9d9QIOsqghvhtWL80EbZp46F9hF/lhdfUEjm4iThMRee5VBWBYpgVHbqD?=
 =?us-ascii?Q?eLj+3YAj9zTSzHpIHUytcj6QlNfnc3VCTGBGDIVXlN/h6/1rxYsvy6BwaFcT?=
 =?us-ascii?Q?0uknFigzapSPtS8DIHPH9yZ4GWjVd0+eauZwR2rIMBpHgxujpRjsn1dGhWtB?=
 =?us-ascii?Q?4lPJACtUnEeKoJ3f8iJj6VZBtryHra62Hev7WA+bhg1K5VGVNBYlAsjMvlMB?=
 =?us-ascii?Q?k2Qo56gCuhID0QVB2P/YaKuUf1XhW4iIw7ziFmN0fngC8z8IlanNX7jHrjbz?=
 =?us-ascii?Q?WK/qtu3Etr5qoh82OZ41yZx1+9FUvYojVogcH6iv7VOor1E/AWaW8dJVCCgo?=
 =?us-ascii?Q?aq/ANI9GSbk0iybTNyOUIv95WwikkXoJvd6+4k0731Gm76lSq2OEDmyWYfz2?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	vvpkBqWMEJTk0M1ltp3AKLoN3n2x03OVYcMpG73vyg+z7IO8siQDb5941zp2aUHFa2NMa2qYQVj8jKCQ+V8vhWfqIwUxRW52pYPV8QXL3uLE8rqPEK8QFw65dv6ZDNusoeXdmG2ziEAikx3vvTrQUMn8kpGyfi1/tszr3CC2R+DassywqUIUq1PkwJVLS7KaWMdZjkqbaYHMCzu7AayBsgc4W6Do0wz7X/aC4ilqNGpQ27AtsGymPdevYUduoYL7CiplCnvMa/hbVV2Y5z+Np/huTsSSVZNAklB4XWu1SdXXlNeL5zN3oaIzAh2l3BV/ajSLdP1MONg1m2Og48y0BR+7D7o+WAHFLy2HFVRXdpjO1jjDICPdEAvhdzPGQC8pnisvxDMGkOkGoZgGq9h+e8k75Q7L4YgZ46WDb3OGjPXjqDxlj62j6Cntgaqw7CUw6TsuNTSXg56RK0VUjp03Et/faI4MN/zTW+UyWnNAiv5YDgelxMhB4SJjyme9+djdiKOBmStYLHLjn7tpv+kh3eM3saNXvSFv9bzJwq6/tQmssn8oiVaDy5N9h3bWQNBz4XP40F0s3P8p3qlbDr9DbIrbogcPaPvG/hy11RfwMcI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8298ab6b-3369-4365-6a39-08dd0bb99982
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2024 12:23:13.4024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RwP4sdoYkFMaPPQ+roC1SSHKQSyO3c+1ukZqAFFEqtbCsgrwc16bhWYWIbapWJnTpllACk0qupR+OZukL9remd2oHoqDx+pt4RsbkxbE0Vg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7700
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-23_08,2024-11-21_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0
 mlxlogscore=748 spamscore=0 suspectscore=0 mlxscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2409260000 definitions=main-2411230105
X-Proofpoint-GUID: lPFT_fQQlAnyBDPZnk8x-nn529q4wTJG
X-Proofpoint-ORIG-GUID: lPFT_fQQlAnyBDPZnk8x-nn529q4wTJG

+ VMA guys, it's important to run scripts/get_maintainers.pl on your
changes so the right people are pinged :)

On Fri, Nov 22, 2024 at 02:38:26PM -0600, Bijan Tabatabai wrote:
> This patch set implements file based memory management (FBMM) [1], a
> research project from the University of Wisconsin-Madison where a process's
> memory can be transparently managed by memory managers which are written as
> filesystems. When using FBMM, instead of using the traditional anonymous
> memory path, a process's memory is managed by mapping files from a memory
> management filesystem (MFS) into its address space. The MFS implements the
> memory management related callback functions provided by the VFS to
> implement the desired memory management functionality. After presenting
> this work at a conference, a handful of people asked if we were going to
> upstream the work, so we decided to see if the Linux community would be
> interested in this functionality as well.
>

While it's a cool project, I don't think it's upstreamable in its current
form - it essentially bypasses core mm functionality and 'does mm'
somewhere else (which strikes me, in effect, as the entire purpose of the
series).

mm is a subsystem that is in constant flux with many assumptions that one
might make about it being changed, which make it wholly unsuited to having
its functionality exported like this.

So in in effect it, by its nature, has to export internals somewhere else,
and that somewhere else now assumes things about mm that might change at
any point, additionally bypassing a great deal of highly sensitive and
purposeful logic.

This series also adds a lot of if (fbmm) { ... } changes to core logic
which is really not how we want to do things. hugetlbfs does this kind of
thing, but it is more or less universally seen as a _bad thing_ and
something we are trying to refactor.

So any upstreamable form of this would need to a. be part of mm, b. use
existing extensible mechanisms or create them, and c. not have _core_ mm
tasks or activities be performed 'elsewhere'.

Sadly I think the latter part may make a refactoring in this direction
infeasible, as it seems to me this is sort of the point of this.

This also means it's not acceptable to export highly sensitive mm internals
as you do in patch 3/4. Certainly in 1/4, as a co-maintainer of the mmap
logic, I can't accept the changes you suggest to brk() and mmap(), sorry.

There are huge subtleties in much of mm, including very very sensitive lock
mechanisms, and keeping such things within mm means we can have confidence
they work, and that fixes resolve issues.

I hope this isn't too discouraging, the fact you got this functioning is
amazing and as an out-of-tree research and experimentation project it looks
really cool, but for me, I don't think this is for upstream.

Thanks, Lorenzo


> This work is inspired by the increase in heterogeneity in memory hardware,
> such as from Optane and CXL. This heterogeneity is leading to a lot of
> research involving extending Linux's memory management subsystem. However,
> the monolithic design of the memory management subsystem makes it difficult
> to extend, and this difficulty grows as the complexity of the subsystem
> increases. Others in the research community have identified this problem as
> well [2,3]. We believe the kernel would benefit from some sort of extension
> interface to more easily prototype and implement memory management
> behaviors for a world with more diverse memory hierarchies.
>
> Filesystems are a natural extension mechanism for memory management because
> it already exists and memory mapping files into processes works. Also,
> precedent exists for writing memory managers as filesystems in the kernel
> with HugeTLBFS.
>
> While FBMM is easiest used for research and prototyping, I have also
> received feedback from people who work in industry that it would be useful
> for them as well. One person I talked to mentioned that they have made
> several changes to the memory management system in their branch that are
> not upstreamed, and it would be convinient to modularize those changes to
> avoid the headaches of rebasing when upgrading the kernel version.
>
> To use FBMM, one would perform the following steps:
> 1) Mount the MFS(s) they want to use
> 2) Enable FBMM by writting 1 to /sys/kernel/mm/fbmm/state
> 3) Set the MFS an application should allocate its memory from by writting
> the desired MFS's mount directory to /proc/<pid>/fbmm_mnt_dir, where <pid>
> is the PID of the target process.
>
> To have a process use an MFS for the entirety of the execution, one could
> use a wrapper program that writes /proc/self/fbmm_mount_dir then calls exec
> for the target process. We have created such a wrapper, which can be found
> at [4]. ld could also be extended to do this, using an environment variable
> similar to LD_PRELOAD.
>
> The first patch in this series adds the core of FBMM, allowing a user to
> set the MFS an application should allocate its anonymous memory from,
> transparently to the application.
>
> The second patch adds helper functions for common MM functionality that may
> be useful to MFS implementors for supporting swapping and handling
> fork/copy on write. Because fork is complicated, this patch adds a callback
> function to the super_operations struct to allow an MFS to decide its fork
> behavior, e.g. allow it to decide to do a deep copy of memory on fork
> instead of copy on write, and adds logic to the dup_mmap function to handle
> FBMM files.
>
> The third patch exports some kernel functions that are needed to implement
> an MFS to allow for MFSs to be written as kernel modules.
>
> The fourth and final patch in this series provides a sample implementation
> of a simple MFS, and is not actually intended to be upstreamed.
>
> [1] https://www.usenix.org/conference/atc24/presentation/tabatabai
> [2] https://www.usenix.org/conference/atc24/presentation/jalalian
> [3] https://www.usenix.org/conference/atc24/presentation/cao
> [4] https://github.com/multifacet/fbmm-workspace/blob/main/bmks/fbmm_wrapper.c
>
> Bijan Tabatabai (4):
>   mm: Add support for File Based Memory Management
>   fbmm: Add helper functions for FBMM MM Filesystems
>   mm: Export functions for writing MM Filesystems
>   Add base implementation of an MFS
>
>  BasicMFS/Kconfig                |   3 +
>  BasicMFS/Makefile               |   8 +
>  BasicMFS/basic.c                | 717 ++++++++++++++++++++++++++++++++
>  BasicMFS/basic.h                |  29 ++
>  arch/x86/include/asm/tlbflush.h |   2 -
>  arch/x86/mm/tlb.c               |   1 +
>  fs/Kconfig                      |   7 +
>  fs/Makefile                     |   1 +
>  fs/exec.c                       |   2 +
>  fs/file_based_mm.c              | 663 +++++++++++++++++++++++++++++
>  fs/proc/base.c                  |   4 +
>  include/linux/file_based_mm.h   |  99 +++++
>  include/linux/fs.h              |   1 +
>  include/linux/mm.h              |  10 +
>  include/linux/sched.h           |   4 +
>  kernel/exit.c                   |   3 +
>  kernel/fork.c                   |  57 ++-
>  mm/Makefile                     |   1 +
>  mm/fbmm_helpers.c               | 372 +++++++++++++++++
>  mm/filemap.c                    |   2 +
>  mm/gup.c                        |   1 +
>  mm/internal.h                   |  13 +
>  mm/memory.c                     |   3 +
>  mm/mmap.c                       |  44 +-
>  mm/pgtable-generic.c            |   1 +
>  mm/rmap.c                       |   2 +
>  mm/vmscan.c                     |  14 +-
>  27 files changed, 2040 insertions(+), 24 deletions(-)
>  create mode 100644 BasicMFS/Kconfig
>  create mode 100644 BasicMFS/Makefile
>  create mode 100644 BasicMFS/basic.c
>  create mode 100644 BasicMFS/basic.h
>  create mode 100644 fs/file_based_mm.c
>  create mode 100644 include/linux/file_based_mm.h
>  create mode 100644 mm/fbmm_helpers.c
>
> --
> 2.34.1
>

