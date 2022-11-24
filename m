Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE93637271
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 07:40:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229727AbiKXGk4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 01:40:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbiKXGkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:40:51 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D881DAD27;
        Wed, 23 Nov 2022 22:40:48 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO6OH5r001748;
        Thu, 24 Nov 2022 06:40:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=wIX8Tc1UFkB+/p/X0Mj7veETRAIdZTUGHtiCNC1GTS4=;
 b=jtx/FBTnAzSoUIphrTXVr/bbJzYDYRRgIFucXU5Tiq6ITf4MozX1g3K8ivX+cxohVwKo
 3HgV+mfE56c+/aBTNBW9W3gRhEAJkIJk6SM9wMiztC1d8pwTpUJRJjA9HVFVs4PLsBqo
 gTCX9m4zBmeNGCIr7IL6s0YFjJ478Om8vpNpHaST5PumX6b5zIUcZgnTcRacd5YoZtHu
 kDmJrN2XbohzKgqOouCUfHumH9YXC9v2pCNDH4vXCGYkpr3j2VqeMQTvp2Nmdk2afN7+
 Fr0ubl89ctLT/iqgzrRIiUEjVc+0tiDhMBTijbEcwx477OhLZmz8WnZSYPq2icErZkf/ LQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kxrb94t31-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 06:40:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Uq12ZB52w1zaoQH6onPLRT4KWU5F7EdW4dXA+FsimsRSbSPU1ODwy+NayStD5Y+Y6LwgQiapT9pZlI1qHLxpPD+7CJpg8A6FYbbKXblGXi7Kj1sWRgJWtzHAM+677kHK1C0q5+OilWSM8yGWu5hNU+wgWP/nFZ3Y41+rYW61xOLrVtTfu0Eq5wUlyN6eizMxLOcq2fbgxAbGIpPcRpaX7DH2CNpBpAIXArIT84247Xk7h01NEU6Vgks3ZxFordjXtSB20DWWAK0ntYtr2XUhEvoVKJAyvA5L0o7MrKenjlWQG/oSStzgGiL4KVkLERRdTbq5zmnFmqpl9wp7YDtwEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIX8Tc1UFkB+/p/X0Mj7veETRAIdZTUGHtiCNC1GTS4=;
 b=eHb/a2E6eBnVvFgFIlKpg9m6v+Azl3WnbcbGvWWGnLTm6v2a1a26zk9Wm95hELDDRWTDHwg0Q+DuCMScxeCcSuv32KR9nGh9Y6c95XaflBBr8M97nQRto7D/vrXGSzuS7yKBnONmLqLMGMt6JmYfditG2gZWfmKg7LXitDkXEVL88U2r1ureDPV9UTyVZRolcX+Dbp0njVfUD0PppuglYuRiYf98mty3Sdc3TMPK3K1Fyg+OscK91nq7UycvvF5wdT52A3R8d6tiN5FZBvBodma2kiyP8GueQXHdhSBwEc2uKcVEH/Vyq/rxH+CEql0G61MKn328d0Zu8YNAXzy2dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4425.apcprd04.prod.outlook.com (2603:1096:4:e8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 06:40:24 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%8]) with mapi id 15.20.5857.008; Thu, 24 Nov 2022
 06:40:24 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 1/5] exfat: reduce the size of exfat_entry_set_cache
