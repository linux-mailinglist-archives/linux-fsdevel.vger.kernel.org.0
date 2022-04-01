Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28F7F4EE811
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 08:12:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245299AbiDAGNq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 02:13:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiDAGNq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 02:13:46 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A06BC6E4E5;
        Thu, 31 Mar 2022 23:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648793516; x=1680329516;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=W2Jsp8XVshMeTCn+ATsIJ1CGJTJnVhR+kWL0bQ/UBtw=;
  b=o3Up+mgQM0UrjYBfx3f5x/9Qf5Ci+OOg5CfyPWyeQmj8dSuNeIf+2+P2
   kDEZSfTB3KGFy099382EUoQrUnYGfxM3j6nVA5RTbS1MbZif3551B8J0T
   uUtJ0z6W7X6waIyCNuEBMbsRyKQDtrJspHg3AGt0oFehvkPMD/+at3wXF
   tCBbi45BXVrPykxeDDgdPXVcDdioz0lVNT+9hK66okRiqczMeFRn9qpRk
   UGFHejOYhW3PDbgPBSL+Lyi3VW4BxURVf1/BAjn5HmzllLbNqJmCpNhy1
   xgXJPqIHMy9AAPnu0R3Uzs3ECcqSZhALXLWAX+yIlD2+JkpKrnW/AfGXZ
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="52702397"
X-IronPort-AV: E=Sophos;i="5.90,226,1643641200"; 
   d="scan'208";a="52702397"
