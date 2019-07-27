Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3ED77621
	for <lists+linux-fsdevel@lfdr.de>; Sat, 27 Jul 2019 05:00:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726808AbfG0DAC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jul 2019 23:00:02 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:11821 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfG0DAC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jul 2019 23:00:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564196401; x=1595732401;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=bhIfxKUPJ004v8S8JE9LS75kftNs4LblsMLq4FvozR8=;
  b=MzE/xt5Pygo9I4XG5vsGVjv0prlqNtkAiIyMVg2vOt8fqrMA25JsUy67
   vsXM1c9hCcFj3WRBeJMrBd9wmb1p6ANzT60rrv3bYVkCPrC8HurZHiiJw
   Tk5OBtx4jSsfDU+bguKqdF9FvXv+7Ea1ncOkfZRPRlO9WHPa6AfVKK9a1
   CxibZcKoheQPEODAkesv5w21CNhxOODZaUtnBa53AxBUwgfvhyHnWdHsT
   RT9tPUKVBCEZOy331yxYowOTy0Ypg7xFSTp6NubwEHvj90kG3iT9qqgzR
   53LQRmVJlJMD2gcdzZtnaYeCQz0ZGmWiLqA7UA9vZwccCObGe3GJ447Je
   g==;
IronPort-SDR: 106Z4PHnIaVZmZdZkt4GTc1S90k8Vs+4YLQyxqpoh4DxUn9l2qPOwpfOh+eKnFot/wkAL3Vp1Z
 UbIBvwDJJq0c3l+oVgFZErezfsMjz1PNwHy5+SGjMHyaEz5tAsywNO+tNvlGMemujC9/7uoCMi
 VFuixonR2NDV9IZfmfGgIBK0edHcK5vCXItm2hILvwa92qWYLVZH9tHNoIlkbHLU/W1UcY0zO9
 cYOiuFuRV/cjxTLSiHTilU1NCKAHo/sFOTbPk/wYRmwNjb1TWVEyYUTPW/uTq1E+ORh3axGhr9
 Pyo=
X-IronPort-AV: E=Sophos;i="5.64,313,1559491200"; 
   d="scan'208";a="220704609"
Received: from mail-co1nam03lp2055.outbound.protection.outlook.com (HELO NAM03-CO1-obe.outbound.protection.outlook.com) ([104.47.40.55])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jul 2019 11:00:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MV4NTX8GTwapNYnEmRjHlGlXmXi2czybZOSIr+XnJ7Q/lkZXOGoBJrHX5L1Ipd3nPD7mTjxP00svOeKMTVqLVfgA9eT2dAiMeB8tGc1AGA9MTMXq/BUX0VdCGG/E8IJno6EmNc6+Nb896pSlvNNpORuyreZJl9L0q5vWnXMrFXnfDdTh2PPWKw/cjdJ2d+gnTRYv+qQId72mewG82m9uaqIYWGR4UD6H071QHEhOnTbQ10US5fZqlaUz4HM4JRFmqvwxkUV25ZxUGFNx1xa7tBgnZD6Bmn7O/r9OFTogB6453OspaPOhRNflFqj66VuuB01/kWdZ3hOYx/uQYbzfKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qLnveVGUHAdSZbJnV8GE3BgRwGQeWO3WwIuLgzyee4=;
 b=YhpGaN3vjX2lOC9v960tFuMx8QMb7fCAcy2NSZTBTX1EnAftnGkYrGUjlmBVIoCYFygRqwVOr26Nj07gIMF3LCKx7yFyRyTTCCyC0dnGeS3iK4YqGt4D8Y7mPrr7k7UG19yEObyA2fSbxem5lDql+xLbUChcFmShyNsucjbTwCkPUtuwQc+5EiVxgW8unKCcavU00aDpWjCmsc6tDaLSgCPcdEV5d1ycY3x69d81tfrZf+xJP/5yGTCzU8+gDRrejdSo6dYUXEnllURVQu9N0n+zTEdISl87ZZT1KegVbmHO0OkqdVOiIQr+yNr2u3M7DIbKNSdbysxx7D/jNIEEsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6qLnveVGUHAdSZbJnV8GE3BgRwGQeWO3WwIuLgzyee4=;
 b=ZW8KLq9PY4pXCD2Pk/cOS0kvSi1bMhieDDHSHYhTXm6dDqw/G8+E4LRxYbobbEl1Hlzre6DyCFihEM37sYHR5ebe/nIRgKu6+pYDygsjb1DCh36fA5/BNq9APbb+qGmvsnLwimo+aOjKWVE78AQAKrSc+qb+9oRI/Q7AqZe0qQ8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5349.namprd04.prod.outlook.com (20.178.50.30) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.14; Sat, 27 Jul 2019 02:59:59 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.013; Sat, 27 Jul 2019
 02:59:59 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Theodore Y. Ts'o" <tytso@mit.edu>,
        Dave Chinner <david@fromorbit.com>
