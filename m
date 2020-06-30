Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64A3D20F4B4
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 14:34:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387723AbgF3MeP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Jun 2020 08:34:15 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:40866 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732042AbgF3MeO (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Jun 2020 08:34:14 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFSi-0001Uj-5e; Tue, 30 Jun 2020 06:34:08 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jqFSh-0004Zz-8C; Tue, 30 Jun 2020 06:34:07 -0600
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
Date:   Tue, 30 Jun 2020 07:29:34 -0500
In-Reply-To: <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Mon, 29 Jun 2020 15:12:31 -0700")
Message-ID: <87eepwzqhd.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jqFSh-0004Zz-8C;;;mid=<87eepwzqhd.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18taL0yKPCpx2MTSwFOdv2sl/sVvNIlmuU=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa08.xmission.com
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
        *      [sa08 0; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: ; sa08 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Alexei Starovoitov <alexei.starovoitov@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 468 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 12 (2.5%), b_tie_ro: 10 (2.1%), parse: 1.13
        (0.2%), extract_message_metadata: 4.1 (0.9%), get_uri_detail_list:
        1.75 (0.4%), tests_pri_-1000: 4.6 (1.0%), tests_pri_-950: 1.47 (0.3%),
        tests_pri_-900: 1.29 (0.3%), tests_pri_-90: 187 (39.9%), check_bayes:
        184 (39.4%), b_tokenize: 8 (1.6%), b_tok_get_all: 21 (4.5%),
        b_comp_prob: 3.9 (0.8%), b_tok_touch_all: 146 (31.2%), b_finish: 1.35
        (0.3%), tests_pri_0: 239 (51.1%), check_dkim_signature: 0.78 (0.2%),
        check_dkim_adsp: 2.9 (0.6%), poll_dns_idle: 1.26 (0.3%), tests_pri_10:
        2.4 (0.5%), tests_pri_500: 7 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

2> On Mon, Jun 29, 2020 at 02:55:05PM -0500, Eric W. Biederman wrote:
>> 
>> I have tested thes changes by booting with the code compiled in and
>> by killing "bpfilter_umh" and running iptables -vnL to restart
>> the userspace driver.
>> 
>> I have compiled tested each change with and without CONFIG_BPFILTER
>> enabled.
>
> With
> CONFIG_BPFILTER=y
> CONFIG_BPFILTER_UMH=m
> it doesn't build:
>
> ERROR: modpost: "kill_pid_info" [net/bpfilter/bpfilter.ko] undefined!
>
> I've added:
> +EXPORT_SYMBOL(kill_pid_info);
> to continue testing...

I am rather surprised I thought Tetsuo had already compile tested
modules.


> I suspect patch 13 is somehow responsible:
> +	if (tgid) {
> +		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
> +		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
> +		bpfilter_umh_cleanup(info);
> +	}
>
> I cannot figure out why it hangs. Some sort of race ?
> Since adding short delay between kill and wait makes it work.

Having had a chance to sleep kill_pid_info was a thinko, as was
!pid_task.  It should have been !pid_has_task as that takes the proper
rcu locking.

I don't know if that is going to be enough to fix the wait_event
but those are obvious bugs that need to be fixed.

diff --git a/net/bpfilter/bpfilter_kern.c b/net/bpfilter/bpfilter_kern.c
index 91474884ddb7..3e1874030daa 100644
--- a/net/bpfilter/bpfilter_kern.c
+++ b/net/bpfilter/bpfilter_kern.c
@@ -19,8 +19,8 @@ static void shutdown_umh(void)
        struct pid *tgid = info->tgid;
 
        if (tgid) {
-               kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
-               wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
+               kill_pid(tgid, SIGKILL, 1);
+               wait_event(tgid->wait_pidfd, !pid_has_task(tgid, PIDTYPE_TGID));
                bpfilter_umh_cleanup(info);
        }
 }

> And then did:
> while true; do iptables -L;rmmod bpfilter; done
>  
> Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().

Hmm.  The wake up happens just of tgid->wait_pidfd happens just before
release_task is called so there is a race.  As it is possible to wake
up and then go back to sleep before pid_has_task becomes false.

So I think I need a friendly helper that does:

bool task_has_exited(struct pid *tgid)
{
	bool exited = false;

	rcu_read_lock();
        tsk = pid_task(tgid, PIDTYPE_TGID);
        exited = !!tsk;
        if (tsk) {
        	exited = !!tsk->exit_state;
out:
	rcu_unlock();
	return exited;
}

There should be a sensible way to do that.

Eric


