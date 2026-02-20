Return-Path: <linux-fsdevel+bounces-77768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AKciDgUKmGkK/gIAu9opvQ
	(envelope-from <linux-fsdevel+bounces-77768-lists+linux-fsdevel=lfdr.de@vger.kernel.org>)
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 08:15:17 +0100
X-Original-To: lists+linux-fsdevel@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B632B16535E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 08:15:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 25D41302F38E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Feb 2026 07:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B4E283FE5;
	Fri, 20 Feb 2026 07:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="fRm25R6I";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="UYhoJ4Yi"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0981D233D85;
	Fri, 20 Feb 2026 07:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771571702; cv=fail; b=uZS7wOEIDHz+Ap9JR0cvmqcFl15vBWNRFaiZ+JhaA6Vrxx8lrA/a0hvOjnNoLVaKvWPGjYYJ+3t0Ohh72y6GXIzl4OU59dyRChqSLNKjaolAFcPPLQfKxWuKQ8Mf/QDFyyUNmNh3fs6d147UAaz1mrILCr+ksA/EIchgg7vqE4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771571702; c=relaxed/simple;
	bh=a6P2m0VGycXwDkDXWwZpWZGbsLBHD8tASmpZKp5+AYI=;
	h=From:To:Subject:Date:Message-ID:Content-Type:MIME-Version; b=cavGIh5UrRI90fkQAroHmJH1EHRukSRWawRiTvp+YqUqBDJGBad37S184oM2NEGYsu6AdXsk4zrj0L5Zl1kSbhRtwO25HqeXhQpmkGvcEbmWMubKVF4DGsq9v0beKU/teEshn6G1aVC02VGCfxvkWqTrogMtZdSyc7SlAadzLi4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=fRm25R6I; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=UYhoJ4Yi; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1771571700; x=1803107700;
  h=from:to:subject:date:message-id:content-id:
   content-transfer-encoding:mime-version;
  bh=a6P2m0VGycXwDkDXWwZpWZGbsLBHD8tASmpZKp5+AYI=;
  b=fRm25R6IAg+LaXIX0MS9LLa8jjAeU/3yfUzYXtOCDhWj1lG/RE+xbPoh
   QATJmXEaZ54eaiQiGNQcmEZj/vqgvba7o0d+PVvJS/4sadnQ3hGdT5sNd
   cgIeyd41qOLrv0bRpS0nTws2vAAdMEGv9a5rIp6kPpbX30TerQim016Lo
   2w9T31J39j30hRCJaHodFMr8I6m0Z/k5Fequv1l8BePBGImDOopG/SItn
   vevVnrI9lMIAjXT1SWM0Sf8TPOk8n3pBEqsu9bMU3AziijYkFsZ2SXcGI
   yqsG4Z5+DFZ+35D9HEQD7TT0oz2urklMF72FBGfBMWkrewZsIZ7m8yKPJ
   Q==;
X-CSE-ConnectionGUID: c9NtDVI9Rm619V7xIi0kWw==
X-CSE-MsgGUID: ssMlFopWQxuiGerZUxRhxA==
X-IronPort-AV: E=Sophos;i="6.21,301,1763395200"; 
   d="scan'208";a="141074820"
