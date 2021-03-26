Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3FF4134B13A
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Mar 2021 22:24:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhCZVXy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Mar 2021 17:23:54 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:35548 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230026AbhCZVXj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Mar 2021 17:23:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtvb-000SOd-No; Fri, 26 Mar 2021 15:23:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=fess.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1lPtva-00074S-1a; Fri, 26 Mar 2021 15:23:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Arnd Bergmann <arnd@arndb.de>,
        Brian Gerst <brgerst@gmail.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-arm-kernel@lists.infradead.org, x86@kernel.org,
        linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20210326143831.1550030-1-hch@lst.de>
        <20210326143831.1550030-4-hch@lst.de>
Date:   Fri, 26 Mar 2021 16:22:33 -0500
In-Reply-To: <20210326143831.1550030-4-hch@lst.de> (Christoph Hellwig's
        message of "Fri, 26 Mar 2021 15:38:30 +0100")
Message-ID: <m1y2e9vcdi.fsf@fess.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1lPtva-00074S-1a;;;mid=<m1y2e9vcdi.fsf@fess.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18JI1x3OTuGSmP1SAxwgJUKnILVVDmHpGw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_40,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        * -0.0 BAYES_40 BODY: Bayes spam probability is 20 to 40%
        *      [score: 0.3879]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@lst.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1205 ms - load_scoreonly_sql: 0.07 (0.0%),
        signal_user_changed: 12 (1.0%), b_tie_ro: 10 (0.8%), parse: 1.10
        (0.1%), extract_message_metadata: 13 (1.1%), get_uri_detail_list: 1.37
        (0.1%), tests_pri_-1000: 7 (0.6%), tests_pri_-950: 1.65 (0.1%),
        tests_pri_-900: 1.23 (0.1%), tests_pri_-90: 84 (7.0%), check_bayes: 83
        (6.9%), b_tokenize: 10 (0.9%), b_tok_get_all: 7 (0.6%), b_comp_prob:
        2.3 (0.2%), b_tok_touch_all: 59 (4.9%), b_finish: 1.20 (0.1%),
        tests_pri_0: 252 (20.9%), check_dkim_signature: 0.55 (0.0%),
        check_dkim_adsp: 2.8 (0.2%), poll_dns_idle: 803 (66.7%), tests_pri_10:
        2.3 (0.2%), tests_pri_500: 826 (68.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 3/4] exec: simplify the compat syscall handling
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@lst.de> writes:


> diff --git a/fs/exec.c b/fs/exec.c
> index 06e07278b456fa..b34c1eb9e7ad8e 100644
> --- a/fs/exec.c
> +++ b/fs/exec.c
> @@ -391,47 +391,34 @@ static int bprm_mm_init(struct linux_binprm *bprm)
>  	return err;
>  }
>  
> -struct user_arg_ptr {
> -#ifdef CONFIG_COMPAT
> -	bool is_compat;
> -#endif
> -	union {
> -		const char __user *const __user *native;
> -#ifdef CONFIG_COMPAT
> -		const compat_uptr_t __user *compat;
> -#endif
> -	} ptr;
> -};
> -
> -static const char __user *get_user_arg_ptr(struct user_arg_ptr argv, int nr)
> +static const char __user *
> +get_user_arg_ptr(const char __user *const __user *argv, int nr)
>  {
> -	const char __user *native;
> -
> -#ifdef CONFIG_COMPAT
> -	if (unlikely(argv.is_compat)) {
> +	if (in_compat_syscall()) {
> +		const compat_uptr_t __user *compat_argv =
> +			compat_ptr((unsigned long)argv);

Ouch!  Passing a pointer around as the wrong type through the kernel!

Perhaps we should reduce everything to do_execveat and
do_execveat_compat.  Then there would be no need for anything
to do anything odd with the pointer types.

I think the big change would be to factor out a copy_string out
of copy_strings, that performs all of the work once we know the proper
pointer value.

Casting pointers from one type to another scares me as one mistake means
we are doing something wrong and probably exploitable.


Eric




>  		compat_uptr_t compat;
>  
> -		if (get_user(compat, argv.ptr.compat + nr))
> +		if (get_user(compat, compat_argv + nr))
>  			return ERR_PTR(-EFAULT);
> -
>  		return compat_ptr(compat);
> -	}
> -#endif
> -
> -	if (get_user(native, argv.ptr.native + nr))
> -		return ERR_PTR(-EFAULT);
> +	} else {
> +		const char __user *native;
>  
> -	return native;
> +		if (get_user(native, argv + nr))
> +			return ERR_PTR(-EFAULT);
> +		return native;
> +	}
>  }
>  
