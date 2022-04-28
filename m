Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D441A512976
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Apr 2022 04:23:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbiD1C0s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 27 Apr 2022 22:26:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiD1C0r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 27 Apr 2022 22:26:47 -0400
Received: from esa19.fujitsucc.c3s2.iphmx.com (esa19.fujitsucc.c3s2.iphmx.com [216.71.158.62])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94D5078FE0;
        Wed, 27 Apr 2022 19:23:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1651112614; x=1682648614;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1oeQhQVv4p7JL6lul1rhP+Znp7wMyXp/780T+zpc9U0=;
  b=lQeOk/emwCXif55hsDSeDHz/oTzgd7D6c/NJrrppQpJZ5r+5LoHGdl1A
   CA1p6s2h7+TTSveaqsG9/y3ewnNzfEPKuJlDVL2+LI0FMrDecFSAlFzX9
   PfYBuSxSbFP22+O3dyA/bOWES+qqYWg0NB9V5lCFiYIopLXzDRN+5yrHr
   cTF/Mj8+c6eyw3XIySJYQh8foB8sTDi3VsIA8Jd/sucrq0NQRTVhWL8yb
   0a3OSgxYGzjQjn1E5qKdKKdt+RyOFdh9u4yYbZZ3d0chs2dDf1jOGWxdw
   STRbRsaOBe5XlkMVK64G+YaE8Vy2ebN07ttMm/SGAboDUtQkGl5bVmrxT
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10330"; a="54496681"
X-IronPort-AV: E=Sophos;i="5.90,294,1643641200"; 
   d="scan'208";a="54496681"
Received: from mail-os0jpn01lp2109.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.109])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Apr 2022 11:23:29 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WByZzpgQYABcky/5AhGM7NOBMzxsG1wCa9T5LGzgdrfJB33/4U6U3AsQVw0bhdH7VRVb0+8YlV/AJbCFWs0mOzSlHhlHqh2Gu2gi9Dw+B2R1ORsk4Nswf3sy2KLCUwxMX8Lw8dNTs9V14zK0UCTXAj/KEDAeI4Z54No7/PwDLOVgn58OUlx8UMflF3aEDqdqkQi2+eYwJdWeysTWOSPjEDzePj9RI3TSmjBr7/Tz2uBbMYeWtA+LUIKypzVD2a5/e0fkDyTiMIBipZqQsfP1d1In5a02FY/zL4md487l8DAZESL9MfMRQpWB6/4LCe1lXUUesQ/nAI7woN8HzBYHSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1oeQhQVv4p7JL6lul1rhP+Znp7wMyXp/780T+zpc9U0=;
 b=mclpzMxFv6dqe5ZH4CHbgQDdEYeYkLttIQAXFLcA9iOGxBhc0TMWqPBj7UFjAJkmE7PF+kIAa5WZe8zLbB2zoXBtyA60DukbhhqXF1OAavI4467Xh5jpncCKf/azJEmm1GacaeFh2CII2Mgarm+XBAFdpQm8xRiXtS0IqoLRqsJmxIvE6tcN8CMsFQH0emYzEz1Y2+gpBmcZ/pJKHMUx8sSIZ+eBgP8yk9MMTpy2B4O2JJGKflmDGm6MPaP0fMwJHfWKYwUWlAbWU4KY0LwyC9iJ5dmLiUXlJGgVb7w5hBANSS4d80HvnymBSZWRc5lwYpK6OzbAmu2biM7HXf70qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1oeQhQVv4p7JL6lul1rhP+Znp7wMyXp/780T+zpc9U0=;
 b=Giuk6SQzyro9/uzGnzWoHHiaefy5EwAwlnUB0dvkj3+VRoRmHxDqdF3X+8T9xnKG9vRk/kxEtZbOM1xt/RLlofg6Oas7PwZQdAZuBTd0xg4dycYgT5q9rD2GL30sLUshJsTPZX6np41qz1CMPElNAOuNDSLve/GHCDgIysirmWM=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB5199.jpnprd01.prod.outlook.com (2603:1096:404:123::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Thu, 28 Apr
 2022 02:23:25 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::cc0c:b99b:e3db:479f%7]) with mapi id 15.20.5186.021; Thu, 28 Apr 2022
 02:23:25 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Jann Horn <jannh@google.com>
