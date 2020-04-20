Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E37E51B06D5
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 Apr 2020 12:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726116AbgDTKqd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 Apr 2020 06:46:33 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:39578 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725865AbgDTKqc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 Apr 2020 06:46:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587379592; x=1618915592;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WesWpgnwluaT1A3i8S/Vtx+Pq+BHytHqxQ45Pt2LfDE=;
  b=pj50cOud6Xa3feU9E5QzBLuxgo0fDQmy/0t4WRayj6/BA3PTqzeCfFb/
   mEcmdZGRop2GQR8x1Y79kmxYATmBUmPkX/xoO94j+sWDHkaj71NRO6ejw
   SE/PR7QGmSweMwsQBELdiEzp7GNoz5Kitv4zSsjJENawKUJ0j8/1rAeLV
   nLO8XxkdA5zAqJTtR/NJASOgS49aUy5md7Rv7zONGftsrnPCgU6jIe5Zh
   XgJbpprjnKWKH0Cn2ERsb9efuf37A42aro/JJkDhQNdggQtmOQLhKFv2Z
   qfO0ratpX/MCKkWJqmUI49J9L4PNfSyW5ZiAt+efsxhN6s4tvYAewDvAu
   w==;
IronPort-SDR: Z4OWQCng631NLMqKzqt9Uh249dIOzrpBzp2MzCVsYSWb1bBaxtjp3LqVXdAocZaps/rFGMFbv0
 NtJrg//N++fua4JdHJINtcVPA5omsvy5lQq3kfJ+e9mnFPnM5OiALVPJ+zZ+DoMwfeKFhPkB47
 3D9ngnLzhcUeAuiw/xayGzMzgyeJEH+45tZ0xSviN8IedNZ77xl+gDAqADitVYNM/pPz6G40db
 7e/yFd4wjvXD8kJ06FfKJA9L4LPYrR3KefBygzG7nIYozOEPt0xz8TUUfczboV/N6YBPaO9z99
 Wag=
X-IronPort-AV: E=Sophos;i="5.72,406,1580745600"; 
   d="scan'208";a="136010138"
