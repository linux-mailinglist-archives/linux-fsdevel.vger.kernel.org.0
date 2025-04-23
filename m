Return-Path: <linux-fsdevel+bounces-47046-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A9D83A98002
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 09:02:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C98DA17F257
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Apr 2025 07:02:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E366826772A;
	Wed, 23 Apr 2025 07:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WR2Twci/";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="PIIIZrbl"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2281E9917;
	Wed, 23 Apr 2025 07:02:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745391749; cv=fail; b=ZMdQMfo38fXVi0hijigypWu31Pq3ZEXx31JPSz6QbDovgk8o4wwuxjMe/UtsGGQyNgUATndKQfzQaoNjqSh0W6db3H34RUDTcQ9aQ5gtHOeVV06Pe/jfu9X41M9oBF2iWzkiGNIPqLsWA5wZcyL+v4qzizihL/d3i3ZiTeLmc1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745391749; c=relaxed/simple;
	bh=gZSYzPF/QleI0PjxfU63AQP8Q1bbtkTnOlUX3+3SIB4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DlONmk5tvJtTmoCFI1gwV9/Y8YqBLa4zb+WHlAV/aJNB5bSoNlbHGXjadEacfqXn6w2OyvCmrFuoweK4VIE7xzvJXhBOBhF5tyB6HLafotj0BUMJbKEUfAH2ZfkpGVagAizoB129JC+W7CUzizvCRZZHSZIO+OoVCvo7q3zwApo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WR2Twci/; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=PIIIZrbl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N0uU2P010801;
	Wed, 23 Apr 2025 07:02:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=CTO8rw1kgccsPrRqbUe7cvJDD0o16+S+Yr9WAzCNIC4=; b=
	WR2Twci/b9L0qvUMWQJ/3b+5LUOn/SXqBxncFujzVg/kSwJQZgLTXr+b00pfbbFz
	P2LYev1c91T6uZp6qvFaV77JQAZQQCr7JD9ZvoiQ+dWkKVmQEDl7or693oRuE36W
	AG+VXDd/2eCFwP8rmylBKrmkeaMHyLVMfWmGehhtRT5VVaoefKcz1AHQ5vJVVCCL
	C0vvqM3CS7wky5lkvaBN7C+bDvx1IwS0nlBZQS4Si/Y9Iz5PK2fmFTyGIfEFGRvp
	wd/JsYfN4+xw/QjMzazKDC7MmnM1G/J6eck0XfamJ+Aw7kkadBXaUSMesIeUSJ4e
	KRi5j8P1zwje4TzNGQduEw==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 466jha0kmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:02:08 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 53N5WeBB028465;
	Wed, 23 Apr 2025 07:02:07 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azlp17010006.outbound.protection.outlook.com [40.93.10.6])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 466jx5pmg5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 23 Apr 2025 07:02:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s4KKKFGlMeoSLABwdcWJFIpuzsTm8KX34AvVDwOZenJqtnS4FXjAcZGKe9zxOQYwizX4HhNfEVKwSl2kd1hn67H28SfCSt5cRt4q5GJtFYJCSoZ9+U5/npbOqLmXJ/e+msyjvlyd2LNo+X9r7P0Xzsva0D89zBwBQ1a2SnU2cuOlp+oFNCV6I7a/yuRL1+1i7HfMSe6hHYZSMjvQHYXmtW3Y7tAR+oRGolVodXeGCG4PThf4MEES6RTaxs6n56I2i9mSeb/M+ClgVnZ1BtyQY0GoTiU07nDo96e1bGXy9SSH7oshTsyw8FDLKAHH//ctt1a6DAZK5jexdRPm/O4/Jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CTO8rw1kgccsPrRqbUe7cvJDD0o16+S+Yr9WAzCNIC4=;
 b=vkLzn9dNnOowKfuEfQhtoYMYcSHLLQ1HfveOi7f2lO4jmiKy5SVu2O+wUlumlxfB2zUedXCPweE/3kQlzpdStv9R90SmmETm7xsO7tp8YppLD+FAVvnvG2YDZBBdRlnxbvaULZKweSPwgb2Y8xUCOlp7hRmp6PUvh5WwRTNnAjMfTEZ9I6z/ScIfY9E+FoKBBUwobCD1nCso/JhuL63d1dC5VmSdAJFeoZwYNAejdQ7Mml3BagACw+sEFDPeE2C/ssfZQ9pWu7hNI4sP7/YI3a9MUp2iXqAMH9RODacn+nLPvmqmHtvcqroAC6XW1X0pWOt2mOsNZzLgiPM7ZUzgYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CTO8rw1kgccsPrRqbUe7cvJDD0o16+S+Yr9WAzCNIC4=;
 b=PIIIZrblApNQ2pEvBY15jrmI+Ap7BiI6hL3RTK3EAtlJyvSupgmgMJxiADrSB3zjTGDT/AhM8bbQ5U4IueMrY7qffiEn+8mD7TzZzW/KGi4GrhHk+SVo73mdu0AviTL+n4v8s6xC6RLVyMLaGjvzoscxfarP8T5dSEatXn1J3Mo=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7761.namprd10.prod.outlook.com (2603:10b6:610:1bc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 07:02:04 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8655.033; Wed, 23 Apr 2025
 07:02:04 +0000
Message-ID: <94141f35-5293-44dc-8b98-12a0d27fdcd7@oracle.com>
Date: Wed, 23 Apr 2025 08:02:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 11/14] xfs: add xfs_file_dio_write_atomic()
To: Christoph Hellwig <hch@lst.de>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>, brauner@kernel.org,
        djwong@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        cem@kernel.org, linux-fsdevel@vger.kernel.org, dchinner@redhat.com,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com, linux-ext4@vger.kernel.org,
        linux-block@vger.kernel.org, catherine.hoang@oracle.com,
        linux-api@vger.kernel.org, Pankaj Raghav <p.raghav@samsung.com>,
        Daniel Gomez <da.gomez@samsung.com>
