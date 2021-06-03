Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A79639AAC6
	for <lists+linux-fsdevel@lfdr.de>; Thu,  3 Jun 2021 21:16:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbhFCTR6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 3 Jun 2021 15:17:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbhFCTR6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 3 Jun 2021 15:17:58 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B9EC061756
        for <linux-fsdevel@vger.kernel.org>; Thu,  3 Jun 2021 12:15:58 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id i10so10488731lfj.2
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 12:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6CRsT8crQOoq4KK7EHvJ7QQM+oKI52My1kzGYaLGrfI=;
        b=R8VDVRcPoGt4k3cTxV+3sOakxWxFIWv9QitfEwkiZuFc+TePCnjK5n4i0LW5CY7vBE
         13FlE07lfLUcNnJ843cb2LCV/zg8vLt0u8cwi/gVWfImNpe1FxwNQ+MJ/WaTmrDjfj+J
         vXkTFwqZubZn2FR3ewqOSGR+9hjtemq0rhKHo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6CRsT8crQOoq4KK7EHvJ7QQM+oKI52My1kzGYaLGrfI=;
        b=IyOtTi9brT0qjjTAj5oRkjQc4l01RhsdHo4j8dENDKgSz0z9DfoehNbyyLUvRkYwhM
         cl3AlL3g//PEASbOoqDi0fCZmkdxnyZb7OQPqh7fC3Pnz/T8eJMOmc/J59GJlYhyVcwF
         l0v8lbqqZxBJ0/DX43Clss1f+D3qavRtj5X2LpvGBhcpAqT7tZTKANbetMbHiBH4Uey8
         EJicsamOjfuUgbp22Ec3b/SVWvZItKxGnO8dOe21+9HrQt/KSk2nph7SgyGKV6fRhC4E
         KQanIRsFWKozYG7DFSEhnfuVxf/ndo/Mv5JGxNPXbxtyw1/vtEOnT2zHXTi8ZiesWQpf
         tMog==
X-Gm-Message-State: AOAM530qS2vsoFPOEk5jBnZYAfLRgf9HWHrk8zESI0AoM1mI5ifXfv65
        oE/Qcb8a+o5Tl/7xcZFVuSm/6+318Orc0+pZ
X-Google-Smtp-Source: ABdhPJwKy9qDx0iGA6zS0Yrbsr1yr/97LsFZds+TuvPTrLXlO92WcLq/xUPPNr508IyA5T65XQIbcA==
X-Received: by 2002:ac2:5084:: with SMTP id f4mr293664lfm.466.1622747756410;
        Thu, 03 Jun 2021 12:15:56 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id x19sm430688lfe.270.2021.06.03.12.15.55
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Jun 2021 12:15:56 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id 131so8533794ljj.3
        for <linux-fsdevel@vger.kernel.org>; Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
X-Received: by 2002:a05:651c:1311:: with SMTP id u17mr626097lja.48.1622747755672;
 Thu, 03 Jun 2021 12:15:55 -0700 (PDT)
MIME-Version: 1.0
References: <1622589753-9206-1-git-send-email-mlin@kernel.org>
 <1622589753-9206-3-git-send-email-mlin@kernel.org> <alpine.LSU.2.11.2106011913590.3353@eggly.anvils>
 <79a27014-5450-1345-9eea-12fc9ae25777@kernel.org> <alpine.LSU.2.11.2106021719500.8333@eggly.anvils>
 <CAHk-=wiHJ2GF503wnhCC4jsaSWNyq5=NqOy7jpF_v_t82AY0UA@mail.gmail.com>
 <alpine.LSU.2.11.2106031142250.11088@eggly.anvils> <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
In-Reply-To: <CAHk-=wiNT0RhwHkLa14ts0PGQtVtDZbJniOQJ66wxzXz4Co2mw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 3 Jun 2021 12:15:39 -0700
X-Gmail-Original-Message-ID: <CAHk-=wg_r837DdEepGAA+jCz27Oqc5hxgYEJo9OoWrnKRhfz5g@mail.gmail.com>
Message-ID: <CAHk-=wg_r837DdEepGAA+jCz27Oqc5hxgYEJo9OoWrnKRhfz5g@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: adds NOSIGBUS extension for out-of-band shmem read
To:     Hugh Dickins <hughd@google.com>
Cc:     Ming Lin <mlin@kernel.org>, Simon Ser <contact@emersion.fr>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 3, 2021 at 12:12 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Yeah, if that's sufficient, then that original patch should just work as-is.

To clarify: it obviously needs the VM_xyz flags things, but the
VM_SHARED check in do_anonymous_page() is fine, and the whole issue
with VM_MAYWRITE is entirely moot.

MAP_PRIVATE works fine with zero pages even when writable - they get
COW'ed properly, of course.

               Linus
