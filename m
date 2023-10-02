Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87837B5091
	for <lists+linux-fsdevel@lfdr.de>; Mon,  2 Oct 2023 12:45:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236518AbjJBKpg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 2 Oct 2023 06:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236437AbjJBKpe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 2 Oct 2023 06:45:34 -0400
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ECD9D;
        Mon,  2 Oct 2023 03:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1696243531; x=1727779531;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ER/FTed6+mNAkqvfiIoialOP36/w/YcTRQY8DjyZXgM=;
  b=KpLuTy/WqzQFBb3citxVFpLNoaBbSDvqQ5RObLKjPreT825A7p4OoaVX
   AVuOGuVsWHgYH/KbvJVCKOfxIpTBJIccM4VFkJ0LjpfRQKoeWiLU3WaNb
   UKkddv0tBG8H6doH/o05/rb9BloSgtcA7IDzEA0r77ypNsVvDy9AcjnhS
   BB8i3dIuz0HfsIWGGD6mVsadYhb7z4GpnY+T3KTixRs8uZpknODl8UYmB
   FhLV3PGYbp7PS+KAZuWWGDpMpHEvD3/K29RUW1oa7wVs5zBC1EH+OuJN0
   T7rP/mI5k4peo/4Hpp/cXkMIGbuTwU6XilH+BZhS9uzGim6VtMWtCGH+g
   w==;
X-CSE-ConnectionGUID: 0R+X06YRT2urmWIOa5FCYA==
X-CSE-MsgGUID: Wz4LhuweSQmpF3gyW9qelg==
X-IronPort-AV: E=Sophos;i="6.03,194,1694707200"; 
   d="scan'208";a="357551582"
Received: from mail-dm6nam10lp2100.outbound.protection.outlook.com (HELO NAM10-DM6-obe.outbound.protection.outlook.com) ([104.47.58.100])
  by ob1.hgst.iphmx.com with ESMTP; 02 Oct 2023 18:45:29 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fwUfBhVcknY69AgMqcwptGbB4X1L+ITZm8cEb36gNhOu0FDly0Vt/4XmMjnSYq+50E49ZXAS0rvZYee9Un1jXFtdmfxgJ8tJ4fw1J5SqIniuiL+m0WPCvkhp5TIZ9O/flPzMzAPRZ/4XPu3wU7LC5fXg8Uf4m5+wQT2pVgsU/fzF57TxhqikV7h0puDCK/WucBdI9+i6ONf0+acnHEA2pnBRPjVGJdlu4GTN7TGw+2qitBlMxt06+zSHyD7nF1oB6gD2OLBvqOj/Xq+p592Q9n9Nu71ghsCA7XxtId1PyKzcezbWrDCDBuGzLdo3rmyUYoc4Nc0Y2gK21iTnyOctnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rj513BDINBCvdIHNGrjt+E+Rb9SbTDHDhBrYEk28a8c=;
 b=c2NKqnOnADU6Gqw4wR3o3KlySz3z3KE2+Sa+MJ8XSS2Xm5qFkGzyxnqBg0AUWA4ra67KMhlGgQbLyobPYDnOdp6lqXucrWaexhi9CmIxSd4tVdSBR2CQamkSWZzl9Il3vBBgHSTIeqAzdjpw8+By+BqJVQOpjuu8FoK0OYvroGGMTxFfYFIBf6nmcNqa5t2SixQYqxNeTWy8tD41pX9imSA/XYQahymIcBvCk4m63yo2VaGJE3TNQjfmksWf5XqSjJBwsqutUW96KS9aWApg69w9+XzG2XzUpqsFYb8JVu0W1BklOinbWElR+63kUseHO+mzAW+JLd4qg1BAhLhmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rj513BDINBCvdIHNGrjt+E+Rb9SbTDHDhBrYEk28a8c=;
 b=dyPte9vc8UEk71TIAwR1hAITdCaw+tL8XWk68KUBliIKGmbAth11q2u2KS2ae3LdP3nr8MjivKLEjDqwlP7UgbwhveYVKJQalP4UAUpjeTqIfG5hbaRs34XHvFvegZEx03E4g5QuHbwls1mB/ewC6sfqtQNYBZCK13v1sPJh2Vg=
