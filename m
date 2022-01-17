Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB5354901C2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 06:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbiAQF4K (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 17 Jan 2022 00:56:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232865AbiAQF4I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 17 Jan 2022 00:56:08 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE11C06161C
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 21:56:08 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id k15so60785264edk.13
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 21:56:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zRK/0z1pNzIoVcKbrmsaM4+gypDDyPNW8G8QLN7lLpU=;
        b=O04pFd1Av+HFa2y7toxjGyGq/OBY4BDKvdL8NOgVGrI2ylQooEl/RGe3RNuEOudKaB
         j9F/+ELni0Q5Lli2EIlFwVrA6OXdH1kl9t9h1MJHTjo4BWF6ftuRU2gTfCgq0YQ3wokT
         zX/zUD1TI1km1ilWoBJIzqBPSwTR7jI824Mh8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zRK/0z1pNzIoVcKbrmsaM4+gypDDyPNW8G8QLN7lLpU=;
        b=pXXVJTyhWiBPIQN8Vy4mGRtf90jHTYot6xVncZJtNKMOBZpPGNo4LN/UIbXPxEpVT9
         C6akU/O2P9jfgFG212UKT/HZv6o5fqktzy3DrGcBYdLqvFvUW30tCxDq7vrZpJlW+xnt
         snAw5IvVqJP9nhHGXgG7uomPaKplPY9CZfmlFvd5Op3ywhDIl8LKX0xArdTsBIAeJcZr
         LLcUkybFzMZ7q0Z2fHnxS9iCs6j+vi58OEBaNWRkmOYPi9kZYo365ROCMIa53ShyZoR6
         Je0nQGIy4dgk4qmw0588wPLLNAzBAg3Mg5GA0PWFxyT5W5N29S5IyTYzows0gkAzZUxn
         oGrw==
X-Gm-Message-State: AOAM532MZtqu/BHZC+cw6JC2tygICfWfinPtuSsxZE1U/OEy4Smbm1I0
        7szgwmEGc3AX7DXck8swmjfOTipSKFNGP+lC
X-Google-Smtp-Source: ABdhPJyoBDnP8nMadP2A/1eJyYm5HZK8n+DGJ0P+z7DtP87x89rwxlewPa4H4vtVGI7jotKrCrwLoA==
X-Received: by 2002:aa7:c584:: with SMTP id g4mr18985969edq.78.1642398966707;
        Sun, 16 Jan 2022 21:56:06 -0800 (PST)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id l1sm3991692ejh.57.2022.01.16.21.56.05
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jan 2022 21:56:05 -0800 (PST)
Received: by mail-wm1-f44.google.com with SMTP id v123so17980382wme.2
        for <linux-fsdevel@vger.kernel.org>; Sun, 16 Jan 2022 21:56:05 -0800 (PST)
X-Received: by 2002:a05:600c:1908:: with SMTP id j8mr4207602wmq.155.1642398965019;
 Sun, 16 Jan 2022 21:56:05 -0800 (PST)
MIME-Version: 1.0
References: <87a6g11zq9.fsf@collabora.com>
In-Reply-To: <87a6g11zq9.fsf@collabora.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 17 Jan 2022 07:55:49 +0200
X-Gmail-Original-Message-ID: <CAHk-=whX5gamPwDcZhV-ejWatq6eFCp7Q7ZEL8XiQMh8ZARN-g@mail.gmail.com>
Message-ID: <CAHk-=whX5gamPwDcZhV-ejWatq6eFCp7Q7ZEL8XiQMh8ZARN-g@mail.gmail.com>
Subject: Re: [GIT PULL] unicode patches for 5.17
To:     Gabriel Krisman Bertazi <krisman@collabora.com>
Cc:     Christoph Hellwig <hch@lst.de>, Chao Yu <chao@kernel.org>,
        "Theodore Ts'o" <tytso@mit.edu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 12, 2022 at 3:59 AM Gabriel Krisman Bertazi
<krisman@collabora.com> wrote:
>
> This branch has patches from Christoph Hellwig to split the large data
> tables of the unicode subsystem into a loadable module, which allow
> users to not have them around if case-insensitive filesystems are not to
> be used.

As seen by the pr-tracker-bot, I've merged this, but it had several rough spots.

One of them was around the renaming of the utf8data.h file to a .c
file: I fixed up the .gitignore problem myself, but the incorrect
comments still remain.

The Kconfig thing is also just plain badly done.

It's completely pointless and stupid to first have a "bool UNICODE"
question, and then have a "tristate UNICODE_UTF8_DATA" question that
depends on it.

The Kconfig file even *knows* it's pointless and stupid, because it
has comment to the effect, but despite writing that comment,
apparently nobody spent the five seconds actually thinking about how
to do it properly.

The sane and proper thing would have been to have *one* single
tristate question ("unicode y/m/n"), and that's used for the unicode
data module status.

Then the "core unicode" option (currently that "UNICODE" bool
question) would become something just computed off the modular
question:

  config UNICODE
         def_bool UNICODE_UTF8_DATA != n

with no actual user input being needed for it.

And yes, it might be even nicer to just make "UNICODE" itself be the
tristate, and not have a separate config variable at all, but that
would require changes to the users.

In particular, the filesystems that have

    #ifdef CONFIG_UNICODE

would have to be updated to use something like

    #ifdef IS_ENABLED(CONFIG_UNICODE)

instead.

That would probably be a good change, though, and then the 'UNICODE'
config option could just be a tristate, with the support code being
built in for the module case, with just the data being (potentially)
modular.

ANYWAY. I didn't do the above, I only fixed up the trivially annoying
gitconfig thing.

I've said this before, and I'll probably have to say it again: the
kernel config part is likely one of the most painful barriers to
people building their own kernel. Some of it is just because we have
*so* many modules, and there's just a lot of configuration you can do.

But the fact that it's already painful is no excuse to then ask people
_stupid_ questions and making the whole process unnecessarily even
more painful.

                  Linus
