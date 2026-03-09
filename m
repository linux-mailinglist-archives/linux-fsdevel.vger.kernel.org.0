Return-Path: <linux-fsdevel+bounces-79810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4AsxH5P5rmnZKgIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-79810-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:47:15 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B11223CFF3
	for <lists+linux-fsdevel@lfdr.de>; Mon, 09 Mar 2026 17:47:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7DADE3094146
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Mar 2026 16:37:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76080314D08;
	Mon,  9 Mar 2026 16:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="pXywLHZK";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="IMeUWmlD"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBD53A9D8A
	for <linux-fsdevel@vger.kernel.org>; Mon,  9 Mar 2026 16:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.154.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773074249; cv=fail; b=GRtUJUe+qLamltO/u9+E97sTCIcBeU9Mer7XdOJQCC9N4ckVR+nat67rn4vJ6EL8o2iMhMfxVs/Lf3e/08PIXMdf+OMMM7PDCJCGXUYhz5RpH92GQPm/KQyk2lEFCZ4f7tdudW3XH52F2cEY8fLD9+8lukDoY2vCow/2FlWkoO4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773074249; c=relaxed/simple;
	bh=EGlnKYV0KB4+C6VV9SXm97GWbLyYwYRBjJegzen7syw=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=rejZ/4mQI867nd7qf58CAsGM3vkgj7hef3pMgee3ngvSSXidw6XIKyCBviT4j/5LKeObAkIzaIEY3cm0G8CJ/t0SWEJg7T3Sldcm1VchC2zHg3rjmH8JUUTXqNyuUta6QztgZg1PnoIRIe0Z6GLZUg7MmGnZJ5H4TDoHTw+i7c8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=pXywLHZK; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=IMeUWmlD; arc=fail smtp.client-ip=216.71.154.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1773074245; x=1804610245;
  h=from:to:cc:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=EGlnKYV0KB4+C6VV9SXm97GWbLyYwYRBjJegzen7syw=;
  b=pXywLHZKi6HsAwEVSDTs/J6EAryZBfQlMywEOLhwuJDVoQ5p6AD6St+Y
   cQMeb89+fzJAep2I7f/Jz6gkFHQ41acI/nInEw5mBmIi6z/9iN7PEnSRm
   ilc0gAnsTKO9ldX/g8T2YYCus90F5x6qoAH7pUx15hvqcAOx/m7ngDK8X
   EQQEAqt4uXv5iyNCyPzbRkZ+Lyqx/ZzBw+FGd4eWardWZBcHUWJsnQykd
   pcjL/wYlAH2TzcXD7OMfuKVilfxzkRjlXRF5GsxIKZseYEGwD4BVcz7Zl
   x0ZKN6mXikGaLthXBsrfr15pbZqwEfoJtQzqJdt9g0LeQXU9v+8Ch3CfO
   A==;
X-CSE-ConnectionGUID: sZ/i24APSFqO9GdypK0zkA==
X-CSE-MsgGUID: Pb5r+1rVSjuNXqHo34x4AQ==
X-IronPort-AV: E=Sophos;i="6.23,109,1770566400"; 
   d="scan'208";a="141207300"
