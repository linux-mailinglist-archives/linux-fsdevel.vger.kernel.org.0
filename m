Return-Path: <linux-fsdevel+bounces-43867-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 86539A5ED2A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 08:41:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A1587A83AF
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Mar 2025 07:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B825FA11;
	Thu, 13 Mar 2025 07:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="MtPIQC2G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="grYPTwby"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE0D25F995;
	Thu, 13 Mar 2025 07:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741851706; cv=fail; b=bX3DAgILJGFqwF7equjS/Rphk0Go5wnqVOn3Hb7J4v3UrJspUAhP8UYEcaiBPM63UNIXZdR7CowBEvYUwmSaab5O2cYoOnUhcDbYjbn0l0Es6/pORUZbcxoPCmyquBRc9LLCIF4q3gqnPSSzoPJ6OeCUnXRPS4QLf5MdySlQpK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741851706; c=relaxed/simple;
	bh=IPpo8bvquEgiaRd5uk7wkZEADl6RAtj3HwszhWmXkyM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=CIBTfXaJMSA8h0EiKx77CPdKMtYyXQdr8KB/u7CDxE4D8mYBfggDxfgXYaWX58OGO96tpAN85Ls/3xVNXIzCy1abGnCvtCL+ZYcM13UBCOdjX8w9lt4QbbRdSsUhajrN46miPtl53NKNOyLNXXR1ZGNRqiDn4QgH31uTrGq61bk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=MtPIQC2G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=grYPTwby; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52D7XkwW007227;
	Thu, 13 Mar 2025 07:41:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=Z+HV2NAAmXgjUGmPQSBegSUoDyI/Mqaez+BcAhrsnM0=; b=
	MtPIQC2GPcQQWSRLWQKfRPijT0IAQKi8tL9wtSeSSyiMTO0HdOZ+hs6TilufHrgT
	BlJLb5X6XgoffANPcxIobxEYSB6hvz+g1hkuu8fb8cymYPMpw9eC8s9PslThgGtt
	koKkQu+d8jpDnrU1jKTLCTKqK6vthqF7IkE6ozvWL8qjrOIX8zHtrPQ26IkkRCpl
	ZPMB8NZYIrv2AILDJ/NBgkTlD/IC6CeNZI3h5KwRfaZoGJHvObhmubvGZj0dR3t1
	+7wP3eOX+Fvu65WRTnTaVEEC+Xi5EHtPKUikOnGIMSXWwEtxJu7XJAZTH+2N+ihW
	qM7aFtfPm82+fTutX6/b9g==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 45au4cuj6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:41:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 52D61VEL002320;
	Thu, 13 Mar 2025 07:41:17 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2040.outbound.protection.outlook.com [104.47.58.40])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 45atn8bx9h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Mar 2025 07:41:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XvSXn+jpBCzjOCgUnW8YEnoUOlm2k2Wpm90OX9ahcS+NivjN/0UbtIoGgdt42HE74gNnKNKPehox5rmNCPcxbXHYb3P610aOitAFZmBOgLygZekEioug/imFyiI5cAXFvUYKfxb+EtbYbVWZcr3tYc/QwuDZo1RyrG/5cddJ4YuS8l8yEQ0K1Z2QTINhZr7INU4UK6KSo3QVm8LxS24837yQQTjw6Jfgv/uMCsQ2FzdZhJUvBcI05X3Y/V+OlA7Nj8XYN/MaWq4JTS18Gpw+uZVokVhxdj2/ZSdiwM5GrWTPMp4e1+otQvrl3fSaYOhuyBgnS7vcoyl0J0tRSqFmOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+HV2NAAmXgjUGmPQSBegSUoDyI/Mqaez+BcAhrsnM0=;
 b=NcP+9/xXnQAo26zI1dPVaz5bd8fOImKZx9g4kSYG4bS1S0sUAIelobcRvqh00TsMIwVDffcf3J3BKDJc0Cyn/lU8PkBG7xTLlEGgUgc+ArGNdxrf7oEwp2r89GUFoIXeJnbQ//HfZXBWmCOKCq/6kthUdER/wMFg1ldOo3/B89g+Dj7+Jo2o6nvK8vCDjefgJ0MgXrppw6vkFWxwFeJwLgIO6aEHFILE1sfxEMyYn8NWeeuzkiY/kMCub7ea1fhvcveaQ32rtBgqJguvNEGrZBTObWj9WbUHp0VmEi6R+8PjotxUD3bfxw+DxaB07UQf7zgv4Hi2UePZWsm0H0IsCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+HV2NAAmXgjUGmPQSBegSUoDyI/Mqaez+BcAhrsnM0=;
 b=grYPTwby+mQ5LgFgzm9MHUXCjr+4UTJxct60Vu4wMdo4Np6Zbg1G+CA0XpqO40T6zAb1tpuvvezl6Yi6Phd6E6ZKHnJsg1stfPxKj7Ur+YoOQEL6luQBXG4iUkxJdcPEpgc6cDAKZp2bEgdUAdcCyBU7n/C0EUEnRMNqEM6WsXg=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by SJ0PR10MB6325.namprd10.prod.outlook.com (2603:10b6:a03:44a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.28; Thu, 13 Mar
 2025 07:41:14 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.8511.026; Thu, 13 Mar 2025
 07:41:14 +0000
Message-ID: <3aeb1d0e-6c74-4bfe-914d-22ba4152bc7f@oracle.com>
Date: Thu, 13 Mar 2025 07:41:11 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v5 10/10] iomap: Rename ATOMIC flags again
To: Christoph Hellwig <hch@infradead.org>
Cc: Dave Chinner <david@fromorbit.com>, brauner@kernel.org, djwong@kernel.org,
        cem@kernel.org, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        ojaswin@linux.ibm.com, ritesh.list@gmail.com,
        martin.petersen@oracle.com
