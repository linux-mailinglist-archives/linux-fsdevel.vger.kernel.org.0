Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FBC4D3B13
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 21:27:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236879AbiCIU2X (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 15:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238174AbiCIU2S (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 15:28:18 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066554B855;
        Wed,  9 Mar 2022 12:27:17 -0800 (PST)
Received: from in01.mta.xmission.com ([166.70.13.51]:56056)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nS2tw-009Dt1-10; Wed, 09 Mar 2022 13:27:16 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34650 helo=email.froward.int.ebiederm.org.xmission.com)
        by in01.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nS2tu-0017uJ-LN; Wed, 09 Mar 2022 13:27:15 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>, linux-mm@kvack.org
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
        <87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>
        <202203081342.1924AD9@keescook>
        <877d93dr8p.fsf@email.froward.int.ebiederm.org>
        <202203090830.7E971BD6C@keescook>
Date:   Wed, 09 Mar 2022 14:27:07 -0600
In-Reply-To: <202203090830.7E971BD6C@keescook> (Kees Cook's message of "Wed, 9
        Mar 2022 08:32:14 -0800")
Message-ID: <8735jqdg84.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nS2tu-0017uJ-LN;;;mid=<8735jqdg84.fsf@email.froward.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ML1Zu0i2Zn9zxbmCt2bn3iMf4MsVJYIQ=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 793 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.4%), b_tie_ro: 9 (1.2%), parse: 1.06 (0.1%),
         extract_message_metadata: 23 (2.9%), get_uri_detail_list: 4.8 (0.6%),
        tests_pri_-1000: 26 (3.3%), tests_pri_-950: 1.31 (0.2%),
        tests_pri_-900: 1.01 (0.1%), tests_pri_-90: 279 (35.2%), check_bayes:
        273 (34.4%), b_tokenize: 13 (1.6%), b_tok_get_all: 12 (1.5%),
        b_comp_prob: 3.7 (0.5%), b_tok_touch_all: 240 (30.2%), b_finish: 0.97
        (0.1%), tests_pri_0: 438 (55.3%), check_dkim_signature: 0.58 (0.1%),
        check_dkim_adsp: 3.2 (0.4%), poll_dns_idle: 0.13 (0.0%), tests_pri_10:
        2.0 (0.3%), tests_pri_500: 7 (0.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Fix fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Mar 09, 2022 at 10:29:10AM -0600, Eric W. Biederman wrote:
>> Kees Cook <keescook@chromium.org> writes:
>> 
>> > On Tue, Mar 08, 2022 at 01:35:03PM -0600, Eric W. Biederman wrote:
>> >> 
>> >> Kees,
>> >> 
>> >> Please pull the coredump-vma-snapshot-fix branch from the git tree:
>> >> 
>> >>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix
>> >> 
>> >>   HEAD: 390031c942116d4733310f0684beb8db19885fe6 coredump: Use the vma snapshot in fill_files_note
>> >> 
>> >> Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
>> >> which could cause trouble.
>> >> 
>> >> Refactor the code and clean it up so that the vma snapshot makes
>> >> it to fill_files_note, and then use the vma snapshot in fill_files_note.
>> >> 
>> >> Eric W. Biederman (5):
>> >>       coredump: Move definition of struct coredump_params into coredump.h
>> >>       coredump: Snapshot the vmas in do_coredump
>> >>       coredump: Remove the WARN_ON in dump_vma_snapshot
>> >>       coredump/elf: Pass coredump_params into fill_note_info
>> >>       coredump: Use the vma snapshot in fill_files_note
>> >> 
>> >>  fs/binfmt_elf.c          | 66 ++++++++++++++++++++++--------------------------
>> >>  fs/binfmt_elf_fdpic.c    | 18 +++++--------
>> >>  fs/binfmt_flat.c         |  1 +
>> >>  fs/coredump.c            | 59 ++++++++++++++++++++++++++++---------------
>> >>  include/linux/binfmts.h  | 13 +---------
>> >>  include/linux/coredump.h | 20 ++++++++++++---
>> >>  6 files changed, 93 insertions(+), 84 deletions(-)
>> >> 
>> >> ---
>> >> 
>> >> Kees I realized I needed to rebase this on Jann Horn's commit
>> >> 84158b7f6a06 ("coredump: Also dump first pages of non-executable ELF
>> >> libraries").  Unfortunately before I got that done I got distracted and
>> >> these changes have been sitting in limbo for most of the development
>> >> cycle.  Since you are running a tree that is including changes like this
>> >> including Jann's can you please pull these changes into your tree.
>> >
>> > Sure! Can you make a signed tag for this pull?
>> 
>> Not yet.
>> 
>> Hopefully I will get the time to set that up soon, but I am not at all
>> setup to do signed tags at this point.
>
> Okay, cool. Since I'd already review these before, I've pulled and it
> should be in -next now.


>
>> [...]
>> Thanks.  That looks like a good place to start.
>
> I will try to clean up that work-flow and stuff it into my kernel-tools
> repo.

It turns out I missed a crazy corner case of binfmt_flat, when coredumps
are disabled.  This fixes a compile error that was reported.

   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix-for-v5.18
   HEAD: f833116ad2c3eabf9c739946170e07825cca67ed coredump: Don't compile flat_core_dump when coredumps are disabled

Can you include this as well.

Thank you,
Eric

This is the entire patch.

From: "Eric W. Biederman" <ebiederm@xmission.com>
Date: Wed, 9 Mar 2022 10:37:07 -0600
Subject: [PATCH] coredump: Don't compile flat_core_dump when coredumps are disabled

Recently the kernel test robot reported:
> In file included from include/linux/kernel.h:29,
>                     from fs/binfmt_flat.c:21:
>    fs/binfmt_flat.c: In function 'flat_core_dump':
> >> fs/binfmt_flat.c:121:50: error: invalid use of undefined type 'struct coredump_params'
>      121 |                 current->comm, current->pid, cprm->siginfo->si_signo);
>          |                                                  ^~
>    include/linux/printk.h:418:33: note: in definition of macro 'printk_index_wrap'
>      418 |                 _p_func(_fmt, ##__VA_ARGS__);                           \
>          |                                 ^~~~~~~~~~~
>    include/linux/printk.h:499:9: note: in expansion of macro 'printk'
>      499 |         printk(KERN_WARNING pr_fmt(fmt), ##__VA_ARGS__)
>          |         ^~~~~~
>    fs/binfmt_flat.c:120:9: note: in expansion of macro 'pr_warn'
>      120 |         pr_warn("Process %s:%d received signr %d and should have core dumped\n",
>          |         ^~~~~~~
>    At top level:
>    fs/binfmt_flat.c:118:12: warning: 'flat_core_dump' defined but not used [-Wunused-function]
>      118 | static int flat_core_dump(struct coredump_params *cprm)
>          |            ^~~~~~~~~~~~~~

The little dinky do nothing function flat_core_dump has always been
compiled unconditionally.  With my change to move coredump_params into
coredump.h coredump_params reasonably becomes unavailable when
coredump support is not compiled in.  Fix this old issue by simply not
compiling flat_core_dump when coredump support is not supported.

Fixes: a99a3e2efaf1 ("coredump: Move definition of struct coredump_params into coredump.h")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: "Eric W. Biederman" <ebiederm@xmission.com>
---
 fs/binfmt_flat.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 208cdce16de1..626898150011 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -98,7 +98,9 @@ static int load_flat_shared_library(int id, struct lib_info *p);
 #endif
 
 static int load_flat_binary(struct linux_binprm *);
+#ifdef CONFIG_COREDUMP
 static int flat_core_dump(struct coredump_params *cprm);
+#endif
 
 static struct linux_binfmt flat_format = {
 	.module		= THIS_MODULE,
@@ -115,12 +117,14 @@ static struct linux_binfmt flat_format = {
  * Currently only a stub-function.
  */
 
+#ifdef CONFIG_COREDUMP
 static int flat_core_dump(struct coredump_params *cprm)
 {
 	pr_warn("Process %s:%d received signr %d and should have core dumped\n",
 		current->comm, current->pid, cprm->siginfo->si_signo);
 	return 1;
 }
+#endif
 
 /****************************************************************************/
 /*
-- 
2.29.2


