Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 832F71468F5
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Jan 2020 14:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbgAWNYp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 23 Jan 2020 08:24:45 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:33738 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726729AbgAWNYo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 23 Jan 2020 08:24:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579785883; x=1611321883;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=H04RTd8Lk2AD7u5P2qvreiwsSaU6PKJ08SwacCl4Jjs=;
  b=UAsoZna1EXIxwiyCnbO4y+8SMAjQJlRv87PUhXVKkjFSA0yAS5LmIvHY
   8Hj3kCdWpqjHkncMOyluUNynp9AO19c2Hpg38DvGb1FsqqleKBD5g8ZJU
   oe/UM54WeafXW+sdUREviRPZH8v/wzTj+1aglNCtKwISj7DU7dYPVPKSO
   SzLOep/cPSptAsOp3qVmeroZCkyTwGqcg2cy8of1RDJVrJYb+p8z1Hm9P
   veczof9tdXVS3WV0E0i7XLYp/j0kGcj7gr5wYt8q8GMnO01ztO1xfxomo
   1ezg0p84bi4PZl8eUvmjrHXK2ouH8DdHHWZWw2/lyK5BV76t17ZtrM/yP
   Q==;
IronPort-SDR: DTAuKMmxVpVeUITO0JYoCGvYvHGnrarP5cVDzk+rSFdJRFHbD6eUwgldaOloqqZbgi8kvGrbbT
 lxGtlezRMTDpRIjtIrCKyf3y3ONMgkEdKW+R19sRQuWJSP7X20NySLsTqI7wpP4IffogW3fxC0
 x0wJx0mn0MSpfWIJOls9UhZDIM2gmG/qa7v9h1cCeaYw6we4YREqfmcsC8sMeWPcL2sBbPxnNA
 njaTYG+BdzPWB3cBpa8yRJLACbUhFL0CbKeiSGHUrJoslnrnSn931aqnmjjEFr/96EgeOzpV7b
 vbI=
X-IronPort-AV: E=Sophos;i="5.70,354,1574092800"; 
   d="scan'208";a="236142685"
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hgst.iphmx.com with ESMTP; 23 Jan 2020 21:21:41 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GrKW5G7g5TjyY9Insgdhn8oyqQTvT8uUZjBDsRtw8F2K1SthsOreSAcScrgPLzVc+E6xSsc3QcCHpoe0uIqgHLpKMLxJ6BLX6zLvw2N45WBN5vgt8j0m+OS9Dap66T9K23NQqOaKb755zReGBwkSAaPIBSN9r+ZI3Gc23nsDAxzEQWgxe0IiKPHPAr9ozuP9H4tbB8MklzmLeYtwA7OLITe8kqCN3MQpKkPuOw5Npgz4sLNqj3w+uF5hdarjDO2ozT+Ie2lcs4QLHeAels4P11Xv1v4eWT5WiVa1CffbHdIHOXk/E2cUPNtRyLzIsBlYOBTC/QD6ml9Cj1JanXFVTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so2I9d3XEEC6rqt1jjJbxOVkBM0WX7myxbZlAq0px/k=;
 b=lgR2OyhlSCHH3Aeh09Srl/UizATuj4IrI4rQf+Ykx2+PahBJch69MmI2TvDTYDSd1yYkD6MzNa+xBWpdlUxnkmOgkbqTRlXQQJtUYFM/e+01FyhtAbW3Z1mmfIEt3D+kSwUxpNSnpxXR+ex6rxCkNmrClEkjdgP/tS+PCcSPeuJU1ofZsVwwrHqFKbNgqTymFjfc+gQFQjvgvUa7YTLslHuS7Atd4ikTFloVRSjWZ3ftHtRR3peq2Dj3dv+3SFCBT4n15nw7wlxSmJmFTD7yGLPwb6kwN6e41syrGNIoCEbzg5BywQF864/a9pCGdo9CRSRwSeQYTSy8L1Vh5XLAtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=so2I9d3XEEC6rqt1jjJbxOVkBM0WX7myxbZlAq0px/k=;
 b=LZMsBKrmiN541eG+YILSEc0ybpRX6ugQJud354Odq43rd1aQSc5W4QdggcN90xVZL9bLVxple59xnoSihDuHvR2AFNOm9x+66QtR1mtg8UssG0Gnx0TG1zpiiKP6gsyXnTJw1EI6Z4dA+B23TSjnioStS5jJ5OTDYAaQJvyBpbU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB6247.namprd04.prod.outlook.com (20.178.234.28) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2665.20; Thu, 23 Jan 2020 13:21:40 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2644.028; Thu, 23 Jan 2020
 13:21:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "hare@suse.de" <hare@suse.de>, Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "jth@kernel.org" <jth@kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v8 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v8 1/2] fs: New zonefs file system
