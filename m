Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB998741E4B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jun 2023 04:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231766AbjF2Cee (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Jun 2023 22:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjF2Ced (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Jun 2023 22:34:33 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A8C2213D;
        Wed, 28 Jun 2023 19:34:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1688006071; x=1719542071;
  h=from:to:cc:subject:date:message-id:
   content-transfer-encoding:mime-version;
  bh=AuFgyNcDu5bX/Ht5qhE1bnxKCSTy723bpVk9ytNCtN8=;
  b=SqR4qhsW05Q2a7jM3hMRlWs8LxDoF20HtJ1U4HkcSFkABaV+9fM/dmSt
   lw5Vu9k8S40s4+uhg6cpBdtkDKrmOA7v776B/jTiuIpk4YFKWNEFavLRL
   Pmz5+L8jIY1x2OAfQwuFWDW6ODzPmB4LAAlmBYoXeiMWQD24n/ylA3bJk
   9cufFxOWdVflpiZnO9boXQypkIvqbqBnfmjdN1LP2jl949ZYZon9XjygK
   o1+eJ2kVc77jXzjPBnpxF4rUw27R4rorq/eV6CVxSjGqQ02W7niM+yYe7
   59OjXdqXlI/zFxcBm9VaGFGuhlXHdu41+3dlqyWnre/9VMqr+d+pGKdZU
   w==;
X-IronPort-AV: E=Sophos;i="6.01,167,1684771200"; 
   d="scan'208";a="348674583"
Received: from mail-bn7nam10lp2106.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.106])
  by ob1.hgst.iphmx.com with ESMTP; 29 Jun 2023 10:34:30 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=U5m9Wnpqlv+Z6tAdPT5A0uxTocQ87tveN/Wpb9eOdxVK8eIkUrpcBiFHwTQboUV4dWaRyuPo1e+zCZWa/P91gq63NO8sywSPqJEzcGnfsqJuW7iw9h1zCCs15YPEfYcECUq2dGBZdI1nfuTxpor/op5GX4r/enrgYBn/0jbBvI5E2aeTz3Qp8q+kZFJjbaejobO5Qpqn+ffxUnZJNPtd0dJ7nBmihpujg/OT+9Guo/MUZmymJQ+DBhllITY22nApw5bmujP1U2FrpraTJ5GNenDTTdDn7OB6kFI2Zofj8vMFKp+MG9IrNuKy8EIbxvVfpRph7KxwoFc8np9+CyHt5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eKBLUMkhw2SdIo/4TeH+rI2PGKzRZ5HNTrVli33TqqA=;
 b=R0TX8927X4b1yUNO0M71vvJVm6rFKjWkSC8klaG8/BsMSrLwZa2FiVMYMrlEmKnHfakah+L+QmNAurPuqkBbOWSNehUFpcH1thNpDQI4+P4lHHj1rThCIwqQ4+Znxor2ryC6wv9pHq4peBdn/iSjyWOS66kk1vm1hc2+bALj9YsDLa4OsuiDcCAeWeVvQrmSzdo6ISjTly3MSd73twsLNN4ZGDHSZgQkORrNx06XnCmiOHviepE/j3RD3fseUR0qxoiabK6+6B7xDs1jYInRM2EQIYwbYHksLpJ9M38hhNpWQ9+p7B9uokTnIH9p3229v5QXVECWMVKUkr8WQXqfSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eKBLUMkhw2SdIo/4TeH+rI2PGKzRZ5HNTrVli33TqqA=;
 b=UmNaYqrIcFb+8XUeL4n5e31QKOgQqVffqRdeyL7Mq+fIlgDDEylHp+TCGtzEw4HpiAY0xtdLYOv5HQvGW9tIaheKxNsK3A/9kuR4YRGiJMgMPr+54fKVp5rICfNazZ4sX5/rSripPtgyuX6cgKIanvPx2RjIOLzdmMpT+Tv5634=
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com (2603:10b6:a03:300::11)
 by DM6PR04MB6623.namprd04.prod.outlook.com (2603:10b6:5:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.24; Thu, 29 Jun
 2023 02:34:27 +0000
Received: from SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01]) by SJ0PR04MB7776.namprd04.prod.outlook.com
 ([fe80::e9d9:ae8:fb59:5f01%4]) with mapi id 15.20.6521.026; Thu, 29 Jun 2023
 02:34:27 +0000
