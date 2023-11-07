Return-Path: <linux-fsdevel+bounces-2266-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75C5E7E432D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 16:17:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23D51C20D30
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Nov 2023 15:17:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E0BB31595;
	Tue,  7 Nov 2023 15:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="e8AaogmS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="rvJuhInc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46688DF72;
	Tue,  7 Nov 2023 15:16:54 +0000 (UTC)
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEC891FD34;
	Tue,  7 Nov 2023 07:16:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699370213; x=1730906213;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=t3nXoBbZa32Vb3OVTbF4gUgz4IyWqyS75WYSsGkuaOo=;
  b=e8AaogmS+kTftnT3upBPurUX3LAiIZJIEm7tkNDbT/dNjXjOmwIwGPzL
   pCT1hPi6GNpM6vvMLlcmTz/Xtm9Np/ODQIQvB3IUsufdq9D48YfDBqR2n
   qsgaA58j9C6/R47DSYJzHA788QmOD/k4py/y4h7kdZ+DOqc1iZp1wM/wx
   9J/wv10JqejvwBtgY/A4U68FzaxVfoQ8joq+TSKWOxZWx8cRUYQoMtvnm
   uGcce4aw0Vyg9XN69JHUj7sjK05CTCbeI7MGv59c9QY4RN4lzHu2zrHEq
   Df6cVtZLwWAn9W1uMhK5e8rVsVJ7OcZtNeWuUEsYMKXXZw5oO294Y766p
   Q==;
X-CSE-ConnectionGUID: GJ1H+3pjSOyTvkQli1oUCA==
X-CSE-MsgGUID: C8ZjgyA7QeuRrnlc6z40+Q==
X-IronPort-AV: E=Sophos;i="6.03,284,1694707200"; 
   d="scan'208";a="1678900"
Received: from mail-dm6nam12lp2169.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.169])
  by ob1.hgst.iphmx.com with ESMTP; 07 Nov 2023 23:16:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=joryYLzjD5OYzVnPllfY0nZKYwfB2i5xG1pTDNXbUuGHrFvc7xYUcFVedlLyb+tlucsIS+puxSyS02ZGK6VFUueDXHt9L0rbLt/SqZ85Zl5pT5KeRzlRQwCaB7oO2GqtexzqatieaSVKX8pIe8owXkB0kAmKibVEOl6QeIJYlddjaTiGDmbkZMADBZV7IGXTlvCU6biwrlUTn1O7Y7CDftqRuAmx0ACEmegHDtn+MDqvtpIV/KNAKIJ0mSBAK397jy9Rq/32vvcZZka7d8k2jHITN5GBOa/8RIyz5ZrpYN2RSQS/zajZNPjnaSymwQue4TbfRMJcxyq31tdunc8Caw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t3nXoBbZa32Vb3OVTbF4gUgz4IyWqyS75WYSsGkuaOo=;
 b=A0wARsxBH8d5NJ9037BHsXiuMWjTN6xgCrpcN2vWDhISyWIgx6chP716oz5AkMtHdPsXAXEfvspWno9ZUKDW1tyCku2QAaqHIz/39prQu/Mqvd1F1hBA97HtLawZ65cxvkJJmH/c4K70+ZTtQrbJ+5cp/4w8irWbk0oLVXeTTzd+5QLaKwruKH2YoP2+BrDprM6imMQJVAZ6cJdx5KdxYJjNejpC8nfH1Bt41Xw9jrbY2eDGYVyPHsFMZWAtw39hInOsUE0ewQBfNiVL9p7M5de9foSRt55VASatI37w6b+kH8IhIVLoxyrIsFFniKPpt5PzZtzXzrNqKmEapiNhDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t3nXoBbZa32Vb3OVTbF4gUgz4IyWqyS75WYSsGkuaOo=;
 b=rvJuhInc6DrRGTDD9UzecKNX39XcME8qiTk9IOl+9mxlLe826VTzVtOCnW6L6Lo838UKMzBxYUeLrels3MOHp/1N/wVm/YJPZyr24I6prNB1OlOETJ/ttBogQusqTZRL9BLPoMMYIBVj+YgX5AGarflli4sc0cGf2058hxvnhh4=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN8PR04MB6435.namprd04.prod.outlook.com (2603:10b6:408:79::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6954.29; Tue, 7 Nov
 2023 15:16:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d52c:c128:1dea:63d7]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d52c:c128:1dea:63d7%4]) with mapi id 15.20.6954.029; Tue, 7 Nov 2023
 15:16:50 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH 06/18] btrfs: split out ro->rw and rw->ro helpers into
 their own functions
