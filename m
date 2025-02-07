Return-Path: <linux-fsdevel+bounces-41205-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 786EFA2C507
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 15:17:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D8A9188E967
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2025 14:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FDE233156;
	Fri,  7 Feb 2025 14:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b="adhaDP2k"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from outbound-ip168a.ess.barracuda.com (outbound-ip168a.ess.barracuda.com [209.222.82.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BEE22330D
	for <linux-fsdevel@vger.kernel.org>; Fri,  7 Feb 2025 14:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=209.222.82.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738937712; cv=fail; b=nx4KDTcDHPddi+A9l0Vif3mcV1KUhZsNnijRFzEQ55chpsW3eovayUSmgoe7hKvUHukofu6/sMdiJ9qnF0OS56TOUxRaE+N8wnm9GzaVbHcEa7BLbvOB8LUSTC01aQUmq8wSY1rqiuI6mWICJ/FCTRwQB3oaGzZZ5d7+HXYesNo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738937712; c=relaxed/simple;
	bh=Tp0d2iYd7wYul44E0gWi0mOSei0w4rtpcR1Qdn/b7x4=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=felP8Zic5p/N9jJQhRd/Lc43rpeV1174R4b9MEMk7TlF9Ftzc7mvF7CVMhWhOsNdUCtgfw5oGDbPmenAjHmrtg1+xNT3LWmj0kQ6FsoQYiNZokUIH7Que1J7u1Km8zLMY1mzOyiJgrpFAI4JkYMM09V7qJxubwho+NRrjB4groM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com; spf=pass smtp.mailfrom=ddn.com; dkim=pass (1024-bit key) header.d=ddn.com header.i=@ddn.com header.b=adhaDP2k; arc=fail smtp.client-ip=209.222.82.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=ddn.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ddn.com
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176]) by mx-outbound9-75.us-east-2a.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Fri, 07 Feb 2025 14:15:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nnzvsOp4PaQBG1cvNFV54FUNJ7k3MekW14MSJtkK37FgY7E8FlNEqitfnYTGbSW367Oe+/0ecHyAANPeKdNy4loefTDKDFiV/3knJRtPnFqIVSKJiVMLGohqDaHZfjbT3q7XLBEH7SWYZZB14IAMriL/f0/2kTn6MvmlBA1hN3HzmKH4q6vgEtLoVPFNZxilEQod69wXURs83owOoU8/D2aP7IM+0al2jtXGrMXZbAwGIW5F2bHNfgjVbSuvT8xmGsGKkb7tSVIdJPnsS9bsIJl4xfH/1xY2T2jEljPyKIyxTxybSv5Ayz8XFzq79URIyBGUwwEykPQE9UffV5h/MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HCVlKDO3K7nWIBYMlXstVXP7UGj+0kZDiK2FFd0rIwU=;
 b=nf/vIt9iXiqMvrU6JIg4bO41ka1wQNvoeaCX51c/Wpp5g9TEONom/gxzflOjELE0EMiI1864wI7xvNNY4mkBEeSs59LIzbKFjBEW9CMqYBTd42vt7zQ39uGQB6Tp454DkFm6wljUkRgajo/Tz6ibKLsTLj6+e662uD/ho2b7O4QT1EQ/OXg2QuId03VAYaGyRRi3nUt5U3vuqICBYWMLtLqTs3Jz+DwQ2e9N1I9oe+8tErcg2JDbx75O0ELC1I+0g1tQsAAonEfycg+/81x/5tO4aqhu8goL/76U82lEI0oXn+1tUST3Nq0pvvE1gFT670+8H5RDtQ1TpaKzHSjkow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=ddn.com; dmarc=pass action=none header.from=ddn.com; dkim=pass
 header.d=ddn.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ddn.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HCVlKDO3K7nWIBYMlXstVXP7UGj+0kZDiK2FFd0rIwU=;
 b=adhaDP2kE0p3XM4oEpi7qcu0F1oDClZqsw9xMj8DdSwVFOhkYRlKbCty0FXLo29YxidtpoALO3E+KgetRuUi/PHCGgOjA+CjqfvLZS4xuglkPmuirqXl1xPkRMOcDoml64nwdiZWtwuSxsrkBCh8CmPQnkvb0iFEA+xNiqjpHzE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=ddn.com;
