Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CDC225D8FD
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Sep 2020 14:52:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730316AbgIDMwX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Sep 2020 08:52:23 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:49538 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730114AbgIDMwT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Sep 2020 08:52:19 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 428291B7;
        Fri,  4 Sep 2020 15:52:08 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1599223928;
        bh=8moMATedVvC/Mwd/J3QHaBg8cFe/k1Zjj6s6XjcMcQ4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=Hb6uPJFDUfeK4xnnhZkp4v0giNfwbe1kHI3DQuVvxnaj8PIkEsi07HsgFIbE0wNng
         3PacAjOS+w3LF6a8Fgsqt2avmTb5sV7nz3SQpVE1+87PdpOcBn2ou8DzdTywoBWNG2
         azfXC7nAOLYn48GM4mcOX8nrs5iQcLwXX94FfHIQ=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Fri, 4 Sep 2020 15:52:07 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Fri, 4 Sep 2020 15:52:07 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Mark Harmstone <mark@harmstone.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: RE: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
Thread-Topic: [PATCH v2 05/10] fs/ntfs3: Add attrib operations
Thread-Index: AdZ9WYtoNhpifd4wR/GdSqVgVwVwlwAkLbAAATPptnA=
Date:   Fri, 4 Sep 2020 12:52:07 +0000
Message-ID: <a9e1e31b909346faa9b398db9fa33ba1@paragon-software.com>
References: <e2decd9632cd4d218fb83e96c0c37174@paragon-software.com>
 <3c1e5918-347a-d1e6-44ce-338c7d0dc7e4@harmstone.com>
In-Reply-To: <3c1e5918-347a-d1e6-44ce-338c7d0dc7e4@harmstone.com>
Accept-Language: ru-RU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.30.8.36]
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RnJvbTogTWFyayBIYXJtc3RvbmUgPG1hcmsuaGFybXN0b25lQGdtYWlsLmNvbT4gT24gQmVoYWxm
IE9mIE1hcmsgSGFybXN0b25lDQpTZW50OiBTYXR1cmRheSwgQXVndXN0IDI5LCAyMDIwIDM6NTQg
UE0NCj4gT24gMjgvOC8yMCA1OjUyIHBtLCBLb25zdGFudGluIEtvbWFyb3Ygd3JvdGU6DQo+ID4g
SGkgTWFyayEgVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEl0J3MgcmVhc29uYWJsZSBjb25jZXJu
LCBidXQgdGhlIG9wZW4NCj4gPiBxdWVzdGlvbiBpcyBob3cgdG8gYWNjZXNzIHRob3NlIE5URlMg
YXR0cmlidXRlcyB3aGljaCBleHRlbmQgdGhlIERPUw0KPiA+IGF0dHJpYnV0ZXMuIHVzZXIuRE9T
QVRUUklCIG1heSBiZSBnb29kIGZvciBGQVQzMiBhcyBET1MgYXR0cmlidXRlcyBhcmUgc3RvcmVk
IGluIDhiaXQuDQo+ID4gSG93ZXZlciwgdGhpcyBkb2VzIG5vdCBhcHBseSB0byBOVEZTICgzMmJp
dCBhdHRyaWJ1dGVzKS4NCj4gDQo+IEknbSBub3Qgc3VyZSB3aHkgdGhpcyB3b3VsZCBiZSBhbiBp
c3N1ZSAtIHRoZSBvYnZpb3VzIHdheSBvZiByZWFkaW5nDQo+IHVzZXIuRE9TQVRUUklCIGlzIHRv
IHVzZSBzc2NhbmYgaW50byBhbiBpbnQsIGFuZCB0aGVuIGNoZWNrIGZvciB0aGUgYml0cyB5b3Un
cmUNCj4gaW50ZXJlc3RlZCBpbi4gVGhlIE5UIEZJTEVfQVRUUklCVVRFXyogdmFsdWVzIHJlcGxp
Y2F0ZSBhbmQgZXh0ZW5kIHRoZSBGQVQNCj4gY29uc3RhbnRzIHVzZWQgYnkgRE9TLCBzbyBpdCBz
aG91bGRuJ3QgY2F1c2UgYW55IGNvbmZ1c2lvbiBvbmx5IGV4cG9zaW5nIHRoZQ0KPiBmdWxsIDMy
LWJpdCB2YWx1ZS4NCg0KSGkgTWFyayEgRmlyc3QsIGluIHY0IHdlJ3ZlIHJlbW92ZWQgc21iZC1l
eGNsdXNpdmUgYWNjZXNzIHRvDQp1c2VyLkRPU0FUVFJJQi4gT3ZlcmFsbCwgd2UgYWdyZWUgdGhh
dCB1bmlmaWVkIGFjY2VzcyBpcyBwcmVmZXJyZWQuDQpJZiBldmVyeW9uZSBpcyBmaW5lIHdpdGgg
c3RpY2tpbmcgdG8gdXNlci5ET1NBVFRSSUIsIHdlJ2xsIHJlbW92ZQ0Kb3RoZXIgb3B0aW9ucyBp
biBuZXh0IHBhdGNoZXMuDQo=
