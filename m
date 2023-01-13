Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74CC1669118
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 09:36:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240437AbjAMIgX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 03:36:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240492AbjAMIgS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:36:18 -0500
Received: from mx07-001d1705.pphosted.com (mx07-001d1705.pphosted.com [185.132.183.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8411156
        for <linux-fsdevel@vger.kernel.org>; Fri, 13 Jan 2023 00:36:15 -0800 (PST)
Received: from pps.filterd (m0209324.ppops.net [127.0.0.1])
        by mx08-001d1705.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30D7M3ZE030166;
        Fri, 13 Jan 2023 08:35:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sony.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=S1;
 bh=fQUi7xBPIqaTh5EW711RxkGg8CnG861STMQyfuJfdsY=;
 b=QnHtgy0Nap8YKtz1V5xojWj6tILu4oRu1flIy4yi/7aWHz6oupYqpME3uxht6fpK4but
 wS/FcUnaSXwo7CMmSAAbEEfJ86CoPBPYh5fZkkjeLR4vDix+R7rYdPjbpvRtIKyT/rk3
 iPeUTrtf9dnQoZwN3qZZtNTGFZZCVt9zRyIRs7LFpVyIcLOQ/NWmJwOlYSqXOgQRTzek
 MR6Tea9F8AWKLga8n+jxP8olTdhX8bKxgOJ4ipVNI+QFO2zH5Ee+CS2DkaY4IuTrWiEx
 1ak53YmKmsVn3/gpHGZ9ftEKDCyLwT9QhyGX/cz8JtAb60IPhE+klgiZxDvZrFsGxt4J Cg== 
Received: from apc01-psa-obe.outbound.protection.outlook.com (mail-psaapc01lp2049.outbound.protection.outlook.com [104.47.26.49])
        by mx08-001d1705.pphosted.com (PPS) with ESMTPS id 3n1kjktrdk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 08:35:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kgcn4cVxE6MtYLCRPBKfx0RC3IAcWW/NNJYzEudz0usabQuVx1LxyBWjy4lYedV7WnLdB4l37T4drxlOwxPT8nkLQIz2aKsjq3JWlfLbeLjxO89+1C+g8PEse0swHitmVqsOx+Dv+8LEsSknuN/rN4Sl8bvwMUXTaxUW5M6DVWHJSZgKB7Bw5/24qKuhUlp4gKtRZKAbWmnr+Ti4lfSb2saTDspyotWXGm8DCos87NBmEezo0gKb8+GLqy7jfHgeam8CM5xai5CDBmu5tRI3NTDAaMotHvsd02sxnjNSKKEFMVUEDKvSzvII6QZAcO29Ax29QK4phEwktzujG4rhgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fQUi7xBPIqaTh5EW711RxkGg8CnG861STMQyfuJfdsY=;
 b=R8S6H5EjnV1tQ/7bOD0LOnsn8mm/PkW4FZkCGbjnQnT4ArR71WPGKoTF81phgpkwVxfeAIIG2/SXtEgE3Dxxc9CvwczeLxXcszgvBTKwelvEk4eRuy0F6DgrtKoSafHahjX4TEeYmgop5oT+26bC22xyuMuVBZWLwGzkar0jSdzAxyi98SXjwdzsz6xRAqSV65qa62fjzwxvtqO+HUqGKB/oaPmxd2jmnx01aAyHr/+MDU0TWHfR4jMVlvxFsDVOes85Iox5jkwhrxDrPwPc9LhT7aTSDcOUa9Y8L+isJOFrjdE7Jo9roPpi4ViuUhHZXS0WSo9bAHTBusDHVc+aRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=sony.com; dmarc=pass action=none header.from=sony.com;
 dkim=pass header.d=sony.com; arc=none
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com (2603:1096:301:fc::7)
 by PSAPR04MB4374.apcprd04.prod.outlook.com (2603:1096:301:35::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5986.19; Fri, 13 Jan
 2023 08:35:48 +0000
Received: from PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13]) by PUZPR04MB6316.apcprd04.prod.outlook.com
 ([fe80::1cb5:18cc:712d:1f13%9]) with mapi id 15.20.5986.018; Fri, 13 Jan 2023
 08:35:48 +0000
From:   "Yuezhang.Mo@sony.com" <Yuezhang.Mo@sony.com>
To:     Sungjong Seo <sj1557.seo@samsung.com>,
        'Namjae Jeon' <linkinjeon@kernel.org>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "'Wang Yugui'" <wangyugui@e16-tech.com>,
        =?utf-8?B?J0JhcsOzY3NpIETDqW5lcyc=?= <admin@tveger.hu>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "Andy.Wu@sony.com" <Andy.Wu@sony.com>,
        "Wataru.Aoyama@sony.com" <Wataru.Aoyama@sony.com>
Subject: RE: [PATCH v2] exfat: handle unreconized benign secondary entries
Thread-Topic: [PATCH v2] exfat: handle unreconized benign secondary entries
Thread-Index: AQHZJo7y5h16sYwNTk+h7l7ut+eKRq6bnW4wgAAmgICAAAVowIAAJKKAgAAHJUA=
Date:   Fri, 13 Jan 2023 08:35:47 +0000
Message-ID: <PUZPR04MB631648B2F33E68B31379AFD381C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
References: <20230112140509.11525-1-linkinjeon@kernel.org>
        <PUZPR04MB63165533693F8FD12046D19581C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
        <CAKYAXd8p8mmSaXLNjkzDH=AmrOyhA5DYsjuKEA7=c+1pYfY5AQ@mail.gmail.com>
        <CGME20230113061305epcas1p2ec0bdad0fbe3cca6e3142f99e9260226@epcas1p2.samsung.com>
        <PUZPR04MB63167FAB29A81DB38D43DD5A81C29@PUZPR04MB6316.apcprd04.prod.outlook.com>
 <626742236.41673593803778.JavaMail.epsvc@epcpadp3>
In-Reply-To: <626742236.41673593803778.JavaMail.epsvc@epcpadp3>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PUZPR04MB6316:EE_|PSAPR04MB4374:EE_
x-ms-office365-filtering-correlation-id: 1f68fd79-9442-46aa-2207-08daf5412ba4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tnSJ1P6i8B0adt1weoU2zTyIiPP2NYgZIpqRtiotJraYfSKRPBhB3UUizL/tms9ixzMw3QiDhLCIDI/5r+wzKUBo0BRjfEgmsKmEUc6DuH5VzQJfsgu3rR9H/6HMuZpjIHMWBkxKfcZLDEPd4qjV4F28aOlgMGcgjGCIu3wh2JNBaRgpCYX/Y6+E4uwYrYzKw7NVCUrzOrWzP5vBqIEZ/v0iQsTg2T3maqQwnCvHgcdZHKiMoUQwbQnr446cAxADBnuFavmyFvLaaaRMRZt5nlCnvfFPA8H9eylhqXMTi3o4wZfTPG5tr+a9CLcSXBDjsj2LCaTjS2PJlRjOySbugHNvAebMqgwY3oKL0MgA1LI2Y5AHXlAh+5z/zZgg5xLHQSgGGMVIjktjFVqv4N/hmKfJ6yje9Yhs7R/AoEezaxZlOa6Jx89w1swxv2nIYrJfN7BiCsdRLN/y/kyTKcwHv5IALnc1js6jNzVUVIMfgrARJV+W22f21GR2pegfunUfbo59QO0v0jDOywuvs6T6sX1NpzrcIfnJaByHjux2YvdJv9lIs7Z9WputMpuUf19+GPEjkFMnRt+DqJUw7hZqU9/De3o5Tnxshy0i23KE9bkIoaSFtPfUUiem9yagzW+bUK3fT2BeKFdc4GEV+wMp+/U08QiLJ5NFG8WDzN/cvgOHVTiu49fbVwZo+ZZvbzaMAFv9kGJipIamjFS3P68umdMykVhbGMUTc16OQhpsrnc=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PUZPR04MB6316.apcprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(4636009)(376002)(396003)(346002)(136003)(39860400002)(366004)(451199015)(2906002)(33656002)(107886003)(5660300002)(110136005)(82960400001)(6506007)(122000001)(38100700002)(8936002)(55016003)(52536014)(54906003)(478600001)(41300700001)(38070700005)(83380400001)(7696005)(64756008)(66946007)(76116006)(71200400001)(8676002)(4326008)(66476007)(66556008)(66446008)(9686003)(186003)(966005)(316002)(86362001)(26005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RWM2ZFFWY3RQdlBGd1ZWc3ZFdG5zQ0VlQzN2ZTNTaVdnV3lRelI5Y3haREk0?=
 =?utf-8?B?MEFHeWpKVzlNZXB4RTFKWDYvZGdiVnVKUVh5TkJ4anFTbWlsOCs1VFcwNjJx?=
 =?utf-8?B?aFgwUlFVeDNHOG5mOXhNM1E2OGhTdEtMZTBsS1Y4aDRucVV5bnZyaTI0c0Y0?=
 =?utf-8?B?aGMwYzhJSlNCUFQzNlYrSHhIQ1JCbmtDNGl5MEYyVVlNL0xZWUlDblRmRnQr?=
 =?utf-8?B?dmFZNjdhNC91dUZSaExqei8wa3JqM2MzTUJhZVVCYjVrWFNOMEFmL29UT0pr?=
 =?utf-8?B?ZWlhcENvWWtzWHRwSDF4aE56Z01iVHJuYThXREVXRXl6aWVnZEhnMHZvaDZr?=
 =?utf-8?B?NXlsb2pxekFDYWczTHBoTnVra0lPMU5iMTdpb0NJSG5KN2JCNGhhWGxORmlO?=
 =?utf-8?B?cGVmOW5UZ1ZlSDFvL3ZpSVpsUlk3MUZnT2dQQTJpQWZKWS9KbVN1M014b0Mv?=
 =?utf-8?B?R1pVYWJTempjQTN6MVN4RnJqcWRxYWJtcDJqV0dTcTBkWDREV0c3WkVMK1Vv?=
 =?utf-8?B?QVNTR2ZqT1Q1UnFnZ2REbVNwUEY3VlhIN3JvZ2pqTnd0ZXNYMm5JWWQ5Uk9t?=
 =?utf-8?B?K2FKTkcwMERrL3F2NG0vaUdMYk5Uc1dXbFNreE0rZkNqUi9JMDFUWndDc3Aw?=
 =?utf-8?B?OE5NWEc1TVV5V1dIUmlOSGUrdEZEaFB4ZENBUS9lRmtveWc2K2pGYTVENjdh?=
 =?utf-8?B?clhsOVFSYWtDOE1iTUFteCtTa29LaHZ6RUZUOWdxNVJQQlpvbm9LOVB2QjRq?=
 =?utf-8?B?TjNmMU5NNmdDT1Ric1VMbHpUMFpWWTVEdW0rZTRHdG53OHAvVWFhTTVlSlND?=
 =?utf-8?B?UmExbkxmRjZyOUhWNHZMR0tkb1NnUnUydlJtVWl1T3BPdHpabzh3cndXN2Jo?=
 =?utf-8?B?UTRMa0JPZ1E4NEFqbGphblhXcHQ3bTZWUjRMdlRmcnRYTFgxczF2ZjJVWGgx?=
 =?utf-8?B?ajdCcWhwdk96bGdCRkhTKzJ0ZXRWd1Qwb2xlQ3R1YTZLT3hpTkhxcE5iNUly?=
 =?utf-8?B?MW5XRFBHNUs5VDE2d1oyT2Q3ZjJBZFcyNVVtMmFUY29OK0dvZzllbStqT1BW?=
 =?utf-8?B?U04zOThKNWlsOWNIMG9QYXoyeTl1ZHdka0Y2dTRaUkN2NlJDN0graU1nbjNZ?=
 =?utf-8?B?cXduN1ZPV3lVUzdmUzlZdThMbmtEWVNrRnI5WDFXZTlhMnFabEowNzJ5WVk4?=
 =?utf-8?B?RzRtWnZPRFM1eGt5NFpRYlB1RE1Nb2V3eXBTZ21WZTdJOXdlZmgwaFBSNlFh?=
 =?utf-8?B?Sm9pTER0QVpLK1VVUUR6YUphUURqUW04anVrRUFsaDVEVktLUzdKSWZCUmlP?=
 =?utf-8?B?SWZycXhramI5WVpoRjlsYnllRVJ1c1BvYXBNajdtUzlaeW4yelNLUjdwNWFu?=
 =?utf-8?B?d1JYbUZ6Si9xSXFSZmpCUUkyZmJ5VWt2MjVCVFAyK25UVW02MHpVQ1JCNGRR?=
 =?utf-8?B?ejZPZTZiNWxiNVB5WHkwYy92ZEJPNUxhWStLMFNFTzZBYmdjL3FLNnU3b2JJ?=
 =?utf-8?B?VStZcjhzVXBveUxPckZMU3NFUE9XMzExM1V0cFVjL1RyTm83TWdIR0hhQlMx?=
 =?utf-8?B?OS9OOTc4eGljZFBTQ2c4UzZuVVRTTDdXeDhMR0w3bWdvemYzLytuWG5hSHZD?=
 =?utf-8?B?Z2xOaHFSTEdONHJBY1hmOXM0U3ovQVZab2JWaFRDcWM2T2JaU2hEelZkeVYy?=
 =?utf-8?B?cDBqdTloQlZ3a3k2QW9VUGRaTkgySmtPM3RhN1ArQTZHbjBEcEZWWU5CeVJa?=
 =?utf-8?B?RlluYUF3b3dKc1FjOEFmN2ZNWUlwVEpjSkNQVW8vME14RWhNTkFqQ2E1UlJK?=
 =?utf-8?B?cVEwMUhEQ0hQTG83Uk9icUwxY3ZsWTFCcnNzb05ZMnpBVGFSc0cxL0ZsaDdr?=
 =?utf-8?B?dDFWcnpJL2k1K0hMbE0zQVJ3bEY4ekxsR0RYYW1HRUV0UlMvcG83UmZZNmR6?=
 =?utf-8?B?NmF0ekJrRHBNZk9EbXo0S0pLZnFzaUdOUEV2VFJVZlJXWnlrYTZtRlJ3Smo4?=
 =?utf-8?B?UjFYQXhETWZhNnpEZFo2b29Ld05kZjRLSnhaSHdaM3RaNjd2WjVLVGhpaW5D?=
 =?utf-8?B?bkRabDN0UGF4Tm95STN6UXBNYUZyWnN6aDE4ck1NaWY5d3NNeEVsMkNvdUV6?=
 =?utf-8?Q?TvvsUI0yCmdMRs73JjPfbdWzA?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 2ct5AfwNHz5Kb0v/6Hmu6TjBtcFz060aCmU5VGXaxnG64j6OmC6qU/VKhJv1mNzmtrIfPOk9jpLcNz7W2PBxGjmXECW1UUH7Y6HZCzqr7Fm28uvW2yCVp3Utr/OpjHAQ8PY4TTZYXqTz1ZMH6oelFzahJV04w09015XJxE9U6txGtXKFs6ybA4aUkDM6hiGyQHACmzwel6iUMQFlFlWYv0MIMyMatjk3L+nGvyDbQ0+4a3CsZ6DK3PexA4v4JN4+9BJHAbYqAStg5djGVCEFpzsWgjD7DC9/I+gMTHU1154GEJNKoyVY0aQ9N3JkHmEMqsUAp5LAtn45N8H5wbgoYqC3WlSeiCTWxp3v+n0ZeyONTPs/WQvR1FY1wcHfjztjCBWFacdBAJAvKsTx2uidbdw9gF6tsSBSCdtv0QLD9X+M8e9ZzSgN88R3Evev+BPYsEGaP3qz8PxiPbYpWpru6Wl63Ty3SjAOLHjWF2TU96PmHR/IT38f1Fyus6r9i3JNaI7QO4Iho/CZ/LMZ2TiQZPaxquBH575OKoi2Kebv9Bj2b3bK5ZqUl9RHNBPyq7e3FuVK8TsGUyXB94FoVNPgRQSTbaOIbZHezmb4ZD02YaDWaAtJo2vodPcLqkQl8ZMK8PAYI+zmVl/x75LgUVEgsY0GeyloWsxNgBWaAytylqfJzqaBCriS3rVYkL7ZLEoHSQJ82DZOB9Jl45764lRafji5b39Mfl5nT3ss7ZH3bFyx2Hj0bNlwM2XwaIHQiqKrquhFRWmniV1grKKCrJgZnYCP/xQmaac5wgDT0UwpME/Kg5DJ0HO+KKVIL3XDDCDmdYboXPZmIzcnnTaIbpT4ahZ+xTl5u7F168zZqHjntds6WKNMz+lX1KA+WuCysKFo3nKX6sPsQ3ceY4hWRCNyTg==
X-OriginatorOrg: sony.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PUZPR04MB6316.apcprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f68fd79-9442-46aa-2207-08daf5412ba4
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2023 08:35:47.9890
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 66c65d8a-9158-4521-a2d8-664963db48e4
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SJGSJM3BX6Um0obxK5v7hNbZ5q3VhbA3NrpZFNEs30md5rN9t2p8qPd+aiJ6T9t2tqOs2LWcHP8KyrnvhVRYbg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PSAPR04MB4374
X-Proofpoint-GUID: IuSIZzHKlUPkKLKzjOs4GVNs3tjdNSRV
X-Proofpoint-ORIG-GUID: IuSIZzHKlUPkKLKzjOs4GVNs3tjdNSRV
X-Sony-Outbound-GUID: IuSIZzHKlUPkKLKzjOs4GVNs3tjdNSRV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-13_03,2023-01-12_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

PiA+ID4gPg0KPiA+ID4gPj4gKwkJaWYgKGV4ZmF0X2dldF9lbnRyeV90eXBlKGVwKSAmIFRZUEVf
QkVOSUdOX1NFQykNCj4gPiA+ID4+ICsJCQlleGZhdF9mcmVlX2Jlbmlnbl9zZWNvbmRhcnlfY2x1
c3RlcnMoaW5vZGUsIGVwKTsNCj4gPiA+ID4+ICsNCj4gPiA+ID4NCj4gPiA+ID4gT25seSB2ZW5k
b3IgYWxsb2NhdGlvbiBlbnRyeSgweEUxKSBoYXZlIGFzc29jaWF0ZWQgY2x1c3Rlcg0KPiA+ID4g
PiBhbGxvY2F0aW9ucywgdmVuZG9yIGV4dGVuc2lvbiBlbnRyeSgweEUwKSBkbyBub3QgaGF2ZSBh
c3NvY2lhdGVkDQo+ID4gPiA+IGNsdXN0ZXINCj4gPiA+IGFsbG9jYXRpb25zLg0KPiA+ID4gVGhp
cyBpcyB0byBmcmVlIGFzc29jaWF0ZWQgY2x1c3RlciBhbGxvY2F0aW9uIG9mIHRoZSB1bnJlY29n
bml6ZWQNCj4gPiA+IGJlbmlnbiBzZWNvbmRhcnkgZW50cmllcywgbm90IG9ubHkgdmVuZG9yIGFs
bG9jIGVudHJ5LiBDb3VsZCB5b3UNCj4gPiA+IGVsYWJvcmF0ZSBtb3JlIGlmIHRoZXJlIGlzIGFu
eSBpc3N1ZSA/DQo+ID4NCj4gPiBGcm9tIGV4RkFUIHNwZWMsIHRoZXJlIGFyZSAyIHR5cGVzIGJl
bmlnbiBzZWNvbmRhcnkgZW50cmllcyBvbmx5LA0KPiA+IFZlbmRvciBFeHRlbnNpb24gZW50cnkg
YW5kIFZlbmRvciBBbGxvY2F0aW9uIGVudHJ5Lg0KPiA+DQo+ID4gRm9yIGRpZmZlcmVudCBWZW5k
b3IsIERpZmZlcmVudCBWZW5kb3JzIGFyZSBkaXN0aW5ndWlzaGVkIGJ5IGRpZmZlcmVudA0KPiA+
IFZlbmRvckd1aWQuDQo+ID4NCj4gPiBGb3IgYSBiZXR0ZXIgdW5kZXJzdGFuZGluZywgcGxlYXNl
IHJlZmVyIHRvDQo+ID4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9fX2h0dHBzOi8vZG9rdW1l
bi5wdWIvc2QtX187ISFKbW9aaVpHQnYzUnZLUg0KPiA+DQo+IFN4IS1pYUszRFNPMnloMXBHamRP
TG9aak1oSDdzNlFFQWJOLVlkMDVibkJ6VHpwUGtzMTBKTkNwdFlidkFkSFoNCj4gWFlZdm94DQo+
ID4gNUQ0UGkyeEMzVEJxSDFwSEVJZyQNCj4gPiBzcGVjaWZpY2F0aW9ucy1wYXJ0LTItZmlsZS1z
eXN0ZW0tc3BlY2lmaWNhdGlvbi12ZXJzaW9uLTMwMC5odG1sLiBUaGlzDQo+ID4gaXMgdGhlIHNw
ZWNpZmljYXRpb24gdGhhdCB0aGUgU0QgQ2FyZCBBc3NvY2lhdGlvbiBkZWZpbmVzIFZlbmRvcg0K
PiA+IEV4dGVuc2lvbiBlbnRyaWVzIGFuZCBWZW5kb3IgQWxsb2NhdGlvbiBlbnRyaWVzIGZvciBT
RCBjYXJkLiAiRmlndXJlIDUtMyA6DQo+ID4gQ29udGludW91cyBJbmZvcm1hdGlvbiBNYW5hZ2Vt
ZW50IiBpcyBhbiBleGFtcGxlIG9mIGFuIGVudHJ5IHNldA0KPiA+IGNvbnRhaW5pbmcgYSBWZW5k
b3IgRXh0ZW5zaW9uIGVudHJ5IGFuZCBhIFZlbmRvciBBbGxvY2F0aW9uIGVudHJ5LiBJbg0KPiA+
IHRoZSBleGFtcGxlLCB3ZSBjYW4gc2VlIHZlbmRvciBleHRlbnNpb24gZW50cnkoMHhFMCkgZG8g
bm90IGhhdmUNCj4gPiBhc3NvY2lhdGVkIGNsdXN0ZXIgYWxsb2NhdGlvbnMuDQo+IA0KPiBGcm9t
ICI4LjIgaW4gdGhlIGV4RkFUIHNwZWMiIGFzIGJlbG93LCBpdCBpcyBuZWVkZWQgdG8gaGFuZGxl
IGFsbCB1bnJlY29nbml6ZWQNCj4gYmVuaWduIHNlY29uZGFyeSBlbnRyaWVzIHRoYXQgaW5jbHVk
ZSBOT1Qgc3BlY2lmaWVkIGluIFJldmlzaW9uIDEuMDAuDQo+IA0KPiA4LjIgSW1wbGljYXRpb25z
IG9mIFVucmVjb2duaXplZCBEaXJlY3RvcnkgRW50cmllcyBGdXR1cmUgZXhGQVQgc3BlY2lmaWNh
dGlvbnMNCj4gb2YgdGhlIHNhbWUgbWFqb3IgcmV2aXNpb24gbnVtYmVyLCAxLCBhbmQgbWlub3Ig
cmV2aXNpb24gbnVtYmVyIGhpZ2hlciB0aGFuDQo+IDAsIG1heSBkZWZpbmUgbmV3IGJlbmlnbiBw
cmltYXJ5LCBjcml0aWNhbCBzZWNvbmRhcnksIGFuZCBiZW5pZ24gc2Vjb25kYXJ5DQo+IGRpcmVj
dG9yeSBlbnRyaWVzLiBPbmx5IGV4RkFUIHNwZWNpZmljYXRpb25zIG9mIGEgaGlnaGVyIG1ham9y
IHJldmlzaW9uIG51bWJlcg0KPiBtYXkgZGVmaW5lIG5ldyBjcml0aWNhbCBwcmltYXJ5IGRpcmVj
dG9yeSBlbnRyaWVzLiBJbXBsZW1lbnRhdGlvbnMgb2YgdGhpcw0KPiBzcGVjaWZpY2F0aW9uLCBl
eEZBVCBSZXZpc2lvbiAxLjAwIEZpbGUgU3lzdGVtIEJhc2ljIFNwZWNpZmljYXRpb24sIHNob3Vs
ZCBiZQ0KPiBhYmxlIHRvIG1vdW50IGFuZCBhY2Nlc3MgYW55IGV4RkFUIHZvbHVtZSBvZiBtYWpv
ciByZXZpc2lvbiBudW1iZXIgMSBhbmQNCj4gYW55IG1pbm9yIHJldmlzaW9uIG51bWJlci4gVGhp
cyBwcmVzZW50cyBzY2VuYXJpb3MgaW4gd2hpY2ggYW4NCj4gaW1wbGVtZW50YXRpb24gbWF5IGVu
Y291bnRlciBkaXJlY3RvcnkgZW50cmllcyB3aGljaCBpdCBkb2VzIG5vdCByZWNvZ25pemUuDQo+
IFRoZSBmb2xsb3dpbmcgZGVzY3JpYmUgaW1wbGljYXRpb25zIG9mIHRoZXNlIHNjZW5hcmlvczoN
Cj4gLi4uDQo+ICAgNC4gSW1wbGVtZW50YXRpb25zIHNoYWxsIG5vdCBtb2RpZnkgdW5yZWNvZ25p
emVkIGJlbmlnbiBzZWNvbmRhcnkNCj4gICBkaXJlY3RvcnkgZW50cmllcyBvciB0aGVpciBhc3Nv
Y2lhdGVkIGNsdXN0ZXIgYWxsb2NhdGlvbnMuDQo+ICAgSW1wbGVtZW50YXRpb25zIHNob3VsZCBp
Z25vcmUgdW5yZWNvZ25pemVkIGJlbmlnbiBzZWNvbmRhcnkgZGlyZWN0b3J5DQo+ICAgZW50cmll
cy4gV2hlbiBkZWxldGluZyBhIGRpcmVjdG9yeSBlbnRyeSBzZXQsIGltcGxlbWVudGF0aW9ucyBz
aGFsbA0KPiAgIGZyZWUgYWxsIGNsdXN0ZXIgYWxsb2NhdGlvbnMsIGlmIGFueSwgYXNzb2NpYXRl
ZCB3aXRoIHVucmVjb2duaXplZA0KPiAgIGJlbmlnbiBzZWNvbmRhcnkgZGlyZWN0b3J5IGVudHJp
ZXMuDQo+IA0KDQpNeSB1bmRlcnN0YW5kaW5nIGFyZQ0KDQoxLiBJZiBuZXcgYmVuaWduIGRpcmVj
dG9yeSBlbnRyaWVzIGFyZSBkZWZpbmVkIGluIHRoZSBmdXR1cmUsIHRoZSBtaW5vciB2ZXJzaW9u
IG51bWJlciB3aWxsIGJlIGluY3JlbWVudGVkLg0KICAtIElmIEZpbGVTeXN0ZW1SZXZpc2lvbiBp
cyAxLjAsIEJlbmlnbiBzZWNvbmRhcnkgaXMgb25seSBWZW5kb3IgRXh0ZW5zaW9uIERpcmVjdG9y
eUVudHJ5IG9yIFZlbmRvciBBbGxvY2F0aW9uIERpcmVjdG9yeUVudHJ5Lg0KICAtIElmIEZpbGVT
eXN0ZW1SZXZpc2lvbiBpcyBoaWdoZXIgdGhhbiAxLjAsIGFub3RoZXIgQmVuaWduIHNlY29uZGFy
eSBlbnRyaWVzIGFyZSBkZWZpbmVkLg0KICAtIFNvIGl0IHNlZW1zIHdlIG5lZWQgdG8gYWRkIGEg
Y2hlY2sgZm9yIEZpbGVTeXN0ZW1SZXZpc2lvbiBpbiBleGZhdF9yZWFkX2Jvb3Rfc2VjdG9yKCkN
CiAgICAtIElmIEZpbGVTeXN0ZW1SZXZpc2lvbiBpcyBoaWdoZXIgdGhhbiAxLjAsIG1vdW50IHdp
dGggcmVhZCBvbmx5LCBiZWNhdXNlIHdlIGNhbiBub3QgaGFuZGxlIHRoZSB2ZXJzaW9uLg0KDQoy
LiBOb3QgYWxsIEJlbmlnbiBzZWNvbmRhcnkgaGF2ZSBGaXJzdENsdXN0ZXIgYW5kIERhdGFMZW5n
dGggRmllbGRzLg0KICAtIFZlbmRvciBFeHRlbnNpb24gRGlyZWN0b3J5RW50cnkgaGFzIG5vIEZp
cnN0Q2x1c3RlciBhbmQgRGF0YUxlbmd0aCBGaWVsZHMsIGFuZCB0aGVyZSBhcmUgbm8gY2x1c3Rl
cnMgdG8gZnJlZSB3aGVuIGRlbGV0aW5nIGl0Lg0KDQogIFRhYmxlIDM2IFZlbmRvciBFeHRlbnNp
b24gRGlyZWN0b3J5RW50cnkNCiAgRmllbGQgTmFtZSAJCQlPZmZzZXQoYnl0ZSkJU2l6ZShieXRl
KQ0KICBFbnRyeVR5cGUgCQkJCTAgCQkJMQ0KICBHZW5lcmFsU2Vjb25kYXJ5RmxhZ3MgCTEgCQkJ
MQ0KICBWZW5kb3JHdWlkCQkJCTIJCQkxNg0KICBWZW5kb3JEZWZpbmVkCQkJMTgJCQkxNA0KDQog
LSBWZW5kb3IgQWxsb2NhdGlvbiBEaXJlY3RvcnlFbnRyeSBoYXMgRmlyc3RDbHVzdGVyIGFuZCBE
YXRhTGVuZ3RoIEZpZWxkcywgdGhlIGFzc29jaWF0ZWQgY2x1c3RlciBzaG91bGQgYmUgZnJlZWQg
d2hlbiBkZWxldGluZyBpdC4NCg0KICBGaWVsZCBOYW1lIAkJCU9mZnNldChieXRlKQlTaXplKGJ5
dGUpDQogIEVudHJ5VHlwZQkJCQkwIAkJCTENCiAgR2VuZXJhbFNlY29uZGFyeUZsYWdzIAkxCQkJ
MQ0KICBWZW5kb3JHdWlkCQkJCTIJCQkxNg0KICBWZW5kb3JEZWZpbmVkCQkJMTggCQkJMg0KICBG
aXJzdENsdXN0ZXIJCQkJMjAgCQkJNA0KICBEYXRhTGVuZ3RoCQkJCTI0IAkJCTgNCg0KQlRXLCBJ
IHN0YXJ0IG15IFNwcmluZyBGZXN0aXZhbCB2YWNhdGlvbiB0b21vcnJvdywgc28gSSBtYXkgbm90
IGJlIGFibGUgdG8gcmVzcG9uZCB0byBlbWFpbHMgaW4gdGltZS4NCg==
