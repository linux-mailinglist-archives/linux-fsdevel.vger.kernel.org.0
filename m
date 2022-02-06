Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C17924AAE68
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Feb 2022 09:25:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbiBFIZl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Feb 2022 03:25:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiBFIZk (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Feb 2022 03:25:40 -0500
X-Greylist: delayed 970 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 00:25:39 PST
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B692AC06173B;
        Sun,  6 Feb 2022 00:25:39 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2164impN009016;
        Sun, 6 Feb 2022 08:25:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=02BbJabkemmzTGgqhmF6imafQa8tMimdzFe/juYkvcQ=;
 b=absWCUxpzAew8u9KSE9krPCAlqx967tSWWlWJCobHwQuP0Fgbvr2QAys6ojum2Ohcezw
 MlfrzUiwxHzXCzjtOstMFqc5M6eGirlH2S5TNY9NsisOQxrsLwuXRahrWBXWZ9nhCojy
 rWuHrtt5omuUbxQglArWoyT3vU4farRAfsauYEkyZjUBq2rcwgiQB6Eo0hukOaJQybXk
 g9fKyA/4q29tOxdFKapQfry+bL9r2Gen+PqUl6J7Cp9F9yqxcQwqSp+IBQHdbpIROSG0
 D1Jw02N+jAiJlN2lSf6G9TZp/Dc512I535KKCyRqgDrqzEHF/8VbdOkmglrKrAX4F/nT WA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fu2juc6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:25:24 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2168BvYe131684;
        Sun, 6 Feb 2022 08:25:23 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2173.outbound.protection.outlook.com [104.47.58.173])
        by aserp3030.oracle.com with ESMTP id 3e1f9bs13w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 06 Feb 2022 08:25:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=elP4WBq8/TbG83j+OihM2avflkv5Kev2UWig7N1zKVfpErGtAh67BbwVGrEFfQeHPNyP39gLT2dhOsHaDfybrrF4IAcnbp8Pl5UNl4rktJQBBW8cJlZCwZqLM7oRAchcbjfkId0i31kTn+1CNbmsnxhGocF5OWhPbCk5GfSiPnU4C5QCK8vRspBL2D0L5Jhhu1jnFH7363PNM2+fmvwFYHROXkLRgh9hQOuOpDpDW8TH3sp3/od7RmjkXwIt/K39V1YIJrDXWKI5uFVo5l2464h5bFO3HYxYwcv2za//KVWHf0bL70z/+eqrz5qVZ+QbE5DXy4VFTqtrzzxCfRePQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=02BbJabkemmzTGgqhmF6imafQa8tMimdzFe/juYkvcQ=;
 b=BMiDVPSPp7wNKv1f1vCw8C3vL+F1xg06+Ex+K19j6U6rW818kMHJeDqPGdIf8YMQY4ZM6DFaGg9Kfe5e3+kJO78wO9ICln1yvE6pvD9brSUUsNtu5qoH7fVoG4cAUBTSbOgEOnjtdhUf9sLx+ZWYra7jGVsDrKKvvqsTuTqihTdae1/Ej+VzTfhN37+p5uFPfKj+ipHxqRERezUytoos0xAEh0Z0sf5BK5pJBP66Oa5vo3N1RaC2pNB+6kxQl4o/vVEHzzIksYGbrwGH6Dis4/rf0+hChSr30lE4NK5jaumVxcdiV16tQpWqhOqTDlZBe0bXBDHEZPH57cBmF8wHVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=02BbJabkemmzTGgqhmF6imafQa8tMimdzFe/juYkvcQ=;
 b=p8YZFKDmTKhfCeG5dkuT3cFbqen/znFvEWerTxq9RkHufxFeZ3eLdFo/zlucOCYS3lSJo+VGyGgPyrETIlCLaDdua21SVXLvfOlNoIu9KzBLUJbK+HJ3I6r6GSrBJ2q8c8YINqFOms4tuNZSi/8evlRF9FkztcDN8r4J/Wxo6Cg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by SN6PR10MB3023.namprd10.prod.outlook.com (2603:10b6:805:d2::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.18; Sun, 6 Feb
 2022 08:25:20 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::d034:a8db:9e32:acde%5]) with mapi id 15.20.4951.018; Sun, 6 Feb 2022
 08:25:20 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     david <david@fromorbit.com>, "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@infradead.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>
