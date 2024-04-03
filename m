Return-Path: <linux-fsdevel+bounces-15954-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85770896258
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 04:11:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 39CDB28A7AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Apr 2024 02:11:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51AE918039;
	Wed,  3 Apr 2024 02:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QFOP6VVz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="y8BlufR1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 128401798C;
	Wed,  3 Apr 2024 02:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712110282; cv=fail; b=ASyV1NZmMt01K5eFQTkzojuXHf8tAmG/He12SHWf6a9sRVPuSA6U9sNupI5K3zu7BhkNQnTlMyZqdf09t7ncyiu5LSJIBE3dO7eMHYX7uDSH7+UdR7q7K/vZF+fetdmZ+WDG8y8AY7cAoyM98SCv4fJxsMcKtktcAwwIV8d1R6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712110282; c=relaxed/simple;
	bh=yRiROTMxz6+ABajgWdyx8NBYlG+/OQymvj67O8r/9nM=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=aSplnr/JLspe8oIEg7p/idOLTncmFM32dQbsBQs+eWAFArA36YOpsrS5zIu0Ix9mQ4/U3Cb8paF470SOJ7LI5nk9NIzzMXd0quHq0eH7KyW/nsJYmrWBxLYzxJpjbKiiluankIgxNQt3wgywxOSIFaYNUOHN8utwvgF+BEwJUp0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QFOP6VVz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=y8BlufR1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432Liv46020055;
	Wed, 3 Apr 2024 02:10:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : in-reply-to : message-id : references : date : content-type :
 mime-version; s=corp-2023-11-20;
 bh=ZyyT7+TGiXE1NVaKyau+kCU4zqWkNj1aBmsI+6hSSjg=;
 b=QFOP6VVzYa7VmYVBexT1zYHIUrrvaEmBgkVkI4xhzJQetGHl1HZvUpICBT+B6u6jZ56P
 2SSasugaf2+QpLZQEzDOjPD2o2Aq1wdYuQwkFaP3gaYfYcJSoI2onu6Mi3/44JvvsaqV
 cLahqh0J3cU1m6+fjf8l1ri3d8mGRR7pbtDOISFLXGWO1aMpXbvWMT7YvxLc2Cj78oQY
 2azx9Du6wRI+brYLcBVebMeLUTDqbMgIKKV/GttVfpNuifM+c8Cm3X7s3p4w5dmiuVra
 Jd70nCiXL63iRqx1+Mw53UwzJPv3B6hbrRJ528ZEkqNsJIgu8uhqvFcfoUrTbbR8pCy0 4A== 
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3x7tb9v4sv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 02:10:58 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 4330hlUR007262;
	Wed, 3 Apr 2024 02:10:57 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3x6967vta6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 03 Apr 2024 02:10:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MFLIMDxSg7XT33NwPRXH5F4dbpvFIykKT9l6/liFUeLV30u+csNc0X9FiCI0mIUKHYUBHiXSfIDev69xgRCQ/OtbW7PBGL7oCBvZ2hwW5q1CPNuaZ3nVEJab7MAPoSe9lkIPy6Ek668fxYOoeuzTq/o1M81kZ7JwDLnG+ld6eZCBvDYtpoyQySN/qnUEnBHbdtnNk0AVgmoIZVLH56EJJhehTWRjzQ+bLJBzBJdOYfvOSV59tDOngvAflewJFLVdRmgMj2OQho8RJq15iBHbczrtQjbt9nJCrQHpM/xf7dayOdfAdeQscbhg5VLYc8mWKqX/I4U6/DsnVfJiUyvYhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZyyT7+TGiXE1NVaKyau+kCU4zqWkNj1aBmsI+6hSSjg=;
 b=I8NaofkeTmnBH4lTLepx3PcHeVhvZdNNxroS/KcDzm/rJl4lnj6TfMq+/k3IaMFj/AsRBAypGKzOzaY91Z/x/VycgB6Ki8BeeKIUmI0Pfy601CSHsw8M2PNK9gBnOw5qkYhU63ABI7OaQvzzHth5/KhgBdccQzsigreMR+U8n2YsWFAOlKgyorUSCtAV0d+4u/ME1I1nHrRAQjKlqPOvZ2/6i+dpuChKOiS+KxTk2lsZ7wEj0+ql7jSs2b94B00MzJOIO1hMeIhvWzqzwAAkhBassa8lPgaQsy8LOvb3GtFzrJ9QONm1ZaZA/EtPsTa9lr8Fnju/MiixlWbaDS+qoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZyyT7+TGiXE1NVaKyau+kCU4zqWkNj1aBmsI+6hSSjg=;
 b=y8BlufR1HIE6/ZC4i+y/se8cGEz9i4j/4BC7i5ZVxX8recGEzWjcUPWErGHPlO5Lpo2399WlROj+joorE6ESC4HwvV4w9OR0YcfnZ9ltccFBxIdy3+iWl1yXUkuNyXsidnKV+buYiPvhA8Gm+SDiZ/HzrT4jGDyDd5Dh6Qwamn4=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by SJ0PR10MB6422.namprd10.prod.outlook.com (2603:10b6:a03:44c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 02:10:54 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::7856:8db7:c1f6:fc59%4]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 02:10:54 +0000
