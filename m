Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDCE04E1BC5
	for <lists+linux-fsdevel@lfdr.de>; Sun, 20 Mar 2022 14:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245113AbiCTNCC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 20 Mar 2022 09:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235848AbiCTNCB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 20 Mar 2022 09:02:01 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14A654B844
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 06:00:39 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id e25-20020a0568301e5900b005b236d5d74fso8898468otj.0
        for <linux-fsdevel@vger.kernel.org>; Sun, 20 Mar 2022 06:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Z64TnHAXth2Q+YHvDxO37JZgeHRVouUHm272HjvkenY=;
        b=giWQ8aBoGVT3idIy3u/If2kfJsnLqwkMYzV4afaeM8WgOdrrSMtjetmk9KpZaBFu7F
         0YYLAd/onm4pV4Vff7BSI5QvBgR5kvY0WPYyTpiR6UCDLUkQH0fFn93GU8iND633+Qfm
         fjbLHKvM944l/P0Nnka/IKs1OLBlwBzSfYIKdabqZIKlX7aSw1xRByvpJiyP3UZotG5v
         ijCDHd3R5UGGAZq+z9UtGAHErgOuVNtyEMDWeRaXetqAXkCk4ds8psprNkWyaRkbpQ1k
         Jct3rE/OWdq954laPXaPJPTM+ZOgEm3UGQQX/zWuuyYQ59r8FX86EDMvwZtyAZ3LPPDH
         yb0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Z64TnHAXth2Q+YHvDxO37JZgeHRVouUHm272HjvkenY=;
        b=JfTCW3O3p1Ve3T3r0wDMYFGCI1r7WWds5plDzGTUsatXI2y1agHEo4cf9A4faWdbGm
         E0EGHhqdrK4jNlGldiqK1qhuX3Y8iPa12uN+84ywXABmCYBu+o5ZqOCj6ShuX5SST+Pr
         fX+BoTPSspmoV3bY/y1SN0wuBcgJ7dBSu2O8AErRsdo79ufCcRLU8wgfSy594x2S7kdH
         H+/EeXQanKeZery6MzgzzeyS8+ySLctyLSTXZH/7Aw8l/b4TsnvSeyHFC++sDdXfyBTJ
         +/74PzdErW99dYt78YeAFi5/5OuapuqbUZu5BSwgi8RBY2SczhbpTMMAy9Kh9pxaTy8O
         4Jrg==
X-Gm-Message-State: AOAM530jJOXLSvALHJQ3fo66oT7h3VRLxli1EMruzfuxpdAjvsirlUZs
        iUffcBAMylA4WVfAE2spUHncRfTaY2ZuMuCRrWqcwbr2S4M=
X-Google-Smtp-Source: ABdhPJxmkOK06N36mgm0tDaoEgZrbGZdCewZ5jIey2iLbp2UbJUtGcSL8Ax5/52cwG6rXn5PliefaSynotFmWW4GvMY=
X-Received: by 2002:a9d:5cc8:0:b0:5b2:35ae:7ad6 with SMTP id
 r8-20020a9d5cc8000000b005b235ae7ad6mr6195406oti.275.1647781236834; Sun, 20
 Mar 2022 06:00:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220307155741.1352405-1-amir73il@gmail.com> <20220307155741.1352405-5-amir73il@gmail.com>
 <20220317153443.iy5rvns5nwxlxx43@quack3.lan> <20220317154550.y3rvxmmfcaf5n5st@quack3.lan>
 <CAOQ4uxi85LV7upQuBUjL==aaWoY8WGMG4DRQToj6Y-JCn-Ex=g@mail.gmail.com>
 <20220318103219.j744o5g5bmsneihz@quack3.lan> <CAOQ4uxj_-pYg4g6V8OrF8rD-8R+Mn1tMsPBq52WnfkvjZWYVrw@mail.gmail.com>
 <20220318140951.oly4ummcuu2snat5@quack3.lan> <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
In-Reply-To: <CAOQ4uxisrc_u761uv9_EwgiENz4J6SNk=hPxpr7Nn=vC1S2gLg@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Sun, 20 Mar 2022 15:00:25 +0200
Message-ID: <CAOQ4uxgqZzsNhfpxDYomK19+ADqtfOgPNn4B1tG_4kupEhD05w@mail.gmail.com>
Subject: Re: [PATCH 4/5] fanotify: add support for exclusive create of mark
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

On Fri, Mar 18, 2022 at 6:06 PM Amir Goldstein <amir73il@gmail.com> wrote:
>
> > > > So far my thinking is that we either follow the path of possibly generating
> > > > more events than necessary (i.e., any merge of two masks that do not both
> > > > have FAN_MARK_VOLATILE set will clear FAN_MARK_VOLATILE)
>
> I agree that would provide predictable behavior which is also similar to
> that of _SURV_MODIFY.
> But IMO, this is very weird to explain/document in the wider sense.
> However, if we only document that
> "FAN_MARK_VOLATILE cannot be set on an existing mark and any update
>  of the mask without FAN_MARK_VOLATILE clears that flag"
> (i.e. we make _VOLATILE imply the _CREATE behavior)
> then the merge logic is the same as you suggested, but easier to explain.
>

[...]

>
> To summarize my last proposal:
>
> 1. On fanotify_mark() with FAN_MARK_VOLATILE
> 1.a. If the mark is new, the HAS_IREF flag is not set and no ihold()
> 1.b. If mark already exists without HAS_IREF flag, mask is updated
> 1.c. If mark already exists with HAS_IREF flag, mark add fails with EEXISTS
>
> 2. On fanotify_mark() without FAN_MARK_VOLATILE
> 2.a. If the mark is new or exists without HAS_IREF, the HAS_IREF flag
> is set and ihold()
> 2.b. If mark already exists with HAS_IREF flag, mask is updated
>
> Do we have a winner?
>

FYI, I've implemented the above and pushed to branch fan_evictable.
Yes, I also changed the name of the flag to be more coherent with the
documented behavior:

    fanotify: add support for "evictable" inode marks

    When an inode mark is created with flag FAN_MARK_EVICTABLE, it will not
    pin the marked inode to inode cache, so when inode is evicted from cache
    due to memory pressure, the mark will be lost.

    When an inode mark with flag FAN_MARK_EVICATBLE is updated without using
    this flag, the marked inode is pinned to inode cache.

    When an inode mark is updated with flag FAN_MARK_EVICTABLE but an
    existing mark already has the inode pinned, the mark update fails with
    error EEXIST.

I also took care of avoiding direct reclaim deadlocks from fanotify_add_mark().
If you agree to the proposed UAPI I will post v2 patches.

Thanks,
Amir.
