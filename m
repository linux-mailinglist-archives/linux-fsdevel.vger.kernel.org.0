Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E655B509AA8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 21 Apr 2022 10:29:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1386656AbiDUIbK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 21 Apr 2022 04:31:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbiDUIbJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 21 Apr 2022 04:31:09 -0400
Received: from esa14.fujitsucc.c3s2.iphmx.com (esa14.fujitsucc.c3s2.iphmx.com [68.232.156.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7E913EB0;
        Thu, 21 Apr 2022 01:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1650529701; x=1682065701;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=jhG52Pah3uEu8nX9eUElx6XZhQ7MILeVWd/9X2j7+78=;
  b=ik9bGc64Aqp8aTZxJmOtm49rnGe5g2RaQku9nZSCHsyxcOjIBPO5Zm1O
   hwNlxIT9rVy2aM0bwiuvMNv7EwkF1t7QNOHJzVKC4hL1zOihJ7tHj0n4U
   6YRlTVAnCCD49gDJpFtKBsK1aXleg2HiXNMQkoUCjUPGp/mPBnt3LW+JO
   NrvFhDrXo2mQ9KIhpwD+pkau68uqvUdh+mKiFyQ627qZSM4jUUwIYmYWS
   FhqqnNgiYzpAVAQHDMGG13/RiC8d0q3CqfQmFPUApQcKgrJJ/VNcG2dkb
   AbCd2JrqGhapNkMF3GPVvsYK15r53SsVU7qddMMHY0AiWjST+5S/6kaim
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10323"; a="54195566"
X-IronPort-AV: E=Sophos;i="5.90,278,1643641200"; 
   d="scan'208";a="54195566"
Received: from mail-tycjpn01lp2170.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.170])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 17:28:16 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NCBABKj7GKV8mtpQG/ssTe3Y3RGcV/drVz+uQCQkaaWcuA8D5zMq0GlR/hdMladojX5cMoopx1xNQUxGIVTfb3SLRsIA0hcNO9XfCZwUnTFqbg3aDy5JZdx9w4cXe+L4aVmdMPJs45lFe1p/U/JzvMCYjN0cvXMb/sZc80x45dUi9SbW2BNlWWaGUFAJ38277kc1xy4Mlmnfpy98PaVbJ5DN7ZDwczJUyacdSB8IPB0LwnPOTJ41j9QwhcIGxLcaYb4JYPw9H0wIY8tJk88pEJb2logw19DoUDEGLyQbYjxAmlCEii78CsXoOxs+mLC+anK2GUpIFYlb2Q20CJxMxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jhG52Pah3uEu8nX9eUElx6XZhQ7MILeVWd/9X2j7+78=;
 b=EJnuvxZAhUGOnQh+vaLXXBv7mnN1EY7oq18iFFimESJ8zoDzRETjiPaHer32TkEpNhSFg6epOXXKeDMGdFdMQ534XkloypaxJaB3AI5/4zDmHPDzaf2S1u8Oq378K3gPtf2pBm2OpPMOBGop0BqKvQzpdG8jeHnsnAb0bKqkHu5OG0b33psur7aB/p82O1JRBSCxV2FtIy7uo0C6DKbtGzsGwEeJ9tCHNGXnYt5Ls41hCPs6Dk4N8HB37XbVUq3BcgzpNUI0TfSmiGXTzX4XVq2mgrIzFKuoXpZsf9f1Ie+ccYy8WzBErlDsKXd1jNY5kZEWW1HqKJzOVcd7ihMVqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jhG52Pah3uEu8nX9eUElx6XZhQ7MILeVWd/9X2j7+78=;
 b=h7lzspwcd2SyyT18eh4lqncHegJ0DKIA3w6HqAOqoDQJE4sW05JRyPBgvgQTleFxAnobQ0jRqspRINAP1QUx9f3RXtpU6I8PcTJ7H0bE9rHMAqzprjYboLaCWrfXZkCXjI+Y6zxiRxPGGe6WGAvucn0gwRnHyanCW4pRktmXQBI=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB3345.jpnprd01.prod.outlook.com (2603:1096:604:53::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Thu, 21 Apr
 2022 08:28:12 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.014; Thu, 21 Apr 2022
 08:28:12 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v5 4/4] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
Thread-Topic: [PATCH v5 4/4] ceph: Remove S_ISGID clear code in
 ceph_finish_async_create
