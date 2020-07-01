Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CC5E2111C9
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Jul 2020 19:17:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732637AbgGARRQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Jul 2020 13:17:16 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:43496 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731122AbgGARRP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Jul 2020 13:17:15 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqgMA-0003Fl-5f; Wed, 01 Jul 2020 11:17:10 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqgM9-0004As-5q; Wed, 01 Jul 2020 11:17:10 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
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
        Casey Schaufler <casey@schaufler-ca.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
References: <20200625095725.GA3303921@kroah.com>
        <778297d2-512a-8361-cf05-42d9379e6977@i-love.sakura.ne.jp>
        <20200625120725.GA3493334@kroah.com>
        <20200625.123437.2219826613137938086.davem@davemloft.net>
        <CAHk-=whuTwGHEPjvtbBvneHHXeqJC=q5S09mbPnqb=Q+MSPMag@mail.gmail.com>
        <87pn9mgfc2.fsf_-_@x220.int.ebiederm.org>
        <87y2oac50p.fsf@x220.int.ebiederm.org>
        <87bll17ili.fsf_-_@x220.int.ebiederm.org>
        <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        <87eepwzqhd.fsf@x220.int.ebiederm.org>
        <20200630165256.i7wdfjxmqu73fewc@ast-mbp.dhcp.thefacebook.com>
Date:   Wed, 01 Jul 2020 12:12:35 -0500
In-Reply-To: <20200630165256.i7wdfjxmqu73fewc@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Tue, 30 Jun 2020 09:52:56 -0700")
Message-ID: <87lfk3w458.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqgM9-0004As-5q;;;mid=<87lfk3w458.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1/OTl4+7uj9gmckES4vam8J/yGBVetut8Y=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa07 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 605 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 9 (1.5%), b_tie_ro: 7 (1.2%), parse: 1.49 (0.2%),
        extract_message_metadata: 4.8 (0.8%), get_uri_detail_list: 2.1 (0.3%),
        tests_pri_-1000: 7 (1.2%), tests_pri_-950: 6 (1.0%), tests_pri_-900:
        1.57 (0.3%), tests_pri_-90: 140 (23.1%), check_bayes: 138 (22.8%),
        b_tokenize: 14 (2.3%), b_tok_get_all: 9 (1.4%), b_comp_prob: 3.5
        (0.6%), b_tok_touch_all: 105 (17.3%), b_finish: 1.05 (0.2%),
        tests_pri_0: 405 (67.0%), check_dkim_signature: 0.59 (0.1%),
        check_dkim_adsp: 3.0 (0.5%), poll_dns_idle: 0.53 (0.1%), tests_pri_10:
        2.5 (0.4%), tests_pri_500: 14 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Tue, Jun 30, 2020 at 07:29:34AM -0500, Eric W. Biederman wrote:
>> 
>> diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
>> index 91474884ddb7..3e1874030daa 100644
>> --- a/net/bpfilter/bpfilter_kern.c
>> +++ b/net/bpfilter/bpfilter_kern.c
>> @@ -19,8 +19,8 @@ static void shutdown_umh(void)
>>         struct pid *tgid = info->tgid;
>>  
>>         if (tgid) {
>> -               kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
>> -               wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
>> +               kill_pid(tgid, SIGKILL, 1);
>> +               wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
>>                 bpfilter_umh_cleanup(info);
>>         }
>>  }
>> 
>> > And then did:
>> > while true; do iptables -L;rmmod bpfilter; done
>> >  
>> > Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().
>> 
>> Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
>> release_task is called so there is a race.  As it is possible to wake
>> up and then go back to sleep before pid_has_task becomes false.
>> 
>> So I think I need a friendly helper that does:
>> 
>> bool task_has_exited(struct pid *tgid)
>> {
>> 	bool exited = false;
>> 
>> 	rcu_read_lock();
>>         tsk = pid_task(tgid, PIDTYPE_TGID);
>>         exited = !!tsk;
>>         if (tsk) {
>>         	exited = !!tsk->exit_state;
>> out:
>> 	rcu_unlock();
>> 	return exited;
>> }
>
> All makes sense to me.
> If I understood the race condition such helper should indeed solve it.
> Are you going to add such patch to your series?
> I'll proceed with my work on top of your series and will ignore this
> race for now, but I think it should be fixed before we land this set
> into multiple trees.

Yes. I am just finishing it up now.

Eric

