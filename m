Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2874664227A
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231520AbiLEFKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231488AbiLEFKf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:10:35 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7091007C;
        Sun,  4 Dec 2022 21:10:33 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B54ssoh014669;
        Mon, 5 Dec 2022 05:10:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=PSMaimujD+GcIpTakMpqfamqwhGTGdsLu8ggA+LdFq0=;
 b=i8mzUZ0Gj0RgefCIdReg3EXpq95aeA/fn0H+fJWolttIRyo/bsj94twD6esIUTGSDC1u
 JgpC3+jM2Oen6G8i3oj5vl1K2GAIy5F40HTMg3loa0dmSxH9/3jzgXe7ZldqOzvnnYjl
 MnHTJP+Ir3OMiKg9RDC130NPv0OQes0piuiNnymu/nlaQ5Nn6rJyljWLRg1GuGRz50tY
 HEc7b6dR5uaNBE/Vil2wD8yKKX0MPVDI99NzCEsrA9wgrqEf42OXX3AtKbbzD7av4Pdx
 kV/yZSYUMjXxSujvzKytfOtg0Vo0JrmVtvmxgE5tlepa0btRvGIMxbLA+i9u43CPd+bm MQ== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2044.outbound.protection.outlook.com [104.47.110.44])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7ycb1ahf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xh1xx+LKo2RbGTNUjiDXam5WVx1rkMY1+OfI1h4hv3drFqL2P8DD0RxCNqzFpt8BFpvmYyeYo2kqgCpFao36l9qZO018e3wGRjOKXH7RDtHYQgC1i/nMBuFIZfZc1b5KurRkDvGZcPF2bD+4xSjzJrNU8KvOngSWmrEm8E5CnSLKklcugft328l6bVllsLrYGuvOjFE6pEY9g712CxVMz6Zt7u+jzlWtj0aP1i0LktmYEwz8wmrGvDEZJ4dprP+bPPyyR7CWVsZMFQnvtmqk073R10jHs45VBr4LmMU8qDk9QgYLkdEGRYS9yoMbGicjzkcSFppjByExrPIKJtCwDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSMaimujD+GcIpTakMpqfamqwhGTGdsLu8ggA+LdFq0=;
 b=XIZCze8a7jpvgE+FX2pa8p1AwEVi8qxhIOb5D/mgqQkGMumt1hLblNZiZXUYVHIwoI1IbcozzqJmZij7ExniikGb19Idr4dD8djJOdUd6HSuu8SUWSqJPMzIRgmXuAIsyglosdDTgS31qn6OXmrmmWLeKwyhXkvIB+EpEiiryuZQOLJ23mIVhsr0R5zc4bcoU/Z0nTMrXxx1q1/kz6bNGmORFE5xd4qQqYi+2SwLUOMelwxt79sGBhfCsOb1PZ3fHHWuplNiC+b2UvcaMaYSo09mtNFYrVDnRMzAGbWJRHzzjY0xKYb4aQHUSPdhpGj2c1BBqZRt6wfVTiRWF9qLiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSBPR04MB3909.apcprd04.prod.outlook.com (2603:1096:301:2::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.14; Mon, 5 Dec
 2022 05:10:19 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:10:19 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 5/6] exfat: remove i_size_write() from __exfat_truncate()
Thread-Topic: [PATCH v1 5/6] exfat: remove i_size_write() from
 __exfat_truncate()
