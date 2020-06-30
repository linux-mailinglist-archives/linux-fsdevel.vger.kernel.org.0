Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F116120F74A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 16:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731372AbgF3Oc4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 10:32:56 -0400
Received: from out02.mta.xmission.com ([166.70.13.232]:51270 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727023AbgF3Ocz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 10:32:55 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqHJY-0007A8-4g; Tue, 30 Jun 2020 08:32:48 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqHJT-00058A-3Q; Tue, 30 Jun 2020 08:32:47 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Alexei Starovoitov <alexei.starovoitov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>, bpf <bpf@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Gary Lin <GLin@suse.com>, Bruno Meneguele <bmeneg@redhat.com>,
        LSM List <linux-security-module@vger.kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <87lfk54p0m.fsf_-_@x220.int.ebiederm.org>
        <20200630054313.GB27221@infradead.org>
        <87a70k21k0.fsf@x220.int.ebiederm.org>
        <20200630133802.GA30093@infradead.org>
Date:   Tue, 30 Jun 2020 09:28:10 -0500
In-Reply-To: <20200630133802.GA30093@infradead.org> (Christoph Hellwig's
        message of "Tue, 30 Jun 2020 14:38:02 +0100")
Message-ID: <878sg4y6f9.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqHJT-00058A-3Q;;;mid=<878sg4y6f9.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18VudBavxc3u9jszpnmk5yoXjTN6p/HnXg=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa06.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,FVGT_m_MULTI_ODD,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01 autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4489]
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa06 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.4 FVGT_m_MULTI_ODD Contains multiple odd letter combinations
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa06 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 4405 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 12 (0.3%), b_tie_ro: 10 (0.2%), parse: 1.18
        (0.0%), extract_message_metadata: 18 (0.4%), get_uri_detail_list: 2.7
        (0.1%), tests_pri_-1000: 8 (0.2%), tests_pri_-950: 1.52 (0.0%),
        tests_pri_-900: 1.29 (0.0%), tests_pri_-90: 105 (2.4%), check_bayes:
        103 (2.3%), b_tokenize: 11 (0.3%), b_tok_get_all: 10 (0.2%),
        b_comp_prob: 2.9 (0.1%), b_tok_touch_all: 74 (1.7%), b_finish: 1.18
        (0.0%), tests_pri_0: 362 (8.2%), check_dkim_signature: 0.64 (0.0%),
        check_dkim_adsp: 2.3 (0.1%), poll_dns_idle: 3863 (87.7%),
        tests_pri_10: 2.4 (0.1%), tests_pri_500: 3889 (88.3%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH v2 10/15] exec: Remove do_execve_file
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

> On Tue, Jun 30, 2020 at 07:14:23AM -0500, Eric W. Biederman wrote:
>> Christoph Hellwig <hch@infradead.org> writes:
>> 
>> > FYI, this clashes badly with my exec rework.  I'd suggest you
>> > drop everything touching exec here for now, and I can then
>> > add the final file based exec removal to the end of my series.
>> 
>> I have looked and I haven't even seen any exec work.  Where can it be
>> found?
>> 
>> I have working and cleaning up exec for what 3 cycles now.  There is
>> still quite a ways to go before it becomes possible to fix some of the
>> deep problems in exec.  Removing all of these broken exec special cases
>> is quite frankly the entire point of this patchset.
>> 
>> Sight unseen I suggest you send me your exec work and I can merge it
>> into my branch if we are going to conflict badly.
>
> https://lore.kernel.org/linux-fsdevel/20200627072704.2447163-1-hch@lst.de/T/#t


Looking at your final patch I do not like the construct.

static int __do_execveat(int fd, struct filename *filename,
 		const char __user *const __user *argv,
 		const char __user *const __user *envp,
		const char *const *kernel_argv,
		const char *const *kernel_envp,
 		int flags, struct file *file);


It results in a function that is full of:
	if (kernel_argv) {
        	// For kernel_exeveat 
		...
	} else {
        	// For ordinary exeveat
        	
        }

Which while understandable.  I do not think results in good long term
maintainble code.

The current file paramter that I am getting rid of in my patchset is
a stark example of that.  Because of all of the if's no one realized
that the code had it's file reference counting wrong (amoung other
bugs).

I think this is important to address as exec has already passed
the point where people can fix all of the bugs in exec because
the code is so hairy.

I think to be maintainable and clear the code exec code is going to
need to look something like:

static int bprm_execveat(int fd, struct filename *filename,
			struct bprm *bprm, int flags);

int kernel_execve(const char *filename,
		  const char *const *argv, const char *const *envp, int flags)
{
	bprm = kzalloc(sizeof(*pbrm), GFP_KERNEL);
        bprm->argc = count_kernel_strings(argv);
        bprm->envc = count_kernel_strings(envp);
        prepare_arg_pages(bprm);
        copy_strings_kernel(bprm->envc, envp, bprm);
        copy_strings_kernel(bprm->argc, argc, bprm);
	ret = bprm_execveat(AT_FDCWD, filename, bprm);
        free_bprm(bprm);
        return ret;
}

int do_exeveat(int fd, const char *filename,
		const char __user *const __user *argv,
                const char __user *const __user *envp, int flags)
{
	bprm = kzalloc(sizeof(*pbrm), GFP_KERNEL);
        bprm->argc = count_strings(argv);
        bprm->envc = count_strings(envp);
        prepare_arg_pages(bprm);
        copy_strings(bprm->envc, envp, bprm);
        copy_strings(bprm->argc, argc, bprm);
	ret = bprm_execveat(fd, filename, bprm);
        free_bprm(bprm);
        return ret;
}

More work is required obviously to make the code above really work but
when the dust clears a structure like that doesn't have funny edge cases
that can hide bugs and make it tricky to change the code.

Eric



