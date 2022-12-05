Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7986164228B
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:17:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbiLEFRN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231175AbiLEFRL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:17:11 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061A9331;
        Sun,  4 Dec 2022 21:17:09 -0800 (PST)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B54TTSq024648;
        Mon, 5 Dec 2022 05:16:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=iBj07h2SdMFEsf8LZAE/mWaTKdfHGp4yQIyyvjn2Kdo=;
 b=E6Mg1wU/V17L2tQYDvjdwoANzaarcIrBbJwshs6osd1bz5rAU2lu06H5EWwpy7HWS3gB
 plysGeod7wWV7bJW0mBQHPbiy+kKXkYBde97Be8yf8YugYwZDhGrIhCOkFJJlFssLJ/q
 H3Ublts3HvPRsTj3wRlcBJd7b6KaQChQEMPNksdrM1kVZt5a6kCb1oyerA9wgINlqmQ2
 xiUtobLEpaJdRj9GFz97RRyEkoojBX8giBPxqP43iRs1x3Nt2SsuAt3fzNE9OWQPfbT7
 MGXPkcKqBwmZbrvafHEHo5gnIujLMb0/RTyYjJoVrE/2LoUSYvJmvsHEq4uYX6zYD7Of UA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2111.outbound.protection.outlook.com [104.47.26.111])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7yen19vp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:16:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JSGhgaProBxfAgBbQ9zxorrq6xyK7vzIAD5Ot/JiG2fWv62PLpfN6EaZdZlcUND1sEG/u7w7XobcG3MEUR7ZZRCLtom1ojKGlPV1RADiLDc8gsQvNMT9jtkSB3/1hRGb2xd1nctrSCJH/uKGYNBOjwo/CALhVBhGHb+mpJbXYfhesioVXS3uCo9KF5qiiA84ZCL0wxBYa2/yFjDf5YGtjlaYReEv86k/bGm8HRfXMa1szVrOvWt2BGMtzCZH7/mw4rNzz4tf0MLsrnlU5P6kQSXL4uVYK/+WiY4Cap2HHDSMHoWcaTIH7eFF5M0W5ACE6pDKh5qx8SWl3AIhKv20mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBj07h2SdMFEsf8LZAE/mWaTKdfHGp4yQIyyvjn2Kdo=;
 b=akSbij0Mn6TEwGPNoZ5hYGVKdYWnWm3w4iAqZSfPpO2MEDrgvKv6LV0UuWuTQ3SsHj9sUfEMW0e8VyGpdd4OAeiaDBwGQK9mp9nbQBGFyT3x7m2wASEGoNajNS7w/IfGFCQDH6QCYUsQK9tdosg6iEXds2hw1P4bi5EuVzMZPkeBfEJLT+czHjLkpOHLiLLKh2DkcCgVRl4+/H0G60WIqfrzBefi5PLmnYFvbWnZhhfXraTZHeSCCpZDU4As1uPzFTAaDABnMvASvKcBu3iEbtTBc1T2U1wmwJMw36UTguH8FHpDNz+390gk8HCQbyyRKgknJzw/1X8zP+/noAF89w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4166.apcprd04.prod.outlook.com (2603:1096:301:3d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 05:14:05 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:14:05 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH v1 2/6] exfat: remove unneeded codes from __exfat_rename()
Thread-Topic: [PATCH v1 2/6] exfat: remove unneeded codes from
 __exfat_rename()
