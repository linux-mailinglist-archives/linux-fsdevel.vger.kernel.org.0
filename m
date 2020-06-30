Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B98020EAC7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jun 2020 03:21:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgF3BS0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jun 2020 21:18:26 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:53410 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726436AbgF3BSZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jun 2020 21:18:25 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq4uh-0000O9-IN; Mon, 29 Jun 2020 19:18:19 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jq4ug-0002jh-Pf; Mon, 29 Jun 2020 19:18:19 -0600
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
Date:   Mon, 29 Jun 2020 20:13:47 -0500
In-Reply-To: <20200629221231.jjc2czk3ul2roxkw@ast-mbp.dhcp.thefacebook.com>
        (Alexei Starovoitov's message of "Mon, 29 Jun 2020 15:12:31 -0700")
Message-ID: <87y2o51hkk.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jq4ug-0002jh-Pf;;;mid=<87y2o51hkk.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+/8MQJ7LM/LZopl5fhfWi2DThHoCOY7Hc=
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
X-Spam-Timing: total 333 ms - load_scoreonly_sql: 0.17 (0.1%),
        signal_user_changed: 12 (3.6%), b_tie_ro: 10 (2.9%), parse: 1.27
        (0.4%), extract_message_metadata: 4.0 (1.2%), get_uri_detail_list:
        1.27 (0.4%), tests_pri_-1000: 5.0 (1.5%), tests_pri_-950: 1.27 (0.4%),
        tests_pri_-900: 1.09 (0.3%), tests_pri_-90: 79 (23.8%), check_bayes:
        78 (23.4%), b_tokenize: 8 (2.3%), b_tok_get_all: 6 (1.9%),
        b_comp_prob: 2.2 (0.7%), b_tok_touch_all: 58 (17.5%), b_finish: 0.97
        (0.3%), tests_pri_0: 209 (62.9%), check_dkim_signature: 0.58 (0.2%),
        check_dkim_adsp: 2.4 (0.7%), poll_dns_idle: 0.68 (0.2%), tests_pri_10:
        2.3 (0.7%), tests_pri_500: 8 (2.3%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 00/15] Make the user mode driver code a better citizen
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Alexei Starovoitov <alexei.starovoitov@gmail.com> writes:

> On Mon, Jun 29, 2020 at 02:55:05PM -0500, Eric W. Biederman wrote:
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
>
> And then did:
> while true; do iptables -L;rmmod bpfilter; done
>  
> Unfortunately sometimes 'rmmod bpfilter' hangs in wait_event().
>
> I suspect patch 13 is somehow responsible:
> +	if (tgid) {
> +		kill_pid_info(SIGKILL, SEND_SIG_PRIV, tgid);
> +		wait_event(tgid->wait_pidfd, !pid_task(tgid, PIDTYPE_TGID));
> +		bpfilter_umh_cleanup(info);
> +	}
>
> I cannot figure out why it hangs. Some sort of race ?
> Since adding short delay between kill and wait makes it work.

Thanks.  I will take a look.

Eric
