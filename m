Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7B35B308C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  9 Sep 2022 09:46:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiIIHnF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 9 Sep 2022 03:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiIIHms (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 9 Sep 2022 03:42:48 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5BDB4DB7B
        for <linux-fsdevel@vger.kernel.org>; Fri,  9 Sep 2022 00:39:34 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-119-yxLAq0GEM_CkpIc4AW_VRw-1; Fri, 09 Sep 2022 08:37:37 +0100
X-MC-Unique: yxLAq0GEM_CkpIc4AW_VRw-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Fri, 9 Sep
 2022 08:37:37 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Fri, 9 Sep 2022 08:37:37 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Alexey Dobriyan' <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] proc: give /proc/cmdline size
Thread-Topic: [PATCH] proc: give /proc/cmdline size
Thread-Index: AQHYxAoY3n6CAL44Mk2Z/ZSAGARO463Wta2Q
Date:   Fri, 9 Sep 2022 07:37:37 +0000
Message-ID: <de33c84cc78747d4901050c792a72b9a@AcuMS.aculab.com>
References: <YxoywlbM73JJN3r+@localhost.localdomain>
 <20220908134546.6054f611243da37b4f067938@linux-foundation.org>
 <YxrKCLXE7k16j9xu@localhost.localdomain>
In-Reply-To: <YxrKCLXE7k16j9xu@localhost.localdomain>
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
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogQWxleGV5IERvYnJpeWFuDQo+IFNlbnQ6IDA5IFNlcHRlbWJlciAyMDIyIDA2OjA3DQo+
IA0KPiBPbiBUaHUsIFNlcCAwOCwgMjAyMiBhdCAwMTo0NTo0NlBNIC0wNzAwLCBBbmRyZXcgTW9y
dG9uIHdyb3RlOg0KPiA+IE9uIFRodSwgOCBTZXAgMjAyMiAyMToyMTo1NCArMDMwMCBBbGV4ZXkg
RG9icml5YW4gPGFkb2JyaXlhbkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+DQo+ID4gPiBNb3N0IC9w
cm9jIGZpbGVzIGRvbid0IGhhdmUgbGVuZ3RoIChpbiBmc3RhdCBzZW5zZSkuIFRoaXMgbGVhZHMN
Cj4gPiA+IHRvIGluZWZmaWNpZW5jaWVzIHdoZW4gcmVhZGluZyBzdWNoIGZpbGVzIHdpdGggQVBJ
cyBjb21tb25seSBmb3VuZCBpbg0KPiA+ID4gbW9kZXJuIHByb2dyYW1taW5nIGxhbmd1YWdlcy4g
VGhleSBvcGVuIGZpbGUsIHRoZW4gZnN0YXQgZGVzY3JpcHRvciwNCj4gPiA+IGdldCBzdF9zaXpl
ID09IDAgYW5kIGVpdGhlciBhc3N1bWUgZmlsZSBpcyBlbXB0eSBvciBzdGFydCByZWFkaW5nDQo+
ID4gPiB3aXRob3V0IGtub3dpbmcgdGFyZ2V0IHNpemUuDQo+ID4gPg0KPiA+ID4gY2F0KDEpIGRv
ZXMgT0sgYmVjYXVzZSBpdCB1c2VzIGxhcmdlIGVub3VnaCBidWZmZXIgYnkgZGVmYXVsdC4NCj4g
PiA+IEJ1dCBuYWl2ZSBwcm9ncmFtcyBjb3B5LXBhc3RlZCBmcm9tIFNPIGFyZW4ndDoNCj4gPg0K
PiA+IFdoYXQgaXMgIlNPIj8NCj4gDQo+IFN0YWNrT3ZlcmZsb3csIHRoZSBzb3VyY2Ugb2YgYWxs
IGJlc3QgcHJvZ3JhbXMgaW4gdGhlIHdvcmxkIQ0KDQpBbnlvbmUgZGlyZWN0bHkgY29weWluZyBh
bnl0aGluZyBmcm9tIHRoZXJlIGdldHMgd2hhdA0KdGhleSBkZXNlcnZlLg0KDQpVc2VmdWwgZm9y
IGhpbnRzLCBidXQgdGhleSBhcmUgc28gb2Z0ZW4gd3JvbmcuDQoNCglEYXZpZA0KDQotDQpSZWdp
c3RlcmVkIEFkZHJlc3MgTGFrZXNpZGUsIEJyYW1sZXkgUm9hZCwgTW91bnQgRmFybSwgTWlsdG9u
IEtleW5lcywgTUsxIDFQVCwgVUsNClJlZ2lzdHJhdGlvbiBObzogMTM5NzM4NiAoV2FsZXMpDQo=

