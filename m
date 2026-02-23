Return-Path: <linux-fsdevel+bounces-77956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAiTBelWnGkAEQQAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77956-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:32:25 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDFC176F5F
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 14:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 137D530C7EE2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Feb 2026 13:26:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C62031F4615;
	Mon, 23 Feb 2026 13:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GEzcddyh";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="Vm3FdNSc"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E98921F3BAC
	for <linux-fsdevel@vger.kernel.org>; Mon, 23 Feb 2026 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771853210; cv=fail; b=ovTaEVR+TKk+qW/VARQCEys/lVjBNah9qOMVwmgLWDyShNmr29IbGH5wpzUZ+1JrTUg/ixO8q/JSqcWGaa7CX0peDvMwtT2oQYJc/j0jI1zcnuVEaEW6ps/Lqzfcwx8TT1OS7z3T9bXOS4aWgjWX85VtkAL8ncdY52EcTxZ+00E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771853210; c=relaxed/simple;
	bh=ID7jua5OJj8XVCSecF5N9kIcKxYIDg8+h8vFWcr210Y=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=i60ccVlRnZt/7yEUxhPoxy/SLnMHGnpybiJtqFw3773wvaWto7vE1PG5VikpB8UHTDu57wMdNqi3lGHwWpMI9KDs0EUvADE9OlKPdWQuU6dUBhYtB4FDhu9Cx+1iL2YkvHXyC9PyVd1Edh0UemSdccfxk5W4u1r0CiYM0loR+4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GEzcddyh; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=Vm3FdNSc; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771853208; x=1803389208;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=ID7jua5OJj8XVCSecF5N9kIcKxYIDg8+h8vFWcr210Y=;
  b=GEzcddyhe/LO9jzyGjPrcNu059DaCs7oREP7yvHGpaiS9cpezBM6a0w+
   vCKrsbnp8nMPwEmHRJSO1qvaz5Yb6xqlW2h1p3cw+0kJNOJe9TjhFu29n
   +2B5CAM8SsRmogC+e3fHcr3km573v2eeNPkR766/KwVeyCuu+atUuiEJo
   Jb5OaCxPg7b5+bpYINTU+Gu6FuT4d+taoJooJE3PGGFkXtblSBRvUbGhv
   rYdD3zzr4HUr2uxOVjvRh/TRsMtSI8QXcWcw67uj3fZD6O8dDsaUCY8p/
   uhqgBRp4FZZz+B+9RsRtUXKDVCcLB6TuPfCtxrszsNILUCy+ENSqhyaJg
   A==;
X-CSE-ConnectionGUID: dWY9xXANTKK/BK9E37bqsw==
X-CSE-MsgGUID: x7/3S4WdSKWez3CP0aaWZg==
X-IronPort-AV: E=Sophos;i="6.21,306,1763395200"; 
   d="scan'208";a="140312088"
