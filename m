Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF851290AB
	for <lists+linux-fsdevel@lfdr.de>; Mon, 23 Dec 2019 02:33:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbfLWBdf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 22 Dec 2019 20:33:35 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:59519 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726393AbfLWBdf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 22 Dec 2019 20:33:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577064814; x=1608600814;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=p4xGMRKw9MtO9uzL7dby4H5SJhMVnpcm9BU6R8ohBYU=;
  b=f8wYJ6ym59LN1phHkwaPC0ipWqF6DHg8IVxwecrhcdMcmwcIbRqlcsQZ
   PuOUxFdDlF0ovvqTFK8MroeHW8YQfzcbH+GmNcjTQpHBS/nSxUy949cD4
   bGgCdsFX15DWKtikbLimbOTq/j73A060tjANyS5D0h/5rbOi5zQ2+r5UB
   hY/ph+itrWZH7F+llzOEj9R1htlPxVzceusjHS9ogK8FPANV5D3KPLY14
   tUJNgBVHIrgLXZ9gBxPBHtE/a3z4zYPWw2swo3r8di83QrYHs0/DTrmt0
   g4HEwNZV9FxGZW3kyNLcetoJm8VdV3f7oFoMFV69yVPkMWfaqUWg3dhhv
   A==;
IronPort-SDR: AAcAQ0eDHGcI6HfI9IrcCyxTxqiUIZwPB/Qsjb41/CdlPV2r3Re9Py9TZyRrfuQt9DnoYbFiLj
 1mqsDwgZYc9ptYJZuWIoFKSNi8Kl4I/kJDg51E+1m/6EX+16dWlpCBoSaQtF34gVe2Quj14tee
 R517KaLcLxaUWya8qJcbD6vQlwGYRvFdrtOijONxe2hpAKCZ267XNiGlf7b5NJAGsUmm/poKvo
 9deTAv3RS0dpT7QcpvxDDL/rlp3jsggb+Il5ns6WpMg83JTrqnxPt2Cz/eI8YGS3aj4nNzkoeu
 QI0=
X-IronPort-AV: E=Sophos;i="5.69,345,1571673600"; 
   d="scan'208";a="233582760"
Received: from mail-dm6nam12lp2177.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.177])
  by ob1.hgst.iphmx.com with ESMTP; 23 Dec 2019 09:33:32 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OtSRnm1O76K2u98Gb3E83rDxkstI9Cg+4VGD7FzBLKoNrr3txDk6dJFWBzgLkY0+Y9W6BInQHnTavmsVOq3PrGISirCKV8RnL8pyisI8//uMFTmrfSk8kceQPCqxgxqJ1DJJGCS5fsKz44UqyQP5afNxEtiXc4Kzq93oLuFXSCXntHRygGLbbDpB9rU9MNKqTsQYU7FjW/f4Qj1rDrGXJVJgF2f52S7jMz5iXHiqQ73vFxUojgx2p9ZLaEbNOUgTtOn9q3PpnhXnwoToXkToenpta3emsiOoxJKFIRbgf1yMMTL7itKt8XWELH+lNGS6BIOqAFgw+dJYil/Lv5j4qA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAtUNUOjJIKfv3EBommT8CIeLf2tO+ifKhn+dMwlRRs=;
 b=mVlcAWfsAn5BXtp1qeTRQE6VlN8dOBHND8rf3SsxZQkALgOzZWm1MN+3lI7K84RvEwcETThoghYGw/o6dy9BuFj9C1LTptElUokpyDwSzRrs6R0SajIcNltZrO3uj2708W4j8kFYiqvNMga7xeVn9GpPC7PO8OSuBgE4xoe7yKQhwSyWUP3brlz2hFNAnTlInes07mgT83LIjCOcieNgVDTWj4xBup8PBtsqKuMkOWkSBg14NRWEylqR0oXR8YtFlW40JqWHPEQjCUIWqRnYFnWyrBMdq7o18yib5HYKtW2oMVdZ+tuf9r+MyQQPe6IZFEjfD58Ri958AVUMLa//MA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NAtUNUOjJIKfv3EBommT8CIeLf2tO+ifKhn+dMwlRRs=;
 b=HQnpxKhaaTnKbZSA3waE3Z8Gx1IjcBwlWALiDEwa7pyzQTY7NSu300HfDtOPC6yEhCNeolUZ4jPxXdlApsN42FJ7y0rtr/HrXwHDCzEZjB/z9WIWreTs418LIm+pY0sDzz2H+9kQ9+qdoZOpSiZmF27Jh98P8fmX8xP3/KHO/vU=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3975.namprd04.prod.outlook.com (52.135.214.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.15; Mon, 23 Dec 2019 01:33:31 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2559.016; Mon, 23 Dec 2019
 01:33:31 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v2 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v2 1/2] fs: New zonefs file system
