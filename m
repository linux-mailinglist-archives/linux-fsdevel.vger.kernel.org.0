Return-Path: <linux-fsdevel+bounces-40209-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0057EA2069C
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 10:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 711957A47AD
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2025 08:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5ED9D1DF748;
	Tue, 28 Jan 2025 08:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="OrPkk4RQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="z9jUYPi2"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDC74A1D;
	Tue, 28 Jan 2025 08:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738054795; cv=fail; b=lYDY9SCm6kqaduQia12GVhPjSS6xnnnnc6sJvdD3dbNjkdpOWjbn76d+idV/95lS4p2/Kg7ZrdufRQ2eBQo0SM1KhO2MbycZmC8QYJRKd3xPL7omVIoovTxGE7+W/eGKNgxW5CfDkwz/tXhPTChVuvzjItLEyTDrsoJCzmEbxDA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738054795; c=relaxed/simple;
	bh=5l2DEHipj0oCgDgbJK93dCGYlqgEna8O0y35I7POqxM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NHJw9l2qy4hbrYa/hehCus/D7nQpNUKBWHv4QkyuVyj/nOJZ2msyFjERP7hfNgxfASQtHGDKarz7Gq+amRp2RjWi8Mr0nvbIpW8pcbwlo4VdXlz1nxCOfooRzuEAJku6dQRpc2uFwiSIjE8Vip7YVcXLlDuAdaunji65dmsw1ps=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=OrPkk4RQ; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=z9jUYPi2; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1738054794; x=1769590794;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5l2DEHipj0oCgDgbJK93dCGYlqgEna8O0y35I7POqxM=;
  b=OrPkk4RQYyVcBJpXFZcm32Eu+6KrxTod4emOoqjbFxaiGsCtQ9x/ye23
   WqPH3ULfW1vprPaLKT2H3BY7lIZVPzbNjRkAogkdnMxUVssRVTtdGBzv/
   XSAXZV2Ty3f4jtTkNHNJprWhWwz7gH3fAiF708qO4LCY0cenjV9gOBrgO
   3ePapuK10TWqBs9gMlCPPQZvB+Y52CzRlxoTXpAYj4FIOVg7KDojFyei+
   KULms9IMfqPl/usgaqmAyCzdOE/GH3st9wIOPXCf79injPNejCrPZjwO2
   zHuKiEPnnutZgCRT/msN5xe5kDOy1TBFs6uDQXTOo5QgzuJrufjhSlxmU
   A==;
X-CSE-ConnectionGUID: CINKNijxRtGgJmYvhDTiIA==
X-CSE-MsgGUID: mv+9IsZ8T6O8dWVHQMN6fg==
X-IronPort-AV: E=Sophos;i="6.13,240,1732550400"; 
   d="scan'208";a="36969428"
