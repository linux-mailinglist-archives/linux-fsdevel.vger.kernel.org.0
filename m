Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FDD349D6A7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Jan 2022 01:21:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233802AbiA0AV6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 26 Jan 2022 19:21:58 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:42110 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbiA0AV6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 26 Jan 2022 19:21:58 -0500
Received: from in02.mta.xmission.com ([166.70.13.52]:56834)
        by out02.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nCsY0-005wJl-On; Wed, 26 Jan 2022 17:21:56 -0700
Received: from ip68-110-24-146.om.om.cox.net ([68.110.24.146]:49734 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1nCsXz-006pY2-KG; Wed, 26 Jan 2022 17:21:56 -0700
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Heikki Kallasjoki <heikki.kallasjoki@iki.fi>,
        Ariadne Conill <ariadne@dereferenced.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Alexander Viro <viro@zeniv.linux.org.uk>
References: <20220126043947.10058-1-ariadne@dereferenced.org>
        <202201252241.7309AE568F@keescook>
        <39480927-B17F-4573-B335-7FCFD81AB997@chromium.org>
        <44b4472d-1d50-c43f-dbb1-953532339fb4@dereferenced.org>
        <YfE/owUY+gVnn2b/@selene.zem.fi> <202201261545.D955A71E@keescook>
Date:   Wed, 26 Jan 2022 18:20:50 -0600
In-Reply-To: <202201261545.D955A71E@keescook> (Kees Cook's message of "Wed, 26
        Jan 2022 15:57:35 -0800")
Message-ID: <8735lauizh.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1nCsXz-006pY2-KG;;;mid=<8735lauizh.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.24.146;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18Sz/maQ5hy2KEQvwA/EgujcJDkBMsam3I=
X-SA-Exim-Connect-IP: 68.110.24.146
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.0 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,TR_Symld_Words,T_TM2_M_HEADER_IN_MSG,
        T_TooManySym_01,T_TooManySym_02,T_TooManySym_03,XMSubLong
        autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4990]
        *  1.5 TR_Symld_Words too many words that have symbols inside
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_03 6+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Kees Cook <keescook@chromium.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 604 ms - load_scoreonly_sql: 0.41 (0.1%),
        signal_user_changed: 14 (2.3%), b_tie_ro: 12 (1.9%), parse: 1.19
        (0.2%), extract_message_metadata: 20 (3.3%), get_uri_detail_list: 2.7
        (0.4%), tests_pri_-1000: 30 (4.9%), tests_pri_-950: 1.37 (0.2%),
        tests_pri_-900: 1.07 (0.2%), tests_pri_-90: 173 (28.7%), check_bayes:
        170 (28.2%), b_tokenize: 7 (1.2%), b_tok_get_all: 50 (8.3%),
        b_comp_prob: 3.9 (0.6%), b_tok_touch_all: 105 (17.3%), b_finish: 1.18
        (0.2%), tests_pri_0: 350 (57.9%), check_dkim_signature: 0.98 (0.2%),
        check_dkim_adsp: 3.9 (0.6%), poll_dns_idle: 0.84 (0.1%), tests_pri_10:
        2.1 (0.3%), tests_pri_500: 7 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] fs/exec: require argv[0] presence in do_execveat_common()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Kees Cook <keescook@chromium.org> writes:

> On Wed, Jan 26, 2022 at 12:33:39PM +0000, Heikki Kallasjoki wrote:
>> On Wed, Jan 26, 2022 at 05:18:58AM -0600, Ariadne Conill wrote:
>> > On Tue, 25 Jan 2022, Kees Cook wrote:
>> > > Lots of stuff likes to do:
>> > > execve(path, NULL, NULL);
>> > 
>> > I looked at these, and these seem to basically be lazily-written test cases
>> > which should be fixed.  I didn't see any example of real-world applications
>> > doing this.  As noted in some of the test cases, there are comments like
>> > "Solaris doesn't support this," etc.
>> 
>> See also the (small) handful of instances of `execlp(cmd, NULL);` out
>> there, which I imagine would start to fail:
>> https://codesearch.debian.net/search?q=execlp%3F%5Cs*%5C%28%5B%5E%2C%5D%2B%2C%5Cs*NULL&literal=0
>> 
>> Two of the hits (ispell, nauty) would seem to be non-test use cases.
>
> Ah yeah, I've added this to the Issue tracker:
> https://github.com/KSPP/linux/issues/176

I just took a slightly deeper look at these.

There are two patterns found by that search.

-  execlp("/proc/self/exec", NULL)

    Which in both both the proot and care packages is a testt that
    deliberately loops and checks to see if it can generate "argc == 0".

    That is the case where changing argc == 0 into { "", NULL }
    will loop forever.

    For that test failing to exec the "argc == 0" will cause a test
    failure but for a security issue that seems a reasonable thing
    to do to a test.

- execlp(MACRO, NULL)

    The macro happens to contain commas so what looks via inspection
    will generate an application run with "argc == 0" actually
    does not.

Eric
