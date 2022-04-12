Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C33B4FDD5F
	for <lists+linux-fsdevel@lfdr.de>; Tue, 12 Apr 2022 13:09:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239320AbiDLLJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Apr 2022 07:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353582AbiDLLE4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Apr 2022 07:04:56 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA4465155
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 02:55:24 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id bg10so36256099ejb.4
        for <linux-fsdevel@vger.kernel.org>; Tue, 12 Apr 2022 02:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=00KClRA1wWMMFU4Cm7CbinihfcVvhxbSLFHj98lTWL8=;
        b=QAWQS3tA/bm43SuAv8JvvNXambgEkPbZap/W+SwYRFjoHZ28b6I/8L3N83XPbMPOl+
         LKygMh0IZtXZjUuorirgxJv4MR6Wu/lJQVnGuLkfKRQCiSFNKn9MmJRc2/LO9kmGXeIm
         vYWyFd4C/Y53elpAUST2vO7pLwxqQAMDlGihgz00FBBvz05v3LD4qdGwvIUwhVfOJxsm
         w6blH3qDQ7et+VQrje57lHhcv6+wUqt3T3Xc0L3tSmhcrdlWfjm86b5PC79kJ2MJbZ85
         PNQOmAlBsG5DvKJakN+0PT4hxRqYSQ7wjw+xKEIHVukqQdUK2UeoU+FEYdRYwbR+MQox
         g7Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=00KClRA1wWMMFU4Cm7CbinihfcVvhxbSLFHj98lTWL8=;
        b=5dROY76mRPi5r0BkougQULXtaCK6lA4qxoQb9l7OSwvcnCWZtoeFuHMd8+hfTZEFkI
         DMRT+BJl3vyw+ulamdgSxVczz6lU+nbPNe7qr16fB8jWCCP2wcMBvZDepFOBu+5+jZhp
         +qQAhP5UfPgSbZe7kk+wrkDTc6jjEFWViXIkBp3toKpvfYTyGVRoHRt0ILZP7vJxSXu3
         dNpkNSFByvXca7USOJb26ASzoz0TiVtxCaGmP+qYzHZgy7Xaar9y3ClFiicLZRZsB4rG
         BlIBTJ1OSdIO9fr0za4tJNXzTPWKqEwXyP0+acW46j3BIbcbqq6YP0yGApGhlJ9rGcq4
         8heQ==
X-Gm-Message-State: AOAM533ib+eApVbOcsSZKWRlu6wbY5EcT1gY0YEYliNzeM9U3Vpc6O3A
        lOyO8EPcCg0avYbp5xoT+9LFYJr3So2AdcATmPk=
X-Google-Smtp-Source: ABdhPJyu0LnOldiH209Rh6FVChpIyp1qRbY2S8zVghPhmHGzxOPbwT+64mU/2RGR7NrFVqx48MPvz93Q279HvG6hobI=
X-Received: by 2002:a17:907:209c:b0:6e8:807c:cdf0 with SMTP id
 pv28-20020a170907209c00b006e8807ccdf0mr11171495ejb.256.1649757323284; Tue, 12
 Apr 2022 02:55:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220406085459.102691-1-cccheng@synology.com> <20220406085459.102691-3-cccheng@synology.com>
 <87czhovr2g.fsf@mail.parknet.co.jp>
In-Reply-To: <87czhovr2g.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Tue, 12 Apr 2022 17:55:12 +0800
Message-ID: <CAHuHWtmNAv6Vx8PCUzMh7d3ThB8gdqYz6+CgC-ukZHtT6ZV-og@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] fat: report creation time in statx
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > +
> > +     if (request_mask & STATX_BTIME) {
> > +             stat->result_mask |= STATX_BTIME;
> > +             stat->btime = MSDOS_I(inode)->i_crtime;
> > +     }
> > +
>
> [...]
>
> > -     if (sbi->options.isvfat)
> > +     if (sbi->options.isvfat) {
> >               fat_time_fat2unix(sbi, &inode->i_atime, 0, de->adate, 0);
> > -     else
> > +             fat_time_fat2unix(sbi, &MSDOS_I(inode)->i_crtime, de->ctime,
> > +                               de->cdate, de->ctime_cs);
> > +     } else {
> >               fat_truncate_atime(sbi, &inode->i_mtime, &inode->i_atime);
> > +             fat_truncate_crtime(sbi, &inode->i_mtime, &MSDOS_I(inode)->i_crtime);
> > +     }
>
> This looks strange. MSDOS doesn't have crtime, but set the fake time
> from mtime and returns to userspace. Why don't we disable STATX_BTIME
> for MSDOS?

Agree. It's not necessary to report in statx.

Thanks.
