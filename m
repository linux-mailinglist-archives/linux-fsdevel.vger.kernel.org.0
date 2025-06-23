Return-Path: <linux-fsdevel+bounces-52430-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0DC8AE334D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 03:34:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C8FD3B032B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Jun 2025 01:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4332C181;
	Mon, 23 Jun 2025 01:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="RCOSwg5I";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="0OFYsquc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A9442C;
	Mon, 23 Jun 2025 01:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750642453; cv=fail; b=h+6TgzicY0qntey8GtmXRbyqIF3c4Qe453dSv1EPqRQkzd/PuVAd8/8wFduzGdXUUhoZx7ikto/HucqSGe6JR6R0EGj3mgb1/h75racI3z0JRkxjILrrTH+gOXw189LYGbzfWzcl/VnuVWbEy+6wjT2hg2lPGfazIfnXJ7y6nH8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750642453; c=relaxed/simple;
	bh=9cGNRVivjSAcy4avUtEZeJXIAY9vE2r9+oeNcpoqNeY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=QAQdrxSXLo9Hvofrnl23E8er76juSSMhUWRJfYy0yNQLBpfduxkOUjgcAkikfEh0QVUC+eGqMpbu6sVdiIM6f3xJK6atsduptS8w88si1TLDx3msDBCXPeM5WtyFiA6DCN41fnUyGG7SbEGcJ6p7zMHv55bY4YzPnowl01u7Pfg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=RCOSwg5I; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=0OFYsquc; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0QnSe009387;
	Mon, 23 Jun 2025 01:33:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=ywOYu6Z255W3KdlbWf
	bxhDDU8aiDWFSD81l94Le6rGA=; b=RCOSwg5IXFqFTdYF4ZfDYOiTiS1NOeFC6E
	av2DAd79PnD9TvBjscLFmdLVDGaU5EVqMWAq5W+gfLYruXmEBYv4HagTMd8k+0vW
	mEB8iLUkcp8QHvdxVs96A0YaDSyHO4q8Fu8wF/Ntlagz61EfWe2fjPOUCfJeRLiw
	fZRIRwCAI+x7Ssxr+GimnBN3K5zxAln2hglLl9WhjYa7vadBlf3IaNTImWjzhcz4
	J9Taa4ptVrWJMgHavUcv6PXLCrnnXvl3mZi4fLwQf0xJ9zca/CNVvswNOn9LcymQ
	YvTNP52guAMNWZf/otE9e/a6RYbJhDuzkIl3P+rLQM7t5a14/95w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47ds8msnvp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 01:33:53 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55N0RaTv025060;
	Mon, 23 Jun 2025 01:33:52 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2083.outbound.protection.outlook.com [40.107.236.83])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47ehvu92mm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Jun 2025 01:33:52 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cTPMdtf9mk55cRbQ+YPw/MzdvX2f7ce5EqShHx1xTC72n3cAHPXNBnt/M4LQvp/9aXfR7wVF0ZX9CsToo6DR/0Rn6huAXy6S62PTJjaQS9L1jZtoLdE5iMfgckhayDnD6Cvj7WaTPGKcBPLq+v5wlSups7gwma/rHxh1wVN3i31nkrLpqAbMMkp18zYOk5M90aINUZk0VGcHP7rxZLMRcCb/IceP80DT8BvMfmmX/6eCLzgYvoD91UhyHHRkho73sPERCPRD8yUoqwCZaMeI26KZxMJsCdGHFDUUx5iopk8SCcB4ThQBG63quTnew1u248Paav0SgqEycX6ft68Gmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ywOYu6Z255W3KdlbWfbxhDDU8aiDWFSD81l94Le6rGA=;
 b=D4l5vXZiGJdydpdoUcMzK9vD1Gx/+F6i8M3ynoUrHp9VWm7wYH5DsIdRUPCecAlZmxnBsC9D9A/vUSTmO/kBx27LYQNsMbhavsPHUawXBwRxpLlwaayOInTiQlSd626qWbie9dnJoDKwNX2RlVlGaLxKIPcJTtysv+vzEH488Y3kHAjZD6TOcizckQi+5y5SXhvYSbB7MGR/TQsnn4IAa7hUzsxO8/av0t4nwrJcPP7ZkTFuol73M3Ks++xyTAYBBKEelWm3RCBFNEq0Ib5NmVy5Q5bUifudm9JiR16tiaclQ5hpFDaFbulgtLQFwPpyVOz7oNk87YNc8PBXqQOMsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ywOYu6Z255W3KdlbWfbxhDDU8aiDWFSD81l94Le6rGA=;
 b=0OFYsqucqFI9PZ5REpoodzT6CBvJuoJkJdqGF2o9ipb+Y2OM2RNLjrKhyIvvat20NNxneI0VhhXaga5eMdJ1yZeKn/oWEzra7UbiJUQPvCgoVq6EZIai1S/JEauv1KvgVca98sdBS34OAaMbHOjcU/2jXGc0hXJ0Ld4V+vcAvr4=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DS7PR10MB7177.namprd10.prod.outlook.com (2603:10b6:8:e1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 01:33:50 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%7]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 01:33:49 +0000
