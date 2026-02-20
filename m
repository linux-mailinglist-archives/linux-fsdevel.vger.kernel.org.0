Return-Path: <linux-fsdevel+bounces-77769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cKpUIpsimGlNBgMAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77769-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:00:11 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 25593165F9B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 10:00:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDB9730059A7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 09:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94B212C0272;
	Fri, 20 Feb 2026 09:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aOmYbtNo";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Ra0Q41Mh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8604C311C05
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Feb 2026 09:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771578007; cv=fail; b=rl1VaRZ//5ULxj0xrcMN8qqieaITVB2WXuFfCUt5/DYV30H5Iog6SvRRNORrXDH1fiRwnIbMWJi86exPq9JuH6voZa8y5WsdQaYf0SmqVrFzKgybDKRnv1yEPpihYKT5szSLf0dUK0fpSSSqmnLw1eEKAjLvK+uBoFN4IvnQaXA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771578007; c=relaxed/simple;
	bh=cSG00Uhk4qxfR30Ot5+4pb9fIkVDb6Qb3+jxu2XHEXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Yhox9jCm5EsIGVen17JU61Ork+QmJ8eG6QdGzZfYCLS87QrSwqsOtQwE8KYlQNd4Kd6O74Y8IZHL62ilp1RLg1drUfD+S+4v4WJgvNDOUSnHJpLSVLQOnSX3y0RPc+w9UHZo+MVWIZAGApxLZJ8wbnUaLpfqFWxq8Tfmb8s2oBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aOmYbtNo; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Ra0Q41Mh; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771578005; x=1803114005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cSG00Uhk4qxfR30Ot5+4pb9fIkVDb6Qb3+jxu2XHEXs=;
  b=aOmYbtNo4NLYhm+ruWkH+iYzLEtWRqZQY4mrazaw/xBm/t0eDNRk3wHl
   qIj5xSNLXRhWYmqV/S28lRBUvx3o7KPAMZ67YlRo9/B0y/CrJyVFB8/0m
   OW1l+zUJ55BWU5ZeNV29UUDSgij6qSNXT9tuK/TCP4ArBes7y7/iMvipf
   VFDYC+WbmIkTvARl15O6LzS9lpGPqCtQNJiVnp9h9fLMK9+g1K0S4QbgT
   xiWgxNlFOF7GAIMReEs0xqWGmaVoyJQF3HDWymlignrhBa1TGP5tGzlc8
   idGIHVQ5mlkrX8UM/pf+6yHPggt9/KZm5MM8mqfqQLq/qDCZztYxtZSg5
   w==;
X-CSE-ConnectionGUID: 0n2zrug9TkOoMoymmJkVLQ==
X-CSE-MsgGUID: yh9rwTnbT/yFwgFuo2xi0g==
X-IronPort-AV: E=Sophos;i="6.21,301,1763395200"; 
   d="scan'208";a="141659609"
Received: from mail-southcentralusazon11013054.outbound.protection.outlook.com (HELO SA9PR02CU001.outbound.protection.outlook.com) ([40.93.196.54])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 16:59:58 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PCNZNjyZjMEn+/A4mdqIJlosCkvsX1KYdZ295/ijwk2T2ZrZi+8kOHWJ06P46KVVKMtKJeVyYgI1YdgcOwVg9rxliLZ+nqswKDTZQ+Sq3Ltp2jMGRF2FidHkv5lBnqoO2jidCkGLqXJ/GsLWinXIdH+a+fGkgiMzcFQBJXwfdLjNJG3kPrb77lWv4r9YMH3MmPgLwaHqtgrvlXujPTH3HY50bLp/1nGVgqGyEjtcxOYfn7uzo0S+q3t9u5gq01pfOYip3IsoXIgEMCMTjhipmilz0d/sG+q9TX6czL7SI4DOsGzH8KFVK58txdR7+MAT54dynxLv3TmyhGwqbgygKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cSG00Uhk4qxfR30Ot5+4pb9fIkVDb6Qb3+jxu2XHEXs=;
 b=c0C/fxxlnEHGXiCq6rFa0ibwb3rs/nr8e4MI4gBlYIXFI0pKNQgjPRrwd5D83lJDuYmp5jgpZxeDmtKbt+5hq8p/SqHO53/TnPVHti4e7YYTRDYJbAzDidhFJFnHjbRMCfNte/hbOaCyPrk/Q/5ahPn2Z6Aj7leRB8vljE8zWD57QRAfPcO/wINCHTAZGoFAvRB5feX1ZLm5qkvy0w1nt/yCbKV8M+ZpMN6JfFl3CLDhT5KAa1PHTDcvITOZsvAqLcoJECeMQnJ9L5zUbJaZYvzG0TdH8NWqPFNjXO1wLDlcPhsWJoTcp9q9sDqBVUVOFu7qh64p+w5tzyolkSGiWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cSG00Uhk4qxfR30Ot5+4pb9fIkVDb6Qb3+jxu2XHEXs=;
 b=Ra0Q41MhiRFGIaIksRpGvPNnLQ9z2bJaGBFc1Nwv77eMvdsWptfKunyy6ojbplLAfmKNG8pvBmSISKu5S5LeycFFTrrTR9Vg4FfpApfa04KJ7MBTPJOo9GTl2FTT8CYrNMSyMYS3PW/AR1rRVkUBap5evEIpbZJkuOQ8i8rZRCE=
