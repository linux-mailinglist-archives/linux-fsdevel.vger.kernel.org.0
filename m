Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BDE4363D28
	for <lists+linux-fsdevel@lfdr.de>; Mon, 19 Apr 2021 10:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232068AbhDSIJQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 19 Apr 2021 04:09:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbhDSIJJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 19 Apr 2021 04:09:09 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44520C061760
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 01:08:40 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id h141so25583517iof.2
        for <linux-fsdevel@vger.kernel.org>; Mon, 19 Apr 2021 01:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fyKhgAXj4hNTxi3/yHVWm38x4d1bt7gbcnetTkznk0s=;
        b=gd1wpGGpnpcq1O1cvFKPBk/QflEq3Xy4tZxpGTSqNnlRSNK9hypM32HUpFW22kbusT
         a9xXYKcrUA5URlc1eU/Tv+TpSeVArq8Nc5zRQM9MqYGr1fSBIlk7Nz/jqFtIWWmc9vO2
         y+5W2GIIK6I478foMUjQ27SMd5euqIkr1/Vq12S6KbMRqx9DIJxSWZKpJdaMS8NNSJmH
         jH7YaPu3DXiX6CMldATZXZ4OTMZ3Rf2kHmQf4ZrDgts1y+99kVPEQaBTidCUWIOEjyR9
         /clCz0NjDZKYlGwlSQOX8ekpfBz0raBQ7GP+Z4XJfjybthpyY2pKQ1+dNkak5XcTgGzw
         POvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fyKhgAXj4hNTxi3/yHVWm38x4d1bt7gbcnetTkznk0s=;
        b=d/Oehp2nMzn0MTTi1GWAuiS88frzmmZlQOuUYT3La79RepH38Rp24J3c4b/EkiqiHb
         Llm77JTjv5aZawmv/HKNW3oqJtUFUw6sMjJurnx5S6sl1ByoW48DNGgJss7eP1ek87KC
         jgFXwuO+ARMXZMlsnr9av3QzWtB/vS46cLyEFyAdwKaLUMdQh6JrmMKCud+07ju+Tn11
         IFw/wUJC8bm3q59JqdVapEFidO3o51MTqTd3ItAMZbGPpjNErWUYvEubgq6WLp3CObNu
         yYf1NFOdO665qXNunrH1PKuqVz7yNujd8PRr0MwZfN+OJIDbOm/IsvtIlfg6eA5MMz5f
         R37Q==
X-Gm-Message-State: AOAM530tr63pk9yOdvoVqZRkxmAziDolU/U9RO6bZXEAM0SBp4H9kkYZ
        gyqTQl2Bv+jIuYNU3kqwC296ZFJ9v6Zbxw66G/Fna30HOO8=
X-Google-Smtp-Source: ABdhPJyHbsKS0GQS3lPwvOvRv8RsRKgg2pe3pmOWbkubfzYOdCvdE1cuBycbZXZpuRY5af6v/HbW9mWAGkKmkAw/DJA=
X-Received: by 2002:a6b:d309:: with SMTP id s9mr13419837iob.186.1618819719639;
 Mon, 19 Apr 2021 01:08:39 -0700 (PDT)
MIME-Version: 1.0
References: <20210331094604.xxbjl3krhqtwcaup@wittgenstein> <CAOQ4uxirud-+ot0kZ=8qaicvjEM5w1scAeoLP_-HzQx+LwihHw@mail.gmail.com>
 <20210331125412.GI30749@quack2.suse.cz> <CAOQ4uxjOyuvpJ7Tv3cGmv+ek7+z9BJBF4sK_-OLxwePUrHERUg@mail.gmail.com>
 <CAOQ4uxhWE9JGOZ_jN9_RT5EkACdNWXOryRsm6Wg_zkaDNDSjsA@mail.gmail.com>
 <20210401102947.GA29690@quack2.suse.cz> <CAOQ4uxjHFkRVTY5iyTSpb0R5R6j-j=8+Htpu2hgMAz9MTci-HQ@mail.gmail.com>
 <CAOQ4uxjS56hjaXeTUdce2gJT3tTFb2Zs1_PiUJZzXF9i-SPGkw@mail.gmail.com>
 <20210408125258.GB3271@quack2.suse.cz> <CAOQ4uxhrvKkK3RZRoGTojpyiyVmQpLWknYiKs8iN=Uq+mhOvsg@mail.gmail.com>
 <20210409100811.GA20833@quack2.suse.cz> <CAOQ4uxhhGsMzZOYnmw5xuz0jXPUtq0Li9hm9+bUiVTmeRxmUug@mail.gmail.com>
In-Reply-To: <CAOQ4uxhhGsMzZOYnmw5xuz0jXPUtq0Li9hm9+bUiVTmeRxmUug@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 19 Apr 2021 11:08:28 +0300
Message-ID: <CAOQ4uxiq=-MUBmKFyTbbSOp2YpWnVTUaGMr2hR7Z8EZgZgZa5Q@mail.gmail.com>
Subject: Re: fsnotify path hooks
To:     Jan Kara <jack@suse.cz>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > How do you propose to change fsnotify hooks in vfs_create()?
> >
> > So either pass 'mnt' to vfs_create() - as we discussed, this may be
> > actually acceptable these days due to idmapped mounts work - and generate
> > all events there, or make vfs_create() not generate any fsnotify events and
> > create new vfs_create_notify() which will take the 'mnt' and generate
> > events. Either is fine with me and more consistent than what you currently
> > propose. Thoughts?
> >
>
> Jan,
>
> I started to go down the vfs_create_notify() path and I guess it's looking
> not too bad (?). Pushed WIP to branch fsnotify_path_hooks-wip.
>
> I hit another bump though.  By getting fsnotify_{unlink,rmdir}() outside of the
> vfs helpers, we break the rule:
>
>         /* Expected to be called before d_delete() */
>         WARN_ON_ONCE(d_is_negative(dentry));
>
> I'm not sure how to solve this without passing mnt into the vfs helpers.
>

Nevermind, I figured it out.
Created a helper fsnotify_delete() that allows a negative dentry
and takes a separate victim inode arg.
fsnotify_{unlink,rmdir}_notify() take care of holding the reference to
the victim inode.

I also realized that passing mnt to fsnotify() as path data arg
is limiting and over complicating, so passing it as a separate arg.
Packed all args to fsnotify() in struct fsnotify_event_info.

Pushed what I have so far to fsnotify_path_hooks-wip.

Thanks,
Amir.
