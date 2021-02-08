Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 49878312A34
	for <lists+linux-fsdevel@lfdr.de>; Mon,  8 Feb 2021 06:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhBHFsd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 8 Feb 2021 00:48:33 -0500
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:6917 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbhBHFsa (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 8 Feb 2021 00:48:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1612764421; x=1644300421;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=xOIpV73Uctd4JsVjWASjMdyETaYHVKtNPK1BtubjJv4=;
  b=AsvkEprTOHr8yh3HNeUpqzn7qig3jfcpaJ4P2r/QXmMDnbnRmiU5qm1H
   mmafi+oF6k+Pyin4h2Oy626GM4XlewnT5QE7FdP+SiCQmxEKv/EMgQzrm
   KSJdPPrxXiq100z4RrG2jNpxyPEefhcwIAff2LDJxRqQZBLArkhpm00Fp
   JaOzFh0aRWnQzapdE60FL+RntZf9bKQyXENMxosjWp7m+itmffiu2oRUZ
   Irx8e3eTtJutPwv6HbUXvqfVlsiCNysWkZ8nUH18+bwyNjZdBcwGgFUFL
   q6Vi2bpAJWKA6wVrHQLRG5j1AQb7Zg5/fSsAiOJcoWU7CY6z/RUuFJpBP
   Q==;
IronPort-SDR: WAMmKfRw7YQw+pPXTDQXDFGcZH7HpGaREWozmv0D7Ajxl01lyMs18AwalYCSo5Dkq1QpyKQJiR
 u2RsCCV6e5+Wa/4x2AFbWfCazBFog29qHUv4KLBahrcUr/mIkGU9ElFZ6P9m52795xLWEgnRFP
 3TxPdZF5KBu6J91JnQTrqnbxfQQD46YibGw4i/jq/e1zZ6fGEVdLNcYdkTbwCmfjh2gyD0FW7X
 iZYckCNsx1IX7DuFEB1xjc/gVSVmWN35rbIxAPDKoLel/D+TJAE/QejFNji18G9RuSvCVD5dBZ
 RoQ=
X-IronPort-AV: E=Sophos;i="5.81,161,1610380800"; 
   d="scan'208";a="263524678"
Received: from mail-bn7nam10lp2109.outbound.protection.outlook.com (HELO NAM10-BN7-obe.outbound.protection.outlook.com) ([104.47.70.109])
  by ob1.hgst.iphmx.com with ESMTP; 08 Feb 2021 14:05:18 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ls4Lmm6e4pAvJj8pfWrKSwg4FKK4XqP5RBcQgbkhikLNPvUePFv0pJH1RRoB6oIs3+84pj+Poh8+bew73h37PMQdPfqa2qyujxncYU876leYt+NZSgIYfi3NlzsGkqRCXo6HAM3dEQsN1DJ9+aLiirFObxfVGrqrFxmbWnyQ2v04VxgzDCNVpSrgnqhk8MG+SgZd3G4VRFm9+Bjw/yWfDMfbNg+hEE+JQeztH+ieoMTqtAxaDDR+Efh78jn4pxOkUpv03AgLkua703M5u0GJQAELDfdTO2rmxK8RdAsc81A6vFPeuCr9wY0KMsdrtYiEP2eb60wBKtNv8FSUgGRi2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/8+WMLFRis7Q34VxN3+AUSWmjbvnzGwUUZYdzRWjU8=;
 b=EbEyjD2Lg3DA7G0UoMn2dQAOxRiPQ6HThhdfwMzRCCEgBq4tqeJhzrCfNibh+alcBV7W57S/Cir3O4PEnqXNIDArAdkBd7PMZ1poJa/K5eiMSf0CMUYJuYA01FRrk9R4h7zjUDl+PlSdkRrLgHMcwQo6cfFimbQjAh5RJTexQy/PpQA2xclMtFtm2Fz9OyC/wLxYYw0yJKvRh4P1y+m7t3Ip35whyImMu1lzSVTEA7tPeAdVEiaJbAG3H87sdoJPSx8QuS0us3z4nrBYNA7UiaJgqQbCyaBtCEADQvKmNJMZ2DPHovyPCkuybeSyE5T2jm+jODIFRqHVq0xc0Kb65A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/8+WMLFRis7Q34VxN3+AUSWmjbvnzGwUUZYdzRWjU8=;
 b=SEfeM4E7MrpHxCrj2lT930Kcwn1ytZO9YiT6IiE5eGMcn8fSFYspMgQivGsN/E9fYcKWX95rZSHY+7BxVPdc/YIhJU3jzcq+ItdHPbFb6momWgvD7ByEjAoqkfrhRHsaOHRhDhQpHOLCIiaOPAbQCJ6FkiSqWw0EZy8UqyO/9pM=
Received: from BYAPR04MB4965.namprd04.prod.outlook.com (2603:10b6:a03:4d::25)
 by BYAPR04MB4037.namprd04.prod.outlook.com (2603:10b6:a02:aa::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.30; Mon, 8 Feb
 2021 05:47:20 +0000
Received: from BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c]) by BYAPR04MB4965.namprd04.prod.outlook.com
 ([fe80::1d83:38d9:143:4c9c%5]) with mapi id 15.20.3825.027; Mon, 8 Feb 2021
 05:47:20 +0000
