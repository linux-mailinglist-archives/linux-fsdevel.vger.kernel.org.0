Return-Path: <linux-fsdevel+bounces-23835-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D09A933F87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 17:25:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5E9B31C23299
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2024 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFE6181BA0;
	Wed, 17 Jul 2024 15:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DjovXksi";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dG7B3ZgT"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DA27ED8;
	Wed, 17 Jul 2024 15:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229905; cv=fail; b=I8Pj1d5XXvdwFktbRP6EOJPohh6j1V8IwDlisuxVeuu7HBvFYTdbNCDUuycHb99CaKVij3V2gapM47LAGaw5y6T42n9MOS7oUqF5GwLDuJePS49bIs91hAGNzSUZe9gl+GHRO1tJYj0zk4TtHeTaVZdczeKNCGwT9DtbuajXs6k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229905; c=relaxed/simple;
	bh=deB7ONiS/+e+fShZ0ghXB1nSgOrmVK7RhF0D3rFHOfQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=iHtzMHp/CG6SjWI6CN0rTt/ZNRt5dZUKFilLtHXHZC7yYMxt4rTXcZjn1w/GcVsEG+vauqT5XHoki7yvWl9K8wp9jg/UfDgpcJo4F5AzHrr5H27wITlyS0nirOQGNfqto7Ut+YgDhJUZOTFGCcoxjshZQ7wOOmrzKm/8lfrijv4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DjovXksi; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dG7B3ZgT; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46HFAkB9006239;
	Wed, 17 Jul 2024 15:24:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=+eZmgFnH+8rPSwRML3BsZcn3S8osZ/iJ8xkBY5fsDJ4=; b=
	DjovXksiVmXUE0uN0oVP0lpGZWZ8Cb5R8+IUD/IsF0WxzGO6IoOEafeZjnizLTD9
	+Q4igHIcHXIXQL0NgQKiM5IeFW1ngWS34kL/PECfK5t1GCkhgqVU5F1lJ01sNpOm
	zJJrtVa1266XN2OD3zBiEfxTvQXiIr7dDSsovQtx2Mq4B5CbhHf/xJXIPB11vWqx
	0QQQu75la6h3wZnACvg2fHuYPTpIa+4Wzqx0XqMjeoOYoyBNVqA5VDTSTYWBwmax
	4SeEZKqCt77HKP4WQXXtxk5fb2C4n6CvF3xydkxh/JJ1R2VwRT5xEF+kl6OlCmLH
	MLSiZbjjCtV6kSx3AbSxlw==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40egc2r1h8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 15:24:54 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46HFDfSa021802;
	Wed, 17 Jul 2024 15:24:37 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 40dwetem7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jul 2024 15:24:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t6kgtDgjFZVsEkaiIdE2Ks6v2P1+rHKn/Sd/R6Tg2YkoocDnW4G849XF3zuq6kAmkZUQjz7IIym35Fa/dLJVCJpTHCzsOIrTzWH+nqNqU6A0NeVV3kvNdikl/yX/+KONgFHFJgY3i/eSj6DPF3vUG15AhKAFqDahA4VBjPWFmJUwPqkA26ZjW+cVUOZ9WKGmgnp89QG3q5b7cs49D+brIRgtdf/jbKCyzAcGwdLQv/TJg4XkMSN5V01ngz/cz5DlG7Lk1wHWaqmi60f/r83/UKBJ5Z3Mad4LMJAq7Z8BYzP/+7n3W4hM5qLlYPRswAnnt7dYySxrrbCMtt9fnmjnqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+eZmgFnH+8rPSwRML3BsZcn3S8osZ/iJ8xkBY5fsDJ4=;
 b=yDX+kH0JNQu0POSjt69GNFWg2aBef+PU+U/EQMVb+SRKGTBsqFq6SPJ+AhRqWNh7ZjObGT50ZH8tRCMGB2BTrXm8syWD+Cc4HY2F2r7qMR1y9PAm6mSdNgvWmTzA5GUYLznVwWzRn3M3RYlZb/8GEfmGqiJJV/L/WKcqZTgmmotZ+dfhsEo1Z1x4TnYhCs7XuiPRzIdIPo2EN4Q4YhOvfWpDFetxVNTZVJB7fLqxGH+Tr7dx0+aIS3WCRAAA7FPMw2POuM1XxyV4hgVzY5tPhRH5Yc+LWcNuKlSKC9DRVszMWl11poZtihg5KQbIM7+i3TC6DUYBT40VTit4giXNFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+eZmgFnH+8rPSwRML3BsZcn3S8osZ/iJ8xkBY5fsDJ4=;
 b=dG7B3ZgTTxwyhZV8qUTFJyXV4dMVrviQ8P0rNMe/Cb4tk9kAHqOmW1tkRgheoBtWdIZTTvW+A3+7CPAf4g+U5ZfZeUtJaOzoA9+W4r8kAnn5ZjPkxKEPndbbYEyuoEzv04/DA8f2j9m1lD9becYIoOu1ljrIGaDJaRgmPv9ORUA=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS7PR10MB5118.namprd10.prod.outlook.com (2603:10b6:5:3b0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Wed, 17 Jul
 2024 15:24:35 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Wed, 17 Jul 2024
 15:24:35 +0000
Message-ID: <9c34cf12-711e-4f36-8f65-873eaabf7283@oracle.com>
Date: Wed, 17 Jul 2024 16:24:28 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/13] xfs: Unmap blocks according to forcealign
To: Christoph Hellwig <hch@lst.de>
Cc: chandan.babu@oracle.com, djwong@kernel.org, dchinner@redhat.com,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <20240705162450.3481169-1-john.g.garry@oracle.com>
 <20240705162450.3481169-11-john.g.garry@oracle.com>
 <20240706075858.GC15212@lst.de>
 <5e4ec78f-42e3-47cb-bf92-eddc36078edf@oracle.com>
 <20240709074623.GB21491@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240709074623.GB21491@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO3P265CA0033.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:387::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS7PR10MB5118:EE_
