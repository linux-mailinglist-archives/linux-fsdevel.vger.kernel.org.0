Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BBD74ED16A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 31 Mar 2022 03:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352382AbiCaBw7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 30 Mar 2022 21:52:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350934AbiCaBw4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 30 Mar 2022 21:52:56 -0400
X-Greylist: delayed 63 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 30 Mar 2022 18:51:09 PDT
Received: from esa6.fujitsucc.c3s2.iphmx.com (esa6.fujitsucc.c3s2.iphmx.com [68.232.159.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED78B48E5D;
        Wed, 30 Mar 2022 18:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648691470; x=1680227470;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=uolfkf7Vazt80IsMaYNkUaUzUcpmZGrjfmx6gnC9/m0=;
  b=rjZsPLx1MS23t5YY+4UwsEaFdD/WL7/DyMvMWaya6yakcVFS6MquOn0Q
   tDXsxTIGuBDWzRo2DYZ31dYz8rNHRpy7rP4rYqIbJrySoHfGnPMRm5JVU
   jzttRFLAA0Y0sQ4bh1dWRx/hNJe2RqgPY0MQadh2/s6i33sNgunjCxfOm
   YYtKPrza6yQMjtmoFkD8V5RGdlz5NjkXwiXDEQqjaCr125GTnsRbFro6/
   4HvM8f9InSrB2qNn7cR1XSfpuuW0nDXX0GQEoLBpUMu4fh6gH67kt3QGe
   SL6spWvUpEy2dUT5ixNxh6Fr903J5a8otnNw/rKWbTlqR7c6lSWyuaTFg
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10302"; a="52925849"
X-IronPort-AV: E=Sophos;i="5.90,224,1643641200"; 
   d="scan'208";a="52925849"
Received: from mail-os0jpn01lp2106.outbound.protection.outlook.com (HELO JPN01-OS0-obe.outbound.protection.outlook.com) ([104.47.23.106])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2022 10:50:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MnCuUJErncBOuW8jjQwDKdwfF4MnCXi3CYzhl82Aszq8KRCvIbJRjV7ChRQXQ9z7vn+ltsS1TXWdi/sdmh8fw7HWCCC1M3Rj2H7tNyG8ZFOs/ncgH2X2XiE/p1QH31dn4/nI7HFZHX5NQm0CUmhAC54aNNC2Y6wA1z7T3nploQ1agV5wkBSMoQd8iMV4Yw8NF83X2M97TBWMN/3O+BNaQhXEB0oT9kZ4sw1C9CbnyI6ybTlVIMmYFzS310Z0CPK7RSDEDjfCh3brubeEAGi9ciZbuso08GUaKCwFE8bqV3AYoAyZsVqhMFIbbvJZ3DhyAWtId0bSLel9rSGRrUox/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uolfkf7Vazt80IsMaYNkUaUzUcpmZGrjfmx6gnC9/m0=;
 b=fGE2el970PYB5CC+uXq40su5iRq72Vea0MpYEQneAZL9Tle0rFdRxbfOS2cK1g6Ar0GMVtFWzbbflnOC9Y6wpIOnU+S8v4/A7RqOiPJWGhr5dXPhMPrIDDe/DfPg3rynMe3VpRVC76CKPr4EDPAj59sxlodpie+9TTaMAiYuranB2AIx5IWNqDItoNS0ASKG4p4O4AYAnjnfHtMudoTZVcXFmmf0CUC07CKHv5WxsBuGQDVAc+cYimmsiRIEwzWZ9tTBbSmCULP70tWOyLr4NgI5b6AE4AcxJicVwYRrtUv+qvFb7oUubC/UlvU2fmsXAkVv0httioaAiCzyf5MdfA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uolfkf7Vazt80IsMaYNkUaUzUcpmZGrjfmx6gnC9/m0=;
 b=UP2vonr22f7Y597ivmxFXXjPqtlC0wVDmiPAIDyTjXaGo4GNV+O/y7G/68ms+x01D3c1Rk/Gah6z9mJGR8WHIqZe6xO6umI9eKqGredpO7V+lyzUJOoBfbNoxx8awf63MJU+zkXJj9z0iE1ni5/5rjzuzdIrk9uMh6ulrMCEdjE=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB1665.jpnprd01.prod.outlook.com (2603:1096:603:2c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 31 Mar
 2022 01:49:59 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.023; Thu, 31 Mar 2022
 01:49:59 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v1 1/3] vfs: Add inode_sgid_strip() api
Thread-Topic: [PATCH v1 1/3] vfs: Add inode_sgid_strip() api
Thread-Index: AQHYQooYC36Pqg2UwEauSQSyjaaA9KzYIwWAgACbWQA=
Date:   Thu, 31 Mar 2022 01:49:59 +0000
Message-ID: <624508F0.4040407@fujitsu.com>
References: <1648461389-2225-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220330163439.GB27649@magnolia>
In-Reply-To: <20220330163439.GB27649@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aec51f4c-b9c9-489f-1702-08da12b8c3d8
x-ms-traffictypediagnostic: OSAPR01MB1665:EE_
x-microsoft-antispam-prvs: <OSAPR01MB1665529F954A0F669951565DFDE19@OSAPR01MB1665.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: JteHgrp8MDjLcuUxD40ywKqyGZDWeeu/Ug9MtkIe1bpbGuPY8t2f22Js+IWsZvSO6eHH//Bo6L/MPyCjS+P1LyrusscSnT+/QFF58qT9xmr3TzhVeQC1Au3Ma+uJOA65VpRdp96mupL2egqa1/XFewa9R39uZ6/2Z6f83PNZawX7QY9tebCE8d6s3gfSet6KqP/AYUwItql7NeiJdyztwaOLMBHFcLzbMKzHreXnwOJH8b+4xOg05lo0pIeDnIlh1xx5KyReF0zLODoDGXVqNKZfwk65b3hSlw6hgvWkp+lLmvANaU6p7wX8d9LRJRzMYZx2u4XKMzXRGwpkHwG1Ws+Y1hwmsWobmhdUPeh+WxM1/djyJheVDw0WYaPaj3IVYPKEWEe6gRu4QID7p22avJ85+SWmnKhGFVZ2YgE3Y624PuZreTdLNh1X8dafqky9OvAhx46dKcfDmC/oaEqGwtTt5ENuwv3LqoTKrR9h+JSwkk6yMzQIv/HqwpFMeVUYdgmwq9/8OYFQhNtV8pJNp/GHZXlS4+oiA4mH3zXfG4Y/sDVzBlbm4+YhZTYXg1onyDkyEyf6F4MCC7irdYid2YT9hRKSZgOX/kvZf2u9xb0nXSTTGv8cdlPyBulFfr5rLMhiK2/xktRUypyD2IRb6AgORbUaCFCDsz9WqXBTnHUsPvJorhEeRNrGx0ShPxwFV90M9GLqF3+4JVxXnnpdAg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(2616005)(87266011)(8936002)(6486002)(6512007)(508600001)(38100700002)(2906002)(6506007)(122000001)(82960400001)(86362001)(5660300002)(316002)(186003)(26005)(8676002)(83380400001)(76116006)(66946007)(66476007)(66556008)(36756003)(85182001)(91956017)(64756008)(66446008)(38070700005)(54906003)(71200400001)(4326008)(6916009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?cG1aazZpRkZoOVBydEppS0RPbkQ3SnU5cFpSZ2F0aFppRHBmdEYvMUxZOTZ5?=
 =?gb2312?B?R2MzNXlYTk5WNE5BMmhUbnBoNUpJNUlCMXlpTGtrWTdWK3hsR2VETDdEeHRF?=
 =?gb2312?B?aHBFVGlFYXVsbkE5OHRxNFE3czFoYkpvZXlsa0hVVEE4RkhmQklkS0doUDJ6?=
 =?gb2312?B?NitJdkRqUm9BTVVKL1lId2h0RHVoT3RDSTdYTXFCNlJGZDIvU0pTdEJmSHc1?=
 =?gb2312?B?em0wSHZ0cElRNjdIbFgxTDB1ZmpQc3lHK3pHalFGbGpOL01DQW14c0YxUWhG?=
 =?gb2312?B?am1oRlFPL1ZFZ2gyeXdFazhFN3hmQ1NldFNRY3FwR0xyUWxxOW5Cc1g0M0ph?=
 =?gb2312?B?NGRuV0xib0U5MnBXRW1pYlM0akVpSUdobnVoeXpib09Fc2NLVXRRSEtDaVZ0?=
 =?gb2312?B?NTk0dUVTYmROcUJRelFBU21xZ0ZRamx2WlZoVm16ZzkyZGhGU0YxRDRON3Rl?=
 =?gb2312?B?dVBpTVZsaUVuVmErbkwxMFVNSDJhN0ZOQkNBR2V4TTVQTUtrWjYxbGk2WSsy?=
 =?gb2312?B?OUlYY2xtREdyNkZKakFaeGxhUENlMTc4dHdNSERsczRaRzBWc3RuRzdvVisw?=
 =?gb2312?B?Q0hCMG9uelNRVUlJaEM1ekxwVjVkMGZETWh6UnNoU096RmNKTjkxUnMya1RK?=
 =?gb2312?B?VitrZG9ZTC9tOU5vOE1Td3lZdzJjZC85VXNpYVg5aXVRRkJOMENEeUkvUHJL?=
 =?gb2312?B?WUlvOXZSNnNPOFZvVE1FZ2FKSExoWUs5Mzg5Z2krWkhhMHUxdkNDSUdUN3px?=
 =?gb2312?B?NWxPUTc1QlNEQUI2UEhyRC9yR2c4WGpORS90NUU4TG1RMGxvM3Ezd1dRYVBW?=
 =?gb2312?B?ZzhsM05mU0UzNVkrRGJyeWhlczZhaVdiR2RrUGZwSGlxVUtWdlhpUFJMUklF?=
 =?gb2312?B?aDJnMkMyNklBdjI0dkZXUHVtZ1AvUXdoblB2cW51S1djeUxoRjdHaHRyTjYr?=
 =?gb2312?B?bzdDL25abTN1K1hQMEExVEpKR21hL1dPbENmUkgraE9yNnFWSHhML3BKbEJw?=
 =?gb2312?B?TmROS0lRR1N1UjVsdEtETkhDeExpOUQ2UlNVb2RyUkROUHBnYXBBQytlejRs?=
 =?gb2312?B?UGdnWnRka1NpdVMvL0tPY0JSbytMUHFQcW1welVOb3doWklraTBNdFhQWTla?=
 =?gb2312?B?UThyeW9HeUZ6TTc5RDRGL25uN25JeG53NUpZS2hjRFY0TDRUSUQyd0RIVmJ3?=
 =?gb2312?B?TUozODlOTDlEUmh2TURsMmlQb0FMd203K2dqdjhUUThFemZOKzdjMVh6eFhP?=
 =?gb2312?B?aEg4akQvR3pBK0NNUGZlVW9FWDVvUGR2dEM4aDVQWVVuU1FFVXpIWThxa3RS?=
 =?gb2312?B?Z0RRTlc2SCt6N0RXbE5GMUNmZ0NNRFZDQmlCSGxXbGt2dWVmV3RJeUE5MkVJ?=
 =?gb2312?B?NDZjd0J4NEVTZXJUbzRUUEFQS0pHemJKTWhQc0lzenFFOTdMbXkySW5kd2dP?=
 =?gb2312?B?SFBUV1FpRXJaMUhmQUNsSURaTkREWmZhMStCMGwvNHVJV3F3ZTc3SlJlem1q?=
 =?gb2312?B?eFhMZ1ZCQ1Y3TlJVT3dPTXFpSzVTSW5wenNrM0dOVnEydEtyM281bThFQW5M?=
 =?gb2312?B?ekZkRml2anI3ZkZYRlQ2VmhKbWNGeTRFNCswWkRFZGxzOFBKVVZJeWpQUERU?=
 =?gb2312?B?NkFIakEyVTdTa2poUTVnbHhPakY0dTBPYTJnNE5qdTNCRzQwTGZBeE40aVNj?=
 =?gb2312?B?MjNnZVBUMG5rNjRreW16NTdja1Zldi9FekZLM1dnenRkbmhpNjFkM2pQMnVz?=
 =?gb2312?B?VktLa1RFL2EvZWtQRklQTEpTcmN0ak5nTnE1ZE5CMFRPNm1tbXBiMGE0cjlO?=
 =?gb2312?B?ZUdtTzEyMXNXRW1OeXFJMlZvMXE5R1ZLTlhBVnluY2cwcWhHMklqdkVkeS9O?=
 =?gb2312?B?c3JicStrOG1qVjRSSUdrQWVGUmZCb1BXM3pBNWk0Q0FvU0RVY3FCK3Vzenpy?=
 =?gb2312?B?cHJOdk1ZZTlFcW8xM3hEeE8vaUtuU3ZLNXVXRm9lRVZDUDRmcVhTOEVnZXRV?=
 =?gb2312?B?U0xrbFkzMEpad2NlUncwcGZ0eUp5WTZQTTRsa3lQa3BQVkpLSDJtd2hHVWIw?=
 =?gb2312?B?NndPTjNMNWtSSVkxSXJMZVBIalBxMDFMK05XSXdwcU90OTFFd2lZejhxd0Iy?=
 =?gb2312?B?WWRVK1pOaXUxazVHanM1Zkk3cFNneVFwNFNtcG5SOGp5V2lEZ0ttM0VINGNG?=
 =?gb2312?B?RGJuUnFHY0ZObnRQcUJHcHRsdmI4S01jUDBmc2dnNHQwQ1dqbXhFaGZIaW4x?=
 =?gb2312?B?bDdkTVhQYTZCdkJMRE13MDY4b016M0FBUzg0ZDBVUkQ4ZXY3bFJ4dDVGMXd2?=
 =?gb2312?B?Rm5SZDFWdHFJTlpOR1NPdy94NHdwcmpzMmt3T04reFRrbUVjWUxyRnRRSEh5?=
 =?gb2312?Q?TM5nOSCiYuuBhDSjHWcKinzqI06eqsmqITXDQ?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <B501650C12448440A400BC32B029636B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aec51f4c-b9c9-489f-1702-08da12b8c3d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Mar 2022 01:49:59.4722
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MBMLF/TCL7i0LgeAx7XSs2u0HVMm7CyJ/DGMLK/72WtPczgBiJ9QtRLHC35tUW+JgfLS31CMhCfO9s90hczMqBBKqw0TQtXOrqByv8eXX+Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB1665
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi8zLzMxIDA6MzQsIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gT24gTW9uLCBNYXIg
MjgsIDIwMjIgYXQgMDU6NTY6MjdQTSArMDgwMCwgWWFuZyBYdSB3cm90ZToNCj4+IGlub2RlX3Nn
aWRfc3RyaXAoKSBmdW5jdGlvbiBpcyB1c2VkIHRvIHN0cmlwIFNfSVNHSUQgbW9kZQ0KPj4gd2hl
biBjcmVhdC9vcGVuL21rbm9kIGZpbGUuDQo+Pg0KPj4gU3VnZ2VzdGVkLWJ5OiBEYXZlIENoaW5u
ZXI8ZGF2aWRAZnJvbW9yYml0LmNvbT4NCj4+IFNpZ25lZC1vZmYtYnk6IFlhbmcgWHU8eHV5YW5n
MjAxOC5qeUBmdWppdHN1LmNvbT4NCj4+IC0tLQ0KPj4gICBmcy9pbm9kZS5jICAgICAgICAgfCAx
MiArKysrKysrKysrKysNCj4+ICAgaW5jbHVkZS9saW51eC9mcy5oIHwgIDMgKysrDQo+PiAgIDIg
ZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKQ0KPj4NCj4+IGRpZmYgLS1naXQgYS9mcy9p
bm9kZS5jIGIvZnMvaW5vZGUuYw0KPj4gaW5kZXggNjMzMjRkZjZmYTI3Li4xZjk2NGU3Zjk2OTgg
MTAwNjQ0DQo+PiAtLS0gYS9mcy9pbm9kZS5jDQo+PiArKysgYi9mcy9pbm9kZS5jDQo+PiBAQCAt
MjQwNSwzICsyNDA1LDE1IEBAIHN0cnVjdCB0aW1lc3BlYzY0IGN1cnJlbnRfdGltZShzdHJ1Y3Qg
aW5vZGUgKmlub2RlKQ0KPj4gICAJcmV0dXJuIHRpbWVzdGFtcF90cnVuY2F0ZShub3csIGlub2Rl
KTsNCj4+ICAgfQ0KPj4gICBFWFBPUlRfU1lNQk9MKGN1cnJlbnRfdGltZSk7DQo+PiArDQo+PiAr
dm9pZCBpbm9kZV9zZ2lkX3N0cmlwKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywg
c3RydWN0IGlub2RlICpkaXIsDQo+PiArCQkgICAgICB1bW9kZV90ICptb2RlKQ0KPj4gK3sNCj4+
ICsJaWYgKChkaXImJiAgZGlyLT5pX21vZGUmICBTX0lTR0lEKSYmDQo+PiArCQkoKm1vZGUmICAo
U19JU0dJRCB8IFNfSVhHUlApKSA9PSAoU19JU0dJRCB8IFNfSVhHUlApJiYNCj4+ICsJCSFTX0lT
RElSKCptb2RlKSYmDQo+PiArCQkhaW5fZ3JvdXBfcChpX2dpZF9pbnRvX21udChtbnRfdXNlcm5z
LCBkaXIpKSYmDQo+PiArCQkhY2FwYWJsZV93cnRfaW5vZGVfdWlkZ2lkKG1udF91c2VybnMsIGRp
ciwgQ0FQX0ZTRVRJRCkpDQo+PiArCQkqbW9kZSY9IH5TX0lTR0lEOw0KPg0KPiBBIGNvdXBsZSBv
ZiBzdHlsZSBuaXRzIGhlcmU6DQo+DQo+IFRoZSBzZWNvbmRhcnkgaWYgdGVzdCBjbGF1c2VzIGhh
dmUgdGhlIHNhbWUgaW5kZW50YXRpb24gbGV2ZWwgYXMgdGhlDQo+IGNvZGUgdGhhdCBhY3R1YWxs
eSBnZXRzIGV4ZWN1dGVkLCB3aGljaCBtYWtlcyB0aGlzIGhhcmRlciB0byBzY2FuDQo+IHZpc3Vh
bGx5Lg0KPg0KPiAJaWYgKChkaXImJiAgZGlyLT5pX21vZGUmICBTX0lTR0lEKSYmDQo+IAkoKm1v
ZGUmICAoU19JU0dJRCB8IFNfSVhHUlApKSA9PSAoU19JU0dJRCB8IFNfSVhHUlApJiYNCj4gCSFT
X0lTRElSKCptb2RlKSYmDQo+IAkhaW5fZ3JvdXBfcChpX2dpZF9pbnRvX21udChtbnRfdXNlcm5z
LCBkaXIpKSYmDQo+IAkhY2FwYWJsZV93cnRfaW5vZGVfdWlkZ2lkKG1udF91c2VybnMsIGRpciwg
Q0FQX0ZTRVRJRCkpDQo+IAkJKm1vZGUmPSB+U19JU0dJRDsNCj4NCj4gQWx0ZXJuYXRlbHksIHlv
dSBjb3VsZCB1c2UgaW52ZXJzZSBsb2dpYyB0byBiYWlsIG91dCBlYXJseToNCj4NCj4gdm9pZCBp
bm9kZV9zZ2lkX3N0cmlwKHN0cnVjdCB1c2VyX25hbWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0
IGlub2RlICpkaXIsDQo+IAkJICAgICAgdW1vZGVfdCAqbW9kZSkNCj4gew0KPiAJaWYgKCFkaXIg
fHwgIShkaXItPmlfbW9kZSYgIFNfSVNHSUQpKQ0KPiAJCXJldHVybjsNCj4gCWlmIChTX0lTRElS
KCptb2RlKSkNCj4gCQlyZXR1cm47DQo+IAlpZiAoaW5fZ3JvdXBfcCguLi4pKQ0KPiAJCXJldHVy
bjsNCj4gCWlmIChjYXBhYmxlX3dydF9pbm9kZV91aWRnaWQoLi4uKSkNCj4gCQlyZXR1cm47DQo+
DQo+IAkqbW9kZSY9IH5TX0lTR0lEOw0KPiB9DQo+DQo+IFRob3VnaCBJIHN1cHBvc2UgdGhhdCAv
aXMvIG11Y2ggbG9uZ2VyLg0KPg0KPiBUaGUgYmlnZ2VyIHRoaW5nIGhlcmUgaXMgdGhhdCBJJ2Qg
bGlrZSB0byBzZWUgdGhpcyBwYXRjaCBob2lzdCB0aGUgSVNHSUQNCj4gc3RyaXBwaW5nIGNvZGUg
b3V0IG9mIGluaXRfaW5vZGVfb3duZXIgc28gdGhhdCBpdCdzIGVhc2llciB0byB2ZXJpZnkNCj4g
dGhhdCB0aGUgbmV3IGhlbHBlciBkb2VzIGV4YWN0bHkgdGhlIHNhbWUgdGhpbmcgYXMgdGhlIG9s
ZCBjb2RlLiAgVGhlDQo+IHNlY29uZCBwYXRjaCB3b3VsZCB0aGVuIGFkZCBjYWxsc2l0ZXMgYXJv
dW5kIHRoZSBWRlMgYXMgbmVjZXNzYXJ5IHRvDQo+IHByZXZlbnQgdGhpcyBwcm9ibGVtIGZyb20g
aGFwcGVuaW5nIGFnYWluLg0KDQpTb3VuZHMgcmVhc29uYWJsZS4gV2lsbCBkbyBpdCBpbiB2Mi4N
Cg0KQmVzdCBSZWdhcmRzDQpZYW5nIFh1DQo+DQo+IC0tRA0KPg0KPj4gK30NCj4+ICtFWFBPUlRf
U1lNQk9MKGlub2RlX3NnaWRfc3RyaXApOw0KPj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgv
ZnMuaCBiL2luY2x1ZGUvbGludXgvZnMuaA0KPj4gaW5kZXggZTJkODkyYjIwMWIwLi42MzljODMw
YWQ3OTcgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+ICsrKyBiL2luY2x1
ZGUvbGludXgvZnMuaA0KPj4gQEAgLTE5MjEsNiArMTkyMSw5IEBAIGV4dGVybiBsb25nIGNvbXBh
dF9wdHJfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGUsIHVuc2lnbmVkIGludCBjbWQsDQo+PiAgIHZv
aWQgaW5vZGVfaW5pdF9vd25lcihzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsIHN0
cnVjdCBpbm9kZSAqaW5vZGUsDQo+PiAgIAkJICAgICAgY29uc3Qgc3RydWN0IGlub2RlICpkaXIs
IHVtb2RlX3QgbW9kZSk7DQo+PiAgIGV4dGVybiBib29sIG1heV9vcGVuX2Rldihjb25zdCBzdHJ1
Y3QgcGF0aCAqcGF0aCk7DQo+PiArdm9pZCBpbm9kZV9zZ2lkX3N0cmlwKHN0cnVjdCB1c2VyX25h
bWVzcGFjZSAqbW50X3VzZXJucywgc3RydWN0IGlub2RlICpkaXIsDQo+PiArCQkgICAgICB1bW9k
ZV90ICptb2RlKTsNCj4+ICsNCj4+DQo+PiAgIC8qDQo+PiAgICAqIFRoaXMgaXMgdGhlICJmaWxs
ZGlyIiBmdW5jdGlvbiB0eXBlLCB1c2VkIGJ5IHJlYWRkaXIoKSB0byBsZXQNCj4+IC0tDQo+PiAy
LjI3LjANCj4+DQo=
