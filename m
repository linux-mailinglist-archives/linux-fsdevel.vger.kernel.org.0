Return-Path: <linux-fsdevel+bounces-23019-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 689CD926015
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 14:19:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 327C7B25961
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Jul 2024 11:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF1311741D1;
	Wed,  3 Jul 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MTG6AF+M";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="t0Wx9uJ+"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25672171E72;
	Wed,  3 Jul 2024 11:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720007891; cv=fail; b=dIh6BpNUpAHKFDZTBt71gJ8L+DWT41kUU3seQIkc9vvBX11X+4c3Rpt9L1evhZ6hfbuXPvzP6TtfpUXmkaJAy33UusmKBrUtuqxrrUajPuh/grI3uVZvmqDAAJ5AVvoV5vZ9FfciA2p7Kyygoi1RbfOSh13Mw7sF7Yg+p8Skq0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720007891; c=relaxed/simple;
	bh=nde+r7ZZvLCwI9OIF1UM27sBtlkT/gLVXn3TCYpzno4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZjXx/Cr+bxcZ23WiNPVdWouTW9S6W1sNssPeSgw+DNbGFet0GOLa5jo9Zx1AVVS6AVpEc/AanUI3nMA1Qc97qPoU516q8/FoS3X+rs2vXUb8YehYisFeOsN0DPpD/g/PXiHVVw335Tc44Nj1SVlnw7rmDkqlA4oUDzhUvAUOCuk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MTG6AF+M; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=t0Wx9uJ+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4638OLQL016018;
	Wed, 3 Jul 2024 11:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:content-transfer-encoding:content-type:mime-version; s=
	corp-2023-11-20; bh=22hILCM5X9sMn9gY63YTPAbD4zPS0lb7vfJ+lyUfogw=; b=
	MTG6AF+MN+yYFGgv+m0nAAY70WHkhn8K+0+KewXyhTBf7AN4sY/fDIVfbQsBw3q0
	RWGFDrc2HX0GYoXNM0eaK5iE4nFKKOG39bRmwH3cje6Tak/K+BS6i3wk7jeiqCr+
	jxyojl7PZTQs25ngmuPTTiuWAEYh1qOHbtg87xKfDrrr42bRB9yT+vt7tb1C/O9/
	wQGM1dWW79v8WZzn9kerCtES9J7SL/UfJa1Ww37pigiuUBVaDc8tYFYgKt+J4yKc
	BCNR8YehNRLr9wepyHiNk6R+ScMxb/lHz8dqpNTtUmR6hOvDD0adD3KHmwQW47zv
	9y1/QYmZbQ2hM+F/H3q1yA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 402a597t1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:57:55 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 463BIOex010195;
	Wed, 3 Jul 2024 11:57:54 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2174.outbound.protection.outlook.com [104.47.55.174])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4028qfekkr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Jul 2024 11:57:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bRSf3U/THjv65AJQlUQQ5/d9UlPu5haKC2ys7OpRauN7LwvgQTta3bDjVT7Eg2nADTxGSAgLqs3S/XMSjt0AOPB0L0p/kn1UoaWeUqbq5wZDqJYlNVE+QepO2G5rDGW90EPNukRaIirVW04iJaoBB4tnTva2ZXwNS10rjAKXOp/A1RX8vkvIw1gYGbfsHG873P8EK/zvWojMFhaOpK9D+l/3zQHFLAmZ80UMg5beXnjjUkVTd0q6boIRllw28k8IWPbl6LCAmKMd7n6BelL6ZoQa7AC+eowbNDq471zjgdxCPmpII4CptRuQorXHRb3ZacOFLn1j+tPOB7eDNLwvpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=22hILCM5X9sMn9gY63YTPAbD4zPS0lb7vfJ+lyUfogw=;
 b=ZhFTqCKwFZdoOMDPBbZ/wFv1i/WL/JuuUxjD4uuOunwriXZBLJKY8xuxxbtmjf02fjsi6HDyci1vvF8YIbS5u5GxCG3ewLFbBS7XJxvVFGNQvFa+iY6j42Hr1c8a+lUhXB6UYBA8r7ErxGFDDOXn7LrpQhiDuSt2lcMskuDATIH8TqKUagULwg8v1pwOzxWT5lrOWzemY2Xmp++fwJJfWcY0nC/EV5SVEWho9YP/iiCb5OPK3Xl9xP5PK+yR9q7dt/ust3c1k7vb9kZbMstP/hJDIdj349wuLksgJ/X9vhGFzbnJxeVRx4k0BIqBDZH0DvYttHotQ7q5+VjMOibnnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=22hILCM5X9sMn9gY63YTPAbD4zPS0lb7vfJ+lyUfogw=;
 b=t0Wx9uJ+PqppaNjo8MpJS0T5rlWEF7dYLCJpYZR73zpFXccBe9wNZ7lO3JE8VFFX9hugXI4huFjdTK5vVf4uZ3sc/UOCqkd9EkxDLCLzmbJdFNSAGyvB2TWr0pgQtZ7zza9jfytIVQaUdtUYQIEw/ystZKIzdhicS+PcxayTR5s=
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com (2603:10b6:a03:3d0::5)
 by SA1PR10MB7832.namprd10.prod.outlook.com (2603:10b6:806:3a9::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.32; Wed, 3 Jul
 2024 11:57:51 +0000
Received: from SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e]) by SJ0PR10MB5613.namprd10.prod.outlook.com
 ([fe80::4239:cf6f:9caa:940e%6]) with mapi id 15.20.7741.025; Wed, 3 Jul 2024
 11:57:51 +0000
