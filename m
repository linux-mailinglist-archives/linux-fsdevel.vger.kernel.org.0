Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8823A2549FA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Aug 2020 17:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726393AbgH0Pyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Aug 2020 11:54:49 -0400
Received: from relayfre-01.paragon-software.com ([176.12.100.13]:40818 "EHLO
        relayfre-01.paragon-software.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726200AbgH0Pyt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Aug 2020 11:54:49 -0400
Received: from dlg2.mail.paragon-software.com (vdlg-exch-02.paragon-software.com [172.30.1.105])
        by relayfre-01.paragon-software.com (Postfix) with ESMTPS id 1C4581D11;
        Thu, 27 Aug 2020 18:54:45 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paragon-software.com; s=mail; t=1598543685;
        bh=GpEyhlwdEKigUIro7QDVzjxPVOnyk80P2SQbz/PL7gI=;
        h=From:To:CC:Subject:Date:References:In-Reply-To;
        b=JTTA8cGnStOX0gsqJyrtTXSh3YSqK431q1FdZUOXbVlAb+P9kRkIjji8WZo/SHY0r
         fVNS8QoPDsSMTCBEuQfVET5Xgh8/L8rLWex+6ALb8VMsyRtcdmkfPXipry+n64nkYX
         IoN1XlVkaJDeycCiRJYHcTEmBtANdrDXV0vFGhWc=
Received: from vdlg-exch-02.paragon-software.com (172.30.1.105) by
 vdlg-exch-02.paragon-software.com (172.30.1.105) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1847.3; Thu, 27 Aug 2020 18:54:44 +0300
Received: from vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b])
 by vdlg-exch-02.paragon-software.com ([fe80::586:6d72:3fe5:bd9b%6]) with mapi
 id 15.01.1847.003; Thu, 27 Aug 2020 18:54:44 +0300
From:   Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
To:     Randy Dunlap <rdunlap@infradead.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     =?utf-8?B?UGFsaSBSb2jDoXI=?= <pali@kernel.org>
Subject: RE: [PATCH v2 06/10] fs/ntfs3: Add compression
Thread-Topic: [PATCH v2 06/10] fs/ntfs3: Add compression
Thread-Index: AdZ30z3rsB9DvpW3SXSScNijIm+BLf//3GgA//ZvGSA=
Date:   Thu, 27 Aug 2020 15:54:44 +0000
Message-ID: <637da0b964ee4bda8d1d31a33ec659e5@paragon-software.com>
References: <ecaa5cd692294178a38a9a2310d9856f@paragon-software.com>
 <e12ee6c4-5064-709a-0d4b-751b23bc5ccb@infradead.org>
In-Reply-To: <e12ee6c4-5064-709a-0d4b-751b23bc5ccb@infradead.org>
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

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+DQpTZW50OiBGcmlkYXks
IEF1Z3VzdCAyMSwgMjAyMCA3OjQ2IFBNDQo+IA0KW10gDQo+ID4gKy8vIDB4M0ZGRg0KPiA+ICsj
ZGVmaW5lIEhlYWRlck9mTm9uQ29tcHJlc3NlZENodW5rICgoTFpOVF9DSFVOS19TSVpFICsgMiAt
IDMpIHwgMHgzMDAwKQ0KPiANCj4gRG8gd2UgbmVlZCBzb21ldGhpbmcgaW4gY29kaW5nLXN0eWxl
LnJzdCB0aGF0IHNheXM6DQo+IAlBdm9pZCBDYW1lbENhc2UgaW4gTGludXgga2VybmVsIHNvdXJj
ZSBjb2RlLg0KPiA/DQoNCkhpISBUaGFua3MuIFdpbGwgZ2V0IHJpZCBvZiBpdCBpbiB2My4NCg0K
PiANCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIGNvbXBlc3NfY2h1bmsNCj4gDQo+IEp1c3QgY3Vy
aW91czogd2hhdCBpcyB0aGlzIGNvbXBlc3MgbmFtZT8NCj4gDQo+ID4gKyAqDQo+ID4gKyAqIHJl
dHVybnMgb25lIG9mIHRoZSB0cmVlIHZhbHVlczoNCj4gDQo+IHMvdHJlZS90aHJlZS8NCj4gDQpb
XQ0KDQpXaWxsIGJlIGZpeGVkIGluIHYzLg0K