To: Anuj Gupta <anuj20.g@samsung.com>
Cc: vincent.fu@samsung.com, jack@suse.cz, anuj1072538@gmail.com,
        axboe@kernel.dk, viro@zeniv.linux.org.uk, brauner@kernel.org,
        hch@infradead.org, martin.petersen@oracle.com, ebiggers@kernel.org,
        adilger@dilger.ca, linux-block@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joshi.k@samsung.com,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        gost.dev@samsung.com
Subject: Re: [PATCH for-next v4 0/4] add ioctl to query metadata and
 protection info capabilities
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250618055153.48823-1-anuj20.g@samsung.com> (Anuj Gupta's
	message of "Wed, 18 Jun 2025 11:21:49 +0530")
Organization: Oracle Corporation
Message-ID: <yq1cyavqm1x.fsf@ca-mkp.ca.oracle.com>
References: <CGME20250618055210epcas5p397b5ca1dc472e3008af707391a5fa628@epcas5p3.samsung.com>
	<20250618055153.48823-1-anuj20.g@samsung.com>
Date: Sun, 22 Jun 2025 21:33:46 -0400
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0360.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::35) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DS7PR10MB7177:EE_
X-MS-Office365-Filtering-Correlation-Id: 96edaa23-24de-4253-cf60-08ddb1f600e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TgWsqVyAPV2zk3XrPzCd1QIQYA6+eJsqnA+LSVzIcaTb+/YadK79g7NtMq0L?=
 =?us-ascii?Q?iEhTdMNgqvlm4MgX9laY4a5wTYE9SjxlEqvrSbfIO210J51lGE6S58L0KiOT?=
 =?us-ascii?Q?w+aIvI5/9K8+6MoOUkYMGqnUEOC+HHAY7FiRxdiWXN5IjsaaVqmgqmPzQLuJ?=
 =?us-ascii?Q?6zBCNGBsBZwLcUAgjEmDR324zy7A3ACUgTE+94UBQq5dIUA5vCeblKTSfbuu?=
 =?us-ascii?Q?9j1ZPAPpalrNMfWKRTFsOQ0KBTBBbHtXynQzBlGmf/X4XnU/EDdaaBmod9d4?=
 =?us-ascii?Q?rlYOIn/I8cTkYxB96Di4JVPhEobMCr9W3IH08tSUAt8VL0CwTIbpckwaf/Jp?=
 =?us-ascii?Q?vL+Xn7fpYjvgsy0ySpYa5cGfavqlG+k8v5a1iQFDorZtROM0VkCAaF7SpBky?=
 =?us-ascii?Q?qLdtwhhFA7HR1yno1VE2BWWT48sHFHvgJWaiXmHstRH+I/fFIvCUYZyNxaBP?=
 =?us-ascii?Q?/HrlLzX2vfBHMHWE1Rp8YWZ186qQdevHK2wqV4bQiLVEx04KRQjFjlmtlhD7?=
 =?us-ascii?Q?NXanMQoayLF/Dnr+b62bQkwzTEED1Ap0VL3aaz5sc0xwaAx8eO7Sq9lRHx5x?=
 =?us-ascii?Q?VLn+yyOJPuL8wXGzP6ivOeiuTYS2CFH5UpNjkQEv2rvpKuuNT6tJoWLrqLhX?=
 =?us-ascii?Q?2Y+4iAlUMZFc5Mn6VTcYRHXxx2R1yNAb/QPdvjLVi3eKJEsLbYQuU6zzCKFF?=
 =?us-ascii?Q?Gj4KZj7tdSb0hlN0+YCNV38QyYgX+nB1JoFhtQG5b75sS+JakxIV9JWdNyuy?=
 =?us-ascii?Q?Gun4F/V0nbuumBV+vSo50MW0kmlD8U478/irNB/jJ+lbX7WExKhOb0ta76OJ?=
 =?us-ascii?Q?vZdxOCfbxY+V0SFZU/7Ua1p5gQ1vszaK5yUuJx33oU1FVh6zuJQB/QhXhB8X?=
 =?us-ascii?Q?7w8eBWPgyXbZrfp5mzDS+Y7y8qs84A12en8UjqwAhUKuyVeD4DXcNzQRuvqD?=
 =?us-ascii?Q?wjVN7Ikl1JXnvJmDKxG2yTa+r4D7VdpoL1sKX+Q8kY7geODcIPFB1eNZvgGS?=
 =?us-ascii?Q?YkzLwQNItRwhpq+HzFjPlOlLDhqx8UtbZ1Abgs1fx7d765JO9P/mBol9+IkS?=
 =?us-ascii?Q?mY50av7uwiWLrzZROe0svrlcXC2bAT8OOc2FKNwsLyUVr7lEoa4wWf8IaAI/?=
 =?us-ascii?Q?hZfR5uoiwY3iumDLjbmugVVIPMDsjl4Hw9qLcPU6WqaU6jStuGL4KJ6yiy6l?=
 =?us-ascii?Q?S3bBZ88lpXwT6TI3iuws67AlElzj0CffZrm+wGIcWx4Txy0gX2Ou+iqr2PeA?=
 =?us-ascii?Q?hEsetPkLz9D2qDPIAaPLyL6PhGwgY8nylNQO4NZ+V0BvEcBNCJat0ncd+R21?=
 =?us-ascii?Q?vdXRVRgC3FUkS5EcJpLufkXVKcn945hECQYJ9+irgNs2zY+nJsiSt8KiY/ZO?=
 =?us-ascii?Q?odEkHTys51G2Z8nRgChreApkA+xaPqTFsaolD79nMTci3PckVDMdeK9YP76M?=
 =?us-ascii?Q?Ozv/DIj61iQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?kV11nPD2tuCdGI12iG3mx3uEvmfow+6aouWY2+jXuffr0QxuUXOw+oiq7lH/?=
 =?us-ascii?Q?Vj3BAil02mwKz/OpaOTSfuOk6wYdKR/kqPldvm8+ZKmsdmHDq1wfd7NjXAuS?=
 =?us-ascii?Q?pK/XTdi1i+s6aqVfkLuxrBFqTG8an+BddGFT6EJMdqAuNDlW0+Bd681/vqPD?=
 =?us-ascii?Q?E0J4T6HFY/0g1cYVcysVGIJFFUJhb5vzGoKWH36NSdiOWNFi7TfJk5dPeFtK?=
 =?us-ascii?Q?u1IIEp5H8S6dXYB50DxTdQQILjuVf5Qg/6hlkLlqY6gjfoICvAw3Uc/wzzuE?=
 =?us-ascii?Q?EY8xb13AgRbSApjHxHEqaFBftr+u/XCu/dW026Z9/PPY07CpK8crY99p/iKA?=
 =?us-ascii?Q?E2+evBmHs32+2pPPKMgkKpjHQdDv/OZd86fAFUwZ7J2gJiHLoopp+sz7ALn5?=
 =?us-ascii?Q?QxrTJlQQAVVr4flRl7jqovI7xR5mGsOdhr4TUftsCTNJeBuESKywLuWWqLtX?=
 =?us-ascii?Q?twEM3aU6zjvjQ1eqENAPY72JipShe+oIEfPj3zk6liRCQXPsF+DhPcvZJ1S5?=
 =?us-ascii?Q?GfWwilFfZenok4t6aJ2RDPVVPuan0guGtHenC0sRFODy1kkFbhqWZ+QGOziU?=
 =?us-ascii?Q?IVMhgkhsNnjQOT4bp8Ljv7RDU8wNESMAgqQRhdCKiQ32ijkWiz3rbH4okaVJ?=
 =?us-ascii?Q?mAIKu0d5E6MS2oKj9xTeJEk5g+u6jbISemPwhyKfkHr9J/mwl+z+aiL+Q/Zh?=
 =?us-ascii?Q?Kea0kZMDoLxdjZ+4TF0WIi1jeuTvt5bVxWY5tMJM/xqORvFbFvXnIYW7oUdd?=
 =?us-ascii?Q?yuuBeA4mGm+jZplWEzZXU9nO2UuwL/dSVWU7fUWVJ8eY6H8tk245HlBrUDGl?=
 =?us-ascii?Q?5dTH7esX0vpk6xWInhz7xV3uCdqoHPgTbRYG2uhOciBKWLSdbu2WP//4fdEA?=
 =?us-ascii?Q?jIK4IsEEbtmMThq4uOXnQ7lsKUBmfOre8FLCdg/Rgu7yBctcQxpdLFvwU/fn?=
 =?us-ascii?Q?lqizgH4mzN6ZBHRq59B4dnffNR7pkboobfUOp7j+aRstnom8bNNNlQ/abazb?=
 =?us-ascii?Q?2OIx3xBvjKtWoDZtE+BEQ85DwccV8N6qvoOVKozC/PTPdLj0/KGkFTvJL2Dt?=
 =?us-ascii?Q?8+4pGDb2QhTsgmomTqPpKLLu4p5uyiBeM4s1edCIreB+61awfEKJn+HHVUmS?=
 =?us-ascii?Q?q6Fwsh9703PxHfgNBNEb5CVDoU0TjoW1uf2NXn6txxI30x9gKLkMlZgdp7oT?=
 =?us-ascii?Q?smpmLF4/JuqpDcv90k1hqyP41KMkcIIsCBR+Jh4+HOVE2fOuYXcIXh3hX5tJ?=
 =?us-ascii?Q?LYTZYOqax/M4UlefpqPFl3MRqLu6l1KFjGVHPe2hxRjUSc/FbbDl8QNcewYF?=
 =?us-ascii?Q?85YIwr+0QTOCe1VgO/YLDo55vBPUIkFYtnf9XIlAnW2ekLljk56wzuOJNzAz?=
 =?us-ascii?Q?NTFa3MoOrEdWfPPc2OpUmpj6wcw52clnkHYe0i6tQ8SsfwkOZP2WKPKeoaWI?=
 =?us-ascii?Q?qV6bFI/Lxwf0BC+uMTKO/lNTNcpDAahbSyrXX/BNaYL97Qly6xcpvePQXpBu?=
 =?us-ascii?Q?Hu6orG7kD6AyLZoBGhnoiEOA+xroRWZznyQuByRhH7OrWsss4gq3MCEI5NBB?=
 =?us-ascii?Q?KZUSLcpghWyggcRWFM+oXw2I+j5VLtMEGcfN6CvevF7tlIjxiQ/mDnXKv11+?=
 =?us-ascii?Q?3g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qClZJxaTiwfFNlO7n6WOj96Gv1A5WXENlng8ujPEdmWOnQlvPbhcQjJqPriOab6MakASRggEfGTkfeiODsAhyS2skyHLnr3Z3JiY2kpbYeIJ4UpfEQlOAVCRAsfS4cUED10r4BthcxQd69wVclgwTFJXOCQAhUKKTNdNrwmZbiWOatGq5BrXywdnU/DoRQlHTVAfY4aRPB+fXJNq8XxA+Efj4nR1GrHxQttRLDhRYhVadLebf7MCbR7ROqWMbXpVxMEKcUjKDd8mZCqP0tdIh66D1wza9wUEvxiZ58J1Lm6c4onwRNQmVB4LmLNWUa6RSR4KHfyv7ZzzP24gC/0jXqVl2dW7L8E8XoSPxqGXKq+x9gxS1Tz9l4S8ZTUhQ/RaHn1aWubHan7w9S67IEsp/TZmUJuG1vt6LuX39NSv9wE+7KyudOOUzn6nRtPI2OCdMy1icBxyuyg8DwA4wiusZUl0BawT3B0lzelEUH6F/gpcOCStWqxnMaFr/zhU6kDX8y9kN7g6+pSoQxxxdN8x0qIm+aI2U3L//VfcvoS+pUPZUJq8A5s5HWKzKO58/4CaghvyHhfyLaEg9+3UGDKRy5auaskhc6KMnxSYz+6U0OQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96edaa23-24de-4253-cf60-08ddb1f600e3
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 01:33:49.6400
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y4yBw2bRqRlTHXJkxjLOOdAX+ucXZ69AAin8a4rXXkNIbZyJ8Rww6l6t26DL5wUo0WIGAyp/oMoOaJ5p3qGTW1uocSwlhvgIrkBArZV9gqs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB7177
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-22_09,2025-06-20_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 spamscore=0
 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506230007
