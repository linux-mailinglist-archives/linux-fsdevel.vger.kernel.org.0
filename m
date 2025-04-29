Return-Path: <linux-fsdevel+bounces-47585-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92031AA09AA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 13:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D40E1B65F11
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Apr 2025 11:33:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F52A2C3749;
	Tue, 29 Apr 2025 11:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="aXHlUxPV";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="TuBDszw1"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021D92C10B3;
	Tue, 29 Apr 2025 11:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.144
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745926313; cv=fail; b=ZtbB+d/19S+1hRzkU6FLKCK7PbxuW6q55lj495ubj1Rdgu6c4nq1isKRj4jx691KXxZL+7ppNWM7Ft5DyJhqHjR/raTgTT0wE9FRxCbCihtO3EHrl9nkZrJf3w9ICUhvglFeOCMkBjFieN95Qw9LCLIoO2/B1v69Vzhqf3q7Z+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745926313; c=relaxed/simple;
	bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ejHiDRZkx9GwEXdyv16xYDped/Svg6pp9NuHrrd5AIG7RNPpoc50sLoiCpYgEPisABcKuD5oyy0lH2AlatZId0tPJMa24+emaH+wBFt66v4t+UFvPAIeUNhQN+04pqzk3PpLiZ8AFH2ZD3qf641kSCmtuX6xlnSf+M3vhiXI36c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=aXHlUxPV; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=TuBDszw1; arc=fail smtp.client-ip=216.71.153.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1745926311; x=1777462311;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=aXHlUxPVEK9DH6a02BfTOGC7iScqfN8xI1IUu33eFjwIrlod3QWYRsoe
   sOygSKPutGoo9ROkSg2nYbcYcLZn81P1APayma6HwZZipPdP36vNYlM/B
   n8yqvBK5NhhbG4hRm/YVfUoGJbKHPzftJ1MBfv4rV/3POWGmtUNYo/Edd
   BP23o7tAT7zOSMlbqtYOn0e+cKNGZ3YvXUgIOVrVcGCu9YGiXm45NwRQJ
   PNQ+0ajfQ4kLygX5mVbVXI7YBFClCU+XvE9tgH7fwE47EHuy4OM7XQeho
   T911ywGef8o6sAF5ZDwEsW0hinNA14ZFk1kQnkygKEkyVT9znq+vFiSJD
   g==;
X-CSE-ConnectionGUID: DIRgLJ8rRC6rYG8O9vA2bA==
X-CSE-MsgGUID: /gMh+SjTTJ6OwF94Ci8ELw==
X-IronPort-AV: E=Sophos;i="6.15,249,1739808000"; 
   d="scan'208";a="77463079"
