Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF47E63726E
	for <lists+linux-fsdevel@lfdr.de>; Thu, 24 Nov 2022 07:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbiKXGkw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Nov 2022 01:40:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbiKXGkv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Nov 2022 01:40:51 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DA8DAD12;
        Wed, 23 Nov 2022 22:40:46 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2AO6OH5q001748;
        Thu, 24 Nov 2022 06:40:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=emgSOPh0cF7CKC8IRLSXKMNrrGNdYnarwKBjiEfuu+s=;
 b=ZIYcdR2XWCLD8+ImzS907cQouBvJ+wPqqHOWJda4p4muU4NB4CVrRjwXFQAHVwr9S33W
 pUmWAc5CDSvpIYVMsS/Z03PXXMh7E5k8350geuicT4xQKPCxRPlK8hkk7qjWR5J/tA+a
 tCjBGlW0RYauvigR7kK4Ocl+Rk8WXJNYjq4eTke2Ec8eVkIeV41/0iLfNou9gc0b1oXt
 0sGeEowwBDe6eAGnvEF1RdCZTsZD/AmKXI3a/Q4HeIu+4E2iZc9LzPRCEsa3mPMvaqtK
 djd19/jzDrqYeqpyWEQB55W4yPTT1VDMXqYDKoE6hHRRoCKkPcryl1Ac9p5Lgut6vtiV pg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2047.outbound.protection.outlook.com [104.47.110.47])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3kxrb94t31-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Nov 2022 06:40:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Undr1rV5azglOOXD2XKFwiLrlpIVhCq4c6Dp+MEU1FzPgJOfC2XUmTGALW80JisAzPkVE+mv/V8taBhm1GVn2KBKgXwgsF8dup9R15apG+qyM4aqGZpCmqvkd5eGCz9DiYAx4S01i8BukL91hJYcynz5H84FyCOR50xaOxKu1tjSJhPgPVz7V8VZVPg6X3ttNAWKF44ME0NXDA3+lv9zIX1dormstqDYTEZcKp7lKmrBWpDBGz+NrJEGR7C/cQYqZxwmI+7LHjtrPAT/vImymZO9j4rpJ244D1lbzDNt/wAhWA7NIZC0MVp5svmhWNAnP3LCVwl623b2Y5MgyWOX4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=emgSOPh0cF7CKC8IRLSXKMNrrGNdYnarwKBjiEfuu+s=;
 b=U6AtmMNc8xO2Gcm4/rRwtj7jQjbAsi8MpXwEdZgA5WMlS8/EboP7mNkrrNU2hNpS8N76ZOIHCavAHLxuCA8tKgsfnwhVNoKmPrMPNTqM5Jpqyxc1P8tGdLtQU5xqp8lTNI2dfYPN4qTVAqaZtDrd9jpNAr4CwV7BNtdPBSe7n7CGDp9Y18LWiA3nK2OyzBnRRt9sk9L4MP8G1MIvAfr6JeaXNNIuqfaHE56YQ7YA2UMSamgQGBIyjYMtE6i+MyXY9ztVA0cYC2S3gswXsWqieHfU6JaGP6kM1tUpu6qhikf+m4sV0KkEJnMSFVB/9Lbu7O+dH9/GpRpuaTCuYHEluA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SI2PR04MB4425.apcprd04.prod.outlook.com (2603:1096:4:e8::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5857.17; Thu, 24 Nov 2022 06:40:22 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::708b:1447:3c12:c222%8]) with mapi id 15.20.5857.008; Thu, 24 Nov 2022
 06:40:22 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 0/5] exfat: move exfat_entry_set_cache from heap to stack
Thread-Topic: [PATCH v2 0/5] exfat: move exfat_entry_set_cache from heap to
 stack
