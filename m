Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AA36E363
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Apr 2021 04:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234904AbhD2Co2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Apr 2021 22:44:28 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35432 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbhD2Co1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Apr 2021 22:44:27 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T2drUK121252;
        Thu, 29 Apr 2021 02:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to : cc :
 references : from : message-id : date : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2020-01-29;
 bh=BscS0ahT3xpi1+GPMmqI6O/b0AXQhB6B6E87fTaauEM=;
 b=IF43v7C92+0xAzLuAiObeCxclJlXPp2E+qAgU25IMyxQh76dM373bkLxJLLSySb0lpBn
 m5uwApVzG6xDRIPBNPgZTLN78hvpXsellA5qHYTP/ab65McRUlY/OrkA1cMggjQN9DSR
 eSW+7/Zpw2bRgrBSitwxrolcPN5Aalirow30FLXymLknPUU6dOnNuX6rWZNfmSd7Rta6
 Mne17eWPzsZA7QtmB9oZGP9+vDBHHcbWSK/on7xKnHnTUqcZHc93dEs/WBUAIcZbMSkF
 /Sgwm8Au+ng3TfPOu6Ekf4QpYbkF8c0SvrBcJh2CpSFx0C1+hNSTejDH4xYNwx3KJzs3 JQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 385aeq2ups-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 02:42:49 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 13T2dqMP145192;
        Thu, 29 Apr 2021 02:42:48 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2175.outbound.protection.outlook.com [104.47.55.175])
        by aserp3020.oracle.com with ESMTP id 384b59hrrs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 29 Apr 2021 02:42:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=a4oLRy/hIOUHKtC9mL00H7ZKy0pjyOyje+hIXHnoD1+CE8zx0ACDkRpIeKKlv/u2Hz+7n0hD9j+clbuoVdeR4uF4whFFNNidMCvQDhDY7wyD0o7R3tBPdbCoFhmCBy1L8wI0TgRjTpY1tAP3MfEssTYVVaOF9TSy+w8YYVCGbXi5V7Xcl3xCTUnYLN8nCuSUimouTZZ4g6wni2ygs9Azirnghby+u2WJA3wZrp8WY9RY8nFje2Wj41TpveRLX1v8EIy8ZR8ekQHu7KBAdGs8IarSllCG88H9pPLdP6GUWqCNy/8MVOyR8DX0cA/z6JnWdMGIPaWl3JhZmInnZivoUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BscS0ahT3xpi1+GPMmqI6O/b0AXQhB6B6E87fTaauEM=;
 b=LNvY2ppkzs9AO+GvUZU3AzqEIcQumIip1StHkxf3zfmupEdauW6H7xpxgtgbagy/iwqxv23V8yAPpN+KvSYxlNP4OEjk5IDImSrNN92fEt1t7M47h28sPLb9LlwvejiAQZnx81BVdyqqtO9ZxNG1T61BmUA/l1vX7y1MLpKHa9EvOX/X0O5vYuXjOVXJB8b+zeMliLHlglP1hQAFhCGJ6xFZJQK3lqheoR1eh4xGKJXRrzmIc5FU3eS2jUd4vh5TaG1zD6guEk6C1ZjfwzK44UQ8Z9ItIt2e8ksRvsNIhoj1KQb25fmSPVjP2fbYYFlexL+M+qLp+MDU5hpT8kC9LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BscS0ahT3xpi1+GPMmqI6O/b0AXQhB6B6E87fTaauEM=;
 b=l5JIkERoRdjSf1T5dFNVWtjI91mk0YchoqqU+0mPSzIMqLvvTHr2/J0eHj4DFi8IUSaniBftaerkmlcP9WFCGccIPqQXc51uZV+KqUqQulmUKRtLOorXWgd1VI/unPDxjF8eYa0LcYT9r+CtMHvEp8axzFNDdOvhs1mmYt+EK4U=
Authentication-Results: vger.kernel.org; dkim=none (message not signed)
 header.d=none;vger.kernel.org; dmarc=none action=none header.from=oracle.com;
Received: from BY5PR10MB4196.namprd10.prod.outlook.com (2603:10b6:a03:20d::23)
 by BYAPR10MB2902.namprd10.prod.outlook.com (2603:10b6:a03:85::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4065.24; Thu, 29 Apr
 2021 02:42:42 +0000
Received: from BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90]) by BY5PR10MB4196.namprd10.prod.outlook.com
 ([fe80::4407:2ff6:c0a:5d90%8]) with mapi id 15.20.4065.027; Thu, 29 Apr 2021
 02:42:42 +0000
