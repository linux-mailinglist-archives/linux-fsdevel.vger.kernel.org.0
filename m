Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 42EBE75CF2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jul 2019 04:25:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726004AbfGZCY6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 25 Jul 2019 22:24:58 -0400
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:34655 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725808AbfGZCY6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 25 Jul 2019 22:24:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1564108008; x=1595644008;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=M1edihby25M5JEmzQphw2I86aIbmXAOwv4YCkNAdV+0=;
  b=kBCtih9OoWPzw6T+JWyn+hQqeUgON78aWKf2skSQxILfHCC4M59hTtic
   u2fK92ACzyzskfDMekaiP7jynAxD3RO4kURtascUIdGgBaVLWuaTZ1fCe
   TCCI1ywDuktbmM9k9A68emyaclsraDK6y9fsdgV9qQuPGykOSH25VZzHj
   RFpVImTRcZ/t/YRNLmLQdOP9fZ0XjwtjQYVNxcJgQ76dieLPxh3o8c0SF
   90XJo+9y1Oo/b1bbL2/s4SguWsFTQxv60wkySJpju/n7kfyKcR1ILB/1D
   Na9yQlTUXkzp+NMhB/3AItqQvWrBRVV0b832S0lwtXrJFmGqOkhdnF2DA
   Q==;
IronPort-SDR: 0LVAFcX9xcls3Ke4JI59otGm4SN3LZAJpsUvqNF4r0XF2WYnITTV2QzBEQYO9lFXrleEf90R+3
 khkW23RfG1PTw82aLqPvpwPnZfhDgkqFa2FyVRwtUjEYmLGa1aUY3HK4W2C99sViWs3skg4iBP
 UlW4G2wheFRREOTrJLIkICIBJSEOzWhQISF71dqKp7lhOZGzvbVQPcWQXkVLrA4T3IAg+leuPK
 hsxkAUo9c90o/yEMYgYIqNf6Hz15IF3/G9x+IOZJ2aU9tbpmSwz5Ckn5QsVWSJr+des9bQHoud
 i40=
X-IronPort-AV: E=Sophos;i="5.64,308,1559491200"; 
   d="scan'208";a="214276510"
Received: from mail-cys01nam02lp2055.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.55])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jul 2019 10:26:46 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HTbWSPzM8i5Q5MyVx1dNVK/YyCYcUG432jXkUzRCQYzU/5Z3ABQH1NOp+l9q/tZTe3ebEnf65pSqjxQgvdFgXTlMa+wVJPrVNL3zkXqcWwOAV/ds2hq7rPe9AQBTD6QFwOqb1IDi/voN572F7GEhywudKUO8WdViUy7YjMMVbSm/GPmRDCkf8wJnRSqQt3jgG9n0Au0dJvOhQ6Z5iqnbV6FtflI1+7YcjnDkhiZXXWdEoO9Mc9dcrJbtNtsbVSZwu6Pz8MZfk6sc5IphDpnm7TOX4UHz3Z8TiraLWp9sSV/W04H2QanJuQqyz0g396wh5phIu6o4LOJAJVceukmVZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjmSyXrwqAHxKeUrkqAaUh8osPBf6pf/TAIEtIchKOA=;
 b=SBTZmPE1PYA+j+DSqBe2MxZlZ7XYj/fPMCRzfPLtqM6mSvU3hlYequFyDsYzRPWpyNDi2GviEd+IbQE0ln/T16nFLkegK0/NLrlbadm+rqPZuKaXwj+4PtMkWNZ6kbaWiSgPkR1OBJahnc7KOl5eUi7l+HDwmK7Th7Lvm1pnyM9ovADQyjIxkhtzsfOkqq/szohO95Og3n3HkHdxH7ImvZ+OR2K01u7jkVY74U9PW2hnHb1jW+e+gVfx6ioJBOd9ydED56M342DxqzKwuplXkNITsvMja4778yBda/oz/c1NY+WxmEFODc8K406sfuKGlQyUKtMTl0rOjpfqLfqKlQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1;spf=pass
 smtp.mailfrom=wdc.com;dmarc=pass action=none header.from=wdc.com;dkim=pass
 header.d=wdc.com;arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fjmSyXrwqAHxKeUrkqAaUh8osPBf6pf/TAIEtIchKOA=;
 b=RmqEwlAjLe8KKOyOJoE7bRO3kCC8EF8DdNlGFdDC59oBcOvxQcn1hCp+6l3G3KQrQ97t1cE0fxXj8gNPf+Azd4yCAX2sxoU+6sAx1Mr+OOduMDQ2A8lP9O+GGYNoy8F/zwysH/Papj4DrHE0d/VTdFQbInv9KvpvgM3S4kGPefM=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB5144.namprd04.prod.outlook.com (52.135.235.82) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2115.10; Fri, 26 Jul 2019 02:24:55 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::65a9:db0a:646d:eb1e%6]) with mapi id 15.20.2094.013; Fri, 26 Jul 2019
 02:24:55 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Theodore Ts'o <tytso@mit.edu>,
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
Date:   Fri, 26 Jul 2019 02:24:55 +0000
Message-ID: <BYAPR04MB58167C8085CB2E47EEBC706BE7C00@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190725093358.30679-1-damien.lemoal@wdc.com>
 <20190725115442.GA15733@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.11]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5664e60e-51cb-4d68-4ce3-08d7117072cd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:BYAPR04MB5144;
