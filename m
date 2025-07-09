Return-Path: <linux-fsdevel+bounces-54331-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A10B0AFE170
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 09:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 73E981C23BA7
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Jul 2025 07:37:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BEDA2701DF;
	Wed,  9 Jul 2025 07:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="c38nLDXS";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="owotjCEn"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D4F26FA76
	for <linux-fsdevel@vger.kernel.org>; Wed,  9 Jul 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.143.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752046646; cv=fail; b=UzV/96Tro7dBsP7VB8fhDXzzcHX62NUg7KKroN3aIiBrqwQYMKBdM6A9oEarR08GmSO9EyxJyxbiKofvzhFIM1aeEMDffqfkfCWcSbF00dL4AVYiLrDTxD/gDfIMoSA58/43Mh0CA6TIVy3TBUPhA4f0M2n4yyVO4WM8zRuprdI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752046646; c=relaxed/simple;
	bh=t/I8ssQWFj5X9djiIgOr9EEqnBFapyVQHY7WFwXKDnI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JfbPRJsSTc+GnQw9aaQ0A9QJBKRoogroAtIICE9MkBWihDcgGWc5ZLjbywDgbMipPVvd1j2F+R35ltFrLx35dhnhkC6CCmxrDGfmpQyTiPVku7VweZrOPuGijrIFG49VrDCov0+0HFh2C0YkCda/jG+BUuzdXWken/GoNuBBT34=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=c38nLDXS; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=owotjCEn; arc=fail smtp.client-ip=68.232.143.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1752046644; x=1783582644;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=t/I8ssQWFj5X9djiIgOr9EEqnBFapyVQHY7WFwXKDnI=;
  b=c38nLDXSc0YEQh7Tr4DJVY+2ReZ5B5jPuO++s37fRLxeNdq3qJ5VwwJ5
   5Kg5S+xNjU8oIftPxUZs7H8FtCf+bgXmDdPJ6ft1d0yNFI6WhJX/zsZU1
   fFGx4/lyQ42s27DUN+3Gk6iUX4+kSggIuJYBV5ZxUZwqikIcoATqBKjba
   EpRqDJSut6Q4+kE9d3w0bge07kSeIkgm1Q8Mz9YGcdUm2SJni29WIvCd8
   25xyG39ly5GCkcG4ogDzwGvRRd1jHyfhvZq8fsMxG1QGQVKlyNqtkQ9Z5
   ZaCGHv7S8RKmXQjgNMD+ksyBBrGOt+/MAzSN6JqwDMHKyo0rB7VUc9prp
   w==;
X-CSE-ConnectionGUID: dsQp19M3RhO0sHcs00asZw==
X-CSE-MsgGUID: J8vX/5ZmTSGKNSlp8eXHqQ==
X-IronPort-AV: E=Sophos;i="6.16,298,1744041600"; 
   d="scan'208";a="92186392"
