Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4901859A70B
	for <lists+linux-fsdevel@lfdr.de>; Fri, 19 Aug 2022 22:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351394AbiHSU2M (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 19 Aug 2022 16:28:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351462AbiHSU2I (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:28:08 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DFD410E793;
        Fri, 19 Aug 2022 13:28:02 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id h19so2204496uan.9;
        Fri, 19 Aug 2022 13:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=OYthYYNdZQvrpatlOm3lNYVTS6uAKNPx96c7Q90Mz3s=;
        b=hq3zLC3QBeifttKK3V6vCbMEkU8j6p1Z5SjX9GufXXA60CpcuyEALJ7vWrDpFTTPtb
         +HFPq1l8z9lFAFMrw+tl8qwiAGQVsf+eGbr2QjNgfhPAo/EtpksMB3/16Imfs+4TTxSx
         l24ekTa+3H4V6mfQCuSkbSQsYUe+i7Q7JKumt7XeuoOZrou8BcPFOPkA+g/3qYs0nKQc
         c5XJLdNv/9uA7TGR3lAyVAYIy7PMSNrkNKcsZyQIg1S+sRUirUjLQqM7oZlWhYnxyf1x
         lYgYwZN20kn+lUsm/L1q9DDUxSjtXMD84kq7mmUhn4FaJm0kh/rrNP43Mm6BpTwqCf6y
         A1wg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=OYthYYNdZQvrpatlOm3lNYVTS6uAKNPx96c7Q90Mz3s=;
        b=U7hbgUq2dVIeOyuXKUF2gZ3xlr6oaeTSJCo/f8mGHWPhBNFuGhYeAwlBtASYdPEK2Z
         9uc1CEiay+AiE1B4wIe+K2jibaeCkvDfHAdSypD9DIF3TV8aB+ptnI50AhofDm35Yf1e
         zsrNfKmOVyfbHi6q1lvJCmySxastvIW2ldVZyjkE0oe7g+Q++c566EnjJprRy8mgNBS1
         /fZvW/xv/j/ciHHLrP9MSbrNDnbf9m+wlV4cGu0IrL2NSMXjqNBWQB1Fqoq0B2/mCO7H
         l0itT+CeCT6nVa5sOaRlkT/il/dekiGlkEBcvEhwnmwM/OBBGsRJUxxFeRZcupu1XNm9
         vE7w==
X-Gm-Message-State: ACgBeo0USofOgc3JtoZ6kdyw5neucN9Ogy33H0s+WfB+TAEMar0jhzDF
        H/yoLg0eWmJdGiqHT1vs5J6EhCvn1usE4hcgYJA=
X-Google-Smtp-Source: AA6agR76KQhgeaAZ++agDFZdUHr+Pui39KP1+A5o5aqlblLsaaVkQYVFKjPrRMaPphxedL00hKcBALuWLDkjiBYeks0=
X-Received: by 2002:ab0:6dc5:0:b0:39b:fa5e:77f6 with SMTP id
 r5-20020ab06dc5000000b0039bfa5e77f6mr2860032uaf.114.1660940880665; Fri, 19
 Aug 2022 13:28:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220607153139.35588-1-cgzones@googlemail.com>
 <20220608112728.b4xrdppxqmyqmtwf@wittgenstein> <CAOQ4uxipD6khNUYuZT80WUa0KOMdyyP0ia55uhmeRCLj4NBicg@mail.gmail.com>
 <20220608124808.uylo5lntzfgxxmns@wittgenstein> <CAOQ4uxjP7kC95ou56wabVhQcc2vkNcD-8usYhLhbLOoJZ-jkOw@mail.gmail.com>
 <20220618031805.nmgiuapuqeblm3ba@senku> <CAOQ4uxg6QLJ26pX8emXmUvq6jDDEH_Qq=Z4RPUK-jGLsZpHzfg@mail.gmail.com>
 <20220620060741.3clikqadotq2p5ja@senku> <CAOQ4uxhq8HVoM=6O_H-uowv65m6tLAPUj2a_r3-CWpiX-48MoQ@mail.gmail.com>
 <20220622025715.upflevvao3ttaekj@senku> <CAJ2a_DfkMvh7EdOA6k+omxhi18-oVbSXSGzXnpU1tXPD55B2qw@mail.gmail.com>
In-Reply-To: <CAJ2a_DfkMvh7EdOA6k+omxhi18-oVbSXSGzXnpU1tXPD55B2qw@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 19 Aug 2022 23:27:49 +0300
Message-ID: <CAOQ4uxhiyVixjDnDsMusfAPqP4DkbA0TfmOKGLa_L6T6s1JJjQ@mail.gmail.com>
Subject: Re: [RFC PATCH] f*xattr: allow O_PATH descriptors
To:     =?UTF-8?Q?Christian_G=C3=B6ttsche?= <cgzones@googlemail.com>
Cc:     Aleksa Sarai <cyphar@cyphar.com>,
        Christian Brauner <brauner@kernel.org>,
        SElinux list <selinux@vger.kernel.org>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 19, 2022 at 9:05 PM Christian G=C3=B6ttsche
<cgzones@googlemail.com> wrote:
>
> On Wed, 22 Jun 2022 at 04:57, Aleksa Sarai <cyphar@cyphar.com> wrote:
> >
> > On 2022-06-20, Amir Goldstein <amir73il@gmail.com> wrote:
> > > To be a reasonable reaction to the currently broken API is
> > > to either accept the patch as is or request that setxattrat()
> > > will be added to provide the new functionality.
> >
> > Since the current functionality cannot be retroactively disabled as it
> > is being used already through /proc/self/fd/$n, adding
> > *xattrat(AT_EMPTY_PATH) doesn't really change what is currently possibl=
e
> > by userspace.
> >
> > I would say we should add *xattrat(2) and then we can add an upgrade
> > mask blocking it (and other operations) later.
> >
>
> It seems setxattrat() is the preferred way to continue.
> fsetxattr() would have one advantage though (w.r.t. SELinux):
>
> The steps to label a file are:
>   1. get the type of the file (via stat(2) family)
>   2. lookup the desired label from the label database via selabel_lookup(=
3)
>   3. assign the retrieved label to the file
>
> The label is sensitive to the file type, e.g.
>
>     $ matchpathcon -m file /etc/shadow
>     /etc/shadow     system_u:object_r:shadow_t:s0
>     $ matchpathcon -m lnk_file /etc/shadow
>     /etc/shadow     system_u:object_r:etc_t:s0
>
> Using the *at() family the file type could change between step 1. and 3.,
> which operating on an O_PATH file descriptor would prevent.

I don't understand the problem.

If you have an O_PATH fd, the object it represents does not change.
If you use fstatat(fd, ..., AT_EMPTY_PATH) (or fstat) and
setxattrat(fd, ..., AT_EMPTY_PATH), it prevents the race.

Thanks,
Amir.
