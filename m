Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26FAE668C65
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 07:19:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236727AbjAMGSX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 01:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239085AbjAMGRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 01:17:02 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8FB69518
        for <linux-fsdevel@vger.kernel.org>; Thu, 12 Jan 2023 22:13:08 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D5fTaW031793;
        Fri, 13 Jan 2023 06:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=uu7cVhYoytKfGgoeRXPImtUZARfDhcDt2RDjkpniQBg=;
 b=iNNAuczYnzlRiOvLuZvaB3DmezUoCWLLenh2yXOgGJ8yEcIYHoh/8vZqFBaEAZWsF3s9
 DVnBaXLM6HFAHlF07tOCx5CJ2Qsl6iSit8WiqfEHASUoMU4VG8gCYZAHqFD7G+oWcxNq
 dlBwGUefWa0h52a/d5xKWylyS5H8KhGn73LtBnQyibrjDl/Lu8g0EfTzIO5jU7NC9v70
 rkNwZoGiS/Nv7w+YcpTbpN9WDP7alp78g0S0zfEfr71kxKDxy3VGecFDL4/pS4vH+5SO
 WsYKSrcwfGpzdGk95D96OjaikrItjwUGIbKzLv2SDaDy99RcrQRUnm5Axm8/LNj6p9Ih 5w== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2048.outbound.protection.outlook.com [104.47.26.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3n1kjktm21-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 06:12:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gDl4XmQ1aleBXqbSZxyzgqlBXK6FhR67x6tfBf29H4HOajssgLJI7HSOrC898zAKdail685nBFiBU5BKjdKWWAdw+x01uaeYwgwwQzVFAw4ZsGXEdtfRN5Tienzo0bsprWSZXeC7rWAuUnxPdwJRE0r8fI/DCyhAoXTma049mF86VEiUaOYTg+Xdh9IrN4sAKjj6TlG3t+GPKP6FV5sirzldZ6vl04ZLr4VSNIqbdDXuu6GiM6YFvStWHt0L4gC1YQoVnVfHJSOu3LQnC2oSR+HsmZ9sUZRBgCJZHOEG4ftKxdEFP63rJQKJ8yua6u3I6oEzBkV4hSo8K2CHWOq4PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uu7cVhYoytKfGgoeRXPImtUZARfDhcDt2RDjkpniQBg=;
 b=bhgfZp18XEW2QQmnLoTIf7fC047oktCB5EDDEFYPkGg2wB4gW/3j6d33dbps3UCXo/dqTISYT497qsrCKmcWO+tT8Q4/AJEu+g1bEFatjs+jHhTMID1ENtx5HDhNTZtnlT51MF89bWEX9Dz2HQazI8VMczKqaSmnpNh3x7y5htcdP0Jm12aCkeOuTMtzCCmNKRgPR2Jc8rqu+TJXhysZY1JDAI6iAkF5OQScD0mMt8351viylOSNY2hkJ4wIG/NfLD35marNzy1xtuuzURyKUVe2ll1h1RjPrelT5EvZxdb6rM6CX6ztmyRRrdwCUSStH9MK2PTcXDzVZQ4b6pGZgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SG2PR04MB5890.apcprd04.prod.outlook.com (2603:1096:4:1b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.18; Fri, 13 Jan
 2023 06:11:54 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%9]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 06:11:54 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>,
        =?utf-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: RE: [PATCH v2] exfat: handle unreconized benign secondary entries
Thread-Topic: [PATCH v2] exfat: handle unreconized benign secondary entries
Thread-Index: AQHZJo7y5h16sYwNTk+h7l7ut+eKRq6bnW4wgAAmgICAAAVowA==
Date:   Fri, 13 Jan 2023 06:11:54 +0000
Message-ID: <PUZPR04MB63167FAB29A81DB38D43DD5A81C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230112140509.11525-1-linkinjeon@kernel.org>
 <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
In-Reply-To: <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SG2PR04MB5890:EE_
x-ms-office365-filtering-correlation-id: 9f21b41a-1198-4b6a-3df7-08daf52d119e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Jng25cpQH2ns5onblOOS8V3f2SvVGfaQkwfST1cBVtWow5bY25SKgagyoZUt8VyhwMVyZnLAQWHNb8DGstA0GpT25j9gnofQVoW7Ic9qV+oqPA+Bd5SLratvDn2ZBNePDF/6Ra/wUtW40KpcuoDw+LQw5c3OcxYWWzf8z7vlLnfl/qHgO+u/CqVPrKDOihuIXfl+A+tLhcX4XUjGbkjJGfJieVnonjEJHCgG1VnqK8FEuDc2y5PS7rcmsowi6H6fAQ7iGO0T7NN6/GVJ798YGJi3g1Rmu8dyXw5RvDwf7MhVBDELl6o01PT6XmISLp4FLWb1j7OcWW+CppW7LOZ4qRQWnBN/SaMxX5OQ9GFBCEFUMjw1eU5+LwLC5xTv3o7rrsAxUXVQ64dfGWYORnvbDoDJWJefnVVG+aalVVqoDIPqGcQmOjZgPvvsQXJ3reW0A6tuYyxsqlDAgZm/jpUHdI/Xt9goM08dzYOipkxRNyHgZxflWI15URBo5Jov6QK/taRdYnyS/Gxq6LOxHEyjfoy7ecjlR/SxD7koOI9kWlnO1pUIptr9da2NzCBzF4oIwS8tZxha8uQPyyO5I6UfnU1krs6AIvRjcU+xntjZd3Jq2al+oMXUpugFC7zD5Us9g5KF60Anv/Qlrz7cW/g6M/kqo3vxDiwhtpFe/PwP+60yOcfxFXfNOIXysD1rRldU7r7p9ef9J4Fl37lbqMsJfb6nY2PeilaPVVoxc8PYDL4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(396003)(136003)(346002)(39860400002)(376002)(366004)(451199015)(38100700002)(33656002)(82960400001)(6916009)(41300700001)(122000001)(38070700005)(54906003)(8676002)(76116006)(66556008)(4326008)(64756008)(26005)(86362001)(66946007)(66476007)(55016003)(6506007)(8936002)(316002)(66446008)(2906002)(9686003)(52536014)(5660300002)(966005)(186003)(478600001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?STVFT1ZITGVxbk52S2ZUY2JULzNQbkxEQXVlL1k0QkNSQjRrWnNwTXVSNU9I?=
 =?utf-8?B?cmc2aHh4Z0ZhSlZaM3Y0SjhtZ25uYks5c3FCaFdkcDRPdjlzbXFQaDRiVXVr?=
 =?utf-8?B?ZS9xSXRINTc5SUlhSXFnQU1uQVZLbVRLYjh4TjA1UGNSdzhtQ29ycjNDR242?=
 =?utf-8?B?MmJqazlTNkZ0RllLUk5kVnBqTVJCeVZESHFtZUEwVUd2elEwNkRqdUN5bEFP?=
 =?utf-8?B?dHVFakNkNTU1anAyV2RrajIwdU5ML01CdU04bW9oWExEUjVBVVUxZ2NuQ24x?=
 =?utf-8?B?eC9zYU9oRUVzOXF1cm5mQXVNbEJUYzljUHRERDJkR3ZUemtHeDR5MzVKQTd4?=
 =?utf-8?B?aVZsc3UwNUVtYzRGMjdrc3VaWk92N1hvSkFDSmQ3ZFVaWFh2QjFUYklFZGZu?=
 =?utf-8?B?UTNRT1F0ODJ4R2Q1VmdxRXdSNmt4WWwrMHRPTHhucFBQRU4vdCs3alM5Nk0v?=
 =?utf-8?B?M0d5Z3NGTklPZG9KcExXSFpZS2RBcUNVVjZ4V3I1blRjeXNOQ3BGUEJmOGZC?=
 =?utf-8?B?RXdaTmllWlRwNnNlTk1yMWJkYkpFVHcwVk9OT0c0aU1ETVZwdjljVUx5U0sy?=
 =?utf-8?B?aW9zb0xVQlc4SXZXREt4K1A1dGs3aFFuYTFaSTkyTzVnNFBpSHNmejUycTdq?=
 =?utf-8?B?QXZuUTI1WVk1K2VDVWY5UWtrZ1ZwQzNFblNoZitoUTJtbWwwQXdRME0xQnMz?=
 =?utf-8?B?Z1FGcm5QSFE5UW9jLzFHMFdQQ3d2MnduWi9JMHJib0JIaEI5dmFOUjVxa2N6?=
 =?utf-8?B?T3kxRldTMmtZNDZGN285Y2xFWjR0LzVmdWtmTUVXK0FjN2phNHZDdzl3ZlRZ?=
 =?utf-8?B?OU42R3hlMWVmeTUvZHJhZmhQL3hVZ2JUOUFvRzdlN0FBZTEvaXROMHNFUm1F?=
 =?utf-8?B?eGFDbW82N2VoUzlkbktOZTdmNTlacUhNQ2FuaTc5Wk9zMTdmSHJoUGRiM2Fp?=
 =?utf-8?B?bDVZcWQ2WVVjYVRTR0dwektrbmk3WHRrN0NQcCs1Qm42a1ZYc21uMng1WEI5?=
 =?utf-8?B?ZnFsdGhteG8vZnVxZWY0c1FwaFVhZER5S2pqa0d2d0JFYVJ0MlhtYlB2dURt?=
 =?utf-8?B?OUJNMTZuZ1lRSG5WY2s1My9saHRySTVCYXRSQnVGNTdLQm1nbkUxd3FoZ1hS?=
 =?utf-8?B?K0twVVRpYzA5Y2FLaWRhbWpxQW42eWVTaVZhRWc0NVpHS3FpM29jMVd1RFlQ?=
 =?utf-8?B?bzVOUktTZXBKN0VIcWNyYjJucGdnRzEzZzJsVVNOcGc0bDVXbDlId0lvaDF5?=
 =?utf-8?B?ZUlPaVE0bVU0MTFKY2ZENC81TFNQOFluRjF6OEluOWhCR2JSZFhaVm41SjZT?=
 =?utf-8?B?NkJrcStDUUtNZnVEVzdRN0VFbjdZRGhWS1RNdkRMV05ZUVh1SHhhbk1UdVZT?=
 =?utf-8?B?enZsMXlScFM5S2lOUTBxOUVFYUZYR2NCVU9rUlZRTGh5NlJyMDhkY29GTjlO?=
 =?utf-8?B?cEs2V0x5U1NuZE0rN3dsTHdMZnpPNll1eUhRaVNMSkxlN2dMUUtzbXl3KzJG?=
 =?utf-8?B?ZHFQUlREc1BmdE1HOWFpRzZaS0FTQUdFa2J3RVpHZmFlcGFBblJBT2RweVZj?=
 =?utf-8?B?VkZPdmV6YzgvNDVzb0UwSGRGUTAxRVBtWkxhZ2o3VTl1MEZwMUZOR0FuemZo?=
 =?utf-8?B?RkZMRmxuanVCMm5DMjFsOHhKQ2wveGowazBNSUF1S3N6clZEb1lGWmw1Z21E?=
 =?utf-8?B?Um1LWkVDbVRYRlJEWkRYVTFrNkExNVQxNGQ1dVpxREhHQ3ZQTEJIWXN2d0c1?=
 =?utf-8?B?YkdScHM4YWV2RzZkbE83VjhRNldzNTJrQ2s1R0RkWjVTVjFPalhiRFcxOS8r?=
 =?utf-8?B?M0hibWwrem96d3F2Szd6STBrRXpvbURLS0owVE1wZXVpWWRTWE1KYWxDNUVT?=
 =?utf-8?B?SHY4VHRIelR1R05BQmNYWnAwM1dmVXRzYjdCK1VwM3VJeGFPOHZoTFNsdks5?=
 =?utf-8?B?bDFTbXVXbWNCalhFbTdvYzlKZnVITkhVcUdlcFA5V1dPNjY1dVFPNUx1VTZ3?=
 =?utf-8?B?S3RlVUFpTWFSNnVqdnl5S2pwYllBUE9XRnpqZUNUYUhqWGV5eUorYzZuZkF5?=
 =?utf-8?B?UjNCTG1pZ1I0dk55U0RVYUpnc3lpSGNtVU9aTU1ZMDgxOVhtRnhoSTdvTDBu?=
 =?utf-8?Q?P5z+i/AvSwsRkfOQOVj33GuB/?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 46hYw7Jix/jqktKY9dzZcIN1TH63IO7SrazYvU0SmWXUPUcNsM7zGX82IiW1WoidnUTAv+dX5h9T75E3XVaJdR817Yp3+qHglofWLkXnN91Kj5J8kCBb1cNxAcnJbb2eEM4wn1bbuToRz5RsDS/NsEqlK3NvKsqGJaXQpqLJoy96dnHu6WFktO1LFV2htOBkMrLNMDdXQIubeuVCnAxHwya3/+asza/ozCfmxQ9iWHAWSnZdeCakJwV217M+/gHBTO06ZxBdKsKrgDhPeLAYGDobJ79fuTG3PgoOpeD3A9cs1O2CyjWt89xUr9UL8l6v6ZHriUJBXoH54xwjD+KUNRGZmxTvqRlPu83RLaMbsJZDUBVgmKeJkn6Ig+4+7m/25Qv0DgRFtOYcBRZq0OLPYoHSotMvArVXwX5dd12n8ZCoJuwYXRrPyjB34owJelYgiICPSPLKGovzWJVLd9Cdv/0bhZ28yQfoG2gR+q3+um1HQ8smLt8IM0c/v63FnStykeigXuxizEkAflRgJPNGBd9eWcDL0htn+X8q6V2o1YEWvk6Y2aCJeEjcE3hNFUQH6qOOhEKCTeAfR5rphPxu1VXuBS2Iw+IFwcDuuoW9eOH8kf2X+ij0IeJGkjkHHSy2rssvW+1LhYMxiUAM+jkgVel8CvRz6q1otv51AFfPfMVb7ogt6g85aHmivhblB5aY+9e6pxUL88WY3rJfl4+vPy0X2JWBZhkpYN+T18t1DhfDDFkZNTtZwCJCORgjRBealKwiP/HRgXvvZyc5Om8cmHaUc5uuxavoKpxwh+tsRjIdK+6RO9y7zOS6e1zRYQ0NW7XlZh6BOthSy9eWOC9vBYx3t20kQZ7u8vUpaTTiTIDvE9l0GpNre7T7q8uEyS+YAMIHk4UHS6TqOR95y/ynaA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f21b41a-1198-4b6a-3df7-08daf52d119e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 06:11:54.3638
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lSvfciEYWe8934W/2Mxl0FhuWpXIJMwKy1goc5x9diFzyblNA0MJJ/i1sdqRKjERcTgLAr6j6KCEWQ330Etqcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB5890
X-Proofpoint-GUID: zmz6UF08T1MWJcb-pc809yZ5NodM8rf3
X-Proofpoint-ORIG-GUID: zmz6UF08T1MWJcb-pc809yZ5NodM8rf3
X-Sony-Outbound-GUID: zmz6UF08T1MWJcb-pc809yZ5NodM8rf3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-12_14,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+DQo+ID4+ICsJCWlmIChleGZhdF9nZXRfZW50cnlfdHlwZShlcCkgJiBUWVBFX0JFTklHTl9T
RUMpDQo+ID4+ICsJCQlleGZhdF9mcmVlX2Jlbmlnbl9zZWNvbmRhcnlfY2x1c3RlcnMoaW5vZGUs
IGVwKTsNCj4gPj4gKw0KPiA+DQo+ID4gT25seSB2ZW5kb3IgYWxsb2NhdGlvbiBlbnRyeSgweEUx
KSBoYXZlIGFzc29jaWF0ZWQgY2x1c3Rlcg0KPiA+IGFsbG9jYXRpb25zLCB2ZW5kb3IgZXh0ZW5z
aW9uIGVudHJ5KDB4RTApIGRvIG5vdCBoYXZlIGFzc29jaWF0ZWQgY2x1c3Rlcg0KPiBhbGxvY2F0
aW9ucy4NCj4gVGhpcyBpcyB0byBmcmVlIGFzc29jaWF0ZWQgY2x1c3RlciBhbGxvY2F0aW9uIG9m
IHRoZSB1bnJlY29nbml6ZWQgYmVuaWduDQo+IHNlY29uZGFyeSBlbnRyaWVzLCBub3Qgb25seSB2
ZW5kb3IgYWxsb2MgZW50cnkuIENvdWxkIHlvdSBlbGFib3JhdGUgbW9yZSBpZg0KPiB0aGVyZSBp
cyBhbnkgaXNzdWUgPw0KDQpGcm9tIGV4RkFUIHNwZWMsIHRoZXJlIGFyZSAyIHR5cGVzIGJlbmln
biBzZWNvbmRhcnkgZW50cmllcyBvbmx5LCBWZW5kb3IgRXh0ZW5zaW9uIGVudHJ5IGFuZCBWZW5k
b3IgQWxsb2NhdGlvbiBlbnRyeS4NCg0KRm9yIGRpZmZlcmVudCBWZW5kb3IsIERpZmZlcmVudCBW
ZW5kb3JzIGFyZSBkaXN0aW5ndWlzaGVkIGJ5IGRpZmZlcmVudCBWZW5kb3JHdWlkLiANCg0KRm9y
IGEgYmV0dGVyIHVuZGVyc3RhbmRpbmcsIHBsZWFzZSByZWZlciB0byBodHRwczovL2Rva3VtZW4u
cHViL3NkLXNwZWNpZmljYXRpb25zLXBhcnQtMi1maWxlLXN5c3RlbS1zcGVjaWZpY2F0aW9uLXZl
cnNpb24tMzAwLmh0bWwuIFRoaXMgaXMgdGhlIHNwZWNpZmljYXRpb24gdGhhdCB0aGUgU0QgQ2Fy
ZCBBc3NvY2lhdGlvbiBkZWZpbmVzIFZlbmRvciBFeHRlbnNpb24gZW50cmllcyBhbmQgVmVuZG9y
IEFsbG9jYXRpb24gZW50cmllcyBmb3IgU0QgY2FyZC4gIkZpZ3VyZSA1LTMgOiBDb250aW51b3Vz
IEluZm9ybWF0aW9uIE1hbmFnZW1lbnQiIGlzIGFuIGV4YW1wbGUgb2YgYW4gZW50cnkgc2V0IGNv
bnRhaW5pbmcgYSBWZW5kb3IgRXh0ZW5zaW9uIGVudHJ5IGFuZCBhIFZlbmRvciBBbGxvY2F0aW9u
IGVudHJ5LiBJbiB0aGUgZXhhbXBsZSwgd2UgY2FuIHNlZSB2ZW5kb3IgZXh0ZW5zaW9uIGVudHJ5
KDB4RTApIGRvIG5vdCBoYXZlIGFzc29jaWF0ZWQgY2x1c3RlciBhbGxvY2F0aW9ucy4NCg==
