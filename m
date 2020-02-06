Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 47CD01543BD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Feb 2020 13:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbgBFMH2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 07:07:28 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:61418 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727138AbgBFMH2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 07:07:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580990848; x=1612526848;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=WunZK8bz5KBE/jnDaD2Fo7eHoTZnfpmceE2NIie/uKKR6IMTdGDV1+6a
   aDMZ6Qf1Awa8THvzKGD30EdDcW0Ign02G/RXH+uwYN2GjYnPTUJ0opr4u
   3FYtMEsgrPteOpE0t4MbLpfl/VlKlGj3qqRcS6EAMHiu02dUfsZ6K4Qbi
   n5DGKpSHKDcp+x5Myshz8eqEoNAI2MZAAs7igNhpVgiTwBpxZ4V9uMZvj
   TNf6NzZ13VtEZzXjbHk215R1dmNgq3cQVYdG2GPJBDIPqdBCIK2UI/hDk
   OAafglX81ag2MhLjI24EqhszIjKWD3MRaZnEljggtxj8ayrwdi1O5B+mj
   w==;
IronPort-SDR: ndYxqmGY1agmPxNGH26sUdgXhApvmgtHW8oxRpRIJ8cpo3rDMwO2fTJJKBGw4xp8dFs8UU2Hf5
 mczBKRXdkdFXQf2nYdSiGAGxhxORSytDNO7sMnK2Y9Rj9SdzioimoT0EbD/u8fCRGaLe6siq38
 iw9hd9OH5GOcaj5xYHoBTyarwg1jfS5CbD0aLODhjiTWMK/b/J971h1mKtE5IE05MzdlCSSJfk
 jinEP0gbjaiHfEwGJOplLv4owU0F278ozurjKDmdBqHBXkEqca45miwYOk3EHMjKb3geh3psH0
 GLg=
X-IronPort-AV: E=Sophos;i="5.70,409,1574092800"; 
   d="scan'208";a="130704911"
Received: from mail-co1nam11lp2173.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.173])
  by ob1.hgst.iphmx.com with ESMTP; 06 Feb 2020 20:07:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A3dVhb2OGRElncrMwWK5ezlqwTLO4c6Xpj3N84iZlOnpOXaHSn3MqmE5F3GF/zG7F8Q2bnprPVMQIjEnmLh7E7GNu3K1T5OcwwYt4UwpI+a7Gq+yz3Ubm4tINJBfhwVGR5vM5HMEfcDLYyMqOXqvdxCipftODER3IyEPZCuhlp34jfylfpsRtG3F1iDs6tdMlueiuylKcVJCF+jSi9tMRzE3xtF9qxePguUpkGGYEENI2laGwsB8XN3Bvq03066PKz2iC9Ste47qAdvSaBRaMrwUPMzD7GX+0z96HTZsaGt9O53/v7ykUpCy6PUWnOV4dJhA96dLGUbgS4pH7TN0mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=h+7tQv0o92qD47XvMubr5f5BIhBXzoeANGvKcvYKEYjRp8L1ZEg+JCth/FNCD5ozhofIpdpM40E4mNR9+UkQkrC70aKhInUYStAhHgF+mDTmAi+RibKDZjIq2chTLKL7vR8MbE5jcyRBoT9Q+58TroQhVE1W7hobXChQzvnqv1lCdRgR0HXjO+L9QhhHerWOolTcuxBcSGNxgONxuHm0H0yiXH5KAlZBXSkPY62K3TB/4czrgcxYwxt/+HBlm13eoyj9z/WoQdMU+mLf9gGBeKpYQ1AtXrGH9I9zDFWSA5vbKvSoEI4XUc5Br5GLMR2mtzZ0UT2Je35jFaAUMbElTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=c66fteN10MUvjw67IVTdvuNhaktV5Z1OzaD1ceiIJX1bfsrOEVuIgdDVsCuD8TwQYeiHjvkiocHuEn+w/qFmv3EkNS+moA3MPhx1LBxsbxNPQhhIi8ZKjm9TlsfA8jjZ9muocFnEAdc9EcqlMFDqOcf5NPDobZTXHfXGVIKAm18=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3597.namprd04.prod.outlook.com (10.167.129.146) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 12:07:23 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2686.036; Thu, 6 Feb 2020
 12:07:23 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 04/20] btrfs: introduce alloc_chunk_ctl
Thread-Topic: [PATCH 04/20] btrfs: introduce alloc_chunk_ctl
Thread-Index: AQHV3Npop+aEXp41RkKhDER0CRu/eA==
Date:   Thu, 6 Feb 2020 12:07:23 +0000
Message-ID: <SN4PR0401MB3598D86B743D30892960D1F09B1D0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200206104214.400857-1-naohiro.aota@wdc.com>
 <20200206104214.400857-5-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b605b7be-e7ea-49f6-1230-08d7aafd1fc0
x-ms-traffictypediagnostic: SN4PR0401MB3597:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35975EA926A2D97F84D65D349B1D0@SN4PR0401MB3597.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(136003)(396003)(376002)(366004)(189003)(199004)(52536014)(5660300002)(33656002)(19618925003)(8676002)(9686003)(86362001)(2906002)(71200400001)(4270600006)(81166006)(81156014)(8936002)(6506007)(7696005)(55016002)(26005)(558084003)(186003)(66446008)(66946007)(91956017)(66476007)(64756008)(66556008)(4326008)(478600001)(316002)(110136005)(54906003)(76116006);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3597;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 489XyRUvTU9baP+f4izufU+atgX7RPVtuHeVf02rXIM7jw3HZ2KZQhpURpzVslttdSog3H+n6mm4+CffRzm2JOmF5JoBg7ZXveXh5k5F49mNsh2o6aMF/K8yzDzDFlPWXvwwhmb436Ol/XO7/l9j3fyDZArpMO+Wmje6Z47d//Lmko7oAS+8GeLKgfT1tovBLL9NwUDEKdesOfeeq7fm7I43qUJ3L5RPFtR5t2p2CocNCWC/1gNIAjL2uluDhpEdR2Mxr/B8Qjj8RhpXfszeexYsKETYhA4L7yJS+fXN2z4WNFYKrP4YpHLl7rzTKA2F9sPnXfU/wBdYqoDcH632wiRZpRF1ckEI4IajXUgRDW04ZEg1O55Pp7/kC5PfFNLWcCk7yZjQop71pDdMEwsyobMegYLyKsqR0Ut8IQOAJ0tzLT/Hhwu/DoIoo9WmH5PL
x-ms-exchange-antispam-messagedata: ZcQxpbYdkAPJpuN7hhkCG/j4Dj9mvon4otnxcm11iIXtYSP0BHAD8sEw63RK4ZrS9v5IiJh52ptgnG/P8b241jrTLlGd4U4h2SNLqEbrQFfAGLoGAwULKublmnVNkUGQ29/SIefBC9eXK2nzLmv+tg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b605b7be-e7ea-49f6-1230-08d7aafd1fc0
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 12:07:23.1064
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0kqYj5aS0LrqcoPr1jcFLbErtf7yDWPPYrLYI1LOaOYe9jw4r6tfZoewNzj9oDWTzdUxTsmTQJW2qGlVnTOWGQU13TeFCYSvoMtt1sk4+SU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3597
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