Received: from mail-northcentralusazon11013071.outbound.protection.outlook.com (HELO CH4PR04CU002.outbound.protection.outlook.com) ([40.107.201.71])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 10 Mar 2026 00:37:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=edtPgH8/LLgUbRRp0eCSRVdLsXjHwIhmQdXlMmXE4HpTMMUrQIv5bl/7XTChIxt+kwI2xgJRVLiQdYWbak1RZotfuc+3c76Cx9YKNr+GYmdvqPYlQG+mX+IQui3CJazbh7aULfpe+MY7TLDbwKKlPoKWqm6jcfq6DzETjsutX2W1BQix3aYU6APkGcucOng8X7rAR0XkkoZizU/Qckm7M0R+3SP/dsFMCKNNrAWxNBvNBKxT+brgFm3GW60wzzUZ9aK5DZszOg/ngrd9YGZ46B8bLSD4bNXvTaj3ScSLJF0ZJS+iY8TlVlse+5hhocymh7XEKA6iYp3XYxdBC+TSLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EGlnKYV0KB4+C6VV9SXm97GWbLyYwYRBjJegzen7syw=;
 b=JQfXgkZEvXihJCGVFgZCKEqGXRJ030Xtlkho4nCDAQ0CbMmXXD/5TQ/1YBTpHqT7du8cJttx244UkpBKD1WHmnOfGtjE6oLZBD5vr9ZXrS1kjmwEoGwmwatEplXDVf1fAUza/oJZwFxQIORSGclPujl5Ju2+SHn7pm7ifYkjiUgGsf6+PdqxbN4FaUe8mwAOmrQbNkmET6DZGCFozsSTAxbIvi9uhDUWda70TVJAKDLll6ZUZuDoPZyc9bX2AQFn0d2p7dWW/vFlY2TpRLoetfN/z5idTikfj2vuUiBeszolwR+9uR5eSBjcz0CZH7+49AHk9AwoZURmuXI6/aeZBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EGlnKYV0KB4+C6VV9SXm97GWbLyYwYRBjJegzen7syw=;
 b=IMeUWmlDg9vNI/3TtPvPRpTiwU4fs+2Mt1xDjFSDteOMnayAkzoOJnJOxsJUNIDrEUWnwUNRztT+FOfud1umvYbqTq7zv8J35FeLR23T47wFjoVAhPsZHcUl/WbnTIsZI5gyYHqLYoAIhA5xdkEWalUTMHUkZG9nkQQAM3PWWSM=
Received: from LV8PR04MB8984.namprd04.prod.outlook.com (2603:10b6:408:18b::13)
 by PH0PR04MB7720.namprd04.prod.outlook.com (2603:10b6:510:4c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.25; Mon, 9 Mar
 2026 16:37:18 +0000
Received: from LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3]) by LV8PR04MB8984.namprd04.prod.outlook.com
 ([fe80::14a1:5b7a:6cf4:31a3%3]) with mapi id 15.20.9678.023; Mon, 9 Mar 2026
 16:37:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Joanne Koong <joannelkoong@gmail.com>
CC: "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap: fix
 invalid folio access after folio_end_read()")
