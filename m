Return-Path: <linux-fsdevel+bounces-2503-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3C5A7E69F3
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 12:55:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EFA01B20F82
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Nov 2023 11:55:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B58F1CA95;
	Thu,  9 Nov 2023 11:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="NxbC6FZQ";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WNDEG6zk"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C3118C3B;
	Thu,  9 Nov 2023 11:55:08 +0000 (UTC)
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C79211F;
	Thu,  9 Nov 2023 03:55:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1699530908; x=1731066908;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=wfJkoq7y1TiZ8lIQUHJPqrzVWxQbWi5TCrPhPPfBFNY=;
  b=NxbC6FZQqyuk/Jrp/gdvsydAsQyKEFpLus3BUK6uvzHkqo+hWSEr2W51
   WAWK7Hxh3LIndN2eFkiteZU/vjoBG14bO55QdLMMxDNUGTggqwPtGVAR9
   jqMjjFzSxhwEqvHf7gf/cmst+oS0UnfUxjAxz8yiw3frpM6BjVNyRKgKy
   q8NUZ6wQw3kC68OIzG5CIPUHNJ9euzcGnYRllA4d9ctmzhD5/PdZ6bBBY
   oq6W54Zsfiqa/UPSpVYxkh4VFzq3M0zwI/U/fAqd2wo07X8C7Ag0ZLWw2
   2VvCRFZk7E4/nmPhfFL7bkSXcGgrrTkuB4/Nj6+dzhBj2a9m3Tikt5ano
   w==;
X-CSE-ConnectionGUID: cZ/+eSwSQMSiP5QvdOWRsQ==
X-CSE-MsgGUID: mEEOUhHsTu6aD+QW66QfDg==
X-IronPort-AV: E=Sophos;i="6.03,289,1694707200"; 
   d="scan'208";a="1809909"
Received: from mail-co1nam11lp2168.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.168])
  by ob1.hgst.iphmx.com with ESMTP; 09 Nov 2023 19:55:07 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aJ1eti5GHDCR7G7/ZjmNy77DjjgP2RHav2rrDurdMOdTiRLzpeH+r6y4Uv6UNKtnISWVzMLjdm7aNnbslCo4YL31ErfcczdXR+9Q9jUTWihZkPM1YO/YW6P0WUwHe7Sm1oyPVMQ1OG/fgl37OfjiRgAV+iL8Ik0tzVE0Z+u20fa9H/giPuiL69s/PJ9NSbnHRnUYYWRisBRAY+I9kqwJjA2qCGOjli7F97Y29KYIVE7m3c0bVYNa7cGOGZ3K9OwMJDbBYMqyH7fw/hKyswtL3cMo6FWJruhVjcRQUfLjEE48PLXrAOFL/aWf5m0TNB/jUK+abPctXInDYxhYGEyv0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wfJkoq7y1TiZ8lIQUHJPqrzVWxQbWi5TCrPhPPfBFNY=;
 b=QB4524MiQC1x4PsCEFr+YBFWfGvFqtBVJIfEA1t7Qk4ilmh+Y5FclkPys1xlCTRSCRR7enr+GDAVWYmoJP2HdNiS8giomlHwMXqDX1Vrut20/RWS4S92iS3m8z7cAIcLIBkK+TTznuwTGdwX1YRR0L5gczYH+uium8CX6jZnxZN0wUuPvVJRr78mcHsHOL5hXpZkMF1d+/afTFElMRVaayyGpaYvxrsyFyj3xsqUVA+NamEN28jVaXsWeiItUQClZXUzyj5Qems/1/l8UJCYZXGkp9aU0996h5SB/dBtr3SCxtHl275ylGL81RLvVKdFgFJu36RYLO1ikqU/z5vu1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wfJkoq7y1TiZ8lIQUHJPqrzVWxQbWi5TCrPhPPfBFNY=;
 b=WNDEG6zkpatx1FnBTpdnUDG1yPOWBdPErSv+ixBFJc2fflaEdF04YtqdnGUsxT7zNAsVBfg2c3DMRPu7OHmwddTgX5HU3pJNVqGw0QLai4aP8dUmMaYJT12znGd2f6u7NiziQ1VbgjKZfIJYm355Go7qtQdo5WzbZ/roIkRXc78=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM8PR04MB7830.namprd04.prod.outlook.com (2603:10b6:8:33::9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6954.29; Thu, 9 Nov 2023 11:55:05 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d52c:c128:1dea:63d7]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::d52c:c128:1dea:63d7%4]) with mapi id 15.20.6954.029; Thu, 9 Nov 2023
 11:55:05 +0000
