Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1AD5305132
	for <lists+linux-fsdevel@lfdr.de>; Wed, 27 Jan 2021 05:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239538AbhA0Epl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 23:45:41 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:64115 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388609AbhAZXYc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 18:24:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1611703492; x=1643239492;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=mTnNOaMvhWmSpCd7MNBWRJxVKCJ235YDnMqY4qDrjlg=;
  b=HBmIo/D+vBQ0so2CxRHTpv7EZgCgNabzTUnzu9sQBS/cwKv0mMksOV45
   jLqFD85Ygao39iLjgC5l+zb5GsBuV7WaCUHHewFXcTSMbD+syy0NNcgpM
   /CzeUlh/RlMPJGux+tMN0XiWU18jjZxpaqibqLyJY9aBmmLE+nwhGXIHx
   xY4n2xOCSNfXXTd2B7S7XrCLJ1fcE/db2GhX0RstFVGOWCBrYPaJvC570
   Bzql/RHNtzqmGzl8bOeiSuK1NxUySvv8bk9eNspiqJGGkrsrsTxMBRod6
   xH5zXm+1T/TlZmeDCziODj5T4YyWiVukh5joiJ11oRjnziNz9B5ayvgb5
   w==;
IronPort-SDR: PMLzSjl3IqOwSN0mI2pkm/E4W86liCDmefoMc5/dDkMfzJBhGS4ACERPrrsf54+EREVvFQKXe7
 /W4TaiIXAEX4yWVRK1+smZsQnzX2DPE9cUOWEZXQMayfL5ll3mSsUMruLmANj6P86LSWRu5jvN
 dyeAL0uFOneoIyd7GgfVY+HmsUN1+1vaH0JNhOOCS4KAROO7D7Jwv5XKfGwQLJqz1FKdMuqfJJ
 08L+O947TdtXmkAMHUFI4Ut7QNKn7LZDr5y0C3czLeP2/4Vi9oscktf6KushtDfHQ9SDS8u2WI
 32E=
X-IronPort-AV: E=Sophos;i="5.79,377,1602518400"; 
   d="scan'208";a="262415022"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 27 Jan 2021 07:43:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eBl7szqsNk5cymyxA7b/Q9gpMJoa1jxfUb7n6vR6Esh6G0Kjt2UEVhhRFGM3y1I0glHd/PM6Ec/WxuYp5kFTrhpEVqH02a67n7LMuagrAjqZac0oXk4HyO37YxESo479VoFeBpv0/g5ViIwvkbk/4fNkii7fRMDmcpBYH7XsYgjxxHNDjRHwQHbfouHC/no9nB2eAEG2Xv8dDgUjKGwuBt1U9fPH0lGNfRfSDMjsCFJ3eqFboHzirSpp/VWTLiUIlXbyP9dZ64Ziua/3QRtRRu8vT+98hsvoKJ+VGURL6f7+Ye0s2FcXWyjoGNX+kFJdqskyUuBRy6LJHSo3Wkan4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT8br6vz/nOOn/SezbAG3agpr8MhS4DjGU3jfMYuX/c=;
 b=XIJ6iHAl2BJNnGAlbzdzLaTgmir6HayBV6hCbhWrKTV3HDLIK4+et9CgOiM0iOp2YkZp8JQ2j4pyqZqVjwl/YmFcum9ARDNFKD29J2yjwR/hHTngH4yxuKkILzK/7s5cAKlwav7Bs2SFCEcFo53YFx6gUGSZdJY6nV8OwoxGnYcjy7RNDtoRQoDWNVAB6wtzxIorvisX7awFuN9YkDwzQsEy0vMVp9+/QLM+nro5PPIwN/ffkphCAh7Yj6BXn6T9JMm3JrDDFzTcddV39UXwl8b6wQTCKajfn699HNBReDxFOB9j8DQhhMIDsEoqRQv/Q21puuysmh8rKCXqr0xj9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DT8br6vz/nOOn/SezbAG3agpr8MhS4DjGU3jfMYuX/c=;
 b=Tx18zRFy4C7/LLfZjiC2xYNq9vYqLVmtds3ZXIly6Pkbb7rooc87Vv0ThAVno8Ww+urBcp/0bbimTFQl7hf/7JFqW1bUySUlV9m1ePMEwNcYkeKPjHCNdA8MPOQpDagkwq7KBSS7E36KqzwTKiTxpMh7eNlXaQ8IkvBbHhNEmmQ=
