Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA0E97407D1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Jun 2023 03:53:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231172AbjF1BxR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 27 Jun 2023 21:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231133AbjF1BxP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 27 Jun 2023 21:53:15 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CA94297B
        for <linux-fsdevel@vger.kernel.org>; Tue, 27 Jun 2023 18:53:14 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35RMvwAt030254;
        Wed, 28 Jun 2023 01:52:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=hkaYrArXpofIodO/hHnl8rhYT7ma2jWFcJZWfdphFJo=;
 b=E4405+ecoQQdEFwHTES4zIXrum1TffrlJ6p/OXmc8G6S9Rr94+cveBM3+ZWx1u85bR7j
 TFILwZSEmdMqLW38FTjFwnl8og/nBTjY4RYPyHmJ/4bgsDqtnSRYbtpHQcxtQ0rStamt
 kBVlb3ssRk6CvfyJf9SDLX4kB4cv63qcKOEQI36446O1NqtnKmxB2BLMLUvTX/wx4UP4
 Dw1YKZYjhXyWxDpLea1EvbvEkKTeLRqWVX9f5qKwtSXsP4PpWvT+u827qgy1vEr5OHcS
 c5ijvkFZiK8yiU1FAoeA88TNd0w64+RYuiDyT7UEy4yOc2KAyaVN7Q/Tie/kqZWWGHta HQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2047.outbound.protection.outlook.com [104.47.26.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3rdnqy3mq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 28 Jun 2023 01:52:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GkRxHuJB7zDfpUy5nmBvCFKjK0s6LjyXcgJ7JFkN4dekAsuVEv5jXOTiua/hqpEj+/xTqyBl1DObNoT8WRHjERz3F5P/sdpRzTfhzcNunpXSPUp4N/HRZ6mO94MBd+rmnead1om7tesctFoSzC3QOOcA6HjkfM+YC4l1c535qEasuGeRtmnpZ8teaQr89dNh8VVsdjvk+2Op/PkIkSqq5Q5NGfYqGXWHpgqJvwliJknei4xXG+/ziMROGkRufrpK3ZPsvGoIg4GjiKZa2WBtCSnY0GgEz/jTChHbgLBHL3mREhYUmI+L27TPsGcdTNMAjTRbQk7J3GMdOzwAon18BA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hkaYrArXpofIodO/hHnl8rhYT7ma2jWFcJZWfdphFJo=;
 b=gxMibElQQ4Rz62DCaYWbsrnJ5RICoHXB34wykCFq0HD4I24LsQcwfDyOvPcht0x7EMEyt/3ukz4lIJfjN52yvlbmpr4f3pt0isP1aRUguRdeyzqQlJ9Zqq5E9nfuHC+aQALxOwXlD315gE2hHkpM2Z7YSaa4fAN367WV3wUvfhjE33d9MXCJn7DTa8YErp7/RNF5eSRWypwuMoigwzOI67xNG0OezJ+gwlG26TFkND7KK32/HB3sAsOmq+UBB3NdGU1K27BZeX57tCFmd9hxttq6FhdjJRkHquQedjHeCfLMvtD+6hHQ9/qMvwVaf37SbduR7AuvM0rFuX4J8ZI6GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4389.apcprd04.prod.outlook.com (2603:1096:301:3f::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.15; Wed, 28 Jun
 2023 01:52:53 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::ce2d:a9dc:4955:5275%5]) with mapi id 15.20.6521.026; Wed, 28 Jun 2023
 01:52:53 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 2/2] exfat: do not zeroed the extended part
