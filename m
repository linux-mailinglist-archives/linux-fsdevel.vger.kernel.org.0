Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 086877B9DB
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Jul 2019 08:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387552AbfGaGoS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Jul 2019 02:44:18 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:21874 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2387431AbfGaGoS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Jul 2019 02:44:18 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6V6gR9k143318
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 02:44:17 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2u35fw9bxd-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Jul 2019 02:44:16 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <rppt@linux.ibm.com>;
        Wed, 31 Jul 2019 07:44:14 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Wed, 31 Jul 2019 07:44:07 +0100
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6V6i6kP42270910
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 31 Jul 2019 06:44:06 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 389A64C04E;
        Wed, 31 Jul 2019 06:44:06 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5E4614C04A;
        Wed, 31 Jul 2019 06:44:04 +0000 (GMT)
Received: from rapoport-lnx (unknown [9.148.8.168])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Wed, 31 Jul 2019 06:44:04 +0000 (GMT)
Date:   Wed, 31 Jul 2019 09:44:02 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc:     linux-kernel@vger.kernel.org,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Brendan Gregg <bgregg@netflix.com>,
        Christian Hansen <chansen3@cisco.com>, dancol@google.com,
        fmayer@google.com, joaodias@google.com, joelaf@google.com,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>, kernel-team@android.com,
        linux-api@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        Michal Hocko <mhocko@suse.com>, minchan@kernel.org,
        namhyung@google.com, Roman Gushchin <guro@fb.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>, surenb@google.com,
        tkjos@google.com, Vladimir Davydov <vdavydov.dev@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>, wvw@google.com
Subject: Re: [PATCH v3 2/2] doc: Update documentation for page_idle virtual
 address indexing
References: <20190726152319.134152-1-joel@joelfernandes.org>
 <20190726152319.134152-2-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726152319.134152-2-joel@joelfernandes.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-TM-AS-GCONF: 00
x-cbid: 19073106-0016-0000-0000-00000297D60A
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19073106-0017-0000-0000-000032F5E768
Message-Id: <20190731064400.GD21422@rapoport-lnx>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-31_03:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1906280000 definitions=main-1907310070
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 11:23:19AM -0400, Joel Fernandes (Google) wrote:
> This patch updates the documentation with the new page_idle tracking
> feature which uses virtual address indexing.
> 
> Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>

One nit below, otherwise

Reviewed-by: Mike Rapoport <rppt@linux.ibm.com>

> ---
>  .../admin-guide/mm/idle_page_tracking.rst     | 43 ++++++++++++++++---
>  1 file changed, 36 insertions(+), 7 deletions(-)
> 
> diff --git a/Documentation/admin-guide/mm/idle_page_tracking.rst b/Documentation/admin-guide/mm/idle_page_tracking.rst
> index df9394fb39c2..1eeac78c94a7 100644
> --- a/Documentation/admin-guide/mm/idle_page_tracking.rst
> +++ b/Documentation/admin-guide/mm/idle_page_tracking.rst
> @@ -19,10 +19,14 @@ It is enabled by CONFIG_IDLE_PAGE_TRACKING=y.
>  
>  User API
>  ========
> +There are 2 ways to access the idle page tracking API. One uses physical
> +address indexing, another uses a simpler virtual address indexing scheme.
>  
> -The idle page tracking API is located at ``/sys/kernel/mm/page_idle``.
> -Currently, it consists of the only read-write file,
> -``/sys/kernel/mm/page_idle/bitmap``.
> +Physical address indexing
> +-------------------------
> +The idle page tracking API for physical address indexing using page frame
> +numbers (PFN) is located at ``/sys/kernel/mm/page_idle``.  Currently, it
> +consists of the only read-write file, ``/sys/kernel/mm/page_idle/bitmap``.
>  
>  The file implements a bitmap where each bit corresponds to a memory page. The
>  bitmap is represented by an array of 8-byte integers, and the page at PFN #i is
> @@ -74,6 +78,31 @@ See :ref:`Documentation/admin-guide/mm/pagemap.rst <pagemap>` for more
>  information about ``/proc/pid/pagemap``, ``/proc/kpageflags``, and
>  ``/proc/kpagecgroup``.
>  
> +Virtual address indexing
> +------------------------
> +The idle page tracking API for virtual address indexing using virtual page
> +frame numbers (VFN) is located at ``/proc/<pid>/page_idle``. It is a bitmap
> +that follows the same semantics as ``/sys/kernel/mm/page_idle/bitmap``
> +except that it uses virtual instead of physical frame numbers.

Can you please make it more explicit that VFNs are in the <pid>'s address
space?

> +
> +This idle page tracking API does not need deal with PFN so it does not require
> +prior lookups of ``pagemap`` in order to find if page is idle or not. This is
> +an advantage on some systems where looking up PFN is considered a security
> +issue.  Also in some cases, this interface could be slightly more reliable to
> +use than physical address indexing, since in physical address indexing, address
> +space changes can occur between reading the ``pagemap`` and reading the
> +``bitmap``, while in virtual address indexing, the process's ``mmap_sem`` is
> +held for the duration of the access.
> +
> +To estimate the amount of pages that are not used by a workload one should:
> +
> + 1. Mark all the workload's pages as idle by setting corresponding bits in
> +    ``/proc/<pid>/page_idle``.
> +
> + 2. Wait until the workload accesses its working set.
> +
> + 3. Read ``/proc/<pid>/page_idle`` and count the number of bits set.
> +
>  .. _impl_details:
>  
>  Implementation Details
> @@ -99,10 +128,10 @@ When a dirty page is written to swap or disk as a result of memory reclaim or
>  exceeding the dirty memory limit, it is not marked referenced.
>  
>  The idle memory tracking feature adds a new page flag, the Idle flag. This flag
> -is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` (see the
> -:ref:`User API <user_api>`
> -section), and cleared automatically whenever a page is referenced as defined
> -above.
> +is set manually, by writing to ``/sys/kernel/mm/page_idle/bitmap`` for physical
> +addressing or by writing to ``/proc/<pid>/page_idle`` for virtual
> +addressing (see the :ref:`User API <user_api>` section), and cleared
> +automatically whenever a page is referenced as defined above.
>  
>  When a page is marked idle, the Accessed bit must be cleared in all PTEs it is
>  mapped to, otherwise we will not be able to detect accesses to the page coming
> -- 
> 2.22.0.709.g102302147b-goog
> 

-- 
Sincerely yours,
Mike.

