Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3E30514C522
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 05:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgA2EOu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 23:14:50 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:36399 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726518AbgA2EOu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 23:14:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580271289; x=1611807289;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=qjsyCoxG6mLlHWnY6zuONNNyOTqJcTzN3zMQRH6b/gA=;
  b=N6fRgC+pXoKeT+YcAh1u1i8BoiQr9eK9bcR2YreTrVLAIFLqj7UncDX7
   y1DOZ16w7y+Nzs5vS1uf+6IiTIso1BH+mGyx/gNZKmXRQ2ydc8h428Ert
   uE8eryGcWBvY2QLhS+lulvzdmtcCSPUQL8SpSB3sJFeH2cs3T2VDaMC95
   9gOxyzwr1KDmnP/6iiEWovN3/+VBHb5EC7p3nVyEqHYMG6L6JO65sZDti
   Ym+ot7Ur0qRHUlSd8RR0V/SV2uQdXDWMh/TR7w6uHLd/SQmGZyj4zHtQS
   rUtf3DNEqY2fedRTYZ+/677p60caXBvqPiC3zidmFpKJ+GCy/JT4gAefq
   g==;
IronPort-SDR: 3WsYMa5IumcFpPnow5w/Ut4M5nF1kzmmyAk38ZrUxBsDMbyUHWmO9MQ8q/T8TJoj31ZEpwKBwl
 gR5FMa8Z5q4LT1HsJFG7r5rtbgy+b+xpMCQDa/UMhWaVPwbmWzNd7rJBvLGgdDV52vq2oydhEe
 lPzdYAV+f+d/kz5kExasgTmjgoI8MjUg8FcE0CLbpcyg9UnvLNi5dX/YbhjW4t4kQEM17TuCIx
 dSLAff13borQy7P9JCQLkwxBNwrqtQtgd95RsHWOXWru31dlIlE9QH7Evx/qQWRlhdKyZz33Xu
 cNc=
X-IronPort-AV: E=Sophos;i="5.70,376,1574092800"; 
   d="scan'208";a="128626886"
Received: from mail-dm6nam12lp2171.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.171])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2020 12:14:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nBOEYfmCIBD/GAWk4ewZgEwGxm4TSI4h0MP2cCHSWW1pm0hFJyrNrVJBEL4gxIjqJWavdZD0m4HTiJn1P1EY7sjYop07WxbB91rVNaP2yzVXil2p/i437+tb0J2JJVoAmxiZPseu0TvHpHNoCe8usAf+nwq/qhdnoPLSqB0W0GuYQZ0ShBE3pQv1iXmExwcyPiJDhgqFEMgyYhArsOsxMVRTCWXENfhRiQVA1JWvFu4QcoTlVSjsIcgQvHEI8yDj6sWxFMD/wSXMhHggCohcQfu5CSmB4YgomUmepchUs+vTzaJ4L63+VHNt/N07/HutjX8MP1UwsDULI4p9r/qn8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjsyCoxG6mLlHWnY6zuONNNyOTqJcTzN3zMQRH6b/gA=;
 b=NK8cozeFbKjMfrc2i44l/PYZN7XlANJ4iiS0J3XCK9NrCGkBw8wLVxEx2/69ahuuoJYjL+XLOmjPIsLB5uFdf6As9CI9DTl/G573JfLb9OC++DWd/gQf0vd1fQYECl/kInf2lnzYJUTmx23GoxNnAVqIdqGD+FRQDHGnKPSEfK316uAPq3N7Eg9tfC7rxZ0gsdITB7fx2fHwPHkKAFEY+qD1GdMqrcQBSoJq4iyXpATviZrhbGqn9ZD/zA8niW/eNOv8bHeZig2seRoYk26/n7K/qCjGT0SirZWndV1ErNdjdeXhFQ8VuLdn7V1wyEfQxHeUMk3+zzEz9ubXpOZM4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qjsyCoxG6mLlHWnY6zuONNNyOTqJcTzN3zMQRH6b/gA=;
 b=X9ZSBAq5xnf1LZUBLwRRowIYHFhVcIUkY8x9IhuhthRqm02VkyVixgV6tSsHGWT0ThOA90A5WjEdbLueZ4v1203g/9lIl52A6XVjO+M7IJoKtIOnuZRnU5O0UkdOybCYLiHkaac98MX2muuDmlhxAPRicHz73xTZqVN3v7h4v20=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4934.namprd04.prod.outlook.com (52.135.232.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Wed, 29 Jan 2020 04:14:47 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 04:14:47 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Markus.Elfring@web.de" <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hare@suse.de" <hare@suse.de>, Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v9 1/2] fs: New zonefs file system
