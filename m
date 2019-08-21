Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CBD8D96EA8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 21 Aug 2019 03:06:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbfHUBF7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Aug 2019 21:05:59 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:19245 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726215AbfHUBF7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Aug 2019 21:05:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1566349558; x=1597885558;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=2uZVhj0WCX7uaMISXCEYB3bhf9CcU0Vd+nd/YjSZ1cU=;
  b=iWOcb9j2WBZDiP49/x+eRIYREuF7KfmCarXSeWAjeVL6yUKNAGvEegCt
   NktTwQw8E/69Zb0oq/z8wmdLppIIr/0Zw+0JN7hxYBVPN3nMTAgAONCK2
   UCJZcjq+MUcNI5sb2vdvwZsAGhUjReJw4qLgkq4rqxVcuJsnvdg9njBL2
   Fs5lu7A2V3Yxb9Aejng5o3buQk67FbFpK+fdnM8B5QDqHQWfJROp9fNg7
   i3M3ToNa3L1mAZwUbSNKfCD4EmSLxTCdwgUgwov7AOVbp/UjnQMz0lgpd
   2SOoWyRK0Ds7EMBk02/Cys5D9LNaM1zroPThoCAoisKGvXzMFdJt+8cdL
   g==;
IronPort-SDR: RmQdTAf6l1Z75F92cQ7Kk67N++57l4aGQla8+PKFVt6cFq+zcbHFlvxZi2TtzITJsY9bc32vBp
 48HBUg6AaWcmHxfHq/3xmdUw6FnC4quVw8WxlGVF0iYfKPHHa2zp7o043HsxkOKFoOtpASpsFu
 kfw8up5lEmo7iVTIVXo2r731SCYOHxizDeFQc9W5JvnRAJAU4Al4ubeNRE43hD2qGXjdar3UMP
 qGrantLDk3iUEA3qbSq65ub8zIK1m1frgLrI21PxOJ8Xf/NTeHK6387IXfmajfaahac26cXqTG
 wMs=
X-IronPort-AV: E=Sophos;i="5.64,410,1559491200"; 
   d="scan'208";a="222864620"
Received: from mail-co1nam04lp2054.outbound.protection.outlook.com (HELO NAM04-CO1-obe.outbound.protection.outlook.com) ([104.47.45.54])
  by ob1.hgst.iphmx.com with ESMTP; 21 Aug 2019 09:05:57 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MffsqzV3hTyFzNOx4hy9eq1SzKHWgQEv4co9Rz7Cg483R2b22ce5ynYeebM5d5sY1e+orrze5ypA0v0V/wrA2aVl4iKAK1mWbBqX3DUGmpwUaq1/hCHuQB8FmSX+g14N3m/i13giIbj9KkmPzinX08zuuAIqQyQsIi16j5tc89X/Je+aDlfau7n8rZeXTNBGX9/EtcvdvrH1TSPEhdtPD+Wdo8dY6OS8Ls9X8e1gtZjyYYFtD4rvT/DzKU6UtsJH/kfEHV75BqbW0LsSyp11a2P6R13Xs3qDdJ42ZJvGFKt7wJRpzrvfZgPVIQ1b388ZVt+5bHrAxOMybG0B6/MULg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAGsGjvPihGsnc/sR8gpjxXrbW4CV5erQHa6EbqE0po=;
 b=UkrE4/kymeNED7GokXAi7Ma7hg8e05viJ4Ub9BxpgIZv7A0J5yJurHkX5yMzCqoFZdvUUlSPuOhfOGQcEjJV0RDctFgXiFX3L2iM8SNqODiGk+HDKxCK7RaeijrxaS/wMu1SxTOeti0ausWqCAaG3IYxO26gv276U/lzx21i2C0eOcm/hgLR3YnYde2XqaCgof80V3x54pWCX8eZGWPRhPHOloOFhEgcIBx8WCfonptCu6boLhrWTpbYxRIqB5OgLukQKj5ehaPNDKsLTstMnJQw1iho0mrwJKRjR4XlWmNE1evBv62mInS1jCqv0kZx5X3lSq9luKFITVSLFNUYcA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RAGsGjvPihGsnc/sR8gpjxXrbW4CV5erQHa6EbqE0po=;
 b=ph/T6vFJB73TIvO4BJ0V5iNMq4lv94m9tpAAdNgXm6c7fFt+mYxakstTYAVImzHB9HD4htv6AyGG3WIbcACpKWrTEht8CfO7MTERnTtJY8kDhD8P1qRk1GCl6ifjUZrmRT+0GCLBjzcA3FqWj65q5JCZuePn6V4Y5R7hE4W4CP8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.58.207) by
 BYAPR04MB4263.namprd04.prod.outlook.com (20.176.251.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Wed, 21 Aug 2019 01:05:56 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::a538:afd0:d62a:55bc%7]) with mapi id 15.20.2178.020; Wed, 21 Aug 2019
 01:05:56 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Dave Chinner <david@fromorbit.com>,
        Hannes Reinecke <hare@suse.de>,
        Matias Bjorling <Matias.Bjorling@wdc.com>
