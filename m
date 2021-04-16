Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 769843629F6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 16 Apr 2021 23:11:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238075AbhDPVMD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 16 Apr 2021 17:12:03 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:44360 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235809AbhDPVMD (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 16 Apr 2021 17:12:03 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GL3af1041733;
        Fri, 16 Apr 2021 21:10:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=SaC5wT/DqdGUuFSNKNgY5+nTr4bAxWaTayv0GzArMng=;
 b=lItUucP4D+SYHk0xrdaZ4aMB2wtAZ0sQ6q13NxaSFFn7DqKzt4nEHVzHokAIA1UQqKe6
 EbSbS/ppC2MIXGxWTowXog6Jg6Rj7GhQ6ELT+ebmfY/H3ZaSO7EEn/vmqD+PRY+5PcFx
 twdivQbBzKaXYU13ppPOA+FFPb7TnLahdSbNv8sWE08C5+HHznf29OlGJdLU1uMG4yMA
 PiCZcRt89I3WLL5QTLAG8NLGgEqtsjLNiMWfmrHC+qpJLOTGgqV02lIQ9ztLVDBCqnnp
 zCNshIy0c4/G2E+MlQ1Z9649373ZkFUI3cdfyo6X5mRTX4hD5VmELgP/6Vtn4bN7Hn5C ow== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2130.oracle.com with ESMTP id 37u1hbtfte-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 21:10:46 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13GLAfS0167580;
        Fri, 16 Apr 2021 21:10:45 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2171.outbound.protection.outlook.com [104.47.56.171])
        by aserp3030.oracle.com with ESMTP id 37unkuqkd0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 16 Apr 2021 21:10:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JfyMg2rI/79TO/2VmSo/mKVsXT4SkWQPtY1OQLqh8QvtdHfN1XlSmAC6Rj2eTpEgOcrHW2zm/c0TwXQBVavLnJR9Aa4XEo9I3daOfioXDGraboAqPLP779OTleGe9eZc/PfQrRjg4dEY5v0QhZdpKY92ea+bN0m7Rt2ZeVrhtxrTg+fHHK00jTkH4gBVvHxZh57zqVK42QCCLujH2i+wWvT1AaHU302905glyYHwcj+LD94Y44N9OdUfx0g1exb6CzLvgsSDJsGDiCWMxpBcbdBkYbe+VGB5juPYckbVeQyrMCS5A7gpGaTtSppDii6LFARi9oy7++ObuBhIF0adBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaC5wT/DqdGUuFSNKNgY5+nTr4bAxWaTayv0GzArMng=;
 b=Ri2Ih1TiFIA+gEhU371upAiGmCOKG4eQw5EgWlxb9bfzZk7x5VCsRbjCHCkLxKXH31mT5wQFLPpnBBdMpfQIj8x3jpo777cFcsdTx9KIsTxQvIK7xqk2OW3NeSZQZKBaNUmXuwHyfMgAkJMJ5e5p1XSCpEfhMXBKkbcSvbL9vc8DC3qF/vT4qh48ONlIIkuy7my+QmAiIbUqEC71YcLLkBdFpvTXurr4Lu6qSznSd2QEu8kALRuKJajhjEMkjsbto6dMBsRzi1jj6nTbQdYbLNsx8afCX4lMe4FkZ7cj0jImpONoP1GbD+/LXm9a9woL/hH1rVdCbMAdDts2sz7ghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SaC5wT/DqdGUuFSNKNgY5+nTr4bAxWaTayv0GzArMng=;
 b=tXac3I45OG6EV3Ct3FVETecQgE8J6Syp3FrsdNumTXGC/1hL9rE3x2yJLj6Gd/ITnZiqEV7BmowM47v0ANfqcTG8HwWOG1tqqjGMP0QxOe6niHG/UeTJXpfgtj2Jxv0LTC7HtYuiVKpvnPhAzShRCPyZ1qAB3qWNKGTvmzl5KJs=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BY5PR10MB3970.namprd10.prod.outlook.com (2603:10b6:a03:1ff::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4020.22; Fri, 16 Apr
 2021 21:10:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.4042.019; Fri, 16 Apr 2021
 21:10:42 +0000
Subject: Re: [PATCH v20 4/9] mm: hugetlb: free the vmemmap pages associated
 with each HugeTLB page
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
        Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210415084005.25049-1-songmuchun@bytedance.com>
 <20210415084005.25049-5-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <602af5f8-f103-438e-d88e-2819404b9dab@oracle.com>
Date:   Fri, 16 Apr 2021 14:10:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210415084005.25049-5-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: MW4PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:303:b5::14) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by MW4PR03CA0279.namprd03.prod.outlook.com (2603:10b6:303:b5::14) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4042.18 via Frontend Transport; Fri, 16 Apr 2021 21:10:40 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 61998f90-22d4-458e-d574-08d9011c17de
X-MS-TrafficTypeDiagnostic: BY5PR10MB3970:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BY5PR10MB397005D75C2016CDBFEC2BA1E24C9@BY5PR10MB3970.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5797;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: b+1JrReQA+73t/mvhzR04HV8lqEvaZHDdbwD77F0ydjqcj/2a2+B7tVWfvpiXp+2TjZ1GpqxLIxm3O+1YSLAI0P2Hqsy7y+kDB9OgIEyBuifslMqK6VccJCXmsMDG/eevysiBwJFNBlXw5Fa69KNicYXFyilJtOtFO2pCUOLDAsuhgOHOGaEu3VflQH0VFhXdN85/ran2BA4Bm3Qc+dtxmXgvNCaInWt9vb7owedMVBUMcGTtrc8CehsO3DUFm9Ei+w6ObqEsY0YSxiFKkq6Gk5xDX6v32IVKsBXOcFZFoTxBxzzEGvmkohHFP/yj4jqSkUakSD2xyUVd3QDV15o8jifOhiFFS5AmNRtPYyLcW8VNqe0D6bWRm4jP0qRklER1LYeR7S3+/qKRWXB47E0HWjt0xEYCea+aOozfKhLpvwUrva8Zz+05WlSBaya42jEnFlaLp+s1ib7wIPK3HbbL/zPwX+ojAVcB8ndUgz/nhwT43ysWrW3clSn9b6UIFpjJL/+sZlZpCYjeGU17AKsxCWu86p1NIzKjQFFJDg4GpZDHizP9jTSt7cAPW9Wl/X4+dWnVBhcTBilewsM3ZV9MSDgksgU5Rplgq8DuFHA3rf9ql5UV+1Ad/iiqcb2jGni87+gYKRw78BeZYWNVirR3kVIn3YFRcCkKSJSv2MMpWbZ5Jx4ojQIxuVxmdHAPaAEYKSkfJYA2oPANRCEfpKb+11+L/MoKMmjqbMZ/L/o2cI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(396003)(136003)(376002)(346002)(366004)(186003)(54906003)(31696002)(36756003)(16576012)(316002)(26005)(2906002)(8936002)(16526019)(86362001)(6486002)(7416002)(7406005)(31686004)(921005)(8676002)(5660300002)(38350700002)(53546011)(44832011)(6636002)(2616005)(66556008)(956004)(52116002)(38100700002)(4326008)(66946007)(478600001)(66476007)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S2VSVjhhL1VWNEJNNVB6UEJqaXN1KzBSY0FVc1FiTXpCMmQ1OVdjRTgwZXk2?=
 =?utf-8?B?SUVIN2wxa3lZQ1EvcHcwclpuUHlVNUp6Q2JwbEptVUs3RE83bVdhcGQ5RThO?=
 =?utf-8?B?SEZ4bGhITWlkSVZuSC9LaUtLUk5XQnlETk4wcWc5TjFXZnRXSVpHSWQrOURG?=
 =?utf-8?B?ODhEYjZLaGpzTXRZSGd1dWVzVlYrMUx2ZnR2WFJLN1dKRXhRRzl4azExUFhI?=
 =?utf-8?B?Z1JDanJDRFFCMVdWNUJJQ09zdjM5MTVwVlNGQVhIaHRRWVFwaWxBRUZSVlBU?=
 =?utf-8?B?UGxZa3V4YSs0VUhUY1RGVWFzdzR0QWsySUttdHJWNFRnN2U3NWgxWWdGekVS?=
 =?utf-8?B?VUlhZFhrMkdWR2NhUGVXRGQvQzNXdGRYQVNLbFpJQ3J6SmJraC9zRTRZelNQ?=
 =?utf-8?B?a2MvMkpXK1ZBYjJBLzVoSzJmSG1vSDFscFlSbm5ENUxIOG5QWnZxUDFGUGo4?=
 =?utf-8?B?L295bVZySUNJYTJreDQycU92S2txempvL1FLWFlRYWFSazgyMFdrMVRKWHRB?=
 =?utf-8?B?di9Pcld2YVdmMkdNRGQ5ekMzQ1d2ZTJiNGZBVWZKbGJRUFZ0VGZHMWlLOXJk?=
 =?utf-8?B?YTUyc1J3d1VpNUpJZVlBOVV0aXlrTDMyM0dPeWUyZFVGdGZGVDV3YjFIMWhl?=
 =?utf-8?B?dm45TjFCUG9HaUY1RTUvTUpXNkcxUkZhL2JOZlRucHgyQlFEbjNveXNsQlY4?=
 =?utf-8?B?QmxhYnRSVWgzNkVNQ0RXNzhWODhYL09pSXVGSlQ5eDgrSWpvNTFkZnFaZHJD?=
 =?utf-8?B?alNJTTVublhDaTQ5emxhLzBDL2c1TWNndzk1dVBmekJ6RUtoRjZtdXVuSUFT?=
 =?utf-8?B?Wk1RQ3RVZUJEVWVwN2huTnRTZHdLWEwrUFRGZHdraDJkWnIzV2hNYVVUN2k2?=
 =?utf-8?B?bWpYd1hVYjlXSSthYk5FREMyR1NUVGFvYThmRWIrNFRicWZCbDU5aUZIUVhG?=
 =?utf-8?B?ajFvTDc3ZkZ1ZitjNHZuNENhQXVzai9Ka0c1NjIySjd2SEdjUTZrdDZ5TTJX?=
 =?utf-8?B?a1pVT1ZRNE52RHg0eW01NUEyRDUwUTJsaHdmRSt5Zm1qUzVLeVh2R1Y5ZGxX?=
 =?utf-8?B?S0pGZGxMR2VseExFZ1E2RGtUeXBsYUtmRzZUQkY5K0tPc1VXb0NjVElWVEdy?=
 =?utf-8?B?WWIxN2RoL0U4aDIzRk1HaUFkcnR6Q21OUUJXZUZsYTVwcXFRcTl2NkczdGV0?=
 =?utf-8?B?d1c3eTlzNmk4UlNZMWtaOWQ3b0VkNzltUEUvQUtyV2h5NE5mWGdieCsxa3JC?=
 =?utf-8?B?R3pKRzQ1RFdJQ1JKdkhpK1dnSVNCSWtlZ3JmV2JEamZJWkdITEtjRnB3cGhW?=
 =?utf-8?B?c2FJUVRxK0NVeTB6WWtWTmFGczRKUUZvWlJCR1ZUWTBZcnc1QzQvZGVDd2p1?=
 =?utf-8?B?ZFRXc2FZaTNVUUMvdlkxNmdHRk53Tlc5STd2Vktlb0N2L1c1S2ltK1ZvSjM3?=
 =?utf-8?B?YVZCbGY1bm5sSkYrVUV6UkNRVzRoSzlabzhUNDVYRGxLU1JrSUI2MHVMbXds?=
 =?utf-8?B?NWhiZnlyMzB6bkFrMExrRWs3MVNrWW1sSjR1aWN4Sm8wTDZpYVBJWjhGL2d3?=
 =?utf-8?B?MDRpUHFwNE5MSFpWcWYzTm5uQlNta0hZNFVDTTV0MkkvakdWQWFRVzVWUlk1?=
 =?utf-8?B?Q2w1bEI0WEd3dWYyUW5iWGwxTS9TQjlEdC9JT044ZUk5Mmd0YmlMZGI3K1dZ?=
 =?utf-8?B?N1BOSXVFVFhKRzBVeEhKMjNSeWc4ZWYwd3VEYm02d3BSVCt4K1NYNFh3Vmo5?=
 =?utf-8?Q?mm2tjnK70ihB92q0AeUR6MLo8UcTcABCaVb3n7K?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61998f90-22d4-458e-d574-08d9011c17de
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Apr 2021 21:10:42.7080
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VrtowJlLrqNAp3sRlfd3qFtg0g3ratfnZ3ca+Uiqq7XsjsQXhB3kl7kt2XoQV+mms934wL6+AmhrxbfkVLmeNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB3970
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999
 adultscore=0 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104160150
