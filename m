Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 248F214C769
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Jan 2020 09:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726157AbgA2IYW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Jan 2020 03:24:22 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:61074 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726091AbgA2IYW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Jan 2020 03:24:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1580286261; x=1611822261;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=OGBRfRD20xGWhXPt5PAz1WeTGLrC0eQ7galj7ndjLaQ=;
  b=CyOGcL6lZcmbJQqWY+gzer3aGh4c3eyioCV7+Rebs1XVtO0I5Nnu5YL3
   Tv3weoIKsHA0C/J4Dsg6Px12WbhIqSYqOjeeRL2IydwRvdYut8ogo3laC
   k2uBBbJZe3IejQXogYElWsPkZrzRHxGEYwbxmsy+s+yn6eNSes2V4/ELi
   +nkBusTDhVl/ExHggcP2HKOIOEAsZG5mRxapqDOxP8CVdjpi27GlP17XR
   6nDX/rdoMfpEpnsGFS50pEydwkhwDx3Adsyt+oZlND91Hq6BcevxEilUB
   6t8nrc+Wqq42vE531f0czRXGt2XYRVU72aSNrQKL0c/mlS25BjPG3hIQL
   g==;
IronPort-SDR: Ml7ebd8/t3Acx5MNPBkJ/58C7xxxAyL2gMzj6zJlShOcsa/bhmhHBrdA2mFsY72TftA5qSrHVi
 E25r02pP9R/2N72Vx7MJGKkCWOyOjjqCaxHCv7nmIwVI4d3S4KLAGc0O8/SNdbcbwI2Mh0L8wr
 NHAeaMmkZPNZLnePJKlKondO6dVaWD7367AugRy3FxyXbOVKdGbelvhghi833V8FFsyxvntsh/
 hcxevJm59q+tMSoOS9xdym3UCyABCnUrM0gx+VyfdDPvObfgZHbO41iUzbpnv+mJDWhcADWRux
 hyU=
X-IronPort-AV: E=Sophos;i="5.70,377,1574092800"; 
   d="scan'208";a="236568456"
Received: from mail-sn1nam02lp2053.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.53])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jan 2020 16:24:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRUK0+x4ozOLfTHlnvC/pOhZKXMySfYwSygCUikxrebk5fdZs7p9ILeZdq+AhbO2PaUYVzAP+FbrifB58wa19zn/D1C41iVFBI17JuvNLELFTXFEWgEbGcKGOkaZnIzyZt6XxR3ORjm13dH3Ap99+lLRrBKa3+fg682vSkUNmpDK9PegRw3aXmOSjV0Prw5Hx86iifbloGZb3OhXSNAn/icou85cwn9oEG0cPnNwhhZ9/FTNc1/bpFyiHjlx43ZtZAD/kO95UBsrByu13RUoskMAcJCYjfEWEFDcjzrDm8bDQC4jaXmHfTRwyLGQAqR41Ip7aBkbtY+Rm/eYK1lUbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGBRfRD20xGWhXPt5PAz1WeTGLrC0eQ7galj7ndjLaQ=;
 b=GQo/ez/FEie8cgyTmOa5oWZeRMfs5ngaYvjOq7GYfANLUq/g+I8pC9fsNtjOkn3XZGct/rtGBxI3Z8tjdS/OpMjcP+qd5AtQbp6MbDDgcL3SR0Ar206XknfEmZgq3YmeADVyuynXYd7vcBP5n9pNdFHVt+3PVbx3VEXCjL4XcWi74JKU/hoovBdUJptKdVRHH3xZZHLYndAuVfjMXgpq9kH8eKYVtdnn8F9o7T2rZX3wHFcQuLPbChky6KLC3k+5J6c5KkL3HHILsK5JnG6QqmFG89IPKK+VFCwxE/G7EW3racv7IRTTDojnnDY9WzsxYr7/SYGkyKcXUqxXpb4nsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OGBRfRD20xGWhXPt5PAz1WeTGLrC0eQ7galj7ndjLaQ=;
 b=txuhSFxlXRA4NA3NtSLITshvJTRJ3NQpMe/9Yd7LmT+qU2iAKCzzuemyNgAO88INmfNCPRfw6Si2Pf8+X7mZq4hhoViLVgJ6EuocqbWcm16Bc/3YeHz+f93tP9HZJARHCSiqCgzeb1x92eLDFDBlO5jt7BLu234XqlS4KT5OZ+c=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5877.namprd04.prod.outlook.com (20.179.58.91) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.24; Wed, 29 Jan 2020 08:24:18 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2665.027; Wed, 29 Jan 2020
 08:24:18 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Markus Elfring <Markus.Elfring@web.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>,
        Johannes Thumshirn <jth@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>
