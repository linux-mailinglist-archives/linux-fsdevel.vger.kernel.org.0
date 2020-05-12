Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13E171CFD54
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 May 2020 20:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbgELScY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 May 2020 14:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725938AbgELScW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 May 2020 14:32:22 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 345D2C061A0C
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 11:32:22 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id w11so15182299iov.8
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 May 2020 11:32:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QxMXFaUWHw4TyNnhjIAhhMEqHJ6qjevYh7uNE/H+6hI=;
        b=tNN6s+9CnF/YQkokTh959Fz/Yfn8lf1XTjGa/dn7HHSmsS1lwIlENoyzzkROOWZEot
         kBFil9y6mbg4FMqL/KUTEPLo3VeIN0OlIqq+Q9LYvESzoRsibAxV6u0MRrGcGFgtg38I
         lTjXcA8Uqsix7jDlt+TWclqadx5T9zIUapx2DN1xCpK1ycsg82Vf7FDmP4eHCmh2g8YY
         xcy2kePd2DXrRgKiVlSbVN9/3U8PLjwIhcy47ROtxDCAA7Xjb1cRn9sTeOP568PmqREg
         zajSAD6w1VZ14+co4eeWekWkXITivn36LaY6UrGfp5O3sPFcNn+1KJ8gdeWHZEVQbhl/
         KuAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QxMXFaUWHw4TyNnhjIAhhMEqHJ6qjevYh7uNE/H+6hI=;
        b=qIn3+a7wUcAgWXOdGtXHhtKfWhSZnBcf6kKWssSxuNonE1rUbwhzt5j/l23jBkerZa
         KC9tkjKx5aQ1OEmB+H1MNj+VLDqrIx/alguSV8P35D6X/h7CuSBXAvgOk3Ql57LEPRBl
         JhBAVPWveHw4UO6QmwXefgIOf1Suv0aGbaagQKKyKEFpP4n8VpJ9mF2O51VtZbgb1m7s
         9DNuJ3IhjYh0srmUxp1T3Eu49AE4rm2T93dnNesw60x1diqeLwT9b++iFS0GKsVTVHH8
         zoDpoOGgtsDJyMMo5aEMff8MYmj67RxZXB2sZ2ZehxW8yGYgNbBrEQ7FfUqbhI8p/d9b
         S1AQ==
X-Gm-Message-State: AGi0Pubn38v/VhLabJX40VWPTExyDn6Ir7V4QNwDMrKf9OhjpqBuNDPk
        Fdvn9qlLcWrjjbFRqc8qaQfT2QIcad9G+wAae8s=
X-Google-Smtp-Source: APiQypJbZTiu3/qadS27MLtSOHgqMA37E6TzmVpglEKc8qleYvS0mUawmWzU8HGLb05JB/mdIbKi+U0IT0U9MN5FjtE=
X-Received: by 2002:a5e:840d:: with SMTP id h13mr11801137ioj.64.1589308341569;
 Tue, 12 May 2020 11:32:21 -0700 (PDT)
MIME-Version: 1.0
References: <20200512181608.405682-1-fabf@skynet.be>
In-Reply-To: <20200512181608.405682-1-fabf@skynet.be>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 12 May 2020 21:32:10 +0300
Message-ID: <CAOQ4uxgr7gXBEYPDSPS+ga0+dXY_xDtae_ZQqg5_Bed3PtJMZA@mail.gmail.com>
Subject: Re: [PATCH V2 0/6 linux-next] fs/notify: cleanup
To:     Fabian Frederick <fabf@skynet.be>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 12, 2020 at 9:16 PM Fabian Frederick <fabf@skynet.be> wrote:
>
> This small patchset does some cleanup in fs/notify branch
> especially in fanotify.

Patches look fine to me.
I would just change the subject of patches from notify: to fsnotify:.
The patch "explicit shutdown initialization" is border line unneeded
and its subject is not very descriptive.
Let's wait and see what Jan has to say before you post another round.

Thanks,
Amir.

>
> V2:
> Apply Amir Goldstein suggestions:
> -Remove patch 2, 7 and 9
> -Patch "fanotify: don't write with zero size" ->
> "fanotify: don't write with size under sizeof(response)"
>
> Fabian Frederick (6):
>   fanotify: prefix should_merge()
>   notify: explicit shutdown initialization
>   notify: add mutex destroy
>   fanotify: remove reference to fill_event_metadata()
>   fsnotify/fdinfo: remove proc_fs.h inclusion
>   fanotify: don't write with size under sizeof(response)
>
>  fs/notify/fanotify/fanotify.c      | 4 ++--
>  fs/notify/fanotify/fanotify_user.c | 8 +++++---
>  fs/notify/fdinfo.c                 | 1 -
>  fs/notify/group.c                  | 2 ++
>  4 files changed, 9 insertions(+), 6 deletions(-)
>
> --
> 2.26.2
>
