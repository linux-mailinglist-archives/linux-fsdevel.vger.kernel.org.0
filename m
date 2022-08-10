Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC04158E985
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Aug 2022 11:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231625AbiHJJXW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Aug 2022 05:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbiHJJXV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Aug 2022 05:23:21 -0400
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C87F26B16D;
        Wed, 10 Aug 2022 02:23:20 -0700 (PDT)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 27A2tV1J003119;
        Wed, 10 Aug 2022 09:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=S1;
 bh=3OEl0I++nHc2+2XVohZ8lh2mpkW8eO8M/rzBSratZvE=;
 b=lmDbk8XxDwExd2WMoJOhryl18MF+sia7ATYm/B5YLJI6bu1KO4gVk6H+RnOPgfaQ5H8f
 h+oz899mzHtfKNo5Mubmei0+A0Md8hP4tuwDeDcyV/YwIWeNBDYz/cvUZ99ATmjdvNRM
 p466f2sDd4c9nEbIP24QYi5CfCT7HroAzP9xLXmfrUYH2npaBReb4PfGatMj8RmAe9VI
 yv/+5tW6BidISB7K+Qhrt6EP1bZA//yUi2zKbiHS89DfUonbkEIFDV0Cdh+heLkHNDU+
 znj86f6XBCGmlcr0SHusBwII5OvEakIj8jaX5/8IJgHsVwZLkXgg+YILAxZNvZd5Jdqb Uw== 
Received: from eur01-ve1-obe.outbound.protection.outlook.com (mail-ve1eur01lp2050.outbound.protection.outlook.com [104.47.1.50])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3huwrmgq99-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Aug 2022 09:22:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H2xLcbBL0usKCdD6jHnzX3gz1EtcT3/zwAz9ofAUOqg+E7s0FwI1dWFEPKZN3ABCi5hx4fybm9COc3s/fvqlGCz34ewzVR/tBosZk74mUJ+yh1TxPi9Ju3KO0SaP+cEXN+ADoJt7y1ThngczncBvJ83VUGTdN5BO5d8+LkfYXArZnrF2/lCMsrmaCrChWHEtGZZlEf7SozlUPQmtejYoCiyf8FNNn6d+Br1g0ueFMNCzjVkFq7sJwo5+qyP9urwg1lcQS2e2YQPafK65kiS7CssnuJB9/2HDWYz0Gohy4CjRhMHCveZB0yQW13UV3vdFqIKf34PWP9Qn6k4nuBEpfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3OEl0I++nHc2+2XVohZ8lh2mpkW8eO8M/rzBSratZvE=;
 b=V8IeFTtkk9fl0vt9nhLUoSI2Xr02bCwU9owbAYCEUCu7VAurLmqHYn7dPx5rxFqvLuYMSaJOMIFL/uYXF/wOTeg67YJQIQrRBpv+xDlRExQEEvYU6f0zW5dLrvnVyxCkI/gMRDOlRQ5MLCelliYypt6mRLCLZJi2ZHNHfv8HxF85NCH7sDRedPBSsh8i5aCpOmnZDgzld4ENrjjTRNYmnMXX76jE5hKtSw8xcJ2c9JaTSR5ZrQV0tpLy1yxg817UI5pE1YBX6wJVz738J+ePZxarw8Arke418pyIxGa9SkKKmvbi4ymOAkpb74QR0kYBvG2ShoshzqG0nRwOKks4Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:3fb::21)
 by PAXP193MB1310.EURP193.PROD.OUTLOOK.COM (2603:10a6:102:156::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Wed, 10 Aug
 2022 09:22:02 +0000
Received: from AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::e4e5:10d5:d7f2:d80c]) by AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
 ([fe80::e4e5:10d5:d7f2:d80c%8]) with mapi id 15.20.5504.021; Wed, 10 Aug 2022
 09:22:02 +0000
From:   "Peter.Enderborg@sony.com" <Peter.Enderborg@sony.com>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:PROC FILESYSTEM" <linux-fsdevel@vger.kernel.org>,
        "open list:ABI/API" <linux-api@vger.kernel.org>,
        "open list:GENERIC INCLUDE/ASM HEADER FILES" 
        <linux-arch@vger.kernel.org>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "krisman@collabora.com" <krisman@collabora.com>
CC:     "kernel@collabora.com" <kernel@collabora.com>
Subject: Re: [PATCH 0/5] Add process_memwatch syscall
Thread-Topic: [PATCH 0/5] Add process_memwatch syscall
Thread-Index: AQHYrJqmgetJxJlXAE68JBxn7woHdg==
Date:   Wed, 10 Aug 2022 09:22:02 +0000
Message-ID: <456a8052-dfd2-e00c-6da7-fb5aa0c35f2c@sony.com>
References: <20220726161854.276359-1-usama.anjum@collabora.com>
In-Reply-To: <20220726161854.276359-1-usama.anjum@collabora.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5e66ad2a-06c3-4529-0a0f-08da7ab1c8b3
x-ms-traffictypediagnostic: PAXP193MB1310:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3WFY8KKfUBuntXflc68U9McsNuXnwxoAN8FzYDRTe5UikMhoPDdbR0FDrBMF9T71DpfZEzdp7TmIMRHEYcE+xXDouq8nVNp/IimKBiwNBKoxQlWf89UFGxm8NYx6MgI8Ch91RiaMdM+62+sTlvRIODHc7Q9MY3HBRGHRHLbLHLKUdhho6T9LGCQupC7SiRmqSOJ2vwXcO2VYOXjYFsA60ms27SORhoQdayaok/Vn2zul0Nrz3psrc15PYb2AyVMPYx1VjeHrUooyzVVEyE6s/BpA0dHNhm4Ng5FR22uS/01G187bYp9P+i3Af39cD/8eulL62vH348+8Z/ZK5d3c4QhsnlNsrGbAjT3jKhm853px0KmfBmPTesxnEEB7OeKaAO9/cphBNZhlqGF/k+ozb3RgvKi3MnNK/vps0zob6RvtcrBX/RGWS6kFPSm5yyiw3o8ltHZiURSPxYTIkGiF7OVE/TEDz+8k1qqxSMBt6T0iNfUTMPVq+rFjwVjVEwCBFC/Q/dlAVYLvuwErkCc/0Pz9E8oH1RI2vDzqldqUXe3uLqRLfY+PKOHvnv/iYG4drEb66xhOlL94jhaZ0GGkp1PolOtSPcx/+4ylDueUEUaX9KSIRLnsobrIL319gAnnQQD8Lv/dqjczpF2nJBQuTRwoTosGhJO+mS5Yx0MflBxdZBp2bzEdhRlBqNodtdQwnMbrQtK5zHYmGsMBNqaEJ04/aQewa0A9AM6Ca5f/Vkt8Cazl/1TiYNzd7+ve+14EzhUgbaJ0oiQR6cMreQvsQvVGj1mUtMlnFp/RoWQCjx+7MN5YIZB37ovxrDCffcHIeXfXMQP4NK/9E8Nv/08FzNlP4o4IsYYz4KNuwdUXipwgeo6moOKZzgoKE57PTlgqxQFS2dvkXMTDBIorMeAQ9w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8P193MB1687.EURP193.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(346002)(396003)(376002)(39860400002)(366004)(76116006)(36756003)(316002)(110136005)(66476007)(91956017)(66446008)(66556008)(31696002)(38070700005)(8936002)(82960400001)(38100700002)(921005)(64756008)(71200400001)(86362001)(7416002)(5660300002)(66946007)(478600001)(6486002)(6512007)(26005)(122000001)(2906002)(4326008)(53546011)(6506007)(8676002)(31686004)(2616005)(186003)(41300700001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ajZDL2EvMHBmY0VFVVFzRzdvWHlqUm9iU25aMHJKNnJBdmNvb2F4a1kwVTQ4?=
 =?utf-8?B?Y3lvTHFwMzAvMmcxTGhVMThxSTI0NjMzTHpBVDAzSlJJSTJpUkhFWit6elgw?=
 =?utf-8?B?QnByUFd1QXFBaW9ZMXhONVR1WXYxSnNXZVBoWDBGRzUybFJWbUNLejNTNVI3?=
 =?utf-8?B?YnFSZk9wbmNDL3pDdkdIeE9reUhwY01JSnFQRDA5VklRWkFiWFUwZUVIQXBJ?=
 =?utf-8?B?emo5enl0OWFodHo1NHA3UXJ3bmRFaDh4ZTFYM1BaR3FyaTU1alNQWXRkTWly?=
 =?utf-8?B?MWExNTZkQnJjM1lEMW5rdFkrcjcrUytXSkpMRjY1U0JPM0drbzJiM0wxbXJD?=
 =?utf-8?B?MmJPMFl6KzRXYUNReG1vTlFteFcxc3NSMHBqbzRvWWlWZHpPUkxsVzg5TEg2?=
 =?utf-8?B?WFh3b21DdFpsQmZMNzB6Y0JxTElZSkJtd1Q2anRaQkhjV1FWdnV6VHZtczlP?=
 =?utf-8?B?SGNWVkc3a29QKzZTa0NaaWhuQkZxZ2FEZkFoSFlsbUVTMWhSVzBJeWZTTzcw?=
 =?utf-8?B?RTRxSHl2Y2lta1ZrQ2FlL2Q0UWQ2NEhqY0hueXlEaytmajJlcGxGV21Ub3Jt?=
 =?utf-8?B?cXBrdThiZmhlRkRwMGVRbGFRdDFiRkN6b0xKU3lHVlZYWVYvbGlSL1ZRREk3?=
 =?utf-8?B?cElRSXBYdjNLNUFMc0c4RU8vWXlpb0tZT0luakliTnV0UGFtZ2NFenZXRGQr?=
 =?utf-8?B?R0NqZVNnMGtkUkhJNVM0bkZwNGQ2anMzV0NSNjhOOGdsb2d1M3hqSUlGNkFY?=
 =?utf-8?B?MzFyNEI0Titsa0Y2RXRBWVl3SmRjQnhBWXhqZHhWTlVGc05pR2R1Si9IMlNn?=
 =?utf-8?B?S0FvT0ZieUFROVhMV0llZ2pIWlFBZkY1ajJyeEhzRFh3NWJCWUxlWVUyQ0Rz?=
 =?utf-8?B?YW9XTXozVGpXNFpKNVQ0Sm9RbXF6MmovWnR0Q2ZaTmduSEdzaWZUTTFlUlQv?=
 =?utf-8?B?Y1pqT1BHTk5FUE1jczEzTU9tQnNoaFZuUlpnT3Y0VUZITVQxRklvWGk5eHor?=
 =?utf-8?B?MVNVcHpDNmRSaTJBWm84dXdMb3NHN1ZwY1E3OFc0TjJ5UmZBTjYwa0p4OC95?=
 =?utf-8?B?Qm9aYzVYcUR4Q00zYkpxa1pGem12bExFVUl3RUJZYVpZeGhoa3dPejJQdkhM?=
 =?utf-8?B?ZnlGTnZNTkREaVZTU1IvYUpyMTNwYWIvbjdXdlhKZngyNWRtazhtMUxUSTYx?=
 =?utf-8?B?Z0FDTnpQdUVsMWlqWFRRU0J6aitNNXhvam1pVm9YZGFJWVdLOE1qU290M2Zm?=
 =?utf-8?B?b2ZVUnRNWjRzV1RLL2hLYmtXNUc2aUtpTTFOckxSZnh1RFRMd3BBdGViVUVj?=
 =?utf-8?B?dlpuMkNRRGRjY3dES09IVytVVWRTa1VNQ0Z6cE5sNHZGMmRJUERhSm9vdTd4?=
 =?utf-8?B?R3RSMWNSdDAxQTJTYU5SL0xDdEQ2cHdXSk91V2k5R3lFNms2Y3c3U0FGbWtp?=
 =?utf-8?B?bnRLUHhxMzVKajJKa2J1Q3JDS2w2bTMrV1l5eGx0UW8zZGFoaXNiTS9MUUx3?=
 =?utf-8?B?ZlpuRjd5ZXk5cUl6aVFBajZzM0pDV3Zubm0yOG5RckxuYkNVZUZZRDFFSGhT?=
 =?utf-8?B?dlFMR2YzQ2RZTnlORXNGaDBiTlhjc1F5OE1Wakp0bXJxdk9mTm8xb0tvSk5i?=
 =?utf-8?B?WUU2Vk8zT3dVZUE4NzU5VkNlY3lmOWxpcTl0WWc5enRKR0t2TGErZUlza01k?=
 =?utf-8?B?ZngrMFB4WUpra0gvZW1HckhlVDZXUzZpcnAvNnRhQkdMOFNGR01LTURaR1BV?=
 =?utf-8?B?bjBCN2s4ek5sTnBvOWoya3V4K3hPVHFnV1hUOWordUova1h6a3k3YWtRVExo?=
 =?utf-8?B?cSsyT2lmcElMK2p3WTltTy9XOHRNdFJMaWZqVlluTzUwR0t5WHRvSnphQWpI?=
 =?utf-8?B?VlcrNlV5TUVzejFtMW94SEtPVFRxNVkwaGVrSTBiY1A4Tm9LaWR2WHNhTnVv?=
 =?utf-8?B?a3UxMmR6cXBiajh6bjdlNW1teVp1R252a2ZlV0Q4WmlpUk9NU3ljOE9kQTN3?=
 =?utf-8?B?WW9DVEwyeTNvUEplN0RIUXdKeEorQ0FYZXVJbGU2d1ZWanQzdXlLWHUwS1Ji?=
 =?utf-8?B?dUFlYk9jaU84TE9MTGViU3dqcWQvTGJTU3RmV1FEN3dOWkREOVZoUDFvSUpL?=
 =?utf-8?B?VTM1K25HMkQ1WmVIRGpYV09GSG9wY2lIZnRqOUJwakt1eDdXaWhtT0hrdzVH?=
 =?utf-8?B?ZkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B174C3CACCFFCD439CA7F1DA42B33B96@EURP193.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1687.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e66ad2a-06c3-4529-0a0f-08da7ab1c8b3
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Aug 2022 09:22:02.0854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FOpo3gWZz+YZ3zJIzW5/ONgwQRwPgsNuGeYDYAaf8uO7rTiBnqM82wB7LPMO2yFQCOjllxEvwdJwk7i+yD5Gb8PWJWWg0pSS04/edJ3rm6w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXP193MB1310
X-Proofpoint-ORIG-GUID: i4ZAWnrK7m9Ygyr8lpvZv6RHk0X827xR
X-Proofpoint-GUID: i4ZAWnrK7m9Ygyr8lpvZv6RHk0X827xR
X-Sony-Outbound-GUID: i4ZAWnrK7m9Ygyr8lpvZv6RHk0X827xR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.883,Hydra:6.0.517,FMLib:17.11.122.1
 definitions=2022-08-10_03,2022-08-09_02,2022-06-22_01
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNy8yNi8yMiAxODoxOCwgTXVoYW1tYWQgVXNhbWEgQW5qdW0gd3JvdGU6DQo+IEhlbGxvLA0K
PiANCj4gVGhpcyBwYXRjaCBzZXJpZXMgaW1wbGVtZW50cyBhIG5ldyBzeXNjYWxsLCBwcm9jZXNz
X21lbXdhdGNoLiBDdXJyZW50bHksDQo+IG9ubHkgdGhlIHN1cHBvcnQgdG8gd2F0Y2ggc29mdC1k
aXJ0eSBQVEUgYml0IGlzIGFkZGVkLiBUaGlzIHN5c2NhbGwgaXMNCj4gZ2VuZXJpYyB0byB3YXRj
aCB0aGUgbWVtb3J5IG9mIHRoZSBwcm9jZXNzLiBUaGVyZSBpcyBlbm91Z2ggcm9vbSB0byBhZGQN
Cj4gbW9yZSBvcGVyYXRpb25zIGxpa2UgdGhpcyB0byB3YXRjaCBtZW1vcnkgaW4gdGhlIGZ1dHVy
ZS4NCj4gDQo+IFNvZnQtZGlydHkgUFRFIGJpdCBvZiB0aGUgbWVtb3J5IHBhZ2VzIGNhbiBiZSB2
aWV3ZWQgYnkgdXNpbmcgcGFnZW1hcA0KPiBwcm9jZnMgZmlsZS4gVGhlIHNvZnQtZGlydHkgUFRF
IGJpdCBmb3IgdGhlIG1lbW9yeSBpbiBhIHByb2Nlc3MgY2FuIGJlDQo+IGNsZWFyZWQgYnkgd3Jp
dGluZyB0byB0aGUgY2xlYXJfcmVmcyBmaWxlLiBUaGlzIHNlcmllcyBhZGRzIGZlYXR1cmVzIHRo
YXQNCj4gd2VyZW4ndCBwb3NzaWJsZSB0aHJvdWdoIHRoZSBQcm9jIEZTIGludGVyZmFjZS4NCj4g
LSBUaGVyZSBpcyBubyBhdG9taWMgZ2V0IHNvZnQtZGlydHkgUFRFIGJpdCBzdGF0dXMgYW5kIGNs
ZWFyIG9wZXJhdGlvbg0KPiAgIHBvc3NpYmxlLg0KPiAtIFRoZSBzb2Z0LWRpcnR5IFBURSBiaXQg
b2Ygb25seSBhIHBhcnQgb2YgbWVtb3J5IGNhbm5vdCBiZSBjbGVhcmVkLg0KPiANCj4gSGlzdG9y
aWNhbGx5LCBzb2Z0LWRpcnR5IFBURSBiaXQgdHJhY2tpbmcgaGFzIGJlZW4gdXNlZCBpbiB0aGUg
Q1JJVQ0KPiBwcm9qZWN0LiBUaGUgUHJvYyBGUyBpbnRlcmZhY2UgaXMgZW5vdWdoIGZvciB0aGF0
IGFzIEkgdGhpbmsgdGhlIHByb2Nlc3MNCj4gaXMgZnJvemVuLiBXZSBoYXZlIHRoZSB1c2UgY2Fz
ZSB3aGVyZSB3ZSBuZWVkIHRvIHRyYWNrIHRoZSBzb2Z0LWRpcnR5DQo+IFBURSBiaXQgZm9yIHJ1
bm5pbmcgcHJvY2Vzc2VzLiBXZSBuZWVkIHRoaXMgdHJhY2tpbmcgYW5kIGNsZWFyIG1lY2hhbmlz
bQ0KPiBvZiBhIHJlZ2lvbiBvZiBtZW1vcnkgd2hpbGUgdGhlIHByb2Nlc3MgaXMgcnVubmluZyB0
byBlbXVsYXRlIHRoZQ0KPiBnZXRXcml0ZVdhdGNoKCkgc3lzY2FsbCBvZiBXaW5kb3dzLiBUaGlz
IHN5c2NhbGwgaXMgdXNlZCBieSBnYW1lcyB0byBrZWVwDQo+IHRyYWNrIG9mIGRpcnR5IHBhZ2Vz
IGFuZCBrZWVwIHByb2Nlc3Npbmcgb25seSB0aGUgZGlydHkgcGFnZXMuIFRoaXMNCj4gc3lzY2Fs
bCBjYW4gYmUgdXNlZCBieSB0aGUgQ1JJVSBwcm9qZWN0IGFuZCBvdGhlciBhcHBsaWNhdGlvbnMg
d2hpY2gNCj4gcmVxdWlyZSBzb2Z0LWRpcnR5IFBURSBiaXQgaW5mb3JtYXRpb24uDQo+IA0KPiBB
cyBpbiB0aGUgY3VycmVudCBrZXJuZWwgdGhlcmUgaXMgbm8gd2F5IHRvIGNsZWFyIGEgcGFydCBv
ZiBtZW1vcnkgKGluc3RlYWQNCj4gb2YgY2xlYXJpbmcgdGhlIFNvZnQtRGlydHkgYml0cyBmb3Ig
dGhlIGVudGlyZSBwcm9jZXNzaSkgYW5kIGdldCtjbGVhcg0KPiBvcGVyYXRpb24gY2Fubm90IGJl
IHBlcmZvcm1lZCBhdG9taWNhbGx5LCB0aGVyZSBhcmUgb3RoZXIgbWV0aG9kcyB0byBtaW1pYw0K
PiB0aGlzIGluZm9ybWF0aW9uIGVudGlyZWx5IGluIHVzZXJzcGFjZSB3aXRoIHBvb3IgcGVyZm9y
bWFuY2U6DQo+IC0gVGhlIG1wcm90ZWN0IHN5c2NhbGwgYW5kIFNJR1NFR1YgaGFuZGxlciBmb3Ig
Ym9va2tlZXBpbmcNCj4gLSBUaGUgdXNlcmZhdWx0ZmQgc3lzY2FsbCB3aXRoIHRoZSBoYW5kbGVy
IGZvciBib29ra2VlcGluZw0KPiANCj4gICAgICAgICBsb25nIHByb2Nlc3NfbWVtd2F0Y2goaW50
IHBpZGZkLCB1bnNpZ25lZCBsb25nIHN0YXJ0LCBpbnQgbGVuLA0KPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB1bnNpZ25lZCBpbnQgZmxhZ3MsIHZvaWQgKnZlYywgaW50IHZlY19sZW4p
Ow0KPiANCj4gVGhpcyBzeXNjYWxsIGNhbiBiZSB1c2VkIGJ5IHRoZSBDUklVIHByb2plY3QgYW5k
IG90aGVyIGFwcGxpY2F0aW9ucyB3aGljaA0KPiByZXF1aXJlIHNvZnQtZGlydHkgUFRFIGJpdCBp
bmZvcm1hdGlvbi4gVGhlIGZvbGxvd2luZyBvcGVyYXRpb25zIGFyZQ0KPiBzdXBwb3J0ZWQgaW4g
dGhpcyBzeXNjYWxsOg0KPiAtIEdldCB0aGUgcGFnZXMgdGhhdCBhcmUgc29mdC1kaXJ0eS4NCj4g
LSBDbGVhciB0aGUgcGFnZXMgd2hpY2ggYXJlIHNvZnQtZGlydHkuDQo+IC0gVGhlIG9wdGlvbmFs
IGZsYWcgdG8gaWdub3JlIHRoZSBWTV9TT0ZURElSVFkgYW5kIG9ubHkgdHJhY2sgcGVyIHBhZ2UN
Cj4gc29mdC1kaXJ0eSBQVEUgYml0DQo+IA0KDQpXaHkgY2FuIGl0IG5vdCBiZSBkb25lIGFzIGEg
SU9DVEw/DQoNCg0KPiBUaGVyZSBhcmUgdHdvIGRlY2lzaW9ucyB3aGljaCBoYXZlIGJlZW4gdGFr
ZW4gYWJvdXQgaG93IHRvIGdldCB0aGUgb3V0cHV0DQo+IGZyb20gdGhlIHN5c2NhbGwuDQo+IC0g
UmV0dXJuIG9mZnNldHMgb2YgdGhlIHBhZ2VzIGZyb20gdGhlIHN0YXJ0IGluIHRoZSB2ZWMNCj4g
LSBTdG9wIGV4ZWN1dGlvbiB3aGVuIHZlYyBpcyBmaWxsZWQgd2l0aCBkaXJ0eSBwYWdlcw0KPiBU
aGVzZSB0d28gYXJndW1lbnRzIGRvZXNuJ3QgZm9sbG93IHRoZSBtaW5jb3JlKCkgcGhpbG9zb3Bo
eSB3aGVyZSB0aGUNCj4gb3V0cHV0IGFycmF5IGNvcnJlc3BvbmRzIHRvIHRoZSBhZGRyZXNzIHJh
bmdlIGluIG9uZSB0byBvbmUgZmFzaGlvbiwgaGVuY2UNCj4gdGhlIG91dHB1dCBidWZmZXIgbGVu
Z3RoIGlzbid0IHBhc3NlZCBhbmQgb25seSBhIGZsYWcgaXMgc2V0IGlmIHRoZSBwYWdlDQo+IGlz
IHByZXNlbnQuIFRoaXMgbWFrZXMgbWluY29yZSgpIGVhc3kgdG8gdXNlIHdpdGggbGVzcyBjb250
cm9sLiBXZSBhcmUNCj4gcGFzc2luZyB0aGUgc2l6ZSBvZiB0aGUgb3V0cHV0IGFycmF5IGFuZCBw
dXR0aW5nIHJldHVybiBkYXRhIGNvbnNlY3V0aXZlbHkNCj4gd2hpY2ggaXMgb2Zmc2V0IG9mIGRp
cnR5IHBhZ2VzIGZyb20gdGhlIHN0YXJ0LiBUaGUgdXNlciBjYW4gY29udmVydCB0aGVzZQ0KPiBv
ZmZzZXRzIGJhY2sgaW50byB0aGUgZGlydHkgcGFnZSBhZGRyZXNzZXMgZWFzaWx5LiBTdXBwb3Nl
LCB0aGUgdXNlciB3YW50DQo+IHRvIGdldCBmaXJzdCAxMCBkaXJ0eSBwYWdlcyBmcm9tIGEgdG90
YWwgbWVtb3J5IG9mIDEwMCBwYWdlcy4gSGUnbGwNCj4gYWxsb2NhdGUgb3V0cHV0IGJ1ZmZlciBv
ZiBzaXplIDEwIGFuZCBwcm9jZXNzX21lbXdhdGNoKCkgc3lzY2FsbCB3aWxsDQo+IGFib3J0IGFm
dGVyIGZpbmRpbmcgdGhlIDEwIHBhZ2VzLiBUaGlzIGJlaGF2aW91ciBpcyBuZWVkZWQgdG8gc3Vw
cG9ydA0KPiBXaW5kb3dzJyBnZXRXcml0ZVdhdGNoKCkuIFRoZSBiZWhhdmlvdXIgbGlrZSBtaW5j
b3JlKCkgY2FuIGJlIGFjaGlldmVkIGJ5DQo+IHBhc3Npbmcgb3V0cHV0IGJ1ZmZlciBvZiAxMDAg
c2l6ZS4gVGhpcyBpbnRlcmZhY2UgY2FuIGJlIHVzZWQgZm9yIGFueQ0KPiBkZXNpcmVkIGJlaGF2
aW91ci4NCj4gDQo+IFJlZ2FyZHMsDQo+IE11aGFtbWFkIFVzYW1hIEFuanVtDQo+IA0KPiBNdWhh
bW1hZCBVc2FtYSBBbmp1bSAoNSk6DQo+ICAgZnMvcHJvYy90YXNrX21tdTogbWFrZSBmdW5jdGlv
bnMgZ2xvYmFsIHRvIGJlIHVzZWQgaW4gb3RoZXIgZmlsZXMNCj4gICBtbTogSW1wbGVtZW50IHBy
b2Nlc3NfbWVtd2F0Y2ggc3lzY2FsbA0KPiAgIG1tOiB3aXJlIHVwIHByb2Nlc3NfbWVtd2F0Y2gg
c3lzY2FsbCBmb3IgeDg2DQo+ICAgc2VsZnRlc3RzOiB2bTogYWRkIHByb2Nlc3NfbWVtd2F0Y2gg
c3lzY2FsbCB0ZXN0cw0KPiAgIG1tOiBhZGQgcHJvY2Vzc19tZW13YXRjaCBzeXNjYWxsIGRvY3Vt
ZW50YXRpb24NCj4gDQo+ICBEb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL21tL3NvZnQtZGlydHku
cnN0ICAgfCAgNDggKy0NCj4gIGFyY2gveDg2L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfMzIudGJs
ICAgICAgICB8ICAgMSArDQo+ICBhcmNoL3g4Ni9lbnRyeS9zeXNjYWxscy9zeXNjYWxsXzY0LnRi
bCAgICAgICAgfCAgIDEgKw0KPiAgZnMvcHJvYy90YXNrX21tdS5jICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHwgIDg0ICstLQ0KPiAgaW5jbHVkZS9saW51eC9tbV9pbmxpbmUuaCAgICAgICAg
ICAgICAgICAgICAgIHwgIDk5ICsrKw0KPiAgaW5jbHVkZS9saW51eC9zeXNjYWxscy5oICAgICAg
ICAgICAgICAgICAgICAgIHwgICAzICstDQo+ICBpbmNsdWRlL3VhcGkvYXNtLWdlbmVyaWMvdW5p
c3RkLmggICAgICAgICAgICAgfCAgIDUgKy0NCj4gIGluY2x1ZGUvdWFwaS9saW51eC9tZW13YXRj
aC5oICAgICAgICAgICAgICAgICB8ICAxMiArDQo+ICBrZXJuZWwvc3lzX25pLmMgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgIDEgKw0KPiAgbW0vTWFrZWZpbGUgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ICBtbS9tZW13YXRjaC5jICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAyODUgKysrKysrKysNCj4gIHRvb2xzL2luY2x1ZGUv
dWFwaS9hc20tZ2VuZXJpYy91bmlzdGQuaCAgICAgICB8ICAgNSArLQ0KPiAgLi4uL2FyY2gveDg2
L2VudHJ5L3N5c2NhbGxzL3N5c2NhbGxfNjQudGJsICAgIHwgICAxICsNCj4gIHRvb2xzL3Rlc3Rp
bmcvc2VsZnRlc3RzL3ZtLy5naXRpZ25vcmUgICAgICAgICB8ICAgMSArDQo+ICB0b29scy90ZXN0
aW5nL3NlbGZ0ZXN0cy92bS9NYWtlZmlsZSAgICAgICAgICAgfCAgIDIgKw0KPiAgdG9vbHMvdGVz
dGluZy9zZWxmdGVzdHMvdm0vbWVtd2F0Y2hfdGVzdC5jICAgIHwgNjM1ICsrKysrKysrKysrKysr
KysrKw0KPiAgMTYgZmlsZXMgY2hhbmdlZCwgMTA5OCBpbnNlcnRpb25zKCspLCA4NyBkZWxldGlv
bnMoLSkNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBpbmNsdWRlL3VhcGkvbGludXgvbWVtd2F0Y2gu
aA0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IG1tL21lbXdhdGNoLmMNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCB0b29scy90ZXN0aW5nL3NlbGZ0ZXN0cy92bS9tZW13YXRjaF90ZXN0LmMNCj4gDQo=
