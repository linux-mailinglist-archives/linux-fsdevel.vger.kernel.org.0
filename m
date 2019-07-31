Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E12937B8D3
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 06:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387531AbfGaEiC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 00:38:02 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:28230 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726439AbfGaEiC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 00:38:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564547881; x=1596083881;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Z4V7k2ilPmnBrfFZ4g6KL8uY792h7usveBb//YnFomw=;
  b=qYRInld73iZeqfVhdYvjTe/7XxzmxltdKsY90Hy/273qvsJAwoWdvQpA
   Rc5sTah3+/SBRYTdFIqE4/kzKIF0wExTKx5T1Z0A9FeDvaNJytyUG5xhu
   Lyydm2eDfI0SoaSYBawQNdeg3eFFxn4XLZ6xfKGGsexzw62jP1MbBec50
   aSATJXlc6Rrp93ZnJaEotDbW7m47nN1esS47atCA9cenKLOX8b9+/ndQn
   zWMHlw20uGM7bDWXKYf+jddwoJq5n8IqvDFXZZFartoWzWj98iJxBQjBG
   nv4CeYuwm3mZuAJR2lU280eDyWLSPXEBM2elviFR7QxPgy0QalCoAiLWC
   Q==;
IronPort-SDR: im/UiE3UCMlRmIhE6jacnS27u9uFnLojua7efIfYDO54wv3O4AWj7dHhqq7foymF6M4I2sAMwz
 vbG7ZpU9zimBlVV2L/fod2i6yJsrrcz92d52G2vUYY2t/DyonLXsj0e8M7WDu/NYIFE8mX+Weh
 Q2jAoj/YCL6ijzJCaB375BktKnskdaRbf4e3oh149/dKRnPiSk1QhQnDQVwTUpyUEOtZ5U7Ai0
 wR52E+M8SrUcZeABoIvZub9TLvurf7mRLanjWHtBXB+hTJa6g/m2OkDp5wIZcLQZ5uhYWzWnwl
 B1U=
X-IronPort-AV: E=Sophos;i="5.64,328,1559491200"; 
   d="scan'208";a="116149744"
Received: from mail-co1nam04lp2056.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.56])
  by ob1.hgst.iphmx.com with ESMTP; 31 Jul 2019 12:38:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aYbmD9AgKaNz6xoqjuq+D7VlL9DHnj7m117jJFjBDk8FzyzsjCJkj9LW4xvJGF5tdWjCvxIXgRm8yRdODw7jvOPWZKMVVA9O7/+flux5vE73b+GkBPb5AACpRjjhhfD2pyRWTTe3T8xyX2UpNJpHdF8O+ZfaDrJtBmzPs+3vjXTcqqOeMh3o9GH50tbqKqvkXRbs5NlbOKG9cLWTICCdhCm04pUEkDqiUTz33E2cPThy29TTb0F3uD7Yg02nB8yzdAMoOl/DRa4DSXYULi+zjWN/amXiV+YrcW4Rh7mErMZ5+DGm83IPlboHVX+CnVoO6VS0o0bQJDClxW210fS6Kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4V7k2ilPmnBrfFZ4g6KL8uY792h7usveBb//YnFomw=;
 b=ckuBMe3zGpJnv++zxgFRJuv+hu0pdO8vUQc41Bo6JmikahDLsXjRS2LeBQn4cRd1E0AQIqR2W/Zn0yIbh4ofmmhhvDDjfanOdDlIL2VO5OHGxQqHxnDS3OVx++K7HyGNmbQOyuFqxTsmkN7AT4OXmYa4qc+B+Z9S9/CuXfmQg8TfZBiEj/SSkk5i5Mq0j3icHaznAzuQoNkOouB1boPGTVTCy9fj6XRlBDbtWO6L8b0vvK5yumWV7h3Xi9Lg1/UQgGvQ8/1z2+CgZIY+OUNkm5fMeIXSSzhHCdPIwyftwuqw73NHYvOBFFDZnOPcof3kslgwDGKQK3teGqGV1r4O8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z4V7k2ilPmnBrfFZ4g6KL8uY792h7usveBb//YnFomw=;
 b=sw1BGNsFzQ0vaS5LG+7bZ1qxYBUlcWVdTu68zp64mKdQX3jGs9cBfKQv7fMiYqnf3OZQjbTENN4JRdKhHQ6kcJu/V6Ig/sO5LJ5tUnCBy61CadSAD8SMiopQEwOd2PGJH7fgna9R1SSHQK+5q1KlzesBTPw/tkddKqez7v7W264=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5761.namprd04.prod.outlook.com (20.179.74.211) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Wed, 31 Jul 2019 04:37:57 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8818:ba27:ae48:ec30]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::8818:ba27:ae48:ec30%7]) with mapi id 15.20.2136.010; Wed, 31 Jul 2019
 04:37:57 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     Andreas Dilger <adilger@dilger.ca>,
        "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Masato Suzuki <masato.suzuki@wdc.com>
Subject: Re: [PATCH] ext4: Fix deadlock on page reclaim
Thread-Topic: [PATCH] ext4: Fix deadlock on page reclaim
Thread-Index: AQHVQswib+fLuRINzEOhyZKScmS/IQ==
Date:   Wed, 31 Jul 2019 04:37:57 +0000
Message-ID: <BN8PR04MB581229D9A42D3323077AF823E7DF0@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area> <20190726225508.GA13729@mit.edu>
 <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
 <3D2360FA-AD48-48AE-B1CE-D1CF58C1B8AB@dilger.ca>
 <BYAPR04MB5816BD641DF55A93986DF826E7DC0@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190730234716.GY7689@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4aa6f22d-9163-4553-fc90-08d71570dc95
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BN8PR04MB5761;
x-ms-traffictypediagnostic: BN8PR04MB5761:
x-microsoft-antispam-prvs: <BN8PR04MB5761E58D6423A4270736EA53E7DF0@BN8PR04MB5761.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 011579F31F
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(376002)(396003)(136003)(39860400002)(366004)(199004)(189003)(91956017)(2906002)(478600001)(81166006)(6916009)(66066001)(76176011)(256004)(53936002)(76116006)(33656002)(8676002)(7696005)(52536014)(4326008)(71200400001)(66946007)(55016002)(9686003)(486006)(5660300002)(71190400001)(25786009)(64756008)(66446008)(66476007)(3846002)(186003)(74316002)(446003)(6116002)(66556008)(476003)(68736007)(7736002)(8936002)(6436002)(81156014)(102836004)(86362001)(53546011)(305945005)(6246003)(316002)(6506007)(26005)(54906003)(14454004)(99286004)(229853002);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5761;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: mGn7SXuibzkBAYvibYHu+TCpIb54xPt/ns+oimba8sibFuTaRahEqgHlpy9p0QhkqB6scv9n0AW2laj8qABlPThtsAgmELTI5gDD7KStwMWu55zo+WAqMIQ8+hi195Xs9IF6naPsfdE2saPcSiJ9gKlHDuECgjSdV5Cjj3LZMUsCsBE1RNiRcHC11pvUehGa5tIRSq60KFs/Mj8LOhhkH2NCPYhhxgebL7HTMI961I931o3crKJenGZWY7gwq76RwToyWjgFDzvK6ysd9XBfxYoxeMGzNQHnMBdM6UQVG/p4yXr0gp7yK8qEqu8gjLS5kWAL5+StvvpGBM0edUi61ShPnli7EVRepovHTbsgWmiapvFjJvrzGgeQS862QvMaccPr5d0Nr0/n++WaQC4bqksMmSLVGXc7cb9D3f84vQI=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4aa6f22d-9163-4553-fc90-08d71570dc95
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jul 2019 04:37:57.6572
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5761
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,=0A=
=0A=
On 2019/07/31 8:48, Dave Chinner wrote:=0A=
> On Tue, Jul 30, 2019 at 02:06:33AM +0000, Damien Le Moal wrote:=0A=
>> If we had a pread_nofs()/pwrite_nofs(), that would work. Or we could def=
ine a=0A=
>> RWF_NORECLAIM flag for pwritev2()/preadv2(). This last one could actuall=
y be the=0A=
>> cleanest approach.=0A=
> =0A=
> Clean, yes, but I'm not sure we want to expose kernel memory reclaim=0A=
> capabilities to userspace... It would be misleading, too, because we=0A=
> still want to allow reclaim to occur, just not have reclaim recurse=0A=
> into other filesystems....=0A=
=0A=
When I wrote RWF_NORECLAIM, I was really thinking of RWF_NOFSRECLAIM. So=0A=
suppressing direct reclaim recursing into another FS rather than completely=
=0A=
disabling reclaim. Sorry for the confusion.=0A=
=0A=
Would this be better ? This is still application controlled, so debatable i=
f=0A=
control should be given. Most likely this would need to be limited to CAP_S=
YS=0A=
capable user processes (e.g. root processes).=0A=
=0A=
I still need to check on FUSE if anything at all along these lines exists t=
here.=0A=
I will dig.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
