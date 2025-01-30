Return-Path: <linux-fsdevel+bounces-40437-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 077D9A23547
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 21:42:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 705F87A32C8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Jan 2025 20:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E11D1F2C57;
	Thu, 30 Jan 2025 20:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Ft7g8fPr";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="hS3yGOQJ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1F041F2391;
	Thu, 30 Jan 2025 20:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738269669; cv=fail; b=V4FxnskI8jMFxKzFVGMUVDCQI/H0kCTGXw0kUmGNY+R6o84RpGgVhY7BNyQgpkOVPD1W7erMgxRvoQeqvvin3ROdBs9OdFRF6Is8UzN6W+lZ+Nc44Uwy5W5d6C5E4D+mT69Ui78l/QdO8gWG7PexCT1HKVb3twJLQfhkqGIsM8Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738269669; c=relaxed/simple;
	bh=H5sZ4kJJBfU7I6JbbUYcA52nUoFS5oJF/KYpRfx0Gjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UJX/KjsIbXA5/+Z1Yst5bz1RYRbweoU7O3jVvQFHEEHo0sqh3I2Tb+t/GXLWJa1b0VVlShjQN7IfbePt25ZHEboEtCnt09nFHon5NmsQGmXJwN/5RaBsG6A7i0h0xrbLhIAraB+627X+FRZbS4iSWVQET8LieF5/0YvK+oPdDDI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Ft7g8fPr; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=hS3yGOQJ; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50UKH0et026817;
	Thu, 30 Jan 2025 20:40:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Bk4iEJmNOs0gKjCIyK6jOaRhyYYz7iRVbjW4yL2p6M4=; b=
	Ft7g8fPr0hn07dsuEe9MphtGbWYQsT77SEDgmFoXA4pRYxWdybufzqdJZBPQ/Lj0
	O5mE+QifF3YWv3YAcHKWO9aK2Ouu48rveN0Ov4O6e6XM5E3QrpQPp/vTXR/23NTr
	b79SXAXLRgLQlT3vhbow+IjSIMVuntbc3OdonmxDbPbj9d+uU9Rf1haqwVFEBrIB
	4q3EEHYd4kgMB6+h5KBv5P+2GmSCQXn93UXp1bnj2b8/DQh/KVJhEAm56Jv6D8OL
	++d6Ta1d7X1ujHY1K3NZ+lD/Q4DPCowvo1cjJhh8eIvfd8Qgh1Gdy44sFxZ++btq
	O9LAsSE9RryB6pyKr2Sn7A==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44ggaqg1u5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:52 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50UJNXhp006240;
	Thu, 30 Jan 2025 20:40:51 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 44gfhtk6tc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 Jan 2025 20:40:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=piHxRbML8qMkjDXY/3cFu/kMLrVXnSRk9bPO94SoqBJjCVEY9aFaVqSNPbSj9X5BBI0atUWP/RyPJUhoYfVzp6LUikHxoYp1gny7xFC9OIa27yULyKJEKWh4jhQDoAZasqM+Ryp3M7Lo8DBpPW/hzzkEd6H2LCFPz8PbkBzxOxfesmO1AIh2HaDeNCWoJngYEswq8gEXGMImaIxQYUi/8N5HkBqzBblNiBNpu3HEj/2Nithz7quVOEX1MkDw9ZVru4dTey7mYOTWYK3Trh6iVNQ0H9tJqhM1dSncAbL0JzC+eyYKhXEuxbSVQDTMRSdAxYm/5TjC+cmZBneFLdLeCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bk4iEJmNOs0gKjCIyK6jOaRhyYYz7iRVbjW4yL2p6M4=;
 b=zJeX/fgL59OnUTOPwFNZPA+REpZavGL/XP/rbVsc9DH0PKvp0XyAv0MA52FCAf4k7UXAFgma8m/+ThcTsRclqnVExkwyy2jWZ4gCN/MoI+b6DbbDr+hwfoLxUKB0VCSySUK3cjDUcShvz8MXszQEuWnBP33fChyLkoOmvXqOWY6drJKEuM4+CY5l2oCpG012NIviB55KNhTx2uaIMxQxQgDSbXWICdviatwlYTVR5IhFEo2JEMCeIsCZ9WVtgXa5uTlYDADxx3/OyPdlIiJ0BH8D9+0GhIZyjUcg1RPuezmZMm9lzA4gMQFbEF81UT9pOuP4Tkw8dzfdSxxMNZOsOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bk4iEJmNOs0gKjCIyK6jOaRhyYYz7iRVbjW4yL2p6M4=;
 b=hS3yGOQJ5k56H2UXrCj/p74sktNsUgJvZBbnlr80xyhdlXi47gz4Aar+a+gqURqZPfobnYJmKsoK6h/ewb1n6GzRjvkCWlRnDZKpsoBXTIGL0oVqTzGKLtVwhOs8+VbSqFT+AMyqf3M3GGf5XpDzmBXKKylfiYPVh5cNs4EjOWY=
