Return-Path: <linux-fsdevel+bounces-41053-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCADA2A5CF
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 11:28:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850691889A5F
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2025 10:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3754B227569;
	Thu,  6 Feb 2025 10:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QSynu+NV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="nw8uR+q/"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A333222688C;
	Thu,  6 Feb 2025 10:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738837684; cv=fail; b=dRLra1YHQjW4tAKTcfZDvPujCGWmBc19Ea88AuWcSUPjGsgNSPSQ48UOqIDlIyFs9FHIkD3Rlynei5raB01ETyi+2Kj27+IiOVz+oieIsRcrvOCodycOccA4Fm59UBTRYR+ntWR4Ur5HxjMvzE+s8GcDBlR+VL9W1PkEmHTqc2A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738837684; c=relaxed/simple;
	bh=+Ta21YzNeQTBQ8JgrCqSZlzAQqAzeif2V2fwxVazFIo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ohyK4gtIeMAE0hw3QgiQqdM2ZaEr63D9bpETiOgpq62Xv1VaqfeHTtlMx6TUQIhBAX6v3L65kunooF0Rqp8WCyF0mojgJz4pI1kAYQlVYCknFBF+8921IgSQGGrV6dH6yh7jK26PSaMqQ72iO36tLQj5U4hT5hPMoa4lX1fZjxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QSynu+NV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=nw8uR+q/; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5166Auvl031571;
	Thu, 6 Feb 2025 10:27:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=/0CgVZBe9GpifS6HZE7yyCqUWQZ1SSLkjodTU8IkquA=; b=
	QSynu+NVfFD06LkJpBerO/gNVY27n+pDU7YNZey7MOf3oCaQiSu84zHquedDOJK0
	3e8PYW9xa58suPG/elYWzOcLiXzwoCmXekM5dl6ZF4CRiqeobuz9Lb5en2hxgBkt
	IIJa0BnadF8JK56oWKLWisa9X7ZMCkrWdFdmYRu4hjTvG46X/GUUxF+wV9aNUkp3
	EO6ka/vwq8TBcGpOVlQTBNr6AELoqNz/WNDXnQ0lYsc+4kVXN/IsjrVC36ru3BWp
	Lz3XgTwrws4UMDkayOcqdtYFehMxwxDSXvF2Z1X+VBMhwPwhIL2KSfVOfIRlpuYn
	HWOZXSkV0zySN1VgnQvZ7Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44mqk88bfh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 10:27:52 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 516ACpEo027814;
	Thu, 6 Feb 2025 10:27:51 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2176.outbound.protection.outlook.com [104.47.55.176])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44j8p5n1hw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 06 Feb 2025 10:27:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wULPnWexpeiTvcg0k+BV5EiOWkxNJwMHYcoEYqwgouF4Dbj44XPgPg7dp5jJUWIZP7vXYMdmEuIkdrO19Pp9zXAqeuJh5PXdx+XwdQ4lyayR+5OaE1C3AJUJHiL1KQ0mUZEIPVk0giIQSwEB2mnI8Um8IE/fCGbKsO+LJR0SSh+E6tQ1XNCOj2uKdrFrUw4/FlxNuqL/7+Wi/sWTvDlOVpdRqQ8ELIPuFILmQvtKurnNfitLxnomaQ3mzPTJmwxECUMJn0bFUL29DYcPnDndNCiKZj8yz+6tIgyqBpeFSck0hWi5vd6SGc+uNdEVoMCTIBCj1HmlHyDdqLpvzTutOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/0CgVZBe9GpifS6HZE7yyCqUWQZ1SSLkjodTU8IkquA=;
 b=WpQJphj5/BU4bzRB9hLqK7I/sBb2W+97jNeyDH523pXY/BnbAEXd1hn7usj2enrv7iDIPlenmDt4NWfMQWTgMSCSB+LvYYwOHgLqXDnGHAE8hQCronumX0rRt1yI0ttg8tCuQPyd56S2dGC+/WuIQb/g7TCUj2HIdKTZrQFzPBr/DpMcCjtpG2lkjWmEo+5ysbrE29mJOPYL97D9LijocK3HVr+B1kUIL3l+qNcDd3pdP29I4EU9ISN2zDf2nncb6m3rUMj3y8n5tKy0BF7/7XiwNkxH/nkosGu+xP6J9mQ4NNiiG6KuxuQXzwcQuwa/yFjkZmhNHzpbgANxD6koHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/0CgVZBe9GpifS6HZE7yyCqUWQZ1SSLkjodTU8IkquA=;
 b=nw8uR+q/3W+BVOlRxaXlfvbM+BrQuiY2cZrQ+k/bwnuwb2u3+BiXUuOLpffqnQIJId+kLGNA4BZpgAkerjwTBuFKonTKkmC8qCJHyOvDRTGqFwkQO1YfmZREtLf6GBr8RalooHx8SWE9JZiXrmQjx08d0rGzv7MTc5aCuR2CZRU=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CY5PR10MB6238.namprd10.prod.outlook.com (2603:10b6:930:42::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.26; Thu, 6 Feb
 2025 10:27:48 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8422.009; Thu, 6 Feb 2025
 10:27:48 +0000
Message-ID: <ee8a6ff2-d1e3-4ee8-9949-cf57279ee5d7@oracle.com>
Date: Thu, 6 Feb 2025 10:27:45 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 08/10] xfs: Commit CoW-based atomic writes atomically
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: brauner@kernel.org, cem@kernel.org, dchinner@redhat.com, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, martin.petersen@oracle.com
References: <20250204120127.2396727-1-john.g.garry@oracle.com>
 <20250204120127.2396727-9-john.g.garry@oracle.com>
 <20250205194740.GW21808@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250205194740.GW21808@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0138.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:193::17) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CY5PR10MB6238:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e2c894f-6b6a-405f-c9a6-08dd4698e721
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|7416014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUUzczBWWjdsR0EvMS9LRVM3WjM2WXplOEllZm9YRFVuemtUWHd6bnJKYTBu?=
 =?utf-8?B?Qi80QWNkR0RiQlhSb2NzNERsWDMvRi9JYTd5UlpGY2RyT2FMU1QxZVAyNXQv?=
 =?utf-8?B?TmdDS0RLV28yOWQxUGZ4ZE9FMVJDWHBaSDVKY0ZSTEZzVUIwdzRjb3E2YktD?=
 =?utf-8?B?dTJwNGpKQjFIcHJlaFVxZngxeDBxZFNCdTIvVkRhbXBzRDV4QUh4amtQZThz?=
 =?utf-8?B?dm03Ri84RVNBREVJd1VrQkE5V3VQV2twelR4ZDFaRVhDNXhrUmV4VHhXQkFI?=
 =?utf-8?B?L2lkSHF4RFhjdEZxOWVJUjlYbFhVWWpMbDRVam9RMk5PTXMrMzNKOXBZTGQ2?=
 =?utf-8?B?SmdOdkY3Qlg1MG12bnl1UTNuUG1uTmdYbGtMVkg3b2UyME1DUXM1RzVQOU8v?=
 =?utf-8?B?VkdtVFdsSnhTUEFFM0k4SURSUGJzODNFQmpseENmeSs3cEs1Uk9xazVVK0pH?=
 =?utf-8?B?TWhwbFBrdWxvU2RWVEtwU3ZpaEticUxSR2UzL1dZcXFuclZmVlNaQ1VIV29a?=
 =?utf-8?B?aXZYRTJUSWRtRGN0eGNrb1BjMXlZdHlLWXV6TnRjVFF0SE95Y1cvSVF0TDgv?=
 =?utf-8?B?VnY2Zk1NL2wwcDBQcEdRYVg2d2s4Vkg4dmFjYlRxYXJWUy9POWQrRVdkTVNM?=
 =?utf-8?B?Q3VhTmJ5aUllbHFYNmNnaER3NkpNNnpuejRMTW9wVUt3aHIxR3gwM2dnbjZU?=
 =?utf-8?B?dVdKUDJ1UDNYNTVudjc4a3FDb3dmUUI0Q0swVmNIYkJyN1ZNdGIvWllEVFJN?=
 =?utf-8?B?S1VzK2ZsUmR5NElkdDZGUXBNeS9JNGdiOHdVbWVORGxRc2xxSWFwVEdpUWJy?=
 =?utf-8?B?WnVnWi91QUdaejdmejU1R3JlOFE4cnBBRktycHdTZ3ZKZXhMNjYzS2pZbVdO?=
 =?utf-8?B?cDc4RXF1a3N6NGVLNUlnajE3bC9UeG5Hbk5LMW5pYzNTeUZ4V1pjM0xzQkRL?=
 =?utf-8?B?L3gvVjU2bzVEdENsWmp1bUVvM0hMZ0g1aGdOSm9kQUJVTFd3cXJpWXBzeGZB?=
 =?utf-8?B?WExUVnpyVGhpbW9KaFZ3L294a3U5VmNCcXZsWmx4bWkvZHB1N3hWVHpKMWJt?=
 =?utf-8?B?NFVRS0NLbWRTRm5HMlJsSnE1bWNCUklxY0kwT2Q4ZDVvbWJWVHZQV3dmRUN3?=
 =?utf-8?B?dlhwbHUrTnc3NlFacElqK1JTQUJ5MEE4Um12ZUZ4YkxLQjZqMVJhNmR0KzRN?=
 =?utf-8?B?RW5PWVpQTmp0VWJpUkxOYzRoSjFxaHp2eTZ6bkVPVkk5b2x4TTNpRUVyUXNs?=
 =?utf-8?B?RUlneEJvdmVUbUVLa0FUS3pXOHpjeTRtUUNyUlNUTUV0TkRIOGJTS2xSRXR6?=
 =?utf-8?B?NjhmU1E3L2t0SnpQSXFucnZWaGtiU001WnRsSEhiRmU3dUVEelZPS3o0TkpH?=
 =?utf-8?B?bjdGZ1lrSGVHbEQ2eEIzM0NIVU83NTFJTkdFRlBER1NMeUdMY08vUXpmY0Vi?=
 =?utf-8?B?RDVCK1hGRVd1czBWM1B5SzN3VGplODl6U0RCaXl5aWhqbVdoRjJOQ1hkY0Nj?=
 =?utf-8?B?S2tlZ0hiNTlXU3RxbmNRaTlQV0RwcmZFSldRbklZZGR0WjFvSUIyQk5qOWRh?=
 =?utf-8?B?ZGdibTl3a0tTRXJ6UEdzb0ZrcnhKT2V3eGo5V0VYaEdGQTA3bnBXZTFIZFhj?=
 =?utf-8?B?U3A0eXQwYnhQL0dWaUZQM0NMQkM2TnY2eXJJUmxQY1NLOEllK0xOdmhUeHBp?=
 =?utf-8?B?c0p6QS8rcE0rZittZVQrcVp6czdPU2FoLy8yZFR2bHVKVExSLytvcndESFBm?=
 =?utf-8?B?WXJZSFRHMis2dEtzR0RiaENCNUF1YUlqQnN2SlF4dlZkL2s1Y1luUHRJUWtm?=
 =?utf-8?B?bTZKUE5oeWd0aUxiTk85emR6WUlESHc2aDZodXFzVmhrbUxua0hqS1BQaUVY?=
 =?utf-8?Q?sbwi0Rlo7n6bK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3dGRXJGOVhyenpHWTJ6YkZuZW13aHM1MzdhQjdFakRsbVhVSFNwblRIR2Nz?=
 =?utf-8?B?R0NHZVRGNHVYcVRQcXZyZkQ3Z0I0TUJBSWc4VVEvYm1oWk1GYjdmVUFsdXRK?=
 =?utf-8?B?c2FyN0J4SWNWaUhjd2VIYXNwc2Erd0xRSTNBWndUL1g2emJnNGZpSmRmOXFy?=
 =?utf-8?B?MUJwL2d1YUNHQ3VjYlJraVJmTXRCRFFqeTk5YkxOcWZKUEJCb25TYTBMSmtt?=
 =?utf-8?B?S3BnZVZYeFlWNndCVXhMbzd3UnB4clU3UU9WdVgzWmNtUVZDeldEYnFhQkVV?=
 =?utf-8?B?MHNkSkc4SC9BbDFBNzVzc1hSNEN6bzZpWFdFb2ptSDROcW9FWFFYZzU0QXkw?=
 =?utf-8?B?SE1ja1pjQVBsRnpsK21VYVBkUTBtb24vVmM3VThkTWl1cUIvMHNHUTk1Y3ZK?=
 =?utf-8?B?clBCM1VRMVpUaVo5Q0p1QkVjZldUN2Ntdm04aTVlcHRKR2piMHU3QnMrVVhU?=
 =?utf-8?B?YXdPZ1JRL2p3d1p1dnRJS3FYWWZEWThsQk90TzN2VWFPUU52c2xWSkVIbVQ5?=
 =?utf-8?B?SG5RY015eVZSTXlCZUNRM29YZXdhSEdiZ05keHQyMmJGeWZtQWM1eHUxdUFh?=
 =?utf-8?B?SytrUkFuNWg0dmRLSjBWaEVyVWkvNzJ2NkJDSHRaK1FTQ1RNYytBVVF0NEl1?=
 =?utf-8?B?akdiZ290aVlMN3VWNVE2anVKdGVXVVIzRE43cmNmM3RRVVA1b3ZhLzc3OXF6?=
 =?utf-8?B?NG5HTFJjcDZQZUZMSUVwSUw3VEhzMURzMkFSbmtXbVV1SVo0WmNjU3EzRkwz?=
 =?utf-8?B?TDVYeENJcC9oY240ZWZvVmFDckZWSXFXM25JRTI4a0lhYm54SU5oZXJDZGY4?=
 =?utf-8?B?dDlrYlBVdkpOOFdkaVc4TENxWHhLbVV1Zm0xemYwNm94ZW1FRkw0aXN0STUv?=
 =?utf-8?B?ajR4bzZCcE0va1A5eDF2N0VQT1FoNlgzYi94dTFmT0RuMys1WkhDMnZVc2NY?=
 =?utf-8?B?V1FUTEg2UGg2am1LNit4bFh3SWxtbzRjVjlrU01hVEFLeWk3M3F1YkQ3UzZu?=
 =?utf-8?B?SDFSMS9DaGc5UFgzMUVVLytXazgveEx4SlV0V1lGb094ZU9KeVZSUVhsL1Fz?=
 =?utf-8?B?dUFMcVNLN1dFbTZzbk9UNnBmVHVNTVBCMTNQdFIwcXdVZStHN2h5T3poeWdl?=
 =?utf-8?B?K0x6eWNYTFZFZ0Fvb2dHNU9xd2cvR3UrKzVUZ0lHVkdjeFY3L2NIK1hYazBy?=
 =?utf-8?B?YnRtb2puUXJzNDJEMFlyUnlLdWdMMytTMUVOZDk0Mkd1bEIxUm5HbGpzRmhB?=
 =?utf-8?B?ZTFxQ1diQ1hPUTdSM0tnNlhaMUtSQ29ha3MwOEl6bXFCb0lxbExlblZJcWpO?=
 =?utf-8?B?NWdMUmdpU3k3cEFjODFsWnVhUjl6VUp1UkZYMytKYldwbEppU3h2QWVCOHZj?=
 =?utf-8?B?Yld4MVBWeXUvZzdqaUlwUldrSUdDdzJ3MUlHT0w2d29CcElweGI5QzZKZGI0?=
 =?utf-8?B?VU5JLy94ak5CSEY0cXFWVDMrTGUyWVEwYjN5ek9Pc0NsWVBFcFlLdm1QK0l5?=
 =?utf-8?B?cDZ0OWNmOTZlSUU4R3dTOEd2eXlkTFhjODVHRlp5MndTWGhyQjZDVmE1ZzdX?=
 =?utf-8?B?YytZRUFEV1pNejR6SU5BQmNqZnk4WjNBeW5Kek0vZkFpa2NhQ2RDTDVGeHhV?=
 =?utf-8?B?TzBSUWh4WmpuRFZCNS82OFZYV21lM2E0YzRoTGw1Y1Znc1kxWnVmakFzQjRt?=
 =?utf-8?B?d0lWTzFuUjdtZFQxblo3QXRiM1l3b2JYdUEzOUNURHZlU04zTHZwRG9GMG1D?=
 =?utf-8?B?bFdKMXc3UnlIQkV0cE5QM2FVWEhnYWJtRk5FRy9IZHR0NDljc3NwZXhBSFZQ?=
 =?utf-8?B?QkRoNmZVRnN5aktxTGhwS1AxV2QwYTNUU1pzeGR4dzllRWw2eWlVT21DVE93?=
 =?utf-8?B?QnRnZEF3eGlhMFN4UUc5LzhPMU5GRXh5cmdXZTkwT1MyY0V4WVZPaGNYWDc1?=
 =?utf-8?B?WlMrNk9vVmM4R0p3VTJlb0h6ZGUrekFINUhGVG41ZjdCSmRuOWQvdzJjZk9D?=
 =?utf-8?B?TVFWVFd4d3Fxa0dDRFM2T29hMnZBam82cENjQjZwSjhlb3BERW1vWWpoWTQ2?=
 =?utf-8?B?bGtkMU5Xa2JjRkNkMU5JYnhSSHJDZ0hSOXltdFltbkVtSEFLREZaYXFEYW4v?=
 =?utf-8?B?RG10MDhmU1hoUGRIcWgvSi91aVVRZmhYM3gvd200RUI5VWdQZ09GZW5OeERw?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	bVDTevuG9bj/SLe60EvdeC+ElivYEMkeNpmAIipP9sM7SfOley66UFR3MSjRmEos4OttU7jFHZ1iTYSjFP9agM5APkZLFC0aSL3kBuXicLfu9DGh5TFJUNdm8dfXpcXbaLnN49xFFnzkOPoBWyc/gFV4PKEG7UfxOR2wau3qK13sO9gpL0/RaAjpTyj1KdqDdzDaDiIrackrf7C7TZcHOI4VJWK0rwUe5NpJ0RXPu3812P8v0j0YMSfFI30Ho0sdWWc1xHeiw4Zd4PS6lLiru+z914WiKCzgbcnESJWQVyOuxd4YBCBdbOKr3OfFsvsWgtkS2mQvMAtCVNrKPCqkZg3X82p2S5VWtbJq1so5OEzCNaPPmMRpJHvRsckhTfKTCSiaxKffjFd1MK9fk/qamg8npDwJsquxjVyomnyHVjE59k9zb5tb6BpWnp6nG77tD5wX/0+vTYRN/MBNzzyvGQqrL3ZnLFIy895DhM+TLVN/3h8meIukT3jkEqZWUD7YSxqc/w5Vlo+xyoI4CBRPFxUiBd9Z4FG4cevaKEq9K+na+m1juSX+GO9v/fii2DUhFIs4SXDnx1b//Zxed6qMtXa41jdB1yTOiNzP3xoMeyM=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e2c894f-6b6a-405f-c9a6-08dd4698e721
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 10:27:48.5794
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DEizHnrHkhEPNUER6fd7pL7Wtk2QI6R+vMmkYVCTsOR+jrhn9vNkJ4u013y4x5yPCpiunVbOwsyxGKbfXgMvZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR10MB6238
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-06_02,2025-02-05_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2501170000
 definitions=main-2502060085
