Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C55B912A650
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Dec 2019 07:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726025AbfLYGFT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Dec 2019 01:05:19 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:53046 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbfLYGFS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Dec 2019 01:05:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1577253918; x=1608789918;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=peQ19EAu+LDhcaQlSAmaEoFYGegjLK4L2EOJHU2qIsc=;
  b=f1onqqh3lmZzw4SHeuzXOZT8600cUK8moVtxMQ6L2zLxWkocFUa/xmF2
   jhbrn0UHNQJxSMyc5NWmrm3bvV3ew7jJle3ar2O0wUq3k/K1hqBfdD1RF
   x/6kVlF3Zk47nEVxdpIBaaG6BM2gBfJ+xS/yKB9jqU8jC7uOm9yVY8q3e
   raHlIFuoX1GOipHVlaDnuOBu+1bBYBhGj49cTQmPPYIaEH0tZWGOYMHug
   yXEHHFOQKzAjXQ8+GxHA1bAJVmIW0eMIlN8rfFyJBU666d+bxfQezj6U1
   Soi0+q7oJaLqlpzB/TfwyemIz2eKX8cyAJkv+z7j503FZUd7z8nRXpSnn
   w==;
IronPort-SDR: 0hCfGNZ5iven2KBXOiLOtN++k1wfAPxhfvb73p7BXPc8niwA0vlkEZZHvnPMepxSdo+TAsj5qF
 QcuitJTIvbaGL23ampiquH1Xn7toTqEo3HeZLdbZW7Y0m+cRv3JXX04BWnokw+hED+45tcSbF/
 9ApqgVK1T/uaVvORHk+14FMRnYBX847EEyI0ao9DIjhnnJ9Td6ltvdiJ9dp9/raBN+WeQW9vJq
 HTYcVTMQbPZsFRXs8KOlxx+/MQm+SHOYkcrx/3I8aGWAh4DiDNayMEq4rbS+A4Dkz88LQZoGIX
 +NY=
X-IronPort-AV: E=Sophos;i="5.69,353,1571673600"; 
   d="scan'208";a="126100488"
Received: from mail-dm6nam11lp2169.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.169])
  by ob1.hgst.iphmx.com with ESMTP; 25 Dec 2019 14:05:17 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z/PcHFAqj5TTQahmUMkwPOwK7KeuyfWXsFrZZuoCymbzJQc9S8jr7u7iTVF5mqzl3NylAbwzFBkI20qSOcP1NkmwIeqZSzFr5PR6Rj7qpOmmAdry872f+c5EjUZ0Ptf8FL1Qz3mZfLQffHvPRniYPhe7c+U+lx/JXgG77rZL/WqC4zqv+5A4HZ1uXAUSgkVZAZx1JNWE4h9/DEz/LsKJEwslyL00UVvQWSO/eA9TEl8vryRwkno8bV+10n3qxHNTyuzKo7tD/xIiKlDKLTmU/w5xYJMbOTyBXjhORWDrab0Y0KIbgSbHs53/ipcvlRareLXR93+iQN9nHx2z6PiH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd8C0bEls/L2Y1IBelQfhHg59c4sAzExpEVeqnwhP8Y=;
 b=ORPx4w/43/kg1N8zdjJr8ojlMezVDGOia43JOZUVccAxqo0ZA6wK8/CJsSlScBO4A7AQbQbjf9SW22OYSsVdaP/xA19dGDcbhHC4EQ2oayRNuYYcjgBHru2TEQ3HdQX0nGsjdPg1HvqYElQfMHlg8QkKLZTOLl7fuw8l0ijj9gJlf6Gwf1Hv6ambP9tc0D92ZK/tlTSQu7FR4yfvFwOChxXaRJBaXI/VQLMsiXwpYfP1GKNnX+pr8ukTDINquG4ORq5fRmgkW0MZdcNw33ruMGmsHI7/EMqNNARvjJUoK2+7uEH65wVzv5JCCU07dqahdkFWqCIlcV7Yi2LulH5eOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bd8C0bEls/L2Y1IBelQfhHg59c4sAzExpEVeqnwhP8Y=;
 b=Gk3h7gmb1g2nmFk/WPbo1noXTSUhQJs1QYxVMZq5fbl7yhMm0vl4fri1V5eW0NiPhZbKzCjC//c6gselkJ2+SSWGMZ7JdTL0v8N5pb1uuobYrZFPh7+njl9oBf7A1WF2SNDptt4NSvH9mD3Xa5B3IaCQxl7W0j49BBIQ5vzMZd4=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB4727.namprd04.prod.outlook.com (52.135.237.33) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2559.19; Wed, 25 Dec 2019 06:05:16 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2581.007; Wed, 25 Dec 2019
 06:05:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH v3 1/2] fs: New zonefs file system
