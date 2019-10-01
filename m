Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E9DCC442C
	for <lists+linux-fsdevel@lfdr.de>; Wed,  2 Oct 2019 01:13:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728892AbfJAXNG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Oct 2019 19:13:06 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39753 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726050AbfJAXNG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Oct 2019 19:13:06 -0400
Received: by mail-qk1-f196.google.com with SMTP id 4so13021850qki.6;
        Tue, 01 Oct 2019 16:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9ILA22R+FzAOleL+j0MeMARy0l6+g6H9hVfWW1tX4jE=;
        b=vQiZmVfaJdfSh01WnpPmrO3ZzAZWT569tlLyWt6abiOLUTpkRl0Z4lKkINtwXAacRo
         ii0e39RXHCH1BodaZQ+SPTVyWbd5FP66oiaqTr8aq8aD+MuhurzjFIf2R3uZaOcm/QbF
         WCYVQPuhUYsPIX/AmmCjDYCaPW5Kg+eH1Xxowaqko6Dg7WVo1l2ZHZqQ9saCpKGeYut/
         jCI+LP5W6PRNcU3Orit1siH90oBE3po/tX+oSqIPEL1SMIHh/qjlW02d05nSmsnxhb9v
         vJ/+GGkkQOvg59kKAPWyzgyvDO83ZI8rz0NQEhszenwsOv0aMDQQ/HggYCW7VuBZc2qM
         44EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9ILA22R+FzAOleL+j0MeMARy0l6+g6H9hVfWW1tX4jE=;
        b=M9Le4Shj8wSuId31KyDSfmH2wHHLjdlP4WFhv/ebFxQCHDCD774xWw0uH4U5f+/BUP
         17Lo5m2jUrzAlEzWnDGATtX27mVQ7WPp40sc6PG7mFryRklOw9G4+bgVnaUBFBzuDq2d
         o567/DM83Q9QQvIMYZ5SMXHtnrJ3WYVRAVKB936OtoEy/bz4tUtMAGY2HGumjfzhMnMC
         Ke2z++SSTtY+6g4JzcOCJR5oKO+crpG0M9tJFHy7yL3oyPImAzoUnduRbjkCPU9Veu/i
         03QP2B7CTrgQHGgyybAfpBft4sFWczoBbwxAGPwOD8mcvwZW3pRTEBKqshI5IbKlI0rJ
         LKuQ==
X-Gm-Message-State: APjAAAVfpLvdYcdoIviPjJ1G+/40bLGxrhUsTiZFJuiE/WSwEve8kRkX
        zfAj8BVp+X3iefbr2EVOOqKKy62+3A7uzTg8/lU=
X-Google-Smtp-Source: APXvYqzFXNFI+cFNgRHC/Q6m+0b30EcRiOsi7zFCHkbZ4Zpo8M60YLKQI0GwEbgrpmLgpRkqA2cEg7ngWYJAPIyVhnQ=
X-Received: by 2002:a05:620a:49b:: with SMTP id 27mr681985qkr.89.1569971585019;
 Tue, 01 Oct 2019 16:13:05 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1568994791.git.esyr@redhat.com>
In-Reply-To: <cover.1568994791.git.esyr@redhat.com>
From:   Song Liu <liu.song.a23@gmail.com>
Date:   Tue, 1 Oct 2019 16:12:53 -0700
Message-ID: <CAPhsuW5CvJNRP5OO_M6XVd9q0x-CH9eADWR5oqdJP20eFScCFw@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Fix typo in RWH_WRITE_LIFE_NOT_SET constant name
To:     Eugene Syromiatnikov <esyr@redhat.com>
Cc:     open list <linux-kernel@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@kernel.org>,
        "J. Bruce Fields" <bfields@fieldses.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ingo Molnar <mingo@kernel.org>, Shaohua Li <shli@kernel.org>,
        Jens Axboe <axboe@kernel.dk>,
        linux-raid <linux-raid@vger.kernel.org>,
        Linux-Fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 20, 2019 at 8:58 AM Eugene Syromiatnikov <esyr@redhat.com> wrote:
>
> Hello.
>
> This is a small fix of a typo (or, more specifically, some remnant of
> the old patch version spelling) in RWH_WRITE_LIFE_NOT_SET constant,
> which is named as RWF_WRITE_LIFE_NOT_SET currently.  Since the name
> with "H" is used in man page and everywhere else, it's probably worth
> to make the name used in the fcntl.h UAPI header in line with it.
> The two follow-up patches update usage sites of this constant in kernel
> to use the new spelling.
>
> The old name is retained as it is part of UAPI now.
>
> Changes since v2[1]:
>  * Updated RWF_WRITE_LIFE_NOT_SET constant usage
>    in drivers/md/raid5-ppl.c:ppl_init_log().
>
> Changes since v1[2]:
>  * Changed format of the commit ID in the commit message of the first patch.
>  * Removed bogus Signed-off-by that snuck into the resend of the series.

Applied to md-next.

Thanks,
Song
