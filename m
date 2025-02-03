Return-Path: <linux-fsdevel+bounces-40562-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B84CA25333
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 08:48:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A15EB162799
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Feb 2025 07:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A15B1EEA32;
	Mon,  3 Feb 2025 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="hb8klVbV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="RKIXo+Cf"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951041C695;
	Mon,  3 Feb 2025 07:48:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738568884; cv=fail; b=jOT+6Ih3Dsa7GbLx6b9otYgiSn1ffzRh8Ief8BLQ6P5ZVCpjlb3NYx+wntBG0PM1LadKoEetkiNeC7JFdh/2BjG26j4sFKA1NrqbDmnVBeXtWuj6jTfxigfNT5vfD4GdIFoOO6fjbKAg1nM2H6euThhDOinJ4IxdOgYSY/Gkv1o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738568884; c=relaxed/simple;
	bh=9LyfJP6int3ETFFCGY+riudZWk6aNxSCDMC7kd+wnv8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Vw1gsqVV2FY1L1Zvo40MpsGL/OrpV+Pk/pvUoetHA7SY0yb6nIe89gveEPYXuMm7S1ERXzK9/4bDayjzjxT/r88ycvMWDTJyfokiV5r8SiOzx6mEQ0dKOJSku7Zgw4dcdooQO1qZPOPjEwgHCx1Em+pKAdWfHDBFhi5goKQ+HUk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=hb8klVbV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=RKIXo+Cf; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738568883; x=1770104883;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9LyfJP6int3ETFFCGY+riudZWk6aNxSCDMC7kd+wnv8=;
  b=hb8klVbV/SRpOdFpYATHo04HBOEdpDGh0TGNPp0rkBjRPI26fUdv40sd
   twfc3gikWonsCr8Fj9prpfxZ4y7B0+bSAWVNerNlHvwGL96k8+N+w01ZP
   KEb8+/KH4uvHWHAyDtzuboaJGe81o1bG2PEKYJFQgZiStTTlWMvt1Kzhn
   uBgwuKXG+nrg8Bxx215syMTklq/jMYxeGJDIfgODAmCmsXKWTXeiIdzU9
   4Rv3Qc932luzRSslFXuth6I/+PqQ/v2c8RuGUgq+M4c4AtTaBHYaeRIpx
   uhw7ED3iFkeUKmr/pQVgV0+Q5qjJBwqkX1zP9e3fAI80p1QxEFd0PZNEb
   A==;
