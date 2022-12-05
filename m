Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B18C3642280
	for <lists+linux-fsdevel@lfdr.de>; Mon,  5 Dec 2022 06:12:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiLEFMR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 5 Dec 2022 00:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231648AbiLEFLy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 5 Dec 2022 00:11:54 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E04313F10;
        Sun,  4 Dec 2022 21:11:30 -0800 (PST)
Received: from pps.filterd (m0209321.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2B544ADq000617;
        Mon, 5 Dec 2022 05:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=sgu6yPQ8lCayHzTODsx17It8x6n3yW2mxMZFTeqPLqM=;
 b=ZdEpSbvRQZbidrd0Y8HwuQt6QRwMLTWNH+bcq27NNYptiGrgCRSu2OywfX1O5WpRIxhD
 FHj1+WvIbbxOpO9Y3FV4r5lfdrIOhh/gsr3vYAkrw4kZ6khasmvMb68jkm8oWpI1kHSL
 nHVWG0Y/JfsljG7dDCkk6Q3Hy9ik5JyS5MeJObzVtlwYayisdU8GQ7eU1kx+/1NYF4KH
 j6xvYjU2FSCQnNov4+NmDImuQYnB8YMX/xGPiX9eiX0pqp/lp1mFrki7g4jNzSsY2iY0
 GIoFEBVZEmGc4lMQg39hIIfaSqIv7OdZRHxx611DBuIf/wXPbyAO87MDjJ8C+QfSPuKD Qw== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2049.outbound.protection.outlook.com [104.47.110.49])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3m7ycb1aj8-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 05 Dec 2022 05:11:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aNlwVsL0tpWDC97+lMCR+DIYqUAlmyQPXtatzyhONEsCtTk6ePEZLr4lhDlCbaW9+5W608Hp6dYYkd7GC0YvhaAiSUs1VwESf1yxI6nzfWUlS0TggmC8XF2nc9Fq+Z4kb5vpV4MyUScNh91AXvc/UL7mvIdCNEZ1nUdZMc44QIzJv5xG1NgCzuugsxIcA2bp3C4FFWHUQBKSlxtApUOWCyyRWQP4nmBtZo1c47/s9rxu1iwtUe8+To+IuItsDzTOE7dgW4GoHlMa+5eVLSevbzvVW/Q1zKwehr6kVEiwnwRYZvdQ8wY64FKdFh9OcNKGdcQeKrwVNoWJi6+H9ydmyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgu6yPQ8lCayHzTODsx17It8x6n3yW2mxMZFTeqPLqM=;
 b=F8ofg05qVNuhUi0HqThynO1rLmoItAaeNbHwa6U+K3ifCs4bo6Ggt6q2BzzJ+KbM2fKHtug9WMUOYbx6BVNJ7koS7HsCmcu/o3tVFgZLkDrCayJ4r6AENZNOCP3hCGihszh/wt7Vz2xlRFYqZrt6ekv//X8z1cqEHqlFnNZhWhSAG1ehW0DswU05Egz3dq+So+pB0TOccbt6nKCNH7fPWwvkzHHcZ1ex+ucN/MOQ964pCkoNe8j6VGPWgsvLBHKqWff6oeIFWouUViZhAe5F+cyKEGoPzKLfcr8pA4EWK+wrsSMS33H6pbgzT3aKsA9ZWyQDFD8gGgZT05TNitLVrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by HKAPR04MB4035.apcprd04.prod.outlook.com (2603:1096:203:dc::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5880.13; Mon, 5 Dec
 2022 05:10:00 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%6]) with mapi id 15.20.5880.008; Mon, 5 Dec 2022
 05:10:00 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v1 1/6] exfat: remove call ilog2() from exfat_readdir()
