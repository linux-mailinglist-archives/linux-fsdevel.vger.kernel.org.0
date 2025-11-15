Return-Path: <linux-fsdevel+bounces-68570-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C1CC60A7D
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 20:45:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F4A23B622E
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Nov 2025 19:45:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7BE30AD19;
	Sat, 15 Nov 2025 19:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PTVV7h86";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="MiH035RN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0C422127B;
	Sat, 15 Nov 2025 19:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763235894; cv=fail; b=jUmAFriRDCAOO34lYZmD2i74WFCuwNk8SSTBaDlEE2YYK+4n60IegIX6cYBx9uQpwa+7TEqq/w0MYndY3eVbP0Vip4c38JDYywZFjMFGjfjYdlnUGWdbllQppD72vxPgh4Yx8glPEoxPlwFX+Ll76AobT77v2gWZeJiKs9y+7wc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763235894; c=relaxed/simple;
	bh=CugVmHPeghTrxrGX2ITYILszZRk9Rr8GhmZcufIjx1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=W27nCDtGQLAEUxF3MVBRxEnb0OQyCGGXO4tbOaDbXIyIMeJ0M4DFC7Gp9CidpBoBJmlhxQhOJjXWd75Zi4QdXTjvpiI9C2zHBFo7v0VR7cIkYYk6wzq8x6AYVUVc0HZ5qLBx80sypTNYQVSvq0dbGbANexhFb7JXSR8yoZ7nQ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PTVV7h86; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=MiH035RN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFHF22l028548;
	Sat, 15 Nov 2025 19:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/rLZDUaJE35rIGzjDM8XAZKt3Q9x4RL37MuC9wDVzNQ=; b=
	PTVV7h86m/b6131N01Veu/iTT2ugM6FCYHv8WrLcJ1JURnjcImGAJk65ahYgWJn+
	x9mR+8tr6FA16Sed8O5dww7lnFfW6xhQFP3rnzw8trDn4zdmCH/Z7yOJWrtH5CUl
	FRDPjegrjnFJbZbsCewnBAMfv+1pV9CWzkJaSbxkN6f/rWg6ujxkH7tIO3oItzAJ
	HwDRnXQ+C/X41xEx3/x8kBu20Iu5ZpaSLIVOGxPTu7xgiCkXyHdnlui3xQP4h3dI
	IgXiD14lNq97vE6XL6cT1/fPvpQ3ExJwZJtBW73ugog2HQVIL9MYbKspJec4gpq3
	2Bd/vrvDgC2WyvpmDUXIYA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbugevf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:44:36 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AFIk2OE002483;
	Sat, 15 Nov 2025 19:44:35 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010063.outbound.protection.outlook.com [52.101.61.63])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy690ux-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Nov 2025 19:44:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UI2sW3MopTmr+w8+JxOfzylheENnR0u6ybOnlh9A73UbiRoK5yJRJoNJ9127UG22kkxlVN8r4sCCPjr/0TmHc2IcbB4nw00SMcx93N6giZs9c5Tr8lWRiHgOgjflE6+qqUJe88d9jndMjy0wjKT6lujtiFJYuP5Ot2vaRat+CDdq9p+rwUi/7iHBTib0Wb7cqFBGYayxe7H8Tx9xc5z4mrToC3oEzDj9ZW2R+XhQs8Gm3GzkS+jpwk6sYNNjMfI/Dfj5sBD31hKv1T3bDVT2D385bCVq3rsG0Ls5va4x4VzH0xpP4NsLE/2P836Ec6AFim9ZurAjCQr8LfVoEFxNGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/rLZDUaJE35rIGzjDM8XAZKt3Q9x4RL37MuC9wDVzNQ=;
 b=ekGluO6c6oyw9BIQbPl7H8CBkix5vF4S5S7PmBaGFUvvgRA8E6LVTRt/mz3lh19hVMf3mtgMCHP366MPPPHt1nWtDFE/cUa7q5p2nDLBXE5i0yetZXlsga1LImGn9tmEV5hJI8YJxNicVghMngfcNx0Uj8eaxnQJA4QVpBBr7/0jk6hiZgA1VVpJvrOVCnZFHIjFpA2+HQFHkTG2sE7eVxyaFxgJGRET6k7PiYNfgc/v4EkmMD75eyWhg2UznIJufMY3h5S8mLRVkeTmsXINKBf6nVH3WUUZWIX/zUwTXMOozCh9mByXOHje6TvnknG04+zsfeQEtKjmyrXM267GJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/rLZDUaJE35rIGzjDM8XAZKt3Q9x4RL37MuC9wDVzNQ=;
 b=MiH035RNjXo4L3vcwgkqvCqC+gW6WYJOPpXuDknV0PwhsEHpo4UXXHpUu1H7fxVpX39RAMmikNohV1xrVYSI+IrroV1MBD9Z3IjETQW4pu4O5bs/FVfbyEArO2qmf7X4i1eqAu4UbxDr3wUZF3i5UmLapt5hURbVjYtvdJaeTzI=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by SN7PR10MB6667.namprd10.prod.outlook.com (2603:10b6:806:299::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Sat, 15 Nov
 2025 19:44:29 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Sat, 15 Nov 2025
 19:44:29 +0000
Message-ID: <967cc3ea-a764-4acf-b438-94a605611d86@oracle.com>
Date: Sat, 15 Nov 2025 14:44:27 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251115191722.3739234-4-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR12CA0019.namprd12.prod.outlook.com
 (2603:10b6:610:57::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|SN7PR10MB6667:EE_
X-MS-Office365-Filtering-Correlation-Id: da8dcbde-6b07-4df8-a539-08de247f645c
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?UXZjd0ZrbTJMV3ZPOWdFZjBYSnVjWDJQVXVUSEtVYVdKYzFqWWxQVmZiWm9E?=
 =?utf-8?B?RVV6MnJ6dkNva01jQ0FqVW5RZU93NjB5Nm4wWU95T1pRZDd0cXBVb1lKYnRi?=
 =?utf-8?B?Q0NJYnhsUm1rc2IzaDNwczlRUyt2NlVGUGg4aGQ4MUVwaEkva1U4MGxwSHZR?=
 =?utf-8?B?a0M1WStwSWVhZnhZSWF6RGQ1Tmpma2JoWEpwMGMzZFRkSDJ4amJUdWRsTnAx?=
 =?utf-8?B?bktUZnBMeEg3Rnp2WERUd2trRHd5aTI5WW5tVWxreWx2RmtyMkV2eEkyOTMw?=
 =?utf-8?B?cVFsWFlUNHpEcnNWWERkM2ltdTlVdC8wNXc4bmdQMmhXRlZTQmhiUk55ZkNv?=
 =?utf-8?B?amRNTVl4RVBVb3JmVFNEK3U4UHJGMnZqZ3M2cDB6R3o2NlQ0ZStJWjJqeHlS?=
 =?utf-8?B?VG1TeVpQclJGbE1rUGZrNmxCSWZSOExUZXFrSzg3U1NQaWhqQmk5dzdMWG5Z?=
 =?utf-8?B?cjRESUVjckhSc0c4VXg0ZjUyWVpUQWpiVklkcCtHU1l0TWl3TEV0YW5CdG9Z?=
 =?utf-8?B?YWxmSFhWbWw1Y0xhVWRVMDJxRE14emxwTUg0OTRjQmdiMDhtUmR3bTUxU1Y1?=
 =?utf-8?B?RE0rTjUwa0kyTUZlMExkRFFndTJkL2JERis2cG1Ib0d0SWpiOUxGRlA3a3k2?=
 =?utf-8?B?bUZSYUtQeG1sWnRqSTU4Y04rM3pkS2JHeFBRN0Q5T2QrVkNiUnVnSWhuY3R0?=
 =?utf-8?B?M2pOcFlmMmpuYVY2WWVKSjBXNEdVbFJDOWJoc2syMlpqSTd2S1YzTEVwc3Vt?=
 =?utf-8?B?WGVUTitrWWNMSThMTGRWbkxsei9iZGl4VVhqY2hzVVROYUtkMFVRaGJ4eUxU?=
 =?utf-8?B?V0krWlJJSDdiTVZDaEhoSVFsQzRUMEl1cThpR3NqcEFGSVVsUmhCU3BieVo5?=
 =?utf-8?B?K3ZZTGk3TnpUUzgwNllab3RWTW13RC90Z3JVM0J0bzNpR2JLSXlTVVhuUWFV?=
 =?utf-8?B?T0ZyczhpcE8rYXR1UUtrdVg3Z0dwZDltckF1NVVtMDEvMjBoTHNLUEtlVVhB?=
 =?utf-8?B?aFVYenBsQ29Kd1JESm5pZFpDY3hHbTZHOTE4ZGFNSkJMS20reWkwbklDdzlK?=
 =?utf-8?B?V2FySTFWU0FjSHRQUTJNcjdOazdTVFRXZDZwcVJYRk8xTUhnUG11dTcrd01D?=
 =?utf-8?B?WXZHV0swbEpGcGhNUUN6b3JEZ09oWWwzYmhMbnNRZCtMTlJNcGhqS3ZvN01t?=
 =?utf-8?B?c3E1MEh6RzVNWXpiM3IrNmFRNlRYUktuNWw2Nk9nNHJzZDczcnJKZXlEWldI?=
 =?utf-8?B?V0xnMERhY3h3ZUE1Y3RpdUY2SnJsUlZ6VzlvTmJodGtKYW5sM3dKOGVLcDdQ?=
 =?utf-8?B?alB0RHJlQzErYjVDVU50WlBjMmlYTHlEekY1Vzl0amV0R3JNRkVHeUFZUWYw?=
 =?utf-8?B?OVIxVndvYldEcmlFUHZSZ3M3VGNWM1ZrM0M4eko4czIxZzVGNmVIbC9uNWxP?=
 =?utf-8?B?SHRwUlpOR2dodHBaa1hwUkJzVnFPRHdRRXhFLzAvb0RSR0g4ejVsTHZ1Z3gx?=
 =?utf-8?B?ZnBZbnd1TUpZUkFVT3BVMjNCQmpiUWxvVXQvbUVSZUw3K3FPTExyN2lmOFB1?=
 =?utf-8?B?aHpFYlFCN1FvU2NzeWtidVBjczFxQWV4WTVTM1phcWdKQUR3MEN2YTRMS0ZH?=
 =?utf-8?B?d0hvQU1vMUdwb3I1WkgrTWRORFk5ZHpSY2tIcWxWdTJwbEFvSDNPbUdqdHJ5?=
 =?utf-8?B?NVhCRzJON0paaFZhWTFrZWNKS2MwVVJrSG96SUg3dmJhZy9Jalp0aWhzMHZk?=
 =?utf-8?B?N1hyeEZUSHkrbjFvZ1lpZ0c5YzFGV05lMFdObXNPVjk2MEVKNy9QSmtucVBu?=
 =?utf-8?B?SG42N0g3WERyUXozRkpUTVVHZzQ0b0RIZE81K3NCTjdGcmNVRjJUZGhNSXly?=
 =?utf-8?B?M2pBTzhZQitaTVNTd1dDMk15Y3lDWm94bml5dENXWmtYYXJ0a21ldlZ2WWdF?=
 =?utf-8?B?WVNQM0o1WnE1d0psR2UxaWI0bkRSbFF0Tzh6QUtaRURLQmxGYUhKVnB3VnFM?=
 =?utf-8?Q?Bp1SLYpNaplkMq+D7htPadWmp1XXTA=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?S3YvTEYxVnNwMDE3RkhDSkhZUFRCYjcyRytaY3ZJSFlpc2JQZUpEMzBubTZE?=
 =?utf-8?B?M25reUNsemlHc1hWSHhBNk1FZTJLSW5IWVV2V1MrNVhTMjlXK3doUkRXQ1c2?=
 =?utf-8?B?V1JoaGQ5VThqcHd6bWJ4MDFDWkZCNGsvR3VsZlorLysvS09RVWc3bVRXMita?=
 =?utf-8?B?eUhwTzQzRFp0d0E0UDdLVGx1akhKTlMrQW1kVkFDOVJzRUMwSTI0T2tFWlBU?=
 =?utf-8?B?NTA3cXRKT0pDQ1JPVDZsbEdiaFN2UmhFR0g5TkgyTDNrNVNCK3dzdTR0Rk5y?=
 =?utf-8?B?QjlXdS9uUVZ2Nkp1dW1TSTU5cDYrUDZLdHNNU3p1RmNhVkNsVy9OMlkyc0hT?=
 =?utf-8?B?OWkzOG1HYXRIa1Z0cUE1MGFkSTlXQTZ6akNTSWVHT0NIL0hsSGdkdjJCSFIx?=
 =?utf-8?B?SkYzYTRBTmdHUk5vQ2hacDVaam9HV2IwOHBqYzcwT2I2YmZhY01yaGFFN1ND?=
 =?utf-8?B?OWFDZUV5SXBRWUk1M3FBTFhUNkNXcUc0Qjk3Zk40aEJUZzlWdjkwWnE0ck02?=
 =?utf-8?B?Q3dXcCtUNnNZYjZkclYzeGNXNjFpaTA2OENLR1Q2RGVPdm15TEMvbFZtRXBE?=
 =?utf-8?B?dkxHNmpsVUE5LzBXVFdBTm0zemVCb3A0WkRlb3N0TkxjeG9BcjRDT3RaemxY?=
 =?utf-8?B?VEJoenV6V3ZkT21VYVhEdVJCNVhReURMa1EwOTV6REZMRnI5RDhGOC9HMUxO?=
 =?utf-8?B?SlJYM2hrQ3MxVnhha1gvSkJmTExXM0ZFZnl1TG92R0RINzBSOUY2S0ErUWFZ?=
 =?utf-8?B?Sk1MSEhGN0VKUjVWQjBVWjl1TFdML0c2dGFBN2RmOFM2K3FGUzFJRU1Rem1I?=
 =?utf-8?B?alFNUEFGWmNvNGRCVjBpSnoyUlU5VFQxOTVibHZoaHRVb3BZVlJEbGRxOVRM?=
 =?utf-8?B?Z1hubGZLV3NPQUVoY3NhWFVhbWh1N2J2a0x6VER1S2d0Q0hPS2JEQUlUSVlU?=
 =?utf-8?B?YkZUTUZtQVBVcWxuQkozcVhYd1RvUXNTelFHQjB6QnBjMmNIRElZcW5nSCtD?=
 =?utf-8?B?bkE5Q1FsL0RpWnJTaDI3czh4VWdVc0dvSW45dFhuaVk3bk0vUHk1MHhrenQ5?=
 =?utf-8?B?MTJ5WWx0cHR3dUZNSVZ0QVB3VElzUWVyczZhV3EwL0JHaTNwWkhaNzJIc0pN?=
 =?utf-8?B?VUlpdVhqMFBHOE5ySzVudFpZYTR0QXQrR252ZUp0QUdGcHg5dDlMZ0FWZXgy?=
 =?utf-8?B?VGR2aHFoREVyWit4RVhOZU9Zc0pTcFhXZnJMK2x1cDVDTEhENk5sV3VpVmdh?=
 =?utf-8?B?WkZ5YUlzTkZESk1wZjF4VzVmUmEwLzNaaklaY1haN2YvMElyaWprWEtkdFBi?=
 =?utf-8?B?dWdaRXljV2tNbWUrOVZaYU1iWWUxTk5PaThEeEgrbGxNTVNpTk5TK3NNTHpj?=
 =?utf-8?B?NXNCb2t5dk5lZ0FMUmxVem8weURmS0gvUjhoNFROcDdjZHk3Z3FJY1BzNlVt?=
 =?utf-8?B?Zlh6YVI1MUowZ0pwaE9KaWM4MG1HM0pBenp6L1JQRHIxcXhmaFFlejdzbnR1?=
 =?utf-8?B?NFZYRnR0LzEyUkhuOFlCY0hRZGZXMGVaRXl3RUNVL0RScDBISFJmbUZaLzJT?=
 =?utf-8?B?bk9iV2V3NDl5Wkg3Y3BnM0RDUzludzFTN1gvMkE2VG16dWIxZG9NTG50OU9k?=
 =?utf-8?B?eURYY0x3Z2IrZkFOQzdQaWxYWlN3Z1BWbEZqYWltN0s4UWlqQnovNmxGMFhx?=
 =?utf-8?B?LzVpWDFJcWRHUGJ3VTg0TXV0TGhDWXFiNmFpWDdRZ05MMFl0djJ3R0JQOUp2?=
 =?utf-8?B?Q0VxWi9Md0J1UnM4azkwamQ2WW1XaGtmb3NGbjFjdUN3SmROV2F3MVRlMW9X?=
 =?utf-8?B?ekpyelFISnlsMmJ2RTZkNVFFOGhFa1BQK3MwT3JtVzhpNnMzUjd2Z2RBNU8x?=
 =?utf-8?B?dUQwaVdzUjhJa3h5ZmJ5NFlRbUZ5SGtST0ZqY1c3UTJETmdwcFNibExjWElM?=
 =?utf-8?B?RVJXQytTWDBodXl2UkpicTFKSXVsUDdVQzc5QVU3dUZaU2dHN3dTQ2V5dVd1?=
 =?utf-8?B?aW5TU0x2YXBrK0k5cW94eGtsUXk5SlQrRXNpUmpGdDlIZnB2dStJK0NCWjJm?=
 =?utf-8?B?SE1rYVl5a1VWRXpMckNrQWNPYVd1NDRYam4rUzRIQWZzbWg5Vks4aWtpQ2dW?=
 =?utf-8?Q?ryelIxJrhHlfhAcJ+CGUONUOI?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	zz/bQRZrRtCGS14caCBTyOvy2c7enXp8WRERVlwXR//So6ywKNNQVeNNY6fajt83+Qoc58TatSqrSBaooTi12aaHm36lnfoHmV0/W1nWr1Y9qmdbRsUfNUtDUXCIvDjgmbfVyp5iPey9WPI7palSP0ZQ6Ma/CdWazxX4+2Hq1qgti07XXiTOlLh8Hqz5vrfHeZDRFcHIhfj2KxImvMGjRr2sclC+7Hqr7nAT77DgskG2AOt5uA5vWHkQtcWIzu/GD9bjli53f2cVTTBvTzAUmB4ISvLSrp3KeI9XJst/Z2JD0+x3LtfLZ1c19kRjPpRmbi9u3v2GGY3YqfW+BbeDxrs1D8Bf5RdJAt2dUg2SmnDMMVbE2jvFvi34MNpIX0JRdAqv67au0JH4Cvs9b/v9kA9J8XU5QjoZ+ObLzJocX1E1rYRt0JTJvTydj0ERWQeAdwACEuBs+HXUuLoDfYJ1x7HjOVIkIC2I2U+Mf/cm4/j6Wz9hnzAzt/HHkKVUP+embZDuwTRLDYSnpuVZDgzrq9bJDM1XVEwAVTpGOUfHu20ndhrRv3+Pc5BYdR51iPV7PZ5hNH9FtZ/7yUck+9kB1Ktlw8m0/wLZfeAinjJMo6Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da8dcbde-6b07-4df8-a539-08de247f645c
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2025 19:44:29.7496
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qSx3FreJB/9Frt5ihOOcqA+oCfPC2BrjeWO+Vipq71glEtpr6YNIHXdpu0McQTjG41LHX7d8uULbjDdndCd2uQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6667
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-15_07,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511150163
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfXwlyNj1w0n0ya
 wifJfDJSf0bzcUAxSJ7Yqr4Qjm/aXDZNqn3ISoba9pbSwXmJpwwuvY8iakxauhKNHfOSA7MmIMw
 f/84lUscedHoljJwGjG53R/3qz0ZpD9/hvhxrUcrxOsKmeNeEnly0tEvBs8t8T964iFsMd2M6Ly
 Z8e5bbBE8jVCJ1DTODYj/UkZDX94rQsqaSfrI3Zg32QWBsNA7apNtoveFnhgpD0YQt+Sn+bWOcn
 1q8gRCaHvv0qU6neqsT63tozn5Aa/eVnNwHbP9u2RmZZdsRMN+Oz7tgiZz4D4jjBLalrN5EutEz
 hdJX+q9fl0HygaEzzzx7K0AKVVMok4FpnJ5FEvhXm7u3HZQ++d+dllOt6dziN5cF7sPiGerS838
 Enq/HlJbVkFaPMfMrmIMBLkqBlILcw==
X-Proofpoint-GUID: 1dYv4AbGQnBVF_V648znZB6ER26YQ3Mu
X-Proofpoint-ORIG-GUID: 1dYv4AbGQnBVF_V648znZB6ER26YQ3Mu
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=6918d824 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=yPCof4ZbAAAA:8 a=kZaoY_gDhQh9-Q8brGgA:9 a=QEXdDO2ut3YA:10

On 11/15/25 2:16 PM, Dai Ngo wrote:
> When a layout conflict triggers a call to __break_lease, the function
> nfsd4_layout_lm_break clears the fl_break_time timeout before sending
> the CB_LAYOUTRECALL. As a result, __break_lease repeatedly restarts
> its loop, waiting indefinitely for the conflicting file lease to be
> released.
> 
> If the number of lease conflicts matches the number of NFSD threads
> (which defaults to 8),

It's 16 now on newer distributions.


> all available NFSD threads become occupied.
> Consequently, there are no threads left to handle incoming requests
> or callback replies, leading to a total hang of the NFSD server.

This is more of a muse than an actionable review comment, but what if
NFSD recognized that there was already a waiter for the conflicted
layout and, instead of waiting again, returned NFS4ERR_DELAY for
additional waiters?

That doesn't eliminate the deadlock completely, but gives us a little
breathing room, at least.


> This issue is reliably reproducible by running the Git test suite
> on a configuration using the SCSI layout.

The git regression test is a single client test. I have to wonder why
the layout needs to be recalled and why the client is not responsive.
Can you elaborate on what resources are deadlocking?


> This patch addresses the problem by using the break lease timeout
> and ensures that the unresponsive client is fenced, preventing it
> from accessing the data server directly.
> 
> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> Signed-off-by: Dai Ngo <dai.ngo@oracle.com>
> ---
>  fs/nfsd/nfs4layouts.c | 26 ++++++++++++++++++++++----
>  1 file changed, 22 insertions(+), 4 deletions(-)
> 
> diff --git a/fs/nfsd/nfs4layouts.c b/fs/nfsd/nfs4layouts.c
> index 683bd1130afe..6321fc187825 100644
> --- a/fs/nfsd/nfs4layouts.c
> +++ b/fs/nfsd/nfs4layouts.c
> @@ -747,11 +747,10 @@ static bool
>  nfsd4_layout_lm_break(struct file_lease *fl)
>  {
>  	/*
> -	 * We don't want the locks code to timeout the lease for us;
> -	 * we'll remove it ourself if a layout isn't returned
> -	 * in time:
> +	 * Enforce break lease timeout to prevent starvation of
> +	 * NFSD threads in __break_lease that causes server to
> +	 * hang.
>  	 */
> -	fl->fl_break_time = 0;
>  	nfsd4_recall_file_layout(fl->c.flc_owner);
>  	return false;
>  }
> @@ -764,9 +763,28 @@ nfsd4_layout_lm_change(struct file_lease *onlist, int arg,
>  	return lease_modify(onlist, arg, dispose);
>  }
>  
> +static void
> +nfsd_layout_breaker_timedout(struct file_lease *fl)
> +{
> +	struct nfs4_layout_stateid *ls = fl->c.flc_owner;
> +	struct nfsd_file *nf;
> +
> +	rcu_read_lock();
> +	nf = nfsd_file_get(ls->ls_file);
> +	rcu_read_unlock();
> +	if (nf) {
> +		u32 type = ls->ls_layout_type;
> +
> +		if (nfsd4_layout_ops[type]->fence_client)
> +			nfsd4_layout_ops[type]->fence_client(ls, nf);
> +		nfsd_file_put(nf);
> +	}
> +}
> +
>  static const struct lease_manager_operations nfsd4_layouts_lm_ops = {
>  	.lm_break	= nfsd4_layout_lm_break,
>  	.lm_change	= nfsd4_layout_lm_change,
> +	.lm_breaker_timedout	= nfsd_layout_breaker_timedout,
>  };
>  
>  int


-- 
Chuck Lever

