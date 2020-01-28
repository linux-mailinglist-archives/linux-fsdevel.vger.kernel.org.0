Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B63914AD9F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jan 2020 02:35:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgA1Be7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 20:34:59 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:36780 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgA1Bez (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 20:34:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580175295; x=1611711295;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xXB5ffKwdVQ4Es0G72+IKHhGb42BCw49BTOR0PF7c8g=;
  b=IJHTpey1Fs+U8p7mz706FQnQwvk9VFWNxE+Xx66OttCJqJYkgDP+HHGl
   seaGcWqkKkdot8Xf1djZ2uGrixCUo4xXs9fD9teyMadzbn9uo+rsJk0CX
   Qsyo+BIKW0dhD/gY6gdQwy388g5Ta3XHaumJT/VDYZESsmyuqSbRduqmr
   lTZeWtueJQsWyqcIX1vhsKjB7uJg2fdvX50mUufX54t+wHtwU0en8RyFY
   nqtdqXxupFWTn7QaU9V+oPDMoQSwh/609XHeIAb8qqT89QEB48dybctlG
   Edlxml0fp9KYshfpxSPKGbfCUrIEleErN7Tmq+kw+7tTFfWCvRYGbI7vy
   w==;
IronPort-SDR: x8v7Xvu81iODF60umvMlsRvT0+W2PRDeaM8gwT9CZqWawsOsEYaQFoQYEmm57u7Q+75pxSOyOQ
 3ZMWkySfkMYraErYNQo94SU1zdwrK0T4kGgdI/32Gs783wSrQ3T49e91ARx2d8W3hAWb6Yi5qu
 Ak3b8gr55QTrgO1cxtqW04czVtvsz/tho896OXBWmLkUsGHaY5gmLg3i8rMn48g4FI0lXoa9HY
 do/ynF6og0i/boz65UKSZk9rZcdFJlcDR5RA3NB1orQ51TGcZPU/MKsQwy7HnvchhoKH+k6GD2
 8jU=
X-IronPort-AV: E=Sophos;i="5.70,372,1574092800"; 
   d="scan'208";a="130001452"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jan 2020 09:34:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QKtqW4zlZtdDTddDA7uQkK662DqIlkXudr/HKPzkaFgcN0gLel3g5/ZunmJnc9DoIWmqvZjJHvZApltoep/MVUe+A9zJ4TDXiXC16tCuVIaHPf8zy1G4xTA9+HVV36ya40Wb0bBS/9UlhP20lPYAhsF3hVvpk8inUT2LSG1eCo+qf85CHyCz9OPc0+7hVbjag9CEoNC5Rn8ZIcL3Y4FeJk5yY7LTN0g55WzYTXR/3VBPSbqKbDQGQUajWvNGxafczi7cAorQai5F7S6BpPmWWiP1txnAjTDvpE+UGa9tMa90DZ2abhk5GQKVNoIq927NjLwphM7cQuz/2BgioXZHFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx/aI63npyDiGtlFLr8Fcy/qPW228mC4zFbg9OVvy1A=;
 b=Zpz6IELI2KmfrqQP2F3SG28BUTPHWbmtFL1FNVw6Gw3kaJXKlSHHjQFBuEZkR+056xQlqCp98J0G4x+yCGyk3401UfSKRB7kSJGOzo3ILObf7OAKzqgwenWMD5vJgSnshphM9L6uFR97PQVwfdyAqxqbvJizjR31H3Ey0hSjWMbTdn5qgx7OYhzTwainP8uISgU8Vwo7CsGiX62veSMobgggGVBTEmla2wESNfKIBagFU0riAXmzdQbC+Bx6oyG4Eg9Ga1L1lMRWm2osVzbKCL2aoyHJHUYJ1i+nzd7YFZWZfIM9pe1T3bXdS4h/HbkvLcEr3p0ceIDWEZhYaTRZdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yx/aI63npyDiGtlFLr8Fcy/qPW228mC4zFbg9OVvy1A=;
 b=V3cOtPx2nVsPNdeNUtJQShhTl0WAdSXfQ1CpdOPvbMtKY0PnRvlGgMre2FLCOoqmT3+D0cY7KpPpmpbUNhoF3GkHkiF3LIvsQ18/0MbKwZZSSH/d4zU5KoRZvljFvqpPKYoiEMIMuMSfg/gwVB1NHkyAZimRIUoYlOqDLNel+HM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4952.namprd04.prod.outlook.com (52.135.234.81) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.22; Tue, 28 Jan 2020 01:34:52 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2665.025; Tue, 28 Jan 2020
 01:34:52 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
CC:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [PATCH v9 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v9 1/2] fs: New zonefs file system
Thread-Index: AQHV1RAutcHD/Pi+Kk6hD9a0Q+BomA==
Date:   Tue, 28 Jan 2020 01:34:52 +0000
Message-ID: <BYAPR04MB581681ADF3F2F02BBF6A1B20E70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <3021e46f-d30b-f6c5-b1fc-81206a7d034b@web.de>
 <BYAPR04MB5816FB9844937D8A86B52F8DE70A0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <CAHk-=whHZzyaRKu5WXTE7_mPaQPf-E-r=cZ+8YGVK5RPbzjt1g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1ea632c3-be70-45e7-196d-08d7a39245c8
x-ms-traffictypediagnostic: BYAPR04MB4952:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4952696FEC040E1280E81BABE70A0@BYAPR04MB4952.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 029651C7A1
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(136003)(376002)(346002)(366004)(199004)(189003)(4744005)(71200400001)(81166006)(6916009)(54906003)(81156014)(26005)(4326008)(2906002)(55016002)(5660300002)(9686003)(33656002)(86362001)(52536014)(478600001)(7696005)(64756008)(66556008)(66446008)(6506007)(91956017)(76116006)(186003)(8676002)(66476007)(53546011)(316002)(66946007)(8936002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4952;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n+lH207+eSmhzej6jReLE6JUzykj8hKgJp/TDxJBuzWh+aJMKy9Ik8Y7Zz5itZJEVXX4SyLJhx+gK68svyEaRbTl0lq3QWSlsyCFpezFumFurpn97iInqNPClT8f/K5MFASZupxoqRB56p4SqtU/a/9d3TsBTzk6nelXEvakaQHL08Hfb4/Bc3d/MlPF53PEP3HU8AWapSEf3cJXR+/7z7eZB4ZOp7FC2qEBenEERIHQstb7d3ishuG+g8QmOLXtWpewMn7KsfuiGT5aO9cyN7yjjWxKQThLIraSRU4el1j3Oi6Qi12Y8Wv6c33GZlSx+gsc5TZC8ThRdlira76LDYNdHtTuGqJkhYnpTdx92JwORriodGXbQybcCjKWdz8INghLiJyqLCelpaYElR8iAFyrlX644X5XC5gCESFoTviszYM0HKBwfhDHQ4AhpXbZ
x-ms-exchange-antispam-messagedata: Y5XMdSuraStxO/tamKpbMP/7PZs7A/Qy53KJvyDiWRvSNGZGXCJ3XdpefI3WfDCsIVvMgbFbdFzugXOz8mTONc1+Z8H1VfkICpHfsYRbAptUB//gHVnkCZqZ6+O/wC9aKWrqh63/4d8ZdcX/iIEF3g==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ea632c3-be70-45e7-196d-08d7a39245c8
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jan 2020 01:34:52.5609
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fsQogTn7cxZ2d2SlsykQtcmkhL57BDKq+p0ROfKMtfv4OE0doI00EBXovPc8QT3qSwaq5Gr9AJMgeZTpHpWMDA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4952
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/28 10:28, Linus Torvalds wrote:=0A=
> On Mon, Jan 27, 2020 at 5:26 PM Damien Le Moal <Damien.LeMoal@wdc.com> wr=
ote:=0A=
>>=0A=
>> Yes, good catch. Furthermore, since this array is used only in=0A=
>> zonefs_create_zgroup(), I moved its declaration on-stack in that functio=
n.=0A=
> =0A=
> What?=0A=
> =0A=
> Making it _local_ to that function makes sense, but not on stack.=0A=
> Please keep it "static const char *[]" so that it isn't copied onto=0A=
> the stack.=0A=
=0A=
Done. Thanks.=0A=
=0A=
> =0A=
>                Linus=0A=
> =0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
