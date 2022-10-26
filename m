Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC81860DC33
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 Oct 2022 09:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbiJZHgu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Oct 2022 03:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231926AbiJZHgt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Oct 2022 03:36:49 -0400
Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C620173C3E;
        Wed, 26 Oct 2022 00:36:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1666769808; x=1698305808;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=USbfS7t+t+hmFUc8P2VeINT7JgxTo4ltO/ZR2Dq1daA=;
  b=QLSz9G3LdUV77lom0USr1ICuCHrNOibJXppZFUoJhwshnaNWQ6UsCu5n
   l0NmMM8UzCI6bFeZyKRYbCm2k7W+3pis7vK/Yb3yhJKhC1WZBlPnRX45F
   luZ1PUPHyXo8Xb0Zt/zaw53P76GZrgpmLxD9SGRknDbMnldxNKcbmjRbB
   vo+9usyP2iZDF3T4Qh+1eNUxdMWztKcwXuUNToqTX+a6Le9DFW4oWxcfC
   ZZkMcok4KdRtgtfAZOC5HPkmGoXLgmOMAgzmThmlzwDgcVQrIxqELfb2/
   nMiT2x1NVNqn88+bOod+tcJaPq0GDJ134U0HHQLu86vF6ziEDRm78P5Py
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,214,1661788800"; 
   d="scan'208";a="219925989"
