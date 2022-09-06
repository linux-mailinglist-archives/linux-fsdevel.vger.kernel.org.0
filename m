Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581195AE0F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  6 Sep 2022 09:24:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233252AbiIFHX6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 6 Sep 2022 03:23:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233137AbiIFHX5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 6 Sep 2022 03:23:57 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1BE374CCA
        for <linux-fsdevel@vger.kernel.org>; Tue,  6 Sep 2022 00:23:54 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id kk26so21119189ejc.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 06 Sep 2022 00:23:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fCMm+tIe4QoGv2l0sI7fXX55FP71013I9jvzVowoWew=;
        b=J8NCNt4VP6WdhwCQR+iTuOlw8Ozg5pPiDOiZjtbDRc/bSaAyZf53iLk6Wfgi3amAUB
         DJzq6KBsJm3npenOnAxxvckQyQvEMrJkdOxmxfIxvpUlnPvaElFZmU1XaDa53rZ8POve
         k9XBm7XGAS/UAw8934xwwu814abhMfszTmOqc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fCMm+tIe4QoGv2l0sI7fXX55FP71013I9jvzVowoWew=;
        b=CZJTaKciymWYFXe5O1slcvK3XQPygKge/uvVZCchbJAemmbnvw2fHRqKb0qNNn1v9y
         5ytdqvwnIP7WF5HwSe3973MlhySPK1d80hnDr8W8uyFy45jVLPWn6ZA+KvrDdya4yKrZ
         TFkuKyu9YB5feUHsJ3Cq1Jto/UOsec2vC/+hGVmEI/UMfNB+CstFQUGqbq6euI/xY/Zk
         ov2/6UlwWt4/y9odTjYPhZy+7F8aaHlisY7TW9gT8p6QnqMPbg+RIw0+F/ZZow3Jmymq
         MVBKdUeviJy4JsLX+9tjHizuslPT7NYstvcZpqKt40fXC0wLMc5WKainC8MBYBdDhWPl
         CdEw==
X-Gm-Message-State: ACgBeo34/jQHgAfbqiYAsn85Z+CH5y1qIwHTfsA8zz4gqrgFvF8oAj/F
        w7uXr1ft+CjDJzE8miwdYGkIHseoLUjB0KwIxE0U+w==
X-Google-Smtp-Source: AA6agR6cI9hzwD73tD3t6brkqelFh2f2THZg2BZEVqWWixfJZCk9Mw9Nv8a61cE6AX0TzIoymbULLCkNEuELDC9YWGA=
X-Received: by 2002:a17:907:1dd5:b0:73d:dc4a:6f60 with SMTP id
 og21-20020a1709071dd500b0073ddc4a6f60mr34664917ejc.255.1662449033382; Tue, 06
 Sep 2022 00:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com> <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
 <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com>
 <YxYbCt4/S4r2JHw2@miu.piliscsaba.redhat.com> <CAOQ4uxiK-nwpu8eNFByfHgfmEehMD9OEktjNF39ZY2v2NJMBmw@mail.gmail.com>
 <YxbauDXVcjD7oaiy@ZenIV>
In-Reply-To: <YxbauDXVcjD7oaiy@ZenIV>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 6 Sep 2022 09:23:42 +0200
Message-ID: <CAJfpegvk9uEGW1+hLBK7kmG=cm3pQKK5ogF-sqtVjbVwn4Ovmw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Yu-li Lin <yulilin@google.com>, chirantan@chromium.org,
        dgreid@chromium.org, fuse-devel <fuse-devel@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        suleiman@chromium.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 6 Sept 2022 at 07:29, Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Tue, Sep 06, 2022 at 07:58:50AM +0300, Amir Goldstein wrote:
> > On Mon, Sep 5, 2022 at 7:25 PM Miklos Szeredi <miklos@szeredi.hu> wrote:
> > >
> > > On Wed, Aug 31, 2022 at 02:30:40PM -0700, Yu-li Lin wrote:
> > > > Thanks for the reference. IIUC, the consensus is to make it atomic,
> > > > although there's no agreement on how it should be done. Does that mean
> > > > we should hold off on
> > > > this patch until atomic temp files are figured out higher in the stack
> > > > or do you have thoughts on how the fuse uapi should look like prior to
> > > > the vfs/refactoring decision?
> > >
> > > Here's a patch refactoring the tmpfile kapi to return an open file instead of a
> > > dentry.
> > >
> > > Comments?
> >
> > IDGI. Why did you need to place do_dentry_open() in all the implementations
> > and not inside vfs_tmpfile_new()?
> > Am I missing something?
>
>         The whole point of that horror is to have open done inside ->tmpfile()
> instances...
>
>         Al, very unhappy with proposed interface ;-/

So what does Al propose instead?

Thanks,
Miklos
