Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F1D61609F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 11:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbiKBKLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 06:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiKBKLO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 06:11:14 -0400
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08AE222BC4
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 03:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667383873; x=1698919873;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=RJOXhonDYLmNeHyjif1fis24qXzkHqIL1mramgHfU8U=;
  b=fuPF/Utci8g3MK+jFhVdAWNF9y1G8cDK4rj3ThL9M1vUUUEkF1D2GhZ4
   puYiCDoo/7sQA85ZtjveThUV5wfwKeDJEv0EiJaeT05L/tbLGliek/jKW
   7c3aIz1K4VYlF5JG3h+bFlykW2OSTtpn9myZtx3i21oEWfVdiGZNn0srR
   bGpmDho28I8xWgTRAd4RYHyONKI7XgbD+zyIr33+ROwJh8aILWFwNRkk0
   VZ4pBxOz6r55yX/i49tdxhI5Mez9Zx51UREbiCfYrBiZk9YvpD5c6Tr62
   ULBtcbQYs/jnVFWQMLZRuyNmZk7op+vz7awcWTqH9iFFn2rE06d/4uwC7
   g==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="215646503"
Received: from mail-dm6nam04lp2046.outbound.protection.outlook.com (HELO NAM04-DM6-obe.outbound.protection.outlook.com) ([104.47.73.46])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 18:11:12 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zyv2ye60kBuRWqFaXpPC5cVklgP87sL25MPn/OWteE/O3QgnMjbyIIxn95w8191mfjC788FjGYnWxAl5ySRHQH2frSsgJIwefzLSgBhJHa6BM3RGQQZR+EP5STq/USu6tPQ9q9656uv0gY/UAVTyUCUnBeqoM67c0CkyRSK9trIw3oHA12n9K8DbW5Co/IxRhYNZIPx7suAWTHRx47cmCzf9xNJt93R3cZkEH+Atnj6HjHasZxUrY9zJiHu1pVA+f/s0E5/4IuluJ5SsgG+4JsM74SAB/N/shpCtqGYkIXZK2KDWoYi1mkvUlE0bkkIHFt/EFlGhDp+uYtBv//IXRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RJOXhonDYLmNeHyjif1fis24qXzkHqIL1mramgHfU8U=;
 b=lYUIqdUcgfpl5jm5V0ebSXwVJW9YwpM/ktu0PyyrCVbFaOQaBG8b79J/ZmY43KEeYaVilHUl7ZLCIPAUtsOVWbgkxlxWn6lmjvsHSc/FmTXZJDF/CywgtRXglDXGCMWjczFNLjwBizx5WdoQFQT0FXj5WEMcOgKsJSm7NGX+1DXtbZB44xTykYjPJxcYpVBULH1CrYiLK+j6UM36G+aLYKrZ6JX0HmhbfMBDbysWSmI0Mww4aYcu+Sfb7Kc13m03H3RTnA0EdM3VCeEk5u/v6FS6hv6SXvDTfcfOCy48thydFw+/UXy0NjDd9tX1s7ji3oC0sM7ZCZsrvZAY40oUsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RJOXhonDYLmNeHyjif1fis24qXzkHqIL1mramgHfU8U=;
 b=jd3gQy1JOD8Uy2GY6G/Ye2N1Vb8El94uLI0z/8hJZKD49H3Z89IQ7MxhTh4EGHQRtR4AM63K8Z/C/eMbDj8kqfTFsKERkTtroKdC80i5/P9ZMc7YQbVgNUZr9Mz0gH7gMGZ6Www7znHL/ZR7hct4DyP+W0O4rkysyDGdMq559zI=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB3799.namprd04.prod.outlook.com (2603:10b6:a02:b9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Wed, 2 Nov
 2022 10:11:10 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.022; Wed, 2 Nov 2022
 10:11:10 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zonefs: fix zone report size in __zonefs_io_error()
Thread-Topic: [PATCH 1/2] zonefs: fix zone report size in __zonefs_io_error()
Thread-Index: AQHY7NTqjMvk9blmSU+DEr/P9bSgwa4rYVOAgAAEXICAAAeDAA==
Date:   Wed, 2 Nov 2022 10:11:10 +0000
Message-ID: <f3102776-29ee-bb44-c02c-534a25d19743@wdc.com>
References: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
 <20221031030007.468313-2-damien.lemoal@opensource.wdc.com>
 <959eb68a-3c74-3b57-dd81-8b46dfa341d9@wdc.com>
 <af8953db-cdb2-507c-1c54-88593fae4b74@opensource.wdc.com>
In-Reply-To: <af8953db-cdb2-507c-1c54-88593fae4b74@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BYAPR04MB3799:EE_
x-ms-office365-filtering-correlation-id: fc52ddeb-fb3b-4089-00e0-08dabcba90b8
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lVnsqqqTyVhMn1kTaAseM0CgLVhFUfZBY4/rfHeciiLwgTMVhoBf7f3WxXcKCj22OdLdGNyH8EeaHvHY5vxlDkkOVvxCNWtjDQyAM/dO68ig3jrStLVLjVHmObs0vDYFUdqlLxCzDs6xKqmUKHQvz43EtTBqur/bphCpSxN0vgx2Prw8+HG1pw9+6lcGYYfk8da0VUhrBDg5YoFxPMvQyqdHN5wxEm/7ayU5Lg1oOAFR6zCyS6iaJeakTDPtmoPYDBzeddJE2O1mCSm3FYpCpLoTh+YerMPR5cJu1WmeEEEMaA94AxewLUKqueOH9P4OQFWhTPfqH0XOIHFLYCIahMFGkvYshei57tz2dGsEYo/iH40+R/4oAmrgCeabAdedbcBDEyTbFLJA6zg0jUnvjSlPd7KbFNNNggvi1gBPVRshmF6HuE9bUX0agIykzJUSW2tWRcEEy/v3RwZVpgfR/6RqLdgCIr3kcYtduinn6mkMS5fqnXC67JkNkf3pd8QBESp75fHqx24VaMezBktex1WcYYgVUsZgrM8cHhp96F+p5UwdTX6s4C9M4SIFjldYAW8KrnTw2qor/8DEZGjWRvEaGfnQtcapTUIdSbSn/a0YNZGRrhIDSZtFlieWHhcNViH7f4F8mhDC5rql4OdHT3/DMSbOBMYYolqIWMDmLsPJ44rAMwep0w5d4eX0rihl+71/5BXGD/gHGolPPJq0dB6JhVRQVJe5+VxMmf52pWiPaWS4TMBLXT8gKbl74F6DG4i8YpfwGQnZ83DR6Br+JO9eMUzdhEH3Q9TK8U7TbeFzGt3WO1s3nKon6tj30x0y55bonstAcdLJbWTjMlz8Nw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(136003)(396003)(376002)(346002)(451199015)(64756008)(31686004)(110136005)(8936002)(31696002)(186003)(82960400001)(5660300002)(83380400001)(66446008)(2906002)(36756003)(91956017)(38070700005)(38100700002)(316002)(122000001)(6512007)(86362001)(53546011)(2616005)(478600001)(41300700001)(71200400001)(66556008)(66476007)(76116006)(66946007)(8676002)(6506007)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NUFIR0FEZzdmeWJKZlVuOUFURDJVL1FUenlWZFlnMTVlblVXT003dm9oelF0?=
 =?utf-8?B?VXZVbSs4ZjIrOG96MW4zc21aNWd3bHZqNFFyRzRTdWI5aVcvVWhZYUFxRGZH?=
 =?utf-8?B?MURhNVhQNDJoRFR3YzJFMnRXTjQyZXFBRVBoOGkyVGVlKzNCSHF4dzNhczhh?=
 =?utf-8?B?b3dvRi9xSXptOUZzVHYwSlNtWWc3VnhITndvY05TSDZZSUp6UUh0S0pkYm9L?=
 =?utf-8?B?dEg4REVueVo5QkJ0OTNtSFVzTjBXZFRrL1dySVh2L0F3dGV3SHlnMExpZHZD?=
 =?utf-8?B?TDNidCt1NTlMQi9PeUhnaHNDdTczWUs1MStvbTBjYVdtNEFQWFZFV2NSb0JV?=
 =?utf-8?B?VjdpbGtZd2RZbHFKbEhDamhLRTY4eHVyZnVDbk9NbEgwRXFyWkgwOVVHU1Nh?=
 =?utf-8?B?dHZvYm1yYXZFQ0Q4SVBhdFVpMi82Q09BR0tyZTRPQWkzK2c2Rit6ZFM3eXB3?=
 =?utf-8?B?NVhtUVFUeUVkbFhISmNQMzZldlFCbUVWVmg5aVYyUExUQWxwcldRb0pDUWhB?=
 =?utf-8?B?RUc1ZnFWZ0RTQlA2QzJNT0luTXQrMEdwUkxQZGliVStPZjR4SzNBUTFXNDFB?=
 =?utf-8?B?WXdzQjN3L2UxS1hTK0p4UVd1MUcxOEpKTGRlWlZINnFrYzRLbzZ5Tk1EeHNu?=
 =?utf-8?B?SXphN21XNFhOOWszVW9hNHRZd2RJOEM2WlVsaXpjS2IwUGYwTC9sRm5sZ3ZL?=
 =?utf-8?B?ejhaZFVYV09mMnAwaDNDblJlYTJlTnpDd0RxTldvV0tOY3BubUthV1lUMDZG?=
 =?utf-8?B?eHF5ZGdOU1U2ak9lVWJLWkZkenVSZVpBWkJzVHhiRVhyV3lkQ3NNZVNudHls?=
 =?utf-8?B?V0hVVEZMWkJsMmhqRkZYSFYrYUgyRlhXWG8xbHBYelpnZFNwMSsyY3BUNHd1?=
 =?utf-8?B?UDJRWHR1Qk1meHFzM2p5NFROQUFlUGdvcVo0emlDd0tzV3RycDBZNFRiOFBS?=
 =?utf-8?B?QWUwYzNYTnlDZCtmQUxLQ2cxSit4STAvVVVrWTFXSXVNZFk1QlNIUkxCbVRO?=
 =?utf-8?B?VmM2aDRNemV5aEgwNVphUmZEd283SUUxVzdSU01tZFBJbllTNFZLSTZKcDVM?=
 =?utf-8?B?Ny8wZzJiUStyd21WZzhYNStNSWZHUFUzS1FYQjEvL2pXNS81SUFnZ1NJWFhz?=
 =?utf-8?B?Y1NHdlFIU0dsS05mN25XVi9rK3VDMkwwMElWTGt3UlpxcCswa05xM3h6cXF3?=
 =?utf-8?B?U1VnMGxXeDlMaDRCU0cyMTl1ZkpmYTAzOVpVbTZzMWtSWEF0djI2WHdnVU5O?=
 =?utf-8?B?R3pSVTYxVHdLcmozMVkrdjhlYWdpVmFZZ2Z6NHBhYkhBc2xVZkM2NlllWDhE?=
 =?utf-8?B?OHBmQVU5S0hSanFPZU9GYnZBc3lOVEQxZXFIazNORmwxQ0RBQ1h2aUZzRGc0?=
 =?utf-8?B?Z1hJNFM2R2pLckJHTWtNRmNWR2pyQmpybEVkMGlRRHBmNnNlYUhqNW9USFFm?=
 =?utf-8?B?eTh2UU1HYkN1cjhHYm9ZYzRqNUFpOXZWeGk4a29McWp0Snp5dWplOGtLa29H?=
 =?utf-8?B?SE1DVXVHdUx6Q2cxR2grUFNFL1JBYTRrM1VNSWtlWFI5NHBjRlBoUndBSmxX?=
 =?utf-8?B?MDFqVG02K2NoNkR4d0JuZ0lSKzFTMUUwR2gwaEhvRjQ0amZSZlNjeUdaNzhl?=
 =?utf-8?B?bW1RbHFMejUzYlpwaGJDbnRkYlNuWWhnUU9tcGJBa2VCNE9qNWg0Z25PWTZL?=
 =?utf-8?B?VWdYc2xwd1dkZ3NWQWRwd1ZDSnp0dkltdm9UQmJmRmtnT05mWjh2SGZFZG1m?=
 =?utf-8?B?c0Evc1l3VVozajAvQUdTME1wcGtzMmtDZUd0c0M0bFlYb01VUlQ1QkR1aEc4?=
 =?utf-8?B?bnE3Vi9WQ2RWSWhKa1B3blEzbjA5aFlBZ21Gck1sbTgzRjUvampsMW9XbmZv?=
 =?utf-8?B?MFFFRFF2Rjl3UTg2SXIvNWw1VkJGRWRZRTZZK2lKbm9NY2F6QWlXenhmRXNW?=
 =?utf-8?B?cXVLa3p4TUE4T1lTekcvdFlVdGMrM3Q3Z3kzZGYzUUJOZGtJNFViakRtZllL?=
 =?utf-8?B?eHFSeUx6NzVUTEFUK1JRNzl3L3k3bzNGdHdtdk51c0wzY00xUTAyZ1gzRjFj?=
 =?utf-8?B?L1NPTkhDQUNqNlVEVnFxblp2WHdTdXV3TUxOUEhXa1JLRnhQZ2F6eTRWZXp2?=
 =?utf-8?B?czg1UWFta3dzdkw4NFZjMzI0TXY4MDAxZTRhYzV0YWpYS3ROZEJqMHMrL2th?=
 =?utf-8?B?eG0yRkx5ajdkQTJNMGFCc0FuUVdvaVd6WGpDSzFRSDJCVFMwcXV2NTdiYTN5?=
 =?utf-8?Q?tyzJwdXRwxbTg68/yAPBIaj+y4xvumgi//hqXdGM1M=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CC625D28D9134D4C9997C06441E31813@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc52ddeb-fb3b-4089-00e0-08dabcba90b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 10:11:10.3949
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ZhnLaMRG1XaOsje/c5RE/eWZu/lz3utYzB8ye6vo9SqDT2jAfXjdOiEjrYsDFDHXP1nViL8+K5oKah0356xUCqs7QHLEkkRjGnFkvZ+jwc8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3799
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMDIuMTEuMjIgMTA6NDQsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiBPbiAxMS8yLzIyIDE4
OjI4LCBKb2hhbm5lcyBUaHVtc2hpcm4gd3JvdGU6DQo+PiBPbiAzMS4xMC4yMiAwNDowMCwgRGFt
aWVuIExlIE1vYWwgd3JvdGU6DQo+Pj4gKwkvKg0KPj4+ICsJICogVGhlIG9ubHkgZmlsZXMgdGhh
dCBoYXZlIG1vcmUgdGhhbiBvbmUgem9uZSBhcmUgY29udmVudGlvbmFsIHpvbmUNCj4+PiArCSAq
IGZpbGVzIHdpdGggYWdncmVnYXRlZCBjb252ZW50aW9uYWwgem9uZXMsIGZvciB3aGljaCB0aGUg
aW5vZGUgem9uZQ0KPj4+ICsJICogc2l6ZSBpcyBhbHdheXMgbGFyZ2VyIHRoYW4gdGhlIGRldmlj
ZSB6b25lIHNpemUuDQo+Pj4gKwkgKi8NCj4+PiArCWlmICh6aS0+aV96b25lX3NpemUgPiBiZGV2
X3pvbmVfc2VjdG9ycyhzYi0+c19iZGV2KSkNCj4+PiArCQlucl96b25lcyA9IHppLT5pX3pvbmVf
c2l6ZSA+Pg0KPj4+ICsJCQkoc2JpLT5zX3pvbmVfc2VjdG9yc19zaGlmdCArIFNFQ1RPUl9TSElG
VCk7DQo+Pj4gKw0KPj4NCj4+IEkgd29uZGVyIGlmIHdlIHNob3VsZCBhbHNvIGhhdmUgYSBjaGVj
ay9hc3NlcnRpb24gbGlrZSB0aGlzIHNvbWV3aGVyZTogDQo+PiBXQVJOX09OX09OQ0UoemktPmlf
em9uZV9zaXplID4gYmRldl96b25lX3NlY3RvcnMoc2ItPnNiZGV2KSAmJiANCj4+IAkhc2JpLT5z
X2ZlYXR1cmVzICYgWk9ORUZTX0ZfQUdHUkNOVikNCj4gDQo+IFdlbGwsIHRoaXMgaXMgc2V0IHdo
ZW4gdGhlIGlub2RlIGlzIGNyZWF0ZWQgb24gbW91bnQuIFNvIHdlIGNvdWxkIGFkZCB0aGUNCj4g
Y2hlY2sgdGhlcmUsIGJ1dCBJIGRvIG5vdCByZWFsbHkgc2VlIHRoZSBwb2ludCBzaW5jZSB3ZSB3
b3VsZCBiZSBjaGVja2luZw0KPiBleGFjdGx5IHdoYXQgd2UgYXJlIGRvaW5nLiBTbyB0aGUgb25s
eSBjaGFuY2Ugd2FybiBldmVyIHNob3dpbmcgd291bGQgYmUNCj4gbWVtb3J5IGNvcnJ1cHRpb24s
IGJ1dCB0aGVuIHdlJ2xsIGxpa2VseSBoYXZlIGJpZ2dlciBwcm9ibGVtcyBhbnl3YXkuIE5vID8N
Cg0KU29tZXRoaW5nIGxpa2UgdGhpczoNCg0KRnJvbSBmOTBhY2YxY2EzZjg0ZDM3YTNiZGI1NzBh
YmY4OWUxODY2OTdjMGQ0IE1vbiBTZXAgMTcgMDA6MDA6MDAgMjAwMQ0KTWVzc2FnZS1JZDogPGY5
MGFjZjFjYTNmODRkMzdhM2JkYjU3MGFiZjg5ZTE4NjY5N2MwZDQuMTY2NzM4Mzg0Mi5naXQuam9o
YW5uZXMudGh1bXNoaXJuQHdkYy5jb20+DQpGcm9tOiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFu
bmVzLnRodW1zaGlybkB3ZGMuY29tPg0KRGF0ZTogV2VkLCAyIE5vdiAyMDIyIDAyOjU3OjM1IC0w
NzAwDQpTdWJqZWN0OiBbUEFUQ0hdIHpvbmVmczogYWRkIHNhbml0eSBjaGVjayBmb3IgYWdncmVn
YXRlZCBjb252ZW50aW9uYWwgem9uZXMNCg0KV2hlbiBpbml0aWFsaXppbmcgYSBmaWxlIGlub2Rl
LCBjaGVjayBpZiB0aGUgem9uZSdzIHNpemUgaWYgYmlnZ2VyIHRoYW4NCnRoZSBudW1iZXIgb2Yg
ZGV2aWNlIHpvbmUgc2VjdG9ycy4gVGhpcyBjYW4gb25seSBiZSB0aGUgY2FzZSBpZiB3ZSBtb3Vu
dA0KdGhlIGZpbGVzeXN0ZW0gd2l0aCB0aGUgLW9hZ2dyX2NudiBtb3VudCBvcHRpb24uDQoNCkVt
aXQgYSB3YXJuaW5nIGlmIHRoaXMgY2FzZSBoYXBwZW5zIGFuZCB3ZSBkbyBub3QgaGF2ZSB0aGUg
bW91bnQgb3B0aW9uDQpzZXQuIEFsc28gaWYgdGhlIC1vZXJyb3I9cmVhZC1vbmx5IG1vdW50IG9w
dGlvbiBpcyBzZXQsIG1hcmsgdGhlDQpmaWxlc3lzdGVtIGFzIHJlYWQtb25seS4NCg0KU2lnbmVk
LW9mZi1ieTogSm9oYW5uZXMgVGh1bXNoaXJuIDxqb2hhbm5lcy50aHVtc2hpcm5Ad2RjLmNvbT4N
Ci0tLQ0KIGZzL3pvbmVmcy9zdXBlci5jIHwgOSArKysrKysrKysNCiAxIGZpbGUgY2hhbmdlZCwg
OSBpbnNlcnRpb25zKCspDQoNCmRpZmYgLS1naXQgYS9mcy96b25lZnMvc3VwZXIuYyBiL2ZzL3pv
bmVmcy9zdXBlci5jDQppbmRleCA4NjBmMGIxMDMyYzYuLjdjMGI3NzZhN2JjNCAxMDA2NDQNCi0t
LSBhL2ZzL3pvbmVmcy9zdXBlci5jDQorKysgYi9mcy96b25lZnMvc3VwZXIuYw0KQEAgLTE0MDcs
NiArMTQwNywxNSBAQCBzdGF0aWMgaW50IHpvbmVmc19pbml0X2ZpbGVfaW5vZGUoc3RydWN0IGlu
b2RlICppbm9kZSwgc3RydWN0IGJsa196b25lICp6b25lLA0KICAgICAgICB6aS0+aV96dHlwZSA9
IHR5cGU7DQogICAgICAgIHppLT5pX3pzZWN0b3IgPSB6b25lLT5zdGFydDsNCiAgICAgICAgemkt
Pmlfem9uZV9zaXplID0gem9uZS0+bGVuIDw8IFNFQ1RPUl9TSElGVDsNCisgICAgICAgaWYgKFdB
Uk5fT04oemktPmlfem9uZV9zaXplID4gYmRldl96b25lX3NlY3RvcnMoc2ItPnNfYmRldikgJiYN
CisgICAgICAgICAgICAgICAgICAgIXNiaS0+c19mZWF0dXJlcyAmIFpPTkVGU19GX0FHR1JDTlYp
KSB7DQorICAgICAgICAgICAgICAgaWYgKChzYmktPnNfbW91bnRfb3B0cyAmIFpPTkVGU19NTlRP
UFRfRVJST1JTX1JPKSAmJg0KKyAgICAgICAgICAgICAgICAgICAhc2JfcmRvbmx5KHNiKSkgew0K
KyAgICAgICAgICAgICAgICAgICAgICAgem9uZWZzX3dhcm4oc2IsICJyZW1vdW50aW5nIGZpbGVz
eXN0ZW0gcmVhZC1vbmx5XG4iKTsNCisgICAgICAgICAgICAgICAgICAgICAgIHNiLT5zX2ZsYWdz
IHw9IFNCX1JET05MWTsNCisgICAgICAgICAgICAgICB9DQorICAgICAgICAgICAgICAgcmV0dXJu
IC1FSU5WQUw7DQorICAgICAgIH0NCiANCiAgICAgICAgemktPmlfbWF4X3NpemUgPSBtaW5fdChs
b2ZmX3QsIE1BWF9MRlNfRklMRVNJWkUsDQogICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
em9uZS0+Y2FwYWNpdHkgPDwgU0VDVE9SX1NISUZUKTsNCi0tIA0KMi4zNy4zDQoNCg0K
