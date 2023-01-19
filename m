Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 327FD6733B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 09:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbjASIcD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Jan 2023 03:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229695AbjASIcC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Jan 2023 03:32:02 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF9E44B8
        for <linux-fsdevel@vger.kernel.org>; Thu, 19 Jan 2023 00:31:59 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30J7x24G023629;
        Thu, 19 Jan 2023 08:31:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=5H2q1JwGhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=;
 b=g6IZkGhni4quPrBlv4JEVzS0m5MrOy1dS9FRvVW7dk4GPXV69q+R43nFC4pmbwWCY+yv
 rDuFBJLIDtff8qG9H8i6MVHcT7C6YgBsceNNsfdfkbI1DY7d56u4AY8WsMoiSLTKlsVP
 c7RIfq6kdHGt1MFtWJCIvuz03yxdFRCHK0b7p7g9oSOY8LQLBJrkI2qKKqAJNTYgpHSH
 sHihGuIwdduAZx7tokEA+bIhtKvPMzwL1BV+AdCDKehtH6Q4ewZZF/BogxoxoPyDcR+6
 ROaDw8OC8I3MR4XKriYzEp3ivOhKxsT/X09WXToiN4bJUUSNlJnz5Ntw1HivJIxNDdJb HQ== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2049.outbound.protection.outlook.com [104.47.26.49])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3n3ht5w5pu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 19 Jan 2023 08:31:30 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZKTa8qgvwDtfUCkh86q+P8R+dY771CTqM1+IOtSd2voF4hzX9gnDGD3h9hRO0Rag6ozeW+OZBh2qMK4wtfBkIV8W8b5GXH4JppwmEB4aA21k2K+mU2gbfxjzbdKerGlmFyxejkyQLPfqSxGcQOvrNJyw65u37w23Kfu3wrCoTrgC/EJxHaksTkSCrRo11sULgsBOs1acsDkTkeds5Yylla0GHsiglfzTEoWJTDrR/TEOV/38Fd3Tqy7v/tokMKCy7TdUHMbVkgfKxsUxi98T46BQW6T3UmhXYZmcFBb8GqReMU914UIvMuTrqtlL+BLbSYxS3DaF+yhPfxw83bICzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5H2q1JwGhnJGk7PlCN6b1q2Gjz4BX0h7RAnR6ylMq+s=;
 b=Z+C5VFmBU3IayxDdhweNkAzb7okZmGvVs0kRb/9J1rruKcayyWHP0stZMOZnpiJss9lEPmtwlWsItDCkELEo73zBadUGC2Z1sJSHGKWQlXj4BVGA4dwQ/Mj3XEtVPHJqLenF5N4oIoG7nAt7CSSRZxxe5oraB72F2HtjIahG0lQLCXE/c0jS919yxUd7QoqyAKdeIj1wWf3fSsHR7gnU5MW07eyEeEXx+93aaxZUvOmTyHWBmg9v0ykTdRIXVCyb7pUuxwr+xecoVsLt8aXMD6MuWHTg6/1ksXAZWnQ8iuS46dp5mYhWD0FkebDbQTFGxkt3BiDfFfFCxgHE6jSG5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by TY0PR04MB5767.apcprd04.prod.outlook.com (2603:1096:400:204::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.25; Thu, 19 Jan
 2023 08:31:25 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%8]) with mapi id 15.20.6002.025; Thu, 19 Jan 2023
 08:31:25 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
CC:     Wang Yugui <wangyugui@e16-tech.com>,
        =?utf-8?B?QmFyw7Njc2kgRMOpbmVz?= <admin@tveger.hu>,
        Sungjong Seo <sj1557.seo@samsung.com>
