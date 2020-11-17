Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7F4D2B6C8A
	for <lists+linux-fsdevel@lfdr.de>; Tue, 17 Nov 2020 19:04:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730552AbgKQSDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 17 Nov 2020 13:03:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730547AbgKQSDb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 17 Nov 2020 13:03:31 -0500
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B61C0613CF;
        Tue, 17 Nov 2020 10:03:30 -0800 (PST)
Received: by mail-io1-xd41.google.com with SMTP id i9so52187ioo.2;
        Tue, 17 Nov 2020 10:03:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=L0CqvNmDjkfC8Y294jJfpN5mwqIiGNj8Z0f3z4VcsnM=;
        b=mo+DUXan4/NPsyiBMtLoIb7YkY1RigFMBP24/GTQaPmS2DVmTw9LMG9zWorlM6joes
         Cvmw+H7SV/o8XtABoNB00V2Q9eHRhzytvX4kNkO/mBC3XUAE8yfAjED2gHESBtWlxXyA
         pc2zxgcdvYK6uNicfPCkNyRqdiZ+1FdEAVv/KclYaNNUJyXMOOCO4d0IE/dc2IU+xK9h
         r+/QRch1hplkC+i6416L14+3V/r0P7mVJMLzGSbDA3cfLvVi1vrgxOAmT51nKCC8gOFo
         lY00/+q1Ap6nzBvLBoEGgrJc75mzn5hloYWgouwpvANQ/upJwNeVexb90rC36mBRSJQx
         a6Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=L0CqvNmDjkfC8Y294jJfpN5mwqIiGNj8Z0f3z4VcsnM=;
        b=fQwo0OviIC/ILX/lLlP+r1q3EXr4x2ltWF0VAHgUT9HeC3ojDPYITlA3+gnB4kObqu
         BoUwGGBp9FPeUPaqfKVA/UkaMO5NkUjWVK9rxCK5jCq7oYY2FSg+drEvDXX2H+QY2zai
         Rh1cYhOW/XJbnbOqEy2C0dUrEgXtyCzVVqlPqRaUXDS7Awrt1Ew6e/XAcnQXETejstzI
         grSnrBoADw2CPpnhqtzr+mjXDDZhTF0ABe4bqBOmSbatu6hG4+Nqco/7vt/YWbfyeiHS
         k5q/S735svmQUjte1ARRJcfPISi4IGJwlsugZVmMnc1j4VeTiIk0UhwAbiZyhmNoMsHQ
         VGlQ==
X-Gm-Message-State: AOAM532SdHiCOPAOBFQEBmAZQ0SycrvYV5FoRY+jN2tUrSLq5Tt2Du5d
        X0kJYQ2etxQZqW8dSbD2nq+QvSHzyu83QhsZA8k=
X-Google-Smtp-Source: ABdhPJyIxEcVNbt4Syb1MkHH0Q8xZk1+KQQfIQw5hhEkaMgHcQxy0JGjYFDwQzvV3AuAlLevrQ/6IgJFGk5vtgu18Co=
X-Received: by 2002:a05:6602:5de:: with SMTP id w30mr12240327iox.64.1605636209512;
 Tue, 17 Nov 2020 10:03:29 -0800 (PST)
MIME-Version: 1.0
References: <20201116045758.21774-1-sargun@sargun.me> <20201116045758.21774-4-sargun@sargun.me>
 <20201116144240.GA9190@redhat.com> <CAOQ4uxgMmxhT1fef9OtivDjxx7FYNpm7Y=o_C-zx5F+Do3kQSA@mail.gmail.com>
 <20201116163615.GA17680@redhat.com> <CAOQ4uxgTXHR3J6HueS_TO5La890bCfsWUeMXKgGnvUth26h29Q@mail.gmail.com>
 <20201116210950.GD9190@redhat.com> <CAOQ4uxhkRauEM46nbhZuGdJmP8UGQpe+fw_FtXy+S4eaR4uxTA@mail.gmail.com>
 <20201117144857.GA78221@redhat.com> <CAOQ4uxg1ZNSid58LLsGC2tJLk_fpJfu13oOzCz5ScEi6y_4Nnw@mail.gmail.com>
 <20201117164600.GC78221@redhat.com>
In-Reply-To: <20201117164600.GC78221@redhat.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Tue, 17 Nov 2020 20:03:16 +0200
Message-ID: <CAOQ4uxgi-8sn4S3pRr0NQC5sjp9fLmVsfno1nSa2ugfM2KQLLQ@mail.gmail.com>
Subject: Re: [RFC PATCH 3/3] overlay: Add the ability to remount volatile
 directories when safe
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     Sargun Dhillon <sargun@sargun.me>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Giuseppe Scrivano <gscrivan@redhat.com>,
        Daniel J Walsh <dwalsh@redhat.com>,
        David Howells <dhowells@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Chengguang Xu <cgxu519@mykernel.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> > C. "shutdown" the filesystem if writeback errors happened and return
> >      EIO from any read, like some blockdev filesystems will do in face
> >      of metadata write errors
> >
> > I happen to have a branch ready for that ;-)
> > https://github.com/amir73il/linux/commits/ovl-shutdown
>
>
> This branch seems to implement shutdown ioctl. So it will still need
> glue code to detect writeback failure in upper/ and trigger shutdown
> internally?
>

Yes.
ovl_get_acess() can check both the administrative ofs->goingdown
command and the upper writeback error condition for volatile ovl
or something like that.

> And if that works, then Sargun's patches can fit in nicely on top which
> detect writeback failures on remount and will shutdown fs.
>

Not sure why remount needs to shutdown. It needs to fail mount,
but yeh, all those things should fit nicely together.

Thanks,
Amir.