Thread-Topic: [PATCH v2 2/2] exfat: do not zeroed the extended part
Thread-Index: AdmpYxJaQT0eJpq9S2qk9+xpIeN52Q==
Date:   Wed, 28 Jun 2023 01:52:52 +0000
Message-ID: <PUZPR04MB6316007DA330B551F70F08598124A@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4389:EE_
x-ms-office365-filtering-correlation-id: ee4826d8-7cc1-4f97-5ed5-08db777a62c2
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PpH0fyK6V9cqk9P++HN6PwKdOoCdsNELwInIlZYYqQ5ld7PXv6jGJd1eSav70yxzBartKkK6tpY9l0a7t30k2YZ5uq78FIaA3vF0iWN+0+YzYDs6r5yQZ2tIltixB1m1mGN4pFhv1L4qOOjbjtJI8MZ4Npai3x+N+s74oToyoiKFlWYFQauuHP0oMdMMXviXxVG5B37BxxYFnz9bd5Ad2YHlH4WzEWfmHB+M9BPHzelvGmspPzEgD7Pi8Q/8wOgjkRbRUNHpzUtnXZabFXJh22CaFPEr3xstUhF5P/c9dp4bUyw8U+H7L5raUUU8BLgDV5oXr4OfWIDwsxWbsKlxFEo4dw5OEhJ/ES5argjw1CtzgGe+V13nJJLT3PmQfOdOFjwJoED4A3nYetOEJ4W545vnNgKRQNfu+MmxkwAhp3qNYXmO+4yC0VQpBQ7aGi2UvhfPrEbmX21qM5zozzoV05u6LBMVa8KslPVrEH/4T/CLydlCjmq0ahCcdF+4fyn+zqpvRw1VkrdYy2/5U0MSnvqG8WXvX6zVX1O8KdY6jTy2GpHmba6Moa0LfPmF2CUV7b2kA9vA5n4CxdNqkix853RkXPIhcQLh5IzYRfXX6pgQUDR2bsUVgelL625ZFB8H
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(4636009)(396003)(136003)(346002)(366004)(376002)(39860400002)(451199021)(5660300002)(66946007)(41300700001)(52536014)(76116006)(64756008)(66446008)(66476007)(66556008)(8936002)(8676002)(4326008)(316002)(478600001)(83380400001)(38070700005)(55016003)(26005)(6506007)(2906002)(33656002)(107886003)(9686003)(186003)(54906003)(110136005)(122000001)(38100700002)(86362001)(82960400001)(71200400001)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aVkyTzkyendsaFE3TkVsZW5sRzU2MDhxdUhhVFhYYWJrWi9iaHJlamZyNHVy?=
 =?utf-8?B?MWFkU1J0L1NtMzN3ODh2dmtBSEhWdStJYnZIYThWSGg3YWplQmZnSUtkVDhy?=
 =?utf-8?B?M2VHUWtmTnVHeVp4V1RnY3VwUmlCUUIxYi9tSHc1OUVTd28zNmxYZGNEZm5I?=
 =?utf-8?B?eGRUdnpGRDZpcHljZ1pjMnpxZ0lMeWk5TngyMVl5R2xVcXNiTVFDdkU1dXph?=
 =?utf-8?B?bGVMdjJCZEtCaTRENUplcVk3aUJzaS8vcFZlT2wzb0lWcG5hOXkwWEE3U092?=
 =?utf-8?B?VjZ3MjZBM2pOKzlRQWxxcWh6RlA4VW1DNk9ORC9UK3VvYUQ2Z3FCaE15RGN4?=
 =?utf-8?B?VWZsNFRTRU04eWpJR1djRlZ3Y1dpdDQrRmpreC9CSmRDMEE2S29ubFhpd0lq?=
 =?utf-8?B?UFdwRVc4VlV5NTlkTTdnRjhxU0hoc1BsZ0hOcXUzRTErRXlBcXNjbGRtYXRI?=
 =?utf-8?B?WWJHdm9GTWRZa3lvYnVrakFOckxsQzJocDJMMXY4NGxNbGxYS1JVTklraldQ?=
 =?utf-8?B?RTJSYnZweUhKQXgzeXFIZnlPUDcyUC9HRUxQZ3RyL2ppVFZ3SGUzVS9neUlh?=
 =?utf-8?B?anRQQTVKYlNxVVpWdWJVQ1h1ZGRjcElzZG5uK3h2NElEY0tEbDM3M3V0TzZL?=
 =?utf-8?B?YnNuWndFVnlzM2VXUTNDQmVJdVU3aHhwR0lJeEJmdGkxVWQ0M05zSldMeEtG?=
 =?utf-8?B?QTh1N05kRjNTVnY3RWNoSFhYbFJpUGdSZmgzRzV2dWZjclg4WGhEVkFMZlF4?=
 =?utf-8?B?NFFvT0xGQmQ5QkFhcnZUdzRYRSsyOWQzdzRmYzJHSFZ3VW9ld213cEk3THYy?=
 =?utf-8?B?UDNwSHBiSFRVbGN3ZkJ6SU1kMkpWY2VQRjV3RWtKZEl5VG84UEh6LzdPTlFl?=
 =?utf-8?B?eldUV1BTa1ZQV0x1MlNxaEZQTjROa0x4Vkw3c3ZJUVV2eWh4UmFobk1jY1RO?=
 =?utf-8?B?SFQxTkV1eHpNVVpTbGRYbllvckh3Mm13SUVkS2NGNjc1MjY4OU1vN3JiUXRa?=
 =?utf-8?B?OVVZKzkzdDJOWWl6M2RlTFc5U1VKaS80VjVCU2JzT2xnZkU5ejB1dDR1MStw?=
 =?utf-8?B?YXdMQ2hvYzVDNjBYeGo4NllMblJXQ0tPK2Q5WENWWDVqTitHOW4xNnNQRGM3?=
 =?utf-8?B?TGFWaGtnWG5VTm1uS01IVGRncHVFYzR5SU04MGdRMERVS0U4YUpaNkI3a2lT?=
 =?utf-8?B?ZDIvN0R2cm1RU3kza0JhRVp6MWlHcVpSK01SdkNmWGl5ZUxBWHlNRkJTdTI1?=
 =?utf-8?B?Y0xld1kxTzBPWjhmeUhVcGpZZ05iRDFieVpNLzFuV1E3R2R3SDF0RW5NNlBj?=
 =?utf-8?B?cGVuZHhzR3NXczl2OGVnWGVKd05jUzhEVXlWN3I5N2hXR2JiR0QzYkJ0NzRj?=
 =?utf-8?B?a09GdzE3SVBzR3ZXT0xxeTZLYWVNNXRQQjE4QmExY3ZIYWljeUNJUFhRTHBJ?=
 =?utf-8?B?eTU2dlZGUWE0QWlyZXVaZHpCQ0MyOFdmWm9BVjdHdTFvV3d5aVphejNzUVF4?=
 =?utf-8?B?WC9SMkhMLzIzU1pxNzgvRkF6VkE4QmhwQmJQNytmRzQvMm9ISCtLRElnbWs4?=
 =?utf-8?B?YzNBN25VUHVxRVdKUXJnZldxczVBRUc0S0E4Zm5rK3MveFFNYlh6Y3VlN2RE?=
 =?utf-8?B?YUI0RDkvS3laSG9tQVR6eFVaRTdFT0pnQ3ZMb3c0czNlTFFWcms4THlycWRw?=
 =?utf-8?B?cXRyNlc2ZnpNUDl5RHM2TGRNZkNGSmR0Uk1zdUR1R2VmNXdtSHFLV0s3RVNU?=
 =?utf-8?B?c2ZRSUpUaXNBZDlUR3ZYK05EWG1KaFJsWlgwN2JMT0E3Z3N0Tm55OWpxSWhi?=
 =?utf-8?B?VDh2dkNvSjhhc1JyT3ZSSjBtZmZzMG1FMDVQblNHeDRLYUxyQ2JicWdEblZG?=
 =?utf-8?B?SE1PMXVxb1RhbkxXRzZFWUtFc1dRbjY0L0JySmFXY1hCRjkvdEFCR2JqQ05m?=
 =?utf-8?B?bCtDUW83clNhMUlGbW5mblY0eXZxKzNyOE0xMHRCMHZLTk9sd3UxY1ZjM1FZ?=
 =?utf-8?B?REVzcjBsN1R0Rjh6cFVrYjUrL3JoYytta0E3SGpuRzFCY3liVDhTTFN1em5p?=
 =?utf-8?B?RklYeStuenpPUkt3Z0pRK1BSUlJZT0hUQ3ZFakdON0xsWGdWWVR5cHpDRHdn?=
 =?utf-8?Q?zzub818mzj/iGaTf4p+VA9P15?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: MKDxVOurGhkR3IkS3bcygor6q/9RNKivRtZD7AoybLuT3fO0UopZMKLuC6GHq5giVR7IZe8FBx+QBA09ojbUp4oZJQeaiMK1w/6i0WsJKfgNhQMf4rDXLRewyf4FG+fV4q2NLO3lmHEWa8NITsB3rMHJSNZBpcAG9n6BKmea6MskMBZBO9AszlRZqoTbKtq2LnveHjaD7+QT4VtZD7VWLlwBxWUvHRI4VCIM74wPS8iOw7LNXjRrDzHO0WaYz2esZwec5wh3jrgRD4VwQqrzqz+jt340VlKnvCfa4JUu14J9X55fPPi5oqW5bRn09bTaC8WeO9Cll0ZOcOAS0FARwh//MlHowGLEb5dOZ5vz2MNt2nYwwW9/+j8FWwEWZQZnO/SULBt8wKF/FpT6flgzemgvy79vsM703KPjMmUD+yPifbWZOO7wQCwprw3Njfq92kPiqGgxFLMLKHEqybVBz59lpFXPA8+sDL7sywaFNSJebTaH+v5XVcELicuRNoGsfU9lMtZt0V6Hs+DxDQIOQWx5FDgPbdtZv3chHisNSP9KaI79PdKTev5dtgE1Xu61wAiq8acfOVMwL/wtGByU6eOMhWAgpFEBHEoCav3Oasj3ESc9aTSw43bwzckUYmsf8c+y3GYq+VF9ngx0k4Ur99KMeuAeOOrzNRic1z+YiipvSMgnQPtXGHpmJeDGAnQ3ocPc5GhOVXHk3zdYJUqQbQzMzkpM9QwVXdUXhLsqtAaFumMGDeAoe9j4tCf8zame2puwGmUgyliZ0AzX1M1wSwWvb/qRNTNU7FGOZDQ/fET7fIWNqO+mpkdiCF8xj+j4eIvU6AMeTK7RyFoQcjIbGA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee4826d8-7cc1-4f97-5ed5-08db777a62c2
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Jun 2023 01:52:52.9154
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rQTjZ88VVESzHrpNbPxceYjA6+TnOPjUVk608O4IkAT6OCmnrVyd3z4D+Zt9awFTIPCNORRxTsMwOdfZHy5Gdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4389
X-Proofpoint-GUID: xgKxvZL3wO7dXfllLqzk4F-st6QEpLsa
X-Proofpoint-ORIG-GUID: xgKxvZL3wO7dXfllLqzk4F-st6QEpLsa
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: xgKxvZL3wO7dXfllLqzk4F-st6QEpLsa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-27_16,2023-06-27_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

