Return-Path: <linux-fsdevel+bounces-58609-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 347CDB2F97C
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 15:08:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 999911CE774D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Aug 2025 13:01:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C29173218B6;
	Thu, 21 Aug 2025 13:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="obVhl8eO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="if8l+4dR"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BAC319844;
	Thu, 21 Aug 2025 13:00:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755781257; cv=fail; b=YEPm1xJJr8++NaCSj4p11SrQwW9kgGX12f9S2i5SGYGcpYGUklJC39uM4AACimNlNAQcrongaSjg0OhAb9tfBroYyllO0Ez1H8rDuRBVj+UiDcPd4rwDtiUqb669pkh4jbQRP46mpGMHrdl7+BbE488qZBM6MQdNAtdh3waRHvs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755781257; c=relaxed/simple;
	bh=SGlMDrHgjq/WHSuPsUQvJU/+2Le/Ptst6c6PGRdixYc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ona/BAQLfsuDftF7SUa5OVECopN04t9abiB85r38hdEMS66hPVPsG/2t+czog9oU3uTCeo718cA0rkjPA4hFS7cczeM0b315II5evhUKmjKUpSnrZLtfBMkupbYHO/AWV+rMS8uKiShdBRpOT3MpRXrm/FOUIdGihqIIKXVUicU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=obVhl8eO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=if8l+4dR; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57LCY08N029883;
	Thu, 21 Aug 2025 12:55:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=BzhNtTetT9Q1eHBRAVj4uxd0hWBN3dsNVlHhi5fWExQ=; b=
	obVhl8eOQO0r+IAGjnb92kbccxa4de/UOGPTlHtA+pMK07JJMR7bmIBzahr7L88l
	ddgmKPhde23BqoVAY8x1h4RB8sJDDKw6JTEy6UmJsGXY/myAhwo0/C7WBiOgJVRf
	jSTINe2VINrrJROQR7xzz6dloosvPY5WKleHqe4M8LaonDUAt5jaKNKywep940tu
	iUMw3PdrBH352dbh6OvYurAGkwPsHu27D6NDJB7Mx5b9szQ+/jN82wjQU02knPX0
	5jQa36iqfwqUAKA/Tgas4qcaAASXjBae4gJFpkKVMRtHkm5jpZODJpijTxS8mo0g
	Xy24IapQYpVXhvJ1aa+KQg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48n0tsubgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:55:20 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57LC4a6u025499;
	Thu, 21 Aug 2025 12:55:19 GMT
Received: from sa9pr02cu001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48my42k1b7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Aug 2025 12:55:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cfGrW0kEvDafmOljLATIhFn2JUQREj4tK5rjpoiGai4NMqZh9g7rDRBFIKCi0vkg+fxx1zBYZNfB/yycrJ4/4+HwaY8JcLBzwzVVf6rXuoulkKAIINz8OcVAH/j2l4THnPcQQ3+7r02gApwu68zK1hFFiuCZ+BjDhYzEIOqpS3EEH/SYrmbh3IZMYKswjE3bn0a1kpRrsxtD4kslwwsyn9XLos3rSI8f4hvKLfFXodDT85BaUYX9htIG6Nmh9ZHjWZnUdylSGnT86pvBIohG0tt5uTphiigdDc69rnEGPGfyduSulSO/1XgaevIGC39nfWJExw/2Nslzj4EhNDsM1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BzhNtTetT9Q1eHBRAVj4uxd0hWBN3dsNVlHhi5fWExQ=;
 b=acKucxT/tID6ImFQwAHlNwzvkuBCllnv2B/PywDcUIIRJyO3OQaDmfD95oNsdAspihQIJAADt+mjR7zarWYFFsSi7vAxWdeMGJWhu8TTTD0BGHeiP1oBqvSPhgkRnVIS9s843PIW5EAE/Didezu0yyy1ajkOLrzfz7vB9VnR/2Rypi0KBPGfQF4PnExYJ7FULQ9CJJA4UUMWeyoTgFwF8vJM0XqCIin9Xz5g3X4E/m5xTO/+JEClZuDdePyKQe3n7DK8sYVp0SI8Bgy1vWcsfdRxMXc/pnq3ng4c+nWP5LBPXFEKyefDIU0NEo0ciJvbwjecl2btEBwj01njtahIuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BzhNtTetT9Q1eHBRAVj4uxd0hWBN3dsNVlHhi5fWExQ=;
 b=if8l+4dRstWuh1An10qh9iWfxfElCn66OFvTGbXN0L5dlz+O3E4/vN+FCx+i5G5XeJK97TJ9D87ifheCrF7dQ1UgjVBDnIFVvTfXWPBajVfgPlj0wT4FqnWLgYd8QRDxHa21is2EtCsl6lEsFjAW8YP5XLLhZ5S9yhTn+ja0zvU=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CO1PR10MB4657.namprd10.prod.outlook.com (2603:10b6:303:96::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.14; Thu, 21 Aug
 2025 12:55:17 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9052.013; Thu, 21 Aug 2025
 12:55:16 +0000
Message-ID: <803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com>
Date: Thu, 21 Aug 2025 13:55:10 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/9] block: introduce
 max_{hw|user}_wzeroes_unmap_sectors to queue limits
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org,
        dm-devel@lists.linux.dev, linux-nvme@lists.infradead.org,
        linux-scsi@vger.kernel.org
