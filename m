Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1454372BB03
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jun 2023 10:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233426AbjFLImf (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jun 2023 04:42:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233370AbjFLImd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:42:33 -0400
X-Greylist: delayed 2019 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Jun 2023 01:42:31 PDT
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDF3B7;
        Mon, 12 Jun 2023 01:42:30 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:49274)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q8cba-00GVnS-6T; Mon, 12 Jun 2023 02:08:50 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:41498 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q8cbY-00F8nl-Ss; Mon, 12 Jun 2023 02:08:49 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20230607144227.8956-1-ansuelsmth@gmail.com>
Date:   Mon, 12 Jun 2023 03:08:21 -0500
In-Reply-To: <20230607144227.8956-1-ansuelsmth@gmail.com> (Christian Marangi's
        message of "Wed, 7 Jun 2023 16:42:27 +0200")
Message-ID: <875y7tumq2.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q8cbY-00F8nl-Ss;;;mid=<875y7tumq2.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX19mPd4u3NrhQg/U/AK1EfBVUc3XuMgnfKI=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa06 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: ;Christian Marangi <ansuelsmth@gmail.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 648 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 12 (1.8%), b_tie_ro: 10 (1.6%), parse: 1.15
        (0.2%), extract_message_metadata: 4.8 (0.7%), get_uri_detail_list: 2.4
        (0.4%), tests_pri_-2000: 3.5 (0.5%), tests_pri_-1000: 2.7 (0.4%),
        tests_pri_-950: 1.29 (0.2%), tests_pri_-900: 1.03 (0.2%),
        tests_pri_-200: 0.86 (0.1%), tests_pri_-100: 10 (1.5%), tests_pri_-90:
        90 (13.8%), check_bayes: 86 (13.2%), b_tokenize: 8 (1.3%),
        b_tok_get_all: 9 (1.4%), b_comp_prob: 3.0 (0.5%), b_tok_touch_all: 62
        (9.6%), b_finish: 0.93 (0.1%), tests_pri_0: 493 (76.1%),
        check_dkim_signature: 0.53 (0.1%), check_dkim_adsp: 2.9 (0.4%),
        poll_dns_idle: 1.04 (0.2%), tests_pri_10: 3.6 (0.6%), tests_pri_500:
        16 (2.4%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH] binfmt_elf: dynamically allocate note.data in
 parse_elf_properties
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christian Marangi <ansuelsmth@gmail.com> writes:

> Dynamically allocate note.data in parse_elf_properties to fix
> compilation warning on some arch.
>
> On some arch note.data exceed the stack limit for a single function and
> this cause the following compilation warning:
> fs/binfmt_elf.c: In function 'parse_elf_properties.isra':
> fs/binfmt_elf.c:821:1: error: the frame size of 1040 bytes is larger than 1024 bytes [-Werror=frame-larger-than=]
>   821 | }
>       | ^
> cc1: all warnings being treated as errors
>
> Fix this by dynamically allocating the array.
> Update the sizeof of the union to the biggest element allocated.
>
> Fixes: 00e19ceec80b ("ELF: Add ELF program property parsing support")
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Cc: stable@vger.kernel.org # v5.8+
> ---
>  fs/binfmt_elf.c | 36 +++++++++++++++++++++++++-----------
>  1 file changed, 25 insertions(+), 11 deletions(-)
>
> diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
> index 44b4c42ab8e8..90daa623ca13 100644
> --- a/fs/binfmt_elf.c
> +++ b/fs/binfmt_elf.c
> @@ -768,7 +768,7 @@ static int parse_elf_properties(struct file *f, const struct elf_phdr *phdr,
>  {
>  	union {
>  		struct elf_note nhdr;
> -		char data[NOTE_DATA_SZ];
> +		char *data;
>  	} note;

If you are going to dynamically allocate this not that way please.
Only dynamically allocating one member of a union is to put it politely
completely broken.

The entire union needs to be dynamically allocated.

Given that the entire thing is 1024 bytes in size.  I can understand the
concern.

Hmm.


The entire union is a buffer for the entire note section.
So 1K is understandable if it needs to hold all of the notes.

Of course only a single note is a wrapper of a bunch of gnu_properties.
Hopefully that single note comes first.


The notehdr + name take 16 bytes.
The only supported gnu_property takes 12 bytes. I think 16 in practice.


Hmm.  So we could do with a smaller buffer.

Hmm.

The code does not check that all phdr->p_filesz bytes are actually
read.

So I would suggest defining the union to be ELF_EXEC_PAGESIZE bytes,
dynamically allocating it like we do all of the other buffers we
read elf headers into, and then use elf_read to verify that we
read all of phdr->p_filesz bytes.

Just like we do for the elf program headers.  I think having a second
pattern for reading data is more likely to be a problem than a dynamic
memory allocation.  Especially since this code only runs on one
architecture in practice.

The changes will cost nothing except on arm64 and it will be as cheap
as it can be, being simply a single page allocation.


Either that or you can up your stack limit on 64bit architectures like
everyone else.

Eric

