Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DC962D2E6
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:48:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239142AbiKQFsY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:48:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239283AbiKQFrm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:47:42 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4196F345;
        Wed, 16 Nov 2022 21:47:18 -0800 (PST)
Received: from pps.filterd (m0209318.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH2rpXC013925;
        Thu, 17 Nov 2022 05:47:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=s9nYSSvrzuXC4t4tRiuFVyOoiBidvlyeIo/S/pFhUN8=;
 b=YNWmwXYz9BHNqJxSFrQN9ALebtpvVn3MD7L9AmCo9zFxWVIszLezC1UlMrWxv5ma5MY4
 oARok6jzSZkopQvPUndLtKqwyWGGg8WSPkmUxkwOLUoPIoNfeh7D5gXYBF8fk0NIRU0b
 PR0Mo67vs1EMwILAGm32Qtu1Kv6Lyw2jid4aVd/HHpq6kTHc/rF66kZPIk2Vs7BKIdDD
 1T1HSXxgf2Yw51AuD7R4f0QtGm+SWfMJlS1mWSwMQvDOSD+c95vy6UxUXpe0WE2sfcvf
 spx+NgVpfhf5Kr7fyNpZwR+VzikuwRnisMRRAQ5LT3JOCMW9kRa2Tmrl6wXWGKtmoJzo uA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kvwhpgxpx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 05:47:08 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=meHWt1nF9OZ3e3HK1QO7UArItyFiR1t6H10ahNqqP8hW8koVwH4WwzdRdHOFlRY6mJObydOZ9kyF+vbuISrq0WHCrwKlpoPhq4/2Rx/ARwBDz+JDs9BbZf55WZE0J05l6fUWVuGq4+AjX0JGnj3KSbvD8M/xMhHNM4UJ++Bcvr7jSxQaJMgUHj5qMxFqPkdb8/pk7mbnY/ivPj02/hAf/GL8l3VxT887le6q/wqnwaF8f5zXX9Tjk6jj3piubpnvSpFlJsY+26sIH3uNVsV8eWs3qy3w4LXmsMnUwrgKp5yaaVwHU8r4KbWCTsOH4qiSQZKNqzQex+wmj4e02144YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9nYSSvrzuXC4t4tRiuFVyOoiBidvlyeIo/S/pFhUN8=;
 b=oEWDkhF+d/0tXIvMLJ8tf+Voe3NEy468R8Q9LPup/18IVrorxnAhgz9eN8ksVJ7C5B4BM82WDTLuL043i9QIJkFumBgpJPbroGT/uKZHIt1nwd7+2wZ/GBWy8Pi/wfA4at8uZWyY0jkxdqGfuA/dKBUTN5w709i6NYtGHAu2gmx2pPBH2i+58SX2D3qnqHpmOGDEPcR3F6norN+0cS8jB2mD4yIRzelRZE5d/YO6fAw93R+TnrEb4+3UkjLGd+Zyzqfo1R+9JBJFvNZjep1XFVgMAeoHw+pfzZ6Hnd9Przqzef+qmS2TJ4BincSN4fQfjZISJpEjEPir3H6EX350Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4134.apcprd04.prod.outlook.com (2603:1096:301:38::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.9; Thu, 17 Nov
 2022 05:46:56 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%7]) with mapi id 15.20.5834.007; Thu, 17 Nov 2022
 05:46:56 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 2/5] exfat: support dynamic allocate bh for
 exfat_entry_set_cache
Thread-Topic: [PATCH v1 2/5] exfat: support dynamic allocate bh for
 exfat_entry_set_cache
