Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7395885E4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Aug 2022 04:43:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235573AbiHCCnc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 2 Aug 2022 22:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbiHCCna (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 2 Aug 2022 22:43:30 -0400
Received: from esa20.fujitsucc.c3s2.iphmx.com (esa20.fujitsucc.c3s2.iphmx.com [216.71.158.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A757E33348;
        Tue,  2 Aug 2022 19:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1659494610; x=1691030610;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=zbA4G50882MM4PQOyIZzcBckXMctGPKyd0qIrhk3sfU=;
  b=vxCI+mm8CXIEbIVjRsTdx8MSJjoy0YbhHenKT/QwgPsPZQL9phTKXA43
   amEYfPP6Hihuvi44x2+4DXf09vfH8WogEfoSp1WdVsvThYogd/oz6LVhv
   6T3P5L8fFuP2vjSEfSJ6V/K6J985qqxuDfej5k7gtR1Bt2ZifNDbmsqQa
   9xVasEHdkShaLO6CmRkDPMrf8KKu/4KtMd0xpipbvzIvk+3R4ijodhLLs
   7ndXUW/mEznLvDxXLq4jkw4hsLEqU/wiEVAzL36PuvCoJDHvGCfMygHyt
   FFNo/sdaeCvHKvEyvcohGy6kFQ1a8tlfn7wVAYiKLYioboI+RGmWZ9f9o
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="61864550"
X-IronPort-AV: E=Sophos;i="5.93,212,1654527600"; 
   d="scan'208";a="61864550"
Received: from mail-os0jpn01lp2111.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.111])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 11:43:24 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QiCa9gX/m/cQex3hfxdFutCRvIaE2xfgQpl8cJ1zByv3MbLxpFlvQCJSNX+ZVic+RU2E2qHdFHk8UA9sPIYDPz7nFKuphK1Mcg7FrWeJP+DzooYuEIDQeELNJnpcW4BaNno1p2RpXzNFxVKrX98KvfKjdwPPHKWMBfg5XavRzk5fKPs74wou8b1RslSjozdV+mfaIm8FWsq5J4m/USqiVPUYp9yYAp5CGz/Sk0lsXTCwUbaKapY1Z+ugQ/3VS368Tqg3lwPRawSX4QQNKTJ71qaWWpjHTFnJfDetVtE0xu5faXs+QhfR2J2n8H5nPFPvp3tA9hVLY7RYn8iHTVKwJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zbA4G50882MM4PQOyIZzcBckXMctGPKyd0qIrhk3sfU=;
 b=ZgFWnBya28Ci1wFY8/Jbk7FI7+RY9wg5gzi84IB0e4vrtlSOcCE+eo6xqgxBrPMvvDNNmCUTHb+ugD5R0yxIlrupzuH36huIRalYZY3MgrvSobI9ZoNttgjybsFJS87vXBCra9+yoWB9YujyUy7lx8iDPOhCpb0uM6cl5D27ttbv0AqlQsQGIBGcowmQD83+vhsDS0dkEnk80ogV1r8s+VyJWd6F0vmR2cSpMmQCXrEYd17XIz7MaPFPZkAW7KA6GdukLCOtYAoaOvW703JyhtOiZMGWBzMg/4v5+3lI0xxro6thenppf0d43X2mSzpAkwRYYHH+cIct5Z1Ma7La7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com (2603:1096:604:18::16)
 by OS3PR01MB5862.jpnprd01.prod.outlook.com (2603:1096:604:c2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.10; Wed, 3 Aug
 2022 02:43:20 +0000
Received: from OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca]) by OSBPR01MB2920.jpnprd01.prod.outlook.com
 ([fe80::7556:cf54:e9e1:28ca%7]) with mapi id 15.20.5482.016; Wed, 3 Aug 2022
 02:43:20 +0000
From:   "ruansy.fnst@fujitsu.com" <ruansy.fnst@fujitsu.com>
To:     Dan Williams <dan.j.williams@intel.com>,
        "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "jane.chu@oracle.com" <jane.chu@oracle.com>
