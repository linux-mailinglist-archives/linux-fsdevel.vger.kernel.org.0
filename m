Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09C1F202E7E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 04:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731043AbgFVCrI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 21 Jun 2020 22:47:08 -0400
Received: from mx06.melco.co.jp ([192.218.140.146]:52916 "EHLO
        mx06.melco.co.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726699AbgFVCrI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 21 Jun 2020 22:47:08 -0400
Received: from mr06.melco.co.jp (mr06 [133.141.98.164])
        by mx06.melco.co.jp (Postfix) with ESMTP id E0D803A4034;
        Mon, 22 Jun 2020 11:47:04 +0900 (JST)
Received: from mr06.melco.co.jp (unknown [127.0.0.1])
        by mr06.imss (Postfix) with ESMTP id 49qv2J5vDHzRjky;
        Mon, 22 Jun 2020 11:47:04 +0900 (JST)
Received: from mf03_second.melco.co.jp (unknown [192.168.20.183])
        by mr06.melco.co.jp (Postfix) with ESMTP id 49qv2J5ZV5zRjd4;
        Mon, 22 Jun 2020 11:47:04 +0900 (JST)
Received: from mf03.melco.co.jp (unknown [133.141.98.183])
        by mf03_second.melco.co.jp (Postfix) with ESMTP id 49qv2J5Z6yzRjr3;
        Mon, 22 Jun 2020 11:47:04 +0900 (JST)
Received: from APC01-PU1-obe.outbound.protection.outlook.com (unknown [104.47.126.51])
        by mf03.melco.co.jp (Postfix) with ESMTP id 49qv2J4K0BzRjc9;
        Mon, 22 Jun 2020 11:47:04 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G0j4MXmmxVSDMOJhPBrWLj7Q/Npob0V3+lu2CC1G2AhsH7YMKQ+z8mS9uDny3rrNAPph4QzXXp5MPKur7szqDfPIpdVBsgJP6iYxdLVpKjNzXwvOIb7nqe0dePA8NQaLfU5cq/cW62aWl5KmDCq/7syZrwNk440KorjTmiw41CeKNKCS4LQ8um1qyJqlfxVG9j6M8XUCVP5U7DvsUgNel4wGl+pNF6delV+iLQeHdrgFW1e21A66DmGXKEGaUntrZlOlI1urdfdEqOFsBYfO3oL+nxQBCY3DyV4HaThPOaPBwSXDbIkhCSFiz89q5J4ZYOzhFGCBuKGbKCUeR9ocmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gkH8xJDZbJ+sE7AWrSSxs4GTa1tZ+ogzVCCN3WBYWU=;
 b=Upq9yaJZjmjSeX042b9YslOLcvmFWt/TxGH/MP6pYY7vJ9hQMiaQJYJwb1lCusR0u9/diIOojzKwyTNBLATwc0IfpRjVy/rBAu2hblvVKDNRfUzmc2rde6Z5yNwfR/6gwjZ/RCpphpshKoyyV4Eru+J7MpsncnoOUmb7pUKWr2aPgAJSE8UO58qiPD3wRXzPtb10uPI+H1mMtNJN/G/9DWL8aiwHz32X8zlmhlsWwnYBlWLqNvVLFGjVqVZL/8w0sUg1DjNYoc0o5N6QbYmGDQTpUIuVlDc4MxBmMBJKMkNFDg3COYTbzUiCWW/OdPhjW8BMHxAzqbaC5G906tKKDQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=dc.mitsubishielectric.co.jp; dmarc=pass action=none
 header.from=dc.mitsubishielectric.co.jp; dkim=pass
 header.d=dc.mitsubishielectric.co.jp; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mitsubishielectricgroup.onmicrosoft.com;
 s=selector2-mitsubishielectricgroup-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8gkH8xJDZbJ+sE7AWrSSxs4GTa1tZ+ogzVCCN3WBYWU=;
 b=PywAw7Rr7BK1zitQwdyRa0+AVzdo5PhJGzzII07F4SLWn5F00ZUAEUtZpwZCnnxJtZGeSVuynSBGxJBc1ho77HNvFG533sYmWxqYCn7pxUAJ3F7I7pmc1J81X8QdTQJPswlsqRw2cP4ZeutOYP8meBz4klN6denrO+rjyVoui98=
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com (2603:1096:404:6b::11)
 by TY2PR01MB4858.jpnprd01.prod.outlook.com (2603:1096:404:10c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.24; Mon, 22 Jun
 2020 02:47:03 +0000
Received: from TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51e1:c5ae:8ef8:4b76]) by TY2PR01MB2875.jpnprd01.prod.outlook.com
 ([fe80::51e1:c5ae:8ef8:4b76%7]) with mapi id 15.20.3109.026; Mon, 22 Jun 2020
 02:47:03 +0000
From:   "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
To:     'Namjae Jeon' <linkinjeon@kernel.org>
CC:     "Mori.Takahiro@ab.MitsubishiElectric.co.jp" 
        <Mori.Takahiro@ab.MitsubishiElectric.co.jp>,
        "Motai.Hirotaka@aj.MitsubishiElectric.co.jp" 
        <Motai.Hirotaka@aj.MitsubishiElectric.co.jp>,
        Namjae Jeon <namjae.jeon@samsung.com>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        'Tetsuhiro Kohada' <kohada.t2@gmail.com>,
        'Christoph Hellwig' <hch@infradead.org>
