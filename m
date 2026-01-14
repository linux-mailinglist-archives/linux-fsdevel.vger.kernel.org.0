Return-Path: <linux-fsdevel+bounces-73699-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A7487D1EE79
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 13:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6EB723026484
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Jan 2026 12:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53B6139903E;
	Wed, 14 Jan 2026 12:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="VSid6pZ+";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Zh1oRfiE"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC6C396D08;
	Wed, 14 Jan 2026 12:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394772; cv=fail; b=ihOky7SPf+hrC1FLxYu0wRFnL6OQDGZESFAhuChuPvpgywNPxlPik7JoXmu51+NbV05lg3RhT12DxfC5k/aSuUO9R2c7aspugCz52J/XcLpmxsDsmVcduL8tsXhQw5Eyvwb+ZhA3x5aVJJI8ZNIC1tflcVSohU6unR8PWK5U3sY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394772; c=relaxed/simple;
	bh=Akcn46e5BusJ+1EfJRW3ASKaH5f/pVCn+M5JSD0dsDs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VN4mlZ7KNgE5mh+AzWjF4oJP/MjtNBu1NgS2Hu4zeA87edZk12unLvLKhGiglSaUCdnLnkzAq/ihgH9FcdafhRubD6R4oRGt9Ynp62ht9UstmWkRTg0siljq+gX04jFz1UtybZPBMcQz8LFnxkaYr/8JG15Ls1142wqbxBsYPic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=VSid6pZ+; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Zh1oRfiE; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1768394771; x=1799930771;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Akcn46e5BusJ+1EfJRW3ASKaH5f/pVCn+M5JSD0dsDs=;
  b=VSid6pZ+CYUbBxGSaSL/KrsXhYAnoozs6QBaEzKi/HCDOT2UqLgfazoQ
   ClyLjCfGhBTshnmH126q+5OdTHxqaNVd5gXXab+uJSMNJuNLxZZLhhKdZ
   kceSTArVrSNwEtWrjckJLahYtvpM74NW3cKWRcQv6axNbxVZL+GOddN2C
   5UuYXiE1divDlmchyu7IwzKdGe+hfQbHTGsKEgmc3D38YSY2mxqm5Nk5/
   eRRXs4+2/DUPui5wW0lM+RIqhYDkb9nUmP5ewKqyhtZgtVgdapWixRQRo
   NflxSLA1H4h7FAFvmobRKc9JDUhZoPZaaPzOicr0MCnxu6svV2PdKDOsB
   Q==;
X-CSE-ConnectionGUID: iTX1WODxQ1+hWhgOmogpLA==
X-CSE-MsgGUID: FiTN+18TR8S/h6m5jSDi/A==
X-IronPort-AV: E=Sophos;i="6.21,225,1763395200"; 
   d="scan'208";a="138542801"
Received: from mail-eastus2azon11010049.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.49])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 14 Jan 2026 20:46:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IsfoHZrc6uIZOm9kay9od/qEYSz+iyrHgwG81ZTKsbMh322/r/3yhedypnbdk2a/ZykzuBIwwF/5F+Hrjw73eKT4gdhyGMbvNZVAGOGUsqcu+FoiQ3ih4iKUloZRdgdB81pXQdGhG3BE0jKtT8hCwcdefCTUJGKVWkUNfj72uRSvI/X5sOUHprRCtKi+tIo5Xf9EgNQr4TkY18IStesAOmSL4NYBxz0J21GBNI0CtgGAw463Lr40uDpKTUvx1zD95av22i8XYltIofPZTqxtaAUfDO2al+W6KJDEaw4O9EGGPuEsVZzcGduGZFEgVXVrr5yjt1bzFBRUEIVIAxBzHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Akcn46e5BusJ+1EfJRW3ASKaH5f/pVCn+M5JSD0dsDs=;
 b=yj0oMptECpkKQl9y3srt1CCAFi/Lmb8rl/61FtmSaKrCxdMF4JKzMM0XEVTisegqddwdnpeqKshMahymDasbCJQ9FPvfMoF2kNy85im2DJWtXf6WKRsLGRUtzdZ50BpPJlUZSdjgUE3WWEucakxVoZDUWpqNK5PVWegd8fGXoltS7iRpEpcU6c4bMtQn1NnWUnbir3VVzWwTpagly40E9expRUaae0LxFgY1lVi+ZubygaHAE/FlHTG40A8XS3EL0XZ0UOGjjwaEgFaBh0O5VjrNjE/UCfOuofKl4VEVLpsT1LKeh/ngYSC6x5fsyI2gJqemGx77Dx+m7DE52DPRoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Akcn46e5BusJ+1EfJRW3ASKaH5f/pVCn+M5JSD0dsDs=;
 b=Zh1oRfiE/FN8JDAKf3FGf5ew/uEYGkGFX9ncR5ReAcrjmvu8etUe5lfUEkHKJGkY9qA9cLLRwGmGBoMxM9sJcLhXu4F1EZ6kiwE1XRU4Jz0HIeLaz2khPz0iIWLK6gM1LgdXTBbyRGovl+4oijJkS+iQAcM++hwNSmgJcc70RQg=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by MN2PR04MB7072.namprd04.prod.outlook.com (2603:10b6:208:1e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.4; Wed, 14 Jan
 2026 12:46:06 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::9ba6:7273:90bc:53a8%5]) with mapi id 15.20.9499.004; Wed, 14 Jan 2026
 12:46:06 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Christian Brauner
	<brauner@kernel.org>