Thread-Topic: Hang in generic/648 on zoned btrfs after aa35dd5cbc06 ("iomap:
 fix invalid folio access after folio_end_read()")
Thread-Index: AQHcr+L+HQEHLTRjl0am4cBZ4kg4eQ==
Date: Mon, 9 Mar 2026 16:37:18 +0000
Message-ID: <b3dfe271-4e3d-4922-b618-e73731242bca@wdc.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR04MB8984:EE_|PH0PR04MB7720:EE_
x-ms-office365-filtering-correlation-id: 2daf05a5-7e8a-48af-6b70-08de7dfa20fa
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|19092799006|376014|10070799003|366016|38070700021;
x-microsoft-antispam-message-info:
 aRXeabMEa+m7TLJtCnkaG4EX9q8nI/i0nvkHkmWUur+1NCjfZpm9JMN8UkYOniB2dKiJCSiGD1TR3kuGQa53468VM8uoGSS5ATUO196gVs1YgpOiJk7V60dU3gmIWKMoydtowE3VlM3rpbOKxo8+j12xBo3XyY3cZZslbmYTShr8vqoDeyKXdA0HRBZw9nbJMuwuN0bnKifwMYyCOXjUhsM4jLol7zAzHPGtgz1Wuwe8NFWlYJ8Oyu6ZDSMdzKhyP5bjfjJL21ADk6HwAaGemI3V544kbPXkBgi9urbz1CI3CVt0hEWeUOZ+FEtPdXHdl1RTtxvr9RIVeS1dyarno0ccagcdxg7SjpiZlK+abtxsN9DLJo+sSZa947SpirNExUupWuKoqRKjQKrSPI5BMWuCRH3ZHW/hE4GfUBXo0VOKRm6byik/UMWr9pRP/Jl3YaZj0TlyThuvF6HRPLzHGXlnf91TXcarE70BwcFM6l67bKw/HECZv6A7cWgB6KS4daJzwnkt2VKvhAHRj+r6tEWw46otMZnslcrHNtY2IMg++4+N+O7V8KlR02AQRDdAzXaWvhEP1mlj7g08tybVcFuj1b+AWoHyShKboC6QxB0oBoZHB0y80EZh3M17jit5id/WRNUIuc22es5tRJlCqfNdhVIJg/76329oei6evqAaVkDktKFNgqkEvV6BZPA1kKVSydCvgUVgVUwxF5QFSIEvXYN4XVDgBxpWBxQY2haKoQVDt7VXkxCFx20DIeoY/7fFCOb+GmWxJQqN7vKVZd5F9sHGPuo8bXJOUImzjeI=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR04MB8984.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(19092799006)(376014)(10070799003)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?SVVmbHFXNEl5RVQ1bW9BbzRSTElQb2l3bExmOXcrTjVubGRGQzFpaVRHVXFo?=
 =?utf-8?B?ajQvbnBRT3daMVB0eitiZTZnUmNqNzZwS3RYOTZwRWxPVmx5bEF1OUppZDJw?=
 =?utf-8?B?Sk1LckdSc3hISDZEWjJZYWIrcDIrak5HOGpBUnRiM1pZd090MmlvN1ZxZWxz?=
 =?utf-8?B?N2NwZTAzMlZ6SEtwZ0pvcVdqNHlITmxIbjU2ZTFpREFjYlVUWTNIYnJSM2xu?=
 =?utf-8?B?NWVxdmJXZkxDOWJwT3JIbnExS3FNRHNtQ3dRVENIaTJlT3JiQlZJdHBpcWhI?=
 =?utf-8?B?eXdCZXVWT1ZLVWYvNzdDWW1zdGZNb3R5OTlUYXJkbW1MckdUN09hSkYyVm1S?=
 =?utf-8?B?ZXhBNkRIeU8xbkR0TFE1bHN4OGxSS1FFZS9PbXlhanJEanRuOVRVS1BVdDRJ?=
 =?utf-8?B?TjUvVmZpbHFoQjJjRHZSWHVnZkovRThOZGFLQlhHWlF3YytPenROS3Urb3Na?=
 =?utf-8?B?MHJCTzJSVVVBQTJ6c0dCcFMycDJ2WDlaTkJPaElCK1dKaThNQUNsZTlEalR2?=
 =?utf-8?B?UndOSVhMZnZJUU9NbEEySGJGUTRja2MzRlBoa0o2QUdGQTVzRmpjSUx2UGJV?=
 =?utf-8?B?TkM0ckpGQW5Lc2dXTVp6TEt2bFllWUczRGNLYmw0L3JMRXBUUU5mbEhUSFJQ?=
 =?utf-8?B?SWREdys5SnZ2a2pzQVE0aTZ5aVJFV3AzbjZnbjNYRHphS1kzOU1GVlIra2ky?=
 =?utf-8?B?bEVkNFdjOEtiNG9MdmhvZzRxYjFFQ25jMGxSTDhCQVY4R000K2x4NEJJTGh3?=
 =?utf-8?B?aTEwaGcrbVVrOWZUOTBxSXJhaDBoVU90eTVRQUN3RWoyTGpoNXBmL1NQZi93?=
 =?utf-8?B?cnZxT2tMTU44Ni9SQkdJRXJNQ3U1RytVTmJHanM3L0F2Sm9DYjJQOU5Sa01s?=
 =?utf-8?B?ZGcxRSt0clBjMkhDYlpTSi9tMjJSNTZ1bTN1WVNwaFQ2bUp2Q0o2UWl6cWM4?=
 =?utf-8?B?THpBVlF4aFRJeXhyWTdBRStuSkhldC96QlFwYTNSRFdFVWkrdFQvTUxjbTVW?=
 =?utf-8?B?ZlN2blQ4azNTUXJ1NEtjcS9PQkxYbmtqVXNyc05XYytac0tIb01ZWWpOWDZD?=
 =?utf-8?B?bzdSdmhBSDIwWm9UczQ1cDYvaWlDbnB2SGE2RWR3aHhzRkgvMnhZaTAzbkR6?=
 =?utf-8?B?azcyRXYrODJpYnVZZXlrcGRMbUhkMi9LWDlxMktZVzA2MUhISnkyUUtINEJj?=
 =?utf-8?B?OTNzY016THQ0VUFyOFRWczBRMUM5WTJGNittZGlhM1B4K1N4WGN3UndOb21l?=
 =?utf-8?B?cFF6NzJpK3dOTTZRVFB0aG1OVWVGZFBhc2RFNmNPdzZneHdWYitKa0Z6cVFq?=
 =?utf-8?B?akZ5Q054d0VuYTFNRnNYTzlhWVk3MUVVaEg0c1NzanlMdWUvVmpVSkpGQjNn?=
 =?utf-8?B?Yjl5Rmx0SmhienpybXo5UUVDakUzcjFqZ0lwVlVza1pYeExiYTZFWnhCbk1S?=
 =?utf-8?B?YTFoR0FidkROdG5RSHZ2bktLQnVjNGVKVFZoSDFLbUF4bW4yVEFHNXo0UUhh?=
 =?utf-8?B?bnZTK0x6dDk1aTgrQ1hSeGhiK1QwbytHM3laY3lndVVONVZQSmJaaVpqRlY3?=
 =?utf-8?B?cW5QSVJaTGxybFA3LzlPSit5eEg1MnV0S3BCTHdITFg0eG9sOW9BdFBuVlNz?=
 =?utf-8?B?L0FnTEpQV1JsZlVvb3BrcTdzeFNvOUVLMDEyV0VTMEFZYVlDZVpmellWdU5j?=
 =?utf-8?B?eEJmY2RlR1V1Tzl0WEFOenNZZE81NmpyMXJycE9Ybng1eEUxQTJjM01ncUlN?=
 =?utf-8?B?NURtMGZ0RTJTNEU1cDhzeCtDamxSdDdReVFQYnR2ZjQyN0h1ZlRDRGxIUGc1?=
 =?utf-8?B?REI0cmRjYVkwRGZmUzhyaU96cStTQTFqdzNDc0cwZ2NZNUJldVpZcW5sL0lV?=
 =?utf-8?B?ZUtwWVpCKzJ2STluSkoxZDdkY2tOc0E4dUdDUVR1TU5NaGgwS3UzOHI4NlNH?=
 =?utf-8?B?N2dVMncwTitORUF1c0tQUFE0aVExdVk2MHVPbHJyWXlPMkdlQ28yZG9HdUxt?=
 =?utf-8?B?MGRXTE1vR2J1V0QvcnpOUWpRL2ZCaWFrSkpWQktUZmYrc2dlWmZFTVFMb1Fm?=
 =?utf-8?B?am4rdEkwUWQrYTl0TDYyMW5memRGSUdQRlROVmNDUlJVb0NRRzlrS2hIWmlq?=
 =?utf-8?B?MlYwcG4veGlYTXMwbmFKa2pQenAwejdKb1ZTNDVBQjRWY3BtQ21XRW96Yjd0?=
 =?utf-8?B?Vmw0YlBFYmJ0QWVPelRVVnNKa2VWNWpMWU4zTDNnTXlacjI5L05xTENJSFFj?=
 =?utf-8?B?S3lqMGM0dEtQRExpYlEzYnYzTHFhL3ZpdE8vWEliYmxyZUMvUWE4NEx2SzFj?=
 =?utf-8?B?dUNvYlZpdVZrc0xGeC9ZSitFbW5YNVhkUWM4RXdqOTNwdm40clRsbk45T0Rs?=
 =?utf-8?Q?byQSaRGHhP4+7rPLa8+GzpLkAfDLIZrQrM8LDzGRNalN8?=
x-ms-exchange-antispam-messagedata-1: loqOc5IVMCUUZZNi7Gl7jmC5JA6VNUhpKLY=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB9FD9E741F0EE4BBE747F5271177C30@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Exchange-RoutingPolicyChecked:
	je9+zpmbdMPaJ9w37a9yMPHPX4FL62ik5Cjp2thrshBVvC7CMDBRXjwjSnYCoox1ROpH5ZXpCi7EHKBTg48VwSo9WQkmzj7X5aqo7xJFd5bD3Y/ltP2h7n2SID55X5VD0cVzb1uapon7lRyWjzc9kdZ/iFFGo3zU8gzSAh6qmuB4kh3wSaUe2XjjShTV53WtHYXHUBc+YVH3fOsMH15onoGmvMsbHCRdMY5MySOZwE7yhs/xY5HhVqMu3IZzRmfX9tFiU9JEZEMHpP5IPTPsCS1lsNp7cD9dmOeLNGlYHPiJUk8lnk35LcN5wtLUHZs7bZg6mnX7bMuGpyFMVhHUfw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	DtEmZ8M2JTmbKdMSzZgOgSfe/BHUBWAIdA2xpKM2oC9Py6CzmH1+sPT+Kqb3n9Xr1aKCo0eIkVnuruCJY529EckIupW2fmkE4rS/IR/G8WvA802UTrPtkM7oZSxo5RugQDwUwOrlNB1LJz2a++syWzmH7DrqmNilA/MAnKuTn2pBFjqP27e0DMMp7ZBObdvgEYkhcYNuUFcuWgjHeeyRpcJU1lU9hYeyZpVhoaSA+kGeRi+SAi3tniI3WeO9z/VWKVJNIZT2GjZwWLfjeabv4No8td3mXlO4pxRfzky4LqOTqqMjdiNRQ0AmJEQh8DZk+PJ3TnV0re2i8gehcarEMfmixq+APzDufjG/oCr4nP8ZFq7ZChM4Iqe8bRz7rz1/+VeQhZoZaBv3a1tPEMrfdJyGbmQL3P5i4xTbAdwKNPNxV17H4pEwbNnYs6KW7yOWFSt2sWgSy9Lke6N/WPSMT4uJeECjr3HPMyhDWgBKiwz2LoWM2XXG2L/7/Vyw/QW1i3baB6ykyPhOtXcukNo5CRo6HVx7Rabk2Gf2D5GeofwuneNGaLscpN+e5miOoeYmN0UwPVmfVBRoikBXQo8bvWKwTNcqobqceaICDrLzmKLZYZgYDtO0xFB0aagRHRAl
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: LV8PR04MB8984.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2daf05a5-7e8a-48af-6b70-08de7dfa20fa
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Mar 2026 16:37:18.0678
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5PXLF8DXMgZsbVKBSDA8FBQVI/n8M0DyzJFa43Pxy3BOhgiXVItv1Nevjw7xFw+ZKEXF/0amSQDjDciW540ba+YSGUKrOJZJT4buHCG2lyU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7720
X-Rspamd-Queue-Id: 0B11223CFF3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.06 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-79810-lists,linux-fsdevel=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Johannes.Thumshirn@wdc.com,linux-fsdevel@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,wdc.com:dkim,wdc.com:mid]
X-Rspamd-Action: no action

