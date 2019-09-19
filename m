Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 85AC9B8351
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:28:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392882AbfISV2S (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:28:18 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:51372 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392876AbfISV2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:28:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568928515; x=1600464515;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=tdhrqiTHaEkVRO5Y+etqQL64dYnkqwZd+mAkBV2KyII=;
  b=Id5Ha/EzJX7mdEZHHoawSNfKyoRIRb9V5USG7EpAMJS0aXzSfvOFfrkj
   /sIoSZB+2pxt3wFc2BRLug13utgPP1zn40CdPtIhBCYG3zJVf2CsF9ifD
   HrcKoXh4w4DWIKlfZnLOR8RjBRdibU/1Lv70Kz6TDrOPQ13rQ78uMUikr
   NHEb0UiHzbdsNZTutSQcc13/iEfpQK5kcW0TCQB3fFHFldjC5gJqOKDb/
   TVGXOoCFaoG0kP0w7vb01ksf1PRRJIBFrH39AwdYwd4uCBbzfUFUs5BHe
   /fGMa93h+rqclYZy+CsVoj+1oqpRstRNxD8wnVId2m6EC0Lt/7Ia6uVxe
   A==;
IronPort-SDR: kkohOL0/R7xjQUfVyai6purYPao9dhrF5Xs5pW/L/5cMbHPLbGVJUweO0NlMjThmn6TkOya6lI
 427O3qdqlVQw2bLYeozV2wVzTKSqvNlAaVxQMz840sNRTXFbn10uPTArUVxx4RQVG9i2QJfkQY
 wU+EDPzOPkW2oVuNTKUpcQ4Dj6oLz3zC491TxVNvjXm8cX7c7q+nxw2zwzPdmoPTG5kQT/Mlu3
 gHZJE0yGHhla5Oz/LynBXdc23kPuy/ZWkaSkEQWJrIMO+T4WdS25HK9YcUZIpj+8cAFCVQDI9G
 aOI=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; 
   d="scan'208";a="219485356"
Received: from mail-sn1nam04lp2050.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.50])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 05:28:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=e1fYXHEmOLRPSl6lpIcIFjFi4kfs2LzsXHUE6B6BrzbZbl4qBVJNQdzv5+FZZszOeFdImEGghBs7e2S42qZYt1dRzXR7uAL1/vJalRZ6LBEu++fuxUODeYhtn9eIugQhsDmpuMKci405p3XwoFbvPR3aSnCUKdjfb8SYX/XZTERuWV9Pv5dgbKhJSg5szfkBK6IwsqrX5zmCzJKtCDqIpP7ZlMqPxjZ5geX/hpSkmMAb6dxl5b1Uo+Frqc5/GeYAi1ZMAMeyWqYB8pDdHNjTpI0WEcHeLdd1xiuu4tDNsREt6wCQ4cBa2VMRsUiM+LvnaWnTNiP5UvW4oUbOm7iZOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JNNDAOA09ApBbEWsBYaBGTglkNK7oOVsgoAkRhdut8=;
 b=nuaGBqQyPR/hJvTA08GzzakSKUVG+JCuxYefF3Uh3VApH8koUtkbUMlzlWcNnV83EfMCnqQ/reW7RNSpWeaAFvwdbhgVlDJb8+7Tgi4cZwbS1bGzVcUze+QC2wZC3k03sPZiY8WRpijZYG/+yLGLkObDNxXTVPx/MVOykRvJjAyVF3RbEoiOWGNLTOOfi1SGJf+969762I2N+yJboAmiyFX7cs/u54z0C3rZp4NgfITeQVI9fo1OUC22ldaOZnA2CyuoV08ux1TJqNz9QNAhy9Wj8yP2MLWfbMBpkc8hmWKQMJK1g8odHj3wdt61qJKgJWT+vwblqx9kcNT6exd/rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/JNNDAOA09ApBbEWsBYaBGTglkNK7oOVsgoAkRhdut8=;
 b=RASmN7fG2KFAoMhM18WE9lcuv7k1AHYhrf6MWeBX5taBhdGeDLSZsNIcxMa6kPS255W4BFcjyj2PCl+s46xG8wQ88ViDXHven7MjihLOIGaz2M5z06A50rsNVwmiVMH2P68V3EmSRqzhfIm7oyz1YJPfnDUipHig/oaaaQ1z0tc=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5975.namprd04.prod.outlook.com (20.178.232.215) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.17; Thu, 19 Sep 2019 21:28:16 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 21:28:16 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Thread-Topic: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Thread-Index: AQHVbwApqraejWyP+EqCoHaEIePvTQ==