From: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, "Liam R . Howlett" <Liam.Howlett@oracle.com>,
        Vlastimil Babka <vbabka@suse.cz>, Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH 1/7] userfaultfd: move core VMA manipulation logic to mm/userfaultfd.c
Date: Wed,  3 Jul 2024 12:57:32 +0100
Message-ID: <8a1516b4c3266a35ab156841a12b3ebe9c7e2751.1720006125.git.lorenzo.stoakes@oracle.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
References: <cover.1720006125.git.lorenzo.stoakes@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0111.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c3::11) To SJ0PR10MB5613.namprd10.prod.outlook.com
 (2603:10b6:a03:3d0::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR10MB5613:EE_|SA1PR10MB7832:EE_
X-MS-Office365-Filtering-Correlation-Id: deacc99d-d1dd-4677-4377-08dc9b575d86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info: 
	=?us-ascii?Q?S/X5aizMM+LdiqhsibKH1SSXn8zxyrDvXiBZy6ZMxFxJoraXm59gNK3jjRTH?=
 =?us-ascii?Q?3COm3Cp2INkDFfpH76ZtKSDWjF6MfTnqKEgioyn609Pao1DSWPt+MY9RalW3?=
 =?us-ascii?Q?m17WJDKrQov95qWd3QtDmqwgcmwbSmkmyEORzEJjUvjrK/aI4YABIj0IdBgw?=
 =?us-ascii?Q?26NavgAVKrZwgzPCH3vKG9E/BZxoiI56zGceAtyIjDCH9qDrxPsU8c3Dh4KY?=
 =?us-ascii?Q?wxX6fI2JCs0cMKb95I8yp3saJfX5yxYE36WTrrjyqgLCDAGIF6hf9Sqkox6j?=
 =?us-ascii?Q?djkpA6ny6IAF8GziI/77vLqy+kOWfG25cG8XNc2JkrMiMXVvrxEhep7uohmF?=
 =?us-ascii?Q?bxOHGH4iG7+amN9n29X4GpJ1X0JhY1VoAAAv1iL9JXs7Rxa/ZvDcdT0FLfoR?=
 =?us-ascii?Q?KbuKP63POfEt5CZCCos6mILzxHOuy6QsmIe+JCMqR2yos1643UVsfndf/5zN?=
 =?us-ascii?Q?og9wkzDhc++S+ZXC7NP57ozzT6BN7kLx2ePLdBaZ0wpIalOH3JqlHObkGkM4?=
 =?us-ascii?Q?lmwc15F/JltxMbjMgFwlhGt0AwNUSp99O/M7AzIMZQOA8s0smP+y8aZYXLI/?=
 =?us-ascii?Q?N/6O49pv73b+ny+hwyX/eQ7oMge4rdEtTZ38lyUVL0dONfuF/miFzXVwLAJL?=
 =?us-ascii?Q?8rrByhs8uOYmXi2o4w+QBO91beRXiaToIUQ4LcQ10vJWaVyCwh8YYIy8XFP2?=
 =?us-ascii?Q?YlQHPOs2Rx1WMwCtnxY4fuZBJHMs2J6nz4x9B215vgsu9ekg/6KVuFJE77Ez?=
 =?us-ascii?Q?Md3PJRelyt2AWthOkhipienKv1BfTAN36ZzCaJQR6HJOYgMVqcKf8wXIpG6m?=
 =?us-ascii?Q?xGyh3o2GojVF+LPakXjYc6SFJWqVULWHxtupdpIxtikya6VuHnp1FuCQu0wu?=
 =?us-ascii?Q?DWY0iCIXWqPVeLTdCSelkkd/cxq5ntLc9yDL6LBjQ/AX5wVIXkmCEpaSEkio?=
 =?us-ascii?Q?q7mp3hTIac9JA2TUCne/voQBPQPPDbuaK+WnaiwGT4yHzOclZ0NuiElQqPix?=
 =?us-ascii?Q?a/VvNU78fcH1rCVoG4Ae3Y7636EMHIKsLfLSqGn4nn6yFUkk7YBXoURcnI0d?=
 =?us-ascii?Q?iBRkUyVk62SeqNC7So3rJ39rXgnTiioCPgB/6HmO2T2dUn30utp6LXjKg+sH?=
 =?us-ascii?Q?X26esoAM91ejXgxBw7dUQT720HjMwOczNH5d5GwpJ81zhtF6LPUtoc9Ue2CN?=
 =?us-ascii?Q?/mQq/U1sMtZ0WxUdqrYNI8ldVJ2Vra6rqCFC56ZQT9ZAOdMMfc0DEhcPFUK6?=
 =?us-ascii?Q?QSB5YgXbEstUrlrL9IygoEetLelWAN/gzj+Ve4GteMsII5EITC+enj48acra?=
 =?us-ascii?Q?tbuJexWjmLUsj1mwBaCyiy1MVbyC9cPwB9OuNhVPhQeLcA=3D=3D?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB5613.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?Rr99wHzPz5H6tXbXznYfSjre3RuHNj7Kf2Bzg6qrj3tn+qkVpltZt98GBVOu?=
 =?us-ascii?Q?SbzvuFjhixxO6gOngPLuzIPe+befOGbpTpFnIxam5YzwRYwr6PDzlXeOLz85?=
 =?us-ascii?Q?syOaKhbbevpzqf0Yg+XUwcq09L7fTTzJrkPQfuvuTw+/MnQBt0FtwnzWsyev?=
 =?us-ascii?Q?ZeAtpwiasfhUXoLSxxnX/tvWU7ZVeOUHDDiyuvjxBWna7PR1B1nX9ZfvZzwe?=
 =?us-ascii?Q?j9Y2JG0vBHubZckIeNUsA+InPbc3dMkhCIWjQ0Kf7YWH/VttLB/DiB5bLX4f?=
 =?us-ascii?Q?fqplpEAG8T+9JrLAFRDAA5nSo+Sg6cDNTGAliRIFqU7HOhbtCXW1Kho6+VMU?=
 =?us-ascii?Q?7VycN84jbmIvkg+QDuHQbAqsTmoyDPuByVrgbGKtvRhER+bW91FDStvUxKZ4?=
 =?us-ascii?Q?isFRAA1ppEatgbFypJIN64hlkGB5hpyxx4vzcnosfHRQu9jY935sPOpB2aww?=
 =?us-ascii?Q?ZNluZ9L0T/P7Sed894XrCLBXutZu8Fk8951Khi6A51JjlgNzmQnlZwvFqmHo?=
 =?us-ascii?Q?5baNIrpIu0Ta89o6s20lkMBKyTQWJIaH2ID2Mhy1mcl5lKRvhHJNiA48ESVs?=
 =?us-ascii?Q?70QqbsbnnNSNXAJJLI09Qgj9l0zbxfO80XA09BJnwnStiWw3elrW7fVIFjU/?=
 =?us-ascii?Q?LjqheBvAn8WTlHowKa2Zu26u8w+NjpN00sgnXDqTVqilNvyyjJ5wKXQDI+mD?=
 =?us-ascii?Q?MnzScDGwnmUgyP+cF70V1DyI8nmOhCoAulHSkTnITdk3D2mAfrsHL/hE/EON?=
 =?us-ascii?Q?dhAcKUHpwV4BD3IQNdORRXVUt5AoqMtl8vSXy9TA5NFkyrCui3sXLL7Jzwv2?=
 =?us-ascii?Q?Ex61AcAPF2lXEIHVzEY2zIDdGr7zOsS1URg6ZBTQJBWbk7L25OOfEVGgbsF+?=
 =?us-ascii?Q?Osxb7s59nwCbADWbCn5Yvth7/piFfySgD/tT/PL5uigYRy60CAfGsh8L42WX?=
 =?us-ascii?Q?r6EF8NVkvg81uydQ//7dxHB8WoaQCXkLaL9EAONuu3i93trDMOISxWkfSCV5?=
 =?us-ascii?Q?f3b1OQWXZz7GDs5DbOGVL9UTr3pwxXqMMQaXUxWyjUfHif0Bt6RhQKYJ9/Fr?=
 =?us-ascii?Q?uBVGpo4NivsEgILYxsvXsNexnfv5okj9egk6LxpggHmZ269yDHRiH5vx0PjS?=
 =?us-ascii?Q?0yS8QNIjKJHipvdw0+g53iBxRsg+t2Ri5ZPpXI5ceAhqjvMTUZ7vp5eWjhJl?=
 =?us-ascii?Q?F5uFiwGoSigG3pPdm7yHAf/zh6OxZMC6AV1sV+WeCntZyYsNhBQoBBTjgdl7?=
 =?us-ascii?Q?cQ5Ehhrmb5J5ry282NHp+0eJumArX+pIXQR9rbRPIb1ljORAUMlz8hYm9GBZ?=
 =?us-ascii?Q?QAi/AwZe341oNwkr4OihmTmjB1q2xaNBPNjqK2NcB0Bkmc1U7sNn3OQG8YSW?=
 =?us-ascii?Q?CBWry4Ljbu83q3OaHTagjM9JxeqewjQ0B+iRWSy9wHVzmS6svQJ1939bMbWD?=
 =?us-ascii?Q?tpQo1TIeBSRUGEeMSK6rhukdRYkTAV7znGL5tMBBgDfg44QKc/75/kNn4fsP?=
 =?us-ascii?Q?P3z5OVqzygCrzYWmW3OatXnfFnEvmQ/83PCQj+Uy3poQ7d/OvOZPYuTDrAn7?=
 =?us-ascii?Q?NVK/+1KspInGF4pcCk6/ZeIQ+QJN3ITQ37U60XSxiJ2PGfV/FlHykBYoRdVq?=
 =?us-ascii?Q?9g=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	qWxbyioY2QLjmgmu3VU15o8wKUMCXQLStGRFbrdngEF6cMqNCKr1xmP839iLjR+1Qm7Bv1g99S/Lb7zJDpbmEvEfiYWrex3knUyRNGVq24gxvdk0ZoSs9e7d++VCntsBTXkqyuRxK002oMIMoFmnu3bW+Df+fDD289j0kUgVEEI57Wy48mg/+9vizbqG4Z2go6P4Aejqlg8MTYwg0wpRpAvM8w/zpqxXLTdFriseRWdW8Dxfb3XRsSw5qEaRSOloFRSFUUnSkT5iQtMeJK4T2ll1BGJZ4WYgUCUaDjJ66p7opaGn25hC61OEa/wfGCDvB4d5+FLwCagoIXvEymqGTD7043lna/ul8VMvCWTlpMn5lAMy4KHKbEDF9J6BTyb3A0n4UvmStBc3syuMnUdq5aVI8TGSLzAB45QnXZN63gCYz0CFIBIllriWfp+wSV0vMV1rPV8T7uHQzIzEGKdvWe+NUUzo5FmhKDon7jgYZzB7UBDrvVhnfUsuuPjtWB4R3xDkTNzKQVgEBZTkTOBzrHvkooHdLrNlq1LpCLc0iFP6ABPAQCfEwlSv8jwQy2+QSjiNmLKAQq8rVxubILgYe/bLGoJA2Ekpi0qnDVM7N1M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: deacc99d-d1dd-4677-4377-08dc9b575d86
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB5613.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jul 2024 11:57:51.6109
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qRWBMxIV8CvWags7aoS0pk9n3AUBX/SjNzQIA4SGwFtQjM2R8IfmESLE/dKLJmNDziV3iRQ9OQdA9117+yQNQIbBY1pitVJgqZOqLK4NkU8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB7832
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-03_07,2024-07-03_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxlogscore=999 phishscore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2406180000 definitions=main-2407030087
X-Proofpoint-GUID: XhJhYS21yl49mRi6_Und3UB3TYxQ_DUW
X-Proofpoint-ORIG-GUID: XhJhYS21yl49mRi6_Und3UB3TYxQ_DUW

This patch forms part of a patch series intending to separate out VMA logic
and render it testable from userspace, which requires that core
manipulation functions be exposed in an mm/-internal header file.

In order to do this, we must abstract APIs we wish to test, in this
instance functions which ultimately invoke vma_modify().

This patch therefore moves all logic which ultimately invokes vma_modify()
to mm/userfaultfd.c, trying to transfer code at a functional granularity
where possible.

Signed-off-by: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
---
 fs/userfaultfd.c              | 160 +++-----------------------------
 include/linux/userfaultfd_k.h |  19 ++++
 mm/userfaultfd.c              | 168 ++++++++++++++++++++++++++++++++++
 3 files changed, 198 insertions(+), 149 deletions(-)

diff --git a/fs/userfaultfd.c b/fs/userfaultfd.c
index 27a3e9285fbf..b3ed7207df7e 100644
--- a/fs/userfaultfd.c
+++ b/fs/userfaultfd.c
@@ -104,21 +104,6 @@ bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma)
 	return ctx->features & UFFD_FEATURE_WP_UNPOPULATED;
 }

-static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
-				     vm_flags_t flags)
-{
-	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
-
-	vm_flags_reset(vma, flags);
-	/*
-	 * For shared mappings, we want to enable writenotify while
-	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
-	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
-	 */
-	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
-		vma_set_page_prot(vma);
-}
-
 static int userfaultfd_wake_function(wait_queue_entry_t *wq, unsigned mode,
 				     int wake_flags, void *key)
 {
@@ -615,22 +600,7 @@ static void userfaultfd_event_wait_completion(struct userfaultfd_ctx *ctx,
 	spin_unlock_irq(&ctx->event_wqh.lock);

 	if (release_new_ctx) {
-		struct vm_area_struct *vma;
-		struct mm_struct *mm = release_new_ctx->mm;
-		VMA_ITERATOR(vmi, mm, 0);
-
-		/* the various vma->vm_userfaultfd_ctx still points to it */
-		mmap_write_lock(mm);
-		for_each_vma(vmi, vma) {
-			if (vma->vm_userfaultfd_ctx.ctx == release_new_ctx) {
-				vma_start_write(vma);
-				vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-				userfaultfd_set_vm_flags(vma,
-							 vma->vm_flags & ~__VM_UFFD_FLAGS);
-			}
-		}
-		mmap_write_unlock(mm);
-
+		userfaultfd_release_new(release_new_ctx);
 		userfaultfd_ctx_put(release_new_ctx);
 	}

@@ -662,9 +632,7 @@ int dup_userfaultfd(struct vm_area_struct *vma, struct list_head *fcs)
 		return 0;

 	if (!(octx->features & UFFD_FEATURE_EVENT_FORK)) {
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 		return 0;
 	}

@@ -749,9 +717,7 @@ void mremap_userfaultfd_prep(struct vm_area_struct *vma,
 		up_write(&ctx->map_changing_lock);
 	} else {
 		/* Drop uffd context if remap feature not enabled */
-		vma_start_write(vma);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-		userfaultfd_set_vm_flags(vma, vma->vm_flags & ~__VM_UFFD_FLAGS);
+		userfaultfd_reset_ctx(vma);
 	}
 }

@@ -870,53 +836,13 @@ static int userfaultfd_release(struct inode *inode, struct file *file)
 {
 	struct userfaultfd_ctx *ctx = file->private_data;
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev;
 	/* len == 0 means wake all */
 	struct userfaultfd_wake_range range = { .len = 0, };
-	unsigned long new_flags;
-	VMA_ITERATOR(vmi, mm, 0);

 	WRITE_ONCE(ctx->released, true);

-	if (!mmget_not_zero(mm))
-		goto wakeup;
-
-	/*
-	 * Flush page faults out of all CPUs. NOTE: all page faults
-	 * must be retried without returning VM_FAULT_SIGBUS if
-	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
-	 * changes while handle_userfault released the mmap_lock. So
-	 * it's critical that released is set to true (above), before
-	 * taking the mmap_lock for writing.
-	 */
-	mmap_write_lock(mm);
-	prev = NULL;
-	for_each_vma(vmi, vma) {
-		cond_resched();
-		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
-		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
-		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
-			prev = vma;
-			continue;
-		}
-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, vma->vm_start,
-				      vma->vm_end - vma->vm_start, false);
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, vma->vm_start,
-					    vma->vm_end, new_flags,
-					    NULL_VM_UFFD_CTX);
-
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
+	userfaultfd_release_all(mm, ctx);

-		prev = vma;
-	}
-	mmap_write_unlock(mm);
-	mmput(mm);
-wakeup:
 	/*
 	 * After no new page faults can wait on this fault_*wqh, flush
 	 * the last page faults that may have been already waiting on
@@ -1293,14 +1219,14 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 				unsigned long arg)
 {
 	struct mm_struct *mm = ctx->mm;
-	struct vm_area_struct *vma, *prev, *cur;
+	struct vm_area_struct *vma, *cur;
 	int ret;
 	struct uffdio_register uffdio_register;
 	struct uffdio_register __user *user_uffdio_register;
-	unsigned long vm_flags, new_flags;
+	unsigned long vm_flags;
 	bool found;
 	bool basic_ioctls;
-	unsigned long start, end, vma_end;
+	unsigned long start, end;
 	struct vma_iterator vmi;
 	bool wp_async = userfaultfd_wp_async_ctx(ctx);

@@ -1428,57 +1354,8 @@ static int userfaultfd_register(struct userfaultfd_ctx *ctx,
 	} for_each_vma_range(vmi, cur, end);
 	BUG_ON(!found);

-	vma_iter_set(&vmi, start);
-	prev = vma_prev(&vmi);
-	if (vma->vm_start < start)
-		prev = vma;
-
-	ret = 0;
-	for_each_vma_range(vmi, vma, end) {
-		cond_resched();
-
-		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
-		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
-		       vma->vm_userfaultfd_ctx.ctx != ctx);
-		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
-
-		/*
-		 * Nothing to do: this vma is already registered into this
-		 * userfaultfd and with the right tracking mode too.
-		 */
-		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
-		    (vma->vm_flags & vm_flags) == vm_flags)
-			goto skip;
-
-		if (vma->vm_start > start)
-			start = vma->vm_start;
-		vma_end = min(end, vma->vm_end);
-
-		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags,
-					    (struct vm_userfaultfd_ctx){ctx});
-		if (IS_ERR(vma)) {
-			ret = PTR_ERR(vma);
-			break;
-		}
-
-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx.ctx = ctx;
-
-		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
-			hugetlb_unshare_all_pmds(vma);
-
-	skip:
-		prev = vma;
-		start = vma->vm_end;
-	}
+	ret = userfaultfd_register_range(ctx, vma, vm_flags, start, end,
+					 wp_async);

 out_unlock:
 	mmap_write_unlock(mm);
