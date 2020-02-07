Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3412C1550B1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  7 Feb 2020 03:29:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727012AbgBGC3j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Feb 2020 21:29:39 -0500
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:23062 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbgBGC3j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Feb 2020 21:29:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581042580; x=1612578580;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xlgsiNmAXCQknG3KctrzbuxmlUuMraOjGmCWNsrlvGQ=;
  b=H0bGvpVLumiOMRYSXVr8msp6OttkeiPrUmmx/+sYhuK7ZK4IxNpnTrLB
   j4kWw9kc/u7pHWZVqK9laK5U9jFMHwbAPatHVifZchpK8OkaIyEsai1fq
   CSh4tIGmi/Br+B/07rUdJFKi8zo8tdznjeqKpWtTwbU/ferscQatU9gjA
   VGESoQRlOHCGmTX7smRe2z9Czr5TUnY8q3RBTOM7xaVDUVN4uwOP6FjfB
   CFXVhTmxn3xgv/NXBlwVPm+B8TH4tK/6+L03eHK/ZgtphQGHkrAKOC939
   sZtQpOqLx4VTRtj8zSDgalclF3iWxtyVQlnybmItNbS60MOwpiMRvL+pi
   w==;
IronPort-SDR: fDlO3/WhObSr26UbiFnnkSFtEOFA58TNbqAH4iubqM2jGjh3PgP4my6BwpVssAC6614P5JmzQM
 JkiqInwZ+t9yAY6CNb4rp/af7Ki7SqTG6DRj/sOFq5RjbvN/JeHFm2EeBpM1RPmAYEhXv3WnQs
 EWl3fkuuBV6J4xfJZPM+sTQe7JQ1SG+QFaTarpamGH7xXdtakNDHfas/WVxDmiTqPfiTKB6CCm
 hBW90ccLMobK4qGnYZtFLRdw/WJFIGasSQ9Y3Q+PjN2VC+i6ATaxRMmUSeiYa8Lg7K3zPZRJbo
 yn4=
X-IronPort-AV: E=Sophos;i="5.70,411,1574092800"; 
   d="scan'208";a="129869106"
Received: from mail-dm6nam12lp2172.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.172])
  by ob1.hgst.iphmx.com with ESMTP; 07 Feb 2020 10:29:39 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/QTx7Ruu0FJcAk3nU+gU7Ea3UNjG9aXYfmIKvdrXq0SbjR2zYOtC6d7e+Nd+KmPfjdBSSkfHSKnsIGEy//flYxDaXPTtdcJDW8PcsXXHCyXI3SZM0dP4f/so9ZRCo4n27789h7zWVq/4mEoYqP7g8Wlqs7i8UvjwHQ82OZ2kucB1gijqQonxeSpK4TM4tGLYZLH5wtr0TZFCNtxm5CmxHbXSAuLg71+PT+PHYQPWemJYh24T+pOmtx99Lib5QZYBG9OQiy58PzKEDZbEIiR3WSAYaZu5gxmTsx22gh+L11JP+OFuFxVre6xNms4sOqVegcIAb+dp/tR27rYwDNnZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXRmTNIkSQO1ZRswauLRQrSz7D5OD/EwBE11fpPU588=;
 b=NX2qGPqQeuoeUKXgLwpvMUzt790irOSSMl9rQ7bMmg7jYCovdYQ6tnwSnYaH2rI4vO5TZ7s2v12ASXqMX6/vcoBwXWToVSLXIKuAJKMqOliI33u/wMDrbScTaHLiFFYoa29TzgtFmU0x3pj/YabBxr6sEadI+DCL4bQAKXaExsNmnyj7iSNOYihvpFEIGLjFny5XNjmGzMX4iTUwdj8Biwpi1W1yLohk29djYiQfO/XjwoglJAngqAHG2HmochZZseD6rqm+up69Ck1joqUriy4mZhjkiepp+3ILWjl1HSQJLe5nDVuKeI5iDNwfoqo+PUNW3MLa1rh0IXrfPb+zCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXRmTNIkSQO1ZRswauLRQrSz7D5OD/EwBE11fpPU588=;
 b=ztwgH8Z7IyY/2tqrVaqD1K1tGhcc4rsicj6ENlEAeNw3MVeufHfkN+ICzfdj5lZsl46HA7F6Uj1mHlTnDAbwspapbMrcVYo46R8yaMySwj7yUZV7dH58Jewg0gT+nUzPPj2unhkRZqxDkMEMLBMCTrGWjPaRh2K2GClL97Zot20=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5301.namprd04.prod.outlook.com (20.178.49.146) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2686.32; Fri, 7 Feb 2020 02:29:37 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2707.024; Fri, 7 Feb 2020
 02:29:37 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v12 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v12 1/2] fs: New zonefs file system
Thread-Index: AQHV3K4LaCqwddoPX0OmBZrk+QgByg==
Date:   Fri, 7 Feb 2020 02:29:37 +0000
Message-ID: <BYAPR04MB58165F4D55724B03EDED8E0DE71C0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200206052631.111586-1-damien.lemoal@wdc.com>
 <20200206052631.111586-2-damien.lemoal@wdc.com>
 <20200207002948.GC21953@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [2400:2411:43c0:6000:e0ca:929b:5db5:1772]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f29bb6a6-4fcc-450c-a6d1-08d7ab7593ac
