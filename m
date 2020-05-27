Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A3A21E44A7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 May 2020 15:55:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388954AbgE0Nyz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 May 2020 09:54:55 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:34099 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388875AbgE0Nyy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 May 2020 09:54:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1590587695; x=1622123695;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=LbygAn6ZApo170+U0evCNrscYG/aeNKyRhR5gwj0cRE=;
  b=N97K2QoCWP0VXCh0NCYVm4q1Qawbs+OmjhESDy52JA4GjNQ2RBxO63E+
   Bo5dxo2Nn+XSDgU3TQbw0Og/ZZXoSFD4GwELDvnLucx8+tW9p96mnqm9b
   gn70D4Z7zCfsENz/Mtp0dFXfRkcxhLjWAPWEPy/CNiDOzcFRgya5WHMK/
   dqL8spxp8VnULICfgiOD97/ib1cemcQ4MlJKDbsoVFX2H920MNXs3GDHK
   JpO0Ajn8NyCqrqGeODsuPIwescmSXfLA8AG6NACj4L+DpS2VmCve/2sGT
   f+Fw/XGaxzcIqqAA2rPKLm7anym2A0HMZEqlTff+aio3loUTSOb0bwgXn
   A==;
IronPort-SDR: sjHL0iQRWrr3Rsoq6mEgLZwFpK8OcTohcoUsOCU6CUo+Htla2GkQfZbXcW5c17yRSccCdv286X
 cf8I9HPdS0YfC/66Bd9UBllbv2Ab/q+SrBCFJm9YNnhScb5eqhjKq4WR5m/SPlqnw1CvvKwP3x
 6cs+3MAjfB4uNmTwDKHCjQFAKlCbvlzPjprDebTa6vOdaYUT+UCbPjhLSsAlV3Qb3lOk1iVFyQ
 gZjFsaDSHiAsGcYPRQ/ZBXCqJeYcCSsPbGJUCmv6QWxL+J/B3HnPMG18dQ8oCRCh6capOOmqdh
 ZG8=
X-IronPort-AV: E=Sophos;i="5.73,441,1583164800"; 
   d="scan'208";a="142949566"
