Return-Path: <linux-fsdevel+bounces-53896-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4FCAF87F5
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 08:26:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705B1587E70
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Jul 2025 06:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 755062459D4;
	Fri,  4 Jul 2025 06:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="DjFh0OnG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="jkjURPgU"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBA431DE2DE;
	Fri,  4 Jul 2025 06:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751610359; cv=fail; b=b3zUrF7RWoQ6Nnb5uL/Ir5S38E0UMjLQ6FLWyb+g9CVl7dW5JmJfjxDPcWwfJUNXNwAgFdUDlbmKySVak3sFtNFiHVu6/VhB4f8XhdByW+At2EJIGc+u/1kEOZVP04YRxvzEiiYzWybe3vkMk9MNqX8AS5lnQf15l5+D6MmN6fo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751610359; c=relaxed/simple;
	bh=iQNQ/NZfm1ALQ58dbyzWte/vCioszDYut7leWLCWr20=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=eT9PO1cFxe17A6YjTn1T0BU3d2SwCkB93f6mLxFxL6yIVllLCxJD0gnurdoB0ajA0yfJS5hc7JgBvjJt7faPyYqQ2n+IC7iOsbW6I5CFkgD3mbn9VcU7lfqgax0XTqcLapYg23HbhGmpZSBNLk+8O3R9gzcc0UwFBOouaRyicXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=DjFh0OnG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=jkjURPgU; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1751610357; x=1783146357;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iQNQ/NZfm1ALQ58dbyzWte/vCioszDYut7leWLCWr20=;
  b=DjFh0OnGVJ6On8cyHb+r/9doZhdah7jY/987JDS2iJ9ZJMTPZwh3XCN/
   k5RST5NgH5CxDB0B/vIAWaIGsgCdDebwdokbQQacikzILpOZ/YKLQMpfE
   e1+50ONfmBO+Gn33mSowuPWDrLqeXSlw8EDCw02GWgp8bV+vE88vBWQRF
   mYRYvQwIuP7DjkFP8NwzmsHwTlxNLd7WHQvjAl+kh3tIvMYA//Vb5mmxe
   CLWff4y9KBHRbpECjz2AHD8xYzIaPXIp6e6h/iiL2wPZY3DfnBK2Oif7S
   w/4UqCx2P56y9PHvi5AL1/BctXhUdvqyH8/HSW3Ftrtji5LM/mxN3cGId
   A==;
X-CSE-ConnectionGUID: Y5jI47sbR3CLCtw0j/swHw==
X-CSE-MsgGUID: S5/pSrSkQJuWvdgxiwUaEA==
X-IronPort-AV: E=Sophos;i="6.16,286,1744041600"; 
   d="scan'208";a="91845838"