x-ms-traffictypediagnostic: BYAPR04MB5301:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB530177F77DD7DDDF414FA0ACE71C0@BYAPR04MB5301.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 0306EE2ED4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(376002)(39860400002)(346002)(366004)(396003)(136003)(199004)(189003)(55016002)(316002)(71200400001)(54906003)(186003)(33656002)(86362001)(2906002)(6916009)(76116006)(6506007)(66476007)(66946007)(66556008)(66446008)(64756008)(8936002)(7696005)(9686003)(52536014)(4326008)(478600001)(81156014)(81166006)(8676002)(53546011)(5660300002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5301;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: EilaFZ6+ZfIqduXqblKVxvO4FMztcH4vx3NuWVP/u0aMupKp7JIvcDJbB2NBWqQrizN0GL6MbiNfQJFiZKAsmvIt++RJxjLF3q1ctQPo9WxsHAXPegz7DdytAT6mHohnuca3XuytpTEaUvfIqmAZyqpbBl5fQjDsc/nIuW3vZIuRW4ab6o+NvU0ZRZyT3qqk6sCjPN5wKzmmodcJjIHnqGw40pBkGrXMubBAlvxOOkB/JmuBnd479NWO7yez2pQcGDmPc2+d2KMBg3mQ1LWnyZPbfKHNk0NaJEE7dlfM43vbFtdPORag7mi68aas9kVMQ6LYYw+PybAkd415W+BbJjfGjdx3LGv/GEGW71lWdmdfJzsRGXbt8dLILcI0ZAYSK7ZkLnn+2ZUdWCb+9Hsg0kgqjwUlyWQLq3xB2AqWP7ELFwT3jXg4dXCfmEmmf9oZ
x-ms-exchange-antispam-messagedata: G1fi7JiTW0QQv7Yicse1Y3yqzw8MIlVzRChxue6LkEb01b5IFX7LYGpifK4iwCvRpGhBVuNKp4gO1cX6DnffRLcGmMEM46pLXidb4P/AS3OICLjOZPjuQ6Vz/KEZdgo2ag1dMRv8sWDmYuJOp1EYnyFnLI300tJS7Qfyw8LwlxRohGUufNo4Vsee/pZ/kDUexN9klnGTmeLK5LAgCPxwqw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f29bb6a6-4fcc-450c-a6d1-08d7ab7593ac
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2020 02:29:37.0914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /nQGe0n0vrco47UV4S6wEVH5ajreoVC7sy4CwVy5U/7etCH8yhAZNyqbW7l79PrPzFQEme9JbziH2eT6QEagrA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5301
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/02/07 9:29, Dave Chinner wrote:=0A=
> On Thu, Feb 06, 2020 at 02:26:30PM +0900, Damien Le Moal wrote:=0A=
>> zonefs is a very simple file system exposing each zone of a zoned block=
=0A=
>> device as a file. Unlike a regular file system with zoned block device=
=0A=
>> support (e.g. f2fs), zonefs does not hide the sequential write=0A=
>> constraint of zoned block devices to the user. Files representing=0A=
>> sequential write zones of the device must be written sequentially=0A=
>> starting from the end of the file (append only writes).=0A=
> =0A=
> ....=0A=
>> +	if (flags & IOMAP_WRITE)=0A=
>> +		length =3D zi->i_max_size - offset;=0A=
>> +	else=0A=
>> +		length =3D min(length, isize - offset);=0A=
>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	iomap->offset =3D offset & (~sbi->s_blocksize_mask);=0A=
>> +	iomap->length =3D ((offset + length + sbi->s_blocksize_mask) &=0A=
>> +			 (~sbi->s_blocksize_mask)) - iomap->offset;=0A=
> =0A=
> 	iomap->length =3D __ALIGN_MASK(offset + length, sbi->s_blocksize_mask) -=
=0A=
> 			iomap->offset;=0A=
> =0A=
> or it could just use ALIGN(..., sb->s_blocksize) and not need=0A=
> pre-calculation of the mask value...=0A=
=0A=
Yes, that is cleaner. Fixed.=0A=
=0A=
>> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_ite=
r *from)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	size_t count;=0A=
>> +	ssize_t ret;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For async direct IOs to sequential zone files, ignore IOCB_NOWAIT=
=0A=
>> +	 * as this can cause write reordering (e.g. the first aio gets EAGAIN=
=0A=
>> +	 * on the inode lock but the second goes through but is now unaligned)=
.=0A=
>> +	 */=0A=
>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ && !is_sync_kiocb(iocb)=0A=
>> +	    && (iocb->ki_flags & IOCB_NOWAIT))=0A=
>> +		iocb->ki_flags &=3D ~IOCB_NOWAIT;=0A=
> =0A=
> Hmmm. I'm wondering if it would be better to return -EOPNOTSUPP here=0A=
> so that the application knows it can't do non-blocking write AIO to=0A=
> this file.=0A=
=0A=
I wondered the same too. In the end, I decided to go with silently ignoring=
=0A=
the flag (for now) since raw block device accesses do the same (the NOWAIT=
=0A=
support is not complete and IOs may wait on free tags). I have an idea for=
=0A=
fixing simply the out-of-order issuing that may result from using nowait. I=
=0A=
will send a patch for that later and can then remove this.=0A=
But if zonefs does not make it to 5.6 (looking really tight), I will send=
=0A=
add that patch to a new zonefs series rebased for 5.7.=0A=
=0A=
> =0A=
> Everything else looks OK to me.=0A=
=0A=
Thanks !=0A=
=0A=
> =0A=
> Cheers,=0A=
> =0A=
> Dave.=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