Thread-Index: AdkIaFX5kufhihWgQh+oIh/p8AZ4IQ==
Date:   Mon, 5 Dec 2022 05:14:05 +0000
Message-ID: <PUZPR04MB631665EE37FB70BC1745990481189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4166:EE_
x-ms-office365-filtering-correlation-id: 8f794ed1-b7ef-40db-3649-08dad67f8814
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8cKXA1q5xcG5rrw0tqT5qz2CvUzepBUk1uxwWsNpFL/MxPncds7poDDuPcTVEWSx2S5ax32DZbixeAdQYzBfx9UQXJA6YHuLa8HZ3YDea2Q03kl7JUk19avBcXOAraXY5scOtxU6YuayqHutmDPCBJJxtSXf1ChzD/VjVGCzjzPsJPqUgCcNDLPJPwhPRQ1ZdVXtKNTP0FrZnvY4gkUV/Wh/JdxvwIKGtgPgCOcGsBxfbJ7Z3M97KqedjdVJa6I/kCsS7jv8YuL+XC0TE9QyceFZm+NXQg/BTMHZdNoBkyCOt4p5lcmZ2f1wdYav0GmU6ShgFpXvcsdyrwQL0f6ijQ+YUMDUsVuSPaDyCwCjtGrAq6F8q//Gw9ZJrrfGYXWBs5Dahn07q0enTmtKXs8QRgPt4uvk4iYTtaHrypZuSJDPYCVuP7OekFCB10PhG8dMwQDRijpFLDqiL+ANaodo+faEc+j6SZTpuFBqLoVbbMc0vyEuaGlu8z5gQrKmTGmT9rMPNpPBkrUZUuY0k2Wh1mbR2x+XUT/HRViTSLCT9v084qnUlTZ94d4r6G9GTY+5rNeY8dqRlCglZ8bkqDxIbPatFJ4tOP1FZEiEp8F6p4JrZ5fo2iMZB6CkrCcv8CADEw1RL1AktbkhoXoyHXpeGD4eGKVbpUgSnHcP1NEu22g8W1zgqzHHmADfCO+qk9YD8UGM6hkfPG3DBdJ+ElSZJw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(366004)(396003)(346002)(39860400002)(136003)(451199015)(8936002)(5660300002)(316002)(8676002)(4326008)(66946007)(41300700001)(110136005)(64756008)(76116006)(66556008)(66446008)(66476007)(54906003)(86362001)(33656002)(478600001)(71200400001)(55016003)(9686003)(7696005)(6506007)(2906002)(38070700005)(26005)(186003)(52536014)(122000001)(83380400001)(38100700002)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Zmd5NFArOXRuTkpkbnU4MHZyeFJJVkVTYmlNaWhsV1lFaCsvUkFOdW5naVZL?=
 =?utf-8?B?L3I2VXgxNXlwbW4rREVWbE83SytHQUJTVGFiT1Fya25MY2ZIVStLN09MZ2dt?=
 =?utf-8?B?bFVKNlM1Vm9XSmo5bDhJL0ZpK29EVzZkMGlpTDcxU1U4bUhIdG1salg1K2lC?=
 =?utf-8?B?RUVOVmVmUDZmS1BtalA3endEQmJsVkt5czlnZmpWeHJYeXNLNXNTZzJFWHNU?=
 =?utf-8?B?YjlSd3FMT1hIN09lWjF4ZWpsMFVnVW1nQzluMEZBYkRIUTlKeVIxZVZpNU9J?=
 =?utf-8?B?MGV6WGZTNjAyRkI0VFFwNTZZNVg3Zzk5OXdaeWRSak5VM1Y2VG1CdU1EYWEx?=
 =?utf-8?B?UENkQXJIbFFBNFhsQ1JrRGc4QXFDTXdISTJnQ2s0VFlLS0Q2aG8yNlg2MDhY?=
 =?utf-8?B?WUtSYzRqOGpOOHM2RFBKYjc2eUFHdWpORXl3U1Y0dEJEWnV0V1p0M3g1Unhj?=
 =?utf-8?B?bkRLMWVyTEFIb2ZsNWlBVHZOeElsM1ZFSGRwdWJMNUE5L2xCcTlPVEg5VWhw?=
 =?utf-8?B?eFB0cTlxTjRXUWlLMml0SUhiSmVmdXZJTzNtTUZzU0RnaTVSRlJYdkVWUXhk?=
 =?utf-8?B?Y0J2ZU9qN2xrU3VxbkxQWWozSmU2Z1hyTVowUWRGUXRSbXBlRmR1U29KM1BW?=
 =?utf-8?B?OVRCOFFRcEFjODNOYWFXcFl2Z1pwUHJNSFBYUXFnWDZvZXNuWlF1ME5Oa05W?=
 =?utf-8?B?TmloaXp0dmFLc2xqdkh5clNFZXBvR3FLaklJZFpQcGZCVnNReFU0T0gzYkRr?=
 =?utf-8?B?MGRndTVLM2puUVRTNEh1VzJ6THpGNUhnejdQeDM4aEdQeXhPMUZYMnk2Z3Ez?=
 =?utf-8?B?RDZRVWtYTTlJNWZZb241N0ZxY2xxa2RiVFB5c0xXYW5jYUoza3dLS2hHVnNQ?=
 =?utf-8?B?ZDJqcXJsR1hjNkdZL1lYVDBranBpV3d5eFozb2lBeThESW13SHBtNjhGOXlj?=
 =?utf-8?B?ekpQbDJ1VDltLzJscTBmVndhOHRLVFFqZXdUcTg3NzhEVnZxaVBMNXk3NHlU?=
 =?utf-8?B?eENPMU5temE3bW4zdkpXZFpuL1l4eE85TVRteDlRS2VxQ05adjdLWlFkaGM5?=
 =?utf-8?B?MFBZc293SFU0RUtiOTR5cVNOb0JuM3htMUtqQUQ2Mm1wOEMxY2EwUUNzOGVD?=
 =?utf-8?B?M3AwWkl6YUY5V2Y4L3owVDVINFZQVFdXRmdrMDE2dWZqOERPRDZBQUhkVjR1?=
 =?utf-8?B?L3dQeFc4KzkvbDZZVERZM2JuT2Q4N1pNVXVYc210MDZ4V0puZzVqUmZpMFBk?=
 =?utf-8?B?TWY5TVd1c3ZrcWNxQlVDY3lRdmN0T00xR0dBS1MyNG15STdvZ0VJcCtrd09w?=
 =?utf-8?B?UnAxaTFtV3Vjb1hneGI5ZzVKdkpseVFkc1lrelkzSTY0K3ZjOFdhTklqdzRW?=
 =?utf-8?B?YklRVG9QYnRnbUVLb2FqVXVBYTc4djF5eFdscHFyZlFqTDlsKzlManZaV3R1?=
 =?utf-8?B?WGJoelAwZUV1VER0c2dQeFhBVERCc3FBNUhyL0NEaTlNNkU4Q2RnTEk1MkhZ?=
 =?utf-8?B?NUVkaG8rYi9vdTk4RGhsNlN0UGJRQklXaCtzZzM1K2FlTFY3WlJsYzJxdVF4?=
 =?utf-8?B?bzVab3p5T2p5NUMvRUNuSWlYVjR5Q2trKzN2TmJBZVl1ZGFzR3RhVDJhdXY4?=
 =?utf-8?B?dXBZelBxQmw5TCtOaFZxV2xQNzRES1V2ZnV5dTd4SFVIMHYwV0lUd3BkM1RN?=
 =?utf-8?B?YXAxblF0S0o3ZjU2c2pmTE5pZmpwcSsyRGJmN1QrUUt4UExKNkdabUNYSG9o?=
 =?utf-8?B?VThZQ0lSRm9rRm9tclhOUE40citNSHp1b3JIbDRXKzZENERnK0YybXNyMEtr?=
 =?utf-8?B?OWNwWFNHK2txdWsrVjJ2VFFCQzRScU13N0plN24zM21DcmN0NWZvMXZFZTZX?=
 =?utf-8?B?SDN0YkE1NmlpUHJKNE1TQmZiQUhCdHcrQ0pvQnd2bG1VeVdQNTVKNDdyR1Na?=
 =?utf-8?B?dUV3eHlGcVJWWSsxWmZIQnd5SklWMnFLb0dWY054YStkQ1dJTHNrNHlLaWpv?=
 =?utf-8?B?QjJBMzhiRGRtTGROdGorR2lXbXF1WUQrQWNaRGJ3K1BXazFMNDlWWnM4bENs?=
 =?utf-8?B?NzdjeVY1UzZvNnE2bkNhWDkxcllmVE95MDN6YmZRWnp1eDlhS3dsakc2cUFD?=
 =?utf-8?Q?Ojskcbj9/DTilGqXsIiCJk3yM?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: igmAgz0sW5UOKg25TV1XR7cej1wamFSJvtsJ4GJ3mf0iayeUbyChnSYHrrlodLh0ShUpZc27e3Plpk0aF6v/vugUeNfG3WCYJEu8A4HMKb3SzuVSUILudqrsWYHTjaXNRe8b5fnRBeFepU+eHELURMTStNO2L6FDvr3oddv0rI0NUH8itsvul0GOBfwHGFkOCO2AXmrJ/QCl/f4NGkqsgWFIKzbVZjMch/rjaXAXDygbcf/0+YzuEDR6M8RuryDzXOgsSQy9BlFJ3yxS0zEhDa2IISqB6w096muUv5LH4WuIv+0AJ4f3/vtqcNMkOmaMpzTi0KqS5RqSNYnL05/N/TA4CIpSNNI11C3PmobkHGBxdnbj7iLbt8HWiSX2xFJoh/u68jXtl39I549nPjXv4FdzQDto2JpWxYzxh64SVKLvKxLxlvnY45F1nEMSLXzRnqwn7mnKhfmeaN+FQcczflYXrODiHf9Ad49NYz2Gr599NU4prB4nrjysQzxCfB7DC42na9+36Dno6q2xzN72YxH/348tm+JvgiPnx3o0xw98aIWHqSEAkpKazV6N8h4Ola6U0tw+1SU/IgnlFxE2A6vPxdHVoQzEMJdFhbqZZYZNKDo1I6PcjS0IlbUHKdg6J/KSuExCz0C/pf3NDWuPlnxpfoW7u625LK/IsVfsT9XMAy0O25P0AKFdhBQoI8I4CZjFfVGdTu2q9k55BLUAJOR6sopGQkJeFSJkBOEBBfVRMnxd+FboP96pHNSTvKq9xQBGEBWRQJ69pRDsa1nkqY5VafQcF9R5w1GBaFfJNEHUIdFqOkvLHJIV+0UEBHpa3S5i9nLyYC3kA/YmGcQDHKdPpHoPYv3JCiDpT0Vco82msDaMP77uADVCHBwfwzLr
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f794ed1-b7ef-40db-3649-08dad67f8814
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:14:05.8406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: VzVmPkOb++Q87pkTRnZH5YMEicj81ryZ9KvNG1eAdX2/hl9w1T+CffQI2hYAmP0Lk2PgFS0UvOe0CGDHDIwSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4166
X-Proofpoint-GUID: IwZujAylVIf3ATr5bYp4FXk0UpLDz5QD
X-Proofpoint-ORIG-GUID: IwZujAylVIf3ATr5bYp4FXk0UpLDz5QD
X-Sony-Outbound-GUID: IwZujAylVIf3ATr5bYp4FXk0UpLDz5QD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-05_01,2022-12-01_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

