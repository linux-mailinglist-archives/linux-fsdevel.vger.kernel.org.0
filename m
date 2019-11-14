Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC1CCFC061
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Nov 2019 07:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726185AbfKNGyu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Nov 2019 01:54:50 -0500
Received: from mail-eopbgr720069.outbound.protection.outlook.com ([40.107.72.69]:34656
        "EHLO NAM05-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725965AbfKNGyu (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Nov 2019 01:54:50 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PDQbAqXzR6Q9ZFojuhxPQeNDIJ5gSTKICV+zo510C9f8zRAsdbpirPP1AVtxcyYWrH3d5PMnsuPQB7JIkF9mW8MXSki31kH5BnOANKlW84mKZSWY5gbboj4X7UxQ8689f7lY/JRiA1SBHbbXIuZbRdHPVa0tiVFUHZc6GPSUTDdrOJIg/F/SuZYXSUjIH55Nm0AkMpk9bKAzHWS1s6/95crdkayXk3pwWB1p2ixPMSKu0ilTbBJ7GPaeswzpBxqGWwCannsXvayV1fllpae+tia7pYL4Ou55B20Yvji64bm1+4iPJvot8gGfdZvLfavgwyMkS3SbTsVO06X7n+Gecg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKeFAMcknn48QUJqQNKn1KH4DRhXv5+uarvQnjRSAM=;
 b=LOpcWvlfULYgGKorRzUYVDu7H672m2PEYACS15JeTD76pminA9+naIkALqDwf8E4dUIFollAmjeBVUEN77qza2qkx1ayUF3b7afkmzKHCd7NeLp2HMnsNkH5trDT5Qx80XaqXMTEM7OHhJ0dNKjpQMcox+kF8nJRHmGw75aAgoPfGYGdY5mOHC3RHInjHrVRZac2o3MN9lW6L4X1yZ1WYt4Y97wUsUBwOQbcYHm1/RpxEjh1P6lt2q4o9bqbNnQzB32cqRtje9dDC47FEDz4TDYt3vC/r27+YM1HAOHqysePYVP3uh9XE2VLz3HPbTiwgmNe/1PqX2CQVr8bGcNAWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fGKeFAMcknn48QUJqQNKn1KH4DRhXv5+uarvQnjRSAM=;
 b=oy4eXRZBXyrcS66I1ZQ4kovet61guxhqoGeqUAqDJYIte/+PKeV1K56RF/LjQTrLMQ0GWOCvgJ6AxWSzg4tYdyaNOpFaFYWAhh51EpdHPDkQHw763VHoeRfFrGiXApdZdc4M7ZWqLXlknaPfc213Imc5ouLF68uH5x97rCV/ARM=
Received: from MN2PR02MB6336.namprd02.prod.outlook.com (52.132.172.222) by
 MN2PR02MB7085.namprd02.prod.outlook.com (20.180.26.203) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2451.23; Thu, 14 Nov 2019 06:54:44 +0000
Received: from MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::58bc:3b1e:12cf:675e]) by MN2PR02MB6336.namprd02.prod.outlook.com
 ([fe80::58bc:3b1e:12cf:675e%7]) with mapi id 15.20.2451.023; Thu, 14 Nov 2019
 06:54:44 +0000
From:   Bharat Kumar Gogada <bharatku@xilinx.com>
To:     Matthew Wilcox <willy@infradead.org>,
        Dan Williams <dan.j.williams@intel.com>
CC:     "linux-nvdimm@lists.01.org" <linux-nvdimm@lists.01.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "jack@suse.cz" <jack@suse.cz>
Subject: RE: DAX filesystem support on ARMv8
Thread-Topic: DAX filesystem support on ARMv8
Thread-Index: AdWY/Oy6C0M7BvSlQD+OiC0acLTSOwAf9TYAAAoFFgAARMFHMA==
Date:   Thu, 14 Nov 2019 06:54:43 +0000
Message-ID: <MN2PR02MB6336070627E66ED8AE646BACA5710@MN2PR02MB6336.namprd02.prod.outlook.com>
References: <MN2PR02MB63362F7B019844D94D243CE2A5770@MN2PR02MB6336.namprd02.prod.outlook.com>
 <CAPcyv4j75cQ4dSqyKGuioyyf0O9r0BG0TjFgv+w=64gLah5z6w@mail.gmail.com>
 <20191112220212.GC7934@bombadil.infradead.org>
