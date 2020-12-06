Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA1562D0363
	for <lists+linux-fsdevel@lfdr.de>; Sun,  6 Dec 2020 12:31:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727387AbgLFLbI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 6 Dec 2020 06:31:08 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:30824 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725804AbgLFLbH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 6 Dec 2020 06:31:07 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B6B2ZE7100701;
        Sun, 6 Dec 2020 06:29:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=sTdeJYkg7s4jW58KjlXSO7YK0Uj/BAuS89bh+WjYExs=;
 b=Rp75CbhEeYCx5VHn/zmMQm/6S+m39d3Usre2min80jBkGcuIUAFLlD1U/x+1W8OWJjzt
 fIMqDyMisdQYl1mM9UyniGF2F3wozFBhPxC8o45xaq4jdyxerJ/476m3OKpNWyqX75Ot
 ZzHIhjFleohS0jG/BTw5yXvXzCYd99hKPpieya0mzuihgbkU/MAWYg+oHQUWV/VR679y
 Kd89sxaBExZT7E3BQljYIuSDAN6L4oWyttmbEubp0O3I6HjC9jWAiHlf70CcFuUqDoNe
 FV1XlQNsQrd7V/hGnlvfLCY1r7+QZ+WUan1OAetcBZbmpiv0Bnk27tfchh/UmmiiMr/D dw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0b-001b2d01.pphosted.com with ESMTP id 358rby5k22-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 06:29:52 -0500
Received: from m0098413.ppops.net (m0098413.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B6BP7Pa153868;
        Sun, 6 Dec 2020 06:29:52 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0b-001b2d01.pphosted.com with ESMTP id 358rby5k1m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 06:29:51 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B6BRVQk019021;
        Sun, 6 Dec 2020 11:29:50 GMT
Received: from b06avi18626390.portsmouth.uk.ibm.com (b06avi18626390.portsmouth.uk.ibm.com [9.149.26.192])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8hkbt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sun, 06 Dec 2020 11:29:49 +0000
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06avi18626390.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B6BSWTZ56295740
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sun, 6 Dec 2020 11:28:32 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9A4D9A404D;
        Sun,  6 Dec 2020 11:28:32 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C1635A4040;
        Sun,  6 Dec 2020 11:28:28 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Sun,  6 Dec 2020 11:28:28 +0000 (GMT)
Date:   Sun, 6 Dec 2020 13:28:26 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        David Hildenbrand <david@redhat.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Shuah Khan <shuah@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v14 04/10] set_memory: allow querying whether
 set_direct_map_*() is actually enabled
Message-ID: <20201206112826.GB123287@linux.ibm.com>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-5-rppt@kernel.org>
 <20201203153610.724f40f26ca1620247bc6b09@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203153610.724f40f26ca1620247bc6b09@linux-foundation.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.312,18.0.737
 definitions=2020-12-06_06:2020-12-04,2020-12-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=1
 impostorscore=0 spamscore=0 priorityscore=1501 lowpriorityscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012060066
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Dec 03, 2020 at 03:36:10PM -0800, Andrew Morton wrote:
> On Thu,  3 Dec 2020 08:29:43 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > On arm64, set_direct_map_*() functions may return 0 without actually
> > changing the linear map. This behaviour can be controlled using kernel
> > parameters, so we need a way to determine at runtime whether calls to
> > set_direct_map_invalid_noflush() and set_direct_map_default_noflush() have
> > any effect.
> > 
> > Extend set_memory API with can_set_direct_map() function that allows
> > checking if calling set_direct_map_*() will actually change the page table,
> > replace several occurrences of open coded checks in arm64 with the new
> > function and provide a generic stub for architectures that always modify
> > page tables upon calls to set_direct_map APIs.
> > 
> > ...
> >
> > --- a/arch/arm64/mm/mmu.c
> > +++ b/arch/arm64/mm/mmu.c
> > @@ -22,6 +22,7 @@
> >  #include <linux/io.h>
> >  #include <linux/mm.h>
> >  #include <linux/vmalloc.h>
> > +#include <linux/set_memory.h>
> >  
> >  #include <asm/barrier.h>
> >  #include <asm/cputype.h>
> > @@ -477,7 +478,7 @@ static void __init map_mem(pgd_t *pgdp)
> >  	int flags = 0;
> >  	u64 i;
> >  
> > -	if (rodata_full || debug_pagealloc_enabled())
> > +	if (can_set_direct_map())
> >  		flags = NO_BLOCK_MAPPINGS | NO_CONT_MAPPINGS;
> 
> Changes in -next turned this into
> 
> 	if (can_set_direct_map() || crash_mem_map)

Thanks for updating!

-- 
Sincerely yours,
Mike.
