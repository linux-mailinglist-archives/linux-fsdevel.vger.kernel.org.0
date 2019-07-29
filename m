Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E93F6782F8
	for <lists+linux-fsdevel@lfdr.de>; Mon, 29 Jul 2019 03:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726300AbfG2BHi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 Jul 2019 21:07:38 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:7313 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726238AbfG2BHi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 Jul 2019 21:07:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564362490; x=1595898490;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=nvQAwXQESaD8r47OneMmmvI3DSsj/9xG5KCdHJjxPpk=;
  b=opBp2U+FB6JxeZvIKztidHh1w0asP5Nubjw7YZD9milruvYMRwph3meG
   OMWzDEnxsFVaA7jWcX6o1JbAnymKakAkuL6MBmlQ0TlZ6F+6msU1Bfgga
   4c4zEsrWce5oBamkNVx3oS4+jmMM4Yrhdvh6FWkzOLzAzH0Qye44ZJeNz
   c+PRsoYSZfAa0IWZG4iSITbpBAjqMUK0tthsoPnS8ikvrqKbhwXvOtyMZ
   EZKDWGADhTuWO6TyaN1784dGynEFSNWa0acqc1aQNzZ2yyYiq589fAm+3
   cGNeXCvKLM0NMF6DhPBrIRVvCCYaZwv+tILkCT5kDcUg30QMjP4Hk32zQ
   w==;
IronPort-SDR: +ywUGU6tV2T7VgyXtrOcVy0uHgBcmK0S69FEzHBjwIXk+rms3t1tx3zeRSpIRS0cueZDu1L7cB
 VIkWM+bdSIZVoje4YQtu85XaYPD10bjrbrbOMj2nV1uW7BX9tLpIa4yU0i5RVxDoCN34dWO4IL
 Q0mH3nQSfbLCoVAPmNHsN4pDtC0sQENugvJwEfIGXTDj7XY4WMJV+k6QAWdYgn1jnmOw5dwtJQ
 ycs/BkY4v5wC0X54WVW17+8cLxjaJE6Giw5lWDfmbnT2vNtahpoO+GBIPda7nqO8lAjiVcSrcf
 fYo=
X-IronPort-AV: E=Sophos;i="5.64,320,1559491200"; 
   d="scan'208";a="214511064"