Received: from mail-eastus2azon11010064.outbound.protection.outlook.com (HELO BN1PR04CU002.outbound.protection.outlook.com) ([52.101.56.64])
  by ob1.hgst.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 20 Feb 2026 15:14:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rQXJa6FjzAWoa1eJLKU+sdannUoxq0XcYJ8AHtFRJkiNV1NCqyxG+k2k2IjAgDm0P3y8RyaNfw8JgBtVC5+noPUQD/RVsmvpiM+TRq+Wg4YM2LRkLl1/oGXxMqHmjryHiDQSe3tMnrWii5Tk/hV7fXoHFI749acti7lRhbXoWY7JGSqy9fH4g1SqWAuduXe+E3iuNdTuZuRW6LmC7o4xMDR6iCqa/sOV/tweXs6Cql1YD4Ci7dA9mbbL6GTswjP7RURF2Z1ay66tfbRTPGYRd02ocgh7hiHxInaSqpXxAuUcm981XJUbDDovIUiynz+qB86tMyzLv8Hs6WWm97s7Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a6P2m0VGycXwDkDXWwZpWZGbsLBHD8tASmpZKp5+AYI=;
 b=EkH84oovnMQDEN1X7cakTkrYSxlI3gHi1WgpWsBwRmhhzwwk6IJ5gJ8bIl7szpCTqgDMI+ESnyLL3Zenud6nQ+kaaOCxkS1nxl5C6+QdoVVQwoEbciHg4WEEN03/UvX2BNSDtmw4ys4QX9FfDQVvJVLXbH4hCofCWWPcIQvEzWJV0kYqCrDjT8DiPmJkp0et1MR5fOJ9W65kEPDA8fHgBiBfRUw0F7BaK91UPZz373Zswwi5t1ko0KMoHmafpo2ZB+UqS2LmTpYjaTKlwpIF9ud6lj4ElcOJuXngBvxmUXpZfdI/yVcQVGQGMhwysB6VM23kz5zrFO++Bzs0sAhAug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a6P2m0VGycXwDkDXWwZpWZGbsLBHD8tASmpZKp5+AYI=;
 b=UYhoJ4Yie5nLtGJoDZYqAEYwYeki8Iz4kBm2SSr3VFtZOL83CdpwAZAfcgvAJhy+WFu++jY9LVR9xSzovAfbJYzTuH0cDzeJAPC7clZ4x2dVSlBrO8GJk/i0leWJNXZseLUEdhrXBn+mczPA5Nu1mZ3r1USmt/nxqGxpW1nte9I=
Received: from DS0PR04MB9844.namprd04.prod.outlook.com (2603:10b6:8:2f8::22)
 by SA6PR04MB9144.namprd04.prod.outlook.com (2603:10b6:806:415::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.16; Fri, 20 Feb
 2026 07:14:58 +0000
Received: from DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a]) by DS0PR04MB9844.namprd04.prod.outlook.com
 ([fe80::9647:6abf:8734:547a%5]) with mapi id 15.20.9632.010; Fri, 20 Feb 2026
 07:14:58 +0000
