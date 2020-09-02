Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD59B25A68A
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Sep 2020 09:24:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgIBHYJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Sep 2020 03:24:09 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:24255 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726130AbgIBHYH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:24:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1599031447; x=1630567447;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ZyjaB2/rRjaCCDl1mXfnrvXCWPDulgC/vx5dwT5hbFT9A6OZ/llvP5V0
   lVwVluRPBBohiHrneg5gd4voIgr4giFladsqgK7O+9cL94X1a8Kv43VeT
   VUn8OQ0Y7d850wb/9bOrCNCHcYkoagPbqEtXmcPiL0q8swfmG1oaiBxlh
   RXspeCRbvNjKUeULbSAnxUnogdFo1Dy6dIs3ggv5nAzDSKDFThfv4tblH
   oCcHdikcArgufnj7eY1dBuAI+h9HVxjrEex6BItxWy7Xmmbk1R3Vzqe/o
   fT9fwYeqd4HvjMS1pCUIB5Xq1DXy1r/XgOePJwqLoaoJxoBTMXPtgHUKb
   Q==;
IronPort-SDR: +isrtv2hTX26JQ0q3/zFevj3cYgquTQKlbw7m7C8wcP5SYOIQNuX4/Mz6padfKYBNdckR5Wt+5
 JKXZNCAjKgw0avk/uXMUIvm3hRMLH9A9vCrnfBtAZqZlgyRmGtrXFDN9VEsl/8CAx03blSd5DE
 Imk30bgqXTQqU8DXs37HSswd3q7zmKxrVdKJCClVj/uscfoF4xi3lvY2oGK5UR+HPTZRkrTgX0
 Hg477CD03ZxVnCi55vM6tRlbCj7lXGcLG3srBPAI3fVxJ4jnEvUQEhoPOGtO92SR8igQsq1tg8
 14o=
X-IronPort-AV: E=Sophos;i="5.76,381,1592841600"; 
   d="scan'208";a="255918310"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 02 Sep 2020 15:23:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JNSX2p1QXdYz2AGvoWHDO4OAqUgf4l/gs139CgSRkb/lETLAZB3mqMOTGj2806BpuSspClZ/Nsnx+1Qe0bMLSUtdydSVbrbuTPt5RVzS+rEDJVTkKJLPB3YTNFcC3HANe0tBh0Qalr7zIozvPcQ4+iSvyM4CvCVOEYUEw4xSs576BiPmjfOoVj7AeG88OgU0ug/vN47iAB1dEU/lxyJ9uAyUtHjzIkpAsIaaXDW2YlQ4lZhaXKwcitWUbhEDz6jZQ5mDsNZQ+tDiQQxS7+/aYBLMd58UV6qsC2l4gGGg34WHRCTNcK+dZ3MAWFyjAyjwALgalRO41KXuWVIxQNeDMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=JdI+6y3iEuT7DoirqzLfHYBQJuM95hNLuSfhxg+tsLzyREGk3fFFACpxzvEOMbPhuETS96xWvj33COrjdKQj+Jnt2ANcIiHfMHLkApRe8gCogY7fvwLoguEWJ0ZTNPeIbNxigKJuRSk2WI1lw4v6JAQ9L79dFoWEhS3AfGQ65Lw99sMmAsfrGstX/63tA9e0sJRVMoeo+c2iOU4Eu1wpcPpC4pDgo2hhOxV4gGW1wuBRBTeAxno+g/wXhNL+UfPD52xeTxt3LeY9yGdhiYWCb/gHrJDERhvz8oKM27RRqiCPJHBfM018kVe82YLiKC7UU2HzSv0/Yj7spOoEtOzwFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=TL7XmXG9SD3szPhXvUS6n947+PDP59dXLrRCpcLUGaRoL2HYDaYuViGLmvFmXVpp172wMEpt3itlcZfQttgx/5DOok2fzOKBSeUm+BDyqgO0I4Ub4xda5R3ScHdpsiGGXd+xLuie4HgnBWNWokWpAgkc8iU/3o3SqYRo2uQrFfA=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB3966.namprd04.prod.outlook.com
 (2603:10b6:805:48::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3348.15; Wed, 2 Sep
 2020 07:23:48 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::457e:5fe9:2ae3:e738%7]) with mapi id 15.20.3326.023; Wed, 2 Sep 2020
 07:23:48 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Josef Bacik <josef@toxicpanda.com>,
        Dan Williams <dan.j.williams@intel.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "nbd@other.debian.org" <nbd@other.debian.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 6/9] nvme: opencode revalidate_disk in nvme_validate_ns
