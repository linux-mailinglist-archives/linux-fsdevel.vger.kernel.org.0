Return-Path: <linux-fsdevel+bounces-76585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6A1jC7r6hWmjIwQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-76585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 15:29:14 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B900CFEECC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 06 Feb 2026 15:29:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D802B30199E0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Feb 2026 14:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76C541B36F;
	Fri,  6 Feb 2026 14:28:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="C75e49/J"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012F0413247;
	Fri,  6 Feb 2026 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.145.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770388090; cv=fail; b=M/tzr3U4AvqxxuRfu6FUPajn2qsQ+NRsTzjOFP71MD6Q1KdCORFBwNfm463SRTDIpmclXgPlSC9FZlHvc3u3mwBk0koa9UjRTMaVnMwsXg89D/omHAwpLR+o6wISi5qwcEVz5Bz4CCX+RmnZUoWiKglqKmGaVGtPXLCWlZcJT1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770388090; c=relaxed/simple;
	bh=mjcXGs409NWKEcxLHIz8vcJ9RkSrZW4CRQ27rTv1zEk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Y5fVKmab+Rg+J9eaSbQtNKpsDEfXccqp8q5YGhXIodlUKDfkwL00bKEI6RHstv5zJ8YEB7lLLJGKkUA1HkGISuHjQmhdb5jc9xn2WH2TBFCi8gtWKIpquE/wOvwiZ4v8qZR3hJimjQDSbDjrcthq1aNtVtwyq+axIdXB9XH/aXo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=C75e49/J; arc=fail smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 616DN0ef3167377;
	Fri, 6 Feb 2026 06:27:54 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=s2048-2025-q2;
	 bh=DoGqC8gdILjh5YaTsMAI6BqmmWYH/bcl1grOrl5tybM=; b=C75e49/JTowQ
	W6pWBRKhYTSM2ua/yXKb25MiJvaOpLFfNsjhXgqT/a+0XbF5zjDPDkfSIbHoD3bU
	q4APNT74i6Btil2BlDTbaNVI1JqFKYeFx9BGJ1NZcmzqHVy1EK8uWKtSeL0XNOJF
	beXkFCOqx66InBb4PIMEwHcJSPEF+wB3ZyXHMDbDKj6CcApo0wo8HA2UJ5LjBsO6
	/J6VctTikUkrjzyNH6aMh4KJatoqDrS8QMzCVTP1393kgjPiSGbLTha9bPQRCvcx
	4u86KgoI/tKOH5YguCffLDFrPO/LcB1Md4bL7yad1Aud0S8d/3jbDhlG/Id+7Svq
	aQtKVc/gcg==
Received: from ch4pr04cu002.outbound.protection.outlook.com (mail-northcentralusazon11013011.outbound.protection.outlook.com [40.107.201.11])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c580q4grj-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 06 Feb 2026 06:27:53 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FqYBo3EziSyP2qRSK56k6dO3VASn7XB/qda93JtipB6zH9gPxRVPCw1sHsArZkzMi82VN+WpeZaWsSiDA7vJLxiFueQFGKr0HovPwxXnEhpBGMe9goKXLKTP7GwO5RYELwXAlOgWbMGHJphii8nSU4+xg3CWY5LCn6DiEu0Ay+pdDlI28QNIepHVVCm912aIGNjxOQrc0NpdeMGY5hrIhwNYzRsXVcms3BDC4uQsWnQFkL/Y/Hq/xyGcrDHOGMGojm8U7mzU9k8V6WAuzT6lSt3Jf0IpJdHyg4bEwPooLaDan9d1ECqBUtYLIQ5b8WKhfiRUNKPESpyEH3t01c589g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DoGqC8gdILjh5YaTsMAI6BqmmWYH/bcl1grOrl5tybM=;
 b=YS/DjNuXMhsw/3tlvFkVtXZo0Q0hJ2yD2ecxAX2ZJmRTiGbX5YIKCDHJFELgEqzrY2h3viaXQOPCToVR2PcQZZBUbN2vs0ZtWkErXn3q2sBf7fvV9vRCSSoleRsd0qOa0uKDxcu+94UU1of/JmjaSCPsR9lcQcWa8HhDZFWQ5VCHumxx1zk2V7UNg/5NwF7ZzTSwuI+8ZJl7dy2YvDbKsNpAH7srOjp6axjTrgwASdgZr+V3PkKYP0OhoodFG+z42VqnLDDLmiaWQWOe3cgfUIAGHM9pK1rsoFcRlE89cOdQ5e/uTOxeGAjuRE52Ol7AH1vzFkownZ2h+YrookHm8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=meta.com; dmarc=pass action=none header.from=meta.com;
 dkim=pass header.d=meta.com; arc=none
