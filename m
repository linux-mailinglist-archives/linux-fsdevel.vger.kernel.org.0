Return-Path: <linux-fsdevel+bounces-76519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KIjTHI5XhWkhAQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76519-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:53:02 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB5DF9766
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 03:53:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3149B300B1AD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 02:53:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0691E2949E0;
	Fri,  6 Feb 2026 02:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="T7elEdTZ"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480421C860B;
	Fri,  6 Feb 2026 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770346376; cv=fail; b=skvX32bX8uV19JmWxMm6lrLj6KyhvBJs7D+x/lLqCpmVCWYtdsyYb3QLW71lMip4rQos8EJDA85vQH2n4ZuvqdkmfW5SYDa1QLFLZxPZVx7Ox6+bFRZVIPtdYXbuqe/KfaqHWO5NPvCUFRo6RUk7W1Vk7Y4nqrfjebiF688DGHE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770346376; c=relaxed/simple;
	bh=WZcw1wHRkGNt936RbnwoUFaauPG+Q1Bpe1jbe7V7n1I=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=M84DmZ5HhHQGPXa3YcrOpRDYcmzx6Pdj3O1zcdtjzwm4rq3FlIG3IWMsFHEwXwNZIqUVOfS3jM1JJo6NaM/8dTAVf3D5R6vEL+JulGsG4cIH9JfUwOLFVQxr3vde+1yMeYQYVMNYlXxR6QMMZXF77K6XcdxC6nTMig1GXncBDbI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=T7elEdTZ; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0148461.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 615LGPYj2800695;
	Thu, 5 Feb 2026 18:52:42 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=niQs2J98h4WqtNNqMW4J7dch1lkxPqHe/HVEYnqb30M=; b=T7elEdTZxBW9
	ss1456FgvJIGxZWKnVsnHwQn8o61ZoYt0eQAXLjOf5BE2Frjtpi1CFAqWP+QES3Y
	jIBedZ7TSqHIJcBldUoJyFdHAqEmS7BGlgqAoQGQWX0WzmNluJIP8oBjtiF5iNY8
	ophJ6GEboJhWQSlVpkqXoQpq60c/QaA98zsx3wZde+URjjTH1EmH/MRtXi04VeNe
	8nygXT6/toOE+lRoGjE+FKiHO1geCxl1KcRntaR1NW+lrEfZPUKBvvkHu1mEBm/i
	B801qlX7uprljoLR3TwZKafdn6BUVMrzdzuZwtsUbZ8Z2l34mvDcuLD1nSdrCB9Z
	t+GvDaChXQ==
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010044.outbound.protection.outlook.com [52.101.193.44])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c52ysu13k-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 05 Feb 2026 18:52:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j81TVrzXqY2ETN41IoyUrEelwlC2ZkzbwEjwJWLHwTG3XEpOhyxJz0DinZPa1rtLNVHYd5W++p1OUrp1uPHMH7aGjasM+CC0qtdu30x0omGWIlbNBa9s5XNOUIgVVZ3aZ/sIBtoHiylS0WmxZvZ0Mrf1DdmxEZXZxoY7jkvHy00lKe1ROL+iEaTt7mmN6oGS1TZHzq3wvY/3ncFMbT4d65j/JUJvdXpqAdfa285jElrlfxrMHKMe2u1HZVguSWj1r+IziZ/K045XdlJSIebJYNLpyswhGui+8gGVX/CbBueUOzohwQUxj5xalmLCuK293jsRfe1thGk4MGgSOBNSlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=niQs2J98h4WqtNNqMW4J7dch1lkxPqHe/HVEYnqb30M=;
 b=VRprBTutS3dvEdu/S8q1SsW/yj5AaQ+hynAOgf6bIlHvk5HwZQDtbiJR7BqG7rmwia142Oed5GWVi8UWwz45NC/WnvYT1Rz9jiUfYa6r0UiT8ozDpCOVCBZ56yTr4P4ZTug77HXh6wZHksPgShViNAztJJOBXu9Sp11bQSlmA+JFdqIP806vg1bKRA69AXFL3SvjrZeMekbPuKWrdbXYV92ie8QaGE9WO6RRlA3mjUaZgBQssTjrMhjgwVYLY41q2WZCC+gzFcUnyQJiSBT8EtRGJWME3nOuBnCmTtqEtQFwGNTBPiNYAS9mjqF8kZvHJJeSbGqeYv0udOIKOrGpJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from LV3PR15MB6455.namprd15.prod.outlook.com (2603:10b6:408:1ad::10)
 by MW3PR15MB3882.namprd15.prod.outlook.com (2603:10b6:303:49::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Fri, 6 Feb
 2026 02:52:39 +0000
Received: from LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5]) by LV3PR15MB6455.namprd15.prod.outlook.com
 ([fe80::444a:f42c:1d70:40b5%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 02:52:39 +0000
Message-ID: <91881ad9-62c0-48c1-9cfd-e6cba6ddb587@meta.com>
Date: Thu, 5 Feb 2026 21:52:29 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/31] fuse: implement direct IO with iomap
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: miklos@szeredi.hu, joannelkoong@gmail.com, bernd@bsbernd.com,
        neal@gompa.dev, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
References: <176169810144.1424854.11439355400009006946.stgit@frogsfrogsfrogs>
 <176169810612.1424854.16053093294573829123.stgit@frogsfrogsfrogs>
 <20260205192011.2087250-1-clm@meta.com>
 <20260206020832.GE7686@frogsfrogsfrogs>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20260206020832.GE7686@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MN0P221CA0015.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:208:52a::31) To LV3PR15MB6455.namprd15.prod.outlook.com
 (2603:10b6:408:1ad::10)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV3PR15MB6455:EE_|MW3PR15MB3882:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f5fb70b-1b13-4f70-be2f-08de652aca7b
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cEpLcVpISklNTFlWYURpODFUendPVVRnam5oRGZZNFJUUnFGSjRMNzJzNXJy?=
 =?utf-8?B?Wjc1eHliN3NndE40VEx3ME1aNUcyVzQ4a01wYlM0VGZWL25POHFtczRHdmlU?=
 =?utf-8?B?MyszSVlXTFFqQWhFZTNLaTIxeUN3b0pWRm1NVlZzQVZ4dVFtYUxTUjBsWjNV?=
 =?utf-8?B?bjR6ZjhhY3o5YkhTWC8rY2xGaWJONWJ6VmpSTkcxdko4c0dDRi9pZXdOZmpO?=
 =?utf-8?B?clNjWGlYdzZobnBEMXBjNVN4amU5ZnhIa0s4Z28yRGljWmwxWkJKeGtiSEtv?=
 =?utf-8?B?OGZhVzFMNEFNWHM5MFoyME1Rdm9WUlVvWW1udUFXaVhUc3FyaTlRS2VEU1JC?=
 =?utf-8?B?LzVMeVVEZFkwa2p2aHF1TVNFNzkweDE3ak5QK1JqbloxZk5rUndnMUg5SUd1?=
 =?utf-8?B?WCtUWXlyL2xkcGoxaWhxOUpkb1NtRlgzQU96NnhuMVEyMVVEL3FmczBuZzhQ?=
 =?utf-8?B?N21nTkh4SzVQVTJpYjVKcU5seXNkUk5EbjVVWStQZXJVRG1jbVVnVVVOSFBv?=
 =?utf-8?B?OVJya2RtQU9QSkFJUDgrWGN6eUE0UUJLQkpzcFpBWElHVEQyb1QxZ2FETEFW?=
 =?utf-8?B?bGVySlVPaWx2T1NVbENGbmZFQis3cVFKbzIxM3o1a2RZS043WVJURUZGSlo5?=
 =?utf-8?B?YThGTkNVQkZFN0RNY2ZGVUtCMnBPZ2pramZidUtUditXUHg3bG0zNllNOWI3?=
 =?utf-8?B?OVllTjJ3MjBLNW5FWDlkVTZTSG0zdDEwUkc1UnM3UWx4SFlxdHZTR3FqcnFH?=
 =?utf-8?B?SkNjRUxvZVRkdHNicGh5MVVURW9YWUJ6VEZ1Y2IvU1MxOFB0WldUMHppWURD?=
 =?utf-8?B?YTJWbUZFamZTK0ZHTk9PeWlYQWpjZEhIZFBmNmMxNXFYekovS0MwRVFQMjlp?=
 =?utf-8?B?Wmw0eldkOWJ3Z2VyYmRVRi90Zis3SGFyOG9lVENtcGVPQU5iZ3pTY2RNU05u?=
 =?utf-8?B?bkxOZDdtWnp2dU45MmRKSU13cXd5dEx2YThlVmYrUDBRN1NIaUtEU2tmZE4x?=
 =?utf-8?B?MEV1R05lZFBKdFVMWDBzdlJTWG4xOHJKOWMrRW10bFlDZ05RUFovemJmU3lr?=
 =?utf-8?B?OFpQcEhNMzBGNTIrMnRjcHJBdzlqSlZFaTFzUE1vTEVVS1QzYzVCQW0zRFpi?=
 =?utf-8?B?c2NpWkZ6cDVySmg5bWo4K1hPNWtHYUhHaXU4cVdCbHhNbzYwRmNNT3NyQkF5?=
 =?utf-8?B?NlZoWjlZb1JPVW5kaXJqdlVlQVpUM2FzRUVYNTA3WlR3NVVhZW5VUlJqWGNV?=
 =?utf-8?B?R2IxVFF1bHBnb3Fuak5ITFNQYk5FNG5obXc5V3R2UmxMQ2hZWEN1OUhSRmNN?=
 =?utf-8?B?ZnVTRkNvVVhwaVhWUjdZajJmUENLS01CSHVKSjFxZmxwcXVTbUxQTUFDeTM5?=
 =?utf-8?B?ZHhwU3VGLy9janBnemdZWStjZ1RNK1JKc3kwdUJrMWRXWkh6YzlpQ2VzV3N1?=
 =?utf-8?B?cXFJSHFtYmw1eDNqMElKOG43SEkrSFU0U3k2WFJoTGNRaW41MGQ4bGhmMFpT?=
 =?utf-8?B?NU9Na1ZKZy8zT21UcnZjYXp4MWx2ZWhMMUMwbGIxS1ZxNDBWSTJSa1E2Z2xY?=
 =?utf-8?B?MllhcXVVelpoWEIwSEt2bVozOGZFdzdidmZlbEJzaGd1TnBOVzUyRUgySkJU?=
 =?utf-8?B?aWVTUS9YMWt3Z0RHWHduZnh3bzNoNzFqbllpd3NORVZhTDlsNVdGTXI2UHJI?=
 =?utf-8?B?cUpsQU4wWEx1dnlpdGdSNXVPdlZDb1NoUk9BWVE3M3RHTTJ6eFd4WWRLNEs3?=
 =?utf-8?B?R2JJa3hZci9kdHhFMGZKOW04VGhlZDhGT3ZPTWwyYmNmUXhmTnh4aVNKRnRG?=
 =?utf-8?B?R2d6Q0RkRWFtdSttRWpKWk13QVliVWk1RkxjYzBYTEh4TmFsWENKWVRhYXBi?=
 =?utf-8?B?VmtqNjdUMmViWWJqRTVrRWJ2MThoa2kwcGsvVi9BV2VaclRvTnJZeFZlNmdh?=
 =?utf-8?B?M29oMmQ4K1VEVW9Cc0ViMUNFNGE3dDB4eG1lbzJNVWlLeVJPT0tyWGkrT1Vv?=
 =?utf-8?B?WWd4N2ZDMU1EMUxNOEZLSFZxMlJXTDVCbWo3TDJWYU9QN3pGV0ZheTIyT3N6?=
 =?utf-8?B?ZXlNR3JKc2FyRGpoa3NOZENYdlB3SnNhMUhSU1BrV3NqNVA3ZUdnc09Qa0hs?=
 =?utf-8?Q?kDeAh3TvuU2a+6l3AjPIbf/XO?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV3PR15MB6455.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?VUlQekF6c09CNHJDWWtGOXV1dUdKRzJpQTIvWlovZEhmM0h6dTVReVZ0bFN0?=
 =?utf-8?B?UWNsUmE1MzJNcVBORER2Z0cvZzdTSjR0NUJBQzdvNU85RS81bldYUElnRG5n?=
 =?utf-8?B?OHM2WjBFcTZ1MUsxYnlMdXNyUG83bzBwY3J0bUVvOSt2NGlDM1dkOE5acktl?=
 =?utf-8?B?emVvL3BpeS8yQVlXM0tjMjBlQWRYWFI0R1o5NEQrSkRmWk1NWmpURmg4bzUz?=
 =?utf-8?B?S0lyQy9LNDZ5dm9PM0tMTGFjNlZDMUFxTVJNSXpwYXBBUFU2UkZmWHV3WXB3?=
 =?utf-8?B?YUcyeTVUdDFLZkc3VDIxYkgwb3ZTTEtIWDFNOFVRQmlPTTZ6bzRNU2FhcGNK?=
 =?utf-8?B?R2ZLUHVYclFEVjVrUC9ZeldTaitiVTNRSXdPN3NlS0FyQ3ZLSGJLSis3NlZX?=
 =?utf-8?B?RlRMOUU1aDBBcldkS1dTS1FieE0zWWo4aHZaMjdEeThPYnJyL3VEQzUwem0y?=
 =?utf-8?B?THBTWUlwUEYreGdwY2I4ckxwUW1xS1NxT2NqQmZsU3I5a244YzFuRGgydjdW?=
 =?utf-8?B?allaSFpxMUthMHB0U0ZPUEJaT0xhRmtzYmEwNkd5RjFpZU5RZmlhTkp5RXIr?=
 =?utf-8?B?UEZDSWV2OEhnbjNIaVhRamRWbkYwZ3JoRzlXWUpaZ1NEZ1BqcHhvOEFWS2F3?=
 =?utf-8?B?eE81NGVwNGJwb2tHVFpzQ0xHb0NTS1VpQUpEUHk4SDNsRXNBbkg1eDhvQ1Nh?=
 =?utf-8?B?bklaTVZhZXhJWWFBSG9jNDQ0NW5TaVVkbk9VeUh4OHBtdXhjRjFGam05L3Bm?=
 =?utf-8?B?YXBCN2RXWlNLYjZqUmlSVlg2VWJHanp5Ti9PV205RjEwS3RXaHFWV2NPUkNW?=
 =?utf-8?B?emJKOWp1cThTWG53WEE2eENwa0hScXdKMGVUSXp1NzRLYlNmNDBtQzVKTzFV?=
 =?utf-8?B?WjNSTjFwVm5pbWYwRjRRaHA2VCt2dHBJZUZMdHdlYmcyVTkwdE4vS3F6RmtP?=
 =?utf-8?B?ZGVmNHFNa285WEdFNzdRUk5CNlh1SE40cC9YTUV1V0NwOEN2aWQyUkdHT2Nl?=
 =?utf-8?B?aWhIVlh0NXhBM01YekRMSmZ2am16STdJWXpweFR1VS85c3h5SWZYM3hZMGRD?=
 =?utf-8?B?WlIvbVdzK0hkUlZQZE5peWNOd3E4SXBjZUx0TFF6V3dTMzVHOVJkN0p6WDM3?=
 =?utf-8?B?TXpCeWR0TSsxS2NHWm5Bay9mTUFKdWJvcjI2UHdOYXZkaWFIREhzMHRrRnVM?=
 =?utf-8?B?RC9uUEwzUGpZRkZLSnQrbk5NekF4TnhCcERheE9OSFZraVVGK0h5YU5zUVBH?=
 =?utf-8?B?bXF2NGYxYklrWVBDbXV5S3gxd2prWVEyeFBnVVVuZUdrRVg5S3FWNkduMjRl?=
 =?utf-8?B?L3MrZm82VHE4VVFXVkpTd0gvWXMrMnhHYmxLbnQxUzVqZ3J6dG5kSDNuZ0dM?=
 =?utf-8?B?bDE3VDJRMWZSd1RVSFF1L0Z2WEpWNi9GdXlpVStiN1RMemcvSWY4dzhWSXdn?=
 =?utf-8?B?N3FlOWpCb1EyZGVjRk5kVVBCM005emE0akNHMkJLQjAxc00rMjZGRW9rTHd2?=
 =?utf-8?B?Q3liSE5FMHhUV0tvZ3hKTmx2RklLK3pGMXl2WWFLaHZtZDVjSXE5TGJvSWFC?=
 =?utf-8?B?QytXQ2FKbXd6T1htYXVCdGJScjl4ZjBFd0RkSHViSnZHTlBhL0lseDVZV0lM?=
 =?utf-8?B?RG4yNDJ3NW85SDIvQnNUcEJZMk9zYThndnJ6M09NZzFYSUVGamZLVlB6UEU5?=
 =?utf-8?B?VGJVODkrN2xxUUU1WVpORTNRM2paczlMalZnOFZ1eUs3SW4wSm4yN0tFQXo0?=
 =?utf-8?B?L1hWSndvdWVxZjZLdkZtUnNIbjRpVGN6b0pMdFZCcU1YZU5RSitueGEzZGdU?=
 =?utf-8?B?NjNQbU5mMUs0ZDgxZ3FFNXR4Y2lnRlRPMFNyVXpPODJjaXQyUWliYzRtMTJt?=
 =?utf-8?B?NzdvUDFoUkZzMS9xY29XL2JtN0FEUFBmUFdtU2dmbUdzSkNiY0xEeSt5QkFz?=
 =?utf-8?B?eElCMkE4SmxlSlBhcVBtcUxLck9hdTlhMVB0ZVc0SVFES2tWN1dsSE1SS3By?=
 =?utf-8?B?T1FKZHBsbGhRMjc4TDZKWE13UjR3QXpKdm5yK01aQ1lGbTMvVFlWWC9QM29n?=
 =?utf-8?B?bUI0bTBIeWJVQzFSUG9GOGNyZnhwUFN6N0l1Y3RlVENIZTdBbG1NRGZjTGpX?=
 =?utf-8?B?dEYvbmV1QjQ5QlJveFZhcmpvN3BFczd0ZFAxL0pxRjRNVDFRWUpXMGFicWp5?=
 =?utf-8?B?OFJXK3M3TEl4YmtqbnFSYmRHQ29VbXppYzVoVXJzMjlESHJrckxYbG9WMER3?=
 =?utf-8?B?U2Q3WFFRc2NINk4rLzhjL2ZlbkhibGJsOFFiZlVzdDZRc2VSM0psQlZZWWYz?=
 =?utf-8?Q?B3F4aNbN9zGPLSz2Z+?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f5fb70b-1b13-4f70-be2f-08de652aca7b
