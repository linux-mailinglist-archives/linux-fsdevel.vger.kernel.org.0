Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A65A1D45F7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 08:35:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726390AbgEOGfa (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 02:35:30 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:39623 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726191AbgEOGfa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 02:35:30 -0400
X-UUID: a627162ab9be4896a6a78854bb275d10-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=dnVzAwZEKYSKKY4z6dkr6lk8gdmk1Zn9tS3rjZChFxw=;
        b=kwP3dkT2wnhIK6hP6had2V0Z7rwvK+3/mjplUJSj+Y2YTlsYDUe1aNcX60PT1zJsQI+DGMO5AOQuCjtilA4TxJRcvm/jQ4MZXj4SIX54zHioqFt/GT2+ucgVaVjbC/X8ONuXj0OGZArn4uLYaSbrzzSD73g88Df20DCAmLwlh5U=;
X-UUID: a627162ab9be4896a6a78854bb275d10-20200515
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 782748912; Fri, 15 May 2020 14:35:27 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n1.mediatek.inc (172.21.101.77) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 14:35:24 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 14:35:24 +0800
Message-ID: <1589524526.3197.110.camel@mtkswgap22>
Subject: Re: [PATCH v13 07/12] scsi: ufs: UFS crypto API
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Satya Tangirala <satyat@google.com>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>,
        "Barani Muthukumaran" <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>,
        "Eric Biggers" <ebiggers@google.com>
Date:   Fri, 15 May 2020 14:35:26 +0800
In-Reply-To: <20200514003727.69001-8-satyat@google.com>
References: <20200514003727.69001-1-satyat@google.com>
         <20200514003727.69001-8-satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgU2F0eWEsDQoNCk9uIFRodSwgMjAyMC0wNS0xNCBhdCAwMDozNyArMDAwMCwgU2F0eWEgVGFu
Z2lyYWxhIHdyb3RlOg0KPiBJbnRyb2R1Y2UgZnVuY3Rpb25zIHRvIG1hbmlwdWxhdGUgVUZTIGlu
bGluZSBlbmNyeXB0aW9uIGhhcmR3YXJlDQo+IGluIGxpbmUgd2l0aCB0aGUgSkVERUMgVUZTSENJ
IHYyLjEgc3BlY2lmaWNhdGlvbiBhbmQgdG8gd29yayB3aXRoIHRoZQ0KPiBibG9jayBrZXlzbG90
IG1hbmFnZXIuDQo+IA0KPiBUaGUgVUZTIGNyeXB0byBBUEkgd2lsbCBhc3N1bWUgYnkgZGVmYXVs
dCB0aGF0IGEgdmVuZG9yIGRyaXZlciBkb2Vzbid0DQo+IHN1cHBvcnQgVUZTIGNyeXB0bywgZXZl
biBpZiB0aGUgaGFyZHdhcmUgYWR2ZXJ0aXNlcyB0aGUgY2FwYWJpbGl0eSwgYmVjYXVzZQ0KPiBh
IGxvdCBvZiBoYXJkd2FyZSByZXF1aXJlcyBzb21lIHNwZWNpYWwgaGFuZGxpbmcgdGhhdCdzIG5v
dCBzcGVjaWZpZWQgaW4NCj4gdGhlIGFmb3JlbWVudGlvbmVkIEpFREVDIHNwZWMuIEVhY2ggdmVu
ZG9yIGRyaXZlciBtdXN0IGV4cGxpY2l0eSBzZXQNCg0KZXhwbGljaXRseQ0KDQo+IGhiYS0+Y2Fw
cyB8PSBVRlNIQ0RfQ0FQX0NSWVBUTyBiZWZvcmUgdWZzaGNkX2hiYV9pbml0X2NyeXB0byBpcyBj
YWxsZWQgdG8NCj4gb3B0LWluIHRvIFVGUyBjcnlwdG8gc3VwcG9ydC4NCj4gDQo+IFNpZ25lZC1v
ZmYtYnk6IFNhdHlhIFRhbmdpcmFsYSA8c2F0eWF0QGdvb2dsZS5jb20+DQo+IFJldmlld2VkLWJ5
OiBFcmljIEJpZ2dlcnMgPGViaWdnZXJzQGdvb2dsZS5jb20+DQoNClJldmlld2VkLWJ5OiBTdGFu
bGV5IENodSA8c3RhbmxleS5jaHVAbWVkaWF0ZWsuY29tPg0KDQo=