Thread-Index: AQHYVUylBmV2SRtyiUy7XdfdBTPxe6z6BkUAgAATu4A=
Date:   Thu, 21 Apr 2022 08:28:12 +0000
Message-ID: <626123F9.8070004@fujitsu.com>
References: <1650527658-2218-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1650527658-2218-4-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220421081852.rrmj2log3fln22lp@wittgenstein>
In-Reply-To: <20220421081852.rrmj2log3fln22lp@wittgenstein>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 242e29e3-8bab-45f6-ce18-08da2370dfbc
x-ms-traffictypediagnostic: OSAPR01MB3345:EE_
x-microsoft-antispam-prvs: <OSAPR01MB3345148275851030FFA55EB7FDF49@OSAPR01MB3345.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PJtkDxGboabqi0XYjmBr3AE1gXANcfuAMbAs8ou7LNJSiOdFqzeUIOiYLu5UY8goT5diqkP3N7k4t6ofiGqYYOr+rRK9bEv0kVNkKdQG8mrgsOXcpsDkH46+WaUIlPEb4lJJ5jDTZCF0qdYY8jKl0KY0CtmmzS9kZEXaGmWL9+7kVvQzyD38IEjE27SJljErCwgNkzAeJV298fyUnm0aogSxfWsEeP6ycG+aMDDwZQS7h29tr1Cku1np+cvAXcM18zNUEc3A1ttKamd0HnXkCPFDCrKFo4yuZ2zf6IVxMaOuaCH+XzTMKH6PyCi9OUVaTnn0nikjba3MqMQ2LfmNO0xqaJNWHzBD8k7zs6wOJlyjGLG7CkdoXHPxJD0BE9uTzF4Dg5SZ9w5URKhNdNsjddXxAVb3BiC193oeL+QHScYKumdQkaxnrh+FaFkZ84JX8endMgBGPbpsgTjRVJP6pGSU6UsePJ4auspmvIXcClicS9tfJfkqxLwoVpv+6WY/Ex3ZycnJz4s9pSj+Aq5qNJEznEoCHZAKTxlLlLeC4g6Fw+UI/WJ914tb4ZaP1et4UCKGzrZJ7iYTvsdMShNyw5kQok4jlCg1CaQCaKw562HxmJtlwKkpPDARXmqOJIc5YKy0Gn8NPVUkdkLi6HlP0UbMWqHD8hH/LwdddUFxUba1EAJ18LM+lSZMo/HC5XGQW3xFeASnmlefQyuYB9GMkQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(76116006)(2906002)(71200400001)(6506007)(66556008)(87266011)(5660300002)(6512007)(4744005)(8936002)(186003)(36756003)(33656002)(85182001)(91956017)(8676002)(4326008)(66946007)(6916009)(38070700005)(66446008)(2616005)(6486002)(66476007)(86362001)(508600001)(38100700002)(26005)(54906003)(45080400002)(122000001)(64756008)(82960400001)(316002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MDVlcjJGY09nbTFWUDFxMmpTSlBnMnRoQjMraG9FcXl0bGxEdURzcG5Oc3Vt?=
 =?utf-8?B?MHhJNTQzclBPTW1jSU9CYjJYbmIxemZYU1l0a29tT2tQUlhNWENTd2ZvVHNh?=
 =?utf-8?B?bG5JK1A0d0hrRTFDWUdOeFl1d3BnUXVqL2J5MmZqZXZlckdJWFRCUm9UdVRl?=
 =?utf-8?B?dFNBZStyWExsZmhXU1FBSW5HZ3ZDN2JKY2RJQmpiYzFka0NabjNpTWV3VURW?=
 =?utf-8?B?cmJnY3dYUkJoWVVpYWpNeFRCR0RmTnFMQ1QxSGdkeUhpaUczYXpaUHBWazls?=
 =?utf-8?B?dkNISnNBZVJkTmxqMXBycURCVVdkR1NodTdaWFR0Nzl2SFRGY3hIcTI1YzFN?=
 =?utf-8?B?c2ZIRFRrZk1zUEdITGhyeTkwUTdEUTRRc2ZxQjUxRHFKNFU0WFBmdk9WVStI?=
 =?utf-8?B?c2xOS0wwTi8xR0lEUU5wRXoyU2pPTGhPNVJmeW9oZjBacjhPQjFFWDJ3dTZS?=
 =?utf-8?B?UEtleG9ldlN4RXpPcEZlR2dPeDFEdHZRK25KOHVjN2JIWEFlUFF5enJTZjBB?=
 =?utf-8?B?elpYNEs1WTY2L21EVU95NTFkV0RSNmU3UGVsaFE1cExSWnVrak1Oc3k1QmRM?=
 =?utf-8?B?M21HREJ4K3JjRUZubGVZT1l0Y2tTeFJhdFJJcDViUG5lT1NyU3BjaXBMMEZP?=
 =?utf-8?B?NVNWaHh0QVVUdG1EZlZMUnlOQy9nckR6SWZ1N2ZudXdBcFhDcmhxTEU0SzIw?=
 =?utf-8?B?ZmI5QUErdWM5V3R2UFZrWktwbEtvSXlBcmV2Yi9UNHdlVURHTS9BV0d5T3Ru?=
 =?utf-8?B?cG9ETkd5UXNmTWZNL1ZGTjdYVE1DRkMxWk1vODRCekVYWEM2eHNSZ0FTK2hT?=
 =?utf-8?B?dzNyUlNLRWJtQWRpK2tHV0JlbHRQYUVCK3hZVW8vb2JFVW5RZklTdzZnaUYx?=
 =?utf-8?B?ZzM1ZC9aWUFEdUpJMHFFaHY5ZXYzcU1EZTRFcys4QXpaRjYrVVF5bExUVHRo?=
 =?utf-8?B?bzRkdTVYY29CcEFNWFI1U1hMS3JTcjlhQ0hYLy9GN3ZCNXJEMDhHellTa3hE?=
 =?utf-8?B?eDJyYitEdGsyOWtTeVBNQnQ3Z0hiVHhuWUJEUGp4Y3ExVklTckVhc0hPcUhm?=
 =?utf-8?B?eXhzYmpmZVpBSXV3Qit6TDdtUG9IelArYko1NFVaUUFNUmcwNmhvdlQ5c1pt?=
 =?utf-8?B?NzVVRXJDcFdkUWlCcTl6V2gxYTcwOUpUSDZqL0FrQVJBb3FuY1NpazA1d1FY?=
 =?utf-8?B?clVXZkw1RWIvbXpNNWk0ZzdtOUJEUnZWU3lOcUFpdkRLZmFsYWYxRmQwUzda?=
 =?utf-8?B?N2dKb3lJVTRkb3FBTU9lWFVEc3I4Zm9QUm9kRlo5d3F6OWI2WmcvbGp1a2lv?=
 =?utf-8?B?ZWxRVUtHTlo1NVo2WHV4ZU1uV20ydGF4Yjc3dFhYMTFtM2ZaMnYxYUh1NFBP?=
 =?utf-8?B?NFduajU2VkRlY2syWlVteGM2WXdBalVJM2didHdwckhkeGRrVzZ5UDlaaE5F?=
 =?utf-8?B?ZTV1bE15ejBYK09aa3kzc1BkT1Y2RUJOQy85OW93bHVYaXoyVmFSVUVGbDNO?=
 =?utf-8?B?aUY1a0lHSDBEV3o0blVXdXVWdUdrTzQwVkZYUEhqRzIxRmFWU1ZQWnd2eHNo?=
 =?utf-8?B?aFRSSFNMUUFEUzd1WHlRLzdJcFZnQ1hpRkthakZjK3htTWx0dzA0M3FydzVH?=
 =?utf-8?B?by93RmdKdDFKdW1sTmVrWCtNdkRWV0tOd09Mcit0K1I1dWptKytmY1FRMCts?=
 =?utf-8?B?NGN5S1JaM0hYZk1FdldIMXZPMTN4c20vY2NuUzJwVEVmR0Y2cm9GSWNjMzJ5?=
 =?utf-8?B?aDljWXIrRDJCKzJiM2swd2N1bXdwcWoyVHUxdDU0dmcxajZHK21FcFlVdjJ2?=
 =?utf-8?B?Z0M3ajlNaXpJZVdQSCtua3ZaZ1FQRFVkZE15NFA2ZUI3UUlsU0JNWCtta1h2?=
 =?utf-8?B?eXppMXZMTUl2NFZraVJFRjF2V3B3Lzc0dDgyRytVKy9qanRSWGoybGFSTXla?=
 =?utf-8?B?WGsyeFN2S0FzODV3QzBiVVJ1dGVXREVZS0YwaG14MXZjSE5MWDNTT1JTdkc3?=
 =?utf-8?B?MmJkcHJGRlpVcm5TNUE2TmloY2NpQjVvUC9ib2tsQWdmZmdoazArN05pdzdL?=
 =?utf-8?B?K2dNQjcwMWNXZFh0QmdHZHhPVDB5cE9Ob2F3SWdVNnJLNUhXcEpCT0RyMGt1?=
 =?utf-8?B?TnRhUUV5K3IwODdma1NVWUkxTVNZWXFLcVpWbUZ6b2FOV1BrL2xjbmU3L1dz?=
 =?utf-8?B?V1FWV3lqMEpDbEdBRDRBN2owOS9TVWRzazJUNmZqcGxUd3drNHNEVlFVYzhl?=
 =?utf-8?B?eTN1RXpOSTkwbCtONzJ2TU9tRE9oQmJuVGY2aEtIbURHcnlVZlJlOEJKcFdS?=
 =?utf-8?B?MTh6ZnhSaGVBM0wvUUdhTVRrQmhpaG9yYjdjNUl1WWpvOHlwdzZ5M2I0UXAr?=
 =?utf-8?Q?sE4POsMkg152eaBr00apUX3ZOhe5eu8/QWRnX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F0552FC03EA93D43A90EB77BE236E1B5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 242e29e3-8bab-45f6-ce18-08da2370dfbc
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2022 08:28:12.2879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WcJxdHjPA8k2G4hDMRPGIJajFljt6ObSj5/qoedOFLHdkwnR5PHcw9oD8BUmzKiRB4XrRiy8ZnVOHbeMkvtquPCd2xd3qZ4cfeKpAcEUCf4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB3345
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzIxIDE2OjE4LCBDaHJpc3RpYW4gQnJhdW5lciB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMjEsIDIwMjIgYXQgMDM6NTQ6MThQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IFNpbmNl
IHZmcyBoYXMgc3RyaXBwZWQgU19JU0dJRCBpbiB0aGUgcHJldmlvdXMgcGF0Y2gsIHRoZSBjYWxs
dHJhY2UNCj4+IGFzIGJlbG93Og0KPj4NCj4+IHZmczoJbG9va3VwX29wZW4NCj4+IAkuLi4NCj4+
IAkgIGlmIChvcGVuX2ZsYWcmICBPX0NSRUFUKSB7DQo+PiAgICAgICAgICAgICAgICAgIGlmIChv
cGVuX2ZsYWcmICBPX0VYQ0wpDQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgb3Blbl9mbGFn
Jj0gfk9fVFJVTkM7DQo+PiAgICAgICAgICAgICAgICAgIG1vZGUgPSBwcmVwYXJlX21vZGUobW50
X3VzZXJucywgZGlyLT5kX2lub2RlLCBtb2RlKTsNCj4+IAkuLi4NCj4+IAkgICBkaXJfaW5vZGUt
Pmlfb3AtPmF0b21pY19vcGVuDQo+Pg0KPj4gY2VwaDoJY2VwaF9hdG9taWNfb3Blbg0KPj4gCS4u
Lg0KPj4gCSAgICAgIGlmIChmbGFncyYgIE9fQ1JFQVQpDQo+PiAgICAgICAgICAgICAgCQljZXBo
X2ZpbmlzaF9hc3luY19jcmVhdGUNCj4+DQo+PiBXZSBoYXZlIHN0cmlwcGVkIHNnaWQgaW4gcHJl
cGFyZV9tb2RlLCBzbyByZW1vdmUgdGhpcyB1c2VsZXNzIGNsZWFyDQo+PiBjb2RlIGRpcmVjdGx5
Lg0KPg0KPiBJJ2QgcmVwbGFjZSB0aGlzIHdpdGg6DQo+DQo+ICJQcmV2aW91cyBwYXRjaGVzIG1v
dmVkIHNnaWQgc3RyaXBwaW5nIGV4Y2x1c2l2ZWx5IGludG8gdGhlIHZmcy4gU28NCj4gbWFudWFs
IHNnaWQgc3RyaXBwaW5nIGJ5IHRoZSBmaWxlc3lzdGVtIGlzbid0IG5lZWRlZCBhbnltb3JlLiIN
Ckxvb2tzIG1vcmUgY2xlYXIsIHNvIHNob3VsZCBJIGRyb3AgdGhlIGFib3ZlIGNhbGx0cmFjZT8N
Cg0KPg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5YW5nMjAxOC5qeUBmdWppdHN1
LmNvbT4NCj4+IC0tLQ0KPg0KPiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgKE1pY3Jv
c29mdCk8YnJhdW5lckBrZXJuZWwub3JnPg0K
