Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CCD764ADC8
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 03:38:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234377AbiLMCiY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Dec 2022 21:38:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234314AbiLMCht (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Dec 2022 21:37:49 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 701121E711;
        Mon, 12 Dec 2022 18:37:14 -0800 (PST)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 2BD05pfX016439;
        Tue, 13 Dec 2022 02:36:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=sgu6yPQ8lCayHzTODsx17It8x6n3yW2mxMZFTeqPLqM=;
 b=erQJDY38kNphiUmalOhmkX5pNhQbMS+d8y/d/68M3lN6eHV1PBtKZ8e++1cEvEUU9MuV
 kR30f8ztj375OUufB7qahpDcgWXYOP76PxnaLv7LCjwm6duJFNjsEny89NgWAaMZvFrJ
 pp3Ld75AYUHsIUs12C+Qi59UJkEykPl7AyU65H2HWm+6WAlTMwzhVU2y2myTn9zO59Gt
 CvlPCE6jWDVUMOj10yDOlMkYHbYU7uB47MC44/0px27MAYwqYojIRokwHutCX00C2DUl
 HGn+0721opeogU8ouGvSvHsrstazliSbol4k5AnWfPVvz8zlkttbZn3R8bHjtHCk3TaQ pA== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2043.outbound.protection.outlook.com [104.47.110.43])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3mcfbytma7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 13 Dec 2022 02:36:57 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MPTNL/UkZJ7oFJKkz4nDYDqF1qp8HzIjirpPdKLRK9F8j3Il/1q5S2ija3SnH9o3Y4gNlJppipfCqiSF2KsjbSHaZ2DgTTkapn87l2e8P6gy/OKcjexZCWt+jY52SGlaloUqddv9ODcOjmYA3oQU5KSsewQwrehteayo9ua7mfW9JcDZg+GCm3DhhKNTm2ennTZbuUDpKqohfAvUt02rCAyvUtY1VKdnnEvjj8KrvaUxSJnVjko2hX2rMGBqgapspLxZ4PYTiwstqMlXIh14T+gpsWr4kj3jRIVCo39pPHcvq7YkEOHuh9Bu+DTXDiB94tbyW0sbhsrUWJwE8b1pxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sgu6yPQ8lCayHzTODsx17It8x6n3yW2mxMZFTeqPLqM=;
 b=hNOGIOEJKqZXsOWeBu8sZc7MzD3kpi19CbkXv0CkeWIVHvbEjOk/W2jUPsB94fyKgJxgDqAvTJIDOgNw+p7+qnQrdnTmMQtHShztuTseQmUvaSQBwENISiCStbrPd269d+kK1ndOHYR7xk7THdnzv3mzZ3bHgdZWBDTtEoAO+HaK287IsALKxOaP8Uk+IQIhzceMLDaz02tKlIpXK/OkwvLYWyTcCFoH/LQ/Js2C2O5PcVA9NBWBCHdsv+C0i6qNsspy7tQv4EhhwWoKs3HWzyxgBeS4Lp4VDsROBhik0DXw364k+yx/ecEfjQILFQNFK1U1IJriwxxTMvGYAS7lUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by SEZPR04MB6948.apcprd04.prod.outlook.com (2603:1096:101:e1::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5924.10; Tue, 13 Dec
 2022 02:36:52 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::c689:d665:b3a2:d4de%7]) with mapi id 15.20.5924.009; Tue, 13 Dec 2022
 02:36:52 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linkinjeon@kernel.org" <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH v2 1/7] exfat: remove call ilog2() from exfat_readdir()
