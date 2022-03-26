Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 581A44E7E39
	for <lists+linux-fsdevel@lfdr.de>; Sat, 26 Mar 2022 01:44:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229489AbiCZAp7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Mar 2022 20:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiCZAp6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Mar 2022 20:45:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AAA40915
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 17:44:22 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id k6so9896139plg.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 25 Mar 2022 17:44:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=94bZ8x1Q7nTpZFPXEyWHGvFt2Awbfow/+NrxSOgACok=;
        b=R6hivrzTvp4LePDOadbPe3dFOajjYpUwNoSgW7jLyXp6W8Ac/oN1vJdiFVyZYi5a+a
         ErU+cQw6xaX5V1LXVrxvEP/GXEiyC7UUB5NjeqLBBirDx8MqP6ZsfHy9oVJNjSiZ0K97
         zOsZ9TAg91mFeTyLO34/EVVHvZgCfqMdZ2Jcs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=94bZ8x1Q7nTpZFPXEyWHGvFt2Awbfow/+NrxSOgACok=;
        b=bPaMz8GCiO1u8J0ArZ5cUrwgjAOdo2jBKFjdG2Y/8Baopc3QEfjCDOvo4KnhAUj5QI
         4vBkfj16b0KtQdGdFAJu1IaUJ2yC/3RFA8QHD/FTS67GAqk3x9kwN38M+pcJKYFiXx/8
         Q2E5UiziwDnPkExWFPYiM9Z++qLGUFg8banu60AeUDBadSr2CuSkBNUmZAuYPdU46rdO
         kLXbd1RRzkywISqzka3Mq1ymV7EorDRxDsC4rlYrHuRCcbkojma1ATvhrgqPxlhXzzkX
         Temy/OYZHgeuI4vmK0MssTWL4WB/uFjgPJg/2yJuJ1r75SY2iUMsXlrrNfEGevVWKaCu
         eeLw==
X-Gm-Message-State: AOAM530lnQXAcEy8eBr+ppEMirThR6RalA6EKy8fymgFj50iEzPaNaN1
        D5RyNAW0GUTwYe7inEhXIEnWL7v79xxiq8J3F5no334O3imFqkfq
X-Google-Smtp-Source: ABdhPJy/BxTZlhcYIY65xpT8plAgoLHEXzIqiynq/mwldpYeh/3hqd/0CpjgoSRpMFCJDTic5vR5NXcTjejFRwVhGHU=
X-Received: by 2002:a17:90a:5ae2:b0:1c6:7168:1164 with SMTP id
 n89-20020a17090a5ae200b001c671681164mr15573377pji.119.1648255462408; Fri, 25
 Mar 2022 17:44:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
In-Reply-To: <20220323153712.csh5pme32z5aqx4e@quack3.lan>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 25 Mar 2022 17:44:11 -0700
Message-ID: <CAADWXX_FmHu6xb1tUEbwNZKtJ-dDe0uCpR94q6j0BRt3SxQxnQ@mail.gmail.com>
Subject: Re: [GIT PULL] Reiserfs, udf, ext2 fixes and cleanups for 5.18-rc1
To:     Jan Kara <jack@suse.cz>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Wed, Mar 23, 2022 at 8:37 AM Jan Kara <jack@suse.cz> wrote:
>
> The biggest change in this pull is the addition of a deprecation message
> about reiserfs with the outlook that we'd eventually be able to remove it
> from the kernel. Because it is practically unmaintained and untested and
> odd enough that people don't want to bother with it anymore...

Pulled.

I have this memory of seeing somebody suggest the eventual removal be
a bit more gradual with a "turn it read-only" first, as perhaps a
slightly  less drastic "remove entirely" maintainability option.

But maybe I'm just confused and mis-remember - and maybe nobody is
willing to maintain even just a read-only form. But being at least
able to read old filesystem images might help *some* people if they
notice much too late that "oh, it's gone".

                Linus
