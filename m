Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16EEB245329
	for <lists+linux-fsdevel@lfdr.de>; Sat, 15 Aug 2020 23:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729356AbgHOV6x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 17:58:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728935AbgHOVvy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:54 -0400
Received: from mail-il1-x145.google.com (mail-il1-x145.google.com [IPv6:2607:f8b0:4864:20::145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4435BC0F26F9
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:04 -0700 (PDT)
Received: by mail-il1-x145.google.com with SMTP id t79so8898988ild.5
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=4xpDMl3NeXZcwdAiC+yVFHrHRUJEIDgJ5ulLpZwqEjI=;
        b=YVX76WoNb8a/kmckWSLXrmRknRo+JlzKrkSdD1qm7fM454YInwbYsjb/mdH7GI1fcq
         Wra4Bndeb8+WafGOMBrB3ZM9xZ6B0TeA7laul6bMomU77G0E1T10DAjAaCJz1NZ2m6nj
         /+X0Vl4rsYyytg14it4lUqTlsjyGk2Nsupw4wHVJpIXU9Hj3cIB71hIa74Y4+u6vJBNP
         DGWpL9gfPjeVENxAteOYdUMC4T93F53WcDomuhLga7hZqo9tNjzOJmTCi+iFfyypsRSD
         zpybKED1FEisJf4n1xHRB0Z+Od6gAHpJK25LZUIu8jS4FaLbV6FMnGzbemCjzPIbmeTU
         o1ww==
X-Gm-Message-State: AOAM531nzdEdLDQfK90fwKjL/fdh4G1Yfdq5XKGN8VdmHHuqOpGFCybT
        yf3tFUawZKDzD57aldhttN2cHHlf6RzLH997w5K8wERUUcgl
X-Google-Smtp-Source: ABdhPJwWbQqFhbKiJRtugfK4oKOj21an5kZquR9VFiI9RweoGgikPQvFcrcRyVgyQeEnOHoeb3Up7TqAFi6Ze2gqNRsgMi9v/td7
MIME-Version: 1.0
X-Received: by 2002:a92:85c8:: with SMTP id f191mr7591361ilh.242.1597515302467;
 Sat, 15 Aug 2020 11:15:02 -0700 (PDT)
Date:   Sat, 15 Aug 2020 11:15:02 -0700
In-Reply-To: <e3494c53-f84e-5152-42b0-f8ddd3ad4ccb@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000207e2405acee84f5@google.com>
Subject: Re: Re: possible deadlock in io_poll_double_wake
From:   syzbot <syzbot+0d56cfeec64f045baffc@syzkaller.appspotmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> #syz dupe general protection fault in io_poll_double_wake

unknown command "dupe"

>
> -- 
> Jens Axboe
>
> -- 
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/e3494c53-f84e-5152-42b0-f8ddd3ad4ccb%40kernel.dk.