Received: from mail-mw2nam10on2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([40.107.94.46])
  by ob1.hgst.iphmx.com with ESMTP; 04 Jul 2025 14:25:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cgwys5peaJ3Y00tAX0O0YrXEv7uXJW8SmPfbx41MTMobmL4d23Gje8EO9J+GcCqhqaKw9CvyzR0q09WGo/VC4oTB0+H4zjk+VDAc8/V24cyHwEF4xAkIkyUZP/Oc5N7fp6vx7+583FcMb15S2eFDEGsXGK5pl/kzIZuKTlFvJQuNrPRivinSvvIpfHUfZw9riVNW9TE765/LO3NM0/4dcf1aLuuLb2m1gbblc+u6+0lGK6KlMIkDq6dBptM4Wy55fhr/BmOR7S1b7RQj1zLM+ZRd5WiS62M03Uwv2uqQufKm+etIsjl6RelyE81Ew9ExhNqIHEtzrBrPH2xQILkAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iQNQ/NZfm1ALQ58dbyzWte/vCioszDYut7leWLCWr20=;
 b=Dx/EODg0/2WbmRbATmhljZGptdmmapLGNsng3umXaV66MwM9OcMmnCYY0inwy8k9/JNiBrjTMVAkoMf8SarW1hucP0Vzg8Uy+LwgnRexxdMOpcF302ihW4ew+ZikegW9ML44eZGVYiJgMfFnqH53+wGq3WlbBYKh1Fxg7wc/1qtr1A+VbzPdyDuk4PWQMflXneSlSIletM4OMdSN8jyCzawZy6avF1Rg9foCmF3cTrMNFJuYfHpoylIF7ZhtSYCnSQ1Nwi55yMrCwbR1cv7nVmhg8rzP1jGQikU0/joOnTU0EvkSsEL4oB0wgFqQfm7NfhY1TkOqXB/1fDT7Zcm5VA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iQNQ/NZfm1ALQ58dbyzWte/vCioszDYut7leWLCWr20=;
 b=jkjURPgU2PRNZ6PhMuRg6yA/UiCRBQtUGetq4KC0nv11h+OV0olRM434FS+UYiDU732Tel0aCfabLWvq7ooYaRuke0SCIIGlRO39s7QAbo90ItClP76ZNsCLD+zmzw1GdBWYpY+QTXnTRpR2XyhL/YF4a8QMMYVu2VyuxOLZ91E=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by CH4PR04MB9387.namprd04.prod.outlook.com (2603:10b6:610:236::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.38; Fri, 4 Jul
 2025 06:25:49 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%7]) with mapi id 15.20.8901.021; Fri, 4 Jul 2025
 06:25:49 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: WenRuo Qu <wqu@suse.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>, "brauner@kernel.org"
	<brauner@kernel.org>, "jack@suse.cz" <jack@suse.cz>
Subject: Re: [PATCH v3 5/6] btrfs: implement shutdown ioctl
Thread-Topic: [PATCH v3 5/6] btrfs: implement shutdown ioctl
Thread-Index: AQHb7HRJS0FtsZjqqk+8nuA4xqg6qLQhgA0A
Date: Fri, 4 Jul 2025 06:25:49 +0000
Message-ID: <eba400eb-645e-4aee-9074-5f561b1baead@wdc.com>
References: <cover.1751577459.git.wqu@suse.com>
 <b2e79c1e16e498b9eb99447499a0d8a353ff6d21.1751577459.git.wqu@suse.com>
In-Reply-To:
 <b2e79c1e16e498b9eb99447499a0d8a353ff6d21.1751577459.git.wqu@suse.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|CH4PR04MB9387:EE_
