Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 853F635F080
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Apr 2021 11:13:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232332AbhDNJNz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Apr 2021 05:13:55 -0400
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:10345 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232081AbhDNJNy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Apr 2021 05:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1618391613; x=1649927613;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Po+841DmFUJen/crOkdXUGsuAPHKeu/dg36br1kYffA=;
  b=l6yPQP9rU1dh6Q4uwSuyCqsQcQ115J6DB7U+KZDydkBRflX49duwUNQW
   nhWdYU9O+AW5TI2lKheRufR6JUdXpZ1+ki+A2gnrbwgbfsjS5E0QQ1GvO
   mdw8Dbgzkp7y0XJdnSIChyybjE4idofnjCVYv4Nv5bfcD86ZrJm19Lj55
   xhU/9XhKZXv3M5s5ehF33mhNB0HjoOBXj1sd+GJsm/l8ZZqtn0V2sE+eS
   Ah1Xy4/BAmwlJa3CiWDuoNRKcv6CC16S170/O3DRhVqa5s1MnPSwkfpwu
   sx2ZaNHiUGzyJ9j0XI/SqVngyTTj4CH9FaXeKhVBhw1g9uRx4ucsEnc0/
   w==;
IronPort-SDR: iLyS3OIzTUjay5k9Taw4r9KZqgrPeKUs7rAGJo7cohfZkzz3i3607yC+0TYPJgtd0oI7mjUyvl
 kkw4TEuMQQ1fqK5otrthRh3gIB8sw8+tpmywxHP+NK69ylBzgrbKUGYVQKgc2qtLNO7qivO2dE
 RxdXRjxOREYfuDT3DtfQwbByw9RsuN8zwUE3DZPydmQ2M+0nkIX8SXJTgTItxD28dFMK/5oo11
 1WA2j1PW8y+Ms+IwVb6R5BWD8CYV12dRE58ucr88EbohAJ6ljKOI+LK6pWV1ugQy1kLDsfk5/f
 QIc=
X-IronPort-AV: E=Sophos;i="5.82,221,1613404800"; 
   d="scan'208";a="275666425"
Received: from mail-dm6nam10lp2106.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.106])
  by ob1.hgst.iphmx.com with ESMTP; 14 Apr 2021 17:13:27 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fjFFsMTcl+g+AW93sKNHRHYQt8eY8R2CeB+SOPCqks05Tt52KGhwM/2rWqF7L3dOcCPEsFHN6+W2jBGetsxJyP572h6tVLgR1AbCZUx1/1sRcJNhJzhwze5/jp7vXFLoNxuYgXandehoX2f/ctJ6ORDECrPefih7taD9/JSYv1I5Z0fHCZOUwhimXrm874Rimh/LfKpaHVX5cAfExZn/Zs8GuHswy6tvvnd6IPBPcT4cXzSj5JD2ia99eQFot2Lu2coza1WSLRIltpHg6zrwZ68EBGrQNqsSeNmeaCedNHEdYjIw6g+TYXnSIuxZJAxNS0CJDNx3C23RtnR3ddjw5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szlogs9BJcaSsgWn/S15p/Lb/6/f4G8EynHc4bi/JTs=;
 b=XVWgSTm240aDBATilUWQUTHoslPDkDK3r6lxZkUTygXLdJTiLWsFDrIOLNo2/DIIWva2S6pJInf5znNUQG48KuP+a8FF1BH1P74KcI1rmwBssR2NWnm4J0WNnvAR2RlALbKlo7hizehdn3Qy+Z8QfH2mU+9txaXFTfOAcL4ylc0ffJDIKBkCr+AWAnJhldDvCpSKwJ529W+PnvTpDSbcPB1eiA6zOKS7P0wif+Om9EqT13jh80R+Evg2wjBMLIZcUqzXqabqcaqFkTidArZAZ0vdrzR39Bc30/W8wQH5O8TRzy4ATeNsn3lGU5NmGaM2+NwBTGm5Oh7rZPF8bgHY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=szlogs9BJcaSsgWn/S15p/Lb/6/f4G8EynHc4bi/JTs=;
 b=xpD6OwdcEE7SL/5WwPphrMhjxk62+FpMJPdjxg5FmrAhfjArFPTwRFgdn3kh83l+Yntk58JhfHy4LNHJUIG98eFFlHsKDs6d1DMHtHRORnptWj0EAJnjmp0ntKewybIuLYaYr32709aIfag5dYkldFkh1tdOFqGMltoQiBXtqho=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by BL0PR04MB4849.namprd04.prod.outlook.com (2603:10b6:208:5d::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16; Wed, 14 Apr
 2021 09:13:24 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::8557:ab07:8b6b:da78%3]) with mapi id 15.20.4042.016; Wed, 14 Apr 2021
 09:13:24 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>, Karel Zak <kzak@redhat.com>