References: <20250310183946.932054-1-john.g.garry@oracle.com>
 <20250310183946.932054-11-john.g.garry@oracle.com>
 <Z9E0JqQfdL4nPBH-@infradead.org> <Z9If-X3Iach3o_l3@dread.disaster.area>
 <85074165-4e56-421d-970b-0963da8de0e2@oracle.com>
 <Z9KC7UHOutY61C5K@infradead.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <Z9KC7UHOutY61C5K@infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0187.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:311::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|SJ0PR10MB6325:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c6e066b-8a2b-4bdf-ed8a-08dd62026e9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZkNOcGxrYkFoemw4QUdrVW8xd2ZueURYRkt3TXFkaDd5Zks0NXdlUTFlYU5O?=
 =?utf-8?B?anVKTFlCZTRGQ1JuT2VqSVN1WC9wY004WFF6T0tTOE0zdExCdHVSZTBTL01I?=
 =?utf-8?B?akVCL3IvVm01ZHFvYkhWVWozcCtoYUFiVzdmcWs5ZjN1b29tZXlXVmkxVUYv?=
 =?utf-8?B?Um1pQ1dNVEJ6OEY2RldJSnNaSm9BV0RlaFhJZ3Q0U3FZUSs3bWUvYXJTODk5?=
 =?utf-8?B?NGtkOWE4WjlaUUlMendXRTBIdE9wekJZbG01eHlzRGlkb0dTOU05Y1lIUWp3?=
 =?utf-8?B?eDlLV1lwYThDaFpVYm9paHdZbStlenhuS1lhb2dXTlJlTUZSRkxsV1lZTEFX?=
 =?utf-8?B?bDl1bmhzOExHTVU3SnRtZExSY0NnTnNSV0F5Qnl1S2xrSHZqbFpsb2x1NFFC?=
 =?utf-8?B?azJCTkg0SkZRVGFMQWZhL3FpLzlxaHQ1YnJKZHJBUVFxZWhqQ1AxRGlOa056?=
 =?utf-8?B?dTlNMzcvQTZtWFV4cEphS0pjNXBHTGJlQkF3YzNabkZrRHB6ZVNwUThRb1k4?=
 =?utf-8?B?TUxBMElGdHg1aE1iRnFOdDl2QjladkpVR0R3TUdSVFpQNllqczFNVUpNNEhm?=
 =?utf-8?B?MWxoM3lpZ01kMGNORm9BV2U4TnVrUEM4bExCSzhiTldSckFRNDNoSXI0NTdJ?=
 =?utf-8?B?RGJLdnJjN1liUUVLNk15SS81RGdYUi9jQWJKb0FLR21kVnlGR3E3R1h4QkJF?=
 =?utf-8?B?bkVEdlg0K1pmbk93R3NzcXZQNkpLS2FDelJ3UDNHQzhjSFo3dkUzc0FrdW80?=
 =?utf-8?B?SG1GMi91aHozQ1VQc3lXV3R0OW5kcGl1U29mN3ZVODJFU05kVHp2MEsvYllI?=
 =?utf-8?B?ZVE4UnVaWFpIOFJGN3FMMHpHb0p1b0VtZXM3R0xQV1JpSVl3VTk4UnptdEhi?=
 =?utf-8?B?Nk55b21uT3orLzdpZndGbUlLaUVjZy93Qlg0MGZENmxTeEZwQUVGc3ZpeXhx?=
 =?utf-8?B?TlpGYTlLSEJhcEdsRFY4T2dFREpIU0FoeHJYa21VWXJFeU5ERzRYcTc5TFZR?=
 =?utf-8?B?Z1pSZ3ZBRDZ6WXoraXdtTGowU2kzOVpHM2NURXNSblhhQ3JOc2dEajVMQUFt?=
 =?utf-8?B?UkxnUy9kRmRGczhTQUVJREd0QXlVUE8ralJUNlBhNWY2K2xxNFoxVnJZcEM2?=
 =?utf-8?B?bWFKczJXNnFPaGpsbkNTRDc1blZPYmVLQW9xRGp1d3B1allyYUdUbklxaVRl?=
 =?utf-8?B?UjlFejU2NDM4aEh5cmdiQ0ZmTzYzTTNmV3QyYUVBVTVVZi9QSWI0Z29Dc3NQ?=
 =?utf-8?B?Z1pVYnFoYTIzREhGTUJkODRrdVA1NTBmQU14K2IzY21hb0dVN2d4dEZTZVl3?=
 =?utf-8?B?SENGL0lpWDZ4VGw5VTlBeDNYQTZhcEFYeHZYVVlMcGZXc0hwTnFrQkFtMXVz?=
 =?utf-8?B?clpJTHllVVVLMGNaMzBjM3h2dmZKQkJjc0ZyeHZPTWxucVl2Mmc3SWFDODNE?=
 =?utf-8?B?T2VRS2FLaVpVTU1oRnR6cXBZdEdlVERoRHB3L0pNaE1WQVROY2IvV0lUUTZK?=
 =?utf-8?B?eTRLMkd6cFpzN3IrRnkvZW02ZDBOZ0ZUSytESGUwcTA4bVNjSE9sY3dyREVX?=
 =?utf-8?B?c1RhR0ZKd1pIQS9OaU5CZlNDS1pWeW91bEwzSEJOajFlOURYc2YrK1F4RDVC?=
 =?utf-8?B?REQyRnNpK3c4LzFSbGdoSHFQRFZkS3BrRXFRQkdNS3ZMeVExdkh0RTA5WmF1?=
 =?utf-8?B?S3FOWi9BZmIzSkx5ZU96OTdMTWZiN25lTllhU1lVU2pzckFYMkNsUUJydk83?=
 =?utf-8?B?WjE2aFM2T1ZVcXNjM2t3cGJHS21JMFI2aHJRSG5RMU5qR3cwZSt1QTBDdEZR?=
 =?utf-8?B?blpkODYwWnNiM0VCVDFFa2NBV1drL2dTYml6Z3NPeU1TRFJCcHBwM3FLUEc2?=
 =?utf-8?Q?nfrM3Dg59ekKS?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bERGNUlSemNuUGJZNU4yV3VNZTgyVXJjWjVQSUVQYUxsaDJaalVkTHdROG12?=
 =?utf-8?B?VXQ2R2NuU3hJU2xya0lMR0pVUnJKSjZEdGNEUjUxMkpld0FHRThwY3d1Mm9X?=
 =?utf-8?B?ellLa0FHQjVSakFvVTkxVXhyQ3BIVERtcHpxbEpYRy9NSytJN001NVRTanow?=
 =?utf-8?B?NGFDQVJiTE9jeW1oeWk4bXhXNXZoOTZKcFVNMnN6N3NwbVBpSFFkaTFWdEhI?=
 =?utf-8?B?cnhYY1VrVTJtd0kvT25yUDNaRlpwckljMFZXK3ZPN3VueVR3cThRZzd0NHMv?=
 =?utf-8?B?Y0YrMXhsRW1nVVQvTmJYdFVmZHl1akR2Rjg0bEsvbW0zOStWM1djTmM5bm4y?=
 =?utf-8?B?UmVZYkxuSUFTS1JDTUtlR2lCQ0dudkY4OWluWW1BY2pzZlVlOHhTT0xtSzg0?=
 =?utf-8?B?ZDlGZ20yWVh3SktyMlptTDRrVVBUdzdkOVZnZnhQYytvZUVEcHZKdVo2YTcz?=
 =?utf-8?B?Q1p6MENCTUhRWU5qTkJJdmJhMTF1WDlJakVhV2Z3YW9ZOElpdG9CUXlMZlN4?=
 =?utf-8?B?eGdnUUg0cEhsbWhzLzBNNW4xakZvRnFWaldLYm5hSVZmZGRua0lGaUJobGFw?=
 =?utf-8?B?cFpYVmdob2tlU0I0aEoyTk1zSkVmc3BDUHhudmNFejdBTklHQmR0cWJ1NUtQ?=
 =?utf-8?B?MjA1SW5uaThrRFZOSkY3cW0vcEdmZTZKd24zZHFjYzV0bFFJKzZzQitpQ3RQ?=
 =?utf-8?B?VEtKNmhrOEdrYjFpU1MvbFh2ZGI1NWFHT25tUXdNeUlqWHNOcitDUDk4MzRw?=
 =?utf-8?B?c0RYZjltRVplMkV3RkJDb0o1RFBFNTF4VXhLc21HcW1HcXhXQXBsZndaaG1o?=
 =?utf-8?B?SmU0c2ViL0N0WE9LM2ZhRFBtZGpiLzYxNXdJZUJ1NDY1bW8zckFIbkQrcDcy?=
 =?utf-8?B?N29TZk5qSXRJYmkzbGYzVjFqMVdZYnhmcUJDSEZHbkJraEl5ajNkT09ZSWhR?=
 =?utf-8?B?SStNSnFsUktvUHpTRndGdWpyZzdzSFlUMU1CNVhrOFc1T05ydlZabXFOa3pH?=
 =?utf-8?B?bm1tTTM4RlkxT0RybmpmSVZwNGlCTjlQTDNYVWpWbW1VcjZ6aXgwbzdVSm1R?=
 =?utf-8?B?bWFXamF6dlR6Sk1LMlRIUGptM1dNS0t2dmI1d25aV3FHZnpHdTNEbWd3ODNj?=
 =?utf-8?B?L1NpNEJNQ2N5aklURTNKMmx0U0twOUprd0ovbmZJNm12WUQyTGRPVGxST2ZX?=
 =?utf-8?B?TzJxaExpWE5mcVhDcllVMEhBZ3gyRnRlSnRHSVVWRVIxenhERXhDUVpKY28v?=
 =?utf-8?B?djNYdGN4Ylc0TkR2TkJVZG96U0tzOGVCWmNlcEVva21DSFYwRzluWUdTbC9Q?=
 =?utf-8?B?WGgycHVDT0RtSVFERWVucnJ5ZVBIeGdNTDY1N1VWOHR0clZJcDFHZm52SXEy?=
 =?utf-8?B?SU5xRkwvejRrcnE2SlJ0b3dOMXJJRkR0alVmS3h5Tk5vTGM4UkRXNE1OMTlv?=
 =?utf-8?B?OWhnY3BEL2JMTzE5OGRteERQb2Njek9PZ0ttWE9VZXI2QzFQM0pEZ1F4NW1j?=
 =?utf-8?B?Vk90eXovR1JkTFV0OG1tOHJ3NzRFWEdYN2gzeFpFTGljeHEvWjN0Sk1EWGVU?=
 =?utf-8?B?WDZRRnNVYm82SWdVbWtVcnZsbVNvK1lJSmZwdDdvVllkUlFOVTYyOFRVeDdo?=
 =?utf-8?B?SEJQL0RCZTdsbTNBY2dXUDB5dzBLUTAvSEJpbTZObW16YkVESmt1S21scjhy?=
 =?utf-8?B?S0JrN1ZSbmNSOVB5VzQ3Zk1oMFAxVXM0WWlEQ0xLazZGNjhmTTRNeWh4eTlJ?=
 =?utf-8?B?S3J6Ym1sZ1ZNMFRuN2hIWXNldUZXWFdDenVWeTlUd0dFdE5ia0FBK0c4SVFE?=
 =?utf-8?B?eVlNMTdCY1hRNXA5bHVzeVAwRW1DblJDeXc2Rll0ckdRWlNOKzZtWlptY3g5?=
 =?utf-8?B?Ymh3RVRQY1BxeEFPTXloU09pRmR3bFE2eStyWE40QUdUajBxOW9ha21RQTZo?=
 =?utf-8?B?UDhJcjIvZW5UWFZmaDhvM3JsVzZ4UVE0QkhHMjJobUZLdE5HZjJrdlQ3TzN4?=
 =?utf-8?B?QTBaNHp1Sk1qYld4WHQ1Yjh0SjdTd25Fd0k0RFdSZGVBbC9TY2ZGcklBeU1M?=
 =?utf-8?B?ODBWU3BjcFdWNXdWb0V2TmtHRm9EK0o0SWRwakg5OXVzcjF6aXdYcFRidG9W?=
 =?utf-8?B?Wmd4U0R0VmFhSGNuQ21VZEJFQy85RDh3bEdJSm82ZEZ5TGZrWkt2d2dOMXZZ?=
 =?utf-8?B?QkE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	TdQPfIEShoBuGqFeYvqan2oOSaMmJ2UHbkL4AFCk6Ucl3PBrGLwBrIC7kiEqmFEimIYbFxPOLgPWneUWtWakQuVChq/jGmTZpRixTrQcWM9LWvi+FOP4F894OSms8Ms/9K2TgMdoQGe7zn2riX5FJe7RA1Fm+RejqR49SU8sco04sGBUUtdQpuKpY3BmJkXxAMM47aABe/ZajdSlVpjQS/UPkWtN+Al4Mx3e4jENIxe4ub/M5rOLXtB8GZP7fWFQW5fTs5JfrqF2rp+bCKNU5y3G/Qm23vZ7bccvOJHAFIJ5N307ClISHwLyJszaecwPU0DoPbgV9hPBfl3CRcK7lPX9QSl3fUogUWGqU5a7HPD0maGIO4T2iGioQ9E05rQXcam5SLwjOsNz7/jdXLrVZy2+O7ZS8nrAKT+nvi6kusmQZw4iRrxyzWdQO/tv9HzP3FZNNQyihoIv9x7RnV+EkwUG7S1ZQ7cF5JIQSRH/6f6X2G2FC1TBW2LOtqPQClHK37RNWv4HAl8IRrbB5JjIbju76yUiKtSMwxOcUZ7MJgkNcTLeE7JGbtSUekX+jfHewqD9hEsb36gYBfmqSoZ/Q+9nIpLGIBV+OdUmgMuoQwk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c6e066b-8a2b-4bdf-ed8a-08dd62026e9d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2025 07:41:14.4107
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pyOEyfhMqPAu2v0ZP3ufzN81M00+I8NvLoknj4B++ciYuHpXmbCmmH+LmUhl9fLT7dTkBzIS7dxjegJ5U7rBOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB6325
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-13_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 suspectscore=0 adultscore=0 spamscore=0 mlxscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2502280000 definitions=main-2503130059
X-Proofpoint-ORIG-GUID: AgRQADKMgSvqYmsn9UMEf7KeZAVb7fmb
X-Proofpoint-GUID: AgRQADKMgSvqYmsn9UMEf7KeZAVb7fmb

