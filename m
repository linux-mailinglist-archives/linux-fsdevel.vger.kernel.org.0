Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41C7520338B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:37:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726931AbgFVJhB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:37:01 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:40202 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726500AbgFVJhA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:37:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592818620; x=1624354620;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=m7Vtk6nxltzFRpmAy+/PfVpYcxw4xTqM7LDDAWQOpCA0rGxLA2fidRkl
   AdTtNlEW/BQ/BAuZQAc/F2D3TNySvJmOJUgQlJQ/k+JNXj33PppGZKuPC
   aSH2Om5JAC24sXMkEA6mukNQVzI24Dslwl5S2DiXq6Gb3cszppBzlRGxQ
   Ss0ZXCTTiQhwdE9x8cKWq746TAewzxmFO8EJuzdQ8dlBD202fPh9MPMXG
   +cqvlKjSsVy1pRyH7iKrFf9E/MGrbTVbYwQjm7n7qFxYjcJaeWG8DyIv8
   dMdN2EhEHbf4ZdBhUyY9Yp8mRZQ34tS38mxn8dmZRrdrzTmbMCqGxuhzV
   g==;
IronPort-SDR: OftNjmNlEXSWrgFpl1wd/xP6DXgGf3NBcLNtAg/Nm3cgvxESozIHojvykVbszi8e/CSIL9L2HI
 tmvUcLE8I0v12U3RjJQQNZXEPmSCd2QdyPHPUhJm2BVBWZWy/xU9h1uoch1x2XhA9ZQbT8MVxU
 D37HOGQAf+FY4TLwd2gNxSYusVoIZfXljrUuB5JjO54pYKGxY+Ym4F+DRvA1IQdaRS33f4V1QC
 1zk3NtMlBLVbLnrWqVGgBKWvcR4Jnv5/uh3NgprvhTqYIHtx0kJrEQUcG9Y+Cgd2g6pGWMeNEb
 Kq0=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="141971181"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:36:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HcgCSuKGH894ojF2GFYpfiHie7s3tvOyZ6rrH8LEXMF5UgR3JW2tDrTW217yqHwIC4VctPb+5z1c0zpoMZou+sGVFr/NZRez+/T+108jClfL6WzLmQr7sOM7WNysdmCV4cQiM2SounMTZYkYHCh+7GkwRYa9tYz5/rFweMq7TjiAHkNIh/RQWMLub/+Iufiz+lJkw1wgvDpWUlCAO4Pn2VNoXRrNjx2AhKHxxvYOoTGdrSjm0lxpno/g1oyZ7E8ljL/iWR3kf0iNOdqtyRQMXHUVzwUpxrucBaCg6i1Puyqj8e3m3NFAGFo4oaPuKRz6vBIBE7UbBlvMn61IdJVbRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=M8ljCz64DtsqxuDAUArhb2ryWgUNyIROTEJPUI5vDa/itCb7JMSuQ2aNgljBtcf6Nha8ph5sC9Kpb+xdm0jCR0d0PPgVAWJwM5LSkMjD9tN5lHuB63J4cT2t0Oi1Hhre2OTQWiF02U5egws9MTReQQ/Do8PcdAYMDGPEOK9/SlJlqMVkmza/iwlItS8r4l0Zub39E07JMCwYjA7SeyFCnDpGSSUH0GMsntmGnHniK0S8Br8g/CuJU4MyngwnbyEXhpdnW6dQ9cl1vo8rIAFaNba+3YDcLce0orxw6bfHaStHFOu46I/ukJUdphQe/voXtBPwHS1fOicUBoW5D/PjEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IIl/G8FJZlH2F5hoG+70Kl1uR40y328oaNhmqqCra2zlstXRS3DOtpX2y4PB+g0O/1V9J0xiTlakbn6HBq8XnAT0NPGbU49k+Rqw9ouIqaLcr6x5sWB6hGYV2RBMvFeBB4DeKhR0UefZDlwNto5Sml9Ew8sJBhLSO8lVMEhQbEM=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3678.namprd04.prod.outlook.com
 (2603:10b6:803:47::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:36:56 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:36:56 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 08/10] fs: move the buffer_heads_over_limit stub to
 buffer_head.h
