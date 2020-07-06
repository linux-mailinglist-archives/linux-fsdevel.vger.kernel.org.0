Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 981392153E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Jul 2020 10:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728237AbgGFIWw (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Jul 2020 04:22:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726277AbgGFIWw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Jul 2020 04:22:52 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB44C061794;
        Mon,  6 Jul 2020 01:22:52 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id v1so20130831vsb.10;
        Mon, 06 Jul 2020 01:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TcfPy5BeGetjZcZtg49AHnHlYlMY923EHh58Yx8xPwY=;
        b=amobd3UufJOQ2LwSgoh8z8cDtk2XkOXjE3WqYKXlXU36cNs4cSbMFborVOQpGRVwAx
         UstxxLR0+FD6IcJZ8l6ARjrlVJKXc5AHqiYulfJW1p6MSM5cx0J6NoiWcKst22Ta5ANR
         MZY9wDpT10XbkRmiAJ+QcOPhuc/E7AtjN2+4znh8+84CkJMxlscFmTR5AUBIP/2YGCRG
         c9FfHfgVEwlI6mvrctkbwD///f2K0JDmzXdg5HAhjwy18Z47ROl3D3U5EIij5TQwBI62
         l1B+NzZd3fdW9JsJB3L0QG6jkjeMZV7Ea55FCnBgMzHpZviXx93P3VvAqSooUI3b10jG
         BPPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TcfPy5BeGetjZcZtg49AHnHlYlMY923EHh58Yx8xPwY=;
        b=nMBgMP0vV71ajyszCOnj9p/G2CdulgYIIpDebqF7lyfJ0qwmilmn5RVVWpRBQxlNka
         +jEZLymdOgPidQiELy1tkuSgW3HxS26B7cCZ2AiAF92GIUlrGqiSxRe78xNY+vpHQRNy
         SOdimXhncGkKACtDsxgcixLWJ71/U9S4+ya4dXyzz5VBYS9wHgHjwuktrQkdV0cNs3sZ
         m2qtXuGBt27lj1rC0K38q+5ev3Bqq6o/7aNO1s0Kv/MUTh02HvX35fhQapJTs8GTe+OG
         wFn9SE9MzfB588V3HxGJKWos81E8TAUyfhDoJrgR3S9+UfZU+fmeU1chbqqSq7T3EiKc
         soaw==
X-Gm-Message-State: AOAM533IoVZ3c1gL86A7DGPCj5WmoZcTGDhTzpwYr6ov4StzlGKdYnEl
        VSYyuIDGPbGY7hZ53xQPCJabZxX/IClKL2V/p6Q=
X-Google-Smtp-Source: ABdhPJwgvZ4oHoUCtn9VtIbwa5Hbr8RpwTI0uj+TB7B0R+ZfDc8KZgjpgNFeatpMagMcoQIWxeV5YUSEo9iZoI6aqhU=
X-Received: by 2002:a67:cb03:: with SMTP id b3mr35827339vsl.214.1594023771334;
 Mon, 06 Jul 2020 01:22:51 -0700 (PDT)
MIME-Version: 1.0
References: <CGME20200627125605epcas1p175ba4ecfbdea3426cc7b0a8fc1750cd0@epcas1p1.samsung.com>
 <20200627125509.142393-1-qkrwngud825@gmail.com> <003801d6502f$f40101c0$dc030540$@samsung.com>
In-Reply-To: <003801d6502f$f40101c0$dc030540$@samsung.com>
From:   Ju Hyung Park <qkrwngud825@gmail.com>
Date:   Mon, 6 Jul 2020 17:22:40 +0900
Message-ID: <CAD14+f0QUgXbDY8vK4HHKcWAh90Jp8DCMb-SRoFmmGrZ3cBhdw@mail.gmail.com>
Subject: Re: [PATCH] exfat: implement "quiet" option for setattr
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Sungjong Seo <sj1557.seo@samsung.com>,
        open list <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Namjae.

Looks like I ported this incorrectly from the previous sdFAT base.

I'll fix, test again and send v2.

Thanks.

On Thu, Jul 2, 2020 at 2:16 PM Namjae Jeon <namjae.jeon@samsung.com> wrote:
>
> >
> >       if (((attr->ia_valid & ATTR_UID) &&
> >            !uid_eq(attr->ia_uid, sbi->options.fs_uid)) || @@ -322,6 +325,12 @@ int
> > exfat_setattr(struct dentry *dentry, struct iattr *attr)
> >               goto out;
> You should remove goto statement and curly braces here to reach if error condition.
> >       }
> >
> > +     if (error) {
> > +             if (sbi->options.quiet)
> > +                     error = 0;
> > +             goto out;
> > +     }
>
