Return-Path: <linux-fsdevel+bounces-69104-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 15DAEC6F481
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 15:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 31A3E4ED9CB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Nov 2025 14:10:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E10C5364EB4;
	Wed, 19 Nov 2025 14:10:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="gIDeSEpt";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Wdrgpjeq"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD3221B195;
	Wed, 19 Nov 2025 14:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763561405; cv=fail; b=BhHUy/SjHqbdmyrxcck/kgzMYPCiUtH7Wlz0Z6VZ4taTgye4RG2olp88gkyKFVjCv/MJxIPg9oL3ttgwuUWz6zNtQWJHJdFGz3RZSGMx3sEdQdiyzB9DUjXm2zDI8y1P5I/40kZFObD0awir3/HAsHsuUWSE1byO5HSAGkNNd7M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763561405; c=relaxed/simple;
	bh=RHUKqr6OLu53UAChLNKIhI6JFxAvsbmUbo7zvXqZPyo=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K5BHnNDX9ucOxw3YfZ3G+W/87lgSVBFIin37VqIIIjSyKeNWPyPYX7CIJM4FRTl0JnkxVx6F6dxEW4yDBJd4JqlXh1lO82QNB4w5ix79uO/sSJfMZMHKJuxHUA4ArsZ3WchiM0ii0yEuBYDIRv6rHH224JHKWja1oynTWgpT/+s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=gIDeSEpt; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Wdrgpjeq; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJE7AvZ012454;
	Wed, 19 Nov 2025 14:09:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=nEsquaiYADMrUO/GmvogP+beUmCGxDpmPF5nqDb3wuk=; b=
	gIDeSEptt+1ZcB+wV39iwCP/ohNloVndnSSsUBK2OloFh1wDWmB54tfZCc3Af4o1
	gy4FOjMyWFwqSQYhGpW92GawOLtUkzfd0KpqLy/c7h5ywcjr45n9AHPkuDd7VEy7
	S3CevPICQoDnMd5LgniyAs2dNXp1h/HXnzBgGvH2bgU5injXkzOKQgv7ZgbPbb+n
	StJzCZ3FTuUbKlQI4vNO9b/nDwWEes4W/+yjlb3HAqarlRK8h/pHEDI0vz0zgVF9
	bg6z4Qc08Tm32Y1Niaii0Ocnve6PvlwEQekBHyvFZCUur1H/DRITZTw/2+JNGCGK
	XacLxoNGGx4AkG6FKJYfYg==
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aejbupyab-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:09:12 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AJCXbUn007932;
	Wed, 19 Nov 2025 14:09:11 GMT
Received: from byapr05cu005.outbound.protection.outlook.com (mail-westusazon11010000.outbound.protection.outlook.com [52.101.85.0])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefyamrhf-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Nov 2025 14:09:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOdX47HY1UuMOzokJ2fOHfVAx9ZqdZrf0Q2+yXpDkEATSFG3S7tsl9FD7gqVaiJvJe3OcypB0sd/0ehZBqsyyhrYoEAyDG1EL2oHG04xk9UDdu26+VjsHRfUKWXzFx3OuOu29DiQ/WR8aKTmK8eYezXtDg/Ot8WvNB9T5cSOtyRw1uBWOsejhXlJiIR5TSVaP6DMdT2AhyPPPDN0g+iC4P5uyTE+RVVqEeITLg0Lt/kspz34T6+N1MWFHrfBm/RVvB3nQgS2vmfCn/NgjyEF1V/aRsemYjBC4jX72GTenUWDyloAPAJgvcoAOvRIMBI1xW/NKhZoir7XGQ5BrZYqaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nEsquaiYADMrUO/GmvogP+beUmCGxDpmPF5nqDb3wuk=;
 b=yWjpHQ78zyIHDp7EeG2Dy+p3L4bsXbcyPgzgalNx8h/7RYggy0k9V6GEXlFhyckmILBmXBoUdCFWYEvAWuzDV9zREAyYpPSObUQp4HpwV2DoV4bqRKOZq6p0fsx58DL2nknw3fEM52GzJAv02OnXhzdexeINxHnx8ZBvqt48U1ffpo79FQ5Lr9KQ1AYiW+eMvbnCPuydNX/GGgwoo08w8TTKaDjNjVkGZLKFT3wKBYNOrA4HWgmEZMr29+xAglDATnmyhNVucuR6vT7cHFIzuLdsZWiool+75MXU5aKTTqrkQ17ZyotX5MT3MQBqeJsAcOKrJ9SnTWu9lOzIoFNClw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nEsquaiYADMrUO/GmvogP+beUmCGxDpmPF5nqDb3wuk=;
 b=Wdrgpjeqg5KIwqPZexxk4cCLF5YKtEb4hNeUO1SKG4421PMaZBwW8EiCHOwGVaGZiVkLbqpfMMcKl3HY5o9CfUW1oTVy9L0E9+bst2Hd2XCEBdURFDESW8JDX4RIqHSjyYHUxU6aNmWL34L2uBRbmb6oAe93gegz830JJ5xS05M=
