Return-Path: <linux-fsdevel+bounces-63947-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F195BD2BE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 13:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7E541189CA53
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Oct 2025 11:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFEF26B2A5;
	Mon, 13 Oct 2025 11:14:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LHF6Q0yk";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="KYGy60bh"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 585F64C85;
	Mon, 13 Oct 2025 11:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760354079; cv=fail; b=gg4Vt5grUQh6JvzfD9ccjgCG3+1Usxj5BT6LDe/vklq5qkOrhhDrRXfEQl/rGvgPPX9n3ZixpvMSxVxymV8tFgYVYTBKtlAWrkgkndDk+z6+cBYc3jrTwO2BH2W0hKRHiPFTURrRrYaE4c4pk9Y0qX3Rrn9Up6I1UjmawkwbB44=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760354079; c=relaxed/simple;
	bh=Q696IijiS9ipEcnLBzquFMPyJ1kk+3OIogXan2+ZENI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Z9zrhm0YSl6FCRw85ZQlIFy7itCwOhzlyZYYyH/uBek8olJ74GzhlhSJv/cViylqWsuYmYyWJN8KkFtzIGGNXjZBWhnQ/4uwQeoFWXc8lD5epV1JZsAwtT5/qXEiUEmMNRjFTHOVEKQugEM5od+k9fnTeLLc28PazB5dbMoh3vQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LHF6Q0yk; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=KYGy60bh; arc=fail smtp.client-ip=216.71.154.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1760354077; x=1791890077;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Q696IijiS9ipEcnLBzquFMPyJ1kk+3OIogXan2+ZENI=;
  b=LHF6Q0yknCU2Xw51FurC9WCFERA/O7l+veLx26ZhgTM5aRDf1znwsY3W
   BJhG5EH05rE1Hrhd9+fedfQx/RZG/Ut7tFkWILk7MI70PYGBGJ6ZMMyCu
   f/98VeG2VSsssQqyx5ae8uayExCAfvmZ4V0N98RcSbI9PHO4YxX9Svyb2
   UKj7AyDJjPlpruJrdYPy7XX6OF+flKzQh4ynY0s+Q+0L6xcoVlka2UDPL
   gEEOIqIKxnIOl3swdZMffuLQyNyqYn7YB7GQRF1YCDCqRQqaAQjxAN6r7
   AhLiVz62PqijjFqzftHv+xrF4FRlGseoaRE5sL651gnwmdVdB7Fq84QJZ
   A==;
X-CSE-ConnectionGUID: ijFOlXu1RRSV2jKeQQnXfg==
X-CSE-MsgGUID: faoJS7/ASkGvRsyZPa+jfw==
X-IronPort-AV: E=Sophos;i="6.19,225,1754928000"; 
   d="scan'208";a="130112421"