Thread-Topic: [PATCH 6/9] nvme: opencode revalidate_disk in nvme_validate_ns
Thread-Index: AQHWgHjs6OAepj9H6kWBHRxoz7ysfg==
Date:   Wed, 2 Sep 2020 07:23:47 +0000
Message-ID: <SN4PR0401MB3598F740D7978B51F648672E9B2F0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200901155748.2884-1-hch@lst.de>
 <20200901155748.2884-7-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1590:f101:bd07:d1f9:7e6b:2014]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5169cc8a-2f34-4ceb-3468-08d84f11223d
x-ms-traffictypediagnostic: SN6PR04MB3966:
x-microsoft-antispam-prvs: <SN6PR04MB3966D912E48E8002A21136649B2F0@SN6PR04MB3966.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XV8PsCfqAgtG6dH7Fd/cIFCOtQ0PRFerIErS5bJEczjQtN3AyUWCKF8fOLfQITrXb9yWGz9v4wTKhLr4LKdcUXOn5yoo9hWSDUtCGJiO9/aqWMGsvs61O1YsASMx01doJ/n+sdcOxy274lcLHgXH1oCAJ9CkqN3itVs1AdTxvmYss2tNjDnQNQ9VyhvO65h2uYn3WRn4qyHcMtT5TqMrF8vdfq75ny1RSRS/C+tmUjyZS88c/yg2kb515FdhB7BOn+M+Y4TpeVj3GWHCaKR23qNUO0kqMjrh9LXoIgcCGTJxyC/bowhBUFT84UbxeAgkFP94gPlo6nbdDpTuW9QDzA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(376002)(39860400002)(366004)(136003)(55016002)(4270600006)(8676002)(110136005)(54906003)(86362001)(8936002)(186003)(478600001)(2906002)(6506007)(19618925003)(7696005)(52536014)(316002)(558084003)(71200400001)(33656002)(66476007)(7416002)(66946007)(5660300002)(76116006)(9686003)(4326008)(66446008)(91956017)(66556008)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: wigWMfyO6LvWMMXN3LRT+2lELfzQjDOj+l4CpCOMCAsiT38TcZpAYVbCWCOFT3tFDcWzVemU+84DadVpLJr1j7UZ0A2lFdU+bmRSL9un0LBoQDFFjYX25p5N60O+jsRNhPoiepDiwe6x8YaI/+R7fRfCZzJuGQ8pUABidg34Yk/6i+6jjIJrF06vlYlczv+mT2XrNsS7GhxUloYY4tp8EpLIvzy84YGpou3woUQj5ib4Dnq7MaugycvZy6U2rZvCIcNQAlhftoCnzCvFgdUZ1qi/081TdXJAHQn97OzQv8Rx5TrQFrEtyVW1mehbT7q+twZ6swvfNQJHr3/E9614EE0iSsD1FADwWkiviQ1pfUNGVB4qXkQ8nmcBsOnVsDBjUcLEQIunWByb78w/bdzrPsD3sGH54EkI0m1sp5RhxDgLCeAZgPiDXLZjf+6q//Sxv3Bhj0uVmmT70jnGyoWpSiCuN+quv/53iSPGFFYNmZl/5zxmhSdgcSSDyd6erzcODwloIykeogFQ6O49uCBzRbuDmSdRUDReaeVPlzp2Hlw/XP9oDV9pPx63i9bm/pHWmzxZJNFzyT8i14OY8FQ/GYas2GYRP5kjxrNj+pzrsbENt7UqAOhl4Q51vu2KNRq7x/HT/pyB9vY8es85WtMDavnUPqrYlJKjsJ5NG81UkeoHMFdDiTBVTZ8RAUWD3LXUiCJ58tCHcGdGLf4VAL7DuQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5169cc8a-2f34-4ceb-3468-08d84f11223d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:23:47.8810
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6Ml4u55+yQ2yWUP6xTN2NXFaDG+I8YEBdwduVuzYHskPzLNMDCTwSyKnWyj3CHk49Xbd9xGDmQRxZf2F6n6QOGurMl3KIjjwrt6Fj07jZYg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB3966
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
