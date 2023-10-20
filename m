Return-Path: <linux-fsdevel+bounces-845-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 445B17D14D2
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 19:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DBC8B281F40
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F15FD2030F;
	Fri, 20 Oct 2023 17:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dRV6fBr7"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC6D20302
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 17:24:21 +0000 (UTC)
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8083BD6E
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:24:17 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-9adb9fa7200so233564866b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:24:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697822656; x=1698427456; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EdhkfPsGi9gy/YeBNgsDbPiV4gQ/kZVT9dE/yOFv4Jk=;
        b=dRV6fBr7qaM9ZRb+nSrwxEMoad+qE9kk1IWtQSGVH1vDatvVD8w1F0BFCYh65KOl82
         JHSDXQWRrrlu0qX5Y7EpcoLaTKUTKYMaUXuvteArPHrjKJ0L5tzia8vm54r3FEK+5VuC
         w/nk3quiypHUlJsSGchaTS/KOtKz9V9HwCNd0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822656; x=1698427456;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EdhkfPsGi9gy/YeBNgsDbPiV4gQ/kZVT9dE/yOFv4Jk=;
        b=JhgH5P0KobrbCxcXB8oVktVMXZ1V9jgDuq8GIqDvk+tJsEkPSV/nwB4JYJMufEGhnm
         yWWjPzFdEVF43sS+FjdN0BTG+YGNmAxnYUZLJXHuyKeSHx/6UHqlCrYt/6zbzZdM1BTa
         hqjsAQuzBpVpLRRtJXxRhZXlQJIthGHqzCoO3SnY1vs2gdrEPIVwmVojyOQuAGcZHTf+
         Lj85uKmiWIndYHY66yPl49cshLVNl4+lwFFniyzxMnQI522+p8M23lGAESLLRH51hNwX
         f1KGkvz3IHBSCtD64k2AMsd25SEastGj7yGEQtp02Bibkfdgh6dHKl3PwpjsT8lnS3JT
         qSZg==
X-Gm-Message-State: AOJu0YwPYSWwsaf3ngSuDhTvbvFFBgq/qdbaYRWw0Hc9zbEia7kCxIt6
	/lNmaCtDsGAwYyQOVFfMzJFghAaUGxYPXJxrM9dzS2R4
X-Google-Smtp-Source: AGHT+IEdNYcuygwMYxPk0NEJ703fSWpBh7nNNEqC6IqA+VfqAReS3CnfhVSHHIaGsoFqKtSyuIw3dA==
X-Received: by 2002:a17:907:2d90:b0:9c7:5186:de2a with SMTP id gt16-20020a1709072d9000b009c75186de2amr4981954ejc.6.1697822655713;
        Fri, 20 Oct 2023 10:24:15 -0700 (PDT)
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com. [209.85.218.51])
        by smtp.gmail.com with ESMTPSA id gy5-20020a0564025bc500b0053d9cb67248sm1777342edb.18.2023.10.20.10.24.15
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:24:15 -0700 (PDT)
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9c3aec5f326so464993266b.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:24:15 -0700 (PDT)
X-Received: by 2002:a17:906:7308:b0:9a2:295a:9bbc with SMTP id
 di8-20020a170906730800b009a2295a9bbcmr1923815ejc.37.1697822654738; Fri, 20
 Oct 2023 10:24:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231019101854.yb5gurasxgbdtui5@quack3> <ZTEap8A1W3IIY7Bg@smile.fi.intel.com>
 <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com> <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
In-Reply-To: <ZTKUDzONVHXnWAJc@smile.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 10:23:57 -0700
X-Gmail-Original-Message-ID: <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Message-ID: <CAHk-=wipA4605yvnmjW7T9EvARPRCGLARty8UUzRGxic1SXqvg@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To: Andy Shevchenko <andriy.shevchenko@intel.com>, Baokun Li <libaokun1@huawei.com>
Cc: Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 07:52, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> # first bad commit: [e64db1c50eb5d3be2187b56d32ec39e56b739845] quota: factor out dquot_write_dquot()

Ok, so commit 024128477809 ("quota: factor out dquot_write_dquot()") pre-rebase.

Which honestly seems entirely innocuous, and the only change seems to
be a slight massaging of the return value checking, in that it did a
"if (err)" ine one place before, now it does "if (err < 0)".

And the whole "now it always warns about errors", which used to happen
only in dqput() before.

Neither seems to be very relevant, which just reinforces that yes,
this looks like a timing thing.

> On top of the above I have tried the following:
> 1) dropping inline, replacing it to __always_inline -- no help;
> 2) commenting out the error message -- helps!
>
> --- a/fs/quota/dquot.c
> +++ b/fs/quota/dquot.c
> @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
>  {
>         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
>         if (ret < 0) {
> +#if 0
>                 quota_error(dquot->dq_sb, "Can't write quota structure "
>                             "(error %d). Quota may get out of sync!", ret);
> +#endif
>                 /* Clear dirty bit anyway to avoid infinite loop. */
>                 clear_dquot_dirty(dquot);
>         }

The only thing quota_error() does is the varags handling and a printk,
so yeah, all that #if 0" would do even if the error triggers (and it
presumably doesn't) is to change code generation around that point,
and change timing.

But what *is* interesting is that that commit that triggers it is
before all the other list-handling changes, so the fact that this was
triggered by that merge and that one commit, *all* that really
happened to trigger your boot failure is literally this:

   git log 1500e7e0726e^..024128477809

(that "1500e7e0726e^" is the pre-merge state). So it's not that the
problem was introduced by one of the other list-handling changes and
then 024128477809 just happened to change the timing. No, it's
literally that one commit that moves code around, and that one
quota_error() printout that makes the problem show for you.

So it really looks like the bug is pre-existing. Or actually a
compiler problem that is introduced by the added call that changes
code generation, but honestly, that is a very unlikely thing.

That said - while unlikely, mind just sending me the *failing* copy of
the fs/quota/dquot.o object file, and I'll take a look at the code
around that call. I've looked at enough code generation issues that
it's worth trying..

                 Linus

