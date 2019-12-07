Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 81EA9115AE9
	for <lists+linux-fsdevel@lfdr.de>; Sat,  7 Dec 2019 05:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbfLGEBw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Dec 2019 23:01:52 -0500
Received: from mail-lj1-f194.google.com ([209.85.208.194]:37676 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726395AbfLGEBu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Dec 2019 23:01:50 -0500
Received: by mail-lj1-f194.google.com with SMTP id u17so9810206lja.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 20:01:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=D9bKHIb2A+ygTSdf7+zChgWhyt6dX/dK0jQhf4W59Is=;
        b=VewXPpWS3+yURzc9MxeOz56Shx1+ekHKKsZfJnkLg9gHFEScXDb5QEN818XuMQTXYe
         NyJTv407dJJ9d7NrQabS6rsC/IYYbwFbxjny2fxTVVGjPfxy1f48xIkLhmJy8IQJILgZ
         BI217t4bFVF2NVTgqWRTPYknLUJ/qIOuDYDFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=D9bKHIb2A+ygTSdf7+zChgWhyt6dX/dK0jQhf4W59Is=;
        b=f7WKvSzMRZ7j0WY0LKBmGAaDSonJcyJYatjnl7rnh1MXb2AWfCK6Ydxu3o6R3DkwK0
         Q8qVZwQL0PeFU7rZ03CwQhnWetq4E4EzIJo1LsfhbJXQ+3E1ID7cKhZmw2g+h53pGs0K
         /e3xSYO8Y+noxv556To6Z8Egd/fK2R2MYqpcHafDVglqlcjC+iFVLq2pPDHdRI94nxpv
         yaTsjEBs8bIKm04xX8dO8DMw26MurwFAfWFkIPS/RY1DoQrDyb+InW1I+tnKNRkiWpAL
         j51m2Vexo0LEqQvSaF+AKCeJxNvs6V1YKOv1uFw9VnbQYc5lECsrcN6iBRZWtZ2vLW78
         oezA==
X-Gm-Message-State: APjAAAVKwF/51nFU4zATpsBmGRHseshF6HA5NbwSn48s7LDzNWBuh+TM
        6DShc//SCl94VRyrWFOKk37nASJM2So=
X-Google-Smtp-Source: APXvYqy+98vXEJ8UfZYTsLYpCEQvKG+QqcTKARbnxvfHWLDZxAQwpb6ZQ8NDy70xbhFbs8NUt760WA==
X-Received: by 2002:a2e:3216:: with SMTP id y22mr10181795ljy.95.1575691307308;
        Fri, 06 Dec 2019 20:01:47 -0800 (PST)
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com. [209.85.167.41])
        by smtp.gmail.com with ESMTPSA id q13sm8651032ljj.63.2019.12.06.20.01.45
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Dec 2019 20:01:46 -0800 (PST)
Received: by mail-lf1-f41.google.com with SMTP id l18so6806623lfc.1
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Dec 2019 20:01:45 -0800 (PST)
X-Received: by 2002:ac2:465e:: with SMTP id s30mr6736611lfo.134.1575691305722;
 Fri, 06 Dec 2019 20:01:45 -0800 (PST)
MIME-Version: 1.0
References: <157558502272.10278.8718685637610645781.stgit@warthog.procyon.org.uk>
 <20191206135604.GB2734@twin.jikos.cz> <CAHk-=wiN_pWbcRaw5L-J2EFUyCn49Due0McwETKwmFFPp88K8Q@mail.gmail.com>
 <CAHk-=wjvO1V912ya=1rdXwrm1OBTi6GqnqryH_E8OR69cZuVOg@mail.gmail.com> <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
In-Reply-To: <CAHk-=wizsHmCwUAyQKdU7hBPXHYQn-fOtJKBqMs-79br2pWxeQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 6 Dec 2019 20:01:29 -0800
X-Gmail-Original-Message-ID: <CAHk-=whnf=avRa4JVoiEB+75mSpnAKuoQSFaxOJWHfqX3mqUqg@mail.gmail.com>
Message-ID: <CAHk-=whnf=avRa4JVoiEB+75mSpnAKuoQSFaxOJWHfqX3mqUqg@mail.gmail.com>
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

On Fri, Dec 6, 2019 at 7:50 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I assume it's the added "do_wakeup = 0" (not the spinlock) that ends
> up having some subtle issue.

Ahh, and then later that is removed, but when it is removed it also
remote the wakeup before the pipe_wait(). So whatever issue that
commit introduces ends up remaining.

I wonder if the extra wakeups ended up hiding some other bug. We do
extra wakeups on the write side too, with a "FIXME! Is this really
true?" comment..

              Linus
