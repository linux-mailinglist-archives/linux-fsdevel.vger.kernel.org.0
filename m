Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C300735E93A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 00:47:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348633AbhDMWrY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Apr 2021 18:47:24 -0400
Received: from esa3.hgst.iphmx.com ([216.71.153.141]:28597 "EHLO
        esa3.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhDMWrY (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Apr 2021 18:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618354023; x=1649890023;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=WQvf0id0oe0dkU0zaP/cvkyW7QNUJn/F6Bfr0L2ouZ8=;
  b=hlTEFl6wtJtcJRj37RFF8MmA7lsLMjwm2OZjuU6k5gHMukCDZVlkD3Ou
   Uwnmac8+4EywRR9gi9U2eEqXQQkdgM4OsEUAKtiUKDsvs60IPvb/bky71
   VmbK0nxWQhuDhtpA4rn6hvEuPlS9SsKusumRKDThW4YRe4zIH8AEKBhjR
   QGZ+PZIMfPl+3/P7UK3xy4HL+OxrgJNST2quwdYhuILKtW/B6H3Th7idL
   4w2PEERUGNaDcrfntopBTh9YLscStNPl5vovZ2IhAWKVglkWsD4jzoUJB
   TkJWPjG/VIc3ri4Fx9pWihrGqzp8n/YUughIe5hg36nuqTqclFtRyt7Ac
   A==;
IronPort-SDR: LSvxMn7Q1tPlpOaOwnh09gZjpStAApgyQvImyDsx8fCD2CDx4/gnxQblSJlZoJx09jmZveZYQa
 Wna6ifdUmZTOqRdDrn25gg7nX+j8mEkjVnR7A/UjjIrgfc6WXyEmsEUuUunS1Tp/fz/e9Eql92
 q8z8Tn/5j57TJ99Zs21RXZNMh5s56BHrJJxPKkmEGqn3LVQBU5KvxrQyeIXDRu+oQRn69pMpoc
 zvl5FQFKtB2BWYCAEX5ZxKuXcjDYBGqIkyI4wJnNMTC3VKQ0dqFxA1N4Xzs36my2QKR2skvCyp
 ZVo=
X-IronPort-AV: E=Sophos;i="5.82,220,1613404800"; 
   d="scan'208";a="169195750"
Received: from mail-mw2nam12lp2046.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.46])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 06:47:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcU7sfjPM/6q3CmTne096JW3foEgpMEgubUdv+HVafVS3VfOsTJCJ3c2+12oBy2o5pSUUDRiD1nlI8iI8ar8olA85ClMvDaEglS4bxtKusl3ViS5CgtqlasNGP9MJpU4zT+vGP34/0L316rgydavqB3nFr0vDAPu2WHcI++fMPCTTUtMOwj4KiWLzIVDzEL+m3vLaA4OuhJIN+LCgbT8070wYVIfLkIgnr7meGKBHCUMoqGRsUzHiwfdPbkk7WIWlcv8zr7VB36PFVkPOSHJ0Rd5qbMJrdoL3KrkXEtpuarZvGH95KQHVZQEpEZot9oOhpDZrRh8SwkF5oR8RzJJ4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBDaZqygqdjzLX5U6CWu+zMNbjnXtCyU3ivyoezghQE=;
 b=ey1XJ9vnlvYoFDKhli9zavLHqdj/R2aN4qCj4pKsZRO/0TO2yU3ZIWOW2Nufl5gbXIfQQn06JzDnvA/QBFluYO9vzyefOdM1VB6Tg1JYQN2jEajsW6eHkBzR80am5h/oLPyn0YyRiqcFTL0XTu2uEd3LIISGpVGaWjIiSUy//nQdw9HjqiwrA7aUpoLAqGGYOEZX6s1xDKbCwFxtjjHpVm6ZIBREXWRPy8Ad+F7Bte6nzetMpQTxSY4TXV77swr9OkuvBAZ11xWq03uRF9oYQ7juRbQj5Lxke8tMYOBNnt3KpkkzUKVXP3QFUaiwYL3TpIdwvj4rm7jUMxAg1b1+ww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jBDaZqygqdjzLX5U6CWu+zMNbjnXtCyU3ivyoezghQE=;
 b=VomKaC/POr8DJBqipaov0RwTxEFLFvRkpGmvVY6q0vGYEvd1wWeSGBkyN2fpNd0LyGNn017wS/HE3J3NPz4e7tIHRmvo1lBrIDgk8E+xCG/rNccesjLUijOFMnD7qJ8JayDVDu61MlRNQZmemtZlRDujPZyHhsXGnQK2zkrGIwQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6638.namprd04.prod.outlook.com (2603:10b6:208:1e7::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.21; Tue, 13 Apr
 2021 22:47:00 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4020.022; Tue, 13 Apr 2021
 22:47:00 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH 3/3] blkid: support zone reset for wipefs
