Return-Path: <linux-fsdevel+bounces-20514-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BB578D49D2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 12:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4DBA284881
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 May 2024 10:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D8817C7B4;
	Thu, 30 May 2024 10:42:42 +0000 (UTC)
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D1C1761B1;
	Thu, 30 May 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717065761; cv=fail; b=NiKRBO4fiy2NPYPUrB5BJ+nkvwprAoaVrGkxObDewdW+YII531jFs+1SEjAYrrsK1ZPCCwNmM+fTgjTqz4b1P94NQwcBA07XTvHn/WESlzYKH85qiT54ChXHHkOz1Ho7gwwfCUC0p6zAb8dZUCqWRSkL3osQC5mC8FiwFNnPVqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717065761; c=relaxed/simple;
	bh=GXOKpUV0skPrmhlS1V25ZoG65f71Y9RVQfVSrd1t4d8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dYzYPCQDx6RoClz8pCwpAMY05iZjk+TN3t4n5ivjdOExGdD1CY4grYVXiN2Fm32YtLQNCZDGzBUEUSvQbKdXZp7U/QH5t2eLNGVqi7v5oe3arsh1700VL6WlZD1upqS+s59D6WpiC60oytIr9P6BujmQo8mx0+ITEiGg6lh3DDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44U7naE2005736;
	Thu, 30 May 2024 10:41:17 GMT
DKIM-Signature: =?UTF-8?Q?v=3D1;_a=3Drsa-sha256;_c=3Drelaxed/relaxed;_d=3Doracle.com;_h?=
 =?UTF-8?Q?=3Dcc:content-transfer-encoding:content-type:date:from:in-reply?=
 =?UTF-8?Q?-to:message-id:mime-version:references:subject:to;_s=3Dcorp-202?=
 =?UTF-8?Q?3-11-20;_bh=3DEKaI/V17s3nuO7AobdkQL95FVddH0mMRjxBu/bbZubA=3D;_b?=
 =?UTF-8?Q?=3DH+OoZEgYaW6AFm6XtbaGPh1pH0Voz3frpoVan9ktqAGR6pWz/nQY+InPeaw8?=
 =?UTF-8?Q?pn1MnbbC_+IB8jzqssg1vvzYVwDzXARibYojMp8DYhewU96dDhaEyXw///VpMtj?=
 =?UTF-8?Q?MsjroxK3QJTW/w_1iZDWqgqJPakkxwJ3rVRssQktBtbjTRqxE8SqMIg6TAntiQL?=
 =?UTF-8?Q?UTop6zU0ZDG1xXL5WvcH_mVWevlK0m7JAY3iMGZcdNERM4NMFtDXm1527tDT4bU?=
 =?UTF-8?Q?F4thbSKSB7h+Yf7iNe3iqtzLZj_tlMCK+f1+0e4HMoikebNbyRRU440M4TFavtq?=
 =?UTF-8?Q?oni7GH9NTdIyTW1gHePJCEwH7gPnf29p_zw=3D=3D_?=
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3yb8g48q0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 10:41:16 +0000
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 44U9COOT006248;
	Thu, 30 May 2024 10:41:15 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2177.outbound.protection.outlook.com [104.47.58.177])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3yd7c6s15r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 30 May 2024 10:41:15 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l/m+AAiNk5Tu5veC9AvHw8aI0uu7Dq17CzRTDF8mh5sbEAfz1I2kbovRZUqRGzWT+vUDuuvyVBK9eoPULozLbTWX8dgRz6NiY8TXhFht4ZqQonTyHJNxvdGF2DElqJfA9M57a1ZJ+DsFUStriGRusIC9BoJ5GwgPPd7jgwBpifEOCC0hVIwbRTl7CQDmt1khJfJZk2P7VyhfpTzS3QfkYZSudHIfJEhY8eWh+YBBQwDbto3FV35jaa1aQiksBy28nKjNrdO/n5cj4/j/EZa3Bs2Yl/WFG0cx9aZciJfdjT4A9zLCMcbueYKZzYMGKKVjZo2f4eKd9wpJ6Sd0jpaVWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKaI/V17s3nuO7AobdkQL95FVddH0mMRjxBu/bbZubA=;
 b=Ve2I7X0WEbZ6i8etV8WQAf1eCZjoQ1tzsnbBkiV0RZBY/Sw7ghcssfDlSGuKmu8sQA/ZJ4+hj+oN8iqnyhrfc9r9SIVTuSOiokMplZvCL3UcLZa44x6lIHn26IKBSu3O1oHAXBhFIg4MtAvNT4vaIwLqd3n6wsNgjHYSOkyfUJe+Pt8YVFYx6s2aCgd/7BpoTrVm9hZjegKxB0fELw9LpatmMAUCCChXx2pYj1mCPFhJZDHRgv9Rj4J/K89UfqYZ/elMmjJgve8NZ8IuO9v8pffD7cdVvhNRKnBoOne8KeRC2v24SnNloiQN2PmquVkQPNAZSE9NuVa5oYgDLSyacA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKaI/V17s3nuO7AobdkQL95FVddH0mMRjxBu/bbZubA=;
 b=qJwiifL9lkYrNgw4KGjwtZSP389e4WjwykdIvbjSfNKWzT4fUVW3+r6KhQviVbIJlgup0a6Z3VACLCaL0BnsWeAduNy2sKutZqKV4ara9GgLUm1MGXfqEkpqRvfk8Xw3edGwZpZOQ+O1PryQEN5hZXnSL03e7s2Z/K0NVSabSOY=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SA6PR10MB8039.namprd10.prod.outlook.com (2603:10b6:806:446::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.19; Thu, 30 May
 2024 10:41:11 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 10:41:11 +0000
Message-ID: <81b46c19-2364-4dcd-876b-ebad4626617f@oracle.com>
Date: Thu, 30 May 2024 11:40:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 14/21] iomap: Sub-extent zeroing
To: Dave Chinner <david@fromorbit.com>
Cc: djwong@kernel.org, hch@lst.de, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, chandan.babu@oracle.com, willy@infradead.org,
        axboe@kernel.dk, martin.petersen@oracle.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        tytso@mit.edu, jbongio@google.com, ojaswin@linux.ibm.com,
        ritesh.list@gmail.com, mcgrof@kernel.org, p.raghav@samsung.com,
        linux-xfs@vger.kernel.org, catherine.hoang@oracle.com