Thread-Topic: [PATCH v2 1/5] exfat: reduce the size of exfat_entry_set_cache
Thread-Index: Adj/yZ7/ZJx2fxByTueAE189lTyjlA==
Date:   Thu, 24 Nov 2022 06:40:24 +0000
Message-ID: <PUZPR04MB63162A898D74090614E33B32810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4425:EE_
x-ms-office365-filtering-correlation-id: 0bf6b9a8-5f3e-48d6-2629-08dacde6c40e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8niHfsphtpCfT7FGnEST3eWyynL5/9N60AFAzS4PZYtJqgJPgl0GQybKi6sg161g0qVo7+abAFUGBAJ2I49a0Gti6qDVEc50NECZAN+EyAtWKE9ZhsbMeiAJb/ANEDNvdLUMH3hXOJm3cZLp00ed9XyFX5vzxX3/S6DcanRJkRpeK4muWa06si4yTKEgYTJaot+2CtdyIDhMd7UZWsYg95N1OSw0ca+Vj9QDSjmsWKIkJykyBNHj4DAKyG5QZvSsI1x89Kbx6RQpXfuCHekepOITnQ0Fq0NBWbbYp9rEKgPZVUVdc3tuvptCFM0UGVOps0521qiQavWGjvh8N6xJPECVElg7PoNe+UmCsuOvylaMLR1594BkDevBvlg3Eyat+20xW7gt5uUjeUD9ADnhQIzYHRh1MjkzYP01onTKRLSnxw7LDsUiF303p890sLE9cgAoVf4cfvEqgS8c2qJkwUkJjPXF6vPJKR2lEX8p+2/yQa4GWhlPUbC8DNWjbn8mqaCq7GjBJsqFyHX2o2LE8G2x4AjfYcIbvscB7LC39VTruvul50cBINNkT6i4ra/mIgcqKVEAirFEz60UhJ93aqJU8V2LrqO204XxPA6aprH+wXNp090OPcPHpikQnB4+gEDKQbKbnhBIdNEXCw4xsR90kxGvCXijJQRaD2shB8WmhpZWHJi4wyOnySJsflrrkzIv/iK+v4Ybr2u87/QrRA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(41300700001)(8936002)(478600001)(54906003)(4326008)(5660300002)(316002)(66556008)(66476007)(66946007)(76116006)(52536014)(66446008)(64756008)(8676002)(71200400001)(107886003)(2906002)(7696005)(6506007)(9686003)(186003)(110136005)(122000001)(26005)(38070700005)(38100700002)(82960400001)(86362001)(83380400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d0tKNnZ6RmpJN0ExL1FnQXprRldPSFdiVjBNTWJkQU1ReS95dFR5bU9PeUJq?=
 =?utf-8?B?Y3dDaHdWYnpTZ3pDNnBLWE4rbWwrMXZRUVlJQzZkc3Q4Tm1JdjFLYTg4Ukxy?=
 =?utf-8?B?dEVXbTdPTnhIYnRVdkY3YVdSMDBIaGZCUWZPZ3V2czVQTG5Zelo1V29YV1Zr?=
 =?utf-8?B?WHd4dDN1YmZtN2twajBnZ0hCVzFPaGtDQnA2L2IzQTNJUWZ3UzdtZFJWTkNZ?=
 =?utf-8?B?OFB1OXlvTCtLWEJwYVVxMlJDd2wybCs5VEFUeTNTbmZ6Vm9qeGtHOTJjTzRt?=
 =?utf-8?B?Sm4xcUo4bCtxNFpESUh5S3JOR2tXWXJuZVd2U2NSai8rYnowL0hkWWZKcFdX?=
 =?utf-8?B?Vk5xZXJqbUkvVkV3WWdUbmdiTDczd3BOR0RTSi90ZGFrbWw5bVVWZENOMzFn?=
 =?utf-8?B?M3hyb1djbmNmNm11NDhOL0ZkZUZoY2VaUnUvdTFvYVdwaVhJR0EvcnQ3Z3p0?=
 =?utf-8?B?WTJLWGFxNFFiVk84QzBXRlQwOHAycXE3ZFhOZjhCbjdYdnBienA3RU82M1Ra?=
 =?utf-8?B?QWd2MnFnWDV6azJUYldZNjNPWTBaTlAxMDI3ODVXejlTTlNqMmdheWRSQVVS?=
 =?utf-8?B?R3lPeFErSzVXdWdJS1hEUlhIZjIxY0lmMUtkRVpOZWhrMVQydStQVXRhYWZk?=
 =?utf-8?B?QUwrdng5c0c2YUtWdEVaYTh4N1RLUEhpeFlrN1FaOS9RYUlVbG5FQzRhWUhF?=
 =?utf-8?B?UHpaVThTMFYrcEdsbDhLdDBFTFlxUHZubUFrMXJGZzFGWXE2Y2pweURCUVNn?=
 =?utf-8?B?ajZiQXV5Nkc0Ulprbk5RcUxoSlNtYkc1YlhnY0ZNZ01rSVZmV3VqaCtLZ0VB?=
 =?utf-8?B?VlRMc3VCOXpaYTBCM2lScHRIamVlR0k1OWZFcDVVNUhuK0FVWWVqek0yc0tI?=
 =?utf-8?B?VGhjT1RVMGhlTG5BT0Z0TnFMMEJ6SHU3OXBzeEw4TFR2elJIeTI5emI4Zlcv?=
 =?utf-8?B?aXAyM0VTNXFqRkJNNURyUVRSV3pDc01BdXJoWll1QlVObWVHQXdDb0JkUkZF?=
 =?utf-8?B?Q2dvZ1YzdkxET1YwV3k1WDFMcXlycCtCNnFLT0pqMjNzbElSOFB5Mjcxa2F2?=
 =?utf-8?B?ZFF6anJLQ1IxdnFmc3FwMTFrY2czNFkvb09xNDRyVWQrREJqR1VXTVR6eU9C?=
 =?utf-8?B?QzFSc1ZIQWNvczg5RWV5YUJqRmY4c0JwNk9qczJWUE5mc0Q3NE9TTENqOEpQ?=
 =?utf-8?B?QkdxeUN0OEt5YWVsNGZOc0NOL3hZU0pMQjhuVWlINko4a25NdzI3M1BZRlZh?=
 =?utf-8?B?bnVEeTZkazVYazlsRXFuT2crZHpDVm42dUlaYmIxZGR3ZENsMURrSnl1UHRV?=
 =?utf-8?B?dDUwVzhBazVsZy9INVppMS9nc25JL3I3TjZVL2MwTG9SdEFkMlVYUVBKK2lB?=
 =?utf-8?B?OC81SmphUnl5d1R0elNYc05valpIUVZqY25vbkRSeWFuanl6OFJDTytrNVhT?=
 =?utf-8?B?dEh4YlRtNzhTRDE0cEdQbzlpYlF0WUVhVGVOUlAyQlREdVZqNS96REFSZ3JE?=
 =?utf-8?B?Vk1zQmpPNFRRTDRrejBWRk1oWmlhdW5sRDR5S1VudEUrY0hCSUtsbTQvNjIv?=
 =?utf-8?B?c1JYdTY4TW9XcURGdXQrQU9Rb2plQU14RndXZTY2YzVkdHp6ZzFRVkQ3dGxC?=
 =?utf-8?B?c0dSUVVwRGp5U3ZmYlV3cURmcSs0UU9WS0Fja1lDRUlla1Bpa0lCaUlQdGtY?=
 =?utf-8?B?S01PTHAxdkJoRFRlM0RTNFIwQmZjMXpCdjdQYkYycDRhdW16TmtIRlI3SXpM?=
 =?utf-8?B?MzFEK1NJQUtoSXh1eXEySWpHVHVuQzNxenpXb0pQdkkwS2s0emcxYVM2TWxC?=
 =?utf-8?B?UjhYZXRUT3VWYmRoZVBjTHBCUUlKb2pzVmM5L3ZTMUdnUHk1M293WW5rSWh0?=
 =?utf-8?B?RDU0NUx0VDBQa1YrZFZRUEY3WmNCN0FDbnBpZm5zblJZN1FIbWhPUEpJbmg0?=
 =?utf-8?B?VnFnc3RLVy95eHkwWDZCbStubEhnLys5bHFtVVo3VG1nQldDQWxGTmFUbzFT?=
 =?utf-8?B?T0hvbWFRajRzaGpPRjlsSnBIWGd5M2w3WFBVbEJpWndwZnB4U2FBeW5oYTNB?=
 =?utf-8?B?d2czdXVMMHZuU3JwRzh3NStKY0RROE9iTGNoZnVpcmlidE9raHFuRzJobDcx?=
 =?utf-8?Q?I8yJFfbQDMQg1GlztICjCZsnz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kCaCHYa+LR+l5i5vDkuCZqc3ezmgHoxlj1WBX9WdSTPdsx1oc6nqR45h3fDZtn88HDjeFqSDxbWhi95mQC/YxdPJELbfBsJoHh4/awc+nS5rXqzio8jM6aa1pb6lw8BI+3AyYc4t78pfQBvcMooYZ0hOiujBI+4WsH1bJtDbKN7ZO7Nk4XLy4P8vCzNehg7/mMHJXhIrQ3qmqfjLV9KvM1QnlOZLEfSTMUpS6TSkcmPCLFa4LVNJ75R7wydRekoCSNwW09wg2yS5DBQz7Sd6hRrcaZiYi/abogIKWx1fx5spZ8TSCcTFqPS2xfktvedpU3LuVHMZBd9pZO556ehC+bxydqOMwOHrL8s9SBVRZlSF+hZnNxiMX1G57+fSa1sVcuU8z5lOIvhklL9P7TaCCcthaF5yG3i2KSn0/Xyv+bSIzMIVWyPBx5A4ocQzQ3PfwzKwKhU75uvNbcABYVTyeEgV6sCSt11FDp3noLA7ErLEzQhvq9dlZ6wbse6xxkvQgG+zg/c2z5h82QTKdiiaLp7GRCmr74OURhdMAc2dYg64jJDDKS00bqKA4cQ9qFS3IPuGzNzqkGuI5uQgX6havOrXL4I/MjDMbikOwNzLHfWNO655K40u4HHpNfPLy2jvMzJk/KhW0Hjd3OYAD/so3e25MXP2I8Wdjb7/dmhC8mWixm8rm9WVv0bGubXxlNjoP9oLLcQeJ3ZVakO/a2J/t0s0B7nYqv3GGqEtvfhiNRWbrQbVSb3raQxeyxchq/krkv/gurB8yCGRj7SwJOR3rxJ0FVKj0a2Xq1wc/VnS76MpzOGm4gtzgSmLCUsJGR+YPnqL0gamBfD6tllXobTgSXZwNKeTZa7y3pIXdQmwAQeQicGbEmW62pY0SM5efu7o
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bf6b9a8-5f3e-48d6-2629-08dacde6c40e
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:40:24.1624
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wuLJLDTRCJtvo82xcZvB4/8nt58fcefY4UZiPZpTyEr9hr9WBS62t+s1i2Xjz8cERScS5G7U3r3lpuJolwlIuA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4425
X-Proofpoint-GUID: ELW1dhsxZXR2tZ7Y-KoLyvFXVq2shLTh
X-Proofpoint-ORIG-GUID: ELW1dhsxZXR2tZ7Y-KoLyvFXVq2shLTh
X-Sony-Outbound-GUID: ELW1dhsxZXR2tZ7Y-KoLyvFXVq2shLTh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-24_04,2022-11-23_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gbm9ybWFsLCB0aGVyZSBhcmUgMTkgZGlyZWN0b3J5IGVudHJpZXMgYXQgbW9zdCBmb3IgYSBm
aWxlIG9yDQphIGRpcmVjdG9yeS4NCiAgLSBBIGZpbGUgZGlyZWN0b3J5IGVudHJ5DQogIC0gQSBz
dHJlYW0gZXh0ZW5zaW9uIGRpcmVjdG9yeSBlbnRyeQ0KICAtIDF+MTcgZmlsZSBuYW1lIGRpcmVj
dG9yeSBlbnRyeQ0KDQpTbyB0aGUgZGlyZWN0b3J5IGVudHJpZXMgYXJlIGluIDMgc2VjdG9ycyBh
dCBtb3N0LCBpdCBpcyBlbm91Z2gNCmZvciBzdHJ1Y3QgZXhmYXRfZW50cnlfc2V0X2NhY2hlIHRv
IHByZS1hbGxvY2F0ZSAzIGJoLg0KDQpUaGlzIGNvbW1pdCBjaGFuZ2VzIHRoZSBzaXplIG9mIHN0
cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgYXM6DQoNCiAgICAgICAgICAgICAgICAgICBCZWZv
cmUgICBBZnRlcg0KMzItYml0IHN5c3RlbSAgICAgIDg4ICAgICAgIDMyICAgIGJ5dGVzDQo2NC1i
aXQgc3lzdGVtICAgICAgMTY4ICAgICAgNDggICAgYnl0ZXMNCg0KU2lnbmVkLW9mZi1ieTogWXVl
emhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFu
ZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFt
YUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAyNSArKysrKysrKysrKysr
KysrKysrKystLS0tDQogMSBmaWxlIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDQgZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhm
YXRfZnMuaA0KaW5kZXggYThmOGVlZTQ5MzdjLi5hZjU1MDE4ZmYyMmUgMTAwNjQ0DQotLS0gYS9m
cy9leGZhdC9leGZhdF9mcy5oDQorKysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQpAQCAtOSw2ICs5
LDcgQEANCiAjaW5jbHVkZSA8bGludXgvZnMuaD4NCiAjaW5jbHVkZSA8bGludXgvcmF0ZWxpbWl0
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L25scy5oPg0KKyNpbmNsdWRlIDxsaW51eC9ibGtkZXYuaD4N
CiANCiAjZGVmaW5lIEVYRkFUX1JPT1RfSU5PCQkxDQogDQpAQCAtNDEsNiArNDIsMTQgQEAgZW51
bSB7DQogI2RlZmluZSBFU18yX0VOVFJJRVMJCTINCiAjZGVmaW5lIEVTX0FMTF9FTlRSSUVTCQkw
DQogDQorI2RlZmluZSBFU19JRFhfRklMRQkJMA0KKyNkZWZpbmUgRVNfSURYX1NUUkVBTQkJMQ0K
KyNkZWZpbmUgRVNfSURYX0ZJUlNUX0ZJTEVOQU1FCTINCisjZGVmaW5lIEVYRkFUX0ZJTEVOQU1F
X0VOVFJZX05VTShuYW1lX2xlbikgXA0KKwlESVZfUk9VTkRfVVAobmFtZV9sZW4sIEVYRkFUX0ZJ
TEVfTkFNRV9MRU4pDQorI2RlZmluZSBFU19JRFhfTEFTVF9GSUxFTkFNRShuYW1lX2xlbikJXA0K
KwkoRVNfSURYX0ZJUlNUX0ZJTEVOQU1FICsgRVhGQVRfRklMRU5BTUVfRU5UUllfTlVNKG5hbWVf
bGVuKSAtIDEpDQorDQogI2RlZmluZSBESVJfREVMRVRFRAkJMHhGRkZGMDMyMQ0KIA0KIC8qIHR5
cGUgdmFsdWVzICovDQpAQCAtNjgsOSArNzcsNiBAQCBlbnVtIHsNCiAjZGVmaW5lIE1BWF9OQU1F
X0xFTkdUSAkJMjU1IC8qIG1heCBsZW4gb2YgZmlsZSBuYW1lIGV4Y2x1ZGluZyBOVUxMICovDQog
I2RlZmluZSBNQVhfVkZTTkFNRV9CVUZfU0laRQkoKE1BWF9OQU1FX0xFTkdUSCArIDEpICogTUFY
X0NIQVJTRVRfU0laRSkNCiANCi0vKiBFbm91Z2ggc2l6ZSB0byBob2xkIDI1NiBkZW50cnkgKGV2
ZW4gNTEyIEJ5dGUgc2VjdG9yKSAqLw0KLSNkZWZpbmUgRElSX0NBQ0hFX1NJWkUJCSgyNTYqc2l6
ZW9mKHN0cnVjdCBleGZhdF9kZW50cnkpLzUxMisxKQ0KLQ0KICNkZWZpbmUgRVhGQVRfSElOVF9O
T05FCQktMQ0KICNkZWZpbmUgRVhGQVRfTUlOX1NVQkRJUgkyDQogDQpAQCAtMTI1LDYgKzEzMSwx
NyBAQCBlbnVtIHsNCiAjZGVmaW5lIEJJVFNfUEVSX0JZVEVfTUFTSwkweDcNCiAjZGVmaW5lIElH
Tk9SRURfQklUU19SRU1BSU5FRChjbHUsIGNsdV9iYXNlKSAoKDEgPDwgKChjbHUpIC0gKGNsdV9i
YXNlKSkpIC0gMSkNCiANCisjZGVmaW5lIEVTX0VOVFJZX05VTShuYW1lX2xlbikJKEVTX0lEWF9M
QVNUX0ZJTEVOQU1FKG5hbWVfbGVuKSArIDEpDQorLyogMTkgZW50cmllcyA9IDEgZmlsZSBlbnRy
eSArIDEgc3RyZWFtIGVudHJ5ICsgMTcgZmlsZW5hbWUgZW50cmllcyAqLw0KKyNkZWZpbmUgRVNf
TUFYX0VOVFJZX05VTQlFU19FTlRSWV9OVU0oTUFYX05BTUVfTEVOR1RIKQ0KKw0KKy8qDQorICog
MTkgZW50cmllcyB4IDMyIGJ5dGVzL2VudHJ5ID0gNjA4IGJ5dGVzLg0KKyAqIFRoZSA2MDggYnl0
ZXMgYXJlIGluIDMgc2VjdG9ycyBhdCBtb3N0IChldmVuIDUxMiBCeXRlIHNlY3RvcikuDQorICov
DQorI2RlZmluZSBESVJfQ0FDSEVfU0laRQkJXA0KKwkoRElWX1JPVU5EX1VQKEVYRkFUX0RFTl9U
T19CKEVTX01BWF9FTlRSWV9OVU0pLCBTRUNUT1JfU0laRSkgKyAxKQ0KKw0KIHN0cnVjdCBleGZh
dF9kZW50cnlfbmFtZWJ1ZiB7DQogCWNoYXIgKmxmbjsNCiAJaW50IGxmbmJ1Zl9sZW47IC8qIHVz
dWFsbHkgTUFYX1VOSU5BTUVfQlVGX1NJWkUgKi8NCkBAIC0xNjYsMTEgKzE4MywxMSBAQCBzdHJ1
Y3QgZXhmYXRfaGludCB7DQogDQogc3RydWN0IGV4ZmF0X2VudHJ5X3NldF9jYWNoZSB7DQogCXN0
cnVjdCBzdXBlcl9ibG9jayAqc2I7DQotCWJvb2wgbW9kaWZpZWQ7DQogCXVuc2lnbmVkIGludCBz
dGFydF9vZmY7DQogCWludCBudW1fYmg7DQogCXN0cnVjdCBidWZmZXJfaGVhZCAqYmhbRElSX0NB
Q0hFX1NJWkVdOw0KIAl1bnNpZ25lZCBpbnQgbnVtX2VudHJpZXM7DQorCWJvb2wgbW9kaWZpZWQ7
DQogfTsNCiANCiBzdHJ1Y3QgZXhmYXRfZGlyX2VudHJ5IHsNCi0tIA0KMi4yNS4xDQoNCg==