Date:   Thu, 19 Sep 2019 21:28:16 +0000
Message-ID: <BYAPR04MB58169EE2BC3346CF6CC3C61BE7890@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190919153704.GK2229799@magnolia>
 <BYAPR04MB581608DF1FDE1FDC24BD94C6E7890@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190919170804.GB1646@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 78496aa3-a846-479f-cf41-08d73d48489f
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5975;
x-ms-traffictypediagnostic: BYAPR04MB5975:
x-microsoft-antispam-prvs: <BYAPR04MB5975E3DD737ED34D2C0D8E4CE7890@BYAPR04MB5975.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(366004)(346002)(396003)(136003)(39860400002)(54094003)(199004)(189003)(86362001)(74316002)(7696005)(91956017)(2906002)(76176011)(76116006)(66946007)(6436002)(9686003)(316002)(55016002)(54906003)(229853002)(99286004)(6246003)(305945005)(14444005)(256004)(66476007)(4744005)(6916009)(7736002)(81156014)(66556008)(14454004)(5660300002)(476003)(478600001)(8936002)(4326008)(53546011)(64756008)(81166006)(66066001)(6116002)(3846002)(6506007)(186003)(8676002)(33656002)(25786009)(486006)(26005)(71200400001)(71190400001)(102836004)(66446008)(446003)(52536014);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5975;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: LndqjsUbw2jd0rvVil6s0z1zG8Xp3TespK6npIMTNVKEVsPgADbwbXraU6FIFKXbtbnugPTWoD1GSt9gZbTYwAb7HBN9nbLxvVSIvYnxIT2MUJMTcZA3wJcHOKzucbcHegqTHImrZU751GU0X9nXKyYRcgS0ODpyf4r6tMlQJovjOiw8DYA5gROGM114cP2A3Sc8tPaY2KgIZ0w2fDDrQalst5+eiAKbiiDGWA2mX/h5rrqYsT27fsGMQ6x0SH5Fq50HwGVZzp9JXafyriezI2BgggucenSpjLyoPIH69JtCfLREw5Sp2n8czsHLPJmWkmB3ly/6exdeln0N7Ph4o4KYQE8CGyXHgQr3qfiHj6ohxnQ2st2uhdFdHbIXI6bOfVK5tuPYoDlNGaJ1KF+fe0SKNvNMTosv2xLTlZZYvUA=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78496aa3-a846-479f-cf41-08d73d48489f
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 21:28:16.1157
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQ0Ld7dNlDmyJMT0aE1me6H6B76MHT9GYc78eHfDRvn0jhoBcBuG2uLAD2Drs8yu68zNUTsaEwoHQQjuFJeT6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5975
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/19 19:08, Christoph Hellwig wrote:=0A=
> On Thu, Sep 19, 2019 at 04:19:37PM +0000, Damien Le Moal wrote:=0A=
>> OK. Will do, but traveling this week so I will not be able to test until=
 next week.=0A=
> =0A=
> Which suggests zonefs won't make it for 5.4, right?  At that point=0A=
=0A=
Yes, Linus did not accept zonefs for 5.4. He requested that I first get mor=
e=0A=
comments about it, adding lkml in the loop to increase the reach over the m=
ore=0A=
limited attendance of linux-xfs and linux-fsdevel lists. The other request =
is to=0A=
repost early in the 5.4 cycle and get zonefs into linux-next to go through =
more=0A=
build tests too.=0A=
=0A=
> I wonder if we should defer the whole generic iomap writeback thing=0A=
> to 5.5 entirely.  The whole idea of having two copies of the code always=
=0A=
> scared me, even more so given that 5.4 is slated to be a long term=0A=
> stable release.=0A=
> =0A=
> So maybe just do the trivial typo + end_io cleanups for Linus this=0A=
> merge window?=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
