Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 739F42453C1
	for <lists+linux-fsdevel@lfdr.de>; Sun, 16 Aug 2020 00:05:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729848AbgHOWEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 15 Aug 2020 18:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728464AbgHOVuy (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:50:54 -0400
Received: from mail-il1-x148.google.com (mail-il1-x148.google.com [IPv6:2607:f8b0:4864:20::148])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DCAC0F26F2
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:01 -0700 (PDT)
Received: by mail-il1-x148.google.com with SMTP id u7so8879488ilj.4
        for <linux-fsdevel@vger.kernel.org>; Sat, 15 Aug 2020 11:15:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=oxh1zcQhSSj1sRDYKLj8pdLk064Zf9K9zDx2kCQjG6E=;
        b=WFy8ZcOnO0ZLEl+hInGAMJkXz+6RsyXk5ennfpYIZVnBpBNBQ3Zc8OLrw8XwW2iEvY
         EnsM0wYiyjexEW0B6ygpUBYjVrEJej4yCylhaVR18TVsobYOxUVEQouTdJRh8KPdo0Xw
         yCIQNNmOY4rj9JXYDWGQ9hhAZGtFuYZfmQyBpC8btog9gKHc4OtI+YGH7olITPzEBXFQ
         Z2keZ9oBkCKaMXE+rqeLPb6O8rLyN+f6pI6jXWWK0DlXsndmVtxMw32coWAf0N+m7ukd
         XoSNs7xIvArJDXJZuMckQtb+PMZxcQnwXj/2QoD7z4xfkXGPb0GZihmK95bJEvucqH/z
         BWBA==
X-Gm-Message-State: AOAM5302Pfm7hcRTbjR5FbqJImcdSabINCQS26i5S4I8474yqRi7cVVw
        d8uNG8WXShMeduvxHbwAVdsuEzXEE+2/y2wg2eDknCDpOUSg
X-Google-Smtp-Source: ABdhPJwKIeEtMwp1Y8DbX5t31FAG0vSEIhEefpQF/pyBQ5lBtW1+CfErzIxRKUS8nmtkvSnig51XIfvJAMACW2/7etVGb8cI+Crj
MIME-Version: 1.0
X-Received: by 2002:a5e:dd4c:: with SMTP id u12mr6289294iop.93.1597515300962;
 Sat, 15 Aug 2020 11:15:00 -0700 (PDT)
Date:   Sat, 15 Aug 2020 11:15:00 -0700
In-Reply-To: <e3494c53-f84e-5152-42b0-f8ddd3ad4ccb@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000009878b05acee84c0@google.com>
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
