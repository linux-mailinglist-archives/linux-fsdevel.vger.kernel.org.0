Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C48B56AA7CE
	for <lists+linux-fsdevel@lfdr.de>; Sat,  4 Mar 2023 04:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjCDDZI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 3 Mar 2023 22:25:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjCDDZG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 3 Mar 2023 22:25:06 -0500
Received: from mail-oa1-x32.google.com (mail-oa1-x32.google.com [IPv6:2001:4860:4864:20::32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13661B3;
        Fri,  3 Mar 2023 19:25:05 -0800 (PST)
Received: by mail-oa1-x32.google.com with SMTP id 586e51a60fabf-17638494edbso5289748fac.10;
        Fri, 03 Mar 2023 19:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677900304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=De/kLTneLvXzHEBgIWucE5xB8O5Vnx+8IbmgurjxawA=;
        b=ho0gXEYddhN3jlxiuXsuDnbe8PQRJ7cQsQ+yR6KrhafvX/gUF7qG9OCwlOd0WXQUsv
         Z0bwBCX65uzpm3XYibQOZ1Mn3Ma+1bN8Ipp3G8EDpNC3EapFvXcyaQix9jnu50RTwAg+
         v700TuO7vs2ibQlTLhG95BEk/sH1zx/hWm1GmSoAMQFT3bAsPp+QjbrcNrhpGmNsVT5m
         FEq/xE2H22a5HvfpxHOlfYCt5Mnavig9sM3mE3TYPzkezNMfOEkUYh9dNck4TubTMjer
         n2/zgZ3YHEb42vY8c+dpvObmmH5MHBt7ZcB2GdfKf50Uq8lBKFkW3pUCWCMeacxHHBNa
         cMSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677900304;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=De/kLTneLvXzHEBgIWucE5xB8O5Vnx+8IbmgurjxawA=;
        b=G2LhOc9phkPT3IRK/kSuEvRiUWAZGBMiw7lST7FZA0A8gkBJEKRPPy/lI6yMMlXMDs
         /VXaOkPrjNZAeUWAWlDoixxae7IexwSSz35Ts+PfvuAOgmt1gF2TAH8Azivd5xwgjDzv
         H/nICerIDBVvkHcb/6mQP8j5P6UxeHT4jkW/4otICLki4RGc0Glo1otqZ6ml78ifsH/J
         x4ElfqivQCu1DO6XaNRmWPHA3tNOFXOIDemp9NbbiIJBJXjWL3v8YXgnV/+Xm7Ft16+8
         kLN8X575MIP6J+r/atRGPSq/qT7n4cwFHDCpVp30Nvth2TS3UCKMQwdIIJ6gshBhjr+o
         tYrw==
X-Gm-Message-State: AO0yUKW+jUKj9yq7n6IOEDjfEUgQJEwy2zjY+CGFiesbiH7+ifkZiraL
        teVLA9Tprj6qlfpfR5AWAcU=
X-Google-Smtp-Source: AK7set/m3K3+OJ063AciflXFmtktgX0pn9hwBEuJky8opjHMbWqPjzFwtIg9Cr21j2BN0+YvF6/SEg==
X-Received: by 2002:a05:6870:a44b:b0:176:4b04:522e with SMTP id n11-20020a056870a44b00b001764b04522emr2436468oal.35.1677900304467;
        Fri, 03 Mar 2023 19:25:04 -0800 (PST)
Received: from localhost ([50.208.89.9])
        by smtp.gmail.com with ESMTPSA id z6-20020a05687042c600b00172289de1besm1733133oah.18.2023.03.03.19.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Mar 2023 19:25:03 -0800 (PST)
Date:   Fri, 3 Mar 2023 19:25:02 -0800
From:   Yury Norov <yury.norov@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mateusz Guzik <mjguzik@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        Eric Biggers <ebiggers@google.com>,
        Christian Brauner <brauner@kernel.org>, serge@hallyn.com,
        paul@paul-moore.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-security-module@vger.kernel.org
Subject: Re: [PATCH v3 2/2] vfs: avoid duplicating creds in faccessat if
 possible
Message-ID: <ZAK6Duaf4mlgpZPP@yury-laptop>
References: <ZAD21ZEiB2V9Ttto@ZenIV>
 <6400fedb.170a0220.ece29.04b8@mx.google.com>
 <ZAEC3LN6oUe6BKSN@ZenIV>
 <CAG_fn=UQEuvJ9WXou_sW3moHcVQZJ9NvJ5McNcsYE8xw_WEYGw@mail.gmail.com>
 <CAGudoHFqNdXDJM2uCQ9m7LzP0pAx=iVj1WBnKc4k9Ky1Xf5XmQ@mail.gmail.com>
 <CAHk-=wh-eTh=4g28Ec5W4pHNTaCSZWJdxVj4BH2sNE2hAA+cww@mail.gmail.com>
 <CAGudoHG+anGcO1XePmLjb+Hatr4VQMiZ2FufXs8hT3JrHyGMAw@mail.gmail.com>
 <CAHk-=wjy_q9t4APgug9q-EBMRKAybXt9DQbyM9Egsh=F+0k2Mg@mail.gmail.com>
 <CAGudoHGYaWTCnL4GOR+4Lbcfg5qrdOtNjestGZOkgtUaTwdGrQ@mail.gmail.com>
 <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgfNrMFQCFWFtn+UXjAdJAGAAFFJZ1JpEomTneza32A6g@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

[...]

> In particular, 'cpumask_clear()' should just zero the cpumask, and on
> the config I use, I have
> 
>     CONFIG_NR_CPUS=64
> 
> so it should literally just be a single "store zero to cpumask word".
> And that's what it used to be.
> 
> But then we had commit aa47a7c215e7 ("lib/cpumask: deprecate
> nr_cpumask_bits") and suddenly 'nr_cpumask_bits' isn't a simple
> constant any more for the "small mask that fits on stack" case, and
> instead you end up with code like
> 
>         movl    nr_cpu_ids(%rip), %edx
>         addq    $63, %rdx
>         shrq    $3, %rdx
>         andl    $-8, %edx
>         ..
>         callq   memset@PLT
> 
> that does a 8-byte memset because I have 32 cores and 64 threads.

Did you enable CONFIG_FORCE_NR_CPUS? If you pick it, the kernel will
bind nr_cpu_ids to NR_CPUS at compile time, and the memset() call
should disappear.

Depending on your compiler you might want to apply this patch as well:

https://lore.kernel.org/lkml/20221027043810.350460-2-yury.norov@gmail.com/

> Now, at least some distro kernels seem to be built with CONFIG_MAXSMP,
> so CONFIG_NR_CPUS is something insane (namely 8192), and then it is
> indeed better to calculate some minimum size instead of doing a 1kB
> memset().

Ubuntu too. That was one of the reasons for the patch.

Thanks,
Yury