Thread-Topic: [PATCH v1 1/6] exfat: remove call ilog2() from exfat_readdir()
Thread-Index: AdkIZagE89nZwe4ETVe4ZwLM5E9ACQ==
Date:   Mon, 5 Dec 2022 05:10:00 +0000
Message-ID: <PUZPR04MB6316CFE354C531596F4C2A2881189@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|HKAPR04MB4035:EE_
x-ms-office365-filtering-correlation-id: 2c122c58-b7c9-403d-43c2-08dad67ef5b8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: rYDqkSuVYkd6EVySXyn+ShRUV4063dZUnoVFoK/D2TF+4FOt678RLKKb3kh7PcHJW6ooLJ0Xp5gVIqDNlI5p9qZHEgVJMNzvIHBqMimn8cJa40ybvcUCLu3J3FM/6zf+p52vnN7piwP7NdzeOyJv8ND0iE+f2J6neKgHmFxEzJXFxEWPJSSEcbF1jXUSG4FCUFtX/GAUfLWw9IHDQt3kWB75QAfAaD9hWJ8DTwx5n712xELCk1JPZHNgd5sfYLyIvVojdL9xfqDNfFi9ONZm/DdPhTK7rqO179quFkRNQTkqxVaubXHPY9OqdCFr9Fgu63I/D3SR137tovG4PrLaehQ37idhok0bIEUiga16vUzWurlqzfNFO7DY1cDnYf9aAk24uTRekDi7AyWnalxT2f4fCP9sf9cEzmoaEjbaf0jJ83ZeDmoynOsppULZVrGhs4HR7BRRrtyrxBRhGIOJfubZoJi0NzSvWdOJ0FH0C4sIdLnuSz2+KDYNhCfNE5yAd4rpeQy5NSiXuME4wY2bB9eFGfvwNcysdWv9Az+Dzku7BICm31dxVvfgqtAi7Z28zui4cQpmiTi7WF8E9JEv0J1azsdtEm1CiQvJkgt9CevK1XcibFSC4rm9Q5d6JPk0o+evGn8H+VG7ZvyIz3lyeC8E6JkAkJ0k/cRCN9HjHU3IVpHUB6/XMRIj12GAddrHFWJa4Z6kZfU+lOIMcpp7WQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(346002)(366004)(396003)(451199015)(33656002)(82960400001)(2906002)(122000001)(41300700001)(8936002)(186003)(52536014)(5660300002)(38100700002)(86362001)(83380400001)(38070700005)(55016003)(54906003)(66446008)(110136005)(316002)(66476007)(66556008)(64756008)(71200400001)(76116006)(4326008)(8676002)(478600001)(107886003)(7696005)(66946007)(26005)(9686003)(6506007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SnZsd1A1RzFibTFKSnRJSk9xZ05yMDhGRDZwcUZTUE9iVGUxVVdzWlVFd1I5?=
 =?utf-8?B?V3FSaFRpOWJWelBTdG44bVRISzhSZFBCTTlKZ0NMZDRyUzB4MjkxTTJ6em40?=
 =?utf-8?B?OGlCUzlvTCt1OEthYVlpSTk5TC9SSUdVdzlUbEtielhjTmo2K254RXJ0RXRH?=
 =?utf-8?B?ZUhhZVJTMmpYbXkvMWNVTWh3RWkrVWFxQ2RMR0luejRDUTR2MGVzdkNnbktE?=
 =?utf-8?B?Z2JKL0NSK0JKSmVtcStLTUx5Y3NwbmNhUXIwV01CNzY5TTE2WFpYYytIblY0?=
 =?utf-8?B?OWtjTVZDWjczWU9FRW9rK2VLWlI4QzhNT09sVDJCOEhOUFJUQ0hTd1lsUVNJ?=
 =?utf-8?B?bmpTSXh5NHNTOXROQWpUSXlZZlVRdHR2Q3NBdy85aENkNHY4cFFCSVlQM040?=
 =?utf-8?B?ZHRrQTREazNVNVMrSmcvUFBNR0IvcEF2WUduREFnNElNYTZGZmQ0UUN2M3Zw?=
 =?utf-8?B?SEpyNlZEMldMNDFrdDNlQmRXVFhHZ1ZjSlI1aFdFWGRiMDQyVVlMWVByU3Jw?=
 =?utf-8?B?Uko4UGJmZGRJY3BXcm5ES25GekdjRmRIY1g0U2hCQVpjTzYxelNIM1NjZUlN?=
 =?utf-8?B?VmIwc01jbVlhSlcrVUovRmxOblpaVjI5azIwUVRrcnp5N0R0N1FUVTlmK1NJ?=
 =?utf-8?B?WnAydG1UVG40Zy9zY000aXIwcXQ2OXE3bUFmTkd5YW5DaHp4UTJKN2xOU0sr?=
 =?utf-8?B?azUwN09JbEJGNUw5VDAyUCt3ZEEzMXFrWFVRUlN5Ky94NW1LbWxFc2Iwd0Fy?=
 =?utf-8?B?WDU1TnAyTWhCQXFGaGlGZGRtS3V4ZGt2WmpGTm0xWGxoZnpCVzNNaFQrNzJO?=
 =?utf-8?B?RGtERmFXQUt0eThRZytIMGwzUGJPUlA3T2dMWmJ1RXI1b2hWRTlZU20vY0hx?=
 =?utf-8?B?ekNrd3hEQTlwcHJlQit6aFFSM2Njckl3N2ljeGtTaThVL2pWRUdBVklZbW5x?=
 =?utf-8?B?RitsQ2FwRFVxTitQYjFGbjRGM0JlZkhLMmhLQ3NXdEtzdlpkaXl4QXhLQmFH?=
 =?utf-8?B?bG14TmhsNXo5Yk5RdjJCM0VGNExNK3pTQ0lHajA3QzdyM1dsK2JmQVVSQXdR?=
 =?utf-8?B?RTdrYVhBWm90ZElvVUdHMzQ1akZZRGQ2SHlJb01IZUFBdmtjdkNhdXBvZnVL?=
 =?utf-8?B?TzZyVVBKNDQwK2Q1YkVVOUZPYWMxeHpETlFVVWJhK2xJcGZkUHZ0cGJBKzYv?=
 =?utf-8?B?MVVxKzR3L0ZFZEJHbmlSdTJYc3g5dElZbzVITHl2eVAyeU5xWWxEbVlaY0U4?=
 =?utf-8?B?V1VpL21nSDI1Sm8rVU5OMXhCNnA3U0IxQTdMMktXK0haVFM5YWJ2YTRXQ1lJ?=
 =?utf-8?B?bFFHTW9VOFRnOENLNmZrUWdlbFh5SGpCS3ljS1NnOEpRcnBocncrK2tIK1Nv?=
 =?utf-8?B?ZysweXhhY0E5bXkvT2tLTTFITXM2eHZ4a25NdFZWQlpaeWthdzZGQzVjakRG?=
 =?utf-8?B?U0V5Q1BnenozWXBobTJhRVE4SHJnc3pMRDZ3YkxwQmtNQ3poc2haVGdwdmhj?=
 =?utf-8?B?M0hEblJ2NWZWOWJHT3E4YlNpS0g1S1U2Y2V5Ty90aUhUZEdoamJBSS9ZTU84?=
 =?utf-8?B?ZXpzVk1BdVhCQU5nYU42c25KcVk2a1diSzlYaXB0c0hWbkNnZGdpU3VSdk16?=
 =?utf-8?B?UzZQNEV1eWJSZzlSRVhDWHNLbERkSm5lSm42V1BiQXJOSnlDSndJNHRlUFJv?=
 =?utf-8?B?SEtEaVozWElxaFYwb2ZKK3FLTUQ3U1ljSSs0UTdvUk9WckFSREhKV2d4dWUr?=
 =?utf-8?B?ZU1HdzliM2x3SGtLQnhLVzY2YWJmWlJWYlN0Vm5FZlhoU2t5LytMdERQaGNz?=
 =?utf-8?B?R3d0MG14TVZtNEJBUDNUSTFSWVRuWmsvajhjWXZiaWs0MDdyRlJNbnpweFJo?=
 =?utf-8?B?STBGMlJacTh5cUFBTEcrRlRndk9JNVRBTWZWUGJqNWJ6cG9Xem1OWUEzUzhR?=
 =?utf-8?B?alV1aTFadDloallCVUZLb0UrUEFKVHJ1aVdSdFFWQ2txdm5OaDZKNXB0RlpO?=
 =?utf-8?B?bHlxNHBySUt4V1VZSElUZ0tHdXVJTkdzd3NBOEwxRS8raU9iVE9NbW5hQmhP?=
 =?utf-8?B?YVVIcjNmT2NoMVh2VXVzMmo5MDRxM2VIYWpONjM5ZDlRSE9rV0JmSzVoNXpo?=
 =?utf-8?Q?m7z7oDXx28t9a/zuqxSYLKVFs?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 5qF60nQq3jhlvZmweg8VeO7NsSoDqf+sSHVHZRMHpD7rLQBPnTtqzZm1T4zofip03dlEi4Tx2oXO8v92Mb9sQ6x6cMu+MubratWcB+s6zNNWqeO3dZT4VVvj53sST1HjhGrLs0gq86CG05nWUydbGF8qzoVKwxlS3NQbDtXNVYzfnsVK+Yyn+35VIOL2GjN51CpMAPiwIv69bxweBbpoZO1uqatkgtZwy5oGqqvYg6sctSjcdhA/o9MR/pyT7gFpMoJzMfyIGBGVhpHTmBnzTn7Ioa73aTecB/MdcfGsEKde8EqE2dRFlJ6eJIOfr+qqAauCmzsCzB3MpFRE/wVOTXXLtC4wqpaUA9j0p8GPp+d7FEfImoE+jGVVt/7FVHn3lQWbBduKBJhDnQ232Xt+s7Rb6QJ2FWsNq4CaDnTii7TUl9Q4CTkCyfsZRvYrJtFbuIbYL/45I1SrgzgmYsWZJXwKKOsjHe7ujrRHF3/6H0iUsLok1bckiBSLXbuyCxs71Cr+w9SkPJX0s/B97MyV2BP1uakDOJIia+ZVJ9Q1kmczyzhABDqfx3XqxOv209y1dl4KwKEA+IZbHVX2zfGjA6AaMnsCtaDE60RKYNokXVICSfNqux94Gh5iSsl1rIk5g2cBdSXStdEu0r8+JJqzBzgjN0vXEzFTeNhsq7vEqevPl20jdy+6A9KHmY1C/aSkcVWn+cW+P6M6uG2pRPUOm3J4lG7M5DDaE+GNjXJVZJuZ7yKsP2s+iyGieZjM73oa3H30eYtYy2JI/Iurawb7My/ca5+e1KLk4phb+OQyC0q+MtmM2sHdHw07VIz+q18lyLoZi/3BKC8LIgyReALZnCIwLYbR3l+ALkWZowv/eqrM79KLqrF48jELP8MWheiJ
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c122c58-b7c9-403d-43c2-08dad67ef5b8
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Dec 2022 05:10:00.2595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: my17+UVvlbVWw8iGR9BffwN7cF5eYUguTixFZz72hYefoxyt1Rr5biGQbIMaUheK9F077MKWrI6v64fQ2y5e+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HKAPR04MB4035
X-Proofpoint-ORIG-GUID: 6RS2H4Y59rOtN1htMyceAIpqss5IQGyi
X-Proofpoint-GUID: 6RS2H4Y59rOtN1htMyceAIpqss5IQGyi
X-Sony-Outbound-GUID: 6RS2H4Y59rOtN1htMyceAIpqss5IQGyi
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

VGhlcmUgaXMgbm8gbmVlZCB0byBjYWxsIGlsb2cyKCkgZm9yIHRoZSBjb252ZXJzaW9ucyBiZXR3
ZWVuDQpjbHVzdGVyIGFuZCBkZW50cnkgaW4gZXhmYXRfcmVhZGRpcigpLCBiZWNhdXNlIHRoZXNl
IGNvbnZlcnNpb25zDQpjYW4gYmUgcmVwbGFjZWQgd2l0aCBFWEZBVF9ERU5fVE9fQ0xVKCkvRVhG
QVRfQ0xVX1RPX0RFTigpLg0KDQpDb2RlIHJlZmluZW1lbnQsIG5vIGZ1bmN0aW9uYWwgY2hhbmdl
cy4NCg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1vQHNvbnkuY29tPg0K
UmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQpSZXZpZXdlZC1ieTogQW95
YW1hIFdhdGFydSA8d2F0YXJ1LmFveWFtYUBzb255LmNvbT4NCi0tLQ0KIGZzL2V4ZmF0L2Rpci5j
ICAgICAgfCAgOSArKysrLS0tLS0NCiBmcy9leGZhdC9leGZhdF9mcy5oIHwgMTAgKysrKysrKyst
LQ0KIDIgZmlsZXMgY2hhbmdlZCwgMTIgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0K
ZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2Rpci5jIGIvZnMvZXhmYXQvZGlyLmMNCmluZGV4IGMwNTQ5
M2ZjOTEyNC4uMzk3ZWEyZDk4ODQ4IDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvZGlyLmMNCisrKyBi
L2ZzL2V4ZmF0L2Rpci5jDQpAQCAtNjEsNyArNjEsNyBAQCBzdGF0aWMgdm9pZCBleGZhdF9nZXRf
dW5pbmFtZV9mcm9tX2V4dF9lbnRyeShzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLA0KIC8qIHJlYWQg
YSBkaXJlY3RvcnkgZW50cnkgZnJvbSB0aGUgb3BlbmVkIGRpcmVjdG9yeSAqLw0KIHN0YXRpYyBp
bnQgZXhmYXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgKmNwb3MsIHN0cnVj
dCBleGZhdF9kaXJfZW50cnkgKmRpcl9lbnRyeSkNCiB7DQotCWludCBpLCBkZW50cmllc19wZXJf
Y2x1LCBkZW50cmllc19wZXJfY2x1X2JpdHMgPSAwLCBudW1fZXh0Ow0KKwlpbnQgaSwgZGVudHJp
ZXNfcGVyX2NsdSwgbnVtX2V4dDsNCiAJdW5zaWduZWQgaW50IHR5cGUsIGNsdV9vZmZzZXQsIG1h
eF9kZW50cmllczsNCiAJc3RydWN0IGV4ZmF0X2NoYWluIGRpciwgY2x1Ow0KIAlzdHJ1Y3QgZXhm
YXRfdW5pX25hbWUgdW5pX25hbWU7DQpAQCAtODMsMTEgKzgzLDEwIEBAIHN0YXRpYyBpbnQgZXhm
YXRfcmVhZGRpcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCBsb2ZmX3QgKmNwb3MsIHN0cnVjdCBleGZh
dF9kaXJfZW50DQogCQkJRVhGQVRfQl9UT19DTFUoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmkpLCBl
aS0+ZmxhZ3MpOw0KIA0KIAlkZW50cmllc19wZXJfY2x1ID0gc2JpLT5kZW50cmllc19wZXJfY2x1
Ow0KLQlkZW50cmllc19wZXJfY2x1X2JpdHMgPSBpbG9nMihkZW50cmllc19wZXJfY2x1KTsNCiAJ
bWF4X2RlbnRyaWVzID0gKHVuc2lnbmVkIGludCltaW5fdCh1NjQsIE1BWF9FWEZBVF9ERU5UUklF
UywNCi0JCQkJCSAgICh1NjQpc2JpLT5udW1fY2x1c3RlcnMgPDwgZGVudHJpZXNfcGVyX2NsdV9i
aXRzKTsNCisJCQkJKHU2NClFWEZBVF9DTFVfVE9fREVOKHNiaS0+bnVtX2NsdXN0ZXJzLCBzYmkp
KTsNCiANCi0JY2x1X29mZnNldCA9IGRlbnRyeSA+PiBkZW50cmllc19wZXJfY2x1X2JpdHM7DQor
CWNsdV9vZmZzZXQgPSBFWEZBVF9ERU5fVE9fQ0xVKGRlbnRyeSwgc2JpKTsNCiAJZXhmYXRfY2hh
aW5fZHVwKCZjbHUsICZkaXIpOw0KIA0KIAlpZiAoY2x1LmZsYWdzID09IEFMTE9DX05PX0ZBVF9D
SEFJTikgew0KQEAgLTE2Miw3ICsxNjEsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X3JlYWRkaXIoc3Ry
dWN0IGlub2RlICppbm9kZSwgbG9mZl90ICpjcG9zLCBzdHJ1Y3QgZXhmYXRfZGlyX2VudA0KIAkJ
CWRpcl9lbnRyeS0+ZW50cnkgPSBkZW50cnk7DQogCQkJYnJlbHNlKGJoKTsNCiANCi0JCQllaS0+
aGludF9ibWFwLm9mZiA9IGRlbnRyeSA+PiBkZW50cmllc19wZXJfY2x1X2JpdHM7DQorCQkJZWkt
PmhpbnRfYm1hcC5vZmYgPSBFWEZBVF9ERU5fVE9fQ0xVKGRlbnRyeSwgc2JpKTsNCiAJCQllaS0+
aGludF9ibWFwLmNsdSA9IGNsdS5kaXI7DQogDQogCQkJKmNwb3MgPSBFWEZBVF9ERU5fVE9fQihk
ZW50cnkgKyAxICsgbnVtX2V4dCk7DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZXhmYXRfZnMuaCBi
L2ZzL2V4ZmF0L2V4ZmF0X2ZzLmgNCmluZGV4IDMyNGFjYzU3ZDAyOS4uMzdlOGFmODA0MmFhIDEw
MDY0NA0KLS0tIGEvZnMvZXhmYXQvZXhmYXRfZnMuaA0KKysrIGIvZnMvZXhmYXQvZXhmYXRfZnMu
aA0KQEAgLTEwMSwxMSArMTAxLDE3IEBAIGVudW0gew0KIC8qDQogICogaGVscGVycyBmb3IgYmxv
Y2sgc2l6ZSB0byBkZW50cnkgc2l6ZSBjb252ZXJzaW9uLg0KICAqLw0KLSNkZWZpbmUgRVhGQVRf
Ql9UT19ERU5fSURYKGIsIHNiaSkJXA0KLQkoKGIpIDw8ICgoc2JpKS0+Y2x1c3Rlcl9zaXplX2Jp
dHMgLSBERU5UUllfU0laRV9CSVRTKSkNCiAjZGVmaW5lIEVYRkFUX0JfVE9fREVOKGIpCQkoKGIp
ID4+IERFTlRSWV9TSVpFX0JJVFMpDQogI2RlZmluZSBFWEZBVF9ERU5fVE9fQihiKQkJKChiKSA8
PCBERU5UUllfU0laRV9CSVRTKQ0KIA0KKy8qDQorICogaGVscGVycyBmb3IgY2x1c3RlciBzaXpl
IHRvIGRlbnRyeSBzaXplIGNvbnZlcnNpb24uDQorICovDQorI2RlZmluZSBFWEZBVF9DTFVfVE9f
REVOKGNsdSwgc2JpKQlcDQorCSgoY2x1KSA8PCAoKHNiaSktPmNsdXN0ZXJfc2l6ZV9iaXRzIC0g
REVOVFJZX1NJWkVfQklUUykpDQorI2RlZmluZSBFWEZBVF9ERU5fVE9fQ0xVKGRlbnRyeSwgc2Jp
KQlcDQorCSgoZGVudHJ5KSA+PiAoKHNiaSktPmNsdXN0ZXJfc2l6ZV9iaXRzIC0gREVOVFJZX1NJ
WkVfQklUUykpDQorDQogLyoNCiAgKiBoZWxwZXJzIGZvciBmYXQgZW50cnkuDQogICovDQotLSAN
CjIuMjUuMQ0K
