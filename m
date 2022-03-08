Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C864D1911
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 14:22:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241950AbiCHNXM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 08:23:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233002AbiCHNXL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:23:11 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AC449691;
        Tue,  8 Mar 2022 05:22:15 -0800 (PST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 228BQ0rg007740;
        Tue, 8 Mar 2022 13:22:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=pp1;
 bh=eO4h0TI+iWr46j4SVj3ufQz+54GScqE667mEsGEh9+Y=;
 b=oUu2C5xgrkqBRt3bneXLbsKVodtuTp3zql7tD/q9GGeZu9QvBjct1NggWmxQSl/AbF6W
 wSru3yrmp6WNQdIhbiHVLNJTFEaswEuDtTB3LGOBnNL2DG1FTQtF6G3Fn+gwgITt+uUu
 pN+Mchs6nDoie9zGXSbWsW+WFJ+8jQ5MxKaHws2IZqj6wdrwnYjyPyKzOZTFgVBlnwjk
 FFOK7BUlAw4nzSKHKEnjb5v1Z9CqcDQtgs8Algrq+nHi4SdS7KvLptmmNyqR3wP/R5j/
 YmlS8f5i/FQ+uaGsC59Ds5q2+rYw2KyqO97DzzVafF2nGFctU3YVTlI/EnU/pTl6tHPH +w== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0hfh6eg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 13:22:11 +0000
Received: from m0098414.ppops.net (m0098414.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 228DHPOj015724;
        Tue, 8 Mar 2022 13:22:10 GMT
Received: from ppma05fra.de.ibm.com (6c.4a.5195.ip4.static.sl-reverse.com [149.81.74.108])
        by mx0b-001b2d01.pphosted.com with ESMTP id 3ep0hfh6e2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 13:22:10 +0000
Received: from pps.filterd (ppma05fra.de.ibm.com [127.0.0.1])
        by ppma05fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 228DHRRl019343;
        Tue, 8 Mar 2022 13:22:08 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma05fra.de.ibm.com with ESMTP id 3ekyg96g2k-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 13:22:08 +0000
Received: from d06av24.portsmouth.uk.ibm.com (mk.ibm.com [9.149.105.60])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 228D9fhf39321948
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 13:09:41 GMT
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FF3642041;
        Tue,  8 Mar 2022 13:20:50 +0000 (GMT)
Received: from d06av24.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id E77BD42042;
        Tue,  8 Mar 2022 13:20:49 +0000 (GMT)
Received: from thinkpad (unknown [9.171.70.239])
        by d06av24.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  8 Mar 2022 13:20:49 +0000 (GMT)
Date:   Tue, 8 Mar 2022 14:20:47 +0100
From:   Gerald Schaefer <gerald.schaefer@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        John Hubbard <jhubbard@nvidia.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
Message-ID: <20220308142047.7a725518@thinkpad>
In-Reply-To: <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
        <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
        <bcafacea-7e67-405c-a969-e5a58a3c727e@redhat.com>
        <2266e1a8-ac79-94a1-b6e2-47475e5986c5@redhat.com>
        <81f2f76d-24ef-c23b-449e-0b8fdec506e1@redhat.com>
        <1bdb0184-696c-0f1a-3054-d88391c32e64@redhat.com>
X-Mailer: Claws Mail 3.18.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bjXztZi9rjQpeJ9qVMe1cbBsMgt6zfXu
X-Proofpoint-ORIG-GUID: W3zlxDiE9TlFw4xptdJc9LTAkRAOlFnC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1011
 impostorscore=0 spamscore=0 bulkscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 malwarescore=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080069
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 8 Mar 2022 13:24:19 +0100
David Hildenbrand <david@redhat.com> wrote:

[...]
> 
> From 1e51e8a93894f87c0a4d0e908391e0628ae56afe Mon Sep 17 00:00:00 2001
> From: David Hildenbrand <david@redhat.com>
> Date: Tue, 8 Mar 2022 12:51:26 +0100
> Subject: [PATCH] mm/gup: fix buffered I/O on s390x with pagefaults disabled
> 
> On s390x, we actually need a pte_mkyoung() / pte_mkdirty() instead of
> going via the page and leaving the PTE unmodified. E.g., if we only
> mark the page accessed via mark_page_accessed() when doing a FOLL_TOUCH,
> we'll miss to clear the HW invalid bit in the pte and subsequent accesses
> via the MMU would still require a pagefault.
> 
> Otherwise, buffered I/O will loop forever because it will keep stumling
> over the set HW invalid bit, requiring a page fault.
> 
> Reported-by: Andreas Gruenbacher <agruenba@redhat.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  mm/gup.c | 32 +++++++++++++++++++++++++-------
>  1 file changed, 25 insertions(+), 7 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index a9d4d724aef7..de3311feb377 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -587,15 +587,33 @@ static struct page *follow_page_pte(struct vm_area_struct *vma,
>  		}
>  	}
>  	if (flags & FOLL_TOUCH) {
> -		if ((flags & FOLL_WRITE) &&
> -		    !pte_dirty(pte) && !PageDirty(page))
> -			set_page_dirty(page);
>  		/*
> -		 * pte_mkyoung() would be more correct here, but atomic care
> -		 * is needed to avoid losing the dirty bit: it is easier to use
> -		 * mark_page_accessed().
> +		 * We have to be careful with updating the PTE on architectures
> +		 * that have a HW dirty bit: while updating the PTE we might
> +		 * lose that bit again and we'd need an atomic update: it is
> +		 * easier to leave the PTE untouched for these architectures.
> +		 *
> +		 * s390x doesn't have a hw referenced / dirty bit and e.g., sets
> +		 * the hw invalid bit in pte_mkold(), to catch further
> +		 * references. We have to update the PTE here to e.g., clear the
> +		 * invalid bit; otherwise, callers that rely on not requiring
> +		 * an MMU fault once GUP(FOLL_TOUCH) succeeded will loop forever
> +		 * because the page won't actually be accessible via the MMU.
>  		 */
> -		mark_page_accessed(page);
> +		if (IS_ENABLED(CONFIG_S390)) {
> +			pte = pte_mkyoung(pte);
> +			if (flags & FOLL_WRITE)
> +				pte = pte_mkdirty(pte);
> +			if (!pte_same(pte, *ptep)) {
> +				set_pte_at(vma->vm_mm, address, ptep, pte);
> +				update_mmu_cache(vma, address, ptep);
> +			}
> +		} else {
> +			if ((flags & FOLL_WRITE) &&
> +			    !pte_dirty(pte) && !PageDirty(page))
> +				set_page_dirty(page);
> +			mark_page_accessed(page);
> +		}
>  	}
>  	if ((flags & FOLL_MLOCK) && (vma->vm_flags & VM_LOCKED)) {
>  		/* Do not mlock pte-mapped THP */

Thanks David, your analysis looks valid, at least it seems that you found
a scenario where we would have HW invalid bit set due to pte_mkold() in
ptep_clear_flush_young(), and still GUP would find and return that page, IIUC.

I think pte handling should be similar to pmd handling in follow_trans_huge_pmd()
-> touch_pmd(), or cow_user_page() (see comment on software "accessed" bits),
which is more or less what your patch does.

Some possible concerns:
- set_page_dirty() would not be done any more for s390, is that intended and ok?
- using set_pte_at() here seems a bit dangerous, as I'm not sure if this will
  always only operate on invalid PTEs. Using it on active valid PTEs could
  result in TLB issues because of missing flush. Also not sure about kvm impact.
  Using ptep_set_access_flags() seems safer, again similar to touch_pmd() and
  also cow_user_page().

Looking at cow_user_page(), I also wonder if the arch_faults_on_old_pte()
logic could be used here. I must admit that I did not really understand the
"losing the dirty bit" part of the comment, but it seems that we might need
to not only check for arch_faults_on_old_pte(), but also for something like
"arch_faults_for_dirty_pte".

Last but not least, IIUC, this issue should affect all archs that return
true on arch_faults_on_old_pte(). After all, the basic problem seems to be
that a pagefault is required for PTEs marked as old, in combination with
GUP still returning a valid page. So maybe this should not be restricted
to IS_ENABLED(CONFIG_S390).
