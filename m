Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F6FF20330C
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:13:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgFVJNg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:13:36 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:56143 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726417AbgFVJNf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:13:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592817215; x=1624353215;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=Ar12fiHuffRjjjvTshYvvyqYs4aZvIEHmtbMdUhtHFJnaz4+GtAF1pkk
   dTZu86ybhWtGuA3n96Ezu0zj0hLGnhsS10uDLBuUlGJXNZYFZyeB1vRyS
   YhZaxklLDlF1cKKQQKQebDqSuVKkBzwA3E2b8dxC1XHfQ351ymsh8wY7t
   gfJ0z/9Q4xWTN0agcCZACl6BMX+/nAxhWxg92CnXviCTvOzPRZNBmhlaQ
   puxBoVZSGwGhd2Gv5lhb6SyUSPmJB7aMHEZ46cLN6ujaFs1ArtUvGdbZM
   wbOjHHFJkj6pwKVqJuMXQ1oqXs7gc5XlqWkkfkMbNVSJk4l7vRmBQicCt
   g==;
IronPort-SDR: RrGvQU8q5IGBu6OfzlsLJQQGO5UBH8VfLqulGZGwKNy3F/8ZtyZZWjdhcqfv1seUnd+4sZl1+N
 fNJHZ/Hxq0iC4PsrzMmQwhzWwCEzrPScoyJP8kqp+JIR0PiH9VSNYpYy2QRmUNGvcFSIGdyu3X
 Iy7JgQNtfmHK8vJWBt/hMUQ7ucIRPUarJerXjVfA694B1glzuYuuW2MNOnuu7dikmgnTxb7ma1
 hh8p7hnccA9DI2KubCBP5V+k4VzUlhbS5SoCmZC43M7J5IVg1AlwIZdA8bzTvr5fvUxefQCH+3
 Dlg=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="144914296"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:13:34 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYgklLXCzcoLo2S12il7TrYZ3ZnnppfsLke0HCDh8K7dScHA7W66kvFYPnvadM+82cHMb1ZBaxrQtG6jP0sbP3p5WNvpQDJBVL4NZPrrMI4PdbqZo0scUJWKe97tzTzgcuCeFJSNX1DWsd9NRtYRSGQux5hRR0gQmtZzpFxoOvYBxA3+lhJ6Lw3WLEoKqHZwCEzEYBQuUEWr1NEc5yPGHy2crIOC5FuRpFBQcyVjZWQ2W/UaRoJu8pQUoGMKAAMWXLXBSSLG/VHW3JdZ4tDwa75yb5QA9Y8vYCZVmIJASPt8DjqwWm75qyBl9yqyiunuBzygrDbJV3bnyoHcq6wnAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=YhVepdjy9Qvs3DtYp0vnW93kyPE3np69pZmwkIhwHV453F112o34Llns5oc24M/L8Fa0aJwkgeW1hRGZQKrPSNQx7bRbAAdeQVvhq+jzPyj1uKxt1aseIAGE/dtyDzFaFiaCkxMB0MAM/P29OJJEjORorNLlgqYwfCMeInImULWrtP35SNXP31CML1NakbrQsjfpP0TDyxer1ePmklhtU5jMzn6Zl7rfy0u7OMFtSgb44URxh4hmnU9+HqHBtCBxvENItWt5kjVh8R2PMNISMtNvreUZvKXSwnt3051WDNCaEJEixKB1sSelxBMIiavSLNNU/8TuEhkbwOist3enUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=CcAdmpiLTYnajJr+jrR4SxIsukBn27H1K3ylcURULAA7phfMVLds2GkG8Oj/ksbzvKvg14pmqeijqBfzVLo2NV/9nvy5EJ2hNRk/X9E5ekaPmGykZg4cqLRqzu+JwEgZFtffM1bXJvXA99rejDbabL5YiwONqjUtcmnl986L1RY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:13:33 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:13:33 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 04/10] fs: remove the HAVE_UNLOCKED_IOCTL and
 HAVE_COMPAT_IOCTL defines
Thread-Topic: [PATCH 04/10] fs: remove the HAVE_UNLOCKED_IOCTL and
 HAVE_COMPAT_IOCTL defines
Thread-Index: AQHWRtLk07J/z97FM0KhM1fAg4IfLQ==
Date:   Mon, 22 Jun 2020 09:13:33 +0000
Message-ID: <SN4PR0401MB359820B05E3FADDAD67BDC639B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-5-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5308ef6-5a6f-4756-bc92-08d8168c89a2
x-ms-traffictypediagnostic: SN6PR04MB4543:
x-microsoft-antispam-prvs: <SN6PR04MB4543A6FE58529EFB4CCD31A99B970@SN6PR04MB4543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HRtWKDwHwNcM6E/CHFMr+PF9ZqWW76NDuTrNZ5UKWjokgS6zZbZhs8TNsf/edQ+xuKOxPUazqH/Zp83wSYXbeEUhGFwdo63KdrKwuFexscP+14o5uHFpgJWILeArszA7dDXZcule5cR4ly+1V4x/GDTpzF8QZsXY8LPkFY9xCdFa+7JSSkTU7+d9PipxnlwYYZDVr9W0nRyF6ehnxOQZr8IUJY/HYLgFOzQHUSDj9pFrR+vQGQZohx/PpJqRACXIfb6Kj3ojg7/IuBYxlqaut3waa+/HLarGGi+PT0EuhdTwyZJr219lEh1kDSYceB+es+XcSuDXhUmprtpOL62y0w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8936002)(558084003)(478600001)(2906002)(9686003)(8676002)(76116006)(91956017)(66446008)(64756008)(66476007)(33656002)(71200400001)(186003)(66946007)(66556008)(86362001)(19618925003)(55016002)(7696005)(4326008)(6506007)(4270600006)(54906003)(110136005)(5660300002)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: BtYxPlYzJ9PFlHwyWbNyq6tIDHtrL6qGyIfAYh+w6P1PUfodc43QJl/rigYz5JrZ8RGbKu+e3R+VwpBEB1XIi1qpkwEA44sGovXjFpG53SY2z3n0bSYRolEOn0H/iCLd6OqTNP7h+Hiq2u9/LwW9PNA8mn3DxYnkkjzxFS0/W5oDxgDCSg4S8Ac3NUvmrnFNaQxdU+3BwrLoha8f88cM4beNX/QuaW7tC5t6pdQOh3diDT6p0skVuNknd12qoENuX/r2IQHB5s/piboXt96tePLNDHHj0t3NAbCxr4CkEeCzmGicbQcLV7CK3IIlFZaQ+UEwNdt8ZlwCOXHA/Dgbp0JqoYov/bfKEr+iH4zH+svIRtu+0YJ42BpCZjl7Pu5cXcDz89up5Cd71Paikp4DLm0KcM9sO50JmZHTnt8KKiMCTm7KBoFam35FJSP2PKd9VGKd1XiSrKrRer0e9LgU33SnPE/qYq5HSs9Jj1ahbsn3hszLJEUED/wjIQg7nJeQNGROCWpBC/iVJBUDNB38vKjCJbd1rdgThXtbntavGNXxV9tNECa3rH2VviMXshOt
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5308ef6-5a6f-4756-bc92-08d8168c89a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:13:33.1834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tzWcFSQkExRGDE9enl8hBoiFrIJxmV/vtl9TabmnM3vnus3g1WVRIDz9EEuI/bkVCJHVwQ4B+3CNghUYlwt8OJPzwp3gwcPc+sJNP7woA3Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4543
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