X-MS-Office365-Filtering-Correlation-Id: ed0dc4c7-991e-4e65-bc74-08dca674906e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?dXhjVXhTck9pWWs2Q2VXQnRGc2E5Q2g1aXowUkRoTG5nSTBscEVuQ0x0OWFV?=
 =?utf-8?B?WUY1SThhbUQxT2tWYWZGY0s5ellhZHhwTWw0dDRwL3RDSDhPUE5LRVk1NGw0?=
 =?utf-8?B?TVpFTE13a3JTcEZYQ1ZkTlJrczFHV1lxdUZieUZlb25PNmk3TjljRi8rb2VO?=
 =?utf-8?B?dENZZHZqdENkNm1lUFFYSDJNbFJzUDFhUkdKeUt3NHpjdzBhUzRHMTFVdlFv?=
 =?utf-8?B?UHpFcFpjQWNrSERqLzlLaWdTYzRKeFNyYURZMk9YNzNtUS9yTUNlYzFpamNB?=
 =?utf-8?B?eTd5TThaaWJYR2k3d3AvTnFyMnZvTDRLSUFFQ2VtRnRGMWpEcGg0WkJqSllV?=
 =?utf-8?B?bnpvY2srQzEzcGpKRVpYYVJMNThXNHhaTERwbjJGdTYzaTJ2V3N6MEVkZ1cv?=
 =?utf-8?B?RWU3UTVmbTJ6Y1VuZEVhdHRkcC9UVEpKTGxWMDJVaDcyaXRJT1UyTHJ6NW1m?=
 =?utf-8?B?SUtqMFFvZWJCSkVYZUhBZXV4cHJvWkcwNDNzRElKQkNlSDVORDlrR3YwLzlL?=
 =?utf-8?B?WjZGc3JNT3czdkhLTDhDMWMxcDhsZEtsR29BT0o0M0N4Rk1LTU5CMUZzMzRH?=
 =?utf-8?B?UE04UmQwQVJkWjBCYU5QYnZ5MEJyakIyZ2RGYVdxdWxnWUJJY3NaUThNZWMv?=
 =?utf-8?B?VWl3YjFkRzJRQ1RpY09LZCtyZDZELzIrNTRGNzlWeWtTTFRxalhLbUJvUTNn?=
 =?utf-8?B?aXpKckRZZnNLYjZxSTRmZ1pRWk8xYVFpWWwwMzh0TlhrbEFKOFRLOEkyMmth?=
 =?utf-8?B?bFZrSGUvelhLT0F1SUZOUUVKUmt3QU9UMmZNUEVQYTllRStEa1JoZlNKYktK?=
 =?utf-8?B?TXRpem51VkRKUDcvWFByaE1qWlBxRzFMSk5jL2k0dGhoUXdSbkduTzZYQ3Ro?=
 =?utf-8?B?V3BSZ2RIWE5idDV6OXVsMDFWazU3c3orYktwU1Q2MGtiMEI4TW12K1R1R09u?=
 =?utf-8?B?U3BGYVFrKzVQOFNndGpiY0JTK1FEdXFucTJlRXRwUFVVMDcrdWllcDJjdkFm?=
 =?utf-8?B?T2hoVFRYWHh1SmFMR2dKZjNQeVVvTEhNdFNXenZ2ckRDWXljNFRTK2o1M1Vn?=
 =?utf-8?B?WU9scWc4UzNQajlhWi9rTk1UeU5QV1JXRVpzMjFSai9XdkV2cE9ERFdXY21H?=
 =?utf-8?B?dFNSUHRzeFhQNWQvWkZiM1hFT1dPa1pMaDYwUElMNjFvOEZHVUhycTcwbDV2?=
 =?utf-8?B?WmtDTlM4akJhY3ZJUGNBRG9OSDRlTzVySk1vZ2RJS3RhQXNZOHY3MTZLWENk?=
 =?utf-8?B?dzB5NmpHSWZ6cVVHU3NndkYzb0dIdWNvU001MW1QRHd4eEFjV3RjVkI2R1Fv?=
 =?utf-8?B?cithdkJFNVg4TTFoRUV1cXZrQW8yVmltY2dCSkZtV3J6b2hqWHV4aVJYSnlK?=
 =?utf-8?B?K1dQMnMrMTdDTXNvN0kwWE9PdmJ4SUdwVmFkVHhkY1BJWnFNc2pwVit6bDNQ?=
 =?utf-8?B?TTNsbjJpWnIySForNXlHaWRyWVE1M3hVbnV6VGRCelVaNUJLdWhpa1dPZmd5?=
 =?utf-8?B?b0JCd29CaG1sZlg5T0txTGFVaWxIdTEwYjZXR2VSQXp6SHJnOW4yWTFqNjZ5?=
 =?utf-8?B?ZmVaOHJWV01nYnVzVmJBTEF0a2Nma2E1UW5SbTVSL04wWGx3TmdSd0ZmVkkz?=
 =?utf-8?B?MXA5NjhhTDZ3VnZuOERwSEFqNE1pTlVVYkRZRXh5TXorNU55dTdIS0RhLzFp?=
 =?utf-8?B?bnRSckdpLzVCMDhMbXlTVExuZkNLR2hJbncxekxmWFY4a3ZlMFEzRkREMTg2?=
 =?utf-8?B?WnpQNDBvRk9aaSttUXU3dWlSU2ZmRnhqbFVyenJwZUlwWENKV2VWbkdpOXJ0?=
 =?utf-8?B?bDJ2R2FNYUFCcEdZSFVEQT09?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?SGhqUzk1cERtQXU4QlUzWitVSjViRytLdmZJMkZxZlZLdVRFQkxKbHlPeFhn?=
 =?utf-8?B?SzRaTmx2RFYvb3ZWV0JFd2JlK3NaNFJBekF5K2Z6SkcxNmtVK0tXM1pWMGcr?=
 =?utf-8?B?cmR4OXh1L0E1QU12VnFSUlZRTGhzZjJyNmZ0UEVVYTRBbDI2WWtjZnA3aXla?=
 =?utf-8?B?bHBydEdkQVFkVEFXSjZBVC9nY1JNZHQ3dUJlNUVHa21RK0xKdmtPMUFkejYw?=
 =?utf-8?B?NzRaUVYzQkZKVXhDTUFWK0lOay9yTmJ5TThJUHZqVk4rSWsrUFJGNzdpVitQ?=
 =?utf-8?B?aW9qRmJ0Zjl1S1lZb0xYYnpCOE9tNmhWbE5LZGFyNGpYelk5cUxFOWZHNHBN?=
 =?utf-8?B?WFdWYXluSFJhcmxhYk42SGhYWWNIMVdYeXVBVmgwQXdYWnJrejdoZWtUTGgr?=
 =?utf-8?B?OGFiMGdRUWY4R0pxZThYMitKSHAvOEVwOWJjZFVqei9vS1pWT3FUMmVLMjZq?=
 =?utf-8?B?KzRDeTI5ZWltRThLb21jem5qSDJFbzBXY3pRTER0bnVLZllDL1FRN3psYldD?=
 =?utf-8?B?MWwrb0pRZ3lIY0dvK1hhMllsWTJOUkZjOGdoamZrVHhoTjl4NitjaE9aVmVC?=
 =?utf-8?B?akxCYng1cEx3VEN4RUl5aTJEbGRyZkN5K0ZCVkRlUFhUWlE3ZG56aGNzVnFZ?=
 =?utf-8?B?WkF0L0MxR1pyQnpBVmVnSjNZKzBiQXppYnpQajJvanJhNk5TSHROMlJUY0tn?=
 =?utf-8?B?QlZxdGt0VFJBWklDMktMUkFjTXNQSGsxSDdLYjdGT3dtRnpabGt6SmlXejc4?=
 =?utf-8?B?ZFBMOVozWStIdE90Z2lkbzgyaVJqQ0xxM0dhWkdGOU85dzZXUjdmVU9Sbzcw?=
 =?utf-8?B?K1owL3kzbjVUOEcwakNyY2hYM2VVQ2RyTEVFcENTdVdzU3lScWVpb3h2NUtJ?=
 =?utf-8?B?aVNvdDBsQkZaVzN5VlMwc2hwc1dkbVZmM1RmZy9tU01BZ2RXNGkzRERFcklT?=
 =?utf-8?B?azFIckJrY1MrQzJ0OFNBQnhNUm5qeHZVZkVXNFJidkI3VmlyZklNeDVFZEp0?=
 =?utf-8?B?OFV6SWpoRDhwa3ZHK0wwN0MwUmUyWklqeTlQNkVVUEI3OXh2alJBWmhXKzNu?=
 =?utf-8?B?ZGZnR25DRFUySklxWnJlbVVGRXd4M0krcVo3Q3ljTS9PczdBZHZtMmNqa2Fo?=
 =?utf-8?B?VUlkbGxYbmo4SVlwazFjeEhuNTVvOHdXc1dzZjA2NWwyNEtSTDRFdXhzVFlS?=
 =?utf-8?B?SVMxZHZqcWp4QU9Sc1BJNGxhazd1ZTNXOHg1bUYxVHdNNXZXTm5SSjRQQ2FB?=
 =?utf-8?B?dlFPdW9Ib2E1S1hPSDRKOFY1dE81cFpFRHBLT2wzdWcwVGRSTk5tcW5uRzhu?=
 =?utf-8?B?V1Z5cXg4Um9rTHF1N1dKSUVxWG42akI2VDkrbTJwMzVEUDlRa1JLUWpRbGU5?=
 =?utf-8?B?ZGZ2bjFvbk9JU0VDWU5kcE5yellDUjlPY0p4MHNzRlljeVU4czRxblVHb2ox?=
 =?utf-8?B?cXpRNlVZUEJ1UUx1akZ4ZFJKSGR1dnFaN3U4N0d6aG0wUmZxNlNOQ3NYOUxQ?=
 =?utf-8?B?VmdFZUFmbDBPbTlOWXZkd2g3cFZ6bUNzSElTWWplenBzREFXWGxMUmUvYita?=
 =?utf-8?B?S2dMYVBUNHZUd1pEVkFFRGU2U2RmMkFKaG8yTDdkQ2dhbWNDdzFUQ0djNzVI?=
 =?utf-8?B?TElKcnFaeGY2Z2hjdzlUNzNjU0dSVnV1UEVEeUJjbXl1VHRxZXdCUUFueGwr?=
 =?utf-8?B?T2UzaFJPamZDbU5xQWFTWGY1WVB4R1FSeTZVM0dIZVZSNmpUY1cyY3QxNXc2?=
 =?utf-8?B?SHMzZzUyaWp2SklHbGRuVjRsRkw5dTBkbW5QNnhKRTBmQ3YrME51ZVJmb25R?=
 =?utf-8?B?OXpFekxJL0NhTzJRd3Nub0tmbEJObFpHY1l0K25yL3JUWlV5bEtESWkwbHZx?=
 =?utf-8?B?UjRWd2MyOUtoSjJnSGxpY3ZGYW9FSzhHUlhEa09xWEVmTVh0c2RDbXJUVTRz?=
 =?utf-8?B?YUtLUjhIaGZCMi85UEtnTjZTY1BXZ0FXS3hHUVZmdGlUTmhwZE1OWWR2bXNw?=
 =?utf-8?B?V3lkbmFRQ2k3SU91SmYyUDNXR3MwcWxiKzY3elpsaTk5TGw4K1o5cTVCSmNy?=
 =?utf-8?B?Q3JwNlNVMEhMQ3JlcHJPSjhFZ0NZRUpiZmUxSzFyc3RZZEZwZWNMQXhoTUdm?=
 =?utf-8?B?N0daOWFsVFJ3SkRTSnNpTFJ0VDhyN1RrUkVuSFRORHFUb3VIWVI0MFVXY1Nt?=
 =?utf-8?B?Mnc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	KmrtEsKpsq9BVc21KrdNsgDXSthYjVrypfSXJXm+jOU6n6cSQcAYTgg3rMXE7pSlkg3JaiGCDTR04AUS71bRBJ26hHG5Rp7WRHH8Cgv0bYA1I6D5WCabi0JVs8FbuY/bb0QAW02PG+lpiI3BqWZy8Gn75Y/ZYLxYTLvQ8YJB4uCdDlthuKt7NP1fymdEOeFg/WZMeKTSo2ranagf+PiQF8dvfl8tNQHng4KKYNSgb75jFYlHxeWbTJz0X80jvLAqyBzlvdK7Scc+EBA+XuZoBx55JjWm+d6bzEC0hPhdPsXcbru8LNQsrk/eNYG5sZ445iRFJaelq10pcexYcXrRy6HBOy/dwZLdehXnidB5afg+O2jvHv4neWz4fMecTZYL+wa73a4S9FgZmZzhjk9/Qu1MthmY0vyYHNc+4/PbcwAZtvQh3R7grxN4u5frXkXDby3xRtfYc2eMKUfrR5pvh2grWlBOGVlfMo1exMI6eR6LrwMcRvXb5eAWlalcuE9sj2Mn3Gk8c7X/SG92ZqbgN+xPCSnAh8zi1Preo+Vup4KafP0QDDgeHNkX8JXu3iLO6RrzzRGSHkFXO1kJvdxg7N5AUo2PIukwFg30fhGa4TA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed0dc4c7-991e-4e65-bc74-08dca674906e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2024 15:24:35.1620
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tWgphkJEyBqy+/ld5RYrLkUNhI5gIfI1aVFdGsJFApfts9MED3Dzjxbyg/wHrQR4vAX11KXuXg0YaOBuQh1HzA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5118
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-17_11,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407170118
X-Proofpoint-ORIG-GUID: OwpRWX-Ui8_bhzd1A2b6sexC7h0-VMqU
X-Proofpoint-GUID: OwpRWX-Ui8_bhzd1A2b6sexC7h0-VMqU

On 09/07/2024 08:46, Christoph Hellwig wrote:

Hi Christoph,

>> Using isfa (instead of isforcealign) might be interpreted as something else
> The check should be used in one single place where we decided if
> we need to to the alignment based adjustments.  So IMHO just killing
> it and open coding it there seems way easier.   Yes, it is in a loop,
> but compared to all the work done is is really cheap.
> 
>>> We've been long wanting to split the whole align / convert unwritten /
>>> etc code into a helper outside the main bumapi flow.  And when adding
>>> new logic to it this might indeed be a good time.
>> ok, I'll see if can come up with something
> I can take a look too. 

I was wondering what you plans are for any clean-up/refactoring here, as 
mentioned?

I was starting to look at the whole "if (forcealign) else if (big rt)" 
flow refactoring in this series to use xfs_inode_alloc_unitsize(); 
however, I figure that you have plans wider in scope, which affects this.

? There is some real mess in there like trying
> to account for cases where the transaction doesn't have a block
> reservation, which I think could have happen in truncate until
> Zhang Yi fixed it for the 6.11 merge window.

Cheers,
John



