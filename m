Return-Path: <linux-fsdevel+bounces-63365-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD42BB6FCF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 03 Oct 2025 15:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 157D5481405
	for <lists+linux-fsdevel@lfdr.de>; Fri,  3 Oct 2025 13:13:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2DD12FD7DE;
	Fri,  3 Oct 2025 13:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bR3zwNBJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sYdw+NAC"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248C12ECE89;
	Fri,  3 Oct 2025 13:08:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759496933; cv=fail; b=Di9xseBDwNP+zAj6DeuXNT++nQD1fySaySY+WrzRiFFcZgdteXT54ll+ki/qet1gmFSLu00XusyPuYe6dvRr1wmC+GCYPOK4uPCiCoIqLOBx6/yO5RJcr9yTxp7ybTSP4mGZjQU6GrTGwv+orQRmT8pW/EmCEaBeztJnjmfbWA4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759496933; c=relaxed/simple;
	bh=t76ufu3cddom2n/FTOQYRC5sdxYLLGzzYdHKClShNv8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uXHEwelLFwhieYe+ER8Rwf+OvXc972x0g1tz9idD5P/rmDyeiL4O2rCmV5a+CurIIGswCjOimZMs2Vv/KcSl5NbNwJh5cCL7VafdW+bO9e9XIUZ2vZRe3Kd1tJCM25iDd6bifTqsz1ubOKn4molsHWMDzi2PAlkMiU+WuR8chHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=bR3zwNBJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sYdw+NAC; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 593CdoWR002249;
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
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49jep9r1wh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 13:08:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 593CQ9FD017254;
	Fri, 3 Oct 2025 13:08:36 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010065.outbound.protection.outlook.com [52.101.193.65])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49hw240ata-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 03 Oct 2025 13:08:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HCxqTELuFu5aV2aLxFYqOAPOrk0OqHMaZnSK0tkzCVp1T82km215i4Ym32hUywLXc6a/WrmeVBD3DrOaeT67e5XJooKVTAirUBxQYJIVjqZMyYE8rzNhTHIwYp+vccZkGJRZg+4lVvhtIyCjLVw5hyZ2H1xZqqQd5oSezYWD4mCkulrnyzLC6crRNIFTbRWM623GWhsipnqXc7e9g8RjzgClYVBkvkI6QLvsmBRAkLF/AAaXEh+lD/QYD/R/+fN1R0jDN2fLU0Pkbx//xaUb8+pzrXC7pMH+NvIYdmKTiXgN81CrnyGD1U9K82SCiYhXUj3+ckOsakQu+1+LuylSEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9WcQENfjEeZbZzHiusmhDI3/mnzIydz/NsLNhqKeQs=;
 b=o/PY5/dv05jSRr/kSc8Uag41P6nMLB1sihDstjpXzQ2tAN1lj3qrt+hsCB1qmzP+3z6dhLTQlrTqMCNj57j1eCXQW2QhnsBgZlB2hECWqh7cYEQNBfDWxPZU3olfRWyjbbPQm+X7gEOkKIUSn26btRUzglqkviOgmpUj26pvFNPWGdoY7MnNhBrAzZqmuzP296puS8QnNP00HB6IEbYRsDpEh63Q6rk/xmz1OECrguDgS40dHG3pDC3Uj87WfrnQJwr2yOHIeN+41AGdQEqWR4QMgLJVaW4ozoYqc7sS1kgVJM9+Si4pXDgWGXbfSoTEp+Kd9cixjxYE4jnXLlCxYw==
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
 2025 13:08:03 +0000
Received: from DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036]) by DM4PR10MB7476.namprd10.prod.outlook.com
 ([fe80::f32a:f82b:f6ac:e036%5]) with mapi id 15.20.9160.017; Fri, 3 Oct 2025
 13:08:03 +0000
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
X-ClientProxiedBy: PH0PR07CA0013.namprd07.prod.outlook.com
 (2603:10b6:510:5::18) To DM4PR10MB7476.namprd10.prod.outlook.com
 (2603:10b6:8:17d::6)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR10MB7476:EE_|SJ0PR10MB5768:EE_