Received: from mail-centralusazon11011069.outbound.protection.outlook.com (HELO DM5PR21CU001.outbound.protection.outlook.com) ([52.101.62.69])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Feb 2026 21:26:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wASnoSRI02/YNKtQaEPlnRgrcKLpxedeX8HwUjA3geWYkn0d76GtwvG7cxQMxkYAl5v7tc0Xpb+aB2Y/ddSJc7ujLjfl50CLF+dmXXofneTBZ9xsjkYuJu2bmKI2JCCBWJPzkglyMUH7gbbOpZL4Bse9e676u5iwqqiK0BM66uTBj7HRsBV8lWweUcmYMFAUup9DUC1L1Yx8q5XhZWjp4QPNGXB/4kLXM3PUzPRpOk0mHXVz7uwH/mrgZIsQy9DCi0jQl+IuLDXH/+TJqTYYUUSVQU+l0+OX/mqyFRUGkOJfCrtEgjQlKSe9wop/QhnJBPxIlml37OrJLA8N+8/sAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ID7jua5OJj8XVCSecF5N9kIcKxYIDg8+h8vFWcr210Y=;
 b=rtYFNkyqV11rVTIQFu1KQQbmXau5Yv6PlM1cQtpp7f+g3G9gkKPI9PKB+NAXMwu/OICYGpMs6zAyNzEiYgb/ngHaNgRDvVxPU373LhtuIinUUQhYWL9QkihJWDSRSKjH92NrSXHo2UwXhVE98fKU+pw9Oi0Z2KfB/jeSFBvVirYYfeXeFoIi+0gNKkDLuuUfwxMfKElf0adMNEFXna4VIl5NMzV9NIcnWqfIXLBDlm2zkHgex+XF34dQUr7EBrJkMGCxeGwycBGUFrWOB6KNa0jIY66TPDHEkN5EUKPo5lzK2cr3ccx1Mv4JgA+hq5/XpIAeOQZJh9UcW6Ou6t1Vzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ID7jua5OJj8XVCSecF5N9kIcKxYIDg8+h8vFWcr210Y=;
 b=Vm3FdNScuEHuEi2QArIkqxkOXK4iekXdv1eD1yU2ZWSQZK6jFDGSFWR3Jh9d2sEiGnQhlMM8r1BUZbNpe+dS6HkGaFTO+rRnKjNlNPEtDHXg1ExcX/PRWp6RWAoIqYu1SuTl2nIzb9r9sByJ4bO7+8EuPKao5Z6Hw0uR//YNBVc=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by DM8PR04MB8022.namprd04.prod.outlook.com (2603:10b6:8:9::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.21; Mon, 23 Feb 2026 13:26:45 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9654.007; Mon, 23 Feb 2026
 13:26:45 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Hans Holmberg <Hans.Holmberg@wdc.com>, Theodore Tso <tytso@mit.edu>
CC: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, Damien Le
 Moal <Damien.LeMoal@wdc.com>, hch <hch@lst.de>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, "josef@toxicpanda.com" <josef@toxicpanda.com>,
	"jack@suse.com" <jack@suse.com>, Shinichiro Kawasaki
	<shinichiro.kawasaki@wdc.com>
Subject: Re: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Topic: [LSF/MM/BPF TOPIC] A common project for file system performance
 testing
Thread-Index: AQHcnCVy0zbMvpaPJEe12Y5TD3XDD7WInukAgAK3WwCABQGNgA==
Date: Mon, 23 Feb 2026 13:26:45 +0000
Message-ID: <5032694b-6b80-488f-bb2a-56fcabdc9847@wdc.com>
References: <b9f6cd20-8f0f-48d6-9819-e0c915206a3f@wdc.com>
 <20260218153108.GE45984@macsyma-wired.lan>
 <660844a0-bf83-4d3a-8fec-84c02b678fef@wdc.com>