Received: from mail-co1nam04lp2057.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.57])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jul 2019 09:08:08 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=evU35/QEHVdfssbFlfLNdwaRxbSVR6HKuQd4PhX5NjKyRkMAa6FihEI51qTiZ4UrLlz9NV70vrPO7xP/tbdtmv8uTfU14A+/bCv/8JVYCf8wlxYvZ4n4m3UxeVkGLlp55HuiW2kkVGOwmALv/PE6/3n/5Xs9DxoZniPDVvqFNNJBZ/X3jF3fpwGedGC6DPlxrBpIsYncwcifH+NkjniiBNw1nIXo5LrEXVeCkEVimE9Jjnj+5HOiYDTPat+/CqxHibOBF05tKJgosy6VAZY5fLM255JLm5B82WHMpXcb4MFlUge2Q3QZTHL2Jw1nT789J/M8kon+lzHtJw7BGsC3oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJft120ztxYMIFn2/z/AhgEYiv693fuVpXmTbYBJw/g=;
 b=anGGOYGmckT7EHU1/HGhvkW1laxxdhvGDRog3rE42T9zBto3/ixh3HsA5rZe2sXemXUuQzyRy3AOGGns4wJTcfPZoYZW5Xc9Sv09yBoTWAajsr8v9b6+ShXHlGeOgvOTMxn9TKzg/FQhlPSQHRomACHo3TVOLFDjskA7nE6UTkwJwy9ylSUF/p9Ryc5BKQgQnvDew0Ydq0ZGCZBjw1tDghdiVSqZFTanyzlsorsC6nK0PGjZrCJtFwdG7PJUww9HOenEhik/wSfrIL8UxB3E5hwMGXevDCsdPPPgXMmjAGESubsgicE+lX54BdVIps1J4R8AUWNae3yVuJRCgf/wPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CJft120ztxYMIFn2/z/AhgEYiv693fuVpXmTbYBJw/g=;
 b=BiaXnYJc2vj5F7qqGnKp/HVnzzGdNiadenL/LePuQxenkalQ23U8K24EQPpDpMd95bosVk7oKVymqbj60U/RJ+8YBQNKqdOHFCHAWEELyjI8ahj8CvBKD/paI8UXC5bqcnbFWC+8H8KDxY7VXGyAVQoKQPf+FjppQlU9hxcbfrs=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4214.namprd04.prod.outlook.com (20.176.250.151) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2094.11; Mon, 29 Jul 2019 01:07:34 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.017; Mon, 29 Jul 2019
 01:07:34 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@infradead.org>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
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
Date:   Mon, 29 Jul 2019 01:07:34 +0000
Message-ID: <BYAPR04MB5816C422BCCC0ACBC82E731EE7DD0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area> <20190726225508.GA13729@mit.edu>
 <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
 <20190728234110.GH7777@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72146712-dc0c-41c1-2265-08d713c123b8
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB4214;
x-ms-traffictypediagnostic: BYAPR04MB4214:
x-microsoft-antispam-prvs: <BYAPR04MB42147164AD32EDBB774FD9AEE7DD0@BYAPR04MB4214.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01136D2D90
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(136003)(39860400002)(396003)(366004)(376002)(189003)(199004)(7696005)(186003)(26005)(66066001)(8676002)(86362001)(256004)(229853002)(6246003)(14444005)(14454004)(478600001)(52536014)(71190400001)(74316002)(25786009)(6436002)(71200400001)(4326008)(316002)(305945005)(7736002)(55016002)(9686003)(3846002)(486006)(6116002)(8936002)(6916009)(66556008)(2906002)(66446008)(446003)(64756008)(76176011)(99286004)(5660300002)(76116006)(68736007)(54906003)(102836004)(66476007)(66946007)(53546011)(6506007)(53936002)(91956017)(33656002)(476003)(81156014)(81166006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4214;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: yEpfwoc22uuPXiDTkXa29gFpfe4OwsVPFRfPbLwwr7CvpGyPrO9oDcGvHk4UVe7i9mSoLtgy2Dsl7tEejUCoBMcZ5+sBMOV8xPlebdacPOwbaBiZDYfXrROIeg+AvNhK5ioDrhRbjiKV4s3DAwDNV0nve5j6jd/lfzctyb+iNxrT8osoESpnvF9pnc08Uq2kM7EBsU6ANVG/z2eRnsei3FJp0wre3TMvP0JBlP7DvGwHGOwUPGrD8Wf4MxOplfNcCh8dx/UniRsojCiep/n75qpRP0csBVUrTfOf/tuyYrwaNh70GXdasrir9OAblMsZQlwfoDO+68PH0zVnF5nptIZadY503WzpS+BlF9C0lT/FOuAtKwgonNUFOSGko7xx9jaL1iqmThJYxlPnudMHVboadUzsH6IKG1S7LULjqOQ=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72146712-dc0c-41c1-2265-08d713c123b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jul 2019 01:07:34.2791
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4214
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/29 8:42, Dave Chinner wrote:=0A=
> On Sat, Jul 27, 2019 at 02:59:59AM +0000, Damien Le Moal wrote:=0A=
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
> Right, I'm talking about using memalloc_nofs_save() as a huge hammer=0A=
> in the pread/pwrite() calling context, not the bio submission=0A=
> context (which is typically GFP_NOFS above submit_bio() and GFP_NOIO=0A=
> below).=0A=
=0A=
Yes, I understood your point. And I agree that it indeed would be a big ham=
mer.=0A=
We should be able to do better than that :)=0A=
=0A=
>> One simple hack would be an fcntl() or mount option to tell the FS to us=
e=0A=
>> GFP_NOFS unconditionally, but avoiding the bug would mean making sure th=
at the=0A=
>> applications or system setup is correct. So not so safe.=0A=
> =0A=
> Wasn't there discussion at some point in the past about an interface=0A=
> for special processes to be able to mark themselves as PF_MEMALLOC=0A=
> (some kind of prctl, I think) for things like FUSE daemons? That=0A=
> would prevent direct reclaim recursion for these userspace daemons=0A=
> that are in the kernel memory reclaim IO path. It's the same=0A=
> situation there, isn't it? How does fuse deal with this problem?=0A=
=0A=
I do not recall such discussion. But indeed FUSE may give some hints. Good =
idea.=0A=
Thanks. I will check.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