References: <20240429174746.2132161-1-john.g.garry@oracle.com>
 <20240429174746.2132161-15-john.g.garry@oracle.com>
 <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZjGVuBi6XeJYo4Ca@dread.disaster.area>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SG2PR01CA0176.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::32) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SA6PR10MB8039:EE_
X-MS-Office365-Filtering-Correlation-Id: e5455f30-9550-4fe9-a4ea-08dc80950584
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|7416005|376005;
X-Microsoft-Antispam-Message-Info: 
	=?utf-8?B?bVFpTWpZd1ZvMWVlK3hTSU1BeldhVWt4cVF0OGdFOXhDYnlMQVFrZU9NaXd5?=
 =?utf-8?B?NDZsM0VxTjlPckNRamZ2RkR4SGtDdXNUVkxSZXQ4S0hlWjhHZjNOVzNFcFds?=
 =?utf-8?B?bGtrL1BJdExVeGFXanBlT0xQT3owZ0tmcHVTaWc2UDZaWHVsdGpnQ001SkMr?=
 =?utf-8?B?YXl6VGJ4dXlUdU1ZOUtsbXVYTTNTc0RjSFdmektmT3p5UnVXcU11Z0dDRTlL?=
 =?utf-8?B?YmV6L2ZWQnliUDlOS0U5NG10QkdvVUJlT3pCNWVCVUJSR2p1dVk5WXkwNmdQ?=
 =?utf-8?B?bnk0OUppOGxPbTA2aVV4SlI3SlUzd2NxMkVpOFJHdEVlREwwdGRSdXU4R1ls?=
 =?utf-8?B?MVh5ZWdLMnYxTWdBakpnMDJIRlZnVld0VEtIcGV2ak9DV1JkODZJZFVJdk9w?=
 =?utf-8?B?U09MTkFaMDVTUFpuUk8wOXJxOFdXUElFYlhUTU41MEdNN3JPUEJrQndORFFi?=
 =?utf-8?B?d1hiYXNOV1I3M2xTeG05SVFUZHNnWmZpUUxsUEJhdzAycTdQSmpTMEc4RXpS?=
 =?utf-8?B?NDRkcUFnSmhtbXhJdG5WN3Rud0JEcFNWL0U5S1R0YklabkJZU0poVjhMcHd3?=
 =?utf-8?B?bFhuaHFlMHUzcDIzZ21tKzFTejFGNmNGZTIwNGErTERzR0laV0IvL2JVYUl1?=
 =?utf-8?B?dEtQbUtWaCtEdXFNdXJNaWFpUTIzY1RVam1ZakZYc1NubnExYUh3aGZIcTZP?=
 =?utf-8?B?VkM5WkdwSTgwdUhqVVUzRitOem5ja3IvNDVKTzNOTmMwc1FzY2UydG5hWElz?=
 =?utf-8?B?dVR1dXVlMFM0TlREMjhTUnhkWm5SUS9Kd1A1YUdkK3k0emhtOFN2aFdETFR0?=
 =?utf-8?B?QlBQS2ljVE9mZ3lNOVNNdjJUdUpkSG5oS0hSWXRLN25hUEhVV2lOMjdMTzV2?=
 =?utf-8?B?NVp0a3Z3L3cyRm1JTEpNUEhZaEp5d1FQSzN0WUVUbmNHTUQyTkdHVWQ0TTJr?=
 =?utf-8?B?MTZ4c2l4cTVocDcxNkVyT1hmNTd2NkhFc25CR3ZkRXVTZ1VLYXVGOUhSci9x?=
 =?utf-8?B?aElQMGdSQzN5NU1JTlAwb1AreG92MjlSTG1BczRuRDZ5WktpQ3pZbjBjalFs?=
 =?utf-8?B?UjlQWWFNS2IrMEJCckFnVFRaTmUxUkFobFl2MzV6cVpkRXZTdE5ZZWR4dWVh?=
 =?utf-8?B?K254a0MxdFVCRUQyMTZZS3lKeHpxeXlsb3YwT0FRTTdFODdtc1VJZWFiWkZT?=
 =?utf-8?B?MGNMcjJXMVBXdks5K0Y5UWhyd1pLZ1Z1OGpITkpPQmhDNmdGV1p3NTd4NHVN?=
 =?utf-8?B?WGpUaVpLZFUyOXNidU5WMExHaXVqdmRZYWtBNlhMaWhHVWFSeXZzeEI2RUNx?=
 =?utf-8?B?MjNWQUNNZHhDZW0zS2tpTHpxL0Q2dVJmU2plQmRvUlFNTUVFQnpXZVhjbEU5?=
 =?utf-8?B?dDdwR3BpVnA4cVRHT3lRVnJRWFBhKzc1emo0d2pzRWJkamcxLzVuMXFQVXRF?=
 =?utf-8?B?SE9pWThySFZCN0RhWFNWQk4zOExjZVBsTG1vNXQ2WkVHMnp6VFhIeUU2NlVy?=
 =?utf-8?B?Uk4zUUJNNUdpbU9TbWhLR2dvVE9MRmxmMENpemVmK0xRbDJKWmRGNWVic1U4?=
 =?utf-8?B?ZWRnMEM1bU51L0ZTUHdCNEphSnNIQlBrTEpaM2pwL0JrZUcxRk9kc1hXOTlt?=
 =?utf-8?B?aGh6MGJJQXJJcXU5bFErakZzRW5HUDhhNHJuQ256VnRISmJtb0puREFhak5w?=
 =?utf-8?B?RSt6cEo4eUFIM1I5Z3NSajZrb1hDR3FVTERVblgvNXJOb1MyaWIzai9RPT0=?=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?cXl5aUhPMkE4NDF6bHpEVmNtaWJqWERjRy9IejFzZ3dMb2Q3ekN5blMzcVdh?=
 =?utf-8?B?K3JmbWVTcmJyRWVRbC8zV1l0SWtUcloyWjdrMS8xQkhCa0Z1cmtZYzNuWW4y?=
 =?utf-8?B?ekRCbkdGeDM5VHM2R0NqV0dqL01kS2JXV2JKZlR3WmhCb3lKOUZDK1VDaEFN?=
 =?utf-8?B?NENQQzAyQUV6ZElxVjcrRTFFcFZNSWl1cEpZbk9UTlBmODFVNmtqMTlJNStJ?=
 =?utf-8?B?akRlYTVpbmZWUlZLUGVscUJ2Mms2andGYlVwWkJqUUVwMnNMRTMwR2gwR0FP?=
 =?utf-8?B?SkdUN1JvUE9IWERGb1hnUzV0QWFSRXRwamZUTUx3QWhUVUtFczh3TlpPTm85?=
 =?utf-8?B?dmNiUFVBY1I5MlpZQWNCWVJTeDF0OThMSEdpb1JJaXA2d1JNcE9TeTJhblJv?=
 =?utf-8?B?UlgvajNrNXlDajBZalN1K3ZQY2N4Tk0waGl5SjRBbWFVcnlEckpVQ2pBTDd4?=
 =?utf-8?B?dWYyZ0tPbkRuVjhFRVpxbHlFb2UwQVF1d0R0RlpKWHJ6Rk9sT1dod0JBcHhI?=
 =?utf-8?B?eGJpK1hPcmNnQkw4dC9GUFNUWHYyY21iZVpmc2pmU0JiSTc3TFlHUmZmWHAx?=
 =?utf-8?B?NXcyL3lDb0o3b3l4c1ZMeGNEOEFodmk1cWhqY0VyV3ZybXo4bG1UODdsaktk?=
 =?utf-8?B?c2ZJSDhwQlVzaHZzRkc3ZmhOMm5WbG8vM0x1SmszUmJtdncxSXZYWUQ4M1Zk?=
 =?utf-8?B?em5BSzJHZlJGL2JQMWN6T3d1cnNkWUovNk5TR0hMK1plazdoUTdHLzlmSzdq?=
 =?utf-8?B?L3NuUWFZSHJpWnhFcFAwK3ZTeDlhN2xxT1pockwrcjRhdzlPNFNHTGZYUnNT?=
 =?utf-8?B?VEg4bTFocmNHYkYvQ3F4UmJJUU94Vm1qQ3NUYk1OYk9JNjdqdlUxZ240bnF4?=
 =?utf-8?B?N1ROMXhuZk10bjlqbFlXNzVnYkoxOFBTMkl5Z0ExeWNvNlIzWVBwNXBEOFYv?=
 =?utf-8?B?V1RMbmlGenlETUN2TVBlYU82eFJvUHBvbHFuTGw2T0pncDNjZHJKUVgwRmNm?=
 =?utf-8?B?NndwRE8walpwM1hJalpUWE1rV3E1VTFyVjJWOHJNUFRxTm5ybERUcU5henhr?=
 =?utf-8?B?U1gzZjZXbWhhRVhDRVgvWkJrTGlMdngxN2FrQ05vYWdnYnBFOFcvZnE5V3Zh?=
 =?utf-8?B?NmV3eFJqa0ZGclIvOUE2SVFpWGJoanJHL0hmSG5EeVNRMmVhdjlKYXJjeUVL?=
 =?utf-8?B?OFgwb1Q1dzIrR3NVbjZST2tiUUwvUGZjTDdROWhsQVkxZjBuV2RLb2FQejBl?=
 =?utf-8?B?bjJ5Wk0ybWxqTFFBVGJnd3EweEtuUGE1NExJUk00Y2N5MFlkN2lPQ0JDN1E2?=
 =?utf-8?B?RGwrRkVJMzNEVDI3RUN4clJHZWE1WWtBa3phaCtWd0tuV3VQZlJ3bGphOE1V?=
 =?utf-8?B?dU14QjMxa3pWQU4wYSsxYTdEamdzRWpzeXR5cTd0NzgxcVdTN0F1Wk1OYTV4?=
 =?utf-8?B?TGJSNWY1TnMxUHdGdnU4TFEydTg3MllyMTljVklDYzlVN2lLT2dKRFhWSlpt?=
 =?utf-8?B?UFp6Z2lnSE1BYVNXbkRzUWVLRFlqdUJqZHo1dGdmM3M2akJGN0NUUWhsNlAx?=
 =?utf-8?B?U2JhU1NZMlVremhwWGduOHg5U21zKy9NMVpLd1RPZnNDTHJsZG1FR0RpZEVH?=
 =?utf-8?B?WnVGMGhGQnJwVzRoVzYyUUlEbW5YS2RoVmRadjlhaVBka3FKZzl3YVVRNmNk?=
 =?utf-8?B?TW5ZaDhvajJ4ZXJqU0NMRjJCNlVTK0VSazRJYzJQR29QTVhsMXRLejgzWk56?=
 =?utf-8?B?MnpPYnR6OWRTNjdxUUVlMDU3UHI2cDJwME5abzYxZjE1cGNMbDNxYTZpbUd4?=
 =?utf-8?B?Yis2TkN2STFmSy9qQ1FybDI5U0l5ZVhXUkJlbDR5NjJ3QUJkYW9oQlFjWkZz?=
 =?utf-8?B?bnNDT3NZdW9tbjB2bmhDRERJVG9aZnVvVDhTbVQ0RThGcTJwL1dUQXlPdTVy?=
 =?utf-8?B?NVFWMmJjdXBqQmFjQjBYYnRSQkI1UkFIQmcxUUhGSXRXMk04QkpLaFZKVi9D?=
 =?utf-8?B?b01USm5TelNpYytqK1Z0UG1tbVFOQmZFNVZGTHFjNWZvZEdST3ptdTBzUk1E?=
 =?utf-8?B?bllCaXh6TVBOTTB1ZnFYUTNKTjAyczNBcUpwbnZJVzhVeXZRemNnK2orMHd6?=
 =?utf-8?B?SjNOTTFWN3M1L2JhMldVYlRxZFE5eGVESmc4Y1kvQnpsT3MxRllDaDhQaUUy?=
 =?utf-8?B?MkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	tuRzHXJuw5GW77QKn65yxpgoXQ+VbJnAUl7AUxgJJ5X4zXDPBpwIJ4y2EZ1ZQq51IjBRCJw3bO5W2RAres58sHQo9xq1f7fWAPc5wOGWVgX8nI/RXmhjtODy7HJ7PzGHDvaaY+JkP6cKLrLeMnJ9b4zYJIoeLFO8BBuxD41Gkx3rNyElUApFeZfKXydOTpk0afZEStXxZG1tNKORxOQYEv7gVY/dVBKRH1gO5pF0srfc7E8FdXKY6UUOindgS8Tic2Hv7iRdjRIyRbKXBGGB1Mp4+Wrxt8On7xLrgrFIdDbHh0uN6j32Ip8ZeUQo8Ig4msAXSU+c3tDXCvgLXS2gPMtB/5MagfuiH/0SpFCaETkMPM6Fux1jauGIDLtZKaDZl9o+G5/eCqlTlqSmNqwnd6SSEEqMxpzbm71kBkrTfUSGAOGNq16bFF8s0IEyVezn3nc5NC2DUxFOb6CRMikqE82sg5PvD7LKlLKTLHBNsB/3Cy1nTuKtHFB/6DhQK8t0vbmqZVw+sa2l7XyV2Qij2mafIUNqjjHhAzzoZX0+turg9GifxXBjVUb00w/TvajxPhAyEcoDh95RvlfetibV7QmGhRtR03PMSgHgk5rH0N4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e5455f30-9550-4fe9-a4ea-08dc80950584
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 10:41:11.4088
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8hn8dBEd82sbCEo1wUFvZ7V8CLN/9rOkrTo612MhZ3kL6StdAc5Exl+7tNrFwyMq4Bgi+U+GebJWReBVRHNLeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR10MB8039
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-30_07,2024-05-28_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 malwarescore=0 bulkscore=0
 suspectscore=0 mlxscore=0 adultscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405300080
