Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9280D203B75
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Jun 2020 17:49:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbgFVPtJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Jun 2020 11:49:09 -0400
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:26489 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729222AbgFVPtJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Jun 2020 11:49:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1592840949; x=1624376949;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=MFaRizNlIYX8EZ9E3dNU//eUmFiXrbsgu7yyOCV+DPo=;
  b=SuYNnqGpjnAoszdZ0TnCyRK50LHzg2vDwIpannhjsnt4fv2T0iV8GRp1
   /alLVhCYwPleAne3eDTH2+h4sJE3v9ai7p9WdQd8R44L2UuxQKlbWebQn
   rBvsxjRKqC0rNXF7G8O2EjCAjwfb6xlvuoGs4cwlI4T+NAmqgDlp3LpYP
   JSu3S3cQvnb4TAY0uPd/XEbS8FCaREq6K3AiXOK40vRbg8MwGmVgPnXdc
   e2e76RJYZGUJ2hpHQDP/zPWyT0TZbrjG2mbPrV4XR6FMhK7AY931iK5Yz
   wc7XGvIP6RzyASivEua6UxVcyKoYUMsZNH4SNbOlak14xH6cdpyWIAsk9
   A==;
IronPort-SDR: Lb8Hq2otivuURK/UkKjpGmHq9sK5XwsCrG19qUpPXlEg7NkrBrGX/EZCM1lumquH2M5iklKJT+
 /CaRbds8pDrbqZt9jl1qPcoB4BgsVrzLdqG+3jrttyWvwQSoygtdp9N9PCla55VyDKTfvUBi+w
 o2kfUzRos2eWRmNDjKcD6CdB1mAcdHj7JRvrQmdIl/51ynQ4gfAbtcwqSbHALRtXA3Fx6/rGxj
 ywzOSvF54FqWzsmgzRktv9kkZOchyQ1C5u9dt4IboFLVNFiveb9rVVnFd+HaugtKrvLLwpbJ/b
 BiY=
X-IronPort-AV: E=Sophos;i="5.75,267,1589212800"; 
   d="scan'208";a="141992554"
Received: from mail-sn1nam02lp2059.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.36.59])
  by ob1.hgst.iphmx.com with ESMTP; 22 Jun 2020 23:49:09 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oMfluJzlHO+8D0eui7J7iEkUA/XQKIYhlyQchG1wepqk1xUMz+FE7ZfjMdEpeaG2gQDkCf/jasvxXQgJI2o4uEItw6yC5kL/yi9J97uPEy3nGN//2i1oz+ay4ni1Bw7GovaDWdFMX5IKuTCjv0KVG73Gvlk//7dB+BdBe1H0u5lV0IAruCkjfLhPdhZS3EwwdpncxnlNcKD1O3ZKCnKL4+z/0eUjUhpwbqaXbtHzGzwSnHUtYKfw17abP0X4D9Tx53jvpImwjroVH/yicNLSv3cD1a4uC8H7Ws5sl5rLAYX/0j4L8oxEU8hq+udRnjCA5VMmNDU4Z7bSCcWQLuDR6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX2E3G8Rxv3dQw2NUEUKda9l6I3XAmCs7Wmt5tavGsU=;
 b=SVZT7ns5x2wVuDiI3tRV8CAZoRc9hcwquzkAaONU5hDzcZ4zwY/WB8ij7r4eFi2i27sUH6IjfWsc4DU37pEh3/d7zbBu8ighMxQjxK/bWgT86p3+l3WOq4xjMS5tSyVZtGmm6yxDNnP1yj67nnFVANS9hX90Yo8HJgEP0SnScCDmjyutaGnWKvGfiayubGyYi7TFPMKirJppFe7NgNdAWq+ARibzDJRYncljver3LSe6eRaUjKFK15//gf4BrHljGWo9P87y+LvFfcW8C4vf0ggqseZd6I5doKjGmSh11HJw5sco6Ga7DUlKHnqCaCBUjBfbShg77wqI4bGrLzwscA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LX2E3G8Rxv3dQw2NUEUKda9l6I3XAmCs7Wmt5tavGsU=;
 b=LhA1RtJa3wZhUuoHNrnSDXNMscVuHpVZ+ju56NVWlmikzYDea2Rd2W7wCYhRZZ0ttiTTs7oW5Nj9w0WMMNWkU2N+srdzD8veJ5F/DnyKH1VOnPDz7veAhKPcep8By3CZA9uuMpvgZg02k+vEK5ITXSz0MoHleVNlci2TX1so1BQ=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4864.namprd04.prod.outlook.com
 (2603:10b6:805:9b::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3109.22; Mon, 22 Jun
 2020 15:49:07 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::1447:186c:326e:30b2%7]) with mapi id 15.20.3109.027; Mon, 22 Jun 2020
 15:49:06 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "hch@lst.de" <hch@lst.de>,
        "darrick.wong@oracle.com" <darrick.wong@oracle.com>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "dsterba@suse.cz" <dsterba@suse.cz>,
        "jthumshirn@suse.de" <jthumshirn@suse.de>,
        "fdmanana@gmail.com" <fdmanana@gmail.com>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: Re: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Thread-Topic: [PATCH 1/6] iomap: Convert wait_for_completion to flags
