Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BF9CB203303
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 11:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726515AbgFVJMF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 05:12:05 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26424 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725819AbgFVJME (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:12:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592817123; x=1624353123;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=ccHT9XrNUuXlt1TaFdRb+0d0Pxn13YcW23TVZCuyCrisJK0Vdps/quES
   pv45m5V1gVcFbF2A757sYD7KMOeD+GWaSThcr+2MX6++Coc0wIWDzaIFw
   i9JRPllDHuulFw/UESmwomiRhD+zEDYW0nBP/Hmsavd6c/Mu/nPQC2HxI
   iM6SEZAgknjyg+35vQY97jir0/e4H4NejZKABtPj/++ydFhm8E2wjJlpk
   s88BOl2JuI/Ya7xzze5Z8Q5X7dFnveraMDVbDFKUymHYTAUchN8rd9ZKl
   Db5CugtiGOLBKKb3v9tTibl+B06O64NbnRjzyMWJ2KEvhY169SQ/s97+H
   A==;
IronPort-SDR: 0mPkZYxvuQ7GK+YWs/JKkpzJjoeUtOH1xKaMwSJJIpFWzbin2KetFV2fGLcasYvW30fo7l5UCA
 Re5hZH994x+K4l3eR3L++p/n8QRE8ei9RrUMP//pVxJrbYCV2C1KVycrz159I53CmU46ijSqOm
 5226rvaB2kzUZzpShrv8uJVeVM9k7d3VFworuOeDnoEyYU0VfS8DxpTU2ilsZxFW6MEKwLCWVI
 thPEWv7QPA5gKQ9I54kGE0RI1s+oA0VFVJx4+sYXNEhJXPE340gF1zSjpZu1ndh5aPZ2ARSiQ3
 N9c=
X-IronPort-AV: E=Sophos;i="5.75,266,1589212800"; 
   d="scan'208";a="249797784"
Received: from mail-co1nam11lp2172.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.172])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 17:12:03 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G6qHMgwLYObpr689XtGqN/Fs1pa0UKDgns9FpTyuXj3sEXD+tDazm3o/fcduHfNH4RXY2EUUP1D2+w5YkbgayJsC4AhPzU4Eq3gZ9TcTyKgYoJGb5KkaeGv9lGoVAxq0MMQ9zMJU9e4q672ulh1Ew15a8aBUROi2t73FDYp0SHQb+DRShFGpUL3Crpmqqncz+m0VoV81ZInnOTRbE46R7Cr6Qz69d1n79rvnHDXLjBR87SWJw17JNIocQb6kKqVdygZ9kcZz0HXfMtzAg62ZUnyJEPsZDCl/GVUzxQhdAwhShBfMNAp4sT9IBba3FLBgcIRUTFJNIVTGmUE+o4FxtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=haJEM5eij6ErjajqTW34iEcjzqOEFsk1POFKAOit/LDM1jUTYTqSwiIA7kJzYKCgWDN8VgR8CFLjDS93lRPNxPt6QxD1lUNSQMktnl7iRNU/8sROtq4VI9pwXUSTIX0HfBuXkBqdoMYMmzZdHqZCAo9ieWttAYouFJbOWL7raCKRBaARnr5SVCl2jdMJkCkDFKGS2fD8893zUqt/8/aGeB9cktgX0Jn8EIFesQuybX/4wxcEaz2ih5Pw77BEbQ8HpL2zB/qm3D9RMJOEWthjcuefGZCV/9uj29nnSXAcRq8/0dyVUyfAPhGxGcUgyE9LX0lwxAsxfRBh+IGfouFxcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=F2K7QUJ4bVTR6aFhUJJv+TCQYmiZ6XF9/8uSB51xAGrPO2l/zjIawWMQX18Tk6kO7LauBBJzzSB32b3M1ZlWdj62M+0uVe73Q0NiwYSPjHIlKeemZQioDHjJYcskY7caHceOXWBVg7m4PfnKiXAnX1os/LlHyfyHsRDWMy4CI0U=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4543.namprd04.prod.outlook.com
 (2603:10b6:805:a5::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 09:12:02 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 09:12:02 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
CC:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 03/10] fs: remove an unused block_device_operations
 forward declaration
