Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F2F8F3041B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 16:10:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391724AbhAZPKH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 10:10:07 -0500
Received: from esa4.hgst.iphmx.com ([216.71.154.42]:50242 "EHLO
        esa4.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406198AbhAZPJ0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 10:09:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611673765; x=1643209765;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=knd/vq/iKZ9ytSRXl4mzhKgn7bInmSzPGgY7pLGvF38=;
  b=qDy/+s97YyX5BNNzY5TOjGb0pu6T3BSY81EouK9EXiQkG9FjFAmgJarO
   d9Ei5ZrwfKFdczWqSjlQ2WB/35eBg5tr2jd4GVu+i7MnQtap5XzQyXP7n
   +QFYvK+feNUL2544sYtPjkcaheDhaanFYeL19mGFDZL46t6R/gDSsinLt
   Rt3M5RIXgDPwHiJ5Gz8Rm3ueOyNFxaHvLzBciBNGd2aqeaQQmTGLf1WiX
   0VoeNdUhcfgSwFyvTNicMVaxU0nfELaMHyK66lXn4FZPJJH/KLDFyN54y
   ZSTyOyqvvdfV9SeMJDECS+OWIF+KzC890TA80amOUbMps3PQDvAqeCMky
   w==;
IronPort-SDR: HcbuzBJm1u6RCEVGWBL1UbDszAA+554lNR+8jGCPOhUhrTc+pKHhEVvRzitrqKNbyKqgmM+S7Q
 G2Wdop8XSypkKCpBYBeBnooXwC2sfytvfQ3e0kVjrnwIIAQhYTSgzfyLoUcFGpu1+NQWyUaU4V
 00pHs71QW1NGoBT6OqA+Zu/2Pfs1SKd24Xqi0IciCZDdaEipwIxhtHh7NQahTyhBluwWxtCjrd
 5+ZDosG++y+NG5j75CXTMWBGV5iW1IbV1DAB57oUFFRAfht1GTG1zNuUCSQsu7bII6h0Ru2rUm
 vPE=
X-IronPort-AV: E=Sophos;i="5.79,375,1602518400"; 
   d="scan'208";a="158356113"
Received: from mail-cys01nam02lp2058.outbound.protection.outlook.com (HELO NAM02-CY1-obe.outbound.protection.outlook.com) ([104.47.37.58])
  by ob1.hgst.iphmx.com with ESMTP; 26 Jan 2021 23:08:14 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kr7MYt6HY1xj8L+LAyIkdkkIyMxnqL7KgFGruOzTGEbXs1MTq/i0d8JuQafkDLJNCGVathGwHMGBqU2Nzs73TQo+asB3M0ZQnvfn3JaijafvJJKcxr/D5eSE2P8km8M/tnLOb+70lo8SQVTeTJyYW8z06B9x2he+SpSdhDQ9j1ebcs1jw19UbkO3gOOf3VDHQsE4RcthmA68ErNTA4XSo03kNKbmRpQDEkded5AY8OGHPbUPQG/G+FKxxAKCbIs2JpcrtZcdp14Ven0JVyp3IzwoKkgu0yiyIMHRGatpjHv/xqNrV5M3yvKTuDPZXnlpNFzankIRodxOGowBOi0C4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWacF5Tz2aVg5M9uD2OwJG49WEBCvddRIk1yXegs3dI=;
 b=E8/sAzk92F7cU7QxqMQZPHSCP0nK0661Z4A6ndp/bjUFjDu5/Hqe2R8eQM91XdseGmERc59z/DS6xKHu2kzBwW6yvOWq1V9epD1sF14bAbCEZwfTp6w9PybI42184QvbwbFGu2hW9jL+sBOSY6fpEdJjIfGyD21tQM1HLngy13GyWkIkryEbyg5P9k+OcoBbMEliCN6Bb2tVpGfME/PuRd9aHNrPFdzs4v1l4Hse968CDqZ3C+lv+p3QyySNE49pWF5WgbIY4TZgSr6FjJs0CbmgmSy59gUtN+sQ+P7rahLY0nTQiS3HYpZ2tKRgrLVlCgjfVKXQeGITwN57ApSzpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UWacF5Tz2aVg5M9uD2OwJG49WEBCvddRIk1yXegs3dI=;
 b=OyB9pKxpw/++A0u7MtL8FBvL4Krc6a86nPbkjXtEEj/B8FKnbRYgPbDwMZI+uxyWV9W+FacbTqcgpAcFIP0sK/rduK8aIBmsAR6keDqvz/Ca4AfV+IeHY8WnvmWBlK5P7ddTslXUETCJhmEoe8MW6cipxzAMhhFTp+XqgpAXFjo=
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 (2603:10b6:803:47::21) by SN6PR04MB4928.namprd04.prod.outlook.com
 (2603:10b6:805:9d::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3784.15; Tue, 26 Jan
 2021 15:08:13 +0000
Received: from SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274]) by SN4PR0401MB3598.namprd04.prod.outlook.com
 ([fe80::c19b:805:20e0:6274%6]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 15:08:12 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
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
Subject: Re: [PATCH 01/17] zonefs: use bio_alloc in zonefs_file_dio_append
Thread-Topic: [PATCH 01/17] zonefs: use bio_alloc in zonefs_file_dio_append
Thread-Index: AQHW8/Qrc+FuLwDd/k+CySi1dId/TA==
Date:   Tue, 26 Jan 2021 15:08:12 +0000
Message-ID: <SN4PR0401MB359852658B9D8F386CC7C76A9BBC9@SN4PR0401MB3598.namprd04.prod.outlook.com>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [62.216.203.141]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 0edb4c87-c068-4eca-1592-08d8c20c335c
x-ms-traffictypediagnostic: SN6PR04MB4928:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <SN6PR04MB49288B3AD6F1136E28FA89949BBC9@SN6PR04MB4928.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ExQuz7m9Z2JVMsakrHKGh0w8++Sxwbj8vy2sZznmg+RMf5rlwJ/ppA3m6/sEhNljkawHlpJht9TX5mm7If/bB/0EYB3U/pShUTwqr0LlFZ/NbtM0Ln3oVrpquJBYV7xQ4ktogxqG7S0n3864flZphyYvkvX9iZzIFpuM3eLUHBo8NGPquM1XIRl1mykcCLhZiMJyZ4kn60XiYBLIsVCyvXaU5Xfg2jKTQ0zrEx+HRmNNaXO9GdfTw6939Wxz5I+922JREaPlm4z5Kpr+Z3piocSgZjCYqw+Bp9XX+A0U5LxgP2jp4FEb+v1/w/BZnnt8LCTzNnLz8qjb9TKVensQrlig83ktPU8lKmds0gnH6PF/BVfPijaHLkvdw8tvGlYEG8kkAduxcBhD3dOXK8FHiA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN4PR0401MB3598.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(376002)(136003)(366004)(39860400002)(346002)(396003)(4326008)(86362001)(8936002)(9686003)(4744005)(8676002)(55016002)(83380400001)(76116006)(66946007)(66476007)(66556008)(6506007)(33656002)(2906002)(64756008)(478600001)(5660300002)(66446008)(316002)(26005)(52536014)(54906003)(7696005)(91956017)(71200400001)(53546011)(186003)(110136005)(7416002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?JQM9L3OEQhlXD6MnYa/VUMRsZExwv8hBqCMxm7neHEOCgV/vnva2Jko4lwvn?=
 =?us-ascii?Q?6a5hV43yv20zlJHD4OiWZ7JqFrxjRCKRwi4D3aR8wFfWRpNdwzB+OtI1Tuqp?=
 =?us-ascii?Q?L7+NjWgG1GIONUMdtWnCZsT5fT3IaaxfjqRG2Hukzm4fzUIQtwwqCzWMBy2l?=
 =?us-ascii?Q?ydxkeNdzouh67olxMR/iIGc15/qRlXhVaWD6fOJWJf4trGiSm11hJjkcg2jL?=
 =?us-ascii?Q?vBWCuMJ30PTxTvvrpbOiSMiHe7Um+Ht0mx57HkwBsF3drQld0QIMd1lv+mKh?=
 =?us-ascii?Q?/EuvP+OPrq6A48BWYa10L1YtTUigufbDtErUVIZLXoHuMPk70FUCdzvW6JPY?=
 =?us-ascii?Q?b7CnDgnYfPUkdVGHxdTIT8w2/UKvSruMWsgRlEkX+UDSiuBhHich9z0kUJ4C?=
 =?us-ascii?Q?XvNaJtBj5Y1UXflXVz0UCnZNRprdvOPIQiyMslHkC/vAsSps+8HP3xAtxE17?=
 =?us-ascii?Q?gVKZ7CzAKybcpEIjO20BCHfCAyhZN0+/zPpdzd9N+pNqKUvDCyKnYdHhOQBV?=
 =?us-ascii?Q?sLYk/pcR+Xzw97zlXrZnI/WTKZ4x2CssnUE+4KMYDbQcoRB8sNAAvMTIrtG/?=
 =?us-ascii?Q?9BF8YKm0a9aNS/sXsL4FY3a+XjIL87rPhpI3HRdyN9aCAO53BJNFByy0TmV/?=
 =?us-ascii?Q?htJ3LGo1uzagc93ru67FZbKWgLnRUKbfq84XAMif6VxgPRj/1sId4wikimF2?=
 =?us-ascii?Q?8bWEuV8aMBb25XcVqg4EkJs9iQpc6BQtslQxVQdxYC7iUQf9I+79iFGUe/cE?=
 =?us-ascii?Q?qLr96pHL/9Hg2plPbC2nQdJWI0eUhbVxZWja8U7tgiuPZxCxMhx9G18TF6t1?=
 =?us-ascii?Q?BIWMu/BC4BMtyiiKlVhbsobqy4tp696zVUrWmLtmgH3bacZJw4a5yDug4avi?=
 =?us-ascii?Q?/MRJMmMOPkrD0TbEXErimf53cgaIDTba0ei/2knbuPboyxPnkFP4S15AegCh?=
 =?us-ascii?Q?LzqEe/GWZyoboUlIt/p0nbGkjX2vX8pDYeUfU+nBvD58Hk3HBag2BDpgCWIu?=
 =?us-ascii?Q?gdIi/PGTK0fWpr9ceKNt9APVCteH9F/etNlvGJTc87zZ3AyNgJBpo7K8N7bX?=
 =?us-ascii?Q?AnGwC++QZn0LXiYiYAgruyRLfkPajA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN4PR0401MB3598.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edb4c87-c068-4eca-1592-08d8c20c335c
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 15:08:12.8135
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Q0E+MnIjdP3+t2e6Q3SF/nPCtiVsfV+MwOfDhDYdKs+Gxw8i48xjhHtX6szGMutRVdsMhisZcVPNCbyiIQoF8KnrFdBgFcRxwbNEaS3pxFA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR04MB4928
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 26/01/2021 16:01, Christoph Hellwig wrote:=0A=
> Use bio_alloc instead of open coding it.=0A=
> =0A=
> Signed-off-by: Christoph Hellwig <hch@lst.de>=0A=
> ---=0A=
>  fs/zonefs/super.c | 2 +-=0A=
>  1 file changed, 1 insertion(+), 1 deletion(-)=0A=
> =0A=
> diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c=0A=
> index bec47f2d074beb..faea2ed34b4a37 100644=0A=
> --- a/fs/zonefs/super.c=0A=
> +++ b/fs/zonefs/super.c=0A=
> @@ -678,7 +678,7 @@ static ssize_t zonefs_file_dio_append(struct kiocb *i=
ocb, struct iov_iter *from)=0A=
>  	if (!nr_pages)=0A=
>  		return 0;=0A=
>  =0A=
> -	bio =3D bio_alloc_bioset(GFP_NOFS, nr_pages, &fs_bio_set);=0A=
> +	bio =3D bio_alloc(GFP_NOFS, nr_pages);=0A=
>  	if (!bio)=0A=
>  		return -ENOMEM;=0A=
>  =0A=
> =0A=
=0A=
Whoopsie my bad,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