x-ms-office365-filtering-correlation-id: 8e780f14-e226-4881-d39b-08ddbac39e1c
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UFZ3bWlYVUpWMU5KbWg0TERwQy9kY01idzhvU3E1QjhzV2laeDFiMTcyanQ5?=
 =?utf-8?B?OU1NTEdjYVlFbFRMTTRwK1ZFaHd5WnJ5R0h0OEdzWVBUNjZkNEZJMjFobVI4?=
 =?utf-8?B?elAwU3ByaXJXTXVnOEFTVXRZNk5vNHdVSjRkL1VCU3dRVkZ1M2dOL2dBT3FC?=
 =?utf-8?B?ZEhEWUNGOUFKWS9UZUNGQ3ZDNTF5L3llaHI3WnBhblpkLzNyWTlaaDJOTEph?=
 =?utf-8?B?WDVHMy9iOURlODNFcUk2djBqaGJvMkQ2RzhXOHdTQSs5NURjbWREckxEM2s3?=
 =?utf-8?B?UzVmVWs2a29pQ3hQMWQ0TjhBZE54UHh3MDFTdDg3RGJTbEtpcVoxQi9KSVkv?=
 =?utf-8?B?bDFBS0lyNnVVS0lXdXdUcDUwb2RHVmZmemNROHBRZW9XUHNUSkZBVHlLYW5E?=
 =?utf-8?B?bWFUVlByUUo5ZWRZczZPR3B4MkR1TUxHUll1bk1sdlNNK28rb085ZERSMXh5?=
 =?utf-8?B?UEVlMHJkQXR1WlJuQzVIMTVpVU1zRG13WGRvQlBzaUs5WjFMdXZobElNaGtw?=
 =?utf-8?B?bmNDZXBEdVJpcEVSbHpXWUNrVnY1UGcvUFVCZTdueHNlVlFOV2hMeDJ4cGZh?=
 =?utf-8?B?Q2hkN2gwMzI4VjlDTzY0ekFjTEowYUt4a3VYYWljWk8zejVLVHR5Qm50b2NI?=
 =?utf-8?B?Zk9sdncwSFMrditYN2hrMXhKbEpzZkhnMCtxblhYN0k0MDNtRTN1UGNZK1JF?=
 =?utf-8?B?dUkzNW05bzBOU0pXS0lpZVF6VUdxK2txdnl6Y2JYZURRZm5odU00Y01BU0Fo?=
 =?utf-8?B?RE9LS0lLaU90TU9iZmhtb2xNSFl4WWM5czhRR09RdFNoUWZWbVdpcWJGKyt3?=
 =?utf-8?B?VTNnOXI2eUVKSjJYVDdiMnB0SXJ5Vmw2QW1uTDkzc2daTFg5UjA2aEx4SnJt?=
 =?utf-8?B?UDJkN0V2OFNSbCtsWWVOMU9najVRZFIxcDdqWnRpWG1ZYlBBZmpTTWkybnh5?=
 =?utf-8?B?T0xuYys1QWhxMWw3MXdNR3VyTk5jOGloZmtuc2ZBTmtUZHdoMXFjZWt2UWdw?=
 =?utf-8?B?ZFMyUHRlNXNvWnlpVjlCK2VzRFFHYkJ3cFZCWXp1N2htZ2ZUWXFEdE8vSVY1?=
 =?utf-8?B?MlFxR1BCVWJxNlQwQnI0cFFlK3RDR2JmSGczY0FRZ3E0RXc2M01XSXdDcW1O?=
 =?utf-8?B?KzUwR1V1NmV6OE84SDcxcHNCOXE5YkFzbWc4ZGNwRTJvQ00yVHZHek5Kczlk?=
 =?utf-8?B?ajFNbjJDQmNHNi9mUm95eEw0SXJDV2RJY290RTByT1VybkQ4eVBsTTFycFVI?=
 =?utf-8?B?MnFpSDhPSnNNbXZUY3FmWEVtSGhlbXdtK3V6RUIzVWZVaVJ3M1Jxbjg2QWxs?=
 =?utf-8?B?b1k2NElGdFBpRmYvSVJUTHFLdGFmTW9TTkFTS0NWa1lya01WMURmODd5cEo0?=
 =?utf-8?B?QkNFNnJSUncya2ljSHAydFdFaSt1b1RzdDNJYTNjb21xSmNHYWpJemt1RXkz?=
 =?utf-8?B?YVVPcncvbzkweTM4REc2ZVRmM2RsL2lpa1hCbnpCclg5bUJ2dDRoVVJFb1hP?=
 =?utf-8?B?YitNUFEyK2dJSjNmKy9CVjRxYk9WMkhpdE5NbkhSVWtGNHlqRUFxdXFKSm1p?=
 =?utf-8?B?eTZnMm94ZDVrNk5BNnJrSEdtSEMxYkNyTzBHQnZ0aVlMTW9lTDhRVk1PN3dQ?=
 =?utf-8?B?bHBHWXdwWXpOc1N1WjJ6d3VGZXhlOEdBVXZzejFXMjAydWVtZVpDRWhVcDly?=
 =?utf-8?B?MmtkREhySU00V2t2RGdCS0NGZytiN1RROUNocTUvMGVSRzFDQi81djJtcVpq?=
 =?utf-8?B?YXdUVjJWeld1ZER4S0VNS0lTb1lBL2RkcTBLL1kzTnhoRU93NTVCR1NQMUgy?=
 =?utf-8?B?VnRPTEdERGd3MytCaUljZ0FvRDBaVE5heXhoZDF5eTJxYTNYSGs5aTFMOEx3?=
 =?utf-8?B?TWhhc2lQdnNndlJCaEpVZ3NlcVJEU3dvQVNLL1BtWVdPRlhCSkpsL0pMdDNI?=
 =?utf-8?B?QnRyMzRubzR6Tkhua2p2OUF5K1JLbW9Kbkc2QU5tMTRRbSs0cUluYkdvaWk2?=
 =?utf-8?B?a1lWUERYR293PT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?azhsNXZmVERSdkpqenFsdjE2TTJIRXhsZmVTSUdWQmNIU2tlYkxnVHdicWVq?=
 =?utf-8?B?ZDhwUGNQZWx5YjZOaE1HZWNyaDREdlFFWCt2Qi9UZW9sekFTQXBHY2JSaGVv?=
 =?utf-8?B?TEh1d2h2QmovUS9Yai9Pc2dldzMrMUttVWJDWnQ3cUFVUmt1alpmbUM3bk5p?=
 =?utf-8?B?YnZERko0VCtyMkp3SHg1TUFSOEFvbUtjekFURXRsK09QWGhYc1UyNFl2Z2Mr?=
 =?utf-8?B?UWRrSUhlSS85aWdVU2xXUFh3Y3FuczBZa1pKT1ppQXNVL1ZQTkNjRWlHRUMy?=
 =?utf-8?B?Z2hvUFhNeHFUVTh4clZ3MUZlbUN0dkc2S2x1SFQ1ZkI1NVJJZ21icHppSW5h?=
 =?utf-8?B?aFFBS2h6bHU2bHNDK3RsZkJ3SlZNRGx2RzhHS08zWFZuZXJYNm1qWVpFcGN0?=
 =?utf-8?B?N3doVDFoQThQekh5b21PajhXN3d5amprcGEwcTl6dkZGUzZZcmJVWWpXMTU1?=
 =?utf-8?B?UDQ4ZU53R3V1NVdtM00zWGtnK3p3VVJxTXBDd2Z6M2ZoV2FzSXB5dS9MZFht?=
 =?utf-8?B?TEJ0Unk3Zlh2UkRNL0pPNDRJTDVhb3Vob0Q1UENVNzR0LzBiMTB6c0JDckFw?=
 =?utf-8?B?c1QwM2hJZVVPZjd1ZFRjZkEwMTdUNXp1MEJwWi9FZG4vbEhjM29GYzNvdXEx?=
 =?utf-8?B?T0x5NmRDc3AxYmxGSWpGMDdHbTJqT1JiODlPUm1UWVNINDdjSmxtL2VRSlln?=
 =?utf-8?B?ck8xZTEzYVBiSm9hZHBBKzZBZnkvd1VYNnR4TWFqSWtCTGFaOUl3ZGRmWi92?=
 =?utf-8?B?TlN3dTlyVHllZTlhNlYzRWdZTURTNzhJNlpoNlZsNUhQWlFXYWRHSUt2L09l?=
 =?utf-8?B?cittbHA4MHRGZHdZR1BrUHBZcmRjZ3JFOUZQY0dJTWlGb09MbWJ1alloUjFS?=
 =?utf-8?B?a29MWVAzZ1hzYVREU1JYd2dkeHBub1FMN1BRK21JdjlqVHhyQVRUcGN4OG9B?=
 =?utf-8?B?WDdxY0NGZWsvbE93WGdyRnoweWQ2U1hDbjFSaVRnSG42RXVwM1J3Vk9VNkRw?=
 =?utf-8?B?S2xybGFhVDFVR0VwbHZNcVhVYStRYjkrcW01N0pCVzZlaXp5M1NxOW84NTZo?=
 =?utf-8?B?Z3FUbUROcFpjZmRqeXdYMzFEWTVUOWdzWlpVNjQ5aVViYzc0dnVwMmtocksr?=
 =?utf-8?B?K2c1RXNZK29HT0VhSHZjelNSS1dFMUk2VGJhRit2YlRrQml0aFJBejFudW1Z?=
 =?utf-8?B?YjBzajVnOWxCdEgzM1Z2MmFyL25aQ2d5cWh0bHdRV3ViV24xRDBCUy9HT2gr?=
 =?utf-8?B?Um5RMDZnbU9kUERjNzhlM0F0SXZBUkpTUEQ5Uy9TYysrN3cwSEhKL2JJZlhB?=
 =?utf-8?B?WVowUG02aWtTNllJK0dUWWkyNVFuU0ZrTDd6cTY5ejIwcy8rMmxzVHdFTmI1?=
 =?utf-8?B?R1pDVW5memlrd1RYdy9HZXlwL2UzRHZpbi8wVzFSQXBWWkYxbDJST2ZuLzZl?=
 =?utf-8?B?QUhUQzR5ZENMQ0FOTEtxSm91d0dBcGV2MGMwYlM1K29OUG94SGdmSEkxRThU?=
 =?utf-8?B?dW11UnIrMnZaVFVxVVZ1WTVvOGVaMWhydldWekl3R3U5YkwyWWl0NlUva0FV?=
 =?utf-8?B?OUI5VE8xK2h0QU9vbmZ4ZHZ3OWgwbTk4OHNOWE5QWlFDb3FkRU54WTZBRUgy?=
 =?utf-8?B?ZmgvdFNreHZBT1Z2RFZRQXJhS0lrS1hPdlBoVWhQSjNuTkdueTZwVUV6Zk1E?=
 =?utf-8?B?Ujk4RUpsc0F5NWljZFR2NGhObGVlYVF2Y242dTluWWVsTlNzSkdtUm1jNStD?=
 =?utf-8?B?NHd6UzA4ZDUwR29UYTFRVkpmcExla1hBSFlJS0hFSTRzbTVZTGZWVmFzSFBw?=
 =?utf-8?B?OTF2YkpGNEYxanNGck53ckV1NkRuM3JrWVJYdVkxaDJ4a25TTC9MWlgwek9j?=
 =?utf-8?B?dmJsTlFDdjlWUXFLSmNySEFBSGRWZXp2K1Vid1RVWkJ2SEMvWFI5c1lGWDRi?=
 =?utf-8?B?ak1Zb05YblpDamxJY2VDTk8ybXE2amVDRHJpV0JiVTB6L1Z1YzdDRktnMzg0?=
 =?utf-8?B?a1hkRFUrRGdqZnY5RWVUWjMwQzJjZ0xBMDdzL2g4Y3dBTm84SC9DVlhBMVRa?=
 =?utf-8?B?TmxqUisyNytxWmFTVGErajM2MUJGVWFMdXAvZUp2VUgrckVTczVERktMTHF3?=
 =?utf-8?B?Y2gyTS9UMlZaRlI3QTB1YS9IQjZodEE3ZXVOS2wvd1gzdXI5cGJyNkwyU21J?=
 =?utf-8?B?OHc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <350697F12C6F6C4CB03B66F9C491ED19@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	51dBmyW/HHAsZoFWZDY8hgTAOQ1yLc4xVufpyqe7Ms1ZFFk84zPuSceavpXmK86HGstFfXqPxuPzb+Tky+IhHDfPi1k3Y1Mu4JnRUlf5RdVvQa3/AZTfw/tdpY0kR54w2TJEth41HvsmKNqqzCZxfUxuyaLDvJINisvEPBxNzj44TDVoXR8C2p5QxTWk5m2ZtzH7TlbQ4txBpiCFupa0ZfRl5gyfeuOvN/077mXxhrkf6lT89olFiwLXjRkle5KwBYZZKY6BaKlDASvHjn027sn2HWL3xhHMfvSE1hOVL2tyQqpcSajiLWlwRahPZxRY9BSB8+kSwrjVKJxrXC1OY/uIy+0GzCjjlMJ6GvQyACi2RELdl9qc0QMEACxomEEBAaRUtJJPNWtPrSF58AhEbfg48M2G4rCaqwH6jWz/Uy33TZKhCKuf8hiG9F3fqffkDKHxfcXKriTbC9iGuRkvW1vx6piEa+nImAh+cg2/GI4R/8drxhf0LCYAJFC1CKwRKlhix9WSaERryhh5CY6ZJDzkkRnzyM0vg0ToVSgjUV+gCC/YCFc/2amf1qLvdUbwNBvS+UL6lnVj/aNTswu/rAr53AVpn6M4NQX3R/fAQ1nr1irEHOb+J595y1clgIj3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e780f14-e226-4881-d39b-08ddbac39e1c
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Jul 2025 06:25:49.0190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zPJ0t2JxudlnVkIQVV9/nowEGcrgZRIGPx9iZaSfK3qyr06mRTBhJHz0KXSv2IimeGBwC4o/x1crZ8aTi06rXm+Bk78T/NIir/D6mlfLnWs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR04MB9387

