Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C9D2BA0950
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 20:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726591AbfH1SRI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 14:17:08 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44589 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726563AbfH1SRI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:17:08 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i32VH-0004Ux-5M; Wed, 28 Aug 2019 12:17:07 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i32VG-0000s0-FB; Wed, 28 Aug 2019 12:17:06 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Michal Suchanek <msuchanek@suse.de>
Cc:     linuxppc-dev@lists.ozlabs.org,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        "Dmitry V. Levin" <ldv@altlinux.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Steven Rostedt" <rostedt@goodmis.org>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Firoz Khan <firoz.khan@linaro.org>,
        Christophe Leroy <christophe.leroy@c-s.fr>,
        Nicholas Piggin <npiggin@gmail.com>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Donnellan <andrew.donnellan@au1.ibm.com>,
        Breno Leitao <leitao@debian.org>,
        Allison Randal <allison@lohutok.net>,
        Michael Neuling <mikey@neuling.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
References: <cover.1566936688.git.msuchanek@suse.de>
        <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
        <8736hlyx8r.fsf@x220.int.ebiederm.org>
Date:   Wed, 28 Aug 2019 13:16:55 -0500
In-Reply-To: <8736hlyx8r.fsf@x220.int.ebiederm.org> (Eric W. Biederman's
        message of "Wed, 28 Aug 2019 13:13:08 -0500")
Message-ID: <87y2zdxii0.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i32VG-0000s0-FB;;;mid=<87y2zdxii0.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19FPHoR0c45QWgnOndw3RBOZkvxMXRg2is=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa03.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4666]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa03 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa03 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Suchanek <msuchanek@suse.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 200 ms - load_scoreonly_sql: 0.02 (0.0%),
        signal_user_changed: 2.8 (1.4%), b_tie_ro: 1.99 (1.0%), parse: 0.96
        (0.5%), extract_message_metadata: 13 (6.6%), get_uri_detail_list: 0.95
        (0.5%), tests_pri_-1000: 18 (9.0%), tests_pri_-950: 1.06 (0.5%),
        tests_pri_-900: 0.87 (0.4%), tests_pri_-90: 19 (9.5%), check_bayes: 18
        (8.8%), b_tokenize: 5 (2.7%), b_tok_get_all: 6 (2.8%), b_comp_prob:
        1.27 (0.6%), b_tok_touch_all: 3.4 (1.7%), b_finish: 0.67 (0.3%),
        tests_pri_0: 135 (67.4%), check_dkim_signature: 0.38 (0.2%),
        check_dkim_adsp: 2.3 (1.1%), poll_dns_idle: 0.90 (0.4%), tests_pri_10:
        1.69 (0.8%), tests_pri_500: 5 (2.6%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/4] fs: always build llseek.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Michal Suchanek <msuchanek@suse.de> writes:
>
>> 64bit !COMPAT does not build because the llseek syscall is in the
>> tables.
>
> Do I read this right you have a 128 bit offset to llseek on ppc64?
>
> Looking at the signature it does not appear to make sense to build this
> function on any 64bit platform.
>
> Perhaps the proper fix to to take llseek out of your syscall tables?

Sorry I missed seeing the 2 newer version of the patchset in my inbox
it seems you have already made the change I am suggesting.

Never mind.

Eric

