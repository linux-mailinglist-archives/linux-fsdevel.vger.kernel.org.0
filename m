Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 80A1B20E8FE
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 01:14:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728780AbgF2W5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 18:57:35 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43942 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728750AbgF2W5e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 18:57:34 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05THc6Ll160864;
        Mon, 29 Jun 2020 17:40:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=gOwHGVEv+9+n2pXWogpDPvTyHw9NsjLdt8nfdAe9dbA=;
 b=BDbG+z+MFyeHLRJxafKS3pYiJQ3MahQoJZVdM9b/IMPbiU0z7AEa6D+r8nUqSu6VEc5Q
 4V1HWxp4UvdmY4N1+xUqXQkV5gwPAxXh6M8YJCLVM/jWgrSnbMMggXbNm8kJ2ffnPMyO
 tST1srxNVzFwPq6z3GZ4AlJQKvSXFgW7JWy+ihwbfj0PE0hTJ8qj4wvemWZ26GfhPJPw
 c1SUm9DhY0+8+cn1zyV80x1uy+KUIBXHGSCFIqiKmasrTJaCW3xwwEFWf6CXC8pmSSHx
 k+3LVa2sGFnUzQH1ssmZB77rb8NvRadC5uKBtSqsvGSgY9EVoc2B6ZWtpCTLNAM37FeL 1A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31wxrmytxh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 29 Jun 2020 17:40:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05THcVKo040680;
        Mon, 29 Jun 2020 17:40:14 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31xfvr3hqg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Jun 2020 17:40:14 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05THeDKI018709;
        Mon, 29 Jun 2020 17:40:13 GMT
Received: from [192.168.2.112] (/50.38.35.18)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Jun 2020 17:40:13 +0000
Subject: Re: [PATCH 5/7] mm: Replace hpage_nr_pages with thp_nr_pages
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>
References: <20200629151959.15779-1-willy@infradead.org>
 <20200629151959.15779-6-willy@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <8bf5ae79-eace-5345-1a77-69d9e2e083b3@oracle.com>
Date:   Mon, 29 Jun 2020 10:40:12 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200629151959.15779-6-willy@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290112
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006290112
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 6/29/20 8:19 AM, Matthew Wilcox (Oracle) wrote:
> The thp prefix is more frequently used than hpage and we should
> be consistent between the various functions.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
...
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index 57ece74e3aae..6bb07bc655f7 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -1593,7 +1593,7 @@ static struct address_space *_get_hugetlb_page_mapping(struct page *hpage)
>  
>  	/* Use first found vma */
>  	pgoff_start = page_to_pgoff(hpage);
> -	pgoff_end = pgoff_start + hpage_nr_pages(hpage) - 1;
> +	pgoff_end = pgoff_start + thp_nr_pages(hpage) - 1;
>  	anon_vma_interval_tree_foreach(avc, &anon_vma->rb_root,
>  					pgoff_start, pgoff_end) {
>  		struct vm_area_struct *vma = avc->vma;

Naming consistency is a good idea!

I was wondering why hugetlb code would be calling a 'thp related' routine.
The reason is that hpage_nr_pages was incorrectly added (by me) to get the
number of pages in a hugetlb page.  If the name of the routine was thp_nr_pages
as proposed, I would not have made this mistake.

I will provide a patch to change the above hpage_nr_pages call to
pages_per_huge_page(page_hstate()).
-- 
Mike Kravetz
