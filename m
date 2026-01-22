Return-Path: <linux-fsdevel+bounces-75021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KCm3C48IcmmOagAAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75021-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:22:55 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 762AF65EC4
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 12:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4237A8A8A1F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jan 2026 11:08:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C203338F922;
	Thu, 22 Jan 2026 11:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="EaAZ3une";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="CLtMBXda"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DCE343203;
	Thu, 22 Jan 2026 11:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769079659; cv=fail; b=O4x8p8spn7lU/gmiz7k2TtyIZXzLqoXtrnKC5Z2g1putdIriTlEcE7rcqL58QepkVTp0MygVABRsX5lhn7fPZTSOc8nl4bUfqVDa+tI7NcqzHk4RIUC71DgG+VNlS+8XbCXURali5HbhUcGk3RqCnbrVL5Vy9ht8cRtiHJnLsl8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769079659; c=relaxed/simple;
	bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSxdW9958/BKqaUIbfA6RyhidtRB9w0DrzgmXa/PIbHNos0Z7qCNpfOgW8pRAasdfQkULNcJA+ZvjWtaFESKEdFtruBHj7iFZnJmd62bcypykGeGKIQGmXeTN5FhIiIg6ZLZrGsYpWenNGk+6l2iyAt+xowX/khkcn1DDQZQA4s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=EaAZ3une; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=CLtMBXda; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769079656; x=1800615656;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
  b=EaAZ3unedXqf/enwhL1ZUAMeifAOWTroVwnks8gZ/5+kJNCj/WGcKemM
   1fDNXrT+VGaBSM4VVWJ9G+VZhrJFQSSQd+UlEZ7TjKcD+LdEjC6PqOAo+
   /wT0HzAVgqb/R0AKXoxUzlR4qDiGPk5CsUdgTi7NiaVsKg52L8O+80Sv+
   0iI0jl6/JehpNo9ClTyOEPRNo8ZFlhNNiC+xjB/E3u4uFaOCjqoAjp38n
   NYXwO5feq9a3hq1J8PSjqKYNdT2VRCa1ynTcA5wDwaH/3P1t13dt3FKtL
   s3DYVX/Xr26SLiDTU4piqzncdDxUgweG38tvyao2qHFJJrKL6rtgMv+hg
   Q==;
X-CSE-ConnectionGUID: wow0FFNlTFySYcbBFfhQRA==
X-CSE-MsgGUID: PsDQxDjlQVObieEZrFEbpQ==
X-IronPort-AV: E=Sophos;i="6.21,246,1763395200"; 
   d="scan'208";a="139014763"
Received: from mail-westcentralusazon11013068.outbound.protection.outlook.com (HELO CY3PR05CU001.outbound.protection.outlook.com) ([40.93.201.68])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 22 Jan 2026 19:00:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kfegg81dhbZTRUwEq82IGnxH0xrwkm78sHX5Fhc/r0OWy837Ew6DpKkzNcxVY1yis9DpA5dkS0OeYpzTfXE/wtv07fOceHV9hENGq7YWc2aix3aI9RNqSD/EJE5qr2dy4GAHrpsB6z+JIWyP3MJY43rREGhav6ci47LVIFhvm0w4yjznJ5Fygyj5Aa1VUKUTLoLFkLiRiThHJRXBpAKX0s78MFgcXTz9rt/5W5zl5txwsYEG7BpuPzdwnf3gaDLZ56KljnbEGwzpOevMOeNt44SFPu3YLoN/EGxeEh7MIeQ7cDJI+IuKpagmqReK0jLhHYUxztm52IZ9sSMKkAJ9YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=xfOqk3cBxwobUotg9euLcRDnKjpHdJT+GPOI6zc4i672BZQ8NEfZkBYlKiNqU773wVvvByezyQ/psnMGG05Yi6n6gHOAuOp+zo2/3MCeUMHstSn6dxuEbG498DtaWfNb0OtsM8L0AFKOzqNzSA5vufMsvj2pKORVy58PFSWl6Dvu3EYrHZe+KS9dDSaxjc1BEbK4hA5qnz94ai6Ms5MkPWq3JEoQ2CntyzEpY+IhxfUgYNo2XrguF33bvcuBOPHpUqw24yE52WiDvVEYBwbQClRYALVHMMLAG0xNhQjNRh+diqkNZ49qgVD836MEk3drDLQatLL52P9mSyVUhZymVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vk2hUJbB8x1kfmvsTSguaM0YPcY6xrQ/6geYb6UO5dM=;
 b=CLtMBXdaLQ8uhYEspyUN+OWmC11D6SzX0T+45chUswce8ZVxS1d8JEB+5u1EyvIEpR7yKlkrNCaKwtgXbrVGsHOJBFvioWcYoGtbx7veAG8fCVBeJCNLFXAXb8x7r/IVsxyXBfjOfFAmVVBgUQwcGZhYHTW9g/PyDgXcTmc8yDc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by SA6PR04MB9375.namprd04.prod.outlook.com (2603:10b6:806:442::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.3; Thu, 22 Jan
 2026 11:00:54 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9564.001; Thu, 22 Jan 2026
 11:00:54 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/14] block: refactor get_contig_folio_len
