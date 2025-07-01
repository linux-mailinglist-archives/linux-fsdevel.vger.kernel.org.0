Return-Path: <linux-fsdevel+bounces-53432-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EBCEAEF0D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 10:21:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 081631BC3BFC
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Jul 2025 08:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A457264FA6;
	Tue,  1 Jul 2025 08:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="g+YYRZRf";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="Oj0Y5JgN"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14776264638;
	Tue,  1 Jul 2025 08:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751358086; cv=fail; b=cxe/LzLfuSoQh+sAfhan+cNB8K5Nh//2aOYZ9zI7+II/kmy/fB9U9q7RL9J93UNHVDc2VjAjQ4Gsq0HFfqr3QrXcdLAThthAey/XAHB+8/Kghb0tG+hRGQMcH4UuNrF+graUl+I7t98h7EgAXYI9aOHDTw7eW23hkcZpgGmJbxc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751358086; c=relaxed/simple;
	bh=f99AjEDqAFfYSZgrTSS64iTP2FMuu/a6DxHRBRqtoEA=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Sak/l0u0lFJ+rNpPYxoQskn9TsYLFjFjBwLWNUh/fdHFJ77z5vZwxjxCeHchuxEs43IBspOyUiXYcaH1shzybRn/3Mvr/tU8PzB/WTC3VwT1aF2p8q4uuIXhSNaTerootiC1OCUkz5qmmdz8DZlieGTxD7J8GEovdAOCXnSTvbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=g+YYRZRf; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=Oj0Y5JgN; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5611NJ0h006583;
	Tue, 1 Jul 2025 08:21:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=X6KXw/oMWcAyYt3ogyJ/0cUh9zgdPmgmmVh+XSE5MC0=; b=
	g+YYRZRfL6Eg/JY6DDivYwqOVgYcmcKfSPT43exjbEKi04Jy6A8d5xiqd7qXQQmP
	h9r4mxHDenjGt1AednJlBgTH62zZOrjTskk6+iwBjVWfNUFewa/7kkDaVUi10zjf
	xYI7Y4ISn9KGHOJyCzsilyB215oOGJYRcZNsjPX8O6GZyrn6AEaAEuDLL1pFeqaB
	e0M1Gh0Vo43uoYXMvyATe5aHP3lUc+QbU7BxpwcIWWM1I0MAAbpp3nwvBCqxM+qt
	RnLoY1hxbWcW+TVWSR/ZsOWbLD8KS3+5PF3pnDw4Qp6wXm2plP4BKrGmGsg5Kamz
	do8Y9uYyIPBIRaZee6quUQ==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 47jum7ug53-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:21:18 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5616lK7q009026;
	Tue, 1 Jul 2025 08:21:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11on2042.outbound.protection.outlook.com [40.107.236.42])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 47j6u9f9rc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 01 Jul 2025 08:21:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pto6bPGZTNFc9ritPsvFI810kGS7jOMsytKoYeQe3cu3ozN+XDhbT0Mgo3yysYYQTo5UI9L5yhq5c76rnotTqb66grYGXQsN8LSOhmgwSmdVTnW3u1Tcdr/Jf5Odt2IaVPl9huRzkvwJ4bd4v4Xk4OCJafUBlaIV9jKkTdTIMvqIg5hc1x13BAa3hzzfQJDyiHgRKQCscRnKAxEkcCl0vzEMwryNeXKi7B8cgP4B/h/SRPF17nXJ6x6rHOoICZAZlnCz1EIJCqMOENu8KAFuhX9bvIxDtGcIjL3H5SKSrCMJmLQULMfQzBtzC7B9tIfD8tKe4x6ezaRt8LZSo+YsLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X6KXw/oMWcAyYt3ogyJ/0cUh9zgdPmgmmVh+XSE5MC0=;
 b=oAzOueQovG6yAcjXKXcIMo3NFz6OSdsctTtmxeEsisHaTh7GGJSwN4I4WLxx/GxNVYgUZlKA82R3xhH+uaSbgFefZRXhm+PJO5JYpLgjfJoy4+cQmoMcyy0FyvFOkyjgGXNvUFzJj31o29eM0X89IKEI8J/Is7m711FuU9aQfMkVmhcm3kBXkCVtZsOHx9fabJS+B7egqBl1RVOxgFMXZPW35Tn8AW3yQZ6T/h9jYd87xpKQteq34OSavSyoJ7n2IXWI4NYxzGYNlRZ59e4YARFuZUbvyikdNcZXR/rKhsL6yMOzEstUD/tfNegio5kcdcxz8ixozv4cCmtG3S85Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X6KXw/oMWcAyYt3ogyJ/0cUh9zgdPmgmmVh+XSE5MC0=;
 b=Oj0Y5JgNZg8zuZGZfX9P/AeJ5ExDYJPGx8I8iMy4/41ttcjfOZRa9a2p9z5xfG39oncK2tWe2DfuV4dhoWXKDJgTppQkJEYcX+/+FQk90st3UP268/PWdLULcQEw9LZCB27j78PY6wVs681kD+00kRtA5xlRw0oVmHLia3HObAY=
