Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 72AA715EB42
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 18:20:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403931AbgBNRTX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 12:19:23 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:38132 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391605AbgBNRTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 12:19:15 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EHIl1w183931;
        Fri, 14 Feb 2020 17:18:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=subject : to :
 references : from : message-id : date : mime-version : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=b3JxBw2+JQ0qP9VNf1U9eTy2/JfMhi+NgCpxMvdxhCs=;
 b=ERrhO+T/qTntFQ7zVkd8ooGG6YvB1SUOUneZw0ar/2dGVBURK+CRf1L+whcz+uEnD9XV
 djcaXwXVe6GWn2SssE618ivCy5fwEuQ1zgHkWByFj2fMD7nwlA7EntOKrfioiA52Xur2
 FUbn6OKAbVUe+dPonvaQuQ64UwivQ7DBzS4sPRl8MtNg2HTUUxMFrdKwZEVI6hV+cVJo
 emHf/Lp5s9hnCciSkzDW1tu2JD/X3MOmzWCTTgfTRbqhRi3JmUrsh4utAFQxt99Wd3Ct
 kQMUvwiPBaoO322mlr9ifAQ9blxR4ldss5C3G39TFNXhFLLQRK6QP6hTbin5BG592If7 Sg== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2y2jx6tvq2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 17:18:47 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01EHI0lS120979;
        Fri, 14 Feb 2020 17:18:47 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2y4k82fnq5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 14 Feb 2020 17:18:47 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01EHIiXG027884;
        Fri, 14 Feb 2020 17:18:44 GMT
Received: from [192.168.1.206] (/71.63.128.209)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 14 Feb 2020 09:18:44 -0800
Subject: Re: mmotm 2020-02-13-22-26 uploaded (mm/hugetlb.c)
To:     Randy Dunlap <rdunlap@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, broonie@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-next@vger.kernel.org, mhocko@suse.cz,
        mm-commits@vger.kernel.org, sfr@canb.auug.org.au,
        Matthew Wilcox <willy@infradead.org>,
        Mina Almasry <almasrymina@google.com>
References: <20200214062647.A2Mb_X-mP%akpm@linux-foundation.org>
 <8e1e8f6e-0da1-e9e0-fa1b-bfd792256604@infradead.org>
From:   Mike Kravetz <mike.kravetz@oracle.com>
Message-ID: <7ff9e944-1c6c-f7c1-d812-e12817c7a317@oracle.com>
Date:   Fri, 14 Feb 2020 09:18:42 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <8e1e8f6e-0da1-e9e0-fa1b-bfd792256604@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002140130
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9531 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 phishscore=0 impostorscore=0 spamscore=0
 bulkscore=0 lowpriorityscore=0 mlxscore=0 suspectscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002140130
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

+ Mina

Andrew, you might want to remove those hugetlb cgroup patches from mmotm
as they are not yet fully reviewed and have some build issues.

-- 
Mike Kravetz

On 2/14/20 8:29 AM, Randy Dunlap wrote:
> On 2/13/20 10:26 PM, Andrew Morton wrote:
>> The mm-of-the-moment snapshot 2020-02-13-22-26 has been uploaded to
>>
>>    http://www.ozlabs.org/~akpm/mmotm/
>>
>> mmotm-readme.txt says
>>
>> README for mm-of-the-moment:
>>
>> http://www.ozlabs.org/~akpm/mmotm/
>>
>> This is a snapshot of my -mm patch queue.  Uploaded at random hopefully
>> more than once a week.
>>
> 
> on x86_64:
> 
>   CC      mm/hugetlb.o
> In file included from ../include/linux/kernel.h:15:0,
>                  from ../include/linux/list.h:9,
>                  from ../mm/hugetlb.c:6:
> ../mm/hugetlb.c: In function ‘dump_resv_map’:
> ../mm/hugetlb.c:301:30: error: ‘struct file_region’ has no member named ‘reservation_counter’
>           rg->from, rg->to, rg->reservation_counter, rg->css);
>                               ^
> ../include/linux/printk.h:304:33: note: in definition of macro ‘pr_err’
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                  ^~~~~~~~~~~
> ../mm/hugetlb.c:301:55: error: ‘struct file_region’ has no member named ‘css’
>           rg->from, rg->to, rg->reservation_counter, rg->css);
>                                                        ^
> ../include/linux/printk.h:304:33: note: in definition of macro ‘pr_err’
>   printk(KERN_ERR pr_fmt(fmt), ##__VA_ARGS__)
>                                  ^~~~~~~~~~~
> ../mm/hugetlb.c: In function ‘check_coalesce_bug’:
> ../mm/hugetlb.c:320:10: error: ‘struct file_region’ has no member named ‘reservation_counter’
>    if (nrg->reservation_counter && nrg->from == rg->to &&
>           ^~
> ../mm/hugetlb.c:321:10: error: ‘struct file_region’ has no member named ‘reservation_counter’
>        nrg->reservation_counter == rg->reservation_counter &&
>           ^~
> ../mm/hugetlb.c:321:37: error: ‘struct file_region’ has no member named ‘reservation_counter’
>        nrg->reservation_counter == rg->reservation_counter &&
>                                      ^~
> ../mm/hugetlb.c:322:10: error: ‘struct file_region’ has no member named ‘css’
>        nrg->css == rg->css) {
>           ^~
> ../mm/hugetlb.c:322:21: error: ‘struct file_region’ has no member named ‘css’
>        nrg->css == rg->css) {
>                      ^~
> 
> 
> Full randconfig file is attached.
> 
