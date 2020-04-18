Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E6291AEB09
	for <lists+linux-fsdevel@lfdr.de>; Sat, 18 Apr 2020 10:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725891AbgDRI5T (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 18 Apr 2020 04:57:19 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:34396 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725801AbgDRI5S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 18 Apr 2020 04:57:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1587200237; x=1618736237;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=RRhWofpGseD8i6oK5yHdziIf2V9Uf2RBNEWtxbqk0zA=;
  b=GBjdfyKY5nIp7blbliY/cYYIHvCN3MUiZsjmtDXebkAFHf7rwk8FQIyy
   0yCAONtpIODeliqW4BY6VYbA0se9DcXuZ4r9GU8geBmxZvPBqpfqiYYL6
   XFyxVKUqhWj/7xJPDofhzTVqRRFCOENN0IBDexP3sJchwVTKd4UStXJGO
   1/BXEDSUaV8BACJmdn6B26GrWAKONJewhwg80Vvz98t/pPLkr43ul5IoQ
   7ij5m8ag69r9r+TDDLAWMwZ8oW43eyEFiFaIus5g3JHJ2pZx/tt62/Bew
   Tb0I9mdG/Yb1ROEkZb1x/xTvpgDT6PklLjHYMwDW5mKqn/1J0CXiu7g67
   Q==;
IronPort-SDR: /O7jHl2BX7kEWgeo815TTA266mRBI2RlMDqGr/QB8gxqiVQXXiBnCuxpCf8w7CYcPhR2omrbpn
 2I68dJEDnEFZWJv24DVJyjz3zXWIw3YqRKlH5C/42r8AjlqaqVfHiO8SU26G/R/R5/LTZ7EW68
 m3omKfJuPPOGJNTjDUnLsShG/QUeKGOv3E1K7mm+Sk5h6C502YlpqPJ7mHC+GtDsZoUTN6ADpK
 OgR4BnkH6EksFaaJ+72tPt4uh361dTstYNFtIntI8qMn0QdfYQHPd+gwvcqZNNa1SpJUzfi0qb
 5Ro=
X-IronPort-AV: E=Sophos;i="5.72,398,1580745600"; 
   d="scan'208";a="244291727"
Received: from mail-bn3nam04lp2054.outbound.protection.outlook.com (HELO NAM04-BN3-obe.outbound.protection.outlook.com) ([104.47.46.54])
  by ob1.hgst.iphmx.com with ESMTP; 18 Apr 2020 16:57:16 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APEeiD9yqbimMyx3Kk9XQPnIvpKQqlzZn6pdBgjqhz8+HGCklaOnbUZSK2F7g6mN1rEltCvMzkhlISpYAb5sWfUlyxF/MQiYyvgHyspuiXLpu9X438XzaGZ0FdQSyW1qOHsfOzFwI3pALyOfEZiyk13oAmQRz1WvZu9FRC/aIl/8sqmegExj06Pi0Em2JDoUxEtTIna6RT8J9V9UXgG/DKujfxbOMLbJXaA6IQkgW+//YrUmQFXYVuIXjLqK5/AlczjVG7+ESbPewHqmIN0XZ6Af7WLM5+aGds3KWc5IJAVLtsGpWpuOzwRia+Zn2cQMTyccItg6vAMmdoIUedMIEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRhWofpGseD8i6oK5yHdziIf2V9Uf2RBNEWtxbqk0zA=;
 b=fp4iKE7CadmoaI/Xwlsppn9aS/qF/LxV/aJmpVV6AE8FWgutHcIb1edNTKaL348pxAMonuxM4rSM0fCtITC5LnFEYJTKtUUUcY5aHTy4iauXT0q2jeWFBGFxWD78EKK3sL8xeZp075o3TV9vr4n9yttba48GdGwj/GUODLp1oFcdjoLVCES+Fg7jtK3yrdnMQMuvbbjOL9zVRoB1nODz3Pt9Y42oxltpvJMQhvw99RQsH4NzljX/Z4dWwlf2VvM1ymdRn4MKalMlnheHTZIG0iv7FBzUG5vB1kNXOwPqLjpO8N7AozE8oeal4LkjQbCrrTqWbAxXbEi2AzWGlybfVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RRhWofpGseD8i6oK5yHdziIf2V9Uf2RBNEWtxbqk0zA=;
 b=sqjyrGE0eG4Z8cNKdnUA2ya5KgkTKPcmCBthmzQWZuITnYgTotqHMFTnFUyt/VoABWwviQncIpEa8z9l7NX/iQrB1IwpT6PJFGLP9I/G3Dcv8cr2NrYzbJGIRXt0Ow0f1OmoYsNU2BZZMoH7/6R8DdImoegCIeJsEqM1uElSTMY=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3517.namprd04.prod.outlook.com
 (2603:10b6:803:45::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.2900.26; Sat, 18 Apr
 2020 08:57:14 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::9854:2bc6:1ad2:f655%4]) with mapi id 15.20.2921.027; Sat, 18 Apr 2020
 08:57:14 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>