Received: from PH7PR15MB6463.namprd15.prod.outlook.com (2603:10b6:510:304::9)
 by SJ4PPF29B96CB1D.namprd15.prod.outlook.com (2603:10b6:a0f:fc02::88f) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.12; Fri, 6 Feb
 2026 14:27:51 +0000
Received: from PH7PR15MB6463.namprd15.prod.outlook.com
 ([fe80::47bd:d7d9:dee5:82fe]) by PH7PR15MB6463.namprd15.prod.outlook.com
 ([fe80::47bd:d7d9:dee5:82fe%4]) with mapi id 15.20.9587.013; Fri, 6 Feb 2026
 14:27:46 +0000
Message-ID: <acd28342-0674-482f-922c-e9af077d8ab0@meta.com>
Date: Fri, 6 Feb 2026 09:27:36 -0500
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
 <91881ad9-62c0-48c1-9cfd-e6cba6ddb587@meta.com>
 <20260206050823.GH1535390@frogsfrogsfrogs>
From: Chris Mason <clm@meta.com>
Content-Language: en-US
In-Reply-To: <20260206050823.GH1535390@frogsfrogsfrogs>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BL1PR13CA0333.namprd13.prod.outlook.com
 (2603:10b6:208:2c6::8) To PH7PR15MB6463.namprd15.prod.outlook.com
 (2603:10b6:510:304::9)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR15MB6463:EE_|SJ4PPF29B96CB1D:EE_
