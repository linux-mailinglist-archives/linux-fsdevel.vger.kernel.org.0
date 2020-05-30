Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0283C1E8D89
	for <lists+linux-fsdevel@lfdr.de>; Sat, 30 May 2020 05:32:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728675AbgE3Dci (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 23:32:38 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:57630 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728406AbgE3Dch (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 23:32:37 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jesEd-0002Yt-NU; Fri, 29 May 2020 21:32:35 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jesEc-0001y8-Q0; Fri, 29 May 2020 21:32:35 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Oleg Nesterov <oleg@redhat.com>, Jann Horn <jannh@google.com>,
        Greg Ungerer <gerg@linux-m68k.org>,
        Rob Landley <rob@landley.net>,
        Bernd Edlinger <bernd.edlinger@hotmail.de>,
        linux-fsdevel@vger.kernel.org, Al Viro <viro@ZenIV.linux.org.uk>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Andy Lutomirski <luto@amacapital.net>
References: <87h7wujhmz.fsf@x220.int.ebiederm.org>
        <87sgga6ze4.fsf@x220.int.ebiederm.org>
        <87v9l4zyla.fsf_-_@x220.int.ebiederm.org>
        <877dx822er.fsf_-_@x220.int.ebiederm.org>
        <87k10wysqz.fsf_-_@x220.int.ebiederm.org>
        <87d06mr8ps.fsf_-_@x220.int.ebiederm.org>
        <871rn2r8m6.fsf_-_@x220.int.ebiederm.org>
        <202005291406.52E27AF8@keescook>
Date:   Fri, 29 May 2020 22:28:41 -0500
In-Reply-To: <202005291406.52E27AF8@keescook> (Kees Cook's message of "Fri, 29
        May 2020 14:24:46 -0700")
Message-ID: <875zcenlsm.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jesEc-0001y8-Q0;;;mid=<875zcenlsm.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19+t4UEQteAa1xI/LIkN0ljhGBleMTZt7U=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 496 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 4.4 (0.9%), b_tie_ro: 3.0 (0.6%), parse: 1.25
        (0.3%), extract_message_metadata: 16 (3.2%), get_uri_detail_list: 3.8
        (0.8%), tests_pri_-1000: 18 (3.7%), tests_pri_-950: 1.07 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 63 (12.7%), check_bayes:
        61 (12.4%), b_tokenize: 9 (1.8%), b_tok_get_all: 9 (1.8%),
        b_comp_prob: 2.4 (0.5%), b_tok_touch_all: 38 (7.7%), b_finish: 0.74
        (0.1%), tests_pri_0: 379 (76.4%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.16 (0.2%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 7 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 2/2] exec: Compute file based creds only once
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Fri, May 29, 2020 at 11:47:29AM -0500, Eric W. Biederman wrote:
>> diff --git a/include/linux/lsm_hooks.h b/include/linux/lsm_hooks.h
>> index cd3dd0afceb5..37bb3df751c6 100644
>> --- a/include/linux/lsm_hooks.h
>> +++ b/include/linux/lsm_hooks.h
>> @@ -44,18 +44,18 @@
>>   *	request libc enable secure mode.
>> - *	The hook must set @bprm->pf_per_clear to the personality flags that
>> + *	The hook must set @bprm->per_clear to the personality flags that
>
> Here and the other per_clear comment have language that doesn't quite
> line up with how hooks should deal with the bits. They should not "set
> it to" the personality flags they want clear, they need to "add the
> bits" they want to see cleared. i.e I don't want something thinking
> they're the only one touching per_clear, so they should never do:
> 	bprm->per_clear = PER_CLEAR_ON_SETID;
> but always:
> 	bprm->per_clear |= PER_CLEAR_ON_SETID;
>
> How about:
>
> The hook must set @bprm->per_clear with any personality flag bits that

Sounds good:

The range-diff winds up being:
1:  c9258ef4879b ! 1:  a7868323c263 exec: Add a per bprm->file version of per_clear
    @@ Commit message
     
         History Tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/history.git
         Fixes: 1bb0fa189c6a ("[PATCH] NX: clean up legacy binary support")
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/exec.c ##
    @@ include/linux/lsm_hooks.h
       *	transitions between security domains).
       *	The hook must set @bprm->active_secureexec to 1 if AT_SECURE should be set to
       *	request libc enable secure mode.
    -+ *	The hook must set @bprm->pf_per_clear to the personality flags that
    -+ *	should be cleared from current->personality.
    ++ *	The hook must add to @bprm->pf_per_clear any personality flags that
    ++ * 	should be cleared from current->personality.
       *	@bprm contains the linux_binprm structure.
       *	Return 0 if the hook is successful and permission is granted.
       * @bprm_check_security:
2:  e6f20c69b96e ! 2:  56305aa9b6fa exec: Compute file based creds only once
    @@ Commit message
         secureity attribute and derive capabilities from the fact the
         user had uid 0 has been added.
     
    +    Reviewed-by: Kees Cook <keescook@chromium.org>
         Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
     
      ## fs/binfmt_misc.c ##
    @@ include/linux/lsm_hooks.h
     + *	between security domains).
     + *	The hook must set @bprm->secureexec to 1 if AT_SECURE should be set to
       *	request libc enable secure mode.
    -- *	The hook must set @bprm->pf_per_clear to the personality flags that
    -+ *	The hook must set @bprm->per_clear to the personality flags that
    -  *	should be cleared from current->personality.
    +- *	The hook must add to @bprm->pf_per_clear any personality flags that
    ++ *	The hook must add to @bprm->per_clear any personality flags that
    +  * 	should be cleared from current->personality.
       *	@bprm contains the linux_binprm structure.
       *	Return 0 if the hook is successful and permission is granted.
     

>> diff --git a/security/commoncap.c b/security/commoncap.c
>
> Not about this patch, but while looking through this file, I see:
>
> int cap_bprm_set_creds(struct linux_binprm *bprm)
> {
> 	...
> 	*capability manipulations*
>
>         if (WARN_ON(!cap_ambient_invariant_ok(new)))
>                 return -EPERM;
>
>         if (nonroot_raised_pE(new, old, root_uid, has_fcap)) {
>                 ret = audit_log_bprm_fcaps(bprm, new, old);
>                 if (ret < 0)
>                         return ret;
>         }
>
>         new->securebits &= ~issecure_mask(SECURE_KEEP_CAPS);
>
>         if (WARN_ON(!cap_ambient_invariant_ok(new)))
>                 return -EPERM;
> 	...
> }
>
> The cap_ambient_invariant_ok() test is needlessly repeated: it doesn't
> examine securebits, and nonroot_raised_pE appears to have no
> side-effects.
>
> One of those can be dropped, yes?

That is what it looks like to me.

I am hoping to take a deep dive into this function after I finish with
bprm_fill_uid (the patches that were dropped).

My brain bends on little details like is_setid not testing if the
excutable was suid or sgid, but instead is testing something close but
unrelated.

I hope that when the dust clears the function can become a
straightforward implementation of the capability equations.
We will see.

Eric