To: Kanchan Joshi <joshi.k@samsung.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>,
        "axboe@kernel.dk"
 <axboe@kernel.dk>, josef@toxicpanda.com,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Linux FS
 Devel <linux-fsdevel@vger.kernel.org>,
        "kbusch@kernel.org"
 <kbusch@kernel.org>,
        lsf-pc@lists.linux-foundation.org, Christoph
 Hellwig <hch@lst.de>
Subject: Re: [Lsf-pc] [LSF/MM/BPF ATTEND][LSF/MM/BPF TOPIC]
 Meta/Integrity/PI improvements
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <e6ec5771-5377-fcb4-7fb4-0858f8f1f0ac@samsung.com> (Kanchan
	Joshi's message of "Fri, 29 Mar 2024 17:05:32 +0530")
Organization: Oracle Corporation
Message-ID: <yq1ttkjxl7y.fsf@ca-mkp.ca.oracle.com>
References: <CGME20240222193304epcas5p318426c5267ee520e6b5710164c533b7d@epcas5p3.samsung.com>
	<aca1e970-9785-5ff4-807b-9f892af71741@samsung.com>
	<yq14jdu7t2u.fsf@ca-mkp.ca.oracle.com>
	<c196e634-7081-9d90-620c-002d3ff15dfc@samsung.com>
	<yq1sf0b4359.fsf@ca-mkp.ca.oracle.com>
	<e6ec5771-5377-fcb4-7fb4-0858f8f1f0ac@samsung.com>
Date: Tue, 02 Apr 2024 22:10:50 -0400
Content-Type: text/plain
X-ClientProxiedBy: LO2P265CA0053.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:60::17) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR10MB4759:EE_|SJ0PR10MB6422:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	itEBDr9CLi9eUMRauWmxrFW0pd/WE/Ys4MRGTrjRLnIf1Q8+TLn3xNaj55YQV5SfdB4ytFlJE0rzy1VCIPVFnHS1TMahT7T7C2Y8KZUAK9EDyPVT5zfOl5MK0Nv6Mdld3JIJH3E8LDNPVXSwuFnP7TKZkgA9AovGcv0VDNJZ7Z/FF/LuajcVCcYYsY0H2+lAv5umQw+/6Frlt3d9OaKABakzef9NOI6sTWOVkSrrtw4OR2J3rNluugzIaZ3wA7LaC5tP7gKUwv2Uofz1Wl2zWYKbgJ7wTClWMBNVrOE+dpD0GIEWO6a2s8PR+5YxwifFxwPaDUvG61CAZL6qs5UtkGqX+P4zXugSDJxR+9VjshLnk3O4EP2iFs0ScNsWdKcEtKhcndCS9xA2+Rwxs7slPO/vAATjfVnUHCDk7EqlhKcYvBJosUPRB8WumhH9cRnNEfoLDHIU5X1bN7wXOjv00R97W5ndDUoMMV39nOu0kBauS9DUGFPJVBQZFryBPbMcXZ6QsLrwX9nBuCNJJCce+Pmc352QY05s/UyN5yjTMZfie+r9rsFM/OqnGkUhg4I8h9YkXC/ccDE2a3aeE3gtObSKjmiIgLlBlAXdATlal3X6AQGEh8VFLjHhrIminMLFlmKyWY84JTu6GmSQ5bIZd0uaWKWZ/HVW7F+FZ/HIj3A=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?us-ascii?Q?XC5FKvVPWgonCdUHFzhHOSNT5dLGsLzRXX6bYIKXs4uQjILooEYU5J1e9O1O?=
 =?us-ascii?Q?MXXs+r6bI1RsT+g5rf3R5zDGHwKt/RB+OYleCDVa8ED114YMiLxUBek1lxoT?=
 =?us-ascii?Q?wbFSibFjIXR1voZcNleWac48nfJzBG4SrLrrItcSQQuTmunr9Qwx7zgrsDa1?=
 =?us-ascii?Q?WyjsKDcauroygSH4mI3JqZmY39ZY84pMaApjsuO5/WprR1MiCMaNpYPDXKXa?=
 =?us-ascii?Q?3vnhy/bG59XfykRmNRC/8xsUUSrdKhl1xYyMc4ffJrH1iZEQ/mfTXljGKIOE?=
 =?us-ascii?Q?6y+PDtyr8558vrJ9VCZVs/LRKYb8cRvmGtJR3LUCVpVIcra+gkYdFxI/xt+C?=
 =?us-ascii?Q?wkE73XTVDF3XkiuTitktOfKDAyQGvWQmuO9LhOmJrR90w54zKlkTpkgww1nj?=
 =?us-ascii?Q?VffjkXAaciYi9uRCCI22NAjLgk5gQ7ju4Xr/7b6nsTgS+RVnf///x87jOmNJ?=
 =?us-ascii?Q?G1yXO9EPHayNZPrqgGY+BwdpDuLXL4WOmSwT+W67tKj/9qu4bypJW5S+aQPG?=
 =?us-ascii?Q?NglfhcYAh+w4Cnw3OaWFkdbliXRd6f9wszkLbqOyuoUSOnl0soGKJ6fR7Lfk?=
 =?us-ascii?Q?16Rtguwl+L/cxH72xebBqjpCJ77ip0ygCh7LR1aGSDZpfuVKXiDg/6+CI6fs?=
 =?us-ascii?Q?Bl10E+gNLG400V5zY694boPH51ft3jy1p2F5NveajbGzN9ryQUtddavrxOxp?=
 =?us-ascii?Q?LGIaAcvGnil9OUgR2azvmc5+vZ4yyLNRioBP1jMtwAFBC/QIwE+VzBaVWJvl?=
 =?us-ascii?Q?54UxAGCAhlJIIKoljgvSZcOewxOZXpQ27u2rPiMVJSlIaPUGF8uiPhsRN/dc?=
 =?us-ascii?Q?ka9ymuKWGsRlNnPuTdLNH85711/ltybnIJRkqIH1cPV4yOBDGPj2Rk+XKhIm?=
 =?us-ascii?Q?PnaqbSvbaGpL/A7BJptdeMGgH5exGOnchlnYqI79pKC8oLGvCx958pcGF/nc?=
 =?us-ascii?Q?j1Gr0sfBe/oHfi61IUCw++ikhzdCUtZOMWHYyLxCWji51iIEqyFq5rkjmKZt?=
 =?us-ascii?Q?b/v0EmLnKHN6lj3/62PMZSOLUxIIRF9xkB+QJRwRW9UORVMGJLLFu/+g+kEF?=
 =?us-ascii?Q?NLMmwMgVtb3I8K8nkgIFA0rAgdHTX0M4EwrmkFLTrWeb5JKesP9EFXu/hXfY?=
 =?us-ascii?Q?JJ9jn49TJ/lxjcAdCzR6Wf37GXK8nOosybR6xnZqOGaM2h2QUMBwtlsHM5xs?=
 =?us-ascii?Q?jnqOy4TNXSxoN1AKNCr0E2PI8J3Jfiugx6AD0fyAClSoCgxEd4fYk+zmvNpF?=
 =?us-ascii?Q?2m2T8jSdDCgntK3GXTITQVKbHFiIzoLPxy92GSHBoMPMJSrQPRD2AvOVtAo5?=
 =?us-ascii?Q?YDeVzgzV+tOt3LTgxD4sbPjaVTG/LL3vTjPVNirjgcLm+iYOMKRoNFWY7MQp?=
 =?us-ascii?Q?w3gBE52KrkAbG/6dhgsKa8jpO82ntMxwqw/uHyOR0IUR9mFzrVDcsKB7+sK8?=
 =?us-ascii?Q?fn3eWBWYNwzjMEjWfVDlo1VGWxutPddGBgkR50H8W5SVCKozfkjVN7kVldcI?=
 =?us-ascii?Q?oZte3MLfKyk/UTTKECVfw+w/8abncPyqEiuBJoWZbHborwllxvv7dqQ2txix?=
 =?us-ascii?Q?ula+KXP+TbvX7DCs+wEte+KGiCYvt+Q+r0e42LaWTageK9HkG0TWc8Rg1v8o?=
 =?us-ascii?Q?OA=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	+T5W66T9PaZ5WoI3fbO5wFwY/b/K79eTrLa2xmxc4d62vvcxlrQL7HiEzzDXKIYjmbRg0DCoFBCIrPaHNMaBuYUC04hgh9iLbB04/A73YsTVUhPVyjx8TTXGDdVr16O31tlPEVfeHRJaMvYS3is2H8bcoukupScyB8UaUaawPKEOJRV8nWCaYd/z56b4R/vO+D34BJJYMqirMGu8b1pYqwGIDVffmbtW8jMbTI5LgEzXDwhp3RiNaMBbKvYov3GKmwX6cC4Z8ewSCcUvVHTU1GIIyzsK/IXf4cyFk0nzUsL3slBqS7tU3hzX+xdRBPr5EYDSED9f5VcsBufPeGpY3tgXQiE8Ze0sJ3sEc3vDlgf/pF2KyzDXJI42yArK+cMFZPrBQZhQkWeO3eXSgM45S6nTCmWBlXMlqR/oqbnvmVCtbvKVcg41anlOFaaLA8ex6K/okdJYmXZ0V2D2lQgNwmO6gj9IlYmvqNti7sIK5inaheVgjctVrmOsPbJ8L0bP9RD/neN82sLOvCkCsZz40zgiHdFHqAgRqcL7VvOKQOFjCnXzGQB2UjLVfG4tN7ejUSFk7xoF+fn3vQPNM+c2XU7ztDjdpZETIZYzzPNQrP4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 27e75bf1-bec3-48f9-9f52-08dc53834ad3
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Apr 2024 02:10:54.3443
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oeVG6aGUab1umc2X5MQk4xWVo2drNYMgzn5Hynuwq4jtHkJ0uUd1N8k7UPpail89Cqds9DXPzL0qwe6xBlH1yYtUEyKarqXIzHVSmj+KcTo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6422
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_01,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030015
X-Proofpoint-GUID: zaw6JwpJ_f8e3bnI6QiGcf8cyGMy9tqX
X-Proofpoint-ORIG-GUID: zaw6JwpJ_f8e3bnI6QiGcf8cyGMy9tqX


Kanchan,

> Just to be clear, I was thinking of three new flags that userspace can
> pass: RWF_CHK_GUARD, RWF_CHK_APPTAG, RWF_CHK_REFTAG. And corresponding
> bip flags will need to be introduced (I don't see anything existing).
> Driver will see those and convert to protocol specific flags. Does
> this match with you what you have in mind.

See bip_flags in bio.h. We currently can't pick which tag to check or
not check because RDPROTECT/WRPROTECT in SCSI are a bit of a mess.
However, we do have separate flags to disabling checking at HBA and disk
level. That distinction doesn't really apply for NVMe but we do need it
for SCSI.

>>> Right. This can work for the case when host does not need to pass
>>> the buffer (meta-size is equal to pi-size). But when meta-size is
>>> greater than pi-size, the meta-buffer needs to be allocated. Some
>>> changes are required so that Block-integrity does that allocation,
>>> without having to do read_verify/write_generate.

The block layer should not allocate or mess with the bip when the
metadata originates in userland.

-- 
Martin K. Petersen	Oracle Linux Engineering