Subject: Re: [PATCH v21 6/9] mm: hugetlb: alloc the vmemmap pages associated
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
        zhengqi.arch@bytedance.com, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org
References: <20210425070752.17783-1-songmuchun@bytedance.com>
 <20210425070752.17783-7-songmuchun@bytedance.com>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <956a52e4-3a2c-b0dc-3b5d-dd651a4aa54a@oracle.com>
Date:   Wed, 28 Apr 2021 19:42:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
In-Reply-To: <20210425070752.17783-7-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [50.38.35.18]
X-ClientProxiedBy: CO1PR15CA0077.namprd15.prod.outlook.com
 (2603:10b6:101:20::21) To BY5PR10MB4196.namprd10.prod.outlook.com
 (2603:10b6:a03:20d::23)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.112] (50.38.35.18) by CO1PR15CA0077.namprd15.prod.outlook.com (2603:10b6:101:20::21) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4087.25 via Frontend Transport; Thu, 29 Apr 2021 02:42:41 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 02be6773-ed15-4164-bb59-08d90ab8764d
X-MS-TrafficTypeDiagnostic: BYAPR10MB2902:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <BYAPR10MB29026754EE008506864740A5E25F9@BYAPR10MB2902.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dibHgEqWxjARgtWlfVHa2vJNY8sYZklIsffGS+UrwM30iQHonCWTMHITRVtfO+Rv0cTFuoXjYDU2nTsW1vtkd0IyjR4dmegS73aHp4q+ABvq19vXUgpXAzNGTKUu2dbhUQ1Yow3JMm2w4DK6FFQPdScque6GxwvoTxK2tcD0giqafr0c/4tHMW95EkXh8NZ+U68Ew5ZQvPTZo3W/vbXk18a4wl1duS11SVsBCZm2GGpK1XB1iymVNVOsq5p/GrrLps00+rRZlYt7BY09RPHb1oM4mZNWiTiz2PhAA6BlC9OlcuoLXmi5Gugi6TRwTQAMUlVMeQAluyT5QAJcwfvWvEz/HmNdpNF5ep7IaSXhXMcd/ia0QufOyfo1iTTCQWt785PqTBY+acwNpV9y0DSKZusAp6AXM04eNQyiz4UeLcGORTqX3+UetXGj06ASkgWA4EQF1hgB8OCFzBC/69UtLMFkZdHGMLHrAQy7hUOU19VYE+Gy+hNDswBQwdZKw2mtHkxYkvOT/D+RYnLXiK15jW2FjPFd/9ZrB7Nw6sPwDK6AbRMBRqpuN/8tyqzzJNj+m5p4osQ2r0WTjmx0Z5XIUWLQMZzhaYWTOpMGt/MnXRN2OORNaMv7wgpFVUT8wpcxloYhk881H0Kjp617CUNV/Jtgv2MlnNLh6+e+xgYcEXIaL6f2g3VCjKdgVd2Bi4PU+Fdrc+5g3AWxLs8FYAKL3PkRRrtldVY+L/2FPVsUtjY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4196.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(39860400002)(376002)(366004)(396003)(136003)(6486002)(478600001)(66946007)(2906002)(2616005)(6636002)(956004)(16576012)(66556008)(66476007)(38100700002)(8676002)(53546011)(921005)(316002)(38350700002)(26005)(5660300002)(86362001)(45080400002)(186003)(36756003)(7406005)(44832011)(7416002)(31696002)(52116002)(16526019)(31686004)(8936002)(4326008)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?cnBvTFg1ZmdHOTdzTXUzeC9jK1J1WUQ4ODlQUTBpWkJiblhKSFB1ck81elAz?=
 =?utf-8?B?NjZ4dWdQcU12UzIrL3cwM0s2ZTVSWEl5aUgzTFpDeVNHTlBqcmJ4OXp0QVRI?=
 =?utf-8?B?UkVtenhGRFhsOHE5K3RES05Xdm9NRjF0b1hVWGdLdHowd2FrM1JGS0FmcVk2?=
 =?utf-8?B?QmpOVU5qL0tzU1hkd09PL0xlOVhhdnBFUWNTcnlYQnZDYVcxVUVNWVd0Unk5?=
 =?utf-8?B?TU9DY3VYWnFRbElLWUtQZ3MyZmQ3K3RPelU0TVREUjdES0ZKaXd0S3ZseHNs?=
 =?utf-8?B?eXU4UGVvUFBNZmh1YXptVGU3QVBTbk9Kczh1SjNuOG9SaDBQakJXbjhPazF3?=
 =?utf-8?B?aEo2aUM0VGE5TCs1ZlRwUW0wL09KbmNPNHVxblVBVHFOUlVsaFQrbWR6Q0RE?=
 =?utf-8?B?S0tRRkxBWVVETmJBb1RVUGR6ZzVrYUJGaTV0VFNpZUhaVHNyb1BLZWF6aFB5?=
 =?utf-8?B?WTF0V2h0VzJ3QzhNZmo1di9sNUxWbEZzSkptTXNiOVZtQXdZNUk5eE1FWHRx?=
 =?utf-8?B?L3dITnlha1kzbmxYZ3EwV2ZXSDRkZlIzbk12Y3pqSjkwUlJrU2drVmllTjZ5?=
 =?utf-8?B?amlITHdjRnY0UjNYUmxPcXMrM2pNbjYxRmtUSlFEZXFuZHlGL2d0Sk5vTHl2?=
 =?utf-8?B?eEc4ak9PdXp5SERYQ2ZoVVVQbk5NVi82YWxyVmdndDQwdXdiQStWWUhPMG54?=
 =?utf-8?B?eXFLaFZ6MDlxVk5vR2lWK0VXeFNLR1NPbWFGQVZEMUFpYXJKQk1yemxIc3Vr?=
 =?utf-8?B?R2N6WjlFc3ducGI3Tyt0cVl3QjVKNkhZVVN0TWh5aitoMjZid2llNjJldHNL?=
 =?utf-8?B?NWx0N201M2JGNzh0dE1tN2ZsNHpUVm55UkUyUzBXV0lSbGtVWnZuck14RVVL?=
 =?utf-8?B?MXJVdkYwVitoRENac2Rualg0NWVDSGZmMGVLNHBnWXFvbW5sL3orTTdBUWFD?=
 =?utf-8?B?emlsVG9NZ2tsUFBENnZBd3VaaU1KdC91YlNmWXlqSGhydkgzaGgyMjB6RkdR?=
 =?utf-8?B?d05mdmt6ak1hOWIxTktscit4ZkwvSG9vM3JMbElIeHFWZjBzQkQ2bUlISTNx?=
 =?utf-8?B?NkNXMXRTWDV6M2c4bHZoNzdqQ21TTGZ4USsrNjBoSExKL0tEMmR4NjQzcG9F?=
 =?utf-8?B?T0dUV25vekVZRmJ5U0tRRUVpRXF6SmdKNEZrbG9OUXFSMUxkRTBSNG9JbWxE?=
 =?utf-8?B?Y1NjeUJpUG5nNUR6VDlDSFRXMStXRmhYNm5PWnVpR3BkbzIvV0lHL2MwdDBw?=
 =?utf-8?B?UkpqdDhobDFXeWFTQVBJTTc2QmpBVFFiQ1ZLamhNSGM4eWhoa0VhblhiMDdW?=
 =?utf-8?B?STFqb2VmZ0dPeFVFbXVqVjlYUHNQTUlHT0lCQStJNFNJVHcrSUVxdTBiT240?=
 =?utf-8?B?cy9hU3hFZXBlQkpnRDBMdmZHQlNMYjIrRmJWT2JPbnpoK1VPVnJhVm5seGlw?=
 =?utf-8?B?SU84SUt1aTdyWS9GZWZqc21uUGIvNXI5K09SRDFzQkNnajZWc2JuUVdWVEJJ?=
 =?utf-8?B?WGVodU5kYWtPcGNpTXM5WWVkZHNZSVJEeVpJTEtJTmc3T2FGUDZvWGF5VFps?=
 =?utf-8?B?QTJsM2FXMHI3SS84aXczVThIV0JOdCs3TldRTDV6Yi9jQkpjNWFGVmgyWGNu?=
 =?utf-8?B?ZUx0ZWVtYkY2cFBKWkxoUDN1VnVmRS96bkFHWGUrdUNVMFBnVSttQms0cTlq?=
 =?utf-8?B?Rk03UGd3cit0UmQvWE1sT0VmMm1Vd3lWSjYxQm1EMHhjUklpbFRJNHY3V0xm?=
 =?utf-8?Q?L3UynMGSbaSGK6QFaXr9bQdp6bG1Mlk7UBSAleZ?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02be6773-ed15-4164-bb59-08d90ab8764d
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4196.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2021 02:42:42.6613
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MsqLnPEf0YCNLrGRitvvyfrz8AVuezVdHDFzPAxExwRdQZhvNJw1WmIvtYIXV1IIRI5On9sUBQsatoHLR3Rwg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR10MB2902
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 mlxscore=0
 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104060000
 definitions=main-2104290019
X-Proofpoint-ORIG-GUID: ihU8u2yR75eS_C6QgTtywOoO0a_m8Qid
X-Proofpoint-GUID: ihU8u2yR75eS_C6QgTtywOoO0a_m8Qid
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=9968 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 impostorscore=0
 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0 lowpriorityscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104290019
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/25/21 12:07 AM, Muchun Song wrote:
> diff --git a/include/linux/hugetlb.h b/include/linux/hugetlb.h
> index d523a345dc86..d3abaaec2a22 100644
> --- a/include/linux/hugetlb.h
> +++ b/include/linux/hugetlb.h
> @@ -525,6 +525,7 @@ unsigned long hugetlb_get_unmapped_area(struct file *file, unsigned long addr,
>   *	code knows it has only reference.  All other examinations and
>   *	modifications require hugetlb_lock.
>   * HPG_freed - Set when page is on the free lists.
> + * HPG_vmemmap_optimized - Set when the vmemmap pages of the page are freed.
>   *	Synchronization: hugetlb_lock held for examination and modification.
>   */
>  enum hugetlb_page_flags {
> @@ -532,6 +533,7 @@ enum hugetlb_page_flags {
>  	HPG_migratable,
>  	HPG_temporary,
>  	HPG_freed,
> +	HPG_vmemmap_optimized,
>  	__NR_HPAGEFLAGS,
>  };
>  
> @@ -577,6 +579,7 @@ HPAGEFLAG(RestoreReserve, restore_reserve)
>  HPAGEFLAG(Migratable, migratable)
>  HPAGEFLAG(Temporary, temporary)
>  HPAGEFLAG(Freed, freed)
> +HPAGEFLAG(VmemmapOptimized, vmemmap_optimized)
>  
>  #ifdef CONFIG_HUGETLB_PAGE
>  

During migration, the page->private field of the original page may be
cleared.  This will clear all hugetlb specific flags.  Prior to this
new flag that was OK, as the only flag which could be set during migration
was the Temporary flag and that is transfered to the target page.

If VmemmapOptimized optimized flag is cleared in the original page, we
will get an addressing exception as shown below.

We should preserve page->private with something like this:

diff --git a/mm/migrate.c b/mm/migrate.c
index b234c3f3acb7..128e3e4126a2 100644
--- a/mm/migrate.c
+++ b/mm/migrate.c
@@ -625,7 +625,9 @@ void migrate_page_states(struct page *newpage, struct page *page)
 	if (PageSwapCache(page))
 		ClearPageSwapCache(page);
 	ClearPagePrivate(page);
-	set_page_private(page, 0);
+	/* page->private contains hugetlb specific flags */
+	if (!PageHuge(page))
+		set_page_private(page, 0);
 
 	/*
 	 * If any waiters have accumulated on the new page then

-- 
Mike Kravetz


[  209.568110] BUG: unable to handle page fault for address: ffffea0004a5a000
[  209.569417] #PF: supervisor write access in kernel mode
[  209.570932] #PF: error_code(0x0003) - permissions violation
[  209.572059] PGD 23fff8067 P4D 23fff8067 PUD 23fff7067 PMD 23ffd9067 PTE 800000021c98e061
[  209.573679] Oops: 0003 [#1] SMP PTI
[  209.574410] CPU: 1 PID: 1011 Comm: bash Not tainted 5.12.0-rc8-mm1+ #3
[  209.575730] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.14.0-1.fc33 04/01/2014
[  209.577530] RIP: 0010:__update_and_free_page+0x58/0x2c0
[  209.578618] Code: a3 01 00 00 49 b8 00 00 00 00 00 16 00 00 4c 89 e0 bf 01 00 00 00 49 b9 00 00 00 00 00 ea ff ff 4d 01 e0 49 c1 f8 06 83 c2 01 <48> 81 20 d4 5e ff ff 48 83 c0 40 f7 c2 ff 03 00 00 0f 84 f3 00 00
[  209.582603] RSP: 0018:ffffc90001fdfa60 EFLAGS: 00010206
[  209.583629] RAX: ffffea0004a5a000 RBX: 0000000000000000 RCX: 0000000000000009
[  209.585148] RDX: 0000000000000081 RSI: 0000000000000200 RDI: 0000000000000001
[  209.586649] RBP: ffffffff839ada30 R08: 0000000000129600 R09: ffffea0000000000
[  209.588096] R10: 0000000000000001 R11: 0000000000000001 R12: ffffea0004a58000
[  209.589643] R13: 0000000000000200 R14: ffffea0005ff8000 R15: ffffc90001fdfba0
[  209.591194] FS:  00007f1e50065740(0000) GS:ffff888237d00000(0000) knlGS:0000000000000000
[  209.592989] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  209.594222] CR2: ffffea0004a5a000 CR3: 000000018cd46004 CR4: 0000000000370ee0
[  209.595762] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[  209.597302] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[  209.598925] Call Trace:
[  209.599496]  migrate_pages+0xd8f/0x1030
[  209.600372]  ? trace_event_raw_event_mm_migrate_pages_start+0xa0/0xa0
[  209.601745]  ? alloc_migration_target+0x1c0/0x1c0
[  209.602787]  alloc_contig_range+0x1e3/0x3d0
[  209.603718]  cma_alloc+0x1ae/0x5f0
[  209.604486]  alloc_fresh_huge_page+0x67/0x190
[  209.605481]  alloc_pool_huge_page+0x72/0xf0
[  209.606423]  set_max_huge_pages+0x128/0x2c0
[  209.607369]  __nr_hugepages_store_common+0x3d/0xb0
[  209.608442]  ? _kstrtoull+0x35/0xd0
[  209.609225]  nr_hugepages_store+0x73/0x80
[  209.610140]  kernfs_fop_write_iter+0x127/0x1c0
[  209.611162]  new_sync_write+0x11f/0x1b0
[  209.612069]  vfs_write+0x26f/0x380
[  209.612880]  ksys_write+0x68/0xe0
[  209.613628]  do_syscall_64+0x40/0x80
[  209.614456]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  209.615589] RIP: 0033:0x7f1e50155ff8
[  209.616474] Code: 89 02 48 c7 c0 ff ff ff ff eb b3 0f 1f 80 00 00 00 00 f3 0f 1e fa 48 8d 05 25 77 0d 00 8b 00 85 c0 75 17 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 58 c3 0f 1f 80 00 00 00 00 41 54 49 89 d4 55
[  209.620629] RSP: 002b:00007ffd7e3f97c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
[  209.622319] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f1e50155ff8
[  209.623966] RDX: 0000000000000002 RSI: 00005585ef557960 RDI: 0000000000000001
[  209.625568] RBP: 00005585ef557960 R08: 000000000000000a R09: 00007f1e501e7e80
[  209.627262] R10: 000000000000000a R11: 0000000000000246 R12: 00007f1e50229780
[  209.628916] R13: 0000000000000002 R14: 00007f1e50224740 R15: 0000000000000002
[  209.630457] Modules linked in: ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack rfkill nf_defrag_ipv6 nf_defrag_ipv4 ebtable_filter ebtables 9p ip6table_filter ip6_tables sunrpc snd_hda_codec_generic crct10dif_pclmul crc32_pclmul snd_hda_intel snd_intel_dspcfg ghash_clmulni_intel snd_hda_codec snd_hwdep joydev snd_hda_core snd_seq snd_seq_device snd_pcm virtio_balloon snd_timer snd soundcore 9pnet_virtio i2c_piix4 9pnet virtio_blk virtio_console virtio_net net_failover failover 8139too qxl drm_ttm_helper ttm drm_kms_helper crc32c_intel serio_raw drm 8139cp mii ata_generic virtio_pci virtio_pci_modern_dev virtio_ring pata_acpi virtio
[  209.647105] CR2: ffffea0004a5a000
[  209.647913] ---[ end trace 48e9b007521233a7 ]---
