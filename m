Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B77A4EFE2D
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Apr 2022 05:30:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbiDBDby (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 23:31:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231599AbiDBDbw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 23:31:52 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 067CBCBE5F;
        Fri,  1 Apr 2022 20:29:58 -0700 (PDT)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2323Hr7W026715;
        Sat, 2 Apr 2022 03:29:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=hQXIRGmCyn6tUmKqYaiCo7guocWWVhAlIoNO50/Yrqk=;
 b=ZQrTNcyQxxobsSIp3vXg/N40pQ3QLvlVzhQbuqxvhDGvUAXyMvIvkaFf9UB+Z8LOPgiD
 gWU0+cJRGyL0FYsj4fmshuWiGWA2bhLgm6o7gBlME4z20j4YdLkrOAPGzS9VNQy9uSc/
 8fpCUw3fEvT4wCPZ7367G9S3XsFcQ5sJ7k9JD2JTUtnqumUrmMELH0rAZlj2bkCuwZsy
 HtnPpdaC1grT4beCQ3cPgGmgo9bgziSuFawMWqZl/VKiSHzPNYCXzIKKb1QhEL9Vb6/f
 cjvLOZmLgpPyNzhpl/Sp7GCQ81h+aBOwUYOZpdPs9Uh1AQnlQQjtS1HHxJrWU8sq8fAc 4g== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2046.outbound.protection.outlook.com [104.47.26.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f6dbyr13h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 02 Apr 2022 03:29:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SsdmwsbOJJ6/uCZUQnOwrHds6DVRfzBciNtrSVdHNRn8t8lZhuv6Qvv49lnyD1OgDWxFezpS6B0SIDWdlMtKYOnkxH3TcrVSPW1Rx64X3O2NvY/nBCczvRtSk1arUmytu+FIN05+R3FpJdnhaYKtPMgSvC8YohyWyq28GjiQSJInYgsV/0zAC9YafVmVj+J848J5SsotTAy7zGlFjkX1Ih/6Tv87l44OfIwBLLDH8APBsokGeVIOLNoY+JLpaMwpzL27BypevxdlwyLA9KwrgMMZdzILpA4DUA5umMrlaIMcxg57ikBwtTw4DV0Gb+O1y6siqfWtTydK90fZIquZcQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hQXIRGmCyn6tUmKqYaiCo7guocWWVhAlIoNO50/Yrqk=;
 b=By89JS1J/nm5dmiC4rBTDdlb0K8DehtadjS5SFaVDZne/v8dSj4lc3jnuAC5s+224EhM3dM1hnLCNFMxFQHGxTFicJH6HN5yvwh+iHgFTKrhvtSnJSkQPVgLtFN/b7sEwHA1lq6bVPNm19GwSdu30yCNS7zsuxVXu6B07CVQimjpCD78h7daUC6ESZnz0FMtGaxPqESSFnO0SNHzDbzKA1xsocZrPHvvTzDo8Dev6YEfQCO9QlS4uP6M4pxOlDapvRsj91kUJJonIoHx2j6N3TJRhDyAX4iYEc+7/CbF+/USOTzqP3PbvCesMm2bAeQNfSEPClfdedtkLIjJfpHKpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB4173.apcprd04.prod.outlook.com (2603:1096:400:2e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.30; Sat, 2 Apr
 2022 03:27:56 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5123.030; Sat, 2 Apr 2022
 03:27:56 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH v2 0/2] exfat: reduce block requests when zeroing a cluster
Thread-Topic: [PATCH v2 0/2] exfat: reduce block requests when zeroing a
 cluster
Thread-Index: AdhGP+ySCsRd0v01QNmJExY4ZV3yxA==
Date:   Sat, 2 Apr 2022 03:27:56 +0000
Message-ID: <HK2PR04MB38916A5D693D52FF1C2FD24781E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1f3ae67e-f73c-4ee9-b9cf-08da1458c768
x-ms-traffictypediagnostic: TYZPR04MB4173:EE_
x-microsoft-antispam-prvs: <TYZPR04MB41733128648985486741034481E39@TYZPR04MB4173.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MZupO8o9bHZSCUJmuVOYc+FmFeFebhivQYlmQrR5u/zllUahmGN6RqgNX0dvCiN+zI9IZa725YP+IUGvhB0M4l4A0lNOOjgAp20kIDExE1UIfY17wSsLvdOjL9xKIEEL6+aCNoLw0Scf1M4rJ3Y8t0h5UAdvZgcRjB3XhEYBUH4g7vMSjlJHdHNllAndIB/xJSXQvdqoBFGbA675QwFgLPu4NW7cBZDzZRpNLBBWr3qsvExSso2iiaDPIuY4jkHky6UN6bK51T6glgDeXgaJY4rrqDoVgxXlQ0Bq34ZQuISz4zuV6ewCq1y+X8D9WjcUrUtSLTASb9uf40b96DKx3x3uF5lmYYH047UixZHUvlgSBdUqYFYOainO2LU4Sp5u7aiQALfWNUDlL9hznH5XgdNetvVdYz/8xtheuNNb4P6lEMNAjqmi7fmfXayA+VzXEXM0hupYbOHAVBB3S6cmr93Sc2v6xLOhtQCHx5UJR7La5Krofws8rP/2MDEkZ3Ec6Xp+AaQNFtRrQKZCu6KrvCv9chI6wVTvkp9/WZginTfpctUJqhIqtbKgJP1bJsncGT4U/dwFIohUU8mw7IO2Y7R/it+htafsjhD4xs6rwrutVMBskLV9VWb3SBxsrfekFIuAwcIUBufgUHOFSbTjfy2KvTD1VZw1IJNrYoLdvdvCVl0qjtwkh17gKJgHADpEwLIWSI0hEUZT0J8F20iOKA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(64756008)(8676002)(66446008)(66946007)(66556008)(76116006)(66476007)(4326008)(316002)(2906002)(508600001)(54906003)(110136005)(38100700002)(122000001)(33656002)(86362001)(38070700005)(82960400001)(26005)(6506007)(7696005)(9686003)(186003)(71200400001)(8936002)(4744005)(52536014)(55016003)(5660300002)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZDhROEpGVkZFWG9uSGdqVTI4RlNDbDYyQkEvWUx5LytsaFJHRmpycVhEdHB0?=
 =?utf-8?B?eVQ4VkxMUWdCTHVpMlpBekRRMXVUZ1cxdkJBVnljdDF1VUVaMFkwVWthdytK?=
 =?utf-8?B?YzdmMGZWSmZBa1hqdEsxTllmUEZZWmRoa0ZhQjFRSFFYam9HTCsyMzlpRXZt?=
 =?utf-8?B?NWpTem1vZ0hsbjlacVZIRTNXWXI1ZjV0L2FlQ1FETjBNYnErSlJMa0czRDl3?=
 =?utf-8?B?SW1LMStuU2E1K2wvdVBNNkJQRHI0MnRGNHlMejR3ZHh6WDlKa2RjL0hkREI1?=
 =?utf-8?B?bW92S3VtYXptRjhoY0F0WDhwbmViemluL29XcnlhT1Fkb2RxVlRZNERiZy9n?=
 =?utf-8?B?VHJ3cUo3SXBLRHhHaWtpYkl2V2c3RExrcEpnaTlSNkVHSm1tV0ZNT2VaZ3pi?=
 =?utf-8?B?b2JnbGVlWENKaXczTzdXQnUxWmJwV01KNnhvWmdnOHU4YjFmM0QwRlZ6SkFh?=
 =?utf-8?B?Y0JDTVRPak9LWk5XbXRrOStBY3p1UlEzRWs1R1NBQ1lxWEg1N2R3c25JNFRQ?=
 =?utf-8?B?M1ZubXF3TWUwTGZWY0k5aWRNMFFld2JGbkNnZHFPdWd3U3RLYVc5UG9sZXVL?=
 =?utf-8?B?eG9pRkx6dzhHMWYvQjRzN1EyUklCTHpIOUJ4UGw2cGV0LzZZODVNTnFOZnZB?=
 =?utf-8?B?Nk1YTmVKZ283N0E0akFLRmgyNTBvN0UzakhKTzVvRVplY1NoNVdjSzFJbnJM?=
 =?utf-8?B?NTljVzVOTzZBNUJ4Y1VjVVJLdFhkbFlJWHozTUUyWEdTNXdpeVNOK3hmenY1?=
 =?utf-8?B?NmllMWFJQStDaHRub2dkejlKa3p0bzJoZ21jUDNDYitRWkNOdEZkclVVL25p?=
 =?utf-8?B?K0VVTGYveEFkcUpUTWE5cjNKWDlWZXhCTVprd0VmNHJaa1V5NnIxTGdVNis1?=
 =?utf-8?B?Tm1FenBTa1BycXY0R3dwT0hPcldRUWo3N1RXL08vMmQ1VHN6QVhvazI0VHZL?=
 =?utf-8?B?dWRIQWlYZ1JJeW50dEQ4R0NPVTlycGJPTUlQd3U5REd3NysvTVB2L1laMUNX?=
 =?utf-8?B?ZjNsMm1hOFRwblJLYXErN1BUREw4c2t5VHJBNGdDOVJ3NC9McUVoVDZRb1kr?=
 =?utf-8?B?YWZ1OHl6MGxZK1h6M3JLOGdyRjdHK0VjMThpZ2N1QkhvcnRFMnBhSTg0Vjc4?=
 =?utf-8?B?N044V0I2eDd4Y0MxNzlyYXNtOHIzb0l6SEcySG9aZGovczFCdERHZitqZTha?=
 =?utf-8?B?TVc0WHNiM2tmTmVndy9BeG42UzNCaHpqLzloRUg4RUJicWNLNUE0TU5GQVpW?=
 =?utf-8?B?NGV2RVNEOWJaeUozMFlMVUtNYWZmWm01MENmWkpUbDkzbmNUQkRqUFU2R2lG?=
 =?utf-8?B?MndiMEFJSFU2VTYxVTBCU29KWUprUDRoVUdIV21iUEVxckdCVEROMVQ2cHh2?=
 =?utf-8?B?elkzR28vbGc2VnNlT1NMQ1RPUUVuVUJEc2UzRnVHV3p5R3VhUGI4WWtVdUY5?=
 =?utf-8?B?M2NYM3dZcEl0dUFSaXhUL2Rlc1FJQU42NHJxNTBrZmRVVkhtQ2lwQVgyNm1a?=
 =?utf-8?B?SFJrMVRUYUlmbW1wODFCMS9PMDFFQmQvdEwvM2x5citKWlErOXNUSWNCMjdS?=
 =?utf-8?B?d2NXYXNjRUpGMXVDYmZ2RkM2OWJZQzhsb1Bic1lIc3l2VHh5SjVjOEwzcUtj?=
 =?utf-8?B?eWgzMjVBZmt6OXo2ZU1YYTd5NjF3NUFMa2preDRGcFc3RGI5bEdZVmFrc2RX?=
 =?utf-8?B?c2xSQzk0Slg0a3c5dmdPM25EVmg2K2VxTURkZWNFY2xyWnBhUGpQNVpLQURD?=
 =?utf-8?B?ZTZST2RQSnliYWhZOE1PSEVXMjNpRXZ5RENiSVVZZEVzS1UzdGg3bXlIRDZJ?=
 =?utf-8?B?SDFkWkxma0d1RW1MdXFLdW9DS2FuMjE4eGRoNndHeWZ5aUtCZmZ5bjFVUzFz?=
 =?utf-8?B?VmhXbEVZQmI2S3NYc2ZLbDRzMmF0WmZzSnhvY1RhcWVpUXh3dVp4WXJ1VUt5?=
 =?utf-8?B?T0ltaXZvbXNFU2lZY0tvNGJ5eUorNFpXZ0FISExSVThSV2JsclVwb3R2b2Zv?=
 =?utf-8?B?SjNHYmh6WWtpOWs2dklMZmMxZTJVekl4WUdSd0ZXallhZHR4a21sMEdqVWVy?=
 =?utf-8?B?eHo4dWJCQ3U2V3phZHR6T2krTjMycnRVZVUwT0ZSb0gxVjdZYjVxVEo2SmVk?=
 =?utf-8?B?NTByS2J3VmU5NFFsUmgzZHRoUXlyTkpBTGEvR1ZiTnY3N1VTNk10aTV6SDh1?=
 =?utf-8?B?MHFBQzN5S2VidFpySGxGRnlEWHk1OXRBcFA5ZkxVQm16TzUvL1JoNmFRclMv?=
 =?utf-8?B?SlRqdGZ5V3dOMklrNTNTalVaOGdXSWpFWTBaOEJndUNYMERjYnQvOUlxS0Nh?=
 =?utf-8?B?bUFWU3BEMmIwNVM0VTV0b1VGSVRva25OcDBGZG01Mk1RSkVaLy9sUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f3ae67e-f73c-4ee9-b9cf-08da1458c768
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Apr 2022 03:27:56.0615
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mt9XW6MCtdsGB1nzf6lUMsDG12pk38f7eWmjE9m7jRJBBkBdoQo6Z22I2o9Me8zaz2UnGWa8mgmOF+D9cu7z6A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB4173
X-Proofpoint-GUID: 94PNkdInN9SSgs3lGW-v-VZNzmyTFzIB
X-Proofpoint-ORIG-GUID: 94PNkdInN9SSgs3lGW-v-VZNzmyTFzIB
X-Sony-Outbound-GUID: 94PNkdInN9SSgs3lGW-v-VZNzmyTFzIB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-02_01,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=920
 spamscore=0 clxscore=1011 priorityscore=1501 suspectscore=0 malwarescore=0
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

Q2hhbmdlcyBzaW5jZSB2MToNCi0gQWRkZWQgaGVscGVyIHRvIGJsb2NrIGxldmVsIGluc3RlYWQg
b2YgbWFudWFsIGFjY2Vzc2luZyBiZF9pbm9kZQ0KICBmcm9tIHRoZSBmaWxlc3lzdGVtIGFzIHN1
Z2dlc3RlZCBieSBDaHJpc3RvcGggSGVsbHdpZw0KDQpZdWV6aGFuZyBNbyAoMik6DQogIGJsb2Nr
OiBhZGQgc3luY19ibG9ja2Rldl9yYW5nZSgpDQogIGV4ZmF0OiByZWR1Y2UgYmxvY2sgcmVxdWVz
dHMgd2hlbiB6ZXJvaW5nIGEgY2x1c3Rlcg0KDQogYmxvY2svYmRldi5jICAgICAgICAgICB8IDEw
ICsrKysrKysrKysNCiBmcy9leGZhdC9mYXRlbnQuYyAgICAgIHwgNDEgKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCiBpbmNsdWRlL2xpbnV4L2Jsa2Rldi5oIHwgIDYg
KysrKysrDQogMyBmaWxlcyBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCAyNCBkZWxldGlvbnMo
LSkNCg0KLS0gDQoyLjI1LjENCg==
