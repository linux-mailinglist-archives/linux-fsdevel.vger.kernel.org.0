Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AD13E138D3D
	for <lists+linux-fsdevel@lfdr.de>; Mon, 13 Jan 2020 09:52:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbgAMIwI (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 03:52:08 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:32848 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728682AbgAMIwI (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 03:52:08 -0500
Received: by mail-io1-f68.google.com with SMTP id z8so8968861ioh.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 13 Jan 2020 00:52:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WguZovr7w2m2X1zQC6+qX9nLM78GMuCabyk3ve+En7w=;
        b=iUMNVIahZJ+iYbyruFJTQpGPwrHA6AbG3SEi1ryfNGcBbqSZhlOZ972H5JVFhpaJu3
         SuxTyCywmNR32/JAz023KaCvReKJ2xvTMZkEU+2+rGlm/PxbAHWugOvhz1JzW5YAkn7w
         X1Y9vVnN8ThfKMFcwdJLuJhJhmVOchINsZaxE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WguZovr7w2m2X1zQC6+qX9nLM78GMuCabyk3ve+En7w=;
        b=HygHqwBo5V108rSWzT/tpi+xCAR6LedXZeJ/d8ItSkO6AIEFoVmd/hS2mBadNbBv/X
         GqSJZX5g9MKd3x4ouh8gIDd0ab+wEnwQPNKKmUTMR785G7x7jMy/yqOnfMoFHN5lIVIu
         oyzjWA0S5puYgc2ArvCPqfQy3PpL+PX3tk9sg6BPbgN2kPlipjTUSHcgPjf1YOqKfzrq
         rg2j6UA9PLeQj8KoMhz+ZJEvxGXLpnBzpZTDxo/iPNHszsh7ExidzaVCneeETDV3XKoa
         qQK4/jxcYlL+d+QnoaY4SLj5qr89A4j5JIAHjX4GjzlhRtBF5mEx+oCl5MF5qhJ6uYFr
         fVFw==
X-Gm-Message-State: APjAAAU0obVSoPnW1QbwpmAafGkvNVOzDXIEdv6xRf9MqN1vyJ6GBPZl
        NrcWDg0tRikBjyJdLIYE9VtraGqSnCRBpvmEc95VJA==
X-Google-Smtp-Source: APXvYqyD1z3AhO+BunsjSlb7c6IJA/YCCugP+yTkUD3iDk7YUduoV/eRTFouDc06SaotaswtXWIGMt+FAjQFrWE+B0I=
X-Received: by 2002:a02:6a10:: with SMTP id l16mr13056335jac.77.1578905527652;
 Mon, 13 Jan 2020 00:52:07 -0800 (PST)
MIME-Version: 1.0
References: <20191231185110.809467-1-dwlsalmeida@gmail.com> <20200110110923.31fc56e5@lwn.net>
In-Reply-To: <20200110110923.31fc56e5@lwn.net>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jan 2020 09:51:56 +0100
Message-ID: <CAJfpegsBbLWaF43WtyTo8y-_sUjLi=60sQoXHDatsSVg8m68PQ@mail.gmail.com>
Subject: Re: [PATCH v4] Documentation: filesystems: convert fuse to RST
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>,
        markus.heiser@darmarit.de, linux-fsdevel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 10, 2020 at 7:09 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> On Tue, 31 Dec 2019 15:51:10 -0300
> "Daniel W. S. Almeida" <dwlsalmeida@gmail.com> wrote:
>
> > From: "Daniel W. S. Almeida" <dwlsalmeida@gmail.com>
> >
> > Converts fuse.txt to reStructuredText format, improving the presentation
> > without changing much of the underlying content.
> >
> > Signed-off-by: Daniel W. S. Almeida <dwlsalmeida@gmail.com>
>
> So I note that the last non-typo-fix change to this document happened in
> 2006, which leads me to suspect that it might be just a wee bit out of
> date.  Miklos, what's the story here?  Should we put a warning at the top?

The document seems to be mostly valid still.

It would be good to have more documentation, though...

Thanks,
Miklos
