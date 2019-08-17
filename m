Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75DE39107C
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 15:15:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725929AbfHQNPt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 09:15:49 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34830 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725784AbfHQNPt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 09:15:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566047749; x=1597583749;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=8Fw2ZV299WA8O4iCy0ogtQvz4yzbv8qhNV+DxO/cUoQ=;
  b=Sat0Ne7PXBFUkN/lrINKTnWypHOU8tv9fcXj2ldpjOkm9VOXf2IJ80Eq
   ycxTPdR40F0xSgfBH1av7kuGsOBVmXn2ndQSfA9fTj3wZpFiKSqF9mJ7H
   FN7TuQzx749GIes4unAkOTsGvzSFQKft1DHwndeoxELVhpKbwyBZxY/r2
   kLr/txhCpjMxCSrjKeEfSvkHV1BYS3FCGSuF2XpiDALK8X+3ovIUwJRZw
   3LVF0R11+IThxjK/tfD5DG8x4/1n43lOX2NjkXg6XRQWiTR+X6TGrD2Gh
   gRaOSWGFOK+rKjsHwAeN1Ztz8RVOirXg81bHPoUwpD6DQ1hC3Yjvucpqg
   Q==;
IronPort-SDR: wsmYScRVTZaEVxSOaQ04puLQ+h2mIXJSglG3VsKl4kh+ZxQQ/Opz+XliawVUoLLemDPXpvGrO0
 tbftOsO3qV17M+7KvewSsWEc2OU4l8uD3xtwkguoehtzVzrS1Xf5OAtUQ2twKI3I1tOXfsnD2o
 aif7oNqQ1bP4KPdm1tCM9boEL+Lz7oFIYHQCB35XPm4mMS0Adb1m2+slUirycvo/cg1dnZQYhj
 Pm3yekMGNKUvrB8gCIoxppBDThCgb8LyutbYJrSfdN5xB0NlLk5hBTHhYIAQF1aNct2aRIZcMg
 faI=
X-IronPort-AV: E=Sophos;i="5.64,397,1559491200"; 
   d="scan'208";a="120644459"