From: Naohiro Aota <Naohiro.Aota@wdc.com>
To: "lsf-pc@lists.linux-foundation.org" <lsf-pc@lists.linux-foundation.org>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"bpf@vger.kernel.org" <bpf@vger.kernel.org>
Subject: [LSF/MM/BPF TOPIC] eBPF-driven Data Placement Hint
Thread-Topic: [LSF/MM/BPF TOPIC] eBPF-driven Data Placement Hint
Thread-Index: AQHcojievv+TwLEMbUOetoWYp2V58w==
Date: Fri, 20 Feb 2026 07:14:58 +0000
Message-ID: <DGJLR6FR7XLX.1D72IEB0DX9KC@wdc.com>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
x-mailer: aerc 0.21.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DS0PR04MB9844:EE_|SA6PR04MB9144:EE_
x-ms-office365-filtering-correlation-id: 543d9e2d-4704-44ee-a2a6-08de704fc14d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?utf-8?B?R0RtdUNhSHV0c3dsYkZ0Vnpmb1p5WUdIR20wYTh5eGQ0bWNTMk16RW9HMXhC?=
 =?utf-8?B?TjVyc0lCYXNSejRqb1ZaVFBITm1hSFRKR3lVMGZicmJ3MzlVYjd1cFJuNFBx?=
 =?utf-8?B?a2xSL2pZSnRDcEhGejhKNEJJanB5NzkvSU93RnpmQjR4ZHZXY21wdlBSbUw4?=
 =?utf-8?B?NnBtc2ZBRjhQZ20zZnhxWXNDeW5vSnViRGcwRVljVTN3b1kyV0U3V1RyZWtJ?=
 =?utf-8?B?NUZPRGNhOVJteWxIQm51LzRtS3RVKzQwTE1pWnZVaVNMZGxtUWhlc1djSEZI?=
 =?utf-8?B?aEtSZ3JJVkRJMjlqNi9McWRyTDlWZGpDYXZSN1dYRitnN2JsMkdDTDM4Mitr?=
 =?utf-8?B?eHFvMWN0cmdGcXlWcW5YaXd1L2cyWWs1UnFkeEQ1Um12Yi80c29UQjU1RjRD?=
 =?utf-8?B?SzV3TGlDcXJwOWhLai95WCtkcUpvYkNvWERvdUtHVmNQUWU2N2NqY2NDbUJQ?=
 =?utf-8?B?SG1KajJKc0JuRURGcmRWVkR2dzVSRk92ZTF4UHFFdFNTbktZeU9vSTNNM1N2?=
 =?utf-8?B?WTluTXBDb3pId0NBckxoR0h6UkJJdDdNVmt1ZHljUm1UWm9hSnZNMkszOU9F?=
 =?utf-8?B?MHJqN2E4eVAxNVkweXg2bnp5U1NkcVU0ZUNyWGhMdi9HL2J2M3Jzblh2RWFu?=
 =?utf-8?B?NDBMM3g2YzR1ZVlRRUp5M1RBY3ZMbzRyeHI2aTJVNzFBZFVTV2tXVnJ3ZzFJ?=
 =?utf-8?B?OHM0aU9XNU1FWUZNb3dRbUhYVFIzL3BqQVJPN0pPVVNzc3dDNDg4VWlYZVd6?=
 =?utf-8?B?eTdGbjduODd3eUQydnMyOXlzT09nK2xpMXpTQXNCdElOYW9qdWRFL000VGdo?=
 =?utf-8?B?VTFNT21YZDk2NllabXIvM2w5S2JGNEhZTFhQZW9jOGljL3lWUDN6emhrcnF5?=
 =?utf-8?B?dXI4WlRJc0FPanlqNzQ1T0pZY3VDVEJpR1V5WjM3Wm9HMjZ4cFJtSTZ6S0NI?=
 =?utf-8?B?U2x4N1FNUHB3a1cvL2h5RVM5Z1ZndjFJRDByQkhWdUd2UUIxSEp6RUMwc1Qv?=
 =?utf-8?B?TkozUnFSTU5FSlNmMUMybkx2RVRONHdVZjZNQXQzNEZOOGRHV3laM0pSdnRC?=
 =?utf-8?B?aVI3TVFldGFRc3hFZXR4RFVIVzZ3RTYwNVlDek1vczFGV204eDRLeFJMOUFU?=
 =?utf-8?B?ZW1sS0ljTWExcm1IOHRUY1VmS0IrNjRXQ0ZnSS9TNDB6YTlvZUFxWkxCaHAy?=
 =?utf-8?B?NEUrVjVVOFlmeXJqcXhNaUkyc1RJdDVsdXhNU282M1VrbUN3MnRnbzl6L3Fk?=
 =?utf-8?B?S1Z6ZDhCNXRja3ZlUkV3N05FNklXeDBIam1pNXpHZUNRODlRY3VGbFc5WFFZ?=
 =?utf-8?B?bUpVNEQ1dFA5aHZodytZVkVNV090MmpiYm1oWUhpbS9FSm5JRGFPVFM2cVA4?=
 =?utf-8?B?d1Rkc09PVTEwK0JPSHRQLzN6S2FrNmdhOHAxTWVyKy9VZDdlR0Zyc0lGRlRQ?=
 =?utf-8?B?anBJOXJKek12WTEzZVM3cU1vdEVTTm9vTUJCWEhJZzIxQVdQUmVZQXp5cHQ3?=
 =?utf-8?B?L3k5WXlUREQxWkNXc0wwSkJSRUhieDMxL0RYVmNIcGlCNWZHbDhwUmVaZDZD?=
 =?utf-8?B?Zk1iT21UQTRZeUVVRjR1VzBFUGhEL1plVWlXcDZBTkNxNDdtZGIrZ2dqd2ds?=
 =?utf-8?B?WkpXNld6ZFQvOHJpdzMrYWRQSjNjUVltM1djc0RmNmdvczBwaDdSRDdlMnk4?=
 =?utf-8?B?dGExKzNyR0xzVmorSjVXZzkvSXdrcjV2NVNhVUcyTVRHS3JKVzNzTzlPakl3?=
 =?utf-8?B?dUdKb1BEYUNidG1XU1F2aTBPTVhqZzRqSXdnRTdoSmJ5U29RU0xNZGp4eE80?=
 =?utf-8?B?RGVCOTh1R1pJKy8wRlhteWptWElxa0Mrbkh3Q0p6b2hRZ01YS05XVkpXNlZy?=
 =?utf-8?B?cEdFNkVqQmVkVk1IZlEzcms4c24rNm9vZmxyWnJKbnNSdENrbjVYRXpLRTJ0?=
 =?utf-8?B?WStDQzBsQmVrQW5lKzZDdTM5UjdCQVBqOFRrbmRhcXhWR3Z3MndJbmtWZHBE?=
 =?utf-8?B?WG1HYXFEdmwyNWMyZkxxTTlGTXl6KzVubS9ZdUFGU1BnMmNCa25EdlVVbVlS?=
 =?utf-8?B?RWt5WDJyS2p0QXpWS3YxVjNWdEtYbEpyenBreExXTjFMVUJYb1NYU0lNZWd4?=
 =?utf-8?B?OTh5a3p1dTl0c01hbFc3QTZ3WkprVFNzWHhGQ2d5QUREdEZ1QU5OSkpjNTMx?=
 =?utf-8?Q?ee+cqXG25/fXYZeV+km46vE=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR04MB9844.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?L0grWjlIcUFLUWNwSUk4N2l6dWJybG1PNXN0ZjJneHhnVCsrTDlIeWp5VG95?=
 =?utf-8?B?OUJRejh0R0ZHN2Vwb3dMSm1JaEFiTmVFWGxVZm11QnlsM3g0Vkc3Uk0vRUZu?=
 =?utf-8?B?U1BoZG9FWXNkZzkwcmhFdlVLak9EcE56K0sxN0lEMzEwRFJUSmhWU2xteXA1?=
 =?utf-8?B?ZEk1bWI5NmJIWFNwaGpHbWMvdjg3L3RMek5oZDRDZjhjcFNqcFAzYzh3TTVN?=
 =?utf-8?B?UUVpa2kxSlpLdHk2ZHVBK0RmeFJVbFRML0RjZDFDZUx4L3dJR0NTR0FBbEFV?=
 =?utf-8?B?a1hrMitYbjJnOUJQbm1ZNHhTQjFOYXcvN1NRemtzdU1iT004RXl4T08raTBF?=
 =?utf-8?B?WmZTR2I5QTE2R3M3Ym9UZitSWGg5ZGpxVE84MWlIdzVnVVJ0M2cyQ0VDNjlT?=
 =?utf-8?B?ckFFaWxZQlY5YTFxek1VNERzSndVYkU3K0huM1RDU2lSUkh1b3RxUkJiZlR5?=
 =?utf-8?B?Vk9KVm5ST2M5YkJaMnVJTGZwVEQwa1dtTVcxek5ld3lFRzlXbzdJMWJMYklX?=
 =?utf-8?B?Q1VYYUVVUkMxWlUySSs0WVlGY1NXWDVWOUhGK0RjWnAwOExyank2YXVsYzht?=
 =?utf-8?B?NWs2SWpmWko1TkVQdWpMV2pZNVVlYU9UQWE4SU1nRGVHR21pOXVNcDBMQkV0?=
 =?utf-8?B?NFNPanF4R2VuUTZoejl4ck53T202S3NWTFlUZTJ2RFBqNnY1Q2p1V1Zmb2lC?=
 =?utf-8?B?RHBhSGRGTEpJMzJONWJwNk9FWUZldStxWkFhVy92Wm9zREpwSlRPYThKNDVV?=
 =?utf-8?B?M3RUMUNJWXJ4V1lpcll3c1h5b3M4aXNVREs4eXpaTkJJRUFrNUFBN1MzVFQx?=
 =?utf-8?B?MGFZV3VNOVhxU3FPYVAzMVo0R3daWlM0SGR6R3lDMkhRVHZMTE0xMThINGRa?=
 =?utf-8?B?R0NqdG1rNjdxSmJOYWhZRDhaNS9pUUJyOFJTai9SSTZsaGdMNVdPdlBKSjhZ?=
 =?utf-8?B?K0hybnF1MUVvbHZ3ZEFqdjROT2ZTTW40bjRmdkVWYjl1TFAzL2FGaVErQXJj?=
 =?utf-8?B?ZTU0YkRpbmkxS3ZPL2VPbW0zdUxCVlBZd2hCUlc2NzViUWlnTUV4R3Fwd3pp?=
 =?utf-8?B?VnZOeVgyWU5qQUZ0VGJRREh6YmUrd240YUpqaW12NXJKaEc5eFkwZmsrWHB0?=
 =?utf-8?B?cmplV2t1b1MydDZCYVY5cWZjTmhQNmlIbzdTcDZZaDhBTk5VN3FJNVhST2Zu?=
 =?utf-8?B?cnBVcnFjek4zc1IrL1lwZkZsQndkczJTVjUvOEV6b1dzRi9DeWlPQmlValkv?=
 =?utf-8?B?NkZ0aTBnbWU2Y2VjMWFPVEZ6cnFmbXlwRGtGNFpNVUJkb3lvU3QvaUNGZkFu?=
 =?utf-8?B?QWIyWElDcmFjS3dEaVR3WXhuaEtJb2lKcGlpZ3ljTFZ4UElJd3BFMnlsMUZi?=
 =?utf-8?B?VnZCT2VCSlFDVUhrUXFlNjBIazhiWWgwNjFrQzU2bmFmMWwydnVMZDg4TG12?=
 =?utf-8?B?R3hpWFUwa2RGSEFJYndhUWxMemNNWTVjLzFuTnlSTW5wY0VkYzg3YUFCcWRR?=
 =?utf-8?B?UGpjWWtXc1FlTmdRZUYxa2E5RlI4WkU0SC8ydWNCczJaRkhwc2JxRUhkOWNP?=
 =?utf-8?B?VlMwVGhyUldCRGFVOWV5YVFMdXpVQUdra291cGhEajhiYW9hV3l4YXZaaUlI?=
 =?utf-8?B?TUVQSmUyRTV2MzFKY204QUlUL20yY0dwSWxWOFpST1c3bXp4ZjZYVkw0SFZB?=
 =?utf-8?B?a3N5eUZKK05NMThSSEthSEVEaUpRajBLTGhQc2ozZk1EUlB1bkY4Qk9mV3Nn?=
 =?utf-8?B?elpYcm1KQWc4bXZUdnUrY0dIR0ZHOE1jVGF6MldPbmpjRGdjMWU3empIZzIr?=
 =?utf-8?B?MlVHWm42Z3A1Z0hzQWZDOEtaWFY0SFhZUnRab1JRejVuTHNIYUdPcG53RDRy?=
 =?utf-8?B?RkY5WnZaWHYwN0c4RFdCbEZJQ04rRjNzS213cWxVTSt4N2FLdmNYVGpQeU1Y?=
 =?utf-8?B?cHV2VjBFbkkwSnhmN01hZk1YWHZUVllrT1dBKzJERmxUN2g4VlcyaDlBVzEr?=
 =?utf-8?B?VnM5eVV6SFdmWk81U1d5b0VWSTd5SWw3WXhuNEtJS21id2Fsck1FS0pRdEdX?=
 =?utf-8?B?N3plekpWQVI2Nkp0M3IyZnpMOTJZeG91cjRxSnhacVNzdGhiSG9wRm9KQ1dn?=
 =?utf-8?B?bDRIVjZjQlJqNEJmUFFEOFhBN0JRSDJqa3haMmplcmFrSGwwZkZVbnZqdmFr?=
 =?utf-8?B?SC9XUnhtYm1wUC90MThaVVQ0K3g1OVhyeWZZODVxNnJOUGkrTEVLZlRwd3l2?=
 =?utf-8?B?WVhtQno5aDZsekorRURTTkJnNGx3dkEyUklnMEZHYlZ3SnFmQUxXRS93WmdZ?=
 =?utf-8?B?QlBJN1U4VDgvYmtIN3F0NnFncmluYmxKZDlCcTd1K3FZUjNJWWRvdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <ACF4E98D23E8464A8F697E250A5E5098@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	c+CFtla3CmRmydRyE5e23DttsUKjESOsJeesrRAiTlKBKNK2JPfy7qP40hTQsPYsdXQ7Mbo1s55LGRzOLCBRpxVbTP2uVR7RAg82YVpLRM3wzpg8Qln4nuaPkcYA7hTu/P844CqUorQk+rr0lX3ztQCDZ1ORL3ZczklAebo19bQk2q9BeWwjxzvVDD3/XaQ+YWPev5CWN2R8/lu0H0F3D7fAYWJsGICYp/MZK8CbZ9MNLSnYxHNwwTwaLRXQC8/OP3dSwyMSJ+04axuoMsf2ArmNJC5iN9hYZ1BZxWXAb7EDtd9wQU0ccfzBgpIEN3RGPNFpbBomgeNO6PDVcQvGqMdGokbZ2GpvHThnIADMeJAmMTcr4WILcVwMsJJhfLT4pGDDFi7RZvVfsrCzcYcCbR2IfeG6YkHQpiWlr6aho4DVq6mB+LNjIqgRMOtQYxwSWGPAJf1bN1I7wuuOfPbEMAmZMJZiffUMB3OU1jxAhTL0ygltEQQkn1Jrzy76R+UbywIWd0Xhybf0Vw7hgZ05qw1CvRm9QqEqD3NwALbyDuwrHE4z33I6FZwgDeWr2pGhkdiXM26dXYbUOA3zLr2cjha4oAMV8IIS1Z39rnPP1AlTq6bp/ku9R/NYEsGvJ9Ez
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DS0PR04MB9844.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 543d9e2d-4704-44ee-a2a6-08de704fc14d
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Feb 2026 07:14:58.0399
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: niVbEacuVxYo6F/9ZxeIgeWPrweSHRzdIclqQz6f7DX4wHJHeq+AldP2rjtI3nhchdAH+vXURAB2zepYbsz+4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR04MB9144
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.94 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[wdc.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[wdc.com:s=dkim.wdc.com,sharedspace.onmicrosoft.com:s=selector2-sharedspace-onmicrosoft-com];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-77768-lists,linux-fsdevel=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Naohiro.Aota@wdc.com,linux-fsdevel@vger.kernel.org];
	DKIM_TRACE(0.00)[wdc.com:+,sharedspace.onmicrosoft.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-fsdevel];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B632B16535E