Cc: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        tytso@mit.edu, djwong@kernel.org, bmarzins@redhat.com,
        chaitanyak@nvidia.com, shinichiro.kawasaki@wdc.com, brauner@kernel.org,
        martin.petersen@oracle.com, yi.zhang@huawei.com,
        chengzhihao1@huawei.com, yukuai3@huawei.com, yangerkun@huawei.com
References: <20250619111806.3546162-1-yi.zhang@huaweicloud.com>
 <20250619111806.3546162-2-yi.zhang@huaweicloud.com>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20250619111806.3546162-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0349.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:18d::12) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CO1PR10MB4657:EE_
X-MS-Office365-Filtering-Correlation-Id: c75a4952-cc4a-42e9-2fbd-08dde0b1f988
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?L2dRVmkxdzJ5ZWVtOEduaWRjSjhUUXR6OWJ6c2MxZWkwQ3QvR01qbFZyNGY2?=
 =?utf-8?B?ZDQ1WnVER3lVZGRTSHVuVWh3L2tMbllsYmk1UXRuRmZCbkdmRnVra0RiRkl1?=
 =?utf-8?B?WkdHeDJJQkMzemJMUGpENVFIRmpYQW1TU0F3NWRBQTZSK2pBNXhpRCtGYmI5?=
 =?utf-8?B?L2dxdUoxMDRnVnpqSjkraWpWcjRYTzZteWJXOUdvQWg1YkVMNWlUNGcyU0hi?=
 =?utf-8?B?U1d2QTJyTERsNTYzTkNCNkF4UWFxcU9rY1ZaVGJXYXBUb2N6cWNXUE4rZ21y?=
 =?utf-8?B?R0xNRHF4OXBpRlFTNFMrKzA4VG9PanZKS2VsbDF5c1loNDlKRHhZZDdIT1Ja?=
 =?utf-8?B?WnQ0OUkzUG1NNXRoUjN4dEFHMnB5WEthazhoeWhLMjVvcjA1eHUxNW1PVmNL?=
 =?utf-8?B?TjJEY1dJN1czdFYvOUp1ejdiajNheGE2b1V2KzhadjduQlF2dFJLVGRjVWho?=
 =?utf-8?B?TnVJL2xyTVlzS3lUR09YMEZ4Q1YxY3YrRUVLTEM1dTV5VDFCdmZWazV5MVAz?=
 =?utf-8?B?NWp5OC9MWitDY3lOcm9aVkp1VWU1eEx0RWhId01SNER2blpZclRwUWVsT3JY?=
 =?utf-8?B?ZS9zQXF1SjV5dWpzOW15YzE3ZjRaK0NmdlQxUTdoaXlhbHRUbURYeUx2cDlm?=
 =?utf-8?B?bXgzZlFrK2R6OUxGMmV2dlBxcE9wUmFjVGJ5ejkzOHg4NUtvMk10VmxXZjVH?=
 =?utf-8?B?OEg5bGg1TnJxUFFCWG5wbkVibWFuTVZuNEp3RVBRMk9XYlI3SmJISFFNSzR4?=
 =?utf-8?B?bm1YUUhWQlM2SThDbGRsQTE0RVhjQ0JxNGFtQlRadmNDaS9HQ2JXRmhLeHNT?=
 =?utf-8?B?NVFSUUYwNnpsNE9QQjdHQ293ZHp3bzM2MGhPM2sxaXJFMTE0ZG1udGc0Wlp0?=
 =?utf-8?B?a2lhbE9CdlVQSFBERGtETFlEK1pzNEhDWHZNMkJZcDNCcUFOb1M2T1F2Z0FC?=
 =?utf-8?B?SEVFd2FrcHRvTlZHSmNpTGtyUGxVdnZxVml0UHE1VHFIblVxZWM2MWxvakh6?=
 =?utf-8?B?L1hNdWxHT0M2b053SWwzczVVbU5wbnRqTThiUjQzQUpwWEtBTnNoeGdxbXVS?=
 =?utf-8?B?eVdGV1hkOGhTUGlSM2h3bi9FdnEzTm1DbjB2aGJubW9uTno5bExlVXdXcURP?=
 =?utf-8?B?L29KYWswTEwvVG5QZlNPbU9nbXY3bEZpMG5yNDVQUFNuYmNjaXNyOE9vejVS?=
 =?utf-8?B?Qnc2SVRZbWVmZ2NGWHdlOXpQM0NiUWowWHFkc2x2cDhNY2JvU09IbHVkYVM1?=
 =?utf-8?B?d2MrME8wY0s2eU9wWkdEVFlWTExXWWtoMVBnaTQ2WWxJcWIyNXhNWTlHcm9B?=
 =?utf-8?B?YW5oR0tHM1JDVC9NYlJaQ3FmVTJuQTE5KzBPOFN3QVo5cTlBSW9qQXZrUGp2?=
 =?utf-8?B?YUpLb05zbTVwdHFXcEw3S3lldkNuVmpCNW8zS29ZL2szVFFIWHlVd1BXSHpw?=
 =?utf-8?B?ZHo3UVZmV3gyblVscklUTXNJV1ZhVEFWVEUyTjJIazFINHZ5eCs0cmg1cHhx?=
 =?utf-8?B?cWMxODVpekRRQ3hITkJnWkprWGRCb05TRkVUaFBDelFrdnMzeGQ1QzFjWGFT?=
 =?utf-8?B?SGl2MVo5czhlZW5iOWRTZStaTzFRZDBxSG11QzNXdGxuZW9LSFU0cHovSjFk?=
 =?utf-8?B?OHVLSDNCYmxCRjFrRTV6RVBXQTVibEhmcFRIT1BIM2ZDRXdUcjlDTm1tc3Rl?=
 =?utf-8?B?R1hYcXJPMkdtdWg0U2tjUytTNXhQYUtjU0xEWlpEZE5ORWllV1pDaDFsUXl4?=
 =?utf-8?B?dSt4R3FNbTdWUlJPTHZlRTFQL2RmTW9qbVFxVkgrT016bGxYUktWV1VGY3RB?=
 =?utf-8?B?blJjdFU2ek1OUDRmOHdCdE5KT1RCcUh6cFgxanN3UTNlVVdKV0JDQlN5b3Z2?=
 =?utf-8?B?OHVWanNidXloZ1pYZkFOVmF3ZnF0aVFncXBzUWJBemRHNEc2cUlmMnBLa0lC?=
 =?utf-8?Q?pXE0fUk6M7I=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?b25Rb3BKK0ZGbTFlNDVlVWlDckd3L1Uwb1MwaTdzSXRTZUJaRXRsbFl5SXlX?=
 =?utf-8?B?OVVKUEdpNUhBc2kxaDRvNFdRc250aVp5SktNWUtyT1FrTGdsVE9xR0ZnYWth?=
 =?utf-8?B?OXJtWFo5bXVMQ1Q5bmFpYnZxMGlMcU1YNlgrakhHbkhvcis5MW1GQ3NKVE82?=
 =?utf-8?B?U2ZSRjRQbVE4WUl6WStwMkFvNUcxM2NKSnBOOEhyNzdVQVVuZFhGc29pYzdj?=
 =?utf-8?B?VnZ1WGViOUdBQ0VJaFIzSVZmQTJUOFprbW8rRlYzQWVVbU54YXZaY0NLVmxw?=
 =?utf-8?B?cFIxeFJadmNjcTVoYWI0S1VSQmY1YU9RYjBSYWpyQ0wrWW1HOEhsektVYW1u?=
 =?utf-8?B?NG9xRW8zY0NFZnFXWGVTWlpwK1hoMXc2L0lCU0VFSnJXMS8vcjlDR0V3a1Fj?=
 =?utf-8?B?UDd1a3JDdXZCckN2YzdvWm9nbEtNYWIyTnRXU2lGZENNZ1BHWEdFUVRrMmVk?=
 =?utf-8?B?M2ZncU5oVjhwanhKNFhkQXJ5VmRacW9Gd1A1TUNINkpoSGFNT1VZbklPU083?=
 =?utf-8?B?dmREUFBBbVlIcnlDYXc0dEhjVVd0dlBjZUdobDVnakltVFBxK1Bvb3NORjRT?=
 =?utf-8?B?bk5WQUUrOGVOZzg1dGdkaVpPMGhDdlZKMytSTEZOa1BFL1VlNWlyY0pidStS?=
 =?utf-8?B?UTRKcmE5YVhPdCtVSW4wQythdzdIU09FOXZkNGd0T3RUdjJzOWRXSC8yZGlF?=
 =?utf-8?B?TWIyZEQwVGM2WEV4MDA4bkVsMTU3WnN6MDFRQUlCa2ZCWDJSN29wTTQwVXNp?=
 =?utf-8?B?Q3dGdmxxZVdlcGI2cXBvVzRzYXIxbzB5RHhFM0Yyci9CZXIwSGx4TDV6ODRq?=
 =?utf-8?B?QTZHVlBSVWlUTElSNEJOUkJ4aGkzcms5OWk2bnJLb1BibElSdlV4ZXRDd3Rq?=
 =?utf-8?B?dmlLTk04UWxWZHJHRDhxNWNFNlQxUENOWUk4NXZrSU5TWTZ5YzFQVkxWRzhn?=
 =?utf-8?B?UU5sZDVnZFMvRHJpVTFjU3gxNkRTVTB6SEluOHMwckJDUS9NOGdlNENaaGlS?=
 =?utf-8?B?cUtHT2JlUlF1bXljeXNRbjhuU2RlaklDODRzUENhMVhrM05wWFh3RlREUjhr?=
 =?utf-8?B?a1BaRU1uenZyWWtFbkd1TU9zTWZMYjdWRUZHczZHWUc4bnBxVEo2ZzdlVTBE?=
 =?utf-8?B?YXdWeUtJSVcwVG1rNkJWbFVwam1kc2RHU2JDVGRTaWxZb0FQRUVZd1o3YU9H?=
 =?utf-8?B?emoyN1hIL0VwN051UkhKMFJrcCtHWTJHbjRQaklIaDVqb29tOHpwRnJTemJC?=
 =?utf-8?B?Zm5lUVFyRnUvMjdmUVVnTUFhbnlQWE0zTWh3eXloeVNHTzdsazBkMTNaK3g4?=
 =?utf-8?B?N2RSUlRiRlNCRWRjU1Z5emVhbU51RnJVRENadUV6bi9UWWR2N24wamtqU2FS?=
 =?utf-8?B?MHZEQ2pjRGVyY0Jub25ydVdQQTZNOW0xay84amg1d3FXOFpaS0IweFd3d1lH?=
 =?utf-8?B?MDFXVjJzWDJ3b3NIVDEzWnhmRnRrQnVMTnN2cEx6Vm0rbTIyazJXVGgvdDhH?=
 =?utf-8?B?ZHZaWkV5bnNnMWxVZW1sWjl0THZBUmlUTEphbEpsZ3dUakNoT08yNkRiTUJT?=
 =?utf-8?B?eHRlRk8xNDkxZHR1YTMxWWVNRlB6blZQN2M0TXFjTkZLMys2V2I0QlB2emN6?=
 =?utf-8?B?dDRybDdhN1oxSE9JYVBHTlpoNy90aGMxUDdaQmI3cjMvRzdJbExZaUlwTkhY?=
 =?utf-8?B?VHYvQ3huOU9QNzlrZW90ZWp6M1QybnFKWWN3aE0xRTI0b2FNU290OVhvVTRj?=
 =?utf-8?B?N3hEUXB0UGxYZ0ttUS9CQnZ5SWdFc0lERkpPUlhmSVI3ZXg5TSs0YStDc08v?=
 =?utf-8?B?c0NFYUVOZXgrNGNSM3o3UDFSZjZ1aDN4dUdxc2x5bjNWQXF1Ui9FWkZqVXBI?=
 =?utf-8?B?Z2RNdzhpMUhTSFlvWkN6MXpQejRCQ3I4L0dPOEo4UkM4L3ZxSGFEaVh0MTJD?=
 =?utf-8?B?MlRGZUxPN0RGbmVTanAxYXBhdHZoTzlJaUg0Qzg2N21ONmJUUEFVNzZKaXpz?=
 =?utf-8?B?WjFoNzRpYXc3NTcyUDRKdU82T1cwTTdjVzFpZmt4VEFZN0dlYTY4TzZhQkVX?=
 =?utf-8?B?TjNMd3ZKclJURmJiaDczZXk0VElZeDNnZzIvSHVqbi9zR2VDdCs0RkdaTGo4?=
 =?utf-8?B?ZnlDcEhhbjEwenY4ckxWOE1UVS83ajFiVkFEWURlNVVvSmRMMWNoNXltOEh5?=
 =?utf-8?B?MUE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	YdndoAwNLryPtTRZoAVzP+Vbviw/0nbX9J9TeauEK3EEqSIGr5FvgtzJRxjx0mWIVgfLwkCOzcwaB5mQGC+VOuEfC78KKLIyrLcwjKAOTh4YVfddFFouXYhHvrmU/jzDMyfk4VJtolByAPVt0xT5QHAnnZgG03uunMhYiKIcOoC6MgaSBz4CROS8jN9lA5nDz7kuwtsSflgg3gZDnUdZV6OQUbuhpnQsG3YRpn2a0ElEE6YhI3jr7suVimlAQFDTwJqYIf2rT7e7UFZHE2FFSUg6YaQ50s41a02wBOyAPhEeHDlKbshouVy8yMVxmyzT+n2VzAUA0v7GWg/ZVZ2seQHVtdyA2oU5YJUdzO0iXVOnq8TBFJgcN2yoPxhDU9DLRr6IOKk+AwFeI2Kyjf5fDXeU48dtcXt5Bzk1cDt7N95n3Y1fXNa5e3bkobfsSOs+9Vw4LKWRFY8Of+pkPnqRkhBPFqjXaqZpjUDdRUrc52xr30oXErnEeeNjgxyTF0ZRD+A09z7A+25zPoAFQ09TK7gDyXEQLw/WxN0cYIGq3z6cksY3hsXS4nubKHTR1rPDL4QcaoBZcd8Yned18a+G9MlLethX72yt2y9NUxxaLy4=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c75a4952-cc4a-42e9-2fbd-08dde0b1f988
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2025 12:55:16.8161
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IFm6xQz5CFgJby2OsfoWXDq73FPnWk4v/C7caZkhOWDWlzODbBLE4qQ2B5RNkUXxHu1JxPcXTSRyHM6pQH098w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4657
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-21_03,2025-08-20_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 spamscore=0 phishscore=0 mlxscore=0 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2508210103
X-Proofpoint-GUID: VFiQzHPbfivlp498mb37rPIhx3gmVt5G
X-Authority-Analysis: v=2.4 cv=S6eAAIsP c=1 sm=1 tr=0 ts=68a71738 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=2OwXVqhp2XgA:10 a=GoEa3M9JfhUA:10 a=YHE87RsjaXBuAp3V8twA:9
 a=QEXdDO2ut3YA:10 cc=ntf awl=host:12070