Received: from CH2PR19MB3864.namprd19.prod.outlook.com (2603:10b6:610:93::21)
 by SN7PR19MB7841.namprd19.prod.outlook.com (2603:10b6:806:2e8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 13:42:50 +0000
Received: from CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03]) by CH2PR19MB3864.namprd19.prod.outlook.com
 ([fe80::abe1:8b29:6aaa:8f03%6]) with mapi id 15.20.8398.021; Fri, 7 Feb 2025
 13:42:50 +0000
Message-ID: <56318e97-c849-4c2c-b35f-bc015a611a81@ddn.com>
Date: Fri, 7 Feb 2025 14:42:47 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] fuse: removed unused function fuse_uring_create() from
 header
To: Luis Henriques <luis@igalia.com>, Miklos Szeredi <miklos@szeredi.hu>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250207133502.24209-1-luis@igalia.com>
From: Bernd Schubert <bschubert@ddn.com>
Content-Language: en-US, de-DE, fr
In-Reply-To: <20250207133502.24209-1-luis@igalia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PA7P264CA0043.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:102:34b::17) To CH2PR19MB3864.namprd19.prod.outlook.com
 (2603:10b6:610:93::21)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PR19MB3864:EE_|SN7PR19MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: f41414fc-bda8-44e2-873a-08dd477d506c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|10070799003|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?S0E0MEFENFdyNlRWbmVQM0g4bzY2Mmtud2NqeWNzekVZNTBGTzhyZlljR0tl?=
 =?utf-8?B?UW1zZ0tXSjU0VkVUcENPRzhQRjdDb2hSSWQ4ZU0rbWY0eEh2ejQrRXB2SFM2?=
 =?utf-8?B?M2thZGh2R0MxR09ja0JCalRlNTc5VENtcnM1UXZ6WVgzOGlLSVJYNllCVThN?=
 =?utf-8?B?ZktqcWV0dFhVZWpuSFl2QzA4UUI5NDR2RWt4M0hKRVpyK0lyNytCemwxcXdS?=
 =?utf-8?B?Z1ZsWTNUU1JYM3RKU0g0ZU45cjBVRW1tWEpOVHoxMHFrM04ybHVmNDBzQ3Zp?=
 =?utf-8?B?OVpBRHpoNzZ4NU5TWjR6ZFVINVlobEVicEpObi9mSEpGNDZ0SW1Da2gra0Y0?=
 =?utf-8?B?Z0FYcVlHR0VJelFKbE9tejZXSml5RWpPZ3lGVVVNdVFSVlRPRFVidnhYVHNp?=
 =?utf-8?B?ZE4ySzVnNld5SVJrdnoxT1NNRTJlcU5WQnZBaERQMm1Gd2Z6TDVVUUFqbDBi?=
 =?utf-8?B?OW80WnRBUi94WVd0ZUp6WXZTaHJoZzR3VkxOY0hwSHRVTlZBaEFSWFE2N3RU?=
 =?utf-8?B?N2E2b1k3eG1TVElJYllkbE9OSkc2Ui9hS1crT2JibVVXVkR2bWEwbllVOWxz?=
 =?utf-8?B?dWkwVFFYUm1qcG9tUFZ5dDZGcFNuZTM1bURoVThJZUlCaEhoajdHcUovaEZR?=
 =?utf-8?B?Z0FEU1ViSThmM2RwWllrbjZSZnBubmZhZzVHdGpjNlFpK2hNRWNVejBTN2w4?=
 =?utf-8?B?R0UzUW5aa1B4OGRXVjEyRDdDQjRjL002Ym5nR0liTVdNKzhSWDc2RzlSSkk2?=
 =?utf-8?B?OWZ6MnVlMU1tbDIwZjNtOFZ4RWVQSVhxT21XcFNJUTRpTTlLTVVRb3NPNlhK?=
 =?utf-8?B?Tkc3ODBlZlhodlBMd2VERnl1WHBLUlRwRTF0T3JMZlIzajdva2ppbnozWHdy?=
 =?utf-8?B?UXlNclhSbkd4dG5Mc3dML2NQMFBJZ2ZLMVFudTFrMUFlSDlhTWd3cGZsQ1lX?=
 =?utf-8?B?NGk3RXNmZUtKMTJzYUlSVlNBblB0OEdwOGhPL2E5NFhUYm9pUGc5NWwxZHhE?=
 =?utf-8?B?dUNlWFZ0WGFNMDRtcExQZ2ZldE50K0JNMUFWN3dMSFVRNExMVE9JYm5nZTlj?=
 =?utf-8?B?VW9UMEJ5N1dqRDl3d1FJR2IyZVRNVFRZM2RvSVdGdnBUaGVVWXJndnlvd3dK?=
 =?utf-8?B?SlJsNm0wUCtqRExLS0JHZERNZGlsVjdxZTIzaHV1TkxZckJQYVNGcEJBeUNk?=
 =?utf-8?B?d3AzNWJsVTRKWi82NFRmbDV4bUh4azFUQkRpSGpRODFCTm9LTXR0RWQxaU9V?=
 =?utf-8?B?c1FsQ2N0eW9MdFFGQzJ1KzI2OFB6OWY1a2VzQXA1VUVkS045Rm1kd21NN2Rn?=
 =?utf-8?B?YUNId3llRCtJdkR1WDlCcUptRWs3Z0RZdFVXWWpEUlBCRTdXN1huMGZxRXFY?=
 =?utf-8?B?bjdkbXducG4rS0Vtb1hFS2xpQnZRWFMyUVZxYkhETU93SHlWWnJ2S21Ddkti?=
 =?utf-8?B?WHUyekxlOE8rdXdqNjFCZE5CSmZQQU9OaWNVQUEyZzhjTlJPY1hnQ2o3Tytn?=
 =?utf-8?B?d1pmQUM0dnlPRU9DT3hJRnFyVUE2QU5pZUNpM0xnbUpnY2Fad3FobmhsWkY2?=
 =?utf-8?B?STZVVzJQNmJrY2tKNTZUeTRpRHowTUFvTHkxbmRxd1FiL0NMd2twRXZHcjVX?=
 =?utf-8?B?NWtkbnZaVGdQUEN0b2xVZXR1M05jbDVQYUFwOW5BNUdtRzd5ME9UcTlwZVNt?=
 =?utf-8?B?a2VITTJrd1h0SUNYcG96TmtKL3lmaTZuN2F4ekQwbHZTMTQ3dmVsTFA5eEgy?=
 =?utf-8?B?b3A4NXRIVVhFbkRHa01KWU1vaHJVNldSKzIyWitLV1NmanVON1JVTGpPajZ4?=
 =?utf-8?B?MW9sZ1lVUW5tSUxaQTBuWE1KSlZuZzJSOUwyc2xGVXJFOU5DZUtuaGR4UmZ0?=
 =?utf-8?Q?O/d8r9kjdPvjP?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH2PR19MB3864.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(10070799003)(7053199007);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZWlIT1Ewby9ZR1lPQmJlbm9UTFVDSUl3SENOeVVFRW53ZENYVWVFSnU2eHQ1?=
 =?utf-8?B?M1lnYSsvVHBQOHFGdGZMUVg2YWwvK3k1M1hMT0xwZ2pCeldNZHQ5VnhUS3F3?=
 =?utf-8?B?WHRVajV1TVU3WGJaL1pEcVVwb3RXSmtyM0VkSVhqbHJLSjFmTWhMblBIQ0pS?=
 =?utf-8?B?ZFYxS2htazZwRitaT3lVdlpudGJyZy9QenpRN0RTSXFFNFAyYlJJdWpwOW5V?=
 =?utf-8?B?NEw1eC9udllRK01HVWxGenNGWEVzVndvWnVaZXlYand0NnBiRWl5ZHcvdHBj?=
 =?utf-8?B?UlVHSXo1a2YxWkRlR3VNLzFNYzYvVytDTkd5YkQ4MkdZNkNuOThNZXREREhj?=
 =?utf-8?B?NGhXcXF4VW9SbzRWYm9RdllQRmluTHZUd29hWjhYa0JyMGMzUzA0SFJUWDF0?=
 =?utf-8?B?YjYwMnBTMm82K3krRlNqVjd4TFdIeHc3QmF0ZFd2LzBQSTRWRzhsUlJGVXNX?=
 =?utf-8?B?QUJsUldRYzFpc0Y1dkhuU3FCYlFnR0JpalJGNmN3TVR0WE5OckFGYlhWSEFW?=
 =?utf-8?B?UllzYkhDQVpldXF4dG00Ni9Oci9iS0pWSU1vNStVVWRTZElUQy8vM2ZNaGpZ?=
 =?utf-8?B?eWtjbGRqWDNxUWV5WFp1Zm12RG5lSkJ4WlpkL1dOelFKWHB6WlpieHNqOTRr?=
 =?utf-8?B?OWJxT0oybncvTENyVkFaK1pnNlRUaktNejFyWmsxUDIvdHY0OVZCUUEybHBM?=
 =?utf-8?B?UTdYbk5qRGViRWtnZlYrQTJ3MkFnS2RPVlhBSlBHbzdFcXlSa0xQTDNXRGpm?=
 =?utf-8?B?MEpFZmxqNGx3WHVoazFkRld5SFVwYlRrZFZxY3NuZkduZ0VPZGlkYmU0VElJ?=
 =?utf-8?B?SXQrR2VXWUFId2VoUDQ2NUdGU0RsSkZMWnlYS1VkSnZ3L2d5VTdtWURwNUxH?=
 =?utf-8?B?YUFJdm1ocytrYmdOVGZsRGZuR2RzVXc4MUJ4ZVQrZmtEcGo0MUdtdDF6Tzdp?=
 =?utf-8?B?dGhiSjVQZDlwaEI1RzhIc3hqaHFSQWZXTkI0TU1jRkRIYzZmaUdYRzVvZ1g4?=
 =?utf-8?B?NlRVYUUxV0lOaHVhSHMxcjVkNExPbGJFaEdsZjFCTmdOZXlpTmxpZWdGVTNh?=
 =?utf-8?B?YmZXMFlVMzlPanRKUFJmUEpxTHJyV2s2NnhsWGZsU3hEZkJFUkVSQStRd1I4?=
 =?utf-8?B?WG84SnJsbEROZjgvUGJXUkxGbWRrYnM5T2tXeEpVb3o0aWhhdXlVR3NacHdE?=
 =?utf-8?B?RGNYVlFWdVhaK2REaVJURDNTWWtWNGFDMHl6azlLSm9hSmwvNjdMTkNFUnBS?=
 =?utf-8?B?Q2tibzFlaXNhUmRMa091QzdFbFJpUVVHcVFmRzIxdnBoQzU3ajVjSU9EUldh?=
 =?utf-8?B?UitmZGowRkVKYVJ3eGxQYUMvakVsaThwSTlCODE1M0xZZ0ZwSG9LRXZZdU01?=
 =?utf-8?B?Vjg0YmNHS2pkSldta2ExaThVSVUxTXhyUEhVdTFTSDdNOU5XWHVpSU95QThG?=
 =?utf-8?B?SDJHZ0VZK0RZczIzb0dkR0h1d3dqR2tZZEQ0bW1OU2VYYXAxV0RnbXdMc1Vo?=
 =?utf-8?B?N1JGMUx4d3E2K0dwd3d5RzFOelJLQlJ1Q0FoZE5mcExnc3JRVVNxUzRJNS9B?=
 =?utf-8?B?QTZRQm5YS0MyWllLZVBvMWRFcEx3Q3dzVmlnWDBnM0kwOHBtSXJndkxlZGlL?=
 =?utf-8?B?M0ttTmF3dTZRQmdDSVI4ZE4zb0dBL0lIYVFPbGE0ZERKU3BDcDhKaUNCdjht?=
 =?utf-8?B?M1FzOWphdnVEK0ZFcDNKVHgwYnBHQXUwVEZMR3Frb3lPcm42Q2hIeHF3YVZB?=
 =?utf-8?B?TjVhbWVNYUNpcDJSelh0bldFR0JkME1wMUlBL0hzY1NFZmdMR05iMmxGUEhD?=
 =?utf-8?B?OTREYlEvVGt5YXQycGZ6UHAzdGlObk8vSDZUY3JKNFY4Zk45c3djUnhGVnhz?=
 =?utf-8?B?TUF5cFJNV2FYcGpzWDJOVVc5YkhNc3BUZnRwTVlmSzNHVEIrZ01FYjJVL3Zv?=
 =?utf-8?B?SmJ1di9XOEhwRGh2SWRlUjFyeTlmN1o1ZHQvenJndFkyZVNnUlBVL2hWV3hC?=
 =?utf-8?B?TWdWNlgrYWZMMGQ5Zy9jQ2NhVTlEWkJ1VTNiMmFEOVRpdEtqVUlKczJFdEJK?=
 =?utf-8?B?SDRUYmFhaUNoYXVIOUszWmd3NVBSOUZYYTdnUkZ3RFkzQ3ZDRk5PL2M0Z0FD?=
 =?utf-8?B?dnRaMVZtRHNTVnovSGRWR2dTNGdES0t3aHloMWJIL2hWNXBPMU9CMVM2bHpE?=
 =?utf-8?Q?uKR2UckM4oNs8DiXsxIXJoFvSiAA4t/3zQD4VfqaIdeK?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RcjubxGgSRUy00aDRZ6gbg5LgcJNujVSkKdpYujPJB/agtDWaruZHUzmJbbF7rvlFCTAp1KsNCLUw86hA5CZn2i6T6pI+cXnGOK5doUEwVQQ6LyC1/GVzvDoYM/32kQH/G5crgDhCc8j4yocGu/RH0fVPhnzQ8xOrRpaLvXF9xbgwhiSFrxJEGla1Kyh68Bkd62i7Wbmc+zOogF27wQ/nLrLoy14sOL/1CmgXwPVTGcWOu5ZNexoe1vq5JvHrkXIfr3hb4w1KhTkv90UyRuAf9ODsazOcGhjlEd5qQ6f4JKXbB7L+C8zsXftmO9mWM//PZnK8A+iKdWhNh9+uaDIfUbIS8jYQ/ev7eAB9JBjp/ezs4hSp5hRqJTFvE4RSTWUQQynMPZeTmCtL4zbd4DE/BUP3Q/Fa3O6O0vsZm1FnhIk42eGENBBmeDqPDtXCN+LLnbKRNRll+Ysm+TO16b0lwTKAQQXdNYuv9cShRS98MjDJqFrYvrQ6yiPZk2+5Mi+DDn22gfDEUbqrq828UyNNaLLcbPkv367WS46ZOJp8TMn4dVALOtoDPBgw5H4UCSBaL2ORzh5t+0rvhn8cmu9Euo11C4ScwsuXHqcTHGvTp9AhplxCQKglOqRCEGpyay6vKezDBvyLd6JCefqEp7ZLQ==
