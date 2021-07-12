Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EFEA83C6315
	for <lists+linux-fsdevel@lfdr.de>; Mon, 12 Jul 2021 21:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234874AbhGLTFC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Jul 2021 15:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbhGLTFB (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Jul 2021 15:05:01 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4526C0613E5
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 12:02:11 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id t17so45391951lfq.0
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 12:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=05TXon0OWe0TdWnzF0gYVTRsMbmyDd8KVA9oD5hUpeA=;
        b=RqribjyX+FgXk9Jlj1MPkaZaCLoRgO3jHrV1pXk9CclhaTPG8owXmmkJgBhZo1CjnU
         tZ401uNZXW7wfn+Uu5W1PFB3J2aiKVhH3yid4QzaiT0DMJHZ6oZLTDTuw4qn8dg5cRUB
         w0rTi/NeXer18ql9FgnwcpxRQn3dmD9kafBpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=05TXon0OWe0TdWnzF0gYVTRsMbmyDd8KVA9oD5hUpeA=;
        b=eaUxbTOE0T4OnjkSJIqGcL0DNQnK1RATTg/KCvccsfG+AohWNxPfh/iNO7YHU9nzQ2
         mnh7aA2GZbmm4/g8fai1yUARlZY9mNptmwD3B3Lj/g+kZbgk3Jma750+vWM0HkdYtO/c
         i8mfebmrgvHpjkKAdzdeBu+Uo88UPHpO/Ok3f3wWD+dpQR9TFnwsIV7JIWD7GvYYss5b
         ti3OllII8J7AJyS2b8G7dRzlQ5cuV1nO1hNIZIC7W6ZKLg8qio5s2IeVXuULEpT8eYey
         0pxXFYrVTK5g5A0U5iyihlZmGrStoRYyuHCw7omwFmg8Kszhu4hV32mUt4TJ3qj9Zypi
         QPaw==
X-Gm-Message-State: AOAM531KsZBdjtlwtdXF+0k1bTUHiEQ/1Ss9G0ugaMyP/4unTFaccUst
        fOymy77DaY1hQ2HigPFyMmwJVQvdkw/w/RlT
X-Google-Smtp-Source: ABdhPJwBYDSWmE/NGgBVc5gbBI3sGWQgjT6Dljkk4e1WaN8Y8gsV1TIsV4dXI9YlvpaSLQ9xQxGyLw==
X-Received: by 2002:a19:f004:: with SMTP id p4mr163558lfc.503.1626116530023;
        Mon, 12 Jul 2021 12:02:10 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id d17sm507008ljl.110.2021.07.12.12.02.09
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jul 2021 12:02:09 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id n14so45304644lfu.8
        for <linux-fsdevel@vger.kernel.org>; Mon, 12 Jul 2021 12:02:09 -0700 (PDT)
X-Received: by 2002:ac2:42d6:: with SMTP id n22mr175625lfl.41.1626116528651;
 Mon, 12 Jul 2021 12:02:08 -0700 (PDT)
MIME-Version: 1.0
References: <20210712123649.1102392-1-dkadashev@gmail.com> <CAOKbgA4EqwLa3WDK_JcxFAU92pBw4hS8vjQ9p7B-w+5y7yX5Eg@mail.gmail.com>
In-Reply-To: <CAOKbgA4EqwLa3WDK_JcxFAU92pBw4hS8vjQ9p7B-w+5y7yX5Eg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 12 Jul 2021 12:01:52 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiGH-bYqLvjMOv2i48Wb1FQaAj8ukegSMLNbW0yri05rA@mail.gmail.com>
Message-ID: <CAHk-=wiGH-bYqLvjMOv2i48Wb1FQaAj8ukegSMLNbW0yri05rA@mail.gmail.com>
Subject: Re: [PATCH 0/7] namei: clean up retry logic in various do_* functions
To:     Dmitry Kadashev <dkadashev@gmail.com>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        io-uring <io-uring@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jul 12, 2021 at 5:41 AM Dmitry Kadashev <dkadashev@gmail.com> wrote:
>
> Since this is on top of the stuff that is going to be in the Jens' tree
> only until the 5.15 merge window, I'm assuming this series should go
> there as well.

Yeah. Unless Al wants to pick this whole series up.

See my comments about the individual patches - some of them change
code flow, others do. And I think changing code flow as part of
cleanup is ok, but it at the very least needs to be mentioned (and it
might be good to do the "move code that is idempotent inside the
retry" as a separate patch from documentation purposes)

           Linus
