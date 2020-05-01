Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9921C1E0C
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 21:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726483AbgEATqi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 15:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgEATqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 15:46:37 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE1EC08E859
        for <linux-fsdevel@vger.kernel.org>; Fri,  1 May 2020 12:46:37 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t11so4667285lfe.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 01 May 2020 12:46:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kt6IiWcmZXX6mLZe3Npm+KnNStyWK4tvZMSZknHrpEw=;
        b=ZyvFH+M0FEmSh28N06nH7yi6EuuiQnNaCVIMA3mgShcIVa7cWxG83XzZcK+9attidQ
         2c4sCZ0aEx5sZnBre78nNPKQWqJ2puuyL4g+CF4LQDiEavbU3LXBmnx6z3k7+mi1Gcwl
         2NR6PYa09f0mZVpskNA7T0kO1xYiOGZEVm9yBa+ei+GkVggdds92ykznzEzxhfvtpvVa
         rapUqKOvGs7LqMCkRzrgJbhq4h9K7YKmkapN9fsCpiJvkbS85NHlYwaG/L+MVko2VMcr
         7Fc6BK5LCtLbxWvBTe/ruxFuF9NGdx3vH4iOqCfUZ7bBoaY7kRmOclZpIAoC/YtpYx7g
         URmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kt6IiWcmZXX6mLZe3Npm+KnNStyWK4tvZMSZknHrpEw=;
        b=PCpFYSeA8m6dJvP7dikENVJxBJt1BFzvmNKk6nyNKTYFf1n36RLNHh0Bms55EUb4SS
         OojnmKcaces/XZ4kNimsquzXbg/LzNnIAnytYbiTWPzQiL3Q+/pZLbplk0+8jumTlYSY
         bODWJXXWc9TXPqj2+jyP5OYEvMWrF8JQ8CjWndNofLOlmj6i6m/Lf1OAgyINrdNnBEp8
         /fDkjVnumANTZytYGIPigitMxowbBy8ac62r1I4ALi5e2k13w1+Sm/o3/SjsPo/OPN27
         OH7KwTqtG0GMdN65x+eE9YgKsRKUFASBV8ws9Kk7yLaQjkbFrkUs6xgxIgW0ZLFbJV5M
         P/5w==
X-Gm-Message-State: AGi0PuZqNW4H0PW/uohxO7hYQxNA5bBDE5dZnJjMUJvwmY+VvbShv86o
        0Ha5+mMGiPYMRbB84fAz/GyUlPRxV0BJpZBWnUlyvQ==
X-Google-Smtp-Source: APiQypLCnx5iBY4mxdbtk29iHmVZ+VLcTq41ZYnT5fApK66c7DCSDwDCusSxYcaDfuerlo+1CJxlIg8cVCBKOZUZmGY=
X-Received: by 2002:ac2:4257:: with SMTP id m23mr3390896lfl.141.1588362395236;
 Fri, 01 May 2020 12:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <158812825316.168506.932540609191384366.stgit@magnolia>
In-Reply-To: <158812825316.168506.932540609191384366.stgit@magnolia>
From:   Jann Horn <jannh@google.com>
Date:   Fri, 1 May 2020 21:46:07 +0200
Message-ID: <CAG48ez0Fa6NSmO2a5kuzp6GCAXAXQtBzEDO+YcBL4BW105tF+w@mail.gmail.com>
Subject: Re: [PATCH RFC 00/18] xfs: atomic file updates
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 29, 2020 at 4:46 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
> This series creates a new log incompat feature and log intent items to
> track high level progress of swapping ranges of two files and finish
> interrupted work if the system goes down.  It then adds a new
> FISWAPRANGE ioctl so that userspace can access the atomic extent
> swapping feature.  With this feature, user programs will be able to
> update files atomically by opening an O_TMPFILE, reflinking the source
> file to it, making whatever updates they want to make, and then
> atomically swap the changed bits back to the source file.  It even has
> an optional ability to detect a changed source file and reject the
> update.
>
> The intent behind this new userspace functionality is to enable atomic
> rewrites of arbitrary parts of individual files.  For years, application
> programmers wanting to ensure the atomicity of a file update had to
> write the changes to a new file in the same directory, fsync the new
> file, rename the new file on top of the old filename, and then fsync the
> directory.  People get it wrong all the time, and $fs hacks abound.
>
> With atomic file updates, this is no longer necessary.  Programmers
> create an O_TMPFILE, optionally FICLONE the file contents into the
> temporary file, make whatever changes they want to the tempfile, and
> FISWAPRANGE the contents from the tempfile into the regular file.

That also requires the *readers* to be atomic though, right? Since now
the updates are visible to readers instantly, instead of only on the
next open()? If you used this to update /etc/passwd while someone else
is in the middle of reading it with a sequence of read() calls, there
would be fireworks...

I guess maybe the new API could also be wired up to ext4's
EXT4_IOC_MOVE_EXT somehow, provided that the caller specifies
FILE_SWAP_RANGE_NONATOMIC?
