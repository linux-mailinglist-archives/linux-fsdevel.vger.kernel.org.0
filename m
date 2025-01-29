Return-Path: <linux-fsdevel+bounces-40293-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A4EA21E3B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 14:55:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 86B3C161C53
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2025 13:55:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ECCA148FF9;
	Wed, 29 Jan 2025 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gQheJwo1";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="igpbetZy"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F972C9D;
	Wed, 29 Jan 2025 13:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738158941; cv=fail; b=TaKkCqCS4IYhYjDp6xflUZ/epgLB+hL2gqPcC2Su7V8EPCA0kwb9AqbZLbJcmVjcWoJS0GTJ0b47fH/ytBdqC19ECev625IwruMZb2gkjfkdk3UmXhfQi6u672mQ0QmjToINMcSZxrL9VFg7Msd5hxsuEz7RYyi2s7fZfocejJs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738158941; c=relaxed/simple;
	bh=I6UM8fZ4tG3DQ2ZFO1bXNb4BzC0d5z0CGvjfqKvhYqE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jXbp0uy2430nR4Gws/YT7Kqn5TIjI4l4SqdE9rwlHqI9jDKQ/7+Veb0PwgTkezBHVkNjdxVj947KMVGKIZTOOkiE3jn5Nyvjxyo5cjP86JaXqaIf7tdPn0AGa4/WHjLiUGTvggAeIKi6/vacNo3k1FupU0DuqpXvnuwF5oCECzg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gQheJwo1; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=igpbetZy; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TCCifH014029;
	Wed, 29 Jan 2025 13:55:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=vRIbbvhx9gD/CaFGL+LBG4qXViwpyyp6KrVdzziWoRk=; b=
	gQheJwo1q8+O8k4WQ0+ouk4XPvn3knnkrpAxNiL6TFBRE0s21uxqzrRUbsqz+Azt
	dlyeoKVBI7egFG8iR/TY+AZRwVVNcVJbxo+LVAGbQ4iXBlsdIOjplA9LceF1DbuJ
	nNTUy/9cqv2vv4igOxxTe8/sp3IckbYjNltJOYiTD/nHnFWtUn7ntRVJHI64bJY+
	PZFuLBJs3n4VY8T4IdGdrQNS71e8phnHxqnTcrQlDA/KHMJZQoLzXw9CwAm4nKQX
	Gfra+q6G/0jmg2NTVkd/zXJcMcMmhOQvQmyV5gqIElhNXlhM+HO2GhTL81K/PZmS
	WzoU/bjZZCTHuTSrqQUDpQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fm4fr5h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 13:55:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50TCVFmW035769;
	Wed, 29 Jan 2025 13:55:19 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2044.outbound.protection.outlook.com [104.47.70.44])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdfsfjt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 13:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MmW3yk3YeFMDx1fZCwLizqPCbB8qYmuPuBJKCsWYfUOKiorQfqScQugyP1yhk2/zojO6HMULtw/x1M3IIn9Hm/GXn7rtOFXhtM36tODhGqDPvL/rWJTJ4oAp8Hwg5f7papy7k8T1KwYASc/Uo/oCVTNiPI5LQxQFY+yoqy7E7hsZ8uN8fnX3jPWjoOi/zr+OAGni4ilFAb0z05LqG/whOKtDVfA9SxsnnOLZdCvcwlf1Foj2bumYchroNjVt2Z1MN3+Vv5p3HqvL+x7sM9JaosPmKR6IaN7ZB/1jbUWlf5j+Liy27rOluI6SNzH5bDtK8QyeJO9xiK1ibi/639bAaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vRIbbvhx9gD/CaFGL+LBG4qXViwpyyp6KrVdzziWoRk=;
 b=YXBxF57fH0PvWjqBdXonrB0c1ovb+JRAFsrUpcux7yEMPoLNxQJEQQTIZ++SYWmCw4QmgZ1zGOd4PpDTCxvpq5HR8eulLpbP4PZCagEc4/hWiY2C+OgMrT4Wm/4B/Mz/mmVvtf180zo1A5QPlKyWKP5X/rB6B14+bnPoTMP6aEjfq7yQTwHyjFN6YvdMVxoWxYkoDRVgkxrt261RT62IjR1WXM9/HUsXglRD1kmue1y1TzAUvUXYyFgozuxE3fDlX2aR9jn/EQwkPRehSC6okOjZYj+xCntxJSRmSj6Y4VhxUx7ZaO3UbofD0giK1no6c9S7OpGYnHB1lCmvdHwYvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vRIbbvhx9gD/CaFGL+LBG4qXViwpyyp6KrVdzziWoRk=;
 b=igpbetZyUx+rf/TAo+1CHdEYKSvBXOC5AmWQ+c/28adzG4/paxBls0O3UP+hjsFdv9+VRV4jfsCtWzpprnGwU63AUwR83G/ZYJHdJbequU3Zt2blwOsa6h73kwfPPzrBNVrl/1SkLBdQHwg7qg7ekm71Jako8E/iEme/Qv4ZUBM=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6059.namprd10.prod.outlook.com (2603:10b6:510:1fd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.17; Wed, 29 Jan
 2025 13:55:17 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%6]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 13:55:17 +0000