In-Reply-To: <20191112220212.GC7934@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=bharatku@xilinx.com; 
x-originating-ip: [149.199.50.133]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 767c3825-b691-47a1-ac19-08d768cf87c6
x-ms-traffictypediagnostic: MN2PR02MB7085:
x-microsoft-antispam-prvs: <MN2PR02MB7085D64462E585F946286B15A5710@MN2PR02MB7085.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 02213C82F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(366004)(39850400004)(136003)(346002)(396003)(189003)(53754006)(199004)(478600001)(25786009)(14454004)(53546011)(102836004)(256004)(14444005)(6246003)(6116002)(99286004)(305945005)(74316002)(7736002)(2906002)(3846002)(33656002)(76116006)(446003)(11346002)(71200400001)(71190400001)(7696005)(26005)(76176011)(186003)(486006)(476003)(6506007)(52536014)(5660300002)(316002)(81156014)(6436002)(4326008)(66066001)(66446008)(86362001)(66946007)(229853002)(66476007)(9686003)(66556008)(8676002)(64756008)(110136005)(81166006)(8936002)(54906003)(55016002);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR02MB7085;H:MN2PR02MB6336.namprd02.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: xilinx.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eV6g+BWUTl6iiTthaAgrnySGAbuZCXcli1t/7yMXZeK5P5sQSuMR/m88H7Pi6zVadPtrpVud7ApL6Fby8LhVvEAmSWBQdud5j3G8sUuSZ/tE7t+tuLCaZdrtmmlhfM53xb9zHET6Bp3aq4xNasbWEmfxVQL9xFzlMghhm+r3NVLvjhEflqC7iStSz5KNyRcwZ9AlIbDcPCR7D73iy6pcUVbaApajd/QhtotwPkmrwceXY9x7gQnsKmPaefDhX4D4aNE35jXGVSBeKjgqu9n61fPOlt72Pz13m3YWtI+srarBpphkumXkRWjBnc/l1CnfjDR3q7Wr7l7ordiBZL7Sdycz/VHPv+VHN5kv658dnlNiqZD79omGJoic2z5qjjMlH46o5gle3V94iKZTAUjzvKw1d/EV6Qnvz7MWSmOEtbCb6uUCvJwEhkVxSDXhlZIT
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 767c3825-b691-47a1-ac19-08d768cf87c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Nov 2019 06:54:44.0488
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 3F5Xlbo4mrKYLgQP92KMHnvrFya1J1Eo+N0Zl59HZjTngsDZ3lQb/rxJ68RnM7PJrcLJOg7mCsU6PawoalhReA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB7085
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

>=20
> On Tue, Nov 12, 2019 at 09:15:18AM -0800, Dan Williams wrote:
> > On Mon, Nov 11, 2019 at 6:12 PM Bharat Kumar Gogada
> <bharatku@xilinx.com> wrote:
> > >
> > > Hi All,
> > >
> > > As per Documentation/filesystems/dax.txt
> > >
> > > The DAX code does not work correctly on architectures which have
> > > virtually mapped caches such as ARM, MIPS and SPARC.
> > >
> > > Can anyone please shed light on dax filesystem issue w.r.t ARM archit=
ecture
> ?
> >
> > The concern is VIVT caches since the kernel will want to flush pmem
> > addresses with different virtual addresses than what userspace is
> > using. As far as I know, ARMv8 has VIPT caches, so should not have an
> > issue. Willy initially wrote those restrictions, but I am assuming
> > that the concern was managing the caches in the presence of virtual
> > aliases.
>=20
> The kernel will also access data at different virtual addresses from user=
space.
> So VIVT CPUs will be mmap/read/write incoherent, as well as being flush
> incoherent.

Thanks a lot Wilcox and Dan for clarification.=20
So the above restriction only applies to ARM architectures with VIVT caches=
 and not=20
for VIPT caches.=20


Regards,
Bharat=20