Received: from BL0PR04MB6514.namprd04.prod.outlook.com (2603:10b6:208:1ca::23)
 by MN2PR04MB6991.namprd04.prod.outlook.com (2603:10b6:208:1e1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3805.16; Tue, 26 Jan
 2021 23:23:15 +0000
Received: from BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d]) by BL0PR04MB6514.namprd04.prod.outlook.com
 ([fe80::b880:19d5:c7fe:329d%7]) with mapi id 15.20.3784.017; Tue, 26 Jan 2021
 23:23:15 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Song Liu <song@kernel.org>
CC:     Mike Snitzer <snitzer@redhat.com>, David Sterba <dsterba@suse.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        "linux-nilfs@vger.kernel.org" <linux-nilfs@vger.kernel.org>,
        Josef Bacik <josef@toxicpanda.com>, Chao Yu <chao@kernel.org>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        Coly Li <colyli@suse.de>,
        "linux-raid@vger.kernel.org" <linux-raid@vger.kernel.org>,
        "linux-bcache@vger.kernel.org" <linux-bcache@vger.kernel.org>,
        "drbd-dev@tron.linbit.com" <drbd-dev@tron.linbit.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>
Subject: Re: [dm-devel] [PATCH 01/17] zonefs: use bio_alloc in
 zonefs_file_dio_append
Thread-Topic: [dm-devel] [PATCH 01/17] zonefs: use bio_alloc in
 zonefs_file_dio_append
Thread-Index: AQHW9Do52nd5GTGfH02P+8SlJRgdug==
Date:   Tue, 26 Jan 2021 23:23:15 +0000
Message-ID: <BL0PR04MB65145D02027D58CAF3F59626E7BC9@BL0PR04MB6514.namprd04.prod.outlook.com>
References: <20210126145247.1964410-1-hch@lst.de>
 <20210126145247.1964410-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: lst.de; dkim=none (message not signed)
 header.d=none;lst.de; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [2400:2411:43c0:6000:59be:e05f:a0a7:a46c]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 3672ab75-cb23-4fde-d810-08d8c2515bb2
