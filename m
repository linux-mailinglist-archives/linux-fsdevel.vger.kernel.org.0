Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E031C1F9DEF
	for <lists+linux-fsdevel@lfdr.de>; Mon, 15 Jun 2020 18:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731087AbgFOQ5V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 15 Jun 2020 12:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728513AbgFOQ5U (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:57:20 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29B57C061A0E
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:57:20 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id y11so20087895ljm.9
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eIkal8pUfONI4oNrGMEW7FJGnsyPgxFx6nFiYlCav8Q=;
        b=BOdfnS1nQ1loTAy3XfZG4v2ypfE6UrK/J+Zd6u9ARxAU0HozZqAjdnCtxoLxulSvq0
         7PoDNtEz3pdUYnk9jHe+VKu0KTcBji19fekNHUB4EqiWzTIqAhfzI/qVn548WkWINsOo
         G2cfvtd1eBk/jMWvfGGb0/G2cdASiBLrgA7w0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eIkal8pUfONI4oNrGMEW7FJGnsyPgxFx6nFiYlCav8Q=;
        b=euZdNtEyuqcb5CfO4Rri8WYRU7KzQR/ERcBHjksdwDUeLo/1txhIKNrmRGIBRsCOIu
         0DrT0e677gqfyeKJEFtXH5j4/RiCHBmVjGEDAKS/d4Bo1LRYj1x2A4AQGVKIcLDc2shR
         THYjodHa+rsNWOsDg55DLDiFfBhu0XzX8nA2Nb7fybecDVITFyjTLQl3ZqpjS2+Kr6yl
         0zGkvfhxVGPiaelVQWisk7QHnUVzLaJPh6a1S7VsUpsiJuxVIAQgZwZxGDi9GimOYYwi
         EjLW4QmjBNUTqFDqQhCm1hLxlA0Q1bQJhDDSid7SgSU0isl2EY4T7fdpZG1lRhMY91TI
         FO7Q==
X-Gm-Message-State: AOAM5309l1qdw43XnPkdIk9sk4c1P/bvfPAJXqYAXaGOaxORuyuz9KB8
        xedfjO58XBDWWlF6FCQWP3Grj7N4aTo=
X-Google-Smtp-Source: ABdhPJw2K7M06eqz/jHp23tt4fkBaFT/IDnA13h2F7mBSXR1PcAsB6fR73fJ6XCDOrvvLCPvCqu5Eg==
X-Received: by 2002:a2e:9804:: with SMTP id a4mr14120229ljj.369.1592240237440;
        Mon, 15 Jun 2020 09:57:17 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id k1sm4674908lja.27.2020.06.15.09.57.16
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:57:16 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id 9so20037032ljv.5
        for <linux-fsdevel@vger.kernel.org>; Mon, 15 Jun 2020 09:57:16 -0700 (PDT)
X-Received: by 2002:a2e:b5d7:: with SMTP id g23mr12503482ljn.70.1592240235665;
 Mon, 15 Jun 2020 09:57:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200615121257.798894-1-hch@lst.de> <20200615121257.798894-11-hch@lst.de>
 <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
In-Reply-To: <CAHk-=wiBJjjV4NuKr_z2Q3vWEXSoGtAmkH=jZ0SkBJ=wZh4=hw@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 15 Jun 2020 09:56:59 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiVjH4C+PzyHfsR0+GzFUf_2XX5H_tQoHGqp+pMGuec7Q@mail.gmail.com>
Message-ID: <CAHk-=wiVjH4C+PzyHfsR0+GzFUf_2XX5H_tQoHGqp+pMGuec7Q@mail.gmail.com>
Subject: Re: [PATCH 10/13] integrity/ima: switch to using __kernel_read
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Ian Kent <raven@themaw.net>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        LSM List <linux-security-module@vger.kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jun 15, 2020 at 9:46 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> It worries me that you're making these kinds of transformations where
> the comments imply it's a no-op, but the actual code doesn't agree.

Note that it's not that I think the FMODE_READ check is necessarily
_needed_. It's more the discrepancy between the commit message and the
code change that I don't like.

The commit message implies that __kernel_read() has _more_ checks than
the checks done by integrity_kernel_read(). But it looks like they
aren't so much "more" as they are just "different".

                Linus
