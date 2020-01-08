Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A693F1337D9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jan 2020 01:16:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726793AbgAHAQo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jan 2020 19:16:44 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:26911 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725601AbgAHAQo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jan 2020 19:16:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1578442602; x=1609978602;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=ZqsPxDsOdbcOjM1KisoLihWTCUnoNy9QhbJY27WXZhM=;
  b=RJC8XiON0rkZFi/1qFlKpugoME3fqt7JP6jNAGgxw0tTuoIy6yPag8YK
   QBuz8SCqGOY77Z8A/zlpelvze3/+nJcls0oWZ3sF5gGXvVu0zPB3nqhu0
   7xy6IGGvy2lAAHQQ+x7+UqdwO0MgODUvsA5PDGh3JXUZkxbeaiEg8JSej
   FdpJkW0ltmL2qMoJRsT5WMtBBfO5HDKSoCegTHZBX8nWaL95Lhf10O82j
   Oj2bBO0RR8vTHdod+2He8o+9HXkXLKSnf9UDhszUQNm4gVMeChDZ+4HSM
   RwzBNuOGvGS2T4KKElZjn+1a2dg3CEo6ikEsMFRBFciAKxD4c7S6ADTWI
   Q==;
IronPort-SDR: 8Xt1/vhHLczuGtVfCi4Kr1Ff4erGo6nk3DRfHKE7ed9LHUpkSNThiTpZK6kjXJ+fXyG+HiqMK1
 b7plEjldWCDewG51vg0L15yFNouHVksL4dwZTBoSXcYH+IX88wcRznhDrLiuJowJmGJ1Jixogc
 fOkMd2wQ4RhkFa0Kp4L38vY79WTL+XSmezktZqPQ1pJPmJVYzmJfOZcyHvcMQGiHd7/Az4VyZp
 MzSQplX4chIsmkX2YgL2O1GTmetOrr3FUeeT01KDZlYYIpQupzfaIaiQ6gZKZhqActNko129ib
 cDE=
X-IronPort-AV: E=Sophos;i="5.69,407,1571673600"; 
   d="scan'208";a="234697448"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 08 Jan 2020 08:16:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/gVYo4IKisojOWfQrzSKraINd/heUB+BhQGl6lNhpczEH7gGVQsSvHYXvm8IS4S6uwlI88PQcB0r8nu39HxjgHVXUbK7VxwhJXCY37/pFz0BcR4jwDyRLrV6Ft4u+gm2qIkFVrq2t3Cpee8qw6Wuqcc4y33rrknuO7ENY3och43CYhTw+stmZd+KtPuC433fpmZ7NJcS0HqTjK0h+g9bvOLpxGR7Hi1rhMgr9l5TZ8mkZY3N0Q0NWW3JhrKPU7h+fPTo4/yI8kAXfyC3yUQNfyYtfNPy3SbmxsZs54bGvWLs5fsztyGujYMw71OKL7llmWmilNpGW4r5fqgv/rrBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU/VsPFlARoBKz1OT7hVPyMSGhRkBdpZihainlSIJQQ=;
 b=EK+ZfMi1DNoNj2eDwKkXnoO7sK4QLbmvp4QDvvhWAYryThBhPTl4SfvOFjTdRA6nJKuxR+nqjV6RUEbuHigtYqW3RZZiJNWO/Rz7kQDIeJvWCLIZP3GLXAL122G7qMxZd77y5zh9cMkIspHCGOpL1SLXmY1ZabAiOj+nTOWZ3rbLz16w5Q3w56nazD5G5ttlwW0pZcA/3Esy1I5kIHunXmQ9G/gkxnLIPofII1OXgfhvZroqred/J001KUCrtWSP0cvNh6CsBOD9MAJ5Qd1WiT3UWK6TB+RbrOhqOPSBspBxFLfZds5tEVIoIezKtUBRWZY0c6NaVN10aVLYzpzcHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oU/VsPFlARoBKz1OT7hVPyMSGhRkBdpZihainlSIJQQ=;
 b=sw6CQ+LNJJTIxng+rf6bHYYPpD6JhsLa9ACjQilNe2mGBifpMjEzWwVRVfN7zSkU8AC070/ZjrTwkWmyLTFJRpDBfIOhrPEzHI+as+omTSkl+QqG7HpYn8HeYKuCvdbFu0OyVp9dmnj6XC7SicJnk8KkpM6DPHwqXKZ9MDJaO/w=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB5896.namprd04.prod.outlook.com (20.179.59.205) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2602.12; Wed, 8 Jan 2020 00:16:39 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2602.016; Wed, 8 Jan 2020
 00:16:39 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v5 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v5 1/2] fs: New zonefs file system
Thread-Index: AQHVwd5j/GcWNGK9iEiyyITZfos+Zg==
Date:   Wed, 8 Jan 2020 00:16:38 +0000
Message-ID: <BYAPR04MB5816CAEC6A4EDE969EF3EF21E73E0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200103023445.1352524-1-damien.lemoal@wdc.com>
 <20200103023445.1352524-2-damien.lemoal@wdc.com>
 <20200107231204.GE917713@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.5]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 5c3d2c21-f33a-44d1-d4bc-08d793d007d6
