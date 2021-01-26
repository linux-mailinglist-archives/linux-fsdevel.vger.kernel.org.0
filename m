Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9A56A30450D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 26 Jan 2021 18:22:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391097AbhAZRVm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 26 Jan 2021 12:21:42 -0500
Received: from mail-ot1-f54.google.com ([209.85.210.54]:40834 "EHLO
        mail-ot1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731409AbhAZIF0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 26 Jan 2021 03:05:26 -0500
Received: by mail-ot1-f54.google.com with SMTP id i20so15464834otl.7;
        Tue, 26 Jan 2021 00:04:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gn3riWFOSuTtLdZEXF1Nsf86n3nO9ZsoSqLIAXg41vE=;
        b=BcuuLS4QvnQ7VW4o4xodK3lekW9Lamer/2mPZYaqnTQN7uImCc3DijO5uQd9p4SL7U
         3IuLSLejjvKWb4pI19+mUbbLbDIy77ystR8l8cmBceES1jEaIQ8aL0sgJJ7KjrH6IKY2
         b+EfttboN1GR9wMh1qdDhov2RRfm0I8ICnfpy0JWRPGiegs7Un5CpEhysp+doOIENidn
         A8gpOqNnu7uH1hs/8aA1k89D41EWYn1+MIrdMVsxuCfraCYywBJC6fkh5MkBrnNQuLPR
         JN+v1Wf7FKYCP8F2E9Z6Af/fgiKWYAiOxTZ7XTMNiT6mB9wp3cK5t3N2Os2lV4+mFYM/
         RPng==
X-Gm-Message-State: AOAM533tN7vPYV43TrOEZUvZRe42fTBrSqvNKnlYZu2c5126ZuGY25Tp
        Q+3dYh0/V5TYYOjwRigqYNalvZ6Dgteoat62UXo=
X-Google-Smtp-Source: ABdhPJytIVD/4Xb2nil6CfBZHjJXQKq/Ujc3snRT0q1tZOrWGz9aNLYUvpR+IrZFMlEDPHDayYjctOwkb3DlnpFFBGc=
X-Received: by 2002:a05:6830:15cc:: with SMTP id j12mr3178136otr.145.1611648217240;
 Tue, 26 Jan 2021 00:03:37 -0800 (PST)
MIME-Version: 1.0
References: <20210106075112.1593084-1-geert@linux-m68k.org> <20210126055112.GA19582@xsang-OptiPlex-9020>
In-Reply-To: <20210126055112.GA19582@xsang-OptiPlex-9020>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 26 Jan 2021 09:03:26 +0100
Message-ID: <CAMuHMdUFsRSCDJeML+0i17ig6oFr+-cz660xyhkhkfg2UtPTzQ@mail.gmail.com>
Subject: Re: [binfmt_elf] d97e11e25d: ltp.DS000.fail
To:     oliver.sang@intel.com
Cc:     0day robot <lkp@intel.com>, LKML <linux-kernel@vger.kernel.org>,
        lkp@lists.01.org, ltp@lists.linux.it,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Oliver,

On Tue, Jan 26, 2021 at 6:35 AM kernel test robot <oliver.sang@intel.com> wrote:
> FYI, we noticed the following commit (built with gcc-9):
>
> commit: d97e11e25dd226c44257284f95494bb06d1ebf5a ("[PATCH v2] binfmt_elf: Fix fill_prstatus() call in fill_note_info()")
> url: https://github.com/0day-ci/linux/commits/Geert-Uytterhoeven/binfmt_elf-Fix-fill_prstatus-call-in-fill_note_info/20210106-155236
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git e71ba9452f0b5b2e8dc8aa5445198cd9214a6a62

My patch (which you applied on top of v5.11-rc2) is a build fix for
a commit that is not part of v5.11-rc2.  Hence the test run is invalid.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
