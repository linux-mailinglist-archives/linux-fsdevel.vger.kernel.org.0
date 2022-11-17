Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D280962D2DE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Nov 2022 06:46:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234701AbiKQFqI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Nov 2022 00:46:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiKQFqH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Nov 2022 00:46:07 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA1E5F856;
        Wed, 16 Nov 2022 21:46:06 -0800 (PST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AH4PVSW014028;
        Thu, 17 Nov 2022 05:45:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=srIk6sYCvJr51MGs4UWdrXWk83cqh3j6SoHwB8Vy6V8=;
 b=O1VRACxnBVnxBJ+yxopG4OGgNF85cCaxqjB/ivRawSFLPbbSOpk35G7Rm9mJsCw4srTC
 QKAO/9Dyv6wHmmrm6motRb3RlJHPycHY5ndMzCuDvnKtP44rzi98ZxTleigociUa7ZwW
 frJ/cilrTH+G8kySKXli0jd0wJkNEIr5T1tsxeq4xqtUR+Y6q+cAkYhEoRLFFg0QdXL4
 SzneDj44yF4d/8rEE2U9ARBnkadnp4sHo0REcmEbrdxOUqwYPVVn4bh3FK7WnlZuFeTL
 NVcbJeekQxM7f2GF0dxVYeYr/SVvTpmsTJahq7VZ2rS/SsB5FFUcQkqDup2GZZK+XgbX EA== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2109.outbound.protection.outlook.com [104.47.26.109])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kvvy510eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Nov 2022 05:45:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BUvP81DlVw5UwU7QcSMeplFGsYWJ+RMSuufEPhiDEaCP42rledj+HhtOUQ+qGVqL9s8cxKzrzORz+DCgYg7jiXEAU+eB/olEAh4tdLvm5u7LSKTY9d3ubEPOD/hVT5o3wrmNQBrfw5IF9pJ8wyBrEGgnpYRsu38SivIwKkB68AxcNCXWiO7mR1XhGoLhgvKUDznfIuid+VfhTXFl2E3DOb0gZbDLVoux5jlHQrnI4al9PM0yjEL3CjhYQ3xfck2LLii2U02/68QerJKVh6RulLAdDqtm090wFyobUAoU5g2OWFEYyuSLrJlpue4+dKo9q+eDMGDMwh9FqrA5x9nOCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=srIk6sYCvJr51MGs4UWdrXWk83cqh3j6SoHwB8Vy6V8=;
 b=PJVLK/plTU0B9oBRpi4zKkBAL1CuEbQXxCCDL5LjUg5GxiEloxSpeSWDNZWt8cWAA1L85kS+POWnN26QY/txLJ6pd/vrypMShVK8jQHN+dQyMZWtL4CQCq32TGB72lbovvBCODH+rM8G3XFuDViXSTUAmIZKGDcTrYZ9AmT5y23b+CemFfLTRLHsU/DQ1WLhSoREVNOlI/JtACMfkL7MPbkJZ6TRKxG2A60Ib2qpMtgByfeK5sil/9O1kSLdOEJ0vq1lRmD527zD8sKew4sAziRZV+3izBo7WOUjAQZIj1xeBEFKzSCGGp+RIUs+iaMrj3IpO0hviCOAWW/187c3kg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4129.apcprd04.prod.outlook.com (2603:1096:820:20::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5834.7; Thu, 17 Nov
 2022 05:45:38 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%7]) with mapi id 15.20.5834.007; Thu, 17 Nov 2022
 05:45:38 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>
CC:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 0/5] exfat: move exfat_entry_set_cache from heap to stack
Thread-Topic: [PATCH v1 0/5] exfat: move exfat_entry_set_cache from heap to
 stack