Received: from mail-sn1nam01lp2051.outbound.protection.outlook.com (HELO NAM01-SN1-obe.outbound.protection.outlook.com) ([104.47.32.51])
  by ob1.hgst.iphmx.com with ESMTP; 17 Aug 2019 21:15:48 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jPSqOOS5xEHbUTnGhQhJVxKJegGVsn8zOFUqgejaWpyW1YCWYPGCUiEWWhraOJrHIJiuHgkM0tl4zvk3i2kpcZ3PSHGqLaGEnIr0VeZV0WiP5agWLXZHVP9mpaNChE/PwH5YHBqUuKBjQLDydHXINnotlRbe5HcNRPVZ6GM2MoWCxYa7VyFNl+XT6BZKKxD0M881bZOWsEC2rMsIXI8rOZtgnZGJGV29i2WHch/6o9Sw5Nes96j3tIvvgJcf6MUSELxmInsLuvT8YJPqYeK95OaTRtbTgQlf7dFeui9ypup0dv1BYIh8E7Ij73UkimxI5KDUhh8ylyz6Sa7yp4SgLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG4h2ACaZpCP4Vm/usMu37oEV0r6T3f9e2aQJc3unxg=;
 b=UW3wmJPcBWSvk8X6V20/fgxDRy4rbX9meh3LADYgL5h1zRJ4tecchBnUwy407cBeMboyBzgDz+WxwMIKP9RkpYGlaNVBQrfdnxB+lzgmyiKPvn0ecxdXaj9L7msWKZ00OtyZhuJLnUgbE6vSPAYNdia6miJu/iUVhPcll+pGgQtpr5m6XDvToebvvsgi1cniGjsd0dXVvDsGuKn5lavE1A+2lcT12WKjgFqsBjyCrs0glrTK/SBKqkwEZHH8O5RJqh1rKMyLq6iw00gXNmyyvS9178fhrxH02IA/z3tA34dowql9z64X9vS09IW/jcstSZ56BWC1iV6YtA3eZNPKOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kG4h2ACaZpCP4Vm/usMu37oEV0r6T3f9e2aQJc3unxg=;
 b=xX53UOy6lSCkjOm56nKpW3AVbSOSiaoWCY/NXcB6uEakDuCE5uSI79V9DJL0dZOowTHrBo4VlLmGfwf4TNqH3Qtkp5BD5RFBT2J1DTBfWLprheRYs6J4kxrAFGsnFcq6iyyIeyQr+jFH+QXs6i2rEF11C8z5s/3MJIcazFxG7cU=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5554.namprd04.prod.outlook.com (20.178.213.77) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Sat, 17 Aug 2019 13:15:46 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8818:ba27:ae48:ec30]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8818:ba27:ae48:ec30%7]) with mapi id 15.20.2157.022; Sat, 17 Aug 2019
 13:15:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "agruenba@redhat.com" <agruenba@redhat.com>
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Thread-Topic: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
Thread-Index: AQHVRnSmzp9+vweS00OIBa0ex787Kw==
Date:   Sat, 17 Aug 2019 13:15:45 +0000
Message-ID: <BN8PR04MB5812376F3252EF67BC7D663AE7AE0@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
 <20190816065229.GA28744@infradead.org> <20190817014633.GE752159@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [12.169.102.154]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fd8bd0dc-e7bb-4198-d3c4-08d7231503ca
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB5554;
x-ms-traffictypediagnostic: BN8PR04MB5554:
x-microsoft-antispam-prvs: <BN8PR04MB55542C00366F23A0D224DFA6E7AE0@BN8PR04MB5554.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0132C558ED
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(376002)(366004)(346002)(199004)(189003)(256004)(66066001)(7736002)(14444005)(6116002)(4326008)(74316002)(3846002)(76116006)(6246003)(9686003)(71190400001)(25786009)(2906002)(66946007)(305945005)(66556008)(71200400001)(64756008)(66446008)(55016002)(6436002)(53936002)(66476007)(229853002)(8676002)(14454004)(86362001)(81166006)(8936002)(5660300002)(4744005)(478600001)(76176011)(52536014)(7696005)(26005)(99286004)(316002)(54906003)(476003)(446003)(6506007)(102836004)(486006)(53546011)(186003)(110136005)(33656002)(81156014)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5554;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: CtX6JdjbUPSjO9GC9jEHBLREZIbAzBcFESsFLKoZ+YB96N1L3hVC8VVL3r+SkG11Pszsbfi4JpM7bRB6bHIdC2p4bLt2M27Wf5qgh1P6CX+txOFghfvG2LzJ5lKa8rf9i0BXyRRjKNgeIJgGmtpNHqgcp2fw7w/vNr892mZH66efQjWrmUzIZ7i5s3sI/0u5puYEMLVZaPPL3m4h7qmoARvtOMhqEbpD2Fb1A6vzK2vHd/oWN9/5mNeXQXlAMY9y3/sy/nTIlQYxTxMCjRJpfZRgo3bDa8x2/zUvDneMPtkGvXt/DZlSySHcBoVCRMK2PWCGShIscEQLf9zikBJFxRwz9YXgzTWp53eYlh40b/Bk/sdYAgBsriqBBzJKgPeQhO9ZQVQaqtTrce6r+6dsbCut0VeFXohWiNbp9BNJ1Oo=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fd8bd0dc-e7bb-4198-d3c4-08d7231503ca
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Aug 2019 13:15:45.9275
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hbH/FXFk6S0/7KoQNNcL9sjhnLgYMsdFfxAywHgsuKEcQEOJ5/CSVI2HDiuO8tX+VD8jE2HeGkr7p26tGCyjBw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5554
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/08/16 18:47, Darrick J. Wong wrote:=0A=
> On Thu, Aug 15, 2019 at 11:52:29PM -0700, Christoph Hellwig wrote:=0A=
>> Darrick,=0A=
>>=0A=
>> are you going to queue this up?=0A=
> =0A=
> Yes, I'll go promote the iomap writeback branch to iomap-for-next.  I=0A=
> haven't 100% convinced myself that it's a good idea to hook up xfs to it=
=0A=
> yet, if nothing else because of all the other problems I've had getting=
=0A=
> 5.3 testing to run to completion reliably...=0A=
> =0A=
> ...I assume gfs2 and zonedfs are getting ready to send stuff based on=0A=
> that branch?=0A=
> =0A=
> --D=0A=
> =0A=
=0A=
I have zonefs rebased on your branch and good to go. But before posting, I =
am=0A=
finishing a test suite for it as xfstests does not work, for obvious reason=
s :)=0A=
I will post a V2 next week.=0A=
=0A=
As zonefs is not an update but a new fs, it needs to be accepted first. If =
it=0A=
is, it will need your branch.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
