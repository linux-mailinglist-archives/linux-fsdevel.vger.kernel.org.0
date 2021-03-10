Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 909CF334B3A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Mar 2021 23:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232907AbhCJWLq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 17:11:46 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:39260 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhCJWLS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 17:11:18 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12AM9ngT110576;
        Wed, 10 Mar 2021 22:10:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=Gdvld94VfL0US6i2llquUmejn61u0SyztP6kQiU88b0=;
 b=V4qzVrn1Gz0F3iAOcAJHuxiq102fhZvdOQcts5QMtHZjaYmAXFnPLg+2yk113uY8hr5I
 LhD5rkxNc/WvAYKQHYsDvwhVOGMO/suhNEytKtbkrD/d0yk0bHViu55W7XQAXIlgzfBU
 JfTnc+Y+/fX+cprPb7bhZ2Q4ac8tXoW15YNlxWdKGpyvxxvknT0saEtuszvgor4ad+jr
 gyuzQ8RsYppKub9cvERHOKMvb1bT52SZaK5j21p5kX/Q43xWh/Rip7YpJWEFjfyYLA9c
 crNpmWOZS9TIu+WoLN1xv0e5BUMlNqKB5kErpYoka6Z7TIhz3JmK+GgYL67+omi4656p kA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 3742cncmm6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:10:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 12ALtScR019397;
        Wed, 10 Mar 2021 22:10:18 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2169.outbound.protection.outlook.com [104.47.56.169])
        by userp3030.oracle.com with ESMTP id 374kp00v8j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 10 Mar 2021 22:10:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XDaEos5W1YNYNkbjZL6SWOih+QiOgEwaMTi1XogpfsjqnhlLCqzYnWc18e09EsD7JmJ2TOfRUbgY62qHWmfLQdN7z3gYedD88V4uWQ9WMkVoDRHJDpALTbzGkRH6CkXh+gfsr8RmAYrO3xpt/AOXNpT9dWzOLJn+gLIQmWmNyUm4Lc5IbfBpnTpQJYc+ZFQCr2r9CN2W1vh6vuhX7eOopzndRRcEqE0lXym4awJzgTUuC1KBotSHZtt0QimKbSql7ZqmvdYES9Rc48+PZjq1QCN2gVo9lBAXuuBQTHx0M0IH6O5B8m1OHkUx+9gtBlLOjjk5tfZOeCBlOhd6QIG5Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdvld94VfL0US6i2llquUmejn61u0SyztP6kQiU88b0=;
 b=lreVv0p3P+JGrjG1tRD79e/JdW5XzUoSU0TVge+XQgEDaxyBJBI+SRSrUBI1BDw6hCoSiwjkd9YkXTp14D0gRJRFFQXplYanGAeBYFlHLBaUc9mU+wrcNK63+cc3v209zhtFf3Mhw/w5bCVJjWuzx5buNEaMzkSazsxtPJ/qGGx7jRmY3zk/K1rMRMyJE5hrPRA2iFjVUVNlmVedf8+HUM2HIL3icKD4W4rp+44EGYca3KIu8UJMuuE8QUuqMKcRUHAgV5GSHa+8cwrmZ8lasSkj+LzHhtemFrmB5jbhBjoMtsh/FsJypA21uA/ZqE0YB6nwxCgjSXkWSd4rR9rnXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gdvld94VfL0US6i2llquUmejn61u0SyztP6kQiU88b0=;
 b=ohW07LcGYjDts7tRPjDZcNqN73iVr/2PrYzD3pYTQwz93AqO05BjkAa/K8d+Vi4NCBWxl7uju9o46QkFLhNyCbO+WzIUOFCJm7Hp0mYO7mFJ5LNVQvkB9U3CZsyDi3zrzDmR16m5a2AKiluJ1EuTef5t+dEFTP1iyGBS2scZkBs=
Authentication-Results: amazon.com; dkim=none (message not signed)
 header.d=none;amazon.com; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2949.namprd10.prod.outlook.com (2603:10b6:a03:8f::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.26; Wed, 10 Mar
 2021 22:10:16 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::980e:61ba:57d2:47ee%7]) with mapi id 15.20.3912.029; Wed, 10 Mar 2021
 22:10:16 +0000
Subject: Re: [PATCH v18 4/9] mm: hugetlb: alloc the vmemmap pages associated
 with each HugeTLB page