X-Proofpoint-GUID: -FD-lGcaQRAEIZs_6OiI1GS5RytWpREW
X-Proofpoint-ORIG-GUID: -FD-lGcaQRAEIZs_6OiI1GS5RytWpREW

On 05/02/2025 19:47, Darrick J. Wong wrote:
> On Tue, Feb 04, 2025 at 12:01:25PM +0000, John Garry wrote:
>> When completing a CoW-based write, each extent range mapping update is
>> covered by a separate transaction.
>>
>> For a CoW-based atomic write, all mappings must be changed at once, so
>> change to use a single transaction.
>>
>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>> ---
>>   fs/xfs/xfs_file.c    |  5 ++++-
>>   fs/xfs/xfs_reflink.c | 48 ++++++++++++++++++++++++++++++++++++++++++++
>>   fs/xfs/xfs_reflink.h |  3 +++
>>   3 files changed, 55 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
>> index 12af5cdc3094..170d7891f90d 100644
>> --- a/fs/xfs/xfs_file.c
>> +++ b/fs/xfs/xfs_file.c
>> @@ -527,7 +527,10 @@ xfs_dio_write_end_io(
>>   	nofs_flag = memalloc_nofs_save();
>>   
>>   	if (flags & IOMAP_DIO_COW) {
>> -		error = xfs_reflink_end_cow(ip, offset, size);
>> +		if (iocb->ki_flags & IOCB_ATOMIC)
>> +			error = xfs_reflink_end_atomic_cow(ip, offset, size);
>> +		else
>> +			error = xfs_reflink_end_cow(ip, offset, size);
>>   		if (error)
>>   			goto out;
>>   	}
>> diff --git a/fs/xfs/xfs_reflink.c b/fs/xfs/xfs_reflink.c
>> index dbce333b60eb..60c986300faa 100644
>> --- a/fs/xfs/xfs_reflink.c
>> +++ b/fs/xfs/xfs_reflink.c
>> @@ -990,6 +990,54 @@ xfs_reflink_end_cow(
>>   		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>>   	return error;
>>   }
>> +int
>> +xfs_reflink_end_atomic_cow(
>> +	struct xfs_inode		*ip,
>> +	xfs_off_t			offset,
>> +	xfs_off_t			count)
>> +{
>> +	xfs_fileoff_t			offset_fsb;
>> +	xfs_fileoff_t			end_fsb;
>> +	int				error = 0;
>> +	struct xfs_mount		*mp = ip->i_mount;
>> +	struct xfs_trans		*tp;
>> +	unsigned int			resblks;
>> +	bool				commit = false;
>> +
>> +	trace_xfs_reflink_end_cow(ip, offset, count);
>> +
>> +	offset_fsb = XFS_B_TO_FSBT(ip->i_mount, offset);
>> +	end_fsb = XFS_B_TO_FSB(ip->i_mount, offset + count);
>> +
>> +	resblks = XFS_NEXTENTADD_SPACE_RES(ip->i_mount,
>> +				(unsigned int)(end_fsb - offset_fsb),
>> +				XFS_DATA_FORK);
>> +
>> +	error = xfs_trans_alloc(mp, &M_RES(mp)->tr_write, resblks, 0,
> 
> xfs gained reflink support for realtime volumes in 6.14-rc1, so you now
> have to calculate for that in here too.
> 
>> +			XFS_TRANS_RESERVE, &tp);
>> +	if (error)
>> +		return error;
>> +
>> +	xfs_ilock(ip, XFS_ILOCK_EXCL);
>> +	xfs_trans_ijoin(tp, ip, 0);
>> +
>> +	while (end_fsb > offset_fsb && !error)
>> +		error = xfs_reflink_end_cow_extent_locked(ip, &offset_fsb,
>> +						end_fsb, tp, &commit);
> 
> Hmm.  Attaching intent items to a transaction consumes space in that
> transaction, so we probably ought to limit the amount that we try to do
> here.  Do you know what that limit is?  I don't, 

nor do I ...

> but it's roughly
> tr_logres divided by the average size of a log intent item.

So you have a ballpark figure on the average size of a log intent item, 
or an idea on how to get it?

> 
> This means we need to restrict the size of an untorn write to a
> double-digit number of fsblocks for safety.

Sure, but won't we also still be liable to suffer the same issue which 
was fixed in commit d6f215f359637?

> 
> The logic in here looks reasonable though.
> 

Thanks,
John

> --D
> 
>> +
>> +	if (error || !commit)
>> +		goto out_cancel;
>> +
>> +	if (error)
>> +		trace_xfs_reflink_end_cow_error(ip, error, _RET_IP_);
>> +	error = xfs_trans_commit(tp);
>> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	return error;
>> +out_cancel:
>> +	xfs_trans_cancel(tp);
>> +	xfs_iunlock(ip, XFS_ILOCK_EXCL);
>> +	return error;
>> +}
>>   
>>   /*
>>    * Free all CoW staging blocks that are still referenced by the ondisk refcount
>> diff --git a/fs/xfs/xfs_reflink.h b/fs/xfs/xfs_reflink.h
>> index ef5c8b2398d8..2c3b096c1386 100644
>> --- a/fs/xfs/xfs_reflink.h
>> +++ b/fs/xfs/xfs_reflink.h
>> @@ -45,6 +45,9 @@ extern int xfs_reflink_cancel_cow_range(struct xfs_inode *ip, xfs_off_t offset,
>>   		xfs_off_t count, bool cancel_real);
>>   extern int xfs_reflink_end_cow(struct xfs_inode *ip, xfs_off_t offset,
>>   		xfs_off_t count);
>> +		int
>> +xfs_reflink_end_atomic_cow(struct xfs_inode *ip, xfs_off_t offset,
>> +		xfs_off_t count);
>>   extern int xfs_reflink_recover_cow(struct xfs_mount *mp);
>>   extern loff_t xfs_reflink_remap_range(struct file *file_in, loff_t pos_in,
>>   		struct file *file_out, loff_t pos_out, loff_t len,
>> -- 
>> 2.31.1
>>
>>


