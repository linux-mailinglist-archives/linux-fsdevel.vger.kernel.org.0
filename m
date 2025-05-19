Return-Path: <linux-fsdevel+bounces-49330-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC39ABB6D4
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 10:12:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF2433B384B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 May 2025 08:12:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCAC26982C;
	Mon, 19 May 2025 08:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="GIt3JgYt";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="hGDzoI2X"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D98242690C4
	for <linux-fsdevel@vger.kernel.org>; Mon, 19 May 2025 08:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747642357; cv=fail; b=D/eu6/+TscL509zA7SAPG22WSkVx85QSjx8wX7ugDrYpgiB6Q4EQSGe2tIM2SePSVSPZZDmF2dNmxiGaO36udf1lRdevg7E9r1xb8NYhDMHEJrzIy6mKaFN+kh8E+PmcmcjYUBgyHLqIpXjtsJrABheXYuLNt3MTjnwQmHtw8m4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747642357; c=relaxed/simple;
	bh=tiXwdM65FmR8iTBbBjyKQmCyo4DkocOkgD8sjomGUMo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K/qs1aqdrU6COMByU6mF7VkKMrqdumIBuuFyEJkUqZoa1WsC5Z/gUtLOU0UX/9c/8uQWRiao+x2DAHntOygeiCNStpQWuJktULllfhUeZQqoOyCLAJrjTZYobKaB/NWTIocPCdyi9aInRjc4QhgJ1RCQsRdCFaZ1N9qGDl6aH5I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=GIt3JgYt; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=hGDzoI2X; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1747642355; x=1779178355;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=tiXwdM65FmR8iTBbBjyKQmCyo4DkocOkgD8sjomGUMo=;
  b=GIt3JgYttd7LesetriFD1hp6gH3rSC0+vrrWanCwFosYN65SaRAQFPgv
   vbjJkUgedQJEkDglPppyrRECg/ty3xkTn7bdOr4h8rga53CtPCrt05102
   TFNVA/7tx+RC3sqET+l5NqIlUpzTr3KbsD8h4EeyaOJJvFlCeVGzrb2Fu
   1EsUvaFPgLA1mC+wGApzBBi2fl4i9z5eyN5iPIZKDYwh6migZqPTs5zfR
   IdZ3tz3+9jlIoSV8KET1JzrWAYeHXIvaPBHAzQR+ePvxznhlp/Gm4aQQt
   RO2d18vO+wDhe3DGkSv0R4I8D1jZrP1iDpuJmeddP3TPLgqshPSesa4Ay
   Q==;
X-CSE-ConnectionGUID: EsBVAjrsQnauIBiVfw1xCg==
X-CSE-MsgGUID: Mg/CsGpAQZ6ltSypn9aCkQ==
X-IronPort-AV: E=Sophos;i="6.15,300,1739808000"; 
   d="scan'208";a="83290745"
