Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0D5A65E31A
	for <lists+linux-fsdevel@lfdr.de>; Thu,  5 Jan 2023 03:58:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229746AbjAEC6M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 4 Jan 2023 21:58:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjAEC6J (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 4 Jan 2023 21:58:09 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F21244364;
        Wed,  4 Jan 2023 18:58:06 -0800 (PST)
Received: from pps.filterd (m0209327.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 304NNw06029174;
        Thu, 5 Jan 2023 02:57:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=5N9JmxjPdUjuu1UTMYcLIEk+Rf3+aA0PTzb6wV6paDw=;
 b=gK3p+/CpFlyjGmAZiwWygNpYYaSCUngUItfFqVppIQcKd32UV9MEoo8kqR+gtRK5cpss
 1yW6Y0M0rwFiavt5s76RWuMIZaVtNofXwJOX/l9vy8tCbCNGDRM5Yfwi43FW8myNWAjD
 SfwsqUAt3fTeWpYRxHcmVYz/ZgW5IuH2G+0TxGN0IyCihkpSS7WlWvE6oP3Ybk/30dZN
 xSXio+v4kq3PLLkBicxMhHqUR7UWYsDN8qnFmRvJwwGPeCANO59HFGaLdDnI7+TeqQax
 SkLxWunPGw+LI2YH4oEZEhndXVl1V4hCn6QWiZf8iuNCNEB5zOZMTod/rOaZLf3KyHmZ Bg== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2042.outbound.protection.outlook.com [104.47.110.42])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mtby1c36q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Jan 2023 02:57:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TMPpUZ7h5DDIxqe9dTwG7GGEm1JuXOAmO7BVNGh0UM+T51Oh8jWZ3QosW6gzOpeOj4oTqAjuPpfPAzQY19Lcfg4t7SBdTBOhBFbVPsWm/7zt9mVts+OtPog0x8/de/rRhROP1Ie3IKVr0GNLlC4folbG4eHjGdekvYX8G3zegy+IqAJoEiTClGSYxOK0PKteXtK5EgXdopm0Qbqwj6QvhQ7fBa7JSAywMG/urU8zD8O3aYr3Q3PpmUINE3xKRIFH6C62SdrZ9v8xhBxVP8sU7wOJ7Uab65bHkwdB7HqpQhW3ycG5+Zn2QZy3pyYTPrxv5YjgtUD5H0W+M51AOefyvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5N9JmxjPdUjuu1UTMYcLIEk+Rf3+aA0PTzb6wV6paDw=;
 b=JMQgeWBFZAzsDQmVfa9AiFH8SEkzVnbBF4s5KeLZapRMsqvxdTj9ViYlbhtwPUrBpZFqa5HU2O7pROv4uC94LMuUiEvXIcAxPJhcycXA7CCt/hAIFnaWS2SxhMIvE/gSYw09Wy0fcHujlNTb1HRN8CY051fXwqtauWKP1aWelAAsNRPkSb6YigUUyDlR6LH2ei2Cv9IAluJW6VUHkHo5wFNQvpBG3L71zXVphWfUy8hfZuS7wtp3TtC06ghv/3FhZUaL61p/P6U7tvocxOGApfGLhBGd3HaKXSwKK0kb6S6ciW3N/AeBlZCj6YEcGrEh7M4VpA0oaYPxnAfoisvuBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4453.apcprd04.prod.outlook.com (2603:1096:301:30::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.14; Thu, 5 Jan
 2023 02:56:50 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%7]) with mapi id 15.20.5986.009; Thu, 5 Jan 2023
 02:56:50 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Wang Yugui <wangyugui@e16-tech.com>
Subject: [PATCH v1] exfat: fix inode->i_blocks for non-512 byte sector size
 device
Thread-Topic: [PATCH v1] exfat: fix inode->i_blocks for non-512 byte sector
 size device
Thread-Index: AdkgsPfQiYBCZ5ikRJGUYBPhyntvuQ==
Date:   Thu, 5 Jan 2023 02:56:50 +0000
Message-ID: <PUZPR04MB63164CCF8EF35EA79461676881FA9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4453:EE_
x-ms-office365-filtering-correlation-id: 50856df9-2636-47e6-646f-08daeec87e22
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: CL/cNRMVVP9T+S4287cKjnH6QGb2YztxT0QbdAHNJaa/7dlHf5i9/vZ+ZSSR8JzEPO1t/eE3Eg2GbTD0KIMrwiGlmnCLAhLRiVPEEq9vjKezD7fVHJlJIdOz6/n1M8LT76VS7rByJ76wOSD96K7x3pmFukK1HsspNu9fbOk61Y6w83Zjf7UCC++YnaU0RTxbF7r19IKllu22JRUZxFJH0DfGWvgc7+KFN9OTsh7sfGikit+v3PVM7liAQ1HY8e39gfs+P0C9Ep1F5r90KasMEb5WBITrJ+PUmCIyPKQOI1bOz3DywXtnYyQB2xZRsuCo+X0z2o3kiOK6cTntHhzCvLO/wdO1ltRLKak3IAAuKfasgv4Yo/UNK1pttatMgracT/TNpADNg9/GHlAk9bcPt+PMSLRTxgD4BeKAWI9bJifpXs21CwETpZ16W99InjV8TSeLJwfrIPL1yQ7NNvkFtYMj1phm2TWjbHfE5h+NLSVUECrPSCqCTm+BoWKfEKUC4bwyStNM2r0l4rZjF6SWMI/Ym7AuAV8gE/tj011xlC9fYUujvDF+h213FKNA6jbmsdRga1WDt9mcJ4lcJsR9KQIdAqlNg7xQoW4N7tl3Q4PRs2+Y6+hwps8j+EUFjzJ7rBcycd6jK6xEklYoAK7jrGrRbguvQTxcUOGAaDQe5GngOGi/ws3FdE7w9CCtvI6s0U4dDNS5B/J0CIG4utHmqw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(396003)(366004)(136003)(346002)(376002)(451199015)(478600001)(7696005)(186003)(71200400001)(6506007)(26005)(86362001)(9686003)(122000001)(33656002)(110136005)(54906003)(64756008)(66446008)(8676002)(66476007)(4326008)(38070700005)(316002)(66946007)(66556008)(76116006)(82960400001)(41300700001)(38100700002)(83380400001)(52536014)(8936002)(5660300002)(55016003)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?cFE5alRybjAzZENKdGtibTRBLy9WWHVsTDhiV0xmQld3SzhvRTBDbWwxSWZo?=
 =?utf-8?B?THJRdzlJV2JpRlJmMVpxV0JiNlo1aWoxRVdJVlJOUFdLa2NxbmM2aXZLQ2VJ?=
 =?utf-8?B?eDVWd0Z3NGZhRDZzaUE2cW1GeXRIZStZTEpCcjBRdENNUEtxWkYvUVNEMUFa?=
 =?utf-8?B?eVZMS1JlVXNZTFNMQXIrbGJhWGVOMllZOG81QS84bExBMkh2YVdrMjNuVThI?=
 =?utf-8?B?YTlBWGhLRTZ4cVJsblVtd3lFOHJtU1ZLdTAyckcyL0VrS2wrWG00cHJEYk5t?=
 =?utf-8?B?RUdyckF0NHJ0M0lDSnhwK3pOSXdaTjFGRW5UOFEvS1ZGVHdrZ04ySlB6ajBI?=
 =?utf-8?B?U1RPbXNmVStlY0czaEdWSVdnQkdVVTU5di9NSTVST01VM1pjSlJ6MUJ1T1Fv?=
 =?utf-8?B?RWxqdC9yY3FpeDlvaFNibzFUSlkybkYrMTFOaHB3U3lpRzhkOFlzRmJmd2Fv?=
 =?utf-8?B?OEFwa0w5SmJVOGZJb2l3MUZDQ3dVRlRCNzlNejl4RUx6bEVBU0hBMDJDOVpy?=
 =?utf-8?B?Z3c4RGJPOHRiRmN0RWtVc0MzZTZoTUFFczNnTWxBdkx5bC9nLzBCc1NxNmxW?=
 =?utf-8?B?VytBL29EdGEwdi85SnVPZXYrbyt4UFBVd21mdTc4emZSdHphczRmYWZSTWlq?=
 =?utf-8?B?VkV0K29jSU5neGw3Tk1Kalg5a2VSWkxmM0RKYU1kUkQyT3NxMHRkSlB5MXU2?=
 =?utf-8?B?QVhQUmFramJLeGdJR0FXV3FHMThUbHd2S0JwUkI1dUFzU3FHdHNKWWNpQW5R?=
 =?utf-8?B?RGtZUGdBMTdpOXhJcEpiaklXaGs0ZnI5V1ZuekxZTWlqKzJ4bVFNc1c0TEFu?=
 =?utf-8?B?WHFuS2wvcm1qT254ZFA0K1F1UlVXVzRralQ1enQ1cWdGWG9KMThTRmNCTFV2?=
 =?utf-8?B?SEZlSnVLZHBVK0pNOElnRXlEd2FublNmYk1DVlNqS2RaRjVUUUtTdWlocjJQ?=
 =?utf-8?B?ZGg4ZFFNdUpTbTFsOERORHhXcjNuaG1LOXhUbnpzZURzQjhXaHlVU1N4TGJW?=
 =?utf-8?B?aE9ZVTRzZkp0OU10d1l5TW9BV1RnQ3dCdDRocVZXc1crMkRMTTdUbEhIbVZr?=
 =?utf-8?B?VEl1MG9DQVdpbmdUVE8xTnZpeUM5bzFLNVJNVm54U21LM1J0WHlNY0Z6dkFR?=
 =?utf-8?B?NklBNWR2cUp4b213QVFXTG9FQVBBdXNuaGNWRytaRGJkQUZocm1GS2EwUFpx?=
 =?utf-8?B?aGxWaENxOVdEV0lqQk9iaUVqZXU2L2krVVcybHp0dWlML0NkeVEzRDJVQnZT?=
 =?utf-8?B?YzJWeHV2bys4akJCSkJDZTJxV1BHVEYrTXdHa29HbDJneXRJRldnNlJaY3cv?=
 =?utf-8?B?WU8reit4SmI1NE5JWGF2RVM3ZHFTUE9FSjJMSlh4cmdSQ2dOTkg1a2cxNU5q?=
 =?utf-8?B?U2gvRG1rem1LSStEY01yK0RtYXRZTEFFMGVod1hnYzRVQkU1NGVVaUVUM04x?=
 =?utf-8?B?UDM5OXpQalhSaVZCZW1BM01oY1J6YjRWVGJnbThCcHFKWmQySmlFenhwUCs5?=
 =?utf-8?B?VnZzWnpTNGtJYldrZzBnYnNUUkpIQ1NFTUNib3lOQTFYOTUyM2c5a1ZBZ1hD?=
 =?utf-8?B?ZllpVEFGY3lwa3hWY1lwdmF0Q1BWSmVCUmRmVU5ySm10RVZhY3hheFN3SzVI?=
 =?utf-8?B?L2d3RTg2WEJzdTE3UTdCSkErNXFlbzYyTXpVVldOVUxKVldLbkVkUzQ3bGpz?=
 =?utf-8?B?aHpxem95SWxMcUVjOTllR0NuRE0yRkFMNEFXSnNlVjMyOXZ3NWxUTlgyaHdr?=
 =?utf-8?B?eHh4S1F4dDVlcGJZTG5nYlNaTjVDVEhZTWkvcEJmQVF0ZzdmUHpCekFJUnAv?=
 =?utf-8?B?VE9XNFV3NHVmQzBCcUJ0WXhocHhBdnZaWjFneG5aWitpQmROMU9vVGErcTd1?=
 =?utf-8?B?SmdGUTYzRTlPQ1ZlQ0QyeFEzeEFhb0NNd2duS01nL1pzWCtXdlZDcXh6RTlm?=
 =?utf-8?B?cFQwcXVnbUZWWk1wSDZwbGVQcmprVjNWTmxlVXIxVXNVejVXaEtiQ3hLSGJY?=
 =?utf-8?B?YURRMzVwd3ludGpWQ2NUWnJyTEVqeG1va0xHczJuZGtKeVoza3pnT3o2azRP?=
 =?utf-8?B?M2g0NHdCTDhUSWVhRUhzRWZlS3pNM0JlMXRYVmlsejMwYUEvS2NnYi9iV3d1?=
 =?utf-8?Q?r3xg7O3ISRtHRhXJhDELcYUXZ?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6JofU1/QFOjXIn6zCoPn3sykiykrpSrhz8sCY6UN58Jz/6hTe4BWBrK8VAPgx48X8f789Gr8Gt3r77ucGBR9w4hhav6cN6JQ8vqO8DW6W52S2GRLKedixLpboMLPplhIDbRTUs2jd4FMSt8gBLBUxRzyPfyjgWEIWonc+fE1tzGkW/wVkm32NLAMboI6NbX8kkDTSaphMs27wujjtzhIurH24lHhNDE5CrbDQPnvftM/jxgWG9U2K0bLteAgBz7ZKAzRXIi6AFoNpX0gjBTQcmmn3bEFtbj0AqsvceXcx5StylncVukcPRshmklfC9Ocj4DhIDS84pLaqRXNg/DEeIYmqSubHgDdSegqNFdjCVcs3M3OPWGZYxcQdTR3sWDyzFETNlpL1s7X75A7Uqw676B9BRYvGqK7bI+Xe5dxXk8p2Rr/gm8/X7C97lkVDIRlijpMrgB0OMDfL8nvAPvnyjHzlqwC6WNAjfk7dGZQ9mlMxRo7xinejy5zRRzV068+PkeWlEDPhlWWec3nqyMsru/F1WuuooBoOLjFsRllAqzY6PI9ZhuPOjVyefKmQDQa6EGxMgOeyl0fExiy970EHUMDHBMgDNrMsd0p79+uRRVw0kWrGQNi1v9VMtdfIxYT6IeWqUWNdWCRcAaii9ur6ZnaRqq5hCfjw8bfpErzjdLIR9ueZoLuD0d/LfT9V+CdHxMfPz3CwdR0XmApBzzo1LMurqfe5ljhDdQcTE2NmJ2yTBaZaRNjJOgMyr4FRid+7m5/PEIuRsw1RSAsTQZE/UZ9m3SOcPZx4cuLgZeGqb3JaBDrNuCh8EYC1XfKVRxWYQNOrT5roTwNcYzT90TiB9q2JNVidl+zvM+EIJeiQSTQkijRh1MN0KyeRrid/8hX
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50856df9-2636-47e6-646f-08daeec87e22
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Jan 2023 02:56:50.2930
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: IHsf7j8hWaI3lVKI0jlMGEXgIEszCIfyIEsv5+5ZaAJ5ug4bBP7niAVd759/eLhKTDD5QAiicX0qeUsrYUrWRg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4453
X-Proofpoint-GUID: ipv8LHlwJN9-92FROU-Y3loRIXWV3k6y
X-Proofpoint-ORIG-GUID: ipv8LHlwJN9-92FROU-Y3loRIXWV3k6y
X-Sony-Outbound-GUID: ipv8LHlwJN9-92FROU-Y3loRIXWV3k6y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-04_07,2023-01-04_02,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

aW5vZGUtPmlfYmxvY2tzIGlzIG5vdCByZWFsIG51bWJlciBvZiBibG9ja3MsIGJ1dCA1MTIgYnl0
ZSBvbmVzLg0KDQpUaGVyZSBhcmUgaW5vZGVfYWRkX2J5dGVzKCkgYW5kIGlub2RlX3NldF9ieXRl
cygpIHRvIHVwZGF0YSBvcg0Kc2V0IGlub2RlLT5pX2Jsb2NrcywgdGhpcyBjb21taXQgdXNlcyB0
aGVtIHRvIGZpeCB0aGUgYnVnLg0KDQpGaXhlczogOThkOTE3MDQ3ZThiICgiZXhmYXQ6IGFkZCBm
aWxlIG9wZXJhdGlvbnMiKQ0KRml4ZXM6IDVmMmFhMDc1MDcwYyAoImV4ZmF0OiBhZGQgaW5vZGUg
b3BlcmF0aW9ucyIpDQpGaXhlczogNzE5YzFlMTgyOTE2ICgiZXhmYXQ6IGFkZCBzdXBlciBibG9j
ayBvcGVyYXRpb25zIikNCg0KUmVwb3J0ZWQtYnk6IFdhbmcgWXVndWkgPHdhbmd5dWd1aUBlMTYt
dGVjaC5jb20+DQpTaWduZWQtb2ZmLWJ5OiBZdWV6aGFuZyBNbyA8WXVlemhhbmcuTW9Ac29ueS5j
b20+DQotLS0NCiBmcy9leGZhdC9maWxlLmMgIHwgMyArLS0NCiBmcy9leGZhdC9pbm9kZS5jIHwg
NiArKy0tLS0NCiBmcy9leGZhdC9uYW1laS5jIHwgMiArLQ0KIGZzL2V4ZmF0L3N1cGVyLmMgfCAz
ICstLQ0KIDQgZmlsZXMgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
DQpkaWZmIC0tZ2l0IGEvZnMvZXhmYXQvZmlsZS5jIGIvZnMvZXhmYXQvZmlsZS5jDQppbmRleCBm
NWIyOTA3Mjc3NWQuLmZiOGJlOTQxZmYwMCAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZpbGUuYw0K
KysrIGIvZnMvZXhmYXQvZmlsZS5jDQpAQCAtMjA5LDggKzIwOSw3IEBAIHZvaWQgZXhmYXRfdHJ1
bmNhdGUoc3RydWN0IGlub2RlICppbm9kZSkNCiAJaWYgKGVycikNCiAJCWdvdG8gd3JpdGVfc2l6
ZTsNCiANCi0JaW5vZGUtPmlfYmxvY2tzID0gcm91bmRfdXAoaV9zaXplX3JlYWQoaW5vZGUpLCBz
YmktPmNsdXN0ZXJfc2l6ZSkgPj4NCi0JCQkJaW5vZGUtPmlfYmxrYml0czsNCisJaW5vZGVfc2V0
X2J5dGVzKGlub2RlLCByb3VuZF91cChpX3NpemVfcmVhZChpbm9kZSksIHNiaS0+Y2x1c3Rlcl9z
aXplKSk7DQogd3JpdGVfc2l6ZToNCiAJYWxpZ25lZF9zaXplID0gaV9zaXplX3JlYWQoaW5vZGUp
Ow0KIAlpZiAoYWxpZ25lZF9zaXplICYgKGJsb2Nrc2l6ZSAtIDEpKSB7DQpkaWZmIC0tZ2l0IGEv
ZnMvZXhmYXQvaW5vZGUuYyBiL2ZzL2V4ZmF0L2lub2RlLmMNCmluZGV4IDViNjQ0Y2IwNTdmYS4u
OTdhYWVhNGI2Y2ZhIDEwMDY0NA0KLS0tIGEvZnMvZXhmYXQvaW5vZGUuYw0KKysrIGIvZnMvZXhm
YXQvaW5vZGUuYw0KQEAgLTIyMCw4ICsyMjAsNyBAQCBzdGF0aWMgaW50IGV4ZmF0X21hcF9jbHVz
dGVyKHN0cnVjdCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBjbHVfb2Zmc2V0LA0KIAkJbnVt
X2NsdXN0ZXJzICs9IG51bV90b19iZV9hbGxvY2F0ZWQ7DQogCQkqY2x1ID0gbmV3X2NsdS5kaXI7
DQogDQotCQlpbm9kZS0+aV9ibG9ja3MgKz0NCi0JCQludW1fdG9fYmVfYWxsb2NhdGVkIDw8IHNi
aS0+c2VjdF9wZXJfY2x1c19iaXRzOw0KKwkJaW5vZGVfYWRkX2J5dGVzKGlub2RlLCBFWEZBVF9D
TFVfVE9fQihudW1fdG9fYmVfYWxsb2NhdGVkLCBzYmkpKTsNCiANCiAJCS8qDQogCQkgKiBNb3Zl
ICpjbHUgcG9pbnRlciBhbG9uZyBGQVQgY2hhaW5zIChob2xlIGNhcmUpIGJlY2F1c2UgdGhlDQpA
QCAtNTc2LDggKzU3NSw3IEBAIHN0YXRpYyBpbnQgZXhmYXRfZmlsbF9pbm9kZShzdHJ1Y3QgaW5v
ZGUgKmlub2RlLCBzdHJ1Y3QgZXhmYXRfZGlyX2VudHJ5ICppbmZvKQ0KIA0KIAlleGZhdF9zYXZl
X2F0dHIoaW5vZGUsIGluZm8tPmF0dHIpOw0KIA0KLQlpbm9kZS0+aV9ibG9ja3MgPSByb3VuZF91
cChpX3NpemVfcmVhZChpbm9kZSksIHNiaS0+Y2x1c3Rlcl9zaXplKSA+Pg0KLQkJCQlpbm9kZS0+
aV9ibGtiaXRzOw0KKwlpbm9kZV9zZXRfYnl0ZXMoaW5vZGUsIHJvdW5kX3VwKGlfc2l6ZV9yZWFk
KGlub2RlKSwgc2JpLT5jbHVzdGVyX3NpemUpKTsNCiAJaW5vZGUtPmlfbXRpbWUgPSBpbmZvLT5t
dGltZTsNCiAJaW5vZGUtPmlfY3RpbWUgPSBpbmZvLT5tdGltZTsNCiAJZWktPmlfY3J0aW1lID0g
aW5mby0+Y3J0aW1lOw0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L25hbWVpLmMgYi9mcy9leGZhdC9u
YW1laS5jDQppbmRleCA1Zjk5NWViYTVkYmIuLjZhZDNkZmY0M2QxMCAxMDA2NDQNCi0tLSBhL2Zz
L2V4ZmF0L25hbWVpLmMNCisrKyBiL2ZzL2V4ZmF0L25hbWVpLmMNCkBAIC0zOTYsNyArMzk2LDcg
QEAgc3RhdGljIGludCBleGZhdF9maW5kX2VtcHR5X2VudHJ5KHN0cnVjdCBpbm9kZSAqaW5vZGUs
DQogCQllaS0+aV9zaXplX29uZGlzayArPSBzYmktPmNsdXN0ZXJfc2l6ZTsNCiAJCWVpLT5pX3Np
emVfYWxpZ25lZCArPSBzYmktPmNsdXN0ZXJfc2l6ZTsNCiAJCWVpLT5mbGFncyA9IHBfZGlyLT5m
bGFnczsNCi0JCWlub2RlLT5pX2Jsb2NrcyArPSAxIDw8IHNiaS0+c2VjdF9wZXJfY2x1c19iaXRz
Ow0KKwkJaW5vZGVfYWRkX2J5dGVzKGlub2RlLCBFWEZBVF9DTFVfVE9fQigxLCBzYmkpKTsNCiAJ
fQ0KIA0KIAlyZXR1cm4gZGVudHJ5Ow0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L3N1cGVyLmMgYi9m
cy9leGZhdC9zdXBlci5jDQppbmRleCAzNWYwMzA1Y2Q0OTMuLmZhMGU3ODkxMzQyNyAxMDA2NDQN
Ci0tLSBhL2ZzL2V4ZmF0L3N1cGVyLmMNCisrKyBiL2ZzL2V4ZmF0L3N1cGVyLmMNCkBAIC0zNzMs
OCArMzczLDcgQEAgc3RhdGljIGludCBleGZhdF9yZWFkX3Jvb3Qoc3RydWN0IGlub2RlICppbm9k
ZSkNCiAJaW5vZGUtPmlfb3AgPSAmZXhmYXRfZGlyX2lub2RlX29wZXJhdGlvbnM7DQogCWlub2Rl
LT5pX2ZvcCA9ICZleGZhdF9kaXJfb3BlcmF0aW9uczsNCiANCi0JaW5vZGUtPmlfYmxvY2tzID0g
cm91bmRfdXAoaV9zaXplX3JlYWQoaW5vZGUpLCBzYmktPmNsdXN0ZXJfc2l6ZSkgPj4NCi0JCQkJ
aW5vZGUtPmlfYmxrYml0czsNCisJaW5vZGVfc2V0X2J5dGVzKGlub2RlLCByb3VuZF91cChpX3Np
emVfcmVhZChpbm9kZSksIHNiaS0+Y2x1c3Rlcl9zaXplKSk7DQogCWVpLT5pX3BvcyA9ICgobG9m
Zl90KXNiaS0+cm9vdF9kaXIgPDwgMzIpIHwgMHhmZmZmZmZmZjsNCiAJZWktPmlfc2l6ZV9hbGln
bmVkID0gaV9zaXplX3JlYWQoaW5vZGUpOw0KIAllaS0+aV9zaXplX29uZGlzayA9IGlfc2l6ZV9y
ZWFkKGlub2RlKTsNCi0tIA0KMi4yNS4xDQoNCg==