From:   Naohiro Aota <Naohiro.Aota@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Matthew Wilcox <willy@infradead.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Thread-Topic: [PATCH 01/23] btrfs: pass a flags argument to cow_file_range
Thread-Index: AQHZqjI5123BXeqqtUCGAGOzr2RhMw==
Date:   Thu, 29 Jun 2023 02:34:27 +0000
Message-ID: <87sfabhu8e.fsf@naota-xeon.mail-host-address-is-not-set>
Accept-Language: ja-JP, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB7776:EE_|DM6PR04MB6623:EE_
x-ms-office365-filtering-correlation-id: 6e53796f-3c59-43b6-7265-08db78495bd9
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HkI2jxEERZHwxOQLpmEQIIrYT6OBHs1gz40NxwsqCbTP/STKPbpvQ6nOOqwlERW1DjKA2iDqyPiqVLK5b6TXBQzOLChs/0S3DrB4ONYHqb8jQD2S93ZsNPKIRr4d8Im3P3uydV9oEQ/xPRfaaJ5Jh4Y+SeOaf4FWTvyVYdGNDBAbxBBCaAbALZoDZ+dmWgd9d8+eC8rSSdO4Gzz/9t67ZTZVMMEPNqbL6/4R20C8THH8/u2b3+qK8q+BqzF++mc76J1Sz5th31GVe/779LzHbRAfSjOx4KCee/3BtQ2tdkugPuNwxERSLgZlHOuM0RggLBfXnwp5RNSI5oxflmNSp9qDXNWtnUZsq4tlH+vnCGPeamUww2WCaQiJOOfyUDOvSdMNPE/SVIEoBSF+p0Y4DZuxWC+tblUIjIJOAFCXYs8T9IwRbb63hFqcu5NPdWYmNfc7GVglkVk7eJPq7L/qnwL66PxIL57qY6kIfJRzjbAXcJCk5tRBcmLArN26KQNedncXRSCZhQLpzL3X7QgQTavNLpFx2N64hQQxfltVJxc8ZvhFHb4tDxtySJ28IK5goOcoEGIHgcNOZ1ySMZlN3Z9j45t8ezS9rRvJcUTxKcj2ommzRfGG0QAGN0yxkgBL
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB7776.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(39860400002)(366004)(376002)(346002)(136003)(451199021)(26005)(110136005)(54906003)(2906002)(6486002)(186003)(82960400001)(38100700002)(83380400001)(6506007)(122000001)(9686003)(71200400001)(86362001)(41300700001)(64756008)(38070700005)(478600001)(66556008)(66446008)(91956017)(66476007)(316002)(76116006)(4326008)(8936002)(66946007)(6512007)(8676002)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?I2INfT10BZ3af1F2mY8HdhGCDnpIZkA8UP/TWYFBncKqEHL+9NFBQPbOBk?=
 =?iso-8859-1?Q?p3+14xtU0JWhbCnSU35f/ud43bEYGpzKm0R8T5TWyhB5mdqvzP6KSuklQE?=
 =?iso-8859-1?Q?Ov7octO0t7ROORUSoC8WCUjOzuD67klIbm98upnCtZyHL9dtgzPaglDnAf?=
 =?iso-8859-1?Q?dFtDFPIdx0rjol3RfT/Y7dc8gMCh4mcE9JzJ489xvN+erYlr2YtK+XNGts?=
 =?iso-8859-1?Q?Y9/G4xs6jvplq/dr6/lDELzvpG9p5IIBQsZNmz8Ybwbo4mg6AcbttyDeKj?=
 =?iso-8859-1?Q?6POAQtk/Ds7L9dj/IPBMaHTsm7tx802XLYaW+2UU/QEBW9stesf72zLoTd?=
 =?iso-8859-1?Q?c2HLxeDIFz1fweE22ueWEU3bQtuF9d3lQyM7RxVaP69m//lomf3Vo4fBpb?=
 =?iso-8859-1?Q?E6znQCUSA8zckAQLtHoQkwKett4iergoG222Ggac79jDXNMgM/CnSqlMzY?=
 =?iso-8859-1?Q?zVN0IappDoPa/1/Hs1mXlwYhhHxeI2c9XTZJ8CAm+XLNcwCg6KV9gD3X+Z?=
 =?iso-8859-1?Q?2qkeCJdk3Fa7ZqyR9QQEZ0kE+pBrd72UXsbgVWGCE2VkX5rKLC2ZVSkw55?=
 =?iso-8859-1?Q?zx20pSRu1WahaZCDQG2/G8rYuzlSF1L3DSNf+RelX9kLejpQEnKuDFP7vL?=
 =?iso-8859-1?Q?o2TjcLNItJwXOzwkBOIP6RwGGb6X49szm21JPlqw1YEd4EO0dVG8Az/yBl?=
 =?iso-8859-1?Q?d+yT6ttgof/XrBPz8Sv8+F6Sk2cJTQGDxam8RRKFJcXukv/+VO8rJ4qY83?=
 =?iso-8859-1?Q?ulgqPi3uRZ3EqMW/9cPXswqfulP/aXIv77wNfSX6A/4STY7DE01isPfOLC?=
 =?iso-8859-1?Q?td397KXL+kqOe2L8A+YE3FiKf5CqFuNa0A6kdE37mz7VDfqBErxsILp2Hx?=
 =?iso-8859-1?Q?bCal+vVlcHn4v5BpMgCMM/X7gycHqJv79yMUH7l5FEcvlsihTRE0UskQ1+?=
 =?iso-8859-1?Q?/7rXYsFo/o2TGMtohsP6l2klsEacL3ax5tiFUe12GnaGZjcEMZnKHvyIew?=
 =?iso-8859-1?Q?lQadtTeGYhIKngsKI051XuP6woWZOFF5T4BgSHK6p8f29wihpmqGBdT6GM?=
 =?iso-8859-1?Q?cociyobKDPC3TRAp1pKmdVn+Hvw7Z2d598p70amkLJDmKagyvU+Aivf1W4?=
 =?iso-8859-1?Q?JYeS+BWHTtBC6uxwH+0PobktIaTpDDe/0JDp6CpzsGE88sDqu6qpMz6f85?=
 =?iso-8859-1?Q?ejCV1++ln/txWilEu5iC5pfSmt6UkXwVo85ZILiSIAXR52LJLRDRiX8Not?=
 =?iso-8859-1?Q?YOzTyZS+EvOSH1Kzy8Egel+5gIIXV5nIbPZTtLZOa5kzzCduIoEjLaZvhE?=
 =?iso-8859-1?Q?NPyVq1w2reSTdb0e90duHJxXKWjxd5nGrEiFVYWDWJM6UTxTGCwa0feHdi?=
 =?iso-8859-1?Q?YdOf9HB1KPaXdBhwkFvnENVJb5oNTVCNiHlBy2DXiWRomXEy+Y6sfVsGki?=
 =?iso-8859-1?Q?S89CAMOmuDZHOB959Qv/Mw5a8RAs9mrZdOR6eFfD4eSBv3myr9AFMH60XF?=
 =?iso-8859-1?Q?6PK6UXXg1IAkGaCnLmcuhJ6odFAmNMemUMR8mMBoFCbP8TmzQv0NeQTf/G?=
 =?iso-8859-1?Q?r1r68gwy5sZEevvixS2hKewnZsby7pAVbXrCj0vbLBQNvQx+6k3zU0XMMe?=
 =?iso-8859-1?Q?bC/ZFApga4JayIeut/A8AfN3VI/uFm0p8Jxli0tEHl4JVc6NamWqDobA?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: OGv4oh+7iwRtUA0B9AVtY081aa2D9l3VBxn2pWkUcmIiwHLP+vK99O3EmE5wg8qSQPOqXWLrs74ADnq4lYheJIQKP/YX2+H81SShp9tTpO9DFRN7CpkQZTsnxLEOGGIN8mPgWcPPHNWo87+JXJgNW/f94w0I7ZWa3bB6CjyhpaVl1+hwtj5tJJfayXfzn6mezjS2OKQcXy6VX92rh2RkWzTmCEk5wGZFxobS+nPx7mHXXdd23i16XcrnJeyes0N8qpHeIf3rCwbMN8mNyc9oW2wCser6dlAyHRfs0cVdAkD/+eqMA6fl96n5XAmQ13lP6iKv1fnwIKDOYoNWaEhEVgc3sv/DiFOAO4w11km+B5BVHQgz7aQkv3US/MStiC1g8yNL1VPlApoaJOTYtPxb3S5LMdR5XDchbK/u7msYgXGFOZ9Z6oX0fzEN5awCfGK4rz5R28zOpyoepGloTlzHyl8kipyOubhRNI2uy0+waPPjR7BV4v/RR3L9LnxUrH+N8VmoWcFCP6moobvvaX/LcRZMc/SH7vka4thTGh/WcWc2Fq20xNGHwuyiUE5XlcoT0JuuZeesWwp6WEYqzps3H25tySjd8of3P5MIPszN7u0GnWl8LsKGiDWHG9UeSKyZBroj5wQDDqnIk49EDZobuOsQS0us4LCDYArtw4fHQbi69erPmCoU49gCIjZ5m4SB+wBxupo+pUaq5whqOMA/lNNN57uKUSxsJe3rK/hIEZ1Hp+BiUDsJFVxj0DspFrIdnhCZXr4vfl2uqovcKTJTPcLJUCuj677zGqhK+TN+ZKDJmU1NQDyhGnFqrjNsGFTDb21YA1WnGejFe7nykvHlviwNljbxPVLlBSIvtfhXvbEEs+qojRWlpLamBc6++eOXwyez+pQSHeToCSPvHl0GtQRelvbub/Z6KYxJ3zo2mKA=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB7776.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e53796f-3c59-43b6-7265-08db78495bd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2023 02:34:27.1770
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EHfJvatXG1JJF6bjF8HafMo87lKCPLVCNuWxFaa9+jn5NFgVOTdTKbkXcpfe0pfL9JeBumZUmE/9sRMAXRvK9A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB6623
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:

> The int used as bool unlock is not a very good way to describe the
> behavior, and the next patch will have to add another beahvior modifier.
> Switch to pass a flag instead, with an inital CFR_KEEP_LOCKED flag that
> specifies the pages should always be kept locked.  This is the inverse
> of the old unlock argument for the reason that it requires a flag for
> the exceptional behavior.

Yeah, I always struggled to remember which is the "1" means for, lock or
unlock. So, giving it a name is really nice.

> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  fs/btrfs/inode.c | 51 ++++++++++++++++++++++--------------------------
>  1 file changed, 23 insertions(+), 28 deletions(-)
>
> diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
> index dbbb67293e345c..92a78940991fcb 100644
> --- a/fs/btrfs/inode.c
> +++ b/fs/btrfs/inode.c
> @@ -124,11 +124,13 @@ static struct kmem_cache *btrfs_inode_cachep;
> =20
>  static int btrfs_setsize(struct inode *inode, struct iattr *attr);
>  static int btrfs_truncate(struct btrfs_inode *inode, bool skip_writeback=
);
> +
> +#define CFR_KEEP_LOCKED		(1 << 0)
>  static noinline int cow_file_range(struct btrfs_inode *inode,
>  				   struct page *locked_page,
>  				   u64 start, u64 end, int *page_started,
> -				   unsigned long *nr_written, int unlock,
> -				   u64 *done_offset);
> +				   unsigned long *nr_written, u64 *done_offset,
> +				   u32 flags);
>  static struct extent_map *create_io_em(struct btrfs_inode *inode, u64 st=
art,
>  				       u64 len, u64 orig_start, u64 block_start,
>  				       u64 block_len, u64 orig_block_len,
> @@ -1148,7 +1150,7 @@ static int submit_uncompressed_range(struct btrfs_i=
node *inode,
>  	 * can directly submit them without interruption.
>  	 */
>  	ret =3D cow_file_range(inode, locked_page, start, end, &page_started,
> -			     &nr_written, 0, NULL);
> +			     &nr_written, NULL, CFR_KEEP_LOCKED);
>  	/* Inline extent inserted, page gets unlocked and everything is done */
>  	if (page_started)
>  		return 0;
> @@ -1362,25 +1364,18 @@ static u64 get_extent_allocation_hint(struct btrf=
s_inode *inode, u64 start,
>   * locked_page is the page that writepage had locked already.  We use
>   * it to make sure we don't do extra locks or unlocks.
>   *
> - * *page_started is set to one if we unlock locked_page and do everythin=
g
> - * required to start IO on it.  It may be clean and already done with
> - * IO when we return.
> - *
> - * When unlock =3D=3D 1, we unlock the pages in successfully allocated r=
egions.
> - * When unlock =3D=3D 0, we leave them locked for writing them out.
> + * When this function fails, it unlocks all pages except @locked_page.
>   *
> - * However, we unlock all the pages except @locked_page in case of failu=
re.
> + * When this function successfully creates an inline extent, it sets pag=
e_started
> + * to 1 and unlocks all pages including locked_page and starts I/O on th=
em.

nit: @locked_page for the consistency.

> + * (In reality inline extents are limited to a single page, so locked_pa=
ge is

Same here.

Other than that, looks good to me.

Reviewed-by: Naohiro Aota <naohiro.aota@wdc.com>

> + * the only page handled anyway).
>   *
> - * In summary, page locking state will be as follow:
> + * When this function succeed and creates a normal extent, the page lock=
ing
> + * status depends on the passed in flags:
>   *
> - * - page_started =3D=3D 1 (return value)
> - *     - All the pages are unlocked. IO is started.
> - *     - Note that this can happen only on success
> - * - unlock =3D=3D 1
> - *     - All the pages except @locked_page are unlocked in any case
> - * - unlock =3D=3D 0
> - *     - On success, all the pages are locked for writing out them
> - *     - On failure, all the pages except @locked_page are unlocked
> + * - If CFR_KEEP_LOCKED is set, all pages are kept locked.
> + * - Else all pages except for @locked_page are unlocked.
>   *
>   * When a failure happens in the second or later iteration of the
>   * while-loop, the ordered extents created in previous iterations are ke=
pt
> @@ -1391,8 +1386,8 @@ static u64 get_extent_allocation_hint(struct btrfs_=
inode *inode, u64 start,
>  static noinline int cow_file_range(struct btrfs_inode *inode,
>  				   struct page *locked_page,
>  				   u64 start, u64 end, int *page_started,
> -				   unsigned long *nr_written, int unlock,
> -				   u64 *done_offset)
> +				   unsigned long *nr_written, u64 *done_offset,
> +				   u32 flags)
>  {
>  	struct btrfs_root *root =3D inode->root;
>  	struct btrfs_fs_info *fs_info =3D root->fs_info;
> @@ -1558,7 +1553,7 @@ static noinline int cow_file_range(struct btrfs_ino=
de *inode,
>  		 * Do set the Ordered (Private2) bit so we know this page was
>  		 * properly setup for writepage.
>  		 */
> -		page_ops =3D unlock ? PAGE_UNLOCK : 0;
> +		page_ops =3D (flags & CFR_KEEP_LOCKED) ? 0 : PAGE_UNLOCK;
>  		page_ops |=3D PAGE_SET_ORDERED;
> =20
>  		extent_clear_unlock_delalloc(inode, start, start + ram_size - 1,
> @@ -1627,10 +1622,10 @@ static noinline int cow_file_range(struct btrfs_i=
node *inode,
>  	 * EXTENT_DEFRAG | EXTENT_CLEAR_META_RESV are handled by the cleanup
>  	 * function.
>  	 *
> -	 * However, in case of unlock =3D=3D 0, we still need to unlock the pag=
es
> -	 * (except @locked_page) to ensure all the pages are unlocked.
> +	 * However, in case of CFR_KEEP_LOCKED, we still need to unlock the
> +	 * pages (except @locked_page) to ensure all the pages are unlocked.
>  	 */
> -	if (!unlock && orig_start < start) {
> +	if ((flags & CFR_KEEP_LOCKED) && orig_start < start) {
>  		if (!locked_page)
>  			mapping_set_error(inode->vfs_inode.i_mapping, ret);
>  		extent_clear_unlock_delalloc(inode, orig_start, start - 1,
> @@ -1836,7 +1831,7 @@ static noinline int run_delalloc_zoned(struct btrfs=
_inode *inode,
> =20
>  	while (start <=3D end) {
>  		ret =3D cow_file_range(inode, locked_page, start, end, page_started,
> -				     nr_written, 0, &done_offset);
> +				     nr_written, &done_offset, CFR_KEEP_LOCKED);
>  		if (ret && ret !=3D -EAGAIN)
>  			return ret;
> =20
> @@ -1956,7 +1951,7 @@ static int fallback_to_cow(struct btrfs_inode *inod=
e, struct page *locked_page,
>  	}
> =20
>  	return cow_file_range(inode, locked_page, start, end, page_started,
> -			      nr_written, 1, NULL);
> +			      nr_written, NULL, 0);
>  }
> =20
>  struct can_nocow_file_extent_args {
> @@ -2433,7 +2428,7 @@ int btrfs_run_delalloc_range(struct btrfs_inode *in=
ode, struct page *locked_page
>  					 page_started, nr_written, wbc);
>  	else
>  		ret =3D cow_file_range(inode, locked_page, start, end,
> -				     page_started, nr_written, 1, NULL);
> +				     page_started, nr_written, NULL, 0);
> =20
>  out:
>  	ASSERT(ret <=3D 0);
> --=20
> 2.39.2=
