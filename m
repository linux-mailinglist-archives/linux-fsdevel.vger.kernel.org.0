Return-Path: <linux-fsdevel+bounces-38646-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 212A3A057A8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 11:09:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6FA1C3A5ECE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2025 10:09:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2DA1F76C2;
	Wed,  8 Jan 2025 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="AFX16b93";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="iOCYlL32"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D47181F76CD;
	Wed,  8 Jan 2025 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736330945; cv=fail; b=AWe1EQBA5SKaDIfQg8z0JzjpMWHJ8q2AzPr/flN3epQk61+8AOosY2ze+kXcN/rIEUgoffir0nU3wSKS0Ig3TEL7q+HvAOT2DF9lxL3B22VGSlkOAzUrVozop4juqh4kF3zHxOC0oVPrK2zCwkaG8no9UCohxl7tfvrM6dfRHGw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736330945; c=relaxed/simple;
	bh=aqEjvCnXUauL+OnctjJxeVGJUNJNVypnaVzcuJBiOD8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=KAKh1ZYnGgVVy1PCzzu/8/Xxf58zbHvbKiRT4jr3Bq43bVTbvdB8jaUBQ/3UQ1Xzgf4cpauP01vk0KkbvJ2nV9KihE5xGE+XVHrf8cqOd/l8gv8X0gMH1EdEnnmcj7xE71BCiUAF5kGYKOU72IfwrQ+t9mF2EC5p4FhrizRjAnI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=AFX16b93; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=iOCYlL32; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5081toZO022312;
	Wed, 8 Jan 2025 10:08:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=i/HLlz82/9i2CAh4h47FfL8b0SGOjJjara2LYdcl9j8=; b=
	AFX16b93QSnuLJxRF5SyM8hOis5xtDZxaNHQRb0pnFffva1Of60VjSkWh2g+OYcJ
	ZGt4hlcfd1mtrTsGVohhrOaCwWd2yF8aNCc3ENJoPEUjXuT/nvVw5JujrpPYKGJG
	fBmOYnMjHpr5ugGqybTCOEG5BXoa8g4ypCnMFnXy0tMsvG/ddTwopFC0J4kRM/bH
	K++zdSUN8TWfJZcr8TeG2S8ZvN5h70CGJdoI9ma0xc7aSpNEMpoOnQF+Oj/NGeLA
	O1MSeg256ZV2HvKCttjVs+5cW0R6T6HANsJCWjGjeXPOEzCcLISjyIBV16SDNz8o
	ZH1AL2cPMZDBINXFPH6K0Q==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 43xudc6pxg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:08:35 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5088ZJQ6011115;
	Wed, 8 Jan 2025 10:08:34 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2177.outbound.protection.outlook.com [104.47.55.177])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 43xue9d35j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 08 Jan 2025 10:08:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WHmSoHDbvG8b/VcDfxKXksyWTtueu3wOCNHMGz2a18mIno9ggqvxIFruw3Af/5sw93gUmuxhMDDG7RCQmPcxavkOz1IVI2HKMCS/TdD3dYG3AErvJn7UMn7ab7wfFgh7gun53/ml8hvSXlHDCstqLhweRHC+NB6LhfZkbiGX0BT00ZW1nxxNSW/kJ9fpLs9v1MuPUIbK3w+QnlzVJOWMnk1ey+9eou15jnB4qdknRn8z249Fs3buoAI7hBsBqV+h36xwHm5vCM5HWCToBI1UUyTzhRXTqOzWkiWg14yJ2GhcAOpe8S2ZuiiRb1GlFkRtRRmvzK0YPue30Xa/6E9QOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i/HLlz82/9i2CAh4h47FfL8b0SGOjJjara2LYdcl9j8=;
 b=YC1hf78+eVSOjx665IJoQ8iBaH7vhT5p3OWPWG3y5yBYDfoCpI0SLwieux4o9W0VGMyyl48bojs9xCa+vj3vo7siUd0ZpBpMDt6hPGdx3jhPws8blgFiivIFZ8HPKglfZCk7IwivD9bDqjE/B/yKY9shOFH08cc/UvZDKuCYaTWKzdcZNLKw3TKfNKnu0gl3pF/PT0jO5D7G6ZnmkqsphCPbJq6Qsg4/YeS3VFCohb5uMRuxg6wRLiDhd2suJAeuO2bcenHE10amFdp/1OAlR9bG5mWU69oshM1dSSgVPJSB7BHv5Kzjt4UUT9JZ9N3a+/qM+63VhOMpQ54UpXg3VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i/HLlz82/9i2CAh4h47FfL8b0SGOjJjara2LYdcl9j8=;
 b=iOCYlL32skE1VQ+2Ylpmqk/dc2OGPrfKQbcU9RDjuvFjSYuPivUJVYXHzL2G8DW/GZQECYMc5K5n75Ic1NvDWVNwsT6qGoFvbluB2VEHUGGUAsKBrunts51jRTmQDyAUo/Q40HGnXawMDUZWBiFbP+PzZkuI4p0KT4DV+COXk7o=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB8128.namprd10.prod.outlook.com (2603:10b6:8:204::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.11; Wed, 8 Jan
 2025 10:08:33 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%4]) with mapi id 15.20.8335.011; Wed, 8 Jan 2025
 10:08:33 +0000
