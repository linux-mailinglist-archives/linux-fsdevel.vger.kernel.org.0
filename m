Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347B24AD151
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Feb 2022 07:01:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245289AbiBHGAv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Feb 2022 01:00:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbiBHGAe (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Feb 2022 01:00:34 -0500
X-Greylist: delayed 2473 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 22:00:33 PST
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DB30C0401DC;
        Mon,  7 Feb 2022 22:00:32 -0800 (PST)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2184iM1R015321;
        Tue, 8 Feb 2022 05:19:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=AYEx30/22S6Pe7WoL4POKsxfuEHRXVrpBC/A8TRJhm0=;
 b=ptrsLPx0oRnAxyqXAKZUSn+zqt87i3RDUN3xxQ944tw6LaBsTxztSUv9rZSTAaMK7qCB
 kscYh/CTJBosDJsq0cddHW1HtrAetaXAlR+S/ucFOgZUlvcRQ7s5Z5HsXYa3YkkknDA9
 feLntWHRgo/+19fCkes1FXe3vG0I/dcU52aBO0LGeTKjOywl8hYmZIrhvPral+n2NslX
 qIKsHd3LB8GIfxJarKhHrTcO6PFYUGOZAQAerPOMmtv/bdxJ5zJxFeXFZizNHDRB0mtI
 2FftsSiW95PFUBPqoyTSmulS63oKOMMrBY0pDYaYsh3Xx56Wn3mFgSgqeD0bGWpZfwOJ bA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2109.outbound.protection.outlook.com [104.47.26.109])
        by mx08-001d1705.pphosted.com with ESMTP id 3e1g16aesn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 05:19:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZwLqb4vsmL4plCIlKU1dXBBtRzGPkojlxorU/k8ohI9NK6s8yTdTIft+LMV0/gUWLg7Ppy9drmIIqKcG5vA+pW9AbMmVwSnXhHohmaITDcqtsMgRDV80cfqGrpHeDkJbxcLAvOXI7VUYd0xIy0OjU930HHQHrCpPgkcaaq4hC6tMroSaYbH4/lflUD2/Qh9CA8aLPFP6AbVKYafnh3WARbcNSNuj4QfwbEbgIAwG8sYIlGuKpTtDO3fYpOTLsYwnOFpiupPqXLutQMdTGkuI7j5U3nU7Ibvod7gzhHlhf29gU+h1PYrqIY36XqPugSsMyoQX+yc5DGIDOkGxp7/GjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AYEx30/22S6Pe7WoL4POKsxfuEHRXVrpBC/A8TRJhm0=;
 b=JpwNaW1APy5q1K051pySPkjz/Rj6LnnHJ/ZzNdQKVMqlCCMc4Clcw1zhBwp+95K3Fnl+a1+70WUDCpOp3BM/E2B0pdpUf+dkDJrNCN8IofSOqoXwiy7Sryz9EwpZc7ZUK/Id60UkW6eulvJoqTxrbhtxliYWcT/7OvHEwf+YVccyozUPlxoYFBDuppdcX3EJM2CAHyfL+cqexGWjKvIHR0vMfI5Kwb6AMR0xxA0ozIDkDeIyV4v/5eHkbnfBcbFW1nY2+ufDBHujyeh9kSmAUpaUG4SF0JexDDTX7+CFBfpjtd2rdle8A3ktWoCXFtv1ENH7Yq6RlsNcfTdeX0Vp6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by HK0PR04MB3169.apcprd04.prod.outlook.com (2603:1096:203:3f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Tue, 8 Feb
 2022 05:18:57 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::24c5:f243:ecdd:80b7]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::24c5:f243:ecdd:80b7%5]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 05:18:57 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCQ==
