Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 201A9AC099
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Sep 2019 21:31:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393335AbfIFTbv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Sep 2019 15:31:51 -0400
Received: from mail-io1-f42.google.com ([209.85.166.42]:44648 "EHLO
        mail-io1-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbfIFTbv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Sep 2019 15:31:51 -0400
Received: by mail-io1-f42.google.com with SMTP id j4so15262394iog.11
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Sep 2019 12:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JyayYHkMn1qpko+mHWJq7od7PVMDdpgP++M1h2VjBSk=;
        b=f+kO3QdWmUt62y6UPR+zuafVFBlze9Pg7VQ8LvXG3aswD324RlaOzNpBZs+CTjmBE0
         C/27/KrVxRdvqc6940qjKdNIWnwrGLgEClqTyfrU3KxppGtv9P+ToNnlFaNXxHccoJhk
         e70fMAvul+bMthiutMg4HMK5HaQAaxw9eiqpo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JyayYHkMn1qpko+mHWJq7od7PVMDdpgP++M1h2VjBSk=;
        b=JNivPwexZ07Xkdu7/xvWgybg5xW3xgfBz5/DakhWrNZxwlSZFzpcWxsLpIVWu+Et1q
         FaRmAFHuHBfnSZbWSZvRKQx3NM4dfv4c+joLmLBIcgd4eDiyEGOrnN0XKzYdnz9NZ99M
         VUIw+qTSmJPGHpU9pzut3mXbgCY/+AYk4XfajWVtmuKKcF89cFDU+3eRMqpUx6hquFqj
         0vo/OGzvGJmCoGq8+XctUxFvzXIL8FGb3OV2ogzrAJqdkR9WW9n/p/W9h3Oul7G2G5jx
         gtbAYd7VQ1DCWka79t2T4Gnju3nMZAV2mTQNQ5mNftmhVt5WzurrfCalHO2r3/JJ1HNi
         eJXA==
X-Gm-Message-State: APjAAAXGMOFmWlEXxymZosWWXnm+5APw/wDzbTCI7Bse5QwGAMYs1L5h
        z+EdlBg7pFIpX9WUIOy/hKkZnbRkWXSmsJsoNxYR6w==
X-Google-Smtp-Source: APXvYqyr6V7RAsDSn1gogovl85zo9XXF34N2OltcVcy8oYI8zIAjefbte+KpZp9NQhWKrdqUiGq+pCePnVsk+Lar7zQ=
X-Received: by 2002:a6b:bec6:: with SMTP id o189mr11604496iof.62.1567798310356;
 Fri, 06 Sep 2019 12:31:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190906170730.GY1131@ZenIV.linux.org.uk>
In-Reply-To: <20190906170730.GY1131@ZenIV.linux.org.uk>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Sep 2019 21:31:39 +0200
Message-ID: <CAJfpegvagSjXYg0zVKeJvJOBKJXBzVPZsBrovX6XM9qUPkB-ng@mail.gmail.com>
Subject: Re: fuse / work,mount coordination
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 6, 2019 at 7:07 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         Could you switch your branch to pulling vfs.git#work.mount-base,
> drop cherry-picked "vfs: Create fs_context-aware mount_bdev() replacement"
> and use get_tree_bdev() instead of vfs_get_block_super()?
>
>         I'd like to put #work.mount1 into -next instead of current
> #work.mount, and doing that would obviously cause conflict with your
> cherry-pick.  #work.mount-base is the infrastructure part of that
> series and it'll be in never-rebased mode.

Done and pushed.

Thanks,
Miklos
