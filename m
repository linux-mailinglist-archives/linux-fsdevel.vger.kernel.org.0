Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC8631190F
	for <lists+linux-fsdevel@lfdr.de>; Sat,  6 Feb 2021 03:54:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231815AbhBFCyI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 21:54:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbhBFCks (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:48 -0500
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A330C08ECA9;
        Fri,  5 Feb 2021 14:37:58 -0800 (PST)
Received: by mail-qt1-x82a.google.com with SMTP id s11so2429280qtq.10;
        Fri, 05 Feb 2021 14:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6IKJbad5BZA4QttxVsCgM6KQ4YVmE8DBAtfOewHjiuE=;
        b=kkrPCAlnHU69A5WtArRJvMpmJ8XdLCyaU9hUZpIDeRpyOT7xe7VTNcd20m5Owd2bLn
         3NmdjdFkNU++JRFE8sfTRmdEvc6ONDpPKYAoDyvZMTQy4OBSjTQxsRqRgUJ2PdthQbAC
         tScB4A7IQvnBObx8NnM2yx88NnXwRFT6HwmPcAt/VtajuQ5oXLjody8A3IM1phjH12bL
         mFQPYja47/T54k02/RojavyclmUs2n7KJiqXEUYqc6Pe+4JhiMxoOqoeuyw7SR1fU6i2
         z1VU+dQbg4tQqHGZZMxMsbdehy+yWhrrhWZdUJKJIFwrsTxFOq+VYhSbrtfXWXp646+6
         geYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6IKJbad5BZA4QttxVsCgM6KQ4YVmE8DBAtfOewHjiuE=;
        b=U3ePiJeZqU7LTwvZytjrYJEz3ygLK+S6ebymeyn56e61OgA7oCzlNMROGJkMnAzG+w
         YwqWkx7JCWxIZdpdx9NIPSJxcq46+3uSZHYzsbbeBFSSTni03KqF4YiA3UOzxTCeDMdw
         dWdGhbXz3dBhO8mbOygXPH0dgTobx6ZY0m0aE4OAoGKaYMSWi881uqyR3Bo1QY68RqAG
         8CeHqxfOsY7vyIE4i8R9y5QRL4ToAK12rtOBBUCgGdipTUaGOSlygrRUAAK0o5d2E7Q0
         beVSefHHj2cIf83Tos4tDKmIZUR67woBOGEVBWMb/FQeDgOQSKsRwLUF+qS1qYie813l
         vfZg==
X-Gm-Message-State: AOAM532aOFJdrSo8vK9a4MULS1OwR5zgzKUNO8gqwn2bZeMEjHl4RUT0
        6I/VcarrtPL5O/wz5Iwx0gi0/YRdD5hW7j9f4+Z67VDZ
X-Google-Smtp-Source: ABdhPJwMxePDpR78n8sUb+VjbYtGhiOZYqSlvkzLop8R8CJm5MdX0a169znS7XzAIHKAbGJYt0LSQAvVJuZcAlRVt6Y=
X-Received: by 2002:ac8:7511:: with SMTP id u17mr6168541qtq.285.1612564677456;
 Fri, 05 Feb 2021 14:37:57 -0800 (PST)
MIME-Version: 1.0
References: <20210205045217.552927-1-enbyamy@gmail.com> <20210205131910.GJ1993@twin.jikos.cz>
 <CAE1WUT4az3ZZ8OU2AS2xxi9h1TbW958ivNXr53jinqHK5vuzMg@mail.gmail.com>
In-Reply-To: <CAE1WUT4az3ZZ8OU2AS2xxi9h1TbW958ivNXr53jinqHK5vuzMg@mail.gmail.com>
From:   Richard Weinberger <richard.weinberger@gmail.com>
Date:   Fri, 5 Feb 2021 23:37:46 +0100
Message-ID: <CAFLxGvz0ZnTs1B7v3R+Zefd5BhE9ximFpgKL8zRmGfOdBrsVfw@mail.gmail.com>
Subject: Re: [PATCH 0/3] fs/efs: Follow kernel style guide
To:     Amy Parker <enbyamy@gmail.com>
Cc:     dsterba@suse.cz, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 11:26 PM Amy Parker <enbyamy@gmail.com> wrote:
>
> On Fri, Feb 5, 2021 at 5:1 AM David Sterba <dsterba@suse.cz> wrote:
> >
> > On Thu, Feb 04, 2021 at 08:52:14PM -0800, Amy Parker wrote:
> > > As the EFS driver is old and non-maintained,
> >
> > Is anybody using EFS on current kernels? There's not much point updating
> > it to current coding style, deleting fs/efs is probably the best option.
> >
>
> Wouldn't be surprised if there's a few systems out there that haven't
> migrated at all.

Before ripping it from the kernel source you could do a FUSE port of EFS.
That way old filesystems can still get used on Linux.

-- 
Thanks,
//richard
