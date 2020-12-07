Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 141AC2D156E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  7 Dec 2020 17:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727226AbgLGQB4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Dec 2020 11:01:56 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:12020 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726891AbgLGQBz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Dec 2020 11:01:55 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 0B7FWp04062929;
        Mon, 7 Dec 2020 11:00:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=k1wpCQsort0IzYh/DjMW0A6+snT0JIYuzCRTR+TV2H4=;
 b=IlBG77CHhECNohXSJ7vbdMx4y6/Bb0nbUjONmUvdIPakRhIy8FzBasmfI8eWl58TeyVN
 Kjtc8pUHgh+2ap1XV+1HEBI0+A2LQX6fYvD1s9/Ee93E3Pt/pEkon88XOPnHqYaV33qG
 IDmFGTAyeyO0YatqA+ifqGAhT3juO7yNH9ZnqZMiOOcMOb5Flu6zksHQd0UI/0phjlqU
 KUUjCGjlfeXc00yPS4L3jQSexQSryZYCWacgb0LfNoCHdrwOk5fBrEfZMXNqtop2m89t
 /SVlnxsj2ypv8tL3Dd2lqptfmVSqPLSJuTwjBOQfO7woEZTjBjelkB6wa+8ncw9vZALb Pw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359pyghad7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 11:00:19 -0500
Received: from m0098421.ppops.net (m0098421.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 0B7FtVmR167099;
        Mon, 7 Dec 2020 11:00:18 -0500
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 359pyghaau-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 11:00:18 -0500
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.0.42/8.16.0.42) with SMTP id 0B7Fs0JH028499;
        Mon, 7 Dec 2020 16:00:15 GMT
Received: from b06cxnps4074.portsmouth.uk.ibm.com (d06relay11.portsmouth.uk.ibm.com [9.149.109.196])
        by ppma03fra.de.ibm.com with ESMTP id 3581u8kvwx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Dec 2020 16:00:15 +0000
Received: from d06av22.portsmouth.uk.ibm.com (d06av22.portsmouth.uk.ibm.com [9.149.105.58])
        by b06cxnps4074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 0B7G0Dr845416766
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Dec 2020 16:00:13 GMT
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0BD254C071;
        Mon,  7 Dec 2020 16:00:13 +0000 (GMT)
Received: from d06av22.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id B96F74C070;
        Mon,  7 Dec 2020 16:00:08 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.145.50.18])
        by d06av22.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Dec 2020 16:00:08 +0000 (GMT)
Date:   Mon, 7 Dec 2020 18:00:06 +0200
From:   Mike Rapoport <rppt@linux.ibm.com>
To:     Qian Cai <qcai@redhat.com>
Cc:     Mike Rapoport <rppt@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        x86@kernel.org, Palmer Dabbelt <palmerdabbelt@google.com>
Subject: Re: [PATCH v14 09/10] arch, mm: wire up memfd_secret system call
 were relevant
Message-ID: <20201207160006.GG1112728@linux.ibm.com>
References: <20201203062949.5484-1-rppt@kernel.org>
 <20201203062949.5484-10-rppt@kernel.org>
 <81631d3391abca3f41f2e19092b97a61d49f4e44.camel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <81631d3391abca3f41f2e19092b97a61d49f4e44.camel@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.343,18.0.737
 definitions=2020-12-07_11:2020-12-04,2020-12-07 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=849 spamscore=0
 phishscore=0 bulkscore=0 clxscore=1015 priorityscore=1501 adultscore=0
 impostorscore=0 mlxscore=0 malwarescore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2012070098
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 07, 2020 at 09:45:59AM -0500, Qian Cai wrote:
> On Thu, 2020-12-03 at 08:29 +0200, Mike Rapoport wrote:

...

> > diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
> > index 6d55324363ab..f9d93fbf9b69 100644
> > --- a/include/linux/syscalls.h
> > +++ b/include/linux/syscalls.h
> > @@ -1010,6 +1010,7 @@ asmlinkage long sys_pidfd_send_signal(int pidfd, int sig,
> >  asmlinkage long sys_pidfd_getfd(int pidfd, int fd, unsigned int flags);
> >  asmlinkage long sys_watch_mount(int dfd, const char __user *path,
> >  				unsigned int at_flags, int watch_fd, int watch_id);
> > +asmlinkage long sys_memfd_secret(unsigned long flags);
> >  
> >  /*
> >   * Architecture-specific system calls
> > diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
> > index 5df46517260e..51151888f330 100644
> > --- a/include/uapi/asm-generic/unistd.h
> > +++ b/include/uapi/asm-generic/unistd.h
> > @@ -861,9 +861,13 @@ __SYSCALL(__NR_faccessat2, sys_faccessat2)
> >  __SYSCALL(__NR_process_madvise, sys_process_madvise)
> >  #define __NR_watch_mount 441
> >  __SYSCALL(__NR_watch_mount, sys_watch_mount)
> > +#ifdef __ARCH_WANT_MEMFD_SECRET
> > +#define __NR_memfd_secret 442
> > +__SYSCALL(__NR_memfd_secret, sys_memfd_secret)
> > +#endif
> 
> I can't see where was it defined for arm64 after it looks like Andrew has
> deleted the  above chunk. Thus, we have a warning using this .config:
> 
> https://cailca.coding.net/public/linux/mm/git/files/master/arm64.config
> 
> <stdin>:1539:2: warning: #warning syscall memfd_secret not implemented [-Wcpp]

I was under the impression that Andrew only removed the #ifdef...

Andrew, can you please restore syscall definition for memfd_secret() in
include/uapi/asm-generic/unistd.h?

> >  
> >  #undef __NR_syscalls
> > -#define __NR_syscalls 442
> > +#define __NR_syscalls 443
> >  
> >  /*
> >   * 32 bit systems traditionally used different
> > diff --git a/mm/secretmem.c b/mm/secretmem.c
> > index 7236f4d9458a..b8a32954ac68 100644
> > --- a/mm/secretmem.c
> > +++ b/mm/secretmem.c
> > @@ -415,6 +415,9 @@ static int __init secretmem_setup(char *str)
> >  	unsigned long reserved_size;
> >  	int err;
> >  
> > +	if (!can_set_direct_map())
> > +		return 0;
> > +
> >  	reserved_size = memparse(str, NULL);
> >  	if (!reserved_size)
> >  		return 0;
> > diff --git a/scripts/checksyscalls.sh b/scripts/checksyscalls.sh
> > index a18b47695f55..b7609958ee36 100755
> > --- a/scripts/checksyscalls.sh
> > +++ b/scripts/checksyscalls.sh
> > @@ -40,6 +40,10 @@ cat << EOF
> >  #define __IGNORE_setrlimit	/* setrlimit */
> >  #endif
> >  
> > +#ifndef __ARCH_WANT_MEMFD_SECRET
> > +#define __IGNORE_memfd_secret
> > +#endif
> > +
> >  /* Missing flags argument */
> >  #define __IGNORE_renameat	/* renameat2 */
> >  
> 

-- 
Sincerely yours,
Mike.
