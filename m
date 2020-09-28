Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 409F527B071
	for <lists+linux-fsdevel@lfdr.de>; Mon, 28 Sep 2020 17:01:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726739AbgI1PBY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Sep 2020 11:01:24 -0400
Received: from mail-io1-f69.google.com ([209.85.166.69]:44467 "EHLO
        mail-io1-f69.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726727AbgI1PBX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Sep 2020 11:01:23 -0400
Received: by mail-io1-f69.google.com with SMTP id l8so792005ioa.11
        for <linux-fsdevel@vger.kernel.org>; Mon, 28 Sep 2020 08:01:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id:subject
         :from:to:cc;
        bh=vgUtXMoVzIZuhx8MiM8mjs9qIwIIfUuwYTFaRd2LK1M=;
        b=Dav3ubbYVZcy+r2GX+fCF53yVAJd06VTArG8UMPABmANJbf4V9O7B1ens8pMMzV5qK
         vk77vqkSSt07J+Paa/IGzFmyEG4QnjT/0CqLsgOUdjNJfQPDJYZjkzZc8OXLmY/JSCrv
         eOSD2vMzKIUg0hmdlXCa2M8198GHgTxhqvVgglKLczo1QhUIOzEw4bb54n1EJByDKlwD
         mgazZAlYBuAlrfMq9YNwyOoHHPgOIXEaqGmN71oKuTCM3mLfglfObHwFmEE59QlEhRFN
         +NSCYX3Tjm8IWRBuQwnRKZA0rUugqcnG7uJmSZTM7I0RaeYKy3VTnmzdvdo0tug9xHoZ
         kp+Q==
X-Gm-Message-State: AOAM533F+DTb9SdsxcagHcnw9bbFywmJSc91EjeH5l/X+eAS2B/vrIRC
        AoPbdXNCO+s4XDZS2R0Qsnom1oSbVw7gsvSxLTFqLSfI3ra+
X-Google-Smtp-Source: ABdhPJzvmXPhbd+OnJjeaLpf0fv/dOPSi+n2gUF1+r+JZy/3sFGdT1z/4lOKD5DI7cxhl3aBCCDj2qXGrL7rRLGXhmlGS74ESKhd
MIME-Version: 1.0
X-Received: by 2002:a92:4805:: with SMTP id v5mr1662666ila.170.1601305282258;
 Mon, 28 Sep 2020 08:01:22 -0700 (PDT)
Date:   Mon, 28 Sep 2020 08:01:22 -0700
In-Reply-To: <69d85830-b846-72ad-7315-545509f3a099@kernel.dk>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000086c59505b060f073@google.com>
Subject: Re: Re: possible deadlock in io_write
From:   syzbot <syzbot+2f8fa4e860edc3066aba@syzkaller.appspotmail.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     axboe@kernel.dk, io-uring@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> Not the prettiest solution, but I don't think that's a real concern as
> this is just for human consumption.
>
> #syz test: git://git.kernel.dk/linux-block io_uring-5.9

This crash does not have a reproducer. I cannot test it.

>
> -- 
> Jens Axboe
>
