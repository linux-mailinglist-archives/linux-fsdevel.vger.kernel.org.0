Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A468365A19
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Apr 2021 15:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbhDTN3g (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Apr 2021 09:29:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59292 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232303AbhDTN3e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Apr 2021 09:29:34 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 13KD47xG166663;
        Tue, 20 Apr 2021 09:28:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=r7qXV4Ucbak5vgyd7ROLcIVKBZPYTemDw/ykiqY6SYg=;
 b=rPwYaU9qq29kTTv0X6zWH+Y9QoAMMR0r066osBDtHrVhZOYmI9YInWAOQ/heN4U1jksZ
 P6nrQ47gkG3vD1J0wFYkrV2iqUGVA5SkDHNnXKeA7nfYj3wuYwVf1qby0QapVz59LSxF
 PhK/2/kDgm3LSaspO1FoGmtFbeNbrT10viQlZ/MsS3Zm6BS79kRvTa1uuficT/8p5SOf
 UxC4pdex+SKH5QcWFLfR3DOTsrZ+Mw+4/iz+JUDojr2v1sLxGemMCDPpHf+OpmL34ZqX
 QxsxUmF0n55SOkaBzgzvZRsRH1qa/IebOfOACABu8ZikMuRL/2zvH6BbZOg4Pcp6s2/K fA== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381y7x9dvp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 09:28:09 -0400
Received: from m0098409.ppops.net (m0098409.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 13KD49if166797;
        Tue, 20 Apr 2021 09:28:09 -0400
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com with ESMTP id 381y7x9dtm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 09:28:09 -0400
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 13KDR9YH006552;
        Tue, 20 Apr 2021 13:28:06 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma02fra.de.ibm.com with ESMTP id 37yqa88xvx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 20 Apr 2021 13:28:06 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 13KDReOM28508444
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 20 Apr 2021 13:27:40 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 5ED9F4C050;
        Tue, 20 Apr 2021 13:28:03 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id EA5B34C044;
        Tue, 20 Apr 2021 13:27:58 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.82.136])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue, 20 Apr 2021 13:27:58 +0000 (GMT)
Date:   Tue, 20 Apr 2021 16:27:56 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Matthew Garrett <mjg59@srcf.ucam.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michal Hocko <mhocko@suse.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        Yury Norov <yury.norov@gmail.com>, linux-api@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v2 1/2] secretmem/gup: don't check if page is secretmem
 without reference
Message-ID: <YH7W3MBR+XdyxlA7@linux.ibm.com>
References: <20210420131611.8259-1-rppt@kernel.org>
 <20210420131611.8259-2-rppt@kernel.org>
 <95b7fa81-f72e-c63f-0456-4c25dee8a5eb@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <95b7fa81-f72e-c63f-0456-4c25dee8a5eb@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: umV0ysjUL103wxbfICo-4xhYTSyDzIUb
X-Proofpoint-ORIG-GUID: dTV5P955knNPQLGIoMCHqafXwNzdKxMI
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-04-20_06:2021-04-20,2021-04-20 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 phishscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 mlxscore=0 mlxlogscore=682 bulkscore=0 suspectscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2104060000 definitions=main-2104200098
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 20, 2021 at 03:19:56PM +0200, David Hildenbrand wrote:
> On 20.04.21 15:16, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The check in gup_pte_range() whether a page belongs to a secretmem mapping
> > is performed before grabbing the page reference.
> > 
> > To avoid potential race move the check after try_grab_compound_head().
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >   mm/gup.c | 6 +++---
> >   1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/mm/gup.c b/mm/gup.c
> > index c3a17b189064..4b58c016e949 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -2080,13 +2080,13 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> >   		VM_BUG_ON(!pfn_valid(pte_pfn(pte)));
> >   		page = pte_page(pte);
> > -		if (page_is_secretmem(page))
> > -			goto pte_unmap;
> > -
> >   		head = try_grab_compound_head(page, 1, flags);
> >   		if (!head)
> >   			goto pte_unmap;
> > +		if (page_is_secretmem(page))
> > +			goto pte_unmap;
> > +
> 
> Looking at the hunk below, I wonder if you're missing a put_compound_head().

Hmm, yes.
 
> (also, I'd do if unlikely(page_is_secretmem()) but that's a different
> discussion)

I don't mind, actually. I don't think there would be massive secretmem
usage soon.

> >   		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> >   			put_compound_head(head, 1, flags);
> >   			goto pte_unmap;
> > 
> 
> 
> -- 
> Thanks,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.
