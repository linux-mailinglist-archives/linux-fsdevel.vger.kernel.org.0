Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABEE75976B8
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Aug 2022 21:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240739AbiHQThp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Aug 2022 15:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239839AbiHQTho (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Aug 2022 15:37:44 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7124917AB2
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:37:42 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id bh13so12808509pgb.4
        for <linux-fsdevel@vger.kernel.org>; Wed, 17 Aug 2022 12:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VkFb2gmnPJh2DD1NwRLdwKWVCBSGP9OxCe1ZkFaX8Fw=;
        b=AUVwyR7T7c7LluQYD30dZSGSzo/Eycc90zAFFEuet1uMsbv5KnvP7VYTTe4PpcmjXu
         N9VKziWiTK2yadkGsvq2WojWbC3dRJnmMUOJbIlpVOVCEYN/lF2xkwlzL/JBsjzFCzRK
         /klZxgOKHQh/76lrnhKriLJ7ZfrxK28K1f0cg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VkFb2gmnPJh2DD1NwRLdwKWVCBSGP9OxCe1ZkFaX8Fw=;
        b=II/3SlN97KtPvGmQKPn1dE6HMI0wmcRkRGPZamodkSWr9c/V87Ti4+SOJ3K0dlreDM
         Rs4DHltqAM8Snhloz+J8HWZfcoIKwBKOnqbdqdXVHjEnO2dOeEIngOIwTQVnk0ImTVd3
         oAj8WZ0JdWDY4uoKN/y4vQiiuJUKeGH06jDcw9NNiW9lOxRRdny8QhMzrhGXziRTDVgo
         NzZ0ZVc0Ick6ErtS1gJWS7XOGlLjhF4n+R9H1saNhULfT6NoMFJZfl4HOSSoi00K8gzz
         EbyD1BZSF1mIuwysqSxkIeVeM4hqpZd7iFq9X0iNSj5JmpAwSr1TX8q1MfTP57KQFOTA
         1UMw==
X-Gm-Message-State: ACgBeo0zgMaucmj0kGxQwPp4ndIU7e0RsAQlChjbkSMYMR7QFauskwso
        8Zrns3340lNWgPR5pj1fZTbEvg==
X-Google-Smtp-Source: AA6agR7V68uSa1wYB6yzkPNJOAf7DHUj6X4X5IvV1s+gIVOck89U0OwaFrfhP6SCIjgKS9MupRYLhg==
X-Received: by 2002:a05:6a00:b82:b0:52f:518f:fe6c with SMTP id g2-20020a056a000b8200b0052f518ffe6cmr27121499pfj.80.1660765061670;
        Wed, 17 Aug 2022 12:37:41 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o11-20020a170902d4cb00b0016bd8fb1fafsm261758plg.307.2022.08.17.12.37.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 12:37:40 -0700 (PDT)
Date:   Wed, 17 Aug 2022 12:37:40 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, patches@lists.linux.dev,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Boqun Feng <boqun.feng@gmail.com>
Subject: Re: [PATCH v9 02/27] kallsyms: avoid hardcoding buffer size
Message-ID: <202208171236.9CA3B9D579@keescook>
References: <20220805154231.31257-1-ojeda@kernel.org>
 <20220805154231.31257-3-ojeda@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220805154231.31257-3-ojeda@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 05, 2022 at 05:41:47PM +0200, Miguel Ojeda wrote:
> From: Boqun Feng <boqun.feng@gmail.com>
> 
> This introduces `KSYM_NAME_LEN_BUFFER` in place of the previously
> hardcoded size of the input buffer.
> 
> It will also make it easier to update the size in a single place
> in a later patch.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Co-developed-by: Miguel Ojeda <ojeda@kernel.org>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Reviewed-by: Kees Cook <keescook@chromium.org>

Does someone want to commit to taking these "prereq" patches? These
clean-ups are nice even without adding Rust.

-Kees

> ---
>  scripts/kallsyms.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/kallsyms.c b/scripts/kallsyms.c
> index 52f5488c61bc..f3c5a2623f71 100644
> --- a/scripts/kallsyms.c
> +++ b/scripts/kallsyms.c
> @@ -27,8 +27,14 @@
>  
>  #define ARRAY_SIZE(arr) (sizeof(arr) / sizeof(arr[0]))
>  
> +#define _stringify_1(x)	#x
> +#define _stringify(x)	_stringify_1(x)
> +
>  #define KSYM_NAME_LEN		128
>  
> +/* A substantially bigger size than the current maximum. */
> +#define KSYM_NAME_LEN_BUFFER	499
> +
>  struct sym_entry {
>  	unsigned long long addr;
>  	unsigned int len;
> @@ -198,13 +204,13 @@ static void check_symbol_range(const char *sym, unsigned long long addr,
>  
>  static struct sym_entry *read_symbol(FILE *in)
>  {
> -	char name[500], type;
> +	char name[KSYM_NAME_LEN_BUFFER+1], type;
>  	unsigned long long addr;
>  	unsigned int len;
>  	struct sym_entry *sym;
>  	int rc;
>  
> -	rc = fscanf(in, "%llx %c %499s\n", &addr, &type, name);
> +	rc = fscanf(in, "%llx %c %" _stringify(KSYM_NAME_LEN_BUFFER) "s\n", &addr, &type, name);
>  	if (rc != 3) {
>  		if (rc != EOF && fgets(name, sizeof(name), in) == NULL)
>  			fprintf(stderr, "Read error or end of file.\n");
> -- 
> 2.37.1
> 

-- 
Kees Cook
