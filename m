Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577676A533F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Feb 2023 07:57:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbjB1G5R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Feb 2023 01:57:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230169AbjB1G5Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Feb 2023 01:57:16 -0500
X-Greylist: delayed 2951 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Feb 2023 22:56:45 PST
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 969792448F
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Feb 2023 22:56:45 -0800 (PST)
Received: from pps.filterd (m0209328.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31S4RQ2l023589;
        Tue, 28 Feb 2023 06:07:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-type :
 content-transfer-encoding; s=S1;
 bh=BNyl0x73b6wVgZwRcK+kG8YClNy0xeSFgcEU9B48xJI=;
 b=CzKyoE9vKHIU4dWYTho77t7nPxLob2bfkwWQMExB2FnQ3MTM6/F0fXf8C2jQrul0gVmR
 UaDXKi1Tq+1JKRRxywqiYdPyhzqVwxQiBjPl/OuUj8QOFd1wilJvPk8SHyoNONTGkMd0
 SKFBaZzTmFaDwlSZNdZ/YQ7+848V7Yv3w9QKwrR8LJHivajpemfOdMqow2dMt4uY2Ak9
 ipmfOjP6DMsPLJdb+hNGGzm83BQEC1a84qxnYPY11yD6ACBmZgzaq6ratQQQAjSTEKSF
 VSjdLLujfxKHQffju2VrmzGnJ4T170inMH/gyyH4Bfqgp33wODMk3GWour7Sux552n2Y lQ== 
Received: from apc01-sg2-obe.outbound.protection.outlook.com (mail-sgaapc01lp2107.outbound.protection.outlook.com [104.47.26.107])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3nybgnab7h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 28 Feb 2023 06:07:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=itc/3ZLGhVOCcUgZFMOVLPyhmTMGEWEWWHiktshycg4hDxzX3QOcnKcU+Nx8sMrNL/U9EHO8CBU/i2Xqg3sVIjmFpD2Qb4W+OTM6ekyvhsrKRDSePGHY9lRV0OZB5PDFRvHnhECrYSXwewj50KsQ0FSpOTS7AA6gTTXqc/HdlaU78vuE5ppfc9h4KyXxqzqi1nDx3qtMOBu1I6AzLSAe1gIY343y3agz/jHneV9vZ7Fotx4XYsHunh5O1aYTNWqL9zorGvfOCGODey7OTTLcy834fncnLxdKMwaeigA98gX7uul1DKpJNtX5JcFjQqM1Ix/N36HmqjMVdXHVbxnQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BNyl0x73b6wVgZwRcK+kG8YClNy0xeSFgcEU9B48xJI=;
 b=kbb5z8syWzd8odJoGScqrgvToeIqsJkdTR0a8J57/7DNBreokQZ5Wfg7WcJhRCFbYcYJCAK/BkCdh8V+t2jB7hSOJxC/LaTgu9nVAAcOujjp6N9uZRYksk1bQpELThI96gozotWKLcROGWfCIkxbdFXs5PmmN4y4RcyhkWpoVX0dcOLn3SFup3HYKZBd4CAZeoTdc0BSm27TOrkRs5ActDi2hojKjtS7NFsQcPyuv9/oLIhFgBj/dfjdJcQEWexo5qOvXa28Z8GKbnMmxxyUdfr+VZroFiBd56+TCpM9+PgFExShq8oBFK8kBUzcsk3og0oCNOQg+q33cRVn62Vn7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by KL1PR0401MB4227.apcprd04.prod.outlook.com (2603:1096:820:25::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6134.30; Tue, 28 Feb
 2023 06:07:18 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6134.026; Tue, 28 Feb 2023
 06:07:18 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 1/3] exfat: remove unneeded code from exfat_alloc_cluster()
Thread-Topic: [PATCH v2 1/3] exfat: remove unneeded code from
 exfat_alloc_cluster()
Thread-Index: AdlLOnYM/msEcfBIQmWIdYvNavIEWQ==
Date:   Tue, 28 Feb 2023 06:07:18 +0000
Message-ID: <PUZPR04MB6316049BBB8D66785211D6DF81AC9@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|KL1PR0401MB4227:EE_
x-ms-office365-filtering-correlation-id: e2bdda73-94f4-4515-8929-08db19520bf0
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 7ywCnNHknJTdtFA64HxuLTqMIUdn27vKMhPttydFZWvXJRvkxOnNg6wAMIq6O0Gb4+bvPftUSvLKjIt68fgcqMihGOxyiluNu8wotwbH4lorpx1wMqk4zJ6Ef0nsr1QSrZLHEkjzGYVfddzihPF+3mV9+ruRczJh7mJbRfwaKklcUGSexTDRnItFNcEMfAg3kEIZ7rpjN0RMN4+oVNkJFNDPi6FX/HemkSOj8t6l/tWlzo+kS3b9RjMSgkrrLaQwcUA4fbGQ25sCQnUmC4KB9g1/ncZ/PcW7AC4ml0rM0BPn+UH93LoK/YssMA0OYrmmuKGpf7vc9vXQELMzh9IG2q4OM6walfNFSUT0b2ZUSXvW1xe/iPefql9nFKnP4Finszrox/DnbPqy2eiMzZW/v1I0hFJgH/SCoKp54VAgu9nSlwUhl1uNu15lWtuxHXYfZyKzwTP59/U1BOgptWZyR4YbztFtxTuGux813a6AmEUeLzRhgOb0E/bgd42ADsoEe/L581NIbyVEm0GYBVnHWvlgVDWj3x/zqTSEWLTYGnJFEpKDMC6OW45R81c/cos0rsC8ZaimaWUeaeaWl47ucEMtxIqjq1LhGeiP+RDzXUXqISGBdG+M0q6aMTreHN6GTQebPlEpt8Tt6QMajU0cZQ0F+h9BBCYTzzjcm7lKcs4HvNdYplzn/xIVmXofp4cg
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(366004)(136003)(39860400002)(396003)(451199018)(110136005)(83380400001)(33656002)(54906003)(316002)(478600001)(82960400001)(38070700005)(122000001)(7696005)(26005)(41300700001)(9686003)(186003)(71200400001)(6506007)(107886003)(5660300002)(4744005)(38100700002)(76116006)(52536014)(86362001)(8936002)(2906002)(66946007)(8676002)(66476007)(66446008)(66556008)(4326008)(55016003)(64756008);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MEg5M2dnQWhtL1JBeGQrN1FoMjByU0tISFRjY1dsUzMrelBjZDhiaGNUV3Y5?=
 =?utf-8?B?bW80aURGajhVQnBRVlpubDhya3AxbkJGZFVqUDJwdlBLTDgvakNHVnRrS0Vt?=
 =?utf-8?B?YmlCNnd2MTRKdE1uRDhhN2pwTlpaYnNYVmJTbHZBY1o0M1h2MW15OHNwRTg3?=
 =?utf-8?B?Nm1Kd3VQaXJuWUxINWtzYzQxTjE1K1ZKT3g5aEZ2eHRjTUhhdVFYUDdSUDBR?=
 =?utf-8?B?MzFaVTVVRkFMakxPdGE4bktEdzBVN0hJeFdndzdUL28wQ1ZnUENkQXpvMmtt?=
 =?utf-8?B?OHR2Q0gySlFTMnJ6emRXY2VtZDBhUlQvSDBYUEgzcUc4VTB2Wk9yTGxHTEdj?=
 =?utf-8?B?Yy9ERnJxM1kwaTd1TzFmNEh3MTdSUjRPdEUrM1VrUnBxcUt2MzhxYjlZNC8v?=
 =?utf-8?B?Z0FPQzF3ZHQzeHBlUWlldUROcHV0VjZ0dzhFd2RRWHpTUDlMMVVEMWhaL0Jr?=
 =?utf-8?B?Y2w2WVpyV0dEam1WOE5nc1NDblIvZGxDbjhFaG1kWkhIZGFudjB1NXJwR3NX?=
 =?utf-8?B?UWtNbDFibnBWSmRkalQ2dkpxTVgvaC93NGVYc20yWGlNelpBRVVVcE1ndGZZ?=
 =?utf-8?B?eGgzU05GNlZybXVJdHVjUzRRSTljRWNRbXRVSGUyM2QzWlIwMDdFVm5keFVP?=
 =?utf-8?B?ODBqdDRub3UxSFBXUjRVcXRKc3Vvam14OG1PcWNYdWM3OEpwWnRLcEZxU25q?=
 =?utf-8?B?OXFOQ1AvczhWY1VhREJMQ2MwVE5ZZCtyU0NieDBKWktqVjVRaVJhZ3JWdk5N?=
 =?utf-8?B?bjBTZWdJeldwOXBHNUlyaTA0L09XSndnOE1XYTVnWm5IVkwrMTQvOGwyQ3BB?=
 =?utf-8?B?RDlnZUJIYXFTMmRKM0V3eVRaUklnYVNUdnVYNjZOUVNlay92Sld3RnVlcGJJ?=
 =?utf-8?B?bEhjQS9OQ21QSC9HVFowZ3hFWHlWMTVlRGtVWFN3QmY3Ni81cDNRTG82cDBM?=
 =?utf-8?B?eHBlZnlxTjlrSER0aDBwSy9aRTMyNDZvWUlVWW93VC9pRDJqZ0ZrZ3VKWFpJ?=
 =?utf-8?B?REM2YndDeWEyUDhZbHN6aUx3SVNBSndBYVZubkgyN2tCQ2JTY3l3K3BTYk11?=
 =?utf-8?B?cUYwVzJRS1NaTERXWDJhMHl5YTBEblNMZkZETjJsWU0yZHkyMDlpYzFIbGo3?=
 =?utf-8?B?bGJxbWJ1WHRrQWowWnExa09JTVVVYisvUjBrR25RSkIyNENjM1ZlMHlhOVpl?=
 =?utf-8?B?ak5oZ1FpTEdTSkliNjJJVGR3S2w3MjdaNi85QVdLaHZNUGNzZ3NKRVR1cnFh?=
 =?utf-8?B?dGJLUkRFNmRiM1NGM1ZZVFJvbG1MZ3FEWTR4eHBTTWZlaEcvR3BxZlE4WlFZ?=
 =?utf-8?B?Vk1DUGh6SEpoY25tcFhhWDlsdkJ0a2hjUHVhZHF2ZVVKRC9BQlArNE4xMWRZ?=
 =?utf-8?B?STFhcGFyRnRJdGNHdVdHYTJmMkoySHN0T1FTaWliYVJOT0NZNVU1TVM0VmdT?=
 =?utf-8?B?b3JmN1hSOVoraEQ1UHUvVzhYZSsvcEpBMGZXdmh5TUJmcERzdVl3UGVHR0FW?=
 =?utf-8?B?cVAyNnBBTGpXaWNKMFpTYWsvTlBGYlpla0FTVDZZRlltb0tqc2k4blc0bzRF?=
 =?utf-8?B?VE1DQmxqWXJ1WU9SNlNNNVBpQ21GYkw3RnBjZnlKek9GQWF2NDZIQ3pKSVRY?=
 =?utf-8?B?SUUreFJuTTNsTW00aVZmMEpTSUoycUltMVpKMlNkbVZjZVd0ZlZiRFM2TTJs?=
 =?utf-8?B?eFRLUnBZWGZuNXhoTmJPd1A5cVlzeldHcXpQNTFWc3FTT0lGWWtsZEE0RWxQ?=
 =?utf-8?B?enh6emtUK2RCMlU2YlYxYzhVSU1tQlRnbi9hUkxmaEtCbW56R1k0Vm85SEE4?=
 =?utf-8?B?Y2VnUmw1U3FYaTBic1d3VDMra3VDd2dzTml2S1drMk5hTFJZZ3JuYUZXakg1?=
 =?utf-8?B?OEhYZDgzVkdsNnVtQWhybzQxMW0vZWxzZmtKQ1VWLyszb2J3TXVUcjQ2S1ov?=
 =?utf-8?B?NVVZWTZGcjVTK1phNjFWSUVCNHZUMUkwNTRWRnNsb0NHT3FMQ0Q0SjVoMHNH?=
 =?utf-8?B?Vk1XNHZBUUtYbFBvcUp1MTliYkZkUVdJcExrYzdxWkptZWluUk1rYlNrSmEz?=
 =?utf-8?B?enUvTDlHd09LMWxTOG5wclBFNjZEeHRCOVJDVDgyN3pKUktPS0p2ejdSMzFB?=
 =?utf-8?Q?tIU2aY3VaIMtFa38RKO/phm05?=
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 4BMGJYaFgd01c32iu5/EGDJ1ERQ7ntZXW1aKid1a85YAGNKrAva/kvO1FbWmagj735kweDes6HZBoa5lYYXE72i9+ULbGrhTSe75Z/ajwQVlRhh0cTjeKKt/fkpY7HyIM1ut+U33/Jbqm825p6Sh5mQJkfM9Pca2AOM/hYOgEarFG01RJo1EyN3FyLrfAWsD3NS+OpI36w1OR/L0ywENqPM1jZt43zNOmNf0o+1Liy+/MpZ/MK0oeGRZG4A53WkzExPuUTw0CDLYIDfxHNNTSkEiws1PfSq6os4FBq1NbVPerlMmpFAnoUktDO6V4+pDrP50fmgd6Kz+41m+hbVF5FBKOm5w8fRT2g/ELDRyKKmduOLIAGxDbPJQbzC+Yh7HqTCPRy9cxqU/zxIqZU3EnSE2zLM3A5X1rLTBUtY42xuKvd0iGcndcy8/3iH6VCxdsaoYlnYJD58a7IJKQtwLiDGg/OQvsH4ZEJ4dpmMCJqRoTWDVyu+r1oTa63vXAsE8YV+h+7VnqGsz7GiOzeucrkSRsx3goP/sLND1blP2vS0JwDCKUSSD38QYXYlfxS6y4Ur5lfpksBIarLj4NKa7UnoREuiAtH8fs8xjbKUQILf1fE5pOUS0l1tmYo7k16xPnTZ7hGBmpXbn8bMVqXzRcqbDdrVvU+0jJ1u9N4OrOyMMkFIEP6nqOcM4PBDSmG5KAzNu/zA1WQg+f/dZJnZONaI72n/yOGezEEX3A/ixMz+HVCB4JP0yOjGCRgOGrcVhsgF6aBu9oSZp5vsURNPFi9xL/ERYy3BJNsQIrS4Hs2BzSCrqDvtMBlAtuc5mNBCK19ju9iO0DxRcZKbQX5D1yA==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2bdda73-94f4-4515-8929-08db19520bf0
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Feb 2023 06:07:18.1070
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5qp9XsqFbN5uiFyTLjAfuJ1Yd4Rd+08tSWg0VBqgVTMY7uc5rImj4A1Ow+zTSOU1QIbK3qJC3ly3aC4oysVs8w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KL1PR0401MB4227
X-Proofpoint-ORIG-GUID: F5rL8jtTRCBcjhDas_eGF06qNBzERe4y
X-Proofpoint-GUID: F5rL8jtTRCBcjhDas_eGF06qNBzERe4y
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
X-Sony-Outbound-GUID: F5rL8jtTRCBcjhDas_eGF06qNBzERe4y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-28_02,2023-02-27_01,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

SW4gdGhlIHJlbW92ZWQgY29kZSwgbnVtX2NsdXN0ZXJzIGlzIDAsIG5vdGhpbmcgaXMgZG9uZSBp
bg0KZXhmYXRfY2hhaW5fY29udF9jbHVzdGVyKCksIHNvIGl0IGlzIHVubmVlZGVkLCByZW1vdmUg
aXQuDQoNClNpZ25lZC1vZmYtYnk6IFl1ZXpoYW5nIE1vIDxZdWV6aGFuZy5Nb0Bzb255LmNvbT4N
ClJldmlld2VkLWJ5OiBBbmR5IFd1IDxBbmR5Lld1QHNvbnkuY29tPg0KLS0tDQogZnMvZXhmYXQv
ZmF0ZW50LmMgfCA5ICstLS0tLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
OCBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2ZzL2V4ZmF0L2ZhdGVudC5jIGIvZnMvZXhm
YXQvZmF0ZW50LmMNCmluZGV4IDQxYWU0Y2NlMWY0Mi4uNjVhOGM5ZmIwNzJjIDEwMDY0NA0KLS0t
IGEvZnMvZXhmYXQvZmF0ZW50LmMNCisrKyBiL2ZzL2V4ZmF0L2ZhdGVudC5jDQpAQCAtMzQ3LDE0
ICszNDcsNyBAQCBpbnQgZXhmYXRfYWxsb2NfY2x1c3RlcihzdHJ1Y3QgaW5vZGUgKmlub2RlLCB1
bnNpZ25lZCBpbnQgbnVtX2FsbG9jLA0KIAkJZXhmYXRfZXJyKHNiLCAiaGludF9jbHVzdGVyIGlz
IGludmFsaWQgKCV1KSIsDQogCQkJaGludF9jbHUpOw0KIAkJaGludF9jbHUgPSBFWEZBVF9GSVJT
VF9DTFVTVEVSOw0KLQkJaWYgKHBfY2hhaW4tPmZsYWdzID09IEFMTE9DX05PX0ZBVF9DSEFJTikg
ew0KLQkJCWlmIChleGZhdF9jaGFpbl9jb250X2NsdXN0ZXIoc2IsIHBfY2hhaW4tPmRpciwNCi0J
CQkJCW51bV9jbHVzdGVycykpIHsNCi0JCQkJcmV0ID0gLUVJTzsNCi0JCQkJZ290byB1bmxvY2s7
DQotCQkJfQ0KLQkJCXBfY2hhaW4tPmZsYWdzID0gQUxMT0NfRkFUX0NIQUlOOw0KLQkJfQ0KKwkJ
cF9jaGFpbi0+ZmxhZ3MgPSBBTExPQ19GQVRfQ0hBSU47DQogCX0NCiANCiAJcF9jaGFpbi0+ZGly
ID0gRVhGQVRfRU9GX0NMVVNURVI7DQotLSANCjIuMjUuMQ0KDQo=