Thread-Index: Adj/yW2oS04GQk8XQ3WWnivO3zERqg==
Date:   Thu, 24 Nov 2022 06:40:22 +0000
Message-ID: <PUZPR04MB631661A405BDD1987B969597810F9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SI2PR04MB4425:EE_
x-ms-office365-filtering-correlation-id: 1df7b470-8720-4bff-0fb3-08dacde6c2f0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: iddjfi51aySt6uhQnbB0SFH+bAIQ8aVBZG3Vd6KB8/UG4GJ4XLO4EWiQgCUhqgPdvDUwtS6Q8kQBWRQfKNLrKm2PIe6dv0txbIZTkpqU3SfoIX6AYi6dmn+NY1SBwKvq9UPoqLIz90Oshu7OC4HB16U2ODeAAej0jGvXVX7RB5DK6m7W06FlEI4S9LzkXbIJa/KeWtYtYxmQs8j1rMD63AlK5VbRL1a5fUeiWhigc9OjiEheUHiPro9DL2yph8VnbFO7WTHSqn0Y9U0ewTjkHfQ7hPFhCsl+GrRNTJ6jOlU3pRcX/X472azMdwboetDRo7a/myhJxVZ2b1TvcWo5WLBGQyQjC8TlMx+vgvqDaktfQzgC0az79FPfOxDccnRXsDxPdzAvTUH1zjqNVl6dsOeVfbQTSMG9i5LjIrKT1PQWCqueJKTrwIMrSHxUKPh9wWvy/GhAWIzhskfgqsNzykTLSWkDC8vzWF6SjiDDF7kGfber5Hn0nWfqh/g/+9nC4FANKzIy4rvV1RRHgT/v7DVziHXN423CnOm2erWswhnFAY/+hwV/yJEAClfBR2Apr2ITdUP9BtABPpUkV6Xy82nJRn+elfb1xVcHRFOrOBi8VkJbSMnbJmfs8ApafvsVbA1o6AW3pLxBHgES9JYLwLavSg6iKxxLoVnrfEl/VPuU9rkoW39Dzk8KvcH+4BT2cUMnQF7OJUJNpRjE7Lbpbg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(376002)(136003)(346002)(451199015)(41300700001)(8936002)(478600001)(4744005)(54906003)(4326008)(5660300002)(316002)(66556008)(66476007)(66946007)(76116006)(52536014)(66446008)(64756008)(8676002)(71200400001)(107886003)(2906002)(7696005)(6506007)(9686003)(186003)(110136005)(122000001)(26005)(38070700005)(38100700002)(82960400001)(86362001)(83380400001)(33656002)(55016003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzhkQVI0OVpJSGg2MzI0S21uSDN3emFtU0RSQjJsdjgzamFMVWsrWHdMOVc1?=
 =?utf-8?B?VWZHNzFSVUdCeFZTazF0ZFZNV1hYWm5pUTdjb2xwSkpDRWRqN1lTVGI3NktF?=
 =?utf-8?B?K1AzM1g0VmpJNTFzUEozS1dvZ0VJK3FOQXRnZlRpS1ZEWUt5d1lDV2dlUWtt?=
 =?utf-8?B?Rjg0VUc3N0dQK24vaUtiUElnWTB3cWl1aVUwUlVvNi95SGtjd2RQUzlTQjJv?=
 =?utf-8?B?d1FpTUl0dERaQ2U3OGhUNXpLUzRuTGRzQ01oUnpvdGV4WXp6SzlDRjYxckJN?=
 =?utf-8?B?bDlKY0hzaGhGeno2dGVaREU1aHZwRWpWWTFsSkw1TXVGRmZ5K0g0aDNic2Jr?=
 =?utf-8?B?YUZKZEZLQUwwU2ViRVd3WTRnZ1d2QS9vQ3JmKzdzalk3eCtwOGMzMmZOeXc5?=
 =?utf-8?B?dHFlTmNpOVovL1pOTkR4TUN5ZTI4NVRtR0RsbUFhMXFqcG1xU1BWKzBaMCtY?=
 =?utf-8?B?YzFwYXBqREc4aVV0ODMxaU1QVE9ZZXBLeGgwNXdyc3RlSTBXTEduR3FUMk5q?=
 =?utf-8?B?cDFOeHU5amxEa3VoY09LTW4wMkY2WDBtUmxwc1VhNDVGK1l2R05nVURVcEFm?=
 =?utf-8?B?MVJNRjg2eWsyTWlLcDZ5RGlBempNTG9CMnBCUzUzeUN5cmEzL0lyVXFzSzNs?=
 =?utf-8?B?QkxnMFk1QzhnV1Q0VXlLRWRVRTAxMzJvdGFBelBzc050RHFkZVpvWWtNam13?=
 =?utf-8?B?WVZtc3ZxVkJzTUtMUmZ0ZkVWNnhQK2JKM2o2cHAxOXIxdm1kOFE5NWNnK0xB?=
 =?utf-8?B?bjROLzZkNWpMekowVXc5QXRmZUR5WGJsN3JPYmFPY3NVSFNxeVVhNHo5bmJp?=
 =?utf-8?B?NXk0aTlHQ2M4ZXNRMFd1VE9hSlBnaHRYbVZNeEdEVW45NVBVb3JWem01V2VG?=
 =?utf-8?B?UEpsc2dwN1NyUEl4SWZkSHpVRjFqeTliT3NCTlZlL2d3Qm5mRmZDdU81aVJP?=
 =?utf-8?B?ZWJTUTdkckdSZUN6akU2di9HZzZ2R20rS09WUUZ2bi9xUDFIWms5c0pTYm1T?=
 =?utf-8?B?d2owS2t3Lzc1djNtTWFFRHFVam0yeGJ6b2h3L1Evd2pnY3ozTUpyNHI0UUpN?=
 =?utf-8?B?cW5MSGpMQ25YRjcyY0U0SkpmTFNRTVVURUFaK0dWaU5lQUU1ejZienBTMUFl?=
 =?utf-8?B?YkZwR3BoUWNoT1d3TlZCZGNSR3RYcFNVMVRpK2lTVjZNZEx6L3QvR3c5UjZ2?=
 =?utf-8?B?a3BTSk9NK2Q1TjNPNXJQbHVLbFR0ZGY1dXdNMitacEhQM29OdHk3cG1obzJv?=
 =?utf-8?B?Zmc3MzRYYXl4K0krR240cmw4Y2h5ZXNjTnNMZlhnVmt4OUg3citiaXNFeE8w?=
 =?utf-8?B?VFdGaUFrZGpHVkpJU2l5a3BuZzEzOXBzKzlnaUJaODZxRkg3d0JkUGFjbTh1?=
 =?utf-8?B?aUhUOCtXVEVGL3o5cTUrQjdNbFVSQ3NrY1NlbXdrU1RhVHVuUXRBODFmZGtY?=
 =?utf-8?B?bXpmTHJUenNZMFZNSG1BWkE1Y01HamV3czArTFhXa3RJNFpvT0ZYWCt3MkhR?=
 =?utf-8?B?T0xjcFE0bnZqUTZuR3lNSWlMZWZIcDZnWFNrNFptWHVIL0l6LzM5SlBRU0VJ?=
 =?utf-8?B?VjdTYlNXQUdxYWlTNWJWSUc0U2dWczQ4NDdROURpalBqUmh4RWxRbFBLL01Y?=
 =?utf-8?B?dkIwMFVwLzRBVlNmS1VRRmJuaG1aT3Rma0cyZWJ0aGx2dUZRY0p2N2dFNzZZ?=
 =?utf-8?B?VzZRTzh2S1AwOTBNcCtGaTFjbEI4UVhNUFVoMFo2cnZoUTNZZkZ1emVXS0Qv?=
 =?utf-8?B?eGJhdW9aVy9sWW4xWVlWSUQvOG40YS9JT0lzcWp4YXAwa1ZHZzlKNk1Fb3ZN?=
 =?utf-8?B?OFFVRG1EZjZHdkd0SE5tdVAyQ1VQRk10UDM3cEh1L1FQVXQ0cjd0c3J3Z296?=
 =?utf-8?B?MTJkcEowUjhQM3hIUnRONHBFNnJHa3NnRDlLVG5XU1JvUXM0TGhDZDNXVTdK?=
 =?utf-8?B?YWpObTF4OFQydFQ1NFRuNW1WbXpBdStJczVTK1dhY3JpcXZnbzc2RER0dnpL?=
 =?utf-8?B?N0J6S01DK1pQWHpWR3krTnZjYmljQjFscFJqNkNqaDllS1hFNExSeUc4R3Ev?=
 =?utf-8?B?S2VDckRPd1ZzUHc2U3FEaEdBc08rOFl6SFdlNUhXSkVtUnFqNE50L2JKc1U3?=
 =?utf-8?Q?Gr9kkbLhN7tUkEoYwKqzGmxW4?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BNF7N8ADJoBgsW5SOW4pJyfrgZLnUjCVUmagGImknxtsAqopnlj0XlYL1IEOdCzZYA7PVvYuH/+MvAbsF0F07Fny6vwK6Jm6AJBGsGf+Et27gc0UdZtUUpjEcHADe5pYpuyNTfTsCsldDXA/1qRZWrZrsC8GBS6QXrs7gtIZT/3YDrHeGFhyO5FJX7ehA3swGyNMyy2qqT9tKnhsSFfPaC+01EIqa+K7RMoIdS+TvvuaPmLUgmI6ZDvNHydzXAcpCZs2oA3zyeHEUq368Z8UEZHAbFVJybkaZvbaAnIQvkgofiyfPv5I5YkzWgcbTpIIJ3A/qe66DxS7iojJSg1Xt6VLdT1HytswZBxJGovpg7/NP/hZ4hPCfko8Z2AvnX1DBHh2ohfBbZl6iyZMRpQ9UolCoQBF3HvTGmDUF09Zo/vZ5oXjN7c2sd0NymwC7fb4L6hZRuEVR7dxvm4IsFMQUAlKkrz6NQQIPfbs4w0xIfderXL6X1bt5XiMj0gWEtosTTxsqGmDtrmO7U6lAHvTTKXjIA0OQ7ghLf3TLdpcFf4xf5Y6OKHbE3zi10NuLEth98+t7xR37nuwXkls2ku+zESidyUp0Pc0dgxAFSZjmpxRnfKPs1dgzrI6nfMnwf2/e2RJYtH/PjwEwQVlzL17bSyDYaTHOOTq0g/mtYgrDaoxShM65epoe9punDt07Gp0uEFs0wUdbAcpKrFlrAEbPk1gvQiW3SULbqVMlLyWT1hxG5pQwmZJhwhCqgdwFtopigWqt6r+khAhFnuf6OlpPS2ujEs+ns6PRXROosfYOBR+WNmnHfJIG8DXPi4XgOZ0+l7xrLwv2tdTqDIDTmu0wSI0HvUWC8hASP+4GGp6b/m4Q7fZPa2Am6Yrg46Ex3V9
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1df7b470-8720-4bff-0fb3-08dacde6c2f0
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Nov 2022 06:40:22.2406
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f0FTT3B2na1G5dTTgTeH69v2bFGhERnqIZdcxbug8+MnA315M8xCMXaK64onRMSUkj9zVvuzsIJop69yPumzDQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR04MB4425
X-Proofpoint-GUID: j4_d0W4wZx7RT3iwQ8G0r2ikmBUE4NsY
X-Proofpoint-ORIG-GUID: j4_d0W4wZx7RT3iwQ8G0r2ikmBUE4NsY
X-Sony-Outbound-GUID: j4_d0W4wZx7RT3iwQ8G0r2ikmBUE4NsY
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

VGhpcyBwYXRjaHNldCByZWR1Y2VzIHRoZSBzaXplIG9mIGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBh
bmQgbW92ZXMNCml0IGZyb20gaGVhcCB0byBzdGFjay4NCg0KQ2hhbmdlcyBmb3IgdjI6DQogICog
WzEvNV0gWzUvNV0NCiAgICAtIFJlbmFtZSBFU18qX0VOVFJZIHRvIEVTX0lEWF8qDQogICAgLSBG
aXggRVNfSURYX0xBU1RfRklMRU5BTUUoKSB0byByZXR1cm4gdGhlIGluZGV4IG9mIHRoZSBsYXN0
DQogICAgICBmaWxlbmFtZSBlbnRyeQ0KICAgIC0gQWRkIEVTX0VOVFJZX05VTSgpIE1BQ1JPDQoN
Cll1ZXpoYW5nIE1vICg1KToNCiAgZXhmYXQ6IHJlZHVjZSB0aGUgc2l6ZSBvZiBleGZhdF9lbnRy
eV9zZXRfY2FjaGUNCiAgZXhmYXQ6IHN1cHBvcnQgZHluYW1pYyBhbGxvY2F0ZSBiaCBmb3IgZXhm
YXRfZW50cnlfc2V0X2NhY2hlDQogIGV4ZmF0OiBtb3ZlIGV4ZmF0X2VudHJ5X3NldF9jYWNoZSBm
cm9tIGhlYXAgdG8gc3RhY2sNCiAgZXhmYXQ6IHJlbmFtZSBleGZhdF9mcmVlX2RlbnRyeV9zZXQo
KSB0byBleGZhdF9wdXRfZGVudHJ5X3NldCgpDQogIGV4ZmF0OiByZXBsYWNlIG1hZ2ljIG51bWJl
cnMgd2l0aCBNYWNyb3MNCg0KIGZzL2V4ZmF0L2Rpci5jICAgICAgfCA3MCArKysrKysrKysrKysr
KysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCiBmcy9leGZhdC9leGZhdF9mcy5oIHwg
MzcgKysrKysrKysrKysrKysrKysrLS0tLS0tDQogZnMvZXhmYXQvaW5vZGUuYyAgICB8IDEzICsr
KystLS0tLQ0KIGZzL2V4ZmF0L25hbWVpLmMgICAgfCAxMSArKysrLS0tDQogNCBmaWxlcyBjaGFu
Z2VkLCA4MCBpbnNlcnRpb25zKCspLCA1MSBkZWxldGlvbnMoLSkNCg==
