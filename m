Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32D434FC5F1
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 Apr 2022 22:41:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234483AbiDKUnd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 Apr 2022 16:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbiDKUnc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 Apr 2022 16:43:32 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 193786248;
        Mon, 11 Apr 2022 13:41:17 -0700 (PDT)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 23BIWWXP031973;
        Mon, 11 Apr 2022 20:39:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=m6zJN5CapZxjO/aE/FQOJ3913dd1uhDs0STipHI2Css=;
 b=dmJpSXg99GrQgP4VM2EnEI9TqqicrpRrzGY/enKOUi5fY9K+dAIXDbNqDp4X4CQfoYB0
 ngEyHYazTFms6dORjSGBAFEV8/AbDINUc84sAWAEu5cARp4Vs0DyKMwtECoAR/gQ4xLD
 H2WXuOWvYIjLulA662AfwSaLXbZ1ZKmNGrQPBcYmFdc/ZTyGoZlB7m7GjZaebuktr9b/
 XPNZIh5Hw4bO+VcOkVyUrTSTyJpoGRMxDDLasFjSx1CgAPCKlJqVnMiduAoIqG+fW4gT
 +gSMM7ukpJMWMooDpgr9Aj9jiZ5yJlZa1lIKIHwKUXOru5xi0FFYKxo79aOb1Dh5dzPu kA== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
        by mx0b-00069f02.pphosted.com with ESMTP id 3fb0jd4uq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 20:39:40 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.16.1.2/8.16.1.2) with SMTP id 23BKQLBD016275;
        Mon, 11 Apr 2022 20:39:39 GMT
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2040.outbound.protection.outlook.com [104.47.57.40])
        by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com with ESMTP id 3fcg9gnh69-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 11 Apr 2022 20:39:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KuQVIyNHq0W7112ugimOj/SEswyzDmVoo+bUlo1Q3XRjpMOuDjNAsB+LwxRch5BMxE6+bEg2xVrYd3yHSPLqsci/t941Dz2Wm2DRpEWbk6V7cmWLi0dnbJW8KEXEWQ41B0Os7jo3rOdieB9qz1UFsLSufZ66s7jKMwkSh2FsJIEWkjYH6R/0tgTRfG8oCWtJsvSR38uw3r1+rFnx3SUDEio1bTjTgjW4/cDQQgbU25ZcajuDiRY7+goYecyWZ9eQ3DIc6F6/HiK6SER+kCH8xa/8RMTnry5vCWt6Wx62SHogJ1z2d5vCpODTaUkO30Di5yEUYvogaRvUY6td+VAmPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m6zJN5CapZxjO/aE/FQOJ3913dd1uhDs0STipHI2Css=;
 b=iIw1YH6sdklOJOiN6kdxeeoZFvnqoAdnUSdXE58m8zm3OCO38annj7H52GxfxIo83lMwYmuQIuk5wKtND++1OtIpasbQZaIDoAlo00NTgawsTXGyC5Nl/qn38jFciA3+MdKQxsqDnEZTzVjZAboGGbzXmY4OH19TpXRvTD7V/xtoqQchZE9VuJrFhhBWdeYGLINF7fmCov+uiQNNMRHrpGbGqkzHRCmySa2gk3KIQkl7pS5mJYFS8IAVQGdJSuTRSWUXVpijeaiqGzl6jv5tLVzV92acy5PqEzT5ddQwhXJDg+QTOpPsmJmhu8+b1nC6wE8ulQleUviJOKrDfTnK5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m6zJN5CapZxjO/aE/FQOJ3913dd1uhDs0STipHI2Css=;
 b=eQqLkIjQ1BkJ9p4tAJsnEnHu1DryRO5dYyHTgQZTXLezIswxNRJlbbZR8hLlijNZ03ITzVdSprm9kqZy1KMYL5jOi2Q3B2nAuUeYIyo/d3eYL6ZZXRmNMLRss64VgN4FBPM5ORNtRBMAIryXDdDMACMrnGX0j+YB7RZOZkoG7Xs=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by MWHPR10MB1646.namprd10.prod.outlook.com (2603:10b6:301:7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.29; Mon, 11 Apr
 2022 20:39:36 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::41da:48ff:402:1a40%6]) with mapi id 15.20.5144.029; Mon, 11 Apr 2022
 20:39:36 +0000
