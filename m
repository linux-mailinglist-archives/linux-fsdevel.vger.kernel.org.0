Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06F3767B6AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 25 Jan 2023 17:17:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbjAYQRp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 25 Jan 2023 11:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjAYQRo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 25 Jan 2023 11:17:44 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB838A61;
        Wed, 25 Jan 2023 08:17:42 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-15f97c478a8so21892179fac.13;
        Wed, 25 Jan 2023 08:17:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=G6fehPfifrX/RPot9q+cZL35omyfpQUYf5YWxcfsJTM=;
        b=jN+V+j7z0c8rXiKWo20rYjTy+nuiCv22HCWx68ZBsucB7hx+6MaudjF/MzNsV2oXz6
         l07MJMoKR2k0tlQLBkwP8iAvVsYktri+NYl22xlCRxvfH0QKIDMkcxh2RlKiaeFsSeC0
         +gpysUgpGMzeLfcP66iatj5mJ0Vg7JGVffnjxDc205glA1Dj8UJyzTxFwlu/MYGqAbJW
         7DlOrH37t9J4NtKhurCSaHYmMyotxoh7pI234IaaXOewcNHYMVOFgIJBa84KagubsiZT
         THNPG/yxTyXbXPh7WwDR6jK0V7fPf7c9pZ32kN92rjiGB1cAEzHR2oQhGH5jeNTDFAGU
         VCog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G6fehPfifrX/RPot9q+cZL35omyfpQUYf5YWxcfsJTM=;
        b=is97E9Kq2cORukjaZ56yToTkjzU8221Q9dltBozpKepA4xVmnIcO0nKWSeCTzhTJfp
         oIHrmmWGr5vsXutGjnjh2R44dri6EVKehYTl74mmUUiClaYgHx1SNLCdW43FlOimg8bx
         jYreLBNwPFwomrJ4jrp5yCeIyY4oDQsbZWKNvI4rln5iLYEBJmGdzJSV60jqkaFIx2Ie
         uiWdwKJs+unkL7tb1F5EdvqMwsNIdYWtlZW/rf7ojLB/9sxlswDfljXzX0/FNiWK2w4U
         6ySYdJgyd5cRb0rOwEuReakPuRryQiUpFyyZPb0zvEu++1WGI4P3GKyygeI8OwxNyA88
         Qw8Q==
X-Gm-Message-State: AO0yUKWJphUrTply4sfDSFC+7GXMLmGqOpJxvRl8QnlwJHBCvs5o7sLN
        nnNPqGReiPAbdTQi/xkAzl19X+T9ms45qDNPw9gJ6VUk
X-Google-Smtp-Source: AK7set8Nw9HWqCnwUl9Dh9bx8TiuKFQo1VUtoK4VQflaGueUpuYcZ4LiyuM7wvD0WjmmnIc4n0NtKaTBjpOttqRQQ7I=
X-Received: by 2002:a05:6870:10d5:b0:163:1dac:5acb with SMTP id
 21-20020a05687010d500b001631dac5acbmr396514oar.159.1674663460908; Wed, 25 Jan
 2023 08:17:40 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a8a:ad6:0:b0:49c:e11d:f815 with HTTP; Wed, 25 Jan 2023
 08:17:40 -0800 (PST)
