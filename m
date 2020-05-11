Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50E0F1CE78D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 11 May 2020 23:36:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726033AbgEKVgk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 11 May 2020 17:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725904AbgEKVgj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 11 May 2020 17:36:39 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B21EFC061A0C
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:36:39 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id i19so11567732ioh.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 11 May 2020 14:36:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ARRt8ef7HkMCL8HxRh+MxoQ7bnt30DaWuBbQFcrM3YA=;
        b=IZhV50kzhBDP+zFc/1c+jXw7CklxTdJRZVJBaQlXkhT/MaXwM89M5gvrxQzLQ6AMRY
         2sdogHxj41ueHbXOE+U1uBYFxxHFkrcpkVUvvCWsp/S1nwD8iwTnsViJn1CuaBfVqpfA
         mvL9WYTIh1PDgUiRue7V2w7362k7P4uI/h0er55H1DHNzLV5qnktkzvjN/qTmnwq30qP
         y7BWfS3c/3pbBkmvoO4e+lxXRUwFNjEZ7o9AWnb2RmirUC2Np3hCkv0vYSsRz3kNwzxG
         fcjuGXe07d6EfMwfDoch1AwFRki+WrscLQQ7wZQwhcPyB/ELqsNdaDLREvqWOYINLktT
         A55A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ARRt8ef7HkMCL8HxRh+MxoQ7bnt30DaWuBbQFcrM3YA=;
        b=JMCOdo2MX4+pwQxevUO0m8tnVlqFEycDETXM/BHPAmW5UKaVzxIj6eJyUQE9CIQbzK
         Dbdq4FuSa021jcd7lEJPOWJdqjIIsShQ22pmMnxddOkr8gcvujUSK4F/ebfcOaRnzmEc
         fKHuN5TkeN8PetdJTz/D7M/PmbgqIc/MyHv9a3uWANfXbOsck8uLx1kjZ/Gz+PItJX5C
         qikSoQnSeyreA8G94BQzaICygF6sCLTmQXIHREEHazTYtk4QmW/34JIEytZBWAytCt/x
         RMayz6dQ0fXUFa7mKtU6KIRS7QBFz+p5OXE6xV0JOzkABFkSvFvDmv+lH4mTsSBIIQX2
         N6pQ==
X-Gm-Message-State: AGi0PubUAW8OoarauXq5trKtNmpxxflguI8DQjWR1EBZ7zUOowzzYYs6
        lwfjjleitkWNv/UevlA8y6BLvUT96HMCLkN1hdI=
X-Google-Smtp-Source: APiQypJUJ3mVsDfkcYqJonylr53YFhMfT1uM//lSfF0IQxivIuXt7vlu6+gEPLt90j0iuOWhQcHGlyHc4IQ5vSkgjho=
X-Received: by 2002:a5d:8417:: with SMTP id i23mr17505072ion.186.1589232999077;
 Mon, 11 May 2020 14:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200511175934.214881-1-fabf@skynet.be>
In-Reply-To: <20200511175934.214881-1-fabf@skynet.be>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 May 2020 00:36:26 +0300
Message-ID: <CAOQ4uxjO9002R_-MXDTv=E3yS6zpnYNUHpy1ZBkMVU9Sy=nUjA@mail.gmail.com>
Subject: Re: [PATCH 2/9 linux-next] fanotify: fanotify_encode_fid(): variable init
To:     Fabian Frederick <fabf@skynet.be>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 11, 2020 at 8:59 PM Fabian Frederick <fabf@skynet.be> wrote:
>
> Initialize variables at declaration.
>
> Signed-off-by: Fabian Frederick <fabf@skynet.be>

Hi Fabian,

Thank you for the patch.
It is not wrong, but it does not bring that much benefit either IMO.
It does however come with a cost, because it going to have a minor
conflict with one of the patches I posted.

This is why patches should be done for a good reason.

Thanks,
Amir.

> ---
>  fs/notify/fanotify/fanotify.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/fs/notify/fanotify/fanotify.c b/fs/notify/fanotify/fanotify.c
> index 95480d3dcff7..5c6f29d2d8f9 100644
> --- a/fs/notify/fanotify/fanotify.c
> +++ b/fs/notify/fanotify/fanotify.c
> @@ -277,16 +277,15 @@ static u32 fanotify_group_event_mask(struct fsnotify_group *group,
>  static void fanotify_encode_fh(struct fanotify_fh *fh, struct inode *inode,
>                                gfp_t gfp)
>  {
> -       int dwords, type, bytes = 0;
> +       int dwords = 0, bytes = 0;
> +       int err = -ENOENT;
> +       int type;
>         char *ext_buf = NULL;
>         void *buf = fh->buf;
> -       int err;
>
>         if (!inode)
>                 goto out;
>
> -       dwords = 0;
> -       err = -ENOENT;
>         type = exportfs_encode_inode_fh(inode, NULL, &dwords, NULL);
>         if (!dwords)
>                 goto out_err;
> --
> 2.26.2
>
