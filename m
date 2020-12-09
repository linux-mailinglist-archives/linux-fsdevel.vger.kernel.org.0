Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC8FF2D48C4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  9 Dec 2020 19:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732938AbgLISRJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 9 Dec 2020 13:17:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732687AbgLISRC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 9 Dec 2020 13:17:02 -0500
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A9FC0613CF;
        Wed,  9 Dec 2020 10:16:22 -0800 (PST)
Received: by mail-io1-xd42.google.com with SMTP id z5so2568621iob.11;
        Wed, 09 Dec 2020 10:16:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0bnqZJonPm2Y5rYBHlDQYhPCxMpoVcbNGKebJQlZK0o=;
        b=qkhZTAiGze98uNr1WjA5/wLIhNSehJmfMFfgUD8xlmDDr9V5Y5ZFHpFEBWs8n3Qtkg
         Y9SwVVaRMH+qBNyqfLpdTWFiXNXpP0624tfi5xJoWMBwM9cuwiupVIc8yMENklBLFcrl
         CAZj3uSVxZqNZUO3QE9P0de9IyZiM/heJRCLkyQFvXQoJe2tog+vie3Wphrf1FsWtVQO
         nz6eB9kyg67GbIG+w9PSSAF600D6UfMxu2RVSn8fmUCj2WBYI44stH8X+LHqxLij0+Xh
         Ky/1rHICxjYGenItETlfONNeIclnT7lh+yn5OXElreSOQcv+7fdp5xlqxBNRQNI8s4zP
         +kXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0bnqZJonPm2Y5rYBHlDQYhPCxMpoVcbNGKebJQlZK0o=;
        b=hM4OEK+u8ZK304Bi3+u6YhyvneHnHSq+wezUyHS1uzj972uG7EpEvSxQfutg+mMHwa
         5NdPy0LzIjMeJzRjy6FU8o1ukkAFQa0Xr2zLVCO4DUq/TN3tUeVXcJoEPWIcVowHef4Q
         ZdnE60ZkkktbuoUAUfdpYtwm1OLFmZ6oUsVY0TKtsndgHJDI0gQTbpwg8ygyI7tpN4tD
         1iCcK2+B0whVJ8moIOAVe9CvkEDGo6IJDF2RtCGumqp7JJIX7XYq5xX05vQjFtv9Z4U6
         1XBcwBhuQ81E/Vqsdo0/IukfZ+f3KN/n49SLZ+PaYFy8B8Tf4FdruO1lVqCB304B++wc
         Ltcg==
X-Gm-Message-State: AOAM533oYGMfsl7fQq/oCHe+cRS7uTYgvzZ+PN/JwncxiEF27Kj2nja0
        Fvve38YJ7gKYFseOFsCsvzc+wXYPgnlyfx7UQfM=
X-Google-Smtp-Source: ABdhPJwA+AlarNaiEaz4q0T5sNgD9fSqisBJmFpg0z0xOmYs0H+it97uPc7KbcQZq+nqKtOfuo1PK6oNjMjpnlB3/lQ=
X-Received: by 2002:a02:a60a:: with SMTP id c10mr4606978jam.123.1607537781901;
 Wed, 09 Dec 2020 10:16:21 -0800 (PST)
MIME-Version: 1.0
References: <20201207163255.564116-1-mszeredi@redhat.com> <20201207163255.564116-4-mszeredi@redhat.com>
 <CAOQ4uxhti+COYB3GhfMcPFwpfBRYQvr98oCO9wwS029W5e0A5g@mail.gmail.com>
 <CAJfpegsGpS=cym2NpnS6H-uMyLMKdbLpE1QxiDz4GQU1s-dYfg@mail.gmail.com> <CAJfpeguvt-Mia9YmT55q3R9tSFocpgq7FzjDKJgnaOEQsaBNVA@mail.gmail.com>
In-Reply-To: <CAJfpeguvt-Mia9YmT55q3R9tSFocpgq7FzjDKJgnaOEQsaBNVA@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 9 Dec 2020 20:16:10 +0200
Message-ID: <CAOQ4uxjDEVnz3Y_BqH41J4+E5dWRPyut_VPokEeMBNALx9oQhw@mail.gmail.com>
Subject: Re: [PATCH v2 03/10] ovl: check privs before decoding file handle
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 9, 2020 at 6:20 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> On Wed, Dec 9, 2020 at 11:13 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> > Hard link indexing should work without fh decoding, since it is only
> > encoding the file handle to search for the index entry, and encoding
> > is not privileged.
>
> Tested this a bit and while hard link indexing does work,  inode
> lookup is broken since it uses the origin inode as a key (which is not

Yes, that is what I meant by ovl_check_origin() is broken.

> available) instead of using the origin value directly.  This is
> fixable, but needs a fair amount of restructuring, so let's just

Maybe it also requires on-disk changes.
We should be able to use the origin fh as the key for lower inode,
but we need the lower st_inode for initializing the ovl inode with
correct ino. If we cannot decode lower inode from origin fh, I think
we would need to store the ino in user.overlay.ino on copy up or
maintain redirect, but redirect is not supported either with user ns mount...

> postpone this and disable index for now, as you suggested.
>

Nobody seems to be enabling it anyway :-/

Thanks,
Amir.
