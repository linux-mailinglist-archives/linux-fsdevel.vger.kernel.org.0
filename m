Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B1698A78A6
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Sep 2019 04:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727168AbfIDCPA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Sep 2019 22:15:00 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:36980 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726441AbfIDCPA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Sep 2019 22:15:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1567563299; x=1599099299;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=iq/uynrBvbXpnk/5sSZfTopoEQYxpVIzsPuk0T4+4ss=;
  b=RWqmBtsqbqFRtO+dHxhiw1zAO7BBRppmcHFXvUyrYM/ewUHjV+8Qul0e
   81Yl5Ylgv2fy8RGyhk1Hne8Jt9G6CzCRqD0k+X8ZA4vqR/pKDUj0h/mu3
   rGz/MIJST6Yowgjb7axuWUUFx9y5UgusAFXedv0DtTQA36ZuxhnVspCCN
   ZiZa/to+ATLYuddDSx0hFzWZMEc/UG7zgFMH9+vL1PJs7rtosdjaI7mZc
   Zc3N2om9o74NlRHZ1xoGArlXOLRTpE6C5wXhUVL5wz2+M9yryz5mG258j
   mSS8nfz4bcVbqtNl4ERxeuuaPXq8zGjracv0rBW+vfjbim39GGyu0Fmut
   Q==;
IronPort-SDR: STNoAe3NZ3k0ueX/1EY1z01Zt3kqAY+4Tgtk9cMI76Sagqky2df0WFBWhmYJOypIyGb7Q3V9DQ
 qx0VBol7o4XCmpXCezyBRLG5Sy80FQVtWGvy0oR2VUyEwgMqKmF/kWF7yXsOfbvwnuU6nnj3bh
 mJt9z+JRKZTbS3GP6MOBZkfbemNjpVarM8D41aDa8fozj6YF1VfC3HMKccuDXivYXb9asb0Vgu
 KiK12lz1tAcysHWIm/0oXiAbwOE+K0+hrc00FFfhmNlOhQ8NIjgnY4ZpVcYmZMT/cGvkDLAnfD
 wW8=
X-IronPort-AV: E=Sophos;i="5.64,465,1559491200"; 
   d="scan'208";a="121913347"
Received: from mail-dm3nam03lp2052.outbound.protection.outlook.com (HELO NAM03-DM3-obe.outbound.protection.outlook.com) ([104.47.41.52])
  by ob1.hgst.iphmx.com with ESMTP; 04 Sep 2019 10:14:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jpNl1eYeGXm2g0CSNBg0sxeLkqmcJrh89DN5zzPCSSJT9fwSbPORoAY46XK5dKsO+5OxtMP8UrX91faifFXiVL/sbeqmboVZkPFnwH3WtjxNT7MFsZai7vjSYBOucrn4mlVYYlCXAtAHAdZQJcy7OpHXnoafx/NOXWH8zrQwamY5eFn07NQ4bCEGkesFnTt3YjYAYUaAu+z/dEKtnzlcr285nDuTC1tN41yQ7qetKM++Qh0Q349wS1Z2cQCoKx6kxfYSoi7o2mpd/tRhBuSIjnNTvO4P8LW8PNJjvuZH3jnG2EyO77Nqi7R1rBBUM1/74AZz1pwE/NskXlnGVsjYXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBQuPmyqJ6tDywB/qTd4fy+DmwAn4liPz5n05fFAtfc=;
 b=Ur+gHZjEZUjW/WJ4eyWhU0xTkECxRoQrwayFEbq8HSvnjSDH7sJXg4aehVfm6Vd7s2M4JlYRjrE7vh9w+CtkMeGJak8XJi+NTpRNetzkRsaL+cwbFoQFx6g16d7bt/nSgzt7ktKxoW7t5ammoIUAJ4zxqFEcyUfDml4oFEIrJsCRIfH4f+CLNwCPAteFSIpNmQyrOqjRaOD6kom+woiAIQvQt5Mtb4FD6aFOZAmw+f8/Zdo+lFBqvx20b72WDSq2E8aCjB1E7vZTZuLfqaS7gV1rVRfA/LzyEI9CPnpAcFrW4DM9hA2A1/hk9OKu85bg+K+u3RjW/DVru7ZZ5IpP/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XBQuPmyqJ6tDywB/qTd4fy+DmwAn4liPz5n05fFAtfc=;
 b=HvKhTU+NhLgfHXtNxxzt0BYatt43vrPF8vnpTwNyv/yOSsGizm3Q62nAKhVJsNUGResSlJoO68Ul4H3eBQ+ya7VC/wtgvrCJHIn8Zzd/HO8fptUFCGSMi844nDK0O5EySjSefd66roJ86p30FdQKeaoEUuh+GtAf4ezwvc+4Rms=
Received: from BN8PR04MB5812.namprd04.prod.outlook.com (20.179.75.75) by
 BN8PR04MB5588.namprd04.prod.outlook.com (20.179.72.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2220.19; Wed, 4 Sep 2019 02:14:55 +0000
Received: from BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59e:5431:4290:9bcf]) by BN8PR04MB5812.namprd04.prod.outlook.com
 ([fe80::59e:5431:4290:9bcf%5]) with mapi id 15.20.2220.021; Wed, 4 Sep 2019
 02:14:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V4] fs: New zonefs file system
