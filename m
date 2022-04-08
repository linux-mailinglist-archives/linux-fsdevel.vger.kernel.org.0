Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 938FD4F8CB9
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbiDHBX0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 21:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233385AbiDHBXY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 21:23:24 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 07 Apr 2022 18:21:20 PDT
Received: from esa1.fujitsucc.c3s2.iphmx.com (esa1.fujitsucc.c3s2.iphmx.com [68.232.152.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EA881546AA;
        Thu,  7 Apr 2022 18:21:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649380881; x=1680916881;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=tl2pf5DA1OllT0W0p8Nbspq5USAA06Bo2TkAWwXL1tM=;
  b=ZtjYRuJKUzRmkZ3xqJqbn1vfSIXWovzYcCuliodFH8BYkSderwAFTWD2
   511PS35zAdeR2SUq93fLfZNOWoP+07LymHFdvjV7iomRjPSVXAcXepDt+
   hlyMD17Xwa/eyW0iTn1a31mCLlmFc+E38Cr6b0nMhAsxcaz+uSuZePuoM
   n/xLFCLxpt6dtdkOf0godcADyP8X8MDXHMRh3hL2xCZnMzeTRxp535wJy
   +D4AxLWoHOUfuncM5amU6Ji8GB863RN14Ve2VCRlqE+BlHn/hXYiMWHLZ
   AOi7AeHZnEeP52RsG+m0phP/u67BpEuNVWe12Z36YuyhdJ+nbUjlDcCeZ
   w==;
X-IronPort-AV: E=McAfee;i="6400,9594,10310"; a="61703351"
X-IronPort-AV: E=Sophos;i="5.90,243,1643641200"; 
   d="scan'208";a="61703351"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 10:20:11 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a7zbF3b4GxGbBdWOjpgXlWTBqdAgrf/7z4OAIa1/c7/wAkIKNgaI/l3CCtm4zUYlEaz8NI5xs+YWWXYfBrlWiwi7c39f8CR0L7O+ZuimwbgOmeAKgYi3VKZJBzSTdTNM4Bmjzt5k5cRavsTUrZyqPYuJAuuC/0XqiMQVUfe+GUkZ99qOH6td3fINRWTjIYHoxwIBwI5UyjoK2Y+zxvR+YONcQfcwVB4xXq3Gqv/zcRyN2+BI7ce/DuruHbf6pr6lKCL6PQupvlcHv7hQ8smnLpKDw/If28RQnZYKmmoZUGiCSjf9CJiR1LJd+kpVM4JmFms0RtizAvFnoM95ubULNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl2pf5DA1OllT0W0p8Nbspq5USAA06Bo2TkAWwXL1tM=;
 b=eCzApsbouCUWOc30XAZokWePQikgHXARzfGXN+mAtRsrd7QXi1T3WCsNw3mfxVIO27VWvPvyMhov3UDAUgvsDUS76LrBxboi09zU9oO+3nZmD6NeOTKms+eyRL264GeEHQRGGwBX+s6jSXaeIJUr6xUpcF7NmS7ZTpXOk0EuqYvIauc9wew7t7QN8PI/SDkc1ELRhXEO6W+W6RXjwbTsApDLdLb2Vrl06LIt4gwuZeDAnTWtDp9mRuK8JNf3FsojhyxJ8EYCtfyQwWVQQPLIGleKOsaD4z2zFvp99lO18YnqGeNvDGKCSvXe75MQ9HhyJGNFrwRtKzXCaku/Dme4XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl2pf5DA1OllT0W0p8Nbspq5USAA06Bo2TkAWwXL1tM=;
 b=JNg+vHdtuDcipHneeAO2ZekSig+aK1mB/k7uHMpjdaea5iBMUfXZCrx9Ch1VUtGoXVY1+6KXFwIjffe++LDA+4S5nXSZ7ZyvWEzEY824bUmZI/kWX84QD/cAshk5TqNPC/B30xNqUaglljv/Abi4QtqLroerk9/azgEd90aKDuw=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OS3PR01MB6611.jpnprd01.prod.outlook.com (2603:1096:604:10b::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 01:20:08 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5123.031; Fri, 8 Apr 2022
 01:20:08 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v2 1/6] idmapped-mount: split setgid test from test-core
Thread-Topic: [PATCH v2 1/6] idmapped-mount: split setgid test from test-core
Thread-Index: AQHYSm/45Pj6IKi+8kSUuTyKGn/7sKzkaIyAgADhIYA=
Date:   Fri, 8 Apr 2022 01:20:08 +0000
Message-ID: <624F9C07.80808@fujitsu.com>
References: <1649333375-2599-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220407125509.ammsotnbrimbqjbo@wittgenstein>
In-Reply-To: <20220407125509.ammsotnbrimbqjbo@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: bd668391-e66d-4f44-1ed0-08da18fdeb9e
x-ms-traffictypediagnostic: OS3PR01MB6611:EE_
x-microsoft-antispam-prvs: <OS3PR01MB66110147A50AE5736F0D8CCBFDE99@OS3PR01MB6611.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pNFV89LAGT9AyqV1raSJizAbB+/kiRctLO3zXa3AhdBMlHIljwH6Olbq9U/3e9MtOmwqGlwA3hbODdijULM9yyZLJoWgfFuzIwvRyeAu6x4FK8bHUlufCnHeRVJP/PCyH6n+pQemLsxH44PTFO3bvNZvhe2p4ZqYWwJQ5mxkyBZIfmak3Pge4qOcXYSJrWwNrEWs3W8GGT+p9nPOjAFq1H3nscu3/F0LsYZ2+xIhMUk1++e/gUlJUY8g2HYmiMhptm/qWIfsDSnAuGYEbXXPDcWyCVQOb2N7JltOmo7Xf2JFrAyMOS0F/bDyA+xdV/d9H5bMeb8i1QlgnwXLLG4kX/1om0LsaeHKWctfkNk4lolfED65gJTiAY8Pd9nVgQR/VDRnP4oVk1A4Bu8joeEhGw6b3Ss9kFJs+vKIcvcg1NuJOczKJlzAwfzPv/mK/EuxxDRyBsYHBzUcMCQjZrree5JnN8V7BPWGL+F9e6uuOY+6bUe7TmToPjvRqckJKQqi+Y4j+wBv6QHYhrdENqirO/30ZQv6p943VkHgZU/yIn9XP+tRH3aV4HIaPFJiZ1btf1ZpM38cm55FmLCC1F9+PiUcVNspKaU3awhSNbsGw17LGv3jHUvfqVt2dy5d++G6WMvumKfEbNa9ljXaP+37aYLsSJY3nE84padX+k70SI20LoffFR4WHHrbbXk/9EvEYtp2T71Zcns6bKGRefxlBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(122000001)(33656002)(186003)(2616005)(83380400001)(26005)(82960400001)(86362001)(38070700005)(4326008)(66446008)(66476007)(66946007)(91956017)(76116006)(36756003)(54906003)(64756008)(66556008)(8676002)(6916009)(2906002)(316002)(8936002)(5660300002)(85182001)(508600001)(71200400001)(6506007)(6486002)(6512007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZzF4Vm5MR0ZRREhhWEFNRUZNNUFFeDllVEVHUWNUeXJBck9aMkFxa0luNzBN?=
 =?utf-8?B?UjVPdjJwNjBCNFd1RzJoZ21sME0rVHZKUlp5QndHaXJQbm9DRWs5b3kzZnpJ?=
 =?utf-8?B?bEdFOHIwYUIzeE0xOUoxK2h0eGdOQWFCaHZpbWNyNHRPZENPdDU3cHFQTXlD?=
 =?utf-8?B?QmFaUm55UnQ2a25rUVRQWnIxT2xpTzFNYUZCUk56WTN4K1Ftd3dIK1hNclVV?=
 =?utf-8?B?TWllaVVPQlFZZHFzWkU2SXhmNmNJZlVxWWpoM1RQM1NEOTFSV0hiL0JUZkxl?=
 =?utf-8?B?RDYxKzBTTVlzQnR5RmJpVlY2SU41bGQya2xNWHdlelAzWHFlazhFdWV2ZkN2?=
 =?utf-8?B?UlZFQ2ZUaUVvcnBpRXYvbHBpTWdjVEljMWozV2pJazVRU1VCcGR2a0Q4OXRx?=
 =?utf-8?B?eGdsemZvNFpzRlhLUkUvMDhqL2Myakg5d3Y2K0YreVNzRStOY3NuMXJLT3FS?=
 =?utf-8?B?TU9RSFBHSnd5ZUZZbnFwSm5vRG5YTnlld2x0dVZlTVE1Y2ppb0pNem9IV21x?=
 =?utf-8?B?TVNMSVlGQjZzT1ZRbHE4SEVNbWFac2ZaaUExRUhBbGZvV2h2cnlFcFBlQjVS?=
 =?utf-8?B?c1JKRlhBVmlVajl0QVF5czVrNGllUjRGMWdnKzJDN3hmbFF1MDFxOGJFMVJ3?=
 =?utf-8?B?bjdQTDR4andYK3IyWGpCc3QzUFVNQVVJS2FWa2gxV3NYMmNUd3Z5MWhOQlRF?=
 =?utf-8?B?S0ZqNjFzUjFQeWpPSkRKT25XY2ptam0wYkQ5OEZFRHBqVkt6eWtPazB4K2xX?=
 =?utf-8?B?TVFiMG9kbUEzazZtUUhoSEZDQlBsa0RjSzFPVUxSbSswNkt1TTFTR1gwLzlW?=
 =?utf-8?B?Uk5kMUlEZUZzSEV2V2Rza0Z5cjlBR0FMSzJOZDV1VytxN0FWK0pEZjd3QU5i?=
 =?utf-8?B?dFFRQVJXWTNPZWFUUE5WVkhBc2pqWU96cy9zT0F2bjJvTUQ2U3lZTmRaVzNB?=
 =?utf-8?B?UjFGRFFMQlNPWWYxMTZnVkJtY25kTkhJNVlmdmpaQTREcVVVb2JEV2NqWnhF?=
 =?utf-8?B?VktZQTZDcWRGcDNqaERxeUZnOWlkRzFneWN0dmpEdGRzYW8wUXdmSlZMN29y?=
 =?utf-8?B?eGU4YThmYloyaEUxU1c4dFlSbFlJdVpjM2pUSXUyK1drdFcyeFdkS0JCZGFn?=
 =?utf-8?B?MWxTdnBQQWhKNVBMTkh6bnkvbzBNL2NybUFiWXU3UzJQZHlYbEhEMjlxMFph?=
 =?utf-8?B?SHhZTmdia3RvYzVMMTh6citNVkpkSFdZMGVMc3ZoOS95YmJudk41MjJqOVpo?=
 =?utf-8?B?blhDdWNrUDlXaDl0cG91TFJrL1FBUTUvZVJha0xPMnMwSXR1M0F1YWs1UjVG?=
 =?utf-8?B?RW5IQm9YV1MrVktOZHM2Q2hUWlpNREJaaHM5RGVYeDBFZDF5TGgxTUZZRzl4?=
 =?utf-8?B?ZHhMRFpjUTU0Z1Y2QnZYZzJtZ0hDK05Dd0NERG04bkZGWUd2OWdkSHpDUGVo?=
 =?utf-8?B?SGh5Um55cEtLbmZLWTJ0UFJwd2ZrUnJQVFk3M0lER2FzZ2diVVdKKys3VTBR?=
 =?utf-8?B?bGVFVUxVVXlUWXpwbURpeDd1Y1BSRXN0RWxBclhhZEhML21RQTFUWEd2djdX?=
 =?utf-8?B?Rmh0MnZEQVVCLzExeGRmUFpoUndOREdoZGRnU3FLblhlWHV2MVF0UE9oNUds?=
 =?utf-8?B?TlVSaTFOT3g5b0hwamprQld4TzRmbWtRWCs4RXRCVnBIbnJlRDRkZUJlWEtR?=
 =?utf-8?B?N2RFWTBvcWxocGU4ayttdVZTb2ZJVEd0aG54c0ZkM3BKYmFtTGhLSHRZY2V1?=
 =?utf-8?B?a0QwcXMwamw3Q2FHMEFKdndha3dmeDdXU1B6S1NnOFlzcGl0MHUzMDR3Um5i?=
 =?utf-8?B?OUtFUzh5ZzdUS3ZzS01xNG1SQ0NwNjk2TDU4OEJOTHZHN3FCa3owMXl6RExC?=
 =?utf-8?B?N0tySTlnem1TUW1EczRKOGRLa2hpUkpFUHFoY0lzNVhUUkhBZzJ2RWV1VjRP?=
 =?utf-8?B?bVJnbTU1blZrUjc2ZjRKOENyYVFTS0Z5RWwrSGhQc0cvdFVTb01vSWY5WW5n?=
 =?utf-8?B?QXBRK3BTTzREbno3aWpjS01vc1U0MXBsK0w3Mi9BeFFCb2hZcy9teFBBcEtF?=
 =?utf-8?B?T3QxQm1XQVJHWHVnLzdxSTI4VW1maUhvSk1LVXBWVGNjcWRjQ2NPODh0UzhO?=
 =?utf-8?B?OTZSRldndlpBL3RxbGVuRkhTNXh3RHBHK2lTaHdEelBNVTVSMi9Mc2F2Tnk0?=
 =?utf-8?B?OHVhdXRVQm1HNi9EeEdreHh4UEZIdGluZGQ3M0JycDZFbS9vRTdFYkRmQ2Q4?=
 =?utf-8?B?blB5bEF0RGRyeXJJUVFmdGhtODh1MUFJMGdCVXlRNEdtcENhYmN3Q1c0dWpP?=
 =?utf-8?B?ckJ4eHhkaUhyQVRUTkovZ1BSWm9NNkNpWE1PVjNuRDNuRStKYnZ0V3BUWTFD?=
 =?utf-8?Q?3+7F+S7Faw0fhWnsODJpGwc7MIi5SW42lVTvg?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6C9DB079334CFD459A34FBC5A012B184@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd668391-e66d-4f44-1ed0-08da18fdeb9e
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 01:20:08.3428
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g33EiGSsfRCAm0znsDFJm95jVzArpwgG+34EVp1Vmr7FqgpoxKEhlj/2aisEb8MS5k8j+kY2D8ouvMWkRU6sNjknMd8EDF3JZnlF9vzvOk0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB6611
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzcgMjA6NTUsIENocmlzdGlhbiBCcmF1bmVyIHdyb3RlOg0KPiBPbiBUaHUsIEFw
ciAwNywgMjAyMiBhdCAwODowOTozMFBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4gU2luY2Ug
d2UgcGxhbiB0byBpbmNyZWFzZSBzZXRnaWQgdGVzdCBjb3ZlcnRhZ2UsIGl0IHdpbGwgZmluZCBu
ZXcgYnVnDQo+PiAsIHNvIGFkZCBhIG5ldyB0ZXN0IGdyb3VwIHRlc3Qtc2V0Z2lkIGlzIGJldHRl
ci4NCj4+DQo+PiBBbHNvIGFkZCBhIG5ldyB0ZXN0IGNhc2UgdG8gdGVzdCB0ZXN0LXNldGdpZCBp
bnN0ZWFkIG9mIG1pc3MgaXQuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcy
MDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4gLS0tDQo+PiAgIHNyYy9pZG1hcHBlZC1tb3VudHMvaWRt
YXBwZWQtbW91bnRzLmMgfCAxOSArKysrKysrKysrKysrKystLS0tDQo+PiAgIHRlc3RzL2dlbmVy
aWMvOTk5ICAgICAgICAgICAgICAgICAgICAgfCAyNiArKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPj4gICB0ZXN0cy9nZW5lcmljLzk5OS5vdXQgICAgICAgICAgICAgICAgIHwgIDIgKysNCj4N
Cj4gSSBhY3R1YWxseSBkaWRuJ3QgbWVhbiB0byBzcGxpdCBvdXQgdGhlIGV4aXN0aW5nIHNldGdp
ZCB0ZXN0cy4gSSBtZWFuDQo+IGFkZGluZyBuZXcgb25lcyBmb3IgdGhlIHRlc3QtY2FzZXMgeW91
J3JlIGFkZGluZy4gQnV0IGhvdyB5b3UgZGlkIGl0DQo+IHdvcmtzIGZvciBtZSB0b28gYW5kIGlz
IGEgYml0IG5pY2VyLiBJIGRvbid0IGhhdmUgYSBzdHJvbmcgb3BpbmlvbiBzbyBhcw0KPiBsb25n
IGFzIERhdmUgYW5kIERhcnJpY2sgYXJlIGZpbmUgd2l0aCBpdCB0aGVuIHRoaXMgc2VlbXMgZ29v
ZCB0byBtZS4NCk9rLCBsZXQncyBsaXN0ZW4gLi4NCj4NCj4gT25lIG5vdGUgYWJvdXQgdGhlIHRl
c3QgbmFtZS9udW1iZXJpbmcgdGhvdWdoLiBJdCBzZWVtcyB5b3UgaGF2ZW4ndA0KPiBhZGRlZCB0
aGUgdGVzdCB1c2luZyB0aGUgcHJvdmlkZWQgeGZzdGVzdCBpbmZyYXN0cnVjdHVyZSB0byBkbyB0
aGF0Lg0KPiBJbnN0ZWFkIG9mIG1hbnVhbGx5IGFkZGluZyB0aGUgdGVzdCB5b3Ugc2hvdWxkIHJ1
biB0aGUgIm5ldyIgc2NyaXB0Lg0KPg0KPiBZb3Ugc2hvdWxkIHJ1bjoNCj4NCj4gICAgICAgICAg
fi9zcmMvZ2l0L3hmc3Rlc3RzJCAuL25ldyBnZW5lcmljDQo+DQo+ICAgICAgICAgIE5leHQgdGVz
dCBpZCBpcyA2NzgNCj4gICAgICAgICAgQXBwZW5kIGEgbmFtZSB0byB0aGUgSUQ/IFRlc3QgbmFt
ZSB3aWxsIGJlIDY3OC0kbmFtZS4geSxbbl06DQo+ICAgICAgICAgIENyZWF0aW5nIHRlc3QgZmls
ZSAnNjc4Jw0KPiAgICAgICAgICBBZGQgdG8gZ3JvdXAocykgW2F1dG9dIChzZXBhcmF0ZSBieSBz
cGFjZSwgPyBmb3IgbGlzdCk6IGF1dG8gcXVpY2sgYXR0ciBpZG1hcHBlZCBtb3VudCBwZXJtcw0K
PiAgICAgICAgICBDcmVhdGluZyBza2VsZXRhbCBzY3JpcHQgZm9yIHlvdSB0byBlZGl0IC4uLg0K
Pg0KPiB0aGF0J2xsIGF1dG9tYXRpY2FsbHkgZmlndXJlIG91dCB0aGUgY29ycmVjdCB0ZXN0IG51
bWJlciBldGMuDQpUaGFua3MsIFRCSCwgSSBkb24ndCBrbm93IHRoaXMgdXNhZ2UuIEkgZG9uJ3Qg
bmFtZSB0byA2NzggYmVjYXVzZSANCmZzdGVzdHMgcGF0Y2h3b3JrIGhhcyBvdGhlcnMgbmV3IGNh
c2UoaW4gcmV2aWV3aW5nKSwgc28gSSBhZGQgYSBiaWdlciANCm51bWJlci4NCg0KQmVzdCBSZWdh
cmRzDQpZYW5nIFh1DQo=
