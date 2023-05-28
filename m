Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA33A713AE3
	for <lists+linux-fsdevel@lfdr.de>; Sun, 28 May 2023 18:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229755AbjE1Q4w (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 28 May 2023 12:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbjE1Q4v (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 28 May 2023 12:56:51 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4206ED8;
        Sun, 28 May 2023 09:56:48 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:46880)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q3JKa-00Ciru-2q; Sun, 28 May 2023 10:33:20 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56530 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1q3JKZ-005jqW-4W; Sun, 28 May 2023 10:33:19 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-mm@kvack.org
References: <53150beae5dc04dac513dba391a2e4ae8696a7f3.1685290790.git.christophe.jaillet@wanadoo.fr>
Date:   Sun, 28 May 2023 11:32:52 -0500
In-Reply-To: <53150beae5dc04dac513dba391a2e4ae8696a7f3.1685290790.git.christophe.jaillet@wanadoo.fr>
        (Christophe JAILLET's message of "Sun, 28 May 2023 18:20:24 +0200")
Message-ID: <871qj0l8ln.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1q3JKZ-005jqW-4W;;;mid=<871qj0l8ln.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.110.29.46;;;frm=ebiederm@xmission.com;;;spf=pass
X-XM-AID: U2FsdGVkX1+tXXgu/hTVpYUB13NneAVqnHHTh5F4BPI=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-DCC: XMission; sa07 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Christophe JAILLET <christophe.jaillet@wanadoo.fr>
X-Spam-Relay-Country: 
X-Spam-Timing: total 364 ms - load_scoreonly_sql: 0.05 (0.0%),
        signal_user_changed: 10 (2.6%), b_tie_ro: 8 (2.2%), parse: 0.85 (0.2%),
         extract_message_metadata: 11 (3.1%), get_uri_detail_list: 0.99 (0.3%),
         tests_pri_-2000: 11 (3.1%), tests_pri_-1000: 2.6 (0.7%),
        tests_pri_-950: 1.25 (0.3%), tests_pri_-900: 1.05 (0.3%),
        tests_pri_-200: 0.86 (0.2%), tests_pri_-100: 6 (1.6%), tests_pri_-90:
        57 (15.6%), check_bayes: 55 (15.2%), b_tokenize: 5 (1.5%),
        b_tok_get_all: 6 (1.6%), b_comp_prob: 1.89 (0.5%), b_tok_touch_all: 38
        (10.6%), b_finish: 0.92 (0.3%), tests_pri_0: 250 (68.8%),
        check_dkim_signature: 0.54 (0.1%), check_dkim_adsp: 2.3 (0.6%),
        poll_dns_idle: 0.62 (0.2%), tests_pri_10: 2.1 (0.6%), tests_pri_500: 7
        (2.0%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH 1/2] binfmt: Use struct_size()
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Christophe JAILLET <christophe.jaillet@wanadoo.fr> writes:

> Use struct_size() instead of hand-writing it. It is less verbose, more
> robust and more informative.

Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
Obviously correct transform.

>
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested on arm
> ---
>  fs/binfmt_elf_fdpic.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
> index d76ad3d4f676..237ce388d06d 100644
> --- a/fs/binfmt_elf_fdpic.c
> +++ b/fs/binfmt_elf_fdpic.c
> @@ -748,7 +748,6 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>  	struct elf32_phdr *phdr;
>  	unsigned long load_addr, stop;
>  	unsigned nloads, tmp;
> -	size_t size;
>  	int loop, ret;
>  
>  	/* allocate a load map table */
> @@ -760,8 +759,7 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *params,
>  	if (nloads == 0)
>  		return -ELIBBAD;
>  
> -	size = sizeof(*loadmap) + nloads * sizeof(*seg);
> -	loadmap = kzalloc(size, GFP_KERNEL);
> +	loadmap = kzalloc(struct_size(loadmap, segs, nloads), GFP_KERNEL);
>  	if (!loadmap)
>  		return -ENOMEM;
