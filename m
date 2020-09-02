Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3F8725AEB5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgIBPXn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 11:23:43 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:58635 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726882AbgIBPWU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 11:22:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599060140; x=1630596140;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=luUVjbH/oE02nz3zecX/hUElaWOmE+pIJRTqM2MUX+hISdafsdkpYAX/
   ZTf8JcDUzUbl6WiLiSvIGX928+56eeNdqKVx+iVS4sL/bAwoo0SzTzJnm
   +OrVQiHGP9X8ZLHgdKdbY9JsEbqW3+hZrkx9jfaOk2B612lfOBrsgJg1h
   AlOjXOH/+i456HOor4e8/L13H8CtqVioTGJUZeYfTzoLpYIfp6vIC3XLF
   JSf7fI/8E+jQ8Q8h6w1Aj7rOykF8KpSYayj8pjuoMY1IiwC+dP92hRb4l
   kRhA0qXrtwPf/W4y5NjCG+PW/aPecGD75fV7cjF6Ct2haxDq1+rrhoTXk
   g==;
IronPort-SDR: ksc7Me5CSCc2Al+RzAE6MN+ZcV8tezZU41YUWxSoFUeDsTtpdggo2XgKRontR0drUG00dQHWQx
 7PdK4YWmkF+TwdC/DCvyqQa/7WJyccEwHH24cXEpJUrQc9WKmQhC8t2b2J2iq6lVlsX+ySqKK7
 i0JoKquSFCKWm3Ha0ryGbGXQcUBT8atD19A0KeVPFx1No2NtBCoH6dpx2z3DA7wJEWDT74YO1U
 eryrWEOw/K3FBM2AIPQKQUkYJQcqrH7JZPw8iIxbwieRZXZMsdR2HDRhnuEu6OeDEny0YzmrwS
 ISY=
X-IronPort-AV: E=Sophos;i="5.76,383,1592841600"; 
   d="scan'208";a="147640762"
Received: from mail-bn7nam10lp2102.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.102])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 23:22:06 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6Gp4r1dTsAEdg7xMd0/JSF6jrlRJntBSAXjPDIhFjnAzWpPyDIY4SAk2Tj5YsXd6gQZ8nAPOq/8Bz1NGRh4zCEUNhNwCXRZEOY0zzviv08rizuOv0W5BX2y3De+8dCMt8+SobrmLreMmJznAfnIN5t2H5J/+fZf8FXrF1zO/VMekirjX94HTde5OYMw1lowJ9x//maqPLTdTfn6umIgY1x5S5S9zys8Lm7K2Aq6VlYxneaF04DOuhI5/47SLAxcL2Ml6JlHBxCiUcwqSigInTUi7nx/siz1perYhIeFTCUZsOEuizDINVw9YHeYAm+LovvoLkD0eOCjLh/qql4amA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=Tzaj5FtFpACDNAISVAi/3ZaUOd1JG5vxQOMeaGMgojxhZY1u0PVliJVScV5Jxv9Xj4nHTBAnHUzHrVnai6aBLDbhIc3GfPr0A4KBaGcNH8dHGkvkU/s/zv6oEbG63d/ibO6ERxxYAdTkfmj5GMrbYtWN64MrCmviEh65PE6fm46LjDaLHErKIzzibpRMhFS2ASGLi+8Z2Avp3kkRJLKjBlFsAj68h8agO7Eu0tuCpntX45pY8+yyDgpWBTXWHByf0yyLfcIvIoprRJH1GdZEglruzSZigsXSqPsDC00iUs8ievnUKNWL3aLJkEel4VMI5VLLEVPUAB/b9rVTQCQLTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=PjFFXYLgoCQaGiL+G0IwGwzMB0MG7BVHpqXSVGUydH0nNPDzI3LRvzIG5fDjEz3jeh4wdSMBRT3exew4hQRfMl5Bm2SYHoOan8gmZRVQr+7WLxwlUmTBFNpRM7i4N1wGpQcXPgvACHJkG6wMKeTEJh8yNToZLzGnIPrDqDSWZxM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3965.namprd04.prod.outlook.com
 (2603:10b6:805:44::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.24; Wed, 2 Sep
 2020 15:22:05 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 15:22:04 +0000
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
Subject: Re: [PATCH 03/19] ataflop: use bdev_check_media_change
Thread-Topic: [PATCH 03/19] ataflop: use bdev_check_media_change
Thread-Index: AQHWgTfWW1JB13GLDU2oidsJA6dYmg==
Date:   Wed, 2 Sep 2020 15:22:04 +0000
Message-ID: <SN4PR0401MB3598B2453E6DF1B8AC20099D9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200902141218.212614-1-hch@lst.de>
 <20200902141218.212614-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:1584:4722:fd5f:b30e]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: b169709b-2872-4cbb-7e4b-08d84f53f2f5