From:   Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
To:     Ira Weiny <ira.weiny@intel.com>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>,
        "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "tytso@mit.edu" <tytso@mit.edu>,
        "adilger.kernel@dilger.ca" <adilger.kernel@dilger.ca>,
        "jaegeuk@kernel.org" <jaegeuk@kernel.org>,
        "chao@kernel.org" <chao@kernel.org>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "dongli.zhang@oracle.com" <dongli.zhang@oracle.com>,
        "clm@fb.com" <clm@fb.com>, "dsterba@suse.com" <dsterba@suse.com>,
        "ebiggers@kernel.org" <ebiggers@kernel.org>,
        "hch@infradead.org" <hch@infradead.org>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>
Subject: Re: [RFC PATCH 0/8] use core page calls instead of kmaps
Thread-Topic: [RFC PATCH 0/8] use core page calls instead of kmaps
Thread-Index: AQHW/YQRsjkxc1kvWUSrH/26RYB5ag==
Date:   Mon, 8 Feb 2021 05:47:20 +0000
Message-ID: <BYAPR04MB4965F228A130556639B17B85868F9@BYAPR04MB4965.namprd04.prod.outlook.com>
References: <20210207190425.38107-1-chaitanya.kulkarni@wdc.com>
 <BYAPR04MB49655721C8EE8BAFF055EE2986B09@BYAPR04MB4965.namprd04.prod.outlook.com>
 <20210208044205.GG5033@iweiny-DESK2.sc.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: intel.com; dkim=none (message not signed)
 header.d=none;intel.com; dmarc=none action=none header.from=wdc.com;