CC:     Jens Axboe <axboe@kernel.dk>,
        "hch@infradead.org" <hch@infradead.org>,
        linux-block <linux-block@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Keith Busch <kbusch@kernel.org>,
        "linux-scsi @ vger . kernel . org" <linux-scsi@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        "linux-fsdevel @ vger . kernel . org" <linux-fsdevel@vger.kernel.org>,
        Daniel Wagner <dwagner@suse.de>
Subject: Re: [PATCH v7 00/11] Introduce Zone Append for writing to zoned block
 devices
Thread-Topic: [PATCH v7 00/11] Introduce Zone Append for writing to zoned
 block devices
Thread-Index: AQHWFLHx0jzddk9TS0yhYXDfmQ7NPQ==
Date:   Sat, 18 Apr 2020 08:57:14 +0000
Message-ID: <SN4PR0401MB35983AC2D018F2976D58F30F9BD60@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200417121536.5393-1-johannes.thumshirn@wdc.com>
 <20200417160326.GK5187@mit.edu>
 <SN4PR0401MB3598F054B867C929827E23F49BD90@SN4PR0401MB3598.namprd04.prod.outlook.com>
 <20200418010055.GO5187@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [46.244.209.31]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f71bdcb0-6da0-46fc-6e0b-08d7e3767d45
x-ms-traffictypediagnostic: SN4PR0401MB3517:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35176722150FABB0169127749BD60@SN4PR0401MB3517.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 0377802854
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(10019020)(4636009)(346002)(376002)(396003)(366004)(136003)(39860400002)(55016002)(26005)(316002)(91956017)(86362001)(64756008)(66446008)(53546011)(66556008)(76116006)(52536014)(6916009)(9686003)(5660300002)(186003)(66946007)(6506007)(4326008)(66476007)(478600001)(54906003)(558084003)(8936002)(81156014)(8676002)(71200400001)(33656002)(2906002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: v4YuCX2xir4M1BEiFUtlHg+YZ1SJavteExg1zp35Wj9KAoNfJSZ8VpKpX7w561lLzAVMyW3VngaXMCjYkZaq0EgXiI5NqSxt9cNVJ7iN/OLjq/pVjRf+p003rjZ7vTt/Qg2oLTgAbMIs8TA4U6zVGW+XcxiixwD4fFdBqjbkw020TQ7HRuDbKkjtoVPYsoY+YpTvSCUHQfLNx7V/PxlyCzLUjwNqDbUW8RCFNm6MWCzL9R06egDz3vaN2RToNm49PYcaLyI3fEOgyPkJL+tbJ0MgZcUi0MT6ebKv0OK9NjCkzN3JpvsAhY2/j63nec7WBwZvRj8x1S2ga6TJlWVNbnOFio7ukGIFILZ4dezf+OPdyPvGj/CgQOyvm2E1M0jGgEaAmaOejEr8t4+FtVFDH/9hc8fodTyG/Vh/ycdCQpa0ot48g0EbyJPzwlB2+DOT
x-ms-exchange-antispam-messagedata: 4BRlUCZsvYkXdEwVVpsEiKfi8qQxC7yQyiM9tqGnEDDFckv3bfQLso/D3rDnibQPPlkN/e5tzbvN5cWWv3QKv715Y/RGtdbschXDejwHgUWlU7MfcFPNbPRoIu5BpkImDRCsS6IC0zo7/rvGKBSPJQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f71bdcb0-6da0-46fc-6e0b-08d7e3767d45
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2020 08:57:14.2190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 1BAXeMVYCuu9KlLRk41IbB/gnCRjnFiZ50mRWgtZP38tJbpPrFPMtu09fDh/D0Dy9kr8pfgkj0YGPhr8Z+5zsf3jbxfXIJcMAuin7+EupEI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3517
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 18/04/2020 03:01, Theodore Y. Ts'o wrote:=0A=
> Ah, I had assumed that userspace interface exposed would be opening=0A=
> the block device with the O_APPEND flag.=0A=
=0A=
We actually did do this in early testing, but wouldn't this break =0A=
established block device semantics?=0A=