Received: from DS7PR10MB5134.namprd10.prod.outlook.com (2603:10b6:5:3a1::23)
 by DM3PPF34F57F25D.namprd10.prod.outlook.com (2603:10b6:f:fc00::c1c) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 14:09:05 +0000
Received: from DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63]) by DS7PR10MB5134.namprd10.prod.outlook.com
 ([fe80::39b2:9b47:123b:fc63%4]) with mapi id 15.20.9343.009; Wed, 19 Nov 2025
 14:09:05 +0000
Message-ID: <dc1e0443-5112-4a5d-9b3c-294e32ab7ed4@oracle.com>
Date: Wed, 19 Nov 2025 09:09:04 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/3] FSD: Fix NFS server hang when there are multiple
 layout conflicts
To: Christoph Hellwig <hch@lst.de>, Dai Ngo <dai.ngo@oracle.com>
Cc: jlayton@kernel.org, neilb@ownmail.net, okorniev@redhat.com, tom@talpey.com,
        alex.aring@gmail.com, viro@zeniv.linux.org.uk, brauner@kernel.org,
        jack@suse.cz, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
References: <20251115191722.3739234-1-dai.ngo@oracle.com>
 <20251115191722.3739234-4-dai.ngo@oracle.com>
 <d7888dd6-c238-45e0-94c0-ac82fb90d6b6@oracle.com>
 <18135047-8695-4190-b7ca-b7575d9e4c6c@oracle.com>
 <20251119100526.GA25962@lst.de>
Content-Language: en-US
From: Chuck Lever <chuck.lever@oracle.com>
In-Reply-To: <20251119100526.GA25962@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CH0PR03CA0415.namprd03.prod.outlook.com
 (2603:10b6:610:11b::26) To DS7PR10MB5134.namprd10.prod.outlook.com
 (2603:10b6:5:3a1::23)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5134:EE_|DM3PPF34F57F25D:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a0ed8f1-2268-4a13-d4f2-08de2775332f
