Return-Path: <linux-fsdevel+bounces-49008-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 77C0AAB7750
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 22:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F247865858
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 May 2025 20:49:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8408529670A;
	Wed, 14 May 2025 20:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YdoC66f8";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sNQ73/2V"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A96E55B;
	Wed, 14 May 2025 20:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747255752; cv=fail; b=mlBZCmsUHR8HF/YRnvxxN7xf4stqv7viJhEJPopBvsw3LmH61uAo+SD1zuS25S6YyFVoEykI6GkOeYjlSeLST0wynzxM+pft+Pw1q26nMx0ykh/N0oj81IO4QZqC4Lh3TXY4z7yquftb3cqhX8Nk6RnEJO5J9VK8+D4DsUgMtKY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747255752; c=relaxed/simple;
	bh=T4QtfX+fuhuRK5dmEQAQglnRgbq390lUKiGhRfRRg9o=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Xbog8M2b7rsCaJfSPJH7ftpqTyOAM8OmBNeXXrXKfuTYW9lPp2v9ahDlnIItdv/a6xd0HrGNvucAOpPaHaOvXec/A70in3pw0PuCs/2tdzJzU/TaBCXzfI73XTlS6xkLsc6lRumDwP1F3jtC1xMwKe64zD/8VuLgi45YlMG7uP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YdoC66f8; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sNQ73/2V; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54EJgrsX013297;
	Wed, 14 May 2025 20:47:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=W9Vc0EsaK49hbWTL+FkVY2oOiL6/MbwQ1+GB2WbmflU=; b=
	YdoC66f80qpqEwZtUFvCCreQdMWupx4gxdJViuYeyyIYnAhejETKqbnL8i7UzUGn
	pnk+KxlbQOQIt1XdWDfuJKI/HPoNwfrbU+r4gLyPXO8SUQPh62H6cbrVFJPONTiY
	7pJSNhQZjzqIYOZnEIQblruwveM7Oa4usure93o8hhxwSNZkIWKRG+1SXD7RAdia
	vlFGNOVE+CfL4Pu3c+FhQuk3HWELR2XhG8VYYRXEovKLsoYMHLrfKcjLE3uYYkUe
	CNnKVpP9EvGHcy3K1HvUG8DTRdzAN6s0cAjKmWapy3YXydsKvkUcK0J8UU/1Vqly
	xJkAiT1k2NcU5cM9D8VzCQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 46mbcrjqqd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 20:47:56 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 54EKeU9r026719;
	Wed, 14 May 2025 20:47:55 GMT
Received: from cy4pr02cu008.outbound.protection.outlook.com (mail-westcentralusazlp17011027.outbound.protection.outlook.com [40.93.6.27])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 46mbt8gmgg-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 20:47:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijYEFNEVfNM5cTY7ROYq2NDDor3n0fw2g2wXOOZ0oUv02ghIb1wbe6xM5Q2lXvx2jCExBRx4Rg/GBkfuVcBjZ64Bl89lnWqGEdKzyDF8F7LxTOJy+5NdPN3eRKs50T9+/u4fs5MxWVXmbvSxYIPKVbHzvVe9UjhkdbeoqciNmh1Ky/nlZh4wezpOBj4ZWQN5Sx9fg9YtLwUlJpn0/D0sL+J5iSk25Rf4DJwwUe/jU9lnQ2FdRK1xV76xrp6ZOyXfRJDu+qSNaSaPgyCE3zmQI6GFNCtRIKff3m7AJoxrXjG/BHkUgLJEHBZo8NjAJqIbpH0qFcJcT0VfXshcy7t0dA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9Vc0EsaK49hbWTL+FkVY2oOiL6/MbwQ1+GB2WbmflU=;
 b=mkucmheVG9mQkOwq/Ik+rw8r2rCIVb1o3pguWzppBk37ZlIBggm6f/LBSaJjdTk51TFA/ckzFmSAmoqPUAXSeY+dSt2R44+tU7+ya8XRYml/o6+EZsmb6coyXCdXQDKNPent1QJxI1N4JIi4Nz8D6QQFtintpkjCQdEXvZspwmxG1VHfI6mkaehON7F6xvB9OBVaffX5Vyey+7F8WM0t5HOJtYfIejZ5cF6UuhEhxXKSxfILH/eHTHaB+LIl55r4clYie7Qfx6WKoZT9r2bVbf5xNGhLmQ5pVhW3n0YGPdm6b+wxjEd1T0LhhJILRxa7M2JY8HoytPFAe/m4SN2LAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9Vc0EsaK49hbWTL+FkVY2oOiL6/MbwQ1+GB2WbmflU=;
 b=sNQ73/2Vw03tyu90Cv98Nq9pB6n64GYxvoqiW3YS+11aSJYH6VBSxH2slQRxcNsYGB2n4qDULL7Qkndxl0ZYNT/2X/I2j0tGoAITMCaCy4Oxo6d307eftOQzW2lkFzULm5AF6xJqkIQd/NybE3dD5XUgFcl2FfSAGP8+D2G0EUs=
Received: from DS7PR10MB5328.namprd10.prod.outlook.com (2603:10b6:5:3a6::12)
 by SA1PR10MB6592.namprd10.prod.outlook.com (2603:10b6:806:2be::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.30; Wed, 14 May
 2025 20:47:50 +0000
Received: from DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c]) by DS7PR10MB5328.namprd10.prod.outlook.com
 ([fe80::ea13:c6c1:9956:b29c%2]) with mapi id 15.20.8699.022; Wed, 14 May 2025
 20:47:49 +0000
Message-ID: <5737f735-55c2-4146-87eb-c59f25517c63@oracle.com>
Date: Thu, 15 May 2025 02:17:27 +0530
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15 02/43] dept: implement DEPT(DEPendency Tracker)
To: Byungchul Park <byungchul@sk.com>, linux-kernel@vger.kernel.org
Cc: kernel_team@skhynix.com, torvalds@linux-foundation.org,
        damien.lemoal@opensource.wdc.com, linux-ide@vger.kernel.org,
        adilger.kernel@dilger.ca, linux-ext4@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, will@kernel.org, tglx@linutronix.de,
        rostedt@goodmis.org, joel@joelfernandes.org, sashal@kernel.org,
        daniel.vetter@ffwll.ch, duyuyang@gmail.com, johannes.berg@intel.com,
        tj@kernel.org, tytso@mit.edu, willy@infradead.org, david@fromorbit.com,
        amir73il@gmail.com, gregkh@linuxfoundation.org, kernel-team@lge.com,
        linux-mm@kvack.org, akpm@linux-foundation.org, mhocko@kernel.org,
        minchan@kernel.org, hannes@cmpxchg.org, vdavydov.dev@gmail.com,
        sj@kernel.org, jglisse@redhat.com, dennis@kernel.org, cl@linux.com,
        penberg@kernel.org, rientjes@google.com, vbabka@suse.cz,
        ngupta@vflare.org, linux-block@vger.kernel.org, josef@toxicpanda.com,
        linux-fsdevel@vger.kernel.org, jack@suse.cz, jlayton@kernel.org,
        dan.j.williams@intel.com, hch@infradead.org, djwong@kernel.org,
        dri-devel@lists.freedesktop.org, rodrigosiqueiramelo@gmail.com,
        melissa.srw@gmail.com, hamohammed.sa@gmail.com, harry.yoo@oracle.com,
        chris.p.wilson@intel.com, gwan-gyeong.mun@intel.com,
        max.byungchul.park@gmail.com, boqun.feng@gmail.com, longman@redhat.com,
        yskelg@gmail.com, yunseong.kim@ericsson.com, yeoreum.yun@arm.com,
        netdev@vger.kernel.org, matthew.brost@intel.com, her0gyugyu@gmail.com