Thread-Index: AQHV0ChCqtOWPBQjzEWITWcaTW/1Tg==
Date:   Thu, 23 Jan 2020 13:21:39 +0000
Message-ID: <BYAPR04MB58160E26E9A84B307C8E3E38E70F0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200121065846.216538-1-damien.lemoal@wdc.com>
 <20200121065846.216538-2-damien.lemoal@wdc.com>
 <20200122015757.GG9407@dread.disaster.area>
 <63dbc880d4748c5f7f9dc91f80525ec01933370f.camel@wdc.com>
 <20200122231138.GH9407@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: cc0a7744-f3b8-475e-621c-08d7a0072e39
x-ms-traffictypediagnostic: BYAPR04MB6247:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB624787CD785845CE7EA3AE5FE70F0@BYAPR04MB6247.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 029174C036
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(366004)(396003)(346002)(376002)(136003)(189003)(199004)(66446008)(64756008)(66556008)(66476007)(5660300002)(55016002)(30864003)(9686003)(76116006)(4326008)(66946007)(33656002)(53546011)(6506007)(186003)(26005)(52536014)(7696005)(316002)(6916009)(81166006)(8676002)(8936002)(81156014)(478600001)(86362001)(54906003)(71200400001)(2906002);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB6247;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3eulsg+P4ApWnmW7RoSPHwBgp0PF5myOTkf8V7bzPWDAghSbEhv9QuHM+ERTfE+sjs+2eqToczIFQCczCF2B3VR57i1xi02N1jRQo8BjbrqD8CC4R+3FYGb1BXZyaJSPZe2OqyF1U7A5Xjt8N98pBRFPaaT937qnE6MwlC469/w/hXavEjVIh6pVPPDoK72RTpfBgrGR5nSwXsIzu0z47HTF8tkrpLediwawu9IxJNPrtH0Wzbi7k5TFuBT97Bz02znfkQEWV2UJCVzryEiBE4qKEkzflR3wnfLwxI4gnoFhGbiGVI2Jh27mp4geffvobMAofCyO2BaxTOT3VVgFa+u/an7YthhzFKgqEJXkZtUkeG0nRkItUOeOk8Z/5bhSg3VPPz0CZQwQwpjpMYjJKr2cVYBosKM2TbnhtU2Cchc4af9zHe4o3iBmiVeQ8ggB
x-ms-exchange-antispam-messagedata: CKYPQ6NXiuOEz5ISvzX7MYKdyuB8doa5mdqe9dMspbXaDPh3i2oD45sdebKly7Elk612kui85z7hwNqi35t8Jb70vQXC/YOizTK1NRUvEgWR8S0RejPpnUg/YapYhQuXKDYYvWpwWbOspWrqsgFcrQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc0a7744-f3b8-475e-621c-08d7a0072e39
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jan 2020 13:21:39.5163
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0LjlnAn/Q5OUircIieH6MoDaIYh+Z/EH+YONmb+AIBSf+Q7/z+Ruu211yZlHh2wOijry895Twy82mihTaB+nAQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6247
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/23 8:11, Dave Chinner wrote:=0A=
[...]=0A=
>>> This also seems tailored around the call from zonefs_map_blocks()=0A=
>>> which tries to map the entire zone (length =3D zi->i_max_size) for=0A=
>>> writeback mappings. Hence the length in this case always requires=0A=
>>> clamping to zi->i_max_size - offset. Again, there's an issue here:=0A=
>>>=0A=
>>>> +static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,=0A=
>>>> +			     struct inode *inode, loff_t offset)=0A=
>>>> +{=0A=
>>>> +	if (offset >=3D wpc->iomap.offset &&=0A=
>>>> +	    offset < wpc->iomap.offset + wpc->iomap.length)=0A=
>>>> +		return 0;=0A=
>>>> +=0A=
>>>> +	memset(&wpc->iomap, 0, sizeof(wpc->iomap));=0A=
>>>> +	return zonefs_iomap_begin(inode, offset, ZONEFS_I(inode)->i_max_size=
,=0A=
>>>> +				  0, &wpc->iomap, NULL);=0A=
>>>=0A=
>>> Where we pass flags =3D 0 into zonefs_iomap_begin(), and so there is=0A=
>>> no checking that this writeback code path is only executing against=0A=
>>> a conventional zone. I.e. the comments and checks in=0A=
>>> zonefs_iomap_begin() relate only to user IO call paths, but don't=0A=
>>> validate or comment on the writeback path callers, and there's no=0A=
>>> comments or checks here that the inode points at a conventional=0A=
>>> zone, either....=0A=
>>=0A=
>> I do not understand your point here. Since all blocks are always=0A=
>> allocated for both conventional and sequential files, I think that=0A=
>> using i_max_size for calling zonefs_iomap_begin is OK:=0A=
> =0A=
> Yes, it is, but that wasn't really the point I was trying to make.=0A=
> My comments around passing in the max size here means that=0A=
> zonefs_iomap_begin() has to do clamping (i.e. the length =3D min(length,=
=0A=
> max_isize - offset) calls) just for this caller, as all the other=0A=
> callers from the user IO path already have their offset/lengths=0A=
> clamped to isize/max_isize. Hence if zonefs_map_blocks() clamped=0A=
> the length it passed to (i_max_size - offset) like all other callers=0A=
> do, then code in zonefs_iomap_begin() would be simpler.=0A=
=0A=
Aaah, I see it now. Indeed, that would be cleaner.=0A=
=0A=
>> for conventional=0A=
>> zone files, any of these blocks can be written, both user direct or=0A=
>> through the page cache. No distinction is I think necessary. For=0A=
>> sequential zone files, only the blocks at "offset" can be written, and=
=0A=
>> that value must be equal to zi->i_wpoffset (which account for in-=0A=
>> flights writes). In both cases, exceeding the max file size is not=0A=
>> allowed so this check is common in zonefs_iomap_begin() to cover all=0A=
>> users and not just zonefs_map_blocks(). Did I get something wrong with=
=0A=
>> iomap workings ?=0A=
> =0A=
> No, the point I was trying to make (unsucessfully!) is that=0A=
> zonefs_map_blocks() is only called from buffered writeback, and=0A=
> so it only called on conventional zone writes. Neither=0A=
> zonefs_map_blocks() or zonefs_iomap_begin() check this, and=0A=
> zonefs_iomap_begin() can't because it doesn't have any flags passed=0A=
> into it to tell it that a mapping for a write is being done.=0A=
> =0A=
> i.e. somewhere in this zonefs_map_blocks() codepath there needs to=0A=
> be a check like:=0A=
> =0A=
> 	WARN_ON_ONCE(zi->zi_type !=3D ZONEFS_ZTYPE_CNV);=0A=
> =0A=
> because we should never get here for sequential zones.=0A=
> =0A=
> And that then raises the question - if we can only get here for=0A=
> conventional zones, then wouldn't the code read better using=0A=
> the inode->i_size rather that the zi->i_max_size as all IO to=0A=
> conventional zones must be within the inode size?=0A=
=0A=
Got it. It is obvious now :) Will clean that.=0A=
=0A=
>>>> +	pos =3D (zone->wp - zone->start) << SECTOR_SHIFT;=0A=
>>>> +	zi->i_wpoffset =3D pos;=0A=
>>>> +	if (i_size_read(inode) !=3D pos) {=0A=
>>>> +		zonefs_update_stats(inode, pos);=0A=
>>>> +		i_size_write(inode, pos);=0A=
>>>> +	}=0A=
>>>=0A=
>>> What happens if this decreases the size of the zone? don't we need=0A=
>>> to invalidate the page cache beyond the new EOF in this case (i.e.=0A=
>>> it's a truncate operation)?=0A=
>>=0A=
>> This is called only for direct write errors into sequential zones.=0A=
>> Since for that case we only deal with append direct writes, there is no=
=0A=
>> possibility of having any of the written data cached already. So even=0A=
>> if we get a short write or complete failure, no invalidation is needed.=
=0A=
> =0A=
> Ah, there's a undocumented assumption that a write error never=0A=
> resets the zone write pointer completely, but only remains unchanged=0A=
> from where it was prior to the write that failed. My concern is what=0A=
> happens if the device decides that the error has caused the zone to=0A=
> be completely lost and so resets the write pointer back to zero?=0A=
=0A=
Such behavior is forbidden by the ZBC/ZAC specifications. If it happens, we=
=0A=
would be fighting with a drive that has serious firmware bugs. So I am not=
=0A=
sure if it is worth adding code for that. But at the very least, adding a=
=0A=
warning would be nice.=0A=
=0A=
> And the other concern here is what if the hardware write pointer=0A=
> still moves forward and exposes stale data because the write failed?=0A=
=0A=
The write pointer can indeed move forward even in the case of a failed=0A=
write. This typically happens if a bad sector is hit in the middle of a=0A=
write. In this case the write pointer is updated to point right after the=
=0A=
last written sector, so no stale data is exposed. This is mandated by the=
=0A=
ZBC/ZAC specifications. If the drive firmware is bad and the WP goes beyond=
=0A=
the last written sector, we would have no way of detecting the stale data.=
=0A=
But on SMR, those sectors will most likely be unreadable anyway. Movement=
=0A=
of the write pointer beyond the IO end though can be tested for.=0A=
I will improve the checks on error.=0A=
=0A=
>> Compared to errors for read operations in any zone, or conventional=0A=
>> zone files read/write errors, this error handling adds processing of=0A=
>> zone condition changes (error due to a zone going offline or read-=0A=
>> only). I could add the same treatment for all IO errors. I did not=0A=
>> since if we start seeing these zone conditions, it is likely that the=0A=
>> drive is about to die.=0A=
> =0A=
> Ok, so it's not expected, but it sounds like in extreme=0A=
> circumstances it can still occur, and hence we still should try to=0A=
> handle such errors in a sane manner.=0A=
=0A=
Yes. We can improve the checks. And if an unexpected (non standard) change=
=0A=
is detected, at the very least throw a warning, and possibly remount=0A=
read-only. For zones going offline or read-only, that is handled already=0A=
and the file attributes changed accordingly.=0A=
=0A=
>> So conventional zone writes and all read errors=0A=
>> are treated like on any other FS: only return the error to the user=0A=
>> without any drive-specific forensic done.=0A=
> =0A=
> Sure, but they don't go through this new error path :)=0A=
=0A=
No they don't, but looking some more at the code, it is not too hard to=0A=
include it for all IOs to all zone types. I will do the change.=0A=
=0A=
>>>> +static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size=
, int ret,=0A=
>>>> +				     unsigned int flags)=0A=
>>>> +{=0A=
>>>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>>>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>>>> +=0A=
>>>> +	if (ret)=0A=
>>>> +		return ret;=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * Conventional zone file size is fixed to the zone size so there=0A=
>>>> +	 * is no need to do anything.=0A=
>>>> +	 */=0A=
>>>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)=0A=
>>>> +		return 0;=0A=
>>>> +=0A=
>>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>>> +=0A=
>>>> +	if (size < 0) {=0A=
>>>> +		ret =3D zonefs_seq_file_write_failed(inode, size);=0A=
>>>=0A=
>>> Ok, so I see it is being called from IO completion context, whcih=0A=
>>> means we'd want memalloc_noio_save() because the underlying bio=0A=
>>> doesn't get freed until this whole completion runs, right?=0A=
>>=0A=
>> Yes, the failed BIO is freed only after the report zone is done. But=0A=
>> more than GFP_NOIO, we want GFP_NOFS for the reason stated above.=0A=
> =0A=
> Yes, I can see that GFP_NOFS is needed to avoid truncate lock=0A=
> recursion. However, we are in an IO completion routine here holding=0A=
> a bio, so what I'm asking is whether reclaim recursion back into the=0A=
> block layer and allocating more bios (e.g.  for swap to a=0A=
> conventional zone within the same zoned block device) is safe to do=0A=
> while we hold a bio from the same bioset that swap bios will be=0A=
> allocated from...=0A=
> =0A=
> i.e. doesn't this violate the forwards progress guarantee we need=0A=
> for bioset mempools? i.e. we now can't free a bio if nested=0A=
> allocation of a bio blocks waiting for a bio to be freed...=0A=
=0A=
Swap does not work on zoned block devices :) But I see your point. I think=
=0A=
it is indeed safer to use GFP_NOIO. Will change to that.=0A=
=0A=
>>>> +	/*=0A=
>>>> +	 * Direct writes must be aligned to the block size, that is, the dev=
ice=0A=
>>>> +	 * physical sector size, to avoid errors when writing sequential zon=
es=0A=
>>>> +	 * on 512e devices (512B logical sector, 4KB physical sectors).=0A=
>>>> +	 */=0A=
>>>> +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {=0A=
>>>> +		ret =3D -EINVAL;=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +=0A=
>>>> +	/*=0A=
>>>> +	 * Enforce sequential writes (append only) in sequential zones.=0A=
>>>> +	 */=0A=
>>>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>>>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>>>> +	    iocb->ki_pos !=3D zi->i_wpoffset) {=0A=
>>>> +		zonefs_err(inode->i_sb,=0A=
>>>> +			   "Unaligned write at %llu + %zu (wp %llu)\n",=0A=
>>>> +			   iocb->ki_pos, count,=0A=
>>>> +			   zi->i_wpoffset);=0A=
>>>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>>>> +		ret =3D -EINVAL;=0A=
>>>> +		goto out;=0A=
>>>> +	}=0A=
>>>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>>>> +=0A=
>>>> +	ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops, &zonefs_dio_ops,=
=0A=
>>>> +			   is_sync_kiocb(iocb));=0A=
>>>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>>>> +	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {=0A=
>>>> +		if (ret > 0)=0A=
>>>> +			count =3D ret;=0A=
>>>> +		mutex_lock(&zi->i_truncate_mutex);=0A=
>>>> +		zi->i_wpoffset +=3D count;=0A=
>>>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>>>=0A=
>>> Hmmmm. This looks problematic w.r.t. AIO. If we get -EIOCBQUEUED it=0A=
>>> means the IO has been queued but not necessarily submitted, but=0A=
>>> we update zi->i_wpoffset as though the entire AIO has laready=0A=
>>> completed. ANd then we drop the inode_lock() and return, allowing=0A=
>>> another AIO+DIO to be started.=0A=
>>>=0A=
>>> Hence another concurrent sequential AIO+DIO write could now be=0A=
>>> submitted and pass the above iocb->ki_pos !=3D zi->i_wpoffset check.=0A=
>>> Now we have two independent IOs in flight - one that is at the=0A=
>>> current hardware write pointer offset, and one that is beyond it.=0A=
>>>=0A=
>>> What happens if the block layer now re-orders these two IOs?=0A=
>>=0A=
>> If the correct block scheduler is used, that is mq-deadline, there is=0A=
>> no possibility of write reordering.=0A=
> =0A=
> Oh, my.=0A=
> =0A=
> That needs a great big warning in the code. This assumes the block=0A=
> layer functions in a specific manner, and there is no way to=0A=
> guarantee that it does at the filesystem layer. Hence if the block=0A=
> layer is subtly broken (which has happened far too many times in the=0A=
> past couple of years for me to just trust it anymore) then this code=0A=
> can result in spurious write failures for applications that use=0A=
> AIO+DIO...=0A=
=0A=
Yes. Absolutely true. I will add comments explaining this point. Of note is=
=0A=
that the same is true not only for AIOs but also for large sync write DIOs=
=0A=
too as these can get split into multiple write requests that can get=0A=
reordered without the correct system setup.=0A=
=0A=
>> mq-deadline is now the default IO=0A=
>> scheduler for zoned block devices and the only one that is allowed=0A=
>> (beside "none"). mq-deadline uses a zone write locking mechanism to=0A=
>> ensure that there is no reordering of write requests, either by the=0A=
>> block layer itself or by bad hardware (SATA AHCI adapters are=0A=
>> notoriously bad and silently reorder requests all the time, even for=0A=
>> SMR disks).=0A=
>>=0A=
>> With this mechanism, the user can safely use io_submit() beyond a=0A=
>> single IO and zonefs check that the set of AIOs being submitted are all=
=0A=
>> sequential starting from the zi->i_wpoffset "soft" write pointer that=0A=
>> reflects the already in-flight AIOs. Multiple io_submit() of multiple=0A=
>> AIOs can be executed in sequence without needing to limit to a single=0A=
>> AIO at a time.=0A=
> =0A=
> I can see lots of potential problems with AIO on a filesystem that=0A=
> assumes sequential, ordered AIO submission. e.g. RWF_NOWAIT and=0A=
> submitting multiple sequential IOs at a time. First IO gets EAGAIN=0A=
> because a lock is held by something else, second IO gets the lock=0A=
> and now returns -EINVAL because it's offset no longer matches the=0A=
> write pointer because the first IO got -EAGAIN and punted back to=0A=
> userspace.=0A=
=0A=
Ah, yes indeed. I overlooked this case. I guess we have several solutions:=
=0A=
(1) return an error if RWF_NOWAIT is specified, (2) Ignore it and proceed=
=0A=
as if it is not specified, or (3) keep as is and let the user handle the=0A=
error pattern.=0A=
=0A=
This error case is still safe with regard to the file size/zone WP: the=0A=
file size is kept unchanged from the value inspected for the first -EAGAIN=
=0A=
failed AIO and the user can restart writing from there. Not too bad. But I=
=0A=
am leaning toward solution (2) to reduce these potential spurious errors.=
=0A=
=0A=
> Or worse, it's io_uring, and it punts that IO to a worker thread to=0A=
> resubmit. Now that IO will be issued out of order to all the others,=0A=
> and so userspace will see that it succeeds, but all the other IOs in=0A=
> the sequential batch get -EINVAL because of IO reordering long=0A=
> before the IO even gets to the block layer....=0A=
=0A=
Yes, same here with the difference that we would have requests being=0A=
uselessly sent to the disk and failed with EIO instead of EINVAL. But=0A=
again, this is still safe with regard to the inode size/write pointer as no=
=0A=
change happen.=0A=
=0A=
>> If a disk error occurs along the way, the seq file size and zi-=0A=
>>> i_wpoffset are updated using the report zone result. All in-flight or=
=0A=
>> submitted AIOs after the failed one will be failed by the disk itself=0A=
>> due to the their now unaligned position. These failures will not change=
=0A=
>> again the file size or zi->i_wpoffset since the zone information will=0A=
>> be the same after all failures. The user only has to look at the file=0A=
>> size again to know were to restart writing from without even needing to=
=0A=
>> wait for all in-flight AIO to complete with an error (but that would of=
=0A=
>> course be the recommended practice).=0A=
> =0A=
> So I'm guessing that the same failure condition will return=0A=
> different errors based on where the failure is detected. e.g. EINVAL=0A=
> if it's at the write submission layer and EIO if it is reported by=0A=
> the hardware?=0A=
=0A=
Yes, correct. With some additional work in the block layer, we could also=
=0A=
return -EINVAL for all unaligned writes failed by the disk. This would=0A=
indicate a soft recoverable error rather than the generally more serious=0A=
EIO. At the drive level, ZBC and ZAC define sense codes for unaligned=0A=
writes which could be mapped to a new blk status code, which in turn can be=
=0A=
converted to a -EINVAL for failed unaligned write bios. That can be done=0A=
separately from zonefs though. Will look at it.=0A=
=0A=
>> In other word, we assume here that all write succeed and allow high-=0A=
>> queue depth submission using zi->i_wpoffset as a "soft" write pointer.=
=0A=
> =0A=
> I'm starting to wonder whether it is a good idea to even support AIO=0A=
> on sequential zones because there are some really messy spurious=0A=
> failure cases that userspace will not be able to distinguish from=0A=
> real write errors. That's not a very nice API for applications to=0A=
> have to deal with...=0A=
=0A=
Yes, but I would argue that zonefs does not make this error processing=0A=
harder than with the raw zoned block device use case. If anything, zonefs=
=0A=
is already an improvement over the complete lack of zone device specific=0A=
error handling of the block device file IO path. Unless I get a lot of=0A=
push-back, I would rather keep AIOs and work on suppressing bad patterns=0A=
due to RWF_NOWAIT and other corner cases.=0A=
=0A=
> At minimum, this needs extensive documentation both for users and=0A=
> for kernel filesystem people that need to maintain this code forever=0A=
> more...=0A=
=0A=
Yes, OK. I will add more comments and improve the documentation file=0A=
mentioning these points.=0A=
=0A=
Thank you for your comments.=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
