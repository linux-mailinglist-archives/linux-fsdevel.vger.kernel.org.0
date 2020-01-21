Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B1143751
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jan 2020 07:58:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726052AbgAUG6Q (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jan 2020 01:58:16 -0500
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:1589 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725789AbgAUG6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jan 2020 01:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1579589895; x=1611125895;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=6mGzC0DIMvynhQWljmjzOPDH6hOQXE+2lyJIgnegpf8=;
  b=bBarno5tJXg8TDpoeUhOa40DVts5pDppmB+V4GnxtSHWroPN1TbOMgWP
   /xd7W9YjOVKDhdIKDcDpz8b4BG/va2jX3AdGM2jCCDFUFDF1NpHFdYqZW
   VBvbD2gMQH4UO7n93j5oFHM73qhUCDf8E46qE+dQ+lbGxYaasG8TCpyOJ
   01VVLinERucS4PxnbYhi7DXBIjXaVoWXUhW7ZQe7vKsADiu0X3dunk+p8
   4TbZ3VTko3dBYDwXngfh0XaTbRfsVIdbX60uecFn69AgctSZvJ3zeneYL
   RDalxe5CU97RP8c+z8HM1Kho050q7P8RZxlesauHG2hiIW1nls5hIkXiw
   g==;
IronPort-SDR: PMyx0TvXCY58uOlBNz2TDb/oi69iYdcoBmijK3L/dEJJmXJjxn3cRsSREyPwYvSBal+ea8s7oW
 eykbRSDn6U2tp3Dz4vbFSX33Eta8Rzreose9C3Qwa2LeDfaSaA+28api2CYiFhCL4xWNs8qUD2
 JvAvwkDWbx1k3htH3lzbY4b5TBzKl90zqigz5gh9fx09zdD4TWBWvK9T2su+LR5f6TXjxwR5eJ
 M3j8T+9QdRps0VJpAR6Def8r0kSL5G9gzfTcd3HkH8L0oRRrEqM7KCVAone1VeuIueUVkPNto6
 TJM=
X-IronPort-AV: E=Sophos;i="5.70,345,1574092800"; 
   d="scan'208";a="132430040"
Received: from mail-dm6nam10lp2107.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.107])
  by ob1.hgst.iphmx.com with ESMTP; 21 Jan 2020 14:58:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lf46RDVLCfPXonpRR0tN42dekaipWZmb1CW/GsGvY2hi3Ntcsx6l0pQUTxVQTgkWBIMB2uN0sota9qL8ykMEpJ4NJGbVZFqqm4orWIjYLKvkv4MRAKY50TMb89GcSOh2fHaxTYZN+kfnTRQ2ChCEPPbZHVX2GoM4yKfxDwTeNY2J4vq32iJluwUC+PJiNhXdUcr344NT6zhsUQ/LujYd7ZthTTNrGEq1MrG4xNz9Y0FGgIBjrtFs3S678iTCC2P1Nqw7ityD5OuYaElIyY40bZs9zoPvFXr5roezU/Q97Kc5yf67Pz4qWervRc3K37to4KsMaBQsFv4V866eMHgHqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcQt3wlkgOb5tEhYJmuNDa+6Rc798wnC66UC3XDI560=;
 b=Q2FpUou1vZFlJtvFD4apxx7IQr0Q7oM8WnwTTzEtyUA2eJ8H7R4SPEk0QyXJ3z7MIZ8HYl4QEmA5qlbJZlmozg1AlFLHZt3iIGO+4lbDoP806GbbtT4pLkUAlYXJhcOSlqBMsf5vdnZaY/+ULtEkoHQgTYKT1bf1H6ptuQcmFQ4hXKHHSFtuujFx6CG/lJlBnkxRfnRtQE02kd/Px4ymWmr0PEGZfgn+wUplDjH4kw+WUkb27JSfWciVGdU0S0O2j4oJlK7NgSt4CIpw0ptEythPbRYQfYPLhGVnU0Mz7i91S/mZJqsfabGtqZTsipMJF7kW+KdEUygyWzDm1JDddA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VcQt3wlkgOb5tEhYJmuNDa+6Rc798wnC66UC3XDI560=;
 b=aPmxBK2v5wcoGGC+cft/f51M/NzfhaATYeyQndeW+Jk5Xjn/HKOkYkslGYZQymgf2QvV6bDXwSShMWpSvEFgxBFpY8r+ADWplAWCW9BzF+XT726R/yACH+70IkbCQ/+f3hdXpxUyEJ1wC80l+7KUYGOApSUG6I/trwtXJ+SJAO8=
Received: from BYAPR04MB5816.namprd04.prod.outlook.com (20.179.59.16) by
 BYAPR04MB3910.namprd04.prod.outlook.com (52.135.218.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2644.20; Tue, 21 Jan 2020 06:58:12 +0000
Received: from BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61]) by BYAPR04MB5816.namprd04.prod.outlook.com
 ([fe80::cd8e:d1de:e661:a61%5]) with mapi id 15.20.2644.026; Tue, 21 Jan 2020
 06:58:12 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [bug report] fs: New zonefs file system
