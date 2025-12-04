Return-Path: <linux-fsdevel+bounces-70698-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 06F9ACA4C9C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 04 Dec 2025 18:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71808302C8FB
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Dec 2025 17:38:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B43AF34EF15;
	Thu,  4 Dec 2025 17:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oaNUVFgA";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="cJZqhtdk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0A34EF0B;
	Thu,  4 Dec 2025 17:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764869935; cv=fail; b=n5pDw3V93tpH/V7nRt8N0rGR7TORg6JgC4hsbQWCa8QWNtTiUiM4n+QyNugVwjHDdmoUCcIms0j7VQQDIATu6YhLadai/+rUztQjBZ1Z4DeddJLwYnhgIqCasVVmqMjhF1CtGbdn5j9IqcJsxEj2UBxeztq4wwJ3px1n5G1MWro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764869935; c=relaxed/simple;
	bh=yQZsH7g8l3m7haEfe8Z8iWb0ounSkRlF9SiXyCBt40o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=NZY98yvL8RJ2Vh02VqzdP/f9GL0DB5WxceTQQ7S36mQgOGryvaiYWzYeq7CUEmxRg/R+hMfMwRWdX6Cpp+T4b85qHmCLe8S5gDTQ0yfzffSRsfN4l8SWG/eAwH/BSoV1FsEa5JGhZeZAUciCOhJvtgpQSIWMIobd0dDsP2qRKeo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oaNUVFgA; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=cJZqhtdk; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B4FE0dK1201839;
	Thu, 4 Dec 2025 17:38:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=UPqpk80OATO1sxmOEpzQyxC35Ax272H5t8pzbyAUM6s=; b=
	oaNUVFgAMp54/wZxaEflwSy/wGdDrZ/m4nZlbLG2Rwvyz83DsoyBZ0wWtLHo9gcJ
	1LoRmN5mb7QfnItSJxCAcxz8oNSdiy5TgePCc2pN6Q5v/66WLQUJCK6IQqk4hLfu
	y8Y3KEFGk+WNUgXiE82owgm2pfYxbln4+Pq6mKDdQVvood1gTYHZkTYKqnc365Va
	n1Rk3J/RMVKQLag5ajbNJNiDN9he5sdfDBkV3MnUk+PKH2Y51jts8GzKpzkDHYLD
	6c71+hOlru3b+q+UA6YlSj3mdYnKgDC2hqTeVHiHmxbsmk4p/0Yide2lIVqyDIEV
	e+sib4f9u8gYk7PqjwnEkw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as846057f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 17:38:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B4HKMdd004703;
	Thu, 4 Dec 2025 17:38:43 GMT
Received: from ph8pr06cu001.outbound.protection.outlook.com (mail-westus3azon11012057.outbound.protection.outlook.com [40.107.209.57])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9cdwds-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 04 Dec 2025 17:38:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDIsHod7n1UavtT8HyFPydn/wAjpmARZXk2s+rQvTLJZHZYrKhwPKnKs6hmgG4Mw2oplXhY5qO1HC02Gnff+4g7/gWk3d19Ba2vdu07GKepwUk/CfOTX93FSbzsKZI+Fm/jXSN4txZ4OP8HRmVHMuO0dltwMcinCuoM5XxLXULGHdxT/fyP8wHGJi9oFGh0bvug6+0+yx1FEWPdia67ZQktX5n+EWDTKeCL8ZN/MIfK1Haz3i9z0FC72NQ6u7GyyFGnyTwJUD4tl1U+RxBryZhSJQby2Cljg+tlZKqTrfg70ewlrfjddcs9IisxB+9FS5pymUqTnrX4z2XE4Kzaheg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UPqpk80OATO1sxmOEpzQyxC35Ax272H5t8pzbyAUM6s=;
 b=oN9bu5E/uA4pWOGFOz5olriy8HIJ723plBA9NeCROd2rVl6QFRSRQoKv+6pvNMeeIMhutWw7S4jXaRQWynQ4Kt+PPE2Z5UvDfWSJBRvFZzqS637FSHbpEIUkY9ax1BASUXuEbJSfuPuxeKcnUQ4CMKss7xg03EL7pQKRBrUi3jS15Z5ifeImrPAEs6kFaW95N4SkBJy5J2APzbh9yQRoaAb/v9TqvQY130xDhHdXTMZyZyce7hlfUF5TE2NXkFPkWaMaZO2/voBHZQTIrP39JVWPqAsSHBBVNiCAyJqOmB016mZ6IypdDxbkA3FhfzdqBeHC5+OZB3xfJBOBviVfQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UPqpk80OATO1sxmOEpzQyxC35Ax272H5t8pzbyAUM6s=;
 b=cJZqhtdkGbxQ+lDC4ikx0dJg0aF7KrYF9uETBGoHgIzNhZ27yFBMc+cIebxyMTtc6X8ocEZSkCJZxrpc/IoH+JEvw2utEWDJMP+e9I2rCuc25t1Kf6D8GntITyJG9TVT0HnneR95iI9y0ttt6Drqmz30ZnMVeGVSZwH7s2wfyo4=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by CH3PR10MB7235.namprd10.prod.outlook.com (2603:10b6:610:124::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Thu, 4 Dec
 2025 17:38:40 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::743a:3154:40da:cf90%4]) with mapi id 15.20.9388.009; Thu, 4 Dec 2025
 17:38:40 +0000
