Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B55C831A5FB
	for <lists+linux-fsdevel@lfdr.de>; Fri, 12 Feb 2021 21:24:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230020AbhBLUXi (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Feb 2021 15:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbhBLUX1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Feb 2021 15:23:27 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68352C061756
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 12:22:47 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id jt13so1280689ejb.0
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Feb 2021 12:22:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=golang-org.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jt/znij/3B8fOvG2/6cCyKxwvx+Ld8xIFxr8VpQdpGs=;
        b=UMNFf3VNvvXt7dkwZkk67PYsZgTlumZvT3waqw6JYJE4qEKa+y1zf4JNt+5R+2zqqm
         yN/E5gw7Vfqut29zBhqcTM4yAHaJGHxWDDouOftu/xKLEz+T35rs9UbgrWnPtytQTmv7
         s6WiKQE6Wsc6N5p1TTzP844IK6c2ZtlNQPPFcQacJZzQrP+3MuEW4r3Wz0FAMyAMGR3t
         FmOHlkR8jEB/c/ZwfNjnDxLWmfoTi5F3fl8jml+xhf6D9dKtsa9ScwLTZ1MWQJ5LPMFK
         LXjF3ba1y0rX2nqh+h6xyOX4krOzF/W+vYlw1wkUTZ69oSlWMrIWbaTmnooEXSQcl0gj
         t6Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jt/znij/3B8fOvG2/6cCyKxwvx+Ld8xIFxr8VpQdpGs=;
        b=Bq9d3D+dpgMvw+eesJ/wqfwfwsvH4WBHAhrZUpDl5jLPb7HKqSiqRvEseVxBJJW2qb
         5OhfG3Kif7McCrxDVI1NxFVSFe4lJGHv9tTDRHkmAHnCvbN5iO+zJM7IzdSpywnsrHSH
         0YSirlCztVnNUaNh9+4SyfMOR4Im5mFOp+4ef5MqEsCdal8fdBmVwNj4aCHghvrtURO6
         7N8Dv3szEKf/UK5oU0RHINXsGWiS0oH71DpoXOJtpC1chXJIFclY4fdhs5O1WBJh3cnK
         3dBRwiE+XMhmtFUFGEjHnTN2Meej0gMdK+CmEHDTRzKTeTUoOhY5tnib1e/GQubGpIkv
         IjFA==
X-Gm-Message-State: AOAM5309s4NNThg11XQMU3SXwd1f72xEZLnlcQ9wrddq3zXDnfytPr+B
        4eIR1uLJQwboH8ugPYO/aGoQsam0z72wk/A7Sk52/mmRnK2OYA==
X-Google-Smtp-Source: ABdhPJyv9jhJSOtLHG3vaLP+bavuIfKMvj1SN0/eHImcOVZ/RjghvLg035DceUMNKiNcRQXaG5p+R4AhFW9WUK4LNjs=
X-Received: by 2002:a17:906:7687:: with SMTP id o7mr4715498ejm.209.1613161365986;
 Fri, 12 Feb 2021 12:22:45 -0800 (PST)
MIME-Version: 1.0
References: <20210212044405.4120619-1-drinkcat@chromium.org>
 <20210212124354.1.I7084a6235fbcc522b674a6b1db64e4aff8170485@changeid>
 <YCYybUg4d3+Oij4N@kroah.com> <CANMq1KBuPaU5UtRR8qTgdf+J3pt-xAQq69kCVBdaYGx8F+WmFA@mail.gmail.com>
 <YCY+Ytr2J2R5Vh0+@kroah.com> <CAKOQZ8zPFM29DYPwbnUJEhf+a8kPSJ5E_W06JLFjn-5Fy-ZWWw@mail.gmail.com>
 <YCaipZ+iY65iSrui@kroah.com> <CAOyqgcVTYhozM-mwc400qt+fabmUuBQTsjqbcA03xDooYXXcMA@mail.gmail.com>
 <YCaswkcgM2NMxiMh@kroah.com>
In-Reply-To: <YCaswkcgM2NMxiMh@kroah.com>
From:   Ian Lance Taylor <iant@golang.org>
Date:   Fri, 12 Feb 2021 12:22:33 -0800
Message-ID: <CAOyqgcXV96OeHg8OkzP-EYV7WCn+sJNGsy1RXBP86wYAYv+g3Q@mail.gmail.com>
Subject: Re: [PATCH 1/6] fs: Add flag to file_system_type to indicate content
 is generated
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Nicolas Boichat <drinkcat@chromium.org>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Luis Lozano <llozano@chromium.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel@vger.kernel.org, lkml <linux-kernel@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000302b1d05bb296631"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

--000000000000302b1d05bb296631
Content-Type: text/plain; charset="UTF-8"

On Fri, Feb 12, 2021 at 8:28 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Fri, Feb 12, 2021 at 07:59:04AM -0800, Ian Lance Taylor wrote:
> > On Fri, Feb 12, 2021 at 7:45 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > On Fri, Feb 12, 2021 at 07:33:57AM -0800, Ian Lance Taylor wrote:
> > > > On Fri, Feb 12, 2021 at 12:38 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > > > >
> > > > > Why are people trying to use copy_file_range on simple /proc and /sys
> > > > > files in the first place?  They can not seek (well most can not), so
> > > > > that feels like a "oh look, a new syscall, let's use it everywhere!"
> > > > > problem that userspace should not do.
> > > >
> > > > This may have been covered elsewhere, but it's not that people are
> > > > saying "let's use copy_file_range on files in /proc."  It's that the
> > > > Go language standard library provides an interface to operating system
> > > > files.  When Go code uses the standard library function io.Copy to
> > > > copy the contents of one open file to another open file, then on Linux
> > > > kernels 5.3 and greater the Go standard library will use the
> > > > copy_file_range system call.  That seems to be exactly what
> > > > copy_file_range is intended for.  Unfortunately it appears that when
> > > > people writing Go code open a file in /proc and use io.Copy the
> > > > contents to another open file, copy_file_range does nothing and
> > > > reports success.  There isn't anything on the copy_file_range man page
> > > > explaining this limitation, and there isn't any documented way to know
> > > > that the Go standard library should not use copy_file_range on certain
> > > > files.
> > >
> > > But, is this a bug in the kernel in that the syscall being made is not
> > > working properly, or a bug in that Go decided to do this for all types
> > > of files not knowing that some types of files can not handle this?
> > >
> > > If the kernel has always worked this way, I would say that Go is doing
> > > the wrong thing here.  If the kernel used to work properly, and then
> > > changed, then it's a regression on the kernel side.
> > >
> > > So which is it?
> >
> > I don't work on the kernel, so I can't tell you which it is.  You will
> > have to decide.
>
> As you have the userspace code, it should be easier for you to test this
> on an older kernel.  I don't have your userspace code...

Sorry, I'm not sure what you are asking.

I've attached a sample Go program.  On kernel version 2.6.32 this
program exits 0.  On kernel version 5.7.17 it prints

got "" want "./foo\x00"

and exits with status 1.

This program hardcodes the string "/proc/self/cmdline" for
convenience, but of course the same results would happen if this were
a generic copy program that somebody invoked with /proc/self/cmdline
as a command line option.

I could write the same program in C easily enough, by explicitly
calling copy_file_range.  Would it help to see a sample C program?


> > From my perspective, as a kernel user rather than a kernel developer,
> > a system call that silently fails for certain files and that provides
> > no way to determine either 1) ahead of time that the system call will
> > fail, or 2) after the call that the system call did fail, is a useless
> > system call.
>
> Great, then don't use copy_file_range() yet as it seems like it fits
> that category at the moment :)