Thread-Index: AQHWSKlc0noxJoz88k2OjaGRtfck+Q==
Date:   Mon, 22 Jun 2020 15:49:06 +0000
Message-ID: <SN4PR0401MB35985FF9FCEA5AB02017FA399B970@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20200622152457.7118-1-rgoldwyn@suse.de>
 <20200622152457.7118-2-rgoldwyn@suse.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: suse.de; dkim=none (message not signed)
 header.d=none;suse.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1597:de01:e494:6330:3987:7eb6]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 77d599f3-f131-4be9-ad96-08d816c3cc01
x-ms-traffictypediagnostic: SN6PR04MB4864:
x-microsoft-antispam-prvs: <SN6PR04MB4864B417BA68E57B96BF8C239B970@SN6PR04MB4864.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0442E569BC
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MwbA1w3rTVft0NxMtsZQtiAumfq179gMljuVr4Kp6DVIpiyRB3qnb2gOAwenhAlyfMewrD6ILB8toyYrI9Px5qvuVj7QNuHWq5ltEyyzrlg/WQe3Fu7BsCj2gx60fs5nTbQlXxxjmoTtzXlZMp+ehjpi3k0UD9pfFQns3GOwHhoX341DcMjjUEVG02zPuGZA14LaNc8KZrrs/IIB9hz0Ld1xRBt8qFL8hiT4Q5YfCdifwnIvan42zVKd4txvOqSBqfVktHFNxV/iyQpt8TR+oWLhDS0X+dMN0/AvDrWnOpndKI32O3Lx5EMCGITur3z/oR6cBMv+WzbKF66V3GafFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFTY:;SFS:(4636009)(136003)(366004)(346002)(376002)(39860400002)(396003)(33656002)(8676002)(53546011)(6506007)(91956017)(7696005)(76116006)(316002)(66946007)(66476007)(66556008)(4326008)(7416002)(478600001)(64756008)(86362001)(5660300002)(66446008)(54906003)(110136005)(55016002)(4744005)(186003)(8936002)(71200400001)(52536014)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: mu0gynD4qyGe4d1K1WTEFje9Gx/5Ra/9VhkGSRMN5bDjJscfW2+kVwhnSd81yK02TqlsENsNVhjuYVf2ijoN0Hg4qv4VfK2TB6WW17IGBsZpEj0vCwyxLe9h0BQqJzmoH/uj2H/eKX3yqfgWtDUd41Qp9xyMjvULC+Mak1nsa6GoPwx5mHWN7XWXapm8pLvYzXpquS5UkedImszcsX/Q3ZPeOzpjnpiAckSMIIIm+lga0eJZEICRyGFIGuwMyYqCw69HvgwdLCITzmsK3Hf4ZKBHF5O5iWalZJ3PrnZRcxIx/LcoQGj5z26BPIp973FPO1/TO518A+4w4CbdkotCkt8X7qABCr/SoI4/kMm2NLqhR4U0q1DsVPNdoeQg6yLXAVR/Xnax76JdypCVm5vh8ovA0/dLCTch4xJU6boLWCea1rAodYOsw82XKLPd9yeGB3v0bBEU7Iy+yw6z3ZWTJ+huRVI/fJe/g45lAMj4q3yO6l7NBzMCRbHJ7K9QMnQ8pPAOgL2b2VgMUdfSrNwBFTrG1HUbtUKPEerElLTuAfV7EWHVSwhyVCIP2gGj3lVZ
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 77d599f3-f131-4be9-ad96-08d816c3cc01
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2020 15:49:06.8289
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: b8TQmkYcYOPAUUQoE7Dc+fIlx3S+obwlefHf2TPOmkxMvQ9ccdsD7Jwu+h5jGHKC4fQlO5s3Zw06MuzzzoZyePMIrcutInA1ngtDte5gXUw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4864
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/06/2020 17:25, Goldwyn Rodrigues wrote:=0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index 07bc42d62673..88dc5aa70d1b 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -715,7 +715,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *io=
cb, struct iov_iter *from)=0A=
>  		ret =3D zonefs_file_dio_append(iocb, from);=0A=
>  	else=0A=
>  		ret =3D iomap_dio_rw(iocb, from, &zonefs_iomap_ops,=0A=
> -				   &zonefs_write_dio_ops, sync);=0A=
> +				   &zonefs_write_dio_ops,=0A=
> +				   sync ? IOMAP_DIOF_WAIT_FOR_COMPLETION : 0);=0A=
=0A=
Not a huge fan of that construct above but for zonefs:=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