Subject: Re: [PATCH v5 4/7] dax: add dax_recovery_write to dax_op and dm
 target type
Thread-Topic: [PATCH v5 4/7] dax: add dax_recovery_write to dax_op and dm
 target type
Thread-Index: AQHYFI6LEOTCAew0QE2MfSX8Pkzm9KyC8McAgANMQoA=
Date:   Sun, 6 Feb 2022 08:25:20 +0000
Message-ID: <e14423a7-d2c6-06c3-fea2-bed1b1ad14e6@oracle.com>
References: <20220128213150.1333552-1-jane.chu@oracle.com>
 <20220128213150.1333552-5-jane.chu@oracle.com>
 <CAPcyv4hFyoHgX9mo=NwOj_FPnfD8zkg_svM1sJZLn41vBm4Z8w@mail.gmail.com>
In-Reply-To: <CAPcyv4hFyoHgX9mo=NwOj_FPnfD8zkg_svM1sJZLn41vBm4Z8w@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c63dd04-4318-4fd4-01b4-08d9e94a36bd
x-ms-traffictypediagnostic: SN6PR10MB3023:EE_
x-microsoft-antispam-prvs: <SN6PR10MB30239499159150C6AE9B08FEF32B9@SN6PR10MB3023.namprd10.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: m4kmuZaXP/WHUaWuFEiWgkPi5Un64u3+CwoppLzllBhLW0XikaBCBNP0OaEltqwbunURY2SprG5qQzq8t/PEWLWqfBdiYW9kpmwSExRZWBuZoTQOd1Qyohm0UP8+YDuHQXteMHBXGAhw3CbS5IiY7ovSEYSpcgpLXLE6Rgrp1vzwmWfd0TuctLaqN+96N8nnmKExnlibYRHl93cQ4IWY9CoVmEHxl1kMVUXXiQpYakmkTlT5qkZbfw5xmGRBbbpAYYeG5c9dPXRw+2bBWWtkQgV5R8kn9kQkh2Ab0bOsIHwOeLUBUKQs5D51E7nFwnkv6V0NV6sEY1421H17hdzqgENyXLfXsat2EdbZr+RkXvpZaF2lDPirXF+wHWuJUiDakMMRwQjOB7oGbgrjrnQ8Tkg/JfyupO9cnxRdg9FhimPT+zuTP9fyQCEcFSunoCaqmdf7cDDGZzVrIVIxM1uwbXC/O0eJtWbfGUv5Rs5xz7tx8wlRvLWD1VQHgUYH8uDZxss1Q//MoAnTjHww54os4UkrMDXqhGH3eQb5C1BzXAmjdhdHgdCVn5Jq5h8OXhCHrhfhUxJEh+A5+P6Gy/C40Nai78plYYCIjb1mgiWf1Fov1g9nS89WlFbkoI4WtciH0G5EXMrITirS7LUDMbTS5/6UVWJEBwz9YQidFkfqp2TzFylSGbWGOdDVmhozgYJdDeQVOYFcq5SOlJjkSonCUiUMSvuftTf9Otb7xV2Q4hz5j7gbdi/RKko2I82T3L9g0YmwfBr0uW5b6ua+ukXUzg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(86362001)(26005)(2906002)(508600001)(2616005)(54906003)(186003)(316002)(6916009)(38100700002)(5660300002)(38070700005)(122000001)(4326008)(6506007)(8676002)(66476007)(31696002)(64756008)(66446008)(66556008)(76116006)(44832011)(66946007)(8936002)(6512007)(53546011)(7416002)(31686004)(6486002)(36756003)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UkdUdlpQakpHSWl4RkJBNUVMajZGSk5aeGc4WFNpTXlPUWdNSkdiVnA4Q01E?=
 =?utf-8?B?L3VkdW50a01FcithRUJpNnZncnk4QURrdmtMczZpZTB6SjlNZEd0bDRjejBM?=
 =?utf-8?B?amdUbjVnOWFUUkVQa3ZZc0N3ZE9TclFpaVo2djl4cm14bGVGalhhbFdDK2RN?=
 =?utf-8?B?LzZ0azhaejdrZWpUR0Z5bGJqZkJ1bW92UE12SWxKcjRNQVhSSWF2S21mL0lo?=
 =?utf-8?B?MUZXNHZwaTNYMVJJNWRQTThVek5Nb0dmZEIxOWxTYTFERjBSWmlYcUVsOWxL?=
 =?utf-8?B?UzVJbVF3K3Y5TFhZaEdPSGpDMUo1NU9aTDhTRTZtU210K3hkWFRnOGhodXdN?=
 =?utf-8?B?R3dveUdqdHMwWHNheFNxVllzTXphemVzZWd0RXc0b3B5STRDdmZoTGRWYnRC?=
 =?utf-8?B?dE4vazNDeG9uS3lzZGozN2V1eXY4UXZXNTBRaVBRQ0FCcXdNcXdkd1JqcWtN?=
 =?utf-8?B?QU9QYmhrSFRXMDM0dGFPZGxHK0dDeThPYkVKeUgrSmhueDF4aStlamFyb2dF?=
 =?utf-8?B?V0xPcDNqU1NVTFYwcysvWXJsVFpqNzR1c0VlYWxFZjdBUDNSTEFjTE9kOWFM?=
 =?utf-8?B?NHFvMUpYUmMzT00wS3hRZkp5YjIwR1RJQVMvRmVoaGpXa3FxeGR4MUtxYnpw?=
 =?utf-8?B?ekpPK05LT3lMRFJjdzk3WnZvYWdCMXc1MDg4aGd2WTZxWkZXWVB2NEIySGtv?=
 =?utf-8?B?cHF5VDkxTnhCWDVvVVRpVGsydGNEMWJ6cDdUejJIZHVOek96YUlhOTR0Mkdw?=
 =?utf-8?B?QnNSdk9BMkZuZEFObDdSQVp2RXpmblQyV3BpdTN4dUhqdFBDaFBvTWd5YnRO?=
 =?utf-8?B?NGFYU0twakF1Wno1SGRTc3ZvOERQZXJubzhSTjB6V1U3alBnK1R4Y09iNmFE?=
 =?utf-8?B?OU5FYTNnOFpEY2d2anN6NFIva3I2Z0RUK3NidW9LYXU4WjY5c3JsNVBYVXow?=
 =?utf-8?B?SVJ2YUc0L3d0QmltVjhsSzVOYW5MK2VpaVdqNDJMazRvdDdHZjVNTlJjQlQw?=
 =?utf-8?B?NForZUlKRWpVeWRWVGN5aXh4Q3oyVjRvWDRCS2h3dXg5ZTJmVSthZlhualN3?=
 =?utf-8?B?Vjk4cFVaaXpUeUFVaFBGenV5cTJuUDlwaStWbzJKUWZwby9DWTRadmpuVVRq?=
 =?utf-8?B?QS9NaGExUldRYU16bWpWd051ZktQa1lOYkREMlh3RHFENGhGUWJCeVRKTklL?=
 =?utf-8?B?ZTBsSmttTDMwcXZSNk4wbzFLdGRjRXp1MFl6K3dQakV2Uzc5SGJ0WGZjdXRC?=
 =?utf-8?B?QnRVMGJVUWtDY2RZUGVqNlJMUjhtV3lTaCs0M3FNdFZjOWhpaFg4T2NCTVlQ?=
 =?utf-8?B?b3RsVnVDQmpKMVlKa25HNmdaWDRuR01DNVI1MnhVVlppSjZQM3R1d2MzRUZh?=
 =?utf-8?B?dENjTE1ONFZVVldoY1FKNEwxNlh1N28rRitJOGROM0YyUkpPUVlYY3dXc3RH?=
 =?utf-8?B?blRMeFJuaHpRTm0wNm5JdlArRnA1cmR0Z2k3SEw1MURvQWdVam5RQVlOUFJJ?=
 =?utf-8?B?YzVaWjlWczROUENDWXpJOTdEa3QzZnpkcVY0bWxBTm9yNUUvSHJaRUM1dzNR?=
 =?utf-8?B?ZVY1NkFtWFRUN01ROUVKSC9HeTViMHZRN1N1a2MxR3Y5cDhpWVFJa0cyZEFF?=
 =?utf-8?B?V3JLdXd4WnZCajM5NTZYN203bzZsUk1oZk9aTzRUV01TKzJYOWRYUy9lVHFO?=
 =?utf-8?B?WDNBWU9xSm52YkIrSC9iLzlkYzBWMDBkU0ZySXhBUVdPdVNudDd5dUl2dFlB?=
 =?utf-8?B?Q0pSN1ByVk4zSm9vNWtxSm1INkQ2a01iTGhraFc2amphRjBrUEFLZ3Q1N0M2?=
 =?utf-8?B?VFpnc3RpaGxoVzhLcUJ5VzNmWTIvV1lKZ1Z1ZmNxNGFJckVmTjE0ZTV5QzJX?=
 =?utf-8?B?REU5bWRpUC9NWmJpRUhvQk1PMWpsM2lzT3Z3cUh5UWRDRVJVMXpUbWJjS1E5?=
 =?utf-8?B?QnNMSXhIM2p1cWI0YnVPR2xqUGVGQ04rbk8weTdidFNQWEl3aVZyWEVsb3l5?=
 =?utf-8?B?UmUzczFleWd3SVNlY2tiSUZiSmtpbC9Hd1pwaGtDRGpZRmVtM1lmbzA5b2xI?=
 =?utf-8?B?WHQxYmVydHQ2QzRVSDQ4Z1F1ZHZJYWpvTUcraUJiWlNiRFRaa25PbnRZdVNK?=
 =?utf-8?B?Q1RRN3dUMmFXUitqOVI3a0ZucWY1RmNtSzNoa08zNUFhb1dGaTYzcEh3U2w1?=
 =?utf-8?B?a3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <64B088008BA96342963236BED03D9A0E@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c63dd04-4318-4fd4-01b4-08d9e94a36bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2022 08:25:20.3594
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Nlt7apsf45bNsbHz7v0bYht/2LSiUXv6ymLd0b2dzQsNBmVCPlAfSMzJOUbStzKBh9O5RIfTH5yRgTssTTD0Mw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB3023
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10249 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 mlxscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202060060
X-Proofpoint-ORIG-GUID: fhYGJugiiDgstLJsBtpgelt3g_j4zRPr
X-Proofpoint-GUID: fhYGJugiiDgstLJsBtpgelt3g_j4zRPr
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gMi8zLzIwMjIgMTA6MDMgUE0sIERhbiBXaWxsaWFtcyB3cm90ZToNCj4gT24gRnJpLCBKYW4g
MjgsIDIwMjIgYXQgMTozMiBQTSBKYW5lIENodSA8amFuZS5jaHVAb3JhY2xlLmNvbT4gd3JvdGU6
DQo+Pg0KPj4gZGF4X3JlY292ZXJ5X3dyaXRlKCkgZGF4IG9wIGlzIG9ubHkgcmVxdWlyZWQgZm9y
IERBWCBkZXZpY2UgdGhhdA0KPj4gZXhwb3J0IERBWERFVl9SRUNPVkVSWSBpbmRpY2F0aW5nIGl0
cyBjYXBhYmlsaXR5IHRvIHJlY292ZXIgZnJvbQ0KPj4gcG9pc29ucy4NCj4+DQo+PiBETSBtYXkg
YmUgbmVzdGVkLCBpZiBwYXJ0IG9mIHRoZSBiYXNlIGRheCBkZXZpY2VzIGZvcm1pbmcgYSBETQ0K
Pj4gZGV2aWNlIHN1cHBvcnQgZGF4IHJlY292ZXJ5LCB0aGUgRE0gZGV2aWNlIGlzIG1hcmtlZCB3
aXRoIHN1Y2gNCj4+IGNhcGFiaWxpdHkuDQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogSmFuZSBDaHUg
PGphbmUuY2h1QG9yYWNsZS5jb20+DQo+IFsuLl0NCj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L2RheC5oIGIvaW5jbHVkZS9saW51eC9kYXguaA0KPj4gaW5kZXggMmZjNzc2NjUzYzZlLi4x
YjNkNmViZjNlNDkgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L2RheC5oDQo+PiArKysg
Yi9pbmNsdWRlL2xpbnV4L2RheC5oDQo+PiBAQCAtMzAsNiArMzAsOSBAQCBzdHJ1Y3QgZGF4X29w
ZXJhdGlvbnMgew0KPj4gICAgICAgICAgICAgICAgICAgICAgICAgIHNlY3Rvcl90LCBzZWN0b3Jf
dCk7DQo+PiAgICAgICAgICAvKiB6ZXJvX3BhZ2VfcmFuZ2U6IHJlcXVpcmVkIG9wZXJhdGlvbi4g
WmVybyBwYWdlIHJhbmdlICAgKi8NCj4+ICAgICAgICAgIGludCAoKnplcm9fcGFnZV9yYW5nZSko
c3RydWN0IGRheF9kZXZpY2UgKiwgcGdvZmZfdCwgc2l6ZV90KTsNCj4+ICsgICAgICAgLyogcmVj
b3Zlcnlfd3JpdGU6IG9wdGlvbmFsIG9wZXJhdGlvbi4gKi8NCj4+ICsgICAgICAgc2l6ZV90ICgq
cmVjb3Zlcnlfd3JpdGUpKHN0cnVjdCBkYXhfZGV2aWNlICosIHBnb2ZmX3QsIHZvaWQgKiwgc2l6
ZV90LA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaW92X2l0ZXIg
Kik7DQo+IA0KPiBUaGUgcmVtb3ZhbCBvZiB0aGUgLT5jb3B5X3t0byxmcm9tfV9pdGVyKCkgb3Bl
cmF0aW9ucyBzZXQgdGhlDQo+IHByZWNlZGVudCB0aGF0IGRheCBvcHMgc2hvdWxkIG5vdCBiZSBu
ZWVkZWQgd2hlbiB0aGUgb3BlcmF0aW9uIGNhbiBiZQ0KPiBjYXJyaWVkIG91dCBnZW5lcmljYWxs
eS4gVGhlIG9ubHkgbmVlZCB0byBjYWxsIGJhY2sgdG8gdGhlIHBtZW0gZHJpdmVyDQo+IGlzIHNv
IHRoYXQgaXQgY2FuIGNhbGwgbnZkaW1tX2NsZWFyX3BvaXNvbigpLiBudmRpbW1fY2xlYXJfcG9p
c29uKCkgaW4NCj4gdHVybiBvbmx5IG5lZWRzIHRoZSAnc3RydWN0IGRldmljZScgaG9zdGluZyB0
aGUgcG1lbSBhbmQgdGhlIHBoeXNpY2FsDQo+IGFkZHJlc3MgdG8gYmUgY2xlYXJlZC4gVGhlIHBo
eXNpY2FsIGFkZHJlc3MgaXMgYWxyZWFkeSByZXR1cm5lZCBieQ0KPiBkYXhfZGlyZWN0X2FjY2Vz
cygpLiBUaGUgZGV2aWNlIGlzIHNvbWV0aGluZyB0aGF0IGNvdWxkIGJlIGFkZGVkIHRvDQo+IGRh
eF9kZXZpY2UsIGFuZCB0aGUgcGdtYXAgY291bGQgaG9zdCB0aGUgY2FsbGJhY2sgdGhhdCBwbWVt
IGZpbGxzIGluLg0KPiBTb21ldGhpbmcgbGlrZToNCj4gDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9udmRpbW0vcGZuX2RldnMuYyBiL2RyaXZlcnMvbnZkaW1tL3Bmbl9kZXZzLmMNCj4gaW5k
ZXggNThlZGExNmY1YzUzLi4zNjQ4NmJhNDc1M2EgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbnZk
aW1tL3Bmbl9kZXZzLmMNCj4gKysrIGIvZHJpdmVycy9udmRpbW0vcGZuX2RldnMuYw0KPiBAQCAt
Njk0LDYgKzY5NCw3IEBAIHN0YXRpYyBpbnQgX19udmRpbW1fc2V0dXBfcGZuKHN0cnVjdCBuZF9w
Zm4NCj4gKm5kX3Bmbiwgc3RydWN0IGRldl9wYWdlbWFwICpwZ21hcCkNCj4gICAgICAgICAgICAg
ICAgICAuZW5kID0gbnNpby0+cmVzLmVuZCAtIGVuZF90cnVuYywNCj4gICAgICAgICAgfTsNCj4g
ICAgICAgICAgcGdtYXAtPm5yX3JhbmdlID0gMTsNCj4gKyAgICAgICBwZ21hcC0+b3duZXIgPSAm
bmRfcGZuLT5kZXY7DQo+ICAgICAgICAgIGlmIChuZF9wZm4tPm1vZGUgPT0gUEZOX01PREVfUkFN
KSB7DQo+ICAgICAgICAgICAgICAgICAgaWYgKG9mZnNldCA8IHJlc2VydmUpDQo+ICAgICAgICAg
ICAgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZBTDsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
bnZkaW1tL3BtZW0uYyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBpbmRleCA1OGQ5NTI0MmE4
MzYuLjk1ZTFiNjMyNmY4OCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+
ICsrKyBiL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPiBAQCAtNDgxLDYgKzQ4MSw3IEBAIHN0YXRp
YyBpbnQgcG1lbV9hdHRhY2hfZGlzayhzdHJ1Y3QgZGV2aWNlICpkZXYsDQo+ICAgICAgICAgIH0N
Cj4gICAgICAgICAgc2V0X2RheF9ub2NhY2hlKGRheF9kZXYpOw0KPiAgICAgICAgICBzZXRfZGF4
X25vbWMoZGF4X2Rldik7DQo+ICsgICAgICAgc2V0X2RheF9wZ21hcChkYXhfZGV2LCAmcG1lbS0+
cGdtYXApOw0KPiAgICAgICAgICBpZiAoaXNfbnZkaW1tX3N5bmMobmRfcmVnaW9uKSkNCj4gICAg
ICAgICAgICAgICAgICBzZXRfZGF4X3N5bmNocm9ub3VzKGRheF9kZXYpOw0KPiAgICAgICAgICBy
YyA9IGRheF9hZGRfaG9zdChkYXhfZGV2LCBkaXNrKTsNCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
bGludXgvbWVtcmVtYXAuaCBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPiBpbmRleCAxZmFm
Y2MzOGFjYmEuLjhjYjU5YjVkZjM4YiAxMDA2NDQNCj4gLS0tIGEvaW5jbHVkZS9saW51eC9tZW1y
ZW1hcC5oDQo+ICsrKyBiL2luY2x1ZGUvbGludXgvbWVtcmVtYXAuaA0KPiBAQCAtODEsNiArODEs
MTEgQEAgc3RydWN0IGRldl9wYWdlbWFwX29wcyB7DQo+IA0KPiAgICNkZWZpbmUgUEdNQVBfQUxU
TUFQX1ZBTElEICAgICAoMSA8PCAwKQ0KPiANCj4gK3N0cnVjdCBkZXZfcGFnZW1hcF9vcGVyYXRp
b25zIHsNCj4gKyAgICAgICBzaXplX3QgKCpyZWNvdmVyeV93cml0ZSkoc3RydWN0IGRldl9wYWdl
bWFwICpwZ21hcCwgdm9pZCAqLCBzaXplX3QsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIHN0cnVjdCBpb3ZfaXRlciAqKTsNCj4gK307DQo+ICsNCj4gICAvKioNCj4gICAgKiBz
dHJ1Y3QgZGV2X3BhZ2VtYXAgLSBtZXRhZGF0YSBmb3IgWk9ORV9ERVZJQ0UgbWFwcGluZ3MNCj4g
ICAgKiBAYWx0bWFwOiBwcmUtYWxsb2NhdGVkL3Jlc2VydmVkIG1lbW9yeSBmb3Igdm1lbW1hcCBh
bGxvY2F0aW9ucw0KPiBAQCAtMTExLDEyICsxMTYsMTUgQEAgc3RydWN0IGRldl9wYWdlbWFwIHsN
Cj4gICAgICAgICAgY29uc3Qgc3RydWN0IGRldl9wYWdlbWFwX29wcyAqb3BzOw0KPiAgICAgICAg
ICB2b2lkICpvd25lcjsNCj4gICAgICAgICAgaW50IG5yX3JhbmdlOw0KPiArICAgICAgIHN0cnVj
dCBkZXZfcGFnZW1hcF9vcGVyYXRpb25zIG9wczsNCj4gICAgICAgICAgdW5pb24gew0KPiAgICAg
ICAgICAgICAgICAgIHN0cnVjdCByYW5nZSByYW5nZTsNCj4gICAgICAgICAgICAgICAgICBzdHJ1
Y3QgcmFuZ2UgcmFuZ2VzWzBdOw0KPiAgICAgICAgICB9Ow0KPiAgIH07DQo+IA0KPiAuLi50aGVu
IERNIGRvZXMgbm90IG5lZWQgdG8gYmUgaW52b2x2ZWQgaW4gdGhlIHJlY292ZXJ5IHBhdGgsIGZz
L2RheC5jDQo+IGp1c3QgZG9lcyBkYXhfZGlyZWN0X2FjY2VzcyguLi4sIERBWF9SRUNPVkVSWSwg
Li4uKSBhbmQgdGhlbiBsb29rcyB1cA0KPiB0aGUgcGdtYXAgdG8gZ2VuZXJpY2FsbHkgY29vcmRp
bmF0ZSB0aGUgcmVjb3Zlcnlfd3JpdGUoKS4gVGhlIHBtZW0NCj4gZHJpdmVyIHdvdWxkIGJlIHJl
c3BvbnNpYmxlIGZvciBzZXR0aW5nIHBnbWFwLT5yZWNvdmVyeV93cml0ZSgpIHRvIGENCj4gZnVu
Y3Rpb24gdGhhdCBjYWxscyBudmRpbW1fY2xlYXJfcG9pc29uKCkuDQo+IA0KPiBUaGlzIGFyY2gg
d29ya3MgZm9yIGFueXRoaW5nIHRoYXQgY2FuIGJlIGRlc2NyaWJlZCBieSBhIHBnbWFwLCBhbmQN
Cj4gc3VwcG9ydHMgZXJyb3IgY2xlYXJpbmcsIGl0IG5lZWQgbm90IGJlIGxpbWl0ZWQgdG8gdGhl
IHBtZW0gYmxvY2sNCj4gZHJpdmVyLg0KDQpUaGlzIGlzIGFuIGludGVyZXN0aW5nIGlkZWEsIGxl
dCBtZSBnaXZlIGl0IGEgdHJ5IGFuZCBnZXQgYmFjayB0byB5b3UuDQoNClRoYW5rcyENCi1qYW5l
DQoNCg==