Thread-Index: Adj6RaOTZm9cQwjUQYeSQhKvy/KL/w==
Date:   Thu, 17 Nov 2022 05:45:38 +0000
Message-ID: <PUZPR04MB63163BEABDCE76AFD33442FF81069@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4129:EE_
x-ms-office365-filtering-correlation-id: 1acf6619-6008-4d6f-391a-08dac85ef48b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y7Fl4VeM+JyXGyzjbD4mxR4VHVXrDCADLgzvdG6pStTKiF69zwakuZoE5Ngf2oCVSDxPdA43Uyi0q1F/4cD5VRfPMw1uUgBO01MCawuGNxbQX9h38LdbJWBTIybyK+yam7YUOcndClVK8OCIow1U81z5bzOEvgxp1LjT9e/holkX485iJWqxTkhvAUovU3qP1XYUaieL1VolAZcgTa01m+pNAeK9d53LjSjX51wyyU3Ts/eawhDAFvs+D/s0rrpUouu+EzdvGKk+WwhAKuJ99Neinj1ChatRhl3ZfVSqOsAl4JR3DBoFSkYq7XsNsQzuh/yp9nQgwcDOCTHkM9W5vtOn4QXD66nCa7hCf0qrDjJqcyd1zNvAyeIXph7JlzI9Kj0SrhNX/BFs5aWvHzGTaiOk4sXVK8OzjMP8RnyZ5Zmy2yh38Bl+iE6gmAJO4+qx8TP5KApH6khJg7qjDN2VsdivkLyZPf5XhfWXsdGdo+jybv7YST9XU/y3x583Tlv0RvqKOFDEbj5Qfm8QZY+6hCFbCXhI0LlpPtde83QfgCz4gIuvQkZY+/b1zf/HohvVA/6aGTHJzEhn2kXvhjb7fMM+R7hgjIAoRIVvjGEWoVzrisMGXHuCjE/qB2Ci7P4uPLjP/ze/RyapRONFsywcOba3B3u1xbQsPqewOcfNCmoPnJ4GT2P80l/TO685Y7TJYTjVAj8gzfo1rydiZ+Gjfg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(136003)(346002)(376002)(396003)(39860400002)(366004)(451199015)(5660300002)(38070700005)(4744005)(2906002)(4326008)(38100700002)(41300700001)(55016003)(82960400001)(107886003)(83380400001)(26005)(66556008)(7696005)(110136005)(9686003)(8936002)(66946007)(6506007)(86362001)(66476007)(76116006)(64756008)(66446008)(122000001)(316002)(54906003)(186003)(8676002)(52536014)(33656002)(478600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TW1pREQzMDZGVVBxVGJFT2h2bkRZUUJta1FpN3ZkOG1tMWNsUG5zalRiUzFh?=
 =?utf-8?B?ZHc0bm1QVlBTaS9mVThYa0ZrNm1qV1puenA2SmFzVW5sZ0FDNCtoMCtEQ2Fk?=
 =?utf-8?B?NWpQdkJjUllRUnkxMEZmc3R3NlRic3hIYnFmamN6bHpaVUI4OUVLejI0VEFM?=
 =?utf-8?B?Rm9XcElFWEJ4Y1ZSVG4xVUp3dmJiTDJxQjhiQmVNT25tUDJoc3U3NHMvaC94?=
 =?utf-8?B?YU5PODJvUGRyZHFDZ0pBZ2xhcGplbVN0Q0htWDk1dkxQOGVnVVQvcTlzOEp5?=
 =?utf-8?B?dkhtNTVGelFMakFNVkpFRGQ2aGZJSUtJUndOdmozMlltbDN6TzNJZTRoQXRV?=
 =?utf-8?B?SjEvNE9jYWlIa1lGRG5SemU5K0JvTTJOVVNTUkFVQXZVcXduRmF6dkh2enZ2?=
 =?utf-8?B?cStQZWU4SFEybFB3Ymt3UEpGVW1ERnFLVVdJZ0psczI3MEpPOWdlQ2w0djRz?=
 =?utf-8?B?YUxHelNJaTlDM1ZLdVlKU3NxUlNqdW84Vm8vSmN1cUR5M3E4emJEa25RTUxm?=
 =?utf-8?B?TnE5c0k0UXpjRG1TejJiZ3NndmhvSnRVTUtKTFdRMEg2N0M2VkRuVGw2ZmpP?=
 =?utf-8?B?ZGt0cVlLQWxrNzVvRHN1QUJpYUVVRGtuZzMyT3RXa0ladnVBcTE2Y25lMU1I?=
 =?utf-8?B?SGc2YjRDeEFPNEZ0ckNsSmMvSGlxMUt5NGVuMFJvTjNLMzVFOE5wVWNkdEtL?=
 =?utf-8?B?dzNxb1VsUTJQeTl5ckVNM0hKaTBRMWx3QmpoSnZnckpiYktXZXNKTURYOGpI?=
 =?utf-8?B?QmxXTUFENWpZRHVlZzRhdm1jNklWZGF3SFd5YUIvcGpFakhJWG9uQ0c4MFZ0?=
 =?utf-8?B?QlErQ1hPOWRnZ3E0SlRsMHFyRkM4U0h1bmJQdXpVYWo5VlNvUlRqL2NlaFVW?=
 =?utf-8?B?RC9vSWlMV09taEp2WXprL2ZtUFJQcTFNY3ljeUYzejlCc29MM2NBVTh2RW16?=
 =?utf-8?B?dzM0MlFBZHNDSjJ2bUVlTkFmYi93Z1ovOEl5endCUFJzTWZyUFJqS2R5Y296?=
 =?utf-8?B?THFpK2ZwK3NtTVJZRGExdkFyQWJwUmpYM3hTbVlXWnFEbEJuRk1ORkJEY3l4?=
 =?utf-8?B?Wm9NcURxUFF3MDB2MUNyU1FheG13cHlMNllJR2RxbEp6L0FVWjRiNHNGa2xF?=
 =?utf-8?B?MG1IbWNsQTRucGllaU4yUDAzRDN3c0lrNjBBVDdNeXg4M2E3Q0R5ZUJyQnVQ?=
 =?utf-8?B?YURUM0cwWSttVlMyOE04cW1OTUk2cy8xaUQ4blZnVkVEMGZwajg3UnoxWWJQ?=
 =?utf-8?B?eHJlVGxocWFHUnIxNk5YSHplaVVxT3hQUXluczdGN1hvNGFoZmFiS0l0VEF2?=
 =?utf-8?B?aDdSSkcxVEV0cGlJcmNZcEc3eDBsalA4UDRPWDN4aEJ0amJxUE0vZU1CYktv?=
 =?utf-8?B?cGo5MzFWY213NVliVkFrQjJzUXlTWDhvTjk2NW1DNDRINmM3dXVjYU5WdjFa?=
 =?utf-8?B?MmYySFFLWko4MGhncngrQUNHOVNLZXBjVE90bk5XZVB2V3EwSFNrQisyY0Ez?=
 =?utf-8?B?M3BaT2E1d1d6UjRMcUJPck5HMkNKUExBYW9KWWJ3OU1zd1g5T3FnRFpkRkI0?=
 =?utf-8?B?WWUwWndqS2dyS3lkVUNoUHpFbUdPVkVST1NscHVhR3FsOHU4djdBUUZGY3Ni?=
 =?utf-8?B?akprbGhrSDlJRW1QQmNiTkFCbFNuZ2QwWCt0cTNva0x1NUhCVTREejcwNWJi?=
 =?utf-8?B?eXU0U0szUHdjTUdQeE5qUkM5a2pCZDJGSk01NzJMUnlMSjZDcXlvaDlVVTUw?=
 =?utf-8?B?VDJGVEtlREZ5VWVoYVFQQ20zTVRPeWhRVUNPNGFXbHlzZ3orMDBkaUJUVWdw?=
 =?utf-8?B?UEYxMzJJWUlrVUVFb2F2c0RvNFV5VzNTOW02YUVGU1J5Ynk3NkF0a0hOYzFS?=
 =?utf-8?B?dFFDeUNiR0o1WVdTY1VPSnlSaVNzaEhYY0I2YXEwWm1QZWdIZHRMaHQ1d2lm?=
 =?utf-8?B?emdUK3VnOXdQYjhMTFFBTk90Y051dWpRd2dJcG0wYXgyUHFhQVFTcjQzZXh3?=
 =?utf-8?B?SklnczJQNFJTdjlidmdvSHdJZnM2Wko4Um8xM09JK05aN2xXQjZBWVJaYTlM?=
 =?utf-8?B?YTlCLytuWDgvS1JHSnN0TlRpbW5tdUhQTUw2UXNxdVJsRk50cDFQV3orT0Vv?=
 =?utf-8?Q?nsskovR5PQa8aKVsfPbwzsLwE?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: mNcQJ6L/vNloleTnLrGpwxS7YIQGCVbXo3j2gpkadfvf6ZMPS28ET1IjZaoU4utf9MNAAJGdglVFJ23RbGwDOD+z5k+oVUgxunjorMLMZ0WEg/Fl3xJAYJ52YGwTYTYIpxVfM5SsfyvQmPCq5YHW0AzTaZJ4moevBXzrmSwvTzxgR4HbM0U/cVPtS+nH9fLyqsEDvXEqOk0fXZuTpYKEEoFMigH0nzPTsy5QG4yrpFCYTm03sHsMbtjRGVzEIWCUGLKqMxKjLXMmG+rvl+Xf4kump27pHLc7SNR1QMjyeCRgzSY9NuE6Sr4XwtWPy3lh9LkKzPGVwMkbmBICx1jMiALF6KauXfMKIF6VVzUzfxNNhWxrcdl3+7IucZHkxSwIZQ0WSBKD001DIcz4EzypGL7GvaXkrMkS3Gq8p/YNGLmMh/uQjjj/TF0tXG7XxC5JP98XXQJeibOzfl5+jDuT0EDEMpE69pj6gie2bJOPmCGquEVxOKG9Cw3tD3jkJX/vogmkfWC8CbKJLspUgIkBTHaKhewB/KAZRUmgpLQblFNMhOvIav/IHFsSBy70YAjWojfmAwp39Fm1/MZcdoRuTKGPTdKa2v93U4NVHLfyBYBnPpBL9UBZsMw5iQK3XumXPpb29mCXIoRS3QZAbhKW812t+dQYhyAblgucFIPUjtG/Gasig72fhyPKVNUI4K4lf5yAMGh8FPfccUPHa7wPi3+lj4/W/lxPFVh6dBxgnDxpZoq3jq90/n52AIV+lO9z/3QYRTUEsPl8e8cMra9wfn+wfiE7bpd4v76uiZ/Wy766CSXuDZSdL7vapSlyChNhbWTwD3jBpL3CaYE4cZn/quj8uCfNkIC1jft7Y7BkM2RrEqlUOzKCBCBxpl9+82OC
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1acf6619-6008-4d6f-391a-08dac85ef48b
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Nov 2022 05:45:38.0554
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dTys7UbUdb6OOzQeIwfsAZ4CoHLbB1J1RE3o/W3T9SbfdjuyAOsGMsKVtKST9enqL9fuNVMKAoQoe+Cl9n+m/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4129
X-Proofpoint-GUID: 7iqPz7CWZbpa3ow8fZHNpTwfRAGaGvvH
X-Proofpoint-ORIG-GUID: 7iqPz7CWZbpa3ow8fZHNpTwfRAGaGvvH
X-Sony-Outbound-GUID: 7iqPz7CWZbpa3ow8fZHNpTwfRAGaGvvH
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

VGhpcyBwYXRjaHNldCByZWR1Y2VzIHRoZSBzaXplIG9mIGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBh
bmQgbW92ZXMNCml0IGZyb20gaGVhcCB0byBzdGFjay4NCg0KWXVlemhhbmcgTW8gKDUpOg0KICBl
eGZhdDogcmVkdWNlIHRoZSBzaXplIG9mIGV4ZmF0X2VudHJ5X3NldF9jYWNoZQ0KICBleGZhdDog
c3VwcG9ydCBkeW5hbWljIGFsbG9jYXRlIGJoIGZvciBleGZhdF9lbnRyeV9zZXRfY2FjaGUNCiAg
ZXhmYXQ6IG1vdmUgZXhmYXRfZW50cnlfc2V0X2NhY2hlIGZyb20gaGVhcCB0byBzdGFjaw0KICBl
eGZhdDogcmVuYW1lIGV4ZmF0X2ZyZWVfZGVudHJ5X3NldCgpIHRvIGV4ZmF0X3B1dF9kZW50cnlf
c2V0KCkNCiAgZXhmYXQ6IHJlcGxhY2UgbWFnaWMgbnVtYmVycyB3aXRoIE1hY3Jvcw0KDQogZnMv
ZXhmYXQvZGlyLmMgICAgICB8IDY4ICsrKysrKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLS0t
LS0tLS0tLS0tLQ0KIGZzL2V4ZmF0L2V4ZmF0X2ZzLmggfCAzNiArKysrKysrKysrKysrKysrKyst
LS0tLS0NCiBmcy9leGZhdC9pbm9kZS5jICAgIHwgMTMgKysrKy0tLS0tDQogZnMvZXhmYXQvbmFt
ZWkuYyAgICB8IDExICsrKystLS0tDQogNCBmaWxlcyBjaGFuZ2VkLCA3OCBpbnNlcnRpb25zKCsp
LCA1MCBkZWxldGlvbnMoLSkNCg==
