Return-Path: <linux-fsdevel+bounces-47575-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 77682AA0922
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:03:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB2FE1B620FA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DDD72C17A2;
	Tue, 29 Apr 2025 11:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="LAVj38mf";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="mJL0SX/y"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81A8B2BEC5D;
	Tue, 29 Apr 2025 11:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=68.232.141.245
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745924552; cv=fail; b=S/9ZV0C8wKA9KHuXNks5hr0CJUTOd6zBfj1cTa230p9gnzF7BuISFJim726ySEHpMVbU2LnCS9RSp9V4QIpQKdZ5bpDRr7toYnA2JM98SW+XwmqGyMzvP1dNVxh1bwM6L/VDH+OUrXkKRjAWUIqG7YKi8YxMyQ6cqhDGo2QG6eQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745924552; c=relaxed/simple;
	bh=QF3IouLBUAZNSIlPd/M1vHL0h9Co5JOlwNQpfKFOitI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n3muer69Jdua2Ju6U1Fvn8TkYi3dmhufmntWNsMX/VYv4VoxLNZZLodO4EJ4yi8rzmPDNqia8rSXZLKkwvNcI5hAd5YdFINVabvZrC7aCNam1a6M2OG2riSUmoHlqDtFz3G+7L7DjRErhnDaL35rW0YOISwgLwh1F0pjrjVv77I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=LAVj38mf; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=mJL0SX/y; arc=fail smtp.client-ip=68.232.141.245
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745924550; x=1777460550;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=QF3IouLBUAZNSIlPd/M1vHL0h9Co5JOlwNQpfKFOitI=;
  b=LAVj38mftfRpQD21NDLT9OvK/sQKckuIqt+n6seBKniC2b6sUcggouEE
   2i2xXSLMgsbnL2BlYjGz/Gwn4zGVP1oEHeBxn32iUeKzQaMV4Qc/5uBVo
   DeHQVTRnvA6zBlSwS5p1ORnO794FmrmXpx2Spi/+rOhtVkq2DLDluCiot
   9oY2mXtWvgOQFNWF7Qik75nsM7CNggXZF23l7SjU+cCsNxrre9SZKAMyL
   29fxeyFCNaGN3LsILhak1sBSK6gKxVy/bennBuI2EqerdHxRg6uqQJX3t
   VLPsuMDBsTW28sipD2SQTO/bJRKsNBn6LM8Ul+yTQEV5a5XcQ+aagsS+c
   Q==;
X-CSE-ConnectionGUID: JkvYIV6ORzmFnY6YS+GhXg==
X-CSE-MsgGUID: eWFmZxHpRumJPvRr6XbUYw==
X-IronPort-AV: E=Sophos;i="6.15,248,1739808000"; 
   d="scan'208";a="76810529"