Thread-Topic: [PATCH 01/14] block: refactor get_contig_folio_len
Thread-Index: AQHciRd9VQrSP/QF8ESl3BYB9n4z17VeCpGA
Date: Thu, 22 Jan 2026 11:00:54 +0000
Message-ID: <8bdc018d-480e-4b64-9ec3-a5f645e14122@wdc.com>
References: <20260119074425.4005867-1-hch@lst.de>
 <20260119074425.4005867-2-hch@lst.de>
In-Reply-To: <20260119074425.4005867-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|SA6PR04MB9375:EE_
x-ms-office365-filtering-correlation-id: e1e685bf-cff5-497e-c04e-08de59a58363
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|10070799003|366016|19092799006|1800799024|376014|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?a2FQRnVTSW5yZnFydmF1d2xZSU1aNlhTR3JJc1lmTldjSFpJVWVmVUl3bGZq?=
 =?utf-8?B?NjloemEvQzhFMkJhNEQ3UHlzU0pMVDE3bFFjdEVoRHloKzg4NkFPbWpKZFJK?=
 =?utf-8?B?UkpCVjlTZkpKT0ROUFJzcytvV0xtL2Z2OWVrNFlLcjIzbG5ObGxQZ3o2SDhv?=
 =?utf-8?B?VnI0cDVyRHVBMTFyKytHWFJGbU4rbEcyclRIMDlIcXNPblNvakxMMEFqZjNC?=
 =?utf-8?B?T2wzMHBaV2sweDFFYnRCTzJrQ05WeVltd3E3ek5ZdDhET3NGNkQwelFkWEF3?=
 =?utf-8?B?ZmtBeWM3aTZmT1d4TGtTL1BlYTd5cWJGZEFsZGEzMzZRalQ1Qmt0THpLSTB6?=
 =?utf-8?B?MWJ6NHJPck9Hd3FnZkU5YzB3SFRNRmJyelNUV21YWkNOeWVXNjRiRncyVGJu?=
 =?utf-8?B?SlpSNTBUdkVVSG9hb2lNOVliK21MN3gwdnVxenR4aFliT2ZkSmZLdW1DNHUz?=
 =?utf-8?B?a3lBMEpLVkh5bWQyVW12YUpBVUpFY2hTUjBYTTJOVyt2ZU9Jc25rRVN6OFVP?=
 =?utf-8?B?clIwT0lOK2N3UkpVczVhaGFBaTNucTJnZzRBK0xFalcxN1I5OUltWTB5NTRS?=
 =?utf-8?B?VlhxR3pscFZHZTNROEtsRjVxek9mRHRpaS95TkRFaFFyeFFvTWE0VGRESkhw?=
 =?utf-8?B?UndIL1RhRDRCTTFsTC9yU090OXV4MWdwMnlpaEJ4YVUvKzFaOWZoVGsxOFN6?=
 =?utf-8?B?TUFtb3U2YW82aTcvVWpwL2MwNkY4ZnNaMkRRTDFBaXczL3BPMVRPck5TU0J2?=
 =?utf-8?B?MDBxc1FmaUl1bmo1akJzUDJad0xHSHpwdkhEdmpTbUdpbkRGYVk0WlRYbWtJ?=
 =?utf-8?B?SnQ5MWRZZmtqOWU0V3JoTUEyVHRZVVhvUDJSUjVFd2VhTnJCN3JuL0IvSCs3?=
 =?utf-8?B?bVo3RGVmZmVsWnZnYjhhY016Q1pXNk55WVowTmlWZmIwUk40UVZobCthNHlK?=
 =?utf-8?B?bHB5TjhDNkF2a05YangwbFlocEN4bU44UnZYNGN0enpBZnBoQkxQNU1mNnpW?=
 =?utf-8?B?ZDNPbHQ4Qnc2SGQzMWRYc3NoUjJGdlhtemVuRmo4QlpET1ZRVnFDU1g3L2tL?=
 =?utf-8?B?MS9oeVc3cHQ5RVpnOURHbms1T3kwbmxwSUlkK2w3S05RS2FnUmNvcHdhZWNM?=
 =?utf-8?B?ZE9GRUpHVW41WTFMeVJZTk5XQWJLTUJRdVh1WUlmZXh0cnhHZ0RaeEhWRWpW?=
 =?utf-8?B?NUJxREpXUnFGNTFZTTkzYWdla3NEWTNwRU1mRTBVYWZyTmZLeW5NTTBKSlFN?=
 =?utf-8?B?ZlBHSW9FdVV3dG94ODk3OW1Pb1E5ZTMrZmhqSjBlYTdnSDVYQWpRRFAwZEdC?=
 =?utf-8?B?U0VyZWFBM0tlL0JyVzIwSkZ5eGd3dmJWZjZCVVdVYjBjc1lxRURPS0V1MEdG?=
 =?utf-8?B?Ukk5bjYwQVBHQzRxM1g0SWs4K3FRd2hkK1RwTEZxQUl4WnFIUE03YnJpSjlo?=
 =?utf-8?B?blhiZHB4OEFmZWU0aUs5MDl0ampxV1dtaDRqaStuNk1EeHpWQjcvZWVSckxa?=
 =?utf-8?B?azV4MjEyWTR5SVZ2RG1abHlzL1F5R0gyeDJoeHlOdzFOOTdFWURIV0ZIWG4y?=
 =?utf-8?B?YTQ1V25XTnluWHUxRm5paTk1WlN6WU9nNFFWdUxTZXo1WTNZTHp2VzVaYk5B?=
 =?utf-8?B?UHl3bnd6L2xMVmFCR2NlNHhPOXRKVktpMVM0eEwzNHlnMWFKWFU5UEgrcXhF?=
 =?utf-8?B?R2lQRUlQeDMxK3RQK0tkMXQ4bVhwR3dZdStlZFlMdzN1eUJxQnlwUU5VaU4y?=
 =?utf-8?B?R051Z090Z2lDZ0t6M01QNFFBQjFUdlo1KzEzNFVDalpYOWxpanl2NUM3RHdK?=
 =?utf-8?B?UDIvUXd1R0o2amZsQ2lwa3RKSURkR0EwYWVDQUdnQjZVY1hqSWgwY2JvMDhF?=
 =?utf-8?B?TUt2QXdjeU9qL3NSdFJ4aHEyWUE3TTVtSzFuZTV0OEhkREt3QS9DaFExNHZH?=
 =?utf-8?B?RGVpb09kMmZ0ZFlUUmdaK05kUnBRaDUrNzNrV0ZpNkMrRVdkS2lsTXV0TERB?=
 =?utf-8?B?SGsraW9mZ3JSUERiMDdGdHlZOUUzMGRTbUkxQkJoRlpvQ2RmdWVEZ1VwdUtw?=
 =?utf-8?B?NmdkdVkvOFZRZFRwSS9zcWVHN01DWEt1Vm1lOTQ3S1hoSmpxeDdnRDdrdCtJ?=
 =?utf-8?B?bmhvclRWdy8zb2JJNk1ta1RyaUg0UGZ5ekMyTDJTWFlCSFhWWG0xQ0FCaGkw?=
 =?utf-8?Q?HXainIvcHe9wpwhB3P/WugU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(10070799003)(366016)(19092799006)(1800799024)(376014)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eko0elFHcGU5a1U4eFMwN1pFWnBpWE52NFZYck9aakJHOTR6d2FlVHIyN2g0?=
 =?utf-8?B?dG5PRjZOZmtNellzT2tYUEMyejhQUzVBZHhrT0w1dy9lU1o5OW5LRCs2MDla?=
 =?utf-8?B?eVAydXdtektRWks2aDB2N0hJdmtXTEhwYVRtdDJVNHh6aTlRdFhOVlBrZnVn?=
 =?utf-8?B?QTgvQXRtN2JRcHFvRTFLdi9SNWRvOGdmTXZRQWlkaDdPRU00UWFNbU1DSjFL?=
 =?utf-8?B?V3JoNUk0ZUJUZ0IyTUZIdktyVDRVRlVoS1QxeTBpbU1pOUNSSDFZRGd6Q1pa?=
 =?utf-8?B?VWdaVDFFdGZLcXk5WDU4ZGNYNVJjUGpua3pxZ2ZlWnlzNjM4NTI3Ti9UdHpX?=
 =?utf-8?B?ZHhyZDFzaDc5WWU3aEVSVzJGaFVtQWxWb2xkdnpiVHJSL3QyUlYzV2VSUDdy?=
 =?utf-8?B?ejM5c1NXeDE5eENYZC9aNHZUOVZvbUpIN0xVcTUwYzVsT2pCeWZ4MmEwZTVI?=
 =?utf-8?B?dCtEaElPNWx0MlpYNUZJNkxiendKUWhUK3FsS0c3eEkwUld1b3ZqeDcwbVlY?=
 =?utf-8?B?a2EwODF4NUZkYWRQaHRYcUh1SUFMMHFZdXRiWkhsUEMzbmFnTXl1UnZoblFK?=
 =?utf-8?B?K0xLa21QU2ZLQWVxSXBva3pYM3lWRDdYbnA5VXZZbHIzUjIzZDkyYjQ2UGV4?=
 =?utf-8?B?bzNZanFCenlFVVE2UHBUZnhHditlV3crc2hwcEZ0SU5QRFl5VjQ3RVZaejVv?=
 =?utf-8?B?eFJkeGpQQThOdnRndFN2aXBwaGhVNmFBd2k1aWhvSkhkZGtRTzBBMHRRZXhW?=
 =?utf-8?B?dklyVzFiT3dwTkN2TmZaV1YrSFZudjM2TGUrTEpOWDNzc20ybXkvazRuRmJG?=
 =?utf-8?B?Y1ErQVRDc3d3dzFrdW1OTzFxZlZqajN1VnViS1JxdStoMVJGSHh5QTVLVWlu?=
 =?utf-8?B?bkx0MDg2TjFXK0N5TklNZXhRZS9jTG5CQ2ppdHRLTjMzdzQwSldWdWkzR053?=
 =?utf-8?B?Q0JJM0tOVlU2b0tlK0lJQVlIZm4yYWRyNWl2cDlhMnJSQWFEdTRnR2owUHdR?=
 =?utf-8?B?ajRZLzRDWWV6aDl5Z1NScGMwSTZublNodk4xb0FMcmhnY0J3Q0owZmkrbEhY?=
 =?utf-8?B?Yys1S1ZhcXlqQ1h1R1pQN2FER2pBbFVDM1B3SE1qdVpKSG9MODRjR2E1RWJy?=
 =?utf-8?B?R1k1WW9oTVp5UHd3MXpSbUY1OGcxbGJ4L0lWZjNTTHNIbmRoUllabDlrV1JY?=
 =?utf-8?B?WUdUVFY3UUJwQjB6YzEwSW5hTU04MnBZUWpteXg5QkYrQ1N6d1BwUHk1L0VV?=
 =?utf-8?B?MEMreGdZWXdHR1k0U1hlU0NZV3ZPQnd1UDBaUXZqZTJqL2kwVWZFZGIzYkt5?=
 =?utf-8?B?d1dyam0wdkZaeEJaa1JsWFJEd2R1dzRtRVNVMVhOem9KOC91NmUveGtRekto?=
 =?utf-8?B?d1JlVWp5dGR4NHNXVDNidkE0VTVXdW9NTk9iYmIyWnJXK3UrckFqb0pZVVZQ?=
 =?utf-8?B?NEtrd2d4NkpydTI4ajRldXVBUjlubUh4ODZyWmdya1JsSnpMZk1jeXllL1o2?=
 =?utf-8?B?aEFneWZIVWJ1RElXSWtOcnFyVE9wY2xCNFZ5TTBZY2U0K0d6N2Z5T0tnYXJX?=
 =?utf-8?B?bXkvRjl6aGdpbjRSNHVEQmlUSEttcE5ZL1JJNkdSaGF3TUhyaDgxNDFPOWdY?=
 =?utf-8?B?cDV5RWs5TUlIbEp6N1cyMjVIN1F3RTE1R1RuNUM5NlQ3aXNjMjczYzBEcFoy?=
 =?utf-8?B?NHJ0dVhtKysxMGd1WTV0THBQemUxYXViV05Nc0pyNkZWLzViTVZIZXlxRENR?=
 =?utf-8?B?aFJnaG5YaTdrUElIK2FDQ3RmUDdpeE9QWnNCZGtISGtzeTlUSUxFREtaZy8z?=
 =?utf-8?B?SkJRU0ZUUHNSL1MrYURXN1pqdzY1SElUSnlPYytSdmFkS2Ftc1NGUUpiWVRG?=
 =?utf-8?B?V1ZETGpPUnJuTlNNTTVoWW1TeElTWjl5cTUwVTQ4UndReVVzeWFvYmI0Y1JP?=
 =?utf-8?B?Z1pRazNFTVBqa212K0k4NE5LZlpMQ0tqRFZOSDI2ZUQwRmRGZzRheURVM2Va?=
 =?utf-8?B?OWpvRUNQdi9oVENzM1dqeEVsajAzM25CT0Y5cmlWdTNWbTZkWXdRR3AzdGdC?=
 =?utf-8?B?dUNqQTdTMVBLVU9acytpc2VVOXh0dis1VXV2Q0JRbEZJZFN4VXY5d3BCZDFR?=
 =?utf-8?B?TGhGQXRzTlNTSitkbXJZSHlYZG9jazlWMXVmc1p4YXhlNXgzY1BxdFUxQjdo?=
 =?utf-8?B?K0NxdWFMN0xjRm5yZzFxUXhrbU14LzhHenlxT1FmNEpiYVoyWXRVdDJTbkV4?=
 =?utf-8?B?VTVFenlzR1EycmkvWmJxaW0zNEhFVmoreTJXNnJGWDB5elZnVTFTTEQ1Q3pE?=
 =?utf-8?B?djZMdTdOYjRpaDFiSkJDYWpJZTRJai9hRHc4d3ZCenNtNVZzU2YxOVFjUXhu?=
 =?utf-8?Q?+jLgrxtO1+lQrgeZ17Nf0U1NoDjqf/Ur9MceIHL8NOAX0?=
