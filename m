Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ED9F532C508
	for <lists+linux-fsdevel@lfdr.de>; Thu,  4 Mar 2021 01:58:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377230AbhCDAS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Mar 2021 19:18:58 -0500
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:38737 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1839563AbhCCIFW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Mar 2021 03:05:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1614758720; x=1646294720;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=4lYQ2MHWW6rsRqfT2NmYPp9CgXtWa0kM+CK774h4NFY=;
  b=IxSgEG3Z7OCxM1cZCeNT6IenZ+CGw+VPChL5BGTNOvo2n9ObpdWwkK6o
   4pXjxXj1n2JEFxZfzhTuiZm1cWFx+gHLgZw82YvZ+PuQ7pCF7KMxhxtCL
   2QWVmqODQKsB1Tl3uv7AGGl71DnCEBR0yzhjuoNwmHGkTiydR2fleAw2E
   inDUVxJTEeA3q6hwKakABxa7opApR3okfAASJfIpZAVLdncMR88blPis1
   DjoQoeboEleLbxWr0QQl8Lqu15r/WDFWdthXldx8TY7bxpgn5xgLecEl2
   DFD89Vsx3SbkuKKGb30P4/JSRse/GGm/GBJDrCKn/1tnLHUsxNhIRJ8YD
   g==;
IronPort-SDR: +fiN4r7NDW9vF7IspDbt0qnEdHuKDk4Cbt5qdtK7iguuYCXol2rsM8nyRf0HHMBpsrLHWEZZe0
 SAcdWMlYNrOojM9wPbxLqmYzk5zYsJfQjZ6Lp9A9swBhEuWJiXGC4z8EFUdKRQICCBF/FEzCGY
 V4xf4PKFNKqWV8CwzsbSp9bX+HvIuAOHYbOtoSzM6dOVuiLbGjyRlPDz9DHxlZwJDhAl3LM59R
 LGNWTJn/10spIrYWA5lttSggU6Fn/3RECaZPjfQugSxMYPIxwU7zsxpvbVv9XWPCnCCZGWRmZH
 zMI=
X-IronPort-AV: E=Sophos;i="5.81,219,1610380800"; 
   d="scan'208";a="271853875"
Received: from mail-mw2nam10lp2104.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.104])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2021 16:04:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GQlUAW+DRGSmOZ0WkKcWZ9gG4S+TnvQtg/YTxYamI6BTOSv10k24M5ab2D+pLIseMMdnLxm/UXp4KkPxPwnnQw0HY/qHkSxbE19YZlzUMAebXYJzHwTOSDAf2UZjf+r7R7mSZji2V74LsPhSFMId4EU0/mqzQBeIFnIC8o1SNuGUNAtIgHlOCQt7gFrSHLCK1Q/seloFK6bMF180t/2/88fCTN41x1S0VBROFdHvdrBDXa8tTXJ3yUX4lc9hYqLlprOOo6K4gReVKiLgK20YJ00i+IycTsG/2R+qM/OLHYgdiH8isrXcFtyRxoBcchbHGfCRekM/dYjzxnPm6jMPkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lYQ2MHWW6rsRqfT2NmYPp9CgXtWa0kM+CK774h4NFY=;
 b=VxAn7kZQafUshvNvaF+Pz3wXImuCVWKpHOu2entrdFyF6axQMfnnjOlf6A0nY8fF446ZN7+4oyv6N0k0FvE0Yk3moHgR1LmuM3Oo+4OuPcnxMCsXEU78nGk783a9SQ3+S8pp1XiBEcTe/BBWN2DX0cUSpeSNi8pVN1FZthdhXsOkCUbijE1iqenlSCUgE85z15PqnJ1enUe0WH9MddQrCuuUWC+T+MZIYAKrAZxPDn48T7Q0wtB+yAKcOn+Z9gnJGVbgVXGCROc2NpwAsxKbAXzhPhK760yR1kbzVaXHTenoMDntp7H6LVp1l4TuVLEQA7cquaYHAac53ZFduE8bog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4lYQ2MHWW6rsRqfT2NmYPp9CgXtWa0kM+CK774h4NFY=;
 b=O28OqsRm1N39iQdcLpF3GNiUh0BrV/k51cmYm4g2As8q4Bx1o3VHSui/8mi6x0XlKdL+EPWHsHtm57sgRc3oceABfjeO6dMHhyE7aE2As52dfjvi2Xf4PqT+CUYd4K9Op+3J4oRdM0QkPr8Z1cY7GCeIGzDRw8NdB7hF8WAwE0s=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by PH0PR04MB7464.namprd04.prod.outlook.com (2603:10b6:510:15::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3890.19; Wed, 3 Mar
 2021 08:04:13 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::3c7d:5381:1232:e725%7]) with mapi id 15.20.3890.030; Wed, 3 Mar 2021
 08:04:13 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Naohiro Aota <Naohiro.Aota@wdc.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [PATCH 0/2] fstests: two preperation patches for zoned device
 support
