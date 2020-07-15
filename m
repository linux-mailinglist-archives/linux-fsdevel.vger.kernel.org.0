Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 604B4221437
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jul 2020 20:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726670AbgGOS0Z (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jul 2020 14:26:25 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:34524 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725907AbgGOS0Y (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jul 2020 14:26:24 -0400
Received: from in02.mta.xmission.com ([166.70.13.52])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvm6d-0008Fo-UP; Wed, 15 Jul 2020 12:26:11 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in02.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jvm6U-0003IZ-Lu; Wed, 15 Jul 2020 12:26:11 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Christoph Hellwig <hch@infradead.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-fsdevel@vger.kernel.org,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        linux-security-module@vger.kernel.org,
        "Serge E. Hallyn" <serge@hallyn.com>,
        James Morris <jmorris@namei.org>,
        Kentaro Takeda <takedakn@nttdata.co.jp>,
        Casey Schaufler <casey@schaufler-ca.com>,
        John Johansen <john.johansen@canonical.com>
References: <871rle8bw2.fsf@x220.int.ebiederm.org>
        <87wo365ikj.fsf@x220.int.ebiederm.org>
        <20200715064220.GG32470@infradead.org>
Date:   Wed, 15 Jul 2020 13:23:11 -0500
In-Reply-To: <20200715064220.GG32470@infradead.org> (Christoph Hellwig's
        message of "Wed, 15 Jul 2020 07:42:20 +0100")
Message-ID: <87lfjk3aeo.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jvm6U-0003IZ-Lu;;;mid=<87lfjk3aeo.fsf@x220.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18nYA25PFlqmd+QJj8Nw4u9gsb6kkHODq4=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa01.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,NO_DNS_FOR_FROM,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Virus: No
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4998]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa01 0; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 NO_DNS_FOR_FROM DNS: Envelope sender has no MX or A DNS records
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: ; sa01 0; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christoph Hellwig <hch@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 8899 ms - load_scoreonly_sql: 0.03 (0.0%),
        signal_user_changed: 3.7 (0.0%), b_tie_ro: 2.6 (0.0%), parse: 0.64
        (0.0%), extract_message_metadata: 8 (0.1%), get_uri_detail_list: 0.74
        (0.0%), tests_pri_-1000: 3.1 (0.0%), tests_pri_-950: 1.08 (0.0%),
        tests_pri_-900: 0.81 (0.0%), tests_pri_-90: 96 (1.1%), check_bayes: 95
        (1.1%), b_tokenize: 5 (0.1%), b_tok_get_all: 6 (0.1%), b_comp_prob:
        1.40 (0.0%), b_tok_touch_all: 78 (0.9%), b_finish: 0.89 (0.0%),
        tests_pri_0: 6203 (69.7%), check_dkim_signature: 0.36 (0.0%),
        check_dkim_adsp: 6008 (67.5%), poll_dns_idle: 8570 (96.3%),
        tests_pri_10: 2.7 (0.0%), tests_pri_500: 2577 (29.0%), rewrite_mail:
        0.00 (0.0%)
Subject: Re: [PATCH 7/7] exec: Implement kernel_execve
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> writes:

>> +static int count_strings_kernel(const char *const *argv)
>> +{
>> +	int i;
>> +
>> +	if (!argv)
>> +		return 0;
>> +
>> +	for (i = 0; argv[i]; ++i) {
>> +		if (i >= MAX_ARG_STRINGS)
>> +			return -E2BIG;
>> +		if (fatal_signal_pending(current))
>> +			return -ERESTARTNOHAND;
>> +		cond_resched();
>
> I don't think we need a fatal_signal_pending and cond_resched() is
> needed in each step given that we don't actually do anything.

If we have a MAX_ARG_STRINGS sized argv passed in, that is 2^31
iterations of the loop.  A processor at 2Ghz performs roughly 2^31
cycles per second.  So this loop has the potential to run for an entire
second.  That is long enough to need fatal_signal_pending() and
cond_resched checks.

In practice I don't think we have any argv arrays anywhere near that big
passed in from the kernel.  However removing the logic that accounts for
long running loops is best handled as a separate change so that people
will analyze the patch based on that criterian, and so that in the
highly unlikely even something goes wrong people have a nice commit
to bisect things to.

Eric