Received: from BYAPR10MB3366.namprd10.prod.outlook.com (2603:10b6:a03:14f::25)
 by SN7PR10MB6547.namprd10.prod.outlook.com (2603:10b6:806:2aa::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Thu, 30 Jan
 2025 20:40:49 +0000
Received: from BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9]) by BYAPR10MB3366.namprd10.prod.outlook.com
 ([fe80::baf2:dff1:d471:1c9%6]) with mapi id 15.20.8398.018; Thu, 30 Jan 2025
 20:40:49 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Christian Brauner <christian@brauner.io>
Cc: Shuah Khan <shuah@kernel.org>,
        "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, pedro.falcato@gmail.com,
        linux-kselftest@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, Oliver Sang <oliver.sang@intel.com>,
        John Hubbard <jhubbard@nvidia.com>, Tejun Heo <tj@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, Michal Koutny <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeel.butt@linux.dev>
Subject: [PATCH v7 5/6] selftests: pidfd: add tests for PIDFD_SELF_*
Date: Thu, 30 Jan 2025 20:40:30 +0000
Message-ID: <7ab0e48b26ba53abf7b703df2dd11a2e99b8efb2.1738268370.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
References: <cover.1738268370.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0072.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::21) To BYAPR10MB3366.namprd10.prod.outlook.com
 (2603:10b6:a03:14f::25)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR10MB3366:EE_|SN7PR10MB6547:EE_
