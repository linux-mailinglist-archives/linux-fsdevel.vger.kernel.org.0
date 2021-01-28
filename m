Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 745C33080E9
	for <lists+linux-fsdevel@lfdr.de>; Thu, 28 Jan 2021 23:07:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231563AbhA1WGX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 Jan 2021 17:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbhA1WGT (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 Jan 2021 17:06:19 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D0FC061573;
        Thu, 28 Jan 2021 14:05:39 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id r12so10064877ejb.9;
        Thu, 28 Jan 2021 14:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HKCtWFXH5+r8I6QVN7JmwP43GunaybG6wrPKLDTJuxc=;
        b=k2a1fUl4a4gmJwlGyVf7KUDgt1EkUownghvr5s1vnwYaI/Ryp30QG4+EBdzOn2JrVN
         m/rfXkIEG5oChyQaS/kuRTPSCCTUFGKh3PCUWDnflgupTHroIH+JfQs4vWeh8GDT/MAT
         lqtvRAehXZL6kUXzwYPK45ujlOgmYw+hCemvaj7B5SNHEy7NFPGhBbcI5NB6vmYi1Cte
         dBf/2FJsIGKCv09DZAlLeiAH6oJDUTwwKxCpFXDRN9DTvnsRRgSCpe/yKNdif/6FyRgU
         RWdttuEqTvn6LXw1V+xa+JzilcpjQtxMd9cMBD2BAPbG/CqacKkMiajJZ0OF3qLdEMPQ
         VGlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HKCtWFXH5+r8I6QVN7JmwP43GunaybG6wrPKLDTJuxc=;
        b=oUsIi1yCW4yAdNOs8qFhS1BXbCPdriOc2ZUJ5Z9+G5K5FUQy8Q+i3Al1u2dFzC2fv7
         ePn0220MYP6t4/URMFRseeHoxSUecDmN7B9GkacIQgt+Nh3SKnBx2AOSImQlgNEgPYAY
         JxhXf97WuvdHZ25qIhx7LlXrKSXWDOPTjFMKrmqVg+ZQGpWOubHg2V/8oKSHOUHvDc11
         LNTaU8TzMK72SSDuVOBdVGyz31mSaJY0RzChUsaClyhtSFp4rbwQVu78C6n+6+sPCld4
         GdQW01pD4/r4+EeUHGeFwJRAXPH7sPFoJxoKKb5ZgO5GD12viO4IYQcaXH4SyD3AAgZ/
         xHTQ==
X-Gm-Message-State: AOAM532oIwBhXGAJ/E1hhv/S/kOVFDYIarYLmuLSgD5johES1dpPxNag
        TrYcK+Iy6Oh8JeafCoDyqpCY0hARMJEs6S98g+I=
X-Google-Smtp-Source: ABdhPJyfNcJK0c+Euz/ZYhosU+vaemOk6O/laqqaC0tPerCWVKz9aeQO7JwhzBS1VCDUfOWJX+oQpzZBxyKdT2qgHzA=
X-Received: by 2002:a17:906:94d3:: with SMTP id d19mr1488136ejy.383.1611871537966;
 Thu, 28 Jan 2021 14:05:37 -0800 (PST)
MIME-Version: 1.0
References: <20210127233345.339910-1-shy828301@gmail.com> <20210127233345.339910-6-shy828301@gmail.com>
 <f6cfbe3c-bfca-61ee-72b4-981188456362@suse.cz>
In-Reply-To: <f6cfbe3c-bfca-61ee-72b4-981188456362@suse.cz>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 28 Jan 2021 14:05:25 -0800
Message-ID: <CAHbLzkp7p9vS1AScqi-w7bkUNBLATDJdjE+x1FipZXkMpGLx+A@mail.gmail.com>
Subject: Re: [v5 PATCH 05/11] mm: memcontrol: rename shrinker_map to shrinker_info
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Roman Gushchin <guro@fb.com>, Kirill Tkhai <ktkhai@virtuozzo.com>,
        Shakeel Butt <shakeelb@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 28, 2021 at 9:38 AM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 1/28/21 12:33 AM, Yang Shi wrote:
> > The following patch is going to add nr_deferred into shrinker_map, the change will
> > make shrinker_map not only include map anymore, so rename it to a more general
> > name.  And this should make the patch adding nr_deferred cleaner and readable and make
> > review easier. Rename "memcg_shrinker_info" to "shrinker_info" as well.
>
> You mean rename struct memcg_shrinker_map, not "memcg_shrinker_info", right?

Actually, I mean remove "memcg_" prefix. The patch renames
memcg_shrinker_map to shrinker_info.

>
> >
> > Signed-off-by: Yang Shi <shy828301@gmail.com>
>
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
