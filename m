Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1722F2D933B
	for <lists+linux-fsdevel@lfdr.de>; Mon, 14 Dec 2020 07:17:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgLNGPJ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 14 Dec 2020 01:15:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726389AbgLNGPJ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 14 Dec 2020 01:15:09 -0500
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC85C0613CF;
        Sun, 13 Dec 2020 22:14:28 -0800 (PST)
Received: by mail-lf1-x142.google.com with SMTP id a9so27229738lfh.2;
        Sun, 13 Dec 2020 22:14:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=JobrGTEzBRmqVBYkQ9rl3c0W2zJKqOwF2tb7YZ5F2Ws=;
        b=fn5ABMsVh9L+dBtfL52XkQ71KyhxPPAvO5sGIuui0uHPTxh8V6oo5p+lbJVf5xbk3K
         sV6uzbAWLwRxsxpM05aVz3PYt44B1b5Ri8zgWtzKmD/3PSrXpQwO3/VnpLFguf2QG+ot
         a0XXmNJNEXUPkgTWWQa2DfA5sfk+5SXg1VnE5ZPmUIzhIl3XPMvabWIRhqB5twWWJe+V
         ZlqavXHsA0DWWuS2joTf/S+RVYc59trRQqaGzvPswBzbCoD0ZX1Iaf0PdTvaEaY4zmdP
         Yx9VWbEjj4QyM83jSy9H5nJgyNB0aQqxCLRgAe2LJrJKXKuKxS6kE4E4lFS0aZDOPlcX
         Ec/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=JobrGTEzBRmqVBYkQ9rl3c0W2zJKqOwF2tb7YZ5F2Ws=;
        b=E/VyUcHq8zjuccj+cf25ItaJGN6IcueNlpJovyIUjFDTccEkIfrQaBrjIxyrMI6tRV
         PfpTm/SRpRXa5sUTDVlV2jat8yPl4kSRDYAeYs04KkAFgEt2AOOe1FInBF7B+FXaLdt3
         7MT3RFY4lbkTuT6cBcitnz7D2r1h9PfeFXmVuZ/D7Zo/HrjIbbAH8BUU8cWd3G9/a0tl
         lhDJ/4Vst2lW4jsihbMn6z4qrO0baDaI+CFwYL1KXQJqfAFLr08GYCOI5xLVoQsCtXMr
         LwCBELNvE51RT4YAWbwiDMryx5xMIsbX3YjoP23jqQUO5jdUYBQnjBvPWiPQGoCBuYCL
         IMYw==
X-Gm-Message-State: AOAM532FoF7N4xAyMEe77N7W6GeSkM6HvZbVPPHnTBgLJH1p4aBd0W8/
        SxNt0UHxGlz+wgQyEeGu396WYzNGvx4aZh91jkc=
X-Google-Smtp-Source: ABdhPJzyygVav6OSUvNJiKnxDOHGr0OuhMOqvE2x3sC+UhL+5dYVdRsuOFPpoR3ODdMxsrNj4Q1neb48I4jhwPeKJJk=
X-Received: by 2002:a2e:2202:: with SMTP id i2mr7243263lji.306.1607926466829;
 Sun, 13 Dec 2020 22:14:26 -0800 (PST)
MIME-Version: 1.0
References: <159237905950.89469.6559073274338175600.stgit@mickey.themaw.net>
 <20201210164423.9084-1-foxhlchen@gmail.com> <822f02508d495ee7398450774eb13e5116ec82ac.camel@themaw.net>
 <13e21e4c9a5841243c8d130cf9324f6cfc4dc2e1.camel@themaw.net> <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
In-Reply-To: <bde0b6c32f2b055c1ad1401b45c4adf61aab6876.camel@themaw.net>
From:   Fox Chen <foxhlchen@gmail.com>
Date:   Mon, 14 Dec 2020 14:14:13 +0800
Message-ID: <CAC2o3DJdHuQxY7Rn5uXUprS7i8ri1qB=wOUM2rdZkWt4yJHv1w@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] kernfs: proposed locking and concurrency improvement
To:     Ian Kent <raven@themaw.net>
Cc:     akpm@linux-foundation.org, dhowells@redhat.com,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        miklos@szeredi.hu, ricklind@linux.vnet.ibm.com,
        sfr@canb.auug.org.au, Tejun Heo <tj@kernel.org>,
        viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Dec 13, 2020 at 11:46 AM Ian Kent <raven@themaw.net> wrote:
>
> On Fri, 2020-12-11 at 10:17 +0800, Ian Kent wrote:
> > On Fri, 2020-12-11 at 10:01 +0800, Ian Kent wrote:
> > > > For the patches, there is a mutex_lock in kn->attr_mutex, as
> > > > Tejun
> > > > mentioned here
> > > > (https://lore.kernel.org/lkml/X8fe0cmu+aq1gi7O@mtj.duckdns.org/),
> > > > maybe a global
> > > > rwsem for kn->iattr will be better??
> > >
> > > I wasn't sure about that, IIRC a spin lock could be used around the
> > > initial check and checked again at the end which would probably
> > > have
> > > been much faster but much less conservative and a bit more ugly so
> > > I just went the conservative path since there was so much change
> > > already.
> >
> > Sorry, I hadn't looked at Tejun's reply yet and TBH didn't remember
> > it.
> >
> > Based on what Tejun said it sounds like that needs work.
>
> Those attribute handling patches were meant to allow taking the rw
> sem read lock instead of the write lock for kernfs_refresh_inode()
> updates, with the added locking to protect the inode attributes
> update since it's called from the VFS both with and without the
> inode lock.

Oh, understood. I was asking also because lock on kn->attr_mutex drags
concurrent performance.

> Looking around it looks like kernfs_iattrs() is called from multiple
> places without a node database lock at all.
>
> I'm thinking that, to keep my proposed change straight forward
> and on topic, I should just leave kernfs_refresh_inode() taking
> the node db write lock for now and consider the attributes handling
> as a separate change. Once that's done we could reconsider what's
> needed to use the node db read lock in kernfs_refresh_inode().

You meant taking write lock of kernfs_rwsem for kernfs_refresh_inode()??
It may be a lot slower in my benchmark, let me test it.

> It will reduce the effectiveness of the series but it would make
> this change much more complicated, and is somewhat off-topic, and
> could hamper the chances of reviewers spotting problem with it.
>
> Ian
>


thanks,
fox