X-MS-Office365-Filtering-Correlation-Id: 10952c93-a037-4302-594a-08de027de2ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UEllNDVNTldydXhuZ3dJRVFyaWtEOFAvZU1SZENoSUNlRFpqNlRmUTRtYnFF?=
 =?utf-8?B?UzBvais4Qldra0xKSU9LNzJBalpldCswY3hGeEhLakdSKzF6dS81Y3NiVXNF?=
 =?utf-8?B?U3E5ek1KRkRMclI4NmFnWS85bUs4TTNXemZxeVovVnAvYlF2YzBtZTBNTkZs?=
 =?utf-8?B?am4yRGNxR2hUUEdYSkJVbzl0NlZFU3I1VmlzVC9CRUN0Z3IrQU9LQ20zZU5H?=
 =?utf-8?B?RHYrWDRzV1pMc1kxTlRoM0dXK3B3cndIaWQxNjVRMXVCamZsaUI2cWRyVGdU?=
 =?utf-8?B?eE4zUndjWEs3VXF0QzUwdjI0RVEwZFY4MkUwaWg1dE5RSjVONHNiVWlJelBO?=
 =?utf-8?B?UjZOZzltRkttZk9hUks0WG9xM1lVZVBxOXVoRjhBVWUrcHJRUnJ6SHNvSDFN?=
 =?utf-8?B?WHprM00ySU1EMDg1UGJ4bHZucnhBYTA3Q0txbFRBaXA1eWd3ZEg5UVViTFpq?=
 =?utf-8?B?ZWdUdTNldjd5WDRaS05JRSt0Q3RXalVHQmJtNTAvSW9jOVl5dURZV0lITVMy?=
 =?utf-8?B?ZTNkZjlRdWxucXRLdU92ak9oUmtkUzlmSWpYc05JWDZyS3lHaERZdHRPQ29u?=
 =?utf-8?B?UHhpN1ByaFQzTE5DRUdObVRqcVZaQUZBRGY3UzRMbllncXRiWTYrS0FOY0RU?=
 =?utf-8?B?UmRLQkhGV1RaV0dveVhJeEI5WUdTMFkwT1daZVc5TkltR3BwSEF1ZDlLQ1A3?=
 =?utf-8?B?cU1HeGJxSGMwNGpwclFnQ1p5NzdDelFrejVPd0R0TW00eTM1NHo4S016YUQ0?=
 =?utf-8?B?UGl4UEVnaVV1Q1dMMXdXbTlPQW9OTm44dndHM3hOSlpVeWNjZTZqR3RmTHg1?=
 =?utf-8?B?cU93SXAwU0MwdjRRZW04NlBqek85aTNZOUZqRmVDWDhPRUVxajdvTW5SMnZB?=
 =?utf-8?B?YkptUWxaMnQ4bVV1VTI5eFlCS0hJNnAwSnlsUGZnUVh4eFhqM0NEZVpWbHZR?=
 =?utf-8?B?VzhYak9tYjdYRUVWUGZzazkwdWhzYlpvRFR5T2dLWEFleGlBeHhlZmxFS2Jx?=
 =?utf-8?B?WVJZWUo5OU02aUtIT2pkdS85WjBWZkhXWDFtUUZiOXlEaUxnRFhBVjRaVWVC?=
 =?utf-8?B?cXZWQ3RVbHRQREpiUllxZ3A1dzRpTWNWbVBxUnRPY3Yyd3dGZy9FamlYQ3Fs?=
 =?utf-8?B?MjNSTFp1TEtYRWtJOVpwVnl0UXpGTWIxTDZ3R1o0U0V2UVRhc0c4QXlYcGRV?=
 =?utf-8?B?MitPMi9yaW5ObnVyUkJhSmN2QlVZVS95czYwRFdxWGFGaTF3TUl1dDhpMkt2?=
 =?utf-8?B?THZyNEFoTU5ReGN1dE9HY003czJIaXhRQ2RzUG1hOVh5d2hMYmF3NjcvakNS?=
 =?utf-8?B?blU2d1RtWG9ENnZyVTZMNVNCd3NMKzhYUFZ5THV6M2NnV0NPblUvVThaK1ZP?=
 =?utf-8?B?aXF0eWg5N2xSVUd6ekg4Q3BnalpGWWNGQWtBSUc3Q2RtcU4wYVRMVmpqaERv?=
 =?utf-8?B?QnNVa3QzaXFFbjlkbkxJdFgxQlZOMkRSbzhlNUg4WWttcUpDUlBaZmlFUjJZ?=
 =?utf-8?B?REl5S09WNnUzSDNIcHBwK056RW03azRJVUtTaWFtMmxhZ0RlOGlYMW05YmZi?=
 =?utf-8?B?YWJURk5vYVhFYWZtMG9Eb1VYYm9oT3A5Q2dWRTdYUUNXM2ROUmVTbGpCQVpx?=
 =?utf-8?B?TVA1MlFWclNrajZ3OUovdHAxUlUwZ3NNWWNCWFVuS0NHS1ROS25XOEQ2amdt?=
 =?utf-8?B?T2VxRDA4dE5YaEZIL0hhelI0eTZ0L0F1bFdTTHZ1ODFIY3Z0ZDZIUjZ0WVJM?=
 =?utf-8?B?QVM2MW9HVTVHUDAzbWhOTC9VdFJtK1dMK3JXU1E4VHYrNlFybHh1b0Y3aTl1?=
 =?utf-8?B?b1pXbEhmRG8wRjhrN2hvRFNaWFc5NjJuV0M1WU1TRGt5ZmU5V0RsaFFDdzB4?=
 =?utf-8?B?RUcwL1RkaWxzQ0ZCN0gvT2tUbnpFZGNhZmgwSk1hYWNXSnFJb2ZlN1dMNUVj?=
 =?utf-8?Q?R4ttaYCLDpltSTnf7q1DrZAJarXL0+wC?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR10MB7476.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UTI4SWhGWlR0ZjVQVzlvdjJUd3NoK2NHalR6TFd5alQyaGFXZW9Rd3gxZEVy?=
 =?utf-8?B?LzREalBXdjl6U2w2bmdaVTdEdlQwN0VyRnY4MVUveitnTHVMeFYrcVY3T2Ir?=
 =?utf-8?B?TzN0MEppMU55KzNTL3BlVW9weUNTVUQ3WTE5NkdHMkUwcW5FeUNIbjVKalZM?=
 =?utf-8?B?WUtDbTRPWHh5RDA3aXZZRS9UUStBQkRQY21nU1ZQRUMxSkc2ZGZ5ZFpHcVNk?=
 =?utf-8?B?U3BLTkI3TG5VQ1kxMUpmM1NiOURnTndoYW1ocFN3VVNtclUveDVxbTBXM3VZ?=
 =?utf-8?B?YjkyS25FRnM5NTFXZkZhRytHcWFzUmtDM0wxSUxzY0o4SVhNUUlxcFVOcm01?=
 =?utf-8?B?ZjRMMGFaL1BvMHJZdG1Mclc4L2hvNTQwbS9CdkZFV0ZzbEd2VnBQejQ3Wm1S?=
 =?utf-8?B?L29VbHh4T2xKVVZTTTlzMkFZTXdkclgrMVhubW1OazZCbHloTHI2V0ZTWElv?=
 =?utf-8?B?ZXdsZ3pWTG4yYm9MQ1NSV2dZQTdCYUEyTkQwSEN0OHE0OEFJRzY3YmVpdllq?=
 =?utf-8?B?L25sbk8rTDF5MEw4TmZ3MGlTUUpHKzVTaDJBb0d3clJyQnpZODI2ZGRsSmFq?=
 =?utf-8?B?K1NIZElSaVZyc0VabXJyOXlRZ1RkZEtPZUVJRjJyV1daQm1lQlFtVWdCY3hD?=
 =?utf-8?B?amhzUGlzV2kxS3QyaWpCMVNsM2hXN0w3ZmMrVTBjb1d6Y3Q2N0d1QThuU2Zr?=
 =?utf-8?B?UFUzRVl2ZjNPdDhHckdod2VkSkEyMVVxMnFVZ0ZPcXluN2VKVXo1U2pGc3FI?=
 =?utf-8?B?RmVkQWR0cW1rWTRSd3RSVWE4ZWZkQU00VE4vOTN2V2Z3bllTdjVrTmpYMytW?=
 =?utf-8?B?czJBbTMxWWNqV0RTVXFVWjkzNXkxdGVSZExzR0tBNmh3M0tDck44TkF3MHhC?=
 =?utf-8?B?Y2kvMjZQbURSK3ZRa0QxWXNFM2g1RXBKU1FaakZzR2lnS2YyNms3aWZFZEdz?=
 =?utf-8?B?OW9ZT0E1WDBNQmJWWHBjTUZabWZIMDhGOGFqbStZUG10dlFBYnB1U3gwRFhk?=
 =?utf-8?B?dXQ5NGQrR3l1cCtFQk00ZTRVZTI4dW9aTzhLY2MvL3ZMVUxBeTd4NzZjS3lK?=
 =?utf-8?B?bit3TytQK25YYmpWQy9kRFNKUFpQSVArMXdmcjkxYkx3dHR3OFhHbUVnaUhz?=
 =?utf-8?B?YktyMVlUaEFpWUdQUTkzVStiUTJ5Zld2NmU2cnF5cHJvU2crQzhpUUxsSXJV?=
 =?utf-8?B?cGRHU0tKa3BBamp3MEZKVW1jSlBmalJ5NEp6WEhjS2YyNlpWaFdBMk4vdmZ1?=
 =?utf-8?B?Z2lHUWZtY0N3UUhXNytpV0ZCQzFPM3NaalZWUGQzVXQ3Nk5rOTdCUk1WQXZt?=
 =?utf-8?B?d1dHM2QrbGNhdkcrczNOZW9aTDRuelZJMjFtd2tFSlhJWUFBNnp2dWlxc0ZY?=
 =?utf-8?B?MG9Bb0ovTGNXNFcrSkV0ZXhnWStoVldnakhUemt0eDB6N3cydkRYY2xIaWFT?=
 =?utf-8?B?RFJGdDRxRC9oMFBDVjEwTGx3NHhOY0F5NHhwQlUvYjUrbWI4TStTNGc4WjZr?=
 =?utf-8?B?SVVuaFRFcFc1dTJOb2hrTXQwV2phOHlwNm1tRTcyL3lhR3JsOXl1RXhCaXJI?=
 =?utf-8?B?QmNabTFUNENOQVFCZmhMa3RnSVZINjQ1VmgzZWxUbkcxYnF3Y2xucm9sNEVJ?=
 =?utf-8?B?Rm5qWWtWUnVkOXZCMU5ya0xxM3AzaVNhcFFIZUJ3MGF6QUlpRVNzdGpzb0Ri?=
 =?utf-8?B?OXJwWUhYNGRWeVFENmpEclRzZjluS0lJVEh6OHJUbWw2L3FMNFZodGpHRjVO?=
 =?utf-8?B?Zk0zRXlYTkUweXlxN1FSdXhIbkNraWlrQS81QU1FVy9zcnZIU1g5djg0cXJX?=
 =?utf-8?B?aU53ZkxETjVnWWZKVStnUUlFUThaNzdRMzRXUDhPamcrNHdQMlNVUU1SYUxJ?=
 =?utf-8?B?SEVobkw1Y1J4enNuejlKVWUzV015aGh4WTFSTU1jM2VmalNXb2x4MmVWU1lM?=
 =?utf-8?B?N3dVWWlNQ2E3blBXN1VXUUNWU1BpT096cExRZ0pKU3lTWVc1Wm1WWTdXa1A4?=
 =?utf-8?B?ZnZ3RE5laEpKc25LNFZBdjFqNllrZXlFK1ZEVC9iTUE3a0pQdzRwUVFHMGlO?=
 =?utf-8?B?dHBuNDBrTzYxbDFXY3lTUDYrQ211cGpLam1OQmlIUjV5TVZ0MmVIeENoeVRi?=
 =?utf-8?B?Rk95MDQrNWVBTzN5NXFieG1tWmxDWUVqSk5vU2pWVEdRNEJ2MkJqd1dmYkt2?=
 =?utf-8?B?NVE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	NCiEizBX0ivRNvBTzR2Z9NMS9EzeaDLs0NOHPVy294G0lTJOizNmaBztRp4ig9FU59BMEQpR2hqTdoi+xJduo+ED5RLDVm/7hHv7Xpf6c+qZjRssMPKNEtXV+0MLPBv2XEgOKk79Y/I/mPgSrezP2dNqFhRvLY+SBz9XSuVang00U/BIgPMgsMFsyjxZWJc7qndSvsD5HGtCL+K3KAi6n55Zjg2ZRe1zmDKiAz9AzZ0dybZ4cykzSszMkYKs8JloHC3bDFJKx1v/zn4ThShLwGJXqf0kbUQVi+hzNGScUP/mO7X7J8+BNiSt0lxiw6MmSOC9yuI65vf+i/V65VYwJkoB3oAK/lg/3eQML6JtY2Kjr3I/4bK5ATeejD4GvUUF21jbIMFXUK7p0xWIuzAE7BdAzAmAcQxFCzxI7xki7r5sICWMGY6yzqDMWfCMaE3Q6yn7jgwiOZ5ShrFpY66mMMoQU0VS9EarNiIuyfqYf8K1xygALNjSnA3BvCJnvx7mxZCC5/3fK9gARFUcH+DHoEi1d4QLfMCXt4NDWFeKUznfy+Wbaw76CbQLxWEtRxMPn7j9T1N+4uV2hiE2wcu4ovn/YG1+qSJBFicwlxW86M4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 10952c93-a037-4302-594a-08de027de2ba
