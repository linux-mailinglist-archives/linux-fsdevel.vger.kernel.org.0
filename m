Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 299F24CB970
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 09:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbiCCIoj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 03:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbiCCIoi (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 03:44:38 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E661587A7;
        Thu,  3 Mar 2022 00:43:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1646297033; x=1677833033;
  h=from:to:cc:subject:date:message-id:references:
   content-transfer-encoding:mime-version;
  bh=Zab4i5IsOq/xnyyJmTS0BD088NbEqllao32XcrfPNe4=;
  b=pAF6HLaAF6pQ1LBAnas1+QYdatfGX2fkVGmHW8aqE3wZSdslciQRoXMW
   PXGWqP6HAs4fu0VUmfFljSUSu3Nc/jijlJcVk5l2KGH6vIJCkHTFEr4Hi
   ghjT2ElWrUywVeq+NfbFgXDk0cQwnN06UHdDb3kPF3+BVOv1IBks+HhyS
   JnA9J3gWq/OFTdxFjPtei49MiqIra1eIkre1UniOIKsCFVgNWdXThaPzP
   E+A2I4KtraXm/Rk9L3mMuFuPthNcY0p4fivONH/4UY2158XL4WcRyC7c9
   oPsVQ4e9QfCo9uH1YGRX3rTypyKPdRZ5sYZzjOZpstw3d8pewIHZu8EaF
   A==;
X-IronPort-AV: E=Sophos;i="5.90,151,1643644800"; 
   d="scan'208";a="306272676"
Received: from mail-bn8nam11lp2173.outbound.protection.outlook.com (HELO NAM11-BN8-obe.outbound.protection.outlook.com) ([104.47.58.173])
  by ob1.hgst.iphmx.com with ESMTP; 03 Mar 2022 16:43:52 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DZ2AYQCQU7a1GskIE0UNqrPIqkaAZwQ8iG1CuxkpT1Ccrfh4D+fpHdCQyr2Mqt53uuNYsd8DETKwWvkInNesBz1SqMTK7L+Kg+8N+l8lnIE+r2sRd+uHWcQEJf0GtGbI8/Bvs9B5cA4Zop12oDOFbeET/tffNmfenigIhHseNiQ7Ap93kAWi119c7dflNhalDVBwuYHT5knz3pa+R9giuzhcVf0WwxxJWCHGG2vdyPReoY8fIcN+d6H35dolRgSom57vnBo/f+P92AF6FGxmW4M1I7BJW86Fo5P6gXWuw5u6D2cKRloYgaPHZg/N5pcpD791ulPdi2YEwqUwV9N0qw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8Qulnz2Aw3N+H6CC2HFUe+R7h2zPzhuM7jWkh05jdKk=;
 b=azxQnyDWWXYqXPhbrYs8RaLcEBTt230dTJjfObL52MzhATJkck2DpTU9t6eAo3kHv2kJXz+Mn03eUtiEkY9veZ3X5aXLzFWN+Fk7jYqYEltcnvVWwTdJwsTtzjQ4wO9WvLzPjbdRngBTWfLoexZc6vKCTIPINQvu7AzSC/GO5T64fNssl6j0h+4U+N+VCUQLtLJ1BVFtbkQq5TFd1BWbehheCCn+BaUIVlAOByqdDyEXH5VPAbgihig6VcpaLW9nHBVj9s63pS3Lr6eozu1fbld9XZFtIRPEy2/xRbfgcIKKF3UQRFzJvHf60D/9RLAkl37P2iOWqYzW75dQKS4bNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8Qulnz2Aw3N+H6CC2HFUe+R7h2zPzhuM7jWkh05jdKk=;
 b=ObOhbGB9pbIwk1rmeLrefCdOGH72sn/ofjgy0Qg9IAV/C85Wndvx7z+AI/vX35ssfXsdZjmRApMjhy/ibXSlF4qpo+m6yUUkmwh6pOlQF0ounjP7H1pczh7DodSfWdcpJ1mXm+MQ3pYXdrXOu5zpXSJszAV++ivJDgcBfoiEbMw=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by MN2PR04MB5536.namprd04.prod.outlook.com (2603:10b6:208:d6::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Thu, 3 Mar
 2022 08:43:50 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::e8b1:ea93:ffce:60f6%4]) with mapi id 15.20.5038.014; Thu, 3 Mar 2022
 08:43:50 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Luis Chamberlain <mcgrof@kernel.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>
CC:     =?iso-8859-1?Q?Matias_Bj=F8rling?= <Matias.Bjorling@wdc.com>,
        =?iso-8859-1?Q?Javier_Gonz=E1lez?= <javier.gonz@samsung.com>,
        Damien Le Moal <Damien.LeMoal@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Adam Manzanares <a.manzanares@samsung.com>,
        Keith Busch <Keith.Busch@wdc.com>,
        Naohiro Aota <Naohiro.Aota@wdc.com>,
        Pankaj Raghav <pankydev8@gmail.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: Re: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Topic: [LSF/MM/BPF BoF] BoF for Zoned Storage
