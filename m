Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9536321EC07
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 11:01:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbgGNJB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 05:01:56 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:35647 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgGNJBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 05:01:55 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 14F9E8011F;
        Tue, 14 Jul 2020 21:01:53 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1594717313;
        bh=QZhAokAJFsC6uIiQS0wezeU8N66XgeQ4QescCeZU9us=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=iR8qyw0JVnHCYF0qT+HKOSZVqQ+bwMjPzy253eF1XtD2w4+5qL+5BBN4vQsfFCK8x
         EBtIVCjwT0faaUxDL8EQgayYEo4soJeTeqOXQD3y20JcrG/l1HkAIkd4N7Y3QoO1A/
         pm61enhuUIbpEqj6+jddx+PwJbuWrJNoeRO3vc9FuV1JEnekELWBzYyviBNoAIOcKi
         MYY/Ln0D4K4suz6nnze2bXQIOp8eSFIAGSFZoshBki0/mdpKsAnPtyjcICy7vXrS5I
         mxb0K+97RRNFnT89JojqsymFJVgw6K/QFTFGbc6Xg/REIbgHesAQD1wMgcn3ve+3kO
         zOvwvXSbGUEew==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[10.32.16.77]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f0d74720002>; Tue, 14 Jul 2020 21:01:38 +1200
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) by
 svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8::77) with Microsoft SMTP Server
 (TLS) id 15.0.1497.2; Tue, 14 Jul 2020 20:45:25 +1200
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.006; Tue, 14 Jul 2020 20:45:25 +1200
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Randy Dunlap <rdunlap@infradead.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: procfs VmFlags table missing from online docs
Thread-Topic: procfs VmFlags table missing from online docs
Thread-Index: AQHWWZ04Axuc9KTu2km08OQff6fL16kFzV0AgAAseoA=
Date:   Tue, 14 Jul 2020 08:45:25 +0000
Message-ID: <a8747dde-32d8-bbfd-fe73-662827abd60e@alliedtelesis.co.nz>
References: <8abafee9-e34b-45f6-19a7-3f043ceb5537@alliedtelesis.co.nz>
 <6ee41c18-934e-26c2-a875-3d9e4c700c6c@infradead.org>
In-Reply-To: <6ee41c18-934e-26c2-a875-3d9e4c700c6c@infradead.org>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <171F16C1FB480043918082C088BBED02@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQpPbiAxNC8wNy8yMCA2OjA2IHBtLCBSYW5keSBEdW5sYXAgd3JvdGU6DQo+IE9uIDcvMTMvMjAg
MTA6MTEgUE0sIENocmlzIFBhY2toYW0gd3JvdGU6DQo+PiBIaSwNCj4+DQo+PiBJIHdhcyBqdXN0
IGJyb3dzaW5nDQo+PiBodHRwczovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL2xhdGVzdC9maWxl
c3lzdGVtcy9wcm9jLmh0bWwNCj4+DQo+PiBUaGUgIlZtRmxhZ3MiIGRlc2NyaXB0aW9uIHNlZW1z
IHRvIGJlIG1pc3NpbmcgYSB0YWJsZS4gSXQncyB0aGVyZSBpbg0KPj4gRG9jdW1lbnRhdGlvbi9m
aWxlc3lzdGVtcy9wcm9jLnJzdCBzbyBJIGFzc3VtZSBpdCdzIHNvbWUgc3BoaW54L3JzdA0KPj4g
cHJvYmxlbS4gUG9zc2libHkgdGhlIHRhYmxlIGlzIG92ZXIgaW5kZW50ZWQ/DQo+IFdvdy4gSXQg
c2tpcHMgdGhlIHRhYmxlIGNvbXBsZXRlbHkuDQo+DQo+IEkgdHJpZWQgYSBjb3VwbGUgb2YgdGhp
bmdzIHRoYXQgZGlkIG5vdCBoZWxwLg0KSSB0aGluayBpdCdzIGp1c3QgdGhlIHN0cmF5IC0gaW4g
dGhlICJidCAtIGFybTY0IiBsaW5lIHBhdGNoIGluY29taW5nLg0KPj4gQW55d2F5IEkgdGhvdWdo
dCBJJ2QgbGV0IHNvbWVvbmUga25vdy4NCj4gVGhhbmtzLg0KPg0KPj4gUmVnYXJkcywNCj4+IENo
cmlzDQo+