X-MS-Exchange-CrossTenant-AuthSource: DM4PR10MB7476.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 13:08:03.4055
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 27ehcQaQR+x6OfOJ+G38yfjVtaIo5e2WhXN5zDXhZzyt6gl+WAqSxARljj7qLi7CE2oqH6q3c4nIf7EJjy5Vb04wiNUZS3BBN68760fooh4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5768
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-03_03,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 spamscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2509150000
 definitions=main-2510030107
X-Proofpoint-GUID: E3cTFxRgdNWq0As7qdMb01Pc7728qXxU
X-Proofpoint-ORIG-GUID: E3cTFxRgdNWq0As7qdMb01Pc7728qXxU
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDAzMDEwMyBTYWx0ZWRfX+njIUPZMimaV
 rzM0ccoTcU/2OXWA1E4oM0XkOyuQgmZudVEKDQX66IwCm24yG4om+ejwMFuGB7K15LiSgwxVBYs
 wM4lP0bufi94ThWCKqSNWNvnqZuVoPV/v+U7BlOM4XGRmjx3XfGT31ACebyZ93QcJIu9IXM5bih
 qjafYxHQ6XeROK9U9EDaISCOzdvWVJ3ZB0yNtZ+N4/8joaPq8H2uYWBW/OW4aLz3IkvlPC0hEVz
 UPhP0CBJemSj8YfB/ExzJjznrCyHLyoXfWNt5lSbI8JJq+47LrbSauR7eo8zQhOJ19bYHXsv9zh
 pY03piYePi4xKuLA54q67/eGgG/rWnsh50aFu85exX5k/c0iXnw/+IyJyllJj/s8Dpk4FDo68uI
 Wh826IBqm97nx9ZSUbDSqPHRjIv8ylhzeXBAzYuCVCVdGz4u97U=
X-Authority-Analysis: v=2.4 cv=N+wk1m9B c=1 sm=1 tr=0 ts=68dfcad5 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=x6icFKpwvdMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8
 a=yPCof4ZbAAAA:8 a=Xcmt9cC28M023SyYxpMA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12093

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