CC:     "util-linux@vger.kernel.org" <util-linux@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
Subject: Re: [PATCH v2 3/3] blkid: support zone reset for wipefs
Thread-Topic: [PATCH v2 3/3] blkid: support zone reset for wipefs
Thread-Index: AQHXMM45qP1cKQKyLk+EKv9d1ZbqCw==
Date:   Wed, 14 Apr 2021 09:13:24 +0000
Message-ID: <BL0PR04MB6514868960E29D9E39BA8277E74E9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210414013339.2936229-1-naohiro.aota@wdc.com>
 <20210414013339.2936229-4-naohiro.aota@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:38dc:3578:4d0f:a943]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c73b966-2274-4ba8-f497-08d8ff258ea0
x-ms-traffictypediagnostic: BL0PR04MB4849:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BL0PR04MB484953246085FC6003527905E74E9@BL0PR04MB4849.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:25;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: QvK82ctX/fMWdglDhdDYw9IBIA50YdFcl2LnRtyRe7buM/ar5GzG5Ce11X9bGsNV2cEjmkzK7nIQyL+Y0hGV8LGvaUJZxEHCs0rAPy8gQCbeNllwGrLHC1So7KX3isdjyjvMgfFqpr+EgNIV0uNJ+DFwnbWzdEnr7Q5b6hUim+uUcX41C0Vk80ZTjaXrJxTU8QyazzY+2nB0ckHXF+SPGrIsJWVwCSyOnnkwq4SPLZ/374Tv1P1Azt3fpoICV5AHHED/SdWro33BPpLUnKTZZOlb/mwCljsZtyd9tUbE+czJHyC/LXayP+fHxjXEeiiBUFXi0SRB9tWuO2/QVKsgFIK1kcpsu8d83W5PSeGde3x9zQb3arMD0Vo8tMP0Mk+SRULitdqRG+621sIrx5QBotbxPKF08iSPI2FEsj5K2nYFSXcDyOxfH7+rBBuNHRCe8xs87fqc3hfxDopl07J4mPDoJ1gKYREwNmFBShHmzFtd6xswWY0oo71hKSN22vzy57kl4qSHNbBWfKqePavvFnyHFDHXfeqQUDKvcie4EvclxC3scFmw6v8yZb5iYNkxmb6R/mlRqRxDUpC4EYd5IPsittJojq/NpvfVx1F6OQE=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(136003)(346002)(366004)(376002)(39860400002)(396003)(9686003)(478600001)(86362001)(66446008)(83380400001)(4326008)(55016002)(186003)(71200400001)(2906002)(53546011)(76116006)(52536014)(38100700002)(66946007)(122000001)(54906003)(7696005)(8676002)(316002)(91956017)(33656002)(110136005)(6506007)(66556008)(5660300002)(64756008)(66476007)(8936002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?HEl/4Yh0G8rkygNXTfBmPAlGlCyygg1+ONNCMg5MIu/HXFF9YGKVzZouk/G8?=
 =?us-ascii?Q?lE+OKeSgeqO7F0iteZcAh2eyKTA4L/s/y2mcetga/UZVY/pTko6gdr0T+8Oc?=
 =?us-ascii?Q?IDKJSd5+CyfaTC5G3+9vd+MjDgDkMOPqkXbJaszBt5OHgA0EslJLa3WKSiZ+?=
 =?us-ascii?Q?9nFafCz1dxME901op/DMzjcTiL8kLUeGznI7CN/o7lAqlIGxHf4/nizl/uR7?=
 =?us-ascii?Q?s6U7w222azT9Z4zu7NaFSRa8mwcbIqneKeHlQEW9mehCZzrWzvsWgy+mX+OD?=
 =?us-ascii?Q?9u5ZMMPco6jgJ5G9MBUNIl3lvPr+dw0jf+ZM94tON0ZFsulzHW7KIdQGiE4Q?=
 =?us-ascii?Q?Mxe2Mf+139dNTO58VRFxacoFnn7/Re58pgH7i/lHteuVlp7XAfPPbBh1C4Xz?=
 =?us-ascii?Q?wCpQeZDfQIhT6Zk9ME6/pju1Zo3UuY5pwwISGhXdVaIwJ1Bp3Oc6wwhlGokK?=
 =?us-ascii?Q?QpfUuPgrFJkREsWZgLCH0zSKKIUPSUonSDaacBbfhB4m9mBvsH3iBsEmwzpe?=
 =?us-ascii?Q?EeZlHumrJ5AwpYWTywOl2eq5KxTOuv9ps5UequktoUo0nf+Qha4wuyi6awl6?=
 =?us-ascii?Q?SgLK02vSE030aHi1Re0p+uU6mRhby5MtnFwkB9S19sQKkB2ThOLWD+ceVWEY?=
 =?us-ascii?Q?R/YuRR5NhORnVQyiZKEZ09j0e9e+QSvBAT6Yzq69UhsNG8JZ1+fhhGN2xBJn?=
 =?us-ascii?Q?jPLIgjEE/N+MbAKVvNrMUgap0Pf+VVG4ESBp6pzjQe5q6vqUWgNy7pAofmsA?=
 =?us-ascii?Q?shfIN0parC5MtI59KJXLBsgDZo/J7/XS2qTXKSAVpNr8grOXRrPpsWAs7VpJ?=
 =?us-ascii?Q?TqgTq/cQNUcfZgQ3t1CI1B2C08XSCfHdBfQpIIEORkBzkBCG96UQ3WmJeuga?=
 =?us-ascii?Q?gOuWBZeS75ijnEjlb5sdgF9DJWKRBOidmxqhDO5kWBzh4mZMy14UPlVqQs5c?=
 =?us-ascii?Q?Tr+WwVkAnXD+iDhWViwc10rWW8cxUDrNzAuiDzQNEJ0xKBWGjlGnClBq0NE8?=
 =?us-ascii?Q?sV8XpYti3J0FcsOYZhjpZjGQARESTUpCXdYCRm6AM70PP+m0YGSXO/1tGRmF?=
 =?us-ascii?Q?7EyPEfyqjhxoIhBBuo9g4Ya5Lll4dRwq3LBrnShsKF8Y9Pht7KnKZqj7RlGS?=
 =?us-ascii?Q?djuly4oa0th6LYBEOLMXgnmd5rE+JSIukygtQN0W4oOFZ9ZBa5izA44yOpUV?=
 =?us-ascii?Q?wq3ARcV0o+Gk907EVNZInqbCZ7l1KavcLTFgajxt/LWlxFY1P3c17GdJ6eR6?=
 =?us-ascii?Q?1BkMweT5dvDqoV5zjxQ3TcDSwQZOaDw3EoGP6Bh5trbGva1EJfySKijTSHq7?=
 =?us-ascii?Q?vgU631+vXT6vrtyRf3yBOS+EpqHJwxlvV5EjmYQBHwJO6nTlXE1RwzUg/3oi?=
 =?us-ascii?Q?DXT8f6Bt9owc0bO4b+7yas5yU4+dPW49Ncj7tuqxXZh76txH0g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c73b966-2274-4ba8-f497-08d8ff258ea0
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2021 09:13:24.2580
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sq+jtE1t1NjLjNCkInj9zO7aL/gBRPxhqUzpEqmzHJJPRjhnQI+Ac7QqIzyUg3S6t3UcN19Nu1U/cT7AIroTyA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR04MB4849
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/04/14 10:33, Naohiro Aota wrote:=0A=
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
>  libblkid/src/probe.c | 79 ++++++++++++++++++++++++++++++++++++++++----=
=0A=
>  1 file changed, 73 insertions(+), 6 deletions(-)=0A=
> =0A=
> diff --git a/libblkid/src/probe.c b/libblkid/src/probe.c=0A=
> index 9d180aab5242..23c3621627d4 100644=0A=
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
> @@ -1228,6 +1229,48 @@ int blkid_do_probe(blkid_probe pr)=0A=
>  	return rc;=0A=
>  }=0A=
>  =0A=
> +#ifdef HAVE_LINUX_BLKZONED_H=0A=
> +static int is_conventional(blkid_probe pr, uint64_t offset)=0A=
> +{=0A=
> +	struct blk_zone_report *rep =3D NULL;=0A=
> +	size_t rep_size;=0A=
> +	int ret;=0A=
> +	uint64_t zone_mask;=0A=
> +=0A=
> +	if (!pr->zone_size)=0A=
> +		return 1;=0A=
> +=0A=
> +	rep_size =3D sizeof(struct blk_zone_report) + sizeof(struct blk_zone);=
=0A=
> +	rep =3D calloc(1, rep_size);=0A=
> +	if (!rep)=0A=
> +		return -1;=0A=
> +=0A=
> +	zone_mask =3D ~(pr->zone_size - 1);=0A=
> +	rep->sector =3D (offset & zone_mask) >> 9;=0A=
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
> +#else=0A=
> +static inline int is_conventional(blkid_probe pr __attribute__((__unused=
__)),=0A=
> +				  uint64_t offset __attribute__((__unused__)))=0A=
> +{=0A=
> +	return 1;=0A=
> +}=0A=
> +#endif=0A=
> +=0A=
>  /**=0A=
>   * blkid_do_wipe:=0A=
>   * @pr: prober=0A=
> @@ -1267,6 +1310,7 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)=0A=
>  	const char *off =3D NULL;=0A=
>  	size_t len =3D 0;=0A=
>  	uint64_t offset, magoff;=0A=
> +	bool conventional;=0A=
>  	char buf[BUFSIZ];=0A=
>  	int fd, rc =3D 0;=0A=
>  	struct blkid_chain *chn;=0A=
> @@ -1302,6 +1346,11 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)=0A=
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
> @@ -1309,13 +1358,31 @@ int blkid_do_wipe(blkid_probe pr, int dryrun)=0A=
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
> +#ifdef HAVE_LINUX_BLKZONED_H=0A=
> +			uint64_t zone_mask =3D ~(pr->zone_size - 1);=0A=
> +			struct blk_zone_range range =3D {=0A=
> +				.sector =3D (offset & zone_mask) >> 9,=0A=
> +				.nr_sectors =3D pr->zone_size >> 9,=0A=
> +			};=0A=
> +=0A=
> +			rc =3D ioctl(fd, BLKRESETZONE, &range);=0A=
> +			if (rc < 0)=0A=
> +				return -1;=0A=
> +#else=0A=
> +			/* Should not reach here */=0A=
> +			assert(0);=0A=
> +#endif=0A=
> +		}=0A=
> +=0A=
>  		pr->flags &=3D ~BLKID_FL_MODIF_BUFF;	/* be paranoid */=0A=
>  =0A=
>  		return blkid_probe_step_back(pr);=0A=
> =0A=
=0A=
Looks OK to me.=0A=
=0A=
Reviewed-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