Subject: Re: [v9 1/2] fs: New zonefs file system
Thread-Topic: [v9 1/2] fs: New zonefs file system
Thread-Index: AQHV1nz4VgmI+ONs6EuOARHWsE8vTA==
Date:   Wed, 29 Jan 2020 08:24:18 +0000
Message-ID: <BYAPR04MB581624B1EFB13DEEA299C699E7050@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <23bf669d-b75f-ed94-478d-06bddd357919@web.de>
 <5fe2d31c2f798b0768eec3ebc35bc973bc07ba1c.camel@wdc.com>
 <938e70e3-0f45-2858-a4fc-dd90371e4e90@web.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.12]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d5f2a73b-3fdb-4e00-95f9-08d7a494a2a2
x-ms-traffictypediagnostic: BYAPR04MB5877:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB5877AC5DD40D7101CA306E6AE7050@BYAPR04MB5877.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02973C87BC
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(366004)(136003)(376002)(189003)(199004)(86362001)(8676002)(66556008)(7696005)(64756008)(186003)(66446008)(6506007)(71200400001)(53546011)(4326008)(2906002)(76116006)(8936002)(91956017)(66946007)(81156014)(81166006)(66476007)(316002)(4744005)(55016002)(52536014)(478600001)(54906003)(110136005)(26005)(33656002)(5660300002)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5877;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: SLsEfDK+Mb757vcByhg5xONfdLwKn92A5QCewhResgVRmWHZ1BWhtK5XnVrNn4vg0HrELMyWkL2q+OTkZBSnzzrPfItLGwQIZgnxU1mGSeZwsrq46PXEsBaNTzlh2RFDx6UewN5KTDJJLlvIyKqGEyPall1zFxuKaCVUSrzpR6jTRpKK1e4yoK9DQfW8b0FKczzdu7ybXLjGcQ9bOp2ohpbvrX9tBWjBkSWQZ+rxMU9BQC7QSbkodQ8U7WE2j/1r7mYIiAt6o+YnlgogQwHpLKkK/sBMZBEMt7s/hyzDjOOkw0ejgVaTT4fmIS3YoercsLuulx/hHscNOV4btqqOO7Sri4yErHZPMXq7mdbp+3X6M0Veo+NLEDabU0386Alqb2z3eZmQwqzK4aRAfbcERYLSutLaJLISpuNLsNXfDxJ1phx0lx/O5pjvCXkL6zu3
x-ms-exchange-antispam-messagedata: vD5u3RIqisPX8UNHkLkld5bKZECqcX1rJtXbcji0Zc6qkIkv6394011ycKib81jCfZdnzv9PIwiHOQrK3ikMo6ethATHhKXRrFMzNfyogd7iK5M3lMRTJMqGRyK/XP8ACH3QXcPhxnJGGAt+dX0iPw==
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f2a73b-3fdb-4e00-95f9-08d7a494a2a2
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2020 08:24:18.5374
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wl4AinB/jwRUkzX3jW7CllQjS/2F9fm8ycgcogCKz9Pfa3ORSs2vc4mjehK3mz2Vn8Cc7dauPfrseakLDirm9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5877
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/29 17:20, Markus Elfring wrote:=0A=
>>> Would you like to reconsider your name selection for such labels?=0A=
> =85=0A=
>> Fixed. Thanks !=0A=
> =0A=
> Will a different identifier be occasionally more helpful than the label =
=93out=94=0A=
> also at other source code places?=0A=
=0A=
I am addressing all comments I got for v10 right now and reviewing all the=
=0A=
goto labels too. Thanks.=0A=
=0A=
> =0A=
> Regards,=0A=
> Markus=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