Thread-Topic: [PATCH 0/2] fstests: two preperation patches for zoned device
 support
Thread-Index: AQHXD0RJAH6zuG/GxkOzttD3+qguUQ==
Date:   Wed, 3 Mar 2021 08:04:13 +0000
Message-ID: <PH0PR04MB7416A0DA052E91B4E17A0DB59B989@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20210302091305.27828-1-johannes.thumshirn@wdc.com>
 <20210303055857.yfevx2uyyhltn2jk@naota-xeon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: wdc.com; dkim=none (message not signed)
 header.d=none;wdc.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2001:a62:1542:e101:ccec:1858:7740:59e7]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dd90405b-9993-47ad-83b7-08d8de1aef5b
x-ms-traffictypediagnostic: PH0PR04MB7464:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <PH0PR04MB7464C44FEEB48191EC8F355F9B989@PH0PR04MB7464.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:51;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y+6KSD+XnbsnFJAiiGQivgn27fg7I/gDLSyFQgpYDu56P609cHueRed8LvVaBx7n9PjO7+QOynBKsxSbcjrlmOwrewW8Ax4bNm3vEjKjBMGOgPvOsDyhP9YnVpFqoy6Us9QkOEFU/oxVDaH2J/Z3tiiAPzSXm01hiyA3ly/dhPy+cbtipJkf9UQnaRraKNVTRo0w/JQnWNjs3cGCdJLvnQRokciPi9217EsVg1rVIrwlPRl3b4ErOoX30I3bkaw2EVbTmXA4QBGiXsTPobvcU2je616ypyJC2/yy0ORUFx6/b/ViL8HlfY0tYFGwiarFqB2pwWWrDSXzg0+fysj9RvqevOR8xIUG1pRrUY/6NOijDyxCw9r+6E4rBhA0Tb4OYIOI98ErQ6BpMhpUYf2ZvF/iYgm0RpRk5qlUngbn5xXOkgNoWinos3cXdMFgLYeElgLcwz2FymdG8SiI+kijUD30CDs+fFDFCsCWNTSkcJ02uj9gz4ZQ3HwVdRXRIpiYNafG7f6YS8rvg2RU4WGDcw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(396003)(39860400002)(366004)(346002)(316002)(86362001)(478600001)(186003)(76116006)(9686003)(55016002)(91956017)(54906003)(53546011)(71200400001)(8676002)(8936002)(6636002)(33656002)(4326008)(66946007)(2906002)(66556008)(6862004)(52536014)(7696005)(450100002)(66446008)(558084003)(66476007)(6506007)(64756008)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?/AxPvhdnqpJPnXM5jBU/RA+W7OXIM6Kmg9fsz2OcknmiXRepdBVkl8TCK+Oy?=
 =?us-ascii?Q?HmftCM+n5sDaD67ozvoyA/jPcjXYvS7/CVF07AMAmOg3RtPq3syjK10g3hTh?=
 =?us-ascii?Q?p3RAUyqKh5CE82+CmKhvoWxV8Zzk20NulA7u2tCnp26KRmQ4fs7qY8O8Ct+Q?=
 =?us-ascii?Q?LYaEj1Ry9hKsnIyddiNRT3VETF6dpvD4MdJw18s7EkLbqlwifgjPBkYG645f?=
 =?us-ascii?Q?XlWfHYra6rS+jOZT/HQRn9UCHk94xg2F2rc5ruP4cIbR+9oztXqoxyJ8QSVO?=
 =?us-ascii?Q?DKVSpMl99+ECp/YypeuiZDUCD+HW9u6d3yj7+zg9IIe72Xn60e4TV3ICTlrQ?=
 =?us-ascii?Q?odwbMQJa6D8PtJzs5pc5/IG0NY23QMI/rX7D9zd629r3FQQeqSW5gtJVVfz6?=
 =?us-ascii?Q?ar8z0WOQrFWGjP7VgeXi7OKrnCJNboqdcq2XK4YqZtq0Lt18p0hxTBoSJYiT?=
 =?us-ascii?Q?9UUDlInN6RxLHQFLlyucV/zd5sIXHJay8seWTyVZId1qcq37reNWk/nGS/6J?=
 =?us-ascii?Q?XF9JrGfhxx+N2l5NcDJdu0FT1SRriEiYcpAAcTZ9HJcvbBWiwlBzYDukeI4u?=
 =?us-ascii?Q?OFwHs0HI23Gs/QmKC5W6sM4W5oRtvB1Sh9dMZ/j8m5HZEilko7tC1s5sZHtm?=
 =?us-ascii?Q?BG5wyStVLtfNY4zPriArpasRkul3sR/MIhxG3nYhuNmvSaK+3CZx/ZiB9ET3?=
 =?us-ascii?Q?zGG4ngamX2+roanAJHvNkDWSb0zoWXvkKXMe+k2dCY4Y41uDunnc2bdYf+La?=
 =?us-ascii?Q?r5nvD1LIx6mwOGbn4gN3ZDHbGU9Dvgr2nqd5sN71qwdqqJ5JGFUVFXGvYDg4?=
 =?us-ascii?Q?aMCHstNNVDX5sC3j/M/l8yyHKhzWMrHE+DtrVQXoGen+7Oex/DvjRpscILHE?=
 =?us-ascii?Q?83vPooRImjGz3SP5FKPuua+2uRHoFLOMzQtWpcbjxhgO44eVnMOUGXAQb0uR?=
 =?us-ascii?Q?I38VzbgYKHylL5TFbwyb5cZpJjDQjGRc9VOuPcf1IflHuy8JiHwsNYurr3WB?=
 =?us-ascii?Q?NnqYH/Q70x1WhK+dLkUSEazAQCtNP6yY2Lf6oA4rTXLvQLBSspspXmXYyL46?=
 =?us-ascii?Q?vYJ/xxfDNEsSIIXBJfhfzHD4DCkr+Tv1gZiUBUPyXFU6ALYZNQAbilnpOVmx?=
 =?us-ascii?Q?jwfsCgtjiVAQ4OLNnw3wR9n8+vy5ELRqpTyBb26PkKDB0AfpQl/JYFT/iQ0A?=
 =?us-ascii?Q?faaH+WyNF/sDvWjMj7MrIGZ5E0Eo4jQosS2dZGp8ushP5CJXk5HjLz5/1G+s?=
 =?us-ascii?Q?NTyEVydXTR1uWxtKJADaCKMgDl+7t8P/drIPkrmGRXY71Bc8RQ4heFi6T/sB?=
 =?us-ascii?Q?EMgf0J+r+bFdC311yjyqrI+1c7JL5ZakiqpurxrCvkJbXgHtFFjZizyA1hXn?=
 =?us-ascii?Q?e/MAnPb6rPevqLQIKUTCmhTYeVivfd6v2ggyBOzrtbYjoiPoMA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd90405b-9993-47ad-83b7-08d8de1aef5b
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2021 08:04:13.7948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: PI+TJJ8DLEH+zzXYZgSTOCT64wzbh+pWdGYdnrdMHz8/ZIcy6l2WDXfEKJW3q1q0CsS0RqXlAeeY4Lywq52fgEcKRVWSBcrdv+e7IJ51iT4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7464
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/03/2021 06:59, Naohiro Aota wrote:=0A=
> Is this series intended to also Cc'ed to fstests@vger.kernel.org?=0A=
=0A=
I'm stupid, yes it should...=0A=
