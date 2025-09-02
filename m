Return-Path: <linux-fsdevel+bounces-59981-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C02C3B40060
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 14:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CCA81887888
	for <lists+linux-fsdevel@lfdr.de>; Tue,  2 Sep 2025 12:26:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763602F6176;
	Tue,  2 Sep 2025 12:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="a2MgUM6G";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="o37vbAW9"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 620862C11D7;
	Tue,  2 Sep 2025 12:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756815976; cv=fail; b=NmGe7ifNprCxKkfqey7GtA4nS6sKweZjmehfCf4JcZEIsjquck8vWa0oD7b0zXcU4YlOZ18fHLa01hRFmyWZwLgZ9JlngebibXJZJXiM3kjZK9PrOpUS30wtklJfXQusQQhig/fneYH2WrmmCtRndTWBV8Nehp7eKjuqAT3iVJU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756815976; c=relaxed/simple;
	bh=05VNB64+q6NefcyBWJuH7miCaozVzTNlHyJ7VqvMCZM=;
	h=Message-ID:Date:From:Subject:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QsGlrS8r78Kg5ZrxfTOjFveNuYmE5rX0gQgMXT0xoNTUSFSmy/pikrCUp5khtUgtOSQdIVYVE4G0LHLgR4wG1xI7DX3NGz8Xb5xDZqMO6/vGs+cFB6/GWexEAaJTza5ARWNwlLd0owlxFC06hG+7b3gAiMcEl4oBzYzh0DalR5k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=a2MgUM6G; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=o37vbAW9; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582ANfka031330;
	Tue, 2 Sep 2025 12:25:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=/m4gTB7J2QUivKKaSYs5HI/uwRtau02sZWzOIyTYwP8=; b=
	a2MgUM6Gmifzs9M+NRN7pgKu+8m+13f2dfSyoK77L2uUoL5FCdlE7c10Ly+hrvYU
	DDNlPymUEMkk9kYKyxoF50Cya30iN8/XC5efiPnzfbdW61DK1S/rt4dlVkaxa40p
	/rk7OgEi3t+F/+uMExeh6+uKgU5oa7Kz2oQGquJPwuY4s4c+7OY97V4hB1NAUsRA
	c/Cke2FSBcVJv5nnR5HW24d1wOs8560cgImEeE8wp3vk8Baa8o2uErSdSTdvVaRU
	iGhXXM0ktVrJCAsgBecbpux0D+kvSD7SNf1pN2Mx6rCH01z2ZAn/ic9GB9EeJDNd
	ed7VQZ/j77YKXCVW6At4Fg==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48v8p4kd82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 12:25:51 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 582Bi9DA040090;
	Tue, 2 Sep 2025 12:25:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrf38sa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Sep 2025 12:25:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kDZ8SLznug75LIhaFwRrzprePiaKZSaT4ubcl3KXgnNIJlc1VcRTc5woyDzu40+rz91RNVYnViM6l5rDXBdP7sjV2yODkHueM3N6+9ufjFv8Qnp1VWQzU2zeqRHKl/Jm3cptWgJylk0JV6ZAgz6Vg9+6xhttSUYojQb/5RijHoeX9yRTyjYQ12nyE8QoOdETlrhgAajtiFse7HoiEc9SO0OYMpIKiqR/lo9V3FhwJHcoubhBrOpLnqtT1CZXTzSyUhcEz9KMdU4PxygDNB/t5jD6lOnXI6kb5VQ7RCfLhCEujp/RsGVQd/l81I7o+Xh/ywU1+DzmFX0FiZY+Wvw+Bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/m4gTB7J2QUivKKaSYs5HI/uwRtau02sZWzOIyTYwP8=;
 b=vhys19ojv89HbxypCyjz7hQPL6al61zUobHv8MrEGEephMAUL5VXuPmZybs1HiFq5xw1HPN/Dn8JuNF5LVwKWg7QBji/X0b1dxwQY6Hq+4d5cfBk2pE+EJCIP8LTmcwEq3Ux3sjRlZOtCrfahPbrJTFMOcwwh2lWrgs1NfAm05uFxHT7xwDUoCNatlR3rYCX5+ZjRuGRh/oLkVyXNOyOhTFz8AOs5yGe7w/su0kG+3ziog0FR7tujDTB31Ae6goGTpaYu+HgUbHwGE4aDZQvxvalI5P8oG4pATL3c5jA/4z4CA8fh+cg2a8DxUqH7vaAPWHLaMpWz5Rs7TR8Oerjzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/m4gTB7J2QUivKKaSYs5HI/uwRtau02sZWzOIyTYwP8=;
 b=o37vbAW9dVkGD98YvG5VALcDnKN7xjWj1Eq2AdPk1tjGs/b1qiLBFZiv+k8gj+d06rwRdOboBinWP8N2bGgN6ioeAv57QVvDMLj1jxaLocpSpKDXLiTfaDyhjvpT23Fst/unP4jtO63Pyy9ofTuQ8B8LMsFKGMXniDj3m2NIBFA=