In-Reply-To: <660844a0-bf83-4d3a-8fec-84c02b678fef@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|DM8PR04MB8022:EE_
x-ms-office365-filtering-correlation-id: 13c6c9d7-b951-49c5-361a-08de72df30d0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|10070799003|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?ODFiMFlDMXRmS0prVFduRDJ3NkpmSE1DMndrN29rRlJjS0N2MkR2L1dxYkkr?=
 =?utf-8?B?K1IwWWQzZnBEcUs0VFI0NWY2TFhHdVl1UVBaY0o3L2I3eklBRTFubnBORWY0?=
 =?utf-8?B?V01pRUdJNzhCa2xUVkt5NTFvTlhCT1RrL1ZONXdCZnIyK1NKMTlpMTE2eHNJ?=
 =?utf-8?B?dkVNTGFtVUVkT3FUa2VOcGQ4WlhqSUlTaU56WEEzSUFRbjhzanpKTkVwdUc1?=
 =?utf-8?B?Q212SDhNVjdUK3hwYVNUaGhvbTZFZ1JzM2F6aFJOWEtVVzlwN2diZ0hMQjhU?=
 =?utf-8?B?Q0RTQ3FycCtRMWVEemJZdkNYL09oai9TaHdnNmNVdE9MN3E0VWtEM3gyYm9x?=
 =?utf-8?B?ZnhhU1FRbHo0Z2xESVpUQjFRT281WWZCSnhKV1liTTZURUJWNW1pQU5aYnNV?=
 =?utf-8?B?dHdUY3lPNWdzODBtcWtSQ0I5TWUvVGVmZnNLaHRlNzduM2wrdUFiZDhXUFpn?=
 =?utf-8?B?cHFIRHFVRlN0c3F0ZWJRbURjZk1sWEh2T1FDcVVaSlNIYU9Fc0hvOHRMWWNE?=
 =?utf-8?B?SDB0S1BNM0xjRWdDWUVIMmVFSVFjWWxQVk53U1pnUXZIZkd4Sks0NndxSDd2?=
 =?utf-8?B?Yzdjbnp4OFV2cTV5RVFrZzJUZWNTbU8yTmVtVVdIV0U2QnBGdSs1cHdURi9Y?=
 =?utf-8?B?RzVnUHFiOXZ0c21tTmpKZytzU3EzNUtFZ0tvb3RFMXNMQWFXeFZQbTM4MDNa?=
 =?utf-8?B?eC9iaVBQVlVOd2N2S1A2OFFtZlAyL3lPRGVoQndRSjZLQU9xNFpvdzcvakZj?=
 =?utf-8?B?UWZINGtUcW1CeHhzcTNOenRWM3p0Q0NKVXliTXRzYUI2ZUt4VS9yMmtHOUwr?=
 =?utf-8?B?MzR3WHg4Y3U1NytUZ2Y4UGpaaEhPb054aEtjcDJPUWQ3S0ozYjR4NEVhUnRT?=
 =?utf-8?B?MUR5dWxBSlFDcTFldU8wc04xUDVzY2dmbitEQzRzbHRqbnBUdXZLaXJFMWFs?=
 =?utf-8?B?eFhLaXAyUDVSREkzVXNkWi9YcXJ0eUV3NXl6VjR2a2RDeVNsTDlZZWFiOVRl?=
 =?utf-8?B?dkMwcXppd3RZbWtQN0RzTVRScEFSNkN3dWRrRmovYVVXNXZPRlNtZWxiQ1Bn?=
 =?utf-8?B?emNzZEdsemIzZzQvZWdVRUhSejQ0bmc0cUtBdm5Kc29yWGJVUkVvUW83dlJz?=
 =?utf-8?B?eUQ1VG1YdSszMFhOSUhBVXk2ZWZMaXBlTUtSb0ppS0hIb1YxSFEzZ3cyZlEy?=
 =?utf-8?B?WVBaVkZxMGlLbFU1NjB3L2p3Y1E2dXk2Z2t5cVZPa1p1SGFVaVMxQXgwWnlZ?=
 =?utf-8?B?bjZLUU1sV0RZSEJJaXZyVUtYWXpNZCtzL1hLQXQvajM0Vm5ObjFBMGhwTGgv?=
 =?utf-8?B?U05mbjJBbzE3VVZqOURuY01oUDZSdlNvL3RFOFE4dVo5SDNzUitHcGFRTlhs?=
 =?utf-8?B?LzdBaUFWUU9ZbVg3OERuQnNSSDF2UysrKzFmQWFHQ0hwREZmc3J1cERzMXdq?=
 =?utf-8?B?QmNDM1lZM2txWDhuM0w4bFRMSGMyY1FOeExUMURMaE0zOStlazQ3YkdqSndG?=
 =?utf-8?B?VWNrbDJCL2ZHN2xCYlltdlRyQ3YxblVLeHNBVFpMc3RVT0JlQy9pMk9sdlR6?=
 =?utf-8?B?MW5pSVNaZXF3VXV0cGcrM3RLRWdQeDU3WkpPTzczTm1kblJOQlRaZUZ1aTlV?=
 =?utf-8?B?SEpkRzhtdFNaT1d1U1kzTmlMd3FEUXNnVEtMMzhEUXAvUnpHbVVtYVFWQTF1?=
 =?utf-8?B?K3lrTGl3dE5MQ0N6bUtBbHZ3d1BRSGRMR3ptd1dhL1N2Tld3NXFPeG5ZbS9R?=
 =?utf-8?B?RFpTNjZ1d1JrclU4ZGVHaFRCLy9JRWN3dTBDM3VXL0x2UTlXdGFwRy9INmxm?=
 =?utf-8?B?NVE5amJNNlhOc3M2aUp5MlExN3V3TkhHMEdTSVV0YTFJNytJQXpBOFQxTCs5?=
 =?utf-8?B?b3gwc2hWa1gydVJsYnlqcjdsZEduZ1kwNytHTUdhRmNQNHpMQTBUTk41cU9G?=
 =?utf-8?B?d3Byd3BsaWdtb1N6OEpsYytMVDMzQmpMTkR6MWhuK284a2lIcVA0ZGQ5YWxi?=
 =?utf-8?B?UktRSG45OHRxUmFPS1ovTFVwdW5LUXJDd1ZLM0psOWFIaG5ONFNIcFBOR0Ra?=
 =?utf-8?B?SHVpQmp2VHVQTlZzaGVEc2NlZmMxMDZGTGxpbkxUdjdDVGd4OVRBSFBmVFdv?=
 =?utf-8?B?MHhYZGZkSHp0T1BPZkxQM1R0N0ZYdTBraEZMYTF4K0NQcWFuWGpOdk5CY2pP?=
 =?utf-8?Q?Oe99HX04LoRJ33sD9dZkEi0=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(10070799003)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V3dFOXRoS3VDU0gxL1QwVXIvd3REMW11L080YXV5SXFKREtPS3NWMlFIOG16?=
 =?utf-8?B?bDBPRjNNejFFaDU3ZmozY3FVMFdtdWpqZ3dzdFE4QWQ2OFgzbXlWLzR0dEl4?=
 =?utf-8?B?VlQ0S2V5dENtVzExYlhQSUlLSnlVU09VU2MrODlkQVFOY3NscUpURlZuS2JQ?=
 =?utf-8?B?RmE2NFhEbW5RajY2VThZNFBTU2FsV3ozTlVlbzM0TC9zSlRIVzFBbnNuWVRL?=
 =?utf-8?B?RU5LRFVkWGpQUFZGSzh5SW9kUWFubi96RDhmUjh5dE9TbTcyNWVxZm9CaFcr?=
 =?utf-8?B?SXp1Tnk4VXRnaW5mbnJVVFgwcmd0cFZFeitvUmkzZVBlKy8vQWE0VThVczJr?=
 =?utf-8?B?ajZiTnljdklUVTNBeElGdGk0M2pvTU9SYWF6VWQySzQ3dnpaUEZqZ3FRS0RE?=
 =?utf-8?B?WWp2Z0RZK25XWFBHaUsydGYzdnBMSy96bkVrZWtsTVR5a1JVR2RuK1BzV01E?=
 =?utf-8?B?Q1Y2aU1iMnlPbUZ0bUEyZThTYkwya0xsWmN6M2JaM3JwTWQrOGxXRjRWYkI0?=
 =?utf-8?B?SWUxOXhxU0c4MWVXaG9uN0tiaklocW43cnViSHB2S28yeFhQZmE0UDk3OS9a?=
 =?utf-8?B?YUdXVXVvbkVzcXl3UCsyV0Y1WkY5MTVUamhHdEU4ajB0N293ZFlDRS9hN2NI?=
 =?utf-8?B?c0xYRHZkUVQyWnhtMldmR2NkUDd2NXNkTVlIOWRLRE1nNmlrZkhhaEVmUnRr?=
 =?utf-8?B?YWhnYmJkdHBMbE9OTmZIK1dmLzd5aGJjOUZuS1JNb05KZTFJQ2x3WnBwV0N6?=
 =?utf-8?B?Nmk0R3dLNXd3QVQ4VThNYmNDdmJObWs1VWROVTByRHlnYWJteTZCVWNmODRy?=
 =?utf-8?B?bUxGN291T2pCMXFvcCtic0VQSlBodjcyMllkRGdqRDB2UDIvWWhEYzBtcmV3?=
 =?utf-8?B?ZU1uUGlIcHNVZTlLeEJUR2JNNUF1TVRMaUJRemkwb2hxM29VdzFLQit3cWUz?=
 =?utf-8?B?QXBZUjhHcnJlMk03TjdmM2JNdlhHcW9OV3B0Vm41d3FtdnUzTFMrZUJFcEF6?=
 =?utf-8?B?T1JBZE45Q2RPb0Y4U3NUOEx5R1BadXQzWjUxTXMrVXd3SUxVZDQxZldRelRB?=
 =?utf-8?B?WFBWQ01pejd4S3IxWVdpNlBPbDFxdU0zYVByL3hpY0R5YnJ1QUVBMW5tZWZr?=
 =?utf-8?B?MWRxQzlLOXFMc0NGUUZsVXI5d29iWEtsczhPelR5NXJqTGdhaEVXUmdFSDJ5?=
 =?utf-8?B?YnltSmk4SUlyc0M5aGljYmhtMTFuSmpYbGVBVkl1dzE4NU1qVnZmY1ExVEph?=
 =?utf-8?B?OWtyZkJDbHYySTBVdUt0Z3pGTWRrTXRkbDhSZ2hUV2NQajR5UWdqV2F5eXVz?=
 =?utf-8?B?M3NldWR0cmJFV0NGdTF1a0U0ZlVtQ0VaZTY3Wmp5R1N0YUdXVzNXQ3gzaHFP?=
 =?utf-8?B?eVNMcGk4V1JFQmVnYnBmSFNCVytxK3o5MkxKRFBkV0I2V2JteEpsWXNtWUl5?=
 =?utf-8?B?dEt3eVZGWEVKQm9RZ0dWdEFoWE9Ed29JZ0RaRldQY1VIRko2R29HOFUxbXhv?=
 =?utf-8?B?ZmpmVGlIRERmYnpXVzRsMjJqM0FzY0dyUmdnYWNNSDNSQmgrelNhMmZrZWdD?=
 =?utf-8?B?RFNhZXJKTUtSeFk5VnhianRRMDdIbkVCMVJmZWE5ckhObzUrWWpQYlgrU0Jh?=
 =?utf-8?B?Q01aWXRuS0hxK2psOUxOeWxwdTg2UmVnN0c0ZGM3aFpvbHBkaVM2Rkc0WFlT?=
 =?utf-8?B?ZU8yay9udGIza3lYenBSM0xBUkplTUhEZzViYWsvVUxNbHAvV1AxbGJkUlVS?=
 =?utf-8?B?bEE2M29KT0FoaG4rRC9FSk96UGlBdkRGNEl3NTJoMGpZSUxSUjJ5YnlrT2hI?=
 =?utf-8?B?d2FQcHJwNis5TXlhUElSRE02Vy9oZVdqc0MxdnV0Y0o5bHd1OEhTRU5yakty?=
 =?utf-8?B?d3dKZkM3Njg2Zjd3VXRZUkFZL1g4MEcxaWdFZlVCVVVENFlOT3d6eVBlRkxq?=
 =?utf-8?B?Vkl6eHhkUjFpUjdqQXZSU1FXOUNsVFVxTkRjT0hWVWZUWHRaQi83T2x4cmE1?=
 =?utf-8?B?ZjhtZ2ZROGJ6NUl5cExWM3NYTVJVQVdSNE00N0p1M28ybDUxSi8wSnhyN3JM?=
 =?utf-8?B?Y1kzM3Rsc1lEcXczVFRsa3NNNnVYU0kvQmNISlJtS1pUaVJGYm90cXVQc0Fy?=
 =?utf-8?B?TUNNQ2VrVXgxQ2ZBRXBRUTFDWVk5Z0JKQTZJdUJxbklQblEvTDhRZERCK1Fp?=
 =?utf-8?B?eElLR1lyUXlaTTlxazNGV3drSWNrWEhvNWhBdXZ6ZDIwZEZYYmc2TE1UZHdD?=
 =?utf-8?B?ZnpJbzhhajZJRzlQN0lSY1BLK2NDL1hKZnZwZHYzaGd3QUlwTjlQY3NDdmRV?=
 =?utf-8?B?TW9uTXBzVklDS1RSamdDNEJseGhCWjB6OWNYdVFZODhUMndVZnhOeUlWZndU?=
 =?utf-8?Q?gYLr4H3hlOh1aJYPJiZ6owXA5aDSegdOhLkbZzlwuiGUy?=
