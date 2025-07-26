Return-Path: <linux-fsdevel+bounces-56088-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C11FB12BF2
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 20:49:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C4E3B17D010
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Jul 2025 18:49:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12307288CAF;
	Sat, 26 Jul 2025 18:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LJ+pqNsJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YXp4hKRk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45EF1C4A2D;
	Sat, 26 Jul 2025 18:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753555757; cv=fail; b=awn/ShX1PeZIFtumiQT2eDQdHpqtTvGBdxV4p82bxWIavT0OTUj9gf2tofB4NXocYovuXf0OfwSlDmjdweOPQb4jTO9jhVX8gJjrrJscC9mLkSfx6D5Y22teHQvkh8/nCL0WMx1n+HQvlX9YUOH1XVVt9ATDuXZHMPM2RguH6JU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753555757; c=relaxed/simple;
	bh=BLjPN62vXrqLF4rwNiZ5G/SDCZncfYBcMbpU6e+aSCQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=RW/LLbwM7FiZGm8oyyeAiQC8LtCkEljmjI7358ActV06BWfRpPvfGG0Az4aWlvYQVShg6wqXpVyVRUrVm/i9cnRi173meSETxI2oMl35CzZRmbnNMC066J2CnHA2+4gILTlkIlVsZry/meTf/BLBeGkUPZZqW/SfqqdzgcWBzq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LJ+pqNsJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YXp4hKRk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56QEa0eV002387;
	Sat, 26 Jul 2025 18:48:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=9x7Nsg7QYTNKFNBxk6N76CkbGMHFvdGGS/SVitNOHAk=; b=
	LJ+pqNsJFK7Y3NJAe1tEtwgj3sxjfVZr3jO0zLueqkSZ+TedXlk+250M6mg0yWOU
	btARmCnD+pG3yguc3T/akhuJOKs8RqtK+9t444gX/89Kb9q/i8cSm5X7wP9rFjwA
	s8ZyQfYNPekKM96zWx5Wxq+MdLPd+7foySVj3VqYtLhSgpPI7/H1L/cRonnreXIE
	g+HxQ+7lUtHsXwXBxtXJ/v3DDFso6hXVG3CRKDGwObbxGETJXDyysmDpyD3geFG4
	BwptJqKf1Y8OpqDKWu9JBLUpc9uyTrkLhYQ/GKFqN45BkGKuuiacUqXlFe9tUMpY
	bQoFu2o46iD9S0YqWhpDOw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q5wgttq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 18:48:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56QHMC8X020447;
	Sat, 26 Jul 2025 18:48:57 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12on2072.outbound.protection.outlook.com [40.107.243.72])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfdeacw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 26 Jul 2025 18:48:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K3onzmZcPenZG7D3f7ykyXZ662IfcU4SF5Dat6K0XNSMZ5cpsH8D4vwoTQT9HcF3VD2K9WxIkyI6tPeSZsvSR1UfrEplUAA6+kCe6OleXum5+HIQvb1o5PAYPZUu5Ay3IeXrnaGzJlIR6DaTliuFbXtzaEJNpv4zQ1DPIPylJMD8CyAsk95Ul/F75kf2nfr8SulfsN0AchNHcpFbwKJwC23xGjAzD+fVclasOeOHFlJxuuuFGSXPVW/3wee/nuEwMpIi02yl4B2kdcG4nrqfP4FHnHW4Q9iv/ICFoEnfJHiWogKDSQ4AuJkuVySc0uD8wlUhYxR8trHDchxDu3GCvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9x7Nsg7QYTNKFNBxk6N76CkbGMHFvdGGS/SVitNOHAk=;
 b=vQhXVcarZV1J1R92nbKRCOVRAacFCgMLG8syhkWP5qLkVVvxzuSisIXove5aGNjd4ojG0hy6GrJJeOzL5vcZKaUfgHE6TgwBXBXodPHcQsht6WvzZwg23bziuxc2OG4OfFT424q5qHLvbT9ylNpTqp2pdJXDlcu125djWjTxOUivm3CKEK+TSfvDEX7rHj5AJ5IP4nBAx3eHSz8qz9i+JTzR5dSQgQrIxfrPDqFVLIIfldaAKJndLDMndGUJDpXZNkm+22gLlINxQQI8jNqoABNAy6duWsoVpmnKDJJEt0GDAtEdQMWRPMmpDgrU+oZtyRiZ/5v1jy0PkcPK5F7Gdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9x7Nsg7QYTNKFNBxk6N76CkbGMHFvdGGS/SVitNOHAk=;
 b=YXp4hKRkHn/IJW0RgJJmDfAz4Uq3Vaiwa0mf9f86kVL9M3A6rvb1kzeEXxhRFbu0YoOX8mguoY3BMfEoxhk+fiJBIk3oCqlwUYOPf6A8/6F8YezGaQQH7vE6ONQD/6DWwe9nHhG6hUpa7vn3wSq3HTBdto5agwdaRtkgGhD9F8Y=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB7539.namprd10.prod.outlook.com (2603:10b6:208:448::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.25; Sat, 26 Jul
 2025 18:48:54 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%5]) with mapi id 15.20.8964.024; Sat, 26 Jul 2025
 18:48:54 +0000
