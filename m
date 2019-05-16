Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9B16920312
	for <lists+linux-fsdevel@lfdr.de>; Thu, 16 May 2019 12:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726667AbfEPKDV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 16 May 2019 06:03:21 -0400
Received: from mail-qt1-f195.google.com ([209.85.160.195]:46794 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726336AbfEPKDV (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 16 May 2019 06:03:21 -0400
Received: by mail-qt1-f195.google.com with SMTP id z19so3079570qtz.13;
        Thu, 16 May 2019 03:03:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4ze2CI8GxO1Dv+DvbrYJ5BaRYjbTbUEsBcbEyw7KMyE=;
        b=SiXWks6e40uCcjoK7bj5UJvXx39pVMjgSbL48l5NelUlcm+UFCgnT4K1RL26V4UhZ0
         vH/432IIJtgH1suDha6rPRkjj+e4wLIYpWRBKPolll2XS4cJdJENHgfKDoKs82dbGgyH
         2eWy+85ahLmwKEeF12vZ80D5LmZQsWxMBanwklZ5wY3OKCvCIk2h+zYgG6LEbzWVf17s
         y0VOXjcG9THbJSoIKk/a+IGLZnsyREcGi3caEzKcQQVOn5sAbeGySqgYyRa3xhpjYkBA
         4JwBNlR6plB6wtsrBNHt1yFR0uh+vmdpPMQohNt9QT8loDZ403XIh978AUqUWYBy2gS/
         kYuw==
X-Gm-Message-State: APjAAAU3xcSvQcSIwUjxfgvh1KnLosSBTfjYWv3s84LwBU5Ds8OWml2s
        w6SYGNfuK9ms9Ku8Gjao2aIFLzQ4BQzZ1qOOvyI=
X-Google-Smtp-Source: APXvYqwScjnVl6A5sBREzjXDTTeEr7nhc/TvBtwNrIkPnYNqC5c+5vjpaW7JJP+EZi34NViTiJm2BJB5s/kVb8BeVfk=
X-Received: by 2002:a0c:980b:: with SMTP id c11mr39432289qvd.115.1558001000574;
 Thu, 16 May 2019 03:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <20190516085810.31077-1-rpenyaev@suse.de> <20190516085810.31077-14-rpenyaev@suse.de>
In-Reply-To: <20190516085810.31077-14-rpenyaev@suse.de>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 16 May 2019 12:03:04 +0200
Message-ID: <CAK8P3a2-fN_BHEnEHvf4X9Ysy4t0_SnJetQLvFU1kFa3OtM0fQ@mail.gmail.com>
Subject: Re: [PATCH v3 13/13] epoll: implement epoll_create2() syscall
To:     Roman Penyaev <rpenyaev@suse.de>
Cc:     Azat Khuzhin <azat@libevent.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 16, 2019 at 10:59 AM Roman Penyaev <rpenyaev@suse.de> wrote:
>
> epoll_create2() is needed to accept EPOLL_USERPOLL flags
> and size, i.e. this patch wires up polling from userspace.

Could you add the system call to all syscall*.tbl files at the same time here?

        Arnd
