Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E99CD1CFA63
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 18:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727099AbgELQSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 12:18:23 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:12006 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726287AbgELQSX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 12:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1589300302; x=1620836302;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qPumcoszRgOGF+v9vZLE8kW3uA40Xr24mpmhMN8k6OE=;
  b=aRZuroFUR82Sg2sb6H9Q3qhifINGEv0Gsqnrk5xsHspgHKQMuA9ge/R0
   rLQY6Zsq34ddGAQt0lcrZ7OyNHzAxWO53AcrrWB1kKgz3Mg1Dh5BKgrYV
   k89AAaKWyos7zOMCH8BL3dsJVSyzwgrBtyb7BshpqK8mlFM82ItVuPk1A
   yveki1tZ23FU3zrRlh1syzHFrgZqD8cYyU7pEm2fVeq/OBoiWH+u8GyW9
   KyGOz/MrRlWSjyevqpAoA3AtUKbAN/lgjQO9xthaO48LMGaRZ+nIAu4Zw
   85mzCBPu0BMRAsVBY26ljf0xtsjbiqW3ProF1J2QZWFyFgN9TATC+EmnN
   w==;
IronPort-SDR: mJPpW1pIqbTAUC5aU0Mw8ZQv3SsTjCOPdpiH8rJ7WmNtikFu+No7e4BprRE53ogh17jwXrjobF
 Q9KLEUBuT+z00NqG02hjGzH3cK3SnRjn7EhQCXQNlnjWNsXkJyOWj8scPV1k4d+1JtUyM3ZdWY
 ipjHhdANWiOj5hHwwwULt06o25X8UU3wiRelclYHE9LLDRkNMpu/VQzqrtNeqY6583cECOeaTk
 qCPXu+jipUMA9yQe7DyVPWOzNh6ZUHpbaVXbV7yW+DwuirwI3ecNAmGj+BpNW1s2AJq8L954dR
 Nmc=
X-IronPort-AV: E=Sophos;i="5.73,384,1583164800"; 
   d="scan'208";a="240207545"
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hgst.iphmx.com with ESMTP; 13 May 2020 00:18:21 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B01KX5ZqK7vWSyB3Au8KGeRW7wu0sVRojWjCoLNZq50wZmvk6Cfg2mlMpzwbvdA562f94Ygz6C/nx5CMk9p+1WloGDgTn0R6hjbVzj4R5sVBEGMcv4XKXaPOq3tq2Fxr7IEEPY00R8h+ZksEkIOB3OOyx5ODnVt8Jz8o52aD0eRoEbk8BIDj3LR4Wvfz8c5LTeZRbzCwaU4e/ZjvKZ+qhc4woRQQIZAkqI9UiYSa/A+U1HLumiKWm75bfvmfVNyggb5xwJ/2dZ38aWo1LxQcsziO0TgjtPwPDmOc4XMSOtz8KcUh6BGU5deXSOacrJIgDRANzFuNf1w5xtf2QBeGlg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2kt2/faP9o2u5G/ZjYio8BtDFsm1WxJJWNXSplfrlg=;
 b=K/aQSVNnTFeYCSxoEj4QSdTzjFz+ci8HAI/k/CRZMtBIgfS2/qE0bstdKdjeJx4t4K2gz7b7D3oj7ks1NE1L9CuIiD+3pW5w7s1fKc0A1Omj1OBnIE+WgHmXo3HJhdImFc9YtHRuw9Yea2PWtTkibT+qC4U/MSC4hReFHMEJNhpxW15lkHqLar2etdJ7+qxTml2PeD4LL2GxtVTkZsVDTHIrwSTjgfFlEexAX87aAhUCSl30i9717zru2+P+Tx9EYOZHWZm9CCN2ZhGYCNrI9nAF7nJqAHKQ04JXcdt8Cbl1JIKfQO+5hcWD/UkN+eHD1p7nD+QlQuraVSv1SxwEPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z2kt2/faP9o2u5G/ZjYio8BtDFsm1WxJJWNXSplfrlg=;
 b=ECMaLI4zJT8W2h6OFOuJsedMWFNyMlpcj7hmRCfYqgIvLEg2mqNbtPlNP1mRwanpI6fcvT8dxTjUI6782yntO4I6EIFyLFiQmOXkP9fQOyKDrVTmqxWPzDazbWV9mm837ErsI58SucJejLm9sut9ffHwGO5TJjJdWPXlBDe7DCo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3710.namprd04.prod.outlook.com
 (2603:10b6:803:43::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2979.27; Tue, 12 May
 2020 16:18:20 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2979.033; Tue, 12 May 2020
 16:18:19 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        "hch@infradead.org" <hch@infradead.org>
CC:     Jens Axboe <axboe@kernel.dk>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v11 00/10] Introduce Zone Append for writing to zoned
 block devices
