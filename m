Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7FAB207327
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Jun 2020 14:17:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403923AbgFXMRt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Jun 2020 08:17:49 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:41092 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2403917AbgFXMRs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Jun 2020 08:17:48 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jo4LY-00030v-LA; Wed, 24 Jun 2020 06:17:44 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jo4LX-0000Hb-QF; Wed, 24 Jun 2020 06:17:44 -0600
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
References: <87d066vd4y.fsf@x220.int.ebiederm.org>
        <20200611233134.5vofl53dj5wpwp5j@ast-mbp.dhcp.thefacebook.com>
        <87bllngirv.fsf@x220.int.ebiederm.org>
        <CAADnVQ+qNxFjTYBpYW9ZhStMh_oJBS5C_FsxSS=0Mzy=u54MSg@mail.gmail.com>
        <CAADnVQLuGYX=LamARhrZcze1ej4ELj-y99fLzOCgz60XLPw_cQ@mail.gmail.com>
        <87ftaxd7ky.fsf@x220.int.ebiederm.org>
        <20200616015552.isi6j5x732okiky4@ast-mbp.dhcp.thefacebook.com>
        <87h7v1pskt.fsf@x220.int.ebiederm.org>
        <20200623183520.5e7fmlt3omwa2lof@ast-mbp.dhcp.thefacebook.com>
        <87h7v1mx4z.fsf@x220.int.ebiederm.org>
        <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 24 Jun 2020 07:13:19 -0500
In-Reply-To: <20200623194023.lzl34qt2wndhcehk@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Tue, 23 Jun 2020 12:40:23 -0700")
Message-ID: <878sgck6g0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jo4LX-0000Hb-QF;;;mid=<878sgck6g0.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18AWL6e2YVEkkYGAkiCdIEi6OTnVRVCYkY=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4969]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 388 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 11 (2.7%), b_tie_ro: 9 (2.4%), parse: 0.79 (0.2%),
         extract_message_metadata: 2.3 (0.6%), get_uri_detail_list: 0.56
        (0.1%), tests_pri_-1000: 4.1 (1.0%), tests_pri_-950: 1.23 (0.3%),
        tests_pri_-900: 1.01 (0.3%), tests_pri_-90: 55 (14.2%), check_bayes:
        54 (13.8%), b_tokenize: 6 (1.4%), b_tok_get_all: 6 (1.6%),
        b_comp_prob: 1.68 (0.4%), b_tok_touch_all: 37 (9.6%), b_finish: 0.92
        (0.2%), tests_pri_0: 296 (76.4%), check_dkim_signature: 0.48 (0.1%),
        check_dkim_adsp: 2.2 (0.6%), poll_dns_idle: 0.55 (0.1%), tests_pri_10:
        2.3 (0.6%), tests_pri_500: 6 (1.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC][PATCH] net/bpfilter: Remove this broken and apparently unmantained
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 23, 2020 at 01:53:48PM -0500, Eric W. Biederman wrote:

> There is no refcnt bug. It was a user error on tomoyo side.
> fork_blob() works as expected.

Nope.  I have independently confirmed it myself.

fork_usermode_blob holds a reference and puts that reference.  An
additional reference is needed for execve to hold and put.

Now can you write some patches to make that obvious please?

Eric
