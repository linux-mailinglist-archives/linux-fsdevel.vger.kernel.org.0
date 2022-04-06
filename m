Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD81A4F6AD4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 22:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232120AbiDFUIV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 16:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbiDFUHy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 16:07:54 -0400
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA36242892;
        Wed,  6 Apr 2022 10:34:45 -0700 (PDT)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 236GSL1i014716;
        Wed, 6 Apr 2022 17:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=8yQHZdHuLQ+JFarfy0oIWEtyE/9XbUpF6TWclW8hPws=;
 b=xWSv+ubT0RUJX3smb8uLRJNJYbnWBTvykTf85cbiLxd2xtLdOmLGC8Ctm1yTM5gJVN78
 f+62pu3Ft2VEPTjzxk06NczvJh66ObViQmvj+frVnEBezahJpgUklD6nNZu7mOhLyXkg
 MGTwbKo3uK450OfwD3xCdoSOeHAnKDSitOwESZ25qvO4T9n3uTChauVvqhaaUhiN/BFJ
 2KrRyeiXzRNDYEGxeLnvlSDwId4t4MMOoC7whnzy1O7auqwEUaYmpnZfPu6bpqOwnFcU
 4ScfUn9er7B1UaKjPlUV4HkHF9xlRuuasNv/WQAboXcDtOD474cj8Y56WnorYV9ZL5MS bQ== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f6ec9sf5h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:34:33 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 236HGt36000767;
        Wed, 6 Apr 2022 17:34:25 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2174.outbound.protection.outlook.com [104.47.59.174])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com with ESMTP id 3f974d4jbs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 06 Apr 2022 17:34:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ecTeEG2g29yMCMMo2y/iLmNTlQY7YLiTtJfNLpr4Hk6tQ0MVeopqDof+Ncveczji+Ew6Q72XABw93ftMPJIpMRzjN9mfTOUFURXBctkYAp7ZLOXNjmmvA51mqIuI2yXinb9odFlb2EmBk6ocmiZ/dL1O68hTh4tWc1PqqojjnZFPDjhQAHr1ElpzHm5QFq770YHQVUSZEM89g6zeEqCkYCv73G1bQUiM5BY8e9UKmSTLsQQjJyuzlvUorZyy1kUVqGtQPyqdA6mH3Q32hQ8BylVIjOBF7XVeJIkGf5MzH1lwBxWJvpkCPtw3hmR7w7Gl478vUcapm9yzMdXgsuy0UQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8yQHZdHuLQ+JFarfy0oIWEtyE/9XbUpF6TWclW8hPws=;
 b=dLzSilh0TtFRZU7mdnhcQKYUurgzV8CvuJ6W9hg8R9Yo8isksA+OkGHbL1ehz6xucXq/WwPW4teShPS9iZYl0NvsvBGpGPtNCOVym48A/A0rytWMwm0fYc/4ccU2D+OA6TgKBpTFPzSp20d5vTB3h8WLTN6rqmfVCGa4FpbLzmohJZ86QV7pS0nnTaEA13PPOfV37Mr3cO5IGWqasty5Dnd6HHwu3hpy0ie9gzZGWbaY0eELVrWLoEIUS1ruF/Aoa3DE4cUAQrqwpbnpTc15m3GkfwHlVnxDRkWuxY7Tra15MxKAdHy2xtabr+SRd8U1lgtPu2ND+WzBkJnhM9LlHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8yQHZdHuLQ+JFarfy0oIWEtyE/9XbUpF6TWclW8hPws=;
 b=wJEo17uQXMT1MhSAK2tOdCf/4dpVJNdgh/Pnrnpdhw3Bsa3MLkqukIhYZ2NTTQPbqU5qZZVNgc7Vq24EXVepzrFhoFEP/mKLZCQ+cmLyYUUyPBhTL/oWLsEHeG9sFWSSvBIDXUGdoDQYdLFsoj87c3AjDKaTJs6/5XkUUriI/Ig=
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com (2603:10b6:a03:2d1::14)
 by BY5PR10MB4194.namprd10.prod.outlook.com (2603:10b6:a03:20f::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.19; Wed, 6 Apr
 2022 17:34:23 +0000
Received: from SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e]) by SJ0PR10MB4429.namprd10.prod.outlook.com
 ([fe80::1c44:15ca:b5c2:603e%8]) with mapi id 15.20.5123.031; Wed, 6 Apr 2022
 17:34:23 +0000
