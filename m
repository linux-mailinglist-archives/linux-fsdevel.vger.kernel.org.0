Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84306228676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 21 Jul 2020 18:50:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgGUQtj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 21 Jul 2020 12:49:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730259AbgGUQti (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:49:38 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F9E0C0619DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:37 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id s9so24802634ljm.11
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cfw0I9KLEinugvOkAIz5pYOKJ30/9U2i4w2l/E0VlLI=;
        b=PjZtpMWcBcYWc/PE2aBDgylpCarGxoRxa+Aq0zab6N7GaIbKRzPu2GNf3RxtSC05dA
         0K7/GHfK0uf/8tRqEMTILPd7F3g3dNdNNYY6ahsv+8BW0iD5iZnwvyqTPsbIeqjdBP3p
         khN1GHy7kDI63rJCnCaLHtNH6mG1r6HGYxAjk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cfw0I9KLEinugvOkAIz5pYOKJ30/9U2i4w2l/E0VlLI=;
        b=m6E3kkkjacethqv89YYY8u0Djh0OzlwnH6X95QmBZhvEJm12PpsMtzbMQtkKcZ7FNr
         HetNpPVHDvRMzX+jx+uNfx+qOVSsKGycVPGhIqnbNVYBwfS2YrcxHd+VtJIDOnAoli/q
         Eg9Dc1ZRjhTBVVwHb/tBI6p4AFR28CGAIcfkjPK8MSDo8R8zYqXJ5vVRdxF1fECxp0d5
         xBtyjp5EWW7gZZZvbzPfZ9nyWhlEfOxUBJ1OMhLiN2s4mC6eRXAY4Yium7j6tYvzDkBE
         OvMSoRNfqKRsceffkWLT+5aTUmqmPjWIyeZdFUdVtFSmAbJygt9Jbt90DFI3G/t9s4N3
         +OvQ==
X-Gm-Message-State: AOAM5314qgUwRMgKpB1DrlsthY83XL4GzTBRlLp8j/vJi56eCXYGATcu
        9FEgBTKnZuIV7GwNVMrzAehDq2OY8Qc=
X-Google-Smtp-Source: ABdhPJwI/2oR/nL0NL/7P5MIAt1LOrnHrNRfzk1LHWSXjQ9PB0wYgCi/cn4ezGbnLls0WyPOc9Db9w==
X-Received: by 2002:a2e:541b:: with SMTP id i27mr12105830ljb.118.1595350175523;
        Tue, 21 Jul 2020 09:49:35 -0700 (PDT)
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com. [209.85.208.171])
        by smtp.gmail.com with ESMTPSA id e23sm663206lfj.80.2020.07.21.09.49.33
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jul 2020 09:49:34 -0700 (PDT)
Received: by mail-lj1-f171.google.com with SMTP id x9so24798901ljc.5
        for <linux-fsdevel@vger.kernel.org>; Tue, 21 Jul 2020 09:49:33 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr13904367ljc.285.1595350173585;
 Tue, 21 Jul 2020 09:49:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200721162818.197315-1-hch@lst.de> <20200721162818.197315-6-hch@lst.de>
In-Reply-To: <20200721162818.197315-6-hch@lst.de>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 21 Jul 2020 09:49:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Message-ID: <CAHk-=wi0GQqAq6VSY=O2iWnPuuS54TkyRBH5B9Ca0Kg5A9d2aA@mail.gmail.com>
Subject: Re: [PATCH 05/24] devtmpfs: open code ksys_chdir and ksys_chroot
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-raid@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 21, 2020 at 9:28 AM Christoph Hellwig <hch@lst.de> wrote:
>
> +
> +       /* traverse into overmounted root and then chroot to it */
> +       if (!kern_path("/..", LOOKUP_FOLLOW | LOOKUP_DIRECTORY, &path) &&
> +           !inode_permission(path.dentry->d_inode, MAY_EXEC | MAY_CHDIR) &&
> +           ns_capable(current_user_ns(), CAP_SYS_CHROOT) &&
> +           !security_path_chroot(&path)) {
> +               set_fs_pwd(current->fs, &path);
> +               set_fs_root(current->fs, &path);
> +       }
> +       path_put(&path);

This looks wrong.

You're doing "path_put()" even if kern_path() didn't succeed.

As far as I can tell, that will either put some uninitialized garbage
and cause an oops, or put something that has already been released by
the failure path.

Maybe that doesn't happen in practice in this case, but it's still
very very wrong.

Plus you shouldn't have those kinds of insanely complex if-statements
in the first place. That was what caused the bug - trying to be
clever, instead of writing clear code.

I'm not liking how I'm finding fundamental mistakes in patches that
_should_ be trivial conversions with no semantic changes.

               Linus
