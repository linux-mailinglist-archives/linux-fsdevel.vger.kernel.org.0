Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A3278A78AE
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:19:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbfIDCTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:19:24 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:13806 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727065AbfIDCTX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:19:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567563563; x=1599099563;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=BqEv8f2V8Lz2K3IJzXdOwPgAEB7b8KAUi447UvFCvHQ=;
  b=dOtuoFE7Yf2tdv66GeYCQrhCeAORwC1D+A075shHtGK8gHw8luv3Vdgw
   ouCMtmWXgMG/4ezuNKU45+gdHEDCR8ciP2eVZqOc7FGkER/XubNGQYHYd
   RizERgjzGpeZ5emFXC9S69ruHWrySOdvhzBlR9AMh9hBBLreCxkDTwbSW
   486kpejVkXOLo1mb2ol2b1R6qgwUaUo4AoZzTA3GWxothC6HLapFgTKHy
   yGuKMgZNIt/w9IMTiIhp7V5pbBhLNMhiTdVM6+VHq2kdtXQtW5WdoXrfU
   YJqIeTUVY/ifRcYTaMHMUo5lByXUpwHSUJ/76wThqtAPIsJgkmlfxkvUd
   g==;
IronPort-SDR: EIFj/xIrJPpsTHk2ovT75YJxyabClG4HLS8gA2uDrNPc2kx94NnByq8NVM13srTp9E9mmuKBvq
 /65QTyGHf9jJwsxWr7SDcnRl7mTv706rcyZsdiqZEiS732UVPBKQGZM2FSfWaqFl3kpkZSFd4i
 ME5boj4Ogm3OP2ji+xgq8SNWDanv/CqWEhpb4+DwU+Piv8I6SAC60ix6LNdskiFJX6tb2Y5lVK
 WFbGxKViaCPYfgoIAH7d0kSb2rzkfBRoMJzYB9YyTi4DWgHpfpcjici+6yZloxYcKoMOmrH8r+
 qF0=
X-IronPort-AV: E=Sophos;i="5.64,465,1559491200"; 
   d="scan'208";a="224071156"
Received: from mail-co1nam03lp2059.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.59])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2019 10:19:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aBwowodQucs5td0G69XEVDxTdUX0zX1UkjT3UAxorouC+Xm7CV+hY4ThmYa9tjxtV/ELREKTa0hfZXls7VK7WL52XChbu8c+v3+2kKCYmFKnSwrYdqDGa0Q+vr4lNHg0LA9Fu8ae+kLjMB4wWy4jez36ZWn5sAAAIFU5/+nyDCkH8i38iRfX1j8J/ZRrC059edNKhot3Tj5aEB/FPdbdzcRCAWBBgLbznIEr6eD4kgZbcx7BPGS6PErlt87MlZAnDCkpWMxmJoYP33Y0b4dCLYUeNHGwNOEpKwCg9hBXJlruX79IaJe7t3oC/az4YsJGTar8VG6vjv7okBGVqNGyMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaYiQrD3hYXUQDoMDU5Qo8LFBTiWFzwLt84BvUQ0xvI=;
 b=HifkxSzb3OY8rETcWo5NLK3lSEoLV4BbMZUuRLJPLzW7A34Ca3i7Zm8R+bEZtFr4wSI7/d3cJnyQWn2Un+fY5/r/aKKtgdmR7KTZ/5AXmTW+QlIiCFjs/pZ+iL6HEgCFjZfuG019y+2Q2ruXC3pYZCuIcejWGRY45zGimBYAOa/+4MvPmXMOIp3obU6bWGUmZb5mD2YaCKrbDF6ZB/JGjZQd8ffS/9PQkeDya1ERj00zZ4GZSIi9dSGOhhLXATMB22xAHxsJzSNFiAz9285O7rM4QjFz0Lt9xL82t7UA4acs8FvquA9u0thpiGrFvprtcbf8hKc61A8F/uE7rqcA/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iaYiQrD3hYXUQDoMDU5Qo8LFBTiWFzwLt84BvUQ0xvI=;
 b=yppxy9Y+oIeGe43ElSWCwGgxyxRYnw9jpqmj03o4tcIlD3NrJgTFnphlEOAu2YVp+0j4Y/9vpGV0G0Uy7J/SvTTdkfj/pek4XjzbxUaE0JFN0nbAQ+eyywKW+PFxUhcbHfOCLsDM4usGi8bYaAHaLHCjncogfMb0fLwmsraGNmA=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB6065.namprd04.prod.outlook.com (20.178.215.83) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.21; Wed, 4 Sep 2019 02:19:20 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59e:5431:4290:9bcf]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59e:5431:4290:9bcf%5]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 02:19:20 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        "agruenba@redhat.com" <agruenba@redhat.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.de>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Matthew Bobrowski <mbobrowski@mbobrowski.org>
Subject: Re: iomap_dio_rw ->end_io improvements
Thread-Topic: iomap_dio_rw ->end_io improvements
Thread-Index: AQHVYlgHvMsTW5bPtkGqhSJnJscvNA==
Date:   Wed, 4 Sep 2019 02:19:19 +0000
Message-ID: <BN8PR04MB5812B14013BB4CB892F33B20E7B80@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190903130327.6023-1-hch@lst.de>
 <20190903221621.GH568270@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6fb9816c-6996-4b7b-ddcc-08d730de4b4e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB6065;