X-MS-Office365-Filtering-Correlation-Id: 3634b2da-05bf-40d8-d37b-08dd416e6129
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?eJgoeI35AdpeIo9siq0kV42bzU9vaEM0IRlu6XcaVrI0p+SjU5zmRG/B4UJl?=
 =?us-ascii?Q?0GNxfE2KOFiMlmJmqc+obdhFkI16vl1q7btYKrJVZP52r0c4muGN3YQAghQ6?=
 =?us-ascii?Q?rK/YHQBNK0Xg7z6a7YKHtxSPpUiXnT4PO1qckWs5f5xA6PppkKE9O4yiYiES?=
 =?us-ascii?Q?AkE6PQCZ5isYoxKz8WIC/HE5om9QEEoilD+wS62GdWLFWazRcEHMBK8/AnIh?=
 =?us-ascii?Q?yehgN+R5zDVQv2gDt3eH5bfbLUUcuRBpSRmHo2CYcN/P+w0+VcNoyKyDji6X?=
 =?us-ascii?Q?+Fu1hPlQoFSFRPJszPS+GLR9TKGNhJal2TYon7uFfyRbwsq9CxkDITsswQxB?=
 =?us-ascii?Q?VxZkX7E9Tidxb/kRTRBNaCHFfKdSxq+NBe0YwQV3NnagKtTSz1Jjbuse7fqW?=
 =?us-ascii?Q?onYYSveVqvgMLcL54uX/Az+jP0/4IBN7rmtn+p6Piuq/qntqxvM+pSsjA9Fv?=
 =?us-ascii?Q?CtNotmYulG2oykmyJv77q/4VmTkgbLZzWCeOkhg38jfFoQNM33x8yJWOIOWK?=
 =?us-ascii?Q?sWlwgCxXiT9nS2niG0e1vJ8W3/yTl8vsbrsUx4PQ1CmiWGolDv2gjPfejble?=
 =?us-ascii?Q?4ijd668G+9o8M4p/xrk+D98us/9ZkgtOYJlnJO4w1i0CMA20/bHOn98BAGFp?=
 =?us-ascii?Q?P3/KSgcHPYMOgSOLQYCH3E8xDLUeXhiJoauiAjqHdRrkQhGR/R4u4Rfy+L14?=
 =?us-ascii?Q?JZJ3HXPbJs6Lekm2XQ0DeuKizR5WzCrupVd6JfkjKf+Phhd2pwyd4H/++CxS?=
 =?us-ascii?Q?onvtau4g9GWCKDCHnfl1P2/ucOshS9aXPnlboCPO97w5QQYKyZPvGgMZQGPh?=
 =?us-ascii?Q?+PDQ949KzmHwxy4FQYIQBGVgAoUSxEb5Z3g8gh/q3aQLpMJQ/VW/yo8BsL51?=
 =?us-ascii?Q?LBPk5W0o5zxGDkr0KcKwfORbYyi4kSwkJsWSnquf5j/8Bnz7teixCXfzf06x?=
 =?us-ascii?Q?pc+d+i0BgET4r1mv/dCjr0VZVC+WtgE+QbRStAr/by4jb4YzmZfMSOIjek+I?=
 =?us-ascii?Q?A76w0c7vGP/8FeqzVhtTSpjxQcI5kJHaFzfaNSRRi481XdHYRwe4wdB53+o6?=
 =?us-ascii?Q?HhQjop8hvdN+7ht7HGjDdjp5QgNVMPk6eERNsvz3Dd5o1d7Phwe88zInJwdC?=
 =?us-ascii?Q?su18v1rUYkDMD8LX5Vuj2R2hE09X7SYZK81r43AzZnb8l1NJDN6/+MHURV7H?=
 =?us-ascii?Q?/HXur1//lAXDCcfROoCcUXjhrco62dqH0ZIOyTljIMGKj8vEBbVeeYwEhIla?=
 =?us-ascii?Q?syrSksIF1Q3vQ6R8QXas+Fpwpho+4+qDvtFEwRkewVL7pnITUchrIVz+sscK?=
 =?us-ascii?Q?a50din4q9eBHKWdzrfkj/eU+D1xRfLXGSNxe8m8HJHlKXzi/j5U+FfjBf5dN?=
 =?us-ascii?Q?OcMY84EEzFkjbyeGB13FXkB4knTr?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR10MB3366.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wfABsDEwsqh9BaLFFQ3I1ELdWJ8cbdCESevd1/yHV5QSKN8TpXLpB8SxDgyX?=
 =?us-ascii?Q?bkdTVIfrymz+QzVZRBqPA82bq35Hp+aK2rpQLxk5kRQNODZbVg9pCmZRTJp0?=
 =?us-ascii?Q?xilaxa8ksQwON9hZPn/T/yC1FooKFhTvtbXTBFl9VCN1fWcBmWQU1yBIRhKi?=
 =?us-ascii?Q?1WgSSttMMVB6QAVpY/21RDTm2jYy/vE0zL4EaMe9nLFY+KNotyrvH6IMdg33?=
 =?us-ascii?Q?xgQNvd3W3c+dYLpjCth3FmxKJl3KLpFpeejZ05aM/zo4ceuK1IFxIFo5R/91?=
 =?us-ascii?Q?fb44TyG86Uq6rSTk+wNLP90tF1mHK767mwRCIGvcJHityaIwGdDoXQ0LnM4T?=
 =?us-ascii?Q?70la3zLXCOzmrDXP932Kxr3AbfWlUWJVgSK4fpz9vrCKyN/C+xlzPGtJ5nzv?=
 =?us-ascii?Q?dhatc4Ty0klVpYq7pPCHRJQzztbXiHdS2JdjbyvzWGdEeeeLktN3umU8EWkJ?=
 =?us-ascii?Q?rbdqQDJuKn/IHXhJ4FcMN9NJ2svKorRQpuZlTTsiyWOo7PB40TxuSfZCH6Tj?=
 =?us-ascii?Q?TSHEhopKoHffxpoinS2c7+NYcT5nJVzvJmgZTF3gbeC3BrspHXb/j9tyqqHS?=
 =?us-ascii?Q?6hMoEctDmgZ0vfpVb/P2BRyvwN2iJNbXflToLVTDFWOZ2c27z9Yx1ASqWzKl?=
 =?us-ascii?Q?XPPuep9MHt9CRLKiBLXMjdmcq+GXB1AcVCSx+ZPS9b6mVdcwayAflBLOXYZf?=
 =?us-ascii?Q?YDpNVEpyxXz9QG2FdTHbddueou1PtQlN9IkZuSRmdriMB4ZGwEuZ69qOexFy?=
 =?us-ascii?Q?wprOhTt1qIiQwICl1RLtUuVNwrIYQlmsFfxA6R5EGb+ScHNHyY1cBMgGlYtq?=
 =?us-ascii?Q?2W+WIsDaAGJFYeZF9dQC2j9gbNtYiUAdFC1DKRxO717yxphtGuzJdEw+hRir?=
 =?us-ascii?Q?Ix5ZuWOXJWn7vanY23YGDjBSqAimKEYXock3+JYCfOfnuaP6MhH8e/tprth1?=
 =?us-ascii?Q?W/vyvGaE7BOKyDUpjtPY+DELS2or2kr/T+/kVl/kRHptc6Q4FzujrCJNb+KT?=
 =?us-ascii?Q?UzT2BVHLVSPdmL/e1DY/L1iuiAbKCT2WaWoBuEr58XUQn2BKNLNWh7Wx9Qls?=
 =?us-ascii?Q?hqrGO0adeTP1gbDrhAKXWTKT1gNyITZAlpLRgcgniRPhsTSDwJLFIzKaTk5h?=
 =?us-ascii?Q?Sl8QNn8Vawf9rd1PrkQb0UYPVgZAWuvfad/roIXeD7X/Pcg50C/lHWI/u39Z?=
 =?us-ascii?Q?BglNIjxgim4vMpwKvzWR11jlkHZBTbrZ6hkS9IsKUjAuZPpDN79ISveBmA6D?=
 =?us-ascii?Q?QD/D6MtlvYxpsE7sx3EqTgtaamVMCgEHXSwuNyq5JohYOAxIa2dSfsMKNrmd?=
 =?us-ascii?Q?ABgWOy3AECe1toCJsIxP8qA6jzHviVlHqESntpPhcSI7MtSf6A1dT6L22Fh0?=
 =?us-ascii?Q?jbvjcQjoMIQ78ZepD9erwVGfWdE/ULf/bLBd7VvTy9JSqYepOfMWD+YOg8Bz?=
 =?us-ascii?Q?Mycz/V8J08ye1KkqA4zG45FW1Pt4GLyQ1lmmu1+VnFkjOI0sfZ2yeNXaVbGN?=
 =?us-ascii?Q?rVx+5IT31Vk5Qu3Do1mxBTkBeXY9ui4gnNu+oH6ROBkw6V6PLypNcYS6TRyy?=
 =?us-ascii?Q?MY3yiDDf9jAHC5q1E+HUrsAbYBB0hDSMqv6UC0ZsJiWUBQWjDBBw7XQ4tbhw?=
 =?us-ascii?Q?/g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	40KeZJHSLUoIhNyD8woiEHdNHrTaT+COoaX1XX9wYaZrv98C9xzS2JrN65RT2yU2LCQ58RNDvGoS7+zUXd9oNM4mQYxkpxj12xDpRiaQ4A/8AoPCW/cy0xpl6UWzoklXs/gOBScoblwO0jFQEwO/nxia5N+Im4ISgBeZWd/mSpJkC5TQNpXvv9mJWz3LyGwz+aiLG5APX+ZEY1yVfK9lNbVa0z9cEHK3v3J+KknliGfjzVX/zs0ZfhCU43W8aNV6vfvOjseg02tnCjWfF3J+QinOdyhbVKAU/WiryP7I4cFJ/+IprxSAIeIrFrTEe5CA41rLnqzVljn+ce70t0cClVfo4DC9q2O1+qlAlEbFEe6iGH21p0q9NpVeUVc4ymJtS6VbDo/J1+dVU967dmnI9dZTxIHceHcGwuXIUKXTrKgJC9hFyonQFYtW+R45unHtmZNAueEh3WACOoBPdecqZ6iieKFyGOEr6tyyMl+c7baFExxGZd85hPE7H5p5/tOZkXB5u/9pgr4nCKE+K6o/RukFte2GNnegDtrw3ncYl4gjDJsDvD2kuqHe3h3ijK6huCNkfxQ+k/6o6ZtsdOLqgoS7jpQjjvGbRruNKh34BCA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3634b2da-05bf-40d8-d37b-08dd416e6129
