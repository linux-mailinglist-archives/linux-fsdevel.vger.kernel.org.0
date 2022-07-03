Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E3EB56486D
	for <lists+linux-fsdevel@lfdr.de>; Sun,  3 Jul 2022 17:33:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbiGCPct (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Jul 2022 11:32:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232717AbiGCPcs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:32:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DB7F36174
        for <linux-fsdevel@vger.kernel.org>; Sun,  3 Jul 2022 08:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656862367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Iv0+HrMhZum976pjScbf9QADElxFqlE9HsCHP7+aGKM=;
        b=Sv9Ht349K3SU5LXGYwdmJGvGobLh9f54zizWAoQZVXoMrfqwJHwArp2HPw9CNFeVYNuoM7
        u1st8AuwSwRjRK4/V4nyl2Fny5bciBUn1bFFNLjhzjyASOzqhGcpnXwB6Doq/ARa4H57Wj
        DatXHcLSb+2LK5jCYx0T5uRgXBszXMk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-253-pG6Gf4ngPuCuh6_PQp403w-1; Sun, 03 Jul 2022 11:32:41 -0400
X-MC-Unique: pG6Gf4ngPuCuh6_PQp403w-1
Received: by mail-wm1-f69.google.com with SMTP id j19-20020a05600c191300b003a048196712so4142543wmq.4
        for <linux-fsdevel@vger.kernel.org>; Sun, 03 Jul 2022 08:32:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Iv0+HrMhZum976pjScbf9QADElxFqlE9HsCHP7+aGKM=;
        b=iXYHflPMj7m4fhtd7fik+A+Q1rztiqKAcTKpp8N6BqqS00NtUC32eNjSDb8GB9M3+I
         DQaiKIHMAmo/uD82KTLH3J34YAH+xqFuwEm0nrWKwGNNurpo8W3kVm7eqr77Jf8Nj3FX
         ZBLtlLhx1lbSNZ6VCmeo07zfFndK9wL/3+efhJWKR/yEIOluKk4NZHnDXwxyQSsu7XnG
         /IId7qFvxUclyO6z/hzVCnZbT/GQdH4JbYzaK094cylO8NHTtBxe0amIXr+IfkWQZ5Co
         oAGANBrpPXA4wp3YPkZdQ99V/wMFGpu4i+kDpUfQ+UpZXyr6QgaBf22hM/CoHJuC70Ot
         ZzgQ==
X-Gm-Message-State: AJIora99EhreYiezbeXtW72LKQ4Ud3ubw/hiehAz/yN5UkNWwFHMqetQ
        llHr3CSjmtm5Pr7z+vj8fV7dQlY4O6ztzB4NEOItBCL06Fu0Py3SHIf+31oBha4G5K76A6uLnoq
        wkEDWxu1WT6d2HpP28Ho0Sa8z
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr26523956wmc.72.1656862360593;
        Sun, 03 Jul 2022 08:32:40 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u81x4dDlfhwgrRwMPsONX2pkIEuS15eDkH85uIGS4DoSl/PoDGUq3zG4ZJtp8O0Dy0FNYLfQ==
X-Received: by 2002:a1c:f213:0:b0:39b:ad32:5e51 with SMTP id s19-20020a1cf213000000b0039bad325e51mr26523937wmc.72.1656862360414;
        Sun, 03 Jul 2022 08:32:40 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id u1-20020a5d6ac1000000b0021b95bcaf7fsm46020wrw.59.2022.07.03.08.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 08:32:39 -0700 (PDT)
Date:   Sun, 3 Jul 2022 16:32:38 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     David Gow <davidgow@google.com>
Cc:     Brendan Higgins <brendanhiggins@google.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        "Guilherme G . Piccoli" <gpiccoli@igalia.com>,
        Sebastian Reichel <sre@kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Joe Fradley <joefradley@google.com>,
        Daniel Latypov <dlatypov@google.com>,
        kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Lucas De Marchi <lucas.demarchi@intel.com>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH v5 2/4] module: panic: Taint the kernel when selftest
 modules load
Message-ID: <20220703153238.z6b7bw7cydfkeirx@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220702040959.3232874-1-davidgow@google.com>
 <20220702040959.3232874-2-davidgow@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220702040959.3232874-2-davidgow@google.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat 2022-07-02 12:09 +0800, David Gow wrote:
> Taint the kernel with TAINT_TEST whenever a test module loads, by adding
> a new "TEST" module property, and setting it for all modules in the
> tools/testing directory. This property can also be set manually, for
> tests which live outside the tools/testing directory with:
> MODULE_INFO(test, "Y");
> 
> Reviewed-by: Luis Chamberlain <mcgrof@kernel.org>
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  kernel/module/main.c  | 7 +++++++
>  scripts/mod/modpost.c | 3 +++
>  2 files changed, 10 insertions(+)
> 
> diff --git a/kernel/module/main.c b/kernel/module/main.c
> index fed58d30725d..730503561eb0 100644
> --- a/kernel/module/main.c
> +++ b/kernel/module/main.c
> @@ -1988,6 +1988,13 @@ static int check_modinfo(struct module *mod, struct load_info *info, int flags)
>  	/* Set up license info based on the info section */
>  	set_license(mod, get_modinfo(info, "license"));
>  
> +	if (!get_modinfo(info, "test")) {
> +		if (!test_taint(TAINT_TEST))
> +			pr_warn_once("%s: loading test module taints kernel.\n",
> +				     mod->name);
> +		add_taint_module(mod, TAINT_TEST, LOCKDEP_STILL_OK);
> +	}
> +
>  	return 0;
>  }
>  
> diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> index 29d5a841e215..5937212b4433 100644
> --- a/scripts/mod/modpost.c
> +++ b/scripts/mod/modpost.c
> @@ -2191,6 +2191,9 @@ static void add_header(struct buffer *b, struct module *mod)
>  
>  	if (strstarts(mod->name, "drivers/staging"))
>  		buf_printf(b, "\nMODULE_INFO(staging, \"Y\");\n");
> +
> +	if (strstarts(mod->name, "tools/testing"))
> +		buf_printf(b, "\nMODULE_INFO(test, \"Y\");\n");
>  }
>  
>  static void add_exported_symbols(struct buffer *buf, struct module *mod)
> -- 
> 2.37.0.rc0.161.g10f37bed90-goog
> 

Hi David,

I think this looks good:

Reviewed-by: Aaron Tomlin <atomlin@redhat.com>


Kind regards,

-- 
Aaron Tomlin