X-Proofpoint-GUID: yVKAgU63bF_-POR5Ex4mEfari-naNtMp
X-Proofpoint-ORIG-GUID: yVKAgU63bF_-POR5Ex4mEfari-naNtMp

On 01/05/2024 02:07, Dave Chinner wrote:
>>   	blk_opf_t bio_opf;
>> @@ -288,6 +288,11 @@ static loff_t iomap_dio_bio_iter(const struct iomap_iter *iter,
>>   	size_t copied = 0;
>>   	size_t orig_count;
>>   
>> +	if (iomap->extent_size)
>> +		zeroing_size = iomap->extent_size;
>> +	else
>> +		zeroing_size = i_blocksize(inode);
> Oh, the dissonance!
> 
> iomap->extent_size isn't an extent size at all.
> 
> The size of the extent the iomap returns is iomap->length. This new
> variable is the IO specific "block size" that should be assumed by
> the dio code to determine if padding should be done.
> 
> IOWs, I think we should add an "io_block_size" field to the iomap,
> and every filesystem that supports iomap should set it to the
> filesystem block size (i_blocksize(inode)). Then the changes to the
> iomap code end up just being:
> 
> 
> -	unsigned int fs_block_size = i_blocksize(inode), pad;
> +	unsigned int fs_block_size = iomap->io_block_size, pad;
> 
> And the patch that introduces that infrastructure change will also
> change all the filesystem implementations to unconditionally set
> iomap->io_block_size to i_blocksize().

JFYI, this is how that change looks:

----8<----

Subject: [PATCH] iomap: Allow filesystens set sub-fs block zeroing size

Allow filesystens to set the sub-fs block zero size, as in future we will
want to extend this feature to support zeroing of block sizes of larger
than the inode block size.

Signed-off-by: John Garry <john.g.garry@oracle.com>

diff --git a/block/fops.c b/block/fops.c
index 9d6d86ebefb9..020443078630 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -402,6 +402,7 @@ static int blkdev_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
  	iomap->addr = iomap->offset;
  	iomap->length = isize - iomap->offset;
  	iomap->flags |= IOMAP_F_BUFFER_HEAD; /* noop for !CONFIG_BUFFER_HEAD */
+	iomap->io_block_size = i_blocksize(inode);
  	return 0;
  }

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index 753db965f7c0..665811b1578b 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -7740,6 +7740,7 @@ static int btrfs_dio_iomap_begin(struct inode 
*inode, loff_t start,
  	iomap->offset = start;
  	iomap->bdev = fs_info->fs_devices->latest_dev->bdev;
  	iomap->length = len;
+	iomap->io_block_size = i_blocksize(inode);
  	free_extent_map(em);

  	return 0;
diff --git a/fs/erofs/data.c b/fs/erofs/data.c
index 8be60797ea2f..ea9d2f3eadb3 100644
--- a/fs/erofs/data.c
+++ b/fs/erofs/data.c
@@ -305,6 +305,7 @@ static int erofs_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
  		if (flags & IOMAP_DAX)
  			iomap->addr += mdev.m_dax_part_off;
  	}
