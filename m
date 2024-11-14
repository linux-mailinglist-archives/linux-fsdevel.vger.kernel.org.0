Return-Path: <linux-fsdevel+bounces-34824-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E2219C8FAD
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 17:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D43B281036
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2024 16:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1147E18DF9C;
	Thu, 14 Nov 2024 16:22:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="hpZsy98x";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="I61HoWSQ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE3B817D366;
	Thu, 14 Nov 2024 16:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731601360; cv=fail; b=uplxuZ/KVy/ExrJ+jwiqnSwiA0+xAC89BA/DcLc3OLE58LgmhNmc6wG1i1LJ0taLBzsSyDdrT2g+5BMn2PDnhCHT+fyFlz4/4aSCfyWXfDfGFiokwHxjVdSW0rdB39bZghETUYuoh3f0jr2VyoKvd+r5EQ/zSI13es+CQQ3VfvQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731601360; c=relaxed/simple;
	bh=6Lxa31EWs1hJ9oX36oK+VbZ0O/T/EGlDq/2mlGCmx9k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=BVYAxel1Kr2XHWYzllKhn2Bi1fUhcTLmwbr9Qb4mfKMhdUfc7NDPTq7tGA/w0BdzOIDIssbPm6EykiXYqzwVSnOzJif+HbZJbdHgurTqIQ8dFGTUpy508x1jTgoz3q3gjLajygHNL1Gap5ww7N5ndLJTACc8W/UKTKKnehEC5EA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=hpZsy98x; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=I61HoWSQ; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEChXpV018587;
	Thu, 14 Nov 2024 16:22:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2023-11-20; bh=c2Bfn4GaQHWd3dNbx0WvH5BKNNeqocOeEAfAx32S54g=; b=
	hpZsy98xAx2q45m9h1JpkJRSL8TACz0sJEIslK/BdrShgw/Kg7/J3/caYIqFByr0
	1DIz+07HGiPYyPGhfGy6m8QNrC2RsgjInzvREUE5Oof6MLAGB7ZAidvQOXTnZvTm
	PRv9Uk6tFY2+/BbJgFWMoT5RZmFjp552O2GYEGKqXG648tRdQCrPhiSpLE7nOpsn
	3kQYLooHCm5ftasfhMIrb/vS/uyJLgUl38TLtato6Qnop15FEjeXLpTk81/vD0et
	Ed7hMHW91tWafbWts9TRmBvkrKksPLGjXuTcHFdD02pPKnKP2KPb46C4Y5j6zMrN
	OKWNSlp88WKNxmKkSEoHtA==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 42t0kc1qfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 16:22:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 4AEFARpe035973;
	Thu, 14 Nov 2024 16:22:11 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2045.outbound.protection.outlook.com [104.47.58.45])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 42sx6b1ne9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 16:22:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rq4y2uesQ7+jKcik9NGQ+GyOMCsNFA9Dj971BPw8NgYMuYyOkWxWTovaMZV7MxJcXA4Drx2jpv6ue9yE3xig/dyUyVflu0fdIyw5x/qAs8XHKQxmXcz212QIwYnhERKk8O72kDmyzyA7GbKiEwvaRwkXxX1drndjVw4KIlZp0ZwC2yXkieWemoy0osR4dYL1z/ChVovFAJkYZ2EY0Ta2OE6rNcXS7+eAv+5VDU2ZeMacwPKfPpsabM3Z8g7E7ECYvzvejq/eVi7kzpBPewnHCVx5PH+RWlGDqQS2bSf++IPB6B4NQLWUm8nNrjRD4XfQOPBlCffPkUlV1sdvlhAm7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c2Bfn4GaQHWd3dNbx0WvH5BKNNeqocOeEAfAx32S54g=;
 b=O0vkKGp4fgqlCDy+yzIXKf+u7kbvLd0QQuW1Tdbt8re8iSIqh6IvRgGydVZPG0m243Mm3puBlgy6On4hU4nXSUhZlWyv3H1ox0myPNomAc5A8zMlzb2ynfcQ+QKGjb/3j4A2Z7nQa2PaICmoSlLn9yNkjZLBiinBNk0aYMsbwZ4hem54O8061kicBFkfCCMXQxQhUYmixmGuV04zJxJqT2IhhSvnfJiKTnuOE2uMNhK0YqjxH9iYQOBDvK6Ju/HBjIvMZwbUQRg75X8U8gIwbJhtIXaS9CpcsuuFpZwvqvjF9+hq6dC4CmDIOe1FnnEo3JDe7Zw3++FQ80BrKcPcsA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c2Bfn4GaQHWd3dNbx0WvH5BKNNeqocOeEAfAx32S54g=;
 b=I61HoWSQynljUgUu9nzSnVnD/ODre8w5LtpCDDTp2bDpD+Wxj5AFAqvvLGIcjPSg429ZZnewgExVUsqVHMZIsfYgVcdogwHZZChyVrIBnZEhhKvJaz+SG0cC6tOBITskP44xjPt9BywhiKymBfCquxfonh6kKkJEqUUVeCOl8rk=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DS0PR10MB6894.namprd10.prod.outlook.com (2603:10b6:8:134::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.17; Thu, 14 Nov
 2024 16:22:07 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%5]) with mapi id 15.20.8158.017; Thu, 14 Nov 2024
 16:22:06 +0000
Message-ID: <94ed563e-5f18-4a80-a137-e35400cd038d@oracle.com>
Date: Thu, 14 Nov 2024 16:22:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/14] forcealign for xfs
To: Long Li <leo.lilong@huawei.com>, Dave Chinner <david@fromorbit.com>
Cc: Ritesh Harjani <ritesh.list@gmail.com>, chandan.babu@oracle.com,
        djwong@kernel.org, dchinner@redhat.com, hch@lst.de,
        viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz,
        linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, catherine.hoang@oracle.com,
        martin.petersen@oracle.com
References: <ZtjrUI+oqqABJL2j@dread.disaster.area>
 <79e22c54-04bd-4b89-b20c-3f80a9f84f6b@oracle.com>
 <Ztom6uI0L4uEmDjT@dread.disaster.area>
 <ce87e4fb-ab5f-4218-aeb8-dd60c48c67cb@oracle.com>
 <Zt4qCLL6gBQ1kOFj@dread.disaster.area>
 <84b68068-e159-4e28-bf06-767ea7858d79@oracle.com>
 <ZufBMioqpwjSFul+@dread.disaster.area>
 <0e9dc6f8-df1b-48f3-a9e0-f5f5507d92c1@oracle.com>
 <ZuoCafOAVqSN6AIK@dread.disaster.area>
 <1394ceeb-ce8c-4d0f-aec8-ba93bf1afb90@oracle.com>
 <ZzXxlf6RWeX3e-3x@localhost.localdomain>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <ZzXxlf6RWeX3e-3x@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO6P123CA0015.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:338::20) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DS0PR10MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 677ce8ae-cdf7-4ff5-c721-08dd04c87b2b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UWxZNWR4SVVuOStZeU83UW1iZU9NY0gza3h4eXFJUnlSTkc0aStyaGRwSWF2?=
 =?utf-8?B?TDJHTmprbnpiRGF1RmNTSzdSRnlSTnlORjVmNUlJcjJBRzVjVnlxYUpNMmJS?=
 =?utf-8?B?K3F5U1dURXlCcXFnSlhJNmlrNnVIL3VQcHhkTVRxVmxDTUhJRWhuNjlSQ3JJ?=
 =?utf-8?B?dTdTQ2hnVWFwYi9PZUNKMTRqdVFWVndZczdmak91eHFRSmdWZXNJZDk5WVk4?=
 =?utf-8?B?N0kwK2NwWkV3cmNnTFlrOCtsN3o2WmY0WW1VdENVZDZ4WDlpTVhQaDVGWlI2?=
 =?utf-8?B?cmhxQUxkZnZjUUVEd3d6WFhiZngvcDVLQUgvWkREVmhPRU1DdG9zWmdLYTZX?=
 =?utf-8?B?K3hRbHFmZm5rL2pPWDhCZGV2OE8xMFpJTlZXZUljMjNEMDFKY3RRdExTYWlY?=
 =?utf-8?B?Y1ZBMk1yc0JFcUxQVUdqa25kdldQcW83U3lPaCtaVytoRXNCcWFpS050Wjh6?=
 =?utf-8?B?MS9rZ1RqNTA0bmVwM0FiVDFQeWh2S1MydmlKV1Z4c1p0MDZ2SzdzUUNidFpK?=
 =?utf-8?B?RGRVd29uWUl2ckE3OWV3YThFcDVqWXpvMzNpam9oOHVpdi9HUUtDOGVZckQx?=
 =?utf-8?B?QlR3TUNMSVI1cjRKL09qWEpkMzdmdzlRaG1CQWpFRFpzRHM2RTFtOG03bzNW?=
 =?utf-8?B?azBmN2hZMm8rSzUxRDcrQjVXaWViVlRZcTdCdE1tMTZuK3hXTzhYbml2dm1V?=
 =?utf-8?B?Qlp4cVcwWlQ5T1JaZUdmZUxFYWowQXF1K0RRQk9PWXlQVk9WOW9SVUdkVDVT?=
 =?utf-8?B?Q0twL3FQU3BJUkIrOS9ZQ1dTSmpnS2E2eDdRZ0tGaGRGMFZqOUNBa0h3dnlY?=
 =?utf-8?B?WndEeUF1bDcrSGlrb1BhS1pqSURlbUJxaW1WVFU1ZnQzRTFtRlZTdDVRVWZT?=
 =?utf-8?B?RmEzb1ZmSnN4NzVYWlFBemdEdDhCUjQyTHIvU3k0MlpNazZ5MmZYczJIa1lQ?=
 =?utf-8?B?TGxCOHJ0MWVUNWN1SWZFWUEvdklQQm9KbmpyQ0JRSlJHQnptUm56ZHEyNjFB?=
 =?utf-8?B?N2hvTFRSMnlvRUJkYUZFNndOeGdITGtoSWtyQUZpbjVkeUlrVGRUWGxBN1Br?=
 =?utf-8?B?bDBiZWprc0ZYME5MY3dUNDlRYVIyNGVnOVlPampWU3NXU1R2NDBHNVFteUps?=
 =?utf-8?B?S1FzLzQwZ0V0anVLZHQzVkdNT0p0V1ZGb0NpanAxSE9Ha1FSRGo5dW5jWUtG?=
 =?utf-8?B?RjNudzNQME5YVjBSNGlCR2pXRW5pL1RibGpUOFFSTUdFUGowRmxUMVNaa0Mx?=
 =?utf-8?B?dnZqQ2VLUVV2U3J1WjR1TDViY2JKalhwMWZnRitRRkhKNUFkanJBcTRYbkFa?=
 =?utf-8?B?NlM2U0U1Smo2VzdmS0VkSW4vdjlrb09XZ2dRWHI0M2RFbzRuT2Z0R2d6T3pn?=
 =?utf-8?B?YWJFVGRua2RtZW56akgxK1RQMjFUNERvRTY2TG4wY2xGejg1T0cxR1h2cC8w?=
 =?utf-8?B?UXBjdGF3dDR2OTZuQ0Vuci9HdlFUR3FzWGNibGNQNkRsZEtUTFFpcFdpR00x?=
 =?utf-8?B?ZHdwYU9IdEN3d3o3RlBqVjc1aml3cjJLOHM5cm9YUVZTZlp4MHc0aHdmbm1y?=
 =?utf-8?B?K1RyMnh5dW4ydmdDRk1lbEMvUkQ4VWQxOHdETnNsdUJZL2V0Y1VYamxUUDBK?=
 =?utf-8?B?VFpOQVpONDZvaVRVYVFUdS9xV3dvc3QxTzZnTFZxUStPbytQK3REUGU1TzFC?=
 =?utf-8?B?YTBVb3FzdTZhSVRsWkMrL0pUU0xSamNuRnYzQnFhL1lNUzcvSU1CYW1mbGtv?=
 =?utf-8?Q?MiXX6H8GkoKiyiSeXN5NT+Xj/z/9QOYggPplFqH?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?L0NId2tWTU01UEF4SFFUVlhocU44K3ZyeDZMWWsyUmg4SW91dEg0MDB4NVFB?=
 =?utf-8?B?cVhkQXVNNnRHaGxCNUxzT3N3YThBY0JLODJCOG9Lei9mYUlNMTBZSTFNODRI?=
 =?utf-8?B?dUkxZHU1elgzWXlqU0Vvajg1MUFlQlk4ZE8wNmJMeHhhcnhpZHlyUkR2Yldj?=
 =?utf-8?B?VitFNkZ0dDRVK1FVVG9rTTZ3bEx1cWxGSkFJSTcwcGkrN2Eza2kvWnR1dUpY?=
 =?utf-8?B?VWRGSmtTWXRNcUlzN0k1alZOOWhla2JYbmxmMjZLeFRqYUlTM2pVNnJzK1Zx?=
 =?utf-8?B?M2M1c01td3VkMDkvbnZINkd5eDRYSVBZY3AwRm1JZVdxRXREVjc1WGpoZXJu?=
 =?utf-8?B?djJsSGx5RU1PSHhMOXhheXB3UmxGM3l1S2s0dTRaK0JnMXg1bVpvNG83ekVL?=
 =?utf-8?B?T3pFa0piV2ViaXdLV01GbHFsVXBnbytGTThKOVJueWh0eEsreWxyWk9DcENF?=
 =?utf-8?B?aFZTdlVsVjZSV0RObGxoV0luaE1DbzFaSENmZnR3VTFTTjZjZ0NpT3J4YW10?=
 =?utf-8?B?aENCUHd4K3VtODJXdWxLQzhPR3RGWWU0MU8xNzF3YjBLTGlTZDhHSlE5NWE4?=
 =?utf-8?B?endMY0lPOWVzbnlzMWFQOThQM3ZnVzRCM2hES2FRZVpSRW9IV01ZU3dyL051?=
 =?utf-8?B?cUt6OEhHdTBVRmdvcHhVMkNBT05RUm04cVMzVUtwZkRJdjJJWTFNdFZPY1ho?=
 =?utf-8?B?azl5WTVzSXIrR3BkS25YTkpIcExTY00vYWtZNzd2SS8rOFpybXV1dU14VXpJ?=
 =?utf-8?B?SjI4cndSQXBHeUUxa0ZNTW43UzV2dXM4Wnc4OWVBWTU3WGdpRGZZcDg2Y2ds?=
 =?utf-8?B?QW16L20yOUlsM1lYN2NZcHNVTVBjOEdtcWpaWVpEQjhxTldQYkdGUVVzVVVz?=
 =?utf-8?B?dndvQjVBN2REZVJRajVzL0h3VUl4OCtJZ0pMQ3A4cHByMzVQd285dFJCdXVF?=
 =?utf-8?B?SldOdCtaS3Rqb09QaHdLTWg0ZHQwMkFkd1pXVG1GamF2K28vNFUwQzZ2Q1VX?=
 =?utf-8?B?OGxXOU1XQ0lPUUhkMGF3UU1YampOS0twb3oyMG4rZW9nUnJZS041WDFyRk1B?=
 =?utf-8?B?UVBSL2E0MW54c0E0Vzl2TUQ0WjYrZElXb3pvMnF1dXBMc1Y5YkEzN3dXMUlt?=
 =?utf-8?B?NWU3V1RKMUxzazd6Nnh3NGdTSzlzV3pZaGFoWTdRQ1I4TFpZaU51cmw0aWhZ?=
 =?utf-8?B?UVM3eEU3VTZ3NGM2ZDdVYmkwL040Z2EzeXFPYUVRc3pQNEpLM1o0ZnYrNTRs?=
 =?utf-8?B?QlFVVXBQUld3M1M0YzBldDBOUFZGVWplUDk0MGVRVWRUUTk2R2trR0JybU1F?=
 =?utf-8?B?R2tadHJtRksyV21IWG9pN1h2bnpWRTV3R3hhNUN6RFlYRmh5Zi9sdFhOUkI3?=
 =?utf-8?B?L1I0dnpQck1nSlZ6WXBxVzFKUzUwS1ljeUVYd25tNGdyMDd1VDJRTGozeFZp?=
 =?utf-8?B?VGo2NUlwWFZ5UkUrOVBNZnZpTU80Zm1kRnZ2dnkyRHBvVjdmdzAvV3ZMVGsy?=
 =?utf-8?B?QURtSUJXTUZpMGVOWE5CYkM4NjRTR0hJMERXTFBra2RKYlo0OUxJVzBiYjY5?=
 =?utf-8?B?QmdFYWpGeXFHU1orNSt2NmhYOE8xL01pZy9FZXJrbkZ0TXFNNWZCNGJsVS9x?=
 =?utf-8?B?eElvWk05dFZYRHZzRlhVSDh3VFhzbmtuTi9WNXdabEVmY0l2WVgrdDBmMGw1?=
 =?utf-8?B?SHJ4Rzd0T2lxWFRaT0I3elpMMVEwNGJIVTRyckJKTEt3S2c5TjNEOVBseWJI?=
 =?utf-8?B?ZGRzNVp1VXBpdldIYmhsS3JDL2JCWmh4MUF2NjdPYThzWmd6enFvblZEcmZX?=
 =?utf-8?B?cGJxMlJ0bzBJYmFkekphRDJ1THhaNEVHeDdEWTVMUWtVQ2NaRFFnbVlnMVZk?=
 =?utf-8?B?V2xFN1JxMTJYL1lTaE9ybWpGdjlEeVRyNmtGY1RaUTZRNVFwbzhLN2FaWTk3?=
 =?utf-8?B?ZkgrOXFveVhVeExMZ1lNR2NacVVEcUtWKy9IWUtPL2JrL2xWdGoxQzEwS2Zx?=
 =?utf-8?B?d2k1NWJpcXJ6RHc2ejRUcXZob0g1UGdDU1c2S0RKV2tBRlNYY1hwMUpOM1JS?=
 =?utf-8?B?cE5KNWkwaWNUaEFDbkFLM1ljY1NWbW5SN0R4bW5PcDYyQ1hyN2diaTFKNHZS?=
 =?utf-8?B?K2N2aExWODN2WW1LTlNSYW1iampHdi9wRGRDMnJiSFdlU0FROWphZ2RNemNm?=
 =?utf-8?B?K1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	5w6MSKzue/KGeURcHRadvbu/LTEvnpt0V7g0wscKsKzN/e46NpIkylwP2Ius6YSl0rhPFrnuPf462vkgSrUVCQUbiNv80vJMUQJkjUS5Tlq0nTJipr6ZQcv6FqxoVEZppivHpD4IL0WoetmGpDRZaKjwObsoRCq6ZVtee4xQf7I2+7iXHtZQG3kaJZcP44DGkYnm/Xcc845DIg+N/67bdcT47E5tp+aCZBvgk/nhjwDiIV2Pxlmflr6kJK1xQaXX5tR/gK6oPXr0mAGkJQcDLwZbW8TXkxz2x+t7BNXzdu22N/57SItENHx0VnvHF8Met9U75iiuR23RkSMBYXm5I2fEB4VWlfLajaDmcPePgsDSIQu10dW4peXL8/juMZdZRsfjqRfJu6WCntjpaNiRIzIYrmWcIkfUMHbOUGBmUv+7C5BwjSebTlJUYyRJztyMoVriHv2n8QyqGQ/BW0oLUDDj4Nq0oKn/RliaAkc1SaiZtCJSdYtsd1quY6TOp+QsVOtuaTkIIwQK3y0FIiaQ/oM1NyVKexm0R2zWy8stSpiwKSC195oxwTqR59kjv7K4v8ywL3dfh4r8/pUJ/hLfD5YNJ4iP+5rI7ONvU1Jw+88=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 677ce8ae-cdf7-4ff5-c721-08dd04c87b2b
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2024 16:22:06.5910
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dyN5ETDic4eea/MRfBGMgiA4SF48LoQlMJYuLDrfCIKTtQG2+wy7EuGF1fVREUsMCg4jEu/jJPPUtl9JIvIAlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR10MB6894
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-11-14_05,2024-11-13_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 bulkscore=0 suspectscore=0 phishscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2409260000
 definitions=main-2411140127
