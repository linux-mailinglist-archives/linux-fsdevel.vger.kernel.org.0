Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E7514F5686
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 08:38:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiDFGXs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 02:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1454349AbiDFFU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 01:20:27 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A90C98585;
        Tue,  5 Apr 2022 17:55:32 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23600wSw000849;
        Wed, 6 Apr 2022 00:55:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=6jaw8dju+f5EfZXrXkjaHNYAE0wAmut7eJOxOGyvWf8=;
 b=1ENGy9QHRL1fk6k9K5dYHAVx9WEnmBTT+1xGctTkdPJwT+yqvDIu/reeb3t0RlsicCic
 4lkX6hDslRbuPjA/6eL6+Jny6iX78Q4ddodB9Y1Jk1zARA97ea51Co3MBOFdiWP8bGba
 zJYM2qNDoBy5HZCPUtosdFYj1VaLXlb6+FX+Wm4IAJTyvYGfvQYwaIgpjiuTgkpSPeuY
 SjrKKGpl+AfhR+5vh0o5LpEJBr24Hi1CE7GU2Y0pElpbAOxI3V+FtOjpayQcfJ3mXhsQ
 t2Jx3dUSN5smaf18BJtEwUn0KhTruqPiO8eAZDnTvPv7wMhy9voOAeQHUMWIamzNqfc8 4w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6e3sqfcd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 00:55:14 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 2360Ze6a036766;
        Wed, 6 Apr 2022 00:55:13 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3f6cx47jpa-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 00:55:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZytxjnK9l1BPLS5GHzLfsGWmRW99nZBRCRyiFrlb/fcHufmR5D+5zcPOTqKfBpiZ9QRE2Uzyayj1anlOst2+8ipuvb2WAOwlhRgi0u8CmrecxSrmDZzDkhyP0UVTdXko+OKbhnr7Iy6i41J9Os/4/SdaaeTnBv8i/QAotLLxmdKsjF6O9ocOpC/6Vp6wPxdvsngC+zveiRSydTKCJgnippyBeQ7JsIzF+ZPHE/k9CJAnje0Lbaaiihd3e92QQm5a3n7J0scjwKSj/xpECBT0q/TgKMl3WPLncxmro4nhV5jCqcGWETz64GeE2il09PrHGyCyX7i9APSu2WipReQQYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6jaw8dju+f5EfZXrXkjaHNYAE0wAmut7eJOxOGyvWf8=;
 b=TeaMy4g8fvYfP2Ltbl4hm0MeHNrCF1pfSrmKhFkAwsUFn2JyMef3XaIRh+zHRAtfHGqZtLKLVBI4VludwHLVNVMfI/OU6kQDii/YsXrq3Nl09Th7wohIUPvrwxGVEI2hV1pX8DEPF/dVb7mPr+ZnuyCgxb7r7FstWSLFG3ZQd5DSXKROefUPbHcg9tv4bfnrs+gFfmleAGpsbBHYWAm1KRT4HhzaJAUpz3K05iSU3qQLr5t4fmHk23Oc7SyrPSNbmq4EVWJtD0hhZEDXwVoHwgkvBEJVxOc/howz1E9LhFdD+2senzaO+hKSOO+AJZmdmrB8eNJ42HxOO1CZ8ZPGeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6jaw8dju+f5EfZXrXkjaHNYAE0wAmut7eJOxOGyvWf8=;
 b=W0LLWUkhYXEeonQhmZhVknyobG19AoTifm/DtES+rRqEpRLOwPSjw1V1kd75FMebQGT4Z0QcJ4SGCKqegOCcG58JXObjPVCoAzcsYqroN+NhuuO9MZuFQR+Od1sO+Acm1Rggb5bN9Syjiz07AWKtudwjyTG9f3KukqAz82KDx/M=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BN7PR10MB2452.namprd10.prod.outlook.com (2603:10b6:406:c1::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Wed, 6 Apr
 2022 00:55:10 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%7]) with mapi id 15.20.5123.030; Wed, 6 Apr 2022
 00:55:10 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>
