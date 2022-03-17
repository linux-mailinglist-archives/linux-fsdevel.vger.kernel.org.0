Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 942AA4DC9B3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 17 Mar 2022 16:15:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234642AbiCQPQV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 17 Mar 2022 11:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiCQPQU (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 17 Mar 2022 11:16:20 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A7B9A27CC
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:15:04 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id t8-20020a0568301e2800b005b235a56f2dso3683322otr.9
        for <linux-fsdevel@vger.kernel.org>; Thu, 17 Mar 2022 08:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xC2T+OefZFY6wWAOcAx3u6b32Cv58SvCNiW+CoTYh3I=;
        b=acS57g/omP0eqjJG8/hzjzk3RqlIa+oksj4x95Tjs8KUdvL134mhrP1vmypls/3ggh
         ULhU5hEBQYh74jkWhhEEkUYxI7fpUDdDDDIdrtgOEb8X52H3At7+C8rRuAbr32pw1mrZ
         pnZxKN6b+T/0qmGrTFL3zNvTRlkJ1unOa+aKJbGzO6CkqHlYS3dxEQRrMM6NozOvJypx
         FYHJleBT+rKKhWr96RHW+/NI/TnasigbCuzCDowrTunzoHlPYD0pSRAyQ1GFdWAF4Mu5
         7bk03hGD279z9JQfC8qAa4z5q9dcwxmuPO9hIiJdqBEmA8bSUJ2LJm23jlj6MduSm+8b
         1jng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xC2T+OefZFY6wWAOcAx3u6b32Cv58SvCNiW+CoTYh3I=;
        b=HHBUvS9E4VWJpHQlEwewAUrGu13IipgXQnzq6c88zdj3M2RlVgvUQkw3NDxmF/Rpxa
         NuDf+oWlkOrJP1Lkb30K4Ms+JrwLOOXdso3Mg5nJFXzrBU3WdUg0TenG90tuAccnNcTT
         i3iPcYbhexVRAk++vEnvNL8wh2nkUL/L4ywubthUOPgsAccNL86QGF+hyt3lT0s72rw6
         aU1rG3o/5lF1bU3nINYsOfRVeYr9IkJYUFHF6iPC2tJ70zUjYgJCNGJo1iZRNZlfVWjy
         JxSS4CTHUfDmPBnNVEI+TAiKpjs/hktV38FeT3S4g2DJkrBfVlm9TTpae6f+Hwb0x869
         TwIQ==
X-Gm-Message-State: AOAM532AW09NerFMzK65dfjGYKGPWZ+JKMtRk1Z//TW/tgBDrEyzwpX/
        IylOQ1Dwf6T72crH2c3yGMPAB94gzybVv3kE8ioCYC4L
X-Google-Smtp-Source: ABdhPJy1RiUaEL4E+xJP+dt5jOL4pb4J3l9ASwmFdh8SKx+KkEXCyIXVY1KZqmm9JbI4q/tmTTpO3pdD9VqLB2XTOE8=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr1721202oti.275.1647530103535; Thu, 17
 Mar 2022 08:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
In-Reply-To: <20220317141204.hbpflysc7p5e5vdo@quack3.lan>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 17 Mar 2022 17:14:52 +0200
Message-ID: <CAOQ4uxh2KuLk21530upP0VYWDrks1m++0jfk6RGqGVayNnEHcg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Volatile fanotify marks
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

On Thu, Mar 17, 2022 at 4:12 PM Jan Kara <jack@suse.cz> wrote:
>
> On Mon 07-03-22 17:57:36, Amir Goldstein wrote:
> > Jan,
> >
> > Following RFC discussion [1], following are the volatile mark patches.
> >
> > Tested both manually and with this LTP test [2].
> > I was struggling with this test for a while because drop caches
> > did not get rid of the un-pinned inode when test was run with
> > ext2 or ext4 on my test VM. With xfs, the test works fine for me,
> > but it may not work for everyone.
> >
> > Perhaps you have a suggestion for a better way to test inode eviction.
>
> Drop caches does not evict dirty inodes. The inode is likely dirty because
> you have chmodded it just before drop caches. So I think calling sync or
> syncfs before dropping caches should fix your problems with ext2 / ext4.  I
> suspect this has worked for XFS only because it does its private inode
> dirtiness tracking and keeps the inode behind VFS's back.

I did think of that and tried to fsync which did not help, but maybe
I messed it up somehow.

Thanks,
Amir.
