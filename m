Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAA6814C51E
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 05:13:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgA2ENs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jan 2020 23:13:48 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:48389 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726548AbgA2ENs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jan 2020 23:13:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580271228; x=1611807228;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iMTON3LdqBnt6+mwar4LTXledxU1gFW3sx9+sK3IZZ0=;
  b=fou15oooQY/nSaHvjH+eY5ppLmyi6h7QsI4Vnw7u5swaxp3hbuTcU7aO
   Mo21BV2b0yVYUlkxtc5MhDLGIrxxB396Jcwjy8xXYtMwXiBebDI8ACH5l
   mXkJ6YHEaCM+dG5hzfQx7NCBTWSldNiSYJCK5f3n/C5AscBiX/fza7obV
   tDiZ7O0yWZ67UuNUMweX7leGaDkb4XgQelPoiAZY0DBvVxKFYGfdxzwdR
   hiikaa6mL3feADg4qjAsxI1Y/01lerSvPo6XD8J1H4lLO08rd72XomDZU
   yiFFrypKHv33dBiG/SAfgZnVbB/wv4alJLbVJdDXd1hdfDSb8lwpGHUAT
   w==;
IronPort-SDR: cR1/Uw9SSyiCPnu7kNvDFb1KNZnzcFzgJZgSQOdbY6aTWDpzIOfp+idr9JXdgr/3MbI/OiSCRl
 hQtI8eQTLLrqFXIHDhjUBjXVbEDDJYtFJ5+ciuNuoZ6v+MuvwqEr/3RgKr/job0Ik257bn45fL
 LgjxL/D6Q7e1YJS66gVvVH1f4sNC1uXkmPYMT3jI/WD3IavTK31buT5evMQSQ4YhMpAD7+n+8I
 rJbEG+e0oMGTLUDy+2ja1lx1n/afryroqGaFlg4pSBqzpeQHu5fpyBT+tv0Ib/6f/b8U+Oi8q1
 zlo=