Received: from PH7PR04MB8755.namprd04.prod.outlook.com (2603:10b6:510:236::8)
 by CO1PR04MB9556.namprd04.prod.outlook.com (2603:10b6:303:273::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 08:59:55 +0000
Received: from PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba]) by PH7PR04MB8755.namprd04.prod.outlook.com
 ([fe80::5df3:d910:6da7:49ba%4]) with mapi id 15.20.9632.015; Fri, 20 Feb 2026
 08:59:55 +0000
From: Hans Holmberg <Hans.Holmberg@wdc.com>
To: Theodore Tso <tytso@mit.edu>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le
 Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, Johannes Thumshirn
	<Johannes.Thumshirn@wdc.com>, Naohiro Aota <Naohiro.Aota@wdc.com>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>, "jack@suse.com"
	<jack@suse.com>, Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Topic: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Index: AQHcnCVy+M/y38WvJkeD9gq7IpAat7WInukAgAK3WwA=
Date: Fri, 20 Feb 2026 08:59:54 +0000
Message-ID: <660844a0-bf83-4d3a-8fec-84c02b678fef@wdc.com>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <20260218153108.GE45984@macsyma-wired.lan>
In-Reply-To: <20260218153108.GE45984@macsyma-wired.lan>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR04MB8755:EE_|CO1PR04MB9556:EE_
x-ms-office365-filtering-correlation-id: f5f2031c-4eb0-4857-ee63-08de705e6a87
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|1800799024|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?NFlsK2pmYm1lWXZDYlkvRFFyV1NFQmZ6SldnRXh0dkJjZHJKblQyd2p5eCtw?=
 =?utf-8?B?dHROcFlTVEpGcnhwd3dLVm51UmNDYWJFWkVjVEMxcmV1a0xFWWFXNjZPOWU1?=
 =?utf-8?B?N0lLQ2NhakdSbUFTL0NrVjAwN29VRUowWDJWSVphQXVGeEg3QXVSb2dKcWNt?=
 =?utf-8?B?MW5DY3NNTVN5LzYvaDg2L2NmT1c5bEY2NzRjc3ZXYWN5Q1BjTGM2Tmw2VzR5?=
 =?utf-8?B?VEFnQW9rOFZjQjVVdGVTTzlxRHdwV01WaWhac3hHZmZPcFdaeGQxU01Xc1RO?=
 =?utf-8?B?cC95RVVnN0VJQzhqUTR3NjMzQ0l2b0lQYkp2bTRZK3VYMy81SDlIbjlBVk5o?=
 =?utf-8?B?YTRyNEtXK29WNWQ3cW1JenhsdzJzMVhqcXdreXBvY1Y0TC84Q0xJTXl3RllZ?=
 =?utf-8?B?RjFrbzNoMjdsWEdKWUhXUzFMZVFSeTZDdkN2SVhSbXJYS0FQb1R4K1pKVGdP?=
 =?utf-8?B?SHJvZHZpbjVlVzJVQnhoRnR2bld4TTIzWVR5aTlWUUpOUVFRd0pYaWZNZ0NI?=
 =?utf-8?B?SGVmaENSdTdhNGU3cFk4RzdLUmtPMWlwcys2M05EV0pmY3BlVmpuY0QrWjRT?=
 =?utf-8?B?VlB6S0RlTjFFNitpa0JwaUJCQjQxa3ozVWpaenI1Q3lpM1Ywb3c5VDBCNUEw?=
 =?utf-8?B?aFc3UFl3Vk9oNlRjMFJXN25FanRHRGRlTEVjTEJwOUZJanNXWk1pVSsvUjkz?=
 =?utf-8?B?cElCMk5oTDJObFlrc2RaT3o3VUdUbXpXRG1sb1ZDSUkwUHlhd0pFc1hSNlBT?=
 =?utf-8?B?a2xHbERwdjVoYzVyRGlHM0IwNnFKZVM3bEFnU0Q4YVJvQytCRFZSdHFSdDFK?=
 =?utf-8?B?ZTFkL3JTVzJBL0QrcUpsYjI5Qitkb2tzMU43YjBYNE9uRWxmS2dDNXNjK0Yz?=
 =?utf-8?B?K3lveWp3amxMSkhZUEdMZnEzOTFSOHVhbVhwcmhxRnVJdDUwdEJDR2JXa0Vu?=
 =?utf-8?B?cTZLcm11blEzdTBRMy9CTjl6Vmw3dnVudmE2aUt6S1drd0xsQ2JtSzFJYURK?=
 =?utf-8?B?bUtQK1hCdnJrSURybUo2ZUZBN0FwM1dPd2krT093Y01GVXlBVTBBLzF1YUE5?=
 =?utf-8?B?UTZoNWs3dlpPS0I0U2IzOXdXOHBKb3Y5dzROR3hkcVpDcEFqeVpJU0JIL0w1?=
 =?utf-8?B?MVVlM1VVTlc4RjZiUkNDM2pXSld1YVoxb2NIek13TGc4Mm9HZExiZm0yU0c5?=
 =?utf-8?B?ZFVNNGZFaER5aFJLaitWRzVCWlBuSnZjaTgvZ25nZXNCTmxzcklxUDUrT2to?=
 =?utf-8?B?REJZTGllQTBicGZhVjlRV3poTHMrUStrZlZGOHgvNlRPWDR4WEx6WUFYUmxQ?=
 =?utf-8?B?akhXUkRIVWZpQ0thTzdKZUtZdWdrQ1BDVFpRSForZWthcDJXdDRScXIyWElJ?=
 =?utf-8?B?RGIzZUhRajdJZTFNVGl2NnBobVM4bUNUbDlkYVF1eUgwVlUvVVhoblNWYlk3?=
 =?utf-8?B?bGR5YVltcGJ5eXlBQkp1V01tS3NFV1Y2dGF2bDVsNmd2R2d4REZQR2RHTXhS?=
 =?utf-8?B?WDlrRjNFWlFKUVZjWUIwYWoxYVVjVDdEZ2xRRmhUMXVPbzl2Rm0zTVVieHAz?=
 =?utf-8?B?OFRPOGZOZFYrZmk3WHRldkMyTzRyS0NUTS9ZSnI0d2U0ZTBuNUUxczg2L1FE?=
 =?utf-8?B?V3dJTVkyNytmejVxbTA1ZFV6N3d4ZmRqSmFoUGMrNjVYY3NOamRiblBPRkRx?=
 =?utf-8?B?eEZUK3V2S1NoZW1XVWJVRzBqSHMvR2d1SUxqcDhYckVNaHdoWEhhTE9UbkFF?=
 =?utf-8?B?Mnc3SlgyNzhJZEdDSlRVMTNaTHBEWWIvd2FoNGpBcnI5KzhSMFVXemhBbnBt?=
 =?utf-8?B?NTllV0dDVUdqNmh5RWlJZTRVdStRakc0R3ZoY2FyRUtTSGxPQ3VMRDVCM2lj?=
 =?utf-8?B?UnVUOEIvZHF2bzBqSU5tYnNqRk9LN29Db25IUmNjYlpaU1E1V1dkdm1IZEpi?=
 =?utf-8?B?QWJMbUZjcXpac2pFNnNiYVBHam9scnRIUVRLSDdHWU5LWHVsWXpDZUFQTVNq?=
 =?utf-8?B?ZkFYdU5iQkVXVmkwRHV0N2ZRQmJ3MEExMlBSS05MZ2ZpVGM2anllcTFkWlda?=
 =?utf-8?B?QnR1UE9LaGlSWDBkU29wTytCc0M2WTlJSHRZY0NQaE9QRkxIRFlQTXl0dlZr?=
 =?utf-8?B?aU1GME40ZTlIRk1tL3hITUpHTEtDUkE5OE0yOXFrMTR4T1hzS2UwZFQrTWw3?=
 =?utf-8?Q?6OrM2dthJuTDJwEdIqsqdBU=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR04MB8755.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(1800799024)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?WUFVenBoQW1FWWU3ajdMNGp5d0hzS1EyR1hnT21uNzNFbWFBRnpneFV5bFp0?=
 =?utf-8?B?U2psTVRyWERFYzErVm1MVGNNNU9HL1poWmNRNU9FVnJnMHg0WmVFUFVGNUlV?=
 =?utf-8?B?UEZ4MEoyRGdXR1hMVWZOd1VKbXdRZXBQMGJxNnpTa2VZNDd0NW9qZS95V2tW?=
 =?utf-8?B?eHFpR052dTNlVUxkU2lrUW5yWER1dW44QytZKzV4WWQxYTAweXJxMzNEcFE2?=
 =?utf-8?B?NVJaQkNHQlFLbTZPUWNGejJGREhhR2huOWNuQ3l0eFlyazg5ZXI0MUg1bWIx?=
 =?utf-8?B?bXl1R0NJYzJsQVpEQUFPSDFOM2pwdEpBNmZTaE55N2VSQUNKUnVBd3djbzN6?=
 =?utf-8?B?bnMzU2hwVUwweGQ0TmlCUExLTDZmRXh0SFh2WE1RSENTeGVxQVc4bEhmWHVC?=
 =?utf-8?B?V05UUlFOa2t3TkhOUkZDNlQzeklXVmdRUGk3K2RxTjNJSzNuMjduVFR5aHBK?=
 =?utf-8?B?cWNpT0dIamt0T0RBZzl2TXRnMVlaMnRGZmd6Y2pKR0lwQWN2ZytTY2hWbERS?=
 =?utf-8?B?VWd0WGpJN3JQZHA2NjhOU0tTRHVyY05LeXVNeHBuVXB6R21ybTdYaE1KK3ZZ?=
 =?utf-8?B?VElvZ2pmeEFxM0Jia2N5UmJLdThxUnJEanRvSVQ4VHJ4YTBTVTBPUFBIWlUz?=
 =?utf-8?B?MGdNTFdzMXV5K2hYbzA3N3pZTnpYQk45TENTNy9BR2hCbGlETGpMZFNsbHBB?=
 =?utf-8?B?TTdUWGpxSEpEMUdkS2kxUmorVjZDeHF1eUl6bEFreEhCVnBWVDRhUmFnbTlu?=
 =?utf-8?B?TmhSSHVrczZEVXJrczNqaVpXdlNmMHgzSzh5Y2Q3K1gxemRkZ2Vxb0hCaWQr?=
 =?utf-8?B?TmhlczRIaWJmUGJlQXptMnoxc09mOGtQSkpKS21XMm0vRHlObmx4WFFVbWpa?=
 =?utf-8?B?L3phbTYvYVd4ejMyUnZ4ZFRMbTdrREFrMHErOC81ZlJ1clJKWXNoTWt5SVBp?=
 =?utf-8?B?aFd6RFBnOG1LUGM5eWJ4TEZSWjR6eGFhM2pGck5QWVJDRHpodXJ4WXlOUkNN?=
 =?utf-8?B?VEh3Sm5HWVVRRjlreDZrZ1JKTitROTRMRmgxVG4xSU9EbFhsR1NIUmFHbmM2?=
 =?utf-8?B?TVdlWWg2VE9PbXJKTm85WFR2TXBucGdOSE9scllwYytnR2RvWmFJckNoaGlH?=
 =?utf-8?B?eFd4OXVveHFjOWRibDdaKzNEcmN1OFpwbG5tNFpneUVsVVY5Q2xMTEFNaVpY?=
 =?utf-8?B?NTV6QnI2c0UvV3BUSzQ0MmdYZUpsSWdWbC9ZQ3pJREtKbENES1g1S3F5YjB3?=
 =?utf-8?B?QkpVRG1wSUt2TFQwYTI3N2JiZGExZXFvZ1hhWkc1RGs1SGROaXZDbXdEaEU5?=
 =?utf-8?B?eUppZHJYRjJzUXE4WkI0cnpwSlJISzZuMGpzdTgzck1ZcXdBc2pNam9NVXQ2?=
 =?utf-8?B?eU5oYmxEb0o3YzNNb3FKRnR3ZXF5Z2o1OW5Mb0o1SUhFZmNORlJIUnFhLzVY?=
 =?utf-8?B?RWJ3MW9hdk1VOEliMUNvM1loVFlwRXpBRlFWZzRMUk1JRzhLWThNVmRmdVRl?=
 =?utf-8?B?aThiMXUwT1hiV2QrRjJwN1V4Y1FoWlVQQlkrMlVyUW5sMEJES3JMMEJuVVha?=
 =?utf-8?B?eVUzRGRRS1QrVkxldGs0eWVpR3RJM1c3WGhzbnR2SHpDNzYvR3EwNkc4MWlT?=
 =?utf-8?B?NDZ3Y1hGbVlxVHg0eDJNTTdnQWZ5MEp3Mmh1eU5kNEptVys0WDQvcmJEa1VV?=
 =?utf-8?B?aUQ4R0YwZTZGS0pldWxuVHgwbEIrMjQ3cW9hSjBiK1NkRTk5Uzd0WUNIN3FS?=
 =?utf-8?B?d3JCb3dDSHI4bXhWbWRkanJEWDJ4VitvSzFSM0g2SWhVRmlNMmxPV1h4Ykli?=
 =?utf-8?B?V2x6OXpUa1ZSakZteWh3NGNlL3Evc1pkL1Q2TzB3NHJOdW9KdmtKc1V1aGhP?=
 =?utf-8?B?VFlVaS9EL3ZGOHpNb0xWMUhEelFKVWlMQVUvQW44SzJkbHZmc0NCZ2Mzdk1v?=
 =?utf-8?B?a284VEJJN1BReDh1Yi9ac2NRTXptWFp6ajAvOHZ2UG1Dait5eTlHbllVLzd1?=
 =?utf-8?B?RVk1OHVXVk93bTJkeVpWdkRIa0E4UnREL1RKQ1NwcnJjRHlBc0hTUm1KUERh?=
 =?utf-8?B?cFRsR0dyem5SYUk2eXRxR3h1d0ZTM3dURm8xQkVpMDllWUIyUVVnbHZNSXJj?=
 =?utf-8?B?ZmNrUWdNMHBEWFIyQVE4VDZPamZGc0xyU05IaUswaXZ5Smtnc2dLSHQ4VnFP?=
 =?utf-8?B?WXpkZnpZTE5UUnRHMDk4a1NObVQ2aTFBNE9ReTlpb0F5YjdWd0tzMHhLNTZy?=
 =?utf-8?B?T2k4UTBoYVA5d3ZtK21nSnFLdHVIMXBCbmlON0FzaUMya1hMUm4yeGFXSW9h?=
 =?utf-8?B?cFYxQWx1cXlhbmR1dndTVFRyUXA4MS9VZnk0djc2eXIwdVdPV0Zmdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7A809AC37AF947449C1AC2A773616309@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	S2p1MMBthZtUx9daJLxQ5TOuIKQ6qUfPi3YdZxgLnlV1a2pbJCi3tO+yszCO7AMvHw8MyAepPw/iCW4g3/V+/ql3JOP11M58W6kjj0T3rp0ML5s3KxFmWHWMVQSL8IBB8+iuhZbcQ4mfyYibNxWD3yuZho3hNbAJfqTYF4xaT+WnghPmtYWwp6Dm9D5yoT+15GmVAhVwBXattMnPNrkjakgLBhC3yC7FyeLPHm50icC31jHVpcY0B4NXTHCT1FJ3EpeFSm9cdFIaKnBcog1JuUSDTJnNOeKN7XIGjNwIGkua5f2tKOXdMkc6VatfK++/gLQ/+UK3xz5Pla90fCNtJYN0kqYdhryMRkT5odD75J3GZHWCHkGpLBaQZEEWWguLCb3ByoSc3Gs6uSzVyoJ062Q6myaTCDKZCbYoiHU3ivzf4ln92i5CFyy2KuCo4+38Ig9eHPz/u4AdwRrZK7IcV3SUztPMIuHsCOB3V4AnHN85+qSh9D2UKGIdpl5Btbb4W+bSJoHxuFVAn2/IWbGwD8DJFE4rbWrFjwhyI9feUMfXR8c6wN/Nh8BjkGNu2smx5asUhg78FYnhxtSZNE5b9o9oYFpYMkwW2mTR+5rz/ojb3WMLCObt5i9qjbqh1klm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR04MB8755.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f2031c-4eb0-4857-ee63-08de705e6a87
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 08:59:54.8474
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1HtntWKsaTZcs+/48DK0v4Vf5d1TZ3LX2FFFYqUbTSYgOREdi4XVUqZfLEDCFSShXMJsUd2v7fazPzXHt5Dk0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR04MB9556
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77769-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Hans.Holmberg@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 25593165F9B
X-Rspamd-Action: no action

