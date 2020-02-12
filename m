Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E55B115A28A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728287AbgBLIBA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:01:00 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:49735 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728192AbgBLIBA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:01:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581494460; x=1613030460;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=a/iP/gP29COk2cDj1DudjGu2VyBIsmEt58S6BpoLgjSS8+kC7RItorYM
   w1hEPUPh82K0SAKJhwkC1xka9v7iC6Xx3TS7YhiB4kthILMNppYI/NZQ1
   YokClg7Xcz5Dax0hOzvvIwG0jRf7tEMVF0knKE8SK41mHumi4bWQS6hBc
   xhuqKLRyVQPUt5XLRtsgbeDUHXDz2dTlLK9Rppv66PraIwdA/nW5YF66t
   E1dUtzLCmSEk6xnPjK9RMsJ/Ga7tlychIDKo7K7MNKwDiiLDrdytby0+A
   tIkPFlWtb8te1Xc175HlubpG+PQhHg3DqdaHJp/foUmSnseVvNI4PLchy
   Q==;
IronPort-SDR: VR/AOrz81lVt6YcpBDTIxMy9BrgQpvJa5st9wKQsYUg5ehVU9D8qfAvuVmZez9yKyhlrxwbbEn
 8fh3GWferrj+CbQr8fTmCmC4pJ6i1yxHtkk5i+zCLFqMaNTai08+Ekq0rb9MIDDlWfK+w4D04j
 gNOVUIMpX3rgdmyd5tmGgooAPLKeXZ33UAlGQq9ZAaQDd61GGzurHqkZ2th3fwX46+H5uNXwdY
 DACW+/vVuCUIEpIoU/Vq+R3JmnGueBy5BzOvQkAa0eRZMfHJ6qkpXTN5mMp08UvUcJOhb3YzmQ
 9wI=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="131103050"
Received: from mail-sn1nam04lp2058.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.58])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 16:00:59 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LlEhrz2irdRw//Qvr0KJ549arJwhQoeJP/xiLfKjMzTsPQd1EuekcfONIiovnbpCo+9Kr7KI6XQK72VgPcZANaLEWz9ylWIZlYq50mLEnzwedZxXK7KjvnLm320/bfpTzB5u3NTbTCMGNY3d+OpmOWNqBABhhF9HL+55wGYJQd0TadGeGyqb5ErkPgEvu2R3n6c+xe7I7/9eqaDRYN44fz/eYvbRJVg2Xj7o/sFb4DxcosIbKK7mBl02VWniKg3Vqm7ohc9mvhyE60GXOSfNbQekhyyXD1AJUFMCYbyntie2PABr91qDQhxiVANuAsFFmhqic1jYcoCbIkhgOG1K0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=IuOv2aItKSGMnqoLJcbjaeWI+T4zkbGIsryqxegbBIFFyZVq8oyQczxcWuugibhxLsD1Mum4Tch62sZ5Ecwktx4fV440J9JmfP91avT5cu/aLIkl5+qGC5ptxr95JyJG43n/h0HSUYdS9grg6aHawMAfP+1dNGsQbL9L8tbcI5eNMWKmdLPuFhsfKgsPBj0Daea9y7X00bTaAXa2tjWlxLPqyFG5EdcOv9zRlMuYT/QYzuC//QtF5aIo+5jb+eEeBbJgiKXDIZ9R1t6sVNDZNzkdHPaXlV79lBN2R4ow8eimbjf6Zbg4Pii2p8yDXZPQY0aQxgo2ZJAJWJpqQRF8IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ut/3npnvnx34NKWkmc68pUNW4rWHgAVDvpmLeEZjzjTueUUKK8H4cvgl0ncJLGESWu94pGu/VL4xNij6hYxdk4rXfnQObNykoI+lqj9fB1jp7dVbu8dPnAZROFqwmX0NSYWK60IvesuXdfTLtzcL03UzZBxCu5PW0zPP/oO+Q5A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3518.namprd04.prod.outlook.com (10.167.150.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.24; Wed, 12 Feb 2020 08:00:58 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 08:00:58 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 05/21] btrfs: introduce alloc_chunk_ctl
Thread-Topic: [PATCH v2 05/21] btrfs: introduce alloc_chunk_ctl
Thread-Index: AQHV4XUDcYRtMa6F7Uyr2P6MjvZUCQ==
Date:   Wed, 12 Feb 2020 08:00:57 +0000
Message-ID: <SN4PR0401MB35982AF7DFAAAF884D32AB2A9B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-6-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc16caab-bbbc-41ec-2798-08d7af91b190
x-ms-traffictypediagnostic: SN4PR0401MB3518:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB35186FA746678A6FC6A3E0BE9B1B0@SN4PR0401MB3518.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(39860400002)(396003)(376002)(136003)(366004)(199004)(189003)(19618925003)(76116006)(558084003)(478600001)(2906002)(86362001)(66476007)(66556008)(4270600006)(8936002)(64756008)(66946007)(91956017)(33656002)(81156014)(110136005)(8676002)(316002)(52536014)(71200400001)(5660300002)(7696005)(186003)(54906003)(81166006)(6506007)(26005)(66446008)(55016002)(4326008)(9686003);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3518;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jPc7gjQWwYVgONMWrtZUUEPc2qnBejsJJwrrRUR/ZWzcxltucKEOrGDH/a+5Cb35p3pNGd4gJJ0KcvmnBirhfOaxtcKdf9YqerBHrnmk0tsG2p9ReSeawDXpEMr14M+TNKV8vLZzo3W0ky8xa//qKqrCHmHBDHLg5kOLh82yTwH8DZ8YcLO1J+AaflB6u4n5A19ANpiQ+70kIut3X5hdJfANOzvWsb2BHIxRt6dJNLmfPBA5dDth1O2HqHr9TYYJcSt7SPDBH8vRuH3sMMr0JbREERhxqEYXAGS/7+smFvE5oFieqBOIDb9OOATYrhtT1SHXBLLq9DGdsVo579GJtAdKu7ubPkBYWr/rzmGQTyHxPUaoVkgVGNWNm6n2M0muy4U+0gEXToniFfuX/Ho4o7t4qXTTjd/uwokCkzfKtpKSfTsIChqs7PrNy3bvpwMi
x-ms-exchange-antispam-messagedata: faHJIGy50I4b4zw0M+b1wai2dqUiM9sMqDgcZuevasC6GBGoB6pHODTkZ6o6XFanK4rqNbnAFGVA/IsLL/vxt5cYtiyKC7kpk/K+hNdeQuRYyyr9Ww7TvaX1HD6bheAFBO61tV8X6gbV/jlNXPSpeg==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc16caab-bbbc-41ec-2798-08d7af91b190
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 08:00:57.9118
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bjlqs7JZvG43D3Dlu0i9Szv6G0lpOgfXNkgkypb1dDGtFx+MmZUBrunyUuD9UiZt7xCqfASrxjv3xE+/SQgo7pPBekqSlwCBCHjl05smWFs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3518
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
