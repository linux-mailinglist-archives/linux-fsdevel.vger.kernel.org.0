Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 75F6E6A74F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Jul 2019 13:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387708AbfGPLVw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 07:21:52 -0400
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:59266 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387658AbfGPLVu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 07:21:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1563276110; x=1594812110;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=TuIT7CVnserEl/AzHfozlulsEBlXyhOFwL9CVqTceYI=;
  b=YZ/xN8vJ/idMYTOfvFrVOlWRdUJUwxFFCKa0xQrLXvObxLup1ZumCITt
   OzrwksjfOSFbltZEQHyvJNFEYjNsqF5NYjemZDrArkIPoiGGZL+WquqEo
   cOOxZLTKdyGrWYXSBEG/mWRnWZBVW+/NH94uQCBnsDKoUC759t1sRMQm5
   lBaSJ6Ke6PoUh3h1t8zRGsVklswa+eMLI8YSlEKs/ArR2tzKb1VFOXKDr
   72FThB8yWaAhj2C31aFBZ40zFKKNxHl2OJKATONQdXPKhSZqiybll0wvf
   O3XT1eZc8wgYzHaLAkvAvYUf+A0vXkhtCUfjDbPtUrvA+hNIzyPm+DRSD
   Q==;
IronPort-SDR: yguZnuvfYFTcwM3JIxB9AWywNoJQ09TevH+8ZQRfGqeUvOLKkpEiKNuWYVWzodQNYPuliWEi87
 TkgyjqOrsDJ4T497GtRAENJKhz7xuVX2VCW+Rt5OSjKoPJLNoq4IPhojyQz8doBGtk2nDLdR28
 dyl1xKWd9QhcAw33MUYiPdpXtTY0pZ6KnZKVVeBqglrrTauH3dh/Ht69ED39t2Il/jbZR72qB7
 hp67zXNhyEXe+w1MyBZ95PGqAWLIh9sZs7ClAVUICP8VdsJbIwKinXbL+vgglpYR7jejatL2xJ
 JZU=
X-IronPort-AV: E=Sophos;i="5.63,498,1557158400"; 
   d="scan'208";a="113168402"
Received: from mail-dm3nam05lp2055.outbound.protection.outlook.com (HELO NAM05-DM3-obe.outbound.protection.outlook.com) ([104.47.49.55])
  by ob1.hgst.iphmx.com with ESMTP; 16 Jul 2019 19:21:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PRf5MGPNMDtLCoj9zJrZIwnGGNlpzQmlJb217oJKfUgQG9tMEQuUWFMiuw9DWqX7VcJ9VQxEvZt3iwSatl4z4pON9Er1uqf2MT0+Onf+Fs01R5gF0gINqI6edt+6o5ERfG1q9HTd58tL8mVov7c0ESc+0r/4xopm/Lt2uaUgoLyuKYy48RrxJ5dZkxFhrsCU+jW/V7g4zEzBqTFelmZDRK9SC9LcNxTOzPSYYMwNNYWHOe85Ojg1tf3JkQ4vt32fsMI07HXsZEExJPNOrLNh7j4gALPsOHv7fsIwOUEOTfTlA1zq0G7BB6kH2hnqnGNA3uUAtpDytNP/VnbTTuoo8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbqyAalFTaxl998dOt1mAsjpbOoeVI2MCfO7zyG5baU=;
 b=KWwMQlyBqx/Sb+7gfusDA0qJXyKy+dN9Q9qAZHEdlNptufdo4cxGz/RYeMWBouT/TXGRPxL8ZImHPcmgIia/oO2/jRO6xe7ZG2Y2Jq6TWBwii1lHRNcfumUMB6Uuhg3WhIVNRw13TAs/phRT/mfmudi4PMX8pkQTf7cnqxhFyNxwK91f5N5I+wYri9hEp1ELYF/6L/8m6FAFDv+58QNutKstRlV7Rp9tRNvjsL6Hg6JoYTp40ZZz3k8cYgFXtsXIQ2oaC0K+6YPp2xUWVyQ4rCg6Vb/JWyIdXXOqVwFxxr5RWbeLk7IgVKHWqoRs6scNV4r3LmbIQlvEVK3OVfSzIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LbqyAalFTaxl998dOt1mAsjpbOoeVI2MCfO7zyG5baU=;
 b=vmGVDZeeRzAGV2vw/++O1ntM++cN1uYme/4zhn98LLvUeKrw86sROSyzXmgy7/65XhMPaZU8LPfEi8y5qjeA5N+AsuZj9bYRSUKmCexd06duzwpzbd/xIzD5fX6EPvrYFcEC+AifX7ZrYybHqo3oTy17iD/mvASZLh3HBcm6vwM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5717.namprd04.prod.outlook.com (20.179.57.161) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2073.11; Tue, 16 Jul 2019 11:21:46 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2073.012; Tue, 16 Jul 2019
 11:21:46 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dave Chinner <david@fromorbit.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH RFC] fs: New zonefs file system