From:   Jane Chu <jane.chu@oracle.com>
To:     Christoph Hellwig <hch@infradead.org>
CC:     "david@fromorbit.com" <david@fromorbit.com>,
        "djwong@kernel.org" <djwong@kernel.org>,
        "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
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
Subject: Re: [PATCH v7 5/6] pmem: refactor pmem_clear_poison()
Thread-Topic: [PATCH v7 5/6] pmem: refactor pmem_clear_poison()
Thread-Index: AQHYSSYgcxRlD0CAw0GRmRS3uRkg1KziVV2AgADRcoA=
Date:   Wed, 6 Apr 2022 17:34:23 +0000
Message-ID: <839591ec-1754-e5a2-4676-57772bbaf3d0@oracle.com>
References: <20220405194747.2386619-1-jane.chu@oracle.com>
 <20220405194747.2386619-6-jane.chu@oracle.com>
 <Yk0fbUs584vRprMg@infradead.org>
In-Reply-To: <Yk0fbUs584vRprMg@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cc03a692-c666-4bad-5536-08da17f3b0d3
x-ms-traffictypediagnostic: BY5PR10MB4194:EE_
x-microsoft-antispam-prvs: <BY5PR10MB41941BCBBC6FF490ABBF4079F3E79@BY5PR10MB4194.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: y0TfKmQJpDDpFBnR3ABwSra707lRQziqvGxqh65l+Sjo0Mez/8Mxe2oh1We3j7VaNkzG8W2EILcc4P75FwMIkaiOiMMjozlRt/LRNPrHkzCqJ65zMoaXDrPw8iNRb9I9ujMZsf8JwhMBgP5upj37dxxXACfRd9k47F0YlGehTT99UQRJeU3q+Si/TiFDSOEKxYqlBFTSyU1NmaT0sUuwMxnUI9KA21je2+yCwsjxgrAFVrnxKqZ29euBtabokPItnqs8pgxTK0E8WgOKSJBszqaRGQD209Ig3IlR/mKDOpYtbRNcvw2P+RVmkU/eXKp/QzQA67JDCDBbYOiwsut9MO5lioPtTVYbuvh3YXZiwffKD9rgdrui6Bao2/EhPPZc0vP1oo9XkqiMCCxl8cRweGc2eSoryKj4m2JD59dwnvsxmE6ga7M42YpPRVPvJMoYyucktDKlTmPTyewglwpvUo85Qzly0gip414P3s6tHLC7iggj71T/q3GPP2lCabcKOKtusSgMELsZbBUxl43DFSPxrHLCPfpLZYsDVTFAxWGDezxGUVtNLJZNvubdMniCCbg79uihmrpe6rEtpG1hClU0XUsvr5K3cl5CAgzncghXXC72oCi6Lf1tQcNONWw8ZzOgR1eGysY0VE1Yph2NV1FqhbKtW8lM6shSmGpeLe8+/j1e1eKxCUWI5bbfYu8BcPyBt/HBXiGacl6F5y15nrZn6u6fDlkeVUq1ZGbFEtzxAZDfPul7REvQeTKfaH4ToGuCocs6Efh1Fs0oUY3hSg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR10MB4429.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(31686004)(54906003)(7416002)(44832011)(38100700002)(8936002)(31696002)(38070700005)(86362001)(4744005)(5660300002)(508600001)(76116006)(53546011)(66476007)(64756008)(8676002)(66556008)(186003)(122000001)(4326008)(26005)(91956017)(2616005)(66446008)(6916009)(66946007)(36756003)(316002)(6512007)(6486002)(6506007)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?Vk5ScFlDVFBEZmhKRE5lRkMxc1N4VGduWFpwWnFpU3JMUjkvT3dmckx2ekJr?=
 =?utf-8?B?OW9GM1VaQlB0L1poTXFudGlRNWlzaUU3eXExSGtxQm5UUEI4OUZCSWtuYWpI?=
 =?utf-8?B?UWUvdEdWbjhJbm9HV2xhSVVEWHl2V3J3dU5TMU5Ob0ovZFFSZk5XUG8wejFX?=
 =?utf-8?B?aktmQlRKZW9tY1BsdFYwV0wxem9adTBTa2g4bWFHQTNIZHljYWVYSko0TGlY?=
 =?utf-8?B?QXBNN2ZCSHVraE9kb2UyRjZQck5lN1YzcVdLV09xWFc3cVV5enMwTng0Q1JS?=
 =?utf-8?B?UEFnc1h2akM2aEk4YzlNbDJGV2FGSmpzSjkwb2Nma3hmYlZjT0xDZkNWMGRw?=
 =?utf-8?B?eGtINnlmamFNY3V5ZHRHZTE4VHI1bVorV3B5aXBPQnhLbU9JUi9Vb2Z2T2FO?=
 =?utf-8?B?OWY4cjd1WjBTV3JTZHBGOEtDQlJXQ0VVeE4rUHQwaWFXbllwdVVuZm44YmtN?=
 =?utf-8?B?Zm8rYWRESHdsSll6K3pZN2ZsWHMrVVY4SmMvQnpjcTZ0aHBtZjB4VjdBcDFo?=
 =?utf-8?B?Sm1vR01XSTJWMG9qK2VGS2hxZFVnQkVMZWFNL0hsZzQvUS9SSUxNM3MzUzZs?=
 =?utf-8?B?SDdkR0FSSThSRTU3UHB1WGZYYUNCVzVBcGtMK2Ewb1NtaVdBRWVTYUVsVnFi?=
 =?utf-8?B?NDdaU1JQTnBpZFQvTll1Ym9RczF4OWhKRXhIa0J1b29DV3JCYVpYcXQxMkJx?=
 =?utf-8?B?OGRieldwVEQwNTBsQnZEanByRS8yeStnSXhUOXliTjc3d2hJcXgxTE9kalhm?=
 =?utf-8?B?c2pnL1pSOUozNDQ4Qy9jbGpuZW1SVEJmY3dRZldUcHhwVTFzWG92YUo0UjZt?=
 =?utf-8?B?dCtiWGhIbzg5STVPVWtEaHkydDg1eHNKMW1ycmZNSU9ISWRUUGZKMG8rOHZi?=
 =?utf-8?B?V0ZCczdRaUR5eWpBZkRvR2JlWVFFRnpoYkM1aytpKzU3RGZ3bHBkYXFtVHhu?=
 =?utf-8?B?SHcwdzF4cVRZYzRwY1c4RHdiZGRYWHRuVExoQ2tnWkFMRlpMV0J0Y21iclZX?=
 =?utf-8?B?VUVvMTNtNERXWEdRV2dHczNEZElQdzZOaVNtdjJTd1NySGhRODlFeUhrWjBn?=
 =?utf-8?B?Q1hjSDFzSGxGTmhKUi81R2Q1WEUrSkJFdis1Nk9id1h2U2dFanFCclpoQUZn?=
 =?utf-8?B?OUFtM2hjM3dYL3BjSWVLNDhaaE90TTFxMFprTk1yeXpGNkpXckNySldjdTVM?=
 =?utf-8?B?MEEyMHVML1BVWVpTSWp0eURiVXZCN0FpQlI2aWJjaURsWXpHYW5tVUxxMHp1?=
 =?utf-8?B?SlNXTGFmak5uQnNTcndtQXhKeGMvRkxFbXdJNkk2TExxL2NveUZza0FsTDBl?=
 =?utf-8?B?Q0xuSEZiQTdqVFFhTlpWSUt1UTA0OGxQYjRwOC9udmlyTENBZ1lRTFg1bXdC?=
 =?utf-8?B?YXlpY1hjVUJTbUM0Tmw1dlo4Y3lnQ2xEUjRWSkl5Umc4ZlFiK1loSHJNbXVK?=
 =?utf-8?B?bm5FQVZkb0p2TEhxM2l6OTN6TVlEWGthTFlOUjNoRWgrY0xWSzlnUDFZZ0tn?=
 =?utf-8?B?aUtGTnhkUFhZV2FnanRNZ0dVdlB3MU5QZ01YZEd4dytYajFoa2w2eG83MkNm?=
 =?utf-8?B?cm9vcVVoUnhMY3JoeitCVGUxVlVET3ZIUHovQ1pxdUZ0OXV1alM0eWh3NVpS?=
 =?utf-8?B?TGxaVDR3M01FZ0NWcFlsOVZ3dWJhang4czhWNitpdm82Vys2NVRFY1BaWmZY?=
 =?utf-8?B?Wkg3dXdpTnFNbjdlL254U0MwQmt2MmUvTll5ZlA2aytYUmZtTFdORVl6NzRD?=
 =?utf-8?B?UFRFY3VIKzBqSlk3NEt3eXVLK3dQWWExZnhaaDdEYndkQVRzOEs2VFhHdi84?=
 =?utf-8?B?bGg3VjlOVnVtYXRkdnVFUVoyWkpLUHFFZnh0YTBJaDRRRzNYNVR0YkRtcmUz?=
 =?utf-8?B?ZForeWI1YjNVYnRGTk44Rys5UEtoT2dYWmsyNTJ5TkpYR0hzd1dlTlVxU3dL?=
 =?utf-8?B?U2JtVTh2QUVheDNrUllHcnpIUFlOSDN6YVVLaWNjbVVvczZGVzM3R3NCZFdW?=
 =?utf-8?B?UXI1VVJoU3M4YS83THRBeFVhbEZCSlMxVlh2MHViMFJFOGZ1bWlseDRJeGZ1?=
 =?utf-8?B?V0c0MVBTMVBqN3g4eEtoR1M5T1RRR3Q4eE5tZUNEbmpkQWVIaFQzdXpzeFRT?=
 =?utf-8?B?bU9zNWlhZy9jMXdOTXZJbC85MHlwY1dwRlhqUU5WOU83WHhJWE85MEdKWXp5?=
 =?utf-8?B?WS9weHFxVE96b3U5Unh3MysxeUV2MllNTUdBZzVGcGRGUGF4WEwzZm9uVVZ4?=
 =?utf-8?B?QktaSlR6K2h3WmFkcWNKbWVaeG9MV0lDYmwyMTRzOFZab2RKMWlNUGlneHVF?=
 =?utf-8?Q?+3YTQjUI6/BPKIEpPz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6D5D09266131449BA1A90B18CF64970@namprd10.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR10MB4429.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cc03a692-c666-4bad-5536-08da17f3b0d3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Apr 2022 17:34:23.6541
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: TdNJ8oxZrr605i30IwkjQVG1c8ct6SyPR1A3hYch4MvCWGKx+ykK2rqhvGhmYlyRXe2P+maFrnMGuCEHkLGYcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4194
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.850
 definitions=2022-04-06_09:2022-04-06,2022-04-06 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 malwarescore=0
 mlxlogscore=815 suspectscore=0 adultscore=0 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204060086
X-Proofpoint-GUID: siMRKrM5B0-3kC1HPYxEiFS5mrDf3jge
X-Proofpoint-ORIG-GUID: siMRKrM5B0-3kC1HPYxEiFS5mrDf3jge
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

T24gNC81LzIwMjIgMTA6MDQgUE0sIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBUdWUs
IEFwciAwNSwgMjAyMiBhdCAwMTo0Nzo0NlBNIC0wNjAwLCBKYW5lIENodSB3cm90ZToNCj4+ICsJ
cG1lbV9jbGVhcl9iYihwbWVtLCB0b19zZWN0KHBtZW0sIG9mZnNldCksIGNsZWFyZWQgPj4gU0VD
VE9SX1NISUZUKTsNCj4+ICsJcmV0dXJuIChjbGVhcmVkIDwgbGVuKSA/IEJMS19TVFNfSU9FUlIg
OiBCTEtfU1RTX09LOw0KPiANCj4gTm8gbmVlZCBmb3IgdGhlIGJyYWNlcy4gIFRoYXQgYmVpbmcg
c2FpZCBwZXJvc25hbGx5IEkgZmluZCBhIHNpbXBsZToNCj4gDQo+IAlpZiAoY2xlYXJlZCA8IGxl
bikNCj4gCQlyZXR1cm4gQkxLX1NUU19JT0VSUjsNCj4gCXJldHVybiBCTEtfU1RTX09LOw0KPiAN
Cj4gbXVjaCBlYXNpZXIgdG8gcmVhZCBhbnl3YXkuDQoNCndpbGwgZG8uDQoNCj4gDQo+IE90aGVy
d2lzZSBsb29rcyBnb29kOg0KPiANCj4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBIZWxsd2lnIDxo
Y2hAbHN0LmRlPg0KDQpUaGFua3MhDQotamFuZQ0K
