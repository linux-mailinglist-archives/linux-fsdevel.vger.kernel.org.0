Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51872712386
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 May 2023 11:27:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbjEZJ1H (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 May 2023 05:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243035AbjEZJ1F (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 May 2023 05:27:05 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C9C135;
        Fri, 26 May 2023 02:27:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1685093224; x=1716629224;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=BgjT95wArCJb4q3cFAf3biUpSAAErt6sf3GM2j4oVmc=;
  b=rloAO9jWZr4J4VRDuh7zaxBB4cvB7YOyIQnXKJYUD5RA2YhAJaCajunr
   ITMIxImTqgtTxlGM9U6BNnRQVGo8/QZqCuxa4PiaTUEnQCZsy5lFV2ThC
   URWYuZe6iz2kUjf/5yTd3xIl4KyjSxyivrg1MFyPBadjmHjaRmc3NwIf1
   OJG4DKfGvHCl5iig4XerBbnxhMywWloKqxvsWTRgJPagVc4FqEFFm3A4G
   uE5sBMB8tIZokHiiBJxO2OAc44P3WpGJ9i58+NURIGvNdcDFJEzfcKS2g
   TZJeOTddyUslj5PC5TLuUbbQpVbWoij9+EwaEEioE5l2QSJmZnxdMFaRi
   w==;
X-IronPort-AV: E=Sophos;i="6.00,193,1681142400"; 
   d="scan'208";a="236654341"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 26 May 2023 17:26:50 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FttOCtpc9i+WvVU0rc5WRzvCzfOPYl/P9x80pDj55e0yJChU9QfBNH1I3uEZ2ImUW7OZTwU1cnMUQ0l94VnXia3kRQvNhp1TRC2Ow6gjHj3JY1Es5wo7SfQGrhBVzrOT5WATkKjsfC96m1VpVkWHkc9yUuqs9LpVsWIvY6sHYstTELeg0UjggK7jLRs7G/bin60sZdacMnaRnExXn41GBuwROCYtiIEOraadu+g14m/75iPNjSBUG3TMjkdT6FaxgZ5fyvvHBP/PyivDfCMeK/x39vyltGbd+wPNmVlv+wGfuDJuDahN0nKQ+E56kz+eoOQb7busA6SsfT+Wel7S1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BgjT95wArCJb4q3cFAf3biUpSAAErt6sf3GM2j4oVmc=;
 b=TTEVtMqHYF2G3QUm1ehE795AZgCkUrpUYmPu7DUAM99PAYUu6/cB1JXrfmST9tOQPR9FELb8t3LghtquOF3J0bbcWZh2PzGNHqsVc2oeqry7U6OdYB+XrPJOv65vsCcA9bCz5EGJHn2vZkGm2HTWnNjXamx39n6gt2PM5lQpYsuQ1XHvfUgvPljIsMmVcKUx517ck41Pwh/X0PuweQg5HsIy2ovsAlixheQHrh1avAJQCf/dxrY39D3iT4ylhpBs/usbu1vwbNykd2cdzGh2+v1hAWtZo2bqTe1z1YPNNQI1dIYHU+9ZWTr3TRf2hkTGZVr3Z7Prp6I+gS/USyyIrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BgjT95wArCJb4q3cFAf3biUpSAAErt6sf3GM2j4oVmc=;
 b=swJGVucBheJx8vyyAUEQMBLarbE3tVQ+e0iutf4I+Ra/OUTcs4afK1Z/H64TVyCuKMeX4dbr/GSPdeE2U0/UbOgFCp57mMS+lfqUjhHv01XpIoDLjj4bdbLjBhlmZS2pjt2TO6Z09fiaDAE58QpoeClWD1mAJk7kqMpN1p2rpwM=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH8PR04MB8712.namprd04.prod.outlook.com (2603:10b6:510:254::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6433.17; Fri, 26 May
 2023 09:26:48 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8c4d:6283:7b41:ed6f%7]) with mapi id 15.20.6433.018; Fri, 26 May 2023
 09:26:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@kernel.org" <snitzer@kernel.org>,
        "philipp.reisner@linbit.com" <philipp.reisner@linbit.com>,
        "lars.ellenberg@linbit.com" <lars.ellenberg@linbit.com>,
        "christoph.boehmwalder@linbit.com" <christoph.boehmwalder@linbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "minchan@kernel.org" <minchan@kernel.org>,
        "senozhatsky@chromium.org" <senozhatsky@chromium.org>
CC:     "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "hare@suse.de" <hare@suse.de>,
        "p.raghav@samsung.com" <p.raghav@samsung.com>,
        "da.gomez@samsung.com" <da.gomez@samsung.com>,
        "rohan.puri@samsung.com" <rohan.puri@samsung.com>,
        "rpuri.linux@gmail.com" <rpuri.linux@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>
Subject: Re: [PATCH v2 0/5] block: simplify with PAGE_SECTORS_SHIFT
Thread-Topic: [PATCH v2 0/5] block: simplify with PAGE_SECTORS_SHIFT
Thread-Index: AQHZj6RuVVwHwlQy5kaD+rEALgEnnK9sSRmA
Date:   Fri, 26 May 2023 09:26:48 +0000
Message-ID: <c156b1e4-8a8e-e296-05f4-0ffd75903380@wdc.com>
References: <20230526073336.344543-1-mcgrof@kernel.org>
In-Reply-To: <20230526073336.344543-1-mcgrof@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|PH8PR04MB8712:EE_
x-ms-office365-filtering-correlation-id: e884dd21-3daf-4af9-0e59-08db5dcb5486
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tZG/rljJZKJFL4Hl8M5JBUSBw6yBwZCjBjTONTYQKMgVKaNDBGhbukQfuElhinAzbEaNP+pSPVfZAVlQMdIrXp7V1ffWNHg96ivFob/Th1mrJ3y1PGenHqzC30t+dHlnOu2CFepDDdgzd0pS0EoimREzw8sw8lu5kfGSHl4D+TBedEfVNspT3GOQemwIvmIrOHxHSQxPR6H5jdnFLpgvXRtLV0CcV5cYQmuEgKMfr2PU5WJmS/dxRRevSs0HDQIxJ7Lzr7tcRUqUah9JOMpe1Ibd61IDFGDsz/yZkE6jg6ls1mDwWhZFxAidPH5GqzKWykqodfhnpeUzMKAFQ7GqGdod7o50CudlsV4TnZ/lK7+QniRd/24v1hqfNrjULt2RtqXgEXIJoPZkNzMtuOLI3f1qub9x06L5aoJNtrUsU/lUiWLu0lDsn5sgGPyQJmcJNkjKk3F/i7wffUKEd7KGM0ri/4pgDo3fxm2wkJ3ZvS/FiLfLuuEbm15klk0/1jxfFCdQxiiN9kGmQwFKhV5fuPmyCJy6Xlx7QDg4ARgsDvw4vuxTXkm33cLl18MygDJEAI6r3nS2vnmIOAscdhSRZ0eLPlMuVIFDcOTWNvwL/HBOeMdOxX4DNM7o9lrHguho2NiM6FfP/0qXpERH3N+MydqBC+saeNsK5RPKG7O+hWwoWOm6ZMW02dCw679bcBcYSHGZ6BFgM6ws63g0v9kvylO90N/bs1Ua9Aq3WjBtuWSgovOV9UVHu1KH61YBvskv
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(366004)(396003)(39860400002)(346002)(136003)(376002)(451199021)(64756008)(4326008)(66446008)(41300700001)(8936002)(91956017)(31686004)(66476007)(66556008)(76116006)(66946007)(8676002)(110136005)(54906003)(36756003)(31696002)(71200400001)(86362001)(6486002)(478600001)(316002)(5660300002)(7416002)(2906002)(921005)(186003)(38070700005)(53546011)(122000001)(38100700002)(83380400001)(2616005)(82960400001)(6506007)(26005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cGFmZlJSWXpYMC9ZRE5VSWRlSnhaUlVoOSt1cHdvN0hFTlptZ1BBWWVRZlFL?=
 =?utf-8?B?aVBPREtBOXRBUnh1WVRJRG93QUt0bU56Q3UvNWJnOE5ZeDI2RmJyNHc4WGc3?=
 =?utf-8?B?S1NJTGdrMTlCakc4eVdYdUlyNU95TS94NWsxQmRRR29TQnZ4VDA5UWI1ZGpz?=
 =?utf-8?B?WXpxbWxrbEh5UzB0L1c2NkUxSWpzQ25neFVmQWdmeHlXejdYK0xOWlV0ZEhU?=
 =?utf-8?B?YUt4RTJUTTQxaUFYcmw2bGY5QTVFU0hCeFo1SG80NXNLSXNZVzhUU3cvbVlo?=
 =?utf-8?B?R0JBWTViVzVCQUxGeGd1aWdBSmVPWDdxRU5nYnY5UC9hdFgwY0JUOTBxZHZk?=
 =?utf-8?B?Z1hESFFwK245TW5vaFppbk5hU2lpeW1mNTRhQmRVdUJ6QzlZL0FPWGRlbDZZ?=
 =?utf-8?B?bGpJcCtMUGJLYUZYRWV4cUpHOUdPZTNraHJ3QVVZeTVpUHZwQVhiTjN2ZzBW?=
 =?utf-8?B?RTIweDhiQ2wzWExoL0QzUlZmVmE2b2F5dGxnSWhmdnJtK2dxS0tnQVZsMDVJ?=
 =?utf-8?B?c0F3ZnRzV3QrbmhBa3dUdksvMlhEeVdTWnpMbElOMHJuQlNmRUQ3TU1hZXRH?=
 =?utf-8?B?b2xudkxkL2piak4wcFU3WWRVTVhMcUlnaG9iQ2pBWlRYQXEra2p2aXN0RnZC?=
 =?utf-8?B?YTd3eWQ0dHdsVmx5R21yV2NrQU1Hb1RhWitRalB1THIvSitrQSt4S1BHQmpF?=
 =?utf-8?B?MVFnMWxwRkNoOUtwdVFxb0wzVFdGWThwRks5VG4rUCtkWkF5REk5cllRUHdE?=
 =?utf-8?B?Z1BVaVBDWGRkSDN1cUZHZTgvM1ozbHhQZ0RxTGNadi85THFEZTYvOWU1RDF4?=
 =?utf-8?B?bEpNTy9qMTBEamplSVY4a1NIdEduZFljeFV3akxHaXhVcXpnQ09Wa1dNV043?=
 =?utf-8?B?b0lmWDd6NWdEcVd1QzhzYkJOMWJVK1EzK01HU2xvbWk4ZGZCK3BFQTZWdjRI?=
 =?utf-8?B?Q0pmcmExcG5ON1JSL1FLQzVHanpNVFBrcVc1QS92VkpRenV2N0laRmlJTHN4?=
 =?utf-8?B?d21Ja1NDWUxZMVBlNHRGWmxFOWduR2lIR0Y0TFMxVTE2UVd1ZEpZRmN4UERR?=
 =?utf-8?B?UW5ocFpuTHlOdnMwQ1lMTzVjRnVEVGVLMXBmOWRScTZta21OOXhZNUoyOFht?=
 =?utf-8?B?VHdVZk1OM0k0MGtkYXZFcVFGUCt3S1llNHJyVGE3NDlneVdxM1kwdjZwUkFt?=
 =?utf-8?B?WHRGeEhlZHNsbWlEeEluMGk4eHpPT1d4dDdzRGZaZHNKbWgxVE1uQ1l4bU50?=
 =?utf-8?B?WlVEK3VmaTdrZnVzTHdhdFhnSFhRdlZtRURaR2JsZ2ZKcW1QUjVEVWRmTEVu?=
 =?utf-8?B?RXo1NXZ6Nng4NG5ITisvVGNFTTR6WDJJeXRuTmx1Q0lOenhZZU43eVFXanp2?=
 =?utf-8?B?WHNaOUQ1Mjh6Nm5GWVZMd3UyU1JqdGxHaldNWkV5dUFmT3IyMU5WZDE5SjJi?=
 =?utf-8?B?Vzgxc25uQ3BJR1ZETjcyRDMyS2ZianVQczZOQWI3U1RVdy90NVZQTzN5djFD?=
 =?utf-8?B?N2pMN1VTeVZidGI1WFJ3QzhtRkhzL2xWanFydDNwNGdIV2YwdzcrdnBXNG5n?=
 =?utf-8?B?YXhKVmg2QTMvNDRGc3ZIS2Z2aDE5bEFNNXYwREhReDhRcUVhUEZDSmdQU2l1?=
 =?utf-8?B?a1VFbWVsbUNMQ0lvckJxaElyVThDTUhhOEVYMlRpeVZnTFdHZVg5ZTRndUg4?=
 =?utf-8?B?MDhyTVlzamdZeEdqU05zcjdDZ0N6RlRLYXh3aHZyeWQvSDMyanFhVzQzVndO?=
 =?utf-8?B?RCtjLzY0VWFUM3RiSTVFYWk4L2ROZFQ2czVyVHAwTk40RkhJQmc2TTJaSElp?=
 =?utf-8?B?WmFmc2lTOVVibFV1Wk9KaVFMMVZEcDBSN0hKU2RpRHYwcFlqRkJvZFhHa3JR?=
 =?utf-8?B?MERIaUZ6RVlZSWdQM0lCYWFreXRmRTFrZ2RESGZqS25VVEphWEVOL3VrWGRn?=
 =?utf-8?B?TkZuWDl6aTBZc3BITjRKdVViWjFuU1NYdlcrcFBUSSt6VzY5cFFrN1dqM2hW?=
 =?utf-8?B?M0RsYlFSL1NRTFdxRzB3Z3NUbzBwZkU0dEpYbnpIdE9nKzgyNFlIaHBSVW9m?=
 =?utf-8?B?L0taVmY4cFZpMnJnQUN1R3c1T0R3TTY0M3ZOT1A3TGEwYUNybzdka2pBelJX?=
 =?utf-8?B?UlIyYjgzVVNHR0xzbk5Vc1RFb0tGTVJ2NFZCdzRJZkJGQm12YXpuVENlS1la?=
 =?utf-8?Q?VPC6700jO+W80TTc3Xj2EEE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <811ABC632CFA204FA57A834FE3BCAB71@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?utf-8?B?aVFaZVcrMVlFZzQvMzFPVE5tY05vZTBGN2ZYU1IzMkNLTVhlZStNQ0phT09v?=
 =?utf-8?B?dGVDb0c2Q1FZM1dHVE9YcDIvc1NwTkMvejBqd3Fybk54QkNmd05RaUNURXJW?=
 =?utf-8?B?bHlxeENzLzJsTTBaeXNsYytUTlpoNjdreHYwWUlXRGlDVkE4Q25OZ21WaW8v?=
 =?utf-8?B?Njk4djVPdUlQVHJqRDZUS1dwUVZTT2kzSS9reWh3SjNaSUpiZU0zQUJBcHVp?=
 =?utf-8?B?SGpnelVvRkVjeG5GRU1pbTZlMFdGSGthMDQveXBJbVJqWWV0b1FvOEw3R2JF?=
 =?utf-8?B?WjJFQ0lxSERGSGlhVEYrUkxjSEw4NUFNZHZ5K2I0MEZtVGJTSWVuUTFQSWxM?=
 =?utf-8?B?QkNWWjlHZGQ5dG44WXUyQ283WkZJS3pSSDFRdzhjcVBhbEh6VmI5VDJxN21i?=
 =?utf-8?B?R0FkbzhWK2tqRUxEZ0hrRS9yRHdGR2hJd1hZd0ZBRlFFZzhwTG5ic3g5d2g1?=
 =?utf-8?B?SzNyZW51YVNEOUxQV1JSdU5pU0lnelZNamo3eDQ1RXlYZSsycjB2Q3lqYThw?=
 =?utf-8?B?YmY2RUxzZUJKK0ZzNG1vaFhTNUhtU1hPQmQrUjJoSEx6bFg4amNiRjFBSUcw?=
 =?utf-8?B?VjJxaDRtdzNmcUR1UEZaL1VUaXBOYVVMRlRGN2ZqZXlhRW4vSUtMSXMvejFs?=
 =?utf-8?B?byt3WVF2QXVFQ1FENktPdE5VUGxjYkxQaHlXRkNFelZvbmpLTzBzV1lubFRm?=
 =?utf-8?B?bUpyS3lOc3pKRGtVUVRITUNDb29EZHdETngrT0xtaUw5ZGtjbm9CL2xhcnRn?=
 =?utf-8?B?cXV6bEtwS3VlM3ZhM2thRFlueHg3RnJ6YWxTK2ttZG8xT3pSL3pXMENETThh?=
 =?utf-8?B?RU1ickwwUWIyOUdYdVZRUnJQa3JsUkJwU3pGSWJiT2dQTDUwTFBaWXpaQXFh?=
 =?utf-8?B?WTJnRXVKZDFpZlpTR1ZDdkNlWVZoRENOMHRPV3Fkc1NnV1k5cERtT2RnTkxY?=
 =?utf-8?B?RzZXOEc4L1Z6VTBHSmt2Ni9ydWxpdG4wVnFmcmJ5dVdGVVZKbkVKUk15eU40?=
 =?utf-8?B?cWVpbGoxNHdCbS9NTktET3oxV1JwK2tnZmkxSHloM2ViVnk2bHlMMU5oUzlz?=
 =?utf-8?B?UFFhYnRkWkREUEpGNmdxc0NzUy8rS2lKZ1dnT09GZEF3L3Ntd3dPUVVKd1ln?=
 =?utf-8?B?U2huWkV3RUVRR1U1dFRweWM1b2dIdTlCQ2ZCUDZuU3IyRUI3dzdncm9wRnNz?=
 =?utf-8?B?NmJzUTB4c1g0SjlSTUg3ZWU5alR1cHZXN2VjNkVTU1YvYURGWVRiOEN3UmpI?=
 =?utf-8?B?Z1hQQUN5Y2gzMkI5aittbjBxdTZZMDJlMkRqMElvWlpqUGlweWFpNmxIZ0lj?=
 =?utf-8?B?cUI2T2ZwZWZVTlM0SFRSWURYeUlWT2YxbTBhb2lKcmhnNERtemM4YlFaZ08z?=
 =?utf-8?B?Z0ozSkp3VDB1TEZpZFJ3bnp3T3JET1NKaFU4VTlaYko4N1NkOWRhYk9vdTJ2?=
 =?utf-8?B?TVMvaTVFb2dlTDNkTU1WVEtIbFhQb0UzV3dZcmZKZGNmaEtXUDRrclhPU01r?=
 =?utf-8?B?K041U3JtSXVVZEhESFp0a0pqem0wVVBZSHk4QjVlWVZwWjZoZzZvZHpyRHNm?=
 =?utf-8?B?b1hCUT09?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e884dd21-3daf-4af9-0e59-08db5dcb5486
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 May 2023 09:26:48.0711
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8YbwVu9/6jYedKGHKxdSAuHlGBV1szSyE27Y37/I/1j5GnXYCcQcCWejFcqzKpRJV4zBEljkg5+oQd3Aah+3I5itrlgf6LdN4iXrNYhgqT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR04MB8712
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMjYuMDUuMjMgMDk6MzMsIEx1aXMgQ2hhbWJlcmxhaW4gd3JvdGU6DQo+IEEgYml0IG9mIGJs
b2NrIGRyaXZlcnMgaGF2ZSB0aGVpciBvd24gaW5jYW50YXRpb25zIHdpdGgNCj4gUEFHRV9TSElG
VCAtIFNFQ1RPUl9TSElGVC4gSnVzdCBzaW1wbGZ5IGFuZCB1c2UgUEFHRV9TRUNUT1JTX1NISUZU
DQo+IGFsbCBvdmVyLg0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgDQo+IEJhc2VkIG9uIGxpbnV4LW5l
eHQgbmV4dC0yMDIzMDUyNS4NCj4gDQo+IENoYW5nZXMgc2luY2UgdjE6DQo+IA0KPiAgbyBrZWVw
IGlvbWFwIG1hdGggdmlzaWJseSBzaW1wbGUNCj4gIG8gQWRkIHRhZ3MgZm9yIFJldmlld3MvYWNr
cw0KPiAgbyByZWJhc2Ugb250byBuZXh0LTIwMjMwNTI1DQo+IA0KPiBMdWlzIENoYW1iZXJsYWlu
ICg1KToNCj4gICBibG9jazogYW5ub3RhdGUgYmRldl9kaXNrX2NoYW5nZWQoKSBkZXByZWNhdGlv
biB3aXRoIGEgc3ltYm9sDQo+ICAgICBuYW1lc3BhY2UNCj4gICBkcmJkOiB1c2UgUEFHRV9TRUNU
T1JTX1NISUZUIGFuZCBQQUdFX1NFQ1RPUlMNCj4gICBpb21hcDogc2ltcGxpZnkgaW9tYXBfaW5p
dCgpIHdpdGggUEFHRV9TRUNUT1JTDQo+ICAgZG0gYnVmaW86IHNpbXBsaWZ5IGJ5IHVzaW5nIFBB
R0VfU0VDVE9SU19TSElGVA0KPiAgIHpyYW06IHVzZSBnZW5lcmljIFBBR0VfU0VDVE9SUyBhbmQg
UEFHRV9TRUNUT1JTX1NISUZUDQo+IA0KPiAgYmxvY2svcGFydGl0aW9ucy9jb3JlLmMgICAgICAg
ICAgfCAgNiArLS0tLS0NCj4gIGRyaXZlcnMvYmxvY2svZHJiZC9kcmJkX2JpdG1hcC5jIHwgIDQg
KystLQ0KPiAgZHJpdmVycy9ibG9jay9sb29wLmMgICAgICAgICAgICAgfCAgMiArKw0KPiAgZHJp
dmVycy9ibG9jay96cmFtL3pyYW1fZHJ2LmMgICAgfCAxMiArKysrKystLS0tLS0NCj4gIGRyaXZl
cnMvYmxvY2svenJhbS96cmFtX2Rydi5oICAgIHwgIDIgLS0NCj4gIGRyaXZlcnMvbWQvZG0tYnVm
aW8uYyAgICAgICAgICAgIHwgIDQgKystLQ0KPiAgZHJpdmVycy9zMzkwL2Jsb2NrL2Rhc2RfZ2Vu
aGQuYyAgfCAgMiArKw0KPiAgZnMvaW9tYXAvYnVmZmVyZWQtaW8uYyAgICAgICAgICAgfCAgMiAr
LQ0KPiAgOCBmaWxlcyBjaGFuZ2VkLCAxNiBpbnNlcnRpb25zKCspLCAxOCBkZWxldGlvbnMoLSkN
Cj4gDQoNCkhleSBMdWlzLA0KSSd2ZSBmb3VuZCBhbm90aGVyIG9uZSBpbiBzZF96YmNfcmV2YWxp
ZGF0ZV96b25lcygpOg0KDQoJbWF4X2FwcGVuZCA9IG1pbl90KHUzMiwgbG9naWNhbF90b19zZWN0
b3JzKHNka3AtPmRldmljZSwgem9uZV9ibG9ja3MpLA0KCQkJICAgcS0+bGltaXRzLm1heF9zZWdt
ZW50cyA8PCAoUEFHRV9TSElGVCAtIDkpKTsNCg0KTWluZCB0YWtpbmcgY2FyZSBvZiBpdCBpbiB0
aGUgbmV4dCByb3VuZCBhcyB3ZWxsPw0KDQpUaGFua3MsDQoJSm9oYW5uZXMNCg==