CC: "Darrick J. Wong" <djwong@kernel.org>, Carlos Maiolino <cem@kernel.org>,
	WenRuo Qu <wqu@suse.com>, Al Viro <viro@zeniv.linux.org.uk>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 02/14] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
Thread-Topic: [PATCH 02/14] block: open code bio_add_page and fix handling of
 mismatching P2P ranges
Thread-Index: AQHchSlVX9BMV47DKUmvd3sftc1wwbVRnSuA
Date: Wed, 14 Jan 2026 12:46:06 +0000
Message-ID: <e9ac4917-ed9b-43ec-8628-bd664c9b7e13@wdc.com>
References: <20260114074145.3396036-1-hch@lst.de>
 <20260114074145.3396036-3-hch@lst.de>
In-Reply-To: <20260114074145.3396036-3-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|MN2PR04MB7072:EE_
x-ms-office365-filtering-correlation-id: 40b0e63e-9af5-4d2c-b985-08de536ae242
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|19092799006|10070799003|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?enQ2ZHRhNGxOVlRvVkZMSGNsR2pJZjRWMXJ0VDdkVExzeTlTQ0lkazM2NlVt?=
 =?utf-8?B?Mm10eTZ6TnY2NFBwQ3Y1enRlZmxTWkFoSXVTMWNzT0psSzdmWWNWbEZrM3pr?=
 =?utf-8?B?V1c4cjRlSnlHVVhaYXdqWlZnemhZUGJiRVM1dTMzdnFyc0g3ZUZvYzhxSUdk?=
 =?utf-8?B?dk5kTklDRjY3TFladTRhOTA2cGJkcXpHOG5uNGJpN1h6dytHWHhaNlRnY2pZ?=
 =?utf-8?B?MjZsSHFkVUJzTm92bGJQYnF0R2d3NGtwckg4ZEowbXNBSEpTZzN5cnFJTXlV?=
 =?utf-8?B?MXc0MnhTOHJpR3A2M2MzUDhDSWUrWlhmQTY3TThRVVI0a3Y4SmdUVmNnN25H?=
 =?utf-8?B?SnpOSkwrZFFFd3lRUFVrcWFtekdKdmlwU2lOZ0EwZVdSbnRDUFV1anFvTmhV?=
 =?utf-8?B?S3llQmJ5U3ZxV21LdyttRFlPVWwwc3ZUUFEyeGJWblNkRWpoeGpSZ0ljOGN1?=
 =?utf-8?B?Qk5mQUFCQUtOTXhjYWhMdHpZVzkwTWxCVWJoU2VadmhqWDJUc04xZlpUQXhy?=
 =?utf-8?B?NmZXNEdnUzhIWmdiNjBnY1ZETU8zcjRQcm9CcWoyU0ZVUXh3NGtqMGlUNWlG?=
 =?utf-8?B?WFJOQWZySDY2aXZhdzNwLzE5VlhXRzdnSkJTK2lsSWtIUnRkcTRNajlaVjVR?=
 =?utf-8?B?bkdJUURkZE5zbng5dml5RHNCLzBxSjBrMDkvSmlkcG9LYVBCMnkzUHY1bnN1?=
 =?utf-8?B?amRER2RteHd2OTJheXV3MHF0UnpKbDNhQ1F1cmxhMDg4bm9oMkRoRnJZMEd6?=
 =?utf-8?B?UFV0OE1MOXVtVHZzL28rSEVUWlJnTVhpZzhTWCt4TEhrWFN1eXpScktCWlRX?=
 =?utf-8?B?Y0lSYUwxaE5yZnpESStFam1RcU5CeEN5U3pwTzU4QThOcTNPcFRKN0JiZzFw?=
 =?utf-8?B?YVNlSWpBdHNNZTBTamxXbnFuZDRwSmFZbnU4U0xSejBSVEFQeC9tNlhEaFQz?=
 =?utf-8?B?TGVSaUZTS1NPWUpqQTFtU0kyVEdZQVdwZi9ZV00wSWRyVkJWeStLNUJmMDgy?=
 =?utf-8?B?U1V3eVoyUFJsSG5UUlRuVG9odUlSM0VEKytsUGVTZnM4THU1U0tCTHV6NHNL?=
 =?utf-8?B?bG1kKzNLNXBwck5VV2pzRXY2Q0VVVnFLdGo0L3doNWJnSkdJeVBwZDRWUDlJ?=
 =?utf-8?B?cVdrb2tlR2FCT1hnVGV5aml2Wi9ualFCeFg3MGlaMHkxRGJLZ0ZDYWZYdnlU?=
 =?utf-8?B?bWt3Tnp1S3ArVFRKVG5IQmh0LzZ0TnlMOTBKdlJQRFRqZnk2dUlHaEVDbEdm?=
 =?utf-8?B?MThLMG83VDFLYTRvLzJoQnA5TU9lbW1RVkhSSzVXamV2ZUNNZ2xBR0ZnbXBn?=
 =?utf-8?B?elA3ek5BcDdBeGlqaVNxQ2RXQUVJU2ZyNUNjSy9SckJRcFZvZXRlUnU2UjZW?=
 =?utf-8?B?aER6S2h6eVhDLzJjNDNveXlhdUFLQWhlYVE4ZTVhYkNSZVZSdUh2L0c5WW9z?=
 =?utf-8?B?bGFwYlpsbmpjUzFnenlQbThZVytaZU05Z1BoazhoY011V09IOHh4VmxxcG9J?=
 =?utf-8?B?UjFMQXVneDNjMFlHY1gwcW1oQllDMFlsT0pZcUUzVW5uODVpcTRhK0cxeDlS?=
 =?utf-8?B?NTI3dlZpNjliaU5xWUFBSFJpVlRDaUdLeXduVkxJTW43a2ZOSlFmYmhEVVFE?=
 =?utf-8?B?ZzJXVllFeUViRWs1WWRFNW94UFRhNTJxZGhXTzkzT0dTbEJlZUVpSTFOeDhU?=
 =?utf-8?B?NS9JMEJiT2lMaDZ5clRKZGttQWo0M1U5YUxqNnFodEVlRS85VnFSQXVnR1k5?=
 =?utf-8?B?elo3ZVRMYWIzRE5PSk1EK1p6b0lxV3JkMVF2Q3Z0d1ZXcjlKTzBlM2R2K1VY?=
 =?utf-8?B?aGVWckR3RGJpRk1UZkdQZk1LOUxKN3NJdzN5RFNDdGpuTUJLdXdGMldFTm5W?=
 =?utf-8?B?bzF5d0IwU0pIS2twNVdGODRjMGY0b0ppcWpKYUlTdmxtOFlHaHJWR0lZRitq?=
 =?utf-8?B?RmdVTEhOVmRzV3B0THVoaWVlWmtXSEpBemFqRTZjcjRtWlEwUnBLRGJJTXRu?=
 =?utf-8?B?UUFJVVU0NGxvNVZJYmw4S1doYmVPa2hzZXhZa1JpU2dyeWhlc0xTN3Q4Z01V?=
 =?utf-8?B?RzYvRzlQY1daM2h6M2QrdjlSY3JxS2t1bWZndThFMS9FVzlidFk1WWtDZ01S?=
 =?utf-8?B?YXYwWStQeG95UWc5S0VnZVQxT29hUGdIQUFSeGdLZ0I3cDFJYlV4bmJnME4x?=
 =?utf-8?Q?fz1sSsWRfxY3rESrmDSikNY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(19092799006)(10070799003)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?bVZhQ1lFS0dUTXZJcCtZRWcvZ29pOEJvM2hsRnIxNWVJN2JHSnBQbnBWaklN?=
 =?utf-8?B?d0V1YUVyclpJNjlBNVRPVi9UMEtaa01sWWd3Wi9BMkovaXBRazVQeTZOdmo4?=
 =?utf-8?B?cUQ0K1FmajRaV25oS3NTL1pVWHlKQ0dtSFcvRXhaT1YrbVlDRUI0S1RtT0Z6?=
 =?utf-8?B?YzRJYlRUdEpPbzFVUWJMRjZ3UkVWTHNhWG5GeGl1RUlmTjZJa0xWd3QxeVU5?=
 =?utf-8?B?Qks0cnIxdHBIS0NKTlZXeU5jVmhmL2NvMlZZMS9mZlBPRlJLQUFmRWZ5Y0Zw?=
 =?utf-8?B?bWNvTWg3T2hCU09QbklNZkkxb25WMEVEdFRTYjNmS1NNMExsand3aUFkazNw?=
 =?utf-8?B?V2N6c3N5OFdsVjdJQk83d2dUNTBhZ2F5cGFvNE13YkdSUUZoay9uV2tvZFlj?=
 =?utf-8?B?d2VRbThWU3ovVW5RU2owMTFIeVQwWGtza0tvZ2RGb1UveXI5V2hPS3RGZGtM?=
 =?utf-8?B?Rk5vc1YyaFowWmZYTXdibW9zalZMZUs5WDVvREhERnphNGFOMnVMYnorMFdD?=
 =?utf-8?B?di9RNHVIOGpubFNCL21qUm5JM1Rqelh1YmhLZ0ptQ3NObkh0VU1yWm9QWkJX?=
 =?utf-8?B?RUsrb1kxeFFnNS95Y2hYNzNhSlRKV3B2RXhFTXlod3VlWjFxVlBuRUNrQjU1?=
 =?utf-8?B?alVzaVpKbldiU212N2ZqRitNcGswRzJzN1d2WUF5aUI4RjFMQ0xMLzUyMXQy?=
 =?utf-8?B?VDFCYmp5Y3ZoY1hlZXVsN1pjdUs0RWpFcWVWT2E5aXd0YTk4RUc1blh0dHBE?=
 =?utf-8?B?L3lnbWE1SUEzZk91cXFkam1EMlZndkxnTS8ranlsU0crRGdSU3pnbG5EeXFh?=
 =?utf-8?B?M2tKcXJ0YVJwVlBERmhsbU5uZTBvOVViSU1IWkI1OWxzL1Fsa09BK2FlUGF0?=
 =?utf-8?B?SmRuVnNNd0VSekpTTEFsK1JDeWR3RnpiWlZPdmY0bWwzZ2JTbVFJeWo4SEI2?=
 =?utf-8?B?bElKY21iWVR6RXR1bERYTmk5RklubStHTERRM2Y1YUxEUDVxNzVwWUVOSHpV?=
 =?utf-8?B?SjlIbUpXa2dMNWg1VVd5bkFxNVh4My81eU9BRlA0WHJrMXF3OExleDllSXhY?=
 =?utf-8?B?MkFUeUVjWHkzVkI3RHhhTVRwM2RZOVpNZWIvQkFRR2ErL1NsSG5MbHM1M0ph?=
 =?utf-8?B?Q2NvZWFZMUxqbnFXQVBVdTQ1OUhybkdRaFYrUm5PbWNFaU5YSmpXZllEaDlr?=
 =?utf-8?B?RFBodHVaNC9oMnliNERBZTJiL3d3blFvQ1FHZTdNU0Z3ak5Ob0FzY3YzSXh6?=
 =?utf-8?B?eHg5czliOWxvcWs2eHFmRmRrcmFWS0Ftd2FDaWhJQ3V4QkhGNGRCSnR6dElD?=
 =?utf-8?B?UCs2SldWNGcrN0VNTlVxcnhjLy9uK1hXeFFSYlJZakZrQXNMVk9oeEl3bGRD?=
 =?utf-8?B?TEduRHF0N3MyTElTZlZxTHJIUVlOUllwL25xb29lWi93SUNkU2c5VEg4SkZx?=
 =?utf-8?B?SnpSZWdIQzN6aHBDYVlJMWFuTE40VDJNaGdHWVpSMFgwU3BBNWdmUjlPNE9K?=
 =?utf-8?B?eE1QdGpmQ1VaL1RDbDZnc3pjMEV1Q0ZZL0l1THJuL1RHS0N2UEF5WXIzM1pH?=
 =?utf-8?B?YlhOeDRVV0dJR2dEcVRsdkpVOGVBNm9Jc2NmSkxSaGI2ZEI2RUZmblJXbytP?=
 =?utf-8?B?cE5qMEltclR0TjJCY0xxbnp4ZHJZU2J1K1JVelRQV3JYUU9xakNSN1NXN0Nq?=
 =?utf-8?B?dzZhaFRjVERodFNkT3ZvejA0TklSWkpOQlFxdW9uejlBbGlrRjFYNS81b1dT?=
 =?utf-8?B?TEZqZmlmR280K2VrN01CZXRzd1FtY0tLYjZscGdzWm1IRXBqUk9lbDQ4akRp?=
 =?utf-8?B?VExkeHdMU2s3bmdKWktDUGV1MGd3YUF4NWtJendpUHFrR2dGZmUyT0RHQkR0?=
 =?utf-8?B?L3ZtT252Q1JKWklZNDhiY09RdmJIaEowQkVlRVVnUEk1c0NTMFJTR2dsQ2J2?=
 =?utf-8?B?L2FyKzJJWGZpdTJPMktPR0pjcE5sbXhFV0hhcWl4eFBiaTRxZmU3YThBSlZq?=
 =?utf-8?B?alRIWDZyTHZmZnRET2JmSjFTVGRqYTdYa1g1Y2R4Ykx2NUZaQ0ZUZFFhYjN4?=
 =?utf-8?B?cXlNNUVZd2V4RFpXNWI4NTVIcWNFbTRzT3NoQ1M1cUl5VTM0b2pxR1VZNTFN?=
 =?utf-8?B?MmxoMVgrTnFSNVRMVXY2V2pWY25mbkhTSGJLSEppSDJSd1lvS2xrMVNnWjVH?=
 =?utf-8?B?YnVBdk44eUNhd1VIM016YzJrajQ2VWxValVhZy82K010QnNkbUZBZlUzd2Ju?=
 =?utf-8?B?dEoybDlyL0w3V1FyQkxKRk9NSTNTRE90ZUlONXg0VmRBRW9WTjRtejRjYlo5?=
 =?utf-8?B?eFMydmJRZXNGVHlxZjBlaVhzYXZwZHpjZHpJMWszNG9wZyt6WnpGT1JPZ0NY?=
 =?utf-8?Q?D9Hxz1RNjStjHHpPgK+qJ8xiwQQbHwBC2QHRxPFtMcEKD?=
