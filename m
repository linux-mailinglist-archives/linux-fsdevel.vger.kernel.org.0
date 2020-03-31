Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5E8331999DF
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Mar 2020 17:37:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730617AbgCaPhZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Mar 2020 11:37:25 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:48351 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727703AbgCaPhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Mar 2020 11:37:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1585669057; x=1617205057;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=l1JZLlYlQM+LfA0sU+avRDubSNNoLI3yE/4diRSZo74=;
  b=ZevmLLHdAU0zvES9DdKSq12+Ofvtk4iFRODvW07L8nvQfDdR6zBOsO5P
   FJgj6Zu3IemEYpIco5arOL7gztHOGbL3PDUxeYYHse4nN+A3Ncbx/VoLg
   Ij7TWvghHiP9c08viHK6slbAfJ6EYIehNwBmzmVoQHvPRFOybzH3DqKik
   NhrEP4pjAq7MESCStcVtudMYW3JigN6Fqu8JLE+u82U1QLYhKyaMaCk82
   w6223H9gHN7H9vtt46zolx5Ap8so8iDNRHMnJKBlqULfcsMZII1gYSJ8v
   m4KU8GaMBzaDbSC/VZJ6cSPfYeEdU//LI+y+8qoZAjo/3mxhOrfaO3JwQ
   g==;
IronPort-SDR: NK77ScrXXdp/KjiTHuNaGKwyi7xs2Ef2jsOVQJwNW5BjR1mvS07SG/jgg3ZMJKojtqvXBqn2d7
 kY3pw2oLgqnPqmsAm8ZmIF3ZMZw3zgryaF5v5ibORlnRiQvGYayl6UiJWPjis9KKfV3OZpdDkW
 cWVOhJSF8rE/igCChuj5VXUUiNpvoodNqsM1ygemRFIYLXQhH+3IR8YEQlZqNbZ8gbtwkgyQLE
 fKslOuIg6oK5CI6g34ulDGCpIZfeFI2MQRJ3Vsf6gy8L6Jr/IC5jIx2SwqQNcK47mz8+C316j5
 1GA=
X-IronPort-AV: E=Sophos;i="5.72,328,1580745600"; 
   d="scan'208";a="236345087"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 31 Mar 2020 23:36:05 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gh0uoWx9wU7ynQxFujrTgA08SYT/ywwbSsVSTTDjQGwyacyPoIboA5accJ6GcTu/tKOSmKuCQFhhaU9C3fj8p/Tpe6MWXwYRhEw1a5YvW95HBmmUipWq2IRvcOPKnfv0Q8gGCUycf4Mn8i8AHYawSauF56BGdvmJeq/RCenGNZd88D1Jz/tT3F3JPfKislCqsYrE5jI1E5l03GZhMZoQ7/0EUxkDsblwUhBko+zlAvITlhKVp7zaTaexoySfmGiSWj88OMED4wHztqtuK5WUaYpGF6czM8APrMSv0cB0PWL8eOUTjPqBJu4U0/Utnj6lxrEBBdCvNnQLfyMUXquY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1JZLlYlQM+LfA0sU+avRDubSNNoLI3yE/4diRSZo74=;
 b=mOKf0JaW1nfJIi+A+COVefbOW8ofLUov0T9sGF/VULqKIRxXRQ0coQpZkDAST6emTmzYri+B2LLeL4oB9vs2OIR2F5rieQsfgKaQ8aAVX6IfWEsPzIrhqPzs/N0fOlOBXRjevIHSgGp4u79BQsPLhopjNHYpoH9pjTqNFaemfFZa30n01rYl28LN8o258D4D0FW2Tn1/akWx0J7xDRW/uz3DsMMOVBK8VdfndReCCgh0zmXywdyAR/b4jkZMyC8XtKniOr0KFmd9qnV5EzJgDXtLOq2/OseKtwOfstnmi6EYT4TAjNhRtdS6GIlcDgP0tWq5pMVOcuWLOpB4WafssQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l1JZLlYlQM+LfA0sU+avRDubSNNoLI3yE/4diRSZo74=;
 b=eYixsITaDxHDjYE8WIFR0SUutawgBLIRUrNYoXcfGlITUUtgEh7eqr5I2vXhiFpex4870CQRyRK6KoVSNdIa8XdlmUyhu2H2iS6ib9xkxJ2pAy4ATy64gihZYb5qNWvr6ahWva/Z9r9M6Q7Vp0oDU7mcPhLMs46LCaVDPXiuGWg=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2856.19; Tue, 31 Mar
 2020 15:35:37 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2856.019; Tue, 31 Mar 2020
 15:35:37 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v3 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Topic: [PATCH v3 02/10] block: Introduce REQ_OP_ZONE_APPEND