On 13/03/2025 07:02, Christoph Hellwig wrote:
> On Thu, Mar 13, 2025 at 06:28:03AM +0000, John Garry wrote:
>>>> I'd rather have a
>>>>
>>>>       blk_opf_t extra_flags;
>>>>
>>>> in the caller that gets REQ_FUA and REQ_ATOMIC assigned as needed,
>>>> and then just clear
>>> Yep, that is cleaner..
>>
>> This suggestion is not clear to me.
>>
>> Is it that iomap_dio_bio_iter() [the only caller of iomap_dio_bio_opflags()]
>> sets REQ_FUA and REQ_ATOMIC in extra_flags, and then we extra_flags |
>> bio_opf?
> 
> Yes.
> 
>> Note that iomap_dio_bio_opflags() does still use use_fua for clearing
>> IOMAP_DIO_WRITE_THROUGH.
> 
> You can check for REQ_FUA in extra_flags (or the entire op).
 > >> And to me it seems nicer to set all the REQ_ flags in one place.
> 
> Passing multiple bool arguments just loses way too much context.  But
> if you really want everything in one place you could probably build
> the entire blk_opf_t in iomap_dio_bio_iter, and avoid having to
> recalculate it for every bio.
> 

Yeah, when we start taking use_fua and atomic_bio args from 
iomap_dio_bio_opflags(), then iomap_dio_bio_opflags() becomes a shell of 
the function.