x-ms-traffictypediagnostic: BYAPR04MB5144:
x-microsoft-antispam-prvs: <BYAPR04MB5144973B74551CDD2BCFB6C9E7C00@BYAPR04MB5144.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 01106E96F6
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(396003)(39860400002)(346002)(366004)(376002)(136003)(189003)(199004)(66556008)(54906003)(55016002)(446003)(305945005)(316002)(476003)(2906002)(256004)(14444005)(486006)(68736007)(74316002)(7736002)(186003)(3846002)(33656002)(71200400001)(71190400001)(76176011)(66066001)(99286004)(7696005)(81166006)(81156014)(66446008)(26005)(76116006)(102836004)(66476007)(6246003)(52536014)(86362001)(53936002)(25786009)(8936002)(229853002)(53546011)(8676002)(6506007)(478600001)(5660300002)(9686003)(14454004)(66946007)(91956017)(6916009)(6116002)(6436002)(4326008)(64756008)(21314003);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB5144;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: VLYVzPpPfCOKfIJfe+Eyv4kxt10YbxfaLON2kjgRfFUv3WWjALLuTREChgxU/MgxV/NG92yfSCmjmpze26pvT6w8aBo+BfuCR4GuvogLESepFusxRfY184EsVvtlAeCq21nDcUH1cR0QgUmaqmT1dcFPwx5mMZW3TJpP2o4J9XkhP70IrPggDpOItbzYsDjeJdFpWIWI+CLs9BVX2iOVRGgsFRH4OPomVK1EfU25/80zJId45B0WIPEt8b1P2DKpEQipokg1332H3XVcWAZ5Se0xNBxUPH4QVbWPXYbbKwv7ADtlo/mpqjOin0pV79lIofVmmeuRebZxec/92PXOMmznZXUKABX/fNe92IYpa94AaLqCWnlYb261Eyko4Wvo0CS125uP/uFMOc2ND1fNqAIchIK3M64RBNtmikTsnuw=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5664e60e-51cb-4d68-4ce3-08d7117072cd
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jul 2019 02:24:55.5131
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Damien.LeMoal@wdc.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5144
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2019/07/25 20:54, Christoph Hellwig wrote:=0A=
> On Thu, Jul 25, 2019 at 06:33:58PM +0900, Damien Le Moal wrote:=0A=
>> +	gfp_t gfp_mask;=0A=
>> +=0A=
>>  	switch (ext4_inode_journal_mode(inode)) {=0A=
>>  	case EXT4_INODE_ORDERED_DATA_MODE:=0A=
>>  	case EXT4_INODE_WRITEBACK_DATA_MODE:=0A=
>> @@ -4019,6 +4019,14 @@ void ext4_set_aops(struct inode *inode)=0A=
>>  		inode->i_mapping->a_ops =3D &ext4_da_aops;=0A=
>>  	else=0A=
>>  		inode->i_mapping->a_ops =3D &ext4_aops;=0A=
>> +=0A=
>> +	/*=0A=
>> +	 * Ensure all page cache allocations are done from GFP_NOFS context to=
=0A=
>> +	 * prevent direct reclaim recursion back into the filesystem and blowi=
ng=0A=
>> +	 * stacks or deadlocking.=0A=
>> +	 */=0A=
>> +	gfp_mask =3D mapping_gfp_mask(inode->i_mapping);=0A=
>> +	mapping_set_gfp_mask(inode->i_mapping, (gfp_mask & ~(__GFP_FS)));=0A=
> =0A=
> This looks like something that could hit every file systems, so=0A=
> shouldn't we fix this in common code?  We could also look into=0A=
> just using memalloc_nofs_save for the page cache allocation path=0A=
> instead of the per-mapping gfp_mask.=0A=
=0A=
I agree. I did a quick scan and it looks to me like not all file systems ar=
e=0A=
using GFP_NOFS when grabbing pages for read or write. XFS, btrfs, f2fs, jfs=
,=0A=
gfs2 and ramfs seem OK, but I did not dig very deep for others where the us=
e of=0A=
GFP_NOFS is not obvious.=0A=
=0A=
I am not sure though how to approach a global fix. At the very least, it ma=
y be=0A=
good to have GFP_NOFS set by default in the inode mapping flags in=0A=
__address_space_init_once() which is called from inode_init_once(). But I a=
m not=0A=
sure if that is enough nor if all file systems are using this function.=0A=
=0A=
The other method as you suggest would be to add calls to=0A=
memalloc_nofs_save/restore() in functions like grab_cache_page_write_begin(=
),=0A=
but since that would cover writes only, we may want to do that at a higher =
level=0A=
in the various generic_xxx() and mpage_xxx() helper functions to cover more=
=0A=
ground. But that would still not be enough for the files systems not using =
these=0A=
helpers (plenty of examples for that for the write path).=0A=
=0A=
Or do we go as high to VFS layer to add memalloc_nofs_save/restore() calls =
?=0A=
That would be a big hammer fix... I personally think this would be OK thoug=
h,=0A=
but I may be missing some points here.=0A=
=0A=
Thoughts on the best approach ?=0A=
=0A=
Best regards.=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
