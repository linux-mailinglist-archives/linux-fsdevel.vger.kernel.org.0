Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDA21A7925
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Apr 2020 13:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438976AbgDNLJy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Apr 2020 07:09:54 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25469 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729730AbgDNLJq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Apr 2020 07:09:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1586862586; x=1618398586;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=im2rE4sZ9k+GluKB1ZzgSn9RzG0GvfS5Wvnuo+9qWqs=;
  b=XifhPlGDehM/tjE5s3feth516mblrtHu3B7ufsineK5CKJwYfHoYuU/+
   mVVsDIMdfeCu9Toxe60vx7qt3EzuzLRBhYVyDoQ8l8O2Qlc4LD7uXt6Rs
   62iVi15j6NVGV8kHS0cBiWCPZWVRmq+ccTRacz4Arb9yLPF/SKdagH3Ao
   uJOjfKCnBQR5yrz3+AhvyqIbN23iNBMzzMrPN3racf+BnkOmH++aiAIAl
   GXB/oo/8h5UnxjBs2W6IMxTI9F1Zeq/WmXOj5F+lrNqOjoMiCIAd/Z0DB
   7DmTiDWqzw5EaXyV1xg85qFlgAHevVtpopQot0iljBfjN3Ov0FT/gItYR
   A==;
IronPort-SDR: +UFMcTVXYgl5ENz1pGKBVQ4zlMwPT1OuOucnn1nFGVHaMaOeZZ+lp4r0s4XKdq45GycJr0OoY8
 pNNfMCgD/VqeaIwKv1jm0ka2+Dfw34ahC+K3MGLD2Kt1DMs5/rXvY3R4J4HK2QMnjjSv+oL0fn
 iiXu4w0q2vcnajeIA5yFiUTj/SMqTqXP8VOaFPyi+Q8u2r+3Ld8zU32Ejqvu/vqpiRPKPq0nvF
 s+ibGMewGqoVmg0Tk36AAvcnEiQQYAg1MLD4/JCMj9c6AY/qHczh2a5MkQOUlVhhdAjbJiEZM0
 nzE=
X-IronPort-AV: E=Sophos;i="5.72,382,1580745600"; 
   d="scan'208";a="135605049"
