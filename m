Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09F08661EE9
	for <lists+linux-fsdevel@lfdr.de>; Mon,  9 Jan 2023 08:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbjAIHBq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 Jan 2023 02:01:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233477AbjAIHBl (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 Jan 2023 02:01:41 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B6E56362
        for <linux-fsdevel@vger.kernel.org>; Sun,  8 Jan 2023 23:01:38 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id i188so7636061vsi.8
        for <linux-fsdevel@vger.kernel.org>; Sun, 08 Jan 2023 23:01:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=FsDUH9fIuin5V6MIFnBRnLjyFYRx5gCeC8tSE52ZXtM=;
        b=d75CHdPX4aaRg+tCWd+dE+UTkDcIlSk6nVfs0+FljsR0rQ6TRUUe/Q98lFYwZF9Atr
         lE3inOzXYoANRfmlW+72s+jVsJQgHYq72vFOSH3moezzTjmt1eHqKUcJijurCJ74ZBen
         ANhpqZ3wKQspscOuitlfNGJfQC90rRpOHfosxoptTL7EzYWbTrgIgJMYFoOjOE/0RRBa
         g5LkX31jua0ADjndzAc2IrGHFyyvR2/68K8kRBLOtfRtee2Mc+dyD/iolERgnKvhhzV8
         ySMwsCfyimhBjumWr+XOcPChpzriklaUp0NJDi/ebv2Cm/17ToK+1rkD+XAaIafZdEHQ
         JeWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FsDUH9fIuin5V6MIFnBRnLjyFYRx5gCeC8tSE52ZXtM=;
        b=QO0tBPnMDNUFXxAa3d2pVzs2Oczj2qTkOd6imkJJhx3RjDHeyHiqeFmUfLeiBbx7Bt
         CS7x4kq9QDIJz/N/gay5p/+aoexeo6FSPF4R5yROrfU0TPSVdxfCgXwcJ4aaHSzW9sLg
         FDb9Eo7ecLbuaq3OTp9vMjbzzHRfmiQbAhOVtgAsElVrBYUnK6KCVmBzu+ud0DTo9jCo
         bdXIHbXKLdKQRC+w+iPShNQVho2zyfQxgjpPEeHFVto/E22nO436Y972FwzyfUfB9wTf
         dp2BDiiv7ffHfwXrzp0UDVEA2gUgtOa/hwrvI6/ut6GP99E3+7OBu9rwzyzatYHQTj9V
         r86Q==
X-Gm-Message-State: AFqh2kpMurW0bRRHEq+2HEX/CexcXUIx8MzAP4ov8ji+6RHDTLMqlykM
        PCFF18T+Oz++cFnpu0OpVD1yEkg0uVC++S6Sjk0=
X-Google-Smtp-Source: AMrXdXv+SWDty5ro5feIgIruhugAmsapCe2ZtcSXs1q0WkaFccsXx441GDy+Is+1MHnTBXQkXVliIP56iNEyrMG5IGw=
X-Received: by 2002:a05:6102:32d6:b0:3b5:3bd5:2a78 with SMTP id
 o22-20020a05610232d600b003b53bd52a78mr8566702vss.3.1673247697093; Sun, 08 Jan
 2023 23:01:37 -0800 (PST)
MIME-Version: 1.0
References: <CAFkJGRdxR=0GeRWiu2g0QrVNzMLqYpqZm6+Ac5Baz2DcL39HTQ@mail.gmail.com>
In-Reply-To: <CAFkJGRdxR=0GeRWiu2g0QrVNzMLqYpqZm6+Ac5Baz2DcL39HTQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 9 Jan 2023 09:01:25 +0200
Message-ID: <CAOQ4uxipt8xM_8q1Kdw981AddZUiPbVLuhNFZ5sQ24yBKcL_tA@mail.gmail.com>
Subject: Re: Do I really need to add mount2 and umount3 syscalls for some
 crazy experiment
To:     Anadon <joshua.r.marshall.1991@gmail.com>
Cc:     linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 9, 2023 at 7:08 AM Anadon <joshua.r.marshall.1991@gmail.com> wrote:
>
> I never post, be gentle.
>
> I am looking into implementing a distributed RAFT filesystem for
> reasons.  Before this, I want what is in effect a simple pass-through
> filesystem.  Something which just takes in calls to open, read, close,
> etc and forwards them to a specified mounted* filesystem.  Hopefully
> through FUSE before jumping straight into kernel development.
>
> Doing this and having files appear in two places by calling `mount()`
> then calling the (potentially) userland functions to the mapped file
> by changing the file path is a way to technically accomplish
> something.  This has the effect of the files being accessible in two
> locations.  The problems start where the underlying filesystem won't
> notify my passthrough layer if there are changes made.  Since my end
> goal is to have a robust consensus filesystem, having all the files
> able to silently be modified in such an easy and user accessible way
> is a problem.

Have you considered using fanotify for the FUSE implementsation?

You can currently get async change notifications from fanotify.
Do you require synchronous change notifications?
Do you require the change notifications to survive system crashes?

Because that is what my HSM fanotify project is aiming to achieve:
https://github.com/amir73il/fsnotify-utils/wiki/Hierarchical-Storage-Management-API#tracking-local-modifications

> What would be better is to have some struct with all
> relevant function pointers and data accessible.  That sounds like
> adding syscalls `int mount2(const char* device, ..., struct
> return_fs_interface)` and `int umuont3(struct return_fs_interface)`.
> Adding two new syscalls which look almost nothing like other syscalls
> all in the name to break "everything is a file" in favor of
> "everything is an API" is a lot.  It sounds like a fight and work I
> would like to avoid.

Don't go there.

>
> I have looked at `fsopen(...)` as an alternative, but it still does
> not meet my use case.  Another way would be to compile in every
> filesystem driver but this just seems downright mad.  Is there a good
> option I have overlooked?  Am I even asking in the right place?

If you are looking for similar code, the overlayfs filesystem driver
is probably the closest to what you are looking for in upstream
kernel, because it takes two underlying paths and merges them
in one unified namespace.

Somewhat similar to leader change, some union files switch the backing
file at runtime (a.k.a copy up).

Upstream overlayfs does not watch for underlying filesystem changes,
in fact, those changes are not allowed, but it could be done.
I have another project where overlayfs driver watches the underlying
filesystem for changes:
https://github.com/amir73il/overlayfs/wiki/Overlayfs-watch

The out-of-tree aufs has had underlying change tracking for a long time.

Thanks,
Amir.