x-ms-exchange-antispam-messagedata-1: oxPblRefqvy1J9cCzAXZyCJ2Q1nbJTYmktg=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5F34FD981E9956439991C8133723B5CF@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	H2fPklzcMX92+HLr2d0a0WOaQdoB8R+AW0dcIrAbLgKQWZnpigCbnM+HE8iZ6BqSuqflwEBzHYvDaZDfPw3KoDamjRqpJwTdSKC7tWU/EBbLSJ85193n8Klt3c0VDXrhnijT1zX16TNPQ7MJ1p2FZJT35DIBSc8u1Pun4RqX0uV3Q9tmMRncXeOw8JyTNd40RKaep/tag01q+TT056DQwV5WHamrdzsWFmJGskciatgRuoyqJwxUo1JiTSXuB+Z8/D8tKzhnIbNT6pnQEv5F9HjDyq1OBGAib8fz+ShtwZI53dg6jWx0t2//x4VBC6xpgUShVYcGAk7q2EHzyNJraI+cBa2xcR/vBeYDO06qomOwxY+xxNqIPtVuI/go0sqcQhYGiOa4y+HrVAA3CW41w+b6ImhXYciD2SILcJFLjbVFrolUcR4oYJaygk23MJZQ9krXrtf1LyB+lcGAEE+LI8iqGr534FYULzHYA4lLPLB59fx2w2LYp8PjA/ZLo1x5x0i+cpq5Qcc4zGVW/vRn9OXPh6j5P04joQL0Bk3ZJaMEb2zD//TZYRYi7xmQffOFy66eIphzRlujWdTTg9wdFiLnEgmE3N0pELrdzJuG71xTF3YwwcOzQ9QgpD3uz9zF
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 40b0e63e-9af5-4d2c-b985-08de536ae242
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jan 2026 12:46:06.0642
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1CJhwTXEBdwiVMbe0a5kPpGi/DJoGtRJTL6gvzFYvg9u8Gplmo36vnI6vXVy2tPOS23VvFigcVC7PCu+EWZ6WPrixgRknCAHOH7qQxgQ//M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB7072