x-ms-traffictypediagnostic: SN6PR04MB3965:
x-microsoft-antispam-prvs: <SN6PR04MB3965D672BBE6457FDD70D3A19B2F0@SN6PR04MB3965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NHcY2AHQ2NqBSiMpuF6601tNHK9jL9EDlqj5yy+KMZ3pHDS8qoxTf+p2RnqufHNhHPjdRYO98m7yqq3HYawArlwW2uF66wSDtY6H8ziqtil2lSYs1wV7t2v7zCJSWtkGm/WBrjIYod2vqoDELWulSGs8oWnkUNwoNjeErhTluuzfPTsvRRhXRw+U6gVGHhH3wRJN3d5U8LgTBwGzqhskBJd7nZ9bAGlIAn8CJJaZVJ6yflfgupNowE2WBR1hQbagO6hG+WqJ2SLlXa9Dm3IblZecAqsth9fK8et7TML3MJSnsd42DVhQaQtTZ3daKYe+vHWtb9krPLdwaaoeAc1xNA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(376002)(396003)(39850400004)(136003)(366004)(86362001)(66946007)(66556008)(7416002)(19618925003)(66476007)(6506007)(186003)(64756008)(66446008)(558084003)(7696005)(91956017)(2906002)(76116006)(4326008)(4270600006)(33656002)(478600001)(55016002)(8936002)(52536014)(316002)(110136005)(71200400001)(54906003)(8676002)(5660300002)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: 8EmnxAsFBW1nLK2GxB6MpZXpIYOdEml7PoW2B1llR6WlzE5ROl/RSKEG1I/BHAGgeb8IqEAr0HNlDvMrNlUU9IYCw6AQiBBnkd5RR+XWvW8GSQj7VuhCise2epAZrjEqJIO7Lq10YMiOGWsxwDpkBBZTCd01PlTZY224JsbV1rkuDBATqIligRZr2NCmNYPjVj+b1raslWSd+PTpyds7nDZ6wJijvT3I8GwO4i5NZhuYzcPMNEodLqJ9XFN8ySMXD4Cxef3adIohEXcO15bfQpq9zUPp0rVMjoscI1rfCb5DY6vkJmw0zxAyQJ+N6OcGLExk5VFtkdBSLCgiMBHD3Ai1mRBdoAyr512x7E3rouLv7RIOkKxZ7gURYU32Bm1qzDZH1BkOVy8OrI97ANghe4x9Fv01njv/2ev8HfgmsuFUelDNPuYJ/QRJP3PVeri1GX5ZN5Yft4YcojibCe/4kZAGSQcbU7k//2gOhzVKiI/gQNq4ZBB0XpAkUhmLb2LYGc6Jf0O2HF9dTotD+fDguStidPuxLkrhk8dAY/XxTbdlo4Jq+KonGwYWd6IIZhhxyWWptW+qcwBFqKfxaT90QpAMvTjcScgD3D3JTZ20dEtoLRCay+JzKKQJfugNaHirVpEjUZRqbtsvr1PFoaTFyQN5cTKbMQsphnZlt+iMFfsC2skZVkhcbPtjR15gsqmCSAAIkkeFsr71l4Taqj5hvg==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b169709b-2872-4cbb-7e4b-08d84f53f2f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 15:22:04.8730
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RDz/pfPysvdUX0/QWPSeSp8mqptdkmDfazHD5J0bP8ekyEyL5oYClRuYgnDrCFy26i7vWMSUaA2GMsUmjn1b6wR94hzo6uXfjI1GJzL7k70=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3965
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
