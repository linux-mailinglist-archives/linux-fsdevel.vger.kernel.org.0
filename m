Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854EC63726F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 07:40:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbiKXGkx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 01:40:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiKXGkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:40:51 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661E5DAD17;
        Wed, 23 Nov 2022 22:40:47 -0800 (PST)
Received: from pps.filterd (m0209323.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO4TqwG004002;
        Thu, 24 Nov 2022 06:40:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=pJVCAmP0s0O5+5cQJOmo9S9CUSSws59MxuYtNmRRfww=;
 b=beIr8b08nm4ozljbQqbiWeup1QeYEVii+BdjOnAwNkXa5jqMOm1sBimZBqZrjdKOL30w
 lyUy6DWP8oFMoi5Lyz26YIe7iTo5mqVhSvS+7mRCvAz4BekTxn/iXIwqpzrIV1crs2Hy
 J6idPeu0QmanEBQ9VPdFMfIAgqHyO45rF4a4gizo1I7MEKPdyvkZbtRuW8Sb3TUksA26
 NVBxhfqJdN1W/EUePt/iT7rwgKlVMxnM0tyoNQ9fH23nZokg5JH9dvIhTL1XvY5eqynY
 BVCGJM9tRq505YWLr0Ql98KVFkqw4h7KfsIQoVxLsv5YW2vAtO+HdsmnvPDJqQX3ODE1 /w== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m1c0a95n9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 06:40:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c80e7hI7MICrJKRIeO6HP3hgIHIjb2aYF8I8GDepvKGrSriRQuOfCgpUic62fbUbT9KKIwWTFCHzjltw6ornuAYHlmru+wUvs2iE/lcCSfUM+eJl2iz14j3QMG7sagwxDf+tCYWMK3HIQbn+r7VUwPUeyTZSllXlHccMwdesWWDofTFAta1agDodSgaRz/VkaXguIzgfny34eLuRalGv4x08xV/awzfEObb+rJHLDhnqSywsGMz7kfKnUdQxj5TayVjcf9VMSclovZ6MP+tKqm2nHSsbt4HZbLrIFzAIhNmptnLLBv6MxnKbpDYnRYBQ+Vk74Tv22Ka/9tNER1mk3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJVCAmP0s0O5+5cQJOmo9S9CUSSws59MxuYtNmRRfww=;
 b=VtOTr+j+LfovsXsMFGrIiigwAj1c7QEt+RpT+rdkdc/JfZ5Qr1K24ibSYpkEOOLEtDzp0o//ZYHGCruMQIs678gbsqngMAOhBUzgmv+mMyO0QE/3r5t5tp2BQxSdcEVmkRXzr073JsKDqw8Rfj9LWXn7oBWiHOSwMpeqxpADUEkfG77Hw333n9Z8gCY95v3DcqWFA45qeEu0U714unpWJ6Ur88Up8Mxa+Akr9uz5LVI8cRni064VtRYewd/+RkSIfLmjvfa8+eERuCLk4I66dDuXN+KcoEdh2wJ7RqY2AA5lgqYPzvIoMCwP425rNhKye2WzyrTm6yaOlQuI9vx2fQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4425.apcprd04.prod.outlook.com (2603:1096:4:e8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 06:40:31 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%8]) with mapi id 15.20.5857.008; Thu, 24 Nov 2022
 06:40:31 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 2/5] exfat: support dynamic allocate bh for
 exfat_entry_set_cache
Thread-Topic: [PATCH v2 2/5] exfat: support dynamic allocate bh for
 exfat_entry_set_cache