That seems like an unfortunate result, but if that is the determining
opinion then I guess that is what we will have to do in the Go
standard library.

Ian

--000000000000302b1d05bb296631
Content-Type: text/x-go; charset="US-ASCII"; name="foo7.go"
Content-Disposition: attachment; filename="foo7.go"
Content-Transfer-Encoding: base64
Content-ID: <f_kl2qjoq50>
X-Attachment-Id: f_kl2qjoq50

cGFja2FnZSBtYWluCgppbXBvcnQgKAoJImJ5dGVzIgoJImZtdCIKCSJpbyIKCSJpby9pb3V0aWwi
Cgkib3MiCikKCmZ1bmMgbWFpbigpIHsKCXRtcGZpbGUsIGVyciA6PSBpb3V0aWwuVGVtcEZpbGUo
IiIsICJjb3B5X2ZpbGVfcmFuZ2UiKQoJaWYgZXJyICE9IG5pbCB7CgkJZm10LkZwcmludChvcy5T
dGRlcnIsIGVycikKCQlvcy5FeGl0KDEpCgl9CglzdGF0dXMgOj0gY29weSh0bXBmaWxlKQoJb3Mu
UmVtb3ZlKHRtcGZpbGUuTmFtZSgpKQoJb3MuRXhpdChzdGF0dXMpCn0KCmZ1bmMgY29weSh0bXBm
aWxlICpvcy5GaWxlKSBpbnQgewoJY21kbGluZSwgZXJyIDo9IG9zLk9wZW4oIi9wcm9jL3NlbGYv
Y21kbGluZSIpCglpZiBlcnIgIT0gbmlsIHsKCQlmbXQuRnByaW50bG4ob3MuU3RkZXJyLCBlcnIp
CgkJcmV0dXJuIDEKCX0KCWRlZmVyIGNtZGxpbmUuQ2xvc2UoKQoJaWYgXywgZXJyIDo9IGlvLkNv
cHkodG1wZmlsZSwgY21kbGluZSk7IGVyciAhPSBuaWwgewoJCWZtdC5GcHJpbnRmKG9zLlN0ZGVy
ciwgImNvcHkgZmFpbGVkOiAldlxuIiwgZXJyKQoJCXJldHVybiAxCgl9CglpZiBlcnIgOj0gdG1w
ZmlsZS5DbG9zZSgpOyBlcnIgIT0gbmlsIHsKCQlmbXQuRnByaW50bG4ob3MuU3RkZXJyLCBlcnIp
CgkJcmV0dXJuIDEKCX0KCW9sZCwgZXJyIDo9IGlvdXRpbC5SZWFkRmlsZSgiL3Byb2Mvc2VsZi9j
bWRsaW5lIikKCWlmIGVyciAhPSBuaWwgewoJCWZtdC5GcHJpbnRsbihvcy5TdGRlcnIsIGVycikK
CQlyZXR1cm4gMQoJfQoJbmV3LCBlcnIgOj0gaW91dGlsLlJlYWRGaWxlKHRtcGZpbGUuTmFtZSgp
KQoJaWYgZXJyICE9IG5pbCB7CgkJZm10LkZwcmludGxuKG9zLlN0ZGVyciwgZXJyKQoJCXJldHVy
biAxCgl9CglpZiAhYnl0ZXMuRXF1YWwob2xkLCBuZXcpIHsKCQlmbXQuRnByaW50Zihvcy5TdGRl
cnIsICJnb3QgJXEgd2FudCAlcVxuIiwgbmV3LCBvbGQpCgkJcmV0dXJuIDEKCX0KCXJldHVybiAw
Cn0K
--000000000000302b1d05bb296631--