@@ -1519,7 +1396,6 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 	struct vm_area_struct *vma, *prev, *cur;
 	int ret;
 	struct uffdio_range uffdio_unregister;
-	unsigned long new_flags;
 	bool found;
 	unsigned long start, end, vma_end;
 	const void __user *buf = (void __user *)arg;
@@ -1622,27 +1498,13 @@ static int userfaultfd_unregister(struct userfaultfd_ctx *ctx,
 			wake_userfault(vma->vm_userfaultfd_ctx.ctx, &range);
 		}

-		/* Reset ptes for the whole vma range if wr-protected */
-		if (userfaultfd_wp(vma))
-			uffd_wp_range(vma, start, vma_end - start, false);
-
-		new_flags = vma->vm_flags & ~__VM_UFFD_FLAGS;
-		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
-					    new_flags, NULL_VM_UFFD_CTX);
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    start, vma_end);
 		if (IS_ERR(vma)) {
 			ret = PTR_ERR(vma);
 			break;
 		}

-		/*
-		 * In the vma_merge() successful mprotect-like case 8:
-		 * the next vma was merged into the current one and
-		 * the current one has not been updated yet.
-		 */
-		vma_start_write(vma);
-		userfaultfd_set_vm_flags(vma, new_flags);
-		vma->vm_userfaultfd_ctx = NULL_VM_UFFD_CTX;
-
 	skip:
 		prev = vma;
 		start = vma->vm_end;
