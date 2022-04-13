Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1754FF46F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Apr 2022 12:10:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbiDMKMf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Apr 2022 06:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234833AbiDMKMc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Apr 2022 06:12:32 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D58E0EF;
        Wed, 13 Apr 2022 03:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649844609; x=1681380609;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=F81Pk04i1pR9E5pxovBnTxPtC+1Tkn3mJ36RcI8Od18=;
  b=L08OY5qnKq40q27k2WkN/nXqDkCVFsvgXsthFt0/Op5rwBl7k0AkHLVN
   uG2ftnfuj+BgiN3dN9+XwP2NIt80Ye1uRhNL4Iz2mMHAYOX/JMefMd8G0
   EWJlUA9Lo8DSP8xxl381MWHMidtN9Kk2It89flqA1w51lN2KmCY2AkgQe
   CNj0v60yHMm33b0NxTzKDRK60HoW3M5Tn2N4fyjJt5nuM9160au9HPfeM
   1QbvRL+dSkb2jO+Jj1Kl2AZ6duRJtDlvHcK0wkFp9qYC8Lh9IRGxTA45m
   ch7ySLdRIFiCvguFwBPRzyEG9Bs5fI23xWxhibeh9jBM6nxvPRJ74TJOG
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10315"; a="53820577"
X-IronPort-AV: E=Sophos;i="5.90,256,1643641200"; 
   d="scan'208";a="53820577"
Received: from mail-os0jpn01lp2105.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.105])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2022 19:10:01 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Us4gP4KWf2FLlvUULPLhzeqs0PWd6o9LD8v8nJbmVxWIIjCraJJzt9ic29qM50K4YOFI5b+kj95A8uAm+OOXyEggFhQlaDY35NB07VS1S589juuH4ZZD9UXrpRBwLOR0xo1OqJdXoWxSJKwFXPQ/VH5M8xZdArsiIFp5tOVUsb7eondsD6cDeoBHptZS7Axw+jg2m2gg+vx3I0DYa3nQxC8ri7dDvfonIU5lhmjZurBP3WA2Y5W3bVUv8sPBIr4p2twmOOXcrbTSBrIlvNRNX3Abjo3E/DDXkOwRqZSCU3BrVpYeFQf/9QqCbOT9nOWAhYHuul0wwPUTFu+xBE6JlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F81Pk04i1pR9E5pxovBnTxPtC+1Tkn3mJ36RcI8Od18=;
 b=CJBferIURBmAIdyR1w3jo/0Y7KHFXkXY4m/ddpEQNN6W82NQlD5aTbCwuMWFx/3kpmcFDY4jW/Gc0LvvsukcmiW7HMFhLwe5s7BXBa+ywq7LaslMy4Ir/2M/eINILNKGxc9nPro3FocTJLEaT66olH2c/n1CtkEQS19uyT/sASYHi8Jk8rEhZAJG7JYvNtt7CGGztYSs3Mk9b2i3U3kxQTVO3WCVmCG3YjHYjGKXXEbfTfdOpWN8hNrgKNAtkkGf0T0K3qX/Q/PYNuIBEE6uhcAevT9WDIRoaH66slgIYMxRk4ne3ScKMg5YajzKh7zwfcwoZWE5l5G8knOldEJKdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F81Pk04i1pR9E5pxovBnTxPtC+1Tkn3mJ36RcI8Od18=;
 b=gDZ+1lLOIjEsi077lvA6BJJLoofAMDpbkpFy65kHxXco7mcWc7r83hAPE9ZWizxwnpC4/QmQY+6iE7D6NNLhZ4Cn7/jTb4otjwznpphTqfVfumdr0Bt9kd/OX0rgo09xuMkcSvsCp2DiF8wF47ODgMVkwxampMVs+OqEZemzwXc=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB4414.jpnprd01.prod.outlook.com (2603:1096:404:12d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.30; Wed, 13 Apr
 2022 10:09:58 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5144.030; Wed, 13 Apr 2022
 10:09:58 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] idmapped-mounts: Add new setgid_create_umask test
Thread-Topic: [PATCH v3 4/5] idmapped-mounts: Add new setgid_create_umask test
Thread-Index: AQHYTljV1XLIppAYZUyHKyMK/b7m8KztjPMAgAAduwD///LTgIAAFBgA
Date:   Wed, 13 Apr 2022 10:09:57 +0000
Message-ID: <6256AFC0.8010407@fujitsu.com>
References: <1649763226-2329-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1649763226-2329-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220413085946.bh2cii5q5isx2odr@wittgenstein> <6256A9F2.2030801@fujitsu.com>
 <20220413095901.2s7jeqyefovd7wok@wittgenstein>