Thread-Topic: [PATCH RFC] fs: New zonefs file system
Thread-Index: AQHVOF31k+9+55ZdEkmKABdH1mzidg==
Date:   Tue, 16 Jul 2019 11:21:45 +0000
Message-ID: <BYAPR04MB5816B0550DE134326E782447E7CE0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190712030017.14321-1-damien.lemoal@wdc.com>
 <20190715011935.GM7689@dread.disaster.area>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [129.253.182.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 084ac8a8-1451-44a9-975c-08d709dfc997
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5717;
x-ms-traffictypediagnostic: BYAPR04MB5717:
x-microsoft-antispam-prvs: <BYAPR04MB5717905EED7D0F418D3A12B6E7CE0@BYAPR04MB5717.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:1227;
x-forefront-prvs: 0100732B76
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(376002)(396003)(39860400002)(346002)(366004)(189003)(199004)(74316002)(9686003)(6116002)(53946003)(305945005)(476003)(478600001)(25786009)(71190400001)(55016002)(66946007)(71200400001)(446003)(316002)(54906003)(76116006)(3846002)(256004)(14444005)(186003)(66446008)(26005)(53936002)(7736002)(64756008)(6246003)(8936002)(102836004)(66066001)(99286004)(6436002)(68736007)(66476007)(81156014)(81166006)(66556008)(30864003)(5660300002)(8676002)(2906002)(53546011)(33656002)(6916009)(14454004)(229853002)(76176011)(52536014)(7696005)(486006)(4326008)(6506007)(86362001)(579004);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5717;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: ow7d+511aFJb+IKCKf5gm1gjjczsGoZDrPMgSOt/TcJ94IZ2JZne3VPlSfVcUXcq1H3IkC94L/muLWOh0DFZx30Pl4XckmjzCIsH8KiPS0vW5jWmqWOkiJSvboSZaEPF+YCKyLmZLcrLEt9SKHicyF+NeTU9x88OAEKg971YPxZilSu9ozbm/TZUez5Jh31vQ4mlJ9vwL2mAtzhZyZI+GQCnTo3tK7iU6KX9wWkEcoDDajkmQQrhuACdiy+HDSAsGRz4FfWHTIRm1ANS/ow0aX8i2qTHVS8CvPUT3J++xTf5MhEghzb9OLw7wEiyM48ge4cuZCn93toZC5GEOjPYleDtzUTpI8IdwUB2qQi/ZF7c/nHH+Xl6YNO6Swu/X/yFAohxcupbNGz66mlsu+boCDJCFxOzQBll63/PE0cOZ1s=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 084ac8a8-1451-44a9-975c-08d709dfc997
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2019 11:21:45.8907
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5717
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Dave,=0A=
=0A=
On 2019/07/15 10:20, Dave Chinner wrote:=0A=
> Just a few quick things as I read through this to see how it uses=0A=
> iomap....=0A=
> =0A=
> On Fri, Jul 12, 2019 at 12:00:17PM +0900, Damien Le Moal wrote:=0A=
>> +static int zonefs_iomap_begin(struct inode *inode, loff_t offset, loff_=
t length,=0A=
>> +			      unsigned int flags, struct iomap *iomap)=0A=
>> +{=0A=
=0A=
[...]=0A=
=0A=
>> +	/* An IO cannot exceed the zone size */=0A=
>> +	if (offset >=3D max_isize)=0A=
>> +		return -EFBIG;=0A=
> =0A=
> So a write() call that is for a length longer than max_isize is=0A=
> going to end up being a short write? i.e. iomap_apply() will loop=0A=
> mapping the inode until either we reach the end of the user write=0A=
> or we hit max_isize?=0A=
> =0A=
> How is userspace supposed to tell the difference between a short=0A=
> write and a write that overruns max_isize?=0A=
=0A=
offset >=3D max_isize is already checked when zonefs_file_write_iter() is c=
alled=0A=
and the write size truncated in that function too so that a write never goe=
s=0A=
beyond the zone size. This check here is probably redundant and not needed.=
 I=0A=
left it temporarily to make sure I was using iomap correctly and to check b=
ugs.=0A=
=0A=
>> +static int zonefs_map_blocks(struct iomap_writepage_ctx *wpc,=0A=
>> +			     struct inode *inode, loff_t offset)=0A=
>> +{=0A=
>> +	if (offset >=3D wpc->iomap.offset &&=0A=
>> +	    offset < wpc->iomap.offset + wpc->iomap.length)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	memset(&wpc->iomap, 0, sizeof(wpc->iomap));=0A=
>> +	return zonefs_iomap_begin(inode, offset, INT_MAX, 0, &wpc->iomap);=0A=
> =0A=
> Why is the write length set to INT_MAX here? What happens when we=0A=
> get a zone that is larger than 2GB? i.e. the length parameter is a=0A=
> loff_t, not an int....=0A=
=0A=
Yes indeed. Since no access can go beyond the file size,=0A=
zonefs_file_max_size(inode) is the right value here I think, even though=0A=
LLONG_MAX would work too.=0A=
=0A=
>> +static int zonefs_truncate_seqfile(struct inode *inode)=0A=
>> +{=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	/* Serialize against page faults */=0A=
>> +	down_write(&zi->i_mmap_sem);=0A=
>> +=0A=
>> +	ret =3D blkdev_reset_zones(inode->i_sb->s_bdev,=0A=
>> +				 zonefs_file_addr(inode) >> SECTOR_SHIFT,=0A=
>> +				 zonefs_file_max_size(inode) >> SECTOR_SHIFT,=0A=
>> +				 GFP_KERNEL);=0A=
> =0A=
> Not sure GFP_KERNEL is safe here. This is called holding a=0A=
> filesystem lock here, so it's not immediately clear to me if this=0A=
> can deadlock through memory reclaim or not...=0A=
=0A=
Conventional zones can be written with buffered I/Os and mmap, so recursing=
 into=0A=
the FS on the memory allocation while holding i_mmap_sem is a possibility I=
=0A=
think. I changed this to GFP_NOFS.=0A=
=0A=
=0A=
>> +static int zonefs_inode_setattr(struct dentry *dentry, struct iattr *ia=
ttr)=0A=
>> +{=0A=
>> +	struct inode *inode =3D d_inode(dentry);=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	ret =3D setattr_prepare(dentry, iattr);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	if ((iattr->ia_valid & ATTR_UID &&=0A=
>> +	     !uid_eq(iattr->ia_uid, inode->i_uid)) ||=0A=
>> +	    (iattr->ia_valid & ATTR_GID &&=0A=
>> +	     !gid_eq(iattr->ia_gid, inode->i_gid))) {=0A=
>> +		ret =3D dquot_transfer(inode, iattr);=0A=
>> +		if (ret)=0A=
>> +			return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (iattr->ia_valid & ATTR_SIZE) {=0A=
>> +		/* The size of conventional zone files cannot be changed */=0A=
>> +		if (zonefs_file_is_conv(inode))=0A=
>> +			return -EPERM;=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * For sequential zone files, we can only allow truncating to=0A=
>> +		 * 0 size which is equivalent to a zone reset.=0A=
>> +		 */=0A=
>> +		if (iattr->ia_size !=3D 0)=0A=
>> +			return -EPERM;=0A=
>> +=0A=
>> +		ret =3D zonefs_truncate_seqfile(inode);=0A=
>> +		if (ret)=0A=
>> +			return ret;=0A=
> =0A=
> Ok, so we are calling zonefs_truncate_seqfile() holding the i_rwsem=0A=
> as well. That does tend to imply GFP_NOFS should probably be used=0A=
> for the blkdev_reset_zones() call.=0A=
=0A=
Yes. Fixed. Thanks.=0A=
=0A=
>> +/*=0A=
>> + * Open a file.=0A=
>> + */=0A=
>> +static int zonefs_file_open(struct inode *inode, struct file *file)=0A=
>> +{=0A=
>> +	/*=0A=
>> +	 * Note: here we can do an explicit open of the file zone,=0A=
>> +	 * on the first open of the inode. The explicit close can be=0A=
>> +	 * done on the last release (close) call for the inode.=0A=
>> +	 */=0A=
>> +=0A=
>> +	return generic_file_open(inode, file);=0A=
>> +}=0A=
> =0A=
> Why is a wrapper needed for this?=0A=
=0A=
It is not for now. As the comment says, we may want to have a wrapper like =
this=0A=
in the future to do a device level zone open/close in sync with file=0A=
open/release. This is not useful for SMR HDDs but probably will for NVMe zo=
ned=0A=
namespace devices.=0A=
=0A=
>> +static int zonefs_file_fsync(struct file *file, loff_t start, loff_t en=
d,=0A=
>> +			     int datasync)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(file);=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Since only direct writes are allowed in sequential files, we only=
=0A=
>> +	 * need a device flush for these files.=0A=
>> +	 */=0A=
>> +	if (zonefs_file_is_seq(inode))=0A=
>> +		goto flush;=0A=
>> +=0A=
>> +	ret =3D file_write_and_wait_range(file, start, end);=0A=
>> +	if (ret =3D=3D 0)=0A=
>> +		ret =3D file_check_and_advance_wb_err(file);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
> =0A=
>> +=0A=
>> +flush:=0A=
>> +	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);=0A=
> =0A=
> The goto can be avoided in this case simply:=0A=
> =0A=
> 	if (zonefs_file_is_conv(inode)) {=0A=
> 		/* do flush */=0A=
> 	}=0A=
> 	return blkdev_issue_flush(inode->i_sb->s_bdev, GFP_KERNEL, NULL);=0A=
=0A=
Good point. Fixed.=0A=
=0A=
>> +static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_ite=
r *to)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>> +	loff_t max_pos =3D zonefs_file_max_size(inode);=0A=
>> +	size_t count;=0A=
>> +	ssize_t ret =3D 0;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Check that the read operation does not go beyond the maximum=0A=
>> +	 * file size.=0A=
>> +	 */=0A=
>> +	if (iocb->ki_pos >=3D zonefs_file_max_size(inode))=0A=
>> +		return -EFBIG;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * For sequential zones, limit reads to written data.=0A=
>> +	 */=0A=
>> +	if (zonefs_file_is_seq(inode))=0A=
>> +		max_pos =3D i_size_read(inode);=0A=
>> +	if (iocb->ki_pos >=3D max_pos)=0A=
>> +		return 0;=0A=
> =0A=
> Isn't this true for both types of zone at this point? i.e. at this=0A=
> point:=0A=
> =0A=
> 	max_pos =3D i_size_read(inode);=0A=
> 	if (iocb->ki_pos >=3D max_pos)=0A=
> 		return 0;=0A=
> =0A=
> because i_size is either the zonefs_file_max_size() for conventional=0A=
> zones (which we've already checked) or it's the write pointer for=0A=
> a sequential zone. i.e. it's the max position for either case.=0A=
=0A=
Yes, correct. I fixed it.=0A=
=0A=
> =0A=
>> +	iov_iter_truncate(to, max_pos - iocb->ki_pos);=0A=
>> +	count =3D iov_iter_count(to);=0A=
>> +	if (!count)=0A=
>> +		return 0;=0A=
> =0A=
> The iov_iter should never be zero length here, because that implies=0A=
> the position was >=3D max_pos and that will be caught by the above=0A=
> checks...=0A=
=0A=
Absolutely. Fixed.=0A=
=0A=
> =0A=
>> +	/* Direct IO reads must be aligned to device physical sector size */=
=0A=
>> +	if ((iocb->ki_flags & IOCB_DIRECT) &&=0A=
>> +	    ((iocb->ki_pos | count) & sbi->s_blocksize_mask))=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>> +		if (!inode_trylock_shared(inode))=0A=
>> +			return -EAGAIN;=0A=
>> +	} else {=0A=
>> +		inode_lock_shared(inode);=0A=
>> +	}=0A=
> =0A=
> IIUC, write IO completion takes the inode lock to serialise file=0A=
> size updates for sequential zones. In that case, shouldn't this lock=0A=
> be taken before we do the EOF checks above?=0A=
=0A=
Yes. Fixed.=0A=
=0A=
>> +/*=0A=
>> + * We got a write error: get the sequenial zone information from the de=
vice to=0A=
>> + * figure out where the zone write pointer is and verify the inode size=
 against=0A=
>> + * it.=0A=
>> + */=0A=
>> +static int zonefs_write_failed(struct inode *inode, int error)=0A=
>> +{=0A=
>> +	struct super_block *sb =3D inode->i_sb;=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	sector_t sector =3D zi->i_addr >> SECTOR_SHIFT;=0A=
>> +	unsigned int noio_flag;=0A=
>> +	struct blk_zone zone;=0A=
>> +	int n =3D 1, ret;=0A=
>> +=0A=
>> +	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);=0A=
>> +=0A=
>> +	noio_flag =3D memalloc_noio_save();=0A=
>> +	ret =3D blkdev_report_zones(sb->s_bdev, sector, &zone, &n);=0A=
>> +	memalloc_noio_restore(noio_flag);=0A=
> =0A=
> What deadlock does the memalloc_noio_save() avoid? There should be a=0A=
> comment explaining what problem memalloc_noio_save() avoids=0A=
> everywhere it is used like this. If it isn't safe to do GFP_KERNEL=0A=
> allocations here under the i_rwsem, then why would it be safe to=0A=
> do GFP_KERNEL allocations in the truncate code under the i_rwsem?=0A=
=0A=
Similarly to the truncate (zone reset) code, GFP_NOFS is safer here. So I=
=0A=
changed the call to memalloc_nofs_save/restore and added a comment.=0A=
=0A=
>> +=0A=
>> +	if (!n)=0A=
>> +		ret =3D -EIO;=0A=
>> +	if (ret) {=0A=
>> +		zonefs_err(sb, "Get zone %llu report failed %d\n",=0A=
>> +			   sector, ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	zi->i_wpoffset =3D (zone.wp - zone.start) << SECTOR_SHIFT;=0A=
>> +	if (i_size_read(inode) !=3D zi->i_wpoffset) {=0A=
>> +		i_size_write(inode, zi->i_wpoffset);=0A=
>> +		truncate_pagecache(inode, zi->i_wpoffset);=0A=
>> +	}=0A=
> =0A=
> This looks .... dangerous. If the write pointer was advanced, but=0A=
> the data wasn't written properly, this causes stale data exposure on=0A=
> write failure. i.e. it's not failsafe.=0A=
=0A=
It is safe because the device will return zeros or the format pattern for s=
ector=0A=
reads that are beyond the zone write pointer. No stale data will be exposed=
, as=0A=
long as the device can be trusted to correctly handle reads beyond the writ=
e=0A=
pointer.=0A=
=0A=
> =0A=
> I suspect that on a sequential zone write failure and the write=0A=
> pointer does not equal the offset of the write, we should consider=0A=
> the zone corrupt. Also, this is for direct IO completion for=0A=
> sequential writes, yes? So what does the page cache truncation=0A=
> acheive given that only direct IO writes are allowed to these files?=0A=
=0A=
Yes, the page cache truncation can be removed.=0A=
=0A=
>> +static int zonefs_dio_seqwrite_end_io(struct kiocb *iocb, ssize_t size,=
=0A=
>> +				      unsigned int flags)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	inode_lock(inode);=0A=
>> +	if (size < 0)=0A=
>> +		ret =3D zonefs_write_failed(inode, size);=0A=
>> +	else=0A=
>> +		ret =3D zonefs_update_size(inode, iocb->ki_pos + size);=0A=
>> +	inode_unlock(inode);=0A=
>> +	return ret;=0A=
> =0A=
> Shouldn't this have a check that it's being called on a sequential=0A=
> zone inode?=0A=
=0A=
Yes, a check can be added but the only caller being zonefs_file_dio_aio_wri=
te()=0A=
after checking that the inode is not a conventional zone file, I thought it=
 was=0A=
not needed.=0A=
=0A=
>> +static ssize_t zonefs_file_dio_aio_write(struct kiocb *iocb,=0A=
>> +					 struct iov_iter *from)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	size_t count;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * The size of conventional zone files is fixed to the zone size.=0A=
>> +	 * So only direct writes to sequential zones need adjusting the=0A=
>> +	 * inode size on IO completion.=0A=
>> +	 */=0A=
>> +	if (zonefs_file_is_conv(inode))=0A=
>> +		return iomap_dio_rw(iocb, from, &zonefs_iomap_ops, NULL);=0A=
>> +=0A=
>> +	/* Enforce append only sequential writes */=0A=
>> +	count =3D iov_iter_count(from);=0A=
>> +	if (iocb->ki_pos !=3D zi->i_wpoffset) {=0A=
>> +		zonefs_err(inode->i_sb,=0A=
>> +			   "Unaligned write at %llu + %zu (wp %llu)\n",=0A=
>> +			   iocb->ki_pos, count, zi->i_wpoffset);=0A=
>> +		return -EINVAL;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (is_sync_kiocb(iocb)) {=0A=
>> +		/*=0A=
>> +		 * Don't use the end_io callback for synchronous iocbs,=0A=
>> +		 * as we'd deadlock on i_rwsem.  Instead perform the same=0A=
>> +		 * actions manually here.=0A=
>> +		 */=0A=
>> +		count =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops, NULL);=0A=
>> +		if (count < 0)=0A=
>> +			return zonefs_write_failed(inode, count);=0A=
>> +		zonefs_update_size(inode, iocb->ki_pos);=0A=
>> +		return count;=0A=
> =0A=
> Urk. This locking is nasty, and doesn't avoid the problem.....=0A=
=0A=
Do you mean the stale data exposure problem ? As said above, the device=0A=
guarantees that stale data will not be returned for reads after write point=
er.=0A=
Old data (data written before the last zone reset) is not readable.=0A=
=0A=
> =0A=
>> +	}=0A=
>> +=0A=
>> +	return iomap_dio_rw(iocb, from, &zonefs_iomap_ops,=0A=
>> +			    zonefs_dio_seqwrite_end_io);=0A=
> =0A=
> ... because I think this can deadlock.=0A=
> =0A=
> AFAIA, the rule is that IO completion callbacks cannot take=0A=
> a lock that is held across IO submission. The reason is that=0A=
> IO can complete so fast that the submission code runs the=0A=
> completion. i.e. iomap_dio_rw() can be the function that calls=0A=
> iomap_dio_complete() and runs the IO completion.=0A=
> =0A=
> In which case, this will deadlock because we are already holding the=0A=
> i_rwsem and the end_io completion will try to take it again.=0A=
=0A=
Arrg ! Yes ! Beginner's mistake. Will rework this.=0A=
> =0A=
> =0A=
> =0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_it=
er *from)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>> +	size_t count;=0A=
>> +	ssize_t ret;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Check that the read operation does not go beyond the file=0A=
>> +	 * zone boundary.=0A=
>> +	 */=0A=
>> +	if (iocb->ki_pos >=3D zonefs_file_max_size(inode))=0A=
>> +		return -EFBIG;=0A=
>> +	iov_iter_truncate(from, zonefs_file_max_size(inode) - iocb->ki_pos);=
=0A=
>> +	count =3D iov_iter_count(from);=0A=
>> +=0A=
>> +	if (!count)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Direct IO writes are mandatory for sequential zones so that write I=
O=0A=
>> +	 * order is preserved. The direct writes also must be aligned to=0A=
>> +	 * device physical sector size.=0A=
>> +	 */=0A=
>> +	if (iocb->ki_flags & IOCB_DIRECT) {=0A=
>> +		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask)=0A=
>> +			return -EINVAL;=0A=
>> +	} else {=0A=
>> +		if (zonefs_file_is_seq(inode))=0A=
>> +			return -EOPNOTSUPP;=0A=
> =0A=
> zonefs_iomap_begin() returns -EIO in this case and issues a warning.=0A=
> This seems somewhat inconsistent....=0A=
=0A=
Yes. The check in zonefs_iomap_begin() is probably redundant. Will remove i=
t.=0A=
=0A=
>> +	}=0A=
>> +=0A=
>> +	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>> +		if (!inode_trylock(inode))=0A=
>> +			return -EAGAIN;=0A=
>> +	} else {=0A=
>> +		inode_lock(inode);=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D generic_write_checks(iocb, from);=0A=
>> +	if (ret <=3D 0)=0A=
>> +		goto out;=0A=
> =0A=
> Shouldn't this be done before the iov_iter is truncated?=0A=
=0A=
Yes. Will move it.=0A=
=0A=
> =0A=
>> +=0A=
>> +	if (iocb->ki_flags & IOCB_DIRECT)=0A=
>> +		ret =3D zonefs_file_dio_aio_write(iocb, from);=0A=
>> +	else=0A=
>> +		ret =3D iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);=0A=
>> +=0A=
>> +out:=0A=
>> +	inode_unlock(inode);=0A=
>> +=0A=
>> +	if (ret > 0 && (!(iocb->ki_flags & IOCB_DIRECT))) {=0A=
>> +		iocb->ki_pos +=3D ret;=0A=
>> +		ret =3D generic_write_sync(iocb, ret);=0A=
>> +	}=0A=
> =0A=
> Hmmm. The split of checks and doing stuff between direct IO and=0A=
> buffered IO seems a bit arbitrary. e.g. the "sequential zones can=0A=
> only do append writes" is in zonefs_file_dio_aio_write(), but we=0A=
> do a check that "sequential zones can only do direct IO" here.=0A=
> =0A=
> And then we have the sync code that can only occur on buffered IO,=0A=
> which we don't have a wrapper function for but really should.  And I=0A=
> suspect that the locking is going to have to change here because of=0A=
> the direct IO issues, so maybe it would be best to split this up=0A=
> similar to the way XFS has two completely separate functions for the=0A=
> two paths....=0A=
=0A=
Yes, very good idea. I will clean this up to clarify all cases.=0A=
=0A=
>> +static struct kmem_cache *zonefs_inode_cachep;=0A=
>> +=0A=
>> +static struct inode *zonefs_alloc_inode(struct super_block *sb)=0A=
>> +{=0A=
>> +	struct zonefs_inode_info *zi;=0A=
>> +=0A=
>> +	zi =3D kmem_cache_alloc(zonefs_inode_cachep, GFP_KERNEL);=0A=
>> +	if (!zi)=0A=
>> +		return NULL;=0A=
>> +=0A=
>> +	init_rwsem(&zi->i_mmap_sem);=0A=
>> +	inode_init_once(&zi->i_vnode);=0A=
>> +=0A=
>> +	return &zi->i_vnode;=0A=
>> +}=0A=
>> +=0A=
>> +static void zonefs_destroy_cb(struct rcu_head *head)=0A=
>> +{=0A=
>> +	struct inode *inode =3D container_of(head, struct inode, i_rcu);=0A=
>> +=0A=
>> +	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));=0A=
>> +}=0A=
>> +=0A=
>> +static void zonefs_destroy_inode(struct inode *inode)=0A=
>> +{=0A=
>> +	call_rcu(&inode->i_rcu, zonefs_destroy_cb);=0A=
>> +}=0A=
> =0A=
> If this is all the inode destructor is, then implement ->free_inode=0A=
> instead. i.e.=0A=
> =0A=
> zonefs_free_inode(inode)=0A=
> {=0A=
> 	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));=0A=
> }=0A=
> =0A=
> and the VFS takes care of the RCU freeing of the inode.=0A=
=0A=
Yes, I remember now that the rcu free inode code was moved as generic in VF=
S a=0A=
while back. I will clean this up.=0A=
=0A=
> =0A=
>> +/*=0A=
>> + * File system stat.=0A=
>> + */=0A=
>> +static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)=0A=
>> +{=0A=
>> +	struct super_block *sb =3D dentry->d_sb;=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	sector_t nr_sectors =3D sb->s_bdev->bd_part->nr_sects;=0A=
>> +	enum zonefs_ztype t;=0A=
>> +=0A=
>> +	buf->f_type =3D ZONEFS_MAGIC;=0A=
>> +	buf->f_bsize =3D dentry->d_sb->s_blocksize;=0A=
>> +	buf->f_namelen =3D ZONEFS_NAME_MAX;=0A=
>> +=0A=
>> +	buf->f_blocks =3D nr_sectors >> (sb->s_blocksize_bits - SECTOR_SHIFT);=
=0A=
>> +	buf->f_bfree =3D 0;=0A=
>> +	buf->f_bavail =3D 0;=0A=
>> +=0A=
>> +	buf->f_files =3D sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] - 1;=0A=
>> +	for (t =3D ZONEFS_ZTYPE_ALL; t < ZONEFS_ZTYPE_MAX; t++) {=0A=
>> +		if (sbi->s_nr_zones[t])=0A=
>> +			buf->f_files++;=0A=
>> +	}=0A=
>> +	buf->f_ffree =3D 0;=0A=
>> +=0A=
>> +	/* buf->f_fsid =3D 0; uuid, see ext2 */=0A=
> =0A=
> This doesn't tell me anything useful. Does it mean "we should use=0A=
> the uuid like ext2" or something else? is it a "TODO:" item?=0A=
=0A=
Basically yes. Forgot to code it after too much copy-paste :)=0A=
Will fix that.=0A=
=0A=
>> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] =3D {=0A=
>> +	NULL,=0A=
>> +	"cnv",=0A=
>> +	"seq"=0A=
>> +};=0A=
> =0A=
> What's the reason for a NULL in the first entry?=0A=
=0A=
This is for ZONEFS_ZTYPE_ALL, which does not have a directory. The NULL is =
only=0A=
there because the array is using ZONEFS_ZTYPE_MAX. This can be simplified.=
=0A=
=0A=
> =0A=
>> +=0A=
>> +/*=0A=
>> + * Create a zone group and populate it with zone files.=0A=
>> + */=0A=
>> +static int zonefs_create_zgroup(struct super_block *sb, struct blk_zone=
 *zones,=0A=
>> +				enum zonefs_ztype type)=0A=
>> +{=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct blk_zone *zone, *next, *end;=0A=
>> +	char name[ZONEFS_NAME_MAX];=0A=
>> +	unsigned int nr_files =3D 0;=0A=
>> +	struct dentry *dir;=0A=
>> +=0A=
>> +	/* If the group is empty, nothing to do */=0A=
>> +	if (!sbi->s_nr_zones[type])=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	dir =3D zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);=0A=
>> +	if (!dir)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Note: The first zone contains the super block: skip it.=0A=
>> +	 */=0A=
>> +	end =3D zones + sbi->s_nr_zones[ZONEFS_ZTYPE_ALL];=0A=
>> +	for (zone =3D &zones[1]; zone < end; zone =3D next) {=0A=
>> +=0A=
>> +		next =3D zone + 1;=0A=
>> +		if (zonefs_zone_type(zone) !=3D type)=0A=
>> +			continue;=0A=
>> +=0A=
>> +		/* Ignore offline zones */=0A=
>> +		if (zonefs_zone_offline(zone))=0A=
>> +			continue;=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * For conventional zones, contiguous zones can be aggregated=0A=
>> +		 * together to form larger files.=0A=
>> +		 * Note that this overwrites the length of the first zone of=0A=
>> +		 * the set of contiguous zones aggregated together.=0A=
>> +		 * Only zones with the same condition can be agreggated so that=0A=
>> +		 * offline zones are excluded and readonly zones are aggregated=0A=
>> +		 * together into a read only file.=0A=
>> +		 */=0A=
>> +		if (type =3D=3D ZONEFS_ZTYPE_CNV &&=0A=
>> +		    zonefs_has_feature(sbi, ZONEFS_F_AGRCNV)) {=0A=
>> +			for (; next < end; next++) {=0A=
>> +				if (zonefs_zone_type(next) !=3D type ||=0A=
>> +				    next->cond !=3D zone->cond)=0A=
>> +					break;=0A=
>> +				zone->len +=3D next->len;=0A=
>> +			}=0A=
>> +		}=0A=
>> +=0A=
>> +		if (zonefs_has_feature(sbi, ZONEFS_F_STARTSECT_NAME))=0A=
>> +			/* Use zone start sector as file names */=0A=
>> +			snprintf(name, ZONEFS_NAME_MAX - 1, "%llu",=0A=
>> +				 zone->start);=0A=
>> +		else=0A=
>> +			/* Use file number as file names */=0A=
>> +			snprintf(name, ZONEFS_NAME_MAX - 1, "%u", nr_files);=0A=
>> +		nr_files++;=0A=
>> +=0A=
>> +		if (!zonefs_create_inode(dir, name, zone))=0A=
>> +			return -ENOMEM;=0A=
> =0A=
> I guess this means partial setup due to failure needs to be torn=0A=
> down by the kill_super() code?=0A=
=0A=
Yes. And the call to d_genocide(sb->s_root) does that unless I missed somet=
hing.=0A=
=0A=
>> +static struct blk_zone *zonefs_get_zone_info(struct super_block *sb)=0A=
>> +{=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct block_device *bdev =3D sb->s_bdev;=0A=
>> +	sector_t nr_sectors =3D bdev->bd_part->nr_sects;=0A=
>> +	unsigned int i, n, nr_zones =3D 0;=0A=
>> +	struct blk_zone *zones, *zone;=0A=
>> +	sector_t sector =3D 0;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	sbi->s_blocksize_mask =3D sb->s_blocksize - 1;=0A=
>> +	sbi->s_nr_zones[ZONEFS_ZTYPE_ALL] =3D blkdev_nr_zones(bdev);=0A=
>> +	zones =3D kvcalloc(sbi->s_nr_zones[ZONEFS_ZTYPE_ALL],=0A=
>> +			 sizeof(struct blk_zone), GFP_KERNEL);=0A=
>> +	if (!zones)=0A=
>> +		return ERR_PTR(-ENOMEM);=0A=
> =0A=
> Hmmm. That's a big allocation. That might be several megabytes for a=0A=
> typical 16TB SMR drive, right? It might be worth adding a comment=0A=
> indicating just how large this is, because it's somewhat unusual in=0A=
> kernel space, even for temporary storage.=0A=
=0A=
Yes. A full zone report (64B per zone) will take to 4-5MB on a 15+ TB disk.=
 I=0A=
will comment this. Doing the big allocation to allow having all zones on ha=
nd=0A=
before creating the inodes makes the code easier. But this can be optimized=
 with=0A=
a partial report in a loop too. I will rewrite this code to avoid the big=
=0A=
temporary allocation.=0A=
=0A=
>> + * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and=
=0A=
>> + * BLK_ZONE_TYPE_SEQWRITE_PREF.=0A=
>> + */=0A=
>> +enum zonefs_ztype {=0A=
>> +	ZONEFS_ZTYPE_ALL =3D 0,=0A=
>> +	ZONEFS_ZTYPE_CNV,=0A=
>> +	ZONEFS_ZTYPE_SEQ,=0A=
>> +	ZONEFS_ZTYPE_MAX,=0A=
>> +};=0A=
> =0A=
> What is ZONEFS_ZTYPE_ALL supposed to be used for?=0A=
=0A=
It is defined only to allow thee declaration of sbi->s_nr_zones as an array=
 of=0A=
ZONEFS_ZTYPE_MAX unsigned int, so that we get 3 counters: total number of z=
ones=0A=
is always larger or equal to conv zones + seq zones. Initially, this made t=
he=0A=
code somewhat cleaner, but I realize now not really easier to understand :)=
=0A=
=0A=
I will remove it and make things more obvious.=0A=
=0A=
>> +static inline bool zonefs_zone_offline(struct blk_zone *zone)=0A=
>> +{=0A=
>> +	return zone->cond =3D=3D BLK_ZONE_COND_OFFLINE;=0A=
>> +}=0A=
>> +=0A=
>> +static inline bool zonefs_zone_readonly(struct blk_zone *zone)=0A=
>> +{=0A=
>> +	return zone->cond =3D=3D BLK_ZONE_COND_READONLY;=0A=
>> +}=0A=
> =0A=
> These should be block layer helpers as the operate on blk_zone,=0A=
> not zonefs structures.=0A=
=0A=
Yes. Will fix that.=0A=
=0A=
>> +/*=0A=
>> + * Address (byte offset) on disk of a file zone.=0A=
>> + */=0A=
>> +static inline loff_t zonefs_file_addr(struct inode *inode)=0A=
>> +{=0A=
>> +	return ZONEFS_I(inode)->i_addr;=0A=
>> +}=0A=
> =0A=
> so it's a disk address, but it's encoded in bytes rather than sectors=0A=
> so that makes it an offset. That's kinda confusing coming from a=0A=
> filesystem that makes a clear distinction between these two things.=0A=
=0A=
Yes. This simplifies a little the code, but it is not obvious. I will rewor=
k this.=0A=
=0A=
>> +=0A=
>> +/*=0A=
>> + * Maximum possible size of a file (i.e. the zone size).=0A=
>> + */=0A=
>> +static inline loff_t zonefs_file_max_size(struct inode *inode)=0A=
>> +{=0A=
>> +	return ZONEFS_I(inode)->i_max_size;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * On-disk super block (block 0).=0A=
>> + */=0A=
>> +struct zonefs_super {=0A=
>> +=0A=
>> +	/* Magic number */=0A=
>> +	__le32		s_magic;		/*    4 */=0A=
>> +=0A=
>> +	/* Metadata version number */=0A=
>> +	__le32		s_version;		/*    8 */=0A=
>> +=0A=
>> +	/* Features */=0A=
>> +	__le64		s_features;		/*   16 */=0A=
> =0A=
> On-disk version numbers are kinda redundant when you have=0A=
> fine grained feature fields to indicate the on-disk layout...=0A=
=0A=
Yes. I guess. I was kind of reserving the s_features field for optional thi=
ngs,=0A=
hence the version number for on-disk mandatory things. But I may as well us=
e it=0A=
for everything, both mandatory format features and options.=0A=
=0A=
>> +/*=0A=
>> + * Feature flags.=0A=
>> + */=0A=
>> +enum zonefs_features {=0A=
>> +	/*=0A=
>> +	 * Use a zone start sector value as file name.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_STARTSECT_NAME,=0A=
>> +	/*=0A=
>> +	 * Aggregate contiguous conventional zones into a single file.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_AGRCNV,=0A=
>> +	/*=0A=
>> +	 * Use super block specified UID for files instead of default.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_UID,=0A=
>> +	/*=0A=
>> +	 * Use super block specified GID for files instead of default.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_GID,=0A=
>> +	/*=0A=
>> +	 * Use super block specified file permissions instead of default 640.=
=0A=
>> +	 */=0A=
>> +	ZONEFS_F_PERM,=0A=
>> +};=0A=
> =0A=
> Are these the on-disk feature bit definitions, or just used in=0A=
> memory? Or both?=0A=
=0A=
These are used for both on-disk super block and in-memory sb info.=0A=
=0A=
Thank you very much for the detailed review. I will rework this and repost.=
=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
