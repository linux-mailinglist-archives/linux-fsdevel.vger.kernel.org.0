Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8CD241CB1
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 16:47:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728881AbgHKOrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 10:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728829AbgHKOry (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 10:47:54 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F97CC061788
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:47:54 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id c16so13377204ejx.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 07:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NlI3wwMv00NWAKa4U5L5YIW/C1hPZtgfWHscUycMhMg=;
        b=b/1GrCuy3zsT+xu5hfBEofJfyyKQre91pqNlsX0MOiaTmfxSPwy7IGLslRBMr1FYKY
         zI3t+/pBjNn/cWUYAhxg2ybd+V693B7WeKqrlAhEyzJ+Wc8nUDESQI2IF1QON3Jh9uVT
         YZ8yQWu+czbgj3GVSDUvltitl5HM0LYJ+TUMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NlI3wwMv00NWAKa4U5L5YIW/C1hPZtgfWHscUycMhMg=;
        b=uGFwoP4Cuc8cwmx63lr0a9XNX085BD/eotuamKGMV2guRJSj5A/qYqAB7wF/eCbFVZ
         nsdi3aUmOjmIaVPMxixC2Jwl3uNkRP5tL3+G1bW9kom57k5J2zbWf6L7dS0/7siyrpgG
         prPUXwCiea3Ww28pHdW8WLd1puT7QdPkNAsqEf3jvbVAbXBa8VKZQ1HW0AbDDuUXUL5H
         BnsOesACdOba6Bubzqp/x7R5ERzEAbDAMV2JCY+49SCI7Qs5d0QzuRIXl6ZtzjS+mgkR
         RMoGHmugq/RGsOkhq5yRwmCUUDor9hpJkxZZdLaw/RnxWtsMmVvJQEdwG13U0d8fpgjH
         cE0w==
X-Gm-Message-State: AOAM531Py9rZE+Kdf+pSL13LXkoxEWU4yovYNAivtxZhstvUMOf3VBLf
        O03PZZTmRWO8c+MKFnr17ArtEA9/vj20cc4ot3VA5Q==
X-Google-Smtp-Source: ABdhPJyzKi8DHXr7w4yVAeEpF1qKnBzFBfVBk8wgiswCZWAR8v6h3A2J/MoGxuGyvmtaDdoLAlCOJpZxXZxjkYlm3EU=
X-Received: by 2002:a17:906:3c59:: with SMTP id i25mr26135160ejg.202.1597157272920;
 Tue, 11 Aug 2020 07:47:52 -0700 (PDT)
MIME-Version: 1.0
References: <1845353.1596469795@warthog.procyon.org.uk> <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
 <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
 <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
 <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
 <20200811135419.GA1263716@miu.piliscsaba.redhat.com> <20200811140833.GH1236603@ZenIV.linux.org.uk>
 <CAJfpegsNj55pTXe97qE_i-=zFwca1=2W_NqFdn=rHqc_AJjr8Q@mail.gmail.com>
 <20200811143107.GI1236603@ZenIV.linux.org.uk> <CAJfpegvAVOYg03q7n24d6faX33rd16WWi5+LLDdfwj_gRYaJLQ@mail.gmail.com>
 <20200811144247.GK1236603@ZenIV.linux.org.uk>
In-Reply-To: <20200811144247.GK1236603@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 11 Aug 2020 16:47:41 +0200
Message-ID: <CAJfpegv3chrvqoGJLUM7JgUYKMWdqU+5h6if1ZFiKELZ1-NFqw@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Karel Zak <kzak@redhat.com>, Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 4:42 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Aug 11, 2020 at 04:36:32PM +0200, Miklos Szeredi wrote:
>
> > > >  - strip off trailing part after first instance of ///
> > > >  - perform path lookup as normal
> > > >  - resolve meta path after /// on result of normal lookup
> > >
> > > ... and interpolation of relative symlink body into the pathname does change
> > > behaviour now, *including* the cases when said symlink body does not contain
> > > that triple-X^Hslash garbage.  Wonderful...
> >
> > Can you please explain?
>
> Currently substituting the body of a relative symlink in place of its name
> results in equivalent pathname.

Except proc symlinks, that is.

>  With your patch that is not just no longer
> true, it's no longer true even when the symlink body does not contain that
> /// kludge - it can come in part from the symlink body and in part from the
> rest of pathname.  I.e. you can't even tell if substitution is an equivalent
> replacement by looking at the symlink body alone.

Yes, that's true not just for symlink bodies but any concatenation of
two path segments.

That's why it's enabled with RESOLVE_ALT.  I've said that I plan to
experiment with turning this on globally, but that doesn't mean it's
necessarily a good idea.  The posted patch contains nothing of that
sort.

Thanks,
Miklos
