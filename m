Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C486666FAF
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Jul 2019 15:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727740AbfGLNJZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 09:09:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59026 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727371AbfGLNJZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 09:09:25 -0400
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x6CD7AQ9002189
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 09:09:24 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tpsvfjsng-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 09:09:23 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-fsdevel@vger.kernel.org> from <pasic@linux.ibm.com>;
        Fri, 12 Jul 2019 14:09:20 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com (9.149.109.195)
        by e06smtp03.uk.ibm.com (192.168.101.133) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Fri, 12 Jul 2019 14:09:15 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x6CD9Ewu50593952
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 13:09:14 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2CD22A4051;
        Fri, 12 Jul 2019 13:09:14 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9E5F0A405B;
        Fri, 12 Jul 2019 13:09:13 +0000 (GMT)
Received: from oc2783563651 (unknown [9.152.224.222])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTP;
        Fri, 12 Jul 2019 13:09:13 +0000 (GMT)
Date:   Fri, 12 Jul 2019 15:09:12 +0200
From:   Halil Pasic <pasic@linux.ibm.com>
To:     Thiago Jung Bauermann <bauerman@linux.ibm.com>
Cc:     x86@kernel.org, iommu@lists.linux-foundation.org,
        linux-fsdevel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Mike Anderson <andmike@linux.ibm.com>,
        Ram Pai <linuxram@us.ibm.com>
Subject: Re: [PATCH 3/3] fs/core/vmcore: Move sev_active() reference to x86
 arch code
In-Reply-To: <20190712053631.9814-4-bauerman@linux.ibm.com>
References: <20190712053631.9814-1-bauerman@linux.ibm.com>
        <20190712053631.9814-4-bauerman@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19071213-0012-0000-0000-000003321AC7
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19071213-0013-0000-0000-0000216B8B35
Message-Id: <20190712150912.3097215e.pasic@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-12_04:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=999 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907120143
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 12 Jul 2019 02:36:31 -0300
Thiago Jung Bauermann <bauerman@linux.ibm.com> wrote:

> Secure Encrypted Virtualization is an x86-specific feature, so it shouldn't
> appear in generic kernel code because it forces non-x86 architectures to
> define the sev_active() function, which doesn't make a lot of sense.

sev_active() might be just bad (too specific) name for a general
concept. s390 code defines it drives the right behavior in
kernel/dma/direct.c (which uses it).

> 
> To solve this problem, add an x86 elfcorehdr_read() function to override
> the generic weak implementation. To do that, it's necessary to make
> read_from_oldmem() public so that it can be used outside of vmcore.c.
> 
> Signed-off-by: Thiago Jung Bauermann <bauerman@linux.ibm.com>
> ---
>  arch/x86/kernel/crash_dump_64.c |  5 +++++
>  fs/proc/vmcore.c                |  8 ++++----
>  include/linux/crash_dump.h      | 14 ++++++++++++++
>  include/linux/mem_encrypt.h     |  1 -
>  4 files changed, 23 insertions(+), 5 deletions(-)

Does not seem to apply to today's or yesterdays master.

> 
> diff --git a/arch/x86/kernel/crash_dump_64.c b/arch/x86/kernel/crash_dump_64.c
> index 22369dd5de3b..045e82e8945b 100644
> --- a/arch/x86/kernel/crash_dump_64.c
> +++ b/arch/x86/kernel/crash_dump_64.c
> @@ -70,3 +70,8 @@ ssize_t copy_oldmem_page_encrypted(unsigned long pfn, char *buf, size_t csize,
>  {
>  	return __copy_oldmem_page(pfn, buf, csize, offset, userbuf, true);
>  }
> +
> +ssize_t elfcorehdr_read(char *buf, size_t count, u64 *ppos)
> +{
> +	return read_from_oldmem(buf, count, ppos, 0, sev_active());
> +}
> diff --git a/fs/proc/vmcore.c b/fs/proc/vmcore.c
> index 57957c91c6df..ca1f20bedd8c 100644
> --- a/fs/proc/vmcore.c
> +++ b/fs/proc/vmcore.c
> @@ -100,9 +100,9 @@ static int pfn_is_ram(unsigned long pfn)
>  }
>  
>  /* Reads a page from the oldmem device from given offset. */
> -static ssize_t read_from_oldmem(char *buf, size_t count,
> -				u64 *ppos, int userbuf,
> -				bool encrypted)
> +ssize_t read_from_oldmem(char *buf, size_t count,
> +			 u64 *ppos, int userbuf,
> +			 bool encrypted)
>  {
>  	unsigned long pfn, offset;
>  	size_t nr_bytes;
> @@ -166,7 +166,7 @@ void __weak elfcorehdr_free(unsigned long long addr)
>   */
>  ssize_t __weak elfcorehdr_read(char *buf, size_t count, u64 *ppos)
>  {
> -	return read_from_oldmem(buf, count, ppos, 0, sev_active());
> +	return read_from_oldmem(buf, count, ppos, 0, false);
>  }
>  
>  /*
> diff --git a/include/linux/crash_dump.h b/include/linux/crash_dump.h
> index f774c5eb9e3c..4664fc1871de 100644
> --- a/include/linux/crash_dump.h
> +++ b/include/linux/crash_dump.h
> @@ -115,4 +115,18 @@ static inline int vmcore_add_device_dump(struct vmcoredd_data *data)
>  	return -EOPNOTSUPP;
>  }
>  #endif /* CONFIG_PROC_VMCORE_DEVICE_DUMP */
> +
> +#ifdef CONFIG_PROC_VMCORE
> +ssize_t read_from_oldmem(char *buf, size_t count,
> +			 u64 *ppos, int userbuf,
> +			 bool encrypted);
> +#else
> +static inline ssize_t read_from_oldmem(char *buf, size_t count,
> +				       u64 *ppos, int userbuf,
> +				       bool encrypted)
> +{
> +	return -EOPNOTSUPP;
> +}
> +#endif /* CONFIG_PROC_VMCORE */
> +
>  #endif /* LINUX_CRASHDUMP_H */
> diff --git a/include/linux/mem_encrypt.h b/include/linux/mem_encrypt.h
> index f2e399fb626b..a3747fcae466 100644
> --- a/include/linux/mem_encrypt.h
> +++ b/include/linux/mem_encrypt.h
> @@ -21,7 +21,6 @@
>  
>  #else	/* !CONFIG_ARCH_HAS_MEM_ENCRYPT */
>  
> -static inline bool sev_active(void) { return false; }

This is the implementation for the guys that don't
have ARCH_HAS_MEM_ENCRYPT.

Means sev_active() may not be used in such code after this
patch. What about 

static inline bool force_dma_unencrypted(void)
{
        return sev_active();
}

in kernel/dma/direct.c?

Regards,
Halil

>  static inline bool mem_encrypt_active(void) { return false; }
>  
>  #endif	/* CONFIG_ARCH_HAS_MEM_ENCRYPT */