Received: from DS0PR10MB6078.namprd10.prod.outlook.com (2603:10b6:8:ca::5) by
 SJ0PR10MB4782.namprd10.prod.outlook.com (2603:10b6:a03:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 1 Jul
 2025 08:21:12 +0000
Received: from DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b]) by DS0PR10MB6078.namprd10.prod.outlook.com
 ([fe80::edc1:7c2:8fe8:a6b%4]) with mapi id 15.20.8880.027; Tue, 1 Jul 2025
 08:21:12 +0000
Message-ID: <d0d7243d-4254-41a3-85c6-887f9fb0db36@oracle.com>
Date: Tue, 1 Jul 2025 16:21:06 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] btrfs: implement remove_bdev super operation
 callback
Content-Language: en-GB
To: Qu Wenruo <wqu@suse.com>, linux-btrfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Cc: viro@zeniv.linux.org.uk, brauner@kernel.org, jack@suse.cz
References: <cover.1751347436.git.wqu@suse.com>
 <5c1f7441e3e2985143eb42e980cdcf081fdef61e.1751347436.git.wqu@suse.com>
From: Anand Jain <anand.jain@oracle.com>
In-Reply-To: <5c1f7441e3e2985143eb42e980cdcf081fdef61e.1751347436.git.wqu@suse.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MA0PR01CA0051.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:ac::9) To DS0PR10MB6078.namprd10.prod.outlook.com
 (2603:10b6:8:ca::5)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR10MB6078:EE_|SJ0PR10MB4782:EE_
X-MS-Office365-Filtering-Correlation-Id: 347b5341-157f-42ca-4268-08ddb8783d60
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dWhiVFpXOFZEYU83RVJkWUY2MEdNQVBHWHN2bEJMdFFVTzZJVHRvWm9tT0Z3?=
 =?utf-8?B?WDJOU2crWUhUQWtQaGs5SjVOQ3BDcGUrYzJXUVBUYk42UUlsYU1JalhSUGR1?=
 =?utf-8?B?dFdCS3hhRStpZnl0OFNWc3FGYm1UZFR3ZEhVakttdnBZYkZTTWx0d1l6ZU14?=
 =?utf-8?B?MmRIanVWWktEQmpIUjE4SlF0K2M5RDhOYzhQT1pSeWsyMksyblJ4Z3o3bXc2?=
 =?utf-8?B?WlY5d0JLUmttVktVa2E5RlZCTE5kcENBNDRRUnFGMkg3dm5DWGpmY3RqYmhY?=
 =?utf-8?B?L2NQMGdwSndLSUdPSXo5eWlVMlkvTDFYa3dmaEliOGdKL0dkN2YwSEV5K2pR?=
 =?utf-8?B?eTV6bzdEbDV2bTVRN3N0ekNTZzdBQ0xEdTFHSWZJNzc4R0xQSE1maTRQbXpm?=
 =?utf-8?B?ckZRV1J2Y2NzaVd6dkJDSWpETUxLZzJMNXlqdGI5UmtFMm01VFZ3Q3dhd0tF?=
 =?utf-8?B?dER6V0hScmtRU25JL2gzRmpGcmVhQlJUZElJSDl2VFVwRm5oSnFabytXQTBz?=
 =?utf-8?B?MGdmYnZtNEgrK2xQenVBWEh3SkJJZzFOazEwK28vRE5YSHlZWU8xeGZwV0NS?=
 =?utf-8?B?aTU1UE5teTZ5VThJVDVNQUxHc2YycENIMmdsenBxOCsyajB6RmJJbzdYc3hS?=
 =?utf-8?B?RTFiamxvRjJsckZXRXRRUE9oQnFEdXpTV0RBM1Z1RTRZRlVHdGVCc0FBQ0p2?=
 =?utf-8?B?NEZERGtGbmVOMmZTOVBSQmdoSVlQMjBuWkhRaFlyNnUyL0hxTGVCbUZoWlJB?=
 =?utf-8?B?cFEwOStDU1FlWVUvRkd4bHBkd1hva2sycWFyQnZxNVJKVDFqT3BuVTdURTJN?=
 =?utf-8?B?MlhEcjlkcS84Nmp0Tmc2MDYwRloxcm0xYVV4VHM2bjNQUU9JdFBjaU5sQ2J6?=
 =?utf-8?B?bkVtUzJDWmQxU0ZmQmgvcnJqK0M3RTNIdmwyUlZKZU4vektOR05LRkZaV1Nl?=
 =?utf-8?B?ZWNVdngzNnhTcjlnYUhwcjJ0aWJ2MFNXQzIrcjVBZ1lzcFl5ZlRaYnVuNzlu?=
 =?utf-8?B?QWZpNkplQ2tNMWc4Y2FuL01uZThhTGl4NW5vZ1Q5T2FRc0NOTlNxNktKRlVn?=
 =?utf-8?B?emJMWWxKdjZ0V0RmQmp0SUxSODlMR3ZNVE9GYmxlZWxHOFJDVkdLR2krZHhM?=
 =?utf-8?B?WVI2eVF3aWhOcmJ3YjZreG80MUdyNyt3K3M4MlpWc1VyV3BmdnJUdmVUMEhW?=
 =?utf-8?B?QUxBQlRmR2VHbFNoWXZTbzNpUUpkcVQwcjNnamdNQW5lbStDTjNTdmhQSjVR?=
 =?utf-8?B?SU41YkVPUXRYRTYzSVIzd0Vucy9VcmswbzNrL2dlakw2K3B6d3QrZFdNalFN?=
 =?utf-8?B?alhMRXFaRzFiU0hpdWl0NnJFS3RnMTZ3QjE0TkgyRVphNllWdW1zZGVweDhF?=
 =?utf-8?B?SWFHUXRwMWZFTUJtOEUzVEZlSGc3aEw2ck1iS215WWd4bEIrQzI5cGRXcGhB?=
 =?utf-8?B?OVV5MnZXNGtMTEhncGQ4OG9wS2pWNDF5MUZZNjJOVkI2d1ZzTkhuQzlMKzhZ?=
 =?utf-8?B?TFNnU3ROMlRHQnJ5Mityc0N4SlN3bklqTWI2cjJOQW4xVS9NREpCd3hLN0ph?=
 =?utf-8?B?dUdnY2w2dlRxRmlZcTBiRm84N1JDTFNHQnJ0VU5LSnFVQmRiMHV4UHJZM3J3?=
 =?utf-8?B?bk92UDZya3dRNHhKN3NNVThKazZxZDFzVmNmZkpQRTJxWm1tRERhQmRWVksx?=
 =?utf-8?B?OWFMb1B6Tml1YTFqMHllK2RIak8zWWZBOXdiY1p1OHJzSzBSNFJhZldrZGFG?=
 =?utf-8?B?ZkhHUktQb05GbUw2azN6RHpTSnVNRkR2V0VKdWhWQWZ4TVBQczNxTUJGUlRN?=
 =?utf-8?B?SE42MFpYeGVQMGh2K010NEp6YjlhUnBoLzdCNVJSakVkMHpjaFk0TUpSR0g2?=
 =?utf-8?B?MW9mdGYvL01uYWgwc2RwVjlRYnVpK1pIZzVTQllIS01ReFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR10MB6078.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?RXh0WUQyaVdZeExEbHNiaVVyRElHNi9VZDNuTHBlNDc2eWFBdTNtbmQvRnBj?=
 =?utf-8?B?NWk4OWZ5Rnl4bjBzK3VCWEwrbG4xUDh5b1F4azMvWlordHRNQmU0dlZTUHlU?=
 =?utf-8?B?dHRvdVhuOUpVQWl5bFlQaThNTXNhS2w3QnEwM2tiODVLWDlPM09VT2lreFJ4?=
 =?utf-8?B?N0R2UDVjUTB1VVhoT01yYzF2Zzk0S3lyazJYMkdkdzdDaW5XbmJaMTZqRExZ?=
 =?utf-8?B?NUdFTUlha085WC9Lb05qVzNFN095eUp3T2dWOVdjUWZWVkYzbWRvS1BKejRm?=
 =?utf-8?B?cFBaSWpsK29wMkNvYm9TYmxXM3dKR21KTjZSMEhqaDd1L25ydE05QVFlYm1y?=
 =?utf-8?B?dW9McHIxY0R0cjJxanR6bUt5VVhXRENZUUlJSGM3OW9oY3h5MFBQL0JudTJy?=
 =?utf-8?B?TkErdFU5QXNiRU91WDlycldHdlJZejBMNit4ZlZsa2IwaFg5ODZGOElnZmxu?=
 =?utf-8?B?eDluUlFwSkt4bm5xWDZlOEFLY0xDYVhjN3J5Wms2b2FBUDF0RGZ1TUM5ZmxB?=
 =?utf-8?B?NmNqbEdndmh2eEJEZEdPeE9VK1FJNHhjWTdsZEJyS0tiQUx4Tm1KODJqWTVU?=
 =?utf-8?B?aWlCbzM3ZVFicTBJNGtqcEtyOVdRSUFhZjBGSXZiSFVqT3NQUjQwRFRFeTMx?=
 =?utf-8?B?ZUpFVlhPUCtlNzZNNlNBRWpuWkV3STZDNmM4Tk9LZE80Nkl6bXBEd0xhc2Fq?=
 =?utf-8?B?WllMaWo0UllHM0xEbG5ZZTZKekJjWXdJUzRDSHB6ZFFDWmE4VmwxT3NsVHZ0?=
 =?utf-8?B?NjJpMHdnbEJ6T04vWGY4MjNVMS91VEJmYlFKVU40UTFBSENSZVh1UW9sN2Nh?=
 =?utf-8?B?WDJKSFNEZUxWZlBoOW1wd3h0Tm90bmdwZ2hiblQxaVQ5TjFQVDdyQlF1azNI?=
 =?utf-8?B?ejRyTG1Jb2lURk5pZWQwS2VBWTZyOVplbHRxRVU3OVF0R2lNcEg1TXBDTUdo?=
 =?utf-8?B?KzNZbkc3VktTZVI1NHJnQmd4TWtQbll5MDhBL3NxUG5QcEI4NU5sRkgrRlk2?=
 =?utf-8?B?NnVCWU1TRUY2OUUvUisyOGhNUWhmZ3JkYlUxaHhRdmVBdkgwU2NsT1pRM05n?=
 =?utf-8?B?dVU0WFhVNktTbWsxblJWa1YweGtRbWJac2RuM3IydWNMdDM2UmhOcTIyMTJY?=
 =?utf-8?B?VC96SWNqd2xVSnUzU2J3SkNGV0dRbHV0TEhpWlEwZmxjbDYxWDNtbG9yTVdT?=
 =?utf-8?B?MEZUSG40elllSDZwc3haMDZJUkRVU0VZR2U4cUltUlA5QjdBVE9yY2tGTzc2?=
 =?utf-8?B?Z1h2UDZhMnVaZ0tJWU5kZkZmd1M3Y3FmRXB1b3NTY3F0dzZUcncza1JmQ0Vo?=
 =?utf-8?B?QzdDQ0pIMStuTXIvUlYyU0NXVHpGci9XWUFKVlNKaEYwSjZLeHl0WGJ5bUEw?=
 =?utf-8?B?QlpOczFVcHZlMUhRaUxRdVNVc01ZcmJTYi96QkZac0R0aDZCTjNHK2s3NUZu?=
 =?utf-8?B?ME5OUnFuejVTUUh0b2hMaWxVQUtNR0d2VmJraml5aVhiMXJvM056U21RejJj?=
 =?utf-8?B?dDVmc3ZjTkl0ZUg4NUQwTzNsem0vRU5kQzhXQ3VwWlZrWG42Y2lpSnpCbGpM?=
 =?utf-8?B?YnlyWm5DRWxHY0F1NkpqVkE4N3pEZkpGZ3dxcDM2dmJ1d2hWbWV1SjZXR1JN?=
 =?utf-8?B?NUZENDU0cndpUHhQNlBENng1c0VITkowamwrOHQzQmlyNUl3bXRtb0lXdnEy?=
 =?utf-8?B?alptZkxVRDNLU2lMUnFXN3Fra205dEQvWkc4OVdpUWFSaGtTbkJlTW11dVVy?=
 =?utf-8?B?SFBSK0Y0Vm1sb1hTZ1czSXBESWxkSXdZbnlkS3BDS01vbFZ2b1BVb2JZdm5o?=
 =?utf-8?B?UVFkVXBRTy9KODJZQU1HU0pPeVVkcFpWYmxZeEdBd3VzZk9iMWNleDVtbFZs?=
 =?utf-8?B?UmJoQWZCNjEwTm9uMDBsY2RFVm9FSmtVckJDcy9kMDM1RUxvY3dvTldJdUov?=
 =?utf-8?B?cGxNMXJieWkyMnovK3h6Nks5cnpYeFpSeWlhRE96Rjc1NGlZNlNnSFBnMHNy?=
 =?utf-8?B?ckV0cFFsSU5nNXlQaUVMQms4VU84aU44SlBXSnpvWmtPelJVMERnaFp4YXdj?=
 =?utf-8?B?cjJDRFQvYXhJVXMzMVJZbklRcmhES0RvOVBpZlJzSStSUm13VXFaTU5Bem4z?=
 =?utf-8?B?NWxzTEs1UWZPRzRVOU1FNk9yMHRoSkZFMnJPY1RvSXFtaGJaWGRoVHRjZk1a?=
 =?utf-8?Q?HVDfEtUHVNxJC6GZFFgNvB8HxKDPHhUiwHqOFIvfEfVq?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	PtCQW31x41GTFn62QyesshbaGaSNhX+jJqqTMpUQUd+A+tDlLXUzpPtfayEDkS8xY5I/oVElazsJ9gKGFKRY2yiy+LabnpmRL16orOzhLDqlZrn7BBQg7UYs3l2TeXJzctWoZ3n3ze+5RqN7yiBn8z7Z8kiDgLSdnhufjtmsLEpOvlYTG4TKdcUBIDBDuUUXly+zshzet6kURYeLBl/QDXLu11WRcpCGLXdotQ2qHBjznG1AZCAhHFi0ariQ7oXH5A/Z7onsP3o18zZyWjGsjdVc/b00mgvkMedQtNHsAoNvi6RshsLriuFq18RAU52G6kFNbSMZxIsGYbdKMxP+e6KIa1egLVgT7vy7IvPqHjInaxHfo4VhVhxL8L/pDmf2Dv+9UPqOjX4+UqDMxB77hbAwCd4KtHo/vx2egvOtSmjTQUfjr5OZzsvMCVdxPYutHfy3ZHM2/RwNPcr9fF3J1elqQDbHEGFl0hOj2foHztJ4f8dbKjeL1oDrelv3CJVlN2RiLuKVbd/DTGZkQO3KUf/fx16/hUsjRH65U23ygEi8MMWehmk/Mv2YoZRzgQdnOx1j8GeT5ZCEs20wUrdGgafW0CzH9UWzxVzusbzdVQQ=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 347b5341-157f-42ca-4268-08ddb8783d60