T24gMTgvMDIvMjAyNiAxNjozMSwgVGhlb2RvcmUgVHNvIHdyb3RlOg0KPiBJIHRoaW5rIHRoaXMg
aXMgZGVmaW5pdGVseSBhbiBpbnRlcmVzdGluZyB0b3BpYy4gIE9uZSB0aGluZyB0aGF0IEkNCj4g
dGhpbmsgd2Ugc2hvdWxkIGNvbnNpZGVyIGlzIHJlcXVpcmVtZW50cyAob3IgZmVhdHVyZSByZXF1
ZXN0cywgaWYNCj4gd2UncmUgdGFsa2luZyBhYm91dCBhbiBleGlzdGluZyBjb2RlIGJhc2UpIHRv
IG1ha2UgaXQgZWFzaWVyIHRvIHJ1bg0KPiBwZXJmb3JtYW5jZSB0ZXN0aW5nLg0KPiANCj4gQSkg
U2VwYXJhdGUgb3V0IHRoZSBidWlsZGluZyBvZiB0aGUgYmVuY2hhbXJrcyBmcm9tIHRoZSBydW5u
aW5nIG9mDQo+ICAgICBzYWlkIGJlbmNobWFya3MuICBNeSBwYXR0ZXJuIGlzIHRvIGJ1aWxkIGEg
dGVzdCBhcHBsaWFuY2Ugd2hpY2gNCj4gICAgIGNhbiBiZSB1cGxvYWRlZCB0byB0aGUgc3lzdGVt
IHVuZGVyIHRlc3QgKFNVVCkgd2hpY2ggaGFzIGFsbCBvZg0KPiAgICAgdGhlIG5lY2Vzc2FyeSBk
ZXBlbmRlbmNpZXMgdGhhdCBtaWdodCBiZSB1c2VkIChlLmcuLCBmaW8sIGRiZW5jaCwNCj4gICAg
IGV0Yy4pIHByZWNvbXBpbGVkLiAgVGhlIFNVVCBtaWdodCBiZSBhIFZNLCBvciBhIGRldmljZSB3
aGVyZQ0KPiAgICAgcnVubmluZyBhIGNvbXBpbGVyIGlzIHByb2hpYml0ZWQgYnkgc2VjdXJpdHkg
cG9saWN5IChlLmcuLCBhDQo+ICAgICBtYWNoaW5lIGluIGEgZGF0YSBjZW50ZXIpLCBvciBhIGRl
dmljZSB3aGljaCBkb2Vzbid0IGhhdmUgYQ0KPiAgICAgY29tcGlsZXIgaW5zdGFsbGVkLCBhbmQv
b3Igd2hlcmUgcnVubmluZyB0aGUgY29tcGlsZXIgd291bGQgYmUNCj4gICAgIHNsb3cgYW5kIHBh
aW5mdWwgKGUuZy4sIGFuIEFuZHJvaWQgZGV2aWNlKS4NCj4gDQo+IEIpIFNlcGFyYXRlIG91dCBm
ZXRjaGluZyB0aGUgYmVuY2htYXJrIGNvbXBvbmVudHMgZnJvbSB0aGUgYnVpbGRpbmcuDQo+ICAg
IFRoaXMgbWlnaHQgYmUgYmVjYXVzZSBhbiBlbnRlcnByaXNlIG1pZ2h0IGhhdmUgbG9jYWwgY2hh
bmdlcywgc28NCj4gICAgdGhleSB3YW50IHRvIHVzZSBhIHZlcnNpb24gb2YgdGhlc2UgdG9vbHMg
ZnJvbSBhIGxvY2FsIHJlcG8uICBJdA0KPiAgICBhbHNvIGNvdWxkIGJlIHRoYXQgc2VjdXJpdHkg
cG9saWN5IHByb2hpYml0cyBkb3dubG9hZGluZyBzb2Z0d2FyZQ0KPiAgICBmcm9tIHRoZSBuZXR3
b3JrIGluIGFuIGF1dG9tYXRlZCBwcm9jZXNzLCBhbmQgdGhlcmUgaXMgYQ0KPiAgICByZXF1aXJl
bWVudCB0aGF0IGFueSBzb2Z0YXJlIHRvIGJlIGJ1aWx0IGluIHRoZSBidWlsZCBlbnZpcm9ubWVu
dA0KPiAgICBoYXMgdG8gcmV2aWV3ZWQgYnkgb25lIG9yIG1vcmUgaHVtYW4gYmVpbmdzLg0KPiAN
Cj4gQykgQSBtb2R1bGFyIHdheSBvZiBzdG9yaW5nIHRoZSByZXN1bHRzLiAgSSBsaWtlIHRvIHJ1
biBteSBmaWxlIHN5c3RlbQ0KPiAgICB0ZXN0cyBpbiBhIFZNLCB3aGljaCBpcyBkZWxldGVkIGFz
IHNvb24gYXMgdGhlIHRlc3QgcnVuIGlzDQo+ICAgIGNvbXBsZXRlZC4gIFRoaXMgc2lnbmlmaWNh
bnRseSByZWR1Y2VzIHRoZSBjb3N0IHNpbmNlIHRoZSBjb3N0IG9mDQo+ICAgIHRoZSBWTSBpcyBv
bmx5IHBhaWQgd2hlbiBhIHRlc3QgaXMgYWN0aXZlLiAgQnV0IHRoYXQgbWVhbnMgdGhhdCB0aGUN
Cj4gICAgcGVyZm9ybWFuY2UgcnVucyBzaG91bGQgbm90IGJlIGFzc3VtZWQgdG8gYmUgc3RvcmVk
IG9uIHRoZSBsb2NhbA0KPiAgICBmaWxlIHN5c3RlbSB3aGVyZSB0aGUgYmVuY2htYXJrcyBhcmUg
cnVuLCBidXQgaW5zdGVhZCwgdGhlIHJlc3VsdHMNCj4gICAgc2hvdWxkIGlkZWFsbHkgYmUgc3Rv
cmVkIGluIHNvbWUga2luZCBvZiBmbGF0IGZpbGUgKGFsYSBKdW5pdCBhbmQNCj4gICAgS3VuaXQg
ZmlsZXMpIHdoaWNoIGNhbiB0aGVuIGJlIGNvbGxhdGVkIGluIHNvbWUga2luZCBvZiBjZW50cmFs
aXplZA0KPiAgICBzdG9yZS4NCg0KDQpZZWFoLCBJIHRoaW5rIHNwbGl0dGluZyB0aGluZ3MgdXAg
aW4gbW9kdWxlcy9wYXJ0cyB3b3VsZCBiZSByZWFsbHkNCmJlbmVmaWNpYWwuDQoNCkp1c3QgbGlr
ZSBibGt0ZXN0cyBhbmQgZnN0ZXN0cyBtYWlubHkgZm9jdXMgb24gcHJvdmlkaW5nIGdvb2QgdGVz
dHMNCih3aXRoIHdlbGwgZGVmaW5lZCB3YXlzIGZvciBzdGFydGluZyB0ZXN0IHJ1bnMgYW5kIHBy
b3ZpZGluZyByZXN1bHRzKSwNCndlIGNvdWxkIGhhdmUgYSBtb2R1bGUgb3IgYSBwcm9qZWN0IHRo
YXQganVzdCBkZWZpbmVzIGEgYnVuY2ggb2YgdXNlZnVsDQp3b3JrbG9hZHMuDQoNClNldHRpbmcg
dXAgYmVuY2htYXJraW5nIHJ1bnMgYW5kIGFuYWx5emluZyAmIHByZXNlbnRpbmcgcmVzdWx0cyBj
b3VsZA0KYmUgZG9uZSBieSBvdGhlciBtb2R1bGVzIGFzIHRoZXJlJ2xsIGJlIGRpZmZlcmVudCBw
cmVmZXJlbmNlcyBhbmQgbmVlZHMNCmZvciB0aG9zZSwgZGVwZW5kaW5nIG9uIHVzZSBjYXNlLCBj
aS1zeXN0ZW0gZXRjLg0KDQoNCj4gDQo+IEQpIEEgc3RhbmRhcmRpemVkIHdheSBvZiBzcGVjaWZ5
aW5nIHRoZSBoYXJkd2FyZSBjb25maWd1cmF0aW9uIG9mIHRoZQ0KPiAgICBTVVQuICBUaGlzIG1p
Z2h0IGluY2x1ZGUgdXNpbmcgVk0ncyBob3N0ZWQgYXQgYSBoeXBlcnNjYWxlIGJlY2F1c2UNCj4g
ICAgb2YgdGhlIGNvc3QgYWR2YW50YWdlLCBhbmQgYmVjYXVzZSB2ZXJ5IG9mdGVuLCB0aGUgc29m
dGFyZSBkZWZpbmVkDQo+ICAgIHN0b3JhZ2UgaW4gY2xvdWQgVk0ncyBkb24ndCBuZWNlc3Nhcmls
eSBhY3QgbGlrZSB0cmFkaXRpb25hbCBIREQncw0KPiAgICBvciBmbGFzaCBkZXZpY2VzLikNCj4g
DQo+IEknbGwgbm90ZSB0aGF0IG9uZSBvZiB0aGUgY29uY2VybnMgb2YgcnVubmluZyBwZXJmb3Jt
YW5jZSB0ZXN0cyB1c2luZw0KPiBhIFZNIGlzIHRoZSBub2lzeSBuZWlnaGJvciBwcm9ibGVtLiAg
VGhhdCBpcywgd2hhdCBpZiB0aGUgYmVoYXZpb3Igb2YNCj4gb3RoZXIgVk0ncyBvbiB0aGUgaG9z
dCBhZmZlY3RzIHRoZSBwZXJmb3JtYW5jZSBvZiB0aGUgdGVzdCBWTT8gIFRoaXMNCj4gbWF5IHZh
cnkgZGVwZW5kaW5nIG9uIHdoZXRoZXIgQ1BVIG9yIG1lbW9yeSBpcyBzdWJqZWN0IHRvDQo+IG92
ZXJwcm92aXNpb25pbmcgKHdoaWNoIG1heSB2YXJ5IGRlcGVuZGluZyBvbiB0aGUgVk0gdHlwZSku
ICBUaGVyZSBhcmUNCj4gYWxzbyBWTSB0eXBlcyB3aGVyZSBhbGwgb2YgdGhlIHJlc291cmNlcyBh
cmUgZGVkaWNhdGVkIHRvIGEgc2luZ2xlIFZNLg0KPiANCj4gT25lIHRoaW5nIHRoYXQgd291bGQg
YmUgdXNlZnVsIHdvdWxkIGJlIHRvIGhhdmUgcGVvcGxlIHJ1bm5pbmcNCj4gYmVuY2htYXJrcyB0
byBydW4gdGhlIGV4YWN0IHNhbWUgY29uZmlndXJhdGlvbiAoa2VybmVsIHZlcnNpb24sDQo+IGJl
bmNobWFyayBzb2Z0d2FyZSB2ZXJzaW9ucywgZXRjLikgbXVsdGlwbGUgdGltZXMgYXQgZGlmZmVy
ZW50IHRpbWVzDQo+IG9uIHRoZSBzYW1lIFZNIHR5cGUsIHNvIHRoZSB2YXJpYWJpbGl0eSBvZiB0
aGUgYmVuY2htYXJrIHJlc3VsdHMgY2FuDQo+IGJlIG1lYXN1cmVkLg0KPiANCj4gWWVzLCB0aGlz
IGlzIGEgYml0IG1vcmUgd29yaywgYnV0IHRoZSBiZW5lZml0cyBvZiB1c2luZyBWTSdzLCB3aGVy
ZQ0KPiB5b3UgZG9uJ3QgaGF2ZSB0byBtYWludGFpbiBoYXJkd2FyZSwgYW5kIGRlYWwgd2l0aCBo
YXJkIGRyaXZlDQo+IGZhaWxpbmdzLCBldGMuLCBtZWFucyB0aGF0IHNvbWUgcGVvcGxlIG1pZ2h0
IGZpbmQgdGhlIGNvc3QvYmVuZWZpdHMNCj4gdHJhZGVvZmZzIHRvIGJlIGFwcGVhbGluZy4NCj4g
DQo+IENoZWVycywNCj4gDQo+IAkJCQkJLSBUZWQNCj4gDQo+IA0KDQo=

