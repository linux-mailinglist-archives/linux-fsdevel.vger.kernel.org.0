Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F4E4F8CD8
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Apr 2022 05:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233884AbiDHDLQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 7 Apr 2022 23:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233810AbiDHDLG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 7 Apr 2022 23:11:06 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F30EB1760CE;
        Thu,  7 Apr 2022 20:09:02 -0700 (PDT)
Received: from pps.filterd (m0209326.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2382kRDj008391;
        Fri, 8 Apr 2022 03:08:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : mime-version; s=S1;
 bh=0krr7e9nrzxJOPqIh4uE9P3WM/AXnl7MPvIRxZA70Os=;
 b=DVLUkUudwJ7wCt0V3mFL9EZTd3zABDOjw97XsnwxDBxo5o34YJnCeBXxZzLi3BC9T+Z5
 sshxY894FMCDhDoxKmlhwAfF8ew7qpbzwFiUT0rXHsdMOh8MTuaRBxIWULuNWmGCqGx1
 5pEyVR4Uxp0Ey3YjS38Kbl2dHmdlMcmyU9t9RUZ+eG62bcp4FFtTBSVd8BtFYrqopYBx
 2apm+awQXI+1cTxPjeISoBo5X32RQtif/O+8zluvOx+XlLWmzD69Nx8/snF88vkCk4nC
 JOWLDX2D4OVN90KM6rp46TZ2WXF4c+dvciYkcSppdSC9ImoOGleEawEUZOyg8teZN77J ew== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2046.outbound.protection.outlook.com [104.47.110.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f8yhgjfuf-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 08 Apr 2022 03:08:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Vmbiq4Yy81P+IiWp1GKacpT9DmmS5ni9pUeybmT7KGDHEklzSLO7SDrUBJWEnRMgCESguYT8yreQdcH1JX+1FpjAptKzEbARDueCAcRXT20XaRjK5JLx6KVXwlS23g16WSFZA6COu7cS9J0VDaPFztl9idfFI9netmRMZQu3c62xP8NPgdkFuQLO8hETbfMwA425l6WZ07onExweeJG9Tat/C4/eOkL15ozAc5cxYUe0eGByF+SWZ6kgJglOUVRp8lwjZbVzd4dVecNEIBi3PadhxEWxqCIUfquUKIidw5y6wUYTxtvWvbB/Zst15tiz9ilvYrQJ4RvgbF9RKiL2pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0krr7e9nrzxJOPqIh4uE9P3WM/AXnl7MPvIRxZA70Os=;
 b=EMW8D5hJka3LCBYt5zvwpjEwhU9ynS7I/Y2HQv+HjeEJpmD4Vmtyru/oUMdIm4QXbEbCDlT6orZmErWhj38tphE5UUttmmfTLjERszpb1eH/OBNpqo/gL3DMsybmUCHuNxL3l/pQATBCkbnMqyN1ulSpjZ5WBmNZx3z9MWwNW1E+YD7l5TvYvRr0g7ZrDEdDKC4aqKHQMIYwtP+F93Es4irz7rUJFnqv5P4Y3xwmTOQNUNc7K2aXkojPZAQCXykFW68876aOP94rWye4JCrJucqM7Q/r+aqtunWFFYtHfEMFQZJnQpm+BVgTJ0uVWgL0BGnTJuc4VE7FIcxPhp0l7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by SG2PR04MB3866.apcprd04.prod.outlook.com (2603:1096:4:a3::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.22; Fri, 8 Apr
 2022 03:07:41 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5144.022; Fri, 8 Apr 2022
 03:07:41 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v3 2/2] exfat: reduce block requests when zeroing a cluster
Thread-Topic: [PATCH v3 2/2] exfat: reduce block requests when zeroing a
 cluster
Thread-Index: AdhK9YQZ0JQytWEmS0yTn9FT+MKl5w==
Date:   Fri, 8 Apr 2022 03:07:41 +0000
Message-ID: <HK2PR04MB3891810F91CA920960EE7C4F81E99@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: baf56c2d-8dea-4f1e-dafe-08da190cf1dc
x-ms-traffictypediagnostic: SG2PR04MB3866:EE_
x-microsoft-antispam-prvs: <SG2PR04MB38668D0C138D92CBFC1A856B81E99@SG2PR04MB3866.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sYS7NdcW3Hab95su6fFgYfFKLhvDHY255j3L3Wd17NB7M8VKw25jGxvApcC6HCTP6/93DoxpnwhtFwCZ93lN7wdQ8Xj9+gl6Rz5jRBNCgoaSz3Q3UsMgNUTfmCERXR1hybGvf/YGZWO6ZgVFMjQRgQkBvMZJuv79Ljmv2l8pTUiG6ebRSODXIpP/qjkiCCuM5nDcA82uJOqUq9EkqhZodnL2aiLU9yXJc77iisbpoBxcngLNMmjJp/rEomdoVSu32UYrO3K2v0xklm9jPVkHJ65Pq80is532Aw7DoJiJeY9Jg7TDvlf3Yv3g2zC+avC0/jsuAwLPez9yw6oNwnqao5TxqIuS+Q7WhJsNh5B7AmrUjzkorSfgDxHKOW3ix57N1IW3PsFXJHoYABXL40c3Hqs3edo75PYbO5dvrn9ecaxrXUxHrOrvRYb/x3Of5fMsmh2TsV7vP0DHUW7c/iMGRn93nUMuyx0seyHCr2mddG0xAtEbIc0FKFH1VW04EgsX099hKHz51k68/xzVV87QSt+PLo+hghy5dkjyVk1nSOfr18Q11Gk8WqcCU3XVE6YOa/xBvS7W5RousU5fKjWNCVuwuoyaxj+oUzq1GnDSCquZsLxhhCx2BwJ2Tgi4CGQ72+1H5aeSVzCu8mSDsOHOixcdjjvSkMXbmujwr8hPt+N7IhxNwzo66NqRSLv0QRYlgjXcjGGyXPwY+YgvIhALYw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(83380400001)(7696005)(6506007)(52536014)(71200400001)(82960400001)(5660300002)(33656002)(8936002)(38070700005)(2906002)(508600001)(86362001)(99936003)(55016003)(9686003)(54906003)(186003)(26005)(122000001)(38100700002)(110136005)(316002)(76116006)(4326008)(66556008)(66476007)(66446008)(64756008)(66946007)(8676002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aWVhbDE3dTdScWFjREJvRXpiSTc1S0RTbjIvelhZeUFTWlRVMEVPZkh3YU5R?=
 =?utf-8?B?aXorK3dPMGNNenJiZ3Q3bWs3cTBwaSthVk1odE41Zm5aNWY4WFFmV3VxUlF3?=
 =?utf-8?B?cStxOVRUblM4Y2ZKSHIzUkt1QXlrWjNIRW5KRVdlOTZ2bVRHcVdaUzRGVzhz?=
 =?utf-8?B?amxuVFZMa2hBY2JsdGxVVlVwUjhmcWg1LzdyWVB6UERtNENWaC9zakRuZVpH?=
 =?utf-8?B?T1plZlNDbSs5eFdjUHl4TXFnQjllQnVsbmlJV2U4M3lTTnZLTGtsYU41dnZ1?=
 =?utf-8?B?T2NEc3V3R3cvM2QralFxY1pNQXc3bk5PSFBYZy9WeGc5NGFWdEdnUHdOUkJ4?=
 =?utf-8?B?QlpWK2dvd2R6dDZ6Z2NQUC8zM3hPVUtkNFpaS21FZWZIaFlRd05IaGkzK0t6?=
 =?utf-8?B?VTR1bjNFRko2aGl5bDV1ZWxPaldjTXNxdVVNbWRTSGdUZkc0VkJmNXhZSUMv?=
 =?utf-8?B?RW5penVpR3VDdEFUY3dudEVZOWZkOHhLemJTbDgraFZhc0NPWW5rOHdqTmZx?=
 =?utf-8?B?NHJobUNnU2dacURGWCt1QUd3UytpQXlwRUxvRnI1alV1bjhEQkwxWXIxQ0dn?=
 =?utf-8?B?VGdmUkZadGNCK0Nta0R1Uk80S3NNY0ZjVHFFM3ZsMHdDT2syTDUyMWhkVGlY?=
 =?utf-8?B?MmtRcE9Sc05BNTFDZ0JNWmhWUXhlNk5HKzNBSmNsRUN2K0FCWW9id25TN3ZL?=
 =?utf-8?B?KzZyL3NXUVlJaDRPMjRIQStIU1E5Wk8vZUN6ODg5WWUwU3R4S0hNQ1VueGQ2?=
 =?utf-8?B?V2E1VldRM1hpSE5EZ1daT1VZOStpaDcrT2QrQVBDSVprcmxwTm9iQkk1VWVn?=
 =?utf-8?B?THdOanVDK3Z3T21NRHdCOVBEdXF6VVBlL29oV0t1VzRuUy9wa0VLaXVFYU4v?=
 =?utf-8?B?emxxc2EzdmVaR25NSjg0VWo4U1VHSXdEcTlIVDV1b1U4ZDVPamdoUHpwemNP?=
 =?utf-8?B?RVFSRXVGNFBFZDBhTVlERHpJRmYzVmgyWDFkN25nbUwyNDFzSFJ5OE14SHN5?=
 =?utf-8?B?c2hWcTdJbHQ0QTZqZVlhSFp3U3JCaGZ0diswV243UU1KaU5ibVRxR0xvMDNT?=
 =?utf-8?B?KzQzb0ljUEhKWEZwTk5KZGEya1phMVN2Myt4VDZxWDErQkdHcVIxaXRrTUZw?=
 =?utf-8?B?VmRNeDA2OWZXZWlTR3JUVk12amNqTk44ZTV4WFZIZzhhTjEwK3c5WW1Hc3ZC?=
 =?utf-8?B?bEQ2NzhCNTZMdy9WY0w0cWw1cVpSNEkvaU1tTGROWm1GVlhVT3lzZTZDaWdl?=
 =?utf-8?B?K3dlQitKNGIvYUVYOUJ3cTl2SVBSRW0wZzJHcndwNTZGeWp3S0xqMzA4WE5x?=
 =?utf-8?B?cC9FbE5YL2N4bVNjb2NvMGZWRUowWkpiUitrdmp6bTR1V0FiMUZNeTBOaXUy?=
 =?utf-8?B?MnU0SHlkKzBCMksvbDZaa2toL1dxOVFNbmlMclNMbnZRSmllOEM1blI2RmtJ?=
 =?utf-8?B?a0dZS0trQ1FsbXhWWjNCSWNMand3dzFDb2l0QzRpY2EvWUhuR1Q4Y0NPc1da?=
 =?utf-8?B?c0p5UDhyUUUybXB6eVZDQmFuUTBJNmNkaVF3QzA3eGZVYit2cEhmMHZ3aE9N?=
 =?utf-8?B?Y1VLZ3YrMXZaN2NWVEZNVzRpOElFM1ZSSHR2eUR1QlY4U3BtYlpKUkFvNVF2?=
 =?utf-8?B?V2xYTjUyYVVuRisxYndjcVAzd3l5aGFldmZBQzh5aFByUEo2ak5ZeTlJSklT?=
 =?utf-8?B?a0xPY1FjRzVHTGI2cXcrQ2ttaFJseHFBOFV2anNoUzFBZW9TN3g4MTRpZy9X?=
 =?utf-8?B?Z0VHRm1VVmlnZWE2dUhSWmNNK0lpalBmbVhTTkNWcDA5dVlmK29GaVNFbUQx?=
 =?utf-8?B?bFo3dXZaR01NamVmczBTNFZDaVdzeHJ5OHF3VmdaM3VWNmRPbHVSdG1sTENv?=
 =?utf-8?B?Zi84MGhQTllITnFxb1FYVFM1ZXF5b01Md0NSenFGVnhjQXVsSUpZaTUvd0ZJ?=
 =?utf-8?B?RkNQR0EzWnd0SU9tM1ZSYTBYNUNYcXgwdTBhdGRySGNISjNrMEdwRE1ocDQ0?=
 =?utf-8?B?RC9mblZjaGg0MFZpVG5LcEhhN0dnZkxhZDFwTVczc0hVZXNMdDk3aUJYR1hN?=
 =?utf-8?B?a1ZQT1MzQjVPazRzemlMVmpGdjRxNEFDUThHRElUL0RPYlJyYU9OV1hoemVJ?=
 =?utf-8?B?bmNmOW40czIxVFljU0pnWjNPLzZIbmR4dmNCTWhoMS9jS0Z5UmpQRXhDekI4?=
 =?utf-8?B?Y1FGMHlpN3VtWmY5Nm4vV2VYNFFhUThFVmlyVll3a1Q1SE0wRGJTZzRNTWdN?=
 =?utf-8?B?LzZBS0M1UVVSWUtDaXQ2TllwcCtOSU9IVEt2cVJuMUdwSWhkcm8zWVRxanZa?=
 =?utf-8?B?ZUpCVXExZzNLeDEvd0xCN2tRNVdCME5wSEtMQmw2MCtLZ2NhWDljZz09?=
Content-Type: multipart/mixed;
        boundary="_002_HK2PR04MB3891810F91CA920960EE7C4F81E99HK2PR04MB3891apcp_"
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: baf56c2d-8dea-4f1e-dafe-08da190cf1dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Apr 2022 03:07:41.3962
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Wrk6lSGFdIo4BmvzTUOsOJGzeXI50rEPG1Y4y0K5/82j5BL2Qkqekgrh41klNxKXSjSED/hELyRCeY9IbEYWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR04MB3866
X-Proofpoint-GUID: tLklq7rBgPtmX-nt0DBHn8LQr12_UJ32
X-Proofpoint-ORIG-GUID: tLklq7rBgPtmX-nt0DBHn8LQr12_UJ32
X-Sony-Outbound-GUID: tLklq7rBgPtmX-nt0DBHn8LQr12_UJ32
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-08_01,2022-04-07_01,2022-02-23_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--_002_HK2PR04MB3891810F91CA920960EE7C4F81E99HK2PR04MB3891apcp_
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
OiBBb3lhbWEgV2F0YXJ1IDx3YXRhcnUuYW95YW1hQHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IENo
cmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRlPg0KLS0tDQogZnMvZXhmYXQvZmF0ZW50LmMgfCA0
MSArKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KIDEgZmlsZSBjaGFu
Z2VkLCAxNyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2Zz
L2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhmYXQvZmF0ZW50LmMNCmluZGV4IGEzNDY0ZTU2YTdlMS4u
MDRlMTEyNmNlOTcxIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZmF0ZW50LmMNCisrKyBiL2ZzL2V4
ZmF0L2ZhdGVudC5jDQpAQCAtNiw2ICs2LDcgQEANCiAjaW5jbHVkZSA8bGludXgvc2xhYi5oPg0K
ICNpbmNsdWRlIDxhc20vdW5hbGlnbmVkLmg+DQogI2luY2x1ZGUgPGxpbnV4L2J1ZmZlcl9oZWFk
Lmg+DQorI2luY2x1ZGUgPGxpbnV4L2Jsa2Rldi5oPg0KIA0KICNpbmNsdWRlICJleGZhdF9yYXcu
aCINCiAjaW5jbHVkZSAiZXhmYXRfZnMuaCINCkBAIC0yNzQsMTAgKzI3NSw5IEBAIGludCBleGZh
dF96ZXJvZWRfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmRpciwgdW5zaWduZWQgaW50IGNsdSkNCiB7
DQogCXN0cnVjdCBzdXBlcl9ibG9jayAqc2IgPSBkaXItPmlfc2I7DQogCXN0cnVjdCBleGZhdF9z
Yl9pbmZvICpzYmkgPSBFWEZBVF9TQihzYik7DQotCXN0cnVjdCBidWZmZXJfaGVhZCAqYmhzW01B
WF9CVUZfUEVSX1BBR0VdOw0KLQlpbnQgbnJfYmhzID0gTUFYX0JVRl9QRVJfUEFHRTsNCisJc3Ry
dWN0IGJ1ZmZlcl9oZWFkICpiaDsNCiAJc2VjdG9yX3QgYmxrbnIsIGxhc3RfYmxrbnI7DQotCWlu
dCBlcnIsIGksIG47DQorCWludCBpOw0KIA0KIAlibGtuciA9IGV4ZmF0X2NsdXN0ZXJfdG9fc2Vj
dG9yKHNiaSwgY2x1KTsNCiAJbGFzdF9ibGtuciA9IGJsa25yICsgc2JpLT5zZWN0X3Blcl9jbHVz
Ow0KQEAgLTI5MSwzMCArMjkxLDIzIEBAIGludCBleGZhdF96ZXJvZWRfY2x1c3RlcihzdHJ1Y3Qg
aW5vZGUgKmRpciwgdW5zaWduZWQgaW50IGNsdSkNCiAJfQ0KIA0KIAkvKiBaZXJvaW5nIHRoZSB1
bnVzZWQgYmxvY2tzIG9uIHRoaXMgY2x1c3RlciAqLw0KLQl3aGlsZSAoYmxrbnIgPCBsYXN0X2Js
a25yKSB7DQotCQlmb3IgKG4gPSAwOyBuIDwgbnJfYmhzICYmIGJsa25yIDwgbGFzdF9ibGtucjsg
bisrLCBibGtucisrKSB7DQotCQkJYmhzW25dID0gc2JfZ2V0YmxrKHNiLCBibGtucik7DQotCQkJ
aWYgKCFiaHNbbl0pIHsNCi0JCQkJZXJyID0gLUVOT01FTTsNCi0JCQkJZ290byByZWxlYXNlX2Jo
czsNCi0JCQl9DQotCQkJbWVtc2V0KGJoc1tuXS0+Yl9kYXRhLCAwLCBzYi0+c19ibG9ja3NpemUp
Ow0KLQkJfQ0KLQ0KLQkJZXJyID0gZXhmYXRfdXBkYXRlX2JocyhiaHMsIG4sIElTX0RJUlNZTkMo
ZGlyKSk7DQotCQlpZiAoZXJyKQ0KLQkJCWdvdG8gcmVsZWFzZV9iaHM7DQorCWZvciAoaSA9IGJs
a25yOyBpIDwgbGFzdF9ibGtucjsgaSsrKSB7DQorCQliaCA9IHNiX2dldGJsayhzYiwgaSk7DQor
CQlpZiAoIWJoKQ0KKwkJCXJldHVybiAtRU5PTUVNOw0KIA0KLQkJZm9yIChpID0gMDsgaSA8IG47
IGkrKykNCi0JCQlicmVsc2UoYmhzW2ldKTsNCisJCW1lbXNldChiaC0+Yl9kYXRhLCAwLCBzYi0+
c19ibG9ja3NpemUpOw0KKwkJc2V0X2J1ZmZlcl91cHRvZGF0ZShiaCk7DQorCQltYXJrX2J1ZmZl
cl9kaXJ0eShiaCk7DQorCQlicmVsc2UoYmgpOw0KIAl9DQotCXJldHVybiAwOw0KIA0KLXJlbGVh
c2VfYmhzOg0KLQlleGZhdF9lcnIoc2IsICJmYWlsZWQgemVyb2VkIHNlY3QgJWxsdVxuIiwgKHVu
c2lnbmVkIGxvbmcgbG9uZylibGtucik7DQotCWZvciAoaSA9IDA7IGkgPCBuOyBpKyspDQotCQli
Zm9yZ2V0KGJoc1tpXSk7DQotCXJldHVybiBlcnI7DQorCWlmIChJU19ESVJTWU5DKGRpcikpDQor
CQlyZXR1cm4gc3luY19ibG9ja2Rldl9yYW5nZShzYi0+c19iZGV2LA0KKwkJCQlFWEZBVF9CTEtf
VE9fQihibGtuciwgc2IpLA0KKwkJCQlFWEZBVF9CTEtfVE9fQihsYXN0X2Jsa25yLCBzYikgLSAx
KTsNCisNCisJcmV0dXJuIDA7DQogfQ0KIA0KIGludCBleGZhdF9hbGxvY19jbHVzdGVyKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2MsDQotLSANCjIuMjUuMQ0K

--_002_HK2PR04MB3891810F91CA920960EE7C4F81E99HK2PR04MB3891apcp_
Content-Type: application/octet-stream;
	name="v3-0002-exfat-reduce-block-requests-when-zeroing-a-cluste.patch"
Content-Description: 
 v3-0002-exfat-reduce-block-requests-when-zeroing-a-cluste.patch
Content-Disposition: attachment;
	filename="v3-0002-exfat-reduce-block-requests-when-zeroing-a-cluste.patch";
	size=3029; creation-date="Fri, 08 Apr 2022 03:05:35 GMT";
	modification-date="Fri, 08 Apr 2022 03:07:41 GMT"
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
eWFtYUBzb255LmNvbT4KUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxoY2hAbHN0LmRl
PgotLS0KIGZzL2V4ZmF0L2ZhdGVudC5jIHwgNDEgKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCAyNCBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9leGZhdC9mYXRlbnQuYyBiL2ZzL2V4ZmF0L2ZhdGVu
dC5jCmluZGV4IGEzNDY0ZTU2YTdlMS4uMDRlMTEyNmNlOTcxIDEwMDY0NAotLS0gYS9mcy9leGZh
dC9mYXRlbnQuYworKysgYi9mcy9leGZhdC9mYXRlbnQuYwpAQCAtNiw2ICs2LDcgQEAKICNpbmNs
dWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8YXNtL3VuYWxpZ25lZC5oPgogI2luY2x1ZGUg
PGxpbnV4L2J1ZmZlcl9oZWFkLmg+CisjaW5jbHVkZSA8bGludXgvYmxrZGV2Lmg+CiAKICNpbmNs
dWRlICJleGZhdF9yYXcuaCIKICNpbmNsdWRlICJleGZhdF9mcy5oIgpAQCAtMjc0LDEwICsyNzUs
OSBAQCBpbnQgZXhmYXRfemVyb2VkX2NsdXN0ZXIoc3RydWN0IGlub2RlICpkaXIsIHVuc2lnbmVk
IGludCBjbHUpCiB7CiAJc3RydWN0IHN1cGVyX2Jsb2NrICpzYiA9IGRpci0+aV9zYjsKIAlzdHJ1
Y3QgZXhmYXRfc2JfaW5mbyAqc2JpID0gRVhGQVRfU0Ioc2IpOwotCXN0cnVjdCBidWZmZXJfaGVh
ZCAqYmhzW01BWF9CVUZfUEVSX1BBR0VdOwotCWludCBucl9iaHMgPSBNQVhfQlVGX1BFUl9QQUdF
OworCXN0cnVjdCBidWZmZXJfaGVhZCAqYmg7CiAJc2VjdG9yX3QgYmxrbnIsIGxhc3RfYmxrbnI7
Ci0JaW50IGVyciwgaSwgbjsKKwlpbnQgaTsKIAogCWJsa25yID0gZXhmYXRfY2x1c3Rlcl90b19z
ZWN0b3Ioc2JpLCBjbHUpOwogCWxhc3RfYmxrbnIgPSBibGtuciArIHNiaS0+c2VjdF9wZXJfY2x1
czsKQEAgLTI5MSwzMCArMjkxLDIzIEBAIGludCBleGZhdF96ZXJvZWRfY2x1c3RlcihzdHJ1Y3Qg
aW5vZGUgKmRpciwgdW5zaWduZWQgaW50IGNsdSkKIAl9CiAKIAkvKiBaZXJvaW5nIHRoZSB1bnVz
ZWQgYmxvY2tzIG9uIHRoaXMgY2x1c3RlciAqLwotCXdoaWxlIChibGtuciA8IGxhc3RfYmxrbnIp
IHsKLQkJZm9yIChuID0gMDsgbiA8IG5yX2JocyAmJiBibGtuciA8IGxhc3RfYmxrbnI7IG4rKywg
YmxrbnIrKykgewotCQkJYmhzW25dID0gc2JfZ2V0YmxrKHNiLCBibGtucik7Ci0JCQlpZiAoIWJo
c1tuXSkgewotCQkJCWVyciA9IC1FTk9NRU07Ci0JCQkJZ290byByZWxlYXNlX2JoczsKLQkJCX0K
LQkJCW1lbXNldChiaHNbbl0tPmJfZGF0YSwgMCwgc2ItPnNfYmxvY2tzaXplKTsKLQkJfQotCi0J
CWVyciA9IGV4ZmF0X3VwZGF0ZV9iaHMoYmhzLCBuLCBJU19ESVJTWU5DKGRpcikpOwotCQlpZiAo
ZXJyKQotCQkJZ290byByZWxlYXNlX2JoczsKKwlmb3IgKGkgPSBibGtucjsgaSA8IGxhc3RfYmxr
bnI7IGkrKykgeworCQliaCA9IHNiX2dldGJsayhzYiwgaSk7CisJCWlmICghYmgpCisJCQlyZXR1
cm4gLUVOT01FTTsKIAotCQlmb3IgKGkgPSAwOyBpIDwgbjsgaSsrKQotCQkJYnJlbHNlKGJoc1tp
XSk7CisJCW1lbXNldChiaC0+Yl9kYXRhLCAwLCBzYi0+c19ibG9ja3NpemUpOworCQlzZXRfYnVm
ZmVyX3VwdG9kYXRlKGJoKTsKKwkJbWFya19idWZmZXJfZGlydHkoYmgpOworCQlicmVsc2UoYmgp
OwogCX0KLQlyZXR1cm4gMDsKIAotcmVsZWFzZV9iaHM6Ci0JZXhmYXRfZXJyKHNiLCAiZmFpbGVk
IHplcm9lZCBzZWN0ICVsbHVcbiIsICh1bnNpZ25lZCBsb25nIGxvbmcpYmxrbnIpOwotCWZvciAo
aSA9IDA7IGkgPCBuOyBpKyspCi0JCWJmb3JnZXQoYmhzW2ldKTsKLQlyZXR1cm4gZXJyOworCWlm
IChJU19ESVJTWU5DKGRpcikpCisJCXJldHVybiBzeW5jX2Jsb2NrZGV2X3JhbmdlKHNiLT5zX2Jk
ZXYsCisJCQkJRVhGQVRfQkxLX1RPX0IoYmxrbnIsIHNiKSwKKwkJCQlFWEZBVF9CTEtfVE9fQihs
YXN0X2Jsa25yLCBzYikgLSAxKTsKKworCXJldHVybiAwOwogfQogCiBpbnQgZXhmYXRfYWxsb2Nf
Y2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1bnNpZ25lZCBpbnQgbnVtX2FsbG9jLAotLSAK
Mi4yNS4xCgo=

--_002_HK2PR04MB3891810F91CA920960EE7C4F81E99HK2PR04MB3891apcp_--
