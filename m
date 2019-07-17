Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994E56B2FA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jul 2019 03:02:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728809AbfGQBCM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Jul 2019 21:02:12 -0400
Received: from mail-io1-f50.google.com ([209.85.166.50]:35383 "EHLO
        mail-io1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727956AbfGQBCM (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Jul 2019 21:02:12 -0400
Received: by mail-io1-f50.google.com with SMTP id m24so43139473ioo.2;
        Tue, 16 Jul 2019 18:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ahySjzA1gL8rVPhqHI5ub3INffwti9XjJMboi48LXtk=;
        b=px7PWCytcQ5b3N9+j1mdgjFwRXMxKtojpS/rxYl/jv+tNNcmvs2z4f43+tHghw5G46
         G6jpDolYGc/cVZzqcdFUcuFPOCK7yNca5vneioU/ospDBBKcmu9vm0g8OyLcSEgpeTX5
         yNGK/7y1sAuZKlIiZ4Gi7yD+oCt6tN2bS847m/m7ilXTICV9Owj+5dvXmpHP4iO+foyJ
         O0AM0/jNwGtguQ40Ftx67Xxc2dR6ivhxL0kg2syfqFK4fxqKx8Wv8hGZrR5sPtCcL2ht
         Go9EFrN/qj862MQmw2NoHnGq5VIYQ23mGsMeXEDXm6NPRO8QVS/Z411JY2WKKQq/wWD8
         i8Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ahySjzA1gL8rVPhqHI5ub3INffwti9XjJMboi48LXtk=;
        b=i9KCAZTFHaR2NYZ3xtuRmBDMf71UJf8XULQ8fKzOAtbW85O82udNB6HOZjs0C6CtVP
         4Im2b1IYNXD5qShSJKj+NbwOWH2xjVIUZUuTapp0t6IQlObJQvcEekYEA1zfxXAKvZfH
         JWjVqp3tgyqiZHoDFOZtohn6lun9O2YKScATS7KzOg7vtXewyLNZlr3QHJcfpvH8JYRf
         bMhWydh17PkafmYl6ZyK1erkYiP9aU39IDv9wQQyIu1J8NzVSSMdbjOBpWZIjUdF0zrZ
         zl0bQhXXNYGqbOV6wGXl/BmZnhEEj24MsMsINkcSuDh/qScoInL4GG5n7tTiLnelmv4J
         Q48w==
X-Gm-Message-State: APjAAAWHmYza1TmCMYOzONGsRsaxOcOTcRf89RFT5Wa73IJN4n+ve4g5
        66oFnq0/sB0c5ETnRxgB5fIGGWIao/0MVO+pdRA=
X-Google-Smtp-Source: APXvYqzDsihWdW3OD5QJZYl9x61JE20yDI2vs4CjyGoc2h1F5eUl0KXfw3dtWJB20tSPmZzSZbJd/RagEdVs554ig1s=
X-Received: by 2002:a6b:3883:: with SMTP id f125mr34176802ioa.109.1563325331370;
 Tue, 16 Jul 2019 18:02:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtXjyUP6_h86o5GmKxZ2syubbnc2-L95ctf96=TvBnbyA@mail.gmail.com>
 <CAH2r5mtQ2QNn+fbdQ_HFSJQ-zv2m4-b02RYVGum0Fy+=yHgftA@mail.gmail.com>
In-Reply-To: <CAH2r5mtQ2QNn+fbdQ_HFSJQ-zv2m4-b02RYVGum0Fy+=yHgftA@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Wed, 17 Jul 2019 11:02:00 +1000
Message-ID: <CAN05THS4iCZdEruuLQRwvrMhdKrEL18-gN4CndtRPwxkuczz_Q@mail.gmail.com>
Subject: Re: [PATCH][CIFS] Add flock support
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Nice.

Reviewed-by me

On Wed, Jul 17, 2019 at 10:51 AM Steve French <smfrench@gmail.com> wrote:
>
> Pavel spotted the problem - fixed and reattached updated patch
>
>
> On Tue, Jul 16, 2019 at 7:02 PM Steve French <smfrench@gmail.com> wrote:
> >
> > The attached patch adds support for flock support similar to AFS, NFS etc.
> >
> > Although the patch did seem to work in my experiments with flock, I did notice
> > that xfstest generic/504 fails because /proc/locks is not updated by cifs.ko
> > after a successful lock.  Any idea which helper function does that?
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve
