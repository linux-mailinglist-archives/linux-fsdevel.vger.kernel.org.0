Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916BF484A63
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Jan 2022 23:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235130AbiADWG3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Jan 2022 17:06:29 -0500
Received: from out03.mta.xmission.com ([166.70.13.233]:43610 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiADWG2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Jan 2022 17:06:28 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:60612)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4rwg-00GRl6-My; Tue, 04 Jan 2022 15:06:18 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:39706 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1n4rwe-00AJrs-EY; Tue, 04 Jan 2022 15:06:18 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     Walt Drummond <walt@drummond.us>, aacraid@microsemi.com,
        viro@zeniv.linux.org.uk, anna.schumaker@netapp.com, arnd@arndb.de,
        bsegall@google.com, bp@alien8.de, chuck.lever@oracle.com,
        bristot@redhat.com, dave.hansen@linux.intel.com,
        dwmw2@infradead.org, dietmar.eggemann@arm.com, dinguyen@kernel.org,
        geert@linux-m68k.org, gregkh@linuxfoundation.org, hpa@zytor.com,
        idryomov@gmail.com, mingo@redhat.com, yzaikin@google.com,
        ink@jurassic.park.msu.ru, jejb@linux.ibm.com, jmorris@namei.org,
        bfields@fieldses.org, jlayton@kernel.org, jirislaby@kernel.org,
        john.johansen@canonical.com, juri.lelli@redhat.com,
        keescook@chromium.org, mcgrof@kernel.org,
        martin.petersen@oracle.com, mattst88@gmail.com, mgorman@suse.de,
        oleg@redhat.com, pbonzini@redhat.com, peterz@infradead.org,
        rth@twiddle.net, richard@nod.at, serge@hallyn.com,
        rostedt@goodmis.org, tglx@linutronix.de,
        trond.myklebust@hammerspace.com, vincent.guittot@linaro.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        ceph-devel@vger.kernel.org, kvm@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-m68k@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-security-module@vger.kernel.org
References: <20220103181956.983342-1-walt@drummond.us>
        <87iluzidod.fsf@email.froward.int.ebiederm.org>
        <YdSzjPbVDVGKT4km@mit.edu>
Date:   Tue, 04 Jan 2022 16:05:26 -0600
In-Reply-To: <YdSzjPbVDVGKT4km@mit.edu> (Theodore Ts'o's message of "Tue, 4
        Jan 2022 15:52:28 -0500")
Message-ID: <87pmp79mxl.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1n4rwe-00AJrs-EY;;;mid=<87pmp79mxl.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+pTOQLVEgfzdSQ3AESBxxTFfoB2eTGC7k=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,XMNoVowels autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;"Theodore Ts'o" <tytso@mit.edu>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1478 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (0.8%), b_tie_ro: 10 (0.7%), parse: 1.68
        (0.1%), extract_message_metadata: 5 (0.4%), get_uri_detail_list: 2.2
        (0.1%), tests_pri_-1000: 4.9 (0.3%), tests_pri_-950: 1.22 (0.1%),
        tests_pri_-900: 1.15 (0.1%), tests_pri_-90: 73 (4.9%), check_bayes: 71
        (4.8%), b_tokenize: 12 (0.8%), b_tok_get_all: 14 (0.9%), b_comp_prob:
        6 (0.4%), b_tok_touch_all: 33 (2.3%), b_finish: 1.14 (0.1%),
        tests_pri_0: 1357 (91.8%), check_dkim_signature: 0.53 (0.0%),
        check_dkim_adsp: 2.7 (0.2%), poll_dns_idle: 0.85 (0.1%), tests_pri_10:
        3.5 (0.2%), tests_pri_500: 10 (0.7%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [RFC PATCH 0/8] signals: Support more than 64 signals
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

"Theodore Ts'o" <tytso@mit.edu> writes:

> On Tue, Jan 04, 2022 at 12:00:34PM -0600, Eric W. Biederman wrote:
>> I dug through the previous conversations and there is a little debate
>> about what makes sense for SIGPWR to do by default.  Alan Cox remembered
>> SIGPWR was sent when the power was restored, so ignoring SIGPWR by
>> default made sense.  Ted Tso pointed out a different scenario where it
>> was reasonable for SIGPWR to be a terminating signal.
>> 
>> So far no one has actually found any applications that will regress if
>> SIGPWR becomes ignored by default.  Furthermore on linux SIGPWR is only
>> defined to be sent to init, and init ignores all signals by default so
>> in practice SIGPWR is ignored by the only process that receives it
>> currently.
>
> As it turns out, systemd does *not* ignore SIGPWR.  Instead, it will
> initiate the sigpwr target.  From the systemd.special man page:
>
>        sigpwr.target
>            A special target that is started when systemd receives the
>            SIGPWR process signal, which is normally sent by the kernel
>            or UPS daemons when power fails.
>
> And child processes of systemd are not ignoring SIGPWR.  Instead, they
> are getting terminated.
>
> <tytso@cwcc>
> 41% /bin/sleep 50 &
> [1] 180671
> <tytso@cwcc>
> 42% kill -PWR 180671
> [1]+  Power failure           /bin/sleep 50


That is all as expected, and does not demonstrate a regression would
happen if SIGPWR were to treat SIG_DFL as SIG_IGN, as SIGWINCH, SIGCONT,
SIGCHLD, SIGURG do.  It does show there is the possibility of problems.

The practical question is does anything send SIGPWR to anything besides
init, and expect the process to handle SIGPWR or terminate?

Possibly easier to implement (if people desire) is to simply send
SIGCONT with an si_code that indicates someone pressed the VSTATUS
key.  We have a per signal 32bit si_code space so that should
be comparatively easy.

> I claim, though, that we could implement VSTATUS without implenting
> the SIGINFO part of the feature.

I agree that is the place to start.  And if we aren't going to use
SIGINFO perhaps we could have an equally good notification method
if anyone wants one.  Say call an ioctl and get an fd that can
be read when a VSTATUS request comes in.

SIGINFO vs SIGCONT vs a fd vs something else is something we can sort
out when people get interested in modifying userspace.

Eric
