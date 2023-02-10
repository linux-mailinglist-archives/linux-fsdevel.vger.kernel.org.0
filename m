Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76206691E6D
	for <lists+linux-fsdevel@lfdr.de>; Fri, 10 Feb 2023 12:37:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231710AbjBJLhU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 10 Feb 2023 06:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbjBJLhS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 10 Feb 2023 06:37:18 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE8E06E98F;
        Fri, 10 Feb 2023 03:37:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1676029037; x=1707565037;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=R32fHpcmjqLJEESIwanhiFcFuZkKFBvmFpvDC4tYjhqbWn+3II+QOb6H
   SRqF113D/2+9p8eVLHsPyf9gs77uAEb7+ZUxAPmybhUInCzNFpSCyY031
   XE/6BAJ0DkE/LgcCkD7U8T3vWqGwxMNT8zLtQeb8x2wi3dIut7n2e1YZQ
   wu/ssbM+k0vYkxJOcRZcPx7TKU2C/aZPCZAh3U+GeS04nCE2/KHgdOI5Z
   uXEJix+ejsEegsN3QuytMqDFFl6v68XcCA4wUlGZTDdXREwbuAgiXQGt7
   I2EM0F+V4A2HYaS/TqEkHLYFwmSakjMoO1GqDXwcBDYzxQ3kxDK95dQQ+
   A==;
X-IronPort-AV: E=Sophos;i="5.97,286,1669046400"; 
   d="scan'208";a="334961880"
Received: from mail-mw2nam12lp2041.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.41])
  by ob1.hgst.iphmx.com with ESMTP; 10 Feb 2023 19:37:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEwhfa/gtLQicFxkzpGPKI5ABXsU0uwL6qIYl8f69ruWD42zjOSxGyWLbSzepH6Vv/IFEYUIijS92ovRYXw7a7GrUKYD++xBJJYJ4vwRSmvNt/WUMvKzj1bKkN/UFPD9ehNN+9OZY0IuLimizU8eX0WfwI/OEMDj8z74RRfkAn+TbYtC5isAArFhYULNpfN04E6rpcF7BmKDTnEl1gWMa7xsdYcm1rOoeI+l4rTQdantV2GjqvWpXh22mUKfUBwjHMRPWqSXJFVnrUdlgks8WKlmbz9EAh5cRaojz891H3b//PpKP88W+PERYEPxvxDI0R7NOkOzgBHRFjpP8ych0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=OB8xm110dsn3tbiYjYQB8eWv1h5LOfZmAarQXKi68OPhuvjIWEprwjes9Ga/4nWTAfJ/iDkU6NKowaG6JwhGUg74PYMFCfcFpR2L0lwG4AodDQYhkbt/qsCnwhM9vFt8dW66qG73kVquC+/mUYCRtm9YEKw1ROa6a6/YPzCIfY4zi+pdrvxvObj8aigjWSuQgLiZUN0CCi1gbRFli+uCSZKErxbh7eOIMuj8slr3hmipcjVptOWHm6bdXPcaGvMTxEJOIbPhJ9CgDhTiXetyMoGIVuXwxPj3pKNsCoXUVT6ALApLoimZMl4InI4qZJIYVWtjHbP65fsMTlP24lRn2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=g0fHaaZmLWoqvWaiGtPWPvb6mHenjFEH3CtUU1uwFMKunVovShGwxl1TXBu0B0dEaHXTv6h4qPk5HR3UK9aXGUjbXfY71s++LazJ5up6IxRe7MSEr1kJwlPuvyiIALQvfjKm0qa1Tz4cgh2bWL2kbmUIWj37KcNnJAOAlT5xu4A=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB4519.namprd04.prod.outlook.com (2603:10b6:a03:15::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19; Fri, 10 Feb
 2023 11:37:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::8ed8:3450:1525:c60a%8]) with mapi id 15.20.6086.019; Fri, 10 Feb 2023
 11:37:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     =?utf-8?B?VGhvbWFzIFdlacOfc2NodWg=?= <linux@weissschuh.net>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Johannes Thumshirn <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: make kobj_type structure constant
