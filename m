Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A8D75A742F
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 04:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232030AbiHaC5M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Aug 2022 22:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230218AbiHaC5L (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Aug 2022 22:57:11 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F209E88B
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 19:57:07 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id v8-20020a258488000000b00695847496a4so1216183ybk.19
        for <linux-fsdevel@vger.kernel.org>; Tue, 30 Aug 2022 19:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date;
        bh=8FrBXY+zg+jV8MmECIX2EFWcdrJIkEQxUnqfTJ8H2hs=;
        b=js3TmGI1BmpgZB7D7sbvUqEmy2DtKctbi0AKTZ9LgOqFjBQfyrXBSyiiD68ymi4ZEn
         syK2DWmC1b5vALNo+yLIIoBSTYLkQqZLrCgzsOlHx/dZ/E/u1WIbp4iL/blS6OcPLW50
         GCVX82B9/6n/lyv8mT4oBscBPlHqp7bBNJiCzIhoLz+ajfhLtEkaCZQ6jQjEmGRlL1bB
         XOCqf9iEcty223OLWszclEg3SeuGOJtX+SSW3Kt/oae8ece4sZkX5Yi7KRttORXup0QQ
         m5USdtVMwNNWjXR6TeTIzoFyD+ck3nAFYzyF6Ay+2TWVYPZw5vNIuF5OsOu4PC/N0PHn
         w0DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date;
        bh=8FrBXY+zg+jV8MmECIX2EFWcdrJIkEQxUnqfTJ8H2hs=;
        b=WaraIMqvdQHoSrMJAX0MbBHki86CKqv4YF5P6CbdgNTscJSSGNWgOQLdDQ2ShNJMbF
         1MJQRiIu0V5gPBMY3LT3URW55l3trZsEoIg86H9yrB+Zgoz7ud7l/Nr3cDW1RxNZYRkR
         Fnrvq+GjYneVOSTadHSy08m9IzzGxnw/tCTyxQNjai6siZ3wfulX14iBfz1YWFyNLlng
         XvZfdbaDHKDN6SPcw5qZGLFQKSf/g6C8NAzhnhEla10AOV8FFL0cFrK8wuaHgQaiXRij
         /3+IZsQs3xS7jzxBFErhoQNf7Hl/i4HF+T5fhW7jcvllkVryqxydhlD+S48fdGl7/1BP
         6Zsw==
X-Gm-Message-State: ACgBeo2ek5xsRVuH9q/xjCoLNCiCe/2Zwvi9kkALgXxPGGq8GVHiY6Vn
        5IJkFj7++Nh0R6k6lRlxFZwSjqyhcOQ=
X-Google-Smtp-Source: AA6agR7fomxkc7idv6/8JFNvqhFuydMbLPfLAA1cBmNsn/WqgTXwYJlmsELiiCGdAEtDcgbAHoglICO3sUPX
X-Received: from yulilin9101948.lax.corp.google.com ([2620:0:102f:15:101b:bf9e:ac90:81e4])
 (user=yulilin job=sendgmr) by 2002:a81:7286:0:b0:32a:c39d:3237 with SMTP id
 n128-20020a817286000000b0032ac39d3237mr15547801ywc.503.1661914626624; Tue, 30
 Aug 2022 19:57:06 -0700 (PDT)
Date:   Tue, 30 Aug 2022 19:57:04 -0700
In-Reply-To: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
Mime-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
X-Mailer: git-send-email 2.37.2.672.g94769d06f0-goog
Message-ID: <20220831025704.240962-1-yulilin@google.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
From:   Yu-Li Lin <yulilin@google.com>
To:     miklos@szeredi.hu
Cc:     chirantan@chromium.org, dgreid@chromium.org,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        suleiman@chromium.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Nov 13, 2020 at 2:54:46PM +0100, Miklos Szeredi wrote:
>
> On Fri, Nov 13, 2020 at 1:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> >
> > On Fri, Nov 13, 2020 at 11:52:09AM +0100, Miklos Szeredi wrote:
> >
> > > It's the wrong interface, and we'll have to live with it forever if we
> > > go this route.
> > >
> > > Better get the interface right and *then* think about the
> > > implementation.  I don't think adding ->atomic_tmpfile() would be that
> > > of a big deal, and likely other distributed fs would start using it in
> > > the future.
> >
> > Let me think about it; I'm very unhappy with the amount of surgery it has
> > taken to somewhat sanitize the results of ->atomic_open() introduction, so
> > I'd prefer to do it reasonably clean or not at all.
>
> The minimal VFS change for fuse to be able to do tmpfile with one
> request would be to pass open_flags to ->tmpfile().  That way the
> private data for the open file would need to be temporarily stored in
> the inode and ->open() would just pick it up from there without
> sending another request.  Not the cleanest, but I really don't care as
> long as the public interface is the right one.
>
> Thanks,
> Miklos

Resurrecting this old thread. Is there a conclusion on the addition of atomic_tmpfil() or vfs changes?

Thanks,
Yu-Li Lin
