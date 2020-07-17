Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F16C2231C7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 17 Jul 2020 05:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726977AbgGQDtQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 Jul 2020 23:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbgGQDtP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 Jul 2020 23:49:15 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8964FC061755
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 20:49:15 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q74so9067840iod.1
        for <linux-fsdevel@vger.kernel.org>; Thu, 16 Jul 2020 20:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lG/4I+vgD25j0CnGJWaK0RYlCihUUn1WHkAFwdnwNUQ=;
        b=bfS1Bv0iE/l+Qnqd33feKrBCAt/KHn8xD9COCUrS1Fx0hdS5mXT/bWMfizAkDr33vg
         Vn+sGM+JoxfQeqZKtKfxfAxg3aYGNzOnvZcGPohCseAnCRMKjYF7B3xNOO4D3G6IOF+r
         /69I7Fu/s8+tVHptnh1mITsU/GMxYElQihluXDTDanm6CTQhCdFSueIkVOcKKQiT3GE+
         Jcwx0nXtVeKzB83sI2z2e2EKlAyK7oRbCUMAcARoDCaI4enx5CMezc4FbHCv1IrW/0cs
         CPf/Ba9I2WojrkwPMCwbKcagLmB/YDcVbVJcw2qc5KhFV3YbV4H9bKsBv6H7HI7oX4Oo
         L/Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lG/4I+vgD25j0CnGJWaK0RYlCihUUn1WHkAFwdnwNUQ=;
        b=RiQst+skeM7ItMiHEKs/mutDuTI/Np3BMeaGnnIb+FrROZT1JCshEk0eY6Wg7tRISy
         +0mhFjeEdqQuVAm+OznfFSv5KEZeNvV/8w6knFjxUH/gkIX2CXu4uW3l5Q1FBdW5MldI
         FnDcgoI2f45SaAOsxv6z8k+kHoMyvJuv6l5zzwBLChLZxk38xP8G2J72Lr+xkUkewHmn
         OC2Y+kh0sfyu+f8OXzs4f0QAonoQnNwXrvUcrf8Gl+mDjV03hmrTftU4q6468YQgjxp4
         PUNzjwMo1UXH9x5lZR4OXE45o1LMaoL/JwLfko02knZvZzhFM0u+WenontenibvwAFFp
         6NxA==
X-Gm-Message-State: AOAM530klqPwT0qOs4PqDJRemwdaOCfW/fhE78cASC1HZCHUdvLxoI52
        tfUWgE85LYArb2WSdB42e7TkWThRrwJqR91QWEC6WbsR
X-Google-Smtp-Source: ABdhPJwTsc4vD3ZRGONrOCCsWEozN0i6+ImeAzyFqX4miE6Qy47LjBsPuMqerhXGrxmBGlbb0zZHPplRdeJJDcU+fzQ=
X-Received: by 2002:a6b:b483:: with SMTP id d125mr7670002iof.186.1594957754777;
 Thu, 16 Jul 2020 20:49:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200716084230.30611-1-amir73il@gmail.com> <20200716084230.30611-16-amir73il@gmail.com>
 <20200716170133.GJ5022@quack2.suse.cz> <CAOQ4uxhuMyOjcs=qct6Hz3OOonYAJ9qhnhCkf-yy4zvZxTgFfw@mail.gmail.com>
 <20200716175709.GM5022@quack2.suse.cz> <CAOQ4uxiS2zNkVQZjcErmqq2OSXdfk2_H+gDyRWEAdjzbM+qipg@mail.gmail.com>
 <20200716223441.GA5085@quack2.suse.cz>
In-Reply-To: <20200716223441.GA5085@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 17 Jul 2020 06:49:03 +0300
Message-ID: <CAOQ4uxg_68=e32WHznJqdeSefaR4Obc+rmUXFQOrCvDyHeHK+g@mail.gmail.com>
Subject: Re: [PATCH v5 15/22] fsnotify: send event with parent/name info to
 sb/mount/non-dir marks
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> OK, nice trick but for this series, I'd like to keep the original ignore
> mask behavior (bug to bug compatibility) or possibly let parent's ignore
> mask be applied only for events being sent to the parent due to its
> FS_EVENT_ON_CHILD.

That should be easy if we set the FS_EVENT_ON_CHILD flag only for
the case of a watching parent.
And I believe that would make the flag meaningful again and not
redundant as you now see it.
Please note that the series is already not "bug compatible", because
the patch " send event to parent and child with single callback"
already fixes the combination parent watch + child ignore, which
did not work before and this is declared in commit message.

> Can you please fix that up?

Will do.
I will also take care of LTP test coverage for the ignore mask cases
that have been fixed and for dnotify/inotify parent+child watching case.

> I won't get to it before I
> leave for vacation but once I return, I'd like to just pick the fixed up
> commit and push everything to linux-next... Thanks!
>

Thanks a lot for everything!

Amir.
