Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4942468386D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 31 Jan 2023 22:13:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232086AbjAaVNI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 31 Jan 2023 16:13:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232025AbjAaVNF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 31 Jan 2023 16:13:05 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1899915C9A
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 13:13:04 -0800 (PST)
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com [209.85.128.198])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C8D0F3F194
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 21:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1675199582;
        bh=E3dApmotheLeT/eOa2wjKZ6tzLWOqP1QPvaTUoN7Zrw=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=LPsaeFq7SPxznWuc9w/BZDUrC8c51KD5hbn6WusKNBjFGYcjQFObPM32d9jGWsUVc
         5r0sKXPPYLD5v2Rw7HsXq7+cigHESTrqqXNKXK8XbNbEdc6nuWD2ej/UPMOn9HfUj0
         cIjA3tCWFCcR6clWZfWsjk0Oqnhsshz8lbXJtHYsycSg07oqpNb0HfXRZTY+KFzccS
         JPPr8nLSw01Tq5CyUV1F9nUA6QW1F0ej0A9oKQIP4XuPDSH5GYGOONoAxTGs+ZFxEA
         ZWO2Dreef8d+Djv/znkjmXyv2XVeuypBX4okm87Qhxl3akao2AVsNMEwP2RwC7JEp9
         YJXeenaLU660g==
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-4bdeb1bbeafso178225987b3.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 31 Jan 2023 13:13:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E3dApmotheLeT/eOa2wjKZ6tzLWOqP1QPvaTUoN7Zrw=;
        b=4Djiwl5gj1JjuUbIV7qLysDvNNcwXBUSkQoWFBYsEvOgUfGR0s0OqWeGNLiHS3UPth
         QC2lwhSFQJh2VriEO8edd+cJgxMG6YtFRwrZ10K6QAiJeA/LlohfAzURdw3B4YTekWaC
         4R8SIgqeFKbeH7jsAn8Yp/kCkv745S9eDA4tvDhhTShDLakqtcMfoaY65vV3DDbFR6LT
         OeYC3WnUpMZ/8faikoNFdqTs+thgGgXFt/9QpdGySN1HeB/vSKqA6YkkB3jquFLmqkAG
         RruCvz3Rjw2KOcZ4xmjbOVX/WAHJm7j0OxXAgjdY3r5Xb4hfJfFT8gA9x4sgepyGmuma
         SDqw==
X-Gm-Message-State: AFqh2krEb/9XxlC1biFGiXwMMsZUKq+11jabtXeIJywn6dX1irDkrpXC
        YzsE6rwzfgphlL/bZSO1mgAmoriEAZXTMcm6umywqEWYPV7TuCMi2w2OBijfMj9VdlbElzDr7fa
        1gIk4oZVGz95KQwOnX+7ilhBjBVFXcklRbgT+xiwE0lvyR911HNaJPlX/p4w=
X-Received: by 2002:a0d:fd87:0:b0:46c:36ed:413b with SMTP id n129-20020a0dfd87000000b0046c36ed413bmr7131973ywf.115.1675199580935;
        Tue, 31 Jan 2023 13:13:00 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuAZCXgnQTSuhEQYytdfKwXPj4iRHgG+Ekq+j50BL69E2/r2c8BGuLrUd4Haf6Ux5FJr7K7hDN2RdEwvAAkO28=
X-Received: by 2002:a0d:fd87:0:b0:46c:36ed:413b with SMTP id
 n129-20020a0dfd87000000b0046c36ed413bmr7131968ywf.115.1675199580710; Tue, 31
 Jan 2023 13:13:00 -0800 (PST)
MIME-Version: 1.0
References: <20230131121608.177250-1-aleksandr.mikhalitsyn@canonical.com> <87bkme4gwu.fsf@meer.lwn.net>
In-Reply-To: <87bkme4gwu.fsf@meer.lwn.net>
From:   Aleksandr Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
Date:   Tue, 31 Jan 2023 22:12:42 +0100
Message-ID: <CAEivzxfxkWtYP4bqFrmD__3M9WpJNZjTJNx9wp4WQ0_LoGKT6g@mail.gmail.com>
Subject: Re: [PATCH 2/2] docs: filesystems: vfs: actualize struct
 super_operations description
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 31, 2023 at 8:56 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com> writes:
>
> > Cc: linux-fsdevel@vger.kernel.org
> > Cc: linux-doc@vger.kernel.org
> > Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
> > ---
> >  Documentation/filesystems/vfs.rst | 74 ++++++++++++++++++++++++-------
> >  1 file changed, 59 insertions(+), 15 deletions(-)
>
> Thanks for updating this document!  That said, could I ask you, please,
> to resubmit these with a proper changelog?  I'd also suggest copying Al
> Viro, who will surely have comments on the changes you have made.

Hi, Jonathan!

Sure. Have done and of course I've to add Al Viro to CC, but forgot to do that,
cause scripts/get_maintainer.pl have didn't remind me (-:

>
> > diff --git a/Documentation/filesystems/vfs.rst b/Documentation/filesystems/vfs.rst
> > index fab3bd702250..8671eafa745a 100644
> > --- a/Documentation/filesystems/vfs.rst
> > +++ b/Documentation/filesystems/vfs.rst
> > @@ -242,33 +242,42 @@ struct super_operations
> >  -----------------------
> >
> >  This describes how the VFS can manipulate the superblock of your
> > -filesystem.  As of kernel 2.6.22, the following members are defined:
> > +filesystem.  As of kernel 6.1, the following members are defined:
>
> Why not 6.2 while you're at it?  We might as well be as current as we
> can while we're updating things.

I'm on 6.2, but for some reason decided to put 6.1. Will fix it :)

Thanks,
Alex

>
> Thanks,
>
> jon