X-MS-Office365-Filtering-Correlation-Id: 9bb7a414-9fdb-4b5d-6f50-08de658be5c1
X-FB-Source: Internal
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QmFoUXN1eEZoSE14VUcxa2hyWlpBem1xMm1sQWpXaHBhY2V6NTkza0svZW1j?=
 =?utf-8?B?N3h3YUJBSGd6bU55MFlYSUM3a3ZaQnZRWVk2WGZOdFl6UW90N29Tc1RBeGwr?=
 =?utf-8?B?a0dJNDl4TnJyaGZkc2w2WjRmdDF5VmdwcXRXQkZ5TmJabmkxUmFMMEQzQ2FM?=
 =?utf-8?B?ajFkSWhabzE1UGZDV1NVc2drT2ZaTkNXRHZjTUZsc01jd2hvYVQ1N0x3bHVi?=
 =?utf-8?B?RmRPOExMa09XcDZnWnk1SG1Ra2NGQ3B1c1NYcjRza01McU50SDFzMXljZ24x?=
 =?utf-8?B?bGhZQ0JRQm14ZmdhMk1sL1dNbCtBNTVrVHhvc3pVUFdDb2Q0MTBIZkdlM0pw?=
 =?utf-8?B?U09laU9LeWZPakVlZGYydS8vcjNlSW0rSlMrOHVwQkFmY0NBKzdCYnZoNEF5?=
 =?utf-8?B?ODFDb0FEdll0VGhPa0g5YzJ2KzhqNVhCd3hwTUwydnpmQ0tqVWN0UEx2NENV?=
 =?utf-8?B?VWoxcXFmdTYwNjcwb2RoUUpNb1hNWFBPRGJ4ZWo1TklSclpzVnNqR2FpUEJH?=
 =?utf-8?B?cjB6YmhIaWtudTh1R1pLdndDWnJKQWtCMlFsUEJVekZpb3BBQjMrTktDQW5x?=
 =?utf-8?B?YkdiV0ZwR2NNUUJSd25MWTErM3ZHWnNISklHaTNNWk5GVlBTVkw1bktYbjha?=
 =?utf-8?B?dElsR3hxaFVwN1dacHFwSEI2ME81SjV5UkxIazlFZWZHQXhpd0ZVMU9lWlc3?=
 =?utf-8?B?VFpkV2ZydFJneTRPV2JVQk9lbG9BUU5YeVg2U2NNMDlZOXdWdDB5UjA3NERC?=
 =?utf-8?B?aFZ6RWFYK0cxSHltdE9wYU8xbDZlOVozRzRYYjFPeS9vV1lwcFM2SndVMmVF?=
 =?utf-8?B?aHBuaXRMQWRsSmV0MGlKU0JoVHVyYTBQNUlIUzY3QlNONTZMMmtuWGNOUlhi?=
 =?utf-8?B?S2E5SEdsck5LU0JKSGQ0NVhzRnhqdnhTYW9WYU5HZTlSbTZ6V29YSDVUdC9Y?=
 =?utf-8?B?VEgzeE1FN2xEWEJIMVZ0Z2MxSnorbldCWlUvdkhMNis4Z2dJT1pwMU1taTFL?=
 =?utf-8?B?RHYwVFloTWVEclVHTC9vdWdCa255anBkWlptaWNITFdxL1ZocEhHSjRPZzFL?=
 =?utf-8?B?b3c0SCtNaWJ2Y2VPTU9GTTRGMjJZUHNPR1Erc3huVkJrRTFpS0RCY0srMUFC?=
 =?utf-8?B?SzF6MXBBbnI0dFVCMTY2emNzU0VsYTdvd255T1U5RnNwYU8yRkpKOVZMemhJ?=
 =?utf-8?B?NlBBN3pydHJBaCtxeWg1WHZLVit1UnhLYTA3M1FYVDhjYjhmT1krZWhKa0VM?=
 =?utf-8?B?UW1scmNqS1QrOHdNTDZhWHRiaE9hRm15WGZVTUI2UnE5UGZkSytiNEF2b2lw?=
 =?utf-8?B?dndPRlVOZzZWNzB4WjZwSlRtdWVrdGUrVjhkRlByUjdGSE1WWWY2bUVpYjhi?=
 =?utf-8?B?UEY4Mk1oeDN5ZCsyQ1gyazR3TStmQkZqS0d4MndTdzFYcE1ZRjVFanNMYWlJ?=
 =?utf-8?B?WW1LUGN0Zzh3dnRibk1UcWhLSThJRkFpVFl3aUxaZDJMZW05akExUGZTOWtj?=
 =?utf-8?B?bDRuTHJOZEJZRG1KSXFOdzdDcG1nZHk1cVFBWGV4ZkkwaDJpMCtBeHhGQlJN?=
 =?utf-8?B?UkZJamJ1VEhnM0JrUXpqQXA1U011L2ljYWM3OUZqRHhnczdxTStkNDVNT1oy?=
 =?utf-8?B?WVVmSnFGWVA4aDN0azFONDRFa21aOUdwVVM3MWNVRk9qWTNpTVZoVHoyM0oz?=
 =?utf-8?B?OXVlcG1ORUxsblcyRllucUhNM1Q0SUVncW9TbG5NK0I5eEJsRm85dXpqL055?=
 =?utf-8?B?RkxLcTVzbU5wYVZ0aksyckVLVkRFMnE2a2t1VkhzWXBJWHNrc3JYRTRoYWlz?=
 =?utf-8?B?UWVEMWlWRWUyMGY3YW1TTEdwZmhFaUoxRzc1Q0RoQW1ZalhsZUU5K3ZzTERD?=
 =?utf-8?B?V1RLdWg3L3lpcElyUjliMUJUSkQwOFhwY0E2Vm1ZUnY1WTRpYmdZaWdjUWt6?=
 =?utf-8?B?T0o0N0dPTVZsbmtaWGhKd0pUb3N6U3BpaXB0Z0owSUp0QStoUGRTRDZnOENT?=
 =?utf-8?B?VUxrZGhjNFRZUldiMktBK1JJTmhLOTFaK09oVzRSREE5cGRRQ0E1VXBnLzNr?=
 =?utf-8?B?ZTlDMmFHd2UxYzlxWlNnbDBsY0N2aHlkbDJpY3h1d1h2MGNjZEVnVE5yTWhh?=
 =?utf-8?Q?G/Bo0kuTfmfs4fPhZO88EyW9Q?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR15MB6463.namprd15.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dzNvdkc5YlJ1cW8rRWdEUitNMnZyT2NXVUE4ZU04TzJNZUFVb3FoZnhCanFE?=
 =?utf-8?B?T010L0I5MHREWlpnTWtHWnBDUDZWVUZRd2pzdkxHY0FZdmtJTXduempPSEti?=
 =?utf-8?B?NDJISWxmZStBamNpRDcwMGhuaWdwckhPamZSUnRFOWV6KzRleERLTXc2QzRw?=
 =?utf-8?B?S2JwV0hBamFOMzBnM1IzVVJxTzh2ajVRL3FYZzB4aDFqL2R2aytmUmdUaWUv?=
 =?utf-8?B?RWs2ZGVLZExFSHlOWldpYTd1SmlDNjY5RnRsYVZLTmhqckFISWhmTTNRZHox?=
 =?utf-8?B?Tkl0a3h3K0hlZndZYnMxaXJpQlRNZlJOOVFjNlR0T3BDVGMvSW9hQXEwSXkx?=
 =?utf-8?B?MXozY0RRMzBnM0pwVW8rQW0yLzJ3SndBNUgvNWpQM3gyRlZ6eFNVdkJ0SlNE?=
 =?utf-8?B?YVZEMkx6aTY5Y1JCaWRKQzFURDEya2VyWkJBVi9KT0Z4RGpjL1lsVm1aRnZr?=
 =?utf-8?B?dUQ4L1RoYkJPajVYV09FRkI0V2crYnpHUmMvMGRwd1dhVHNMUUdraFIzR3pr?=
 =?utf-8?B?R2oyUWlML1YySFU0cnl2ZGt4ZkNrZlVRVHlVSldhSkJYS0docUk2VlUxaC9X?=
 =?utf-8?B?bFpoWE5acFRoNzM2aHRFQS95ZEhoUXlxblVlTTYyOVgxRmhMaStBTGg3Umtm?=
 =?utf-8?B?cWViN0dFdG1oc1hVejg2aExBWnRFcjJCVTBzUjFHa3RrWHJBRHBHTzB6RFdD?=
 =?utf-8?B?bU5ZeDJaZGo5SmRmTFBZOUlpdXlpM05NaXgrMGt3SEFFUUw3a1RDd3ZoTkF1?=
 =?utf-8?B?STlHT3RrTGN2WnI4bFhNQ2YyRzVrZGQyUlZKT3NNcVZRelZjMzVZNFBOMUZ4?=
 =?utf-8?B?ajdPd2lFS1RMQjcyMC9LRFpHaVJxQ1FrZ2ZXSnpGdkhFSmJqcHhBeUk3N21L?=
 =?utf-8?B?eG9IWHVBUndOdllIczlQVEZ1c05rUnYxWUZkMGdJVUpFbmY0UVVGV2wzME5L?=
 =?utf-8?B?amhWL1AzVyt0SVdZOGtGeDFNcHBGcHhXVTZFRVYzYWl1OHVacjJpWk15WDVl?=
 =?utf-8?B?YzBCUTZ5RVFSVGV0enh6TlN2NTVCZEZUMFlzQzMraW5MMGt3OE1xYU1KUVAr?=
 =?utf-8?B?MStWMWNsQXhzcFNLbHQvNUFtZG8vUkhvUjVsa2IvenMxclNudk04dmh5b3U5?=
 =?utf-8?B?ZEFTdW5NZGE4YjRIUUJEOXpSUzNjMjV4QVlaeWhzZnRaWnNad1dpYVN5N1ZC?=
 =?utf-8?B?YklLejR2UnZyMXYzQ0FkSDVSZjRwa2c5VjRCY24rN0FITk1QZkc2akJsSHJH?=
 =?utf-8?B?ZHVrcnhDcmUwY1RDcmVmK2F3eExLYit2b0ZIRktNT09iRkJGS0lXV0RUQkpB?=
 =?utf-8?B?RUlBUGpWWEp6NTk5c1lHS1dmVGI0ZkFhckY4OCtMYy9SNlhZSUt0azQ3T2hK?=
 =?utf-8?B?UnhCVmg1R0FMZG9LMU5KUC9JbTM1YTJvVmxOb3dPcTJaN3J0YjN4YzFSU3E4?=
 =?utf-8?B?OE14MGNSaGNvZjRPR3dwMHhQWTB6R2NzenVJTS9ObUxBN0JKTG9LTnV1b0w5?=
 =?utf-8?B?c3pic2JaUDBzWVBEc2lKZkYxdVo5UktZOFJtQi9XT1Yvdm9tbURpbTU5Tkg2?=
 =?utf-8?B?L1FnSjJTQ0dKOUUzeGwrRWlTZkpSL0RwZDBoZU5JRnhUMld3Z1NRTU9yeVZx?=
 =?utf-8?B?ODA2VlJ5UUdBZVl2QXdRK3RjbDh5L01sVVoxK2hiQ3p1VXRkM1g5blloUHo1?=
 =?utf-8?B?dVdvYWE2dDBhNHZWSDRUZUpvUjlKbUUvUy9HMXNLYWNmUTIrZEVKdW5hbCt0?=
 =?utf-8?B?S0pHVDhHdFNtUXZKT2pIZGtHNVA4V0ZDdGQwNndHUXZQVUNoNUYvWG0zVEVQ?=
 =?utf-8?B?NzU0RDE3NEtGdkhUa3dvbE90ekRxdDNQRmxZVHk0UGpFVE1QaUtOR1JkMTNs?=
 =?utf-8?B?ckx4cmtMK0djeUVkcjVITlA5akwySW9kbG1zRVZLK2JBVWg3VkxqZVdtbjV2?=
 =?utf-8?B?d2pkVWREZWRiVnFUNkMrd1FpTGIwakVvbU5rREtRZjJONEM4dTA1Wko0aHdl?=
 =?utf-8?B?eXhkeEIxaEMwQnVGUW9HY2RjSUhUUTBMYUI1cmhzTElWUmZUcFY3K0V4eTFE?=
 =?utf-8?B?M0JyVTRWWndLM0J0aEEySWsrcVRoWS9MZ2d4TmtHTnpvcDRkNkZ0dkpvbFpq?=
 =?utf-8?B?M2dINk4zM3QvOXpzc0FnWVRRMjhlNnE5Mlc0aExsUFdxRFpuSlkrZVMwRHVh?=
 =?utf-8?B?cGpscEZQWFNXcWtTOEs5Y3Q1U1NleHo5K1VFZGM0ZWRKSllWbHZPQk1rR2Fr?=
 =?utf-8?B?OXR0cm9tSVhlZ1ZUUDZnRXZWbWR2TElhVmxaTldYMm11T2xjUGEzbFFzaUZX?=
 =?utf-8?Q?qlSmYy+wiiSo7oqCT5?=
