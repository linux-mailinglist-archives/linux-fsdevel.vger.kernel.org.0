Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9217A362827
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 20:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240255AbhDPS4g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 14:56:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:39670 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236029AbhDPS4g (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 14:56:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GIn2d4004432;
        Fri, 16 Apr 2021 18:54:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=fr/d7yw8Jal51eTRkry/V6G06QGd15CZ/Me4jA4xMb8=;
 b=FB4Ilbjub8G4FlDEIKIecUB9rL5UaGb42xJ4KmH4OHQ5J9+Q7v7uTOaJDeWjoRnTZprR
 r6lQlY8ElmhQ1pLUYRZE40mTptG3RaMfbE+kqDY2HXk8+kqwC+ujpTwWeYI1f76IzxF2
 uwHGbsHzB1jQLxuF2q4KSSSjPz3jgiVtN6BBS1TD83++8+AcIjw46bXixT/XxCFRbrkq
 P8k+VkytbvB9C552XUZr3hWRGl7DpwdaZVan6bUBzyj261ZbZ/x0HQSAX5W8/Fuzqo93
 mjM7UQAqqwfLHdqFr6uIqKRVGb+NBi5FeXK4pgZyxk9QCIsn7dGwi05S2w+0T+sSPohA Aw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 37u3ymt20v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:54:32 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GIogms081901;
        Fri, 16 Apr 2021 18:54:31 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by aserp3030.oracle.com with ESMTP id 37unkuk97t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 18:54:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mURFLafMD1JDf7u7T9W6YIjhwzs6ehDMwi4Xy0bOKUs31oKjmssKbLU2CG7X+pqQ457TAFOsLzWihtk1RbGOrSwILsJGstFpnRcE9rF1eVQOxi4asTv1mUjrr05oFkgMiOiOk5hl6DI45Edy6BsclLzHJpTEkjR7s1swV4MFTtZpWrgl/ZU7HIfkL0t8m+BgaLaXusSUktevStfa25+WqJAjtQbWkItPHzhVC57vvznxO4RyxpEo0VSj9ACV5J5Mpy3S4PPOddrv5jaQzDc1a9RR2HtsfgI7jjvRndQ0phNgB2wZ3gxL5MGC1UY48Ag12t4OZg1ioEoqfAA8RWeEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr/d7yw8Jal51eTRkry/V6G06QGd15CZ/Me4jA4xMb8=;
 b=m5N0bDoImTpqKMIOJM/5RuagUsPTarhZGl7x1G9dTbzB+OytuqgoxvqnWgf4uYF4Odf+F2lMP1RIMZVbG9mMD0ZNK2VeVpK8SPxMesuDhymI+zPFULyG7XmeZU+c5l2xYxrNSGjJAVMRzNqTDIZlwDf2uvbySP/q9QGkkGV0ImOwIVBbX+vJ/Kr3qDiKZfCpcT5G7kfdGrtUviH9AEQcg1NUs3WN6wv2duoCd459f4gIVV53kIakZ3OP9HDouIKG6stCBXYBgtytMQ1ad68lBNYXDprV+//5jeUhoAn1Twv6f2Bof3wwEcOvn6ZUzm0fXoXTX1TKHDV1vSIKreyoOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fr/d7yw8Jal51eTRkry/V6G06QGd15CZ/Me4jA4xMb8=;
 b=GFLJiFp27dGRSOT5aE0hjHriATTjwvAMnD8k00f9S8TQ5F/+bX0FtCJ+h+y0aT+rqb6wy00mUuJ6GTqRP6O8oMc1ZCF+uGLSCCWwdnE447bqUBWza7r9Z756zx1ASkOu6YqQr1+HKmv4mE4ddrsbc/fhxWTKoNbc8jsklZFvTIQ=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3908.namprd10.prod.outlook.com (2603:10b6:a03:1b0::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.19; Fri, 16 Apr
 2021 18:54:29 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 18:54:29 +0000
Subject: Re: [PATCH v20 3/9] mm: hugetlb: gather discrete indexes of tail page
To:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, paulmck@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, mhocko@suse.com, song.bao.hua@hisilicon.com,
        david@redhat.com, naoya.horiguchi@nec.com,
        joao.m.martins@oracle.com
Cc:     duanxiongchun@bytedance.com, fam.zheng@bytedance.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        Miaohe Lin <linmiaohe@huawei.com>,
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-4-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <da62c232-ba9f-c7d8-a552-0bf3b28d905c@oracle.com>
Date:   Fri, 16 Apr 2021 11:54:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415084005.25049-4-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MWHPR17CA0066.namprd17.prod.outlook.com
 (2603:10b6:300:93::28) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MWHPR17CA0066.namprd17.prod.outlook.com (2603:10b6:300:93::28) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.16 via Frontend Transport; Fri, 16 Apr 2021 18:54:27 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 33a0fefd-7f88-4da6-1648-08d901091018
X-MS-TrafficTypeDiagnostic: BY5PR10MB3908:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB390868680613F8C626744367E24C9@BY5PR10MB3908.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6Syul/0LzMfeWAZt/FiwpRfn8s4loeBVH5m270iWf30DBW8+RrqV0J3W36fb9E24S9J58p98ssGkGoq0Uk1fvHAXbPLjpKZqEnRRvGz/elltm4R/XvICm9/2bRJsDyS2v/CC9lz9tA0wsd0B5TkwOGRJKAM0Uez2Nq/tkUG2o4Sk2g57xh4IkrMXAbJmUkf3R0lASmlPpfR3SE8s75IeMKQClELzdjc6EouKaGyWv9shhQzznEOdrm0n2XRNfwjWgF+GjPTzcUK9v0FpnXItih2yCQ9GYjXxDZF7JxjOuugK22wq1Lf9x18UFbEfnD9I4icR9J8P6tsikvZ8v4A1i787CscxhJTMoqEskveA/ws3JxJSB4fE5fpYRs8WPTs8eq0WhTaafAYK3QH7ZZRkQb7M5s5qwqL3tNTVmX9iIKYBnIV5ilX/HRfE5pmGazD/HM0qf3fkXFbpTYgTzFPxRcI6F4ewWFpDULQRJ7WnZ0AyGJUMMEC7Xd53qhWM3mtxL66i4Qj18WaQom6D77Rru8sBx8/XrmvDxhaJt8odtxx3AezT6sHrcR/BHgV85/qWdwS5DINeTqnq1iOyJzKvIGqk6bqy6uJYaq/NWKBY8rtQGoH3bzof+i3rhp/l/XZ/Tkogah8kB6d2GU+JFTm/pXUeHSie47KFzWmNFOXw2HtHptWsqjwmeRVLnE9wKirQr4cck35CJuCbrfH6Jskoo+hwhbJr+Zr1UUFh6uWdP9c=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(366004)(136003)(376002)(346002)(6486002)(186003)(86362001)(31696002)(921005)(54906003)(4744005)(8936002)(36756003)(8676002)(4326008)(7406005)(6636002)(53546011)(2616005)(26005)(66476007)(83380400001)(44832011)(5660300002)(956004)(2906002)(31686004)(16576012)(316002)(38350700002)(16526019)(52116002)(66556008)(7416002)(38100700002)(508600001)(66946007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?WHpzZ2pHdE5hZ08rMmR4K3dyNUxaNUdJaGMxeFQvQXVvbUczWmV2bFc0dmlk?=
 =?utf-8?B?eGdoR2wvMy8vK1lEcFlLNGFVeHpyNFF4eUlCM1V6eUREemJzajBNUURqSWJM?=
 =?utf-8?B?dHZlMkpDUnFZTkkycjI2Y2tOakx1TWtsS2pFTFB4VWt0b0ZJOXJBeTAyTU9G?=
 =?utf-8?B?SWVnSVJBNmc3YUNFUmJ4TVFZWEJrRnpzdmRDa0d4WFFVTHJKUGZTbnNHTkx0?=
 =?utf-8?B?U2lLOUtWTEJyRHB2T09qdHg2cERkNG9lYmlWRnhWdXFFZXEvN2tUVm84Rnhk?=
 =?utf-8?B?NnhaQm1vWDRUOWdVcGJrRFZZMlo0VFVXaS9TTy9md1hwNW1QRmxhQXBIUzBN?=
 =?utf-8?B?Umh6cEZtU1IwTFJEYnhCL0ZEUTYyYWhDbTNDbUNleFhDY0Z2aW5kdXFiM2dm?=
 =?utf-8?B?cWJrNjE0ZW14blRVam9PNXVLSlNCTU5RUGhzRS8yK3A3RFk3WEVFWUxBRGpy?=
 =?utf-8?B?bXIwRnpwLzZveGlZeGZiQVpFU3VtMTVIOGVCczVWSnFsTDJjMDY1d2pDQUtm?=
 =?utf-8?B?NzkwK1lEZGlyeEh4Y05ROFpMbzc3Z0NWWFRVR2hTYU54SSt0andRMnhseHhv?=
 =?utf-8?B?SGVKdURuVVNNZTJ5cU5BS2NkQXBmTTJ4NGdnUWVTUWJUNkM2bmc4d2Y5WExh?=
 =?utf-8?B?TGhjdGFRUFlUNFo1ckorcE1Sa0RzTFRtV25HblpBcDBhOCt4SVF1Mk9ZYzJp?=
 =?utf-8?B?THJld1gyay9nNUJIMXVFVkxGL0VaNHNzZWF0SlFuZFFlTWJoOWsyNjd2VVBH?=
 =?utf-8?B?bWo2WSsrOTJGVWc5Tk5xcXVoQUxQSVMyTXc0S0Ewb0pzSC9STHNDbXo5dU8x?=
 =?utf-8?B?Y1Q2TzBiMUVKeUkyLzBqQXIySDlHSXVKblVHeGJhbElha1ZZMmMrOEVPbkVh?=
 =?utf-8?B?Tzd4eEhjdzRPRlh1a0ZwRG0yRkdxUmdITHFIcVBsYVQ1NUZ6Qi9Bb0pRcndJ?=
 =?utf-8?B?WG9vVVNoZzNNemtJbUJvMy9wbTRmaS95UnhaNVdySEh3ZWVhZ3NZZ2RLTmhF?=
 =?utf-8?B?L0xxWmFWRW05cklMOVlDYWRLMVJLQWpnaUpTNC9oZ0dkV0grdFMxOEkyU2tl?=
 =?utf-8?B?SzI0L3crYkRvSzNjVXlGNldxRER4a3RFaXRESnM2bFJkRCt2aGRkRkxIaHhG?=
 =?utf-8?B?NzYzeVR2bGpQM1ZianNZYTVxbmNhbkNVV0gzUy9kcTFrNEw3S2xDZ2N5YTNz?=
 =?utf-8?B?WTZOK1RuQTJGZkp2RGY5Nk1xS3VHMUhSUEEwN3gxNXBYT0hiZERUbWtkaGhG?=
 =?utf-8?B?dWVDeFMvcWltcHFhNHdGRS9SY2pyRmU0Z3hyM3daakxQMzJBOHpIQ3pCeFZ1?=
 =?utf-8?B?RkkrYlFwL21vTjVZSGNaaENodmdvMGt0c2wyOEdib2I5bEVuRHVBampPWnQv?=
 =?utf-8?B?c3dlaWtjeHJ3YjZOUEE2N2MyOGVqWS9uVnJCc2hXd0lkcndaUHUvN1poRElx?=
 =?utf-8?B?WGFtZjh4UUQvZDkvMWFKU0EwNHJValRsaWZENXc0NHEwSzVlN2MyOG1BUWlM?=
 =?utf-8?B?UFFqVS85eEFoZEt3aVFTT2d1MnM4TUdBL0hMN3gvZEgwdjU4ODMxeHhlZXNR?=
 =?utf-8?B?V0FwRVNwVU1CaVRwTWN0WjQ1a3Z6YVhmUUZQbWYrN2xOZXF2WWZ2eFloVGZE?=
 =?utf-8?B?MVRrZTVkVlZsdFpqQXJsTGRad3hXaWlpa2o2MWFlclFGNUdSS01YT0JhTlF3?=
 =?utf-8?B?QmZFcTdqcUZiM0pRNW5Hcjh1RzZXZkMyQkNOUFRXWFpYZXpkTklxYVZkZVJ5?=
 =?utf-8?Q?7LmAcLlF0ScLR4yCmsrQkk1hBs2rWeTQP2PVy/g?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 33a0fefd-7f88-4da6-1648-08d901091018
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 18:54:28.8970
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z3N6Ubo1D2uotiEvtiAx6+0nSeVLffvS5NToCy4JlMQhBfzD7YGm4ZTCDTZg1GtkFDSMcH5Ew8iTgLgMBL4/jA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3908
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160132
X-Proofpoint-GUID: C0FOTSDO_aDAkjSnaTYlIyFwt7xSO1IS
X-Proofpoint-ORIG-GUID: C0FOTSDO_aDAkjSnaTYlIyFwt7xSO1IS
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 malwarescore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160132
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/21 1:39 AM, Muchun Song wrote:
> For HugeTLB page, there are more metadata to save in the struct page.
> But the head struct page cannot meet our needs, so we have to abuse
> other tail struct page to store the metadata. In order to avoid
> conflicts caused by subsequent use of more tail struct pages, we can
> gather these discrete indexes of tail struct page. In this case, it
> will be easier to add a new tail page index later.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Reviewed-by: Miaohe Lin <linmiaohe@huawei.com>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

Thanks,

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>

-- 
Mike Kravetz
