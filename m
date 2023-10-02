Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A41847B51C0
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 13:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236795AbjJBLxW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 07:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231338AbjJBLxV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:53:21 -0400
Received: from esa5.hgst.iphmx.com (esa5.hgst.iphmx.com [216.71.153.144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA1293;
        Mon,  2 Oct 2023 04:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696247599; x=1727783599;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=eTihvWeE17oA67Fe6cRz3dnHyjI01ZunaNHAUD4WEko=;
  b=Rc1lhaW38FLEhu7mZfvl4zX2b0X40J8hapeiVejd3luCiO1Vr5I0aV4m
   7VUGN/LrNJv2oB3Kl5/OPTxTsUiDnL8Wey1zcqo2ZnlA7CmLgLj4SQE3e
   iA5cqwThn1iDHiqRxAKz4ZlQjN/ln/StR3aHBjiI6lzOufMpPi76tcidT
   xaZ63Nq1atMnkQGfH+iD7k/jPghYayM8TC3jQYGQJT/6e+CztEjoEiIDq
   k+k/TaNJL2EFAJ2WOVNQQpYuSiZLmt4WXiHHrq3+4U7Kc1BOPhx+Cf/Cc
   EltsuKYh+w+WspqHZkI5lLaIsRUr2tr83PiVv7YFEUXGjNBshHB018xMI
   Q==;
X-CSE-ConnectionGUID: spQitle+R12Ztsbf0CXujA==
X-CSE-MsgGUID: ybGbhLiPT3uijNvyN4flQg==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="245444586"
Received: from mail-dm6nam11lp2176.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.176])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 19:53:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OQP/FbG4U2UQyfyotAygjOGr75mZFeCT7P+cHTUgHxYddsMY8gRJcBbgBOk/cVOQX9b0JofEUFzzoPS6UHY0P9VFfWhr3eRZX1vl9Jqmp0J8Nn7ePEbVebUNMFGf2yBz/HyTYqQHa4DCu93Ft3wmKQiUll3ol18WEen3MkFAOeGtGn1PA7xS1a03pGXLe36C8tgY3fQE/+Sp9H+Ks/GGvil7OAuCziiNM9GEpQUduhVGR8DAbyR5vctRPdI7JQsKriDyEb8Rg6ABIJg4zKdThE9eG6EA8gtIE0ey5L+pIcdlIJQr2i990kI5g7n/W1MbFyYt7YzyG2EHZ66jYZ4TNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eTihvWeE17oA67Fe6cRz3dnHyjI01ZunaNHAUD4WEko=;
 b=lLQxZk4ypB4qNQL9YlRlL/5LJhlppJJ5NjzOSLvrwwO2sEKNdW0YUwTdSzQDSGqPHc4PdG3VsWELZbRuSrqVzI3G2aBq4WEC4n7oLIcXS8od+Z6e3jX4BzyEQ8gVdv57z3yothzE02C16k3xwuD5hDpL0yCxz1X+x74S0tDImEbqtz5i4ioIjRzTmzkiMD51xxUoHjLIFY+NZXCTfuRSO3qs3WduRO0Rz9XtOV99hT1ijHWT5wSRin8j0isMwErKNT7RiIF9p+HnWZ/Zn/LbneHRLpfCXvg5aG7sKJeK2sCWtk1IeFqP7mtFiw+/9pMVQE3e7qJTHhFUv+zxU8Tl6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eTihvWeE17oA67Fe6cRz3dnHyjI01ZunaNHAUD4WEko=;
 b=PyTofbVgM7dPYnOG/fLxbZ54FzUITT4Y/mAIYjeyWQxOSLODma4WkQ2CkLWjg9FWkbXgZ3DyerpCTSDYkcYMP/uBfUDTm357jEhGvsDU9z12WTfk68XdxzQ/1SpCOMhUrnB51S/InDgW9QNXcc+7zAobcrh1Mt/I3+xmqM++d/c=