T24gMS8xNC8yNiA4OjQyIEFNLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90ZToNCj4gKwkJaWYgKGJp
by0+YmlfdmNudCA+IDApIHsNCj4gKwkJCXN0cnVjdCBiaW9fdmVjICpwcmV2ID0gJmJpby0+Ymlf
aW9fdmVjW2Jpby0+YmlfdmNudCAtIDFdOw0KPiAgIA0KPiAtCQlpZiAoYmlvX2ZsYWdnZWQoYmlv
LCBCSU9fUEFHRV9QSU5ORUQpKSB7DQo+IC0JCQkvKg0KPiAtCQkJICogV2UncmUgYWRkaW5nIGFu
b3RoZXIgZnJhZ21lbnQgb2YgYSBwYWdlIHRoYXQgYWxyZWFkeQ0KPiAtCQkJICogd2FzIHBhcnQg
b2YgdGhlIGxhc3Qgc2VnbWVudC4gIFVuZG8gb3VyIHBpbiBhcyB0aGUNCj4gLQkJCSAqIHBhZ2Ug
d2FzIHBpbm5lZCB3aGVuIGFuIGVhcmxpZXIgZnJhZ21lbnQgb2YgaXQgd2FzDQo+IC0JCQkgKiBh
ZGRlZCB0byB0aGUgYmlvIGFuZCBfX2Jpb19yZWxlYXNlX3BhZ2VzIGV4cGVjdHMgYQ0KPiAtCQkJ
ICogc2luZ2xlIHBpbiBwZXIgcGFnZS4NCj4gLQkJCSAqLw0KPiAtCQkJaWYgKG9mZnNldCAmJiBi
aW8tPmJpX3ZjbnQgPT0gb2xkX3ZjbnQpDQo+IC0JCQkJdW5waW5fdXNlcl9mb2xpbyhwYWdlX2Zv
bGlvKHBhZ2VzW2ldKSwgMSk7DQo+ICsJCQlpZiAoIXpvbmVfZGV2aWNlX3BhZ2VzX2hhdmVfc2Ft
ZV9wZ21hcChwcmV2LT5idl9wYWdlLA0KPiArCQkJCQlwYWdlc1tpXSkpDQo+ICsJCQkJYnJlYWs7
DQo+ICAgCQl9DQo+ICsNCj4gKwkJbGVuID0gZ2V0X2NvbnRpZ19mb2xpb19sZW4oJnBhZ2VzW2ld
LCAmbnJfdG9fYWRkLCBsZWZ0LCBvZmZzZXQpOw0KPiArCQlfX2Jpb19hZGRfcGFnZShiaW8sIHBh
Z2VzW2ldLCBsZW4sIG9mZnNldCk7DQoNCkNhbiB5b3UgYWRkIGEgY29tbWVudCBoZXJlLCB0aGF0
IHRoaXMgaXMgYSBkZWxpYmVyYXRlbHkgbmVhcmx5IGEgDQpkdXBsaWNhdGlvbiBvZiBiaW9fYWRk
X3BhZ2UoKT8gT3RoZXJ3aXNlIHNvbWVvbmUgdGhpbmtpbmcgaGUvc2hlIGlzIA0Kc21hcnQgd2ls
bCBkZS1kdXBsaWNhdGUgaXQgbGF0ZXIgYWdhaW4uDQoNCg==