Received: from mail-northcentralusazlp17012050.outbound.protection.outlook.com (HELO CH5PR02CU005.outbound.protection.outlook.com) ([40.93.20.50])
  by ob1.hgst.iphmx.com with ESMTP; 29 Apr 2025 19:31:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xvnfOvMPkcIYq+EGR9S6ySdIHVPgFzCpFLlOs3/C2Jc/u2vR23Ny27XNPHWL5QnDW9H1qyn06qK0zOeW8HUGfy51Uc0aY2Edc25qOFmWj/z2IDW8l+fUNhTQiVa0HnLFbhte3vIl+6jnvyTkGdSfcZH03l41fH/nMuGLTAvtdMhbsMqNbdsZcdXPVAqPwBDY6fBGYrFFTo5uTu0oucIQKEHOlB4l+lmxRzh34M9rY4BEFIjc7nJpJTMYZdffC46RHiBV1oIv0WJtf7fZTWss1axc+goatReV+Wsnnfk+TzrPQDXOabeQZdyZns8IYBk48Jwln0YFL8BLeN+E9YuQEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=fmpDSmQNvNAkncMgdUEy7NrGfHyQeGu1s8sZNsu9H9B6G/fvwKyW0mOLbS5fxwqP1j1Jxc26HzmHMYsuUJdHyqWINog5tmkl1JqhKwX/dIMEw+VlZftvWt1up//iq/5THe/Xycd8JBA2aAyrM2DF3/SXBxxnJjiCT5MMvLhsmTUp57l54SIOQLO+Ubawt2z798sR7G968T0tHMUuXk7vupV/3SIMSdqma7ryByFoZdQAyx7wf2Az/qh75q1RWnYVRqdUzktac/C8c8byC6Wjzr3JFR0j8G8ZXnflygHf9nkuxh/ilpE58cD6gz4sKKecbBhyHhPGEzJJUx84R9eYDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=TuBDszw1TC9OTyZAp51j6d2Tkdk3SVxMxI75PqAhskfj63P806ztygs06jAEB3j5rqEUiR2silgZnXFe2fAt4ZlGtb8ucMp4OkAwfgNhZopJ37xbAqiSjsUip/REGYZp9ihX2BlEXsXYOEC5yciXOdUixdItFIcQ/zr9pUwFfeM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DS1PR04MB9606.namprd04.prod.outlook.com (2603:10b6:8:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Tue, 29 Apr
 2025 11:31:47 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::ee22:5d81:bfcf:7969%5]) with mapi id 15.20.8678.025; Tue, 29 Apr 2025
 11:31:47 +0000
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
Subject: Re: [PATCH 06/17] block: simplify bio_map_kern
Thread-Topic: [PATCH 06/17] block: simplify bio_map_kern
Thread-Index: AQHbs5LpdfwPwhEuX0Wt2h2QND7pjrO6jW4A
Date: Tue, 29 Apr 2025 11:31:47 +0000
Message-ID: <ad310d43-8eeb-4cb9-8c48-d3de90985169@wdc.com>
References: <20250422142628.1553523-1-hch@lst.de>
 <20250422142628.1553523-7-hch@lst.de>
