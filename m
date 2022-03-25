Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBA8A4E702F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Mar 2022 10:42:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354687AbiCYJoE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 05:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357904AbiCYJoD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 05:44:03 -0400
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAB5CFBA6;
        Fri, 25 Mar 2022 02:42:29 -0700 (PDT)
Received: from pps.filterd (m0209322.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 22P4kuci032355;
        Fri, 25 Mar 2022 09:42:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=0jy1Q11krTW0IwSAiZvlkFDm1CwU+j4KZU7DquVCSXk=;
 b=ogrPfy44l6siWM08VHTOKBYcOkuQq+UQ1jhmmgltXHpUii/47jNpXy8oqoAtQdnk7T2z
 EK9UjAg1IE7p9K6fl1sJ9hVAnvGftg5iRwmjYLS1JMzL2wGRMCmbBr3nmuk+EufUjhwQ
 eW6jFVIXtoJQC/lXr7wTZZOwKm3/yrX5fFLMJtghSAX2Wf49Tu1MEy3g8RVAjjAHKfad
 EK1NarSiAKGTtROQvIozst5ULgUk6bzPtZ8GL2vy3FBwBPUOM5ZIqcMQDVQkQVtTErvr
 AsUbNjxfsFG0oFZQ8QE3pXanT8aB5AN4GCXLzflJWafi/DA9FPnf5JEVNrR//DlPp7Tf Cg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2048.outbound.protection.outlook.com [104.47.26.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f0yw3rk6g-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Mar 2022 09:42:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MQi8Fjx4ipVYUtLTk7wV5zqLbXv22aV0jgHvrw46fh/YU4jDHVEdVv4tzhR+z7AY2F33/2aXIBdSjz53UvwYrQv8YTWjhRf3EZvqf4UrVbbXWjKw7aKEQKkC8LNMPPr8DKeNLVsaavorWUDWWwoEjkfuCPfZAuW6RJnQj69xiVtJOHwo2vXDeKDL5HwQI+yWeqajif88PvRr1ecsDnET/m4j172PQuU6i6EoUIBJvzKEpFcgI+fkjtlMZsleD2csPjAvE8EmZ+qrEYLFEF45grMxCyVDoOMc0/uIfwaMzKIzr2ttnLyUQ88T+woCHjKTpKtC8a6u/C14JrT35DM6KQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0jy1Q11krTW0IwSAiZvlkFDm1CwU+j4KZU7DquVCSXk=;
 b=E+B5XtTXSuO0UzDiKcNgU26SpXeAZzglBfLPb4ZCplj6NfXKsidXwstlwICZg3Pz86W4L5v4tYqsF4W9XlsBFoJZbr2bJCFOhzhHlLVxxLdvSLxdTdXODgd95A6ydxPdvEF/NhJLokifrIeKmb6ZarxeU1kmMceXgFv/4WTb8uObEMBcrggRRMa7r/yuy0jEpImNaM1P/+BFDvDU1S0u806kV61QMV9zJUUrEX/Pd8EWIKBBEQPaF1eTs1VFhYiEnJx5xucJ9HUREjuwCDVOrNUy6e1Gk6IRB+yILUCywWV0iJGb60xhzsxdzMXilViiqYGsI9g1C3g1ovY7GlCjrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by HK0PR04MB2386.apcprd04.prod.outlook.com (2603:1096:203:4f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.16; Fri, 25 Mar
 2022 09:42:08 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5102.019; Fri, 25 Mar 2022
 09:42:08 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp" 
        <Kohada.Tetsuhiro@dc.MitsubishiElectric.co.jp>
Subject: [PATCH 1/2] exfat: fix referencing wrong parent directory information
 after renaming
Thread-Topic: [PATCH 1/2] exfat: fix referencing wrong parent directory
 information after renaming
Thread-Index: AdhAKsEtthO71fDaRs2uNUmwvcqVmw==
Date:   Fri, 25 Mar 2022 09:42:08 +0000
Message-ID: <HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a345c88a-1838-40fb-a34c-08da0e43bad8
x-ms-traffictypediagnostic: HK0PR04MB2386:EE_
x-microsoft-antispam-prvs: <HK0PR04MB2386E459A1FEBBDB4098D224811A9@HK0PR04MB2386.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: fk5h0ZLSPAgaN/ZizUjBcbPe1CjqYxthxO4JpsakTYqvip3zponkw+M/rW2ZPsofKm1+QRnnKdjygHp0myYC0vu/WiytdWCgiN35hfBJp425ivTPiIopnzDTYWCAVMBmk3m4Uw/Kkv7VFr9q42QC0acSLU8th0/JMjxr2YxnjjLW+XYYstTX5Ad9rcluzpBcZT4oB27IjK+ptMueN9dv/2VjHhH+bTxJbbUr2gVcY1BWYbydSN7rkqCVlW2MZN6kBesNuHfGO8aFfes5DcElH45ULftc2TXO4psc3RAsOlEmu4oCQdiEBNcsRaEWhdQUbhefW4m5HqjnHsu/D6WQN7g1ve8fbZjWjyYAzvrS/9XphOzSt8j6SV0XvGB/d9vjPiKCxQfp3qC4QbMzkQkYP3pw2HMUl7EY8iXOtyVJp3xfriDhTtqhdJtosXX27ceeVnIbhDZBUG3HyTYMjzyyOgVms8sjp7kXnqhT/mdTFLCtyc6zL1F5hYSRFNz9WVGSLl65f49e0Lfa5zERKtp4KnyxfSgZYLJhNQUOVWEI1Y1sZxbxNevPKwAAflr8bcqYndWJoeyRrECAPpK1OqpKDXlQS/Kw0sg+7i9jsxFInRczwTNLgynXuA44ygNdLPe2NmhddqWecCW7St3U8N927tKMaWi4OeYyDu/EoqaHEIACjj8ezu8RrHqM4mGT6PBaeQyopvwJ1Ki58r7124OjNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(316002)(508600001)(7696005)(9686003)(64756008)(66946007)(2906002)(38070700005)(8676002)(6506007)(55016003)(71200400001)(8936002)(26005)(52536014)(76116006)(186003)(83380400001)(66476007)(110136005)(66556008)(33656002)(66446008)(5660300002)(54906003)(38100700002)(122000001)(86362001)(99936003)(82960400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bnBsejhRejdLaTBzbVBYVjB2bWRHWTVQUjdIT2JVaEwwanMrR1V2blhuMmZx?=
 =?utf-8?B?K2sxVytTQm9sZGNGK3gxajR5VHBGOGNRcTJYck9ZY3pCQTNDaUxRZnhWYzdz?=
 =?utf-8?B?Z3hmb0hMd1RlWEw5ZkNTL1ozSTNYRUp6L2QzQ1phN1JhYmJPVE1uRE5wSVJj?=
 =?utf-8?B?SUZrcDhFdnhnZzVkSUhOWTF5azM4OFFWZ3pzVnNqMWp5Y1oxa0pVcjJmSHgw?=
 =?utf-8?B?N0N0YmxxWDFIYzYwL3d0Y3JteGN1ZDFXOWUyQjhjRzZPSG01OTdxOVkvUkho?=
 =?utf-8?B?THBPa3BWeUQ5NWU0M2JGaTQyeGMrWmloM0VOVk1SQi96d3lpUTlidUYyRzNQ?=
 =?utf-8?B?S3NETi9oaTZEZml1VUJyL1U2Qmx1dG9XaFF4a3dPbjF4VDRVRE03Rk05YVlB?=
 =?utf-8?B?Y3F2cUhFcXVZV0Z0R0dPQ0l2R3A3N1IrRmJ3Mlg4aXBiUWEwMlpYbDFxOWRB?=
 =?utf-8?B?STMzbXp0dGwwb2dzdnVXR21ZOElGd2JOeWNNblNBblZkTkFWemxIdmVEVHhI?=
 =?utf-8?B?UDh4alhxSXFXdjVTRzFsckFNT3ZLcmVabEZwdWVMUk5XYXhGMjJrbGpHZksv?=
 =?utf-8?B?RExyV05iWFBHUUkzY012bi9GTmF3L1JFRUZEU3V0bG52dU8vdkVPWFo2bndw?=
 =?utf-8?B?Q1lmOUVtNXFSNCtzSU9ZWHlQTzR0bU5Qcis3dTZaT29kWFhwVjUrMmpMVGxr?=
 =?utf-8?B?TWRVS0wzMkl6QVFjMXRzOW5BYTd2L1RWSC9FMUJFakZ5VkJqYWFpTmh6QU1O?=
 =?utf-8?B?U1h3NXcyNkQza2laZVp4SlVsUUVYZVkvSExUbkVrbFF5M3hxR3c4eW0zL0p5?=
 =?utf-8?B?eTl3OWhtTGVMVW1SWDFtcFBLMkpjQkRiWEdMb1RnZE9oNmZ1QzhaekZUcEU4?=
 =?utf-8?B?b1g1bmQ4UjlxYW1KRm5vS3hVMzR1akhWSTczNk8va1VQam9SV09qVFUyK3px?=
 =?utf-8?B?NTdPb1lTbG5QL3EvanZ1cGxOL3JWT2xHMXZjYlNDYWJ4bENzREF4bFovUFk5?=
 =?utf-8?B?a2w4ZHFGY01pbUgyTWZPQ2p0ZjhhcVp4WkgrTjZya3NKVndlMXNtYmNjMDlB?=
 =?utf-8?B?dUg1RmhHZXUzYUFJNlo1NHBWdmtXR3pPQmlOeUQ2dTBWRk8xbWxLbWJSbGRp?=
 =?utf-8?B?cGVxNGsrVmV1YjVkVm5sVE1nUjFiUHpDa2txQ3VXQmIwSTdMOVgyOHFJR0dp?=
 =?utf-8?B?eDJack5IbGRvMjlac0xwUlN1VDVVQ1FVdnN6K0F5OEszN2NTTG1acXd0OUNM?=
 =?utf-8?B?Umo1bk5NYUoxd05kOGZFTWZOU3lmWXdFZW9pQmpaU3J3ckdzUGplKytHbjRN?=
 =?utf-8?B?b21Oc3ozNC9PMzVxM2U2UVhIaDV3NHIvS2VvWS9tMTZlSFRRZHUyWHJ4UWo4?=
 =?utf-8?B?bHhJWHNDS3NYMHdhMTAreVVFcmIvUXQ1Yk1mb3Y0eGt3KzZJTFNvWWwvdDRM?=
 =?utf-8?B?Qmgvb1hESEFDUi9EYVlzWlZFVWN5YkRtbTBRaEJveWlqMC9RRFBlV014NXla?=
 =?utf-8?B?OVN1YkJLaWxNaS9GOVV6TmQ2bkFMSEh6NnVSOTd0RjNyOXhuY2dodXFUU3Z5?=
 =?utf-8?B?RmYrTUhXVFZ4SmhvSTRoZHQ4cmJwVGJsckxGeGR0OXk0dGlTZlBYdG1vMmJJ?=
 =?utf-8?B?L1FPandGZ0tOYVR6cU5yM0htVDE0aDNiZEhSaGk1K09UQUU0bzFGUENreEha?=
 =?utf-8?B?Sjd3SGt1MmRxOWxPNVUwMVVmaXUzK3diUFFDSlE4WnJJTGJXQmxLQ3Y0ZTFD?=
 =?utf-8?B?VHNudmgrT1dyL0ViMlVKR1FDTmxTWGFzaUtPYmZGWXVTTUxvek9NbGRXWWVM?=
 =?utf-8?B?ZDNTeWowczI4OU5CaTFOK2ZsM0JoZTAxK2lFcWpWSDBDVmZLTmFGdTVxOXV4?=
 =?utf-8?B?YUsrS0VrcUd5OGc5KzZ1SHVBMG1VR2Ixc2Q1OHl6N2toVjBrSktKeU5iM29x?=
 =?utf-8?Q?oIi63rQ79H/0crLDgKp8dPxtne2WSq22?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a345c88a-1838-40fb-a34c-08da0e43bad8
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Mar 2022 09:42:08.5922
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: m41cA1jW0mF1UoafSeTWFqlcn/H1IfW1NEK554BIxpj0zzzigsBtdbfDVxA5SmLSE384dlDWpwHlwKWhGxZ95w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK0PR04MB2386
X-Proofpoint-GUID: R-mx-bLXHbbd9taD3GWx715hZc_2ZWn0
X-Proofpoint-ORIG-GUID: R-mx-bLXHbbd9taD3GWx715hZc_2ZWn0
X-Sony-Outbound-GUID: R-mx-bLXHbbd9taD3GWx715hZc_2ZWn0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-25_02,2022-03-24_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 phishscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 adultscore=0 spamscore=0 suspectscore=0 bulkscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203250054
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

RHVyaW5nIHJlbmFtaW5nLCB0aGUgcGFyZW50IGRpcmVjdG9yeSBpbmZvcm1hdGlvbiBtYXliZQ0K
dXBkYXRlZC4gQnV0IHRoZSBmaWxlL2RpcmVjdG9yeSBzdGlsbCByZWZlcmVuY2VzIHRvIHRoZQ0K
b2xkIHBhcmVudCBkaXJlY3RvcnkgaW5mb3JtYXRpb24uDQoNClRoaXMgYnVnIHdpbGwgY2F1c2Ug
MiBwcm9ibGVtcy4NCg0KKDEpIFRoZSByZW5hbWVkIGZpbGUgY2FuIG5vdCBiZSB3cml0dGVuLg0K
DQogICAgWzEwNzY4LjE3NTE3Ml0gZXhGQVQtZnMgKHNkYTEpOiBlcnJvciwgZmFpbGVkIHRvIGJt
YXAgKGlub2RlIDogN2FmZDUwZTQgaWJsb2NrIDogMCwgZXJyIDogLTUpDQogICAgWzEwNzY4LjE4
NDI4NV0gZXhGQVQtZnMgKHNkYTEpOiBGaWxlc3lzdGVtIGhhcyBiZWVuIHNldCByZWFkLW9ubHkN
CiAgICBhc2g6IHdyaXRlIGVycm9yOiBJbnB1dC9vdXRwdXQgZXJyb3INCg0KKDIpIFNvbWUgZGVu
dHJpZXMgb2YgdGhlIHJlbmFtZWQgZmlsZS9kaXJlY3RvcnkgYXJlIG5vdCBzZXQNCiAgICB0byBk
ZWxldGVkIGFmdGVyIHJlbW92aW5nIHRoZSBmaWxlL2RpcmVjdG9yeS4NCg0KZml4ZXM6IDVmMmFh
MDc1MDcwYyAoImV4ZmF0OiBhZGQgaW5vZGUgb3BlcmF0aW9ucyIpDQoNClNpZ25lZC1vZmYtYnk6
IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4NClJldmlld2VkLWJ5OiBBbmR5IFd1
IDxBbmR5Lld1QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFveWFtYSBXYXRhcnUgPHdhdGFydS5h
b3lhbWFAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogRGFuaWVsIFBhbG1lciA8ZGFuaWVsLnBhbG1l
ckBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgfCAxICsNCiAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKykNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9l
eGZhdC9uYW1laS5jDQppbmRleCBhMDJhMDRhOTkzYmYuLmU3YWRiNmJmZDlkNSAxMDA2NDQNCi0t
LSBhL2ZzL2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC0xMDgwLDYg
KzEwODAsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlbmFtZV9maWxlKHN0cnVjdCBpbm9kZSAqaW5v
ZGUsIHN0cnVjdCBleGZhdF9jaGFpbiAqcF9kaXIsDQogDQogCQlleGZhdF9yZW1vdmVfZW50cmll
cyhpbm9kZSwgcF9kaXIsIG9sZGVudHJ5LCAwLA0KIAkJCW51bV9vbGRfZW50cmllcyk7DQorCQll
aS0+ZGlyID0gKnBfZGlyOw0KIAkJZWktPmVudHJ5ID0gbmV3ZW50cnk7DQogCX0gZWxzZSB7DQog
CQlpZiAoZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXBvbGQpID09IFRZUEVfRklMRSkgew0KLS0gDQoy
LjI1LjENCg==

--_002_HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="0001-exfat-fix-referencing-wrong-parent-directory-informa.patch"
Content-Description: 
 0001-exfat-fix-referencing-wrong-parent-directory-informa.patch
Content-Disposition: attachment;
	filename="0001-exfat-fix-referencing-wrong-parent-directory-informa.patch";
	size=1280; creation-date="Fri, 25 Mar 2022 09:01:36 GMT";
	modification-date="Fri, 25 Mar 2022 09:42:08 GMT"
Content-Transfer-Encoding: base64

RHVyaW5nIHJlbmFtaW5nLCB0aGUgcGFyZW50IGRpcmVjdG9yeSBpbmZvcm1hdGlvbiBtYXliZQp1
cGRhdGVkLiBCdXQgdGhlIGZpbGUvZGlyZWN0b3J5IHN0aWxsIHJlZmVyZW5jZXMgdG8gdGhlCm9s
ZCBwYXJlbnQgZGlyZWN0b3J5IGluZm9ybWF0aW9uLgoKVGhpcyBidWcgd2lsbCBjYXVzZSAyIHBy
b2JsZW1zLgoKKDEpIFRoZSByZW5hbWVkIGZpbGUgY2FuIG5vdCBiZSB3cml0dGVuLgoKICAgIFsx
MDc2OC4xNzUxNzJdIGV4RkFULWZzIChzZGExKTogZXJyb3IsIGZhaWxlZCB0byBibWFwIChpbm9k
ZSA6IDdhZmQ1MGU0IGlibG9jayA6IDAsIGVyciA6IC01KQogICAgWzEwNzY4LjE4NDI4NV0gZXhG
QVQtZnMgKHNkYTEpOiBGaWxlc3lzdGVtIGhhcyBiZWVuIHNldCByZWFkLW9ubHkKICAgIGFzaDog
d3JpdGUgZXJyb3I6IElucHV0L291dHB1dCBlcnJvcgoKKDIpIFNvbWUgZGVudHJpZXMgb2YgdGhl
IHJlbmFtZWQgZmlsZS9kaXJlY3RvcnkgYXJlIG5vdCBzZXQKICAgIHRvIGRlbGV0ZWQgYWZ0ZXIg
cmVtb3ZpbmcgdGhlIGZpbGUvZGlyZWN0b3J5LgoKZml4ZXM6IDVmMmFhMDc1MDcwYyAoImV4ZmF0
OiBhZGQgaW5vZGUgb3BlcmF0aW9ucyIpCgpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVl
emhhbmcuTW9Ac29ueS5jb20+ClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29t
PgpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBzb255LmNvbT4KUmV2
aWV3ZWQtYnk6IERhbmllbCBQYWxtZXIgPGRhbmllbC5wYWxtZXJAc29ueS5jb20+Ci0tLQogZnMv
ZXhmYXQvbmFtZWkuYyB8IDEgKwogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCgpkaWZm
IC0tZ2l0IGEvZnMvZXhmYXQvbmFtZWkuYyBiL2ZzL2V4ZmF0L25hbWVpLmMKaW5kZXggYTAyYTA0
YTk5M2JmLi5lN2FkYjZiZmQ5ZDUgMTAwNjQ0Ci0tLSBhL2ZzL2V4ZmF0L25hbWVpLmMKKysrIGIv
ZnMvZXhmYXQvbmFtZWkuYwpAQCAtMTA4MCw2ICsxMDgwLDcgQEAgc3RhdGljIGludCBleGZhdF9y
ZW5hbWVfZmlsZShzdHJ1Y3QgaW5vZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfY2hhaW4gKnBfZGly
LAogCiAJCWV4ZmF0X3JlbW92ZV9lbnRyaWVzKGlub2RlLCBwX2Rpciwgb2xkZW50cnksIDAsCiAJ
CQludW1fb2xkX2VudHJpZXMpOworCQllaS0+ZGlyID0gKnBfZGlyOwogCQllaS0+ZW50cnkgPSBu
ZXdlbnRyeTsKIAl9IGVsc2UgewogCQlpZiAoZXhmYXRfZ2V0X2VudHJ5X3R5cGUoZXBvbGQpID09
IFRZUEVfRklMRSkgewotLSAKMi4yNS4xCgo=

--_002_HK2PR04MB3891BE0766FAF0AEC39FE2DC811A9HK2PR04MB3891apcp_--