X-MS-Exchange-CrossTenant-AuthSource: BYAPR10MB3366.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jan 2025 20:40:48.9776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 99vuMzWRjg0R4X33wE3RdCyXTK0VwXBp655ufj129knETZL7+unesUVW7QHYTebZHqQhMQ8vyKQCXF7mtcoNyikfMQ5Ag5ML0UOmocFS130=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6547
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-30_09,2025-01-30_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 malwarescore=0 mlxscore=0 adultscore=0 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2501170000 definitions=main-2501300158
X-Proofpoint-ORIG-GUID: 6jpQdmPgzVkG9Pnyrlra1A1ppx64t9wS
X-Proofpoint-GUID: 6jpQdmPgzVkG9Pnyrlra1A1ppx64t9wS

Add tests to assert that PIDFD_SELF* correctly refers to the current
thread and process.

We explicitly test pidfd_send_signal(), however We defer testing of
mm-specific functionality which uses pidfd, namely process_madvise() and
process_mrelease() to mm testing (though note the latter can not be
sensibly tested as it would require the testing process to be dying).

We also correct the pidfd_open_test.c fields which refer to .request_mask
whereas the UAPI header refers to .mask, which otherwise break the import
of the UAPI header.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 tools/testing/selftests/pidfd/pidfd.h         |  2 +
 .../testing/selftests/pidfd/pidfd_open_test.c |  6 +-
 tools/testing/selftests/pidfd/pidfd_test.c    | 76 ++++++++++++++++---
 3 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/pidfd/pidfd.h b/tools/testing/selftests/pidfd/pidfd.h
