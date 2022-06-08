Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F301B542BA8
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jun 2022 11:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235108AbiFHJhg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jun 2022 05:37:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235231AbiFHJhH (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:37:07 -0400
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6885ED923D
        for <linux-fsdevel@vger.kernel.org>; Wed,  8 Jun 2022 02:00:36 -0700 (PDT)
Received: by mail-vs1-xe2f.google.com with SMTP id e11so4558307vsh.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 08 Jun 2022 02:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HLgxt9aZ2iL4yPuW7IWOkkDUVvUblyjGvGoRRpBVDCY=;
        b=CJR5y2l4tzW55g11BTkoLz6Q7uj/jXb3OY3NtI+vCM1McB+Rz+NwNwIuv3fQ2ebm4o
         2b7YgJFwHuJPuJq3VWht7Oi2bj9c2VV0TvsgucE/IZGGCPcW7f8H+tZE1Dh6vHT3ns4S
         CJRPkfwrhUOxqMT+g/KqLgi/2vOVuWFVmkJ5Iu19OGNO/Y3t/J8Ykk8d+dEJb9+gNz4D
         T/VmlxJYmQtIYor83xYxRErt4/zF6YooJ1XN2XYH7U0/Z9STs6iyndAxsi+uE2Nx4K8V
         OZb4gC4mXURuHZ81QRWjWxbmjcCpawHbNVd10B2mkGcEzzhfc8IRUuoG7XNmGA+++BZ/
         pPlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HLgxt9aZ2iL4yPuW7IWOkkDUVvUblyjGvGoRRpBVDCY=;
        b=B0jT9t+ykAe2axpsdZzsXlAriCj/T7V9l87eIzbwHDllZwS5CwNFgFFbmItrYzWxIR
         sA0Qd2ORP2QaWxXYdUdq4wZuT4d4a1MESmCk6zjdCNT5LUjSkETy3OTkqyOg2DGXcle7
         ITwlPu+sg6BcmJj56ZZh2GUtI+XxS9KVyQ7sh64q0hF6h7XxS8zrKnMLWB7Yl0g/nDDa
         5j6g4Df9EMwVrGfZ+SHbrJifp9/X4GunhHhF514Fo76mWua7uS+R7g2TyJKsBokOOOBD
         j5UfVo/eYy6bpjASHILNUB2dMHDwtDaoOaCZVectEAuBDCLIRXIJmxSU/au1yoWMyMIJ
         djew==
X-Gm-Message-State: AOAM532rvQpyionNvk8Vx1BgCp7Gq7J98N3ONy4PpqXF/jHIkFJOTLK0
        biZ4yIew6jfhq40iNjcmrjXDBCeW0hUcryev8YtOP75XPvYXfA==
X-Google-Smtp-Source: ABdhPJy8sBOCVI+r+PqKOgI2YdsAdJ0ZWRGjrzePuVW/592sPWy28zMThhtmfSewfhGNFjtzS81wRu9etdKB8fMCiew=
X-Received: by 2002:a67:d28f:0:b0:34b:9225:6fda with SMTP id
 z15-20020a67d28f000000b0034b92256fdamr13011983vsi.72.1654678835072; Wed, 08
 Jun 2022 02:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
In-Reply-To: <CAJ-MHhCyDB576-vpcJuazyrO-4Q1UuTprD88pdd0WRzjOx8ptQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Wed, 8 Jun 2022 12:00:23 +0300
Message-ID: <CAOQ4uxj=Cd=R7oj4i3vE+VNcpWGD3W=NpqBu8E09K205W-CTAA@mail.gmail.com>
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

On Wed, Jun 8, 2022 at 11:31 AM Gal Rosen <gal.rosen@cybereason.com> wrote:
>
> Hi Jack,
>
> Can you provide details on the reason I sometimes get read errors on events that I get from FANOTIFY ?
> My user space program watches on all mount points in the system and sometimes when in parallel I run full scan with another application on all my files in the endpoint, I get a read error when trying to read from the FANOTIFY fd on a new event.
> The errno is sometimes EPERM (Operation not permitted) and sometimes EMFILE (Too many open files).
>

Hi Gal,

EPERM is a bit surprising assuming that your process has CAP_SYS_ADMIN,
so needs investigating, but EMFILE is quite obvious.
Every event read needs to open a fd to place in event->fd.
If you exceed your configured limit, this error is expected.
You can bump the limit as CAP_SYS_ADMIN if that helps.

> The last time I saw these errors, it was on RHEL 8.5, kernel 4.18.0-348.23.1.el8_5.x86_64.

Does your application even use permission events?
If it doesn't then watching with a newer kernel (>5.1) and FAN_ERPORT_FID
is going to be more efficient in resources and you wont need to worry
about open files limits.

Thanks,
Amir.
