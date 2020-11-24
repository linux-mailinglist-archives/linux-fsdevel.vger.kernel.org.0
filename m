Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C719A2C2504
	for <lists+linux-fsdevel@lfdr.de>; Tue, 24 Nov 2020 12:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733110AbgKXLw6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 24 Nov 2020 06:52:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733105AbgKXLw5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 24 Nov 2020 06:52:57 -0500
Received: from mail-vs1-xe41.google.com (mail-vs1-xe41.google.com [IPv6:2607:f8b0:4864:20::e41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 890EDC0617A6
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 03:52:57 -0800 (PST)
Received: by mail-vs1-xe41.google.com with SMTP id x11so10914460vsx.12
        for <linux-fsdevel@vger.kernel.org>; Tue, 24 Nov 2020 03:52:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QYwpUXf9MOd1UXy87SihXPs0Lb5kLuS+SByPITmbzJ4=;
        b=k6D884fBWg+S/eH9wqhr0dJ1XnzXoK4yq0GDnUZGLEqC4fmd+0BAo7DZVsfzDtPRqd
         7oZ9q2dHy7G4z486oytIYVp88b1jx3zZG1jhVFCkWy+v1L/xvE9b9rJKbmckPJ0MiPKR
         VKu/MZEkF/GYxmzUhsoSkMoOKX8olmHJMkAFc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QYwpUXf9MOd1UXy87SihXPs0Lb5kLuS+SByPITmbzJ4=;
        b=dHasMwNCtXAtnu6kNnEyeCyAgbfbRLa5PRReuMXHNsada+egI3eVGBHUtB0di7xhh6
         J6fe2HO99jWpOjcie+k++vduYkgxkp2gM7JvbAnOWoa4ATzQbOIVeZkMJzWFlnCJ/0iw
         7tQLvR3LuZoY43FwN73CyPDIxnzaQK3mzFovgrQqx5VkytxWkPe6hx4b56mO3kflUVyK
         vdkcL1kKqmHueTzTSpw7qrozQllHfdQcMFmapRd57qU751vnhR4vA2My5CGCvPrAxgT2
         ucVzQBlGx5RN768a1yjlz0dPXSbJTNxusDhP5KCQcU3Z/a0Sr1IlwviYqC+xV2ddMlnr
         92Cw==
X-Gm-Message-State: AOAM530UeDGesX+NlRakdGGrDfR7WGkwSGE4r3vNHZQu8QjOEASGW5yt
        Wsr9gqmGqTl07dNg+zAqyXzdi1VOIS8Vb/fJedgtbg==
X-Google-Smtp-Source: ABdhPJwHqp8yckVbn5c3DrIHcZxQcwm+qnD7l8Sy5hsn+ZsG5bM56gagA8ZuwiB1itkaYHpkkPuC5X0x+6lTIhVjBGM=
X-Received: by 2002:a67:ce1a:: with SMTP id s26mr3248965vsl.0.1606218776732;
 Tue, 24 Nov 2020 03:52:56 -0800 (PST)
MIME-Version: 1.0
References: <20201123141207.GC327006@miu.piliscsaba.redhat.com> <20201124115004.GB22619@lst.de>
In-Reply-To: <20201124115004.GB22619@lst.de>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 24 Nov 2020 12:52:45 +0100
Message-ID: <CAJfpegvb7U4wgYpe4KPtayM5kpdjX1SkhrgNLbxaRmm_Tn8noA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: fs{set,get}attr iops
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Dmitry Vyukov <dvyukov@google.com>,
        linux-fsdevel@vger.kernel.org,
        overlayfs <linux-unionfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 24, 2020 at 12:50 PM Christoph Hellwig <hch@lst.de> wrote:
>
> Looks pretty neat from a quick look, but you probably want to split
> it into a patch or two adding the infrastructure and then one patch
> per file system to ease review and bisection.

Definitely.  Just wanted to get this out to get early feedback.

Thanks,
Miklos