X-Proofpoint-GUID: kykisfbIJSYHG-t8Tml31fye2vKGck46
X-Proofpoint-ORIG-GUID: kykisfbIJSYHG-t8Tml31fye2vKGck46

On 14/11/2024 12:48, Long Li wrote:
> On Wed, Sep 18, 2024 at 11:12:47AM +0100, John Garry wrote:
>> On 17/09/2024 23:27, Dave Chinner wrote:
>>>> # xfs_bmap -vvp  mnt/file
>>>> mnt/file:
>>>> EXT: FILE-OFFSET      BLOCK-RANGE      AG AG-OFFSET        TOTAL FLAGS
>>>>     0: [0..15]:         384..399          0 (384..399)          16 010000
>>>>     1: [16..31]:        400..415          0 (400..415)          16 000000
>>>>     2: [32..127]:       416..511          0 (416..511)          96 010000
>>>>     3: [128..255]:      256..383          0 (256..383)         128 000000
>>>> FLAG Values:
>>>>      0010000 Unwritten preallocated extent
>>>>
>>>> Here we have unaligned extents wrt extsize.
>>>>
>>>> The sub-alloc unit zeroing would solve that - is that what you would still
>>>> advocate (to solve that issue)?
>>> Yes, I thought that was already implemented for force-align with the
>>> DIO code via the extsize zero-around changes in the iomap code. Why
>>> isn't that zero-around code ensuring the correct extent layout here?
>> I just have not included the extsize zero-around changes here. They were
>> just grouped with the atomic writes support, as they were added specifically
>> for the atomic writes support. Indeed - to me at least - it is strange that
>> the DIO code changes are required for XFS forcealign implementation. And,
>> even if we use extsize zero-around changes for DIO path, what about buffered
>> IO?
> 
> I've been reviewing and testing the XFS atomic write patch series. Since
> there haven't been any new responses to the previous discussions on this
> issue, I'd like to inquire about the buffered IO problem with force-aligned
> files, which is a scenario we might encounter.
> 
> Consider a case where the file supports force-alignment with a 64K extent size,
> and the system page size is 4K. Take the following commands as an example:
> 
> xfs_io  -c "pwrite 64k 64k" mnt/file
> xfs_io  -c "pwrite 8k 8k" mnt/file
> 
> If unaligned unwritten extents are not permitted, we need to zero out the
> sub-allocation units for ranges [0, 8K] and [16K, 64K] to prevent stale
> data. 

How does this prevent stale data? Just zeroing will ensure aligned 
extents. Unless iomap is provided a mapping for the fully aligned extent.

> While this can be handled relatively easily in direct I/O scenarios,
> it presents significant challenges in buffered I/O operations. The main
> difficulty arises because the extent size (64K) is larger than the page
> size (4K), and our current code base has substantial limitations in handling
> such cases.

What is the limitation exactly?

> 
> Any thoughts on this?

TBH, the buffered IO case has not been considered too much.

The sub-extent zeroing was intended for atomic writes > 1x FSB and we 
only care about DIO there.

Thanks,
John