x-ms-traffictypediagnostic: MN2PR04MB6991:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MN2PR04MB699141B5B4385436431DEE0EE7BC9@MN2PR04MB6991.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:660;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6SIxQcVjcZvwAOYPTqhLZd1XB17uQt0aK1fAR/nnZdW8/1hiE6ZpHh0wggzzlVJMJLMThEoVkj0pBg1JLtqF+rf0fxThv8DusNrcOip0gmsEr8aV3WA4o0dmsEsqnjQw2hMBgwlI1ta1Amm4/2puIvLuuj8Nh6mpsGV5wdkNX5N8LBOpSb4qbPpzM4WqmZBcZgVidgAMuW4ZUL22+TTNxuJzcQJoh1A7GYUGLCj+hWZjDeaayb0VX5vxSdBIVoQmTJ/aqvH0+rmX+XNpbEa6eGiLAWEooIDixsNpCHAQJQy3kQP+yY5rNUahhDmVf4tS4KRRUtAPBH+9wg1Uqg3bAbRHxV2eQlLTbKVTnl9covvkF8ON4UxGErAVsUO2zYu4YgwwP1S6knv6bp5QF5jZddm3KPidAHu6UBSkDkgno42kx6VpjYjSs9FFfQLEl4g/0meD02ntCO3CAe7CscfzST1YWPAdXu3VL3GrL13zRVzx+Rd41+12xV6qityL2JJTNBgNCxxv+9cRFV+hXDnsWQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR04MB6514.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(396003)(366004)(376002)(346002)(136003)(66946007)(83380400001)(316002)(54906003)(110136005)(86362001)(2906002)(9686003)(7696005)(7416002)(8936002)(33656002)(6506007)(4744005)(186003)(55016002)(5660300002)(53546011)(52536014)(76116006)(64756008)(66476007)(91956017)(66446008)(4326008)(66556008)(478600001)(8676002)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?h9X0Gtw9vSaAmaGPbbhrolsYgole2HKvSGxfo1iihE5lnMAH065ng76JxoU/?=
 =?us-ascii?Q?QjnKIfg46M1srZQEr6B2udU/m1X9HRZigI6fpKlWeDreCN5eWI2Gv24QwoWR?=
 =?us-ascii?Q?IJ9ys7srexeN5kNBJTuZ08cT3nJmCCq0j/7NOA/3Dy4qSUx8QtZP8UPS4upx?=
 =?us-ascii?Q?x1QNwsRkgrT88AA3q9OkNadrFEctdP6kYAOieAE4KOH1aB3knKV9b07MZ/OG?=
 =?us-ascii?Q?nLgpsuGgzhimsZMHiFTlTxdr9PNwumU4x9y/d+3NImG6+l+pKF1qxDdazbSw?=
 =?us-ascii?Q?gUum+Gb0HqPdp1gdcOcUhszciUv4N6fvoxYe/UmkU/AkfXzD89h7OejmBOBX?=
 =?us-ascii?Q?tCU1fqqH3M9PLYFwQkq8Z03FEC2QWG2pGrs30kMnq/lhAkZ1p/O5mJg3UhKI?=
 =?us-ascii?Q?BQoSozZS9lCqqA+Ea4fcvLAUumN+Hv4U3GfllgXttLwDI639o0pzyJLi/leD?=
 =?us-ascii?Q?wvAMu0s3b4ZXIY3o/A+RZdtFylNqvwJrzHw8X4dFsLwlm04TuUXKGLyH5S+b?=
 =?us-ascii?Q?FY1MDDuz6tMhQ+EfI5Ciwnbl6VXyWVJtceM505RMWvojHAvkQvAlBpJMQNdG?=
 =?us-ascii?Q?fF6D36v0Jr7UtoAZFOW1HyJ4S7rTSYc/92faN3BdI+SLDTx7J7sVAZ2md5DN?=
 =?us-ascii?Q?8bc32ncxeKg10oW6EUS6I3vL8Yhyscii5HO0oLjr7yZX2FYINzLA4UYu8Rf+?=
 =?us-ascii?Q?acN0ZMUhmQYZNnIzqy9pCv/XnVNP56XQ7PEdeC8nfs3lvyc5MXk4YMLoctM1?=
 =?us-ascii?Q?LIGKS6YmRDQWrBaByDPNXQiaLhKr3LXyuTahZ0NdobdpnjmoQwZlU9LdjSiO?=
 =?us-ascii?Q?b8n2l8k3HY5uoGpQM/y/Ki3Z0HVdKTC3uPRE/qvifSJlivrc1cO0teToFHWU?=
 =?us-ascii?Q?rmUhhJ5MHTlG8uzh9YklJXOUeARwq6nBlLUFE6IsGEM1GV07CIVVSTK5/Hjk?=
 =?us-ascii?Q?sdx8kid58h9LCuH1RqKtCmc8B4sfw7q1YK7+296qR7fVsLyHgtl+sC3Pq/UY?=
 =?us-ascii?Q?m06sV25q2Vxf///Y2YMG7/AtZantlOVcf3QAvuzHdMSidh0bIbh20KRaFpOP?=
 =?us-ascii?Q?DCmWfsAKSuU0tgd2hTmk2HIEZZ3Enj2cEwXKgbFYgFCWtl1W1msJ/l80bUTH?=
 =?us-ascii?Q?vV0CgT3SHKPwYUKs9LHIDDBJKrYxNRWiJA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR04MB6514.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3672ab75-cb23-4fde-d810-08d8c2515bb2
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 23:23:15.7291
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2Ys2pEm4dwPypxXNQflN2ZuOc6fOAfjNaKAfawRkYdKvpX11zpiJWlnZxqfTCWDH3c7KpfDYuSpoMS0HzU8HRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB6991
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2021/01/26 23:58, Christoph Hellwig wrote:=0A=
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
Acked-by: Damien Le Moal <damien.lemoal@wdc.com>=0A=
=0A=
-- =0A=
Damien Le Moal=0A=
Western Digital Research=0A=
