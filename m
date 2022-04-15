Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19E87502011
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 Apr 2022 03:19:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346984AbiDOBVf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 21:21:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348353AbiDOBVd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 21:21:33 -0400
Received: from esa16.fujitsucc.c3s2.iphmx.com (esa16.fujitsucc.c3s2.iphmx.com [216.71.158.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC436AF1ED
        for <linux-fsdevel@vger.kernel.org>; Thu, 14 Apr 2022 18:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1649985547; x=1681521547;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TnvUizzAXunUOW2DdajlYOzV1ZFWLERBPR4eJilOKX8=;
  b=VntQfttiSqE55bzpDFggOohJYuZIJrZNpnXeYiv4BpGtka80KO2rIFbO
   t2Y8fAgXSy16ssI01gMsSXAm8RM90f3ioaUgt02iNWYm9gXTDKezGDbaV
   OfkaRd8hcP2MOzyGm0nYLJa5VHq+hIRHnkp5D6++tlItrq+gBEk0Rm/Le
   vqgeBlLb+uQI1RUKWoVsYLsyk3dCeNa63P4WkL7TP6KKV5YLbKUQyDSYk
   3hqLBvEnNBtSiLZZGjiI+I5S91Vu3kf1nJhnD8MnyA/0q1p5jwn7XjIuV
   DwCaDjoSGTB/mHKkCV5/Z2nQqX/l3Usl/Kaq2rsYWT+DYF32ZfU6Ppu7c
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10317"; a="53925714"
X-IronPort-AV: E=Sophos;i="5.90,261,1643641200"; 
   d="scan'208";a="53925714"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Apr 2022 10:19:02 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FpAP3vybnMTg26mdqG6x+6+c+OuS/MD4wguuFvS7cqQgWZuIO2D7brAb4yeWDnCf1dLMxN+aZF+Disd2NPFeQHPdmHL1ybFGihpBiYCkFLReGDpEYGni3X9AGAUi7UzZNfNSSWkIAq09cAccN3kLIn/q0nT9na9vRowiMmlZpij1yCJiKqQZRz6/BV/udZdrCPJ8rP5JuTL229blaN8p3XVutWJIOBwVa4bRWafR68CnYgJeAjn/HPRCjD151+/pschHBpoEBVA32WC9g/c1wnxDgjCV3arDmJ8/scyfE5cFhllZxOQmnLHSSCHhVMlvhK3T7yDnZuN38ycJHJYuAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TnvUizzAXunUOW2DdajlYOzV1ZFWLERBPR4eJilOKX8=;
 b=mMaYu0gIf0DulzvkSlC+WQwTt591uXdKLTBERthly7tuJSUWhOIkkgzGNVkr3g/NfV+3g1CE3olvTefbYd4GgYXGoaI+n26eWOwFfdpnq/WdLATcaoMabXY48AVMuSJ3lEMPGGR3SBNM00D3P6xFKXLL0MA3elUNWF1KE4vUq/afoxomSl7WH+AdSCthoNBeNkuePjWhWDU6p5tFBXrCPoCL5e8lyt0ZIOeBNvVJCs09YOP9PAUWh1GTPxr7ofDzpsYM01CpJEqCIhtRbK2ZbpQRPB4tV7HxeHQdSb+UlVzmEixtMufL8FI+5mSfSg/VzKNCVHGqMS4dBUkxa20rCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TnvUizzAXunUOW2DdajlYOzV1ZFWLERBPR4eJilOKX8=;
 b=SbeXtxoYom+ycEnLsQWnhhfZfxsshST6S+FCMBdvNu8cjvRO7spEXbwmeg0K2c6es5SZRfnrInq5WFmsH0vP9+uoDn1oR1M8nP2eYUqgwThOjKDJ3UgY7aBE4UkpO4/0kf32hKWjPp/Xc6qPEMhuYqLqg7Kxsq8w99pR2pT/5Q4=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by OSAPR01MB4082.jpnprd01.prod.outlook.com (2603:1096:604:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Fri, 15 Apr
 2022 01:18:57 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::fca9:dcb9:88b4:40fd%7]) with mapi id 15.20.5144.030; Fri, 15 Apr 2022
 01:18:57 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     "Darrick J. Wong" <djwong@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>,
        "ocfs2-devel@oss.oracle.com" <ocfs2-devel@oss.oracle.com>,
        "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "david@fromorbit.com" <david@fromorbit.com>,
        "brauner@kernel.org" <brauner@kernel.org>,
        "jlayton@kernel.org" <jlayton@kernel.org>
Subject: Re: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Thread-Topic: [PATCH v2 1/3] vfs: Add inode_sgid_strip() api
Thread-Index: AQHYT8zJjgXI7lzLHECHzFKbpundU6zvkPuAgACuB4A=
Date:   Fri, 15 Apr 2022 01:18:57 +0000
Message-ID: <6258D64F.8030903@fujitsu.com>
References: <1649923039-2273-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220414155707.GA17059@magnolia>
In-Reply-To: <20220414155707.GA17059@magnolia>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c741df66-a502-4bcc-59ed-08da1e7dea3d
x-ms-traffictypediagnostic: OSAPR01MB4082:EE_
x-microsoft-antispam-prvs: <OSAPR01MB408256379EC719F89E9BFB96FDEE9@OSAPR01MB4082.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: djYhD33CcLgg9QNm07w2DFBukSZQmlFo3W27fYKmqaMq5AVl6p24zT+ysR/A2O8UTXSSnK3KQ+Gcv/jVtit/pZZjfVY5MCOTAFU4PyRqFf0JF5qi5lwHEteGui7BFRoXg4ThiqTa9r/C33WdEPyqrGJWgxL6x+i84XEKTD8PRv6bunhTlh+Tn7rYfPaYb7d0gB/4xf0HpCTrjgCH+tvewgDV4py0LWIUEyDnFe/mLT+vkxm2AcHiThfzdvX8OWL83skYeA8Ju/K/ebh+tHEFlLcMgY+ZFrBxskDqiXeLCif/8hB8grrsbHU1PZoLDV7ErN8rDyz0dLwrd4iSxmspOoxRNIxz8pkvFlWKFkWq/1odHdIROA6ja9DlGEwgWy34kCxjB4WNgmM0wTbmaQUSwvCZUa+0mLUPxjvLrgz+O9tC6L41aF+hjvig4mzvmwm67WIItBNxn7Z0LB4ilji/OZAW7nVgmqa6MXIyT8IvggoUDWa1SbjJK2uAx2uTM2Hj03WIMcYuMdrBcznfv3lu+WF9xmVgMtw7YlfPZZWER8OKH9pVzclriM/py13L4z5zL7IPPFIMqGJTODsNkq+3SfKRWfwR4DLeO+BhPjnWlRJGoYjWMney8m2wmF8fnmLl87i8/F2TECUcWCDAfGjY20pv8nXguuYHkEAhIWdTYb9YV4gOd0RPjL57Su+8uKm9Bc2KUo8OfGB2AtcBttBymA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(45080400002)(508600001)(2906002)(64756008)(66476007)(66446008)(66556008)(4326008)(8676002)(6916009)(33656002)(85182001)(76116006)(54906003)(71200400001)(6486002)(86362001)(87266011)(6506007)(6512007)(316002)(91956017)(82960400001)(66946007)(122000001)(36756003)(2616005)(83380400001)(186003)(26005)(38070700005)(38100700002)(8936002)(5660300002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?c0Q3UVlkMmFkcWhtSW14bmpzRkQvbTNpRzZwOUZDeUhVTHJiT2tURVBCU0FL?=
 =?gb2312?B?SmVBRGorUzVHbFVuckFrUUNleDZYdVUyQWplWW1ONDdPZGRWeGhocGJQdzBU?=
 =?gb2312?B?Y09EajFLZGhZTGVlbnlpR2N1TFhDUCtnU2lzMFhWaXJ2OXZ5cFI5SEMyUW83?=
 =?gb2312?B?VnNNUm5OckgrWVgwV2lmNnBDMzlTaWIwb1JLbm8zTkdZcmNLSmhTcDlCUzZq?=
 =?gb2312?B?RWdzWkExNEI5UkJVSHpUVUUwc1dPa2F5TytkL0J0S256cGdOM3Q3MS95aW9M?=
 =?gb2312?B?WnphK0FFS0JXMXBTVXNZT1BGbEJiK1BldGVob2Y3VVBjZzBvK1FkbUw4QTFV?=
 =?gb2312?B?MW03aU5CWDhUOGxzSmRQYytNVHFWYWJ4U0RjTzlRUTZqaXJEWit2Y29qTCtS?=
 =?gb2312?B?VSs0QnpybXVxOTFabGtwNGJMNkZYNlBDOUpVZnk1UVdWREg4blpKZnY0Z0dX?=
 =?gb2312?B?SURlbHA3WHM4SmJKMlFKUVl6YUhyeHRiakU0MCtiQ2ZsQUhLcytpK000SE5n?=
 =?gb2312?B?andpeVhlVmlEa0pSa1Jpam03UDdxTUNlUlpKUVp4enQxUFIxWm9QVlVOZjdO?=
 =?gb2312?B?bTJtWDRHU3pOLzRVcGhiQS9VT25yaURzWUdaYStjVmovMWQ1eUw2VEFlZGlp?=
 =?gb2312?B?d0tNVDNuTyswcjJSUjZEM0N5R2sxU0JrdnQrY3ZYbFZhVitqYWgyUjNuRnZF?=
 =?gb2312?B?VDAwdjV1MnY4NUlEL3Z2eUNvY2JDbkFaOUFhdzh1NE9PMUhxZWI3aENxWVJD?=
 =?gb2312?B?a0Z3azBEKzBFNlp5SkoyV3RrV2gzWTNrT1htM0F4MFQyTnFhZjROTVhnTFJv?=
 =?gb2312?B?SlNBLzBKekZHK3I4YVdoeDhsdkRGenlHM1BZblNIbHNqWW15dmhTWTNhbThT?=
 =?gb2312?B?YkZPbzFwVEk1VzArN3NzeGtmYUNRLzdIdU5IQ3FXaFlLR3Y1YzRFajVTOWEz?=
 =?gb2312?B?ZWlHUnh3SkI2dGpUeU96K3JuM3JUdXp1ZjdpS2hTRDFjQlV1RklKNDE3Z2JD?=
 =?gb2312?B?WjNXaGppZDdQTHJEeXlpb2F4YjBxTEpldU42NTZPU3ErWmYvSjlrd28rTmhy?=
 =?gb2312?B?cVBjRTlsYUhhdGlyRTJSb3pkbFgvU1ZYMFp3cnc3eHcyb0RZK3hydTBpTzVR?=
 =?gb2312?B?RFhOSHNDNHZ1UVBWYzd6TTVYOTNDZ2hLL1VhelYza3o5eURPSHB5RVExOHY2?=
 =?gb2312?B?UWViR0ZRb0tWZ2lvQlY5RFhCYUc1Y0cwQkFGQWFiQkFObDFZRS9pWGNJQkk2?=
 =?gb2312?B?VUpLOEhlc3JaNXhvODlJeHlNRzk1djVzWFFOdTU0clRCWXdxUURJbkpSZHNP?=
 =?gb2312?B?am9nZGVQOFQ3WDMvUjBZeEErN1dzbzdBMC9ETGlBRWdTSVh5aHp6bkJNajdp?=
 =?gb2312?B?QVkyNEpYNmJEaXExUmFjUHllYy9hcWwwQ3p6Y044N1poZHYrWldKZVlsbzB0?=
 =?gb2312?B?bHdoVUtscitCSHRpTHFYQmRoeXd3OFhnVTdwbkxKLzMyc0IvajdSb01ORTNp?=
 =?gb2312?B?b0RINloyaTBpOW9GSHloTlhOODA0a3FVdnVvTFJEV0NQV3RJWFk3Z1ZOa1Bv?=
 =?gb2312?B?eGdlTDhmWWlEUzJSVmJoVmdwYXVpWjdTYzBEbytvR0Q0UlpaZUMwK1dHellS?=
 =?gb2312?B?N003azIyOHB1eTVVd2l2ZnJBcnM0OURSTVZ0Nld6L0FGNzNNWlM4REVaRVBx?=
 =?gb2312?B?ZXk3VEpxWUhuVWVRWm1uWXVwbi85T0l6RmRkQXhuanp6ZzBaWU1vUjZ1RVBV?=
 =?gb2312?B?aFl2VUpRTFV5U1d0QktRTkhBOCtTMWFqT1g3cGU0VjBsd3dlZ1VBYk4zTlI5?=
 =?gb2312?B?KzQxVkwwdWs5ZUZSRC9PZEtPMjgrTlhudHRwbGtFTFRTOFFsT0VHN2xKSVZo?=
 =?gb2312?B?KzRMTGplNDdqbVREOW0ybFYrd0djV1c2Y2dCRzVXclhCdDhzeFdoRU1oS3c0?=
 =?gb2312?B?QWowT3JwMG10WWw4VDVaaDV2aTJObVRJUDVzNWdxWnJ2bm1Ba244NzludjRn?=
 =?gb2312?B?RVlkWExwSXlSeWtaNlZTd0dCeUNXZVJyMFlWb1k4UG1IVUR2RVNDbWtJV2pB?=
 =?gb2312?B?OGhtamxXdEI2NFpYZVNPdVpucWw2RjMrcHJQM0F1NUY5YWNiSUxUQ1JxV0c1?=
 =?gb2312?B?L0YzWXEwcDZUaDZaem53MFVvbWF4b21JL0dPY0taUEdnMGo3dlEyVjhIRDBo?=
 =?gb2312?B?WXV3Rm1oWFpiWnBXMjJlK0dZNXhtZ051T2pyL1Z6MlBwVlNZRDhYNksvVzda?=
 =?gb2312?B?RXlMajV2LzdoZWR2LzVZZDJWTGEyQ2lOcG9PdFF0T1B2VElISnhZWmNVVjAr?=
 =?gb2312?B?YU5GTHVCZmtGL3NkOVBNaEZlSGpHMUtBcDE1N2FKcXJuRE1IZ0lTajk1bm9H?=
 =?gb2312?Q?O/yK8/ADafTtGPaDdOaCjNyUTyk+kPuicontP?=
Content-Type: text/plain; charset="gb2312"
Content-ID: <3D6BC4F31F3AAA4A9CC92FDF94E04EB5@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c741df66-a502-4bcc-59ed-08da1e7dea3d
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Apr 2022 01:18:57.4574
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qkJYngnRlmpkovgWuOZYhZqZUklrbyqv1Wb4aBRZwzDAHrUPhvKoKL2hY0HrflPK33uPQO6xLVPEDhEQmu80KMuU260XozJNiSGt5hX9qlk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OSAPR01MB4082
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzE0IDIzOjU3LCBEYXJyaWNrIEouIFdvbmcgd3JvdGU6DQo+IE9uIFRodSwgQXBy
IDE0LCAyMDIyIGF0IDAzOjU3OjE3UE0gKzA4MDAsIFlhbmcgWHUgd3JvdGU6DQo+PiBpbm9kZV9z
Z2lkX3N0cmlwKCkgZnVuY3Rpb24gaXMgdXNlZCB0byBzdHJpcCBTX0lTR0lEIG1vZGUNCj4+IHdo
ZW4gY3JlYXQvb3Blbi9ta25vZCBmaWxlLg0KPj4NCj4+IFJldmlld2VkLWJ5OiBDaHJpc3RpYW4g
QnJhdW5lciAoTWljcm9zb2Z0KTxicmF1bmVyQGtlcm5lbC5vcmc+DQo+PiBTaWduZWQtb2ZmLWJ5
OiBZYW5nIFh1PHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20+DQo+PiAtLS0NCj4+ICAgZnMvaW5v
ZGUuYyAgICAgICAgIHwgMTggKysrKysrKysrKysrKysrKysrDQo+PiAgIGluY2x1ZGUvbGludXgv
ZnMuaCB8ICAzICsrLQ0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDIwIGluc2VydGlvbnMoKyksIDEg
ZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZnMvaW5vZGUuYyBiL2ZzL2lub2RlLmMN
Cj4+IGluZGV4IDlkOWI0MjI1MDRkMS4uZDYzMjY0OTk4ODU1IDEwMDY0NA0KPj4gLS0tIGEvZnMv
aW5vZGUuYw0KPj4gKysrIGIvZnMvaW5vZGUuYw0KPj4gQEAgLTI0MDUsMyArMjQwNSwyMSBAQCBz
dHJ1Y3QgdGltZXNwZWM2NCBjdXJyZW50X3RpbWUoc3RydWN0IGlub2RlICppbm9kZSkNCj4+ICAg
CXJldHVybiB0aW1lc3RhbXBfdHJ1bmNhdGUobm93LCBpbm9kZSk7DQo+PiAgIH0NCj4+ICAgRVhQ
T1JUX1NZTUJPTChjdXJyZW50X3RpbWUpOw0KPj4gKw0KPj4gK3ZvaWQgaW5vZGVfc2dpZF9zdHJp
cChzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMsIHN0cnVjdCBpbm9kZSAqZGlyLA0K
Pj4gKwkJICAgICAgdW1vZGVfdCAqbW9kZSkNCj4+ICt7DQo+PiArCWlmICghZGlyIHx8ICEoZGly
LT5pX21vZGUmICBTX0lTR0lEKSkNCj4+ICsJCXJldHVybjsNCj4+ICsJaWYgKCgqbW9kZSYgIChT
X0lTR0lEIHwgU19JWEdSUCkpICE9IChTX0lTR0lEIHwgU19JWEdSUCkpDQo+PiArCQlyZXR1cm47
DQo+PiArCWlmIChTX0lTRElSKCptb2RlKSkNCj4+ICsJCXJldHVybjsNCj4+ICsJaWYgKGluX2dy
b3VwX3AoaV9naWRfaW50b19tbnQobW50X3VzZXJucywgZGlyKSkpDQo+PiArCQlyZXR1cm47DQo+
PiArCWlmIChjYXBhYmxlX3dydF9pbm9kZV91aWRnaWQobW50X3VzZXJucywgZGlyLCBDQVBfRlNF
VElEKSkNCj4+ICsJCXJldHVybjsNCj4+ICsNCj4+ICsJKm1vZGUmPSB+U19JU0dJRDsNCj4+ICt9
DQo+DQo+IFRoYW5rcyBmb3IgY2xlYW5pbmcgdXAgdGhlIG11bHRpcGxlIGlmIHN0YXRlbWVudHMg
ZnJvbSBsYXN0IHRpbWUuDQo+DQo+IEkgc3RpbGwgd291bGQgbGlrZSB0byBzZWUgcGF0Y2ggMSBy
ZXBsYWNlIHRoZSBjb2RlIGluIGlub2RlX2luaXRfb3duZXINCj4gc28gdGhhdCB3ZSBjYW4gY29t
cGFyZSBiZWZvcmUgYW5kIGFmdGVyIGluIHRoZSBzYW1lIHBhdGNoLiAgUGF0Y2ggMiBjYW4NCj4g
dGhlbiBiZSBzb2xlbHkgYWJvdXQgbW92aW5nIHRoZSBjYWxsc2l0ZSBhcm91bmQgdGhlIFZGUy4N
Cj4NCk9rLCB0aGVuIHBhdGNoIDEgY2FuIG5hbWVkIGFzImZzL2lub2RlOiBtb3ZlIGlub2RlIHNn
aWQgc3RyaXAgb3BlcmF0aW9uIA0KZnJvbSBpbm9kZV9pbml0X293bmVyIGludG8gaW5vZGVfc2dp
ZF9zdHJpcCIuICBXaGF0IGRvIHlvdSB0aGluayBhYm91dCBpdD8NCg0KDQpCZXN0IFJlZ2FyZHMN
CllhbmcgWHUNCj4gLS1EDQo+DQo+PiArRVhQT1JUX1NZTUJPTChpbm9kZV9zZ2lkX3N0cmlwKTsN
Cj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L2ZzLmggYi9pbmNsdWRlL2xpbnV4L2ZzLmgN
Cj4+IGluZGV4IGJiZGU5NTM4N2EyMy4uOTRkOTQyMTlmZTdjIDEwMDY0NA0KPj4gLS0tIGEvaW5j
bHVkZS9saW51eC9mcy5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L2ZzLmgNCj4+IEBAIC0xODk3
LDcgKzE4OTcsOCBAQCBleHRlcm4gbG9uZyBjb21wYXRfcHRyX2lvY3RsKHN0cnVjdCBmaWxlICpm
aWxlLCB1bnNpZ25lZCBpbnQgY21kLA0KPj4gICB2b2lkIGlub2RlX2luaXRfb3duZXIoc3RydWN0
IHVzZXJfbmFtZXNwYWNlICptbnRfdXNlcm5zLCBzdHJ1Y3QgaW5vZGUgKmlub2RlLA0KPj4gICAJ
CSAgICAgIGNvbnN0IHN0cnVjdCBpbm9kZSAqZGlyLCB1bW9kZV90IG1vZGUpOw0KPj4gICBleHRl
cm4gYm9vbCBtYXlfb3Blbl9kZXYoY29uc3Qgc3RydWN0IHBhdGggKnBhdGgpOw0KPj4gLQ0KPj4g
K3ZvaWQgaW5vZGVfc2dpZF9zdHJpcChzdHJ1Y3QgdXNlcl9uYW1lc3BhY2UgKm1udF91c2VybnMs
IHN0cnVjdCBpbm9kZSAqZGlyLA0KPj4gKwkJICAgICAgdW1vZGVfdCAqbW9kZSk7DQo+PiAgIC8q
DQo+PiAgICAqIFRoaXMgaXMgdGhlICJmaWxsZGlyIiBmdW5jdGlvbiB0eXBlLCB1c2VkIGJ5IHJl
YWRkaXIoKSB0byBsZXQNCj4+ICAgICogdGhlIGtlcm5lbCBzcGVjaWZ5IHdoYXQga2luZCBvZiBk
aXJlbnQgbGF5b3V0IGl0IHdhbnRzIHRvIGhhdmUuDQo+PiAtLQ0KPj4gMi4yNy4wDQo+Pg0K