CC:     Christoph Hellwig <hch@infradead.org>,
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
Date:   Sat, 27 Jul 2019 02:59:59 +0000
Message-ID: <BYAPR04MB58162929012135E47C68923AE7C30@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
 <20190726224423.GE7777@dread.disaster.area> <20190726225508.GA13729@mit.edu>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [60.117.181.124]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a482308f-2c1d-43e7-b693-08d7123e8309
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5349;
x-ms-traffictypediagnostic: BYAPR04MB5349:
x-microsoft-antispam-prvs: <BYAPR04MB534971BD114898232B7D67A4E7C30@BYAPR04MB5349.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 01110342A5
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(396003)(366004)(346002)(376002)(189003)(199004)(256004)(7696005)(6246003)(2171002)(14444005)(66946007)(6116002)(3846002)(52536014)(86362001)(81166006)(81156014)(8676002)(478600001)(71200400001)(66556008)(64756008)(486006)(66066001)(76176011)(74316002)(2906002)(316002)(66476007)(305945005)(446003)(9686003)(55016002)(6506007)(14454004)(53546011)(33656002)(476003)(229853002)(4326008)(53936002)(5660300002)(76116006)(8936002)(186003)(91956017)(99286004)(102836004)(68736007)(7736002)(26005)(25786009)(71190400001)(66446008)(110136005)(54906003)(6436002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5349;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: hyP5BnNq2M6gtK1kItZkbDB0aDlqDV+fxDFdSCMUdNnPLomKZGqQKflbClu1PXWz4ldwkqR+Z1CZpgb+jAzKcc7tLoo1DzrDdsQNnwXn98JxFE9DptH3ickCgAI7LYzt3sxFyz9MFn4cN5Fvp6JZJgAjVqflNAesOvppw4K8LXlvRYLVEZyAXxKhHZPTQWZRe/3EcV2FEzFzddEedpbnSLEr4L11YJhYrUwvXPz8wM0rNgbWEtQNsmHO9jZ+iLoYRMt39LvZeqvTVfYmLxNsWTFpZ/SNKVqIF4ncEljFrYWj8u21xgJZqa7Yc5FzqxQ1gAFWspZviOub8zuO8WMhBGeOvKc3TZ+RjtZ/XbW8T/fNr9cTbTgBKzDtFYk1yGb+Bk9Jxw8bNqztbMX72+oPqcsNGaKP6le5R9fwgezU0Hc=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a482308f-2c1d-43e7-b693-08d7123e8309
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jul 2019 02:59:59.0909
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5349
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/27 7:55, Theodore Y. Ts'o wrote:=0A=
> On Sat, Jul 27, 2019 at 08:44:23AM +1000, Dave Chinner wrote:=0A=
>>>=0A=
>>> This looks like something that could hit every file systems, so=0A=
>>> shouldn't we fix this in common code?  We could also look into=0A=
>>> just using memalloc_nofs_save for the page cache allocation path=0A=
>>> instead of the per-mapping gfp_mask.=0A=
>>=0A=
>> I think it has to be the entire IO path - any allocation from the=0A=
>> underlying filesystem could recurse into the top level filesystem=0A=
>> and then deadlock if the memory reclaim submits IO or blocks on=0A=
>> IO completion from the upper filesystem. That's a bloody big hammer=0A=
>> for something that is only necessary when there are stacked=0A=
>> filesystems like this....=0A=
> =0A=
> Yeah.... that's why using memalloc_nofs_save() probably makes the most=0A=
> sense, and dm_zoned should use that before it calls into ext4.=0A=
=0A=
Unfortunately, with this particular setup, that will not solve the problem.=
=0A=
dm-zoned submit BIOs to its backend drive in response to XFS activity. The=
=0A=
requests for these BIOs are passed along to the kernel tcmu HBA and end up =
in=0A=
that HBA command ring. The commands themselves are read from the ring and=
=0A=
executed by the tcmu-runner user process which executes them doing=0A=
pread()/pwrite() to the ext4 file. The tcmu-runner process being a differen=
t=0A=
context than the dm-zoned worker thread issuing the BIO,=0A=
memalloc_nofs_save/restore() calls in dm-zoned will have no effect.=0A=
=0A=
We tried a simpler setup using loopback mount (XFS used directly in an ext4=
=0A=
file) and running the same workload. We failed to recreate a similar deadlo=
ck in=0A=
this case, but I am strongly suspecting that it can happen too. It is simpl=
y=0A=
much harder to hit because the IO path from XFS to ext4 is all in-kernel an=
d=0A=
asynchronous, whereas tcmu-runner ZBC handler is a synchronous QD=3D1 path =
for IOs=0A=
which makes it relatively easy to get inter-dependent writes or read+write=
=0A=
queued back-to-back and create the deadlock.=0A=
=0A=
So back to Dave's point, we may be needing the big-hammer solution in the c=
ase=0A=
of stacked file systems, while a non-stack setups do not necessarily need i=
t=0A=
(that is for the FS to decide). But I do not see how to implement this big=
=0A=
hammer conditionally. How can a file system tell if it is at the top of the=
=0A=
stack (big hammer not needed) or lower than the top level (big hammer neede=
d) ?=0A=
=0A=
One simple hack would be an fcntl() or mount option to tell the FS to use=
=0A=
GFP_NOFS unconditionally, but avoiding the bug would mean making sure that =
the=0A=
applications or system setup is correct. So not so safe.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
