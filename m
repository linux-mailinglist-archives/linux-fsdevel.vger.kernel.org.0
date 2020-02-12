Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77E6F15A2BD
	for <lists+linux-fsdevel@lfdr.de>; Wed, 12 Feb 2020 09:05:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgBLIET (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Feb 2020 03:04:19 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:62694 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728250AbgBLIER (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Feb 2020 03:04:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1581494657; x=1613030657;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Kt3JKOUEwrvla7LIVfHidOGXAAenYxYt8ZT23z2+0mU=;
  b=b//oGb6R9ypBx1Ybv5+FVuE37PKPygO6PofGOw3exbP3tlh7r+VW+a4b
   PKdtsNyB3z/mv/WZ/IYgKl2uL2ubjeuNtO55l/Wh/G2VI4HwTJa2u+AYR
   hq2RLp3sL6Ul/eFCtESXBiHBMguVFs0FIOHQziy6LjIhyC/Fuwwcpn/eB
   eHGYiFgY2/KyMJuF9ExupXCKgqCdQt9pf1XoucX4Q+Slfzini/LuJybqf
   oIUUcODRslyMEK2ph0nGm8qOTdLvAJ9bOgavJADi9ds3tzmc56mbqL27L
   HyQegimAgZG0ppQD/aLjGJx/CiyvRbJzhCGzuWWVF6IJBXNj/fX/nYn1Y
   g==;
IronPort-SDR: W+Kt0Con4FmWSqA7owsisTwSgxNYwT76byZnk6DJjF0v0RSW/rnMtomCy3G71ciwTMIdcd3EJO
 yCzndI7980fzfbJ6iI9+RYITJ7WcTOkszQR+M/XcTHguvr5Mfc2W8bUVioU4gWVbOwIj9QKHKn
 1lF4poCNsVMUMAVGtwnI3LvP8Es2Fsli8E+OzihOSKnx5j+5ZDyazAAMH8opOBZY+Q98NOw1x9
 b8chj/DLdxhBXYrbXsgi728j27E2SDYKowT+dHc/5g8beQz45je7IXPnypKUR/TaNVzYTcRswW
 sUU=
X-IronPort-AV: E=Sophos;i="5.70,428,1574092800"; 
   d="scan'208";a="237671218"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 12 Feb 2020 16:04:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eGaSXk9hcypX82tG22NZ0r2AoH8UjrdCa60DgSmI/CatDpmP3Dp9SiDbarHrJlzHXKhf/ZqgYdleVOgWyp6T0d1T9ELv/EAjV2QfniZc9zBij+JgawqltqGdJs+Ag5jtFDZJhS9ctTynoAN3kZZ+FS9s3VyJshnilcjXD65Uy5NUTmQQvrP+2x+UIx6ZI7jvfrUeqwmm/HMj1FMGsDab5Q0Vrfdfct6nX4p0AKuwbmqYAvhxYl6BZ9YuPRorY2cFV7T1vxNX4SfaXebAaH9bsQYXGGPwOpoIXkvL0tv8A+v968dTIk0dp8g0XmDn8mRWL0Lh0N5PCrD+H5fL0ewE3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfsMtqXu2KKLwlm5U/C4UUOKHCkEAHAit7zMYHSDu0A=;
 b=E1IdXFk4EWpublkgA2cyQXnIiSYh/LK8oKny2CTF0VQZQiiIhLZ/q0dUPYUCfigilDUE2nemX+VFTg8p01rJ1Xf2abFn/8oDzHgqPSgda6PT8rWP2VfIuq74Lr7vKpulj9V5u9eWMACIvAo6cVmz99PEv/hH4wbKfN/mscylh9cZnUlSXY6bAQz6K+Gb0RnIJAR7fPfJUo4rlzBhVqOT4PEaYMMoE56Z+wRe4RqtsySr+YtTKhgB/ovVJR++HJvrI348xMrvpjP9yKQ/zBQM3TW1MspqkJ/px6HRA2+9wlJOKO2ksQlgzY3D7GcEZ2HKNQtxMAF5F39+zeYu0vdBjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vfsMtqXu2KKLwlm5U/C4UUOKHCkEAHAit7zMYHSDu0A=;
 b=aqkeNRXJRpyawVfm/AC3hxTjr2nznOdyVUjZ1iYEfcumg0VYI1h0BJnAf9rewttMeYEmlXxoRIukSxrUUMt2P+NTox+Om+LdwrkIGu35In8EoXeyBdJQbus0Swu3hB2VrAUQbt5DcEzkfxoJWLqZh9rqvtzY8jHRQv5z1WkK55A=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com (10.167.139.149) by
 SN4PR0401MB3680.namprd04.prod.outlook.com (10.167.150.12) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.21; Wed, 12 Feb 2020 08:04:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::e5f5:84d2:cabc:da32%5]) with mapi id 15.20.2707.030; Wed, 12 Feb 2020
 08:04:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        David Sterba <dsterba@suse.com>