Thread-Topic: [PATCH v3 1/2] fs: New zonefs file system
Thread-Index: AQHVuf7BpC1bTe1k6UmgztFIqbNKpA==
Date:   Wed, 25 Dec 2019 06:05:15 +0000
Message-ID: <BYAPR04MB5816B3322FD95BD987A982C1E7280@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20191224020615.134668-1-damien.lemoal@wdc.com>
 <20191224020615.134668-2-damien.lemoal@wdc.com>
 <20191224044001.GA2982727@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 7f2062c9-bf7c-483d-5b88-08d789006979
x-ms-traffictypediagnostic: BYAPR04MB4727:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB472794230412449BDFBFA3AFE7280@BYAPR04MB4727.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 02622CEF0A
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(136003)(396003)(366004)(376002)(346002)(189003)(199004)(54094003)(2906002)(91956017)(4326008)(66446008)(316002)(64756008)(5660300002)(52536014)(478600001)(8676002)(81156014)(81166006)(66946007)(6506007)(53546011)(6916009)(76116006)(8936002)(7696005)(26005)(66556008)(66476007)(71200400001)(86362001)(55016002)(186003)(33656002)(9686003)(54906003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4727;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 27pqEVQ4esuEbBealzTID/nxHgrBuW3i2dKRoPWyStwjw6L3KAWgU/Cfd2BSaWZDzRq9OvNC/QzNcLltOwepOgnJTx+iEse6oBuTYCrTP0PEQXTWjXXBxMqSNtJ6yvv50u8Qn43yRfA8YZlxr43/AAsOZL1uhxRcbTNyzHF3wgS7KNZSg1bEEMeZZaPOs4MwmIOzGHWh6ysePTHVg+glV6ewy3FyMpiDU9qI6HhbfeiWaZcOHs6jY7TbI4uq+jAttf5p8BPyf94/YEgpwPNBgxCpM6WZahVanytP4QuPrRQY84GEQJUYF3Yly41a91JSJkmz/UvZHGEfqMOHNBKpl+54N1Q6hhf6npKew/mAAkkrfs2PaR0gh3FaXvG+cavlD2HGYburKiWgZZimrX4bQOKcBhzRpxxblk+ZHdaHNyLndruL5NxO8frd7qwDB6XAlTgVuCggG5YQ/8WsEWKDI01lK5VPqLsYvtTMpzDZOFaxnwyDeKMUc2e5SWXY4qlN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f2062c9-bf7c-483d-5b88-08d789006979
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Dec 2019 06:05:15.5782
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 80kWq+yxloWo8QuTWJ7lWA5m8RmIBOQI3pAJhDApxcKQDfm3x0K1nHumY3dYvlqCoT1GHo2cj+1K+xbvqfysYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4727
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/12/24 13:40, Darrick J. Wong wrote:=0A=
[...]=0A=
>>  config FS_DAX=0A=
>>  	bool "Direct Access (DAX) support"=0A=
>> diff --git a/fs/Makefile b/fs/Makefile=0A=
>> index 1148c555c4d3..527f228a5e8a 100644=0A=
>> --- a/fs/Makefile=0A=
>> +++ b/fs/Makefile=0A=
>> @@ -133,3 +133,4 @@ obj-$(CONFIG_CEPH_FS)		+=3D ceph/=0A=
>>  obj-$(CONFIG_PSTORE)		+=3D pstore/=0A=
>>  obj-$(CONFIG_EFIVAR_FS)		+=3D efivarfs/=0A=
>>  obj-$(CONFIG_EROFS_FS)		+=3D erofs/=0A=
>> +obj-$(CONFIG_ZONEFS_FS)		+=3D zonefs/=0A=
>> diff --git a/fs/zonefs/Kconfig b/fs/zonefs/Kconfig=0A=
>> new file mode 100644=0A=
>> index 000000000000..6490547e9763=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/Kconfig=0A=
>> @@ -0,0 +1,9 @@=0A=
>> +config ZONEFS_FS=0A=
>> +	tristate "zonefs filesystem support"=0A=
>> +	depends on BLOCK=0A=
>> +	depends on BLK_DEV_ZONED=0A=
>> +	help=0A=
>> +	  zonefs is a simple File System which exposes zones of a zoned block=
=0A=
>> +	  device as files.=0A=
> =0A=
> I wonder if you ought to mention here some examples of zoned block=0A=
> devices, such as SMR drives?=0A=
=0A=
Yes, will add that.=0A=
=0A=
>> +=0A=
>> +	  If unsure, say N.=0A=
>> diff --git a/fs/zonefs/Makefile b/fs/zonefs/Makefile=0A=
>> new file mode 100644=0A=
>> index 000000000000..75a380aa1ae1=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/Makefile=0A=
>> @@ -0,0 +1,4 @@=0A=
>> +# SPDX-License-Identifier: GPL-2.0=0A=
>> +obj-$(CONFIG_ZONEFS_FS) +=3D zonefs.o=0A=
>> +=0A=
>> +zonefs-y	:=3D super.o=0A=
>> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
>> new file mode 100644=0A=
>> index 000000000000..417de3099fe0=0A=
>> --- /dev/null=0A=
>> +++ b/fs/zonefs/super.c=0A=
> =0A=
> <snip>=0A=
> =0A=
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
> =0A=
> Can a zone go from offline (or I suppose readonly) to one of the other=0A=
> not-immutable states?  If a zone comes back online, you'd want to clear=
=0A=
> S_IMMUTABLE.=0A=
=0A=
ZBC/ZAC specifications do not define transitions into and out of the=0A=
READONLY and OFFLINE states.=0A=
=0A=
For both offline and read-only states, the standard says that a zone=0A=
transitions into offline or read-only for:=0A=
=0A=
"a) as a result of media failure; or=0A=
 b) for reasons outside the scope of this standard."=0A=