Thread-Topic: [PATCH 03/10] fs: remove an unused block_device_operations
 forward declaration
Thread-Index: AQHWRtLkB2deiCQS90ymcJt07+29Hg==
Date:   Mon, 22 Jun 2020 09:12:01 +0000
Message-ID: <SN4PR0401MB3598B806DB60117C908A3AFF9B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200620071644.463185-1-hch@lst.de>
 <20200620071644.463185-4-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c672fd15-214a-461b-c110-08d8168c5367
x-ms-traffictypediagnostic: SN6PR04MB4543:
x-microsoft-antispam-prvs: <SN6PR04MB4543D41F4EAE37A8670815C89B970@SN6PR04MB4543.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: b6kZ3cGxm9OKTgZQltxJ2ogrBK7NJEFtstb/0t49F8ixs8pOyrsNyYzxEnFnw9ftgOUBbyn/4yIAbTPlhcq9zk4oOtGDdAfh3DrWS615dGZ29noffAKjMWniHOTmTIu1j/N7NG16xx4pxvbywQjoG/hTMwZsmU1lUHYQFv+pIXOghqNRhOfodTumltboscCngtxjOocZG5jo3L6Oxj90aehN1V12GFG7wdIXpht+4ng4Ddaj8NRKUxIQfwv6Zuj9TaU5G4S7qLdlETjGb6pZoNe00ZUW64q3Gh6bHLlA7e9mpnInJbPMNgYuEtWConnEL5qJd2QygTfjnu33WfXoow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(39860400002)(396003)(376002)(366004)(136003)(346002)(8936002)(558084003)(478600001)(2906002)(9686003)(8676002)(76116006)(91956017)(66446008)(64756008)(66476007)(33656002)(71200400001)(186003)(66946007)(66556008)(86362001)(19618925003)(55016002)(7696005)(4326008)(6506007)(4270600006)(54906003)(110136005)(5660300002)(316002)(52536014);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: GhWiPWR031A4iH2dHxDhpRZ0/QepvLUZuvNu2L+9nWvU4Dzh8svrWkL3CQByDLGIDUlMnkhGBdzf8GQxLhWhjRNV4rQZqhuASAWLgHEO01UynW9z+An+phZgiJtKyU3lg9pTSQd3OhLZQa0Otciqdi+ojglqr8lLD3AssKzrSenn7pyJ9zHa1mdnWO6Y63U3VIyXo2aGW1ZofT8gIBzOUtAEV0nEJHGr+i5VWozfimR7hpkkvgHs9ITOSalh5Wf8zv5fI1HEBvQfLnm45nQgzlor29hfUWg4SUNf28jdpIhVi5IEjoFONSoYseu5RbqSDmgnor3vbKPx11DNkRH2ELmdYc1gFtRrvPm5oLPpSGfMrCHmHIm+N+T/F33ght918yabxwq6HKL2/sQicLs7Btt17hTAXSjCp8YZ0P2LQhdHTdq+np8fftGCVfMGY0lTbUB7C2fahZ56PSUFGffBpC8sNlO/DpV1/zCrGQSfxeQVV6nGWAq47X0mOM+/dswr2/p3QD05jR3aEaZuTYLUp+kBIFSCq6RXoaHV+VZ1RKJLHljuZkwuFO7TSSIeVYtm
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c672fd15-214a-461b-c110-08d8168c5367
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 09:12:01.8390
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vDebUKgoRpuxqw5mIltv561bayeQdfmTtb5GrVPDsVdmf5hXituVboE1420hkYXCBTMjvJ8fY5zZFeX7h/4l46GBvdbVynJ09Bf/JifED5c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4543
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