+	iomap->io_block_size = i_blocksize(inode);
  	return 0;
  }

diff --git a/fs/erofs/zmap.c b/fs/erofs/zmap.c
index 9b248ee5fef2..6ee89f6a078c 100644
--- a/fs/erofs/zmap.c
+++ b/fs/erofs/zmap.c
@@ -749,6 +749,7 @@ static int z_erofs_iomap_begin_report(struct inode 
*inode, loff_t offset,
  		if (iomap->offset >= inode->i_size)
  			iomap->length = length + offset - map.m_la;
  	}
+	iomap->io_block_size = i_blocksize(inode);
  	iomap->flags = 0;
  	return 0;
  }
diff --git a/fs/ext2/inode.c b/fs/ext2/inode.c
index 0caa1650cee8..7a5539a52844 100644
--- a/fs/ext2/inode.c
+++ b/fs/ext2/inode.c
@@ -862,6 +862,7 @@ static int ext2_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
  		iomap->length = (u64)ret << blkbits;
  		iomap->flags |= IOMAP_F_MERGED;
  	}
+	iomap->io_block_size = i_blocksize(inode);

  	if (new)
  		iomap->flags |= IOMAP_F_NEW;
diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index e067f2dd0335..ce3269874fde 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4933,6 +4933,7 @@ static int ext4_iomap_xattr_fiemap(struct inode 
*inode, struct iomap *iomap)
  	iomap->length = length;
  	iomap->type = iomap_type;
  	iomap->flags = 0;