Thread-Index: AdkIZqkGDJStBxJVRvqAguPRIr3LCA==
Date:   Mon, 5 Dec 2022 05:10:18 +0000
Message-ID: <PUZPR04MB6316A1684B2C6398D8E4B25381189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSBPR04MB3909:EE_
x-ms-office365-filtering-correlation-id: b9af9feb-a35a-40ee-d321-08dad67f00ea
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 91yTOwbdmIdNS/UM75Z8MHPziZexYOYD+xbNQI84R7EhFbkXO43QR+8pVZHWWLQTvxLqn67HHNdxE2d+u9OloLFN0I+zev6mlVyg9g9kUhvJWUUX6x3aCN/6IerQoqyZCxJa5uYtsaWYU0MDo4utVdzlBInJlacJYwmKzahipAuqtjSRJ4SlQIkAsK2GjyJaI1CgBqeZY2d9q0WjobvoeGLO9v46WnFv4Nt4BB7cXW+9q8IetfTt1CVoGHQNQuDT+LA2oHXpWV5/gUJJdEkK6KSx2MfNRN8h/bEAxwE9DhHGLJB5oBEAx7TgLiGHfpLYupC+Pm2i+Zxi760hhbjYJjQrmicE3WQ7rI7TN6ncP0Pelwx+bsgWoeJwAdXkkVYG1kWM0E/xQs+6mQ9yS2LP89ZrE5G3KF2KpjdR+dIBjmdfoP1YO9wwq1Jo2EIVmfxNxQ25Kq8PYBDvkbJ9df3PMkQV8y0fchvi7aCFdV6Sq9UiZdbT5e3ycVYs52rDy9c3CuN8zOR0QfclYpR8tidKxqJyn41tXN0OEFnUqDJJcIpa6VzQkyBOsnJtsDP7CCSIHJB8Kn2Oldek9TFARYZ++as/5lBVBQumEmLkiF5/51GZk8eIcpjcWxNHiCmrRSGz4WWHlG2/YG1tGRiu6JTuepRsYfS9w1a7Q2YJz3YW2cDGZGj+6E7aqSsgGhyPuEB9tiBuU/08ZDifFe2Jw7xfxA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(366004)(396003)(136003)(346002)(376002)(451199015)(26005)(316002)(107886003)(478600001)(6506007)(7696005)(54906003)(110136005)(9686003)(71200400001)(76116006)(66556008)(66476007)(8676002)(66946007)(4326008)(64756008)(66446008)(8936002)(52536014)(5660300002)(186003)(83380400001)(41300700001)(2906002)(122000001)(38100700002)(82960400001)(38070700005)(55016003)(86362001)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SlJUdXdWUG1PK09CM2w2ODBKVzM5YXZlbm8rK2xqK0JiLysvcUQ1bVFGbjdM?=
 =?utf-8?B?SlBTbWNpbXRBekJHZzZDTHZRQmRYQ2o1MlRkcGVGRXR4Y2ExYUV3K1VlcGlq?=
 =?utf-8?B?U0x4WmpNdTQyaWM1Ujh5dzd3Q2MyemJmVlBRZ1ZUd2ZhbXBXZklBZFZhc3Rp?=
 =?utf-8?B?cGhlMDYwd2M2YjcvMEZKVzdFcmV1M2xvQzVhSHh5UjU0bVZpVHFpakNpRkN4?=
 =?utf-8?B?MDNmSUxoT2MyK1NhenFURG1vTEZiV1FPU0sxenZMQmNXeGZLWE5UVCszNFBo?=
 =?utf-8?B?OHFpT2Z4Ylo4dkxIS05xOWVTaDBKdXpCR0w2ODhpc3ZrRWttWmQwOFIraXZ3?=
 =?utf-8?B?K1pwaUZ2bjhxMHRLa3hWYXlFOUdCdDZrclBUeThTUnFCZmRwRVpYQ2dyOTlw?=
 =?utf-8?B?OHo5bkNSdG9iWCtZbzI2Q1pRSXpnQ1lUaFp2R3hyQmVFcG5DdXlyM21EZlRr?=
 =?utf-8?B?QlZ2WDdieEVqNEE0RmoxU1FhNGZTbVNaUmc2ci9UQ1Bld0hxaGlSN09EYk43?=
 =?utf-8?B?QjZmL21ZMVNLWDRia3htMVdCZE5peXkzeTNnRllFU01LTVRRVmtUb1pFUDQ5?=
 =?utf-8?B?QkwwN0RVOVlPa3BwTGZXbytGaUdMSDdQNG5Nb2lwbXdUQXVpdVhYSHRCaFh2?=
 =?utf-8?B?QW5CYjI5TGo0Wko2WHNRYlo3RktJS25BRG5JVi9nT1FxbXBWZWtza3RhWTNC?=
 =?utf-8?B?WERFUlJEZXN4dFNYOGVNTkdGTTYzUTJCd1JVTFA0enNGbkVpRmlmeVlHVjNs?=
 =?utf-8?B?Y3oybnN2L2JTT0RjbDlTamxNMnQrc1FCeXV6dDFZYkxGWlpjRXNPNXBqdXIy?=
 =?utf-8?B?ZlIvR1I2ekpJYkpZV3FBbnV0WjQxRno5bkp1bGFqVHYwZWprL3NUQ3c3VDJz?=
 =?utf-8?B?WC81cHdIdEVGRWI0cko5anhnNk9jaG9hMFpiMHlEMnlPbGtoTk56NGk4bW44?=
 =?utf-8?B?TE9KVlZRbm5jeTVTajJNNU0xcEY2UHZEK2dCZ0tEUHVJRjJ5UEpYT1piZW1r?=
 =?utf-8?B?T3F4VlFTUmRSM2QzcXZQNFpQMkxtUUZCMmxUYmpMVDBoRG5PWllGS2h2WlVN?=
 =?utf-8?B?TDN2T0dTMjgwQ2dvaDlhUnFWYTJ0OUdZdFpLcDBHSlI2czFob1ZjRkQvRCs5?=
 =?utf-8?B?NTVlSGhqWkZnY3E5UWF2R1dQYU9rYkplYWxlemlwNXRzczg1Qno0NGFyYnp1?=
 =?utf-8?B?cmI5RXdFZVo5UzFCc1VCLzNwbVFtc1ZzME9YRXhIWG9JMHVaMWhabUdhdWRX?=
 =?utf-8?B?a1l1TFVKeFJyeHA2UWxYUTB1UVo4UzZlNVkyU2JXcDRRZ3g0ckx4VXBsS0Q1?=
 =?utf-8?B?cmFxRkNMUjdIbHBqYUxGN2Vjc3RnSXRSOVlsRm03Y2NiT3pLV0RMVXhIU3Zz?=
 =?utf-8?B?SFI2QVFnNHptWFdZOFBjbU5NU3hIWm4wYmR4KzZOcUVsSFE0Myt1RnJ2Q0Jp?=
 =?utf-8?B?R1hxbEh5cVhYV041Slhta1lnai8zQ0xSa1hncDBLMjBlZG9DK3I0TXRReHZt?=
 =?utf-8?B?MHdPZS9waE9GdEhBclFUSTZaeVRUM1A1bUJRR3pnV3R2aU8xbVJJZUI5M3Jq?=
 =?utf-8?B?dE5wVkszbTU0TlVpMENpVStDQ24xUlBwekhOV0NocXVnUFpPZUVvOVlFSWhG?=
 =?utf-8?B?QVhzYURaeTJCKytxVWVZUWp6VUladDY0YjNCTzRtNDMzQldvNXlvM2FkS0ha?=
 =?utf-8?B?TmhheC9PS0l1azJRU2ZJSDlWb0lRUFk2YzExVStEQ1dwUnhvck9PN09iWC8z?=
 =?utf-8?B?TldTNERRdTg5clR3NHBZbmdZYXhEOHpCaWdWZjRIYWcreU1oaS8vc25ScHQr?=
 =?utf-8?B?eDdmTTYrSUI0WXk2eEdXdkUvcjREMFZTeU1EYXlKdGV4U1BSbFcvQjk3TlFq?=
 =?utf-8?B?R0EvVitUU2pmdGNZUzNUbk1LL0dNc2trNUlXdTVFdFA3elBDa3YyR2NZMzVC?=
 =?utf-8?B?RjAxZFY1TU83bmEyOEtTSUpaVjIwd2NUOGkwUE1EaWRTeXpLQjFPdWxQVlcw?=
 =?utf-8?B?OEtERDg0YkJYZ0hXekhUS1QvZGxhVXVBeHQ2Si9KS1UzSGdhN0JITGZscVlJ?=
 =?utf-8?B?U1VPWXlaUUVmQ3ByRTZKYmlCZmwwcXZOVCt4dzlxQm9nR2htUVh1Q0loeTBP?=
 =?utf-8?Q?dGXlauAOX/W5EohOvLXj7DSPL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WaR/8hleepkupXMpaA8a8ZV81DDscynRR3HTbHPRN3fEGqeD8ta4Yx6iIPHVCMHhCFLl8ZaBhyCxROvtwlXfaB1SIj9+c5TC7He9IzHUQa6H4lfKVC7x9PYoolL+c1m0XanG9JkMuBj/nVI60dkHtkVeuuSIQXziszyZDykCcRkgyT8MEi8rsTmitjWhf/8nP3HhGmRyOk+xQUClmI9hBV1VjoKreVRnOLcccqkWDZVSfp1h8zqR7xWBGBylOCSTFzzMhQ/5mewclCq4qq/YY0jVZqFlnSG8343y9KVYVx9gb16L4ByXdFYzGliRiEHABi7JpCf4ZrLt+p6j+Loj6Xj93sc/aXLJc5eRncCVJKDZ2HnVesZYXeBJTHBeAfQ3RmVniEqThgN/ZJiYzcvTW44kxX/fv1SkEMoSuPG/UBpCK1RRHs+HNIWwPSAIW9V4f+ltDH7OA07IJtoREoc9Z4XYi/UNG3cqaQ/qT9ofJqS9Kk2EgFrmWajaGYtf33/4PU438Nvu6u39a6xZSxq/Kg0M6rMzy/5iqtvsAWw3c7itH5CPf4Ymo/nnf6T93K6NNE8ilxni7KoI3tmKjnCPj4T9fSrXtZ2eSIeP5Sfu0QF29f5KtX6QbqYy2Q/o3X1ckkz3XSQS+vM0ZUq1qTdda4tUPdEhEZKbyWpLVN7u8vzf/mS7/VD5AX5R9NtgiwpaGWQ+RQZhrhjXwUe0MzyUQv9LCHA77/3tmJLd2I2yxbi+GBpsl4F1QWbi1Xu++5orfg+6oDpwUJK5CmqozLo2iV3SGaADYYtCv8eYWE9xZ56zPDY/NW7Htjs+hoZTZdOE5m2sya1CGD0OeiKngoVF6qkaL6odWN42abE+6y3YKIboTNwmF3wUeJAyy+RcW8/s
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9af9feb-a35a-40ee-d321-08dad67f00ea
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:10:19.0301
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qILIC8eybYI7nqtph9szwgqZ2wcAWjQOAg5+EPZG4J2+bQzJJwnPSx/7HWNaZz0kZi0vld+J6EpinKuctOQ0Hw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSBPR04MB3909
X-Proofpoint-ORIG-GUID: cOA1nKQpeU4WFVRvITZCwCuweMQOfAIN
X-Proofpoint-GUID: cOA1nKQpeU4WFVRvITZCwCuweMQOfAIN
X-Sony-Outbound-GUID: cOA1nKQpeU4WFVRvITZCwCuweMQOfAIN
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

