Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ABF8125B02B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728244AbgIBPv4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:51:56 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:62031 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726814AbgIBPvu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:51:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599061922; x=1630597922;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=sA6eCQiqN4QuwrqpfUMCbxqbEOKPooXIfMoI4UBpptw=;
  b=jY1lb04tJAkuIJVsRs4wChwKDHw/OaW7qQzUFvVl5ZqHbqqv05QBajNZ
   NPxsiJcsfXz4YX6GGpm4KUIfr18cwgiOme6Lm/81J1JzLsGerhAIo3eRu
   dZpXVV29khnh+GbYRGxv2EM7PU9Rz6RytcByICoLVztOLDpF0PecZ4Lij
   7uTkxJM3nkl8c8UBb8VEsiF5LKlYILmS3GZauOOmccsYRvgxXm239ZAPy
   +9BFe4TPL7A5Rc/R9l/TjR5pogldMDs3BDkmogz9Xq5Ot7jha46K4ltSi
   mENklwbHpf0BEbv9HdMWOO71mAMXtLXcHNw6rLLmtofKaQurvzj7zYY+8
   g==;
IronPort-SDR: 74mR8BPa0l5EikaSTJ0sTDmtgChBJuCYzVIoRhxDtLJ+4kgoCDR5nh7ijIPaqGBk7l5kQv06I8
 D6ov40juxwlUfR+6GdUxGFO4eZJQBPjzYRKQJ5xiuV/ijxf0EDVokJOrr+zo8n+JUtXDX8TSw9
 /FzmB8wPRgbJt0cIYsPSQR9SHIN+VRbdVAhCWYRdAua6hf+FYpnDDXQlixfEGqs1ma1k0itUpJ
 zaBnpOOB56WWgY8dWbUJcE7rtHmtHPuR2tAUd1axDVAHpiwWLICB4J6ZaHekpmjU5gQ8LS9Q0P
 5O0=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="249683427"
