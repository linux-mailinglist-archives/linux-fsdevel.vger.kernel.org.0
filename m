Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1B999304C4B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 23:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729147AbhAZWgQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 17:36:16 -0500
Received: from esa6.hgst.iphmx.com ([216.71.154.45]:50956 "EHLO
        esa6.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732414AbhAZTMd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 14:12:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611688353; x=1643224353;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=qycwswdKEkfSrfBGHipxmgVrIyfCcU42WNDTcdPx4d0=;
  b=NTnzrB3ZxZn6U0sgYA6ixwWzgGO9J0I6t4jCC/N7eN49tuoIIT4zaOl+
   dZ7KlpnZQ2Kb/wEM2xeWPZULB45z7CctY3jYRNMkkfhzc7bbKT8fEvokS
   quD7t+NzYjWW+WVA8/k6VFQk7DH49xtm05lpAsoKzTlqTKXtt34+jaqnH
   RqGZ98ih3l83+EfRARSs2t3PKLzybelZXDhLvdtBNbfKZqloGwSTQQ3MI
   Oe44vB2L0XALOQuOIOJOAEJsAKaxd10O+s+eXz2tEyG1UJI5+AlTezhpD
   uubTbmMdV7yCEXD3xKoX9kiWe7soKmIh/XbfSkQUsvIAHt50JN1CCbGsV
   A==;
IronPort-SDR: 9HrUbYLhXi0toG9lWlwQ111gEyZxDJnP776ZlBI/cre4cQGC66/tHZrdY7ZvWcqdOjH+D5ze95
 TutGps+CGm7uVKGD0TBGMIxCHZaRwQ2282KRgGnO8QjYDXcobHE2JLuN3rLmPY26qVPY71dw2T
 xqwzF7u4UA970Aq9SJcl+hjCqMuKKB/HnPRXjP5saZOGBNz3yhO/SfEQcgeExO4Kb7r+E+ykAQ
 XGdNVbr1RVUUvi6jx8UTeQYFRxjs7dpADtExt4fiyOZFM46D3Ck3Dq5JvR6FXIld2yEROAKZYH
 dzQ=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="159553899"
Received: from mail-co1nam11lp2176.outbound.protection.outlook.com (HELO NAM11-CO1-obe.outbound.protection.outlook.com) ([104.47.56.176])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 03:11:20 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a1UdTxzrjUs4pfZi48MQJ6Pv/CbpbAa+Wh3SZ8JXHI2+1zKEKiuTx5IPbv3T9//EIWegRwhHfZAsNwMlAQTtd0BObrY3Mt2kTbTDnoLPL1Wmqxzlm26Ueiep1q/ifZIQnF1ZeqzfTnZMlFBJa93hAz6h4sVhByHprsF4OlJqB5UQU7FZ2P1Ahh4IT4JJRv+5Dh1+92jPwigb69Bd+qZJQ6JYnUehfFJGftte3T6EwlmBRxpd+qvFib61c63GPJpyTtnvazAD4QgoofKSwlkSDUx427HlzrfrxalJcDEN39FeVwlwzkJ8s0sERWS0FSQx1cBpdkVGjt6xSbTsZw8q7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qycwswdKEkfSrfBGHipxmgVrIyfCcU42WNDTcdPx4d0=;
 b=PkBkS+/ZzTepagg6yZMWS21S2ogWWy0E94Lx2s6Ie2VfFSM36aNDIl29Rh401i0vSCR0EDF1sAZpMrgqOkm/GTEF94yE28M6mKFLXWlXtdzBx159eiygch6xD76XxOkvxTkaIL+/IXsEjlbJD8wZ49eFGpLhuB4HbpNj4L9BekYX8ppcdbQ1BllchLKJch7K7+uZbaxKFv1W/TJDVTOrAUxKLRKQK/RiD+RetBOYqrRY+UWWrz2fOuvLRPY+WXWGGunQtsk02Vvqu7q7PFEkMLrQGBEv/ZXfm/JFcX5AI7G8JIH43KVn/fkT4YSOVh43a410o6a0KqTvfK7Mv6WI7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qycwswdKEkfSrfBGHipxmgVrIyfCcU42WNDTcdPx4d0=;
 b=PrVh+41fYjjTea3vPDoMebpSZh/LOBX+Wy5D7i2YyXFwnEktcnu04SFNCPZgwromMFrPzERw99RGdu2i3N+UOCF33YF6Gnm289xkUWn7uihL6uhwqUolBOdp661zHcnM7MY+4INjSee6xVFJa4rizpquDOZIx8NDnbSCYPpAdfs=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by SJ0PR04MB7262.namprd04.prod.outlook.com (2603:10b6:a03:292::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.13; Tue, 26 Jan
 2021 19:11:18 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3784.016; Tue, 26 Jan 2021
 19:11:18 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
CC:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "drbd-dev@lists.linbit.com" <drbd-dev@lists.linbit.com>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Subject: Re: [PATCH 02/17] btrfs: use bio_kmalloc in __alloc_device
Thread-Topic: [PATCH 02/17] btrfs: use bio_kmalloc in __alloc_device
Thread-Index: AQHW8/R60f6RE8OXIUCkbvhVzCX0Mg==
Date:   Tue, 26 Jan 2021 19:11:18 +0000
Message-ID: <BYAPR04MB4965808085867317CEDE615186BC9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-3-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2600:8802:270c:4b00:b091:5edc:1473:bf45]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: fa00d4b4-9e05-4e1e-33e9-08d8c22e28dc
x-ms-traffictypediagnostic: SJ0PR04MB7262:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SJ0PR04MB7262B19D21BE2A31F5E3BD6386BC9@SJ0PR04MB7262.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:227;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 2KZA1/rEr/W1lpsd1PINRSs1f7HpMDml5NjuyzUcogKy1mCT3fgeDTpF1FIazWAF8MR+Yd77vp/F11XUtpv4hlThBYYPia3DmQ3A0TjfFC3J2cJF+KKjRN2E9Tm8nWK52cTa6a7EPO7VSVnqQErVZjbOGFbPuWeUnlVkO0SJ8CYaG1DNLb21CabGvBVe3IsaV5GSQZBROQTlzVK8iza7zdXyXqkCCeOOhHuJzC1eVj2COw1C25soX+k/CX4rzrvgMO0TE64hT07HISuBgQPH/h7MD8gwNSXWJ7OlYni5WZxKiT7usYVgJNc3IxG5cjHtnTy89noCKjl1EqsF6pmTZ5Ai2ujRbw1TrlyHA+3XFnf1FpT/Qr+35LLAPDF1bM0Slawui5uIfyO9Zso13TkCpa2row9Nceqzhaqd9NlOxz9evZLDBqSN+GmxWoIUcnmqJSKRI+ifYMag5l+7vv51aEg8h7xD36SCxPYGVJJx5LKFwkUvdDykR3BcdLZ0yU2uTuTITD8PlslERMvihzVByw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(376002)(136003)(366004)(346002)(558084003)(52536014)(186003)(33656002)(7696005)(8936002)(53546011)(6506007)(8676002)(110136005)(9686003)(316002)(64756008)(66556008)(5660300002)(55016002)(54906003)(66946007)(66476007)(66446008)(4326008)(76116006)(71200400001)(2906002)(7416002)(86362001)(478600001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?d4ptxX6mZEPBGIZsteWKaLZjzSo1m+Lq7aENEzkgzE+r+P9kNQHhSVi1ehRM?=
 =?us-ascii?Q?RMLcPq2hxicyKbHz+eg+N+ogzO9lhKeNRPhcPnLHWgdf7QfWGmIt2THZ8Fw3?=
 =?us-ascii?Q?6S78Vl8duyVcvcecfD5nQy4TwkCdlwFeoBVONhhsfO7sK1cG880KqU9UTi/G?=
 =?us-ascii?Q?oiatjNa4LLxdzYXulB5dVOrifgDo7omNXmOdISIK/wwGMWMzTUqBHftGHQqb?=
 =?us-ascii?Q?zk3qx5Mh8mXAqrXa3W6ZFVuGW9TBRzJvPG1iOXRKAnArShWTbqDFhSXG1hoy?=
 =?us-ascii?Q?WIZHCGn8KSyKiEZXkNVlSFKxV17kfwTXzKk7NNtP4gTf6U6n1zQS1dXSWkhn?=
 =?us-ascii?Q?Yl0iClvJsO+6dqGmA6WYOKm/u9Zp5OedUru6UgVMKWYARWer7jvh4kpjLfVT?=
 =?us-ascii?Q?jNNLn06mRoEVmZcG6rjqqf5+tpX7XpNEzc2yQ1+4R2gGH3p43HylRaDbOhl2?=
 =?us-ascii?Q?Lb19ODYgIlpXUbk0tgTZ8jN0J50YN1EVSazlk6hjdC673/LMlx/MSYgI21zQ?=
 =?us-ascii?Q?W/dvD6CTswOGwZ8vdTTq+/6F+plGhCuqfJobVaqyCjTVzpeWDWWvgb61/xTF?=
 =?us-ascii?Q?O7ZU72VgeL0o+xyrwiSDlGEayXnCsivG3sH21/Gy589h8UI08L646cL6A/T4?=
 =?us-ascii?Q?dHSPBbHgBX6fowOnMoN0YrgG87OzCbN4XxNm/ABh1QekfQ7l+9Zgjhe2mu5B?=
 =?us-ascii?Q?/e2goxVgjfFAILuB79AinYBOwGSf9KVTlLwwPlJTh+IdW6+8o7QzJREpaIgH?=
 =?us-ascii?Q?2IxE7UeVmoDOhw4GCxJR2Room/m20b+K15If9Brbnv5ETahJvVeT+4Fvga7k?=
 =?us-ascii?Q?kFle1+xQ9qSBL3qCsR844RUQv+fmwkDLQxBcWJjW/uqnci5ls5Y9sA/Pq3u6?=
 =?us-ascii?Q?Xe1bz6CLthQv1PiaZGp4jwHKU+riFE8/z6aGlKffeOiruP0v2pJapm00K23Z?=
 =?us-ascii?Q?DMBCjL327szzR5Nku5yRBJZ1p8HSqozCpp32w8zzQwbpSRNJMKboeugOafYn?=
 =?us-ascii?Q?iyDKdxmH4Eb1cuNL6Cf0b94NpxR2YdspdcERHuyLjyZzgoxcE/ENl5YsNLbp?=
 =?us-ascii?Q?7G9h33NyV4Lir4m0h2OvTVl+59AmQe/tvhNz5aOqgQurle+SKteGNpSyVNLz?=
 =?us-ascii?Q?hpWu2csTD3cO/KMFJSiB4RSVnIQ67Hb/Rg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa00d4b4-9e05-4e1e-33e9-08d8c22e28dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 19:11:18.1689
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: NW/d4FbXu1icGoh8C9XQmW4dRM0JEd+cBUzwUw/wAHLhcJ6XSs3gYponomIRJGMZ8CrpHOU6ygsZgtqzLCnAa5EXK3aXQckWIRUfscUiJ7o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR04MB7262
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/26/21 7:04 AM, Christoph Hellwig wrote:=0A=
> Use bio_kmalloc instead of open coding it.=0A=
>=0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
Looks good.=0A=
=0A=
Reviewed-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>=0A=
=0A=
