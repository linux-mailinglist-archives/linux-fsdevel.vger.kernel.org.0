Return-Path: <linux-fsdevel+bounces-50915-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BCAAD0EDB
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 20:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63F8116C316
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Jun 2025 18:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D249820487E;
	Sat,  7 Jun 2025 18:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ArcVAVGz";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YCt96kFT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C7CAFC08;
	Sat,  7 Jun 2025 18:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749321045; cv=fail; b=aeD6hM96cm6eJpfUR/8WS8OHK6W47rtZ0H1XZm0cunTgskLwGqIFrIHhL8hJ+e9+WLgFIQc1gI0BpEAjLtia7Dt3gkz4/7BqAwDrqVueWmuYpkpAypYMVyhxc691ibBSTl/2ZyzcuEQDQ1YNqEoTLb3QEf3XRzjebD3rpAQX1EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749321045; c=relaxed/simple;
	bh=wHGl81ujKhEFP9aZxY08D9zSnN+Xf+UTeHqJ2AqfIck=;
	h=Message-ID:Date:Subject:To:References:From:Cc:In-Reply-To:
	 Content-Type:MIME-Version; b=qmJzvYnUFAdGUPxUaXz6UeY64gI9M6toz8kxINE7xb8JPG7FGh50NdfZGOmwGewlNI/FqdRr1B3sltcgtObu2Wz+L1MmMXcPyUngsohIQAMVEEHpqVOXBxLtoLsP4ToUwA9Daw/Ux9Hlj65IZDLPkWrv5BDbgWgtlo8ZN/zZQys=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ArcVAVGz; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YCt96kFT; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 557HZ19G014892;
	Sat, 7 Jun 2025 18:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Dc9m/gO7QA0uOHqF2sTb0YjhgGCjrx7nfJAQd6g6Qo4=; b=
	ArcVAVGzsGFzJG810JS1H0/P4Y/KIjIn4lzbmk4FBEoactuX5XXjug87L0pBPkOY
	GBqZtrYyNevPIfclzfTXp0awxWN7KZm4cToEMfrF6FTHguT4jgtQQvMnWk+PSRLY
	aR5hgwU07SUlsa5H4cILEBlIWEcQezx53eVlUwReMGhrPuU6l4b8WQwWg5OPD+3y
	6HW9fe+OF8citks58Ky/FgyxIESAv8xIb4AIReHS9E9/zWU2te0/BpgPUphmJ3hq
	co+ivfA00oFcSLKuc7TpnAiIPrIix4qvGuKZJxw/8q35zyFIgnCmMa2KVF3rfUu1
	qIYuStFXwQanlgt5NNRU4Q==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 474dywrcps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Jun 2025 18:30:41 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 557IMCUI011804;
	Sat, 7 Jun 2025 18:30:40 GMT
