Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9066C47610B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Dec 2021 19:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239225AbhLOStT (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Dec 2021 13:49:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239049AbhLOStS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Dec 2021 13:49:18 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9846AC061574;
        Wed, 15 Dec 2021 10:49:18 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id c3so31696733iob.6;
        Wed, 15 Dec 2021 10:49:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5eEVCrujViVmV0zIaDji1kh/aII6Yr7i5gqgtqAMTLc=;
        b=YNi4Q2z0oRiZ4G/TlAWIRp+rVLuIHN5FJdhmlwsi7FRh+i5IcwXcIIepEVYpIJT3GG
         WO72YMZNNoRs2fzEQqXU3MzXGcsairjxsHnD265OSKEfN5PjLMyhDPzvImqWu23GOd8h
         u1b388t+9gRVYmX1SQqdkaq8AtzjbjWF3SoQ71b2lvkrfTPqZ5qWWekAiXvCfL3n+/+u
         mXdPOMz0Cc4dOaY2qOQLnwjBuUFBwoTwlGPgavjnJVIPmxIrMtBVIVm8blX1uNJzG4YY
         yJDV5Kio88jEqYNFEIyOQLljv61o/RUOH9zb5yKa7sswJnGrqVT2Tr5K3/rKRjxecOh8
         x8Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5eEVCrujViVmV0zIaDji1kh/aII6Yr7i5gqgtqAMTLc=;
        b=PvZrepn2f1dhm7LOZyQU/Tia+g9YMiOdc6FdLT7MC75aQ3X5g7lly4G77C/PV/nBcP
         4lZhulnoIpLmK8toCZSLprJMkdI1KWG3kV0sT8VljP/K68fYF+v/YZ8tVSY5rSXU/tXd
         tCml+5kmWjiaD2d4gMrisnmkfzDsMiNn8A5NQhxQ9X4pw1eDTrGWApY8rzKTggQrbq6s
         Nob0pa6j2HcnNHc66scTwNLtARMt1SeenoDdp9d8oAK2jCEiHxW+u9lfxp60hb/SiLsO
         vFiaXlI/DjvR4wnLq+jVwZFhEJjJbMtgT6FbKw3n9D+4JXtoX9eOnJVceZqfjQQgS3Lo
         mY+A==
X-Gm-Message-State: AOAM532sUwWaIwrWectT6ZYDxvlHf2D2tGNjV2qOehTLnLLiQ2j3oRc1
        8J7996bIQEAWk3VBbZ7TEEhIZvqXwyHxhDePVgQ9mCeLk18=
X-Google-Smtp-Source: ABdhPJw1WXSkp+9aD8HixAQwK9zlLlOIcdkyQjDt1FIWyV5gYChKGVZjwG4Q1adqLdrONK8fozlL27QEoKletMz/6cc=
X-Received: by 2002:a05:6638:4091:: with SMTP id m17mr6586140jam.41.1639594158052;
 Wed, 15 Dec 2021 10:49:18 -0800 (PST)
MIME-Version: 1.0
References: <20211129201537.1932819-1-amir73il@gmail.com> <20211215174547.GO14044@quack2.suse.cz>
In-Reply-To: <20211215174547.GO14044@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 15 Dec 2021 20:49:07 +0200
Message-ID: <CAOQ4uxjfx4e_CyXGedwafezq5LcqjqCBO09bmvoUd-JuHSmJNQ@mail.gmail.com>
Subject: Re: [PATCH v3 00/11] Extend fanotify dirent events
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 15, 2021 at 7:45 PM Jan Kara <jack@suse.cz> wrote:
>
> Hello Amir!
>
> On Mon 29-11-21 22:15:26, Amir Goldstein wrote:
> > This is the 3rd version of patches to add FAN_REPORT_TARGET_FID group
> > flag and FAN_RENAME event.
> >
> > Patches [1] LTP test [2] and man page draft [3] are available on my
> > github.
>
> I'm sorry it took so long but I was sick for a week and a bit and so things
> got delayed. I've looked through the changes and they look good to me. I've
> just modified patch 9/11 to pass around just mask of marks matching the
> event instead of full struct fsnotify_iter_info. I understand you wanted to
> reuse the fanotify_should_report_type() helpers etc. but honestly I don't
> think it was bringing much clarity. The result is pushed out to fsnotify

I understand why you don't like using fsnotify_iter_info.
Result looks very nice to me.

Thanks,
Amir.
