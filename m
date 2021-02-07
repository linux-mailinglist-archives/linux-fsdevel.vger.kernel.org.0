Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A399731272C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  7 Feb 2021 20:12:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229623AbhBGTL4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 7 Feb 2021 14:11:56 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:45289 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbhBGTLx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 7 Feb 2021 14:11:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612726183; x=1644262183;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=FzS9zFUmRqicv50QPGUeADa6V5Jl4yxJkzBPfpJ4xzg=;
  b=IdwufY7kr5xKCvd0FYQNPucdbLEcRwVbMxyFkIEQxDLb5VL7cws/+izN
   91bgJqPUZGeqhEh27T8j3VXT0OphnHXYKMM9U/JQdKQCVf2/a7eOE+tc0
   oK33/9d2PmCD8DtxFT4Tg8xLJSjAzq5Bs/d1jP9YGLgk8+hqB5vSISanj
   xCferfBO7SYZxjWyJiyqdSrCWxyvWmfPY/6HlfaRCKr6sf4IeoZXwp4+B
   ZLL7lGD5py/H2BR4yDHPMXRmlu3irPieT2061TH4FUYG6fnNdIanJSlsS
   58gzmcuMKDFegxtZwb9f2kxdSIvONBRPPAOE/2NmUSULNGbU/oc5vDSU+
   g==;
IronPort-SDR: JsZFWg87zoq742Kv9BeiHOscxurNSedo1XHiFZvPrOFH8NY9QRp6RlD7n/IG3Xk1Xwft22eHQo
 Agw9kTbHrwOJQ58yAbTOEmiGxaGRHgA4J8Rkf9zmdbtOaZebqya/MUJWta0UQ0zC8TUv7g8k5E
 Sq2XoeuOtIvQmB/wVIOrh7JQF4ajbuvBba/tX3gMY5Npcahg3mIIqMXq2cTDzPdpdfe4shGFdX
 WxwCyHsj9dofRB4HmxwwudYA1sJzyj0sAFj0hSDJQ3FfPhRBgaZqT23HtbWGotBnLKqztILxBl
 1rM=
X-IronPort-AV: E=Sophos;i="5.81,160,1610380800"; 
   d="scan'208";a="263497557"
Received: from mail-dm6nam12lp2173.outbound.protection.outlook.com (HELO NAM12-DM6-obe.outbound.protection.outlook.com) ([104.47.59.173])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 03:28:00 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OJ69y0VSndSOll3ZjWX7hNioWH8qq8AJQZT23/IjgX3enZydpPcBir9L177QUUMNngtGhi40H7GPJeHoGgcjqGjkGhyrxMnKrekl+XF4Ivz+ohe5p9jl8wbqJeNVo+E5DpJVsBE1bXd5JpII1Vu6pSyvDNipwmRNu1vXa/JhT9xqS3cOP/58pZis2TdD64BEWivDyKW02KO1B6h3iDN0Chq/sfzbwbqNsBZcutqJEAeBX6k3RduG5AoP/dDefre58QhLjwJCc5G2f5AxFTxCU+Palh4fVG43OA56qKeHGdcTHU+AOExTqYIRkYcBjK0YfAy3cPWwETxcMOCnaGRjgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRJx5OElmvEhkI0XpYnPJ0OUCTbMQdWdrHsDzxQTizU=;
 b=A52w6ZiiE6GSllgA+6V2luORB7xwQ6p0VuBc287AIdnUzVxtLT/NjF0Vsjf+4pql7mSLVaAtm8iR2a+VwHpmNPze96OIMqEmiYouZSenVRYeRRwoE/Hw/PJaAkt4B2rrP4hGY4iP/NseB0pAAohDGHCygmdY2ASe1vp2PdCiUt9yZQ8V+R1zY4CKXBWGUsEeIA82ZN5B5JH/SeO6UDdFy7uc8KPoeL4MpkTxsrkqIo5BXdPiqHEsU5cGiFEna54a4izlSToLH8u5GRJ60fga/rz/W1C0ypi2E3HDeP3Sum64pu8UwENETMvoVI0r4SZ9yY1tMZ3daklDDT77QvyEPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRJx5OElmvEhkI0XpYnPJ0OUCTbMQdWdrHsDzxQTizU=;
 b=Yrm70KUHCpDQcO3TX1vL0yQpnWWEO8tLUk6HIpIk7TPXncd51Eu8iZFqXvk+3RBsv+xCBjJf5TT7V25eIPI/rP5Ud4T3cgBz7RTqHAbBmGL96hhKpy58oqTa1dzQzcduq95J4OiibdEXqvQIECt2XdivF5l4j6SGFXagRZO4rtU=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.23; Sun, 7 Feb
 2021 19:10:42 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Sun, 7 Feb 2021
 19:10:42 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "clm@fb.com" <clm@fb.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "dsterba@suse.com" <dsterba@suse.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/8] use core page calls instead of kmaps
