Return-Path: <linux-fsdevel+bounces-846-lists+linux-fsdevel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F367D14D9
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 19:26:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD69A1C20FBE
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 Oct 2023 17:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1369120312;
	Fri, 20 Oct 2023 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="eB2dZqUP"
X-Original-To: linux-fsdevel@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CF101DA43
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 17:26:48 +0000 (UTC)
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B811D7A
	for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:26:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-9be02fcf268so163343166b.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1697822805; x=1698427605; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hFd/PeJUrCqAUlQIC7OhOkLtSLgI8B2z7y+zqnxlUNQ=;
        b=eB2dZqUPQ9v4yToflXPaXZPk0YAI60nb98j7RvFY893P/OSuRehkBmF5wl0SSS5BY7
         vS9Zix0BU5ZCKLivGaoZ1Jc38KBSYzZK5ZbnP5lQvFtk+2dps3xXcc/p8EwjCREvT2wa
         JjrygDBcHUGcrNbMCFT/TCVaBqtWC0P9tyIVw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697822805; x=1698427605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hFd/PeJUrCqAUlQIC7OhOkLtSLgI8B2z7y+zqnxlUNQ=;
        b=dfHxMHDtv+He5VHYOv9JOclsV3R7pHzJgpHC/Hrt+V8jt9dE6lTyNahBO9ldwcbJRl
         hNBq1XL/JxhoqLJ2T//184OePiIioJBEXonslAxz6oNAeLhjrDvofdOepcA30b9u9DUX
         1Kp1GlVZbPJGRC6D2PB5MpwDg61jfIx3mujzI5ucsZYD8ArL6R7DEXCXX3DSZsmXBQUr
         8XZ88a9u3EG2loJWKofbV2VeDhmZMq8VbONdl8Rf5c5YoHe+LJ0o798Mwu+X/9/TV86F
         t57Bwx+qjCF9vUuan4yIw1MQWiZvVd8z54fKf7gG3Ov7iX1qJY807iRQkC8AXB2Bzn3a
         TdLg==
X-Gm-Message-State: AOJu0Yx61KQEtLS0bA/l24n/ZcXjnOx3K9L2UIX1QBmNpSgD5c0XC+FO
	oTQrGW3GXCRmn33iqOUJYdvm3lWBb/N/wPDjfojztpYk
X-Google-Smtp-Source: AGHT+IH2BJcFM9/3LmZg+JF0HcvLX9Yq7Udm0+APMjO1jZ2GwyzMjJtRR2cQs5nx6LymK6s3uk5mcw==
X-Received: by 2002:a17:906:4fca:b0:9b2:cf77:a105 with SMTP id i10-20020a1709064fca00b009b2cf77a105mr2096681ejw.15.1697822805416;
        Fri, 20 Oct 2023 10:26:45 -0700 (PDT)
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com. [209.85.218.50])
        by smtp.gmail.com with ESMTPSA id m19-20020a1709066d1300b0099bd453357esm1856128ejr.41.2023.10.20.10.26.43
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Oct 2023 10:26:43 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-9b1ebc80d0aso166820266b.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 20 Oct 2023 10:26:43 -0700 (PDT)
X-Received: by 2002:a17:906:fe06:b0:9bf:1477:ad82 with SMTP id
 wy6-20020a170906fe0600b009bf1477ad82mr2068018ejb.76.1697822803062; Fri, 20
 Oct 2023 10:26:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-fsdevel@vger.kernel.org
List-Id: <linux-fsdevel.vger.kernel.org>
List-Subscribe: <mailto:linux-fsdevel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-fsdevel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZTFAzuE58mkFbScV@smile.fi.intel.com> <20231019164240.lhg5jotsh6vfuy67@treble>
 <ZTFh0NeYtvgcjSv8@smile.fi.intel.com> <CAHk-=wjXG52UNKCwwEU1A+QWHYfvKOieV0uFOpPkLR0NSvOjtg@mail.gmail.com>
 <CAHk-=whis2BJF2fv1xySAg2NTQ+C5fViNSGkLNCOqGzi-3y+8w@mail.gmail.com>
 <ZTFxEcjo4d6vXbo5@smile.fi.intel.com> <ZTFydEbdEYlxOxc1@smile.fi.intel.com>
 <CAHk-=wh_gbZE_ZsQ6+9gSPdXfoCtmuK-MFmBkO3ywMKFQEvb6g@mail.gmail.com>
 <ZTKUDzONVHXnWAJc@smile.fi.intel.com> <ZTKXbbSS2Pvmc-Fh@smile.fi.intel.com> <ZTKY6nRGWoYsEJjj@smile.fi.intel.com>
In-Reply-To: <ZTKY6nRGWoYsEJjj@smile.fi.intel.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 20 Oct 2023 10:26:26 -0700
X-Gmail-Original-Message-ID: <CAHk-=whzn2AVM6iSfy64h8TPjL6DtirO-YKW9o8afEw1s9nbjw@mail.gmail.com>
Message-ID: <CAHk-=whzn2AVM6iSfy64h8TPjL6DtirO-YKW9o8afEw1s9nbjw@mail.gmail.com>
Subject: Re: [GIT PULL] ext2, quota, and udf fixes for 6.6-rc1
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Baokun Li <libaokun1@huawei.com>, Josh Poimboeuf <jpoimboe@kernel.org>, Jan Kara <jack@suse.cz>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, 
	Kees Cook <keescook@chromium.org>, Ferry Toth <ftoth@exalondelft.nl>, 
	linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 20 Oct 2023 at 08:12, Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:
>
> > > --- a/fs/quota/dquot.c
> > > +++ b/fs/quota/dquot.c
> > > @@ -632,8 +632,10 @@ static inline int dquot_write_dquot(struct dquot *dquot)
> > >  {
> > >         int ret = dquot->dq_sb->dq_op->write_dquot(dquot);
> > >         if (ret < 0) {
> > > +#if 0
> > >                 quota_error(dquot->dq_sb, "Can't write quota structure "
> > >                             "(error %d). Quota may get out of sync!", ret);
> > > +#endif
> > >                 /* Clear dirty bit anyway to avoid infinite loop. */
> > >                 clear_dquot_dirty(dquot);
> > >         }
>
> Doing the same on the my branch based on top of v6.6-rc6 does not help.
> So looks like a race condition somewhere happening related to that dirty bit
> (as comment states it needs to be cleaned to avoid infinite loop, that's
>  probably what happens).

Hmm. Normally, dirty bits should always be cleared *before* the
write-back, not after it. Otherwise you might lose a dirty event that
happened *during* writeback.

But I don't know the quota code.

... the fact that the #if 0 doesn't help in another case does say that
it's not the quota_error() call itself. Which it really couldn't have
been (apart from timing and compiler bugs), but it's still a data
point, I guess.

               Linus