+	iomap->io_block_size = i_blocksize(inode);
  out:
  	return error;
  }
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4bae9ccf5fe0..3ec82e4d71c4 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -3235,6 +3235,7 @@ static void ext4_set_iomap(struct inode *inode, 
struct iomap *iomap,
  		iomap->bdev = inode->i_sb->s_bdev;
  	iomap->offset = (u64) map->m_lblk << blkbits;
  	iomap->length = (u64) map->m_len << blkbits;
+	iomap->io_block_size = i_blocksize(inode);

  	if ((map->m_flags & EXT4_MAP_MAPPED) &&
  	    !ext4_test_inode_flag(inode, EXT4_INODE_EXTENTS))
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b9b0debc6b3d..6c12641b9a7b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -4233,6 +4233,7 @@ static int f2fs_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
  		}
  		iomap->addr = IOMAP_NULL_ADDR;
  	}
+	iomap->io_block_size = i_blocksize(inode);

  	if (map.m_flags & F2FS_MAP_NEW)
  		iomap->flags |= IOMAP_F_NEW;
diff --git a/fs/fuse/dax.c b/fs/fuse/dax.c
index 12ef91d170bb..68ddc74cb31e 100644
--- a/fs/fuse/dax.c
+++ b/fs/fuse/dax.c
@@ -577,6 +577,7 @@ static int fuse_iomap_begin(struct inode *inode, 
loff_t pos, loff_t length,
  	iomap->flags = 0;
  	iomap->bdev = NULL;
  	iomap->dax_dev = fc->dax->dev;
+	iomap->io_block_size = i_blocksize(inode);

  	/*
  	 * Both read/write and mmap path can race here. So we need something
diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index 1795c4e8dbf6..8d2de42b1da9 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -927,6 +927,7 @@ static int __gfs2_iomap_get(struct inode *inode, 
loff_t pos, loff_t length,

  out:
  	iomap->bdev = inode->i_sb->s_bdev;
+	iomap->io_block_size = i_blocksize(inode);
  unlock:
  	up_read(&ip->i_rw_mutex);
  	return ret;
diff --git a/fs/hpfs/file.c b/fs/hpfs/file.c
index 1bb8d97cd9ae..5d2718faf520 100644
--- a/fs/hpfs/file.c
+++ b/fs/hpfs/file.c
@@ -149,6 +149,7 @@ static int hpfs_iomap_begin(struct inode *inode, 
loff_t offset, loff_t length,
  		iomap->addr = IOMAP_NULL_ADDR;
  		iomap->length = 1 << blkbits;
  	}
+	iomap->io_block_size = i_blocksize(inode);

  	hpfs_unlock(sb);
  	return 0;
diff --git a/fs/iomap/direct-io.c b/fs/iomap/direct-io.c
index f3b43d223a46..1e6eb59cac6c 100644
--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -277,7 +277,7 @@ static loff_t iomap_dio_bio_iter(const struct 
iomap_iter *iter,
  {
  	const struct iomap *iomap = &iter->iomap;
  	struct inode *inode = iter->inode;
-	unsigned int fs_block_size = i_blocksize(inode), pad;
+	u64 io_block_size = iomap->io_block_size;
  	loff_t length = iomap_length(iter);
  	loff_t pos = iter->pos;
  	blk_opf_t bio_opf;
@@ -287,6 +287,7 @@ static loff_t iomap_dio_bio_iter(const struct 
iomap_iter *iter,
  	int nr_pages, ret = 0;
  	size_t copied = 0;
  	size_t orig_count;
+	unsigned int pad;

  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
@@ -355,7 +356,7 @@ static loff_t iomap_dio_bio_iter(const struct 
iomap_iter *iter,

  	if (need_zeroout) {
  		/* zero out from the start of the block to the write offset */
-		pad = pos & (fs_block_size - 1);
+		pad = pos & (io_block_size - 1);
  		if (pad)
  			iomap_dio_zero(iter, dio, pos - pad, pad);
  	}