Received: from mail-eastus2azon11011022.outbound.protection.outlook.com (HELO BN8PR05CU002.outbound.protection.outlook.com) ([52.101.57.22])
  by ob1.hgst.iphmx.com with ESMTP; 09 Jul 2025 15:37:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0vzl2BgC7gkzGA1yHN3b0B4EEl9znXzAMmUdS+ots/QbGhxbmFfiGiAZxw+eIFB7jVgV0t+6B15wtTh4WzAg5sqFWzRVspOrXZMFJmrA38Pbdpe0iH46CLN4XDA2XOxQaXQ84aHQ1BYyXEdiuBv646sFxlk9zJOJd4CCLxZ+5qF4se4QfK3GcbPpLTmz0j4wLY/jrV8QibZa3nEa0xdfEm27sObNjWCgiphfbkGBAKJ3cOHZdFmK0eoaU49JEH72YMzSgOjbo7+aAjxqxkAggn6SPqkYBTgZmsmW3FP4Ig79cxtu/s86EE+Vy6Oee7Rt4E3MSphH0s6YtelrjKnEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t/I8ssQWFj5X9djiIgOr9EEqnBFapyVQHY7WFwXKDnI=;
 b=GsXeukN/SWYnxqCfqo35wFZPPd2GZyf+eTQlf5ogQbppmqRFuH+WF6ywfFgZFjPpGhmBpXxtPnQyZJMlV6jN3/MqkYkEGfF4VeBa6NmTXWD6q2P5R6/gcl/3zXEg6fMrBJKVPeCNJ6oXtndC0S0SGzz2oMn14Fn3XzOrlmC/m4mCZTrMWLdKBjoB9NNM8F4U3k3BxrIDVlORdGiPW+TI8GgKbe3rkcOCE51bUhT7lturcIif1JTkkIQImrudJoP8DdvJECL0R3jw01CTJdMSgArj+w1M2ApfsceuhRjROyZQXE2KqxJYR/Z0jKYMUxJl1lLIJ2p4N+NhrfH0BccTUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t/I8ssQWFj5X9djiIgOr9EEqnBFapyVQHY7WFwXKDnI=;
 b=owotjCEnDmVfgkOMwwHt+XnT9+3qSPB2AbgAu1Zepc7VxpGpM5pPKSJyhroJ/3WlAaFcWkOuGFIJb9NzmMEWWfvmMdNbEUCz3YBGQQLfuMeXP4oK2bHP8ZuGpht4CCq0uxq9ErwASg6rM46LILFYMvrsnjDeCC2dUBH+LidkCNo=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by SA6PR04MB9074.namprd04.prod.outlook.com (2603:10b6:806:41f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.26; Wed, 9 Jul
 2025 07:37:15 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%4]) with mapi id 15.20.8901.024; Wed, 9 Jul 2025
 07:37:15 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Viacheslav Dubeyko <slava@dubeyko.com>, "glaubitz@physik.fu-berlin.de"
	<glaubitz@physik.fu-berlin.de>, "linux-fsdevel@vger.kernel.org"
	<linux-fsdevel@vger.kernel.org>, "frank.li@vivo.com" <frank.li@vivo.com>