In-Reply-To: <20250422142628.1553523-7-hch@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DS1PR04MB9606:EE_
x-ms-office365-filtering-correlation-id: c4e092cd-6335-4db9-86c8-08dd87116d45
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?b3N1TE9iT0JEU1FGNnA3OVQ5cFRTLzZ5cDJ3ZllDY0ZUbXZ6a1JodGprUS9Q?=
 =?utf-8?B?US9wRVh5SzJiZDI0TU1Qb3FOUU5TekZzRHZENWxVc2ljOVh0aXdWY1p5QUlI?=
 =?utf-8?B?cmcrZHpOWlBtVlhRZGdJVzBkdVE4eVhVV0RaUnlyWDBoTU8xUklxQ2JZVE5C?=
 =?utf-8?B?SVU2TzI4b3Z4ZU5tL0kyNGw5LzBjQTdZV1F4cXlEbUd3NzFnb1dqVHdtbmk1?=
 =?utf-8?B?ZVY3enFzY2wxZVl6bUw2bTJtcnhiVDF2NG1vaDl5R3RIOFJ5Z25NNU9VbkZX?=
 =?utf-8?B?WkJmUDdkU3ZBcnoxMENMNGJWVE1EOTFGU21LTkU5UjZtSDNPbDVLTHI3SzJq?=
 =?utf-8?B?Y3FqYi9nUzB4Uit2dDRCVTgzUDRoTEFldDkxczZSRWR0TUw4SmtVNTRjcmVa?=
 =?utf-8?B?M3A0NG9UOVU0N3VXaW5YQjZNdWZ5bXBwQzR5MmtiZ3NIR21kVy9TNzhDdTk3?=
 =?utf-8?B?UXRZQ0xLNXY1NzVXcXhGcFVRUzV5RVZMS1Uxdk9sZDh3V2N2eFU4UGRwS0Qz?=
 =?utf-8?B?bU90cGZNUC85WVVyWUYwVnk3eENxaWxtUGw1U0pjRXJ6SU1xV1FKZ2tGNUtx?=
 =?utf-8?B?Y3Yrd3dZbThuSEEwSEwxQ1FCbmxBR29wa1Vrb25JK2NseGRUTDQ2THYzUjZn?=
 =?utf-8?B?KzNhUlJKbXc5SklKcmtFTnBKckgxYlNFcHIzUXVUbjV1cUhDM2lxdGYzb2lC?=
 =?utf-8?B?WnQ2c01IeHVZSkh3Z0VtZFJ0SDF0Ny9aeXJSanhhNVZRUUtJSVhwQlpRMnJz?=
 =?utf-8?B?dWZ6d2U5NDZnQmJCb3ovemdiRE9ZY2dyVnVMT0wyV2xidzFaRjNkQ2h4OUJl?=
 =?utf-8?B?K3M1dnNORVNzdHZPTnVGcjU0bDZCREFFbWxPZWo1S2xGY29oank4QXI2UFJQ?=
 =?utf-8?B?Mm5mOFlVbGgrRi9jUEM4UDIyMG5qZzFsb01nL3pMcklUZjYwL3hHK3NORXJL?=
 =?utf-8?B?eGZWY1B3Z203cEwrM1NRVHAvZ1pBb2NDTTRNajZJb3k1S3pNV1VzcGF6b05D?=
 =?utf-8?B?aEtGZDI2eUJYVHE0WWZKRSsveXJPNnhTNHZmS3BWdER4VnpCWnZTcndjWGN4?=
 =?utf-8?B?U0Q3MUI0MGRwTlF2R3JPVURGVjFlRWNHeCtITWZjOWY5V0tMQWZJLzhhcWIy?=
 =?utf-8?B?S2NMRjVxbUdYZ0hsak9XdTRQcVlQcDlJSTYwTU4rNG1QZjhNWkRDc0craEQ1?=
 =?utf-8?B?Yk9ndUpXUjlrWkx5M2hQSHhrYXJJSCtMZThWNWZmNUZncW9GOEtGMHRkTGdV?=
 =?utf-8?B?NFZncGlZQ2cxSXZjdFNjeTNwVXdzQ2czTlFiVXlPdExQVngzUEVHWlZiYVJH?=
 =?utf-8?B?emJpa2NMeU5qWVY0OUxRdDBlZEtLNTFOZ1VwZE1IZFRaVG94KzBROHhzaFEy?=
 =?utf-8?B?UHZ0RHZBMVhURThxRmVKZ0ExUEl5VHZsbGxFRjFZVEhzT2hhc2Y0RUYzdXZ2?=
 =?utf-8?B?cE1jc1E5Mmk4b2c0MEdLR1JVNWUveHhrSmYyMDBZRDYxYlhUQi9EbVVkVkFu?=
 =?utf-8?B?bVk5RDZneDFwZi9SMzJSZW0xMVozSzRGL2NXYk0zRU9LQ3ZGMG16RzQ5dE0w?=
 =?utf-8?B?bXdkdXlleEp2U2dpVjF4SE4yWmhRUVVsRHZQTUZLTGRXY2FBdnlzTC9SeGVK?=
 =?utf-8?B?T3h4dEpWaGVYM2JncjZWSm5jQjJ5dkVRUEJRekVOWVgrN3N5cUp0dGxyOUhT?=
 =?utf-8?B?MkNtT3pBSy90MDQxYmovdWdLQTVLVGZFNEFnc3dNMEF3MysrYzZRUkwvSWhj?=
 =?utf-8?B?bWhiTUZVQ243YlRUL3M4cEZmS3c1TmdQR0hReGhkS3NtUjJwd0ZhNHMxTlpa?=
 =?utf-8?B?Tm1mL1IxUVprWUJzcmd1d1kxNzR1TlNlSTJkN2hnWG91SUt1S3ZTbk5WL0xD?=
 =?utf-8?B?bnkzS3pLOUkzYTVPOTdtSGlCblFMYloxTXoxUHpueS9NV2JTOUNXcWd3OEpR?=
 =?utf-8?B?b2pNeU5HWklSWEpHOEVqYks2dzhCVDlGZ1RjSTVUNko0T21NL0FZV21rOXJH?=
 =?utf-8?B?bEtFdm9Zb2hRPT0=?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?d1VqOXdGZWNTZzJlRVMwMFkrQ2V0WkM2R0FHakM2ZjJ3UXRMd0tFYW1yTElp?=
 =?utf-8?B?MzM2VHBHTHBlbzdkazRsaVNJQjRrZ0hDNkszUUJHLzluWDFzV1p3RE0vanVw?=
 =?utf-8?B?bFZlbitlUjdtWHVxV3JkKzZDRjJEbXhuVUxNVk9VSm5YTU5QeG1kOHlOR2J3?=
 =?utf-8?B?VjJoSk4wZ1pTa2VSUnhBTVczQjNUVldVMXgxeVZCV21IWHRrd3FMRGQwODRN?=
 =?utf-8?B?N2hnVE1vVFJYbkR4aVhNTGpYakhwQ1F1dmx2cVdVYTlWNysrMWFRcUhGQkpJ?=
 =?utf-8?B?cW45aEFnNE16TmFEMFRhVElyaWtiTFhwSWNIWnhYbmN3Z2RsazUrb2ZBZVdC?=
 =?utf-8?B?MGVjVGw2VDVRR2g1R044bzdoclpVZS83QjZzc05pbDZha1pCbk1KUVY4eFFK?=
 =?utf-8?B?ZGl1QXhTWjNVbWNNTmQ2ZUU5dVlhTktDRmozQXp3NTJsb0F2TkhFTGpWU1Bz?=
 =?utf-8?B?SXBKeHZXSE5SbnZIQkNoVUdCa2cvMTNmTWpzNDlYeDU0WGMwZ1cvK3lWSG5q?=
 =?utf-8?B?MCsxN0NUWW5WMFVIa1VaM0dnUnMxSG15WEdtVG1ydE9uTmFCWEZlSW93Snhs?=
 =?utf-8?B?WXJGN1ZpM3JaYnZzZnlnd1lGcVB5azVGRm4yY0U4SFJhbytXM0pjQ2lsYXht?=
 =?utf-8?B?cHg3TnFELzBNYjJOcjRsSVNjd2V6b1dxeTBwejBvOWI0QTVzYmFrQ3ZTYzB3?=
 =?utf-8?B?NTVsdE1oZGN2QnZyQjdEaEVsamVmWHhDbUhoWlFWZUlCRzEyaVNDU0w2M29Y?=
 =?utf-8?B?UUU2NnZjWWp0V2hPNUtPeG1tWlJ0V0F5eURjaUpSTlk3L21zeERtRDRRR2E2?=
 =?utf-8?B?cXNhTEt2S2xELzEzNWw0TjFxQTZMZlpFanRlTTZVZEplUExFOEE0eU1ydTB4?=
 =?utf-8?B?MDdEMHE2ajJvMjlWNitpNC84TjZ6TEkzRmxGbGJ3dnN1VmVlMTArWERRdXZt?=
 =?utf-8?B?ZWNJVldxVlhETG5ISlRnK1ByYWgzcEFzNnNOT0c2dGttcHpxRjlVYW9IRHF4?=
 =?utf-8?B?SU5Ia2pUQW1kTVZrWXJjaWp5aHpkN3E0eHBwVE5WL25vb2gyZXZKam1RTW1I?=
 =?utf-8?B?MHJ3TkpaamRERGJJZit6eHB1eE9GV2tVMWptNkM1Vk4rZ3dMWnJYV0d3UEJ3?=
 =?utf-8?B?N0h1enE1VHgrU0hLOWQ4Tm53U3IxNlZXajlZNFRUUVFWRnlpZ0tFUjloRmhz?=
 =?utf-8?B?b0ppWG1kS2hrSTR1WWVuT3hNeFBUZ291NWdEdVRDTkxpcnY4VE84dmZycExB?=
 =?utf-8?B?M0xVWlIxNXdOVHdCYlQ5NUdSUFpTeTJVekFhaGVFclFWOHkzVVF5K1FZd1cz?=
 =?utf-8?B?TDZQdXEwU1Q1VzJYVWZkbGhHOUlpTmJwSWEvS2l6S0dXTys4SWlnbmVJdEpL?=
 =?utf-8?B?QU91bTRTVjlULzNrajdRanB5MjFxT3FqN2JXR3lqT1BmM3pzc3FRV0tGUWd1?=
 =?utf-8?B?TUNTMDB1dE9iTnViZEgvbHhhL2tUVEVXbXpmM0JVdllzREo5TFNsbWkzOExH?=
 =?utf-8?B?bFlQME9jcDhmOGxseTNrcmh0NWpqbzRMNlVOSWVtZlFYaGIyUldqellvZ3NU?=
 =?utf-8?B?QzZoL0hSbkcyZktJYnFRaUptUng3NTUvdXVrRWVmUkI5RXY2ell6RUw1YndO?=
 =?utf-8?B?Vk44cVB6WFdaRkhIRG5ZODgraVZZcERKQW5DaFVWcXoxNzlVaGY0RmZnOTBR?=
 =?utf-8?B?VU04cXBqY1FtOU5reTFBSjJNcVVMOWE3c2gyNVoyZGROcUtwR0xUMDVzTU92?=
 =?utf-8?B?SkJFVEg3NzEzODF2UUdFRmV5VktFMU1kR1BzblpjdlRETkxRV1U4VHNSL2Ji?=
 =?utf-8?B?R25rTzFncWlIRmc1a1JESVErY2YvVmpGQTN0TitscnJDWUI2aWhZVGcySVkz?=
 =?utf-8?B?TXdtb0dVYzRXSnpZdTh2U2lTaEZkYytDWTFWMVpxdUpQMklVNGpuWTNJVjY1?=
 =?utf-8?B?MUVLRVgwNmQ2aTZRUVVteWFERmVDdE52TDNxWml3K1dKemtUK1VKK0toeVll?=
 =?utf-8?B?Ylc3MVdvUXhKeGx3MWpSYnoxejducE9hZ2ZWM215OWdadTJ0Y3F6bUZhS0xH?=
 =?utf-8?B?Z291U3NIUUNidlR0WlhOSVpYN21pZmdPdHFnVE1qTTY5TlNmVy9WeDBuUWo2?=
 =?utf-8?B?SFNZRUhBL2pkd2RQcG1qRHFqdHhzYVlQWE05eU5qd1N2RURWNE1HREVoeU9X?=
 =?utf-8?B?U1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <7E32B20F2C622F429271131A96AE00FA@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	RKTzxLhBS7Qz+zdCXz4z6rHpmpVgVqd0eLqTKq9SJEjW0KwbXJotVLFS3q6hXQ3msRzGXTid+G8HsXQfVobUHmX/0Zbh8TSK/XDhMKiW2F4I/E7hAn1IBE3YiLtGLAvh9SHiA5GRB25K2sBuZND/MVyC2Y7VqdZf7JszrxjCvUUXjPkX6WKdiycRz7OEmlWuBg2ZLPcTVQbDEPeY5Lqn+vbu8/ul8VVB5BzqIF8yFkz6ImmBn8vJcz37xJqa06lKpnC2UNpllTWMIwsvlilKJNQfPGbknFsG19JvBAx4qeqXer9vjkxJT7+AHWnyK/s6+Uhs+qeJzhbJoIaIL0XB4anYcUH1dF7l4BwN/pR5kJsdqB8B/Q2bfo891LkCoOoVKP8dIpPcOzzohFU4UROW8tQYhtEHA1L45VCIl/rgrxhCsX8ngmC2UQQR8+8+4J96OMPNmXKaQtJGuWUorn5zc0SuvTocE+VMe9mfhGHVH34LEOWlh1+NIeqsJrkP7vweXJ9D/Nj8kduVY+hbCOr9a13pWzuN/J4Co4v63/kFrcjIi6A4VrJ15/eV11zWc/k9IczVnPQM25qVXqJQLJ7YYMN2FfG6ruPXCwCWMh25FaAMms6zelRvRw9qRwi5p0qm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4e092cd-6335-4db9-86c8-08dd87116d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2025 11:31:47.3765
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uXp+xjeFppy0dgB3on7n9vlBxokWc2brY8n92nhEMtL0f/ty593QIdjNSSbgIEv7kaukvM7uCbl6PCSCBLZa/kVE+pTU7GAAWU8o/6sIbzA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS1PR04MB9606

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K