@@ -429,9 +430,9 @@ static loff_t iomap_dio_bio_iter(const struct 
iomap_iter *iter,
  	if (need_zeroout ||
  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode))) {
  		/* zero out from the end of the write to the end of the block */
-		pad = pos & (fs_block_size - 1);
+		pad = pos & (io_block_size - 1);
  		if (pad)
-			iomap_dio_zero(iter, dio, pos, fs_block_size - pad);
+			iomap_dio_zero(iter, dio, pos, io_block_size - pad);
  	}
  out:
  	/* Undo iter limitation to current extent */
diff --git a/fs/xfs/xfs_iomap.c b/fs/xfs/xfs_iomap.c
index 378342673925..ecb4cae88248 100644
--- a/fs/xfs/xfs_iomap.c
+++ b/fs/xfs/xfs_iomap.c
@@ -127,6 +127,7 @@ xfs_bmbt_to_iomap(
  	}
  	iomap->offset = XFS_FSB_TO_B(mp, imap->br_startoff);
  	iomap->length = XFS_FSB_TO_B(mp, imap->br_blockcount);
+	iomap->io_block_size = i_blocksize(VFS_I(ip));
  	if (mapping_flags & IOMAP_DAX)
  		iomap->dax_dev = target->bt_daxdev;
  	else