Received: from mail-bl2nam02lp2056.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.56])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2020 19:09:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RyCD/Dshju70WCztpq6pQXcnrUU6mJhGtfJgMl8i6JSQaQMSHERJ7PF2dCq816n1euDo2qkx3LlywSFiK6VUmN94MH4BeYJKAQiz4WrYIJNAvAUpBvW/ousquj5jiuMW6bKubnOpeg1iSQty5Izsz2c+YPtaeV60m3ndECufB1mtzuZJuyHuXvsioaPU63UAZb0Ew5FfCw540jBEWuQWMLgiWO3sBSPcMzhvo8cPpc1NPgVPc2C5EQSpNC2wgYD8juwgut9pLBHcJefoCGMTTFiE1WcE9Xb4z5ed41y6Xd2WfkQyKlY4NkglSGOlIrTT1924/D7MgDmjihXGilBOHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX/JqwYQ976caw8DRc7pT+rUHYZQhAXFHx2YBn2r2hk=;
 b=V7t3bMQMNl+gtSf17LhJWYIJYTo4EcQFjI2/62xK+GefjYJZR61ElTjJVRGP9rEO+dMMFKwmwchgw+IG/EiptMAfUhEDWh4uNFwsbV4rzCm0GuEtHeMC4JEBPIETiwZgTgFyJRKpjREmxGMj98dQqehjO6pjaaPaO6SUwbYjZfcgIDCtQf31hu131qXfSoejP/sPq/vu1seg7icoJ/tEOtacH6TgosVTjFkfVMqgU0mqOkCMlGGlYLvcW706ZB5Hdkcati02RVM6G5O5D3C+9bahLgBu1Pk93M8xYhuYqB20WjpUI+fdEHCL87SZcfvvPCiDkfM2gEMGZInK5WTDMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX/JqwYQ976caw8DRc7pT+rUHYZQhAXFHx2YBn2r2hk=;
 b=dSyHYeehExIk08PHaSAnbMjgkbjrqlAYU5p7baAAN2CxdmK3qF3Bhp5Smr+Kr/53HhqIF8mo49swszIWVwZ05Izzl4t/QyntvcKHX7mrzySHOxYXE37887O6JTXkN1ISqdILdJ3ZGDLD9+cIsKeWoUTjTX0WXOLDM9BIiWfusGU=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3679.namprd04.prod.outlook.com
 (2603:10b6:803:46::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Tue, 14 Apr
 2020 11:09:41 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2900.028; Tue, 14 Apr 2020
 11:09:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Topic: [PATCH v5 07/10] scsi: sd_zbc: emulate ZONE_APPEND commands
Thread-Index: AQHWDo9/7/TsxA+1IEecB4cF8olDQw==
Date:   Tue, 14 Apr 2020 11:09:41 +0000
Message-ID: <SN4PR0401MB3598DD3A892162A3FADB06CD9BDA0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200409165352.2126-1-johannes.thumshirn@wdc.com>
 <20200409165352.2126-8-johannes.thumshirn@wdc.com>
 <20200410061822.GB4791@infradead.org> <20200410063855.GC4791@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 16963a83-c987-478a-bf5c-08d7e0645483
x-ms-traffictypediagnostic: SN4PR0401MB3679:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB36790ED07C1A1849664EA8C29BDA0@SN4PR0401MB3679.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0373D94D15
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(366004)(396003)(39860400002)(346002)(76116006)(91956017)(6916009)(8676002)(86362001)(316002)(478600001)(26005)(4326008)(81156014)(53546011)(66556008)(71200400001)(64756008)(66446008)(8936002)(7696005)(66946007)(33656002)(54906003)(66476007)(6506007)(9686003)(5660300002)(52536014)(186003)(2906002)(55016002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: vaqJSgt1T792vZ24x8aQ3uGbS7y3pv+ABBZmTZWPZsQ6QSBu2rRcBdOXMr06x5Q5R0QbdItilKixlEu7zZkicJHqCxaMuiuNv7kzowzpCpY3s/L7fTtDAGCMPGN59FVwy/6UdvvQ0fkHksd8eQrqxtYspuIt3GzX/LUdNqX9pbr1NzizO3or1NCjT6ugUg2rGrd45vT1XIDY9fpEQMfnPGgxPSbOTOudLMfrCu1fuvW06JJoMpDAUingqJ5T12WdvqgGKEm+GJ3yZ9mQMYgsfrOPHs61K4L31CXld6jUd7uaMYOTDfygiuuFl962UrMgv0MsjVYxjc8P3qXDHkwtwnsxaVkqLZiLo+KnRgR1ZbgylfNK/BlTF7yNvje12cJx++mCh0UZnRr+IxGNSfQ3Pf0qPEkxWB5wWWSsnpiyHwq73Yn92i/SrQMpejGrEU2w
x-ms-exchange-antispam-messagedata: SEMNtNTMYHF0bUCI+T7gE4Jv5RpxKBiZ6Sv239DjxI6mqLMNR4ofSJqPAhlHCZtrxmoYfOntahTmFFNw60CwfMBRPMtd9FsUr5a+x9yCWGrpH7M3yLhckUEcM9yv4kKSZ8tvmbLkXEKzE12PvMrDXw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16963a83-c987-478a-bf5c-08d7e0645483
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2020 11:09:41.4356
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uRssO4/AF2l5TVyVjnNLGo36wfj2RxfN7/iTLmhh5N8su2azlY/mL1paO9oJXc40wNZWb6WWzE5722h56tbK+PmyDuHjigF3apQVXwQ2X7s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3679
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/04/2020 08:39, Christoph Hellwig wrote:=0A=
> Looking more the situation seems even worse.  If scsi_mq_prep_fn=0A=
> isn't successfull we never seem to free the sgtables, even for fatal=0A=
> errors.  So I think we need a real bug fix here in front of the series=0A=
=0A=
If I'm not missing something all that needs to be done to fix it is:=0A=
=0A=
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c=0A=
index 4724002627cd..5e6165246f77 100644=0A=
--- a/drivers/scsi/scsi_lib.c=0A=
+++ b/drivers/scsi/scsi_lib.c=0A=
@@ -1191,6 +1191,7 @@ static blk_status_t scsi_setup_cmnd(struct =0A=
scsi_device *sdev,=0A=
                 struct request *req)=0A=
  {=0A=
         struct scsi_cmnd *cmd =3D blk_mq_rq_to_pdu(req);=0A=
+       blk_status_t ret;=0A=
=0A=
         if (!blk_rq_bytes(req))=0A=
                 cmd->sc_data_direction =3D DMA_NONE;=0A=
@@ -1200,9 +1201,14 @@ static blk_status_t scsi_setup_cmnd(struct =0A=
scsi_device *sdev,=0A=
                 cmd->sc_data_direction =3D DMA_FROM_DEVICE;=0A=
=0A=
         if (blk_rq_is_scsi(req))=0A=
-               return scsi_setup_scsi_cmnd(sdev, req);=0A=
+               ret =3D scsi_setup_scsi_cmnd(sdev, req);=0A=
         else=0A=
-               return scsi_setup_fs_cmnd(sdev, req);=0A=
+               ret =3D scsi_setup_fs_cmnd(sdev, req);=0A=
+=0A=
+       if (ret !=3D BLK_STS_OK)=0A=
+               scsi_free_sgtables(cmd);=0A=
+=0A=
+       return ret;=0A=
  }=0A=
=0A=
  static blk_status_t=0A=
=0A=
=0A=
Theoretically it's enough to catch errors from scsi_setup_fs_cmnd() as =0A=
scsi_setup_scsi_cmnd() either fails scsi_init_io() which means no =0A=
sgtables are allocated or returns BLK_STS_OK.=0A=
=0A=
But for the sake of symmetry and defensive programming I think we can =0A=
also check the return of scsi_setup_scsi_cmnd(). I've checked =0A=
scsi_free_sgtables() and __sg_free_table() and they're double-free safe.=0A=
=0A=
Thoughts?=0A=
