Return-Path: <linux-fsdevel+bounces-68400-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C9D12C5A455
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 23:05:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 845484E2E96
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Nov 2025 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D1D3325727;
	Thu, 13 Nov 2025 22:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JsRtRow0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="BCfLZ4p1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2625C244679;
	Thu, 13 Nov 2025 22:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763071528; cv=fail; b=KoB1SGpY3c9GXCbpTp0Cj3amEAlojcSr9/ylELX8Ghp1gpfctV9nUnZ3fq0kG5CrahcMqO3poWy55J+WCJGzMLMbZpNg0BUFMxLMVbrFTVzwdl7pM6aGcKSn/vCj6DQjLhvQ7vUSUSKyOvRaped6/ILTmZLvN0UedBut0yhEJOE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763071528; c=relaxed/simple;
	bh=Rthk3B27ebKEqcj+ETzemQ8t5K/ZbWo3VuAfA/NpRTc=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U58lU+JQBwcUIQmCdmXD05ETQc/ixqVZCt0br2D7hvqmAXrILq8O+aLG0YU9KxdjhVxry4e4+JlpyAkzwgIhmMbuRcOjsaGMla8DAbqEndsmOf/Z+adGzFJLJI8PgyOZYI07J7f8hbZsGf8sd9x59liUgn059HjK1F1IuFOqdSs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JsRtRow0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=BCfLZ4p1; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADKN2GA009527;
	Thu, 13 Nov 2025 22:05:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=CR0dLmH2Ymkntdz65qIVndhBthKYXhlXuZ3eLRScYTc=; b=
	JsRtRow0l9hCPibAfqsiTquYaCu1YL8J/SCNL1GFyLkBzBPxMNTVEztp6TOtedhI
	rGLTQ8Manuyp9Yd6s/09sPhJyuUCBM+ITc3oDKY5u0sLCoZjohDyGudcjQASUp24
	bcklxCl8mtrVTR9rNtcqQfl3HtnihAhBd+nQhZYy8QjO+dVjhkh8/4fHNEDlw+BT
	wlZt9Bkj6Oqq/pBy+fjSua/tFw3zvchKYh0M/IUAlk1GnGUF2GJZ9FAElsp+nqNu
	PF5Ol9CxJBI4Z5uhX5ta2NLtiqJFmE50Ali0u0u31CjuuHhChk0YYoe+MdXrl8bU
	vL3cmvD6wvi/Xo+lXNU32w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4acyjsaw7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 22:05:12 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ADLX8YO010897;
	Thu, 13 Nov 2025 22:05:12 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010038.outbound.protection.outlook.com [52.101.61.38])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4a9vapgngw-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Nov 2025 22:05:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YySJAizMn591PZzft5tjaxDQ3OwRcoTp5LhJLvLQUCK7iXal2xryzlU0VVaNIA2WorvBiKWWDsDY4bfLXMfWmgKOayMDw4ZY9wBIkC2iuK5jjLgv3sbdBvrXONunsxM0xhRIxC9xAJ6nxz5GU13g6zIsqvvVomjFtO9PtBzO7fTDM6XaSjEiY3ZeY91FZzQppJSt8LFleIvNtC5LqYV7a7xrvLV6IMhrl8urb/Qi1KayIz9k5Bj5GpLfUXS/ZMZ8XcjRc2SjLsgAujXSdl3TPzjBwVpjKkNLCUULNP9r168+xbl5S6G2XL1smVh4NvPGqyXR4VTq6EbJxC38l1gGjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CR0dLmH2Ymkntdz65qIVndhBthKYXhlXuZ3eLRScYTc=;
 b=WLtibW7c09L3Si6TTlTwCbglJ5vKxgQL3AjbdfzEHVSktNv4uoF/JKUVJ27cACTtxsaXjW8pZ+vkGqMG1cG6R22ZN4B+YI8pHbQETLu4yRcd2PTHjTOK47SjND5bR3FAYgbSTtZ3wZVPDO9fK5S/eMs/rxv+GM51XAdxs4C85rhhLv0GtgLee7wPTv3WgMU0huy9H0h3dPocV3WHKEqak7WU2oitETH7hugXBnLA5gxnfWftED0d+BXCWAnX83vTLD+J92cA0FX1nA58wgZsQkijCyG2MA7RSJWQG+64oqL2Dir34wBHxWWWaKuNUiwxYL1JmUdbal+pPRxTjvtl/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CR0dLmH2Ymkntdz65qIVndhBthKYXhlXuZ3eLRScYTc=;
 b=BCfLZ4p1HQzYnfKwba+4/4+WbbJt3Gj9lYGKKPmHQ4h8LTWa42NSFn93/r+Nx4vjKwUtNbL0GGg0NFMduxHpfkSjz0Vt5HzbQjmFfOUTo4o+Q2U1jdTdW/Kn6Z4snJW1cCJDnzt3XnQkTEVcu+o425mEM4F0DBeiqT74259dpkk=
