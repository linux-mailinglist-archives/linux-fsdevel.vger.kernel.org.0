Return-Path: <linux-fsdevel+bounces-75034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OLKUHO0icmmPdQAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75034-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 14:15:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id EA79A67241
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 14:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 12DC762C18D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 13:06:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3122D94AB;
	Thu, 22 Jan 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="qfzpvb8S";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WMog3psc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968FB244670;
	Thu, 22 Jan 2026 13:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769087129; cv=fail; b=JHugpJBBoNG/TiB5jv3TUHRzvxhSrox/Ow1zVjg18y57PayP8PdcQHZfT5+VTOZzCPPrtc+m27oYQiV+SQCE9c36WxaFdEyZH9/7ekxnncT7ofVkq/BqYidLd2iExD1Z1i6iUau9EjMHP0hf5nrT2CVnyAqLmso+k5yxcsnCWz8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769087129; c=relaxed/simple;
	bh=mcVjTQ/dWEd3wDQpBxSZruq4zD6Tft0F3gJQ5/FmXZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WQyvm7vQwWnZY2qauIVGjsGu918KEIeTUI/mq1zzotIAh5HqPj010Ek0V/VKEEYFIwwWknXcF7tsCimvq1VZjWCK/C8zH7P+1RibsE/DeOCanxmQ11LQaoTIb/kkS4ukiAeXuda7w4IpQQ3xONMAF4btxgHtDFPqfoAXLzwODdY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=qfzpvb8S; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WMog3psc; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769087126; x=1800623126;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=mcVjTQ/dWEd3wDQpBxSZruq4zD6Tft0F3gJQ5/FmXZA=;
  b=qfzpvb8SoT8xPsG4rgai4i105jK2KLVW9UoD90sKPEnwvFN/8u06293f
   Yb38tfyJ154tgX/0IR12r5w6ST7FLcIqjEgrt3kZtwzD/Np8OOuh0dvl3
   UleSGYDpCV76HfjK4XHTK3TbRMy+36yP0cvtCDwC72aIuoFZvlobpCM1z
   nN3R/PK0G/8DfvqC5KWvxy6f3w6WX5GSdD5yupvAT04BmQocLzxUB7Ub0
   Z0oyKMVleH1t+BCNQCVQjvfLsgOCI2Kvpg+CYZzXQpovc6dlc1oC+5yKL
   xWcgvnsGqNQNhDx70EOMHq6t56QnFDNR4pgQHCB29Cq3bvtQp670r9n5z
   w==;
X-CSE-ConnectionGUID: BIyEWw0kQ4CPyNQEJ4vCPA==
X-CSE-MsgGUID: yCe+d4UpR8O/NVuS/JYBXg==
X-IronPort-AV: E=Sophos;i="6.21,246,1763395200"; 
   d="scan'208,223";a="140451858"
