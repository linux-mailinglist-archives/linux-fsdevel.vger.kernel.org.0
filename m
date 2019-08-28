Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ECA0A0949
	for <lists+linux-fsdevel@lfdr.de>; Wed, 28 Aug 2019 20:13:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfH1SN1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 28 Aug 2019 14:13:27 -0400
Received: from out03.mta.xmission.com ([166.70.13.233]:44198 "EHLO
        out03.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726400AbfH1SN0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 28 Aug 2019 14:13:26 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out03.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i32Rc-00046B-Eb; Wed, 28 Aug 2019 12:13:20 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1i32Ra-0000CA-T6; Wed, 28 Aug 2019 12:13:20 -0600
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
Date:   Wed, 28 Aug 2019 13:13:08 -0500
In-Reply-To: <80b1955b86fb81e4642881d498068b5a540ef029.1566936688.git.msuchanek@suse.de>
        (Michal Suchanek's message of "Tue, 27 Aug 2019 22:21:06 +0200")
Message-ID: <8736hlyx8r.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1i32Ra-0000CA-T6;;;mid=<8736hlyx8r.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19tJ+0ygLXYYSaWSDzqRpX5AB+XRHVKmoo=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa07.xmission.com
X-Spam-Level: **
X-Spam-Status: No, score=2.3 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_XMDrugObfuBody_08,XMNoVowels autolearn=disabled version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4699]
        *  1.5 XMNoVowels Alpha-numberic number with no vowels
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa07 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_08 obfuscated drug references
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: **;Michal Suchanek <msuchanek@suse.de>
X-Spam-Relay-Country: 
X-Spam-Timing: total 1058 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 4.7 (0.4%), b_tie_ro: 3.8 (0.4%), parse: 0.92
        (0.1%), extract_message_metadata: 11 (1.1%), get_uri_detail_list: 1.05
        (0.1%), tests_pri_-1000: 13 (1.2%), tests_pri_-950: 1.32 (0.1%),
        tests_pri_-900: 1.17 (0.1%), tests_pri_-90: 26 (2.5%), check_bayes: 25
        (2.3%), b_tokenize: 9 (0.8%), b_tok_get_all: 7 (0.7%), b_comp_prob:
        2.1 (0.2%), b_tok_touch_all: 3.8 (0.4%), b_finish: 1.28 (0.1%),
        tests_pri_0: 230 (21.7%), check_dkim_signature: 1.02 (0.1%),
        check_dkim_adsp: 4.1 (0.4%), poll_dns_idle: 754 (71.3%), tests_pri_10:
        2.4 (0.2%), tests_pri_500: 764 (72.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/4] fs: always build llseek.
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Michal Suchanek <msuchanek@suse.de> writes:

> 64bit !COMPAT does not build because the llseek syscall is in the
> tables.

Do I read this right you have a 128 bit offset to llseek on ppc64?

Looking at the signature it does not appear to make sense to build this
function on any 64bit platform.

Perhaps the proper fix to to take llseek out of your syscall tables?

Eric

> Signed-off-by: Michal Suchanek <msuchanek@suse.de>
> ---
>  fs/read_write.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/fs/read_write.c b/fs/read_write.c
> index 5bbf587f5bc1..9db56931eb26 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -331,7 +331,6 @@ COMPAT_SYSCALL_DEFINE3(lseek, unsigned int, fd, compat_off_t, offset, unsigned i
>  }
>  #endif
>  
> -#if !defined(CONFIG_64BIT) || defined(CONFIG_COMPAT)
>  SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
>  		unsigned long, offset_low, loff_t __user *, result,
>  		unsigned int, whence)
> @@ -360,7 +359,6 @@ SYSCALL_DEFINE5(llseek, unsigned int, fd, unsigned long, offset_high,
>  	fdput_pos(f);
>  	return retval;
>  }
> -#endif
>  
>  int rw_verify_area(int read_write, struct file *file, const loff_t *ppos, size_t count)
>  {
