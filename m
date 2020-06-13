Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 138E51F8459
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 18:48:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726445AbgFMQrz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 12:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726378AbgFMQrx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 12:47:53 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B50E8C08C5C2
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 09:47:51 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id 9so14464337ljv.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 09:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ncEwZ2YTb3mVdV4EuBbju4CI9gD1hCf0cAsyxu6rkFs=;
        b=WxQOOQExCmoR+tWyWgfXfgTncQypYk9W5MJCAxdFj3dqLPSTkGWlfMMwGUljAXEl5R
         DcdA9O4BYJiyYRfD230dt30F3t+DJyMR6NcHFmsBmpFKMj8GebV/5NgxzNY4KxeMK4CZ
         y2p86lQyIBCmazacaBh+U1MDbQQBNmr34MoVg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ncEwZ2YTb3mVdV4EuBbju4CI9gD1hCf0cAsyxu6rkFs=;
        b=Nt432grtsX+JngPYQqU1hg85X5hOV3B1QBjOsNsPAM9TNNgvLU0R7Wk/JnnC31TCLk
         9zPiMt9BsDllhL0s4HRbU3cXnKll4yLP+J2dTRzRA0T6z0EMWPitAcCJssq0OC36GMe+
         CLiqgH3nHE00tsmjZrovmFDoI+kkEM9WIwHpXvvQ2q0lCs0Qq4vk9Uokaf64NEkaEi0v
         OtLgNZm3RvU2A0ocjwpM/nwGR0z8KZSg8AX1DH+fz3m5WCRVf2VLovTnLqSHBCTt88iw
         5fu7gxcTOxBgz6q54HQ/OpHrqLHcpCJHArphm7/Ttbrz90zlgdiAiDliOe2FjjPXPUSi
         HXSA==
X-Gm-Message-State: AOAM531erPQrX6K7O84BZFg2nt2SEHdcMUw+UiQAsBHdJLiGzZsUvvE1
        n4VV5j0P6Y3Q2uHhYyRILJQmz4siEf0=
X-Google-Smtp-Source: ABdhPJw2U183pPeFUhM+NO/mtf47YVoyy8WDYgTX+2UB4VavgD5ZKOSDWo0C1mQySbfjSoeMXSS4CQ==
X-Received: by 2002:a2e:2f0a:: with SMTP id v10mr9067421ljv.163.1592066868559;
        Sat, 13 Jun 2020 09:47:48 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id g22sm1818666lfb.43.2020.06.13.09.47.46
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 09:47:47 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id i3so9937074ljg.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 09:47:46 -0700 (PDT)
X-Received: by 2002:a2e:b5d9:: with SMTP id g25mr10011919ljn.285.1592066866523;
 Sat, 13 Jun 2020 09:47:46 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com> <3984625.1592053492@warthog.procyon.org.uk>
In-Reply-To: <3984625.1592053492@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jun 2020 09:47:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
Message-ID: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
Subject: Re: [GIT PULL] General notification queue and key notifications
To:     David Howells <dhowells@redhat.com>
Cc:     Karel Zak <kzak@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>,
        dray@redhat.com, Miklos Szeredi <mszeredi@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Jeff Layton <jlayton@redhat.com>, Ian Kent <raven@themaw.net>,
        andres@anarazel.de,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
        keyrings@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jun 13, 2020 at 6:05 AM David Howells <dhowells@redhat.com> wrote:
>
> Would you be willing at this point to consider pulling the mount notifications
> and fsinfo() which helps support that?  I could whip up pull reqs for those
> two pieces - or do you want to see more concrete patches that use it?

I'd want to see more concrete use cases, but I'd also like to see that
this keyring thing gets used and doesn't find any show-stoppers when
it does.

If we have multiple uses, and one of them notices some problem that
requires any ABI changes, but the other one has already started using
it, we'll have more problems.

          Linus
