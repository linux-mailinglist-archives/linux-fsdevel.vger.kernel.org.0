Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D997B8337
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Sep 2019 23:19:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390047AbfISVTh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Sep 2019 17:19:37 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26650 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389707AbfISVTh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Sep 2019 17:19:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1568927976; x=1600463976;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=oIAzALbG3ajuHh1JFSray6a+XFmvv5wLVPKLgWyYSb0=;
  b=Ynp2qZqm4QAoRiwqxhqi0lIMQIR+CaG4nRsnh+v+G5DjlDDrIZJip6mI
   1/+bmc5ami5QM/RvsUB+So1HsztnXLYihxgRW2wgclJj3T10jcwZi91hk
   Q6WmmJLaTbPhdsRQ9g9tLUqGj9fZuN2TFdzHAKOTDEKiZ7NFXmb+J051j
   /dQJDRnXu9RsXUasls4rrBubz2mhIYgkvyb+ZxtJ/QomeGEZpDro5om1C
   q/Yjtvf/T2+Fpx41dogTUqaafC8VWcWfcArhtcmBwg/2Nn82KPKmaytNc
   zW12M0SBEew0sEh3wQVIEeVO06mk01UYq/Xhcquyk2Gs76dsrtbE4DsFz
   g==;
IronPort-SDR: qoZ8k424B9LbYtg3UkdOnS54rDribtSx1xWgOrtoeYCIGZsWDo2zefiOenv7dCrXwXhvU2Uqx1
 WPqOFwnl7BXvE3S1cjSELpJxxeOWRRJWOjSMIH93KE6q2I88Gf5yhUVaxkxRejUe/ZOBosgOJr
 IAK5/ztU2QTizq57MRIfCkTRhk80ErpJwIuxzR1GTrsOC6nn2YDbjHxsEFlWBg3cWmIEhg1KCl
 RRaQE6UMocIynEN0itErIiS5c21LQqyiAP36138XC393DhLVz/yYU1navCv+JWdbbUmDNT85h6
 kqw=
X-IronPort-AV: E=Sophos;i="5.64,526,1559491200"; 
   d="scan'208";a="225495917"
Received: from mail-bl2nam02lp2057.outbound.protection.outlook.com (HELO NAM02-BL2-obe.outbound.protection.outlook.com) ([104.47.38.57])
  by ob1.hgst.iphmx.com with ESMTP; 20 Sep 2019 05:19:33 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EEhT+ncfw9i2/XckWTWpiy9hSU/Q5B+Z10n/63ptdwyKlf3Ugtgq9egEt9KbCVeq0wH//CWGvCW3voCzv89l+mbG0/uCLFPBl30A7ZqYt6Nd3bPcQB7zsQ0MZ/1vtwvv7OPEbGkAue+L4eC2dqJ8PEhcAMW8ws55vw12HbclGp8xdOGBIqIQC+9TZ/PH6l1Iji7B2Mqv9MwazPv6h66COFZLLPrmifPtr1b1ZTQzXGcu8IyaHzq28zMpDhRqC27pu00VLROQRLTJzLcO5iOqShAO0nriRQBj8Z6t1YT7vHFwbI91OYOvPB7OXZ2d/TWQPBxQPY9Mdi70AXMZTLFbqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e44p7n5ZNvu+4xYyrsMdDD4jSNDLOI8Tp+ueq39uiiY=;
 b=XI4/SC8FxnKcUjERcrnpwGyVJTvzEym03JAJZW+KtBxF1ulDvBpW8QRpdFhQeFhfEilZFwkNEOaxLREJb4J6iboqvmb2YLiE8xhl/kqA9bwhapX8sXapIvsqzBVpzQTrBdSbsSF7AzoTCTeXZtuAwge3Pdceem6gNCKm/djpbAvx3wXuyPFbn1y5CCUkCYvtSic4whdVeZvXy5HfY2ad7uzxzrGZdxQkyqL997mz9Gpa2l0U1SRqA9JiCHTJdROhs0msOzoKge5RLPgkcrti2VXIMCKzIs2RzVx1yPEKoNBZDHHv2SR0JJxaN0mI0vdz/ysn6D9/F7GGbUpov7JY8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e44p7n5ZNvu+4xYyrsMdDD4jSNDLOI8Tp+ueq39uiiY=;
 b=Jx9U4/wbWEDLMg36B/QXNSwgiFm+icULIKombJM7DK14AjWM39Cwqivvs5sj8wxaCJ82weJ/V5hVHt/08Ocu5UJHtn91KXPG51bA4iCod1l92jKDvGPdDfiRa8W1+Hz1Gp+EBXkhhvDoszr5jZmePAf3aK8VgW7b9P7KXboPOig=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5685.namprd04.prod.outlook.com (20.179.57.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2263.24; Thu, 19 Sep 2019 21:19:32 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::9821:67e1:9799:b117%3]) with mapi id 15.20.2284.009; Thu, 19 Sep 2019
 21:19:32 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
