Return-Path: <linux-fsdevel+bounces-21383-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A8579033A2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 09:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECCFC1C2307E
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Jun 2024 07:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C078C172769;
	Tue, 11 Jun 2024 07:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="eWCqq4U4";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Xt6DLQr2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473931B28A;
	Tue, 11 Jun 2024 07:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718091044; cv=fail; b=YB2LUMJ1xjjZNUG3lX/237f3lWw7K2qSxIaRPPd3wYtk8cVcgFSdYtGI5lW7GzHWu+fHGYZr24CtwfmC68PT3I8CNlbTPISIXiYln3pb2gEZOjHge54V0kGIh1apO206erwS+RIv64y153KRI6dCXu/MU47xwZwvam/37fla0Fg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718091044; c=relaxed/simple;
	bh=uPUtL07YNb6vpwrZGN3de9WaYhVfdcraVzxCjQbOGOo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Kc51HhW8ir3BjPQm5pBZ5due230f7oKOkxD5UeIy669XWjDacScNvAi4sm1QMp156l8cWxuqwpZGFHz8jiFdESZbEeYUzY/NO23RycubIwDbC6+cdAsli1VCOjDpJxmc5Dy9uun/8vLtkAI1CG1BAZp4b2C8+P5BPIkjzb5MEEU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=eWCqq4U4; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Xt6DLQr2; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ANDGkZ001920;
	Tue, 11 Jun 2024 07:30:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=xHqfzjfBJHiyWopjPn6oOjmCCxZbDrJ2KczBZMrjAF8=; b=
	eWCqq4U4Cvu3b/JEDVyw/Cg5W2HENJywjVgCUrdexIw7GrYKOoZ1spIR9e8pRlGE
	WhHG6xynA4tAGKzCzNBb2zhwM5w4c3pC8JfH/LU3qNMFjWnto1AoGj/KcMrykBRE
	w7yalbIUCs3a9+zV8HIQ0aJK3okHEMilVAHwZHefGsX7dCBAdX/9QrAKb+CERub5
	rHzO/Wu53fffvJcr/2wEcBNe9XaIDQG5KEnjYPpq7HFCrwR4lOp6fvfiVilTSnQm
	BvJ4Jp74vy//jlxj2WdIa2j/yyw6KoC6qenhBqqr+pY6WGRc8fnlUl9zTDp4nlGU
	rKFB1CJrNAJGGKO25DhuJQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3ymh1947cj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 07:30:06 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 45B6IJtc021181;
	Tue, 11 Jun 2024 07:30:04 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2040.outbound.protection.outlook.com [104.47.55.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3yncau3u2k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Jun 2024 07:30:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SQYtP69t+wWktPDGrnNfpjHUPamIN3aaTBCU0/PkMmt/VAIdf16L3eSM0vx6uwXf0+l3nunMfFZ/ssvb9CKPcrnQNGz++scngUGOPdmisvODiXxxJw+DmjFlnEbvU9Bo20+tIQQDjeG1sS0Q+AuMz2VVy2kCMWHfeCuhLSEuIS45aWYDddyaIu5fYq+TraO6qLBu16rCHmaZgLS/WBLbxq9mSMTI6Es1jxelrlN7/1dXXkSCfoyy9bZlBkLHd2nyEPOj4UpBGysskXycG+zUC/MH3qPogNOVZ4UtCe5tdUCa8AhE7PBx05uAJXdTrHQOztQA90nmYx8T7XyU+EsPLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xHqfzjfBJHiyWopjPn6oOjmCCxZbDrJ2KczBZMrjAF8=;
 b=aXoZpORK9PX20vEVsWiEYF4Bao1mhNNZw0Po8EZUj1tRrZuTS9P0r3MqTLNLFHcS4dh7ADHjKquqnW5NdsDrM7aZwq0mUBau7YWdv8XTAsy9JVgM9Mwyz+pBsK3UZ+IURIAxIyMIkYYNqb8wwyB2upTANZnobHbGWewy/O4Y0hTj8jvvvY9jp4hiciKvVAm24hzHiNcasj9Vae4LjnPlUdrOFXAc+9Cq0lJyFquBWglWkjLX4h3JwmyXPYaSnOsaULQ8ylYhiI6d84lmy3JwH+I6TDiD4jAYD3TxjfhsLVIx0dNmlihtGAUFtTkzdbGmKpzZt+aoFx9S4AdxtG+/qA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xHqfzjfBJHiyWopjPn6oOjmCCxZbDrJ2KczBZMrjAF8=;
 b=Xt6DLQr2IE73SJ+juJ7IOEhDChiid3YtUkfiAVwOI/8fKWY7hjtvvs0P+u9S5enmHVxW9uzXoNTz8Ed0M8sUI61TuxsOKMmxVPhzMthCHE2Aj8gX26VYPL4eZqMpXXm4uFGbyhcdcwTLXL0PTalb9hvqbsr80AsvMFvnxa+74jk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA1PR10MB5868.namprd10.prod.outlook.com (2603:10b6:806:231::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30; Tue, 11 Jun
 2024 07:30:01 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7633.036; Tue, 11 Jun 2024
 07:30:01 +0000
Message-ID: <180c98f5-faf9-4578-a069-3586c6b48252@oracle.com>
Date: Tue, 11 Jun 2024 08:29:56 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
To: Long Li <leo.lilong@huawei.com>, david@fromorbit.com, djwong@kernel.org,
        hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        chandan.babu@oracle.com, willy@infradead.org
Cc: axboe@kernel.dk, martin.petersen@oracle.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, tytso@mit.edu, jbongio@google.com,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com, mcgrof@kernel.org,
        p.raghav@samsung.com, linux-xfs@vger.kernel.org,
        catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
 <20240611031009.GA3408983@ceph-admin>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240611031009.GA3408983@ceph-admin>
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
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA1PR10MB5868:EE_
X-MS-Office365-Filtering-Correlation-Id: 8cd2d716-fc96-4364-8f75-08dc89e84e06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?Y20rZW5COFNqelkyVG43WXU2QnMrK083L21VVTIvdlJZRlVTdENqUngxaFFz?=
 =?utf-8?B?UVBYUEpQdkFQV2RERWE5MGJiZHFQOThWRnNjZGdWQUxUcUxCZlR2NFpRTGxH?=
 =?utf-8?B?YjZzQktKdWtmSHdpYnptT2Jwc2ljcjN6ZWxrNmxTZndzaDRmTUMvMEZyVGhX?=
 =?utf-8?B?b2JCTVRFVEk3MURaWERiQk1hTnFIeFpqRngzbWJ2ek5RcmwrQ0IxZ0diQ1Az?=
 =?utf-8?B?VFVvRkFqQ2pqMmFjb3U5K0RxYjdlRUNxcE0zWGhCLy9KM09DNVJhM3BsQ2Y3?=
 =?utf-8?B?MVZsK1JpemZpb054RXhhaER6czF6ekg1azhTS1dYV2lmMXh0LzNvSXZrUlJT?=
 =?utf-8?B?VWNWeHI2Qm1hQkpTdEM1YWdiaVRoSTlIZXVldlFJc0dabHYyeGdvbDlsNlFP?=
 =?utf-8?B?Zzhzby9lbGMwL1dSZm1yUWZvVHdhOEdnRG91VnFEY3lOV3FtRHVZaFNZUjJy?=
 =?utf-8?B?WU8xeUszYndwZFhDendVUkN5MTk3Ylpsa2lvOHUzWXVRaDgvc0VCTndxVUNT?=
 =?utf-8?B?SnlkR0QvOVkrTXI1eFVlZ2YzdzVtTFhqREhZd0owTHdkQnZVSk5NallJMDd4?=
 =?utf-8?B?bk55eTlQVEJESjdJcHFTcEYzajdSeXRsUWw2SUZ4YTVJZUFucUkrblArSUVt?=
 =?utf-8?B?bFZqOHI0OU5nMTVjc3gwaUtvdWc3TUV0U1dtZGlLZW1RU1RhWXp1d09TT1Fv?=
 =?utf-8?B?Rnh2NVlJMGVDbVJmRTdpMHBDd3Rvd0syaXJCM3lmZ0FqTGt1aHVpbGhoYzk3?=
 =?utf-8?B?cnN6SW1paTBQVDhCUjZlSnczU2dUWWpkdzZlb2d0YTlHZnkxSW9uMDJxS29L?=
 =?utf-8?B?OGpCdDZTVTBuc1FadExNc3IxdkQ4TklxYTNqakFkMjFxMHhrZWlzVkdSdXlo?=
 =?utf-8?B?OXA4dHJVN3pzTjR3U3dqd043d205eEpCSnBxTEFmNWtqL3VPdDJFZkFTb1c0?=
 =?utf-8?B?QUE1bDNnc09tMzVpdmtDN2xvbmpwMDU5eFFBcndPUURrZFlpWEtVdUJDZFls?=
 =?utf-8?B?b0hEajlDYTBCTFpWVHUrWWpaNXN2YVQrcVB1cVh0WldXbXpKbGNFeVo5cWlK?=
 =?utf-8?B?ZzlJMlRTT05FN3Y1aVN5MjRJYnowYVp0SmdpallhcnIwc20zc1VVMzhRVVpk?=
 =?utf-8?B?SVovWklRZkJqUEgwNFhDa2hBcTNIcTMwdm84TU5iUDM5NHpkTnNsY2U4VDNz?=
 =?utf-8?B?VkRHTmxaekVHeitpeFo5OXJML2htc1g0SUovWWpac2JLMEtIV0E0NkZPSjc2?=
 =?utf-8?B?Q3JOa3BsWWc4UlhrZ1B4K3M1WDUzZWdxUFQ0eEgveFhnOE1rUE96NXg0VDRG?=
 =?utf-8?B?SklVbGhmU0M1L0VFR1k3YjZsYXRzSmZJRTdscFBOQUxjRCsrd2hpSkt4TVov?=
 =?utf-8?B?NUlPY2JTV3dkS3BJaXltYmtyK0pYMEF6RE5vVG94VmliQm5NR0tBN3preEpj?=
 =?utf-8?B?SmUrZ2o2bEQ3M1loMUJ6K1hxeVpyZEhBbkVjaW94a3A1U2RoSFFaRS9DejND?=
 =?utf-8?B?TVNZOGNEcXNOc1Zkelo0MlNJNkIrWHdMWTVudnZ4azYyWmhQd1JFK2JDczFr?=
 =?utf-8?B?SHAwWXRDeUhUZjZrVE5nMTdudmp1N25QNlcrZG5MM284WFVKNmlzUmtSNHBx?=
 =?utf-8?B?VUNleWxOUk5sTVI3MVljT0NqbXFRay9ZT0sxQXpCaEZERlpJQUI4dVBJenlu?=
 =?utf-8?Q?ZHJ2HzeKE6GuOpV6P9Vd?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?TW9rRlFyQ0tScWZpQXZ5S2NPNDBHV3p2eXpjelc5ZGcydG5IZXl6MmJsVmc0?=
 =?utf-8?B?K3p2Q1pReWMyY1pYNVJJQmE0UEVJRG04ZklYMis0MGdxRWVlb3ViSE9ScXcz?=
 =?utf-8?B?S2RBSlNVOWtsb05wOEkxYWFkM2hmaUkvSGg0ditpOUdEdVFUTmpYcmdrWkI5?=
 =?utf-8?B?WWNsTlJwdm9iZUd5Q3BvNGJUVzRDTG5YT2VUdk5kb3BRN2JscUpuaUM3VEF1?=
 =?utf-8?B?c0xvcU5UMmRXTzZKMzdnSXkvQkQvSXl4N05KS25UNi9Vb29VUVhNYU84Und3?=
 =?utf-8?B?WWFHdGZxdFYza3ppN2NzeXJ2dHlIdjdKRGVpL1RqVS9STFZ3dFhVUkxqWGhF?=
 =?utf-8?B?a2o4NnNrcHZ4cXNKVUE3bmpYaXZEU2lKRlZRTUwzYzlDVWFrVHRxU2F6eTRM?=
 =?utf-8?B?cXlWWStQUXRvVnhCWHYyV1F1R0VmRzl3K3MxZFBiQ3BPWHlCVjlPWGVZSVBw?=
 =?utf-8?B?SUpZOVNLaWN5OEMzRTdTOWlSL1E1NEYwLzI2TE5LaVVzWjR4MWFzbThpNWZj?=
 =?utf-8?B?YmZWdXQzTHYzM204WG5saXloNmRVTFY2cWJNb1lyKzFGbUxzRTJzLy8ycU9y?=
 =?utf-8?B?WmtvTTdsZGdUMGwyV1pBTmZGYWJkRXR5M0NUemw0SWhaVFhZbUZJREQxS0Vq?=
 =?utf-8?B?eTNlT3VrZXZwZXdCdGpqc0o4OENSZWNOVTVkODNpOGVFNjB4UTJibmhaMHV1?=
 =?utf-8?B?SzMrU1JoVzB0UklIRHF2VU5lY291dGcvNUgxR1E2d2ZVQ1BUUmRhc0Fwd096?=
 =?utf-8?B?ZERLZ3hmZ3BaTStqbGdvVzNEKzNybmZXakV2RDh2azZ1WFdEUi9PbUhlTlp1?=
 =?utf-8?B?YjQza1hCTHlqamFKVFRSYjAyZnFnZ0lvTDhkcWNBb2ZSaGFGRHp2Zlg2Zzcr?=
 =?utf-8?B?SytJNUF2bXQzc1NOZVdDakVhVUMrc3RMQk95RTVyS3RYMkhCRnhkTmVKV3JU?=
 =?utf-8?B?OGFLRUppQ3dXTXNFNysremI1SE5QRC9Sc0Q3ZzVmVE1FVWpSZmh4TDMxUXR2?=
 =?utf-8?B?R3hCMm0rY0VHZjdzYmlybmlhc2dGdVErUjd2ay9XWHdBR2RmUU9DajNaWU9D?=
 =?utf-8?B?WUljZHc1WWVUS0hTc2FoSXduMDVXbEo4eFQxVVR5UmxmdlhGTWl5QTZXaGti?=
 =?utf-8?B?Q1p1OWc5c0tiV0x0REZXRjhiWkdQZGRkQnV1Wks0R0wyVERqS0RDOFBkNSsx?=
 =?utf-8?B?MWVMVWdIbWREeFFxU0VGazZXZm1jeGE1M1pHVjZsNStQSXBBQmxzR2poQ2Vw?=
 =?utf-8?B?NUZaWWJpNCtHOHdtekovY04wUTB2aFBzanliRmZxdHBOTGt2SXY3UTVFV3U0?=
 =?utf-8?B?N2tJcW5wRURublBwMkhyc3cvbFczVXlMb1VCMUVBZFV4UWZHWDVUcnJjcklT?=
 =?utf-8?B?cURjZi9Sc2ZXbFVSMUZQckRMNS9DMmNMcnhkWGFCVFZzTndRUnVHZTNxUkJI?=
 =?utf-8?B?Y2wvVFVjbVFyNXI2c3NCbEZIdW9VOUxtVzFqSUgrdWlBNmtpSFh3dUJFOERj?=
 =?utf-8?B?OWJ6Q2NIcFhSRmtDT1pOMGJWeTVBZ3FSZDV2M21qSkFGZllHOUpKSGNJK0xw?=
 =?utf-8?B?cnF3WThrMC94U2tWQXQxaHZ0NFRkSUlzU0RWL1VGYmJGdGxuWFZkYmtRY3dk?=
 =?utf-8?B?Rk5IcWJvQzhGZ0lrVUFxN3NoSCtTUVprQXI5Y1FyZTFFbnB0LzRPRkRiWUFk?=
 =?utf-8?B?UDdFZlkxZTQzRkZUbjdKMFhDSE9kV0FLdCsrVnVJb21tYkRFV1ZvS2dEd0kz?=
 =?utf-8?B?Z0dSaUtjWDJVK0JTN29PUVRvUk82TjFFZmw2elFhOG1jdjVuR01kdnYvTm1T?=
 =?utf-8?B?OUdRNGEwMXJVVUt1bGdtQlpWWkpEQU1RaWlrNnZnbGw1NDVreUkxeWg4UitU?=
 =?utf-8?B?YmtjclVLVkF0amtRak16MXQxbG1hUXhuUlFVTW9WV3BkeWlBSXBzRm9UakFU?=
 =?utf-8?B?c2FDUks2OHhtNmRSdG5FaUx1RXlVc2VNanVWWUYweTBoSmV1ZmtFbkxJRENn?=
 =?utf-8?B?QVduS1JYTk1qMWRMWmNCSEgyWlhjQitBNlFZWGdiVThSNVJYSzhLc2ZmWUNN?=
 =?utf-8?B?WGU1R3dFVTIyY3RqTjB0V09DVEN0TzN6QW15MXMvTkRQbFJlcUwvQWY3QzFT?=
 =?utf-8?B?bXJYVlRQbzJQRHpsMko5NWYxYXIvWTlWaWZVMXF0RnBXQnpHOFhFdE8xeitR?=
 =?utf-8?B?SkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	4nORxT45gGenYElB85DjNjPmbMdpq3I/oDwWdJZSUPIPJvnxjLdllUSKpwYZjLUttIZbyXvs2mHS5+YUzTTGTE5y2goSlCrNJHPglxVECDI7iwkaMKHGYJH+QDacRDoK2l6LUOUokD3iAdkAvauoHACjzHanskm9Ea+vhO8TGwFS873r1gPi2UzLfH/Zx5hrhK06UaOHrqT9P9eUZgcuMYLEuPfcDCvPtmBf2pITcwp2kuZb5x43IKYdp+En8tDHORTlHedbJUq5xmKvenq9jpkWrvuq5XdousTUOXyO+SYvFHpFXmbwdoBye52FqDtPxb4bbeZ5ZaAXKQDFbqNmupJbn1UY6/Edhmk4ReTOaAZxttmaRJG3Epvtqg0EGeGhKa3oZIPILE9/bkF+ZdxwdgbtSZHBqX8/2qTbcUYY0SKzN5vnkKHdGk7qETp68uMESzRpV7glAwcRZbpwdKLnMh81S8vsuHwR34dbAV01pDwUppwjlOIV/706EV63S5xEVMtSOunSwcaM2RpSXR5dklGYkL0hC1OvAFnQCT5nqUdkFokV46iv0qClXvSz1wQd29PoUrpi7hbPL5ooxgnw6+93CrsSFuE+JEt5G+Zx02c=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8cd2d716-fc96-4364-8f75-08dc89e84e06
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 07:30:01.6609
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kEGxJNEWtpTZEbpUXaX2w/6uit/qcZB7MBv28LFYhOLLNfuXZDgnVMDJ8zit1CKqw2MblOd4UGglQl+NUNgoaA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-11_02,2024-06-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2406110055
X-Proofpoint-GUID: gJq1c_dMdotQqBqXnR_VWE86TNiFvAVg
X-Proofpoint-ORIG-GUID: gJq1c_dMdotQqBqXnR_VWE86TNiFvAVg

On 11/06/2024 04:10, Long Li wrote:
>>   	if (need_zeroout) {
>> -		/* zero out from the start of the block to the write offset */
>> -		pad = pos & (fs_block_size - 1);
>> +		/* zero out from the start of the region to the write offset */
>> +		pad = pos & (zeroing_size - 1);
>>   		if (pad)
>>   			iomap_dio_zero(iter, dio, pos - pad, pad);
>   
> Hi, John
> 
> I've been testing and using your atomic write patch series recently. I noticed
> that if zeroing_size is larger than a single page, the length passed to
> iomap_dio_zero() could also be larger than a page size. This seems incorrect
> because iomap_dio_zero() utilizes ZERO_PAGE(0), which is only a single page
> in size.

ok, thanks for the notice.

So 
https://lore.kernel.org/linux-xfs/20240607145902.1137853-1-kernel@pankajraghav.com/T/#m7ba4ed4f0f0f48be99042703c10b42b72c9fe37c 
is changing that same function increase the zero range past PAGE_SIZE. 
I'll just need to figure out how to make it support an arbitrary larger 
size.

Thanks,
John