Received: from mail-mw2nam10lp2046.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.46])
  by ob1.hgst.iphmx.com with ESMTP; 19 May 2025 16:12:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O5oTPBd04FpKMkrD7q1ak5vrukVh3r/mbFqBi/0qsjWO8t+c0Zp0+WU8MsBpFzCDuvk991494oYeB3W0gP406UKvjPhFCrlwgmt1vrLwbOpb4MYepFU/Z+AB9Po2lnKwF9QMagozLUK47a2aE3RGSRTuvntRtQvhCgzCazpdgbrqiAqm5WlNJ5Ali8bLqlzoL75oSAO1CZnEXtKo2l2yC7kqMdBC4voVoqD2VUC8GymcqLky+xuSA7gRNlOj8TmucCBKh347soSpyHBwVjpWg+cE4H7tmPvYtsNcCv94DX2jiIbPb/UFjQbauVx3QoM5NBNmabddkFqmmC262jmSaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tiXwdM65FmR8iTBbBjyKQmCyo4DkocOkgD8sjomGUMo=;
 b=Ii7Qraci1DPAId3qzto/vgQpXSQ6mYQ4YM7L0AXbf53A/uvRK8BUCkMqgXbCgyhJUOALqXYqjW4KPIOKtrtIahvkvkrMh9AYDqSt+XaPnVjBZi1CQQcKW5Kk5CbJyFOlVwzPZKcWtdwtPmom7bb9H3NyCFsr5re0oZbvL6F99bPj70Mbf+YurG1KsBFVxFwvXQuPZCuDW/DZmRibbmhdbnOttl53GzOtVcCiWi6ke6TfYDdC/3V19m6Xn0ROqmsOq5lqC/geSMo8WeOvcrC89CxxxoWLy35jh19sMZNfYSFWr0h7hDtrmM6g/9vnO60APOaqtPADSdMhQL/aFzCsog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tiXwdM65FmR8iTBbBjyKQmCyo4DkocOkgD8sjomGUMo=;
 b=hGDzoI2XaTfX+6qaOKKyGvom4ugxt1ukX5BdRDMsZhuE6vpLgu5AVu3IwwFXLS2buUwN778BYOH+OSPbh3UA0AqmEAnBsykNw7pIn6Op2gH/A2xRzB8wvmoDovwWxKh1yDjda4JRdlEHx5hiPDw0PIEyQlIud6igCv75wQ4xdmk=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9519.namprd04.prod.outlook.com (2603:10b6:806:43f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.30; Mon, 19 May
 2025 08:12:27 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8746.030; Mon, 19 May 2025
 08:12:27 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Joakim Tjernlund <joakim.tjernlund@infinera.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2] block: support mtd:<name> syntax for block devices
Thread-Topic: [PATCH v2] block: support mtd:<name> syntax for block devices
Thread-Index: AQHbxjc9FWv6R7K+1k+YM7e39W3mlLPZnxOA
Date: Mon, 19 May 2025 08:12:26 +0000
Message-ID: <5a3c759c-4aa9-4101-95c2-3d9dade8cb78@wdc.com>
References: <c0ecfadc57d7e595cad87eeab8dff4d0119989ad.camel@nokia.com>
 <20250516074929.2740708-1-joakim.tjernlund@infinera.com>