CC:     Shiyang Ruan <ruansy.fnst@fujitsu.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        david <david@fromorbit.com>
Subject: Re: [PATCH v11 1/8] dax: Introduce holder for dax_device
Thread-Topic: [PATCH v11 1/8] dax: Introduce holder for dax_device
Thread-Index: AQHYK9Kpm1cE0BfAdUaTr1ZW76b9cKy66amAgAc3EYCAFXleAIAASPCAgAAC2ACAAAyegIAAUVeAgAAIBgCACf5sgA==
Date:   Wed, 6 Apr 2022 00:55:10 +0000
Message-ID: <fd37cde6-318a-9faf-9bff-70bb8e5d3241@oracle.com>
References: <20220227120747.711169-1-ruansy.fnst@fujitsu.com>
 <20220227120747.711169-2-ruansy.fnst@fujitsu.com>
 <CAPcyv4jAqV7dZdmGcKrG=f8sYmUXaL7YCQtME6GANywncwd+zg@mail.gmail.com>
 <4fd95f0b-106f-6933-7bc6-9f0890012b53@fujitsu.com>
 <YkPtptNljNcJc1g/@infradead.org>
 <15a635d6-2069-2af5-15f8-1c0513487a2f@fujitsu.com>
 <YkQtOO/Z3SZ2Pksg@infradead.org>
 <4ed8baf7-7eb9-71e5-58ea-7c73b7e5bb73@fujitsu.com>
 <YkR8CUdkScEjMte2@infradead.org> <20220330161812.GA27649@magnolia>
