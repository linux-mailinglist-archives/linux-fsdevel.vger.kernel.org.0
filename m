Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C2DE7B968
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 08:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726219AbfGaGFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 02:05:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:12807 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725209AbfGaGFC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:05:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564553101; x=1596089101;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iQTGf9VaoGZdtljTcwnap0dzWXip55b2MbRVHHDOFyQ=;
  b=jnZBr6BY8bsVqrjln2ci2sNaDSY/ssWixdccPQtoc7zKqWCpy1ZcvcaU
   sEQuj6yx+KOM60E73wejQtK4TP6qd5bWyzb0/+T7YwitKA1hg36f7orYB
   nWC0dfZMcKP/xqvDI0CXRqbo1fPlIMQDt96WHknH5pXJUU6DrtlzoG/2N
   QvbMjMnuYYpRikSs4YlIS0Ixlr+paMgpo800Ad5BB0GwTNlxDb7VN1ySC
   7nET+/3X0xgfEZdbE9IMF5ZhsnajYl/kqBCwqrXmMvLSEWWW1d1HVm1iI
   /AMevv3sb6LYzLhlPsoTZB5mXKFonZIv/TNREwOnDFTQZGm+c+pfMdGql
   g==;
IronPort-SDR: HWVMdYAO1SNUr7Wo9EhFP2uhJjql+bNkHbfaiNchBizLWDFQ7OE67wRt3hjYOf49ereSxQRz3t
 nWNZxJ1DqdhYA1HU7VV4PZqppJrF8ij3Uq5tAjGkDc+PVdNJcSBBp+f5/SFAWf6QgNWSezJNSQ
 uBcM+P8UMoHypbQe741GCYTM8fq/btz57qFwG62QK/PnSvuWPMax6tapZ96kNIRlmiijjil15B
 AaoWileIMp73oHBlyVRIhQeom6ZjPD/6YtY3bSMoMk/u4r286YoeOJIMfzr7eC0DszBFNBc0Jb
 Lgo=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="221025846"
