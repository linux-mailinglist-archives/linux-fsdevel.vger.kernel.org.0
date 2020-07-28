Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 443AB2309D1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 14:18:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgG1MSW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 08:18:22 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:9576 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728846AbgG1MSV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1595938701; x=1627474701;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=l0kRjycEZhiyXiP4rEfFmnR8DdQ1o9bEmEM3lVywktpciPkaUSpQsIm8
   lariAnS+ytpEQ4/eE3aA7zADJLOIxVuFC1585XOCTqm4kNxRTCt9eyuix
   eO2Fp8lMn5UHh47H7oToY6M/LqIfyCexQZNt/sDQQMzMwc4Ba/UvqN8xp
   CxRTGrF1HNeMLzr5FRZLZ4z8p/6sJKnBc+5sFvOdWGV8eLCc83AOSMhpX
   198Dl/9NTxCRQZqAiyvh1JzSVw6SWQk53rpHNcFRYhXK2FLx9iaf0XSXv
   6+7lAfplJLFub0GHb/rYXmnxywNZ8Bc5MU+S5elL6lvL3aPmkDlbdhqOC
   g==;
IronPort-SDR: GQjXte0hlT0tXxQ38flYOsr36ZIvdKLhES81dKmxyGWO3+RpYM7pj3gaFA2m9r/3AicMMAG4w1
 qrlTB0Kdz2dKSfVoJq9MypsRf0Fy+sOmk85K8pz/NCrBIBDQuta+PfpUCvNedTHtNAqxXg+Ocl
 BtM5kM5UjCMVNxAaPlM6Rw9WwF/3xNbs+GcY+/fWDmN9SXwUYNLYrNqk1rmLamHFQMnFL5eohp
 boqTbQ5OPVN3/4a+bfPRGd8eUZFZemoYMB00+pnYZwD+k3WZCi5fp93iv50MxpWogus5JsI2tr
 nII=
X-IronPort-AV: E=Sophos;i="5.75,406,1589212800"; 
   d="scan'208";a="252886390"
Received: from mail-mw2nam12lp2044.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.44])
  by ob1.hgst.iphmx.com with ESMTP; 28 Jul 2020 20:18:19 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cmSlNSgehQMUEWfODH7QO7Zd3qR/SrV/MwN4+CIRyhjECISbP6ksF2ivupg1/ZJ2aIDWTamWvHL6MHV8Js5zMFXXcPNNY6U2v1Tqyd6VlPPSgGmyend6erg5KW3e0nzoAuhDfnVrBEN7KCEN1ffLSP2O2mYCymROnt88V5qthtYPEEocvfGosA4S3qSwdBYo0e8Nan6JFtNs1o5Wr+9hcLdpfTThXfNZppCGf1x75LHSxD76JHsqX6augDs9hB38mnMhds3IazfNhI+xLudSct3smCkIcKYe6mqtStTmUJFdjiLTDwc/f7gkfNfdpHGUHoyRdLS1TuiTg4EWJ3YgwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dNf2SyjoyRdCjGQmXZ4oYwBL22QtuDkY2Oa2XgTA7CS3VEgpDsybzgrrimNPtzZA3/8ryyL2IImWftYI7rbm+8UHqOFEjdhFjyhW0hhzjIr8sbn+z8ls/nt9Ctzgt41drKkk6P6OzMZXRioGHqfPaongM5bfLPCtMzfT9hnZaYcZIl139SOcZLL9qz6EzBI8Sik5PebnI1NRt2m2Bi4d410BSDNf9+59ug755LHEhOn5flQvGPE71j3Cqd2iaa47kvyXy317zA89q90PQAuP/aWBw3+n5Qe2WS0vAo/InYj537S5kzLNN4lBrnTICp4JmasznmXYlW8uAQpz6xtWsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=if2E/t3flnnBCzC6GbKinqQ8jpDLhuEzTasUy9HbV0RPH0C91NsTj105cvESjCKRTTz/lYQrLC2iKUAjmK29ZpiOWd/75GnFuSAf1HEM2Ig+vy8C305iRhF1EtqTwKlS0zWvLTvfOi7QUefJYuCAyfSrWhjJ4LP7u7Mt65ibI5k=
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com (2603:10b6:4:7e::15)
 by DM6PR04MB5867.namprd04.prod.outlook.com (2603:10b6:5:16d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3216.25; Tue, 28 Jul
 2020 12:18:19 +0000
Received: from DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573]) by DM5PR0401MB3591.namprd04.prod.outlook.com
 ([fe80::c862:9cd5:689a:8573%5]) with mapi id 15.20.3216.033; Tue, 28 Jul 2020
 12:18:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Song Liu <song@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
        Richard Weinberger <richard@nod.at>,
        Minchan Kim <minchan@kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>
