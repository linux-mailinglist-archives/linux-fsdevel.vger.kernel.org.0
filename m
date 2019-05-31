Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 644F330AF6
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 May 2019 11:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfEaJCc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 May 2019 05:02:32 -0400
Received: from mail-io1-f53.google.com ([209.85.166.53]:33026 "EHLO
        mail-io1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbfEaJCc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 May 2019 05:02:32 -0400
Received: by mail-io1-f53.google.com with SMTP id u13so7579331iop.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 31 May 2019 02:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oeG+pCM85tciRrjyBB0fht7GW7L/dCmAoFu75hbblAg=;
        b=ipWqv0mRhsVR28jMwe91Yn7Aq12aj2LBj+Aq7Z2S2i/ypJwWJ86b4Cth/JpafTy4mr
         +r0RzoG3YC7bcYDIiyVRMo5tLDYBzeoHAQEoQlsISJ0HIIdjQ0x0oPOEycHUly5YxxYj
         rDhd4CDEcy8ANLnUxHi35o+w4T9Yyhf86zmTU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oeG+pCM85tciRrjyBB0fht7GW7L/dCmAoFu75hbblAg=;
        b=O4A988baKYBA8cljiIjiDjcznRAyn7vFfsn+5xJuAAS9F5+jYKdZTA9PiDCPoNPVNJ
         T3HZBvbJsElyKq1TyCe6oa8ko/pYmWZi/7KYzheOkcDKSq50d9F9JvIHTyfGDfBhMSy/
         7F4YZcqtrfRoKYO2AtzHn67+G+LRq5Iy/Gicvq1wFXPc8OfrRQBbrbj30a0vEvg17Dgo
         svOeGyyM9EhgJaYbaQO2GIfmds238gmbJwGgEk1ovQbi3lD56ZeIgEaRVqW7UT72wS/D
         CrHS4omXs40ABGmxvfzz+PQwI5bmwZHjpukXKIHWJQAGGJ+WbhAIQ+ADbQ6P0+ap/oY0
         zmgw==
X-Gm-Message-State: APjAAAUbjFv03UXVWJ5dM2P+Z3rlpE3k+uA+0pdfCazeylAaFh8EGbb8
        dWY7wuT3w04Oih2jLhgik/KmCb8J1g4iILYiyJZ8WQ==
X-Google-Smtp-Source: APXvYqwH2hmjTNGyREh/JmhHHPPScRfWlxDYI3ztOsXmXY4lpTZ1Lgl7pigYDx7+tzlVSxeGZLY81/d4JWtJzA3aPmI=
X-Received: by 2002:a05:6602:2252:: with SMTP id o18mr3818806ioo.63.1559293351755;
 Fri, 31 May 2019 02:02:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190502040331.81196-1-ezemtsov@google.com> <CAOQ4uxhmDjYY5_UVWYAWXPtD1jFh3H5Bqn1qn6Fam0KZZjyprw@mail.gmail.com>
 <20190502131034.GA25007@mit.edu> <20190502132623.GU23075@ZenIV.linux.org.uk>
 <CAK8JDrFZW1jwOmhq+YVDPJi9jWWrCRkwpqQ085EouVSyzw-1cg@mail.gmail.com>
 <CAOQ4uxhDYvBOLBkyYXRC6aS_me+Q=1sBAtzOSkdqbo+N-Rtx=Q@mail.gmail.com>
 <CAK8JDrGRzA+yphpuX+GQ0syRwF_p2Fora+roGCnYqB5E1eOmXA@mail.gmail.com>
 <CAOQ4uxjbVxnubaPjVaGYiSwoGDTdpWbB=w_AeM6YM=zVixsUfQ@mail.gmail.com>
 <CAK8JDrEQnXTcCtAPkb+S4r4hORiKh_yX=0A0A=LYSVKUo_n4OA@mail.gmail.com>
 <CAJeUaNCvr=X-cc+B3rsunKcdC6yHSGGa4G+8X+n8OxGKHeE3zQ@mail.gmail.com>
 <CAJfpegvmFJ63F2h_gFVPJeEgWS8UmxAYCUgA-4=j9iCNXaXARA@mail.gmail.com>
 <CAJeUaNC5rXuNsoKmJjJN74iH9YNp94L450gcpxyc_dG=D8CCjA@mail.gmail.com>
 <CAJfpegs=4jMo20Wp8NEjREQpqYjqJ22vc680w1E-w6o-dU1brg@mail.gmail.com>
 <CAJeUaNBn0gA6eApgOu=n2uoy+6PbOR_xjTdVvc+StvOKGA-i=Q@mail.gmail.com>
 <CAJfpeguys2P9q5EpE3GzKHcOS9GVLO9Fj9HB3JBLw36eax+NkQ@mail.gmail.com> <CAJeUaNAcZXfX-7Ws0q7SnaWrD+nzK3hxPwoW-NYvjAL0b=8M9g@mail.gmail.com>
In-Reply-To: <CAJeUaNAcZXfX-7Ws0q7SnaWrD+nzK3hxPwoW-NYvjAL0b=8M9g@mail.gmail.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 31 May 2019 11:02:20 +0200
Message-ID: <CAJfpegtHsE9j_SFKKfuibR4_ZDHeNzqCx8YvmN6uY_YmgR28kA@mail.gmail.com>
Subject: Re: Initial patches for Incremental FS
To:     Yurii Zubrytskyi <zyy@google.com>
Cc:     Eugene Zemtsov <ezemtsov@google.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 31, 2019 at 12:45 AM Yurii Zubrytskyi <zyy@google.com> wrote:

> We'd need to give the location of the hash tree instead of the
> individual hash here though - verification has to go all the way to
> the top and even check the signature there. And the same 5 GB file
> would have over 40 MB of hashes (32 bytes of SHA2 for each 4K block),
> so those have to be read from disk as well.

As I think Eugene mentioned, dealing with the hash tree should be done
by the verity subsystem anyway.

> Overall, let's just imagine a phone with 100 apps, 100MB each,
> installed this way. That ends up being ~10GB of data, so we'd need _at
> least_ 40 MB for the index and 80 MB for hashes *in kernel*.

Seriously?  Are those 100 apps accessing that 10G simultaneously?

I really don't know the usage pattern of those apps, but I can imagine
that some games do quite a lot of paging data in and out.   And my
guess is that most of those page-ins will still be sequential, and so
getting a pageful of index from userspace will allow the kernel to
serve quite a few reads without having to go back to userspace.

My guess is that even really tiny amount of caching (e.g. one page of
index per open file) will get 90% or more of the possible performance
improvement.  But those are all just guesses.  If you say this is not
the right direction for your project, fine.

Thanks,
Miklos