Received: from mail-bl0pr05cu006.outbound1701.protection.outlook.com (HELO BL0PR05CU006.outbound.protection.outlook.com) ([40.93.2.10])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2025 16:59:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=INV+i9xNuN71SXT0eMxvR8KNYEVVNBtim26hvZbsPtCHLKMs1t1d+k+HN/0e2+s76KvOlbAr+OvAxh/wqznU3zCnbDal42ACQiNH8Wlh1rQ302IpliMD/nYVUPLbkPiCEOJYpF8hE+ZbZIErR2OmenHsfMYpiaK8XVpBj504G0FoCWuWTjfEOC+bJh8Am4MZbyHuikoQGHqGrxMYnu1r5V5tvQ5JPpoh5VfP1qGCDR5ih8Lnbzd+nUO7+QwvcQjzRGDYocymfx23fgSeXFDNB0e5t6x0UBN3nB25Rpg2RlrT1P1me3/elc4yODTl3EzR+/VO4PHq6KvrZzf/G3bmxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5l2DEHipj0oCgDgbJK93dCGYlqgEna8O0y35I7POqxM=;
 b=Pt4EfS16gkU7cpRJ6pgjk0AEkTHU8TU1nitYRV2kIYvXY1lhf5i8+MWyF1HA+8YCUN0mSPxejIEYW2RJV0xR3svCy9155a0R0aWktbAb+4+/CgeBFpFluHIpvlaEcaxDB+VHNvA8VjSE2oWePiLwfA5ztBpCV/QTEk8K5J0snYzPImHa2pXHsgXmSQHTMGA+/5+nsyX/xqyaQ+Iqjo8WLy9ovFn4ChL75uEdHbN6pcyeDMM/2OBRPFd2J+xQ9Iz9cDb8bgz1yAQjBmidLxgrJeV48fhn4K1TCRoTrmrRd/xIkwHawuaD28ML97VPGJHe1h4hJ0NkCyGkUXJCTm3y+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5l2DEHipj0oCgDgbJK93dCGYlqgEna8O0y35I7POqxM=;
 b=z9jUYPi2Ak0/7CKqUbtKH8NirEHUxl/jFr0MM/Uja6rh2XNCvoTNasSHFaoUwn4j/gLdJLJfzEgNUfQicYP1QKjhWM4NfJERFUnTkQEGleVonAwkpNg16NUgf3rYDK7DdjyGV9VNJt2cfw8LV9opgBccPk2WNZXsiTbg7j/HfuQ=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH0PR04MB8068.namprd04.prod.outlook.com (2603:10b6:610:f0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.23; Tue, 28 Jan
 2025 08:59:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8377.021; Tue, 28 Jan 2025
 08:59:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Hans Holmberg <hans@owltronix.com>, Viacheslav Dubeyko
	<Slava.Dubeyko@ibm.com>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>, "slava@dubeyko.com"
	<slava@dubeyko.com>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "linux-block@vger.kernel.org"
	<linux-block@vger.kernel.org>, "javier.gonz@samsung.com"
	<javier.gonz@samsung.com>
Subject: Re: [RFC PATCH] Introduce generalized data temperature estimation
 framework
Thread-Topic: [RFC PATCH] Introduce generalized data temperature estimation
 framework
Thread-Index:
 AQHbbdWqn1HCzX8OPE6FHTiztjVarrMlldaAgADVRoCABEYMAIAAb7QAgADFcQCAAAP9gA==
Date: Tue, 28 Jan 2025 08:59:48 +0000
Message-ID: <8369d108-7f11-4989-863f-abccac45c322@wdc.com>
References: <20250123202455.11338-1-slava@dubeyko.com>
 <fd012640-5107-4d44-9572-4dffb2fd4665@wdc.com>
 <f44878932fd26bb273c7948710b23b0e2768852a.camel@ibm.com>
 <CANr-nt2+Yk5fVVjU2zs+F1ZrLZGBBy3HwNOuYOK9smDeoZV9Rg@mail.gmail.com>
 <063856b9c67289b1dd979a12c8cfe8d203786acc.camel@ibm.com>
 <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
In-Reply-To:
 <CANr-nt2bbienm=L48uEgjmuLqMnFBXUfHVZfEo3VBFwUsutE6A@mail.gmail.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH0PR04MB8068:EE_
x-ms-office365-filtering-correlation-id: 04a733bb-cf9d-43ac-7c5b-08dd3f7a1eab
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?blF0RzBIWThQc2w0NWNDdGJpRzE2cnl4TFF2T2QzWUtvNE8valhCVTR3c0JW?=
 =?utf-8?B?eXBjVUV5aXpyeEEvVnFIL3VJTHd6cERRN2hNaTJuQThrZ09hbUNvYksrMUtH?=
 =?utf-8?B?cVBETWpaSnc5TkRRM3hHT2dvdlBBNXNpUkg0VnNmbXJFUEhSQko1c0tvN2Fp?=
 =?utf-8?B?K1R0RXNqMFVRQW5ua2hQOFlsbityQkYyM0lRZDViRXJnWEdEYjk2MFBZekNv?=
 =?utf-8?B?SlkvQmladkJDajhkWE1aMG5ONndlSDdOSHlkWFJWRTVkM3BrdzBnLzlLSGFE?=
 =?utf-8?B?WDhnc1JoNThLMDY1djh2T25ETU4zaUFzZ1dmQysxeTE1eEpFeFI3RE9mSk1k?=
 =?utf-8?B?OXQyVUkxaTVxRWZQMXFHSmsreGwxOEdDMGtiZ0pzMjdobVdvVXltUFJpalFW?=
 =?utf-8?B?MkwveWF0dVR0aDVHY0NSSSt4TzB4SzJ2cTJaYTVVSnU5LzNBaTVwR21EaG0r?=
 =?utf-8?B?VHpFeEhMdXdiTS91M1ZSSjUyYVhIb0JHMmpFQ1ZubGZRSFVLNFhFR3hVNjVW?=
 =?utf-8?B?SlFtbXZjdFBtUWdnR0JrQWN3ZC9XQXFQQ1UxbktnRGNRNkg0Vmo1MHRTaTh0?=
 =?utf-8?B?QWhmV1pUSHBiWGdMWUJlZVp5Q0VBRStnWlJRY3V5WWw5UmErdU1OUC9WbDJL?=
 =?utf-8?B?Si9WdVdDelRWSU1mTVhTaEdSYzFTTHl3emx3eXlnRVJlUEZ0enpQOFhNemg4?=
 =?utf-8?B?dXdZbUFybTArZi9OclZWdGpxbTRvWU8rK3BPRmF3V3VJTzZNT0R2YUYxSlZK?=
 =?utf-8?B?NVJvYUxKcmlRUGJPbkpESFNiTzdmTmdzOXZkbTF2QTRuZ2F5bWRUY2FJaGZa?=
 =?utf-8?B?aHdOeGxvejZrcFpRalRiaXdxSzU3VitRdEJ3anN6ejgvZjhjSlNGU3VXVy9m?=
 =?utf-8?B?aVZiSGtDcllmMFlMcUZWTFFFMkNuOGdMZEc2QTNCYi9PK0c1MWNXRzJ3SlUr?=
 =?utf-8?B?dngxb0dEVkJzNS9SeVpkdTRnUklPcFMzNTNiaXNLTUtIaHh0bnkxNEhiV3FU?=
 =?utf-8?B?ekd2S0syMGxIUVBBaDNEVEQ5N0E2QXZ2OUlLRzNFZldjMmtQTjJQYzFvMEs3?=
 =?utf-8?B?NVZBVnFQRU42Mkk1WkhFV2dKdW1kS1VBTlp2YjZabXA5SkFkdlFYVlJUcGwx?=
 =?utf-8?B?MW55Q1ZxcmthK3hZOTNWWEpvb2QxdUd1TlZCVy96b1NWcjlrQ2pGR1F5RDI3?=
 =?utf-8?B?QWRJMFZxN29ESjJQY05hclY1WXlKQVlyTjRqS1Y3SFZkSHV6SVZuN0srNENN?=
 =?utf-8?B?S1hVRnBqakQyUWZhcm1JZHZpQWsyMk1EY3daalZhQnFrc1JRNm5DU2ZtRHc2?=
 =?utf-8?B?YU9CbGQ3bFl3VXY3QlA1ZzNyM3BmMzZGWldpT3FJMUlQTm1MMjJvZGhQNWw5?=
 =?utf-8?B?emc2QmJhUUNIb0FrT0svZWRJbCtLZzA5NXBMSUdDdVRPVlJsL0k1dUF3YW9I?=
 =?utf-8?B?NXdOU3hYemJOcG5vY2ptdTlnMHE0NFZCMk1jS3pGNjFUR2trT3hnZ2kza2Yz?=
 =?utf-8?B?Zi9POUV5dkFjWElpWmRoMkovRDJTd1paR04yMmwzWXZSOG1qd0JpdmhOOEw0?=
 =?utf-8?B?RWVZT2lnMWp5bXphTHdwSVJjRHJZRk1sbW9LK3R6Vy9aUGo1akM1a2M5ZEdE?=
 =?utf-8?B?VEM5YjMrRHUxT3Z1VVlldXNTRkhtOGg3OXl1SS9YQ0VtY2xzN0o2N1dGNkxC?=
 =?utf-8?B?L0tZTUZWdWhyQkw0UW0rdXRCYVFkQlZNUkRkY0hlcU5ZcStIaU5FbEFDcWRG?=
 =?utf-8?B?SUUvSzIyVkZMN0dkUnI0Ui8yUUI2V0tRRUljU25VUkhyS2hVVUJJL250a1dw?=
 =?utf-8?B?Q0U1NW4vOTh2NUswOENITWVnaFUzYXpDTThsUjRma1BoOXNEdFVRNVZORjRh?=
 =?utf-8?B?SVJHSytrejZFTlBZbTh1MXdSUkRWNjJ2QkRoQk1vTzh5Q25aaEUxSjdLeFVU?=
 =?utf-8?Q?EGqA0uJfeyzA3D4tNxNiSHTknbmEcalK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OXVKUUVQUEVMQ2JBTTlaSXhXU1o2aVBNTDIwRzdTQWNVZnRKZFE4WWhkR0VE?=
 =?utf-8?B?eHRmMlIwSTlHVE5mOCsrVklCYkswSW5vWXVxOThYb1I3cUlZaWRsUlVqM2x6?=
 =?utf-8?B?L1dtUnAySitFaE1Rem5UbEdoT0dGUFJQdGpVRVltSEloVWM2cndaZzYvR0kx?=
 =?utf-8?B?OXJRVjRLc01KYnVlNWxkdTRuUWNnMTdFTlBMUGNvY1V1S0p2SkE4WW1IM2VK?=
 =?utf-8?B?b1pFMDJodG5WRGRSSmtRUGFzcyswWlBQNTVTOTBEU2NnRE5SNW9iVGRUZ0Vt?=
 =?utf-8?B?eFFLL1pUamx5TWFuRFBLcUlpRGpmNldFQ0RKQ0ZveUN6bExzN3ViS2xJWFRH?=
 =?utf-8?B?RFVIUjRJeFdTUmpFanFJakRPd3g3ZHJ0cHA5MldWR053cy9BTHI1UU0vT0py?=
 =?utf-8?B?Tjh3cXpGbkwraHdBLzI5djYzVDdmWTlEN2RDeWFiVTFaa0hLcDlreG5JQ1U0?=
 =?utf-8?B?RzI2SjljWGszOUxNb05XRTFqdjVaUVd2RHAyQ3F6V3dsSU9JTnBNRG03QmQ5?=
 =?utf-8?B?b2Vzd092MXkzS1dMajRnWVJZNGs5dEFIa0llaUJ5dzRrUG5BNzg0eDgrZTdQ?=
 =?utf-8?B?VkdsdWtLWXNVL1h5WjJ4b1d5WUJzc1V6a0k4RUZXYXRTQ0IxOEZLVzZnSU9p?=
 =?utf-8?B?SkZnclZBaUZocnJ4WU1JZzRDUmhjdy83SEtlbjdYYmo3VXhMd1RLQndJeWJh?=
 =?utf-8?B?eWRyQmNIeEdCcmpXemxzVTM3Z3F2c0JpWVVQWU1oaTdwOU8wODRMeGpHbk40?=
 =?utf-8?B?UUxLU0hBc1ovVThzWWNTZHVVQVYva0hkQm9QRytzT1piaHVzRUY5TFROOUtV?=
 =?utf-8?B?RnFTQ2UrWWZSZ2RUalhuMjQ4MUdnZ3BwVW5KSnlGOS9QNFFCTGNzSkNHU0VD?=
 =?utf-8?B?cy9OL0NoYURhdlhmbng4dVV6MDlvKyt3WTFXYzB6c0puNFdpZ3Z1UWltVTB4?=
 =?utf-8?B?azN5eERpMjhIL3A1MGNVYjFiazVLM3BWdFIrN3NHYXd0TlVycWE5UjUyNnJQ?=
 =?utf-8?B?cnZRNXJpd0NQOHBGNEE4M3FxZFJ5aUNmblNYOW1lai9TdmFPT1VNY3pRdEdi?=
 =?utf-8?B?OFNBRmpnYTJJRFpYdjhXZEV0bnc1QnMxc1hBSitDMVI0OGptUmtyRERPanNo?=
 =?utf-8?B?SnhqU0hLSVQvendsSkYyK1gwSVBLK21Qa0tjSGpVV3pRUVp2emxCUUhEWVh6?=
 =?utf-8?B?ek1pSGcxNWRLc2lFVmo3Um1PYjM5NWtocXZxWnVUbHQ2RnplODBZMnNPYzVT?=
 =?utf-8?B?cFptbXRPMGpxbExJNzlLZktkTk9EdkxTSlQrZG45S0ZtZjl3UDdWM0Rjb1JP?=
 =?utf-8?B?SEt5a0hIc25wc2p4K0ovYS96TTVaczZqQysvd1dpVksvUE9laXcxclVZMWFO?=
 =?utf-8?B?aWRHNklmZXg0eXRlNjV5dE55UndGUk1TMUxtNnZtQ1RNQisxdEFZNHpnK3dF?=
 =?utf-8?B?Tis5cndrbEkwd1FGeXUxMEVTMTlhM2g0RVdsRVBqWDVCRTdoZzd0UW9OTUNX?=
 =?utf-8?B?VXRQcS96UjduR0JNL2RJaThWT1hNUWhsWXZMZU5abHZPQjVEWHBjOVBaVHBn?=
 =?utf-8?B?a1M0aS9xdDErcnJYVHE4djdkcy81b3M4QzNqMVNsMUkwUW4zR0ZrbjRIbHo5?=
 =?utf-8?B?LzBub0R5Yjcxd1lMdUVGUEpHdGVPd3lUYlhBa21yRGJkRkJDNjZGZTZLWmhC?=
 =?utf-8?B?dmRlNlpWNHY0SGVPVk5HTnhFZ1VjOHRDbGs5Uk9tRk9IaUtMRXI4TjI2OEFB?=
 =?utf-8?B?WjlMMXc4TURlL29adERHbVI3TlNTbkdtSGpMdE95a2FPQTczS3JvVU5raXFT?=
 =?utf-8?B?RW9ZMi9FRGFnZWtPb2MxcXZvcWtXbHpZRGVCbXRSOUhKd3pYSStUNzlqNHJl?=
 =?utf-8?B?anZUUWo2eGpaVUhHT1JlM2k2NVl5T3ZTSDdxWTVCOEh1eUlxa3BhTmJubkdl?=
 =?utf-8?B?UFA5QlA0MEYxbTN2T0QwMEVJTzVFcGYrOGh1TzVEZXVweFYzcktDWmt3MEVw?=
 =?utf-8?B?aTNHcWMyejdPZ3B3TmY5MW13UVF1UFc5VEd4SEEwcWZYdmxmaDRacWdabUpZ?=
 =?utf-8?B?WnZERDE0cW9tSFc0TmZoTy9MWkRmSkU0SVJkWEdwNkIrd1gxYjNXL1piY3Zi?=
 =?utf-8?B?MWtheHlWQTJIZ1doRWtzZ0Qzek1sd3V5QnJUcVdvY2E2Qi9qR09ialFFbFRZ?=
 =?utf-8?B?bHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <062CC1961E7E5845980A36C27CA39582@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9htbL5HUWBt6GdVUXXPn25t3QcGWEVd6K+ZP0XDFdQKoeMfbnBpOpR2FmtrSykYTDSB+jcxbMbQzjqSnlheEmPdX2ef+nB8KpaoJUFJjTetaaDfR/yDmhvYb+zFxZPksFXUr5tZDTLmII0n0KkYbf5WJoGM8n0AIIkWK+u4F0blj8pLrJWEoWk27MoPZ/Lp0dFwNDpy+QbIAlRONceLvXe1QHIvrBaOucW19r1P+YtW2NcjHY39arquxkgXZXUjANzVcOt1cZjgIrBAlo2XQ1hy8xpnO/sQTpMbAvZCOpw0YgfIiFfaBQSCzxi96RtSdxZAHblJMC890FeQsoHHv41Nk4SS7eCIU/yNhu2/UrUVihB42Qqr28gy/QzHJouvLRI90e7wCSSY0ucSKR1XnAI8Ljx4NllqtCUJvH5Xyi8w3z+I3Bc1fpKniWzY0JTs6R08JSIfPL5x4FhYj/c92PJpWJtrcTza0M2j1iBL3Br3BdI34L56D1Jn2ih9yGBKJImu/hORqQ0LlKmubFOG/4Z0PDKLrYS1kGBTBJrtWwJJeYZfpsTWLn7k4S8jyR7j19+AIMtgWs0OoMJFwJ8rhN65ZdCflpsmlHlLbwMqALYNwAV+TiwG9At2CCx7dlXWB
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 04a733bb-cf9d-43ac-7c5b-08dd3f7a1eab
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2025 08:59:48.9107
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: opDBNHzvqV5oHKQTKdRC4zqvLCbn+UGBuEStQx+odSeqhuGbu1JhZUogDE9sZmPhgGExNpdRsS8+Mxy0tvu6+gV1aIRrpXQ+zXuz2hNxXgw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR04MB8068

T24gMjguMDEuMjUgMDk6NDUsIEhhbnMgSG9sbWJlcmcgd3JvdGU6DQo+PiBJIHRoaW5rIHRoYXQg
RGlyZWN0IElPIGNvdWxkIGJlbmVmaXQgdG9vLiBUaGUgcXVlc3Rpb24gaGVyZSBob3cgdG8gYWNj
b3VudCBkaXJ0eQ0KPj4gbWVtb3J5IHBhZ2VzIGFuZCB1cGRhdGVkIG1lbW9yeSBwYWdlcy4gQ3Vy
cmVudGx5LCBJIGFtIHVzaW5nDQo+PiBmb2xpb19hY2NvdW50X2RpcnRpZWQoKSBhbmQgZm9saW9f
Y2xlYXJfZGlydHlfZm9yX2lvKCkgdG8gaW1wbGVtZW50IHRoZQ0KPj4gY2FsY3VsYXRpb24gdGhl
IHRlbXBlcmF0dXJlLiBBcyBmYXIgYXMgSSBjYW4gc2VlLCBEaXJlY3QgSU8gcmVxdWlyZXMgYW5v
dGhlcg0KPj4gbWV0aG9kcyBvZiBkb2luZyB0aGlzLiBUaGUgcmVzdCBsb2dpYyBjYW4gYmUgdGhl
IHNhbWUuDQo+IA0KPiBJdCdzIHByb2JhYmx5IGEgZ29vZCBpZGVhIHRvIGNvdmVyIGRpcmVjdCBJ
TyBhcyB3ZWxsIHRoZW4gYXMgdGhpcyBpcw0KPiBpbnRlbmRlZCB0byBiZSBhIGdlbmVyYWxpemVk
IGZyYW1ld29yay4NCg0KRXNwZWNpYWxseSBnaXZlbiB0aGF0IG1vc3QgYXBwbGljYXRpb25zIHRo
YXQgcmVhbGx5IGNhcmUgYWJvdXQgZGF0YSANCmxpZmV0aW1lcywgd3JpdGUgYW1wbGlmaWNhdGlv
biBldGMgYXJlIGhlYXZ5IHVzZXJzIG9mIGRpcmVjdCBJL08uDQo=