Thread-Topic: [PATCH v2 1/7] exfat: remove call ilog2() from exfat_readdir()
Thread-Index: AdkOmXOzasUmLwpnSf6xtnBDY8gbaA==
Date:   Tue, 13 Dec 2022 02:36:52 +0000
Message-ID: <PUZPR04MB6316B01DBC97DA2D468A491181E39@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|SEZPR04MB6948:EE_
x-ms-office365-filtering-correlation-id: 9d89c779-51b4-4f02-189f-08dadcb2e479
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: R/qawWOmNP90qSJTPwlxQJQTII7D8o1tdGaepBDS3B1UdxmPlscu9RVlKoZXFCCFiFkKvW3nHLKPTvmvrquhRGM+EakOPO0rJy4mwN8Zu7Q+8ozpGm9H7zTolGrILF2qru4S4BE9f8SOR30NKO5aDfj5mZUIvHjYsuowGtkvVikO53TOIQS+y6Jl38FHRfP7r/JLWHrY5UKtNKjGMw8M1H5o3rrobZcWlDoZRjXm+gyKhGlFvcaB8nN67BTVNAtkIyCnqoyT1kiRdt7VwObRFcBHeU5mCOiNqsdbMNJoDUm4w1U9oJ7IBfw2mSSy8v1ipv+/kj63mcNjxFxAVNmMnAAOy2TIpy6ceqVnu2ZlQiWgGaeAaxkMpvXQ1/jDMaSNbdpUwNsZjaj7G/UGVuVmfNiqCLJtKOgL06GyPf8UMY5n8ChYGKfxJdVsrtrD0WeJanbOFdgUKXaEbLbX27LJD+FX4Of+T+MiYVtDlOIVxLm3LfQAP6ROyhwJsJIkxIN5GkxYHhr4DCrRkrEM+pi4U9HY+pAUiRp+2xPdZrwg16diQludZFSEqsK2ibl2jfOG2BPV77L/0TMpul7N2u3YPSFjAxaD7IapQYVRh1085EimXvMobXBXO92Ny10scELbgJqoC7yEF6SC/+roJ/n42lpzgUp2scyp5sF4eCext3LqzOHd5sz4Rvs6Zxkc1k+h9HPsUeXKwnv/2jKrLDd8ww==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(39860400002)(376002)(136003)(366004)(346002)(396003)(451199015)(86362001)(82960400001)(38070700005)(2906002)(8936002)(4326008)(8676002)(66946007)(66476007)(66446008)(64756008)(66556008)(5660300002)(122000001)(38100700002)(33656002)(83380400001)(478600001)(110136005)(316002)(54906003)(71200400001)(76116006)(55016003)(52536014)(41300700001)(6506007)(7696005)(26005)(186003)(9686003)(107886003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UldyR2xnWUxmYVB3c25LMnVoYm1aU1hZNWlScGdHMHlXSmJrUEdnNzluNHk5?=
 =?utf-8?B?SkE5a0pnY3FoeDdvd3RNb04vblNEa2JmckNySDJPRE55TWt1MGV3amErN0ZP?=
 =?utf-8?B?d2FyNGJSZ0JnOGliS0JZaFEwRjBJZkRQSkZzUnlGT3V3WnFOLysraEVBeHZa?=
 =?utf-8?B?K2FZWXhJR3FnWnFEWmJPYUhISG1lc25QV25CUC80eEN1cC9SbWV2UmJ0dzIy?=
 =?utf-8?B?OXhqSHdVdXFSVm1BVGdoU2dGZGE1WnZmaXZLSHJXRDJDZlFaVkZiU3liSnlP?=
 =?utf-8?B?TnV6QXdPc3doVWU3dlVUNXg0T1V5d0dqYWFMa3BNRkxRcEFMQnBSTmxpaklT?=
 =?utf-8?B?MUc1MmhOV3lKK2diTVB2bWZaVkUwY1IwdjNvSkZRdTVNUkR2d1lrTDQ1dXkv?=
 =?utf-8?B?eVFxZFNNbWZjRmd5Z0RzMHcwNjA3ZTk5R0FOaEFZL1NjOS9DN2xJUUJzbnlM?=
 =?utf-8?B?UFJaUlZpT2hIN0V0VlZNNEJFeUlET3hJN2V1SzZnZks2SHNMVitETGdhYzRo?=
 =?utf-8?B?bHRoRjhlbDJCQlpHQXV2aTVYaEsySTJ4SnJkcDFWTlJCVGZFemF4SHp0bmdm?=
 =?utf-8?B?MGFoY0dxQUNURjFjbDNHWVJVb2lMZTZ5d1dhNE11OW5XQ2hQUjQxbGhEdURl?=
 =?utf-8?B?T2t1ZVZ1SHI4bmt3dXpqMDFsZWx0NkVySUd4MUFveWxBd0ViS3d5RnVxaVFT?=
 =?utf-8?B?dzhiRnEyanBiZWc3UVZsZFVQbUpoWnlrTkxVK2RaUG92NGRwRldKT0RlRitD?=
 =?utf-8?B?R1E4aUJGa04rKzV1NC90a09DVHR1L3dnT1dlajR1UkJ2STFXNU5LTFFMeUV6?=
 =?utf-8?B?clFXQTdLNGoxeitKbUZhVWZaN1RXOUtZb3JDUTY1REpUTVljdm45UjFnUUZU?=
 =?utf-8?B?NG55dC9IOXpxQzNMbEN1VXJFa3FpcXNvTnJXNU5FMEZnR2tTT0Q1bHpvcFhY?=
 =?utf-8?B?OUk0Uk5FR2FRdWFLOGVYcjJnYzVNRzRVYUdvSGp1TElDQU9zK2g4eml2ZDF0?=
 =?utf-8?B?dXl6eG5EUFJDbTFoMU0vQ0FQNjdUZFl4MGpTdUoxblh3VXp6Nk5KaENqVGZj?=
 =?utf-8?B?SW9RK21rQkttbXNEM0ZhNnhEbDUwc2V1MUlHZVFEK1JjNHVXbG1yaDNPaHRU?=
 =?utf-8?B?V29qTkdFTkdnaGtkUzV0S0thS1BXZFhybG9pZlpyWWN1Mk56aHF3WGlXTTFw?=
 =?utf-8?B?V0J3azNGclBKUjJXNzRMVzRSaWphQW9oTEtEdmdpaFhKTHZVQ2IwOEdFQTZi?=
 =?utf-8?B?TnAzOFlOUmtIeHRHWjArbktORVFza2lSaXFIcUU3MHR4a3ZuRCtIbXEzaXNW?=
 =?utf-8?B?ek1TNGMyOW5PMkU3ZG51MDJUdFBSVDhNUHFLRExHTXVxcERZb0VoOEFwUHFl?=
 =?utf-8?B?aWNBVzNDa01DM3QwSzB6d1NnSjV3ZkpSVGxwdVpkZjlVNXRUZllyYkpETjl6?=
 =?utf-8?B?R2xiMS9hVnVxak9Rd0MzQ0c5WVY1Z1VtZ28zb3ZtUWFEV3JCOVRvd1NycG1s?=
 =?utf-8?B?dExpR01uU2E0ak5RTlkwNHZZaThWbTdUbWdWY0c3TTRldThueTFWa3JrTFRp?=
 =?utf-8?B?cDFUYnNqMTFwWXdWODVncWloMlBqaWxwTkV3ZTJ2V0NCRVRUTDZzZ01sVUhn?=
 =?utf-8?B?U0hpcC9rNXljWm9jUDFrc2ZqaDRCOGJoa29FdzRpYmRlb3ZBN3FoVEo3WGpO?=
 =?utf-8?B?cWdtZnpaSitueTVLVWpTN1JjazVrNUNoOXlpbGpJVjFSTmVIdG82ZkRROXJh?=
 =?utf-8?B?SzJTOGpuVHFpemtVU3dQSFNPVCsrYWgyQ3UyVktNbjIxaXlwOUtMNW53S1ZD?=
 =?utf-8?B?ZktHWTZrTy9jQ3d1NUNjNkdRZkE2L2tlQmlrVzg3M0h2N0tSdDYzMk95K1dH?=
 =?utf-8?B?ZThCN0JENnRQQzZNeE42L0E2VUFvc3JubERzT3BjbERjdHlmc1oyOXB0SkRp?=
 =?utf-8?B?U1g1MWh1eXpkS1JwUzViNFEzTXN4cjROajVNOFlRaUN6YnF6TnFZRnNRbDAy?=
 =?utf-8?B?RGJXNnppMUNQdzNMWU5jd0lwajVPVUtSdVBVRWtPak9HV3VQdFlHd2hRT09s?=
 =?utf-8?B?aXBpRXFyV0tFaSswSXZ2ZFVHUVJOK3ArT1hrZGd2NmNrT1NkbUgxeEpvem9v?=
 =?utf-8?Q?7/vqLFbxhPUzvHGYySMR41rYu?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d89c779-51b4-4f02-189f-08dadcb2e479
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Dec 2022 02:36:52.1308
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wF3l+p1JpQY7pRkT9TnVtI7TPJ9m7W5h548HkKWyeT0poPCsspAUqfAjC+SJ88mLC4nePLKUAlpo2twpzHyplA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR04MB6948
X-Proofpoint-GUID: jefesoyQjk3DZS28J8mm9URqE8fRskkR
X-Proofpoint-ORIG-GUID: jefesoyQjk3DZS28J8mm9URqE8fRskkR
X-Sony-Outbound-GUID: jefesoyQjk3DZS28J8mm9URqE8fRskkR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-12-12_02,2022-12-12_02,2022-06-22_01
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