In-Reply-To: <20220330161812.GA27649@magnolia>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 34b45ca4-88e7-405d-d4b5-08da176819c9
x-ms-traffictypediagnostic: BN7PR10MB2452:EE_
x-microsoft-antispam-prvs: <BN7PR10MB24528ED0E7BC9CA11C361885F3E79@BN7PR10MB2452.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: yB7vpBLr/0TzPKrhdFeqdSC5kZ8ue4i1kRu7n0uZtFUmmAfKWh7yY53anOjImbrS1vab5Amoh+J/E3cZ06koq+7R8WQlXDJNn68im2Ix5lFlEuqIyFcjgUfu5636yD15HLxfez1A9Kl941k4EvHahUoALD9AL1faHiBsz5HDakh+oowXORiVqf/sLnurcEnSr+iw9RABGj/aCAOC5V5A0GZD9EF9zmJ4/vctpJVlaw45/iWTj+rE5GfQ01kOnF5gqIDIPuMJjUwK1dm5dgagoVhlRd7ykzfW1J8rycvpz0Gzw8C6HIJ+uySKUhMKTszsyUNKqT6IZ24Wq2Th2n7aX7BYiKxSEb70M9UO3X0xFvjHSWqXH28GUnlyB2c8581/7JeZisqqztOjzY5OIIP4vSNLj8F09G0/ExV6PgWtvnlV+6IeO2WJUuNUpqStGgwEBMeCQ4HPy3g35IkBTLlMkoDD6D9/uy6udhRqnldsmPAITm4STlhsPNNqSmfYxNRM7h+EKE6VQBrzp+rLqRmt3MdNIlQ4SJMajdnA0CzlbvDTNSSFIKzvI5R9sPUDJW0wuqBMDgFHsxh5eDtAGfRkwERdCaco2/dQgb2MbheyeDLu4OoQHgnt2+0K123zfYFHYobnbrzhWovHVb5f/jQaqMVpeqDPV0a8WFBBfbQKNBRAj+dchmKrFZbg2OKa/MUv1+FFjLzGLPENe5/Oy75nLOJ+vZqrasBAb+uZg0Wr9TiLb8TSsUTzQ+XKQpWT9BUMFwnNyCUPVc/ibhAHFgJD/A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6506007)(6512007)(31686004)(53546011)(122000001)(71200400001)(5660300002)(508600001)(36756003)(110136005)(8936002)(7416002)(4744005)(2616005)(2906002)(6486002)(54906003)(26005)(66476007)(31696002)(8676002)(4326008)(86362001)(38100700002)(66556008)(38070700005)(186003)(44832011)(83380400001)(76116006)(64756008)(91956017)(316002)(66946007)(66446008)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzIzTStiU21lNWRNVjVPd1dWSCthZFBwa29HUlNicDYwb3ROYlU4SmdmQm91?=
 =?utf-8?B?OEJ0QXJ2TEdadkdCdko4ZVh3L1NhVU5Bb1FkYlk3ek5FMjNSYmF0Zm1ubWUz?=
 =?utf-8?B?SmVmTzlFZS9rRUFmemxMNDNEM2JuQzlJK3pmM1dreDVqMjYyYkNZR1dBbUIw?=
 =?utf-8?B?bGlueExjb2tZeTRMVW9sYjk4RnRTRk1Qc05tQTFtaUIwRTFMN0loN0lJazdD?=
 =?utf-8?B?dlpUbmcxNFZLQ3FMMFF5dzMzWUJLWnJsMnJxYmIvUkFFdFhyaStHZUdoU2xs?=
 =?utf-8?B?b2RERGVGYU92Wi9yWlpnMGhkT1pNZ3d6bTJPKzVCWmdndVlxd2xmR1ZNYm8z?=
 =?utf-8?B?YkpkKzdGVWtRd2NZUjRMeVRxZHFmY3U0dFFlTXF1TFRnd2R1TEd6aXh2UVI1?=
 =?utf-8?B?Y0k2WFdrZy9ZR3M4ZUZKajZrb2tTZlNVSkNUZjZlRGI3WmJScUlzeGltTkNY?=
 =?utf-8?B?VVo2aDE2eDZJSmsxVWs3emo1RzN5V0hsNzZyVFlkSmFHREppTzdOQkllMCtr?=
 =?utf-8?B?YmU4b2FXSkVNaFk0UEZIL3Uwd3RrV3AwR3R5RkRMekFhanZkbkpsRWFOT1hY?=
 =?utf-8?B?Z0tsUVU5NzJwU04zSzllUkFYamFuVHVvbEprbTE3UkpLWTY3SzUyZDVpV2pW?=
 =?utf-8?B?ZUVFL3JIVUlJeVpGY2d1Ty9nQlRLQ1pGTE1QSVFZUmtJUUkxUWN4RzNITHNs?=
 =?utf-8?B?NHp4UFhPOFVmcmduUTREUnpmZE04dWU4Z3RhR1FDVjJaaFFvbSt2R2NvczRl?=
 =?utf-8?B?cFluQzlibGN4UDU5VVN0cWxFcWNqNFJHZGUyUklQOUY3RHdtOHVzUHhHVjRN?=
 =?utf-8?B?NXFIN3dwelU5TWlYK2hXUjhHQ2xGSitSMHNtMzUyVDRPNEY5RXNMNEJqeEw0?=
 =?utf-8?B?MXh2U0lKbnY3UUlDcG1NYWRPVzdwazJhZ0E1eFlySnpDYWJ1NDUzdFdGR3Vy?=
 =?utf-8?B?R1JZaWEzcGVXb3EvYXhiaktLSFZvSGxLcjFvbTFKc1BXb2ZvcE41cSt5ekta?=
 =?utf-8?B?c2JONG9ubC9GV1dIdXN6RFFSemxVVk9ZSG1aNWR3czRxWEY5cHkxazdHQ3py?=
 =?utf-8?B?SmkxMGQzSWhVOHgrZHlDVEpMY0tGUksyR3JTL0FzRzVSVnVEbURRK2tlalpR?=
 =?utf-8?B?MWp4VHV6OU54L0F2dlZlRU1xZ2lCb1pPQ01IbHk3endoMHhpTy9Ecnk4Q0tz?=
 =?utf-8?B?RVJPRkZlaGdFUjRmNGVLZFd4ek1XdjhzU28vclVEUGFpN2FPeFg2eTRqbFMz?=
 =?utf-8?B?aURkaWJNZ3lPWk9zbytYQXV1YWJCRWJCMnlQL1NkMUExNjhQWWlWeUlrQ2Mr?=
 =?utf-8?B?WkVuSEpKTHkrRHZyNkhCdVhKdUExT1cvWGd0M2U1YURITVdPTGxCbVFBd2tO?=
 =?utf-8?B?aDVRQW9BQjJWcTgxRnNITzk1OFAyUjRyMVZuQzc5OHpudWpyTGpkdmhmZGRV?=
 =?utf-8?B?b0JNMHhuMDV2U1JkUi8rSVBhTW84YVJMYnNjYTVhTzVFcnkyQXNqY0VkSW96?=
 =?utf-8?B?ZnJ0b21zZjhnQVI1Q2JCR1oyWmRvTUhjcG5nZkt3VXJrRG1NZmNuQXNtWVVq?=
 =?utf-8?B?c3pZd09BTkNYUUQxUWtzQVViQlowK1hSeGo2T0ZUakxDYUo0MTE3cGU4Vmpq?=
 =?utf-8?B?c21wenh3c1BHck12UzNIWkg5STZQQUdPQmhmbGFYbGpUb0hnL1BJWnB5dGNy?=
 =?utf-8?B?WnQ1VzZMcEFKU1dKNzByNUJ5aTVGV21LWnMvWFZ0Nm5CWEV4Q20wRjNPeC9S?=
 =?utf-8?B?NENnVU8xTmk5Y3A0OTdqMzVoMEQxVzZVNzRrMWh5RUpZWjRiVHM0dVlPdVlU?=
 =?utf-8?B?SzZ3TDdTQ3JpbkFaTW5TS3lXdThNSFpWeWswcUdWUnRVQTA4NW11YklTLzIr?=
 =?utf-8?B?dGZEbFAwb0NkZ0paclRjTkpZYmZvanVzc211ZWUwSkJ1TEt2TmdZME1vZGZ3?=
 =?utf-8?B?NWsvdExkaCtZc1ZFTzVSdkRQZjk0dTJMVjZrYm8wVGNTWFRzTzAxR0JBOFhx?=
 =?utf-8?B?eklPTjlzRnc0cnp4dUhPb0R6YWNZaENuR29ZbVNmZDNzZ3JYNEgrODZMRFR2?=
 =?utf-8?B?dUo3RUUrQVN0QkhlZ09tOVAxVFBoYWV6cWFNZmZPMkdEdzFOZUFrZTliUUlC?=
 =?utf-8?B?bXk1bnhtOXpleGZZRzRWOE5EZGx0VWFJWFZkcllidjJKd0FoZ3pHMnY3eDFF?=
 =?utf-8?B?cEh0MHRLK0Q1WnptOE1DTFNONStBVnVwRmJvUlNpWTZjY0hESGN0Q1l5cmlt?=
 =?utf-8?B?ZDZMSlpGc1FqbU5LdmpzbW1DRmxwNnVVOTZ0SUJhcVkyQzAxSG5Ta0dWcGcz?=
 =?utf-8?Q?M/yrR7tsGaIYu62zCO?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0F8DD7C465B2B64E9136DE248EE4A456@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 34b45ca4-88e7-405d-d4b5-08da176819c9
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 00:55:10.1948
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: U3kmExPAvMeEB5vo+iZDLlb4z8ic+8Y8oRev7xj704ezNSCQd+UcwOVGUwZB7bVWW2XETImWOx5GD8Qjenty3A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR10MB2452
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-05_08:2022-04-04,2022-04-05 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 mlxlogscore=999 phishscore=0 spamscore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204060001
X-Proofpoint-ORIG-GUID: GC8IyIznSW0DE8yaowhGz7_q4YUj_6kX
X-Proofpoint-GUID: GC8IyIznSW0DE8yaowhGz7_q4YUj_6kX
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMy8zMC8yMDIyIDk6MTggQU0sIERhcnJpY2sgSi4gV29uZyB3cm90ZToNCj4gT24gV2VkLCBN
YXIgMzAsIDIwMjIgYXQgMDg6NDk6MjlBTSAtMDcwMCwgQ2hyaXN0b3BoIEhlbGx3aWcgd3JvdGU6
DQo+PiBPbiBXZWQsIE1hciAzMCwgMjAyMiBhdCAwNjo1ODoyMVBNICswODAwLCBTaGl5YW5nIFJ1
YW4gd3JvdGU6DQo+Pj4gQXMgdGhlIGNvZGUgSSBwYXN0ZWQgYmVmb3JlLCBwbWVtIGRyaXZlciB3
aWxsIHN1YnRyYWN0IGl0cyAtPmRhdGFfb2Zmc2V0LA0KPj4+IHdoaWNoIGlzIGJ5dGUtYmFzZWQu
IEFuZCB0aGUgZmlsZXN5c3RlbSB3aG8gaW1wbGVtZW50cyAtPm5vdGlmeV9mYWlsdXJlKCkNCj4+
PiB3aWxsIGNhbGN1bGF0ZSB0aGUgb2Zmc2V0IGluIHVuaXQgb2YgYnl0ZSBhZ2Fpbi4NCj4+Pg0K
Pj4+IFNvLCBsZWF2ZSBpdHMgZnVuY3Rpb24gc2lnbmF0dXJlIGJ5dGUtYmFzZWQsIHRvIGF2b2lk
IHJlcGVhdGVkIGNvbnZlcnNpb25zLg0KPj4NCj4+IEknbSBhY3R1YWxseSBmaW5lIGVpdGhlciB3
YXksIHNvIEknbGwgd2FpdCBmb3IgRGFuIHRvIGNvbW1lbnQuDQo+IA0KPiBGV0lXIEknZCBjb252
aW5jZWQgbXlzZWxmIHRoYXQgdGhlIHJlYXNvbiBmb3IgdXNpbmcgYnl0ZSB1bml0cyBpcyB0bw0K
PiBtYWtlIGl0IHBvc3NpYmxlIHRvIHJlZHVjZSB0aGUgcG1lbSBmYWlsdXJlIGJsYXN0IHJhZGl1
cyB0byBzdWJwYWdlDQo+IHVuaXRzLi4uIGJ1dCB0aGVuIEkndmUgYWxzbyBiZWVuIGRpc3RyYWN0
ZWQgZm9yIG1vbnRocy4gOi8NCj4gDQoNClllcywgdGhhbmtzIERhcnJpY2shICBJIHJlY2FsbCB0
aGF0Lg0KTWF5YmUganVzdCBhZGQgYSBjb21tZW50IGFib3V0IHdoeSBieXRlIHVuaXQgaXMgdXNl
ZD8NCg0KdGhhbmtzIQ0KLWphbmUNCg0KPiAtLUQNCg0K
