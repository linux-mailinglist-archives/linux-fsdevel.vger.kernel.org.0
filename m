Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1554E6CB9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 04:03:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239594AbiCYDEs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Mar 2022 23:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235171AbiCYDEr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Mar 2022 23:04:47 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03CB5DEA2;
        Thu, 24 Mar 2022 20:03:10 -0700 (PDT)
Received: from pps.filterd (m0209329.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22OMIu1N005584;
        Fri, 25 Mar 2022 03:02:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=W/BR76FJAR0Q/Axofy7KQ0iSLYspBCOn/K/AW/pAGuU=;
 b=jwDwjWjqg7tZMigZKDeBctz7W5bOjySEvO01qUWawhwGe0+D1GbJMsG9wn/7i3YIw5J7
 R/48yrdPyYuTbOwqjMekE6XPzWLJCecU/zVSXRJkuiS2PDZRG26F+dGU/PuQGgUkkO1p
 CIm8ZDlKZNN9Iz+4xWK0inbBOEv6Ocle9ncoYUXb8yttvJrBSY3pzDciHEYN5WP4hQs+
 DICLOMiQeW1zGEdm43cZex9Ekj9KzxCV+X192S/Z9j6bf5e5SEuMhgOa3RoaTgVrPyX4
 mBDQb12C/M9O/taj/LyZVYWzsecjnDwwiOUspoenSrBcEk8oYjW84S0ibefJdgg44ntQ MQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2113.outbound.protection.outlook.com [104.47.26.113])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ew5txd9eb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 03:02:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5p5GJU6r9CUJyWDHb4ksbaWeSN5olE/RpPRt+2CnhXnz00ldj4dpw63/O98RgYl/1WnKeY0iHfCTqIgKwpoBXLWFehol1swQZ+HOObXMrTniZ4bhOdgIg49oLTYwMFVhIgeTpjVToJKH8imTjExRf3f2Yq+VFpD7GPdQNLvzIfbTQn1QeN1S2VRi+sXRsx7iFr9GuhNf65hsexy2Rj/cNyqPzdMPKYujzW1QatbiARvyFVhtKwYyhCLXwVt+FpsQQLqizbchQxLPotD0qp09spnVQhKSwxaPk2GLSuWFUtU76bHbcA5oTXPlD4tFV1JGgQvbLOHpgCCVf4FxngQig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/BR76FJAR0Q/Axofy7KQ0iSLYspBCOn/K/AW/pAGuU=;
 b=LUNBMiIgFf5ht72ZJ/kfktH2VCMBAtCrM8Cmv2i/O5XqUeSyKulfKdt8yEEjzvzRdKTeHRK5KTK8Q/7/5j5zNazHaV0YbyUh8z18IAdpW7XMBSrRNrE2cPjyTE6cYBv2CxVDGPF9oEF9isO60X+uO3s/VgBEQIeiGKj1QLEL72JqfEIMdBvSj8lERSlDraKUO3MfQgSZfK+nk8+jUFet6w5zUwuJSeOuKmbETq/c5o+Ira9s4kbbtr7s/oqLOyOVqO95QX26j/nlDcw1q2fa7kNb/11jSMLikAejoE8MnF+ckH9gQCZ0e2HEyMfQjGQM31sMtxwHszkPX1wCYwZawg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SG2PR04MB4074.apcprd04.prod.outlook.com (2603:1096:0:d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5102.17; Fri, 25 Mar 2022 03:00:55 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 03:00:55 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH] exfat: reduce block requests when zeroing a cluster