Subject: Re: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Topic: [RFC PATCH v6] mm, pmem, xfs: Introduce MF_MEM_REMOVE for unbind
Thread-Index: AQHYl21MSZyYmdiLqka88bTs8k0Skq1+LkkAgAaKG4CAAAvzgIAX0fKA
Date:   Wed, 3 Aug 2022 02:43:20 +0000
Message-ID: <ef6fbc40-db59-eca5-e3e1-19f5809ec357@fujitsu.com>
References: <20220410171623.3788004-1-ruansy.fnst@fujitsu.com>
 <20220714103421.1988696-1-ruansy.fnst@fujitsu.com>
 <62d05eb8e663c_1643dc294fa@dwillia2-xfh.jf.intel.com.notmuch>
 <YtXbD4e8mLHqWSwL@magnolia>
 <62d5e515de3a_929192941e@dwillia2-xfh.jf.intel.com.notmuch>
In-Reply-To: <62d5e515de3a_929192941e@dwillia2-xfh.jf.intel.com.notmuch>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-08-03T02:43:19.482Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 43b556d4-499b-4f3d-bc84-08da74f9ed57
x-ms-traffictypediagnostic: OS3PR01MB5862:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: +vOojp2pUsdrY1HMsDlWC1kb6gEeLY/gcqaUcedjikeI+GWdSCp+H9mfB/Gri6jmlkBru+sEOGQaTD6ZMvw0Ppt+1rkUrRyeEj7o7tEMqBUHyADTQBU7nHcGL9I7dvs8D6u4za0JWz6ZMNHAvgl8eAgv/edI3jIhUfEo+xmnZOq8rYAvRqDD972xht198Q5ECPG0DwkzrbnFMv0E77azVE0kUjFJBZIoR+yqTbxbg05Sy7DgZUl2H8G9dOzMpTLiYsVljoXqXYoxytBxIhdmoui+OK7V5cFlnZZuYY0Sbwuf4jBplfWKMyznbfHamioBv7vHvpTe39IXt92Ocb18DgHy9Bl0WQVy5FQtXlzy1TM5vPsKCHetbHnNm/dvMQWFutnW/KcOBFSe/qdxz9iTpada6Mhxmfew0/KN3qxmewFRpZ0aK5DxYD4ars0ZFrOzb19mos0Fr2KZfg9/p6eLq8VjkMrUPn3Qn+PJR9Mron0Dj1OEEpz8EEgHu2cwZ5lcYTmKkYY2yvJ4p9CFqYldZrBcQg1MfPfm2fwqjf7c+VvN8ZyQ5r/2IFppmkK6He0n7rYR1t6Kagsej6aR7RNWfe3+ww5fb2stqP4W+8TUddmDbLi7S5KjmE6pcPXfJ7Oh2MvYMHJGKuM43W4hztISBgN7fPtqUU0dCkgK5DgMX38+fyNOZ1C2K98mlJ6ye2Uaeoc6F61U6yCThOjh2F44KJWi/1bdNkIJdD0JYL1XEHNgVfYGrjsDk+af+lw8Q9gPQosR2po98MXCYRIQLMzErgvcA+ZbkQd9M1pHOvvunYzDOED1qkF9zekpmu1i2sn6Do0IcqjPJBgZpvnpIWR8nTNhm5fbuqe9Achnkycs8mF+jPzNFSKSuO7qgYze0P0z1FgyHfbWJ+DK0LMX3pkBBQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSBPR01MB2920.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(366004)(376002)(39860400002)(136003)(346002)(36756003)(85182001)(316002)(122000001)(5660300002)(110136005)(31686004)(54906003)(64756008)(71200400001)(66446008)(66476007)(8676002)(38070700005)(76116006)(4326008)(66946007)(91956017)(66556008)(186003)(38100700002)(6486002)(966005)(2616005)(82960400001)(86362001)(478600001)(6512007)(31696002)(41300700001)(7416002)(8936002)(83380400001)(2906002)(6506007)(26005)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?WjZ1T1pJTG1QZ243OERzTE5jSTdRVUJFaUowSmZPQ0dERnJlaHVpZ3JlcnhP?=
 =?gb2312?B?ZzF0N1dRdVpXd3JtQmh6MHREOFJqZ2M5L0pYakM3Mk95dTd3SWc3VVUxcnR2?=
 =?gb2312?B?S0ZCWno3bHZ3ZjhqejV4ejJaZmtIVlVCdVgyd2FhYlYySW4wMXZSY09BZlM5?=
 =?gb2312?B?aWYvTHhGck4zNUdTbzJnV1ErcWJWYStGM1pOV2RKSjdLbXFTNDhuaEpVUEVr?=
 =?gb2312?B?My9IMU9JZjArRTY4KzRFQm0vSDc1K3cxTFN4M1JySmoyR2wwMXpFbEVqZTFp?=
 =?gb2312?B?ZC9paEFYU1RxSGVyUzBrN3JiTDlGS0tJNjlwSllJV3ViNHIrcnA5S0hLK01C?=
 =?gb2312?B?MWErNG9zWC9Bc0Fya3cwOXhGWmE0QUFGb2pvcjdIWUY4MEJ4L2dOc2pITlpG?=
 =?gb2312?B?U0ZnSjVYdXRZVTlacWJNOVhuMkIxSjFHMXo2b3pJNlN2cnlaQjlXTFFha1FV?=
 =?gb2312?B?TmtKZ0JKV3JLTU5zb1JoTDRHRG9lTjExWENQcnFtbldFVXpzY2ZqZUNnSXFq?=
 =?gb2312?B?clJvb0pMQWlyMjFYMnBYS21oMHNrMXNTMUIzR1NERDJVdTJaaS9xTmFDM2Z5?=
 =?gb2312?B?aDlCNHR6emdWbWJWelZQWE1GSmFwNUZEVm9sakZSWFVlNEVhSm5EME0wc1RV?=
 =?gb2312?B?Ni8wa0hVWHp6N0dGL0l2V2ozZGU0R3JsNHZwV3pWYzVPWU4reTA5S1hJOGg2?=
 =?gb2312?B?OXJUa01uS04wRHhuclc4dU5XUEhFR0JwTnpHL01IZ3hrSkhub0NZL004R0pv?=
 =?gb2312?B?Tnk5SUFEN3dTSk4zYnk4c2lTdTRHT24yekxLL08rVVlINUVyMnVBbTF1TGZV?=
 =?gb2312?B?Mi9Qc1NRTFZMdlJLczBvS25Lc2sxR3FVWlU2VmljVlJ3dDVHbkJlMzQ5eDVZ?=
 =?gb2312?B?c01Zc3NkWEhLRHl1WXZyME1LY2Y3eHR0Nk5wZm9BREd1Ui9tcXQ4YWdIamNV?=
 =?gb2312?B?eEZRNEFtbnpkNjJjTWw1L1dhNXpMQUZtdnE1YjBEbFd0RkwyYjdEdFNGcU5T?=
 =?gb2312?B?ZHNOMUlEQy9kaUtnNnJIRzJSUDdqSldmWkZ5S0grODljMmRJWFA1SWgzcEVJ?=
 =?gb2312?B?OFFHSGtXcG5ORmc0eFc3b21BVXFRQ0RHcDZNMnBjMlpYRjhJU3gzSTBuNjh5?=
 =?gb2312?B?STBISktvZlRaMm83ZEdsS3pndTQxTWNjNnZWeFNlQVZ5TmFRUjN6QnhRQ3FS?=
 =?gb2312?B?c2c4Uk80dlN5a3lGbWtpSGFBaWowSEFMbzc2SEcrazg1TDhMVTkyTDRtdUNM?=
 =?gb2312?B?M2piaGE3SllsM2dId3kwYkpQbC9KNk5KbXdYU0Z2dnNwRmxIZHE1V0tFNGxy?=
 =?gb2312?B?QmZUaEVQSnBobFIyWjRpNHYxZ3RQM3Z0d2FKWEV6OVJraE03Zks1aGlXS1Ry?=
 =?gb2312?B?MFJ4cVVlWHd0ajhiWi9nNjdlRVk5VGRnWDdPZkR5OVZjRDdWTFprTTIxa0Vo?=
 =?gb2312?B?R3VjZHlka3lzRWtrallGeHE5Nm16ZEdJYUcyU3NYQ3dVanB5aTdoQTNvbXps?=
 =?gb2312?B?UnRGOG05ZHpMYzNaRXFvZFVVWVNsWmsxQTdBbE5VQXVlOUhWTmljK2h3d0Z6?=
 =?gb2312?B?QnRUOGo1bGpRRkM2UGlSbGRJWis0Nzhvc3lBYk9OV0VTdWdkWHZkeER6VnZn?=
 =?gb2312?B?MVJ1NmxhZzFJZDRtV2pvcmk0UXdlTFh6U1Q5MmtYSFRhMjlwT1hYUmx5NG8v?=
 =?gb2312?B?RVQrbEJ4dFlTb1MxSjJReHAxQ0VjTHpxSG13THAvN1J0WnJobGtrMFNQU0U2?=
 =?gb2312?B?Q29NYWtSSXpkaXcxNlNHdzY5RFdWNUZmalN4Y3Q3RFlteEkzWmhuWHBjSElN?=
 =?gb2312?B?KzZDOFNCTlFRZGFPZ0xSMW5pa2lubjFOWXlhWlNBbm1lQ0dnYjU2V3pHeDJp?=
 =?gb2312?B?QStHOExid2dWNDcvNm05RTl0OTJFQXVLRUxYdnVZWFpxL2JqOThkQXdCTnpj?=
 =?gb2312?B?TngzNC95T0xjL1dDTFlEWHlxV1VxVzV3TFhHQWx0VWFvNFhoSlVnQURTbTdi?=
 =?gb2312?B?a2ZOYWYrQkJQTG9ITm9zVjlrRkgrMDV1c3ZzYW9mNHcrYzdkRXlud2ZKa1dS?=
 =?gb2312?B?MDRvVGpHOXZTUzFCR2dmMWUrczdZb09BVDJlbzRaWEI1dDlRSTljNi84SC9X?=
 =?gb2312?Q?/8brzyf4QDjFj7vVjPa6YEV61?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <39524FCAC9A7B640B9087DF7F1562C2C@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSBPR01MB2920.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43b556d4-499b-4f3d-bc84-08da74f9ed57
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Aug 2022 02:43:20.3350
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 79M9WotzuLREButnh68THCiKYJCXNUzai9B1Z8i4ShPSNJwN/zjFoZOm6IZY2xfW3fj+DVXKuIFJ/fHm/Gc8yw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB5862
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

