Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 958514EFE34
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 05:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347763AbiDBDcB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 23:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345533AbiDBDb4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:31:56 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C643DCFB85;
        Fri,  1 Apr 2022 20:30:02 -0700 (PDT)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2323Hr7Y026715;
        Sat, 2 Apr 2022 03:29:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=QoZu6Thw0qjEC5H55c0voBd89jrCWZYVpEf7GxeijJ0=;
 b=AMrjnowXaiLlZSuefs/o8Y4ofZdjESGg5mxGBd3GpRCHb7JCSVJxjE7vIChpHoDlfeI1
 Pup+V2d+FbgU2lLH93gXo4kpyn5c1f955zy3asHo74chsHzjeQs9Zg7IJ/pxsMT5zv7h
 lStFLw+oVivb304/QN9Zx9nkxM5aPx/KbESLxy9JAA2/TD6pfKmGz8aXXd3gSI7RSpSw
 2j1P2upkeOqmsHVf9uF+/E00MMUCV3kOcfH6FQU6F8UG4fAu/jC/v6BGnFGspghOLTJR
 /EtZbp6TeiX68+DBRASY882eEjdgp7L2ys02TgLBW4uTwdZ27yVbhKDq70c0LvMBqDcP JA== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2046.outbound.protection.outlook.com [104.47.26.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f6dbyr13h-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Apr 2022 03:29:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M67WqnOhEOW9brIqeTW9FLs58577WKhN469qfCgCsklmMAsH2R1G7vz+pBHGzA+74wBaWc+HXrNWmJUtTqCVaNfIUBTB9X8blQcmJlGIIc4SAbyCGcooJ/saL/SIqTyJt4QpLSYi6GS7XEpckxyBSBCNuE7FjeNi3cgxbYeZsCSU7iTUq9KABB2/zbCvN9fjSBUgBRatEPSQTAMmIBD8/GsX4gS+Mpy8kLTuF7KcwU453LEgnBIHEa/R7BGC3EhaCOr3EZR0/Ii0ZVv7cPCTiIvvjDrJJikO+ObRObDPLx1SEurpXlf/l/8RZIyJfOMcJqu+/iZvrd1kE0qeiFqG6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QoZu6Thw0qjEC5H55c0voBd89jrCWZYVpEf7GxeijJ0=;
 b=ObY160W0xGk7+AH62TkCq9ngfbgGi77I0bYTgdWle+wqdj8tBvEm6VoUeuR/Dy1VCoOBce+9KYleQzyHL8Cpy2OE1gaBxvHnSIGllNS93FcAVeMrfwnFdAaIg37j3jxcY4SOopUCxdb++RG7r92VwOPQ8Js6nuOKYMLKAwtiYIPkPO47tSo+kPPQ/5szRzZ7J3Rbp7v+gxOi47qDqyX1KMH8PMqudBVpxMaIRUuAWQGs2bC/YC5KDOdjvo9Rqu/dj0lLO/2lPQRL9JylbJUgYby5ceZ2gc1vc5YKbK5AWrPG1VHhgCquA8BybX9Y+iuGuQxPSeGcQQYWFdN9dv5kFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB4173.apcprd04.prod.outlook.com (2603:1096:400:2e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 03:27:58 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 03:27:58 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        Namjae Jeon <linkinjeon@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 2/2] exfat: reduce block requests when zeroing a cluster
Thread-Topic: [PATCH v2 2/2] exfat: reduce block requests when zeroing a
 cluster
Thread-Index: AdhGQPrZ8jFXP7cDTmSgzBFekuDYAQ==
Date:   Sat, 2 Apr 2022 03:27:57 +0000
Message-ID: <HK2PR04MB3891C5C2430056F553BC51A681E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7f8221b5-300a-41e4-f56d-08da1458c88d
x-ms-traffictypediagnostic: TYZPR04MB4173:EE_
x-microsoft-antispam-prvs: <TYZPR04MB41739768C8CB0C2716C467DB81E39@TYZPR04MB4173.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zunHhxBi3VVG5xod2LOzlx1BWtwIBfadJ3pQxPogvV4NuO3oGGDwxCZHjiK86X9IJyW9EI1cxUH5YViWMp5RjJwu439+NQY2B0OlpD7PCG5rCyE+9VyJ8l7ePjIeSLV9FJTpsRRE+kI0a524v9MnezNj3dOW31bVz78XdB/ZA6vef8KeqZAJfcYI1CuBzGWS0hk8g5UFC7nrgZ29j/hII5DILcz7sb7Ry79/SLAWr7dMvpCmgeJENtftOvS/UU86pWYLdsh1c0SrVk7qCfuOdo95Mb19XCtIWuFshLlq8y+1WQLa/7meFRD5Qfmy17yCFiUC9+ZOiO75TfDCMoNfyi+U4jnDA7ob2G7K6gdISS+Z8/EzDt+6dPfRSr43wJ2XisCdFxEHSqAzGNQ+i2DWonU7Slxh820j6fzq26D0qbRvrdU9vrhag0NvvTyRLfCcYs3bzwFmPNcNa3Q8+SIozEVfENVU+znfpjOm7dSoZ27GTuKP3w7oaztFkhtd4nv5iVSi5YlFRL5n3muKMkL3GQwWqnfsUJ+NlM+ViPrr53DuL2CFkKWQhRyMisnYMv3fOcafTstZi4yRBH00IOhAdGJP1u3JyMPhV+pM36m1lMUSfPTajKUe+AqfdCMPAjOnV9yXdZhx0XwKDK1YkzaNvlyVrXVcifCK5QBtkoUHHOlxuDOsCpK/a01N67a91VPXifTaMNrbTcaQ+w0XkF3QDA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(8676002)(66446008)(66946007)(66556008)(76116006)(66476007)(4326008)(316002)(2906002)(508600001)(54906003)(110136005)(38100700002)(122000001)(99936003)(33656002)(86362001)(38070700005)(82960400001)(26005)(6506007)(7696005)(9686003)(186003)(71200400001)(8936002)(52536014)(55016003)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d1dvTXY4Uk9yZm4yNXBuS0wvUGZXUWJmSDZaeXBhcEdKU2xHS0F3dTFCZUFD?=
 =?utf-8?B?L2tRa3VmT29CaEkreFpZbk9CalMwcU4xMzIzSndzVGdnWGxHYmppL2F2dFND?=
 =?utf-8?B?UDRuNTFiendZVGpNMjR1Y1I5RkQ4azg4S01hUTZsMkY2R0FNSm5oeUpqVGds?=
 =?utf-8?B?WHMzRWtwYytITGxzNnp3UkVBd3BiQWh3b1MzQTN4d0RCZGxBUERSSXJ4WUN1?=
 =?utf-8?B?VktHR0VqMVJhZHR5RHdwclBkUHo3NXg1Y3BzSFpXNUNWaWgvc2xBOTJJMTZv?=
 =?utf-8?B?Rk12OVdqNjFkZkZWcWVpdEc4QW4wdkRTZ29xZkxuNzh0V09SaFNKLzdOQkMz?=
 =?utf-8?B?d2YzQitkdlp4Q0dhR0QvT0VXUVlIMnA1dmN2T0lqR3NjelNFWG5nRGZKMjY5?=
 =?utf-8?B?RHQ4R2E0NEpGZXRYSit3UlJYdzFZZlExNzJKZXZGVjUwdDh5K0Rhamk3Yjdp?=
 =?utf-8?B?OVlicUFIZXNoYmtqU3lMQ2h3T0xGalFDa2l0OVRjYVQvOTgrRXYvdXYwZXAw?=
 =?utf-8?B?NjNnRjZESDJwdGhiT2VLajB1a3FXTG1TV2RneUdrVDRZL1ZBU3VLOHl0Nnll?=
 =?utf-8?B?bnZFWTV3aXQ2UmR1WGJrKzFSTndzbHkrSmcwd0xxenhzMWx1dE1XY0xwUGRw?=
 =?utf-8?B?NEVBZEdqQWJsOHo1bWd5bUZqNWJ4MlhpaFZiUy9NYUlqemxyVzVKK3BjMEZm?=
 =?utf-8?B?V2NxV1NWZ2J1VEVlRHZBZUdVR3podktGZ3dFSlZoU21lVS9mendva3VwbHM5?=
 =?utf-8?B?bHpiaE5DWmNqdkpFbVEyemR1UDBvK3NGQ1VVSU53ejBnTUxWK1JVMm8wRmpt?=
 =?utf-8?B?OW14NFRkSU53di84YTBYRFg1ZnFQU01wMHFoN2RRaEtudFcxZXd2V0hnWUtj?=
 =?utf-8?B?OTB3eUpaZFo3ZHF5L2dlZFd3Um9UcnUvSVVyemVDQmRlcTNtamh4eDZyd3cy?=
 =?utf-8?B?MkozT3lwQzlIZHNQRFpUSUtHdTJYR3c4UUY2N3RycGZ5WHZhQU5HTUlIdmlu?=
 =?utf-8?B?dEduVEFnZFE0OU9CRk9Za0luT0JSSlRCWCtwVHZVa0J6bUduNG16cXMzV0F1?=
 =?utf-8?B?MTVKZUx4OUh5cGxoSkhyRFFZSjRaTjhia0RrM0xQcHBBMUxIZWJ5ZkVPL2Nl?=
 =?utf-8?B?NTZnNWk5RDVhYmd4d013SmczSWxrOGtDOEllOTR3aVNQSXpVWjRXU3VGUUlm?=
 =?utf-8?B?MW5oL1B0ZS9uc1g1QTRIa2x6WWNHMVQxTC94eDQzNmV1Q25BZm5ZbEZickRm?=
 =?utf-8?B?TER1L29INDFzQ0Ezc2w5MGp2RzQ3Q29TemVSdWRSWjJ6NkQ5Mit3cUdGZTJZ?=
 =?utf-8?B?OWpuWThHOU1hR1VEOGNyaTlkdnJySU9NK2pRQnhScDNQWTJRbFpLeTlyU0Yv?=
 =?utf-8?B?NDZ5U2hnd3VwbHBLT3M2cmJpNzA5ZTRHaFVONE04b0RrUTFaZWp5Zld0Qk1M?=
 =?utf-8?B?KyswdUZSUzhXai9ja0NyRUxyR2J3ZDBRejFVUGNXSE5IMVkyYjBiM2I3NVVL?=
 =?utf-8?B?K214Z2FKM2ppcjVNSmswbjh4NGdUQndieU9ZdE1SdXpkN1pHMExnWGlJT0hh?=
 =?utf-8?B?aTI3eVdRN3ZpR2xkVHBSYXZ0WkhKMGlpaVZJMkk1aVBxL0J4R1Q5QXh2T3FS?=
 =?utf-8?B?VG40NnFCdGZWb1JtYUt0bFFPZ2RBL0VGV1RCNWM4L3JEbFd1MTI4d3phcmli?=
 =?utf-8?B?cUM3UEY0eDRoYlUvNkVOVWtWNzgvTllVcnlNM1RMSEk0SzhDcUFIRnhJVkFo?=
 =?utf-8?B?dWRtS2JZdVNCa2x6RHd2V1FrMXB5SnJvZyt0M3JyaEtSWDN3dWVCK1JBYTlI?=
 =?utf-8?B?bEFCNEZ1RWFXbzUvOUNUY1lJc1pmVFpGeENUcWtVcmhtSU0zZ1paeWRkZmlI?=
 =?utf-8?B?enMvNk9NVk9JMDJkYVdEc2VIaDBzL1lYSi9TRDVlbGJTWmdhUzEzam1DQ1lG?=
 =?utf-8?B?T0VsRzVLSzBsNW5yejZPS2wrdElNWEdFQVE5OUppTGd6dkpnSElOV2Y2cVh1?=
 =?utf-8?B?aEMyc0hwSHB0Y0lCN3Jpa1BteXR3Z1B4d21PUTZBQjBHRXFLRURoeS9vZVV1?=
 =?utf-8?B?YmZKS29VUFRtK0hLK0xqbDBiT2hGWUVEb053bFovZzY4cnVjRFB1SG84WmFN?=
 =?utf-8?B?MXE2bWI1Z3pwRWMyekVXM0FzalBMUkovOWxpNktjNFpWNUhpWkRaQWIrZjVO?=
 =?utf-8?B?RmNLUXpSVWlBV0hvbmE0UHBaOUd6d2xZTXd0VzByTjVwZUlvQ21YY2pkNUlN?=
 =?utf-8?B?bERDemVTYkxLUjJqSlI5cWdKSzllckg0VFF4N0tUSlpESlkwQ1BEMUwwSngx?=
 =?utf-8?B?U0p0dVkvTkhIVWQreHlqMk1XcnYya2lxK3ZkdjcrTmgwSzNKeXJhZz09?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891C5C2430056F553BC51A681E39HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f8221b5-300a-41e4-f56d-08da1458c88d
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 03:27:57.9833
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9tvoFHmHKYYh9C/CUTjKx910KZRqn/JT0PB/wp4fHRtbwE13SWTqKyZiswSpGNOhMDj+h1+Waf5ZAp0lE2YHOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4173
X-Proofpoint-GUID: NxIz80PZGKzQyu6JXyB476jvfIgvPQkz
X-Proofpoint-ORIG-GUID: NxIz80PZGKzQyu6JXyB476jvfIgvPQkz
X-Sony-Outbound-GUID: NxIz80PZGKzQyu6JXyB476jvfIgvPQkz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-02_01,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=999
 spamscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204020018
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891C5C2430056F553BC51A681E39HK2PR04MB3891apcp_
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64

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
ZmF0ZW50LmMgfCA0MSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0K
IDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCg0KZGlm
ZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50LmMNCmluZGV4IGEz
NDY0ZTU2YTdlMS4uMDRlMTEyNmNlOTcxIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMN
CisrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5jDQpAQCAtNiw2ICs2LDcgQEANCiAjaW5jbHVkZSA8bGlu
dXgvc2xhYi5oPg0KICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+DQogI2luY2x1ZGUgPGxpbnV4
L2J1ZmZlcl9oZWFkLmg+DQorI2luY2x1ZGUgPGxpbnV4L2Jsa2Rldi5oPg0KIA0KICNpbmNsdWRl
ICJleGZhdF9yYXcuaCINCiAjaW5jbHVkZSAiZXhmYXRfZnMuaCINCkBAIC0yNzQsMTAgKzI3NSw5
IEBAIGludCBleGZhdF96ZXJvZWRfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmRpciwgdW5zaWduZWQg
aW50IGNsdSkNCiB7DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBkaXItPmlfc2I7DQogCXN0
cnVjdCBleGZhdF9zYl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQotCXN0cnVjdCBidWZmZXJf
aGVhZCAqYmhzW01BWF9CVUZfUEVSX1BBR0VdOw0KLQlpbnQgbnJfYmhzID0gTUFYX0JVRl9QRVJf
UEFHRTsNCisJc3RydWN0IGJ1ZmZlcl9oZWFkICpiaDsNCiAJc2VjdG9yX3QgYmxrbnIsIGxhc3Rf
YmxrbnI7DQotCWludCBlcnIsIGksIG47DQorCWludCBpOw0KIA0KIAlibGtuciA9IGV4ZmF0X2Ns
dXN0ZXJfdG9fc2VjdG9yKHNiaSwgY2x1KTsNCiAJbGFzdF9ibGtuciA9IGJsa25yICsgc2JpLT5z
ZWN0X3Blcl9jbHVzOw0KQEAgLTI5MSwzMCArMjkxLDIzIEBAIGludCBleGZhdF96ZXJvZWRfY2x1
c3RlcihzdHJ1Y3QgaW5vZGUgKmRpciwgdW5zaWduZWQgaW50IGNsdSkNCiAJfQ0KIA0KIAkvKiBa
ZXJvaW5nIHRoZSB1bnVzZWQgYmxvY2tzIG9uIHRoaXMgY2x1c3RlciAqLw0KLQl3aGlsZSAoYmxr
bnIgPCBsYXN0X2Jsa25yKSB7DQotCQlmb3IgKG4gPSAwOyBuIDwgbnJfYmhzICYmIGJsa25yIDwg
bGFzdF9ibGtucjsgbisrLCBibGtucisrKSB7DQotCQkJYmhzW25dID0gc2JfZ2V0YmxrKHNiLCBi
bGtucik7DQotCQkJaWYgKCFiaHNbbl0pIHsNCi0JCQkJZXJyID0gLUVOT01FTTsNCi0JCQkJZ290
byByZWxlYXNlX2JoczsNCi0JCQl9DQotCQkJbWVtc2V0KGJoc1tuXS0+Yl9kYXRhLCAwLCBzYi0+
c19ibG9ja3NpemUpOw0KLQkJfQ0KLQ0KLQkJZXJyID0gZXhmYXRfdXBkYXRlX2JocyhiaHMsIG4s
IElTX0RJUlNZTkMoZGlyKSk7DQotCQlpZiAoZXJyKQ0KLQkJCWdvdG8gcmVsZWFzZV9iaHM7DQor
CWZvciAoaSA9IGJsa25yOyBpIDwgbGFzdF9ibGtucjsgaSsrKSB7DQorCQliaCA9IHNiX2dldGJs
ayhzYiwgaSk7DQorCQlpZiAoIWJoKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KIA0KLQkJZm9yIChp
ID0gMDsgaSA8IG47IGkrKykNCi0JCQlicmVsc2UoYmhzW2ldKTsNCisJCW1lbXNldChiaC0+Yl9k
YXRhLCAwLCBzYi0+c19ibG9ja3NpemUpOw0KKwkJc2V0X2J1ZmZlcl91cHRvZGF0ZShiaCk7DQor
CQltYXJrX2J1ZmZlcl9kaXJ0eShiaCk7DQorCQlicmVsc2UoYmgpOw0KIAl9DQotCXJldHVybiAw
Ow0KIA0KLXJlbGVhc2VfYmhzOg0KLQlleGZhdF9lcnIoc2IsICJmYWlsZWQgemVyb2VkIHNlY3Qg
JWxsdVxuIiwgKHVuc2lnbmVkIGxvbmcgbG9uZylibGtucik7DQotCWZvciAoaSA9IDA7IGkgPCBu
OyBpKyspDQotCQliZm9yZ2V0KGJoc1tpXSk7DQotCXJldHVybiBlcnI7DQorCWlmIChJU19ESVJT
WU5DKGRpcikpDQorCQlyZXR1cm4gc3luY19ibG9ja2Rldl9yYW5nZShzYi0+c19iZGV2LA0KKwkJ
CQlFWEZBVF9CTEtfVE9fQihibGtuciwgc2IpLA0KKwkJCQlFWEZBVF9CTEtfVE9fQihsYXN0X2Js
a25yLCBzYikgLSAxKTsNCisNCisJcmV0dXJuIDA7DQogfQ0KIA0KIGludCBleGZhdF9hbGxvY19j
bHVzdGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2MsDQotLSAN
CjIuMjUuMQ0K

--_002_HK2PR04MB3891C5C2430056F553BC51A681E39HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="v2-0002-exfat-reduce-block-requests-when-zeroing-a-cluste.patch"
Content-Description: 
 v2-0002-exfat-reduce-block-requests-when-zeroing-a-cluste.patch
Content-Disposition: attachment;
	filename="v2-0002-exfat-reduce-block-requests-when-zeroing-a-cluste.patch";
	size=2985; creation-date="Sat, 02 Apr 2022 03:05:06 GMT";
	modification-date="Sat, 02 Apr 2022 03:27:57 GMT"
Content-Transfer-Encoding: base64

SWYgJ2RpcnN5bmMnIGlzIGVuYWJsZWQsIHdoZW4gemVyb2luZyBhIGNsdXN0ZXIsIHN1Ym1pdHRp
bmcKc2VjdG9yIGJ5IHNlY3RvciB3aWxsIGdlbmVyYXRlIG1hbnkgYmxvY2sgcmVxdWVzdHMsIHdp
bGwKY2F1c2UgdGhlIGJsb2NrIGRldmljZSB0byBub3QgZnVsbHkgcGVyZm9ybSBpdHMgcGVyZm9y
bWFuY2UuCgpUaGlzIGNvbW1pdCBtYWtlcyB0aGUgc2VjdG9ycyBpbiBhIGNsdXN0ZXIgdG8gYmUg
c3VibWl0dGVkIGluCm9uY2UsIGl0IHdpbGwgcmVkdWNlIHRoZSBudW1iZXIgb2YgYmxvY2sgcmVx
dWVzdHMuIFRoaXMgd2lsbAptYWtlIHRoZSBibG9jayBkZXZpY2UgdG8gZ2l2ZSBmdWxsIHBsYXkg
dG8gaXRzIHBlcmZvcm1hbmNlLgoKVGVzdCBjcmVhdGUgMTAwMCBkaXJlY3RvcmllcyBvbiBTRCBj
YXJkIHdpdGg6CgokIHRpbWUgKGZvciAoKGk9MDtpPDEwMDA7aSsrKSk7IGRvIG1rZGlyIGRpciR7
aX07IGRvbmUpCgpQZXJmb3JtYW5jZSBoYXMgYmVlbiBpbXByb3ZlZCBieSBtb3JlIHRoYW4gNzMl
IG9uIGlteDZxLXNhYnJlbGl0ZS4KCkNsdXN0ZXIgc2l6ZSAgICAgICBCZWZvcmUgICAgICAgICBB
ZnRlciAgICAgICBJbXByb3ZlbWVudAo2NCAgS0J5dGVzICAgICAgICAgM20zNC4wMzZzICAgICAg
MG01Ni4wNTJzICAgNzMuOCUKMTI4IEtCeXRlcyAgICAgICAgIDZtMi42NDRzICAgICAgIDFtMTMu
MzU0cyAgIDc5LjglCjI1NiBLQnl0ZXMgICAgICAgICAxMW0yMi4yMDJzICAgICAxbTM5LjQ1MXMg
ICA4NS40JQoKaW14NnEtc2FicmVsaXRlOgogIC0gQ1BVOiA3OTIgTUh6IHg0CiAgLSBNZW1vcnk6
IDFHQiBERFIzCiAgLSBTRCBDYXJkOiBTYW5EaXNrIDhHQiBDbGFzcyA0CgpTaWduZWQtb2ZmLWJ5
OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5jb20+ClJldmlld2VkLWJ5OiBBbmR5IFd1
IDxBbmR5Lld1QHNvbnkuY29tPgpSZXZpZXdlZC1ieTogQW95YW1hIFdhdGFydSA8d2F0YXJ1LmFv
eWFtYUBzb255LmNvbT4KLS0tCiBmcy9leGZhdC9mYXRlbnQuYyB8IDQxICsrKysrKysrKysrKysr
KysrLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgMTcgaW5zZXJ0aW9u
cygrKSwgMjQgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmF0ZW50LmMgYi9m
cy9leGZhdC9mYXRlbnQuYwppbmRleCBhMzQ2NGU1NmE3ZTEuLjA0ZTExMjZjZTk3MSAxMDA2NDQK
LS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMKKysrIGIvZnMvZXhmYXQvZmF0ZW50LmMKQEAgLTYsNiAr
Niw3IEBACiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPgogI2luY2x1ZGUgPGFzbS91bmFsaWduZWQu
aD4KICNpbmNsdWRlIDxsaW51eC9idWZmZXJfaGVhZC5oPgorI2luY2x1ZGUgPGxpbnV4L2Jsa2Rl
di5oPgogCiAjaW5jbHVkZSAiZXhmYXRfcmF3LmgiCiAjaW5jbHVkZSAiZXhmYXRfZnMuaCIKQEAg
LTI3NCwxMCArMjc1LDkgQEAgaW50IGV4ZmF0X3plcm9lZF9jbHVzdGVyKHN0cnVjdCBpbm9kZSAq
ZGlyLCB1bnNpZ25lZCBpbnQgY2x1KQogewogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBkaXIt
Pmlfc2I7CiAJc3RydWN0IGV4ZmF0X3NiX2luZm8gKnNiaSA9IEVYRkFUX1NCKHNiKTsKLQlzdHJ1
Y3QgYnVmZmVyX2hlYWQgKmJoc1tNQVhfQlVGX1BFUl9QQUdFXTsKLQlpbnQgbnJfYmhzID0gTUFY
X0JVRl9QRVJfUEFHRTsKKwlzdHJ1Y3QgYnVmZmVyX2hlYWQgKmJoOwogCXNlY3Rvcl90IGJsa25y
LCBsYXN0X2Jsa25yOwotCWludCBlcnIsIGksIG47CisJaW50IGk7CiAKIAlibGtuciA9IGV4ZmF0
X2NsdXN0ZXJfdG9fc2VjdG9yKHNiaSwgY2x1KTsKIAlsYXN0X2Jsa25yID0gYmxrbnIgKyBzYmkt
PnNlY3RfcGVyX2NsdXM7CkBAIC0yOTEsMzAgKzI5MSwyMyBAQCBpbnQgZXhmYXRfemVyb2VkX2Ns
dXN0ZXIoc3RydWN0IGlub2RlICpkaXIsIHVuc2lnbmVkIGludCBjbHUpCiAJfQogCiAJLyogWmVy
b2luZyB0aGUgdW51c2VkIGJsb2NrcyBvbiB0aGlzIGNsdXN0ZXIgKi8KLQl3aGlsZSAoYmxrbnIg
PCBsYXN0X2Jsa25yKSB7Ci0JCWZvciAobiA9IDA7IG4gPCBucl9iaHMgJiYgYmxrbnIgPCBsYXN0
X2Jsa25yOyBuKyssIGJsa25yKyspIHsKLQkJCWJoc1tuXSA9IHNiX2dldGJsayhzYiwgYmxrbnIp
OwotCQkJaWYgKCFiaHNbbl0pIHsKLQkJCQllcnIgPSAtRU5PTUVNOwotCQkJCWdvdG8gcmVsZWFz
ZV9iaHM7Ci0JCQl9Ci0JCQltZW1zZXQoYmhzW25dLT5iX2RhdGEsIDAsIHNiLT5zX2Jsb2Nrc2l6
ZSk7Ci0JCX0KLQotCQllcnIgPSBleGZhdF91cGRhdGVfYmhzKGJocywgbiwgSVNfRElSU1lOQyhk
aXIpKTsKLQkJaWYgKGVycikKLQkJCWdvdG8gcmVsZWFzZV9iaHM7CisJZm9yIChpID0gYmxrbnI7
IGkgPCBsYXN0X2Jsa25yOyBpKyspIHsKKwkJYmggPSBzYl9nZXRibGsoc2IsIGkpOworCQlpZiAo
IWJoKQorCQkJcmV0dXJuIC1FTk9NRU07CiAKLQkJZm9yIChpID0gMDsgaSA8IG47IGkrKykKLQkJ
CWJyZWxzZShiaHNbaV0pOworCQltZW1zZXQoYmgtPmJfZGF0YSwgMCwgc2ItPnNfYmxvY2tzaXpl
KTsKKwkJc2V0X2J1ZmZlcl91cHRvZGF0ZShiaCk7CisJCW1hcmtfYnVmZmVyX2RpcnR5KGJoKTsK
KwkJYnJlbHNlKGJoKTsKIAl9Ci0JcmV0dXJuIDA7CiAKLXJlbGVhc2VfYmhzOgotCWV4ZmF0X2Vy
cihzYiwgImZhaWxlZCB6ZXJvZWQgc2VjdCAlbGx1XG4iLCAodW5zaWduZWQgbG9uZyBsb25nKWJs
a25yKTsKLQlmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKQotCQliZm9yZ2V0KGJoc1tpXSk7Ci0JcmV0
dXJuIGVycjsKKwlpZiAoSVNfRElSU1lOQyhkaXIpKQorCQlyZXR1cm4gc3luY19ibG9ja2Rldl9y
YW5nZShzYi0+c19iZGV2LAorCQkJCUVYRkFUX0JMS19UT19CKGJsa25yLCBzYiksCisJCQkJRVhG
QVRfQkxLX1RPX0IobGFzdF9ibGtuciwgc2IpIC0gMSk7CisKKwlyZXR1cm4gMDsKIH0KIAogaW50
IGV4ZmF0X2FsbG9jX2NsdXN0ZXIoc3RydWN0IGlub2RlICppbm9kZSwgdW5zaWduZWQgaW50IG51
bV9hbGxvYywKLS0gCjIuMjUuMQoK

--_002_HK2PR04MB3891C5C2430056F553BC51A681E39HK2PR04MB3891apcp_--