Thread-Topic: [PATCH 06/18] btrfs: split out ro->rw and rw->ro helpers into
 their own functions
Thread-Index: AQHaEP3ZC94OaOLEP0CuvSGdS9wlzLBu+OAA
Date: Tue, 7 Nov 2023 15:16:50 +0000
Message-ID: <1a5369c6-24e0-45dd-a867-5844e8171fb9@wdc.com>
References: <cover.1699308010.git.josef@toxicpanda.com>
 <bb944da42fc7d01832f72495ec07f9a82a133376.1699308010.git.josef@toxicpanda.com>
In-Reply-To:
 <bb944da42fc7d01832f72495ec07f9a82a133376.1699308010.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN8PR04MB6435:EE_
x-ms-office365-filtering-correlation-id: a835fb8d-bf70-45b6-5243-08dbdfa49128
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 k4CG8dPxCg6RJh6bnYZJyY5jyM4MY3fmqTcEOP5MDZYWlaCDFWH42g0f6pgrBCyDSavTtMK3K88Fv5dBNcegacg9RujDj78WPRdWffBDPtRXXDZhr/2BDkfkpH+82sff7MGFgNaLLL5goabPM4bcBYRQ1z/F7AMZN+uIjZTq5uB30QI+nDICmAA+Pr/Q+NO3xwSK6TUGlPYqgQzjQ6VuXlT/XzrK4R8dgrqCxh/sZBgBz12sMjKIRHFT67V7t4AeU057eGDTd6fPppOxNoYLmudW16QXN0mIWKavkTipsEQ+DBEhjAdcHdGRrSIc+CprR1I/HBltb//EJGlyfxdXZ4mlcuaoVxevCtkP0AJk6+eN1ZDTxEpUoykpP1LRiCOdof29y5oXloEWPLJ3YxVW20+VXOFY7s1yrdjcyWJuG7n8PBA3kUJjgZJq4CEk56p+2n7Cin2lxwVjFj7IKwhaL+4Wi1guPD9gyOayFUVJqaNwj5CXhOHMXRjuJK/iSWraCDp4d1MWdeufm2z/EEzysT5m18D5e5qSoG17uEG/+tt5I87t6P45PmTiMRsEzV2KoLqzt4qVSoHePs6fPUiB5avcN3hNhdg4YdSQDaLMVnLY6SrNYQdhznf6fkaIYMdzoP7sWCcwGffnUGt7AQiFPNhUx2Cf2wppASDsSj5RbjL5nnVlz50QkqPKUcddPX2U
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(39860400002)(366004)(376002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(83380400001)(31686004)(6512007)(2616005)(6506007)(53546011)(478600001)(6486002)(4744005)(36756003)(64756008)(2906002)(66476007)(316002)(66946007)(66556008)(76116006)(110136005)(66446008)(91956017)(31696002)(5660300002)(122000001)(86362001)(41300700001)(38100700002)(8936002)(8676002)(71200400001)(38070700009)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?RlNDWHVobTFzazZxb3hjb1hRekFIWGYrME9BZndvL3VTaHpsMGxCQjk2Mk9P?=
 =?utf-8?B?WjNoa1FITlpnQUhBVFdLQld4cVQvRVh6OWIvMkxMbHlzS0tQMk9uNlBGZlpI?=
 =?utf-8?B?MXVqMTh4bTFjeXNyWktJQk1tVUE3U1pWUnlPZjVtdHVNRndKNW96OURUallE?=
 =?utf-8?B?UDNsclZRejNiOStMUGF0dUJiSzJUNHlpYTZWTHdjN01Jd2NaN1Q3NVB4NktK?=
 =?utf-8?B?ZGoxZVJMejBKRTZlTytrTjYvcWdEMENCK0toTDNnWUt2SG94NmxYNUVsK3pZ?=
 =?utf-8?B?aEtJVTJTOElxTlJGN1M2UDZydXdiSDlhS0ZQbEpRbnhJRExPVFgvNW5Ta0dD?=
 =?utf-8?B?Qjc2OWI1bnNNQThnTnJ5WXduNUs4TUd0d1dNbkF3eDBuRU5zQWlOUWFmSHNq?=
 =?utf-8?B?TmFTcHZZaVl3YmVGNE1ZODNaRHpoaTBRSWZ6bUhZR0x6cnQzK2Q2WnlqMGlR?=
 =?utf-8?B?S3ZGVWdUWHpBUnVaL3NQc2gzR1l2cWpDRG4wdXhXYVhXKzZuVlQwZkdibTlo?=
 =?utf-8?B?cnM5QnZwM1dTb0dBdTZ6b0E3Q3g1d1ppdjg0Z0h6VTJZVXdWNHRhL1pWcjMx?=
 =?utf-8?B?RGxBcjZseWdsVlJsdG4rL3dQa3M1UHRGNlBJd0FjNEc4NzdWUWRBMk5IM0ox?=
 =?utf-8?B?Y1pFN2xleGc1U01zdjYxc3dHdmtlNUhUeDREZXlFWlVrVUxjK1JEbjhNWUNq?=
 =?utf-8?B?YkZnRUZkaVNGNDJjMjYvZjNvVmx1eHE3d21ObExZeXdLV2pQUERhcWhUUnZK?=
 =?utf-8?B?WkNkako5VlNyVGU0anFjbXRtTW91eDlVc3Bld3BZODhVelBRdEgxUTAvMTdz?=
 =?utf-8?B?bEUwbUJmVDFRNDVBWnNOYnJRZWEvNkhZQm1UeFBIQ0F1My9jbzVzeDQyamdl?=
 =?utf-8?B?OXdYbU9LcGNnTUJKNmwzYWxBWHJQRUF5MkNISXRqc25TMkhaZnY2RGl2Uk9r?=
 =?utf-8?B?THJnbExHcFcvRk4zZDgyWEZGMWhqdnUxRmVyT0s2WmhBUEtOai9XTWZPUmpr?=
 =?utf-8?B?MFhFdEpodHZORjhESU0rK1NyNmlyWkF4MzE3cUxzQ0g5ZndkS0c2a204Vjlu?=
 =?utf-8?B?d3A5cUxtMGJUK0hQTGhicFZ4MVY4QitieFBsaWlBZ3hxUTM0SzB4VFNuZm5K?=
 =?utf-8?B?NDdlL0R4RFdUMUorcTJMUlF0NWw1R0pBNlQwclY5NFRac0haM0EyR1drSktT?=
 =?utf-8?B?QjFWQ0piczEzT0thU20rZTY3VHJ4TWEvU3pldDRBNEYxR1I2V2l2RkdiVTly?=
 =?utf-8?B?QkhJeDYzSDZmRW5hTi9FS3VaS1I5ak9RZ04yY25BbGE2SDFNdk9kWWp6YkhW?=
 =?utf-8?B?cDNjczBoWEZMbEVJSEs1bExJb1RPYmdESHphR3NmakN1MGV2ZThOUEgydlRz?=
 =?utf-8?B?OEZqRDNVeTkxZTF3cjlTMWREalZSVk9EejVic0xjTzJkOFIvNURkaEcydmVB?=
 =?utf-8?B?TlVBTTBTUG9tVzRJNzY2c2dFcEJFVURwditTMmVLdWtNNkJRWGtYY0wrdUUw?=
 =?utf-8?B?SGJMTzhMakJNWXZlZloyRkRyV1ZhcXFjZHJDMHlNZXMzQlBETnpPdEJHVGQx?=
 =?utf-8?B?L1o5UHZtazVaTHNlL3VHYmhJZmpSMFNOdHJ1OXlERmF0UkpITTE3ZjlwUXMv?=
 =?utf-8?B?M0JuZEVZcncxNFY2cmNaMDJzbkRPZTJjcFNmTEpiZGZXMTZVNFl3bkhSZ3Z3?=
 =?utf-8?B?bGdQeGRyczFST3QrUitkM0Zia2J3bHQ5TW1WSTZWaCtWdWxrZ3lHblJwTTJM?=
 =?utf-8?B?MTFlRzAwK3RlNG1ManloZ05Pb1Z2Wk05Q2RUdUxXWEFJdnV6L2lYYkt0Qnhj?=
 =?utf-8?B?eVZkaWpuU3VUd0VCWDVhMkpKRHQzVXVuL3VWeGNuNzZ0YkpzUmlPREh5dlFv?=
 =?utf-8?B?UUx2QlFCRStsaEd5eEYzMEU5QWFqS1NjcDZhQmhqOUplOVNaR1lsa3Y2V0VL?=
 =?utf-8?B?aWxzRWtMbHFTcHg2L0FlT2oxMDFMTXFzK3NQaFVFSk1pK3ZMdGZ5N3lDc1BQ?=
 =?utf-8?B?VFdWME5nSktBMVk0Tkw4NS91bUtwYlZtd0dYU1F2Y2JDU2VXVFpTTzk1RmpZ?=
 =?utf-8?B?VlVGRHFXRlFDTHRqUjhpK1VjWUp1YXRpNzRFbXU2N3pwNXNuZmlzZ09MTTBv?=
 =?utf-8?B?VU43cjczSkREQzB3RDMrdFpRZzZJam5oUHpwbWRHMkt6ZEo0VFltUEUzR3dr?=
 =?utf-8?B?WTAzVkFWczdVNUtxS0djL1hBM0svcDJJV2xtUGRPOUhuenlSc3BCTWE4RXNN?=
 =?utf-8?B?TG4weTlwd0dvZHNmNlZFMFZrMWFnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3BF0707F87E18649960DE5D128A9C527@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DtP9RHhiMp69wH6rDYaPohmSlJUlOeTF+lJnLo9CYtzqI/mPqCosz6qvPGIMM19mEGMF+umzWYuwxVZWPp5aMou8gv67AXhbr8XPAZ9v77Dam2C5BUzpY//i1vmW/ckT7wzpQ7xPobEqcP8PElJBNmCkYrgdxfeYD/8xXaBj/HOCMtT6uq/uBtDBlM8CivlR5a+6P5ulypqInBuGI+3cjESxIdd/PymjrBte3VyhViQa72Lfmul173/9ee/dwEjSu/OYjHV1nKO1TMsHXR23hzo1Qc+InKNFv+RQZpiV0CQvLkRRgmu1OkIxQ/sFTffTC1YA3/Lqii8epm6AJQPmd6nKez55TPpmgqWz3YBRP46lVWeW6tW4sN3/Z7ZRrZIgetM9QB5PQEhLIje0308uL67IhO+7COcjIULqkbQARMXmn72cvT7rINd16qYiURSQS8f3l/KnxECpSmsMA57Lt0N+KDmQGcQ0mTFBaW3aPD9gzYyJ4nRCOWKAZEiY9kaOS3RWidU5nlg6chF4TjQe/8mShkpMsTtBvjMentocO2Ef4IphLus+j56kEqT2lfb0FMUleP6W9NFMviPFWyYTwDIW7dwQIszUvGwWNdxtEqGJAVmWzHjcfAxTp3mrgq3oMI5rMS1DmcM05HIa9rdwOLslLFbFfTqVPTXJUrMp35ebNp+qoDPjv2XUKYrhoVYGX4qgCLx01MKctiiiyjkMT7HrnSk6ZWbeqBN5AEFdLTdSLe4LFDvf0OJ9F4/4/6ILI6Ex0L/gqrFyzEVYifNafH8G0qE0K6TUabynTeDlUQVJfKF6CtPKLWsVvDSuEccBXBI22f0MS7ONxQze0uCZQAb8DkgXlV8H3kChuB8Ci/IECZ1I+ZTKXL4acZCET8pC
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a835fb8d-bf70-45b6-5243-08dbdfa49128
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Nov 2023 15:16:50.5486
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mcObAVb5NMf9qCr2WMve2Wu1a8yuGScskRGep7ABR5jkjxjKogkS7LW9CoKld6o168oQphJfNjqyMYtcwSVXYzOoSkQ5Wf6Sk17ch8WTAJ4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6435

T24gMDYuMTEuMjMgMjM6MDksIEpvc2VmIEJhY2lrIHdyb3RlOg0KPiArCWlmIChidHJmc19zdXBl
cl9sb2dfcm9vdChmc19pbmZvLT5zdXBlcl9jb3B5KSAhPSAwKSB7DQo+ICsJCWJ0cmZzX3dhcm4o
ZnNfaW5mbywNCj4gKwkJCSAgICJtb3VudCByZXF1aXJlZCB0byByZXBsYXkgdHJlZS1sb2csIGNh
bm5vdCByZW1vdW50IHJlYWQtd3JpdGUiKTsNCj4gKwkJcmV0dXJuIC1FSU5WQUw7DQo+ICsJfQ0K
DQpJIGdldCB0aGF0IHRoaXMgaXMgb25seSBhIGNvcHkgb2YgdGhlIG9sZCBjb2RlLCBidXQgaWYg
eW91IGhhdmUgdG8gDQpyZS1zcGluIHRoZSBzZXJpZXM6DQoNCglyZXQgPSBidHJmc19zdXBlcl9s
b2dfcm9vdChmc19pbmZvLT5zdXBlcl9jb3B5KTsNCglpZiAocmV0KSB7DQoJCS8qIFsuLi5dICov
DQoJfQ0K