In-Reply-To: <20250516074929.2740708-1-joakim.tjernlund@infinera.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9519:EE_
x-ms-office365-filtering-correlation-id: 8fb7f989-1c41-48be-09c0-08dd96ace49b
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?c0xDamFpekdzcmxHR0F4eFVLbXlzeVhMSkFac3hIQWdiT05zQTM2cUJHb09N?=
 =?utf-8?B?U2RkZXpsNHhpK3hhQUZVMlFOQ2xzTjlIZDAxOFBWQXRQbUxsT2J5UnhUaTVm?=
 =?utf-8?B?YkF3WS9tcEk1a3dvOEtzc3UrTUJPanpMaXdhcGdLSDVFM3AvQVRxNzJHS3Nq?=
 =?utf-8?B?ay9pbGpEMGxtdHdTUmxseTlkbmU4T09pVkJnNmVwMWJyU3dOVHFjRWpNQVUx?=
 =?utf-8?B?UjZ4TWxmT2xHUmRrK0t5NHZSNU0wNDgyQjIzY0NaZ0pZT2o0YzZjb3lXZjE2?=
 =?utf-8?B?a0c2YzBqam8zN25lRkhjakJrUVlPU0x0YTNRUTltQVprWGJrVW1KclNhRXB4?=
 =?utf-8?B?RFF5ZHNQelNQWEU4NnUvcHdjNXUyRkRxbzM4dUFESTMxRzg0bThUZjBhbll2?=
 =?utf-8?B?b3Y0bmhjT3NEam1MKzA3SGl6ZTZwZGFJSDNOTWRUNFp0R3hEZkdjT2U2ZTVm?=
 =?utf-8?B?VWw4YnZJbnF3OVlOUytBeGFuOER2QzZjbkkxY0dVSkpuNXJ6NU84dlYrMWRN?=
 =?utf-8?B?TzJ0UEVHUVhwYndvd2twOW9oWU1iN01TUEVQcTVGUnZIaG1rQWs2bUlrMFZn?=
 =?utf-8?B?ZDhCQjRDS3RkUEJiWktORDlqbkZ0TE42SnJYZTh1NUdmUTVwMnBrRUJ0Rm1r?=
 =?utf-8?B?dXpvYmdzeWxjMDFxL2dyRlltdU1ySkRaaVVLY2tLZWI5ZmJMVWFCNFlOTUtR?=
 =?utf-8?B?eVF2MzA5ckFZVEdDWnY4TGlOMkJoaFpxelp6cmI5VWhmQWVPbERGK211YzZX?=
 =?utf-8?B?OUlYMjdmWmFwRWZrSzRBdkk5TUtPNjdyaGJxRG9KQzRFS0tMMUZwWmJEL3Ay?=
 =?utf-8?B?aFg5Nm02cmhmb0VzNjJQSXFQeUUxMVNoS2sxdTlKT0lYMDdxVXZvVG5KV1hF?=
 =?utf-8?B?a1VsSVZUbmx2ckw3anF2UUloVzBvcWVHWXVGUG0rUDhZTndUQSswY254akdn?=
 =?utf-8?B?Mzl1UU1lYWNzUzczTEhRdG1zcUNFQVdzZU5TRjZOZmhsd1lCOFQyUzdXNGh5?=
 =?utf-8?B?UlRvQXREbU03blozYlE0RG5Ha2p6M1RIeGY1SFRHa2ppdVpsVFgxWTZDdEYy?=
 =?utf-8?B?aUlubXYycG5lV043Ti9jNWp2TzdTL2pMVTFwR1lXbVRUV2h3OXNpNkd2bEpn?=
 =?utf-8?B?eHRvNzcvdDVxNFl6b2JIMVpYeWdHVmlJeU90NkdjVjREaGZVWFFDVVcwSGIv?=
 =?utf-8?B?ZFVBVzJxbHNmRmxINlhUd1lBNWtYbXF3eDJUZ1l6SndXdG4rRVBDOE1KRmd1?=
 =?utf-8?B?VitvU05BZUFYeTdWVm1SSktjcXAzVjB6c0xnVlpsMjdjU3ppeG41ektiR1ZD?=
 =?utf-8?B?bUhZM0N3ZUlCTlZsN0VhanRFY0hySDhYSVpGYnhXYURZSWQvbVN1RGFLREU3?=
 =?utf-8?B?Tm5kWGVSN2tFSDZVdGJLOHFGL1Q3RVQ4UUdPekJPb0xDa0ZQcG9VbllHcjNR?=
 =?utf-8?B?ZlZsY2dVYkpoQi9PdHNsOWNJQm9GS2M3U1pISlBhYU80bXp0am9Ed3FhMVRo?=
 =?utf-8?B?RVFHRlEyQXVHUTFCK3NLdVNLZHcwOGs3c0psaVBCUzVxVmlCc1JVWXV3cGZk?=
 =?utf-8?B?bGpkbnh1cG02M0VTMW1wM1BIZjFsQW81RDVaQlo5SmwxVjcwTXVwUFNZSXRq?=
 =?utf-8?B?RWR5VlVrd2plK0pLR3dDdjNkUUZsdE0xOU9Beit1YW0rVVF1RDVSN0NVRU1j?=
 =?utf-8?B?czlMRzNWeUROR2o0OGE1TGNkQkpTemZGb3YwN3VYMWFjUjJuMFFEWjBQOUFV?=
 =?utf-8?B?eHNhaXhyR0tqWmF6cmpCVlNEMFFCR1dWOE1kb2svTFlUY1QyVmRSNlp0ZmMx?=
 =?utf-8?B?c1NnZ1RySVRUMmN4bENMSkhLbXoyMEdkKzRBSzI5OExBb3lJcm1VWlQrOEdW?=
 =?utf-8?B?NWdKQ1dMMjVpRTJhSTdlQUFmeUdodFptUW1mQi9ibUVteGxQMWU5VDhSeUpZ?=
 =?utf-8?B?dWtqS2RlRG84dlpMbmVTWTZmT0FOc1o3cnFsRjF0RUttRXpSamNnelBhZ2VE?=
 =?utf-8?B?OUJib2pqNkdnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?OHczZ2F0dzV4b21NeG9tUk1PQUY5ZnBNd2V0MkhCWGRUcU9GRVY1cTVoaGxM?=
 =?utf-8?B?bGIza2hGYUJrWUt6aEh6TGV5K2tZVEZqN0N0Z04xWkFzM05VQUdkbXlBWnY4?=
 =?utf-8?B?MUNPa2pNcGJrVldSRS9MVE0zblZ4UlZIUVZSREFyNUM2UTBWU1kyb0JSOTdm?=
 =?utf-8?B?c3ZmK3JyczFlM1A3MVYyS1FRaDRVaDNnenFlZjVRaG1VWGJvVFd4RlpIVmNF?=
 =?utf-8?B?aTlJUndoWEo2M3crT1lUWEJkRVlKdEo1OVJLL1hpUEFzQnl1RG1ucnNaTFky?=
 =?utf-8?B?U0JLQ1ZDMmNLUHdNdytwS0tGOVVKUFJyeVAyNXJvZzlqNjYzV0ZPZXRMTHpn?=
 =?utf-8?B?cDVVOE4yZEZ0RVJMUkdRMHNVT3V2UlRVV3Y3SlRnWUdGUlo3cDhraVhQS2tt?=
 =?utf-8?B?NzFDVUNtMEhWak1vOUZYNndNUU8rY1ZkVUhIbUlRYnBGUG5OS0kxb1kyM0ZK?=
 =?utf-8?B?ekptUHlLWjRwZStNNDBaNVBVRWhldm8zdzhHN05BNStIdUwyeXY3QUpyZ3A1?=
 =?utf-8?B?UnY4V3RqaGg1QWd0d2tKdll5c2hwYW1nMXJHYzZPMU9JcTZ0cmJDKzJDTFd3?=
 =?utf-8?B?cjVRa0JoTm5QZGMyY0ovYjR6d1crZ3ljN3dWNXNadkhoZmV2a2FRblh1YWZi?=
 =?utf-8?B?em1sdDcrYklQdW9UQy9Rd3R4OTFESzZBakxydDhlTmgzS0ZoVUg1Zm9PVGNu?=
 =?utf-8?B?MGR0K0Rld2VpZ1J0TGtHRmFwK1grZVdoYlpwQjlHaHJLQ3N5Yy9hamcycEwz?=
 =?utf-8?B?WGh5UnMrRWRiU1FTS29IRCt5YmdWKytCZlhUbXZKNHlBa0JEUFRrOXNoU0tW?=
 =?utf-8?B?Tk1KUDZNY2VSZ2Zvai9USmcwMlB3Rk1rNmhmS0Y2S1RBMWRUTkRBdUw3QUZj?=
 =?utf-8?B?RmdJcXJlODhhTzhZbnhjbk1uMkVPNzl5QVVweEttcEY0d3JwQXFmUkNJbTRk?=
 =?utf-8?B?WEFDbVAxbmd4eUVXREhsSDdDSmlCR0tvU1hCRGliQmRaZnJyWXI3cGdmMTVl?=
 =?utf-8?B?blFQL3NKb1ZCNHNQRFZzZWc2Z3F6RFhZbEFFQTJGTW9WNHlmMk1YRzFhYjdS?=
 =?utf-8?B?UHB6Nm9pVnJFSFMvV1Y3N21NUHhnMmZEQ0E2dERZK1EzYmt6Z2FNc1E5d3lq?=
 =?utf-8?B?Vi85TXY1MFkxdHBWbThOaUM0a29lSkUvMk1TT28rTENleFZkY2JROW5EQ0ZV?=
 =?utf-8?B?SFRUWGFRcG1ubGxzeXBYbzdRNi91UnpnMGdRVVJZYnlsMnFZMXhZTEVTbk4r?=
 =?utf-8?B?ZkpJb1FhWjFhMjFMOG9DWkFvcng1ZjFBTjQ0R29OcjVQWUMwQVNiQUFBVlRU?=
 =?utf-8?B?NzEwU0R6QzRLSERKRGVJY3hrUTJVM0dJY2h6NktpbnVaQXhKYm1tdHVnQkRv?=
 =?utf-8?B?TDJyeFNWWjBoUk1DK29KeUVSTHltYmNyRDVRSFlFTEg5QmVKVjVyMDRqWVJJ?=
 =?utf-8?B?cXdyZjdOWDMrT0U3WUFLYXhMM2lWbHkzTDJObUJxYks5RGpmc2E3NUx1RmM4?=
 =?utf-8?B?b0xtVU96UG5EdFRBTFgwZjJmRGpwTlBPS2xBVHA1NDNld3B6NGxOemZJcnhR?=
 =?utf-8?B?RnVrTTF1QUtVbXY1YittczFGRXNRekNBUFBaMWxLc3F1aEtYcnlEaUdTckVx?=
 =?utf-8?B?S0FkaEliOW9Rek5LT2hGU2Z2VmRORHFsQklsQ1h1SmxRamNad2p2UnAxQ3Bm?=
 =?utf-8?B?WFJDQVZPelpjeXJCQ0lTeTFVeGYya0U5eWI0dGtqMUk2ZHBNQ1k0OUREb2hv?=
 =?utf-8?B?TFRBVGN5Tlg1dEwxV3lKdGdNbFNidlpBN0c2NEZzN1A0Vk8rMVRrSGxVdEJH?=
 =?utf-8?B?VXppYit5eHp5cE85UlY2OFROZHAyNE9lQkVJTVk0MFdjOFU5a2pWeEV4Rmgw?=
 =?utf-8?B?Sm9pcURCVkxkWEdjT2dLUmV0a3BWSkZpK0llWkpKMEV0aGpEYS92anRRbTB6?=
 =?utf-8?B?WmhTK09CemE2TzVUN3lGYjRqcWljc2ZXT0M5KzVpbmgrZ2ZhS0NUYjhPVkp3?=
 =?utf-8?B?NlgyQ2ZlcXNIMktCUjdGNkdON3hTcTlsVlhPQmM4NlVIaThwaVhwRjNyaFVO?=
 =?utf-8?B?UnFKSitDeTlmZEhjTkVVSFVRSDR4V0k1MEdyTnNvU1dJbDF1dTRTVkRMWEow?=
 =?utf-8?B?ZmlqZUNwYVJ6L3VqcVV1OWRuUWRhTisrWmN3eXBIc2FzTEgxWFc4OXlQd1Mv?=
 =?utf-8?B?RFE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3EFAA533276E22408A052915CCD900F2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6DJ2eUf/WkRvl8CYTIXj6igeD7P1cUVWwapGeHLc8vFa4j2pXLLPm3aZ93f3DqIponnWjsfV6g9UYwKcBAf0IqOS4SJIe9Vc0uNCm4enb1hd2aNaz+3UzM+m7vSAZEdqi42BevRejGfCQGE6fqJqLJEYfeNVzfEusCccK6+hEn0FlU0LS2YFlMEFnxqyHJCWov4Js6ylCMEGfTvmA3LpKuMXG7B/QFyjhzflXIqQQH/qcEhXNmSi/RzluJEnOY4n39RyuQ6f+gGR+c6Cc4bGsN+0YCuc7KVZFDqS7bbhR6vbRt6qMw8uwZNA+k5X+99KCKh8OPFzx2vOnv9XuTZl3nr605ItH4sTT7ktr+keELKPjVTmMXSEyHU0kVsUd+4bKiStY9ua52PBk433HUjBEderikQ9IrR2MtbtmbbIJS4cxNfbptuqA2lfj6VM1axB6Eq0MedV/k8D6XH3YrybSU5HiRuzSmQN+kFLafoIIO+ihaLnfHL4e5P9xkggnBL0QuYHEXT2XGeJZ82+PFMqllqSrTJSwZWeq+GRGnRQvNR6iRJ0HURsg4PaARXb+8JJb/A7mKJDCopeTjioZ3JwZAg9S2umz5R6ZFg4yN7vys59QTq4yVQQrh+MA5kKD9+3
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fb7f989-1c41-48be-09c0-08dd96ace49b
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 May 2025 08:12:27.0151
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WbOZZEAMcK7GloxWBlSfmwtHUNt4kK4D5ofK8DwVD9n0SSkd0HOOcEapEmg8oUMWRV224pBeV4lAhBGzmfLwarKkufQy8WcbnEfUBJI1Ba0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9519