Received: from mail-eastusazon11011003.outbound.protection.outlook.com (HELO BL2PR02CU003.outbound.protection.outlook.com) ([52.101.52.3])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 21:05:24 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hqsxeC0jeDx8GdbDeu7UGZ46FNSZOlZXOktxIszKznJCl4biAJ3+7ghQUJJ2/9JY89NZGMpt7asbKqdqxdLpMRZThxUBgUNPQ4FTbJmFIYao6mvZTM7JhhR0y/hF7sAdGxBmzHnxm09PDlS7OsbD0XZz0K7LmPt6CuHLtoPyPQz3BTsmuTRDCW5kg12ZqVOhjOxRZE8C3EqmMhMmcKV1kBNBhBW1AZtmSCRiyHr4RDxD7q9o+hzngv0URM3cMr5+xPSDZlumvpGHcYTRVV98lO9ZDgBb+ZkhPgYEVH0nyU6hLnxRGMvNgXnIXfcCcjYAt0+c0La6Qx1sPO8PZnKysg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mcVjTQ/dWEd3wDQpBxSZruq4zD6Tft0F3gJQ5/FmXZA=;
 b=Ya0TEMne1ocMhxQFWEAAQNQnLx6XMDTnZYhvU2356+hV4/bAfbuSWxVi1RNaf4u4xebw1HRyqIycgOjECBgQvzYXrpeQW4ix+bQlLveA0l/gguqU2A6zqHgga8rfjY4PgiuK+jwbezOKlcy5EGlM1nnWtFXqOCleO2HzQMIX3br6CvOJzBm0PCf8ixbQ6D2CwAETE/oTUOu1CiSwv1Zjp1ZFSdeMdsiIjG+pAySSFIzJJAE45rVH0bhBjJ+ON6R9N2c5G9iCRfLbSIlbTKqBawSleBOmII+n/bzONsPr2oLSP6hucM14ridtkb5D43zk6coGhzt/Wf/XTPTaImkZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mcVjTQ/dWEd3wDQpBxSZruq4zD6Tft0F3gJQ5/FmXZA=;
 b=WMog3psca4Ap269djG7js/Mu8Wou6oegmaphjrePzs5YJJ+0P2N/++5aYZfa3bRi+Z5+6B8nisbePcXtvSQBGPxtUwKT0AvI+WnBYmcux+F2tSvtdsNYulbm3Wa9oI6xtg0O5RamzyacEg2CaUecBb9xQa/MmKJcuJ2g7HSg4Wc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB6832.namprd04.prod.outlook.com (2603:10b6:208:19e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.2; Thu, 22 Jan
 2026 13:05:24 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 13:05:23 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Thread-Topic: [PATCH 05/14] block: add helpers to bounce buffer an iov_iter
 into bios
Thread-Index: AQHciRgwrUjwCsM0skyaUYv20x9P/7VeLViA
Date: Thu, 22 Jan 2026 13:05:23 +0000
Message-ID: <848832ec-99c7-491a-b9d0-974874bc7ff6@wdc.com>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-6-hch@lst.de>
In-Reply-To: <20260119074425.4005867-6-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB6832:EE_
x-ms-office365-filtering-correlation-id: 00eff7a8-696d-4ae9-0466-08de59b6e7b5
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|10070799003|19092799006|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?UGpxSFd2YXhTTnhkaWhBRVpxK2QzM3VQbmpvdTFFVSsyTnBNK1FaQlcxUU4z?=
 =?utf-8?B?ekwwUXhlYzJmSkx4clEzNmw0YWxtMEVLSEplOGk0WnRnNE5DQ2REK1RZanJ5?=
 =?utf-8?B?SHZRbFcxMC9nM3EwSnJCR3JtMDBKdDRpNVppVTVXcEZFK1Y0bnlYazVKTkk2?=
 =?utf-8?B?QjNVaDRzeS9zWnlFTjFGTUE2b0NWZzdtdWl2ODVXZ3g1VWV4WFl4L05UZG8z?=
 =?utf-8?B?MjVuZ3lLdmUrSlF4NUN3RnF3UXZKUGFkVTNsOWpmTE0yT1FCRzFseWcweHRt?=
 =?utf-8?B?U1VPLzFZbldxZVhRRlBmcFFpTlNicjR2eFJBaThWUmdRSXI4M2NzY2gvUDJx?=
 =?utf-8?B?MmIvRHg2V25XR2tjQzlBMk5veVhwSG80dHNCQTJwN1dMdVE1UWJXMTBNeVN0?=
 =?utf-8?B?YVl0YTM5UldZUTNWRi9MUm9SN3NreHR1Vmt2OWRXaGxSaGxUaCtoaUpjcERx?=
 =?utf-8?B?MlpTdEhRRG9oUnJzdUZybGQvODJualoxbXdFM0JFdmc5VFpIVk9pdndwbE1F?=
 =?utf-8?B?eklWVDBLeU1WN1BERWVpdzVXSHF6Wm83ZXpCY1JKQnpFTG5KYmpXQURaSW5P?=
 =?utf-8?B?cDFnS2FKVHJsZ0RDVVF5UVlpVzVkRVRDVmpSMXZHaFRaWGw5VTcwZlZSQUFm?=
 =?utf-8?B?VkJFVzRib3lQRGJlR01EcGNFWW8xbUNvdmVRVVRqNUhhZEVJeVdFcnRic3Av?=
 =?utf-8?B?dzZocldZdXo5TE9ZY1BYbzFibUR0dlVsRVVpV2NNUHJkVGRYWEV6RG45WDJO?=
 =?utf-8?B?VEJONTN4WW9OczcvMC9NUjh5T0RJaUg4TXk1MFF1RGRUbERwaHRudTI5ZjE0?=
 =?utf-8?B?OGRIcEliMThWc3JFOGNGc0JsZUtJYVNwTHJBM3l1ZW9SR2hqVFZwcmE0cnZh?=
 =?utf-8?B?U2JsVXVvOWdQQnNETmpuWGVFN0owcUs5eXBoc1pNUmJLZmdocjBxNWhDNERC?=
 =?utf-8?B?bk0xbExyME16THJadjVuS0crWEdtWTZXSHFLTVBTcnVjd0c2cE0yOTZZbmRi?=
 =?utf-8?B?U1IrR28yWCtNWjVyT2Q4YzZnWTFYTWlsZXJYS3RsUXRnZXIzcUNJRldIZEhz?=
 =?utf-8?B?T3RoVXBCWTFCSCtUbDRVN2hSN2xiV1lBNGtONHNreS81OUtPWHJSSURienVO?=
 =?utf-8?B?b2VqOWlYVThKSjNtcW1qU1p6M05kYzRQcWFlU20yenl5Yk14K09TUHBBaHZw?=
 =?utf-8?B?cU5VQ1hKUG1qTG9PZFlGdm5razUvdjFlYUdiWUE0ejlNSkFocTVkMXdlYk9I?=
 =?utf-8?B?ZU1hT2xNcVQvb2Y3Q3FVUTVKelhLR0NTUDFYMjZQakZRR1dkTklsNDY1ZnND?=
 =?utf-8?B?UUY3TE1ML2hQaUlJOWYxSXlhaHg4TkVvM21kdG0wL1hHYitnbWRNdlhGR2xN?=
 =?utf-8?B?Ny8xSmxId0Q4Ynp6Y1R6WW90ZnZIRjd3WUZaUHVlTm0xM2VjZUVMY25UYm5C?=
 =?utf-8?B?TDV5UlBpRU51QmhFRjFSakg2RUlHRmxmYU5tQVV2emdLemNwTlA4OU1MZS92?=
 =?utf-8?B?NTJPMGordmY5NWJPcE5ITk1KODVqajhYVDFlZngyKytwRnk0TUN4amJwaDJY?=
 =?utf-8?B?Vkd4ZnQzUCtkb0w2SzlnUUpwcStHMUVQVGJFWVZlcjBRcG9aTFZtdGMwdHY0?=
 =?utf-8?B?N3dOR0E3Umd1MjUxOGlrZDFzc2FYY3pPcEZYZEpqWTNJbzR6NmZVelJqWkNF?=
 =?utf-8?B?cWlXWUEwTUV5WUxtOWtnQ01uSTZMdkVGTGw4SDZwbkNzM2R4WUFkTm1qZnh2?=
 =?utf-8?B?NTRyQ3ArbmN3M0s2YW5QKzVaM0ZFdlpibE0vN3k5SGxQYk1UbHU2UENLSjEr?=
 =?utf-8?B?dzEwOXFSWTBHa25qZUM2by80Z2p0WkVJSW1wY3hNWW0wbGtnY1dVZnNoOFJz?=
 =?utf-8?B?SGMvZURMQUNKVDlnN1dNVG1sZGJoNzRwT0VndFNwR3FoekZ1RTU1cENrMnBQ?=
 =?utf-8?B?aWluSlByMEo4YXUwZ2NrblkzVkNRZjF1SzVuRmQ1Rnk2WGxxZkRGYjNpdjZp?=
 =?utf-8?B?Y0VSOVdvWG9NNEo2MSthaDlwblAxelJ2WVExZXhEODQzSHNtaldzMUg2c09s?=
 =?utf-8?B?aWpHSG1FSXFwT0NBMmlEdmVnWVQyRi8vL2djL1JxcDgrM1pFbW5KQTJqN1Vz?=
 =?utf-8?B?dHhadU1TTE1md2VsbUZZUll0SGhyUzAwdWxralNWYmJzdnNURDFpdVRzaUZH?=
 =?utf-8?Q?USbKl5IhK7ZG/WJ+C46jKjk=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(10070799003)(19092799006)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?VDFCZCs2SFdTUWRKdnNoZCtZbDJSSFlVeG5GQU9oSW1Pc2Erbkk4cjBGSm9M?=
 =?utf-8?B?S2sreTIwK3Vhc0h0MnNZTTN3T0t1UlhCMTFhT0Y5QlUzSVhLNWVJTXJaQzlr?=
 =?utf-8?B?b2ltYUljV290TmZZS0V5OWNjV1JvRjRvMEh3QlJwOWdhM2VodkMybDk1MU9I?=
 =?utf-8?B?ZHlGN3J4UDRhVElndS91TEhseHFDOGp0RXhzMlhycmd3Si9XMktQR3gxNGxq?=
 =?utf-8?B?UEMwYTk1WWJRcnR1SWFYM1I3VmxzbzhmTmw0N0tzRjViYVJKQWh5RUhUZTcx?=
 =?utf-8?B?dEhmbjNVc21LL2JhenpuYzlkUFNUUXMzbDN1THRmSGJ3cHJpV2xXMTVZOERs?=
 =?utf-8?B?YzhwYVlRa0JDb2t2WGx5cUxaQXJQUjAvRTN0MHUrUmhaNzloaGl3d21LeE5I?=
 =?utf-8?B?dHN4RUQyZkJLL2FESzNFeGg5N3lCMTNURW5aejI4c1NOcFN6WnJyc0RjS0w2?=
 =?utf-8?B?eFpaV0h0bm1DY1hDTFRqNVJZd0k2ZnVJSjlzZkVnNG5ucXhQcEl4ZEg0WUVT?=
 =?utf-8?B?VlIyN3dQaWZ0NkUxSnZQMnR5K21QeXVYNFl0ZXQ0SlNmMzhmYWFMQmFoeTRK?=
 =?utf-8?B?TUFwbUZTTzVpN2F0RVhJUFY5NFZFSjdsYUNWTStEWTJQbk81MlBGWG1BZ2VE?=
 =?utf-8?B?bUZyclFhR1BZRWJWdlg3TmFzWXVUd3FuMnppNFBYZVVLZExUQTlFV2NGeU9h?=
 =?utf-8?B?VFlCMENCZHFIQVN6cVpVcFBmOXBJTmM4cnZDNzFISnlOVFNtZXNoV3paMGdP?=
 =?utf-8?B?bExPajRHdFRQTnQwa2ZlR1g0V09CM0g2bmFlVWRJRmxITU92YzVMdlBEY2tI?=
 =?utf-8?B?aVdCRTRRQXBVV2NaNml0QmFlbkxpUGRCMDJHWk5zUjhrOEFtZFZXdldkOVVE?=
 =?utf-8?B?QVlOR2YxMkFPQkhHb2tyU20wZ2RaVkNvMnhpT2dMY3kyV2VPdXo1ZlJNVENo?=
 =?utf-8?B?aHk5dUxyRFZYSDdIZUJWenBlVm05OTdOU1Q2WnRIUEEwc1RQUFdreGdTSzA3?=
 =?utf-8?B?c0psZHQyYy9XQ0wweGpyUVFnTW96VXlaZEN6bXZvUUg1ZFVseUJ1bmQ5V3RG?=
 =?utf-8?B?TXFJTjBQMzZqVEdoWlJmTUZlZlFzRVhUMENUVkcwbWV1TDJtOGdmVmpndlYz?=
 =?utf-8?B?VWxJWDhNWjFEb3ZDSnI4Z0NubnhuUzRGdlMyd3lLN0c4N2tPZDBlSlBZUzFO?=
 =?utf-8?B?dWkvWE82UDRIam90a2srdGY1Q0h3c0xkREg3ZnR1UGRHTTA3T3M2RERwRk5m?=
 =?utf-8?B?c2ZEMHRPOVhrdk84eFBMamxnNVZVSlJqampjWGRuZFpZWnA1Qks1VmVxVVNB?=
 =?utf-8?B?MVFjT1AwR3B3dWEyM3JYU1p3Wi9FTER6cktLLzBIb0xaNitxRFVaalFZcVBH?=
 =?utf-8?B?ZElUZWZNc1p3dnJCK1JlR2NaUHhLakdweERIa3RSVUlqUTkrem5VWngzdmN0?=
 =?utf-8?B?WnVxRWJEalJHd0M3bFp4T29JakFjdEJjZXhiL3M1NHI5ZGpDWmNhTkRtbmlk?=
 =?utf-8?B?bVFwSGRtSGNOdXJlZTg3TzN2REFJNkU0ZlFUeno1UjFVTE1uSk1BdW1nSGor?=
 =?utf-8?B?VHp0OTBKVCt0d21HUjBTaTlYQndhc1Z0c05DYXRuc0V4RG9IYXQwN2RUc1pQ?=
 =?utf-8?B?a3lSaGM1MlRBdUdzY1VPNkVxSVYrMXhROWdPbjY2NnNMdlBWVzRkUjIxZE4x?=
 =?utf-8?B?cGpVMWJOVDdKMElyMzNDTkt5RXd0TXNkNzBXWmZaWlRnT0lBQkdSN3VqQzZP?=
 =?utf-8?B?U1hsKzB6SUw5U1kvWnhoNlZpMDlNalQ0T3c3WEU1VGx3WFZuRHFxYTZsTnR3?=
 =?utf-8?B?RUtRZXcwR3djaU1HZ1RnK1FtZXU5TXpLUXJ2YUgxbk9GSkhHSUVnUys3QzNp?=
 =?utf-8?B?S3JSZ0YvOG9hanZHQVdBWnpwSStjRk80VmdIQURwQ1dFK1VBaGJPWEFsdE9B?=
 =?utf-8?B?ZlpVeHFZcmI5c25kaU9PQnpLVjRPbzgvbjZtd1hOeWxOOElWcnloOEc1d0Z1?=
 =?utf-8?B?N3h3K2xiS2dZVzRQMUsvdkRsTGhRaXBGcFlBVmdZY3ppZ0FGZ09hUFNwRzUx?=
 =?utf-8?B?c1ozUkNIN041MWhCYzFLdTk5ai8zU09jVDROKzZONDkrK1FUVkE3d3p1aUtW?=
 =?utf-8?B?RW9OWHVlelhKWGZ0Y1pEcDBZelF6SnNZejR6aUV4d3VOMjY5cjZNTWdIUXhx?=
 =?utf-8?B?Ujc5b3EzbFIwOXY3NUxkZjlkclhkRGsxZjRBdG1kcVBWYWo0L0FaY2VDN1Ry?=
 =?utf-8?B?OE9WYnBBNHpZTmFRVDJ1ekEyZTRCRExZQzVNc2NkdmlUL2JMaGxEMDE3ZDAz?=
 =?utf-8?B?Z2Rpd2wwTGJucXo0QldlOWYrL01PcEJnWCtqZmFFQjl3QVFoYUQwNCtrdDNR?=
 =?utf-8?Q?nGXaT18AYoRzHwSWjA4r56SSH1B2OcRt+jntPel4Ph42Q?=
x-ms-exchange-antispam-messagedata-1: 36Agf4OFsKMuNshVOGty6K1lY2qrLLzqDvk=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E3D7FD89D8BF3B418500D3DD1E25D751@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	nl75msM1qh7AmQe8WsvvPEaQ4WUgvHIwz5Jc3CMD4SpD13HPqLWr946JRebbx/8Q9PfUxSDuUHD988iUrL5/SIySteJ0PrmG9nKis+XzTBZ3HgPvTu+sCkXvb1ii9NjN8K/quRBT2Bg9AACeYT1bEAWk83Ob0ozCbH2cipJWwOjsaWjPQ3nkkbckqLBq5bkttzC1Xh9JJqbICCW9wVUIlc7mfTB0rUa2Nu8AbfGc/5Jm1+TIwMRQqkeKbjHGv/xHi+En/JfFvsv7+qLBNqAj/6CJJuReaPxKPMxxIe2sA1K0Sr222YkkshlRaz7Ckq7XrbQjbV3/GdzcuaOmPK9mV4i6fN15n/g0aCMiQb7uPMXmtsVG2MgR8JBUzNS0seLpoHWIj+6oeeUR8J9kbMBYQmMvHHIOJXKzln+q1Urh2QYRc1Oqo0VezfZEM7Zjz9M/8ssFLueXhmw+oyXjbFKn+U3FAWKMQLaVJZym5ArJHojY40hye13iI1S/D+r1XTCwY9/NJhBgmlo8vJaaprNFP9jNNTd7agRKt7ywP+mvMDXmFsAoZUuxAGCp5AnBcuBQ0M4IZ+/Qdd/7ehrxG+TSDNo8rYteqaRK4izZroTIZGlg4jRycuRtR6JgykVCm57R
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00eff7a8-696d-4ae9-0466-08de59b6e7b5
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 13:05:23.9322
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QahOU9WLO0dPPy1PmuVCwIBLNjR+YBRg2GE/FC7g3eD9we2ygOPOPoOtIwe5KlQljBt18AKdIGsAbAwkL67WbVND9cO5Q5yY3Ecwu1UX6Js=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6832
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-75034-lists,linux-fsdevel=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[wdc.com,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,wdc.com:email,wdc.com:dkim,wdc.com:mid,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: EA79A67241
X-Rspamd-Action: no action

IEZyb20gd2hhdCBJIGNhbiBzZWUgdGhpcyBsb29rcyBnb29kLA0KDQpSZXZpZXdlZC1ieTogSm9o
YW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4NCg0K