Subject: RE: [PATCH 1/2 v4] exfat: write multiple sectors at once
Thread-Topic: [PATCH 1/2 v4] exfat: write multiple sectors at once
Thread-Index: AQHWR3la8B54VJqyQkK0efdoiW1IbKjj7UmQ
Date:   Mon, 22 Jun 2020 02:44:46 +0000
Deferred-Delivery: Mon, 22 Jun 2020 02:47:00 +0000
Message-ID: <TY2PR01MB2875F1888E60DEA85558A88C90970@TY2PR01MB2875.jpnprd01.prod.outlook.com>
References: <20200619083855.15789-1-kohada.t2@gmail.com>
 <CAKYAXd9qRx5q57xwG-d6-MzW-DK9jYAecX_6KuecCAhxrNbmmA@mail.gmail.com>
In-Reply-To: <CAKYAXd9qRx5q57xwG-d6-MzW-DK9jYAecX_6KuecCAhxrNbmmA@mail.gmail.com>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-melpop: 1
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none
 header.from=dc.MitsubishiElectric.co.jp;
x-originating-ip: [121.80.0.164]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ccef1fa6-e1df-4de3-a94c-08d816568bab
x-ms-traffictypediagnostic: TY2PR01MB4858:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <TY2PR01MB4858AFE512890BA40CF835C790970@TY2PR01MB4858.jpnprd01.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4714;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yaNR/nDhMUvOxTY0+qsjikabnyqMmoiDbX5K40VHei1RjlgPdg1y02kgMEVTe26Do8uynJtJ4vTWY+nnUvIB7ywXV1yQs6BbztsnWqh69FkN5enrt5CXVQ7cimxgx4os4nAJxnhDdFx6A0BGEp3xsgxNnzdavqJWnLyu5Jq/NE+dmO6RRStqEea8ow2BXhBsJjCw5F+fA68ZUKpBDQuiFkCnZYlXHGGaUG4LaAWcgPTeHFVofOOT/zXoYrrrQLvaKeRA+1XaQ86W6NSmM4EUQe/c7Cc3p+PQKu8eIcOV6UWqhuZnTYUMk5WfNKxMaSoV26SFAJmNDWkIa8KWpvT5QA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB2875.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(39860400002)(396003)(346002)(376002)(366004)(136003)(26005)(52536014)(186003)(54906003)(33656002)(9686003)(5660300002)(4326008)(6916009)(6506007)(6666004)(7696005)(478600001)(316002)(71200400001)(76116006)(66556008)(8936002)(83380400001)(64756008)(66446008)(66476007)(66946007)(55016002)(86362001)(2906002)(8676002)(4744005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: c0rkIVLbjDue1OSG7Z/f9Py9cED0SJaiJy1uIHGAU8bykgrJMEC4ETVFAsFxGqxt32UwnYrD1lfZkg3ZZzVwwhY0h8wHhcwCKLFOjXpL9khQsTNHgJmXHbNoM71k+lLxDkGTMsmVc/Bn3GAGjsgI4XhkkgThEzy/6fOWj9u+oZuWiEsQEb82GkDE/bgM6V+Lry3WRmyFX+6bPEAIP7zVXG/4EeaEpcTCqSMB3qZIf1+yb9kOfa3LgNib3G3to32P86TXuWEboKMI5xtoK0c6moH53Iu54VP///j+bCbewo/3QCHFXk9du6pSRM8U7UNcEoK6nkaNWHbIZEOTacKvj2qJ7Qoq1QJhQ9/HV48DeCgGVzU5L/Gs30Bx+k3KPDSTn4EBZmppWJe0iV+rkpDMvGTjQ3mUz5T6UO0xvxS4A0nDNoKhN3SLnk7hkRREbSpB1m0y2Zg7N7DiBzuwd5HCq95thmQZ1N3pLUpjuesRO6c=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: dc.MitsubishiElectric.co.jp
X-MS-Exchange-CrossTenant-Network-Message-Id: ccef1fa6-e1df-4de3-a94c-08d816568bab
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 02:47:03.8647
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c5a75b62-4bff-4c96-a720-6621ce9978e5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mr9EAGHaXCuS5Km+GtM3fWWiJsDbzYjsk2cNjROR/QpUHOp+fEDvhw5nYJGSgdY2rXt/6hoc1pKHkFSj3Zl+ow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4858
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiAyMDIwLTA2LTE5IDE3OjM4IEdNVCswOTowMCwgVGV0c3VoaXJvIEtvaGFkYSA8a29oYWRhLnQy
QGdtYWlsLmNvbT46DQo+ID4gV3JpdGUgbXVsdGlwbGUgc2VjdG9ycyBhdCBvbmNlIHdoZW4gdXBk
YXRpbmcgZGlyLWVudHJpZXMuDQo+ID4gQWRkIGV4ZmF0X3VwZGF0ZV9iaHMoKSBmb3IgdGhhdC4g
SXQgd2FpdCBmb3Igd3JpdGUgY29tcGxldGlvbiBvbmNlDQo+ID4gaW5zdGVhZCBvZiBzZWN0b3Ig
Ynkgc2VjdG9yLg0KPiA+IEl0J3Mgb25seSBlZmZlY3RpdmUgaWYgc3luYyBlbmFibGVkLg0KPiA+
DQo+ID4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAaW5mcmFkZWFkLm9yZz4N
Cj4gSGUgZGlkbid0IGdpdmUgcmV2aWV3ZWQtYnkgdGFnIGZvciB0aGlzIHBhdGNoLg0KPiBZb3Ug
c2hvdWxkbid0IGFkZCBpdCBhdCB3aWxsLg0KDQpJIHVuZGVyc3RhbmQuDQpTaG91bGQgSSByZW1v
dmUgcmV2aWV3ZWQtYnkgdGFnIGFuZCByZXBvc3QgdGhlIHBhdGNoPw0KDQpCUg0KLS0tDQpLb2hh
ZGEgVGV0c3VoaXJvIDxLb2hhZGEuVGV0c3VoaXJvQGRjLk1pdHN1YmlzaGlFbGVjdHJpYy5jby5q
cD4NCg==