Message-ID: <5f877de4-347c-484c-814f-33c08f1a5189@oracle.com>
Date: Sat, 26 Jul 2025 14:48:52 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/7] nfsd: use ATTR_CTIME_SET for delegated ctime
 updates
To: Jeff Layton <jlayton@kernel.org>,
        Alexander Viro
 <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        NeilBrown <neil@brown.name>, Olga Kornievskaia <okorniev@redhat.com>,
        Dai Ngo <Dai.Ngo@oracle.com>, Tom Talpey <tom@talpey.com>
Cc: Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-nfs@vger.kernel.org
References: <20250726-nfsd-testing-v2-0-f45923db2fbb@kernel.org>
 <20250726-nfsd-testing-v2-3-f45923db2fbb@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250726-nfsd-testing-v2-3-f45923db2fbb@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR05CA0033.namprd05.prod.outlook.com (2603:10b6:610::46)
 To BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB7539:EE_
X-MS-Office365-Filtering-Correlation-Id: 68692e20-2e70-423a-d8ec-08ddcc75123e
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?QzFzWEMwQjBLaFp5QytRWXdaRlFOalNvS3JZbU5wOU12eHlRZWhnQldTZC9I?=
 =?utf-8?B?dDFLWFh1MUNsamFQa21BUzVDb29vaTRLeVkxenlRRDZ1YnFMNUZhaXB6NS9v?=
 =?utf-8?B?MEdQVG1ZbFFQdUszK0g2d2tYQzV2clFhYlhoRTk1Y1ZkVHdQSVI2WnpHYlpO?=
 =?utf-8?B?cVBVWXFRV0RveWQyQWx5anJuOTh6a0RjYnBrR0NBdFRHVnh6dC9YdEx2NUds?=
 =?utf-8?B?cjlLS2wwOW1Dc2w3eE50alk2cXo5Nnl5Z09ESTdwc215TlNON1NFZWNqUnA2?=
 =?utf-8?B?QmFqU0FKVWVwUFo1SVlNUVVJWFZReHlaZkg1UWJ1bFZ2SG5PZXFmdUNGZGRr?=
 =?utf-8?B?c3g1Sy82Y2tMbFc0Ly9aMW53dHdvcUpkMFNNekszVjFqVmtLU21ZeVo5L1Js?=
 =?utf-8?B?TmJIZnBFZ1NteDJUT3ZiWXNBOE9QWnJsN0phKzN1WDI1RElKem95ajY1ek9n?=
 =?utf-8?B?R2tRVWM4SWNKWFB6NmpPeVdnWEFhaEdpVjd4cWxoV2NPL0RiWUJ6cnZtTnI5?=
 =?utf-8?B?TEZwVStDbzRzdkxNY3R5dkJjSjBPUFl3bDBHaGQvY3Q5TlZQZEpJWThxSjR3?=
 =?utf-8?B?YlF0Zm1IbWovWmhZUnJvelFZWmhhRnRaVi9LZnN6d2sxVlM0NC9YYzlvOTlY?=
 =?utf-8?B?RHhudHFlSmNWY1hldFd5NnFLRExGSG9FUnJDOWdPaHI5TGxkQ285K25UUXhE?=
 =?utf-8?B?VGJtRWlXSVFLeVRCQ2pZM3ZiQzhOQkpPeG44VUhIMDloR2MvaENDa3FzMm9V?=
 =?utf-8?B?V3ZiOFBXTzU1SjJLTUorR3JZQWFSVXRRQkIzL2RhUFBZa1MrSGx1KzlJRXg4?=
 =?utf-8?B?VDIyY1VOUjhEMUNWWks1VXlManREOEZyVm9GamFKandKd01ySUFzUmFEcHV1?=
 =?utf-8?B?MlBnODI2WmpBd3Z0RXFmNThsNjJITVRGQ2tOSXZjVTVTanIwc2NGUjg2M05j?=
 =?utf-8?B?U3BKTm9ENXJnQjcxK29ob09PTTdvWlA2ZW94TWVZdkEzSnQzVjNDWTI1dVY2?=
 =?utf-8?B?TDZsM3g5N0RQRkxqakRmMCtKZVdaQ2NJc3JjTGFwSzh3NmhvWDY1VjFrZWEr?=
 =?utf-8?B?dkdoMWs5TFRiRnU0U3lEb01Sb1g3UWhreTlVUVR3a096ZE1idng1cVRMWXVy?=
 =?utf-8?B?N2pWcGVEeTUwNVJsMVlWYm1PN2dYSlFMYXUzandGMTNFekp6OTlFQUlTLzla?=
 =?utf-8?B?RUNnUVVtaS9jazRQMk1hcmdHK2RYSExVMzJiNTBOUXlCV1RrN1c0cEJ4WlNl?=
 =?utf-8?B?N3dyK3NrbnFkUlVDS2xJOFFBV3hsckVQV0hHT2ZXaDk3ckpFdEdIS3hMVnhQ?=
 =?utf-8?B?MkNUQ254UWx4L3I5aTBtTE9qNHY5MUk0eG15YTZMMlRrS3MxaU9LOVp3a3JW?=
 =?utf-8?B?Wm51MGVvUnM2N2plbHArZXFjcjdQU3pFZHg4Q3hwU0pwL1h2Y3kyL1QrV2t2?=
 =?utf-8?B?NmQ1OEF0aUlYaWhnWGk0bWdlR1ZMMlVWWlZhaVdtaGVHVndnZmpTSC9KbTZu?=
 =?utf-8?B?cjZaUWlXMGdUdU5RNW9zd2o0YTRTV1JJNktCK1ZaaEEySGQ5ZEhFdnZoV3Q5?=
 =?utf-8?B?MGo5dmVXNkYySWRHRmIvNlc4VEUwY0sraGhNQnFUUDJlb0FWNWFzUkZvMDd0?=
 =?utf-8?B?QlFSeVhSMm5LZC8xNGZ5SWNUbzlKdkNzYjVFaDAzWlY3a01DVXQyb3l1S0U4?=
 =?utf-8?B?WW9BR3pLUHB4VEszMnZZNWhpNUVEN1Q2ZnZpaDFvZUUzSkxkN2hNSDZaNVFJ?=
 =?utf-8?B?NGlOS3JvVDVBV3ZVTkd1dzl4SEVGZ0V4dk81a2ZiS1VZWUh2cldtOVVCa2Zx?=
 =?utf-8?B?ZktNS3hEWTlONEFmZzkrcTBaS1dvOUJueWRGbFFHWXJnM1ZmVklEdGtaU3dt?=
 =?utf-8?B?bjAxalBqY0dyN2lkdEduY28wcHpkV1BLSjE3U2tvcmZXT1V5SU9qYzBBczFP?=
 =?utf-8?B?TFhqVng3WTJWcVFqeWp1UEN0dC9udWhaMkNqS3ZLWS81MkVSL0NiU2RGcUtt?=
 =?utf-8?B?UmdGYjd4L2tBPT0=?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?QU1xeGxDendFTkl2SkZKNVNtdlBobU1ablNGazNHWmxDUTBCcjd0Q1Q1d0k4?=
 =?utf-8?B?L3RpRzF6cng5aW5GQXFiUGJtN3k2SitHc2o0WDhJa2VjZnNyVXQ4UlpDWXFk?=
 =?utf-8?B?a2haRFlCZXlSdUFFdHYwclJnWGRDSkNUWVhYUW5tdmlPZktaZWVRQmFtTWZX?=
 =?utf-8?B?azJ0SUxaMTRRVnNZTVMrNGlXMUdaR25YZDF3VjRyaDZ6WUFrdmtzc3JRS1JR?=
 =?utf-8?B?QXpsQ1FXOVJzTEU5NzFUS09OdHpTakVjQXV2b1l3VXNyUmNpTjB4VUVyTThS?=
 =?utf-8?B?cllUWGFwZzZWU0lXMk1UTnVuNTYwVkRTWXZPcVJZTVVsa2pKbEpRMG4rVllx?=
 =?utf-8?B?S3dJSnMyWnUvWFBHTE14RnF6Q2IrRUFLYW9jWXJQNkdRWXNLMmEwSzI4b2NL?=
 =?utf-8?B?VnR4aE05alNBU0ZFQ0R0eDQ1UDJxUStxRmVGR09QTmhESE12Wk5EWVJOV0Rq?=
 =?utf-8?B?UERPUVdKWmtqcVVTVW5MZUdpdFg5MFhrOVMwWE9hQVhDMFpnQ2pOQ3IrcTIx?=
 =?utf-8?B?U2tBb0RBb04vYzN0NXZGM1hvSGtJejBzQ3l2Nm9Ob3JnV2RIY3Fqa0JuZGxR?=
 =?utf-8?B?eGswNGtCb3dDQWRsUGV1Y1k2elZZVDJLeFZHQUlpZnhGQ21lRmorQXRDQ1d4?=
 =?utf-8?B?VWx0V1llUGlyZWtFczZ6WDRYVDBQYWZvQWw4RUxMYmR5M3pURm5kQ3RpSER2?=
 =?utf-8?B?NlZxeGJtbDhVU1dUd0xXK2tsamxlVUo5OWljUlpsK2FndW0zNVd1NVFXaC9a?=
 =?utf-8?B?U0RIV096RzVqeUFjZkhMcFBhdHF4L1VjZW5qeDltL2N0V3FYdXg2TVNKWVE5?=
 =?utf-8?B?VjNGb0RDc2VoNlFDRW5tRXB1M1hyL3hIWjVXbXlmUitYR0hzR3QyajJQajVO?=
 =?utf-8?B?NXh1V2lZcjVUcm54U3J3L0RmdEc5dFdsaW9SbUlEQ0M4czBYNzQ0L1kyaXdT?=
 =?utf-8?B?ZnRDR3plZEhHY2ticms0c2FTN0lHRXdXYTBjWWJGTjZjUVptSDBVdTJpOG03?=
 =?utf-8?B?cmU4ay83aldodFpKUERiR1BzM3BTc1RwakhORWoxMlgxSXlUMUhva3JVZkFq?=
 =?utf-8?B?RFcwa0RsbXFBTk92TGlGd2VJTXRIRVpCOUlEWDJ0dnJXRVlDTmMwSHdpUnp3?=
 =?utf-8?B?T0NDcVhQZ1FKaWdUcVd2WDFjd1lqMVIwQ0E1Yi8xVUFCZ1ROdlBURVVWazEv?=
 =?utf-8?B?S00zdmdkalBZa2FHU2IyaE9KMGhWTXdRQXpWNFVsY20rdFhYQ1N6NmRuUG5q?=
 =?utf-8?B?OGM0cmhrd3Jud3dHRDJPS0IyclpxRzZKNlZVMC85U1ZOeDF1TjFSeVdiMEVY?=
 =?utf-8?B?dGVvalJWT1AyNXk0N1NiRkhmWHBUdVhSbitkT1c5MGtRckZlcERneDZYWDN4?=
 =?utf-8?B?a0gxTnl5SEdZd0VpYitReTY4SWVSWkc3dDNUbll6RmdlenhVdjllU29lcjZv?=
 =?utf-8?B?enNMZUlJbkJsUlljUk1sVEViMUpqem44YnlidlgxV0k4YWMzNTdzcEZyd0Fw?=
 =?utf-8?B?WUo0eHhoYm5HWVMrSm1aT0tVKzRqUWhLNU5FcHc2RFJJSy9GTVlmRlpJK2VG?=
 =?utf-8?B?ZGNxQ2NNZ3BEczZPZnJkTUZrWGlyRzhhV1B5eGZwa3JQVTBnRjVVL21SRHYz?=
 =?utf-8?B?d090MXpNL0RnWkp2djZ0UWFlQVBwT2tJdDhmbmlQT0lpbnpXT0x4cGlKaGND?=
 =?utf-8?B?MWF3UHZLN3NvVGxEREpPOG1qSlNYOExJN3g4YVdvRnNPY202Z2xJNFRHZkNC?=
 =?utf-8?B?NTAyN1JhRUhyMllQSFNRZUNjNnE2bWpNTytHcm0wMEJ1S25iT2R3YUlsYkZQ?=
 =?utf-8?B?dHFWM3p2dXRaZTV6dEdMdkMxb3ZnaERPVEZOeFA0RTdTcTNiNXlaNWZrWEpO?=
 =?utf-8?B?UnNqS25vYTRwRWFEVnE3SXBpdUNMa3JiZWZxMkxjbmdXVVpIcWdYL3RObDll?=
 =?utf-8?B?dXlwUEp0OU1aZTR4NWhqNXJnclpsRGp0ZWhsSkU4Q3BWVk1BYzBzbFB6UGtH?=
 =?utf-8?B?NXQxUzNtTitjNzFYMUFrSTRTRnJVOXA5bEJub2g2UVZXRTJmZ0Z0emlvbjZt?=
 =?utf-8?B?MUY2TUlDOTUwY0lyM0dqejFQYVhDc1F5VzVnaE1nSHpObzlGdmRmWi9JRWdE?=
 =?utf-8?B?My9KZy9lQmFLeGtraWdMcmk5SnNRSnZFSFExSkVoc3UxcU5CWHJTSThnUzNa?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cvt3HinlQfmYLc6LCOFXWTirsCyhkyTmasy/aQ04e5lIuBtADNU+8Us4TTpbCLajjBc4Qa3w9aHzOOsS9psAGyoSLVZIdtC4L5tqlpDIAoFnSHsd7d0b6W6xB165xGrZ/DaQncP8ReIB3ZZ2Wv91ZYvh9dWOfk8txg+DkteghDoCA6VwvxY8umX9O/xpi+SJPIaS1X+Qr3mDeG+B67AUyZzrIy3JTsTLzNJTA/bu/3bAw8fWVzYCfQ//WhRIViGwPWQweSQBirZbGNombW3ARMHGr+jTDOAz+t4SX16hGEAM2gBPsOb58CsErfkZkkrHr7z7/6vW6TDb6LrnaG8MEoyV9LvKBk3fBMVzrUB7iB6JaWfoNZ9IicztNcP48FCwXEGNzlbvvHp7JEp+j9Iaq3BsK01qn1YbiYu+Ubrx+VBMVSoAhUZ7TjJkqp9Xaj0j+8emVbxV02BKJZjJyRGqUGx992LmPY82aT4lVCD7DkG1YoOt/pkZsMBsBy7ZSl2qkX6iOq8/bYF5i5NzD/Q9AgqUSzsGYHrQN4yJkZT2WUJYEcF51KiRczGKagfMD4ttSHfrLGFDGQ2jJddusmsK5m7o2XOJ1mbIF8zqrvkYYAY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 68692e20-2e70-423a-d8ec-08ddcc75123e
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jul 2025 18:48:54.7517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jcfxXlpFW6f08PIQ4uZMAbbdUJ6BFNV6d977YOOgSul3dWBIeB4obTT+k+QPCncQ6zh4LGSIog+EldHCDuCPRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB7539
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-26_05,2025-07-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507260166
X-Proofpoint-ORIG-GUID: DA0DskYBKMMfYLSgaWzfg4qQeXQR3IEv
X-Authority-Analysis: v=2.4 cv=LdA86ifi c=1 sm=1 tr=0 ts=6885231a b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10
 a=VwQbUJbxAAAA:8 a=vlY4Tx4SO32IoOzBz2kA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12062
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzI2MDE2NSBTYWx0ZWRfXzsfqeM3AUjzT
 mJg9OtbiIlYT5y/S/MM9W87HIKZj91EeHZLzCEtpiLI3RCtZvLtRStUi9wySBKoV7U1OudHbqsc
 rJ2fQYwg5rJZ49jgsYCWqJaDQ2Y3ozgLtRXrKbxYyvprhBbFyp2Za8511gx1C7G8UbJCZhOAL56
 DuarSlp626D7CWZr38NGEblnKFq6XPQgriP3TGjo1HK+cXvoZzN/NNGoZl8OJM8XYOdewCHpAg5
 q7iX+VImTV/Kz935XHenz0tJ4ZdB11zV0ydnuS2/W1HC918Cphjz8Q0jd5R067A3H0D7IWCXrk4
 UHxEwGyKKI9TaSI325cMf05QCX3W0ZHiyoMGP3pC0NjWe78pZTO1Lmb/SQMSMbWNvOotVhhgk+/
 usBD/sYLQLpTfnwoDzXKWKze94oSOSOFsfGr6lPNiXAJdJABwhrzkTEr705RYDu2lO9++H4c
