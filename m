Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF8E64E504C
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 11:27:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243497AbiCWK30 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 06:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240414AbiCWK3Z (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 06:29:25 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCA927667F
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 03:27:55 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id r23so1310623edb.0
        for <linux-fsdevel@vger.kernel.org>; Wed, 23 Mar 2022 03:27:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=r4cArKJsQmc9nGWaTHXv9wZbXDgAdAZsDgk+mEly5DM=;
        b=JRfUEyQs8jtjDz96yj/DDw/yzcOhx73gX3biQsFdd6npH0lhWrxfUJD3nlTswwkFBz
         f80dyGsS5/eN2QQqJJoqQ1e+rBY1UN5YMDEQ+J/XYpglEK2SNuvLJTEZHKk/yD9b9Euv
         9qYMlWMHcYV24ZoRUX6jUzbspeQEKOY/U6ZpcFkPClmhPeatPzf7PIvdUczgeBPix0ea
         Z9lueot6zPFX0zG01AvdGvQsskrvPsDA/YK1se1cqS25wx6T/cjnAQRf325vpOoCGceO
         V+NNnMgGzTQeG21MtPtP+jJn9pErqa0MxCviavklKL6f6bjTOZsmLkH/irNj5zFue1OI
         AITg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=r4cArKJsQmc9nGWaTHXv9wZbXDgAdAZsDgk+mEly5DM=;
        b=C+eEXL+IsBj6IiGALeala3+Uv+d2Ps7+J9QW7rU6pGvJMvZL39yqKf6fRctf9IfQKe
         eMoXqbclMNeBJOmpg8kJoYP5EQV7XgwQe+IJtBX6rUpWqPdhCfarq5sDTCdjvmTVu6xI
         XnjTqXeHwtmZN4oiwznvFW2h9lFsYp5hPkaf5hA4LncvPkyhrr80QR6eV27qS59MA171
         757vtCaaWuQNnlWhEJa7UcgBXQPag1BnCTEmeo7XAgorv6CHNeSkfNAt2wPypGlX5+Fe
         YZ8YUnJwTHqaJgiqlDDdrFX2fGj7Y9g9s30+ERACU12mqMOXO5MMaX2FxcNVvvbAUIkk
         AEHg==
X-Gm-Message-State: AOAM533vt5NgrPahkpCQ7p/jzfwx/dwBR/gGrykS3pnx5uRZYmCwnWQS
        y82BTFFJc0+9RZa/RVy58Z/bTCqDcFdJ9eieeH8=
X-Google-Smtp-Source: ABdhPJyQNl7xH+c99C/c9ox9ZmWpXMCJ2QyETgHbybWKNnXMllkUxdrI5oH5JhkK/IwiHi+ncWG+SxfHAecsOKxdkHw=
X-Received: by 2002:a05:6402:350d:b0:419:547f:134a with SMTP id
 b13-20020a056402350d00b00419547f134amr10301109edd.405.1648031274188; Wed, 23
 Mar 2022 03:27:54 -0700 (PDT)
MIME-Version: 1.0
References: <20220321095814.175891-1-cccheng@synology.com> <20220321095814.175891-2-cccheng@synology.com>
 <87lex2e91h.fsf@mail.parknet.co.jp> <CAHuHWtkvt4wOdwaoyYv0B4862pSYttMBh6BUz3vHbERv+CEGaw@mail.gmail.com>
 <87sfr917hr.fsf@mail.parknet.co.jp>
In-Reply-To: <87sfr917hr.fsf@mail.parknet.co.jp>
From:   Chung-Chiang Cheng <shepjeng@gmail.com>
Date:   Wed, 23 Mar 2022 18:27:43 +0800
Message-ID: <CAHuHWtk1-AdKoa-SBOb=sJAM=32reVzcUQYjrrxvOPYwFZJqXQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] fat: introduce creation time
To:     OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        linux-fsdevel@vger.kernel.org, kernel@cccheng.net
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

OGAWA Hirofumi <hirofumi@mail.parknet.co.jp> =E6=96=BC 2022=E5=B9=B43=E6=9C=
=8823=E6=97=A5 =E9=80=B1=E4=B8=89 =E4=B8=8B=E5=8D=882:57=E5=AF=AB=E9=81=93=
=EF=BC=9A
>
> Chung-Chiang Cheng <shepjeng@gmail.com> writes:
>
> >
> > Yes. I think it's not perfect but a better choice to distinguish betwee=
n
> > change-time and creation-time. While change-time is no longer saved to
> > disk, the new behavior maintains the semantic of "creation" and is more
> > compatible with non-linux systems.
>
> Ok, right, creation time is good. But what I'm saying is about new ctime
> behavior.
>
> Now, you allow to change ctime as old behavior, but it is not saved. Why
> this behavior was preferred?
>
> Just for example, I think we can ignore ctime change, and define new
> behavior is as ctime=3D=3Dmtime always. This will prevent time wrap/backw=
ard
> etc.

I got your point. Correctly speaking ctime is not really dropped but mixed
with mtime after my patch. They share the same field on disk. Before that
ctime is mixed with crtime.

I choose this new behavior because ctime and mtime are similar concepts.
ctime is the update time for file attributes, and mtime is the one for file
contents. They are updated together most of the time with few exceptions
(rename, rmdir, unlink) in the current FAT implementation.

Thanks.

>
> Thanks.
