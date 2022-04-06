Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 038214F6A5C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  6 Apr 2022 21:48:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbiDFTui (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Apr 2022 15:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbiDFTuS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Apr 2022 15:50:18 -0400
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E151E204C9D
        for <linux-fsdevel@vger.kernel.org>; Wed,  6 Apr 2022 11:20:07 -0700 (PDT)
Received: by mail-qt1-x831.google.com with SMTP id b18so5742343qtk.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 06 Apr 2022 11:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OVp1Ag8qfAV7bBRweGxdipTWZh1bEEMVzQia0AMttME=;
        b=I5vuNPse3UG1t8+bKW+RA8GbnNV9odjBI/GhrYZqfKP8dXNImisLRLd9jx40mVmiNl
         saYeBSgeI9ZBEHlKseXKkPv/FHm45LhomT/v41Hf/IpWNo3vcSIOQKsO7AKHTtaf3e1r
         llBLDXSCOG8c42aeXgS9XaCVLPhd0aEf3FnlDas33PsnpT6+kpoy1tIb6nUF8xBlESMv
         7719CQ5CIHtp3rHQ0FbotvYDto1Z0Vh3ej4v1ZMuPCWjN3G8p96qdjxdDvdJPAFNTo6L
         BNyLbIIFcLlryzYpe0SumkouXAW9b8wfUf8vKSHLzVwAaT9BzKd1qKkmuq3ClQ5TPHLU
         rm9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OVp1Ag8qfAV7bBRweGxdipTWZh1bEEMVzQia0AMttME=;
        b=64SrvGrpnHBgZtdFJAvyKQpIWeuWj9TGmo+GChTeB5r93ubwCvKPr45phCAkTg/Jt7
         8JpXqp1GHjbbAJ9eE6BJGQKYqS7FLZyLLeUiJu7nVZVBUIZL8TUW3yuTDc24TqbciVHJ
         5XWoZP1Jk0EsqniC91K6bkqoiCXlJyidAWuBOWOy23XBxquIc5gyCA2olkvUS5nnKRnj
         7bC5PZ1f1Tfc4Ty50uO0caAlz6l4nI0tTB9RCpgljjGi63j5Z1HGdIeK2u1XB9BELBtF
         3y92JqIlrknGh2Kz7ovfTGC15zC6iuHJCHDIgHAntZ74HylsD5cJgRnIFTh8JmmO5m/8
         nQoQ==
X-Gm-Message-State: AOAM530gZ3ic4StFBDEM0twhyMSTpjaWqTkS2KVe+2LQxeZrnzh4c25Y
        MOcHOiSvtVNPvx7NUdAlvaz0X4zkzPcO2kkjd9c5c1wt
X-Google-Smtp-Source: ABdhPJx2OaRQ56ZcnkTjb7moLYCQ51OJ6ivutXfQ7pmHXnZ+bZZui/mPTX7hfOt5opRBjoJrq0+fm+/0TwLLjCCEx6k=
X-Received: by 2002:ac8:5dcb:0:b0:2e1:ce48:c186 with SMTP id
 e11-20020ac85dcb000000b002e1ce48c186mr8669576qtx.2.1649269206031; Wed, 06 Apr
 2022 11:20:06 -0700 (PDT)
MIME-Version: 1.0
References: <20220329074904.2980320-1-amir73il@gmail.com> <20220329074904.2980320-5-amir73il@gmail.com>
 <20220405125407.qn6ac5e3bpr5is6h@quack3.lan> <CAOQ4uxh3XvBnXs0d71Uk_6Df3_d4kP97sdLqpkHUu2AP32of2A@mail.gmail.com>
 <20220406174747.da3qwn7sicplcem4@quack3.lan>
In-Reply-To: <20220406174747.da3qwn7sicplcem4@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 6 Apr 2022 21:19:54 +0300
Message-ID: <CAOQ4uxi5TEwjbqFTW39JdGQr_GfVPp6WUWLL=hGF=FAofKz1LA@mail.gmail.com>
Subject: Re: [PATCH v2 04/16] fsnotify: remove unneeded refcounts of s_fsnotify_connectors
To:     Jan Kara <jack@suse.cz>
Cc:     Matthew Bobrowski <mbobrowski@mbobrowski.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 6, 2022 at 8:47 PM Jan Kara <jack@suse.cz> wrote:
>
> On Tue 05-04-22 16:09:00, Amir Goldstein wrote:
> > On Tue, Apr 5, 2022 at 3:54 PM Jan Kara <jack@suse.cz> wrote:
> > >
> > > On Tue 29-03-22 10:48:52, Amir Goldstein wrote:
> > > > s_fsnotify_connectors is elevated for every inode mark in addition to
> > > > the refcount already taken by the inode connector.
> > > >
> > > > This is a relic from s_fsnotify_inode_refs pre connector era.
> > > > Remove those unneeded recounts.
> > > >
> > > > Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> > >
> > > I disagree it is a relict. fsnotify_sb_delete() relies on
> > > s_fsnotify_connectors to wait for all connectors to be properly torn down
> > > on unmount so that we don't get "Busy inodes after unmount" error messages
> > > (and use-after-free issues). Am I missing something?
> > >
> >
> > I meant it is a relic from the time before s_fsnotify_inode_refs became
> > s_fsnotify_connectors.
> >
> > Nowadays, one s_fsnotify_connectors refcount per connector is enough.
> > No need for one refcount per inode.
> >
> > Open code the the sequence:
> >     if (inode)
> >         fsnotify_put_inode_ref(inode);
> >     fsnotify_put_sb_connectors(conn);
> >
> > To see how silly it is.
>
> I see your point and I agree the general direction makes sense but
> technically I think your patch is buggy. Because notice that we do
> fsnotify_put_sb_connectors() in fsnotify_detach_connector_from_object() so
> after this call there's nothing blocking umount while we can be still
> holding inode references from some marks attached to this connector. So
> racing inode mark destruction & umount can lead to "Busy inodes after
> umount" messages.
>

Yes, I see it now.
IIRC, it was just a cleanup patch, I can remove it and amend the rest
of the series.

Thanks,
Amir.
