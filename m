Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B419F316008
	for <lists+linux-fsdevel@lfdr.de>; Wed, 10 Feb 2021 08:26:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232579AbhBJHZy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Feb 2021 02:25:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232478AbhBJHYu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Feb 2021 02:24:50 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B62E4C061756;
        Tue,  9 Feb 2021 23:24:10 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id d6so961304ilo.6;
        Tue, 09 Feb 2021 23:24:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:reply-to:from:date:message-id
         :subject:to:cc;
        bh=JxAVXkfRt732sFTu4WOeBN4VxK25wfM9E0zqBjpvjdE=;
        b=eFt3k/Y0UriwZq/9CO31VZVCxiq0C9+CfFpRMNnk3OvJRvyLtOefzGijaSKzbNnvQ1
         f/6KzQd1/9wNTUBw5djf726vmTr693ppeQ6r4q/wN2OnL+1QLKo+OlPsCIu7f66GNzPV
         iE3skz6K8NDiK1GB8q9yuJJByhM1LB/SXF+NG/U4iG7MG9oWISKvd/VN+Yn15Q7AGtSW
         2wGjnJIbUrUwSKgwnkrsiz0VrDIRWtL+0hySmMN6UbpeECGudnm+DpCCvQie+nIz/jqb
         CBtd5Y70HNHfX3nWxY00l8tuVOVW6DGtcYQl7kaZGpVSXomP1on0r8Ez4nqbBbdbGWyl
         j4CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:reply-to
         :from:date:message-id:subject:to:cc;
        bh=JxAVXkfRt732sFTu4WOeBN4VxK25wfM9E0zqBjpvjdE=;
        b=h6jWRoe9Zs7piNsy0VZOvnSZ3B+f9ev9vQvQMrPesI3YdAX11P0vwhG3fL+Xc5WskE
         a7v2EfmNykb/vkaWNZsyVuwbr94MPrORZGcpHuppGtVMH+n9k/RInUdvps88BqUvwdvm
         DNvTJP8vA49PDMao5y4uDRDGzRuALz+w4ZPj1MYrWk1HcpneM+DmjDn2CZ2AiW7VevAS
         FgfTIhqxZ5fo1XPHIhvDYxcqe0NpGV0SWem9fBwNG08jIPbt/h5RxkjlkKdF9e0MBVXO
         ICqeBI2sjPyuCx+ulWBS4fqMTzzqrD88zvkaldpEb5O3aDvuFITEBpKghnTphIg74Ml9
         c4TQ==
X-Gm-Message-State: AOAM530MvlDsaHeK39r1gFre/PLVi3JkOVyCLs6SdCd3GtR64fFpcMUw
        mPX8nSQmlR9yCR6/ryp8t18x7v5vyb2JRo8FTtw=
X-Google-Smtp-Source: ABdhPJy3P0ddvjEDOh8APAyGjWR/fSWVFtjK3qjSAtJiIn7Cp5suhXrJfmimi4w98U4+ooMCH/onYk3kpXSg0PSbFxc=
X-Received: by 2002:a05:6e02:4c9:: with SMTP id f9mr1739562ils.186.1612941850146;
 Tue, 09 Feb 2021 23:24:10 -0800 (PST)
MIME-Version: 1.0
References: <CGME20210209235046epcas1p1416b5b121c0d78bfcb854aab46ea35c2@epcas1p1.samsung.com>
 <000001d6ff3e$62f336d0$28d9a470$@samsung.com> <CA+icZUUFFrEJccHDZPV9nzj7zav-RA53eWqgKkDyvwOxCaKKnQ@mail.gmail.com>
 <001401d6ff68$5acaf360$1060da20$@samsung.com>
In-Reply-To: <001401d6ff68$5acaf360$1060da20$@samsung.com>
Reply-To: sedat.dilek@gmail.com
From:   Sedat Dilek <sedat.dilek@gmail.com>
Date:   Wed, 10 Feb 2021 08:24:04 +0100
Message-ID: <CA+icZUW0gS21ns1mVeJ7z-0W8XmfyuhggkwYHRXQjYy0jDZyNw@mail.gmail.com>
Subject: Re: [ANNOUNCE] exfatprogs-1.1.0 version released
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, Eric Sandeen <sandeen@sandeen.net>,
        Goldwyn Rodrigues <rgoldwyn@suse.com>,
        Nicolas Boos <nicolas.boos@wanadoo.fr>,
        Hyunchul Lee <hyc.lee@gmail.com>,
        Luca Stefani <luca.stefani.ge1@gmail.com>,
        Matthieu CASTET <castet.matthieu@free.fr>,
        Sven Hoexter <sven@stormbind.net>,
        Ethan Sommer <e5ten.arch@gmail.com>,
        Hyeongseok Kim <hyeongseok@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 10, 2021 at 5:51 AM Namjae Jeon <namjae.jeon@samsung.com> wrote:

> > Hope Sven will do a new release for Debian.
> > ( Note that Debian/bullseye release  plans "Milestone 2" this Friday, February 12th (see [1] > "Key
> > release dates" > "[2021-Feb-12] Soft Freeze"). Dunno which impact this might have on this. )
> I hope he will do it, too!
>
> Thanks Sedat:)

I filed Debian Bug #982431 "exfatprogs: Update to version 1.1.0"

- Sedat -

[1] https://bugs.debian.org/982431
