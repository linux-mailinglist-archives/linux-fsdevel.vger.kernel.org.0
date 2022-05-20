Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEEA152E3EA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 20 May 2022 06:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345315AbiETEjn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 20 May 2022 00:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245673AbiETEjm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 20 May 2022 00:39:42 -0400
Received: from mail-qv1-xf2b.google.com (mail-qv1-xf2b.google.com [IPv6:2607:f8b0:4864:20::f2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E1E66694;
        Thu, 19 May 2022 21:39:41 -0700 (PDT)
Received: by mail-qv1-xf2b.google.com with SMTP id c9so5325367qvx.8;
        Thu, 19 May 2022 21:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oTZoXWFSjcQtcUIhLzqzvpSET2NPUjAaPwOJ05WU/wA=;
        b=HKsk9sfLgIt8leFLiJmwQSapxZ8rYdR37mbZ3ZQOMvbGBCg8B33P4oxby5LlZLYBv4
         VxCEwpPJlXO8wvYo1Iz1r863wz6blhYmESUFTgIKXQWKOrFtRWroR5GVfMjpUUSuUv/K
         HnhXJyJ1nCqBNW7ngBof1RxWf2fGaMRRCZ6RhIwV/XQFT2ti97xlIe9Pwq8kF+T5nfaL
         WrFXeoIcrVeT5bubCJA2MfPYZ3KgTDd8ArNR7qa9E02MYPeroagzwB6OXBjpc7ckfTRW
         aKRv2gAyqGOuyukITEmYKUG+R2hnhCc33GJu402U0wR9hXlbjJx5BSlYjA2N0aYVKWNe
         if5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oTZoXWFSjcQtcUIhLzqzvpSET2NPUjAaPwOJ05WU/wA=;
        b=E/yZ1InVpkqBX/7iVVHKa+jMewWAYLakuKgCx2Dyka/NmWo6KSdSu7jMtxjHnpUqJn
         jL0DVqYAhL9GHtyJS9FwRTaVkk9ahOAqggN4PjaWZK3aiBk8MeeNx42jERiIPYz8ksR6
         0/08fY6SX3I3LOkVwjKatFmMG6n/4xDUp9mn716noA1nL+JMp59yHGC1ThasgOGjd30o
         TH9TLXCeLmrlxBp1++KsU+5co5KKm+5ruVaY92dogUpiWUVscsDi0tpH1DbbeRbprRXr
         n7TF25ptvpqBP1r7zRc5UR48v1RA1zC/CADIrn+LYxWbShf/QaUAeYphYiCyvsf0j5QN
         v1cA==
X-Gm-Message-State: AOAM531J3Qxw9cu5T43zdzRY9aJJsg9rql3Dsq+6eIaKzTVuxdQ2wJmc
        H5K1x2zE88qoWNJwl/FKi//EvnbyjiA+EjyFcyI=
X-Google-Smtp-Source: ABdhPJy5USmBabbYE1kjFOsbD/gGJC5hZ/vUgNSjq5EujoGkuc+/ukKRj9Kwyr78sU3zP6MiWLrG8TBkGyGbvYM/P8Y=
X-Received: by 2002:a05:6214:2409:b0:432:bf34:362f with SMTP id
 fv9-20020a056214240900b00432bf34362fmr6692263qvb.66.1653021580704; Thu, 19
 May 2022 21:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20f17f64-88cb-4e80-07c1-85cb96c83619@windriver.com>
 <CAOQ4uxiQTwEh3ry8_8UMFuPPBjwA+pb8RLLuG=93c9hYtDqg8g@mail.gmail.com> <YocRWLtlbokO0jsi@zeniv-ca.linux.org.uk>
In-Reply-To: <YocRWLtlbokO0jsi@zeniv-ca.linux.org.uk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 20 May 2022 07:39:29 +0300
Message-ID: <CAOQ4uxizvWk-=JW=s-WXw0OGR3Wjm2YYkpwQqXHc27U=iRtQDg@mail.gmail.com>
Subject: Re: warning for EOPNOTSUPP vfs_copy_file_range
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     He Zhe <zhe.he@windriver.com>, Dave Chinner <dchinner@redhat.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Olga Kornievskaia <kolga@netapp.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 20, 2022 at 6:56 AM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Thu, May 19, 2022 at 04:53:15PM +0300, Amir Goldstein wrote:
>
> > Luis gave up on it, because no maintainer stepped up to take
> > the patch, but I think that is the right way to go.
> >
> > Maybe this bug report can raise awareness to that old patch.
> >
> > Al, could you have a look?
>
> IIRC, you had objections to that variant back then...

Right. But not about the "main" patch.
The patch had an "also" part:

The short-circuit code for the case where the copy length is zero has also
been dropped from the VFS code.  This is because a zero size copy between
two files shall provide a clear indication on whether or not the
filesystem supports non-zero copies.

-     if (len == 0)
-         return 0;
-

Which would have been a regression for nfs client, because
nfs protocol treats length 0 from ->copy_file_range() as "copy everything":

https://lore.kernel.org/linux-fsdevel/CAOQ4uxgwcNwWEqYKBg3fMHD3aXOsYUmPeexBe9EVP9Nb53b-Hw@mail.gmail.com/

This api impedance should be fixed in the nfs client, but I'm
not sure if that was already done.

I will test and re-post Luis' patch without removing the short-circuit
unless Luis gets to it first.

BTW, IIRC, there were already LTP tests and man page fixes posted for
the copt_file_range() behavior change.

Thanks,
Amir.
