Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D975A8822
	for <lists+linux-fsdevel@lfdr.de>; Wed, 31 Aug 2022 23:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232362AbiHaVa5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 31 Aug 2022 17:30:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232210AbiHaVa4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 31 Aug 2022 17:30:56 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F7FD5DD7
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 14:30:53 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id n23-20020a7bc5d7000000b003a62f19b453so272907wmk.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 31 Aug 2022 14:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=37R8vxBQ0cmjbyUqy1T5CHmyf9iLIL9y29CN8kqvRjY=;
        b=RUmFe2PKruhmCwF+rZlM5G7tAZ2DjjoPTzVT/v7GrYicufFrGCgZKVUdqBgrVuZJaH
         NgRA3ZqBkW0eeD6Hv2bnQhnMl+ranPQXp5fMy+Y8z9fxJPnK227PwFhUkggSMEA203iw
         uQCPAoHhyG8b4empiun/zzXsnmkLEwv8Di2rpeKQ4m6pXIYuT1mmmXR6n/t9pTJc7cCh
         deBFnOUbtDbPrT/YtY66ypWHYgHKtVUlzoRd94cRHbNntKaVTF3wL5oqzBJQ2rPr/jbQ
         NnnNYYwC13Ujxik5P+ynnJvQuuc/3Ng+y1gfBSxq0g0/XaF5R5Ig8QwYLnmcMsOErsyw
         5phA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=37R8vxBQ0cmjbyUqy1T5CHmyf9iLIL9y29CN8kqvRjY=;
        b=KG0aQk8GnfTU/o8vLQyuCGwHPmZaizIz9tc4UFLrTdmSuK/V2S/qBnMQC2H6fjT10s
         g1CKKh45vC8/CoZaDQbYHnvDB8Zd4Q5eOfNrjSwTYwhTX4Ce5nmzQKoOSf4hJN0sxTVE
         xAoLMBoWrTHDKbHJwyvpq+l7bCFj0W9seuGp81d3Q33PL2vk/wl1cSsoZ3yk0gDvo/5y
         mvk/vDq23gg+c9fUahrTKJgXVfVGMXhHNrM80co3mERU1qBRLrf8F3ePwhthMq3RP5F4
         KrCDQEPj5x4Q/NkXZ9nPtFm41+hTDJgjl4EPU8u2N2YFVyEU0EgwKQw9ytJLNlytEi+N
         B2uw==
X-Gm-Message-State: ACgBeo3E5nFJXT/aUBiCFId20DnKes7xxfqyYgHsTOSxKFBe+Q65LXw0
        /UzShlAdqpeub0ssg+BVtvm+EsM2tT8/SffD46gC
X-Google-Smtp-Source: AA6agR5cUAq4Bi7LhJmifYDNiIhM3oDe3pGElvvl2Oyv4cyh+nGsXId3G0rhZ4Tm5xrXNSj2O/ynuDS0QBn+qrcMW68=
X-Received: by 2002:a05:600c:b47:b0:3a5:a431:ce36 with SMTP id
 k7-20020a05600c0b4700b003a5a431ce36mr3206663wmr.89.1661981452020; Wed, 31 Aug
 2022 14:30:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAJfpegvsCQ+rJv2rSk3mUMsX_N26ardW=MYbHxifO5DU7uSYqA@mail.gmail.com>
 <20220831025704.240962-1-yulilin@google.com> <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
In-Reply-To: <CAJfpegvMGxigBe=3tgwBRKuSS0H1ey=0WhOkgOz5di-LqXH-HQ@mail.gmail.com>
From:   Yu-li Lin <yulilin@google.com>
Date:   Wed, 31 Aug 2022 14:30:40 -0700
Message-ID: <CAMW0D+epkBMTEzzJhkX7HeEepCH=yxJ-rytnA+XWQ8ao=CREqw@mail.gmail.com>
Subject: Re: [PATCH 2/2] fuse: Implement O_TMPFILE support
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     chirantan@chromium.org, dgreid@chromium.org,
        fuse-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org,
        suleiman@chromium.org, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 31, 2022 at 5:20 AM Miklos Szeredi <miklos@szeredi.hu> wrote:
>
> Ref: https://lwn.net/Articles/896153/
>
> On Wed, 31 Aug 2022 at 04:57, Yu-Li Lin <yulilin@google.com> wrote:
> >
> > On Fri, Nov 13, 2020 at 2:54:46PM +0100, Miklos Szeredi wrote:
> > >
> > > On Fri, Nov 13, 2020 at 1:28 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
> > > >
> > > > On Fri, Nov 13, 2020 at 11:52:09AM +0100, Miklos Szeredi wrote:
> > > >
> > > > > It's the wrong interface, and we'll have to live with it forever if we
> > > > > go this route.
> > > > >
> > > > > Better get the interface right and *then* think about the
> > > > > implementation.  I don't think adding ->atomic_tmpfile() would be that
> > > > > of a big deal, and likely other distributed fs would start using it in
> > > > > the future.
> > > >
> > > > Let me think about it; I'm very unhappy with the amount of surgery it has
> > > > taken to somewhat sanitize the results of ->atomic_open() introduction, so
> > > > I'd prefer to do it reasonably clean or not at all.
> > >
> > > The minimal VFS change for fuse to be able to do tmpfile with one
> > > request would be to pass open_flags to ->tmpfile().  That way the
> > > private data for the open file would need to be temporarily stored in
> > > the inode and ->open() would just pick it up from there without
> > > sending another request.  Not the cleanest, but I really don't care as
> > > long as the public interface is the right one.
> > >
> > > Thanks,
> > > Miklos
> >
> > Resurrecting this old thread. Is there a conclusion on the addition of atomic_tmpfil() or vfs changes?
> >
> > Thanks,
> > Yu-Li Lin

Thanks for the reference. IIUC, the consensus is to make it atomic,
although there's no agreement on how it should be done. Does that mean
we should hold off on
this patch until atomic temp files are figured out higher in the stack
or do you have thoughts on how the fuse uapi should look like prior to
the vfs/refactoring decision?
