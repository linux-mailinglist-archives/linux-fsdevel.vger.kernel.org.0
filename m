Return-Path: <linux-fsdevel+bounces-26895-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D59D95CAA9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 12:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 731FF1C21EE8
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Aug 2024 10:42:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B00316DEA7;
	Fri, 23 Aug 2024 10:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LceRoxas";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="JMt0oLln"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0FE28EA;
	Fri, 23 Aug 2024 10:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724409751; cv=fail; b=tZdPyq7xl5kuUplHAPYqkHTliFT3dd4BdxVQ/hUJdnBW99u3zaJV8ZZ4srT/o4T47uYVN+NNoc7TGmVBeEf5N1gndAJ+sq0wXMI1EHew5IyVd8UAgK0SimhB1+QhHdigqHlTFi3TsPNbua2vlmWMADh9HQZAs0+rW9prcqWvG+I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724409751; c=relaxed/simple;
	bh=HwE4XUB5YJhBXl0okX54HiP+7xsTLMcPxSq35V2IUyc=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Es894Ibrn0iuBxMDp/IoJ8/5r+KdSZOlerPZmSVks2f5+sCEdtRQI2QRPVIDWEvVI6m434DmqYrvEefoXdDk2uW06NmwOvo0SgLpzThxpkV0USZPxA4igJBvrsZekdawQI+z9wYzQLkRSWnukWb+qwsLJrlwvNAntok+CRUZOs8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=LceRoxas; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=JMt0oLln; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47N8BZWt021089;
	Fri, 23 Aug 2024 10:42:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:cc:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=OGF176QX0w+o3cSPuLF+bl988/plkpiDMI5xqeFMdK0=; b=
	LceRoxas/HBVpk0dFJz8UWhv/U0shvVwoxxK6EFXZ69mBb6FEjxNqWFtBmBnujeq
	vVpuOwebnyV+UWstOve5fIeK/zRftt626IguASzWLzRd/2/kLgTGiEXnuzAqzLLC
	U6i52jQoYQFPRLhSxawn/F/CSDnHxzydTrCdcAjsERPQbzzcZOtWvhnjHr8ezehJ
	jVTQbvKKpBmbqTkP6C0Pr1gI/Zng7TPuRsXZTA6qfn6LmAkfgxAdRBjxKhHyYmTZ
	yox/SRlUafdY+4wysP9Q7CXqzwJkgEkpwVguJAnr8uOZe6+EFGN47li5ADU87a1F
	GdFfisAvzYCY68+aP7RL0g==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 412m6gm4fp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 10:42:17 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 47NAJ9FD026448;
	Fri, 23 Aug 2024 10:42:16 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2173.outbound.protection.outlook.com [104.47.56.173])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 416rjm8p9s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 23 Aug 2024 10:42:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qQiY2gBWyDbbQu2dOy4lKBVKWZPIF1Hb4Zw2POtOM1+QsK3pHpBFSQEURjfgMAv3oiCY4wzMErc66iw8zok/FqP/Z54MqwuqAdf9q3XlGIi5WcMVYsG+uT5xzPInmg4yG8aFZDDMF1zYL3ZfrBolEw/hT+AzFP9a0DUJFkgE92x9RxWObji5iRklhcONXQwzmhjdLvbaKKgW/z18lqDYFw3/noQIGYsi4SyL4e6QW4P2wzCMTpl3Y9k8xEbqcVm3Qw7kht/Z/Z9NUQSpjLgJvqknt0OG3mbGJY0pFOmKs+3lS0NxOloPsjsDnSqjqhvHKTbHUZFpHFFMXFw8rsHHkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OGF176QX0w+o3cSPuLF+bl988/plkpiDMI5xqeFMdK0=;
 b=tsZ4y0JbuOcrFLWBPTvtTjY45mTipy92XHKrPjOD5vGaNZxpnfBBmqyR/7ZJ8MlEE6XL+ynNWkPtPKQs8vy+odQ9z3vMkqNJo/0sBnMPWR5hkaYB9a5e8SLoTkN4PAGTt9/DeJKO0RwhDdtTejY/AyzGBPRnWn+wgjy2XlnbPqwZEpC0p21G6JMgcXv/9V5XtorhQvVXqKRmUgrnv5tVlpumvN8GCgpjeyfW/NP3LF8Zli+rysrPKsodV8wkxxsJhBe144FLYHENVe4z/rQq1MkPNw94/VP/MkF7dDTYOKQrV7b/uG11CxrE4ey+UJTiZj46/GQErPIPFBBsdRnT8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGF176QX0w+o3cSPuLF+bl988/plkpiDMI5xqeFMdK0=;
 b=JMt0oLlndPV15r+swugob8F9EyrO/FtRThU37KnjIgIq6bz7RrTUGFooUe7/fPweFZXTezDRYvW6/lCfmX2FbrphHuvMB4nRxhMFYirAVFXYC3wXY+MPuh90XTcgk4Cr7hR8wvawPMvuzFO42OxLtHUaK+F31J7G0crP77qDJiM=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by MW4PR10MB5812.namprd10.prod.outlook.com (2603:10b6:303:18e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.10; Fri, 23 Aug
 2024 10:41:13 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%3]) with mapi id 15.20.7918.006; Fri, 23 Aug 2024
 10:41:13 +0000
