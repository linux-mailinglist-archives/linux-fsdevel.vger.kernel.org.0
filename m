Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8B34D21A1
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 20:35:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350008AbiCHTgd (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Mar 2022 14:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349999AbiCHTgc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Mar 2022 14:36:32 -0500
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DC7454688;
        Tue,  8 Mar 2022 11:35:35 -0800 (PST)
Received: from in02.mta.xmission.com ([166.70.13.52]:60392)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRfcL-006Rk2-Nb; Tue, 08 Mar 2022 12:35:33 -0700
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:33848 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nRfcK-001fpg-Bz; Tue, 08 Mar 2022 12:35:33 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Denys Vlasenko <vda.linux@googlemail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Liam R . Howlett" <liam.howlett@oracle.com>,
        Jann Horn <jannh@google.com>, <linux-mm@kvack.org>
References: <20220131153740.2396974-1-willy@infradead.org>
        <871r0nriy4.fsf@email.froward.int.ebiederm.org>
        <YfgKw5z2uswzMVRQ@casper.infradead.org>
        <877dafq3bw.fsf@email.froward.int.ebiederm.org>
        <YfgPwPvopO1aqcVC@casper.infradead.org>
        <CAG48ez3MCs8d8hjBfRSQxwUTW3o64iaSwxF=UEVtk+SEme0chQ@mail.gmail.com>
        <87bkzroica.fsf_-_@email.froward.int.ebiederm.org>
Date:   Tue, 08 Mar 2022 13:35:03 -0600
In-Reply-To: <87bkzroica.fsf_-_@email.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Mon, 31 Jan 2022 12:44:53 -0600")
Message-ID: <87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nRfcK-001fpg-Bz;;;mid=<87h788fdaw.fsf_-_@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18VHZi4qAUqp2lFjUGTMEwqPtkpQK8w5+o=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 536 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 11 (2.0%), b_tie_ro: 9 (1.6%), parse: 1.56 (0.3%),
         extract_message_metadata: 5 (1.0%), get_uri_detail_list: 2.0 (0.4%),
        tests_pri_-1000: 6 (1.1%), tests_pri_-950: 1.92 (0.4%),
        tests_pri_-900: 1.49 (0.3%), tests_pri_-90: 202 (37.7%), check_bayes:
        200 (37.3%), b_tokenize: 9 (1.7%), b_tok_get_all: 6 (1.1%),
        b_comp_prob: 3.8 (0.7%), b_tok_touch_all: 177 (33.1%), b_finish: 1.11
        (0.2%), tests_pri_0: 280 (52.2%), check_dkim_signature: 0.81 (0.2%),
        check_dkim_adsp: 3.8 (0.7%), poll_dns_idle: 1.14 (0.2%), tests_pri_10:
        3.8 (0.7%), tests_pri_500: 10 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: [GIT PULL] Fix fill_files_note
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org


Kees,

Please pull the coredump-vma-snapshot-fix branch from the git tree:

  git://git.kernel.org/pub/scm/linux/kernel/git/ebiederm/user-namespace.git coredump-vma-snapshot-fix

  HEAD: 390031c942116d4733310f0684beb8db19885fe6 coredump: Use the vma snapshot in fill_files_note

Matthew Wilcox has reported that a missing mmap_lock in file_files_note,
which could cause trouble.

Refactor the code and clean it up so that the vma snapshot makes
it to fill_files_note, and then use the vma snapshot in fill_files_note.

Eric W. Biederman (5):
      coredump: Move definition of struct coredump_params into coredump.h
      coredump: Snapshot the vmas in do_coredump
      coredump: Remove the WARN_ON in dump_vma_snapshot
      coredump/elf: Pass coredump_params into fill_note_info
      coredump: Use the vma snapshot in fill_files_note

 fs/binfmt_elf.c          | 66 ++++++++++++++++++++++--------------------------
 fs/binfmt_elf_fdpic.c    | 18 +++++--------
 fs/binfmt_flat.c         |  1 +
 fs/coredump.c            | 59 ++++++++++++++++++++++++++++---------------
 include/linux/binfmts.h  | 13 +---------
 include/linux/coredump.h | 20 ++++++++++++---
 6 files changed, 93 insertions(+), 84 deletions(-)

---

Kees I realized I needed to rebase this on Jann Horn's commit
84158b7f6a06 ("coredump: Also dump first pages of non-executable ELF
libraries").  Unfortunately before I got that done I got distracted and
these changes have been sitting in limbo for most of the development
cycle.  Since you are running a tree that is including changes like this
including Jann's can you please pull these changes into your tree.

Thank you,
Eric