CC:     Chris Mason <clm@fb.com>, Josef Bacik <josef@toxicpanda.com>,
        Nikolay Borisov <nborisov@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Hannes Reinecke <hare@suse.com>,
        Anand Jain <anand.jain@oracle.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH v2 07/21] btrfs: factor out gather_device_info()
Thread-Topic: [PATCH v2 07/21] btrfs: factor out gather_device_info()
Thread-Index: AQHV4XUFm+xFvpD6aU2Aln1ZtGHtzw==
Date:   Wed, 12 Feb 2020 08:04:13 +0000
Message-ID: <SN4PR0401MB3598EA79D1908E1150692F529B1B0@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200212072048.629856-1-naohiro.aota@wdc.com>
 <20200212072048.629856-8-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=Johannes.Thumshirn@wdc.com; 
x-originating-ip: [129.253.240.72]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 44bd53a9-827c-4ab6-c0c6-08d7af922648
x-ms-traffictypediagnostic: SN4PR0401MB3680:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN4PR0401MB368070E59D60678E73D649DE9B1B0@SN4PR0401MB3680.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:3826;
x-forefront-prvs: 0311124FA9
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(4636009)(346002)(366004)(39860400002)(136003)(376002)(396003)(189003)(199004)(81156014)(81166006)(8676002)(478600001)(26005)(4326008)(86362001)(186003)(33656002)(2906002)(6506007)(4744005)(7696005)(8936002)(55016002)(53546011)(9686003)(5660300002)(71200400001)(316002)(76116006)(52536014)(66556008)(64756008)(66476007)(66946007)(110136005)(66446008)(54906003)(91956017);DIR:OUT;SFP:1102;SCL:1;SRVR:SN4PR0401MB3680;H:SN4PR0401MB3598.namprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KG0+8RdyYsdqwmVV1AKjtPoZ+IDyTMFACtYZVHbyiQ2F9HcEMpPLhfzuBIwApM0XVuRwD+t8AtBHNOpSzxHr/Dvlhduzu+9oDLJFWc2KU+gkTBoJWJRNP2/nRth2kRo6w9rLU6DMpS9rvkCUw+29IXciSy5hJVHgvU9LDeuz3CKHxjMZSa1iohEPoZcUT53HVECicFRKmcPO5vDPcEre16V+wkEug3Jnhq3gRC/9UPvY3i06PNsRWSYZI9TSPFAZt/LJW1G2NHkicI1yrt4SD+Pb1+HpESqvy75rhmqqluFHf6jX24eSWneoyBFts0skU7Yi5YQ/03MyfxmGWdGjOLs16HzabAfcKVehg0bALkW4n6IpI5pUCqTicnn62gQ1tNTcz9JPZBgi6dkzW/w7FLeZ+IRomHkssD+y1j7Szf6L+VQcSOeGZhyhta8pEqkB
x-ms-exchange-antispam-messagedata: lXUpEBhOPTqF5OukD9iLK1woct89gWDFXIdVUzWmQx8txUWMse2Az7egOb3Zlj+pDtXoURK2Xn4wFB/yN+seFC4n7dIZTHm+o/UJH6hdP0vr8JmIBqZ8v5q4rxELpwlPSXkhxRJ2vcv/4bv/B+WVAQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 44bd53a9-827c-4ab6-c0c6-08d7af922648
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Feb 2020 08:04:13.7793
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 62dAkX5lxCzepIZ+twIIMYvksQgqIr5CbnoJB25yn+oUuuDyunj4TbYMAomkcLMw055Z+s7WlzmnG4uvfaCQDkeHvoW16n3cksIPcgUC66Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN4PR0401MB3680
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 12/02/2020 08:21, Naohiro Aota wrote:=0A=
> +	if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {=0A=
> +		btrfs_err(info, "invalid chunk type 0x%llx requested", type);=0A=
> +		BUG();=0A=
> +	}=0A=
=0A=
This could be=0A=
=0A=
if (!(type & BTRFS_BLOCK_GROUP_TYPE_MASK)) {=0A=
	btrfs_err(info, "invalid chunk type 0x%llx requested", type);=0A=
	ASSERT(0);=0A=
	return -EINVAL;=0A=
}=0A=
=0A=
as well.=0A=