Received: from mail-tycjpn01lp2171.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.171])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 15:11:52 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oCYXHjDs3CBKdpJD0Oyjn1f13arZyxt9G9FE5lvcIQgSJeCsmmcb6K4Rfd3oTR+nBoo4nBvYXb+Lblyo/VMCHjLL0nBoj9xF8LjyHqjELAfRrCBkhXjJptPrWLTnft1QLmp+LEYQTJTeYmPPXWDzAFjKsDr1be8NOFViVN6a/f2j/kd0DiWoPVHRaCJ0zrW/odTX/aDemUBeZutriGNoIYKIDExxhQr3LQYsjxxXu+ZVeAX9uAFXUF7EPk+G3pGAAAF7x3Jkwvj49mAvESemt3uuGcuj8dpcEpLefwOVVwUhG9TRzx4L46A+uBCjJ7rf1yc8HEZHzZQxbJBg7D7CkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W2Jsp8XVshMeTCn+ATsIJ1CGJTJnVhR+kWL0bQ/UBtw=;
 b=eShqsyk2g/DIiBtbTs+PWeHy0nMG8YcjbQyidYlEQ+YcDJZFoF6jrfDvLk+qfGqG2iQ/dioAnbaGIJIUbbQVsOxpfPONQL57wIuwGVEHSxvNoDr5d050dhrrMaJtmyyK+u6bqWG6SGHu2vyODuvVbNa9OVAE18e1sT4+lvcfPePSN9X0dfgk3a8SVmQt1Q78QQvu2F1lxaxmEWhXL6+Y8YuQ3ht1sV4rvLbkQWYurOUpfraKxj0ZJhx/KGiVhxL8xCozaehA3zI2OpQFn1qsry/70ldJGLo/XOCe0nueXhGIsSvuSjCuZ55567AkbUPN8Sg37RC3s8rrRHuALYB2CA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W2Jsp8XVshMeTCn+ATsIJ1CGJTJnVhR+kWL0bQ/UBtw=;
 b=cicO5h1IoskONOCpP6QB0j3INvDY0aZ37mkTyjEJhHDc92m/pndW2CYE8MByOxIkmUx7rdNqlg4C8oUArBt3CPw/dlVlYnOkInHqcaXXIeV565jkeNBXJj+cemB37TvCb0Zf6TYs6M5n8qUsQJo+f+vhFgSTn2jkjGj7ezi/UaI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYCPR01MB6672.jpnprd01.prod.outlook.com (2603:1096:400:9d::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.25; Fri, 1 Apr
 2022 06:11:49 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.023; Fri, 1 Apr 2022
 06:11:49 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Topic: [PATCH v1 1/2] idmapped-mounts: Add mknodat operation in setgid
 test
Thread-Index: AQHYROGzpm6L1ToHZE61xo5lM5st0KzZY8SAgAADGICAAS5WgA==
Date:   Fri, 1 Apr 2022 06:11:49 +0000
Message-ID: <624697D3.80206@fujitsu.com>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220331115925.5tausqdavg7xmqyv@wittgenstein>
 <20220331121029.r6lcwbejdd243f5r@wittgenstein>
In-Reply-To: <20220331121029.r6lcwbejdd243f5r@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c5113154-1689-4d30-6dcc-08da13a68212
x-ms-traffictypediagnostic: TYCPR01MB6672:EE_
x-microsoft-antispam-prvs: <TYCPR01MB667218616D9D54FE132342BAFDE09@TYCPR01MB6672.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: e+k+Hqg6zxr21EM0sGpuykzEGofvB3pFt24DPcmzGiERRWpxZiRjPK4T0jtVr3oqbem0OnaLahHATSJN9XPXepCbiL33hYJOLUJ21Oa+/wksInJZ84gUHtH2ZRv3i7zdvqrUwHLAyEMsKAGStIsudQz4sLdUUKWeWo+F7x32i5mORpVWeRCKO8gD+rGpFgBIV+ckamHXtRRgZVdfp/DLVwE8aCuipHha713U109KoTNzxRsy/1F2fhPqrFi2xYmxgfcR1Bk4AqhaW4o6FHq8soaIahbAiqWk/garSnpXOH8qqK5kW0hfsZplEWCNzTdXmFAougG20X/FHNiBw9RKu9/TYs41ttSoE4zr0i1ZSBsYb4cTo1HL0KoV8klx+HkPkQHXHCNn+WEKexMa8W0Ugd0c5QlY8NYy85F2mv/RZbWUXnzVk9aw9oEDtvTLEtGlgOOBLEIwpfPf7QumH4crPlvEdCY0Dgljt4krjnScrhESAVLAKhWO9v8NnOjze/Oe/CA13wnEq25pQdZXdV5LOH2FDK4M2TcrTToB5/RLroE+/05GWFiO+NlRP/b59rdmntyqD327OrrRMqEDBgq7h1qAeZXzmL8yoRf8w5BhStZlQBGLBnoEKV7EGlxGSD42RIV2nzp47eNJyejZkkP9OSZkHKG6vk6MnCIwcb+Lp7b8uCjkpQv8J5mDk1L7+piZ2g94d7UEglu+NCTyis2hAA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38070700005)(76116006)(91956017)(66946007)(64756008)(36756003)(33656002)(85182001)(66476007)(66556008)(4326008)(8676002)(316002)(66446008)(83380400001)(6506007)(2616005)(186003)(26005)(86362001)(8936002)(6512007)(2906002)(82960400001)(54906003)(6486002)(71200400001)(122000001)(508600001)(5660300002)(38100700002)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?NGpuZXdsSU51M1puT25aTkJlTkNhM0dUM1dDd0pwMGtndEtxdy9XR1ZKRzRW?=
 =?utf-8?B?OExiTzdnNjd5Ty8zWTV5VHNqQWtLVzN4M0JIMWRnVU5zOEo5M3Rib01Ea3pO?=
 =?utf-8?B?eTdWMkRSYUNzUkZoN2IyTkdIdGpNL2hCd1JoWFhzTTB6NStpUDA5R0xqdDNh?=
 =?utf-8?B?M09aTnpvakFtejdUTXMrNHNzcDYraUFkN1VzTTlWVkJ4SkdhckM2TFNXVENh?=
 =?utf-8?B?bDM1NkNhVkwxYmFrcnFla0pJYW9EVEZseHoyYXU3WHE5REI3aVNvRG5Gd2dC?=
 =?utf-8?B?aStxTHhuVnhIUEdEbGQweG9rVHIwVXhzdW5sQ3RnSXNua3hDWmVvWTBmTkVj?=
 =?utf-8?B?dXJZaGJvNHhFc0N3TkFWTldXZnl1MzVKditOQkl0c3MvQlc3dzM3NjZ0RC8z?=
 =?utf-8?B?QlZHQVk0eEdNWnpjenF6V25QRW5WcmJtOE43TWoxMTdrdUFWVTdlYXc0TmlL?=
 =?utf-8?B?cEZpZ3Zuc2Evc2NBYmpVSjVFUEZjSFNWTHIxTHVWQXVCNk5vWE9xU0phYXQw?=
 =?utf-8?B?UWhCU0dRRnF0V28xbU94L2x1Sy9hblJTc09RUk9CdTVvQks1Y0VmYW5mbndF?=
 =?utf-8?B?Y1VLTWd1b3lIN3pGcjV1QjN5NHRuYW9SdE5hMDFBMTVsSkZtTWU2TldzK0dG?=
 =?utf-8?B?bHFidVdFbzZqS3NoV0JBOHE0QlIvbWJWeHdVY0FSNEZKUlhEUmh5Lzc3M0x2?=
 =?utf-8?B?VUNkWjBkRVd3bURReFdteWRuTHVrU3ExNzhjMnl3OEJ0cGF5M3ZnelN1eVZS?=
 =?utf-8?B?Wkxud1ozU21PTnA2K0ZmSDVkbnZGK2hIUHF3MER4TTZpZVBtVnZvU3VZcVBX?=
 =?utf-8?B?TlVaL2hBZjU3ejg5bWNmV0x0VHk0NEtjSytqRWVMNjFOSjkwK2xPRmZXeU1x?=
 =?utf-8?B?RmF4dERlRjFjWXdZZCtyM2RuNUJHMFovWXlzMm83WWNoTHRhVFFrUm01ZCt4?=
 =?utf-8?B?TlFWVHVvb1prc1pCWHdUVWN6THpKeFNXamFINHZEM21CSjdTTWtSWlVNZWhL?=
 =?utf-8?B?c2RrRFBCVmJJbmpaRGljOWNXZnRaUzRYb0dIWlVNUzhBKzlvNlhyMUZGaHBC?=
 =?utf-8?B?d3ZRdXFiZkR6UFUzNHRoL3A0OWtjQk53WkhYcjZZeVBnMURsZG1mWGVnbmFP?=
 =?utf-8?B?KzB0cjNvdkxxZDgzaHdPU2thUkJWSURhN0NkbDN6WVh1RVFPSHdwMW1MNDJt?=
 =?utf-8?B?bjNXcEpYN3Z4b0M3VDYwMlY2cFpDTkJoZEtFVHk1UUgrN0tHbTlpZys0bHhF?=
 =?utf-8?B?VitSOHFXOWtuN1ZsQm8vSTNtc3NhT3V6d1VqKzdqMU1FZWRUZUw1UEtNZm8w?=
 =?utf-8?B?VWd0WUdhVDBXVU81d3IwcXltSnJjOE91TDdJR1AwWlhjcjRzNmFFUHFnemxx?=
 =?utf-8?B?U0JoTjk3MjBjVHIwekZmUlh2YTBCZ0ZJVWZSQXlicHRFVlhDYWQyL0hnMy9V?=
 =?utf-8?B?WXJiYUlkai9OOXBoZ0Znc1FUQ2JwNmxwSlpuQzI1K2RnQmNXeG5xWlMwWlRp?=
 =?utf-8?B?Slk2dGpsWUFKQjd3YjN6MW5DdXljaDFHb0RzOElqWVoyUVY1K0FFWHc0N1B1?=
 =?utf-8?B?SFVNY2l5M3FJV2NhUFZjVWprVmxtNjZLaDZmKzNPTDVPVDdyTHFyYzRTNU1N?=
 =?utf-8?B?SGM2VTZTUjRUUmtzRm5XNkJCRWoydVVLSGo1TmNoTWpUbjErYXFxcmpxN2Z2?=
 =?utf-8?B?c2hVeW1ROEpUeUMvbkhmV0tHdmYvcTlob1NjZ2N5WklET2pPUmVoTXVCQzh3?=
 =?utf-8?B?SHJ6bTNOVEhXRkUzZ2tYd2NGeDFvWnBJWWlwTTQ3SDZDL0pRMzJ0RC9zWDNk?=
 =?utf-8?B?VEFWUlBQU3pQNTl5TFUwd2NIQmZpbDNPT2FpTnN6eHdNN1VNV1ZGRE5BSlg3?=
 =?utf-8?B?MHoySzNCcFZDam5QQXAzUEhRUmxMREZRRmRjdENDRkhBV1Q2bVlyMzMxbEVY?=
 =?utf-8?B?c25qeVVYMFV0dnh2dHB3TDJ0Y0lXcUxPenNFTEZZZVBSWDZPaGRPRjYvT2Zw?=
 =?utf-8?B?NUVNNEQ1U1FDUExTSGxObVU3bFVVR2dKTlNyekozR0M2VlVkbzNENkhFMncx?=
 =?utf-8?B?VXB0WUdsSDNvN3dic2s3L1JsWHovZDJxdHFRSDBWVVFLSFZlWGIxT3ZsQzR0?=
 =?utf-8?B?eitBdWwrd21KdStoa3dGRjljNVROUyt4UExOOWc0T0phZDdnNndtMUhiQWl6?=
 =?utf-8?B?RDFmb1pvT1lsUmdXQkJvNnVsOUs0ZE1EM2F3c0tJcDBwUEIzd082WVZsVDh1?=
 =?utf-8?B?NjRLNVBBUCtnT2RxVDdPRFh2SHF5bXJSYTRBRVBzREJCbXVNa2RPS3kwaVBo?=
 =?utf-8?B?V3JzU21XOFFIWXhHayttSDRTZlVMRmt5YUtZZ2xDbXIwMi9ZVHg3THZ6TVVD?=
 =?utf-8?Q?dtZTepd4/q0s43mw+lacTyka/0A7XVHI3QL+O?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A20CC50102115E4086FEA6FAE7AE0C2D@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5113154-1689-4d30-6dcc-08da13a68212
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 06:11:49.3622
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rZtVOj9k/L4NYyfqtUXsa+jH7hLrdjXKuQOwRh8yE77r8BX7d6LC7txoJnqpZNI68eQFJjucnDvGwcPaCUDgj8sndcQY2fE3IRNu6L3ZlDU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB6672
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi8zLzMxIDIwOjEwLCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBN
YXIgMzEsIDIwMjIgYXQgMDE6NTk6MjVQTSArMDIwMCwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6
DQo+PiBPbiBUaHUsIE1hciAzMSwgMjAyMiBhdCAwNToyODoyMVBNICswODAwLCBZYW5nIFh1IHdy
b3RlOg0KPj4+IFNpbmNlIG1rbm9kYXQgY2FuIGNyZWF0ZSBmaWxlLCB3ZSBzaG91bGQgYWxzbyBj
aGVjayB3aGV0aGVyIHN0cmlwIFNfSVNHSUQuDQo+Pj4gQWxzbyBhZGQgbmV3IGhlbHBlciBjYXBz
X2Rvd25fZnNldGlkIHRvIGRyb3AgQ0FQX0ZTRVRJRCBiZWNhdXNlIHN0cmlwIFNfSVNHSUQNCj4+
PiBkZXBvbmQgb24gdGhpcyBjYXAgYW5kIGtlZXAgb3RoZXIgY2FwKGllIENBUF9NS05PRCkgYmVj
YXVzZSBjcmVhdGUgY2hhcmFjdGVyIGRldmljZQ0KPj4+IG5lZWRzIGl0IHdoZW4gdXNpbmcgbWtu
b2QuDQo+Pj4NCj4+PiBPbmx5IHRlc3QgbWtub2Qgd2l0aCBjaGFyYWN0ZXIgZGV2aWNlIGluIHNl
dGdpZF9jcmVhdGUgZnVuY3Rpb24gYmVjYXVzZSB0aGUgYW5vdGhlcg0KPj4+IHR3byBmdW5jdGlv
bnMgd2lsbCBoaXQgRVBFUk0gZXJyb3IuDQo+Pg0KPj4gRndpdywgaXQncyBub3QgYWxsb3dlZCB0
byBjcmVhdGUgZGV2aWNlcyBpbiB1c2VybnMgYXMgdGhhdCB3b3VsZCBiZSBhDQo+PiBtYXNzaXZl
IGF0dGFjayB2ZWN0b3IuIEJ1dCBpdCBpcyBwb3NzaWJsZSBzaW5jZSA1Ljxzb21lIHZlcnNpb24+
ICB0bw0KPj4gY3JlYXRlIHdoaXRlb3V0cyBpbiB1c2VybnMgZm9yIHRoZSBzYWtlIG9mIG92ZXJs
YXlmcy4gU28gaWlyYyB0aGF0DQo+PiBjcmVhdGluZyBhIHdoaXRlb3V0IGlzIGp1c3QgcGFzc2lu
ZyAwIGFzIGRldl90Og0KPj4NCj4+IG1rbm9kYXQodF9kaXIxX2ZkLCBDSFJERVYxLCBTX0lGQ0hS
IHwgU19JU0dJRCB8IDA3NTUsIDApDQo+Pg0KPj4gYnV0IHlvdSdkIG5lZWQgdG8gZGV0ZWN0IHdo
ZXRoZXIgdGhlIGtlcm5lbCBhbGxvd3MgdGhpcyBhbmQgc2tpcCB0aGUNCj4+IHRlc3Qgb24gRVBF
Uk0gd2hlbiBpdCBpcyBhIHVzZXJucyB0ZXN0Lg0KPg0KPiBPaCwgaWlyYyBFcnl1IHVzdWFsbHkg
cHJlZmVycyBpZiB3ZSBkb24ndCBqdXN0IGV4dGVuZCBleGlzdGluZyB0ZXN0cyBidXQNCj4gYWRk
IG5ldyB0ZXN0cyBzbyBhcyBub3QgdG8gaW50cm9kdWNlIHJlZ3Jlc3Npb25zLiBTbyBpbnN0ZWFk
IG9mIGFkZGluZw0KPiB0aGlzIGludG8gdGhlIGV4aXN0aW5ncyB0ZXN0cyB5b3UgX2NvdWxkXyBh
ZGQgdGhlbSBhcyBuZXcgc2VwYXJhdGUNCj4NCj4gc3RydWN0IHRfaWRtYXBwZWRfbW91bnRzIHRf
c2V0Z2lkW10gPSB7DQo+IH07DQo+DQo+IHNldCBvZiB0ZXN0cyBhbmQgYWRkIGEgbmV3IGNvbW1h
bmQgbGluZSBzd2l0Y2g6DQo+DQo+IC0tdGVzdC1zZXRnaWQNCj4NCj4gYW5kIGNyZWF0ZSBhIG5l
dw0KPg0KPiBnZW5lcmljLzY3Kg0KPg0KPiBmb3IgaXQuIFlvdSBjYW4gdXNlOg0KPiBkMTdhODhl
OTA5NTYgKCJnZW5lcmljOiB0ZXN0IGlkbWFwcGVkIG1vdW50IGNpcmN1bGFyIG1hcHBpbmdzIikN
Cj4gYXMgYSB0ZW1wbGF0ZSBmb3Igd2hhdCBJIG1lYW4uDQpXaGVuIEkgd3JpdGUgdGhpcyBwYXRj
aHNldCwgSSBhbHNvIHRoaW5rIGFib3V0IGl0LiBJIHBsYW4gdG8gbW92ZSBzZXRnaWQgDQp0ZXN0
IGZyb20gb2YgdGVzdC1jb3JlIGdyb3VwIGFuZCB1c2UgYSBuZXcgdGVzdC1zZWdpZCBncm91cChh
bHNvIA0KaW5jcmVhc2UgaXRzIGNvdmVyYWdlKS4NCg0KV2lsbCBkbyBpdCBvbiB2Mi4NCg0KQmVz
dCBSZWdhcmRzDQpZYW5nIFh1DQo=
