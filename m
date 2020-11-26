Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A137A2C5346
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 Nov 2020 12:50:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgKZLuU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 Nov 2020 06:50:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732480AbgKZLuT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 Nov 2020 06:50:19 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1666C0613D4
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2020 03:50:19 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id j23so1500471iog.6
        for <linux-fsdevel@vger.kernel.org>; Thu, 26 Nov 2020 03:50:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KgWVgN9KE1ZQRSgz4cfardTeeI5G9unOOIo8bsBxZ4w=;
        b=nx41fQaWoWpFu6AReyi2LH2KSYSLgUctlb4SivrZqlaTqz/5kP+YEDu5HhtWGj3kn6
         sJANTv3ZocxFtvIWScKpnXYBIJWbmHfakj96nQX1xeiXsD0z0jtlfh1ganRbpc80u5sn
         RvQABRjJPR/5aK6Oduo3XAVKbxf5UyQHQsuiM+o4Z119RLJsFoVeexeSCilHj1qT/T5B
         C6AgSCJAhMCA7qZb3LEKHCHHpAfksI3allZ7AwoElgN4BCWQoaOQ9WqeqHH11DgMymcP
         j6Q71ySzcKtumwiFVWMo1fNQblXdrW2SRspd4k1bQuM/5bIGLAYaLyp7rI5p5dZQVbRN
         0yzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KgWVgN9KE1ZQRSgz4cfardTeeI5G9unOOIo8bsBxZ4w=;
        b=eNMw3p8FO8qEjGCSVTm8BeTne5wP1srvU/CRljkZGHYlpGv7qfFv6IUYxPeGYSDMu1
         mApbptIhnzDfuUW6gtOm+KlpnWq0NNxJl+SRoAMyaksu25StySlniIWnV1tWb0FX4qG2
         x5QRgZrnpf8C9oGD+lZlCtzcLUG6lJ19coN7V6EJ3q70dA8R812By/kagQQRI63hW/6H
         JfpxYWRicRL3miEH+5yfI85ITXF+JgvfUPUQqLdzQEm0X4sj0vVW7DZ/2U63HNkR6K/b
         Rt5LAJ7XRvppCs6IE7T/JuCNTUjOfcH+KCgE04MUhHWGMfnEugnCkX/xeTbg+9z28x8g
         heLQ==
X-Gm-Message-State: AOAM532+ctpMvlUki+56nK3jOXBHlZqp2G22K2Us23ArFTUGqbkLzpLD
        N5rPS4JRlHglUx7UwqHbMJFKCBEUGzF6hiBYBMynaLWuq3E=
X-Google-Smtp-Source: ABdhPJzoGAyydPyYU7aa4sQNt2LWcD7u+8rBCzBY2se47im2CGqZYoG0teDCbKAaMRtnSWDtmrrWxFVs84o9X0wMdWg=
X-Received: by 2002:a6b:6d10:: with SMTP id a16mr1774594iod.186.1606391418089;
 Thu, 26 Nov 2020 03:50:18 -0800 (PST)
MIME-Version: 1.0
References: <20201109180016.80059-1-amir73il@gmail.com> <20201124134916.GC19336@quack2.suse.cz>
 <CAOQ4uxiJz-j8GA7kMYRTGMmE9SFXCQ-xZxidOU1GzjAN33Txdg@mail.gmail.com>
 <20201125110156.GB16944@quack2.suse.cz> <CAOQ4uxiaaQ9X8EBS-bd2DNMdg7ezNoRXCRvu+4idikx67OFbQQ@mail.gmail.com>
 <20201126111036.GC422@quack2.suse.cz>
In-Reply-To: <20201126111036.GC422@quack2.suse.cz>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 26 Nov 2020 13:50:06 +0200
Message-ID: <CAOQ4uxgtw14=CsYLYniDzrOjWKj3RKqWREW-9NO55Z6JMr8RJw@mail.gmail.com>
Subject: Re: [RFC][PATCH] fanotify: introduce filesystem view mark
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Nov 26, 2020 at 1:10 PM Jan Kara <jack@suse.cz> wrote:
>
> On Wed 25-11-20 14:34:16, Amir Goldstein wrote:
> > On Wed, Nov 25, 2020 at 1:01 PM Jan Kara <jack@suse.cz> wrote:
> > > In fact I was considering for a while that we could even make subtree
> > > watches completely unpriviledged - when we walk the dir tree anyway, we
> > > could also check permissions along the way. Due to locking this would be
> > > difficult to do when generating the event but it might be actually doable
> > > if we perform the permission check when reporting the event to userspace.
> > > Just a food for thought...
> >
> > Maybe... but there are some other advantages to restricting to mount.
> >
> > One is that with btrfs subvolumes conn->fsid can actually cache the
> > subvolume's fsid and we could remove the restriction of -EXDEV
> > error of FAN_MARK_FILESYSTEM on subvolume.
>
> I'm not sure I understand this - do you mean we could support
> FAN_MARK_FILESYSTEM_SUBTREE on btrfs subvolumes? I agree with that. I'm

Yes, that's what I meant.

> just not sure how subtree watches are related to general
> FAN_MARK_FILESYSTEM marks on btrfs...
>

I thought that it would solve the ambiguity issue with btrfs fsid
(it differs for objects inside a subvolume), because conn->fsid
of subtree would cache the subvolume's fsid, but if there are both
a filesystem mark and subtree mark on a subvolume, that would
result in ambiguity again, so we are still not out of the woods.

If this hand waving wasn't clear, don't worry about it.
I will think about it some more and document the issue in my next post.

Thanks,
Amir.
