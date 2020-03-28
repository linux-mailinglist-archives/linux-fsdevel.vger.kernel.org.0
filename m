Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB481966A1
	for <lists+linux-fsdevel@lfdr.de>; Sat, 28 Mar 2020 15:17:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727149AbgC1ORZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 28 Mar 2020 10:17:25 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:50119 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726937AbgC1ORZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 28 Mar 2020 10:17:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585405045; x=1616941045;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=moUPt29vKzoJQj/rg2s2bT3a8sVhdjHv+d/Lrs9QYP8=;
  b=JaugMWq0ac/rh+Pxuh7XYqL5yAGKBKKWPeG8yl0LSrMqxnMaqOdlaKjw
   6xTFqTQ4vdQhosXUtOeWzfGB6aE5mpyNyb2geteYLyhIashQkIDvZAMX/
   oFxmxBf+pAb4/slgzMl+ceS7gJjNUNSbWhbBPXoEp9xuBMJsnHUwfQsaG
   dN9FK2WVcoBnejlAASYyEndVPUU/ezwZALPSg8jHvaiI9govRTGJZBI92
   SZg8oO7sa8kwr8O31z9Dqww98lpi88aWeFb9pV8ESY4GuwM0rctbViQml
   anBsluThcnHbP1R/iusF/Dzg6Uwxupswtt+ZpAfYmqKR0Yw49EPhNC3No
   A==;
IronPort-SDR: BfZiQ93okK6fFDPc+1Y6MZAmD8Z6njC0u0uc649lOssYgxiqcFBxPcTTUv+t27SsMkVZSHuPvT
 6NP7c196w/fspM0MTsyZTAmB+1+6P+rgVO7o0UrQtKBBGUf4E7KOH2gWHESgs30zAJcexWsEa6
 nShRkRfajC+rUMczdPWKMu/QbAJECEul2pc4RjPjE1EYhP9nXdcqN2jn+Fnw3NoZEMedp5fL3C
 5j9Vczv+B3h5nIQYDVpJ/Ax5Q/AK0S9br0e2kdokpCbcRb2kcn1VxeQIeKjrX0MOtAEeuLAbpm
 2Aw=
X-IronPort-AV: E=Sophos;i="5.72,316,1580745600"; 
   d="scan'208";a="134189774"
Received: from mail-bn8nam11lp2171.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.171])
  by ob1.hgst.iphmx.com with ESMTP; 28 Mar 2020 22:17:23 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QYhW/VrD4CLfSR5mB3RuqZvUQckUVS7OeZfRO++Euw6DGoudLg7vgwUXsAJxTsn2urSBJoWoP4v4eFJUGkhbtbHtP8BqqpciJqtK3vQTgaOgIUmkRffmWObA7NykkQPINFdp+Bt0ejQ4YXxxhSO6klALf0toVTb1pV3midbxyQ1uxKwb2iXhQSO7/AQLf1Pv+uE/xeV+TTWe/RgcGDe6ZkUPiKUQJ5KI6thJSGvnCW9Q6Du2eKtrRbFVpX1fi446gdUuqNIrpKXMXJRmvvG8mXt76PdeuCp75yi4jbEsPb4QakjPWhce8/P9QitWjyKPaO1YgnFQSDf5v2ju0YyLbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moUPt29vKzoJQj/rg2s2bT3a8sVhdjHv+d/Lrs9QYP8=;
 b=oYbFVAjiXcdmmZUR2rFNQYoIuu1frmDExvVlR7dIvD/jOkHE5xa5nKPP99nCTtE+S9dtVv+X0TpBBrr+hIxAEngW8WC9HSzAKjYdJscaEsBr/c3+9j4C+FxkCbZ+mUHhK0DVgBSBPz+n4p9YrLnde4MaK62z4Tq768LuHiCJqx7/EIKzB3A2n1lAbThR//UKInY9rMg0h/s4wLnqHxAwpAhrjagiwagk7PPdRTtpIY1B4Oaa+iawfQSuw1+PoV6YI4ZzwI2jQw5DjVRgc5LXneZAwZcZ7XF5bVN0pEF9FjD77eduVPWAf5nyCWdpI7mc0sFpZ1GU7bntKfrPAWz4mw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moUPt29vKzoJQj/rg2s2bT3a8sVhdjHv+d/Lrs9QYP8=;
 b=fyKib4/UjF3cZVFQT4vMKCYbt4eRELpNPezdS1FZIElgA72H+dibz0f4AINg+3qKhOIxmoTpoHzxSgkodqdWiU/7t1L4yMfvykAu4nOMtMP7r7UenyrJYuJd/Z9Zal0D0XOvn9Y8ZrWwZrqyfDLE8i/rEZ+js+Zjz5TLjANvAQw=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3662.namprd04.prod.outlook.com
 (2603:10b6:803:47::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.20; Sat, 28 Mar
 2020 14:17:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2856.019; Sat, 28 Mar 2020
 14:17:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v3 08/10] null_blk: Support REQ_OP_ZONE_APPEND