Received: from mail-westus2azlp17010005.outbound.protection.outlook.com (HELO CO1PR03CU002.outbound.protection.outlook.com) ([40.93.10.5])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:02:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Elun8Y/5cdJtGDPuK3VKGqrUtV9vqgmMzQmGe7ZdocJaHO8ts02mIlgm2tQMB3OIX48dpCtjrfEJaSmdK7XaBZyXX41hi8mVrksjW4s7Jw65lM0yyR8j/QV33ePI4TmwrVSwyCzWPojrgPFOCuVHPWvMJxWYKLwexRbcdQJxzg1tNHINOzQ2ajVIPrVTntGU9aoQVvNUDeM3uyiPI87rGuxn/ROxQqr22rBNkWnu4xaDNV/EzduRAFPJgDaqacLJkOOPEZcjs0n/GgYWkRKu5TbOBVA7bKlNTMLiEbeXi8NMNS8sW95ZL3Wsa1LeL2t0hYipnb3AFIJY2D6vr9rhQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QF3IouLBUAZNSIlPd/M1vHL0h9Co5JOlwNQpfKFOitI=;
 b=Y6wb+4z35dvYPueiu5GMXMRYOs50b3Fffqn4Fw7Y0Yqn7/DiU/EiG2ji0QYNM8SctzeZuWE3mL6IWpRseuv2TkIa8l84PKpwYo8ZWSB6JtJi6QkcQ4vGhEXzG2wf9MyWPoOCaBixDLfUxX/DigSjnsmGiS7Tpt+YzGEpzmY6Y5qAmJjNPRUbWM3N/KRaQXBRj3nofyXZdy1A+goV4Kejxy1TW+raWrONAOiL9BLSsWYwAKQVwvmhkMSFTM+kS8nNxGeeWz+JKYZKZ9I202/T9Y/RRHUsPtjBL77XhZPVSSCcI4Nf4ugHWuTjocsAaI6OoQjJzOh6QCMBpNX4PzP+rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QF3IouLBUAZNSIlPd/M1vHL0h9Co5JOlwNQpfKFOitI=;
 b=mJL0SX/ymguvre/wxBRETPilsJpas+36HEMVHoSgW1InjOWu/gSWf7q4qFnEDMezs3YLEKowAIa6y/vIvQqJ9IqEcsTRD1pXX2UZusP62m0ZxdiBcIz+RdZXmkR2wh3ZmQYTQeDtPRTL4bvLKPhELkeEdyqUpwlNGPF4CZqgDbE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB6447.namprd04.prod.outlook.com (2603:10b6:208:1b2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:02:19 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:02:18 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: hch <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Md. Haris
 Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, Coly Li
	<colyli@kernel.org>, Kent Overstreet <kent.overstreet@linux.dev>, Mike
 Snitzer <snitzer@kernel.org>, Mikulas Patocka <mpatocka@redhat.com>, Chris
 Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>, David Sterba
	<dsterba@suse.com>, Andreas Gruenbacher <agruenba@redhat.com>, Carlos
 Maiolino <cem@kernel.org>, Damien Le Moal <dlemoal@kernel.org>, Naohiro Aota
	<Naohiro.Aota@wdc.com>, Johannes Thumshirn <jth@kernel.org>, "Rafael J.
 Wysocki" <rafael@kernel.org>, Pavel Machek <pavel@kernel.org>,
	"linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
	"dm-devel@lists.linux.dev" <dm-devel@lists.linux.dev>,
	"linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
	"gfs2@lists.linux.dev" <gfs2@lists.linux.dev>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
	"linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Subject: Re: [PATCH 01/17] block: add a bio_add_virt_nofail helper
Thread-Topic: [PATCH 01/17] block: add a bio_add_virt_nofail helper
Thread-Index: AQHbs5KkjOs5+7+490Sh/PhMCrePubO6hTGA
Date: Tue, 29 Apr 2025 11:02:18 +0000
Message-ID: <4ad7407a-48f5-468c-9f95-6b79ad8ba00b@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-2-hch@lst.de>
In-Reply-To: <20250422142628.1553523-2-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|MN2PR04MB6447:EE_
x-ms-office365-filtering-correlation-id: 7d207dbb-7cc3-4acd-3bb1-08dd870d4eb6
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|10070799003|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?WjNlaXlkN1Ryb0tRUU5Pa3FBdlRzazEwbG5wQk9sNkhOUzAva0pYUmRuRjl4?=
 =?utf-8?B?S3BVbDNZSDY1TVdNTWw5eS8vdlVxUGtXemI5TExhckZzb3lHcXAyT0MzaTcx?=
 =?utf-8?B?N1VaalA2TElJYmkwejVHczg1U2JpMnZCRHZSd1VLbS9Va0dFRW04NmMyaXlN?=
 =?utf-8?B?Vk1WU2hZNjFmTkU1bWhKN3ZQUEZyWUhDVUtNZXhOWVpaZlYwVmVlS2Z6NUJa?=
 =?utf-8?B?VU4wcEhUeEt0eEY2Z3NLUkVzQmxxR25ySUFuL0dwcUkwZTlCV3Zic0VORS90?=
 =?utf-8?B?T3gzQUp3YkUrazl6ZzBrdGFiUjZLY2tFRVRDbFpDeUpnbnFuSytUZGtCOEN1?=
 =?utf-8?B?a3ZZRGpEK3NMRnQzQ25RamtYL29tM1VuU1ZlcFV2TFA0SFBubGxaaWloN0Vs?=
 =?utf-8?B?WUFNeGpwL1JZQWRhaVAyUEErK3hCTzFBVGp4TUNhbGVOb01sbTZzYmN6clRv?=
 =?utf-8?B?b25selYzVC9TeGFvYkRsUDQ5UjFmVlcwbVVaSnFQMHlMYjRXTVppYmRJaEo1?=
 =?utf-8?B?RGdkNHhFSlFONmdpSDRVbUl2T3F3dUhTa0JvYWUzTzdrOWZ3QlZ0dmhOaisz?=
 =?utf-8?B?bHNYV1JxRFV2VUVNamYyTXVGOGhyaDFQRmdoWlowWEZlbUtXUHhBbUJBczFv?=
 =?utf-8?B?Y2trOTdEZmdoMmtCZXZDbUVSTk5aSWZUU0dST294aTlvanJTaEkvaVVYaUJ4?=
 =?utf-8?B?WUFtbG5ybUF2MG9jVWliQUtMR0JCeXVDVmhYTkF3QWYyZ3RzL3kwdVFjUm5t?=
 =?utf-8?B?Mmh0N1pFSUZjTDhuYW9jYkdYOSt6YncvSzZmTThST0dFcDJNa0tsUUJRdnlS?=
 =?utf-8?B?bWhYT2RZMHVJczhNVk1kbkFhTnh0c3dqeFhoQmdnZ1NEZ01GSzN3UEVEZmQw?=
 =?utf-8?B?STF2ZmtCbk5uRlQzTEZSanIzeTlVRnlVSnovWmpFTURRTmpPWW00SHcwUE9N?=
 =?utf-8?B?dzljclZBY1owV28vaDZJNEdvSVZnbXRkRE5VdExwK2dwRTg4bDNDOU9jOEl2?=
 =?utf-8?B?Y0lXUk4zZFJHQjBsK253dnRVa0dQOXlrajE3RFNVNWpDOXhuRkJleVdCSUpy?=
 =?utf-8?B?UlN1eURxbGZlT3RnTHBXMU5tT2pYay81WTA2eWx6U2sxQk9OeWVYSXlvZnA2?=
 =?utf-8?B?MzRJTi92NjlMVXVqcDkwQnZZZmVmSnFKMDRmc0Q5TS9LSTUwNlJkVmI3bWFP?=
 =?utf-8?B?TXU5VHZ3NU55WHU5MndsdEtLSWhOU2NMb3NiMi9HaU5KWE1qNk54R3RiY29V?=
 =?utf-8?B?ZWFvWU9Tai9qQklIazVMUzRyeTdWWE5oNnRwUXlscDJiVVRJUWZyN2c5THFD?=
 =?utf-8?B?OEtlcUtYOWhIU014V0RybEFhbXpqNkpGbmFhWFVlNGMwcE1ocEF6MU9XWkRM?=
 =?utf-8?B?eTFGRkROd3ltd3drVGJIRWxjNG51d3lDWjY4Nk5HckFkU1FXNGppaXp5NXly?=
 =?utf-8?B?b1E3aFFVMHNPTlZLTFJiYXluYTF5REhiNkJCeElGUW10YXlHS29hVHVPWGFG?=
 =?utf-8?B?OE44SVJTWjJiVHFmMEJpbnc5a040UHdOTVdJSDVUcFNXR0VSZUk2RXRBaTA1?=
 =?utf-8?B?YWx6RVFpUjJyV2NtczZwOFRGODc2Q0xKa290UUhRRXl2MEFQTXZSdDBudW43?=
 =?utf-8?B?dkVsQ09HQUxGMnFIN3ZQcWFHeU0wYm9sanI0R0xDOGgwdmk0SHBWM3BtYzl3?=
 =?utf-8?B?ODZHVGs0ZHJKNld5dTlCM1NIMS9CZzhOR1FLa1ZLTmFhbjV1TW9hTEpuQmM4?=
 =?utf-8?B?VlMvZ3FjNGl6ZXZzNVZiaU5LYW5lekl6Q3VjRElLQktBZDk0UUk1cGJwWEtk?=
 =?utf-8?B?ZWhPU1c1eVhkcHBKTkkzTHpWSE80V1RVK0hsalVwNjRKaUQ3UFNwZDdBbFlk?=
 =?utf-8?B?YW44TmdqM3cyREt0Rlc0bnR4Qm5nWGZlYWIxZmdiWElRYUdLemgxSU9kOGpF?=
 =?utf-8?B?VmUwaE5wUktUd2d4b3Y0QThKZ1BaMTF1RWFWd0lnQzMxNTJ1UHRUSVRXN0FR?=
 =?utf-8?B?V05SNjluT2pRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(10070799003)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?V2FQWStPZVhuVVdPUUQ2QkIxV3RyQk1uTEtNS01YajJXZ3QxTWhIV2hBV0RV?=
 =?utf-8?B?Q2hmTi9MZFYzdEo2S3Q4OUhwaHFoMTVZeitoV2dOaW84MzJ4WjQzaVN4NW1w?=
 =?utf-8?B?UjRyTHdvK05rY0Vxc0lGUnIyTEtiQ0pvZDd0Z0VzWTEvVy85bmg0TjZiQmxr?=
 =?utf-8?B?cmlObUpWbFBzZG9sZ2RDbHlFcGhPdGJaM2hiODMweHdkUDUrUEJFTENLeHA4?=
 =?utf-8?B?UWVRM2FvQVVzSnJ2bDI2VHZHSlFmdnFETmJmV3dxV2dJVnM2QTUzaURhRGp5?=
 =?utf-8?B?ZGYzSVgxV2F1MTMyYmtjSW9ibGJLV2puU1V3N1ZjLyt0SHJqRmtlblozdmxi?=
 =?utf-8?B?MXJYYjJwU1lPRnRjenU5V3dYdHpPSDJ5dEJrcWNaT3kyZDYwS0tuMzBNTHMr?=
 =?utf-8?B?QkQwSm42czJHVTVsWmxFeWhzaGtldGFOS05iZDlJZ0RaSUNudXRLNnB0bjlZ?=
 =?utf-8?B?NE1TWlZ0eE1TbTBlSUZDM0k0cUdsTnpkUTBYcG9uUW1zSjJyblpSYkg4bTNZ?=
 =?utf-8?B?WldmQ1kxSEJ0aXFsNHRXTkpQQlV6OUtQTlJHb2twVXhxZTZ2TUdkU3dlVHlj?=
 =?utf-8?B?bFV1dU1tcTF4OURYK3I2VUJtOHFzN005OXNvNVlTcDlLMkMzOWplM1dpK2ZP?=
 =?utf-8?B?K2JjcVRhSllGeFlaSUFvZzFlNU81dkU3WUhiS2orWENoVjhMb1VXb05tc2xJ?=
 =?utf-8?B?TlM0ZXR0aTJYRFk0SFdRcmtDaWFzTjF3ME83UStlTTlGRGlCMWZKSjN2dmdn?=
 =?utf-8?B?Z3JlajNtTlc3dWZJZWF1RzZINTJQUFRpZ3JPMDBBM05vRVVSYXZ3RHkrclZp?=
 =?utf-8?B?elEwZEV0RFM4OHo0NXpDWnQxakdIakZCY3ZXa2pVWm5EZlN0eEJmREpLUEdx?=
 =?utf-8?B?RE52WGdqUnVXU0ZBdVRIZFZzYllBVmcwZ3dLQlByeWF6YjRZTG9vTzh1bTRS?=
 =?utf-8?B?WnZXdnZEUXJ4V0ZxU1JONThxdzFHcHN6V0tXay9reTVSbzJMTjR0RHFBcmpL?=
 =?utf-8?B?Tm16VERtQ1pzbmUvbG8ycDBHRFdaMnIyeUVDUmlvRnZwd1c3c1FIeTQ1NVFq?=
 =?utf-8?B?ZEk1WFVaUldEYmNETVZqVmRkYUNWRlpyRS92SnI1Q3lVWGJMRTdSZXpjaEJy?=
 =?utf-8?B?UHJjWmk5Tmxra2t5QTlPdndQMkdJMmxOaWoySEtpUE5iU054VHdjc3VkbGM5?=
 =?utf-8?B?a2tDak1MQ3pBNElVL05nL3BVQVRxWTBZTUhyRXY4ckNaYWNJTE1VOEVCUUVo?=
 =?utf-8?B?UWwwMnZwcFRQOU1HME80TFUrTXFZQmdEUjlUajJvcTg3eUFWdDBYMEFRUisw?=
 =?utf-8?B?bDBlYVZ2ZlRpYTB0YnNoT1hPYTdFQkc2MG5Rblowa2UwQ2F6Yk03ZUlYTlNi?=
 =?utf-8?B?YnFLNzFXMUxxRmwvTkV4SitIS2JsaWN1Q0hqRllJbkJZUHhqVGZJREQ4V0JG?=
 =?utf-8?B?cEVST1paOW12MVI3bUpqRkJPM1ZEdHkwTi9lZVM5ZEwraU9NQnh4QW1aYTB4?=
 =?utf-8?B?SSs3bjBucCthTFp4UnUzTGNEajNDRE44akZNY3g0SXBwNzlXUEZZTkhLaG1G?=
 =?utf-8?B?a2wvMEEyVW5wZ1U1aTN3ajBKejQ3cUhOMkZ2REFac0U3RldIVWVYRHNXc1BP?=
 =?utf-8?B?Z2xHT0hZckErNVNwU1ZnQXdmVEZmN3dHYVpYbk1Yd1owRHFvdnArL1lZUDFP?=
 =?utf-8?B?QzFnczdmWFJhTlhLbUpoTjdJd0cvSXpWbmJjYUZLYnliS0xSL24rM0NoM0pD?=
 =?utf-8?B?K1RyT3UvVEJCNFo4NUVXZzM3R29rUGRGaVUzazdJb1d6V3BqejArcFFrKzNY?=
 =?utf-8?B?eEp0UXExaTN3QlVwbHZJUEtOL0RtK0E0TWRUdVZaQlpVUDgzOWJQd212NEc3?=
 =?utf-8?B?YXQ3d1dXWng5cDRlMnZQeG5EQlBaQkdqZUsvOGhPdDRQMUQrZWh2WG15cEVZ?=
 =?utf-8?B?VVJRODNCaXJ6cDNDT2dGa3hnSml0SFNqaTFkTXFuYUpNbVN1bWFLRjJ3bTFO?=
 =?utf-8?B?YUIvbjRuMUl6VDdBa2VBR1FRMkdnckd1UTRacWE2TWw0YTdXTlA5bEdsSEZn?=
 =?utf-8?B?dk56U0dyMVhDUGpuZzlGb0hxdGdjK3paTjZ5OWhBMFZTRUg3Rjh5cUtPSXlk?=
 =?utf-8?B?Sy9JY2syZ3VjMjB5aFRiZHVuajh4S3lXQmRQdGRFU0tXM2gvN3hoSGlVano1?=
 =?utf-8?B?UGlDRmdGcmY1VzZBTjQ1QnlER3hsRlJKMWs3Y0NhK3pTcXI2SXcxSkp2NTNX?=
 =?utf-8?B?MzBFbTZQK01PVUlKTVAwdnE5T2x3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <EA9AA7CD4018F945B6476EB2BA55467A@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tI07GGAnluQXX5A8L8aQUY+1y8cuqIEAeBg1Tr6VIyCZivXSDLAOFRmMGwIbnls48rYwnYt/x4pOsWbJlaguQSqUzd4OmNeAcvgikVd0D7Q37Vbxm2CNJY36WWTJB9BeBHK5MLAUtZBhwC+LnDver9DwoR4BpNvyzolgZPiNOfZbPYLDWT4b9v5p9xI40exQZqU+LFKm7c21+ricnY9/6S44+wTPRqK14S9A2JYwc+hEkR6YfpdceaVyXRck+OsecidHaBs/RbyVbIIMAr+/K0x3jz3mhAZVf2VkrL2Cz+mmrHmn9icEkqPY8MaqP9IreNpZqoCHCrYhVkEZa6cs32TeUvsptxbNXFCXcv4gft7ZmxyGhR42PrM7ViFxR2CWalgOgBhFxqy/eC/JbYsRVIuFJeiwppxyaSQ2/blqXV9xnOEFv0dZw5aresYclDkIbrwIYFj33I3VZWVRo5YGM2zKKi5pQKHAJoP13NSe8u3CG4XqHsAKBH94m9PnO7vmrDYR4hdSqSRCSLSApu53kPJZ+kt4/StHlNsVoYwEVivO+b2O1z+pqh0pCDsYRQHp3rcixD2I26/1nWg1Kg+SzXGhV6PQ5hTQsl27NAGzgQYCzh8hN2pUACSUGt6z36Ho
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d207dbb-7cc3-4acd-3bb1-08dd870d4eb6
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:02:18.1270
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kmNYBtDyWcMeVOgYjHRm2ELltA9eAJ+MPVCaz6mmNDTInb8ioyt50Cck1NP+4fkyNvcszwFtpWB5od/DCgSg22lqwHILhOOonnXSUo0AwKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6447

V2l0aCB0aGUgdHlwbyBEYW1pZW4gbWVudGlvbmVkIGZpeGVkOg0KUmV2aWV3ZWQtYnk6IEpvaGFu
bmVzIFRodW1zaGlybiA8am9oYW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQo=