X-Proofpoint-GUID: DA0DskYBKMMfYLSgaWzfg4qQeXQR3IEv

Hi Jeff -

Thanks again for your focus on getting this straightened out!


On 7/26/25 10:31 AM, Jeff Layton wrote:
> Ensure that notify_change() doesn't clobber a delegated ctime update
> with current_time() by setting ATTR_CTIME_SET for those updates.
> 
> Also, set the tv_nsec field the nfsd4_decode_fattr4 to the correct
> value.

I don't yet see the connection of the above tv_nsec fix to the other
changes in this patch. Wouldn't this be an independent fix?


> Don't bother setting the timestamps in cb_getattr_update_times() in the
> non-delegated case. notify_change() will do that itself.
> 
> Signed-off-by: Jeff Layton <jlayton@kernel.org>

General comments:

I don't feel that any of the patches in this series need to be tagged
for stable, since there is already a Kconfig setting that defaults to
leaving timestamp delegation disabled. But I would like to see Fixes:
tags, where that makes sense?

Is this set on top of the set you posted a day or two ago with the new
trace point? Or does this set replace that one?


> ---
>  fs/nfsd/nfs4state.c | 6 +++---
>  fs/nfsd/nfs4xdr.c   | 5 +++--
>  2 files changed, 6 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4state.c b/fs/nfsd/nfs4state.c
> index 88c347957da5b8f352be63f84f207d2225f81cb9..77eea2ad93cc07939f045fc4b983b1ac00d068b8 100644
> --- a/fs/nfsd/nfs4state.c
> +++ b/fs/nfsd/nfs4state.c
> @@ -9167,7 +9167,6 @@ static bool set_cb_time(struct timespec64 *cb, const struct timespec64 *orig,
>  static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation *dp)
>  {
>  	struct inode *inode = d_inode(dentry);
> -	struct timespec64 now = current_time(inode);
>  	struct nfs4_cb_fattr *ncf = &dp->dl_cb_fattr;
>  	struct iattr attrs = { };
>  	int ret;
> @@ -9175,6 +9174,7 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
>  	if (deleg_attrs_deleg(dp->dl_type)) {
>  		struct timespec64 atime = inode_get_atime(inode);
>  		struct timespec64 mtime = inode_get_mtime(inode);
> +		struct timespec64 now = current_time(inode);
>  
>  		attrs.ia_atime = ncf->ncf_cb_atime;
>  		attrs.ia_mtime = ncf->ncf_cb_mtime;
> @@ -9183,12 +9183,12 @@ static int cb_getattr_update_times(struct dentry *dentry, struct nfs4_delegation
>  			attrs.ia_valid |= ATTR_ATIME | ATTR_ATIME_SET;
>  
>  		if (set_cb_time(&attrs.ia_mtime, &mtime, &now)) {
> -			attrs.ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET;
> +			attrs.ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
> +					  ATTR_MTIME | ATTR_MTIME_SET;
>  			attrs.ia_ctime = attrs.ia_mtime;
>  		}
>  	} else {
>  		attrs.ia_valid |= ATTR_MTIME | ATTR_CTIME;
> -		attrs.ia_mtime = attrs.ia_ctime = now;
>  	}
>  
>  	if (!attrs.ia_valid)
> diff --git a/fs/nfsd/nfs4xdr.c b/fs/nfsd/nfs4xdr.c
> index 8b68f74a8cf08c6aa1305a2a3093467656085e4a..c0a3c6a7c8bb70d62940115c3101e9f897401456 100644
> --- a/fs/nfsd/nfs4xdr.c
> +++ b/fs/nfsd/nfs4xdr.c
> @@ -538,8 +538,9 @@ nfsd4_decode_fattr4(struct nfsd4_compoundargs *argp, u32 *bmval, u32 bmlen,
>  		iattr->ia_mtime.tv_sec = modify.seconds;
>  		iattr->ia_mtime.tv_nsec = modify.nseconds;
>  		iattr->ia_ctime.tv_sec = modify.seconds;
> -		iattr->ia_ctime.tv_nsec = modify.seconds;
> -		iattr->ia_valid |= ATTR_CTIME | ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
> +		iattr->ia_ctime.tv_nsec = modify.nseconds;
> +		iattr->ia_valid |= ATTR_CTIME | ATTR_CTIME_SET |
> +				   ATTR_MTIME | ATTR_MTIME_SET | ATTR_DELEG;
>  	}
>  
>  	/* request sanity: did attrlist4 contain the expected number of words? */
> 



-- 
Chuck Lever

