Return-Path: <linux-fsdevel+bounces-63364-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF49BB6F8B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 15:19:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB4D4A347B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 13:13:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4FB22FD7A8;
	Fri,  3 Oct 2025 13:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bR3zwNBJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sYdw+NAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726632EB872;
	Fri,  3 Oct 2025 13:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496932; cv=fail; b=ars5y70AYsXvMaixu/Y5rT7vd32qPwSPW+I1OR+HbwQdlTkG9NTIXHHmMWeGN59ke/4cZouA9KObrFzXJKS1D4e904fc0gv68sgMYZ9K3YPWphg12f/So0kcqVQkTBn1ithRzV1riKX19YxPl8YINxAXHm0BzbI8Vt0FwYBpCiI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496932; c=relaxed/simple;
	bh=t76ufu3cddom2n/FTOQYRC5sdxYLLGzzYdHKClShNv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=GLUZiB/0rLBwTiU/9/LwbXo5EyWXIeWVrMhVpD6M7mp4YboSkbf272rcnBFh6mBD0MUheL3wIq+ngbblYdvjEc4R5zFWufEaJxYgypsduiurjHFq6cY8Yakoe3/SS+90CSpla5Lbq+Px/ZRNjRZXyRO7usn5m2nnUq9l67edaUY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bR3zwNBJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sYdw+NAC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593Aine5014790;
	Fri, 3 Oct 2025 13:08:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=h9WcQENfjEeZbZzHiusmhDI3/mnzIydz/NsLNhqKeQs=; b=
	bR3zwNBJa+Ak1Y9O3SL7UNAYebvfnW1wq/1WBLByJRWflp2qvlWS18xEyXpcN9kJ
	pHimSedSCuj2pTWnQ+YOiLHYFsz8bLaSGScwbeGzvm0OWTA5Or17LiQa4iziKGTV
	3UJtF/iHmu5jNTaHefjK2g1mrQ97KMZ/BI3neX4WMzo4VrVYlnFT5hO3pLV3LwPJ
	Ki4J/ABKIrf6YI5ISkQsSGTT6t2q3JOf2GU2QhKCzfzuEYehz599U6C6gmd/39Ge
	/Krf+sRr3FkKbfn7vYXePwthj0gPCpUK5wtoyQrzkJImLcbH7pE6yIwG3Rb9zADJ
	RtoKb8Wx8J5SkDHlFz3BlQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jcbbr91v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 13:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593CQ9FE017254;
	Fri, 3 Oct 2025 13:08:37 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49hw240ata-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 13:08:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gRgcTjLXXAtndUqnx+lVQNZOcwYtcQuDiDsliyT+S/ws8PvntYgJL5WXa+e9stL7p7AArq6Lbf9nIUKhz9MMYRRInw5ZOUQrRz9rmw4QV/DniV5uMR5WgPiexFA9mlG30Q3Jy/GC/Zx0IUTTTzt5yLjcn7oCTKO8SgvlfT6tH7SM4k29VqD+GIWxvCj2J6NQKE9RrunqNx4w0zf5AAS/mKd8Mme78kMpz8ufwE31hV0ooCngARU6Y5dwMmpceb3EmByuNqOYugy7MQnCdc8d8Z+ovikSF0OI/fiSUiHdreIu0+1vnRGPuWa2b7B0+MIbNCZ/2ImjIhSH+z008s8Cng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9WcQENfjEeZbZzHiusmhDI3/mnzIydz/NsLNhqKeQs=;
 b=Pwjyf3zeZx+PVxq7q0AYa5VyXTpcCpIRW6UbD8iJ+WycCGVTsdEEtPFJ+rX/806ExbjMOS0iK05Vg8QUzSk13+jwfCnzIW8VEf8fads7WZ9hnzVcOyvWKh4cL+JE5RVEDgD/amEFAgX/KfAJMd9Pc7pKJvScQKdhjMRMEP2cauz3eO4y/W7tiPr9ynmi/jt65iBppvrjtpVxgYJpGb1GblLTYdNtUkuGTiGvCkeKGeNaDXkz1Gg8r/nXBy2lzoa8Yt5V3LKONfLodLZUTpzi5OPdyOHWRvbJx7FiBS2yo1qg9oezX+xmawB256HeVUSW3t5jBvLzyR/9WGvUlf+Oiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9WcQENfjEeZbZzHiusmhDI3/mnzIydz/NsLNhqKeQs=;
 b=sYdw+NACuIy8Mmbnlelvg6k7EUKoGkw8CZsNm0sSh3+Lcsh1kYXn45NokUMRgKzgPY5jAjDxE6KWgAQq0+3QM6iV7SVx2Yc2bFJFA0RcUwm8mI1WVrtQ8AyePBZZcVbVJI+eLaSz1hfef99LIVMWcL43xw9tNaWckBcm4uLg60g=
