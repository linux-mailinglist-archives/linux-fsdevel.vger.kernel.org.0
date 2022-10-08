Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E4A25F8463
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 10:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJHIrg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 04:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbiJHIrf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 04:47:35 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95544E28;
        Sat,  8 Oct 2022 01:47:32 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id 13so15710207ejn.3;
        Sat, 08 Oct 2022 01:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+yiSi8U2X1nNi7xA8jjitmb2681viY/WHfM+nff1N/U=;
        b=bFsPbUnI9xGdR4PjwkMQuz4htY1UW+E2WhVkt+y+gVChfhV3+Uy/pXzNCELf/HluI7
         zaeiERAAXLedio0mKXdLgDqRVWSfdPjrfAvKlvoTxkkpkMjwCfluCd0uJvotAwc6vXEk
         XfjrySdQfQla7n+5avFUAnxXR53ARaRam7RRo5dXzKo+SdH+MvUZ5SG+MLz7qQ67Rz29
         wd5loGoQL9GMgnfXAg/ud4kjzrsCSHv9WbBUUs4gyi8E6FSK1ubW03cgRwVPDqPu7bEy
         dRh+3YpTplQUOc62VjKu3PvwYR41wLtF3aS09drcAq6c/NnarTQHTWA9d95+r+zxmr5T
         84jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+yiSi8U2X1nNi7xA8jjitmb2681viY/WHfM+nff1N/U=;
        b=14qGIAXCiJOs6pJdoyLmn0JIH+2/rB1FA9krcT91BW4wkm2t39t2Bkcb6fPjNj38IW
         XFkkn+1VdaJ1FUVa1HJrSWfjRtbTKJ17365adbTXKg9Z9OOc6jF69eVOZuBCThZsMyfz
         6bEa+tJa3W+gXXzPA3Cs4VUP7vEYBNRwN1qIvtaXB0+u7KeewJ+MNyRWWwDe9zTsvzIx
         fBKuO6jLUu/kGRFLZRO/vuagmB9VvGE+jocVOEeY+uqqUMfxS6SiC6wqOxiC6BgCtP5y
         3Xt3mAkGvA10zqssF3XaGwXHjUBpFlaVSFRTWH4ggfJkci2/cLWQ0oIg7bWIVoG6yMsx
         ln2Q==
X-Gm-Message-State: ACrzQf1hXHoO8YAmUJ37KUyrl9c2ZkoOgvZer2mIUl/pMjV3ay4+kCMh
        2KrhtckpIUy4I3LYVvkJHLU=
X-Google-Smtp-Source: AMsMyM5X7VJRChA8KmTqHLRpCXhRDQA9L49cObs/Ewuw1fi9XBmTVZ2OjybISDp5R8JVWPCGhCuj7A==
X-Received: by 2002:a17:907:97d5:b0:782:23b0:ecb8 with SMTP id js21-20020a17090797d500b0078223b0ecb8mr7423959ejc.100.1665218851074;
        Sat, 08 Oct 2022 01:47:31 -0700 (PDT)
Received: from nuc ([2a02:168:633b:1:1e69:7aff:fe05:97e6])
        by smtp.gmail.com with ESMTPSA id 13-20020a170906308d00b0078c1e174e11sm2410308ejv.136.2022.10.08.01.47.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Oct 2022 01:47:30 -0700 (PDT)
Date:   Sat, 8 Oct 2022 10:47:29 +0200
From:   =?iso-8859-1?Q?G=FCnther?= Noack <gnoack3000@gmail.com>
To:     =?iso-8859-1?Q?Micka=EBl_Sala=FCn?= <mic@digikod.net>
Cc:     linux-security-module@vger.kernel.org,
        James Morris <jmorris@namei.org>,
        Paul Moore <paul@paul-moore.com>,
        "Serge E . Hallyn" <serge@hallyn.com>,
        linux-fsdevel@vger.kernel.org,
        Konstantin Meskhidze <konstantin.meskhidze@huawei.com>
Subject: Re: [PATCH v8 8/9] samples/landlock: Extend sample tool to support
 LANDLOCK_ACCESS_FS_TRUNCATE
