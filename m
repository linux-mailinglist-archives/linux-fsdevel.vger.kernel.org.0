Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1877B713B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Oct 2023 20:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjJCSpt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Oct 2023 14:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjJCSps (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:45:48 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFAFA7;
        Tue,  3 Oct 2023 11:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696358745; x=1727894745;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=L3HgaknsHZfCM2mp7JG9QcW3ovQUeLjNKDEPtTX3/l8=;
  b=VetvRncEyqqVeafMhVxkDfgjI+hF56LJFeiuRIVuh34ytxapU3qaqT4E
   ZpG+1+drGlN2Axyu3FFQ8q2WuQrVCN5eJZobcxdGq09dMBaCCi2OF9PAi
   7pHDYDcR3DvTacanW7aYkMxYVUtUclZHc5pXIyVOiCA7sk192uHF3huoM
   /ykyj6uMPE1S09HfGapAbSDPy8kXtiLmaXKbCz02xlS9LuH0qWgm6DUK6
   4fx4rOmyPaj7AfrYSEhfX5RtjxffFQ5lHV8yCrjnaS+XWZlC9zpPGGysq
   ork5mYVBRJgouvgsifdlyhxL30yazoNUjQ/XaANw+5dlaNM6OafygTzcV
   A==;
X-CSE-ConnectionGUID: pcaIXerQTfiQvPTDzZZQiA==
X-CSE-MsgGUID: t/cvs/GJRe+USqAEsK23Pg==
X-IronPort-AV: E=Sophos;i="6.03,198,1694707200"; 
   d="scan'208";a="357680327"
Received: from mail-sn1nam02lp2043.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.43])
  by ob1.hgst.iphmx.com with ESMTP; 04 Oct 2023 02:45:44 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FHJgcXxcuzKNfc2EOYTX1qYhBgB+HXva5olobPcFJplPxTRhv0O7IDIMRP/mVoHNjNfzaZMYBmJ6CS/H3RAht/k2S/IVUmL89HOG30NrxRcMW62O4tPboAHE7FvUF1OnyrAjjcRclAKj26PhHzdfZJ9nQrNMLTTu3N5mOt1LQX52vpX/sNh+uA23hOuI+IugNlorAbEozcmD1nZKHaVlhpMDkWpzKeMf+bqQjokCrmKHxG/dJ4NDYzAKvXLVxZrRMXqtoG2IERjJkwO9FsVcLJX+VLhHdY4WVLmSc8HJ2kH4kGWwtnG0w6UbSI1Nfk7TDt64wiE0JjDNelFRJvjkcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3HgaknsHZfCM2mp7JG9QcW3ovQUeLjNKDEPtTX3/l8=;
 b=fnitALd4teWqV3gOaWV73SZlMGOVpvvgDzb9xrJ/aCvMoxLJcSfZT4M3jdsvjqIu3p8AECXq+zWS93bqA3eWny4JlQkxj/V9Z5jCX9U8pS6Z+nG1Kg36VEnmjXBsJBGGJYSlIK87LK/Dy9tyeTd5gqROah3x8sJV+8A78vyOVYyY7FeF8ZxrsJef7BH2v9fUV8Id5dilrqBZ2Np9m6bGgSBvvFSJ3micr68sXVQ3j3lNoY4S+rr6ugEP1RwyRlLY+mGNilN6D2ZuyuZwqOG2IoIbWZZYhUt9M5P1iQvVMEy8+OpAkdvUTS59G9mP3QdTfeH4vU1Cuid161/z7ei6gQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3HgaknsHZfCM2mp7JG9QcW3ovQUeLjNKDEPtTX3/l8=;
 b=mJOcpGIi2sSmSaBOpkfMLbsh18UfVuUCJItLkl8qGr/2tuDtqvZ+7rCRMU5kLMnGnzHAVYylySV+7fTvcQVsuyWeJ+RHzOtKmrOmk8yO53q1u6s08DH22Qhafwm7Xl6GithzA7IyPoP9vfGu/G7z8CX4NMJzcAmKI++AOgT1udM=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by PH7PR04MB8756.namprd04.prod.outlook.com (2603:10b6:510:237::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 18:45:42 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Tue, 3 Oct 2023
 18:45:42 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>
CC:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Topic: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Index: AQHZ9STkFfj1sZp8ZEmkxmgvdKgC97A3Sw9egAEIIYCAABYkgA==
Date:   Tue, 3 Oct 2023 18:45:42 +0000
Message-ID: <ZRxhVcluOJErnclX@x1-carbon>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
 <yq14jj8trfu.fsf@ca-mkp.ca.oracle.com>
 <123f0c8c-46a3-4cb2-9078-ad71d6cf91ef@acm.org>
In-Reply-To: <123f0c8c-46a3-4cb2-9078-ad71d6cf91ef@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|PH7PR04MB8756:EE_
x-ms-office365-filtering-correlation-id: e2f8ff85-d29e-47f9-e5b0-08dbc440f26e
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B3uXDfIbf0xEDfBOCl111LP1IIm3rRTBjTDHeZoL7+mY6t4DmptECKu3n2BjCqnP2trqqh75+CCLA8q7lP4MKp7YtderaGNzoXfpc56JsMIRVu0Dke74ATvMNpB5XL6fNS1XZH0MgcEknoZJt1SP4d4QahsOOCWDkE0Kqm/O2dWyEhCJoX+F0oZRxdsWZw9Uf3FlMBsYAA2n5IOrQzq7li+l12f0D5FGPsk5nZx/0gcTtihr9yvZE58MVADwneEIKJVF+/ZX+b4yO+x1QdrzYeXuLZ/sk8wEBSZgB51ImL++UulUiY1TOLn/korv/PF77uyeqX6l3dOPJRIeaHQ3xchMGZjJSxC9x3nwiCmDrV99Q0WBIroloixmxjTR3yXu4Nix4u7jR/JEixLi0p9u2IVMJiUFi8jFD4Dd6F8pCTjPYE1xelK007dDT9FR6GHQE9PnmTSLjdxbX4i//fYylSoHkazCx/TMwZQhtCtsaE5Ed+GuAAX2MSA3gZ5DFM6D+dr5xC+zl15f0I4oQ4j+kJfegzS1hpjhx9extVjPBOdQJPzuCy6WnGuITOKSUk0qmhGQRCzSN3z8AZO9SG3lKoDsYEwf7i53yzVtkmHB2gqkxJ2ll1pitnAucKPxFAIR
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(376002)(396003)(346002)(39860400002)(136003)(366004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(64756008)(33716001)(66446008)(66556008)(76116006)(6506007)(26005)(6916009)(91956017)(66946007)(66476007)(38100700002)(38070700005)(82960400001)(122000001)(53546011)(86362001)(71200400001)(9686003)(6486002)(478600001)(6512007)(54906003)(2906002)(4744005)(4326008)(8676002)(316002)(8936002)(41300700001)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?qooCMdBP63/oDA1hN401tgLIp95zQs8zNvB0V/RxJgGJNz3jeBh2Cp98GUwR?=
 =?us-ascii?Q?wVJdTyjxjCtHFTY3PvekehDkfU3zUvhv9F3Dj5JdKvJ/pplYZOp808VemFkt?=
 =?us-ascii?Q?Nwu3Kdo58+wQX5RNgJHKdM7iqjGTZX6+ovyCUAU1ge3ux/BvG7ArCUGU7YwJ?=
 =?us-ascii?Q?2pXR7bE/q3MyMubd1Vn9OZgTElpYvuZO/nu0NsgydgUa5Lw2W/X+6aaRfln9?=
 =?us-ascii?Q?IrqphQkHt6f1K0DXNM2vL/jnIhD4d1slu3luqiC7sM0tbEvQb6vqqh+RtDEO?=
 =?us-ascii?Q?aq8dsdeNthZgGHgGVF3bwtuLh6kpaKOO9P4NpJkxQN2akYb1bem5fy5UjWRQ?=
 =?us-ascii?Q?yQCdruW87KeNvTCwJ+VQzXNWgdSSxsIVCciK2QGJtNc7amKNVJic0FZM4I5O?=
 =?us-ascii?Q?FiZtIwZAzSR5myaaJyAeHqGyWsfGl2d6Y16/7Ve+LRFLoJM20r8X1+y/EfgJ?=
 =?us-ascii?Q?9Yn9Ji0TuHQTUh+8vH14PsGhpF7TgwfyonKiZKj/0WY5hnytCwnsNaoTwqum?=
 =?us-ascii?Q?cYJq1ze9Ch56UHo2GWRNdVJVoz2uHB/IMfcnw6YcGKLdhsRUoDBjcMAcPmaP?=
 =?us-ascii?Q?kO+ukSL8h4MoXaT/Xq7gXFNxIW2YZ0pnFRttRbWtTwzOBe7X0fnh1YkWA+DN?=
 =?us-ascii?Q?WLmS7tESrgXQ3uGAYimDy/kLA0EZYe7YOrZHUUtRDLbjJ7T+W/qJ0gbna3UZ?=
 =?us-ascii?Q?kQSUYaiEFZ+tbUwQurJdCrTKFWedZmWpGbnVmw+7e5EIJU2GdNL1mJ/Tqc0b?=
 =?us-ascii?Q?bLe5nqzN0qIsR/U1dTLSGg/gxKIk+wNYGOXBBS+RC9vcXU35jGZ08JV0lsnU?=
 =?us-ascii?Q?ymwohJElbz+Q0MmQ8LjW/f/e4bRHdAhoCtZXCo4J+8jwvapXhLv5vw3S19iA?=
 =?us-ascii?Q?mR/it1mbNjLmgNV/XVIE1uPs/+6QGfN1VxkfvHYUyvoUIGATlxgRQx5EJPwg?=
 =?us-ascii?Q?wrutHi+NrDkc/1PTg1v5XsQuc88fqMxiS9SY7Za4sVRSrUA2jIxxtMqMHUTw?=
 =?us-ascii?Q?VJYNP9hEd7GHk1PSL5v9O4/FTlzMglQyYqzORVxPyMtQC/ubgJT5lyVFMSia?=
 =?us-ascii?Q?bM93Vt7chZ2UM2REy6xIzfPbBLAAPEQeVNqYeeaSJ61Hbo+MaNiUAPZa1Di2?=
 =?us-ascii?Q?gBtPVT3TbRCsCudGiI7FC//5FqZqsCXasr5MSMsmu1o6sPgnsfa2qvK1QkLC?=
 =?us-ascii?Q?qD2XKssuu0HciJRf0eyOo8XJp5lF9EnPKL4srSl4eAGFcL0H2u7ci0ivquXk?=
 =?us-ascii?Q?8BjXsvdXCYCKa54PqRNreNBI0TmbKJ0MxpZdCdZ6q3y7ufQGUdaE8OkQSYOy?=
 =?us-ascii?Q?8PXoIMMN36tIccv/UE9Jz1dMafXonfGa3QdVOmQbxH9zlP4Yjpv6YD+NxdaV?=
 =?us-ascii?Q?oNpRHgOimcmQ38HpHBsemJNHlL1kZ+FExtfHf8j4jHTOI3BWoHnW4cGWy9UM?=
 =?us-ascii?Q?32OgRJCekS68ZISn4qxZVeb6LXXJ5/gksgZL9TQyKoBgXjjH+VGDN8FFUErF?=
 =?us-ascii?Q?hSAt9y9GlcpWU6/LCnnTr2iJtfJdTzeidXJlWiXxkuAP+6suQSHcF80JK4fy?=
 =?us-ascii?Q?/Ph7HaYR0jnj8/9AcrofMHn1CwU6g50iEMtzka1QLfvbZy3WNSBklkj+Tsc7?=
 =?us-ascii?Q?tg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <144AFA51BFDB2346B318AEF278A94302@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mF1fFLvjrTMEiVqNYMOFred2aGFHe5DIXLIKUTsyYPotX8G/0GcTJd47uGTSIZGrcoPDAUC3uWVom39MXUq2Iy+pnAzRSRDEtNv7Xwk6+CdPcVj7G784IA6ZinusXbsxJcZ8Ss2+M2Hio05OS7680z0STJ4grtKPWrADPstEI4zy/9Bqjx5UkOmvwMc/XEpVg+N5BrjGdUxRHnoblU4XDLLR2yqMY3G1Pq8xhKHUyJt5XccXMmIpZ1DkiC5NxCUpcz1mHj8eygd5dP2RNvOPSYNEtJ9SIG0uLv+kIUh356RKtMF4RZXBUO7S4rC2k6Hi3Q7kxXHTjRE2/X05/kZ2Cui7js7+S6Z/2fO6UEI8CZfRodjgDYfkLDwf/EzTCxP2v32yr0BqYmPwFyyYfnrCApraHuSXqyMaZsiFsDhTqIBiGxiafsSDoLNZGEzZ9CpPOEw0Gys/qzU4rz1gvCG0bBmmQBCYWk+1/IrAhfyiRvTjLUbv1aquRzRIei9yhG8CeHwsYFkSLFZg9F/HUvB86Rhy7y9icSVYo2B2yWAoT3X4hQNLS2bhToLMrrmuqDNKQxDAuM39QrJCzKAmpfid0YFmkD2COVRTkDICHwhf20BW3jxXIQRMCcDy6a3yCUtwLKc78su1Mop+7k1DNrY2BgQGv6lV+trkmL7Ih4/CDKvDdi+I1ZusyeKhYI8b8wifosuCPJkCM2hC6hJkWEzaKdygELeLIA3y2WrcLr5qCWxRfrQVUZUN+4VK5LElLcVePDWqZl6RJ4t2dT12bOymQQt3OD8/AtXaPp6Wdqq2FxwmtEaWUspSPyXpKs87q4db4ZRrEF+tV7xJXwpGDvg1qky18yTCeX86iUEihCWJ6lF2shnUrMUD5j/uaK2gekfoBwdACby4ns8H2c/DY4BVUQ==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2f8ff85-d29e-47f9-e5b0-08dbc440f26e
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Oct 2023 18:45:42.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wpg6YPWjmBMdfkkA2WMdqeTaKDwRIzjwIKLPx2QWBlKL2K2pVW5/M27LikgHF7HdyClT/ruUedXK5zNBAg6Dow==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR04MB8756
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Oct 03, 2023 at 10:26:27AM -0700, Bart Van Assche wrote:
> On 10/2/23 18:40, Martin K. Petersen wrote:
> >=20
> > Niklas,
> >=20
> > > I don't know which user facing API Martin's I/O hinting series is
> > > intending to use.
> >=20
> > I'm just using ioprio.
>=20
> Hi Martin,
>=20
> Do you plan to use existing bits from the ioprio bitmask or new bits? Bit=
s
> 0-2 are used for the priority level. Bits 3-5 are used for CDL. Bits 13-1=
5
> are used for the I/O priority. The SCSI and NVMe standard define 64
> different data lifetimes (six bits). So there are 16 - 3 - 3 - 6 =3D 4
> remaining bits.

Hello Bart,

I think the math is:

16 - 3 (prio level) - 3 (CDL) - 3 (prio class) =3D 7

so if we want 64 different values for data lifetimes
(we previously only had 4 different values), that is 6 bits:

16 - 3 (prio level) - 3 (CDL) - 3 (prio class) - 6 (lifetime) =3D 1

so only one bit left for Martin :)

Not very much room to play with...


Kind regards,
Niklas