X-MS-Exchange-CrossTenant-AuthSource: LV3PR15MB6455.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 02:52:39.5003
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lvDAQTTMIUDGJrsa1KMr+pcmVEi54bTcGguY1tkbvQIwZNFyOwHrSxxltCiq1GL8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR15MB3882
X-Authority-Analysis: v=2.4 cv=Wo0m8Nfv c=1 sm=1 tr=0 ts=69855779 cx=c_pps
 a=8M1/PN84ODQM9BgHet7h7w==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=WbtYzbEyMZlCZ4bzrXEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: agC-xezeBJbrUI3m2pqj_9h6Ctm01N0s
X-Proofpoint-ORIG-GUID: agC-xezeBJbrUI3m2pqj_9h6Ctm01N0s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDAxOCBTYWx0ZWRfXwWIRChrTAFMv
 ZC68y7+3/kRhSv3T1tp8ty+FzqSz5v/RVFncQJA1R1i4AlcIGFjPkieV0pLIjpHdZ0eJ0auD0wG
 OA10uBdQCusdNYvI4znnqoaurpaZL9EHSK/g5rwI12sKwwFC/av+DqFpX82nkfFfYnPQSo/CcHk
 qZ+LJLG7sY3Y6O6sKXbvxNa+Z8DINBa775S6rIDi9qjwUklZ83TQ5eSdG81SvZkdZ7MnefHgMfy
 g8rjPt0kfWayxpUVkPrVYuvuYhqTkpH5/tXUkldI4RB9qmomx/7J4Vh2F/O5WxcovtAh0u57tBe
 pz9q8mVHjpFnYQUgx07KWH/mO3HnsGcHCQkd4Wm1oJ3/9onhwUfKRN/KzqHxzMKvqMz/VZ8Q/Xx
 qbvALgxiNvlarloJxKUdsT2p3HzdZiyJlpbwiWTO2B86qqOp11RBgO7qq/PafEJs5YKa64kzYv1
 VZlw1UJIjJJ3gFxrNKQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_01,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76519-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[clm@meta.com,linux-fsdevel@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: DCB5DF9766
X-Rspamd-Action: no action

On 2/5/26 9:08 PM, Darrick J. Wong wrote:
> On Thu, Feb 05, 2026 at 11:19:11AM -0800, Chris Mason wrote:
>> "Darrick J. Wong" <djwong@kernel.org> wrote:
>>> From: Darrick J. Wong <djwong@kernel.org>
>>>
>>> Start implementing the fuse-iomap file I/O paths by adding direct I/O
>>> support and all the signalling flags that come with it.  Buffered I/O
>>> is much more complicated, so we leave that to a subsequent patch.
>>>
>>
>> Hi everyone,
>>
>> I'm trying out my AI review prompts on a few more trees, and I ran it
>> on the fuse-iomap-cache branch:
>>
>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache 
> 
> I should mention: I appreciate you rolling out the AI reviews by slowly
> expanding the number of trees you scan for bugs.

Thanks, I'm trying not to send unsolicited AI unless it feels like it's
mostly right.  I did discard one false positive, which looked accurate
but also looked like intended behavior.

Now that the false positive rate is pretty reasonable, I'll try to
collect some fs/* Fixes: tagged patches and see if I can teach claude
how to spot the bugs.  In past kernel-wide scans, it gets ~35%, which is
better than 0, but not as good as I was hoping for.

[ ... ]

>>> +static int fuse_iomap_ilock_iocb(const struct kiocb *iocb,
>>> +				 enum fuse_ilock_type type)
>>> +{
>>> +	struct inode *inode = file_inode(iocb->ki_filp);
>>> +
>>> +	if (iocb->ki_flags & IOCB_NOWAIT) {
>>> +		switch (type) {
>>> +		case SHARED:
>>> +			return inode_trylock_shared(inode) ? 0 : -EAGAIN;
>>> +		case EXCL:
>>> +			return inode_trylock(inode) ? 0 : -EAGAIN;
>>> +		default:
>>> +			ASSERT(0);
>>> +			return -EIO;
>>> +		}
>>> +
>>> +		return 0;
>>> +	}
>>
>> This isn't a bug, but the 'return 0;' after the switch statement inside
>> the IOCB_NOWAIT block is unreachable since every switch case returns.
> 
> gcc is too stupid to detect that it's impossible to reach this case and
> whines about the lack of a return.

Oh that's great.

-chris