X-CSE-ConnectionGUID: uGh7cH+EQQiu15brbpWXRQ==
X-CSE-MsgGUID: djw7jrXIS5KkdROE9tyXUg==
X-IronPort-AV: E=Sophos;i="6.13,255,1732550400"; 
   d="scan'208";a="37417105"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.8])
  by ob1.hgst.iphmx.com with ESMTP; 03 Feb 2025 15:47:55 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q/2XREWg5dcHTb/PfStOD9JXF3cvPI1RAc70Gg0aDNXfkB2IFGWJAgzSIYS/JYGXxLrYknObaLYYtz5RoqlRuoQ7JY8OVwq0SXRt3Xk9ymjg8S8GJFMFeQUO2uxLNv28Frzo4j0QUADpBD6qXUyghjfgMHFoW6OfuA55TODyMXJ+Lh+eZO9r+RLMwjDQO2PmAtjZw8e7EG09y73PqVPkArwOFytB7WvpsszPyz3IDlokB5ECpiE8uKYKLhWTTTwbFTxgwnFNM6whMxfOeH4xyTyMCIXimufJLAuj7qCCfW3HWcuc8jqWN4Qi785q8nvJ3WLeBWJuuE4e4DyLRldm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LyfJP6int3ETFFCGY+riudZWk6aNxSCDMC7kd+wnv8=;
 b=A31EmY+EfjtsOyhZb8btRSGg6Ch9l+qhqkv6bGg5Xq06s/vZEPm59m6ry1vyWAGBNngPLmEvTcPHu/2UL7WE24zjjiUiChge5jAvfSFryEm6ajkqECnhZ4EvnIsGnUwksXoX1gaQzFsFBcR7SACRG4XZeExDjHqdCoVjzvHj4OPQD//1It89daZ+ef9ypH44hEuQZZMisttWTvvsgEhNAkbc+gwg8IASmY341rDaDNkXWhUekS1h/Kfq/283ouMWmqEMxRsYf6+T0GjFaTu5iPvjNk3x7u+sABaqSvcH2aciSBRG/Bt5AgDY4sXQjLN8yDBxdah2aVafxBvpFqEziA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9LyfJP6int3ETFFCGY+riudZWk6aNxSCDMC7kd+wnv8=;
 b=RKIXo+CfkGUTYJGR1mF3mTOk7PYkN2IrmxQ76Gv2c5hFOqjnbIz2vrR3l0VZurz1QbhjUBaVv/DRzTsGbRwyWLBbI92Z6yUditDKMYmWTNkvII6XPn+MRn/HrPKP+DPpI2u5xS9K6kjFqH0biznwSJPtbuXNRzlM/4TZMED1t68=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9584.namprd04.prod.outlook.com (2603:10b6:8:21f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.25; Mon, 3 Feb
 2025 07:47:53 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8398.021; Mon, 3 Feb 2025
 07:47:53 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Kanchan Joshi <joshi.k@samsung.com>, Theodore Ts'o <tytso@mit.edu>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	"josef@toxicpanda.com" <josef@toxicpanda.com>
Subject: Re: [LSF/MM/BPF TOPIC] File system checksum offload
Thread-Topic: [LSF/MM/BPF TOPIC] File system checksum offload
Thread-Index: AQHbcvi+bSfLLTFN0kKx3C8kxByMxbMvYKaAgAF8mwCABFyoAA==
Date: Mon, 3 Feb 2025 07:47:53 +0000
Message-ID: <b8790a76-fd4e-49b6-bc08-44e5c3bf348a@wdc.com>
References:
 <CGME20250130092400epcas5p1a3a9d899583e9502ed45fe500ae8a824@epcas5p1.samsung.com>
 <20250130091545.66573-1-joshi.k@samsung.com>
 <20250130142857.GB401886@mit.edu>
 <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
In-Reply-To: <97f402bc-4029-48d4-bd03-80af5b799d04@samsung.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9584:EE_
x-ms-office365-filtering-correlation-id: ee2eee7d-2ef9-408b-a195-08dd442710b7
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZndjdEUwcEV5U1h6Znc5eEtWUXg0ZG9pNGlyeUNPY2xVdjd4MzIvaUxVem9h?=
 =?utf-8?B?bkZTUFBCb1Z3MGxjY1RjdVVjK29RMmdveE9YY3RLSWlBOXY1R3g0ZGxwcnB2?=
 =?utf-8?B?bUdRVTJ0aGFYWGFGbFdZQ3hMZXU0Q01Db09SbDlZSE4ydzJXUk1OQnB6SU1p?=
 =?utf-8?B?Mm1jMXp3UlRQNjRkdHJrRllsTHNVRTBpN05RYzRUMXR2WGhZRWhIdkZ4WWtq?=
 =?utf-8?B?NjkxZm43ZXBxNVhMbUFHWEovN2hXdVBvYTdtRkVvVXBTZy96MVU5ci80OE5v?=
 =?utf-8?B?QTBiVTdKdnFXVXdSbm9BUE1ncUg5S1pIbUQ5VjFuM0U2YjN0c3NPNGMzYnJV?=
 =?utf-8?B?TmJFODEyeG1JL2Z5UlBGeHo0TU9SWWhVQUg1S1dHemZicyswaXV5SCtYOHEy?=
 =?utf-8?B?Skg1MU9tTG5Lb01SSE04OTRTK09TQ3IvMElsWHdKT0g2SE11dStGT3hEa2Fz?=
 =?utf-8?B?aDAwRVZLeDFsYk1OVE5oVERNaXpZazFvNmtNZGcrUzJyQmhKY0pGRW5nV1Ir?=
 =?utf-8?B?cnhIRE15eExxK1FnRnc3a1NBRWJUOW5hdzBjTWd6Wkwyc0JSaUgyQlZ3Rndi?=
 =?utf-8?B?ZDhmcCtFRU9NaFhkMFpZZGp1K2twbnl5Y0VnNkN0Um0vMGhxSnZlUGsva1V6?=
 =?utf-8?B?UFN6S2ZHZ1NWOWcvN0RZOWhnZ0Z0RThkUzdhSFhYVkJLdm5SVEREWUhtNlly?=
 =?utf-8?B?b3VwQXlWelRDWXk3OFBEZDNhMThRTTR6MlN2akMrWGZCbUhENmV1dUxEemZT?=
 =?utf-8?B?d2l2ZWZLQVFuSEFQRTVqRDZuZWwxZmNOb1pPaW9JbWZ6S3RQSGZzMHRML1Fr?=
 =?utf-8?B?VmVtRjRKNkI4Zjc5dll1NnFaZ01zczBkdUN5THR0alRuei9iMmUrVkNBSHJo?=
 =?utf-8?B?UGhmVTcrTFhPZk9TcHo0U0w1QnpOaGtYckcrWElHWlF3YVZhdnorakIrWFlB?=
 =?utf-8?B?SkVLbUhRWTVJQUQvOXlwbzFvVytWQTNRZUhmR1hTdDlQRnhBSmlEUzJ5VUlx?=
 =?utf-8?B?c2ZPSks1eXExT1lLY2NRTUdKeWx1bEdOc2tHRFU5cUFrenZHSkNGa2RNQ2pn?=
 =?utf-8?B?S0h5Vm1FR3NHNDRjbzV1SnR6RWUvTjRUSDlmeDNUc1pQbUFiN3crT3VJTVJU?=
 =?utf-8?B?RmsrWjRTb0ErYU5aazBWRFJoajhLVnFMUDQvVzQ5ZVFIcEx6UnFOUlVMRTl3?=
 =?utf-8?B?aEZMYjg0cnBCTmp3SytZdG9kQnZac0VOSDdLME0yb0NiRmcreWxiNzdxMGZB?=
 =?utf-8?B?RW9tVEZWYTJGWU5naVZ1M1kvUWZva2dxdHhTOXlqYUdkeDlJc0QvSmdNWDBq?=
 =?utf-8?B?YnIrV1Q0ejVMNzVZWjVlVkU5QmdrZXRyQkY4YXFYdVhxQTdGTlIyKzVUY2d5?=
 =?utf-8?B?N1ZzWFBTS1Y2Y0FuZm9FR290c3VIL2RURXVuanphQ01kYi9UMjh2Znh6Tisv?=
 =?utf-8?B?bVl5WERUaUFJbVhUREpsTmw2TzBldW9EYy9ROHJCZUR0M3lLa1hLMG5KM0xy?=
 =?utf-8?B?Y3hGNUlsNGt5NVFZeEJFVDVtS3hiMCszbzZrTWFhNUtITW81SW0xTTRWbi9O?=
 =?utf-8?B?T3dMK0tOVHJuMkx4UFVxS1pDUnBwTjZMZXlvMWV3QStCWWcwTXJrQ1dMV0NO?=
 =?utf-8?B?UVJrdWdTUFU0VlRwSzBnRmZibmw4TlhVUUFCMXp0M1drYWcremQ5ZVQxT0tp?=
 =?utf-8?B?RXZrckpUNTk3R3dMYzNzOFVyQys0bjFDdjNaZWIyYjN3bDI3cjh2eTdtV2hE?=
 =?utf-8?B?QWxlbldEYnZ0WVVEWGlSVzZDTGJIaGFpc1J6dm9rVGNvMCtHMmNNTWs5RFc1?=
 =?utf-8?B?VUFRNHk5b2Y0K3ZoKzhQS2pQTjBqYW9ZL0RVTXBXQ0d2QlFEMWVDa2ltVDhX?=
 =?utf-8?B?SWwyOFYraXhLQXBDOG5BYnZQdC94bVpHamFZV0E4RU01Q3gremNNZWgwYldG?=
 =?utf-8?Q?bsxPnPT8+T0sEIT3A2IFESyqsc4fe3pa?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?MGt3c1ZwdkdRZFBEdEVUZWU4S2hDb08wYXBWb1IwTlVBNDRWRE9LSkN2bHZS?=
 =?utf-8?B?UXhjQjVoY1lqWUppTzBHWWtrU2cvckNIUHNXWTVUL3lwRGJaLzNlVjJNSU9y?=
 =?utf-8?B?elNQMU5KWlpxS3Nya2tPdjdpanZCUzVKa0x3cmdtZkNSdWUxeGxhZkUyK0ov?=
 =?utf-8?B?UTUxTXluSlhLSFgvSXZuWWo2blYyMjBjUnpjdmJ3MVgxYXlyZUVJUlVUdUhM?=
 =?utf-8?B?akJ2TDlEZkk0RkMwdFNCY3BFcWNZeGlYcGtncXlWTGpidk9IRlRhV2pCemYx?=
 =?utf-8?B?L1dJcW1mVms0Q2x2SUFCbGtRZkFxSTNrK1lUZnBoOWtkL0FCMDF0TEVQeHQ4?=
 =?utf-8?B?WEZka2xBUWtxUjYzRVUvS2hLTFA1TDBjaEk4b3drUWtDZUxmeXk5aFFYTG1S?=
 =?utf-8?B?TTBSK2RXWCtQT0FXVXdHSWxwQVpQa3F0aWtwU2lWcFZVeFQ2TWwvWlErL1lh?=
 =?utf-8?B?N29qaTVPMGVGekN4MjlsKzRvQy81K1V0bVd2eVhEVEFHR3dnbTlJY2o3QzNU?=
 =?utf-8?B?bjNNMG1RdVB1MmpBOHlHU1Q0V2g1OXk0aGhpZFZsaG1ZdThqVjZPTGtCbGJG?=
 =?utf-8?B?Rzk5M0Q3QmI4NlVKeWtYbytWdTl6ajVzcGNZT1NQYVBVRWtraWt2YzF0RW5j?=
 =?utf-8?B?c3gxRGxEL0R6ZFhpcXd1YnlNYXpKN0I4UmxZUWQ0cFhxbUxMemxsU1JodWhr?=
 =?utf-8?B?eCtIRm1yYWVOYmJOSEovdEFGTlQ1TmRZMDAwdVh4Wm5wNWdiR0cwdy9FZjRQ?=
 =?utf-8?B?VVdsNk5ZaW1wYjh3bjBFczBPVHowMzRwQmJ6NEtpM2tOMVJLWmtIdmo2ZVdv?=
 =?utf-8?B?MGlrYnZaTlJvcTEwcVNRWFlKd0JkVzczcS9QNUVvUmtaME1mbjFvVFRybi8w?=
 =?utf-8?B?dThCNUQvelZqMGs1YlR1YzlTbENIMXdNM3RwM2FkMzY5cTV5TGpLM1ZzOWtV?=
 =?utf-8?B?aDBNZ2NUeThGL3pWZkpjMm9JbndlVzVhaktjOXhTRGQ5QTljRWFrd0NzUm5J?=
 =?utf-8?B?aFNtVXcwMlRwZS9EZjNaYk9jVm5NQ1JQZXgwTTA2UC9ueWZqMWQ1VjNNbEF1?=
 =?utf-8?B?K1NpMVFzZ0x1MkJHTlcyZUxhODUzUWVIWVBPdkVMRndqU3ByOGFKVllPaFo5?=
 =?utf-8?B?RmFVdEJuNW5jR00wa0M3SnhnS2hSMzkvNzczUVB1NVdpN1I2RTU4b0hMSWVW?=
 =?utf-8?B?M25PZjRNbndCTmZNSGljbjg5cGYrTytRN1hEUjVzZDBneHFEUi96NzJQYVNN?=
 =?utf-8?B?V3RjZi84aGg0aTNLYXVZUXhlaE1RK2RzWmdHVEx2eWhTbkR0UitYNmNJQ2tR?=
 =?utf-8?B?TFkrUmRoemJkTVFtRTNiQ0FWQllnVUtGV1gxYWIyV0MxSHZUaGlKaDgzd3Ay?=
 =?utf-8?B?L2lGNWwrckhtYUE2U29TQVkvZk03OU5LZFJKVCtiR3M0OCt3K0U2OWs2TUYw?=
 =?utf-8?B?bzRuK1RjQlU5SExhR1BiWmlGY0FQV2UrOEpBYm9SVVp5eHFqR3U2ajhNdmhz?=
 =?utf-8?B?SmRNZ3QvNWNFV3FKN3lWVTBnQ0s2M0FJTkw1RU0xM0VKYk45aWk5MVF2QnZy?=
 =?utf-8?B?Sm1Qdnh5OFB1THBJVjJuQmxnRXNZdUlwdy9iSndDb3ZSZjB1VG85aUJRbUpK?=
 =?utf-8?B?L3dNVktreWpQQi9UNUhSVUN2WGYvay9oZy9yVjhjSE13TzJDS3F0SkczS05x?=
 =?utf-8?B?UHQzWFVhd3Z0Y01ndER6cnVVMTh2ek8zcWVhY01Wd3VlUE5rb2pmNkU1RE9Y?=
 =?utf-8?B?dGprd0doOWMrQnpHRXRtZGdOR1FDL1BkSTlzZ2FMRzU0d3l2bTFhM0FscVNO?=
 =?utf-8?B?aVhPMDRSOTNOeFhDTW5mTWRlMVJXb2ZLaGlxc3FVS1F1UlZEWXNHRW1vZ2l6?=
 =?utf-8?B?OFlTR1hoZVlSdFlEVjE5RjRicmUvL3pUWmFIa0FPVjZxdDRpKzhwMlNuVEc1?=
 =?utf-8?B?UWMwd05MYUNwVjU4aXYxTCtKeFFrTUR3aWJRZmF2djdRZ2JXWVkvR0VETW5N?=
 =?utf-8?B?aXVndGoyZkhINHNqNVA0Kyt4Y2tCVGhNY1BlS1ZIYXBrbDNnZTdSQklYZ0JP?=
 =?utf-8?B?TzBxSm4raVJUVGRXaWdra2hPYmRMWitTZWhyRmFrSndURmdiUmxQRUpLZ1hy?=
 =?utf-8?B?MmJZTTJ1bE5QQ1VuZGtRSVUrdTBRaXREZVRhUFV2TEdVR0MxSGNCUFVJMEsz?=
 =?utf-8?B?Z1JZMnlSaGF0Y0FWN044ckxuenk2UjVmcGoyRHF1Y1M2czRXeTdwMUlZK3U2?=
 =?utf-8?B?SU5wRHZpWXFySWdQN0Q0RTdaSnNnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <550960E21ADA7542824A88FCC6B67FA7@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	/vBDLpkwXuW3L6/OqA9CoWz7hHUSbgS+Uegkps+qLzWn5DW6p3Tyf4aqeGGnfM1ILzJbHFAY6+Rhbd8LYuuFD8p6lpK1NlBGvNL2ut0IdBsyXIWRXwlc5YqYRnhedTm2OXGw2ihQY5Ax2vcbxPyvpaTLcB+Q/vsvvKBty0r3XtFtqN2oKi1uoz+HoBO7scUkfdlmR9dVZiEuJrzjTylEnBqlX/WD7PUIJqtk+LnreO64a22zgN1aRPDWBS6yzG4+X60zDywXfAxXWC2Nsz2KAe3mN+fy4WiwE0eb9a5YtKgVF3ZnZxLEDVJOmXetgfVJN6xOgySgF+e0Iu74fctq5jtx0G6u1shMPKuGUfdb8K1LzntRkbaLB6E6hJsNdS4Fizqwq3TgpY33+LukaC7NjXQ9CszQeFxLwSgEEhOB+pHGfDVyouSZdgCuEmYVUypKjOX2IvQLUgZKGVsiFNodlJ/9ihb8CX0wIxihw3QKYJY/EO/7MI9ca9WaJfAGY3GygGSpJcKggIZ567ZXGLXG+LR2GggDbIf8fb49eGgeT7AaZQJcKfmX+bDHYWdm+TVtY8wMoMRVQuAQ8pBHzicm91zK/gmphlO9hel7TfWRDWOLLreUqvpVPLS66Au/yUu8
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee2eee7d-2ef9-408b-a195-08dd442710b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Feb 2025 07:47:53.1060
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: xv9hOpIpc2Xua65DDo2hUMQQFnJfWhTALe9g97TC6yZXJO/2KBT2QqB0vMo6JHtAzuVuMy8FGNOT3fdzeRJCYzV8dTBKVYtW6xY431ywv74=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9584

T24gMzEuMDEuMjUgMTQ6MTEsIEthbmNoYW4gSm9zaGkgd3JvdGU6DQo+IE9uIDEvMzAvMjAyNSA3
OjU4IFBNLCBUaGVvZG9yZSBUcydvIHdyb3RlOg0KPj4gT24gVGh1LCBKYW4gMzAsIDIwMjUgYXQg
MDI6NDU6NDVQTSArMDUzMCwgS2FuY2hhbiBKb3NoaSB3cm90ZToNCj4+PiBJIHdvdWxkIGxpa2Ug
dG8gcHJvcG9zZSBhIGRpc2N1c3Npb24gb24gZW1wbG95aW5nIGNoZWNrc3VtIG9mZmxvYWQgaW4N
Cj4+PiBmaWxlc3lzdGVtcy4NCj4+PiBJdCB3b3VsZCBiZSBnb29kIHRvIGNvLWxvY2F0ZSB0aGlz
IHdpdGggdGhlIHN0b3JhZ2UgdHJhY2ssIGFzIHRoZQ0KPj4+IGZpbmVyIGRldGFpbHMgbGllIGlu
IHRoZSBibG9jayBsYXllciBhbmQgTlZNZSBkcml2ZXIuDQo+Pg0KPj4gSSB3b3VsZG4ndCBjYWxs
IHRoaXMgImZpbGUgc3lzdGVtIG9mZmxvYWQiLiAgRW5hYmxpbmcgdGhlIGRhdGENCj4+IGludGVn
cml0eSBmZWF0dXJlIG9yIHdoYXRldmVyIHlvdSB3YW50IHRvIGNhbGwgaXQgaXMgcmVhbGx5IGEg
YmxvY2sNCj4+IGxheWVyIGlzc3VlLiAgVGhlIGZpbGUgc3lzdGVtIGRvZXNuJ3QgbmVlZCB0byBn
ZXQgaW52b2x2ZWQgYXQgYWxsLg0KPj4gSW5kZWVkLCBsb29raW5nIHRoZSBwYXRjaCwgdGhlIG9u
bHkgcmVhc29uIHdoeSB0aGUgZmlsZSBzeXN0ZW0gaXMNCj4+IGdldHRpbmcgaW52b2x2ZWQgaXMg
YmVjYXVzZSAoYSkgeW91J3ZlIGFkZGVkIGEgbW91bnQgb3B0aW9uLCBhbmQgKGIpDQo+PiB0aGUg
bW91bnQgb3B0aW9uIGZsaXBzIGEgYml0IGluIHRoZSBiaW8gdGhhdCBnZXRzIHNlbnQgdG8gdGhl
IGJsb2NrDQo+PiBsYXllci4NCj4gDQo+IE1vdW50IG9wdGlvbiB3YXMgb25seSBmb3IgdGhlIFJG
Qy4gSWYgZXZlcnl0aGluZyBlbHNlIGdldHMgc29ydGVkLCBpdA0KPiB3b3VsZCBiZSBhYm91dCBj
aG9vc2luZyB3aGF0ZXZlciBpcyBsaWtlZCBieSB0aGUgQnRyZnMuDQo+ICAgICA+IEJ1dCB0aGlz
IGNvdWxkIGFsc28gYmUgZG9uZSBieSBhZGRpbmcgYSBxdWV1ZSBzcGVjaWZpYyBmbGFnLCBhdCB3
aGljaA0KPj4gcG9pbnQgdGhlIGZpbGUgc3lzdGVtIGRvZXNuJ3QgbmVlZCB0byBiZSBpbnZvbHZl
ZCBhdCBhbGwuICBXaHkgd291bGQNCj4+IHlvdSB3YW50IHRvIGVuYWJsZSB0aGUgZGF0YSBpbmdy
ZWdpdHkgZmVhdHVyZSBvbiBhIHBlciBibG9jayBJL08NCj4+IGJhc2lzLCBpZiB0aGUgZGV2aWNl
IHN1cHBvcnRzIGl0Pw0KPiANCj4gQmVjYXVzZSBJIHRob3VnaHQgdXNlcnMgKGZpbGVzeXN0ZW1z
KSB3b3VsZCBwcmVmZXIgZmxleGliaWxpdHkuIFBlci1JTw0KPiBjb250cm9sIGhlbHBzIHRvIGNo
b29zZSBkaWZmZXJlbnQgcG9saWN5IGZvciBzYXkgZGF0YSBhbmQgbWV0YS4gTGV0IG1lDQo+IG91
dGxpbmUgdGhlIGRpZmZlcmVuY2VzLg0KDQpCdXQgZGF0YSBhbmQgbWV0YWRhdGEgY2hlY2tzdW1z
IGFyZSBoYW5kbGVkIGRpZmZlcmVudGx5IGluIGJ0cmZzLiBGb3IgDQpkYXRhIHdlIGNoZWNrc3Vt
IGVhY2ggYmxvY2sgYW5kIHdyaXRlIGl0IGludG8gdGhlIGNoZWNrc3VtIHRyZWUuIEZvciANCm1l
dGFkYXRhIHRoZSBjaGVja3N1bSBpcyBwYXJ0IG9mIHRoZSBtZXRhZGF0YSAoc2VlICdzdHJ1Y3Qg
YnRyZnNfaGVhZGVyJykuDQoNCj4gQmxvY2stbGF5ZXIgYXV0byBpbnRlZ3JpdHkNCj4gLSBhbHdh
eXMgYXR0YWNoZXMgaW50ZWdyaXR5LXBheWxvYWQgZm9yIGVhY2ggSS9PLg0KPiAtIGl0IGRvZXMg
Y29tcHV0ZSBjaGVja3N1bS9yZWZ0YWcgZm9yIGVhY2ggSS9PLiBBbmQgdGhpcyBwYXJ0IGRvZXMg
bm90DQo+IGRvIGp1c3RpY2UgdG8gdGhlIGxhYmVsICdvZmZsb2FkJy4NCj4gDQo+IFRoZSBwYXRj
aGVzIG1ha2UgYXV0by1pbnRlZ3JpdHkNCj4gLSBhdHRhY2ggdGhlIGludGVncml0eS1idWZmZXIg
b25seSBpZiB0aGUgZGV2aWNlIGNvbmZpZ3VyYXRpb24gZGVtYW5kcy4NCj4gLSBuZXZlciBjb21w
dXRlIGNoZWNrc3VtL3JlZnRhZyBhdCB0aGUgYmxvY2stbGF5ZXIuDQo+IC0ga2VlcHMgdGhlIG9m
ZmxvYWQgY2hvaWNlIGF0IHBlciBJL08gbGV2ZWwuDQo+IA0KPiBCdHJmcyBjaGVja3N1bSB0cmVl
IGlzIGNyZWF0ZWQgb25seSBmb3IgZGF0YSBibG9ja3MsIHNvIHRoZSBwYXRjaGVzDQo+IGFwcGx5
IHRoZSBmbGFnIChSRVFfSU5URUdSSVRZX09GRkxPQUQpIG9uIHRoYXQuIFdoaWxlIG1ldGFkYXRh
IGJsb2NrcywNCj4gd2hpY2ggbWF5YmUgbW9yZSBpbXBvcnRhbnQsIGNvbnRpbnVlIHRvIGdldCBj
aGVja3N1bW1lZCBhdCB0d28gbGV2ZWxzDQo+IChibG9jayBhbmQgZGV2aWNlKS4NCg0KVGhlIHRo
aW5nIEkgZG9uJ3QgbGlrZSB3aXRoIHRoZSBjdXJyZW50IFJGQyBwYXRjaHNldCBpcywgaXQgYnJl
YWtzIA0Kc2NydWIsIHJlcGFpciBhbmQgZGV2aWNlIGVycm9yIHN0YXRpc3RpY3MuIEl0IG5vdGhp
bmcgdGhhdCBjYW4ndCBiZSANCnNvbHZlZCB0aG91Z2guIEJ1dCBhcyBvZiBub3cgaXQganVzdCBk
b2Vzbid0IG1ha2UgYW55IHNlbnNlIGF0IGFsbCB0byANCm1lLiBXZSBhdCBsZWFzdCBuZWVkIHRo
ZSBGUyB0byBsb29rIGF0IHRoZSBCTEtfU1RTX1BST1RFQ1RJT04gcmV0dXJuIGFuZCANCmhhbmRs
ZSBhY2NvcmRpbmdseSBpbiBzY3J1YiwgcmVhZCByZXBhaXIgYW5kIHN0YXRpc3RpY3MuDQoNCkFu
ZCB0aGF0J3Mgb25seSBmb3IgZmVhdHVyZSBwYXJpdHkuIEknZCBhbHNvIGxpa2UgdG8gc2VlIHNv
bWUgDQpwZXJmb3JtYW5jZSBudW1iZXJzIGFuZCBudW1iZXJzIG9mIHJlZHVjZWQgV0FGLCBpZiB0
aGlzIGlzIHJlYWxseSB3b3J0aCANCnRoZSBoYXNzbGUuDQoNClRoYW5rcywNCglKb2hhbm5lcw0K