Received: from mail-co1nam11lp2169.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.169])
  by ob1.hgst.iphmx.com with ESMTP; 20 Apr 2020 18:46:22 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CXCcnv/UfCNYBHO+Rm9qHPhe2/TRGsHL2iAfVmMR+EdUuBUul3BI2hVK0fDm8A8yo4RnKdGnMzQAqDccva/w/0rrfbt/+jVp5fDE/NrQEUcjDoFh9zGvXjqRGdbJ/a16z+f04SRd4mZnNJj3HHFZLKjoH1iSITV4cjkjLQ6n7X2F+Vn8OXt2995fwn2stJ/9/Lqa1p5U+2PGuuSeeFP7vxpHGhBVJJ2oUD0hWlWTNsLtIJGtfpWRvdSqzr1q54s2F/CVz9QEekZJ1OpEw3t5FlLy9W/Me9oqa1fg4XFOmexXtVDMjw0yn9J/KlR91Jrb5mZZ/l74i/g+nG+VrTlarg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dm4Okxwmld26ng7ZdQb0wwSZF6YUAaBIVSgOMQ5DI4=;
 b=fJ3eDtJTmmbAcyfoCHbjdRu2TSVmB/8GEBR9KrofjPZdmqtFfklnUDmKAJJx9PWXKd/1gZ3boFSXyy/49+CbGtNQfrv87uD1tr5EK2CgGpFWAsaSBTBNPN5p3JDUjA6nv2+oBrmkyvrfIFgv39c5rs4oN8m6xGBWN2qWKYRSuY7QhMEr3d0pN24mLcYLfJdOStDspO6yrij0NOGFd7VbawNSg8LuLK+8CRaEaB1vcIsUpI7fsFIwPag9D2kBjVNdX62noIJ873302UWShDyRtWvUc8/PVKyAUoYBL2yc6sknT5AgU+2hIHiZ5BXzR/isTjtmZe6LnU7063/gTbMvRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Dm4Okxwmld26ng7ZdQb0wwSZF6YUAaBIVSgOMQ5DI4=;
 b=kJwzyT3H979CnRncQcvrcvr760qqu5ir8Nmpny44Rr2TnBTWuQOFetS9z4KHSP6bz0or3Sq1YtcFTYbDDfWygYSTiSv57bb4o1TbX8aPHF+aCfZNlBjDK2ylI3B1APKOC8aeD2tCwIGfNlwgLkmmiLv45rwskXTqneYPAPi2mRI=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3630.namprd04.prod.outlook.com
 (2603:10b6:803:47::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2921.27; Mon, 20 Apr
 2020 10:46:21 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Mon, 20 Apr 2020
 10:46:21 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
Thread-Topic: [PATCH v7 01/11] scsi: free sgtables in case command setup fails
Thread-Index: AQHWFLHyAOekOpGZiECrfGFghLCsTQ==
Date:   Mon, 20 Apr 2020 10:46:21 +0000
Message-ID: <SN4PR0401MB3598B2774CD52FAB68C726249BD40@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417121536.5393-2-johannes.thumshirn@wdc.com>
 <de79e1ab-0407-205e-3272-532f0484b49f@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 48878d3c-0127-4124-900f-08d7e518108f
x-ms-traffictypediagnostic: SN4PR0401MB3630:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB363005E876573EBCDADD8A429BD40@SN4PR0401MB3630.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-forefront-prvs: 03793408BA
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(376002)(136003)(39860400002)(346002)(396003)(366004)(91956017)(8936002)(81156014)(8676002)(76116006)(66946007)(66476007)(9686003)(52536014)(26005)(6506007)(186003)(4326008)(33656002)(86362001)(53546011)(66446008)(64756008)(66556008)(55016002)(7416002)(2906002)(478600001)(4744005)(316002)(54906003)(110136005)(7696005)(71200400001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZS9Q8G6ZF3SfP9VGNRcNchGl1FBMCNgUYsPUVA+nHhm/GzS8A4w5DFoJvXBXhw/S8t8hWQMOD7r+kvosnfDdo4q5cFuICSaMWg4REjVtP60OhcGG96nDpNv8yWM78UwevECVbnzQUlqRA9fDJNfBFDA0V7CxuAGD7owBkP432pFXy4UdV/T5Rl6FwbiSEbxI07A1xh4sGHblEcVVQJ5ZMd6GGOL+hmYelCXmj6N67S/xIyBLNebUE9Ie57g2R9bUnOM92lUb3QCqBruwVKKm4T07xuZX6ZrxfHT0s2yhE28t+pgPyZbUpFaLvXzJOBmEUw1e1TodYgttBATIN1E1MG5MzIAcqFF1sgfXKyeGwvRvxi6uReJvQZlRiE5xLhoO8hHicmCrqF6D1vWBzFmArUb2GnL2ZYxjV1l5Qz0jAux0/AH6O/tqBsv8KZ58kuGz
x-ms-exchange-antispam-messagedata: Dd81dMhXzktCbWred1zjuDD8dRFN6RZMSt/QXvClH8N9VTI4mirS9QFY9lhjYzY/KIQC2tbOAlLJRzSAWEPVKj9uHUFngP1omV7lwo642L0En+VQPU8JemuZwZkYVCnvgf0SLVEUOnKmvwNqer+Mqg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48878d3c-0127-4124-900f-08d7e518108f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2020 10:46:21.4088
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: LHGFwGH+PWypcKFTtSKfiFiPuPKpFDyOMdVT/UWJ7Yfy/vY++n09jhOoOpg0SKms6Krp8ICPZ6T/ySvcESGQ62tFgu2pSCR4sTP/bWMugB4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3630
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/04/2020 18:02, Bart Van Assche wrote:=0A=
> How about adding __must_check to scsi_setup_fs_cmnd()?=0A=
=0A=
I'm actually not sure if __must_check helps us anything given that with =0A=
this patch applied:=0A=
=0A=
johannes@redsun60:linux(zone-append-wip)$ git --no-pager grep -n \=0A=
                                        scsi_setup_fs_cmnd drivers/scsi=0A=
drivers/scsi/scsi_lib.c:1173:=0A=
static blk_status_t scsi_setup_fs_cmnd(struct scsi_device *sdev,=0A=
drivers/scsi/scsi_lib.c:1205:=0A=
ret =3D scsi_setup_fs_cmnd(sdev, req);=0A=
=0A=
there's only one caller of scsi_setup_fs_cmnd(), in the same file, 32 =0A=
lines below the implementation.=0A=
=0A=
I do agree about the Link or an eventual Cc: stable, but I think Martin =0A=
or Jens can add this when applying the patch.=0A=