In-Reply-To: <20220413095901.2s7jeqyefovd7wok@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a96847f9-a3d3-40a7-7602-08da1d35c3b1
x-ms-traffictypediagnostic: TYAPR01MB4414:EE_
x-microsoft-antispam-prvs: <TYAPR01MB4414DA0A309CE60425517630FDEC9@TYAPR01MB4414.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +sWgeGNNcWGWtwYX5f8Vs8+SZ0ggRuOuLrO8aUvLy+1qVRTKScyvV87U6da8JVi1nFjSAwv6FrzlnJe8PQDfqdQjJ2N0Tj3VcoTWGCv7B8JYHrUlCO84YCgQ5gs3xCJOTjvilYlVinQLKceHudq4WfUqHB2usco1AjxGABTQ57cGwswBfmUyZIV40a+7BQG7XvF8PpkBKnYEIqWH4y7B/NoBDz+tklHKQPOR60qiORJP71GmIi9GlCI+GQFZ+KBgxDOIoiCPiI0xhuWsX71vRCeA9AIJQ1VbLK4+uoL5UndVVZK/micf/U7orPby8+7h4PeGZXHXoEVG1S5DetkVyJZs8p6CHtybn1HYgHlhUrt1ehbSPBXwMlCmcHLknMzXWZtrdK30xwW50yT6HWJLocbca/Ktt8bzhuZJvqe0WHfV6LQx5vyPJBrSxU1ze0SAxonb1Wo6hBbkF+O67rwwBZqR5WayLKhh1zHnW06tstTHUk+ipNaj8+LgT1/DFfBAsVsOYY/9xHHmRgpS5n3RUk5UsxRmoh4AM4qo6m8r8HTyDAd4sgaTylMQDc4Gdm9A43j6eyNyBktD5n9Ii/BrvH8vnPWlhpFoClCzhrBk5DtHMOFWSZnccg6nmOhGjsJWPmg4KXAzrEKu/r8rM4tf3l0Rg9gT+atM/acpccClI+N/oK/53VJszJphO9FADBP5Eiuay0+4T0dhHa/m424u7H2m39kn801v2loUnmy32f6Sutku2Aay5wDOtLxwbJXzIxMbGAOcPd49oUBgcFsmot1zKrJmu1HQOB48bKpezQs=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(71200400001)(85182001)(2616005)(6506007)(6512007)(91956017)(6486002)(82960400001)(966005)(83380400001)(26005)(38100700002)(186003)(316002)(2906002)(33656002)(54906003)(6916009)(36756003)(38070700005)(508600001)(5660300002)(87266011)(86362001)(66476007)(66446008)(64756008)(66556008)(8676002)(76116006)(4326008)(66946007)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U05aRHhkL2x3b3duMmZTNG5iRVhpcGFSNGVEMitQOU1XNGZhVW9WTEN2a3VZ?=
 =?utf-8?B?WU1LVWhSdktueGExcDdKaE5VdkVLTXhNbC9uaFNRclBzS003RkdDUGFQQWZo?=
 =?utf-8?B?Y3BHeTBDbVQxUWhNWU93bUQ4K05ZM21tblByMmxPdWlNZXptR3VEa2lyWkRu?=
 =?utf-8?B?VEhzQUVNc25kbGE1Wlc3Q2JCZU5vc0FLSDhFVWY2RW4wY2pyZEhIRjh5YTBp?=
 =?utf-8?B?VEVMRnI5K0tYbmtrVnlDOVNrQ3dLS0xibFZrcDgrZlhCSWk4TnpaOTJJNlpQ?=
 =?utf-8?B?QjMyWDBudWsrQVVkUGdNNjR3NERiOSt4V1VOTGx3cGNQamJpNmhWYzBSMVRx?=
 =?utf-8?B?d3V5NUJ6aHY2dmZQL0p0NWhoSmZUVUMxRU5QZzVITFVkdlR4OUREM1RFY2NS?=
 =?utf-8?B?VkhNZXdDcHYwV1ZLa1pqZHo4ZkVtQVRNNXhqSTJJOGowTUlmd3dCTEhCbW80?=
 =?utf-8?B?Z3VpUDJFck5SUmhqMUUrNWYrY1ppNThVYURVWXpCaGVVb3NHSytVU3FzTkFI?=
 =?utf-8?B?M1pLNFZKMllMQVNsdE5VWS82a0tVMkZLNWRWS3RzUjF2dERLdzJQUXhxWWxa?=
 =?utf-8?B?Zk9pSWpEczFjR1JpZzRFNkJGcUptUXBtdHpVOGU1ZjB5QVNmSDVyU25VbExh?=
 =?utf-8?B?aWtzY2pjU0tDcVZ2LzQwMjVUZmozbFdaOWJOeE43UW9jbHdRczN2T0JhdFZu?=
 =?utf-8?B?MnowS0ptam5rVVBnQWRoZEx3eFEyTCsvdE1QMHZTdHhqQ3B5U3hmQW11NmRV?=
 =?utf-8?B?NnZXcUpLdE14RVRkR1FSMDVrdmZ3WXZxM1VnOTVxQzAySk5XVFZQd0IvZVY3?=
 =?utf-8?B?ZGE5akNrREI0cElVM2lBb09zNGh4ME01Qm4zcmFTOWpaNGJUSWFOWGo1OVI5?=
 =?utf-8?B?eHBNQzVxVXhob3BDSVJUbTJ1ZHB0dUlHbmFlRWE3Qk9VbVVrNGtRK0QvTVBE?=
 =?utf-8?B?RWhEQkxBdnpMZVFNSTNkSld0UnZIYXFEdWFHbkV4WXRJZUhydWE5Q3E0T3cz?=
 =?utf-8?B?SkJJd0V1VWlSOXZsR0RhSi9sY244KytqMGEzblAvYjczY1NFQTNaaTZNaEFV?=
 =?utf-8?B?MlY3WWp4a1RtNEs5YVpHQ3lpTmlHSHVLQ3M5bEczZHhndnJkL3kwZzNVZlVo?=
 =?utf-8?B?aEhDYS9RWFozT2F2ekZFS3N4a3EyeVZ0cW51WlNQaWdCRlo5ZGNLa2VSSThT?=
 =?utf-8?B?NzY0WkttV29MdjJsNGtRVG5MMTRpN0tLYnpEdUw0M0ZSVllvaVVqK3FhTTBK?=
 =?utf-8?B?cUc2N2RJWGtsVmk2Y1E2VEpIODBQV05zR0JRYXBkRUc5OTR3V01MeS9NUmFH?=
 =?utf-8?B?Z254ekNBd3VVN0ZKYS9NVDJWRVVEbGhZNWZWbDl1R2RvZ3BNV2w5SnV0cVg1?=
 =?utf-8?B?MTllSHplcitIV1FVUTZ1Ny9zL2kwR0YxVmh6azVzbGIyUndBQ3BBL0I1YUg0?=
 =?utf-8?B?MWdyb2Naa0lBSVpvZWduWnlzalVidm1lY215dzQxaUxZSGRoRUxBNWdMRU1P?=
 =?utf-8?B?RVA5RlgvR1dXeENCT1lTMWtYc1lTZ1hXbU1MMW85QVpzZWlPSjQ1YlZNd2ZB?=
 =?utf-8?B?RGdMTTBHcmR6NHJvNDZMeERSU3lHSksrTU5IT3M2Q0QydlUxU0hmZ2ZhUVdR?=
 =?utf-8?B?RzNMbGx1NnZQTFdzUk9OUktVcFFOMHRSdzZ6NGtyQmN1aFBGRWo3aEpVbkVl?=
 =?utf-8?B?ek5HMmIxRk9rZ3VKZ01Hd3FMY0ZreUZndGtJY0FtV1k3Q3I2azJTMmFpZTRB?=
 =?utf-8?B?OHdkWmJNUHZpRUhRZGkyMjArcTFzU2ZUUGUzV1V6ODd6Tk1qZnlaN1RoM2ZR?=
 =?utf-8?B?aENlQTRwNEJYOE1sd01FR3VNVmYwdjdLSjFRc2Uwa3pzL3ZHNitrYm9uejZo?=
 =?utf-8?B?ODJHdmhDYUkvTTMxNzB2Q3NOSDVpaXIvNENPOVBwS0JMaVdMQkFWNTl3Um4v?=
 =?utf-8?B?TFp2UWtOb3R3Q2VKRGtvSlp2N1RJckp3NThDb1hzdFhhM3lrc2ROSkJVVHFE?=
 =?utf-8?B?VWdsZE04cjR2aEsyaGdGcU10MTVoS3FScS9CblFHWWdNUWptRmFmeGpoQ0FQ?=
 =?utf-8?B?ZnZPRkZPdlcxbXJWWjBoSFRVYU9xZ1pxQUJKVWNwNHRhMzFGZzVhTUNMeEJG?=
 =?utf-8?B?YXB5Ylg3U2NCdXJiUkZ6QzZJMUhCcFc5ZTBwNTM4Z1FvRUhiS2xxWnNvc1pY?=
 =?utf-8?B?bG13b0lQYVVJVlc1RmdWUTBwRERnTlIyOHFGOElib0Z4RWM3NExXY3RGNzVt?=
 =?utf-8?B?K0RkU1k1Sm8vZlpmbnpKdk9sN1cwUzFvQkgxNlE1dVh4NGkyVzg5UDU2QU1E?=
 =?utf-8?B?eUsvNHhOZjI4WlNVTWtSeW1VUFNIcUx5ckp1aVlheWpPQzI0ZDk5S2h1RFVZ?=
 =?utf-8?Q?F1ZWzQPv8iRZTFPE=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3AE1133875C50F4385637927033B3469@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a96847f9-a3d3-40a7-7602-08da1d35c3b1
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2022 10:09:57.9537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W4ba19QRjoCWe02pue9iz/AelxeA1lkt5oLpecloxl4Eh2l2G2PA9gzpQHD0wQ/qpNqszHuLyObardNNzv5tmt6hTnh/XlF6Ysw7MUMpQ0g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB4414
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzEzIDE3OjU5LCBDaHJpc3RpYW4gQnJhdW5lciB3cml0ZToNCj4gT24gV2VkLCBB
cHIgMTMsIDIwMjIgYXQgMDk6NDU6MTFBTSArMDAwMCwgeHV5YW5nMjAxOC5qeUBmdWppdHN1LmNv
bSB3cm90ZToNCj4+IG9uIDIwMjIvNC8xMyAxNjo1OSwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6
DQo+Pj4gT24gVHVlLCBBcHIgMTIsIDIwMjIgYXQgMDc6MzM6NDVQTSArMDgwMCwgWWFuZyBYdSB3
cm90ZToNCj4+Pj4gVGhlIGN1cnJlbnRfdW1hc2soKSBpcyBzdHJpcHBlZCBmcm9tIHRoZSBtb2Rl
IGRpcmVjdGx5IGluIHRoZSB2ZnMgaWYgdGhlDQo+Pj4+IGZpbGVzeXN0ZW0gZWl0aGVyIGRvZXNu
J3Qgc3VwcG9ydCBhY2xzIG9yIHRoZSBmaWxlc3lzdGVtIGhhcyBiZWVuDQo+Pj4+IG1vdW50ZWQg
d2l0aG91dCBwb3NpYyBhY2wgc3VwcG9ydC4NCj4+Pj4NCj4+Pj4gSWYgdGhlIGZpbGVzeXN0ZW0g
ZG9lcyBzdXBwb3J0IGFjbHMgdGhlbiBjdXJyZW50X3VtYXNrKCkgc3RyaXBwaW5nIGlzDQo+Pj4+
IGRlZmVycmVkIHRvIHBvc2l4X2FjbF9jcmVhdGUoKS4gU28gd2hlbiB0aGUgZmlsZXN5c3RlbSBj
YWxscw0KPj4+PiBwb3NpeF9hY2xfY3JlYXRlKCkgYW5kIHRoZXJlIGFyZSBubyBhY2xzIHNldCBv
ciBub3Qgc3VwcG9ydGVkIHRoZW4NCj4+Pj4gY3VycmVudF91bWFzaygpIHdpbGwgYmUgc3RyaXBw
ZWQuDQo+Pj4+DQo+Pj4+IEhlcmUgd2Ugb25seSB1c2UgdW1hc2soU19JWEdSUCkgdG8gY2hlY2sg
d2hldGhlciBpbm9kZSBzdHJpcA0KPj4+PiBTX0lTR0lEIHdvcmtzIGNvcnJlY3RseS4NCj4+Pj4N
Cj4+Pj4gU2lnbmVkLW9mZi1ieTogWWFuZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0K
Pj4+PiAtLS0NCj4+Pj4gICAgc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYyB8
IDUwNSArKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPj4+PiAgICB0ZXN0cy9nZW5lcmljLzY4
MCAgICAgICAgICAgICAgICAgICAgIHwgIDI2ICsrDQo+Pj4+ICAgIHRlc3RzL2dlbmVyaWMvNjgw
Lm91dCAgICAgICAgICAgICAgICAgfCAgIDIgKw0KPj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDUz
MiBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4+ICAgIGNyZWF0ZSBtb2RlIDEwMDc1
NSB0ZXN0cy9nZW5lcmljLzY4MA0KPj4+PiAgICBjcmVhdGUgbW9kZSAxMDA2NDQgdGVzdHMvZ2Vu
ZXJpYy82ODAub3V0DQo+Pj4+DQo+Pj4+IGRpZmYgLS1naXQgYS9zcmMvaWRtYXBwZWQtbW91bnRz
L2lkbWFwcGVkLW1vdW50cy5jIGIvc3JjL2lkbWFwcGVkLW1vdW50cy9pZG1hcHBlZC1tb3VudHMu
Yw0KPj4+PiBpbmRleCAwMmY5MTU1OC4uZTZjMTQ1ODYgMTAwNjQ0DQo+Pj4+IC0tLSBhL3NyYy9p
ZG1hcHBlZC1tb3VudHMvaWRtYXBwZWQtbW91bnRzLmMNCj4+Pj4gKysrIGIvc3JjL2lkbWFwcGVk
LW1vdW50cy9pZG1hcHBlZC1tb3VudHMuYw0KPj4+PiBAQCAtMTQxNDYsNiArMTQxNDYsNDk0IEBA
IG91dDoNCj4+Pj4gICAgCXJldHVybiBmcmV0Ow0KPj4+PiAgICB9DQo+Pj4+DQo+Pj4+ICsvKiBU
aGUgZm9sbG93aW5nIHRlc3RzIGFyZSBjb25jZXJuZWQgd2l0aCBzZXRnaWQgaW5oZXJpdGFuY2Uu
IFRoZXNlIGNhbiBiZQ0KPj4+PiArICogZmlsZXN5c3RlbSB0eXBlIHNwZWNpZmljLiBGb3IgeGZz
LCBpZiBhIG5ldyBmaWxlIG9yIGRpcmVjdG9yeSBvciBub2RlIGlzDQo+Pj4+ICsgKiBjcmVhdGVk
IHdpdGhpbiBhIHNldGdpZCBkaXJlY3RvcnkgYW5kIGlyaXhfc2dpZF9pbmhpZXJ0IGlzIHNldCB0
aGVuIGluaGVyaXR0aGUNCj4+Pj4gKyAqIHNldGdpZCBiaXQgaWYgdGhlIGNhbGxlciBpcyBpbiB0
aGUgZ3JvdXAgb2YgdGhlIGRpcmVjdG9yeS4NCj4+Pj4gKyAqDQo+Pj4+ICsgKiBUaGUgY3VycmVu
dF91bWFzaygpIGlzIHN0cmlwcGVkIGZyb20gdGhlIG1vZGUgZGlyZWN0bHkgaW4gdGhlIHZmcyBp
ZiB0aGUNCj4+Pj4gKyAqIGZpbGVzeXN0ZW0gZWl0aGVyIGRvZXNuJ3Qgc3VwcG9ydCBhY2xzIG9y
IHRoZSBmaWxlc3lzdGVtIGhhcyBiZWVuDQo+Pj4+ICsgKiBtb3VudGVkIHdpdGhvdXQgcG9zaWMg
YWNsIHN1cHBvcnQuDQo+Pj4+ICsgKg0KPj4+PiArICogSWYgdGhlIGZpbGVzeXN0ZW0gZG9lcyBz
dXBwb3J0IGFjbHMgdGhlbiBjdXJyZW50X3VtYXNrKCkgc3RyaXBwaW5nIGlzDQo+Pj4+ICsgKiBk
ZWZlcnJlZCB0byBwb3NpeF9hY2xfY3JlYXRlKCkuIFNvIHdoZW4gdGhlIGZpbGVzeXN0ZW0gY2Fs
bHMNCj4+Pj4gKyAqIHBvc2l4X2FjbF9jcmVhdGUoKSBhbmQgdGhlcmUgYXJlIG5vIGFjbHMgc2V0
IG9yIG5vdCBzdXBwb3J0ZWQgdGhlbg0KPj4+PiArICogY3VycmVudF91bWFzaygpIHdpbGwgYmUg
c3RyaXBwZWQuDQo+Pj4+ICsgKg0KPj4+PiArICogVXNlIHVtYXNrKFNfSVhHUlApIHRvIGNoZWNr
IHdoZXRoZXIgaW5vZGUgc3RyaXAgU19JU0dJRCB3b3JrcyBjb3JyZWN0bHkuDQo+Pj4+ICsgKi8N
Cj4+Pj4gK3N0YXRpYyBpbnQgc2V0Z2lkX2NyZWF0ZV91bWFzayh2b2lkKQ0KPj4+PiArew0KPj4+
PiArCWludCBmcmV0ID0gLTE7DQo+Pj4+ICsJaW50IGZpbGUxX2ZkID0gLUVCQURGOw0KPj4+PiAr
CWludCB0bXBmaWxlX2ZkID0gLUVCQURGOw0KPj4+PiArCXBpZF90IHBpZDsNCj4+Pj4gKwlib29s
IHN1cHBvcnRlZCA9IGZhbHNlOw0KPj4+PiArCWNoYXIgcGF0aFtQQVRIX01BWF07DQo+Pj4+ICsJ
bW9kZV90IG1vZGU7DQo+Pj4+ICsNCj4+Pj4gKwlpZiAoIWNhcHNfc3VwcG9ydGVkKCkpDQo+Pj4+
ICsJCXJldHVybiAwOw0KPj4+PiArDQo+Pj4+ICsJaWYgKGZjaG1vZCh0X2RpcjFfZmQsIFNfSVJV
U1IgfA0KPj4+PiArCQkJICAgICAgU19JV1VTUiB8DQo+Pj4+ICsJCQkgICAgICBTX0lSR1JQIHwN
Cj4+Pj4gKwkJCSAgICAgIFNfSVdHUlAgfA0KPj4+PiArCQkJICAgICAgU19JUk9USCB8DQo+Pj4+
ICsJCQkgICAgICBTX0lXT1RIIHwNCj4+Pj4gKwkJCSAgICAgIFNfSVhVU1IgfA0KPj4+PiArCQkJ
ICAgICAgU19JWEdSUCB8DQo+Pj4+ICsJCQkgICAgICBTX0lYT1RIIHwNCj4+Pj4gKwkJCSAgICAg
IFNfSVNHSUQpLCAwKSB7DQo+Pj4+ICsJCWxvZ19zdGRlcnIoImZhaWx1cmU6IGZjaG1vZCIpOw0K
Pj4+PiArCQlnb3RvIG91dDsNCj4+Pj4gKwl9DQo+Pj4+ICsNCj4+Pj4gKwkgICAvKiBWZXJpZnkg
dGhhdCB0aGUgc2V0Z2lkIGJpdCBnb3QgcmFpc2VkLiAqLw0KPj4+PiArCWlmICghaXNfc2V0Z2lk
KHRfZGlyMV9mZCwgIiIsIEFUX0VNUFRZX1BBVEgpKSB7DQo+Pj4+ICsJCWxvZ19zdGRlcnIoImZh
aWx1cmU6IGlzX3NldGdpZCIpOw0KPj4+PiArCQlnb3RvIG91dDsNCj4+Pj4gKwl9DQo+Pj4+ICsN
Cj4+Pj4gKwlzdXBwb3J0ZWQgPSBvcGVuYXRfdG1wZmlsZV9zdXBwb3J0ZWQodF9kaXIxX2ZkKTsN
Cj4+Pj4gKw0KPj4+PiArCS8qIE9ubHkgdW1hc2sgd2l0aCBTX0lYR1JQIGJlY2F1c2UgaW5vZGUg
c3RyaXAgU19JU0dJRCB3aWxsIGNoZWNrIG1vZGUNCj4+Pj4gKwkgKiB3aGV0aGVyIGhhcyBncm91
cCBleGVjdXRlIG9yIHNlYXJjaCBwZXJtaXNzaW9uLg0KPj4+PiArCSAqLw0KPj4+PiArCXVtYXNr
KFNfSVhHUlApOw0KPj4+PiArCW1vZGUgPSB1bWFzayhTX0lYR1JQKTsNCj4+Pj4gKwlpZiAoISht
b2RlJiAgIFNfSVhHUlApKQ0KPj4+PiArCQlkaWUoImZhaWx1cmU6IHVtYXNrIik7DQo+Pj4+ICsN
Cj4+Pj4gKwlwaWQgPSBmb3JrKCk7DQo+Pj4+ICsJaWYgKHBpZDwgICAwKSB7DQo+Pj4+ICsJCWxv
Z19zdGRlcnIoImZhaWx1cmU6IGZvcmsiKTsNCj4+Pj4gKwkJZ290byBvdXQ7DQo+Pj4+ICsJfQ0K
Pj4+PiArCWlmIChwaWQgPT0gMCkgew0KPj4+PiArCQlpZiAoIXN3aXRjaF9pZHMoMCwgMTAwMDAp
KQ0KPj4+PiArCQkJZGllKCJmYWlsdXJlOiBzd2l0Y2hfaWRzIik7DQo+Pj4+ICsNCj4+Pj4gKwkJ
aWYgKCFjYXBzX2Rvd25fZnNldGlkKCkpDQo+Pj4+ICsJCQlkaWUoImZhaWx1cmU6IGNhcHNfZG93
bl9mc2V0aWQiKTsNCj4+Pj4gKw0KPj4+PiArCQkvKiBjcmVhdGUgcmVndWxhciBmaWxlIHZpYSBv
cGVuKCkgKi8NCj4+Pj4gKwkJZmlsZTFfZmQgPSBvcGVuYXQodF9kaXIxX2ZkLCBGSUxFMSwgT19D
UkVBVCB8IE9fRVhDTCB8IE9fQ0xPRVhFQywgU19JWEdSUCB8IFNfSVNHSUQpOw0KPj4+PiArCQlp
ZiAoZmlsZTFfZmQ8ICAgMCkNCj4+Pj4gKwkJCWRpZSgiZmFpbHVyZTogY3JlYXRlIik7DQo+Pj4+
ICsNCj4+Pj4gKwkJLyogTmVpdGhlciBpbl9ncm91cF9wKCkgbm9yIGNhcGFibGVfd3J0X2lub2Rl
X3VpZGdpZCgpIHNvIHNldGdpZA0KPj4+PiArCQkgKiBiaXQgbmVlZHMgdG8gYmUgc3RyaXBwZWQu
DQo+Pj4+ICsJCSAqLw0KPj4+PiArCQlpZiAoaXNfc2V0Z2lkKHRfZGlyMV9mZCwgRklMRTEsIDAp
KQ0KPj4+PiArCQkJZGllKCJmYWlsdXJlOiBpc19zZXRnaWQiKTsNCj4+Pg0KPj4+IFRoaXMgdGVz
dCBpcyB3cm9uZy4gU3BlY2lmaWNhbGx5LCBpdCBpcyBhIGZhbHNlIHBvc2l0aXZlLiBJIGhhdmUN
Cj4+PiBleHBsYWluZWQgdGhpcyBpbiBtb3JlIGRldGFpbCBvbiB2MiBvZiB0aGlzIHBhdGNoc2V0
Lg0KPj4+DQo+Pj4gWW91IHdhbnQgdG8gdGVzdCB0aGF0IHVtYXNrKFNfSVhHUlApICsgc2V0Z2lk
IGluaGVyaXRhbmNlIHdvcmsgdG9nZXRoZXINCj4+PiBjb3JyZWN0bHkuIEZpcnN0LCB3ZSBuZWVk
IHRvIGVzdGFibGlzaCB3aGF0IHRoYXQgbWVhbnMgYmVjYXVzZSBmcm9tIHlvdXINCj4+PiBwYXRj
aCBzZXJpZXMgaXQgYXQgbGVhc3Qgc2VlbXMgdG8gbWUgYXMgeW91J3JlIG5vdCBjb21wbGV0ZWx5
IGNsZWFyDQo+Pj4gYWJvdXQgd2hhdCB5b3Ugd2FudCB0byB0ZXN0IGp1c3QgeWV0Lg0KPj4+DQo+
Pj4gQSByZXF1ZXN0ZWQgc2V0Z2lkIGJpdCBmb3IgYSBub24tZGlyZWN0b3J5IG9iamVjdCBpcyBv
bmx5IGNvbnNpZGVyZWQgZm9yDQo+Pj4gc3RyaXBwaW5nIGlmIFNfSVhHUlAgaXMgc2ltdWx0YW5l
b3VzbHkgcmVxdWVzdGVkLiBJbiBvdGhlciB3b3JkcywgYm90aA0KPj4+IFNfU0lTR0lEIGFuZCBT
X0lYR1JQIG11c3QgYmUgcmVxdWVzdGVkIGZvciB0aGUgbmV3IGZpbGUgaW4gb3JkZXIgZm9yDQo+
Pj4gYWRkaXRpb25hbCBjaGVja3Mgc3VjaCBhcyBDQVBfRlNFVElEIHRvIGJlY29tZSByZWxldmFu
dC4NCj4+IFllcywgb25seSBrZWVwIFNfSVhHUlAsIHRoZW4gd2UgY2FuIHJ1biBpbnRvIHRoZSBu
ZXh0IGp1ZGdlbWVudCBmb3INCj4+IGdyb3VwIGFuZCBjYXBfZnNldGlkLg0KPj4+DQo+Pj4gV2Ug
bmVlZCB0byBkaXN0aW5ndWlzaCB0d28gY2FzZXMgYWZhaWN0Og0KPj4+DQo+Pj4gMS4gVGhlIGZp
bGVzeXN0ZW0gZG9lcyBzdXBwb3J0IEFDTHMgYW5kIGhhcyBhbiBhcHBsaWNhYmxlIEFDTA0KPj4+
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0NCj4+Pg0KPj4+IHVtYXNrKFNfSVhHUlApIGlzIG5vdCB1c2VkIGJ5IHRoZSBrZXJuZWwg
YW5kIHRodXMgU19JWEdSUCBpcyBub3QNCj4+PiBzdHJpcHBlZCAodW5sZXNzIHRoZSBBQ0wgZG9l
cyBtYWtlIGl0IHNvKSBhbmQgc28gd2hlbiBlLmcuDQo+Pj4gaW5vZGVfaW5pdF9vd25lcigpIGlz
IGNhbGxlZCB3ZSBkbyBub3QgZXhwZWN0IHRoZSBmaWxlIHRvIGluaGVyaXQgdGhlDQo+Pj4gc2V0
Z2lkIGJpdC4NCj4+Pg0KPj4+IFRoaXMgaXMgd2hhdCB5b3VyIHRlc3QgYWJvdmUgaXMgaGFuZGxp
bmcgY29ycmVjdGx5LiBCdXQgaXQgaXMgYSBmYWxzZQ0KPj4+IHBvc2l0aXZlIGJlY2F1c2Ugd2hh
dCB5b3UncmUgdHJ5aW5nIHRvIHRlc3QgaXMgdGhlIGJlaGF2aW9yIG9mDQo+Pj4gdW1hc2soU19J
WEdSUCkgYnV0IGl0IGlzIG1hZGUgaXJyZWxldmFudCBieSBBQ0wgc3VwcG9ydCBvZiB0aGUNCj4+
PiB1bmRlcmx5aW5nIGZpbGVzeXN0ZW0uDQo+PiBJIHRlc3QgdGhpcyBzaXR1YXRpb24gaW4gdGhl
IG5leHQgcGF0Y2ggYXMgYmVsb3c6DQo+PiB1bWFzayhTX0lYR1JQKTsNCj4+IHNucHJpbnRmKHRf
YnVmLCBzaXplb2YodF9idWYpLCAic2V0ZmFjbCAtZCAtbSB1Ojpyd3gsZzo6cnd4LG86OnJ3eCxt
OnJ3DQo+PiAlcy8lcyIsIHRfbW91bnRwb2ludCwgVF9ESVIxKQ0KPj4NCj4+IGFuZA0KPj4gdW1h
c2soU19JWEdSUCk7DQo+PiBzbnByaW50Zih0X2J1Ziwgc2l6ZW9mKHRfYnVmKSwgInNldGZhY2wg
LWQgLW0gdTo6cnd4LGc6OnJ3LG86OnJ3eCwNCj4+ICVzLyVzIiwgdF9tb3VudHBvaW50LCBUX0RJ
UjENCj4+DQo+Pj4NCj4+PiAyLiBUaGUgZmlsZXN5c3RlbSBkb2VzIG5vdCBzdXBwb3J0IEFDTHMs
IGhhcyBiZWVuIG1vdW50ZWQgd2l0aG91dA0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+Pj4gc3VwcG9ydCBmb3Ig
aXQsIG9yIGhhcyBubyBhcHBsaWNhYmxlIEFDTA0KPj4+IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0NCj4+Pg0KPj4+IHVtYXNrKFNfSVhHUlApIGlzIHVzZWQgYnkgdGhl
IGtlcm5lbCBhbmQgd2lsbCBiZSBzdHJpcHBlZCBmcm9tIHRoZSBtb2RlLg0KPj4+IFNvIHdoZW4g
aW5vZGVfaW5pdF9vd25lcigpIGlzIGNhbGxlZCB3ZSBleHBlY3QgdGhlIGZpbGUgdG8gaW5oZXJp
dCB0aGUNCj4+PiBzZXRnaWQgYml0Lg0KPj4gVGhpcyBpcyB3aHkgbXkga2VybmVsIHBhdGNoIHB1
dCBzdHJpcCBzZXRnaWQgY29kZSBpbnRvIHZmcy4NCj4+IHhmcyB3aWxsIGluaGVyaXQgdGhlIHNl
dGdpZCBiaXQgYnV0IGV4dDQgbm90IGJlY2F1c2UgdGhlIG5ld19pbm9kZQ0KPj4gZnVuY3Rpb24g
YW5kIHBvc2l4X2FjbF9jcmVhdGUgZnVuY3Rpb24gb3JkZXIoU19JWEdSUCBtb2RlIGhhcyBiZWVu
DQo+PiBzdHJpcHBlZCBiZWZvcmUgcGFzcyB0byBpbm9kZV9pbml0X293bmVyKS4NCj4+Pg0KPj4+
IFRoaXMgbWVhbnMgdGhlIHRlc3QgZm9yIHRoaXMgY2FzZSBuZWVkcyB0byBiZToNCj4+Pg0KPj4+
IAlmaWxlMV9mZCA9IG9wZW5hdCh0X2RpcjFfZmQsIEZJTEUxLCBPX0NSRUFUIHwgT19FWENMIHwg
T19DTE9FWEVDLCBTX0lYR1JQIHwgU19JU0dJRCk7DQo+Pj4gCWlmIChmaWxlMV9mZDwgICAwKQ0K
Pj4+IAkJZGllKCJmYWlsdXJlOiBjcmVhdGUiKTsNCj4+PiAJDQo+Pj4gCS8qDQo+Pj4gCSAqIFNf
SVhHUlAgd2lsbCBoYXZlIGJlZW4gcmVtb3ZlZCBkdWUgdG8gdW1hc2soU19JWEdSUCkgc28gd2Ug
ZXhwZWN0IHRoZQ0KPj4+IAkgKiBuZXcgZmlsZSB0byBiZSBTX0lTR0lELg0KPj4gTm8gTm8gTm8s
IHNlZSB0aGUga2VybmVsIHBhdGNoIHVybA0KPj4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9y
Zy9wcm9qZWN0L2xpbnV4LWZzZGV2ZWwvcGF0Y2gvMTY0ODQ2MTM4OS0yMjI1LTItZ2l0LXNlbmQt
ZW1haWwteHV5YW5nMjAxOC5qeUBmdWppdHN1LmNvbS8NCj4NCj4gT2ssIHNvIHlvdXIgdGVzdGlu
ZyBwYXRjaGVzIGFyZSBwcmVtaXNlZCBvbiB5b3VyIGtlcm5lbCBwYXRjaHNldC4gVGhhdA0KPiB3
YXNuJ3QgY2xlYXIgdG8gbWUuDQo+DQpCZWNhdXNlIG9mIERhcnJpY2sncyByZXF1ZXN0IHdoZW4g
cmV2aWV3aW5nIHRoaXMga2VybmVsIHBhdGNoc2V0LCBzbyANCnRoZW4gSSBiZWdpbiB0byByZWZh
Y3RvciBzZXRnaWRfY3JlYXRlIGNvZGUgaW4gZnN0ZXRzLi4uDQoNCiAgSSBzaG91bGQgaGF2ZSBh
ZGRlZCB0aGlzIGluIHRoaXMgcGF0Y2gnIGNvbW1pdCBtZXNzYWdlLCBzb3JyeS4gV2lsbCANCmFk
ZCBpdCBpbiB2NC4NCj4gVGhlIGtlcm5lbCBwYXRjaHNldCByZW1vdmVzIHRoZSBzZXRnaWQgYml0
IF9iZWZvcmVfIHRoZSB1bWFzayBpcyBhcHBsaWVkDQo+IHdoaWNoIGlzIHdoeSB5b3UncmUgZXhw
ZWN0aW5nIHRoaXMgZmlsZSB0byBub3QgYmUgc2V0Z2lkIGJlY2F1c2UgeW91DQo+IGFsc28gZHJv
cHBlZCBDQVBfRlNFVElEIGFuZCB5b3UnciBub3QgaW4gdGhlIGdyb3VwIG9mIHRoZSBkaXJlY3Rv
cnkuDQpZZXMuDQo+DQo+IChPaywgbGV0J3MgZGVmZXIgdGhhdCBkaXNjdXNzaW9uIHRvIHRoZSB1
cGRhdGVkIHBhdGNoc2V0LikNCkkgYW0gcmV3cml0dGluZyB0aGUga2VybmVsIHBhdGNoIGNvbW1p
dCBtZXNzYWdlIHRvIGNsYXJpZnkgd2h5IHB1dCB0aGlzIA0Kc3RyaXAgY29kZSBpbnRvIHZmcyBp
cyBzYWZlciwgYnV0IEkgc3RpbGwgaGF2ZSAgc2V2ZXJhbCBmaWxlc3lzdGVtIGNvZGUgDQpub3Qg
dG8gc2VlLiBJIHdpbGwgc2VuZCBhIHYyIGtlcm5lbCBwYXRjaHNldCB0b21vcnJvdy4NCg0KQmVz
dCBSZWdhcmRzDQpZYW5nIFh1