Date:   Tue, 8 Feb 2022 05:18:57 +0000
Message-ID: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: e9111107-af93-7ba9-9a04-b4d950db9f08
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a2b85178-3207-45aa-4cf6-08d9eac281c9
x-ms-traffictypediagnostic: HK0PR04MB3169:EE_
x-microsoft-antispam-prvs: <HK0PR04MB3169E92208E0F283459EEE29812D9@HK0PR04MB3169.apcprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:43;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cMB14keXnm3EqxEJFBh3dmo/h81dA/wBvE5EgzeY5/TsZa1Z1GAnFr4F1Lw89/3FOJIAjOT4SpymtG7Js96AU6dPUMvpzka+wtcRYKOGVLVrcS796dX3zGad8T7JraYMr9/uqH1ed46LGH82QjxBnFgQt6tA3FNaDzTD/EJ6lnwseGlAr7QMGWwTnSIUy7T2y3eOdlE4jpFDjmq7gt65TyL9o6KJYkWTV5j/Hr1Y9UT2ZUAEeF9siBV254KkeR+wgXfoFzttjRpJv/hLTuDRGrV62+nr0NzwhQynEnv5hvh2A1sefHsRrWGeLCd7/FjCJTjawFETNz/R2HekNhyXoGQgpPNgvtgWu8p8y+lH1jl5HnvxPoBh4Dj7z824cGIkMXCgYaH11w99fnpBF2wWSppGKRi35z8MoWDuEQ8Jm3uOY32km1s2FJyagk9oXmA/KCePEg4iy3lOxzUBJL0lGRAHBKN4Q/fx/3c/sgml0u6EvJTJ/lB5trfBUM0Z1XXN1/iiDMWS642E/XZPYKuQzmHk74K7N3xo12/szRE6Qpx2OSxynBltMT1gB/91ab9FZnE2jDz7NKKOelUR8kVw2HTgKwnOJYdpDQ3Ie4nK4SMSIWlzQenUMRkuqTbi1pY2sgZJ/3tA2MLFq98rsfJ2LPZTohOtyq7U6J9q8iT9kGDFnQ8XHE0KA5OXFya5fFpV
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(38100700002)(38070700005)(76116006)(82960400001)(186003)(66446008)(54906003)(8936002)(66946007)(64756008)(66476007)(66556008)(110136005)(316002)(91956017)(8676002)(4326008)(55016003)(52536014)(5660300002)(122000001)(83380400001)(86362001)(33656002)(7696005)(6506007)(71200400001)(9686003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?gb2312?B?REZjWS9XMXpjNGtJRitpK3EyUlQ4dTlaUWo0dXBpY0JYd3YxOGw0b2U4TUNO?=
 =?gb2312?B?WmVOVmhZbkxleW9iVGtobFNZb3p3YjdvZmI4QkxoL2Zzc0d5NVNTYUorRlQ0?=
 =?gb2312?B?b1laQlJtcEdZd255bCtWOVVrb1J0SkJuakpyRWdkSXEwNXNKV281VkxoOURV?=
 =?gb2312?B?S3Jxc3p5cTVtNXorQU1helVwTDBnM1kxeDJQR0hnRTJydENPZFc3cHhJM3hV?=
 =?gb2312?B?N21VbUh3dnhEZzA1cy84ZDZGL0N2S20wR3NTdGdKQXk2c2EyOCtMZm0yalFU?=
 =?gb2312?B?aWJOaWlPQmlPZUlxcnBaTm1zcktXMkdXUm8xTWJJUTc2M2szQ29NNlhSMTZD?=
 =?gb2312?B?Tms4N0FFeGI1R3hVM2pURmJ1V2dIVnpWdlQwS3l3WUVmczM2eXE5MktlcEFV?=
 =?gb2312?B?Qk9pMFBzS1ovdTFqUG9VSmgyMmYwc2JHbjY5N0M3T2s4VUpQaHdPdG9GRW11?=
 =?gb2312?B?V1UyaHI0U3ZGOXZEZVRxZVo0WHEwQjNjOEhvQk5kcXNOd3RMYkNtbTc3dDJM?=
 =?gb2312?B?bDdaYXBxejl0dS9rdGQzRG1uZ2VsYUluemt5dU9Fc2NTUHNIc2k3a3VjdENP?=
 =?gb2312?B?b0ZNeWxxeEpyRzZHRyttUGYwSE9UZlQxTFQvQk9JK0xkVVV5ZkR5UEVSL21l?=
 =?gb2312?B?VzFRbkZJWUo0SThKMlZOTEtDWlNVRVd3bmRwWTBIWUdXcWZLeG9aTVZNZ1pX?=
 =?gb2312?B?VHk1eEtiMTRMZXNhWUR3ZFR3RTNXK3B0eEVHNmhUeUdWWWNuekVJUnVZZ09L?=
 =?gb2312?B?d2VFTk5jRjF4eXdSN3ptbXRIMUpFRlh1RGdzS2VKdzFFcVlybUluTWJ2WjJJ?=
 =?gb2312?B?NjBpYWt5T3hLa1haYUpwMDUzZVVnUW9RNnVtYWpBRzNCVndCQjY2YmVCc1lZ?=
 =?gb2312?B?Tm1XTjhCbWJJUEFLLytubEcweXcrZTNyNDJpbjd4QUJsL2VMb2d5QitvR0NV?=
 =?gb2312?B?b3NVMXZqbzZjcnp4ZkU2QklQejVWTTNuaXN0TWJlTWZURlA1V2t2VTNITWJz?=
 =?gb2312?B?Wm53NDVSaDgrQmNVMjhOK2Nydm9POS9FazJqR1N1djY1Q3pTQ2Y0UytCeGlH?=
 =?gb2312?B?aGlIZHBKYURxRnhsOGxlSnFmSDZnWjNsbVV1WEo1QmdXcWtVTU53RlpqeXI2?=
 =?gb2312?B?VkdOQnhYYVZidlVBei9iZVI0UnZlN0lWVGlRSHc0QVdSNUVpbFRSVGp6cXdQ?=
 =?gb2312?B?SVhuaUJ1UnRlWkp6OWJsblJ3RWV0cU9xcDFyV0RoekFpc0wrandKb3ZkbERX?=
 =?gb2312?B?M25GVjZKVFZsMU5hcDdXK3VGYkx1NzFYZFhFNEdGczZQTWlKSENCUGw3U1NW?=
 =?gb2312?B?Y0pIbjZGaXpnOVFEZ2NVT3JOak1uRkMxVk9iT1RYU3FpNml1cWVlTmZXcXRI?=
 =?gb2312?B?aTZWN0lqTWVRQmRCaXdzZmFINEladzR1M2NRbFo0aEpRL2s2ZHU1MzZ0NmlR?=
 =?gb2312?B?Q0VmazdQaWhoZFlIbWIzYWNRbE1kcmplWWgvMXBkaEEyYTUvYXUwTjExeVMw?=
 =?gb2312?B?OVk1ZkFqQjF2L0ZpbkMvcVhjUU84ZHFvN1E1Uk8xTXVEdVpzY3VLa1psaXIz?=
 =?gb2312?B?dGJVdjhjaWxIempQbGNrK0s3WksxLzJqOXZKNkpOeWY4N1ZycTFUa1lCTXNx?=
 =?gb2312?B?Rm1GbXQwUlUrMjhWbXBsNlpEWnFmcFllTHRvOUg2V1dxcHZrdVJQNW5BTWNj?=
 =?gb2312?B?UmkwOXNEU25YektkRnRMR2w5WHJUTjlLNkRGTjdNTHB5dkl4V1JrNDlpLzlG?=
 =?gb2312?B?c1JjeFlpeWlCQVdSVjN0VTlwK0JWOWtlZEY4RVE0V0ovRWlOTEI2YjNEVU5Y?=
 =?gb2312?B?VHdmRXJMZjVtSHQvMFBwcVNCN3hGbVV2cmk4MGwyR091N2VjU3pPeU9aai9F?=
 =?gb2312?B?UURIaDlaUHlmbjZSb01MczNOVTJkMnZaL2djdElFeHkzN00yK000UHk0Tm5Z?=
 =?gb2312?B?MUtNMmdMZDdtcWVSVkxnZGdGTjR2d0hyQjlXdHBhbm1yekVMTGpjYitNZU40?=
 =?gb2312?B?bFc3c2VlTnFxWnl6bmFGNkVKcFl4Qy9HMlZLUGxKNXIrbWFvbUdxNWdoYWg1?=
 =?gb2312?B?M3l5ZjgwWXhhbXBQa0FTdWRNcjlFTjE1UWxXQm9rV0gySnd6ZldzY3ZLdElD?=
 =?gb2312?B?a1kwRGxYdkFSVXVvMG5lN2hIbUdodUgyUHZzTHpIZC95YWt1cHYzQ29sT0E5?=
 =?gb2312?Q?dX7f11AITrO7rNuSnRPSzhc=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a2b85178-3207-45aa-4cf6-08d9eac281c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2022 05:18:57.0706
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kb56fNVVpb//8A41FPEHMvhi68ZnXXi9fWBDs6FWxef6SG3x3234vGhlzqyiF6px4h6uAvod32WIyYDwYMCmXA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB3169
X-Proofpoint-GUID: kGt5BMN2kMnxSjvndz8NXTrtjAm0rlQB
X-Proofpoint-ORIG-GUID: kGt5BMN2kMnxSjvndz8NXTrtjAm0rlQB
X-Sony-Outbound-GUID: kGt5BMN2kMnxSjvndz8NXTrtjAm0rlQB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-02-08_01,2022-02-07_02,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 clxscore=1011 bulkscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202080026
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

QmVmb3JlIHRoaXMgY29tbWl0LCBWb2x1bWVEaXJ0eSB3aWxsIGJlIGNsZWFyZWQgZmlyc3QgaW4K
d3JpdGViYWNrIGlmICdkaXJzeW5jJyBvciAnc3luYycgaXMgbm90IGVuYWJsZWQuIElmIHRoZSBw
b3dlcgppcyBzdWRkZW5seSBjdXQgb2ZmIGFmdGVyIGNsZWFuaW5nIFZvbHVtZURpcnR5IGJ1dCBv
dGhlcgp1cGRhdGVzIGFyZSBub3Qgd3JpdHRlbiwgdGhlIGV4RkFUIGZpbGVzeXN0ZW0gd2lsbCBu
b3QgYmUgYWJsZQp0byBkZXRlY3QgdGhlIHBvd2VyIGZhaWx1cmUgaW4gdGhlIG5leHQgbW91bnQu
CgpBbmQgVm9sdW1lRGlydHkgd2lsbCBiZSBzZXQgYWdhaW4gd2hlbiB1cGRhdGluZyB0aGUgcGFy
ZW50CmRpcmVjdG9yeS4gSXQgbWVhbnMgdGhhdCBCb290U2VjdG9yIHdpbGwgYmUgd3JpdHRlbiB0
d2ljZSBpbiBlYWNoCndyaXRlYmFjaywgdGhhdCB3aWxsIHNob3J0ZW4gdGhlIGxpZmUgb2YgdGhl
IGRldmljZS4KClJldmlld2VkLWJ5OiBBbmR5Lld1IDxBbmR5Lld1QHNvbnkuY29tPgpSZXZpZXdl
ZC1ieTogQW95YW1hLCBXYXRhcnUgPHdhdGFydS5hb3lhbWFAc29ueS5jb20+ClNpZ25lZC1vZmYt
Ynk6IFl1ZXpoYW5nLk1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4KLS0tCiBmcy9leGZhdC9zdXBl
ci5jIHwgMTQgKysrKysrKysrKysrLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMiBpbnNlcnRpb25zKCsp
LCAyIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9mcy9leGZh
dC9zdXBlci5jCmluZGV4IDhjOWZiN2RjZWMxNi4uZjQ5MDZjMTc0NzVlIDEwMDY0NAotLS0gYS9m
cy9leGZhdC9zdXBlci5jCisrKyBiL2ZzL2V4ZmF0L3N1cGVyLmMKQEAgLTI1LDYgKzI1LDggQEAK
IHN0YXRpYyBjaGFyIGV4ZmF0X2RlZmF1bHRfaW9jaGFyc2V0W10gPSBDT05GSUdfRVhGQVRfREVG
QVVMVF9JT0NIQVJTRVQ7CiBzdGF0aWMgc3RydWN0IGttZW1fY2FjaGUgKmV4ZmF0X2lub2RlX2Nh
Y2hlcDsKIAorc3RhdGljIGludCBfX2V4ZmF0X2NsZWFyX3ZvbHVtZV9kaXJ0eShzdHJ1Y3Qgc3Vw
ZXJfYmxvY2sgKnNiKTsKKwogc3RhdGljIHZvaWQgZXhmYXRfZnJlZV9pb2NoYXJzZXQoc3RydWN0
IGV4ZmF0X3NiX2luZm8gKnNiaSkKIHsKIAlpZiAoc2JpLT5vcHRpb25zLmlvY2hhcnNldCAhPSBl
eGZhdF9kZWZhdWx0X2lvY2hhcnNldCkKQEAgLTY0LDcgKzY2LDcgQEAgc3RhdGljIGludCBleGZh
dF9zeW5jX2ZzKHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIGludCB3YWl0KQogCS8qIElmIHRoZXJl
IGFyZSBzb21lIGRpcnR5IGJ1ZmZlcnMgaW4gdGhlIGJkZXYgaW5vZGUgKi8KIAltdXRleF9sb2Nr
KCZzYmktPnNfbG9jayk7CiAJc3luY19ibG9ja2RldihzYi0+c19iZGV2KTsKLQlpZiAoZXhmYXRf
Y2xlYXJfdm9sdW1lX2RpcnR5KHNiKSkKKwlpZiAoX19leGZhdF9jbGVhcl92b2x1bWVfZGlydHko
c2IpKQogCQllcnIgPSAtRUlPOwogCW11dGV4X3VubG9jaygmc2JpLT5zX2xvY2spOwogCXJldHVy
biBlcnI7CkBAIC0xMzksMTMgKzE0MSwyMSBAQCBpbnQgZXhmYXRfc2V0X3ZvbHVtZV9kaXJ0eShz
dHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiKQogCXJldHVybiBleGZhdF9zZXRfdm9sX2ZsYWdzKHNiLCBz
YmktPnZvbF9mbGFncyB8IFZPTFVNRV9ESVJUWSk7CiB9CiAKLWludCBleGZhdF9jbGVhcl92b2x1
bWVfZGlydHkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKK3N0YXRpYyBpbnQgX19leGZhdF9jbGVh
cl92b2x1bWVfZGlydHkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIHsKIAlzdHJ1Y3QgZXhmYXRf
c2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOwogCiAJcmV0dXJuIGV4ZmF0X3NldF92b2xfZmxh
Z3Moc2IsIHNiaS0+dm9sX2ZsYWdzICYgflZPTFVNRV9ESVJUWSk7CiB9CiAKK2ludCBleGZhdF9j
bGVhcl92b2x1bWVfZGlydHkoc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKK3sKKwlpZiAoc2ItPnNf
ZmxhZ3MgJiAoU0JfU1lOQ0hST05PVVMgfCBTQl9ESVJTWU5DKSkKKwkJcmV0dXJuIF9fZXhmYXRf
Y2xlYXJfdm9sdW1lX2RpcnR5KHNiKTsKKworCXJldHVybiAwOworfQorCiBzdGF0aWMgaW50IGV4
ZmF0X3Nob3dfb3B0aW9ucyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCBkZW50cnkgKnJvb3Qp
CiB7CiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IHJvb3QtPmRfc2I7Ci0tIAoyLjI1LjE=
