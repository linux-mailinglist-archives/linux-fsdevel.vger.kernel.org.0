Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4DA2B596F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 06:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgKQFlw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 00:41:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbgKQFlv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 00:41:51 -0500
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF9FC0613CF;
        Mon, 16 Nov 2020 21:41:51 -0800 (PST)
Received: by mail-il1-x144.google.com with SMTP id y18so10240864ilp.13;
        Mon, 16 Nov 2020 21:41:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4uP0R4NMek+c9p+edkiMYaC2lOlHd67i9h4rSBZ4QGE=;
        b=YIt1jnPD4pcSqM6gNNrslEYZqoa3Wm8d4SYuvafhQWRR0bNNdIiBKkGFz3mLsZjiw3
         XovPQMcH1m2EZ7Cs+Ifs6YPdroHxMzwxd6nicwF11L1rxHiUCB493IJvdJMUpvaRNg3L
         8SOBy8NVKl1+teRICIP2SVo2B7+DXnZ5QwWE2TnEgcC8e4RYz+WMtXGuakpF/aH0AUKT
         C4lumr3ipiz1trXE3IfBHbbU4UcLYqF5/JhIhwERAnhoZm9Dwya/H2GN40jYyBdjOIxq
         sFjhQSc910VRZhYkcqG2vozEyh4S6oqbA5HAECeKOqkeQtOhJn3ZdeRSYKkY4ZYK0nU9
         AcJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4uP0R4NMek+c9p+edkiMYaC2lOlHd67i9h4rSBZ4QGE=;
        b=jo6z2G/8RwGv2MIrrh2oMOqiQksXJNAin1/zPrXGzUtZnkk15XsHBJjtS8kaz2tcRs
         hSGTUZd/1Q/8YCK226YWaZlI410VOXfzS7xMT4TzvI0BE71KMs9ptsODetvqKZ4H0HMW
         WOs6Ds0ydq0l4sqDlCwFHWs8pA27HqX2ztwjLR+VA6wFXn0GhALdEepvlEyxXpTsPTJO
         wjhpnGk3izAONv6rZEqDIun9buaY6LsadkXITxq5zbhvySTBGor6EwzzcKsOcfNpjZTH
         BcGp8yQZ9qzCA21zYSwv1HiTMh9A9DraxfRjklw5LTKOiVmq+hYa6xfjrnaTX4JbBxMR
         N0vA==
X-Gm-Message-State: AOAM5332m661LrPpnaT9XPO2chYyMRy6Vb3LxEaLz1R8A3E8z5Gn2eNP
        cu6wO4LcxI/KXVHpHFwOEqABD5ICmc71vak4/v4=
X-Google-Smtp-Source: ABdhPJw1PmowWRS71CiSsLwz4ShaMDnkL1iLcri2fbmdXbqb9K34Ui9UH2LpgeTnv8pCeUoaXqMwdOltuo6tw/feqtg=
X-Received: by 2002:a92:bac5:: with SMTP id t66mr11045762ill.250.1605591711122;
 Mon, 16 Nov 2020 21:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com> <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com> <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116212644.GE9190@redhat.com> <20201116221401.GA21744@ircssh-2.c.rugged-nimbus-611.internal>
In-Reply-To: <20201116221401.GA21744@ircssh-2.c.rugged-nimbus-611.internal>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Nov 2020 07:41:39 +0200
Message-ID: <CAOQ4uxijv8JiJzZ+Sxt8iXfZVbZvDNzK1PJRLexMAHnVdJEg=g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Vivek Goyal <vgoyal@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > > I think upper files data can "evaporate" even as the overlay is still mounted.
> >
> > I think assumption of volatile containers was that data will remain
> > valid as long as machine does not crash/shutdown. We missed the case
> > of possibility of writeback errors during those discussions.
> >
> > And if data can evaporate without anyway to know that somehthing
> > is gone wrong, I don't know how that's useful for applications.
> >
> > Also, first we need to fix the case of writeback error handling
> > for volatile containers while it is mounted before one tries to fix it
> > for writeback error detection during remount, IMHO.
> >
> > Thanks
> > Vivek
> >
>
> I feel like this is an infamous Linux problem, and lots[1][2][3][4] has been said
> on the topic, and there's not really a general purpose solution to it. I think that
> most filesystems offer a choice of "continue" or "fail-stop" (readonly), and if
> the upperdir lives on that filesystem, we will get the feedback from it.
>
> I can respin my patch with just the "boot id" and superblock ID check if folks
> are fine with that, and we can figure out how to resolve the writeback issues
> later.
>

On the contrary. Your code for error check is very valuable and more
important than the remount feature.

If you change ovl_should_sync() to check for error since mount and
return error in that case, which all callers will check, then I think you
fix the evaporating files issue and that needs to come first with
stable kernel backport IMO.

Thanks,
Amir.