Message-ID: <da192cbc-e015-193d-b183-83d1d40b42e2@oracle.com>
Date:   Mon, 11 Apr 2022 14:39:30 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 08/14] mm/mshare: Add basic page table sharing using
 mshare
Content-Language: en-US
To:     Dave Hansen <dave.hansen@intel.com>, akpm@linux-foundation.org,
        willy@infradead.org
Cc:     aneesh.kumar@linux.ibm.com, arnd@arndb.de, 21cnbao@gmail.com,
        corbet@lwn.net, dave.hansen@linux.intel.com, david@redhat.com,
        ebiederm@xmission.com, hagen@jauu.net, jack@suse.cz,
        keescook@chromium.org, kirill@shutemov.name, kucharsk@gmail.com,
        linkinjeon@kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        longpeng2@huawei.com, luto@kernel.org, markhemm@googlemail.com,
        pcc@google.com, rppt@kernel.org, sieberf@amazon.com,
        sjpark@amazon.de, surenb@google.com, tst@schoebel-theuer.de,
        yzaikin@google.com
References: <cover.1649370874.git.khalid.aziz@oracle.com>
 <5c96dd165d7ec3da14306b8fd857c7eb95a8c3e6.1649370874.git.khalid.aziz@oracle.com>
 <86956aa9-36be-b637-8e58-14eb0167b751@intel.com>
From:   Khalid Aziz <khalid.aziz@oracle.com>
In-Reply-To: <86956aa9-36be-b637-8e58-14eb0167b751@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0059.namprd11.prod.outlook.com
 (2603:10b6:a03:80::36) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cfe3bf03-1c39-4aea-f127-08da1bfb6414