CC: "Slava.Dubeyko@ibm.com" <Slava.Dubeyko@ibm.com>
Subject: Re: [PATCH] hfs/hfsplus: rework debug output subsystem
Thread-Topic: [PATCH] hfs/hfsplus: rework debug output subsystem
Thread-Index: AQHb8ERqutV+FY/7eEOaZFpfR1Ybm7QpaAuA
Date: Wed, 9 Jul 2025 07:37:15 +0000
Message-ID: <e80488fd-0b9e-419a-aa63-3887125b7f36@wdc.com>
References: <20250708201017.47898-1-slava@dubeyko.com>
In-Reply-To: <20250708201017.47898-1-slava@dubeyko.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|SA6PR04MB9074:EE_
x-ms-office365-filtering-correlation-id: 79533bfd-dec4-48b4-f10a-08ddbebb6d30
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|19092799006|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?ZHdaRmpwVHFnaEY5WC9iQlUwWEc1bUZhY1pjRWd6QVhZdkIxMllqa29LNVBl?=
 =?utf-8?B?Tjh4ZzNCS0c5RlVib3FrbDdGeDQ5RGtBemlvWVFCcnE5ZVMwcnd2ak5kZ1BO?=
 =?utf-8?B?TmFKZXNCd2pkOGlwbUlsU0hyMzNsYzVqeDdYaTFjZGVhNmVMdlJrTlhtWUp2?=
 =?utf-8?B?TmF3TnZIK0xaenZ0YTRlcVA2L0tCeUozU216ZVMzK3pNT3hkMlF0VHdGV3M4?=
 =?utf-8?B?VUxZbUhzQXk1MDdKcUIwNlFwYzU5VzVEWVBGS3k5YU1Yb2RES05valBhRk1D?=
 =?utf-8?B?VGwwSzJ2Yk5BNkZNcm5lWTJmbUxPVkE4Y3kzOEM5NWpuQ3ZJUVJEWmMwRVNh?=
 =?utf-8?B?YTRDSFkyT0F0QzFLcFBsSW0xMDVrU2NQdlFTMVF3N0tDZUYyZUttbW0rZ21C?=
 =?utf-8?B?UFdNNEVwakZqZjYzZHdua1RaQlptSURUWDVkaS82ZU1lbUQvNVlzMU5qSTN5?=
 =?utf-8?B?TGd0Um1XbC9BTGZwNkc0VkNhdEkrTzhwZzJqWG4xZG5IOERMZU56RWsyT0Fx?=
 =?utf-8?B?b0lUeGl1Zm5ORDZrUnVkR0I0WGdKNHQzMi93ZjFRb1ZMeEhDWDlSN0s1cDN4?=
 =?utf-8?B?ZTB3eXVGZDlscFVlQXJqSFpKVC8zR1MyRTgwRk1wTm9ocGEvS25oZnFYdDcr?=
 =?utf-8?B?dnpmbHp6dHl6RTJkK29wVWZ0QTNoS1ZGdkt2S0tyTmlkeWNtS3l0RzFHbEc0?=
 =?utf-8?B?Z2Z2RVpRb1ZzcGRDeGJqaWNHajV1NXhRR0ZVRnA2M3Z1NGJnbEZXdWZ5RHA0?=
 =?utf-8?B?S0JUWHdOWnVFeDlYWGNhM09DZXNLbzQwL0EvOHZiTXZZOGxqV2VPV254ZElW?=
 =?utf-8?B?c3RzYTJzd0x3MUV4UXhGSWQ1djRQc0ZOUzJ3Z3ZQTEx1SkZORnlnYWVvRnpp?=
 =?utf-8?B?L3pLMyt3RGlCTEZqY0VjcXl6OWtXakk1M01WSUlnZk9KQitMVklDQ1BPQ1Rs?=
 =?utf-8?B?aVl0QTdNb0gxVmNHVGRRZnhlYzJYV0NsMVFoODZBRDkzYUFtazlvcVZRWHdX?=
 =?utf-8?B?ME9ZOE5rbjV3V0dPVDV0K0V1RmpkRy9rWGhwV0VybjJsWHZkbDVpQU9kWGpi?=
 =?utf-8?B?YXlxYWRkbG95MkFpN0JlWU5pcFpTSlFqSE1ZUVNLWm5hYmZST3UvWDZYSGJO?=
 =?utf-8?B?S0Z6dzhCZC9QdWd5ZkdURVF1TXFJVDZXUkpVb29qWVExbGNVYnFuaThTWDJ5?=
 =?utf-8?B?YnhvdjUySzZ4SWRmbHZaSGYzcERHc3FKbFpleWVrd2U3VGM2TktJanJqVmlx?=
 =?utf-8?B?eEhEbGI5UVFBciszSUg0OWthejYyUWk3UmJscHJWYU41WnlZV1RNU3h1eTVm?=
 =?utf-8?B?QzlBZ2EyZ1RzQXR6ZG1LSkdzeFdvYnNjcUFoQ0FlcmpDeHVzSUxMVXdoN2NS?=
 =?utf-8?B?U1JUNGlnRkFmdXlxM2pOcVo0RE9GWlJkdnMrZmxmZXplNGdIamJUY21ZQ1Bz?=
 =?utf-8?B?Sk5BcjZDdlJ1WlRXdjhFNEFSYUxuY014eHZ5TS9wM3d2djFmdkFVcHhYaVhQ?=
 =?utf-8?B?STJSZHpvWXBCcUNTYnplY0NuUUFjNFlJMlBoMDV3QU1DMktRZHhTZC9wVE5Y?=
 =?utf-8?B?eGpUb2hrSFBOQkVkc3FHYmhCTVh5cGlxeFh2NVZkMmZOM0hNMHBsUzJkS3dw?=
 =?utf-8?B?WGQ4bkwrUGZweEtXdXJWOGVMUUpldDRWL09OMS9mRHZ1dnQ2V2dHZi91VDJQ?=
 =?utf-8?B?dmJkSUNEZXUrOWtOeUl5V3lhblFKOG5idU1KUVJiQU15VTJCdVQyN3dUNWg3?=
 =?utf-8?B?Q2hraEhZcFFsZy92S3dGUHczckJxNEY2a0x5SlNwMDlaRmphYWphajJPMDlL?=
 =?utf-8?B?aVVnaUF0VzlldFY2dXlVeDFFY1BEeHVDRXJXdmVJeFIzZzM2VmZuWlRlYUdW?=
 =?utf-8?B?OW1hZXhvcjdsVzRvTmczUkNPb0p3SDEvOXp5Y1FQNEVvTWZXQUhENWRvMUg4?=
 =?utf-8?B?TE8vVFVNZVdha0EvS2I2N1A2czR1T2ZxVnJZanFtRDI0aDRkOFV4UDBjSGo0?=
 =?utf-8?B?YUpVY3BTQkZnPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(19092799006)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?ajRBYWw5UTFzR1FTL0dGWmtLZ1dnNmpTSkU2dE9pU3o1VW15N1JrTUkrVlMy?=
 =?utf-8?B?MUR4N0ZWQnAxYkQzQkU0MWcyWW5HK3AwM0FPTXNmK29LQkppNHRCbGpmSzZZ?=
 =?utf-8?B?MU9BdWdOSFJBY1FXNXl1M0g4QXY1ZXNVRnVic0NSajFock81T0w4RXc5L01L?=
 =?utf-8?B?MFdXcGdGMXpFNU91ZWl5TWptV3hlZTVweDFNUm5BR3p4NUoyTlFJYUdpRjR5?=
 =?utf-8?B?RTI5cWFFZy80Z1B5cTdETlhqVDBQQzJNc20wWVMyV3JEODhkaEpZK3FEeW41?=
 =?utf-8?B?emw5SUtTNFh6bjRiYkoxTlZWTUI5SXZmMlBxeXB0aWZhUFdaWEpHbXI2QnJ6?=
 =?utf-8?B?MlNvbC9sZG1VODVNTWRUck0wS0JMRTMvOThiWkQ0SjEwZUU4WXA1RFBkTm1I?=
 =?utf-8?B?Mmk3MFJMUGNNMWFtQS9ZbnV4ajh6RHBlZ0xKcS8vL1FFMldhTW9wMFZPc2VO?=
 =?utf-8?B?aG50dU9vOVhqL2V3dWNNRmtSY1REVkIvdXRvaCtYRW92TTNlZHZBZ1hFcXA4?=
 =?utf-8?B?Y1RXd3BZYWRKV1lTdGZpeWM1UXFpV0VvVjJDME5VM3Z3WXZtTUJIZmpvcmhv?=
 =?utf-8?B?L2RvOWc2cmNwbUFmUUViTEMvc3ZhTjFqUzRwVlFaekxuTXZheitNWDVmbUJ2?=
 =?utf-8?B?c1U2bUdoYzhPeld5eXZRekJIc3BSZ095cmtmbEYveUgyNVhNdXBidkYzUHpm?=
 =?utf-8?B?Uk9QNGN5aE5zNm8zV2R6VVFyWDh0K0paT2RtVDdjUTBza1owWEhJdlRuMTBv?=
 =?utf-8?B?a0N2VXgvOGtqdTlud1hDL0pKV3pEWTU4T2pUWVpIandJcGd4dGVFZUR3V0hD?=
 =?utf-8?B?MjNTaUh3Y0dDTG9xOE5nY1pkcUptZXlicFhvUWE5RzRCb2JhUU1DU3cyRnQx?=
 =?utf-8?B?L0JjOHE2RmdoRGExZytFaUJEV25kUElJZi9NMWt6T0lVZVFGdHdkUmtQb0RH?=
 =?utf-8?B?SVpha2hwdFRyd2ZrYVRKTDAvdS92SkJhWUxjQm1xL2RodkZLcGhSV3VDMUp5?=
 =?utf-8?B?b2xTeGlZemVqcEdWSmdJUElXZWZ0ZWM2NFUrUnI0YlB1K0g5OFJVaE1mNnZ3?=
 =?utf-8?B?TzFiMFlWektWU3hocjNqdzBRMDZJT2xBdVQ1RjVSNC9ENEcxck1BZWFPaUh5?=
 =?utf-8?B?ckRRQkw0RnJDbWovbjBjUUJDMEZ1NDNKUEJVdUlSQUhhVGZPMjRkZ1p0V0Zn?=
 =?utf-8?B?dTlvTER0M3BmTlFLSmVJNmd6dllUM0JlU3BKWlVlTGhtK2JLdUlra1J3ZWZW?=
 =?utf-8?B?Q2RiTElSb2hRL1p6OTlGQ05reUlaU3N2MzdNWURvZnNpaEsyM3M5SU1Ga1Fn?=
 =?utf-8?B?dGdOWmxGQmloSWdMTUwycmR4VTBSdXJnUFpseTdCdEliZ0RaTU53RVBVQU13?=
 =?utf-8?B?cFg0Y3lvZVM0TGhyZ1RraWVHbjc5R2U0V0RJTnV3WnN4UUMvanlXKzhBU3Fy?=
 =?utf-8?B?UFJwdUt0N1NMQXdTWkRLbXlMbFc1Z2hIaDNtV0RCZzhwYVBhTHNLMldwKzVI?=
 =?utf-8?B?VHk4TVVBaGpYek5oYlR3a2U4YzdIaFNZb1E4dnViakFZcnc4bGxWbGVkaTBi?=
 =?utf-8?B?SGg2UitQbER0VlhUMFhrTFdlU015QnJIS2RBaTFJTzNTMGtYRElCbGtiVzFj?=
 =?utf-8?B?c05GYU16QWlNeTQ4NmtOM3JXNFJaR3pLRU1IU2xSRmlDVTFTZldGYmhlclFu?=
 =?utf-8?B?M1NDOWw2N0V4WXRiNVBkVFlDWVNzTlBjeFB5MmpvYzBFMk5lVWVSSXBaaXRS?=
 =?utf-8?B?NUZtZVRxL3RSdjF4d2M2Ukc1Zi9pZVdjSTllajZSaGVpa255eWtZcFFvSE9T?=
 =?utf-8?B?cnpDWW8xT04wczJOQ0JpcTlLS2JYWlByMGswMHdnTjhvc2FMSGxjd1pCcUJV?=
 =?utf-8?B?d1JVOFFwazhyb3BVbTgwS0VSYmJSK3ZKdVVFZUZtWEl3YVErMXRhbUFyU2xa?=
 =?utf-8?B?ekVhcGc2cXI3K01jV3pSVlBWS3MwR1JIaEt2d1U2TDM4aHRtS09YZHE1TlVO?=
 =?utf-8?B?VFNSZjducXdiemhJek9yV1FEa28xbVJZSU96TXpEWHJ2NnVWaEVsSFdOem0z?=
 =?utf-8?B?cGs3OGdyOVN2a3oyZTFpWkpmM29XZDJORFI3clNFMi9iZGdDSG9ubVFTWXYw?=
 =?utf-8?B?YXF1UlIwbHRDTzEyaFl0K2lXbEgweXNhZkJpODJtQk9jZ3BYQlRkM1NpbjJm?=
 =?utf-8?B?OGc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BA8E274908DF6C4C96E18BCBDA3221F1@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9TLO2Bvw2EOwUz33Ta/7abyUY0Kq+xvKiGWLOjc4NnjoVL11kI2q2I5TU3/wGXfocDcK5XdJ4ELz2cZ+DPaCEG6sY1p81m/ldTNa0sYAm1EsPDt1Qxn1zXW1SOZh6LL3dS7AS1cQAw+JIx8IfhQtQrgUiDziZctuSsEZbbyeVJFWQijTVxHcPia8TAMoY7UrUbdldRtQLR7dIm5YN6NAwAN/drOVjLdvXXaGf4r60P7UfegGh9pTSCak50PPWUngZCqPLpEhy1CPDUI5OgadoN/HxLEpcbaUSR9b/VrNGnmtSc8isbdoGBICdFtgV4UbX+GXslt3VWh7aOOUTta0YI+1+JnTxi+vxGHzbh1GLA5bVOZ8IiO6MmtxS1BL3iVq3b6sQOeubAdxIUbgzbZsnRzBjFTc9Y1KqAbjde3uX32aT02QAOixLgULSuE35XdEqbbwFuoOdPs0SjA/oLvTgdjFVgyFQLZNYA7K8Rh6Mmt9ilU64UUoKq2wFUrORH5bJaUNDOdcpqGeWgc4FbAA7fxjLaFlvSR0XHBc8Vd+9E7N3JRgZPdDiF2759pF0CznAxKvqM4Fq8tFHy2ae2fWygxjWFlNHZDjd7l7ebB1X8hFDuJaau7TdvCh+r8748BL
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79533bfd-dec4-48b4-f10a-08ddbebb6d30
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jul 2025 07:37:15.6015
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QdnUznBZy/T+BNlS4vHe+ke3/3vbgI5WQ+WeK4fGGt2vwSachql6CCEQwZTRo0T7uPE+2gIYOdpBvrgfd4rPNK/hwb2Rtkw1ReIGGa0bUIY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9074