Message-ID: <e0a93440-8f38-46e1-a77f-6a0125ab8cb5@oracle.com>
Date: Fri, 23 Aug 2024 11:41:07 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/7] xfs: Support setting FMODE_CAN_ATOMIC_WRITE
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: axboe@kernel.dk, brauner@kernel.org, viro@zeniv.linux.org.uk, jack@suse.cz,
        chandan.babu@oracle.com, dchinner@redhat.com, hch@lst.de,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org, hare@suse.de,
        martin.petersen@oracle.com, catherine.hoang@oracle.com,
        kbusch@kernel.org
References: <20240817094800.776408-1-john.g.garry@oracle.com>
 <20240817094800.776408-8-john.g.garry@oracle.com>
 <20240821171142.GM865349@frogsfrogsfrogs>
 <7c5fdd14-5c59-4292-b4b5-b0d49ba1bce6@oracle.com>
 <20240822204407.GU865349@frogsfrogsfrogs>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240822204407.GU865349@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AS4P191CA0042.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:20b:657::19) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|MW4PR10MB5812:EE_
X-MS-Office365-Filtering-Correlation-Id: d11b38cb-bdbc-439b-caaa-08dcc3601bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0N3M1dic1dWWVVBQ1ZOaFpveFA1UnJ3bTRvQVMvWHlLWEkwRG9ZVTltaVJT?=
 =?utf-8?B?OWdjUUFhUVVSdTVaaW9nTzd3ajJXTGdCb3JqZTZNdFVhNE1OZSsyckN6VTBr?=
 =?utf-8?B?YTF0aitwdG9iUVZwVDE4NzMyTnJaT05VaVg1Mkw3V1BtV21UTTRocXNod2RD?=
 =?utf-8?B?TThLY0pBZitLa1U3R3ZpbitVclpUd0d0MEZJTnNHeGJFU1RmOTBZb2Vsb3Ju?=
 =?utf-8?B?M2FZMWdyNFcwVnI2ayswd1FvQWdwSStZN0V6bjlzcG8wZFBiV2YydGtMR0Nx?=
 =?utf-8?B?alNKOUE2NkZYcFlIS0FGemxGd09VSFhwR2lJczFrS1RQNlNoTEw2Y3haVEVD?=
 =?utf-8?B?Z3ZDTXNKSGdRMFZyYmN5S0xoSUhaMXoyc3VXcG9ubEpRQmRzRm5tejhybzhP?=
 =?utf-8?B?TnlFME1Vcjdib0hXMW5FcktjaGU4SWlUTy9lSFg2dGRLNTh6bUxkcW9wNEsz?=
 =?utf-8?B?K2VjYVora2VGQlRFQmozSkpWZWRSN3dWbGwwZzQvOHE1YjFCTUpZMzhUbHhH?=
 =?utf-8?B?MWtQd0s4RmhPTjFVdTRCOGFoUEx4RVNZM1hHc1pySnZqV0dZTW9uSUo1elg4?=
 =?utf-8?B?V0J0SFM1c2g4OEJqN2puRHAzcHhSQ2FxR3E5WGFXYzZQMEl3cFVZc1paMTd5?=
 =?utf-8?B?VDVLV2lUd09HMEZrSmlRZnhkbVUxNDZPMExaQlRMcS9MQjhqN05tbW5RU25M?=
 =?utf-8?B?TzBrMmtVTXZyZlNFVTVTVWNjS2ZsbGwxZmNmVkxFNi9xTU41OWw0R0dqd1Nu?=
 =?utf-8?B?TEpmSDd0RUtGQkc4MzIyZTlGQWlXRkNkQVdOTFdhS0p2ejZZdEh1aWVPZHVp?=
 =?utf-8?B?K1FienN2QjBvNlRMNGMrcTdXN05nelBaWEZudFdpZ0pCWlJkaE1uRXY3eW1M?=
 =?utf-8?B?Q21MdndHSnVrMC9qUmtzTkZnL09WS1ZuNG1uZTBjbkNWZG5OUkkxTEhEdG9h?=
 =?utf-8?B?ZW9FWllhM0pRZWszejhBZG9oRm1RcCtiMnlNajAvb2xPUCt3UFhSRG9mZjc2?=
 =?utf-8?B?MEZPQVhtR1pRZXM2MU51WkluNWF4U1pQZVJFRmdBRGJiVVltYVh2czI4ZytU?=
 =?utf-8?B?U0hJd3dzOFRuTFM0U3VGb0Q0K2dVMzhJdXBIaFg4TzVINmttYVRhcmhQNVhK?=
 =?utf-8?B?UzFDMmgyR2hMQjhnMnR2Q2U3WXFOYzFzVHoxOFFFMHpVci9BOG9oNDJVcC9w?=
 =?utf-8?B?TDEyTDZtdzR2WEEwVUZrR1UxOHhmU2hTaklKWXF4a201blRLb0ZXUklXY1Jp?=
 =?utf-8?B?alJ3RzlXK2diTUNiOFQrUWpEQ3YxZHFhSGNJaHU2WU5rSzd4Rk1iclg5SUl6?=
 =?utf-8?B?QStxNVFiK0NVZXlhaXVyVStKeVk2S0poK3JpZkhqUTZaV0xML2JwMjNIbkZ3?=
 =?utf-8?B?aEIrY3pzcDBlUE12TW5zWGNLSFZYNWRid1F2YUZiTXVESU4rQ0x6VldaY0NY?=
 =?utf-8?B?UFFuWVRvMUUzL2xHY2pETXNyeWJHUzVFbkhUenRoY0szc2dlaTVoaEIrQ1Bo?=
 =?utf-8?B?SjVFRU80SDQyTFFDeGpPZU9UVXVYWkJwaEI3RUJ6TmE1S1hkdmVEblBHVThV?=
 =?utf-8?B?VXdwbGpxaUwxN05CUm5laE1GVnJodnJYZk0reThVcHMvaUhJQmNrUzZ3N0w3?=
 =?utf-8?B?VTRST0g1eDg2L1NLWHBrRk1HcmlxTkFtV2cwWmlZVk12Y3l2RTI5Ui9mc1l5?=
 =?utf-8?B?SEN0S0Z1dG1zRDBnNnphMFM5MDdJdk51VEpzbGtELzlhbUkvY2MvMkhyeDYv?=
 =?utf-8?B?a0FkSGZTK2N3V1lyWmNVVTh0NEtUSzJOMWZxcUhGYXNXRHRpK1lLNnVOcjBz?=
 =?utf-8?B?Wng2MDl4WFJUamVXVjNadz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VHNaamk2VVI1cWlXTWQvTDAxaXRYdi8wcXBDWXBxTVlkYU5HTEhHTUk2NzlU?=
 =?utf-8?B?UFVsdHkxODFOZDlxNVlvNk80N1dxY3RkSTVOOEROZ1NiYUJNWG5JMXNnMzJY?=
 =?utf-8?B?MjNINmljZStOMEM4bzJURURnSHZZYjdYV2JTQjFnakZUY0ZWZjlORGJvdkpX?=
 =?utf-8?B?RmxvUmxWa0E2K0xrVDVjeElKa1czWjk3NzNrcjhYenFQSzRSOFhSeFg4NTBE?=
 =?utf-8?B?T0xaUC9tV0cwOHVYcW9UbFVKcWNiTVg5SHlWcWdnNkd0L25TQmhsVUllYkRW?=
 =?utf-8?B?VHFkMXZyUWVmRnUxRjZTTHVkSklJc3ZFcTJMQW03Tk5DMFhPSzB5TFQzRS82?=
 =?utf-8?B?NGxiclN5OGNaQmF5R0NVbVNCQ2orRFAyRWNEdlI1SEJqbWxzR0xjODVqNmlq?=
 =?utf-8?B?YXZQbmprSlF2bWJabGFUSHg0OXlTYmxOUHAwRTZxd3hUMk5aWjZVdWJidjNj?=
 =?utf-8?B?Vy9TQmJBbFhMQXNEczF2OWJ0SVdFeTRlam1ZWmZRSjZ0SzgrODlOeEZhbmJV?=
 =?utf-8?B?VlVpQVFvdmtmMHNBM2haYWJEVkF3MGtwb0l5b0hXMGdXZFlSbk5CT0g3MC9q?=
 =?utf-8?B?YUJLcDEvbFlST3ZHeERTS3dKQWw1RkNSTUdiMUcrSStvZncyU25GdjQ2ZjY3?=
 =?utf-8?B?bUM2SmhSM3VWKzV5K0pJR2xVZXc3cWN0eUdEampJOERKbzF6M2dRZUk1dHhG?=
 =?utf-8?B?NWtuczVRZFFubmNzRTYrMjhTSEE3dWV1aGtXekhJYjIxMzhiWU1WVkdLV05o?=
 =?utf-8?B?aFpFaXZCV0xoTW9kZFAreTRhQWhqL2VvWEpSQTRwVWNUQzlEblZkQTFoQlZy?=
 =?utf-8?B?aGZDdlNEendsVkhISjNPd05lMHM2UXVCcEd3Q1BWaWhxYUVwT3M5NWhka3lz?=
 =?utf-8?B?dXVCMGtzaG9qUjFla0ljNjZGVTY4Y3plNE9nS01hRmQxME9oVlFRd1VSZVJm?=
 =?utf-8?B?Y0lKTXZnT2g0K3hiRkFqb3VuUVFLWk9lcU9Id3loeUJFblJ0cVpBdWRMSmVC?=
 =?utf-8?B?N1JIVnZoUkJSU3VrTUFSZ01MajlHbXY4cUZLQWNMamtzYVVndkM0S0xtR3pD?=
 =?utf-8?B?OGNIZ0h3aVhQU3ZGcFp6KzkwK0hsd05HVTBSd0N2dXRrRWdwc0xFSUN1elI0?=
 =?utf-8?B?MndOR2tMMkN5cXdTQUtwQ3dITm4xY0FIYytrZVdVSTgyZnBZTGdRUVNJOW91?=
 =?utf-8?B?d08rZGN6M2RkQUJxMzB2ak53cmVGNEw0eHM5dW4xMnVQQ0o5MEpzWS82RWVw?=
 =?utf-8?B?cUU2OHFnL0JPYU0zcVZKSStpQkVxTmhUR2xna01yM0l2Y25pa0hzQWFEVHo0?=
 =?utf-8?B?M3ozbkFjS1MvalFNd1RzRVplNHkvSWVrL1F0bmxYY3hXNmxFM2hjVWhmaDgv?=
 =?utf-8?B?ZUpUSlFEZEhDQWJ2SEcxbGVlenRJd0wvNEYreDlCSHNkNjJjSCtsYS83cWYv?=
 =?utf-8?B?Skl3djBMelRzOFEwSktJaDhvYlk5S1VPN2ZMcjhlV0FPdnhKYXRFSDRVZU03?=
 =?utf-8?B?R3lKS2ZZQTl1OTg0K1h1WXh4a2VOYjFhdDE1akZ1TVAwdFI1VisydnhtcG5J?=
 =?utf-8?B?dzlCbi9rblk3K0dpdG5rSjFLZSs0SG1oT2Y4L0ovN3plemVIRmszUFhCOG9h?=
 =?utf-8?B?WEtZenY0d1BKVTFjL2tzV2RJamRObUt3aytqTzNIT0xhU3haOHVHRFhXb0hT?=
 =?utf-8?B?eUNuT2Rjdnl1QWo3R2VEZ1hpMCtBNXQzdHo0R0FZWkxwMjFtelF2M2lMaGR3?=
 =?utf-8?B?bk1jVHJDYVQyRmRGUjhDeFVxeUkvV256R0JNdkNqendWTjdSQ25qNFpBT3ZR?=
 =?utf-8?B?NWVzdUZDWUZjUkhsdXN6YjU5MVQxakVTa0FDaXBYY1gzQldMa2dxeWkzUGx4?=
 =?utf-8?B?UUlndjlTY0N4bmZ2cmJEN1Awa2ZqdllvY1NDb29PeTh6YlU1N0hmcklDZE1U?=
 =?utf-8?B?b2RGNmJrWXV6dWE5Nzl6MjBqdUtJUjR6N1pnSEFscDFRakV1M2F6UzlNeXJ5?=
 =?utf-8?B?eFYxRnV0V0F5Y0hLVjhmRExmVWZsOWlRcFJpZkpYQjAvL1BzYWtOR2Ywb2Fi?=
 =?utf-8?B?eU9ZMm81a01ENldxb3FucHV1R1ZhMW94SkJNdVhkbVJwN3pIQU1Od0pDby9m?=
 =?utf-8?B?ajdUVzgwcTVaTHd0c2RzWmxjSVU1Y29iT0NYVlVaTzRjcERKTXovQmZjSkc2?=
 =?utf-8?B?Z3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	wJtEpsxfmCgOu7fX7Iz1j2fv1gXhhRke+LSpArHsGJF4jQxVr7XIu9VDPCscSGoYXQL7KFfahdUMo8FcLsZVhxN608kx2BRQX693PxCjh8pr75OkNAm5XmaJHA4TJWJ5CvBiIDOrjDz20TIbeLJnP+QXGtGy/NqeM5dpdxGguMu13IocyuE80xH9X/Kf4TA8K7Yrbp8pr7r+eMzf+sQF16pepwDqHgT51CrlLfqdTgOcNWT9ZfS53uobVP0KGqF/u2JPUmfa01l9Xrx5RR9Cd6raGztSy0QurYBeQJ45pWKAmtpAbsS6SPon4gW9qWhfIfgTOZ0O8sCIqQttv3y0oxgQUG1sHafT/0vb28Ei2Idu7E4N3NM5zmZ3AEdzbkmhjEJOrWIfjpcO4BBz5vALJ2VNmBBxeDrMXJ065k+9m2JqZJYqsD08Mb0I1eOweIR4jOtH7x0ufhC6f9ArojLi+ATfMjr6iyG2KvKgXeeGyROnLXPGON4AM/+7sbfc9DjoXbPwql8fWb1Bcva1PKHaHfqBa+G7TXp8+F2MD6MaHjKsNs4Gd8xyMHIzSHKKJNhzS0hAb2U2daxYEij0Ofu6cjDZbcrQH8+YtC92fVdb3r8=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d11b38cb-bdbc-439b-caaa-08dcc3601bd3
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2024 10:41:13.3429
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j2xyDXw/QV24kIPQ6JfABhWQ1SVfVw9bdumwEI9Ws3XwQTjd/VfQ8HHCUl0GaxJ7tPRO1LArpOcxVQTgdopVAg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR10MB5812
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-23_08,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 malwarescore=0 phishscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2407110000 definitions=main-2408230078
X-Proofpoint-ORIG-GUID: iqneodJqkLhnwxYPg8QnsxjACWUZpqUh
X-Proofpoint-GUID: iqneodJqkLhnwxYPg8QnsxjACWUZpqUh

