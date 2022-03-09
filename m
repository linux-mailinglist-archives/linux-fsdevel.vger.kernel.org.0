Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 153C74D357C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Mar 2022 18:42:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235179AbiCIQhE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Mar 2022 11:37:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235812AbiCIQd4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Mar 2022 11:33:56 -0500
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E72969E9C6;
        Wed,  9 Mar 2022 08:29:27 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:35982)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRzBm-0032OW-NN; Wed, 09 Mar 2022 09:29:26 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:34582 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRzBl-005i1Z-OH; Wed, 09 Mar 2022 09:29:26 -0700
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
Date:   Wed, 09 Mar 2022 10:29:10 -0600
In-Reply-To: <202203081342.1924AD9@keescook> (Kees Cook's message of "Tue, 8
        Mar 2022 13:49:32 -0800")
Message-ID: <877d93dr8p.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nRzBl-005i1Z-OH;;;mid=<877d93dr8p.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+n6dmJ5h9NeMXTcHx08GyxJ8itHy6uo48=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa08 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 430 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 12 (2.7%), b_tie_ro: 10 (2.3%), parse: 0.84
        (0.2%), extract_message_metadata: 11 (2.5%), get_uri_detail_list: 1.76
        (0.4%), tests_pri_-1000: 13 (3.0%), tests_pri_-950: 1.42 (0.3%),
        tests_pri_-900: 1.16 (0.3%), tests_pri_-90: 92 (21.4%), check_bayes:
        89 (20.7%), b_tokenize: 7 (1.6%), b_tok_get_all: 9 (2.2%),
        b_comp_prob: 2.3 (0.5%), b_tok_touch_all: 66 (15.4%), b_finish: 1.12
        (0.3%), tests_pri_0: 287 (66.7%), check_dkim_signature: 0.55 (0.1%),
        check_dkim_adsp: 2.9 (0.7%), poll_dns_idle: 0.50 (0.1%), tests_pri_10:
        2.1 (0.5%), tests_pri_500: 7 (1.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [GIT PULL] Fix fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Tue, Mar 08, 2022 at 01:35:03PM -0600, Eric W. Biederman wrote:
>> 
>> Kees,
>> 
>> Please pull the coredump-vma-snapshot-fix branch from the git tree:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix
>> 
>>   HEAD: 390031c942116d4733310f0684beb8db19885fe6 coredump: Use the vma snapshot in fill_files_note
>> 
>> Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
>> which could cause trouble.
>> 
>> Refactor the code and clean it up so that the vma snapshot makes
>> it to fill_files_note, and then use the vma snapshot in fill_files_note.
>> 
>> Eric W. Biederman (5):
>>       coredump: Move definition of struct coredump_params into coredump.h
>>       coredump: Snapshot the vmas in do_coredump
>>       coredump: Remove the WARN_ON in dump_vma_snapshot
>>       coredump/elf: Pass coredump_params into fill_note_info
>>       coredump: Use the vma snapshot in fill_files_note
>> 
>>  fs/binfmt_elf.c          | 66 ++++++++++++++++++++++--------------------------
>>  fs/binfmt_elf_fdpic.c    | 18 +++++--------
>>  fs/binfmt_flat.c         |  1 +
>>  fs/coredump.c            | 59 ++++++++++++++++++++++++++++---------------
>>  include/linux/binfmts.h  | 13 +---------
>>  include/linux/coredump.h | 20 ++++++++++++---
>>  6 files changed, 93 insertions(+), 84 deletions(-)
>> 
>> ---
>> 
>> Kees I realized I needed to rebase this on Jann Horn's commit
>> 84158b7f6a06 ("coredump: Also dump first pages of non-executable ELF
>> libraries").  Unfortunately before I got that done I got distracted and
>> these changes have been sitting in limbo for most of the development
>> cycle.  Since you are running a tree that is including changes like this
>> including Jann's can you please pull these changes into your tree.
>
> Sure! Can you make a signed tag for this pull?

Not yet.

Hopefully I will get the time to set that up soon, but I am not at all
setup to do signed tags at this point.

> If it helps, my workflow look like this, though I assume there might be
> better ways. (tl;dr: "git tag -s TAG BRANCH")
>
>
> PULL_BRANCH=name-of-branch
> BASE=sha-of-base
> FOR=someone
> TOPIC=topic-name
>
> TAG="for-$FOR/$TOPIC"
> SIGNED=~/.pull-request-signed-"$TAG"
> echo "$TOPIC update" > "$SIGNED"
> git request-pull "$BASE" git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux.git "$PULL_BRANCH" | awk '{print "# " $0}' >> "$SIGNED"
> vi "$SIGNED"
>
> git tag -sF "$SIGNED" "$TAG" "$PULL_BRANCH"
> git push origin "$PULL_BRANCH"
> git push origin +"$TAG"

Thanks.  That looks like a good place to start.

Eric