Thread-Topic: [PATCH 3/3] blkid: support zone reset for wipefs
Thread-Index: AQHXMLHm85tcS+eWOEqQhbH7M1I+dw==
Date:   Tue, 13 Apr 2021 22:47:00 +0000
Message-ID: <BL0PR04MB65141A1374C49EC06DDCCBB9E74F9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210413221051.2600455-1-naohiro.aota@wdc.com>
 <20210413221051.2600455-4-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:7d52:2cf9:7a90:aa92]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4e5c6533-22dc-4096-c6f1-08d8fece0ca4
x-ms-traffictypediagnostic: MN2PR04MB6638:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB66385AE7BD66757350F54902E74F9@MN2PR04MB6638.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:66;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KRYbcAY/p7fePzCV1u6710LmvJEOBVRfsOQ/cqhkfKuhCEKn8fk8CfIHJkcH9YgCWjIn2RrU7F23JbDdjrLr+t7yKqVjB7eBPdumxqwE3QKWVcxP5jFnCucbuaUh8VY4YGaS+MBNq/RdsxAMCkiuCP/eZLsOSwlHfg9x1h+qfO9GY+IeYp+fY3zsQuoJSV5C0HeyFCZ+rdpWKxpjE47y5u1iZNF6jPUY+oZ9mBF0I93YiLtE+925XJ5HqghM4shdvNvVP8QvRzicKvTOZBdVUZaeGgUf34wGcM4vFgQJ7S82NL6kG2AAyW6iLqcLO/Q+ChUyMIKo2HetqqCokZhbR7lE5tHDCR5o/whmP23i8vKhzNQu2p5880wdgFFSC6xvppD7wCtYEc8jlIRkRk+/myceqbauZF+pT3U1jPsWTTPjsO4SD2J6E5n5lojBOyBd1qa5Cr1GQDSUyiQbPR+dlaSII8Kk/OdCTF0j3v52mgo1ABX7Oi6ZVGKP5Hy2WNPoonJhkVVaUKaTFXcy7sCcGGTp5A788YHckzd74orHXDMH+7+w8aJz7BI07oWUx25SEnjXPLH337Xf4GfCx1i8g+QKQWSZGDc28IDqbyHwRcc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(136003)(346002)(396003)(366004)(376002)(4326008)(33656002)(9686003)(86362001)(2906002)(110136005)(55016002)(7696005)(6506007)(8676002)(76116006)(8936002)(71200400001)(122000001)(53546011)(186003)(478600001)(52536014)(5660300002)(54906003)(316002)(38100700002)(66946007)(66476007)(91956017)(66556008)(66446008)(64756008)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?NNVz+o+rdz6z4u6rp3UcnxWa5hDLKn+jMMC/8r83uXgljcIvZ47E4t7MNryJ?=
 =?us-ascii?Q?ew5YpiICkm7Kz83/URVGCruHkftFVmUAAM+LjX1KRt227Xrcc6IUFtZxnQIq?=
 =?us-ascii?Q?kdFJT9x1upNxYwBbVVE8RXPBj1vrLJehsgE/nadtoYUsFPUwyxUCJU4RnK1u?=
 =?us-ascii?Q?khL1JtA33Kivsytw8LK2Q3R0Dm0UuP7NLzvuX9p7vhSoDCjo/bgfoxZY4VfI?=
 =?us-ascii?Q?PkHxlpwneiDjrTjqvHV2US6ypIFRpDV2Q8rWRwB+CYSbm2PU6yab1UUJuLlW?=
 =?us-ascii?Q?lw9fVxNMAPKUos/Ab94xBdns05bFQ8kQrS8YPLPs0yBhUypipHDDZSMd+AHw?=
 =?us-ascii?Q?KU+vfgt4Ej3NhvRaFCTD9c0V33C0TSYq8mOL0a0RYkMnouZFgfIuI8nwGbu6?=
 =?us-ascii?Q?CcpoHyQn32+SL0uBXFKciG/WRMSuG5huiM/U7/wK3Yr5nzg+OjgV9S0ytEER?=
 =?us-ascii?Q?I9nVsMtxHoqTu+arW0qOP6P25Ef1QwTf3jL2twC0TAtoPZg8E4jrzE+xbwxY?=
 =?us-ascii?Q?diSDO0O8DfnjS8/QZ1be2/aVy4k126r6SEIG6iwXPjMT+vef0J6p6reJ2uPJ?=
 =?us-ascii?Q?7mp3AWavLpvx9A800l9kNNbZ0MIMHOmeLifYRtXDqQa3QAaZTZJXgS1jGFFu?=
 =?us-ascii?Q?ziBHvsW4luTaMCw1sJS72TT7GbTOdvCcmGOexgIgtNZvZkyMLKYjNiVrbXUG?=
 =?us-ascii?Q?fZ2vFMrg9+WwdTWJD2nB8x5yzoDmFn1Chq84E9D/Ap9ILkyNLFK382hOgsTH?=
 =?us-ascii?Q?n3esvH0F3bj9sprmjyNwQMiYqDWgGA4wdKJWN0j7b2adI/OiI5HkyElm+Sw/?=
 =?us-ascii?Q?VwRhI2+atOEtkWf//6RvdKnIJqrY2I5vb/WgaswYeJc/i7G23gIhqwjKPWAK?=
 =?us-ascii?Q?AW5BoSPjEE+96DdYlUKq/nojLpuxE9Sva7zDgsZNuCKoSY4vnfYJIr4Yi1dq?=
 =?us-ascii?Q?76yjKySfuzE139HDlFu3im+Utwr4YfpCHxM8VzMUarOypnbsrmfeq/UwSBqd?=
 =?us-ascii?Q?R8SMmX1A/3Wys7yp2hO/PiOZLpMyLKbDPyNFVOrAajdQBuGkrCDaRs6w15zi?=
 =?us-ascii?Q?1xIkuqDq3NVCERmY12MEcRX090t1XJoGX22RtZm36v41nONzKgib5459dX6G?=
 =?us-ascii?Q?wX3cpjADak8Tb5Gi128K8fIiubAmuQDAX/xAyAUdYxtvYWEJ1TjhB6IjRoZT?=
 =?us-ascii?Q?I8HsPGrLZSwV3zYLsTd9lqTOYjj3xk798N3qe/gloqhqN2Zpcn6DARrpJrzo?=
 =?us-ascii?Q?TT03Dk5DEN1rdDjb9+fdhpufu9UKS2v9LquanU/6ZxrMm1eEgqHpHgymMujA?=
 =?us-ascii?Q?dclimjAjfVfMgtsYwZBYHkpIWmAkIgEiKKT34P4oJrJQmiqMrv5rtjZ6/xBI?=
 =?us-ascii?Q?mHLuzVG+aVzQOsN3mJOASGlCXGTu4DP1pQXhXk3yYvFuDTqcGQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e5c6533-22dc-4096-c6f1-08d8fece0ca4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Apr 2021 22:47:00.0504
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: r0uWE9qSaRfxKmtmMqBaN1q0BpuE9pnrpyeUmxQpyrFboWOIXCranmv3p3DEZSqubGAO3rA88MEReXJlHpca5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6638
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/14 7:11, Naohiro Aota wrote:=0A=
> We cannot overwrite superblock magic in a sequential required zone. So,=
=0A=
> wipefs cannot work as it is. Instead, this commit implements the wiping b=
y=0A=
> zone resetting.=0A=
> =0A=
> Zone resetting must be done only for a sequential write zone. This is=0A=
> checked by is_conventional().=0A=
> =0A=
> Signed-off-by: Naohiro Aota <naohiro.aota@wdc.com>=0A=
> ---=0A=
>  libblkid/src/probe.c | 65 ++++++++++++++++++++++++++++++++++++++++----=
=0A=
>  1 file changed, 59 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c=0A=
> index 102766e57aa0..7454a14bdfe6 100644=0A=
> --- a/libblkid/src/probe.c=0A=
> +++ b/libblkid/src/probe.c=0A=
> @@ -107,6 +107,7 @@=0A=
>  #include <stdint.h>=0A=
>  #include <stdarg.h>=0A=
>  #include <limits.h>=0A=
> +#include <stdbool.h>=0A=
>  =0A=
>  #include "blkidP.h"=0A=
>  #include "all-io.h"=0A=
> @@ -1225,6 +1226,40 @@ int blkid_do_probe(blkid_probe pr)=0A=
>  	return rc;=0A=
>  }=0A=
>  =0A=
> +static int is_conventional(blkid_probe pr, uint64_t offset)=0A=
> +{=0A=
> +	struct blk_zone_report *rep =3D NULL;=0A=
> +	size_t rep_size;=0A=
> +	bool conventional;=0A=
> +	int ret;=0A=
> +=0A=
> +	if (!pr->zone_size)=0A=
> +		return 1;=0A=
> +=0A=
> +	rep_size =3D sizeof(struct blk_zone_report) + sizeof(struct blk_zone);=
=0A=
> +	rep =3D malloc(rep_size);=0A=
> +	if (!rep)=0A=
> +		return -1;=0A=
> +=0A=
> +	memset(rep, 0, rep_size);=0A=
=0A=
Use calloc() to get the zeroing done at the same time as allocation, may be=
 ?=0A=
=0A=
> +	rep->sector =3D (offset & pr->zone_size) >> 9;=0A=
=0A=
Why the "& pr->zone_size" ? This seems wrong. To get the zone info of the z=
one=0A=
containing offset, you can just have:=0A=
=0A=
	rep->sector =3D offset >> 9;=0A=
=0A=
And if you want to align to the zone start, then:=0A=
=0A=
	rep->sector =3D (offset & (~(pr->zone_size - 1))) >> 9;=0A=
=0A=
> +	rep->nr_zones =3D 1;=0A=
> +	ret =3D ioctl(blkid_probe_get_fd(pr), BLKREPORTZONE, rep);=0A=
> +	if (ret) {=0A=
> +		free(rep);=0A=
> +		return -1;=0A=
> +	}=0A=
> +=0A=
> +	if (rep->zones[0].type =3D=3D BLK_ZONE_TYPE_CONVENTIONAL)=0A=
> +		ret =3D 1;=0A=
> +	else=0A=
> +		ret =3D 0;=0A=
> +=0A=
> +	free(rep);=0A=
> +=0A=
> +	return ret;=0A=
> +}=0A=
> +=0A=
>  /**=0A=
>   * blkid_do_wipe:=0A=
>   * @pr: prober=0A=
> @@ -1264,6 +1299,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)=0A=
>  	const char *off =3D NULL;=0A=
>  	size_t len =3D 0;=0A=
>  	uint64_t offset, magoff;=0A=
> +	bool conventional;=0A=
>  	char buf[BUFSIZ];=0A=
>  	int fd, rc =3D 0;=0A=
>  	struct blkid_chain *chn;=0A=
> @@ -1299,6 +1335,11 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)=0A=
>  	if (len > sizeof(buf))=0A=
>  		len =3D sizeof(buf);=0A=
>  =0A=
> +	rc =3D is_conventional(pr, offset);=0A=
> +	if (rc < 0)=0A=
> +		return rc;=0A=
> +	conventional =3D rc =3D=3D 1;=0A=
> +=0A=
>  	DBG(LOWPROBE, ul_debug(=0A=
>  	    "do_wipe [offset=3D0x%"PRIx64" (%"PRIu64"), len=3D%zu, chain=3D%s, =
idx=3D%d, dryrun=3D%s]\n",=0A=
>  	    offset, offset, len, chn->driver->name, chn->idx, dryrun ? "yes" : =
"not"));=0A=
> @@ -1306,13 +1347,25 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)=0A=
>  	if (lseek(fd, offset, SEEK_SET) =3D=3D (off_t) -1)=0A=
>  		return -1;=0A=
>  =0A=
> -	memset(buf, 0, len);=0A=
> -=0A=
>  	if (!dryrun && len) {=0A=
> -		/* wipen on device */=0A=
> -		if (write_all(fd, buf, len))=0A=
> -			return -1;=0A=
> -		fsync(fd);=0A=
> +		if (conventional) {=0A=
> +			memset(buf, 0, len);=0A=
> +=0A=
> +			/* wipen on device */=0A=
> +			if (write_all(fd, buf, len))=0A=
> +				return -1;=0A=
> +			fsync(fd);=0A=
> +		} else {=0A=
> +			struct blk_zone_range range =3D {=0A=
> +			    (offset & pr->zone_size) >> 9,=0A=
> +			    pr->zone_size >> 9,=0A=
> +			};=0A=
=0A=
Please add the field names for clarity and fix the sector position (it look=
s=0A=
very wrong):=0A=
=0A=
			struct blk_zone_range range =3D {=0A=
			    .sector =3D (offset & (~(pr->zone_size - 1))) >> 9,=0A=
			    .nr_sectors =3D pr->zone_size >> 9,=0A=
			};=0A=
=0A=
> +=0A=
> +			rc =3D ioctl(fd, BLKRESETZONE, &range);=0A=
> +			if (rc < 0)=0A=
> +				return -1;=0A=
> +		}=0A=
> +=0A=
>  		pr->flags &=3D ~BLKID_FL_MODIF_BUFF;	/* be paranoid */=0A=
>  =0A=
>  		return blkid_probe_step_back(pr);=0A=
> =0A=
=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