T24gMDQuMDcuMjUgMDE6NDMsIFF1IFdlbnJ1byB3cm90ZToNCj4gICBsb25nIGJ0cmZzX2lvY3Rs
KHN0cnVjdCBmaWxlICpmaWxlLCB1bnNpZ25lZCBpbnQNCj4gICAJCWNtZCwgdW5zaWduZWQgbG9u
ZyBhcmcpDQo+ICAgew0KPiBAQCAtNTIwMSw2ICs1MjMxLDggQEAgbG9uZyBidHJmc19pb2N0bChz
dHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQgaW50DQo+ICAgCXN0cnVjdCBidHJmc19mc19pbmZv
ICpmc19pbmZvID0gaW5vZGVfdG9fZnNfaW5mbyhpbm9kZSk7DQo+ICAgCXN0cnVjdCBidHJmc19y
b290ICpyb290ID0gQlRSRlNfSShpbm9kZSktPnJvb3Q7DQo+ICAgCXZvaWQgX191c2VyICphcmdw
ID0gKHZvaWQgX191c2VyICopYXJnOw0KPiArCS8qIElmIEBhcmcgaXMganVzdCBhbiB1bnNpZ25l
ZCBsb25nIHZhbHVlLiAqLw0KPiArCXVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICAgDQo+ICAgCXN3
aXRjaCAoY21kKSB7DQo+ICAgCWNhc2UgRlNfSU9DX0dFVFZFUlNJT046DQo+IEBAIC01MzQ5LDYg
KzUzODEsMTQgQEAgbG9uZyBidHJmc19pb2N0bChzdHJ1Y3QgZmlsZSAqZmlsZSwgdW5zaWduZWQg
aW50DQo+ICAgI2VuZGlmDQo+ICAgCWNhc2UgQlRSRlNfSU9DX1NVQlZPTF9TWU5DX1dBSVQ6DQo+
ICAgCQlyZXR1cm4gYnRyZnNfaW9jdGxfc3Vidm9sX3N5bmMoZnNfaW5mbywgYXJncCk7DQo+ICsj
aWZkZWYgQ09ORklHX0JUUkZTX0VYUEVSSU1FTlRBTA0KPiArCWNhc2UgQlRSRlNfSU9DX1NIVVRE
T1dOOg0KPiArCQlpZiAoIWNhcGFibGUoQ0FQX1NZU19BRE1JTikpDQo+ICsJCQlyZXR1cm4gLUVQ
RVJNOw0KPiArCQlpZiAoZ2V0X3VzZXIoZmxhZ3MsIChfX3UzMiBfX3VzZXIgKilhcmcpKQ0KPiAr
CQkJcmV0dXJuIC1FRkFVTFQ7DQo+ICsJCXJldHVybiBidHJmc19lbWVyZ2VuY3lfc2h1dGRvd24o
ZnNfaW5mbywgZmxhZ3MpOw0KPiArI2VuZGlmDQoNCldpdGggdGhhdCB5b3UnbGwgZ2V0IGJ1aWxk
Ym90IGNvbXBsYWludHMgaWYgQ09ORklHX0JUUkZTX0VYUEVSSU1FTlRBTD1uDQpiZWNhdXNlIGZs
YWdzIGlzIHVudXNlZC4NCg0KSSdkIHByb2JhYmx5IHB1dCB0aGUgZ2V0X3VzZXIoZmxhZ3MsIC4u
LikgaW50byANCmJ0cmZzX2VtZXJnZW5jeV9zaHV0ZG93bigpIHRvIHNpbGVuY2UgdGhlIGNvbXBp
bGVyLg0K