Received: from mail-mw2nam10lp2105.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.105])
  by ob1.hgst.iphmx.com with ESMTP; 26 Oct 2022 15:36:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UTIruOBwKy/YJNHpnehorC4epW0J4MEsn8Dnx8e2QmnnQN7LviBjn3w3O2gDLjTKj3exn/2bgSWvupIm4iUpFkMr2vpooWrnagNDnHIYgJXHyIeiTaYFSCswBNJuGBxI8W0ZE760b8XsGj3Kdj+6o4cKgGLm1WnbGbBi/oiG0gVBOCHcgIL7P5AMPA00EQn88pbqKfKth1xQhD1yPTmDNBunQ7zofMRekGBviPMu/PoQNv6ARlQDRtKLtWaMhMjVQmAq4pEXslvR98eYo8aLglimhYRkmjUGIYo4y9VxAs7lE7iKH7MXJji+d77ZdvA8C3PZYAluXsS+xeUa7D72jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USbfS7t+t+hmFUc8P2VeINT7JgxTo4ltO/ZR2Dq1daA=;
 b=UVwErd6eG133AQHqLEa2myMh/AoEhBuvjGcomNEpWTfvZnlUIGNNEuQd6Og1qja4SOixI/BG6YUhzvNp5nHKywegD9gKJ94Z/LXJpM4KtR6kCd9K7MfzSiapoQ5x+hKIGNoplFnPG34eE7ggQSS+XGdiqFMEylvjv2vMdSpFHQVXCS152FyfvQqehzCqcnwt1aRazhVDrvbN4qBvnXoT20iMNVhiVoORV6EM52Fh/1UwpjXOfjDWpiVYoCZFDp4wmENCqSJ73l+dDNJQD5DX1KuPWg/X2eTBc6bV66u2zq4+9auc2PJSEk8cMsI2GMXerhtJ42cvYQWleKDJDXJumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USbfS7t+t+hmFUc8P2VeINT7JgxTo4ltO/ZR2Dq1daA=;
 b=puq0AhsaDrNfBVp8ynFKZq4FOmXBTdwYZ28oigRVQZsRWPBjk9n3sY/r4df4l2ra1454DXXszH7p8QMPK+b9Eobcn9LJ891WJD9SbmtHF8WDzLmDFpGh1NSCL8xJhYLAZsxz3LHy3DRxzECJ/tyWwZTadT8SjUA0dyjI2mgKpZE=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5351.namprd04.prod.outlook.com (2603:10b6:a03:cc::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5746.23; Wed, 26 Oct
 2022 07:36:45 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5723.041; Wed, 26 Oct 2022
 07:36:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>, Chris Mason <clm@meta.com>,
        "rostedt@goodmis.org" <rostedt@goodmis.org>
CC:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: consolidate btrfs checksumming, repair and bio splitting
Thread-Topic: consolidate btrfs checksumming, repair and bio splitting
Thread-Index: AQHYvdZkzfjbXHDoM0mHBIw1hzgYgK4dhQkAgABtcoCAAAtsAIAAHYQAgAKETAA=
Date:   Wed, 26 Oct 2022 07:36:45 +0000
Message-ID: <9f443843-4145-155b-2fd0-50613a9f7913@wdc.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <347dc0b3-0388-54ee-6dcb-0c1d0ca08d05@wdc.com>
 <20221024144411.GA25172@lst.de>
 <773539e2-b5f1-8386-aa2a-96086f198bf8@meta.com>
 <20221024171042.GF5824@suse.cz>
In-Reply-To: <20221024171042.GF5824@suse.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB5351:EE_
x-ms-office365-filtering-correlation-id: 339ea16f-852d-480a-6c91-08dab724d58f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Db/ZRFgJOblW9KXBqJn+zA0NBSaMatRqx8Pp9GgM41tq4gZkCP8vLhoqOs72n8YnlrA/3r2p3xEqsaLPUR9GCS/5qBVnLV+yS+jrXWZuD6/4ANlBy2pgXTR1rMKiQzVloX9Om/E+QNK+eGsp4yq2mxl68Z24PJYYXXHRPBHzMZFuIzNDum+mBQVAU8N/GcLCJncN8HwNkopXmxEXoWz0IaTilx72F9N4K+OZgDsmx//s4MWMmF6q2+Ybw84uy81KkVHDpdktzScbpAeCah9zGlcxYne/Q9mLGcCXdlhqCQ6Bf+aV6bazf3SToSsyzMiGg1D5LT/Qj1QcNAA/qMHC6dLnKXS6IqrqSXEAyK7cHQXmaXVIFrDbWJJ7cLVPRC7yFqOB4AwOSAAmbwMKxNr3+3SgPKhqdAkF+hYqram1cdVIXGQJffTtuR6VqTbmsh2tME8zgC3wOnPFAJerX2m1QROq4sjCK1DYwPD0NzVNYDXxhuA0vxr5Ne3Z7FVPijMAffLr7S2NIYkvnN3R6Z3v2q+ifrOe+HYjshhrPgalXxgYllToeqIyCvF7ZbvJadIQOORKX5MNCptFO+LgpaeNAGcK3XR4lp2DqccM+w8seVtmSuVud/4gkOa75SeDXrOwfiQA0XKbqGKPqGPPhhYMv4ebvCbKO4Yo5xyr9T4hC1uiuY+Y/aK04pviOp47I0+sj3/yYXLc6GfnxyomT8R1QI25f3rMP0tWjqJq9yns890P2a4uGv8cl+RXV2rqONFCwwKf2N8hbtsbLXz0w6kRU52uDwt3qdTBKJtxZjDU2Ecd6pAUIFwIuzd1rhW7W/cc/04h6Oh5dAS96aba8qutJUkOnR7if9eOSq9iGeT8pBw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(84040400005)(451199015)(36756003)(31686004)(122000001)(38070700005)(41300700001)(38100700002)(82960400001)(64756008)(83380400001)(2616005)(186003)(66556008)(6506007)(53546011)(2906002)(86362001)(6512007)(478600001)(31696002)(5660300002)(7416002)(8676002)(966005)(71200400001)(6486002)(4326008)(110136005)(54906003)(316002)(8936002)(66446008)(91956017)(66476007)(76116006)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?djhhRDFJZldtV2RMR3dzZE10ckx1WjcvRnk3eUJhaTBrdEJtNWxOWHlYTlN2?=
 =?utf-8?B?V0pCQmI2dEVkUlpHNjJKcXpBT3ovZU53RmZha01HdEc5S2J4Z0hWV1RuWXNt?=
 =?utf-8?B?WEhXZUZpT3h3OEZiY1ZMbk14TmJKNTdoQUZCSVQxTUNHQnhPbmZadFAwVUdx?=
 =?utf-8?B?SFNsWmY0R0FLYTFKUkhJS2E1bmI4ZVppOEVwTXRPN1RpRWNIVHEwcEtiR3Rw?=
 =?utf-8?B?cjJSQW5sOWJNemNHeXVsZG44c3lRR25zRE53QVlpZkRpQml6NHFTUWVsMGdP?=
 =?utf-8?B?Nm94MmQxanhTbVRsdS9rS2RVK1hhTjBiazFtbFl0Z1R1bDNlRUt4VjN4c2R0?=
 =?utf-8?B?MVJEM2k2UVVvVHd3S0c5L0Fsd3R2MjQ5NlFaak9RKzMzVE50eUtIaHk3Qmx6?=
 =?utf-8?B?VHJEZ1RzZkQ4Z1dmMU5pd05uQ1VENytjcFhUaDRCN1p6RVhLbVlGb1gzSVBD?=
 =?utf-8?B?RGhLdjg5KzA1OWpGSHNXM1lnQWE2d2JybGt6SEpqakZnTXBsS3NRbU9Jb29i?=
 =?utf-8?B?RFIyK25hL0ZYWVNQbHB4bHNYdDMwaWpmTXU4c21XbU10Mnh5NklQenJkcGNN?=
 =?utf-8?B?VXk1ZVRidk9PWFI2dE4yYjZZUXllU0FmNGo2amZrbnI1UmJUZUp4dDFaMW14?=
 =?utf-8?B?QlpzYnEvQWxxR2o2cUhtQmxvSGltM2xoSnU0cmwvYzVJWWhMMXZaT2NLMS83?=
 =?utf-8?B?TWRvbWdrMWNhTWFxSHdDU1VKU0hXcjR0WEZwVEpYelhCSUx1aUNnNjVuVXo2?=
 =?utf-8?B?RjREK0pZa0ZZWlJqejdjaEhweURCNlhXeExScWpSRzdUQ0NBUEtib0dYV2Nw?=
 =?utf-8?B?NzFhSkh3Q2VLQTBPRFE5ek93ZVFKVUVkUGNLY3NRVUMxdGN5bkpMdEVBUGNS?=
 =?utf-8?B?QWVSSURvbDc5YktPRnBWdTJUVG1UQWNLUHA2RktIRXBjQ2xaQkNWMWg1TE80?=
 =?utf-8?B?bFBhdEorZ01sd2lHcGYwaW81RkJSd2xDaTlSTlpWNHVLYXpGYlduVllqRUw3?=
 =?utf-8?B?RWxHVS81T281TVZsRXBPdWJDZDAzRnZORmsxL3dMU2VmVGlsL2FXN1gxUUFL?=
 =?utf-8?B?TWE3VVZ1YURQc1pqajlmYjNyL1ZFL3JmZU9xUTJWaFZlUnlRY2hVUG9POHRN?=
 =?utf-8?B?WW5rOXkyQ2lNNTh5Zk1DTUtYb2c5eHdUU1diaS9ZOW9rN2JiKzRuTGtBTFN2?=
 =?utf-8?B?WGhyY200VVZGY0t0QWM3Lytlc3labzIzZjZzRFI4L2R2R005MDBWZEw4TDcx?=
 =?utf-8?B?Yzl4TDBXUUhsN3N0NnBtNVhURjJEcGlHRW1SeERRNlI2WXdrYnhrUEZ6aFZi?=
 =?utf-8?B?TVFrQlhnZWxKQm1JWWxBV1lDZ0Z6cDF2NnRDOVhSMW5qVWtBU2k3UUFZUjNk?=
 =?utf-8?B?YzlieVZHNkM2bFp5UEpnK2JXSGNOTkdDcFY5WnJxT2Q2V1ZiM3NOUVptVFRY?=
 =?utf-8?B?VmdWRGs5OVVkZ2tTY2xJUTB2Snl4Z1FMR2M1eDdEWC9ZK3VQdksxcUFiNStW?=
 =?utf-8?B?TWJHa05TUVk1N3VDV1JiVEhGVmxSSUlSOE4vS1Q1aVluaHo3VnNpNjJXN0Zk?=
 =?utf-8?B?L0wxVUg4dWJXaTlyMy9iT280emxtTDlDMDdvcVpqKzEwajdpaU5pTkl3SDBt?=
 =?utf-8?B?WTdrVlVqRlNDMW5RZFloMXJOZUVGeStSZFpxK09DZWsrK2h6VTlIdGQwdllP?=
 =?utf-8?B?YU9Rd1V5RCttOUluLy9JdUQydzUyS2FZM2RjTEFORVluNFovcnpaL0VydFhV?=
 =?utf-8?B?SlRjaEE5WnAzekhjS2ZaK3RtRWhvQ3FDSURSa0lmWEJONFAxTk9EY21rYWxI?=
 =?utf-8?B?NVBwMDdEVmhWSlJHMmJycWlCeU9mR1V2ZGw3cjhkOUk3VFJLNS9hMC84REsz?=
 =?utf-8?B?RUVBc0Ftbk5NUzVROHp4RDZlTjh4TzZZMCtNVTNkQTd3d2d6MmlzOUxOcVZH?=
 =?utf-8?B?bmJqUy81eDhWeWl4VVhYdzI3dS85WDVvbHhiaUZ0TUM0d0U3MEJ6S014WHQ1?=
 =?utf-8?B?cHFzRnJkVFptd2hLZHlrTURrRnF0NHd0TGFUT2dSenUxeFVqTkVTa29TeVhK?=
 =?utf-8?B?NHFhNVJxcGhVZS8rM2h4MTlJbWhycjVGNDJzQ2RtTnN6UkNYR0xVTnVTZVlJ?=
 =?utf-8?B?dG5BRzl3RlU1eHluaEM2MHhrU1ZHSy9mWjd2T0xNaURncUkrTlVDSzJ0NXIz?=
 =?utf-8?B?c0QzdGt3U3pibnVLeHdHUi8vTXJhd1V5anR4RU04SWxUdmR4ZHpDY0QvUXgv?=
 =?utf-8?Q?1m3UsIwwCKrUeLoVW3SxizyWGg67XhzjfvyJPrjhKE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E0D1C6A50162A3489EC3C9681819ABF3@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 339ea16f-852d-480a-6c91-08dab724d58f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2022 07:36:45.5686
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JlBzv+tkZLrSa0tCrqTOovu8tun6cdegXNLRJCeNpcVhdFOkLEDtiOoBOQVHYU87KlaoSi1upTmW4hLydVxZoDoQ3ufmt1/YTOrVoIxA9Ys=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5351
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

WytDYyBTdGV2ZW4gXQ0KDQpTdGV2ZW4sIHlvdSdyZSBvbiB0aGUgVEFCLCBjYW4geW91IGhlbHAg
d2l0aCB0aGlzIGlzc3VlPw0KT3IgYnJpbmcgaXQgdXAgd2l0aCBvdGhlciBUQUIgbWVtYmVycz8N
Cg0KVGhhbmtzIDopDQoNCkZ1bGwgcXVvdGUgYmVsb3cgZm9yIHJlZmVyZW5jZToNCg0KT24gMjQu
MTAuMjIgMTk6MTEsIERhdmlkIFN0ZXJiYSB3cm90ZToNCj4gT24gTW9uLCBPY3QgMjQsIDIwMjIg
YXQgMTE6MjU6MDRBTSAtMDQwMCwgQ2hyaXMgTWFzb24gd3JvdGU6DQo+PiBPbiAxMC8yNC8yMiAx
MDo0NCBBTSwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6DQo+Pj4gT24gTW9uLCBPY3QgMjQsIDIw
MjIgYXQgMDg6MTI6MjlBTSArMDAwMCwgSm9oYW5uZXMgVGh1bXNoaXJuIHdyb3RlOg0KPj4+PiBE
YXZpZCwgd2hhdCdzIHlvdXIgcGxhbiB0byBwcm9ncmVzcyB3aXRoIHRoaXMgc2VyaWVzPw0KPj4+
DQo+Pj4gRllJLCBJIG9iamVjdCB0byBtZXJnaW5nIGFueSBvZiBteSBjb2RlIGludG8gYnRyZnMg
d2l0aG91dCBhIHByb3Blcg0KPj4+IGNvcHlyaWdodCBub3RpY2UsIGFuZCBJIGFsc28gbmVlZCB0
byBmaW5kIHNvbWUgdGltZSB0byByZW1vdmUgbXkNCj4+PiBwcmV2aW91cyBzaWduaWZpY2FudCBj
aGFuZ2VzIGdpdmVuIHRoYXQgdGhlIGJ0cmZzIG1haW50YWluZXINCj4+PiByZWZ1c2VzIHRvIHRh
a2UgdGhlIHByb3BlciBhbmQgbGVnYWxseSByZXF1aXJlZCBjb3B5cmlnaHQgbm90aWNlLg0KPj4+
DQo+Pj4gU28gZG9uJ3Qgd2FzdGUgYW55IG9mIHlvdXIgdGltZSBvbiB0aGlzLg0KPj4NCj4+IENo
cmlzdG9waCdzIHJlcXVlc3QgaXMgd2VsbCB3aXRoaW4gdGhlIG5vcm1zIGZvciB0aGUga2VybmVs
LCBnaXZlbiB0aGF0IA0KPj4gaGUncyBtYWtpbmcgc3Vic3RhbnRpYWwgY2hhbmdlcyB0byB0aGVz
ZSBmaWxlcy4gIEkgdGFsa2VkIHRoaXMgb3ZlciB3aXRoIA0KPj4gR3JlZ0tILCB3aG8gcG9pbnRl
ZCBtZSBhdDoNCj4+DQo+PiBodHRwczovL3d3dy5saW51eGZvdW5kYXRpb24ub3JnL2Jsb2cvYmxv
Zy9jb3B5cmlnaHQtbm90aWNlcy1pbi1vcGVuLXNvdXJjZS1zb2Z0d2FyZS1wcm9qZWN0cw0KPj4N
Cj4+IEV2ZW4gaWYgd2UnZCB0YWtlbiB1cCBzb21lIG9mIHRoZSBvdGhlciBwb2xpY2llcyBzdWdn
ZXN0ZWQgYnkgdGhpcyBkb2MsIA0KPj4gSSdkIHN0aWxsIGRlZmVyIHRvIHByZWZlcmVuY2VzIG9m
IGRldmVsb3BlcnMgd2hvIGhhdmUgbWFkZSBzaWduaWZpY2FudCANCj4+IGNoYW5nZXMuDQo+IA0K
PiBJJ3ZlIGFza2VkIGZvciByZWNvbW1lbmRhdGlvbnMgb3IgYmVzdCBwcmFjdGljZSBzaW1pbGFy
IHRvIHRoZSBTUERYDQo+IHByb2Nlc3MuIFNvbWV0aGluZyB0aGF0IFRBQiBjYW4gYWNrbm93bGVk
Z2UgYW5kIHRoYXQgaXMgcGVyaGFwcyBhbHNvDQo+IGNvbnN1bHRlZCB3aXRoIGxhd3llcnMuIEFu
ZCB1bmRlcnN0b29kIHdpdGhpbiB0aGUgbGludXggcHJvamVjdCwNCj4gbm90IGp1c3QgdGhhdCBz
b21lIGR1ZGVzIGhhdmUgYW4gYXJndW1lbnQgYmVjYXVzZSBpdCdzIGFsbCBjbGVhciBhcyBtdWQN
Cj4gYW5kIHBlb3BsZSBhcmUgdXNlZCB0byBkbyB0aGluZ3MgZGlmZmVyZW50bHkuDQo+IA0KPiBU
aGUgbGluayBmcm9tIGxpbnV4IGZvdW5kYXRpb24gYmxvZyBpcyBuaWNlIGJ1dCB1bmxlc3MgdGhp
cyBpcyBjb2RpZmllZA0KPiBpbnRvIHRoZSBwcm9jZXNzIGl0J3MganVzdCBzb21lYm9keSdzIGJs
b2cgcG9zdC4gQWxzbyB0aGVyZSdzIGEgcGFyYWdyYXBoDQo+IGFib3V0ICJXaHkgbm90IGxpc3Qg
ZXZlcnkgY29weXJpZ2h0IGhvbGRlcj8iIHRoYXQgY292ZXJzIHNldmVyYWwgcG9pbnRzDQo+IHdo
eSBJIGRvbid0IHdhbnQgdG8gZG8gdGhhdC4NCj4gDQo+IEJ1dCwgaWYgVEFCIHNheXMgc28gSSB3
aWxsIGRvLCBwZXJoYXBzIHNwZW5kaW5nIGhvdXJzIG9mIHVucHJvZHVjdGl2ZQ0KPiB0aW1lIGxv
b2tpbmcgdXAgdGhlIHdob2xlIGhpc3Rvcnkgb2YgY29udHJpYnV0b3JzIGFuZCBhZGRpbmcgeWVh
ciwgbmFtZSwNCj4gY29tcGFueSB3aGF0ZXZlciB0byBmaWxlcy4NCj4gDQoNCg==
