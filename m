Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 752FB4D0BE5
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Mar 2022 00:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243219AbiCGXTU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 7 Mar 2022 18:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiCGXTT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 7 Mar 2022 18:19:19 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D053193E
        for <linux-fsdevel@vger.kernel.org>; Mon,  7 Mar 2022 15:18:22 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id w7so15379639lfd.6
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 15:18:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bvag9d2yKnVQ2WA/+ZCk8meLFVTu4t3Z/Y+Vhn7jLqs=;
        b=iE1Mpo/4WNvmX4KVx+vCPrRdmpw6OvR5A+gP5peGjMWmvtI9qqXJ7QVWhM5mmjDAr9
         OxRVuE27WlAcAJxgb2qcdgwfIEVoyYkX+FP20GgX2hzl8hfi+DISfSMg4WgSb2Dw6/4C
         iRVzuKCVR8of2ZBhjlZfemAtmupGO2kDD76nQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bvag9d2yKnVQ2WA/+ZCk8meLFVTu4t3Z/Y+Vhn7jLqs=;
        b=k4cMNIcPXuEoK21HszmlwXdcaemd6SNW5zkucfddHhKy3z5vcJ1hfUnmveruHqzimi
         hVh+Js7GXLyESJl8PJGUULXWeYtlL1ieaaXNvR7y1JLQQQCQniT3H/0WeZkA3PUS2stv
         IJChJi0CYXtFNWTdvwj1EMsgPB3OxJUkxO4f1uqj2F0RAlvafguWGTmuppME9AKcXYju
         5jwMaU3+zDV8R/EsI0as1ur+4564b+SKvIiXzfrDvDeqvCERwaW+pyTMcIbMpbcBLJFH
         wBxIH4vBgDQdYiwtoRv+VJIancqROl2211bY1lF1LnDNDJwG3ONe4hqJ+RQ+6+1i8IO/
         mVmQ==
X-Gm-Message-State: AOAM5335dSSBvrbb8W63wjx/g/pD/j8N/6QVOQtmzIZgMxswkEwAG86A
        WeWzXhoSYUbpj+KF/LFR3yp4F5fYFOERSw1TPJY=
X-Google-Smtp-Source: ABdhPJz7DjCyqqgmWvTkGA6dxrrmpHWSwHOVbrt4FdAZfz9L4eZptuOBjDAFXzsdekiAZ0/4OZGN4Q==
X-Received: by 2002:a05:6512:16a7:b0:445:862e:a1ba with SMTP id bu39-20020a05651216a700b00445862ea1bamr8825665lfb.85.1646695100824;
        Mon, 07 Mar 2022 15:18:20 -0800 (PST)
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com. [209.85.167.44])
        by smtp.gmail.com with ESMTPSA id h20-20020a2ea494000000b00247eb07015bsm657447lji.26.2022.03.07.15.18.18
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Mar 2022 15:18:19 -0800 (PST)
Received: by mail-lf1-f44.google.com with SMTP id l20so4408898lfg.12
        for <linux-fsdevel@vger.kernel.org>; Mon, 07 Mar 2022 15:18:18 -0800 (PST)
X-Received: by 2002:a05:6512:3049:b0:447:d55d:4798 with SMTP id
 b9-20020a056512304900b00447d55d4798mr8957028lfb.531.1646695098272; Mon, 07
 Mar 2022 15:18:18 -0800 (PST)
MIME-Version: 1.0
References: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
In-Reply-To: <CAHc6FU5nP+nziNGG0JAF1FUx-GV7kKFvM7aZuU_XD2_1v4vnvg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 7 Mar 2022 15:18:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Message-ID: <CAHk-=wgmCuuJdf96WiT6WXzQQTEeSK=cgBy24J4U9V2AvK4KdQ@mail.gmail.com>
Subject: Re: Buffered I/O broken on s390x with page faults disabled (gfs2)
To:     Andreas Gruenbacher <agruenba@redhat.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        David Hildenbrand <david@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 7, 2022 at 2:52 PM Andreas Gruenbacher <agruenba@redhat.com> wrote:
>
> After generic_file_read_iter() returns a short or empty read, we fault
> in some pages with fault_in_iov_iter_writeable(). This succeeds, but
> the next call to generic_file_read_iter() returns -EFAULT and we're
> not making any progress.

Since this is s390-specific, I get the very strong feeling that the

  fault_in_iov_iter_writeable ->
    fault_in_safe_writeable ->
      __get_user_pages_locked ->
        __get_user_pages

path somehow successfully finds the page, despite it not being
properly accessible in the page tables.

And it's presumably something specific in the s390x page table
functionality that makes that happen.

The places I'd look at in particular is to make sure that
follow_page_mask() actually has the same rules as a real page table
lookup on s390x.

IOW, if follow_page_mask() finds the page and thinks it's writable,
then it will return a 'page' successfully, and the __get_user_pages()
code will be happy and say "it's there".

But if then accessing the page by trying to write to it using the
virtual address fails despite that, then you'll get the behavior you
describe.

I'd take a look at that can_follow_write_pte() case in particular,
since this is a FOLL_WRITE thing, but it could be any of the pte
checking details.

Have you tried tracing through that path?

                      Linus
