Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 370B163291C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 21 Nov 2022 17:13:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiKUQND (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 21 Nov 2022 11:13:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiKUQNB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 21 Nov 2022 11:13:01 -0500
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.86.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC78AD2374
        for <linux-fsdevel@vger.kernel.org>; Mon, 21 Nov 2022 08:12:59 -0800 (PST)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-79-JCNmq6zLOMy4J3wKzwty6A-1; Mon, 21 Nov 2022 16:12:56 +0000
X-MC-Unique: JCNmq6zLOMy4J3wKzwty6A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 21 Nov
 2022 16:12:53 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.044; Mon, 21 Nov 2022 16:12:53 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'James Bottomley' <James.Bottomley@HansenPartnership.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
CC:     Matthew Garrett <mjg59@srcf.ucam.org>,
        "linux-efi@vger.kernel.org" <linux-efi@vger.kernel.org>,
        Nayna <nayna@linux.vnet.ibm.com>,
        "Andrew Donnellan" <ajd@linux.ibm.com>,
        Nayna Jain <nayna@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "npiggin@gmail.com" <npiggin@gmail.com>,
        Dov Murik <dovmurik@linux.ibm.com>,
        Dave Hansen <dave.hansen@intel.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "George Wilson" <gcwilson@linux.ibm.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        Stefan Berger <stefanb@linux.ibm.com>
Subject: RE: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Thread-Topic: [PATCH 2/4] fs: define a firmware security filesystem named
 fwsecurityfs
Thread-Index: AQHY/bIc6g2ldzgOWEG38iaI8ZLls65JjEcA
Date:   Mon, 21 Nov 2022 16:12:53 +0000
Message-ID: <010cbb5d1c7944aba628a15774bef941@AcuMS.aculab.com>
References: <20221106210744.603240-1-nayna@linux.ibm.com>
         <20221106210744.603240-3-nayna@linux.ibm.com> <Y2uvUFQ9S2oaefSY@kroah.com>
         <8447a726-c45d-8ebb-2a74-a4d759631e64@linux.vnet.ibm.com>
         <Y2zLRw/TzV/sWgqO@kroah.com>
         <44191f02-7360-bca3-be8f-7809c1562e68@linux.vnet.ibm.com>
         <Y3anQukokMcQr+iE@kroah.com>
         <d615180d-6fe5-d977-da6a-e88fd8bf5345@linux.vnet.ibm.com>
         <Y3pSF2MRIXd6aH14@kroah.com>
         <88111914afc6204b2a3fb82ded5d9bfb6420bca6.camel@HansenPartnership.com>
         <Y3tbhmL4oG1YTyT/@kroah.com>
 <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
In-Reply-To: <10c85b8f4779700b82596c4a968daead65a29801.camel@HansenPartnership.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogSmFtZXMgQm90dG9tbGV5DQo+IFNlbnQ6IDIxIE5vdmVtYmVyIDIwMjIgMTQ6MDMNCi4u
Lg0KPiA+IFRoZW4gaG93IGRvZXMgdGhlIG5ldHdvcmtpbmcgY29kZSBoYW5kbGUgdGhlIG5hbWVz
cGFjZSBzdHVmZiBpbg0KPiA+IHN5c2ZzPw0KPiA+IFRoYXQgc2VlbXMgdG8gd29yayB0b2RheSwg
b3IgYW0gSSBtaXNzaW5nIHNvbWV0aGluZz8NCj4gDQo+IGhhdmUgeW91IGFjdHVhbGx5IHRyaWVk
Pw0KPiANCj4gamVqYkBsaW5ncm93On4+IHN1ZG8gdW5zaGFyZSAtLW5ldCBiYXNoDQo+IGxpbmdy
b3c6L2hvbWUvamVqYiAjIGxzIC9zeXMvY2xhc3MvbmV0Lw0KPiBsbyAgdHVuMCAgdHVuMTAgIHds
YW4wDQo+IGxpbmdyb3c6L2hvbWUvamVqYiAjIGlwIGxpbmsgc2hvdw0KPiAxOiBsbzogPExPT1BC
QUNLPiBtdHUgNjU1MzYgcWRpc2Mgbm9vcCBzdGF0ZSBET1dOIG1vZGUgREVGQVVMVCBncm91cA0K
PiBkZWZhdWx0IHFsZW4gMTAwMA0KPiAgICAgbGluay9sb29wYmFjayAwMDowMDowMDowMDowMDow
MCBicmQgMDA6MDA6MDA6MDA6MDA6MDANCj4gDQo+IFNvLCBhcyB5b3Ugc2VlLCBJJ3ZlIGVudGVy
ZWQgYSBuZXR3b3JrIG5hbWVzcGFjZSBhbmQgaXAgbGluayBzaG93cyBtZQ0KPiB0aGUgb25seSBp
bnRlcmZhY2UgSSBjYW4gc2VlIGluIHRoYXQgbmFtZXNwYWNlIChhIGRvd24gbG9vcGJhY2spIGJ1
dA0KPiBzeXNmcyBzaG93cyBtZSBldmVyeSBpbnRlcmZhY2Ugb24gdGhlIHN5c3RlbSBvdXRzaWRl
IHRoZSBuYW1lc3BhY2UuDQoNCllvdSBoYXZlIHRvIHJlbW91bnQgL3N5cyB0byBnZXQgdGhlIHJl
c3RyaWN0ZWQgY29weS4NCmVnIGJ5IHJ1bm5pbmcgJ2lwIG5ldG5zIGV4ZWMgbmFtZXNwYWNlIGNv
bW1hbmQnLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2VzaWRlLCBCcmFt
bGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3Ry
YXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