index d02cfc5ef77b..cc684d872253 100644
--- a/tools/testing/selftests/pidfd/pidfd.h
+++ b/tools/testing/selftests/pidfd/pidfd.h
@@ -15,6 +15,8 @@
 #include <sys/types.h>
 #include <sys/wait.h>
 
+#include <linux/pidfd.h>
+
 #include "../kselftest.h"
 #include "../clone3/clone3_selftests.h"
 #include "pidfd_helpers.h"
diff --git a/tools/testing/selftests/pidfd/pidfd_open_test.c b/tools/testing/selftests/pidfd/pidfd_open_test.c
index ce413a221bac..9a40ccb1ff6d 100644
--- a/tools/testing/selftests/pidfd/pidfd_open_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_open_test.c
@@ -31,7 +31,7 @@
 #define PIDFD_INFO_CGROUPID		(1UL << 0)
 
 struct pidfd_info {
-	__u64 request_mask;
+	__u64 mask;
 	__u64 cgroupid;
 	__u32 pid;
 	__u32 tgid;
@@ -148,7 +148,7 @@ static pid_t get_pid_from_fdinfo_file(int pidfd, const char *key, size_t keylen)
 int main(int argc, char **argv)
 {
 	struct pidfd_info info = {
-		.request_mask = PIDFD_INFO_CGROUPID,
+		.mask = PIDFD_INFO_CGROUPID,
 	};
 	int pidfd = -1, ret = 1;
 	pid_t pid;
@@ -227,7 +227,7 @@ int main(int argc, char **argv)
 			       getegid(), info.sgid);
 		goto on_error;
 	}