Message-ID: <50585d23-a0c1-4810-9e94-09506245f413@oracle.com>
Date: Wed, 29 Jan 2025 08:55:15 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v6.6 00/10] Address CVE-2024-46701
To: Hugh Dickins <hughd@google.com>,
        Andrew Morten
 <akpm@linux-foundation.org>,
        Christian Brauner <brauner@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sasha Levin <sashal@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, stable@vger.kernel.org, linux-mm@kvack.org,
        yukuai3@huawei.com, yangerkun@huawei.com
References: <20250124191946.22308-1-cel@kernel.org>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250124191946.22308-1-cel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0339.namprd03.prod.outlook.com
 (2603:10b6:610:11a::30) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6059:EE_
X-MS-Office365-Filtering-Correlation-Id: e23ea492-dfe1-47dd-39e6-08dd406c8fc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|7416014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SnBka1YrTklNNktLdzZ0WlZrd201MzhNVDRGYTB1NkliQU12d1BlOVlzN3FZ?=
 =?utf-8?B?R2FxZklNSWNFczlkdnJKajRMRUlaVDg3THNxT20xUHFKS0hPaDgrRFRadTNT?=
 =?utf-8?B?VXNqRVdzTFVTTUpuMS9jR0NiZ2pnZ29VSTljN1RwZnJkcVNQRWpjOWxocitM?=
 =?utf-8?B?RWFLakpYV2wxZ1N4ckNGRjh5UytCUnNTcXpiTWNvMENSbFZHNFdqKzB3R2ZE?=
 =?utf-8?B?TmVxZE8rY2NFVE1IY0tWQzJlWGFpMkx1OGw5ZTMwN040RWREeU4rcGYyUXl2?=
 =?utf-8?B?ZUd5amVwU3BaQkVvZ2JPWXN1U2ZIOGlURmRCRHhaT0JHRGJzMmUwY0JjR2Zp?=
 =?utf-8?B?blJsWTRQdUExSUlSQk1IRWFjN0g3VjFTOWJySmVIc1NURi9ldU5TeWZTcFl1?=
 =?utf-8?B?azZRZGxaRnd1N1dHMC9NSVo0RGtXSzNCMVpSYm54Wi9SQUM0Mko1N1lVaEJJ?=
 =?utf-8?B?WExpUG9STFE2UjNsRHBIZVY1UEk0MDZyd2l5RTVHK3VZa1NiKy9kUXBmVWU4?=
 =?utf-8?B?UHZYOUljT3Z5cnIrVEs2TFdoalROWDE5eVQyL0FGVTh3dHFLbXpmdXZuSm1k?=
 =?utf-8?B?eDd2VS9jNkt3KzNlRGZvWjErUjlQR1dOS1F1a1Q0a1VQTkxMakkzaHBnTEN2?=
 =?utf-8?B?Q3hTdGpzN3FFL3BxVTliRTVnL2huRS9UTHhDQXVZV25yWXpwOE1peVBOTVZ3?=
 =?utf-8?B?TUNLMFFlTjlneldTYmdSWEhWeWdBUVBDdnVvakZVSzFZcG8rUWltcmU4TnpQ?=
 =?utf-8?B?R0ZGd0JpNzBjYjhXdlMwL1RMY2l1dmNTbFpra0l5NFo3MHIrYWlrcitUdU1k?=
 =?utf-8?B?enQwMW5NU040WnBHUjl1d3l1OStRbGJpd1RwT25IWlhOb2gyT3hrd1FCcjdW?=
 =?utf-8?B?WUhSRkNFNjkxUHJYTUV2MHlFYUhIRzZQYnN0UHJwdnowN3lmNFcrK2UyRFhF?=
 =?utf-8?B?YXVTVlBZMmtNbWxVa2dBb0ZzYUtNdlk2WjZZL04vMDdMK3JENE1aaXpqUkVu?=
 =?utf-8?B?TlRqdy9mRU9Qc2lPTUNmMUVWTTNZT0NBZmprcmlMYzFoVWpSQ1JLYVdGZzdN?=
 =?utf-8?B?SVQ3VXRQQ0doOFpjVHREY0pYQ2MrSCt3blBzRnlrVzlIbDBKN1RiclY0ZFRW?=
 =?utf-8?B?SlNoaGRqMlhoMmFwdjh4MHRVNkpSeE1ocWtUZWhIT1F0d1pTQ2FQaWlmcmcr?=
 =?utf-8?B?WDAyOERINnkxNEFjeFFRdXdEOG5UZ2FoTnc2T1hXcFBrVlNmVEF1cHZFN01W?=
 =?utf-8?B?ajJWRVR2eUN4WFN4NWZUaXJYS0J0bmhlczdsSUtQa3l0VTN2VEFzWTBPZjJ5?=
 =?utf-8?B?dS9rVVpIQ0ZtMm94dm5BV1RjbzE1emd6M3diamR6TWxEbkpJYTVxbFZUWCs0?=
 =?utf-8?B?TEpSTitGamY4YUwyUVlXbVBINlhVRms5b3VwM2tXSHFxbTM1WHlEdFhXR0pt?=
 =?utf-8?B?ZFAyeVFMKzdHOUZFSklrMzhWRTFSNkY1aE5NbzRucDhkWnBzekNYaXZvdVNk?=
 =?utf-8?B?QUg3V3NDaVlyNjc2UldpVWtMWE1qSkFkVlpKVDNDc0xOQ1ZzNWRYWGgxSUFi?=
 =?utf-8?B?NEhwYUp6cGlnWVU0eHppbHpwK05xZ2gzVHRNejU2a3A1QU9nNDgwQ3N3UkFT?=
 =?utf-8?B?djVLYU40ZDM2aVZPbUNna2szRU1jQjFWTW1naGphclFsSzZweEFaaHBveXM4?=
 =?utf-8?B?YytoQWZWYU0yeXRHc0VPZm9WYmlrWS9OYUZQcTZCS1UvamZESzFGUlE5LzFo?=
 =?utf-8?B?bW9qejluUXJIOXhwK1hLYnAwTGVPZU01RlhOTEVpVTJ6ZUFaNGx2RmJiM1lK?=
 =?utf-8?B?RWdabnBQUEdmT2g1L2ExUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(7416014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NWg3QVU0WVRPMEs4YTlPNTZtOEpZdjVJOWNmNE93eEFXNG43cXZaNjIxYTFB?=
 =?utf-8?B?WXhHM21yNDNDNUFDN2x0OW1RVU1BdjVnV1RBNUFVWngxbEZ2YU1UdnlLQ1Mv?=
 =?utf-8?B?L0V2RnN2UEhqTmx0QUNyZlBIai9HUkZJaFlaN3NIeG1YQ1FnNHQ5U2F0Y003?=
 =?utf-8?B?U1ZsaHB3U0t2WkhMaHZ1blhkYnJXV1djYm0yWnE2WC83VWgzUm9COXlwVzNE?=
 =?utf-8?B?bC9UMy9aeW42R1F3Q2JXbGZoYm1BSzUrbStPRlV6QndCYzg2Qzk4blFkVDRl?=
 =?utf-8?B?dDREZHlmWXJ3UXNwN0JxeGJRUWd3WVZSOGhBdHY1NE92Rms2UHNSSjFkQnht?=
 =?utf-8?B?dVV1ZWJNMU1haTZka0h5bFNrR3pkRmxhSmZxRmlJMnB3M1RHNDQrTVgrMVgw?=
 =?utf-8?B?VklkUGdFRjZWMnk4cHJkWEFMLzZHdHFPUjBaUDFzYmkvZzkreU82K2hOSHcv?=
 =?utf-8?B?Nkw2WnNKNGp1a1luTkpBWXIyWTkvb09JSWlWU3lOWUp4ekNIT1ExYXFicU13?=
 =?utf-8?B?R2hneG9oV05GUHZ5dndwNjJNYmJQVGRwMEo5Rkc2RDZkZUplS2dlVlkzd0Rk?=
 =?utf-8?B?clNxV3BrVjJ6K2JYODF6ZC9iUWQxbHl3azR6WW05OEhydGpmL2hCSjU5TWNL?=
 =?utf-8?B?My81T2NoaUdUOEI2R2t3YnB2alJxeVJ3eGxEaDVSQnE1Nmg3cElSV1VHNTFq?=
 =?utf-8?B?eVFpU2d2SG5VWmlna1lkWm53dDZNMEl4VHVvNWxtVmlhSndiZEo3WmhaZ1pT?=
 =?utf-8?B?OVllUlBiRWQxL2pjc2dVeU5Wb241SER6VlFRZkFsUjdrREh6RFVuUW12ajZk?=
 =?utf-8?B?UVFUUHNFRDI3TG5qdDdPbzZDdjVQQUJkL2JrU0Q1Y0FHd2JDOTBnQldwUDgy?=
 =?utf-8?B?SVRCMU1Ca044eVBFWkkvbmhHZ1RjYkFaWWFRZFRCaE5SM041T0VMaTUvZG5a?=
 =?utf-8?B?S01SejVBUG04TlJsZjJzblhIL3dCQjc1bUQ5eGozdzV6VzdxcFZFN2IyK2V3?=
 =?utf-8?B?T3RiTGV6YVZoYVlrMzlxU3lENURiZmRkS29JdmZLbUJTS3lqMXoxRlZwSHlB?=
 =?utf-8?B?MTdJcVpGbnpHTmVoT3N4THRUWndFTzRoRnJpVTJuZG10ejFzakNJVklGMlFt?=
 =?utf-8?B?THI4NitPdFk3KzRKTkVMRTUrc0FML2krbllVais2US9mK3lpWDJGbS91RkZ6?=
 =?utf-8?B?S0FOWUY0Z3VDTk1GRWt1WEQzTWtKTXpLSGZSL0pXMVpWTk43cUNINHBOdTB5?=
 =?utf-8?B?V0dOVGhhcUg2a3F6aVpaMUxmcWo0ajNNd3RvSEc4RnBDTHRGaGlFZVdwZ0Jn?=
 =?utf-8?B?TDVMWXk3M1FSV0U5OU9EempvdjNvOWNuQnR0K1IxRTFkNlZCcmlScmxrZFlz?=
 =?utf-8?B?YjA0NmNZTEUwdFZVcG1YeFJncStqR1pNNnBxYVdoSTdsYVhwMXdxU0l6ZG5V?=
 =?utf-8?B?SGwwZVBKeU5oZzFwbDBha2d2RDF0Rk14ZHpRdkwydmpTcGhiek5ac2ZJSXlD?=
 =?utf-8?B?YUV5ZTlCaFhBZUo4WVdQcDQxemxzT0FEV2VZRVlKVFZJbmJyTHIwL2tnSWFT?=
 =?utf-8?B?QU0zSjlLb2dhWkpnai91TittalpHNE5pNkpjYWJYMnBOYUlzVEZVa0lSZTJ5?=
 =?utf-8?B?NldkK3h1WndLQ2Jsam8xcGpvcUtka0JmaW5mc0RHNkp2NTNROGZtZW90ZVgy?=
 =?utf-8?B?N1VQZU90OG1sVVl5eHo1Y3FzN2Zob2cyWVBUTlVqMGcwY3BaZERZN2hnTlU3?=
 =?utf-8?B?dFo0bXpYWVJXYWRQWkVlaE9vSm9tK1FiVEh0VDdqVjh6cC9kQ0JyMm1GMzFB?=
 =?utf-8?B?WFFyVHNFQS84UWpYeGRCRlgydEMzS2puY3JrS0pjaTYzWDFTK2xwYVBjS3hT?=
 =?utf-8?B?KzlDMFl1KzZ2SDR4UlQ5MnRsWVV2emVIWEl5cFhSOU1WaFRMUitwczhwUjhw?=
 =?utf-8?B?dzE4U250em4vU0RUQTRjV3pnNkUydU05Q1BNZitCcFdhdW9zdHFYaWN2SDdV?=
 =?utf-8?B?aWtIVHVBMFVyNEhIU2tQOENGSmxaVTNCeVZuRWlVbUxMMmY2MTRJS3NyaHVH?=
 =?utf-8?B?TFRUM3lKOGtlc0IxdGU1SzhSZ2lKWkZkZzB0c2FyNlFWaXhKdEh2VzJUTU9p?=
 =?utf-8?B?d2w1aXdpcmthdkFLWDMvTlFDWHRMTnk3QUhFVG83YnU2dVdlanpSSnBzYWZS?=
 =?utf-8?B?QXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	frBuBs+RPldGPsIlnnFqRsvAxJJtMmlceroE2SI01I1qSi70NQGThQ9B1orN9uL5jjfHJB3Wix7mFQtsHe0Ou4ClASIOUq3kl3Sl/6eeJRIA2vj4zPS/yKE5M4CBD/QEG3qgyPFd9VlBQ5kFTX541W0SbOZH9vYn5VRJhDxPGPtvGcNv5MkNB5Md/7C94ecCjZS2isSiIuA4ChepetaCbSOEbbP37XoPCf2e+0n08T829nuXvvDsObFpUhNJ25QUWBrYJRxrILeoVXjSnzqHdwrtZAoU2zW28sLwr9Tq6lTF1T5V68LM4orkcZrEkihImF3dprS7mjhFsRvI6opEWxYJAt0vnpQJkWRhxQNSpK/o8QiZioOxz0D4A9nUWqW5xmVLpXzEYE3gIH1r0QMFPHIuCSHNcxJeQ155uGv9dTgD5iXwEHTgayNblEhOq8j0MtYm2enNh3dgbNqcWkzoPHqpqldK+UetpBYliXX3mc3x4beanlUckO6lUGWT+87PB4srS6Fc2o2rKkgyGiP/yuaacij2i71D3riPTuNMdH/xNJJF8YZ5wOiXLuAMiicjfjn2wyPqXwEE9baHRM6qG4uDTVggU0ji56q/3ukyk5M=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e23ea492-dfe1-47dd-39e6-08dd406c8fc5
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 13:55:17.1022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zbr42cN96RoWY1hlPv6CDYYqi/Cus2pfUYu6eNAO71F5kDfLFEAn7wbq0yx8nDus3PeC/Ni1Iks6RgYbXEK3BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6059
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290112
X-Proofpoint-ORIG-GUID: 9-UAITG5e-yJhnypVlx_C-n_6xTN1G5x
X-Proofpoint-GUID: 9-UAITG5e-yJhnypVlx_C-n_6xTN1G5x

On 1/24/25 2:19 PM, cel@kernel.org wrote:
> From: Chuck Lever <chuck.lever@oracle.com>
> 
> This series backports several upstream fixes to origin/linux-6.6.y
> in order to address CVE-2024-46701:
> 
>    https://nvd.nist.gov/vuln/detail/CVE-2024-46701
> 
> As applied to origin/linux-6.6.y, this series passes fstests and the
> git regression suite.
> 
> Before officially requesting that stable@ merge this series, I'd
> like to provide an opportunity for community review of the backport
> patches.
> 
> You can also find them them in the "nfsd-6.6.y" branch in
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/cel/linux.git
> 
> Chuck Lever (10):
>    libfs: Re-arrange locking in offset_iterate_dir()
>    libfs: Define a minimum directory offset
>    libfs: Add simple_offset_empty()
>    libfs: Fix simple_offset_rename_exchange()
>    libfs: Add simple_offset_rename() API
>    shmem: Fix shmem_rename2()
>    libfs: Return ENOSPC when the directory offset range is exhausted
>    Revert "libfs: Add simple_offset_empty()"
>    libfs: Replace simple_offset end-of-directory detection
>    libfs: Use d_children list to iterate simple_offset directories
> 
>   fs/libfs.c         | 177 +++++++++++++++++++++++++++++++++------------
>   include/linux/fs.h |   2 +
>   mm/shmem.c         |   3 +-
>   3 files changed, 134 insertions(+), 48 deletions(-)
> 

I've heard no objections or other comments. Greg, Sasha, shall we
proceed with merging this patch series into v6.6 ?


-- 
Chuck Lever