X-MS-Exchange-CrossTenant-Network-Message-Id: f41414fc-bda8-44e2-873a-08dd477d506c
X-MS-Exchange-CrossTenant-AuthSource: CH2PR19MB3864.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2025 13:42:50.5188
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 753b6e26-6fd3-43e6-8248-3f1735d59bb4
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /XVp7cteJXQ7TXTbGPw7ueqMb6MFM0e0PRiOvLevKUO+bjGgMR2GY8vN1F9CtL0QteHTsSnXHiPNVY1cIpCL8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR19MB7841
X-OriginatorOrg: ddn.com
X-BESS-ID: 1738937707-102379-7526-9932-1
X-BESS-VER: 2019.1_20250205.2128
X-BESS-Apparent-Source-IP: 104.47.56.176
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGBgZAVgZQ0MAoKSnV1CIxMS
	3NyCTNLNEs2SQl0SglzdzcMtk40TJJqTYWALbvhwBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.262355 [from 
	cloudscan17-35.us-east-2b.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
	0.00 BSF_SC0_MISMATCH_TO    META: Envelope rcpt doesn't match header 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS124931 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MISMATCH_TO
X-BESS-BRTS-Status:1



On 2/7/25 14:35, Luis Henriques wrote:
> Function fuse_uring_create() is used only from dev_uring.c and does not
> need to be exposed in the header file.  Furthermore, it has the wrong
> signature.
> 
> While there, also remove the 'struct fuse_ring' forward declaration.
> 
> Signed-off-by: Luis Henriques <luis@igalia.com>
> ---
>  fs/fuse/dev_uring_i.h | 6 ------
>  1 file changed, 6 deletions(-)
> 
> diff --git a/fs/fuse/dev_uring_i.h b/fs/fuse/dev_uring_i.h
> index 2102b3d0c1ae..0d67738850c5 100644
> --- a/fs/fuse/dev_uring_i.h
> +++ b/fs/fuse/dev_uring_i.h
> @@ -172,12 +172,6 @@ static inline bool fuse_uring_ready(struct fuse_conn *fc)
>  
>  #else /* CONFIG_FUSE_IO_URING */
>  
> -struct fuse_ring;
> -
> -static inline void fuse_uring_create(struct fuse_conn *fc)
> -{
> -}
> -
>  static inline void fuse_uring_destruct(struct fuse_conn *fc)
>  {
>  }


Ah yes, that is left over from earlier patch sets that were
still using ioctls.

Reviewed-by: Bernd Schubert <bschubert@ddn.com>

