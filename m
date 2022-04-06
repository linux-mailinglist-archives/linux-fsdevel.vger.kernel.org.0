Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87E974F6184
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 16:17:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234529AbiDFOT0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234983AbiDFOR7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 10:17:59 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1370584C58;
        Wed,  6 Apr 2022 03:24:46 -0700 (PDT)
Received: from pps.filterd (m0209325.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 2365Veke013519;
        Wed, 6 Apr 2022 10:21:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=QVfTa6YVHXGkDO1x2VxFw6b0S5LZvTZKZGOpa03nPoM=;
 b=VGV4Pgwpj4NwegwpMg29/1R4r304iAX4Yz3DDguILAtYU5xMY6/Z6wN+hv80sxCgI9jn
 KKl0DW8/OEz5REQ0K01a9+pSeBkpPwiFIRV/jvyK0w+YX3+aSzFl+conIx+PumNBZbEK
 74Dd4oFI3kmVDFQPX5itIESvPZYTNOftO6rsE8LD9bXs3Hd6n7O3+MQtJyIMn3yR4+hZ
 QGThnUIRqYdUMaNcVgnjpw/HOK59iHr+X1SV0uvduCo2UK2+/k7mTMpo360xhdZmhkSn
 xLi2aayW6uhbV1hESmV2Iq0ZMapJpAKcBPnzldDoWd2fAL94nnESlPQ2r+kPdtZeKkeR ag== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2048.outbound.protection.outlook.com [104.47.110.48])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3f8wx9gm8f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 10:21:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mT4Cr/PeygiA0KAfKIBEHPlwtnV8Npwt54kHqaqrrUXPn9gDZ/7S1XYu2eRX5ItUvw68kbJd2nQvOJpPRrS/iwXoiJnla3MannK4ZPLI7Xy7PYfqo2eO96FVwxbcfQT9zHdOwmGBvyHfKHyMfCoOd/ZSfzPtQBgD1CvkNjmNS3O5wMEyoCe0vm48nJvbyQ/xoDV1xmZViSba3cNIaVuaYYCM9AliqGdeQlbQX4ghsj8y0/52eDVEXMtbP6fd2wonCZ+95uZj5yjThkYIyC975lh8fNmX0v/9eIV/03bz8zrCYtRmRBbJONX01ZuIbCs+Epa5jQs9BhvUgLsVN2I5oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QVfTa6YVHXGkDO1x2VxFw6b0S5LZvTZKZGOpa03nPoM=;
 b=CNAH7UFh1wAjOTcBxFc40us5Tx31pnZ2uRKWRU9KcKOTFF4x0I/AlOVn8TKkg1m9LHrbzVXDa86G+SRG+m9ptEhU6WIAdFRApQm8lRpyeO7lfu/KhglMuGYTVb8vP+8/Ravz+F6W/mFXd10xLLzrpPlj8rjIBJfWFE1e4xAmK1MDHUtvWytmCP+ldG75QcPfxFzkKB8XA1530zXP4Ri6B2EHfjwcL4YBR6inFhbDMVjCP0atMb+QreO/2ChQYmrjPwhqegltmNPsmFGPq9t0fLH8+7yK3kKzaP50Bja+wXgVk7GA5aixRGs07TXrnVu6UEj1ZyMly2kN5LnPr/voBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com (2603:1096:202:35::13)
 by TYZPR04MB5632.apcprd04.prod.outlook.com (2603:1096:400:1cb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.31; Wed, 6 Apr
 2022 10:21:16 +0000
Received: from HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094]) by HK2PR04MB3891.apcprd04.prod.outlook.com
 ([fe80::7440:bc88:211:6094%4]) with mapi id 15.20.5144.019; Wed, 6 Apr 2022
 10:21:15 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     Namjae Jeon <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>,
        "axboe@kernel.dk" <axboe@kernel.dk>
Subject: RE: [PATCH v2 1/2] block: add sync_blockdev_range()
Thread-Topic: [PATCH v2 1/2] block: add sync_blockdev_range()
Thread-Index: AdhGQJxpg7LpERZLRKCnO5+IYADlBABnxzoAAG99VxA=
Date:   Wed, 6 Apr 2022 10:21:15 +0000
Message-ID: <HK2PR04MB38910663E1666A0C74A5618781E79@HK2PR04MB3891.apcprd04.prod.outlook.com>
References: <HK2PR04MB38914CCBCA891B82060B659281E39@HK2PR04MB3891.apcprd04.prod.outlook.com>
 <Ykp5cmdP3nV8XTFj@infradead.org>
In-Reply-To: <Ykp5cmdP3nV8XTFj@infradead.org>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a69fe55-4568-4694-afe2-08da17b72ece
x-ms-traffictypediagnostic: TYZPR04MB5632:EE_
x-microsoft-antispam-prvs: <TYZPR04MB56329324F2B4459093E36C6481E79@TYZPR04MB5632.apcprd04.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: zb9B+ZGI0u1YJFuf8UuZpgUyobX+yD2D7mSLbwEkCtDFBeLjNOgblKBDn6bkWP5qN3uS/mHSnoUmtSULNz29V4etI4BTTCLZoGJOPxsck/hgyE52URMJ9xxk6gcJZVHptWqyVTGbw8otTanIOhqxc+YqLWisfFns2icG2RwlBKt72e/HUgHtYrOY5aC11p2DKdpLIfwogQqXmvJcd9cgap5KaRKtLsuxewc3BTxklj8iwZ/Y5LyKxMDqBKZB37xdfowxFikA+U9NUIvIeSWMU7qdsGlgx+uxvwyi99tPtkIv8V8GhFftmGzoZn+7VqZlfFUhkNcrjC8nYhOMD3huMEB3AOtZHZC5tn5C/CAJGfn6a6YqXRxRuOEEwWZ229T+DX7U51VVpaakwCxBneCGMFP5a7XFCqNXAimvkcm2LAg/l8vBVFvA0PfyMZf8Ow1CBvan8tBdciR0MXY+ojyKL/sc9gdlhkk0uzBijH9JoA9LNZF5/kEA7yeqZK7FfMwJ1MOkhrPaDpBFGyvwsj/SrQcIm8pEQXlRRdC+jIzQbM3pxw6J/EdEH8tR4Uc96uTAUYkNVL/K8ycQ0MbYTJ9WRC7h4Y22VydXbbHZq+L8w/qkvk/kNKpeSxZhz0RvnRt1jpx66ArrC5j2Z0cZLsGWIWe+Sp9X4LzD7Cgxv4eYyNSEulBpnpYgFTy4Ih/FKjtGynxpPqfKJ2U9I8A9H4XN9g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:HK2PR04MB3891.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(122000001)(66946007)(38100700002)(54906003)(26005)(186003)(6916009)(76116006)(66446008)(55016003)(66476007)(64756008)(86362001)(4326008)(8676002)(66556008)(7696005)(6506007)(82960400001)(316002)(71200400001)(9686003)(5660300002)(4744005)(33656002)(83380400001)(2906002)(508600001)(52536014)(8936002)(38070700005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RnlpVnRBZ3RHdTBlYlh0eG1EZkFrekp4b2ozQUppUXNVeDhEeDZodzNKekJS?=
 =?utf-8?B?cytvQVVyRFFBRUxkY1lWVXBHL1REdjcwdmdhdUdOM1lHWTMxTFg0RWJ2YS9x?=
 =?utf-8?B?b25LVk5EOFNTOFh0WEFUeUZzSnRxTWtiRnNIT3NVZmwrMnpRWTF1bUpWYnhV?=
 =?utf-8?B?bFp3ZjZ5YVRERHl5NHlLeG9udEUyN25reXJQbjhyekZ0WUtDWXFjMk1pQ3dn?=
 =?utf-8?B?T3VpZ2ZjYlVhZjN2b0p1dzJrejliamU2MjBBS0NqTGl4THdUZHRrejZMUStn?=
 =?utf-8?B?YW9hTy9tYWZPOXA1a1V6RDZwcnU1R3VkNnlkZUxxSnJTZG9VQ0hkY1l0Z2ty?=
 =?utf-8?B?N3pkcFdJLzB0Zm91NDhadjBmMm9KdnFEMGxsNGoxcVlKUVVISTJ1SzZncERP?=
 =?utf-8?B?cEczZHVMS2Q5T1FDelFaY3UwVnNTUkp0N1c2VUcwczVPajJWSGxIc2EyK1RE?=
 =?utf-8?B?TGs2V1NmTFA3dUk5WGN0NXdJZjNONUE2YTJWc0JWUWRwZmJZNG52cDF1Qm1j?=
 =?utf-8?B?cDFaeGR5S0JTWFphbXBXREpEaks4aVF6T0J1LzZ0aUt3QmhIcmV0ZmJPVGJC?=
 =?utf-8?B?L3N5RVBHR3Q4YlZoVGIxNHZLZGZCaFlMaklQblpia1lCZHk1bXdNSlk5bVUz?=
 =?utf-8?B?SDg4Y1ZsOG5HcE1qdHVsZGszOXdGMGxSM1dzNm90Yzc0eGZIdkd4U3BsbVd6?=
 =?utf-8?B?dUdndUZLVFNMdUdDVHl3K3J5Y1RPck40QWV0ZTJQa04rZHBWSFdjUmcrU0pi?=
 =?utf-8?B?R3JoUm04dHd4K0ZzTUxNaEJmU1NnNTFBcW82THA0OSsvTXZkbUM1cHRBYXpo?=
 =?utf-8?B?M2lrTk4vcm1EVjU3dE93SHQ2VU44K2RERXR3bzdRN2h5N1o5UStXWlR4QVRw?=
 =?utf-8?B?aU1IZ1pBQUR6RTlmSVo3SWFIajFvRTBkcmZ1SVNWUDlKTzJPK1Byd1FZeVIy?=
 =?utf-8?B?QUxONFVEVG9HVU1EajU5VmplVitxK0VKcnRxK0hKV0NTZEJiNy9BQXZJaEl3?=
 =?utf-8?B?SW8yNzJndmswVUZseTlGK1FBZExKdXBTalhBTE05L2lhWE9BSERFbm0vYzZ1?=
 =?utf-8?B?bVZqTUZUNTB4alNvOUx0dXFnMUdOSzJjZUpGWW1LUWdnL1RmQ3ZNMHhVaEZU?=
 =?utf-8?B?UVVQTTVkUndiejlTck5pZlY1NFh2ZllFd2xMY29OcmJHU3lWbm54cnVMUTJJ?=
 =?utf-8?B?NjFVY3MvM3kwdGp3cjJsa3JhdUFCUThlREI1dEcwcDcyenc2TnZTSnF3QWUy?=
 =?utf-8?B?Z3B6NFFtNmc2aEMzYnVoK2NSTnRkU3ByMmxFWXEyLzhRNi9XZFBVQkRjWmk0?=
 =?utf-8?B?Zm1mVnl0T3FTVjlSSi94bk5nRmoyOWVub3NkdnI3QXVWRWREZ25JUjBMZEJt?=
 =?utf-8?B?dklKVENkTXl0UE9veUdvNVdWbUovYTFBRDlicXZGQmNtWDVQdnNxemZWNURN?=
 =?utf-8?B?bmVEb1JnU3IyKzZ5a3JyLzNaMGVDTGFnRGkzbUNsUUJoUHlMdEYxMDhxYzRB?=
 =?utf-8?B?N0w0VnRQSytUaUwwTVoyd0ZtZmRIOElxT3dOQ0pGRk1Ec2hSTWJIQzZxejFT?=
 =?utf-8?B?R2QzaFlybFhOcFZzVzE4R1k0bEw5RVhMaTVjUStjZE96TWNxL2o4N1U5QlpK?=
 =?utf-8?B?VlFxU1RpVjhpN1JIbzlGR3UxWkJNbDd3ZnozMlFZU1hHQW9sN2NTM3ZtVUhY?=
 =?utf-8?B?V3VMVTA4U2hOOHFDNXpKeUZieUEzWFh1SjExMlFQY0Zxc2NMQXVFa1lSZEJ6?=
 =?utf-8?B?cXEzcWt0L0tyQlVmUEQ0dHVBeTVIUHkwVThML0YyZldJb2oyTmtVa1cvbkRN?=
 =?utf-8?B?a09JbkpYUEZ2cG1raUtqSXZEbDhNNGx4dkVUZUVDalBnU05kWjdtU0Fkdlhn?=
 =?utf-8?B?Y3hYdFdUVmt3TExjdTdPMnBzMENvNm1tZUgxRXhiK1p4TjlGKzFaQ1duUWVs?=
 =?utf-8?B?ZUtybnpnTlMwYVpEd2IvOFUwM1NaS1lqSnp0ejVUNjlKUWhNZ3RtVXlwZWtY?=
 =?utf-8?B?am5QVkZuM3hpc0I3THpSUWw0R2JMMUJMTjdiSTlrTThocWptUjB6T0pvZ1Iw?=
 =?utf-8?B?V3FtdmZkZFA1NHlPeFNtVjVKdnFlLzhpZXpDdHkzLzhZbUhUajZNMXBCL2pR?=
 =?utf-8?B?S2R1dzhSMGRxSmthOUtDb2paUkxIMzhBR05IeTEvSjBVUkw4THVhL1RhZDNu?=
 =?utf-8?B?TWhWS0Q0cUwvKzF2VnExRkdnZm1aQ0xMbG5vMitoeHVQRjBxVmYxRVNvY01B?=
 =?utf-8?B?RTRaN0w4cXJoZG1Va1pRU29pbUdUSitPVUdvSDRxV210RGdzN2JXMkltYldQ?=
 =?utf-8?B?dnBoNzQxeDlOdUpoQndUc0ZFL01Kb0FjS2daMVlkZmozVHBNajgrUT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: HK2PR04MB3891.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a69fe55-4568-4694-afe2-08da17b72ece
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 10:21:15.4660
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0ZAaWRoCnxtFt0ZlMHlizNsFL6tfa1VYUM16KQinUKSNHVQt/MNnyOP415xyr6WNwuO5BbFw3yXR3KxhCMPtdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYZPR04MB5632
X-Proofpoint-GUID: q0afPo94CCKZXnx8yaS8ha7ztQuuJ2pA
X-Proofpoint-ORIG-GUID: q0afPo94CCKZXnx8yaS8ha7ztQuuJ2pA
X-Sony-Outbound-GUID: q0afPo94CCKZXnx8yaS8ha7ztQuuJ2pA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-06_03,2022-04-06_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 suspectscore=0 spamscore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060046
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiBGcm9tOiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGluZnJhZGVhZC5vcmc+DQo+ID4gLS0tIGEv
YmxvY2svYmRldi5jDQo+ID4gKysrIGIvYmxvY2svYmRldi5jDQo+ID4gQEAgLTIwMCw2ICsyMDAs
MTYgQEAgaW50IHN5bmNfYmxvY2tkZXYoc3RydWN0IGJsb2NrX2RldmljZSAqYmRldikgIH0NCj4g
PiBFWFBPUlRfU1lNQk9MKHN5bmNfYmxvY2tkZXYpOw0KPiA+DQo+ID4gK2ludCBzeW5jX2Jsb2Nr
ZGV2X3JhbmdlKHN0cnVjdCBibG9ja19kZXZpY2UgKmJkZXYsIGxvZmZfdCBsc3RhcnQsDQo+ID4g
K2xvZmZfdCBsZW5kKSB7DQo+ID4gKwlpZiAoIWJkZXYpDQo+ID4gKwkJcmV0dXJuIDA7DQo+IA0K
PiBUaGlzIGNoZWNrIGlzbid0IHJlYWxseSBuZWVkZWQsIGFuZCBJIGRvbid0IHRoaW5rIHdlIG5l
ZWQgYSAhQ09ORklHX0JMT0NLDQo+IHN0dWIgZm9yIHRoaXMgZWl0aGVyLg0KDQpzeW5jX2Jsb2Nr
ZGV2KCkgYW5kIHJlbGF0ZWQgaGVscGVycyBoYXZlIHRoaXMgY2hlY2sgYW5kIGEgIUNPTkZJR19C
TE9DSyBzdHViLg0KSSB3b3VsZCBsaWtlIHRvIHVuZGVyc3RhbmQgdGhlIGJhY2tncm91bmQgb2Yg
eW91ciBjb21tZW50LCBjb3VsZCB5b3UgZXhwbGFpbiBhIGxpdHRsZSBtb3JlPw0KDQpUaGFua3Mu
DQo=
