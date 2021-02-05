Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 516AC311532
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Feb 2021 23:32:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232648AbhBEWYn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Feb 2021 17:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbhBEOZQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Feb 2021 09:25:16 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BB1FC061797;
        Fri,  5 Feb 2021 08:03:23 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id n7so7901695oic.11;
        Fri, 05 Feb 2021 08:03:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=FVdQ5ukkP9/XbYX/8CVztmsEIJMufgkJkRC2gxyWHPI=;
        b=iC4JrNHZTN8cnhAfbFpXAv6CrFup/sVyTxWB7UeMqnn+hr1kvuuCSI8K3p2ARted3u
         59LNcUye0Sy0/hKfpUXWC82aIyZwK8dCGo5zBKK++Nj01iZFkMSbMGPm356DrQKJRz1r
         +AV6IgEH03dFHV2pGfYjGATnvdelNkX17KWcEdLdC0esiq307LeLHH2TZEirXbbape4e
         5YobvlpVcF4g3OOFXMPnzLx6GlD9LbzjGMZWwGVh+C/NJdCdqTjx8Ve6LZsdxp7M9Don
         piF1R2oOaNnqfbNVg6svIWto6ew7TKfXoi45NqqXNLygS8/z+tHJqKAluNwbRb8tzXnh
         PK+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=FVdQ5ukkP9/XbYX/8CVztmsEIJMufgkJkRC2gxyWHPI=;
        b=AA83PO6GF+GEVH3eFNc7ma3qgWct6qwxMlvT8EnXhyexnvO8B5sLJy/xlHt1xqJOJu
         sRjX50U93Sv7FhLBV/o2TMEk5E2F7kW0kqhOf+SG+hMnseX5zBW8LTmrve4WA5llPvdZ
         NIXilpvO9qHh6zwySc8A36WmGy6KRXE4Da7EHR784i0B+5AInoDWT2NWRyDgIonmwxJK
         VvddfpIPaFueWWk2A6tADM79fL/wZET2ntHsvA07m543C8DXdF0+trdonZHO+CZxz+jG
         ZvvWu4E7rcdDluB23R3BeMGoaKktObsK+XwqMxLuhDnwZbLcVpHVoXU6RoWNgVwDJ5gT
         gC7w==
X-Gm-Message-State: AOAM533qsHsYyD1N953i4f2G0SVbJVqtdIxDGVrKq41knRp9iNIp0p/n
        TIlI6IySehmMYoGXEyWngh+AoWagzeez06lW5pCpTjtL6FU=
X-Google-Smtp-Source: ABdhPJy6jCzEz03JnQXVhbqT+cuIUDmp9ZKy2c51bvVOq36mVzOPREDPhQTk2WphtOI6JFjfXJn66s2Kn9PDiuB374M=
X-Received: by 2002:a05:6808:1290:: with SMTP id a16mr3368879oiw.161.1612539418567;
 Fri, 05 Feb 2021 07:36:58 -0800 (PST)
MIME-Version: 1.0
References: <20210205045217.552927-1-enbyamy@gmail.com> <20210205131910.GJ1993@twin.jikos.cz>
In-Reply-To: <20210205131910.GJ1993@twin.jikos.cz>
From:   Amy Parker <enbyamy@gmail.com>
Date:   Fri, 5 Feb 2021 07:36:47 -0800
Message-ID: <CAE1WUT4az3ZZ8OU2AS2xxi9h1TbW958ivNXr53jinqHK5vuzMg@mail.gmail.com>
Subject: Re: [PATCH 0/3] fs/efs: Follow kernel style guide
To:     dsterba@suse.cz, Amy Parker <enbyamy@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 5, 2021 at 5:1 AM David Sterba <dsterba@suse.cz> wrote:
>
> On Thu, Feb 04, 2021 at 08:52:14PM -0800, Amy Parker wrote:
> > As the EFS driver is old and non-maintained,
>
> Is anybody using EFS on current kernels? There's not much point updating
> it to current coding style, deleting fs/efs is probably the best option.
>

Wouldn't be surprised if there's a few systems out there that haven't
migrated at all.

> The EFS name is common for several filesystems, not to be confused with
> eg.  Encrypted File System. In linux it's the IRIX version, check
> Kconfig, and you could hardly find the utilities to create such
> filesystem.

Ah yep, good point.

   -Amy IP