X-Proofpoint-GUID: lzMg4P_AXRBmTLk_6KC9wYJiI1FVnImW
X-Proofpoint-ORIG-GUID: lzMg4P_AXRBmTLk_6KC9wYJiI1FVnImW
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9956 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104160149
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/15/21 1:40 AM, Muchun Song wrote:
> Every HugeTLB has more than one struct page structure. We __know__ that
> we only use the first 4 (__NR_USED_SUBPAGE) struct page structures
> to store metadata associated with each HugeTLB.
> 
> There are a lot of struct page structures associated with each HugeTLB
> page. For tail pages, the value of compound_head is the same. So we can
> reuse first page of tail page structures. We map the virtual addresses
> of the remaining pages of tail page structures to the first tail page
> struct, and then free these page frames. Therefore, we need to reserve
> two pages as vmemmap areas.
> 
> When we allocate a HugeTLB page from the buddy, we can free some vmemmap
> pages associated with each HugeTLB page. It is more appropriate to do it
> in the prep_new_huge_page().
> 
> The free_vmemmap_pages_per_hpage(), which indicates how many vmemmap
> pages associated with a HugeTLB page can be freed, returns zero for
> now, which means the feature is disabled. We will enable it once all
> the infrastructure is there.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> Reviewed-by: Oscar Salvador <osalvador@suse.de>
> Tested-by: Chen Huang <chenhuang5@huawei.com>
> Tested-by: Bodeddula Balasubramaniam <bodeddub@amazon.com>
> Acked-by: Michal Hocko <mhocko@suse.com>

There may need to be some trivial rebasing due to Oscar's changes
when they go in.

Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
-- 
Mike Kravetz
