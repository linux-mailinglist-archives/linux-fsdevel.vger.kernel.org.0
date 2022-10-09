Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5174B5F8AC1
	for <lists+linux-fsdevel@lfdr.de>; Sun,  9 Oct 2022 12:50:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230034AbiJIKt6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 9 Oct 2022 06:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbiJIKt5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 9 Oct 2022 06:49:57 -0400
Received: from eu-smtp-delivery-151.mimecast.com (eu-smtp-delivery-151.mimecast.com [185.58.85.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB47210558
        for <linux-fsdevel@vger.kernel.org>; Sun,  9 Oct 2022 03:49:55 -0700 (PDT)
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-32-AZdfbNVcP-2xXHI9wdH94Q-1; Sun, 09 Oct 2022 11:49:53 +0100
X-MC-Unique: AZdfbNVcP-2xXHI9wdH94Q-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.38; Sun, 9 Oct
 2022 11:49:52 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.040; Sun, 9 Oct 2022 11:49:52 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Nick Desaulniers' <ndesaulniers@google.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Kees Cook <keescook@chromium.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andi Kleen <ak@linux.intel.com>,
        Christoph Hellwig <hch@lst.de>,
        Eric Dumazet <edumazet@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        Paul Kirth <paulkirth@google.com>
Subject: RE: [PATCH] fs/select: avoid clang stack usage warning
Thread-Topic: [PATCH] fs/select: avoid clang stack usage warning
Thread-Index: AQHY2n+hcGcBonK1M0KmZt3TrrNRoK4F47gg
Date:   Sun, 9 Oct 2022 10:49:52 +0000
Message-ID: <b211e3a2549844fa957ca84b9257872d@AcuMS.aculab.com>
References: <20190307090146.1874906-1-arnd@arndb.de>
 <20221006222124.aabaemy7ofop7ccz@google.com>
 <c646ea1e-c860-41cf-9a8e-9abe541034ff@app.fastmail.com>
 <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
In-Reply-To: <CAKwvOdkEied8hf6Oid0sGf0ybF2WqrzOvtRiXa=j7Ms-Rc6uBA@mail.gmail.com>
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

RnJvbTogTmljayBEZXNhdWxuaWVycw0KPiBTZW50OiAwNyBPY3RvYmVyIDIwMjIgMjA6MDQNCi4u
Lg0KPiBJdCBsb29rcyBsaWtlIGZvciBhcnJheXMgSU5JVF9TVEFDS19BTExfUEFUVEVSTiB1c2Vz
IG1lbXNldCB0byBmaWxsDQo+IHRoZSBhcnJheSB3aXRoIDB4RkYgcmF0aGVyIHRoYW4gMHgwMCB1
c2VkIGJ5IElOSVRfU1RBQ0tfQUxMX1pFUk8uIE5vdA0KPiBzdXJlIHdoeSB0aGF0IHdvdWxkIG1h
a2UgYSBkaWZmZXJlbmNlLCBidXQgY3VyaW91cyB0aGF0IGl0IGRvZXMuDQoNCkhvdyBtdWNoIHBl
cmZvcm1hbmNlIGRvZXMgZmlsbGluZyB0aGUgYXJyYXkgY29zdD8NCkknZCBzdXNwZWN0IGl0IGlz
IGVub3VnaCB0byBiZSBtZWFzdXJhYmxlLg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJlZCBBZGRy
ZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1L
MSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K

