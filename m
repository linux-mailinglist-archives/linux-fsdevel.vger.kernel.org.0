Return-Path: <linux-fsdevel+bounces-69103-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 24899C6F2D6
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:14:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 36B4335D018
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B143023EA9D;
	Wed, 19 Nov 2025 14:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="oLfUFhpI";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o/uKtkVl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01B335A139;
	Wed, 19 Nov 2025 14:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561116; cv=fail; b=rEIyPg6cpLY4TXe4GKDOR3NCK670/5r/eI9D79yNx4q3s8gMLYqAyYXixJzl7gRaQodYew1FqvNePtUnA4hESGnMBSN/ilalyFGiX8eLf+UCFEfghPofckZEWyUlZ+ENoQPzg1KrSgRqY9UFon2uXy6JVHLXbtlmIPFway+ZGmI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561116; c=relaxed/simple;
	bh=ahLxTjbVA1USLvSDR65QEu4HiIu0pf/ZrvvU0zjZxC4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=eMgFGCjV6cIfZJ5imKXvZiy499oEzzNrSuX1XdzzzntVKkoHlQTE1FmKZMnmqV/IuzqE70HZkhOJVahRwfOU7zARgIkKQfnd+i4gYnTQ7iy59AI9uHD+TpR8aIUGO49F8xCHotdeKO9IA3Y2L9hxzEv5LPsEZ0+6R0ACCfD971s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=oLfUFhpI; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o/uKtkVl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJCpAQA013829;
	Wed, 19 Nov 2025 14:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=p182NbMHxAe72392mMXJpR9VQsU5STDyp0vbeiSwOwU=; b=
	oLfUFhpIyAOvXERPFk2f1Ewdo5UrcqZ+WE0rhClOrIJPsHbGXc6+coEvWBoPfhvK
	i9aMwi9AKPjMSeymiQEKdTmfMjzjaA646f28r8X+wbEHl5KNfgeNfVk0+OfPnzc3
	8ZAFZH+OURPFNS+CVJ4zuyOMqkwh7qeuppga/S0qGdSihyhCE/DYr1MZp9dXUS6r
	4e6BRxtpZQIodozrf42lopa0ggcck26wzfGtmlN/mQLLT94QK0yg3VcW7OF6NUHF
	kVCaXiLASYjsQ33GVq4skawci4ntYqhpLwr6CUHF7rsMFR93QrQfp2PXpDD7e8L4
	NcIyQwMp7ormvhtDAN34RQ==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejd1eykx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:04:26 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJBrR5L007832;
	Wed, 19 Nov 2025 14:04:25 GMT
Received: from ph0pr06cu001.outbound.protection.outlook.com (mail-westus3azon11011004.outbound.protection.outlook.com [40.107.208.4])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyamhtr-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Vni43zC/IXbKlplexluxmSd5LXzXjJWsFtKosgxd8shgq+8jJq3tJnP97owXmVjAVpzBcxvx5nJx9WCNOKSsKydkRP1T12lyU8LTKEZQPqeiSWaW9rHSk2hazyXN+P+uJSRAZ9Z8Ub75s+xKnQgX3LzpeDCXsay4bLxApLyt0oW3yfWe5nS+oXaOqOesGAF1R/KkW9aTggDz+Qvz0w35orFDnC8ZIFadl6ZSwJwtxXKpp2w3u49OYqgS7l33QETQ2yHQhwK/kuK+pGh2fCiP6woKEtEKmvQ/UORmRTdPi3l6o/wSmnyxfBOHeVn7GwWOqb2mKx6BDUPOVOSywYEFnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p182NbMHxAe72392mMXJpR9VQsU5STDyp0vbeiSwOwU=;
 b=basC5HI0PzqjorPAhqwTNJ07i8KEJpINi/rG7wvjBu4w5w32Gtg13b3cfk2FwkxsXBHTYfsvk5vbQNOWtsfwoFvNqaDQh03jxGmK6tAWzFjWg5inPGYQ1RFj8f7kZI9cnKKzR0N+Clu7+IZ2LK/Fkkk1/FQr/tszIrJ9vDIgCFIcKC28uD4/Cwegu6PdWZqFuVc0hfejsF0rxFo4wDxkR9Kx4jLkJTeCYO1L85gpBy+q5LpGO2qHeHSaOD9NSDPgi0hQLEE2dNNfJ0byOso5aTHPg97S4MW+B60zld7+w6cTTjK6W0WyZj3MRgeBT1BGcO9OFtzeTa1xjA5mLu6SrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=p182NbMHxAe72392mMXJpR9VQsU5STDyp0vbeiSwOwU=;
 b=o/uKtkVlI4zEBGZeLcY4yDoCpA9eIAUBb5bQKpE1alS8ebqcYxnn7OQBR4X117GwA1F+DmIGCpXGfR6BWIxCjzUzq3445bPKkuuafvgH5nd6femJ7JbPwXTPhWHJQstvLLClXtBcHwH70Puliw6NxK9RektNEieFQXWHQxT2xL4=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by SJ0PR10MB4623.namprd10.prod.outlook.com (2603:10b6:a03:2dc::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:04:21 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:04:20 +0000
Message-ID: <8a55618d-ea6f-4fda-9be4-e1a76906d874@oracle.com>
Date: Wed, 19 Nov 2025 09:04:19 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] locks: Introduce lm_breaker_timedout operation to
 lease_manager_operations