From: Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To: Josef Bacik <josef@toxicpanda.com>, "linux-btrfs@vger.kernel.org"
	<linux-btrfs@vger.kernel.org>, "kernel-team@fb.com" <kernel-team@fb.com>,
	"linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
	"brauner@kernel.org" <brauner@kernel.org>
Subject: Re: [PATCH v2 00/18] btrfs: convert to the new mount API
Thread-Topic: [PATCH v2 00/18] btrfs: convert to the new mount API
Thread-Index: AQHaEncZAT+O30/JHk268X9be9bQ/bBx4jgA
Date: Thu, 9 Nov 2023 11:55:04 +0000
Message-ID: <243f107e-5dd4-4c3d-a8a8-59603c751f67@wdc.com>
References: <cover.1699470345.git.josef@toxicpanda.com>
In-Reply-To: <cover.1699470345.git.josef@toxicpanda.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM8PR04MB7830:EE_
x-ms-office365-filtering-correlation-id: 25b4028a-1a3f-4e17-4706-08dbe11ab66d
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info:
 IocEmAo2Ubi+Ty/0vndxUc7i2yPQ4TEpSi8mKzuLRA+DTtpI/EbaoAex7cYTLr2CUFhzDq73bOwv0/WlRNLuwfz3dCC0HGivnT9aleOoKIRQaFgPZ5b1thyxJLf5qR4iDkDY4rIinCCBpGLh//e6BjmuBbC8v+97CfM3agrK1JsJ/yeiZAvve8u6kNMTFBDqDHJV9fREX7nWW/i6JG43xr/BOt3Ll3xAjJrnAG2g9+UgqXW200AKrufKhPry3ZX5GuZVJL/9SeYQCOQZZXWG2LpnQ8iNivbpzWGM3xTqqQnhLZYc69mLVjfMBf1SBBe+I0Dtf8lwiMC6ajrxqJYI1tADVwTWmtabExJImnPrjJ5wYx+Rjba4yeSPMsMnfNqJVevLKzJdZxGZG41iPylkiAHQGeSzNQOXW9QO/0tjDyNGOqL89dmLtyGio0bPMHLiaXDLseBXGyMrb6QYBPdfGudL0qmSbz8QH+GBJA6Xx9h2Sm5F/CSWGk4zpS7AtIS/8fS01CkFjuNEInMjHTkLzTw3H3t7kHlb3tCrP8C9Ee69DQiCjww72DoJLvOSvef8wMpQKBksGptD7h1D5D9sBpRx67nY8qKZqNs+pCPZgCy+NmSTxwXP29+ubQGGUHcrmDwYTmiQe1yPcQ+4Qw09aQabRt6NFW39zQEldxgLY9nTj5r0tYTFOzSSQUSkB9AJ
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(2616005)(66446008)(31686004)(110136005)(478600001)(6486002)(6506007)(38070700009)(86362001)(36756003)(31696002)(38100700002)(82960400001)(558084003)(122000001)(316002)(76116006)(4270600006)(66946007)(6512007)(66476007)(91956017)(66556008)(71200400001)(2906002)(64756008)(5660300002)(41300700001)(8936002)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?NW84ODF6WXE3NnQvN2Y5UnFhWWo0Umd6QXZYdmRlblJqcFcvNFV5UkZqSDl4?=
 =?utf-8?B?Nk9nbW8rS1dwbnY2eE4rWnZ4TGE3Uk1wcGVFak04N0ZTZExYOWpkRFAwc2NO?=
 =?utf-8?B?T2xRTEhiUUJVbDVQZ2p5b2xSQ3lsbkoxNHVmejV4RCtsRjdxYWJpNm1mbTh6?=
 =?utf-8?B?MUtWTE1JQngxUGo0U2ZTRnhWZzJPSUI1bCs2M2Q5QVhRNTFHZ1dyVTlqQUNH?=
 =?utf-8?B?d05QMUpnNWRhaEVsR29KKzk2Z1JQZzIzVG9yM0pHcy9uRDZxWkFPbUhOT3VP?=
 =?utf-8?B?NW1uZnZueElQbGtFTlRrVU5rcWMydEFsWGNxQkhnK3lZd0EwVFRPZW5FY2N3?=
 =?utf-8?B?Z01HNzc4eGFqYlgrTjgwemNiL3VCeEw0TWtIbjVjamdFZUdES0tYRDEvbGFa?=
 =?utf-8?B?ZXlrbmQvTjU3ajV3UUM0ZjlhT2tZUDQ4VEd4a0ZIS1E2eGEva3YxNTd1ZkE1?=
 =?utf-8?B?TzBURmJVVnFZVUVwZ2F1SEdlUHNrbTNIR0YwbzJSOEkvY1ZGazdnbTZFdHdn?=
 =?utf-8?B?Yy9SU2xMci8vUDJJUGtGbnM2SmZvcGZLNFVZOUhPZnJURVZkVFcyazAvTE9O?=
 =?utf-8?B?aVUzdW9vOHZuZmlqazh4RllpUHB0VmZBWXVOMDJZZ09ZQjlZZnR2UituS1Bo?=
 =?utf-8?B?VFBTUHFKakxSZ2ZEajJXMkZFUk9OT3VKQkN4RnBPK0VuSmFpUllsVUp3TTMy?=
 =?utf-8?B?akFzUVp1N1RPUFg1eUh2VTYramhxOVhpU1Y4L2NEU2lTZEJiVzhWazdRYUpY?=
 =?utf-8?B?K2Mzb3lyYUlkQlkxQ1FCS2hRaDcyMEtYeUwyYUwvR256NGM3WnBVdVg2ckc1?=
 =?utf-8?B?OHIxVE9IUGY4VmJ3andFVGU0eURKQS9sR2hUeWkrV1dUVXp1bWVMY0VlQUtn?=
 =?utf-8?B?VlprUS81THBGMU5PMXFXeFMzL2IzYk5xK3RINmVxN1M4blF3eU8vNHFOTUJR?=
 =?utf-8?B?bks1QnROTUR3YlJ5am9DQjdPelQ3UHczd3kyRjlqa2ljaWovQVAvL0N1Qmph?=
 =?utf-8?B?Q0RJVlhlMnV6NXFTWmsrUjVuTHhONTNWUlJ5WHZTN2R1VGpMNW40VGsxQXpC?=
 =?utf-8?B?bkM1R1Bud2gxS1Vwa3FJc3JveldWc0lyUHpvNDd4TUZMQ3M5Q2FuME1HaVgv?=
 =?utf-8?B?U2NNMC9OL09YQm02TURSQ0ovajJrUmtCK3hFR1lodjVrQnlHc3pXSzRSdnBN?=
 =?utf-8?B?RnFpMGtpTytRd3MvSnNCVXMzb3krejBJci94Vlc5SFU5SXN3dWxWM0xNRmI0?=
 =?utf-8?B?SEg0eE9ZRUkrQ3V2bXJqOFRPMUVJWGIxdWtrUUxJTFJtYlovaVRycXFCcExk?=
 =?utf-8?B?WW9JVFpmbnA5bHpMVFFLd244c1JZeWg3emRwMjlxYWl5VkNDN3ZyU2Q1Njk4?=
 =?utf-8?B?UnBGSzZwMTdDbW9VU2U3NUVVSFFMUUJscUxQN3dFSGRtc21nejRmK3ZNMDQw?=
 =?utf-8?B?UmZaZC9RMVhyTTZ4MitDS1Z1ZHBZOWFnSGtCQWR3L1pSdFB6aXlOYVA1ZWJp?=
 =?utf-8?B?RC9xUzlFNmRmU2VOYkxJKzdrczFnNFFwNWVoQWtud3JxYnU3TkIrbThITExL?=
 =?utf-8?B?TVkrUUNhMXBrNy83eGNsREpHbXljRmUyVnY1dlZFN3o3UEQ1cWRTdEZZUE4x?=
 =?utf-8?B?UlYzRFc0YThITFNLRmFUUTVwRmVLcmNIYmx5SVZuc29PcFhMZkI1cmRjWVJJ?=
 =?utf-8?B?d29nME1zSm80d1ZFVWlQWmRPUmtUU3k0S0xlL3I3Q0lFOTZlc3JveE9HZXpC?=
 =?utf-8?B?SElEcno3eFBmVVpmTE1PSy9lVDExZ1MvK3JsOW5qMlpuT0Uwc1pYV3FUK0hw?=
 =?utf-8?B?cnYrNnBaQ09BT2oveU5kYmcyQ01STEFFUVduSXRObmg3cUw0Tm1Bc1daQmYy?=
 =?utf-8?B?eGVza2tCa0FNQ1o2TU13RVVKTVlwTXh5UzBIbHlDSmdlMDQ4TDh2c2pUbDBj?=
 =?utf-8?B?ZHo1TnJhRkd3SHRwTTJtaHlWcElDZUMvdTNXVVUzNHZpSlBOUVltQ2tKd093?=
 =?utf-8?B?U05Pc1oyQnhiV0dSOWdnMElSMVFRSWdWNHkxWUJYZ0x4UEpoOUt6SENUZTJ3?=
 =?utf-8?B?dHpaV1B6Vk1pVFJ5YjF0NW5iR1dPSS8reTdmR0FtdmZpTktEejZrUGsyVmoz?=
 =?utf-8?B?YXVKbEhYUW9pOU5rcTJEVm5Qc1dENUd1NE44Qm5TWEhRcU9ZQUhLTnJhb1NJ?=
 =?utf-8?B?NUpoV3c4MGM2a0tyRDRIWS9kRGNjYUE3QjB5d3dRUUJDbXFLbGZ0TFpxdGNJ?=
 =?utf-8?B?Nk1DYk1Uek1ycTZhS3VPcERqcnpnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E583C18AE8C39B4496392FC1E44FC9E6@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	lY2ge3Y8oVmTQpAL8PnkRGdPSDDkOkSNRk5bhaUCK3Nup3dF+tKwRmXxPfrK3ogSe/Cas7rvIu5WGiTi73QKZ59h9k3nkYU0cM+spePq67nVmy3yVVvQ+IY04i/Yta9aqpIMeDO897mkhJgMN0ASYlqcbr72x1h7gw+K4EJLYfJhPNwmj+/TXfVNlr+DqGKkSiKOK8FoqfXI1J/0AKPO8KDIFq+78mBsScx77jvKluZ9WJfjOn1zLoZ+L4+zpe/jLGdpU3Sn3kDn4UD7x91w4fmA4bULBv58ah/lfkaMWsHQek0Qf/8kxbUUwaN7pfPgBV+h5hMdP30sxZv0LTqvG/H+adFxW2rB/2A6UJxFJFA96mG5TOMqR5d00UfxrWZk5EUIkumJ08lUe37Xhm4cp1IMGerg6Gb61iu9cWWpZXuk9YQs9aYZaKvbdtcfJCWhxmUH1OoSzXZa7tUN1frXoxOJOJBZErfKZWrJv8OektkJK1LuVzTatQANVS890iJ+c5wHi/ZFFWZpy/vJy8XlbmuLaAUMKso9Ln7K4zlB+uOarfsqt/bnsKlCYr0dgtjyHdLGKuVbqVZdJBPRtRJrGOcrWXyZWsL/SeVswfKwyblX6kdzSiE0OBChKxrwR/NZbUhVrDKi4XFjhYz/TiUh8995YtLSRmzOid8x87Z+0s/j0vwFTZqJZs6Rd7ZdruTurDHVyhIUZs2pfwrUdbmSn5EH67QXf8s/M4H2/J4Xj8Wd4RpclaHuXy93sDfhm7zRimOExqbl5b5Ne1+8wT031t4elkiaTySmyfPABuzljzjBLgpAjAQZoXpH6NsQgtQfUrv/1y7JQZhR2SE6wttWERbkyRCl15cguqNKD82/amJCiXCN1ppLF/19u7718A6n
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 25b4028a-1a3f-4e17-4706-08dbe11ab66d
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Nov 2023 11:55:04.8950
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Bw02Q/WCAb2triO/82PveYLo+nYPdujzEVOhmtO0G6l/tuQK6jiEveh+AIph9wdnsP2BfEctTF5u/g26hGCd4b4JgwLajFi3ClAiGY8uyo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB7830

TG9va3MgZ29vZCBmcm9tIHdoYXQgSSBjYW4gdGVsbCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBU
aHVtc2hpcm4gPGpvaGFubmVzLnRodW1zaGlybkB3ZGMuY29tPg0K

