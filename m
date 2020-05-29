Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBC7C1E7242
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 03:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391585AbgE2Bye (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 28 May 2020 21:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391555AbgE2Byc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 28 May 2020 21:54:32 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D47EC08C5C6
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 18:54:31 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id q2so577752ljm.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 18:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=SbSSYfo2woqk0Vl6eANj/3pGpkwuVFMnZscpIkwWehg=;
        b=axMTKiUo678k9Kwfw1J+soo23q6RboVir0DjXK9tdCy9qsS6P1aqarOBokzRq9rSEk
         UHfvFLJaqw2xNmZW8Qd2EMSUoAuEUaO8Zk4nwGpOFFfDXcKfessean2qJ/JDrWWalGv9
         yonOOKFy0GMGZ1sk4IKljUY4pEq2rtjPx0Nto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SbSSYfo2woqk0Vl6eANj/3pGpkwuVFMnZscpIkwWehg=;
        b=KmwPcMA3t7WyA4ObSaR/DQbIhvyhXFFmR9xqB3DElFeEsE0XQy+MepIJ7I8BQWV64/
         ockbUvf/r0YUvkyahrp69Sr9a9LeR6l8IxtKYSl0HWbJcTGWxjlCdRW54unC6TsO4iu4
         Rt/PGzG/Uhh3yXF2+D+kaDLR+Ecgp+VVzl1M8zC/3UYfT+DgDqhHV6E/JpPQTSPrazJq
         P0dVFR+JoHhMGddpZnpm4qKh5SqOToB2tUywuxoHcggPcJarFbLUVjpEw3QWcjKRaQ/h
         HzKN+YUTWbw35UBpGnQVmNV9ylYq2VMBsqtSahWu2XaHzE5wtkbm95N+7hzaOSDexh6Q
         67OA==
X-Gm-Message-State: AOAM532ZZwks3hG0sWnPzshxINLYOFlT0IYPwtqHjTdb0g6MKQhxSild
        VyIwQNKTu4LNWFeee7/sGO/i9KBo9vQ=
X-Google-Smtp-Source: ABdhPJxohNmZGRawqJ6xSYRUQoGjTM7Tp5jtmWmxWUHXj+SXDzhynqZWk9RPIwnQPnkV+WgT4wYbbw==
X-Received: by 2002:a2e:8717:: with SMTP id m23mr2623459lji.300.1590717269457;
        Thu, 28 May 2020 18:54:29 -0700 (PDT)
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com. [209.85.167.42])
        by smtp.gmail.com with ESMTPSA id t27sm1719459ljo.114.2020.05.28.18.54.28
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 18:54:28 -0700 (PDT)
Received: by mail-lf1-f42.google.com with SMTP id u16so324262lfl.8
        for <linux-fsdevel@vger.kernel.org>; Thu, 28 May 2020 18:54:28 -0700 (PDT)
X-Received: by 2002:ac2:504e:: with SMTP id a14mr3166908lfm.30.1590717268099;
 Thu, 28 May 2020 18:54:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200529000345.GV23230@ZenIV.linux.org.uk> <20200529000419.4106697-1-viro@ZenIV.linux.org.uk>
 <20200529000419.4106697-2-viro@ZenIV.linux.org.uk> <CAHk-=wgnxFLm3ZTwx3XYnJL7_zPNSWf1RbMje22joUj9QADnMQ@mail.gmail.com>
 <20200529014753.GZ23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529014753.GZ23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 28 May 2020 18:54:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
Message-ID: <CAHk-=wiBqa6dZ0Sw0DvHjnCp727+0RAwnNCyA=ur_gAE4C05fg@mail.gmail.com>
Subject: Re: [PATCH 2/2] dlmfs: convert dlmfs_file_read() to copy_to_user()
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 28, 2020 at 6:47 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         case S_IFREG:
>                 inode->i_op = &dlmfs_file_inode_operations;
>                 inode->i_fop = &dlmfs_file_operations;
>
>                 i_size_write(inode,  DLM_LVB_LEN);
> is the only thing that does anything to size of that sucker.  IOW, that
> i_size_read() might as well had been an explicit 64.

Heh. Indeed. I did actually grep for i_size_write() use in ocfs2 and
saw several. But I didn't realize to limit it to just the dlmfs part.

So it does that crazy sequence number lock dance on 32-bit just to
read a constant value.

Oh well.

It would be nice to get those follow-up cleanups eventually, but I
guess the general user access cleanups are more important than this
very odd special case silliness.

             Linus