VGhlIGZpbGUvZGlyZWN0b3J5IHNpemUgaXMgdXBkYXRlZCBpbnRvIGlub2RlIGJ5IGlfc2l6ZV93
cml0ZSgpDQpiZWZvcmUgX19leGZhdF90cnVuY2F0ZSgpIGlzIGNhbGxlZCwgc28gaXQgaXMgcmVk
dW5kYW50IHRvDQpyZS11cGRhdGUgYnkgaV9zaXplX3dyaXRlKCkgaW4gX19leGZhdF90cnVuY2F0
ZSgpLg0KDQpDb2RlIHJlZmluZW1lbnQsIG5vIGZ1bmN0aW9uYWwgY2hhbmdlcy4NCg0KU2lnbmVk
LW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6
IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8
d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAyICst
DQogZnMvZXhmYXQvZmlsZS5jICAgICB8IDggKysrLS0tLS0NCiBmcy9leGZhdC9pbm9kZS5jICAg
IHwgMiArLQ0KIDMgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygt
KQ0KDQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBiL2ZzL2V4ZmF0L2V4ZmF0X2Zz
LmgNCmluZGV4IGFlMDQ4ODAyZjlkYi4uYTFlN2ZlYjIyMDc5IDEwMDY0NA0KLS0tIGEvZnMvZXhm
YXQvZXhmYXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMuaA0KQEAgLTQ0OCw3ICs0NDgs
NyBAQCBpbnQgZXhmYXRfdHJpbV9mcyhzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZnN0cmlt
X3JhbmdlICpyYW5nZSk7DQogDQogLyogZmlsZS5jICovDQogZXh0ZXJuIGNvbnN0IHN0cnVjdCBm
aWxlX29wZXJhdGlvbnMgZXhmYXRfZmlsZV9vcGVyYXRpb25zOw0KLWludCBfX2V4ZmF0X3RydW5j
YXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUsIGxvZmZfdCBuZXdfc2l6ZSk7DQoraW50IF9fZXhmYXRf
dHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSk7DQogdm9pZCBleGZhdF90cnVuY2F0ZShzdHJ1
Y3QgaW5vZGUgKmlub2RlKTsNCiBpbnQgZXhmYXRfc2V0YXR0cihzdHJ1Y3QgdXNlcl9uYW1lc3Bh
Y2UgKm1udF91c2VybnMsIHN0cnVjdCBkZW50cnkgKmRlbnRyeSwNCiAJCSAgc3RydWN0IGlhdHRy
ICphdHRyKTsNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9maWxlLmMgYi9mcy9leGZhdC9maWxlLmMN
CmluZGV4IDdjOTdjMWRmMTMwNS4uZjViMjkwNzI3NzVkIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQv
ZmlsZS5jDQorKysgYi9mcy9leGZhdC9maWxlLmMNCkBAIC05Myw3ICs5Myw3IEBAIHN0YXRpYyBp
bnQgZXhmYXRfc2FuaXRpemVfbW9kZShjb25zdCBzdHJ1Y3QgZXhmYXRfc2JfaW5mbyAqc2JpLA0K
IH0NCiANCiAvKiByZXNpemUgdGhlIGZpbGUgbGVuZ3RoICovDQotaW50IF9fZXhmYXRfdHJ1bmNh
dGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXplKQ0KK2ludCBfX2V4ZmF0X3Ry
dW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUpDQogew0KIAl1bnNpZ25lZCBpbnQgbnVtX2NsdXN0
ZXJzX25ldywgbnVtX2NsdXN0ZXJzX3BoeXM7DQogCXVuc2lnbmVkIGludCBsYXN0X2NsdSA9IEVY
RkFUX0ZSRUVfQ0xVU1RFUjsNCkBAIC0xMTMsNyArMTEzLDcgQEAgaW50IF9fZXhmYXRfdHJ1bmNh
dGUoc3RydWN0IGlub2RlICppbm9kZSwgbG9mZl90IG5ld19zaXplKQ0KIA0KIAlleGZhdF9jaGFp
bl9zZXQoJmNsdSwgZWktPnN0YXJ0X2NsdSwgbnVtX2NsdXN0ZXJzX3BoeXMsIGVpLT5mbGFncyk7
DQogDQotCWlmIChuZXdfc2l6ZSA+IDApIHsNCisJaWYgKGlfc2l6ZV9yZWFkKGlub2RlKSA+IDAp
IHsNCiAJCS8qDQogCQkgKiBUcnVuY2F0ZSBGQVQgY2hhaW4gbnVtX2NsdXN0ZXJzIGFmdGVyIHRo
ZSBmaXJzdCBjbHVzdGVyDQogCQkgKiBudW1fY2x1c3RlcnMgPSBtaW4obmV3LCBwaHlzKTsNCkBA
IC0xNDMsOCArMTQzLDYgQEAgaW50IF9fZXhmYXRfdHJ1bmNhdGUoc3RydWN0IGlub2RlICppbm9k
ZSwgbG9mZl90IG5ld19zaXplKQ0KIAkJZWktPnN0YXJ0X2NsdSA9IEVYRkFUX0VPRl9DTFVTVEVS
Ow0KIAl9DQogDQotCWlfc2l6ZV93cml0ZShpbm9kZSwgbmV3X3NpemUpOw0KLQ0KIAlpZiAoZWkt
PnR5cGUgPT0gVFlQRV9GSUxFKQ0KIAkJZWktPmF0dHIgfD0gQVRUUl9BUkNISVZFOw0KIA0KQEAg
LTIwNyw3ICsyMDUsNyBAQCB2b2lkIGV4ZmF0X3RydW5jYXRlKHN0cnVjdCBpbm9kZSAqaW5vZGUp
DQogCQlnb3RvIHdyaXRlX3NpemU7DQogCX0NCiANCi0JZXJyID0gX19leGZhdF90cnVuY2F0ZShp
bm9kZSwgaV9zaXplX3JlYWQoaW5vZGUpKTsNCisJZXJyID0gX19leGZhdF90cnVuY2F0ZShpbm9k
ZSk7DQogCWlmIChlcnIpDQogCQlnb3RvIHdyaXRlX3NpemU7DQogDQpkaWZmIC0tZ2l0IGEvZnMv
ZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IDBkMTQ3ZjhhMWY3Yy4uOTVh
ZGM0YjJlNDM2IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhmYXQv
aW5vZGUuYw0KQEAgLTYyNiw3ICs2MjYsNyBAQCB2b2lkIGV4ZmF0X2V2aWN0X2lub2RlKHN0cnVj
dCBpbm9kZSAqaW5vZGUpDQogCWlmICghaW5vZGUtPmlfbmxpbmspIHsNCiAJCWlfc2l6ZV93cml0
ZShpbm9kZSwgMCk7DQogCQltdXRleF9sb2NrKCZFWEZBVF9TQihpbm9kZS0+aV9zYiktPnNfbG9j
ayk7DQotCQlfX2V4ZmF0X3RydW5jYXRlKGlub2RlLCAwKTsNCisJCV9fZXhmYXRfdHJ1bmNhdGUo
aW5vZGUpOw0KIAkJbXV0ZXhfdW5sb2NrKCZFWEZBVF9TQihpbm9kZS0+aV9zYiktPnNfbG9jayk7
DQogCX0NCiANCi0tIA0KMi4yNS4xDQo=