=0A=
As for the transition out of these states:=0A=
=0A=
"All transitions out of this state are outside the scope of this standard."=
=0A=
=0A=
So from the file system point of view, once these states are seen,=0A=
nothing can be explicitly done to get out of them and even if the drive=0A=
itself does something, there is no notification mechanism and only=0A=
regularly doing report zones will allow detecting the change.=0A=
Of all the SMR drives I know of, these states are only used if there is=0A=
indeed a media failure/head failure. Seeing these states is likely=0A=
synonymous with "your drive is dying". NVMe Zoned Namespace may define=0A=
these in slightly different ways (work in progress) though, so we may=0A=
need to revisit the immutable flag management for that case.=0A=
=0A=
For now, irreversibly setting the immutable flag matches the zone state=0A=
management by the disk, so I think it is OK.=0A=
=0A=
=0A=
> =0A=
>> +		inode->i_mode =3D S_IFREG;=0A=
> =0A=
> i_mode &=3D ~S_IRWXUGO; ?=0A=
=0A=
Yes, indeed that is better. checkpatch.pl does spit out a warning if one=0A=
uses the S_Ixxx macros though. See below.=0A=
=0A=
> =0A=
> Note that clearing the mode flags won't prevent programs with an=0A=
> existing writable fd from being able to call write().  I'd imagine that=
=0A=
> they'd hit EIO pretty fast though, so that might not matter.=0A=
> =0A=
>> +		zone->wp =3D zone->start;=0A=
>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY) {=0A=
>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>> +		inode->i_mode &=3D ~(0222); /* S_IWUGO */=0A=
> =0A=
> Might as well just use S_IWUGO directly here?=0A=
=0A=
Because checkpatch spits out a warning if I do. I would prefer using the=0A=
macro as I find it much easier to read. Should I just ignore checkpatch=0A=
warning ?=0A=
=0A=
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
>> +		perm =3D 0;=0A=
>> +	} else if (zone->cond =3D=3D BLK_ZONE_COND_READONLY) {=0A=
>> +		/* Do not allow writes in read-only zones */=0A=
>> +		inode->i_flags |=3D S_IMMUTABLE;=0A=
>> +		perm &=3D ~(0222); /* S_IWUGO */=0A=
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
>> +	inode->i_fop =3D &zonefs_file_operations;=0A=
>> +	inode->i_op =3D &zonefs_file_inode_operations;=0A=
>> +	inode->i_mapping->a_ops =3D &zonefs_file_aops;=0A=
>> +=0A=
>> +	sb->s_maxbytes =3D max(zi->i_max_size, sb->s_maxbytes);=0A=
> =0A=
> Uhh, just out of curiosity, can zones be larger than 16T?  Bad things=0A=
> happen on 32-bit kernels when you set s_maxbytes larger than that.=0A=
> =0A=
> (He says with the hubris of having spent days sorting out various=0A=
> longstanding bugs in 32-bit XFS.)=0A=
=0A=
In theory, yes, zones can be larger than 16TB. The standards do not=0A=
prevent it. However, the chunk_sectors queue limit attribute that holds=0A=
the zone size of a device is an unsigned int and there are checks when=0A=
it is initialized that the device zone size is not larger than UINT_MAX.=0A=
=0A=
In any case, please note that I did make sure that we do not exceed=0A=
MAX_LFS_FILESIZE: a few line above the one you commented, there is:=0A=
=0A=
zi->i_max_size =3D min_t(loff_t, MAX_LFS_FILESIZE,=0A=
		       zone->len << SECTOR_SHIFT);=0A=
=0A=
So for sb->s_maxbytes, 16TB maximum is a hard limit on 32-bit arch that=0A=
cannot be exceeded.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
