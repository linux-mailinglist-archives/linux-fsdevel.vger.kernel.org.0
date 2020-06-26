Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 580D720B6D3
	for <lists+linux-fsdevel@lfdr.de>; Fri, 26 Jun 2020 19:22:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbgFZRWO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 26 Jun 2020 13:22:14 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:38286 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726139AbgFZRWO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 26 Jun 2020 13:22:14 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jos3F-00056A-ME; Fri, 26 Jun 2020 11:22:09 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jos3E-00066Y-OC; Fri, 26 Jun 2020 11:22:09 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Miller <davem@davemloft.net>,
        Greg Kroah-Hartman <greg@kroah.com>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
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
        Casey Schaufler <casey@schaufler-ca.com>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <20200626164055.5iasnou57yrtt6wz@ast-mbp.dhcp.thefacebook.com>
Date:   Fri, 26 Jun 2020 12:17:40 -0500
In-Reply-To: <20200626164055.5iasnou57yrtt6wz@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Fri, 26 Jun 2020 09:40:55 -0700")
Message-ID: <87sgeh926j.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jos3E-00066Y-OC;;;mid=<87sgeh926j.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19iYzMwx7bCBaPQ2l8NqBFdNQa296MM+Fw=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa02.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa02 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa02 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 511 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 4.5 (0.9%), b_tie_ro: 3.1 (0.6%), parse: 1.21
        (0.2%), extract_message_metadata: 5.0 (1.0%), get_uri_detail_list: 2.7
        (0.5%), tests_pri_-1000: 3.9 (0.8%), tests_pri_-950: 1.08 (0.2%),
        tests_pri_-900: 0.82 (0.2%), tests_pri_-90: 139 (27.3%), check_bayes:
        138 (26.9%), b_tokenize: 8 (1.5%), b_tok_get_all: 11 (2.1%),
        b_comp_prob: 3.5 (0.7%), b_tok_touch_all: 113 (22.0%), b_finish: 0.77
        (0.2%), tests_pri_0: 337 (66.0%), check_dkim_signature: 0.40 (0.1%),
        check_dkim_adsp: 2.5 (0.5%), poll_dns_idle: 1.16 (0.2%), tests_pri_10:
        2.7 (0.5%), tests_pri_500: 7 (1.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 00/14] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Fri, Jun 26, 2020 at 07:51:41AM -0500, Eric W. Biederman wrote:
>> 
>> Asking for people to fix their bugs in this user mode driver code has
>> been remarkably unproductive.  So here are my bug fixes.
>> 
>> I have tested them by booting with the code compiled in and
>> by killing "bpfilter_umh" and running iptables -vnL to restart
>> the userspace driver.
>> 
>> I have split the changes into small enough pieces so they should be
>> easily readable and testable.  
>> 
>> The changes lean into the preexisting interfaces in the kernel and
>> remove special cases for user mode driver code in favor of solutions
>> that don't need special cases.  This results in smaller code with
>> fewer bugs.
>> 
>> At a practical level this removes the maintenance burden of the
>> user mode drivers from the user mode helper code and from exec as
>> the special cases are removed.
>> 
>> Similarly the LSM interaction bugs are fixed by not having unnecessary
>> special cases for user mode drivers.
>> 
>> Please let me know if you see any bugs.  Once the code review is
>> finished I plan to take this through my tree.
>
> I did a quick look and I like the cleanup. Thanks!

Good then we have a path forward.

> The end result looks good.
> The only problem that you keep breaking the build between patches,
> so series will not be bisectable.

Keep breaking?  There is an issue with patch 5/14 where the build breaks
when bpfilter is not enabled.  Do you see any others? I know I tested
each patch individually.  But I was only testing with CONFIG_BPFILTER
enabled so I missed one.

So there should not be things that break
but things slip through occassionally.

I will resend this shortly with the fix and any others that I can find.

> blob_to_mnt is a great idea. Much better than embedding fs you advocated earlier.

I was lazy and not overdesigning but I still suspect the blob will
benefit from becoming a cpio in the future.

> I'm swamped with other stuff today and will test the set Sunday/Monday
> with other patches that I'm working on.
> I'm not sure why you want to rename the interface. Seems
> pointless. But fine.

For maintainability I think the code very much benefits from a clear
separation between the user mode driver code from the user mode helper
code.

> As far as routing trees. Do you mind I'll take it via bpf-next ?
> As I said countless times we're working on bpf_iter using fork_blob.
> If you take this set via your tree we would need to wait the whole kernel release.
> Which is 8+ weeks before we can use the interface (due to renaming and overall changes).
> I'd really like to avoid this huge delay.
> Unless you can land it into 5.8-rc2 or rc3.

I also want to build upon this code.

How about when the review is done I post a frozen branch based on
v5.8-rc1 that you can merge into the bpf-next tree, and I can merge into
my branch.  That way we both can build upon this code.  That is the way
conflicts like this are usually handled.

Further I will leave any further enhancements to the user mode driver
infrastructure that people have suggested to you.

I will probably replace do_execve with a kernel_execve that doesn't need
set_fs() to copy the command line argument.  I haven't seen Christoph
Hellwig address that yet, and it looks pretty straight foward at this
point.


Eric