Received: from DM6PR04MB6575.namprd04.prod.outlook.com (2603:10b6:5:1b7::7) by
 CO6PR04MB8412.namprd04.prod.outlook.com (2603:10b6:303:143::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.16; Mon, 2 Oct
 2023 10:45:27 +0000
Received: from DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe]) by DM6PR04MB6575.namprd04.prod.outlook.com
 ([fe80::8e15:c9a8:1531:8fbe%3]) with mapi id 15.20.6838.016; Mon, 2 Oct 2023
 10:45:27 +0000
From:   Avri Altman <Avri.Altman@wdc.com>
To:     Bart Van Assche <bvanassche@acm.org>, Jens Axboe <axboe@kernel.dk>
CC:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@lst.de>,
        Dave Chinner <dchinner@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Benjamin LaHaise <bcrl@kvack.org>,
        David Howells <dhowells@redhat.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: RE: [PATCH 03/13] fs: Restore kiocb.ki_hint
Thread-Topic: [PATCH 03/13] fs: Restore kiocb.ki_hint
Thread-Index: AQHZ6/boF7DB8hsuL02+58Veoj3mgbA2YuqA
Date:   Mon, 2 Oct 2023 10:45:27 +0000
Message-ID: <DM6PR04MB657516145B6C3E71FEDB0C6CFCC5A@DM6PR04MB6575.namprd04.prod.outlook.com>
References: <20230920191442.3701673-1-bvanassche@acm.org>
 <20230920191442.3701673-4-bvanassche@acm.org>