x-ms-exchange-antispam-messagedata-1: CVkcsKupIKVsWz+8D2PZzgg7uUy9Hl+QHNw=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BD1E17EE66B220489FDC4144F31BCF09@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6hRBCLTSTmaCodf7eMuXi3FdjomrS8Bx0TWVlEGkWus4ilkwIdkWLC3XarwIRGt6gLGau/OecAWJq3oyPO4l3knUlkQe1LmLqeY5mpeoXPhRHVQipEmGOYuXOVKlu+zjXxFFgcl4iD1wkmN+N1rBfOtF3t/wyA51XOhmzxtZ//pC5s0iG+uGi8hKCdCzk1fzMshO8RfB2zl5p8SjVXCc6MtKMd/vpKRcZ5t0wiTk/E+rvE1AzbR4yzhnRItruEUWIG9F1TkDCo9vxoRcxJmMacg/GP/Ix1HlZssGzAe7TxYfFmP1yamr8jFJmR/MQW3cmSeQpp6SMf72wAPISP1pTK1sUQoyJBEeOkp4ZcJ5uB2j7HgA2feSPF03qRbrq6TcRTjoTDx8OyEac7arMrRjLCIZ2Q7s1i1kYMyfZ7RKEKkZpYTBhWSbRg75wIoBWyPvlX9JOpYwkZjYDKv10Egll0YPf+5C1t/ITwlPLaFGJ0o1o00nofc4RCphVmqAcJbtmiHMvDwz+1VGGYy/KSi+OUJoQ+GeOFWIAI2q90TdNA2xV+IIjsWe9Yql4/rQfZicmNIjuidi3YxfTawtBxNf1JCCyXr4Cl9acWeLFkvggXpK0w53EPUBe1nslBbcxdUl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 13c6c9d7-b951-49c5-361a-08de72df30d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2026 13:26:45.4787
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MuAiJZqMCQ7CbkojLSXJCaVGFxxWX2VJQf57v/2JK56WeSBsWXB0buAceVjljGv16N2Tw68d9YYl24VtZaGyafzIyfF9Y8Z5P3/50n1H4+E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8022
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-77956-lists,linux-fsdevel=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:mid,wdc.com:dkim]
X-Rspamd-Queue-Id: 6DDFC176F5F
X-Rspamd-Action: no action

