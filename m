Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 470ED1F896E
	for <lists+linux-fsdevel@lfdr.de>; Sun, 14 Jun 2020 16:55:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726903AbgFNOz0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 14 Jun 2020 10:55:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43318 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725815AbgFNOzZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 14 Jun 2020 10:55:25 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jkU2c-0004qH-MZ; Sun, 14 Jun 2020 08:55:22 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jkU2b-0007Fe-JU; Sun, 14 Jun 2020 08:55:22 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        David Miller <davem@davemloft.net>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>
References: <202006051903.C44988B@keescook>
        <875zc4c86z.fsf_-_@x220.int.ebiederm.org>
        <20200606201956.rvfanoqkevjcptfl@ast-mbp>
        <CAHk-=wi=rpNZMeubhq2un3rCMAiOL8A+FZpdPnwFLEY09XGgAQ@mail.gmail.com>
        <20200607014935.vhd3scr4qmawq7no@ast-mbp>
        <33cf7a57-0afa-9bb9-f831-61cca6c19eba@i-love.sakura.ne.jp>
        <20200608162306.iu35p4xoa2kcp3bu@ast-mbp.dhcp.thefacebook.com>
        <87r1uo2ejt.fsf@x220.int.ebiederm.org>
        <20200609235631.ukpm3xngbehfqthz@ast-mbp.dhcp.thefacebook.com>
        <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        <87bllngirv.fsf@x220.int.ebiederm.org>
        <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
        <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
Date:   Sun, 14 Jun 2020 09:51:09 -0500
In-Reply-To: <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
        (Alexei Starovoitov's message of "Sat, 13 Jun 2020 09:14:02 -0700")
Message-ID: <87ftaxd7ky.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jkU2b-0007Fe-JU;;;mid=<87ftaxd7ky.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+UGFwGba4IeeaZDMSgdzIG36nqN4WYSQw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 643 ms - load_scoreonly_sql: 0.51 (0.1%),
        signal_user_changed: 17 (2.7%), b_tie_ro: 13 (2.0%), parse: 1.64
        (0.3%), extract_message_metadata: 14 (2.2%), get_uri_detail_list: 2.4
        (0.4%), tests_pri_-1000: 15 (2.3%), tests_pri_-950: 1.45 (0.2%),
        tests_pri_-900: 1.13 (0.2%), tests_pri_-90: 85 (13.3%), check_bayes:
        84 (13.0%), b_tokenize: 9 (1.4%), b_tok_get_all: 10 (1.6%),
        b_comp_prob: 3.4 (0.5%), b_tok_touch_all: 57 (8.8%), b_finish: 1.00
        (0.2%), tests_pri_0: 489 (76.1%), check_dkim_signature: 0.68 (0.1%),
        check_dkim_adsp: 2.5 (0.4%), poll_dns_idle: 0.81 (0.1%), tests_pri_10:
        2.2 (0.3%), tests_pri_500: 11 (1.8%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Sat, Jun 13, 2020 at 8:33 AM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
>>
>> On Sat, Jun 13, 2020 at 7:13 AM Eric W. Biederman <ebiederm@xmission.com> wrote:
>> > I am in the middle of cleaning up exec.  Send the patches that address
>> > the issues and make this mess not a maintenance issue, and I will be
>> > happy to leave fork_usermode_blob alone.  Otherwise I plan to just
>> > remove the code for now as it is all dead at the moment.
>>
>> May be stop being a jerk first ?
>> It's a Nack to remove the code.
>
> I'm happy to work on changes, but your removal threats must stop
> before we can continue discussion. ok?

I am looking for reasons to not remove the code.  What I can't
personally do is justify spending the time fixing unused code.

The code is currently unused, and has an implementation that can be
improved.  All of which argues for removal on technical grounds.

The implementation issues are a problem for maintaining other code so
they need to be addressed, again that argues for removal on technical
grounds.

There are some asperations to use fork_usermode_blob but no commitments
that I can see to actually use this code.

If someone who cares can step up so other developers don't have to deal
with the maintenance problems, then there is no problem in keeping the
code.




Now there is one technical issue I see that has implications for how
this gets fixed.  The current implementation requires that 2 copies
of the user mode executable be kept.

int fork_usermode_blob(void *data, size_t len, struct umh_info *info);


The function fork_usermode_blob is passed an array and a length.  Today
that array is stored in .rodata.  Not in a init section where it could
be discared.

Now userspace in general and exec in particular requires the executable
to be in a mmapable file.  So fork_usermode_blob creates a mini
filesystem that only supports one file and no file names and opens
a file within it, and passes that open file to exec.

If creation of the filesystem and copying of the data can be separated
from the actual execution of the code, then there will be no need to
keep 2 copies of the executable in memory.  If the file was also given a
name there would be no need for fork_usermode_blob to open the file.
All fork_usermode_blob would need to do is make make it possible for
exec to find that file.

The implification this has for fixing the issues with exec is that once
the file has a name fork_usermode_blob no longer needs to preopen the
file and call do_execve_file.  Instead fork_usermode_blob can call
do_execve.  Which means do_execve_file and all of it's strange corner
cases can go away.

We have all of the infrastructure to decode a cpio in init/initramfs.c
so it would be practically no code at all to place the code into a
filesystem instead of just into a file at startup time.  At which
point it could be guaranteed that the section the filesystem lives in is
an init section and is not used past the point of loading it into a
filesystem.  Making the code use half the memory.

Eric

