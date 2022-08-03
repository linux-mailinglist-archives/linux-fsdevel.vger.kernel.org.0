Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B7BD588790
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 08:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234955AbiHCGri (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Aug 2022 02:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230290AbiHCGrh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:47:37 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 237B63BA;
        Tue,  2 Aug 2022 23:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659509253; x=1691045253;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=riCeVEUI8Y9s8nX5iMcRRLoa7Ljs8rjLwGtlIf2YDKw=;
  b=uofLY74UMrDTvOyniUhIdGXBhQO8/Mvbdrl3+2qAF4hBEeULa/SrNCgG
   QekRrSBsLGBnhUkxk0g158F6BhweGFX6CUsYPtqXaulEMAZITiP2CkTRP
   H5T0QWPqB+RQsvxxwFDo9ksRw/ee9pMoZvjIyqjGWFmRwZ7F7ieD9pMe+
   B45kt2nzHkrw//TNqA9p+6ule6a/Ga8wX9zMauB07WWh5s6kZ9VAGGebZ
   6fBNiNgjNVPI+sscKtURcOfuo15vlXnlaGigAXeN93ajmCypbMtQg3OdF
   82UwK+RsxPSwBNnaVA3oBKve19zlc2PlOAchdUP4PJWFpo0yeswixvhyj
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="61604307"
X-IronPort-AV: E=Sophos;i="5.93,213,1654527600"; 
   d="scan'208";a="61604307"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:47:28 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Op6zGgR/niSnoyyVTDC8xHukiyk2jKb6R1rbx3KpZgtV2juyzK8bVrqPYACnGwiN9Om7manCqJl8sAG1nJq+CAbEENKaOslCiDo6MKj2v40kOcZQMk4WsDhEHZKSF1uAVKTN041NWqkhiAom1xj9kmRN93Y1oj0rhwvflRMYk744uafL7nvH69vNVPV4U7vE0dlB2gryxmF27uMU/cXvuuBi/SGhoh1xfrjOO0dlPEUpUELiYHkL9RqRFGHgycS1rZE6/Ps99I+f7B/aVlHD8k4hohDXDYppbVHtXOzjTESlF6mOQRmuppdgMIp4OF/E3zDLWepowFldo5vZNJbjZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=riCeVEUI8Y9s8nX5iMcRRLoa7Ljs8rjLwGtlIf2YDKw=;
 b=laz1NKuYDzbg3YcpGaOfvzV+xCgiWdJWHNxqUq1w6KN1JchEOgbxPGnuM7tm3gr/UTP/75W2xK8ui04oFQctTMTCuvxlRAedRQNZ6r/dbxWcB51PSf8cYcBgcG0Buj02ethOcGAYT9zGya7jg8uLI0xmm71sGaC9KbblU7/39PVHkdqg2uxOWYwCClX8Z8VRen3aVltDTNzW9vE2FLnp+Tl4aRYU+afFPDET7IKQq9jhz7e42vgG1AZt2OALx33L+cnIe53jdC4FJeVseWGkjeev7ReBf/DSBt8lCFUsBp/KipLriOTGPMIBcQV/OdDovXbEBfTHTeOXsfdCf0R77A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by TY2PR01MB4777.jpnprd01.prod.outlook.com (2603:1096:404:117::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 06:47:25 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca%7]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 06:47:25 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>
Subject: Re: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Topic: [PATCH] xfs: fail dax mount if reflink is enabled on a partition
Thread-Index: AQHYfA4g5aj+ViA5o0mdS5cU960Zpq1oy6eAgCBSEICAACSLAIALwXoAgAASpQCAB/r0gA==
Date:   Wed, 3 Aug 2022 06:47:24 +0000
Message-ID: <0ea1cbe1-79d7-c22b-58bf-5860a961b680@fujitsu.com>
References: <20220609143435.393724-1-ruansy.fnst@fujitsu.com>
 <Yr5AV5HaleJXMmUm@magnolia>
 <74b0a034-8c77-5136-3fbd-4affb841edcb@fujitsu.com>
 <Ytl7yJJL1fdC006S@magnolia>
 <7fde89dc-2e8f-967b-d342-eb334e80255c@fujitsu.com>
 <YuNn9NkUFofmrXRG@magnolia>
In-Reply-To: <YuNn9NkUFofmrXRG@magnolia>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-08-03T06:47:24.176Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2447de42-0cba-4a1d-1c13-08da751c0637
x-ms-traffictypediagnostic: TY2PR01MB4777:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sKoh/1NFDraT+WcGbOsNQo2Tj/WeQhihEFIbkjAXwx1cLwJFX30z4O4iro7j6W1N89Z3GlcioNsCiC0V+DnEbftsJHh5iMzdoyntz2cfbYOyTryC4pRqC2anhbAcMCMzxSVqb4yxWcqCCXfMsX5yBtXJs8rIuYC9MOcENxs3ct0zC8slZD50+EcIpEO6RW+3Fd8Y5c3HPqwFOqMm2/3BEfI1laRJpXjkfF/Rga1whLiAMYLNgCKC0KOuk2vGBjQ/S4wjSO4AuxIYCOUHnQfRW5Rys+U8Px/iUPLC82TZvQXtrcVL+TO5Fa1laEgvFlJ4+Gwtjm0CxAjfonOiL0uN9ciY1Zz4aFFl0t7SzhvcZa1hrMMqP9e9RAh4r0A17Ptc4QtPKp8ijiIbAtHDJDS0Bt1zCZ6racPRP4ZmPdByW0fsbgLh/W/G81J0k1JJsiNVKG6+wDq6oBuKlxLSAbg/EP25f9NXsBOCtWgbI5yjJDXZ5oKuDT7rwwbLqlIOEwiFaNFldhRPeftonYJgVOpEyo/yHEMG1uhVTnGLNb9k20+1oyo4f/feR/qOK+Gm0cu/lsWJ7ZS4OBMG2EAsJ7XOxHR0KGDZd6GClODbQxKa+PCOCASRUS2Sg/KzWLNtqJWF0fd/SB1FkDise1HeFF6AIzodIcMlULOzkAZ6kV4gj4+qTWseaBplmvLU/qHVtswoZui99fxZEsmh/OatIkosxYe83UoJc7SK3O+12SJLGQ5i+eJ5MzC4/zADJRkLeEjn/MagURyGXSSB6/3apl9MZOadMuBoZbkvn40Dx9Y25iEo6h44lGCiJ7Tu9ujzAAuTfN3a6Q3uaCck4PCYLmteAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(376002)(346002)(136003)(396003)(39860400002)(366004)(26005)(6512007)(86362001)(41300700001)(54906003)(6916009)(31696002)(6506007)(6486002)(71200400001)(316002)(478600001)(38100700002)(38070700005)(122000001)(82960400001)(2616005)(186003)(5660300002)(91956017)(83380400001)(4326008)(64756008)(66446008)(31686004)(66556008)(36756003)(66946007)(66476007)(85182001)(2906002)(8676002)(8936002)(76116006)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?K0pYdnk1UlI3L2ZSY215amZ4cENJcjM5YWlVQWRPRDJYdUZrMTNvY0FERGdR?=
 =?gb2312?B?RkxSdjVEM3J6QUFPVE9iTmpIbDZOVzRhNzNCdFJuNERLVUFEWFN0UnA2cW5C?=
 =?gb2312?B?L0Q5K3cxOUFMVTJDc3VkSFlCMHMvUXJKZmIyQ0d1dHl4eGoxNHVzMVMxRmdp?=
 =?gb2312?B?S3ByKzNjTC9EcGV2dndkTkw0eTVFU2JsU2prdEFDUGpPQTVuNmx4S3RxZnp1?=
 =?gb2312?B?ditxVnN1aU1HNG1YYVluUXhEcUUxZGpXY2Uvd01pL1JMNGtoUDd0b1p1L3lV?=
 =?gb2312?B?c0tIVW9wTTBJbVo4Tmc2TWZoZHVNYTVmOGFDaDUxTGo5NzA4Zk5xMFhVZ2x6?=
 =?gb2312?B?NmROVGo3b2J2WU5iYk9GNmE4V0Q3YkdweEpsUkh2ekNaczg1K3pTMk5tT0tW?=
 =?gb2312?B?QmVlaVFTd3RsbEdxTXEyR3NUbW1MRGxxQ3p1bkVxdjRkTlFKUVZYOUpjbVRO?=
 =?gb2312?B?T0tKeXdsSVE5cCtxNTBxbUxyR3pmU3Q3NmxlL1o5NVg1YkxhMGRaMWVuWVFS?=
 =?gb2312?B?UEk0TjFNdSt2MVFhM1lMdHVCWGFxbGtFd21USm9PYWRZbTl2VjR2TFJJK21h?=
 =?gb2312?B?NldFcG0vMWdRd1VZaVJuTXBYRlJVL3hPSHNNSDFFeXNFTFhIYkZNV2JzZWFs?=
 =?gb2312?B?WW1hVHdYTjVMeitmNWd0MnpQZzRlWXFTRDZWMytQR1YxOS9scXU2R2NrUnN1?=
 =?gb2312?B?K1dpWVNaSE4yYjA4Wi80S3oyMllZU1JIQ3pjamg3bWxiYmNiZnhPSFpLcGJh?=
 =?gb2312?B?TTdidUFVbktHV3ZzR3g3SVcrRml4QkJQOVRDWEVRcTE2SDU2dzZiZnhGYUdi?=
 =?gb2312?B?cm9sRXdqMmlsa0dJOFRMa054M1pyV2FYNDhvc3dLUXhHZDJJY284VkkvVmpR?=
 =?gb2312?B?Qm1TN3VtM0tFL2VRbEt2TUhyQlNlZURSaFFFbU00eFRDZCtFSWY4UTBFTWNI?=
 =?gb2312?B?bkpvazFSTmZHM0t4SmVUV0w4MmZudGI5NlVQdUpZT2ZMSU1OMDN3eS94cUta?=
 =?gb2312?B?ZmFRTDhCRytMTzl4QUJuWnRZNzVjbjNIUjVYWVEwYWRrVGVWVHRMaVZNUkl3?=
 =?gb2312?B?UHhpdnBQallPQzRBcHpvdm54KzJ3Qnd5aFo0MVpKb3FCNW9UVVNVQXdrR05s?=
 =?gb2312?B?eVZaNDliV3pwRW1VNDJXdjk5MVNNSzhiaE1XR0VaQWcrUjJyMVcyazRWUDU4?=
 =?gb2312?B?NVc4RXByVXdxbEFxTWJZRlJVLzRvQWlYWU45WEE2cDJQK25TTURRSjhsdjdh?=
 =?gb2312?B?eHZlcUFFOE43bkJrd1F4YnNQRnZNY29UWWNhVWFYR0FSYXZnREQ3U3pkRWN5?=
 =?gb2312?B?K3pSSisyRVlRY1NLbnpUUVNIWEZoVnoxRSt5VHR3L2RxdytjU1RTek91bTZN?=
 =?gb2312?B?dGo0TXVyam1iWTNWNlJsN2VpK2ZHQXBIL2NGWGJHL2xNbFhaSUYrOFBrM3Zk?=
 =?gb2312?B?c2graVprenVkSEI2Wi9XL1RjU0grcExkQk1OLzE4V0E3MUswbko2UG1LNFpQ?=
 =?gb2312?B?bmJtY3ZVUXh2YkNQdzkvOGVSd1Zqa0FyTHczS2VRYnVvc3psclF0cTJjMUdQ?=
 =?gb2312?B?eU5lbjVuSW9JWUxyUXhvSGRBZ1ZTR3JEZkxhRlVsK1BHelRraXBNN2w1S2Jt?=
 =?gb2312?B?L21UNCtSeFlVRzlqaW1jY1VsQ3NJSWF1K0dYSkZ1dkZuZTZqRVg3YlZOaEMw?=
 =?gb2312?B?MTVXKzc1SWFmc25zTTFLUHRDeTRibnFZSzU4MDN2djdreUtLVXJLcXdiWXQw?=
 =?gb2312?B?N001RHJnaFVFVVlNYXFpb05Nd25pSHQvUEJXdUx6Ly9kQzJ3M0RoVjNqeE1N?=
 =?gb2312?B?d1RiaG9BMnltYXJraGNEQWh6b0dYU0FmekdZRk9yd2UvMG5VY01ZQ3JnZkMw?=
 =?gb2312?B?ZVV0Q2I3ZHRhUmpZNFAyYXAxRlFuMkZlNU82MkRlMUZheHpVTy82b2NaTHo2?=
 =?gb2312?B?N1lZKzNGb2lFTi9hUXdjdlp6dmRhQ0hjT2ltelhQL0RvbmgrUDV5RFBiVG1G?=
 =?gb2312?B?dEw1eGV6c2lmc0FKRjJML3pGZGRiRzQ2QU96N0gwUHJxdzRLejgyaWNjdk8x?=
 =?gb2312?B?SldYTVVrQnIyNEZ3RzI5dzVvYTFzTE9USjFNTzdtTFJKeTQvRTJSQXJKMTBJ?=
 =?gb2312?Q?du1mwmVBgH6PIQLHlSVXqy8uk?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <34BB07496FBB5D478A4DB0F81228CE6A@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2447de42-0cba-4a1d-1c13-08da751c0637
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 06:47:24.9530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9zN212E7T5RwQm4KyuX782kTXnt18SSs1YHzBE7pS1mB9xawcmdpEL6dtVi0tejCJSGV0hXB8OL5sbjg8QR8UA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY2PR01MB4777
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CgrU2iAyMDIyLzcvMjkgMTI6NTQsIERhcnJpY2sgSi4gV29uZyDQtLXAOgo+IE9uIEZyaSwgSnVs
IDI5LCAyMDIyIGF0IDAzOjU1OjI0QU0gKzAwMDAsIHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tIHdy
b3RlOgo+Pgo+Pgo+PiDU2iAyMDIyLzcvMjIgMDoxNiwgRGFycmljayBKLiBXb25nINC0tcA6Cj4+
PiBPbiBUaHUsIEp1bCAyMSwgMjAyMiBhdCAwMjowNjoxMFBNICswMDAwLCBydWFuc3kuZm5zdEBm
dWppdHN1LmNvbSB3cm90ZToKPj4+PiDU2iAyMDIyLzcvMSA4OjMxLCBEYXJyaWNrIEouIFdvbmcg
0LS1wDoKPj4+Pj4gT24gVGh1LCBKdW4gMDksIDIwMjIgYXQgMTA6MzQ6MzVQTSArMDgwMCwgU2hp
eWFuZyBSdWFuIHdyb3RlOgo+Pj4+Pj4gRmFpbHVyZSBub3RpZmljYXRpb24gaXMgbm90IHN1cHBv
cnRlZCBvbiBwYXJ0aXRpb25zLiAgU28sIHdoZW4gd2UgbW91bnQKPj4+Pj4+IGEgcmVmbGluayBl
bmFibGVkIHhmcyBvbiBhIHBhcnRpdGlvbiB3aXRoIGRheCBvcHRpb24sIGxldCBpdCBmYWlsIHdp
dGgKPj4+Pj4+IC1FSU5WQUwgY29kZS4KPj4+Pj4+Cj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBTaGl5
YW5nIFJ1YW4gPHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tPgo+Pj4+Pgo+Pj4+PiBMb29rcyBnb29k
IHRvIG1lLCB0aG91Z2ggSSB0aGluayB0aGlzIHBhdGNoIGFwcGxpZXMgdG8gLi4uIHdoZXJldmVy
IGFsbAo+Pj4+PiB0aG9zZSBybWFwK3JlZmxpbmsrZGF4IHBhdGNoZXMgd2VudC4gIEkgdGhpbmsg
dGhhdCdzIGFrcG0ncyB0cmVlLCByaWdodD8KPj4+Pj4KPj4+Pj4gSWRlYWxseSB0aGlzIHdvdWxk
IGdvIGluIHRocm91Z2ggdGhlcmUgdG8ga2VlcCB0aGUgcGllY2VzIHRvZ2V0aGVyLCBidXQKPj4+
Pj4gSSBkb24ndCBtaW5kIHRvc3NpbmcgdGhpcyBpbiBhdCB0aGUgZW5kIG9mIHRoZSA1LjIwIG1l
cmdlIHdpbmRvdyBpZiBha3BtCj4+Pj4+IGlzIHVud2lsbGluZy4KPj4+Pgo+Pj4+IEJUVywgc2lu
Y2UgdGhlc2UgcGF0Y2hlcyAoZGF4JnJlZmxpbmsmcm1hcCArIFRISVMgKyBwbWVtLXVuYmluZCkg
YXJlCj4+Pj4gd2FpdGluZyB0byBiZSBtZXJnZWQsIGlzIGl0IHRpbWUgdG8gdGhpbmsgYWJvdXQg
InJlbW92aW5nIHRoZQo+Pj4+IGV4cGVyaW1lbnRhbCB0YWciIGFnYWluPyAgOikKPj4+Cj4+PiBJ
dCdzIHByb2JhYmx5IHRpbWUgdG8gdGFrZSB1cCB0aGF0IHF1ZXN0aW9uIGFnYWluLgo+Pj4KPj4+
IFllc3RlcmRheSBJIHRyaWVkIHJ1bm5pbmcgZ2VuZXJpYy80NzAgKGFrYSB0aGUgTUFQX1NZTkMg
dGVzdCkgYW5kIGl0Cj4+PiBkaWRuJ3Qgc3VjY2VlZCBiZWNhdXNlIGl0IHNldHMgdXAgZG1sb2d3
cml0ZXMgYXRvcCBkbXRoaW5wIGF0b3AgcG1lbSwKPj4+IGFuZCBhdCBsZWFzdCBvbmUgb2YgdGhv
c2UgZG0gbGF5ZXJzIG5vIGxvbmdlciBhbGxvd3MgZnNkYXggcGFzcy10aHJvdWdoLAo+Pj4gc28g
WEZTIHNpbGVudGx5IHR1cm5lZCBtb3VudCAtbyBkYXggaW50byAtbyBkYXg9bmV2ZXIuIDooCj4+
Cj4+IEhpIERhcnJpY2ssCj4+Cj4+IEkgdHJpZWQgZ2VuZXJpYy80NzAgYnV0IGl0IGRpZG4ndCBy
dW46Cj4+ICAgICBbbm90IHJ1bl0gQ2Fubm90IHVzZSB0aGluLXBvb2wgZGV2aWNlcyBvbiBEQVgg
Y2FwYWJsZSBibG9jayBkZXZpY2VzLgo+Pgo+PiBEaWQgeW91IG1vZGlmeSB0aGUgX3JlcXVpcmVf
ZG1fdGFyZ2V0KCkgaW4gY29tbW9uL3JjPyAgSSBhZGRlZCB0aGluLXBvb2wKPj4gdG8gbm90IHRv
IGNoZWNrIGRheCBjYXBhYmlsaXR5Ogo+Pgo+PiAgICAgICAgICAgY2FzZSAkdGFyZ2V0IGluCj4+
ICAgICAgICAgICBzdHJpcGV8bGluZWFyfGxvZy13cml0ZXN8dGhpbi1wb29sKSAgIyBhZGQgdGhp
bi1wb29sIGhlcmUKPj4gICAgICAgICAgICAgICAgICAgOzsKPj4KPj4gdGhlbiB0aGUgY2FzZSBm
aW5hbGx5IHJhbiBhbmQgaXQgc2lsZW50bHkgdHVybmVkIG9mZiBkYXggYXMgeW91IHNhaWQuCj4+
Cj4+IEFyZSB0aGUgc3RlcHMgZm9yIHJlcHJvZHVjdGlvbiBjb3JyZWN0PyBJZiBzbywgSSB3aWxs
IGNvbnRpbnVlIHRvCj4+IGludmVzdGlnYXRlIHRoaXMgcHJvYmxlbS4KPiAKPiBBaCwgeWVzLCBJ
IGRpZCBhZGQgdGhpbi1wb29sIHRvIHRoYXQgY2FzZSBzdGF0ZW1lbnQuICBTb3JyeSBJIGZvcmdv
dCB0bwo+IG1lbnRpb24gdGhhdC4gIEkgc3VzcGVjdCB0aGF0IHRoZSByZW1vdmFsIG9mIGRtIHN1
cHBvcnQgZm9yIHBtZW0gaXMKPiBnb2luZyB0byBmb3JjZSB1cyB0byBjb21wbGV0ZWx5IHJlZGVz
aWduIHRoaXMgdGVzdC4gIEkgY2FuJ3QgcmVhbGx5Cj4gdGhpbmsgb2YgaG93LCB0aG91Z2gsIHNp
bmNlIHRoZXJlJ3Mgbm8gZ29vZCB3YXkgdGhhdCBJIGtub3cgb2YgdG8gZ2FpbiBhCj4gcG9pbnQt
aW4tdGltZSBzbmFwc2hvdCBvZiBhIHBtZW0gZGV2aWNlLgoKSGkgRGFycmljaywKCiA+IHJlbW92
YWwgb2YgZG0gc3VwcG9ydCBmb3IgcG1lbQpJIHRoaW5rIGhlcmUgd2UgYXJlIHNheWluZyBhYm91
dCB4ZnN0ZXN0IHdobyByZW1vdmVkIHRoZSBzdXBwb3J0LCBub3QgCmtlcm5lbD8KCkkgZm91bmQg
c29tZSB4ZnN0ZXN0cyBjb21taXRzOgpmYzdiMzkwMzg5NGE2MjEzYzc2NWQ2NGRmOTE4NDdmNDQ2
MDMzNmEyICAjIGNvbW1vbi9yYzogYWRkIHRoZSByZXN0cmljdGlvbi4KZmM1ODcwZGE0ODVhZWMw
ZjkxOTZhMGYyYmVkMzJmNzNmNmIyYzY2NCAgIyBnZW5lcmljLzQ3MDogdXNlIHRoaW4tcG9vbAoK
U28sIHRoaXMgY2FzZSB3YXMgbmV2ZXIgYWJsZSB0byBydW4gc2luY2UgdGhlIHNlY29uZCBjb21t
aXQ/ICAoSSBkaWRuJ3QgCm5vdGljZSB0aGUgbm90IHJ1biBjYXNlLiAgSSB0aG91Z2h0IGl0IHdh
cyBleHBlY3RlZCB0byBiZSBub3QgcnVuLikKCkFuZCBhY2NvcmRpbmcgdG8gdGhlIGZpcnN0IGNv
bW1pdCwgdGhlIHJlc3RyaWN0aW9uIHdhcyBhZGRlZCBiZWNhdXNlIApzb21lIG9mIGRtIGRldmlj
ZXMgZG9uJ3Qgc3VwcG9ydCBkYXguICBTbyBteSB1bmRlcnN0YW5kaW5nIGlzOiB3ZSBzaG91bGQg
CnJlZGVzaWduIHRoZSBjYXNlIHRvIG1ha2UgdGhlIGl0IHdvcmssIGFuZCBmaXJzdGx5LCB3ZSBz
aG91bGQgYWRkIGRheCAKc3VwcG9ydCBmb3IgZG0gZGV2aWNlcyBpbiBrZXJuZWwuCgoKSW4gYWRk
aXRpb24sIGlzIHRoZXJlIGFueSBvdGhlciB0ZXN0Y2FzZSBoYXMgdGhlIHNhbWUgcHJvYmxlbT8g
IHNvIHRoYXQgCndlIGNhbiBkZWFsIHdpdGggdGhlbSB0b2dldGhlci4KCgotLQpUaGFua3MsClJ1
YW4KCgo+IAo+IC0tRAo+IAo+Pgo+PiAtLQo+PiBUaGFua3MsCj4+IFJ1YW4uCj4+Cj4+Cj4+Cj4+
Pgo+Pj4gSSdtIG5vdCBzdXJlIGhvdyB0byBmaXggdGhhdC4uLgo+Pj4KPj4+IC0tRAo+Pj4KPj4+
Pgo+Pj4+IC0tCj4+Pj4gVGhhbmtzLAo+Pj4+IFJ1YW4uCj4+Pj4KPj4+Pj4KPj4+Pj4gUmV2aWV3
ZWQtYnk6IERhcnJpY2sgSi4gV29uZyA8ZGp3b25nQGtlcm5lbC5vcmc+Cj4+Pj4+Cj4+Pj4+IC0t
RAo+Pj4+Pgo+Pj4+Pj4gLS0tCj4+Pj4+PiAgICAgZnMveGZzL3hmc19zdXBlci5jIHwgNiArKysr
LS0KPj4+Pj4+ICAgICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9u
cygtKQo+Pj4+Pj4KPj4+Pj4+IGRpZmYgLS1naXQgYS9mcy94ZnMveGZzX3N1cGVyLmMgYi9mcy94
ZnMveGZzX3N1cGVyLmMKPj4+Pj4+IGluZGV4IDg0OTVlZjA3NmZmYy4uYTNjMjIxODQxZmE2IDEw
MDY0NAo+Pj4+Pj4gLS0tIGEvZnMveGZzL3hmc19zdXBlci5jCj4+Pj4+PiArKysgYi9mcy94ZnMv
eGZzX3N1cGVyLmMKPj4+Pj4+IEBAIC0zNDgsOCArMzQ4LDEwIEBAIHhmc19zZXR1cF9kYXhfYWx3
YXlzKAo+Pj4+Pj4gICAgIAkJZ290byBkaXNhYmxlX2RheDsKPj4+Pj4+ICAgICAJfQo+Pj4+Pj4g
ICAgIAo+Pj4+Pj4gLQlpZiAoeGZzX2hhc19yZWZsaW5rKG1wKSkgewo+Pj4+Pj4gLQkJeGZzX2Fs
ZXJ0KG1wLCAiREFYIGFuZCByZWZsaW5rIGNhbm5vdCBiZSB1c2VkIHRvZ2V0aGVyISIpOwo+Pj4+
Pj4gKwlpZiAoeGZzX2hhc19yZWZsaW5rKG1wKSAmJgo+Pj4+Pj4gKwkgICAgYmRldl9pc19wYXJ0
aXRpb24obXAtPm1fZGRldl90YXJncC0+YnRfYmRldikpIHsKPj4+Pj4+ICsJCXhmc19hbGVydCht
cCwKPj4+Pj4+ICsJCQkiREFYIGFuZCByZWZsaW5rIGNhbm5vdCB3b3JrIHdpdGggbXVsdGktcGFy
dGl0aW9ucyEiKTsKPj4+Pj4+ICAgICAJCXJldHVybiAtRUlOVkFMOwo+Pj4+Pj4gICAgIAl9Cj4+
Pj4+PiAgICAgCj4+Pj4+PiAtLSAKPj4+Pj4+IDIuMzYuMQo+Pj4+Pj4KPj4+Pj4+Cj4+Pj4+Pgo=
