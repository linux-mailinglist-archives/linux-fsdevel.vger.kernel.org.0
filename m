Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49559669BB3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Jan 2023 16:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjAMPPu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Jan 2023 10:15:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbjAMPPK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Jan 2023 10:15:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AAB8141F;
        Fri, 13 Jan 2023 07:06:26 -0800 (PST)
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30DEerZl018428;
        Fri, 13 Jan 2023 15:06:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2022-7-12;
 bh=tF8TDnOOVkAR8ghLEsA46IWl7SR2baC0XKPedfaVd8g=;
 b=G00C9N7hGtuYucsXNNi71XtpCsNZ0ygvmvqnHJTfkAQ5FatAKurjbPAnwRDY2WdR+7UT
 8ehE2VVxW1kJb1fzJxVV64R6G1eztL1gm8U1++Gnoscni1/jZEQxtFqSxkVXVO9RLaZN
 w2WwQzSuXH/4kvh0vlMV5p9zzASJzAGjBCQoun/SDnpLe71Cx8ZyIXUfrT4aQP/2tX3p
 WWuqiMPko/p9GNH660dNnI6WCTmwt2EK3I59Q3NdolEp9aqkEQmD1DM55/CUcPw4EcTu
 lDXcNuY/IolZOqGlFYr3Ct/FlVyv1BVBwr114yteLYeLFEbbBv+GDw8uu8R3DuMAjT1t /A== 
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3my0scmw2v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 15:06:05 +0000
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.5/8.17.1.5) with ESMTP id 30DDjx6b008372;
        Fri, 13 Jan 2023 15:06:04 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2173.outbound.protection.outlook.com [104.47.59.173])
        by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3n1k4s9k36-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 13 Jan 2023 15:06:04 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZGv3Xppk4KQqI3jYJaWRIBhzHfYIRNeXsgG2S01FbO7Gpw1FaB9SIWGPzcvxZ+LHNDbUOxzQsbJUJtITR383XYc1u2qUV0jTf59atfykEXRYbBc+aWUJSeikCSPsalZ4tCqMNTPGskuqt7KtS5CNyQF9nfa322Q9Ufg73YrKWFOlnh8itY2DXgD1AMcg4Xk1EKptWfYsCYx+p1LX93yVcQ41yha6clihJhYlEj53F3FfSeeOIKIyztQW2P4PlWciR8vSrq2GWxaf8AkH/IxfmZX4it98yH0EUE8z6UAGDYzejw1fxA4tlZLiKyp9KrvR5oFPOGoY5/QWgi9yPr7y/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tF8TDnOOVkAR8ghLEsA46IWl7SR2baC0XKPedfaVd8g=;
 b=bQQRLdp44LOVio5lGbGV2/hRBNumoz4ivE0Iq/IWXwXjsoJ0UNYVHsNdjjzHIJBiIxjwKCDrgTMX93rXi+ARU+TsBGRm5/QZgrmoodDGWUOQlTXnpPa59mWkC3dyjjs0URtoiI/xjOmhF2WN1946FsLjoS1thcA+ivtruN6VFZSVkFzpfA4U3vpIRb3lmqMV78KglGEFgs8QPl9lJ02+hZSRP4pgeyLIJl/Wcv08fjdlmSsv2sAayNvwlZMNfLFyOFTkzt45cN+Q7lto0HCPFiux7A/fFzXcM0y+zxuvSIgo1LaRDlZqkIFG4moBbrYjiDEr1KcqCgzneHX9YY+TTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tF8TDnOOVkAR8ghLEsA46IWl7SR2baC0XKPedfaVd8g=;
 b=mq3FSCwMHCtx9wjh7bu0qxZ7N3dfbHqmDSe0HpiYjAFJkt67Yr07s50O2nndVZEhT/7+Iqe5wyhadvC5UOjtu5ouUko9CxgT2x9WzSuT02ztlXUPq70YMILm+6Qw6V3FoOtpqO0JZhx1kaBExk22oeb0wfIqIjvSQPlqAn7coJs=
Received: from MW5PR10MB5738.namprd10.prod.outlook.com (2603:10b6:303:19b::14)
 by PH0PR10MB4423.namprd10.prod.outlook.com (2603:10b6:510:40::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6002.12; Fri, 13 Jan
 2023 15:06:02 +0000
Received: from MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a7ae:fd8c:2e73:edb0]) by MW5PR10MB5738.namprd10.prod.outlook.com
 ([fe80::a7ae:fd8c:2e73:edb0%6]) with mapi id 15.20.6002.012; Fri, 13 Jan 2023
 15:06:02 +0000
Message-ID: <f99e5221-4493-dba3-3e80-e85ada6b3545@oracle.com>
Date:   Fri, 13 Jan 2023 09:06:00 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: Should we orphan JFS?
Content-Language: en-US
To:     Harald Arnesen <harald@skogtun.org>,
        Christoph Hellwig <hch@infradead.org>
Cc:     jfs-discussion@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <Y8DvK281ii6yPRcW@infradead.org>
 <0661e73f-9420-9a0a-ef46-15b54a3b5357@skogtun.org>
From:   Dave Kleikamp <dave.kleikamp@oracle.com>
In-Reply-To: <0661e73f-9420-9a0a-ef46-15b54a3b5357@skogtun.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: CH0PR03CA0105.namprd03.prod.outlook.com
 (2603:10b6:610:cd::20) To MW5PR10MB5738.namprd10.prod.outlook.com
 (2603:10b6:303:19b::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR10MB5738:EE_|PH0PR10MB4423:EE_
X-MS-Office365-Filtering-Correlation-Id: 765acad1-67cc-4f5f-a01d-08daf577af7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b03d4JfyAt6mKqI6EHNkhWDlo3QOIqhnAmpxEmuUb7x1DlKurWaVOmY2Urj5vjPQ4+AMgvbYqMFKKUqYIbiBdmYL/CkAFpYllHbUinqchjmSxHxPDwkjrkjRCkTIcs7lST9Oxk6guDdGD6l4G9PHrmvFUfk7KtvUD2BaR8QKRwABZJNS7rfJdI4P9UPkhXDgoyZ+sOVSo0sxBBocg8kba4Y99H9bg1VwY85OwhoOpnGKzi9gX4U8U3Zgcm7TbHVEczg0ST2wamDawLc/xUtPmZxeF4Yg3Z1fMn6jMXXPpYiIFFOIcZMApYvxzP1MSBmClTwNYMrEcOF68AHhHy1UVNe2Dz+VtHNTJlDFqLKkm2lEgHM/a1fySfNW9MGUjoXU/BH56v/AZvepUPsYfS9Jf4rPMaztPkYcuOIlG3H6yuf2dLHoe7B0/9eL7DwQnr+xuf3i5gr2Dth/vQ13bgH6LIRS1+i1yLEj/HnhvdEUJ1UmJ1pscRPs0sOMz/DqiZU/fadKSgLtGgY+OQWx6HfZw5GWEb6rAMVhqRM3juBKUWlLXwHi/HXa70hBoOUPHrOo//XA/zThKVncuFAPKLDku8iwPvZN78/TP2RY9uaBjFt6mTbVskXdIB4oqsvHDsJaAC+eEICrlvix3GEA6qedEMP8NmOlBLaXbFLUen5Er+Hs6idCMTUVn1ddHyz7lR01v9zo/u8xzkbGzpR6AoHdb0r+VGeaICoycRZw52rz2q4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR10MB5738.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230022)(346002)(39860400002)(136003)(376002)(396003)(366004)(451199015)(6512007)(186003)(6486002)(26005)(31686004)(478600001)(316002)(66556008)(66946007)(66476007)(110136005)(2616005)(6506007)(4326008)(8676002)(38100700002)(8936002)(5660300002)(41300700001)(31696002)(44832011)(86362001)(36756003)(2906002)(3480700007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Mm0wV3NpeDNNZCtuK0I0VWJZMGdKOHpxY2E3Y1lieGExdytuNXlhcG1zWnl4?=
 =?utf-8?B?dHplZVo3NHRSR3Boc1lLR1FCWnc1VERjcjBRNE5OQ3haQlRSTEVtNDY3Qldn?=
 =?utf-8?B?NlNDVkxVaDg5QU9VazJZemt2Vm8rdk9NMXdRQVo2aE5EL0pLbjd2Mk41RWky?=
 =?utf-8?B?bmJ4dGJUMEJnSGo2TTUwWGlTSjFyYW93L0tHOXIxZCswRnh2M21YbWtLZzNU?=
 =?utf-8?B?NWs0dVBWWStPeDBsS2FOSEl4VXNpYVBESFQ1V3JBQ09JWlRWSkJqSWpjNzM1?=
 =?utf-8?B?TVkwSUlIRG9zL1A3eitrbW80UlRQdGU4Sk9YUC9iYmlkUUoxNS8vbFZUUkxR?=
 =?utf-8?B?YlViN0N0aTVjSXFjU0I1UnJXdFNzeTROb1pBUUNpZ3llRzI2ODFjMFMvcGg3?=
 =?utf-8?B?YWlWWTJXenlOd3V5TndMTERDbUtkN2tpU0JjWFdudlZwc3ZxSUVsZGQwQU4z?=
 =?utf-8?B?blZUdWF3NGpnNFR2MUZab001SFRvalo1Tk8reVlKdlRTb2lXajdoaWo4T24w?=
 =?utf-8?B?RHhOUUVCcGxNVVFsb3V0Q0J0dU1odUJIbWlZNzV0UGM2TGdMcGVGSzA1NUZI?=
 =?utf-8?B?TUNRN2h0TGpwTVZUSUk4cXIyRlErWHpIbzFSbUl4VkNvd3RhdXc2cVZtY0hr?=
 =?utf-8?B?dCs3dHJ6KytBN2tEUGFLZkhwbEovYzlkVDFEMUJuMEk1b0E3MnV6cmFpc0h3?=
 =?utf-8?B?UUh2MTRzNXdrM1RTRG12NzNsTVl4cXpDazN0SE14dHZsRy92V2hodkRqN3BV?=
 =?utf-8?B?VGhsbW5hQjI2cHUvU0l3YnZoaDkycm51eVJSVlZvbFgvbHIxa0swelVqdlhN?=
 =?utf-8?B?WWM2Tk1sdnBwbm9NTWIwS0V1UHR6bVNGLzZ0QkVvOGdvTWxySklUTm5QNFg5?=
 =?utf-8?B?K2ZYb0NoczRwUmRnL0paQ0tGVWRrNjkybnRubGZydTFFQ1NmYlF1anhsZ2lj?=
 =?utf-8?B?OXJZdzdwd1ZTb1pRWXdiQ2VkbVA1UTZpeGIremJWMm11dWVMN3Vpc2dTTmgw?=
 =?utf-8?B?R1FvRmZ2ZzA3N2xEUS9RY2tiT0pMb05sMzVEaFROS3RtdG9QSzl4R25KRjR6?=
 =?utf-8?B?Z1ppdGJJaVAvZUY4UTdQUzFjQy9RU2k2emtueXdSV05lVFFpNmZkMWFMdlJV?=
 =?utf-8?B?UTllanZRNzk4Wms3ZVd4QjFDSm14S1JGdW1uN2NnZlgweks1SjZ0cVZzckh0?=
 =?utf-8?B?MTRHdXp0aXcyUTN3MWRFT0VveWRpMk1GSXQ1azU0cGVoUEFHT2dNSEYzamNj?=
 =?utf-8?B?Y3gyeExIOVZSOXZGcWw3Kys1ZUtxUVMzVWJtYVVOaXVnYW5NdXFqSWJBWnJC?=
 =?utf-8?B?VDZ4dVNOR0xNSnFPSEp5YzRubmF0V0dKQndJRi9JU3BvYWFlajM1WEpJdEky?=
 =?utf-8?B?Yk03aVdPR2ZjQ3MydSt4SUFPcXJ4b3gzTEdqR1NVOGRhUndMOWxMdHp4U0lO?=
 =?utf-8?B?YUY0MTRWYWxVYnpaV3VwRzYvODhVU2dkYU10Q0JxRTV1YlI2YjdIczlUbTZq?=
 =?utf-8?B?VG9BVkZrZHgrbEN4eFl2RDlpS084RDZpQ1Z1Y1A3S3VEaTlGc1NYTThwT2g1?=
 =?utf-8?B?NnZIZTQwbGI2SDAwTFRqNEtrQkFTU1BzcTl6SFlDU1VKbUdRZGsyMEdhUlFH?=
 =?utf-8?B?TVZQT0pIMXZkZ1ZHTk1sOFNwN2VTT2hvd1Rod3FVb09tRk1ubEpxYWdaL0cv?=
 =?utf-8?B?TDlVcFZVeUdaTGVsVUJqeThCTy9qQ2ZKZWJBM1dtUWxrN0Z1UjMwYms1cHZI?=
 =?utf-8?B?YTlJcVQwR0gyK1FtSWp2RUJIalQzVFJkQkVGSnMvOUVVV2pmRWRVcTV1WWRy?=
 =?utf-8?B?amRpOHBONkI0L1F3Q2ppczVQQXYzZGFNU0pyUmpaaFozYmtuZitoSms1Z1pF?=
 =?utf-8?B?TlhDMjFveGdXa2x5UE9DTnQ5ZCtzTWdYd1NwY1RRSlkrQWx0QThxOGQrTGRQ?=
 =?utf-8?B?NVRWaXhUR081TXJ0UWFLL0lZampvUlFETVIzTzVlV1hZMVRtcmcrbHc5eG5p?=
 =?utf-8?B?ZkgzWmEwTnBFcWEydlRsbHdlRXUzMEpVUEc0cTR5VUptVEg1L2phRlc5cUJF?=
 =?utf-8?B?cThVakVINm4vSklDMUdlMmxkNC8xS05FRjJRN3RQWkYwWDgwNVVBNlBFTnJZ?=
 =?utf-8?B?Z1BhZXUvRGJhanNXQnA2SVh3d3VmVVBFVjNHRDNheERROWNGSnl2MUpiTjV6?=
 =?utf-8?B?U3c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: V28ad81TJ8srIFAkQu+/JzIkV4xGZcy4aaJSUSuxgz2HqNpY3ncUhjp+GjJ+ZYt6HyM5mJvNDjJiIa2d3rXnUWrk39SM+e+mqltMXORGmXBPPUhQDmQsbMsaTW9L4iKyJ/KAyo2Jr7vf3mjbGPEmJuXe5lsjhmNQFcVRcdEJNSjytEFT9q3SxbJifjFUErlcr9IBNh3cZThZzYTXiYsiKbhvUbOflBQRVtUOstyGmRZHZwX5ADiypWloUNTThBhy/YFF+946kO2E7GeYO5ucRR0olg/NRFbRe9tZ2giYj2nfKkBFdWSrbQSqQabNOHheHlygJ0UtZMqu+ODzxkD1ejR8dg33CfSOFKazFXuTOkLGZzs2iXgljKe48IpYefzZL/NMSYvA3kQ84pjDVYr0VX80PzuKdCKAVFiUwjfTpHydTcP0XFuFsYV6wzKqRl+olujt/8lCOp56rgbl9Gu18Ue3+a6o5BnKSoi3bRg4TgY8UfVWaH2Jrb++5rAu786rZRfTVY65jl9SeWXC9J1gvCh1svzIP5pHvKUBy82T5Vkii6Nf2jhTsVI8+zyM/vXpzBFVAZTYVxfmw7lBGUBEET0rpxBOlOPcVsRLNaD0hm3gV2C3ME9iHbKzABB0LLtLI1HlGdo57VvdCBhKL/qa2un7RSYlIB3vVVxM9+QUwC10J9QUMuxIegp2sRTZ55x5olHbztU6ZnZ8wt8avSIuWcI+tw+raTLw8PttuUOfK1YHs3IA3WmxOfz6h6C6vev7Q46jxvvp47X9D/E72yt0U01CHZ30GGCZud84Y0cchHQtlv20HuE+HyplsYeARC439W1wYB8Ur/fdTU7OvW/lq9ndyRFrFOC4pDM/T+0/AnPwFUpIGCep8/TZH/mzJM3U2GVwWuKJGuHpQ7NtO+IZzg==
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 765acad1-67cc-4f5f-a01d-08daf577af7d
X-MS-Exchange-CrossTenant-AuthSource: MW5PR10MB5738.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2023 15:06:02.3182
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tkeJCAdW1ue1k6d2zbfMn4J/R33v/2aNWF9K3YJkmnFDINl5GRsVlFJQYUfeHgNlMNRoMZoZ4eMoBZ4QasOkxsSe15Cdgm/cQbSnAom1TtM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4423
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-13_07,2023-01-13_01,2022-06-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 spamscore=0 mlxscore=0 mlxlogscore=909 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2212070000 definitions=main-2301130099
X-Proofpoint-GUID: 0wthW5nqiXDbHHKmKxeqBBE0f9c2LEo9
X-Proofpoint-ORIG-GUID: 0wthW5nqiXDbHHKmKxeqBBE0f9c2LEo9
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/13/23 7:08AM, Harald Arnesen wrote:
> Christoph Hellwig [13/01/2023 06.42]:
> 
>> Hi all,
>>
>> A while ago we've deprecated reiserfs and scheduled it for removal.
>> Looking into the hairy metapage code in JFS I wonder if we should do
>> the same.  While JFS isn't anywhere as complicated as reiserfs, it's
>> also way less used and never made it to be the default file system
>> in any major distribution.  It's also looking pretty horrible in
>> xfstests, and with all the ongoing folio work and hopeful eventual
>> phaseout of buffer head based I/O path it's going to be a bit of a drag.
>> (Which also can be said for many other file system, most of them being
>> a bit simpler, though).
> 
> The Norwegian ISP/TV provider used to have IPTV-boxes which had JFS on 
> the hard disk that was used to record TV programmes.
> 
> However, I don't think these boxes are used anymore.

I know at one time it was one of the recommended filesystems for MythTV. 
I don't know of any other major users of JFS. I don't know if there is 
anyone familiar with the MythTV community that could weigh in.

Obviously, I haven't put much effort into JFS in a long time and I would 
not miss it if it were to be removed.

Shaggy