Thread-Topic: [PATCH] zonefs: make kobj_type structure constant
Thread-Index: AQHZPUQEvevXcVWvCkS1IdaUFpU/Lw==
Date:   Fri, 10 Feb 2023 11:37:13 +0000
Message-ID: <1cb1bb13-a54b-d19b-b472-99e24650ff66@wdc.com>
References: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
In-Reply-To: <20230210-kobj_type-zonefs-v1-1-9a9c5b40e037@weissschuh.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB4519:EE_
x-ms-office365-filtering-correlation-id: ea5c4d03-6e48-46a7-568f-08db0b5b2785
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5gREACcNS3KySngdX4C70Z3a4Hx5F0P9gnw8EsXAwTLBUH4Q68HZJBHJi2CIg6yxRFyaAW10L+FZui/Mbjh//MGGyF942ivuYJ2iH9bVu/xNTMWt9Kr1KdjWcyvw2/QhndY6cU8MHfFa+bQZojPpm+iDRw0plB1cmBF75UZa8mANTfQt85SbW3FLxg1zJW7utLRdzcbSxfjf2Yho5FleYfNDBj2qyKEQsqaQeTf5DI+r+TIZI5C7marNO/dK/ET9ftF7trV30Pu6uTr5AtnWMZW5aJkp8Gjc7UoKHrHjHiPqikpRJzyLBqOQ2CgOhnJfD6Aq/6R1bXd6VgDWfEJxrDeCY2mk402W5uFGaKx0AKw/jSoNQXwVPhbEfAimSpj8YZu0sBmm7RXG9iLp37cZQr1ax9u/I9yxbas8Z58F8lFdu51dvyw6AlbOIyCzyIZYeM7Vw0Yd5Khw1sBKnZ90V4Wu5unlDRJu5IDvR16vK0cxHMQGEwW67eaNJ21nJ2z5eTyT0xC9GYqgQVMzeHMUzs0mAWmRc+W+2Va/IMfQ02/ArOchkfPpu0mYPQDf6Bjmv516PWFaPrXNsFLac1ABIggC7DRWcJNnAotTTKLKgPba2HQ0rx6P4uzLIIbSAKG6eBMk2Ba9Y/Z4ZCkxpV/1aCOEZ7oxYyrtMLFMJNxcwF3Nx/nhYb38dRxSaQFkCBHtZ5iSxZS0OuQZDEEh1m4KMGYeSx1DYoRj4pE91rrAHEza27P85exAfVcEN5mRhuS7ezYPIFQyyH/cD7KfxGSvKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(39860400002)(346002)(366004)(376002)(396003)(136003)(451199018)(6486002)(6506007)(2616005)(31686004)(5660300002)(558084003)(31696002)(478600001)(38070700005)(82960400001)(6512007)(4270600006)(71200400001)(86362001)(186003)(19618925003)(38100700002)(66476007)(64756008)(66556008)(8676002)(66446008)(54906003)(36756003)(110136005)(122000001)(2906002)(316002)(8936002)(76116006)(4326008)(41300700001)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TVhBV3Q0UXF3cXV0Z3dnSEVBRk54Vm9NTWhFbUhlSEE0L0p1SlVXdHRQMXNI?=
 =?utf-8?B?UVRwMmhlMFhaWTZpK1pKayswVEhBcUVZL2psTlJVRUU0K0pVaDNEOTg1Si9L?=
 =?utf-8?B?M2tzWVhpUnQxd1gxcUJBM2p0RHQrNkRTKzJpNVJQNW45UjVscUpJaFRpeUVU?=
 =?utf-8?B?dFBKYjBLWXIyeERhM1JlbGY2ZjBFVldub2xuYnVTMEl2TVhOQm9sKzZWWDA0?=
 =?utf-8?B?UVU0NmtMeWRwT0JmZE5mSlNHVmFhVjF0VUQ1MDJjdVIzb3pBQmhvS0U0bkhS?=
 =?utf-8?B?bTVlRHNZSzlEWTBRekVFUmNZRjhvNExkakxVaGtSM3JZTmxhQXVva2Y4TWFn?=
 =?utf-8?B?VnEzNkZMbUpJdXJSeE5hODVHZjBNczgyRmtiKzJITFE3NjBxeHFMZEU5QzVK?=
 =?utf-8?B?NFRwVDZaV0x0d1VPM0k4d0NOcWpTcTlYSkJFaHc4dmFiYzFsMmQ5dmRmd3Zp?=
 =?utf-8?B?WGV5M3pVYnZ2bnFxSDhTMmJYOERjMzVDUm5SUEhDU3VIUFUvc2d3UEJrMTI1?=
 =?utf-8?B?bVRQYWRHeUtwcFhNYlRDY1piOUlTK0NReVlDZ2lKWGI0em5jZlZCYjh2bUJF?=
 =?utf-8?B?bUNMMnZiaFNvVzcyYXpNN2JJNWxOTE1MVVBLUDJ3VWEvdUhRT3B6UUhFS0o4?=
 =?utf-8?B?YWx6UGRPOWJ0UFBWM3VWN0RFVEE1eFVBR0w5aVFsYUtmK2ppVFhkei8zenhp?=
 =?utf-8?B?UUNKYzRldEVsRWQ0d0YwaXBGV3pkQUpnQTBSRWN6dmNUM251bktmcVh3MGlo?=
 =?utf-8?B?MU8zclY3N3k0N1lkQ0k1enR4bHYvNksvdTB2VWhvcE9WeERlcUV1WEFST09n?=
 =?utf-8?B?d3psYXZ0UGxuU1I0bmIybTVRK0w1Tk50SURwRUZJU1V3NlQ1ZVVZT1pmQzNH?=
 =?utf-8?B?WUVhREhGU2NCR05Zb2dnSmJiVnpNU1p5VnM5NUVkRHdXQnp5b2tGeUxrQUlY?=
 =?utf-8?B?QWo0VTdjZFRwVjkyMUlTWEs5cm1ZdE0wZEJ3YUJQajJ6RDZBcGozRlU0emhT?=
 =?utf-8?B?R2E4N0lDeStuVWZacDMwZVpjcWJkdzFzSkdKQWdHNlRadkhuMGVZRTVCb2FK?=
 =?utf-8?B?S3RqRzZrbGRxRHE5NkFyY2d2Z0ptcUtqWEl4ZTFuMUFqVEptRVk1ZStCODBE?=
 =?utf-8?B?MmxRZGpqSHl0cTlKbXd2dGN1OWRETHY2NVJqV2lOTHZjVjVUK1luNHRsRVFW?=
 =?utf-8?B?SEhRUFo0OEtRUXN2VzNsV0F2NHdPQ2RaQnV5aElpK2d5R0R2RmxLak9YWGIv?=
 =?utf-8?B?ZVE0NU5aVFRkcjJkTHNGTUlXQkFmZGdvNVNDS0QwQ21tQXdjSmhFa0I0S1Rl?=
 =?utf-8?B?a2R3bGs2dEljeFhiRXlUcElyaCtsYjFpYktQNVMzWGtxYnl3L2FoUkVPdXpB?=
 =?utf-8?B?Y2RHL3gxU01TN0p4UWphSjVCTjl0S0ltWUxsT0ErSU0wcXpnMTVMQkFzSy9P?=
 =?utf-8?B?MDZpdXVaMlQrVEpSKzBmQkVuN1F3TlNWMDJxNzYwR1hQMUlGZUVsNno2V1ZN?=
 =?utf-8?B?dTZVOXBTdWpIL0JBcUU2Z3diZTdJaXkxNGYwNE16SVpwNWkzRTd5dlpLaEEr?=
 =?utf-8?B?WXpNbml5NzZSYXMzYmV1VmE2U25vQlBxMG5kN0ZqanhqdDhsTHpLeUhEalN4?=
 =?utf-8?B?VjllTHd0WkgxbW9YT1dPa0Fnek13ZWxubW8wK0IxZWxGM29TU1M1TWVwa0t5?=
 =?utf-8?B?MmxsWXdiRmFzRzVEeE5jcXdyWGpFMjQrd2RzNE5maCszNjBiNjJ4WDNtbGlE?=
 =?utf-8?B?WllQdW5OWVRFSEFxSldyY0d0eUNrUlE1QXVDS2Q1d3BSUEc2RWdwMGdMeE41?=
 =?utf-8?B?bG9WN1NwcXMvMFAzZkxYbmNhWkhOZ20wZmtrRkFOSG1La1VDaTRLRllncEdS?=
 =?utf-8?B?US9nRjhBT2dyNm9nakM0UVMyTi9xRW00L0J5RmlOM0JLeEJZWFp4dHNQa1ZD?=
 =?utf-8?B?L1JqeDNpMko3TUNISTB2czFQMkZZYys5MUhoMjlWQ2JKYmxYS2N5SFd2WWdx?=
 =?utf-8?B?SVJ3Y3FxNVh4bEw3VnVURFlxeFZpVHlqc2g5NWQ2dVZONzFaZGwzTkpPQTg0?=
 =?utf-8?B?Vk05VFcyN0xlb0lzalc0bjlTYjZJcEovclA0c0ZJSVhubkVPdW53TnZIRXR1?=
 =?utf-8?B?Nk1aeGZEaVhZcERmWUF3SWVpMTBpVkMxaGRGcGxNSlJNWVVOS1E1TkxVaS9v?=
 =?utf-8?B?bURjZE9pYlJxSGtGbk1TcDgycEJRMGdXTmVHZFhMRUFIVmF4cEQraExWdlFj?=
 =?utf-8?Q?1H3g8xO3NGTm7rABQW7YVyh9X8A76go/K5+Iqy0YaI=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <BF4A1CF28DF08742AE3A03A7018808FC@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: CAZcF79degNSD3WDl6F35cMt/DCtN0l2e3vFZSKCT+ZP5Jl0Rnj1aUUms1aVgfUAia1ZaOWSH8HPsEF0nj3Ry2sGd9ot0nwFtIT/06yXg6xqlfE9uAd4V2+0ughZYqOkkyFiWXV0HXhWqEuawCQfMBrBeCzAAXYqMjM7sUU7K9sp+p+yErgUowYLg0RAXG/4PAtnvMz2tDfFOiqtdtnJpBNPVTOi15DvRzxDF2TJU9+rEb0L7Pl60MZ81MWgvG/3YYG/xhOBHZKF1HQnh+XJrvKqEr8iMRSo6KCEHQhJOs/FbhZ+XWyN+OhkQsM2wRD1uZ5CSqU4YeOhYGlrW6PJwdDvTdQzpGpPRLHoNU6tbWOAyOO3PYjLqk9YiwY0t0S/i6AHaPGugfR+uN0gqBcSyJTVY43Ki/04Aqi4o+5zf+8tZGIJ0XcbnZkF3bLgy0bc+Z3iCxwqySKZUO1hNZbSmzYO90VwdbVL0iLbL4b++Hv06XU0RZmAKBykzsA0AILsqeTFXstl0Lkz5oRMrnP8XgUlad+RC6Odpggj/ZBzXse5acb1u9acB6YJjrM4Al/NLUji0MN+VryQupk5wl+Mj3ayvhB1Cqyg/CZmAYVJioyUgI1eDjj+KhLe4iQzTrSuc4K/kemhElhUUGmLt7L/EoZDEc/4KU7GE3rxBZAuzKV7OjNjwAC5QHavZuCfYfslNCwh4FYKJpBq6ARdHTUISLEjKiAN0QHiJVyqPG4RJcQupaGKV1Akm83Vt9fVIvzks9X5tITFi770lMlsnVRg2apoZ48auIn1lqIXyf+geh30NhJ70iUxaUDkki/LpTbnjLosDneVBnK/MU8ys/mjoSAboqSBXG5x/e2p6dwU1bc=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ea5c4d03-6e48-46a7-568f-08db0b5b2785
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2023 11:37:13.5723
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +0iCcZN612h7MKsh0Txsm5Q/ovPOnKRslwDWhxxnWzKIUNNVrPUiYJt7v/sEHRYvQX36DRsyvvwD4jh4I18+B90+R++BRV0Pps0VE8Vn54w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4519
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
