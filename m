Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A71AC6026B9
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Oct 2022 10:25:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbiJRIZa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Oct 2022 04:25:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiJRIZY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Oct 2022 04:25:24 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC3C98342
        for <linux-fsdevel@vger.kernel.org>; Tue, 18 Oct 2022 01:25:21 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-2-35Rxj-SpPiqudJRe367Y8w-1; Tue, 18 Oct 2022 09:25:16 +0100
X-MC-Unique: 35Rxj-SpPiqudJRe367Y8w-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 18 Oct
 2022 09:25:14 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.042; Tue, 18 Oct 2022 09:25:14 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Frank Hofmann' <fhofmann@cloudflare.com>,
        Ivan Babrou <ivan@cloudflare.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@cloudflare.com" <kernel-team@cloudflare.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Theodore Ts'o <tytso@mit.edu>,
        Jonathan Corbet <corbet@lwn.net>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christoph Anton Mitterer <mail@christoph.anton.mitterer.name>,
        Mike Rapoport <rppt@kernel.org>,
        "Paul Gortmaker" <paul.gortmaker@windriver.com>,
        Kalesh Singh <kaleshsingh@google.com>
Subject: RE: [PATCH v2] proc: report open files as size in stat() for
 /proc/pid/fd
Thread-Topic: [PATCH v2] proc: report open files as size in stat() for
 /proc/pid/fd
Thread-Index: AQHY4slyq0Jheh9Cz06WEADbevrMua4Tz5UA
Date:   Tue, 18 Oct 2022 08:25:14 +0000
Message-ID: <57b146037b5744d4877fd77b1e4db262@AcuMS.aculab.com>
References: <20220922224027.59266-1-ivan@cloudflare.com>
 <20221017184700.e1e6944e743bfc38e9abd953@linux-foundation.org>
 <CABWYdi1UJsi1iGOAME1tW5eJdqvo3XJidWyO97ksxS85w3ZUPQ@mail.gmail.com>
 <CABEBQineydLjdHcc84+JuQnvEbGqkiXuVRXvcmk58bO=9X901Q@mail.gmail.com>
In-Reply-To: <CABEBQineydLjdHcc84+JuQnvEbGqkiXuVRXvcmk58bO=9X901Q@mail.gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogRnJhbmsgSG9mbWFubg0KPiBTZW50OiAxOCBPY3RvYmVyIDIwMjIgMDk6MTMNCj4gDQo+
IE9uIFR1ZSwgT2N0IDE4LCAyMDIyIGF0IDY6MDIgQU0gSXZhbiBCYWJyb3UgPGl2YW5AY2xvdWRm
bGFyZS5jb20+IHdyb3RlOg0KPiA+DQo+ID4gT24gTW9uLCBPY3QgMTcsIDIwMjIgYXQgNjo0NyBQ
TSBBbmRyZXcgTW9ydG9uIDxha3BtQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cm90ZToNCj4gPiA+
ID4gKw0KPiA+ID4gPiArICAgICAgICAgICAgIGZkdCA9IGZpbGVzX2ZkdGFibGUocC0+ZmlsZXMp
Ow0KPiA+ID4gPiArICAgICAgICAgICAgIHNpemUgPSBmZHQtPm1heF9mZHM7DQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKyAgICAgICAgICAgICBmb3IgKGkgPSBzaXplIC8gQklUU19QRVJfTE9ORzsgaSA+
IDA7KQ0KPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgb3Blbl9mZHMgKz0gaHdlaWdodDY0
KGZkdC0+b3Blbl9mZHNbLS1pXSk7DQo+ID4gPg0KPiA+ID4gQ291bGQgQklUTUFQX1dFSUdIVCgp
IG9yIF9fYml0bWFwX3dlaWdodCgpIG9yIGJpdG1hcF93ZWlnaHQoKSBiZSB1c2VkIGhlcmU/DQo+
ID4NCj4gPiBUaGF0J3MgYSBncmVhdCBzdWdnZXN0aW9uLiBJIHRlc3RlZCBpdCB3aXRoIGJpdG1h
cF93ZWlnaHQoKSBhbmQgaXQNCj4gPiBsb29rcyBtdWNoIGNsZWFuZXIgd2hpbGUgcHJvdmlkaW5n
IHRoZSBzYW1lIHJlc3VsdC4NCj4gPg0KPiA+IEkganVzdCBzZW50IHRoZSB2MyB3aXRoIHRoaXMg
c3VnZ2VzdGlvbiBhcHBsaWVkLg0KPiANCj4gKzEgZnJvbSBtZSBvbiB1c2luZyBiaXRtYXBfd2Vp
Z2h0KCkgLSBnb29kIHNwb3R0aW5nIHRoYXQuDQoNCkRvZXMgdGhhdCBoYXZlIHRoZSBvcHRpbWlz
YXRpb25zIGZvciB0aGUgdmFsdWUgYmVpbmcgMCwgfjB1DQpvciAyKipuLTEgYWxsIG9mIHdoaWNo
IGFyZSBsaWtlbHkgZm9yIHRoZSBmZCB0YWJsZS4NCihFc3BlY2lhbGx5IGlmIHRoZXJlIGlzIG5v
ICdwb3BjbnQnIGluc3RydWN0aW9uLikNCg0KCURhdmlkDQoNCi0NClJlZ2lzdGVyZWQgQWRkcmVz
cyBMYWtlc2lkZSwgQnJhbWxleSBSb2FkLCBNb3VudCBGYXJtLCBNaWx0b24gS2V5bmVzLCBNSzEg
MVBULCBVSw0KUmVnaXN0cmF0aW9uIE5vOiAxMzk3Mzg2IChXYWxlcykNCg==

