Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ACAC2302C3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 08:25:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727008AbgG1GZv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 02:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726896AbgG1GZu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 02:25:50 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60356C061794
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 23:25:50 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id 88so17056259wrh.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 27 Jul 2020 23:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7etnaWOwVx6vNnoAvWMwIKpf2RbffIgHQ+Ut1q/2kv8=;
        b=YPBKAucSuaaf0P/MoRJbUS6YUlX4lgKwIHfXj8kMmn7VgUjhZkX5rNqMQtZU8B+5X/
         Xc4ch8YTm38tgIYFMi9LaOKn7TYaAOgQjIxwxxdC7aG1uMFStwiaiCOqhsLIn3R7vszK
         SIbUHh7CNbo0zBtb1j5l8IjEVQ9tvgHYkjFitOyITdWxWZzgWed5r3I0PXE6ThDfU5HN
         n5YMY+nNygQOKo8PLMPqjSn4yRgjjVZiRjewR3r72lviGgzsbFu5QO6pEWTUeh0uAG09
         BH9WwFswLLnlzagBOmXVavtQbx0Z9ZIWtqDvwLC+6vh1QwcCKe7UIHHwlqubNonY8FlS
         Wvmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7etnaWOwVx6vNnoAvWMwIKpf2RbffIgHQ+Ut1q/2kv8=;
        b=sIL9WYlveUhQAIpqgt26oD48XlgiSHetuz0UmjN29UCG9mZkwMCZZsKKcb23K4GcRQ
         pmUn+mNNSfZxc2FJHD74ATu3bbG9TLseOJC71nICsv3NCHYyawCpNv+/z2VGD7tsnqrP
         ZvFVO2tngdGhAvUSelxp9UO0mRMEcKaNVHa1IkU03XOxOtrgqg/hV5ULGvgTn2uqX/8X
         qfFnmPH8xxYlonJt7MTcZewC5csbo7TuECauAXjzpwuDo80EVGID7TU+kc5Oi3yY6Q5f
         mki6p0xwNEOnvWQB4hdIiuBMkAsqwG6U3358NJ2a2/P8Lt8p9q169yTdhkxWIIVi6/l2
         zbGw==
X-Gm-Message-State: AOAM532pErKmhcFNYoNWmy8GD+UUpSkoR4YmwXbjNg12JjLSnz/9eSgQ
        9EE4GwPiCD1lGpcwJ83SWcyYeBDCo1VGuCsAAyggMTbCwYY=
X-Google-Smtp-Source: ABdhPJyad6Em+rX/p7Ji908ZQHajh7zAhsMAC2huISArT4VENpdGyGPdZ94rIl1ouUQwvSKcqdf81TYCZkrnf40qg70=
X-Received: by 2002:a5d:40cf:: with SMTP id b15mr23050073wrq.319.1595917549191;
 Mon, 27 Jul 2020 23:25:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200725045921.2723-1-kalou@tfz.net> <20200725052236.4062-1-kalou@tfz.net>
 <20200727142140.GA116567@localhost.localdomain> <CAGbU3_nkBfrJK55-ZiCc6ve1F+CZBeuSmm6Dike0kkKja-RmVg@mail.gmail.com>
In-Reply-To: <CAGbU3_nkBfrJK55-ZiCc6ve1F+CZBeuSmm6Dike0kkKja-RmVg@mail.gmail.com>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Mon, 27 Jul 2020 23:25:38 -0700
Message-ID: <CAGbU3_nPuWyrhOVbHGk7EXb+fVAOR1sC08Fu-1sOdbOsmQkE_A@mail.gmail.com>
Subject: Re: [PATCH v3] proc,fcntl: introduce F_SET_DESCRIPTION
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 27, 2020 at 6:39 PM Pascal Bouchareine <kalou@tfz.net> wrote:
> > struct file is nicely aligned to 256 bytes on distro configs.
> > Will this break everything?
> >
> >         $ cat /sys/kernel/slab/filp/object_size
>
> Indeed on the config I'm using here this jumped to 264 bytes
>
> Would it be better to move this to the inode struct? I don't know the
> implications of this - any other option?

Well it doesn't actually make much sense to share that at that level

However the above 264 is building from 5.4 without f_sb_err, so I
think master already passed the 256 bytes too ?