Subject: RE: [PATCH v3] exfat: handle unreconized benign secondary entries
Thread-Topic: [PATCH v3] exfat: handle unreconized benign secondary entries
Thread-Index: AQHZJ89k8zWBjWKpG0OH2bCkvCIGtq6lcGzQ
Date:   Thu, 19 Jan 2023 08:31:25 +0000
Message-ID: <PUZPR04MB63168725D434A4FB60D6A03381C49@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230114041900.4458-1-linkinjeon@kernel.org>
In-Reply-To: <20230114041900.4458-1-linkinjeon@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|TY0PR04MB5767:EE_
x-ms-office365-filtering-correlation-id: e8073191-ce0e-40a6-2ac4-08daf9f78d73
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0THKJAOxQd/UtNEDq0Xfk+/XQNtQjSZ6TRkTxaS3AffHJt147GpElHQG1duyPEaD1xn8EPRLQKYQ7kOsw8JO0g3BLafj9FNaAZQOwlKDBBXKkjwkQry6Bo0rVHIqK0rR2CY+adDhIZfPXjzS5jS1SinRPYAlnYww0CPcUesJAGUIXJTAlY4Xg4tsfNZrPf6V2IWM0LyuEUi5ra7Ta2xsltZsAlRCgo2dO0a2f1koPGXX1jSpPcLLWXxvauJ5touQRsu/aqmYQHQWcfqfrlaJlqzGoRCPpLO4Nd19RvakehWz1CcZy7vY96LE320d3Sbee5lle0QbpUHZjbGyvrDv7p+h0DAM0ctFUdUya0u2atuiEwyBoiOmN0hjXvNaEtoFuFp/tPabUv1Tt3OkE6OuAWH19vg5aidyy/NAaW9wAsGX45jyD9FfFR28c6xObkCiKPYaZnGo6w7bEqWyI93LVMhizmfIoljjJwucRRohAgoboERlK4BHKMk0s0QEKac/nqlkFJArRZ6Gm1ndtxINUpUW+2qMZ1flDocmxUvN/bksJBoEZjjfNMOZfjZ1/GB9mvfK6fb0T9XqslRGCGSPSua714EkLkxSC62n9nR/rVxzbX/hjE0FSA13KNgpC1pisQmavgKhRK55dQDV0oWQRkN/WhGrydwaWUdmiTUilsEcWX1vDzupUVlep8r36MDpnyswIynYrsLKQG2rNkFI5w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(346002)(136003)(396003)(376002)(366004)(39860400002)(451199015)(478600001)(2906002)(19618925003)(55016003)(7696005)(6506007)(9686003)(26005)(186003)(558084003)(4270600006)(33656002)(38070700005)(41300700001)(52536014)(8676002)(8936002)(122000001)(76116006)(66946007)(66446008)(66556008)(64756008)(66476007)(82960400001)(38100700002)(316002)(71200400001)(4326008)(86362001)(5660300002)(54906003)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WGVKK1d3OExVanBSR2M2T2tqVC8yb0VZSnBtRExON0QvczhqOG41K0xqamNw?=
 =?utf-8?B?dzhKVnd5ejVzc3FzZjRtT2UwUXJkeVFTME5zUnZlZXh4L2FocE8xQ3J1L3Vo?=
 =?utf-8?B?VFdsTUZaL1VuV0JZWE9UQnpKNzk3OFpjSlh1clVxaVRsdzdYaGdOLzBoVFNv?=
 =?utf-8?B?UHJXUDhDSk1FMjcxZUlrd045VjZvV1U4OFFMWkdGZFkxTjltamZEcm1CanYr?=
 =?utf-8?B?b2txcERMcTBrSjBUMWNJTnNBTUpLOFoycXBGWjVhNDlseEN5bzJCODdGMVBo?=
 =?utf-8?B?Wld6aDltZDJpcnY3Tk8wOXVnVDdLWk9VeDNCU0ttZmwwVUxPSEtsWTdRZFJr?=
 =?utf-8?B?dmFKUDR1WGV2ZjZMcUpYSlRWWnhQa1M1OGs5UzR1WGpZLzJSRldqSE9abU1w?=
 =?utf-8?B?WE8xZHZWYTVReWNSQVB1VFV1NjRnUGR2clZkNEowSjMrcFdWWG5EdTN6V2Rr?=
 =?utf-8?B?aGQyME9LaWsxdGZnb2FDSzNDSTZ6SzhtU296RDFaQWFuMjNZMi9tMzF0aTd2?=
 =?utf-8?B?b1NNb1FhdlpPS040ai8wQkZ6ZjFnc2JQMHY1NjNxb2JYNHpmL2xRd3I1WE9n?=
 =?utf-8?B?SVJKVW8xRmRxelNFeTZBQlgxRU9mS1dieFoxTVZmbzlvSSs5T2dGMWFtVmRh?=
 =?utf-8?B?VXNVMHJzb2lYd2ZZNEhSdXd2S0JnRDJwVDl5clZ4Q1lFNzhtbUhYMGpjRTRT?=
 =?utf-8?B?YWJzK0JrN01sWUZhSUZRaWxiV1VSRHlZNWJ5RlVRdHJFVFdEcDAxa0hEK2hY?=
 =?utf-8?B?aGJtL252dURSZnR6SHpZbko0SzBJUlF3cHNyVDQ1SHdxNWdCZWZIaXZuUWth?=
 =?utf-8?B?NUZ2TzYweVk5bHhtb2t2dWVEeVVsSHFpSjYxUGFIbVlNVjdScjlTb004ZVpk?=
 =?utf-8?B?RXN5YTg0OVBxN3VITlkxZzZMRk1EK28yeTNpWTJzekNKYUs4Uk44ZG14M3o5?=
 =?utf-8?B?TFpOVm9OZG95MjgrcVc5QWpmWU5MZWpVamZJU0VsSDFSOXIxWHVEcFdhRG5s?=
 =?utf-8?B?UlRZWmRSM3drZTNsV21IeUNjc25iVEpCcG1jdXlQbTNzT05JSFZXa0JFU1Az?=
 =?utf-8?B?OEFFMUk0bVV5WTJzQWQxUytMQjJzbHNsa2NJdFpUL3lZbmwydVhvYlF1cGhT?=
 =?utf-8?B?NVoyZ3NxMzQraG5WRFhPSVVkREhkYlFiMkk0cCtpdmNjdVNGQ1dXai9ZekhG?=
 =?utf-8?B?RkFQZFIrdXFkSVNMd3NDaUNOOEZRcmR3UmZ5WkVRdXdrcFBXRmVuOTY2U2ZB?=
 =?utf-8?B?SFgwdnFESjlSM0x3Z2FyT0FCdWU3YkIzdlo4bEFEOVZQZkJ2MnJFTjZtSGt1?=
 =?utf-8?B?V3JuSGNPN1ZaakZPMWRzeFdGeDRwL1BBeXJVeHNvdnhBL0l4N1cwQzZTdmtm?=
 =?utf-8?B?NFpJWUQ3ZmNtKzgzdFJrb1dFZWtGM2hyUTF0cVRPKzRTOSsyNHllWjNQUmcy?=
 =?utf-8?B?bXlCSTVuanNGTVVtK2p1cWc0b3dKaEdMR1hITWlHRmJGdzQra1ZSSGxuTFBT?=
 =?utf-8?B?eWYvZ0t1RWVOdFpQeDFHcXB0OWwrWWRlV0FQZ1dYbWlPeUNwRnJieURSYXBN?=
 =?utf-8?B?dzc4aU8rL3lKQXJueFpvbThEQzdGUFRKUUNkei9UU3MrSWVFSUtmelhIdkFU?=
 =?utf-8?B?ajlGeVZIaWNMNk16Y2xiYzAyWU8vVGdXeVk3L2ZneGwzL1VGSS9GRUs0WExu?=
 =?utf-8?B?Z0JLYTMwWHJIeFBscW1oS0hNckxXNjMwNExXOTh1aktOYVJ4M2o2RVdRUDBB?=
 =?utf-8?B?b0VvTmFwTjVmb2p3M1BxL0ZWRk9WYnlMOE1iMmZTbktIcEwrUytSeG1TS0tq?=
 =?utf-8?B?VDlBWDBZT2pSTmt1cHVtOWVzZjEzUWNiQ1E4TWthRDJ0K1NKZ0pHOVdyOEdL?=
 =?utf-8?B?MjR4VVJsMDZnMm5obEQ0dkU5emF0T3FMbTJGQlI3VzVBcUVrOSt2T1VUVXBR?=
 =?utf-8?B?ZVRERHVMdGpKUEVxZ1VmbXBOMlBvN244WDlONUpUVDFYcG13dDhqWUNHZEIz?=
 =?utf-8?B?eEh3QTI1STdrQmhoYUR1T2xiZVRsdDBLTlYyTzFOdWhDQzFuanBTa0x6VjYw?=
 =?utf-8?B?SnFDU0p4NGxrQVgxejRUOERUekVGOWkzSTQ0Yzk4angza2xGbkZvdm9mSjhE?=
 =?utf-8?Q?l37aUrFZYTMyHarzMQ8S4Z44F?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: VEeTPs6bPHFupzbJftSyNGJC/js1MiQsrKbQYT/nqTD5fxvlyNvMCB0zIhhqyiAsI8BzbRuJt6ByBgpHWl1D8YpyZISEQ8dyQ8I3wn3SweZaVIqFOMEbOlA7wMj6MkjOdvzqRE/lDKYdts4wVyFElbTsxzbzRvfchRwsqzMMBG9XM5ThYvVPoz+IcroJ5GATRXsk9TJHY8kRUDRqFS+BB/thNvyjuqP2AlycdztY5z5tBYQ+1TQ3Zs6uwWuZLtRQ3yjkphax7Xdt+M3b4TcZC9U/5vcQJQHFZKd4si/VKvYTdAUoFStBjBV6dkDjvyJjf5nx2cYRmxwnE8Usb/nzIKcCNQ+5jPwbK9u7oq7JLcoqoVRT3wr077IIbpajVFfEJ3adv4n34eIsH+40b5ImcnPyvmcRBzlHpeolcFsRLjST8bJ5nwk3MmbeyKG3ZbyfhP8r7FCNApoqCcLMJLen7EF4chVnRYGwWZ2fd8A1FGHoe6uHDTa7g8g8FdBYXINj/vjRH01cEzAPf2rVzCWCFlweFufNruGZQRiRcyQ4z67P8T7u+jC44FUrX4QTi11SRh3mz/E5ukSrX0qkiVXblQrodQfJtw4yvvuta4hPsN2D0QUL4ZKPOOZ81LBub3qxLdRq+Blv7puJHPkXU4+/CSHI6gCQLAMYgC+UZSeKb/mU2lYWIOfjzhMRV/0CBLIN3ky+NAimWFi+KSBREo3WacGrGLTg/aZClwIriWa9nLZPx61S/bxZOeFY1EiEIAdceON3auyoWy6qyF8XPXP8kJxFCuRktXWWd20ZjKh31qNgtiNMw0FEoZZgC/ynZRGT3M903OXA1TAQQM4HWznSpllHAf9KYctSIRjNrnYZGo8OnzoJIbLZvopWBm2V/vttCebC7JdZOi1sYNnXDB7C6g==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8073191-ce0e-40a6-2ac4-08daf9f78d73
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jan 2023 08:31:25.1407
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: +mEnk50ahR46S+ThQLnsKJlO9axjDvd3wWKfmJd3O+wVJdfIrttoKkmHVS5Gynw2ezFfijyM0EKr5AZ/UsDmCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR04MB5767
X-Proofpoint-GUID: BdKvgckWPxEB3NlgRMHFS3T4ghCevLAn
X-Proofpoint-ORIG-GUID: BdKvgckWPxEB3NlgRMHFS3T4ghCevLAn
X-Sony-Outbound-GUID: BdKvgckWPxEB3NlgRMHFS3T4ghCevLAn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-19_07,2023-01-18_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

UmV2aWV3ZWQtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NCg==