diff --git a/include/linux/userfaultfd_k.h b/include/linux/userfaultfd_k.h
index 05d59f74fc88..6355ed5bd34b 100644
--- a/include/linux/userfaultfd_k.h
+++ b/include/linux/userfaultfd_k.h
@@ -264,6 +264,25 @@ extern void userfaultfd_unmap_complete(struct mm_struct *mm,
 extern bool userfaultfd_wp_unpopulated(struct vm_area_struct *vma);
 extern bool userfaultfd_wp_async(struct vm_area_struct *vma);

+extern void userfaultfd_reset_ctx(struct vm_area_struct *vma);
+
+extern struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+						    struct vm_area_struct *prev,
+						    struct vm_area_struct *vma,
+						    unsigned long start,
+						    unsigned long end);
+
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async);
+
+extern void userfaultfd_release_new(struct userfaultfd_ctx *ctx);
+
+extern void userfaultfd_release_all(struct mm_struct *mm,
+				    struct userfaultfd_ctx *ctx);
+
 #else /* CONFIG_USERFAULTFD */

 /* mm helpers */
diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index e54e5c8907fa..3b7715ecf292 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -1760,3 +1760,171 @@ ssize_t move_pages(struct userfaultfd_ctx *ctx, unsigned long dst_start,
 	VM_WARN_ON(!moved && !err);
 	return moved ? moved : err;
 }
