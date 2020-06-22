Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BEB87203347
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgFVJ0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:26:48 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:58800 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbgFVJ0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:26:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592818007; x=1624354007;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Nl/Xa6LI1U89T3f9LQgugI2AR3tBLqknmvOWOFbcz2zi3D2jAvWXm86Y
   ilBgfcCpFjiC4UpcQskyvANcdk+H5p6grjJ51lKcH1pIb/LeADGzVN8Ql
   BQlVXOh+PH2Bq0l6YaSaDr59bJhfeEPG+fJZIdA0DIGzcUOeAAnOfE4ON
   8KB8gcGi1AUKjnPOJ7pQfSWVLhNPzZpVquJgAlcLTrUH8x9x3Vilao2DF
   AkE3NurJqZnOcPYjiUWH27sJJ+Rc2BV4nJNfJt7JqItkMG1kIPwyw6vtt
   2xVltimKPueghS99jKSTb8iU3w3ozQlqd84b1TBP4bvTokv69Qco76Agu
   Q==;
IronPort-SDR: GIKbmFDna5UH9Dr8CEPMkXWf0RSszTGM5QH5rJA1jSlHfdy4rkNEpqy4Tj7gylUr/NeMyI9VDj
 24o2IJTNMnUP7pUY4LSrzW4m9CZ/pVrX77qwUULK0BDjfqFNriQgHQgfT4+cSsF2/auIQ/sPBa
 NbmZkaXJr4PrY1ncJJaf2c1QWkRzu7O3fHsQXQr3x87PXnjDM5JYIiThU9PrlefJ9+iD29TjHK
 vIdggcZ92bJTOa+GRC3Z3a+wXRyp90mxX2XVcuEUJt64bLzk0KgouvQa+yEX5TOmZ46rPz70bb
 DAI=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="144915113"
Received: from mail-dm6nam10lp2108.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.108])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:26:47 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BdQpBxT1XEkz+Ievk1QlvGRQILnvUpr+Fu5wqQmWj6ONGFG8HzA8KptS21aka2ZnCZwc53jIUT4xT3F/A5imZmjwLct/hVYVCpGDKBMGKkz04uOq8j8RhSE2a36KuELA6INluvupHqFuxg1WMjSoPWXMfWTxbmzvvecRwGwq2pqBGnsQjd3godlOpjV74czHhVaxvBUc5GckixsL2TyV+EJqlGkb21eaZnaFUtdOGGJau3Oo02wV2rNRbztZxUxTvmydAJ4hp51kv3uNvqabd+XkEEt1vLuR9yNYe3c6oA4OABkjJBM0gwyZKYHSEtVYfm4fLn4tJbgbPHd735UhJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=dWi96nAE4x17ldFGXNPDPrygbgZH+nGeMjn1IOxVlqCAN/AiEenziBA6HmJBEegdvP4FE3ONgljOhJ3hSDTxBxEuCgFmLQrXfPFRE+3BHGG5c2xUmEHY2jQlph6H1ImFero93Iws7Uq80xTUEybOFNmdpF0wEoOAbhFwrdtax0qazIOUD+M3eMRonbayW7O7e4I2RmB0sDKA8SiM6YutJ6Pr0gU6Sx3GJt6tElvIE5AeCYQzrpRx6zjZhzsZVxccGZyALwrlMnmH8v4O8RW+1tbyIJiTdooFBEUmfpul4WlnYgAJbyJBpfHkYRbX1hqhJCKTjMAswZsqK9552NTDvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=iAXjozro3Jy2nwWvukpQfXKlGziXsdjVXI6Gezh5nCPUV85GHZtjBUEWhBkNMqX9Uvhu8dAaB0WnVRdpLRHckzATlw0XTbQ4wtfNM0FX5IE5+Lm6j8JfL3PdyzV7Vh8P3aMfEpKUZ2endvOSmkW4tqOTKX1vnyF4Rwir6enYg6U=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4047.namprd04.prod.outlook.com
 (2603:10b6:805:46::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:26:45 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:26:45 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] fs: remove the mount_bdev and kill_block_super
 stubs
Thread-Topic: [PATCH 05/10] fs: remove the mount_bdev and kill_block_super
 stubs
Thread-Index: AQHWRtLkhWU1VuDw00aWjCSARz8i0A==
Date:   Mon, 22 Jun 2020 09:26:45 +0000
Message-ID: <SN4PR0401MB3598841C9F547D589D9F684D9B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-6-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 74b7d4cc-be43-42b0-5c20-08d8168e61e6
x-ms-traffictypediagnostic: SN6PR04MB4047:
x-microsoft-antispam-prvs: <SN6PR04MB40476B03E8356388488640A89B970@SN6PR04MB4047.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: oUKESJyMKg4IgoYXQqz8LkYGMw9FL7LkUjPWsiym8sqGH6IchbLU7RA7PVP9pR0fanl8SXAUgCTA97T5dGVgwu4V1CyE7cI19Nqjw63molvoFCpaO0Wn1aEC9yunTOIFg9TEdwxwz5LxTYlgVKKMEB/YQVuacIBDrceybaanYLBhsN3uBhAnxtsskql7XXN5RZ8YcVseZzyUQdYs5rY6EVrUsCiNlDI8D7Fe/ypTlkz9O7xslO4gU0DnmGusIx2YnTyPBhuGdzLNEZV/NK/juOyPU2Sxlr0wk7S5oOxcz/WHI81nwQBPU6s9Z3DqfrvZAes+DYDL5f4bUVncrosXKw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(396003)(39860400002)(346002)(366004)(376002)(6506007)(186003)(86362001)(5660300002)(91956017)(66946007)(558084003)(19618925003)(76116006)(110136005)(66476007)(66556008)(64756008)(66446008)(478600001)(2906002)(4270600006)(52536014)(33656002)(54906003)(7696005)(4326008)(8676002)(55016002)(71200400001)(9686003)(316002)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: C8sJK1IAyfZbENFFhmPY0+OaUuGMUlrQtgerQzLh7glhL4YCpbZodsFx9cqrSF3J5rdDEyj1M9fE5i1/a/vdTC8V1Xb2f693dPdU1spXgrdu97pyH2YP0ZB1gqAmTLiVPqmqXKs+9uXjw8kQl1ukA0XjelOd6wsgsiapNpUY3gmp4wf7/N/HOaebvJaS1tMJhBMWzSR46wNyI7U6bMkj88y2MVJd8UgANLdFjZvurm6PnbBgJhvHWDwcseGcwAAAfl0deSbEK5Vt5TsZJa/TokUHzW3FBwfl7vD9UrM8NP+th5Aoq3xvQDbmo3jKmxqwQGFWuT3BrbIEuFMTj2wZIXL0N6X5pTOj4PXfpb762Ci6W93/1xXHJboOC1VrkMNQQv9pT1XXlXWvLmFHJpt53yO9BHtIWQ7C7nXpXzN5B1Z+wJz68wPHgo0el4uKbk/9yEEdUp2/KWudEephTrV0lXuWDXW1vnx1nzEc1Ye7VR0MSufpj9CXNlH6CAMUW5ycgV45AN7UP+d1XJA30wFLfBKAYTNUrt95B5z4rbeuw8+bv5Va9NvcTqeTUoM0WkqV
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b7d4cc-be43-42b0-5c20-08d8168e61e6
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:26:45.5541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1AiIlfhyRWprh+4LQPF8FVkeGZGarbGB3fIMwO11PJQRAviycPw/9KCrH0Jp6BtB5Z5WcWVvk2ugfTgzk+/6WgXoF33yN9OiwiIT26PclQY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4047
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
