Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A0E0B11A74
	for <lists+linux-fsdevel@lfdr.de>; Thu,  2 May 2019 15:46:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726303AbfEBNqh (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 2 May 2019 09:46:37 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:43665 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfEBNqh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 2 May 2019 09:46:37 -0400
Received: by mail-yw1-f65.google.com with SMTP id w196so1564380ywd.10
        for <linux-fsdevel@vger.kernel.org>; Thu, 02 May 2019 06:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sk26o6QbuEZBRc0Vv7aQ7Pbpa+wxlC71B4ABxNC9w8k=;
        b=azvqMu29Dvqc2Vtp9mK59z1pBt5SfrpCZgwjyEZrlTxl0BP2lGTalUuEO6UV9hS13k
         oIfZ4SpCkgdK5w5PS24ftL9dimRT9az/u1XvG1KhUu82tqq2OnuMHf7QG5g8Jf+4pgLj
         54suaeAEz8A9Koo3bC/03dRjWu5tpBl9c0WkhJeeidzbvI6zCxMxOS5Z8vnXOFkYb1HG
         AMnxF+36v/G6lZjcalin4U9XTL0p6GS6JdUBXJ5bMGLlp1xJxyfpYHoHoYPrIUigMrWq
         vomfhJ3s4EOZZCKq8nQTLmnvtLWEltmz8dFRiluRknW8sMoSrt+5VD/sTtlFONxRMwyg
         65rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sk26o6QbuEZBRc0Vv7aQ7Pbpa+wxlC71B4ABxNC9w8k=;
        b=mN1TPNapOsHMNAlbfptCV3YK35X8HeOgMxbqewt4gTfLvSQ1tJ1CzDJHO47UIrbNWm
         65Gg3DYBrbGL6KO9ICwNrt56K+HpFKUaPACNFyCOFJDRz4rnl7oxuJZXbQc+1Kuexul1
         FItaKZY5HWOq5VZTEWex6oqickyzmd1qXfuNZCLMccesoM44X14Ny5NIRmEIRg4wBLOT
         e45AV0WIKtX5DpD2EmreM4JwXd2UiRD7fwviBvSJXlQGVcTK2DugGJeDHrADionkho7L
         B/Cps8gazQShvm2QGd1RWnmSJkBLvysW7A6HZaofzPazE25WWPpW73+glPnbJNwHttyQ
         rUkw==
X-Gm-Message-State: APjAAAWNKrr3uHGcBrrzWj7UGlVKpxcJuuDtBP3dCmKsmedroIbCWBLJ
        ab/IuS827Zhy7RxgmkCiSQBAti9m1SRtldBqQLg=
X-Google-Smtp-Source: APXvYqyhzqdaNNecui2D9IPnJCV4IO+qKDeeR9LEUuFfKK4ATqe/H3HrwXgWsOMa7rvFJw0M7qPyCSP9w/dJarup3Oc=
X-Received: by 2002:a81:1150:: with SMTP id 77mr3118097ywr.241.1556804796455;
 Thu, 02 May 2019 06:46:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu>
In-Reply-To: <20190502131034.GA25007@mit.edu>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Thu, 2 May 2019 09:46:25 -0400
Message-ID: <CAOQ4uxhGxEWasBaHdXiCVbPPSqVLQ=c8Deq_QE2JYo5q0iUfYA@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     "Theodore Ts'o" <tytso@mit.edu>
Cc:     ezemtsov@google.com, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, May 2, 2019 at 9:10 AM Theodore Ts'o <tytso@mit.edu> wrote:
>
> On Thu, May 02, 2019 at 07:19:52AM -0400, Amir Goldstein wrote:
> >
> > This sounds very useful.
> >
> > Why does it have to be a new special-purpose Linux virtual file?
> > Why not FUSE, which is meant for this purpose?
> > Those are things that you should explain when you are proposing a new
> > filesystem,
> > but I will answer for you - because FUSE page fault will incur high
> > latency also after
> > blocks are locally available in your backend store. Right?
>
> From the documentation file in the first patch:
>
> +Why isn't incremental-fs implemented via FUSE?
> +----------------------------------------------
> +TLDR: FUSE-based filesystems add 20-80% of performance overhead for target
> +scenarios, and increase power use on mobile beyond acceptable limit
> +for widespread deployment. A custom kernel filesystem is the way to overcome
> +these limitations.
> +
>

Fair enough. I didn't think FUSE could be an alternative as-is.
I am familiar with USENIX paper.
The question is if we need to re-intent the wheel or try to improve the wheel.

Thanks,
Amir.
