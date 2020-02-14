Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 18A5415F543
	for <lists+linux-fsdevel@lfdr.de>; Fri, 14 Feb 2020 19:39:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388641AbgBNS1t (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 14 Feb 2020 13:27:49 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:33039 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387718AbgBNS1t (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 14 Feb 2020 13:27:49 -0500
Received: by mail-il1-f194.google.com with SMTP id s18so8861069iln.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 14 Feb 2020 10:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=525HaDZiWE50FZ3TCtPQCNxuVnb7KtEWz5SDq7NWtZA=;
        b=hzXQOokN8B8QURVRTlJzusnJkUeSt7w7wuDjCPrZ6NCruf70fdnw9tlXTGVOx1NT48
         8K28f127jMOYhCXKY0u4Y3h1Ax9zV10+kk1iK1I8w7sffsOgWx0Bxlo8PggWyCrZ7wFn
         pGnuOaQQtisG6Lpi+a/LHqAl2ZJqY67cyYmI2jmdsgafvf01Fj+Rh0equKGi8l3qwQHg
         lpM0CA83fWfVlfBTMfik07pgw0aQj2eDa+n74Mcrn7vPs1W1gXkGKWyXGy9FZ/MY5Jwp
         eX9tetyus1zoSbZaSdYeCijN8+9B+Ridcs1XSEKXooT5hfeFEgAzXvbwvsM4ZB1ZSjzM
         4iEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=525HaDZiWE50FZ3TCtPQCNxuVnb7KtEWz5SDq7NWtZA=;
        b=acy3md1AtyY8N5g4uux5y+iRrxcqI40HuD3f8Edlj1mma6QmdgKD2atkNK1hoSnigM
         xTHsujTTKe9rFR/D8AYOfJMHrBsuoWsLp4oWh8jNqdv49Z44x28Q3Yo3HAHLbudNSa68
         W42QQ+1Fu3Qs33D9lkmRDtC4hMnrRfS9/gvyt0mfZgFgQY+u43/Mu3w3M1+x9La+hSSL
         LhpL8LaScOfsJobij4dXpIG2lCRVfZpfAjftn2TfhcD2mz4RDqepWrKd/lGxHkSOaAQM
         igCyi6ZdKsJfE+7jcBGSDmy+BRbK+RJ3f5J0HN7ZuRHh8WEGSfMHvKI9dHA3ucYYANiD
         Wisw==
X-Gm-Message-State: APjAAAXe+VjhDot7Tum9WkvO+Up+ELrORqntTlW8urFr3uGvvfBKl9JS
        B7kBog6eVT9RYDRYsFDys19rprNFMharmgZTOX8=
X-Google-Smtp-Source: APXvYqxaPahU4lW8qm63HmvdGzXToS0WIXLN7PAHyAaOe/LhgE077r0yz0rodZE2f9D3MWG2LVXOioxI7+uAx31K1xY=
X-Received: by 2002:a92:9f1a:: with SMTP id u26mr4321234ili.72.1581704868824;
 Fri, 14 Feb 2020 10:27:48 -0800 (PST)
MIME-Version: 1.0
References: <20200214050853.GX23230@ZenIV.linux.org.uk>
In-Reply-To: <20200214050853.GX23230@ZenIV.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 14 Feb 2020 20:27:37 +0200
Message-ID: <CAOQ4uxiEQd00U75=AkXHaEd+OKMFMor4JdDaN2j6fauKVy_L3w@mail.gmail.com>
Subject: Re: [Lsf-pc] [LSF/MM/BPF TOPIC] sorting pathwalk semantics out
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     lsf-pc@lists.linux-foundation.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Aleksa Sarai <cyphar@cyphar.com>,
        Jeff Layton <jlayton@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al,

Just making this public as requested, so potential attendees can chime in.
I suppose this was your intention.

Thanks,
Amir.

On Fri, Feb 14, 2020 at 7:09 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
>         There had been quite a bit of activity around that area
> (openat2() series, for example) and IMO the complexity in the damn
> thing is getting close to critical - we are not quite at the point
> where the average amount of bugs introduced by fixing a bug is greater
> than one, but it's uncomfortably close.  Quite a few places are
> far too subtle and convoluted (anything related to do_last(), for
> one thing).
>
>         We need to get that mess under control.  I have a (still
> growing) series massaging it to somewhat saner shape, but there
> are some interesting dark corners that need to be sorted out (situation
> around mount traps, for example).
>
>         We definitely need to settle on some description of semantics.
> Preferably with a set of litmus tests, similar to what memory model
> folks had been doing.
>
>         I would like to catch at least the people who'd been active
> around that area.  Miklos Szeredi (due to atomic_open involvement,
> if nothing else), David Howells and Ian Kent (mount traps, among
> other things), Eric Biederman (userns fallouts of all sorts),
> Aleksa Sarai (openat2 - most recent large changes in the whole
> thing), Jeff Layton (revalidation et.al.)...
> _______________________________________________
> Lsf-pc mailing list
> Lsf-pc@lists.linux-foundation.org
> https://lists.linuxfoundation.org/mailman/listinfo/lsf-pc