T24gMDguMDcuMjUgMjI6MTAsIFZpYWNoZXNsYXYgRHViZXlrbyB3cm90ZToNCj4gZGlmZiAtLWdp
dCBhL2ZzL2hmcy9iZmluZC5jIGIvZnMvaGZzL2JmaW5kLmMNCj4gaW5kZXggZWY5NDk4YTZlODhh
Li40NGE4YjNiYTQzMDAgMTAwNjQ0DQo+IC0tLSBhL2ZzL2hmcy9iZmluZC5jDQo+ICsrKyBiL2Zz
L2hmcy9iZmluZC5jDQo+IEBAIC0yMyw3ICsyMyw3IEBAIGludCBoZnNfZmluZF9pbml0KHN0cnVj
dCBoZnNfYnRyZWUgKnRyZWUsIHN0cnVjdCBoZnNfZmluZF9kYXRhICpmZCkNCj4gICAJCXJldHVy
biAtRU5PTUVNOw0KPiAgIAlmZC0+c2VhcmNoX2tleSA9IHB0cjsNCj4gICAJZmQtPmtleSA9IHB0
ciArIHRyZWUtPm1heF9rZXlfbGVuICsgMjsNCj4gLQloZnNfZGJnKEJOT0RFX1JFRlMsICJmaW5k
X2luaXQ6ICVkICglcClcbiIsDQo+ICsJaGZzX2RiZygiZmluZF9pbml0OiAlZCAoJXApXG4iLA0K
PiAgIAkJdHJlZS0+Y25pZCwgX19idWlsdGluX3JldHVybl9hZGRyZXNzKDApKTsNCj4gICAJc3dp
dGNoICh0cmVlLT5jbmlkKSB7DQo+ICAgCWNhc2UgSEZTX0NBVF9DTklEOg0KPiBAQCAtNDUsNyAr
NDUsNyBAQCB2b2lkIGhmc19maW5kX2V4aXQoc3RydWN0IGhmc19maW5kX2RhdGEgKmZkKQ0KPiAg
IHsNCj4gICAJaGZzX2Jub2RlX3B1dChmZC0+Ym5vZGUpOw0KPiAgIAlrZnJlZShmZC0+c2VhcmNo
X2tleSk7DQo+IC0JaGZzX2RiZyhCTk9ERV9SRUZTLCAiZmluZF9leGl0OiAlZCAoJXApXG4iLA0K
PiArCWhmc19kYmcoImZpbmRfZXhpdDogJWQgKCVwKVxuIiwNCj4gICAJCWZkLT50cmVlLT5jbmlk
LCBfX2J1aWx0aW5fcmV0dXJuX2FkZHJlc3MoMCkpOw0KPiAgIAltdXRleF91bmxvY2soJmZkLT50
cmVlLT50cmVlX2xvY2spOw0KPiAgIAlmZC0+dHJlZSA9IE5VTEw7DQoNClRoZSBmdW5jdGlvbiBu
YW1lIHByZWZpeCBpc24ndCBuZWVkZWQgZWl0aGVyIHdpdGggZHluYW1pYyBkZWJ1Zy4NCg0KZWNo
byAnZnVuYyBoZnNfZmluZF9leGl0ICtwZicgPiAvcHJvYy9keW5hbWljX2RlYnVnL2NvbnRyb2wN
Cg0Kd2lsbCBhZGQgaXQNCg==