References: <20250513100730.12664-1-byungchul@sk.com>
 <20250513100730.12664-3-byungchul@sk.com>
Content-Language: en-US
From: ALOK TIWARI <alok.a.tiwari@oracle.com>
In-Reply-To: <20250513100730.12664-3-byungchul@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI1PR02CA0013.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::7) To DS7PR10MB5328.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::12)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5328:EE_|SA1PR10MB6592:EE_
X-MS-Office365-Filtering-Correlation-Id: a74d53da-4abf-479c-55c2-08dd932896c9
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7416014;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?eUVCMWpBaDZ0M2lyVXhzQnRXRWNzRVBHa0o3bjIxWTMvQm1tNTRpOSt4Zjcx?=
 =?utf-8?B?SkU2Sm1lMk5HZDVkeDY0WmNIeGF6U3RKVktkbjhuZUdsanhySWVUTzhEemtQ?=
 =?utf-8?B?NTZlWUQ0OUJWcFdNUlNnd2NmSWpNak1ha291QkJPTWV2VTlRUE9vaHRhOHc5?=
 =?utf-8?B?MitkYVp1YTVqK1BFbGRMbnAxTldpZ092N2RvWkNHSFZSc01iM2JCOWk0Y2Q2?=
 =?utf-8?B?YmVuUEE4TEx6S0dnd2ErVWR1bXgzVGV4RVV4aWh2TzhsYk9VSjRYVHZ2VXRi?=
 =?utf-8?B?eGpsRVhCZksrcTl2YnNiRER5UzlvR3NyOW1MWjhYNlRGVjFCdVVIZXdaNjhT?=
 =?utf-8?B?VmNSK0xraXE1aEhmM1hyYWc1RmhIR3NZSmFhN21oSFo5eE8rSFJTalN1dXAx?=
 =?utf-8?B?dng0OERQeW1uSk9qVzNlK3R3MWp0WW9CeExZTVQ2S1JJLzNpSnl0VkZrNWJ6?=
 =?utf-8?B?TTQzZnFzMjJrandXU2dCeXhtSUVaMUZaSjhJT3pnNWNUY1pHNXZaWEhZYUFB?=
 =?utf-8?B?TkRsajlKSHhUN0VNYWlzeFVOSDNrbm5MRmoyR1JLWGtXdjFOU1YvellTRTZT?=
 =?utf-8?B?WE0wSGF6ZE5xUk05RWJhTU9Qb2cxRHFDVDR1UnF5dGVXZWR6UTdKZHJCQlYx?=
 =?utf-8?B?ZmQyM0JSNFZTTW5Vb1FBcWxRckJBT0NtaU53VGtmb3RjNzI3NHlGREhYeWQz?=
 =?utf-8?B?am1YNUdEdk56Qi9lYXlORjI5eFlWU1hQMFVBbkdhc3VmZEJBTGZ6Rk8xa21q?=
 =?utf-8?B?dEpzTGIvNVBud1ZNVWRLcnd1ajhjUERDKzdxZTh0VGlvNFhMRUVVd0pxTmxu?=
 =?utf-8?B?RjRVSWZ2c1kzNXlFNjVqQkQ1b0N3OFhqR2ZPSlEzVWlGZVZuS3JYa2pkUTlr?=
 =?utf-8?B?U3FyWGtWQnkwbE9ZUWFmZWFzVDh6RUZFd2ZaVVNQa3pjTzNoYUZUSUV3WW51?=
 =?utf-8?B?S1hneDhQZ2oyditKNkJQZ28vMzhpcTZBMkNoRkVaaEZJeXZ0aVh3d21BRXNj?=
 =?utf-8?B?QUcxaTJaVStaNm9ValZYV1RycVRBSFd3RzRjdERwZWt0T3NpL2ZzaHczczcv?=
 =?utf-8?B?Um01WWwzRXU3cGY3KzZlREI3VEF4MjkyS3VxdXVGNC94NUFJNFdHSXhSd1RF?=
 =?utf-8?B?b0tZZnl6R3ZHRVdyWmtxRTBoYzBqME96UFZCNWJVaERENmRzOHIycURncXly?=
 =?utf-8?B?L0hmdkM5ME5EQVdxOUFrejdyZGVhcXFNdU9KRDB3ckVrY1BUekIvZEx3RkJr?=
 =?utf-8?B?WElscm9mK0xJVmpQc3RCRitZaTZQSEduMDd2WUUxbHpoREtHUHlUaWh5STIv?=
 =?utf-8?B?MUFKRGZYRHhlazB3S1ZORmYxTFI0QlQwN2RNNTBUbG8yTjg4aDNRS3VkK0x0?=
 =?utf-8?B?R05TKzJ1VmpMaE9vYXdBR2pMNzJkY2NwdVpYYzhCSkk0aXh4SmtjZ1VGTWdY?=
 =?utf-8?B?MzBOUDRsNDV2Z1dkRnBZRFByblI2YXM5d3R0SFl2aTMzKzJQa09XYmxQM1Qv?=
 =?utf-8?B?VTQ1czZNVTU5czg0N2VlRWRvM3lxdUYwWFhUQ3RZSnM4bHZIaFVudlV2Y1BN?=
 =?utf-8?B?UnNRSktoVlJ0NU54VzdSTnN1NTJkcHljd0JXUVBrOVJLZ2NHUnRNK0w3TGRG?=
 =?utf-8?B?d1hTNStJaHpuVENMK0xQamM2dXYra1hjRWptdGtScTIvM2hJY2haRThLVkpn?=
 =?utf-8?B?UkN5M0tieXVDUEsyRDJQSk5IUThqNGVHZ2lWSmdONlphV0NFbEt0VjFJSGsr?=
 =?utf-8?B?T2VkSUVWUmdEODdvaGJsTEs3aFdOeUw3ZHlMVGdBNlBjRzRkbGdOZzhzSEJD?=
 =?utf-8?B?V0hvMjUxMEtiRFRxNUx2QmxYeWw0enE0SVpjUkhWUXdJWUlFbDlkTTdaOVhm?=
 =?utf-8?B?VXNWRHN1bzF1bzJ4VllPd2RlTWYwY2crSVBiNHJaNnl0c1UraDU2NVhNc3Yy?=
 =?utf-8?Q?P17fl1SrNIQ=3D?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5328.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?U3JlbEpaSm9WTHdyS0lycHZuZ0tEbzl3SkR1QjJ3TXc5Z1hRTmpXbWU0M29n?=
 =?utf-8?B?cG5yT01xMTU3Ly9mckpsYmRJcHZ2MEE4NkM5UnpSV2tGK3JzbmtUczBwaTRZ?=
 =?utf-8?B?QlNHZzNvdWNEVUpSOW9QSlI2ZEsxaUo2TzJac2hYVFFaejlpZlMwNFJuVUFF?=
 =?utf-8?B?d0hJc1AxTXpoaDVBOFFUNXpReEkrVzAzOTlXS1p0MFpHREE4REFLTE9lL2Vi?=
 =?utf-8?B?c0J4M2M2azk3alF5alJoMzFMeHJCa3Y1UXlYV0lCSFRzc3VQbUlyTVFFYk9V?=
 =?utf-8?B?ZE1palllbElRbFRZYUhKZ3lYZ2hOcUREYktwYVN3UUVWZ29INy9Qa0tBNVRK?=
 =?utf-8?B?Y0FwSmdZaGJrOXZkUlNPcUdPMXNTWktML1lnOC83eWZua0xFaDNxbTZGUFo0?=
 =?utf-8?B?SVRxOUtXUDU2eE5lSG5EMFNoUFM3dnp4QjhYV3RWSlVMOHBpd3NJU2pmOHkz?=
 =?utf-8?B?VTVoQnhtTmViTHJyN1U3UXBqYW5hTkVDa1FMNVVoZXBqS3lUWlpqVHh4NG5G?=
 =?utf-8?B?aDFNRmQ2NFRldlZvY1hqSVh3K0ZLOWFFcG1qelUvbjZFT2dBR25pRkQzV1BY?=
 =?utf-8?B?dHZuNXBoNGErNExVMEltYi9YR1RuRmNROEkwRVovZlU0UmY2RUduM05qZU1j?=
 =?utf-8?B?dHNBdVp3aWdkUVVnd1p4dVRTWXhOZFBabUlqcEdXcXVmK3pXTnREbUIyR3A0?=
 =?utf-8?B?N3hNRDRoM2xkdmFFZ3hPeDltamU0bzlaMk01bnd1U1ZTdWhMWFhVZkxnNGZJ?=
 =?utf-8?B?dGtYbTVuL3FsTXVkMXB5TFUyWGcvbWVtTnNsYTNIVWoySmtvckxLY0FoRTln?=
 =?utf-8?B?NTluUUtHcGUrUXBhY0ZWaStyUXJ0ZTRaR2huSjVQMGExNXRURktkRmpFbGN5?=
 =?utf-8?B?amM2cEgxczB1YnhOeG1uR0xaYThqNUNiTjE1bmpPVHZGUi9xQWczS05GMjNT?=
 =?utf-8?B?MnJocHNnUkh5VzE4WUJVUUhIVkxMUGdMQ1Y0eHA5TVVkRUd0b1VFa1gwdWZp?=
 =?utf-8?B?Mmh1bFZvS3BkbTcyUVhwMEtqS1NSNDEzTTJNVE5hVFNyRXVMdzJlZW1IQUt0?=
 =?utf-8?B?R2NHU09UQTJQbHhhTVB2U3BTK2lWVmROOUNCeXRzZGdzMld6bjJYYjE0VzIr?=
 =?utf-8?B?YU1PKzc3aW1MTWVJcnFoVE1MUkgwYzg0WUplejl4MjFwRy9UL2Y4QjFMYUF2?=
 =?utf-8?B?RGQxd1grVko1ODg1UUQ1Mkl2TzUwQ2NNaWxRNWlLc21JdFNtMkhmeExEU2pM?=
 =?utf-8?B?LzNYTkpKVjJRUll6M05JSVRzYktRQ1JyLzllVjhBT3FhRUpCSldUL0tjaG16?=
 =?utf-8?B?NHdBek1iVGhoek1LSTl3dGJlV3hJT2ZXaUlWOHpCWVJoRWtObGo3TG94MG5x?=
 =?utf-8?B?Q3ljRVMzVTIyVmYvOXYzNHpTYlltenp2NGZDeWNTVlZmMmpJcGV0cm5RT3Fi?=
 =?utf-8?B?N25rcVFPcXlacHRTaVhad3Y2WmFrZVFLcWRHVzBMMjgrWlVrcmZ4MEhZZVl6?=
 =?utf-8?B?REU0NVZnN2pqR0cyVGpVYlNsdi82NHlXVlFlenA1RTdqL2NDbE9IN0JJcmw3?=
 =?utf-8?B?VTViSDNNSy9nQkJKRU5RT2JFOFpPM0d6WUhBbTJYTHA4b0VZZlpsWHc3MUZV?=
 =?utf-8?B?RlB4UlB3RFZPTFhqNEZHTXhRVUpuVUp3L0xSQ0l0Wk40UVNaNnBYV25zZ1JW?=
 =?utf-8?B?cThldzhxamNaOXlJdm5mbjlpemdPOGNvcVgrcjc0U29hcTB4UExqSTJ6ZnN4?=
 =?utf-8?B?eUFlck5zSlIzNzkvU25JK3RiOTNEaDEvNXJVdlgrQU51WTQxN0puQlo0ZFBw?=
 =?utf-8?B?VjRXWU1keGphQTVWQXhPLzAxek1YaTY5bURWKzh1UG5UZVBVcnpNT3UyUHBm?=
 =?utf-8?B?bnJXWXpTZmQ5NWg2cXFPV1hrcFIvQmx0YVR3YVVKeDZWMi9keU1ZbnM1MVU0?=
 =?utf-8?B?UzdTL1p4NDZPcExpemEveGJuVmlsMlJFQ3c0YzA2VXBkMDRzSjlQQWY3MHFL?=
 =?utf-8?B?OXNlWUNEUXVrUk40WlRoMjRCRzFKdnFRZ215ZTBkcjl4QkwrazFIT1hiaUc0?=
 =?utf-8?B?dFU4dnpMQzR6V1lpbjlILzlROFFwQllaVFk5djdZb24wVGxuL2VpaytlR1Q5?=
 =?utf-8?B?dGptTEJuMjhlaGRqWUtZYzNnQWZUdmQzSHJHcGRyTVo0VjBFMWxzazJ2bjlt?=
 =?utf-8?B?clE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	50jfNm+m1PxfFxxEUODTtmb2FqeN4qvQnLCRFrn4SVLy3ZtOTwYWwu84cBaTwAlxFGUoLOP4Dkw4EnnsLEWtAr6m49aLDLphJf1hutyNs8t9D+e/xr6/jjOiiTSSTs1o0oFfKRwKLh9Eosk4DFfmBc5uuo6hmW4wdyUqBV7S6s2uEiJdOgy1q6vcgIpolDPeKw7eQN+8C2B6AVo4i5ZV3agdRqniHAZENd2WAP4A53t4r3lyL3pKKnxhxZ1Kk2rxknthxIIJ+gxtGjtBUPW+LvdgVyJlF2Ld1jCpbIrrnoL9mHN8goZ98nxQcYotX5LvV2aYJMk+f3pYFJ9QBiTRor4XGteeFbXl1ffq75JKW+0IF6SkP6XvrvfGz9mU9K1Vc9RcVRSOFNgPmr2y3jlI4lOwOIvC0zTF74WG/09BPbIelfDjVsgQQpXfBByg+suG7tSkwU1O7LCoodbpeUjC3l62WW2161xLDRWgLwI6VcG6DOLzK1BlITwgtUI6HsYuzcUfZIBh3yCOU0hT2hylOcDWD1ERo41wfaYFzCbyjjsFCpJehhCZ/nV+YUDkGhDMH9m/LiOGoFyxFJyRl2DqSqDNNJuTw//OMptTqvuTDvI=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a74d53da-4abf-479c-55c2-08dd932896c9
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5328.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 20:47:49.7903
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S13HftiYsL2wVBW8IQgBs85oK3Ryud1dvU/8q6zIRV2xiGfsHRUoZyihBJGzofZm5o7TfKT9uQ2Mm9QXfyaAj0H3XoxZhign0roDuvMf7ls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6592
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505070000 definitions=main-2505140191
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE0MDE5MSBTYWx0ZWRfX1U8y8RScEjzm 8s96huW6HqeFJF3KlDBglNoHM/Bw4h2+KobgblhgVwcOnZsVJV81DRYfXSAWx/eV5q17k5dFCbw mGgj41iUXhnfIZvSAohxMqTjxzz/vkaXjPF3EFk5+pipDYB8ZZPQdvJPyyxu5SwBqnFewII3oqJ
 oerQVFKIrDS7xwiaTu+64SvVJjZn5v83lewDQhJjwth6gFgqZvLFysOOmJBi4ScZ4VIZh6DKnjY iHXpbecAjQWCcJlXTUQa6RoG/S4JCJh4Jnfy5TmiZl9rD9s3Zgav8IEyGN05g3JzXmD9tfjVUZJ gptnOI0EgtRfsUCK9ALcIUPwiy2cBFBZAoAUQ9vZwHzIjvHXkOIbXrMTeWM41NTnnhyda/E9xDP
 tjeemMMwXOUAZ3olcGK6GH83qcIlonwY/SC+T8aXoqZjljghGT2YFelrQsAyNjA0cVbO6i9U
