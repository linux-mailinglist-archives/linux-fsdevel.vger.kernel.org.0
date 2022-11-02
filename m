Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D4D3615FB1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Nov 2022 10:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230190AbiKBJ26 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 2 Nov 2022 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230292AbiKBJ2p (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:28:45 -0400
Received: from esa2.hgst.iphmx.com (esa2.hgst.iphmx.com [68.232.143.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752CFE12
        for <linux-fsdevel@vger.kernel.org>; Wed,  2 Nov 2022 02:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1667381324; x=1698917324;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=aO4+E/7zzrAE3FLtcID8sKgH7tTEd8cKnHbHDxS57CA=;
  b=l8YoOBEcRlZeCeiGBqBLjkzFh5v1/NN1uCYijd1YRUCvRDBkTXqEVZEc
   AYDy7eH01OB28/eMJZ1cggK860+GrZXYDuOUF7ONwv80fFDpym9/AKuMs
   MJMPvUNPlPgusEjGnd2l5hy1TaRoBmYWaTnqKE3Pgm2yY4/k7LNCn6iW5
   n4qUK5P886nEPO5GMmHmWcOvyimrvgE2zTT8iTNy7CmAbdhxsJ/PySNfy
   eRK7OLC8UszJkSScRmYLn1kmmB/FVnV+kNf0EX9/NgmdWmQ8c53ZKzi/Z
   LI5FapJJBbuAyJ5E5bLWZBPjIpq5sD5XHfoCgkSvV8zAVa8bcYJs3i8j1
   g==;
X-IronPort-AV: E=Sophos;i="5.95,232,1661788800"; 
   d="scan'208";a="319633116"
Received: from mail-mw2nam12lp2045.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.45])
  by ob1.hgst.iphmx.com with ESMTP; 02 Nov 2022 17:28:43 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BRqgnZ0jkuiE9lPZMRelTx2AGfdGy/s7mPmZHggMVHgz2BMCMYvJRnY3MGOumq35gRm1BrMbiMC6Qig77S1CFAwEplgjy3xIY1qYGjrgYNp6XdQXJyYVOHxEKiAhfhnSZdA+EXc9VO82fPtlMPei3Vc8yNf3AyjAEZggFWgKHO0+UiNJj+F9CdNkwYcHge7qAXbd+27+tk1wFkiUfEIHn01ss5HAATRupwbzPmMxLYKlKy9DStHW787rcBxXuTu48Pr9IhlszPvxfJEfxktP1XZs4oFMzmg9qeBVZwHCzhstevIFtZhKvJP9Zs7SaLbW/1S/I83OFn4JTlknJdYNpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aO4+E/7zzrAE3FLtcID8sKgH7tTEd8cKnHbHDxS57CA=;
 b=lx6VGu/EXt2bjwkGTelcvivh0Q5UXjb3tl3SYSRTJfIoFs6sjJwb/y7CT28gWh/m/dPi82/dbs4nYc42EZGLIdQ/VEpmQJQ/x0I5+4sxtbnxjf6JU4e3Xo36JUPIEUXbbzeiITp9Mab+5Z6Dhb7AUf10pD61m1ZZDdvcYbEKbTuGd5FXGPREN9kMG5RtypZNBUEITsfVQKIzoN2ukiBqjIxKXVGHxkg8/fgnuFtjSpDyKG/L0UjqneN4TPr61fN7+3YOpnhY+css60qw2h5HICpCoJDkFiEoErrvJQ2Ee/NI9zcntSHHNQB4yxlrCxu8nXTL/lfXj4OtE2IZC1CMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aO4+E/7zzrAE3FLtcID8sKgH7tTEd8cKnHbHDxS57CA=;
 b=mGcfC5YO+Tai8Y+N2ypOVFb82HbShA6UdpzQfkirTqZeU3YdLLfaFwHj2kZpaBnGrYJDC0MTFg5+DoJ1/APlQt2yWHcm5jY4AoF/5l+TJd7EKYD4U5WCj2ZP6MXtcNuQpbpn3Ey4y6ikbx6EsH3yKJcWjlWn+UVJu4qmwarJZGc=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by BN7PR04MB3825.namprd04.prod.outlook.com (2603:10b6:406:cb::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5769.18; Wed, 2 Nov
 2022 09:28:41 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::88ea:acd8:d928:b496%5]) with mapi id 15.20.5791.022; Wed, 2 Nov 2022
 09:28:41 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH 1/2] zonefs: fix zone report size in __zonefs_io_error()
