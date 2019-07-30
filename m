Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 389ED79E76
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 04:06:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731105AbfG3CGi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 22:06:38 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:31233 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727539AbfG3CGh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 22:06:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564452396; x=1595988396;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=DAWwB4PthrIkhHgU0udUzp8i81R1gkPBRTHtTf/eUlU=;
  b=VU3eTnD9njipZiprlruw9/gCR1IgJy4yE7NOBxRYXmGtPFoPgr7J7RMB
   8UKSMc4H1K6bsRYykCPgMWlC9Zn36WDPXV9CUN0Q3vnMtizWqKrmDL7er
   3RJqDIR8uefl4+Wvvlba9jHkBrwfZnjg1fCeTBlETiEzwXa2Dr1V2z5Tr
   pGwGbErtRu6q00e7yFUAIQpEeicY5LiLSZ+FKB7oBB+GIsiyV8VwhOssr
   f+15NW22MAMXzM71ZXS1/HEMM7Ch+HPkUCHlNCm9sdlvJFrUgRc9GOuG/
   SCLZ5julwyKnXBMkJs/DaTjCl5KbHkj+T67o7rW7EZikEaCybxDyH+EQR
   g==;
IronPort-SDR: Zyh2aOGVFAiKoOA+aNLiUiELN8oVwQSJO6d4ES9JPlgs0gEyUUAA5OvZnV8kG5w1DfOILnWD+W
 HmCQpUErw71HvQfhtaV+mgEkQYmv0uKkAC7qEmogtslsFfYZFMavfH+POGD72xt4r7W1btR5bq
 2ky0Y0YiKoRRBrfvY3rUXG0j8iK5V8AoGcaw8JE1JbzLzofJKcvbQs0gcr7chFiRkZinfEhNLi
 M/yes8nkvSSxjzpf1om38E0gcZ+S6MrkoFvBCBRDwmRtbY23QJ/VeSb19NgUvzcqE6uq6ou+BG
 Vlo=
X-IronPort-AV: E=Sophos;i="5.64,325,1559491200"; 
   d="scan'208";a="220903382"
Received: from mail-sn1nam04lp2052.outbound.protection.outlook.com (HELO NAM04-SN1-obe.outbound.protection.outlook.com) ([104.47.44.52])
  by ob1.hgst.iphmx.com with ESMTP; 30 Jul 2019 10:06:35 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ROo4ky4MySbdSFuZTfy+a/pt7L9qpw6ifz4JfydK1EeNKf5ds/1gYbembAqegm9sSMJFnctpCQuL7OwcxK+U8tiVB+Yj2C7G9TlznQ4JTOA3Eu4FyciYodhvlMNPPwFLKcaKcAmEFZsQYx/S/pFP4LHeaGrflXRK/ultDKredCyCRz6F8Nc27Y0y6tuLwmy5SiL/FTZ4yhXgFvMwdP68GCRW00szwbRcIzqtAjc5RoovXTTfYwB4rBfz+jp9WRdYaGNBbH7g6spw3lSQ8QT8uao0Vho9QAFYewkVeSnW+wqzS9Qt0gBcQaBOlFnd2SS8QBqUjv9IpHr1EE7xIc0+7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZGJJzk0BFAD8E2zFAkqogu/xXdmRo6CozZ14BjqTuc=;
 b=clqRR08gzZpYJs4thf6Jk5wSke91arx2wj15ouZs5ivO96vNd10XneDYI5v+DYYwM9F0+JteDfql3oXHinX9cJGAuih7/2tG0amF1gr027N5noWb3JGWS4/rb+ixr46nqxKnTbTYEBznPSuGg22DGROPJOmR3Nez9zVNtIqLxb89FXgkgKLYfmeSlS7WrHZogSPGuCztA5lP0ePFd6i6F3/RPYAHMSgZ50bQJ2LHc2tCxN4aTbNovmekChn/wI4Y2lV6S6GY6kzwFiVvQ6nvPhG+tOuXr95y+NlX8FgWXXbp1dkc2tUSFUPnDkXn2v3fdA0wqIPwvsYQldd+pv8Ptg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rZGJJzk0BFAD8E2zFAkqogu/xXdmRo6CozZ14BjqTuc=;
 b=GULdEayiUswnt8nFYDPNrQd+YCZ0Uf4XxxJMt9AHqk0JVWvPO5htVUtRdMw3EQMtMVY1JL4qzJlhXb1O0LvO7fzqYhPo8Lh6rlYiBrq/DoYbFsD7z/t71HaYNaaW3VCCP2Qf5G4+ZvdS7bJzm7rl1lw8bvnRaE8+8UaGxxkCAoQ=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4101.namprd04.prod.outlook.com (52.135.215.160) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.15; Tue, 30 Jul 2019 02:06:33 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2115.005; Tue, 30 Jul 2019
 02:06:33 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Andreas Dilger <adilger@dilger.ca>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>,
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
Date:   Tue, 30 Jul 2019 02:06:33 +0000
Message-ID: <BYAPR04MB5816BD641DF55A93986DF826E7DC0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area> <20190726225508.GA13729@mit.edu>
 <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
 <3D2360FA-AD48-48AE-B1CE-D1CF58C1B8AB@dilger.ca>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34d260bd-0935-4578-fc3c-08d714928b8c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4101;
