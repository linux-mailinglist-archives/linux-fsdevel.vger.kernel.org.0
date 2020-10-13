Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8341528D3AC
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Oct 2020 20:31:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729755AbgJMSbx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Oct 2020 14:31:53 -0400
Received: from mga18.intel.com ([134.134.136.126]:39019 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726899AbgJMSbx (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Oct 2020 14:31:53 -0400
IronPort-SDR: W8xiilTl3OxH88FCikgy1IOVIU6wcB8PvfhYPPZmjweOK2+8giAVSEDMuyYi9VfZKLhhtV00Li
 LJlK0kbY9ycg==
X-IronPort-AV: E=McAfee;i="6000,8403,9773"; a="153794227"
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="153794227"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:31:45 -0700
IronPort-SDR: N1xn0HQI0ubXW+ZZ5gn2QreU7BQoHP/0atyUS215Vn7NRjG/ItSebl73LdP+GjPjSK62O2AOZS
 e/mlDqFbQs2A==
X-IronPort-AV: E=Sophos;i="5.77,371,1596524400"; 
   d="scan'208";a="346279150"
Received: from murawskx-mobl.amr.corp.intel.com (HELO [10.209.9.29]) ([10.209.9.29])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Oct 2020 11:31:45 -0700
Subject: Re: [PATCH RFC V3 4/9] x86/pks: Preserve the PKRS MSR on context
 switch
To:     ira.weiny@intel.com, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     Fenghua Yu <fenghua.yu@intel.com>, x86@kernel.org,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-kselftest@vger.kernel.org
References: <20201009194258.3207172-1-ira.weiny@intel.com>
 <20201009194258.3207172-5-ira.weiny@intel.com>
From:   Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
 z5cecg==
Message-ID: <429789d3-ab5b-49c3-65c3-f0fc30a12516@intel.com>
Date:   Tue, 13 Oct 2020 11:31:45 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201009194258.3207172-5-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 10/9/20 12:42 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> The PKRS MSR is defined as a per-logical-processor register.  This
> isolates memory access by logical CPU.  Unfortunately, the MSR is not
> managed by XSAVE.  Therefore, tasks must save/restore the MSR value on
> context switch.
> 
> Define a saved PKRS value in the task struct, as well as a cached
> per-logical-processor MSR value which mirrors the MSR value of the
> current CPU.  Initialize all tasks with the default MSR value.  Then, on
> schedule in, check the saved task MSR vs the per-cpu value.  If
> different proceed to write the MSR.  If not avoid the overhead of the
> MSR write and continue.

It's probably nice to note how the WRMSR is special here, in addition to
the comments below.

>  #endif /*_ASM_X86_PKEYS_INTERNAL_H */
> diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
> index 97143d87994c..da2381136b2d 100644
> --- a/arch/x86/include/asm/processor.h
> +++ b/arch/x86/include/asm/processor.h
> @@ -18,6 +18,7 @@ struct vm86;
>  #include <asm/cpufeatures.h>
>  #include <asm/page.h>
>  #include <asm/pgtable_types.h>
> +#include <asm/pkeys_common.h>
>  #include <asm/percpu.h>
>  #include <asm/msr.h>
>  #include <asm/desc_defs.h>
> @@ -542,6 +543,11 @@ struct thread_struct {
>  
>  	unsigned int		sig_on_uaccess_err:1;
>  
> +#ifdef	CONFIG_ARCH_HAS_SUPERVISOR_PKEYS
> +	/* Saved Protection key register for supervisor mappings */
> +	u32			saved_pkrs;
> +#endif

Could you take a look around thread_struct and see if there are some
other MSRs near which you can stash this?  This seems like a bit of a
lonely place.

...
>  void flush_thread(void)
>  {
>  	struct task_struct *tsk = current;
> @@ -195,6 +212,8 @@ void flush_thread(void)
>  	memset(tsk->thread.tls_array, 0, sizeof(tsk->thread.tls_array));
>  
>  	fpu__clear_all(&tsk->thread.fpu);
> +
> +	pks_init_task(tsk);
>  }
>  
>  void disable_TSC(void)
> @@ -644,6 +663,8 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p)
>  
>  	if ((tifp ^ tifn) & _TIF_SLD)
>  		switch_to_sld(tifn);
> +
> +	pks_sched_in();
>  }
>  
>  /*
> diff --git a/arch/x86/mm/pkeys.c b/arch/x86/mm/pkeys.c
> index 3cf8f775f36d..30f65dd3d0c5 100644
> --- a/arch/x86/mm/pkeys.c
> +++ b/arch/x86/mm/pkeys.c
> @@ -229,3 +229,31 @@ u32 update_pkey_val(u32 pk_reg, int pkey, unsigned int flags)
>  
>  	return pk_reg;
>  }
> +
> +DEFINE_PER_CPU(u32, pkrs_cache);
> +
> +/**
> + * It should also be noted that the underlying WRMSR(MSR_IA32_PKRS) is not
> + * serializing but still maintains ordering properties similar to WRPKRU.
> + * The current SDM section on PKRS needs updating but should be the same as
> + * that of WRPKRU.  So to quote from the WRPKRU text:
> + *
> + * 	WRPKRU will never execute transiently. Memory accesses
> + * 	affected by PKRU register will not execute (even transiently)
> + * 	until all prior executions of WRPKRU have completed execution
> + * 	and updated the PKRU register.
> + */
> +void write_pkrs(u32 new_pkrs)
> +{
> +	u32 *pkrs;
> +
> +	if (!static_cpu_has(X86_FEATURE_PKS))
> +		return;
> +
> +	pkrs = get_cpu_ptr(&pkrs_cache);
> +	if (*pkrs != new_pkrs) {
> +		*pkrs = new_pkrs;
> +		wrmsrl(MSR_IA32_PKRS, new_pkrs);
> +	}
> +	put_cpu_ptr(pkrs);
> +}
> 

It bugs me a *bit* that this is being called in a preempt-disabled
region, but we still bother with the get/put_cpu jazz.  Are there other
future call-sites for this that aren't in preempt-disabled regions?
