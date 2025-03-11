Return-Path: <linux-fsdevel+bounces-43735-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6551FA5CF94
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 20:40:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4025189D377
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Mar 2025 19:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6E2F2641F4;
	Tue, 11 Mar 2025 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="NA73pWjR";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Q2WrVww8"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F522217719
	for <linux-fsdevel@vger.kernel.org>; Tue, 11 Mar 2025 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741721994; cv=fail; b=AuMy+IQkbWSjFBqxMfv4WAA+39vKwgRVeUwxAgj6cSkGw0wmTn/ckgyecEZyHKey8f++HFxnoglltny/YLAt3k9EfnuRO8/XCG9tf3ScV6CLRa+4XRWwe+B25HFTiHoOBBjWWxDm53b3n1fMBQ/5FFt586YE0PBiIIohoKGwbQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741721994; c=relaxed/simple;
	bh=216Kcu8O+ZxCc4JYZ63Cw2jvO07hEwTurxdldfvXPuo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fr1x7YvNu1/yycoIqqsLPJDUFWZGXBRMoS4MS7X5AMq5PF4IM+l2tl0FkZFIhZBfgzSU/BSgBNdu0TnoVojEfuKK3lGJAOQoo7OyEadps4H0kF9OnC9kT0Aw9bnHG5x8R6djnRkqE9KiTerbHZg8i24zbp/4MhMGuN4ELleFNq4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=NA73pWjR; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Q2WrVww8; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52BJMld5018167;
	Tue, 11 Mar 2025 19:39:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=+ouS0cMi7dwKmV9y4Zc/aVj/DyH/uZPqZ87cqiTh6oo=; b=
	NA73pWjRjIqJHyjvgwDJsJBdSv/JGHsmn6lm4grxrhrf+yH44CzBfZFTSZvmGF02
	A1j9pWsfV2csiOHmtaFbXANpn8gNUVqlyNJRQ42HmyPSmlaIMREcjRG/S4rJSuqh
	k5f6sMhI4JBM01x9oG2mjUOehY/IhFsRdYif5PGec21jxnBPBZcLj78HDKjFGRUU
	Wfl80Elcuuxei6Z2YPCthKl9P0/W7nfYFuEwGHvOMhg7frvf4byBd35VJ9g+NfIL
	Co0F+EHe67hiNmDIJ70Mv2sWF0vZjTtt9aEC2X+aJOM8jXrTcrL6odfbNMcopqpD
	d28gKvKxfQUyqUyoQhxTjw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4cr1y9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 19:39:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52BIdqjs002391;
	Tue, 11 Mar 2025 19:39:37 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1nam02lp2046.outbound.protection.outlook.com [104.47.57.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn6aq3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 19:39:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApMqrOeTyMrW456K3FR2EdOHr3ptEysUXSYSJxiZZ5HAh+5/QV7tMOD44MaX1eptlUzlu5vJgN4EkN45U6nKTBSvck+byRBNjdSj+TgW0PevGWPSEqdfFVAA2mJqAI1zMJjk3PDXzsrC3LuNmbwsf/Mh4erduPq2z5YoFO5mm8ABZC/hJDPN7aENWkdXkXCJcWHyTqgReDG1EzERSOIg8JnpMwOEsBI5LxNClNYfi3YkjC7xzYHjYXfwOnomWx04T0gqTFs2tpcoBiTEOq7kaWRpwX14p5H+WC+fYEmNjEycEJxYvqDUWYcq8zb24K89CQWJjTSl8ih3cKa7a6kXAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ouS0cMi7dwKmV9y4Zc/aVj/DyH/uZPqZ87cqiTh6oo=;
 b=DHLKeJEdVGpuBFVlKB14s5ty4nqGE+ZpNUuX0+z298xsrlDzkIzD1ZF0W22gf9Bwsbgg3AHIU/0vCoV0IB6Lvis92mp2YmQsW9wQDo2H4n/gKK2BDMpUpy/yZPm686ndtlf2IJq2dLRb4tQKIVvGfbQLCOTbK2Sh6Jy17DlMvWgG/EJbBjd2/psUJgzKRJEd9/yw4Hq0dVvscS5FLRY9y0+SykFGZ9HVEROvqhHGzwBgdS8TD0qwZ/nrhRoEArBB6HPgyTsNZF6aSAXmujnBR4unPGT5ea7Ndu3FhJv6MLKkvMcaIZ6M/chvwrPfE3gJgErnOA5fjRewLAq5uh+YZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ouS0cMi7dwKmV9y4Zc/aVj/DyH/uZPqZ87cqiTh6oo=;
 b=Q2WrVww8mblvDyF2Kr4fyi5ZlEwdjAiGMZeJ8SV+rANd5eHPeirzodUgSpjgztPT3B7a9oPuSTGgAhVR7eqevHnRkAk1QcvYQSSSBFbHXjCIE55SsD8ORYmjgNHqCoPLqH+9rhcKoK1WbYDYt9fvNNeqgdwBX/2UPAy6d07EhY8=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by PH7PR10MB6204.namprd10.prod.outlook.com (2603:10b6:510:1f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Tue, 11 Mar
 2025 19:39:34 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8511.026; Tue, 11 Mar 2025
 19:39:34 +0000
Message-ID: <d0dc742a-7373-4e1e-9af4-d7414b1d3f4e@oracle.com>
Date: Tue, 11 Mar 2025 15:39:32 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Revert "libfs: Use d_children list to iterate
 simple_offset directories"
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: Sun Yongjian <sunyongjian1@huawei.com>, linux-fsdevel@vger.kernel.org,
        yangerkun@huawei.com
References: <2025022621-worshiper-turtle-6eb1@gregkh>
 <a2e5de22-f5d1-4f99-ab37-93343b5c68b1@oracle.com>
 <2025022612-stratus-theology-de3c@gregkh>
 <ca00f758-2028-49da-a2fe-c8c4c2b2cefd@oracle.com>
 <2025031039-gander-stamina-4bb6@gregkh>
 <d61acb5f-118e-4589-978c-1107d307d9b5@oracle.com>
 <691e95db-112e-4276-9de4-03a383ff4bfe@huawei.com>
 <f73e4e72-c46d-499b-a5d6-bf469331d496@oracle.com>
 <20250311181139.GC2803730@frogsfrogsfrogs>
 <2fd09a27-dc67-4622-9327-a81e541f4935@oracle.com>
 <20250311185246.GD89034@frogsfrogsfrogs>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20250311185246.GD89034@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH2PR18CA0008.namprd18.prod.outlook.com
 (2603:10b6:610:4f::18) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|PH7PR10MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: dfa7fe6d-a557-4975-fc53-08dd60d4735d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aXNyRk02aysydU5oV0VQS2JXQm16c25GcUJhR1FEdXJpemIva0xzY2xjZCtQ?=
 =?utf-8?B?aDNBeTZldnRuS3B2OVFOMzFZUXR1NTh6TWVxcDE1cTJMdTA2VEVYQ0dwVzgv?=
 =?utf-8?B?TWxDTXFRVUNHQkVsQ1NWR2dTWHQrMU5hakJRdGJZdGJyUWhOZDNmRVlwVVFV?=
 =?utf-8?B?QWlRWDNNTVlxYVhEaFB5S3BieFFkaGltU3k4dFlBd2NDRFA3cUIzK2JyRE1S?=
 =?utf-8?B?ZGxQaDBXdkRCaER0REJmRGtHUlduVkx0R2llb0szZUZ6NkR1dXN2SDF4RTZ4?=
 =?utf-8?B?SVFFVFZqWWlOU3dvZjVtUXhnbTFRVkVQMlZLSnREMUx4SGluWlY0d2ZQY2Nm?=
 =?utf-8?B?ZU9xZFY2RHBmYkE3SkZLZ3FQVXYrRlY1eWRFYlI5dzJyb29LQjd4RFFnMjZU?=
 =?utf-8?B?cGVOK0hpVTA2Rk1aWWJXZlduVFcxdlp3c2V6bjAzVWlsSnEvd2RLNklvMHph?=
 =?utf-8?B?OFhWOHFJWnJJUVV4ZGRiTjlaaS9DbE9MaHA0aVFnUnlwYVdzV2Z0OERnZ0J3?=
 =?utf-8?B?NzZEdlNObUdiNm40WEJtaURudEhIWUhpbGMvZnRESDd1UDNlL1RGRWpic2tj?=
 =?utf-8?B?dnViSGxpRjl4NW94ZmEvZjNSdGlFaDliL09IbWIweXluNjhPNUNjL291NVl2?=
 =?utf-8?B?QW5yWnB3UVdKcEpzUG1COWE3c3Q4V1JOcHkyV2NIN2RMQjlnOVBDSHd1SHJz?=
 =?utf-8?B?emx1ZEJqcEUxSW8weVc3ZWgycHUrK25UY0VQUTUyWlpTTlUxeEFieXY3aHRj?=
 =?utf-8?B?cFVuS3BOU0x0WnhaUFRpV1dtYm1vYUpZSXJlWTAvNHF4bTZZcmJlWTJwZTJ2?=
 =?utf-8?B?bXA1aUlDZkZqTFJRZlJtUVFwT1I4bDRVU2F4NVZPQ0tQR2VzV3pKV3E4TnRP?=
 =?utf-8?B?ZlRBVW9mZ2hjWlRuKzM5WlZjWVh6Z3FpYlE4d3gvVHBXc1VrNENhWFo4NnpI?=
 =?utf-8?B?ZDdCTTc0Und1ajJ2enp0RGo0UnZ2ZDFLeEdtZkFoT0twb3JFNGlobVRqa1My?=
 =?utf-8?B?YmkyOWZ0RFp4VmZNUWlNTkE0eUVYY1QvYW9tbVcxajJoZXFaOFlZUUhQZ1Zh?=
 =?utf-8?B?UUQ0UUZjc0dTZUYraVNqcUlWVXlhWk9tdmtKdWdQNnFVSU1TcngyTGgrbGNY?=
 =?utf-8?B?R0MvdW9IZ2RQVmw0VmkwejdLUi9RZGpIYjdlckZ0UU1vZGdkUDlTWmhRK3E5?=
 =?utf-8?B?bDc3OXdhWkhWZ3lqaW42ZGZLeU5zK1grV0FtbmVQTSs2T0VVQnVCQkwzUjhs?=
 =?utf-8?B?UU9ZZDRCSHZmdFFmRFpzWmVDSWtKL01RZE5oYUM3VzVSaWJscVprd0RWbm0v?=
 =?utf-8?B?Zi9wY3FCN3dmajFVMlZaTlRsSDJTbFcwY1Z1RllDQ2Qzdm14Q0c2V1oxMXdF?=
 =?utf-8?B?RjM5M1U4Y3VVdnhCaERRaDJrNVRiK0RkblNpTWorSUluQjFUbXg5Y3lQZStL?=
 =?utf-8?B?bzA3N09LTW9sdm12V1F3K1Fkamg1eVNKQkpiem1UWDlma3Q2VExjUVNhak5Q?=
 =?utf-8?B?WXgzbTZKMlZsTmxDUHZtWDEydFE3cDJ4eU5PckY4V2cxdkhVTFlYRml2UDg4?=
 =?utf-8?B?Ry8zaHVUL0M5dUlGbWh2TERIWnk4cWFMaU1DMkUyajc5ZHNnWVl0ZHRoMXFK?=
 =?utf-8?B?WTJMK0tBNm9jdUZleXdYUjJrOUI2R1J4ZVNUSXE4dnZLejlxMGplRGRZSTN5?=
 =?utf-8?B?c0ZLRzZoZWZZZUNVSHJSeWNIWE96NGk3d0ZISm4xbEJRSC8xdjllakp5aDla?=
 =?utf-8?B?MG5TN1NEZmR6U2E5d00ydm1NL2hPU1dWajdsN1ZMc0lKblZKcTYweThoZWFk?=
 =?utf-8?B?VEZuYTFFbXFrVzJXQVY2Zz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MW9vbm51QmVwU3pJdmNmVTF6S1hIOEZIeHU2SXFPbHM3amhQSWkveWFPNjhI?=
 =?utf-8?B?UUNNQmVsd045L2pUb0hjMXpjZk5kdnYvSEV4TEN5SmVYUEJRTk1GTnU4ZHd2?=
 =?utf-8?B?QnVjbVZwaElNdTd4Ymt5cGdwTDJ2cmtoL05Vb2ExRTBLQlNxL09ZWTV5aWdv?=
 =?utf-8?B?NDlkMFVUNEtxMTl4RHhta2d6NC9GWVhIbXR4ZVVoQzZSOW5QMzZOQWQ0emxy?=
 =?utf-8?B?U2JVbWdvNEpBc2gxb1Q1K2lwWG0vNWhOa1laWStVMWJxUFkybGpocWYwN0dY?=
 =?utf-8?B?WDY4L09MNFBzdXFYK1dHUytMNlcwNU5yTnNsUk1hWTBQSTVOS2cxODlMOVJ4?=
 =?utf-8?B?Yk43TlRPY0h5NEpZdGkyUUhWWlpJTDVEb29HeElyMWtvdFpsUzVwMmRoUjU1?=
 =?utf-8?B?MTVYVjNteUNmUEZxWUY2QVUvdkVsa29PQ2FDZzA1QjFVcFpJemRUbk04aWRu?=
 =?utf-8?B?Y3pUOEg3dWN5N3JQeEFFV3dsNGVTa1hKdDB3WkJIOGs0NnJHRU9LbWR5c2d6?=
 =?utf-8?B?ejRVcnUvUGtJWnlvOEZYY1U0MmVvcGZha2tDN3czKzZIV2gzNFJOSzlWZXlz?=
 =?utf-8?B?WGVPTzF2NzczYmhjeW9lTjkySW1pSkh2VlFSQ2VZbi9aS3lackVsQWNpVVp3?=
 =?utf-8?B?anR5ajhrakJMSCtKRmNYTTFodmV5M24xMDZRWHRySEtJcmNGajkvekZ0UVd5?=
 =?utf-8?B?dGplSmdpdHBMZCtEeUsxSWt0VGpreksveTNvbjlWV3lCR2IwaEdLUmxPcERD?=
 =?utf-8?B?dzBQWmFUV2hyV2xZVEF6MXRvTlJ5ZDhwYm9HZU1Ia0dMYzh4dUlUL09pM0pW?=
 =?utf-8?B?bE1vYU5TazliRGhPT3YxMWJUU1FqZE5zZkRubnJOc3FVMC9wbGpkWVdiczVa?=
 =?utf-8?B?SVJNVk5QZnlNaDNjeHM1VHpUS0hNT2pKZXJhenJKM1lsR2l2R0llRDhrN3ll?=
 =?utf-8?B?QWhUTzBHcDA5aUJSVSt4Tlpmd2dYSWtNeU9zVEFQaWJid0dNSU8vV1BWcHRO?=
 =?utf-8?B?OW8xY0NvMjk2R2dDTGFZTEV1OW1VSFlRRlVQbzBaU2E4TW5RUlhLUXQ5UjBx?=
 =?utf-8?B?eUVMc0E5cUhQMHdidTVCWmVINjdycmVQR243ZUlXekR6STYzVUY1NURuMUJN?=
 =?utf-8?B?SGhnRWNRQ3loM0tudU5DdXJDak9Tby9oWGFpVWh3NEtQbFJja245YUQyVWdL?=
 =?utf-8?B?TlpLQ3pUeWp1QnlCSkU3RVpIRlZPWXRKUFB5a2RFZ3dQVWVocSs4UlgrQUl0?=
 =?utf-8?B?TVcvbnJDUklncWRmdEFTS2hEOHdPcWo1M3RuMXA3Tmwvc0FsUkRTdjRTMXNK?=
 =?utf-8?B?bGFNalBqVmJMc0s3VFNkbWNqN0F3azRjYWFWeEhmYS9xeWhqWXFBUm14NjBk?=
 =?utf-8?B?NDJlcjlJWG1rNjBwSUpiQ2V3eVhGTy8wd3QySTZXMTlXTHA1c0Z0K2NXS1oy?=
 =?utf-8?B?a29DR2ZOOXF6TWduQldLYVZZU2Y1Mm5rU0w0Z0o5RElDSm5ERFhKZGpXcFh5?=
 =?utf-8?B?aDdQak5WWm1CSS9aNjd3Y3FpVW1ValJqOWlyWTQwZzRvRFE2RjRYK01EZVc1?=
 =?utf-8?B?ei9KMnd0YWNwRFBZaGpEZE9pNGhCZHlyMHpwUUJJMTRvU3EzVnZ0N0RIZWd3?=
 =?utf-8?B?NTFpdUU0UUFQb2R5TklFOWYzQjhrWDJhVGU1RXcvSGtlTGRHVytCTE9BOEVu?=
 =?utf-8?B?dlNOOGt3TzdIRmRGdDhzVVZYKzh3RXRLU2xPdzNTYkJ2eUFXVUwzQzl4SGtO?=
 =?utf-8?B?dklPRythRERaRFFqbXlDdEpGT2x6djRuV3lTZnB5cGd6U0E3WWVQblZvL3BG?=
 =?utf-8?B?YzRUcWZaTHJUZ2t6Y25PRXBkZ3dUVy9jdkRhWWxZWm85d1lqVEJ6VUI2dVp6?=
 =?utf-8?B?NTN1T3VtYmNFMTRDaENxL0dDQndrYUJEQmtmWkR3OThxWjhvZzMrNEM0dG9F?=
 =?utf-8?B?TFM1VEpjdkJJYWw4MnFYT2pMWWhrVUg2K0Rjc1kwL0RhQTNxblg2RTNkaWtw?=
 =?utf-8?B?QWl1aXhpZ1RNT1lyWm5GbTc1L2Y1UGlBS2JsTG9jY0xxUjFmako3bjhpSjdv?=
 =?utf-8?B?U3NvVjF0QzRSMC8zNks5QVFENTFqM0IyVVBGd2NMWENwajVUQytRMVVZeHJr?=
 =?utf-8?Q?iPuD7LmNfMXXxBYsHc9Giuafp?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+3+SO0CWfYW3TGHmMszzLNriGXYSWbxuIoumNIwKH/iiKM+mZMj+Oey00lv2syclHEnB8ksiztfM2AsOZlEj2tRFoD1lSupV1z8S06+07UbAm+sJRZqFDkxr+Ki6IME3L5R+o1Iwe1QERH/HrTG0LmzbTq5bPiVb8Lo1XFqXfoVbNeht6M6JZTm0LSU1Lq6dJoZEVRAF/iOkrBrWOG5FkcKH8fqwiNMpL/l+J7ZAnbg9dmJU33EPhESk1Y6KzSiV8xjU/MPLF2hohwTu/yu6IQ+vEWZIcoykjXLDog/+pE7cIEdOF1P31riF4PMoBmqMi0QDywqQq6VLtwiMtpV0adCiHE3xnSV5trG/vX29h1oVnH14FMARlWXf2SeYm4d1RUXddIeCdtzKY2dbkywDnshaG/W8AkuPdpdlCehdPENLiiOr/kk7PLKJLQAa+DUssAgeJNTV1iYjeZrXMCeC7sBDTc8KM36x7/6IU1YPgudQF2pA6EcXO9GsvX7pXMR4c3AbS7VgKGcY64qp9MggMqVPpT7MW8lDzAOlfvc5AzCrJuLaz2UWQOwpW45F2ktZau9QvT6HvbrECMmMNWb/VRFO2gaU1/AIfXCisFkKCMc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfa7fe6d-a557-4975-fc53-08dd60d4735d
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2025 19:39:34.2695
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l09Qald+GzPo1uRA8V5EUmtc/0FK2q1wY1hgdTwUmjW0cg/f3pLZ2zEkg49P3DqV1n567qadndfMsoTbePCyeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6204
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_05,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503110126
X-Proofpoint-ORIG-GUID: wSk3CoxtyZ4AJpl1dbGfOobnf_Mk5m1u
X-Proofpoint-GUID: wSk3CoxtyZ4AJpl1dbGfOobnf_Mk5m1u

On 3/11/25 2:52 PM, Darrick J. Wong wrote:
> On Tue, Mar 11, 2025 at 02:25:14PM -0400, Chuck Lever wrote:
>> On 3/11/25 2:11 PM, Darrick J. Wong wrote:
>>> On Tue, Mar 11, 2025 at 11:23:04AM -0400, Chuck Lever wrote:
>>>> On 3/11/25 9:55 AM, Sun Yongjian wrote:
>>>>>
>>>>>
>>>>> 在 2025/3/11 1:30, Chuck Lever 写道:
>>>>>> On 3/10/25 12:29 PM, Greg Kroah-Hartman wrote:
>>>>>>> On Wed, Feb 26, 2025 at 03:33:56PM -0500, Chuck Lever wrote:
>>>>>>>> On 2/26/25 2:13 PM, Greg Kroah-Hartman wrote:
>>>>>>>>> On Wed, Feb 26, 2025 at 11:28:35AM -0500, Chuck Lever wrote:
>>>>>>>>>> On 2/26/25 11:21 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>>> On Wed, Feb 26, 2025 at 10:57:48AM -0500, Chuck Lever wrote:
>>>>>>>>>>>> On 2/26/25 9:29 AM, Greg Kroah-Hartman wrote:
>>>>>>>>>>>>> This reverts commit b9b588f22a0c049a14885399e27625635ae6ef91.
>>>>>>>>>>>>>
>>>>>>>>>>>>> There are reports of this commit breaking Chrome's rendering
>>>>>>>>>>>>> mode.  As
>>>>>>>>>>>>> no one seems to want to do a root-cause, let's just revert it
>>>>>>>>>>>>> for now as
>>>>>>>>>>>>> it is affecting people using the latest release as well as the
>>>>>>>>>>>>> stable
>>>>>>>>>>>>> kernels that it has been backported to.
>>>>>>>>>>>>
>>>>>>>>>>>> NACK. This re-introduces a CVE.
>>>>>>>>>>>
>>>>>>>>>>> As I said elsewhere, when a commit that is assigned a CVE is
>>>>>>>>>>> reverted,
>>>>>>>>>>> then the CVE gets revoked.  But I don't see this commit being
>>>>>>>>>>> assigned
>>>>>>>>>>> to a CVE, so what CVE specifically are you referring to?
>>>>>>>>>>
>>>>>>>>>> https://nvd.nist.gov/vuln/detail/CVE-2024-46701
>>>>>>>>>
>>>>>>>>> That refers to commit 64a7ce76fb90 ("libfs: fix infinite directory
>>>>>>>>> reads
>>>>>>>>> for offset dir"), which showed up in 6.11 (and only backported to
>>>>>>>>> 6.10.7
>>>>>>>>> (which is long end-of-life).  Commit b9b588f22a0c ("libfs: Use
>>>>>>>>> d_children list to iterate simple_offset directories") is in 6.14-rc1
>>>>>>>>> and has been backported to 6.6.75, 6.12.12, and 6.13.1.
>>>>>>>>>
>>>>>>>>> I don't understand the interaction here, sorry.
>>>>>>>>
>>>>>>>> Commit 64a7ce76fb90 is an attempt to fix the infinite loop, but can
>>>>>>>> not be applied to kernels before 0e4a862174f2 ("libfs: Convert simple
>>>>>>>> directory offsets to use a Maple Tree"), even though those kernels also
>>>>>>>> suffer from the looping symptoms described in the CVE.
>>>>>>>>
>>>>>>>> There was significant controversy (which you responded to) when Yu Kuai
>>>>>>>> <yukuai3@huawei.com> attempted a backport of 64a7ce76fb90 to address
>>>>>>>> this CVE in v6.6 by first applying all upstream mtree patches to v6.6.
>>>>>>>> That backport was roundly rejected by Liam and Lorenzo.
>>>>>>>>
>>>>>>>> Commit b9b588f22a0c is a second attempt to fix the infinite loop
>>>>>>>> problem
>>>>>>>> that does not depend on having a working Maple tree implementation.
>>>>>>>> b9b588f22a0c is a fix that can work properly with the older xarray
>>>>>>>> mechanism that 0e4a862174f2 replaced, so it can be backported (with
>>>>>>>> certain adjustments) to kernels before 0e4a862174f2.
>>>>>>>>
>>>>>>>> Note that as part of the series where b9b588f22a0c was applied,
>>>>>>>> 64a7ce76fb90 is reverted (v6.10 and forward). Reverting b9b588f22a0c
>>>>>>>> leaves LTS kernels from v6.6 forward with the infinite loop problem
>>>>>>>> unfixed entirely because 64a7ce76fb90 has also now been reverted.
>>>>>>>>
>>>>>>>>
>>>>>>>>>> The guideline that "regressions are more important than CVEs" is
>>>>>>>>>> interesting. I hadn't heard that before.
>>>>>>>>>
>>>>>>>>> CVEs should not be relevant for development given that we create 10-11
>>>>>>>>> of them a day.  Treat them like any other public bug list please.
>>>>>>>>>
>>>>>>>>> But again, I don't understand how reverting this commit relates to the
>>>>>>>>> CVE id you pointed at, what am I missing?
>>>>>>>>>
>>>>>>>>>> Still, it seems like we haven't had a chance to actually work on this
>>>>>>>>>> issue yet. It could be corrected by a simple fix. Reverting seems
>>>>>>>>>> premature to me.
>>>>>>>>>
>>>>>>>>> I'll let that be up to the vfs maintainers, but I'd push for reverting
>>>>>>>>> first to fix the regression and then taking the time to find the real
>>>>>>>>> change going forward to make our user's lives easier.  Especially as I
>>>>>>>>> don't know who is working on that "simple fix" :)
>>>>>>>>
>>>>>>>> The issue is that we need the Chrome team to tell us what new system
>>>>>>>> behavior is causing Chrome to malfunction. None of us have expertise to
>>>>>>>> examine as complex an application as Chrome to nail the one small
>>>>>>>> change
>>>>>>>> that is causing the problem. This could even be a latent bug in Chrome.
>>>>>>>>
>>>>>>>> As soon as they have reviewed the bug and provided a simple reproducer,
>>>>>>>> I will start active triage.
>>>>>>>
>>>>>>> What ever happened with all of this?
>>>>>>
>>>>>> https://issuetracker.google.com/issues/396434686?pli=1
>>>>>>
>>>>>> The Chrome engineer chased this into the Mesa library, but since then
>>>>>> progress has slowed. We still don't know why GPU acceleration is not
>>>>>> being detected on certain devices.
>>>>>>
>>>>>>
>>>>> Hello,
>>>>>
>>>>>
>>>>> I recently conducted an experiment after applying the patch "libfs: Use
>>>>> d_children
>>>>>
>>>>> list to iterate simple_offset directories."  In a directory under tmpfs,
>>>>> I created 1026
>>>>>
>>>>> files using the following commands:
>>>>> for i in {1..1026}; do
>>>>>     echo "This is file $i" > /tmp/dir/file$i
>>>>> done
>>>>>
>>>>> When I use the ls to read the contents of the dir, I find that glibc
>>>>> performs two
>>>>>
>>>>> rounds of readdir calls due to the large number of files. The first
>>>>> readdir populates
>>>>>
>>>>> dirent with file1026 through file5, and the second readdir populates it
>>>>> with file4
>>>>>
>>>>> through file1, which are then returned to user space.
>>>>>
>>>>> If an unlink file4 operation is inserted between these two readdir
>>>>> calls, the second
>>>>>
>>>>> readdir will return file5, file3, file2, and file1, causing ls to
>>>>> display two instances of
>>>>>
>>>>> file5. However, if we replace mas_find with mas_find_rev in the
>>>>> offset_dir_lookup
>>>>>
>>>>> function, the results become normal.
>>>>>
>>>>> I'm not sure whether this experiment could shed light on a potential
>>>>> fix.
>>>>
>>>> Thanks for the report. Directory contents cached in glibc make this
>>>> stack more brittle than it needs to be, certainly. Your issue does
>>>> look like a bug that is related to the commit.
>>>>
>>>> We believe the GPU acceleration bug is related to directory order,
>>>> but I don't think libdrm is removing an entry from /dev/dri, so I
>>>> am a little skeptical this is the cause of the GPU acceleration issue
>>>> (could be wrong though).
>>>>
>>>> What I recommend you do is:
>>>>
>>>>  a. Create a full patch (with S-o-b) that replaces mas_find() with
>>>>     mas_find_rev() in offset_dir_lookup()
>>>>
>>>>  b. Construct a new fstests test that looks for this problem (and
>>>>     it would be good to investigate fstests to see if it already
>>>>     looks for this issue, but I bet it does not)
>>>>
>>>>  c. Run the full fstests suite against a kernel before and after you
>>>>     apply a. and confirm that the problem goes away and does not
>>>>     introduce new test failures when a. is applied
>>>>
>>>>  d. If all goes to plan, post a. to linux-fsdevel and linux-mm.
>>>
>>> Just to muddy the waters even more... I decided to look at /dev/block
>>> (my VMs don't have GPUs).  An old 6.13 kernel behaves like this:
>>>
>>> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
>>> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
>>> getdents64(3, [{d_ino=162, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
>>> {d_ino=1, d_off=3, d_reclen=24, d_type=DT_DIR, d_name=".."},
>>> {d_ino=394, d_off=5, d_reclen=24, d_type=DT_LNK, d_name="7:0"},
>>> {d_ino=398, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
>>> {d_ino=388, d_off=9, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
>>> {d_ino=391, d_off=11, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
>>> {d_ino=400, d_off=13, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
>>> {d_ino=402, d_off=15, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
>>> {d_ino=396, d_off=17, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
>>> {d_ino=392, d_off=19, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
>>> {d_ino=419, d_off=21, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
>>> {d_ino=415, d_off=23, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
>>> {d_ino=407, d_off=25, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
>>> {d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
>>> {d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
>>> {d_ino=458, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"}], 32768) = 384
>>>
>>> The loop driver loads before scsi, so it looks like the directory
>>> offsets are recorded in the order that block devices are created.
>>> Next, I create a file, and do this again:
>>>
>>> $ sudo touch /dev/block/fubar
>>> $ strace -s99 ...
>>> <snip>
>>> {d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
>>> {d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
>>> {d_ino=458, d_off=44, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
>>> {d_ino=945, d_off=45, d_reclen=32, d_type=DT_REG, d_name="fubar"}], 32768) = 416
>>>
>>> Note that the offset of "8:16" has changed from 30 to 44 even though we
>>> didn't touch it.  The new "fubar" entry gets offset 45.  That's not
>>> good, directory offsets are supposed to be stable as long as the entry
>>> isn't modified.  If someone called getdents with offset 31 at the same
>>> time, we'll return "8:16" a second time even though (AFAICT) nothing
>>> changed.
>>>
>>> Now I delete "fubar":
>>>
>>> $ sudo rm -f /dev/block/fubar
>>> $ strace -s99 ...
>>> <snip>
>>> {d_ino=411, d_off=27, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
>>> {d_ino=424, d_off=29, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
>>> {d_ino=458, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"}], 32768) = 384
>>>
>>> ...and curiously "8:16" has gone back to offset 30 even though I didn't
>>> touch that directory entry.
>>>
>>> Now let's go look at 6.14-rc6:
>>>
>>> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
>>> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
>>> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
>>> {d_ino=1, d_off=28, d_reclen=24, d_type=DT_DIR, d_name=".."},
>>> {d_ino=452, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
>>> {d_ino=424, d_off=22, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
>>> {d_ino=420, d_off=24, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
>>> {d_ino=416, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
>>> {d_ino=412, d_off=20, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
>>> {d_ino=408, d_off=12, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
>>> {d_ino=402, d_off=8, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
>>> {d_ino=400, d_off=14, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
>>> {d_ino=398, d_off=16, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
>>> {d_ino=396, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
>>> {d_ino=395, d_off=18, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
>>> {d_ino=392, d_off=10, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
>>> {d_ino=390, d_off=6, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
>>> {d_ino=389, d_off=2147483647, d_reclen=24, d_type=DT_LNK, d_name="7:0"}], 32768) = 384
>>>
>>> It's a little weird that the names are returned in reverse order of
>>> their creation, or so I gather from the names, module probe order, and
>>> inode numbers.  I /think/ this is a result of using d_first_child to find the
>>> first dirent, and then walking the sibling list, because new dentries
>>> are hlist_add_head'd to parent->d_children.
>>>
>>> But look at the offsets -- they wander all over the place.  You would
>>> think that they would be in decreasing order given that we're actually
>>> walking the dentries in reverse creation order.  But instead they wander
>>> around a lot: 2^31 -> 6 -> 10 -> 18 -> 7?
>>>
>>> It's also weird that ".." gets offset 28.  Usually the dot entries come
>>> first both as returned records and in d_off order.
>>>
>>> However -- the readdir cursor is set to d_off and copied to userspace so
>>> that the next readdir call can read it and restart iteration at that
>>> offset.  If, say, the getdents buffer was only large enough to get as
>>> far as "8:0", then the cursor position will be set to 30, and the next
>>> getdents call will restart at 30.  The other entries "8:32" to "7:1"
>>> will be skipped because their offsets are less than 30.  Curiously, the
>>> 6.13 code sets ctx->pos to dentry2offset() + 1, whereas 6.14 doesn't do
>>> the "+ 1".  I think this means "8:0" can be returned twice.
>>>
>>> Most C libraries pass in a large(ish) 32K buffer to getdents and the
>>> directories aren't typically that large so few people will notice this
>>> potential for skips.
>>>
>>> Now we add a file:
>>>
>>> $ sudo touch /dev/block/fubar
>>> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/  ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
>>> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80  fubar
>>> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
>>> {d_ino=1, d_off=47, d_reclen=24, d_type=DT_DIR, d_name=".."},
>>> {d_ino=948, d_off=28, d_reclen=32, d_type=DT_REG, d_name="fubar"},
>>> {d_ino=452, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
>>> {d_ino=424, d_off=22, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
>>> <snip>
>>>
>>> The dotdot entry has a different d_off now, which is strange because I
>>> /know/ I didn't move /dev/block around.
>>>
>>> So I can see two problems here: entries need to be returned in
>>> increasing d_off order which is key to correct iteration of a directory;
>>
>> I would agree, if POSIX made a statement like that. I haven't seen one
>> though (but that doesn't mean one doesn't exist).
> 
> They don't say it explicitly since posix_getdents doesn't return
> per-entry offsets, but they do say this:
> 
> "The posix_getdents() function shall start reading at the current file
> offset in the open file description associated with fildes. On
> successful return, the file offset shall be incremented to point to the
> directory entry immediately following the last entry whose information
> was returned in buf, or to point to end-of-file if there are no more
> directory entries."
> 
> https://pubs.opengroup.org/onlinepubs/9799919799.2024edition/functions/posix_getdents.html
> 
> To me that implies that the offsets are supposed to go upwards, not
> downwards.

It's not possible to guarantee that the next entry will have a higher
offset value.

Suppose the "New offset" value wraps. So the current directory entry
will have a offset that is close to U32_MAX, but the next created
directory entry will have an offset close to zero. In fact, new entries
will have a smaller offset value than "current" for quite some time.

The offset is a cookie, not a numeric value. It is simply something that
says "please start here when iteration continues". Think of it as a
hash -- it looks like a hexadecimal number, but has no other intrisic
meaning. (In fact, I think some Linux file systems do use a hash here
rather than a scalar integer).

An offset range of 1 - 2^63 essentially hides all these dependencies
by using a range that is so broad that it can never generate a repeating
offset during the lifetime of the universe. On platforms with 32-bit
long types, we do not have the luxury of choosing a range that wide.


> I just found that getdents64 does this:
> 
> 	if (buf.prev_reclen) {
> 		struct linux_dirent64 __user * lastdirent;
> 		typeof(lastdirent->d_off) d_off = buf.ctx.pos;
> 
> 		lastdirent = (void __user *) buf.current_dir - buf.prev_reclen;
> 		if (put_user(d_off, &lastdirent->d_off))
> 			error = -EFAULT;
> 		else
> 			error = count - buf.count;
> 	}
> 
> So offset_iterate_dir sets dir_context::pos to DIR_OFFSET_EOD when
> find_positive_dentry finds no more dentries, and then getdents sets the
> last dirent's d_off to _EOD.  That explains the 2^31 number.
> 
> The increasing d_off behavior might not be specified by POSIX, but if
> the iteration /did/ leave off at:
> 
> 	{d_ino=416, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
> 
> Then the next getdents would seek right past the older entries with
> smaller d_off numbers.  I think that makes it an important
> implementation detail.

Not sure what you're getting at here, but POSIX makes absolutely no
guarantee that d_off will always increase in value as an application
walks the directory. That's an impossible thing to guarantee given
the way d_off values are chosen (at entry creation time, not at
directory iteration time).


>>> and it might be the case that userspace is overly reliant on devtmpfs
>>> returning filenames order of increasing age.  Between 6.13 and 6.14 the
>>> mtree_alloc_cyclic in simple_offset_add doesn't look too much different
>>> other than range_hi being decreased to S32_MAX, but offset_iterate_dir
>>> clearly used to do by-offset lookups to return names in increasing d_off
>>> order.
>>>
>>> There's also still the weird problem of the dotdot offset changing, I
>>> can't tell if there's a defect in the maple tree or if someone actually
>>> /is/ moving things around behind my back -- udevadm monitor shows no
>>> activity when I touch and unlink 'fubar'.  In theory dir_emit_dots
>>> should have emitted a '..' entry with d_off==2 so I don't understand why
>>> the number changes at all.
>>
>> tmpfs itself should have completely stable directory offsets, since 6.6.
>> Once a directory entry is created, it's offset will not change -- it's
>> recorded in each dentry.
>>
>> If that isn't what you are observing, then /dev/block is probably using
>> something other than tmpfs... those offsets can certainly change when
>> the directory cursor is freed (ie, on closedir()). That might be the
>> case for devtmpfs, for example.
> 
> devtmpfs uses the same simple_offset_dir_operations that tmpfs does, and
> both exhibit the same backwards d_off behavior:

Fwiw the old pre-6.6 tmpfs behavior might also have exhibited the
backwards offset behavior. (I haven't confirmed this).

It walks down the children list in just the same manner as 6.14-rc does.


> $ mkdir /tmp/grok
> $ for ((i=0;i<10;i++)); do touch /tmp/grok/$i; done
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /tmp/grok/ ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)'
> 0  1  2  3  4  5  6  7  8  9
> getdents64(3, [{d_ino=230, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=12, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=240, d_off=11, d_reclen=24, d_type=DT_REG, d_name="9"},
> {d_ino=239, d_off=10, d_reclen=24, d_type=DT_REG, d_name="8"},
> {d_ino=238, d_off=9, d_reclen=24, d_type=DT_REG, d_name="7"},
> {d_ino=237, d_off=8, d_reclen=24, d_type=DT_REG, d_name="6"},
> {d_ino=236, d_off=7, d_reclen=24, d_type=DT_REG, d_name="5"},
> {d_ino=235, d_off=6, d_reclen=24, d_type=DT_REG, d_name="4"},
> {d_ino=234, d_off=5, d_reclen=24, d_type=DT_REG, d_name="3"},
> {d_ino=233, d_off=4, d_reclen=24, d_type=DT_REG, d_name="2"},
> {d_ino=232, d_off=3, d_reclen=24, d_type=DT_REG, d_name="1"},
> {d_ino=231, d_off=2147483647, d_reclen=24, d_type=DT_REG, d_name="0"}], 32768) = 288
> 
> Also, the entries are /not/ stable:
> 
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/ ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)' 
> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80
> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=22, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=1138, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=1125, d_off=24, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
> {d_ino=1092, d_off=20, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
> {d_ino=1072, d_off=28, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
> {d_ino=452, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
> {d_ino=412, d_off=12, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=402, d_off=8, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
> {d_ino=400, d_off=14, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
> {d_ino=398, d_off=16, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
> {d_ino=396, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
> {d_ino=395, d_off=18, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
> {d_ino=392, d_off=10, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
> {d_ino=390, d_off=6, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
> {d_ino=389, d_off=2147483647, d_reclen=24, d_type=DT_LNK, d_name="7:0"}], 32768) = 384
> 
> $ sudo touch /dev/block/fubar
> $ sudo touch /dev/block/z50
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/ ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)' 
> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80  fubar  z50
> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=85, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=1144, d_off=84, d_reclen=24, d_type=DT_REG, d_name="z50"},
> {d_ino=1143, d_off=22, d_reclen=32, d_type=DT_REG, d_name="fubar"},
> {d_ino=1138, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=1125, d_off=24, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
> {d_ino=1092, d_off=20, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
> {d_ino=1072, d_off=28, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
> {d_ino=452, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
> {d_ino=412, d_off=12, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=402, d_off=8, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
> {d_ino=400, d_off=14, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
> {d_ino=398, d_off=16, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
> {d_ino=396, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
> {d_ino=395, d_off=18, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
> {d_ino=392, d_off=10, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
> {d_ino=390, d_off=6, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
> {d_ino=389, d_off=2147483647, d_reclen=24, d_type=DT_LNK, d_name="7:0"}], 32768) = 440
> 
> $ sudo rm -f /dev/block/fubar
> $ strace -s99 -o /tmp/log -egetdents64 -vvvvvvv ls /dev/block/ ; cat /tmp/log | sed -e 's/}, /},\n/g' | grep -E '(d_off|d_name)' 
> 7:0  7:1  7:2  7:3  7:4  7:5  7:6  7:7  8:0  8:16  8:32  8:48  8:64  8:80  z50
> getdents64(3, [{d_ino=164, d_off=1, d_reclen=24, d_type=DT_DIR, d_name="."},
> {d_ino=1, d_off=85, d_reclen=24, d_type=DT_DIR, d_name=".."},
> {d_ino=1144, d_off=22, d_reclen=24, d_type=DT_REG, d_name="z50"},
> {d_ino=1138, d_off=26, d_reclen=24, d_type=DT_LNK, d_name="8:80"},
> {d_ino=1125, d_off=24, d_reclen=24, d_type=DT_LNK, d_name="8:48"},
> {d_ino=1092, d_off=20, d_reclen=24, d_type=DT_LNK, d_name="8:0"},
> {d_ino=1072, d_off=28, d_reclen=24, d_type=DT_LNK, d_name="8:64"},
> {d_ino=452, d_off=30, d_reclen=24, d_type=DT_LNK, d_name="8:16"},
> {d_ino=412, d_off=12, d_reclen=24, d_type=DT_LNK, d_name="8:32"},
> {d_ino=402, d_off=8, d_reclen=24, d_type=DT_LNK, d_name="7:6"},
> {d_ino=400, d_off=14, d_reclen=24, d_type=DT_LNK, d_name="7:7"},
> {d_ino=398, d_off=16, d_reclen=24, d_type=DT_LNK, d_name="7:5"},
> {d_ino=396, d_off=7, d_reclen=24, d_type=DT_LNK, d_name="7:4"},
> {d_ino=395, d_off=18, d_reclen=24, d_type=DT_LNK, d_name="7:3"},
> {d_ino=392, d_off=10, d_reclen=24, d_type=DT_LNK, d_name="7:2"},
> {d_ino=390, d_off=6, d_reclen=24, d_type=DT_LNK, d_name="7:1"},
> {d_ino=389, d_off=2147483647, d_reclen=24, d_type=DT_LNK, d_name="7:0"}], 32768) = 408
> 
> Notice that "z50"'s d_off changed from 84 to 22 when we removed fubar.

d_off is not the offset of the /current/ entry, it's the offset of the
/next/ entry. It's the value that the application is supposed to
pass to readdir/getdents after reading this entry to get the /next/
entry to return.

getdents(2) sez:

       The linux_dirent structure is declared as follows:

           struct linux_dirent {
               unsigned long  d_ino;     /* Inode number */
               unsigned long  d_off;     /* Offset to next linux_dirent */
               unsigned short d_reclen;  /* Length of this linux_dirent */

Note well the comment after the d_off field declaration.

Moreover, the only d_off value applications should care about is the one
in the last entry returned in the buffer, because that's the only value
that is passed to the next readdir() call.

So, yes, if you have a directory with only entry A and entry B, and you
readdir from the beginning of the directory and get:

d_name: A, d_off: 5
d_name: B, d_off: 2^31

then you delete B, a second readdir from the beginning of the directory
should return:

d_name: A, d_off: 2^31.

Yes, it's confusing as hell.

So we can guarantee only a few things:

* each entry in a directory has a unique offset value;

* readdir(X) will always start iterating at the same entry as long as
the entry with offset X has not been unlinked; and

* directory iteration does not return entries that were created /after/
the directory file descriptor was opened. To see those entries, the
application has to close the descriptor and open a new one, or it has to
rewind the descriptor.

And as I stated before, I don't believe that entry removal is in play
for the OP: device directory entries are created just after system boot
and remain in place as long as the devices have not been unplugged.


-- 
Chuck Lever

