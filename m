Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEBE91D4F0C
	for <lists+linux-fsdevel@lfdr.de>; Fri, 15 May 2020 15:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgEONTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 15 May 2020 09:19:16 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30887 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726407AbgEONTP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 15 May 2020 09:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589548753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=VVfnMaxbDJwdN3t1pb7+qmfm61G7CFVxjrzZ7nK0lKs=;
        b=iEZQ1MA6zRRxiv/TBD4Pvm9wJ9cFasGQEftC/kxnKq3nAT9Jbi81XQ8ldCor0FR+dUCzgZ
        ZXgwwYH5uRXqYZWV6ty0N8kgFB2tlmCuun4z4egxKkOy4V2Xs2RkSn6uAPiE2OGrRlsFjr
        0jS6yWvtFjqhOSDzyXHyt/oXYYaOad4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-LRWcvlbuO7SPM-xhLLpFBA-1; Fri, 15 May 2020 09:19:11 -0400
X-MC-Unique: LRWcvlbuO7SPM-xhLLpFBA-1
Received: by mail-qk1-f197.google.com with SMTP id i17so2166895qka.4
        for <linux-fsdevel@vger.kernel.org>; Fri, 15 May 2020 06:19:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVfnMaxbDJwdN3t1pb7+qmfm61G7CFVxjrzZ7nK0lKs=;
        b=Cirv73EXIxCNlwFN/kZ6zHjx4f/jOGuBnAq/Fj4ELJDxct+pohrbQN7jcBhqOAe9Vd
         NQB/wCD0bf3auk4JZ6PHZmv73T106/w9kqDOHBJDrT3PzcwWzCaC3TLktait0B6vqiaj
         dyNjaMAu0Bsq6qzK7LUmffl2Khe2DPKNKO1OxhQc6sAKv0bqu9+kiTB+LWMz9ipk++80
         yZT7gWJNKEZChceyjgPSYFplriY/8UItvcGjGVh0E2ZcXWx3ZWD94r+prHemrH8a5V0z
         DHF7mt0LFR7qWZorN6yQomsfQFhbPnYClheZeV0kmEPGSkobITwXE0mGnnMZT8AlshD4
         86gQ==
X-Gm-Message-State: AOAM533NAoecUYHKKZ1C4DKdNSDsiGzw/7E3RLTudse7WLBhVw0rDDLd
        UU51u2YELKMdfxsrvQiUY+wzyIVcjrXLBwfiT6L0e+AR1a6oCoJGBaU6oXGlWI2XhKmbIKuJBC5
        BnzeqfShCVfG6lNgxIlAnh7yuzNabmCgXxoywmRH2JA==
X-Received: by 2002:a37:2783:: with SMTP id n125mr2067399qkn.335.1589548751356;
        Fri, 15 May 2020 06:19:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw2B+IpGj1TzoDwxhUOvlZ0BoV1h+b7uDLIOJqPAZ+BTQYyL5XS0xoOnJyMwQ5EcW6b+8bWBU1/WT/ceTDe9b8=
X-Received: by 2002:a37:2783:: with SMTP id n125mr2067373qkn.335.1589548751140;
 Fri, 15 May 2020 06:19:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAKgNAkioH1z-pVimHziWP=ZtyBgCOwoC7ekWGFwzaZ1FPYg-tA@mail.gmail.com>
 <CAOssrKeNEdpY77xCWvPg-i4vQBoKLX3Y96gvf1kL7Pe29rmq_w@mail.gmail.com>
In-Reply-To: <CAOssrKeNEdpY77xCWvPg-i4vQBoKLX3Y96gvf1kL7Pe29rmq_w@mail.gmail.com>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Fri, 15 May 2020 15:18:59 +0200
Message-ID: <CAOssrKeDE5XKEA62Kygiis+6AVZodOzLifsaQY=eR0jAa8Z23g@mail.gmail.com>
Subject: Re: Setting mount propagation type in new mount API
To:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        lkml <linux-kernel@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        Petr Vorel <pvorel@suse.cz>,
        linux-man <linux-man@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 15, 2020 at 3:04 PM Miklos Szeredi <mszeredi@redhat.com> wrote:
>
> On Fri, May 15, 2020 at 1:40 PM Michael Kerrisk (man-pages)
> <mtk.manpages@gmail.com> wrote:
> >
> > Hello David, Miklos,
> >
> > I've been looking at the new mount API (fsopen(), fsconfig(),
> > fsmount(), move_mount(), etc.) and among the details that remain
> > mysterious to me is this: how does one set the propagation type
> > (private/shared/slave/unbindable) of a new mount and change the
> > propagation type of an existing mount?
>
> Existing mount can be chaged with mount(NULL, path, NULL, MS_$(propflag), NULL).
>
> To do that with a detached mount created by fsmount(2) the
> "/proc/self/fd/$fd" trick can be used.
>
> The plan was to introduce a mount_setattr(2) syscall, but that hasn't
> happened yet...  I'm not sure we should be adding propagation flags to
> fsmount(2), since that is a less generic mechanism than
> mount_setattr(2) or just plain mount(2) as shown above.

Also note that only setting MS_SHARED makes sense on a new mount
returned by fsmount(2) because

 - MS_PRIVATE is a no op, due to mount already being private

 - same for MS_SLAVE, since it's only different from MS_PRIVATE  on
mounts receiving propagation, which a new mount by definition isn't

 - MS_UNBINDABLE just prevents move_mount(2) from working so that's
not really useful, though at least it does something

A more interesting issue is whether we'd want to control the
propagation of the target when moving into a shared tree.  I.e. should
there be a MOVE_MOUNT_DONTPROPAGATE flag for move_mount(20 that
prevents the new mount from being propagated...

Thanks,
Miklos