In-Reply-To: <CAGudoHG-42ziSNT0g8asRj8iGzx-Gn=ETZuXkswER3Daov37=A@mail.gmail.com>
References: <20230116212105.1840362-1-mjguzik@gmail.com> <20230116212105.1840362-2-mjguzik@gmail.com>
 <CAHC9VhSKEyyd-s_j=1UbA0+vOK7ggyCp6e-FNSG7XVYvCxoLnA@mail.gmail.com>
 <CAGudoHF+bg0qiq+ByVpysa9t8J=zpF8=d1CqDVS5GmOGpVM9rQ@mail.gmail.com>
 <CAHC9VhTnpWKnKRu3wFTNfub_qdcDePdEXYZWOpvpqL0fcfS_Uw@mail.gmail.com>
 <CAGudoHEWQJKMS=pL9Ate4COshgQaC-fjQ2RN3LiYmdS=0MVruA@mail.gmail.com>
 <CAHC9VhSYg-BbJvNBZd3dayYCf8bzedASoidnX23_i4iK7P-WxQ@mail.gmail.com>
 <CAHk-=wiG5wdWrx2uXRK3-i31Zp416krnu_KjmBbS3BVkiAUXLQ@mail.gmail.com>
 <CAHC9VhTg8mMHzdSPbpxvOQCWxuNuXzR7c6FJOg5+XGb-PYemRw@mail.gmail.com> <CAGudoHG-42ziSNT0g8asRj8iGzx-Gn=ETZuXkswER3Daov37=A@mail.gmail.com>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Wed, 25 Jan 2023 17:17:40 +0100
Message-ID: <CAGudoHHkeF-ozA-A+7ZcJP-Su02PwE4rfQ79VgD0zw8zS84YwA@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] vfs: avoid duplicating creds in faccessat if possible
To:     Paul Moore <paul@paul-moore.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        viro@zeniv.linux.org.uk, serge@hallyn.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-security-module@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/25/23, Mateusz Guzik <mjguzik@gmail.com> wrote:
> On 1/24/23, Paul Moore <paul@paul-moore.com> wrote:
>> Although I'm looking at this again and realized that only
>> do_faccessat() calls access_override_creds(), so why not just fold the
>> new access_need_override_creds() logic into access_override_creds()?
>> Just have one function that takes the flag value, and returns an
>> old_cred/NULL pointer (or pass old_cred to the function by reference
>> and return an error code); that should still provide the performance
>> win Mateusz is looking for while providing additional safety against
>> out-of-sync changes.  I would guess the code would be smaller too.
>>
>
> It is unclear from the description if you are arguing for moving the new
> func into access_override_creds almost as is just put prior to existing
> code *or* mixing checks with assignments.
>
> static bool *access_override_creds(struct cred **ptr)
>         [snip]
>         if (!uid_eq(cred->fsuid, cred->uid) ||
>             !gid_eq(cred->fsgid, cred->gid))
>                 return false;
>         /* remaining checks go here as well */
>         [snip]
>
>         override_cred = prepare_creds();
>         if (!override_cred) {
>                 *ptr = NULL;
>                 return true;
>         }
>
>         override_cred->fsuid = override_cred->uid;
>         override_cred->fsgid = override_cred->gid;
>         [snip]
>
> If this is what you had in mind, I note it retains all the duplication
> except in one func body which I'm confident does not buy anything,
> provided the warning comment is added.
>
> At the same time the downside is that it uglifies error handling at the
> callsite, so I would say a net loss.
>
> Alternatively, if you want to somehow keep tests aroung assignments the
> code gets super hairy.
>
> But maybe you wanted something else?
>
> As I noted in another email this already got more discussion than it
> warrants.
>
> Addition of the warning comment makes sense, but concerns after that
> don't sound legitimate to me.
>

So I posted v3 with the comment, you are CC'ed.

I'm not going to further argue about the patch. If you want to write
your own variant that's fine with me, feel free to take my bench results
and denote they come from a similar version.

There is other stuff I want to post and unslowed access() helps making
the case. The CONFIG_INIT_ON_ALLOC_DEFAULT_ON option is enabled on
Debian, Ubuntu and Arch and as a side effect it zeroes bufs allocated
every time a path lookup is performed. As these are 4096 bytes in size
it is not pretty whatsoever and I'm confident not worth the hardening
promised by mandatory zeroing. Got patches to add exemption support for
caches to sort it out without disabling the opt.

-- 
Mateusz Guzik <mjguzik gmail.com>