Received: from sj2pr03cu002.outbound.protection.outlook.com (mail-westusazon11013017.outbound.protection.outlook.com [52.101.44.17])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 474bv75fab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 07 Jun 2025 18:30:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VVe73oBOmWIb5YKzXnU7OO+5WPnt1cer3vPESUHPq/yN+oq/Kay4ERByzSg7o5S7MWbTFL+zR5pPo8kOmYMVhr77JinD0DvHMU7hxG7cueAws2F4LO5FiayKRDZ5ttNttbIg4Q4fy/0wwlbN27rgR5MV1rDVlYTUCx6Aj0NxsdmrvPdQZSayp3cwDqYQuj6buB3afGWGL0UcwzH9ryr4gU9yspk1mndKODNo3VNik2ZfISKQi6EIfKlv3pFjcx9fGJPBBwIsi8Vk6v9vz3B9m/Sa52Ws4rx4ib5I0c2DwVpy1sw/vWWc4W9EIMfAlVD05x0iWLbKp/bW1T/Cc0iMag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dc9m/gO7QA0uOHqF2sTb0YjhgGCjrx7nfJAQd6g6Qo4=;
 b=TCOLU8wKXKToj/ch5HUBu+n6mYA0nqILtFyk0Qsu7W9OfVRzzVQ20TNmskcTM/9m1v+KDGrAJyViYLgwv8Wr0zBF2AU+U9yyZcIw4o/cTxLTLytyCQRd10ubN4rWnWVgf96y+n9N3mACWzh0AFw1kyz9BqqlaP1zfYz492PrN2MHQbVNI1bQ93/XPmJTJgLUPVUYRrQ7rs+tinVskbTUM/aqfGTS2XQuzsF/xYA0U358eOH88Q9BtfDyHB9IdL4NKeN39QDYEooOXyZ4YRuYfKUftZC8bvpOxOByRmEFwDfSf4E113iofQDEHtS5Kbtxfyg9lJTB2WIkV003MAJhDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dc9m/gO7QA0uOHqF2sTb0YjhgGCjrx7nfJAQd6g6Qo4=;
 b=YCt96kFTYtAohCl9r525XqLyRT/soxPnjnpr+aS5cuLKexQNXPfKMpMCjsLGWH9ICINK/LInr2ix4x0eu0z9hIbHt9FijviHErNRTZLqZm8eF8PZdBxuCMCNSn3KRoS9cDyNlbWtRypp4s/qegyD7s/iBZdRA2VYn2A53wCAHZQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by IA1PR10MB8211.namprd10.prod.outlook.com (2603:10b6:208:463::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.22; Sat, 7 Jun
 2025 18:30:38 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.8813.020; Sat, 7 Jun 2025
 18:30:38 +0000
Message-ID: <44250631-2b70-4ce8-b513-a632e70704ed@oracle.com>
Date: Sat, 7 Jun 2025 14:30:37 -0400
User-Agent: Mozilla Thunderbird
Subject: Re: LInux NFSv4.1 client and server- case insensitive filesystems
 supported?
To: Cedric Blancher <cedric.blancher@gmail.com>
References: <CALXu0Ufzm66Ors3aBBrua0-8bvwqo-=RCmiK1yof9mMUxyEmCQ@mail.gmail.com>
 <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
Cc: Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
In-Reply-To: <CALXu0Ufgv7RK7gDOK53MJsD+7x4f0+BYYwo2xNXidigxLDeuMg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR04CA0101.namprd04.prod.outlook.com
 (2603:10b6:610:75::16) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|IA1PR10MB8211:EE_
X-MS-Office365-Filtering-Correlation-Id: d94799a4-30f3-4906-bdf5-08dda5f166cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L29icXZWNXd6cm03VEN5QVZwbkxJK3pFRjZ3T2lrK2MrQ0pjUEdxcDJiaGow?=
 =?utf-8?B?NVJsei9Pbzcxb0huWTBRMWtxMnhFVzhJQjdQVkdab3RMUUFjVlJTZWtENHR4?=
 =?utf-8?B?Mmt4aWJadHlQSTc5R1lZdnNuSldjb0VHZG9tWUtiUVRRbHcxeW4rTVZ0K2VC?=
 =?utf-8?B?ODZWMHQ5WnpQZGdHbzJOaVNldkd4SWNFM3orU2ZFUk8xeldSUS9lTHIvRFds?=
 =?utf-8?B?REZqaUhOYlR5b3dSL1NPVkU5MzhGSnNEcmdEWitCTmM5WWJWWDh2YlRkajRR?=
 =?utf-8?B?dzBFcVY1NU1PK3hWd2xYY0IyRXU4ckxTS3RpLzB2WXpZQXJEL2JyMmd1bzJG?=
 =?utf-8?B?RWxwZjhmMDJRQzJ0K3drc213MlB2MlkwMjJXa2Vtc3dXZjhGc1pEWDRuTzUz?=
 =?utf-8?B?eDI3Ny80VWZ3SUdhTDc1b0ExMi9Mek5McjZMWVJRS1lQeEdCSFZWMm9SZXNP?=
 =?utf-8?B?QllCdkY2RDNZWHVESGY0ZjJIOGt4bFlHaEkxWXB0QWVaaFFISDMySzZBR3U3?=
 =?utf-8?B?Q2hZeUhwS3RLSFAyZ1ZBOHhJOWVhSnVSTzhUQ2ppSzNFTmdpWnZndDNHckpD?=
 =?utf-8?B?b0JpK2dCN1NKS0RQTzFYOGNab0NQbzR2cXNHczQ0SGNrbkZaS1llaUdsbGNh?=
 =?utf-8?B?UStUdVNqZGVWbmxQZ2wvR282amdHbEhZT2JpOWpjMVpMNm8zZWR0Yjd4Q1N1?=
 =?utf-8?B?ZHRqc1hHK1dVNUFEY0NKZkJ3dmg2NVE3QWRMOERNRjdLTlBzdWp2RDFmSm1D?=
 =?utf-8?B?RndqSEgwaDVOSHNGRVlteWhzM1QyZmlxWjhJU0EyWmdTcTlWa0UrQ2djaWxp?=
 =?utf-8?B?blVIZDBvQXBQRUdIcmFQWlRrMm5kNEY4cThhVHBibFBXT0hxVE9DcTY4eU1i?=
 =?utf-8?B?ZGNxZ1BBZDJjbTROWmdlU0lOREJRNUtoRnhuVzlkR1QxRURQU1hIUVdaREx5?=
 =?utf-8?B?Ulh3a1hncXNJblIyLzdzcG9uYXJTdjFuUXFtdVhDZXllQ2FGTFllRkxIUGE3?=
 =?utf-8?B?eHVoRDY3NFZMeW84Ti8yVzlKSzZOVGYvUjAzNWJtVnZLcUN2LzFRaVJaWXpH?=
 =?utf-8?B?NjBIQXpEZ051WkZBUGJmbDZXdkRGREFIdjBLWDBVejE3NkF6b0prNUxnWWQ2?=
 =?utf-8?B?VXBDMDhDS0hJR2dHNzEva3ZMQ0R3V1k5dHJaaGo5T0c2UHJ2RUVYZFhGZktO?=
 =?utf-8?B?bC95dm1sMGljZGxRNTREaXlCNUg0QVZkY0NuTlFUSHRiSVcyd0EzZmtqVCtI?=
 =?utf-8?B?RVU1dVFYWlRHVHZFbVZsZFdSRithWlVpN2NGWERXTTRITlN4OFhSUkI2S1pP?=
 =?utf-8?B?a01vWEluN01sSEMvUVkvWVJvUmY5VlNVZ1VLMVpwRU1DYitaVXlGbTEySkJi?=
 =?utf-8?B?ZllDQkpIVm1RNmtDNVR5NjZDZzArdnNDVDZiR25yUHExWGx0b2t3UmI3Z0FE?=
 =?utf-8?B?UTZBSU9TMzI5T3hSRDR6QmdXODJZYkVJems1amlwWUlhcjRCRmlobUZWV0pi?=
 =?utf-8?B?QVRpRm1MVmxKaG5HNzRRV24wWVlqeThDSXRwaXVQdjlGQXBCcThmQk40eUkv?=
 =?utf-8?B?TjIxaWU0RlpFQUpiTjY3MGhac0lsT0dPZ2dSUGFIMFFXTXlwKzI1cnJQdjdZ?=
 =?utf-8?B?emlWSDgwOVFQa0FmSGhBRGpJT05ydkU3eFlrUEJzMHV6UXk3N1lnUXcxOEdW?=
 =?utf-8?B?RUJwZndoUy80V1BMbmZZcDczd3pzRGM0SS9DblhPV2FVVGdvLzhvSDRIMkdo?=
 =?utf-8?B?ODVOcGw5NE9EVEhTbDNkbE1xL1ZCWlNzblU3Z1k5Sjl1b1g1RFJvbjVZSC9R?=
 =?utf-8?B?aXNUR2hVRjBCaTV4UjJ0bC9vckZQOW1DWUM4dlBOeHB4NklnekhmYk00aUpz?=
 =?utf-8?B?VlZQTWVxWnU4TGhSUmlTZUhsQm5jOG9yR1BET0RRWmxRUzFLaDdRd1VVN0NI?=
 =?utf-8?Q?cb91S8S6arQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b2EySTF1VC9hQWx4YWcxd0FDbmhRcUZMb08wV3BkTnlPN3hSK1FUdE1BSmdP?=
 =?utf-8?B?OU45V3JlSnVHQlAzc2FNY2VEbVVHbFpScHRvMjJRNjdab2g2cC9lb3c3YVpU?=
 =?utf-8?B?RWZoSE5oQjE0ZjdSSFY5TXN4V29TME90Znc5V1Q4SytyV1ZJaEpSVDBwbG9Z?=
 =?utf-8?B?TkhYWDdxOWJxanNlL1hoMnNsenZjWGhpWHA1YjhMNmNxYVR0NlE1eEplN2k1?=
 =?utf-8?B?V1NCNFVKTXZnYnBDeTY1Z3JvcUJuZmR4ekFMN05CaWE4emF6b28wVmo3bjNv?=
 =?utf-8?B?S1hBQ1RJNjZ2Z2JHdzJkOCtwdGJOVFhKam4vTFFHMERFTmFVMXhUQVk1ejRn?=
 =?utf-8?B?U3IxYjQ4VVBUbUNRYUVLSzAzZnhXSlRzK2V6UVVteVJneUIxbUY2SUE4T3VQ?=
 =?utf-8?B?YVM3TXNIQTgyb21IdFlPaXlSemMvbll0V1FkL0IvV3NwZFZ5d2N4TlB2c3A0?=
 =?utf-8?B?VzFhRGsvNmpQVE1SUnllQkExZ2I0dm5xRndiRERpVVBTTGlOckg5YUJBNkd5?=
 =?utf-8?B?OVQrT3RDSVZGVTE3N3d4d2o5TkpGaDFkMjFHY0hJQy9oaFdGTnNwd0JYUThO?=
 =?utf-8?B?TTU0bEF3UzV5N0V0UVJzdnBENUhqZDQ5MGs1U3d3Q3JrTURaNmNpb0hZU21Q?=
 =?utf-8?B?dlpnN3FzdGhDZXpmc3JUYkF3WkJZMHJzblhOc3dOelNoODlVVEhmbkMyVTVC?=
 =?utf-8?B?QUlORlJHM2VPUkVGdUFWT1hGNU5XMEJqUnU5dE5pK0pJdEdSRHdsUERRb3hv?=
 =?utf-8?B?ZWVKd2RVVWF3ZysyYTd2MjQveSsya3hKYjA1Zjdrc2dhKzJteS9CWEh3b21w?=
 =?utf-8?B?Z3ladUhHSEdRR0EzalhESmdKbkU0MWtORzlZV3lIaXpycVB5Ti9XS3dqU082?=
 =?utf-8?B?VlpReGs3VVppWDUvV21OdHpTWmpnRG1Wb25ZSkF3OVh0Rm8vMnJ2RHV1dExE?=
 =?utf-8?B?clAvRmJFTmlwL3JEd3lvZEN2U3owY2k4bThYRSs0NG95cGJsOExNZFl0WHdl?=
 =?utf-8?B?R1dhZFdzeVZBSEUwU3JvZjgrRFFhV1ord25RblFwN3c4MG9hcFFjcEt6eWVR?=
 =?utf-8?B?VVgxd3hycWFSNXU3aCtmUXdheDVuVHYxVDhxdFBTbjc0NlAvbnNGdy9DQ3ZM?=
 =?utf-8?B?K2o0OVFDUjZFK05oWlNPelN1djUrbGdhWkhTVlQwWGhDMFVmSjlXMzE0ajlV?=
 =?utf-8?B?Mk5DdE1HaGF5TWhnOElXSUhzamhtSlA5NWo2Zk0vNUFYOTdEdUZESG9IYkxk?=
 =?utf-8?B?QkV1OTJwS0NsQjFSWHVPNTREbEhuM0gxWnVVMkpwdy93SHhRQ1FWamF1Y3RQ?=
 =?utf-8?B?WWRtRXd0QlMwcGpmTlRrSHJBSkd1OXVORzlELzY1OTYvK29Mc2hwbkFJTmln?=
 =?utf-8?B?WTg1ZmRmejhvbUtsT0UycVFvcE50Y3B3RTlJc2xxNTMxMmgxb3JaRWxUOXdG?=
 =?utf-8?B?WE9XRHZ4RlJPYkxEeE1CR0dQRmxaeUgyY2RqRzFEcE92VVY2MWljdzlSUXBT?=
 =?utf-8?B?blhkTm1pRGxSSnptRjdFMTVEcys3SUJ6VFc4YnJSUHBrTTVpVUtaN2JFTkJh?=
 =?utf-8?B?QUFDWEp3RmhRTlNFU3NzTUNzS2xQRkRQUDBPc2JHNk9oOW9nTklZQ0FEc1Jh?=
 =?utf-8?B?dVBmS1pRbE5UNlNxYmozZFFxLyt1Sk9xMElXOHFicVJFUUhsSUxjQ0M1cy9p?=
 =?utf-8?B?Y2tiKzBCa0UxMmtwcEJHVGZOUThIQ2V4U3QzajVxenJkaklRUXhoL3d1OTVn?=
 =?utf-8?B?TlRaUVd6L3IvL1IzTk03RERQNUNIcGhid2tKbU4vNlhPa1NlMzQrNGtFeU14?=
 =?utf-8?B?ZmlibURCVXc2b0U5TlBCeTZPVmhaOUorNU8vMm1ud09pU3dTVkZ6NytMRzdz?=
 =?utf-8?B?T3FlQkRlM2VIcU1OM21pZE5VdTdEQS9HUThUODgxc1lkU3hrVnd1STVMZ0lp?=
 =?utf-8?B?MFpKLzJ6WXVOQWs4d1V1YnJiUGhROXdFZGFsK1ZIWC9zcEZoSngxL0xlSTBP?=
 =?utf-8?B?aFZaVndTcXFXSWxXOVluZlRtMU5YT2tRTkF5cTE5UFR4R2VlK1ZuV0hZeWhO?=
 =?utf-8?B?bHFCZitpMHBJK1c5U1FSRkxoRTlwTC9GK09IdHd0dGJ0SUkwZWxQOXJYQmw4?=
 =?utf-8?Q?RYcgE8TeUBBCe+FlvHKp5Zdog?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	amKlQHSMZKIGXLUJGppUQrlUj83DxEwfc1DzLtmcXLp42mDQvNcnBo9c0NO2KyUm8K1uX3GPHfTOjivHLCUdHLfHZj8AKl1XcLWy5f11cBkdT/3/l6YMXM30SMu8fSM+XHgGcekW0yxYUM3d5WmNa4U8O2azVfWNhvmDcuyCh+7DuTYSsaPQF1xFx9RGnKue8bEFbaC1x5+AzuvQi5kwoz0ovGcGC6rkbjmGxoGvcNCfsUM8nmpD5Ssz3ngFUff+/6ZLgfSh65bOxgmFawjcjWLiHyLIG3ZtSLgz3XKAgtme2dv4q7l5PxLDZGyb8zZFCQbNJR7cseaj/JlBhmSdSOLdwgLX2MCYo7CxoEtbITNdSN5OFCAF/kN6Zf3ALZwil2QY6+yyX4IHs8tq0U1ZMZBvLRPythhH1TQfGmV9/EQ3vXRjZjy0tCT02ozFQgJemPpGZNqnFdQdxbFPOY+9fMNzX3Xm+JpkYxKLhsIoA4gASndZdSsFb4FJrm25nzV69UGWKzRNhIHSKIo16Jo4SVMCU/AG2GLqaYSDsB+VeTe2z4hW8xhbml/Wrn7agDARxbxyI+hkQ2YkrFLHYwafVekQr7Y/We9JstYxfUzcseg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d94799a4-30f3-4906-bdf5-08dda5f166cf
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Jun 2025 18:30:38.8373
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Qx/hH0wUAM6sa73GVJJKElWXxXw5l5FfVSbmFP5lLs7PAVeYN8YMv3zc2XK/6NZ4r+CMDYnqJ+Oz2ZzPSGKSsA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR10MB8211
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-07_08,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 adultscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 spamscore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506070134
X-Authority-Analysis: v=2.4 cv=fdaty1QF c=1 sm=1 tr=0 ts=68448551 b=1 cx=c_pps a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=tgYuhzoOWHTPJOdo75UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: LJJtn6FV-dyqCe8Uom2fKN7SlhZvp2kY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA3MDEzNCBTYWx0ZWRfX6MhR3v/INzKy KU4O72wMnSqsIHbVdNv/NGpxuGvSKlERRcvZvMhhknovCfyQl1nq4RcXEy7CPy7wf9MmnSzUKwm NSFrKwSsuEQQ6JhJbQ+WtWt4yFQ2B/Xa38RqPPIlC8HNKjHzLDExXcX9mXklRxZu0tHsUyv8Yic
 jBYFKlNszmqO9ipGy8eQJ6Dq5PgHtxkYToVqiXTwTVCyM7a3J0OuAKUA3GT9zWtPOsTdgvFk2k3 28FDXHGTzFVbMN7rSol9EUfWhc+82VknZHGr7AB4dmcOoZA1gcptCSNvWkKa5CIUBrY0+e/0ws/ yutv1Oi/oMDt85fm/sdnfhzxPsZBq6RW/J3h0Xtq9GNUX1gC9EKUsD3Jubu2Uy+NSA2fPv20sbM
 ctdwr8B0lAyNI4wEP2izysnlamL9MiFlB6LZrbLgKTLZwAmdt3Sd9+rTfL9B9KjtSAkhadAS
X-Proofpoint-GUID: LJJtn6FV-dyqCe8Uom2fKN7SlhZvp2kY

On 6/4/25 2:52 PM, Cedric Blancher wrote:
> On Wed, 4 Jun 2025 at 19:58, Cedric Blancher <cedric.blancher@gmail.com> wrote:
>>
>> Good evening!
>>
>> Does the Linux NFSv4.1 client and server support case insensitive
>> filesystems, e.g. exported FAT or NTFS?
> 
> Just found this in Linux kernel fs/nfsd/nfs4xdr.
> 
>         if (bmval0 & FATTR4_WORD0_CASE_INSENSITIVE) {
>                p = xdr_reserve_space(xdr, 4);
>                if (!p)
>                        goto out_resource;
>                *p++ = cpu_to_be32(0);
>        }
>        if (bmval0 & FATTR4_WORD0_CASE_PRESERVING) {
>                p = xdr_reserve_space(xdr, 4);
>                if (!p)
>                        goto out_resource;
>                *p++ = cpu_to_be32(1);
>        }
> 
> How did this pass code review, ever?

Hi Cedric-

I presume what you are complaining about is that when these attributes
are queried, NFSD returns fixed values rather than interrogating the
file system on which the target object resides.

Until very recently, the Linux dentry cache supported only case-
sensitive file name lookups, and all of the file systems that NFSD is
regularly tested with are case-preserving.

In that light, this code is entirely justified, and reflects very
similar existing behavior for NFSD's implementation of NFSv3 PATHCONF
(see nfsd3_proc_pathconf). Historically, on Linux, there is only one
possible correct answer for these settings.

My impression is that real case-insensitivity has been added to the
dentry cache in support of FAT on Android devices (or something like
that). That clears the path a bit for NFSD, but it needs to be
researched to see if that new support is adequate for NFS to use.

Recently, Roland poked me about NFSD support for case insensitivity.
Unfortunately that is not a simple topic. There are probably one or two
people on the mailing lists Cc'd here who can explore this with you so
we can understand exactly what behavior folks are looking for, and
determine whether it is feasible to support it in NFSD. Please keep the
discussion public because I'm sure there are multiple interested
parties and even more opinions.


-- 
Chuck Lever