VGhlIGNvZGUgZ2V0cyB0aGUgZGVudHJ5LCBidXQgdGhlIGRlbnRyeSBpcyBub3QgdXNlZCwgcmVt
b3ZlIHRoZQ0KY29kZS4NCg0KQ29kZSByZWZpbmVtZW50LCBubyBmdW5jdGlvbmFsIGNoYW5nZXMu
DQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJl
dmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFt
YSBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+DQotLS0NCiBmcy9leGZhdC9uYW1laS5j
IHwgOSArLS0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDggZGVsZXRp
b25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9uYW1laS5jIGIvZnMvZXhmYXQvbmFtZWku
Yw0KaW5kZXggMDFlNGU4YzYwYmJlLi4zNDdjOGRmNDViZDAgMTAwNjQ0DQotLS0gYS9mcy9leGZh
dC9uYW1laS5jDQorKysgYi9mcy9leGZhdC9uYW1laS5jDQpAQCAtMTE3NSw3ICsxMTc1LDcgQEAg
c3RhdGljIGludCBfX2V4ZmF0X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUs
DQogCXN0cnVjdCBleGZhdF9pbm9kZV9pbmZvICpuZXdfZWkgPSBOVUxMOw0KIAl1bnNpZ25lZCBp
bnQgbmV3X2VudHJ5X3R5cGUgPSBUWVBFX1VOVVNFRDsNCiAJaW50IG5ld19lbnRyeSA9IDA7DQot
CXN0cnVjdCBidWZmZXJfaGVhZCAqb2xkX2JoLCAqbmV3X2JoID0gTlVMTDsNCisJc3RydWN0IGJ1
ZmZlcl9oZWFkICpuZXdfYmggPSBOVUxMOw0KIA0KIAkvKiBjaGVjayB0aGUgdmFsaWRpdHkgb2Yg
cG9pbnRlciBwYXJhbWV0ZXJzICovDQogCWlmIChuZXdfcGF0aCA9PSBOVUxMIHx8IHN0cmxlbihu
ZXdfcGF0aCkgPT0gMCkNCkBAIC0xMTkxLDEzICsxMTkxLDYgQEAgc3RhdGljIGludCBfX2V4ZmF0
X3JlbmFtZShzdHJ1Y3QgaW5vZGUgKm9sZF9wYXJlbnRfaW5vZGUsDQogCQlFWEZBVF9JKG9sZF9w
YXJlbnRfaW5vZGUpLT5mbGFncyk7DQogCWRlbnRyeSA9IGVpLT5lbnRyeTsNCiANCi0JZXAgPSBl
eGZhdF9nZXRfZGVudHJ5KHNiLCAmb2xkZGlyLCBkZW50cnksICZvbGRfYmgpOw0KLQlpZiAoIWVw
KSB7DQotCQlyZXQgPSAtRUlPOw0KLQkJZ290byBvdXQ7DQotCX0NCi0JYnJlbHNlKG9sZF9iaCk7
DQotDQogCS8qIGNoZWNrIHdoZXRoZXIgbmV3IGRpciBpcyBleGlzdGluZyBkaXJlY3RvcnkgYW5k
IGVtcHR5ICovDQogCWlmIChuZXdfaW5vZGUpIHsNCiAJCXJldCA9IC1FSU87DQotLSANCjIuMjUu
MQ0K
