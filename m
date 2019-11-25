Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE9C1090CE
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Nov 2019 16:14:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728390AbfKYPON (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Nov 2019 10:14:13 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:34775 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728368AbfKYPON (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Nov 2019 10:14:13 -0500
Received: by mail-io1-f67.google.com with SMTP id z193so16642834iof.1
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Nov 2019 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ALu9igSRSsKi52hn+f9OyAjdyB0mBhNXe9BnXNqIOe4=;
        b=Uhh7wOIqPQR81MSbRooLEt8qyy+07qluJoDtNGDtuedJKTsKjd14fVckV+hyDQmbo6
         78MPzzDXsUkzjxgRhAEm9siOrRhNZUiy8r2DTW7OWcdnHo7YHAbfbIO7lH/4mUPXSThw
         yCn+Oo5iRpC87zL2LqOdI1JCfz+ssecH+ma6A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ALu9igSRSsKi52hn+f9OyAjdyB0mBhNXe9BnXNqIOe4=;
        b=jrmPtvaHXaYdDKBcfoHZ+vHdlN0jyHMy36vuvd6cRhc44c6tU9crHk90jw7K+PAl//
         BUTl3rEB3xRiP/Y5/7GPyTjrWP2PTc+e/iU6uuns6WGMpF9g4Zegu2NQAlwe9aAO0oT9
         ZbUuAGluub70ME67BTn9XC433QZ5zBFFoMYJaiSdAupD1Bw77zEbxXg6V5DrP2q4JjC9
         c/qG+7JfrRQiF57pb6sQ11nKC5MlMZ/lp/FzQRKmlYGyggz2qC4eUtQEUlltgXRkfIFa
         eMBepcZJFuV7yidrT5vF2WOpRCx7VAuQdQlpdHW9yXOW9umF1jlmFKuwxyNOEUuk9qme
         Yh6A==
X-Gm-Message-State: APjAAAXm/Sjg8/imR04mtOhLvVqrtbAEGdL8ujOyBSgk92Rg0deIkDiI
        ubcUYrFAKMtdoL/eheGJ5VH/h6EtqnWNRmcMMItN5g==
X-Google-Smtp-Source: APXvYqymUw8TAznCvAM14YFrTvY36Km1p/Eylp7nwOHjzN72m1nqZQk+qCIweSmRGc14oNLOCMmjpk2sZSwXjZnmUyo=
X-Received: by 2002:a5d:91da:: with SMTP id k26mr26131450ior.252.1574694852323;
 Mon, 25 Nov 2019 07:14:12 -0800 (PST)
MIME-Version: 1.0
References: <20191025112917.22518-1-mszeredi@redhat.com> <87r231rlfj.fsf@x220.int.ebiederm.org>
In-Reply-To: <87r231rlfj.fsf@x220.int.ebiederm.org>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 25 Nov 2019 16:14:01 +0100
Message-ID: <CAJfpegt_haMDwd6jo3mQzX2vchk_LLMH+V+h4yDs7geLmo4NhA@mail.gmail.com>
Subject: Re: [RFC PATCH 0/5] allow unprivileged overlay mounts
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 25, 2019 at 3:43 PM Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Miklos Szeredi <mszeredi@redhat.com> writes:
>
> > Hi Eric,
> >
> > Can you please have a look at this patchset?
> >
> > The most interesting one is the last oneliner adding FS_USERNS_MOUNT;
> > whether I'm correct in stating that this isn't going to introduce any
> > holes, or not...
>
> I will take some time and dig through this.
>
> From a robustness standpoint I worry about the stackable filesystem
> side.  As that is uniquely an attack vector with overlayfs.
>
> There is definitely demand for this.

Hi Eric,

Have you had time to look into this yet?

Thanks,
Miklos
