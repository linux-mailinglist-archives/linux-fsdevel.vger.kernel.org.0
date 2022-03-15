Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54D5A4DA5E9
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Mar 2022 00:02:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352476AbiCOXDg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Mar 2022 19:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348250AbiCOXDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Mar 2022 19:03:31 -0400
Received: from out02.mta.xmission.com (out02.mta.xmission.com [166.70.13.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C3BC5D64D;
        Tue, 15 Mar 2022 16:02:18 -0700 (PDT)
Received: from in01.mta.xmission.com ([166.70.13.51]:41624)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUGBF-009r8q-BR; Tue, 15 Mar 2022 17:02:17 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:37836 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nUGBB-009Aiq-3P; Tue, 15 Mar 2022 17:02:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Rick Edgecombe <rick.p.edgecombe@intel.com>
Cc:     dave.hansen@intel.com, len.brown@intel.com, tony.luck@intel.com,
        rafael.j.wysocki@intel.com, reinette.chatre@intel.com,
        dan.j.williams@intel.com, viro@zeniv.linux.org.uk,
        keescook@chromium.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220315201706.7576-1-rick.p.edgecombe@intel.com>
        <20220315201706.7576-2-rick.p.edgecombe@intel.com>
Date:   Tue, 15 Mar 2022 18:01:30 -0500
In-Reply-To: <20220315201706.7576-2-rick.p.edgecombe@intel.com> (Rick
        Edgecombe's message of "Tue, 15 Mar 2022 13:17:04 -0700")
Message-ID: <87y21ayg51.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-XM-SPF: eid=1nUGBB-009Aiq-3P;;;mid=<87y21ayg51.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+NStT7FMzsu/ZuH/bTi7e/+LSZutDCt20=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Rick Edgecombe <rick.p.edgecombe@intel.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 3600 ms - load_scoreonly_sql: 0.19 (0.0%),
        signal_user_changed: 15 (0.4%), b_tie_ro: 12 (0.3%), parse: 2.7 (0.1%),
         extract_message_metadata: 112 (3.1%), get_uri_detail_list: 7 (0.2%),
        tests_pri_-1000: 99 (2.8%), compile_eval: 157 (4.4%), tests_pri_-950:
        71 (2.0%), tests_pri_-900: 16 (0.4%), tests_pri_-90: 428 (11.9%),
        check_bayes: 423 (11.7%), b_tokenize: 142 (3.9%), b_tok_get_all: 181
        (5.0%), b_comp_prob: 4.2 (0.1%), b_tok_touch_all: 61 (1.7%), b_finish:
        1.53 (0.0%), tests_pri_0: 2658 (73.8%), check_dkim_signature: 1.56
        (0.0%), check_dkim_adsp: 20 (0.6%), poll_dns_idle: 16 (0.4%),
        tests_pri_10: 52 (1.5%), tests_pri_500: 136 (3.8%), rewrite_mail: 0.00
        (0.0%)
Subject: Re: [PATCH 1/3] x86: Separate out x86_regset for 32 and 64 bit
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Rick Edgecombe <rick.p.edgecombe@intel.com> writes:

> In ptrace, the x86_32_regsets and x86_64_regsets are constructed such that
> there are no gaps in the arrays. This appears to be for two reasons. One,
> the code in fill_thread_core_info() can't handle the gaps. This will be
> addressed in a future patch. And two, not having gaps shrinks the size of
> the array in memory.
>
> Both regset arrays draw their indices from a shared enum x86_regset, but 32
> bit and 64 bit don't all support the same regsets. In the case of
> IA32_EMULATION they can be compiled in at the same time. So this enum has
> to be laid out in a special way such that there are no gaps for both
> x86_32_regsets and x86_64_regsets. This involves creating aliases for
> enum’s that are only in one view or the other, or creating multiple
> versions like in the case of REGSET_IOPERM32/REGSET_IOPERM64.
>
> Simplify the construction of these arrays by just fully separating out the
> enums for 32 bit and 64 bit. Add some bitsize-free defines for
> REGSET_GENERAL and REGSET_FP since they are the only two referred to in
> bitsize generic code.
>
> This should have no functional change and is only changing how constants
> are generated and named. The enum is local to this file, so it does not
> introduce any burden on code calling from other places in the kernel now
> having to worry about whether to use a 32 bit or 64 bit enum name.
>
> [1] https://lore.kernel.org/lkml/20180717162502.32274-1-yu-cheng.yu@intel.com/
>
> Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
> ---
>  arch/x86/kernel/ptrace.c | 60 ++++++++++++++++++++++++++--------------
>  1 file changed, 39 insertions(+), 21 deletions(-)
>
> diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
> index 8d2f2f995539..7a4988d13c43 100644
> --- a/arch/x86/kernel/ptrace.c
> +++ b/arch/x86/kernel/ptrace.c
> @@ -45,16 +45,34 @@
>  
>  #include "tls.h"
>  
> -enum x86_regset {
> -	REGSET_GENERAL,
> -	REGSET_FP,
> -	REGSET_XFP,
> -	REGSET_IOPERM64 = REGSET_XFP,
> -	REGSET_XSTATE,
> -	REGSET_TLS,
> +enum x86_regset_32 {
> +	REGSET_GENERAL32,
> +	REGSET_FP32,
> +	REGSET_XFP32,
> +	REGSET_XSTATE32,
> +	REGSET_TLS32,
>  	REGSET_IOPERM32,
>  };
>  
> +enum x86_regset_64 {
> +	REGSET_GENERAL64,
> +	REGSET_FP64,
> +	REGSET_IOPERM64,
> +	REGSET_XSTATE64,
> +};

So I am looking at this and am wondering if the enums should be:

enum x86_32_regset {
	REGSET32_GENERAL,
        REGSET32_FP,
        REGSET32_XFP,
        REGSET32_XSTATE,
        REGSET32_TLS,
        REGSET32_IOPERM32,
};

enum x86_64_regset {
	REGSET64_GENERAL,
        REGSET64_FP,
        REGSET64_IOPERM64,
        REGSET64_XSTATE,
};


That is named in such a way that it emphasizes that the difference is
the architecture.  Otherwise it reads like the difference is the size of
the registers in the regset.  I am pretty certain that in your
REGSET_FP32 and REGSET_FP64 all of the registers are 80 bits long.

Eric


> +
> +#define REGSET_GENERAL \
> +({ \
> +	BUILD_BUG_ON((int)REGSET_GENERAL32 != (int)REGSET_GENERAL64); \
> +	REGSET_GENERAL32; \
> +})
> +
> +#define REGSET_FP \

> +	BUILD_BUG_ON((int)REGSET_FP32 != (int)REGSET_FP64); \
> +	REGSET_FP32; \
> +})
> +
>  struct pt_regs_offset {
>  	const char *name;
>  	int offset;
> @@ -789,13 +807,13 @@ long arch_ptrace(struct task_struct *child, long request,
>  #ifdef CONFIG_X86_32
>  	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
>  		return copy_regset_to_user(child, &user_x86_32_view,
> -					   REGSET_XFP,
> +					   REGSET_XFP32,
>  					   0, sizeof(struct user_fxsr_struct),
>  					   datap) ? -EIO : 0;
>  
>  	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
>  		return copy_regset_from_user(child, &user_x86_32_view,
> -					     REGSET_XFP,
> +					     REGSET_XFP32,
>  					     0, sizeof(struct user_fxsr_struct),
>  					     datap) ? -EIO : 0;
>  #endif
> @@ -1087,13 +1105,13 @@ static long ia32_arch_ptrace(struct task_struct *child, compat_long_t request,
>  
>  	case PTRACE_GETFPXREGS:	/* Get the child extended FPU state. */
>  		return copy_regset_to_user(child, &user_x86_32_view,
> -					   REGSET_XFP, 0,
> +					   REGSET_XFP32, 0,
>  					   sizeof(struct user32_fxsr_struct),
>  					   datap);
>  
>  	case PTRACE_SETFPXREGS:	/* Set the child extended FPU state. */
>  		return copy_regset_from_user(child, &user_x86_32_view,
> -					     REGSET_XFP, 0,
> +					     REGSET_XFP32, 0,
>  					     sizeof(struct user32_fxsr_struct),
>  					     datap);
>  
> @@ -1216,19 +1234,19 @@ long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
>  #ifdef CONFIG_X86_64
>  
>  static struct user_regset x86_64_regsets[] __ro_after_init = {
> -	[REGSET_GENERAL] = {
> +	[REGSET_GENERAL64] = {
>  		.core_note_type = NT_PRSTATUS,
>  		.n = sizeof(struct user_regs_struct) / sizeof(long),
>  		.size = sizeof(long), .align = sizeof(long),
>  		.regset_get = genregs_get, .set = genregs_set
>  	},
> -	[REGSET_FP] = {
> +	[REGSET_FP64] = {
>  		.core_note_type = NT_PRFPREG,
>  		.n = sizeof(struct fxregs_state) / sizeof(long),
>  		.size = sizeof(long), .align = sizeof(long),
>  		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
>  	},
> -	[REGSET_XSTATE] = {
> +	[REGSET_XSTATE64] = {
>  		.core_note_type = NT_X86_XSTATE,
>  		.size = sizeof(u64), .align = sizeof(u64),
>  		.active = xstateregs_active, .regset_get = xstateregs_get,
> @@ -1257,31 +1275,31 @@ static const struct user_regset_view user_x86_64_view = {
>  
>  #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
>  static struct user_regset x86_32_regsets[] __ro_after_init = {
> -	[REGSET_GENERAL] = {
> +	[REGSET_GENERAL32] = {
>  		.core_note_type = NT_PRSTATUS,
>  		.n = sizeof(struct user_regs_struct32) / sizeof(u32),
>  		.size = sizeof(u32), .align = sizeof(u32),
>  		.regset_get = genregs32_get, .set = genregs32_set
>  	},
> -	[REGSET_FP] = {
> +	[REGSET_FP32] = {
>  		.core_note_type = NT_PRFPREG,
>  		.n = sizeof(struct user_i387_ia32_struct) / sizeof(u32),
>  		.size = sizeof(u32), .align = sizeof(u32),
>  		.active = regset_fpregs_active, .regset_get = fpregs_get, .set = fpregs_set
>  	},
> -	[REGSET_XFP] = {
> +	[REGSET_XFP32] = {
>  		.core_note_type = NT_PRXFPREG,
>  		.n = sizeof(struct fxregs_state) / sizeof(u32),
>  		.size = sizeof(u32), .align = sizeof(u32),
>  		.active = regset_xregset_fpregs_active, .regset_get = xfpregs_get, .set = xfpregs_set
>  	},
> -	[REGSET_XSTATE] = {
> +	[REGSET_XSTATE32] = {
>  		.core_note_type = NT_X86_XSTATE,
>  		.size = sizeof(u64), .align = sizeof(u64),
>  		.active = xstateregs_active, .regset_get = xstateregs_get,
>  		.set = xstateregs_set
>  	},
> -	[REGSET_TLS] = {
> +	[REGSET_TLS32] = {
>  		.core_note_type = NT_386_TLS,
>  		.n = GDT_ENTRY_TLS_ENTRIES, .bias = GDT_ENTRY_TLS_MIN,
>  		.size = sizeof(struct user_desc),
> @@ -1312,10 +1330,10 @@ u64 xstate_fx_sw_bytes[USER_XSTATE_FX_SW_WORDS];
>  void __init update_regset_xstate_info(unsigned int size, u64 xstate_mask)
>  {
>  #ifdef CONFIG_X86_64
> -	x86_64_regsets[REGSET_XSTATE].n = size / sizeof(u64);
> +	x86_64_regsets[REGSET_XSTATE64].n = size / sizeof(u64);
>  #endif
>  #if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
> -	x86_32_regsets[REGSET_XSTATE].n = size / sizeof(u64);
> +	x86_32_regsets[REGSET_XSTATE32].n = size / sizeof(u64);
>  #endif
>  	xstate_fx_sw_bytes[USER_XSTATE_XCR0_WORD] = xstate_mask;
>  }
