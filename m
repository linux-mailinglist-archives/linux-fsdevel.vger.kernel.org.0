Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D82548259F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Dec 2021 20:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbhLaTW4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Dec 2021 14:22:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231553AbhLaTWz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Dec 2021 14:22:55 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5E5AC061574
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:22:54 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id j21so111431336edt.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:22:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0FaWMSBfmWtZkzvxZZ3tF40QOE4zBte4EqNi/u5y60I=;
        b=E/SjcKhF4JFcwzv2/X9miVwVq5ZuHd7raajITq4JeZsOaYHUlIMLL8fT89QVFi8I1y
         NoKWuNsw75AcoAl8eAjbCJ/7mDzs0ypgFYfoJln+z3TQ1dBYG7x/EO1e5qlupTlfnHKT
         R47HkHrOG4EccFnAkS/BskjKUHRPD8bcHdm5c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0FaWMSBfmWtZkzvxZZ3tF40QOE4zBte4EqNi/u5y60I=;
        b=h4cK69X8cWFcfut4l6lh28f3000jz8OEbG/9n6DQRipBhvOAAL0CrJJC8YZZxEG46K
         dy0yMQJBAHiSrBrXvAMb9pvQ2wNx23m5iqudsDYWUDGvLzOgkNZTgCvxeQBaW37Ruey0
         TZiTMmj0Juy3wQ8nnSywn/l214YDnHNyPLIT7QFyJ7jzv2EytxTpdJ75Dp5kjFx4PJEf
         DGkBhWxQTcyhqE8DFcGItEghwLvj9jX4LJ7ffh27XtyIlT0DAYyLBft86URg54Ygu+Kd
         2HUCDT8pauumEoFlfmTD0wUHP806euI9ygKpkVRvTdNbqgr19Fqcm6UO5CL0QHQ7H6oT
         uxuQ==
X-Gm-Message-State: AOAM532IbRAMfqi4toxuKSYOuDv1xPOKXuR1XFhavBOfvD4qrk5gE5w2
        XUCAZoJfrC1qqUNT9YzLzdvbxffqzNE9+uLh8Oc=
X-Google-Smtp-Source: ABdhPJy36KAuyvPE8twoXxcJ8WgcsQmI1+NTdeNCYm2qON8t2TMCBBsXAjx7XSG4QHFzf5IvxuBTFw==
X-Received: by 2002:aa7:db8d:: with SMTP id u13mr34848146edt.111.1640978573191;
        Fri, 31 Dec 2021 11:22:53 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id hq9sm8619797ejc.57.2021.12.31.11.22.51
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 31 Dec 2021 11:22:52 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id v7so57243699wrv.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 Dec 2021 11:22:51 -0800 (PST)
X-Received: by 2002:adf:f54e:: with SMTP id j14mr29689443wrp.442.1640978571474;
 Fri, 31 Dec 2021 11:22:51 -0800 (PST)
MIME-Version: 1.0
References: <20211202150614.22440-1-mgorman@techsingularity.net>
 <caf247ab-f6fe-a3b9-c4b5-7ce17d1d5e43@leemhuis.info> <20211229154553.09dd5bb657bc19d45c3de8dd@linux-foundation.org>
 <5c9d7c6b-05cd-4d17-b941-a93d90197cd3@leemhuis.info> <CAHk-=wi3z_aFJ7kkJb+GDLzUMAzxYMRpVzuMRh5QFaFJnhGydA@mail.gmail.com>
 <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
In-Reply-To: <CAHk-=whj9ZWJ2Fmv2vY-NAB_nR-KgpzpRx6Oxs=ayyTEN7E8zw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 31 Dec 2021 11:22:35 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjKNjx1EApBoaqB0kZ8BB5r+YReOELA5uwRhwMi17S=qg@mail.gmail.com>
Message-ID: <CAHk-=wjKNjx1EApBoaqB0kZ8BB5r+YReOELA5uwRhwMi17S=qg@mail.gmail.com>
Subject: Re: [PATCH v4 1/1] mm: vmscan: Reduce throttling due to a failure to
 make progress
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Mark Brown <broonie@kernel.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Alexey Avramov <hakavlad@inbox.lv>,
        Rik van Riel <riel@surriel.com>,
        Mike Galbraith <efault@gmx.de>,
        Darrick Wong <djwong@kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Dec 31, 2021 at 11:21 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Pushed out as 1b4e3f26f9f7 ("mm: vmscan: Reduce throttling due to a
> failure to make progress")

.. and I _think_ this empties the regzbot queue for this release, Thorsten. No?

                   Linus