T24gMi8yMC8yNiA5OjU5IEFNLCBIYW5zIEhvbG1iZXJnIHdyb3RlOg0KPiBZZWFoLCBJIHRoaW5r
IHNwbGl0dGluZyB0aGluZ3MgdXAgaW4gbW9kdWxlcy9wYXJ0cyB3b3VsZCBiZSByZWFsbHkNCj4g
YmVuZWZpY2lhbC4NCj4NCj4gSnVzdCBsaWtlIGJsa3Rlc3RzIGFuZCBmc3Rlc3RzIG1haW5seSBm
b2N1cyBvbiBwcm92aWRpbmcgZ29vZCB0ZXN0cw0KPiAod2l0aCB3ZWxsIGRlZmluZWQgd2F5cyBm
b3Igc3RhcnRpbmcgdGVzdCBydW5zIGFuZCBwcm92aWRpbmcgcmVzdWx0cyksDQo+IHdlIGNvdWxk
IGhhdmUgYSBtb2R1bGUgb3IgYSBwcm9qZWN0IHRoYXQganVzdCBkZWZpbmVzIGEgYnVuY2ggb2Yg
dXNlZnVsDQo+IHdvcmtsb2Fkcy4NCj4NCj4gU2V0dGluZyB1cCBiZW5jaG1hcmtpbmcgcnVucyBh
bmQgYW5hbHl6aW5nICYgcHJlc2VudGluZyByZXN1bHRzIGNvdWxkDQo+IGJlIGRvbmUgYnkgb3Ro
ZXIgbW9kdWxlcyBhcyB0aGVyZSdsbCBiZSBkaWZmZXJlbnQgcHJlZmVyZW5jZXMgYW5kIG5lZWRz
DQo+IGZvciB0aG9zZSwgZGVwZW5kaW5nIG9uIHVzZSBjYXNlLCBjaS1zeXN0ZW0gZXRjLg0KDQpJ
IGtub3cgd29ya2xvYWQgY2xhc3NpZmljYXRpb24gY2FuIGJlIGhhcmQsIGJ1dCBzdGFydGluZyB3
aXRoIGEgc2V0IG9mIA0KZmlvIHNjcmlwdHMgd2UgY2FuIHJ1biB3b3VsZCBiZSBhIGdvb2Qgc3Rh
cnQuDQoNCg==