X-Proofpoint-GUID: bDJfFBZ99BZhO5Zr_fEu8lz-wbsKTqik
X-Proofpoint-ORIG-GUID: bDJfFBZ99BZhO5Zr_fEu8lz-wbsKTqik
X-Authority-Analysis: v=2.4 cv=cuWbk04i c=1 sm=1 tr=0 ts=6825017c b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=GoEa3M9JfhUA:10 a=pGLkceISAAAA:8 a=fMlQ-z-2Nm90nbUFZnUA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14694



> + * DEPT(DEPendency Tracker) - Runtime dependency tracker
> + *
> + * Started by Byungchul Park <max.byungchul.park@gmail.com>:
> + *
> + *  Copyright (c) 2020 LG Electronics, Inc., Byungchul Park
> + *
> + * DEPT provides a general way to detect deadlock possibility in runtime
> + * and the interest is not limited to typical lock but to every
> + * syncronization primitives.

detect deadlock possibility in runtime -> detect potential deadlocks at 
runtime
syncronization -> synchronization

> + *
> + * The following ideas were borrowed from LOCKDEP:
> + *
> + *    1) Use a graph to track relationship between classes.
> + *    2) Prevent performance regression using hash.
> + *
> + * The following items were enhanced from LOCKDEP:
> + *
> + *    1) Cover more deadlock cases.
> + *    2) Allow muliple reports.