Thread-Index: Adj/yf3EdbTZ4lxGQLaYPoSH9Dr5Mg==
Date:   Thu, 24 Nov 2022 06:40:31 +0000
Message-ID: <PUZPR04MB6316B19EC10EE0E1E52D3936810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4425:EE_
x-ms-office365-filtering-correlation-id: 83912b38-a64a-4c54-275c-08dacde6c850
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eyYdtDe8Z9MaRIY7evzEYyQoKYLiGoQQ8PrVldRWs+FQSPK9ExtcMob4xR+AezfKqQJGemmzV0KGG9MSrmM8STT/1d3Xf2CVHv82kduevuJaKxSGHLr0dSIfxWx9JD27u+2jE+1sgI+cqI2fCVUaeH/lYdk140ERoOuesltZcIRSTG7rcXilzO/VW9IWaFmukiPKF05Z49NtwBSmn6RC4AIYy8E8vjMltzkccsEbgNu2B/NH3eO2jAWOOyoNW8kZIczLSAMO+DzdxuuChEG/Wrw0FkypohEHUZbq3Xw6Co2EZLCC4hTDf+08IgBla9q4t6NcbSZLenKIJH4eqRVu4HnSTUKPCw7ogN38PWyD6Y4Tb7JlsbAs2uXtfwae4UDR1N11M9udz48KPo7nGe+9E97NJaeKpRaairaQprpupJ2ouhVsBiaMu3ln+HJEcYDzP9ndkuojDrm2EO2DFyOCmCWjQUR95D2vlpewanPI8W2qvK4vSn/lo7nRpkzVJ5dIsTzJYpE7xFxYlXh7sJMh/6QQ94vmi4pCpmFdKPOQp028+fJRxcnsVKFyzO1KxYocB/9JvV27mfEFfqzh7rlCsFsJUmIHVCRmxsUSNBe0lxaGP4XYEszV+6qNqw8/sNqvXCHQCtDHFevc8FDfv829vLN+jnIeO77ILCf5TqK8588mCsLJd0Wi0ghRgqQVt7KLAjjsLL06/38erxz81ZDiFw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(41300700001)(8936002)(478600001)(54906003)(4326008)(5660300002)(316002)(66556008)(66476007)(66946007)(76116006)(52536014)(66446008)(64756008)(8676002)(71200400001)(107886003)(2906002)(7696005)(6506007)(9686003)(186003)(110136005)(122000001)(26005)(38070700005)(38100700002)(82960400001)(86362001)(83380400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UjR3L0YvRUROVmtnYURTQTljQ0pXYTNOQXR1NjVhNkV6RWN5cnpUL2tvYXMw?=
 =?utf-8?B?UFdJTlVTOFVNQXZ3N0RzdVZocjl1OUZYN282anpnV21hUS8wSk9Tb1NHRlVu?=
 =?utf-8?B?TkhaajlVZnozOW9ZNHhIV0hpSVJZdXBwVFM0Smc1TnR2VkVKM1hGVElCOHJx?=
 =?utf-8?B?b2ZLUDBDK1d5ZE1xcTgxU3VUOXBkd1R4VmxudU9aaVBPVVl2RkxtMXZtcVdy?=
 =?utf-8?B?bHhMM2dEMmxrMmRhVlNOSitGT1RTeDNOSnJDV3htYkZtWVhNM2ljVE5HR0VB?=
 =?utf-8?B?Z0U2OGJ5L09LZFk2VjBrSDdUZzBqc1VDRDJhSDFsa3QyTlVncUF0UGF2c1kr?=
 =?utf-8?B?S2xVUWx1ZnRYY0sxR3ozVWJSNmJ4TFc2UVBKY1dMMlhwOUY1dklmYlE1YUFh?=
 =?utf-8?B?UnF2Tnd5allWZmdTMG0zdS9pNnh0VWExcDlOUzJhaXJqNFNjSzlJKytNZ0xM?=
 =?utf-8?B?VkJ1SVZvYU1wYWJVRXpCNDdLeVMwUE9ySjIySmQ3VjhaY0hycDZpdlFKZjVx?=
 =?utf-8?B?cTA1SzJxMHNhWjZ1elBCdkxGTnpJZWhhMWFvQjNEU01zNmZ5Yk50TklnczZh?=
 =?utf-8?B?eXAvWEdXbDcrWUJKK1d5dnVWT0xUSmlJeWw0RllyNEZESXpLbnlmeDZTVFlI?=
 =?utf-8?B?bHVCWUF6ZnRrZjdoVWNTaVJtQ1BscEhRemFocmsxaXpDTUdRNU5EeFIvVDhR?=
 =?utf-8?B?UU5GbkVnMXFJblhMY1VDVTZndHFmQWxhelVrWWhkbExtQmQxeU5ibGdRNFU5?=
 =?utf-8?B?aHp4cU9jRThsR0w3b2xycWNDMzFLNXRTSC8vWm1DYVQwZ1I0Qlh5dXJIZUlJ?=
 =?utf-8?B?VUE2dFk4anc3bkRUeUxUa0pjRnJ2alVjMnN2MUhGbFl4aUsreE1DdjZRdlJD?=
 =?utf-8?B?KytVNXhzSHJSUmJ0ZEFjY2p2K2dndTh2UmZhMlZXZ2hjdnRueVZSckhWY0JC?=
 =?utf-8?B?amxueGtDN2RETTRiWlk4Yzc1Si81dllHbXJjQVY3cFhFYWhQUVBsTlhZU1RB?=
 =?utf-8?B?U2pPZ0dGWkZwcVZYUDdHMmduNTVRUmRSZWxLWDBRZHRsQnJDV0NUVDJpQlQ1?=
 =?utf-8?B?UDdLY0NUOEF6L3hRLzFCTTNBZzUrSW1rQlROUGVZU095UFFSb0J6dDVvWVZa?=
 =?utf-8?B?RFh0anNaL1BWQnd2cE9HUGJrNWpVUWJXZ3ZkN2FaNCtNaGNCNWpLUWVzSklp?=
 =?utf-8?B?T2pHOHd6c3ZDb05nS2lhSTZnMno0d2tHQUVTdElqL3hERnhsUk5NU212NlhX?=
 =?utf-8?B?T0RZRXF0eXVvL2VsMVVvYnlzenpMWkxIRzRnYnd5NWVtUjM0Wjh3ZlNQZGNY?=
 =?utf-8?B?VWlyOGNGL1M2U2NpcUVVRHY2QVJjSWpDRWxyajFOaEYyOW1iczlZNm5mdWdz?=
 =?utf-8?B?RDBEenJENm05Zi9MRnVUUWc2V3pmMGIwSjYza3JZM0lTMi9sU0tZb1gwL096?=
 =?utf-8?B?U2NPV0tmL2pDRWlQZWhHWGJ4N1RFenRqcVR2SEFDQ1Q2bGx0dmVoOWdGWjZt?=
 =?utf-8?B?c2NTSE8wSVlkbS83SjNpMWFZY2RUTkxHYmRnQVN2aE5MT3BzRVJnNkM0WEU0?=
 =?utf-8?B?eU5vb3Q4YnFURWxKTDhCZ2J4SzEvZDlhWWMrQlNnVGZvNzRjOWVGQWxPaE1t?=
 =?utf-8?B?a0hvK2hJcGJ1UkgydDdaZnB6Q1QvdEZFYk9MeUZEVWxSZ0l6NWNXSlo0V0R1?=
 =?utf-8?B?bnNHYWJEQ1lhUDNOSDQzMGdhWkZRRHBqaERRN296TEM5SFhwSEMvTEpzUzlt?=
 =?utf-8?B?cjA1dEVVOEJxSTc0UHAxOSs3NU9UWUpZNmhyV2djQVNMUkQzczErbGEwSkdz?=
 =?utf-8?B?VnJDSHNrN0gyRWtMV29jWkprb3NaUktWOHN1MXpyaFBDQWJVb2ZUeWM0VkRI?=
 =?utf-8?B?c0hoTzUyRElvVWxnbVhqQmF0TnFKeXZ0dS9RU3RLVEI0ejlrNUdYWFVRc1p6?=
 =?utf-8?B?ZDVqNzJoM0ZoVEptT283Z0JIR2d0bVk4UHZ4ZFdEcWRFRlJvZ2hQUFZWNWVL?=
 =?utf-8?B?ZVBROW5sWUJXUVM2NnZpQXNUYklZUURkRGNBdFhwQzIyaVJMNXlMR2p4MXlt?=
 =?utf-8?B?NlZzRkhQWnBTS1YyZG4vdmFkOVRUZUllSTVKWUNTZ2ZwdE9CbVE0dWdJYXl5?=
 =?utf-8?Q?eI/ie3/29I9UfjGf/bAsp7mqz?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SCit4Jp3R29+J6ukskENF3aB8Mfzuc9FQE+X6hw+x+OaPEGCuHByItVXLRN53i5WmNyZ0eVyYL9zh894kV+enSGkw373j0GcuN5Q5NNc+GWsM3EXKEg167+U4FYFwBwPJyWiEA0wq1FDgqcyOXC8XuRj8UKJOBZAntnYXn90FYl5XbWUXGoS2ZOdpecmllvpMHqyFNJDVFNuAQyXYvhMOUQY470icRhIkg797GzlaFNUlIAATSrt9dTG673WQ9QhpKuJtoSqLgz4YSqIrOZc/QkoaBIALpSRssyRYo2wNlub5J/t/vdmY23zFbsA87StuhbjjYIExYVbQ8sFa5f7SqHscXB7L5N/caRQtu7v9RfmlgN+NxatsLieqneU3SkUZaCzJpS8L+xvDofIs9eUdTdxI29cqa1VZPdh9gFmKqxvqs4aXef9/5MzPFkUVbhI8+AdIDwoIp8Ird7Iyd5Tk14RmTm+E6WXs6LzI8gTUcfKxKHVBThbVEiaaJazFwSem4+FwJb8Apb2GsDRFoT9nlGk8YV6W4vB8KoTVVkd4bh6EFrl0NvNMQuOAwDiqxd8yCkV0VWUonbzB72qFFH+twV8h2deGi9dwAjhX8Hzu46Tpk4euHARaWn/c7FUzLmN0ySjYBBDA69q9eokS0yAyI7JTCvt+8i3QMYIN/md9uuCl6V41vO4y3f3b5/ZZydHQ1+uKPST9I4qq0LC89ynIsudh1BLukdcmxngR3wR9DQzC0hcSeyI61HJlFCV7g8XkWCnKb3iLBw2jFuLffJpVpe1sP+DZa4vz103B2pbNzzXZrtVxduFA7FdabDPM/tqN5VXjpr/5yC3dnV/uxur0WTns2z8Tl4zDNDunts5WT7MFf7y4Bwb4IpKOe63VhGs
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83912b38-a64a-4c54-275c-08dacde6c850
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:40:31.2589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SQVrjfBOva3e5nRP8mHu3azsa2E+f1OLaMCz2mYGzjmenn6vF2lNmrhstliVqLUhywvD7UEyCF6Ax/80ye/e7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4425
X-Proofpoint-GUID: IN6SF8FGayMl0tUn_DzfGR20FF4dH4Ux
X-Proofpoint-ORIG-GUID: IN6SF8FGayMl0tUn_DzfGR20FF4dH4Ux
X-Sony-Outbound-GUID: IN6SF8FGayMl0tUn_DzfGR20FF4dH4Ux
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

SW4gc3BlY2lhbCBjYXNlcywgYSBmaWxlIG9yIGEgZGlyZWN0b3J5IG1heSBvY2N1cGllZCBtb3Jl
IHRoYW4gMTkNCmRpcmVjdG9yeSBlbnRyaWVzLCBwcmUtYWxsb2NhdGluZyAzIGJoIGlzIG5vdCBl
bm91Z2guIFN1Y2ggYXMNCiAgLSBTdXBwb3J0IHZlbmRvciBzZWNvbmRhcnkgZGlyZWN0b3J5IGVu
dHJ5IGluIHRoZSBmdXR1cmUuDQogIC0gU2luY2UgZmlsZSBkaXJlY3RvcnkgZW50cnkgaXMgZGFt
YWdlZCwgdGhlIFNlY29uZGFyeUNvdW50DQogICAgZmllbGQgaXMgYmlnZ2VyIHRoYW4gMTguDQoN
ClNvIHRoaXMgY29tbWl0IHN1cHBvcnRzIGR5bmFtaWMgYWxsb2NhdGlvbiBvZiBiaC4NCg0KU2ln
bmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQt
Ynk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFy
dSA8d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCAx
NSArKysrKysrKysrKysrKysNCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgIDUgKysrKy0NCiAyIGZp
bGVzIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdp
dCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IDMwZDBhYzQzYjY2Yy4u
MDNlOWM5ZTM5NjZlIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBiL2ZzL2V4ZmF0
L2Rpci5jDQpAQCAtNjE1LDYgKzYxNSwxMCBAQCBpbnQgZXhmYXRfZnJlZV9kZW50cnlfc2V0KHN0
cnVjdCBleGZhdF9lbnRyeV9zZXRfY2FjaGUgKmVzLCBpbnQgc3luYykNCiAJCQliZm9yZ2V0KGVz
LT5iaFtpXSk7DQogCQllbHNlDQogCQkJYnJlbHNlKGVzLT5iaFtpXSk7DQorDQorCWlmIChJU19E
WU5BTUlDX0VTKGVzKSkNCisJCWtmcmVlKGVzLT5iaCk7DQorDQogCWtmcmVlKGVzKTsNCiAJcmV0
dXJuIGVycjsNCiB9DQpAQCAtODQ3LDYgKzg1MSw3IEBAIHN0cnVjdCBleGZhdF9lbnRyeV9zZXRf
Y2FjaGUgKmV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsDQogCS8q
IGJ5dGUgb2Zmc2V0IGluIHNlY3RvciAqLw0KIAlvZmYgPSBFWEZBVF9CTEtfT0ZGU0VUKGJ5dGVf
b2Zmc2V0LCBzYik7DQogCWVzLT5zdGFydF9vZmYgPSBvZmY7DQorCWVzLT5iaCA9IGVzLT5fX2Jo
Ow0KIA0KIAkvKiBzZWN0b3Igb2Zmc2V0IGluIGNsdXN0ZXIgKi8NCiAJc2VjID0gRVhGQVRfQl9U
T19CTEsoYnl0ZV9vZmZzZXQsIHNiKTsNCkBAIC04NjYsNiArODcxLDE2IEBAIHN0cnVjdCBleGZh
dF9lbnRyeV9zZXRfY2FjaGUgKmV4ZmF0X2dldF9kZW50cnlfc2V0KHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsDQogCWVzLT5udW1fZW50cmllcyA9IG51bV9lbnRyaWVzOw0KIA0KIAludW1fYmggPSBF
WEZBVF9CX1RPX0JMS19ST1VORF9VUChvZmYgKyBudW1fZW50cmllcyAqIERFTlRSWV9TSVpFLCBz
Yik7DQorCWlmIChudW1fYmggPiBBUlJBWV9TSVpFKGVzLT5fX2JoKSkgew0KKwkJZXMtPmJoID0g
a21hbGxvY19hcnJheShudW1fYmgsIHNpemVvZigqZXMtPmJoKSwgR0ZQX0tFUk5FTCk7DQorCQlp
ZiAoIWVzLT5iaCkgew0KKwkJCWJyZWxzZShiaCk7DQorCQkJa2ZyZWUoZXMpOw0KKwkJCXJldHVy
biBOVUxMOw0KKwkJfQ0KKwkJZXMtPmJoWzBdID0gYmg7DQorCX0NCisNCiAJZm9yIChpID0gMTsg
aSA8IG51bV9iaDsgaSsrKSB7DQogCQkvKiBnZXQgdGhlIG5leHQgc2VjdG9yICovDQogCQlpZiAo
ZXhmYXRfaXNfbGFzdF9zZWN0b3JfaW5fY2x1c3RlcihzYmksIHNlYykpIHsNCmRpZmYgLS1naXQg
YS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggYWY1NTAx
OGZmMjJlLi44MjM5NWFlODBkYmEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQor
KysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQpAQCAtMTg1LDExICsxODUsMTQgQEAgc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSB7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2I7DQogCXVuc2ln
bmVkIGludCBzdGFydF9vZmY7DQogCWludCBudW1fYmg7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAq
YmhbRElSX0NBQ0hFX1NJWkVdOw0KKwlzdHJ1Y3QgYnVmZmVyX2hlYWQgKl9fYmhbRElSX0NBQ0hF
X1NJWkVdOw0KKwlzdHJ1Y3QgYnVmZmVyX2hlYWQgKipiaDsNCiAJdW5zaWduZWQgaW50IG51bV9l
bnRyaWVzOw0KIAlib29sIG1vZGlmaWVkOw0KIH07DQogDQorI2RlZmluZSBJU19EWU5BTUlDX0VT
KGVzKQkoKGVzKS0+X19iaCAhPSAoZXMpLT5iaCkNCisNCiBzdHJ1Y3QgZXhmYXRfZGlyX2VudHJ5
IHsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGRpcjsNCiAJaW50IGVudHJ5Ow0KLS0gDQoyLjI1LjEN
Cg0K
