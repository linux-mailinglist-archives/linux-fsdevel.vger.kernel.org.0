Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFB3823DA5D
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Aug 2020 14:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726955AbgHFLOr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 6 Aug 2020 07:14:47 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:20456 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726490AbgHFLNv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 6 Aug 2020 07:13:51 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 076AX2Zk023945;
        Thu, 6 Aug 2020 07:10:47 -0400
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rdt2n6mc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 07:10:47 -0400
Received: from m0098417.ppops.net (m0098417.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 076AeeeC049571;
        Thu, 6 Aug 2020 07:10:46 -0400
Received: from ppma06ams.nl.ibm.com (66.31.33a9.ip4.static.sl-reverse.com [169.51.49.102])
        by mx0a-001b2d01.pphosted.com with ESMTP id 32rdt2n6ht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 07:10:46 -0400
Received: from pps.filterd (ppma06ams.nl.ibm.com [127.0.0.1])
        by ppma06ams.nl.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 076B7Jv2015021;
        Thu, 6 Aug 2020 11:10:44 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma06ams.nl.ibm.com with ESMTP id 32mynh5cuj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 06 Aug 2020 11:10:44 +0000
Received: from d06av26.portsmouth.uk.ibm.com (d06av26.portsmouth.uk.ibm.com [9.149.105.62])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 076BAf3t30736750
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 6 Aug 2020 11:10:41 GMT
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id C2F7CAE05A;
        Thu,  6 Aug 2020 11:10:41 +0000 (GMT)
Received: from d06av26.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 7CDD7AE063;
        Thu,  6 Aug 2020 11:10:38 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.24.39])
        by d06av26.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Thu,  6 Aug 2020 11:10:38 +0000 (GMT)
Date:   Thu, 6 Aug 2020 14:10:36 +0300
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     "Kirill A. Shutemov" <kirill@shutemov.name>
Cc:     Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christopher Lameter <cl@linux.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Idan Yaniv <idan.yaniv@ibm.com>,
        Ingo Molnar <mingo@redhat.com>,
        James Bottomley <jejb@linux.ibm.com>,
        Matthew Wilcox <willy@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Michael Kerrisk <mtk.manpages@gmail.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tycho Andersen <tycho@tycho.ws>, Will Deacon <will@kernel.org>,
        linux-api@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-nvdimm@lists.01.org, linux-riscv@lists.infradead.org,
        x86@kernel.org
Subject: Re: [PATCH v3 1/6] mm: add definition of PMD_PAGE_ORDER
Message-ID: <20200806111036.GJ163101@linux.ibm.com>
References: <20200804095035.18778-1-rppt@kernel.org>
 <20200804095035.18778-2-rppt@kernel.org>
 <20200806101112.bjw4mxu2odpsg2hh@box>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806101112.bjw4mxu2odpsg2hh@box>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.235,18.0.687
 definitions=2020-08-06_06:2020-08-06,2020-08-06 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 mlxlogscore=997 clxscore=1011 suspectscore=1 spamscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2008060075
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 06, 2020 at 01:11:12PM +0300, Kirill A. Shutemov wrote:
> On Tue, Aug 04, 2020 at 12:50:30PM +0300, Mike Rapoport wrote:
> > From: Mike Rapoport <rppt@linux.ibm.com>
> > 
> > The definition of PMD_PAGE_ORDER denoting the number of base pages in the
> > second-level leaf page is already used by DAX and maybe handy in other
> > cases as well.
> > 
> > Several architectures already have definition of PMD_ORDER as the size of
> > second level page table, so to avoid conflict with these definitions use
> > PMD_PAGE_ORDER name and update DAX respectively.
> > 
> > Signed-off-by: Mike Rapoport <rppt@linux.ibm.com>
> > ---
> >  fs/dax.c                | 10 +++++-----
> >  include/linux/pgtable.h |  3 +++
> >  2 files changed, 8 insertions(+), 5 deletions(-)
> > 
> > diff --git a/fs/dax.c b/fs/dax.c
> > index 11b16729b86f..b91d8c8dda45 100644
> > --- a/fs/dax.c
> > +++ b/fs/dax.c
> > @@ -50,7 +50,7 @@ static inline unsigned int pe_order(enum page_entry_size pe_size)
> >  #define PG_PMD_NR	(PMD_SIZE >> PAGE_SHIFT)
> >  
> >  /* The order of a PMD entry */
> > -#define PMD_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> > +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> 
> Hm. Wouldn't it conflict with definition in pgtable.h? Or should we
> include it instead?

Actually I meant to remove it here and keep only the definition in
pgtable.h.
Will fix.

> > diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> > index 56c1e8eb7bb0..79f8443609e7 100644
> > --- a/include/linux/pgtable.h
> > +++ b/include/linux/pgtable.h
> > @@ -28,6 +28,9 @@
> >  #define USER_PGTABLES_CEILING	0UL
> >  #endif
> >  
> > +/* Number of base pages in a second level leaf page */
> > +#define PMD_PAGE_ORDER	(PMD_SHIFT - PAGE_SHIFT)
> > +
> >  /*
> >   * A page table page can be thought of an array like this: pXd_t[PTRS_PER_PxD]
> >   *
> 
> -- 
>  Kirill A. Shutemov

-- 
Sincerely yours,
Mike.