muliple

> + *
> + * TODO: Both LOCKDEP and DEPT should co-exist until DEPT is considered
> + * stable. Then the dependency check routine should be replaced with
> + * DEPT after. It should finally look like:
> + *
> + *
> + *
> + * As is:
> + *
> + *    LOCKDEP
> + *    +-----------------------------------------+
> + *    | Lock usage correctness check            | <-> locks
> + *    |                                         |
> + *    |                                         |
> + *    | +-------------------------------------+ |
> + *    | | Dependency check                    | |
> + *    | | (by tracking lock acquisition order)| |
> + *    | +-------------------------------------+ |
> + *    |                                         |
> + *    +-----------------------------------------+
> + *
> + *    DEPT
> + *    +-----------------------------------------+
> + *    | Dependency check                        | <-> waits/events
> + *    | (by tracking wait and event context)    |
> + *    +-----------------------------------------+
> + *
> + *
> + *
> + * To be:
> + *
> + *    LOCKDEP
> + *    +-----------------------------------------+
> + *    | Lock usage correctness check            | <-> locks
> + *    |                                         |
> + *    |                                         |
> + *    |       (Request dependency check)        |
> + *    |                    T                    |
> + *    +--------------------|--------------------+
> + *                         |
> + *    DEPT                 V
> + *    +-----------------------------------------+
> + *    | Dependency check                        | <-> waits/events
> + *    | (by tracking wait and event context)    |
> + *    +-----------------------------------------+
> + */
> +
> +#include <linux/sched.h>
> +#include <linux/stacktrace.h>
> +#include <linux/spinlock.h>
> +#include <linux/kallsyms.h>
> +#include <linux/hash.h>
> +#include <linux/dept.h>
> +#include <linux/utsname.h>
> +#include <linux/kernel.h>
> +
> +static int dept_stop;
> +static int dept_per_cpu_ready;
> +
> +static inline struct dept_task *dept_task(void)
> +{
> +	return &current->dept_task;
> +}
> +
> +#define DEPT_READY_WARN (!oops_in_progress && !dept_task()->in_warning)
> +
> +/*
> + * Make all operations using DEPT_WARN_ON() fail on oops_in_progress and
> + * prevent warning message.
> + */
> +#define DEPT_WARN_ON_ONCE(c)						\
> +	({								\
> +		int __ret = !!(c);					\
> +									\
> +		if (likely(DEPT_READY_WARN)) {				\
> +			++dept_task()->in_warning;			\
> +			WARN_ONCE(c, "DEPT_WARN_ON_ONCE: " #c);		\
> +			--dept_task()->in_warning;			\
> +		}							\
> +		__ret;							\
> +	})
> +
> +#define DEPT_WARN_ONCE(s...)						\
> +	({								\
> +		if (likely(DEPT_READY_WARN)) {				\
> +			++dept_task()->in_warning;			\
> +			WARN_ONCE(1, "DEPT_WARN_ONCE: " s);		\
> +			--dept_task()->in_warning;			\
> +		}							\
> +	})
> +
> +#define DEPT_WARN_ON(c)							\
> +	({								\
> +		int __ret = !!(c);					\
> +									\
> +		if (likely(DEPT_READY_WARN)) {				\
> +			++dept_task()->in_warning;			\
> +			WARN(c, "DEPT_WARN_ON: " #c);			\
> +			--dept_task()->in_warning;			\
> +		}							\
> +		__ret;							\
> +	})
> +
> +#define DEPT_WARN(s...)							\
> +	({								\
> +		if (likely(DEPT_READY_WARN)) {				\
> +			++dept_task()->in_warning;			\
> +			WARN(1, "DEPT_WARN: " s);			\
> +			--dept_task()->in_warning;			\
> +		}							\
> +	})
> +
> +#define DEPT_STOP(s...)							\
> +	({								\
> +		WRITE_ONCE(dept_stop, 1);				\
> +		if (likely(DEPT_READY_WARN)) {				\
> +			++dept_task()->in_warning;			\
> +			WARN(1, "DEPT_STOP: " s);			\
> +			--dept_task()->in_warning;			\
> +		}							\
> +	})
> +
> +#define DEPT_INFO_ONCE(s...) pr_warn_once("DEPT_INFO_ONCE: " s)
> +
> +static arch_spinlock_t dept_spin = (arch_spinlock_t)__ARCH_SPIN_LOCK_UNLOCKED;
> +
> +/*
> + * DEPT internal engine should be careful in using outside functions
> + * e.g. printk at reporting since that kind of usage might cause
> + * untrackable deadlock.
> + */

"be careful" -> "be cautious"

> +static atomic_t dept_outworld = ATOMIC_INIT(0);
> +
> +static void dept_outworld_enter(void)
> +{
> +	atomic_inc(&dept_outworld);
> +}
> +
> +static void dept_outworld_exit(void)
> +{
> +	atomic_dec(&dept_outworld);
> +}
> +
> +static bool dept_outworld_entered(void)
> +{
> +	return atomic_read(&dept_outworld);
> +}
> +
> +static bool dept_lock(void)
> +{
> +	while (!arch_spin_trylock(&dept_spin))
> +		if (unlikely(dept_outworld_entered()))
> +			return false;
> +	return true;
> +}
> +
> +static void dept_unlock(void)
> +{
> +	arch_spin_unlock(&dept_spin);
> +}
> +
> +enum bfs_ret {
> +	BFS_CONTINUE,
> +	BFS_DONE,
> +	BFS_SKIP,
> +};
> +
> +static bool before(unsigned int a, unsigned int b)
> +{
> +	return (int)(a - b) < 0;
> +}
> +
> +static bool valid_stack(struct dept_stack *s)
> +{
> +	return s && s->nr > 0;
> +}
> +
> +static bool valid_class(struct dept_class *c)
> +{
> +	return c->key;
> +}
> +
> +static void invalidate_class(struct dept_class *c)
> +{
> +	c->key = 0UL;
> +}
> +
> +static struct dept_ecxt *dep_e(struct dept_dep *d)
> +{
> +	return d->ecxt;
> +}
> +
> +static struct dept_wait *dep_w(struct dept_dep *d)
> +{
> +	return d->wait;
> +}
> +
> +static struct dept_class *dep_fc(struct dept_dep *d)
> +{
> +	return dep_e(d)->class;
> +}
> +
> +static struct dept_class *dep_tc(struct dept_dep *d)
> +{
> +	return dep_w(d)->class;
> +}
> +
> +static const char *irq_str(int irq)
> +{
> +	if (irq == DEPT_SIRQ)
> +		return "softirq";
> +	if (irq == DEPT_HIRQ)
> +		return "hardirq";
> +	return "(unknown)";
> +}
> +
> +/*
> + * Dept doesn't work either when it's stopped by DEPT_STOP() or in a nmi
> + * context.
> + */
> +static bool dept_working(void)
> +{
> +	return !READ_ONCE(dept_stop) && !in_nmi();
> +}
> +
> +/*
> + * Even k == NULL is considered as a valid key because it would use
> + * &->map_key as the key in that case.
> + */
> +struct dept_key __dept_no_validate__;
> +static bool valid_key(struct dept_key *k)
> +{
> +	return &__dept_no_validate__ != k;
> +}
> +
> +/*
> + * Pool
> + * =====================================================================
> + * DEPT maintains pools to provide objects in a safe way.
> + *
> + *    1) Static pool is used at the beginning of booting time.
> + *    2) Local pool is tried first before the static pool. Objects that
> + *       have been freed will be placed.
> + */
> +
> +enum object_t {
> +#define OBJECT(id, nr) OBJECT_##id,
> +	#include "dept_object.h"
> +#undef  OBJECT
> +	OBJECT_NR,
> +};
> +
> +#define OBJECT(id, nr)							\
> +static struct dept_##id spool_##id[nr];					\
> +static DEFINE_PER_CPU(struct llist_head, lpool_##id);
> +	#include "dept_object.h"
> +#undef  OBJECT

is this extra ' ' require after #undef? consistent all place

> +
> +struct dept_pool {
> +	const char			*name;
> +
> +	/*
> +	 * object size
> +	 */
> +	size_t				obj_sz;
> +
> +	/*
> +	 * the number of the static array
> +	 */
> +	atomic_t			obj_nr;
> +
> +	/*
> +	 * offset of ->pool_node
> +	 */
> +	size_t				node_off;
> +
> +	/*
> +	 * pointer to the pool
> +	 */
> +	void				*spool;
> +	struct llist_head		boot_pool;
> +	struct llist_head __percpu	*lpool;
> +};
> +
> +static struct dept_pool pool[OBJECT_NR] = {
> +#define OBJECT(id, nr) {						\
> +	.name = #id,							\
> +	.obj_sz = sizeof(struct dept_##id),				\
> +	.obj_nr = ATOMIC_INIT(nr),					\
> +	.node_off = offsetof(struct dept_##id, pool_node),		\
> +	.spool = spool_##id,						\
> +	.lpool = &lpool_##id, },
> +	#include "dept_object.h"
> +#undef  OBJECT
> +};
> +
> +/*
> + * Can use llist no matter whether CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG is
> + * enabled or not because NMI and other contexts in the same CPU never
> + * run inside of DEPT concurrently by preventing reentrance.
> + */
> +static void *from_pool(enum object_t t)
> +{
> +	struct dept_pool *p;
> +	struct llist_head *h;
> +	struct llist_node *n;
> +
> +	/*
> +	 * llist_del_first() doesn't allow concurrent access e.g.
> +	 * between process and IRQ context.
> +	 */
> +	if (DEPT_WARN_ON(!irqs_disabled()))
> +		return NULL;
> +
> +	p = &pool[t];
> +
> +	/*
> +	 * Try local pool first.
> +	 */
> +	if (likely(dept_per_cpu_ready))
> +		h = this_cpu_ptr(p->lpool);
> +	else
> +		h = &p->boot_pool;
> +
> +	n = llist_del_first(h);
> +	if (n)
> +		return (void *)n - p->node_off;
> +
> +	/*
> +	 * Try static pool.
> +	 */
> +	if (atomic_read(&p->obj_nr) > 0) {
> +		int idx = atomic_dec_return(&p->obj_nr);
> +
> +		if (idx >= 0)
> +			return p->spool + (idx * p->obj_sz);
> +	}
> +
> +	DEPT_INFO_ONCE("---------------------------------------------\n"
> +		"  Some of Dept internal resources are run out.\n"
> +		"  Dept might still work if the resources get freed.\n"
> +		"  However, the chances are Dept will suffer from\n"
> +		"  the lack from now. Needs to extend the internal\n"
> +		"  resource pools. Ask max.byungchul.park@gmail.com\n");
> +	return NULL;
> +}
> +
[clip]
> +	return hash_lookup_dep(&onetime_d);
> +}
> +
> +static struct dept_class *lookup_class(unsigned long key)
> +{
> +	struct dept_class onetime_c = { .key = key };
> +
> +	return hash_lookup_class(&onetime_c);
> +}
> +
> +/*
> + * Report
> + * =====================================================================
> + * DEPT prints useful information to help debuging on detection of

debuging

> + * problematic dependency.
> + */
> +
> +static void print_ip_stack(unsigned long ip, struct dept_stack *s)
> +{
> +	if (ip)
> +		print_ip_sym(KERN_WARNING, ip);
> +
> +#ifdef CONFIG_DEPT_DEBUG
> +	if (!s)
> +		pr_warn("stack is NULL.\n");
> +	else if (!s->nr)
> +		pr_warn("stack->nr is 0.\n");
> +	if (s)
[clip]
> +		eh = dt->ecxt_held + i;
> +		e = eh->ecxt;
> +		if (e)
> +			add_iecxt(e->class, irq, e, true);
> +	}
> +}
> +
> +static void dept_enirq(unsigned long ip)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long irqf = cur_enirqf();
> +	int irq;
> +	unsigned long flags;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	/*
> +	 * IRQ ON/OFF transition might happen while Dept is working.
> +	 * We cannot handle recursive entrance. Just ingnore it.

typo ingnore

> +	 * Only transitions outside of Dept will be considered.
> +	 */
> +	if (dt->recursive)
> +		return;
> +
> +	flags = dept_enter();
> +
> +	for_each_set_bit(irq, &irqf, DEPT_IRQS_NR) {
> +		dt->enirq_ip[irq] = ip;
> +		enirq_transition(irq);
> +	}
> +
> +	dept_exit(flags);
> +}
> +
> +void dept_softirqs_on_ip(unsigned long ip)
> +{
> +	/*
> +	 * Assumes that it's called with IRQ disabled so that accessing
> +	 * current's fields is not racy.
> +	 */
> +	dept_task()->softirqs_enabled = true;
> +	dept_enirq(ip);
> +}
> +
> +void dept_hardirqs_on(void)
> +{
> +	/*
> +	 * Assumes that it's called with IRQ disabled so that accessing
> +	 * current's fields is not racy.
> +	 */
> +	dept_task()->hardirqs_enabled = true;
> +	dept_enirq(_RET_IP_);
> +}
> +
> +void dept_softirqs_off(void)
> +{
> +	/*
> +	 * Assumes that it's called with IRQ disabled so that accessing
> +	 * current's fields is not racy.
> +	 */
> +	dept_task()->softirqs_enabled = false;
> +}
> +
> +void dept_hardirqs_off(void)
> +{
> +	/*
> +	 * Assumes that it's called with IRQ disabled so that accessing
> +	 * current's fields is not racy.
> +	 */
> +	dept_task()->hardirqs_enabled = false;
> +}
> +
> +/*
> + * Ensure it's the outmost softirq context.
> + */
> +void dept_softirq_enter(void)
> +{
> +	struct dept_task *dt = dept_task();
> +
> +	dt->irq_id[DEPT_SIRQ] += 1UL << DEPT_IRQS_NR;
> +}
> +
> +/*
> + * Ensure it's the outmost hardirq context.
> + */
> +void dept_hardirq_enter(void)
> +{
> +	struct dept_task *dt = dept_task();
> +
> +	dt->irq_id[DEPT_HIRQ] += 1UL << DEPT_IRQS_NR;
> +}
> +
> +void dept_sched_enter(void)
> +{
> +	dept_task()->in_sched = true;
> +}
> +
> +void dept_sched_exit(void)
> +{
> +	dept_task()->in_sched = false;
> +}
> +
> +/*
> + * Exposed APIs
> + * =====================================================================
> + */
> +
[clip]
> +void dept_map_copy(struct dept_map *to, struct dept_map *from)
> +{
> +	if (unlikely(!dept_working())) {
> +		to->nocheck = true;
> +		return;
> +	}
> +
> +	*to = *from;
> +
> +	/*
> +	 * XXX: 'to' might be in a stack or something. Using the address
> +	 * in a stack segment as a key is meaningless. Just ignore the
> +	 * case for now.
> +	 */
> +	if (!to->keys) {
> +		to->nocheck = true;
> +		return;
> +	}
> +
> +	/*
> +	 * Since the class cache can be modified concurrently we could
> +	 * observe half pointers (64bit arch using 32bit copy insns).

insns, Instructions?

> +	 * Therefore clear the caches and take the performance hit.
> +	 *
> +	 * XXX: Doesn't work well with lockdep_set_class_and_subclass()
> +	 *      since that relies on cache abuse.
> +	 */
> +	clean_classes_cache(&to->map_key);
> +}
> +
> +static LIST_HEAD(classes);
> +
> +static bool within(const void *addr, void *start, unsigned long size)
> +{
> +	return addr >= start && addr < start + size;
> +}
> +
> +void dept_free_range(void *start, unsigned int sz)
> +{
> +	struct dept_task *dt = dept_task();
> +	struct dept_class *c, *n;
> +	unsigned long flags;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	if (dt->recursive) {
> +		DEPT_STOP("Failed to successfully free Dept objects.\n");
> +		return;
> +	}
> +
> +	flags = dept_enter();
> +
> +	/*
> +	 * dept_free_range() should not fail.
> +	 *
> +	 * FIXME: Should be fixed if dept_free_range() causes deadlock
> +	 * with dept_lock().
> +	 */
> +	while (unlikely(!dept_lock()))
> +		cpu_relax();
> +
> +	list_for_each_entry_safe(c, n, &classes, all_node) {
> +		if (!within((void *)c->key, start, sz) &&
> +		    !within(c->name, start, sz))
> +			continue;
> +
> +		hash_del_class(c);
> +		disconnect_class(c);
> +		list_del(&c->all_node);
> +		invalidate_class(c);
> +
> +		/*
> +		 * Actual deletion will happen on the rcu callback
> +		 * that has been added in disconnect_class().
> +		 */
> +		del_class(c);
> +	}
> +	dept_unlock();
> +	dept_exit(flags);
> +
> +	/*
> +	 * Wait until even lockless hash_lookup_class() for the class
> +	 * returns NULL.
> +	 */
> +	might_sleep();
> +	synchronize_rcu();
> +}
> +
> +static int sub_id(struct dept_map *m, int e)
> +{
> +	return (m ? m->sub_u : 0) + e * DEPT_MAX_SUBCLASSES_USR;
> +}
> +
> +static struct dept_class *check_new_class(struct dept_key *local,
> +					  struct dept_key *k, int sub_id,
> +					  const char *n, bool sched_map)
> +{
> +	struct dept_class *c = NULL;
> +
> +	if (DEPT_WARN_ON(sub_id >= DEPT_MAX_SUBCLASSES))
> +		return NULL;
> +
> +	if (DEPT_WARN_ON(!k))
> +		return NULL;
> +
> +	/*
> +	 * XXX: Assume that users prevent the map from using if any of
> +	 * the cached keys has been invalidated. If not, the cache,
> +	 * local->classes should not be used because it would be racy
> +	 * with class deletion.
> +	 */
> +	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
> +		c = READ_ONCE(local->classes[sub_id]);
> +
> +	if (c)
> +		return c;
> +
> +	c = lookup_class((unsigned long)k->base + sub_id);
> +	if (c)
> +		goto caching;
> +
> +	if (unlikely(!dept_lock()))
> +		return NULL;
> +
> +	c = lookup_class((unsigned long)k->base + sub_id);
> +	if (unlikely(c))
> +		goto unlock;
> +
> +	c = new_class();
> +	if (unlikely(!c))
> +		goto unlock;
> +
> +	c->name = n;
> +	c->sched_map = sched_map;
> +	c->sub_id = sub_id;
> +	c->key = (unsigned long)(k->base + sub_id);
> +	hash_add_class(c);
> +	list_add(&c->all_node, &classes);
> +unlock:
> +	dept_unlock();
> +caching:
> +	if (local && sub_id < DEPT_MAX_SUBCLASSES_CACHE)
> +		WRITE_ONCE(local->classes[sub_id], c);
> +
> +	return c;
> +}
> +
> +/*
> + * Called between dept_enter() and dept_exit().
> + */
> +static void __dept_wait(struct dept_map *m, unsigned long w_f,
> +			unsigned long ip, const char *w_fn, int sub_l,
> +			bool sched_sleep, bool sched_map)
> +{
> +	int e;
> +
> +	/*
> +	 * Be as conservative as possible. In case of mulitple waits for
> +	 * a single dept_map, we are going to keep only the last wait's
> +	 * wgen for simplicity - keeping all wgens seems overengineering.

mulitple

> +	 *
> +	 * Of course, it might cause missing some dependencies that
> +	 * would rarely, probabily never, happen but it helps avoid
> +	 * false positive report.

probabily ->probably
"false positive report" -> "false positive reports"

> +	 */
> +	for_each_set_bit(e, &w_f, DEPT_MAX_SUBCLASSES_EVT) {
> +		struct dept_class *c;
> +		struct dept_key *k;
> +
> +		k = m->keys ?: &m->map_key;
> +		c = check_new_class(&m->map_key, k,
> +				    sub_id(m, e), m->name, sched_map);
> +		if (!c)
> +			continue;
> +
> +		add_wait(c, ip, w_fn, sub_l, sched_sleep);
> +	}
> +}
> +
> +/*
> + * Called between dept_enter() and dept_exit().
> + */
> +static void __dept_event(struct dept_map *m, struct dept_map *real_m,
> +		unsigned long e_f, unsigned long ip, const char *e_fn,
> +		bool sched_map)
> +{
> +	struct dept_class *c;
> +	struct dept_key *k;
> +	int e;
> +
> +	e = find_first_bit(&e_f, DEPT_MAX_SUBCLASSES_EVT);
> +
> +	if (DEPT_WARN_ON(e >= DEPT_MAX_SUBCLASSES_EVT))
> +		return;
> +
> +	/*
> +	 * An event is an event. If the caller passed more than single
> +	 * event, then warn it and handle the event corresponding to
> +	 * the first bit anyway.
> +	 */
> +	DEPT_WARN_ON(1UL << e != e_f);
> +
> +	k = m->keys ?: &m->map_key;
> +	c = check_new_class(&m->map_key, k, sub_id(m, e), m->name, sched_map);
> +
> +	if (c)
> +		do_event(m, real_m, c, READ_ONCE(m->wgen), ip, e_fn);
> +}
> +
> +void dept_wait(struct dept_map *m, unsigned long w_f,
> +	       unsigned long ip, const char *w_fn, int sub_l)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long flags;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	if (dt->recursive)
> +		return;
> +
> +	if (m->nocheck)
> +		return;
> +
> +	flags = dept_enter();
> +
> +	__dept_wait(m, w_f, ip, w_fn, sub_l, false, false);
> +
> +	dept_exit(flags);
> +}
> +EXPORT_SYMBOL_GPL(dept_wait);
> +
> +void dept_stage_wait(struct dept_map *m, struct dept_key *k,
> +		     unsigned long ip, const char *w_fn)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long flags;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	if (m && m->nocheck)
> +		return;
> +
> +	/*
> +	 * Either m or k should be passed. Which means Dept relies on
> +	 * either its own map or the caller's position in the code when
> +	 * determining its class.
> +	 */
> +	if (DEPT_WARN_ON(!m && !k))
> +		return;
> +
> +	/*
> +	 * Allow recursive entrance.
> +	 */
> +	flags = dept_enter_recursive();
> +
> +	/*
> +	 * Ensure the outmost dept_stage_wait() works.
> +	 */
> +	if (dt->stage_m.keys)
> +		goto exit;
> +
> +	arch_spin_lock(&dt->stage_lock);
> +	if (m) {
> +		dt->stage_m = *m;
> +		dt->stage_real_m = m;
> +
> +		/*
> +		 * Ensure dt->stage_m.keys != NULL and it works with the
> +		 * map's map_key, not stage_m's one when ->keys == NULL.
> +		 */
> +		if (!m->keys)
> +			dt->stage_m.keys = &m->map_key;
> +	} else {
> +		dt->stage_m.name = w_fn;
> +		dt->stage_sched_map = true;
> +		dt->stage_real_m = &dt->stage_m;
> +	}
> +
> +	/*
> +	 * dept_map_reinit() includes WRITE_ONCE(->wgen, 0U) that
> +	 * effectively disables the map just in case real sleep won't
> +	 * happen. dept_request_event_wait_commit() will enable it.
> +	 */
> +	dept_map_reinit(&dt->stage_m, k, -1, NULL);
> +
> +	dt->stage_w_fn = w_fn;
> +	dt->stage_ip = ip;
> +	arch_spin_unlock(&dt->stage_lock);
> +exit:
> +	dept_exit_recursive(flags);
> +}
> +EXPORT_SYMBOL_GPL(dept_stage_wait);
> +
> +static void __dept_clean_stage(struct dept_task *dt)
> +{
> +	memset(&dt->stage_m, 0x0, sizeof(struct dept_map));
> +	dt->stage_real_m = NULL;
> +	dt->stage_sched_map = false;
> +	dt->stage_w_fn = NULL;
> +	dt->stage_ip = 0UL;
> +}
> +
> +void dept_clean_stage(void)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long flags;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	/*
> +	 * Allow recursive entrance.
> +	 */
> +	flags = dept_enter_recursive();
> +	arch_spin_lock(&dt->stage_lock);
> +	__dept_clean_stage(dt);
> +	arch_spin_unlock(&dt->stage_lock);
> +	dept_exit_recursive(flags);
> +}
> +EXPORT_SYMBOL_GPL(dept_clean_stage);
> +
> +/*
> + * Always called from __schedule().
> + */
> +void dept_request_event_wait_commit(void)
> +{
> +	struct dept_task *dt = dept_task();
> +	unsigned long flags;
> +	unsigned int wg;
> +	unsigned long ip;
> +	const char *w_fn;
> +	bool sched_map;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	/*
> +	 * It's impossible that __schedule() is called while Dept is
> +	 * working that already disabled IRQ at the entrance.
> +	 */
> +	if (DEPT_WARN_ON(dt->recursive))
> +		return;
> +
> +	flags = dept_enter();
> +
> +	arch_spin_lock(&dt->stage_lock);
> +
> +	/*
> +	 * Checks if current has staged a wait.
> +	 */
> +	if (!dt->stage_m.keys) {
> +		arch_spin_unlock(&dt->stage_lock);
> +		goto exit;
> +	}
> +
> +	w_fn = dt->stage_w_fn;
> +	ip = dt->stage_ip;
> +	sched_map = dt->stage_sched_map;
> +
> +	wg = next_wgen();
> +	WRITE_ONCE(dt->stage_m.wgen, wg);
> +	arch_spin_unlock(&dt->stage_lock);
> +
> +	__dept_wait(&dt->stage_m, 1UL, ip, w_fn, 0, true, sched_map);
> +exit:
> +	dept_exit(flags);
> +}
> +
> +/*
> + * Always called from try_to_wake_up().
> + */
> +void dept_ttwu_stage_wait(struct task_struct *requestor, unsigned long ip)
> +{
> +	struct dept_task *dt = dept_task();
> +	struct dept_task *dt_req = &requestor->dept_task;
> +	unsigned long flags;
> +	struct dept_map m;
> +	struct dept_map *real_m;
> +	bool sched_map;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	if (dt->recursive)
> +		return;
> +
> +	flags = dept_enter();
> +
> +	arch_spin_lock(&dt_req->stage_lock);
> +
> +	/*
> +	 * Serializing is unnecessary as long as it always comes from
> +	 * try_to_wake_up().
> +	 */
> +	m = dt_req->stage_m;
> +	sched_map = dt_req->stage_sched_map;
> +	real_m = dt_req->stage_real_m;
> +	__dept_clean_stage(dt_req);
> +	arch_spin_unlock(&dt_req->stage_lock);
> +
> +	/*
> +	 * ->stage_m.keys should not be NULL if it's in use. Should
> +	 * make sure that it's not NULL when staging a valid map.
> +	 */
> +	if (!m.keys)
> +		goto exit;
> +
> +	__dept_event(&m, real_m, 1UL, ip, "try_to_wake_up", sched_map);
> +exit:
> +	dept_exit(flags);
> +}
> +
> +/*
> + * Modifies the latest ecxt corresponding to m and e_f.
> + */
> +void dept_map_ecxt_modify(struct dept_map *m, unsigned long e_f,
> +			  struct dept_key *new_k, unsigned long new_e_f,
> +			  unsigned long new_ip, const char *new_c_fn,
> +			  const char *new_e_fn, int new_sub_l)
> +{
> +	struct dept_task *dt = dept_task();
> +	struct dept_ecxt_held *eh;
> +	struct dept_class *c;
> +	struct dept_key *k;
> +	unsigned long flags;
> +	int pos = -1;
> +	int new_e;
> +	int e;
> +
> +	if (unlikely(!dept_working()))
> +		return;
> +
> +	/*
> +	 * XXX: Couldn't handle re-enterance cases. Ingore it for now.
> +	 */

typo Ingore

> +	if (dt->recursive)
> +		return;
> +
> +	/*
> +	 * Should go ahead no matter whether ->nocheck == true or not
> +	 * because ->nocheck value can be changed within the ecxt area
> +	 * delimitated by dept_ecxt_enter() and dept_ecxt_exit().
> +	 */
> +
> +	flags = dept_enter();
> +
> +	for_each_set_bit(e, &e_f, DEPT_MAX_SUBCLASSES_EVT) {
[clip]
> +	might_sleep();
> +	synchronize_rcu();
> +}
> +EXPORT_SYMBOL_GPL(dept_key_destroy);
> +
> +static void move_llist(struct llist_head *to, struct llist_head *from)
> +{
> +	struct llist_node *first = llist_del_all(from);
> +	struct llist_node *last;
> +
> +	if (!first)
> +		return;
> +
> +	for (last = first; last->next; last = last->next);
> +	llist_add_batch(first, last, to);
> +}
> +
> +static void migrate_per_cpu_pool(void)
> +{
> +	const int boot_cpu = 0;
> +	int i;
> +
> +	/*
> +	 * The boot CPU has been using the temperal local pool so far.

typo temperal -> temporary/temporal

> +	 * From now on that per_cpu areas have been ready, use the
> +	 * per_cpu local pool instead.
> +	 */
> +	DEPT_WARN_ON(smp_processor_id() != boot_cpu);
> +	for (i = 0; i < OBJECT_NR; i++) {
> +		struct llist_head *from;
> +		struct llist_head *to;
> +
> +		from = &pool[i].boot_pool;
> +		to = per_cpu_ptr(pool[i].lpool, boot_cpu);
> +		move_llist(to, from);
> +	}
> +}
> +

Thanks,
Alok