Received: from mail-mw2nam10lp2101.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.101])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:51:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g1VqPgvAr+0O7WGjxD2bnMfFjsPqYXdCeQJI08n2CyH6vbWirrKNl/FJMXqjcmEsF0XQ4voXem5xDLshG0GtLkFdqbSlJ/yjdbhQs806AkO+aSSuHqpMTF01NTsYfdDwc4HWthJUKfg2VByZyfMB4Sn1V9ZVmH69naaIg8IiPPxjW8G1e8cMdEpFIa1iTye6t5U0ZXs5G4BCb+cNB/mOIKwZe+Ps2R6rI4Uml/ObyImtBU9PW4on+mR9P0U4NBNvJ7HbROto+ugiGeACYFnz1MYZ7HqvQiQCo63q/i9dwTooDz+hpeCsApqtyrN2pf33k1pAFgAo/Klpf4/iJDONsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U612zDgy+EUQwYnOwdUX9DSBUJDcp8QSWwHP+TSPeJk=;
 b=ehADTdrgcKcREra4gNghMolBHO0z9M5mALTK1Ax8HbYfGrv5O35h28Oj1W+wrpKZAtDhYKjenG2lgIWhaRFO50OmNi7mPqFvgtOpFv/9IR9/BsVOMgc+ECc6NSBomL2zOj++KOzV6xAxnWBScMwa5pgC+2CZmlsUgvjKBbCc1CdDCEeyn1up9pFraGFeLlLsS2Y0nJ0AIDVuA/w+UcrrIhWJSft0654dRcYKjTaYEQd2yvdnVsllDsf6qW8yIbRfzVoJuIrQJCH0Kxb3jsRzLoFIs/VRV8j0zVpn6gewkbdmFs3A1q5YGoXdbjmpExqTETZGFUUFumXALio2UCEQcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U612zDgy+EUQwYnOwdUX9DSBUJDcp8QSWwHP+TSPeJk=;
 b=qQdBvhlIMQCjOlAqGYKypH4p1EaPy4IctvLYZdxmqcuTFRelEfUP2Bax0teEQYX0g1LMuaP56liqxG+n+zWh3HH1BIxX8tkL8ncX9LZrFqZnaTDCfPP3DtaqRSzYPYZmJf3lxtm7bl3BCbgr7ReqXFDGX77Tv8P6lS0MQr9Fy8U=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3886.namprd04.prod.outlook.com
 (2603:10b6:805:44::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.21; Wed, 2 Sep
 2020 15:51:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:51:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Denis Efremov <efremov@linux.com>, Tim Waugh <tim@cyberelk.net>,
        Michal Simek <michal.simek@xilinx.com>,
        Borislav Petkov <bp@alien8.de>,
        "David S. Miller" <davem@davemloft.net>,
        Song Liu <song@kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Finn Thain <fthain@telegraphics.com.au>,
        Michael Schmitz <schmitzmic@gmail.com>,
        "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 16/19] sd: use bdev_check_media_change
Thread-Topic: [PATCH 16/19] sd: use bdev_check_media_change
Thread-Index: AQHWgTRM37m0yDEcsEWsI3h7LeZKxQ==
Date:   Wed, 2 Sep 2020 15:51:45 +0000
Message-ID: <SN4PR0401MB3598BA93CEFEE08E8F898B429B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-17-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 6ae089e9-35dd-4247-72b0-08d84f581878
x-ms-traffictypediagnostic: SN6PR04MB3886:
x-microsoft-antispam-prvs: <SN6PR04MB388677B35C0A1533393216079B2F0@SN6PR04MB3886.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:962;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MjO+ZOqa41UR5hP56t2X9W/edlwFdxyr0szpuBePQLyMuTGIzb246LzNq1I2j4V6b7jykYKrk7ASQkF2K6cpdjqxd/MGBrXG5FEsAZVC5xJt8LIu83zJyBidkuEZoc0IZZ4o8nel0c1POu5iHg6jXlkIegaH2zufCMEX5oJX9DCYUdDn8Tb6UjqYWWSk/TwOIBFb/3tpxkmBaK7EWFxKoLi8dCHRbVXL75+HIwLbQi8mUf9fExbjw4NA8DoZoat2kQqh1QJElKJfHW3Zq8gh+Zjh6iUxK9nTLgq+ol4k34nkEYXq9ma7SHDcah65A1Khbv3C2sA2sJDuC5n7fWKvpQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(136003)(376002)(346002)(396003)(39850400004)(33656002)(8936002)(9686003)(7416002)(52536014)(71200400001)(4326008)(53546011)(6506007)(186003)(5660300002)(55016002)(8676002)(7696005)(83380400001)(66446008)(316002)(558084003)(2906002)(478600001)(64756008)(66476007)(54906003)(66946007)(86362001)(66556008)(110136005)(91956017)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 3Jd5xbEQcRal9B2wxPL1R88OCyv0hVSWkIRSrUQNZSCs8H5c7MgzZ2ZBduC3qwnl02g/E9RkawpoBfrdvlLgbc4PUUskkj6s3tlPDKyUJ81kGDEqxEaNmZTjj9va2jSWSNOC43ZjrsjHehbbF5q7cfYXAUw5LTMLqxXdJMwseSREn7H39nnmvGEGoHbnqWGgHRj/OVdO6W3+Bn/r8k+32Ax797YkuasCVjiQXNYOBWWrpI1/f6j/+fyNmEluSu6CZuLK487t5P+/6YGq7QqoVQTEuNe4BUVewC9Dxj6qFBP7rLlBgN/Xnor4CAdzkE0fPplF4B2NwNcHmNYK8tMayZZfYXc624H8V2hmiSY1PBCAH1cIT+6DGvuyitKmHS8vWYXT7eCAVK5h3miKkmd8OJgXt8Oq9HTSb356TTu+N2DDAhQuc87EUuimK+FypNssJ/bhZ4Peqz+EJdpf8eAFZ7/kB547dGiNO2WdJpc18prdOzlcvebUtU3AB+s8Qo1NiwaxSpQNWPgKUUcEbUemQslJxeFdwbIqZcmZ3RqKsi5KabhG5x3JN3HQGgBTGlJpTjGabqmwrMQeZB/ZOfDQmNzs568h5GULjKsStt2tPhzxZ1uqgi+QRzrEmWH/WLf46G/QOb1OadcYW4gwz0irkVPl2X9SlMQYyZvh+AQMKSwEL3OdliLjDDdh0bBF/9CKNh9JbwYiuo2hcXYdxadjqw==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ae089e9-35dd-4247-72b0-08d84f581878
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:51:45.7509
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 08tCYd1WPyTbVPbDeZ98u0QXvOFgTVKMIhsC1TIoRKTp2Tk2EKUPGs14JtM/DeqK4yCMmxgtZkU/KmN8jxex0mrAihRrVk4qFKZEBYBZVEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3886
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 02/09/2020 16:21, Christoph Hellwig wrote:=0A=
> call cd_revalidate_disk manually.  As sd also calls sd_revalidate_disk=0A=
        ^~ sd_revalidate_disk=0A=
=0A=
Otherwise,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
