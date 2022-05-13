Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 694C7526391
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 May 2022 16:16:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343878AbiEMOPX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 May 2022 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245701AbiEMOPT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 May 2022 10:15:19 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CEED11C0B6;
        Fri, 13 May 2022 07:15:09 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c1so7099994qkf.13;
        Fri, 13 May 2022 07:15:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6ZLUB2BhEGxnhst9iSZ/Y951Q8OlgV1+BfPX50QmFmI=;
        b=NRxYV6cnBaDDp8NpbE8cZ1jmZd4OIi1JD5q2M986Vj147Sgd99CNJN8uEgVzIic8DA
         NckCsLelzmZNFmyLX674mMzlrzsyMf+F80dlJBIMZRkZMZF6b0t5QAUCUG83z8YgxEVm
         EnMzd0gTZHY/HmIwc6Epe2K5/L6z10XeHmOYkjF6EXgqwHyYPwdmZy2X3WhsRtakEn//
         Mu2T6YJf2OmynOnoLxpQxBp809asQuHH/9Zppmo1NnPEhkWm5DgqKNn1sWHbyN05eeJd
         YYkV5MiknpqBuQIUFVi10UolcWBOzhXtvxqmxw1kVvDTyUU4ctt2qPS1pqdnG+1yr3zQ
         1Ywg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6ZLUB2BhEGxnhst9iSZ/Y951Q8OlgV1+BfPX50QmFmI=;
        b=PkEgxhL2r7yjrdNwY5HnsYbho4TiI1ZYs3ERZPv76wcEApx9ienA3S6334vT5q7Vgc
         DgMRGv9L7mwbfZsalRHKGOSTlQyR5Y+TQazT4ld6cKF5bfpMwwUW3E0gZtWaV9lFZBDN
         uKGRZDTNLdE95jwyV/bDoh86MvBZF373l0Aw5WI3FHo12YPHfBGyfQjO5NCD6DtbDTRG
         BnCw6/0laq5R63KNbOUiJEdnfoEtLuB9jcmRnTS1Wf4rNUINaLwy3qNl/5tyw2/bGQuq
         LiXHI9HlEHLj4CQIevK1e7ouASJSLuVs6s8Mg9c4OT4kEC4Dgps/WPQPbMCcY5A1i4rS
         rwOQ==
X-Gm-Message-State: AOAM531rRHa7yNPL1OZDKn/SggdrSVAJco1TPWHMC0lyRVea8D5Y5bcC
        QhCof3zpptq+lzc4M3Hlc5o62nf8MET8NawHsmYTvyRx
X-Google-Smtp-Source: ABdhPJxzx0A2WS93AnMnWiA0FqnGRjgtPwrB/BUfOA+b+ZiP09fsJ8RBt+gWF3N6Ief5jFQLZ3yXt8NA7pIP+2akkHk=
X-Received: by 2002:a37:9381:0:b0:69f:62c6:56a7 with SMTP id
 v123-20020a379381000000b0069f62c656a7mr3791659qkd.643.1652451308902; Fri, 13
 May 2022 07:15:08 -0700 (PDT)
MIME-Version: 1.0
References: <YnOmG2DvSpvvOEOQ@google.com> <20220505112217.zvzbzhjgmoz7lr6w@quack3.lan>
 <CAOQ4uxhJFEoV0X8uunNaYjdKpsFj6nUtcNFBx8d3oqodDO_iYA@mail.gmail.com>
 <20220505133057.zm5t6vumc4xdcnsg@quack3.lan> <YnRhVgu6JKNinarh@google.com>
 <CAOQ4uxi9Jps3BGiSYWWvQdNeb+QPA9kSo_BDRCC2jfPSGWdx_w@mail.gmail.com>
 <20220506100636.k2lm22ztxpyaw373@quack3.lan> <CAOQ4uxjEcbjRoObAUfSS3RHVJY7EiW8tJSo1geNtbgQbcTOM+A@mail.gmail.com>
 <Yn5al/rEQIcf6pjR@google.com>
In-Reply-To: <Yn5al/rEQIcf6pjR@google.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 13 May 2022 17:14:57 +0300
Message-ID: <CAOQ4uxiMBEz8bgNT6zhsJbVe6dKCXfd0WyZw3MdNb_WLFvk2Zg@mail.gmail.com>
Subject: Re: Fanotify API - Tracking File Movement
To:     Matthew Bobrowski <repnop@google.com>
Cc:     Jan Kara <jack@suse.cz>, Linux API <linux-api@vger.kernel.org>,
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

On Fri, May 13, 2022 at 4:18 PM Matthew Bobrowski <repnop@google.com> wrote:
>
> On Sat, May 07, 2022 at 07:03:13PM +0300, Amir Goldstein wrote:
> > Sorry Matthew, I was looking at the code to give you pointers, but there were
> > so many subtle details (as Jan has expected) that I could only communicate
> > them with a patch.
> > I tested that this patch does not break anything, but did not implement the
> > UAPI changes, so the functionality that it adds is not tested - I leave that
> > to you.
>
> No, that's totally fine. I had to familiarize myself with the
> FS/FAN_RENAME implementation as I hadn't gone over that series. So
> appreciate you whipping this together quickly as it would've taken a
> fair bit of time.
>
> Before the UAPI related modifications, we need to first figure out how
> we are to handle the CREATE/DELETE/MOVE cases.
>
> ...
>
> > My 0.02$ - while FAN_RENAME is a snowflake, this is not because
> > of our design, this is because rename(2) is a snowflake vfs operation.
> > The event information simply reflects the operation complexity and when
> > looking at non-Linux filesystem event APIs, the event information for rename
> > looks very similar to FAN_RENAME. In some cases (lustre IIRC) the protocol
> > was enhanced at some point exactly as we did with FAN_RENAME to
> > have all the info in one event vs. having to join two events.
> >
> > Hopefully, the attached patch simplifies the specialized implementation
> > a little bit.
> >
> > But... (there is always a but when it comes to UAPI),
> > When looking at my patch, one cannot help wondering -
> > what about FAN_CREATE/FAN_DELETE/FAN_MOVE?
> > If those can report child fid, why should they be treated differently
> > than FAN_RENAME w.r.t marking the child inode?
>
> This is something that crossed my mind while looking over the patch
> and is a very good thing to call-out indeed. I am of the opinion that
> we shouldn't be placing FAN_RENAME in the special egg basket and also
> consider how this is to operate for events
> FAN_CREATE/FAN_DELETE/FAN_MOVE.
>
> > For example, when watching a non-dir for FAN_CREATE, it could
> > be VERY helpful to get the dirfid+name of where the inode was
> > hard linked.
>
> Oh right, here you're referring to this specific scenario:
>
> - FAN_CREATE mark exclusively placed on /dir1/old_file
> - Create link(/dir1/old_file, /dir2/new_file)
> - Expect to receive single event including two information records
>   FID(/dir1/old_file) + DFID_NAME(/dir2/new_file)
>
> Is that correct?

Correct.
Exactly the same event as you would get from watching dir2 with
FAN_CREATE|FAN_EVENT_ON_CHILD in a group with flag
FAN_REPORT_TARGET_FID.

Thanks,
Amir.