Received: from mail-southcentralusazon11011043.outbound.protection.outlook.com (HELO SN4PR0501CU005.outbound.protection.outlook.com) ([40.93.194.43])
  by ob1.hgst.iphmx.com with ESMTP; 13 Oct 2025 19:14:36 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JTj3glcbW312hWU2ygYLl2NYm61cOkI20xALPMG2n++jxtVRL4D/9yH1ay/6yCTcgd07xAji7G8fz0yjEJ/PnSX21AP3Ri+87Khp2gnETupyrgwort30WQ7q/yyP0sp+leqxBc4z41APdUz/1m1rXawq9RJcZemhozdHw2JHvaPj5QlT7XIinpuXesh4Vh/2mlQt3M6XFPLR3YHE0HLsO71A9qg9PAZpxDu054JB6qGXCbzsB3/m3D+7HpXmPJgPnfJ9h3FdnhlcCq1ocY++2lt9Ns66io7g5fbViGwSY7pfg+PJAVNjznoLqLNTevCZKH035Ny5keobSgAnMUXXpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q696IijiS9ipEcnLBzquFMPyJ1kk+3OIogXan2+ZENI=;
 b=lDRNKO+7JtP7ZXI+MgJYhMpq5BN467827SoiOjrDw+cL+gDI3SugRrxG8EsMDlvJNTzcOgnmOPeKcujiR31/bMSm3nVG8uQp+ElPiv7ju58iWC6o+oJXBh4EAnOkoZNvOFEVKUrVs8TRAFncsxiZvyCW2xWtdU2kL+8C6HKsANYrkYNwM92YmOMAvx86KtrAX44G2mPx2i1LayQVnzdzEQoewZbsmLarVCqhE2T5EbHvnIct7a8d5RFufw8HkI6LACz3upoJ6v7Y7srn9LvMXaEe3GW+hnSI4Y2VXINvT0PhZFOAO81tLII/z+9V3bHKLYDahzoG24Z5LlNfgwnEaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q696IijiS9ipEcnLBzquFMPyJ1kk+3OIogXan2+ZENI=;
 b=KYGy60bhZzgJYUsK/5tEkQ3azwKOeEBYJTUz/XJGoI2gbQsKPFR0vlfurLcjIiyTht1zi8+92fip8TP1bTGxFlkzji+RapoL3dhTwf2oUi1/xsMDDB9b6YxCTDSiUlc3CmvQI5lqqZgtm0SH/ahjJPXbIN/S4RN/utf0wpbcBQs=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN6PR04MB9335.namprd04.prod.outlook.com (2603:10b6:208:4f3::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.12; Mon, 13 Oct
 2025 11:14:33 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.9203.009; Mon, 13 Oct 2025
 11:14:33 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>
CC: "brauner@kernel.org" <brauner@kernel.org>, "djwong@kernel.org"
	<djwong@kernel.org>, "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Thread-Topic: [PATCH v2] iomap: add IOMAP_DIO_FSBLOCK_ALIGNED flag
Thread-Index: AQHcPCCQDRkNHwxlK06mS2xj3NN/07S/7NgA
Date: Mon, 13 Oct 2025 11:14:33 +0000
Message-ID: <cda26765-066d-4e4f-bd8e-83263f1aee82@wdc.com>
References:
 <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
In-Reply-To:
 <c78d08f4e709158f30e1e88e62ab98db45dd7883.1760345826.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN6PR04MB9335:EE_
x-ms-office365-filtering-correlation-id: 85ef1771-a639-492f-2aba-08de0a49b024
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?Mm9MR3drdjJvVXZyL2hiNC9OL2c3OXd1enVXT1hqeWtkanMySERZVXh6UVdJ?=
 =?utf-8?B?Ymd5ZWZ1aE5XYnlZdHhKcnpGd2V2OUFIQWhRRzBSZi9LVVd2aExEQ2lTclph?=
 =?utf-8?B?bmdWMkZRZ0tZZ0hxMWVCWGZWVW5TL21vajEvcGJXUGdBR1lpcEM0YU1MRFdH?=
 =?utf-8?B?V3Vxb2tBcWM5NjhVNnlac3YwZzJYUVArZmNQZnpwVUsyRjhQMHd5c2J0YWRy?=
 =?utf-8?B?N0lQWk10NXZBNHZWRyt2T3ZianpmRnRENFQ1aUJHamEyaTVXUk5XVnBjbndy?=
 =?utf-8?B?SHZJYUNrOWxGcTd3Y2lselU0bTZaSEV5bG1JVjFUSVNiaXhQdTJNVlBWWURm?=
 =?utf-8?B?TXJRYXdRR0plY3dlYlFaS0kwS0JwQ0pLVXp3em05RUYwUm9XRWRhNmd5V1k5?=
 =?utf-8?B?aFlOTjM1SGtSQXBFcjRQSEFpRndaT2lFc0NPeVBmcGFhYXZzUTlJRUxGek4x?=
 =?utf-8?B?N0FZZGZ6K1JPdzNiOUpEdjR1V2ZPcmxmeW00NUxFcEdIU3RLYXlDNzQ3WGI5?=
 =?utf-8?B?emFlZjVreEFHVmJKTUhpVkl3ZmFwY1A5MWZnQ25JbmJsZk5aN2Q1aXpzRlY2?=
 =?utf-8?B?OS9mWkF0WmFIRlZkQWJyZXRWK3NaM3NFb0VaRkVvZTkrby91Nm1VdWIycW5t?=
 =?utf-8?B?SGVqWG93VFY1bUs0RWwrZXFab3V6OWlvaXRNWDVIS2VYNFJLb3NTODRoVVlM?=
 =?utf-8?B?Z3NmTis1bzFBVDc0NUdDWFVWSThMR2NHekhrWnBTVUJwajJxcHpBZzI0bjBC?=
 =?utf-8?B?bE9vbGxvZlp1cE5ZNk5nNmZUUEZzSlFIa1ZOZFBkQzA5b1FBMEUxNEtJVWZv?=
 =?utf-8?B?T3dDVWhtejV5Mms2U0xmVHMzdWRrTmtpTWkvSGZuVmthTmJBeUthcm90cG5R?=
 =?utf-8?B?T3N3eTlDWTdJaGl3dXNWTHRleUVBNGRXYzZLWCtpWWFscXFCaTdITDhXdzcx?=
 =?utf-8?B?K1N5cGg1V21DVkxxdXp0M21XWDRtTm1iRXhyYitLWW0zQnd5N1FiT0RwRzFT?=
 =?utf-8?B?OXkxcHlUTWRUNEhWTHNPeTZrSFdIT0lBdThMSW9kSG9aSGZyUk5PUDAzaGFv?=
 =?utf-8?B?MFlPK0orakp0QkN6dms4Y00wQVZBcFRTNGFWdVNMZlVDY05iZkY4dlVCU2RF?=
 =?utf-8?B?cW9YMmZxMnJNT2F3bG80U2JNM2NEOUViejl6dlQrV25tMG1vcC95RElkVFpR?=
 =?utf-8?B?dTdCYnYxb1NrU3A5OW5kbmJMbmc0MTlla2xicEg1QVZYbUxqYys4SXdDdkFV?=
 =?utf-8?B?cUlWWmd1U2xOaEJxbHVxMVVyTVdQUTZOU2FOT0hiaVNZdHVLZk1DYWs3VzB4?=
 =?utf-8?B?S0VHYVpmUENKVXZqVlNZQkdhek42c3B3S3cwWm5RNmNITzg4bmcwVVdrbWVu?=
 =?utf-8?B?RStLbzhUNXI4YmFsYzR6TnVwNHZ1TmZtT2QvMG1GUk1heVRLU2lpemJMVnow?=
 =?utf-8?B?STJLNmtZbFZnQjFsWk1WdWZISkZPRUJpeWJyY3pQYUNpZmRCOEVkaXorZHhQ?=
 =?utf-8?B?SjNIc0tXeFNFOEV0c0ZtcThRempIeGJTSUdkQlNlWTJLZVUxblVJb2JmS3hF?=
 =?utf-8?B?U0JyczIreDNtMmd3Qm82SW12ZTNvbFNTT3pRNFpESG5MazdyQU1mV0hiaHdi?=
 =?utf-8?B?V3NaRm5zZlMzaU1lVEg0REJPVm9aS3hSbW5WVk9GdkRnbGY2ZzB3aFdRWTJp?=
 =?utf-8?B?Q3UzYnlDYWlsSGZQWXp4aUNEazU4QUtWUjRxcVJqdEdxLzlIaHJPNmxSKzBY?=
 =?utf-8?B?UzEyeGJNd05tK0lHWnhYQ3RVMVVnY0tsSEl0TGZxb1VxVUJQcHNUWVV6REFK?=
 =?utf-8?B?Vkx2UlhzYm5vMExiZDFSZXJ4cmkvYjhUcVFrYy9ENU5JSWFBeGtwaHh1S2FP?=
 =?utf-8?B?UXIxQVh6TnhxWjJ1NHRlUlZnOVFkUTFXOTZtYi8yOGE2bHE2YnU5M2htZmZh?=
 =?utf-8?B?eHlYL2JBWEFkdDF4Z3djVk4wTURGOVB3Y0dkQlNIMUQxOXFleHJhbUZCS3RU?=
 =?utf-8?B?anNkZE1ldjJvcTJWbDhkZzlpZm1rTnJCREpDeXJLLzVDdWV3TnpoNWlmZDlz?=
 =?utf-8?Q?ZTiKIe?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?Ym9zMTA3c3hKU1ovY214SS9lRnVhSTBvYTlORE5QOGtrc1BYYjhnNzlsM0xW?=
 =?utf-8?B?Y0JzU2k3N01vdStLaGZkeGdFcUE5WVZ5WmE2ZXlVY0ZZaWlzb1RjdHVoeElH?=
 =?utf-8?B?T01EQTF5cjNQbHZpdFB5OFlhSlNSQ0IyMHp0MmEveU94UjZ5NHMrVWQrNTJM?=
 =?utf-8?B?cmsvRWdSVWVHRldmWlowRVQ5R093YXozRnNUNTZ1ZVJ3ellCU2N6d1lFMXdY?=
 =?utf-8?B?ak92UVRhMTgrRDkwYWJ2R0QvSnBtMGJZZUhmUkdWT05YOExxQldRbFRDN1RM?=
 =?utf-8?B?VHg0TVlGTWI5Z1lrM2JnbTNEOFJ6Y1d6bVZ5bTliODArOEJibHpvQUp5N01T?=
 =?utf-8?B?UEhzU2JEREhSTEFwSk5aYjNxVWJXcndrYlpra203TTBheTJHMTFUak84QUhN?=
 =?utf-8?B?OFBWZTZET0dlWktnaTVxVEJ3OUt2VisvbkpZNGN4RXFFaGRRUjNzZTVuSlVD?=
 =?utf-8?B?VWhkTUpWL3U2bmppdWIvdzVia256UllnUFkrL204YTdZK1prdUZWVFNrNVNp?=
 =?utf-8?B?N2pBVXZxamh1Y0dEbWZBbnBJYVAwYVdvd3p4RFBTQ2lvQ05mTjJXeWkwVnM3?=
 =?utf-8?B?NjNrc3l0T0c4VVd0b0NTVy8zTU1HSUFuZnRpbk9Va0hJdUNxejVyWjdpbW5U?=
 =?utf-8?B?VHpVbGFxeFFFUi9qbzhRbjg4ai93akZiYjBMZWNNZUQxcUs0SWgzVGdnMTF0?=
 =?utf-8?B?VytIc3pIclM0SHkvMzg1Wk9INUlCMEFCZk9CUEM5U2dtYTJ4eXhKTDkvRmZw?=
 =?utf-8?B?a25pUFZ2U25EWDE4N1JTQ2JhSXdLMEJ2T0xPdHRIWHlLMUM5SENZSzNtRzBz?=
 =?utf-8?B?WlhlVCtIQ2NBTUlhay95cjhLYXIyTmdsZjR2TXpqcldmc041ck9VZXpZY2Rs?=
 =?utf-8?B?UiszSFo1WEpDTkc3RDFRRFh3WWhMM3R1QWM0VE4rdkRXNFh4ZjVBRjdVQnYx?=
 =?utf-8?B?NlhtbDBlNUdCNTJTU2JValhhQ2Y1SDI2RXhYQWNucmZzMlhJRmdjUitUM2w4?=
 =?utf-8?B?RGJObFVaSzZ1L3cyUjZ4bmF6YkkzUzNuOXZSVUFwbEVUeFRwWG9NOXFCd25H?=
 =?utf-8?B?OVJYbXN5NUtDY1BYODhnV21tSFJlUit1dytoM3BoMU00Q0hFNG9HRUttZ1ps?=
 =?utf-8?B?c2NxVEZIalRwK1VLVGxvcVQ4SVJVZFczTk5HMmxhWVJSSVpVYWNmY0pxWnV1?=
 =?utf-8?B?SjdWTHVCTndzM3lYME1jWnlrN3g5TERtQlBPMTJwVnZYaExkc3JueCszblk4?=
 =?utf-8?B?S25RVkpCVjl1ZVIxbGNhK1JnYzY1dzduY29QTjcySk5qNTc5aUNmR0tSOGk2?=
 =?utf-8?B?T1F2akIyZXBFaEQ1NGxuVW15TU1yVS9pTHVTc09pT1Y3SUNrWnArMFhsSDEr?=
 =?utf-8?B?eDdDc2YvSWQ5bXVkZENxMHJyR1pxRHhsSTFlUHlEMDdhdSs5ZW9VTnJEcXEw?=
 =?utf-8?B?Z1RkUStUaFZ6R3Q2QXBaSHpNMXlFUEN1dC9YVG9OSUFjcTQ5eHYyN0dyVlRS?=
 =?utf-8?B?WmFOTUd2QmRQZy8xWkJLemFLVmFjQmszTXpDbTNCL3hXU1dRRFRZWXN4dTM5?=
 =?utf-8?B?Qm9SYXphRy9uazZyWDhYbjRZV1RmT0pRTk9SUTNHaEh5Wkp1eDhiNzhiMVdU?=
 =?utf-8?B?aDZWM2VMeUFQRHQrK1QyTHZqbnloempDSklKS0pCS2REamlQcDVLOTdzNC8x?=
 =?utf-8?B?RmhxWGVrM1VsejZwYWhkdnA5czE5QmdZY3JtUG55Mk82emlCeW45K2VlNnZ6?=
 =?utf-8?B?SE9tQ25aNU1jRUlOcG90dFBHdkltOURNVW45UmJjT0EwWi95dnFNdElEenh3?=
 =?utf-8?B?KzJyc1Q1bEZhUHRnT2FuaTk4bGpGSXF0Szh6TmpOSlVadnd4Z3ZpQnlDWmNz?=
 =?utf-8?B?UnpYbzRiOStvTWYzVk5jZW5DSkUwQUpxU0owWUpvLzZxTlBPdzlBdEtKVzJC?=
 =?utf-8?B?RHlNYTdzdU1ma2VLTzRmbDVnNmpFMGJoWkRjYjJ6d2JxOVR5blQ4WmdNNGha?=
 =?utf-8?B?bU80YWx6cGt0Yi9UVlc4cjlwSHFuNUhhdEtkQ0RiTFlsRnZmK3pWOGxYZTdG?=
 =?utf-8?B?alpqMzNrSW02K2VML2VEa1NmaDVTWGlJNXZWMmcrbGUvVG14ZDYrR0ErcEIx?=
 =?utf-8?B?bjlZbW41RVMwd3pIOXhTWU8xZkVtcWE5b21ZdGU5a0VhRWQ1S2ovZXkyeDhV?=
 =?utf-8?B?eFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F9C82AEDFC77D54A93F2A885898B13A0@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	3GaMDIpRFHflKBIRvxKrfeBFkdmKA0WBOsjVMg77bVup7XRel9Jn8V4mLDTxJ6bKhSrVeG0zhC9FrVJCtlBPVKu72D0JAmmtUEkfVOZnxStMPDztTBIxMM4HgBs+RwmfT1DREN82vT8RmvkX9xDBUhh2z/QkHUPhhds2nKnCXB17PVePT7OzbIzu0/FDdA+0JzwzZuushv68TaReqjxbjbdCnysJ/QeHmf47fJzn1gZoxaKgJhZeMHLiFg7Vi4OX3AZi2W2mgXRBTeCkvj1opZzU1e7PhELXYBxHhP+sX64s8XhMgxLraPiIsJq4O/MeUjWy/dT6qlDxvTqKCLl0O/dcp6xbBwHQyNemrmC/9lN9VB36B/C7uhxs8HOFz5E2GWJqX/GdaPRfdGSEeVpgmfIa0qRp8pgTqPRXCwFjoxcnHZ9GUe3A6/xvynZcUoMdUq3nX80fxyMq9G883mbYE3wHQwaQfR9VNm3WYrLj5YopPDgO031FvXB+QVY4+/LWwYsQRScrhmtfWZXEnyRPAdk+ShNCcNjxoQfpu9Zg0CVrL7CCMOapZRTLvl31uP6JcQMnrl52nY64LtRr66ThOVTvZP1ww1mta552PhDVDI0dij7zvEiuFqtOmLjSl+JA
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 85ef1771-a639-492f-2aba-08de0a49b024
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Oct 2025 11:14:33.6704
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sszGbk/eCz/poxnk7dHGPm7qxBKGfDSiIS7VWCUr9BUH7GUP6dIDrXgVjlV9MfCZTWLcZ3ghpApy3MF9Nz+2FQV9yJZ6ayCx5hLlOFb0D6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR04MB9335

T24gMTAvMTMvMjUgMTE6MDUgQU0sIFF1IFdlbnJ1byB3cm90ZToNCj4gLSBSZW1vdmUgdGhlIGJ0
cmZzIHBhcnQgdGhhdCB1dGlsaXplIHRoZSBuZXcgZmxhZw0KPiAgICBOb3cgaXQncyBpbiB0aGUg
ZW5hYmxlbWVudCBwYXRjaCBvZiBidHJmcycgYnMgPiBwcyBkaXJlY3QgSU8gc3VwcG9ydC4NCg0K
QnV0IHRoZW4gd2UgcG90ZW50aWFsbHkgaGF2ZSBjb2RlIG1lcmdlZCB3aXRob3V0IGEgdXNlci4g
SSB0aGluayBpdCBpcyANCmJldHRlciB0byBoYXZlIHRoZSBidHJmcyBwYXRjaCBpbiB0aGUgc2Ft
ZSBzZXJpZXMgYW5kIG1lcmdlZCB2aWEgdGhlIA0Kc2FtZSB0cmVlLg0KDQo=