X-LD-Processed: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
 =?utf-8?B?Vy96SEI4bHJjV2pvTHRMcVB6dVp3NjhKYXAwaGtKdkk3Y0pLVUNDVWhPdHM5?=
 =?utf-8?B?MHgremFaTGRVdUZ2WWtJSkNEa2pFVUN1cHg2SEhRNi9sVUVlVUtVbDZ6aFFn?=
 =?utf-8?B?U0hUbUk0QkF6Ni9KemNmT2dwcGxCWGZ5a1dhWUh5K0VkcGQvVG5RZUpuQkth?=
 =?utf-8?B?bDU1Q1ZhallwSThhdC9XTUpZRFFlQ2JFNEVXV0NabnRrSXJKaEhodDcrT3BE?=
 =?utf-8?B?MTdCb0lpM200Q2RTZS8xUHJORXA4bS9EbkFTSEZ3SFNVWURLNHY1ZWtFTitz?=
 =?utf-8?B?dDd3M2dZelN0WnlBVXpWeHd1T2dOdzAra2tYWXMrMTJzVm5wRUZzeFZUZTF2?=
 =?utf-8?B?QzRYNkVmdWVuSlE0Z3o4TlBzUWlyNFBTa0xpbnZpZ3cycy9LK3NiQVo2dHNQ?=
 =?utf-8?B?SjlybnIvaEk2aTZwQndCMVZibnRuS2dBYkp1LzRRdFd6THFneHE5cXZwNHll?=
 =?utf-8?B?RUw4Z1o1WlcxMWlVdW43Yzg3NGN5YTF4MStXREZSMzZxdnJBQk4wRVUxK2VQ?=
 =?utf-8?B?M1pvNGVKcUJnaU1kajEzTXN4aVl3VytPTTY1eEtTbjJ3cC85ZzVndnhqbDI0?=
 =?utf-8?B?WkVmYy9vbnlJTzQ1UjdCUFhucDdtbW5zYkVTRGgrT0ExQVpia2xVSGhxZm9q?=
 =?utf-8?B?eEtYamg4ck9YMmNBMFpJOCthS1Z3TDhVQjBrY1dsMlRFaHA4d01LZDNlV0hx?=
 =?utf-8?B?QWNvZlNWaVFHR3NsZGZPelEyWkgzd2gwVVNHWk0yS21hR0xJUE9JczJPSStX?=
 =?utf-8?B?KzErYjVpVllwSUh1S0ZKWVA5ODl6Yk9aSDBDQzZ5T2FwY2szcENEdXdPaWo2?=
 =?utf-8?B?aXZ5R2JDRG1JaGtUTTVDbFo2TWlRM2MyS1BsU1ZMNnVTM0VQQnRnaEpHeDFU?=
 =?utf-8?B?bkQ2ajU5bkpzcUFRaTkvZ0J6MW5JL3I1UHlpN28wc2p6SlZ2K3QwK2NaRzFa?=
 =?utf-8?B?aGlMWGxNaEo1MGd5L2xhcTVnTWJjdzdjYTVDdTkrZTJkSUVwVVhwcGl6UHN3?=
 =?utf-8?B?NUYzdHJucmJBaDk0NythN1RJdHNFWDRlNGNwNVIrbm1YOXVCMGhCVGpYVjl3?=
 =?utf-8?B?Z08wbDMrUFRKcFdSMEVnUWpvbjh0cHJQdUhmRmJTaXhHU3BSeFBZY09lNXkv?=
 =?utf-8?B?bEg0WW52YlR1REpxQXFibXBIaDBNK2szSkZDcEVYR0dqYnpoYnhPMEF5WFo5?=
 =?utf-8?B?aHFvbHJ4K1d1ejdmakZ1QXBiSkpDN3VXSkVlOUoycEI1Snl1U1drYkNyVFNv?=
 =?utf-8?B?V3hvRjg3dnZGanZ6bGxJVW41RUZIYWZOdEorMFpibDBVSmwzbjZNYmkvVjZU?=
 =?utf-8?B?dXZTVFdCNm9RQkFqTjh2YkJVWUkrNEpXQStaRlVHa25SUmRnSGNOczJGREdz?=
 =?utf-8?B?Q2JYbEtvUFZKbnpEaHJ4MFhZWWE3YnM0cjdhYVZidk5EVDhyRUppc0xPdnQ3?=
 =?utf-8?B?WEZQRW9NbnNKK2JrVSsvbldZQUZJTThyeVBNYy9Senh3TTc4UjlqUzN6cGdR?=
 =?utf-8?B?ZEl0NjJVMGJONlpWM0ErKy9Td252NmhINUlQV2xURG9RZm9LRGl0aWtHQTJO?=
 =?utf-8?B?MU5ZQ2VCVUxvZ205ZWxiWjlDdGNEeEhoKys5cThoSjV4Qnk5dnducVBGSGtk?=
 =?utf-8?B?UTJXN29Mc3Awd0Y0cGpMdm9DN3M1amZEc0ZINUE4UktKc3grV3llb3NCYTBK?=
 =?utf-8?B?MitFVmdHQnREamI1RjR1Tm9IZ3ZPMGNBUW9DMDdIMS93bDdMN1c2SXhIckJH?=
 =?utf-8?B?R0IrRXZVcy84R041bysrdTBnYzh2V3V6SXZhZFc4cFhNVmZxOWZrMzFGZlE3?=
 =?utf-8?B?ZDE5ZWliZ2ZEVVlSN3ZiMWVIYmtCVEo5aU1adVJWSHYrTzhqY21XWmdNUHNq?=
 =?utf-8?B?MGc0WTBoaVU5ZXM0aFBDRkY2bzJDYWV3cTY5c2MvVnVNWlpKWEZoVVczU016?=
 =?utf-8?Q?M2vlw6ywnKe2tQ9pNzsnGgZin8/tyCKR?=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5134.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?utf-8?B?d004Qm42akZRUFdSYURyY3hvVmNWcnYxbzExQ0NEZHM5bmM0SkJodW5sRmY2?=
 =?utf-8?B?QW1icFVpNTBsVW8vbncvWm5JSmxkeGd6OTFvdmtpSk1xR2JtOGFFZlRxT05O?=
 =?utf-8?B?LytEWlltbjV3cTVnTFJ3QlNMU1ZtRDFUcEFjVjJPQlpCWGlIeEdaTDl3VWk0?=
 =?utf-8?B?YUIzaml2bmJ4Tnd6Z01IWFBqbURqVTQ4cm5HWm4wTEVEaFdFSzV5VGVqU1h6?=
 =?utf-8?B?ekNpVENXWXMwYzJEeHJxdDVUUWhLU21xVVdSOUNDSDMwelM3c0JXZ0FvSUhZ?=
 =?utf-8?B?NFhRdDlvZnJpR0hqc0g0NEpmRm4waVI1YWFmK3k4aktvNkxsNy8zSkZkdDNV?=
 =?utf-8?B?QWF5L1lGajNCU1BLekdTY1BMdFEvajA3QXV1RUdWSThmcTF2Z1M2MHRVd3V4?=
 =?utf-8?B?cmV3b25lbnM2VzdrVVkrVnIvU21haGhYT094MUdXNncxVEtvMks5REVNb2xH?=
 =?utf-8?B?dy9oUSt6cjBMQnpBOHhvRjNBRitMR2dNcFh4UUttOXhjNy9pR3FiZE1Ydmxr?=
 =?utf-8?B?YXJjWStoWGFpWE85Wk02SXB0RE90OVpKakEyNGNpb2FlanVoNFZOcEM3bWZD?=
 =?utf-8?B?VDMxeFFzM2pabDRTYnZxa1dURmQ0S2gyZWcwenJ5TGV6SW9WS2RUY2dhd21W?=
 =?utf-8?B?WUJ4RHpUVksxdVYrOEdhNXlnNHdhRU1qa2VkSkxOSzAzaFRCdXNMQVJvK3A4?=
 =?utf-8?B?WkNhcXhhamIvZzBGQTNQLzNvYlk5dnY4ajNNQkNMSGRaL0NFbmk0U2hDenl6?=
 =?utf-8?B?VzRoeElobm93VHdLSXdUSENEcU9uNEtodTQ4V3I3TW02TGVtT2Vpc1gyRVov?=
 =?utf-8?B?alg5citZSHYwc3gyNHVaRzEzeTlocDBzRnFJQXBZU2tFNzdqU05ycVpWT29T?=
 =?utf-8?B?MzlmUTdUZGo0czl3bXZJbXVrN3A0OC9jdG50ZzFpRzZsMjJqamN2STZvOHAv?=
 =?utf-8?B?VlhTT3B5Vmx0Uzk0b0N6eVJNWlFWVzhRdWVOcG54aXRCOUV5U2h0a3ltMnlI?=
 =?utf-8?B?bTJka2N4eG5BUTFpQWlNRXhSNDJ6S3pLcWpFWEduVTY4em5kSFNia3RoeGpk?=
 =?utf-8?B?aWdEZWh4c3JsbWVuYVdxa1ZBc2c0Tm9mbGJoaE8yNGw4QmVONkc0eWk2aEF6?=
 =?utf-8?B?QjhxcG5qbUJvUW9JZG00cndTSis5RkVzMVEwWDNSVCtBMG9ma1FUc2hlVzlS?=
 =?utf-8?B?NThRMjRDejZRdzU3c0tMOEl5dS96SzRBaDhYSk8xbENlT0hjM3VCYUhLTTJa?=
 =?utf-8?B?T2RwaEpPZE1NcGVkR0tSNnJFT2xBaVVmZzFXaUFBOTdCNXlzV2VCRFFEY0dy?=
 =?utf-8?B?dkhUT3ZveWZ1Vm5sUXhuSVJOT1RSdHEycy9najNqbk1xd0U3TStzeTg4aEd4?=
 =?utf-8?B?ZWtUNlE4ZWdEQ0tuZ2Fxb1k3SE41eTJCU3lJcHp2SnJuMis3MXZzWUJybklE?=
 =?utf-8?B?MWZnc0crYVk3Y2VtbFNVcXNpTGJXeGp1cU4rTVlnZ0xrSDFSSzlsanVUVUVh?=
 =?utf-8?B?SkRZRUxRbG1WYWV4ODk0RFZpTnpqR3o4TUtxNHFaL0lPbitXSVRZazhUVzlm?=
 =?utf-8?B?SVdvM2dpS3JTVE5hcGQvSDBzTjJ0QU43RjhzUDVwRVQ1UEtDdnU0ZFZsRWNO?=
 =?utf-8?B?KytpcVpWeG1tbTJQd3dvSDZnSHBvQk9Rd1Rsc24zOFBUd3JMOHlseEZaVnJJ?=
 =?utf-8?B?ejBQb3BWSG45TWFQbXNVdFVYcUFsS2JpeU1heDFNKzlZRzlndGVXM0xHSndS?=
 =?utf-8?B?RjJ4QTFBdEhRR2RXcmtneWt2QWh1WW15YzlySTdWT2N2UTdraUQveFk3a2xD?=
 =?utf-8?B?bXluVkJnVlFEMGZ6OEdXdDNYVEwwMjJLUzRuSHpQaVFJMUJxbko0WDJvMnQx?=
 =?utf-8?B?RGJUSHBqc0g5RzhYbDdCMDY0T0R2WUVKQTV5MUVGbzhTTGFqYWNhSUtNWkl0?=
 =?utf-8?B?S1E0OTJOVW1vMHNZclh6L3pwRlVNSUNHOUtVY25vcjhkVURxcWlOMUtXYXIx?=
 =?utf-8?B?WUh5ZWh6N3pBczQwWEZBdE9wZnUwMkxTMWFRZWsyam1Db21pUFdGaWp0cmhq?=
 =?utf-8?B?WnJnYU1MYmhOcDlxOEYzbDBmbnA5Q3JNRkdES2kwTUxpdEJmdFh4NHRUVXR2?=
 =?utf-8?B?N3ZTeXlxVGU0VmZNL3MzYVplZUE1L1poU3AwRTFRQUpIVFVXNVB1Yk9uNHRi?=
 =?utf-8?B?M1E9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	FzZ/x4Ok/U+rwGTcl4Kc/cjLtQfhRrotK7471kzlI66NhP7nwiEXkmX6Cwzbt66DOKat0jjl5cUigRJYChX+czDTCF19Ha6jktgHTVXjURWnjcWz7u8q6q0W9PlU/pn+ykgnt0aRgQZN3DDdX544qAT9e5yD+0GDBv3su3+wQ2at8i+1Jx50ZTCaztPaj2ZIMChDhQQZr0Ke2vkHFS3D5Vj3eTBHluA/+FmUvhSaEkdPLHVJSZnDDNtDo5hRwjkVCI8JcME9Oq99gA0gEcJEYZZdLnCLgoi07eUQMMQT4akomRJ9j1l3cOqhnHI/CYGM52aXhLM48Nh6J0oc4nqNb5UA3uFTND9y8H9N39KJrmmg+hgBn7rJkXHBk+Pr7aU1LqcO4+9ha9NGXaidl0BO6s2nsft2ht/iJGJNP2h86+e+glTPtA66PhqAN70sUql0xC251Kg47mgDQjIX5JeezphTR41hmXKs2Be7p2XP0D2OAjtViTnSMbyST3Nn5Hmz3TstdJDtv9edV6Z2g6cabJdCSxayPoLlyMDFeEuPJYC3waGQMjp/61EriVnUFt6M7wjDwvKokcpxvIykaAN0AcfLnSh4xgqML5FUSfVGE0k=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a0ed8f1-2268-4a13-d4f2-08de2775332f
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5134.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 14:09:05.7749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LBUDQ7Lo4ArV8qGvESJ4xRBG1FR6I+8JignCuzZg1jIaupq3zU81Fo6Y15V6ja45CoRZUJnR7PG0rjILSCEQpQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF34F57F25D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-19_04,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511190113
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX4ocIHbTwLMYF
 EKGHA0vl6whoAk0OTrBkBiV+REPmJCfkjLlVMmFBu/U+mDcIQRyrs96eYUnisuPc/SmTtEKAqdm
 DhMB047nZM5+D0hjqH4mhtKMOzFzLur+19HowY49BsGqSp4XeGH2viCyZvX/pRdB5+xW0osGRN7
 b4CQGj1y0607waHVLv3teCcpBSE1kN19Mm4wwQfMHoyKajVGl+1ReOQBYmKNxmP+aVvNngYoRW/
 xtvLVemw99BRSNbIC30fRQrhbCUmR3JZSqp4lh703wIunPEdyIIEhjZbj4gg9/ipRJeSbvrK+0s
 RJN5p5D6jRmus2GjF1almEgdSGm1FMNuxOZgINxc6CpiPu+jt1szvdeHUvtVZ/xYag5a0/SxiOp
 w5yl8n7O11iO5JDtzGL+opFkWJ+hTA==
