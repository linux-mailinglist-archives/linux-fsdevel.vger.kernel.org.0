Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07EA57B2AF7
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 Sep 2023 06:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231774AbjI2EaY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 Sep 2023 00:30:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjI2EaX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 Sep 2023 00:30:23 -0400
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 042091A2;
        Thu, 28 Sep 2023 21:30:22 -0700 (PDT)
Received: by mail-vs1-xe2a.google.com with SMTP id ada2fe7eead31-45260b91a29so6503097137.2;
        Thu, 28 Sep 2023 21:30:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695961821; x=1696566621; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GK+5urlW+H/uBh4ugJ3a6JJPF2bjuI093VBoOXW+KIs=;
        b=DmNDs08+qo5u064pz2gWRv7/MqzmoQHC1em0jT/U89ZGpoFU4iwr2aANhdSeXe6JHl
         4ovfdmHnsXOyCj8ltTQZbDoTQPYA+LS0+reE616T6rAKyjaKadQuuR2f5d0Q+ws26Ruy
         QGt495Xukj/0trnIlgzjJiOXS6m0VPjo0UnS+GHXxz+ltmbMGVhWxBKKEf9NuCith/eF
         /P+P1Gt1rPuj9vdGqooNa8Dlii3x0l1KMW+2quSkcmxU9ZSm7ZcqkK9yOCtZRnmN7tOq
         Odiq7hylnuWVCgcrQ6xOG5CsPnbHt1Z7rpr6VDVdHTM61DwBpNStsYcs0S1QoeKMqCii
         z4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695961821; x=1696566621;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GK+5urlW+H/uBh4ugJ3a6JJPF2bjuI093VBoOXW+KIs=;
        b=ChCmXPtSaMzbFiolf49lr+YjvMA+j4pzeAqPFG24J5Pe83TRV322DvOdzfBwHQ68yt
         sStO0RnJbTI/ZANsjRzPQy3XiURy6JB4iMmBA4kLreb5ytg8tfHWZE9ETNgrTAT2BtLl
         uFMticgPJRmsUw1w7Cbwx4N0JuzQ5OKxbzuK9ZJTDQCEby5HhFQLydzxgDqLlj8yT7Qd
         /z5PEMxckuusuXWUynKYOfdbFX3Ezjtjn0UvUwB/5qQ4FU9y0qMoNjpDOGf1fQ0F9lMN
         SPsyzqRS4h9m0OdBkuHwuzt/70ywXJZAeDDj1qq3vkvxcJSdBIHa/Daw/wL33U9D/rlV
         hM6w==
X-Gm-Message-State: AOJu0YytJsAgFnQru+/zJQ3NuiJwAtEjskR81ZOUsH78GAhHdaCVMdTh
        +0rKB7gA8K03QzlJmu1fBoCiz32MGzwIRR/g9Ag=
X-Google-Smtp-Source: AGHT+IHqdC387drnXRl+RJB2xD7feSSZjVSE5QV774OWhJeiYcOK3kkxypgxw5/MswJamdpaeP6yUdggIhAgHhr4I6Q=
X-Received: by 2002:a67:ecc6:0:b0:452:58a1:112 with SMTP id
 i6-20020a67ecc6000000b0045258a10112mr2663901vsp.3.1695961821016; Thu, 28 Sep
 2023 21:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000259bd8060596e33f@google.com> <bed99e92-cb7c-868d-94f3-ddf53e2b262a@linux.ibm.com>
 <8a65f5eb-2b59-9903-c6b8-84971f8765ae@linux.ibm.com> <ab7df5e93b5493de5fa379ccab48859fe953d7ae.camel@kernel.org>
 <b16550ac-f589-c5d7-e139-d585e8771cfd@linux.ibm.com> <00dbd1e7-dfc8-86bc-536f-264a929ebb35@linux.ibm.com>
 <94b4686a-fee8-c545-2692-b25285b9a152@schaufler-ca.com> <d59d40426c388789c195d94e7e72048ef45fec5e.camel@kernel.org>
 <7caa3aa06cc2d7f8d075306b92b259dab3e9bc21.camel@linux.ibm.com>
 <20230921-gedanken-salzwasser-40d25b921162@brauner> <7ef00ceb49abbb29c49a39287a7c3f28e00cf82a.camel@linux.ibm.com>
 <028eefb0207e8cb163617ef28b8104e98d00ca2e.camel@kernel.org>
 <7e211a0e0ccf335143abe8e8b6366bbbfada36f8.camel@linux.ibm.com>
 <e5a8196fbd3ed73b777df557633d1bfddf7cfd76.camel@kernel.org>
 <b9f8eb5c7e2e120bee908ab39a5ffc5d818d4cc2.camel@linux.ibm.com>
 <CAOQ4uxhNCar7jSeocjrH5RtccSJUO6jyqjnhj0U4Y+hQXL1X8Q@mail.gmail.com> <34f60b1462570d05ada03e4f2fed56d47e6b4430.camel@linux.ibm.com>
