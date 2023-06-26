Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B87A773E4E2
	for <lists+linux-fsdevel@lfdr.de>; Mon, 26 Jun 2023 18:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231932AbjFZQXr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 26 Jun 2023 12:23:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231954AbjFZQXX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 26 Jun 2023 12:23:23 -0400
Received: from mail-ua1-x933.google.com (mail-ua1-x933.google.com [IPv6:2607:f8b0:4864:20::933])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EEA11B7;
        Mon, 26 Jun 2023 09:21:29 -0700 (PDT)
Received: by mail-ua1-x933.google.com with SMTP id a1e0cc1a2514c-7919342c456so834172241.2;
        Mon, 26 Jun 2023 09:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687796488; x=1690388488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwwgqiMrVmM1eYVFUtW7ZXKf6dJ3xT9dHrtUvYYp2tI=;
        b=nid/mGjZJ3pQbK55R+nmNZ6cJsJi/dvJrlPbqKkaDDEDQ+xeLSdri+PpvpxvN1fJy2
         pliA2WN1SgSDcGtZJ0CtW6PCToSSJGYSmlrYMds9bb9E7KfiECWBiOsFTO/10TAfrksm
         cFLuSnL9fQ01QyDe50lt9xHv2rrXYtEMwczRm5TDj3J/dwAHmDq+GClGmcpIaYFC7Hzt
         zaTcth93OyGCb7cD5O2mw4w3J7mOzppOb2DXRr3i6N0e89jgfMlnn6KywEjxK+XFuO81
         gcoXmNCOC4ZFN4X91uUcgsFIMcPHJTX9l2BthtOJqx6vu1QLyMNitt4v67374esCIiI2
         l13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687796488; x=1690388488;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwwgqiMrVmM1eYVFUtW7ZXKf6dJ3xT9dHrtUvYYp2tI=;
        b=M3Qo9tCr3SC+jTpdrvAfr1facEPPXE468ip8L7ficgOImbGJEjRM7mGdmlXuXCdA1w
         0GYNOx8SjI6UbR54E9GRZFaSzeK2KoyEk/uWMqp5HHIW3pQNNqP5gLkzP1PSeQZ3IBNJ
         eolRRIxg36JpiD/WwPFyiZoe0iPFL3+PsGceJSITVXW+DH7gdeI1QI9IXjtc9h42KGvk
         ivfkMxxSqXCgR/mUK6GUpOO0FrZPHDOnXuvEtjbiZwr02owkZzT8HA0RET/1trDYTgqq
         IheENUpeYfi5VFpw9oDVaBzxvUycSKlmFf1BCe6YU81dnNNx1+LjpHOXHDOBi/yS22+B
         7wyw==
X-Gm-Message-State: AC+VfDxKO/VO2QHf1mkZqvwCUJkcdb+kkGMYdNEfc0uAlxKo+5KlB9qG
        gdBgWbjiTLASE+4bUgzk7ah9izBiSo2Rz7vcPUk=
X-Google-Smtp-Source: ACHHUZ4JukKKcmEtxtgN72mCvCGMNSEQ7HZucR2Pd+aIipmM4vhLc0izGrmJnCoy5Jr1froBK7eYAPNlSP+8yUUjXLI=
X-Received: by 2002:a05:6102:3550:b0:443:5340:e29e with SMTP id
 e16-20020a056102355000b004435340e29emr1211662vss.27.1687796488155; Mon, 26
 Jun 2023 09:21:28 -0700 (PDT)
MIME-Version: 1.0
References: <jbyihkyk5dtaohdwjyivambb2gffyjs3dodpofafnkkunxq7bu@jngkdxx65pux>
 <CAOQ4uxhut2NHc+MY-XOJay5B-OKXU2X5Fe0-6-RCMKt584ft5A@mail.gmail.com>
 <ndm45oojyc5swspfxejfq4nd635xnx5m35otsireckxp6heduh@2opifgi3b3cw>
 <CAOQ4uxgCrxMKO7ZgAriMkKU-aKnShN+CG0XqP-yYFiyR=Os82A@mail.gmail.com> <jbg6kfxwniksrgnmnxr7go5kml2iw3tucnnbe4pqhvi4in6wlo@z6m4tcanewmk>
In-Reply-To: <jbg6kfxwniksrgnmnxr7go5kml2iw3tucnnbe4pqhvi4in6wlo@z6m4tcanewmk>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 26 Jun 2023 19:21:16 +0300
Message-ID: <CAOQ4uxjizutWR37dm5RxiBY_L-bVHndJYaK_CHi88ZTT0DNpjg@mail.gmail.com>
Subject: Re: splice(-> FIFO) never wakes up inotify IN_MODIFY?
To:     =?UTF-8?Q?Ahelenia_Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jan Kara <jack@suse.cz>,
        Chung-Chiang Cheng <cccheng@synology.com>
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

On Mon, Jun 26, 2023 at 6:12=E2=80=AFPM Ahelenia Ziemia=C5=84ska
<nabijaczleweli@nabijaczleweli.xyz> wrote:
>
> On Mon, Jun 26, 2023 at 05:53:46PM +0300, Amir Goldstein wrote:
> > > So is it really true that the only way to poll a pipe is a
> > > sleep()/read(O_NONBLOCK) loop?
> > I don't think so, but inotify is not the way.
> So what is? What do the kernel developers recommend as a way to see if a
> file is written to, and that file happens to be a pipe?
>
> FTR, I've opened the symmetric Debian#1039488:
>   https://bugs.debian.org/1039488
> against coreutils, since, if this is expected, and writing to a pipe
> should not generate write events on that pipe, then tail -f is currently
> broken on most systems.

First of all, it is better to mention that you are trying to fix a real
world use case when you are reporting a kernel misbehavior.

What this makes me wonder is, if tail -f <fifo> is broken as you claim
it is, how is it that decades go by without anyone noticing this problem?

When looking at tail source code I see:

/* Mark as '.ignore'd each member of F that corresponds to a
   pipe or fifo, and return the number of non-ignored members.  */
static size_t
ignore_fifo_and_pipe (struct File_spec *f, size_t n_files)
{
  /* When there is no FILE operand and stdin is a pipe or FIFO
     POSIX requires that tail ignore the -f option.
     Since we allow multiple FILE operands, we extend that to say: with -f,
     ignore any "-" operand that corresponds to a pipe or FIFO.  */

and it looks like tail_forever_inotify() is not being called unless
there are non pipes:

  if (forever && ignore_fifo_and_pipe (F, n_files))
    {

The semantics of tail -f on a pipe input would be very odd, because
the writer would need to close before tail can figure out which are
the last lines.

So honestly, we could maybe add IN_ACCESS/IN_MODIFY for the
splice_pipe_to_pipe() case, but I would really like to know what
the real use case is.

Another observation is that splice(2) never used to report any
inotify events at all until a very recent commit in v6.4
983652c69199 ("splice: report related fsnotify events")
but this commit left out the splice_pipe_to_pipe() case.

CC the author of the patch to ask why this case was left
out and whether he would be interested in fixing that.

Thanks,
Amir.