To: Christoph Hellwig <hch@lst.de>, Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-2-dai.ngo@oracle.com> <20251119095419.GB25764@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119095419.GB25764@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR04CA0023.namprd04.prod.outlook.com
 (2603:10b6:610:76::28) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|SJ0PR10MB4623:EE_
X-MS-Office365-Filtering-Correlation-Id: 485fba42-8b8e-448c-78a3-08de27748959
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|7416014|376014|366016;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?M081QmpFVHNDVHRHalhlbTNDSW9xWjBSYUhzNWpHTnhubndUSmo0RjhPNXlt?=
 =?utf-8?B?NHV3VTVYY1JBbkpqVVl1eDJISitOUUEwdlZBSkVtQ3hvaittNlo3emU3L1E1?=
 =?utf-8?B?cWQ4WUNJYzIydVE3WE9HSzNocXdZVDIzTkZWOGNIUk85cHpVM2tWaTRVcXpN?=
 =?utf-8?B?akhWM2IyRGY2bWZGdDRMdWxXTVVZdDVRaFV0cnFOT2xHWHZkY3lCOEVUcWFz?=
 =?utf-8?B?RmN4U2F2dDdHOXJWcmtiMzJxQ1ZXSmZNeFdRa2h4dXRIWFZWWXNDRjVjVFpT?=
 =?utf-8?B?WDV1NElMRng0cks5cHZFSWc4c0hBWkpXdnpITW9LandaaHlmYjhxNDN5MWxP?=
 =?utf-8?B?S1Avc2pEU01DNmtQMzhGaGNqSDNHdGxaVks4RWc5TUdZSEo0Uk5LZll4Q3A4?=
 =?utf-8?B?NmRuQm5DR3hBU0FsWHVPUjhJbnJCQXYvYkorTWtpeVgxUmhVbXpKcnNFR2RZ?=
 =?utf-8?B?bXA4Z1dSTGR3Ymh3QnZsMlJIZUhoMC9jTHVIeDBaSXdQV1NzbmdwdEJjNDI3?=
 =?utf-8?B?UFd0VnZJeHZRRUVDWFkvZUtGTU9YZm9aSzdZc0VHejFXTDZNL2t1RDR4YnhW?=
 =?utf-8?B?dW9pZDBlNTYzd0NqdWF1anVHb1IvdHJLdk9Qa3pvTFk1L011ZDg4ODNHUk1W?=
 =?utf-8?B?MExhUE81NXE4OThEVnkyUGVXWXIvSDhUczhmK2pzdE05dElONVgxclNlMnlY?=
 =?utf-8?B?SkFjSU5kUEJ2T2tkbEs5R2tDY29PY242QmlPSU9VUFowVmc0T1BDRnhKNG02?=
 =?utf-8?B?b1kxYjFyeU1YRE0xK0I5cFF1N1Fyc2VLc1RabWw5eE9oSXhLVHFJTTQvNUpN?=
 =?utf-8?B?T0srMkl5b24yUkVJOVdxZUlNblZ1WkhISDZ1M09xVXFRUEhGck5CbEdMUGM3?=
 =?utf-8?B?MiszaVVhcVNYclN5UDR4cEQ2VmVRSVl5Q2tWRUQrU0FPY25tL3VLNHR3WXBQ?=
 =?utf-8?B?QzYrQnNxU1JIWjlWVHRiNzc2Y1RQVHhZalVIMjJhWlNTWWRTWENmTmdjZ2Rm?=
 =?utf-8?B?WEtvRmgvcGQzcnJYbWYvSWgrSzFEK1NCaFVWaHMyeWQ3Z25oQ2ZHWHVGWG5G?=
 =?utf-8?B?YXFmNEx3S1hLaXZWTUh3T21hekxwV2x1bjkyT0t2NHV0TVlqd21icVJLN3BD?=
 =?utf-8?B?Y0VZdGdnWDh4bGRFdHQ1MUNDa2NraWxqb0g0RVZ1Yk5mcjQrN1lPQkxyRWo5?=
 =?utf-8?B?UlZnSE40L3VBclYveGJWeVNqc1k2bHUvS2lVcHNuUlhzbytSSm5NZTdoOEs2?=
 =?utf-8?B?VUdNSkF2OFF6MFJ0Z3B1cytQbUFZVWNCMGZDZGdPVVZuZlE2K1BLQ0dHK3By?=
 =?utf-8?B?dlMrbExxMjBCRjJGUFR1RSsxOHVQUHpON2FtWkJVOEx4Ymd2UWxodnd3Y0RO?=
 =?utf-8?B?dmZxKzZjWGFKNHFlZGZQVXVCRmpyRVpNVUJzVUJHK3QzRGtONzE2VndEcEY3?=
 =?utf-8?B?ZnpUcGZiQUM1TFp3bDRabkNJWXRxNFZCMDlqVXNBNGpqbjcwbHVIQVI1OTRZ?=
 =?utf-8?B?ZTMrWUE4SE9Gd1I3bjVKdTBQS1BNTXNnTDF3cmVtalE5UTRVK01MQVVkVC90?=
 =?utf-8?B?NU9mM3pWK3g2cGxyQXlkOHZLdUZTMHRvbm9pbXFYaE5razVVSFpiY0hOMWZE?=
 =?utf-8?B?b3E5TFJ0OUdTNmlZakM3Z0t3aWhJdEFsZUdiTzNxcDVFa1FBQ0xqTHhUemhW?=
 =?utf-8?B?NzJuNFkrczljdXVKSTNYL09DSUtaQXF6c3R4TFNpWVpGNWoyeW0ybUJBb3Fi?=
 =?utf-8?B?S0l2MHVwV0dkWlNaVWpqT3p6U3JOanIxcHpySmlLaGN2TG1aMzNLWXlqRmxz?=
 =?utf-8?B?b3dWU0NrbEszdEJtYWpvdHhJTWNEYzVyOS9IcEdTZjVFVHpsemJaWmEvcTdH?=
 =?utf-8?B?cHFISlpBOUwwdVdoL2M2L3dSWHJyZkU4aUYzSmRtSjR0aVJxM2NaMmp0SGJV?=
 =?utf-8?Q?OrvKclqMCdqSfh5nx4o2aZ94Pf/Plt/d?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?SWlDWFpURHcxZ0ZjVXZoSHRSMVNNSDdIUWJUdTFzRDdaakRVV2pvUFVOVHI4?=
 =?utf-8?B?SkdQYnRFYlhvWkhhWFU0bUtsb0tWRjdmcXJNRWJHRzBtazcrUlZocEZ2Znor?=
 =?utf-8?B?c0JDZS9qbEpCWVNpQVU2SkVxMEg1Q0l2MWFidGtHSURoU1VFanNJVUxjWmox?=
 =?utf-8?B?YTZrSXUrRU5nTlNKcjJ0UEgxTHYwcFNXMTdtK3JaNFJNZXkvVGR6WlVQbmNE?=
 =?utf-8?B?VVpyZUpUZWsvaFVOVzFjdzR3VnFqN1ZwRitlZU9WRUhGazI2M1oyb3BqUUor?=
 =?utf-8?B?MzgvbUsyVHZiakEzMlQ4RDVWOEkzVnV5SzhVU0NYNmFEMUJUdHRib0MzZGtW?=
 =?utf-8?B?Sm5vMGoxSDg0ZHpZQ1ZvcWNHWEJaZVYzOWxBcWNpelFqVmJoRk5DOXM0cDdG?=
 =?utf-8?B?MUU3TWp5Wlk1MEhKL1dkVHRFMWp4eFVoL1c5enF3MllZNlR5bTdaSTBpNGpp?=
 =?utf-8?B?TlhsTXA2RVNxL04zZXBMdUFuVXdTYTJBRUFFbU45amtjaTVoQ0FOVGp4VTdC?=
 =?utf-8?B?MDVvQko0bmljbXFxT095TzBLemNxU1YwNkdhOEZaZkM1dWxTRVJJRDBIOW1D?=
 =?utf-8?B?QmtDclBzWVFYQ3lwc2UxbWo4SzBLd1FQcnc3ajRZcVVBbTVmV0RmTXFDTWtX?=
 =?utf-8?B?SEFGeXduZ3d5RGJDVlZCZUY3Kyt2cFJjSzlHcXdkZGVMVHFXcEhXQWN3MGpv?=
 =?utf-8?B?aEI5WFFvVXUxbFVpUHE5TXhFS0xEb2NzUmp4WlZQL0NpaU80V3NNUXYwUW55?=
 =?utf-8?B?ZGhFRXVtNTBHbXBsVnBhN2xHaEJkcmVIUG94NmdHY2l5NHB4OWhMY0FmMFJV?=
 =?utf-8?B?K1ZMeDE2OWFOQU4rejB6cmtlS0hHWnlTSExyQlZuT2RhMS9WUkt5WFNTcncx?=
 =?utf-8?B?QnNlV3hLS002K2Ixa0dsRGw2RFhpVzJIR2RyUStKcHM5TTBrVmR2OGlvWXY1?=
 =?utf-8?B?ZHIzQzRRN3B4MHdxUjBGem1OeDJ1aElrdW5KOEdUWWhxSFFNWlpESFlaYVMr?=
 =?utf-8?B?VDJncFFheGZUK0poRGVnYksxdkFxWmE1KzRHanRLZUdRczdUK3hyVVRXc3gr?=
 =?utf-8?B?eUlQZEhQQ05sSTBXZGJ0dUtRNmxaTms3STBTK1hlaFo3VEtaMStYOTFnN0Nl?=
 =?utf-8?B?OWNHRGZ0QXpMd0dySjZ6Vnd5QXJ1QTdZTEdGTmRXdzFTbXFPWHRpbFJ0RUkz?=
 =?utf-8?B?YXZMNHc0Y3Vid2Z4aVhIUHI1cE5WMGljM2ZaSWRxeU5FN25lazc0VGY5aCsw?=
 =?utf-8?B?Sks2WHZnMytCRXZqNGpVOGdNcVFydXBzNHRvdk0yMUZBRGt3dDhySU9oQ1dq?=
 =?utf-8?B?bC9qRHNrUndLbmVnd2ZSSXMwRzlOMDRUSExDMjlIVmM3Mjc2UGVuODJ3ckpq?=
 =?utf-8?B?OWpWMFQ4VTZXanVpR2hlTHJIck1CZ2pZdXNrQW5MbXN4VkNCRVhtQk9DbnVu?=
 =?utf-8?B?bmYxNXFBZmxsNGh5TFVTS3NKUXcvTm9tRytTWGlZUjNBM1Y0VENreHlLSjZK?=
 =?utf-8?B?YldVN0pucnBTNkxrOVd3enY1cW04WW9zOUV4Z25NTG9tQkRBK1VTQ1l5a042?=
 =?utf-8?B?RlRKNktSZXhXRGVyczJyWkpuSWRxTWFEeW1OOHo1YUptRzJzT0xJcVNhTC9D?=
 =?utf-8?B?ZXFWN1JiUUFrWXQyTDVJUnZMbDVFWlNkZE5aN21hVlRYc1lhT1B1VjZLWmJO?=
 =?utf-8?B?YmVwaUpEYTZTdE12eGltbDBUWW1NWU1tNFBPYW5pZWN2MHNrLy9YT3BMVzhZ?=
 =?utf-8?B?L1NRQ3dRVDYzTkorUjdlTTRGNjFOa2EyWm9zdDVCbi8vY2pVSFRUMnp5RWdz?=
 =?utf-8?B?aFM4bnFYWVVlbkpPTVUrc3Evc2dIOGFWSmpiMXlHTVNNQUhsSzJybWhnK21r?=
 =?utf-8?B?Q2VWb2tibkJWUzY2b2VZbzl4L1hqNEFIVCt0SWF2YlB3ODJNYmhsNXN1aVEy?=
 =?utf-8?B?QUI3VUNKMkhsT3o4M09pWG9PeHBFbkl0bThJb0liWHdZK1o2cktqbU5hN3lG?=
 =?utf-8?B?NFJscDhJZXp1RjE4Q2JtditVbXZDeUNQZnR6SHZLSFZDNGRVWjNhTkxnWCtt?=
 =?utf-8?B?dGJJT2ZsdGM0WlFCRE04akwvSEpjb1lHdHdSc0hmOGdqSUR4ZFMzMUxtT3Ex?=
 =?utf-8?Q?7OCfhDGKXUjaOt1+OpYqMZvEA?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	U1CTJiUmTVl2dKMDkluh8tndoe1rhkrUjxGW8eEhoggh9YfhSKkV3uYoKXBr1a/HROhJnuSN1gpHpMVV7C8O4BQ/UQmwsN4KlurY3Ql+g1RloaIjEzCwkBLIA3fH4OJUKoWT1ghre3+w9JJ+7HYib8hiaA7+9JRD8VVxtqjfJsv60Z2jYkTCjZiHPrTLAuIoDoyP9r4CTOCgCHSK/WlKUXaicDUq10eOnUZyOznY7kOa5KIFgEjbQCBAvTcSgS0zN8wheqXH5wd0/WuUL7gzKW4Of+GYhhsNzASjnFo9tzNSrQNcRRcAFgMxo6horpxZOubhjc/HeUHnitV6am3s0oXKwvt9h2aIt3Sh53xpyBhkoIaU3k8UJHzyBm5MSJe7PHWaLapbKqtu0OFmM6oPvGYCR1Q97sdo5z9zIOlKKaGl6l/fdZ+ZWbKWxsJJtcwQNDRLosEUqchwzTXg7qgrK7R5wouHese5OAaNVaNxxmRXmGnvYZieTU+W0FaxUWhn+3x39HnQOXkBfplyBXcZsEQ6ViMUv2W8a3emNaDBs6e6e44Yw7azxxpIux6G3ZzeDso9wE1etQCakeVWVXHd8pMC4DVFCBHVXM5IKKEqA8w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 485fba42-8b8e-448c-78a3-08de27748959
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:04:20.8715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QAOWseoMlq5nRL0Rz7PLhqgBpWy39+jLJGJB1SKlq+5NudnefWFuhtj412vWJtwMMFJCFJB4odDJ5UYIVLKdTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4623
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190112
X-Proofpoint-GUID: AemCh1z-e4uevVpOK5DUcU7g2QqJmWpN
X-Authority-Analysis: v=2.4 cv=Z/jh3XRA c=1 sm=1 tr=0 ts=691dce6a cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=vs6C7C37WQGOd3F5zBEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX2n/oWUpFMU3d
 qX4EXKd78j2Bl2OLef7wGkf1n2grePaDpp6if3JLpYwI+iBCvU1Lx1SALG3ksKV9FJ4MBcTr2kc
 0Ho+FW3gp2c1TSLg/4CtGw2fZmNq3WXpf1uyy49osv68P2JP1pOvLBpVJDC7O+nwNKDKt1Xv7dg
 v9jA4ggcfIcGmPpfIsL1MRsZi9Kpf+JCk8noQyfoaC6eDhxy/JV3QdYxA5qlwvsU9EZIKByOgaa
 voJVBKq1qskKkN0S34NFwxI49XolIRiCoXjNUsIAaB1+JZZE0stYUEH2dqdNpI6eHJFnoNlu0VG
 v6KVfz1WgcSmtiwd4HzXrKPQtU3cGRmcypdlRuDT+voYl4rM3EY/CeE+vQhvHpumBi45zBjAwhS
 fpbpQTNdj6Reg/RFNDVo7Zvf7hVSqg==
X-Proofpoint-ORIG-GUID: AemCh1z-e4uevVpOK5DUcU7g2QqJmWpN

On 11/19/25 4:54 AM, Christoph Hellwig wrote:
> On Sat, Nov 15, 2025 at 11:16:37AM -0800, Dai Ngo wrote:
>> Some consumers of the lease_manager_operations structure need
>> to perform additional actions when a lease break, triggered by
>> a conflict, times out.
>>
>> The NFS server is the first consumer of this operation.
>>
>> When a pNFS layout conflict occurs and the lease break times
>> out — resulting in the layout being revoked and its file lease
>> removed from the flc_lease list — the NFS server must issue a
>> fence operation. This operation ensures that the client is
>> prevented from accessing the data server after the layout
>> revocation.
>>
>> Fixes: f99d4fbdae67 ("nfsd: add SCSI layout support")
> 
> This again does not fix anything.  It is infrastructure for your fix
> in patch 3.
> 

Dai -

I don't think the Fixes: is necessary. Please just fold this patch
into 3/3.


-- 
Chuck Lever

