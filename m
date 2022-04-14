Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D579A501DCB
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 Apr 2022 23:55:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241057AbiDNV5J (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 Apr 2022 17:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239662AbiDNV5H (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 Apr 2022 17:57:07 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25BD7182;
        Thu, 14 Apr 2022 14:54:41 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23EJmfn7029058;
        Thu, 14 Apr 2022 21:54:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=We5iEGZYVdbG4QuGVQQBFMQ6iYHb3NKhg0mChqpN18Y=;
 b=mHIhWvzAgSSS2pLHpMeK+N0Esl8TaBMs/JyZ9NxYrJtbWprFEAU3b8HaYVbBMbhxlm2Q
 ho2+qohc6C0ToJcLLK5Wv4+1dLJzc8jiDKRsxp1zMJxXUWo7Mm+Iu2vCTiPHVyMzgbOf
 ZSFk8hGf6SCtWZCz2XNANcEILrtJr7ZoSUSSHaJlHc27noY8JmgDUMp+froquhIyxKQR
 eSOzuSLOZ15goNHJB3oP1XIGs4SkefI7nsP84/g07AFZWV/CZeNsePjZawWmdzcwZZW3
 VMVHDbAQVxkwZB50p1YptzjvOiOIO1g77zli/FCbv7PKsguUl8mOdqKb8owTtdanJTZG nw== 
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb1rse58m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 21:54:18 +0000
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23ELqUui000830;
        Thu, 14 Apr 2022 21:54:18 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2170.outbound.protection.outlook.com [104.47.55.170])
        by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3fck15ch1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Apr 2022 21:54:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fSpUiHjATAmbh8bSyHkiRMeDSBZkU7gFS83Fm8EP84FPzLoJeptsnuSZs87F4n/2d2W1LnISCtr/21iBesC94/R55r35+ddMFo5HnHSPUNcDAMx0J+p/sOQdTUrYxSXSe7nL6lL5lWBA9UPSfaMu6RSKQ0IiSPJqBi/XEHy3HdPfIU61VfkyVRMMUEbhtZYBG8FEZrUck1vIeTqiqe+JbQtXQXEYhZtSut7cu1x/Hm101fGoiavVyVyzW8tzq08W0T8+H7Dj3csjRwoBg59ej1JCYS56JEZlHgmWqLhAfiXlK4n/NI0tRzfjvfG0P5ia4Ndl7ERx+XrDna704NxruA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=We5iEGZYVdbG4QuGVQQBFMQ6iYHb3NKhg0mChqpN18Y=;
 b=C1cgCyl0KGu2jkv/SD+xFYSzXXL1lUi4gEF4sOi59usLyBKFarB0PMrp0u3IX5rcASAxL//QSHKcAs9dfyT94wwGoIekj1BNep70rmLk0ST3DwABDp5vv5pUeVvtrcfuxG7fYMYvz0Jh13ZJrt7PT4bViF6/VEkMgEZCkXiVM+pLo/Q4iHsW145xIsqtrQoLfI31b7UA3UI/LiXr0qQkNegLlAZ/5z7GPABR7V9gJHO1izrWjN7c3nvyYaTKowetPX0fihUKSlX4l2MAwlZfBwlfM5+zrsdYBG+ryHjL5c3zhmAyd8JQXJJ/uuxLbfVkvhi94Wsud/kwj3KEoD0T8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=We5iEGZYVdbG4QuGVQQBFMQ6iYHb3NKhg0mChqpN18Y=;
 b=kN7MuxmuvU5UrLvdC3WQW+3dkzCyDsEovr+szSqojWyKRu49sNsVsdJqas4kRZymDc7dV+Mi7dHxW0d/mHtkF7weGHYDmxcu05vVv1PjlvHKOUUfL1t/JGDFPfb9iW/NqL34hMq6F1/yKW+dbjfMe5TX69RccqJTNHwHShajkjg=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by DM6PR10MB2586.namprd10.prod.outlook.com (2603:10b6:5:b3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Thu, 14 Apr
 2022 21:54:16 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5144.029; Thu, 14 Apr 2022
 21:54:16 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Borislav Petkov <bp@alien8.de>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
        "hch@infradead.org" <hch@infradead.org>,
        "vishal.l.verma@intel.com" <vishal.l.verma@intel.com>,
        "dave.jiang@intel.com" <dave.jiang@intel.com>,
        "agk@redhat.com" <agk@redhat.com>,
        "snitzer@redhat.com" <snitzer@redhat.com>,
        "dm-devel@redhat.com" <dm-devel@redhat.com>,
        "ira.weiny@intel.com" <ira.weiny@intel.com>,
        "willy@infradead.org" <willy@infradead.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "nvdimm@lists.linux.dev" <nvdimm@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-xfs@vger.kernel.org" <linux-xfs@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: [PATCH v7 1/6] x86/mm: fix comment
Thread-Topic: [PATCH v7 1/6] x86/mm: fix comment
Thread-Index: AQHYSSYYGFAW2NTmbUWesvhenggRg6zsFCQAgAKPhICAAIHKgIAA3J+A
Date:   Thu, 14 Apr 2022 21:54:15 +0000
Message-ID: <8361114d-f543-9785-8359-66b3d8fbdc9d@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-2-jane.chu@oracle.com> <YlVMMmTbaTqipwM9@zn.tnic>
 <e0f40cd6-29fd-412d-061d-d52b489e282f@oracle.com> <Ylfe9eqCYvl0nSRC@zn.tnic>
In-Reply-To: <Ylfe9eqCYvl0nSRC@zn.tnic>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c8ff1eb-4614-42f4-8583-08da1e6151df
x-ms-traffictypediagnostic: DM6PR10MB2586:EE_
x-microsoft-antispam-prvs: <DM6PR10MB2586A8C29429EBD2DADF3D83F3EF9@DM6PR10MB2586.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uOJBd9RNYj57BJpDPHKffx2AS7UmVabQAPKYpWS1ueKQwllWHdb8JnLKgMRAgzCxalyJsNQJ8Xb+xlGDquNJ2zX7KeeeUS9meSbLy+AlQpgNpNATIGbvuKfuUynjKB2l00J+cDCzOimAhMH9AYbKQjDGsD/hO787U4DPX4w07qpLC17WI0NGN7MFM/OBcgoCf4nJQMky14b7hjzHmeS4Qo3LpYdKtOLRnoYhoaMSym50C+cTJGceedV4I2ZcVp11K0lD9WcjckZIhxkwLF27D9W0hS/edrdb/jigZ3eHHAA2NMOcJCKHxDywO5DSGRiVdpE5G5AYLHScdQSlEKSLGWgGI53SczlgXVJeZyvuJ9vDQPwOhHevcnxHL/G68yJ8abyqCqMicniCRK5+nKzHZMhnhCVgIdAiudrDg63jSwE/JyDWuoIcx4O1NZesGtT4CkfOU72W3LlAvXYBv5KEwezAuCBpbd9ghyGe3iH2bOvMhiX6gDuoi6Qc1JDdea+A4vuKTLyGMkO82F8rzrdJsjySfBeDeKndSYkyDth6v+koiyqfR0gIrB0FfED2u9zJj+iHxon4qJcTjPeVugCTVAAYJtnXGaqSI0IT0hJU5cLohnmjFQ+swduYXLYOS8gz4RGuZUX4jJDOvttcs+Ay/Ap5evM3Yhtf9i8ChQ9ujKWlouumayOsb4vHWMNQ3twxC1B3Emszr7XR4hdN5IPF7PFaWguUCrr2N02BkfxgWVY7lcir5HDqTXksMrThEfmLL0tETvS5lMVyC+rnAUukXg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(64756008)(2906002)(76116006)(6486002)(66556008)(66946007)(186003)(8676002)(4744005)(31696002)(5660300002)(83380400001)(4326008)(44832011)(7416002)(8936002)(66476007)(2616005)(6506007)(53546011)(316002)(86362001)(31686004)(54906003)(66446008)(6916009)(71200400001)(36756003)(122000001)(38100700002)(38070700005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VkowczJKQkNMVlhzSUN3Z2VMcGtGWDAzbk9WT1RkU2hPWjhXczQrMzUwUjJ2?=
 =?utf-8?B?TlBuM0ZzTnFkcGtvTzJjSmppWDUzaWc2RGM3NklTWXlZM2VHb25OQUxiZVF6?=
 =?utf-8?B?UnlGRTAxREM1TVdQWThpaEVwRy9KMGdKUEhRVnlrR21nUHhhd1RyRWVxZ0FX?=
 =?utf-8?B?YWtpVnRmWVFDeGtqRzVLSmJnK2FlRzRNam1NWnJraytjNndST1djbGZCMzRT?=
 =?utf-8?B?Vlg0R0FycWplSFAydkx4RFVqYlp3UWlKdW15Qm0vTlhkdVpNSlU4eDQ3bzBh?=
 =?utf-8?B?b09JY0tIcnBmR1kxd0tBTzE1ektBZHMzZXV6V1VTalhRSWZySXpac1E0U2wr?=
 =?utf-8?B?dVZuQzJyQWg1blNueXE2d0tvcXlsaXJMUXpIaUpUaHR5TzROUkJHYnRzS0po?=
 =?utf-8?B?L1pwREhpL0dod0N0TU9qaUlmSnR1a0Y1b1NSUENoTFZwQzY5TitPK29nKzls?=
 =?utf-8?B?OXFFaGF1bXZUUkJ0b0pka0pPNlcwcUpMVXpwOVlCQURwSnExVHBaVmtJUUtu?=
 =?utf-8?B?QmN1V2RPUTV3aDJmM1hxbHdWOFlVMXBjeGNabkhJcWNDVjg2T3IxLytLVm50?=
 =?utf-8?B?dHN6UjN6cDlsemVHdjdiRjViQjRzaE1ERXIwK0FmcEZ2SW9HVGFlODArb0o5?=
 =?utf-8?B?SnNWZWZ3K2tnVGRMbkRwWkVRdC9jd0JvSWZEb2VCeEdCakswbnNXMDNBOEJZ?=
 =?utf-8?B?MDk1T2R1dDJ2OHo5SUt1R1krbjNPVTd2d050ZVByL3lKcVRmeE90WTJDT0xJ?=
 =?utf-8?B?bXM5MmNqVGlnMVZSQ3RMazBHQ1lwYmFIdHgvNG12eDA5TmFsLzBwR29rdTlO?=
 =?utf-8?B?QW9KOGFyNXU0TzF2NFRJM1VaVy9hSVlXeWpWamIyREZSS2F0MUxpZytsRUFt?=
 =?utf-8?B?aVl0dE03d0tEcE9ZaUdpcFZLeDIxUWN1SjJxQ2tzWFNFU3dEK0RlZXcwekxI?=
 =?utf-8?B?T3BNcEFaODdaVmZ5MEk3eG1acVFxbnFCWE96SVNyemhFa05KSTZKdzZTUUNt?=
 =?utf-8?B?TmtnZ091UjlvdTExT3lIYXkrQ0tSN2k0bkVYTC9ROW9HMUxIMUR3ZzQ2Q0R5?=
 =?utf-8?B?SklmNUFsWDlYUEYyL0xINkRIYUZJeTdJeW5PRFpGUTVHUS9wdm9JTmFoU2s4?=
 =?utf-8?B?b2hVVWtvaG9maitUUGFYTm9xeloyOUszWXI4cjRNd2poNXdKbkkvSFVFNGRn?=
 =?utf-8?B?U2hJNjc5OGlpaGxkT05RdzY0SW5XbDgwYm5kak9OOEtBSGtkT0w4S0w4Smkv?=
 =?utf-8?B?WkFtRnlSU0ZYRzFmM0J4S1AvdHI3UTZWTlgzeTJxUnhscytlbjZLc243WDZ3?=
 =?utf-8?B?Y0xhanJOcmVSaDNuN0lyRGFocnN2OXcxRUxmem85Y1IyeHluVmVubFRtN1F6?=
 =?utf-8?B?MWVrZkVabk9DdUNyWlpKVWpIUGQzN3dWeXRSeW9rdW8wTGRvaUtxZVhXZUNz?=
 =?utf-8?B?RlA3ODZQdXNmeHdTMmJkckZiZENmdlZDVnQ3RXh3RFYyVDZVVTNWQ1FteDdM?=
 =?utf-8?B?WXJselhDK25uMWlTSm0yK29CZjBRK3plYkZvSFdPQWgyV3NFQWpINHRxNlht?=
 =?utf-8?B?emN6eXBzbC9VTWxMU3dDR3dUVUlOQkNqOGVrdnl1ZDJwRTJ1NUZka1NTYUd1?=
 =?utf-8?B?Nkt5dy90VUNDMnJPMFhtNlNSUDU0NVlpKzUrK3J6Smo1Z2xJYkxEeU1hQm4z?=
 =?utf-8?B?N2FkcWhZekNKVWI0alVkSFdDZUd2Q3NIckhJOUp4d2F4ODA2bWxkY1JLWE1y?=
 =?utf-8?B?VzVEa2U2Vmd2L3V0UVZUcmhtNkw5eUhDVlk3amtaeHNoRVhMMDZhVzlHUXJV?=
 =?utf-8?B?R0NsQmk4K2x6R3NSUG1UTmtSSWoyYjV6TEFxaHAwM0pkcStCejFxNmU2MlNY?=
 =?utf-8?B?MmdiWGpTZkxrN1Jqd0IycmR1dGNWdEl5dUMrbDlFRjB1MEdrWTRhMUF5M2JL?=
 =?utf-8?B?bUh4ZUsxUWZGeFVjdVR0eUM0RGxFeDNnLzRLY2M2V0QwbEdKMTAxT05Wcytk?=
 =?utf-8?B?MXNUVjcrdlE5eFhIVXBFNW1mQUhYZDUyRWljREw5RlFiMUNDT2hjaUUranhY?=
 =?utf-8?B?cG9RRUFkc2NxVHVUYWtLL2hBNzdCL3FGOEVUcUlPNEFUZnBXUTJUMFZtWWh5?=
 =?utf-8?B?N2duOVZzazJQV0l5NC9hOTI5aktvaTN5a3FPZXFCY1FERHNVRlNGME5YOFRs?=
 =?utf-8?B?c0dibHNsbDJpVDZwWk00MjNST3ptM0NtNS90NTNRL1NVa2FFWlNnWmNjR2M4?=
 =?utf-8?B?amZoL2dRV0cra05MUDBvT1ZHVy9iOFF3T0VoKzZROEhFRmkzTmppbDVvZjh3?=
 =?utf-8?B?OStma1lkVm9DSURhdE1VVnk1WVRtOEZzcDF1d252L1dNNjdlbXFHd2hMbEI1?=
 =?utf-8?Q?qtKiITA1noAowVHo=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <37CC72E7A8B2404BAD7C8A7D00814543@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c8ff1eb-4614-42f4-8583-08da1e6151df
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Apr 2022 21:54:15.9673
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: yfvLuxTNi87EgMvH8w4bdEOEqDgIp9QYnvTs/6gQ/9tnAA2wY9PFQQzoSgoyzYJjNIEy0oj3SDbFCyVorcbGqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB2586
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.486,18.0.858
 definitions=2022-04-14_07:2022-04-14,2022-04-14 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=869
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204140113
X-Proofpoint-ORIG-GUID: uZTvyBFe-r2ENqZ374oGHSTjnfxi09iI
X-Proofpoint-GUID: uZTvyBFe-r2ENqZ374oGHSTjnfxi09iI
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC8xNC8yMDIyIDE6NDQgQU0sIEJvcmlzbGF2IFBldGtvdiB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMTQsIDIwMjIgYXQgMDE6MDA6MDVBTSArMDAwMCwgSmFuZSBDaHUgd3JvdGU6DQo+PiBUaGlz
IGNoYW5nZSB1c2VkIHRvIGJlIGZvbGRlZCBpbiB0aGUgbWNlIHBhdGNoLCBidXQgZm9yIHRoYXQg
SSByZWNlaXZlZA0KPj4gYSByZXZpZXcgY29tbWVudCBwb2ludGluZyBvdXQgdGhhdCB0aGUgY2hh
bmdlIGlzIHVucmVsYXRlZCB0byB0aGUgc2FpZA0KPj4gcGF0Y2ggYW5kIGRvZXNuJ3QgYmVsb25n
LCBoZW5jZSBJIHB1bGxlZCBpdCBvdXQgdG8gc3RhbmQgYnkgaXRzZWxmLiAgOikNCj4gDQo+IEFo
YSwgc29tZW9uZSBpcyBiZWluZyB2ZXJ5IHBlZGFudGljLg0KPiANCj4gRm9yIHRyaXZpYWwgdW5y
ZWxhdGVkIGNoYW5nZXMgbGlrZSB0aGF0IEkgdXN1YWxseSBhZGQgdGhlbSB0byBhIHBhdGNoDQo+
IHdoaWNoIGFscmVhZHkgdG91Y2hlcyB0aGF0IGZpbGUgYW5kIHB1dCBpbiB0aGUgY29tbWl0IG1l
c3NhZ2U6DQo+IA0KPiAiV2hpbGUgYXQgaXQsIGZpeHVwIGEgZnVuY3Rpb24gbmFtZSBpbiBhIGNv
bW1lbnQuIg0KPiANCj4gTGVzcyBwYXRjaGVzIHRvIGhhbmRsZS4NCj4gDQoNClNvdW5kcyBnb29k
LCBJJ2xsIGZvbGQgaXQgdG8gb25lIG9mIHRoZSBtY2UgcGF0Y2hlcyBhbmQgbWFrZSBhIG5vdGUg
dGhhdA0KaXQgaXMgYSBCVFcta2luZCBvZiBmaXgsIG5vdCBzb21ldGhpbmcgcmVsYXRlZC4NCg0K
dGhhbmtzIQ0KLWphbmUNCg0K