X-Authority-Analysis: v=2.4 cv=IcWHWXqa c=1 sm=1 tr=0 ts=6858af01 b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=p4HzJcn3jR7z0nbIS3cA:9 cc=ntf awl=host:14714
X-Proofpoint-ORIG-GUID: qI8omU7cxlFp1HPmiIsiHrW6V5DC-Ucf
X-Proofpoint-GUID: qI8omU7cxlFp1HPmiIsiHrW6V5DC-Ucf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjIzMDAwNyBTYWx0ZWRfX/EHkYR94Qxnu FvGs28CiDBYgwkP9xOollbtE86bEqrBTWNTbtMRYZ1KHWTtQS/J52Xx0fRhQZQ7Zhicqz+H6Ezc tT7S5l0XcV58cQPyHg5k+M7MljwlrcUGMi6L5leUJeYJ4McGQL75ppBHbaL43Z9jknYdWbzy6WR
 Mp5vsiQkgZz3yq7K4+Bj3vBv6WJ78ACn+4Kbt78ta4Hgy9KE6EsWNfCMkkks4XnMJLmZhvm+iv1 xnYxv8kqYM9Ie+pNh+4Dig6ngsifVlZ5J4ZfiGvAO9xmjxIG0eP1WFlX4qHNd6+GQtto+9FkEpj v/8ScTFy0wXkHhGiLFptVJUP34i8YYtIVB2NkX/bgbGdgbChhx6IeRDABkI15eDN/Q5HINgoLHz
 baKd0gObkz7RMfTutltGqzUMjqOrQ8TK7eoHhS3cTgfvfx7g2EK8xtZA7rJe+eUuDth/egnV


Anuj,

> This patch series adds a new ioctl to query metadata and integrity
> capability.
>
> Patch 1 renames tuple_size field to metadata_size
> Patch_2 adds a pi_tuple_size field in blk_integrity struct which is later
> used to export this value to the user as well.
> Patch 3 allows computing right pi_offset value.
> Patch 4 introduces a new ioctl to query integrity capability.

This looks good to me. Thanks for making all the changes!

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen

