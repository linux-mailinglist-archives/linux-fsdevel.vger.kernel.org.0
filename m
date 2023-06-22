Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A4873A6C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Jun 2023 18:58:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231130AbjFVQ6R (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Jun 2023 12:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjFVQ6Q (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Jun 2023 12:58:16 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9CEE48;
        Thu, 22 Jun 2023 09:58:14 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35MGCBcm016194;
        Thu, 22 Jun 2023 16:58:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=vb2QR7NykO0ibEygnCRE342q4tMc3w6XISG+NJASd6E=;
 b=NkI309T51uehFuB2hfrGY4bBXf7zHRxW1duqqPrE1FPOtZm6dXcHFKWD+hDuegI4c8Hq
 Ma/HEQJeC01kcmBKJvT2/LMFn6q6vSEeA5t+s4pufnVlQ8QlRcSYD6/lDzpF7hUWzTBD
 CLuh04yDzEolCdj6oHVd3BKim5QpJeebROvDwCLvMaunVLwNPMv/AIrLyFHIpM0ytOxV
 WcYQld1/Im7XeVX6o4/hWeJExxDmNp6NEbGMU/2/mgqhC5KQQWFJo0R6AWZr6f4Ou7Qt
 LFFEY6ski+RUsARug6czz2Rp/UatbI2FnGWzk74e9R4rDY6iYECFI+tQxeacdadPEtN0 UQ== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3r94qaa4v2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 16:58:11 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 35MGr3GE028807;
        Thu, 22 Jun 2023 16:58:10 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2109.outbound.protection.outlook.com [104.47.55.109])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3r939dux19-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 22 Jun 2023 16:58:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R7eVzUd96tWssutIWrWMslp50cPQsNQNik56yq0m2amS9P3nrVXpz2JLpWrJhCSjrV3XoDxxcg9tH00rx8Bru7Rkr9i0SR4epRygoKVGTkKdjSRX0f39TdyCBtt7BgxOqC+niT+Eeo2cKLPrny5XG9R2BEzMMWQSER/C/rF2nKTZ2YcINhLJONueAaYmka15JvqsTKsaMhTzG6fXkvybMVzIUOIhGHB+khxf4ZWccv6SCKcTORv86q5m1+E6aPiMFf3mfn8Ps+QGxYJAC1gtxeJJSfc9MnF2Tww3jsPWJTSWJpaqsfPjCHDL22rUvfzbEj8PJ832xCEnmtsHMgPAUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vb2QR7NykO0ibEygnCRE342q4tMc3w6XISG+NJASd6E=;
 b=gyu9Vz1JSeoiACyTyLQBoMljMyGhh+v4/cd8qFBVG7qlFI/QhG+gpySyitvnJTD2rEnSYVh9e9wZiBYHZOTlMs1oKNEICo8RiF13TuysCur5tpOfDxgmO6JCHpKfcnAJKQ4ZKUhIxQ2WNzlxWOoDrFeDKA++fCRlY/Z/5ppCgCwvW9dQYWsB9XYJjC6YyJr5AHJhTrj/0xwtd4IMooLtgrXRBK27GEToyh6hEeTNJw4cYI9fCpj3rCoW/hQuLYLUoiU8arrJNmLO3YtAYhRB4KC33G4AkVss5I423/6SxGMLx89TBxSgnSt5NHa2xLo7zkCLg2my09Z6BIM4nT7ELg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vb2QR7NykO0ibEygnCRE342q4tMc3w6XISG+NJASd6E=;
 b=lIrNmGVULF3PUFJ5YtSzvFSzSTyOrfyuBJ7DYvOjm972niY3m+6jm/S9+8Syfg8lf0bHlZMyAcOeD6pD+8/xSbw3RNKCBwKpqauMdM2XDSSp9s13juF9xdy5U4WDC28S2roX44gxLlHNJcVe2Meu31xgFa3d2pefmMI5/6SHzuQ=
Received: from BN0PR10MB5128.namprd10.prod.outlook.com (2603:10b6:408:117::24)
 by LV3PR10MB7868.namprd10.prod.outlook.com (2603:10b6:408:1b4::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.23; Thu, 22 Jun
 2023 16:58:08 +0000
Received: from BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3]) by BN0PR10MB5128.namprd10.prod.outlook.com
 ([fe80::ae00:3b69:f703:7be3%4]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 16:58:08 +0000
From:   Chuck Lever III <chuck.lever@oracle.com>
To:     stsp <stsp2@yandex.ru>
CC:     Jeff Layton <jlayton@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Shuah Khan <shuah@kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        "linux-api@vger.kernel.org" <linux-api@vger.kernel.org>
Subject: Re: [PATCH 2/2] selftests: add OFD lock tests
Thread-Topic: [PATCH 2/2] selftests: add OFD lock tests
Thread-Index: AQHZpFRBuWHdWK3VTEWhHJpZRPu6tq+WtkkAgABRqwCAAATGgA==
Date:   Thu, 22 Jun 2023 16:58:08 +0000
Message-ID: <8F45F47C-86C0-472E-B701-001A4FF90DBC@oracle.com>
References: <20230621152214.2720319-1-stsp2@yandex.ru>
 <20230621152214.2720319-3-stsp2@yandex.ru>
 <4db7c65bee0739fe7983059296cfc95f20647fa3.camel@kernel.org>
 <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru>
In-Reply-To: <7bbb29d2-4cae-48bd-1b97-9f4dbf6ffb19@yandex.ru>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3731.600.7)
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: BN0PR10MB5128:EE_|LV3PR10MB7868:EE_
x-ms-office365-filtering-correlation-id: 6582132a-a650-436c-61db-08db7341daa9
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MRes7Ykp91E19JZzLbtytsiftewq9kmyU0Y+pkKjYnKobW5HzMs6MXEUP2PdXSSL7toIm2SAfMDIOvOdQHsopJwhn6ZNyU36nTWMeBM6ryWF/50RaWfFDRYDv5GBgMLFO45/zZh7lJln9TmENYLAv4qE6VDi1nzBgEiUHfMPHRUhcNbvoNdNMo5ZrUN3qr5ZCQYYTyHkk9NOGFrdJ4A+Gqoa5ZjjYJRlbhLgrprC9lBImGQ4eDFL+N7JhfiTL2qRsP7ZeeL7BqG58Lsvze7b9jQjve5bwyVF5UC+BZD16Hh/0O4s+p9Hl6It6Hk2TCjmASxNtOaxb8XNGhn761wtfkFLijE+g0JT2f2ENxSCOIUGtbxY8Q+eHwiKg3OY6d9YOmBUU4f2JnSMMTf0sgkUgzIS0zcf0KiRooR1RYeBLkceiTz4EnRk7RBi5BzNNOzK8ydEdxC2C88PUQ3rpTvrb7QKfJSmVkYn5aQfzyuv2CeQHX+3tH99Ce6PkXGrfUA3S7L5R57Ux01hhkBk/wm6yX7Tb5DvVnlXTWQGEHlWV+o3cDfjRzWwx0K8VWvy8UM2yygmnOeeO29SpnDdzEYARmhd7PxJSGpnm/7clsy116Gn3BWqil/jfLC65QHim5Hq0hJLZYTGMINCoN3e0eiF+A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN0PR10MB5128.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(136003)(39860400002)(376002)(396003)(451199021)(4326008)(66556008)(91956017)(64756008)(66946007)(76116006)(66476007)(66446008)(186003)(2616005)(53546011)(122000001)(6916009)(38100700002)(6512007)(966005)(26005)(6506007)(83380400001)(38070700005)(86362001)(33656002)(478600001)(54906003)(36756003)(6486002)(71200400001)(2906002)(8936002)(8676002)(316002)(5660300002)(41300700001)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?amlLd0FnVURjL1ErcFhFdGYzalBtQ2Q2VVNOL25ZV2FNOVJza1VMemFjZkNw?=
 =?utf-8?B?Szl5c05WNTZ4UFl4YXRiVm9pYTJCUE45M1JIRGxOUGI5cDdxRjNLeVZHdHhK?=
 =?utf-8?B?OWhTZDVId1NwWTVJb2QwN21wMnpUMXNZcklnd2p4aE1jUFYvNENSTThLNlBS?=
 =?utf-8?B?VXJnOFJOT2JvTVBDdGhobEFuaE9GWnpGcVFPVnRONStXd0xDcS9PTG1ZQkJI?=
 =?utf-8?B?WWhsamlLVksvNkFlb0VqVSs2MVBjRmtmTGhONlVWV01TSWdqRGltZXppM1cw?=
 =?utf-8?B?NlptZGdxV0h1OGRPNFYvRU44OHhYNFpHZDk5b0g0N3h1MWVmTE9ta1RKREZZ?=
 =?utf-8?B?SWZLSER1REovVmlleXBhaERrNlJ5eitHQU9qbi9jMVdBQ0lMTkM0Z0hTakZU?=
 =?utf-8?B?OWxMMElBSE9tN21NUGdhWEVPRVl3WWN2SXZidDlNZHZFVVBITlhiNVhyU0tF?=
 =?utf-8?B?a3pxeWNwdVpyUUtmbnh3bktlUXR5cDZQTkE4NUU3Z2dCenBOdlc5T0ExYkYz?=
 =?utf-8?B?aTJVSW4wN015dTdVVmMwQlBYVkFSdWd2Q2Uyc2VFSDNXZ0RObitxODJlZWpF?=
 =?utf-8?B?c254ZGlQbEtzenIxWUNNQXRxQjZzUjBPOHlYSmpaYUNsZjBobTRlYURLY2cw?=
 =?utf-8?B?L0xMS0Vzd1lxV1R3L0V1d0tTWHFoSmNYOW9vWDRabXp4NWZsZzlibE5lSDdO?=
 =?utf-8?B?SWx6aTY1akJneWJhVGZ2N2tmbmY1djA5VmZTME1DSFpsWkwrSyt0NWs1NHR5?=
 =?utf-8?B?RmI2YjRHalFYNWhMSSs0Wkc3MktkZllLUkFOY3RaNHZGUitscitJK3FIMEg3?=
 =?utf-8?B?dWxmWXI5enZzUU51M3NwMklTR3NVVXg2eWpBQmhTOTJlQ3RabENldk1KUHlY?=
 =?utf-8?B?UnU3WVFDaldCY1p4VUh2dnZzd1dtcXBRWGkycDdpdzBrOGdrRUVnY29VSkFK?=
 =?utf-8?B?R3lxNWMrMGI3SURicVZDbXNSUTVnL0lqY25pdlF2Uk1HY2FYcVpXWkVjNFZ5?=
 =?utf-8?B?alptS2tYTVpxS2lFMGE0N3ZkclRIT0lHVGJVK1pqTG9ZZHo2VGxJWkVBWmpx?=
 =?utf-8?B?U3piUFZwNUZGZUJXRmNPMkc3Y3hqNk95QU1LYTRyV2dOTVczNjRJc2JISGFi?=
 =?utf-8?B?bU9ZazU3eEF0RG05WmdhNWYzR1ZPeTVLa1ZxZTArbW9OdzJ5VCtHTHU2Zm1j?=
 =?utf-8?B?ZURTaFRnaHZxeXZueTlUYVhkT3d4aDR2OG81Y0ZxWjN5QXV0ZVBzbzhLaXc4?=
 =?utf-8?B?cG1FOGFJK2x6cThNcXhQL1MvbVBobW1HaDdYOE9tWGJiR2srWThFdUtwU3Ra?=
 =?utf-8?B?K09WM1JJdFhwN2IxNTQ1NVJkQllLbTFSNGFzMkpMdm5TY2dXWi9vNWZkNkxQ?=
 =?utf-8?B?N3hGZml1Q01YOWswcjVicTdITEFzeGcvMXRDZTZwMHFtaC8xdnFiK1R1enVO?=
 =?utf-8?B?V1IweDZOWVYxS1g4Q3dJVjB4UG4yOUNEblB5aTB5MUFTSi9QTkFib2ZLYm9R?=
 =?utf-8?B?QUNMYzV1VUo4TDJNUHluQ1c5V0R3K2hkSXN6Nmp4RDZtTVc2bXlDY2FEZnVO?=
 =?utf-8?B?YWxhWDUrYVpTYjhTUlRsMjBzY2w3UFlhcEp0a1JkQmRLWENQMWdJaExIc1FX?=
 =?utf-8?B?K1dXNVl1azZUQWJod1VlbkVPNDNzT2NtL2U0UjFubTNBZUxvaDZyYzBtMG1O?=
 =?utf-8?B?cm1ZRXQ2ZStUNTdxaVJIb2VuZVdsdlVteCtMOWVmMVRXeWc4dHNzZTlmYkJk?=
 =?utf-8?B?NlU2Ni9Oa3VpS2VaZVltUGU0M0hPbUlaMnFmMERDMmVHYVlMZ0tsbzBOTHFK?=
 =?utf-8?B?ejhJSTVHenFteDZtZjFyWk83N1dtVE1jYTY2YTVIeFZZTVEwNzlIRkYzK1Za?=
 =?utf-8?B?UnJzQjdONUxHSWEySWY0ZENvWkNKalVFYjVnTjQvMzNHMndTZ0JNbVpUdDBS?=
 =?utf-8?B?VHdDNzh5MlJ6LzhLdVJjSThNYmVzSVBzWDljYmRld09ZbnlNRmxhdk10TGQ4?=
 =?utf-8?B?bnp0UStmekZib1pabmQ0M0xCWURjcm0vTjY4M1RDWGFzdWVpaWFBc0xWY1Q5?=
 =?utf-8?B?MzVzMERZU2twQ3cxZ3RST2x2NEVzUmJ0K1JKVDkzMVd0ZURHNW5KRzZnQjY1?=
 =?utf-8?B?Y3lCaTJYTUFpa1FjSEtyZEVodUs5RFk1Y1ovVWhzN1h5L2xwNWp1WmIwK2tu?=
 =?utf-8?B?TkE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <38FB2A8EBB4B2B4D9C97F83F9ACEF952@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: TmE+IiJYdYaYvL/IUE+daZDiHOnK5+J/EtW8RZEPJjmoUh/bUP3pQjrD2KjwrMOMT0dcP7fJgHVT0Gg3Y9GyjzTBudL0LFQbZl2fZzr4hzr+BR1mGLoD9j2GAUl4AbGgTDYU7u0qhodUjgSGg5caNOqm+tmVmNzD8ET8vLnxScOg+My8RsLqO08MigQc/uxyg4h4LvbQISM3OwHOvG1sfXZniJeW/Arh7cAnWk9/dqZlLeIN4fUtgMwgf+bgbvl4/5ceqE/MDuEnVqRUu1q66KFfPy7PYyxjhi5Q9J329yBI3Jn+5L8rTqI2X2MZgtVQBGlY9ILVJRIGv4LiLMSMriGjPPQ1APMQFMqj88irwnES/ZVz8VdRnIN04Bqu/3flD1v08rDey+dVNHu/0MEKTAnWAQE2fIr8tplA7anvtjrhapRSfELTDnb42s0fz+cgGsIaCyGcaGrqFv74PkT64moL9fRgzhSR5y60VGB2NWvudoY8cbcbmEniZpFzM7B3O3EG7l4OB/phL0b3bLoZHX0E/ik99HpPmi6kOjrLmXi7bMyWPMGkATD4HezaWVtiWWeNEjxhpvdKp4XggSbW7ufUmXDnSLJHYuga2N5L4SWNFBXqcS+nckc5T4Q+vZztcugzFddBl7FjV4VL15+VswSTUUGiWsNJSrGfDKT/eTVuXabJLrQwXL2zzRu7Yh70HJNU+2yE9kZJA7LM4lHda5ouCHRgF+X+qzIXLFkQEXmE+TPUkUwaxIs78FlGXaIucjcn93OTJ8jWaGB9/8LIesroCHGvYikxXUae4Jw1I4gewTli/coO5kcpLjwz0zmG5q0l2gryG9PB1KIyWByddUXKkFo+YHjpKuK4GKr1hTtr/y2aGeNtra9SIi7Jxl/F
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BN0PR10MB5128.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6582132a-a650-436c-61db-08db7341daa9
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Jun 2023 16:58:08.1346
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vqFJuo9HVznsgV5M8Zw1KRCcMpKl0Sx2nTmqY75nu1ZgMplnC8BikbE8JPnsbiwBCwwExXgap9NjkHW+7b3grw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR10MB7868
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-06-22_12,2023-06-22_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 malwarescore=0
 mlxlogscore=861 suspectscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2306220143