X-MS-Exchange-CrossTenant-AuthSource: DS0PR10MB6078.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 08:21:12.5524
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4xWlE5Q/UxUbx/ToSIdkFK2Re5tfX8EJpZjlpuXKmRiczJHTdojTnD01cMTtfYbr92UWdQ3M1nxe+glXdLQwSg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB4782
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-01_01,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 suspectscore=0
 phishscore=0 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507010047
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzAxMDA0OCBTYWx0ZWRfX2PoUqir97rGf 5ofluoBMoVPcrCdBwd1OseE621/GB/MFiyKiwSLidXMY2T0eF5xRegqSPyAubT/Scyfxy9Sg008 Xo3F359kcebf3D2Ztb2G4yaXD+vADdyrU4F4NyqTBRFEB2vy/iPMz8thUYBpFLjKtT/zwERd7QU
 GZ5B501nA08dxRmgJuFEkrlg0Ny2LGGuIZgt1S1JWcp7MUNnrLw3nl+HI8E3Q1dVWYyjlP7Mgcm ivUENwyYPHzWcRwOHJ9hRo67sIAoOi36Z4n5AxuqNwclIspwEU4Sf4L7jnul38NJILfm8kEPtgK xHJSaMykoyUdYwVrMSO/AYSrvdYBsHGpXkyUfrRIW4ksiG4bfwY3UktoEkLAL7PQmQs+X8+76dv
 YNGvlPaiNelNOcoBWIZvVgGHh8sw1dSIKI0E7RzDrI6Iqay3NUYDg1rFNxlRwepuK6eefOcp