In-Reply-To: <20230920191442.3701673-4-bvanassche@acm.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB6575:EE_|CO6PR04MB8412:EE_
x-ms-office365-filtering-correlation-id: e75a3a16-f2c5-4039-ff48-08dbc334b0bc
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a/HPLtI9bCdclBakXVphw4I54XocXVXbCDtQonpolqkyN/l2DwB17DRoCKzhTdR1KbnTIUzf1z1A37j7a4CY9D32LwPt3BS51LoVjWaJ9ZjaV3+gnbQ4lEH6Dwmm4DNNtvM9ZCkCzT+yjMSbDLb1ADcrXxh9Jy/mtUJ87f6P8moGzvpImz3B17J5r6P0TOIIeMSVfjskjyJKVPIjyB/1TFpBIvRw2HPYpgPWkYjhTwtG0R9DOF2g2jTOn7qRz4eY+OAPjlBEKrkNXcGYTHOXcBuhXxtquIrHQbFX017tBV2sP7bYKmJN690moWB2n2TS68d1cln0FeUq2OgQh4Q//mMli2CTYst70vGq82C+gNLKPOK/OxhPzu036Xa68qno18xWv8yv5C68rhbGNdFT+svl3SksfBZ2Twq0GT7gaUtbkqFVnkckFZlkz3tg0hs3/uA6Zherg7eCkr8Bc7gm4CtC1ViR4vCsUscTgmS5l4ctYK9GiZXaRhH18BilPLdGSilE1ri/KdMW+KAxYR7r8DQwb90LbX6k5uQ7D9GFCn1Hq/irHUdjWAIPcSsNRNC3uPkIPqb/tP4JyZuGMF93s2PYXiC7FE2zBuxW+AL13Fqt+s2UDMp17Yz1y1fO47cy
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB6575.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(396003)(136003)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(478600001)(71200400001)(83380400001)(26005)(7696005)(55016003)(9686003)(122000001)(6506007)(82960400001)(66446008)(2906002)(4744005)(86362001)(33656002)(4326008)(38100700002)(7416002)(8676002)(8936002)(52536014)(66946007)(66556008)(110136005)(76116006)(41300700001)(316002)(64756008)(66476007)(54906003)(38070700005)(5660300002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?+VXcxO7+1F9lp0TovN1H77LBGLJbnSk+RWJ3Cm1vOg0z9ZZ4mJ9SvLCXugfQ?=
 =?us-ascii?Q?66wT3wbyOSQLRjzfQAk5nOOl62uwG8Qmdaq60cNroCEJQolJUuCPlFKuLgGz?=
 =?us-ascii?Q?OiDy6eFevc3Rti9V85duPGGQTIxncTqfxWa/UdJ7PIvky8okxCjcFzdmMc+N?=
 =?us-ascii?Q?WRsgqHqQsRcHAdC3yz5P9cKxIbxx0VDraHYVOpXLcUmHssYHIgEeAssYsaHT?=
 =?us-ascii?Q?TtsCAXAkhWl6K/CBMOu2YnJ4VllMqC7JpnlxWLJ6VcKeq7WEaZ41gFRNZUeo?=
 =?us-ascii?Q?o2Ay+laZr80G5OE9MWMH/x6lrpxtbjUVMasFhFEyuUiUzexSfhP51v71Imhb?=
 =?us-ascii?Q?uWjTHdKqI88pBMVnaHzQ5XZb+u/RZ3LirOW9ZvO8bkLGx30UlejcELFcMMj0?=
 =?us-ascii?Q?m8AkaFUUt2B9Qg/bfatPat4zEzR/T4IFHQ0OzQikbVVJFDAmd4AdkNh/mIvC?=
 =?us-ascii?Q?8rFlCe5fPUIGxDo3+67OLM18foVoeSEcbT2+mUcwyP5Uq0eGYd8xZw/j1Qst?=
 =?us-ascii?Q?KhTZwDesU6kh8IAk6fAmS0WLpVnPOwZWs4rsTrB5QOOdbB22fI099dlBjgNq?=
 =?us-ascii?Q?5r6BGiQ+eynNRuaA6z/LjGpP5YXxMf1FVDjBBZ8w50R8D1/Ga4xSdvPqhfpA?=
 =?us-ascii?Q?j3ImgxvVD6hW6ZD8seo5k+t24ng+1xasrC/M4dd79VhkI4jZssQVncEt5jCg?=
 =?us-ascii?Q?0pJKK4uWsNmZ8mKItzZPYu7p2M9xlVvXCRSWFPCM0u9hdHeUfJ4Y3fT5o9F2?=
 =?us-ascii?Q?jiYV9IV6g6cmM2b2Ct1Rn8t2Qy1xq1X5iVRh8r1n7PPNuDVOUIG5d5z69iy5?=
 =?us-ascii?Q?+DligoJBi5O+rrlBmNk59+8ASfJq6h9ZNNSj82jLGLs2xG6QmETW1+czVROE?=
 =?us-ascii?Q?vAIWDyxJVXB9jldxcvybUJIxKchvn0JQJhp0EL9E3XZ96iq+fZvqBV9sPZgu?=
 =?us-ascii?Q?AI25V1wNNQxN4WLKAQR/kO+ciQ/O3C9cNMiVWz4/WKG5IX2DNKkv5BaVTn6n?=
 =?us-ascii?Q?EDZPpWRo7VEV9i0mfSP5Bg9lAfB22ITV1Dt1Wsv4cHrNPBnwibVdYMgaTiSd?=
 =?us-ascii?Q?Pqo28rT1nIFpLgkVWJi+dMxuW0WFQHGrZmdDZO8MGwg/JAO3LAi80CSMLIyD?=
 =?us-ascii?Q?ZQ9UglqJBnATyuFundPzgIy35tu3McYduDA5mYyWhAWVhPXpNiywVLV7+kgo?=
 =?us-ascii?Q?tRQxKvJHTI9Cj70yX4v1NmOMPdBEfCjrimmzjBvs3LF1e1cvi9N4MvkjVtzT?=
 =?us-ascii?Q?2TQd76QMhny9LyNonrq3oO1R8+6EvGLvFBu3o6OkB+yjrqtxgRSPcGzLcpzG?=
 =?us-ascii?Q?N7zXRT/43m6ON4SYL3IMHt+PmHvLhiBx3E/za/wp3L2O6inqgwXrZKJUPDf0?=
 =?us-ascii?Q?YXpOBIJwKsiDuUWzXPcLr0RTHUUcTV0iCDoyMMVri2SznYASKHlth0kO71Uy?=
 =?us-ascii?Q?AmavDQx0JS1K9xUZzbdxqF/koGR/sQ/RS4dZGC7WasNUM+0LEgivlNi4jaiQ?=
 =?us-ascii?Q?rbJaz7k+dB3cWZx8WdXp2G+tQyMU+RWh+wh3ZaBkXxB4fzwpG0wPD+EdxwJ4?=
 =?us-ascii?Q?0yezde2Um9xk9C12uqX27w5vV4VxVzspW4CiQDg7?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: =?us-ascii?Q?ib43QiXR+sEC2Z4+QmC/hOKWC1Zl2cgmd4QCiRaUrR22bmUqhTULj9wOQzcL?=
 =?us-ascii?Q?Mt/qz7tz95LRy1GDBWP7a2B3bUcFh/P6CF0svA/9RBg/6VR3dh2LHIG+8hk8?=
 =?us-ascii?Q?YWXsTCMw8jXv2VUy0YBp3F2JHWoMSFXcmnid7k2TuGiJIR6ZI22P8sUeptAG?=
 =?us-ascii?Q?IQZFPlXcnYJKAKlWUFUHiiQyTt0/4STz3BNAHYOCJXmtckIBPAbUvJqqk/y9?=
 =?us-ascii?Q?zQ2cEfJ0BC418FVCZkaw1ivC32UdpBG1SXWToNeRhaYKYcE9HjzwFCljD7M9?=
 =?us-ascii?Q?wv645sK5SORDfaOS+DlLBqjsn+zi9E/QnYFe1sKcAB3oX8Z00JUrpPylT0UT?=
 =?us-ascii?Q?ZaRhVK+J2Qa3juePW4vW+ky0NSxdvWa3j9ccIRTRE7X9/jXdLuCiz3t5LeLy?=
 =?us-ascii?Q?r0QCIS8XCTrfpq7e8Lmxi7KL+f4vV6t6VFoLNL8OCad6OFbOpXrAPMKQ4q05?=
 =?us-ascii?Q?EYTRfVIg/zTjAfi2RV0abPiByUifs+Sdpxcvy3BEv/uYckwabtLs55fSklMT?=
 =?us-ascii?Q?pHGSSqpQ8+S/2ZORVwe4+78enS9ruNL3jwXQzxenqwjfTqBRt8SiT5Ck8rKX?=
 =?us-ascii?Q?4j2UFRSrKACtAacRSK1D0DRP3LlB43jDLZz7U+vpdPhAve6lZmTJO0ZBQz/u?=
 =?us-ascii?Q?NSHibSX98y0xiT8zdQBr1I/Lpz/BValL5jCdOPWb7wyQunY/Nr0u/mDKIOCw?=
 =?us-ascii?Q?bWXsa2sFn39sF6HXunym2DMFESjRQ9gIOVYWuZZJh3XFCUC1yQmGY/oE81e6?=
 =?us-ascii?Q?chpmgbWXSWTWNyTNeK3iZIOX+mqEV97JxySzKT3nkWuMZIsfrOc6boCk3cbw?=
 =?us-ascii?Q?6mHez69RlboB9380hM069adad0VfPkeh6P8CxgAMXLpb+qkSBgG1zn859b+o?=
 =?us-ascii?Q?rSJ7fHgOpEY0Q+vKe909H/7KMNueMD/3f0X/mFwJW5wsHneirej33ivCM1aF?=
 =?us-ascii?Q?wBpRjJBpbTy3DtrFLqH7wTyZWRE38R0lZK/zQsY4qheVaheV3cE0AD9TKJU3?=
 =?us-ascii?Q?dk2GAMIJ3FUsapZIjsj4tRN5NUaVQDxDf7HeLfPEwElT0ZM=3D?=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB6575.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e75a3a16-f2c5-4039-ff48-08dbc334b0bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Oct 2023 10:45:27.3447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Kmr/cXVySWvJHaMwfQN8NG27Mnc9HVJBdAeJxCUpFKJRoVYrajvpOgxKqu2bJyigkTLz2auBmjqExDAuknY+wQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8412
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

=20
> Restore support for passing write hint information from a filesystem to t=
he
> block layer. Write hint information can be set via fcntl(fd, F_SET_RW_HIN=
T,
> &hint). This patch reverts commit 41d36a9f3e53 ("fs: remove kiocb.ki_hint=
").
>=20
> Cc: Christoph Hellwig <hch@lst.de>
> Cc: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Bart Van Assche <bvanassche@acm.org>

.....

> diff --git a/io_uring/rw.c b/io_uring/rw.c
> index c8c822fa7980..c41ae6654116 100644
> --- a/io_uring/rw.c
> +++ b/io_uring/rw.c
> @@ -677,6 +677,7 @@ static int io_rw_init_file(struct io_kiocb *req,
> fmode_t mode)
>                 req->flags |=3D io_file_get_flags(file);
>=20
>         kiocb->ki_flags =3D file->f_iocb_flags;
> +       kiocb->ki_hint =3D file_inode(file)->i_write_hint;
Originally ki_hint_validate() was used here as well?

Thanks,
Avri

>         ret =3D kiocb_set_rw_flags(kiocb, rw->flags);
>         if (unlikely(ret))
>                 return ret;