Received: from MN2PR10MB4320.namprd10.prod.outlook.com (2603:10b6:208:1d5::16)
 by CH3PR10MB7308.namprd10.prod.outlook.com (2603:10b6:610:131::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 12:25:46 +0000
Received: from MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c]) by MN2PR10MB4320.namprd10.prod.outlook.com
 ([fe80::42ec:1d58:8ba8:800c%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 12:25:45 +0000
Message-ID: <5b0fd2a0-dffc-4f51-bdff-746e9bd611bd@oracle.com>
Date: Tue, 2 Sep 2025 13:25:39 +0100
User-Agent: Mozilla Thunderbird
From: John Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH 1/2] md: init queue_limits->max_hw_wzeroes_unmap_sectors
 parameter
To: Zhang Yi <yi.zhang@huaweicloud.com>, linux-block@vger.kernel.org,
        linux-raid@vger.kernel.org, drbd-dev@lists.linbit.com
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, hch@lst.de,
        martin.petersen@oracle.com, axboe@kernel.dk, yi.zhang@huawei.com,
        yukuai3@huawei.com, yangerkun@huawei.com
References: <20250825083320.797165-1-yi.zhang@huaweicloud.com>
 <20250825083320.797165-2-yi.zhang@huaweicloud.com>
Content-Language: en-US
Organization: Oracle Corporation
In-Reply-To: <20250825083320.797165-2-yi.zhang@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:c7::10) To MN2PR10MB4320.namprd10.prod.outlook.com
 (2603:10b6:208:1d5::16)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN2PR10MB4320:EE_|CH3PR10MB7308:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e5a5859-350c-472c-a799-08ddea1bd6e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|7416014|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a1ZabnlHSjc4WkY5dVNHazM5RCtnRHBrTllBcmoxNnkvaEFUS2dWM1hUVko0?=
 =?utf-8?B?ZjBMK3FER2YyU25HQWkrZ09yTkxEaUtsbjQwSHd5QUZTT3lNN2RhalpuTkJQ?=
 =?utf-8?B?cWpIOW45TXJCUS9ubDA3bjZERlBBdncxbXBUNWF0bXdmNlNsekEvbjNpTGQ5?=
 =?utf-8?B?cS9oWFhqMm9zZHJXL01MeVFac1BWSU9maTVYVzk5TkZFWmJSVllmcUE3emti?=
 =?utf-8?B?cmlzTXRXenFLYm1oOHByS1RNbTFyUUtpbnk2a0I2RDVWQWZzT0pBL0h1VnNn?=
 =?utf-8?B?K0pSYmwrWHJQb3dtK2RQeE1iQmRyQ2NxWDRaN1pnc3B2WXFGLzNNOGVMaWdP?=
 =?utf-8?B?K2hZVkJNbnkrbnlMK1gzblFBQlJ6cGMvR3VzZno2QkJqMXNRU1Y1cEc5TTJU?=
 =?utf-8?B?aFpCRHZHMS9Xc01UNjUzYkZyT2MvS0xQbGxjeFVQL2U0ZmNDT08yOTY1M1Vn?=
 =?utf-8?B?TThmTDB5NmZ0cmFtV3pjK0t1ckhJQkt4NDRxaGgwbVBpN2VOYy9DNEZCL241?=
 =?utf-8?B?VWZldnlRQnFZMktTaVA0L3BkR1FBWDdVMW5jVzRkMTU4U3lMeGdjNU05Y1hF?=
 =?utf-8?B?OWV3aUIrdnV3N1UweGVCODgwSzB6Yk5OWUJWOS9uK3lWaGxWVWcvOHZWVmhG?=
 =?utf-8?B?UFZkWjZQNElacGQyS01DNVFsQThubXgycGVlcFdVVkdFOUpQOGhmRkg4cW1L?=
 =?utf-8?B?VDZDMVFZZkEzakd3aHhQVWNzN01PMDkydUVoQVJzUlhoWDUzSkdLakREV29s?=
 =?utf-8?B?N2QrNDZob3lualROaWVIbjR6T1FJK3J1UkdoMWZDZ2Q0akF2dC9XdlZXS2pE?=
 =?utf-8?B?UUF1N2xMSjl2ZDhDUzhzaXR5azlnVldIM2VGeHlVR1hpS1pwWTRRRlplRU53?=
 =?utf-8?B?QmFCemg4c3dZaituTW5UYzByN3ZET2g4TFpQUHBVbVZKSG5udms5clRTU3M4?=
 =?utf-8?B?V2xubFUvcnpHenZUT3pNYVpVUCthZVE4V1lKdHNTQlpzZ1VmbEVVYklDZzQy?=
 =?utf-8?B?cUxPeHIzc1NiajJWMk1ueTBWUVl2eUZySlNLV0FPSFpWdzZlWXI1b3hqN01v?=
 =?utf-8?B?V3VNWUY1OTZrY1B5VDlPNG5aeXp0UHZkWTNsZjdhQzJPejRjQ3RqNy9lMnlx?=
 =?utf-8?B?N1VMalloalRCb1c2ZVplaUdxbnNlK1BGTndWK3hWdngrRVdmRlU0U2UxSXFk?=
 =?utf-8?B?SmZSY3VyZ2w1ZVlyVXhXd25FY2xMTGtjQjNqR2tnMVNMbGhyM0tPRi9LZ2ky?=
 =?utf-8?B?eUI5elJFUm81VG00RXVHRmk4UjdTb2h0eVFmRC96MWd2aEEvVFJOZDBqNTht?=
 =?utf-8?B?NzBnaGQ1aG9xbWxyanFYeXZLQ3NucWtPa0QrZ0FCSXF2Z1k4SnBFOGFPbExG?=
 =?utf-8?B?UUY0c1Jxc2NJOFlHT3VhbFc4cHlZNXVxMFJreHVpSkhKMkVkallQdWV4UUxJ?=
 =?utf-8?B?UVlIWlFzR0J0SzFaWGlRMnN6VjRXWkx3M0FNNXd4aHk2aHViTGtoTlloeFlq?=
 =?utf-8?B?SXJIYUx1YmZhK05MVVlZVEJoUEVDWFhFbGRBM3VEcHBYaUdLQlNBalRWL084?=
 =?utf-8?B?cGhkZjVZb1RybUpaVE9jTnJYU3BTUzM4QkprOU9EakRXR1RMR3NlTi9kV2t3?=
 =?utf-8?B?UTdZVGF2UzlpRlBWdXJaOENncWVGbTZzbDBEWStoSFlnWWtralpxbzJ6Rndh?=
 =?utf-8?B?eDRyV1g0VVJ4S2s3VUZObGZTekdneVNZeG5WL3ZFRUxpaVhMNFBadkNqUmFx?=
 =?utf-8?B?dWJhVnk1ZXMxZTE3SXNYZ2Q0QjNER25YQmYvRkhvdkowUDB4QWw5MDQ1NkpL?=
 =?utf-8?Q?ZUI7MB6XKMTLky/JeI8I13BwQs0Sj6D6kafSs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR10MB4320.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RENxdlo1LzcyVWVPQXB6RWNFbWtYUWRLRUpMbk00TEg3RGtsZm1KVWFSMmdr?=
 =?utf-8?B?cWZXaXNmZlFrdFZadjhsT1hBUXFPRFNTd3kxQmdSeEZXSXNjVm5FY0ZMOGVy?=
 =?utf-8?B?QkYxeE5yblFPWmxnZmM5aUVJZVhJcVFzcWxlbnQrNWhsUDY3MGxmSGtXa2do?=
 =?utf-8?B?cWxkMFRQc1NJL0swdmR4MUl1MzNUMVA0MmtVQ0JjL0ZiOGZNUCsvM0wzcERr?=
 =?utf-8?B?T2xtOVM0VDNUNGpjWXFKRTZ1UWVCTzhyZGxWWitJSGYyd3h2bU11czhFMnBE?=
 =?utf-8?B?QVN6L2NrTTV1dk00T0RubWNaMnYwSkVRTDdndTdBV1FmcXhNNmJ1d2lnRjJE?=
 =?utf-8?B?UlBGd01TR0tWQjh2WkhTckUwcWlNcGFnOTV5eERHYmJCRCtxT0daVWhVc21G?=
 =?utf-8?B?UUNtYXF1V2t3VThIdURTekhEUXdJUHFpb1ROWlJaZWFrWG5ZQzdzQWJXdmpu?=
 =?utf-8?B?bVJ1Z3ZsZHc1VWZaeVR2VTQwdE5PYU5VcGZncFVLLzZnQVlWSzlDRVpPc3Fy?=
 =?utf-8?B?SjljM1VYTGd4QllmaEsxWWJJNHRBNUlMcStWa2RQRWJqM0F3N25raEw5bkxU?=
 =?utf-8?B?YjVHWXBrS3Y3SlpjVkJ5T09TVnlremhpNWFuWnppazFUWGkydHZCdTFmMFRw?=
 =?utf-8?B?cmhTckNsQ1dVZ2x0enVWT3VadUhCMjZnTSt6QjRXZ2F0SEZoaE96MDI4aENS?=
 =?utf-8?B?Qlk5NmlmY1VhTjdrNEYwb2RIdUZrRUxRQVNjbFVJZW8wb29tZVFHcC83VnU5?=
 =?utf-8?B?Syt4MjE1WFJSK1FENHpPclJzNFJ4L1N3VTNqV0wrcFVPYm1wTUxidGxrTVEw?=
 =?utf-8?B?NXNRcXhmQ1lyMGR4N2txOVVQVG5tcFk3ZW9mcmhLV1huRzZCSUFiL2tmTjNw?=
 =?utf-8?B?empMOW9iMEdBQlBuVVFwR0JPRFVCSVZ4amVmZnZBcGFKemNlU0l4Z3Zrb2Q4?=
 =?utf-8?B?ZFNUUU5yMVBpcHJCWVBGT2pkdmVSZGE0Tk5EYXFKZFJ3Q2RDeUVrR2NEZTZo?=
 =?utf-8?B?RWVBMVg1TTljNGFxK0wrWnpFOWJpamlyb1B4eHRYTGZtM3dVV3l4Q3A2Qjhz?=
 =?utf-8?B?MXk1VWlONVNORVg1RUJxMUloN2lOVERDKzJEMU5VdkxzNWkxNk5oRXJ4cnZW?=
 =?utf-8?B?NGR0ZW1zVStrRjRTYXdYcnRCUndxN0RGWnVsTlhqN2JqeWMxckw5RmhLSjRj?=
 =?utf-8?B?c01tdFZIV0tQeGw3OFcrbVRzZ3RtM1RoalNGK0hyTmVwQ0VJdUFlbCtkSG9U?=
 =?utf-8?B?MGl2K29mSCsxeXhHQWZBd1c4bXlQejk0cnhLa3lWK2JnRVFjU3Q2eENtdU12?=
 =?utf-8?B?eWN0M3RRa3REdHhNKzhWR3lLN1FSSWFleStyeWswWTI5WTZnM3ZVVkYzSHdS?=
 =?utf-8?B?dW1PSUxPT0R3MlZtMEViYlVscUZZREh5MEtkOGZ3dmNjMDdDTERwbWo2Qmp3?=
 =?utf-8?B?dW9BZGNiU1FQWHBhbGovaXNXRWZudUlZK3ErYlJsRUdSR0I0RllieTFxRFZu?=
 =?utf-8?B?R2NveHhWQlMxMVJ6SXFhMW5sVFJMVDZjS1VwcFZMQUdiUHVxZitCYkxBZENG?=
 =?utf-8?B?clg0T29wYVBPN1VlWVdlTHlHSk01ZFkrTG5TZEs2OFNqYUtVb1ExbDR1VDFW?=
 =?utf-8?B?R1owbFFxVUI0WS9xVTR3T282a0l6MUxvUmk4MDZHWGNiZE43bU5Ea2FHcjI5?=
 =?utf-8?B?TnVqUDBISGdINVkydTREb2MzcG5NMzBkVEJrTHNsNWJ6YnQ4M2hSVWkvYUNt?=
 =?utf-8?B?bzRMUXNaanA1bTB5WXZMS0JkNmtqM0ROQXprc01NL3JSMnAxWkhpellXdGhR?=
 =?utf-8?B?anprUGNlc2IydkZoWmxwWGhNOGdhZlZWMmdpaVhKOU9lTncvMjh5MzlQL3RH?=
 =?utf-8?B?eWEzUy8zRWkxU3BtMTJNb3pOeHpicGtoV2RteFhsYmlCRWhRREVScHJLdTdy?=
 =?utf-8?B?Y0dNY3BPcXo1aHJWcVEvKzArM3FqSmV5bXhhZnJNTitIaFowUXJzREpndXUv?=
 =?utf-8?B?S2s0Zlp3U1l1bTFNazhNbUUwMXBaZzRPTUFWMXE4VnVlM05CTytKTzZZRmIz?=
 =?utf-8?B?NDRnYURWMHBDR1ZQME15K1NKRVJZdG41N3gxd1FlK3JpdDdyVU43d2xybUZJ?=
 =?utf-8?Q?zuBC8umhKzt6TOM9r+vltXTSL?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OReFcJTJ/J4haArZ3fR8gUb5TabyQ0o2PMebdzVGsdY5SeOGUp94I0Woqa/ULRyYPAU91CRrbQ0yzyX/CDmc6d4wAVyrIXBaF7F9oXcamGemzcADaWC4jetpGS/kUxipaiQ/sDQSO0zQhWkJ3LhpF3VEruFehXBGDj9PdXy9/y055dShLJnk2ErjUs76gLKUkY0uU7UJNfViPpx0FqSAaasoN5F6cRvjiB1iWQdCTKQyiWWA+rFdx4bdwU0fKfGAvRBmu3wYyGCOBMxsxMNWRi8gyfgKxRvqk6dj507WXaB3HGva94mns043QHAU9eHWDyq5zsKJlC7+vNGPrSNmQKAVb9pGP69/ant2FHzUDWAuxht+26NzSeJLTqAWtKZG6MgPIqq3rnbw4TBwvfYdc3zfZVPpXVMchxqiGtzfUKu54AmNRQJI/RN8iAVbTu+rwrW0IEV2Vg9IP7qRWxUVYlaNjkQs30m5rkQeIh85cNhOX4R+hHrI+S0m9sHsl6wMQ6qA5FrfjeQd5Z9yWz3f+e+poL+4s6uitrIDpYGD6lK3+PUBsuIQ1Mj5ZzDaoi2cgOrl1ipnoV6Msz1LhicJyfcGEm1Hn7KPDnLpF4QgBqc=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5a5859-350c-472c-a799-08ddea1bd6e8
