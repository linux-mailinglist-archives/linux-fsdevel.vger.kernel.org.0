Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B454A1C05EA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Apr 2020 21:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgD3TKj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Apr 2020 15:10:39 -0400
Received: from out01.mta.xmission.com ([166.70.13.231]:58196 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgD3TKj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:10:39 -0400
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out01.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUEZk-0000zA-Oa; Thu, 30 Apr 2020 13:10:24 -0600
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1jUEZj-0004x2-MM; Thu, 30 Apr 2020 13:10:24 -0600
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Ungerer <gerg@linux-m68k.org>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Jann Horn <jannh@google.com>, Nicolas Pitre <nico@fluxnic.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Oleg Nesterov <oleg@redhat.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Mark Salter <msalter@redhat.com>,
        Aurelien Jacquiot <jacquiot.aurelien@gmail.com>,
        linux-c6x-dev@linux-c6x.org,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Linux-sh list <linux-sh@vger.kernel.org>
References: <20200429214954.44866-1-jannh@google.com>
        <20200429215620.GM1551@shell.armlinux.org.uk>
        <CAHk-=wgpoEr33NJwQ+hqK1dz3Rs9jSw+BGotsSdt2Kb3HqLV7A@mail.gmail.com>
        <31196268-2ff4-7a1d-e9df-6116e92d2190@linux-m68k.org>
        <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
Date:   Thu, 30 Apr 2020 14:07:06 -0500
In-Reply-To: <CAHk-=wjau_zmdLaFDLcY3xnqiFaC7VZDXnnzFG9QDHL4kqStYQ@mail.gmail.com>
        (Linus Torvalds's message of "Thu, 30 Apr 2020 09:54:28 -0700")
Message-ID: <87imhgyeqt.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1jUEZj-0004x2-MM;;;mid=<87imhgyeqt.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX1+M59kbFeatkOUeTsajPIqn7fwIqzhVK08=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on sa05.xmission.com
X-Spam-Level: *
X-Spam-Status: No, score=1.5 required=8.0 tests=ALL_TRUSTED,BAYES_50,
        DCC_CHECK_NEGATIVE,T_TM2_M_HEADER_IN_MSG,T_TooManySym_01,
        T_TooManySym_02,T_XMDrugObfuBody_00,XMSubLong autolearn=disabled
        version=3.4.2
X-Spam-Report: * -1.0 ALL_TRUSTED Passed through trusted hosts only via SMTP
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4987]
        *  0.7 XMSubLong Long Subject
        *  0.0 T_TM2_M_HEADER_IN_MSG BODY: No description available.
        * -0.0 DCC_CHECK_NEGATIVE Not listed in DCC
        *      [sa05 1397; Body=1 Fuz1=1 Fuz2=1]
        *  0.0 T_TooManySym_01 4+ unique symbols in subject
        *  0.0 T_TooManySym_02 5+ unique symbols in subject
        *  1.0 T_XMDrugObfuBody_00 obfuscated drug references
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Linus Torvalds <torvalds@linux-foundation.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 556 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 11 (1.9%), b_tie_ro: 9 (1.7%), parse: 1.41 (0.3%),
         extract_message_metadata: 20 (3.7%), get_uri_detail_list: 2.7 (0.5%),
        tests_pri_-1000: 19 (3.4%), tests_pri_-950: 1.76 (0.3%),
        tests_pri_-900: 1.31 (0.2%), tests_pri_-90: 225 (40.4%), check_bayes:
        216 (38.9%), b_tokenize: 11 (2.1%), b_tok_get_all: 10 (1.8%),
        b_comp_prob: 2.6 (0.5%), b_tok_touch_all: 189 (33.9%), b_finish: 0.94
        (0.2%), tests_pri_0: 263 (47.3%), check_dkim_signature: 0.52 (0.1%),
        check_dkim_adsp: 2.2 (0.4%), poll_dns_idle: 0.80 (0.1%), tests_pri_10:
        1.93 (0.3%), tests_pri_500: 8 (1.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2 0/5] Fix ELF / FDPIC ELF core dumping, and use mmap_sem properly in there
X-Spam-Flag: No
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Thu, Apr 30, 2020 at 7:10 AM Greg Ungerer <gerg@linux-m68k.org> wrote:

>> > Most of that file goes back to pre-git days. And most of the commits
>> > since are not so much about binfmt_flat, as they are about cleanups or
>> > changes elsewhere where binfmt_flat was just a victim.
>>
>> I'll have a look at this.
>
> Thanks.
>
>> Quick hack test shows moving setup_new_exec(bprm) to be just before
>> install_exec_creds(bprm) works fine for the static binaries case.
>> Doing the flush_old_exec(bprm) there too crashed out - I'll need to
>> dig into that to see why.
>
> Just moving setup_new_exec() would at least allow us to then join the
> two together, and just say "setup_new_exec() does the credential
> installation too".

But it is only half a help if we allow failure points between
flush_old_exec and install_exec_creds.

Greg do things work acceptably if install_exec_creds is moved to right
after setup_new_exec? (patch below)

Looking at the code in load_flat_file after setup_new_exec it looks like
the kinds of things that in binfmt_elf.c we do after install_exec_creds
(aka vm_map).  So I think we want install_exec_creds sooner, instead
of setup_new_exec later.

> But if it's true that nobody really uses the odd flat library support
> any more and there are no testers, maybe we should consider ripping it
> out...

I looked a little deeper and there is another reason to think about
ripping out the flat library loader.  The code is recursive, and
supports a maximum of 4 shared libraries in the entire system.

load_flat_binary
	load_flat_file
        	calc_reloc
                	load_flat_shared_libary
                        	load_flat_file
                                	....

I am mystified with what kind of system can survive with a grand total
of 4 shared libaries.  I think my a.out slackware system that I ran on
my i486 had more shared libraries.

Having read just a bit more it is definitely guaranteed (by the code)
that the first time load_flat_file is called id 0 will be used (aka id 0
is guaranteed to be the binary), and the ids 1, 2, 3 and 4 will only be
used if a relocation includes that id to reference an external shared
library.  That part of the code is drop dead simple.

---

This is what I was thinking about applying.

diff --git a/fs/binfmt_flat.c b/fs/binfmt_flat.c
index 831a2b25ba79..1a1d1fcb893f 100644
--- a/fs/binfmt_flat.c
+++ b/fs/binfmt_flat.c
@@ -541,6 +541,7 @@ static int load_flat_file(struct linux_binprm *bprm,
 		/* OK, This is the point of no return */
 		set_personality(PER_LINUX_32BIT);
 		setup_new_exec(bprm);
+		install_exec_creds(bprm);
 	}
 
 	/*
@@ -963,8 +964,6 @@ static int load_flat_binary(struct linux_binprm *bprm)
 		}
 	}
 
-	install_exec_creds(bprm);
-
 	set_binfmt(&flat_format);
 
 #ifdef CONFIG_MMU