SGkgSm9hbm5lLA0KDQpBZnRlciBjb21taXQgYWEzNWRkNWNiYzA2ICgiaW9tYXA6IGZpeCBpbnZh
bGlkIGZvbGlvIGFjY2VzcyBhZnRlciANCmZvbGlvX2VuZF9yZWFkKCkiKSBteSB6b25lZCBidHJm
cyB0ZXN0IHNldHVwIGhhbmdzLiBJJ3ZlIGJpc2VjdGVkIGl0IHRvIA0KdGhpcyBjb21taXQgYW5k
IHJldmVydGluZyBmaXhlcyBteSBwcm9ibGVtLiBUaGUgbGFzdCB0aGluZyBJIHNlZSBpbiANCmRt
ZXNnIGlzOg0KDQpbwqAgwqAgOS4zODcxNzVdIC0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0t
LS0tLS0tLQ0KW8KgIMKgIDkuMzg3MzIwXSBXQVJOSU5HOiBmcy9pb21hcC9idWZmZXJlZC1pby5j
OjQ4NyBhdCANCmlvbWFwX3JlYWRfZW5kKzB4MTFjLzB4MTQwLCBDUFUjNTogKHVkZXYtd29ya2Vy
KS80NjMNClvCoCDCoCA5LjM4NzQzMV0gTW9kdWxlcyBsaW5rZWQgaW46DQpbwqAgwqAgOS4zODc1
MDJdIENQVTogNSBVSUQ6IDAgUElEOiA0NjMgQ29tbTogKHVkZXYtd29ya2VyKSBOb3QgdGFpbnRl
ZCANCjYuMTkuMC1yYzErICMzODUgUFJFRU1QVChmdWxsKQ0KW8KgIMKgIDkuMzg3NjI2XSBIYXJk
d2FyZSBuYW1lOiBRRU1VIFN0YW5kYXJkIFBDIChpNDQwRlggKyBQSUlYLCAxOTk2KSwgDQpCSU9T
IDEuMTcuMC05LmZjNDMgMDYvMTAvMjAyNQ0KW8KgIMKgIDkuMzg3ODEwXSBSSVA6IDAwMTA6aW9t
YXBfcmVhZF9lbmQrMHgxMWMvMHgxNDANClvCoCDCoCA5LjM4Nzg4Nl0gQ29kZTogMDAgNDggODkg
ZWYgNDggM2IgMDQgMjQgMGYgOTQgMDQgMjQgNDQgMGYgYjYgMzQgMjQgDQplOCBiOCA4OCA2OSAw
MCA0OCA4OSBkZiA0OCA4MyBjNCAwOCA0MSAwZiBiNiBmNiA1YiA1ZCA0MSA1ZSBlOSA1NCBlNyBl
OCANCmZmIDwwZj4gMGIgZTkgNDggZmYgZmYgZmYgYmEgMDAgMTAgMDAgMDAgZWIgOWQgMGYgMGIg
ZTkgNTMgZmYgZmYgZmYgMGYNClvCoCDCoCA5LjM4ODA5Nl0gUlNQOiAwMDE4OmZmZmZjOTAwMDBl
Mjc5YzAgRUZMQUdTOiAwMDAxMDIwNg0KW8KgIMKgIDkuMzg4MTc4XSBSQVg6IGZmZmY4ODgxMTFj
NmI4MDAgUkJYOiBmZmZmZWEwMDA0MzYzOTAwIFJDWDogDQowMDAwMDAwMDAwMDAwMDAwDQpbwqAg
wqAgOS4zODgyODFdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAwMDAwMDA0MDAg
UkRJOiANCmZmZmZlYTAwMDQzNjM5MDANClvCoCDCoCA5LjM4ODM4Nl0gUkJQOiAwMDAwMDAwMDAw
MDAwMDAwIFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IA0KMDAwMDAwMDAwMDAwMDAwMQ0KW8Kg
IMKgIDkuMzg4NDkxXSBSMTA6IGZmZmZjOTAwMDBlMjc5YTAgUjExOiBmZmZmODg4MTExYzZjMTY4
IFIxMjogDQpmZmZmZmZmZjgxZTVjZGIwDQpbwqAgwqAgOS4zODg1ODVdIFIxMzogZmZmZmM5MDAw
MGUyN2M1OCBSMTQ6IGZmZmZlYTAwMDQzNjM5MDAgUjE1OiANCmZmZmZjOTAwMDBlMjdjNTgNClvC
oCDCoCA5LjM4ODY5MF0gRlM6wqAgMDAwMDdmNmUwM2ZkZmMwMCgwMDAwKSBHUzpmZmZmODg4MmI0
YzEzMDAwKDAwMDApIA0Ka25sR1M6MDAwMDAwMDAwMDAwMDAwMA0KW8KgIMKgIDkuMzg4NzkzXSBD
UzrCoCAwMDEwIERTOiAwMDAwIEVTOiAwMDAwIENSMDogMDAwMDAwMDA4MDA1MDAzMw0KW8KgIMKg
IDkuMzg4ODczXSBDUjI6IDAwMDA3ZjZlMDMyODAwMDAgQ1IzOiAwMDAwMDAwMTEwNmQ3MDA2IENS
NDogDQowMDAwMDAwMDAwNzcwZWIwDQpbwqAgwqAgOS4zODg5NjddIFBLUlU6IDU1NTU1NTU0DQpb
wqAgwqAgOS4zODkwMDZdIENhbGwgVHJhY2U6DQpbwqAgwqAgOS4zODkwNDRdwqAgPFRBU0s+DQpb
wqAgwqAgOS4zODkwODddwqAgaW9tYXBfcmVhZGFoZWFkKzB4MjNjLzB4MmUwDQpbwqAgwqAgOS4z
ODkxNjddwqAgYmxrZGV2X3JlYWRhaGVhZCsweDNkLzB4NTANClvCoCDCoCA5LjM4OTIyMl3CoCBy
ZWFkX3BhZ2VzKzB4NTYvMHgyMDANClvCoCDCoCA5LjM4OTI3N13CoCA/IF9fZm9saW9fYmF0Y2hf
YWRkX2FuZF9tb3ZlKzB4MWNmLzB4MmQwDQpbwqAgwqAgOS4zODkzNTRdwqAgcGFnZV9jYWNoZV9y
YV91bmJvdW5kZWQrMHgxZGIvMHgyYzANClvCoCDCoCA5LjM4OTQyM13CoCBmb3JjZV9wYWdlX2Nh
Y2hlX3JhKzB4OTYvMHhiMA0KW8KgIMKgIDkuMzg5NDcwXcKgIGZpbGVtYXBfZ2V0X3BhZ2VzKzB4
MTJmLzB4NDkwDQpbwqAgwqAgOS4zODk1MzJdwqAgZmlsZW1hcF9yZWFkKzB4ZWQvMHg0MDANClvC
oCDCoCA5LjM4OTU5MF3CoCA/IGxvY2tfYWNxdWlyZSsweGQ1LzB4MmIwDQpbwqAgwqAgOS4zODk2
MzNdwqAgPyBibGtkZXZfcmVhZF9pdGVyKzB4NmIvMHgxODANClvCoCDCoCA5LjM4OTY3OF3CoCA/
IGxvY2tfYWNxdWlyZSsweGU1LzB4MmIwDQpbwqAgwqAgOS4zODk3MjBdwqAgPyBsb2NrX2lzX2hl
bGRfdHlwZSsweGNkLzB4MTMwDQpbwqAgwqAgOS4zODk3NjFdwqAgPyBmaW5kX2hlbGRfbG9jaysw
eDJiLzB4ODANClvCoCDCoCA5LjM4OTgxM13CoCA/IGxvY2tfYWNxdWlyZWQrMHgxZTkvMHgzYzAN
ClvCoCDCoCA5LjM4OTg2NF3CoCBibGtkZXZfcmVhZF9pdGVyKzB4NzkvMHgxODANClvCoCDCoCA5
LjM4OTkxMV3CoCA/IGxvY2FsX2Nsb2NrX25vaW5zdHIrMHgxNy8weDExMA0KW8KgIMKgIDkuMzg5
OTc1XcKgIHZmc19yZWFkKzB4MjQwLzB4MzQwDQpbwqAgwqAgOS4zOTAwMzNdwqAga3N5c19yZWFk
KzB4NjEvMHhkMA0KW8KgIMKgIDkuMzkwMDgzXcKgIGRvX3N5c2NhbGxfNjQrMHg3NC8weDNhMA0K
W8KgIMKgIDkuMzkwMTQzXcKgIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsweDc2LzB4
N2UNClvCoCDCoCA5LjM5MDIwNF0gUklQOiAwMDMzOjB4N2Y2ZTA0OGM1YzVlDQpbwqAgwqAgOS4z
OTAyNTVdIENvZGU6IDRkIDg5IGQ4IGU4IDM0IGJkIDAwIDAwIDRjIDhiIDVkIGY4IDQxIDhiIDkz
IDA4IDAzIA0KMDAgMDAgNTkgNWUgNDggODMgZjggZmMgNzQgMTEgYzkgYzMgMGYgMWYgODAgMDAg
MDAgMDAgMDAgNDggOGIgNDUgMTAgMGYgDQowNSA8Yzk+IGMzIDgzIGUyIDM5IDgzIGZhIDA4IDc1
IGU3IGU4IDEzIGZmIGZmIGZmIDBmIDFmIDAwIGYzIDBmIDFlIGZhDQpbwqAgwqAgOS4zOTA0NDdd
IFJTUDogMDAyYjowMDAwN2ZmZGY1MGNkZWQwIEVGTEFHUzogMDAwMDAyMDIgT1JJR19SQVg6IA0K
MDAwMDAwMDAwMDAwMDAwMA0KW8KgIMKgIDkuMzkwNTI5XSBSQVg6IGZmZmZmZmZmZmZmZmZmZGEg
UkJYOiAwMDAwMDAwMTNhYTU1MjAwIFJDWDogDQowMDAwN2Y2ZTA0OGM1YzVlDQpbwqAgwqAgOS4z
OTA2MTldIFJEWDogMDAwMDAwMDAwMDAwMDIwMCBSU0k6IDAwMDA3ZjZlMDMyN2YwMDAgUkRJOiAN
CjAwMDAwMDAwMDAwMDAwMTQNClvCoCDCoCA5LjM5MDcwNF0gUkJQOiAwMDAwN2ZmZGY1MGNkZWUw
IFIwODogMDAwMDAwMDAwMDAwMDAwMCBSMDk6IA0KMDAwMDAwMDAwMDAwMDAwMA0KW8KgIMKgIDku
MzkwNzg5XSBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAwMDAwMjAyIFIxMjog
DQowMDAwMDAwMDAwMDAwMDAwDQpbwqAgwqAgOS4zOTA4NjZdIFIxMzogMDAwMDU1ZDVmOTlmYTI3
MCBSMTQ6IDAwMDA1NWQ1Zjk2ZTVjYjAgUjE1OiANCjAwMDA1NWQ1Zjk2ZTVjYzgNClvCoCDCoCA5
LjM5MDk2N13CoCA8L1RBU0s+DQpbwqAgwqAgOS4zOTA5OTddIGlycSBldmVudCBzdGFtcDogNTQy
NjkNClvCoCDCoCA5LjM5MTA0NF0gaGFyZGlycXMgbGFzdMKgIGVuYWJsZWQgYXQgKDU0Mjc5KTog
WzxmZmZmZmZmZjgxMzhhYzAyPl0gDQpfX3VwX2NvbnNvbGVfc2VtKzB4NTIvMHg2MA0KW8KgIMKg
IDkuMzkxMTQxXSBoYXJkaXJxcyBsYXN0IGRpc2FibGVkIGF0ICg1NDI4OCk6IFs8ZmZmZmZmZmY4
MTM4YWJlNz5dIA0KX191cF9jb25zb2xlX3NlbSsweDM3LzB4NjANClvCoCDCoCA5LjM5MTI0MF0g
c29mdGlycXMgbGFzdMKgIGVuYWJsZWQgYXQgKDUzNzk2KTogWzxmZmZmZmZmZjgxMzA0NzY4Pl0g
DQppcnFfZXhpdF9yY3UrMHg3OC8weDExMA0KW8KgIMKgIDkuMzkxMzI3XSBzb2Z0aXJxcyBsYXN0
IGRpc2FibGVkIGF0ICg1Mzc4Nyk6IFs8ZmZmZmZmZmY4MTMwNDc2OD5dIA0KaXJxX2V4aXRfcmN1
KzB4NzgvMHgxMTANClvCoCDCoCA5LjM5MTQyMF0gLS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAw
MDAwMCBdLS0tDQoNCkkgaGF2ZW4ndCBkZWJ1Z2dlZCB0aGlzIGZ1cnRoZXIgeWV0LCBtYXliZSB5
b3UgaGF2ZSBhbiBpZGVhIHdoYXQgDQpjb3VsZCd2ZSBjYXVzZWQgaXQuIE9uIG15IHNpZGUgaXQn
cyB0cml2aWFsIHRvIHJlcHJvZHVjZSwgc28gaWYgeW91IA0KY2FuJ3QgcmVwcm9kdWNlIGl0IGp1
c3QgeWVsbC4NCg0KQnl0ZSwNCg0KIMKgIMKgIEpvaGFubmVzDQoNCg==