X-Proofpoint-ORIG-GUID: VFiQzHPbfivlp498mb37rPIhx3gmVt5G
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODE5MDE5NyBTYWx0ZWRfX2JbB8Gn9tf2c
 7n+7j9XSbB6naNEhTCURPtBg8SOTSH4YevifCyCJSqtWPHGX40aiu+p2sJWmC/FKp6GoC6AFJY1
 8pW3Hue9P33rvUNShS45bDl0zjTxogogQEG9QVTzCF4+H0zySU90fFMB5mmzc9EES4GgsdxjVjf
 XGhmh0pOomCl5X8Y75hAonV1cuzKVFBlJ/jXwI/68gQTTt9QqQnv8JfeYMzKjmnBWVce+j4xVoP
 U1FjLtBFGFCg9/bF5R58gn4f1lc4/J7QXiIM5cXxFrg8XEqFGZAsqq/EUVWH1FPhbVGY7p28DzT
 7l63ssRJAk0n4CiwZvHRzzVwfLIGeP9nDOKa3JKQ2Yc96itikusH9JVoGIhbcSR9NHFc3TlstXA
 /W0fVURpaN40g7Mg9EhIR4tzU3oCnO2GgZU3vzheo+uqXmd9KXc=

On 19/06/2025 12:17, Zhang Yi wrote:
>   }
> @@ -333,6 +335,12 @@ int blk_validate_limits(struct queue_limits *lim)
>   	if (!lim->max_segments)
>   		lim->max_segments = BLK_MAX_SEGMENTS;
>   
> +	if (lim->max_hw_wzeroes_unmap_sectors &&
> +	    lim->max_hw_wzeroes_unmap_sectors != lim->max_write_zeroes_sectors)
> +		return -EINVAL;

JFYI, I noticed that I am failing this check in raid0_set_limits() -> 
queue_limits_set() -> queue_limits_commit_update() -> 
blk_validate_limits() for v6.17-rc2

The raid0 array consists of NVMe partitions. Here 
lim->max_hw_wzeroes_unmap_sectors = 4096 and 
lim->max_write_zeroes_sectors = 0 values for the failure, above.

john@raspberrypi:~ $ cat /sys/block/nvme0n1/queue/write_zeroes_max_bytes
2097152
john@raspberrypi:~ $ cat 
/sys/block/nvme0n1/queue/write_zeroes_unmap_max_bytes
2097152
john@raspberrypi:~ $ cat
/sys/block/nvme0n1/queue/write_zeroes_unmap_max_hw_bytes
2097152
john@raspberrypi:~ $



> +	lim->max_wzeroes_unmap_sectors = min(lim->max_hw_wzeroes_unmap_sectors,
> +			lim->max_user_wzeroes_unmap_sectors);
> +
>   	lim->max_discard_sectors =
>   		min(lim->max_hw_discard_sectors, lim->max_user_discard_sectors);
>   
> @@ -418,10 +426,11 @@ int blk_set_default_limits(struct queue_limits *lim)


