Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C83CF2421E5
	for <lists+linux-fsdevel@lfdr.de>; Tue, 11 Aug 2020 23:24:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgHKVYK (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 11 Aug 2020 17:24:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725987AbgHKVYK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:24:10 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F09C06174A
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:09 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id o18so14666636eje.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rA8YRs7dGB/GfkhZuYULS9uPbpqUgOSLUWngUo8yoaM=;
        b=B37Vu6gJyZiMc+9rfRlkcU20N9U10pvTExHnPuibbYthtQqVMegykJE7HYcY2zldNY
         5gxGBXFItNBRH8z/eG/knEXfMsho/PZusS91v/AIuz6EknTOjHM1WbX1WJwE9Kjez0Pq
         BW2ud3bdkqnIsddUMftapP9Lsi2ETAl3njB+s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rA8YRs7dGB/GfkhZuYULS9uPbpqUgOSLUWngUo8yoaM=;
        b=fSnVmUs6j++2DtS6UM06+Agb8iQ4PFgOXgxYcUpUlMZcFRM6gTBQsFU0iM60e7zwf/
         pC3RXJhoGtv9LxqQq5l3tzSGnAGjwakRM8J1MZtvolhuwvoHB60MhL6JVfHbH1WmrWgI
         j7bXk90zp1YwayDQ5uzESD1x/13xW3cnm9LQP4RWcDAPl1P6ENgd78cw5ikeFh+8Ft5L
         aLOuO9XA80irtZXSsDALs8jgcNJioT1fpiVdMFE4y2eWwxmp/rfNuhWG9oOfGLP235Ln
         hcavgnlQGUDmavdIlsw8lb+c0CiffwdFPkJM4XftkLmo/cKGbKz0wvfbuMu70dYRORzp
         wLLQ==
X-Gm-Message-State: AOAM533gOd6eLQWMKbnd9jdJIAYOh0U6KLJTFKeDMm2Acy9NLyTM0jiI
        Lfvs8+dbRoz6E2FnaaC22SyF+TsBFTU=
X-Google-Smtp-Source: ABdhPJxEnDGOyvm3dUiTNZr5jOIQTOribrm0i9VrXaAb+fra02qdorlgZGvE8vDihqF79Fqxu+AI7Q==
X-Received: by 2002:a17:907:204e:: with SMTP id pg14mr3301517ejb.324.1597181047552;
        Tue, 11 Aug 2020 14:24:07 -0700 (PDT)
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com. [209.85.218.44])
        by smtp.gmail.com with ESMTPSA id gh24sm128786ejb.45.2020.08.11.14.24.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Aug 2020 14:24:07 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id f24so14680374ejx.6
        for <linux-fsdevel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:07 -0700 (PDT)
X-Received: by 2002:a2e:545:: with SMTP id 66mr3970905ljf.285.1597180737731;
 Tue, 11 Aug 2020 14:18:57 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
 <5C8E0FA8-274E-4B56-9B5A-88E768D01F3A@amacapital.net> <a6cd01ed-918a-0ed7-aa87-0585db7b6852@schaufler-ca.com>
 <CAJfpegvUBpb+C2Ab=CLAwWffOaeCedr-b7ZZKZnKvF4ph1nJrw@mail.gmail.com>
 <CAG48ez3Li+HjJ6-wJwN-A84WT2MFE131Dt+6YiU96s+7NO5wkQ@mail.gmail.com> <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
In-Reply-To: <CAJfpeguh5VaDBdVkV3FJtRsMAvXHWUcBfEpQrYPEuX9wYzg9dA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Aug 2020 14:18:41 -0700
X-Gmail-Original-Message-ID: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
Message-ID: <CAHk-=whE42mFLi8CfNcdB6Jc40tXsG3sR+ThWAFihhBwfUbczA@mail.gmail.com>
Subject: Re: file metadata via fs API (was: [GIT PULL] Filesystem Information)
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Jann Horn <jannh@google.com>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Andy Lutomirski <luto@amacapital.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        Ian Kent <raven@themaw.net>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 11, 2020 at 1:56 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> So that's where O_ALT comes in.   If the application is consenting,
> then that should prevent exploits.   Or?

If the application is consenting AND GETS IT RIGHT it should prevent exploits.

But that's a big deal.

Why not just do it the way I suggested? Then you don't have any of these issues.

              Linus