+
+static void userfaultfd_set_vm_flags(struct vm_area_struct *vma,
+				     vm_flags_t flags)
+{
+	const bool uffd_wp_changed = (vma->vm_flags ^ flags) & VM_UFFD_WP;
+
+	vm_flags_reset(vma, flags);
+	/*
+	 * For shared mappings, we want to enable writenotify while
+	 * userfaultfd-wp is enabled (see vma_wants_writenotify()). We'll simply
+	 * recalculate vma->vm_page_prot whenever userfaultfd-wp changes.
+	 */
+	if ((vma->vm_flags & VM_SHARED) && uffd_wp_changed)
+		vma_set_page_prot(vma);
+}
+
+static void userfaultfd_set_ctx(struct vm_area_struct *vma,
+				struct userfaultfd_ctx *ctx,
+				unsigned long flags)
+{
+	vma_start_write(vma);
+	vma->vm_userfaultfd_ctx = (struct vm_userfaultfd_ctx){ctx};
+	userfaultfd_set_vm_flags(vma,
+				 (vma->vm_flags & ~__VM_UFFD_FLAGS) | flags);
+}
+
+void userfaultfd_reset_ctx(struct vm_area_struct *vma)
+{
+	userfaultfd_set_ctx(vma, NULL, 0);
+}
+
+struct vm_area_struct *userfaultfd_clear_vma(struct vma_iterator *vmi,
+					     struct vm_area_struct *prev,
+					     struct vm_area_struct *vma,
+					     unsigned long start,
+					     unsigned long end)
+{
+	struct vm_area_struct *ret;
+
+	/* Reset ptes for the whole vma range if wr-protected */
+	if (userfaultfd_wp(vma))
+		uffd_wp_range(vma, start, end - start, false);
+
+	ret = vma_modify_flags_uffd(vmi, prev, vma, start, end,
+				    vma->vm_flags & ~__VM_UFFD_FLAGS,
+				    NULL_VM_UFFD_CTX);
+
+	/*
+	 * In the vma_merge() successful mprotect-like case 8:
+	 * the next vma was merged into the current one and
+	 * the current one has not been updated yet.
+	 */
+	if (!IS_ERR(ret))
+		userfaultfd_reset_ctx(vma);
+
+	return ret;
+}
+
+/* Assumes mmap write lock taken, and mm_struct pinned. */
+int userfaultfd_register_range(struct userfaultfd_ctx *ctx,
+			       struct vm_area_struct *vma,
+			       unsigned long vm_flags,
+			       unsigned long start, unsigned long end,
+			       bool wp_async)
+{
+	VMA_ITERATOR(vmi, ctx->mm, start);
+	struct vm_area_struct *prev = vma_prev(&vmi);
+	unsigned long vma_end;
+	unsigned long new_flags;
+
+	if (vma->vm_start < start)
+		prev = vma;
+
+	for_each_vma_range(vmi, vma, end) {
+		cond_resched();
+
+		BUG_ON(!vma_can_userfault(vma, vm_flags, wp_async));
+		BUG_ON(vma->vm_userfaultfd_ctx.ctx &&
+		       vma->vm_userfaultfd_ctx.ctx != ctx);
+		WARN_ON(!(vma->vm_flags & VM_MAYWRITE));
+
+		/*
+		 * Nothing to do: this vma is already registered into this
+		 * userfaultfd and with the right tracking mode too.
+		 */
+		if (vma->vm_userfaultfd_ctx.ctx == ctx &&
+		    (vma->vm_flags & vm_flags) == vm_flags)
+			goto skip;
+
+		if (vma->vm_start > start)
+			start = vma->vm_start;
+		vma_end = min(end, vma->vm_end);
+
+		new_flags = (vma->vm_flags & ~__VM_UFFD_FLAGS) | vm_flags;
+		vma = vma_modify_flags_uffd(&vmi, prev, vma, start, vma_end,
+					    new_flags,
+					    (struct vm_userfaultfd_ctx){ctx});
+		if (IS_ERR(vma))
+			return PTR_ERR(vma);
+
+		/*
+		 * In the vma_merge() successful mprotect-like case 8:
+		 * the next vma was merged into the current one and
+		 * the current one has not been updated yet.
+		 */
+		userfaultfd_set_ctx(vma, ctx, vm_flags);
+
+		if (is_vm_hugetlb_page(vma) && uffd_disable_huge_pmd_share(vma))
+			hugetlb_unshare_all_pmds(vma);
+
+skip:
+		prev = vma;
+		start = vma->vm_end;
+	}
+
+	return 0;
+}
+
+void userfaultfd_release_new(struct userfaultfd_ctx *ctx)
+{
+	struct mm_struct *mm = ctx->mm;
+	struct vm_area_struct *vma;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	/* the various vma->vm_userfaultfd_ctx still points to it */
+	mmap_write_lock(mm);
+	for_each_vma(vmi, vma) {
+		if (vma->vm_userfaultfd_ctx.ctx == ctx)
+			userfaultfd_reset_ctx(vma);
+	}
+	mmap_write_unlock(mm);
+}
+
+void userfaultfd_release_all(struct mm_struct *mm,
+			     struct userfaultfd_ctx *ctx)
+{
+	struct vm_area_struct *vma, *prev;
+	VMA_ITERATOR(vmi, mm, 0);
+
+	if (!mmget_not_zero(mm))
+		return;
+
+	/*
+	 * Flush page faults out of all CPUs. NOTE: all page faults
+	 * must be retried without returning VM_FAULT_SIGBUS if
+	 * userfaultfd_ctx_get() succeeds but vma->vma_userfault_ctx
+	 * changes while handle_userfault released the mmap_lock. So
+	 * it's critical that released is set to true (above), before
+	 * taking the mmap_lock for writing.
+	 */
+	mmap_write_lock(mm);
+	prev = NULL;
+	for_each_vma(vmi, vma) {
+		cond_resched();
+		BUG_ON(!!vma->vm_userfaultfd_ctx.ctx ^
+		       !!(vma->vm_flags & __VM_UFFD_FLAGS));
+		if (vma->vm_userfaultfd_ctx.ctx != ctx) {
+			prev = vma;
+			continue;
+		}
+
+		vma = userfaultfd_clear_vma(&vmi, prev, vma,
+					    vma->vm_start, vma->vm_end);
+		prev = vma;
+	}
+	mmap_write_unlock(mm);
+	mmput(mm);
+}
--
2.45.2