Thread-Topic: [PATCH] exfat: reduce block requests when zeroing a cluster
Thread-Index: Adg/8vGi1uwGLxPQRBCWtJcMeyhbsg==
Date:   Fri, 25 Mar 2022 03:00:55 +0000
Message-ID: <HK2PR04MB38915D9ABDC81F7D5463C4E4811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 291f2d7f-4271-49d9-5b9a-08da0e0bae24
x-ms-traffictypediagnostic: SG2PR04MB4074:EE_
x-microsoft-antispam-prvs: <SG2PR04MB4074A5A58CF8A9AE87A59125811A9@SG2PR04MB4074.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: prkP3+Au6Pu8tgThZ1bPr+E9yQe0dK8FQBBzSsScPnggI+z9x7tyijo63gwDecVTLRgUkh9CdejFOF8s1OK4dlNFbzCYP+ih+c2DtZu8FmS1HSHiMRJKBUOG+3TrU0xP1I1PomtGFoqhhi4UqMBercVQulO3Yxe8K573mVeM/yGBmANXXJUIrAGcO9gG8zwQAUsjGLDjnwJupJYsWiLuewKBflpd7mGbf7iHYlWuBNGxyKamnPv2faafkR2KHxCXVHUuFm34lYZTRRHn0emEPkl061Wm0+7gPVioDrShfo0MJfvr3Q1SY/4xCvh2FAFTt+aIQ4nDQ0ldUSwv1jxA12c+n/OmuMtA/xS3DGgPcy3w0Fga6fI51HqoC++HiD6kPptr9FpzkXxaxojz1b9JAae3C5p7/lxwI48AdB3BLMJSSZdWCfNuHkaOpiB2BVvIu0/aRuEEvhKsbZ9ZA0SKjg14w0Br4QSGm3WSfp2dZ+o9m+6j/q3XDG6af6ZiLAQRF8cVMwvvZw8Vm1pj4dZqagKBYO5Jn4JlmiQ2Wl0Qfl2RcUNwhIjidorBQNbcB0MPhL0o06Y9GJfKWY+Zby7Sgg/w56Q3UiIgNHxiB+Nip6mBYI/JOrIldoo8/mti3IKBkGKVgfUYpRLdEZIGghQq7p7Y+5hNyBwM3Te/dv32MEaKNH2landqgKqZjD9r92jtpIFz1c2FCpV37wCoXviMeQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(508600001)(38100700002)(54906003)(2906002)(6506007)(7696005)(55016003)(33656002)(122000001)(71200400001)(107886003)(8936002)(8676002)(86362001)(82960400001)(26005)(186003)(5660300002)(52536014)(66946007)(64756008)(76116006)(4326008)(66556008)(66446008)(66476007)(38070700005)(316002)(110136005)(9686003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ek03WHdrMnBRT0lUWG9PMnQvSVNKR2RGWlg5UC85OHFWQVZ0MTFBZHoya3RJ?=
 =?utf-8?B?RTRGcDR5V2Fvd2tjKzJxakFSeC9PL2JPYU5ya21LUElEbUhKbGlibkw1T1Rw?=
 =?utf-8?B?MjViaWR5b0oycFdIZzJIby9GWkswZkhIVDFvQm0xcEtPdG55b1lEYkhLK0l6?=
 =?utf-8?B?a05vRmJXSldwQkQ0SjlGSXRnTUtTSXc4ZzdpN0hnRXRMRjFCT2lIUEJwcTFQ?=
 =?utf-8?B?U2UrSG1raTM0N21KSitMWHpNUDNnMGtGOW1uSEE3VzNrcFc0bWwyOGkzZmNL?=
 =?utf-8?B?QUEyQWIzT2puWHo0NnBOZ29HeU43ZkwxamhEWExCSmt4ay9yNFRQaXlvM2RP?=
 =?utf-8?B?TnBZbFYrWDNlNGtmMFJHaVZEN29ZUXAwTVkyZ3h5anJRZ1RwbU92ZjNWdUkw?=
 =?utf-8?B?cmtKdHJQK215VnJiVUsxVlRSL2FXOTBTUkwrNG1kUGRRK0pMRWtTRUhqWitk?=
 =?utf-8?B?emlKbGdMck92ZVRoZ2hqSWcxSmxLeCt5RUhsblFNZWREWFVETXAzQlZ5RTFO?=
 =?utf-8?B?eGRTNlArRFRtYjJlL1I0RUJGU3dHckdkaHJ0ZGxWcE5oZlczcHpqUy96VzVP?=
 =?utf-8?B?ekZBWnJhdHpob29SWFVyK0lyeU00ZmtmNXVWMHVNUTQ3U3k2RVBKZHhyaFlq?=
 =?utf-8?B?NVNFMHFzbHpjVlBmQ3A5aWVKdWkzY2VabFNlY1hxREJiNTdnTUwrQVZQU0tG?=
 =?utf-8?B?ckE2aXA0TTVtSlZvcHdhVHI2K0xTK0s2c1ZoWjZXWTNWaVNoOWFQNUFPQmdv?=
 =?utf-8?B?ZUlTMTlmYlZHYmVDRVBoWnViRXN2eXQ5Lzhzb1h5V2txTUM3dnk0N25Yd1RZ?=
 =?utf-8?B?eENCYXc4RDlZSjM1M1N4Q1hFdktRZUtnRmZra2wxQWprQ1lCeUYydFJ3ZmVC?=
 =?utf-8?B?SnhxWlQyeGdnYkxLalByOWdCdWFMMnJ2OGNrTHV4bmtpbFREVXFqU21seU8x?=
 =?utf-8?B?U1dFcjRxbzBIQUwvOTc0NTROenA0d2dlVWh6Q3c5ZXlWQkxraUVldHczT3RZ?=
 =?utf-8?B?N2hRSVJqZnBPci8zZWlDc3BaaVdkUDZ3ZTZEdEc0ZURJNzlOMHFiU1VVRjB2?=
 =?utf-8?B?bFdHMlBKVVY2cnBjLzNURDhDTFNvVDU4M1lLRklkdzZYdlFDMUc1MzdQVjBv?=
 =?utf-8?B?ejdhUnhJRG9aWHJvOFhTYmQvS1p1dlNuYWdIdzk3cnJXY0pNNUxxWDlTQVEr?=
 =?utf-8?B?ZHFWUFQzcFJCendwbVFjZGtQR05tZUhsZkV5TitpWGh6cWxIUDMwbzlvSmpU?=
 =?utf-8?B?TmJxZHduWjR1QnprS3IwZlR5TmRkSHR3L00wWmwyb2FzRlZ0NzdjUWJmT0Jk?=
 =?utf-8?B?OTV2T0RTdlN3WHlUd1dYZ0d1dDVMdEE0ZVBieFluNlhIMTVrOUV3WVk5b1pl?=
 =?utf-8?B?VWJRMlVmbFpsNThLQkxqdlFkaUxYRW9ZRmg5Vkhub1htdE5zUTBGMng1RnhK?=
 =?utf-8?B?WFJPNlpMYkpoV1owUlJKS1JzOHVoWUlWWU1lQVFqcis5V2Z2REdVbkg3MHU1?=
 =?utf-8?B?N2pNTUVNank4QUJTZVZWVVBqbjdFRWUwQm5XMlhkL013eFRIcExTRkhYSi8w?=
 =?utf-8?B?djJmMFdXRHpBdFJuajVUS1VqdmJLTW9qdGhmRGJkcFE2RHhlWHpTdGdDeEpH?=
 =?utf-8?B?bnZxeGN3ZzQwaXY2dmVRWE5BU29udG5XMUtQVC9nZGthb3dBV0d6U0UzVTRT?=
 =?utf-8?B?dnVLMlAvajdDTDhhZWNiZzcxTTVvS1l6bHMyTWVac3dXd2hjOWowand5bDRH?=
 =?utf-8?B?cWhGMlNYdGkvQlg3ZjBHeWdnb2pobVJaajVsUnhCV1VXdDRGK0E1SkthLzVR?=
 =?utf-8?B?b05UM0x2eW1PRkd0UWxKNldFck5uNDhMSGJCdWlOWStadC9LYUpzcE9PUGRX?=
 =?utf-8?B?ZE41bzMyTm9tdjNkWGUyS1Q2bjlYbUllZnR3RlBEQXl5eUNVTytlU1BzcnJ1?=
 =?utf-8?B?Ny9tOFRnYjkzUnZ3UU90MmVlTkFyTHpkbGxycmxLRUZsZlFSSGRIK0Y5dyth?=
 =?utf-8?B?aHp3dUZMNzhPMmlhYkN5czRCY09lNGlSUjluU2Y0L1RBZTIyWGVEeHZRWWhn?=
 =?utf-8?B?R0htV1REZEFkeDlsb2l4MVlBZWQ0NFM0ZlRVbEhDL2MrbjEyTVhHNU56VXNx?=
 =?utf-8?B?QWhRVmd6YndacS9XZHd1MXppSUVJT0JWY3VTMHU5NUg2dU4wSDVVWkIzTDZj?=
 =?utf-8?B?QmZYbDcvMUlQZ29VS3Y5V1hlOFMxemFHL2Y2ZXZOZ0xUbGU3SGRNbjFiUVV4?=
 =?utf-8?B?Uk5CNTY3RFkzVUZlaTBlYi9qL1AzWENuaVRYeUc3c2RLdllRMFFBUDJNYXJw?=
 =?utf-8?B?c2x4UE5EYVVRSC9paHNvL2g4MlVoK1E0R0NKeUZ3Vk4zbnRPT2VYQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 291f2d7f-4271-49d9-5b9a-08da0e0bae24
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 03:00:55.4300
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7jcNidJ0a0MNu5T1BesVjaQCFqtOomtmB+FequW5LKY6fRGb+R6Jijt/l4lwfLIUwVTTFbZrrcTIdAAYPHCK2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB4074
X-Proofpoint-GUID: WNFHklwGFTQoNibahJOZ7j26KD1dsqCc
X-Proofpoint-ORIG-GUID: WNFHklwGFTQoNibahJOZ7j26KD1dsqCc
X-Sony-Outbound-GUID: WNFHklwGFTQoNibahJOZ7j26KD1dsqCc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-24_08,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 bulkscore=0
 mlxlogscore=999 spamscore=0 impostorscore=0 clxscore=1011 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250014
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SWYgJ2RpcnN5bmMnIGlzIGVuYWJsZWQsIHdoZW4gemVyb2luZyBhIGNsdXN0ZXIsIHN1Ym1pdHRp
bmcNCnNlY3RvciBieSBzZWN0b3Igd2lsbCBnZW5lcmF0ZSBtYW55IGJsb2NrIHJlcXVlc3RzLCB3
aWxsDQpjYXVzZSB0aGUgYmxvY2sgZGV2aWNlIHRvIG5vdCBmdWxseSBwZXJmb3JtIGl0cyBwZXJm
b3JtYW5jZS4NCg0KVGhpcyBjb21taXQgbWFrZXMgdGhlIHNlY3RvcnMgaW4gYSBjbHVzdGVyIHRv
IGJlIHN1Ym1pdHRlZCBpbg0Kb25jZSwgaXQgd2lsbCByZWR1Y2UgdGhlIG51bWJlciBvZiBibG9j
ayByZXF1ZXN0cy4gVGhpcyB3aWxsDQptYWtlIHRoZSBibG9jayBkZXZpY2UgdG8gZ2l2ZSBmdWxs
IHBsYXkgdG8gaXRzIHBlcmZvcm1hbmNlLg0KDQpUZXN0IGNyZWF0ZSAxMDAwIGRpcmVjdG9yaWVz
IG9uIFNEIGNhcmQgd2l0aDoNCg0KJCB0aW1lIChmb3IgKChpPTA7aTwxMDAwO2krKykpOyBkbyBt
a2RpciBkaXIke2l9OyBkb25lKQ0KDQpQZXJmb3JtYW5jZSBoYXMgYmVlbiBpbXByb3ZlZCBieSBt
b3JlIHRoYW4gNzMlIG9uIGlteDZxLXNhYnJlbGl0ZS4NCg0KQ2x1c3RlciBzaXplICAgICAgIEJl
Zm9yZSAgICAgICAgIEFmdGVyICAgICAgIEltcHJvdmVtZW50DQo2NCAgS0J5dGVzICAgICAgICAg
M20zNC4wMzZzICAgICAgMG01Ni4wNTJzICAgNzMuOCUNCjEyOCBLQnl0ZXMgICAgICAgICA2bTIu
NjQ0cyAgICAgICAxbTEzLjM1NHMgICA3OS44JQ0KMjU2IEtCeXRlcyAgICAgICAgIDExbTIyLjIw
MnMgICAgIDFtMzkuNDUxcyAgIDg1LjQlDQoNCmlteDZxLXNhYnJlbGl0ZToNCiAgLSBDUFU6IDc5
MiBNSHogeDQNCiAgLSBNZW1vcnk6IDFHQiBERFIzDQogIC0gU0QgQ2FyZDogU2FuRGlzayA4R0Ig
Q2xhc3MgNA0KDQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5j
b20+DQpSZXZpZXdlZC1ieTogQW5keSBXdSA8QW5keS5XdUBzb255LmNvbT4NClJldmlld2VkLWJ5
OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQv
ZmF0ZW50LmMgfCA0MiArKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0N
CiAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9ucygrKSwgMjQgZGVsZXRpb25zKC0pDQoNCmRp
ZmYgLS1naXQgYS9mcy9leGZhdC9mYXRlbnQuYyBiL2ZzL2V4ZmF0L2ZhdGVudC5jDQppbmRleCBj
M2M5YWZlZTc0MTguLmI3ZGUzZDA3NThmNCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5j
DQorKysgYi9mcy9leGZhdC9mYXRlbnQuYw0KQEAgLTYsNiArNiw3IEBADQogI2luY2x1ZGUgPGxp
bnV4L3NsYWIuaD4NCiAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPg0KICNpbmNsdWRlIDxsaW51
eC9idWZmZXJfaGVhZC5oPg0KKyNpbmNsdWRlIDxsaW51eC9ibGtfdHlwZXMuaD4NCiANCiAjaW5j
bHVkZSAiZXhmYXRfcmF3LmgiDQogI2luY2x1ZGUgImV4ZmF0X2ZzLmgiDQpAQCAtMjMzLDEwICsy
MzQsMTAgQEAgaW50IGV4ZmF0X3plcm9lZF9jbHVzdGVyKHN0cnVjdCBpbm9kZSAqZGlyLCB1bnNp
Z25lZCBpbnQgY2x1KQ0KIHsNCiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGRpci0+aV9zYjsN
CiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsNCi0Jc3RydWN0IGJ1
ZmZlcl9oZWFkICpiaHNbTUFYX0JVRl9QRVJfUEFHRV07DQotCWludCBucl9iaHMgPSBNQVhfQlVG
X1BFUl9QQUdFOw0KKwlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOw0KKwlzdHJ1Y3QgYWRkcmVzc19z
cGFjZSAqbWFwcGluZyA9IHNiLT5zX2JkZXYtPmJkX2lub2RlLT5pX21hcHBpbmc7DQogCXNlY3Rv
cl90IGJsa25yLCBsYXN0X2Jsa25yOw0KLQlpbnQgZXJyLCBpLCBuOw0KKwlpbnQgaTsNCiANCiAJ
YmxrbnIgPSBleGZhdF9jbHVzdGVyX3RvX3NlY3RvcihzYmksIGNsdSk7DQogCWxhc3RfYmxrbnIg
PSBibGtuciArIHNiaS0+c2VjdF9wZXJfY2x1czsNCkBAIC0yNTAsMzAgKzI1MSwyMyBAQCBpbnQg
ZXhmYXRfemVyb2VkX2NsdXN0ZXIoc3RydWN0IGlub2RlICpkaXIsIHVuc2lnbmVkIGludCBjbHUp
DQogCX0NCiANCiAJLyogWmVyb2luZyB0aGUgdW51c2VkIGJsb2NrcyBvbiB0aGlzIGNsdXN0ZXIg
Ki8NCi0Jd2hpbGUgKGJsa25yIDwgbGFzdF9ibGtucikgew0KLQkJZm9yIChuID0gMDsgbiA8IG5y
X2JocyAmJiBibGtuciA8IGxhc3RfYmxrbnI7IG4rKywgYmxrbnIrKykgew0KLQkJCWJoc1tuXSA9
IHNiX2dldGJsayhzYiwgYmxrbnIpOw0KLQkJCWlmICghYmhzW25dKSB7DQotCQkJCWVyciA9IC1F
Tk9NRU07DQotCQkJCWdvdG8gcmVsZWFzZV9iaHM7DQotCQkJfQ0KLQkJCW1lbXNldChiaHNbbl0t
PmJfZGF0YSwgMCwgc2ItPnNfYmxvY2tzaXplKTsNCi0JCX0NCi0NCi0JCWVyciA9IGV4ZmF0X3Vw
ZGF0ZV9iaHMoYmhzLCBuLCBJU19ESVJTWU5DKGRpcikpOw0KLQkJaWYgKGVycikNCi0JCQlnb3Rv
IHJlbGVhc2VfYmhzOw0KKwlmb3IgKGkgPSBibGtucjsgaSA8IGxhc3RfYmxrbnI7IGkrKykgew0K
KwkJYmggPSBzYl9nZXRibGsoc2IsIGkpOw0KKwkJaWYgKCFiaCkNCisJCQlyZXR1cm4gLUVOT01F
TTsNCiANCi0JCWZvciAoaSA9IDA7IGkgPCBuOyBpKyspDQotCQkJYnJlbHNlKGJoc1tpXSk7DQor
CQltZW1zZXQoYmgtPmJfZGF0YSwgMCwgc2ItPnNfYmxvY2tzaXplKTsNCisJCXNldF9idWZmZXJf
dXB0b2RhdGUoYmgpOw0KKwkJbWFya19idWZmZXJfZGlydHkoYmgpOw0KKwkJYnJlbHNlKGJoKTsN
CiAJfQ0KLQlyZXR1cm4gMDsNCiANCi1yZWxlYXNlX2JoczoNCi0JZXhmYXRfZXJyKHNiLCAiZmFp
bGVkIHplcm9lZCBzZWN0ICVsbHVcbiIsICh1bnNpZ25lZCBsb25nIGxvbmcpYmxrbnIpOw0KLQlm
b3IgKGkgPSAwOyBpIDwgbjsgaSsrKQ0KLQkJYmZvcmdldChiaHNbaV0pOw0KLQlyZXR1cm4gZXJy
Ow0KKwlpZiAoSVNfRElSU1lOQyhkaXIpKQ0KKwkJcmV0dXJuIGZpbGVtYXBfd3JpdGVfYW5kX3dh
aXRfcmFuZ2UobWFwcGluZywNCisJCQkJRVhGQVRfQkxLX1RPX0IoYmxrbnIsIHNiKSwNCisJCQkJ
RVhGQVRfQkxLX1RPX0IobGFzdF9ibGtuciwgc2IpIC0gMSk7DQorDQorCXJldHVybiAwOw0KIH0N
CiANCiBpbnQgZXhmYXRfYWxsb2NfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25l
ZCBpbnQgbnVtX2FsbG9jLA0KLS0gDQoyLjI1LjENCg0K
