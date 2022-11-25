Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88D96384DD
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Nov 2022 09:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbiKYIAF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Nov 2022 03:00:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbiKYIAD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Nov 2022 03:00:03 -0500
Received: from esa1.hgst.iphmx.com (esa1.hgst.iphmx.com [68.232.141.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FED12FC34
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Nov 2022 00:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1669363201; x=1700899201;
  h=from:to:subject:date:message-id:references:in-reply-to:
   content-id:content-transfer-encoding:mime-version;
  bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
  b=lPwNyY3OIiFqJImbR1ej+wCOO6gGkhzrXZKpSrwhvbxj4j3VCddFFbTk
   67r+FRFljkDg1gaLaZ2wXeP4WhY4iYzuaOwHKYJIZnk/Fx+0AY2oNFLB+
   7vIyAoDQFUKitXtO1SMQHQOB03oPzlLw71Pi4D/VFkwVrkv6uQBTN1sqU
   2hexS1wqcAChefM2dj6LQ7fJVVQkSvIPmrzVPwJUnVBonJc/6xo6WvlYz
   ersCGMiHGKNvQsBLy+p1wyycuEJ6GjEYYvYZwGlDqEdq7TV53zoibpQsu
   lDnPcn89ehohrLGuxbaLFbeJ0JpU6XqFQrI1hOZe2/G6v7GGtHr8KcG3D
   w==;
X-IronPort-AV: E=Sophos;i="5.96,192,1665417600"; 
   d="scan'208";a="329254704"
Received: from mail-dm3nam02lp2043.outbound.protection.outlook.com (HELO NAM02-DM3-obe.outbound.protection.outlook.com) ([104.47.56.43])
  by ob1.hgst.iphmx.com with ESMTP; 25 Nov 2022 16:00:01 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwqvi2pHCar7UK7FJs/o86XGCixVkrBCHZ1WKJ1NtXsnxAyhDT13Ot8rIfQfOE0VTZUzODuY8eMv1E1VqQS/MK9jhbbkrwDMEp6ni7m0J85UWZ/J2Cn1r3rY7RijTEKw/b9rOrdpbwTnt8ib7xMtLED3id/eBrMj8OO7/QWO8rxpS/h+SsEC9bmgccCQp/6b9SvLEvCAnMm4K/lr+G5bNAH18O+VwnItO5DAdGaIJulKwEqzfu7jG6FdW/qTTg5ln7fiunEfFTae2FPjpntOxklwjQw4Hgbmb8lOzZmevBIJ7ydnWqnqOUK51KeCvO+/RD2R4u401QR2bRRcWvGpwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=IfgjbkuWZ9+8GWKmrUmsTGXxOp4QIsszMQL4Qp8UKyDvyuyOz51LTpemqyp2BtkrGyB0MbXGINIxeVPQkt9tkZV5T1+J/cM5XVO+uemnTmG3C4CxhXeAcBcwrYgl3FlhN2Juv9iU4PfKS7IHFmrrelvWWAnC2zj6YIBt/AyCJMtLeEX/aBkqggVh6CLlVje5WaGBUXz3GnA1DFBXY9INPSEk2+My6rIxb63kCLZi0gnROWI9IndI3xEOEyJ3T2XoguKBa5pE0uxlO4hA9xcRDcp6agpCwI6RB8APFx+tP1dRDl5FjivqO3gKhM6rBZJn3QBFaDqJPN/VP0TKnRAwFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=joufdrNO2/FLdgGzlnaieoHfZ28FYCwNXGhrZ08f24E=;
 b=PIr7RwuJDwlPog8UitW6xwqEGr8C96Hl+DSRHoLoNZIDlTOK+S0jXi4yGwSAvB9y0zpNEI1XJ6lFj1nNCzLBdwixSKuEM5L7UrZmLvP/ERaVrtSnc6m41HVV/4urPm/TbqEdUwsgShR19P85f3Gxc5iJSmwbXB6LFcnEe5rCPlA=
Received: from PH0PR04MB7416.namprd04.prod.outlook.com (2603:10b6:510:12::17)
 by DM6PR04MB4171.namprd04.prod.outlook.com (2603:10b6:5:95::29) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5813.17; Fri, 25 Nov
 2022 07:59:59 +0000
Received: from PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a]) by PH0PR04MB7416.namprd04.prod.outlook.com
 ([fe80::f4cd:7c80:5642:bf1a%8]) with mapi id 15.20.5857.019; Fri, 25 Nov 2022
 07:59:59 +0000