In-Reply-To: <34f60b1462570d05ada03e4f2fed56d47e6b4430.camel@linux.ibm.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Fri, 29 Sep 2023 07:30:09 +0300
Message-ID: <CAOQ4uximgT7cKyfJccLmm-a7Ty-cehxvnJ0+B81KKXe3zbH2Eg@mail.gmail.com>
Subject: Re: [syzbot] [integrity] [overlayfs] general protection fault in d_path
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Jeff Layton <jlayton@kernel.org>,
        Christian Brauner <brauner@kernel.org>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stefan Berger <stefanb@linux.ibm.com>,
        syzbot <syzbot+a67fc5321ffb4b311c98@syzkaller.appspotmail.com>,
        linux-fsdevel@vger.kernel.org, linux-integrity@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-unionfs@vger.kernel.org,
        miklos@szeredi.hu, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 26, 2023 at 5:40=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com> wr=
ote:
>
> On Thu, 2023-09-21 at 20:01 +0300, Amir Goldstein wrote:
> > On Thu, Sep 21, 2023 at 7:31=E2=80=AFPM Mimi Zohar <zohar@linux.ibm.com=
> wrote:
> > >
...
> > > Let's see if Amir's patch actually fixes the original problem before
> > > making any decisions.  (Wishing for a reproducer of the original
> > > problem.)
> > >
> >
> > Confused. What is the "original problem"?
> > I never claimed that my patch fixes the "original problem".
> > I claimed [1] that my patch fixes a problem that existed before
> > db1d1e8b9867, but db1d1e8b9867 added two more instances
> > of that bug (wrong dereference of file->f_path).
> > Apparently, db1d1e8b9867 introduced another bug.
> >
> > It looks like you should revert db1d1e8b9867, but regardless,
> > I recommend that you apply my patch. My patch conflicts
> > with the revert but the conflict is trivial - the two hunks that
> > fix the new vfs_getattr_nosec() calls are irrelevant - the rest are.
> >
> > Thanks,
> > Amir.
> >
> > [1] https://lore.kernel.org/linux-unionfs/20230913073755.3489676-1-amir=
73il@gmail.com/
>
> Here are some of the issues with IMA/Overlay:
>
> 1. False positive syzbot IMA/overlay lockdep warnings.
> 2, Not detecting file change with squashfs + overlay.
> 3. Changes to the backing file are not detected by overlay (when
> backing file is not in policy).
>
> Commit db1d1e8b9867 ("IMA: use vfs_getattr_nosec to get the i_version")
> upstreamed to address 2, but has become unnecessary due to other
> changes.  According to Stefan, the problem subsequently was resolved
> without either commit db1d1e8b9867 or 18b44bc5a672.  (Kernel was not
> bi-sected to find bug resolution.)
>
> Commit 18b44bc5a672 ("ovl: Always reevaluate the file signature for
> IMA") to address 3.
>
> [PATCH] "ima: fix wrong dereferences of file->f_path" is probably
> correct.  Does it address any syzbot reports?
>

Not that I know of.

Mimi,

I am going to change my recommendation to -
Please wait with applying my patch unless you know that it
fixes a known bug, because:

1. I don't have a complete picture of ovl+IMA
2. I didn't find any specific test case to prove the bug
3. I have a plan to get rid of the file_real_path() anomaly

Thanks,
Amir.
