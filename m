Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFA43508DE1
	for <lists+linux-fsdevel@lfdr.de>; Wed, 20 Apr 2022 19:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380801AbiDTREh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 20 Apr 2022 13:04:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231803AbiDTREf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:04:35 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A6BB20BC9;
        Wed, 20 Apr 2022 10:01:48 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23KFGbnC024754;
        Wed, 20 Apr 2022 17:01:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=+5TIR2Y+G9qg1CCZB9+eD7IzIXqHL3ycaxgPfhdW1lM=;
 b=IJmbF0U8QaJbZ0MSBb9Lk1s2PpIfvZaNKL2GKfCor5o1/E3jyr0EW6SHESEJZojsj/fM
 z48fwDcA4D2+Fb9cawrgnK+8D9+r61ZV82t1Kw/N1dbRXgEM6foFCmuEVpoGTa7yRPLu
 af0lIHZVYZvp/F5xC7EG0x9GTZgzJtG9sE7+nrJ2EII6VpFhUB/JLvGVg8M5GOf22u/M
 1/6/OqKtUPjdOT7o9BpP6w/Hb7XJwE6B4+FS/kHrGOCkV5j3z6IASbva00rNgwIixJI8
 XcrOsYbK7LE35wECdS34bl4ZJTSf4LpMnV8t9BtViQHZVyoo5ZbpgZ2UVHWHzy+62WA1 6w== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ffnp9hfd5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 17:01:19 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23KH0iDA001476;
        Wed, 20 Apr 2022 17:01:18 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3ffm87thmq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 20 Apr 2022 17:01:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gv3olZj1Zwweu1SaoeuW3m0qIiKJhCe7vJL0oinCq07gH+Bgidj8NNr1EHTH9N3qrAycRc1UJe72Xs5g7qr0PKTbhWt2f9167UOP2Qu348siUCrjGMPecxJ19vl7wpV14s4dvMb1lbSCFkxiC/24W3FthDGJbUZVqC4eUxL3PBXOjj21y0m//T+beSISQ5LQxmwS4mPyBY682oK5KXAirsC2IY5afZdxx/G19oKr4VvLJCNS8hb6V/4V62iO9Z50Z9P499SsQcVjx9MTKZzaMoWuEwAO7zb/83KF6ZDvIgyohg40KgM91iFrE/yaypH3FdNyx8kntvQIDf2y8W26lA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+5TIR2Y+G9qg1CCZB9+eD7IzIXqHL3ycaxgPfhdW1lM=;
 b=asyBnWWLtgiFQ6wVMxlrxBNRg5AVFtZE54qKnyotSE1d3StoI5K7qGpdn5oebO4nPEEZLEWPDYZXtbdnhw2f0MELXt8Y7/cOvS9LXMZq7noaQD4v9ppv8km9ALVejvbGrnqACZgwE4nzv0y/xJ9JO7ras480wyGRMzatEr6bYOkwdt6r4AmcjGQ3OcG5aEVykj3Jw4A8HqKkG+gVURxx85jOZQ46fxAJr+DWQ7S9kQ3TGEjaNNKAVZfw3C/IWGuIoLc7w4jO1FCTzeSSQfFHr2ZHpKCkRGTPlfQecARFeTWDwou0vTCDrLDI1h8YaTK7j3XrACwDXIeI5PiGJ1wm8Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+5TIR2Y+G9qg1CCZB9+eD7IzIXqHL3ycaxgPfhdW1lM=;
 b=Zh+jD/cJB/iIaLRJu6bTziu+dkMxSrFrABHJOaxHodNFDWSMmhRyBYksNIK5kl0N9rxtGCx9IrHxx1Z9reHAGiHBfD00GuecqAcOzMifM9RTusxPyHQNj/0NVjJ6ccOWGkU4WCfW6n/1YNVmev9DbuxQBi9QK+uT9nrWiJCm7P4=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM5PR10MB1449.namprd10.prod.outlook.com (2603:10b6:3:11::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 17:01:15 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:01:15 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Dan Williams <dan.j.williams@intel.com>
CC:     Borislav Petkov <bp@alien8.de>,
        Christoph Hellwig <hch@infradead.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>, david <david@fromorbit.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NVDIMM <nvdimm@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>,
        Vishal L Verma <vishal.l.verma@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        device-mapper development <dm-devel@redhat.com>,
        "Weiny, Ira" <ira.weiny@intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vivek Goyal <vgoyal@redhat.com>
Subject: Re: [PATCH v8 7/7] pmem: implement pmem_recovery_write()
Thread-Topic: [PATCH v8 7/7] pmem: implement pmem_recovery_write()
Thread-Index: AQHYVFsWAZKeTRs39kii18Q/afzGwqz4Vm+AgACxWIA=
Date:   Wed, 20 Apr 2022 17:01:15 +0000
Message-ID: <d48f9641-30e3-f459-2376-386c28a69026@oracle.com>
References: <20220420020435.90326-1-jane.chu@oracle.com>
 <20220420020435.90326-8-jane.chu@oracle.com>
 <CAPcyv4gs2rEs71c6Lmtk1La2g3POhzBrppLvM0pkGxx+QZ3SbA@mail.gmail.com>
In-Reply-To: <CAPcyv4gs2rEs71c6Lmtk1La2g3POhzBrppLvM0pkGxx+QZ3SbA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b46f31b-33cc-40ed-b6e6-08da22ef61c0
x-ms-traffictypediagnostic: DM5PR10MB1449:EE_
x-microsoft-antispam-prvs: <DM5PR10MB14492279C619ECD4DCCCDD57F3F59@DM5PR10MB1449.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wXLUefivyfvapuo1wDpmghojRrKZ+80hxgolOAzeACGG/ip9s7CDRTeMCkjc1XgSc3fl2QYG4OLU7X1GJIUGjKR2UEMySRFVJIuzH2dwIwveXIzMCcYWYM6cqFXrokKXsDBVWDG5qq60P3kPfG27145j4GYXfHcq/ga8QA0UE68AkNgAxUqfwZN8yE7xKWcrAp41dRi2SAQRWrR/jGtKI6N2OAD1JKKkID/NgJVlfmKdTyc9xMEKbrRnHawDc8QGrw6SVilXpVAi03uJLeajr+bAicZAG2MUWjbg2LdFcOErJLiHDNdT+ED3vgeH9qoA5hQl0rFWHIPRsb3KvQRpfIwvOzA5CpyAvUp5ii4I786zZ1Hfsc8kouhe5mxElH1vHgEgy+VjqrL0F/5/Mj8iFJNLDuH6TDxpmUyDXhgC0B5usa1LJwGeDRZlpoYjNciZP/Jk8lwz1eHAShD0ecSSTcwSwMlbs3bzOKFuMj5EJcYRzkb4av0Vs1Zr4Klcivuk2NVw77BxFTUdU6+G10GaeeSVxRKe5fjPyJaLXRbs2y4r/6zCa22EySI28a1q3qtSrCEJ0qRha6rrJgYPBDzZjW7D4BYblJeedOoxNFR9wC3r5/+JiSVYAXGEC6leTOL5esGWOc0xrE537QK/KyQGLJQOeXBf+K2Up10BZ+EFgU2TWUfWP/tun2OCqcF4ivvQfwoAKOoJNSmqZ8TVKK39ZQ4u+Cc+KDjovUvNq0qeSfjK0T+hMLoasZ732SpLK9iVjO7UrnPD3Ewqcul1PkrgZA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(8936002)(8676002)(26005)(66556008)(6512007)(6486002)(508600001)(71200400001)(6506007)(7416002)(44832011)(5660300002)(31686004)(53546011)(38070700005)(4326008)(83380400001)(54906003)(66946007)(86362001)(2616005)(38100700002)(76116006)(66446008)(122000001)(64756008)(66476007)(186003)(36756003)(6916009)(31696002)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WDZaTmRrYUZNNmNvODhrT25sTUdiR3kyZ1hwTmVkZ3hEeTEwRWovRVV5VHJw?=
 =?utf-8?B?cjhWUWtablVvT1pYVDBlWW8xckV5by92Vk1BMWZyMlZJMzI5dnF5TkNwSUts?=
 =?utf-8?B?VUROMHZvUmsxdXFTM3VJQnFQMHFXQzR3eEhJazhDK3plSWlXRnRyYU9tZC91?=
 =?utf-8?B?SThlRW95Znk5WXFBTlU3Q2lERjNlcHhxTklucXBmUHZ5eDU3S21IaXg1amtD?=
 =?utf-8?B?TTIzVVFYY3ZCeDdMMGVWYUdSYWQ3d2dWWjlxNXlIbS9Qa0NqLzhIVFN0RjM2?=
 =?utf-8?B?NXM5WURtdzI5YitaY0JtcWx2WDBRa0VBRDd2RTVSeXBESkcvQmtManF0UGl3?=
 =?utf-8?B?REJGRE1Cd2VVQkd2cHlKV09FOERuUWpJV3ZGcW5XdUpqWWNSRmR3UVRYRjZV?=
 =?utf-8?B?L3JvYy8xZHBGSVE4MkczN09uSXQ1M01zaDlHY05ZaUE3Yy94eW5xWFhoQTV6?=
 =?utf-8?B?ak9mY3Y1WERLRnExNXFyMEdDdllZSjAzTTZsWGl3VEZpM2lGL2FOcVlGcHBn?=
 =?utf-8?B?dUlqNkxaQ2N4REdDQXJkVngwcFN6Vnp6ZlJFOVZvR1dXYjIzVXlFNGgreDBW?=
 =?utf-8?B?L0Z4M2FYbE1UQnBrR3R4alFDVU5pZG9JV21BT25UdFhLdVNYalc4OHdVRU9p?=
 =?utf-8?B?Y1REOGd0cmkyVGtWUUZacG9ha0JlYmhMY3FSVW9LTk9GL2oxY0pvZmVGMWls?=
 =?utf-8?B?cHNiOWIvUzFIL1IrRHhwUnQ3ZlZOT0o2aGFVc2d6RDl5cGN3Q2hQQWJEVmlS?=
 =?utf-8?B?V1B6TjFrK2s4SkFOOW5zZEZBcDVwWjlNelZYOVpCQlc5bmxDdWdaZkV6S21S?=
 =?utf-8?B?ODJEZ0Rnbm9hc05XSFZjVzdmWk5OWTZNK3pWUTZTdzR2SDJjNFBuUm1rQVNB?=
 =?utf-8?B?aHNMTVVyMHo4NC8zYS9SVEZXd056dlJhODhMcElPYlJsTU1qRG9FYUg2Qmlv?=
 =?utf-8?B?SWdRZEhaSXEwdTFRUnl4VHgrZ3VVV1VPaU0xRDI2a1dKeWdWQXN2SXQ0YkhT?=
 =?utf-8?B?eHRpckUyWDhocHYyUnNNaEgzQmNqbmh0K3lzajltaWxsYmRFZFA5aVFjVDFR?=
 =?utf-8?B?WlkrMDZWQUZDeCtlMG5Manl1THJScWNheW1mcERma2NiLzU4T2FoTlVEYjFh?=
 =?utf-8?B?eW9lODJycWphQnNWOG8yb3drKzZwMXlNOXBTMXI4cmRvS09YdG5laXhSSFZ0?=
 =?utf-8?B?TXU0eVFXM3ZOd0t0a2tWdzVkci9IdElpU1Y5cHdta2dRdzhBU0pZUkpFZWg1?=
 =?utf-8?B?Rm84eEk5cFRWL1Y5cW9VbGxpRWIyNy9iWThHM2hQZDFqWXp3TGU2TlpEdlJY?=
 =?utf-8?B?QW1xMlh2NkgxU3RWNzg5dmZIRTZveCtmSFMweUljYlM2Y1Z5TkJXY1lwaEg5?=
 =?utf-8?B?SkxPVDBXN09aK2dlZUJqb3l2N1RCa1RjSWlSUzVGYXhrTXQxSGN6a29RRzJo?=
 =?utf-8?B?MUJZTThtMUtzMjRialVGTGtaVHdpZ1FIczZtMnFoZWh0Q3NJR2FreEdLUEVk?=
 =?utf-8?B?YXEwK28xWGhMUGVENWxZRXNUWm1kTXdVRFREaEQ3QktaOTU4aUFLek8yS0Nn?=
 =?utf-8?B?LzNta0h3UnJHUDBNZHlESUdzcjlJUGZ6RjloeUdIbUFFdkF0Snd5UkRxZ01K?=
 =?utf-8?B?VENwUHNuc1M4SkNxcFMzQlpoL1grOEYreGYyVHJqQ3p6bWNRdXFyeEJwaGIr?=
 =?utf-8?B?eWF5TWRxMyszYzkvQ2Q0STlQRUpjcktEVDNWSWtFQVZhZUs2bDhpMXllYVJJ?=
 =?utf-8?B?ZTlkOUsvckxENlpxT0txck9wQ0FHOXQ1cnBYZjNnWFdaUkREbWhJVGFlNDcr?=
 =?utf-8?B?MHdWRTBPNUJVU2FWZ2Z0aVA3ZDhHM0MrbkE3S2JjRHI0M3ZuMDVYSnRkSmFj?=
 =?utf-8?B?NG9KaEVIUmJyQmJCdzg4b0hVVDdaaFVZVm1yQ081VldXQkFSUnBwUmVmR2xU?=
 =?utf-8?B?TmM1OUZnWmJvTXlJMWE1QWJYZ2Z2d0dYSkVEUEV5TTk2SGt5cG1oOE5mcEkr?=
 =?utf-8?B?RmU5Z212UTBVaForajhXRjFHMUEyV29vRnRYVXJNWldobnV2MmNJSGJDaFQ4?=
 =?utf-8?B?eWkwTUpoM01OMlFpKytMaTJQeEZZaEpwb1NablY1cDlTOU8xV2Z3WHl2MFQw?=
 =?utf-8?B?OGgvZisxaDJHZU1vaVAwQW1uZlhObk54cGlFM1RQME9RSWVHcEdWdFhBRG9R?=
 =?utf-8?B?d3NyNVdpZVNEVnN5SGROeWNkU3BkSk1jYkF4Wk5vL1dPcDFkV3dYVlFrcTZn?=
 =?utf-8?B?cmU1aUN5V0hoRGZWK2xFa25TU1NBV3N6YThWRGFIRFNwMllWbmNIMHozNVhH?=
 =?utf-8?Q?LGvsBK6B/r6LgTqHX2?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <1C3675DD9B85124BB65409D954E2533D@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b46f31b-33cc-40ed-b6e6-08da22ef61c0
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 17:01:15.7956
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: RmZDuNl7dHpknNpLPiGuHzTORROm03UgKZxn9kBSEOEz0H0gY2TsVc7O0obSQYOsOmN4tZ5PC8WElwK2qPqHvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1449
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-20_05:2022-04-20,2022-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200101
X-Proofpoint-ORIG-GUID: axAxM4DSqQ34Hu1wgtw90YIdC7Etb7CI
X-Proofpoint-GUID: axAxM4DSqQ34Hu1wgtw90YIdC7Etb7CI
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xOS8yMDIyIDExOjI2IFBNLCBEYW4gV2lsbGlhbXMgd3JvdGU6DQo+IE9uIFR1ZSwgQXBy
IDE5LCAyMDIyIGF0IDc6MDYgUE0gSmFuZSBDaHUgPGphbmUuY2h1QG9yYWNsZS5jb20+IHdyb3Rl
Og0KPj4NCj4+IFRoZSByZWNvdmVyeSB3cml0ZSB0aHJlYWQgc3RhcnRlZCBvdXQgYXMgYSBub3Jt
YWwgcHdyaXRlIHRocmVhZCBhbmQNCj4+IHdoZW4gdGhlIGZpbGVzeXN0ZW0gd2FzIHRvbGQgYWJv
dXQgcG90ZW50aWFsIG1lZGlhIGVycm9yIGluIHRoZQ0KPj4gcmFuZ2UsIGZpbGVzeXN0ZW0gdHVy
bnMgdGhlIG5vcm1hbCBwd3JpdGUgdG8gYSBkYXhfcmVjb3Zlcnlfd3JpdGUuDQo+Pg0KPj4gVGhl
IHJlY292ZXJ5IHdyaXRlIGNvbnNpc3RzIG9mIGNsZWFyaW5nIG1lZGlhIHBvaXNvbiwgY2xlYXJp
bmcgcGFnZQ0KPj4gSFdQb2lzb24gYml0LCByZWVuYWJsZSBwYWdlLXdpZGUgcmVhZC13cml0ZSBw
ZXJtaXNzaW9uLCBmbHVzaCB0aGUNCj4+IGNhY2hlcyBhbmQgZmluYWxseSB3cml0ZS4gIEEgY29t
cGV0aW5nIHByZWFkIHRocmVhZCB3aWxsIGJlIGhlbGQNCj4+IG9mZiBkdXJpbmcgdGhlIHJlY292
ZXJ5IHByb2Nlc3Mgc2luY2UgZGF0YSByZWFkIGJhY2sgbWlnaHQgbm90IGJlDQo+PiB2YWxpZCwg
YW5kIHRoaXMgaXMgYWNoaWV2ZWQgYnkgY2xlYXJpbmcgdGhlIGJhZGJsb2NrIHJlY29yZHMgYWZ0
ZXINCj4+IHRoZSByZWNvdmVyeSB3cml0ZSBpcyBjb21wbGV0ZS4gQ29tcGV0aW5nIHJlY292ZXJ5
IHdyaXRlIHRocmVhZHMNCj4+IGFyZSBzZXJpYWxpemVkIGJ5IHBtZW0gZGV2aWNlIGxldmVsIC5y
ZWNvdmVyeV9sb2NrLg0KPj4NCj4+IFNpZ25lZC1vZmYtYnk6IEphbmUgQ2h1IDxqYW5lLmNodUBv
cmFjbGUuY29tPg0KPj4gLS0tDQo+PiAgIGRyaXZlcnMvbnZkaW1tL3BtZW0uYyB8IDU2ICsrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4+ICAgZHJpdmVycy9udmRp
bW0vcG1lbS5oIHwgIDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKyks
IDEgZGVsZXRpb24oLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9udmRpbW0vcG1lbS5j
IGIvZHJpdmVycy9udmRpbW0vcG1lbS5jDQo+PiBpbmRleCBjMzc3MjMwNGQ0MTcuLjEzNGY4OTA5
ZWI2NSAxMDA2NDQNCj4+IC0tLSBhL2RyaXZlcnMvbnZkaW1tL3BtZW0uYw0KPj4gKysrIGIvZHJp
dmVycy9udmRpbW0vcG1lbS5jDQo+PiBAQCAtMzMyLDEwICszMzIsNjMgQEAgc3RhdGljIGxvbmcg
cG1lbV9kYXhfZGlyZWN0X2FjY2VzcyhzdHJ1Y3QgZGF4X2RldmljZSAqZGF4X2RldiwNCj4+ICAg
ICAgICAgIHJldHVybiBfX3BtZW1fZGlyZWN0X2FjY2VzcyhwbWVtLCBwZ29mZiwgbnJfcGFnZXMs
IG1vZGUsIGthZGRyLCBwZm4pOw0KPj4gICB9DQo+Pg0KPj4gKy8qDQo+PiArICogVGhlIHJlY292
ZXJ5IHdyaXRlIHRocmVhZCBzdGFydGVkIG91dCBhcyBhIG5vcm1hbCBwd3JpdGUgdGhyZWFkIGFu
ZA0KPj4gKyAqIHdoZW4gdGhlIGZpbGVzeXN0ZW0gd2FzIHRvbGQgYWJvdXQgcG90ZW50aWFsIG1l
ZGlhIGVycm9yIGluIHRoZQ0KPj4gKyAqIHJhbmdlLCBmaWxlc3lzdGVtIHR1cm5zIHRoZSBub3Jt
YWwgcHdyaXRlIHRvIGEgZGF4X3JlY292ZXJ5X3dyaXRlLg0KPj4gKyAqDQo+PiArICogVGhlIHJl
Y292ZXJ5IHdyaXRlIGNvbnNpc3RzIG9mIGNsZWFyaW5nIG1lZGlhIHBvaXNvbiwgY2xlYXJpbmcg
cGFnZQ0KPj4gKyAqIEhXUG9pc29uIGJpdCwgcmVlbmFibGUgcGFnZS13aWRlIHJlYWQtd3JpdGUg
cGVybWlzc2lvbiwgZmx1c2ggdGhlDQo+PiArICogY2FjaGVzIGFuZCBmaW5hbGx5IHdyaXRlLiAg
QSBjb21wZXRpbmcgcHJlYWQgdGhyZWFkIHdpbGwgYmUgaGVsZA0KPj4gKyAqIG9mZiBkdXJpbmcg
dGhlIHJlY292ZXJ5IHByb2Nlc3Mgc2luY2UgZGF0YSByZWFkIGJhY2sgbWlnaHQgbm90IGJlDQo+
PiArICogdmFsaWQsIGFuZCB0aGlzIGlzIGFjaGlldmVkIGJ5IGNsZWFyaW5nIHRoZSBiYWRibG9j
ayByZWNvcmRzIGFmdGVyDQo+PiArICogdGhlIHJlY292ZXJ5IHdyaXRlIGlzIGNvbXBsZXRlLiBD
b21wZXRpbmcgcmVjb3Zlcnkgd3JpdGUgdGhyZWFkcw0KPj4gKyAqIGFyZSBzZXJpYWxpemVkIGJ5
IHBtZW0gZGV2aWNlIGxldmVsIC5yZWNvdmVyeV9sb2NrLg0KPj4gKyAqLw0KPj4gICBzdGF0aWMg
c2l6ZV90IHBtZW1fcmVjb3Zlcnlfd3JpdGUoc3RydWN0IGRheF9kZXZpY2UgKmRheF9kZXYsIHBn
b2ZmX3QgcGdvZmYsDQo+PiAgICAgICAgICAgICAgICAgIHZvaWQgKmFkZHIsIHNpemVfdCBieXRl
cywgc3RydWN0IGlvdl9pdGVyICppKQ0KPj4gICB7DQo+PiAtICAgICAgIHJldHVybiAwOw0KPj4g
KyAgICAgICBzdHJ1Y3QgcG1lbV9kZXZpY2UgKnBtZW0gPSBkYXhfZ2V0X3ByaXZhdGUoZGF4X2Rl
dik7DQo+PiArICAgICAgIHNpemVfdCBvbGVuLCBsZW4sIG9mZjsNCj4+ICsgICAgICAgcGh5c19h
ZGRyX3QgcG1lbV9vZmY7DQo+PiArICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldiA9IHBtZW0tPmJi
LmRldjsNCj4+ICsgICAgICAgbG9uZyBjbGVhcmVkOw0KPj4gKw0KPj4gKyAgICAgICBvZmYgPSBv
ZmZzZXRfaW5fcGFnZShhZGRyKTsNCj4+ICsgICAgICAgbGVuID0gUEZOX1BIWVMoUEZOX1VQKG9m
ZiArIGJ5dGVzKSk7DQo+PiArICAgICAgIGlmICghaXNfYmFkX3BtZW0oJnBtZW0tPmJiLCBQRk5f
UEhZUyhwZ29mZikgPj4gU0VDVE9SX1NISUZULCBsZW4pKQ0KPj4gKyAgICAgICAgICAgICAgIHJl
dHVybiBfY29weV9mcm9tX2l0ZXJfZmx1c2hjYWNoZShhZGRyLCBieXRlcywgaSk7DQo+PiArDQo+
PiArICAgICAgIC8qDQo+PiArICAgICAgICAqIE5vdCBwYWdlLWFsaWduZWQgcmFuZ2UgY2Fubm90
IGJlIHJlY292ZXJlZC4gVGhpcyBzaG91bGQgbm90DQo+PiArICAgICAgICAqIGhhcHBlbiB1bmxl
c3Mgc29tZXRoaW5nIGVsc2Ugd2VudCB3cm9uZy4NCj4+ICsgICAgICAgICovDQo+PiArICAgICAg
IGlmIChvZmYgfHwgIVBBR0VfQUxJR05FRChieXRlcykpIHsNCj4+ICsgICAgICAgICAgICAgICBk
ZXZfd2FybihkZXYsICJGb3VuZCBwb2lzb24sIGJ1dCBhZGRyKCVwKSBvciBieXRlcyglI2x4KSBu
b3QgcGFnZSBhbGlnbmVkXG4iLA0KPj4gKyAgICAgICAgICAgICAgICAgICAgICAgYWRkciwgYnl0
ZXMpOw0KPiANCj4gSWYgdGhpcyB3YXJuIHN0YXlzOg0KPiANCj4gcy9kZXZfd2Fybi9kZXZfd2Fy
bl9yYXRlbGltaXRlZC8NCj4gDQo+IFRoZSBrZXJuZWwgcHJpbnRzIGhhc2hlZCBhZGRyZXNzZXMg
Zm9yICVwLCBzbyBJJ20gbm90IHN1cmUgcHJpbnRpbmcNCj4gQGFkZHIgaXMgdXNlZnVsIG9yIEBi
eXRlcyBiZWNhdXNlIHRoZXJlIGlzIG5vdGhpbmcgYWN0aW9uYWJsZSB0aGF0IGNhbg0KPiBiZSBk
b25lIHdpdGggdGhhdCBpbmZvcm1hdGlvbiBpbiB0aGUgbG9nLiBAcGdvZmYgaXMgcHJvYmFibHkg
dGhlIG9ubHkNCj4gdmFyaWFibGUgd29ydGggcHJpbnRpbmcgKGFmdGVyIGNvbnZlcnRpbmcgdG8g
Ynl0ZXMgb3Igc2VjdG9ycykgYXMgdGhhdA0KPiBtaWdodCBiZSBhYmxlIHRvIGJlIHJldmVyc2Ug
bWFwcGVkIGJhY2sgdG8gdGhlIGltcGFjdGVkIGRhdGEuDQoNClRoZSBpbnRlbnRpb24gd2l0aCBw
cmludGluZyBAYWRkciBhbmQgQGJ5dGVzIGlzIHRvIHNob3cgdGhlIA0KbWlzLWFsaWdubWVudC4g
SW4gdGhlIHBhc3Qgd2hlbiBVQy0gd2FzIHNldCBvbiBwb2lzb25lZCBkYXggcGFnZSwgDQpyZXR1
cm5pbmcgbGVzcyB0aGFuIGEgcGFnZSBiZWluZyB3cml0dGVuIHdvdWxkIGNhdXNlIGRheF9pb21h
cF9pdGVyIHRvIA0KcHJvZHVjZSBuZXh0IGl0ZXJhdGlvbiB3aXRoIEBhZGRyIGFuZCBAYnl0ZXMg
bm90LXBhZ2UtYWxpZ25lZC4gIEFsdGhvdWdoIA0KVUMtIGRvZXNuJ3QgYXBwbHkgaGVyZSwgSSB0
aG91Z2h0IGl0IG1pZ2h0IHN0aWxsIGJlIHdvcnRoIHdoaWxlIHRvIHdhdGNoIA0KZm9yIHNpbWls
YXIgc2NlbmFyaW8uICBBbHNvIHRoYXQncyB3aHkgQHBnb2ZmIGlzbid0IGhlbHBmdWwuDQoNCkhv
dyBhYm91dCBzL2Rldl93YXJuL2Rldl9kYmcvID8NCg0KPiANCj4+ICsgICAgICAgICAgICAgICBy
ZXR1cm4gMDsNCj4+ICsgICAgICAgfQ0KPj4gKw0KPj4gKyAgICAgICBtdXRleF9sb2NrKCZwbWVt
LT5yZWNvdmVyeV9sb2NrKTsNCj4+ICsgICAgICAgcG1lbV9vZmYgPSBQRk5fUEhZUyhwZ29mZikg
KyBwbWVtLT5kYXRhX29mZnNldDsNCj4+ICsgICAgICAgY2xlYXJlZCA9IF9fcG1lbV9jbGVhcl9w
b2lzb24ocG1lbSwgcG1lbV9vZmYsIGxlbik7DQo+PiArICAgICAgIGlmIChjbGVhcmVkID4gMCAm
JiBjbGVhcmVkIDwgbGVuKSB7DQo+PiArICAgICAgICAgICAgICAgZGV2X3dhcm4oZGV2LCAicG9p
c29uIGNsZWFyZWQgb25seSAlbGQgb3V0IG9mICVsdSBieXRlc1xuIiwNCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIGNsZWFyZWQsIGxlbik7DQo+IA0KPiBUaGlzIGxvb2tzIGxpa2UgZGV2X2Ri
ZygpIHRvIG1lLCBvciBhdCBtaW5pbXVtIHRoZSBzYW1lDQo+IGRldl93YXJuX3JhdGVsaW1pdGVk
KCkgcHJpbnQgYXMgdGhlIG9uZSBhYm92ZSB0byBqdXN0IGluZGljYXRlIGEgd3JpdGUNCj4gdG8g
dGhlIGRldmljZSBhdCB0aGUgZ2l2ZW4gb2Zmc2V0IGZhaWxlZC4NCg0KV2lsbCBzL2Rldl93YXJu
L2Rldl9kYmcvDQoNCj4gDQo+PiArICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwbWVtLT5y
ZWNvdmVyeV9sb2NrKTsNCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsNCj4+ICsgICAgICAg
fQ0KPj4gKyAgICAgICBpZiAoY2xlYXJlZCA8IDApIHsNCj4+ICsgICAgICAgICAgICAgICBkZXZf
d2FybihkZXYsICJwb2lzb24gY2xlYXIgZmFpbGVkOiAlbGRcbiIsIGNsZWFyZWQpOw0KPiANCj4g
U2FtZSBmZWVkYmFjayBoZXJlLCB0aGVzZSBzaG91bGQgcHJvYmFibHkgYWxsIG1hcCB0byB0aGUg
aWRlbnRpY2FsDQo+IGVycm9yIGV4aXQgcmF0ZWxpbWl0ZWQgcHJpbnQuDQoNCldpbGwgcy9kZXZf
d2Fybi9kZXZfZGJnLw0KDQo+IA0KPj4gKyAgICAgICAgICAgICAgIG11dGV4X3VubG9jaygmcG1l
bS0+cmVjb3ZlcnlfbG9jayk7DQo+IA0KPiBJdCBvY2N1cnMgdG8gbWUgdGhhdCBhbGwgY2FsbGVy
cyBvZiB0aGlzIGFyZSBhcnJpdmluZyB0aHJvdWdoIHRoZQ0KPiBmc2RheCBpb21hcCBvcHMgYW5k
IGFsbCBvZiB0aGVzZSBjYWxsZXJzIHRha2UgYW4gZXhjbHVzaXZlIGxvY2sgdG8NCj4gcHJldmVu
dCBzaW11bHRhbmVvdXMgYWNjZXNzIHRvIHRoZSBpbm9kZS4gSWYgcmVjb3Zlcnlfd3JpdGUoKSBp
cyBvbmx5DQo+IHVzZWQgdGhyb3VnaCB0aGF0IHBhdGggdGhlbiB0aGlzIGxvY2sgaXMgcmVkdW5k
YW50LiBTaW11bHRhbmVvdXMgcmVhZHMNCj4gYXJlIHByb3RlY3RlZCBieSB0aGUgZmFjdCB0aGF0
IHRoZSBiYWRibG9ja3MgYXJlIGNsZWFyZWQgbGFzdC4gSSB0aGluaw0KPiB0aGlzIGNhbiB3YWl0
IHRvIGFkZCB0aGUgbG9jayB3aGVuIC8gaWYgYSBub24tZnNkYXggYWNjZXNzIHBhdGgNCj4gYXJy
aXZlcyBmb3IgZGF4X3JlY292ZXJ5X3dyaXRlKCksIGFuZCBldmVuIHRoZW4gaXQgc2hvdWxkIHBy
b2JhYmx5DQo+IGVuZm9yY2UgdGhlIHNpbmdsZSB3cml0ZXIgZXhjbHVzaW9uIGd1YXJhbnRlZSBv
ZiB0aGUgZnNkYXggcGF0aC4NCj4gDQoNCkluZGVlZCwgdGhlIGNhbGxlciBkYXhfaW9tYXBfcncg
aGFzIGFscmVhZHkgaGVsZCB0aGUgd3JpdGVyIGxvY2suDQoNCldpbGwgcmVtb3ZlIC5yZWNvdmVy
eV9sb2NrIGZvciBub3cuDQoNCkJUVywgaG93IGFyZSB0aGUgb3RoZXIgcGF0Y2hlcyBsb29rIHRv
IHlvdT8NCg0KVGhhbmtzIQ0KLWphbmUNCg0KPj4gKyAgICAgICAgICAgICAgIHJldHVybiAwOw0K
Pj4gKyAgICAgICB9DQo+PiArDQo+PiArICAgICAgIG9sZW4gPSBfY29weV9mcm9tX2l0ZXJfZmx1
c2hjYWNoZShhZGRyLCBieXRlcywgaSk7DQo+PiArICAgICAgIHBtZW1fY2xlYXJfYmIocG1lbSwg
dG9fc2VjdChwbWVtLCBwbWVtX29mZiksIGNsZWFyZWQgPj4gU0VDVE9SX1NISUZUKTsNCj4+ICsN
Cj4+ICsgICAgICAgbXV0ZXhfdW5sb2NrKCZwbWVtLT5yZWNvdmVyeV9sb2NrKTsNCj4+ICsgICAg
ICAgcmV0dXJuIG9sZW47DQo+PiAgIH0NCj4+DQo+PiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZGF4
X29wZXJhdGlvbnMgcG1lbV9kYXhfb3BzID0gew0KPj4gQEAgLTUyNSw2ICs1NzgsNyBAQCBzdGF0
aWMgaW50IHBtZW1fYXR0YWNoX2Rpc2soc3RydWN0IGRldmljZSAqZGV2LA0KPj4gICAgICAgICAg
aWYgKHJjKQ0KPj4gICAgICAgICAgICAgICAgICBnb3RvIG91dF9jbGVhbnVwX2RheDsNCj4+ICAg
ICAgICAgIGRheF93cml0ZV9jYWNoZShkYXhfZGV2LCBudmRpbW1faGFzX2NhY2hlKG5kX3JlZ2lv
bikpOw0KPj4gKyAgICAgICBtdXRleF9pbml0KCZwbWVtLT5yZWNvdmVyeV9sb2NrKTsNCj4+ICAg
ICAgICAgIHBtZW0tPmRheF9kZXYgPSBkYXhfZGV2Ow0KPj4NCj4+ICAgICAgICAgIHJjID0gZGV2
aWNlX2FkZF9kaXNrKGRldiwgZGlzaywgcG1lbV9hdHRyaWJ1dGVfZ3JvdXBzKTsNCj4+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL252ZGltbS9wbWVtLmggYi9kcml2ZXJzL252ZGltbS9wbWVtLmgNCj4+
IGluZGV4IDM5MmIwYjM4YWNiOS4uOTFlNDBmNWUzYzBlIDEwMDY0NA0KPj4gLS0tIGEvZHJpdmVy
cy9udmRpbW0vcG1lbS5oDQo+PiArKysgYi9kcml2ZXJzL252ZGltbS9wbWVtLmgNCj4+IEBAIC0y
Nyw2ICsyNyw3IEBAIHN0cnVjdCBwbWVtX2RldmljZSB7DQo+PiAgICAgICAgICBzdHJ1Y3QgZGF4
X2RldmljZSAgICAgICAqZGF4X2RldjsNCj4+ICAgICAgICAgIHN0cnVjdCBnZW5kaXNrICAgICAg
ICAgICpkaXNrOw0KPj4gICAgICAgICAgc3RydWN0IGRldl9wYWdlbWFwICAgICAgcGdtYXA7DQo+
PiArICAgICAgIHN0cnVjdCBtdXRleCAgICAgICAgICAgIHJlY292ZXJ5X2xvY2s7DQo+PiAgIH07
DQo+Pg0KPj4gICBsb25nIF9fcG1lbV9kaXJlY3RfYWNjZXNzKHN0cnVjdCBwbWVtX2RldmljZSAq
cG1lbSwgcGdvZmZfdCBwZ29mZiwNCj4+IC0tDQo+PiAyLjE4LjQNCj4+DQoNCg==