Message-ID: <10093dbe-449c-4bb3-bdaf-6264292e0c66@oracle.com>
Date: Thu, 4 Dec 2025 12:38:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/3] Allow knfsd to use atomic_open()
To: Benjamin Coddington <bcodding@hammerspace.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <cover.1764259052.git.bcodding@hammerspace.com>
 <DD342E0A-00F3-4DC2-851D-D74E89E20A20@hammerspace.com>
 <97b20dd9-aa11-4c9a-a0af-b98aa4ee4a71@oracle.com>
 <EF15582A-A753-46F0-8011-E4EBFAFB33C7@hammerspace.com>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <EF15582A-A753-46F0-8011-E4EBFAFB33C7@hammerspace.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH2PR11CA0012.namprd11.prod.outlook.com
 (2603:10b6:610:54::22) To BN0PR10MB5128.namprd10.prod.outlook.com
 (2603:10b6:408:117::24)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN0PR10MB5128:EE_|CH3PR10MB7235:EE_
X-MS-Office365-Filtering-Correlation-Id: b3bf3452-de7d-4b9d-ab88-08de335bf65b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dml2aDc1UEw4a2JrSFI1ZUV0R29odWZMelBvU1ovNW1pbmpuQ0JWL0NhUHhm?=
 =?utf-8?B?UXIrRU10ZWxIVzZTSUJmdG0vY3h2WTB1dTd4UWNwQ2V3KzNOUkdjbDFuR0Vk?=
 =?utf-8?B?SjV0WUZJaks4NTluZjVKR2UvR0FsM1VES3B5MWsrM0QrNjNXNC9ibGppcW1W?=
 =?utf-8?B?WlZYaHA2ZTBqSytUMnJCYnhUUm82ZWFrc0hxTXdtUVVZclhMdE5mWDdyN1Yy?=
 =?utf-8?B?bGw1azRSMmg5cDMrWFUvUmF4YzVtM3dROFJsb0pkYlFwd1loN2hndVlLMXM2?=
 =?utf-8?B?LzNYMzlXM2JBRDFUTjVUdWpjZVVudlRUenFhMWNmTFNvc2w0b1pOT2tzQzVQ?=
 =?utf-8?B?VEVyRkNXUGJJM243YTZWY1BWME9KaGJHd3IzSHhrc3ZPNHVIQ3BHUnRrSEhX?=
 =?utf-8?B?ZEJ2SUJhenducFJxSlFCY2xWMHVlSnBRTHhOY2JhVlJNaHNBNEI0MjdUd2I0?=
 =?utf-8?B?dHNKVE0yYUQrM3lmVGV4Q0cvTi9KYjFMZGtFUlJySnJpSHRHOEthZml5c3hD?=
 =?utf-8?B?OVMydWp1WUlGd0Y0WEo0NW5ZbmhSc3Vad2FVaUdqakxPOXRLYm1zMzNaSjFl?=
 =?utf-8?B?cVFRVzlLK3A1VUI0NktJT3JHc09vMTlyZS9XdzZEQVg4ZThvYWJmUCtCbTM2?=
 =?utf-8?B?RktsNEcvcXdTS3lVeC93RzNuaVcvRXFnUzZtdDVLSnJ3RlBhbmxSZytEalkx?=
 =?utf-8?B?dythUHVpRjNnTHRyNjZ3bFJiYWhBVmRiemwxNGpSOS9aQy9YYmNoc3FqRmla?=
 =?utf-8?B?eHZjSEtaeEljV3N6aHhhenRNalV2Z0tRWWoxUitlTlFva21ZZFVDTTVEVTJW?=
 =?utf-8?B?YlE1OW81eWN3cldITnAvWTBiSDNVSVR3QlVPN1hRQjBBdFFtL1Uxb3FsNDIw?=
 =?utf-8?B?ZTVLTVkyOVBSeW5hWFdpRmUzbXdoVlJndlZVdXFlSFVYR2hXLzVsbnJYRExv?=
 =?utf-8?B?bEhxTHdybW9MZ2I0K1E2L2lFcUZEb0RybWJ2Wnc0ZEJGSit1YVpUWnJnL0Uy?=
 =?utf-8?B?WW5QUGxjQm5VL0JYRXZHNFQ3c20vNmc4MGdpcFJvek8vRVg3clJpeDVRbVNJ?=
 =?utf-8?B?Rm1yYTlTb3RYalh6VkxWZkhPNElDdmJDb0pmTERYY2dLRVVFZkM4MmtCK3F5?=
 =?utf-8?B?clhHd2t6b3d1cktoZUdYQkhZcHRWR0NaRGZnNHRZSGpXaTJsSko0L0c4QVNJ?=
 =?utf-8?B?TXBXWFJFMmwzMWZId2xjaHZ5WjhnWnUxS1VkNkY2emk2Q29ROWVOR2JxNk9w?=
 =?utf-8?B?Tk91YVBCUk1QYzVKODZpRkFpTEVHSjd2T1FUL2FFbzNFL1h5STBlZ3NhQ2Qy?=
 =?utf-8?B?cElXOGZRaks0QzNvUU8wMXFsc1BhSGxNbG5rSUJDMXNTMFhqdmdPQzZvUThC?=
 =?utf-8?B?NWFUaFVaeWFUcCtORDJSVkNaL0JkWkJSZEpqS292ZFpPRFBZa1Y0bXF5bDNU?=
 =?utf-8?B?ckpTQ24xZkVnT2tac1ZJd2p6dno3ZXExbkhWb0VHNSsrekxjNW9wZ3lFanQ0?=
 =?utf-8?B?MVdLTitiQURnTVo1SERURGxtRkR1VGM1RHNuczRETk1GQzNBejZFMjU2MmJj?=
 =?utf-8?B?YVhxWEFJSzFNRUpHbUVwZTJ0cHB4RmR2SitHMFJPUkVtUWRWOVZ3eEFHS3hz?=
 =?utf-8?B?Vm53Q2hzNWovT0pSTlRRQWNuQjJ5RnlUVFJsVjA3cFlFbGZiYW14eDc5dEk1?=
 =?utf-8?B?RnMwT2hRaVZuR20ycDZhcEw1Y2lCZjlSazlvTTF2NjlkVVhPek1pN2lJcmJZ?=
 =?utf-8?B?ZHI3UWtTL0Y2WEtFR29yampRUTArRDd4V3g2MFNXM3o4dXhSRUNaQWNTZGpV?=
 =?utf-8?B?NXVUQXZPTWFrOVhmZU84V25BWVN0V083eTg1Vzd5MlZKci9YZjNBMUVrcTNK?=
 =?utf-8?B?VExjZitBbW1WYkw0eUo5dldlSzJac1hYSjFkdzEzWUY1UmcxeVJYY3ZnbHpk?=
 =?utf-8?Q?iw6d91K93ORQ6umP2zM8lgq0e+iafw3Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Tk5hYnBLMDdEVjZsN1lLU3JMc2J1VC9NT0hYdXZ4S1VIbTkxYXllTGVNbm1C?=
 =?utf-8?B?QkR2dXJKSjVtN3YrRHZsa1ZzUk50UEM4Q2JuWTNEdWNQMUd3dElXeE5mb0Nq?=
 =?utf-8?B?YmF4VXBzbzhZcmhQcnV0WlN3NEtXQzd3cFc3aGs1NEhBQ0s2QUpxS0RoVVVj?=
 =?utf-8?B?Nys0QW1yYURkTU5vTnJ0OHNJK2NveTFsTEh2RzJWVXlUcW1XMVNMSlVXTXkv?=
 =?utf-8?B?RUpSUTlzdk5NS1JHelRrMjM1c2xZRXJRY29UVTVnbUxkc2pJNTJpVHdQWnhx?=
 =?utf-8?B?YVFUdmxHMEhGV1pEZ3pSNFBadVUyMEd2UWNxTDZpWFlVVWxaa05YM1ZCVzdr?=
 =?utf-8?B?b3JiL3paRW5ocTkrdGhmMy9nWXV2dVRtRFFQdm9paVlSUTFOR29ScXNRTnlC?=
 =?utf-8?B?U0hnWTFuaXRFYldNZGFrUkNhckh1bytTcEszQWFKb29zZVdpUndOUXVZb0VL?=
 =?utf-8?B?dFI2MzVHUlVmQUdMVllOTkpPc044RllZa1J2eURFemlHZENzc1V6SVE0TStt?=
 =?utf-8?B?d3I2UzVFNlRYaFIrSE5KRDVlbHJTa01seW82YS94WEFoUlZnaGcreGdZdUNu?=
 =?utf-8?B?VXhGeUxnQ2lnV1g5dzhtUDNLS2MxNXcxZzIrSG16M0RLOGdXbWZyOWxhQTVS?=
 =?utf-8?B?dWJpUEU5bjgxd0djYy9ZbTdKbm9KNlo5SzhLMmFsWnpsNHlDSW1jdXRodGxm?=
 =?utf-8?B?ZEV3aS80RG9WdzZXQ2ZyRHBLYlc1MS9yM0ozOFlnMkwzdzlvUTZRNDU1c2Fm?=
 =?utf-8?B?NVBlczNJbXY4QTBHRFdIQzQ0QkFGc21LRU54T3FtZDdIYzAwNm91cE1GU3pI?=
 =?utf-8?B?MEpwRUhPRmgxb1hScGFUc2NGQmRWUmpYR0x0bTk2eS9KQmppVytoS2xVWW1R?=
 =?utf-8?B?R3F6aFU3K2VPVm5mMk4xOEgyaE1POHJycGJPQ2RKbyt5Q2NVeVJnVE1IVS9T?=
 =?utf-8?B?NWtNWHpiSzZrbWhybXgwNG5LQzgzQ3hJNFRLVk1Ga0haa0xxd1NzNXluQXNQ?=
 =?utf-8?B?MmZMWkw4WTE2ajBOS1JtVytTdGVIYlBKQUEwbExQUU5xUXlKcnZBc0xvVnRr?=
 =?utf-8?B?MVIyaXQrR1U0djhmb3RqVHNLcGc1eWh0bkpkNmlLNm9HZDJJNGZWRkoxMEt6?=
 =?utf-8?B?QXlMTU9STFI1VUxTSys3NXFUSFNYS1VQZjZlWDNQREpkanIyeTE4d2p3TS9v?=
 =?utf-8?B?NS94bTRvbS9WZzAyQkluNkV6UzJ6WlVwL2ZXWHlEMnBTNnpxTklWQU1XaXdJ?=
 =?utf-8?B?Z1hYc0dkWWxMK2J5Z0lPOW9kVzNaMSsvMWs5K29QUEZRTEdBdzZzWDZQNjIx?=
 =?utf-8?B?UXhMeFJFbS9SUlVhanNNR281eTRWS3NhbnhZYk8xSVQwTCtjaUxmcGdoZEZC?=
 =?utf-8?B?UGN5REkvZ043RFBIR1FqVHFsaFNlTzNXU2htbDhUaDViNFJDVHV1dWM4MjNr?=
 =?utf-8?B?RWJMclBkYU16aERRNTkzZVpvUUJxWGR1d3hrcUJ3dWZiV0s0UHBGWDR3bFdZ?=
 =?utf-8?B?dGtXdXZYSDV4TkljcUNtUzFoNzFWOVA0T09xM3ZjeXJPYTJkUGtEaUowaGhq?=
 =?utf-8?B?Mzg2SkFURTZieGZQMlBEa1QvN3dEclZCUkcyUUNFTjVGRjlXa0NUNUVSS0lk?=
 =?utf-8?B?aE9hZzNlOUxOQklkQmR6VHhOUlRjY0pMZ2NPTk5EeDYvTlQwRUlFdEZRWUVa?=
 =?utf-8?B?VVdaTmdYT0daL2xCOCttZjlZRldJbWRRMzJHSVh6ZU5CQmI2WmVCV3Zab1Rn?=
 =?utf-8?B?OHZVQ3k0NTI0WXh2TUhZZDVtdmtIekpRbmZtTURlQnFabitJZkdLZm9CWm8z?=
 =?utf-8?B?Y3gzTVhZK0NoQ2x5cVBYTTZsczE3eTlNVk9BVzBTaXhGazRBVE51OUc3WENI?=
 =?utf-8?B?RUJBQVBSckRTK0o4aCthbXlJVGJteXNEcUp3UTF6cWhkMWFkaVl1aTFIUWFH?=
 =?utf-8?B?NXBkWHJZSnhGNnBZamtrVGxyMjdyYmhPRFl2bGZJb0cxV3hreE9TemJoYXRQ?=
 =?utf-8?B?SFNwSy9sZkJTclBEbXN2d3gxcElPcStHaXVBSWpoU0Zza1hjcUZ5YVBCWFJN?=
 =?utf-8?B?M21ibXdoSUhTd216ajdrYUczOWVVUzlTOUs1Z2dvNHNLK3g0YkxQMFNFQ0xP?=
 =?utf-8?Q?Y/SENdyqvnTO0GDZ733orC24J?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	dWewMcLTn/c56K8cvD/s7ivIN+4hIdrjmuZsMjWBGkhWa3j0LR5kOUKnvYfpLuwHAXt2KbBBDOHdXY8M7huDVNw7x8egJUDOZvE8YFPd7KYlRap8SL25DytJHBiALlIUycFoO/1M24TxjfvkjfAfUc1OU5JPU/oOy/DXZQZeS0aJMtaeTTozNltbNBfKp1JTGe5IrIwB76cbdDkioxx+wgkHENZbfsXt1FGq7I9jtXpXX26IfZAkThkjogVlWIKppgZLAxSray0YDaot7NKI+cIoFc0ApjcDVIYoBo9ZH4547QkieU/9d6EePC4i0X4ql5aaC6esK1mhSW3n8L4uzmwLheiqzWQmFXKWCLNHYmClVUaxsQO33BsGtTGULLAtJ9DnkkeAUjaGedLne6JPU0aWJhJKvabfsJbrQ5A3Z4rjdFKZLVSVwnFP1jE0wdPn+3utIDeDBxr7DRkFXrFeNPjWAGIzl5VCFQLuSkAE0P/VwArNgfBUfffOdWZdFXLMPBmEDQZad3nEyq97fq9hAP3/Ms5aqYYYyLaM2NcFtVRgmKQXzNHEICgoVZZLWQq0s9gvI+dwRYvgmbj8KSo/nB86oOqlPRbq5egUmu2W7TM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b3bf3452-de7d-4b9d-ab88-08de335bf65b
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2025 17:38:40.2209
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gWl/43njt9PyJixzNGYvNNsW7mQh1tJrgiAznRQRuafxnWitUOHCKcRpwVDFO8lAiOnmM+GYbWbE4D+mAtGH2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7235
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-04_04,2025-12-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 adultscore=0
 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=825 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512040142