X-Authority-Analysis: v=2.4 cv=MvBS63ae c=1 sm=1 tr=0 ts=68639a7e b=1 cx=c_pps a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10 a=Wb1JkmetP80A:10 a=GoEa3M9JfhUA:10 a=nWhQQUS8FPfqSf9eo6EA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:14723
X-Proofpoint-ORIG-GUID: 0p0u8hcD2urNsuPXhUdYXZ1s2OOiizHy
X-Proofpoint-GUID: 0p0u8hcD2urNsuPXhUdYXZ1s2OOiizHy



> +#ifdef CONFIG_BTRFS_EXPERIMENTAL
> +static void btrfs_remove_bdev(struct super_block *sb, struct block_device *bdev)
> +{
> +	struct btrfs_fs_info *fs_info = btrfs_sb(sb);
> +	struct btrfs_device *device;
> +	struct btrfs_dev_lookup_args lookup_args = { .devt = bdev->bd_dev };
> +	bool can_rw;
> +
> +	mutex_lock(&fs_info->fs_devices->device_list_mutex);
> +	device = btrfs_find_device(fs_info->fs_devices, &lookup_args);
> +	if (!device) {
> +		btrfs_warn(fs_info, "unable to find btrfs device for block device '%pg'",
> +			   bdev);
> +		mutex_unlock(&fs_info->fs_devices->device_list_mutex);
> +		return;
> +	}
> +	set_bit(BTRFS_DEV_STATE_MISSING, &device->dev_state);
> +	device->fs_devices->missing_devices++;

Where do we ensure that the block device wasn't already marked as
missing? If there's no such check, could missing_devices end up
exceeding total_devices?

Thanks, Anand