References: <20250415121425.4146847-1-john.g.garry@oracle.com>
 <20250415121425.4146847-12-john.g.garry@oracle.com>
 <aAa2HMvKcIGdbJlF@bombadil.infradead.org>
 <69302bf1-78b4-4b95-8e9b-df56dd1091c0@oracle.com>
 <20250423054420.GB23087@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250423054420.GB23087@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB6PR0301CA0086.eurprd03.prod.outlook.com
 (2603:10a6:6:30::33) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7761:EE_
X-MS-Office365-Filtering-Correlation-Id: 07b3c8b9-8da1-4a2e-efc3-08dd8234c0e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K2hPdzRWa3lqRXRSTkh4NWpuQ051Y3BZMW4rMDNTN1l0L0Z6bGZIeDVUTjkz?=
 =?utf-8?B?WjRXcEQyZVBUTHhERnRyMnZZOUdmU1BwSElXQkNQQnJFeHdFaThwMjJlM1dT?=
 =?utf-8?B?RHJ2QTFzMVNmamlMbnJyekZmTlczWlNQU2lpZ25tZDRSa0IzOHZLUjdXaVBY?=
 =?utf-8?B?bGl1NHR4MzJOd2FVOW11TDMvYXp4UXNFTFRjTFVhZTNmQjZLUlp2cE84WkhL?=
 =?utf-8?B?OTZ3RGpaeWtRWDBBQVY3d2VNVFpFbGN2M2NOSjZTc08ySksvUndxTFl2ekZl?=
 =?utf-8?B?TFltZlFMdVRXNFdHQklxV3JYWTA3cWZlTnFRNyttMTNOMGphU01BZjVscWVK?=
 =?utf-8?B?b2VDdWhSRmJOellBZ01uOTFPRFBpNjYvY2hkYUEzaHAzZWZZZzlyU0YyVzEw?=
 =?utf-8?B?UTEwQjduVXFKU29vVkR0L1lXbzd5V0pVTTBBellGT0hLeFRKQUZYd2k4MjM0?=
 =?utf-8?B?NWY0WnN6NFlUdFZSTlZFQ0VPYkJoMERkbFY2NmxLbWluYzFpK1FJUTRuRlNY?=
 =?utf-8?B?bXhTZC9oMUk3TTg3MWg1Z0RYNkRUdVB4cmxJOElBNlYvTDQ1U09BbWtCOVpY?=
 =?utf-8?B?ZEhveHl4aVpQRUMwVnN4ZVd1UCtKOVoyR3JIaENSQmRpSmpJYUtESy9tU0Z5?=
 =?utf-8?B?eTdOLzJhS3VKZE96Wk9rd3A0SWNvdXphWjNuQTg2Um8zeXYrWTZueFprckV6?=
 =?utf-8?B?ZVcxTGphcEVNNFVUdXpiMUoxaWNPTDhRZ3UvME5DdlJaWFdnQjVqMHZwb1VF?=
 =?utf-8?B?aVBsb1Y2Qldpdi9uYVUvMkhBdUMwc0FQSDFraCtKMTlwSlQ1bVY4R3N2MFlY?=
 =?utf-8?B?M2J0cnlyZ0xHU3UrVGVIMUpLdW9Sbkx1M2dkK3luRkxtOVQxczNkeTY3QXhP?=
 =?utf-8?B?M1hYUms0aG8zL3FsT2xlR3FRYzJsOFVCdXI2UnR2V29sbnRUT28vUkpwM0Va?=
 =?utf-8?B?am1WMUpTK1M1ZFNlSnduYnlCUmI2WUJzQ2xNQVVRbW1SaUo3c05jK0F6UXJN?=
 =?utf-8?B?bEVVdlBoeHBYejJxakVETVkrRUVBTEZjMHBRYy9rc3pweE9iREdQSHdXRTF3?=
 =?utf-8?B?WUh1VEpvdWpjbjF3V05CcnFXV2FUOTUwbmkxUittWXljUXgrWkZxVkgzMGp3?=
 =?utf-8?B?a2Nwd3VvU2l3MFYwWTVtZDUweFBmK0N2TTM2WFBPendpbE5pbWo1Q1p0QkNY?=
 =?utf-8?B?N0NDL2tIRWY1dDJMUFFYL0ZpUkFkZ2Z4eDYwMmdyK1RxM3UvM2VFN1NacE9W?=
 =?utf-8?B?RVRzNml5RHorOGJ3WndCOUV1cHlsL1dacWt0eUlsdE1JRDltWkRsejlQQys2?=
 =?utf-8?B?Qmt3aXNGNG9JNmlydTl6ekZrYnZuYzJsdUN3MWRtMkVsQVpQSHhCUEt2YlJI?=
 =?utf-8?B?NkI2SXZtbjkraUU2SjlsUzBMdk14OFJoU3dobkZrT09KblFXRmpDU3BtZmRp?=
 =?utf-8?B?RUxteFNuTmRMT2MyNmxjUDlyQ2NHcnhpTzJ4R0lreXhpeWZyZ2ZHS1FtY3hl?=
 =?utf-8?B?b2E0cHp2TnBCZ0Z6TXl1bVNMYTU0Q0ZHeGJOQUlraldPVXk1Uk1GdXhKZFBZ?=
 =?utf-8?B?Z2N4M2dHSDVsOXBicTNvTHFiSlVVaklsQUhiNy8rQWttNHJFVWVXWERJNjAw?=
 =?utf-8?B?SWNFU1dVdTVsdEh1R0tNNE5EUkJFNWlQRndBb0hEYmVqYTNMSFl2REgrVGN6?=
 =?utf-8?B?MU5iZWVpVnh4d1l5V1NSLzRQa21Cd01EWk1xc083aGgwT2RMS09WTitHQjBR?=
 =?utf-8?B?ZTF5dnFYQWtLWGhTOTJVd1FwZ0U2akF0cisyaXVoWjgxMmFDcklEZUNPQStQ?=
 =?utf-8?B?ZUZRb3Nic2FuY3FtVkFGSFduLzZhcHkyZGZmSUxXb1F6V2RtRHVoWXBhUURP?=
 =?utf-8?B?ZW5CQmZKdjU3SCtQOGRzVHJvQ0NOem96RWsyU1ZjTXlhV0dwRFRvRWovam9L?=
 =?utf-8?Q?239BVoPmzJ4=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?anJKaFpYQ0dWK1lQMDArT3lnSlVHZndwM2RMYTBXZlJmVUtPL0FnTTRac2Nz?=
 =?utf-8?B?KzlOUVNvYmhzK2JKRjVldXVFU2hZSnhGNHBvTHY3S0toQTZtaXU3Mk1hZkNX?=
 =?utf-8?B?dW8xb21CRkFVT2dDdWJPb1dWQTdkRnlnWEJqNThLclRtTjMvTzdCV2xjZVpY?=
 =?utf-8?B?d2xCRmZKQ3pyRFlTQVFrcGl1RjkzOFlLSnpxanVrZEZqSlNHSXlJQWJLNzdh?=
 =?utf-8?B?ckczWndSVjRFUW5lSm5wWE9NR2FSZUR1RFdIUWlleTdCb29pVDhKUXJsYVVW?=
 =?utf-8?B?c2JOdUpaMTZNVDJOUUZzUDVnaWhYSTlsVW04bkpwajlYMzB6SmhiRjdnenRC?=
 =?utf-8?B?OFc3eTZMZ1EyZ2xSNGViRW1Fa01sbWZWL09TYnVpSjVQZEt6N1hDZkFQbjhC?=
 =?utf-8?B?ZGQ0bVJlTnhaMUwrZzVvS0M3WWJsQlNkQzNPb2dnZ3U1Sk4zUDlrS05NemtH?=
 =?utf-8?B?bkJwbndOZWFCOS9mSWFSdHc1WVBnVG5zazN2ZG92T1FxZnV5RTBVWHdVRlNB?=
 =?utf-8?B?NHViWjQyQmhyMmtyYTIwWEY3aHZwbzZmckplNStiYVovL3pyMlJZVk5DMWJs?=
 =?utf-8?B?cnR2aEhqdzlIaklYOU1iMHVyMG1MUEJ5T0oydm90UGN5S0g1cnQ1cG90Yy9s?=
 =?utf-8?B?RDF1bCt3cXpuUDBMOUM4dTlKdWk0b2FsWlRGS1ErMmRNektLelRiT2NDSis2?=
 =?utf-8?B?UTdPZUFLY0Y1NWMvK3g1VHZVdVFCM2RtbGZzbXlSZnhxZ3gyeEMvNkdEOXpR?=
 =?utf-8?B?OE85RmdCQmNGWHFMTlhnZEUvNHJBTDJBVHJKNEtMdzVmV2pZSUxkV2wxeVN3?=
 =?utf-8?B?NE1Ed050OVladDBZV2Vic2VzTXJBK2FUNEtiNGN2VVVVM2lGODJiMC9DNWY3?=
 =?utf-8?B?TmZpQjBDcXhBRUJOanM1OXNaQTBacUdUdHpYSmxxOEdYVDFVMGNSalNDRmRD?=
 =?utf-8?B?dzBFdHhsL3VuUVVDL0FBWXhGeU51R1NKL3Z0Ukxmd2NWR0RQVFM3TWZnSFNQ?=
 =?utf-8?B?WjNFVjJvMzd3Y2Z5aXF6QjlvNlRnK0tWUmJOWTNTNXNZc20rQ1prY3dwNFdM?=
 =?utf-8?B?RE1SeDl3VE1iR0lGSm1HbHVHb0dDN1N4VDFtQVpNQU5oN2VCS0ZHckRXd3JZ?=
 =?utf-8?B?dDdlK0ZUaDZaTnMzaUt1VkVPZ2hqWkgyWkxsNmgrdnBVYis4SkR0b0k1Wi9H?=
 =?utf-8?B?R0lUTitVQ1pHMWJCQm1aM1VpUW5WWlQ0RkptSmRsYk1BOHhxY2hyaHo5U2Nv?=
 =?utf-8?B?d3E3UDNkeFhFQ3hkU3JhU3VRRUg3dWkrMElFUkdneU4xSmhEeGZvSGpIQS9P?=
 =?utf-8?B?WDg4YjRRSXdSazZ3S01PSHZJNDN5RzdXRzVodVFSOFR6NlZSUGpFY1h0amNz?=
 =?utf-8?B?Q1hOdU1ycVp2NTQwQmtGcHU1YlFRb0c1U3VrNm4wd3dwd2loLzdrUVJkWEdD?=
 =?utf-8?B?NnFvd3kxVm5taDFPSEo3aEEyb3lyWVJVS1lNVUZ4dHlzKzFSUmRvdjZ0OUwr?=
 =?utf-8?B?M1piTFo2d01oTENFVnJXZGM2bkNISjRmY3J5WDNvWFVjcWMyUDVNODJ1UUV6?=
 =?utf-8?B?VDdJRWdhZnZ0UDJ4b2MrbmlMTXo0RlFoT2RXbnd2YVo2UEtmRzF2d2xNaUEv?=
 =?utf-8?B?czVZc2RZNnZhWU5iT1NZNlRvMFBuSTJYQWZnY3VZMWdJS2YvTzNaUGRTakY4?=
 =?utf-8?B?czB4dGJLbXZWY0IyM2ZjQjFwbitCRnAxMEdTUTFaUzI1OFhqNFJiN2lHaHU4?=
 =?utf-8?B?QWdFd1JuMm5lSU1VcTJLNjdxVXVGbGM5QzEyeFBBa0V1RDJTQUNSR3Y1dlhS?=
 =?utf-8?B?cXJ0Nkx4UlZBRVdIQzF0U1BFc2tFL2dJUUFOOXpFR0N5VWZlLzJId3JEOWsx?=
 =?utf-8?B?QklYYm02dEFtT3JRZi91RUJpVzhwRmdvRlBCc2x0RzNYaXRCZGVzakdQSmhB?=
 =?utf-8?B?RmUxSjd2d2haYzJjVkU4RVJvWGVuck1lM1VPRWxVOWJzb1pqZmZqMUVydWp5?=
 =?utf-8?B?Uk1iVWE2R0hFSTR6cEt3QkFrTFdZczU3MSttZXJETEZ3WUlhN3NsV2dIN3Ix?=
 =?utf-8?B?Ni9oeXE2U3F3VS91eXVSWDRnU2VtbmNxb0pud3p5enhaa1IrdVFYdTJINE03?=
 =?utf-8?B?eE9kM2pJZ2l1eVZQVHhxU0NDSXJTUlg3RW9sd3N3Sm9GM3pETlNrSkN6S1VF?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D/sWwXgdtcsX2Lzzlro0iFnc3BPj9+hvt4itJaBlflOIMUy6SHgw53u3J8Pt3OOWewwnfMmZq9ejMLz9i891RkPJvPIa6iBD9c/JG+kHkRnbPCgG9uxejPQ2Tk0W/nm8gZzzo90RyPafBMYAsRrEoTrhJQwWYLg8yJNFG25MyslISnrEJ3TsFGypta9Ka7Z8VUX++3ME9ByNkl6KywUer1WWWYnZIKaNFqEhJrHTQD0uNHiiUrEIOFrZZBcOlFp1YY5O9WW24I+NcwhCnTgyVmQ6HMj4qRKX//pr2f08URxKyedAGSV49CSUlhumi78SZIxU5gvd3GSafKCLo15OvyOGojrjXwt5jUtYAgBxwshgW0Vt+FuSLe1MbmooBjMR7lLjtZqt1CnNY9xo1GFDWhA5NXjCbu988khn3T8jUP7rKN5hRMXJYFvqUrGeqV48ZXMTpfcoRLqOI7zQVvxjwr//V1EKweavesJnqvOO16mbnc7ygfHeVWQeYqQjBGAFPxe0O8bjfhfIawotI+4bVX1nEfu6jet7huhes2xUunwgh1RXzNujGUGLKyDpyZkdTnBRuykWs4s/tZjvYFV+m+OS6gtFKbiQ0KCNPrBF63Q=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07b3c8b9-8da1-4a2e-efc3-08dd8234c0e6
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 07:02:04.4968
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kwmCtRQ3kPnA6LaW9GOSpmHTwyKxs3XIttAJkfJHRcmx11kfa/2IUiqDbWkEj1lBESSJsDgIaqmYTD+TqsXlow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7761
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_05,2025-04-22_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0 phishscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2504070000
 definitions=main-2504230045
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNDIzMDA0NiBTYWx0ZWRfX/lSX6fElLFE5 KaNVBQ3hvQghkaGs+DtdHYRo7xfwtfMdOHXpm/6wkYuk+QzpXF1kQfLl2BejJTifae6C+f7g+2Y xN3ethutv5tgOr8jjV0Vtk10haJwaBNM9l0TQprIby57wbjDr1i01VA9sS+f4K4UMUJo97A/gca
 HLNnZrXADzEfR3xywTwf0AqrNGvYV8/J39XhKUcV++Kd7qeQaBuddSQjcIMBhP/qATd/hSO8D+j Yp0N2JuWTyFMG4YuYU07UvLnTRzcbOwXX7R1HqHlSnxcr5fMUdbClmHJ0i1LkJM/f8Ihmy9fztU eTQX5tcLf9/vczCZ5qctBKBHS5B+gDkPI0IaO63u4s5Hz+EEgnkrLKvNa4YjGfL6W1k6+INIo50 p4JgR57v
X-Proofpoint-GUID: lc62u_nNtlKsWErR6VRVgQteAde5Gx7G
X-Proofpoint-ORIG-GUID: lc62u_nNtlKsWErR6VRVgQteAde5Gx7G

On 23/04/2025 06:44, Christoph Hellwig wrote:
> On Tue, Apr 22, 2025 at 07:08:32AM +0100, John Garry wrote:
>> So consider userspace wants to write something atomically and we fail as a
>> HW-based atomic write is not possible. What is userspace going to do next?
> Exactly.
> 
>> I heard something like "if HW-based atomics are not possible, then
>> something has not been configured properly for the FS" - that something
>> would be extent granularity and alignment, but we don't have a method to
>> ensure this. That is the whole point of having a FS fallback.
> We now have the opt limit, right? 

right

> (I'll review the reposted series
> ASAP, 

ok, cheers

> but for now I'll assume it)  They can just tune their applications
> to it, and trigger on a trace point for the fallback to monitor it.