From:   Johannes Thumshirn <Johannes.Thumshirn@wdc.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH] zonefs: Fix active zone accounting
Thread-Topic: [PATCH] zonefs: Fix active zone accounting
Thread-Index: AQHY/67eEoD4ed61CUK8+6Bpc0P1Ja5PSHUA
Date:   Fri, 25 Nov 2022 07:59:59 +0000
Message-ID: <fe670155-ac77-5d9c-107c-58ee8d09af26@wdc.com>
References: <20221124024545.243036-1-damien.lemoal@opensource.wdc.com>
In-Reply-To: <20221124024545.243036-1-damien.lemoal@opensource.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH0PR04MB7416:EE_|DM6PR04MB4171:EE_
x-ms-office365-filtering-correlation-id: 9f27f591-6f16-4812-e66d-08dacebb0c8f
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /zvbfX07I6XxBkAxwOUzKnQQBHJOWXdDLqH7m8KGjl+LUdnbQu7NMv2DxpyLnfOGYEAYHQdZYJTt4MBrlOMc40xz8LfRfo2lVbLaccYJdufjI0tH8pa1dw03BPPc0irAZbG6Z/4EKXiAUV3ehg4OGnNRH0yIBiRClXGWD0j/A3XDxK2J+r+VyBXQh8Dm3k5QDHjBidzZOHdHSb4bO9uRCmkqfECMxhz0z5FUn5kNdDo4HrS1KUmbu4cbdNcUS5jBg1JO0ckzTI3qaPhL/i5q0hAAnFHOqgMP6XglMnNegSmRlxPhg6b79bBh7zxUgdkzYqOHY+U1mMeOXKKQfj3l8U1R7o28J94VgsLJSlPi/DlHhWg0k1UokUBEYJeqTrB46z0kSxiKNtZKQaIS947UmyKHrQzwlwb6cSd8egGVE22CPqjBxK+9dCyFpz+lJimrEKerqV2+zCHLFUTYjCM3wuupBVh5YX83910Ej+t+ajzlxH+P5FXzAghu6+irqmt4XtTSmPaDR7793MBDPh+JMLkpgPYQp27bWWwEld8IDjcnKe5CKcanvl/PWlZm7cs7HX0QzWtZ1HrfLRIWlhLYoKb0fzuO4MUWx8muVraKMRJ/qbv2mNemcscYybM7hxaJdPR+oWightMFIitSwDBLrDt6s8ekqOyZXO4S8jWoxk7dhP43+5iBCIcJgMR+Jo2OdipFxJL2mYwHJHT9m1mknIobOw7QXkLY/dgtefcGNnKTruDtyNN7O/uq84e1bJXV+1yNJWt2biUguzgZjaRyTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR04MB7416.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(136003)(346002)(366004)(376002)(451199015)(558084003)(6506007)(6486002)(71200400001)(36756003)(41300700001)(122000001)(2616005)(186003)(19618925003)(2906002)(8936002)(5660300002)(316002)(110136005)(31696002)(6512007)(76116006)(86362001)(66946007)(4270600006)(66556008)(64756008)(82960400001)(38070700005)(91956017)(8676002)(66476007)(31686004)(38100700002)(66446008)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?K0FRaUoyQ3VlVWdnK3ZiVW96QXJlQk5uWUJtMHVBb21HSmZyMmRKeHJlWkRy?=
 =?utf-8?B?OFc4V0s1MWlBVk4rckdzRlBLOVQycmNQMWhOWjE5M3hQZFNPVWlIU2o2aXJI?=
 =?utf-8?B?ZE16OGZ2TUg1UlMrbVFVYUgreDIvY2piMEs1UDBQSnlPNTA4V2dDczZydlZV?=
 =?utf-8?B?QlhEekVRTHlDZDc5T09IaXhwSytXMXowdFMwSXpwdFllVytPYVR0Z0pXNFUz?=
 =?utf-8?B?alZMSWQvOC9GNjZDVmcvSzRKUk5hN1hzb1FCRkQ3VUIzTzVYMEZ1MmdUcGFS?=
 =?utf-8?B?cDVBL3Z0RnlUQTMvZkpEMWxnc1I4YU0wbDBMeGZVN20xeGdkUjV3RmpiK0tR?=
 =?utf-8?B?LzVGRXFtNzFBdFBIWGt5M2lIS3lCTVZxd3ZQRGduaTI0M0lGeHNxK2htUXFS?=
 =?utf-8?B?UzhBNExuNEl5VXVvY2ZQTXAvNGI0SWpUUVR3T045ekdOaTRKQ2R0WWFDNytF?=
 =?utf-8?B?SXNkOUV3bEY0V2N6NXk0dkludHNKTEZFc2crU1FOellpaTRGckFZS05PQkQ0?=
 =?utf-8?B?LzhxY2t1eWV1TUhEemVqbE0raWR1b3ZUM1NraFhoN2lHTENtM2ZlTXZyd3M5?=
 =?utf-8?B?OGcrOHpHbVJub2U5YW52T24rSExrclRVRCt0eUZPbmE5Z0JHU1lQQkpHUUVk?=
 =?utf-8?B?SXRLVG13TUJBTURMbW1UdmFWOGNyRFNBZUErelVGWjJWajBTanNrbnJEbXR4?=
 =?utf-8?B?blNDSjV3eHRQV0JIdkQvVWR4OHVXaXVpTmU4YWEySlkyaWVKZnZjdGFpMkRD?=
 =?utf-8?B?RkFqVmNzQWtUSU10WnFmMzNRbE9aUDlTZ3VwSGo5TnRSM2Y1RnBIdEpYM2Fx?=
 =?utf-8?B?Ly8wMmw2SkE2MlJzUkRRaGdGN3hJVFc2aVJSK0twWnl2N2UxTEtpRmJMWXNl?=
 =?utf-8?B?TXVtRjJPREdQZVRsby9rNHZyUGRlQmR5dDhOMnpFaW5LVSswM2tyL3Q5Z1dv?=
 =?utf-8?B?clFjaGtpaStta05La01EVHpadUFVZERYNEpEdkVUdk0xNHBNcWR5QWRLWGlT?=
 =?utf-8?B?ZXI3aW5HUjd2RWl0Q2RVMnk4Q2tURlF0RkFJbTQzRHNMVFFrSkMwSzRJVStj?=
 =?utf-8?B?VUVpbjZTekdjelFWWmYwbmNLdDBjdHZTNVNqU09QdjdSV0d0Z2pKM0JXVEpL?=
 =?utf-8?B?b0VVRGlOL3ZEbGxMNGgzbU9sY1p4RC82MmlzekJLWUEyei9LVDhQdWZqSGNa?=
 =?utf-8?B?ZmRjVmw1UmVQNDFCOTNMTW5JSkNiSDJyT0MxQW5jZXVINWZoSzkrdFVKUTIz?=
 =?utf-8?B?eStTZ2ZPSzF2ZDFDZTlUb21HbXBQR0tNNUxvbjN4UFZvaTJ4WGE2MmpQbkJU?=
 =?utf-8?B?ZUd5dG5jdmlYNFlMNkR0WmE1b25pckw4ZW5rbVd0MWhENUdxUW9SMHhwV0tY?=
 =?utf-8?B?dGY4alprNWlsZWhndHNOU2oxSmljdlRoNEMrR2NCUkhVOGdndmRXangwUlAz?=
 =?utf-8?B?V0dRaVRObmxaaXpwM0U4T0I0V1RrYXJlQ2pHVWpjNk9aMEtXSUh1a3phK2xR?=
 =?utf-8?B?bGlTZkd5QTFVNmQvT0EzNlQvV2JTenJ1QXBNdHVzd05IYXFMZzVpTk5OTk4r?=
 =?utf-8?B?V0JidHJSNHltM0NCQnhCSDV1aXpadlhiQVM4OE5lVUNVVUFQZEcxWjNTLzVX?=
 =?utf-8?B?akUwS3BDN1Q4dlRzbE8yMWU4K2ZzdTE5c1U0RW56ei9mZFdEalZBOFdDaVJj?=
 =?utf-8?B?WEpZNjJ5bGRyWmhjbWZBbWZBWFpxYzZlUDY0T0s1ZGpSUDdPbnliUld4QzBL?=
 =?utf-8?B?QjZpYmhoc2hVbktyRTJuOVVxQlhsV3ZNQTl0c3hmaGtDMkhxc2tTZzR1VlhV?=
 =?utf-8?B?UnNvclA3QkN2MFR6UmRYUExxUllvWUVpUEZMUmJPaDdVWUNlZVNLdnBSVm1Y?=
 =?utf-8?B?SXI1NzR6WWtsZDNvZ3lMUTM0YXpqbXZhUzJ5MzU0b0dJUkRTUE9pTG9pc1N4?=
 =?utf-8?B?aUdMTSsxekJ4NlN2eVdERTk5eVlIV3FnN0xlanpiOTNxbUIzeVRRNGlMeUFY?=
 =?utf-8?B?UDFMMWZMMTFoQUlCR3RyOEw1U2JPZ0doVnR2RjNYM3FWYUI4ZzBKWTFXNjFC?=
 =?utf-8?B?dERPaFFyRjYyWHRKQldGMnFtT1paSE8wblJMcTd3L0tJNjdOc1NVWjZKWHdp?=
 =?utf-8?B?T0RKaHFpTTdITVFYSkdINXNjelpNSjJYNmRWdDdZcGhKSFJORDZYblR6UGxh?=
 =?utf-8?B?SFl4ZER0RFQ3YWVwNjlRYTVUSms0MUYvN256K1U3TDdRNWMxN00rRTRSSGg5?=
 =?utf-8?Q?C5LYR34vguJIJ68R0UA4pZw1NfDj3nV8pCXYfy7lPw=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <316BE1C10028FD43A429EC2FE964ADC2@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: K5Spr3UeJgxDO37btxm9+D3JzqOeXi5qzat2bOEtOaUe0elo/AkgCzAtFutrEodfY53dtgTM59MXs2mpL8mLUIr42YW45DRVLcUewAT6PP2j7eu7XBwBLqSXkXYnbZ+9OI+90raKznQHwU1e/CbK/36nuytbzgtyGNlBMXV2QqDA/0LQdW+AJDLbq4P+xef+CLQZZM6AycTWs0q9xIe1pzHgnG4qDTylRQDULXQ3S+0Gm2orWu3t0n+TXPRo7BSf9Wq8JSjEFaJ5iESRCLngMpv9DDDgv9777HSrwztPgewdcTZi7iJRY1ItkKXza0E1EuvbAH7F64oxNj69hgn+IlBQJWDDbZz9SOOUJ/hHbS7O83NS2vPU3cmsJj2lRnGtU4fMMWWA2CYDjRDQj89TqzoCnD9klNbx6Vm024hNgzI5uJjT9ngU4yTZd+jZMGx9XQS5TZkzeZ5hgJe+0GIENVIeFJgXdpEgjHsPOpDFn57lyg8TN438R1StPNsMIYHTykON+KcvSkSJztSqx8BmoUZ3ETFTIWDQkarm4uK6kgshZcId9ua+GJhrHe9AcMMHCgFwPlEP93LmLtRXD5sW8ouVPkesP59i1gF6L+cAsrC6DFxF9FMxkjgSxbckT7k9FBvyLfQVGGpzPET2zVFXYVRskQLQgH+A1TkqNCExkERbZm7Q45vaJh691y0ROzPtA/7cn4CvnLne5Pzbf4etmH4YrZ97QpBjBMwzFAp80zxxJvS7k7SE9cTE60ME4cKNG92Won34h8XSKkIjeNqgKBeLxuyd/R+Q8IT5Z7maSs8=
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR04MB7416.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f27f591-6f16-4812-e66d-08dacebb0c8f
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2022 07:59:59.0841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fIogHvDWky1h+VzyRM0PKttF1TbGVbAc7jf3mw8O585m6cmD0STs+zrRnGZFRu1ZzaReRarGXdrJY5PJVxrKSMkTxhwiv3tB2NNcajC7qEg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR04MB4171
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

TG9va3MgZ29vZCwNClJldmlld2VkLWJ5OiBKb2hhbm5lcyBUaHVtc2hpcm4gPGpvaGFubmVzLnRo
dW1zaGlybkB3ZGMuY29tPg0K
