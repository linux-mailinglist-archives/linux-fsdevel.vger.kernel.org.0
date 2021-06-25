Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1C1F3B3B0B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Jun 2021 05:07:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbhFYDKI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 24 Jun 2021 23:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232973AbhFYDKI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 24 Jun 2021 23:10:08 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA4CC061574;
        Thu, 24 Jun 2021 20:07:47 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id h2so11483245edt.3;
        Thu, 24 Jun 2021 20:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UNvtlF232p3EiZr+6FhxyEqOeV41Uro0zH9H/bylNNo=;
        b=SVAwkIdCwdivOc7XY80cHuqu4FJ70WVLbDDk24GDxPsaatuF4TZMbIBRHVedJt8FXd
         daksQyOXqPaZNePIhZj5de5mbH71hqEmH7GSOtoQEq3rF048GV0peiVT3q/XIQcqzIhX
         4Dg0KFTKKTe2/LHo/ZHAOtuDyarPGAjRDKzOCPkRsNcrRTW8WlVoN6HNxdmlyafsIY3h
         eZUOhaHbA9w42jFwqLwRVKh0lk3NyNVGTglrh6tcHneOhQ/F0HA7HYm8d7voF5tZJVwj
         RgQjZ9ilx6f8uC6ulBWS5t2QAEp32E5BlwkzSIFolgAgBSOVchhU01El9VJfoNtf5aT8
         r6pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UNvtlF232p3EiZr+6FhxyEqOeV41Uro0zH9H/bylNNo=;
        b=inCCzolHKcW+jAxH37Qt/rBXozMpd9eQ0xfH60NlHi8i5x3MfjBGi/c/56+m9jkjmW
         YkVhFOolrjbUKzgxdrOHnJ/5i4mR1GWMB8bo/MkuA/EioMGvLQAygTsFnuzkRHF19vcY
         lYlqURJUVEMZbMp28OAoKgAGrT6laA2pgcDWkTMg6RH8xmQuVp+fSNLsB6kAb/mUDnxI
         zIJieN/mPeN2kp/wfLETP0dQ5CgiPcJOJGu5JIZthfws+o3TQsKlKO7LnYSE1dbcobvl
         wLvMIHXc+SAS8SSg1QWBjLCyUgo82iObdcfBvxBPQD8/czSXm9Sdib4WjPIVF0qrxsv/
         U4Pg==
X-Gm-Message-State: AOAM5308keQI2hvr0w78gESqAppBsc+zUTAkxVEgTXRd3ixAWF3BwtBv
        S/y5kJBlDw7L/5obXWr1fixx1TqZygirZPyQPP8=
X-Google-Smtp-Source: ABdhPJzNFJ9BxTwrfnzesjEqhAYBwOZhnTwAFnVTiM9ixuJG8gELz6vC/e8c5ZB5mm7pDn5Ng+oYslTkv397SD9XTm8=
X-Received: by 2002:a05:6402:1001:: with SMTP id c1mr11496221edu.26.1624590465724;
 Thu, 24 Jun 2021 20:07:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210416172147.8736-1-cccheng@synology.com>
In-Reply-To: <20210416172147.8736-1-cccheng@synology.com>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Fri, 25 Jun 2021 11:07:34 +0800
Message-ID: <CAHuHWtkqMeT3UwKH3zMr5j782U9UcwrdjXdqVHLND2MLi8rQKg@mail.gmail.com>
Subject: Re: [PATCH] hfsplus: report create_date to kstat.btime
To:     christian.brauner@ubuntu.com, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, jamorris@linux.microsoft.com,
        axboe@kernel.dk, dhowells@redhat.com,
        ernesto.mnd.fernandez@gmail.com, Al Viro <viro@zeniv.linux.org.uk>
Cc:     "Synology/Chung-Chiang Cheng" <cccheng@synology.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

From: Chung-Chiang Cheng <cccheng@synology.com>

There's no HFSPLUS maintainer now. Could anyone help to review this
patch or give feedback?

On Sat, Apr 17, 2021 at 1:21 AM Chung-Chiang Cheng <shepjeng@gmail.com> wrote:
>
> The create_date field of inode in hfsplus is corresponding to kstat.btime
> and could be reported in statx.
>
> Signed-off-by: Chung-Chiang Cheng <cccheng@synology.com>
> ---
>  fs/hfsplus/inode.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
> index 078c5c8a5156..aab3388a0fd7 100644
> --- a/fs/hfsplus/inode.c
> +++ b/fs/hfsplus/inode.c
> @@ -278,6 +278,11 @@ int hfsplus_getattr(struct user_namespace *mnt_userns, const struct path *path,
>         struct inode *inode = d_inode(path->dentry);
>         struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
>
> +       if (request_mask & STATX_BTIME) {
> +               stat->result_mask |= STATX_BTIME;
> +               stat->btime = hfsp_mt2ut(hip->create_date);
> +       }
> +
>         if (inode->i_flags & S_APPEND)
>                 stat->attributes |= STATX_ATTR_APPEND;
>         if (inode->i_flags & S_IMMUTABLE)
> --
> 2.25.1
>