Subject: Re: [PATCH V2] fs: New zonefs file system
Thread-Topic: [PATCH V2] fs: New zonefs file system
Thread-Index: AQHVVy8UVAVGvwSe4Um+ID5oFBsG3w==
Date:   Wed, 21 Aug 2019 01:05:56 +0000
Message-ID: <BYAPR04MB58160FB257F05BB93D3367BFE7AA0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20190820081249.27353-1-damien.lemoal@wdc.com>
 <20190820152638.GA1037422@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.9]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d83c4724-b7b0-410a-37be-08d725d3b8d4
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:BYAPR04MB4263;
x-ms-traffictypediagnostic: BYAPR04MB4263:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB42636548F45CB6878475A866E7AA0@BYAPR04MB4263.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2733;
x-forefront-prvs: 0136C1DDA4
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(366004)(136003)(39860400002)(376002)(396003)(346002)(189003)(199004)(102836004)(486006)(53936002)(71190400001)(6116002)(52536014)(99286004)(14444005)(476003)(5660300002)(14454004)(316002)(25786009)(6436002)(66476007)(66446008)(81166006)(33656002)(81156014)(54906003)(91956017)(76116006)(66066001)(3846002)(74316002)(2906002)(478600001)(64756008)(76176011)(66556008)(66946007)(8676002)(8936002)(446003)(305945005)(7736002)(256004)(6916009)(26005)(229853002)(53546011)(55016002)(6506007)(7696005)(71200400001)(186003)(4326008)(9686003)(6246003)(86362001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB4263;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: X/CP4RJ1mUd7qa71AJq3IB/d7AXcsj9q0hPErLrxEKWeyD6rIZU2Pzy492gZJTblz8rpAAvLp9/S3YQ349xGwXW2kNnLtfRxzEc847AekKb1b3gg/nPLjSHQH6VE6+wncQ+1yoM7CJE8UCQoP4zlMvU9YBNzTIb9kKr0tfNxnExGy8ZOTKmp4CNCTp6ltG2ivCXM7lQxyZrNgzvX2CSV45xSiJLo6eFh9Hm1+uKtQBmWFbCwbJK/vD+5wTL//iheQwYsrOAUddvtiEnsIypfQnmkfaowG6FhUFGA+3W00NK1HsrdXI91TtWVQHSapY3zCeqiE1qIYmdV38Evw0Mm+MA4YvbEDR9/Uskq5vT5xmvAlVuQf+nnP46g58SRlpEjuocMaOCDlmAh0h33J7StddMz+UVm3fsUXeWyk61CZJs=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d83c4724-b7b0-410a-37be-08d725d3b8d4
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2019 01:05:56.4178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bP+fbXHco0apkcI1nQ3GNBcd+EJ+N6N3fVOWaYPe1stD1rxsQc4OBzGx6WE7aZC2BK2+F0W64Si5SEcHdOr7Ew==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4263
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Darrick,=0A=
=0A=
On 2019/08/21 0:26, Darrick J. Wong wrote:=0A=
[...]=0A=
>> +/*=0A=
>> + * Read super block information from the device.=0A=
>> + */=0A=
>> +static int zonefs_read_super(struct super_block *sb)=0A=
>> +{=0A=
>> +     struct zonefs_sb_info *sbi =3D ZONEFS_SB(sb);=0A=
>> +     struct zonefs_super *super;=0A=
>> +     struct bio bio;=0A=
>> +     struct bio_vec bio_vec;=0A=
>> +     struct page *page;=0A=
>> +     int ret;=0A=
>> +=0A=
>> +     page =3D alloc_page(GFP_KERNEL);=0A=
>> +     if (!page)=0A=
>> +             return -ENOMEM;=0A=
>> +=0A=
>> +     bio_init(&bio, &bio_vec, 1);=0A=
>> +     bio.bi_iter.bi_sector =3D 0;=0A=
>> +     bio_set_dev(&bio, sb->s_bdev);=0A=
>> +     bio_set_op_attrs(&bio, REQ_OP_READ, 0);=0A=
>> +     bio_add_page(&bio, page, PAGE_SIZE, 0);=0A=
>> +=0A=
>> +     ret =3D submit_bio_wait(&bio);=0A=
>> +     if (ret)=0A=
>> +             goto out;=0A=
>> +=0A=
>> +     ret =3D -EINVAL;=0A=
>> +     super =3D page_address(page);=0A=
>> +     if (le32_to_cpu(super->s_magic) !=3D ZONEFS_MAGIC)=0A=
>> +             goto out;=0A=
>> +     sbi->s_features =3D le64_to_cpu(super->s_features);=0A=
>> +     if (zonefs_has_feature(sbi, ZONEFS_F_UID)) {=0A=
>> +             sbi->s_uid =3D make_kuid(current_user_ns(),=0A=
>> +                                    le32_to_cpu(super->s_uid));=0A=
>> +             if (!uid_valid(sbi->s_uid))=0A=
>> +                     goto out;=0A=
>> +     }=0A=
>> +     if (zonefs_has_feature(sbi, ZONEFS_F_GID)) {=0A=
>> +             sbi->s_gid =3D make_kgid(current_user_ns(),=0A=
>> +                                    le32_to_cpu(super->s_gid));=0A=
>> +             if (!gid_valid(sbi->s_gid))=0A=
>> +                     goto out;=0A=
>> +     }=0A=
>> +     if (zonefs_has_feature(sbi, ZONEFS_F_PERM))=0A=
>> +             sbi->s_perm =3D le32_to_cpu(super->s_perm);=0A=
> =0A=
> Unknown feature bits are silently ignored.  Is that intentional?  Will=0A=
> all features be compat features?  I would find it a little annoying to=0A=
> format (for example) a F_UID filesystem only to have some old kernel=0A=
> driver ignore it.=0A=
=0A=
Good point. I will add checks for unknown feature bits.=0A=
=0A=
>> +/*=0A=
>> + * On-disk super block (block 0).=0A=
>> + */=0A=
>> +struct zonefs_super {=0A=
>> +=0A=
>> +     /* Magic number */=0A=
>> +     __le32          s_magic;=0A=
>> +=0A=
>> +     /* Features */=0A=
>> +     __le64          s_features;=0A=
>> +=0A=
>> +     /* 128-bit uuid */=0A=
>> +     uuid_t          s_uuid;=0A=
>> +=0A=
>> +     /* UID/GID to use for files */=0A=
>> +     __le32          s_uid;=0A=
>> +     __le32          s_gid;=0A=
>> +=0A=
>> +     /* File permissions */=0A=
>> +     __le32          s_perm;=0A=
>> +=0A=
>> +     /* Padding to 4K */=0A=
>> +     __u8            s_reserved[4056];=0A=
> =0A=
> Hmm, I noticed that fill_super doesn't check that s_reserved is actually=
=0A=
> zero (or any specific value).  You might consider enforcing that so that=
=0A=
> future you can add fields beyond s_perm without having to burn a=0A=
> s_features bit every time you do it.=0A=
=0A=
Indeed. Will fix that.=0A=
=0A=
> Also a little surprised there's no checksum field here to detect bit=0A=
> flips and such. ;)=0A=
=0A=
Yep. I did have that on my to-do list but forgot to actually do it... Will =
fix=0A=
everything and send a v3.=0A=
=0A=
Thank you for the comments. One more question: should I rebase on your=0A=
iomap-for-next branch or on iomap-5.4-merge branch ? Both branches look=0A=
identical right now.=0A=
=0A=
Best regards.=0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
