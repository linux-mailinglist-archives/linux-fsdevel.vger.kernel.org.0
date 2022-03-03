Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E65E4CB776
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Mar 2022 08:08:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiCCHJV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Mar 2022 02:09:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230107AbiCCHJS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Mar 2022 02:09:18 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FCE2164D05;
        Wed,  2 Mar 2022 23:08:30 -0800 (PST)
Received: from pps.filterd (m0209320.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2234SeFa026991;
        Thu, 3 Mar 2022 07:08:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=OkSKmCjRPPFlIE7PRy/+4PnUD+KmLrk5cYPSz/wJUug=;
 b=JDfs72oBgYrEr8NM5xmrfkQx8ax9h9cvo7LwlVoiQnwqXE9Qx+U1aenY6WwOPG6EkGh4
 KeddXOwGCkKdh7v2fg17kzPZ/DCDejABNuOzrU24xdWvwMQuMO92LfNS+7Rpj/5N1/ej
 t/2WxbahWwNCiCkLCd2y97bHA7T1Ayogn5wPOBO4G4HH5rh2hN5IIfnwcvGMVzwoah1b
 0UoVoNFQJ6FObSEtkacGZrafuGBLen26pedw8TG0UzGPygCnoZ6gC7wPfffGpTvXI5pe
 8k8VKc95ouoSjSGyRpC9GDmGvKqd1A/CLNdnqiWNVb9rydzYbDA1QOITGN3shWcY20gR OQ== 
Received: from apc01-hk2-obe.outbound.protection.outlook.com (mail-hk2apc01lp2051.outbound.protection.outlook.com [104.47.124.51])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3efefwvt5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 07:08:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YHP8meeWxUfaxvTJ7xPBlmPKq0puJq9pBvkKPBYHmKwgCa4x74haMaULlp0AMS9FaDrfvHUvSpmwLHj2KCaxkhB0HdwGzNeq2YxxOhC1FfVH5w4WG31546yIRs03pw1XRmk/YKh3vMANWIPneSQrusbI9rFRjH3OAZMXFs/0ie9Gc2O9WweeM4lNRS0coSwawusi+eoYupk+7IO0dU7emG1j0frdeLqZKvpCr+0xOREI8YTCUPKmArl8fWFwLI66k/tQafq82izVSJRXzNojKvOS5Uu7NxAmk/t90cQtiQJFSUacn+JB8V0gop+wb1MOuqeGsID+gbRt7G5v4H9+cA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OkSKmCjRPPFlIE7PRy/+4PnUD+KmLrk5cYPSz/wJUug=;
 b=iQDAhyenRlv0HSYoKZ8oL0rBp0PK+8v2RAKXgy9Ywr6a4oVel5iZxq1Zz9RQozWGxOOJOUPyNAPEh4Fb9IUQ6fV49BLA9bKtq1VeDSOD2Er3Xj+SO34FUsOw+irEL2z7GbLvKdM2vxgXWfwb8HESWKyGty6tYUA7ejvnW5w9HbgMBxSLjZHHGGBUdk574xf9R4Bz5SplYEV6v3/yqbWDWjtZJJFadcIs0XqFGPZ1c08/ETSGthw9tUmB4zCkl7LMJxuR4fLQszub4sVThrRvt+vXTtAPmW/wf0a8GHZ2y20IomXY76wyYx4Yn8kJle/tWMDg5Df5AggyD+gomB0x8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by PS1PR04MB2935.apcprd04.prod.outlook.com (2603:1096:803:4b::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Thu, 3 Mar
 2022 07:08:05 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::98b0:9ef4:57f2:c045]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::98b0:9ef4:57f2:c045%4]) with mapi id 15.20.5017.028; Thu, 3 Mar 2022
 07:08:04 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
