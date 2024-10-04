Return-Path: <linux-fsdevel+bounces-30926-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4894098FBEA
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 03:21:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D14F283EE0
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2024 01:21:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B1E156CF;
	Fri,  4 Oct 2024 01:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NA8l0VHt"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C69128F0;
	Fri,  4 Oct 2024 01:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728004869; cv=none; b=Pt9Fvb6bvmbMrM73VQey+FZpbgd6OQAgC3hIM24TkYX4hkGqaUyeuufzvaVSkGcbgIGR3+VsgtiKFxRzPLjRBHq5gCHxAVR5FKvnsfZlVzMFgUXz7nbDP5qBET/k+zesz0Z4lRXYbMfXT3zsWNtNXhU3cX0KyxhZk3OIho+M0yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728004869; c=relaxed/simple;
	bh=XAwp1HajigedLWPNyvDA2B/OVsp5lSLx9eQxfxT3RdA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y+1Mhht9ZZoCxcwDkSxIK/EiQ98onmg9tSjz45utzfWPjFRB8rM3nUq1V4e5XDtIcOiLTer80bjo5c8P5VgV8KGJ5gQB9Bg1YfdZHgntWLcADPR7pTu5HY9rcNIPMzd7exAOWDhG2cPYY0atkVqfZEc/teSnYUHzCiVAT0ytDXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NA8l0VHt; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728004867; x=1759540867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=XAwp1HajigedLWPNyvDA2B/OVsp5lSLx9eQxfxT3RdA=;
  b=NA8l0VHt/g2yXBxK1Ir7eO67PDYRZhBFcJH3rpEmQZ+zwhJwJQYWxoRc
   UvUQzrmZzYRq6wxnAr1VnIJr8WYHpH1XvUAiIF4KG1LBnEksaG4zW1LRI
   dDdS6B3Y+TekdOMpNhyIK+HF89PCMxmWF3xtu9ZyMlm+v2Selj8FiDJgT
   zFHTzponPizRj5rqX3GEQL/bGzI4Af9oIE+RzPZyaOfh4d5g47fEx22XJ
   kytxxUjSqDVoein/NJO6IzV33zdigCLh7/kBGRKOBbhbov4jf4khYgcv7
   ImftI8JNK+spsAQ+QjZBeacEp3ceN5xhZHzgoq8PyPjr4B4IBMcas116U
   A==;
X-CSE-ConnectionGUID: Fh18YlQcQR+U+IZ4DxRmjA==
X-CSE-MsgGUID: 21HWNlupQeGRxbwI8K+y0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11214"; a="26689231"
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="26689231"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2024 18:21:06 -0700
X-CSE-ConnectionGUID: 1PmMfVzDQZqzvxQvcU6udQ==
X-CSE-MsgGUID: fxKs9q26TUComuwqMFdUkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,176,1725346800"; 
   d="scan'208";a="74234010"
Received: from lkp-server01.sh.intel.com (HELO a48cf1aa22e8) ([10.239.97.150])
  by fmviesa007.fm.intel.com with ESMTP; 03 Oct 2024 18:20:58 -0700
Received: from kbuild by a48cf1aa22e8 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1swX04-000160-07;
	Fri, 04 Oct 2024 01:20:56 +0000
Date: Fri, 4 Oct 2024 09:20:32 +0800
From: kernel test robot <lkp@intel.com>
To: Deepak Gupta <debug@rivosinc.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Conor Dooley <conor@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Christian Brauner <brauner@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Eric Biederman <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>
Cc: oe-kbuild-all@lists.linux.dev,
	Linux Memory Management List <linux-mm@kvack.org>,
	linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	linux-riscv@lists.infradead.org, devicetree@vger.kernel.org,
	linux-arch@vger.kernel.org
Subject: Re: [PATCH 22/33] riscv: signal: abstract header saving for
 setup_sigcontext
Message-ID: <202410040912.4TpCD7iU-lkp@intel.com>
References: <20241001-v5_user_cfi_series-v1-22-3ba65b6e550f@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241001-v5_user_cfi_series-v1-22-3ba65b6e550f@rivosinc.com>

Hi Deepak,

kernel test robot noticed the following build errors:

[auto build test ERROR on 9852d85ec9d492ebef56dc5f229416c925758edc]

