Return-Path: <linux-fsdevel+bounces-52209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CEDD4AE036D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 13:24:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 748663AF0B5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jun 2025 11:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AA73227E82;
	Thu, 19 Jun 2025 11:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="rFoYhxtg";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="NwU5jAxC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88C8022756A;
	Thu, 19 Jun 2025 11:24:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750332282; cv=fail; b=h+DgMxK3ElmcAuTtNCtMy5hiNCvJuPLpppV5p7RXgfXj1/UeI0HoVP1mG2v+5GdvsdRieOI7A/aCpg4UYEHNllLeyRhHxtYetwYcvT65mmhc4X+reFt36uhX4HNpfk9n0D4Vzt6qIt43a5GHKMM1FuIh40G50sR68o6SQVPXBmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750332282; c=relaxed/simple;
	bh=czFoA7oHwDtRPzrVcqUwu5iyIS+JeFBnF8qoOGTeycQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=U2vtZBn8F+ZMnMVkQND7xFo4VTfxHOJ5N9IPBOH0icaq6TqyEzyKgQQ7CscFar1u6jDqJ57gsTNQhR2SWCGkDWjVcjD+yCwTI0EcJsVSQTaY4w9IfxpQ/H801c0L1ys/Z78/EogcQe4sOCSSoTLYdOWW1gE2MZhldt0ecopwjeg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=rFoYhxtg; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=NwU5jAxC; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55J0fclC027900;
	Thu, 19 Jun 2025 11:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=8a6+9IfdLfmc8XJJXUeqJbSOAhcVd/j+Zg9LqCtxJEk=; b=
	rFoYhxtgqhrft9eBn+DtMJMQDFCzckB8PISORB8f7LBgfgSDzoWpbALqVdWq3+og
	hko+C5M+bxW47qg0vOFSIF9EcHxCQTTYRylFIUqTiu15lWsaUyifzejdfvmsEkQ3
	hlq/Slmo3T88LAfPsfs2Nm89Las3l4YTUw23wFNzJ0Lu79ujQ8Kdh6vccEN+yqoi
	OFcaE0gBadk+JJfXrR95d5wLPQVCmaa8yl9NHYwUYpbb7e4BFy7b6TtqELJXxVRd
	T9mMwRkeZ5vAWADXaW7NUsBS6VLtxqbrF6jLpJK5d4UxA7gMh+komhR61YmWzo2d
	Cyf45JXvbTcyVVNI8db0kg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4790yd9pvd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 11:24:27 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 55JB1F0Y022778;
	Thu, 19 Jun 2025 11:24:26 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2044.outbound.protection.outlook.com [40.107.236.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 478yhj2gd3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Jun 2025 11:24:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ETh/lD8vLz4TVTQKI1kGEnnYtHArJ7PNUhdvnxDDlzFR9GE1oxDMR5FmpdTeCPe3dwbUeZb8oryEAlfiXEkphNSg8PYGxtHA1nqjpIQ9jdubCLpJEQm/D4VczZuX2fmHxtc7hVvFGPwlaSqAzY27V5/1sX7vycmC8FSOfQ3FlaefeDbOGWKR1Gu2GGSa8Jbga2m6k+UNRcYk8/PX7Hc13hekiuaniGgqmBhb+afhhLzLCMYMYH36M6qyYKr8ZtyOyB8GPbNssb6prT53bUN3dNOMFhvliUc3aY5hwPKnbqNK1CXeOUEtHHfGu4taD00fHGyUrceBfsHcx+NkTvy8ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8a6+9IfdLfmc8XJJXUeqJbSOAhcVd/j+Zg9LqCtxJEk=;
 b=eS9Uo3rhtjN98oSBjKTfTeDaGeDIGSMQoU18N+2m/M+wu0L4KjlYczXS8TCMnvPFkUC8n0ThxRSn7JIat9P5lyuDCNZuzInbogQvmHvig6R0U2lBa7Osq7c44AqPZqc16HJZVLnrvY4lDYgMTu/IIeeWXY/EbaAI9bqC/M9wsRuNHwQxFet3zr+qfzqRXw1iZBBS058NVzc0YDN3DlQsYTzFZI8+rWNCJ7xvEzXVvPblPZbSnOqlOjono+f6ypBjjJx0N4lOqml14GFvR0wTSz9FexN60n3l1LDJFOwJpz+119FpD43iEPJCisRp3Gp4LBp/E7oxwvaPnDqHYapzpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8a6+9IfdLfmc8XJJXUeqJbSOAhcVd/j+Zg9LqCtxJEk=;
 b=NwU5jAxCJ0BNPQ9pAyV+r5CCFhWaJ1O35YMfUQg9HWPvK5nmz3Unp+spf550mLAGbuTrDsrBvdV0aWVSK3SSdkf/SdEtkbYU0oxFnMr4GBn8isMYLkaLAKZN+gAWz0UDKRGdDO9cjSIrbhIGU3gIJj2vwA4XoxW9bPqmGX+CMyI=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB5550.namprd10.prod.outlook.com (2603:10b6:a03:3d3::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.20; Thu, 19 Jun
 2025 11:24:24 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8857.019; Thu, 19 Jun 2025
 11:24:24 +0000
Message-ID: <22295562-ac0e-41df-a995-a52c0ebcaa12@oracle.com>
Date: Thu, 19 Jun 2025 12:24:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] statx.2: Add stx_atomic_write_unit_max_opt
To: Alejandro Colomar <alx@kernel.org>
Cc: linux-man@vger.kernel.org, linux-fsdevel@vger.kernel.org, hch@lst.de,
        djwong@kernel.org, linux-xfs@vger.kernel.org
References: <20250619090510.229114-1-john.g.garry@oracle.com>
 <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <7ret5bl5nbtolpdu2muaoeaheu6klrrfm2pvp3vkdfvfw7jxbr@zwsz2dpx7vxz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0311.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:391::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB5550:EE_
X-MS-Office365-Filtering-Correlation-Id: b7be1476-aa4a-47db-ec5e-08ddaf23d81d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bzh3SGxjTC9jWHAyMTJjQWhFSW4zVmxDOWQzSVJiWWN0OHQvWlh0RXRkYTlI?=
 =?utf-8?B?Ni8vOGc0aXVMZzc5Tk93TXhUaTloQ1MvRHR2a0UxR3hmbWVscjNaZlBpU0Uv?=
 =?utf-8?B?RUIyRnZ6ZFVVVmJwSUNjU1VRam5CZ1hTYTVPZ0xOT3lpRGUzZWdQSzFPL1Yy?=
 =?utf-8?B?VlJkMU50Yk9vWi9hM0hjN2lhdnVaQkpGandib2lnUjJ2OGhIQmJ3VFBZY2lV?=
 =?utf-8?B?RUFOSGlOR2p4Y0dRYSt1QUdESmpjT1dYVjhiS2YvRmxpUmF1RnQvZ3JGYjZR?=
 =?utf-8?B?ejd6NDM2Y0loZEFIL25pMUkwdDRJcUZBM2N3cGVFYVBLbE0xMkdHMTFZZ3VQ?=
 =?utf-8?B?K0tqRENpYkRYK09WUEVRcXd6ZkY2T1dXL3ZVdTlpZG5TM1BSaTdtK3kxM0FL?=
 =?utf-8?B?K3gvdlpVbjlkNHFUM2dTZUliNHZsVmYyQzJpdnY4NFdiMEEzY3hHdWdFMjJm?=
 =?utf-8?B?dUhBK1paUEM2MjFZOFluSGd2Qk5IR1RQV2ROYzVTbVNUSzBIaGorOStnTWFY?=
 =?utf-8?B?WUdNaDVlODN1OUVEOEo5MDBZekpOMHZnWWRPcFhESkNQSVhjVWtFNWZ0REFW?=
 =?utf-8?B?UUFoVVNxL3lZSUdOekJtcWs4K3RwSFlBaHUxYS9JcU1EVmI5Rm1MRExUY3k4?=
 =?utf-8?B?NXU4V094bDVEWUl6dENuRkRQYUZCd0tBdE1hV0dPKzZCOU0vL2pWckpMVFhh?=
 =?utf-8?B?aDlZSGFtUUVvOUUvN1pIK0IwdUZvckFJSlNoRkViUm8vbW9VQnVCbHhBTjhG?=
 =?utf-8?B?OUl3S0Y5YlZSTSsyTnRrYVVGdlBDSEErODN2NW81VGRrUkpyaUlHS1FpSXVt?=
 =?utf-8?B?WHZ1eHpRakZiZEh2YUdNNW5EcUNTNkJreFVXQWFnM2RPbUtTU3JrRXJtUFJh?=
 =?utf-8?B?dWVmbTJGREFWT1RwZzRkUDhoeTM0ZEFWY0NOaXFLaEZwaXhieFFVOUo0dUxJ?=
 =?utf-8?B?akZEdUN4UGJyT3M1Z1p0QnI1K2toUUhOWDZndmV5M0RnSFkvOE0wMXZiMGw2?=
 =?utf-8?B?SEZJVkVKVFNyV0cwQVJ0QWNQVllLMlpnZFB1Ykc4eWM4RXhZVFk4Vll0K1I2?=
 =?utf-8?B?UVNmTXVsZnlHYlY5ZHROdjFIMVYrelZTak9ERzFTVWNzRFQwZ0F3WFFSSE90?=
 =?utf-8?B?cTZET3p4Z0c1KzFBZFZXU283MWNiUDFuNlFkRkwzL1RraW00L3JKcGtkNnNj?=
 =?utf-8?B?TSt5SjFXa2s0MmdVV2dkOFlhc25HMUdVZ2QxMmErRW92cWc3a0lvb2pYTzlK?=
 =?utf-8?B?SHEyMFhlMk1xeSs1dE1kRHJQb3hjMm9LR09vTnFSeTNXSHBxUUFVYWw4Sm94?=
 =?utf-8?B?cnBLQ09OU3RWVmVVMSs5cFM1cEFCU1hNMmVkS1JtNkpZS3R1c25odUhjMVd3?=
 =?utf-8?B?RlN6b1IvSVpHZWhxQlltWmFGVHRhc3NoMElGV214UFhoUis5MGVOZU96R2tv?=
 =?utf-8?B?YjRVa2lnSTg4eG9JeEYzQWk4Nlh4RkRUaHNzL05GUUVXZDloZXBvUHFxUGpY?=
 =?utf-8?B?TGpDVGtoL09EUTF1K0dMWHk2dzdVTmVOa0VwSVh6SjNKY1Rpcm9oS21mWlpV?=
 =?utf-8?B?UGhNNlk5N1JEVVpFczRQTWVSbStpUkJVWW1YbzdFVGl1cFdlOHRRZG5SQ2c3?=
 =?utf-8?B?eGFDY0xwNytNMUVpL243TFJrRHZDT3RBRnVlUE04d3lJaXZiL3ZGZTJUb2lT?=
 =?utf-8?B?bnA2Q1BpWTRuTTlKdmJuTUhtUVR2YmJUNGs2cWxQQlRLYytqSmg3QnlkTzVz?=
 =?utf-8?B?SU9RZmtIM1QySEZSbVB4UzVFaWhnWnQ1V1ovNW9Sbmp5U1RnYndRYXQ0eGlD?=
 =?utf-8?B?QlQzZERCSmhGbmZRdFkzZ25uaDJ3L3FSeE14RTduUjlxQjRqeDRUWlV3Smc1?=
 =?utf-8?B?MVF3dVI1U0d6WllXTU1peHZFcXlKelJkTjkzQ0I4dDQzbVZDSkJTOEdSQmpa?=
 =?utf-8?Q?JvE8lRiSPUg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SzRkaXppU0E1VDZUUUREblRQaStXQUpVdTFIZDdFSUlLbGxZQktNNjIrZFBy?=
 =?utf-8?B?ZmNYSksvM2lxaWQ3Ui9uSXVzdjZzekVuZkdHb3d0NW5GZUJ5QUNNVG5jOGQr?=
 =?utf-8?B?UXZVRmR6ZThsakJHcnlzbGlORmovNHhxOUdlWEszYUU1djdmcGRySU94ckZZ?=
 =?utf-8?B?NG04QW9qNHlVSHZhcU9SbGUzVnlvMkVaU3g0QXgwVlZxUUxaSHdySjFOcHh5?=
 =?utf-8?B?T0Z1SlI5MVlmdVZuVHIxanhmY1lrZGlYVkhrTytJVHJKb1FQdlZxb0JuckZN?=
 =?utf-8?B?NEtzRzRyaTZhSU0yME5XNnFVdG1QOGlPWnltQVg3ZjZKdldvaW9xazF5Nzla?=
 =?utf-8?B?QlNDT2VOaG1GbjFkcnV6cFo2WGsydHF5cFNRWW5HNXFEL2RJbG9ZTHBvcVlY?=
 =?utf-8?B?ZGx0eTh0cG1lUjZobFlOSk9ScS9DcGk3MWxMMHdmY2kybVlLZFo4cHN5NHRU?=
 =?utf-8?B?bHNwRjF0YjRPRVltOFQ1ZEFYVFFjNVFCUlBtR0dKSU50bDNCRUJhK0xPL1Vs?=
 =?utf-8?B?cGpLd2tPbUZhN2FyOU9sOHdTZThUdUkvUnJidEZDS3pISWsrQTRnbVNkMjV4?=
 =?utf-8?B?Mi9GdjNiT1FUc0J2RTdGUEhpVFp0MWJudW1iMjdBaTZqdk0relFmcE1WaVNH?=
 =?utf-8?B?cVhla2JHYkxRTFZ6VjIrMWM2YTNTWFFxdnNUMUw3bzdmS2pMZGZ2bEtSTG1Z?=
 =?utf-8?B?V1FCMU5hRXNKQmFRUU9MZnBudHhydUFiS2lkRFZDRnhKMFUvVllsQWVvOHVp?=
 =?utf-8?B?Qk13dlRZY244N3VSeVdhOHVtT2VBa1RJWExaSFhMQmxib0VmcHNWSHE3cnVD?=
 =?utf-8?B?SnBZaGFmWm5TcHZNRy8wcFFpc2RYdmhJeU9hRFJyeEdYeU9mMS9xanVWOG16?=
 =?utf-8?B?TmFSbTYvVWVwaHpQYmVXZ2NCcUx5Uy9WbnhuV1dGZmlDc0NGR0hBbjlSc1A4?=
 =?utf-8?B?VUxHalBpWm14dXNBMVdlNXVXQzJhQ2cyZngyd3BFa0JHRjhkTDR2bFQ1aDlp?=
 =?utf-8?B?clFrZ2I0a0sxNU0rbmxpeDZqUmg2bnlnR2pzSTA0Q2I3aWJZOWRCREp3WDk3?=
 =?utf-8?B?alRLblZ6bjFqUU1IaGtBN3RYQVMwaStCaGt1VkVmbnU3NmZIR3d3TlZDY2Fr?=
 =?utf-8?B?V0hqUDJDUXNNN1ZXaEpINDN5RFJ3UzRRdU1MS04rUkRQVlhLN3k0MTRjRGk5?=
 =?utf-8?B?VDdyM2ROY1VSUWFTWG83VzRGRVpEUDA0V09NTjY0UXhoS2E1VWtVZDNNd0Nl?=
 =?utf-8?B?aFQxczllN0VsRS8wakZVUS9NNE5Fa1Y3THR4bm9lUXZtVEhhcW1ETjhPTnVH?=
 =?utf-8?B?NzZsSnQyNXdyVmtOVXZBdlpMUEN0NDB2WjJad1FRdFUxY0U1SGF2YWNSejNv?=
 =?utf-8?B?MGhwUUtLazJ0UVNiWFkyb1U1ajVxYlQwWWpoclVPU0VicHhmdlpRK3ZBQlRy?=
 =?utf-8?B?SC8yMjBmMGc4eFlNZHc2UFJ5dHJzbWdoaWJieWxld1ZwRU45QWNHOUczZHQ0?=
 =?utf-8?B?Q0NhRVlMdHJmVTdqNXQybnRCRTFQbjNVWkZZK1VVczNvUVR3eWhLNTJEWGox?=
 =?utf-8?B?VTJkc2pTcVE2NUJjZDFYY25hR3NLLzZQbTkvUHJtUzN0aXZtWWZlTVJENG9T?=
 =?utf-8?B?VWdIcU93Mk5NN0JIaEx0WlVXZ2s5YXV3dUxOWmdWdzk2M2JLUG94ZEo4Q05O?=
 =?utf-8?B?L3VHUS9UZDQwWk13dTJCeGNVUDBZUUJoZmRYTndoY3dBU1FzMDZkTjJWUVlI?=
 =?utf-8?B?R2xPV3F6VzdGbkwrYktoODYwMWlhUUx5MFJ3QUdVUzdOaEFmekwwdGtBSzRx?=
 =?utf-8?B?amtibW4yeUw5bXFvVGNMa0d4TStETU5SOHFqQ0hpVHNzRVpNRm1vc044SG1j?=
 =?utf-8?B?UENyb2NGU3RZdGtQQmdYdTduOWp3RHowdDc0b0M5WXkxUnlyUVBZZzBDQUV3?=
 =?utf-8?B?UVN6VStFZWlGSlFPM25SblAvdzdMa3pHRUZDTHBKM1hyaWpwL0F6MWQ4ZnIy?=
 =?utf-8?B?VjhvMi9qY1F2Vk5nYXVCMURWNVdOUU5VNy83UzYxZmFvdnVORDgvQTFteXpH?=
 =?utf-8?B?QnJEbmYwVVVZdXFYanlVTVJFT0tENUhwcEI1ZkU2UDdza09PYzZCOEFENG82?=
 =?utf-8?Q?L44AJ7ZNeLXHTXbAJnwqrErAS?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	qrhIeJVPjLc5b0BbtKKN5NVmF7Fox7Fy55CRvT1ibOq+Fn1hFTodiDEIPkn4Gs9XyeHsD1GWDN0FND824WNWYF2v94eD8IkOhshkt1jeWSccZaMWMzUO0Py4PH22Cfx45d1Ukf6iL8CkulbBw8nlC61QDC8kAPsXc4q/pM8twOgkrIlgUixXxbR0Rsak+1MBrMMad7g52v0tXodJfuqX40LkxGuRB0dqrsblVEKAy2efQ/IvpXzLDT7PMbjg1G6uCVAI9iUJZ0AAeL4ov6/PRYVN6nsDZnkO+dgKrccJrYnzDcdwgt32e/iLj/IF8z0zMWmON1EAZMFEU+2mJE39mFwGqJ541LhUhxyo3FJtO/0lTck/XcVSl3f1cJrBLAZBA1MpdNdWdOn66l6MTcun2eUBHdTA5b0yFFx1aYxLcvmXfBDvQw6wmw6laOJX1etORUO4Na9jBxuPZrC6VBjb5kLselN8lHxl75LPhvIj3JU8L+GwfyC+5PHW7h+Y6vtUQd9gOqFwPjWPmaWIsgFN2KbdHKTH61T1QUhiU8EPmjPcBALTRa/DOZOkKki7ghey0lPOECGIFjMyFntJ3DBslYeHm/88zszyKf3CisEvv/U=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7be1476-aa4a-47db-ec5e-08ddaf23d81d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 11:24:24.3307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dwKGYF7Xe5lUqz1a8N1y1oXQozKFBVaEmqKQQ2PEhShBhKwXhQibgnsTSWAp4w3oq6HvhqGwzZJJkNziRgxgIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5550
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-19_04,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 phishscore=0
 adultscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506190095
X-Proofpoint-GUID: 8HTYUGjaDRP5l-GLjRIub75qYgKZ3EjG
X-Proofpoint-ORIG-GUID: 8HTYUGjaDRP5l-GLjRIub75qYgKZ3EjG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE5MDA5NSBTYWx0ZWRfXyLVgkZH8k+nS 3tGlKLN/2dsZE6bTvFQSHmSoHB5sXF+hVGDabD7+fmP1/xABYKo5ZD2deKUWN/c3JOiJKIlybLa 7w3Kjnpllq/S9v7jcLapAoze4oQ+Xc7Gy/Ejae8PE0vCO02UniDBNMGEArSQ4IZyEchdqqGWTCj
 P9C2Zmvu1UegQKne6786Mbq07AyZI1U0dqrFTAjfLCczKM5kiCahzTrOzNR3H3vVDREid6ZXgvU RtMA4rygLQxrRmfrRk3yt7RFvMIpbhDwv1TVaQo294EHIb3AfNH8gaelAWWwqwT44UaJJeL/FS4 GIpgAPip7XdHaZ7/iaZHDzlZxBO/2anBZhF9/D65xe1Uenh15PQnuPUtpSDOsNWiA82t3gSpJpY
 KuuB6NiWKltXvncFedsKL/qSFlk9rXTard6GB2txsVsAKOJa0qChoyOZEnAGAwRc5dXinUk4
X-Authority-Analysis: v=2.4 cv=XZGJzJ55 c=1 sm=1 tr=0 ts=6853f36b b=1 cx=c_pps a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=dTf-JLeCBEkRLD-99xsA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13207

On 19/06/2025 12:05, Alejandro Colomar wrote:
> Hi John,
> 
> On Thu, Jun 19, 2025 at 09:05:10AM +0000, John Garry wrote:
>> XFS supports atomic writes - or untorn writes - based on two different
>> methods:
>> - HW offload in the disk
>> - FS method based on out-of-place writes
>>
>> The value reported in stx_atomic_write_unit_max will be the max size of the
>> FS-based method.
>>
>> The max atomic write unit size of the FS-based atomic writes will
>> typically be much larger than what is capable from the HW offload. However,
>> FS-based atomic writes will also be typically much slower.
>>
>> Advertise this HW offload size limit to the user in a new statx member,
>> stx_atomic_write_unit_max_opt.
>>
>> We want STATX_WRITE_ATOMIC to get this new member in addition to the
>> already-existing members, so mention that a value of 0 means that
>> stx_atomic_write_unit_max holds this optimised limit.
> 
> Please say a "a value of 0 *in stx_atomic_write_unit_max_opt* means
> that ...", to clarify.

ok

> 
>> Linux will zero unused statx members, so stx_atomic_write_unit_max_opt
>> will always hold 0 for older kernel versions which do not support
>> this FS-based atomic write method (for XFS).
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>> Differences to RFC (v1):
>> - general rewrite
>> - mention that linux zeroes unused statx fields
>>
>> diff --git a/man/man2/statx.2 b/man/man2/statx.2
>> index ef7dbbcf9..29400d055 100644
>> --- a/man/man2/statx.2
>> +++ b/man/man2/statx.2
>> @@ -74,6 +74,9 @@ struct statx {
>>   \&
>>       /* File offset alignment for direct I/O reads */
>>       __u32   stx_dio_read_offset_align;
>> +\&
>> +    /* Direct I/O atomic write max opt limit */
>> +    __u32 stx_atomic_write_unit_max_opt;
> 
> Please align the member with the one above.

ok

> 
>>   };
>>   .EE
>>   .in
>> @@ -266,7 +269,8 @@ STATX_SUBVOL	Want stx_subvol
>>   	(since Linux 6.10; support varies by filesystem)
>>   STATX_WRITE_ATOMIC	Want stx_atomic_write_unit_min,
>>   	stx_atomic_write_unit_max,
>> -	and stx_atomic_write_segments_max.
>> +	stx_atomic_write_segments_max,
>> +	and stx_atomic_write_unit_max_opt.
>>   	(since Linux 6.11; support varies by filesystem)
>>   STATX_DIO_READ_ALIGN	Want stx_dio_read_offset_align.
>>   	(since Linux 6.14; support varies by filesystem)
>> @@ -514,6 +518,20 @@ is supported on block devices since Linux 6.11.
>>   The support on regular files varies by filesystem;
>>   it is supported by xfs and ext4 since Linux 6.13.
>>   .TP
>> +.I stx_atomic_write_unit_max_opt
>> +The maximum size (in bytes) which is optimised for writes issued with
>> +torn-write protection.
> 
> Please break the line before 'optimized' and remove the current line
> break.

ok, but I am not sure the issue with the current formatting

> 
>> +If non-zero, this value will not exceed the value in
> 
> Please break the line after ','.

ok

> 
>> +.I stx_atomic_write_unit_max
>> +and will not be less than the value in
>> +.I stx_atomic_write_unit_min.
> 
> This should be IR, and the '.' separated by a space, so that the '.' is
> not in italics.

So you mean like the following:

.IR stx_atomic_write_unit_min .

right?

Cheers,
John

