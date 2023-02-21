Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 049F569DB48
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Feb 2023 08:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233657AbjBUHfD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Feb 2023 02:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232650AbjBUHe7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:34:59 -0500
Received: from mx08-001d1705.pphosted.com (mx08-001d1705.pphosted.com [185.183.30.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D58B823302
        for <linux-fsdevel@vger.kernel.org>; Mon, 20 Feb 2023 23:34:58 -0800 (PST)
Received: from pps.filterd (m0209319.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 31L6rl2Q003747;
        Tue, 21 Feb 2023 07:34:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : content-type : content-transfer-encoding :
 mime-version; s=S1; bh=c1cMvyK3NSTnm5NRLqdZRfYYSZ/wK6CedQmmoBPGvt8=;
 b=dsv8e4nbs3uhWsBxWvm/0TWfuvMyhL2G+/XnMIeEx6vd+tvHTYMFl7E7dmrSAT7PkW9A
 gkK0cRWROCgJHlVdPg9o4t6Ij9U7RnFXa3+Rp7VIXzxEcJM3slOgcrQrMcg39F6VIfXz
 wT7mKMw6xVLnuw/wI4XW33oKXuUlnWAdo7vGxenIUI6LFqlzE6svwI4ts55Vb2tNWQ+u
 b/rjjnU4maE3GKXSmmC9XnQkgDs/ID+Ueub1oJIusJdW7uTNjC7SDfUGQV2zpznROq6S
 cZVII8d2Qm9jUJhZSwfuwIQNL7wrlXWiQu0wMiN2aaka81bZwhqKN7mhGbrFIeOrRecZ /w== 
Received: from apc01-tyz-obe.outbound.protection.outlook.com (mail-tyzapc01lp2046.outbound.protection.outlook.com [104.47.110.46])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3ntq2sttb1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 21 Feb 2023 07:34:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KtP77k00/0T3XI3B8GAVKXHvxWgWQbCX5K9Lw/iEUuck8ML3FwfmnrYC1wf0OFDK4zPjg//RX2R8JV6wNolcBNcylvcde5v48lhZpuFDFivsLD1vHfgUu+g6VZ3O5TpqJVuxY2dZ5qZDTZvnxTwSfV2N5VLbQzV1ivO/Re6KGn0I4GHSaGI/oaN0HQyk9moFvAxWToKSDUEQCIASs5f8lrnGiT35y0LI+Kg4Ml5hMn8mwaEjYh+XNJlBdsjVTNxE95hf7hLWP5H6dQRtt/DZrwyEcNqctk3hxbBaR3gXew3akhPYiQUuoP/EriW+07jPb0xytvKtPNY0BbXQa8ge0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c1cMvyK3NSTnm5NRLqdZRfYYSZ/wK6CedQmmoBPGvt8=;
 b=GcxkF9eeih1IdLTkVo+Yvx378Llorm9HVaQOxTEPfwhzyngkNDs+hsJP5l1igiEd2Rfmdw4SQdmfhaRpvj294WqwyEaoTqAa1raQBIezGtUM3nBJB/hVkTWEKFmoh8sFf+AlfswKAbPZY0cn1r1dK9WIXccnS2NL/THyVmTRjVkxvCtKyCFnMJRegp/61Yw8wpe02GVtbeu1t30TZHENBQ99FBQjfQbl1hM+rrt3BUF5z6vOQFbZMPy1pptqwvFpIZ7u4Np2tudQlHTWoZtpk37vU5UyRsmXW6g0/ZxzvuE/ieEck4pDePIs1KzWiHp+rFZLAje+LzB+tkFFrzJk/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4165.apcprd04.prod.outlook.com (2603:1096:301:34::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.21; Tue, 21 Feb
 2023 07:34:42 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::779:3520:dde5:4941%7]) with mapi id 15.20.6111.020; Tue, 21 Feb 2023
 07:34:42 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     "linkinjeon@kernel.org" <linkinjeon@kernel.org>,
        "sj1557.seo@samsung.com" <sj1557.seo@samsung.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: [PATCH 2/3] exfat: don't print error log in normal case
Thread-Topic: [PATCH 2/3] exfat: don't print error log in normal case
Thread-Index: AdlFxiFlnzIOBZgURkO2gsQA24A40Q==
Date:   Tue, 21 Feb 2023 07:34:42 +0000
Message-ID: <PUZPR04MB6316E45B7AB55F18F472503481A59@PUZPR04MB6316.apcprd04.prod.outlook.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4165:EE_
x-ms-office365-filtering-correlation-id: 60ee57f1-a70a-4c4f-6b30-08db13de1904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: jFNkGFhvGH5j29AFXGx3Zt2eBfNHYO2DwZHJhObdHdm+mABCk4XTGCKSdPCYApD4jJm8Qxp16MkCF6xG2oyHY2VzG/fk/F9zyJl851Gh9BOWQRiVX48oEipyzYINgKjEkYiHt1nGUg9blULAsMxG714zcG4qaeqBTdtCkKJR/Z3te7lZC/XhZIXGElI0hdcdSWgmnN6QESq4INHbxVmxPK2jbaWNyuJ26Cegd3m3fZuPDjofnJNCR3CeoayEC5gYaQ8U8wJWga2RyoIqVMrNuMXiZ1qopkf3jwUtUmLhgPKTVjggfB48mAgbYBSYpRa/FwucW7sPgk6ft31eHz4IW6rdJwc4beEbx5Qe2/qI32ZeLLY/rSQxAUgZArzZHC+2AfpiJtFrU24sNxWBYAt5+0+kz34C+Z/1j7DJYoeMlJDW5aM5rNJD4YQbf24NMXQ/PoXvyikQzcyCbK2WZY6v3aEQ7NqmEkfq/pyXx+Kd1UUHvMjdAq10IT9ivhwo9zWaII8hiyuH539bDTyuN+zkf6oQJPWlLXGdzOUNbZHWd8etBpZ3gYt/oVjkmZVUCvapQsHSHpoWAGIPck7zQPxS/mXKEGDq8GyS3ncGA6GY92dhNquRlqRbFp76Qu2YT7AVYnHj/ww354oFgL7/XTYdWCcsvFK5GhYmikOmCS9k19DPfBZrPoi+7P99FpyMpASQMKXmaCDCIGsIyHZEHZSBBA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(376002)(366004)(39860400002)(396003)(346002)(451199018)(82960400001)(122000001)(38100700002)(83380400001)(86362001)(316002)(54906003)(8936002)(5660300002)(64756008)(66476007)(8676002)(4326008)(110136005)(55016003)(41300700001)(478600001)(38070700005)(107886003)(33656002)(7696005)(76116006)(66946007)(2906002)(71200400001)(66556008)(66446008)(52536014)(9686003)(186003)(6506007)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RzE5dWw5U2NzakViaVZLRmdUTmhFV2NYYTFCOEEzaUxoSkdYbDVXWlg0WTZP?=
 =?utf-8?B?UWwvR3M5QkpYYVNNZ2JPbGlQaysrcFQyY1hmdXdkanJqVTV2a3o5R2grL3hC?=
 =?utf-8?B?dk1hbFpQRjhiZHdNYXJ1bnlMR0tnTzNyTzh6TzZPRGd1KzRobzh5cU1RKzA5?=
 =?utf-8?B?OXZIc2o3TC8yMi9HMDJQNm9QZ0pMUTdjS0dWemR1aUkzZGhrVDRtQVNhL0NU?=
 =?utf-8?B?d2U2Z1VCc3NpclJlM2Q1cGFIV3QyTW96WjcwblE5ZWdmc0FvNWJwWTFKTWdR?=
 =?utf-8?B?SmZhbG1xY0oybHo3VG5hR21mM2tGUlFsOW81K3lWbmVsSHFpcnVTVFhlRE5k?=
 =?utf-8?B?c0ZMc0xVdzdGRm9TTnBkVUlWaHdmeWZkZWpNbWFXRjdHaU5DajZ1YUNGWlFW?=
 =?utf-8?B?UDhScS9GUURkb0NzdFYvUFRKaVRaaFVEYW0vbmhHcElhbDFGVTI3LzExdHlO?=
 =?utf-8?B?QTRhV21XTldoSWUzc0ZDSER3Y3NZT2FGamhTdkxFRHNvQmU4Z01Ib3FUa3NZ?=
 =?utf-8?B?UWs1clBsZHpudGo5TlVUNWFFQk9HUDV2VmR1WmpaTHBXdHpVdk05MWlOMzJI?=
 =?utf-8?B?ZDVQR2VBQTMxRlEvTDU5Q2grVmlpbk53eW1hTzdQV2Vyb1lwSzIxcHFVc3h5?=
 =?utf-8?B?c3dTVisyZktCOG1rTEZFYks0eUUxMUVlZWlxVkx4bG00b1NxK2p2VHNZSXV6?=
 =?utf-8?B?b2taZ3M3YnNTa3hMai9uTEtVNGs5ZHVqNXh1YWVmOFpTeURkZU1QVVBUa01R?=
 =?utf-8?B?U2FkUUd1eDRkTDNJOHNQUWdHazJydFQvNzIzNVRnd25hcUJkUDN4SFR6ZUdG?=
 =?utf-8?B?WHVySEZJRm1zb25JTkU4Z3Ewc1d1S01RQzhnZEI1QUgyaVFKb1JjQ0s3bEFN?=
 =?utf-8?B?WHVqVEI3OW5nZ1hUK0xzSnJXSzBWTFlkVHdzTXhnQUVYR0VwTzVTR1lSVkpY?=
 =?utf-8?B?T0ZjaTljcXNXaXgrcC9oMzFvVVdqcXZNVzd6VndoZUVRV3BFRUxyMEJRMmJa?=
 =?utf-8?B?Q05lL0VoeFdqeklrbWJyK3grTmlhc2sybkFPeVlQaUEySUsvbCtHeGVrMDFO?=
 =?utf-8?B?N0JYZjlPSklPY3lZUlFqNmh2WlJ6TEM5a3I0aUk0cEIrZjZtTlFoQW5KYXZZ?=
 =?utf-8?B?WWZPSmlQcXBGZFV4R044VmRkSHRTZm5uZGpHMVl1d3loK3plUWR5ckptTW15?=
 =?utf-8?B?NEluTUFBSm9RU2h6dTR6SzZ1ME1hNlM3YWE4Z3gycW9vVTIyRWZwSyt0Y2RX?=
 =?utf-8?B?aWxlUmFHS0QyYXBpNEM2a1VocVpsL0hIYVJsS1EwOUsvYUp5bU8rWEpKd1Vr?=
 =?utf-8?B?MHVQd0FxTmN2bU9aMzlmWCtraExYalBCWnRRVExWdHE1U3laaG54K1VwWksz?=
 =?utf-8?B?QjZUWkNnWHkzall3UlQ2NjJ0V1hndm4xaWtRcnFiS0RKS2lTeTB5aVk0TmVL?=
 =?utf-8?B?VkN5eWF0ZWdXdDZKQWNRMmR3bmoxbnhjTkxRemVZZGFvempDUXZsMUx4QmVD?=
 =?utf-8?B?ZmZkbmt6UEgvSHFudDQ5UGVyNElRZ2pFN3F1N2FBbmVVZ3JtVVh1TWRuWGdh?=
 =?utf-8?B?eUJQVjZhMFhOQmJUeVZpNFJkdlp6eDcvM1VnUThjdjFodGF3N3FBeFZFY3Nx?=
 =?utf-8?B?dEVKc2c1MUVORXREeUx6MFJKcFIrbG5XTVR2cm01Vi8zT0E0eHBsTkZRdHlR?=
 =?utf-8?B?ZldUc21xeGpidjdqMnR6d0hjaHpjenNHeTRNam9qU0xZZ3hXcjY0Wmk5dFBy?=
 =?utf-8?B?SjV2ektIV1hQV1kvYm85cWFHUEsxTTdCcDBFSURSekF6OGZRNmVub1hoMHBq?=
 =?utf-8?B?OUZKSythMHluY2Q0QnFzTWZTOTdOTzFIZ2tnT2djRWVvbmlnZXRZSFVQd01y?=
 =?utf-8?B?ZXJRNm01WjRVU2l6aC9VOU9na29IZ25ZVEpNUWRKS3paYkZBVDU0bE9MWlVQ?=
 =?utf-8?B?QnhMMkJLeU9jeFl4TG1saUJBTGJ0RXhKZlpaZGE5TDNRT0RUT29WamxxeXVK?=
 =?utf-8?B?bmdzOXN2TEdpVmtjVDdGVmhOUzNzcllkOFQrN2NnNWNCazBkOS92bU5XOCto?=
 =?utf-8?B?K3BaZC94ZHQ0TjZHenFuRGpCM0ZDMXNmSVorZkVvdklvdElyQStZRlpNSTVx?=
 =?utf-8?Q?CzAUiZuBnZPYQhuW37p4JohsF?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Me5jP2Q6J+C7TYbUAMG7bpAt6wqu4KmxSgXppLa9ZwCTZXcmPEvOnfwk8b1Q8GU6ZXRKquKzEi6MOuQ/arUPSZjgBQkhwbT+sjS8w4We5ECOHMjTDCCuLja2YGMlLC80O9yU8RcwqTEA2pQzYe+FPcSCjAVMYWAmPrzk7U/4cgBqGU4vFQkT/rIKmgMgRRUwn68iEZP34G5jpPWglfrAE44y/WKV+DdWaWHlgpPQr4mcleh7+XDrsgsgiGDpvZnLhF9YQNmLeXAVXEK4JBs+9kCkqZD8aBnU4hmgOn6gjcIvXbux+xVGiwM4avBA9LSWpqKyEQZdvajptsHuchexYdXhSCsR3lx8BMRWd+DclO3mrsq9zke+tm4XF56lhSxcXCx4RK/PiclUskS6yh/QDUX9XnvgbEyCbdHFXmEQBf5lC/L1gNQBpySnvHQACt1LZk+wrPWJt47UhP1r9CSbnNaCOvsjD43jDBaiF3wEJkweMhMSgc/eZTMPIJRotkWQeTiC9Ae9DSS0CYJSIdoMLjvKpZROgtsB5JIW/pdf18AfYR/b+0B3aB6GlnolViLtFbVrSIajCVHcdITU0nRkdvKaV2ETIbSNndVrIw9MKzIhvbK6CatHK3HO/P8OHsxBBusy2/kAdAidzAycHl3UL9lIqoSBFEr4cExO38cFyMSt8Ev19xIWtfyinCgzu5nm5BnkL2iAaxwAMutEiw2zmasI+BM0E+4wkyWfb/VJJZX7vReEfB0/35FUGKcKfrwmmuKrjgReKEzqPoYvU7UwigWSRob0sm66SFCX9KKwGlW8olMqe8wqjP9FJXvgk+Upo4tZ9q7cjbrCb5c82qupMw==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 60ee57f1-a70a-4c4f-6b30-08db13de1904
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Feb 2023 07:34:42.5819
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WhCz/g2BFC+txt2urrN2grc7ANMhmN0Vl4TD6QnKz3YFiHbNu/C4zivmQrf+OgQeXYax6LMiKDcrgmY/5fAXiQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4165
X-Proofpoint-ORIG-GUID: pQzcIuFm85-G_ODrNWadcNJBiIB1YTUA
X-Proofpoint-GUID: pQzcIuFm85-G_ODrNWadcNJBiIB1YTUA
X-Sony-Outbound-GUID: pQzcIuFm85-G_ODrNWadcNJBiIB1YTUA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.930,Hydra:6.0.562,FMLib:17.11.170.22
 definitions=2023-02-21_04,2023-02-20_02,2023-02-09_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

V2hlbiBhbGxvY2F0aW5nIGEgbmV3IGNsdXN0ZXIsIGV4RkFUIGZpcnN0IGFsbG9jYXRlcyBmcm9t
IHRoZQ0KbmV4dCBjbHVzdGVyIG9mIHRoZSBsYXN0IGNsdXN0ZXIgb2YgdGhlIGZpbGUuIElmIHRo
ZSBsYXN0IGNsdXN0ZXINCm9mIHRoZSBmaWxlIGlzIHRoZSBsYXN0IGNsdXN0ZXIgb2YgdGhlIHZv
bHVtZSwgYWxsb2NhdGUgZnJvbSB0aGUNCmZpcnN0IGNsdXN0ZXIuIFRoaXMgaXMgYSBub3JtYWwg
Y2FzZSwgYnV0IHRoZSBmb2xsb3dpbmcgZXJyb3IgbG9nDQp3aWxsIGJlIHByaW50ZWQuIEl0IG1h
a2VzIHVzZXJzIGNvbmZ1c2VkLCBzbyB0aGlzIGNvbW1pdCByZW1vdmVzDQp0aGUgZXJyb3IgbG9n
Lg0KDQpbMTk2MDkwNS4xODE1NDVdIGV4RkFULWZzIChzZGIxKTogaGludF9jbHVzdGVyIGlzIGlu
dmFsaWQgKDI2MjEzMCkNCg0KU2lnbmVkLW9mZi1ieTogWXVlemhhbmcgTW8gPFl1ZXpoYW5nLk1v
QHNvbnkuY29tPg0KUmV2aWV3ZWQtYnk6IEFuZHkgV3UgPEFuZHkuV3VAc29ueS5jb20+DQotLS0N
CiBmcy9leGZhdC9mYXRlbnQuYyB8IDEyICsrKysrKysrLS0tLQ0KIDEgZmlsZSBjaGFuZ2VkLCA4
IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pDQoNCmRpZmYgLS1naXQgYS9mcy9leGZhdC9m
YXRlbnQuYyBiL2ZzL2V4ZmF0L2ZhdGVudC5jDQppbmRleCA2NWE4YzlmYjA3MmMuLmI0Y2E1MzNh
Y2FhOSAxMDA2NDQNCi0tLSBhL2ZzL2V4ZmF0L2ZhdGVudC5jDQorKysgYi9mcy9leGZhdC9mYXRl
bnQuYw0KQEAgLTM0MiwxNCArMzQyLDE4IEBAIGludCBleGZhdF9hbGxvY19jbHVzdGVyKHN0cnVj
dCBpbm9kZSAqaW5vZGUsIHVuc2lnbmVkIGludCBudW1fYWxsb2MsDQogCQl9DQogCX0NCiANCi0J
LyogY2hlY2sgY2x1c3RlciB2YWxpZGF0aW9uICovDQotCWlmICghaXNfdmFsaWRfY2x1c3Rlcihz
YmksIGhpbnRfY2x1KSkgew0KLQkJZXhmYXRfZXJyKHNiLCAiaGludF9jbHVzdGVyIGlzIGludmFs
aWQgKCV1KSIsDQotCQkJaGludF9jbHUpOw0KKwlpZiAoaGludF9jbHUgPT0gc2JpLT5udW1fY2x1
c3RlcnMpIHsNCiAJCWhpbnRfY2x1ID0gRVhGQVRfRklSU1RfQ0xVU1RFUjsNCiAJCXBfY2hhaW4t
PmZsYWdzID0gQUxMT0NfRkFUX0NIQUlOOw0KIAl9DQogDQorCS8qIGNoZWNrIGNsdXN0ZXIgdmFs
aWRhdGlvbiAqLw0KKwlpZiAoIWlzX3ZhbGlkX2NsdXN0ZXIoc2JpLCBoaW50X2NsdSkpIHsNCisJ
CWV4ZmF0X2VycihzYiwgImhpbnRfY2x1c3RlciBpcyBpbnZhbGlkICgldSkiLCBoaW50X2NsdSk7
DQorCQlyZXQgPSAtRUlPOw0KKwkJZ290byB1bmxvY2s7DQorCX0NCisNCiAJcF9jaGFpbi0+ZGly
ID0gRVhGQVRfRU9GX0NMVVNURVI7DQogDQogCXdoaWxlICgobmV3X2NsdSA9IGV4ZmF0X2ZpbmRf
ZnJlZV9iaXRtYXAoc2IsIGhpbnRfY2x1KSkgIT0NCi0tIA0KMi4yNS4xDQoNCg==