Thread-Topic: [PATCH 1/2] zonefs: fix zone report size in __zonefs_io_error()
Thread-Index: AQHY7NTqjMvk9blmSU+DEr/P9bSgwa4rYVOA
Date:   Wed, 2 Nov 2022 09:28:41 +0000
Message-ID: <959eb68a-3c74-3b57-dd81-8b46dfa341d9@wdc.com>
References: <20221031030007.468313-1-damien.lemoal@opensource.wdc.com>
 <20221031030007.468313-2-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221031030007.468313-2-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|BN7PR04MB3825:EE_
x-ms-office365-filtering-correlation-id: 56334f7b-9f31-4ad1-710a-08dabcb4a16f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: XUdAryIHiJw7GiGglA7OThnUnuk0GGhPFrbEb9tSHOv5DffByJVCh+xlcsxe+JqW+lct2CELHD6rnxb7U1XO2LhSUqYdFO1bXcqjR6Zk3E1CAsP6RaWhAyH7CJovGKDiyEXVV3Ai6TxTap8We3xR4E3uRdjSGRJu0/xi42FgYPssDwU3Ik4Jkjnq1yBjVomhVaYWhrBPN/UW9gnEt6FbCE/lNa/mClgv4JsX1sp1JR+8A8pbyq1ukKovu7U386sXnyRQvf/sUFhgosi2+fKIPLkqfeS7kkKmXTLlcXuMldEeQCvYsb/pDv2CD3mn1skpfNlkyP5kcbI6pnWiF4v1ivzhYEzXsBUir/SNFMgkcdY8plf/vpNef5qkzSiCPGyU8sJ0saC10tcGeHoYROCQ5T+Tcw/Yc3oniv2kmyptYOV7aI5IV/R3jcpEqMHsu1NBS+b7tGpTElyP7I9VY3JVHxmozjermlkd2x4HTFi/du6d/UOCWhVy7UJhMMsQrznsVkO+V89Djtr+8lr0UrtJEXGQCdoTmvLl43MbL0zRmaCTn6cG/q4HPEYhGUVJBr1dwjo31O8G8op48qMbhPRAz0WlcG0sbRdMJ4VLbtSMjL1KyUNKMjOuXjN1gOeoUbWt0LNNpfwFmYxnJ6HYgApqXR4XDNs3YxIhP2qdR7meQ637oeSGfXDozK1d6nzw3HOxVnGtHRWKzCYIDewVfyvj0HFqzMERzBAA7Q6+zLpycUiMSITUxc8ZJatkQHwFyGNTo6US28o3cQtihDCMs00PuWywo0ayuJurERWOIrKfIXwQ6HPcqKcrthuZHmh4FVcUFxGn75Rcsg2P7ES1Fjh3KQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(39860400002)(136003)(346002)(376002)(366004)(451199015)(66446008)(31686004)(31696002)(186003)(36756003)(8936002)(4744005)(64756008)(38100700002)(38070700005)(2906002)(5660300002)(110136005)(316002)(41300700001)(2616005)(6512007)(6506007)(122000001)(86362001)(82960400001)(478600001)(91956017)(71200400001)(53546011)(66946007)(66476007)(66556008)(6486002)(76116006)(8676002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zk4vK2w4ZDZQYndJMm9Hb3VHQlpMSXZPT01TV013MEVLc1dCYzNaRE9mRHZ2?=
 =?utf-8?B?ak5RWTJVSmo4c0JZRXZiYjBEYk0wNVBlck5XNW1vS3lzc29talJ6RlEzZXRm?=
 =?utf-8?B?cDNmR3JhMzEzTFZzMXR1STY5bVdPT2ZHSk9aY1puNjdnMlI1M2o5VFJhWWwz?=
 =?utf-8?B?T2FVaVEzVmJIS1ExOHpnTkJKRmZCaU9BQlRKVWYwaXJrdG1CcCt3M091WEly?=
 =?utf-8?B?RzM4TG5IL053eUVqNU9EamV1ZVNrcUpVSWN6Q1hKRkMzSnQzL1R0TTA5Qnpl?=
 =?utf-8?B?cFIzVXAweHdIblZvK29hL2lET3RjZHRQUVZUY0N1cG5zKyszdXM3UEw5NFdR?=
 =?utf-8?B?UkdKMTdmaGZBNmpObW5Kd1Zac3lLd2p2RTNseThqWlJ5dmdFdVZheG00WlNT?=
 =?utf-8?B?TEI4NjdsbXhoRHpNMThodkFQRFNkRTZYMnpUdVduY241K0hSYnNZaWhiNTR2?=
 =?utf-8?B?c3VBdG9PSUM0bVZYOWNHWlByY0tBTEszWHNkbU1IMUg2M1dOR1hvYW5SMDF0?=
 =?utf-8?B?c0pzcVhmdFh0clJLVkhXWEc0dS9rRENxZit4T1JSblB5QW5INit0NDJucy9v?=
 =?utf-8?B?WkxseUZuYXcwa3RzRS9Pa1Z2UkpNTHkvaE44eGpkQXAzWVpNbG9lYVNDcUND?=
 =?utf-8?B?SFFIRnNTL0VCa1o1bUtkamdaMVpCRTZiRFozR0ovTXhPaGsyQVB1WnFvMkhl?=
 =?utf-8?B?bWNjUDlIeVdxTmk0d3N0UmZKSVA3d0s3V0IrNlIzekdpcHhhWWE2SUx1TFNq?=
 =?utf-8?B?N0NvSjU3V00zTnY4WUZqaUxJblBxWjJLWmJXTXpaUHFmYXY4TXlPOGtGcXlX?=
 =?utf-8?B?RDhPS1AvbmJuckNtcFRVcEV5bW1JV01vczROL1BLellJbjhvZVNEeGZaZ1Ba?=
 =?utf-8?B?bzMySnpXTzI2OER6Ty84YzZJMHp5YjlTb1dLRDBzMmR5aHRyMkVHb3VEZThl?=
 =?utf-8?B?S0dQR0J0YXhBM3RrT3NmcVltVTY0OGI1N0dLSlhrL1J0S3A1blRTSmxEV2RY?=
 =?utf-8?B?RkJiLzZjcXlFZWNKeGtGQllmV25Fd2NyaTBTSHZsc0VyRVdUb3h4T3FNcnh0?=
 =?utf-8?B?UWw2OU13L3BEQ2JUeU1lZnRLUTFIaDJCcnhHdTg3ek9TTWgwUzkwUHc1TVlw?=
 =?utf-8?B?Wlh5L1FpVDhhR1ZSTVI1TkdIdDduaFhwUEN0MXBmTjk0Ym1EdVRqUWVoaHR5?=
 =?utf-8?B?LzdZTjJsVFlSRXdkeHMvY3JGZGNlUGFQNTBVOGRVUGd3V2JObGxzNWpXQVN2?=
 =?utf-8?B?R3Z3Q0NlVm1DVGUvZXZ4OWU5c1pSTFJkMFhjRWhsWE9qZU9HMGtGNDhTeTZk?=
 =?utf-8?B?YkZxaCtDTUIrNk9pL1UrbUtYUWVTQVJVR0VlbVJvUVI0bm5FNFpROThiZmlt?=
 =?utf-8?B?TFM3MWNuYVFMVTdMNDlKUWxyRERaUk5tR1B3K2VzQkNLTzFxNHRUS25SMVJM?=
 =?utf-8?B?UGNPSUhTT3N3RjVEcHg4L1d6alpoNTI5RStOSmtQcnBsZi9YNHVTNUtHS1Z3?=
 =?utf-8?B?bDZ1aHVQUXNXRStEMmpqdUxLZHdrNmxjeGkvVzVXWFhpMVNZeHhSdXNKQ3Mv?=
 =?utf-8?B?LzkzNUIzYWZic0dlS1k4Unp3TWJ4ODZSbnE4WGQvTlRkTUhGb2tjUVhaKytU?=
 =?utf-8?B?ZFluVEJoc3RzQ0JSTG4yNzVxWVlHYm1rM1FDZE5JTjlCeHl4VjVDTEwyRnBH?=
 =?utf-8?B?L3YxVnoyaEdSYmd3MnNCc1BEcndtL2ZCQmpCcGRSNmxlODVPWll3UUpZUHNJ?=
 =?utf-8?B?RXpJZXBKWUFVb3lzNGFwc2tRbEhObVN4YlhCS2dIbnBuK2IzczRxM0xzQVNz?=
 =?utf-8?B?V0xBSm1YVXhlZ3dCVGo5UVAxRjZ4UTlVMzVOMCsvbUxKSG1aWURrOS9CZ2dY?=
 =?utf-8?B?NTFkTTYya0VOUnVNZUZOb25QaGxwRXB5L3pGU3JCMDVIZ3prWnlQYmcxcjZr?=
 =?utf-8?B?UnVlY2wrM3JDcXJFWjloS2FNMGVWajVqTkl1OHZsT1VNWFRScVNtYjZCZUN4?=
 =?utf-8?B?Q1Z6OE1vVHZBbC9tTCtpWGJTMDViMHZqL3V1N3VXWldQM2NlWnBUQnhTTTJp?=
 =?utf-8?B?dmQ2a0RVN0xtdGZlL2dFT1IybCtGc3BCZVE3MDk2bHlSUHRGQkhZUTBxOHpN?=
 =?utf-8?B?RVRFWXJDeHBVdmd2NExZM0MzVDV2U2Rrei9WSG9rRXR1WExESllNMG52ankx?=
 =?utf-8?B?WXlCdXViNnpFSmZpclZWOTFXSVUyZUNtS3VIQUoyVHpvVlBPSWpqZkZYWWJi?=
 =?utf-8?Q?ew+O64uxzHm4KsKata4ZNIbCGrpiqSVs4h2YFy0HsM=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E4ADAEC3CB6B75419DD1A49B27F1F862@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 56334f7b-9f31-4ad1-710a-08dabcb4a16f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Nov 2022 09:28:41.4604
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kH4TlqHFba+O+7cOmtNaVwKaadCjlz25HhAxVEczGynLgrW9mXXPhfjSwT+h/Z8ZrKmkhJ2CNhO0lSIXa3Svc+InFcHr7gW9OK25XCQXc4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR04MB3825
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMzEuMTAuMjIgMDQ6MDAsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPiArCS8qDQo+ICsJICog
VGhlIG9ubHkgZmlsZXMgdGhhdCBoYXZlIG1vcmUgdGhhbiBvbmUgem9uZSBhcmUgY29udmVudGlv
bmFsIHpvbmUNCj4gKwkgKiBmaWxlcyB3aXRoIGFnZ3JlZ2F0ZWQgY29udmVudGlvbmFsIHpvbmVz
LCBmb3Igd2hpY2ggdGhlIGlub2RlIHpvbmUNCj4gKwkgKiBzaXplIGlzIGFsd2F5cyBsYXJnZXIg
dGhhbiB0aGUgZGV2aWNlIHpvbmUgc2l6ZS4NCj4gKwkgKi8NCj4gKwlpZiAoemktPmlfem9uZV9z
aXplID4gYmRldl96b25lX3NlY3RvcnMoc2ItPnNfYmRldikpDQo+ICsJCW5yX3pvbmVzID0gemkt
Pmlfem9uZV9zaXplID4+DQo+ICsJCQkoc2JpLT5zX3pvbmVfc2VjdG9yc19zaGlmdCArIFNFQ1RP
Ul9TSElGVCk7DQo+ICsNCg0KSSB3b25kZXIgaWYgd2Ugc2hvdWxkIGFsc28gaGF2ZSBhIGNoZWNr
L2Fzc2VydGlvbiBsaWtlIHRoaXMgc29tZXdoZXJlOiANCldBUk5fT05fT05DRSh6aS0+aV96b25l
X3NpemUgPiBiZGV2X3pvbmVfc2VjdG9ycyhzYi0+c2JkZXYpICYmIA0KCSFzYmktPnNfZmVhdHVy
ZXMgJiBaT05FRlNfRl9BR0dSQ05WKQ0KCQ0K
