Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0169B3FF076
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 Sep 2021 17:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbhIBPtC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 Sep 2021 11:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345837AbhIBPtB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 Sep 2021 11:49:01 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9D0C061575
        for <linux-fsdevel@vger.kernel.org>; Thu,  2 Sep 2021 08:48:02 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id t12so5120606lfg.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 08:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5wsPeIhzYXabpZGJAWeTrSQOBVTFZSeI6/V+A/PKS+M=;
        b=ERUiyJetgJfhv6CSzrx6t3BC3sUidOHQEL/eDPlppAa2ihMq3Wb2UVSXXDUuPuaU1A
         4/XvqW5lS+oI+M7I2xMssmbTqkpxCPxhR1wO2lWfQBg4oc+w/Mm4258ukKLi75PZRBLY
         Wn2b943/0K9fY7TmwJ8wE1L+ipYVBjxFcZqsQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5wsPeIhzYXabpZGJAWeTrSQOBVTFZSeI6/V+A/PKS+M=;
        b=NS3d6SXxArLhdoZYfR0p/wiAD9Kn44GUP1Q0VJjbxvnLY6yPjhWKc8fVyNtqaqThMz
         YgjeB8Hh4ROCFGfa4+hByOKuzS7T9KhZjJdrgnq8/oq3oOTzz/G2CJrJJQQyHAz92771
         JnlfYm2ixhYOK+xLxIhIVN3ysQ465x0SuvncW2mabffzY5rgQuL5JHODX2mUriP73a+q
         DLKdOW5mGZ50/ELJiv6nTTI7z5CZ42n93wDwvUDRRsjUiDipWpPdNwnPvf/4gl24IcP+
         2bvvbpvvTYwnK9NrCrHPe+AU/NTO4NXjRN1cCZ36Fm2ym3MYvWx0pXQjN7Suzy+rMCFC
         Y1nQ==
X-Gm-Message-State: AOAM532aOvzMAvlFkroPXD7QL4lT/VXxX5/tQrvcdoJL5kTSSgmQB6Lg
        tzDd4s5bg0n8svyTr9iD7aGNv5BXUF9TyDmJ
X-Google-Smtp-Source: ABdhPJwAROq1jKJdUe5204xJUDkmvkStWfzsO2YDPSnKT5gcBbaazSZ05WrK6V3jiyaq3GTk2qos6g==
X-Received: by 2002:ac2:4896:: with SMTP id x22mr3094099lfc.159.1630597680233;
        Thu, 02 Sep 2021 08:48:00 -0700 (PDT)
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com. [209.85.167.50])
        by smtp.gmail.com with ESMTPSA id j17sm233094lfe.55.2021.09.02.08.47.58
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Sep 2021 08:47:59 -0700 (PDT)
Received: by mail-lf1-f50.google.com with SMTP id k13so5311965lfv.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 Sep 2021 08:47:58 -0700 (PDT)
X-Received: by 2002:a05:6512:228f:: with SMTP id f15mr3148224lfu.253.1630597678499;
 Thu, 02 Sep 2021 08:47:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210831211847.GC9959@magnolia>
In-Reply-To: <20210831211847.GC9959@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 2 Sep 2021 08:47:42 -0700
X-Gmail-Original-Message-ID: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Message-ID: <CAHk-=whyVPgkAfARB7gMjLEyu0kSxmb6qpqfuE_r6QstAzgHcA@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new code for 5.15
To:     "Darrick J. Wong" <djwong@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 31, 2021 at 2:18 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> As for new features: we now batch inode inactivations in percpu
> background threads, which sharply decreases frontend thread wait time
> when performing file deletions and should improve overall directory tree
> deletion times.

So no complaints on this one, but I do have a reaction: we have a lot
of these random CPU hotplug events, and XFS now added another one.

I don't see that as a problem, but just the _randomness_ of these
callbacks makes me go "hmm". And that "enum cpuhp_state" thing isn't
exactly a thing of beauty, and just makes me think there's something
nasty going on.

For the new xfs usage, I really get the feeling that it's not that XFS
actually cares about the CPU states, but that this is literally tied
to just having percpu state allocated and active, and that maybe it
would be sensible to have something more specific to that kind of use.

We have other things that are very similar in nature - like the page
allocator percpu caches etc, which for very similar reasons want cpu
dead/online notification.

I'm only throwing this out as a reaction to this - I'm not sure
another interface would be good or worthwhile, but that "enum
cpuhp_state" is ugly enough that I thought I'd rope in Thomas for CPU
hotplug, and the percpu memory allocation people for comments.

IOW, just _maybe_ we would want to have some kind of callback model
for "percpu_alloc()" and it being explicitly about allocations
becoming available or going away, rather than about CPU state.

Comments?

> Lastly, with this release, two new features have graduated to supported
> status: inode btree counters (for faster mounts), and support for dates
> beyond Y2038.

Oh, I had thought Y2038 was already a non-issue for xfs. Silly me.

              Linus