Message-ID: <c428db70-1fa2-431d-83d2-c8d782bc5a80@oracle.com>
Date: Wed, 8 Jan 2025 10:08:28 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5] fs: reformat the statx definition
To: Christoph Hellwig <hch@lst.de>, Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc: Jan Kara <jack@suse.cz>, Chandan Babu R <chandan.babu@oracle.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Hongbo Li <lihongbo22@huawei.com>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        linux-nilfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-xfs@vger.kernel.org
References: <20250108085549.1296733-1-hch@lst.de>
 <20250108085549.1296733-2-hch@lst.de>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250108085549.1296733-2-hch@lst.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4PR10CA0013.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:5dc::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB8128:EE_
X-MS-Office365-Filtering-Correlation-Id: 8127d817-0a88-481c-6fe1-08dd2fcc6882
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M3dpcFF0MWwyNFdBTFhzZ2hVSWdQZ3l3UG81RkdrZ3J3cGdISFYrL2xRYlFs?=
 =?utf-8?B?b3FPc1EraXdzclhDYXdNOG52YzJYK2pyTHNVRnZ2Tlg1MnAvSFZIeko3V0pU?=
 =?utf-8?B?TU0vZFRSdlIwNnFWYnF6bndzRENGbTA3RHlKVnZSNXlDYmlpK2NVaHVwZVBr?=
 =?utf-8?B?bVllZnBuelhoVmhWZ2V5UFk2SE45WFZ4ZEd4VmVFYzhTVTRLc2VZanFnR3Fj?=
 =?utf-8?B?UGQ5WkNwRnJ6UXVzVU5STE5jbG5HSGNpczM3eEVwNVQrYmlUcmhFWEF3Y0tV?=
 =?utf-8?B?U2l0d1ZFeG5xQzFycWZuQSsreGt2dEtkWUJDZ0MrSGdPR2ZTbE1BZlVGUWly?=
 =?utf-8?B?OXF4clVuVGJIeW5pZ3Fwc1pFS25wYmpZZGZoRDBzNzRBckF2V2ZmbzJjMTZm?=
 =?utf-8?B?ZG1QNUYyOG1vR3V5ZXdua2w0NTlvWW9CQ3ZlU1pwbDRnMlBjRUc5b2YvYk9V?=
 =?utf-8?B?ZzNicG1NSWpITXpqRGQ1bFh3OUUzYTZ0eUhxS3NSeWlhUUhWc2wvMW9NaW01?=
 =?utf-8?B?WWJCbDNCT1J6MFNrWUZ3Wmp1YTJzNkhoQkE3M2NNTTVJTUJJVk5zajNyMmNW?=
 =?utf-8?B?ejRnK1laUHVRYk5EZkhmMXRVWEtZTU94MGJpTFZGSWlzK05CQUhXd24xK24y?=
 =?utf-8?B?TlNtMjVuSldyaXBCbWRkMG5NcWRqVThlN1pKN2FmQzlkSWZPTnNmOXkvNGtt?=
 =?utf-8?B?N3A3djRucHllMEV4QW9sTWRPN3dzRHcyQzh5WkIwNjhaWDZRaTlLNFR0U05r?=
 =?utf-8?B?ek82b0pHQm9vZlhaQVNqcThkbjllWjYrc1E1d3UwSkJjdjFXSWdOeEx2R2NN?=
 =?utf-8?B?NUxuVzByTUhXQkZiYnJJZ0d5VCtlVmZNd2RQZGl2a1hlTUwrdU4vZ1QzUFpB?=
 =?utf-8?B?YU1lREszNjRGOXIrVlJSQVNydkdWWDJJcWxUTDBGM2RjV0tFNmdMeW4wMzh6?=
 =?utf-8?B?aVhtYWl1SXJ2eldzcjhOQ0tKTDFuTEt4bnJKNy9MTDhObXR3d1BKYjQ2ZmFx?=
 =?utf-8?B?ckh4QUdNK0RxN1ZiYTdsMzhyUEd3MHhNL3hOWko5V2hMdHZzM3Fybmk0ejBn?=
 =?utf-8?B?a2pRazdScU95VHhtYzdkaFB0aVlXVkpOMFRFaHVNT2hMU0QxUzAvQlVITDdU?=
 =?utf-8?B?NFVWbXU2Zm0xOXJVTW9WYlF5MVpBSEZNbjN4ZVVtUTN1N1I2dnU1Q3JUNXRw?=
 =?utf-8?B?MnpXbnUxUzNXK2lvam5ld0FrNVRDenNUV0VNbTJzL2xQQjdFUkhsOEtuVUNC?=
 =?utf-8?B?SEg4S1RrMXErMGxwWVZQQlBVb1JWU2djbWx3UDQybmMySU1Vc1ZwMXd5Qk9o?=
 =?utf-8?B?UTRZRk13NWJrYkR6Ym9vSkJDQktEeDNJVWlLQUQ0UXljVnZsUnhVS3RkVCtK?=
 =?utf-8?B?ZXlmMTlWejBmWXFaMmREcitwSjRMWThvR3JIc05INERGeklQS2NoSnZIaTZT?=
 =?utf-8?B?NzhEeVcyelcyYVdURGtVenZkNVR5UWlpVzExWmRSZitLTzE3OHZEemV3ZnBT?=
 =?utf-8?B?Wk9RTzJCckZVUm5zSEV6ZzJhUzhxREJLV2FoUjEzVmllMWZGOXVRRzgxOEU4?=
 =?utf-8?B?NG5GVzNYZG9BK2ZwbWIrNzRzSUJIWWpnSnRuU1kxSFN5TWZtYnZ1VUNRbk1T?=
 =?utf-8?B?Z0ZDOEdEWG5GQVhRSHhUMTMyRjYrVUF4NVpnNk5QSlVMSHgwK1d4Qi9GQVo2?=
 =?utf-8?B?VXJpSlZnTVJ6Yldia3dodlBabHJYRGthM3pYWDczamNUQUQ1b3NRZklUTExz?=
 =?utf-8?B?ODc3Lzk3TmNuUjFJWlFvVTI4UGloU1VTeE1BVmYvS2I5ZmVTMkQ3VHRNL3RZ?=
 =?utf-8?B?T1Q3S3F4NVllM2JDYkpYL0FGeldqZGN3M0NiNXNka2NRbGRqZjgydk9ubnJR?=
 =?utf-8?Q?WCE0LrHL3M7gK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bWhVTUx5cENQc2YrOGlrZ283MXlLM1h3V0tYVHk2S2g1bmZiWXZZRnRWbHN1?=
 =?utf-8?B?cVlUcEd4RkExR0NPYjRTMDZWck8zR0NDaTRmaFF1WUNnZE1hZHBKRnN1Rk50?=
 =?utf-8?B?UXJXK2NTOFJzbEs1cFlvdWVUcVB4MkJsbTFVTGM5R0Nrb0xib3FGSnkvSGhi?=
 =?utf-8?B?QlRpVHBvUCttZjNKMmExSXprT25jMEZEY01QVWoyMXBZaHlWQWxkZ2xTMjRu?=
 =?utf-8?B?ZzB4RHdlcE5mRmtxa2ZVRlIrcWdQSlY4R09IU2E0dHQ4MHdVbllra1Z4MHpO?=
 =?utf-8?B?NVhkRlI3dDgrWkExRE0wSlVWUFVEbzNNL0RxSGowalNVUmIwWnAwU1lqZng4?=
 =?utf-8?B?ZGFDSmQxeGlOZG9VM3BvWnM0N1F1SjhiYUpnaC9oSkJweCtsbFUvWFVVRnVt?=
 =?utf-8?B?OFZkWk1IYWtKVFQxUk14S1NURWFPRlZzRVNQOEVSblJVYi9nQlFodHQvYTM0?=
 =?utf-8?B?RERVclhBdGlJZ1JzK1R3eWFZUXJtcm1kME02ZVh0UnJCVmE1KzE2ZVBhOWFW?=
 =?utf-8?B?MW1iVXJ1aGhubytpVXo2cE41QWIraklXMmdZbzFvN2ErVlBoOVNKYWN5WEta?=
 =?utf-8?B?Uk5KY3hLWE1iLzVIWWhJdEltVm5Bb1FZY1liQnk4REU1TmNwRzhUZXdPa3Jr?=
 =?utf-8?B?dTNFU3ptVU1qamM2MFdwVWdBZW9NOGFRWmwxVWszRG4wUitCKzZzdlcyVFFt?=
 =?utf-8?B?RXB5Q3E5M1ZRTGxBdEJWdXhHRUhFRFdVMjlMMnJpUTR2aE4xTWJKMWN6cXdj?=
 =?utf-8?B?OTF3UjYyRkRvd2lneW1LWlVra3pTTnc3bGZVeEF0TzhxMXN1cTVpb01vbjJz?=
 =?utf-8?B?eGM5bWxUNnBPbUp1R3NFU2ZLRkNMUHIxbmx1KzlyODRWdnQrVm55ZXJnSHFn?=
 =?utf-8?B?YUcvRTd0eFB5N0ZUcWxtUTA5YnZxaFVOQUZUWm9YN2xlZWV4UUlCc1YyRE1M?=
 =?utf-8?B?NmY4anMrcUIrK0pPL0c5MXpNYnB1bngreERjU3c2TGsxaVZZTmNKZ1FwSUFM?=
 =?utf-8?B?T1pFVGJpamdrQmNMbnh6WElKRWRzSVpBa1FLN0tBNDlKTEZQcFNReHF2bC9k?=
 =?utf-8?B?VUlwd08ydHgwQXh4a1FUWFRIaWxpc2ltano4RHFYNmp5NlAyOXc3ZGM4OUJY?=
 =?utf-8?B?Y0EyMUIwTFNKY0kxQ3oxZ2k4V2oxN09yVkZ1Y3ZORjJacHc0RjJWNEVkM2Qy?=
 =?utf-8?B?V0t0VGhqeFpRWFFRTktWYnJveFZQN2t6K0lTeExSSmQrY3lUSjY4M1NZZ0RH?=
 =?utf-8?B?NExDTVl4VVgrTzRKWjF0OXAvcFU4eUtLVC9mWWRtUjZQUzRmZkN2TjVvdEQ0?=
 =?utf-8?B?VmI0MnRGTGJBaE1GR25ZT2VVRFppaHY5aVpUWk53YTdZZEtYaEdUYk1tMzNm?=
 =?utf-8?B?T3g1dDB2MktYa2t1VEVwUkhJY0dERGhzODg4Ty9wUUF3cGVKYmw2aUVJRGR0?=
 =?utf-8?B?VFgwb085Q0hYeFdDbzhORUNJdWtuOHIvTzl1WEx0SmJvdWtTM0JwaVMxK0dV?=
 =?utf-8?B?TDY2dUV1TXlhZ3pwaml2MW9BRG8wMy9rSzZxbGhnVWo3OVV3bnpFZGNVeXpi?=
 =?utf-8?B?MnJFMTdpdGdMcU5YbHBjRjFHRzlIVC9LMjlESGNMSTJxa0Rwd2oxYXBla1lh?=
 =?utf-8?B?RkI1bFAvZXI0OW5kOW80ejlFV0tuV0tvMHUxQmNWZlBuRmNkUDhFRkdFQ0Vp?=
 =?utf-8?B?UC9ZellOQVhsMzhMaFdVVURkNjNlZ01xb3NDWDdReEYwdm45K2FqQUFWbEtF?=
 =?utf-8?B?c0xRaEw0cHVLK2FZa1BCUHNJQXVvYlhuSXVES3p0RXplR1Z0ajdYZW5CRU1j?=
 =?utf-8?B?d0hQK2lKUjBrY1JDQU8zRWQrUStxVjRFQWg3MXJ0Y1AyR0VYM0dzWVJ5YStG?=
 =?utf-8?B?ckdrOW5PcDdWYklMc3FKK3FOd3RwdHFYSTBHV2F1bVI4bTRHWHZWVW5TaHBP?=
 =?utf-8?B?eFp3aXB0dlVKUGpxN0llRC9JcTVrK3U5bVFaWmlzbHZFK3E1Nm10V1Y0VWNx?=
 =?utf-8?B?SVdUWmVVTjhQbXh5NzdoSEl0dWZ4Y2tBcktpVVZyUStLaytmNzhwb1VpNGM3?=
 =?utf-8?B?UFRvbVI1Q1NsN0dPNTg3RkFmK0Z0RzBJM2N4WnpIZjM1cEFxYzRzME5rZjFU?=
 =?utf-8?B?NlBXZ2MxeU12NzhNRGQxUllCbm13VGpKNlRPWFNJOUdjazBhMjN0Z3hhaVVN?=
 =?utf-8?B?NUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	KThAI1CyNQAf7cLDksz3Tro6kZMgstQpJ577yELSdQqlg8Q0bFVSVx3bnQGH67LNQL2eAV+YWyiPqgrCob/DbtF/r8gEM7QAYeYAA6EKTJAqc17RFKLnQVYSs53OKkJcaOWbyoxqZadwPsrVk9QpXS5MciMtC79bWZBOWzUHUXkgyHF1bnVwhwTUJgEIHkFvDSdtx5+u01PPyr9d9yyyX1WUbmxR9HG8YmF1PX4LMIuG663iu08qJB0EMhXLsCbTmLWeFS61QB5H5/QNgguYbETerTmIXNySg+zY2C+j7furg6oJw+oN046dgqvF1QNBLripvchLaR/jz3Ncs/lzlu5oBnyog/QJOyF56mr1tVYZjNCefwV0sWhJJcd9LpSQ94s3G3O9WjV2gbgCPcfYIRU4ZQffXmOberSmtfxhRz/ciSfdMJQLJKygby9yJTt0BKa7ZbU2pUhBAZVAWbXi0MoDv4R14/5vmVoBY73H11FZYIGWEFU5bLvPzVW6IFRMhfw+M8QhPLW1EyURZ58youqmZxtUcIijnOdaxZqeyoZrsXrbbDH0LVswJXkTfPhlfURCRjrgmUkobV1FcEsbFEGJt5f8J0fXzDCCklTVtio=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8127d817-0a88-481c-6fe1-08dd2fcc6882
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jan 2025 10:08:33.0663
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4AN01cpG5rxBjz4QuljS18AwaG6Jv92xZCsPa68/QUselljLBK463qggBgo94SfCMTn3wi4uAwaoXtU8qnTyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB8128
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-08_01,2025-01-06_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxscore=0 phishscore=0 suspectscore=0 mlxlogscore=986 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501080083
X-Proofpoint-ORIG-GUID: ncSLK-dxRVlSCQNR2rwv3pF9KO186jKv
X-Proofpoint-GUID: ncSLK-dxRVlSCQNR2rwv3pF9KO186jKv

On 08/01/2025 08:55, Christoph Hellwig wrote:
> The comments after the declaration are becoming rather unreadable with
> long enough comments.  Move them into lines of their own.
> 
> Signed-off-by: Christoph Hellwig<hch@lst.de>
> Reviewed-by: Jan Kara<jack@suse.cz>
> Reviewed-by: Darrick J. Wong<djwong@kernel.org>
> ---

FWIW:
Reviewed-by: John Garry <john.g.garry@oracle.com>