X-Proofpoint-GUID: QFXY2K_2NI5H3Ps6xnHdN5n4s84qVWuz
X-Proofpoint-ORIG-GUID: QFXY2K_2NI5H3Ps6xnHdN5n4s84qVWuz
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

DQo+IE9uIEp1biAyMiwgMjAyMywgYXQgMTI6NDAgUE0sIHN0c3AgPHN0c3AyQHlhbmRleC5ydT4g
d3JvdGU6DQo+IA0KPiAyMi4wNi4yMDIzIDE2OjQ4LCBKZWZmIExheXRvbiDQv9C40YjQtdGCOg0K
Pj4gSSdtIG5vdCBvcHBvc2VkIHRvIGFkZGluZyBhIHNlbGZ0ZXN0IGhlcmUsIGJ1dCBtb3N0IGZp
bGVzeXN0ZW0gdGVzdGluZw0KPj4gaXMgZG9uZSB2aWEgeGZzdGVzdHM6DQo+PiANCj4+ICAgICBo
dHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vZnMveGZzL3hmc3Rlc3RzLWRldi5naXQvDQo+
PiANCj4+IEl0IHdvdWxkIGJlIGJldHRlciB0byBhZGQgdGhpcyB0ZXN0IHRvIHRoZSBleGlzdGlu
ZyBnZW5lcmljLzQ3OCB0ZXN0DQo+PiB0aGF0IHRlc3RzIE9GRCBsb2Nrcy4gQ2FuIHlvdSBwYXRj
aCB0aGF0IHRvIGFkZCBhIHRlc3QgZm9yIHRoZSBuZXcNCj4+IGZ1bmN0aW9uYWxpdHk/DQoNCkkg
YWdyZWUgd2l0aCBKZWZmLCB0aGlzIHRlc3QgbmVlZHMgdG8gZ28gaW4geGZzdGVzdHMuDQoNCg0K
PiBJIGRvbid0IGFjdHVhbGx5IHRoaW5rIGl0cyBwb3NzaWJsZS4NCj4gSXQgc2VlbXMgbGlrZSB0
aGVpciBzY3JpcHQgY3JlYXRlcyAyDQo+IHRfb2ZkX2xvY2tzIHByb2Nlc3Nlcywgb25lIGZvciBj
cmVhdGluZw0KPiB0aGUgbG9jaywgb25lIGZvciB0ZXN0aW5nIGl0Lg0KPiBUaGlzIGlzIG5vdCBv
dXIgY2FzZS4NCj4gVG8gbWFrZSBpdCB3b3JrIG91ciB3YXksIHdlJ2QgcHJvYmFibHkNCj4gbmVl
ZCB0byBoYWNrIHRoYXQgdGVzdCBkaXJlY3RseSBpbnRvDQo+IHRfb2ZkX2xvY2tzLmMsIHNvIHRo
YXQgaXQgY2FuIHNldCBhbmQgdGVzdA0KPiBmcm9tIHRoZSBzYW1lIGZkLg0KDQpPciB5b3UgY291
bGQgYWRkIGEgbmV3IHRlc3QgcHJvZ3JhbS4NCg0KDQo+IEFuZCBJIGRvbid0IGtub3cgaG93DQo+
IHRvIGV2ZW4gcnVuIHRoZXNlIHRlc3RzLiA6KQ0KPiBTbyBJIGFtIHJlYWxseSBpbmNsaW5lZCB0
byBsaW1pdCBteXNlbGYNCj4gd2l0aCBhIGtlcm5lbCBzZWxmdGVzdC4NCg0KSU1PIHRoYXQncyBu
b3QgYSByZWFzb24gbm90IHRvIGRvIHRoaXMgcHJvcGVybHkuDQoNCllvdSBzaG91bGQgd29yayB3
aXRoIEplZmYgYW5kIHRoZSBtYWludGFpbmVyIG9mDQp4ZnN0ZXN0cyB0byBtYWtlIGl0IGhhcHBl
bi4NCg0KDQotLQ0KQ2h1Y2sgTGV2ZXINCg0KDQo=