So how about this (I would re-add the write through comment):

--- a/fs/iomap/direct-io.c
+++ b/fs/iomap/direct-io.c
@@ -311,30 +311,6 @@ static int iomap_dio_zero(const struct iomap_iter 
*iter, struct iomap_dio *dio,
  	return 0;
  }

-/*
- * Figure out the bio's operation flags from the dio request, the
- * mapping, and whether or not we want FUA.  Note that we can end up
- * clearing the WRITE_THROUGH flag in the dio request.
- */
-static inline blk_opf_t iomap_dio_bio_opflags(struct iomap_dio *dio,
-		const struct iomap *iomap, bool use_fua, bool atomic_hw)
-{
-	blk_opf_t opflags = REQ_SYNC | REQ_IDLE;
-
-	if (!(dio->flags & IOMAP_DIO_WRITE))
-		return REQ_OP_READ;
-
-	opflags |= REQ_OP_WRITE;
-	if (use_fua)
-		opflags |= REQ_FUA;
-	else
-		dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
-	if (atomic_hw)
-		opflags |= REQ_ATOMIC;
-
-	return opflags;
-}
-
  static int iomap_dio_bio_iter(struct iomap_iter *iter, struct 
iomap_dio *dio)
  {
  	const struct iomap *iomap = &iter->iomap;
@@ -346,13 +322,20 @@ static int iomap_dio_bio_iter(struct iomap_iter 
*iter, struct iomap_dio *dio)
  	blk_opf_t bio_opf;
  	struct bio *bio;
  	bool need_zeroout = false;
-	bool use_fua = false;
  	int nr_pages, ret = 0;
  	u64 copied = 0;
  	size_t orig_count;

-	if (atomic_hw && length != iter->len)
-		return -EINVAL;
+	if (dio->flags & IOMAP_DIO_WRITE) {
+		bio_opf = REQ_OP_WRITE;
+		if (atomic_hw)  {
+			if (length != iter->len)
+				return -EINVAL;
+			bio_opf |= REQ_ATOMIC;
+		}
+	} else {
+		bio_opf = REQ_OP_READ;
+	}

  	if ((pos | length) & (bdev_logical_block_size(iomap->bdev) - 1) ||
  	    !bdev_iter_is_aligned(iomap->bdev, dio->submit.iter))
@@ -382,10 +365,12 @@ static int iomap_dio_bio_iter(struct iomap_iter 
*iter, struct iomap_dio *dio)
  		 */
  		if (!(iomap->flags & (IOMAP_F_SHARED|IOMAP_F_DIRTY)) &&
  		    (dio->flags & IOMAP_DIO_WRITE_THROUGH) &&
-		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev)))
-			use_fua = true;
-		else if (dio->flags & IOMAP_DIO_NEED_SYNC)
+		    (bdev_fua(iomap->bdev) || !bdev_write_cache(iomap->bdev))) {
+			bio_opf |= REQ_FUA; //reads as well?
+			dio->flags &= ~IOMAP_DIO_WRITE_THROUGH;
+		} else if (dio->flags & IOMAP_DIO_NEED_SYNC) {
  			dio->flags &= ~IOMAP_DIO_CALLER_COMP;
+		}
  	}

  	/*
@@ -407,7 +392,7 @@ static int iomap_dio_bio_iter(struct iomap_iter 
*iter, struct iomap_dio *dio)
  	 * during completion processing.
  	 */
  	if (need_zeroout ||
-	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !use_fua) ||
+	    ((dio->flags & IOMAP_DIO_NEED_SYNC) && !(bio_opf & REQ_FUA)) ||
  	    ((dio->flags & IOMAP_DIO_WRITE) && pos >= i_size_read(inode)))
  		dio->flags &= ~IOMAP_DIO_CALLER_COMP;

@@ -428,8 +413,6 @@ static int iomap_dio_bio_iter(struct iomap_iter 
*iter, struct iomap_dio *dio)
  			goto out;
  	}

-	bio_opf = iomap_dio_bio_opflags(dio, iomap, use_fua, atomic_hw);
-
  	nr_pages = bio_iov_vecs_to_alloc(dio->submit.iter, BIO_MAX_VECS);
  	do {
  		size_t n;
-- 