x-originating-ip: [199.255.45.62]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 853d474d-e12a-43cd-d41c-08d8cbf5002d
x-ms-traffictypediagnostic: BYAPR04MB4037:
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR04MB403702FC46BDB11D96E67CB0868F9@BYAPR04MB4037.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ymv6VN0ujlArcbm18MgFHa4EFJgGlgLgOzQaeT3a8wW0w9OSUZA2Epd4NHSgurrDxdFrypxYK49N4wa4MPotr0NwAp7hDVw3cwsyAd5q1jlCOOa/PYFGv7HkWG5CGoPnYNw2WVz/xJwTmi/Gd3HYiEh8/CXRfiyGIBq5elk29HNg0SO+wZiGiClwRw0zjg1o92drjUKquYfDltStKhMYTNDEQIL4+5o13fCg6AxRsP/4OY2UJ4cvMsAkQLKa9MnSAEqgedggU/6XZcDndVWxTBJ0HoV2bCmAG7sqGYxQcYXii5OsmleNmvA/rNnhU9uImegxzoLCFYymJ15SGre56p9rJQnLLzjG6DYoFwxYoGP66MrKW3q5OabOQfFdbFig3XR1GXGpvgAdTXbD6OHEXjzDcoLK/xBb3KGLyWgsEnYxC6kKSpqCGUGDF662PL6XlYleLiNMwuMVSTAb66InGtClO2kYl1oeFeO4WvW0njYJHQSaNG+N+AJ6+sncbzMmau+qZT0ik1GxkldQ7DT/NA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR04MB4965.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(346002)(396003)(366004)(39860400002)(376002)(136003)(4744005)(26005)(7696005)(316002)(2906002)(54906003)(52536014)(186003)(5660300002)(478600001)(8936002)(9686003)(4326008)(53546011)(6506007)(55016002)(71200400001)(33656002)(76116006)(66946007)(7416002)(86362001)(8676002)(6916009)(66476007)(66446008)(64756008)(66556008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?zQU0jENzSUgLXXaySdNV/f1Ed2SZ9yYFTMZTVOnasG6wfxKXikhEtWwq7vwU?=
 =?us-ascii?Q?aCEd8blce2qeL1+JFTdUoPS92z3FK6YAvtwFxX/KCWbd/6gEuBWUFnvkVxPr?=
 =?us-ascii?Q?Ex+2rwuo6boW/RpvFi9PZEz2jThd9e/UT50yMcGqKHAB84sxzrwBSSErlzVt?=
 =?us-ascii?Q?DVNfShVJ2DeNnoCbcZMnPBEfj0rTs12lr/c55q3A/CsnYjEgOGaf2MONXNw9?=
 =?us-ascii?Q?QaQ+/xruEp/6yGbD2QOy0jMD58r9MRn7RdkmDX5ls0s9IP0w5kUxC4vmROHf?=
 =?us-ascii?Q?naQXQeXK9hQ9nr8OBpG39B+hH/gSfaaR8Ymqv6xL7mjizS/1TVeFKerjcViX?=
 =?us-ascii?Q?HRNxmvD6FOd73yR5qJFoVFgf20uB2mDHgPFKCgpaGLqxOJV45oT5jWEtR2CT?=
 =?us-ascii?Q?JOohg9orI5gepv2JRbKlnAaxkjVApgek3O73/UiZoi+PdGsVqJGC/7TVv6Sw?=
 =?us-ascii?Q?XiFmUvzcaBwdwDWsRBVxBYMVESHSarM1xg0jA/m0uobVLM35xPNdiPz0PoED?=
 =?us-ascii?Q?tsX8v03CWE+bfjmQlLcQ6MNJXKslU6wv2qsBmeq2nKL4ibYOBudbFgs6Hx3t?=
 =?us-ascii?Q?9uObYhoZOwFXTMdiRRyAbpBkzEHMiirsCqXaFWiS28wCsq2Fh7s7j+6wJF5N?=
 =?us-ascii?Q?H71WYx9dGI8sFdJoIsNpLFsUehtPFXgAHOguk9Zd4bhB1ctRr5jUJ+GakUNx?=
 =?us-ascii?Q?XwVtsiCesM5cRn+WQ/9/pcoNeUTBYZEkrOgIqPYoeLiX2YVlqeQ4w+49j3wB?=
 =?us-ascii?Q?CoJ6H8fEt9xEXGC/s8ipMmxmDFTD7gC9PSJYA8p1A7KsMfSVzfQSOflI43C/?=
 =?us-ascii?Q?vYRevNVIvCWSS8OE9mTR/SK+I+pAbQa1/EY/jOU7WfHYv0U3YBD+m2y9bECc?=
 =?us-ascii?Q?wVrKGdbSpUgkiRcsxc1Gwe5mDYeA5k701vxTfT/6iJuhyTF3CBUDKNGH4ycZ?=
 =?us-ascii?Q?pV7F8x4t5w3O8g86cYZx7wmzdIsHMDE5T9qFs+lcX0NTPYIUzeDlFv1y0Igk?=
 =?us-ascii?Q?LcFYOlXW1AyMw/2y+SxobBicEhglsPzMv8bnmcjhiZqqruSLK4IVtRc5ar9/?=
 =?us-ascii?Q?P/3LZSTCqXTnlQbsbEdQWOhP8xdl8HEKoXdJL6L23UKmOXjozEmc/c1Pb0ms?=
 =?us-ascii?Q?/0HPoPst0P0nXvXKIfXALl4GlCGN34KZXdF8NtH8LPVlNcb0rXvu3ASlPPtL?=
 =?us-ascii?Q?QoixrzkuEkuof6c7vGo2xXzIQP1FdGp7jv1323nKs04faAgm4upfzEEZwfmT?=
 =?us-ascii?Q?PNuvOzsvReXmPtH7LiHBwdruAnvCSQJVQlc89Oji13+iANhsiiNd5UIVerRY?=
 =?us-ascii?Q?9+iiFTPZas705E5fYRh6KfkZ?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR04MB4965.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 853d474d-e12a-43cd-d41c-08d8cbf5002d
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2021 05:47:20.2305
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SiTzrUcj+g6CSg762WOU8kLo97ld0EWITWtZXYOHvN6+vb0UEAuema23IXi7ohWa4vjaQ3IaH2ARiCMfTDLBcB4xeCPxl8qU/9VzBTVFo1w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB4037
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2/7/21 20:42, Ira Weiny wrote:=0A=
> On Sun, Feb 07, 2021 at 07:10:41PM +0000, Chaitanya Kulkarni wrote:=0A=
>> On 2/7/21 11:04, Chaitanya Kulkarni wrote:=0A=
>>> Chaitanya Kulkarni (8):=0A=
>>>   brd: use memcpy_from_page() in copy_from_brd()=0A=
>>>   brd: use memcpy_from_page() in copy_from_brd()=0A=
>> I'm aware that couple of places in brd code we can use memcpy_to_page()=
=0A=
>> and get rid the local variable, once I get some feedback I'll add those=
=0A=
>> to the V1.=0A=
> Except for the one comment I had this series look's good to me.=0A=
>=0A=
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>=0A=
>=0A=
> Thanks!=0A=
> Ira=0A=
>=0A=
>=0A=
Thanks Ira, I'll add your fix in the V1 and send with your review-by tag,=
=0A=
when this code is upstream.=0A=
=0A=
Thanks a lot for doing this we can get rid of go in null_blk which makes=0A=
code smooth.=0A=
