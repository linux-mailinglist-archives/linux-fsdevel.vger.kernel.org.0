Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2CEF71F8461
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jun 2020 19:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgFMREN (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 13 Jun 2020 13:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726272AbgFMREN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 13 Jun 2020 13:04:13 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5880AC08C5C1
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 10:04:11 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id i8so679200lfo.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 10:04:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8uOcP8wvI0VVU/9vs++U3KixSM8L7MBiXf+DxWGkO0I=;
        b=Yy3d5KdRDw1hzH1PEQuf/w+pL5E0KZICHKYeEpDF6h4E1JkwxsLxvUOA82j8ffi9wm
         G69M2LrhlOjYJ+LDuDQRsqubitClqczfsBDSYVR2HIzjv6ucIalMybe9rZVai3H50Ykg
         LtyaL1R6OHx6sisGgCxHaVvhg8CvecRUuLcqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8uOcP8wvI0VVU/9vs++U3KixSM8L7MBiXf+DxWGkO0I=;
        b=ELdjNWuJjPZAWGkFiitip8p6cMlli0dqdMUh+JGl6Z4NHGKTbEr07nVhi3Mi6GqqJ4
         azQosbqSEyF2bKc6j3ZyIkPEH8FPWp2ZDx3jCCT1gWON5riREZF6ADlFSmRWhaa9ZU8N
         Mkv9bXLbnt7rnCWRArIqcNOEyYC63w2XF0SOSAn4+c7m3sdNNJPEzk2RhrW8IZsOiPF2
         oM7LdRNH8idHNMnGS5U9vIiffr7YSamxO/YHunNrprcLSePSBt2wMoi1eoS0llc8gCRp
         Mglm7QhE4g3eIrv3emcD8AyQi2MOsOeDZ4fL74apc/f+cWGLIiaQCpOCDnpiHhqdxI5Z
         yJIA==
X-Gm-Message-State: AOAM533qzopVeD8NxhBe6dDmQ7xaJg/raxQo1ckQAHV+ArAs+nvx6zE+
        aISxV/nPde2QT5YA5ztC3t+6A8e1jZI=
X-Google-Smtp-Source: ABdhPJwTpb6RQ5OkqaBxWbps0uVywT7B2z9YF4TTnQvkRdkBKvV9TJhBwv3s8MtbGD3tQBf2kK6FPQ==
X-Received: by 2002:a19:8305:: with SMTP id f5mr3387441lfd.173.1592067848659;
        Sat, 13 Jun 2020 10:04:08 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id g5sm2733697ljk.93.2020.06.13.10.04.07
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 13 Jun 2020 10:04:07 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 9so14525135ljc.8
        for <linux-fsdevel@vger.kernel.org>; Sat, 13 Jun 2020 10:04:07 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr9126775ljk.314.1592067847109;
 Sat, 13 Jun 2020 10:04:07 -0700 (PDT)
MIME-Version: 1.0
References: <1503686.1591113304@warthog.procyon.org.uk> <20200610111256.s47agmgy5gvj3zwz@ws.net.home>
 <CAHk-=whypJLi6T01HOZ5+UPe_rs+hft8wn6iOmQpZgbZzbAumA@mail.gmail.com>
 <3984625.1592053492@warthog.procyon.org.uk> <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
In-Reply-To: <CAHk-=wh=9bYycJM5ginkkwymb3x-geMtiT5i2FvRS0zbKYR9LQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 13 Jun 2020 10:03:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgX1WM-ST+imRUUKabBo8GodUkYLGSAZ9NsGyqjA-q1Ng@mail.gmail.com>
Message-ID: <CAHk-=wgX1WM-ST+imRUUKabBo8GodUkYLGSAZ9NsGyqjA-q1Ng@mail.gmail.com>
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

On Sat, Jun 13, 2020 at 9:47 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> If we have multiple uses, and one of them notices some problem that
> requires any ABI changes, but the other one has already started using
> it, we'll have more problems.

Ok, it's merged in my tree, although I was somewhat unhappy about the
incomprehensible calling conventions of "get_pipe_info()". The random
second argument just makes no sense when you read the code, it would
have probably been better as a helper function or #define to clarify
the whole "for_splice" thing.

But let's see how it works and what actually happens.

               Linus