Thread-Index: AQHWBFfQotoH4NJ6H0WQq9clRZuQ5w==
Date:   Tue, 31 Mar 2020 15:35:37 +0000
Message-ID: <SN4PR0401MB3598942843F94886422759989BC80@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200327165012.34443-1-johannes.thumshirn@wdc.com>
 <20200327165012.34443-3-johannes.thumshirn@wdc.com>
 <20200331152317.GB30875@redsun51.ssa.fujisawa.hgst.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6f6c8f99-3150-460e-acf8-08d7d5892942
x-ms-traffictypediagnostic: SN4PR0401MB3598:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB3598BFA94C3AC80EFB4549009BC80@SN4PR0401MB3598.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0359162B6D
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(376002)(346002)(136003)(86362001)(33656002)(9686003)(71200400001)(6506007)(4744005)(54906003)(52536014)(4326008)(55016002)(76116006)(81156014)(316002)(64756008)(8936002)(81166006)(53546011)(5660300002)(478600001)(6916009)(66476007)(7696005)(66946007)(66556008)(8676002)(26005)(2906002)(91956017)(186003)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GKOL5QSSqilLCcXCcpsckSuiNGKZP7fLlf3Yh3ZOvECnzIFoOJJ5VmD10qFohEMogucribm9tGS5W1Ysh0wH8ZmLqU6za0yzwFlITeXkJqDKl4vf97gtF9ZI5SJy22+yPl8EN7dRaX6mjCtCB09J2BUJIiamfE6jX3jMjQ59aFO7d7pEmiyOzthZzB0SKsKRT5cVdckymGPk2h3aejCd+xA7QoRfSvXig9kmpnpvcCX8jZP0ThwiKYfajz++PTsx3Peysyh/E5nYN0aRfmMuGkW03/2ZiPgJ4X19dCYDduz7YphCgmNfBEjyoUJwc4Jt1+taCW+B1UVEL7qJbanKtZW7fZHnrpcZmrCv0PVt7Nts6yRH3BvVjRG4ZwZkXRp2hysIXiPPqFR+75UfLCJlBZaR6LwbVeUQEXjwpk2gmfx/m9+8nbZwg29awR9l6/ws
x-ms-exchange-antispam-messagedata: 0fZM+ldLgS37hD4YPrYWECkPrGI4HYy4zs22eToFzowxO3oVBjEu18Wd+Xyfsi5C1IlB5DEKFtKFT+QAB/A7g0QfwJzH0e5ZHJ0LkpaILutrFoC4TAt85o1euCV0OlNLdjJEZV4O7LZP3EQNTzaKww==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f6c8f99-3150-460e-acf8-08d7d5892942
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2020 15:35:37.4006
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: eAADsSbzEOn6Keg1MAk9Cl3Z8fn98PYkZJkT7Ocnpl/vkDDI2NLmKJPoxnfIcNrFg5YeJRnyg9h/dyl0eGzrdB3RKlImuFznIDNT8rk1WlU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3598
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 31/03/2020 17:23, Keith Busch wrote:=0A=
> The generic block layer doesn't set chunk_sectors until after this,=0A=
> so unless the driver happened to set it earlier, this check would fail.=
=0A=
> We don't want to rely on the driver doing this, so I'll fix it up for=0A=
> the next version.=0A=
=0A=
I'll take care of this, it's a change I made to the patch.=0A=
