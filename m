Return-Path: <linux-fsdevel+bounces-68746-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1B7C64EB7
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 16:41:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C16CD34F5D8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Nov 2025 15:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A385027146A;
	Mon, 17 Nov 2025 15:40:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JvT4USA/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="VK6Taz7k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DD72571A1;
	Mon, 17 Nov 2025 15:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763394006; cv=fail; b=eGGdDC7uVYYrEOfwxlWrvSMoNaJKEIqJbETVDWwSIuDaFdgT9rX1A20fX3f+efPpfgPU+2MqCbxPu+qOsVM50cRKCZUqGvOcBbH/Wqmtt3zw3oA5OnQaN+4d0kA66f5+uLoXpqYUwO93Hg5xlRiu1AUEtu2fVyCKPEg68oh3MoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763394006; c=relaxed/simple;
	bh=3qlZ929OIcgutPCpKgGd2JYAp9vRbcyOxgSq4cxuO5Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Je1ra0WWqtbVjaJ/VKdEJeF8iO4ha3jHY7MAVPjsla0HstOmbsFU36UASnlW76Kp82C5hI13OMZKfyTOiR9CZRU+T118xYdI4H+cJLnz0vQAqo23K7Db/NQUndPsiNzZRjoCGnTG1bjuGwtdnKgQsNVZUrwghtIr8O+WHGyVtKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JvT4USA/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=VK6Taz7k; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHC8M2k024561;
	Mon, 17 Nov 2025 15:39:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q9AQ7O1VQCH93KVWusg5FHtHJwYjW69jHRNOyBQMphc=; b=
	JvT4USA/FPeP2lOtv9Cfxg/WtK7+5kktfkbDtr2++4Cq74oCNLIHYutl8RAtjIPl
	F54jjfTvery3/f4P2a5XZzEEBxRQJq1HDW8yg73Tu/olNaSGl5AKD1PcCtM+A7GS
	YwnoBaXFWn9F/Ltq/73br/WTVnCWxfcqs3lFQepIhY7vH4mAoXAI/o/s7ytWwzQ0
	1pnKIOQMPlWFUkfPEzrBxQFzPHjSkznd1cSf1PHE+ue14s6YiXV8/I+FrFB0Db+U
	JLDVJhkCFcZLzjb0v96B7wDKVboxI8Z62ZyNhoQNrMmrlCx54wkdJ+5GGXFoJQgv
	ydkI7Ra8GeAvTy60Pu0LMQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbbaskn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 15:39:51 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AHFQINY007784;
	Mon, 17 Nov 2025 15:39:50 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012045.outbound.protection.outlook.com [52.101.43.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefy7ug05-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 15:39:50 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jVLhyl6R8ezXrVSPJvCUwx1ywQuKr3YRgrXCVh1Z9SZ/SRLyrRXTHRDap+uxlNJD88hQbsYFy0VjMqG8YFn2lJm1rhu72rMCBPBMWNvNhn4Uypk9H+/21FfWqGJOTJXK4TMvfV/H/7hC0RglTGtQguw53NoLV50/K9jRE4gTqj0M/HHEFIrVKJIKu78atBuiShRjkWs5RD2KY7jaSPXNI3gGjhhThkT2E9Qlt0K2oB0SyCxupLBVR0DBvbNrBXGtL/l9Qtv6rgtJRpXDFaopUPR5T3blenqx7T6nG9d5yx05a6v+r5dcKesxGtUsxLhyH0p/nS+gob25oO1YCOmw5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q9AQ7O1VQCH93KVWusg5FHtHJwYjW69jHRNOyBQMphc=;
 b=aiDEoEmQoE30CULdB7b3WsjSICnNVqnGP/S5nUe3LGRZdlyakeFUAH6LUn1AGUaKzxgUgW7VA/J8T5DKYG3h7ahuiZWF7H9XV8CTxqoxx+/gIQf9APbanXaaRo5SQwDqxgqxMPrBAN7Cl3sBwCbrypeCW18iYcVAdkGi9Za2DLTWof1Z467I8EchppbbfF8+2EKdceZv5KkX8Q9ryOiRnkC0ACg2s3ZZgPhPxmdeRS987BOM/qAWPfDvYi+EVosWWg5nyoVnJuzY0f44DhNlWBQlU/c1XIeR/SNLt21JlxjChKcZGwIJl5mJie87S6IjeYKZj930l/7EB1c8xGaLgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q9AQ7O1VQCH93KVWusg5FHtHJwYjW69jHRNOyBQMphc=;
 b=VK6Taz7kiiHjeTVRwi0MBy69Q+sJPoOuPJxP5+7mMqEZihM9T1jcjZZZvScx2zFSCl88tZ00HuOQlcWRQneQvAY/SQ7yHcBUT7EE1C0sRsjCm9IeG8M/aRaHUhHA1Qg7jFvtR+i/CGf18Y4A2WJBsArKLXVsGUTsHVzN4K0ApoU=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by DS0PR10MB6245.namprd10.prod.outlook.com (2603:10b6:8:d3::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.22; Mon, 17 Nov 2025 15:39:47 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9298.010; Mon, 17 Nov 2025
 15:39:47 +0000
Message-ID: <15c4b1c4-ac3b-4aa3-9561-129394f26a58@oracle.com>
Date: Mon, 17 Nov 2025 10:39:44 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation to
 lease_manager_operations
To: Dai Ngo <dai.ngo@oracle.com>, jlayton@kernel.org, neilb@ownmail.net,
        okorniev@redhat.com, tom@talpey.com, hch@lst.de, alex.aring@gmail.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
Cc: linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-2-dai.ngo@oracle.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251115191722.3739234-2-dai.ngo@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0264.namprd03.prod.outlook.com
 (2603:10b6:610:e5::29) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|DS0PR10MB6245:EE_
X-MS-Office365-Filtering-Correlation-Id: 0789db31-471f-4633-38e4-08de25ef8977
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?aHBrWldnOUV1ZlFYRzZKZktpY3dSS1FBanJJTk8wQkdqb3IwdURWQVUyZDhI?=
 =?utf-8?B?UkRvTkg3NnozaXlRcEZPQWJZMnJvUG5kYWQ5OUNzY0VjZEZWTDhtenpORS9O?=
 =?utf-8?B?N0xyM2hvMWZqWTQwYTVKYmN5RkcwZWxsZGdwLzBTKzlLbTdiS3pOeUpOU05V?=
 =?utf-8?B?RWVxS3c0K3hMTXdOQXR3SXZEazlUS3ZlVzhFWWlwQkxVandaeU1kVjZ6c0Vq?=
 =?utf-8?B?L1BwNmdtU0IvNDdWNzRmTmJWNmhUa055dWxWd2cvK3pEalNldEVKKzFITFAv?=
 =?utf-8?B?UFpaWFFvR0lDQ1U2MkJZT3A3eG5hWkowZUN6NWN3MU5HMDRTN0FGWGhKZC9O?=
 =?utf-8?B?UkRTYytIMlF1WmRzNHhhK2ZVNlZncFJkS21MR1gyZ210UXVYVkxQZzdoU2pl?=
 =?utf-8?B?ZmtaKzF3b2syOGk4VEVLMTNxdmVxUzl5OUpYR00xakhCVk5yQUJ6eCtpVFJl?=
 =?utf-8?B?a1d4aXdzUWVWbE8rdEZmci9BTnp0dTF3UFJuOUVKOFBRT3RHdGg3VnhVd2hP?=
 =?utf-8?B?bVZsbW8relBLaFljOTRlRzU3bE5tK3pxTVdYUW9yV0tkaDRFOFpXREpXck04?=
 =?utf-8?B?RzhqS093NmRkUUN6ZzNTRlRIYXNQQmd2QkZaTTdGZTBsSmxzUnZ6Tldwc1Mx?=
 =?utf-8?B?ZzJCUERsVHFPODNXbjNSMko1TEVJemJYZG0xdHBrUVFURk04Z2J3RWR0enJ2?=
 =?utf-8?B?THZZeHpuQXdON2cxeXNXNUJqY29pNFlBVXloOVRWM2xVblFXdzhTZ1JLL2lv?=
 =?utf-8?B?UDk0UWx1SmNJRmlJd0o5a2w4amdCVWg2cFpXejNYdmVKWlVDZGpDMzFoOGoy?=
 =?utf-8?B?RnVHaXFSQlkxOEJtZllwWEVySmp5c1FHRXZZNENtKzUrV0FtWjcvbDFwS0NN?=
 =?utf-8?B?MXM3ejNHdFdueDJqS0FTNGhTbUdKcTVyS1llSjFwQlRBNnhEM0cwTzlUSmtY?=
 =?utf-8?B?RmJCZWpQUENoWDlrYVlLMk14aGFHdFpnTnozOVdGcHM1R2U4eDNqaWRCY1BJ?=
 =?utf-8?B?VjBHekdzeFkyNVVyWW9uN3NOQlAwZVp2dVdQY1ZNUnVVZjhYRWpqQ3hGSkRu?=
 =?utf-8?B?VVlhWHlpblJwN1AzQ3hwcVk0Y2lVczZyV2IxOER1VXE5cWo0VVdySWlGM3Vw?=
 =?utf-8?B?blMyeUZIQVhaNDBlem11amZPV0VIMzZHNmFGOHBqTjQzS010TTdjUGRIa1NH?=
 =?utf-8?B?amVPT1RrVUdGcE9aM09WakNuRk11LzVRMXRmWUtLVXhkSFN6NXZZM3ZnY1lZ?=
 =?utf-8?B?UUlWQmdXQlRsWk5icFpnUmw1U1VYTFJyalErSjFVTklWWnlObDh6SlkySDRV?=
 =?utf-8?B?WU9OZ0NQc0ZSbHVqU2dxY3VrSmJzeG5YVHlnVVhnYXlxT0xJUjRQR1BoNTlX?=
 =?utf-8?B?cUJKdWFvWDVzblYwVmRkWEZjSHR3eWx6NUdBSVF5WVAwTU5GLzJ3Z3VxWFFH?=
 =?utf-8?B?MGFkN1N2VUFiay9tQzdiM3duOERmZkgvOFRMcFROaytTQlBWb2ZaSnFwTTVV?=
 =?utf-8?B?YVUzL3lpWDd2U2thUW9pbUo2c1JOK3BFUHFXR0FEWmlWZGtFcU5HemIxZTd6?=
 =?utf-8?B?bmlpQWxKWDFORC94OWtvd0lpVzVEQ2dVTWt6NllJZHJnUExvN2ZsMFpQU2VD?=
 =?utf-8?B?QXJyUmJQcUVkMDN0WFVuQWtRZGpqaXB5YURMV2o4dUxhQjBNQ2tNTnJkcmdH?=
 =?utf-8?B?c29lL3ltS3d6TmhiZkVuMHAyOVg4WlJNQm5FcXBvcU4zb2IwTHNuVS8raEZZ?=
 =?utf-8?B?b0RLQVJpVHd1Uis5NmVqMjVmTHEwZE1RUHNNN25SNVNUTWI1TVBUaDVTbW10?=
 =?utf-8?B?OW5ETmJLcTIwSyswTEw4aTNuZlp3OTNXa1JXWmJ4ZVpaTGtIOXZLQUpCTm1t?=
 =?utf-8?B?SFBrdE5QVVRFYmhvY1c4eGMwOUE1YWFQdi9KTW1vSk45WmtQS0ZzZW5KeEQr?=
 =?utf-8?B?NGxBR0tjOEsrVmM4QnEyeTR5TG8xcVExZGNzSmtETHZvaFFFa2V6WTk2T0NH?=
 =?utf-8?Q?fdB00mlU86+QUo6amsHdVGsLgIA5Qs=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?VldsQ2pxcWpucVRVdTlPeEtmY2RPS24reU5TeXJHNDJnR29ycUFnRTNYT1My?=
 =?utf-8?B?QTJnUThkQ0ZhT2NJUSs5SGJKbjRNWWI5ZEtGemxCSzBMVmtLcndhbEd6QzVk?=
 =?utf-8?B?ci9yejFNRDJDaVJkb2VTUHNZcWNQQ2E5WlQyR0NoNmtxZmVOV3RkSkFFMDZC?=
 =?utf-8?B?cU5EdElXK0pZbGl4WGttbTJVNGgrUW53ZlNKQ015K2drOEk0blYrOUo0bG9J?=
 =?utf-8?B?a0VHUGxTMXNCM3lNNUUySEp2QjFiY1JCNUJwY3VKQi8zK2NCaTdzeWtnVFBV?=
 =?utf-8?B?em5kWmV2Zmw5WkpWL1dKQzFNaGlWaEpFZG5GL3lVdGQyTUs1ZjQ1V2M4SFFJ?=
 =?utf-8?B?SnNkdHExYW1nRTZIbm9xVTNrQlVna2hzUzdIbmEvY1N3ZkpnSXVmeXk5Zmh4?=
 =?utf-8?B?NERQVXprNCsyOGNieXplTzM1c0J4Y0YwVTBERFI0UHROWXFoZVFlWG11aVM0?=
 =?utf-8?B?TGFBbkptUHRjMFdiL0hjblJ0Sk92Umxrd0s4NlhqZFVPdk1XK1pWTDhJc25x?=
 =?utf-8?B?RXg4ZXc5eSt3aFM3OHdHcDRkOHUwdTk3ME5UVVVMMXI4eTVRd2hpeHk3VTVh?=
 =?utf-8?B?cHpOVHVPRThaejVXOHNCK2RqSUsyU0RIUmFZU0ppLzhWcklOaEdWOTZBeWR5?=
 =?utf-8?B?Z0VoU1lieGR1aDRLUFFDcFZXS09NWlJUclNMemtubHR5ODZTZjZUR0xJb1V6?=
 =?utf-8?B?RnJIRktGUEtWWElEZEhwTDZhL2k5UTB1SExGT3ZNK0dveFBnOTYzQ0Q5TWl2?=
 =?utf-8?B?RE85L2lXdU52cG1CbjJuRzBUQ2FBZTgwUzJtTzV3OWJhRGpwL1UyczE1bmdU?=
 =?utf-8?B?UnZGazVySDljS3Y2RnhPT3FHbW8yTnI5QlRIWE5jMlhZN0Y2dCttd3VpTEJk?=
 =?utf-8?B?ZXVZT01hN3g1UkNmcEFpQ3dZL0ZLZHFqMHUvalNoY3dxVWM0Nk5CcHpaOGlT?=
 =?utf-8?B?T3pzbHdBaWJlcVJnK1BMSkRSZ21zWmM4OEJTS1BXUEVUdm10TEV4b21jUFlN?=
 =?utf-8?B?NmxtWEFMK2M2NWN5VjRLSHMrcVNwdEVKTW9PV0gySFdRclVsS1FMMWdVSThu?=
 =?utf-8?B?Vk1FK3FDQUo3N3hLOEd6MGlBZEtSMlNwMFROekI3RGlkK2tSaWlObkJiOWUv?=
 =?utf-8?B?YzUxdE9ETXo5ckY3eEpSRTdLZmpUelRpdExIb1dwODdUdnIxcVFLNHN4dFZa?=
 =?utf-8?B?elEwS0YzeHVCaEVPaVA3ZXFvMENPc1lYbDhwY1U5OENHbi8wUC9TdExKaWxy?=
 =?utf-8?B?WkRuVTBZTXJGQ21pamlCb3IwVTFrRkoydkNiR2hJejZhYUlBc0Z1WG95Zm1S?=
 =?utf-8?B?OVJRN1BsNXlJM0tma0cxVnUyeDJENXZQbTBTZ3hrd3QvaW9LL0dNc0dDaS9h?=
 =?utf-8?B?d1doeVFhaWlPV2xLMGF5V09yL3J4ejVkdm1tcHM4Nk1HRGw2NGorejBscW9R?=
 =?utf-8?B?QmlYeUFPRStzQ3J6akY2ZUxKU1hsaUorS2pmWEJQbll1SlAyUEQ2NTNRNkNy?=
 =?utf-8?B?TXZua1RTN1c1U2lSalIxbVdXc2V3eGtuZXB6QmxaS1ZncWVxRE5ncFRteUxz?=
 =?utf-8?B?ekF3R1hNMHJyNUpRUXhYYjJYc0RQV0dnWUg3THVjQUEwWnFsM2Vod0U5WXZP?=
 =?utf-8?B?d0VtMW03NzZxTjJTaTh5ZDAvMkRFaXk4U0NVSHpJVWo5ZkNBMGtONURqTHo4?=
 =?utf-8?B?cFhCb244QnRWcDg1aVRQc3dJbHNENmtmeVpMMkY3ZXdjKzlLMHJ4RllPemVz?=
 =?utf-8?B?aEZIVytmVmxGblhzT2VkcDgvV1hsSTJGQVI2dlJwRXZFOUVwVkd1aWpBQ2d6?=
 =?utf-8?B?bEVaRXdlNGp2bk9vVGtPb0xVY2hocDdwQmdyaE9GckVVWjduemowc3dRdE1P?=
 =?utf-8?B?YzVxeWpZbytUR2UyTVZpL01RY3lkV3VzYytPY040cnM3c2JxcWNBVXFOSlRX?=
 =?utf-8?B?Mkt0T1FCRDNwbGdkQXVsZGFSM0p1MmxwNDEzWjJBd0cwNWhVNEtzeGl0eWxE?=
 =?utf-8?B?NE50YjRsVkVEaU9uSGRjb25zUkhBL2pSMlFzT21mTWJDdS9QOUJoa3BMMUg1?=
 =?utf-8?B?NkpUYk9NejlXZDBBZVFjL0Q3aFdOWjBITElpOGRKZE85bUh1MjJ5WmxTSVZ5?=
 =?utf-8?B?K1VHdXFCSXhkayt1MDRoZmZwUExvRk1SZ0ZLM3lHeEs0aVdnbHFuZVV6Um9l?=
 =?utf-8?B?eXc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	cMOx2BVT6c8c6AkZDOM2BQoSly/U/2cKvAIxv9XuQEvKNR/opLoKnUVX31YShGlvJpGFBtF07jQRfylV3hE8BZeXWJuPIaJpk9YGBSJN9rdBcXrIDaF4dzgoycMMKzs1r9KnSqAw1QFW3k1yygBZfgiU1ro/TpqNAdViETUrQyJMk3/BvvTPDhL8NdDLKlfZIPyWwX6BeyYUmehwELxBsneKK8NQqVWl1HZDBJOayaCw6EluEdLSP+73w6d8UkbJYtHSuS8k8tmFFEH5w4xetXdZ5R7IhLfkWJWLajc01Rea7NWkKUUsLuhhkLaB5jyThrODf1WoKDzYPNuGo61oG0mNw+GeKHhqtC+j23ryYVQWMeW3nnlAABgPS4s0x6oXzb50M7/qiBTF+6zft4rfF5xXNTHh7Z/r+lmu1IlxYFVtB5aq4nDC2R2DoAqj79nwB9dDd+HkKQht8r2t+SvoL+E786QsGtCZXFuZMw9GgtFUzNcretjghZhQCgN/kZQMW2vzBYEo17OmJenNdyakJ2cwrT337Bjv4A0ZNz8ef3DVN9U3EsHflQjRUaMrt6wpAT0tZNS/7VwNOIuxmC/53ezsTSBvo9PeGVMdY6kbSsE=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0789db31-471f-4633-38e4-08de25ef8977
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 15:39:47.0754
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /lvFiX+G4HjwwpOV5NajKes0zK3+S3YQeUU0ww7ufFXve3s1c6uoKM4M3sHgN3j7s4rijZgIQZ44DyFxIAYX3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6245
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-17_03,2025-11-13_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511170133
X-Authority-Analysis: v=2.4 cv=BoqQAIX5 c=1 sm=1 tr=0 ts=691b41c7 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=FZMDFZoD4Z2TOdRC_bEA:9 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: Y0PydpnRzk9Pa6tWg07d_z5Vk96bQrjD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX3cMnHQt/8HLc
 q48WYiX5g3d8m6XKWs0DlsM9YWA2AWDtrCRAuxD1V0Imzir3+kuNI5PzG65GjHugzi98Jng1ngP
 ANJK+OiNcPnfO7yLtGU22lwEEfGsed07RElDRu7UicW6cohJrleuuTxAmGQcQLqTUih7MM1FYbg
 KxK7js5qBJiMSlGHbdpl/CZN19A9v0HqbOYnlVHCjJ7jzQSHXy61n5AJGoI/Bjh5SS3XqzmlTdl
 GnnkH6VP6IPX2Po/ENKUCum62dHLHBy8hs7D9KBSZfUYDi19ytKFiS9JD5FOhf79LUYrIOWm0Qv
 CZi334RpV4d0Ngyk9xbnZoorCC8ao5TzxD95TPgEnHNpiS1vDc59NYqgsBYMCoK9Qtk2YGeASx2
 IzY+OO7mydPdxJcMMUisz/v0M2/1aw==
X-Proofpoint-GUID: Y0PydpnRzk9Pa6tWg07d_z5Vk96bQrjD

On 11/15/25 2:16 PM, Dai Ngo wrote:
> diff --git a/fs/locks.c b/fs/locks.c
> index 04a3f0e20724..1f254e0cd398 100644
> --- a/fs/locks.c
> +++ b/fs/locks.c
> @@ -369,9 +369,15 @@ locks_dispose_list(struct list_head *dispose)
>  	while (!list_empty(dispose)) {
>  		flc = list_first_entry(dispose, struct file_lock_core, flc_list);
>  		list_del_init(&flc->flc_list);
> -		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT))
> +		if (flc->flc_flags & (FL_LEASE|FL_DELEG|FL_LAYOUT)) {

Nit: scripts/checkpatch.pl wants to see spaces around the pipe
characters.


> +			if (flc->flc_flags & FL_BREAKER_TIMEDOUT) {
> +				struct file_lease *fl = file_lease(flc);
> +
> +				if (fl->fl_lmops->lm_breaker_timedout)


Let's make this:

			if (fl->fl_lmops && fl->fl_lmops->lm_breaker_timedout)


> +					fl->fl_lmops->lm_breaker_timedout(fl);
> +			}
>  			locks_free_lease(file_lease(flc));
> -		else
> +		} else
>  			locks_free_lock(file_lock(flc));
>  	}
>  }


-- 
Chuck Lever