Received: from DM4PR10MB7476.namprd10.prod.outlook.com (2603:10b6:8:17d::6) by
 SJ0PR10MB5768.namprd10.prod.outlook.com (2603:10b6:a03:421::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Fri, 3 Oct
 2025 13:08:04 +0000
Received: from DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036]) by DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 13:08:04 +0000
Message-ID: <cb09f591-7827-4fd6-a3f4-01591561912b@oracle.com>
Date: Fri, 3 Oct 2025 08:08:00 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [External] : [PATCH v2] ocfs2: retire ocfs2_drop_inode() and
 I_WILL_FREE usage
To: Mateusz Guzik <mjguzik@gmail.com>, ocfs2-devel@lists.linux.dev
Cc: jack@suse.cz, viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        brauner@kernel.org
References: <20251003023652.249775-1-mjguzik@gmail.com>
Content-Language: en-US
From: Mark Tinguely <mark.tinguely@oracle.com>
In-Reply-To: <20251003023652.249775-1-mjguzik@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY3PR05CA0056.namprd05.prod.outlook.com
 (2603:10b6:a03:39b::31) To DM4PR10MB7476.namprd10.prod.outlook.com
 (2603:10b6:8:17d::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7476:EE_|SJ0PR10MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 69301e9a-a7f0-4e52-9f81-08de027de34a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d0lwdXZ5UmN6eEp5cllXNW1NbEoyTVhUOExPajhHdWw3NnpGL2Y4dlJBNGxi?=
 =?utf-8?B?aGQ0bHYvNDB6OFFaNHo2QnV1OXgxdEVodzk1VksydUFqL3VDV0lLRlFmYmJW?=
 =?utf-8?B?RGtQbTBsN1N2dms5TTZZUW9tQ1o4UFg3TXNRR1NNT1Rtd3lyVC9kbzM2UXVs?=
 =?utf-8?B?NGRLWVAvbHN1L1dFU3ZrbVpFSTlyNGpWVmNadFozbCtRVHdiRXdUeGxWZXU5?=
 =?utf-8?B?ZCtFcWVSUTAvTzFrVy8vbm1RcUN6bDkxSkxYcWZMV1h4VjNqbWRPRVRSbVZQ?=
 =?utf-8?B?SnlsUmY0b2Mzc1ArMXdkTDVOSnFqenFiSHIrOTFjY2ZaYXg3RW81SDlINjdM?=
 =?utf-8?B?SUFPMDR2aitrRXladVRRS0dldnpMNUlxOEJWM1g0YUlnaDU5clJiSXc0WnRF?=
 =?utf-8?B?OFBFZ3JxZDJWa2dXM1drV1ltdTdYbDFhY0IvNHB4aWx6OVlYcENGdHRSTmsv?=
 =?utf-8?B?alkxREhtM25UbkJ4L1AvOWZ1WTVwTmVxYTN4YXNrWTVtelR6R1RCT3F4bnJU?=
 =?utf-8?B?NVlQMlEySGFYRTY0ZTl1WGtZSmpuajRHTnMzU1I2bkRBaW5kWXlUSnZxbi9k?=
 =?utf-8?B?NW04UlFyZWNuNTc2SXI1ZHFxOGY3UUdYelZUVStTczBLVzNYODJhTmxLZld2?=
 =?utf-8?B?Z1JGZGdDUlZVdE9pNFFacVBmZllwb2hJb3U0SklJSnVUbGpPdmFXZWEyU0VU?=
 =?utf-8?B?ajZHTXdFZXVTUll3M09td3ZnT2htbnN2K2l6cXpQdGtUUW4xV1lSZm9Md0Rj?=
 =?utf-8?B?YzU3M2t3d1ZWNTNwU2pmalFtUk1JY0RGdDdzeWZwVkY2ZWQ1NmFHNUpoeUFi?=
 =?utf-8?B?UVljcnVBakxXdlVMamZZT2ZPUnd6cmliTytYcjFZK2wzcHgrd0cvZDZlTzI2?=
 =?utf-8?B?Q0V3b3I2UzB0MmYzK0NSbjhIU2RuRXU5NTZDbWx5ZGl5UVlBaWkzcWg0Y3Rm?=
 =?utf-8?B?QzZyaVQvRC8yRm1sRzAyVUlPQkVZMURoWEhja0hGVEFubmg2YUgxRkdSQURH?=
 =?utf-8?B?RkNWZG4rRHM1aVl2eURzNkRKVXRlSWVHUm9pdGZEUndzeXBSOEkvTGhvb2sr?=
 =?utf-8?B?RjUzWE5SV0tyVVA4MHdxK1poUmxzUnl6ZStXZi9RVFU3NFVGMlI4Nnp5VGM0?=
 =?utf-8?B?UjF0Q2JYUFRKZFc1MTh3aElBMmdVbklFcUkxcENzdmxkSkliNnBDbWI3NG82?=
 =?utf-8?B?MXUwd3UvcEE1M2VDOWgyUUo0aXE2V2JWd2NyanE0cmt0OTYxb1NIYkNiSnJ3?=
 =?utf-8?B?UjNDQS9Va3ZXR1J2QXIzbDkwVDR2NFFBaU5WVWxtVXlseEN3YnQyTFliYlVn?=
 =?utf-8?B?eFcrMThSckxRZVlEcXhIREhuWGRjVE9zeC9VZzFyMG9xcjRWSWJzcTFmcy9I?=
 =?utf-8?B?eVZtMGlETHpQbGNBZElFcTBIbTZzekc2UFhZVkR0dHhqRlQrTGJyQ1phMkJp?=
 =?utf-8?B?TDU2ZEZLY2lzWGZJWS9ZbTZkZjJGbEcxVkQrRW9laDJrVEd4aTJobi9Rb2dp?=
 =?utf-8?B?YmF3VVdYdGovZStmU2pXbjBidVAzOFBnZ0YvMXYyN3prclkyckxCbUU1OXlQ?=
 =?utf-8?B?M05CU1QxbjRQZGFld3p3eGJXZ3JDbTBkRmRRY0tZczNoNCtOT3NNZVVOd0pE?=
 =?utf-8?B?WTYxVHZDdUVtQ2lhSU84ekpkS3pyR3JPcEc3Y2cxbVlveTV0R2lsbkF6d042?=
 =?utf-8?B?L3h4TTA2cEUxVlFMemw1VzdYazlTOUxhT1UrTzlZN1gzalh0Tld1TU5jSHdo?=
 =?utf-8?B?NnVFcXo4YWJnaHhTVG4vM29BL0kyN0xzNk8zUTdQQnVGNUhtSjMzcGZkeS9R?=
 =?utf-8?B?d1VQSWlMVkhLa2EvejRyaG15K2dLdm4zQkhua05JSCtUeE55VitTdm5FU0ln?=
 =?utf-8?B?aXd1VHFxRG54aTdKeUN2eHJPUTlXWnBQd21KdlV6bUtDNXJvVU1ocFFvUHdI?=
 =?utf-8?Q?+xPcUOCHftnEORW6AIGdyuJnH3apB6TF?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7476.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEhEOGFrMVVZb1FFUnRkczZpRGdseTNYUVV2RTVIekZOMHlHc3lJeVZRb3Vy?=
 =?utf-8?B?RC9obkd0d0UvRElSeitMVTNQWXhJZlBvOWM0RnAvQWFsbU52VUVpZjMwb2wy?=
 =?utf-8?B?OHdGY0M2bVFabWE3cy85cjFxcEFQUzg2R2dReUkyTC91Y2VZNjhFd0JQNzRm?=
 =?utf-8?B?UzlmYmNZQ0RoMnVxN0ZTN3BXNHBiQy9PR2pYaWFuVmd2blJ1ZFppckQvR3dD?=
 =?utf-8?B?NExncUtPVldhNmVnZnZ0UE1peWZjK1o1T3VuZ3F3M3I3bGVxb2hUa0VxTTBU?=
 =?utf-8?B?L29vVEowcnJJZ05aT2prWEE1bGxXcnh3cjhMMWJreEsza0d4VXIrbkdQQkFO?=
 =?utf-8?B?UURVYmpkNjEwem1oQVhpcXlWSExWQ2krR2lwcXZKZWRYVGF6U2ZPOUQ0R0FZ?=
 =?utf-8?B?M1o5SlJra0N5NExEM0dOWWlzRWxGS1I4TTFWVWJKU1JZdktjcDNOSHFPcEpH?=
 =?utf-8?B?a01BMzd1Zlp2bENxamtUZFY2U1czaUQzTEQ4Z0d3dTNrQ2xGb1JhQi95SW5X?=
 =?utf-8?B?RitkdFJMSkgzSXJqQUcrT1BycXRaR1FycTdkNHVRdHBtQ2t5TkJITnFkODNX?=
 =?utf-8?B?bjMzZ0lPMU5pM3NJU2VMWk81MU55OTVsczRXdHZRMkUzcUdhVzBuZ25TaTFy?=
 =?utf-8?B?aTd1TEZlQjJmb0cySXJVYU5jOGhiQldRQXh0c2VEb2Urb1FkakpMZklhL291?=
 =?utf-8?B?bkU2ekZYSUhVVjdIcFl0UmNsbWYxYXNaM3ZLSlA0Y2dqSzFRZy84Z2lLWnZZ?=
 =?utf-8?B?QkJTN1ZuYXZFN1Y5bndYRmNQV3B4b1p3MFZtQWVGZGVzelQyV2tIYnN6RnVm?=
 =?utf-8?B?V0pYbXNwSHJKcWIyWGFpOTlPNW1zMUNLazZVeVJmQzlSZWlvcTZmVTR0MU4y?=
 =?utf-8?B?SXhvcGZNaXZOMDhKNU1oV0pwVWVjSVdnaHBvKzl3a09qMWxGamZwVzFFbUpE?=
 =?utf-8?B?OHgrK1lZZWUrNGNiekFvcDBZQjJRSndjVTBjVFpwMUhQQ2dlNDRqZWw0VW9S?=
 =?utf-8?B?T1VlUmFlQ1Jxd0F4ZXE4SGRFTVM4d0dlU2VnN29kbC81dmQ3NEhDaDMxOGkv?=
 =?utf-8?B?enNaamhFd0RrSkdwQkdSeUdrV3pJbHNMd1VTQzRIZnRyRE1ZNlo5cWVSeCtv?=
 =?utf-8?B?WGpTay8yOFBVbVYvSTMraU5tenh3QjMvTWEvaU80czQxSEtpYjVNSk1vVkty?=
 =?utf-8?B?TUR2cng5YzBjMEhsL2doQWZVTXkwaUVZUWdpRnp4bTFuVURJTGlHejZRMW1E?=
 =?utf-8?B?SDRUdWVXTmd1UzFUeDNmZjdoYTZBcmZ4YXAxQ2M4OU1jV09rMFBPajljRUNU?=
 =?utf-8?B?ejVzMksvcmt3VDAwL0JPYWVOa2I2OGVMYVJxUStQSUl0UkRLR1NuMlFUNGpp?=
 =?utf-8?B?RVdlVk50ZmlwdHdZdDAwbnZUYzVnQ01VWnY4ZVlJYm1MdGlUYUFacC9aYWkv?=
 =?utf-8?B?ODYzNWtoVExSVTN2clNiVDk4Wm9XRkZuUTcxR2Z1amxSNkNVY1JuZFlPSm9q?=
 =?utf-8?B?NUJKZVVncTU5UkdFdjNuZHZQUk13SW1kL0piZ0lXRkYrS3pDbWtseDFOUDNB?=
 =?utf-8?B?bURaVnIwazJKT1d1VnhNU1paSUNtMzNYK1lYUHBLUWVHcXh0NkErZlBLMVNs?=
 =?utf-8?B?bHZtOElaSHpXcFNuR1lKc0wzYmlkYlpaSEQ1QlNRc0Vwa2FMalRtbDNFSSt0?=
 =?utf-8?B?YUd4bnpDL3F4S1lRSWwwajVDZUE1emgvUEswWTdzTTVtOTBUOVVLN2o2Szlw?=
 =?utf-8?B?UWI4SW5POWxtYXFPcDRxWk4xbEhpVU1Zb1pmTXFHODBvWDlWZGtPblQrUUJI?=
 =?utf-8?B?ZEVlZGk4RUNLTjBJTW9DQ0pETzc4QkxYOURhWlM4TGtTbHhqSnJIN3E5NmFr?=
 =?utf-8?B?ODlkdE94NFk2QndGUU5uYitCUStLN054dFA0U3ZpMmtKU25DNDRxVEdxbG9o?=
 =?utf-8?B?YkVySzNtMTVzeG9RKzVXOG8zdWZQaGwrUkpUaWlWTEZMT0hvSzI4c1NMWHBC?=
 =?utf-8?B?YUJkdDE0QmVPS29XWkpGQ1U4N1VlZVI3dUFhM2o0VlhmanJuU1lzVThha1Nt?=
 =?utf-8?B?N2FWeXlWSzdHVkNaR0dNMVZYR0VFMTJFSDR0WWlBYUVxUGZnMEh2VTlVVWtJ?=
 =?utf-8?B?YkZNMm5EVUhPU1MxOVBpSzhzTHY3SUVDQzN5TWNyS2JBbDNWOVlLUXJ5c2dj?=
 =?utf-8?B?SFE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9dYiyM4AXe1bulFQqkE991J1KIfHMpV3uVoTc5nOF6/JIGrtzGwFkcohcj81TEXZbtVydfg2+zDf5NydQsGxuQ3Or+pc+WVXjm3CuEgZMpH8PfAO99qXsxvx2pQXNWQzm28oVBTYlaSG4XBpjrBye33eEnyqbfZNAzD1SzUdpj6LJQ7UcuSi9YnZ0ZseBPTIuV1pxLKVTwHj00K4SVXOtmM6tOYZd9jcV0RBWLgVDpOPmCNCpHm+xWfFTPT82ZYgm1ukro0rvouN/9+obszyDSiDsnA8UYH9gQW5evoIlLs3AArGM5fIsKG7JBiCmEUp/jN7QoKjqDk3yy3BqaohTEoJJEpwEWqAP+u5RzwwkojqFljdbU06Hiy5d+01SvzgUUuPGMP+KXU7QvnORZjWJrtKIe+PCSLjNTXITPsoNxsvvMPQC4jkruV4EKZEEkvNHyl0+4WOdRRBsX6UOQ973V2XFWuCp3m5a8ddprD5cs7GRX19/LB7KBzHbX4GW6ezgT6kOIV6iVmXMNtm0TE+K6xyW8gKKNL+F1DEPD1EXzN8jmWg7X8VJ4CGKpK/O3NTiupZr79iihNCiKku93PGTzl7II0nLE5VM0KLaTkAsWs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69301e9a-a7f0-4e52-9f81-08de027de34a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7476.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 13:08:04.2654
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pa1PUQs7Ya/bFtalGBCAOyFA/M1FoG8vKHTFfJ0AIXNqemPOlTzBItSarWf1p3FcG6HB+dNR6bsXZWLparSZS9TYxbNDm2MYkVs35ZEg44w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510030107
X-Authority-Analysis: v=2.4 cv=bZpmkePB c=1 sm=1 tr=0 ts=68dfcad6 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=Xcmt9cC28M023SyYxpMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12093
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDA3OCBTYWx0ZWRfX/vbEI1ym+X4T
 blM/xQ89ljAmbswrnNZJjfTTJjRaMIBd1ycyQdi99PWr9Tsr33dld7xB5+UplJpNyVXIwHBNVaU
 I13XKnAhxD2n1tup+wF4L6ao5tLHlriltqGRB+7T2VZZ9Dx5YRnXUwfu+WKGJyDix2aYp8h07Y6
 r+jxIYSVbV7T1uNFN9qREJdVU5jHJmRUG3vzKsnvi6Ic3BthG1rNcsuE8uVoaQcOmmn30tW8liL
 kGzmlzXJ/qf6QhR+0ebz536QY2iZ1KZsFWI85+jH06ZCwOgcuHJLAMNSeVvOTm+fFYOTZMcsD22
 7M9Us1Ho8EJlmVhB+dbJ++pM5UAIi//LRfQfvq5nqk+sx6BkiH2vHF85hL+djQ6wch1ZphTnz9r
 beLGwU94KQT+YsFvMgagLajMX4RX1Rcy392KqpC8Bbe5xO0STmI=
X-Proofpoint-GUID: V5K3ttfPH70FxtcXqu4UiXVkbmABCeC6
X-Proofpoint-ORIG-GUID: V5K3ttfPH70FxtcXqu4UiXVkbmABCeC6

On 10/2/25 9:36 PM, Mateusz Guzik wrote:
> This postpones the writeout to ocfs2_evict_inode(), which I'm told is
> fine (tm).
> 
> The intent is to retire the I_WILL_FREE flag.
> 
> Reviewed-by: Jan Kara <jack@suse.cz>
> Signed-off-by: Mateusz Guzik <mjguzik@gmail.com>
> ---
>

I agree this is safe (evict() is done with the I_WILLFREE i_state flag)
and smart to remove I_WILL_FREE i_state from ocfs2.

Reviewed-by: Mark Tinguely <amrk.tinguely@oracle.com>
  
> v2:
> - rebase -- generic_delete_inode -> inode_just_drop
> 
> The original posting got derailed and then this got lost in the shuffle,
> see: https://urldefense.com/v3/__https://lore.kernel.org/linux-fsdevel/20250904154245.644875-1-mjguzik@gmail.com/__;!!ACWV5N9M2RV99hQ!Khsiz-7t3Akh8BY068JIkK4bVNulsK7SAgJlWzCE-T7Ry_ddsK-Omj0NiJuBy66vtlGZrDLaR33VeeHw1N0$
> 
> This is the only filesystem using the flag. The only other spot is in
> iput_final().
> 
> I have a wip patch to sort out the writeback vs iput situation a little
> bit and need this out of the way.
> 
> Even if said patch does not go in, this clearly pushes things forward by
> removing flag usage.
> 
>   fs/ocfs2/inode.c       | 23 ++---------------------
>   fs/ocfs2/inode.h       |  1 -
>   fs/ocfs2/ocfs2_trace.h |  2 --
>   fs/ocfs2/super.c       |  2 +-
>   4 files changed, 3 insertions(+), 25 deletions(-)
> 
> diff --git a/fs/ocfs2/inode.c b/fs/ocfs2/inode.c
> index fcc89856ab95..84115bf8b464 100644
> --- a/fs/ocfs2/inode.c
> +++ b/fs/ocfs2/inode.c
> @@ -1290,6 +1290,8 @@ static void ocfs2_clear_inode(struct inode *inode)
>   
>   void ocfs2_evict_inode(struct inode *inode)
>   {
> +	write_inode_now(inode, 1);
> +
>   	if (!inode->i_nlink ||
>   	    (OCFS2_I(inode)->ip_flags & OCFS2_INODE_MAYBE_ORPHANED)) {
>   		ocfs2_delete_inode(inode);
> @@ -1299,27 +1301,6 @@ void ocfs2_evict_inode(struct inode *inode)
>   	ocfs2_clear_inode(inode);
>   }
>   
> -/* Called under inode_lock, with no more references on the
> - * struct inode, so it's safe here to check the flags field
> - * and to manipulate i_nlink without any other locks. */
> -int ocfs2_drop_inode(struct inode *inode)
> -{
> -	struct ocfs2_inode_info *oi = OCFS2_I(inode);
> -
> -	trace_ocfs2_drop_inode((unsigned long long)oi->ip_blkno,
> -				inode->i_nlink, oi->ip_flags);
> -
> -	assert_spin_locked(&inode->i_lock);
> -	inode->i_state |= I_WILL_FREE;
> -	spin_unlock(&inode->i_lock);
> -	write_inode_now(inode, 1);
> -	spin_lock(&inode->i_lock);
> -	WARN_ON(inode->i_state & I_NEW);
> -	inode->i_state &= ~I_WILL_FREE;
> -
> -	return 1;
> -}
> -
>   /*
>    * This is called from our getattr.
>    */
> diff --git a/fs/ocfs2/inode.h b/fs/ocfs2/inode.h
> index accf03d4765e..07bd838e7843 100644
> --- a/fs/ocfs2/inode.h
> +++ b/fs/ocfs2/inode.h
> @@ -116,7 +116,6 @@ static inline struct ocfs2_caching_info *INODE_CACHE(struct inode *inode)
>   }
>   
>   void ocfs2_evict_inode(struct inode *inode);
> -int ocfs2_drop_inode(struct inode *inode);
>   
>   /* Flags for ocfs2_iget() */
>   #define OCFS2_FI_FLAG_SYSFILE		0x1
> diff --git a/fs/ocfs2/ocfs2_trace.h b/fs/ocfs2/ocfs2_trace.h
> index 54ed1495de9a..4b32fb5658ad 100644
> --- a/fs/ocfs2/ocfs2_trace.h
> +++ b/fs/ocfs2/ocfs2_trace.h
> @@ -1569,8 +1569,6 @@ DEFINE_OCFS2_ULL_ULL_UINT_EVENT(ocfs2_delete_inode);
>   
>   DEFINE_OCFS2_ULL_UINT_EVENT(ocfs2_clear_inode);
>   
> -DEFINE_OCFS2_ULL_UINT_UINT_EVENT(ocfs2_drop_inode);
> -
>   TRACE_EVENT(ocfs2_inode_revalidate,
>   	TP_PROTO(void *inode, unsigned long long ino,
>   		 unsigned int flags),
> diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
> index 53daa4482406..2c7ba1480f7a 100644
> --- a/fs/ocfs2/super.c
> +++ b/fs/ocfs2/super.c
> @@ -129,7 +129,7 @@ static const struct super_operations ocfs2_sops = {
>   	.statfs		= ocfs2_statfs,
>   	.alloc_inode	= ocfs2_alloc_inode,
>   	.free_inode	= ocfs2_free_inode,
> -	.drop_inode	= ocfs2_drop_inode,
> +	.drop_inode	= inode_just_drop,
>   	.evict_inode	= ocfs2_evict_inode,
>   	.sync_fs	= ocfs2_sync_fs,
>   	.put_super	= ocfs2_put_super,


