Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D33A724B6A3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Aug 2020 12:39:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726666AbgHTKjA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Aug 2020 06:39:00 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:33602 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731229AbgHTKiK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Aug 2020 06:38:10 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id F36F1223;
        Thu, 20 Aug 2020 13:38:07 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1597919888;
        bh=gfXFV6bh+3dm6WwUV1c/R0J8KdjOdJb/YfS20DcA1TQ=;
        h=From:To:Subject:Date:References:In-Reply-To;
        b=oF1Ef0jpdMP0PGiW8jcwI7pSE+y5loGhZ6e3E76Np9uAYmnWtuQ/xykBU/3rdmAqD
         ecXo+pXUyjPwrmtbyQFX/1S7I7R4TMUA3bEGcgV2EUuqUxcca5uHeDK5HT6cdj8xFF
         VffkE1PfN3Qcjzx6U94UDjxbRaMEdR7d8dBy3hYM=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 20 Aug 2020 13:38:07 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 20 Aug 2020 13:38:07 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     =?utf-8?B?QXVyw6lsaWVuIEFwdGVs?= <aaptel@suse.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: RE: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Topic: [PATCH] fs: NTFS read-write driver GPL implementation by Paragon
 Software.
Thread-Index: AdZyNcmjSkpkGje7R9K6YobJrVDyZwAAOBcAASmx1XA=
Date:   Thu, 20 Aug 2020 10:38:07 +0000
Message-ID: <5588b1f433bb4844ae4db776030d323f@paragon-software.com>
References: <2911ac5cd20b46e397be506268718d74@paragon-software.com>
 <87h7t5454n.fsf@suse.com>
In-Reply-To: <87h7t5454n.fsf@suse.com>
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

RnJvbTogQXVyw6lsaWVuIEFwdGVsIDxhYXB0ZWxAc3VzZS5jb20+DQpTZW50OiBGcmlkYXksIEF1
Z3VzdCAxNCwgMjAyMCA2OjMwIFBNDQo+IEkndmUgdHJpZWQgdGhpcyB1c2luZyBsaWJudGZzLTNn
IG1rZnMubnRmcw0KPiANCj4gIyBta2ZzLm50ZnMgL2Rldi92YjENCj4gIyBtb3VudCAtdCBudGZz
MyAvZGV2L3ZiMSAvbW50DQo+IA0KPiBUaGlzIGFscmVhZHkgdHJpZ2dlcmVkIFVCU0FOOg0KPiBU
aGVuIEkndmUgdHJpZWQgdG8gY29weSAvZXRjIGludG8gaXQ6DQo+IC4uLg0KPiAjIGNwIC1ycCAv
ZXRjIC9tbnQNCj4gDQo+IEJ1dCB0aGlzIHRyaWdnZXJlZCBhIE5VTEwgcHRyIGRlcmVmOg0KPiAN
Cj4gIEJVRzoga2VybmVsIE5VTEwgcG9pbnRlciBkZXJlZmVyZW5jZSwgYWRkcmVzczogMDAwMDAw
MDAwMDAwMDAyOA0KDQpUaGFua3MhIFRoaXMgd2lsbCBiZSBmaXhlZCBpbiB2Mi4gVG8gZ2l2ZSBz
b21lIGNvbnRleHQ6IHdlIHVzZSBvdXIgbWtmcyB1dGlsaXR5IGluIHRlc3RzLCBjb3VwbGVkIHdp
dGggYSBXaW5kb3dzLW5hdGl2ZSBvbmUgYXMgYSByZWZlcmVuY2UuIFAuUy4gQWxyZWFkeSBoYXZl
IGV4dGVuZGVkIHRoaXMgYXBwcm9hY2ggd2l0aCB0aGUgY3VycmVudCBta2ZzLm50ZnMgdXRpbGl0
eSBhcyB3ZWxsLg0K