x-ms-traffictypediagnostic: BYAPR04MB4101:
x-microsoft-antispam-prvs: <BYAPR04MB41010BF909DC7CB87B70861BE7DC0@BYAPR04MB4101.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0114FF88F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(136003)(346002)(376002)(39860400002)(366004)(189003)(199004)(6506007)(25786009)(102836004)(186003)(256004)(26005)(74316002)(53546011)(6246003)(8936002)(14444005)(3846002)(8676002)(33656002)(305945005)(81166006)(66066001)(6116002)(4326008)(99286004)(446003)(76176011)(7696005)(68736007)(486006)(81156014)(476003)(66556008)(66946007)(76116006)(6916009)(54906003)(229853002)(86362001)(6436002)(9686003)(66476007)(5660300002)(55016002)(66446008)(64756008)(71190400001)(91956017)(71200400001)(52536014)(2906002)(7736002)(14454004)(478600001)(53936002)(316002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4101;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KyudndvP1MUGxdyTNylfLU3zyh8YljkUXBPfWOxxrqrQdXoaYoZCO/u3mbas/cX536DFD6rS8ddUDQdMsbPNQueOksxj5EuNcF2tNFsa2Kup1XmIn+89GixXv2dF5+FhK9mhafIgE2SA95FcfGeYzeNfBTLHKYYMb3hJtR9eOVe71wemcMxowC0NOhhHEgQasgcc6gtMy7N7NJwu6qGwZHWIGKjggEDWxsW/gfY6O80y9E5LiXEvG+c7Tf4tccB1yDuObUYmwsB2mmZlyASnY4GuDLJ6BoXnTfXw3hZg6c7m3bqybi/RBk6iNnKe/tC97vcmzSIpbCah97d7yOe+5yviJva6RlVAPX9a5lnLR01A8Ivl6mpYcLlvypYOO0fq3i1/xqbFrhdw0bUpNNpwrwg9n90RDeypWk8F88HQUQw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34d260bd-0935-4578-fc3c-08d714928b8c
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2019 02:06:33.3688
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4101
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Andreas,=0A=
=0A=
On 2019/07/30 3:40, Andreas Dilger wrote:=0A=
> On Jul 26, 2019, at 8:59 PM, Damien Le Moal <damien.lemoal@wdc.com> wrote=
:=0A=
>>=0A=
>> On 2019/07/27 7:55, Theodore Y. Ts'o wrote:=0A=
>>> On Sat, Jul 27, 2019 at 08:44:23AM +1000, Dave Chinner wrote:=0A=
>>>>>=0A=
>>>>> This looks like something that could hit every file systems, so=0A=
>>>>> shouldn't we fix this in common code?  We could also look into=0A=
>>>>> just using memalloc_nofs_save for the page cache allocation path=0A=
>>>>> instead of the per-mapping gfp_mask.=0A=
>>>>=0A=
>>>> I think it has to be the entire IO path - any allocation from the=0A=
>>>> underlying filesystem could recurse into the top level filesystem=0A=
>>>> and then deadlock if the memory reclaim submits IO or blocks on=0A=
>>>> IO completion from the upper filesystem. That's a bloody big hammer=0A=
>>>> for something that is only necessary when there are stacked=0A=
>>>> filesystems like this....=0A=
>>>=0A=
>>> Yeah.... that's why using memalloc_nofs_save() probably makes the most=
=0A=
>>> sense, and dm_zoned should use that before it calls into ext4.=0A=
>>=0A=
>> Unfortunately, with this particular setup, that will not solve the probl=
em.=0A=
>> dm-zoned submit BIOs to its backend drive in response to XFS activity. T=
he=0A=
>> requests for these BIOs are passed along to the kernel tcmu HBA and end =
up in=0A=
>> that HBA command ring. The commands themselves are read from the ring an=
d=0A=
>> executed by the tcmu-runner user process which executes them doing=0A=
>> pread()/pwrite() to the ext4 file. The tcmu-runner process being a diffe=
rent=0A=
>> context than the dm-zoned worker thread issuing the BIO,=0A=
>> memalloc_nofs_save/restore() calls in dm-zoned will have no effect.=0A=
> =0A=
> One way to handle this is to pass on PF_MEMALLOC/memalloc_nofs_save state=
=0A=
> in the BIO so that the worker thread will also get the correct behaviour=
=0A=
> when it is processing this IO submission.=0A=
=0A=
But there is no BIO to work with here: dm-zoned BIOs are transformed into a=
n=0A=
application (tcmu-runner running the ZBC file handler) calls to pread()/pwr=
ite()=0A=
into an ext4 file. And processing of these calls trigger the direct reclaim=
 and=0A=
FS recursion which cause the deadlock. So BIOs are not the proper vehicle t=
o=0A=
transport the information about the NOFS allocation.=0A=
=0A=
If we had a pread_nofs()/pwrite_nofs(), that would work. Or we could define=
 a=0A=
RWF_NORECLAIM flag for pwritev2()/preadv2(). This last one could actually b=
e the=0A=
cleanest approach.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