To:     paulmck@kernel.org, Michal Hocko <mhocko@suse.com>
Cc:     Muchun Song <songmuchun@bytedance.com>, corbet@lwn.net,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, x86@kernel.org,
        hpa@zytor.com, dave.hansen@linux.intel.com, luto@kernel.org,
        peterz@infradead.org, viro@zeniv.linux.org.uk,
        akpm@linux-foundation.org, mchehab+huawei@kernel.org,
        pawan.kumar.gupta@linux.intel.com, rdunlap@infradead.org,
        oneukum@suse.com, anshuman.khandual@arm.com, jroedel@suse.de,
        almasrymina@google.com, rientjes@google.com, willy@infradead.org,
        osalvador@suse.de, song.bao.hua@hisilicon.com, david@redhat.com,
        naoya.horiguchi@nec.com, joao.m.martins@oracle.com,
        duanxiongchun@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, Chen Huang <chenhuang5@huawei.com>,
        Bodeddula Balasubramaniam <bodeddub@amazon.com>
References: <20210308102807.59745-1-songmuchun@bytedance.com>
 <20210308102807.59745-5-songmuchun@bytedance.com>
 <YEjji9oAwHuZaZEt@dhcp22.suse.cz>
 <f9f19d38-f1a7-ac8c-6ba8-3ce0bcc1e6a0@oracle.com>
 <YEk1+mDZ4u85RKL3@dhcp22.suse.cz>
 <20210310214909.GY2696@paulmck-ThinkPad-P72>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <68bc8cc9-a15b-2e97-9a2a-282fe6e9bd3f@oracle.com>
Date:   Wed, 10 Mar 2021 14:10:12 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210310214909.GY2696@paulmck-ThinkPad-P72>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO2PR18CA0066.namprd18.prod.outlook.com
 (2603:10b6:104:2::34) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO2PR18CA0066.namprd18.prod.outlook.com (2603:10b6:104:2::34) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend Transport; Wed, 10 Mar 2021 22:10:14 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 7f383d7c-ca3e-4cb2-49d6-08d8e41148a8