Received: from mail-dm6nam10lp2104.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.104])
  by ob1.hgst.iphmx.com with ESMTP; 27 May 2020 21:54:54 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YVE5w5mdDtMqvYdT0fWg+8xZfN3jZnPqfDas4Yzt4SyAPb1WP8Jhp0Lj1gE5gJO0dg7nXoNdhby5Pz2q7O1iYIJeVfnntOuWqRgU9Z1kGdvWmiRAxoOB6e12yRG4KqEBXuMiyOl8HFHWgU+UeFcSW+sQ6y89on/cEW/Cea2xIT7aBTfh9Akrja2SjUxRn3nstBqgwiGurJ6xuF5/I3YyqID7LtchKlx18VEBiD9/t2JpKm5AaytpbXzMvxHE9bCwvh/XNGZuJORb13DNKoi9u0lDNAoOgVYNv90oPFFsNSuM005GU1DD/uWyZqudx8S7zj/nqE/YA1MZakNNWlrbnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilNKspfy/pRmgCzjGjyHNEFrTZcv32S3gZqtwmpMjHQ=;
 b=CX7zvwHPEDeyh4iZl5T4NePYmwnnCWS9lgF5wKLNyZj+A6uC0J4be4r4BQ00GTvEDm+0wOqqOcGT79eoxOD9khXRkmTFFL4rVLK5dJimS/QblbVYCH+g0NUulBoOxets0YLrGe8twjDj/6nuKdn+8yKFuKv4BXf6P3krhu5Ho8G9kt9xygMOKFVmSVM3a9QAmMVJPaO9y2YLBtsX3ylUNZI9LsD55FMc045sXaD+2eZZsH4jkuDNEugRRWLSnkfGlvUEdEZ9qh4SVABzSyiTEtnud9DQoAdzt1u02/FNAunRNNJKFSJ16TQbJnCmVhTFclM+bcYlOXzt5jwjcR8zUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ilNKspfy/pRmgCzjGjyHNEFrTZcv32S3gZqtwmpMjHQ=;
 b=N0FrinAtApum6OBAhVusug4/ubVjbvOET4ibD6Lt+IwoIBuKdAXYcQzFLlVLXqKD+sixUb7CmQ1Z/N5qyGHKDFzAPe09g9DdDCt/DS0ZqAHPdv4qB2YZU7gmi3xGtuOR8TFJYsdjTsZpyLDBwQV6Yj41UnYov37n2x5jcEvhlaE=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN4PR0401MB3583.namprd04.prod.outlook.com
 (2603:10b6:803:4e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3021.27; Wed, 27 May
 2020 13:54:51 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3021.029; Wed, 27 May 2020
 13:54:51 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     "dsterba@suse.cz" <dsterba@suse.cz>,
        Johannes Thumshirn <jth@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <jthumshirn@suse.de>
Subject: Re: [PATCH v3 2/3] btrfs: add authentication support
Thread-Topic: [PATCH v3 2/3] btrfs: add authentication support
Thread-Index: AQHWKdGCuxq5LET6vEqLmo6XtFxQPg==
Date:   Wed, 27 May 2020 13:54:51 +0000
Message-ID: <SN4PR0401MB3598593BC0AF9909CC1986889BB10@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200514092415.5389-1-jth@kernel.org>
 <20200514092415.5389-3-jth@kernel.org> <20200527132428.GE18421@twin.jikos.cz>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.cz; dkim=none (message not signed)
 header.d=none;suse.cz; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f1f420fe-b68a-4a76-a584-08d802458755
x-ms-traffictypediagnostic: SN4PR0401MB3583:
x-microsoft-antispam-prvs: <SN4PR0401MB3583A92B0B254E910812B6EB9BB10@SN4PR0401MB3583.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:5797;
x-forefront-prvs: 04163EF38A
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fctiC2S0pPDjH+hSPJ6S7I0ufLLm0fRgzqg5vCM1Wy6QRiv19/uYf7hfEDids+/3t1hxPpeQoznOpedDAdSpSBHWFfHetx9mdFeB6TqTi/4mo+yg+960Ee0l6x7sVrb1nJPEj3eGTQfUGdBBytTkwNZxKLF34MOxLJ/AsKXhBunpl5I8m2DGQ0+Mgy3kUINObpgL9wXy1vCTz4Trf9btAF5ZB8NufwX7X5Q2h8we5fpm3UyH3lrFaflARpdhjD/20ZgpqVNIO29zaCsgWmILNskcjl5GHBcWql8iJDfw/HXGyyUbG8PhV9jnXg5mbftn7R18XzdbQWtmNIay16yLnI4btE0G+MkCNWPf8fsfjPfFUVx6X/7aK2qMx2JyhgZN89xvUFk7NbERF7i69KIdaw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(396003)(366004)(39860400002)(376002)(136003)(346002)(9686003)(66946007)(110136005)(5660300002)(316002)(91956017)(26005)(8936002)(86362001)(186003)(83380400001)(33656002)(478600001)(54906003)(71200400001)(7696005)(4326008)(966005)(2906002)(53546011)(76116006)(6506007)(52536014)(64756008)(66556008)(66476007)(8676002)(55016002)(66446008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: uFDZR65wmkq5JPrTAWMpuxEhJSX6Kxk3Q/YLBp0+yIaS9zcFA8bkqFKZyMXlrDxzRmoVEX5PMVD2Mq82AcpqowyfwAEM+0xcdiSZYAigHfH9Y4/WTWPlXKwgBP0VB3fIZRpWIq72K/TZxeYzRJJz/IqKHbtg3hsGn5gQOX6GXIoIWezV+SEJoLesl7AedmCpZVeyVu987oJ5SuX5/nv1HJKg/O9q1azDHifFalGyJkS92J0MaIjK7Vgw40xhaEkQw7M8kB6gq3NNWXeltFV0NMJCO6cjVPaliKnwW7fLrnNtnGIn8f6jmMn6YRWJFLpV1JnWhN/jvzPWL/Wt6qmsZligGMGiHZ92NeQrGkb8Bg8xX2DjBJY0sOSZLfpWft5lVNLREvQX9pxyJ1P0hTvyGc89mSe/713a7vIZ1fEWw4QLW2XkBqMKK7/aVgQ0TiI45Hve6SIYLf4eO/HMII+fD0WjPNtqak4Fzl6jWv0z53TRN/86JjtstgZJRCxXtXoL
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1f420fe-b68a-4a76-a584-08d802458755
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2020 13:54:51.7772
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RyDqWEprt/nI+W9Nz5flS+hjKVnBot+wzlECOjEKzMhGdum29wH01SZUoqR8D8OXYxniSN/Moye1BuhTo1RuTR6GkSxvE+mHQy2CyloVyvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3583
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 27/05/2020 15:25, David Sterba wrote:=0A=
> On Thu, May 14, 2020 at 11:24:14AM +0200, Johannes Thumshirn wrote:=0A=
>> From: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
>> Example usage:=0A=
>> Create a file-system with authentication key 0123456=0A=
>> mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk=0A=
>>=0A=
>> Add the key to the kernel's keyring as keyid 'btrfs:foo'=0A=
>> keyctl add logon btrfs:foo 0123456 @u=0A=
>>=0A=
>> Mount the fs using the 'btrfs:foo' key=0A=
>> mount -o auth_key=3Dbtrfs:foo,auth_hash_name=3D"hmac(sha256)" /dev/disk =
/mnt/point=0A=
> =0A=
> I tried to follow the example but the filesystem does not mount. But=0A=
> what almost shocked me was the way the key is specified on the userspace=
=0A=
> side.=0A=
> =0A=
> $ mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/disk=0A=
> =0A=
> "0123456" are the raw bytes of the key? Seriously?=0A=
> =0A=
> And how it's passed to the hmac code:=0A=
> =0A=
>  gcry_mac_hd_t mac;=0A=
>  gcry_mac_open(&mac, GCRY_MAC_HMAC_SHA256, 0, NULL);=0A=
>  gcry_mac_setkey(mac, fs_info->auth_key, strlen(fs_info->auth_key));=0A=
>  gcry_mac_write(mac, buf, length);=0A=
>  gcry_mac_read(mac, out, &length);=0A=
> =0A=
> Strlen means the key must avoid char 0 and I don't think we want do any=
=0A=
> decoding from ascii-hex format, when there's the whole keyctl=0A=
> infrastructure.=0A=
> =0A=
> The key for all userspace commands needs to be specified the same way as=
=0A=
> for kernel, ie. "--auth-key btrfs:foo" and use the appropriate ioctls to=
=0A=
> read the key bytes.=0A=
> =0A=
=0A=
Hohum?=0A=
=0A=
Here's what I just did:=0A=
=0A=
rapido1:/# keyctl add logon btrfs:foo 0123456 @u=0A=
1020349071=0A=
rapido1:/# mkfs.btrfs --csum "hmac(sha256)" --auth-key 0123456 /dev/zram1=
=0A=
btrfs-progs v5.6=0A=
See http://btrfs.wiki.kernel.org for more information.=0A=
=0A=
Detected a SSD, turning off metadata duplication.  Mkfs with -m dup if you =
want to force metadata duplication.=0A=
Label:              (null)=0A=
UUID:               56ae43ac-f333-4ed4-933a-356aed534115=0A=
[   31.005743] BTRFS: device fsid 56ae43ac-f333-4ed4-933a-356aed534115 devi=
d 1 transid 5 /dev/zram1 scanned by mkfs.btrfs (241)=0A=
=0A=
Sector size:        4096=0A=
Filesystem size:    3.00GiB=0A=
Block group profiles:=0A=
  Data:             single            8.00MiB=0A=
  Metadata:         single            8.00MiB=0A=
  System:           single            4.00MiB=0A=
SSD detected:       yes=0A=
Incompat features:  extref, skinny-metadata=0A=
Checksum:           hmac-sha256=0A=
Number of devices:  1=0A=
Devices:=0A=
   ID        SIZE  PATH=0A=
    1     3.00GiB  /dev/zram1=0A=
=0A=
=0A=
rapido1:/# mount -o auth_key=3Dbtrfs:foo,auth_hash_name=3D"hmac(sha256)" /d=
ev/zram1 /mnt/       =0A=
[   65.959465] BTRFS info (device (efault)): doing authentication=0A=
[   65.963204] BTRFS info (device zram1): disk space caching is enabled=0A=
[   65.964137] BTRFS info (device zram1): has skinny extents=0A=
[   65.964912] BTRFS info (device zram1): flagging fs with big metadata fea=
ture=0A=
[   65.968302] BTRFS info (device zram1): enabling ssd optimizations=0A=
[   65.969551] BTRFS info (device zram1): checking UUID tree=0A=
rapido1:/#=0A=
=0A=
