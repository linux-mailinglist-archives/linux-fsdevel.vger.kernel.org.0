Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4F55A917C
	for <lists+linux-fsdevel@lfdr.de>; Thu,  1 Sep 2022 10:02:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233616AbiIAICu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 1 Sep 2022 04:02:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232762AbiIAICs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:02:48 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69249121424;
        Thu,  1 Sep 2022 01:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1662019366; x=1693555366;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
  b=GWHaEpfu2IgRyfjiw82uTX4wkT3JnoR3qQycIUvNhiDV+xVB8Nr777Ho
   vXqzyOfMlYJhNeL3s1ui9Bei99/J4uOXgP+NSWY/ilRvepZUPHUbeNkis
   jKLOlw7KtmoJv3DOG7mkcJzaSQE96CLvrYN7mbdtGGG/Q836FJjJ8ou/x
   WYX3K6LPLh6qvTOvfZEChHmdck20cs+kRAGya0htomD0iuhPzs5u0YrEu
   T611IM9ZiV4ahVH7Grve3u77CgUP1U0u/p8cK1askCwdxqPJ3P3x712k7
   LaluSu86exHqPiPMBSkVm7WHF8sGXnlxKIq84byVMhlw7RFfQSTAv2+uZ
   g==;
X-IronPort-AV: E=Sophos;i="5.93,280,1654531200"; 
   d="scan'208";a="210205905"
Received: from mail-mw2nam12lp2043.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.43])
  by ob1.hgst.iphmx.com with ESMTP; 01 Sep 2022 16:02:45 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PFfXpTqoTDzgqCEJk58PuCabo/MMmRCdZPhMExUeYmgtzADXr6Yzuld/QQUU198wl5d+8WEQDBBffNFH+3GK7E8+QF/b4E3JaGZAu6naqbZA3t/yqLMg/+MpdjtvXLYlxBH5XYIKFeb3Z06WP7gXbxqR6d3ndLorimtmWNBwHem6/ZWaykZ0c/jIl3ZZ3r9upR0vVcPiGOWOi1HjZa4fQ+imtcOYQQOqmMICOrIQ/LNxfxD57jEg4I5Gg7PDFnqchW9gEc/5qOz5yh9I/tfc26Us3FAKFSgi3y4mYB+leBj91J1x+fjEQwAPC4szkYhIE8NNTOgAQs+3MMIMFoI4Tw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=ZjUzp+eD1GXYwOfg6BZWt5swqJDQJzfjhqZ/AUu9NZVaA8TxuPvv4ntmhnsNx2nwwvZCHRVOatPbM19rUHWnq7vV27ZDyvxy3S4igrhHls645gBOmZf2/fyY1PMCWfFza1kIsPnPD0s3qOcdj0vQTghNfd0qs+xAdji4j0kw6BQH4mRf6v1WTNakF7vX1Tyc1AWTLAPJFAY6xJgz/ULHHmS36zPkPm+cthDYcbVRP7GtAQ1BXye5r8L7kwcB1O51eSPDeHXA0j247cRBomrfNROgSlzFNd8lp9ko4/uBz1qp6uk7KIsvX/eZ4jWJsxFDLCfI+ywgVxiHOtdxEZvjaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G8FZ0D3PP/OudJ5uuxCAz/C/vBHo8wESZoPwxTWqVEI=;
 b=kBCEyYHvxHoXKm1d1g13sKwGrCOUxgmTFSKU9kjrgs4Zj1LVU+DHU/t4Gp1BLCd2fg3L6/yhM8TCOEFnisCYkOMagAZcMMUz5GpwDjLlp+FaTc04uN5EOFntE1tx/g0izJ3sVwa+S5qOczbCRPzWK2gf7MYwW/IGrDve1vbC08I=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BYAPR04MB5848.namprd04.prod.outlook.com (2603:10b6:a03:112::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.21; Thu, 1 Sep
 2022 08:02:44 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::bc05:f34a:403b:745c%7]) with mapi id 15.20.5566.021; Thu, 1 Sep 2022
 08:02:44 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Christoph Hellwig <hch@lst.de>, Chris Mason <clm@fb.com>,
        Josef Bacik <josef@toxicpanda.com>,
        David Sterba <dsterba@suse.com>