X-MS-Exchange-CrossTenant-AuthSource: MN2PR10MB4320.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2025 12:25:45.2694
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E9PKNiUe9rP/pJNYsmlrbMtXKr7LN/F8jg6MDlVV0+q/SYgNDLPonYZk5fz0Nkg157aDaFHiUCkjWX/qUAI41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7308
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 phishscore=0 bulkscore=0
 adultscore=0 mlxlogscore=999 malwarescore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509020122
X-Proofpoint-ORIG-GUID: cGSJ-zBYGK8yi_7zE_EJYhoe_O46DEmT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDIyMiBTYWx0ZWRfX0I+SKYPPb+nz
 bAPfUQGx3aRJnkxxKDE+EWrSr1eg8PX6MW5xDyqZ5Gtx5FnZN4t6N+baDiE1afEKZ9fEPxFZ3Ck
 Xk4Mi45OFefqaphJxejIMKdfmVJv6Rp4G6sBzbXNCu5aALkAv+QxN7/KNeWzRJ6THj7HqkRbUbf
 U2f9cIFOrhEAj/5FC91gDJzCVvFFGllsEZJHkfCcsGbqoI9Lt2zwEVenoHQHmUCieUQwv7tABwO
 pB7KXk4QouT5nsX57k7o0F1s26BQ/37QeraFKk/z2IvyEYryEkaOxypMDSVQKyvEnSZYMOLp5LH
 a3mzp5gfZYoND0TWn0KYLsEWrwtf3938XditNSyr8llYlkxxdcuNZOs5hBczBXf1xwM1R6pp0K8
 YVL9Hmj6U0GUVEfIoIZqEsaTTH+RvA==