Message-ID: <Y0E5IUoAR9Lq5SB5@nuc>
References: <20221001154908.49665-1-gnoack3000@gmail.com>
 <20221001154908.49665-9-gnoack3000@gmail.com>
 <8c5b8019-f945-417f-3f98-ef5c9317b52d@digikod.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8c5b8019-f945-417f-3f98-ef5c9317b52d@digikod.net>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Oct 05, 2022 at 08:57:23PM +0200, Mickaël Salaün wrote:
> 
> On 01/10/2022 17:49, Günther Noack wrote:
> > Update the sandboxer sample to restrict truncate actions. This is
> > automatically enabled by default if the running kernel supports
> > LANDLOCK_ACCESS_FS_TRUNCATE, except for the paths listed in the
> > LL_FS_RW environment variable.
> > 
> > Signed-off-by: Günther Noack <gnoack3000@gmail.com>
> > ---
> >   samples/landlock/sandboxer.c | 23 ++++++++++++++---------
> >   1 file changed, 14 insertions(+), 9 deletions(-)
> > 
> > diff --git a/samples/landlock/sandboxer.c b/samples/landlock/sandboxer.c
> > index 3e404e51ec64..771b6b10d519 100644
> > --- a/samples/landlock/sandboxer.c
> > +++ b/samples/landlock/sandboxer.c
> > @@ -76,7 +76,8 @@ static int parse_path(char *env_path, const char ***const path_list)
> >   #define ACCESS_FILE ( \
> >   	LANDLOCK_ACCESS_FS_EXECUTE | \
> >   	LANDLOCK_ACCESS_FS_WRITE_FILE | \
> > -	LANDLOCK_ACCESS_FS_READ_FILE)
> > +	LANDLOCK_ACCESS_FS_READ_FILE | \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> >   /* clang-format on */
> > @@ -160,10 +161,8 @@ static int populate_ruleset(const char *const env_var, const int ruleset_fd,
> >   	LANDLOCK_ACCESS_FS_MAKE_FIFO | \
> >   	LANDLOCK_ACCESS_FS_MAKE_BLOCK | \
> >   	LANDLOCK_ACCESS_FS_MAKE_SYM | \
> > -	LANDLOCK_ACCESS_FS_REFER)
> > -
> > -#define ACCESS_ABI_2 ( \
> > -	LANDLOCK_ACCESS_FS_REFER)
> > +	LANDLOCK_ACCESS_FS_REFER | \
> > +	LANDLOCK_ACCESS_FS_TRUNCATE)
> >   /* clang-format on */
> > @@ -226,11 +225,17 @@ int main(const int argc, char *const argv[], char *const *const envp)
> >   		return 1;
> >   	}
> >   	/* Best-effort security. */
> > -	if (abi < 2) {
> > -		ruleset_attr.handled_access_fs &= ~ACCESS_ABI_2;
> > -		access_fs_ro &= ~ACCESS_ABI_2;
> > -		access_fs_rw &= ~ACCESS_ABI_2;
> 
> You can now base your patches on the current Linus' master branch, these
> three commits are now merged:
> https://git.kernel.org/mic/c/2fff00c81d4c37a037cf704d2d219fbcb45aea3c

Thanks, rebased.

> The (inlined) documentation also needs to be updated according to this
> commit to align with the double backtick convention.

There were no occurrences of the double backtick in the sample tool, I
assume this is OK?

> > +	switch (abi) {
> > +	case 1:
> > +		/* Removes LANDLOCK_ACCESS_FS_REFER for ABI < 2 */
> > +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_REFER;
> > +		__attribute__((fallthrough));
> > +	case 2:
> > +		/* Removes LANDLOCK_ACCESS_FS_TRUNCATE for ABI < 3 */
> > +		ruleset_attr.handled_access_fs &= ~LANDLOCK_ACCESS_FS_TRUNCATE;
> >   	}
> > +	access_fs_ro &= ruleset_attr.handled_access_fs;
> > +	access_fs_rw &= ruleset_attr.handled_access_fs;
> >   	ruleset_fd =
> >   		landlock_create_ruleset(&ruleset_attr, sizeof(ruleset_attr), 0);

-- 
