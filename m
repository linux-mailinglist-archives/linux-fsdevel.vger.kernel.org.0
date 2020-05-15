Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 087991D4724
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 09:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726653AbgEOHhT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 03:37:19 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:7911 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726613AbgEOHhT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 03:37:19 -0400
X-UUID: 592f197f268745128398747fa762b992-20200515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/DCO/zS7sesB2PVRfTMTsSwE8pj4v6mVVtmNsnUpisY=;
        b=mc53IrWVbJ+QF+yITq9W+RJtiRzw/Im0K8UCmXksgoT20zYkNPfdBnBiDEemIfDnQnt2H3YNc7uARzMCvDYBH4p7wCZKMDWVvoe4trS35E7ICLkv+vNXWRV01seYMGFC8/GgBzTsI6rOkU4iv1+LT5PZ6vbeikuIROOKSCQZ6Vs=;
X-UUID: 592f197f268745128398747fa762b992-20200515
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <stanley.chu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.10 Build 0809 with TLS)
        with ESMTP id 1287260482; Fri, 15 May 2020 15:37:16 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 15 May 2020 15:37:06 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 15 May 2020 15:37:06 +0800
Message-ID: <1589528228.3197.114.camel@mtkswgap22>
Subject: Re: [PATCH v13 08/12] scsi: ufs: Add inline encryption support to
 UFS
From:   Stanley Chu <stanley.chu@mediatek.com>
To:     Satya Tangirala <satyat@google.com>
CC:     <linux-block@vger.kernel.org>, <linux-scsi@vger.kernel.org>,
        <linux-fscrypt@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
        <linux-f2fs-devel@lists.sourceforge.net>,
        <linux-ext4@vger.kernel.org>,
        "Barani Muthukumaran" <bmuthuku@qti.qualcomm.com>,
        Kuohong Wang <kuohong.wang@mediatek.com>,
        Kim Boojin <boojin.kim@samsung.com>
Date:   Fri, 15 May 2020 15:37:08 +0800
In-Reply-To: <20200514003727.69001-9-satyat@google.com>
References: <20200514003727.69001-1-satyat@google.com>
         <20200514003727.69001-9-satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3162AC34A7748C1611374E99FEE9C8C991AB3926776566336456D27B7D911DA92000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGkgU2F0eWEsDQoNCk9uIFRodSwgMjAyMC0wNS0xNCBhdCAwMDozNyArMDAwMCwgU2F0eWEgVGFu
Z2lyYWxhIHdyb3RlOg0KPiBXaXJlIHVwIHVmc2hjZC5jIHdpdGggdGhlIFVGUyBDcnlwdG8gQVBJ
LCB0aGUgYmxvY2sgbGF5ZXIgaW5saW5lDQo+IGVuY3J5cHRpb24gYWRkaXRpb25zIGFuZCB0aGUg
a2V5c2xvdCBtYW5hZ2VyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogU2F0eWEgVGFuZ2lyYWxhIDxz
YXR5YXRAZ29vZ2xlLmNvbT4NCg0KUmV2aWV3ZWQtYnk6IFN0YW5sZXkgQ2h1IDxzdGFubGV5LmNo
dUBtZWRpYXRlay5jb20+DQoNClRoYW5rcyBTYXR5YSBhbmQgRXJpYyBzbyBtdWNoIHRvIG1ha2Ug
aW5saW5lIGVuY3J5cHRpb24gdXBzdHJlYW1lZC4NCg0KSSB3aWxsIHByb3ZpZGUgZXNzZW50aWFs
IE1lZGlhVGVrIHZvcHMgcGF0Y2ggdG8gYWRvcHQgdGhpcyBmcmFtZXdvcmsNCnNvb24uDQoNClRo
YW5rcywNClN0YW5sZXkgQ2h1DQoNCg0K