Subject: Re: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Thread-Topic: [PATCH v8 1/4] fs: add mode_strip_sgid() helper
Thread-Index: AQHYWVXfz8USQ3fGU0yVfe+Yu4r8bq0ElGOAgAAEnQCAABMuAA==
Date:   Thu, 28 Apr 2022 02:23:25 +0000
Message-ID: <626A08DA.3060802@fujitsu.com>
References: <1650971490-4532-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <Ymn05eNgOnaYy36R@zeniv-ca.linux.org.uk>
 <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
In-Reply-To: <Ymn4xPXXWe4LFhPZ@zeniv-ca.linux.org.uk>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47f14dc0-08ef-404e-d73f-08da28be12d1
x-ms-traffictypediagnostic: TYAPR01MB5199:EE_
x-microsoft-antispam-prvs: <TYAPR01MB5199E24C298BB1A0841EF9DDFDFD9@TYAPR01MB5199.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: BLVTicuCmPe7R4Jofj2JLb5NrkyXxDex26vbC9sgky3ytwlPeQXj4zGSqTYWKngcUrxzl6WCJX/3+GGVp6J8yGvdykFF4Mnrd6g6Ty6oCmTc/kqfz3plU5uBeX/yZdnMzBmEBkXv5WjxZCCuVbR1nk606O3h6CsWQrwXnivvn3oktZAPvEj9VdcQ5mk3JrA6fwA8Z+45QNpEwL63TmuvybP2HdBXD54Q4aRboi2rhkqZ6OHY6JAYcz8N3pVK000GUC4JWBqISFpqTZF8FEHxGmOgDSAAeanmKStkQRlH0hzR6KcUEibRMA/m9SeStRhxbwF+rF3x2XOzqxhrDKUcQfxFKvk+uIemz50JejW5dk4cyRL2z2vjs6jUrVZYbWcgjkxBU80dzjJljYHPg70K+65edT4KH3f2SGsDWCD3TAJRd08LhTle9ODs3J0CQw5/QS5FF787hqhdHF7H5BMiF3/gIXdBub9D/Jg8Gi8BYyXPxsT7/N4QcDKC/sCacBUIK0E/EY30xv1P1wfDdJUOhrMlAQdFVfN4yIVO2Bi5U3enOy3UN/nEMd5jsb2ToVIuUDiVA2j2WZzF/YuKmJ1QpicLadD0/VSwNYWG4LRH5tX33IsKLb9Bsh13iYyDdxjFv/712pk2oVHAGZSkKDbbN4k3jfWSw9Qu8T8iXp52CP/E3gKq1vionJgeGEQBvHC8QsCdjYUMJhu5A/s2wbInNJUgc6HUIYirO3xRgmiCLsc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(76116006)(6916009)(87266011)(6506007)(2906002)(6512007)(26005)(71200400001)(8676002)(4326008)(86362001)(7416002)(508600001)(33656002)(6486002)(66446008)(66946007)(91956017)(83380400001)(36756003)(85182001)(66476007)(66556008)(5660300002)(82960400001)(186003)(122000001)(8936002)(38100700002)(64756008)(2616005)(38070700005)(316002)(51014002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?UEczay9na2JVOGZ3NUlxN0lWNkRCSGhvQU1WUFVWKzBFeWE1TmYwMksvb0Uw?=
 =?gb2312?B?U0JJTi9ORWNCYW80Y0JZSkg3UjlRS1AvS1pBMzhyYkxMcytUeENpUjhJRWxG?=
 =?gb2312?B?VXZ3UjVkeFNWc1hEbSt1VVhrcmhaOVpEdHk1ajRVcm4xT3Y4YkNsMVlzMldE?=
 =?gb2312?B?TkN6MlN3OEUzVy91eUUrdjNzT0FBekkwSjlaaWpkajRHakVOZWxyanpGMDdx?=
 =?gb2312?B?NEF6RXZWU0wybDhDMHZ4V3FrZ1lBbWFkbVphTVFaTXQvQTBBMjRhb0JQT3lQ?=
 =?gb2312?B?MHFqb2ZiM0JFNW55MnloeHhuTlZDNk9pMUYxaWIwNXN4akwrQ0ptVUhISG45?=
 =?gb2312?B?VmMxT3lXSmljZmVla0dTK1JLNVVUejZ2NGdpcG9SZEYzMDF1dlo4c0pqbGln?=
 =?gb2312?B?VDFCVkhOU0FBRTFtQUo4bHZjTHJYWUt3SmJuMWpWbkN5SllTWFlQWUsySjk5?=
 =?gb2312?B?Z3JLUFdLNS9DOGI0M09HbjFmUUxTUWI2Q3RxYjZydWlWNlhRdU5SSlFxU0p0?=
 =?gb2312?B?UnlSd3NRYmJBVUJ1ZnRtcS9EK2tYOGw1YjZQcTY1YVBOTEVSRGR0WUZwenhM?=
 =?gb2312?B?SWpPY1JaVnZDQ29vaTBPamtGMXY5bUtVQ3kzM0VSNTNvNDd3bUh1VXY1c2sv?=
 =?gb2312?B?VGNhS0FlODIzTENidHdkbWtUdGl1VG5JVU01L0h4MmVUOVpKcU1ydTF3cDlh?=
 =?gb2312?B?djFhVDdmcDFzSkVFcGVsOE1CMGZ4U1lMQ09NSTE1dklEWk01dnpwQjlvRlpi?=
 =?gb2312?B?K0dKaGJwTndsdGlXdkh5Z1NvUnJmK1dUcFpUaEcxcVdOVk9rQ2hVOEx6bEc5?=
 =?gb2312?B?aHZaN2xhMkNZNUV2NVBmcDBvSnZmOVk4MitNWmx2YTBKV21HU3dXSzVDOTFJ?=
 =?gb2312?B?L1ZsQW9ldnFUSHFPMWc2OWtVcWdVSnFuNU1uZFg5R1NBdUlOYlVqNTlTLzhr?=
 =?gb2312?B?aTdnNnlzbm5SVDBOLzBjWjFFdlZXNjJ6TE0xSkE2U1RPZFZRNzJDQzFSSlpD?=
 =?gb2312?B?WGRsUmZIRnZGM251bnR6di9wSUdHVlA1UWQ4ak1pOEdZWmljZGgrVllRZERG?=
 =?gb2312?B?ZWJXYlRDSlFNdlBYa3dsWkc0WkNnaFVhdVhzd3FpY1pSV05oWkw2eTlKTnRv?=
 =?gb2312?B?aWl2ZEJpYlFUeDZ1VVN3SC91WEVCb1FYVkVtNTBEcTNWa05ML2RIQTZEZjBF?=
 =?gb2312?B?TWhESXB5aGJDK293bWk4ZStCcURNaVhQcHJVOHJndjkvaFNQSmtQa0VHNWta?=
 =?gb2312?B?ZHA4dVZUVUZLOXBtYnFxZ0JnTm0zWldvQ3dLMTN2YzhJbGw2SjduS3lEc3Rw?=
 =?gb2312?B?U0pacWxWd0NvcGFsdnZxWDhjci9QNXhYdDJ0cE9LWkMyUHU3WGpDcjBlSTV0?=
 =?gb2312?B?TEw2c1pGalRBZHdmRjRpa215MjAxRTVpVXNnK0hhU3U0SXdXdTlpQjV2ZEQ1?=
 =?gb2312?B?WVVPd0xyckgwSW4xK2JqeUlzdFlLQUoxemdOem5iakNSUGN3dDdMNm5GZVlL?=
 =?gb2312?B?bUI0bmNNYU55dnhkZXJsVDZoUi9JTGtqbE1zODkrZ00yRDhOSWNTMTZMZnFJ?=
 =?gb2312?B?K290WHZHY0ZnYzRoOFQ2THVQTG5FRXBKYTVHcmF1cTh1L0FKUzhXMzFsbWQ1?=
 =?gb2312?B?bnROSHF6MDBJcGJkWWZENWgySHc2ZzBKbzRBbi92eUVwVzBIMDF0QTk2cjN0?=
 =?gb2312?B?Y0hTR0xvMkFwUjlDa3prd2lrTkxKeWdSSC9VL1NwZWwwaUxxNlJicVhOZjVI?=
 =?gb2312?B?MWo3T0NSekRPT2wwelk4ekFWVUdwOHRpVlZScFB3WDRWMmUvWlgvQnlnbU0w?=
 =?gb2312?B?cjJnYWVDVEYzSkRsR0hXQVhHZXhJVHVVajNEa0kxeko4bkhCTUhJVE1zdFlt?=
 =?gb2312?B?dHMzTGpxOUxGK3pYa3YveVMvaEZIMDBBQm0zd3ZGVUxLTGxDWmhoZE5ORHdF?=
 =?gb2312?B?cTh1K3g4TDVOU3Z2UUZsbEhCSDJCMnZqcFBSTEpSTVdNS3p1TmY3eWhpWUpv?=
 =?gb2312?B?QWpLKzRpb0Y4ZytUQmErMEhtZnpCUWM2VDJhenF4aU5qT0JsV2g2NEVSMDhl?=
 =?gb2312?B?YWM0RGM1WDNaTVFmcUlYRDg1dEI5R2U0aDJVSFRoaUkvd1RvMTdKREorRWlz?=
 =?gb2312?B?bFRlUGp6VE9xclhJR2FhVVp4eFgvVE50YU83WXdkN1NibldFelZKNTd5QnZ1?=
 =?gb2312?B?aVB4SkNvZXh2bnR5VjkxV3NodWttRHpxczVCN2pLb1dTK25NU2hxVURoYVBp?=
 =?gb2312?B?ek5EaDBvWllYd21vY2szRVppdFZoRnFrbkZHeWJoZ2tQYnY0YURzSVM0RktQ?=
 =?gb2312?B?WUh1akNjaWFzQUdqY0Q4V0tKU2RvNGQwUFFpTzlVandac0Z0c0hvNUwxQk1n?=
 =?gb2312?Q?qCLg3d6BTkNKD8LnYiqqrzgLm7qAx9VurHL7o?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <E2E2C90ECC1A6347BDE79B03C322BACB@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47f14dc0-08ef-404e-d73f-08da28be12d1
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Apr 2022 02:23:25.0517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2UtFFxlajAeLkNy4SSrJr6hsLODSy1VdveikSDwQobMSUN8TQE1EqDKXZBRAl3AjvYAL57+is+KN5vlyPBLvZ5aEKZ6uvaG+2Um0e+xdnzE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB5199
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzI4IDEwOjE1LCBBbCBWaXJvIHdyb3RlOg0KPiBPbiBUaHUsIEFwciAyOCwgMjAy
MiBhdCAwMTo1OTowMUFNICswMDAwLCBBbCBWaXJvIHdyb3RlOg0KPj4gT24gVHVlLCBBcHIgMjYs
IDIwMjIgYXQgMDc6MTE6MjdQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+PiBBZGQgYSBkZWRp
Y2F0ZWQgaGVscGVyIHRvIGhhbmRsZSB0aGUgc2V0Z2lkIGJpdCB3aGVuIGNyZWF0aW5nIGEgbmV3
IGZpbGUNCj4+PiBpbiBhIHNldGdpZCBkaXJlY3RvcnkuIFRoaXMgaXMgYSBwcmVwYXJhdG9yeSBw
YXRjaCBmb3IgbW92aW5nIHNldGdpZA0KPj4+IHN0cmlwcGluZyBpbnRvIHRoZSB2ZnMuIFRoZSBw
YXRjaCBjb250YWlucyBubyBmdW5jdGlvbmFsIGNoYW5nZXMuDQo+Pj4NCj4+PiBDdXJyZW50bHkg
dGhlIHNldGdpZCBzdHJpcHBpbmcgbG9naWMgaXMgb3Blbi1jb2RlZCBkaXJlY3RseSBpbg0KPj4+
IGlub2RlX2luaXRfb3duZXIoKSBhbmQgdGhlIGluZGl2aWR1YWwgZmlsZXN5c3RlbXMgYXJlIHJl
c3BvbnNpYmxlIGZvcg0KPj4+IGhhbmRsaW5nIHNldGdpZCBpbmhlcml0YW5jZS4gU2luY2UgdGhp
cyBoYXMgcHJvdmVuIHRvIGJlIGJyaXR0bGUgYXMNCj4+PiBldmlkZW5jZWQgYnkgb2xkIGlzc3Vl
cyB3ZSB1bmNvdmVyZWQgb3ZlciB0aGUgbGFzdCBtb250aHMgKHNlZSBbMV0gdG8NCj4+PiBbM10g
YmVsb3cpIHdlIHdpbGwgdHJ5IHRvIG1vdmUgdGhpcyBsb2dpYyBpbnRvIHRoZSB2ZnMuDQo+Pg0K
Pj4gRmlyc3Qgb2YgYWxsLCBpbm9kZV9pbml0X293bmVyKCkgaXMgKGFuZCBhbHdheXMgaGFkIGJl
ZW4pIGFuIG9wdGlvbmFsIGhlbHBlci4NCj4+IEZpbGVzeXN0ZW1zIGFyZSAqTk9UKiByZXF1aXJl
ZCB0byBjYWxsIGl0LCBzbyBwdXR0aW5nIGFueSBjb21tb24gZnVuY3Rpb25hbGl0eQ0KPj4gaW4g
dGhlcmUgaGFkIGFsd2F5cyBiZWVuIGEgbWlzdGFrZS4NCj4+DQo+PiBUaGF0IGdvZXMgZm9yIGlu
b2RlX2ZzdWlkX3NldCgpIGFuZCBpbm9kZV9mc2dpZF9zZXQoKSBjYWxscyBhcyB3ZWxsLg0KPj4g
Q29uc2lkZXIgZS5nLiB0aGlzOg0KPj4gc3RydWN0IGlub2RlICpleHQyX25ld19pbm9kZShzdHJ1
Y3QgaW5vZGUgKmRpciwgdW1vZGVfdCBtb2RlLA0KPj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgY29uc3Qgc3RydWN0IHFzdHIgKnFzdHIpDQo+PiB7DQo+PiAJLi4uDQo+PiAgICAgICAg
ICBpZiAodGVzdF9vcHQoc2IsIEdSUElEKSkgew0KPj4gCQlpbm9kZS0+aV9tb2RlID0gbW9kZTsN
Cj4+IAkJaW5vZGUtPmlfdWlkID0gY3VycmVudF9mc3VpZCgpOw0KPj4gCQlpbm9kZS0+aV9naWQg
PSBkaXItPmlfZ2lkOw0KPj4gCX0gZWxzZQ0KPj4gCQlpbm9kZV9pbml0X293bmVyKCZpbml0X3Vz
ZXJfbnMsIGlub2RlLCBkaXIsIG1vZGUpOw0KPj4NCj4+IEhlcmUgd2UgaGF2ZSBhbiBleHBsaWNp
dCBtb3VudCBvcHRpb24sIHNlbGVjdGluZyB0aGUgd2F5IFNfSVNHSUQgb24gZGlyZWN0b3JpZXMN
Cj4+IGlzIGhhbmRsZWQuICBNb3VudCBleHQyIHdpdGggLW8gZ3JwaWQgYW5kIHNlZSBmb3IgeW91
cnNlbGYgLSBubyBpbm9kZV9pbml0X293bmVyKCkNCj4+IGNhbGxzIHRoZXJlLg0KPj4NCj4+IFRo
ZSBzYW1lIGdvZXMgZm9yIGV4dDQgLSB0aGF0IGNvZGUgaXMgY29waWVkIHRoZXJlIHVuY2hhbmdl
ZC4NCj4+DQo+PiBXaGF0J3MgbW9yZSwgSSdtIG5vdCBzdXJlIHRoYXQgSmFubidzIGZpeCBtYWRl
IGFueSBzZW5zZSBpbiB0aGUgZmlyc3QgcGxhY2UuDQo+PiBBZnRlciBhbGwsIHRoZSBmaWxlIGJl
aW5nIGNyZWF0ZWQgaGVyZSBpcyBlbXB0eTsgZXhlYyBvbiBpdCB3b24ndCBnaXZlIHlvdQ0KPj4g
YW55dGhpbmcgLSBpdCdsbCBzaW1wbHkgZmFpbC4gIEFuZCBtb2RpZnlpbmcgdGhhdCBmaWxlIG91
Z2h0IHRvIHN0cmlwIFNHSUQsDQo+PiBvciB3ZSBoYXZlIG11Y2ggbW9yZSBpbnRlcmVzdGluZyBw
cm9ibGVtcy4NCj4+DQo+PiBXaGF0IGFtIEkgbWlzc2luZyBoZXJlPw0KPg0KPiBCVFcsIHhmcyBo
YXMgZ3JwaWQgb3B0aW9uIGFzIHdlbGw6DQo+IAlpZiAoZGlyJiYgICEoZGlyLT5pX21vZGUmICBT
X0lTR0lEKSYmICB4ZnNfaGFzX2dycGlkKG1wKSkgew0KPiAJCWlub2RlX2ZzdWlkX3NldChpbm9k
ZSwgbW50X3VzZXJucyk7DQo+IAkJaW5vZGUtPmlfZ2lkID0gZGlyLT5pX2dpZDsNCj4gCQlpbm9k
ZS0+aV9tb2RlID0gbW9kZTsNCj4gCX0gZWxzZSB7DQo+IAkJaW5vZGVfaW5pdF9vd25lcihtbnRf
dXNlcm5zLCBpbm9kZSwgZGlyLCBtb2RlKTsNCj4gCX0NCj4NCj4gV2UgY291bGQgbGlmdCB0aGF0
IHN0dWZmIGludG8gVkZTLCBidXQgaXQgd291bGQgcmVxdWlyZSBsaWZ0aW5nIHRoYXQgZmxhZw0K
PiAoQlNEIHZzLiBTeXNWIGJlaGF2aW91ciB3cnQgR0lEIC0gQlNEICphbHdheXMqIGluaGVyaXRz
IEdJRCBmcm9tIHBhcmVudA0KPiBhbmQgaWdub3JlcyBTR0lEIG9uIGRpcmVjdG9yaWVzKSBpbnRv
IGdlbmVyaWMgc3VwZXJibG9jay4gIE90aGVyd2lzZSB3ZSdkDQo+IGJlIGJyZWFraW5nIGV4aXN0
aW5nIGJlaGF2aW91ciBmb3IgZXh0KiBhbmQgeGZzLi4uDQoNCkkgYWxzbyBtZW50aW9uZWQgaXQg
aW4gbXkgcHJldmlvdXMgdmVyc2lvbihpbiB0aGUgMy80IHBhdGNoKQ0KIlRoaXMgcGF0Y2ggYWxz
byBjaGFuZ2VkIGdycGlkIGJlaGF2aW91ciBmb3IgZXh0NC94ZnMgYmVjYXVzZSB0aGUgbW9kZSAN
CnBhc3NlZCB0byB0aGVtIG1heSBiZWVuIGNoYW5nZWQgYnkgdmZzX3ByZXBhcmVfbW9kZS4NCiIN
Cg0KSSBndWVzcyB3ZSBjYW4gYWRkIGEgIGdycGlkIG9wdGlvbiBjaGVjayBpbiB2ZnNfcHJlcGFy
ZV9tb2RlIG9yIGluIA0KbW9kZV9zdHJpcF9zZ2lkLCB0aGVuIGl0IHNob3VsZCBub3QgYnJlYWsg
dGhlIGV4aXN0aW5nIGJlaGF2aW91ciBmb3IgDQpleHQqIGFuZCB4ZnMuDQo=