CtTaIDIwMjIvNy8xOSA2OjU2LCBEYW4gV2lsbGlhbXMg0LS1wDoKPiBEYXJyaWNrIEouIFdvbmcg
d3JvdGU6Cj4+IE9uIFRodSwgSnVsIDE0LCAyMDIyIGF0IDExOjIxOjQ0QU0gLTA3MDAsIERhbiBX
aWxsaWFtcyB3cm90ZToKPj4+IHJ1YW5zeS5mbnN0QGZ1aml0c3UuY29tIHdyb3RlOgo+Pj4+IFRo
aXMgcGF0Y2ggaXMgaW5zcGlyZWQgYnkgRGFuJ3MgIm1tLCBkYXgsIHBtZW06IEludHJvZHVjZQo+
Pj4+IGRldl9wYWdlbWFwX2ZhaWx1cmUoKSJbMV0uICBXaXRoIHRoZSBoZWxwIG9mIGRheF9ob2xk
ZXIgYW5kCj4+Pj4gLT5ub3RpZnlfZmFpbHVyZSgpIG1lY2hhbmlzbSwgdGhlIHBtZW0gZHJpdmVy
IGlzIGFibGUgdG8gYXNrIGZpbGVzeXN0ZW0KPj4+PiAob3IgbWFwcGVkIGRldmljZSkgb24gaXQg
dG8gdW5tYXAgYWxsIGZpbGVzIGluIHVzZSBhbmQgbm90aWZ5IHByb2Nlc3Nlcwo+Pj4+IHdobyBh
cmUgdXNpbmcgdGhvc2UgZmlsZXMuCj4+Pj4KPj4+PiBDYWxsIHRyYWNlOgo+Pj4+IHRyaWdnZXIg
dW5iaW5kCj4+Pj4gICAtPiB1bmJpbmRfc3RvcmUoKQo+Pj4+ICAgIC0+IC4uLiAoc2tpcCkKPj4+
PiAgICAgLT4gZGV2cmVzX3JlbGVhc2VfYWxsKCkgICAjIHdhcyBwbWVtIGRyaXZlciAtPnJlbW92
ZSgpIGluIHYxCj4+Pj4gICAgICAtPiBraWxsX2RheCgpCj4+Pj4gICAgICAgLT4gZGF4X2hvbGRl
cl9ub3RpZnlfZmFpbHVyZShkYXhfZGV2LCAwLCBVNjRfTUFYLCBNRl9NRU1fUFJFX1JFTU9WRSkK
Pj4+PiAgICAgICAgLT4geGZzX2RheF9ub3RpZnlfZmFpbHVyZSgpCj4+Pj4KPj4+PiBJbnRyb2R1
Y2UgTUZfTUVNX1BSRV9SRU1PVkUgdG8gbGV0IGZpbGVzeXN0ZW0ga25vdyB0aGlzIGlzIGEgcmVt
b3ZlCj4+Pj4gZXZlbnQuICBTbyBkbyBub3Qgc2h1dGRvd24gZmlsZXN5c3RlbSBkaXJlY3RseSBp
ZiBzb21ldGhpbmcgbm90Cj4+Pj4gc3VwcG9ydGVkLCBvciBpZiBmYWlsdXJlIHJhbmdlIGluY2x1
ZGVzIG1ldGFkYXRhIGFyZWEuICBNYWtlIHN1cmUgYWxsCj4+Pj4gZmlsZXMgYW5kIHByb2Nlc3Nl
cyBhcmUgaGFuZGxlZCBjb3JyZWN0bHkuCj4+Pj4KPj4+PiA9PQo+Pj4+IENoYW5nZXMgc2luY2Ug
djU6Cj4+Pj4gICAgMS4gUmVuYW1lZCBNRl9NRU1fUkVNT1ZFIHRvIE1GX01FTV9QUkVfUkVNT1ZF
Cj4+Pj4gICAgMi4gaG9sZCBzX3Vtb3VudCBiZWZvcmUgc3luY19maWxlc3lzdGVtKCkKPj4+PiAg
ICAzLiBtb3ZlIHN5bmNfZmlsZXN5c3RlbSgpIGFmdGVyIFNCX0JPUk4gY2hlY2sKPj4+PiAgICA0
LiBSZWJhc2VkIG9uIG5leHQtMjAyMjA3MTQKPj4+Pgo+Pj4+IENoYW5nZXMgc2luY2UgdjQ6Cj4+
Pj4gICAgMS4gc3luY19maWxlc3lzdGVtKCkgYXQgdGhlIGJlZ2lubmluZyB3aGVuIE1GX01FTV9S
RU1PVkUKPj4+PiAgICAyLiBSZWJhc2VkIG9uIG5leHQtMjAyMjA3MDYKPj4+Pgo+Pj4+IFsxXTog
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtbW0vMTYxNjA0MDUwMzE0LjE0NjM3NDIuMTQx
NTE2NjUxNDAwMzU3OTU1NzEuc3RnaXRAZHdpbGxpYTItZGVzazMuYW1yLmNvcnAuaW50ZWwuY29t
Lwo+Pj4+Cj4+Pj4gU2lnbmVkLW9mZi1ieTogU2hpeWFuZyBSdWFuIDxydWFuc3kuZm5zdEBmdWpp
dHN1LmNvbT4KPj4+PiAtLS0KPj4+PiAgIGRyaXZlcnMvZGF4L3N1cGVyLmMgICAgICAgICB8ICAz
ICsrLQo+Pj4+ICAgZnMveGZzL3hmc19ub3RpZnlfZmFpbHVyZS5jIHwgMTUgKysrKysrKysrKysr
KysrCj4+Pj4gICBpbmNsdWRlL2xpbnV4L21tLmggICAgICAgICAgfCAgMSArCj4+Pj4gICAzIGZp
bGVzIGNoYW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPj4+Pgo+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL2RheC9zdXBlci5jIGIvZHJpdmVycy9kYXgvc3VwZXIuYwo+Pj4+
IGluZGV4IDliNWUyYTVlYjBhZS4uY2Y5YTY0NTYzZmJlIDEwMDY0NAo+Pj4+IC0tLSBhL2RyaXZl
cnMvZGF4L3N1cGVyLmMKPj4+PiArKysgYi9kcml2ZXJzL2RheC9zdXBlci5jCj4+Pj4gQEAgLTMy
Myw3ICszMjMsOCBAQCB2b2lkIGtpbGxfZGF4KHN0cnVjdCBkYXhfZGV2aWNlICpkYXhfZGV2KQo+
Pj4+ICAgCQlyZXR1cm47Cj4+Pj4gICAKPj4+PiAgIAlpZiAoZGF4X2Rldi0+aG9sZGVyX2RhdGEg
IT0gTlVMTCkKPj4+PiAtCQlkYXhfaG9sZGVyX25vdGlmeV9mYWlsdXJlKGRheF9kZXYsIDAsIFU2
NF9NQVgsIDApOwo+Pj4+ICsJCWRheF9ob2xkZXJfbm90aWZ5X2ZhaWx1cmUoZGF4X2RldiwgMCwg
VTY0X01BWCwKPj4+PiArCQkJCU1GX01FTV9QUkVfUkVNT1ZFKTsKPj4+PiAgIAo+Pj4+ICAgCWNs
ZWFyX2JpdChEQVhERVZfQUxJVkUsICZkYXhfZGV2LT5mbGFncyk7Cj4+Pj4gICAJc3luY2hyb25p
emVfc3JjdSgmZGF4X3NyY3UpOwo+Pj4+IGRpZmYgLS1naXQgYS9mcy94ZnMveGZzX25vdGlmeV9m
YWlsdXJlLmMgYi9mcy94ZnMveGZzX25vdGlmeV9mYWlsdXJlLmMKPj4+PiBpbmRleCA2OWQ5Yzgz
ZWE0YjIuLjZkYTY3NDc0MzVlYiAxMDA2NDQKPj4+PiAtLS0gYS9mcy94ZnMveGZzX25vdGlmeV9m
YWlsdXJlLmMKPj4+PiArKysgYi9mcy94ZnMveGZzX25vdGlmeV9mYWlsdXJlLmMKPj4+PiBAQCAt
NzYsNiArNzYsOSBAQCB4ZnNfZGF4X2ZhaWx1cmVfZm4oCj4+Pj4gICAKPj4+PiAgIAlpZiAoWEZT
X1JNQVBfTk9OX0lOT0RFX09XTkVSKHJlYy0+cm1fb3duZXIpIHx8Cj4+Pj4gICAJICAgIChyZWMt
PnJtX2ZsYWdzICYgKFhGU19STUFQX0FUVFJfRk9SSyB8IFhGU19STUFQX0JNQlRfQkxPQ0spKSkg
ewo+Pj4+ICsJCS8qIERvIG5vdCBzaHV0ZG93biBzbyBlYXJseSB3aGVuIGRldmljZSBpcyB0byBi
ZSByZW1vdmVkICovCj4+Pj4gKwkJaWYgKG5vdGlmeS0+bWZfZmxhZ3MgJiBNRl9NRU1fUFJFX1JF
TU9WRSkKPj4+PiArCQkJcmV0dXJuIDA7Cj4+Pj4gICAJCXhmc19mb3JjZV9zaHV0ZG93bihtcCwg
U0hVVERPV05fQ09SUlVQVF9PTkRJU0spOwo+Pj4+ICAgCQlyZXR1cm4gLUVGU0NPUlJVUFRFRDsK
Pj4+PiAgIAl9Cj4+Pj4gQEAgLTE3NCwxMiArMTc3LDIyIEBAIHhmc19kYXhfbm90aWZ5X2ZhaWx1
cmUoCj4+Pj4gICAJc3RydWN0IHhmc19tb3VudAkqbXAgPSBkYXhfaG9sZGVyKGRheF9kZXYpOwo+
Pj4+ICAgCXU2NAkJCWRkZXZfc3RhcnQ7Cj4+Pj4gICAJdTY0CQkJZGRldl9lbmQ7Cj4+Pj4gKwlp
bnQJCQllcnJvcjsKPj4+PiAgIAo+Pj4+ICAgCWlmICghKG1wLT5tX3NiLnNiX2ZsYWdzICYgU0Jf
Qk9STikpIHsKPj4+PiAgIAkJeGZzX3dhcm4obXAsICJmaWxlc3lzdGVtIGlzIG5vdCByZWFkeSBm
b3Igbm90aWZ5X2ZhaWx1cmUoKSEiKTsKPj4+PiAgIAkJcmV0dXJuIC1FSU87Cj4+Pj4gICAJfQo+
Pj4+ICAgCj4+Pj4gKwlpZiAobWZfZmxhZ3MgJiBNRl9NRU1fUFJFX1JFTU9WRSkgewo+Pj4+ICsJ
CXhmc19pbmZvKG1wLCAiZGV2aWNlIGlzIGFib3V0IHRvIGJlIHJlbW92ZWQhIik7Cj4+Pj4gKwkJ
ZG93bl93cml0ZSgmbXAtPm1fc3VwZXItPnNfdW1vdW50KTsKPj4+PiArCQllcnJvciA9IHN5bmNf
ZmlsZXN5c3RlbShtcC0+bV9zdXBlcik7Cj4+Pj4gKwkJdXBfd3JpdGUoJm1wLT5tX3N1cGVyLT5z
X3Vtb3VudCk7Cj4+Pgo+Pj4gQXJlIGFsbCBtYXBwaW5ncyBpbnZhbGlkYXRlZCBhZnRlciB0aGlz
IHBvaW50Pwo+Pgo+PiBObzsgYWxsIHRoaXMgc3RlcCBkb2VzIGlzIHB1c2hlcyBkaXJ0eSBmaWxl
c3lzdGVtIFttZXRhXWRhdGEgdG8gcG1lbQo+PiBiZWZvcmUgd2UgbG9zZSBEQVhERVZfQUxJVkUu
Li4KPj4KPj4+IFRoZSBnb2FsIG9mIHRoZSByZW1vdmFsIG5vdGlmaWNhdGlvbiBpcyB0byBpbnZh
bGlkYXRlIGFsbCBEQVggbWFwcGluZ3MKPj4+IHRoYXQgYXJlIG5vIHBvaW50aW5nIHRvIHBmbnMg
dGhhdCBkbyBub3QgZXhpc3QgYW55bW9yZSwgc28ganVzdCBzeW5jaW5nCj4+PiBkb2VzIG5vdCBz
ZWVtIGxpa2UgZW5vdWdoLCBhbmQgdGhlIHNodXRkb3duIGlzIHNraXBwZWQgYWJvdmUuIFdoYXQg
YW0gSQo+Pj4gbWlzc2luZz8KPj4KPj4gLi4uaG93ZXZlciwgdGhlIHNodXRkb3duIGFib3ZlIG9u
bHkgYXBwbGllcyB0byBmaWxlc3lzdGVtIG1ldGFkYXRhLiAgSW4KPj4gZWZmZWN0LCB3ZSBhdm9p
ZCB0aGUgZnMgc2h1dGRvd24gaW4gTUZfTUVNX1BSRV9SRU1PVkUgbW9kZSwgd2hpY2gKPj4gZW5h
YmxlcyB0aGUgbWZfZGF4X2tpbGxfcHJvY3MgY2FsbHMgdG8gcHJvY2VlZCBhZ2FpbnN0IG1hcHBl
ZCBmaWxlIGRhdGEuCj4+IEkgaGF2ZSBhIG5hZ2dpbmcgc3VzcGljaW9uIHRoYXQgaW4gbm9uLVBS
RVJFTU9WRSBtb2RlLCB3ZSBjYW4gZW5kIHVwCj4+IHNodXR0aW5nIGRvd24gdGhlIGZpbGVzeXRl
bSBvbiBhbiB4YXR0ciBibG9jayBhbmQgdGhlICdyZXR1cm4KPj4gLUVGU0NPUlJVUFRFRCcgYWN0
dWFsbHkgcHJldmVudHMgdXMgZnJvbSByZWFjaGluZyBhbGwgdGhlIHJlbWFpbmluZyBmaWxlCj4+
IGRhdGEgbWFwcGluZ3MuCj4+Cj4+IElPV3MsIEkgdGhpbmsgdGhhdCBjbGF1c2UgYWJvdmUgcmVh
bGx5IG91Z2h0IHRvIGhhdmUgcmV0dXJuZWQgemVybyBzbwo+PiB0aGF0IHdlIGtlZXAgdGhlIGZp
bGVzeXN0ZW0gdXAgd2hpbGUgd2UncmUgdGVhcmluZyBkb3duIG1hcHBpbmdzLCBhbmQKPj4gb25s
eSBjYWxsIHhmc19mb3JjZV9zaHV0ZG93bigpIGFmdGVyIHdlJ3ZlIGhhZCBhIGNoYW5jZSB0byBs
ZXQKPj4geGZzX2RheF9ub3RpZnlfZGRldl9mYWlsdXJlKCkgdGVhciBkb3duIGFsbCB0aGUgbWFw
cGluZ3MuCj4+Cj4+IEkgbWlzc2VkIHRoYXQgc3VidGxldHkgaW4gdGhlIGluaXRpYWwgfjMwIHJv
dW5kcyBvZiByZXZpZXcsIGJ1dCBJIGZpZ3VyZQo+PiBhdCB0aGlzIHBvaW50IGxldCdzIGp1c3Qg
bGFuZCBpdCBpbiA1LjIwIGFuZCBjbGVhbiB1cCB0aGF0IHF1aXJrIGZvcgo+PiAtcmMxLgo+IAo+
IFN1cmUsIHRoaXMgaXMgYSBnb29kIGJhc2VsaW5lIHRvIGluY3JlbWVudGFsbHkgaW1wcm92ZS4K
CkhpIERhbiwgRGFycmljawoKRG8gSSBuZWVkIHRvIGZpeCBzb21ld2hlcmUgb24gdGhpcyBwYXRj
aD8gIEknbSBub3Qgc3VyZSBpZiBpdCBpcyBsb29rZWQgZ29vZC4uLgoKCi0tClRoYW5rcywKUnVh
bi4KCj4gCj4+Cj4+PiBOb3RpY2UgdGhhdCBraWxsX2Rldl9kYXgoKSBkb2VzIHVubWFwX21hcHBp
bmdfcmFuZ2UoKSBhZnRlciBpbnZhbGlkYXRpbmcKPj4+IHRoZSBkYXggZGV2aWNlIGFuZCB0aGF0
IGVuc3VyZXMgdGhhdCBhbGwgZXhpc3RpbmcgbWFwcGluZ3MgYXJlIGdvbmUgYW5kCj4+PiBjYW5u
b3QgYmUgcmUtZXN0YWJsaXNoZWQuIEFzIGZhciBhcyBJIGNhbiBzZWUgYSBwcm9jZXNzIHdpdGgg
YW4gZXhpc3RpbmcKPj4+IGRheCBtYXBwaW5nIHdpbGwgc3RpbGwgYmUgYWJsZSB0byB1c2UgaXQg
YWZ0ZXIgdGhpcyBydW5zLCBubz8KPj4KPj4gSSdtIG5vdCBzdXJlIHdoZXJlIGluIGFrcG0ncyB0
cmVlIEkgZmluZCBraWxsX2Rldl9kYXgoKT8gIEknbSBjcmliYmluZwo+PiBvZmYgb2Y6Cj4+Cj4+
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L2FrcG0vbW0u
Z2l0L3RyZWUvZnMveGZzL3hmc19ub3RpZnlfZmFpbHVyZS5jP2g9bW0tc3RhYmxlCj4gCj4gaHR0
cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvYWtwbS9tbS5naXQv
dHJlZS9kcml2ZXJzL2RheC9idXMuYz9oPW1tLXN0YWJsZSNuMzgxCj4gCj4gV2hlcmUgdGhlIG9i
c2VydmF0aW9uIGlzIHRoYXQgd2hlbiBkZXZpY2UtZGF4IGlzIHRvbGQgdGhhdCB0aGUgZGV2aWNl
IGlzCj4gZ29pbmcgYXdheSBpdCBpbnZhbGlkYXRlcyBhbGwgdGhlIGFjdGl2ZSBtYXBwaW5ncyB0
byB0aGF0IHNpbmdsZQo+IGNoYXJhY3Rlci1kZXZpY2UtaW5vZGUuIFRoZSBob3BlIGJlaW5nIHRo
YXQgaW4gdGhlIGZzZGF4IGNhc2UgYWxsIHRoZQo+IGRheC1tYXBwZWQgZmlsZXN5c3RlbSBpbm9k
ZXMgd291bGQgZXhwZXJpZW5jZSB0aGUgc2FtZSBpcnJldmVyc2libGUKPiBpbnZhbGlkYXRpb24g
YXMgdGhlIGRldmljZSBpcyBleGl0aW5nLgo=