X-OriginatorOrg: meta.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9bb7a414-9fdb-4b5d-6f50-08de658be5c1
X-MS-Exchange-CrossTenant-AuthSource: PH7PR15MB6463.namprd15.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2026 14:27:46.4314
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 8ae927fe-1255-47a7-a2af-5f3a069daaa2
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j9W9QO44sugT0kH9AeG3WL/Xz4rR+mC8W6u9XLrxLGE60XtC8r1Jp1AqtL/1Km9W
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ4PPF29B96CB1D
X-Proofpoint-ORIG-GUID: H3VAjNM_oFCaX1BoxI_ZWT4n7qvjMS5D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA2MDEwMyBTYWx0ZWRfX/o+e34oM4gp7
 gIzi4yawL8gCwrcJi292XjhQGLl371gg2irWizSzK4mjD8E/bGGIQYl262HqrbERzGyZesglRW9
 /dhQXt9pNKPcOklLf9RNVWA2RzJAxpFWdUepI00A82jb8G+sAyBgdASWtoDFHIkVghLUdd9jr8/
 LhMBxxy2MmHWsRpCArKm4mu1VIPg1eiPlErRAvgHkYU8VBdyhwZYl6u05XiocR2zNkCEC7s8GUK
 N34Hcw5SMAMeSOhYEHWEu6OQfMJQXMax38I2Lu5jyLXBck36vCGFdPUnBDHOxYyLa5Q3ofBZ58V
 YplFMbqQf2aKF+0ZpPAZtoZysPRw4UobZKxkiE8ZfGqobsnjRh3lFHxJvSN0+2fFWK3LbEQYg5r
 357c3pOALgM6YdLuimdu/KJaWvFSBEYISp09y2puzYYUUxxmC2ayBYGXmG/eEIEnggGb4OS3aMm
 3gcqCr3VijDJAUCG2WQ==