Thread-Topic: [PATCH v11 00/10] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWKDsvWpidiX8hYEyMY94iZDcZOw==
Date:   Tue, 12 May 2020 16:18:19 +0000
Message-ID: <SN4PR0401MB3598F2AE584D163B222FE4D59BBE0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200512085554.26366-1-johannes.thumshirn@wdc.com>
 <20200512131748.GA15699@infradead.org> <yq14ksl2ldd.fsf@oracle.com>
 <20200512160410.GA22624@infradead.org> <yq1zhad169p.fsf@oracle.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: oracle.com; dkim=none (message not signed)
 header.d=none;oracle.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d0b5379a-878c-4de5-38f2-08d7f69015e3
x-ms-traffictypediagnostic: SN4PR0401MB3710:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB371095A987C0AD0A5241B2A89BBE0@SN4PR0401MB3710.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0401647B7F
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KU7NKSakogqeL/tOR0a/1+8mIUEiOqzhYbFQhRA7Alu+QXwtTaGboh/IvYxhX0bb75WLHq7xsdw4BJnvtq54fsIBFFKXnGgSPOdg4dMOZf+Bf9VNSRQFA1vZStI7F/c7iE8AM1LfKUhx5aFSGcIoAJxDZ7FLKtCXI72AJKlLRO4OLKfpImzmGcNcjaPycFwyBbz9h5Eh4ieuePp1EsHw1Jo/HUVNC2GNMxnn/uSyICOA+ClDvWphDOwXRNsPjZG5E6pNGeyOaBN5WuvvD5BRFoKFz8BIs5ZCKO4M0CCGO6lta1TZ8Efhec5Cfle8yL5TDSPzPS1Msb4qu4XObQAab7BKaTZppBq2OyjGWCSUWyu8qrKqwLnIEFQPFChNp9zZvxsBxgyxkyfmVKCWfXX3lEUHDknj/XYqLzBLpCQEvTE17KReNFFGO6d77yOhWGHOzvRf3pmpPDHiBojKR5Vm5gjt/9+Rds3gxv48Kgcd3pz3MEQVfteYGUjt5Nijb0ySB2EQULYRm/1BLILTEL2R/9N0gZOEBusszueXHvHWwsB+11NW8UvTb/LpTq7n/blbDUkjdMr68/68zIAmbU+OJnvSfrRy8owEB7JcfEtfMcM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(366004)(33430700001)(5660300002)(26005)(2906002)(186003)(4326008)(498600001)(86362001)(71200400001)(4744005)(8676002)(33656002)(8936002)(9686003)(76116006)(64756008)(91956017)(966005)(7696005)(66556008)(66476007)(66946007)(66446008)(53546011)(6506007)(52536014)(110136005)(54906003)(55016002)(33440700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: G15iezrnYpUVDyx1DcHTPw/uZeD1KB0rnxCclimBknoNFEZGWhAex5AKa3KykhK29O8R4Ka2EfWnCU98y8nBwqbm0rx534ks5iRttfAt7iDkWvlhpQepxcw9PoI1Qh54W+TMpBd6Ztfc7Fhua7gRO8Aziyd0YNuKBgCxItCzsr3XZ4wt5d7K0FtXQ4cfTGbynM0Uw3hFN6OSrcbslFVWGZ72PgW2KaR/4kuxiy/7Lx7i/tAKJReiok401dJQe18aLTiJhkyvARyRk10HdIXTqhzPx8JoIJoWXLd1f8NP/nKaXvOJAbllMU+UqHlEvbqw8S3nc3mOn/WkNfZS2nu9AqP4IzVexQOMskGs8fjLyErfkxx9G9x/T4YicO0GBktkrEK6REWEDbxKpcaDtGv41qrjFY1Smixb3MYToPsAydb7KlVUA4FO0VLa9c/zak3CUn5NW9hoimwEgH7QW41tJCnOiHZ4LglI7UIHv0mEzgUgovt/9/pGvVKgtwp4w1/v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0b5379a-878c-4de5-38f2-08d7f69015e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 May 2020 16:18:19.8061
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: pbALKJ9TKoLGj813THjxwwIdekjOMtfrqQuGy0Z8qCs3lFZt1agTHk8mkVvg7G7kbmxS/fBAYhuGShFC9+y/mjXWqVAcHyXhBYQj3l9IYF0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3710
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/05/2020 18:15, Martin K. Petersen wrote:=0A=
> =0A=
> Christoph,=0A=
> =0A=
>> Where is that series?  I don't remember any changes in that area.=0A=
> =0A=
> Haven't posted it yet. Still working on a few patches that address=0A=
> validating reported values for devices that change parameters in flight.=
=0A=
> =0A=
> The first part of the series is here:=0A=
> =0A=
> https://git.kernel.org/pub/scm/linux/kernel/git/mkp/linux.git/log/?h=3D5.=
8/sd-revalidate=0A=
> =0A=
=0A=
Just did a quick skim in the gitweb and I can't see anything that will clas=
h. So I think we're good.=0A=