Received: from MN2PR04MB6272.namprd04.prod.outlook.com (2603:10b6:208:e0::27)
 by DS0PR04MB8598.namprd04.prod.outlook.com (2603:10b6:8:126::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.12; Mon, 2 Oct
 2023 11:53:16 +0000
Received: from MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d]) by MN2PR04MB6272.namprd04.prod.outlook.com
 ([fe80::6fb5:ecb:1ea0:3b1d%6]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 11:53:15 +0000
From:   Niklas Cassel <Niklas.Cassel@wdc.com>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
CC:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Topic: [PATCH 00/13] Pass data temperature information to zoned UFS
 devices
Thread-Index: AQHZ9STkFfj1sZp8ZEmkxmgvdKgC97A2Y70A
Date:   Mon, 2 Oct 2023 11:53:15 +0000
Message-ID: <ZRqvJsF6s5OrFlC4@x1-carbon>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <yq1o7hnzbsy.fsf@ca-mkp.ca.oracle.com> <ZRqrl7+oopXnn8r5@x1-carbon>
In-Reply-To: <ZRqrl7+oopXnn8r5@x1-carbon>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN2PR04MB6272:EE_|DS0PR04MB8598:EE_
x-ms-office365-filtering-correlation-id: 76bd2b75-8590-4a03-78dc-08dbc33e2968
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lmeALMQCJnKVZsYKHI28+EI//bo/q7gOgWQOgTIXCwcotFM1esjkvlXmFCYLA6kCNHrkMSn1qwrrwZkvoX4Wj5FQz6qb4KtjyhfSfp+poDSPUfj5Q8/WNb3uGqETj64w0jb6xyjGkGw2FMAu/TrpR4uo2S+CgD32DG6TsZVgj+gOWpl0lfF6rS0FKQHiu2KURN2Id6bstBiBJB0U0DikbJD2yrPMCmb4fV3A6XIdZtUkMXcIwPvq0a5N5eqlwu4hg5Tum4bOWUc7J7dslcwomojpjXaC0Y++4Jw+sF7pLLaWyiW3vb043cMAs6FVMo5LEe/m3+CukMZx5oUonnnMHusq0LpfrNICSO+l+ChjNpBRmFtZmD3AQZFe8xKLN9GgMeRp/XyZnMK53RTf+kaeNZ9pfiHISNqEC3wMMAi8btaZjwuv5pAwQg4QFA1G+N/5KIUF5EBevFXGFldHPEGlc8SrG4066WVc+UrQ6d2fyKY1p/jcdspXi/frabMyTZi8qT+fTvM9Fv2qDtRqBoLpuaVY1t5+yC1EYFRRMKXUHLCXkIc1YE0Pav6IkQErpWmjVNmx7WVD3O/BaeLO7cV9tlx86+qY3efByVxqR0LE9RMpWfRLosp9VdIceiphDqYBXnkZEYUBjQIvDV7cizYYdg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR04MB6272.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(7916004)(366004)(376002)(396003)(346002)(136003)(39860400002)(230922051799003)(1800799009)(64100799003)(186009)(451199024)(8936002)(82960400001)(122000001)(26005)(71200400001)(6506007)(478600001)(966005)(38070700005)(6486002)(38100700002)(9686003)(83380400001)(6512007)(64756008)(66946007)(66446008)(66556008)(66476007)(316002)(6916009)(54906003)(5660300002)(2906002)(86362001)(76116006)(91956017)(4326008)(8676002)(33716001)(41300700001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?y4Ww4aeN/5WdQnIJa92gmZFJincKI3rzJ94/7mx2iQtrzKh7hlK2YaX/5g8o?=
 =?us-ascii?Q?PJibDlyl/A2EiUqHDI41KooOXROE3NGxIuTWBkVfQd1JC2c4KeYvy0IwmhrX?=
 =?us-ascii?Q?ICDsQjOfcbqXcZVAU+2zCwWsk9/fdwO01G0exclpWD2h+GiezcecC3/Dd799?=
 =?us-ascii?Q?To7seee/mA0uCv7kjB7Yfi78ZM/svUuqcWutFLwymRDf2g5y3ccyRh0VvBQW?=
 =?us-ascii?Q?agsAchZVJhJPKKpVPLG7TeDHc/kfyOjnAkDP8mFKKO5HCADHZ2guvw2WrSMy?=
 =?us-ascii?Q?bM6ou4nGcedllsbI+RqX6qh6+wd8qPSzcBe76uJ3DpHZeRVWagxzV1aAmjTg?=
 =?us-ascii?Q?SLYNZ8H0OjygTyZu8g2KHG9vg9vrRwD21qWbkG0HKFhJATmMm1i7lqvNxKNz?=
 =?us-ascii?Q?vTRjSwksyWJicJ7OaP7e6W8juVxXPfDcyHfJcyxCkKoIP514JLmhh7FjvMax?=
 =?us-ascii?Q?RxQKjLhPJCHDdwJQxV75mauQzAtWOcg1BoCSGsrVlDqtyW7l5F1bRCqaLOmJ?=
 =?us-ascii?Q?wR8dzxu5pqKwWuatoO4BSy9jAWEXvTvG14JSiNxzZtJR3JE5QJEKGPhMpzDI?=
 =?us-ascii?Q?EQ9vEN5fzvusbpm/MTjJrMvnJjlHw6zgFGHRP/tGZA4n7DjK31AzfUTNdH7r?=
 =?us-ascii?Q?Knw22I1n8pYnz1wVRcjKr27mShdGHj/O5B8g/fxf78lwvzH/WD3CkMx7eGqO?=
 =?us-ascii?Q?OF3tpG1lFDLWc2tgHM336tteJrJVBzUw03m3jGj8mmxpkrFaNYeHjeQE/tfN?=
 =?us-ascii?Q?MWBAmFKnL5ERn4rV40kQzuT9CDxrR/O/GYWpywRUsdir0n8LDVejt1ZtPDdA?=
 =?us-ascii?Q?Ou49dR50TwXJYj7bqaJPON2YX5IwC+TpZVgD+IVLPYighJ7SN+7wUw96ZOOV?=
 =?us-ascii?Q?VtqrS55J9tPoerQZ8kwcNHP2QMeK6gbm1P14wUy4JOzV9fGcBUDNYxcfdBxZ?=
 =?us-ascii?Q?CwtP4EWhaB8y+lL3BFy4HlnC2MEMo9H5BYPJZsK9y7E8d/gRVsXxWPgVrNYO?=
 =?us-ascii?Q?z2bIf4eiVgwXvn67HOXrZmYzvzW1b29HxwX9elerZmPmj9ux6yH+7+08uvN2?=
 =?us-ascii?Q?LB+JLvgjkANdiT6YBrAhuIJgoVDYsMQxN7zKM/1I/LYpxcDTdPaaUVb4QLHn?=
 =?us-ascii?Q?6B2W82zWD47oLFnmSDdBlGM1ACW52gKSE0HV3VuqbqwQhUA0WUT0k55BxBzx?=
 =?us-ascii?Q?ZeoVRWM3HfFBpw10TnQcQHiMowoCJ9mVm9IGzKEI2LnNFSYv4vUWPgni0WPj?=
 =?us-ascii?Q?RPRts7jon3i04iXD1krRuHDdUVuCfd+Jy+0ufojdhjjq7/6cHvHA5jluowDR?=
 =?us-ascii?Q?yFoGNkg/B62ek44X0hsJ4BE9+H7pcHEbYZZxXpV4M284UK3eH3BuxX2NBgzo?=
 =?us-ascii?Q?NslxgIsDVBSO5nXA0Dhz+p1ojMNTIRZM5ilHdS1iyvs4UhTkK4Ek67MyQYZx?=
 =?us-ascii?Q?ZBiV5kLTZzhV3hnP6Fi9QGJlShhsiM0TEwFucWG3s5ZFF8RNpovJkrdOTHVI?=
 =?us-ascii?Q?rrRaar/Vok7+NCQXoCURqR1B09NNDSzqZE9PES6RkKfbEma8sRRNMAVYbcIC?=
 =?us-ascii?Q?8U6pjzej1JcMk6mlQgrGj9yPkfoRnHX9/KpPXUbjq41blhM10tHNdRBqcHex?=
 =?us-ascii?Q?pg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <4F17EE82E3654C48A3C99BF17466E836@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1PC+BcK6F73zKuovMHSD9EwHplb+4IgMRw4EN8OwpYMtqkb1Ku3KBWBl3rVHsDPeaeBe2xJxoItW7L+zn45SjDjZtDbKT6T1S2jD27kw0QpHpO5oCFJSWc8EOPwScdlVGjMSKY90aWMbjSZ4qIDVSlTSXR6dfBHOgUmgrF5beWJ8WuVgmcPT4JWTlMoCyrl7PaG6oAza6LmW31gf5bCL4wXbHcjfErt8fy2EOXG458JW1U57QSSmj6zWuXr32oNTeZOmR6h5N8HPg2N3VvDFh0ahBFkxCJhcDI8IjK7PiZWkV3APBK1VbYDVB2r6ia0053lMrYEtCBhwgYAwaVT4jj0Ix+cTHiXGt+FmCgoMUplqyI2SMuwMvEwclF4BbsFMpMDVDTuKkh+okvypnnKx9whit41u9JGBd36t2ATxWVT9DcbM97vlfFTcm4ud1Bopg8/pNjFM2IxI9czRIp0CpsqKlplqLmpLo0imymyVAfrgCdViwtumQk2p1z2z8AJEaUBrnW9S+dLI5q2y3TORlYQuVoQvHmEFDf5hmvbB+PPPAfrQnY/xtEsezpoTv3TNRY8aSDq5N1LQLKq+au8u4ch/AeyE41CRYbKqkHsJbxm/ZGtyOiijwn+0ga1HWDtc/61SZVqalZan30sBbUo51olE4xY8rgr9nsVgL2IWXOUL0/gtPaH0wRMoN7p+bMAR4cQ0qH5uODgBn18MRbhIEVSwIZzAoGwQSNEbFE+QAXyve96p4Yr9i24apZqBGZaCkx9foX9IHksLwsXtKjKZ+a+WFAXOAn+gyh047XWIJ6/deJBbA7HjQbUZZ/RZVza+hgg1VqkiRdR7Bk78k/7dJE/xLOibpjv53JJGsyamY3G3t7PUwzM6bOCVqjg+Iitq0Dth5hFSa666e7HFGu9QKA==
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN2PR04MB6272.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 76bd2b75-8590-4a03-78dc-08dbc33e2968
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 11:53:15.3037
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mmQLzzD21bAB2LtN/a+2F5gLYLIIMNLCUUtCmRRIlBKdxbKPpo3y+XfmbYyCXiWIRmVVB7W2mtGLwVGl0Sf+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR04MB8598
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Oct 02, 2023 at 01:37:59PM +0200, Niklas Cassel wrote:
> On Wed, Sep 27, 2023 at 03:14:10PM -0400, Martin K. Petersen wrote:
> >=20
> > Hi Bart!
> >=20
> > > Zoned UFS vendors need the data temperature information. Hence this
> > > patch series that restores write hint information in F2FS and in the
> > > block layer. The SCSI disk (sd) driver is modified such that it passe=
s
> > > write hint information to SCSI devices via the GROUP NUMBER field.
> >=20
> > I don't have any particular problems with your implementation, although
> > I'm still trying to wrap my head around how to make this coexist with m=
y
> > I/O hinting series. But I guess there's probably not going to be a big
> > overlap between devices that support both features.
>=20
> Hello Bart, Martin,
>=20
> I don't know which user facing API Martin's I/O hinting series is intendi=
ng
> to use.
>=20
> However, while discussing this series at ALPSS, we did ask ourselves why =
this
> series is not reusing the already existing block layer API for providing =
I/O
> hints:
> https://github.com/torvalds/linux/blob/v6.6-rc4/include/uapi/linux/ioprio=
.h#L83-L103
>=20
> We can have 1023 possible I/O hints, and so far we are only using 7, whic=
h
> means that there are 1016 possible hints left.
> This also enables you to define more than the 4 previous temperature hint=
s
> (extreme, long, medium, short), if so desired.
>=20
> There is also support in fio for these I/O hints:
> https://github.com/axboe/fio/blob/master/HOWTO.rst?plain=3D1#L2294-L2302
>=20
> When this new I/O hint API has added, there was no other I/O hint API
> in the kernel (since the old fcntl() F_GET_FILE_RW_HINT / F_SET_FILE_RW_H=
INT
> API had already been removed when this new API was added).
>=20
> So there should probably be a good argument why we would want to introduc=
e
> yet another API for providing I/O hints, instead of extending the I/O hin=
t
> API that we already have in the kernel right now.
> (Especially since it seems fairly easy to modify your patches to reuse th=
e
> existing API.)

One argument might be that the current I/O hints API does not allow hints t=
o
be stacked. So one would not e.g. be able to combine a command duration lim=
it
with a temperature hint...


Kind regards,
Niklas=