Thread-Index: AQHYLpmoe5dgRHtRR0OXY/Wz2q6J+g==
Date:   Thu, 3 Mar 2022 08:43:50 +0000
Message-ID: <PH0PR04MB74167349E67E7CC6C04E007F9B049@PH0PR04MB7416.namprd04.prod.outlook.com>
References: <YiASVnlEEsyj8kzN@bombadil.infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e496a51f-6f8b-4233-b97e-08d9fcf1f0dd
x-ms-traffictypediagnostic: MN2PR04MB5536:EE_
x-microsoft-antispam-prvs: <MN2PR04MB553633A2ECF14705584BB7C99B049@MN2PR04MB5536.namprd04.prod.outlook.com>
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: lDaJdDGUFN++TFc8oPAvwJiSOdusOAcuWZHqltDN0FKHilAkEwKtdQiojO+7tnf2gZ7EmeOrM+xGedtPQSn9dhGyttLMCy+IyAG1HVKeAex499h74W/9/1jBU6SUFNYQ3zirKT7Y2Bmj8db440XMOKq8qUrGfbRZ4qTRlTARdrK8SJGw45fjrNtMuLJL+JHSl8ysQzKS+5aVJZ3fHAEe5Tk2V/bQBjBtyNsW1a1VL99D5wC5BIIWaV1VrUYgWSL2hUGOsECIDloymPwP0t1H0WS/EHKedTr7rWoa3yA0dHXezMrSnZmV3RTc0kp3GqxHzpqpa4R4YZDGDzxkHA1CgPoiXT/ojr2M+N9TJDp8CiaSFD0MAjTa39YSYlIL2Hu+OrLojx2ufbmPClsnSjBcv6d3oj5KknrxsAAJ7DxFVdp0//ECXzq1hqghM75Uj4N3ZmB23Sz6aVEL8vI83MLql2FgwDKnKUFJEmpWDk42PAJg64x8IkITMGNn4wSjD2kptwrZWgRlLmkvE14JcbxcCxNxhs23PQQQZa0rp0xdE3wzgIbayoJyd5k1fR1zp3r0hZrB7QsSUaTPx90MQb3kNQ9W1sAlTeHPJdzRlpzUbk/iEE6MOPF+/SlHYNuWpdJogKC0MbXIf4QeTp/WGbndwqD2Oxe+wvsMW6S9VAiLqCERJKOFqa8i3xKbtvB+EdhhhGckmM0mrY4YFAk0pDhpeg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(83380400001)(5660300002)(7416002)(54906003)(53546011)(186003)(4744005)(6506007)(52536014)(7696005)(55016003)(8936002)(9686003)(66556008)(66476007)(66446008)(122000001)(316002)(82960400001)(71200400001)(86362001)(38100700002)(33656002)(508600001)(64756008)(38070700005)(76116006)(66946007)(8676002)(91956017)(4326008)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?O9QNN5Tn82AyWzFBTfy0s1ejzU4Z+EL9kjvUB4eNOkdKrrNpgyGavJMbep?=
 =?iso-8859-1?Q?5u9zC53wJ+z62XHnuduKD42caXIt2KstsuRmDXHQ7CyifnB+63Njm89az8?=
 =?iso-8859-1?Q?x5DdNWe+e1ZyeSu14OZ6VhKv4nIWp/2n+F5wm1boHeSygD0dhngMEebNcm?=
 =?iso-8859-1?Q?i3tweSMABZQP7uLPFo0KpjCa3/efvdTeDzwBEvIbDmmTloETD3AzEIo5gL?=
 =?iso-8859-1?Q?oDHPT7nDFHpnCe3sr56NqviLXZdoC0hofu1wXTfTETza2w/FEa30NNpe+X?=
 =?iso-8859-1?Q?z7AdopyjfAKFZql0a5VeIrWQKsr/WAcdJeFSvj/s4XasRzi5aQqDprX8iZ?=
 =?iso-8859-1?Q?a9Wb3mnUr/WkJkVtcFa6tBevVUUi/FQT2t4bUWGEIDpgi6Uo2N9w4qFOVV?=
 =?iso-8859-1?Q?hY2zk6DyNtlyGK2CMpkfT1RpPZ92vCdoOfECuP4OA1kphaSUibYkd9aIJs?=
 =?iso-8859-1?Q?A2xlWk1qPr8uebV13+5lnmCUIJD5Y7RIPtIlwxcYWxl3kPqEH5Rfdnlpur?=
 =?iso-8859-1?Q?+v8iq0A7E4E51USHj5yEufA0iyD4OUM/0ArpzocAR+BMHwAR/iGzl9Uk2V?=
 =?iso-8859-1?Q?qmO1k6v8R/42OwL4Xkpb/xaqg5xrgpu1wv7iuhj1NCSWrY3Vod2ZuSZ30X?=
 =?iso-8859-1?Q?Yb3vs+PNH8l3NWiXwbNSD4RWD2f6dKuGdIp4WBkByb6lvwqKVanVguLd3Q?=
 =?iso-8859-1?Q?a5rshGcNkAECRfhJQmVa1VjaVAow1u9bUKmFt19dlTSgZfx1I6xZ4Iqx25?=
 =?iso-8859-1?Q?0C180eX1uuje01h3VfoPaeqbi+17NiQNiYVj874UNbMa6Joscn8Zzyox6e?=
 =?iso-8859-1?Q?kCnC6fjhPGAFTdFXeAo6jJC35MevTZ9YpFfiQLg6+0zvT1nFhrO9qa8ufE?=
 =?iso-8859-1?Q?qvBxtU6hEjEaDRZqknu148bcUPep3XYbfUeEFqKAmzAnaGSHbA3qAYEomi?=
 =?iso-8859-1?Q?+QDPZ/exhAQoj7ftEwZXPuLV23USmYaDcb/d2JR3NxuKvwGxNUcG1XxyhA?=
 =?iso-8859-1?Q?BJLgueZj9wELvFeEeGJ9teF22q6OOIzq7kGrVp3kMn3bQsuuxooBADY4Pq?=
 =?iso-8859-1?Q?SA3GW0KS3Ls4Epf6A/deKUMYDWGH8sZrSjfXPdmb/+6ta1SRKlXK/y6ulc?=
 =?iso-8859-1?Q?xm/6uwlVI+e/HvrndLN0TI9WPRd1JJihiUVbsgmXhS3DCawSzmk8516LAa?=
 =?iso-8859-1?Q?wmHKE2cQAJDO8wIvDlhNOlxdEacxj9A7tU3trwLhbDSCobtmuuqoNglRc3?=
 =?iso-8859-1?Q?JG3f5RN5sVT+8YmNnXdpp3MgF3xW6xo+EyYDisHw/n5Nx5oCd3LAbq7gtA?=
 =?iso-8859-1?Q?0fwIghnqAKiqrmlk5Jhv/yeyoE6ssVnCLojllyC44OqVHCl3M7fwvtVroJ?=
 =?iso-8859-1?Q?J1N63XM8/ldWaVnaXXyx9/NgDszO/6FDsaiy1ZCuwLeO0g1PnQg6H6Iztv?=
 =?iso-8859-1?Q?dleTDnERoHeFgBFOJmYiNR4FZFYGfrZQ/jgFSiQSLNurnn8+rTaXB87Uxh?=
 =?iso-8859-1?Q?bN9aA0LiqEJDI9Zxb9zsdxl9btpU6N3luM3604p/8GrQiyhOA8QrviS7iw?=
 =?iso-8859-1?Q?h4nX6Ez7Lw1tfX2kUV1X2uP5EshrGvMpWz88b81eqVC3xhhFLrKM0n7caz?=
 =?iso-8859-1?Q?ttYt63JacK7NdVTCwaI3S3f4AEsm2FT0drr3wfZE9gBwZNy+KgwF//jJWH?=
 =?iso-8859-1?Q?+VdOIrBYjHG/YbqrU1UcqwYQl2V+ZEAv6hQvhlD4Z8ndix7CIZHSRkv7yn?=
 =?iso-8859-1?Q?5B/YUnAYQlE4ht+NsHmEZ1WSsVP1SyjyzCdrjgcvgY9pXUj8DfRHHV2D7R?=
 =?iso-8859-1?Q?GixO8cvjpzIIoavBQmmYXqCW75D+JNM=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e496a51f-6f8b-4233-b97e-08d9fcf1f0dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 08:43:50.5516
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BUkWZHG5RGQAWTLzADW49ivFBkUX3SkLvzgZGCiHrEf70GRAdSxtymtRuYgL8etYgAo9UeikNysofixs2oAZKUlK+DPcoxo9O3Mv2r5/zbs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR04MB5536
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 03/03/2022 01:57, Luis Chamberlain wrote:=0A=
> Thinking proactively about LSFMM, regarding just Zone storage..=0A=
> =0A=
> I'd like to propose a BoF for Zoned Storage. The point of it is=0A=
> to address the existing point points we have and take advantage of=0A=
> having folks in the room we can likely settle on things faster which=0A=
> otherwise would take years.=0A=
> =0A=
> I'll throw at least one topic out:=0A=
> =0A=
>   * Raw access for zone append for microbenchmarks:=0A=
>   	- are we really happy with the status quo?=0A=
> 	- if not what outlets do we have?=0A=
> =0A=
> I think the nvme passthrogh stuff deserves it's own shared=0A=
> discussion though and should not make it part of the BoF.=0A=
> =0A=
=0A=
Working on zoned storage (Block and FS side) for quite some =0A=
time now, so please count me in.=0A=