x-ms-traffictypediagnostic: BYAPR04MB5896:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB58966115AA97D2DB0BD1BBCFE73E0@BYAPR04MB5896.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:231;
x-forefront-prvs: 02760F0D1C
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(396003)(136003)(346002)(39860400002)(376002)(51914003)(189003)(199004)(81166006)(81156014)(64756008)(91956017)(66556008)(53546011)(7696005)(6506007)(66946007)(186003)(66476007)(8936002)(9686003)(4326008)(30864003)(76116006)(5660300002)(8676002)(478600001)(71200400001)(55016002)(52536014)(66446008)(86362001)(33656002)(2906002)(54906003)(26005)(316002)(6916009)(569006);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5896;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BXBIKqwYR0ZdOGTH+oWFudbTNKqWi3arPXhE4BJXTDeYdZLgDB63/R6lPxITc0sL/oVfigxgHHGfP8emfXrnzSYhGWGmSqgLJmfWw+ZufjNQKDcQO0GPPRpZjOUz4xK3XciJFqPX41CFCtsKpGYp83YSEjJET+tGSo0hm3meCLarYrjfetKBpqanHgnfrOdDDqnmlApLFwlaxzD5DzSyGWj9ZCLrfXEgshzmAs00hqno9HgA7NxyQ/0XCZCRFbfwyXBfVl5wLu81zXdU86RGOrx4HMT1CdDwo9wpoZHmvF59PMHha31ubQYiKt0OZBTpkhdI4/XwVnGpR/QcSRSmlOoeJiOR2aDdAE6Il3UHzT4yUcnfnbYBCp/pQRxFt2LrL5C+B99Aq/elBPgidJ2YI8wEsxUhhFI4oh3GtJfIERjGWCJHAE7usDEOct8c3ibv4ijKoQTwECjkIHTa3Ng0dcf/NREFGvq/yLnZS/DrRNh1lDKbRavIH9Uwtxs7zKhyr2I09J96/NUuPSDFKAHjPA==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c3d2c21-f33a-44d1-d4bc-08d793d007d6
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2020 00:16:38.8116
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zIFfiAzuXzB4SFETKesLv5nALMWCTizSPzmFJJCM1/pUBi/cZa5tjSmxNNsQM1BgXg8gRhlf9VDo9DVsS1/kwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5896
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/08 8:12, Darrick J. Wong wrote:=0A=
> On Fri, Jan 03, 2020 at 11:34:44AM +0900, Damien Le Moal wrote:=0A=
>> zonefs is a very simple file system exposing each zone of a zoned block=
=0A=
>> device as a file. Unlike a regular file system with zoned block device=
=0A=
>> support (e.g. f2fs), zonefs does not hide the sequential write=0A=
>> constraint of zoned block devices to the user. Files representing=0A=
>> sequential write zones of the device must be written sequentially=0A=
>> starting from the end of the file (append only writes).=0A=
> =0A=
> <snip>=0A=
> =0A=
>> +static int zonefs_file_mmap(struct file *file, struct vm_area_struct *v=
ma)=0A=
>> +{=0A=
>> +	/*=0A=
>> +	 * Conventional zone files can be mmap-ed READ/WRITE.=0A=
>> +	 * For sequential zone files, only readonly mappings are possible.=0A=
> =0A=
> "Shared writable mappings are only possible on conventional zones"?=0A=
=0A=
Yes, correct. Since conventional zones/files accept random writes, the=0A=
page cache writeback/msync() can go crazy on the order of writes.=0A=
I will improve the comment in the code to clarify that.=0A=
=0A=
> Otherwise, this looks fine to me.=0A=
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>=0A=
=0A=
Thanks.=0A=
=0A=
> One more suggestion: Have you considered making it easier to identify a=
=0A=
> zonefs filesystem by stamping a UUID and/or label into the superblock?=0A=
> At some point you might want to send a patch to libblkid to detect=0A=
> zonefs so that users can do things like:=0A=
> =0A=
> # mount LABEL=3Dmy_first_smr_drive /mnt=0A=
=0A=
There already is an uuid in the super block (s_uuid field). I can=0A=
certainly add a label too. Since I need to send a V6 to address Johannes=0A=
comments on the documentation, I will do that.=0A=
=0A=
Thanks for the review.=0A=
=0A=
> =0A=
> --D=0A=
> =0A=
>> +	 */=0A=
>> +	if (ZONEFS_I(file_inode(file))->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>> +	    (vma->vm_flags & VM_SHARED) && (vma->vm_flags & VM_MAYWRITE))=0A=
>> +		return -EINVAL;=0A=
>> +=0A=
>> +	file_accessed(file);=0A=
>> +	vma->vm_ops =3D &zonefs_file_vm_ops;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static loff_t zonefs_file_llseek(struct file *file, loff_t offset, int =
whence)=0A=
>> +{=0A=
>> +	loff_t isize =3D i_size_read(file_inode(file));=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Seeks are limited to below the zone size for conventional zones=0A=
>> +	 * and below the zone write pointer for sequential zones. In both=0A=
>> +	 * cases, this limit is the inode size.=0A=
>> +	 */=0A=
>> +	return generic_file_llseek_size(file, offset, whence, isize, isize);=
=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t zonefs_file_read_iter(struct kiocb *iocb, struct iov_ite=
r *to)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(inode->i_sb);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	loff_t max_pos;=0A=
>> +	size_t count;=0A=
>> +	ssize_t ret;=0A=
>> +=0A=
>> +	if (iocb->ki_pos >=3D zi->i_max_size)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	if (iocb->ki_flags & IOCB_NOWAIT) {=0A=
>> +		if (!inode_trylock_shared(inode))=0A=
>> +			return -EAGAIN;=0A=
>> +	} else {=0A=
>> +		inode_lock_shared(inode);=0A=
>> +	}=0A=
>> +=0A=
>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Limit read operations to written data.=0A=
>> +	 */=0A=
>> +	max_pos =3D i_size_read(inode);=0A=
>> +	if (iocb->ki_pos >=3D max_pos) {=0A=
>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +		ret =3D 0;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	iov_iter_truncate(to, max_pos - iocb->ki_pos);=0A=
>> +=0A=
>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	count =3D iov_iter_count(to);=0A=
>> +=0A=
>> +	if (iocb->ki_flags & IOCB_DIRECT) {=0A=
>> +		if ((iocb->ki_pos | count) & sbi->s_blocksize_mask) {=0A=
>> +			ret =3D -EINVAL;=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +		file_accessed(iocb->ki_filp);=0A=
>> +		ret =3D iomap_dio_rw(iocb, to, &zonefs_iomap_ops, NULL,=0A=
>> +				   is_sync_kiocb(iocb));=0A=
>> +	} else {=0A=
>> +		ret =3D generic_file_read_iter(iocb, to);=0A=
>> +	}=0A=
>> +=0A=
>> +out:=0A=
>> +	inode_unlock_shared(inode);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static int zonefs_report_zones_err_cb(struct blk_zone *zone, unsigned i=
nt idx,=0A=
>> +				      void *data)=0A=
>> +{=0A=
>> +	struct inode *inode =3D data;=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	loff_t pos;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * The condition of the zone may have change. Check it and adjust the=
=0A=
>> +	 * inode information as needed, similarly to zonefs_init_file_inode().=
=0A=
>> +	 */=0A=
>> +	if (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE) {=0A=
>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>> +		inode->i_mode &=3D ~0777;=0A=
>> +		zone->wp =3D zone->start;=0A=
>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY) {=0A=
>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>> +		inode->i_mode &=3D ~0222;=0A=
>> +	}=0A=
>> +=0A=
>> +	pos =3D (zone->wp - zone->start) << SECTOR_SHIFT;=0A=
>> +	zi->i_wpoffset =3D pos;=0A=
>> +	if (i_size_read(inode) !=3D pos) {=0A=
>> +		zonefs_update_stats(inode, pos);=0A=
>> +		i_size_write(inode, pos);=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * When a write error occurs in a sequential zone, the zone write point=
er=0A=
>> + * position must be refreshed to correct the file size and zonefs inode=
=0A=
>> + * write pointer offset.=0A=
>> + */=0A=
>> +static int zonefs_seq_file_write_failed(struct inode *inode, int error)=
=0A=
>> +{=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	struct super_block *sb =3D inode->i_sb;=0A=
>> +	sector_t sector =3D zi->i_zsector;=0A=
>> +	unsigned int nofs_flag;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	zonefs_warn(sb, "Updating inode zone %llu info\n", sector);=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * blkdev_report_zones() uses GFP_KERNEL by default. Force execution a=
s=0A=
>> +	 * if GFP_NOFS was specified so that it will not end up recursing into=
=0A=
>> +	 * the FS on memory allocation.=0A=
>> +	 */=0A=
>> +	nofs_flag =3D memalloc_nofs_save();=0A=
>> +	ret =3D blkdev_report_zones(sb->s_bdev, sector, 1,=0A=
>> +				  zonefs_report_zones_err_cb, inode);=0A=
>> +	memalloc_nofs_restore(nofs_flag);=0A=
>> +=0A=
>> +	if (ret !=3D 1) {=0A=
>> +		if (!ret)=0A=
>> +			ret =3D -EIO;=0A=
>> +		zonefs_err(sb, "Get zone %llu report failed %d\n",=0A=
>> +			   sector, ret);=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int zonefs_file_dio_write_end(struct kiocb *iocb, ssize_t size, =
int ret,=0A=
>> +				     unsigned int flags)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Conventional zone file size is fixed to the zone size so there=0A=
>> +	 * is no need to do anything.=0A=
>> +	 */=0A=
>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)=0A=
>> +		return 0;=0A=
>> +=0A=
>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	if (size < 0) {=0A=
>> +		ret =3D zonefs_seq_file_write_failed(inode, size);=0A=
>> +	} else if (i_size_read(inode) < iocb->ki_pos + size) {=0A=
>> +		zonefs_update_stats(inode, iocb->ki_pos + size);=0A=
>> +		i_size_write(inode, iocb->ki_pos + size);=0A=
>> +	}=0A=
>> +=0A=
>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
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
>> +	mutex_lock(&zi->i_truncate_mutex);=0A=
>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>> +	    iocb->ki_pos !=3D zi->i_wpoffset) {=0A=
>> +		zonefs_err(inode->i_sb,=0A=
>> +			   "Unaligned write at %llu + %zu (wp %llu)\n",=0A=
>> +			   iocb->ki_pos, count,=0A=
>> +			   zi->i_wpoffset);=0A=
>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +		ret =3D -EINVAL;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +	mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +=0A=
>> +	ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops, &zonefs_dio_ops,=
=0A=
>> +			   is_sync_kiocb(iocb));=0A=
>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ &&=0A=
>> +	    (ret > 0 || ret =3D=3D -EIOCBQUEUED)) {=0A=
>> +		if (ret > 0)=0A=
>> +			count =3D ret;=0A=
>> +		mutex_lock(&zi->i_truncate_mutex);=0A=
>> +		zi->i_wpoffset +=3D count;=0A=
>> +		mutex_unlock(&zi->i_truncate_mutex);=0A=
>> +	}=0A=
>> +=0A=
>> +out:=0A=
>> +	inode_unlock(inode);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static ssize_t zonefs_file_buffered_write(struct kiocb *iocb,=0A=
>> +					  struct iov_iter *from)=0A=
>> +{=0A=
>> +	struct inode *inode =3D file_inode(iocb->ki_filp);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	size_t count;=0A=
>> +	ssize_t ret;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Direct IO writes are mandatory for sequential zones so that the=0A=
>> +	 * write IO order is preserved.=0A=
>> +	 */=0A=
>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_SEQ)=0A=
>> +		return -EIO;=0A=
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
>> +	ret =3D iomap_file_buffered_write(iocb, from, &zonefs_iomap_ops);=0A=
>> +	if (ret > 0)=0A=
>> +		iocb->ki_pos +=3D ret;=0A=
>> +=0A=
>> +out:=0A=
>> +	inode_unlock(inode);=0A=
>> +	if (ret > 0)=0A=
>> +		ret =3D generic_write_sync(iocb, ret);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
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
>> +	.fsync		=3D zonefs_file_fsync,=0A=
>> +	.mmap		=3D zonefs_file_mmap,=0A=
>> +	.llseek		=3D zonefs_file_llseek,=0A=
>> +	.read_iter	=3D zonefs_file_read_iter,=0A=
>> +	.write_iter	=3D zonefs_file_write_iter,=0A=
>> +	.splice_read	=3D generic_file_splice_read,=0A=
>> +	.splice_write	=3D iter_file_splice_write,=0A=
>> +	.iopoll		=3D iomap_dio_iopoll,=0A=
>> +};=0A=
>> +=0A=
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
>> +	inode_init_once(&zi->i_vnode);=0A=
>> +	mutex_init(&zi->i_truncate_mutex);=0A=
>> +	init_rwsem(&zi->i_mmap_sem);=0A=
>> +=0A=
>> +	return &zi->i_vnode;=0A=
>> +}=0A=
>> +=0A=
>> +static void zonefs_free_inode(struct inode *inode)=0A=
>> +{=0A=
>> +	kmem_cache_free(zonefs_inode_cachep, ZONEFS_I(inode));=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * File system stat.=0A=
>> + */=0A=
>> +static int zonefs_statfs(struct dentry *dentry, struct kstatfs *buf)=0A=
>> +{=0A=
>> +	struct super_block *sb =3D dentry->d_sb;=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	enum zonefs_ztype t;=0A=
>> +	u64 fsid;=0A=
>> +=0A=
>> +	buf->f_type =3D ZONEFS_MAGIC;=0A=
>> +	buf->f_bsize =3D sb->s_blocksize;=0A=
>> +	buf->f_namelen =3D ZONEFS_NAME_MAX;=0A=
>> +=0A=
>> +	spin_lock(&sbi->s_lock);=0A=
>> +=0A=
>> +	buf->f_blocks =3D sbi->s_blocks;=0A=
>> +	if (WARN_ON(sbi->s_used_blocks > sbi->s_blocks))=0A=
>> +		buf->f_bfree =3D 0;=0A=
>> +	else=0A=
>> +		buf->f_bfree =3D buf->f_blocks - sbi->s_used_blocks;=0A=
>> +	buf->f_bavail =3D buf->f_bfree;=0A=
>> +=0A=
>> +	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {=0A=
>> +		if (sbi->s_nr_files[t])=0A=
>> +			buf->f_files +=3D sbi->s_nr_files[t] + 1;=0A=
>> +	}=0A=
>> +	buf->f_ffree =3D 0;=0A=
>> +=0A=
>> +	spin_unlock(&sbi->s_lock);=0A=
>> +=0A=
>> +	fsid =3D le64_to_cpup((void *)sbi->s_uuid.b) ^=0A=
>> +		le64_to_cpup((void *)sbi->s_uuid.b + sizeof(u64));=0A=
>> +	buf->f_fsid.val[0] =3D (u32)fsid;=0A=
>> +	buf->f_fsid.val[1] =3D (u32)(fsid >> 32);=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static const struct super_operations zonefs_sops =3D {=0A=
>> +	.alloc_inode	=3D zonefs_alloc_inode,=0A=
>> +	.free_inode	=3D zonefs_free_inode,=0A=
>> +	.statfs		=3D zonefs_statfs,=0A=
>> +};=0A=
>> +=0A=
>> +static const struct inode_operations zonefs_dir_inode_operations =3D {=
=0A=
>> +	.lookup		=3D simple_lookup,=0A=
>> +	.setattr	=3D zonefs_inode_setattr,=0A=
>> +};=0A=
>> +=0A=
>> +static void zonefs_init_dir_inode(struct inode *parent, struct inode *i=
node)=0A=
>> +{=0A=
>> +	inode_init_owner(inode, parent, S_IFDIR | 0555);=0A=
>> +	inode->i_op =3D &zonefs_dir_inode_operations;=0A=
>> +	inode->i_fop =3D &simple_dir_operations;=0A=
>> +	set_nlink(inode, 2);=0A=
>> +	inc_nlink(parent);=0A=
>> +}=0A=
>> +=0A=
>> +static void zonefs_init_file_inode(struct inode *inode, struct blk_zone=
 *zone)=0A=
>> +{=0A=
>> +	struct super_block *sb =3D inode->i_sb;=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +	struct zonefs_inode_info *zi =3D ZONEFS_I(inode);=0A=
>> +	umode_t	perm =3D sbi->s_perm;=0A=
>> +=0A=
>> +	if (zone->cond =3D=3D BLK_ZONE_COND_OFFLINE) {=0A=
>> +		/*=0A=
>> +		 * Dead zone: make the inode immutable, disable all accesses=0A=
>> +		 * and set the file size to 0.=0A=
>> +		 */=0A=
>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>> +		zone->wp =3D zone->start;=0A=
>> +		perm &=3D ~0777;=0A=
>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY) {=0A=
>> +		/* Do not allow writes in read-only zones */=0A=
>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>> +		perm &=3D ~0222;=0A=
>> +	}=0A=
>> +=0A=
>> +	zi->i_ztype =3D zonefs_zone_type(zone);=0A=
>> +	zi->i_zsector =3D zone->start;=0A=
>> +	zi->i_max_size =3D min_t(loff_t, MAX_LFS_FILESIZE,=0A=
>> +			       zone->len << SECTOR_SHIFT);=0A=
>> +	if (zi->i_ztype =3D=3D ZONEFS_ZTYPE_CNV)=0A=
>> +		zi->i_wpoffset =3D zi->i_max_size;=0A=
>> +	else=0A=
>> +		zi->i_wpoffset =3D (zone->wp - zone->start) << SECTOR_SHIFT;=0A=
>> +=0A=
>> +	inode->i_mode =3D S_IFREG | perm;=0A=
>> +	inode->i_uid =3D sbi->s_uid;=0A=
>> +	inode->i_gid =3D sbi->s_gid;=0A=
>> +	inode->i_size =3D zi->i_wpoffset;=0A=
>> +	inode->i_blocks =3D zone->len;=0A=
>> +=0A=
>> +	inode->i_op =3D &zonefs_file_inode_operations;=0A=
>> +	inode->i_fop =3D &zonefs_file_operations;=0A=
>> +	inode->i_mapping->a_ops =3D &zonefs_file_aops;=0A=
>> +=0A=
>> +	sb->s_maxbytes =3D max(zi->i_max_size, sb->s_maxbytes);=0A=
>> +	sbi->s_blocks +=3D zi->i_max_size >> sb->s_blocksize_bits;=0A=
>> +	sbi->s_used_blocks +=3D zi->i_wpoffset >> sb->s_blocksize_bits;=0A=
>> +}=0A=
>> +=0A=
>> +static struct dentry *zonefs_create_inode(struct dentry *parent,=0A=
>> +					const char *name, struct blk_zone *zone)=0A=
>> +{=0A=
>> +	struct inode *dir =3D d_inode(parent);=0A=
>> +	struct dentry *dentry;=0A=
>> +	struct inode *inode;=0A=
>> +=0A=
>> +	dentry =3D d_alloc_name(parent, name);=0A=
>> +	if (!dentry)=0A=
>> +		return NULL;=0A=
>> +=0A=
>> +	inode =3D new_inode(parent->d_sb);=0A=
>> +	if (!inode)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	inode->i_ino =3D get_next_ino();=0A=
>> +	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D dir->i_ctime;=
=0A=
>> +	if (zone)=0A=
>> +		zonefs_init_file_inode(inode, zone);=0A=
>> +	else=0A=
>> +		zonefs_init_dir_inode(dir, inode);=0A=
>> +	d_add(dentry, inode);=0A=
>> +	dir->i_size++;=0A=
>> +=0A=
>> +	return dentry;=0A=
>> +=0A=
>> +out:=0A=
>> +	dput(dentry);=0A=
>> +=0A=
>> +	return NULL;=0A=
>> +}=0A=
>> +=0A=
>> +static char *zgroups_name[ZONEFS_ZTYPE_MAX] =3D { "cnv", "seq" };=0A=
>> +=0A=
>> +struct zonefs_zone_data {=0A=
>> +	struct super_block *sb;=0A=
>> +	unsigned int nr_zones[ZONEFS_ZTYPE_MAX];=0A=
>> +	struct blk_zone *zones;=0A=
>> +};=0A=
>> +=0A=
>> +/*=0A=
>> + * Create a zone group and populate it with zone files.=0A=
>> + */=0A=
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
>> +		    (sbi->s_features & ZONEFS_F_AGGRCNV)) {=0A=
>> +			for (; next < end; next++) {=0A=
>> +				if (zonefs_zone_type(next) !=3D type ||=0A=
>> +				    next->cond !=3D zone->cond)=0A=
>> +					break;=0A=
>> +				zone->len +=3D next->len;=0A=
>> +			}=0A=
>> +		}=0A=
>> +=0A=
>> +		/*=0A=
>> +		 * Use the file number within its group as file name.=0A=
>> +		 */=0A=
>> +		snprintf(name, ZONEFS_NAME_MAX - 1, "%u", n);=0A=
>> +		if (!zonefs_create_inode(dir, name, zone))=0A=
>> +			return -ENOMEM;=0A=
>> +=0A=
>> +		n++;=0A=
>> +	}=0A=
>> +=0A=
>> +	zonefs_info(sb, "Zone group \"%s\" has %u file%s\n",=0A=
>> +		    zgroups_name[type], n, n > 1 ? "s" : "");=0A=
>> +=0A=
>> +	sbi->s_nr_files[type] =3D n;=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int zonefs_get_zone_info_cb(struct blk_zone *zone, unsigned int =
idx,=0A=
>> +				   void *data)=0A=
>> +{=0A=
>> +	struct zonefs_zone_data *zd =3D data;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Count the number of usable zones: the first zone at index 0 contain=
s=0A=
>> +	 * the super block and is ignored.=0A=
>> +	 */=0A=
>> +	switch (zone->type) {=0A=
>> +	case BLK_ZONE_TYPE_CONVENTIONAL:=0A=
>> +		zone->wp =3D zone->start + zone->len;=0A=
>> +		if (idx)=0A=
>> +			zd->nr_zones[ZONEFS_ZTYPE_CNV]++;=0A=
>> +		break;=0A=
>> +	case BLK_ZONE_TYPE_SEQWRITE_REQ:=0A=
>> +	case BLK_ZONE_TYPE_SEQWRITE_PREF:=0A=
>> +		if (idx)=0A=
>> +			zd->nr_zones[ZONEFS_ZTYPE_SEQ]++;=0A=
>> +		break;=0A=
>> +	default:=0A=
>> +		zonefs_err(zd->sb, "Unsupported zone type 0x%x\n",=0A=
>> +			   zone->type);=0A=
>> +		return -EIO;=0A=
>> +	}=0A=
>> +=0A=
>> +	memcpy(&zd->zones[idx], zone, sizeof(struct blk_zone));=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static int zonefs_get_zone_info(struct zonefs_zone_data *zd)=0A=
>> +{=0A=
>> +	struct block_device *bdev =3D zd->sb->s_bdev;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	zd->zones =3D kvcalloc(blkdev_nr_zones(bdev->bd_disk),=0A=
>> +			     sizeof(struct blk_zone), GFP_KERNEL);=0A=
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
>> +	stored_crc =3D le32_to_cpu(super->s_crc);=0A=
>> +	super->s_crc =3D 0;=0A=
>> +	crc =3D crc32(~0U, (unsigned char *)super, sizeof(struct zonefs_super)=
);=0A=
>> +	if (crc !=3D stored_crc) {=0A=
>> +		zonefs_err(sb, "Invalid checksum (Expected 0x%08x, got 0x%08x)",=0A=
>> +			   crc, stored_crc);=0A=
>> +		ret =3D -EIO;=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	ret =3D -EINVAL;=0A=
>> +	if (le32_to_cpu(super->s_magic) !=3D ZONEFS_MAGIC)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	sbi->s_features =3D le64_to_cpu(super->s_features);=0A=
>> +	if (sbi->s_features & ~ZONEFS_F_DEFINED_FEATURES) {=0A=
>> +		zonefs_err(sb, "Unknown features set 0x%llx\n",=0A=
>> +			   sbi->s_features);=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	if (sbi->s_features & ZONEFS_F_UID) {=0A=
>> +		sbi->s_uid =3D make_kuid(current_user_ns(),=0A=
>> +				       le32_to_cpu(super->s_uid));=0A=
>> +		if (!uid_valid(sbi->s_uid)) {=0A=
>> +			zonefs_err(sb, "Invalid UID feature\n");=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	if (sbi->s_features & ZONEFS_F_GID) {=0A=
>> +		sbi->s_gid =3D make_kgid(current_user_ns(),=0A=
>> +				       le32_to_cpu(super->s_gid));=0A=
>> +		if (!gid_valid(sbi->s_gid)) {=0A=
>> +			zonefs_err(sb, "Invalid GID feature\n");=0A=
>> +			goto out;=0A=
>> +		}=0A=
>> +	}=0A=
>> +=0A=
>> +	if (sbi->s_features & ZONEFS_F_PERM)=0A=
>> +		sbi->s_perm =3D le32_to_cpu(super->s_perm);=0A=
>> +=0A=
>> +	if (memchr_inv(super->s_reserved, 0, sizeof(super->s_reserved))) {=0A=
>> +		zonefs_err(sb, "Reserved area is being used\n");=0A=
>> +		goto out;=0A=
>> +	}=0A=
>> +=0A=
>> +	uuid_copy(&sbi->s_uuid, &super->s_uuid);=0A=
>> +	ret =3D 0;=0A=
>> +=0A=
>> +out:=0A=
>> +	__free_page(page);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * Check that the device is zoned. If it is, get the list of zones and =
create=0A=
>> + * sub-directories and files according to the device zone configuration=
 and=0A=
>> + * format options.=0A=
>> + */=0A=
>> +static int zonefs_fill_super(struct super_block *sb, void *data, int si=
lent)=0A=
>> +{=0A=
>> +	struct zonefs_zone_data zd;=0A=
>> +	struct zonefs_sb_info *sbi;=0A=
>> +	struct inode *inode;=0A=
>> +	enum zonefs_ztype t;=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	if (!bdev_is_zoned(sb->s_bdev)) {=0A=
>> +		zonefs_err(sb, "Not a zoned block device\n");=0A=
>> +		return -EINVAL;=0A=
>> +	}=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Initialize super block information: the maximum file size is update=
d=0A=
>> +	 * when the zone files are created so that the format option=0A=
>> +	 * ZONEFS_F_AGGRCNV which increases the maximum file size of a file=0A=
>> +	 * beyond the zone size is taken into account.=0A=
>> +	 */=0A=
>> +	sbi =3D kzalloc(sizeof(*sbi), GFP_KERNEL);=0A=
>> +	if (!sbi)=0A=
>> +		return -ENOMEM;=0A=
>> +=0A=
>> +	spin_lock_init(&sbi->s_lock);=0A=
>> +	sb->s_fs_info =3D sbi;=0A=
>> +	sb->s_magic =3D ZONEFS_MAGIC;=0A=
>> +	sb->s_maxbytes =3D 0;=0A=
>> +	sb->s_op =3D &zonefs_sops;=0A=
>> +	sb->s_time_gran	=3D 1;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * The block size is always equal to the device physical sector size t=
o=0A=
>> +	 * ensure that writes on 512e devices (512B logical block and 4KB=0A=
>> +	 * physical block) are always aligned to the device physical blocks=0A=
>> +	 * (as required for writes to sequential zones on ZBC/ZAC disks).=0A=
>> +	 */=0A=
>> +	sb_set_blocksize(sb, bdev_physical_block_size(sb->s_bdev));=0A=
>> +	sbi->s_blocksize_mask =3D sb->s_blocksize - 1;=0A=
>> +	sbi->s_uid =3D GLOBAL_ROOT_UID;=0A=
>> +	sbi->s_gid =3D GLOBAL_ROOT_GID;=0A=
>> +	sbi->s_perm =3D 0640;=0A=
>> +=0A=
>> +	ret =3D zonefs_read_super(sb);=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	memset(&zd, 0, sizeof(struct zonefs_zone_data));=0A=
>> +	zd.sb =3D sb;=0A=
>> +	ret =3D zonefs_get_zone_info(&zd);=0A=
>> +	if (ret)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	zonefs_info(sb, "Mounting %u zones",=0A=
>> +		    blkdev_nr_zones(sb->s_bdev->bd_disk));=0A=
>> +=0A=
>> +	/* Create root directory inode */=0A=
>> +	ret =3D -ENOMEM;=0A=
>> +	inode =3D new_inode(sb);=0A=
>> +	if (!inode)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	inode->i_ino =3D get_next_ino();=0A=
>> +	inode->i_mode =3D S_IFDIR | 0555;=0A=
>> +	inode->i_ctime =3D inode->i_mtime =3D inode->i_atime =3D current_time(=
inode);=0A=
>> +	inode->i_op =3D &zonefs_dir_inode_operations;=0A=
>> +	inode->i_fop =3D &simple_dir_operations;=0A=
>> +	set_nlink(inode, 2);=0A=
>> +=0A=
>> +	sb->s_root =3D d_make_root(inode);=0A=
>> +	if (!sb->s_root)=0A=
>> +		goto out;=0A=
>> +=0A=
>> +	/* Create and populate files in zone groups directories */=0A=
>> +	for (t =3D 0; t < ZONEFS_ZTYPE_MAX; t++) {=0A=
>> +		ret =3D zonefs_create_zgroup(&zd, t);=0A=
>> +		if (ret)=0A=
>> +			break;=0A=
>> +	}=0A=
>> +=0A=
>> +out:=0A=
>> +	zonefs_cleanup_zone_info(&zd);=0A=
>> +=0A=
>> +	return ret;=0A=
>> +}=0A=
>> +=0A=
>> +static struct dentry *zonefs_mount(struct file_system_type *fs_type,=0A=
>> +				   int flags, const char *dev_name, void *data)=0A=
>> +{=0A=
>> +	return mount_bdev(fs_type, flags, dev_name, data, zonefs_fill_super);=
=0A=
>> +}=0A=
>> +=0A=
>> +static void zonefs_kill_super(struct super_block *sb)=0A=
>> +{=0A=
>> +	struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +=0A=
>> +	kfree(sbi);=0A=
>> +	if (sb->s_root)=0A=
>> +		d_genocide(sb->s_root);=0A=
>> +	kill_block_super(sb);=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * File system definition and registration.=0A=
>> + */=0A=
>> +static struct file_system_type zonefs_type =3D {=0A=
>> +	.owner		=3D THIS_MODULE,=0A=
>> +	.name		=3D "zonefs",=0A=
>> +	.mount		=3D zonefs_mount,=0A=
>> +	.kill_sb	=3D zonefs_kill_super,=0A=
>> +	.fs_flags	=3D FS_REQUIRES_DEV,=0A=
>> +};=0A=
>> +=0A=
>> +static int __init zonefs_init_inodecache(void)=0A=
>> +{=0A=
>> +	zonefs_inode_cachep =3D kmem_cache_create("zonefs_inode_cache",=0A=
>> +			sizeof(struct zonefs_inode_info), 0,=0A=
>> +			(SLAB_RECLAIM_ACCOUNT | SLAB_MEM_SPREAD | SLAB_ACCOUNT),=0A=
>> +			NULL);=0A=
>> +	if (zonefs_inode_cachep =3D=3D NULL)=0A=
>> +		return -ENOMEM;=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static void zonefs_destroy_inodecache(void)=0A=
>> +{=0A=
>> +	/*=0A=
>> +	 * Make sure all delayed rcu free inodes are flushed before we=0A=
>> +	 * destroy the inode cache.=0A=
>> +	 */=0A=
>> +	rcu_barrier();=0A=
>> +	kmem_cache_destroy(zonefs_inode_cachep);=0A=
>> +}=0A=
>> +=0A=
>> +static int __init zonefs_init(void)=0A=
>> +{=0A=
>> +	int ret;=0A=
>> +=0A=
>> +	BUILD_BUG_ON(sizeof(struct zonefs_super) !=3D ZONEFS_SUPER_SIZE);=0A=
>> +=0A=
>> +	ret =3D zonefs_init_inodecache();=0A=
>> +	if (ret)=0A=
>> +		return ret;=0A=
>> +=0A=
>> +	ret =3D register_filesystem(&zonefs_type);=0A=
>> +	if (ret) {=0A=
>> +		zonefs_destroy_inodecache();=0A=
>> +		return ret;=0A=
>> +	}=0A=
>> +=0A=
>> +	return 0;=0A=
>> +}=0A=
>> +=0A=
>> +static void __exit zonefs_exit(void)=0A=
>> +{=0A=
>> +	zonefs_destroy_inodecache();=0A=
>> +	unregister_filesystem(&zonefs_type);=0A=
>> +}=0A=
>> +=0A=
>> +MODULE_AUTHOR("Damien Le Moal");=0A=
>> +MODULE_DESCRIPTION("Zone file system for zoned block devices");=0A=
>> +MODULE_LICENSE("GPL");=0A=
>> +module_init(zonefs_init);=0A=
>> +module_exit(zonefs_exit);=0A=
>> diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h=0A=
>> new file mode 100644=0A=
>> index 000000000000..0296b3426f7b=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/zonefs.h=0A=
>> @@ -0,0 +1,169 @@=0A=
>> +/* SPDX-License-Identifier: GPL-2.0 */=0A=
>> +/*=0A=
>> + * Simple zone file system for zoned block devices.=0A=
>> + *=0A=
>> + * Copyright (C) 2019 Western Digital Corporation or its affiliates.=0A=
>> + */=0A=
>> +#ifndef __ZONEFS_H__=0A=
>> +#define __ZONEFS_H__=0A=
>> +=0A=
>> +#include <linux/fs.h>=0A=
>> +#include <linux/magic.h>=0A=
>> +#include <linux/uuid.h>=0A=
>> +#include <linux/mutex.h>=0A=
>> +#include <linux/rwsem.h>=0A=
>> +=0A=
>> +/*=0A=
>> + * Maximum length of file names: this only needs to be large enough to =
fit=0A=
>> + * the zone group directory names and a decimal value of the start sect=
or of=0A=
>> + * the zones for file names. 16 characters is plenty.=0A=
>> + */=0A=
>> +#define ZONEFS_NAME_MAX		16=0A=
>> +=0A=
>> +/*=0A=
>> + * Zone types: ZONEFS_ZTYPE_SEQ is used for all sequential zone types=
=0A=
>> + * defined in linux/blkzoned.h, that is, BLK_ZONE_TYPE_SEQWRITE_REQ and=
=0A=
>> + * BLK_ZONE_TYPE_SEQWRITE_PREF.=0A=
>> + */=0A=
>> +enum zonefs_ztype {=0A=
>> +	ZONEFS_ZTYPE_CNV,=0A=
>> +	ZONEFS_ZTYPE_SEQ,=0A=
>> +	ZONEFS_ZTYPE_MAX,=0A=
>> +};=0A=
>> +=0A=
>> +static inline enum zonefs_ztype zonefs_zone_type(struct blk_zone *zone)=
=0A=
>> +{=0A=
>> +	if (zone->type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
>> +		return ZONEFS_ZTYPE_CNV;=0A=
>> +	return ZONEFS_ZTYPE_SEQ;=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * In-memory inode data.=0A=
>> + */=0A=
>> +struct zonefs_inode_info {=0A=
>> +	struct inode		i_vnode;=0A=
>> +=0A=
>> +	/* File zone type */=0A=
>> +	enum zonefs_ztype	i_ztype;=0A=
>> +=0A=
>> +	/* File zone start sector (512B unit) */=0A=
>> +	sector_t		i_zsector;=0A=
>> +=0A=
>> +	/* File zone write pointer position (sequential zones only) */=0A=
>> +	loff_t			i_wpoffset;=0A=
>> +=0A=
>> +	/* File maximum size */=0A=
>> +	loff_t			i_max_size;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * To serialise fully against both syscall and mmap based IO and=0A=
>> +	 * sequential file truncation, two locks are used. For serializing=0A=
>> +	 * zonefs_seq_file_truncate() against zonefs_iomap_begin(), that is,=
=0A=
>> +	 * file truncate operations against block mapping, i_truncate_mutex is=
=0A=
>> +	 * used. i_truncate_mutex also protects against concurrent accesses=0A=
>> +	 * and changes to the inode private data, and in particular changes to=
=0A=
>> +	 * a sequential file size on completion of direct IO writes.=0A=
>> +	 * Serialization of mmap read IOs with truncate and syscall IO=0A=
>> +	 * operations is done with i_mmap_sem in addition to i_truncate_mutex.=
=0A=
>> +	 * Only zonefs_seq_file_truncate() takes both lock (i_mmap_sem first,=
=0A=
>> +	 * i_truncate_mutex second).=0A=
>> +	 */=0A=
>> +	struct mutex		i_truncate_mutex;=0A=
>> +	struct rw_semaphore	i_mmap_sem;=0A=
>> +};=0A=
>> +=0A=
>> +static inline struct zonefs_inode_info *ZONEFS_I(struct inode *inode)=
=0A=
>> +{=0A=
>> +	return container_of(inode, struct zonefs_inode_info, i_vnode);=0A=
>> +}=0A=
>> +=0A=
>> +/*=0A=
>> + * On-disk super block (block 0).=0A=
>> + */=0A=
>> +#define ZONEFS_SUPER_SIZE	4096=0A=
>> +struct zonefs_super {=0A=
>> +=0A=
>> +	/* Magic number */=0A=
>> +	__le32		s_magic;=0A=
>> +=0A=
>> +	/* Checksum */=0A=
>> +	__le32		s_crc;=0A=
>> +=0A=
>> +	/* Features */=0A=
>> +	__le64		s_features;=0A=
>> +=0A=
>> +	/* 128-bit uuid */=0A=
>> +	uuid_t		s_uuid;=0A=
>> +=0A=
>> +	/* UID/GID to use for files */=0A=
>> +	__le32		s_uid;=0A=
>> +	__le32		s_gid;=0A=
>> +=0A=
>> +	/* File permissions */=0A=
>> +	__le32		s_perm;=0A=
>> +=0A=
>> +	/* Padding to ZONEFS_SUPER_SIZE bytes */=0A=
>> +	__u8		s_reserved[4052];=0A=
>> +=0A=
>> +} __packed;=0A=
>> +=0A=
>> +/*=0A=
>> + * Feature flags: used on disk in the s_features field of struct zonefs=
_super=0A=
>> + * and in-memory in the s_feartures field of struct zonefs_sb_info.=0A=
>> + */=0A=
>> +enum zonefs_features {=0A=
>> +	/*=0A=
>> +	 * Aggregate contiguous conventional zones into a single file.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_AGGRCNV =3D 1ULL << 0,=0A=
>> +	/*=0A=
>> +	 * Use super block specified UID for files instead of default.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_UID =3D 1ULL << 1,=0A=
>> +	/*=0A=
>> +	 * Use super block specified GID for files instead of default.=0A=
>> +	 */=0A=
>> +	ZONEFS_F_GID =3D 1ULL << 2,=0A=
>> +	/*=0A=
>> +	 * Use super block specified file permissions instead of default 640.=
=0A=
>> +	 */=0A=
>> +	ZONEFS_F_PERM =3D 1ULL << 3,=0A=
>> +};=0A=
>> +=0A=
>> +#define ZONEFS_F_DEFINED_FEATURES \=0A=
>> +	(ZONEFS_F_AGGRCNV | ZONEFS_F_UID | ZONEFS_F_GID | ZONEFS_F_PERM)=0A=
>> +=0A=
>> +/*=0A=
>> + * In-memory Super block information.=0A=
>> + */=0A=
>> +struct zonefs_sb_info {=0A=
>> +=0A=
>> +	spinlock_t		s_lock;=0A=
>> +=0A=
>> +	unsigned long long	s_features;=0A=
>> +	kuid_t			s_uid;=0A=
>> +	kgid_t			s_gid;=0A=
>> +	umode_t			s_perm;=0A=
>> +	uuid_t			s_uuid;=0A=
>> +	loff_t			s_blocksize_mask;=0A=
>> +=0A=
>> +	unsigned int		s_nr_files[ZONEFS_ZTYPE_MAX];=0A=
>> +=0A=
>> +	loff_t			s_blocks;=0A=
>> +	loff_t			s_used_blocks;=0A=
>> +};=0A=
>> +=0A=
>> +static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)=
=0A=
>> +{=0A=
>> +	return sb->s_fs_info;=0A=
>> +}=0A=
>> +=0A=
>> +#define zonefs_info(sb, format, args...)	\=0A=
>> +	pr_info("zonefs (%s): " format, sb->s_id, ## args)=0A=
>> +#define zonefs_err(sb, format, args...)	\=0A=
>> +	pr_err("zonefs (%s) ERROR: " format, sb->s_id, ## args)=0A=
>> +#define zonefs_warn(sb, format, args...)	\=0A=
>> +	pr_warn("zonefs (%s) WARN: " format, sb->s_id, ## args)=0A=
>> +=0A=
>> +#endif=0A=
>> diff --git a/include/uapi/linux/magic.h b/include/uapi/linux/magic.h=0A=
>> index 3ac436376d79..d78064007b17 100644=0A=
>> --- a/include/uapi/linux/magic.h=0A=
>> +++ b/include/uapi/linux/magic.h=0A=
>> @@ -87,6 +87,7 @@=0A=
>>  #define NSFS_MAGIC		0x6e736673=0A=
>>  #define BPF_FS_MAGIC		0xcafe4a11=0A=
>>  #define AAFS_MAGIC		0x5a3c69f0=0A=
>> +#define ZONEFS_MAGIC		0x5a4f4653=0A=
>>  =0A=
>>  /* Since UDF 2.01 is ISO 13346 based... */=0A=
>>  #define UDF_SUPER_MAGIC		0x15013346=0A=
>> -- =0A=
>> 2.24.1=0A=
>>=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