X-IronPort-AV: E=Sophos;i="5.70,376,1574092800"; 
   d="scan'208";a="129193406"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2020 12:13:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oZZG1BUjx9DIAR+fqaRVvrUMCm3DwmURFCa4anGb1AVRxRSK8C4NGesAQQ8JffGxm2kRWFdc+O7tswpI0XzaPo/VhJDtJUmv3bR0IUFujfN/ZfAfujKB75yDRb2FcpdJD9TgiYacBliwAwJL2Cy3aI3tDspKABiED+zxUgJvT/byzNBhwX5bVYqsEXBq+f4PkexLsQ2DMmeqXpnddT3ZmdpOpBnYNoBjE09QD54PtyHbUlzNXVpRiMFGDKJHx/+1AfE8+tRN5XfhsOy2I3jnU+t8pwkSAIa9xP9pz3yozSANoc8mFbjOGk2tUFsTkC8RNgssrkGL1ujMKBjAd/p2gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMTON3LdqBnt6+mwar4LTXledxU1gFW3sx9+sK3IZZ0=;
 b=VsePmHzVvm6RWerfygUAYp9BoYtklvAVy8CpHrfbff9DyVyBTVnVy6WiqO2F6czCSDTw69FP+KNwrHY2rzg9kg6JtJfqX+m4o23ooIIZHlZ+Q6Wz5zJAZzxhuXvXbELboCpU0dDPHQdTRrv1g4zUSECdMUQWyyEuxihsyr4/fzOsUhU/lgJng+GXBXWFbp15JQdIaAdrFQOMVFjTH7RsgTFEik8Dwvp/zVHo3CJbB4S7xXfgg3Be6TRO8g5+MvOPuUmZZbbokDWvusGXhP0koosEEFvemBd54d0yPEPFgivRXRdRLC9Gc9OjtW2PEAVEbUEjhCCuSYNZcZHmrMMWjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iMTON3LdqBnt6+mwar4LTXledxU1gFW3sx9+sK3IZZ0=;
 b=iVTQX+oFENJc2QgPRVYkAUC/JCwZancpotRZeGMdsLqQCMK2Hpi7tODFEE9YZoffjnWf9/N09RyOTU0BBY31YdyAwTMcvQxMK4VuCjYm2QifFwOSSuPsGb5OsAZWgupNMPnZ1FKAB45b+GTvXrle/qnSYCjiL2hBqRopGxC96js=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4934.namprd04.prod.outlook.com (52.135.232.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Wed, 29 Jan 2020 04:13:43 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 04:13:43 +0000
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
Thread-Index: AQHV1fB23bgzMmzBxUymcdYwabOlz6gBCRmA
Date:   Wed, 29 Jan 2020 04:13:42 +0000
Message-ID: <5fe2d31c2f798b0768eec3ebc35bc973bc07ba1c.camel@wdc.com>
References: <23bf669d-b75f-ed94-478d-06bddd357919@web.de>
In-Reply-To: <23bf669d-b75f-ed94-478d-06bddd357919@web.de>
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
x-ms-office365-filtering-correlation-id: 4e1a4efe-bae0-43f7-8c1b-08d7a471a0cc
x-ms-traffictypediagnostic: BYAPR04MB4934:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4934DF80BB3F5B4181ED1E58E7050@BYAPR04MB4934.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:4303;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(366004)(376002)(346002)(39860400002)(189003)(199004)(81156014)(81166006)(66556008)(186003)(8936002)(6486002)(8676002)(6506007)(966005)(4326008)(91956017)(66946007)(76116006)(316002)(2906002)(66476007)(64756008)(66446008)(86362001)(36756003)(110136005)(478600001)(6512007)(26005)(71200400001)(4744005)(2616005)(54906003)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4934;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8IAg91Anpi9zdjUCrYUrDd6QSeUTQtuCrbjV5g6/HLskYWBD2cwi7MVPnBhA8WxHI+s+fX4SzWy1UQkQlW48KwOEuiUswUVay5JYUdzHs87wV4NLfPynQ8ML08iT1LD/8agJzc1GI9+9Fjb0yRE+xeCsVUUK6ar6pW1cGyQhE3nPvZeFc0u/uQuSeaZB67bciGUfLMIOb/8ABZfNPBUmVhOAYG67QVulRrdhYbafBhhtukVcftZ/A+zuoe+wSQ9k55e6wpEx5+0qiocuI9P3/j6yvHmSrt5y7QTbWlH+pz/8KhGg+K4D8OdbOtJVNax5B043ZifCHnxTP/eWKQzQivm6zRKJz5E/qmXknzrrbZm18uCPHtEe0HTjEIRGLbEIc9oxKpf8DMwCxjZEClI+6LFH5zmLJ6uJjGrRhMimhMKyRx1ZYuE8a4zXIeYWcqTV8qipaWiMVBFS448iye4rB2wM+7Tsp2OBzslc9/bdR3vUHyQRS1i8fab5WTI++fTrSEs0KyirY2d2dlhJV0VA9w==
x-ms-exchange-antispam-messagedata: pixtRBBOVKjsFT4kYJg8qOEIh8WTqtU5qLN9WMEg/y+iH8dx/6wr9HjYL7CK21jcbmHXodPADJVGEtFarjB6dTIRM6zycjQMlQ3CMsjPtP6OOZtxv+aqUp7OTqbSLmU4x03PkP+wmRd3tUbJN7omnw==
Content-Type: text/plain; charset="utf-8"
Content-ID: <39C2C769C135D948923919B67F5A5A8C@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e1a4efe-bae0-43f7-8c1b-08d7a471a0cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 04:13:42.9815
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HlEcsgS2rLU6pVzgjs+RNXX3xft9Z2Wbv3HCHVCgsgRyYopFdlTn+qwGB1P9iu6Uk1nmkVvbdagqgrLkXnSeZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4934
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTI4IGF0IDE2OjM0ICswMTAwLCBNYXJrdXMgRWxmcmluZyB3cm90ZToN
Cj4g4oCmDQo+ID4gKysrIGIvZnMvem9uZWZzL3N1cGVyLmMNCj4g4oCmDQo+ID4gK291dDoNCj4g
PiArCWt1bm1hcChwYWdlKTsNCj4gPiArb3V0X2ZyZWU6DQo+ID4gKwlfX2ZyZWVfcGFnZShwYWdl
KTsNCj4gDQo+IFdvdWxkIHlvdSBsaWtlIHRvIHJlY29uc2lkZXIgeW91ciBuYW1lIHNlbGVjdGlv
biBmb3Igc3VjaCBsYWJlbHM/DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51
eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC90cmVlL0RvY3VtZW50YXRpb24vcHJvY2Vz
cy9jb2Rpbmctc3R5bGUucnN0P2lkPWIwYmUwZWZmMWE1YWI3N2Q1ODhiNzZiZDhiMWM5MmQ1ZDE3
YjNmNzMjbjQ2MA0KPiANCj4gQ2hhbmdlIHBvc3NpYmlsaXR5Og0KPiANCj4gK3VubWFwOg0KPiAr
CWt1bm1hcChwYWdlKTsNCj4gK2ZyZWVfcGFnZToNCj4gKwlfX2ZyZWVfcGFnZShwYWdlKTsNCj4g
DQoNCkZpeGVkLiBUaGFua3MgIQ0KDQo+IA0KPiBSZWdhcmRzLA0KPiBNYXJrdXMNCg0KLS0gDQpE
YW1pZW4gTGUgTW9hbA0KV2VzdGVybiBEaWdpdGFsIFJlc2VhcmNoDQo=