X-Authority-Analysis: v=2.4 cv=doHbC0g4 c=1 sm=1 tr=0 ts=68b6e24f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=yJojWOMRYYMA:10 a=GoEa3M9JfhUA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=i0EeH86SAAAA:8 a=lvo31q2j7KoqIwRptJoA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12068
X-Proofpoint-GUID: cGSJ-zBYGK8yi_7zE_EJYhoe_O46DEmT

On 25/08/2025 09:33, Zhang Yi wrote:
> From: Zhang Yi <yi.zhang@huawei.com>
> 
> The parameter max_hw_wzeroes_unmap_sectors in queue_limits should be
> equal to max_write_zeroes_sectors if it is set to a non-zero value.
> However, the stacked md drivers call md_init_stacking_limits() to
> initialize this parameter to UINT_MAX but only adjust
> max_write_zeroes_sectors when setting limits. Therefore, this
> discrepancy triggers a value check failure in blk_validate_limits().
> 
> Fix this failure by explicitly setting max_hw_wzeroes_unmap_sectors to
> zero.
> 
> Fixes: 0c40d7cb5ef3 ("block: introduce max_{hw|user}_wzeroes_unmap_sectors to queue limits")
> Reported-by: John Garry <john.g.garry@oracle.com>
> Closes: https://lore.kernel.org/linux-block/803a2183-a0bb-4b7a-92f1-afc5097630d2@oracle.com/
> Signed-off-by: Zhang Yi <yi.zhang@huawei.com>