Thread-Index: Adj6RlW0h6tBo002TMOVyOUUojuPWw==
Date:   Thu, 17 Nov 2022 05:46:56 +0000
Message-ID: <PUZPR04MB63163CD638A35F7835184D7D81069@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4134:EE_
x-ms-office365-filtering-correlation-id: 478d3d83-1bde-4bfe-c5bb-08dac85f2364
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: /ryJaA3DiNi7c/i5wcJaXdeNU2YO/O1yhp8MjoYgXEa86TRbiWVyj2EqxE8vctIHCVNms9Q3CrzSRP36SUgYJnQkqtM6L68HCLR/Kgele2Y3bk21QfSyLv6lcmJzbMFXPJo02YCxltZTpeMZlxP2TsSGeO1+MbGaZmlmQ1DpwbEUCXBUNCpu7nNm2Gd50MSLP0uyfIk9jeiE1dii835+VI6FMUZQa7kGsphnPuwsewpherxCshuL2ox92JSFyLrxIuJJwO9oA1qrpKEAQYi5tG8yIaMLahnqSD9cqhY/JpUDbMJXt/G/EEc5QXxWXip4dO+an7GQO9g+WS+sUq8xv+QQ4jY3DYPwbpbCvwqxEx/Ei2g9u+n3cr1SYDD/5r/6TEEjpzweE+Z/3qAvIzChzH13PPykF+57ESQVHoT3N2J9TARCPFAdM8WQsGN5s/kFfFrSsDnwr/Pm8S1p1pKv34jCwYVqZkV/Nl0w8P7AwDAIqe/xWtYs6Rz2tBR2ERO8eRoLipiJZlXg4ZA95vcHiqm8WoldtsrSE82IvvX0gtRv2wutM3JchZgxA0MJRCkl3kYb7l8aVPBiq9+uGXNoKU/d4OC0yQModsq1lheMVI3hbDiH6tbiarikDRRggA1LFv71MLMK8OjVhzzzKHsAxJZ4qKNFOpiYP7O8uKJLp8J+BYgW/5l/cCJfCowL/AYG0mjt1pd5o997Yq7dMn9Amw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(39860400002)(366004)(396003)(451199015)(33656002)(316002)(110136005)(186003)(38070700005)(54906003)(71200400001)(107886003)(83380400001)(6506007)(26005)(478600001)(7696005)(9686003)(2906002)(86362001)(55016003)(66476007)(66556008)(66946007)(76116006)(64756008)(66446008)(8676002)(5660300002)(4326008)(8936002)(52536014)(38100700002)(82960400001)(41300700001)(122000001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXVuUG9yS2FXZkg4eWMrSlMzdjd0aVdrTFd3ZXdHSUVMZEdabGhXclZsNjRn?=
 =?utf-8?B?cUNtMHAyb0pGeVZyTnRMcE5vL1RYQ0tXVGR2MDVZN05QN3NNZHN0WUtJU0VF?=
 =?utf-8?B?aHVIRmI5WjZaNU1MSDcyMEdYdEpXckU4MDlzeFJPbHRhTzVUUzF5di9WNHdy?=
 =?utf-8?B?NUNLMVBlZ3JZZUx5UVJ0WmJ4UmhqWTkyaVQ5aXFRTnJzMjJQRDJaRU1CWVA2?=
 =?utf-8?B?d251UDQ5QXlHQUxuUmNlaUtzN2UwOWx6akZvaUZ2QlprK293V0pIaGxhVFBG?=
 =?utf-8?B?RjNYVFgxZExRSzFGWHBnUnpMSFdMenZCRERoTzk4N1NyeERPZERkb2wzbDNk?=
 =?utf-8?B?dkM2RWhCckpVVXpvTXdmUkNBMWpzZ3VmelNYZkx5alp1SENocEwrNGs0cFFW?=
 =?utf-8?B?RWYrVGd3L1hzSE1WMk1yb1Jic205OVI0RXIvdkxkMkJwUzBFMm5IK1hEdkxZ?=
 =?utf-8?B?RVBSdzlQSXd3YmVCb3JKdFlyRGQyb1kxSHdvcklKam9vaFJCaFh4ZDJ4dUh5?=
 =?utf-8?B?cUpzS1p4bnNoZWkxL0x0VjVhS2MzK2tyVkJJd0o0cEcrZkJKU1E3RWU4NDU3?=
 =?utf-8?B?ZTBNbERUSWxEQ0Nza2VmT1hsTHIwc05LdDl5RFBHcUxiOExKTUJGaGRRU2xv?=
 =?utf-8?B?MlBlV1IrVkV0U1VrN3R4bklJalAvUjMxNld0TXA1T2JDV3RRR2NtYjNNZEZv?=
 =?utf-8?B?SG1rUWdjMDNmc2h6S3dJWTE5M3J1MTNqVHFZZEdqbFpFNHVZUDA5UFovTHNY?=
 =?utf-8?B?VGRaUC9xd0Vxbmo1YmFmNEVPUncyMWErMTRsRmJMUlJaZzNtczN5S2ZHdDdz?=
 =?utf-8?B?Y0t5WVBiOEtyYzBCS3ViUTZMSHlxWTYza0ZOeEJMdlhIT2dvNjRuMjRtQ1Z0?=
 =?utf-8?B?dEVaYU9NS3Q5SGg4dDJCcFFPUkNWcmp3YmhUMW5IUXY0dmI0Rk5aTkFteTNM?=
 =?utf-8?B?U0pnR3crVHkrMDhhRTFOcGtvV0ZjSE5vUmRPaWtOSldWS1lQV0FPYmJWUHR3?=
 =?utf-8?B?cnpIWG9oNVQ2T1J2MkFkVG1JUVM1N3lxY3lOY2RnYjJBU1BPUFQ0MmRCRUQ5?=
 =?utf-8?B?ZVhHcHlZdWlsR2hlRExBajN3MitnMTE2Zmt5K1cxNUUxK2FoQ3Q5Slh1YXNH?=
 =?utf-8?B?ZC9veUVLZWF6V1VIcGhBWXBTbmtYWlMzYWYvUm8zbmpsUTVaWjMvdGlubHpY?=
 =?utf-8?B?ZGJUUjdON01LbGd5RUhhK1plT01KMjhYdHFvLy9ld3JRY2tkbkc4c21nRlAv?=
 =?utf-8?B?KzlCV1ROYjJsRHorWFNoVEdUQVU4RWRZUjZva21yeWQwSlJLVDlScTVQMmZ0?=
 =?utf-8?B?aU1kMzZMaFRkQTFRODc5UkV3cHhxcnRyZG05UWdkdDE5aHJvd3NpRzEyNnFC?=
 =?utf-8?B?dWd4RllDaTQ2b3RUSEppN2NHUlRadlNSRHZHQWhhU2wxc01tbXRGa2IyakY1?=
 =?utf-8?B?UXdRTTdBOTV0dGhhTno4REl0TGl5WTlIMS9leGhpbTlTRXFFQU1hT3hOZHBu?=
 =?utf-8?B?WFZWOFcrTVcxMFBsWmVPU25MNlZDTmFoeElCS1VabTM5d1VwR0lidkNHTy9Q?=
 =?utf-8?B?YzFTVFI4UGFOeUliSkN0bDIyYmlINDVhZDZ1UmR2ekNscUpwL3Y4OHJSVWo0?=
 =?utf-8?B?R25jMUU5SHNnOUk5RnhON1BudVNpM3haWkdNQ0Z3dW5kT0RjRmR6TXhuTXl0?=
 =?utf-8?B?Vlk1VnZZTTlhOS9aU1EzVVBDNWZ6Mit3TmJ4dFA1N09xQk84WFV3eXlVeGVL?=
 =?utf-8?B?NGhuRnJGNmNHL0U0cjFsN3lub2dwRjNQV05xUEx3bTd1dTNEQ2dNMkViT2U3?=
 =?utf-8?B?UkE3ZThNS2NuUUtqNWNqL0loM3daa2tsNkdSYldJK2gxUjhsM2k0bkZTRHd2?=
 =?utf-8?B?YnhhZUtDL0tPZVEvcStZakFIN2xHRjdCcnllOUdOd05VVEl1a1gvOFJZRHNO?=
 =?utf-8?B?SXlPTHJ1SkJHQldqcDRuNzBMOXpVd2h6Z2drdnU5QnMrTGgvUUdnS2VVNTdK?=
 =?utf-8?B?NmY5b3hHaGN5Y1VKeGJJS1RENUNETUNYSmZabXRYT1NLYlE2U3lib09JUHVh?=
 =?utf-8?B?OFMvbEtwOWc5cURoR0F6Z2E5MjZ2WDRucHY4RVVHWFRGc2VWYmRPcHRRWjJs?=
 =?utf-8?Q?NFVvtQmYh6DsFdtCFV4n/cKbS?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6GXGN31fta0yQ3HQXB6oghIzp4W+O3xABf8WTnAP/PiVwPm5HYpTRFUkV2F/sdaPxT0rZolJ51LcEi27t+h0jVdkfEpjJoWA7potK8d7d4npoKXgY7ucnOzJBB8U3vJIMcffheENzcrMwcOTb3Go199DDaSoVym/vz96e/3tapdx0X05+gewzUs2KAAS4NU8WGzeQdTOcwi5xbcmUfUlapsGY5+dyZgbo25C1FBTxppPfRuVaYGppQCy50VwpeL9EB92AhD2x6v5rDXgu2FsG422RBKg+FX5L/wC/u7aIikmh+4NBAFW9e108xiiuNl2yLhltKn4w+v2HFMrZk6UOhmgImSCimd42kt7nJuL8O7gJAitUGg1HCMFpxJPTcycVTD8kWSmL1/APwthmjg9q6khEZteg+IpDFRJxFUCVzWCwAiU+Qq1Rrbz+h6xIJniGNpnRyLe8giOJwSwT+LHM0UhseRPWx1Zjuf0VOW52XngRGQdJS8/uWoYLsSWMydsp+/khqhRdD0zS6pHyuQ+OWRRP8YtufOjR5SEXbt4ITnBHLCEQqJ5QsaGDDdXrTIt3OxvQWCuNhOd3YuGpEjZY6fu/DngrgfglHBOjVhGh/0hsFvmyCiN7Ve7pcjFHgs+cWEaHFnjkLxo6v6aVJV5AvE8G/+H4FisycsAKbFurfgYey7cFocrGxVc1z12xxzD6mC5rte+6po1jfNMApesZXATXaWWtvdp8/7FiAbF1yAjZ9SNcuJWlfkYuGQA/dJ6NSYpiwU9V3YLkzz5mrZr9bP+btqTGWJg/3yQ42ZCygc2Y8ygDSuIVrLIVOpnLoha9mZ00+YNKcNF8gGkTJ+EtFTH8wquioA3Y4Lu9ribGM9XNsFm8KcV1WW5fCUcS1ED
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 478d3d83-1bde-4bfe-c5bb-08dac85f2364
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:46:56.6963
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YZdYQUTEbm5ZkyC8B/oLHMg5xtRlhhXM6pnvvnE+Mjw7/zEpn65g+scKvNQqeNvSii6P35Wj+Qh0nsQHwP13rA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4134
X-Proofpoint-GUID: 822aN-kN3FM5WGLczgZ_DxNak25mcitc
X-Proofpoint-ORIG-GUID: 822aN-kN3FM5WGLczgZ_DxNak25mcitc
X-Sony-Outbound-GUID: 822aN-kN3FM5WGLczgZ_DxNak25mcitc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-11-17_02,2022-11-16_01,2022-06-22_01
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
YS9mcy9leGZhdC9leGZhdF9mcy5oIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KaW5kZXggN2QyNDkz
Y2RhNWQ4Li4zM2EzZDU0NDM2NWEgMTAwNjQ0DQotLS0gYS9mcy9leGZhdC9leGZhdF9mcy5oDQor
KysgYi9mcy9leGZhdC9leGZhdF9mcy5oDQpAQCAtMTg0LDExICsxODQsMTQgQEAgc3RydWN0IGV4
ZmF0X2VudHJ5X3NldF9jYWNoZSB7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2I7DQogCXVuc2ln
bmVkIGludCBzdGFydF9vZmY7DQogCWludCBudW1fYmg7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAq
YmhbRElSX0NBQ0hFX1NJWkVdOw0KKwlzdHJ1Y3QgYnVmZmVyX2hlYWQgKl9fYmhbRElSX0NBQ0hF
X1NJWkVdOw0KKwlzdHJ1Y3QgYnVmZmVyX2hlYWQgKipiaDsNCiAJdW5zaWduZWQgaW50IG51bV9l
bnRyaWVzOw0KIAlib29sIG1vZGlmaWVkOw0KIH07DQogDQorI2RlZmluZSBJU19EWU5BTUlDX0VT
KGVzKQkoKGVzKS0+X19iaCAhPSAoZXMpLT5iaCkNCisNCiBzdHJ1Y3QgZXhmYXRfZGlyX2VudHJ5
IHsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGRpcjsNCiAJaW50IGVudHJ5Ow0KLS0gDQoyLjI1LjEN
Cg0K
