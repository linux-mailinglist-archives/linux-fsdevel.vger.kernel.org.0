Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7632149031E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 08:47:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237674AbiAQHr2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 02:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235240AbiAQHr2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 02:47:28 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F00FC061574
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:27 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c71so61861789edf.6
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KxaKd126ds9B/hqHoJr3I0DdwvzQ+yakIqTbnoGSuO8=;
        b=RGXdV4HyYc3xaX2rdnh+hAKPvPMFKV81qHTYLnM9kE6m4ww5iFzzJhvkM+GlTCXgm4
         ZokwaT+e53zJt/1DXVTyJxkad79H3Eh05BUmTyYG8YMTO182roVXLBbdNIAzvTxe8TWX
         8mdvIHdvuFPgQbda+EO/U/kRqlj5jS7Vae7u4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KxaKd126ds9B/hqHoJr3I0DdwvzQ+yakIqTbnoGSuO8=;
        b=rZ9NogJcjl41yLTT0pPSPvIoipAMssp2JcaM+x4RDkA4idDGY7VhPf7wKn4QJhOb9f
         16CfGTf59/nzF/3uMyIigDzzRagwqNrXTpKmojgcfgc3wLSKfnbRLnv3K8VYLEZHCpOh
         Do3oZiCQMSX1R4Uxkf2TmHNvEQGX0S9vS9gOxy6Loua6tsLP9aXmb+xGjd8/o7x1TM84
         w4waytirUpvt82irWmNWx8pRnJJdTAFIg25ncsVp9yVAGps7cYLzFBApxW7UQH9HrYfl
         /FEeAtBmMXUPNNPYWGN+Lx3Z+GJZs2iYX8ZdNjWbs6YRI2nGLDgUbl7ms601R29YI5ih
         57Qw==
X-Gm-Message-State: AOAM531aMoLtVLMHiPPkNXaFkhiUnPFUU1lakAn4rckONo3EB76SDOl4
        UL89Tq45tV4fE8JZSGiW+tAx3FkCsoVRdXb5
X-Google-Smtp-Source: ABdhPJw3NH4m+7O8UxlR5VubBu3jzMkBSjS7rgb1xTgQByXSFirudrtKrrjfU06gULdnNS6ml64tuw==
X-Received: by 2002:a05:6402:c12:: with SMTP id co18mr10709560edb.246.1642405646073;
        Sun, 16 Jan 2022 23:47:26 -0800 (PST)
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com. [209.85.128.43])
        by smtp.gmail.com with ESMTPSA id r3sm4149516ejr.79.2022.01.16.23.47.24
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 23:47:24 -0800 (PST)
Received: by mail-wm1-f43.google.com with SMTP id ay4-20020a05600c1e0400b0034a81a94607so19684932wmb.1
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 23:47:24 -0800 (PST)
X-Received: by 2002:a05:6000:1787:: with SMTP id e7mr4294373wrg.281.1642405644098;
 Sun, 16 Jan 2022 23:47:24 -0800 (PST)
MIME-Version: 1.0
References: <163935794678.22433.16837658353666486857@noble.neil.brown.name>
 <20211213125906.ngqbjsywxwibvcuq@wittgenstein> <YbexPXpuI8RdOb8q@technoir>
 <20211214101207.6yyp7x7hj2nmrmvi@wittgenstein> <Ybik5dWF2w06JQM6@technoir>
 <20211214141824.fvmtwvp57pqg7ost@wittgenstein> <164237084692.24166.3761469608708322913@noble.neil.brown.name>
In-Reply-To: <164237084692.24166.3761469608708322913@noble.neil.brown.name>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 09:47:08 +0200
X-Gmail-Original-Message-ID: <CAHk-=wiLi2_JJ1+VnhZ3aWr_cag7rVxbhpf6zKVrOuRHMsfQ4Q@mail.gmail.com>
Message-ID: <CAHk-=wiLi2_JJ1+VnhZ3aWr_cag7rVxbhpf6zKVrOuRHMsfQ4Q@mail.gmail.com>
Subject: Re: [PATCH - resend] devtmpfs regression fix: reconfigure on each mount
To:     NeilBrown <neilb@suse.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Anthony Iliopoulos <ailiop@suse.com>,
        David Howells <dhowells@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 17, 2022 at 12:07 AM NeilBrown <neilb@suse.de> wrote:
>
> Since that was changed, the mount options used for devtmpfs are ignored.
> This is a regression which affect systemd - which mounts devtmpfs
> with "-o mode=755,size=4m,nr_inodes=1m".

Hmm, I've applied this, but I'd have loved to see what the actual
symptoms of the problem were. Particularly since it's apparently been
broken for 18 months with this being the first I hear of it.

Yes, yes, I could (and did) search for this on the mailing lists, and
found the discussion and more information, but I think that info
should have been in the commit message rather than me having to go
look for it just to see the clarifications..

                Linus