Thread-Index: AQHV1fd+i8cexmeU+kuMtjmzEb+Ao6gBCVeA
Date:   Wed, 29 Jan 2020 04:14:47 +0000
Message-ID: <66069013676fc49042b3cf96d30d98963c57f79d.camel@wdc.com>
References: <1928f213-f6c8-156f-a968-6d0603a7656c@web.de>
In-Reply-To: <1928f213-f6c8-156f-a968-6d0603a7656c@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.34.3 (3.34.3-1.fc31) 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16d50590-0b93-4a9c-2690-08d7a471c727
x-ms-traffictypediagnostic: BYAPR04MB4934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB49349F616329B2C068A44DE2E7050@BYAPR04MB4934.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(81156014)(81166006)(66556008)(186003)(8936002)(6486002)(8676002)(6506007)(4326008)(91956017)(66946007)(76116006)(316002)(2906002)(66476007)(64756008)(66446008)(86362001)(36756003)(110136005)(478600001)(6512007)(26005)(71200400001)(4744005)(2616005)(54906003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4934;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iQnAsMKlh2N0Q+BY89BDitaIcs2fL2f/YksB0kwSvWPXqSZ5hJrImRi6mCTNgYlMXVOXzKHIyMfLH39siLyUpBXeqV9CS7U6je89OC2o0lhCaNIhfWKC8fsWJxSuiwGRB5zene6j/hiMl3sinKbLi16Gk5R6HwLhc9JCH1hmQ0SiTUsAmj+Y8agYCqUkXMxMImilOshTcpTzplDnX9QacDNSIUpKNGmM6NKAyGRs5uXmZT5oBdyli/UWuegIzcAVZBaYferTn/G++SL7bEGdgwcjaiYWstra4jC081ZYmRj5++1H/6JjKO0s9a0hWjvuYPefe0asJNQ6VbOxUOXCSur1dn6u70UDpwKz6vnFToCh5+/SWeRJx8XeqUv8YxQHlLg5hM81BuECG9TCWEak9hUuipHPVKA1RlpmpIbW9trWaN/IjQZNhC92x0FeQhEZ
x-ms-exchange-antispam-messagedata: 7VON7aadz975f9avE8p6PZiUnEPRdlhh+ts1xbJ0r+x8FzjgpGbMZpnacsVFiCq89x5nUwsDeFPeN30nXLa33k+Ojk2toFTXu4E49clGViJsg2Dvl/ZKxjJ79ubRWTZX8Io7DVAivKhoz/Sz6MZfHA==
Content-Type: text/plain; charset="utf-8"
Content-ID: <C24DD951B3303E4691B32FFC1F1A714F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16d50590-0b93-4a9c-2690-08d7a471c727
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 04:14:47.3737
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uEPY+SKFSMRbw5Nu+uQf2nl3z6kAyhPQqSY2SadUJRxNJLF06vr/IMRvhwc7AigFii8Z55IveQ0U5ElJuyijTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4934
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTI4IGF0IDE3OjI0ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4g4oCmDQo+ID4gKysrIGIvZnMvem9uZWZzL0tjb25maWcNCj4g4oCmDQo+ID4gKwloZWxwDQo+
ID4gKwkgIHpvbmVmcyBpcyBhIHNpbXBsZSBGaWxlIFN5c3RlbSB3aGljaCBleHBvc2VzIHpvbmVz
IG9mIGEgem9uZWQgYmxvY2sNCj4gDQo+IERvZXMgdGhlIGNhcGl0YWxpc2F0aW9uIG1hdHRlciBo
ZXJlPw0KPiBXb3VsZCB0aGUgc3BlbGxpbmcg4oCcWm9uZWZzIGlzIGEgc2ltcGxlIGZpbGUgc3lz
dGVtIHdoaWNoIOKApuKAnSBiZSBhcHByb3ByaWF0ZT8NCg0KRml4ZWQuIFRoYW5rcyAhDQoNCj4g
DQo+IFJlZ2FyZHMsDQo+IE1hcmt1cw0KDQotLSANCkRhbWllbiBMZSBNb2FsDQpXZXN0ZXJuIERp
Z2l0YWwgUmVzZWFyY2gNCg==