On 22/08/2024 21:44, Darrick J. Wong wrote:
>> Do you mean that add a new member to xfs_inode to record this? If yes, it
>> sounds ok, but we need to maintain consistency (of that member) whenever
>> anything which can affect it changes, which is always a bit painful.
> I actually meant something more like:
> 
> static bool
> xfs_file_open_can_atomicwrite(
> 	struct file		*file,
> 	struct inode		*inode)
> {
> 	struct xfs_inode	*ip = XFS_I(inode);
> 	struct xfs_mount	*mp = ip->i_mount;
> 	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);
> 
> 	if (!(file->f_flags & O_DIRECT))
> 		return false;
> 	if (!xfs_inode_has_atomicwrites(ip))
> 		return false;
> 	if (mp->m_dalign && (mp->m_dalign % ip->i_extsize))
> 		return false;
> 	if (mp->m_swidth && (mp->m_swidth % ip->i_extsize))
> 		return false;
> 	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
> 		return false;
> 	if (xfs_inode_alloc_unitsize(ip) > target->bt_bdev_awu_max)
> 		return false;
> 	return true;
> }

ok, but we should probably factor out some duplicated code with helpers, 
like:

bool xfs_validate_atomicwrites_extsize(struct xfs_mount *mp, uint32_t 
extsize)
{
	if (!is_power_of_2(extsize))
		return false;

	/* Required to guarantee data block alignment */
	if (mp->m_sb.sb_agblocks % extsize)
		return false;

	/* Requires stripe unit+width be a multiple of extsize */
	if (mp->m_dalign && (mp->m_dalign % extsize))
		return false;

	if (mp->m_swidth && (mp->m_swidth % extsize))
		return false;

	return true;
}


bool xfs_inode_has_atomicwrites(struct xfs_inode *ip)
{
	struct xfs_mount	*mp = ip->i_mount;
	struct xfs_buftarg	*target = xfs_inode_buftarg(ip);

	if (!(ip->i_diflags2 & XFS_DIFLAG2_ATOMICWRITES))
		return false;
	if (!xfs_validate_atomicwrites_extsize(mp, ip->i_extsize))
		return false;
	if (mp->m_sb.sb_blocksize < target->bt_bdev_awu_min)
		return false;
	if (xfs_inode_alloc_unitsize(ip) > target->bt_bdev_awu_max)
		return false;
	return true;
}


static bool xfs_file_open_can_atomicwrite(
	struct inode		*inode,
	struct file		*file)
{
	struct xfs_inode	*ip = XFS_I(inode);

	if (!(file->f_flags & O_DIRECT))
		return false;
	return xfs_inode_has_atomicwrites(ip);
}

Those helpers can be re-used in xfs_inode_validate_atomicwrites() and 
xfs_ioctl_setattr_atomicwrites().


John