Tested-by: John Garry <john.g.garry@oracle.com> # raid 0/1/10

> diff --git a/drivers/md/raid0.c b/drivers/md/raid0.c
> index f1d8811a542a..419139ad7663 100644
> --- a/drivers/md/raid0.c
> +++ b/drivers/md/raid0.c
> @@ -382,6 +382,7 @@ static int raid0_set_limits(struct mddev *mddev)
>   	md_init_stacking_limits(&lim);
>   	lim.max_hw_sectors = mddev->chunk_sectors;
>   	lim.max_write_zeroes_sectors = mddev->chunk_sectors;
> +	lim.max_hw_wzeroes_unmap_sectors = mddev->chunk_sectors;
>   	lim.io_min = mddev->chunk_sectors << 9;
>   	lim.io_opt = lim.io_min * mddev->raid_disks;
>   	lim.chunk_sectors = mddev->chunk_sectors;
> diff --git a/drivers/md/raid1.c b/drivers/md/raid1.c
> index 408c26398321..35c6498b4917 100644
> --- a/drivers/md/raid1.c
> +++ b/drivers/md/raid1.c
> @@ -3211,6 +3211,7 @@ static int raid1_set_limits(struct mddev *mddev)
>   
>   	md_init_stacking_limits(&lim);
>   	lim.max_write_zeroes_sectors = 0;
> +	lim.max_hw_wzeroes_unmap_sectors = 0;

It would be better if we documented why we cannot support this on 
raid1/10, yet we can on raid0.

I am looking through the history of why max_write_zeroes_sectors is set 
to zero. I have gone as far back as 5026d7a9b, and this tells us that 
the retry mechanism for WRITE SAME causes an issue where mirrors are 
offlined (and so we disabled the support); and this was simply copied 
for write zeroes in 3deff1a70.