Thread-Topic: [PATCH 08/10] fs: move the buffer_heads_over_limit stub to
 buffer_head.h
Thread-Index: AQHWRtLgGyF5qU4/jE+aw6jEXcjdhw==
Date:   Mon, 22 Jun 2020 09:36:56 +0000
Message-ID: <SN4PR0401MB35981E33B78E7C5B1C096F699B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-9-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 87772292-5eb0-4c10-616f-08d8168fcdcc
x-ms-traffictypediagnostic: SN4PR0401MB3678:
x-microsoft-antispam-prvs: <SN4PR0401MB36789A1704476C4CF37BA6189B970@SN4PR0401MB3678.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hwIFlVfV8E2w6nEJJl48dhPDKh32igNe0ZXKsWt/8ahpV9CLm1HRvC+rnZKiQdQDXvK8G7/oB75ofohYIKfOdeKyRFJuDbKBqrXCUmd4MqkWyagsfaV2cYquBrGxFT8ioUln39QWjZITZMFydaAv7bTCRuetPwhfaiVdc7G78i1g3SgGO2tV8F7yP0dJ3yYbAV/9EBDk0nKdyNlLoYcsT+E29hMhIuYWo0+UQV7hsSJy7TkBxwTXKNe0ScSs9kyDgnZ+yc25FVYI5SdQrLdvHBVISmGgQSIFr55+Ep37Z6PqC2vxq32uySdm33tGGA/sPJ6TqX2dVdQ07PEjiB532A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(366004)(396003)(136003)(376002)(346002)(5660300002)(52536014)(8676002)(91956017)(66446008)(110136005)(54906003)(66946007)(76116006)(8936002)(19618925003)(4270600006)(316002)(66476007)(66556008)(64756008)(558084003)(4326008)(9686003)(86362001)(186003)(478600001)(33656002)(6506007)(7696005)(55016002)(2906002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: ZuI6FDps8N+R6gUsdabl+Kqwd2bdp3IYn2wMyfN960DUcuIXslWrrjQUmJD1HPpLYdEAjHrCQTnQLgqdc61acDjk9dpLGeONEF/GO+7s2heV/pgjixzc85kZHQwT6xmSzYe28W7y8BwIYVc6HAQ13n56A2eMuEVFkvGovMwU2eClTYvccMNMZ63poVorGzpkZ4sjp9bqUbq4HqHTZ+76qxE7k9o5G30EgcRcjJVAxIiRsGNXGyFduUnhPmwb81odhoDFnBMEYAGFcwh5FyyWhPIQMdLBumxo3Hp009SItUvMgbCgrH6RmUs94pkzOWvIUW3RHx5jfzhQl3eHYZH151ZI/ZiGh4xQoPBeuUBF8JRbJiw4wYHkLbVw/9MwsIStZg6AvU7FCOi+yxpiJa+zQBRsP/syaIGOgs7x4YJf3XrIPffvbggL8wRNa2nL8d6+ycxuAQGbASO0VQD3t4u9Bgjj76EOuOyRsa+YegBjPXShtcayUs124AlQdcKMldKPjlMoXFWtcYCIIicsRUR4Jajo7NB6W0UCM1AuN27EyaRVuK07AmnZSVTHFQowsQDm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 87772292-5eb0-4c10-616f-08d8168fcdcc
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:36:56.0595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oLbiM/EuY88YNfqK7muCEd3+vgpvxQNVUEBg8uYQoK2xP3DiP2Ojzfs0+08seVHsEtIgUKPY/x3Ci11YbyJPQ3a8Hk8tkqLwQSmkgrL8BM8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3678
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