T24gMTYuMDUuMjUgMDk6NTAsIEpvYWtpbSBUamVybmx1bmQgd3JvdGU6DQo+ICsjaWZkZWYgQ09O
RklHX01URF9CTE9DSw0KPiArCWlmICghc3RybmNtcChmYy0+c291cmNlLCAibXRkOiIsIDQpKSB7
DQo+ICsJCXN0cnVjdCBtdGRfaW5mbyAqbXRkOw0KPiArCQljaGFyICpibGtfc291cmNlOw0KPiAr
DQo+ICsJCS8qIG1vdW50IGJ5IE1URCBkZXZpY2UgbmFtZSAqLw0KPiArCQlwcl9kZWJ1ZygiQmxv
Y2sgU0I6IG5hbWUgXCIlc1wiXG4iLCBmYy0+c291cmNlKTsNCj4gKw0KPiArCQltdGQgPSBnZXRf
bXRkX2RldmljZV9ubShmYy0+c291cmNlICsgNCk7DQo+ICsJCWlmIChJU19FUlIobXRkKSkNCj4g
KwkJCXJldHVybiAtRUlOVkFMOw0KPiArCQlibGtfc291cmNlID0ga21hbGxvYygyMCwgR0ZQX0tF
Uk5FTCk7DQo+ICsJCWlmICghYmxrX3NvdXJjZSkNCj4gKwkJCXJldHVybiAtRU5PTUVNOw0KPiAr
CQlzcHJpbnRmKGJsa19zb3VyY2UsICIvZGV2L210ZGJsb2NrJWQiLCBtdGQtPmluZGV4KTsNCj4g
KwkJa2ZyZWUoZmMtPnNvdXJjZSk7DQo+ICsJCWZjLT5zb3VyY2UgPSBibGtfc291cmNlOw0KPiAr
CQlwcl9kZWJ1ZygiTVREIGRldmljZTolcyBmb3VuZFxuIiwgZmMtPnNvdXJjZSk7DQo+ICsJfQ0K
PiArI2VuZGlmDQo+ICAgCWVycm9yID0gbG9va3VwX2JkZXYoZmMtPnNvdXJjZSwgJmRldik7DQo+
ICAgCWlmIChlcnJvcikgew0KPiAgIAkJaWYgKCEoZmxhZ3MgJiBHRVRfVFJFRV9CREVWX1FVSUVU
X0xPT0tVUCkpDQoNCkNhbiB5b3UgcGxlYXNlIGF0IGxlYXN0IGVuY2Fwc3VsYXRlIHRoZSBjaGVj
ayBpbiBhIGZ1bmN0aW9uLCBzbyBpdCANCmRvZXNuJ3QgbG9vayB0aGF0IG11Y2ggbGlrZSBhIGxh
eWVyaW5nIHZpb2xhdGlvbj8gVGhhdCB3YXkgd2UgZG9uJ3QgbmVlZCANCnRoZSAjaWZkZWYgaW4g
Z2V0X3RyZWVfYmRldl9mbGFncygpIGFzIHdlbGwgKGFuZCBjYW4gc2F2ZSBhIGxheWVyIG9mIA0K
aW5kZW50YXRpb24pLg0K