x-ms-exchange-antispam-messagedata-1: 8KZQneKd2EqQXLB4XnSSs0So84pH2bwmrd0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <4131B21071DC824088C34B41376BB356@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	OzyeBL2SURbRkOjScQpH+dbsEIFI7LbwVEsYJeNeYIljlF1022IWoeFHmwcHDm+8LNh+HLLiqjpiJYmqd6Vz6tIjVDyVnU8Xn47JsV5j0ZGPQX6/49Zu7v6nsW88tolRbD+WwakxpgnwB3gKjNTRAsieAumkgpyAUK8/U2YcRpDqpsvMmUJWSjyY7esvvGlxqltwfBCMh0i314ckUBox6UGPpnjmRXN0nmBfdnpnSDhSyw2UhFW9MIaW28+6Xx4PUk/+R66uEO88hx3cE83JvDXcsbdEw72ZdyOvwAvSa2NpMsLYxyDPnZm4jCKrnKim7xHemSq6BUrnQ1ckPGgjTg91WsLQEcbWVkXBVzPnV21QDe8Zlj8TXjw29OV5Hg112gmrNjYbBEQNuDJdciyIxHcS0hynPYOIUjPgwFQfV5lV/zajGBtNDXjuwFuNbRfkb4iEPD6Yof52K9YC5jRVRDT3BDwEZTX1jmAGoBszoqhHWzec1GtUVGP8zr2hVVuK+Y1wRTip8RP9ouCSEVJNwU6+7lqefHEKkfZiAdgwhL3RukFMbWcA/qwmYmSNp2snlWJmEnKBoQRNmHsS7ypcOI/vYzNULYkHC54QHkD3D57mVuK2rOjWVOQIMgpWWJYs
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e1e685bf-cff5-497e-c04e-08de59a58363
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jan 2026 11:00:54.1366
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IepB2U7vuq/Jr38Vyj+Wf9Mp+lwTT1KFdUPkmkdPRlqpgeb/h57FxoeUUYgya1kTr6cz3ops6nFaRRPfPPEGDm2u9hiOMa1j6Dd9f9OGeSE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9375
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.14 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75021-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[wdc.com,quarantine];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,wdc.com:dkim,wdc.com:mid,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,sharedspace.onmicrosoft.com:dkim]
X-Rspamd-Queue-Id: 762AF65EC4
X-Rspamd-Action: no action

UmV2aWV3ZWQtYnk6IEpvaGFubmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5j
b20+DQo=