X-Proofpoint-ORIG-GUID: vZ7EYLMnVKqMdIoBa8NVwhbaAQWIvEdr
X-Proofpoint-GUID: vZ7EYLMnVKqMdIoBa8NVwhbaAQWIvEdr
X-Authority-Analysis: v=2.4 cv=W8w1lBWk c=1 sm=1 tr=0 ts=6931c724 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=xdNH5hyuhG0fqUY3jY4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjA0MDE0MyBTYWx0ZWRfX37gbY7Zjnflf
 0+wiFdicY1fa3lhJyD52K/VwNZ3xIyKvwpxkNFgy9X3yD6Bo8qCMg4N6+8zCu0zavdvghCD6IhK
 rS1P72e/l3Kw7qtuEAX9/5NHVu1Q3T9RQsm9VG8X3grxoLfFnYwp8BceHletb2oHHO5qjthVoW7
 PSUczNDQH5sz0lO7c8ikKGywfL0ityAi2Ktua2WoRxhvlAR+F+kaNCKRjwg5lolFy2gP/rJPGn7
 d6m4HoBP/Cid0oHvT8yh8FqDOSdISMvPQ3RjP8rGg56dFLBjFleJdPsrpP9t7BukSq/DJljbdew
 5ddPLk1I1AbH3GwqMpYNbiehCFdF4cPp8ZfFRH5JrF7obIpLoIACZlDHX26FfUe7QThJdtk6rIN
 HrIBPCxiOHOPFB0+P6C1opaDaJ3GyA==

On 12/4/25 12:36 PM, Benjamin Coddington wrote:
>> I assume that since you sent To: Al/Christian, they would be taking this
>> through one of the VFS trees; hence my R-b.
> Thanks for that - usually there's some discussion on which tree would take
> this which I didn't see yet.  Hope Al/Christian will pick it up.

There hasn't been any discussion, so you didn't miss anything. I just
assumed, based on the To: line.

I'm happy to take these if Al & Christian feel that's more appropriate.


-- 
Chuck Lever

