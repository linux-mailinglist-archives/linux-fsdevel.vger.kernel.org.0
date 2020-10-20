Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0995293E64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 20 Oct 2020 16:14:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2407934AbgJTOON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 20 Oct 2020 10:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2407905AbgJTOON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 20 Oct 2020 10:14:13 -0400
Received: from mail-vs1-xe43.google.com (mail-vs1-xe43.google.com [IPv6:2607:f8b0:4864:20::e43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10DAAC061755
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 07:14:12 -0700 (PDT)
Received: by mail-vs1-xe43.google.com with SMTP id l6so1214411vsr.7
        for <linux-fsdevel@vger.kernel.org>; Tue, 20 Oct 2020 07:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DPNh0mxf9W6nrU5UX0j2gl4RwbbkCGAtatdB/XKqpro=;
        b=lqqnpGrBQdyMv1l37UevFLNxp3WUgIUOACNCF8SpUYNHdaHYcliVGGgq76k/QKKDo/
         +oVNmKgiysVaRdKU4pQQc75Wye7iCz0tgTPpbUzawUTlHHOihIpKtG29ZKDOa/UM9pJc
         f+tBoyKGRSkMpkElEg7pjZ7S/csPScvoA7SKM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DPNh0mxf9W6nrU5UX0j2gl4RwbbkCGAtatdB/XKqpro=;
        b=IVWkp+AbUtf5tGpqUaJYBomgPvZ1JYGNIM9euvjcEpEJN6y2EVXeYQLm5f8mnmBPs1
         eSGFf8W7rVLTYO/j64ftFuymtJcS0rxHHysf9849siYjK4Kv8e2vSX7tPhcNUM7UHIxe
         J5LGyenEOIU4PJZ73CmRK8uzE9LIEsz7VwA7M0t9+ytw9iav+gY+aP7YUrz0AhD52Zrg
         VSFSA6gDJ0io+GITI/2+rCkmGXKcmmGRUWwKjq9nPKY1bkBqCOEhNpCSk0sXgoAWiDZe
         lXhRJXheSryOmTFY7a+dDlNfyArlVCibNC7I2m0ted89iXKJNZxQXQZ6OLJHaxIJ4tm5
         yKvw==
X-Gm-Message-State: AOAM533aQ4HTmWLh7xEz51L0LbxMiXFIstaJJDFc2JZS5enugaNXD0Ld
        O+oxkL7BwE2DJlvmMeAEmzGuh4tx1/TJkWN5bhbMiVdxApTKPA==
X-Google-Smtp-Source: ABdhPJwdDrRYp58kKWKWIataUpj/UchoK20xPX6MgA56OVPjB+Xk6lXCGx8fwpJt1MJ81+ZWRTnN9iNsCkWF1Wehz6I=
X-Received: by 2002:a67:3241:: with SMTP id y62mr1960015vsy.47.1603203251204;
 Tue, 20 Oct 2020 07:14:11 -0700 (PDT)
MIME-Version: 1.0
References: <20201016160443.18685-1-willy@infradead.org> <20201016160443.18685-14-willy@infradead.org>
In-Reply-To: <20201016160443.18685-14-willy@infradead.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Tue, 20 Oct 2020 16:13:59 +0200
Message-ID: <CAJfpegt=H5kV9vGrNvxfwi=11-OUpZKKu5eYjc+=-cH2DFOWGA@mail.gmail.com>
Subject: Re: [PATCH v3 13/18] fuse: Tell the VFS that readpage was synchronous
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 6:04 PM Matthew Wilcox (Oracle)
<willy@infradead.org> wrote:
>
> The fuse readpage implementation was already synchronous, so use
> AOP_UPDATED_PAGE to avoid cycling the page lock.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>

Acked-by: Miklos Szeredi <mszeredi@redhat.com>

Thanks,
Miklos