X-Proofpoint-GUID: H3VAjNM_oFCaX1BoxI_ZWT4n7qvjMS5D
X-Authority-Analysis: v=2.4 cv=LrqfC3dc c=1 sm=1 tr=0 ts=6985fa69 cx=c_pps
 a=+Z8LngAnY8uKoQL+MiJmWw==:117 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19
 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19
 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22 a=GgsMoib0sEa3-_RKJdDe:22
 a=VwQbUJbxAAAA:8 a=NEAV23lmAAAA:8 a=y3oW0uFFOmPCuqdFuA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-06_04,2026-02-05_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[szeredi.hu,gmail.com,bsbernd.com,gompa.dev,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-76585-lists,linux-fsdevel=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[meta.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
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
X-Rspamd-Queue-Id: B900CFEECC
X-Rspamd-Action: no action

On 2/6/26 12:08 AM, Darrick J. Wong wrote:
> On Thu, Feb 05, 2026 at 09:52:29PM -0500, Chris Mason wrote:
>> On 2/5/26 9:08 PM, Darrick J. Wong wrote:
>>> On Thu, Feb 05, 2026 at 11:19:11AM -0800, Chris Mason wrote:
>>>> "Darrick J. Wong" <djwong@kernel.org> wrote:
>>>>> From: Darrick J. Wong <djwong@kernel.org>
>>>>>
>>>>> Start implementing the fuse-iomap file I/O paths by adding direct I/O
>>>>> support and all the signalling flags that come with it.  Buffered I/O
>>>>> is much more complicated, so we leave that to a subsequent patch.
>>>>>
>>>>
>>>> Hi everyone,
>>>>
>>>> I'm trying out my AI review prompts on a few more trees, and I ran it
>>>> on the fuse-iomap-cache branch:
>>>>
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/djwong/xfs-linux.git/log/?h=fuse-iomap-cache  
>>>
>>> I should mention: I appreciate you rolling out the AI reviews by slowly
>>> expanding the number of trees you scan for bugs.
>>
>> Thanks, I'm trying not to send unsolicited AI unless it feels like it's
>> mostly right.  I did discard one false positive, which looked accurate
>> but also looked like intended behavior.
>>
>> Now that the false positive rate is pretty reasonable, I'll try to
>> collect some fs/* Fixes: tagged patches and see if I can teach claude
>> how to spot the bugs.  In past kernel-wide scans, it gets ~35%, which is
>> better than 0, but not as good as I was hoping for.
> 
> <nod> You've found some very good bugs, especially in the fuse-iomap
> branch!  At some point I'm going to have to figure out how to run these
> tools myself, but until then you're quite welcome to keep scanning my
> dev trees. :)
> > I wonder, have you tried it on non-kernel repos like e2fsprogs (ha!) or
> fstests?

The prompts are here:

https://github.com/masoncl/review-prompts

And thanks to Christian they now have both kernel and systemd specific
directories.  The original versions of the prompts had a lot of details
about exactly how to review code, but recent models don't seem to need
(or follow) that level of detail.

Instead it's really just forcing larger chunks of the call graph into
the AI context window, and adding some kernel specific knowledge about
locking, rcu, gfp masks, sleepable vs irq context etc.  Basically the
weird stuff that we've forgotten is weird.

So non-kernel projects would mostly work but would need a few fixups
depending on how far they stray from kernel semantics.  It's easy enough
to add branches into the prompts, with the asterisk that from time to
time AI ignores all the instructions and does what it wants.

-chris