diff --git a/fs/zonefs/file.c b/fs/zonefs/file.c
index 3b103715acc9..bf2cc4bee309 100644
--- a/fs/zonefs/file.c
+++ b/fs/zonefs/file.c
@@ -50,6 +50,7 @@ static int zonefs_read_iomap_begin(struct inode 
*inode, loff_t offset,
  		iomap->addr = (z->z_sector << SECTOR_SHIFT) + iomap->offset;
  		iomap->length = isize - iomap->offset;
  	}
+	iomap->io_block_size = i_blocksize(inode);
  	mutex_unlock(&zi->i_truncate_mutex);

  	trace_zonefs_iomap_begin(inode, iomap);
@@ -99,6 +100,7 @@ static int zonefs_write_iomap_begin(struct inode 
*inode, loff_t offset,
  		iomap->type = IOMAP_MAPPED;
  		iomap->length = isize - iomap->offset;
  	}
+	iomap->io_block_size = i_blocksize(inode);
  	mutex_unlock(&zi->i_truncate_mutex);

  	trace_zonefs_iomap_begin(inode, iomap);
diff --git a/include/linux/iomap.h b/include/linux/iomap.h
index 6fc1c858013d..c6ae6fdcec00 100644
--- a/include/linux/iomap.h
+++ b/include/linux/iomap.h
@@ -103,6 +103,7 @@ struct iomap {
  	void			*private; /* filesystem private */
  	const struct iomap_folio_ops *folio_ops;
  	u64			validity_cookie; /* used with .iomap_valid() */
+	u64			io_block_size; /* sub-FS block zeroing size  */
  };

  static inline sector_t iomap_sector(const struct iomap *iomap, loff_t pos)


---->8----

That's a lot changes... in addition, if rtextsize is to be considered in 
setting io_block_size, what about ext4 bigalloc and other similar features?

> 
> Then, in a separate patch, you can add XFS support for large IO
> block sizes when we have either a large rtextsize or extent size
> hints set.



> 
>> +
>>   	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
>>   	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))