Thread-Index: AQHVtwKAJkM7crdOGk6pusveV6ToBA==
Date:   Mon, 23 Dec 2019 01:33:30 +0000
Message-ID: <BYAPR04MB581661F7C2103E8F35EEDAA0E72E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191220065528.317947-1-damien.lemoal@wdc.com>
 <20191220065528.317947-2-damien.lemoal@wdc.com>
 <20191220223624.GC7476@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1064c29d-81bf-4685-a42d-08d787481e2f
x-ms-traffictypediagnostic: BYAPR04MB3975:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB397587F7DF7776B71FA67B4FE72E0@BYAPR04MB3975.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2089;
x-forefront-prvs: 0260457E99
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(136003)(39860400002)(376002)(346002)(396003)(366004)(52314003)(54094003)(55674003)(189003)(199004)(4326008)(30864003)(5660300002)(71200400001)(7696005)(8676002)(66946007)(66556008)(66446008)(66476007)(76116006)(91956017)(81156014)(64756008)(81166006)(54906003)(478600001)(6506007)(9686003)(33656002)(53546011)(55016002)(86362001)(316002)(8936002)(2906002)(186003)(52536014)(6916009)(26005);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3975;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: U0sMOQoDSXsG/3uj/GuPx/UFHwFAC8Z2F3iK5VAYp76S92R/oRK7jfcihEn/FFi/pQEmh+KdwGg+szf5g1yBycNQPV7rh85HD9PaSfFr4DwhO1FP7ThcyJODcqkwU2mLsyFtq0o//nRHAwBcNfOYI4KDyeTaQJyaA32nLYedaWHJ88uICULASxSDl/x6o8PDDJHk7VvvmiAOh5ndouAvkrODM0yi++Co088nczKpOOthUNMENbfm6Kiy7oHvaSaTOp1YmSYfKf9p3LrH3ZltoqHFEflKWyyVh+HH5iBJ+2Gs8eXnAuFpE/csKwvl7e9mri24Zml4TT7dk2+xESwX+VIFOgHmcWJ5ujFpeYY1qBgEG6S55LiVy6bvBKm/U0fQ18N8Mp7E/AQL6h3SqyHXGWCI4WVAzCsw2obO9/aOMiLmtq6xpkNNfRnkztRpsT8UARXyes5FJm+CTLHPyLIcrNsxjFtB/waywpUD5A7IgECodivcL9PIBuoVGPamhhgoXEtdSFgYh4l1QjiVPkiySSyDDyk89LhfzJfXdiLgzZk=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1064c29d-81bf-4685-a42d-08d787481e2f
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Dec 2019 01:33:30.7569
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p41CT/NckRUWAqkUueb3r8GfasRey+kz6CtUh9lBGEMAXKCANMd55RXIFQFBRoVhD+LkkRAY0B6kybmJVQ+kDg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3975
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/21 7:38, Darrick J. Wong wrote:=0A=
> On Fri, Dec 20, 2019 at 03:55:27PM +0900, Damien Le Moal wrote:=0A=
[...]>> +static int zonefs_inode_setattr(struct dentry *dentry, struct=0A=
iattr *iattr)=0A=
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
>> +		if (ZONEFS_I(inode)->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)=0A=
>> +			return -EPERM;=0A=
>> +=0A=
>> +		ret =3D zonefs_seq_file_truncate(inode, iattr->ia_size);=0A=
>> +		if (ret)=0A=
>> +			return ret;=0A=
>> +	}=0A=
> =0A=
> /me wonders if you need to filter out ATTR_MODE changes here, at least=0A=
> so you can't make the zone file for a readonly zone writable?=0A=
=0A=
Good point. Will add that to V3.=0A=
=0A=
> I also wonder, does an O_TRUNC open reset the zone's write pointer to=0A=
> zero?=0A=
=0A=
Yes, it does. That does not change from a regular FS behavior. This is=0A=
also consistent with the fact that a truncate(0) does exactly the same=0A=
thing.=0A=
=0A=
[...]=0A=
>> +static const struct vm_operations_struct zonefs_file_vm_ops =3D {=0A=
>> +	.fault		=3D zonefs_filemap_fault,=0A=
>> +	.map_pages	=3D filemap_map_pages,=0A=
>> +	.page_mkwrite	=3D zonefs_filemap_page_mkwrite,=0A=
>> +};=0A=
>> +=0A=
>> +static int zonefs_file_mmap(struct file *file, struct vm_area_struct *v=
ma)=0A=
>> +{=0A=
>> +	/*=0A=
>> +	 * Conventional zone files can be mmap-ed READ/WRITE.=0A=
>> +	 * For sequential zone files, only readonly mappings are possible.=0A=
> =0A=
> Hmm, but the code below looks like it allows private writable mmapings=0A=
> of sequential zones?=0A=
=0A=
It is my understanding that changes made to pages of a MAP_PRIVATE=0A=
mapping are not written back to the underlying file, so a=0A=
mmap(MAP_WRITE|MAP_PRIVATE) is essentially equivalent to a read only=0A=
mapping for the FS. Am I missing something ?=0A=
=0A=
Not sure if it make any sense at all to allow private writeable mappings=0A=
though, but if my assumption is correct, I do not see any reason to=0A=
prevent them either.=0A=
=0A=
[...]=0A=
>> +static const struct iomap_dio_ops zonefs_dio_ops =3D {=0A=
>> +	.end_io			=3D zonefs_file_dio_write_end,=0A=
>> +};=0A=
>> +=0A=
>> +static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_ite=
r *from)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	size_t count;=0A=
>> +	ssize_t ret;=0A=
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
>> +=0A=
>> +	iov_iter_truncate(from, zi->i_max_size - iocb->ki_pos);=0A=
>> +	count =3D iov_iter_count(from);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Direct writes must be aligned to the block size, that is, the devic=
e=0A=
>> +	 * physical sector size, to avoid errors when writing sequential zones=
=0A=
>> +	 * on 512e devices (512B logical sector, 4KB physical sectors).=0A=
>> +	 */=0A=
>> +	if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Enforce sequential writes (append only) in sequential zones.=0A=
>> +	 */=0A=
> =0A=
> I wonder, shouldn't zonefs require users to open sequential zones with=0A=
> O_APPEND?  I don't see anything in here that would suggest that it does,=
=0A=
> though maybe I missed something.=0A=
=0A=
Yes, I thought about this too but decided against it for several reasons:=
=0A=
1) Requiring O_APPEND breaks some shell command like tools such as=0A=
"truncate" which makes scripting (including tests) harder.=0A=
2) Without enforcing O_APPEND, an application doing pwrite() or aios to=0A=
an incorrect offset will see an error instead of potential file data=0A=
corruption (due to the application bug, not the FS).=0A=
3) Since sequential zone file size is updated only on completion of=0A=
direct IOs, O_APPEND would generate an incorrect offset for AIOs at=0A=
queue depth bigger than 1.=0A=
=0A=
Thoughts ?=0A=
=0A=
[...]=0A=
>> +static ssize_t zonefs_file_write_iter(struct kiocb *iocb, struct iov_it=
er *from)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Check that the write operation does not go beyond the zone size.=0A=
>> +	 */=0A=
>> +	if (iocb->ki_pos >=3D ZONEFS_I(inode)->i_max_size)=0A=
>> +		return -EFBIG;=0A=
>> +=0A=
>> +	if (iocb->ki_flags & IOCB_DIRECT)=0A=
>> +		return zonefs_file_dio_write(iocb, from);=0A=
>> +=0A=
>> +	return zonefs_file_buffered_write(iocb, from);=0A=
>> +}=0A=
>> +=0A=
>> +static const struct file_operations zonefs_file_operations =3D {=0A=
>> +	.open		=3D generic_file_open,=0A=
> =0A=
> Hmm, ok, so there isn't any explicit O_APPEND requirement, even though=0A=
> it looks like the filesystem enforces one.=0A=
=0A=
Yes, in purpose. See above for the reasons.=0A=
=0A=
[...]=0A=
>> +static void zonefs_init_file_inode(struct inode *inode, struct blk_zone=
 *zone)=0A=
>> +{=0A=
>> +	struct super_block *sb =3D inode->i_sb;=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	umode_t	perm =3D sbi->s_perm;=0A=
>> +=0A=
>> +	zi->i_ztype =3D zonefs_zone_type(zone);=0A=
>> +	zi->i_zsector =3D zone->start;=0A=
>> +=0A=
>> +	switch (zone->cond) {=0A=
>> +	case BLK_ZONE_COND_OFFLINE:=0A=
>> +		/*=0A=
>> +		 * Disable all accesses and set the file size to 0 for=0A=
>> +		 * offline zones.=0A=
>> +		 */=0A=
>> +		zi->i_wpoffset =3D 0;=0A=
>> +		zi->i_max_size =3D 0;=0A=
>> +		perm =3D 0;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_COND_READONLY:=0A=
>> +		/* Do not allow writes in read-only zones*/=0A=
>> +		perm &=3D ~(0222); /* S_IWUGO */=0A=
>> +		/* Fallthrough */=0A=
> =0A=
> You might want to set S_IMMUTABLE in i_flags here, since (I assume)=0A=
> readonly zones are never, ever, going to be modifable in any way?=0A=
=0A=
Good point. Will do.=0A=
=0A=
> In which case, zonefs probably shouldn't let people run 'chmod a+w' on a=
=0A=
> readonly zone.  Either that or disallow mode changes via=0A=
> zonefs_inode_setattr.=0A=
=0A=
Yes, will do.=0A=
=0A=
[...]=0A=
>> +static int zonefs_create_zgroup(struct zonefs_zone_data *zd,=0A=
>> +				enum zonefs_ztype type)=0A=
>> +{=0A=
>> +	struct super_block *sb =3D zd->sb;=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct blk_zone *zone, *next, *end;=0A=
>> +	char name[ZONEFS_NAME_MAX];=0A=
>> +	struct dentry *dir;=0A=
>> +	unsigned int n =3D 0;=0A=
>> +=0A=
>> +	/* If the group is empty, there is nothing to do */=0A=
>> +	if (!zd->nr_zones[type])=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	dir =3D zonefs_create_inode(sb->s_root, zgroups_name[type], NULL);=0A=
>> +	if (!dir)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * The first zone contains the super block: skip it.=0A=
>> +	 */=0A=
>> +	end =3D zd->zones + blkdev_nr_zones(sb->s_bdev->bd_disk);=0A=
>> +	for (zone =3D &zd->zones[1]; zone < end; zone =3D next) {=0A=
>> +=0A=
>> +		next =3D zone + 1;=0A=
>> +		if (zonefs_zone_type(zone) !=3D type)=0A=
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
>> +		    sbi->s_features & ZONEFS_F_AGGRCNV) {=0A=
> =0A=
> This probably needs parentheses around the flag check, e.g.=0A=
> =0A=
> 		if (type =3D=3D ZONEFS_ZTYPE_CNV &&=0A=
> 		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {=0A=
=0A=
gcc does not complain but I agree. It is cleaner and older gcc versions=0A=
will also probably be happier :)=0A=
=0A=
[...]=0A=
>> +=0A=
>> +static int zonefs_get_zone_info(struct zonefs_zone_data *zd)=0A=
>> +{=0A=
>> +	struct block_device *bdev =3D zd->sb->s_bdev;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	zd->zones =3D kvcalloc(blkdev_nr_zones(bdev->bd_disk),=0A=
>> +			     sizeof(struct blk_zone), GFP_KERNEL);=0A=
> =0A=
> Hmm, so one 64-byte blk_zone structure for each zone on the disk?=0A=
> =0A=
> I have a 14TB SMR disk with ~459,000x 32M zones on it.  That's going to=
=0A=
> require a contiguous 30MB memory allocation to hold all the zone=0A=
> information.  Even your 15T drive from the commit message will need a=0A=
> contiguous 3.8MB memory allocation for all the zone info.=0A=
> =0A=
> I wonder if each zone should really be allocated separately and then=0A=
> indexed with an xarray or something like that to reduce the chance of=0A=
> failure when memory is fragmented or tight.=0A=
> =0A=
> That could be subsequent work though, since in the meantime that just=0A=
> makes zonefs mounts more likely to run out of memory and fail.  I=0A=
> suppose you don't hang on to the huge allocation for very long.=0A=
=0A=
No, this memory allocation is only for mount. It is dropped as soon as=0A=
all the zone file inodes are created. Furthermore, this allocation is a=0A=
kvalloc, not a kmalloc. So there is no memory continuity requirement.=0A=
This is only an array of structures and that is not used to do IOs for=0A=
the report zone itself.=0A=
=0A=
I debated trying to optimize (I mean reducing the mount temporary memory=0A=
use) by processing mount in small chunks of zones instead of all zones=0A=
in one go. I kept simple, but rather brutal, approach to keep the code=0A=
simple. This can be rewritten and optimized at any time if we see=0A=
problems appearing.=0A=
=0A=
> =0A=
>> +	if (!zd->zones)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	/* Get zones information */=0A=
>> +	ret =3D blkdev_report_zones(bdev, 0, BLK_ALL_ZONES,=0A=
>> +				  zonefs_get_zone_info_cb, zd);=0A=
>> +	if (ret < 0) {=0A=
>> +		zonefs_err(zd->sb, "Zone report failed %d\n", ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (ret !=3D blkdev_nr_zones(bdev->bd_disk)) {=0A=
>> +		zonefs_err(zd->sb, "Invalid zone report (%d/%u zones)\n",=0A=
>> +			   ret, blkdev_nr_zones(bdev->bd_disk));=0A=
>> +		return -EIO;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static inline void zonefs_cleanup_zone_info(struct zonefs_zone_data *zd=
)=0A=
>> +{=0A=
>> +	kvfree(zd->zones);=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Read super block information from the device.=0A=
>> + */=0A=
>> +static int zonefs_read_super(struct super_block *sb)=0A=
>> +{=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct zonefs_super *super;=0A=
>> +	u32 crc, stored_crc;=0A=
>> +	struct page *page;=0A=
>> +	struct bio_vec bio_vec;=0A=
>> +	struct bio bio;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	page =3D alloc_page(GFP_KERNEL);=0A=
>> +	if (!page)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	bio_init(&bio, &bio_vec, 1);=0A=
>> +	bio.bi_iter.bi_sector =3D 0;=0A=
>> +	bio_set_dev(&bio, sb->s_bdev);=0A=
>> +	bio_set_op_attrs(&bio, REQ_OP_READ, 0);=0A=
>> +	bio_add_page(&bio, page, PAGE_SIZE, 0);=0A=
>> +=0A=
>> +	ret =3D submit_bio_wait(&bio);=0A=
>> +	if (ret)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	super =3D page_address(page);=0A=
>> +=0A=
>> +	stored_crc =3D super->s_crc;=0A=
>> +	super->s_crc =3D 0;=0A=
>> +	crc =3D crc32_le(ZONEFS_MAGIC, (unsigned char *)super,=0A=
>> +		       sizeof(struct zonefs_super));=0A=
> =0A=
> Unusual; usually crc32 computations are seeded with ~0U, but <shrug>.=0A=
=0A=
No strong opinion on this one. I will change to ~0U to follow the=0A=
general convention.=0A=
=0A=
> Anyway, this looks to be in decent shape now, modulo other comments.=0A=
=0A=
Thank you for your comments. Sending a V3.=0A=
=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