CC:     Damien Le Moal <Damien.LeMoal@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>, Qu Wenruo <wqu@suse.com>,
        Jens Axboe <axboe@kernel.dk>,
        "Darrick J. Wong" <djwong@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-btrfs@vger.kernel.org" <linux-btrfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 01/17] block: export bio_split_rw
Thread-Topic: [PATCH 01/17] block: export bio_split_rw
Thread-Index: AQHYvdZlv7I7R6HH8Uy7pCzFAa8j9w==
Date:   Thu, 1 Sep 2022 08:02:44 +0000
Message-ID: <PH0PR04MB74166210BEF39E6B2BDBCDF99B7B9@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <20220901074216.1849941-1-hch@lst.de>
 <20220901074216.1849941-2-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 453cec9e-4261-458e-2c61-08da8bf059c6
x-ms-traffictypediagnostic: BYAPR04MB5848:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6s6ibw31yC6KSWq15R9znwkbGI8WIv0u8JROcJmZOmh69aL+pChQHB5UCAf500zAgOBAim3L+6sowM0yq3ibqMyjen2KpygUIlLpuayJVCNYj8Dp11nmc/SKg+xU3v8LMXYxzosm6S55tp5M3wy7gdsn5jSFrKfUa7Ibd2NjNho7n1TvU3A/Iw8arfp2u5KfsfFIJ//ew1nnuE8MaqUs6m283wMK+JA6sv+eLPeo7MMo2ZaAFr9lqUvvxWDm6uI8CtoboNeD96WuxazvXm2N2uoChUqGOldnYdvnSsp8xk385KdAVwrlbgu0LwWfVgEDxNBL1tbCeCa6dYXIoSwF4CIr5BIRd8gJ/9KZRrdnsQRLaZGx01/8G+oGzjsx4wxOIAWRedFleopeCCILPjMe9V034xK9nESjpStZdhnaiflOWFbAwiVdTF1bic3PwbgErx1T2Dv6MvHK36JgmQW4UeWKCPP3HXU3nHLq4SbMperOM6b2hfHP/nIKRZrF08piw1RwiuPnn9N97dvngW3IOtF8D37X5tjzoBG/3d0Uyfx3nx7mAhOasG++APhftNYyo/d/UFS5A9lyZQ5Gy97D2Dc2Bcpf8UWxidTW8/gPRWXxSlwKlGI8ayUDiAA65HKc8ta0gHdqBn4mk+Z9JzsAf/FJQe7Oxbf/lmn+SrykXjYaYCln9Hm2SqmaO+HIp65KrFfTrXklT/mpkgVlsFYs8wIdtdSxO+T36MSgXbatiIptBKaGG1Qn8iOuy9rza5gpkJH5n/EwZwUu9O0o/OeQrA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(39860400002)(396003)(366004)(376002)(136003)(9686003)(186003)(26005)(6506007)(41300700001)(122000001)(4270600006)(7696005)(33656002)(38070700005)(82960400001)(86362001)(558084003)(478600001)(71200400001)(66476007)(55016003)(8676002)(4326008)(66446008)(110136005)(316002)(54906003)(64756008)(19618925003)(66556008)(7416002)(38100700002)(76116006)(8936002)(66946007)(91956017)(2906002)(52536014)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?LYBrykv3njQ1RcasxDcaj09tX5yFD0ZXrpik6ELEtteeWlIfoR1uNXB6rFcu?=
 =?us-ascii?Q?v6cN85ziI4KjQUvoaGtjxOtg8NctBVRmbgJzUgHHB6ApAq9QMwq9zEFil6yE?=
 =?us-ascii?Q?E1QugVXD4LfCYmwB2IuLCjfkF0T5x3pPxcXwPU+L2O1CFq0CdUAP27yJQ3a+?=
 =?us-ascii?Q?9VT+gTVTq5rUS63HGkPXMLfn3yHuC3DSheXWI4SJBmyzpYq3IuYxLGhmdCyO?=
 =?us-ascii?Q?9L9o+mMP2K/JT3i5p4ScHRrR7RnQqrEPI354kZNTSwJcV0qGoAEOQs/cgO98?=
 =?us-ascii?Q?5BW2pbIgCSJRAUgyY+KqHtIBj5Rw0TlwOqdulLdV595p1KDJsKjS8KOwMvMi?=
 =?us-ascii?Q?qoyI92CCd0JKgDwI6NwYGPfkzRxkQ1Fajtd4i0VOvDpwNiXx7myK0UYJ4z/R?=
 =?us-ascii?Q?CvtAsiv3dTEyYpe0CQsLv8yq11WnZ6r/tAJw1TFYBoQbAcmEEZJXt8fr8p2q?=
 =?us-ascii?Q?appWikLjiQPSbo4zSSuSEFPVDS8cmZut/zqPlFYYhLkjx9wUtV8cJWq+FQoq?=
 =?us-ascii?Q?4ro+SW6+oJjHUAzE7mkmABwLgKC6C0WFNR2sNF2QKcJ4vpVJh8jMkPWrOIcy?=
 =?us-ascii?Q?go+1bK2acwHP4a5stNhkdU24HpXMtMi7z8eiZn79IRCvHZ9SrsXizWv7+5oA?=
 =?us-ascii?Q?8qF6Een8lRbi2Trc+vQKsf7Gb9lqlxycCEGfV4HjB6iob8Qko4WFxYxiq7Pm?=
 =?us-ascii?Q?PHHS+HkCGMQa+TNLZT6h1/4c7wIauAqFKSvwGRRfcdlihSvshfCwuDLhcCSK?=
 =?us-ascii?Q?3ekX5GyciEi3x+DwKNqW/EuujCsHBxKZfXHQ6i9/IFxAp0UF7ykIIVpf2mvw?=
 =?us-ascii?Q?cze8BZGboCNZ428tGIgiLrL05FAUX75a9apJdkjEFJuwbUZD1buMpYtAIy9B?=
 =?us-ascii?Q?btMg69pPKt8n76Ke6bGPGf+sQFv1IOT+iT6HgslTW9Wpvo/WtNfbeLCj8MaK?=
 =?us-ascii?Q?ZcubyPw3VzcDaL+ihKxL+r/4R+O6RvVNTuyfW1TPLajRPnXIPKY3pMx9Asc9?=
 =?us-ascii?Q?rFV/cL7SJljr0QCgBF6hf3R1ixlX7m/05Yv3BBqUzVNrXpn+/BwJNPEqoVKB?=
 =?us-ascii?Q?gtVLddNoojSQ1UnuOhp+YzvaLUJrfHsSaxB5NB5AdwTNG2hLR8gv83V7GYez?=
 =?us-ascii?Q?oBrF+l3f8d6dk4UpB+EabqsXvl9L7OxbpsL7dueCppdPmlKyhvfEq2a297qL?=
 =?us-ascii?Q?zbizWHibHQ4ha9LLynHMXTE+icl0fGWre/KdKS38N1DPwXfcTxc2uYY7JlP7?=
 =?us-ascii?Q?lm8QkuJtC/R7jErxEyr534DqrGT0LtxkBrO6Lsq903S2bpi18ONVCGtTDtNk?=
 =?us-ascii?Q?zRegtyYilGk8YUOlZLlodOdjky0k2EdD3fME8re13imvmzMKgpb997NBKs+T?=
 =?us-ascii?Q?Nz43+mnJGc77yf3mp3Hj7n7fWftCRpTrL41fDMXORa1XgCm1Cq7F0+ElNuZO?=
 =?us-ascii?Q?pAKMC8ZWf8wrO7WpLmIP2safdaP5jXKhadAqqX+BvUeNThy6h0B7eGh5Sqjc?=
 =?us-ascii?Q?IGayCfyqVVkSjXL1DOdHgU3zhSVcZCcpcqtETFYjxI4IdcpcN0hUmccsOxDa?=
 =?us-ascii?Q?VwCLNAN3abTWNMx2xpQnX6SD+sSLVVt37F5SJKHN2Ne6fq2hwJ8CNiSH8zEC?=
 =?us-ascii?Q?0A=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 453cec9e-4261-458e-2c61-08da8bf059c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2022 08:02:44.0605
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6RhEzi0oSqbGJNjqWCygipUMK46yM0ipcDLUagujn4/748BAz3vdJ9LBOVmxyHlP4g3HtrGXEJjnGQKNYccNwBEei24NcdTgmWwDmCbICqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB5848
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,=0A=
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>=0A=