Received: from MW6PR10MB7639.namprd10.prod.outlook.com (2603:10b6:303:244::14)
 by SJ0PR10MB4573.namprd10.prod.outlook.com (2603:10b6:a03:2ac::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 22:05:09 +0000
Received: from MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6]) by MW6PR10MB7639.namprd10.prod.outlook.com
 ([fe80::69ee:3509:9565:9cd6%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 22:05:09 +0000
Message-ID: <03da26c1-57b1-465f-8108-424fe6015380@oracle.com>
Date: Thu, 13 Nov 2025 14:05:06 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [Patch v2 0/2] NFSD: Fix server hang when there are multiple
 layout conflicts
From: Dai Ngo <dai.ngo@oracle.com>
To: chuck.lever@oracle.com, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251113164043.1809156-1-dai.ngo@oracle.com>
Content-Language: en-US
In-Reply-To: <20251113164043.1809156-1-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH1PEPF00013308.namprd07.prod.outlook.com
 (2603:10b6:518:1::15) To MW6PR10MB7639.namprd10.prod.outlook.com
 (2603:10b6:303:244::14)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW6PR10MB7639:EE_|SJ0PR10MB4573:EE_
X-MS-Office365-Filtering-Correlation-Id: 6660f4d5-5c98-4d9d-487c-08de2300b5ba
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?MUZTYWF5Z2dCMlBaQ2Y1ZXFLN3llR3VjYjAvS1huTzFMT3NGUWhrU3hKRnhR?=
 =?utf-8?B?WGhGckY4TlpzUTZoc2VqTEhzQitCbENKY2RnenhoZzhIVWdVQVV0R3FRMklX?=
 =?utf-8?B?aHZYMW56NWg0SVNMS2dsM0U2UzdpUmZDWHFSejk0MDdSWExhQ1J3RFk1NEhF?=
 =?utf-8?B?QzdnSzIzT25MUXFhbk9CZERTRTR6bmNVbFhWOVNzY1Rmd1dIRlUrcTUrNW9s?=
 =?utf-8?B?MlVQL2cxbmxWSm1HYlUyVmQzK3owT3NjVFI5N2dwRnZkNGxvekswNng3UzJN?=
 =?utf-8?B?cldvcVJOaVFCbXFIUUU5YlhYaXhrUCtON0hWWEpmVmgrUSs2ZmtNVzRmM1VL?=
 =?utf-8?B?czQ1UWpaazdhSVppT1p1eWJFbVo0WU5tRy9YOWh5Si9aS2dnQlpJSHpmY0hl?=
 =?utf-8?B?ck9jdjJBdTBpSGhybWFGL3lxV0wrVURUdWErTmo2Mm55Q3I5VUhQZUdWNHVy?=
 =?utf-8?B?aGlqZW0xVTNPR2RpUFdrd0U4RWJQcVFSRXFGVTVMVnBnZkQ4aG5UODlXNDFQ?=
 =?utf-8?B?MDNMdFRuS04xSVZXWGU3UGhYZmlKU2xvTGRPYXJrbjc5cC95QzFkMnIwUER0?=
 =?utf-8?B?eE9OUFUwTnBkSWJUUDM1Z0d3bTNhWmtueGRTK21JcUFhM2krSDRub2VVeXZQ?=
 =?utf-8?B?bDZOYmhGNHVFUjZTNzVGOHJIdUhXYnVUeW1yRUV0SWtqazRVNFJ4aWxzWUJ4?=
 =?utf-8?B?OWpLSjNJS1JrSUxUTko4cXpLQm9ZendsWm1sUWY1cWdHWjdBMndmRTRyRmF1?=
 =?utf-8?B?QUxROWxYdlBtMlplRjMyWEFWeThCd2F4bWh4MjlqYWlrdzRiOVNVdEdVNW1z?=
 =?utf-8?B?NFA5SjYwMkl5NS9OV2NXSC8wUmFTd0FucG94bzJKekVkc0xPQ0RWUzhVWmdX?=
 =?utf-8?B?WmlKZ0JwODFGeGhpMk1kZDFBTmNQak53WHdpL3FCb2xoNG1kK0xqUXM1ZkRi?=
 =?utf-8?B?bzh1VGtxV3VYNUhleHdSQUhYb2hLQ1VGcEs2TW1EZFB3R2g5RzZ5TlNhLzI4?=
 =?utf-8?B?M3g3c3JxUDB1d1VNd0cybE95NmxmdFU1S05iOWloT1hBN3JQMGs1QUZDMVZ1?=
 =?utf-8?B?RzN6QnFJY3M4U1E4dTF5NC9CaGFDcjBTeFJUUS8xZXd2RDRzaXA5TTNQc1Jq?=
 =?utf-8?B?YzdJQktESUZuYVRNd09pdERmaHBlZ1A0aGpYNyt5b2lseHpVTWNMaEtCTVM2?=
 =?utf-8?B?WWxCcFJ2QksyeXF6QXRlVmMvOHBSNitGZ1pSLzgxUTgwQVJSOHo2Y25QWkxu?=
 =?utf-8?B?YXlRZC9UVmN4bjIzUEh5WUd5Q2FqaTVvR3dxZnI4VWVHZmw0RzNJTEVCYVJw?=
 =?utf-8?B?UWhCV1BlL25kTHJGS09wRFZ2STkvUHNrN3VYNTZLMVliZGxYb2lCd2ZHTHh3?=
 =?utf-8?B?cXNweEludTcwZ041bnpSL3lzL3FZMW5qaFF0M3dZK0p2dG1YcjFxa0M5WitY?=
 =?utf-8?B?RVNCNk1MWVZLOTUwNTkxWnZiZXBtSFVNa1oyQTE5Q0Qxejl0Z1VHYWdjaVRW?=
 =?utf-8?B?ME4wZ0pZN3kwcmgrVG9hTDlKRWFhdTIrM2o3aGdxWEx2VFJZTnFQNXo4SGNH?=
 =?utf-8?B?MUNDL0YyU1NDL3hxOGcyNSs5U3RRc0ZESXp2YmM5U3RaRzBEaE5PdmgwL1lF?=
 =?utf-8?B?b3VOSzdKc2szZmw4YUM3STY1N3BoSUUzN1NFU3B0N29EYzRhczZJaVQybldJ?=
 =?utf-8?B?TmppU05VR0hHUUllcDk1a2JwVFZ5QUFWZzQxYU5ZL1hieUtVcytISDQ1SFI2?=
 =?utf-8?B?c2V4M1hSOEpLZENKRGdMTmNOMjJnTGl1SUhZMlM2YXVrV1BxMmRHa1luZW9Q?=
 =?utf-8?B?cTk3VDh0aFlWdk1iR1phQXNIQXpGckJPdDQ2M2lBVXJlWnZqY0xsNkxncFlP?=
 =?utf-8?B?aUhmZUQ0S1NHZEpsOTV3VzRibTFmOGNNTTR0ZzFndWxYSkljZ05JYk9nQ25W?=
 =?utf-8?B?UTVwQUpnaGpEaFFPb0ZYNHNSOXpyM0hVNzFSbmhXQWRKZURhQVRSRWMrVlhW?=
 =?utf-8?Q?iQcvfZFNYJxcKJk+wvXHWhakiJtp6s=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW6PR10MB7639.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?aXZzNmx1bVZ2bDU5Q3NiZVpQM3phZnFkNE5IWVkwWG02eDFvdStiR3NZZXNK?=
 =?utf-8?B?emJHT1NneUdubTNQeFB4VThqM21sTlhTaWcwNzcwZGs3Qi9FZWMyUFhsTm02?=
 =?utf-8?B?bmdNOWM5ZW1lZ3RoSjdaUmhxb2ViNG40SzhaNmRrd0o5MVRSUWFiTG00UGpL?=
 =?utf-8?B?ZDVNL3RKWnJ0SDJzUUxmNmpEbC93RXlpS2tWd1hrcWJURWJycmdML2o1S0t5?=
 =?utf-8?B?cDhHeFc3MHBEUkUzcHNoTTZMUjh5TmlTK3dMUE44WDdXU0NwaEFFYUhwdzlZ?=
 =?utf-8?B?Z3k4UVZQSUh3Z0pMSWxsUG1HV1RKODNzazgrY052UUNVcFpzQmlCUEpXMENQ?=
 =?utf-8?B?elFOR1FkWlRPMVdQK3RBTVB2WWVGUFZIT3Y0SEsxUk5pZitMS0lDWExYdExw?=
 =?utf-8?B?NGJMTzdHNnVBd3dkQjBhVWE5WjRzNXkvRXVGaTRYZFJRakx0aUVvclJlN2d5?=
 =?utf-8?B?OE1MckdtT0lVa21LMmVQb1h3TVk0YXhJblV0ZFFZSXlhcHFMc3FBd080enkw?=
 =?utf-8?B?YzlXOC9QcFZlNVRIdmxUbVB0bVUrSnRRRGFMQzNSekF0Sld0aHV3N3lOQWhH?=
 =?utf-8?B?RjVITWJlaUJINHlSYmUwbzJDUTlzdjM3bkowR2ZPWjIzNFlJL05nZ1ZuaGtt?=
 =?utf-8?B?Z0xyeURuVUFjekVlanQwVWhQclJ6N2RwbnR6MEdyYWRURm53cG04N3M5MFhV?=
 =?utf-8?B?c3RkVXFveTBwL29hYURPVDloc1EvZk93aFRxT3JFSVpHcXk5NFZMNXhTOGd2?=
 =?utf-8?B?WFovZndtQjdRTTQySTE3ZHJ2cWdQanFURXhYR012WUtseE10V2ovQllnQlJs?=
 =?utf-8?B?aDVIQ2VJajNDVk1IZWd1SEx5UjQ5MVVWbDdTOEh5VGlpanVsYzBpYnhjRWdN?=
 =?utf-8?B?bmxyYTN1cWdMQTY0ZUpsQU1PTzU0SmJ5UlpIcEVOM1BqQ1R4VkxoUnl0OTND?=
 =?utf-8?B?Q1d4bUdiK2VrTUVnSzM2Wk12MHRodnlBTDRZTC9JVVJXU2hFWU9NRzlmQUZK?=
 =?utf-8?B?SzBuN09GVTl6a3g5c2RpS3VmSWg4T1V6aDB1SjRlblVxSk8vQ0FsZFJqZ2ht?=
 =?utf-8?B?MnF3ZVVaaUcwZklZYnRzd2NBYTJHOFZDMlJPb2hGZ2lpTkRldmRZTzJWTHQv?=
 =?utf-8?B?b1I0ckhVdmk5M1R6VXFQaVV4K3diNTVxYklnTkJvSm5DNGZkbDM0ejQ4WXVx?=
 =?utf-8?B?YitZbWl5TTAvTXphSitRR1N4eitWU0JsMTY3R3BqQzdSSjdCWklVenBsOWdh?=
 =?utf-8?B?cU1XejZHNDNpdVNrREF3Zzk3MW56WUk4U3N3YlJLRGJmRzVTdjByMks0Rm42?=
 =?utf-8?B?Q3I0Z2t0dENUQ0tBdzVPQjRnVHJkR0hWNTZHeTg3cTBBaUdvWEk4T2dCTzBs?=
 =?utf-8?B?emNHL3BIREtyRzdQWFRFUHF2RVgyWlBkZlN3ZGIyV3JhQTdWNm9QcTNIL0Y2?=
 =?utf-8?B?eTNVWHJHVTJXUW44dHdMVEJDUkRvcEJTbmE1VTlDUVo2V2w3M0t6ejVYMXNz?=
 =?utf-8?B?NG9jNy9kWmNrb1p1azlhb1p5S3Z6YVAyQ0tqMWhMeFl3anpxTEpvTGhlODIz?=
 =?utf-8?B?dldKZ2l6YlZYTmw0L09INVRtSHZvdDFybjdqSmw3ZTV0b2FSdExmei9CSFVW?=
 =?utf-8?B?a3B6c2tHNlNOZFViVklQcHhkUko3Z3lUTDVTa2w0UW04WlJZc0JaUmd3K2lY?=
 =?utf-8?B?MXZ2dlgxZnBqWE0xTTlLeGNrT3dPclpxbHhZNnEyMFMwUitIS0xzTGtTVlN0?=
 =?utf-8?B?QVg1aExJSDRhY3phbHA0MkhqWGhTV3ZJR2V6aFIwMDR0Y3FaMXlBMU1NNlFZ?=
 =?utf-8?B?S2F1SzEzMEs1cTh0c21yYjU5Tno3Y09jUHpyaEgvZ2Z2eXpVVkd4eDVrQlFr?=
 =?utf-8?B?Z01zdnMwMWxrT0F6TmxyeHYwSUFkUFdzVWJXK2lQTXF4OUV4L2Y1NlhaaGRP?=
 =?utf-8?B?dWQvZ0xycXJRL1VIQXI1dlI5bTJhQmhYQ3hpeUxPRHkyY3ZHRnVQT0txSlpW?=
 =?utf-8?B?UHZIejZRd01sOUUrK0RzNHpHRUwrTzdhRVh4VnFYc2pUU2o3OU9qUllIMUpq?=
 =?utf-8?B?WUVFbnpmTVpKUGFrNGh2cFZCVUp3elYyMFVkUmllZHpOYkJzTWNsVlhjYU1r?=
 =?utf-8?Q?c/WHUQBjO2vKdDRbUtb4MG/gL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	n4TLNfbfdUEUx056b4TCF0WC/g8k0K+RYuuNb5JGBogXXiiLeSuOsTGDpEnqJFJ+4TIhXl5bPm485EyhiGSd9qYacxpMQ6CF0a1+7UHGcUdLlGcKjPUPMVa2b+qONMg/tGuuUq21yCU3PkfteN8Mbi5WjI63euPJsyI+E3TloTAUvuykHL97Tm79RimuS2k+VhWZRhxI4B/iLGeRGFjksVTxMY48UyQNyNGLlZZnUpvkzRujVAMjImp/HUCmuZTqQS9QKTAs6zJswPfkn6gEdftol80cKlrx4qv6aUWYeZgmHICxJH5meyBWQZxGroClrV/GkdxYC7gQ1kuFVJkPEOdVwIRkcYVoPybW7kPr32sCe0ftVmvkAifnH+0Mak94G5pFxogpVKBipJiy2mapDfEZlskZA5SXEEKOdwpK1uhRddqSc0qN9npKgmW5l7NI0ZXjUbOHaOolnthocJ8+3Ia1gcDkwqK/QNKoBkiIW3s+K4Wtar5PPSGX9uVzirQ8fkCD+YJpZWThiZXuCGcXqqJOMseGp7xK/S12JQXbCH0nY4ZjG4eI/o+kd9gUm0qZdtXX2x7i0EFq+Eb1wVfDXDhmPx+rF5w4k3U0Gv3Jj2k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6660f4d5-5c98-4d9d-487c-08de2300b5ba
X-MS-Exchange-CrossTenant-AuthSource: MW6PR10MB7639.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 22:05:09.1085
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UNYAcBS3QwDYN4FWVHyulsV3LHUtk4hFj4neMOM9l6sWkCyV6amL1GvC/nZ0Cw8EQ3ik4bLJ6zaS3hMaqlA68w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4573
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-13_06,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0 mlxscore=0
 phishscore=0 mlxlogscore=999 spamscore=0 bulkscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511130173
X-Proofpoint-GUID: nKlD0xXazBsd2f_D2LekQvOu3f1Vv6SO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTEyMDE0OSBTYWx0ZWRfXxTBZmlEIFdCc
 w6TWyV341pR1cFHcOa+yKiazag48hTLYRqm4aCa/XP0yIDX0yS4OI7QH8R4Q6fZ/nlsxIx0A9wx
 FdBK7WFdLwNWkXmP6TGrCDGFEhsozIFNEw+xUNRFLJ3aZHaH5flDhLxng95I8Qt3gtu78yznTmG
 +09dpEyKNGF5zT+A0xGktuzGlEqphGVBp/llzyrv+ZKZJ8s+BJtlj0H33SdvTw4h7aC6zqtVVM2
 qTkn1YcUWZXesbqsdxgm0i0I66Ba+NGwUNOZKCSCYrL9nuTIVDqeusIzhJfiBPz0tZNT3zY0JhJ
 fEmRgyV+/XZYMTV6AzTRfutdfTW0dbWIxxrIlgyDTJ4RzqB+xeaLOq0BKHYpe7Swc/CmZxcMcJG
 XF1IYxF7BWTKG2K/N0LKBd4Q8JXoDq5ZfajglgVc/OR/YVjheuA=
X-Proofpoint-ORIG-GUID: nKlD0xXazBsd2f_D2LekQvOu3f1Vv6SO
X-Authority-Analysis: v=2.4 cv=HLzO14tv c=1 sm=1 tr=0 ts=69165619 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=L3MgVh_lYD9YF1JyEg4A:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12099

I will resend v2 with some minor changes.

-Dai

On 11/13/25 8:39 AM, Dai Ngo wrote:
> When a layout conflict triggers a call to __break_lease, the function
> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
> its loop, waiting indefinitely for the conflicting file lease to be
> released.
>
> If the number of lease conflicts matches the number of NFSD threads (which
> defaults to 8), all available NFSD threads become occupied. onsequently,
> there are no threads left to handle incoming requests or callback replies,
> leading to a total hang of the NFSD server.
>
> This issue is reliably reproducible by running the Git test suite on a
> configuration using the SCSI layout.
>
> This patchset fixes this problem by introducing the new lm_breaker_timedout
> operation to lease_manager_operations and enforcing timeout for layout
> lease break.
>
> V2:
> . replace int with u32 for ls_layout_type in nfsd_layout_breaker_timedout.
>
> . add mechanism to ensure threads wait in __break_lease for layout conflict
>    must wait until one of the waiting threads done with the fencing operation
>    before these threads can continue.
>
>   Documentation/filesystems/locking.rst |  2 ++
>   fs/locks.c                            | 30 ++++++++++++++++++++++++++----
>   fs/nfsd/nfs4layouts.c                 | 25 +++++++++++++++++++++----
>   include/linux/filelock.h              |  4 ++++
>   4 files changed, 53 insertions(+), 8 deletions(-)
>
>