U2luY2UgdGhlIHJlYWQgb3BlcmF0aW9uIGJleW9uZCB0aGUgVmFsaWREYXRhTGVuZ3RoIHJldHVy
bnMgemVybywNCmlmIHdlIGp1c3QgZXh0ZW5kIHRoZSBzaXplIG9mIHRoZSBmaWxlLCB3ZSBkb24n
dCBuZWVkIHRvIHplcm8gdGhlDQpleHRlbmRlZCBwYXJ0LCBidXQgb25seSBjaGFuZ2UgdGhlIERh
dGFMZW5ndGggd2l0aG91dCBjaGFuZ2luZw0KdGhlIFZhbGlkRGF0YUxlbmd0aC4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2ZpbGUuYyB8IDc3ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCiAxIGZpbGUgY2hh
bmdlZCwgNzYgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQppbmRleCA4Y2QxNGJjMTY4NTcuLjYyYTIx
YzQ1NTE3ZCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0KKysrIGIvZnMvZXhmYXQvZmls
ZS5jDQpAQCAtMTMsNyArMTMsNyBAQA0KICNpbmNsdWRlICJleGZhdF9yYXcuaCINCiAjaW5jbHVk
ZSAiZXhmYXRfZnMuaCINCiANCi1zdGF0aWMgaW50IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBp
bm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplKQ0KK3N0YXRpYyBpbnQgZXhmYXRfZXhwYW5kX2FuZF96
ZXJvKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBzaXplKQ0KIHsNCiAJc3RydWN0IGFkZHJl
c3Nfc3BhY2UgKm1hcHBpbmcgPSBpbm9kZS0+aV9tYXBwaW5nOw0KIAlsb2ZmX3Qgc3RhcnQgPSBp
X3NpemVfcmVhZChpbm9kZSksIGNvdW50ID0gc2l6ZSAtIGlfc2l6ZV9yZWFkKGlub2RlKTsNCkBA
IC00Myw2ICs0Myw4MSBAQCBzdGF0aWMgaW50IGV4ZmF0X2NvbnRfZXhwYW5kKHN0cnVjdCBpbm9k
ZSAqaW5vZGUsIGxvZmZfdCBzaXplKQ0KIAlyZXR1cm4gZmlsZW1hcF9mZGF0YXdhaXRfcmFuZ2Uo
bWFwcGluZywgc3RhcnQsIHN0YXJ0ICsgY291bnQgLSAxKTsNCiB9DQogDQorc3RhdGljIGludCBl
eGZhdF9leHBhbmQoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUpDQorew0KKwlpbnQg
cmV0Ow0KKwl1bnNpZ25lZCBpbnQgbnVtX2NsdXN0ZXJzLCBuZXdfbnVtX2NsdXN0ZXJzLCBsYXN0
X2NsdTsNCisJc3RydWN0IGV4ZmF0X2lub2RlX2luZm8gKmVpID0gRVhGQVRfSShpbm9kZSk7DQor
CXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBpbm9kZS0+aV9zYjsNCisJc3RydWN0IGV4ZmF0X3Ni
X2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCisJc3RydWN0IGV4ZmF0X2NoYWluIGNsdTsNCisN
CisJcmV0ID0gaW5vZGVfbmV3c2l6ZV9vayhpbm9kZSwgc2l6ZSk7DQorCWlmIChyZXQpDQorCQly
ZXR1cm4gcmV0Ow0KKw0KKwludW1fY2x1c3RlcnMgPSBFWEZBVF9CX1RPX0NMVV9ST1VORF9VUChp
X3NpemVfcmVhZChpbm9kZSksIHNiaSk7DQorCW5ld19udW1fY2x1c3RlcnMgPSBFWEZBVF9CX1RP
X0NMVV9ST1VORF9VUChzaXplLCBzYmkpOw0KKw0KKwlpZiAobmV3X251bV9jbHVzdGVycyA9PSBu
dW1fY2x1c3RlcnMpDQorCQlnb3RvIG91dDsNCisNCisJZXhmYXRfY2hhaW5fc2V0KCZjbHUsIGVp
LT5zdGFydF9jbHUsIG51bV9jbHVzdGVycywgZWktPmZsYWdzKTsNCisJcmV0ID0gZXhmYXRfZmlu
ZF9sYXN0X2NsdXN0ZXIoc2IsICZjbHUsICZsYXN0X2NsdSk7DQorCWlmIChyZXQpDQorCQlyZXR1
cm4gcmV0Ow0KKw0KKwljbHUuZGlyID0gKGxhc3RfY2x1ID09IEVYRkFUX0VPRl9DTFVTVEVSKSA/
DQorCQkJRVhGQVRfRU9GX0NMVVNURVIgOiBsYXN0X2NsdSArIDE7DQorCWNsdS5zaXplID0gMDsN
CisJY2x1LmZsYWdzID0gZWktPmZsYWdzOw0KKw0KKwlyZXQgPSBleGZhdF9hbGxvY19jbHVzdGVy
KGlub2RlLCBuZXdfbnVtX2NsdXN0ZXJzIC0gbnVtX2NsdXN0ZXJzLA0KKwkJCSZjbHUsIElTX0RJ
UlNZTkMoaW5vZGUpKTsNCisJaWYgKHJldCkNCisJCXJldHVybiByZXQ7DQorDQorCS8qIEFwcGVu
ZCBuZXcgY2x1c3RlcnMgdG8gY2hhaW4gKi8NCisJaWYgKGNsdS5mbGFncyAhPSBlaS0+ZmxhZ3Mp
IHsNCisJCWV4ZmF0X2NoYWluX2NvbnRfY2x1c3RlcihzYiwgZWktPnN0YXJ0X2NsdSwgbnVtX2Ns
dXN0ZXJzKTsNCisJCWVpLT5mbGFncyA9IEFMTE9DX0ZBVF9DSEFJTjsNCisJfQ0KKwlpZiAoY2x1
LmZsYWdzID09IEFMTE9DX0ZBVF9DSEFJTikNCisJCWlmIChleGZhdF9lbnRfc2V0KHNiLCBsYXN0
X2NsdSwgY2x1LmRpcikpDQorCQkJZ290byBmcmVlX2NsdTsNCisNCisJaWYgKG51bV9jbHVzdGVy
cyA9PSAwKQ0KKwkJZWktPnN0YXJ0X2NsdSA9IGNsdS5kaXI7DQorDQorb3V0Og0KKwlpbm9kZS0+
aV9jdGltZSA9IGlub2RlLT5pX210aW1lID0gY3VycmVudF90aW1lKGlub2RlKTsNCisJLyogRXhw
YW5kZWQgcmFuZ2Ugbm90IHplcm9lZCwgZG8gbm90IHVwZGF0ZSB2YWxpZF9zaXplICovDQorCWlf
c2l6ZV93cml0ZShpbm9kZSwgc2l6ZSk7DQorDQorCWVpLT5pX3NpemVfYWxpZ25lZCA9IHJvdW5k
X3VwKHNpemUsIHNiLT5zX2Jsb2Nrc2l6ZSk7DQorCWVpLT5pX3NpemVfb25kaXNrID0gZWktPmlf
c2l6ZV9hbGlnbmVkOw0KKwlpbm9kZS0+aV9ibG9ja3MgPSByb3VuZF91cChzaXplLCBzYmktPmNs
dXN0ZXJfc2l6ZSkgPj4gOTsNCisNCisJaWYgKElTX0RJUlNZTkMoaW5vZGUpKQ0KKwkJcmV0dXJu
IHdyaXRlX2lub2RlX25vdyhpbm9kZSwgMSk7DQorDQorCW1hcmtfaW5vZGVfZGlydHkoaW5vZGUp
Ow0KKw0KKwlyZXR1cm4gMDsNCisNCitmcmVlX2NsdToNCisJZXhmYXRfZnJlZV9jbHVzdGVyKGlu
b2RlLCAmY2x1KTsNCisJcmV0dXJuIC1FSU87DQorfQ0KKw0KK3N0YXRpYyBpbnQgZXhmYXRfY29u
dF9leHBhbmQoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IHNpemUpDQorew0KKwlpZiAobWFw
cGluZ193cml0YWJseV9tYXBwZWQoaW5vZGUtPmlfbWFwcGluZykpDQorCQlyZXR1cm4gZXhmYXRf
ZXhwYW5kX2FuZF96ZXJvKGlub2RlLCBzaXplKTsNCisNCisJcmV0dXJuIGV4ZmF0X2V4cGFuZChp
bm9kZSwgc2l6ZSk7DQorfQ0KKw0KIHN0YXRpYyBib29sIGV4ZmF0X2FsbG93X3NldF90aW1lKHN0
cnVjdCBleGZhdF9zYl9pbmZvICpzYmksIHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogew0KIAltb2Rl
X3QgYWxsb3dfdXRpbWUgPSBzYmktPm9wdGlvbnMuYWxsb3dfdXRpbWU7DQotLSANCjIuMjUuMQ0K
DQo=