Thread-Index: AQHWBFfX7h71lczrakCHx9Pfk27Rsw==
Date:   Sat, 28 Mar 2020 14:17:21 +0000
Message-ID: <SN4PR0401MB359808CCDB0B685D4A0A5E979BCD0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-9-johannes.thumshirn@wdc.com>
 <20200327172656.GB21347@infradead.org>
 <CO2PR04MB2343547B8748378050855B2CE7CD0@CO2PR04MB2343.namprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.221.17]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 30b113bd-bdb5-4fb2-35d4-08d7d322bb04
x-ms-traffictypediagnostic: SN4PR0401MB3662:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36624E4B8659690305CCB2BE9BCD0@SN4PR0401MB3662.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 03569407CC
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(91956017)(4744005)(5660300002)(54906003)(186003)(26005)(71200400001)(4326008)(6506007)(76116006)(86362001)(2906002)(8676002)(66476007)(66556008)(7696005)(53546011)(64756008)(478600001)(66946007)(110136005)(66446008)(9686003)(81156014)(52536014)(81166006)(8936002)(316002)(33656002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: C9EoDjeez11zOFob4meHOLwCnK6kKVfiys2dQaMnaJaKpKYbmLiF48bP2AZK8cVxSX3rad+IdfAbowC9PkgiC4Fz0aPNwgNfMcz2KnfN2kU0NS118kD1clKuxEubjh0YXCuar/OEFiR7H/31eFyFcbILtZsCXTfGb9IfCGKlWJ/kr38M2Ow3MzxQdPXVLjBKLaEBb/48pkHGlL6ujpTZaIz9IKFTIEzS31dJm1MpE3PVwpiYEtL42+2VGXzw16IfmWwq9fkjpPJ9U1V1d5fd1dsxMWltKpyRo9LSO270FCMNbSYtyGaXhWOEYHfseIIlg9YJt0E6NuKlV8BnTQkM3bYJrJJhfLewrSa04pE9o/rgLXFOQpv2lO0rtb1KnMttdL5OazbuNN5N0KdCBbZB/WfTbF2CZZOl+uovAnvHsYzOy8rKc5e3SLEC31b1+YLW
x-ms-exchange-antispam-messagedata: nNAX/sR96H12exey/SUG87QOp4NqdSnKKrXt0Xu6KhFlm2GOLVT2tUc2qvM/B7/s0IdEM0At6OEmTsVaQ62Ttm1tU7EUIKT5f350Nkx/RHioFZTsaNc0DCNrcwEluif9cXCNHaplqFT3Mq50+e/CNQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30b113bd-bdb5-4fb2-35d4-08d7d322bb04
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Mar 2020 14:17:21.4679
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oxa8MHqTqtzoKILD4ayvbx1XRq7p2uH1hN4WLv9wrd5q3Bt8EZLwmWgFPDKfaUigmAJ4WMqOrjbezjTnEFuj6nhPVNysoFVSKUbJ7Mp0rEw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3662
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 28/03/2020 09:51, Damien Le Moal wrote:=0A=
[...]=0A=
> Johannes,=0A=
> =0A=
> If you agree, I will send a patch separately for the move of null_handle_=
zoned()=0A=
> before the memcopy. While at it, I think I could also take patch 7 from t=
his=0A=
> series and send it together with the reset all cleanup using req flag. Th=
at will=0A=
> make a mini series for cleaning & fixing null blk.=0A=
=0A=
Sure no problem.=0A=