X-MS-TrafficTypeDiagnostic: MWHPR10MB1646:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB164669C9047F5235BAD9C91086EA9@MWHPR10MB1646.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: F972w0Tl/Ylm2E8px6ecVLb/LY0BypHNf8b8Y3HJmcGdwaeQcdcX0TQWAnPse8f9u7cP8JEIzGNQ5F6S+RO6keESdyW6ccGzigd45QA4s9LTwh/ej5pukdYSMgTCoUKLoSTQVq9SHCv3a2eMaHmrKKbcpa25KyiJ41w1o4K3P/LXQFUXVK0NOnrB8YDknGshKG1OSN3T+ZBrw0xGAV2H7KJ2IPQMhm6iA+7q2AKwxNUnM4Y/YbN7P3T5/+nltVvoMowhGPWRy6GyrqzN70IW4ghtpN7rdSr1Am4lPJqEAKISPtDTRa39zJsibhoXErwwxLA47+k3uVz/j2juhRIWQvIuOgYRz8wyqMOhpXtKDq6U6IX5VRnNyFm8EsTFyyl4qrm0kAZzMN7DJKvibsUSUfTx9HVI1UHM1+1ZEdcFRXRdq/AsT7pJ5BnXLZKhxpPb+LxmEH/qD+bo4EC9XmJ1HhQuZW1mQhp3fRhtkoa+WKjcFyt+rWSOt8UWYGn7oVFykV4yBhpuP2S/DNtL/thh+iE6heJYhrPArEoqyVqU3qnIEnsCYlybneKyp+zbycV0LAxbUN/kXPx3c5oJJ8fFN3XtI5CVZ4BTG0taSPY68qR3q/cmoPS0i9ir/pb6hBScUqwxv/sWyvdcs/+ffm58T6P3CaoKJhYKH9xmjOJ3iVn/6+LjdaA9vm5Vr/2pe0Y+ERLtYaPQly70wszqkgaQn8n0xblPPq19FdPi3yluA/INMT6NaE0vjndQxenQncerWPzrRKyweBGfh9KtkNQ1QQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(31696002)(5660300002)(8676002)(2906002)(66946007)(6486002)(8936002)(7416002)(44832011)(86362001)(66556008)(53546011)(6512007)(83380400001)(6506007)(6666004)(2616005)(66476007)(4326008)(186003)(316002)(38100700002)(26005)(508600001)(31686004)(36756003)(21314003)(60764002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RE9GWk95cUFKdkdoS3pzZWtjVnBvcjhoQVYxZ0w5bXBmQ0tKZUVmZkRpdGti?=
 =?utf-8?B?bGNGRGdRcFFMMTRhNFcxRTFiZzdPSE9kUS9VUDBwOFlxZHVwYk1ZcTFvemkx?=
 =?utf-8?B?eGlwRm5ZdVh4enU0L081WTUzSTVDNXdTYnZWS0dFR0hhNkpLSHg2MHRqTWpr?=
 =?utf-8?B?ejMxVFFXYkIzNTJKY3ZnSnlNYkZ0Ym9SaE9nNzJmZjUzL1dIZjduMEN0LytW?=
 =?utf-8?B?R2ovVzZMOHR0WklSU3ZWenpFUW5YMFA1T201NC9Rb2VpM0I5NkQ4U0NGTmhO?=
 =?utf-8?B?YldPVGR2bkEybHZNTllGbGgwRVVrbVJwdXU1QWZuQk9XMDFBWW5xV3N2a2Iy?=
 =?utf-8?B?eG1NTEpKS1V1YUxnMmdsTGllUVFoSm5WVVA4TGlKeDJUQmhKQnk2MEp1alpv?=
 =?utf-8?B?bnUyUy9TeTc1UkhRbzVlMk1qWWoxc1JLV0RlY3kxY2M2MGFuOFRzWDg5VDQw?=
 =?utf-8?B?bUxZdWpmWnVsbmpvaDhCZGJOT3FxUVFOczVrajljK1NocFR0cERzak12aTJ1?=
 =?utf-8?B?cDBnUG5tUm5uK0l6aGlOb0ZrczU5ZEdobTBNOEp6SG0xcWtUQnZ6bmt4bms0?=
 =?utf-8?B?cFdvWXhLbmtiSTIrUmZ3MTdqcjBoVDNyVFJZdVhsa0x5d3lFYUlDRk9QRUp2?=
 =?utf-8?B?a0tOcGUyZWt5dGJxWUpobHp4ckFZNlkwWG0wc2JiTTdvZXZ6Y092SFNHWkR0?=
 =?utf-8?B?aGNORTJFMW5teDFJTG1DNHJ3SnkxaHVuM3dtK0N4bndPQXVXSXU3czNQY2NN?=
 =?utf-8?B?MmU2QVk5OFNJVi80T211UUYwSFVjTFluTllYMlRxVjhZdDFnTWRIRFFrU3FP?=
 =?utf-8?B?bzhDSlFBL0dvTlBtd1VadXZJMjJCbFM4d2ZvR0N1bjExSzJsQU9tVFhBNFN5?=
 =?utf-8?B?eklDdHAweXRCdmFLSUsxQ3JJcU1oQWJWbDVnVXVhU3R2U1JqbW9VSXFyaUkr?=
 =?utf-8?B?UnliVElDSWs0R1VKVVovcnRDUWVjNGthYVZ4NEtQWmJtNUZZbWpFditVVXNk?=
 =?utf-8?B?bWFZVWlBU0ZGNlFjb2VUWkVFS2pFOVR1VFdkNDdVNzRVYXgwTGQzWnI1RVVS?=
 =?utf-8?B?T2tzcjROaHRBR01uR21CTHpleXRjeW5mdG8yR1plYTdaMGhUbGFNUjlERTlq?=
 =?utf-8?B?OXBjcDJWTExXbGVwTlZiQ3lHNnVFTnh2bE41ZFpVT3BZRXJiM3drREVwYVJN?=
 =?utf-8?B?TjVZU1ZkQ2pwLzhFMjNCVzI0QzZPNlZVN0VDYm16UElpcTRvdGppSW11ODRF?=
 =?utf-8?B?TCtuZHI0eTliRmZVTDA1TE5LMUhYNUl3VTJibENBZFMyVG90VDRwZ2ZHOUc1?=
 =?utf-8?B?RWtWTG1rZzJkK3Y2OFYvZzA0U1VmdCtES0FiU0xYa0lOL1FpNWcya3pmeSsx?=
 =?utf-8?B?ejUwdlVaSGlTZEVPbENHTk1EQjYvMWh3Q2tSQ0lKbHZqM2V6RGtSTElqeUpo?=
 =?utf-8?B?bGttVFVHMnRYZjV2Rm9IQUlWSXgyeUY5YXRJUVJWbktXc3c1aWxRRkpqbW82?=
 =?utf-8?B?dDNMMGkxNERDOGlOSThMaXU4Z3ZkbDdtb0xmK0RjYmF0dHN2YXJzMkpyV1g5?=
 =?utf-8?B?WDFpYllETmQxQTZXNjJmRUlnTzdzcTVEdmYvZldGaU1lU2hvaE9jVml2OGpa?=
 =?utf-8?B?VDlMR0RzNXgydGtJT0F4TjFSTXlVVitVZUh2aWsrUVNrSVhXZDJCOTRGSG9L?=
 =?utf-8?B?QmJ6TkNTWGlDajVFWDVvNXhBY3M5VDgrZXlnZEVNVXFFTm5lcUxiaFFyaGhQ?=
 =?utf-8?B?ZXFWWEdQcFYvTENHUU5Bb1RUY2pMUEVYYjhmdUhMSWdob25RVUVVZ0xPN1h1?=
 =?utf-8?B?UEw5SHZRTXA4S2l1amRHZCtWUGw4V1VBUnJPMElEU0c0cUJsRTkrZGtzaGNi?=
 =?utf-8?B?b3FJOTdaRzFTa2orenFFcUJHVkhQcFdIbnhHWGJEYjRQTkJKMW9HRHF5QzVt?=
 =?utf-8?B?ZnBmZjlFZDJPcG1ZRmN1enpqZkk5UHBSTW5SdUl2N09EZ0NUNWNQTGszRElX?=
 =?utf-8?B?d2lxZUpRVXRCMi9TZDZpNW1vcjFrUWk5SDhSaDJPMXB3OFhydkpPUmIrcXlj?=
 =?utf-8?B?NzFrakZIYjB6R0krUWFiMys0eVJuSDBpdERRVHRYWG5GRmF3anM0Q3U0dXlo?=
 =?utf-8?B?aTNvSHVZSUNoQ1ZoSHNudUwyY2k1UFA3ZmZiTEV5YUY4b1pUd2dhOThVV0FP?=
 =?utf-8?B?VC9pYWVqVnlwOWNkVnkyYVROQmdRaGxVRTdYTDJZQytCRHFOQXRTdXQ4bGtE?=
 =?utf-8?B?NVc1cVZ5RmdPTWdiWVgxNUtaZDNMN0h5N3lqeHdiWmtLcjdraTJiNXRjWFc0?=
 =?utf-8?B?WWJqUHlGRnBud2tVcTkvdGx3L3lrWU1pOEVpdGRhY1R2TlZiYW0vVDMybmhH?=
 =?utf-8?Q?iYbSmEKx2CjmdOY4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfe3bf03-1c39-4aea-f127-08da1bfb6414
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2022 20:39:35.9775
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ecnN8zNdDLoJoiBE+boR97fChj+AYQkfBwhL7sGRTiQe6evEGty8J9iXPkdMbNSAFhr3YTbfHsZzzmehT2ghQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1646
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.425,18.0.858
 definitions=2022-04-11_08:2022-04-11,2022-04-11 signatures=0
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxlogscore=981
 spamscore=0 suspectscore=0 malwarescore=0 adultscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204110113
X-Proofpoint-ORIG-GUID: X2Z9qQDD6VucCY11uQQJuUXUSGjA4MYn
X-Proofpoint-GUID: X2Z9qQDD6VucCY11uQQJuUXUSGjA4MYn
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/11/22 12:48, Dave Hansen wrote:
> On 4/11/22 09:05, Khalid Aziz wrote:
>> This patch adds basic page table sharing across tasks by making
>> mshare syscall. It does this by creating a new mm_struct which
>> hosts the shared vmas and page tables. This mm_struct is
>> maintained as long as there is at least one task using the mshare'd
>> range. It is cleaned up by the last mshare_unlink syscall.
> 
> This sounds like a really good idea because it (in theory) totally
> separates the lifetime of the *source* of the page tables from the
> lifetime of the process that creates the mshare.
> 
>> diff --git a/mm/internal.h b/mm/internal.h
>> index cf50a471384e..68f82f0f8b66 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -718,6 +718,8 @@ void vunmap_range_noflush(unsigned long start, unsigned long end);
>>   int numa_migrate_prep(struct page *page, struct vm_area_struct *vma,
>>   		      unsigned long addr, int page_nid, int *flags);
>>   
>> +extern vm_fault_t find_shared_vma(struct vm_area_struct **vma,
>> +			unsigned long *addrp);
>>   static inline bool vma_is_shared(const struct vm_area_struct *vma)
>>   {
>>   	return vma->vm_flags & VM_SHARED_PT;
>> diff --git a/mm/memory.c b/mm/memory.c
>> index c125c4969913..c77c0d643ea8 100644
>> --- a/mm/memory.c
>> +++ b/mm/memory.c
>> @@ -4776,6 +4776,7 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>   			   unsigned int flags, struct pt_regs *regs)
>>   {
>>   	vm_fault_t ret;
>> +	bool shared = false;
>>   
>>   	__set_current_state(TASK_RUNNING);
>>   
>> @@ -4785,6 +4786,15 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>   	/* do counter updates before entering really critical section. */
>>   	check_sync_rss_stat(current);
>>   
>> +	if (unlikely(vma_is_shared(vma))) {
>> +		ret = find_shared_vma(&vma, &address);
>> +		if (ret)
>> +			return ret;
>> +		if (!vma)
>> +			return VM_FAULT_SIGSEGV;
>> +		shared = true;
>> +	}
>> +
>>   	if (!arch_vma_access_permitted(vma, flags & FAULT_FLAG_WRITE,
>>   					    flags & FAULT_FLAG_INSTRUCTION,
>>   					    flags & FAULT_FLAG_REMOTE))
>> @@ -4802,6 +4812,31 @@ vm_fault_t handle_mm_fault(struct vm_area_struct *vma, unsigned long address,
>>   	else
>>   		ret = __handle_mm_fault(vma, address, flags);
>>   
>> +	/*
>> +	 * Release the read lock on shared VMA's parent mm unless
>> +	 * __handle_mm_fault released the lock already.
>> +	 * __handle_mm_fault sets VM_FAULT_RETRY in return value if
>> +	 * it released mmap lock. If lock was released, that implies
>> +	 * the lock would have been released on task's original mm if
>> +	 * this were not a shared PTE vma. To keep lock state consistent,
>> +	 * make sure to release the lock on task's original mm
>> +	 */
>> +	if (shared) {
>> +		int release_mmlock = 1;
>> +
>> +		if (!(ret & VM_FAULT_RETRY)) {
>> +			mmap_read_unlock(vma->vm_mm);
>> +			release_mmlock = 0;
>> +		} else if ((flags & FAULT_FLAG_ALLOW_RETRY) &&
>> +			(flags & FAULT_FLAG_RETRY_NOWAIT)) {
>> +			mmap_read_unlock(vma->vm_mm);
>> +			release_mmlock = 0;
>> +		}
>> +
>> +		if (release_mmlock)
>> +			mmap_read_unlock(current->mm);
>> +	}
> 
> Are we guaranteed that current->mm == the original vma->vm_mm?  Just a
> quick scan of handle_mm_fault() users shows a few suspect ones like
> hmm_range_fault() or iommu_v2.c::do_fault().

You are probably right. Safe thing to do would be to save the original vma->vm_mm before calling find_shared_vma() and 
use this saved value to unlock later if needed. I will fix that.

> 
>> diff --git a/mm/mshare.c b/mm/mshare.c
>> index cd2f7ad24d9d..d1896adcb00f 100644
>> --- a/mm/mshare.c
>> +++ b/mm/mshare.c
>> @@ -17,18 +17,49 @@
>>   #include <linux/pseudo_fs.h>
>>   #include <linux/fileattr.h>
>>   #include <linux/refcount.h>
>> +#include <linux/mman.h>
>>   #include <linux/sched/mm.h>
>>   #include <uapi/linux/magic.h>
>>   #include <uapi/linux/limits.h>
>>   
>>   struct mshare_data {
>> -	struct mm_struct *mm;
>> +	struct mm_struct *mm, *host_mm;
>>   	mode_t mode;
>>   	refcount_t refcnt;
>>   };
>>   
>>   static struct super_block *msharefs_sb;
>>   
>> +/* Returns holding the host mm's lock for read.  Caller must release. */
>> +vm_fault_t
>> +find_shared_vma(struct vm_area_struct **vmap, unsigned long *addrp)
>> +{
>> +	struct vm_area_struct *vma, *guest = *vmap;
>> +	struct mshare_data *info = guest->vm_private_data;
>> +	struct mm_struct *host_mm = info->mm;
>> +	unsigned long host_addr;
>> +	pgd_t *pgd, *guest_pgd;
>> +
>> +	host_addr = *addrp - guest->vm_start + host_mm->mmap_base;
>> +	pgd = pgd_offset(host_mm, host_addr);
>> +	guest_pgd = pgd_offset(current->mm, *addrp);
>> +	if (!pgd_same(*guest_pgd, *pgd)) {
>> +		set_pgd(guest_pgd, *pgd);
>> +		return VM_FAULT_NOPAGE;
>> +	}
> 
> Is digging around in the other process's page tables OK without holding
> any locks?

current->mm should already be locked when handle_mm_fault() is called. "mmap_read_lock(host_mm)" should be moved up to 
before calling pgd_offset(). I will fix that.

> 
>> +	*addrp = host_addr;
>> +	mmap_read_lock(host_mm);
>> +	vma = find_vma(host_mm, host_addr);
>> +
>> +	/* XXX: expand stack? */
>> +	if (vma && vma->vm_start > host_addr)
>> +		vma = NULL;
>> +
>> +	*vmap = vma;
>> +	return 0;
>> +}
>> +
>>   static void
>>   msharefs_evict_inode(struct inode *inode)
>>   {
>> @@ -169,11 +200,13 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>   		unsigned long, len, int, oflag, mode_t, mode)
>>   {
>>   	struct mshare_data *info;
>> -	struct mm_struct *mm;
>>   	struct filename *fname = getname(name);
>>   	struct dentry *dentry;
>>   	struct inode *inode;
>>   	struct qstr namestr;
>> +	struct vm_area_struct *vma, *next, *new_vma;
>> +	struct mm_struct *new_mm;
>> +	unsigned long end;
>>   	int err = PTR_ERR(fname);
>>   
>>   	/*
>> @@ -193,6 +226,8 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>   	if (IS_ERR(fname))
>>   		goto err_out;
>>   
>> +	end = addr + len;
>> +
>>   	/*
>>   	 * Does this mshare entry exist already? If it does, calling
>>   	 * mshare with O_EXCL|O_CREAT is an error
>> @@ -205,49 +240,165 @@ SYSCALL_DEFINE5(mshare, const char __user *, name, unsigned long, addr,
>>   	inode_lock(d_inode(msharefs_sb->s_root));
>>   	dentry = d_lookup(msharefs_sb->s_root, &namestr);
>>   	if (dentry && (oflag & (O_EXCL|O_CREAT))) {
>> +		inode = d_inode(dentry);
>>   		err = -EEXIST;
>>   		dput(dentry);
>>   		goto err_unlock_inode;
>>   	}
>>   
>>   	if (dentry) {
>> +		unsigned long mapaddr, prot = PROT_NONE;
>> +
>>   		inode = d_inode(dentry);
>>   		if (inode == NULL) {
>> +			mmap_write_unlock(current->mm);
>>   			err = -EINVAL;
>>   			goto err_out;
>>   		}
>>   		info = inode->i_private;
>> -		refcount_inc(&info->refcnt);
>>   		dput(dentry);
>> +
>> +		/*
>> +		 * Map in the address range as anonymous mappings
>> +		 */
>> +		oflag &= (O_RDONLY | O_WRONLY | O_RDWR);
>> +		if (oflag & O_RDONLY)
>> +			prot |= PROT_READ;
>> +		else if (oflag & O_WRONLY)
>> +			prot |= PROT_WRITE;
>> +		else if (oflag & O_RDWR)
>> +			prot |= (PROT_READ | PROT_WRITE);
>> +		mapaddr = vm_mmap(NULL, addr, len, prot,
>> +				MAP_FIXED | MAP_SHARED | MAP_ANONYMOUS, 0);
>> +		if (IS_ERR((void *)mapaddr)) {
>> +			err = -EINVAL;
>> +			goto err_out;
>> +		}
>> +
>> +		refcount_inc(&info->refcnt);
>> +
>> +		/*
>> +		 * Now that we have mmap'd the mshare'd range, update vma
>> +		 * flags and vm_mm pointer for this mshare'd range.
>> +		 */
>> +		mmap_write_lock(current->mm);
>> +		vma = find_vma(current->mm, addr);
>> +		if (vma && vma->vm_start < addr) {
>> +			mmap_write_unlock(current->mm);
>> +			err = -EINVAL;
>> +			goto err_out;
>> +		}
> 
> How do you know that this is the same anonymous VMA that you set up
> above?  Couldn't it have been unmapped and remapped to be something
> random before the mmap_write_lock() is reacquired?

Good point. The one check I have after find_vma() is not enough. I need to add more checks to validate this vma.

> 
>> +		while (vma && vma->vm_start < (addr + len)) {
>> +			vma->vm_private_data = info;
>> +			vma->vm_mm = info->mm;
>> +			vma->vm_flags |= VM_SHARED_PT;
>> +			next = vma->vm_next;
>> +			vma = next;
>> +		}
> 
> This vma is still in the mm->mm_rb tree, right?  I'm kinda surprised
> that it's OK to have a VMA in mm->vm_rb have vma->vm_mm!=mm.

I will look into what needs to be fixed up here. One possibility is to not change vm_mm. I think I can work without 
changing vm_mm for donor or client processes as long as vm_mm in the host mm for mshare'd vmas points to the host mm.

> 
>>   	} else {
>> -		mm = mm_alloc();
>> -		if (!mm)
>> +		unsigned long myaddr;
>> +		struct mm_struct *old_mm;
>> +
>> +		old_mm = current->mm;
>> +		new_mm = mm_alloc();
>> +		if (!new_mm)
>>   			return -ENOMEM;
>>   		info = kzalloc(sizeof(*info), GFP_KERNEL);
>>   		if (!info) {
>>   			err = -ENOMEM;
>>   			goto err_relmm;
>>   		}
>> -		mm->mmap_base = addr;
>> -		mm->task_size = addr + len;
>> -		if (!mm->task_size)
>> -			mm->task_size--;
>> -		info->mm = mm;
>> +		new_mm->mmap_base = addr;
>> +		new_mm->task_size = addr + len;
>> +		if (!new_mm->task_size)
>> +			new_mm->task_size--;
>> +		info->mm = new_mm;
>> +		info->host_mm = old_mm;
>>   		info->mode = mode;
>>   		refcount_set(&info->refcnt, 1);
>> +
>> +		/*
>> +		 * VMAs for this address range may or may not exist.
>> +		 * If VMAs exist, they should be marked as shared at
>> +		 * this point and page table info should be copied
>> +		 * over to newly created mm_struct. TODO: If VMAs do not
>> +		 * exist, create them and mark them as shared.
>> +		 */
> 
> At this point, there are just too many TODO's in this series to look at
> it seriously.  I think what you have here is an entertaining
> proof-of-concept, but it's looking to me to be obviously still RFC
> quality.  Do you seriously think anyone could even *think* about
> applying this series at this point?
> 

Fair enough. Some of the TODOs are meant to be reminders for expansion of functionality (like this one is to support 
calling mshare without having to mmap the address range first), but I should clean these up and I will do that.

I appreciate your taking time to provide yuseful feedback.

Thanks,
Khalid