-	if ((info.request_mask & PIDFD_INFO_CGROUPID) && info.cgroupid == 0) {
+	if ((info.mask & PIDFD_INFO_CGROUPID) && info.cgroupid == 0) {
 		ksft_print_msg("cgroupid should not be 0 when PIDFD_INFO_CGROUPID is set\n");
 		goto on_error;
 	}
diff --git a/tools/testing/selftests/pidfd/pidfd_test.c b/tools/testing/selftests/pidfd/pidfd_test.c
index e9728e86b4f2..fcd85cad9f18 100644
--- a/tools/testing/selftests/pidfd/pidfd_test.c
+++ b/tools/testing/selftests/pidfd/pidfd_test.c
@@ -42,12 +42,41 @@ static pid_t pidfd_clone(int flags, int *pidfd, int (*fn)(void *))
 #endif
 }
 
-static int signal_received;
+static pthread_t signal_received;
 
 static void set_signal_received_on_sigusr1(int sig)
 {
 	if (sig == SIGUSR1)
-		signal_received = 1;
+		signal_received = pthread_self();
+}
+
+static int send_signal(int pidfd)
+{
+	int ret = 0;
+
+	if (sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0) < 0) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	if (signal_received != pthread_self()) {
+		ret = -EINVAL;
+		goto exit;
+	}
+
+exit:
+	signal_received = 0;
+	return ret;
+}
+
+static void *send_signal_worker(void *arg)
+{
+	int pidfd = (int)(intptr_t)arg;
+	int ret;
+
+	/* We forward any errors for the caller to handle. */
+	ret = send_signal(pidfd);
+	return (void *)(intptr_t)ret;
 }
 
 /*
@@ -56,8 +85,11 @@ static void set_signal_received_on_sigusr1(int sig)
  */
 static int test_pidfd_send_signal_simple_success(void)
 {
-	int pidfd, ret;
+	int pidfd;
 	const char *test_name = "pidfd_send_signal send SIGUSR1";
+	pthread_t thread;
+	void *thread_res;
+	int err;
 
 	if (!have_pidfd_send_signal) {
 		ksft_test_result_skip(
@@ -66,25 +98,45 @@ static int test_pidfd_send_signal_simple_success(void)
 		return 0;
 	}
 
+	signal(SIGUSR1, set_signal_received_on_sigusr1);
+
+	/* Try sending a signal to ourselves via /proc/self. */
 	pidfd = open("/proc/self", O_DIRECTORY | O_CLOEXEC);
 	if (pidfd < 0)
 		ksft_exit_fail_msg(
 			"%s test: Failed to open process file descriptor\n",
 			test_name);
+	err = send_signal(pidfd);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on sending pidfd signal\n",
+			test_name, err);
+	close(pidfd);
 
-	signal(SIGUSR1, set_signal_received_on_sigusr1);
+	/* Now try the same thing only using PIDFD_SELF_THREAD_GROUP. */
+	err = send_signal(PIDFD_SELF_THREAD_GROUP);
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD_GROUP signal\n",
+			test_name, err);
 
-	ret = sys_pidfd_send_signal(pidfd, SIGUSR1, NULL, 0);
-	close(pidfd);
-	if (ret < 0)
-		ksft_exit_fail_msg("%s test: Failed to send signal\n",
+	/*
+	 * Now try the same thing in a thread and assert thread ID is equal to
+	 * worker thread ID.
+	 */
+	if (pthread_create(&thread, NULL, send_signal_worker,
+			   (void *)(intptr_t)PIDFD_SELF_THREAD))
+		ksft_exit_fail_msg("%s test: Failed to create thread\n",
 				   test_name);
-
-	if (signal_received != 1)
-		ksft_exit_fail_msg("%s test: Failed to receive signal\n",
+	if (pthread_join(thread, &thread_res))
+		ksft_exit_fail_msg("%s test: Failed to join thread\n",
 				   test_name);
+	err = (int)(intptr_t)thread_res;
+	if (err)
+		ksft_exit_fail_msg(
+			"%s test: Error %d on PIDFD_SELF_THREAD signal\n",
+			test_name, err);
 
-	signal_received = 0;
 	ksft_test_result_pass("%s test: Sent signal\n", test_name);
 	return 0;
 }
-- 
2.48.1


