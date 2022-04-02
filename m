Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A896F4EFE47
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 05:48:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239405AbiDBDu3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 23:50:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbiDBDu2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:50:28 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576FB1760C2;
        Fri,  1 Apr 2022 20:48:37 -0700 (PDT)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2323m67j003850;
        Sat, 2 Apr 2022 03:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=bfT8xGYAfmzrEBS6/SJw9NkZ2s54zRYqd5FURSrLwJ0=;
 b=WMrRGepIassOF3+ISAdPu6XhEj3Q6SPUmKkKM/nGMAT7poxcwb0V1uIu+dzNhiWBB4Hx
 vZeF9t60gXINAQoxYZ+GcG2yVUQuimLVtw5A9cTvMjCN2ijFVdJkuR3RSWhvw23VE0g3
 06SyfFN7/kNcETmmZleheD+m7ZCd7RWiHaoI79O3JxUZyq0Yaf5aSWvM0kVkGlMi4sJQ
 s/5uW9GJJC+IpdWdeYqUB3UoYRYcb7kfGx4D8S0rR3PN7RI3rGQ/9/nM06vGishPz2m3
 x5ADhh9F5qfbpf+AN5oKasLd3bi/bseYcIJOMgsxXwBtd+4iItxMCD//Gt+iU6a/Qhf6 8g== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2047.outbound.protection.outlook.com [104.47.26.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f6evqg00j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Apr 2022 03:48:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jmCsJkKWIjecXfwyNoqGI6dEjo8gzd1sxpTSutj+3CALjuMXy9MBVJzfM5o52eB4dwDMogXSkmEgEF39G8pgREvo8buHP2R3Rtp/EY3e/adaS6qxzH3VmbEHBuaMYuQErisVdcpFPJDNnXCGwaX2ixOCmYGoStJcMAvQ5ChmbgJxByjFboAqMu0HLqqBKY37hlosrTcQZI/cP4aQFTsqGlDnbyel0bp5Z7aNMGcNhNKC5eEuKFsxEVmPEunUvo4VjeCOkly7f7KMiWFcSnO1a3W7oYk72wEIcMZDZzgtwtFALrXi3H7AWOghJvw2zGVfUbLrs0RFNVZuHzuLHYOLWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bfT8xGYAfmzrEBS6/SJw9NkZ2s54zRYqd5FURSrLwJ0=;
 b=VKQLs4qcQysZL7bNBbl+/uAHzdkXlwTvbouuXcgMGUpEylpnNOiF1Ig4x53fsYKrDF1yS9NRrqZLwpScyd0Smsmvivl3MWEW/AOoXv5FP8jn4OLvwYrO/udvgGl0D4E29MZhVeDvhSvC7KuVAt0VSxWrHVVW+/YUuiMdU3NKlWCDNEsalDF68fEM6SKVDHyJXcq8qELsBGoOe7ZSpu8niLIZkpm27cR7D1bPGDbEwQLDLL4X3FOT6vADg/vd4Fdzb1+xSJ4NZ+k+fH/mbKhHtWcBLUox2GaQLeQi+xlGNMz9qyVLcob2X9XW9eNEV1IiTBPkd+vwYB4HDrkMjFzSNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SL2PR04MB3353.apcprd04.prod.outlook.com (2603:1096:100:3f::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.29; Sat, 2 Apr
 2022 03:45:59 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 03:45:59 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Sungjong Seo <sj1557.seo@samsung.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Daniel.Palmer@sony.com" <Daniel.Palmer@sony.com>
Subject: RE: [PATCH 2/2] exfat: remove exfat_update_parent_info()
Thread-Topic: [PATCH 2/2] exfat: remove exfat_update_parent_info()
Thread-Index: AdhAK+2AhxgEsqrvQY2S5lzzjVrKNQFnDCdoAB68rTA=
Date:   Sat, 2 Apr 2022 03:45:59 +0000
Message-ID: <HK2PR04MB38917E7782D96B44D0A19FA381E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <CGME20220325094234epcas1p28605e75eef8d46f614ff11f98e5a6ef8@epcas1p2.samsung.com>
 <HK2PR04MB38911DEEC1C24C06E4C272D5811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <818b01d845b4$07f97b50$17ec71f0$@samsung.com>
 <CAKYAXd8z3LE+wnQbyzwohOvy3zXwC6q50gZ8rW=ytwMae_4iOw@mail.gmail.com>
In-Reply-To: <CAKYAXd8z3LE+wnQbyzwohOvy3zXwC6q50gZ8rW=ytwMae_4iOw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4d1d1d71-0162-4061-57fd-08da145b4d02
x-ms-traffictypediagnostic: SL2PR04MB3353:EE_
x-microsoft-antispam-prvs: <SL2PR04MB3353EA3BC4F33D7B92B5999081E39@SL2PR04MB3353.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: VYsCHKOskLr0KWzwcyuga/T5a0wzlhyb9pMCpeJjzOV07aNhPU3MdA0xQ8Q6WBu62WMUygoF/s0/E4bXnFPdAbVDPm4ZrSXxr0WQRQwlNrhbDp/sase0IBkFeGfe1l7/INVrDZvrwFa2u2gZUm8fy3NnGX3J4aTWDiCrbfgZebD0IN/NBPbLw4kZ5nfdaE9cFMGKqqHpNdVKA2troWt87QzcR6nJ9SoCq22nq2NvBxOaREwORDbt4zpG36EVcA+672E8LLjJXlHIZ2O3dH6wo3ROmxMSTY/WM1Vb62GzX4WY6k56SQkiB9/uHghuO94DcqYq5A8W05mjIl6gGxGiJ4DkwIXQZHYYq2k09AcOw+BLWD1av2Bi0YCoicTVHHNMgoiG0GuFDUm9PIA/y2v0HrBPzUHvWqiaXjPUG3HLv3uISOeRoSRQm5VZpjxxl1w2kpjR8R/SeeMwlojS6aML1O3M3oHBokfrbdhELEx71gcgN3m4drK63jgqJfYgq5kZQk2eEriIXlZbf1SYTCZIwaSmEVRzVIWAz5fojW/o8KpXYPHfMvJ5oyeiJRlgBjEfHA2vuuXr6S9Zv6a+nfkyiY2BdAc/NiHrF83eWhqLOZaU9OY6NFiLAX2/zhB7zd3zjtEocEKKuwYQ0FEuUuFzR4RdyBktmK6wHZL0kk5oMAEw28Aq4/HlvrO2h5D4qeuwPOh23PKICJEU2zmJYuG7/w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(33656002)(9686003)(7696005)(6506007)(26005)(107886003)(186003)(2906002)(82960400001)(38100700002)(122000001)(86362001)(38070700005)(83380400001)(55016003)(5660300002)(316002)(66946007)(4744005)(66476007)(66446008)(66556008)(76116006)(64756008)(71200400001)(4326008)(508600001)(54906003)(52536014)(8676002)(8936002)(6916009);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dStFUE9EazF3OVJKZ2k3b0phZ21IV2k1ajVUbFh0Y2Ura0xaZm0wVXlhR2hq?=
 =?utf-8?B?cXMvUVdtRXhhZUxtTHc4Z1FjQVNhclQwdXJLM2FxVXhLT0VWUkFUUnljY1FQ?=
 =?utf-8?B?eFZIY1VFY1ZkdEx0SFkwS3p4S0FCU1ZuNjF5NU9NNnBLM0lackFCbjFQN1ly?=
 =?utf-8?B?UDh5YVpnSGMvUTkvbFhIb2FXbFF6YXhCNmVPT2VTN2x3VjFhZk9PUFU0Vi96?=
 =?utf-8?B?TSs1MkVURXMwenBYeEpZdWNnMUp1a012aWxEZWRjanIrLzhTQ1A3eXdYVC9Y?=
 =?utf-8?B?VlV2T0pZbWt4TjYyOXJ6WUZ4MHhoZlZ6RTdKT2Njb3dnUzY0c3ZaMG5pM3JX?=
 =?utf-8?B?ZGZ4M1Z1clpZRFlPMEEwV0FvVW1vU0kzejRqNkd3SmNSdDE4QWlZL2pOSmZw?=
 =?utf-8?B?YlVTM1VZVlJmbEhVOTJwT1FWdHZaWlJXWnNTb2lnV3I0a2lYTUtGdVBIN09i?=
 =?utf-8?B?QzYxd1YxZnIwWTM3S1BsdVV2WHR0QUdnanZjMnZSTktMNm1abXFMV0VqaUVL?=
 =?utf-8?B?OU5uUTF1aHl2SUNnVEZRYTk1V2ZSUmJTNjdQMUZtZjBiMU9YOTdKVkc2NW9P?=
 =?utf-8?B?YTJhTjQwSDlGd2VSM2g3QmxzbUswR0FZNjJJRnVwUUtKdGhpTk9tTVJvUkRL?=
 =?utf-8?B?V2FGNFFqSWpmSGRVYUR0bWVqMzk4Z3FmTlphbmlGTTdoZy84WG9aRVFhNkow?=
 =?utf-8?B?NU1lcGRKVUIxbE1meCttUjlHK2V0R0xRUzdGS1lwMy8yTlZGckkrL2J0K3c3?=
 =?utf-8?B?SGdEL0x5R09PZnBHdFIvR0M4WjVJTGJ4S2tROHZCR2s1eGZWbUtLb3NTUXZK?=
 =?utf-8?B?SWFjZkhzdDFZMEZKSlUza0ZNMkZiTkF1SGhQRTBxTUpDSjB3NU1Dd2R2NVdE?=
 =?utf-8?B?aWVuNDJsbE1YRityMlMxb3JTVThlREM0SnNoaWZrbDBNYndiSU1uMCtJVnJ3?=
 =?utf-8?B?NDF5dEFlVlVPb0ZoTVJzUC9WT1A4TGJiUCs3RjJpbFhhZmdBS3dyaVNsRFlJ?=
 =?utf-8?B?RHR3akQwN1dkQlRBb2szQ0FaYTJIT3FiTEZHcFpPS2VxZUY0OFlLMnFLRFVh?=
 =?utf-8?B?M1kzaCtZQWhodWJDWTBvTG9sTHRqKzc2YzVuTVZQdHVKZmVWUy9zdVZlTzc5?=
 =?utf-8?B?YWFiRDN1VjlFdVNJSzNLdlJjL2h6YkFxZFMwLy83VkVETjNRSkJUOGxPNlN1?=
 =?utf-8?B?YW00N2NBTXh6dk01NlY2bVZrd3Q0cFlFdFlWVXZMaUhuQkFvM2dTQVpYQXZP?=
 =?utf-8?B?UUpRZmlDNnpZR3crVEpuNVlzM3plZ2RTc0dPS1phejd3aEh5cDJZTWwxSTlu?=
 =?utf-8?B?bWFvYlVYblh2VDhPYTU5b0I1VlRpY0lSWkJXZDI0MFdjT2tPdnhyem1sSk1P?=
 =?utf-8?B?cE9NdmdxeTRZTWZGcllPeER2K1drajd0bTlsNVJYQ0tsdlBnUnc5bkZkTzF5?=
 =?utf-8?B?TS9aVHYwT0NURnBzWFB1MmZEMG5IRWlwN29WRGFTR2t3S0QxQW1OM01pOEtz?=
 =?utf-8?B?V1pHTjFYS3VIcktJMTBZRFJrUXoxZnA2R1BRQ1FpcE51dUhYN2pnUE1CNktE?=
 =?utf-8?B?Rzg0T1lwY0V5UWdCQTV0NStqUTkrT2NVV0gwQVR2TmM4dlU1K3psTWYxQ0NG?=
 =?utf-8?B?aFlOaHVxSHIvVC9jNTJWTFFkc3A2THFpU0ZVWGs2dXB4RS9lNkZwL2R1OThB?=
 =?utf-8?B?YXBOU3duNldEV1d4N3k1SmNncDB6MEdaUGtyMkgyVUZ5WUNsMkZINEVUUjVL?=
 =?utf-8?B?WVRHT0hoaXVHSDlhRFJhZ0hGazNKMHpZZ1FFK01hUHJSdDIwWVFCTEh5ZUEw?=
 =?utf-8?B?TlFkSlJ5MVFkNDA3MHExSFJsR1JnT0NDMTN4RmtwSlcxZXUxdWttK1NTc0cz?=
 =?utf-8?B?L21hV0VxWk5BZmREL2R1NmlvMEZadkJZby9TYU51MW5nUW5VMmE3NlpzQ29r?=
 =?utf-8?B?M0dUTGxpSEpQTEZzZHRnL0NOb25jWFdLdTA3S1RRcW5kc3Raa1MyMWxlWllx?=
 =?utf-8?B?NGhuV1pUZVZjVzR3aUM1NlR0YVhZZFBmTSt3cUYwVkkycHI4Y21SdG5DdWlD?=
 =?utf-8?B?V25icGs2ekxYdC84MnFoR0poZ1p4ZGdMeHpWMGlmWDVqcTZsaXFLNjhNbk1t?=
 =?utf-8?B?VlJMQnZ5Yk9ISElVMlpzSEx6YmFZOFhteUErY2c2RVpoWE9aWCtEWnFWNits?=
 =?utf-8?B?STJKdGk4Q0RrOUJTVVM1K2hJNXppMlE0b3BTSFdXMXZVWFovdkhzc1Rmb0J4?=
 =?utf-8?B?WTNaUzdMaUwvOXZRNlVQRkxxRzQwQmtIQk56MlltVVNEMWQrQ2dNTVJVazNu?=
 =?utf-8?B?TVZWbFUyVE1KZnAxUmZYT1JtbnFtQ3NhSDdITHhDSTlxZjNvaCtNdz09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d1d1d71-0162-4061-57fd-08da145b4d02
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 03:45:59.1675
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kVdzBHgEarVqe6oMEAS5RPNs3D5QvNR0lrcaekkGopAnjIxDS5uyogsXCzVg7GKMX06ZswvCG+jXKVI/xV2wYg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SL2PR04MB3353
X-Proofpoint-ORIG-GUID: 6LUY7JzvQtic6nPeKyAnADyol40J0Jus
X-Proofpoint-GUID: 6LUY7JzvQtic6nPeKyAnADyol40J0Jus
X-Sony-Outbound-GUID: 6LUY7JzvQtic6nPeKyAnADyol40J0Jus
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-02_01,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 spamscore=0
 mlxlogscore=989 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204020021
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

RGVhciBOYW1qYWUsDQoNCj4gSSBkb24ndCB0aGluayB0aGVyZSdzIGFueSByZWFzb24gdG8gc3Bs
aXQgdGhpcyBwYXRjaCBmcm9tIHBhdGNoIDEvMi4NCj4gQW55IHRob3VnaHQgdG8gY29tYmluZSB0
aGVtIHRvIHRoZSBvbmUgPw0KDQpUaGUgcHVycG9zZSBvZiBzcGxpdHRpbmcgdGhpcyBwYXRjaCBm
cm9tIHBhdGNoIDEvMiBpcyB0byBoaWdobGlnaHQgdGhlIGZpeCBwb2ludCBmb3IgZWFzaWVyIHJl
dmlldy4NCklmIHlvdSB0aGluayBpdCBpcyBub3QgbmVjZXNzYXJ5LCBpdCBpcyBPSyB0byBzcXVh
c2ggdGhlbSB0byBvbmUuDQoNCg0KQmVzdCBSZWdhcmRzLA0KWXVlemhhbmcgTW8NCg==