url:    https://github.com/intel-lab-lkp/linux/commits/Deepak-Gupta/mm-Introduce-ARCH_HAS_USER_SHADOW_STACK/20241002-000937
base:   9852d85ec9d492ebef56dc5f229416c925758edc
patch link:    https://lore.kernel.org/r/20241001-v5_user_cfi_series-v1-22-3ba65b6e550f%40rivosinc.com
patch subject: [PATCH 22/33] riscv: signal: abstract header saving for setup_sigcontext
config: riscv-allnoconfig (https://download.01.org/0day-ci/archive/20241004/202410040912.4TpCD7iU-lkp@intel.com/config)
compiler: riscv64-linux-gcc (GCC) 14.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20241004/202410040912.4TpCD7iU-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202410040912.4TpCD7iU-lkp@intel.com/

All errors (new ones prefixed by >>):

   arch/riscv/kernel/signal.c: In function 'save_v_state':
>> arch/riscv/kernel/signal.c:89:9: error: implicit declaration of function 'get_cpu_vector_context' [-Wimplicit-function-declaration]
      89 |         get_cpu_vector_context();
         |         ^~~~~~~~~~~~~~~~~~~~~~
>> arch/riscv/kernel/signal.c:91:9: error: implicit declaration of function 'put_cpu_vector_context' [-Wimplicit-function-declaration]
      91 |         put_cpu_vector_context();
         |         ^~~~~~~~~~~~~~~~~~~~~~
   arch/riscv/kernel/signal.c: In function '__restore_v_state':
>> arch/riscv/kernel/signal.c:123:9: error: implicit declaration of function 'riscv_v_vstate_set_restore'; did you mean 'riscv_v_vstate_restore'? [-Wimplicit-function-declaration]
     123 |         riscv_v_vstate_set_restore(current, regs);
         |         ^~~~~~~~~~~~~~~~~~~~~~~~~~
         |         riscv_v_vstate_restore


vim +/get_cpu_vector_context +89 arch/riscv/kernel/signal.c

e2c0cdfba7f699 Palmer Dabbelt 2017-07-10   70  
3fad3080e143f7 Andy Chiu      2024-10-01   71  static long save_v_state(struct pt_regs *regs, void __user *sc_vec)
8ee0b41898fa26 Greentime Hu   2023-06-05   72  {
8ee0b41898fa26 Greentime Hu   2023-06-05   73  	struct __sc_riscv_v_state __user *state;
8ee0b41898fa26 Greentime Hu   2023-06-05   74  	void __user *datap;
8ee0b41898fa26 Greentime Hu   2023-06-05   75  	long err;
8ee0b41898fa26 Greentime Hu   2023-06-05   76  
3fad3080e143f7 Andy Chiu      2024-10-01   77  	if (!IS_ENABLED(CONFIG_RISCV_ISA_V) ||
3fad3080e143f7 Andy Chiu      2024-10-01   78  		!(has_vector() && riscv_v_vstate_query(regs)))
3fad3080e143f7 Andy Chiu      2024-10-01   79  		return 0;
3fad3080e143f7 Andy Chiu      2024-10-01   80  
3fad3080e143f7 Andy Chiu      2024-10-01   81  	/* Place state to the user's signal context spac */
3fad3080e143f7 Andy Chiu      2024-10-01   82  	state = (struct __sc_riscv_v_state __user *)sc_vec;
8ee0b41898fa26 Greentime Hu   2023-06-05   83  	/* Point datap right after the end of __sc_riscv_v_state */
8ee0b41898fa26 Greentime Hu   2023-06-05   84  	datap = state + 1;
8ee0b41898fa26 Greentime Hu   2023-06-05   85  
8ee0b41898fa26 Greentime Hu   2023-06-05   86  	/* datap is designed to be 16 byte aligned for better performance */
1d20e5d437cfeb Zhongqiu Han   2024-06-20   87  	WARN_ON(!IS_ALIGNED((unsigned long)datap, 16));
8ee0b41898fa26 Greentime Hu   2023-06-05   88  
7df56cbc27e423 Andy Chiu      2024-01-15  @89  	get_cpu_vector_context();
d6c78f1ca3e8ec Andy Chiu      2024-01-15   90  	riscv_v_vstate_save(&current->thread.vstate, regs);
7df56cbc27e423 Andy Chiu      2024-01-15  @91  	put_cpu_vector_context();
7df56cbc27e423 Andy Chiu      2024-01-15   92  
8ee0b41898fa26 Greentime Hu   2023-06-05   93  	/* Copy everything of vstate but datap. */
8ee0b41898fa26 Greentime Hu   2023-06-05   94  	err = __copy_to_user(&state->v_state, &current->thread.vstate,
8ee0b41898fa26 Greentime Hu   2023-06-05   95  			     offsetof(struct __riscv_v_ext_state, datap));
8ee0b41898fa26 Greentime Hu   2023-06-05   96  	/* Copy the pointer datap itself. */
869436dae72acf Ben Dooks      2023-11-23   97  	err |= __put_user((__force void *)datap, &state->v_state.datap);
8ee0b41898fa26 Greentime Hu   2023-06-05   98  	/* Copy the whole vector content to user space datap. */
8ee0b41898fa26 Greentime Hu   2023-06-05   99  	err |= __copy_to_user(datap, current->thread.vstate.datap, riscv_v_vsize);
8ee0b41898fa26 Greentime Hu   2023-06-05  100  	if (unlikely(err))
3fad3080e143f7 Andy Chiu      2024-10-01  101  		return -EFAULT;
8ee0b41898fa26 Greentime Hu   2023-06-05  102  
3fad3080e143f7 Andy Chiu      2024-10-01  103  	/* Only return the size if everything has done successfully  */
3fad3080e143f7 Andy Chiu      2024-10-01  104  	return riscv_v_sc_size;
8ee0b41898fa26 Greentime Hu   2023-06-05  105  }
8ee0b41898fa26 Greentime Hu   2023-06-05  106  
8ee0b41898fa26 Greentime Hu   2023-06-05  107  /*
8ee0b41898fa26 Greentime Hu   2023-06-05  108   * Restore Vector extension context from the user's signal frame. This function
8ee0b41898fa26 Greentime Hu   2023-06-05  109   * assumes a valid extension header. So magic and size checking must be done by
8ee0b41898fa26 Greentime Hu   2023-06-05  110   * the caller.
8ee0b41898fa26 Greentime Hu   2023-06-05  111   */
8ee0b41898fa26 Greentime Hu   2023-06-05  112  static long __restore_v_state(struct pt_regs *regs, void __user *sc_vec)
8ee0b41898fa26 Greentime Hu   2023-06-05  113  {
8ee0b41898fa26 Greentime Hu   2023-06-05  114  	long err;
8ee0b41898fa26 Greentime Hu   2023-06-05  115  	struct __sc_riscv_v_state __user *state = sc_vec;
8ee0b41898fa26 Greentime Hu   2023-06-05  116  	void __user *datap;
8ee0b41898fa26 Greentime Hu   2023-06-05  117  
c27fa53b858b4e Björn Töpel    2024-04-03  118  	/*
c27fa53b858b4e Björn Töpel    2024-04-03  119  	 * Mark the vstate as clean prior performing the actual copy,
c27fa53b858b4e Björn Töpel    2024-04-03  120  	 * to avoid getting the vstate incorrectly clobbered by the
c27fa53b858b4e Björn Töpel    2024-04-03  121  	 *  discarded vector state.
c27fa53b858b4e Björn Töpel    2024-04-03  122  	 */
c27fa53b858b4e Björn Töpel    2024-04-03 @123  	riscv_v_vstate_set_restore(current, regs);
c27fa53b858b4e Björn Töpel    2024-04-03  124  
8ee0b41898fa26 Greentime Hu   2023-06-05  125  	/* Copy everything of __sc_riscv_v_state except datap. */
8ee0b41898fa26 Greentime Hu   2023-06-05  126  	err = __copy_from_user(&current->thread.vstate, &state->v_state,
8ee0b41898fa26 Greentime Hu   2023-06-05  127  			       offsetof(struct __riscv_v_ext_state, datap));
8ee0b41898fa26 Greentime Hu   2023-06-05  128  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu   2023-06-05  129  		return err;
8ee0b41898fa26 Greentime Hu   2023-06-05  130  
8ee0b41898fa26 Greentime Hu   2023-06-05  131  	/* Copy the pointer datap itself. */
8ee0b41898fa26 Greentime Hu   2023-06-05  132  	err = __get_user(datap, &state->v_state.datap);
8ee0b41898fa26 Greentime Hu   2023-06-05  133  	if (unlikely(err))
8ee0b41898fa26 Greentime Hu   2023-06-05  134  		return err;
8ee0b41898fa26 Greentime Hu   2023-06-05  135  	/*
8ee0b41898fa26 Greentime Hu   2023-06-05  136  	 * Copy the whole vector content from user space datap. Use
8ee0b41898fa26 Greentime Hu   2023-06-05  137  	 * copy_from_user to prevent information leak.
8ee0b41898fa26 Greentime Hu   2023-06-05  138  	 */
c27fa53b858b4e Björn Töpel    2024-04-03  139  	return copy_from_user(current->thread.vstate.datap, datap, riscv_v_vsize);
8ee0b41898fa26 Greentime Hu   2023-06-05  140  }
3fad3080e143f7 Andy Chiu      2024-10-01  141  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki

