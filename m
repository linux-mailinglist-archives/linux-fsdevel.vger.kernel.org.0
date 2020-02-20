Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 46105166B13
	for <lists+linux-fsdevel@lfdr.de>; Fri, 21 Feb 2020 00:41:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729387AbgBTXlR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Feb 2020 18:41:17 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:38500 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729234AbgBTXlR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Feb 2020 18:41:17 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4vRT-0002Tu-CA; Thu, 20 Feb 2020 16:41:15 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j4vRS-0003Oz-LG; Thu, 20 Feb 2020 16:41:15 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux API <linux-api@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Security Module <linux-security-module@vger.kernel.org>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Lutomirski <luto@kernel.org>,
        Daniel Micay <danielmicay@gmail.com>,
        Djalal Harouni <tixxdz@gmail.com>,
        "Dmitry V . Levin" <ldv@altlinux.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        "J . Bruce Fields" <bfields@fieldses.org>,
        Jeff Layton <jlayton@poochiereds.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Kees Cook <keescook@chromium.org>,
        Oleg Nesterov <oleg@redhat.com>,
        Solar Designer <solar@openwall.com>
References: <CAHk-=wi+1CPShMFvJNPfnrJ8DD8uVKUOQ5TQzQUNGLUkeoahkg@mail.gmail.com>
        <20200212203833.GQ23230@ZenIV.linux.org.uk>
        <20200212204124.GR23230@ZenIV.linux.org.uk>
        <CAHk-=wi5FOGV_3tALK3n6E2fK3Oa_yCYkYQtCSaXLSEm2DUCKg@mail.gmail.com>
        <87lfp7h422.fsf@x220.int.ebiederm.org>
        <CAHk-=wgmn9Qds0VznyphouSZW6e42GWDT5H1dpZg8pyGDGN+=w@mail.gmail.com>
        <87pnejf6fz.fsf@x220.int.ebiederm.org>
        <871rqpaswu.fsf_-_@x220.int.ebiederm.org>
        <87blpt9e6m.fsf_-_@x220.int.ebiederm.org>
        <20200220225420.GR23230@ZenIV.linux.org.uk>
        <20200220230309.GS23230@ZenIV.linux.org.uk>
Date:   Thu, 20 Feb 2020 17:39:14 -0600
In-Reply-To: <20200220230309.GS23230@ZenIV.linux.org.uk> (Al Viro's message of
        "Thu, 20 Feb 2020 23:03:09 +0000")
Message-ID: <87blps7rrx.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j4vRS-0003Oz-LG;;;mid=<87blps7rrx.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OdZjKNTBNxrAmd9oO+cyfw3wUEl55Vpc=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa04.xmission.com
X-Spam-Level: ***
X-Spam-Status: No, score=3.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        XMGappySubj_01,XMNoVowels,XMSubLong,XM_Body_Dirty_Words
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4051]
        *  0.5 XMGappySubj_01 Very gappy subject
        *  0.7 XMSubLong Long Subject
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa04 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.5 XM_Body_Dirty_Words Contains a dirty word
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ***;Al Viro <viro@zeniv.linux.org.uk>
X-Spam-Relay-Country: 
X-Spam-Timing: total 245 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 9 (3.8%), b_tie_ro: 5 (2.1%), parse: 0.86 (0.4%),
        extract_message_metadata: 17 (7.0%), get_uri_detail_list: 1.64 (0.7%),
        tests_pri_-1000: 12 (5.0%), tests_pri_-950: 1.51 (0.6%),
        tests_pri_-900: 1.22 (0.5%), tests_pri_-90: 24 (9.7%), check_bayes: 22
        (9.1%), b_tokenize: 8 (3.3%), b_tok_get_all: 6 (2.7%), b_comp_prob:
        2.2 (0.9%), b_tok_touch_all: 3.3 (1.4%), b_finish: 0.70 (0.3%),
        tests_pri_0: 166 (67.7%), check_dkim_signature: 0.51 (0.2%),
        check_dkim_adsp: 2.4 (1.0%), poll_dns_idle: 0.32 (0.1%), tests_pri_10:
        2.00 (0.8%), tests_pri_500: 7 (2.9%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 4/7] proc: Use d_invalidate in proc_prune_siblings_dcache
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al Viro <viro@zeniv.linux.org.uk> writes:

> On Thu, Feb 20, 2020 at 10:54:20PM +0000, Al Viro wrote:
>> On Thu, Feb 20, 2020 at 02:49:53PM -0600, Eric W. Biederman wrote:
>> > 
>> > The function d_prune_aliases has the problem that it will only prune
>> > aliases thare are completely unused.  It will not remove aliases for
>> > the dcache or even think of removing mounts from the dcache.  For that
>> > behavior d_invalidate is needed.
>> > 
>> > To use d_invalidate replace d_prune_aliases with d_find_alias
>> > followed by d_invalidate and dput.  This is safe and complete
>> > because no inode in proc has any hardlinks or aliases.
>> 
>> s/no inode.*/it's a fucking directory inode./
>
> Wait... You are using it for sysctls as well?  Ho-hum...  The thing is,
> for sysctls you are likely to run into consequent entries with the
> same superblock, making for a big pile of useless playing with
> ->s_active...  And yes, that applied to mainline as well

Which is why I worked to merge the two cases since they were so close.
Fewer things to fix and more eyeballs on the code.

Eric


