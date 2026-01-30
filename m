Return-Path: <linux-fsdevel+bounces-75938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPAaOjBufGkSMgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-75938-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 09:39:12 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22544B87F1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 09:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B3CC230046B6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Jan 2026 08:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC6A32E12E;
	Fri, 30 Jan 2026 08:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="G+CaOqPO";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="VNIVhwy4"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DF42DECCB
	for <linux-fsdevel@vger.kernel.org>; Fri, 30 Jan 2026 08:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769762347; cv=fail; b=Q2ez5SiEfkYHBEBY6cswMAowN1rZlrrRIKQKHiBB9v3XhXZDM7Ip+H3Z7+9JTmLtOFgxUxtjnaQIgGrfDxRnedji4pFjGlRJyIGVuagU9FD9izlYT10jRma35luZkklOBSbNOJ8aH6K02sh1pRzVSOpOL0IaabXvdQ09iSh3Pys=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769762347; c=relaxed/simple;
	bh=1EOJ3qQfOyZMkTtOPwSAxN/vUpWBc5yp0aPUXzTvoHI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dNLj9+TisIr8N695Slc4loqAQRHQ9IQelEvHSNPU7wTTaHQKHWmCqjobhT3XMaNWvzwVdqqiqXxLuXE/UiOdz1knVGpc8strE4SnPz49UI6VkpoxuNHHz+QxQVVvmqwNcAB4E5Vcm6UJpBt5bNIvtlRVN52cwqArCHuxlDYHYZE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=G+CaOqPO; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=VNIVhwy4; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1769762346; x=1801298346;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1EOJ3qQfOyZMkTtOPwSAxN/vUpWBc5yp0aPUXzTvoHI=;
  b=G+CaOqPOu7/Z2bF2de9OebiNNIFp67AdBFWYpSPluViBYaTbFW2VAQUY
   XMPcvfBt1B9Vi9PKkmi8CDZx5TnhQrg+97egsUdbamiXc6C1ohSfqXMpe
   jNRX1jSBT4f5pW4JVq9YxjSGLCXk+jPBygatdQYi6hrz+XgyobPKgkrkN
   DJvCC045DkxaDtDlkxcc2dlzPPO2jV3Z9p5pLMroH4jq63tmnmrvVjBD2
   d6K2051Rdh9p12L/XVJqqjqXf7NrWVvYSwAt50hfrrZaBHhBEw4PRRjWo
   G9crLmnTw/UFsNrWIVNpDRZ3E1G/z0MMHxkg3RqarWW+WwdUmaakwJgTC
   w==;
X-CSE-ConnectionGUID: rnRru1t9RLOmFxVMX+1JwA==
X-CSE-MsgGUID: nLoCieRIQEy8AFjp0M4Y+Q==
X-IronPort-AV: E=Sophos;i="6.21,262,1763395200"; 
   d="scan'208";a="139772386"
Received: from mail-eastusazon11012042.outbound.protection.outlook.com (HELO BL0PR03CU003.outbound.protection.outlook.com) ([52.101.53.42])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 30 Jan 2026 16:38:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eukYOKkkmbHUVWqEDEaRPnOLHujgjTZqLSWV/Dpwshm4a2ic5yXp5rnM3x14XdEI8KRuD0RlSyX9QCfpBbmhglvy9jOOHuXhm+vXJbKaUycx3v/KGR7j2i8N5uhZ1AjsYRqyWOQrlpEZ0ZlZY9wkEAPGThCqpKWjt7okUW/cBkhcSS5oKS5frLf4QALQlUM6intMnjufaMVmxuJpua+z/t6FC371N7SNTELj4zRe0vpLXaW7lRz3mtaqwzWFZWwPBAWbvkjwuO+FhSkoZdjBwZLecpyMIVDJjWVsA9FwkU/lgZHPcWSbQ9d8XjxCI1QwulLOMDq8/PWAVmMJCHfKGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1EOJ3qQfOyZMkTtOPwSAxN/vUpWBc5yp0aPUXzTvoHI=;
 b=aIPmtar//75fcxNVk89dNgM8v5WXYmW/sS3lXocQgr+Yn80JlrLLD9z1Y3EJPiiz6DgcB2RsSfH5XG9Db7OByk80e79mOTbA09GWD9YFkkbtNkiylGqBlLlDeajM9XmqyS6x3l4Gc6o34kStOwODF1R7/bKwAwBkrOW4V+Ypsh0bJ7b7rkPMTP0HLY4XROq+dTMleTHYWg0lRtMVur9aFdBCms9U/zCfxKSCryixcqa1anV62tEtYKc44/uodxGl9L/Sa2vN26cDJEsVjR3L475eNqthroVdXzoWk9K9qGw5outnY4bKrn8XQ3r8ybwGFNe5M36is/oaGkzrF2xlqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1EOJ3qQfOyZMkTtOPwSAxN/vUpWBc5yp0aPUXzTvoHI=;
 b=VNIVhwy4vrel7YkciPanC3bBg8m2/0P9rnePje9o9FmPQ/Pdy5aLNi/35/7y7R8oRxDdk0QgWkjzJWUKcDqgkX3hSKIsjyDrJe9fC3v6dwo6E8tWX7A1XwFmXOGvjDCGUi7Q4UuLRFMnkoqapkS0J1qdPSS9gUNYbF16xfVd2No=
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com (2603:10b6:a03:557::20)
 by IA3PR04MB9499.namprd04.prod.outlook.com (2603:10b6:208:503::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.10; Fri, 30 Jan
 2026 08:38:57 +0000
Received: from SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::2209:bd98:89ca:9421]) by SJ2PR04MB8987.namprd04.prod.outlook.com
 ([fe80::2209:bd98:89ca:9421%4]) with mapi id 15.20.9564.010; Fri, 30 Jan 2026
 08:38:57 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Snaipe <me@snai.pe>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>
CC: "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [RFC PATCH 1/1] fs,ns: allow copying of shm_mnt mount trees
Thread-Topic: [RFC PATCH 1/1] fs,ns: allow copying of shm_mnt mount trees
Thread-Index: AQHckUZBQBlr8/79K025dKByB3nheLVqZTKA
Date: Fri, 30 Jan 2026 08:38:57 +0000
Message-ID: <60f683fa-bd25-4656-ae53-fc247962bac7@wdc.com>
References: <20260129173515.1649305-1-me@snai.pe>
 <20260129173515.1649305-2-me@snai.pe>
