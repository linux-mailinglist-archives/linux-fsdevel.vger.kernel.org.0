Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8072511577E
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Dec 2019 19:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLFS70 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 13:59:26 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:41717 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726325AbfLFS70 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 13:59:26 -0500
Received: by mail-lj1-f194.google.com with SMTP id h23so8745958ljc.8
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 10:59:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=1FDNapKMyJbKRN4aBAePV2ePHaiGaeNO8oMNreucOQY=;
        b=PgSQDJhkFDTFDemGwLYHhtvXR6HJRvYj90hNfBT6osoTDg5ezGsSbGl83LOQXCCHJx
         i+MdTOYgdB4keVytADAH76rUGbbekCtN0m1I+heTBGpmgPAeblFj2jYDfHmvwt/W+n39
         MuKxbAsB+RUFfgptJIHuFE+m0X89qs3bMVfSk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=1FDNapKMyJbKRN4aBAePV2ePHaiGaeNO8oMNreucOQY=;
        b=l2/cTBmpoqNtxDD2RPXKcc7JiQkSoNsVWhPA2W0Nzzv52Ni8oig+8zEkiTCZJbJqzY
         4sVH3CW29pTjmux0o81bdorCmHmcaCrjMYR0d39XLN9OldiWkhHjM/jYO63Nc/7XSzJP
         t4NSg5X6EYrIo6G+AR77+2E3NnH+Idcq4ax+aWGhKbqlnck3ElcPMyifgD9kY0vM8DF7
         sOhpc74Z+Y/7+l6F6V8XbRxQe2u+oq3eapR+vVYX6xEl4Q1dIRwYURhxBkU0mEfyJBYB
         4JGg0ZYphHbySqIeA3+eX5QvvuytqF58e1x7dhHHvDDhQCln70zXLz+pHAHBq6NuitR/
         fntw==
X-Gm-Message-State: APjAAAUcuqzo6gH3xrxQSDqxifFI2YG0kQ5BnJC6WzK/QnGC55zaLAH/
        f0FTITI1NoPfpr36fkrnuK+3kQDWZQE=
X-Google-Smtp-Source: APXvYqzaOZ1Jf3SsYfrNoUmjRjVwSWZ+MXtF6AxMWbCJWVp9yzwZGI4JrOu/toIfh+1zMHL8cxHIyQ==
X-Received: by 2002:a05:651c:285:: with SMTP id b5mr9637761ljo.14.1575658764563;
        Fri, 06 Dec 2019 10:59:24 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id 6sm1653451lft.52.2019.12.06.10.59.22
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 10:59:23 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id n12so6053307lfe.3
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 10:59:22 -0800 (PST)
X-Received: by 2002:ac2:555c:: with SMTP id l28mr8819122lfk.52.1575658762585;
 Fri, 06 Dec 2019 10:59:22 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wj42ROD+dj1Nix=X7Raa9YjLfXykFczy0BkMqAXsFeLVA@mail.gmail.com>
 <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
In-Reply-To: <CAHk-=wga+oXMeMjftCKGT=BA=B2Ucfwx18C5eV-DcPwOAJ18Fg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 10:59:06 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Message-ID: <CAHk-=wj9pprDUeoJd5EeN-2x7+GXdSsm44mSv1y9f5e7MrTZ2A@mail.gmail.com>
Subject: Re: [PATCH 0/2] pipe: Fixes [ver #2]
To:     David Sterba <dsterba@suse.cz>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Biggers <ebiggers@kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hmm. I think I just saw this same bug with a plain kernel compile.

My "make -j32" suddenly came to a crawl, and seems to be entirely
single-threaded.

And that's almost certainly because the way 'make' handles load
distribution is with a network of pipes that has a token passed to the
sub-makes.

So there's most definitely something wrong with the new pipe rework.
Well, I can't _guarantee_ the pipes are the cause of this, but it does
smell like it.

              Linus
