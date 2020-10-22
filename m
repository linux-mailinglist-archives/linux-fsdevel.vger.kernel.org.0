Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8C6C2962CE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 22 Oct 2020 18:36:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2901877AbgJVQgp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 22 Oct 2020 12:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2901870AbgJVQgo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 22 Oct 2020 12:36:44 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA4C0613D2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:36:44 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id j17so2312407ilr.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 22 Oct 2020 09:36:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+lch+IZMfxV3l3RJZHJEowGmWSc4FEincm/6SxOPYKQ=;
        b=UnPigUn7I8I2pHxcyygPgbXBbVkqTbhqqy9L+bgfggs0G/DgBn9kZGBtoRIrdbBKpb
         lSUKTYm+WQM1NWvaXeaJF20E6u4RFsEM+tVlZBwNgSwVDlNS40hqgXXwPu92E8sK56h6
         bz++0QFzMroIeALDuDt+A+PqpUgYC5I+omcLg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+lch+IZMfxV3l3RJZHJEowGmWSc4FEincm/6SxOPYKQ=;
        b=QfxwXf9fHMRdMk3MIeBD+J+R2pkl5lzrsxNG9uTNkUGLuvCK3ee4WBxTHYJ3jay2jf
         tt5M9qU13+hWiLrksyfCsk8oagGJXdiZJONSjJPj0Oq1JWROrX2Oni79oENnmVOGqu/C
         w7sR5h095ZHCoI3v6uEGOVy/El3nGY52eId4Fnx+eaAurPjfTfm7XmwDQaN5J+N8pvjB
         cQe7ebvYPQhGFMf3BKq4qjmiRsDZ4StJzvRDhcLixY/zBCvv0AqOFUYHVDGKMTDhsz6F
         0yAeyiSHpBYFVfmYHU4PKwn69dDqKP/c2H7/lPvoUOyVG+DEqJScdmc/Y0t10wIrPdwz
         WTOQ==
X-Gm-Message-State: AOAM532N8GjWVcnwU5X5m6KQ2u8JZp6mffnEjs+pwofd7wmWjgrQY7vw
        Zyd8KfpLHnX/rDiiWWDJM7moX0VcjrG0fNJ+11m9wA==
X-Google-Smtp-Source: ABdhPJw8exBc165wZjBOYF2Mq1SSOm9RufoUu4migxB1UkHORcrMp7OntunI5ATQr/R2FIQdbMLxOeKzZUu9cMeI+v4=
X-Received: by 2002:a92:d28e:: with SMTP id p14mr2661432ilp.132.1603384603410;
 Thu, 22 Oct 2020 09:36:43 -0700 (PDT)
MIME-Version: 1.0
References: <20201022120826.GA28295@nautica>
In-Reply-To: <20201022120826.GA28295@nautica>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 22 Oct 2020 09:36:32 -0700
Message-ID: <CAADWXX89-No9XCE+ge+-Mv-DWPJk_y1E7YrDeng80jE=J3_gzQ@mail.gmail.com>
Subject: Re: [GIT PULL] 9p update for 5.10-rc1
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Netdev <netdev@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        lkml <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 22, 2020 at 5:08 AM Dominique Martinet
<asmadeus@codewreck.org> wrote:
>
> another harmless cycle.

Quick note: your email got marked as spam for me.

It's probably just gmail doing another round of spam changes, but I do
note that while your smtp setup does spf, it doesn't do dkim. Which I
think makes gmail more suspicious about it than it would otherwise
likely be.

            Linus
