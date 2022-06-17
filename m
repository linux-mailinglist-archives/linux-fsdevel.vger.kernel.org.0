Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF29854FA43
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jun 2022 17:28:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382870AbiFQP2h (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 17 Jun 2022 11:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382875AbiFQP2b (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 17 Jun 2022 11:28:31 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD48137BEC
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 08:28:29 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id ej4so2688659edb.7
        for <linux-fsdevel@vger.kernel.org>; Fri, 17 Jun 2022 08:28:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dneg.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WPVSEvTCvflFVWW5j2J0ixJtMAaP9wSf1jUduymLlc0=;
        b=v7RXMWZyuWDlLd2v5s/ooA/1Btk4V0x78HXw7Xm7i33Wi4KPyENUDcJieRtSDHdqXF
         y0CguHXlfnWbXj9NHraQ6rewV/+kAKdVxVFcsWohBz4cMSu/XJIxbWcQgFbjOEonH3m9
         x0hV49Il2On30MIL5DdT4BGZWralIS3PVPDN2i9lIVxw1wD8EcFvpyfh6Cl/cm6vZzJ6
         PL9+Opn3M4m129911zb6XlvplLpltIWORVUm8OXUH2JZIdv6k51S4jV3FKqR0udjmP8z
         EUCtnQ5UquCW9dfEm1dEWgXhrSK9gx16akUcJ0URmOTwbS6E87UTFqfUUq9H3KW4bcKl
         wXPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WPVSEvTCvflFVWW5j2J0ixJtMAaP9wSf1jUduymLlc0=;
        b=V+sq6sLPh9u8Ghr1vrZwgXk+rSQiLs+pLmSIaA+ejuCSqlDzuakrDSpuJeVKZiYLMX
         8PemaWRmtvm7fsKVQUFrZPOPnOFELeQ/5ghdnQVrntqCL6ZxbeLjmn4kwDkMsvPx6PS5
         fMbTWxl9VTGPhvYDqdmNqL+8fBXeJSlKicxtWSLwgIArpLLdD7Y6unPw8eRENYELja2s
         kjfRdDPGcfl5Y8VNVNs5ig1r37FQaO3cUD58gKaSpWg9vU64rxKxtUYDdcuh3QLB7h86
         UYhQjEsmhuwA2k9mreGxAcreMPFtPB2iHNxE+0bYVFRHHjYtYoxvTci/GPcsjDHJr12m
         ytBg==
X-Gm-Message-State: AJIora9pifyUDNrw5qCqrmr+055ZsKZ+Zrwnvrq+5Je/iJoLFUNMCny7
        4Wl2f2o7t7OICDcqr8LMHRUVMXNqLRTxMwIjaNP58A==
X-Google-Smtp-Source: AGRyM1vEi6r6fYhd5rEyG/Oo+64RdkJiqOkUizhd0wgddNSc0WlzPxLW8/Jzu4daDxPaJij9IyK5BeX6kcGkf4WPg5E=
X-Received: by 2002:aa7:cf01:0:b0:435:5ace:69cc with SMTP id
 a1-20020aa7cf01000000b004355ace69ccmr6151037edy.251.1655479708477; Fri, 17
 Jun 2022 08:28:28 -0700 (PDT)
MIME-Version: 1.0
References: <165516173293.21248.14587048046993234326.stgit@noble.brown>
 <CAPt2mGNjWXad6e7nSUTu=0ez1qU1wBNegrntgHKm5hOeBs5gQA@mail.gmail.com>
 <165534094600.26404.4349155093299535793@noble.neil.brown.name>
 <CAPt2mGOw_PS-5KY-9WFzGOT=ax6PFhVYSTQG-dpXzV5MeGieYg@mail.gmail.com> <165544498126.26404.7712330810213588882@noble.neil.brown.name>
In-Reply-To: <165544498126.26404.7712330810213588882@noble.neil.brown.name>
From:   Daire Byrne <daire@dneg.com>
Date:   Fri, 17 Jun 2022 16:27:52 +0100
Message-ID: <CAPt2mGNJYJ=pTmRRseJdeyvTDw9am6uNUaiZysDvU2bNcNJLQw@mail.gmail.com>
Subject: Re: [PATCH RFC 00/12] Allow concurrent directory updates.
To:     NeilBrown <neilb@suse.de>
Cc:     Anna Schumaker <schumaker.anna@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 17 Jun 2022 at 06:49, NeilBrown <neilb@suse.de> wrote:
>
> On Thu, 16 Jun 2022, Daire Byrne wrote:
> >
> > I double checked that the patch had been applied and I hadn't made a
> > mistake with installation.
>
> :-) always worth double checking...
>
> >
> > I could perhaps try running with just the VFS patches to see if I can
> > still reproduce the "local" VFS hang without the nfsd patches? Your
> > previous VFS only patchset was stable for me.
>
> I've made quite a few changes since that VFS-only patches.  Almost
> certainly the problem is not in the nfsd code.
>
> I think that following has a reasonable chance of making things better,
> both for the problem you hit and the problem Anna hit.  I haven't tested
> it at all yet so no promises - up to you if you try it.
>
> Thanks to both of you for the help with testing.
>
> NeilBrown

This patch does the job for me - no more stack traces and things have
been stable all day. I'm going to run some production loads over the
weekend and then I'll do some more artificial scale testing next week.

Thanks again for this work! Improving the parallelism anywhere we can
for single clients and then nfsd is great for reexport servers
(especially once you add some "cloud" latency).

Cheers,

Daire