X-Rspamd-Action: no action

SGkgYWxsLA0KDQpJbiBab25lZCBCbG9jayBEZXZpY2VzIChaQkQpLCBHYXJiYWdlIENvbGxlY3Rp
b24gKEdDKSBlZmZpY2llbmN5IGlzIHRoZQ0KcHJpbWFyeSBkZXRlcm1pbmFudCBvZiBzdXN0YWlu
ZWQgd3JpdGUgcGVyZm9ybWFuY2UuIFdoaWxlIGN1cnJlbnQgWkJELWF3YXJlDQpmaWxlc3lzdGVt
cyAoRjJGUywgQnRyZnMsIFhGUykgYXJlIHpvbmUtbGl0ZXJhdGUsIHRoZXkgdHlwaWNhbGx5IGZp
bGwgem9uZXMNCiJibGluZGx5IiBieSBhcHBlbmRpbmcgaW5jb21pbmcgZGF0YSBhcyBpdCBhcnJp
dmVzLiBXaGVuICJob3QiIChmcmVxdWVudGx5DQp1cGRhdGVkKSBhbmQgImNvbGQiIChzdGF0aWMp
IGRhdGEgYXJlIGludGVybGVhdmVkIHdpdGhpbiB0aGUgc2FtZSB6b25lLCB0aGUNCmZpbGVzeXN0
ZW0gbXVzdCBtb3ZlIHRoZSBjb2xkIGRhdGEgdG8gYSBuZXcgem9uZSBiZWZvcmUgdGhlIGN1cnJl
bnQgb25lIGNhbg0KYmUgcmVjbGFpbWVkLiBUaGlzIHdyaXRlIGFtcGxpZmljYXRpb24gbGVhZHMg
dG8gc2lnbmlmaWNhbnQgcGVyZm9ybWFuY2UNCmRyb3BzIGFjcm9zcyB0aGUgc3RvcmFnZSBzdGFj
ay4NCg0KRXhpc3Rpbmcgc29sdXRpb25zIGZvciBkYXRhIHRlbXBlcmF0dXJlIHNlZ3JlZ2F0aW9u
IGFyZSBvZnRlbiBzdGF0aWMgKGUuZy4sDQpGMkZTIGZpbGUgZXh0ZW5zaW9ucykuIEhvd2V2ZXIs
IHRoZXNlIGRvbid0IHNjYWxlIHdlbGwgZm9yIGR5bmFtaWMsDQptdWx0aS10ZW5hbnQgZW52aXJv
bm1lbnRzIHdoZXJlIGRhdGEgbGlmZXRpbWUgaXMgYmV0dGVyIHByZWRpY3RlZCBieQ0KYXBwbGlj
YXRpb24gY29udGV4dCBvciBkaXJlY3RvcnkgaGllcmFyY2h5Lg0KDQpXZSBwcm9wb3NlIGEgdW5p
ZmllZCBWRlMtbGV2ZWwgZUJQRiBpbnRlcmZhY2UgdGhhdCBhbGxvd3MgZm9yIGZsZXhpYmxlLA0K
cHJvZ3JhbW1hdGljIGRhdGEgc3RlZXJpbmcuIEJ5IGludm9raW5nIGEgQlBGIHByb2dyYW0gKGUu
Zy4sIGF0IGZpbGVfb3BlbiksDQp0aGUgc3lzdGVtIGNhbiBzZXQgbmVjZXNzYXJ5IHN0ZWVyaW5n
IGluZm9ybWF0aW9uLCBiYXNlZCBvbiBwYXJlbnQNCmRpcmVjdG9yeSwgcHJvY2Vzcywgb3IgY3Vz
dG9tIG1ldGFkYXRhLCB0byBlbnN1cmUgZGF0YSBpcyBkaXJlY3RlZCB0byBhDQpkZXNpcmVkIHpv
bmUgb3IgYmxvY2sgZ3JvdXAuDQoNCiMgVXNlIENhc2VzOg0KDQotIFpCRCBHQyBFZmZpY2llbmN5
OiBQcm9ncmFtbWF0aWNhbGx5IHNlcGFyYXRpbmcgc2hvcnQtbGl2ZWQgam91cm5hbHMgYW5kDQog
IHdyaXRlLWFoZWFkIGxvZ3MgKFdBTCkgZnJvbSBjb2xkZXIgZGF0YWJhc2Ugd29ya2xvYWRzIGlu
dG8gZGlzdGluY3Qgem9uZQ0KICBwb29scywgZW5hYmxpbmcgY2xlYW4gem9uZSByZXNldHMuDQoN
Ci0gTXVsdGktVGVuYW50IElzb2xhdGlvbjogVXNpbmcgY2dyb3VwIGNvbnRleHQgdG8gaW5mbHVl
bmNlIGUuZywgYmxvY2sNCiAgZ3JvdXAgc2VsZWN0aW9uIGluIGV4dDQsIHByZXZlbnRpbmcgIm5v
aXN5IG5laWdoYm9yIiBmcmFnbWVudGF0aW9uLg0KDQotIEhERCBQZXJmb3JtYW5jZSBab25pbmc6
IFN0ZWVyaW5nIGxhdGVuY3ktY3JpdGljYWwgbWV0YWRhdGEgdG8NCiAgaGlnaC1wZXJmb3JtYW5j
ZSBhcmVhcyBvZiB0aGUgZHJpdmUgd2hpbGUgcHVzaGluZyBhcmNoaXZlIGRhdGEgdG8NCiAgbG93
ZXItdGllciB6b25lcywgYWNjb3VudGluZyBmb3IgaGFyZHdhcmUtc3BlY2lmaWMgZ2VvbWV0cnku
DQoNCi0gT3B0aW9uYWw6IFRyYW5zcGFyZW50IENvbXByZXNzaW9uIEhpbnRzOiBFeHBhbmRpbmcg
dGhlIGludGVyZmFjZSB0byBza2lwDQogIGNvbXByZXNzaW9uIGZvciBhbHJlYWR5LWVuY3J5cHRl
ZC9jb21wcmVzc2VkIGZvcm1hdHMgb3IgY2hvb3NpbmcgYmV0d2Vlbg0KICBMWjQgYW5kIFpzdGQg
YmFzZWQgb24gd29ya2xvYWQgcHJpb3JpdHkuDQoNCiMgRGlzY3Vzc2lvbiBQb2ludHM6DQoNCi0g
VGhlIEF0dGFjaG1lbnQgUG9pbnQ6IFdlIGN1cnJlbnRseSB1c2UgYSBzdHJ1Y3Rfb3BzIGFwcHJv
YWNoIGluIFhGUywgYnV0DQogIGEgY2xlYW5lciBWRlMtbGV2ZWwgcGF0aCB3b3VsZCBiZSBhbGxv
d2luZyBicGZfcHJvZ19hdHRhY2ggb24gYSBkaXJlY3RvcnkNCiAgRkQuDQoNCiAgRGlzY3Vzc2lv
bjogSXMgYSBuZXcgaG9vayBpbiBzdHJ1Y3QgZmlsZV9vcGVyYXRpb25zIHRoZSByaWdodCB3YXkg
dG8NCiAgInBpbiIgYSBwb2xpY3kgdG8gYSBzdWJ0cmVlPyBBcmUgdGhlcmUgYmV0dGVyIGFsdGVy
bmF0aXZlcz8NCg0KLSBUaGUgUGxhY2VtZW50ICJDb250cmFjdCI6IERlZmluaW5nIGEgc3RhYmxl
IHN0cnVjdCBicGZfcGxhY2VtZW50X2hpbnQNCiAgdGhhdCB3b3JrcyBhY3Jvc3MgWEZTLCBCdHJm
cywgRjJGUywgYW5kIGV4dDQ6DQoNCnN0cnVjdCBicGZfcGxhY2VtZW50X2hpbnQgew0KICAgIGVu
dW0gcndfaGludCBpX3dyaXRlX2hpbnQ7DQogICAgdTMyIHN0cmVhbV9pZDsgICAgICAvKiBHZW5l
cmljIFN0cmVhbS9DbGFzcyBJRCAvIEJsb2NrIEdyb3VwIGhpbnQgKi8NCiAgICB1NjQgZmxhZ3M7
ICAgICAgICAgIC8qIEJlaGF2aW9yYWwgdG9nZ2xlcyAoZS5nLiwgQUxMT0NfRlJPTV9IRUFELCBO
T19DT01QUkVTUykgKi8NCiAgICB1NjQgcHJpdmF0ZV9kYXRhOyAgIC8qIEZTLXNwZWNpZmljIGNv
bnRleHQsIGNvdWxkIGhhdmUgY29tcHJlc3Npb24gaGludCBoZXJlPyAqLw0KfTsNCg0KLSBMaWZl
Y3ljbGUgYW5kIFBlcnNpc3RlbmNlOiBCUEYgcHJvZ3JhbXMgYXJlIHJ1bnRpbWUtb25seS4NCg0K
ICBEaXNjdXNzaW9uOiBTaG91bGQgd2Uga2VlcCB0aGlzIGFzIGFuIEZELWJhc2VkLCBydW50aW1l
LW9ubHkgYXR0YWNobWVudCwNCiAgb3IgaXMgdGhlcmUgYSBuZWVkIGZvciBwZXJzaXN0ZW5jZSAo
ZS5nLiwgdmlhIHhhdHRyKT8NCg0KSSBsb29rIGZvcndhcmQgdG8gaGVhcmluZyB5b3VyIHRob3Vn
aHRzLg==