Subject: RE: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Topic: [PATCH] exfat: do not clear VolumeDirty in writeback
Thread-Index: AQHYHKozeVmted1T5UKvjQCq+AaGCayoqY+AgAA/KGCAAw0zD4ABYXsA
Date:   Thu, 3 Mar 2022 07:08:04 +0000
Message-ID: <HK2PR04MB38913077A55A6E7124A41A4281049@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914869B1FEE326CFE11779812D9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB5353E089F4843C6CE6A0BA1E90019@TYAPR01MB5353.jpnprd01.prod.outlook.com>
 <HK2PR04MB3891B4F1C2BC707582E81C0C81019@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <TYAPR01MB53531DB8B19324F7D60EE9AA90039@TYAPR01MB5353.jpnprd01.prod.outlook.com>
In-Reply-To: <TYAPR01MB53531DB8B19324F7D60EE9AA90039@TYAPR01MB5353.jpnprd01.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 73038022-96f1-4ba0-978f-08d9fce48fd9
x-ms-traffictypediagnostic: PS1PR04MB2935:EE_
x-microsoft-antispam-prvs: <PS1PR04MB2935D0ECEC36CFE5A9293FA781049@PS1PR04MB2935.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: bZsXfy3W+jCT5i2Cr+MbYcCwvesguNFjYSHhszlFg3wUOwAHjPA94IvGReYd9mOPXXzrisyrBU9FEbo8yb9u9tkijMIByQMf505+RdfjLwWcUwdR/fcD7N1+xOtxg5brw1/ElCzYvkfRoEZj2zahYKe96pLRXkFCRpG/ZZ3j3JTczdHOlDgcZlGjK0dCpWblnmA1z9RuJvKhZ5wPuKHoCx35DG8KZ+qL9FsKwE8SCe6kR/SvWM0fO6GF56gwB28jpkhbBv5/IYyvUILgKBNjThENSGbzX5tatV1jbKT39z4VrPtxlUcu84RaAenoVhkIK7n8aglDuEYsLuzE76kzLqZ7rIGpg3BAiZXsbWVU6HQNjkAgEkYrDBWweWiJa4o97XaAy7soGUFE60RE+vgjV7EmOV4wKl8eMVJzDq7c/aldCJXH+st1GuUGZVukTD6uTPxvMVz4miBuzBfCQ1zzIriTouCB2gpk76aE4UU3HWbZrW5c4PNxebZq09n2esAjNkmNGQo0luMYET7WOxZ7S4h/96DDxWt1V2sp/Bt4bjBEQmNLa8M1VbOYfbZprkdYJOLBcJ8gd6SZCn+tXBFkofkIlN62lFcfS8Jhhe3gD7+kHjcr0H17OsHuV67tg+HfLmX/fWjwNNyZLv0vNE7gwR7AvTjuImdUIRnLTtrTPUexwJtH33iT++IpiRxjb0Ybx/IwruF2WRTNzqnmlq7PPQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(26005)(54906003)(7696005)(6506007)(6916009)(71200400001)(508600001)(316002)(82960400001)(122000001)(66946007)(66556008)(66476007)(76116006)(64756008)(66446008)(38100700002)(2906002)(4744005)(4326008)(186003)(55016003)(9686003)(8676002)(83380400001)(8936002)(5660300002)(38070700005)(86362001)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QXl4VXhwcDNoZ0E5TytxQUNRMUtObkhnVTRJSDFHY1F4ejBMS2t2TzR3eHlj?=
 =?utf-8?B?SkM1M3hjUnhTR0tiYTRseldwS3A1NHFsNFd1QWJZYjF1SnhzSS95dkIwcFVZ?=
 =?utf-8?B?QTZzSXNwRnFtd1NBazF2aEZhNGErZDVqVVRYZGJhQStCZHNQNHBPSUNrTzZv?=
 =?utf-8?B?ZEJDTmpqSG11K0ZDUUJIMU9yKzhIQU9YVTIwTGhYQ3kxaWdZSlVYTXQ4Tk80?=
 =?utf-8?B?cDNnVklwWmdDbWZDOXU1RWRvMEpjeTVMdGE0R3NJWVRkZ0FRMEVWTzByNnlJ?=
 =?utf-8?B?WC9JMXJSNDlhSGhGK2pMbHVIZGtMNmtwTHN1M0VlME5oTjlTQ0lWbytyRHV4?=
 =?utf-8?B?UW9TeDE3TEs2MmU4SlR1WmQxZThIcWRmcExzL1BBVnRsWFluZHhJSFJEWitI?=
 =?utf-8?B?R0YwR1pSR3BPN0NuS2UwZTYwazk4WVQyTG0vMnV6SGhUenloSkg3bVRjR3pY?=
 =?utf-8?B?eUJnc00xM3N6WWY4L3JTNDBndzd4Vy82aXh3d1EzM3BTRkZDREtBMDIyNFAv?=
 =?utf-8?B?SFlkeXJPR3FHK1lGYkJxbnlnczBCQjNzV3ZWMUFUQ01IRWJGNSt1dDdrcDdP?=
 =?utf-8?B?dytJYWZ0U3ZiUFdGN25mSzZ1NVhIR1pqbHpaM1BQUzljMWxQVFl4bjd1M3Ar?=
 =?utf-8?B?Q1NYTk8zbGEzQ2haVCs3dU9YM0Z6VExtcmpzcFRORFQvNmYzaWNLSjF6VUlk?=
 =?utf-8?B?NGJMUDF1cEQ1aHZkKzArQVhKWWVEd005aGJmUnJEL2lORW94QmJmZ0ZhOHg0?=
 =?utf-8?B?cTg0eUlCcWhVZHA4cDNNcmtjaloyZmp0UU13MXlEcDZYQ21HNEo3UTh3aHhM?=
 =?utf-8?B?bzZTUUtlZllnNXMvUTYyQktGaC9tNnM3ek5SbTBYa3N3OWxlbkVnY25nQVcz?=
 =?utf-8?B?UU9XaXVNM29zZm83d2I0SlJXcjRrMmNYbWtkTkprM3ZOUllDb21pOUxBL1FF?=
 =?utf-8?B?UXF3MHhPRHduN2diRHl2Vm5KMFo0d2QxNE44RElaWGl3Y25JQThoeHhQWlZC?=
 =?utf-8?B?NWxrLzQzOE9xZGZ3cDUybWxvTWtTeXdKRVVYaHZUZzk0Nkg1blNZb2h5YVpj?=
 =?utf-8?B?cVd0WHlqSmJxWFNIVmovVk54ZVJ6QWpQNmlsWFgwMlA4cGtpdFhvU2dOcjZ4?=
 =?utf-8?B?U2s3ZnJOREFzcVNYQWhjdVZ6YVppTlhFQ0diRSt5TmZnNC9QNE5kYlROeEFx?=
 =?utf-8?B?VlFmWXlMMU02blJYcFZ6QUxCZncwMXE4LzZGSmFSTHgvSTBucVRhRkwxQnRo?=
 =?utf-8?B?N1NadjA1ZGJERjRWQjFEUHFJYkxoU2V3cGNFM3pVdERkWHIvN0QxMEd6T3BX?=
 =?utf-8?B?RXd2TzZramlyeVllM2RYMzNvQjB2YThTR2ZYRVJrY1ZKME9qUkJzZVdmUURN?=
 =?utf-8?B?YXY3MmZYWkpxb2RKZ2dla01mQm1VMXB0QzVGK3lJNkhRcFl4TFcyZStSQllh?=
 =?utf-8?B?WnBNUGhodkM2YnFRZkVLYzNmaHV0TGxGRkdHOXRqMk1Qdm1QeGJkSWNBRkI1?=
 =?utf-8?B?L1ZtdFNrU0dBNGdSN2Y3VzJjajY1clJ4TGRmNzUwUUQySzlLR1B0dHlXd083?=
 =?utf-8?B?VmxyNGNtOXliRWRqMDFyUFd3bVBnOGlUL2M1T1d1ZnpPU0xPNlpBSUgxa2Rz?=
 =?utf-8?B?WkxtNlh1UGpkR25ITnVxNklneGRJbFg2U2FGcFY4VVhnb0NKNktTcHNJZGE1?=
 =?utf-8?B?c3VicjYwRmxEWjRZNnVLZGJCNzZ4RVlueVlJU1BzT21LMlVPMktkbnBGZjRB?=
 =?utf-8?B?aElDNFFDMGFIMkgybE0xcDd2Y3BkcXBKc0RaY0hBVHpPSUo2UjNudkxUMXpN?=
 =?utf-8?B?bHlsT3hONEt2M2o4amtHQTlKT2FtT2pMV0NIcG9hUHJNREFIUkxUbGdjZHhw?=
 =?utf-8?B?bWlmUlNLUVlvZkhpWWliTmtFL0Fnc3Q5QVczSldycjNtdFhFVGQwYUNiQ0xO?=
 =?utf-8?B?NkpIUit1Y295MWhkOE9vSzNwNGdzdHJyYTdJc0lkL3ZaN04rbHErZVQ3SjBT?=
 =?utf-8?B?Q1dDZTFCOG9HekREZzNyS2dKTjdMT1pwTmg3eGpWbGowL1IzeWMxd29NQW9q?=
 =?utf-8?B?YXdIUzFDcHNYWm93TkFUbk5ZVmwzRTNjODV0YTk3LzJsUXhSSURhaDRFcCta?=
 =?utf-8?B?dmg0M1RvTWc3ZmxPSWhDUWhtTGNXdXNEYlNmR3BVYzlRZmx0RU83N3p6MFh1?=
 =?utf-8?Q?P3g99OeDYrdMK3yDy4ahkmo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73038022-96f1-4ba0-978f-08d9fce48fd9
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Mar 2022 07:08:04.4530
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IRbHpGPK5bGOdICiq550eV+MHe5cywkY/XuM5ISCjUUQ82X6LWa6aNQe2flf0gOYfe69phxynmO/jyT9icYuOg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PS1PR04MB2935
X-Proofpoint-GUID: 43UjLDFMP-Vbd8bq48Wk8Kq21xKC7SdW
X-Proofpoint-ORIG-GUID: 43UjLDFMP-Vbd8bq48Wk8Kq21xKC7SdW
X-Sony-Outbound-GUID: 43UjLDFMP-Vbd8bq48Wk8Kq21xKC7SdW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-03_02,2022-02-26_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 bulkscore=0 impostorscore=0
 mlxlogscore=999 phishscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030035
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SGksIEtvaGFkYS5UZXRzdWhpcm8NCg0KPiA+KFBTOiBUaGUgb3JpZ2luYWwgbG9naWMgaXMgdG8g
Y2xlYXIgVm9sdW1lRGlydHkgYWZ0ZXIgQml0TWFwLCBGQVQgYW5kIGRpcmVjdG9yeQ0KPiBlbnRy
aWVzIGFyZSB1cGRhdGVkLikNCj4gDQo+IEhvd2V2ZXIsIHRoZSB3cml0aW5nIG9yZGVyIHdhcyBu
b3QgZ3VhcmFudGVlZC4NCj4gTW9yZSBzeW5jaHJvbm91cyB3cml0ZXMgYXJlIG5lZWRlZCB0byBn
dWFyYW50ZWUgdGhlIHdyaXRlIG9yZGVyLg0KDQpJZiAiZGlyc3luYyIgb3IgInN5bmMiIGlzIGVu
YWJsZWQsIEJpdE1hcCwgRkFUIGFuZCBkaXJlY3RvcnkgZW50cmllcyBhcmUgZ3VhcmFudGVlZCB0
byBiZSB3cml0dGVuIGluIG9yZGVyLg0KVGhpcyBpcyB0aGUgcmVhc29uIHRvIGtlZXAgY2xlYXJp
bmcgVm9sdW1lRGlydHkuDQoNCg0KQmVzdCBSZWdhcmRzLA0KWXVlemhhbmcgTW8NCg==