Thread-Topic: [bug report] fs: New zonefs file system
Thread-Index: AQHV0CMvDpp6pQyE70Cu9h7L05oJ2Q==
Date:   Tue, 21 Jan 2020 06:58:12 +0000
Message-ID: <BYAPR04MB5816CD0A636F4AECA76540A0E70D0@BYAPR04MB5816.namprd04.prod.outlook.com>
References: <20200121062025.gqkfye2wbk6la7wr@kili.mountain>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Damien.LeMoal@wdc.com; 
x-originating-ip: [199.255.47.10]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 56c3c1a0-5c33-46bd-e299-08d79e3f47e7
x-ms-traffictypediagnostic: BYAPR04MB3910:
x-microsoft-antispam-prvs: <BYAPR04MB3910D80AB54060336B7E25F2E70D0@BYAPR04MB3910.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-forefront-prvs: 0289B6431E
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(39860400002)(396003)(346002)(136003)(366004)(376002)(199004)(189003)(5660300002)(316002)(52536014)(33656002)(55016002)(9686003)(66476007)(66446008)(66556008)(478600001)(76116006)(66946007)(2906002)(64756008)(26005)(6506007)(7696005)(53546011)(8676002)(6916009)(4326008)(186003)(81166006)(81156014)(91956017)(8936002)(86362001)(71200400001);DIR:OUT;SFP:1102;SCL:1;SRVR:BYAPR04MB3910;H:BYAPR04MB5816.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eeTZHKiAXvXOR73+z9zIuwIknCm4iD87zMxxRx9WSxL9cXFmPCNeCFJBgZXB1oKglAmgK/70xiI3l3JCRIBH3islrasfdIfRXtK1y+zG15pLvzbggyWd5OygL1QSdaP7I5YHKo/k+qaan9KoqjNbnCVErFtxTMzwk2WHV9/9QLfgZ6rp7bu+8uCa7DCp4X2+MfCLPocWfcq7Fhl9v1kt104CZJmirEUGmvJSNfHfV28+VCLLBnHwgjBOt9q3dED6Dd6N4EslwgpUNDX0wQluP/2B7+kaahItzj+2rHBzANuD0a3rF284mZDmENCdkGNjSau5aiutqUmkuCbg2ImWGZ4hIoKwmygMCUr9cVSguxlDNzZ/5RY2pPxonsc4VVf6UuxrkdKE2OT3t1WN/Fr8p7Rik01SM0Tz8AM7MdmPLM2qaVFg2GdpUeDYy+ERpt/N
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56c3c1a0-5c33-46bd-e299-08d79e3f47e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2020 06:58:12.0173
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5bq7FYhLqPtlziD7D/w/ZHPNzUA7vZrwnqavfoSmlTJQwvhiG7iVfLoTkRHS30jCGOY9htcVFHkzuHdCSqYzcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB3910
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2020/01/21 15:22, Dan Carpenter wrote:=0A=
> Hello Damien Le Moal,=0A=
> =0A=
> The patch 5bba4a0d475a: "fs: New zonefs file system" from Dec 25,=0A=
> 2019, leads to the following static checker warning:=0A=
> =0A=
> 	fs/zonefs/super.c:218 zonefs_inode_setattr()=0A=
> 	error: should you be using S_ISDIR()=0A=
=0A=
Yes, that would be better. I fixed it. I also caught another warning=0A=
with make C=3D1 W=3D1 for a set but not used variable. Fixed that one too.=
=0A=
Sending a v8.=0A=
=0A=
> =0A=
> fs/zonefs/super.c=0A=
>    208  static int zonefs_inode_setattr(struct dentry *dentry, struct iat=
tr *iattr)=0A=
>    209  {=0A=
>    210          struct inode *inode =3D d_inode(dentry);=0A=
>    211          int ret;=0A=
>    212  =0A=
>    213          ret =3D setattr_prepare(dentry, iattr);=0A=
>    214          if (ret)=0A=
>    215                  return ret;=0A=
>    216  =0A=
>    217          /* Files and sub-directories cannot be created or deleted=
 */=0A=
>    218          if ((iattr->ia_valid & ATTR_MODE) && (inode->i_mode & S_I=
FDIR) &&=0A=
>                                                       ^^^^^^^^^^^^^^^^^^^=
^^^^=0A=
> TBH, I don't know what the rules are with these.=0A=
> =0A=
>    219              (iattr->ia_mode & 0222))=0A=
>    220                  return -EPERM;=0A=
>    221  =0A=
>    222          if (((iattr->ia_valid & ATTR_UID) &&=0A=
>    223               !uid_eq(iattr->ia_uid, inode->i_uid)) ||=0A=
>    224              ((iattr->ia_valid & ATTR_GID) &&=0A=
>    225               !gid_eq(iattr->ia_gid, inode->i_gid))) {=0A=
>    226                  ret =3D dquot_transfer(inode, iattr);=0A=
> =0A=
> regards,=0A=
> dan carpenter=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