Subject: Re: [PATCH 05/14] md: update the optimal I/O size on reshape
Thread-Topic: [PATCH 05/14] md: update the optimal I/O size on reshape
Thread-Index: AQHWYYzroAeRYAy/EUeF2DDEDmAMKg==
Date:   Tue, 28 Jul 2020 12:18:18 +0000
Message-ID: <DM5PR0401MB3591D718B1F2A18968A0CF629B730@DM5PR0401MB3591.namprd04.prod.outlook.com>
References: <20200724073313.138789-1-hch@lst.de>
 <20200724073313.138789-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1eb635b5-ca1b-444f-4d2f-08d832f0501c
x-ms-traffictypediagnostic: DM6PR04MB5867:
x-microsoft-antispam-prvs: <DM6PR04MB5867D9D0566DEFA6EF9047AD9B730@DM6PR04MB5867.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: WLHN3+N4v1g8zhYkBF1/bx4c72IFUW94C55fZjDRTDUItb2ZHmPWK6nyvoku/TwpanPssrTX767+1GIBA6ibmRQejpBE8UlgZ9iCI1RKbX84i2XFS52sxXW5B+c03DGagtDuLKrMVnu8PhALCv6d3ddTmT84VtCKhLADfPSvcw8xBJmdZa5tdSbP1O2PoHMN5Or+S9inFmClJBXBz2oIFJcmtoKVMZsgkDUunV8Wz8USgX3lWogOW6rzwF05oGVkmwug0DXhAWePWLTu1/66G8Icni+0anRoiN6MktMGgdNSFfcmt8277hli+aujFyZpdjNpdsYHNsgZs6Kqjjn7Ig==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0401MB3591.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(346002)(136003)(39860400002)(376002)(366004)(396003)(4326008)(8936002)(8676002)(52536014)(55016002)(478600001)(9686003)(7416002)(5660300002)(4270600006)(66556008)(66476007)(91956017)(76116006)(6506007)(66946007)(71200400001)(186003)(33656002)(2906002)(86362001)(54906003)(316002)(19618925003)(558084003)(66446008)(64756008)(110136005)(26005)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: afJN6LmRwdvpuQNdxiDxNwpBb9/cxQY/w4tMeo8UbsT8uSCVwhyPjaiJgCMejADXoDgrzR2HeD7DTeqX5t0TC4iIrZgwfvJqS3gZjW1zdfzDww6r2YRrE4R8hkz0OQGcUWMm12qAbbsGaT0rrmbzvyLA7NTiUoLqTPKaY5EFKoxM26obAy0WuT7/hzPOrwzx+I61vBTJWyoCZskBCUxA3g8f6l3SVml9Qq4XkXryjvhZZ21IZ+Tl4T2LbNOOJmWZIo+3vRtMvHLr9HehnAICMlqxYsZvbtl5qvxkBAr2wON7gNbGL84eQVbSVbBRygRaoUy+EfLxtUC95s3BaGHmEX2lffM7SyWc56epVlAIkvgvqbkYaQ6YR3HfFy1DzFWzqCZxmH47nl0lBUVC++t/5Y+5wRuEP5yodn5dI0Ooh9dMvojyPMy8/hzjGn6t/jNiIKf22jxfr2y+f0FZzKjRLL6VTjR0gs2jRZ38gXROlCjgN6IV2zW+BjN+8eo7nAc1
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0401MB3591.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1eb635b5-ca1b-444f-4d2f-08d832f0501c
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jul 2020 12:18:18.9707
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fk8kaoOTFl+K4yvFvuu5MyJrIF8mjo157erAEKhJ76iAImDL1j8Yz/Fl6MlL9/udOgW7T5sT71pkJJgyW+TJ2Lqfyjg78R0KzN/6e+o1RqI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB5867
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