In-Reply-To: <20260129173515.1649305-2-me@snai.pe>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ2PR04MB8987:EE_|IA3PR04MB9499:EE_
x-ms-office365-filtering-correlation-id: 83fae997-0e44-46ed-962d-08de5fdb026a
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|366016|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?dnRXdGxrUVpRTjllS2s4RFJiSHBYUlZxdytDblh3Y1NuSCtuekNGMHFWU1Uy?=
 =?utf-8?B?MVpTVmQ1SGdBZ2g3K1B2UTFZTHpMV20rZnZNM3A5Z1VWdDh6b2NMVndMV0po?=
 =?utf-8?B?Wk9WUlhSdUhMMmdMVWFWdVhjNFk3VjBFUkZUbGU3ZW42TjRkVDRDSThHK3FV?=
 =?utf-8?B?b0pHWnFBSmJocXQ5Wk9taS9SUDVwQ0NESmNVR2Nqcmt1VWk0eUM4L21DeEZp?=
 =?utf-8?B?NTU5VjdqWHNTcGd0eFBMUEhDOG12Nk0xR1pGUHJlSGpyRno1R2M2UXBWUjBi?=
 =?utf-8?B?cUdidXJEK0hIN0VydlRvRVdmdjg4cVIxSTZZRnIzNDVpb0wrYjBXNFR0ZkZv?=
 =?utf-8?B?anllbWdUYit0cndjQlpMWndxTVZqamY4K2xpNEVJUndTT3V1d2VrV0FncVFB?=
 =?utf-8?B?Um9EK3l3VnZDa096b0ZXTEV2VDVvck1OSGZRRzYzZG5rczFKZHF0SmhrWDFW?=
 =?utf-8?B?MXVmclZZNnNPdFcwaitEWUxLWmV6WWtjWVYwVzRSejRyS1hTckhXWE9FVEda?=
 =?utf-8?B?ZnoyN3BaR1pvNjc4TDZkOXFGL2RvL2NmYUtRYTErMXh3OXprNFZLcVc1Wlpq?=
 =?utf-8?B?bk51YkZQcGhNRGVsQStyNlZwRCtBcGxsQ1RnaEhIek9nMjJxNUFxRm93U0JZ?=
 =?utf-8?B?ZVFRU1JzS2JaWU0yYXpUb0NFRW1lM3VMeE5iWEdsQWF6dWhWUmk1KzFRSTlx?=
 =?utf-8?B?Qzg0NXdMN05hOEpJMWVKaTI5U3pFR25tTzJCUEM3T0pNSG0xWEtXVDRMUUJV?=
 =?utf-8?B?SGRQR1g1M0R1YXFtNExNTE12Y2o5YmdLWEZHaEJlSVRzSHFxNlljUHhKR1Jt?=
 =?utf-8?B?S0wwV2NsV09mTzMyeEZpMDY1V1hmS0ZqQWtLR2JSaGRrazE3Wlkya04rcGZs?=
 =?utf-8?B?UUZGTjEyOTNUdlB1SDhvVldWVmFrY20yT0Vqcng5Q3cxTEloU1pZKzRaY2Ir?=
 =?utf-8?B?QnE5NjMrRE1NU0hCbFlrdmRPS0tPSTd2RndpS1ZlRUU5cXlUU1p4cEN6S1cx?=
 =?utf-8?B?azhnQndqWEswUko3ZkNOVUVLWERFSUxqNDVHeFY1TnYwN0xEVFArT3dzeCtR?=
 =?utf-8?B?UGdnQitoVStxWlZ2M0NXRFRRZ3I2L0lUSXBDU0pRc3pGN2VnYVZYSWRyYTVl?=
 =?utf-8?B?Rm5HMll4di9wMzZHQUZUcmk5OTFya3UxTUtVdFhZWkkrOFFNTGUya1dkVWh3?=
 =?utf-8?B?WTZERGFCYTdvOGJzNTRtWmJDUkYvS0pSa0FWdUZDaFVyUGNGTGttcjhQNm82?=
 =?utf-8?B?L2M5RzlDZjN6dmdFYUc1Y2JhWkJyVVV4WE04ZTRzN2xQYm1heFFJcThaLzZS?=
 =?utf-8?B?S0N5b1VIRlllU0xucGVEVDV1dVgvc0s4WndydW1PQkY4SDV3L2pSOE9haG9q?=
 =?utf-8?B?RGQwL2pkNmhlMTZ0R1p3M2VKd2pQSmtFTXRwZE9TZC8yRWwrZUNZVFlycE1L?=
 =?utf-8?B?UVl0NzcyMEk4YkVkM3QwNEdOQ2s1WnczRXRJamoyeEZtVnZmczlHWU1aM1oz?=
 =?utf-8?B?NkpkVTNQZ09oRjdZd3pMaVBjOG94L3I5cHdrYitTc0ZRd1NsRHdjWVplMEsx?=
 =?utf-8?B?eW8rbGh5QXRvZVI2NGRTYUFiZlZDdHE3S1c3MFV2Vk1xcnp6RStWSGJ2M3Q3?=
 =?utf-8?B?dkNZeVFicm9FVG1BWndPdm55MFIwYnNYdXZjY1h1OG9NU2w3ZTh1L0dwRFJh?=
 =?utf-8?B?VzRMdmJWU1ZZN25wQzBMTGJCbjdxUnpQMWtTWloxL0xQWitTQnorclJsQTFF?=
 =?utf-8?B?QlRiYUR4c2gxemx4Ny9RM3ZnTWF2dTRUdFhpcS9JSk1XMTYzR1llRlErNE95?=
 =?utf-8?B?MW9jbGQ5YXUxcDJFdlV5anY5VFVhTU5zWE1ENm1wcG04RGRiT24xMzdMWDJG?=
 =?utf-8?B?eWd0TkVYY0UvVEZ0MFFqQmVSMXd6K1hhWGJCdndUQWVFRE52NzdLZDU3aEty?=
 =?utf-8?B?ZnZLUVNSbDRoQ0pVQ1M4VFJ2YzB0YzhldEhlaUJtcnI5N01ocTFUY24wdlA0?=
 =?utf-8?B?YVlrdzQwR1FTeUk4S1pmd252V3pVZVZ6M2ZGUXlkVU1vNVYybjBwUEhuUzFR?=
 =?utf-8?B?WCtzOWxrN3B1OEM3ZDdjTjJlSXR1U3JQMDlEUGFSZGhMbE1JanppcExCc2pS?=
 =?utf-8?B?QnozcVlGQUY2cHZqYnNvRXI1cjh5Ni9LR2JMcGoyK0lpT3VIOTNTcTRGQ0s3?=
 =?utf-8?Q?BZv9Z4pU6+wmIQXKdJuOSi8=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR04MB8987.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?eDVsZ2R1TE1nNUdqVzRTM25qZ0VCT0JQNkNMb2VzYjB6SForc3VVRUE1V3Vr?=
 =?utf-8?B?TXpVdDRLWWR4Y3VpeUFPZHZMY1dvcGJpZEZNcGlmclQ4em9ZTDdENlRQZWdr?=
 =?utf-8?B?NmIvRFBSTWVMbG5aVFpBZXEvaHJWQjV0eE5Xb08ycHp4dFFiTERhQU1TSzlK?=
 =?utf-8?B?dDEyaFlOZFNzY0dvcW9RZ1RsbVo4cU1adlFaZWh4cnpZM0ZITjlxQXFtYm9l?=
 =?utf-8?B?MlRjMGNpVjdnNmFjbHdveDVZZks4ajgzWE8zdHBkSVUzSERYVm5Tc0JyU2pj?=
 =?utf-8?B?UGtBTG5wSXBHb0RnQUsvNG9oaEV3emk0SjY1TTVlR04wam9icUhUSCtpUzlO?=
 =?utf-8?B?N0tSaEZPNU5NRDNVa3dSTlQ4ZmNWODkydFlVN0E0OFNtemJpWlZiMjN5T2d1?=
 =?utf-8?B?aW1xaGRXMzVYbExTdnVmZ1J0MlZ3cEZSYUxxZHhIZmgxMzZwekNkZmFmZ3Jn?=
 =?utf-8?B?bzVjZ0lDbWJ0N2xjODd4eGFUbUhQQjhqdWpkVjNDNE84Qk0wQXduRmJ2L1pl?=
 =?utf-8?B?N282bXZhbXUzdkxBZU8xejQ0cFVrRTBZc3pqZ054VExWTFZJQkdGR0F2TWFz?=
 =?utf-8?B?NVoxQ0tsMW9jL2ZNWlVlQytkSWRaMkdHZXluSmJXeFl1bEhBR2Rza0NmaEdv?=
 =?utf-8?B?MnVWdlZqdHdGeG5ncWYyQVBBN2REZlM5NW9WM01NampDRlhOeTFtMkRFMnc0?=
 =?utf-8?B?L2RBM3NmVUJ6TzBOMGNicWk3RWVnYVczdUJBcUVYK0pyMXNHOEtubUZuUkxT?=
 =?utf-8?B?TzlxSit1a2oyNjhoSVFZUG5VVmV1SmlQakJnNmdDYkU5WHl3U3Mwanc3RjRF?=
 =?utf-8?B?MllRd1RjUUFrRHpTVlVvQ05zOE9XV2o4Wi9VU0FEZ0FuY3l1Z0FIc05LUjF2?=
 =?utf-8?B?MDBLV0cxaG9GSThyeHVPUno5UjJ4b1FyN2hCM0JsMlFJZlZBM0lieDhZZXpV?=
 =?utf-8?B?US9lTEdJUnd0WFJtOThmdENFbXRJS1Y2ODFUWlVER3JBTXJCUEpnSjR5YUVs?=
 =?utf-8?B?TEY4bnB1aVNITnZoZTdxeVhFTWZFdHNJN0taelpVbVhHV0h5b3d3ald6MnJl?=
 =?utf-8?B?VFpvb3lxbWlDTHU3b0RJOGcxeTNyMzlXOGxQeWk2VTdSUzQ3dFBkTHFuQmNZ?=
 =?utf-8?B?a0JQUWNTTnBvY0hBTEtUVXVGZ2pIMmE4dWhFWG5SanFVVHpvU2ZsK3ErWXdY?=
 =?utf-8?B?WGtmaGJiYW5OR2lCZGFMQzhWWFZiS1kwaUZWU3Y4TXFmR2RDV2ZBSnhsS2tL?=
 =?utf-8?B?YzV3MHQ3L2FaSnBkSU9xU2JjM3FrV3BlQS9yKzU0ZmpNM2duL1VzUk9jQ0l0?=
 =?utf-8?B?ZlhoUnM1NVJsako4K0NrQnVsejdxWGJOK0RSdnRSS05oN1dwSmV5MGhzcE03?=
 =?utf-8?B?NXlBWWpRc2hmNjY2UFZSVmZJT3QyYXdHcGx5eUZBYk03UGpjdnY3THdoaUdB?=
 =?utf-8?B?YWZtNVc2MGQxNjlzdmx5ZHNuemtkRFJMb01HTWRta2VnTWJkVGN1NHdlOFFi?=
 =?utf-8?B?UWZ4cUplZ0JXN01leUova2FYdWFLOGE4UG1oOVhOaisyY3VBQ2I3ejcyODdz?=
 =?utf-8?B?VnV2WWJ1VzVnZHE0QVpBaG9UWWsxNDB4NVZYQTBoNjNrTEdHN3RMQUlWNlF1?=
 =?utf-8?B?d0F1eWRxY29OMnkrRlRZUEMzS0F6eWFmUjhsZElzL3ZEMm14cUt3OS9qMUps?=
 =?utf-8?B?TStmSGc0SUlxU0dGOVlJek1PQTZjdE5SRHlOQnBpbUZGNkVoenFMTVlEazRR?=
 =?utf-8?B?RGRmc2IweUdjUHpVZFZHRXk3Ymk4WCtWL2hPUjhUMXNqb2doWTFsOWFOMy8x?=
 =?utf-8?B?SytxYVpZczI1eFJWeXM5b1NHdkt1VCtQWkRQWHh1MVhjd1duc3I4ZTN3QXZ0?=
 =?utf-8?B?b200S2xwdnY5QUtFV0hXVzR1K3Z4Y3UwWjhtYWJ6czVUaWJ4bmtGMjVBbDFk?=
 =?utf-8?B?UGZiZmRHQWQ0cG4yc1plNUwrRHQrOXFJT2xCQWdZcm1Ed0lCcXNYVmR5WExI?=
 =?utf-8?B?bnJBSXdBLzF3amhIZ3g1aVFJQ0g5V2R0RVpRMXExZTc4NW5UOEd2SE80T3BQ?=
 =?utf-8?B?WW5DYkpYL0dyK1RDeFJnU3pTUVlKOXJ0RVovNDg5S2NFRGdpV0xNbWE4MVlQ?=
 =?utf-8?B?c1JmMkw0QVhodTAvRjNGdE9kak5GRkk1cWJVcnA3ajlWVEZNbVlGQzVpdTF4?=
 =?utf-8?B?b1BjdGxkZ3ZFS2srSWdzR053TWlLTlJMQ0w5ejlUYzRpQW9EbWJPY0t1Q2VO?=
 =?utf-8?B?TkMwMmpPeEtuVFNvd0NrdkdGZjQ1Yi9QUW1tcnVCeEc0cC9LeWFUSWtFeUE0?=
 =?utf-8?B?MEtNU1JpVERySHB3bWJXS1pvU2hON0owN2xZSTNPTXVra05MTXVWeVhucHhD?=
 =?utf-8?Q?nWsev4uYnnQ9U0yI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <31C5CA7140B4C541AD3D7D888C2283AD@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	Tu95grjdIcpm1VP8QXPL2+taCvijAzS7FEdK5USHpQXVqrURaqqR+DpqziwB462JOUnuEs0MciO3DF8VcVzIDpe4TwWT0Y4JHmKNphy4gxuAjAqLg7L6TdWMikzVhJQGiAbUpC5AkaUgbB6SCFGx4q42zOw2S34DjYfOMOTGhOIrYXXGd27dgw8RRMvkksAMCmjMCELy1svvnvhG/Gd707ljMRDj3S8kdYjXa/kzmFZ+us5wQ2OCnnBChu7jduviXtL1sQHmSZUwJxZ1OSB6G8v3nr01XLEREylVGJ6ByZ1HoF14PQPVcqnhrHjOtZoVVOZcvlSgVsgHPHFDDoQNKLzl2vzhnC1Cqdd1EPS+wz1JUf4hozhFee0kqlUmGZz6VVsEWQ4vtAIv0hOEqnuppzPvPVfTOzUkS81oiC3m/HAYgfULYwcd+cNILzAZpkXkVOIQcvVU1pl0P6GO2e+6CtBOz5ZS6T5Mjd4dXkBLN0WfXd4kF9X5i49R95xB4oTGsM8byiFr+8jdqlGeU9jHi5qDs9FHBRdrdXaw3zf6UWlZvMR43zcTDG2f/AU92OooeIjRIbzR+hnUferR0ILRcA+0uigz11h8Xe18AyYcjgTwX5zChI0t+21/qL6Dqhz7
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR04MB8987.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83fae997-0e44-46ed-962d-08de5fdb026a
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2026 08:38:57.5874
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PQAk7JFWrTFHQWl2wmi8/sN5/IbPD9HfEY7R5b3Lvma9vSL75w2DnTdpf9d/s589pCj0SaJ4SNT+Yl6QXph6RfK6aLW3sRTb/KZoK7aojhU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR04MB9499
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-75938-lists,linux-fsdevel=lfdr.de];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sharedspace.onmicrosoft.com:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 22544B87F1
X-Rspamd-Action: no action

