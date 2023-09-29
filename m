Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 932A67B3732
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 17:45:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233517AbjI2Pps (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 11:45:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233257AbjI2Ppr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:45:47 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BFDB4;
        Fri, 29 Sep 2023 08:45:45 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:44246)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFgW-00G0cZ-8R; Fri, 29 Sep 2023 09:45:44 -0600
Received: from ip68-227-168-167.om.om.cox.net ([68.227.168.167]:41658 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1qmFgU-00H7NY-Vb; Fri, 29 Sep 2023 09:45:43 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Sebastian Ott <sebott@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Pedro Falcato <pedro.falcato@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, linux-hardening@vger.kernel.org
References: <20230929031716.it.155-kees@kernel.org>
        <7ddc633e-c724-ad8d-e7ca-62d6b012b9e9@redhat.com>
Date:   Fri, 29 Sep 2023 10:45:35 -0500
In-Reply-To: <7ddc633e-c724-ad8d-e7ca-62d6b012b9e9@redhat.com> (Sebastian
        Ott's message of "Fri, 29 Sep 2023 13:33:50 +0200 (CEST)")
Message-ID: <874jjd6l0g.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1qmFgU-00H7NY-Vb;;;mid=<874jjd6l0g.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.168.167;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19qOgVaSfVR9pj3QS9bIi6xEj+LTb3sHKw=
X-SA-Exim-Connect-IP: 68.227.168.167
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Sebastian Ott <sebott@redhat.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 654 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.6%), b_tie_ro: 9 (1.4%), parse: 0.98 (0.1%),
         extract_message_metadata: 15 (2.3%), get_uri_detail_list: 1.62 (0.2%),
         tests_pri_-2000: 8 (1.2%), tests_pri_-1000: 2.6 (0.4%),
        tests_pri_-950: 1.18 (0.2%), tests_pri_-900: 0.98 (0.1%),
        tests_pri_-200: 0.79 (0.1%), tests_pri_-100: 6 (0.9%), tests_pri_-90:
        306 (46.8%), check_bayes: 286 (43.8%), b_tokenize: 7 (1.1%),
        b_tok_get_all: 18 (2.8%), b_comp_prob: 2.5 (0.4%), b_tok_touch_all:
        254 (38.9%), b_finish: 1.18 (0.2%), tests_pri_0: 284 (43.4%),
        check_dkim_signature: 0.61 (0.1%), check_dkim_adsp: 7 (1.0%),
        poll_dns_idle: 0.48 (0.1%), tests_pri_10: 4.2 (0.6%), tests_pri_500:
        11 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v4 0/6] binfmt_elf: Support segments with 0 filesz and
 misaligned starts
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Sebastian Ott <sebott@redhat.com> writes:

> Hello Kees,
>
> On Thu, 28 Sep 2023, Kees Cook wrote:
>> This is the continuation of the work Eric started for handling
>> "p_memsz > p_filesz" in arbitrary segments (rather than just the last,
>> BSS, segment). I've added the suggested changes:
>>
>> - drop unused "elf_bss" variable
>> - refactor load_elf_interp() to use elf_load()
>> - refactor load_elf_library() to use elf_load()
>> - report padzero() errors when PROT_WRITE is present
>> - drop vm_brk()
>
> While I was debugging the initial issue I stumbled over the following
> - care to take it as part of this series?
>
> ----->8
> [PATCH] mm: vm_brk_flags don't bail out while holding lock
>
> Calling vm_brk_flags() with flags set other than VM_EXEC
> will exit the function without releasing the mmap_write_lock.
>
> Just do the sanity check before the lock is acquired. This
> doesn't fix an actual issue since no caller sets a flag other
> than VM_EXEC.

That seems like a sensible patch.

Have you by any chance read this code enough to understand what is
gained by calling vm_brk_flags rather than vm_mmap without a file?

Unless there is a real advantage it probably makes sense to replace
the call of vm_brk_flags with vm_mmap(NULL, ...) as binfmt_elf_fdpic
has already done.

That would allow removing vm_brk_flags and sys_brk would be the last
caller of do_brk_flags.

Eric


> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: linux-mm@kvack.org
> Signed-off-by: Sebastian Ott <sebott@redhat.com>
> ---
>   mm/mmap.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/mm/mmap.c b/mm/mmap.c
> index b56a7f0c9f85..7ed286662839 100644
> --- a/mm/mmap.c
> +++ b/mm/mmap.c
> @@ -3143,13 +3143,13 @@ int vm_brk_flags(unsigned long addr, unsigned long request, unsigned long flags)
>   	if (!len)
>   		return 0;
>
> -	if (mmap_write_lock_killable(mm))
> -		return -EINTR;
> -
>   	/* Until we need other flags, refuse anything except VM_EXEC. */
>   	if ((flags & (~VM_EXEC)) != 0)
>   		return -EINVAL;
>
> +	if (mmap_write_lock_killable(mm))
> +		return -EINTR;
> +
>   	ret = check_brk_limits(addr, len);
>   	if (ret)
>   		goto limits_failed;