x-ms-traffictypediagnostic: BN8PR04MB6065:
x-microsoft-antispam-prvs: <BN8PR04MB60653E698D81B73D060EF3C3E7B80@BN8PR04MB6065.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(346002)(136003)(376002)(396003)(53754006)(189003)(199004)(4326008)(486006)(446003)(54906003)(110136005)(55016002)(316002)(25786009)(6246003)(9686003)(256004)(26005)(6436002)(102836004)(53546011)(6506007)(476003)(76176011)(14454004)(7696005)(99286004)(71200400001)(71190400001)(478600001)(66446008)(8936002)(66946007)(5660300002)(76116006)(64756008)(66556008)(66476007)(91956017)(52536014)(6116002)(3846002)(81166006)(229853002)(305945005)(7736002)(81156014)(8676002)(2906002)(186003)(66066001)(74316002)(33656002)(2501003)(53936002)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB6065;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: rjC34b9d/OpnVodrxfrQjNPPPmxYpm/gNH19t6jgETOMrayBAq/nu3y+so+RGoQTJc88RgZlwI6dgCLs9pkLcKgKKa1isNi6BbFjLal1p1oW8o+6JMwNQJ8IEzuhonYDl476rx4yrHkxPP8EQ8lcAx67Iff8D+wCsoU3dM6Uh9/Y/IxwwYfv/YJ72dVwuJ6oUgT6Sv3Qc1VD865doPY+tmBWnGdB/Q88ZlJZvR3EM57c4tVjG99Y2XS1MD8ACVsMU0U39+z6gzGbaMa1GR40kLLQLr2jrmrDZlu7ruIjW665oITGFVzdP/9ACzHfmNsDuNvIGIY3q8MnD4hIy53RlpJLzWXw3MGA8DYIWQTQLSY+vjDoelmrwh+dLF4j6fLP7EHmECX4SkdWQ94Y2il8vCp08AuLoPt1cdQ/0zR2Y+M=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb9816c-6996-4b7b-ddcc-08d730de4b4e
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 02:19:19.8958
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 30VTstTfHiSk4xrztY7B+G/86LTlguJ5Sb68eM6tIjYItP+uK5i3lNK6QudNQ2A15PrbNRg1eUI+vVxtW9FxkQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB6065
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/04 7:16, Darrick J. Wong wrote:=0A=
> On Tue, Sep 03, 2019 at 03:03:25PM +0200, Christoph Hellwig wrote:=0A=
>> Hi all,=0A=
>>=0A=
>> this series contains two updates to the end_io handling for the iomap=0A=
>> direct I/O code.  The first patch is from Matthew and passes the size an=
d=0A=
>> error separately, and has been taken from his series to convert ext4 to=
=0A=
>> use iomap for direct I/O.  The second one moves the end_io handler into =
a=0A=
>> separate ops structure.  This should help with Goldwyns series to use th=
e=0A=
>> iomap code in btrfs, but as-is already ensures that we don't store a=0A=
>> function pointer in a mutable data structure.=0A=
> =0A=
> The biggest problem with merging these patches (and while we're at it,=0A=
> Goldwyn's patch adding a srcmap parameter to ->iomap_begin) for 5.4 is=0A=
> that they'll break whatever Andreas and Damien have been preparing for=0A=
> gfs2 and zonefs (respectively) based off the iomap-writeback work branch=
=0A=
> that I created off of 5.3-rc2 a month ago.=0A=
> =0A=
> Digging through the gfs2 and zonefs code, it doesn't look like it would=
=0A=
> be difficult to adapt them to the changes, but forcing a rebase at this=
=0A=
> point would (a) poke holes in the idea of creating stable work branches=
=0A=
> and (b) shoot holes in all the regression testing they've done so far.=0A=
> I do not have the hardware to test either in detail.=0A=
=0A=
For zonefs, the changes are not that big (thanks for sending them :)) and=
=0A=
testing does not take long given the lower amount of functionalities compar=
ed to=0A=
a regular FS. So regression testing with changes to iomap will not be a hug=
e=0A=
problem for me. I can do it if needed.=0A=
=0A=
> So the question is: Are all three (xfs/gfs2/zonefs?) downstream users of=
=0A=
> iomap ok with a rebase a week and a half before the 5.4 merge window=0A=
> opens?  I'm still inclined to push all these patches (iomap cow and the=
=0A=
> directio improvements) into a work branch for 5.5, but if someone wants=
=0A=
> this for 5.4 badly enough to persuade everyone else to start their=0A=
> testing again, then I could see trying to make this happen (no later=0A=
> than 5pm Pacific on Thursday).  Bear in mind I'm on vacation starting=0A=
> Friday and going until the 15th...=0A=
=0A=
No strong opinion either way. I will adjust to what you decide.=0A=
=0A=
> =0A=
> Once iomap accumulates more users (ext4, btrfs) then this sort of thing=
=0A=
> will never scale and will likely never happen again.=0A=
> =0A=
> Thoughts?  Flames? :)=0A=
> =0A=
> --D=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