Received: from mail-by2nam03lp2059.outbound.protection.outlook.com (HELO NAM03-BY2-obe.outbound.protection.outlook.com) ([104.47.42.59])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 14:05:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b+j+fiJt1ewboGhOmsJ2ntJ9/D0fYpIQXnmo5mPnWJ2yz2pvPiG2aeUK7wG6B+59zuC+M4V2DwOpoY0bmdAom4bevXxA/Nix+ZI9GsaOzCrHDP9ftZ7c1koMnLbHLF9SNxZowRBOJabpI4jA3JlbmCGcWGhJrXCL/wUFBxmuOsd4Y38gMBSEQsjZC4dAvVVx3BFhiGQ5yxplq4rZZ22UpZSrsBzMPxvx6I/2JWNrtaBNviA1m5EzGjzINycYCOFaL2LJ9hre0eF5SFD2CiSExuUVxN7zgBWXSNBamzQz0MKvylL9HBaZ4RKEPYsqBwfpD+BQUGzmJNYpp/eaBeyscA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/4SIyxFYoR37nN5oERyil6crnRYsl0mvsWzEKScotU=;
 b=GcjR93LuEo4mXj//T5KDRdNgTW7mTmI+YeqiFaoqbpU4KhWcRjmvW2+ZvY44jVK3+HDkKKZ4Mb7Up6Bs5V0gWrM7gyZLqgDTHyu8huVpNZYrg8dN0TmF4HoqpPslslpmF4T3fY9eFNzdxMrkp8E/n86HW7EVklGRoxdhJxVHtDDxmmEH8R4oeT2cgXr/B6QdlOLkVsZGsxGsGgC1l8Yvfj7oksqtHZFL0fVJjR1+avEH1xFOt2aq3hRqT1efNkrS2vFToT/LlzrLWdaUzugdwdM5InDsB+U9MZT5bmQVmA+qYuul5zZJAYPK+xfMPDHWm/kZGPN6SPWcxl6sca6V3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6/4SIyxFYoR37nN5oERyil6crnRYsl0mvsWzEKScotU=;
 b=va9XUTzJl4p4XCyQHAT/x4OdZoB6rJem4CO5h5rkNGvqpSCdd/igIniGq3mnYppzzQ7ejYksTm4wVoCGeOTr6QflejpLq7PvuerV3Z0IREKP56tIYuWORyj3IStI8TsnWFCMs4TLtNirX6WbcWeXLWTDHlWW5fLhD92gK1kiDhQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4325.namprd04.prod.outlook.com (20.176.251.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.17; Wed, 31 Jul 2019 06:04:59 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 06:04:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>
CC:     Andreas Gruenbacher <agruenba@redhat.com>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: lift the xfs writepage code into iomap v3
Thread-Topic: lift the xfs writepage code into iomap v3
Thread-Index: AQHVQHLnm8YlnzqufEe/8+6cUzq/WQ==
Date:   Wed, 31 Jul 2019 06:04:59 +0000
Message-ID: <BYAPR04MB5816C29CC419B748F03BF5BAE7DF0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190722095024.19075-1-hch@lst.de>
 <20190730011705.GO1561054@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe6f1290-eed7-43b7-27ab-08d7157d0519
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4325;
x-ms-traffictypediagnostic: BYAPR04MB4325:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <BYAPR04MB4325B7CEDDD150387EEF8220E7DF0@BYAPR04MB4325.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(366004)(39860400002)(346002)(136003)(376002)(199004)(53754006)(189003)(8936002)(55016002)(26005)(486006)(68736007)(102836004)(186003)(6506007)(256004)(446003)(66066001)(25786009)(8676002)(229853002)(53546011)(14444005)(476003)(6306002)(81156014)(53936002)(81166006)(7736002)(6246003)(74316002)(33656002)(9686003)(305945005)(71190400001)(76116006)(478600001)(3846002)(4326008)(64756008)(66476007)(2906002)(7696005)(76176011)(86362001)(966005)(110136005)(71200400001)(6116002)(99286004)(52536014)(316002)(5660300002)(14454004)(6436002)(66446008)(66556008)(66946007)(54906003)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4325;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: xegEx0kTgwS2LCa6HlYzIYXyTBcNwn/vhzYYT/e8qxnt7GsWCJxQYG3BiIDNJ19jjL1H4hyoMIVl7bwBuTFMAWRA6sQ1h1kniG7IxDGEB0V4YRU0I/pKjT9shtEgKeNtd8BBLLELErnt9LJJDzjs/vX+FtfSANxsMA+1mS8XuTaApNQfdwrWqIhB4hFH4uZ+CLzm31776TYJuF+8K0xzs9fdx4OUutkNS/3sdydjJJR6x5WySm8dIQakE5EU5CS9KDYV3Wbx8TLEXWduWw5G2r+ha1tuK797eOd2HlRkuWni/AMOgbQ/nNMc0Nt0XmTt/Rj2H1B13TWQytTYT3BXYteH0Q4cBd+PHF4x6uVcqJnkoD5sn3g+6+LlIBuJlffb2mksb5mYpCnxR4k/0hTNBWjilv4ZvKv8BrHLJCWCf3I=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe6f1290-eed7-43b7-27ab-08d7157d0519
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 06:04:59.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4325
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick,=0A=
=0A=
On 2019/07/30 10:17, Darrick J. Wong wrote:=0A=
> On Mon, Jul 22, 2019 at 11:50:12AM +0200, Christoph Hellwig wrote:=0A=
>> Hi all,=0A=
>>=0A=
>> this series cleans up the xfs writepage code and then lifts it to=0A=
>> fs/iomap.c so that it could be use by other file system.  I've been=0A=
>> wanting to this for a while so that I could eventually convert gfs2=0A=
>> over to it, but I never got to it.  Now Damien has a new zonefs=0A=
>> file system for semi-raw access to zoned block devices that would=0A=
>> like to use the iomap code instead of reinventing it, so I finally=0A=
>> had to do the work.=0A=
> =0A=
> I've posted a branch against -rc2 for us all to work from:=0A=
> =0A=
> https://git.kernel.org/pub/scm/fs/xfs/xfs-linux.git/log/?h=3Diomap-writeb=
ack=0A=
> =0A=
> and will be emailing the patches shortly to the list for completeness.=0A=
=0A=
I rebased zonefs on this branch and all tests passed, no compilation proble=
ms=0A=
either. I will send a v2 of zonefs patch with all of Dave's comments addres=
sed=0A=
shortly.=0A=
=0A=
Thank you.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