T24gMS8yOS8yNiA2OjM5IFBNLCBTbmFpcGUgd3JvdGU6DQo+IGRpZmYgLS1naXQgYS9mcy9uYW1l
c3BhY2UuYyBiL2ZzL25hbWVzcGFjZS5jDQo+IGluZGV4IGQ4MjkxMGYzM2RjNC4uZjUxYWQyMDEz
NjYyIDEwMDY0NA0KPiAtLS0gYS9mcy9uYW1lc3BhY2UuYw0KPiArKysgYi9mcy9uYW1lc3BhY2Uu
Yw0KPiBAQCAtMzgsNiArMzgsOSBAQA0KPiAgICNpbmNsdWRlICJwbm9kZS5oIg0KPiAgICNpbmNs
dWRlICJpbnRlcm5hbC5oIg0KPiAgIA0KPiArLyogRm9yIGNoZWNraW5nIG1lbWZkIGJpbmQtbW91
bnRzIHZpYSBzaG1fbW50ICovDQo+ICsjaW5jbHVkZSAiLi4vbW0vaW50ZXJuYWwuaCINCj4gKw0K
DQpIaSwNCg0KSSBkb24ndCB3YW50IHRvIGNvbW1lbnQgb24gdGhlIHJlc3Qgb2YgdGhlIGNoYW5n
ZSBhcyBJIGRvbid0IGtub3cgZW5vdWdoIA0Kb2YgdGhlIHN1YmplY3QgYnV0IHRoaXMgc2NyZWFt
cyBsYXllcmluZyB2aW9sYXRpb24gdG8gbWUuDQoNClRoYW5rcywNCg0KIMKgIMKgIEpvaGFubmVz
DQoNCg==

