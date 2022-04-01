Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43ED04EEB1A
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 Apr 2022 12:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245165AbiDAKSy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Apr 2022 06:18:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245095AbiDAKSw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:18:52 -0400
Received: from esa7.fujitsucc.c3s2.iphmx.com (esa7.fujitsucc.c3s2.iphmx.com [68.232.159.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEBB2264548;
        Fri,  1 Apr 2022 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1648808223; x=1680344223;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=VofugQ3+cmVSdchW8ixSBX+3j0pGJ21j8jD+hnpSVeI=;
  b=HXQLoQxiM03w108GbxRW/NoT87FKf/uHquBuMZLkfvBFmgzCTvsdxdCN
   9PFBQ4aOuCM4WWIRuhLn7gCLSatc+aL5tWlscg+e1kCocp+zAi3d0s/4x
   dBOROvSWVmTR+p8KvSGbQA2jAMSPmDL9okJ+5NeXTasxrG41UU2k32dVH
   8SXr0hMFP+z4kiR0xx1s2kwy/4cW7v1x3U2PZB7R5SSHskanDI9/synKw
   c34Wyy0BlGH8JDgP1NzUMyNunGJwGxuK5qLwv1NXT1RNMtAAnlCJ/W0Nu
   6EmvLpb/1ELKCLwTFQt/3L6/m6gZcKKVYLsT6yHMBM4vPLHpFmDTtdBHF
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10303"; a="53090659"
X-IronPort-AV: E=Sophos;i="5.90,227,1643641200"; 
   d="scan'208";a="53090659"
Received: from mail-tycjpn01lp2169.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.169])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2022 19:16:59 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dr2woOCaaO4xyD0eOugegMcx4iozi/7IfLKXfUblP+YnZkwvSdCnvSvDshrZIreHFsT5OLTi+FFsQ2O/827zSD7f9TbMAXSKfHm1tzbGEgTvjDQ0zmnvZDE+qodM0G7YgJJjK5/OFmW79PMLM4XWy2d633xkv+j9YAkuYPbk5CCHX0T0jt8ZIFWVCY6CIgvSN4tGSCood5EHiESTuGiamrYDL9XV7E5FJpTpNYEgcWGkEVOxnvDUQyTxRe+jNYttY4n+/Qh9mcnTfzb4MJ0BpE+CYw60NEIoEWjgdcYxpigzvqZIw8VcQ35T6ikFehHYA1ziXob1HC7hQso/pUPfXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VofugQ3+cmVSdchW8ixSBX+3j0pGJ21j8jD+hnpSVeI=;
 b=SPPNdbuSWib68eK1aeEAeCTBJ4/1fIzP77O3GePCYi9hREuWvmQHpEyY4FKDYjNpzEhBS9v8Hb2PiW/WcnhebKLKstR0PWueDmfMcJfXpjkuXJy6qdGK20RSpu1JR7lf/d2sjbBi+kgSkLoKZVjm/gMZHieXv+5949WF96Kc7dunIWnmM3pGQEhCPMtl15Eov1eOi9iSwf0KIxGDUD7TXHOKyN23G7RKr5b+YLBTHuCTM7DdDIk1j78C8gzaGVqtnEeOYkOEJ1IY0K1Ec81zOZZeZNdoIMSwKIYJ2UYzCZgM5Ptq70WBplm7Fl6muWMYNRTFErIeJb4hYDb0HQZtxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VofugQ3+cmVSdchW8ixSBX+3j0pGJ21j8jD+hnpSVeI=;
 b=IQa2KDpVqgDV/ypZWDpSrDZznPtx2m6NGQun9/d0VWNvdljKJDMP3tQg2hB236fMTfYkRUmvVhnYvZBOfWuehc9m/mD2N4IymyktgiB64QsNx+Hd4t6akirvclaHZ172Bn3Z+X5tpmw98Tnas1svmIrKMbDtJyR0dyrZNiIUtUs=
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com (2603:1096:404:10d::20)
 by TYAPR01MB3008.jpnprd01.prod.outlook.com (2603:1096:404:8d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Fri, 1 Apr
 2022 10:16:51 +0000
Received: from TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354]) by TY2PR01MB4427.jpnprd01.prod.outlook.com
 ([fe80::dd2e:e671:b3d5:d354%6]) with mapi id 15.20.5102.023; Fri, 1 Apr 2022
 10:16:51 +0000
From:   "xuyang2018.jy@fujitsu.com" <xuyang2018.jy@fujitsu.com>
To:     Christian Brauner <brauner@kernel.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "fstests@vger.kernel.org" <fstests@vger.kernel.org>
Subject: Re: [PATCH v1 2/2] idmapped-mounts: Add umask before test
 setgid_create
Thread-Topic: [PATCH v1 2/2] idmapped-mounts: Add umask before test
 setgid_create
Thread-Index: AQHYROG1nkif++qfDEmcNMEnghbLd6zZZKyAgAEvugCAAEVCgA==
Date:   Fri, 1 Apr 2022 10:16:50 +0000
Message-ID: <6246D141.8000607@fujitsu.com>
References: <1648718902-2319-1-git-send-email-xuyang2018.jy@fujitsu.com>
 <1648718902-2319-2-git-send-email-xuyang2018.jy@fujitsu.com>
 <20220331120239.uzliits77lfmn5m2@wittgenstein> <62469728.4040904@fujitsu.com>
In-Reply-To: <62469728.4040904@fujitsu.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c396d183-4129-4a59-3253-08da13c8bd13
x-ms-traffictypediagnostic: TYAPR01MB3008:EE_
x-microsoft-antispam-prvs: <TYAPR01MB3008B0B24CCC5EA0228C8966FDE09@TYAPR01MB3008.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sM2Ze7X5JsMpGXocJi/tUZIIgJ2W+EchwSQz14XEDhXvhnp9And33Qz2S2eiru2nPsTe7xIWWHWa2CWrqlFuBOf58rfZiemh+8TzRyVFhIFbm6i6cMwbKddHoc4HWkeL5Wn52zx2TxblfrjfeQoq2HcLaVJ8aDr7TVWbF1q1gOVXIMg5PeZj7Rgv+Gedo7P6j1tZERbSmFW7l/OCD5hx9D2yJVlEygy/1VOl/QXslcwXzicK6B4+6eSHX7sMjgaWULHJF9qBAjT7vX548iPUE3GlnC4SN9Z1/1AoAQttHQ8x7YqhJGhuXMooY4UMtUIEpqNEedScSwg/00m2YIsT/az73xGP2F3/0WHTSpHRSlrHEOA4tG80SuswpRhFNEr0pf8fNs1fKYYJ/l76l+aou3P/cRGMnZ0MRBSC3qZx45Qtl+z1Na5I78Dv5wKsz6lkbciK4rKuKKO54+3MY6rrT2heIdAKpygwQiFC+5QXmjPu9o6RK7AyGgFxxE7S2C8P4iHNjcRcBYCiyFOltnA15Lbqt72VYadqR8c3Bf+pNOBuXHzDm7fGsfxlRteRlsEsIkEw8DvnTinmIO2znOAG9vWKJg/TR1a/DT/44rKXMDOfx0NCuJAronJkm9dtiHH1I1p9bdvtZ4jh/ySr2FchqbW+kqxfr1T9drXBhvlb25iLRDZwUYdKhVFybN0Z05/pJNvjmy315+JIVRdNJLHTWw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR01MB4427.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(54906003)(2906002)(36756003)(4326008)(8936002)(316002)(38070700005)(6512007)(6916009)(5660300002)(2616005)(26005)(85182001)(186003)(508600001)(6506007)(86362001)(91956017)(64756008)(83380400001)(45080400002)(38100700002)(66556008)(8676002)(33656002)(82960400001)(66476007)(66946007)(66446008)(71200400001)(87266011)(76116006)(122000001)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VGx6cWZzc0FMSHFlck41ZmpCeUNSVFltczI3Zi92SGhoRDR6aUdwa3hPTGFk?=
 =?utf-8?B?VXhWLzN5TFByS3JnVEFJUjVVQkNKUG4rVUdnWURSYng3c3NEUU1rRVBRT3V2?=
 =?utf-8?B?amN4ZUM0Vml2UGtFdW9JRUM2NDFGbGJoMGJOQnJzS01Oa3g2WEowbTRTN2xz?=
 =?utf-8?B?QitWN3JoMUpYU3NDSkppOEVBUUdFcEh0QS9EcE9oTDg1NUk0bVQ1eEQydlZX?=
 =?utf-8?B?d2dVem8xQ3lUaWZMajRoVkw2NzlpTWNKc053WEd5UU15Qm11V0ViSE1DOXNy?=
 =?utf-8?B?Vm82amlOUjlvdll4RUJkandPclZpQU50T05FNmxHdWxqOExiVVlOeFdMM2ph?=
 =?utf-8?B?MEhqK2kvanR1RmprcTNyK3FSZElFOGRTRDA3aUx1eHNiQmhpZ2VNc3pWa01R?=
 =?utf-8?B?TldZYmJXdE9vZ251dzcrZUZqQU5wa1FvblIvTVp6TkJDZGhsdlVlOWRzK1pL?=
 =?utf-8?B?ck9ESmp5SmNKT0ZET2k4enI3U3A2dmJ1NUppV1BVWmE5b2RISk5JKzRGNyty?=
 =?utf-8?B?NkwrM2dmczFvWHM1TXFSbnkyVExjSDI4NSthOWxiVnVmYnZxTFIwRHRPVXhJ?=
 =?utf-8?B?Y0JxZ2NjMnJIM1hQaUpEWm5DelRVMHczSDIvSEc5VGNrSG5YQStiaVZwTDRI?=
 =?utf-8?B?MC9HMTB0eWxpYXZ1YzNVM1hMRjlIM0R5aUFjNmZ4SXBEbmhrM1QrcCtub1d2?=
 =?utf-8?B?OGo4OWQ0ckNPaXZsUGMrVUt2Z09LdWxmTHl6TTJzQytvMWlnMk5hNFpEaEF2?=
 =?utf-8?B?QjRYMHBGeld4YTNGSDQrMlR3UUtCeFZpUjdqQ2pRN3c2QUd2TUp4UXBIUWg3?=
 =?utf-8?B?RzRxeXRXUndCdDZ1WGliOWM0UW1hZDUxKzE5VUhBWXVkS0ExSGFQcld2OW5K?=
 =?utf-8?B?YS9uSjVaRUFRTUVNRnBSMzJ5NjZzdTN3N1BjN0MydVVYMWJUMjNnbTJtV2xx?=
 =?utf-8?B?bDdYcy80bUIvS2pIM2daSWZvajhRVjRBR1M1amFvbjFOL0pIV3NHb0IxL0ZK?=
 =?utf-8?B?cnZpaWVJNHVBYk04U0cxOXQ2RVIramFSZGRhMGZVVUMwdXlxQUsxRk5BT2dk?=
 =?utf-8?B?NUtnR01QdFFxOEJOSkZlMWVaTVZsVk80OGtQMlhJMTY1TFV6anIwZU5Zd1pN?=
 =?utf-8?B?M1k3RmE3V2F6cmpLaHhtd3lYb0VpdXVwWnBBRzVpTXI3V25wSW5UdVFtZmN3?=
 =?utf-8?B?TE55WW1YYkkzc3d3S2M1KzFoKzBacEh2eHg1SjZGMVFGbE1qU2sySFFEZzNJ?=
 =?utf-8?B?NG1DYTdGK3pSRUNaaVd6U3lSYWhrc2U2Q2VkVkFtbXNUN0hTOHYyeWpiaWVw?=
 =?utf-8?B?THlLakJ3cDJGa0JsWGxyWjNVTHk2bXFvZ0tMOVdndys1SVV5bWZCSDdzUW52?=
 =?utf-8?B?Y1JHc2pzMmJsOElaNitvYmk5V1BvQ1pDNGY1MU5WVzBZQ3dwWWc2RlJlekVL?=
 =?utf-8?B?SlFvS3hpcisxTk9OcW9Nc3kzWGtLMEV3YUkvRFVLWmNTb1hyWXhBc2l2bW5z?=
 =?utf-8?B?WVlVZDIzZVlpUE9DSDlPejR3OVZxZzNEblNwaXVrMWpDV1JnV1BwRHcycjVu?=
 =?utf-8?B?MURHYUlxRlJOYWhKQ1NqYlFmZGpyS1g2QUtLbENTVU53aDZONndQVmY2WFJC?=
 =?utf-8?B?R2FZeFZYZ2EvSmM0cWk2N0RTalplWlN2dnNMU2VVN3locmZ0ZnF4QUlXaUZt?=
 =?utf-8?B?dXRaNzRCUG9VMFVZdTZtU3NDaVJqdlhIOVhhd1lFUEcxZG9LWlYra1VWUi94?=
 =?utf-8?B?aXNhTGtPcVNOU0RsQlZ4VjJpYngyMVFnOHVNaHpXOTZjTHRNWm1vV1BlVWRu?=
 =?utf-8?B?R241RGdHankyRm90eE85eWt4cTNyRlR1aCtHSjJGMitacEhJUGVDdXBBQU5B?=
 =?utf-8?B?b0Q5V3BtNWtxeFJweFVlK0Yvcm4zWjh3QnJ5RWlIVXN5bmRlWTRWUjk1a0Ir?=
 =?utf-8?B?VTB5aHRjMXU1aGJHK0lHcktqb1d5cUloSFd3QmJDbmV0dWtBTm5Nd1Jkb21h?=
 =?utf-8?B?M3AwM0YvMHNtN2s4ZnEvTS9RNmtURlJveDJkbEFsTlIyVmVZWXljbGZrLzh4?=
 =?utf-8?B?a0RvUzZOVUJYc2JXREF4Q1FHYVZLRkI1WlcrLzlYOWVTYTVxK2NwYkgra1dz?=
 =?utf-8?B?NUkyTHdLUHgyYldweCtRMERPYjNlT1RjeVZtcGpJRkoyc01BdU1ibk9adllZ?=
 =?utf-8?B?aWt3czFFbExKZXc1Sks0bFBQMVlxc3k5TDJYekY4N2twdm5oV0VHaU92WkJa?=
 =?utf-8?B?MTRBUGsrV3ZCcUV0K0FvWlVpSEY5KzR1TC9hVDFZUFlNdndkRFpZZndtR3h2?=
 =?utf-8?B?TWpSTGVSYWdwWmd1NURTeHJUYUJ6UU1SdWtDSFA2UnFaSlhUWW5uVmtTYUQx?=
 =?utf-8?Q?2QmmMW3QSKGqgbiP/mYNSvrBIrgZb6TG690JY?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A15F78500D4C91468B35D8F60D0F222B@jpnprd01.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY2PR01MB4427.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c396d183-4129-4a59-3253-08da13c8bd13
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 10:16:51.1166
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 50dwvaZSmUoTFoprgGu87eaSZhzWlk1rOB+/b2qEemSTKxN7zXGweuKKpWl52wmItmYe0nK3PtiK0DP9WrgeFTGevRNXDR9/B56vNAIsWfA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYAPR01MB3008
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

b24gMjAyMi80LzEgMTQ6MDgsIHh1eWFuZzIwMTguanlAZnVqaXRzdS5jb20gd3JvdGU6DQo+IG9u
IDIwMjIvMy8zMSAyMDowMiwgQ2hyaXN0aWFuIEJyYXVuZXIgd3JvdGU6DQo+PiBPbiBUaHUsIE1h
ciAzMSwgMjAyMiBhdCAwNToyODoyMlBNICswODAwLCBZYW5nIFh1IHdyb3RlOg0KPj4+IFNpbmNl
IHN0aXBwaW5nIFNfU0lHSUQgc2hvdWxkIGNoZWNrIFNfSVhHUlAsIHNvIHVtYXNrIGl0IHRvIGNo
ZWNrIHdoZXRoZXINCj4+PiB3b3JrcyB3ZWxsLg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTogWWFu
ZyBYdTx4dXlhbmcyMDE4Lmp5QGZ1aml0c3UuY29tPg0KPj4+IC0tLQ0KPj4NCj4+IChTaWRlbm90
ZTogSSByZWFsbHkgbmVlZCB0byByZW5hbWUgdGhlIHRlc3QgYmluYXJ5IHRvIHNvbWV0aGluZyBv
dGhlcg0KPj4gdGhhbiBpZG1hcHBlZC1tb3VudHMuYyBhcyB0aGlzIHRlc3RzIGEgbG90IG9mIGdl
bmVyaWMgdmZzIHN0dWZmIHRoYXQgaGFzDQo+PiBub3RoaW5nIHRvIGRvIHdpdGggdGhlbS4pDQo+
Pg0KPj4gVGVzdGVkLWJ5OiBDaHJpc3RpYW4gQnJhdW5lciAoTWljcm9zb2Z0KTxicmF1bmVyQGtl
cm5lbC5vcmc+DQo+PiBSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEJyYXVuZXIgKE1pY3Jvc29mdCk8
YnJhdW5lckBrZXJuZWwub3JnPg0KPj4NCj4+PiBJZiB3ZSBlbmFibGUgYWNsIG9uIHBhcmVudCBk
aXJlY3RvcnksIHRoZW4gdW1hc2sgaXMgdXNlbGVzcywgbWF5YmUgd2UNCj4+PiBhbHNvIGFkZCBz
ZXRmYWNsIG9uIHBhcmVudCBkaXJlY3RvcnkgYmVjYXVzZSB3ZSBtYXkgY2hhbmdlIHRoZSBvcmRl
cg0KPj4+IGFib3V0IHN0cmlwIFNfSVNHSUQgYW5kIHBvc2l4X2FjbCBzZXR1cC4gQW55IGlkZWE/
DQo+Pg0KPj4gSWYgYWNscyBmaWd1cmUgaW50byB0aGlzIHRoZW4gdGhpcyBzaG91bGQgcHJvYmFi
bHkgYmUgYSBuZXcgdGVzdCBvcg0KPj4gc3VidGVzdC4NCj4gV2lsbCBhZGQgaXQgb24gdjINCg0K
SSBoYXZlIGEgaG9saWRheSAoNC4yLTQuNSksIHNvIHdpbGwgZG8gdGhpcyB2MiBpbiBuZXh0IHdl
ZWsgd2hlbiBJIGNvbWUgDQpiYWNrLg0KDQpCZXN0IFJlZ2FyZHMNCllhbmcgWHUNCj4NCj4gQmVz
dCBSZWdhcmRzDQo+IFlhbmcgWHUNCg==
