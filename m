Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 622DB543283
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 16:26:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241136AbiFHO0V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 10:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241119AbiFHO0U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 10:26:20 -0400
Received: from mail-vk1-xa2a.google.com (mail-vk1-xa2a.google.com [IPv6:2607:f8b0:4864:20::a2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C90181D82DF
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 07:26:18 -0700 (PDT)
Received: by mail-vk1-xa2a.google.com with SMTP id n203so1770299vke.7
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 07:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hvpRrGDRjqUGaBYOJqCb4XeNao3Bc5jvLInZKg/uWX4=;
        b=awc5yYdB3ofNky6ZA/N30wA8KX9v2n5gs8H4iY8TOwD+J3ftByjYWNX/yyg+LJY3Wd
         WphFdXvTvSn+/IMkWlA5st6QKXD9ll23G+WjRkn0Xr5e+4LFIeQvsoipAgqbNidLwg4i
         UTsVT22b74RZfGr/YbHoWqrHAeRQ5T95xxwRMROrPaxtAb3D0AIGsdLn/NmYW2IfKCXn
         0qCgXbI5jc+WlNbksw160aytQKiY6xLWk2AJvzISfalc69sSL4llV5Sb+sUZAK/I6Wff
         sMDwK6xZKDmL2JG28W6qvxWtk/yQpatS3BxX1vIXSvGQc9JAmjelJBPO0DWFvXxVxhQu
         rjaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hvpRrGDRjqUGaBYOJqCb4XeNao3Bc5jvLInZKg/uWX4=;
        b=gCaJ9QKTUhZHNCmJ31xRgDfaYxncPqQnFAvU4lYWwwOzQVMW/kffKLKwJO6ZPL00tw
         RrQWnwk3WxkVxjdGRnpyo0ikAUa017ebHnbmNj6F0w5JDEeLqr8xHXZXi92V0Win1+nk
         3JKhTTEzubDQFjXCiVu7DnsFz4ZFP3WvgRFbLN4EcJ6FtEjdhtZFpfqndkTLYqScV/BE
         3nREBxVpObWS2uoR52lze1vGWrBWm1vCY5amy04yYWiS6nJ8lp0GB+1xCND2Meuw2PyJ
         OXGnfMQrZD8OskELkQVggSqIpcI2Uhm2AAmKzQpoE5Zm9yr25YX5YlxJCYMmg+ey+x+I
         voYw==
X-Gm-Message-State: AOAM531xn29M4kbAUIibvXmJrxyWloHENeRJR98781zNPbVCcXkdshOc
        m6LBdBCSyIqUcNetLNr3vZjUn6vVusHv0XheR5Q=
X-Google-Smtp-Source: ABdhPJx3bWOQk1U1FL61kyPnU1jPRoGN2yLfxYD5RskPJetB4HsW/kq5WGdGLA9F8cZDwGjCGFzNDoXqH+pJ+IPzsDk=
X-Received: by 2002:a1f:2b46:0:b0:35d:74a8:ca14 with SMTP id
 r67-20020a1f2b46000000b0035d74a8ca14mr12677619vkr.36.1654698377667; Wed, 08
 Jun 2022 07:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
 <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
 <CAJ-MHhCJYc_NDRvMfB2S9tHTvOdc4Tqrzo=wRNkqedSLyfAnRg@mail.gmail.com>
 <CAOQ4uxjH9o_XwowdyjyCYswpfvwRSq9wUAkYvg_XoKULvx23-g@mail.gmail.com> <CAJ-MHhB2sd==f9iMk8TBEd341YCXTaSx_LquKWfXrCSre=8GLw@mail.gmail.com>
In-Reply-To: <CAJ-MHhB2sd==f9iMk8TBEd341YCXTaSx_LquKWfXrCSre=8GLw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 17:26:06 +0300
Message-ID: <CAOQ4uxgzr3WtF68b-Lk2K6xV8+Fe9ZVj+fzrjxh2Xbo4xs0DAQ@mail.gmail.com>
Subject: Re: Failed on reading from FANOTIFY file descriptor
To:     Gal Rosen <gal.rosen@cybereason.com>
Cc:     Jan Kara <jack@suse.cz>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
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

On Wed, Jun 8, 2022 at 3:47 PM Gal Rosen <gal.rosen@cybereason.com> wrote:
>
> Hi Amir,
>
> Our process is running as a root user, is it possible that it has no permission to open a file ?
>

Yes, with SELinux it is definitely possible.
Ask your SELinux experts.

Thanks,
Amir.
