Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CFC7C1F6D13
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Jun 2020 20:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726805AbgFKSBF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 11 Jun 2020 14:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbgFKSBF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 11 Jun 2020 14:01:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02BF2C08C5C1
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 11:01:05 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id i27so7966521ljb.12
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 11:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BulRtyYimxYCM3JqpK8tF3IaJrXUR0A9VD3QaE4GUiU=;
        b=F+EXHlVbvkMTRVWWzv8ZcPEHGpfAID2Da8N5jJ9jwq/Sk5UFdV4BndnY890mbolBO3
         xJbuERV3mR0f+F5yKntH8xwiKR2kUGoUueLXNO5RnIgcO1PBh7DEHUydmD5yKAclq+vQ
         balMdqIjrUuK2NFsEurmgSTtX0E/N5pRMm69I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BulRtyYimxYCM3JqpK8tF3IaJrXUR0A9VD3QaE4GUiU=;
        b=IxxKVlyyimwEoQouDF+InX0vV2uN8kSWxt1WzbbjpdEkOTl7Qara1OGtnmmj/rYdxA
         9gxtol63fi0GnSbfwIJ5RwQIazNN4Xsa7kOy5z/i2rgjM19JOyc1//9XmZaMSS0aBHP8
         HUzzmd/leGli53tSMciroDrdoMWmercckMoECdHwh3QG0bEHSfZdcmkB16iW1ZxI+9NK
         e+2aj47LUH+3p+xm6LrMSHB/ILOvIEc1xJObeMSpCmN4wVxuOTPSbP+3pycJrRt3GwG/
         sZnKfHQEPBHrUjsVwy5kFqTd72JpGY2EMmUy3TgYEUYxfEBWmjybuDNGg/IKLbpibeAo
         K3zQ==
X-Gm-Message-State: AOAM530iYfyUAQzNsnuBxuPFfpdlL+ZL10pmfq47zRYP8H52HHr4/jhV
        mfpq7OKSWMcfCWO6OGd4Gzd6ZfNgWj0=
X-Google-Smtp-Source: ABdhPJxKS8z9CELwxfKW9WgdwLgijp/WzYtMKht1rKJuC1kpIpEHbmcUJ3j88D01NlzQXEJLBE4bbA==
X-Received: by 2002:a2e:82ce:: with SMTP id n14mr5342973ljh.9.1591898462252;
        Thu, 11 Jun 2020 11:01:02 -0700 (PDT)
Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com. [209.85.208.182])
        by smtp.gmail.com with ESMTPSA id z2sm1141158ljh.72.2020.06.11.11.01.00
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2020 11:01:00 -0700 (PDT)
Received: by mail-lj1-f182.google.com with SMTP id s1so8030501ljo.0
        for <linux-fsdevel@vger.kernel.org>; Thu, 11 Jun 2020 11:01:00 -0700 (PDT)
X-Received: by 2002:a2e:8e78:: with SMTP id t24mr4854187ljk.314.1591898459839;
 Thu, 11 Jun 2020 11:00:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200611024248.GG11245@magnolia>
In-Reply-To: <20200611024248.GG11245@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 11 Jun 2020 11:00:43 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
Message-ID: <CAHk-=wgTMxCAHVgtKkbSJt=1pBm+86bz=RbZiZE-2sszwmcKvQ@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: improve DAX behavior for 5.8, part 3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>,
        linux-ext4 <linux-ext4@vger.kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>, ira.weiny@intel.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jun 10, 2020 at 7:43 PM Darrick J. Wong <djwong@kernel.org> wrote:
>
> I did a test merge of this branch against upstream this evening and
> there weren't any conflicts.  The first five patches in the series were
> already in the xfs merge, so it's only the last one that should change
> anything.  Please let us know if you have any complaints about pulling
> this, since I can rework the branch.

I've taken this, but I hate how the patches apparently got duplicated.
It feels like they should have been a cleanly separated branch that
was just pulled into whoever needed them when they were ready, rather
than applied in two different places.

So this is just a note for future work - duplicating the patches like
this can cause annoyances down the line. No merge issues this time
(they often happen when duplicate patches then have other work done on
top of them), but things like "git bisect" now don't have quite as
black-and-white a situation etc etc.,

("git bisect" will still find _one_ of the duplicate commits if it
introduced a problem, so it's usually not a huge deal, but it can
cause the bug to be then repeated if people revert that one, but
nobody ever notices that the other commit that did the same thing is
still around and it gets back-ported to stable or whatever..)

So part of this is just in general about confusing duplicate history,
and part of it is that the duplication can then cause later confusion.

                Linus