Thread-Topic: [PATCH V4] fs: New zonefs file system
Thread-Index: AQHVW9uc9S7B9ZIieUuwphG+VS4vgg==
Date:   Wed, 4 Sep 2019 02:14:55 +0000
Message-ID: <BN8PR04MB581234D367C3D760AAA7387AE7B80@BN8PR04MB5812.namprd04.prod.outlook.com>
References: <20190826065750.11674-1-damien.lemoal@wdc.com>
 <BYAPR04MB5816E881D9881D5F559A3947E7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190903032601.GV5354@magnolia>
 <BYAPR04MB5816D115D2AD1AF3470C2A7AE7B90@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190903215634.GH5340@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e3a9c2f1-913e-4054-e582-08d730ddaddc
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600166)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BN8PR04MB5588;
x-ms-traffictypediagnostic: BN8PR04MB5588:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BN8PR04MB5588E7CD3B44D400EBE5F846E7B80@BN8PR04MB5588.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 0150F3F97D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(39860400002)(346002)(376002)(136003)(189003)(199004)(6506007)(99286004)(102836004)(6916009)(81156014)(486006)(446003)(26005)(476003)(76176011)(81166006)(2906002)(33656002)(8936002)(316002)(3846002)(8676002)(53546011)(14454004)(6116002)(478600001)(9686003)(53936002)(6436002)(66066001)(55016002)(5660300002)(54906003)(186003)(71190400001)(7696005)(71200400001)(7736002)(25786009)(64756008)(66446008)(74316002)(4326008)(305945005)(76116006)(14444005)(6246003)(91956017)(256004)(229853002)(86362001)(66556008)(66476007)(52536014)(66946007);DIR:OUT;SFP:1102;SCL:1;SRVR:BN8PR04MB5588;H:BN8PR04MB5812.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: QKNYuPbSKYTXRasXhMyuoddgpE4PGd+U8JThhr5XYwE0uhLkeEzB5rq5ovuuL113ng91557QAq844RAnpjmfllXv9YvYThcKH3/30a57lqxzgpf4Xa5qN8d63oxrRM9etgEpD3gSz/sltllYxetSq2eUzdxTgkdG+EEFF2FRAacm/2VrP6oTjVTLW7F9vJTY1DAYV/Qhdp7Wi6tyLFcNI4PuZy+WItOa2ncQ4e5YbJlNMcNEpX7vP10wX+dj/cUXEQny3oJR64z/02o0Wa/48Hywj1QMP165QZxp8EErTMtzYWp9s3xH/IGtK6zP4MZBD8yHjmkcn8gbKGmi3hx5EoKfGhSBjA60X+fsVcOo412by+WCgmuNXYBIYlEb1tzmwgs+AnPfniZimNVg+unSxU8+XVfDLTnyx+5p0lNuVkQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a9c2f1-913e-4054-e582-08d730ddaddc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2019 02:14:55.7206
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VZ3dNZAngi2mNNNysG8hbYU8d1JkwtV5WyIn4QyUDDR1VrWx4AcDHYrCjfTKKaA9Ly05Mr3OJAHhScKMRO06BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR04MB5588
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/04 6:56, Darrick J. Wong wrote:=0A=
> On Tue, Sep 03, 2019 at 03:49:11AM +0000, Damien Le Moal wrote:=0A=
>> On 2019/09/03 12:26, Darrick J. Wong wrote:=0A=
>>> On Tue, Sep 03, 2019 at 12:59:17AM +0000, Damien Le Moal wrote:=0A=
>>>> Hi Darrick,=0A=
>>>>=0A=
>>>> Any comments on this new version ?=0A=
>>>=0A=
>>> I took a brief glance a few days ago and it looked ok wrt the iomap=0A=
>>> parts.  I'm assuming you received the same complaint from the kbuild=0A=
>>> robot as I did?=0A=
>>=0A=
>> Yes, I did receive the same complaints.=0A=
>>=0A=
>>>=0A=
>>>> Should I wait for the iomap code to make it to 5.4 first before trying=
 to get=0A=
>>>> this new FS included ?=0A=
>>>=0A=
>>> Given that the merge window apparently won't close until Sept. 29, that=
=0A=
>>> gives us more time to make any more minor tweaks.=0A=
>>=0A=
>> I keep monitoring your iomap-for-next branch for any change, rebasing an=
d=0A=
>> testing if anything changes there. So far, no problems.=0A=
>>=0A=
>>> (That means 80% of a "Go for it" but I'll look more closely tomorrow ;)=
)=0A=
>>=0A=
>> OK. Thank you. One question I was wondering about: All my code until now=
 has=0A=
>> gone through a maintainer, even for the little parts I maintain myself=
=0A=
>> (dm-zoned). However, it seems customary for file systems to each have th=
eir own=0A=
>> maintainer and sending PRs to Linus. So should I prepare myself for havi=
ng a=0A=
>> tree specifically for zonefs and getting a signed GPG key for sending pu=
ll=0A=
>> requests ?=0A=
> =0A=
> That is a good idea, particularly if you're at LPC and can leverage that=
=0A=
> to get key signatures.  It's awkward to try to push changes to zonefs=0A=
> that aren't related to iomap through the iomap tree, and you're in a=0A=
> much better position to integrate & test zonefs changes given that=0A=
> xfstests doesn't translate too well to it.=0A=
=0A=
OK. Understood.=0A=
=0A=
>> Or given how small zonefs is, would you be willing to take zonefs=0A=
>> through the iomap tree ? The last option would be easier for me, but I d=
o not=0A=
>> want to put on you any overhead :)=0A=
> =0A=
> Most file systems are such big piles of ... code that it makes more=0A=
> sense to have the maintainer(s) be the specialists in that filesystem.=0A=
> AFAICT most dm targets are much simpler by comparison.=0A=
=0A=
Yes indeed. I will prepare everything needed to send PRs myself then.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