CC:     xfs <linux-xfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Thread-Topic: [ANNOUNCE] xfs-linux: iomap-5.4-merge rebased to 1b4fdf4f30db
Thread-Index: AQHVbwApqraejWyP+EqCoHaEIePvTQ==
Date:   Thu, 19 Sep 2019 21:19:32 +0000
Message-ID: <BYAPR04MB58160BB6899EA306089288C6E7890@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190919153704.GK2229799@magnolia>
 <BYAPR04MB581608DF1FDE1FDC24BD94C6E7890@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190919170804.GB1646@infradead.org> <20190919194011.GN2229799@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.44.250]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 248c93a5-db3c-4abb-9207-08d73d471082
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600167)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5685;
x-ms-traffictypediagnostic: BYAPR04MB5685:
x-microsoft-antispam-prvs: <BYAPR04MB5685FACFADAFA2FD83679B1BE7890@BYAPR04MB5685.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 016572D96D
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(346002)(366004)(396003)(136003)(376002)(51444003)(189003)(199004)(54094003)(52536014)(64756008)(7736002)(81166006)(110136005)(54906003)(66556008)(66446008)(66946007)(66476007)(76116006)(91956017)(5660300002)(74316002)(81156014)(478600001)(66066001)(6246003)(305945005)(316002)(14454004)(55016002)(7696005)(99286004)(6436002)(9686003)(6116002)(53546011)(33656002)(3846002)(6506007)(71200400001)(76176011)(486006)(25786009)(4326008)(186003)(229853002)(446003)(476003)(2906002)(8676002)(102836004)(86362001)(26005)(8936002)(256004)(71190400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5685;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: pEsc9BCMg1ffaKryYiAFF3Fclnfajo2Lb4c/yTHpkB2/kOmqzJs6nOT8kPj7wTU8OwBaegjJwYgLN4Ch4EV/iNIVet9t945BgNKO49WiCG7HilCmKfNVFo2fQxPmU5vZFnE9N6C3I0OxjPni11nOg+AMwpLXq+TaRgKwgro2b7ZUBPFMff87pkhftZm05Wib3xtyWUTI5h/UB09he6TOMOlAUBpMaxXn8IUmztjx+D3xzIMG/OxeUSacNwxqEDSXjlroIEB+4Dei24Mxe7NVhK8oXJVODQyYaEGjybUVVy7hsn+FkLLWdTeLqnNvDTA+377kZF54duM/vV5zTLEFcRBykNCsZDMmJjgPwNQAjNDAdlNGIpNQujZTdjcwls5dZv5Gsf763voxiZe5xNJq+U8iLxJnFYJwEbL2+X0WIIw=
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 248c93a5-db3c-4abb-9207-08d73d471082
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Sep 2019 21:19:32.3870
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: x6pCf3du4hEH2DPtnvPxPxxfwbTdnr7drLBVHclXGdrHYnjHmkStQuOMYDol6QojMNSFvyOOVrb/BOZZSMk/Rw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5685
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/09/19 21:40, Darrick J. Wong wrote:=0A=
> On Thu, Sep 19, 2019 at 10:08:04AM -0700, Christoph Hellwig wrote:=0A=
>> On Thu, Sep 19, 2019 at 04:19:37PM +0000, Damien Le Moal wrote:=0A=
>>> OK. Will do, but traveling this week so I will not be able to test unti=
l next week.=0A=
>>=0A=
>> Which suggests zonefs won't make it for 5.4, right?  At that point=0A=
>> I wonder if we should defer the whole generic iomap writeback thing=0A=
>> to 5.5 entirely.  The whole idea of having two copies of the code always=
=0A=
>> scared me, even more so given that 5.4 is slated to be a long term=0A=
>> stable release.=0A=
>>=0A=
>> So maybe just do the trivial typo + end_io cleanups for Linus this=0A=
>> merge window?=0A=
> =0A=
> I for one don't mind pulling back to just these three patches:=0A=
> =0A=
> iomap: Fix trivial typo=0A=
> iomap: split size and error for iomap_dio_rw ->end_io=0A=
> iomap: move the iomap_dio_rw ->end_io callback into a structure=0A=
> =0A=
> But frankly, do we even need the two directio patches?  IIRC Matthew=0A=
> Bobrowski wanted them for the ext4 directio port, but seeing as Ted=0A=
> isn't submitting that for 5.4 and gfs2 doesn't supply a directio endio=0A=
> handler, maybe I should just send the trivial typo fix and that's it?=0A=
> =0A=
> I hate playing into this "It's an LTS but Greg won't admit it" BS but=0A=
> I'm gonna do it anyway -- for any release that's been declared to be an=
=0A=
> LTS release, we have no business pushing new functionality (especially=0A=
> if it isn't going to be used by anyone) at all.  It would have been=0A=
> helpful to have had such a declaration as a solid reason to push back=0A=
> against riskier additions, like I did for the last couple of LTSes.=0A=
> =0A=
> (And since I didn't have such a tool, I was willing to push the=0A=
> writeback bits anyway for the sake of zonefs since it would have been=0A=
> the only user, but seeing as Linus rejected zonefs for lack of=0A=
> discussion, I think that (the directio api change; iomap writeback; and=
=0A=
> zonefs) is just going to have to wait for 5.5.)=0A=
=0A=
From what I understood from Linus comment and discussion last week, it seem=
s to=0A=
me like the iomap part only was OK for 5.4, even without zonefs as a user. =
I=0A=
definitely got a clear signal that zonefs will be accepted only after we ge=
t=0A=
more comments and some time spent in linux-next, meaning that at best it wi=
ll be=0A=
5.5. And frankly, having iomap already merged at that point would make thin=
gs=0A=
easier for me, and also probably for other FSes moving to iomap. So I am in=
=0A=
favor of trying to push the changes into 5.4.=0A=
=0A=
But pushing for changes without a user not being the usual approach, I woul=
d=0A=
understand this is all delayed to 5.5. If that is the case, I will simply k=
eep=0A=
working on zonefs using your branch instead of Linus master.=0A=
=0A=
Thanks !=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