Thread-Topic: [RFC PATCH 0/8] use core page calls instead of kmaps
Thread-Index: AQHW/YQRsjkxc1kvWUSrH/26RYB5ag==
Date:   Sun, 7 Feb 2021 19:10:41 +0000
Message-ID: <BYAPR04MB49655721C8EE8BAFF055EE2986B09@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: f93838af-af82-46ce-b5b2-08d8cb9c103c
x-ms-traffictypediagnostic: BYAPR04MB4965:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB4965082D7C82C908D953831686B09@BYAPR04MB4965.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 6hWj/jrXdnfYWUXhNExa/O0OpjrisD/J44b/bX8+1ORNxf52d6N8CSppwk6YHnTl8rcbo1s2OpmA/6qh19mDTOCfQib05CnZEGP2arjXWfihrDnCaeNaUesEiD95avtdlfhr5bnSZagM2Rd0GgpvrhiClVzn7i0mwqFY42tTvtnHpaeVR4N85Ywy+jT/38wuoaHllPJ15R08fOtktlFPwP8pdSyRR491MF/PKPv0VbOygt2UCAKXTIn58XQaD+vswoAP/RU3OTzCeRURx4vn7pZKmYp5pvPn4j3zeHbQgOtNbxq3HPQ94E9QFAgtCyjpzhgkDCCHa4qks22QfkaxuuBq2lcpZkR9UfOyLeSg96p6dRXU2KPx+VXfKdquChxdeOHlC0hOQ5oqnTnmsHzk0/TECCH7vnaivnfIqNLAR2ZAELtwSVGQfQO4W7NyH1Fii2dnpvEekbFdWgK+tE6Iy8qI6C44VqffcfVR5nKJpTRXLcXCFJMv2oLMZ0Vb6EVcoduOlUfIMNjH+Cew1DIbEg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(39860400002)(376002)(136003)(366004)(8676002)(26005)(186003)(6506007)(53546011)(33656002)(2906002)(4326008)(9686003)(5660300002)(7416002)(8936002)(55016002)(71200400001)(66556008)(7696005)(66946007)(64756008)(66446008)(66476007)(4744005)(52536014)(54906003)(110136005)(86362001)(478600001)(316002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?+DjXuXVD+ig/odKvbRNsHU9Vh8qi6bGDP7OTH3sDJtO+1I4atUN9QXJUIn/V?=
 =?us-ascii?Q?kRV3WbxyBvnRdUCuIvz8lpjCr7u6jpu0kEVvljYVNI5jzJrOdFA8p/GUQkw2?=
 =?us-ascii?Q?Lq/Tfno1k/nPAsJ3O6jO0cO3kjW59BdnPr1jbK6deg28l83JW1XIwp1tBCka?=
 =?us-ascii?Q?gfqwyVCgWL7ABYQ9vC16ctLrRnY3MK9Oeh3cP+GBbruC+QSuY7wDY+hH+FWD?=
 =?us-ascii?Q?c3lQY2p2knVBICgpZY1AekUajB88PNjFJz2JEFq+WnjfzwIJlgxKNHamrfJW?=
 =?us-ascii?Q?PcCuxUMCO9BgN6H7Zv5osHHS3ZuMuRwh4kZZdNL4qXeYLXCBlRsq9IZlp1Up?=
 =?us-ascii?Q?uPhzS+Fbdg1XyMr6ZGgvLsI/dIdcUczYcVsvrzAVcxmJ33L0fJkk3mdgP+2Q?=
 =?us-ascii?Q?GCV4y2/SqmDtlS6ds6IPPLrbwtmmBVfbV0Zlb72co3VymPZbVux3KgkuPh97?=
 =?us-ascii?Q?ydK/299xvdLfVk9xCa1jxiim8qLRpP2i3ToIH3Fd5DKmW/yIuIp8JahJFV+w?=
 =?us-ascii?Q?PFBEgnOcwNnrDU5B2ePPr5+5qan6FXps5vwMko6xD1RVfM+yFRVLEmf1WrL2?=
 =?us-ascii?Q?1V02oOLS670jYOmJLfLiKiFOcqYjoftCfl+HC6UZYygjZl6iXeppIXVPXuei?=
 =?us-ascii?Q?LxU8naFGJmijNqUi6Pj2AGregHHFHopFYkrDF+C/AwB6RfxHH+NZvKUPj3Cq?=
 =?us-ascii?Q?Vp9o31qeTOEGmhhjBshTPLygcqTyI8QlmJ2gePwMbiXaREp+JAFL4tdduDK5?=
 =?us-ascii?Q?JsNMbPRpp9POh6gGo/FzlukzWX2Q5ZTPmRQrq9KiBeiNmSk0sdLnNdTt+6pq?=
 =?us-ascii?Q?YraPVvNC+EJT3wwr/AbWdnn7MBvXIz1BF4rFXHUbfjacSspN68E+0ZCF6sLQ?=
 =?us-ascii?Q?F8lUq+906Gg6drJ4R5n1OWPC8e6KjiG8p0mMP4050Yw3MF4j9PgBCR7iV/8n?=
 =?us-ascii?Q?oQZOvApELIaYz/q8S1DGwxhNxZZZsDtzSpUmtZ8VkmZOnKZVT2A/lIVotIMo?=
 =?us-ascii?Q?ocvs0R1t5p9EVhEPQJme72w25LAYtJrT5JHhUAhD4IIAw5BUdHi/bh9SgK3s?=
 =?us-ascii?Q?frrEoyGziGkD9GGtxTiru8vwMbeX39I8mBeCKwv1uApFGUrWDJK/ZgDVKCnn?=
 =?us-ascii?Q?Qy67ANNXLpJUmr26TTvzgVll0Cj/Vcv90GC7q1EX+3TuNgTb+kZaI771K8Mo?=
 =?us-ascii?Q?SSIiAi7Xrmas5O99Iz8dnlb3S5gTxH33pdnDRLSMvjIFoP+HsfIHxCFfP/SK?=
 =?us-ascii?Q?jIIdsQTt8hXloduGqFO/QduzRjNT3QJhNExTFtNrWYsAOTfMh2674rVm2KOs?=
 =?us-ascii?Q?5Mev8NGuflbmeI/OE2dVAC0j?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f93838af-af82-46ce-b5b2-08d8cb9c103c
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2021 19:10:41.9806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/wvv+T9mIiuEfKRcklCSuPiZfhrgt77nEXhjc8PQ8WGRSJztJWmX/WyXvvmiZkwXefOUJc6XfJOhkWyzvikLSNoM6uUcjy+++G9H9DlxOc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4965
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/21 11:04, Chaitanya Kulkarni wrote:=0A=
> Chaitanya Kulkarni (8):=0A=
>   brd: use memcpy_from_page() in copy_from_brd()=0A=
>   brd: use memcpy_from_page() in copy_from_brd()=0A=
I'm aware that couple of places in brd code we can use memcpy_to_page()=0A=
and get rid the local variable, once I get some feedback I'll add those=0A=
to the V1.=0A=