X-Proofpoint-GUID: FbHpMS_zRP7buwheaCwrCw_ZDAzBmydf
X-Proofpoint-ORIG-GUID: FbHpMS_zRP7buwheaCwrCw_ZDAzBmydf
X-Authority-Analysis: v=2.4 cv=Rdydyltv c=1 sm=1 tr=0 ts=691dcf88 cx=c_pps
 a=OOZaFjgC48PWsiFpTAqLcw==:117 a=OOZaFjgC48PWsiFpTAqLcw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=6UeiqGixMTsA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=NyX9CG4KF4sA2nl3LZkA:9 a=QEXdDO2ut3YA:10

On 11/19/25 5:05 AM, Christoph Hellwig wrote:
> On Mon, Nov 17, 2025 at 11:40:22AM -0800, Dai Ngo wrote:
>>> If a .fence_client callback is optional for a layout to provide,
>>> timeouts for such layout types won't trigger any fencing action. I'm not
>>> certain yet that's good behavior.
>>
>> Some layout implementation is in experimental state such as block
>> layout and should not be used in production environment. I don't
>> know what should we do for that case. Does adding a trace point to
>> warn the user sufficient?
> 
> The block layout isn't really experimental, but really a broken protocol
> because there is no way to even fence a client except when there is
> a side channel mapping between the client identities for NFS and the
> storage protocol.

Is the protocol broken, or just incomplete, assuming that other
(unspecified) protocols are necessary to be provided?


> I'd be all in favour of deprecating the support ASAP and then removing
> it aggressively.
If we can say with some certainty that there are no users of the pNFS
block layout type, and there is no way of addressing the fencing issue,
then I'm willing to consider removing it.


-- 
Chuck Lever