X-MS-TrafficTypeDiagnostic: BYAPR10MB2949:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB29494671B01B97656478563DE2919@BYAPR10MB2949.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 2YXOoqLfU40tXM7SPren2wQAkLW9ln5OZ+p2Sm9jvOv/A4tWWKzvnBzVgTCmBr3ofTRuy/KfwzeNLmF9OC6wkpVyCXfGvp97eC3MJek69hulnO7yLh0gi4RhBHfQpH103ZGIa3GMBAcOlolYC1sf8qV6kyyCfgo4aRyOhLC2C9G075WcNKNBHRvd08eMNUhI/NiaISlH46v1G9hWtoVb9Lme2ks/SNXBIX3H56g/eRJ6JH1+VE29eyA1T2xXIMgeNo9c7q77ruTJM/42M9cMmHN1fUCPvM8+/+W87v1Zj7dhe8Nz4fLM2y+GmWkroh/Yf1BohNznCix+1YcK0g+gh20x6H22KxSXU6zlkXb/6IxjvuS3T2SF/Cvs5TR9DNrFjRBmeIxsJlXtqB143F04E1LcpOywVQ3OAOEitA5mt6X0vf44yCJ6LfzqWO8uO5zMbCRxxAGvm8RiF/V4ve+/HS4vLGfFGaUhM3CvvzuZY5W6XUsq6EeySaz61s0057YXUkn/zcXO+sMpH13h/duoLEKc8jCfYN1nmeFVUEBNEBt5WGSGKcx1E8+UtU40qjlUCxOjTzic//7WRiVzACZCCJjV/ufXUYsqXmkPVf701iE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(366004)(39860400002)(346002)(396003)(136003)(8936002)(6916009)(4326008)(316002)(36756003)(8676002)(478600001)(2616005)(86362001)(6486002)(54906003)(16576012)(5660300002)(7416002)(44832011)(2906002)(186003)(83380400001)(16526019)(7406005)(31686004)(52116002)(66476007)(66556008)(31696002)(66946007)(26005)(956004)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?S0d2ajg3UGd3eCtacWR4WTZSalFGeHpqNmI4ME9yMzAxZEc2NzRxdjcrVzhG?=
 =?utf-8?B?U3p2UnBaOE1qVGRwNlVNNGtEbmJPbGZUN3FXSFZxUXBnaGtLVkVpdVhseW9D?=
 =?utf-8?B?NDFGWEl2eWFmVGRyMkZHMjZTeFFsY1Jrd1JDUzJxMGtoTDBBWDEyMEpqd3lT?=
 =?utf-8?B?WnJYbS9TUWI1MU5uNjRPZjVoV0IwQzlnME1BelJMRllra3piNEY1WWlyNEMr?=
 =?utf-8?B?TmJwbHRIVDhyQ0hTa0o1SXZjME9vNCtDUks4Y0F2WUU1b2FrbFVIVm9iV3BM?=
 =?utf-8?B?L1ZUTmkyQWlMem93REVjNW9GTDdtek5YSGtmZ2NWT29BNGMydEo0NmxVS1ZI?=
 =?utf-8?B?ZGFuQUVFU1RDejZqaGFnQnVBNEZ5Nkc2U0FMSzJPaE1KcFhZMDNHb2VycXNF?=
 =?utf-8?B?NCtTZDlCY3Q5cWIwLzFwRUxjQ0gzanp3UEIyWmMvMGxpampvSEdSMnJ1RUlE?=
 =?utf-8?B?K3VKdjR0WDZ6Z3l3bGRFN2UzYWl3NDd4ZitBdnFRVXlpSmM4ZEpxVmpEand2?=
 =?utf-8?B?TkJ6bzhWWWdKVnVHQURMOHNpaXpoK3BRTzE0ck1qRlNYcEtQZ1dzMGxxU0Y1?=
 =?utf-8?B?VldHU0RuY0NKdmRCWFFLWkptTkR5MVF3cEtXTlhZU291RnRWZFRJUXNiZTd0?=
 =?utf-8?B?LzhQdVBqS3prbWJIK1VSWlBBZGZZTm5tWHVnSGxWNkZ4QzFUNnFnMTFGWEdq?=
 =?utf-8?B?a1lHN2VZQllPZTg4dUNVcXE5aVhPRXpLNUZTS3FpL096WDUyUEZWMnlTajJn?=
 =?utf-8?B?VlJSZHNkYmVZa25KaGMrU09Qa2huSThSendxdFpIbm9lWWQ4K3ZNM2VpTE0r?=
 =?utf-8?B?L01McHpEb3VXekYvcXFPRlRkRnlrR1JCeE5TWm85YXBsWURvazJkSkFDZnhG?=
 =?utf-8?B?L1JzMngwNHVPNE1odUJyNE9YMEdtWTdTNXJrNEIyMWFFNTBGKzRscTNHTWVp?=
 =?utf-8?B?ZnBSbXhteisrOUYwNzIwMHF1VTlSUmN5YlF4eUp6dnFPT3B2MTNTcnQ5MkxX?=
 =?utf-8?B?UXFFYmpVRXBZOVJuZGxMTHdKeWVTejI3Y0xrdzUwd1YwQXZxRlJWdTlVa3B0?=
 =?utf-8?B?WGs4emJPd01CWEJqSUU1QVdqeDBUdEIvencwUUNYdnRVc1hrenQ0Y0ZBQWp0?=
 =?utf-8?B?enhrT3JmWlFTbGFoY2JiL2xhR2svNlNicTZ0bUF6MmR4WCttOTNaMWxkUkhG?=
 =?utf-8?B?UVhlT0pEVXQrczBGejkvNHpzazRZc095TDJ5Q0c1a3MyOHdoNnZnc3orZDZY?=
 =?utf-8?B?TmtYMlljR0l4WjNBakdlV1dTV3VNSUhkcWVPWFhsNWEyMGhaWTNxemFYcTBj?=
 =?utf-8?B?K25YUDAzVDVFQkxmd3dhNVgyOHJUQ09lMFE0V2tobE9rU1JqSzJOK0NraEtV?=
 =?utf-8?B?U0tLalkvQkV2MGJvMkNRK25KR2V6bGRiWlB6c3d6SlN3RWY0MWI2WUFienRN?=
 =?utf-8?B?aUc2TGJwekd0Sk5KNHlnTnVidGpzWTUrendtRkNtNkd0VVFTaGVMY2x0N3Zp?=
 =?utf-8?B?em5hakJHbjcwSWFvbnBjeGREeStvdkpaYllDWitPRkp0Lzh6OWxlSUNObTM5?=
 =?utf-8?B?MUNwOXdsZTVadVQ3Zkt4WDh1a3BYQkYrN0xNUjExVCtDWmV1SjBtNmYyT3g5?=
 =?utf-8?B?N2I0RU5xSm1nbjZPVm55MmdwVjZIMG44ZE1YaWc0MVh3UXlBN3lQZG43anZz?=
 =?utf-8?B?L0FvNVhLUXo1MkxZelZ5YzNLL0NVdm9TODlEQkQyZ0FqbjJrci9BVGNycUxK?=
 =?utf-8?Q?751rQZx4UgHopCNVgYHsMVybC5LEuSe62AHNS/A?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f383d7c-ca3e-4cb2-49d6-08d8e41148a8
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2021 22:10:15.9890
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HD2s+uzBNMyGUZLeLUZIUV+kZ/KDp7CrYXpwNjtghJoaWFGTUEx/3CEz4tD1CO3k/ahJCxgEs5BFMpwCwdcr9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2949
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 phishscore=0 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100105
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9919 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0
 clxscore=1015 phishscore=0 adultscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 mlxscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2103100106
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 3/10/21 1:49 PM, Paul E. McKenney wrote:
> On Wed, Mar 10, 2021 at 10:11:22PM +0100, Michal Hocko wrote:
>> On Wed 10-03-21 10:56:08, Mike Kravetz wrote:
>>> On 3/10/21 7:19 AM, Michal Hocko wrote:
>>>> On Mon 08-03-21 18:28:02, Muchun Song wrote:
>>>> [...]
>>>>> @@ -1447,7 +1486,7 @@ void free_huge_page(struct page *page)
>>>>>  	/*
>>>>>  	 * Defer freeing if in non-task context to avoid hugetlb_lock deadlock.
>>>>>  	 */
>>>>> -	if (!in_task()) {
>>>>> +	if (in_atomic()) {
>>>>
>>>> As I've said elsewhere in_atomic doesn't work for CONFIG_PREEMPT_COUNT=n.
>>>> We need this change for other reasons and so it would be better to pull
>>>> it out into a separate patch which also makes HUGETLB depend on
>>>> PREEMPT_COUNT.
>>>
>>> Yes, the issue of calling put_page for hugetlb pages from any context
>>> still needs work.  IMO, that is outside the scope of this series.  We
>>> already have code in this path which blocks/sleeps.
>>>
>>> Making HUGETLB depend on PREEMPT_COUNT is too restrictive.  IIUC,
>>> PREEMPT_COUNT will only be enabled if we enable:
>>> PREEMPT "Preemptible Kernel (Low-Latency Desktop)"
>>> PREEMPT_RT "Fully Preemptible Kernel (Real-Time)"
>>> or, other 'debug' options.  These are not enabled in 'more common'
>>> kernels.  Of course, we do not want to disable HUGETLB in common
>>> configurations.
>>
>> I haven't tried that but PREEMPT_COUNT should be selectable even without
>> any change to the preemption model (e.g. !PREEMPT).
> 
> It works reliably for me, for example as in the diff below.  So,
> as Michal says, you should be able to add "select PREEMPT_COUNT" to
> whatever Kconfig option you need to.
> 

Thanks Paul.

I may have been misreading Michal's suggestion of "make HUGETLB depend on
PREEMPT_COUNT".  We could "select PREEMPT_COUNT" if HUGETLB is enabled.
However, since HUGETLB is enabled in most configs, then this would
result in PREEMPT_COUNT also being enabled in most configs.  I honestly
do not know how much this will cost us?  I assume that if it was free or
really cheap it would already be always on?

-- 
Mike Kravetz

> 							Thanx, Paul
> 
> diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
> index 3128b7c..7d9f989 100644
> --- a/kernel/rcu/Kconfig
> +++ b/kernel/rcu/Kconfig
> @@ -8,6 +8,7 @@ menu "RCU Subsystem"
>  config TREE_RCU
>  	bool
>  	default y if SMP
> +	select PREEMPT_COUNT
>  	help
>  	  This option selects the RCU implementation that is
>  	  designed for very large SMP system with hundreds or
> 
