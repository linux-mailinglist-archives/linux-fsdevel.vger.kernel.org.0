Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BC327ADD74
	for <lists+linux-fsdevel@lfdr.de>; Mon, 25 Sep 2023 18:52:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjIYQwH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 25 Sep 2023 12:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjIYQwG (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 25 Sep 2023 12:52:06 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CBC59F
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:51:59 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id ada2fe7eead31-4525dd7f9d0so2479128137.3
        for <linux-fsdevel@vger.kernel.org>; Mon, 25 Sep 2023 09:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695660718; x=1696265518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Eh7n/+cLzjpARLvCjBzHgGhMYKtXqlHu85WkcQo8HuA=;
        b=fhS84E2+BBukOOFQyZyRCGjbzSdK64q2L5xLV7lbQM/b4whB5yavXj9cP10fp4lKwp
         KRJWIpkgpgQ1xod7DkMSb56lvtGbscnEmIK+7Fhm80QKL/3cEnoMn0n5AYhdJXH6xDUs
         kKbgCLR2ClRd65v5dZa8BjOb/9xySz+gx01+9W2tN9kr9l+w97jYUtl1BV2vPUHBjS3M
         T25FuOTJPs6S4yB5LovS+Q1w5D3fJk/qzHlbSIJYm4BeCB1vKkl/IOH4uuQCaDwXoDmV
         PC4ai6ySo/CLLoKqdjOJNwBCu53uXC3m+Vq22CwCcjmn8K4QF9PgAkX15OPinaTvIQk6
         D8DA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695660718; x=1696265518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Eh7n/+cLzjpARLvCjBzHgGhMYKtXqlHu85WkcQo8HuA=;
        b=DHZF0UJym8/MVI1hAv6DUqXxoDRTS+ON2BGNejDIjAkPrzCg/Ct6BH6aU9rbSaIuV8
         QNCUlQWuEdSfHkKsaLZBJ09L5bSVP5L5oBoeTqsTlyLIMGewDF0jn/xaXCajzc8IBt39
         gamLxutfzyzsQCpxqWIV203tiRykoCv86xjN6BIg0yP25C4uK7GoSyFvNoBOy+PCGHSI
         /AcW26brAMeUpJK1GqorTxmV827KsayoBqkWtDcHQFNJZMTuOqHOqhsvWXBQS/M3MQcI
         f8gLsv6xQTQ5PmcqryviBAvaaLPiZC5OMer35dpxaBTXk8uzH3Nv+nacQtwMcaUb/FMf
         xWbg==
X-Gm-Message-State: AOJu0YzNS5zErpI1XYgs1L2M31D4qT01ivWtCngQ0M0FXF+ijAOWq9uD
        aVq0RzyFc3TSkXEK2HWIYE2WUGwil/CC7M3+Ook=
X-Google-Smtp-Source: AGHT+IEEmKdeOkRNHmFizLT4hteSLXS/hMqmxgDmpUHuLNG/fZUm7J1RrjZ5mr7E3Qxx981iIDFT1lf1k0exV2dnk28=
X-Received: by 2002:a67:fb18:0:b0:452:78ea:4aec with SMTP id
 d24-20020a67fb18000000b0045278ea4aecmr3118054vsr.7.1695660718605; Mon, 25 Sep
 2023 09:51:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAOQ4uxjnCdAeWe3W4mp=DwgL49Vwp_FVx4S_V33A3-JLtzJb-g@mail.gmail.com>
 <ZQ75JynY8Y2DqaHD@casper.infradead.org> <CAOQ4uxjOGqWFdS4rU8u9TuLMLJafqMUsQUD3ToY3L9bOsfGibg@mail.gmail.com>
 <CAD_8n+SNKww4VwLRsBdOg+aBc7pNzZhmW9TPcj9472_MjGhWyg@mail.gmail.com>
 <CAOQ4uxjM8YTA9DjT5nYW1RBZReLjtLV6ZS3LNOOrgCRQcR2F9A@mail.gmail.com>
 <CAOQ4uxjmyfKmOxP0MZQPfu8PL3KjLeC=HwgEACo21MJg-6rD7g@mail.gmail.com>
 <ZRBHSACF5NdZoQwx@casper.infradead.org> <CAOQ4uxjmoY_Pu_JiY9U1TAa=Tz1Mta3aH=wwn192GOfRuvLJQw@mail.gmail.com>
 <ZRCwjGSF//WUPohL@casper.infradead.org> <CAD_8n+SBo4EaU4-u+DaEFq3Bgii+vX0JobsqJV-4m+JjY9wq8w@mail.gmail.com>
 <ZREr3M32aIPfdem7@casper.infradead.org> <CAOQ4uxgUC2KxO2fD-rSgVo3RyrrWbP-UHH+crG57uwXVn_sf2Q@mail.gmail.com>
 <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
In-Reply-To: <CAD_8n+QeGwf+CGNW_WnyRNQMu9G2_HJ4RSwJGq-b4CERpaA4uQ@mail.gmail.com>
From:   Amir Goldstein <amir73il@gmail.com>
Date:   Mon, 25 Sep 2023 19:51:47 +0300
Message-ID: <CAOQ4uxh7+avP=m8DW_u14Ea4Hrk1xhyuT--t2XX868CBquOCaA@mail.gmail.com>
Subject: Re: [LTP] [PATCH] vfs: fix readahead(2) on block devices
To:     Reuben Hawkins <reubenhwk@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        kernel test robot <oliver.sang@intel.com>,
        brauner@kernel.org, Cyril Hrubis <chrubis@suse.cz>,
        mszeredi@redhat.com, lkp@intel.com, linux-fsdevel@vger.kernel.org,
        viro@zeniv.linux.org.uk, oe-lkp@lists.linux.dev,
        ltp@lists.linux.it, Jan Kara <jack@suse.cz>
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

On Mon, Sep 25, 2023 at 6:36=E2=80=AFPM Reuben Hawkins <reubenhwk@gmail.com=
> wrote:
>
>
>
> On Mon, Sep 25, 2023 at 4:43=E2=80=AFAM Amir Goldstein <amir73il@gmail.co=
m> wrote:
>>
>> On Mon, Sep 25, 2023 at 9:42=E2=80=AFAM Matthew Wilcox <willy@infradead.=
org> wrote:
>> >
>> > On Sun, Sep 24, 2023 at 11:35:48PM -0500, Reuben Hawkins wrote:
>> > > The v2 patch does NOT return ESPIPE on a socket.  It succeeds.
>> > >
>> > > readahead01.c:54: TINFO: test_invalid_fd pipe
>> > > readahead01.c:56: TFAIL: readahead(fd[0], 0, getpagesize()) expected
>> > > EINVAL: ESPIPE (29)
>> > > readahead01.c:60: TINFO: test_invalid_fd socket
>> > > readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) succeede=
d
>> > > <-------here
>> >
>> > Thanks!  I am of the view that this is wrong (although probably
>> > harmless).  I suspect what happens is that we take the
>> > 'bdi =3D=3D &noop_backing_dev_info' condition in generic_fadvise()
>> > (since I don't see anywhere in net/ setting f_op->fadvise) and so
>> > return 0 without doing any work.
>> >
>> > The correct solution is probably your v2, combined with:
>> >
>> >         inode =3D file_inode(file);
>> > -       if (S_ISFIFO(inode->i_mode))
>> > +       if (S_ISFIFO(inode->i_mode) || S_ISSOCK(inode->i_mode))
>> >                 return -ESPIPE;
>> >
>> > in generic_fadvise(), but that then changes the return value from
>> > posix_fadvise(), as I outlined in my previous email.  And I'm OK with
>> > that, because I think it's what POSIX intended.  Amir may well disagre=
e
>> > ;-)
>>
>> I really have no problem with that change to posix_fadvise().
>> I only meant to say that we are not going to ask Reuben to talk to
>> the standard committee, but that's obvious ;-)
>> A patch to man-pages, that I would recommend as a follow up.
>>
>> FWIW, I checked and there is currently no test for
>> posix_fadvise() on socket in LTP AFAIK.
>> Maybe Cyril will follow your suggestion and this will add test
>> coverage for socket in posix_fadvise().
>>
>> Reuben,
>>
>> The actionable item, if all agree with Matthew's proposal, is
>> not to change the v2 patch to readahead(), but to send a new
>> patch for generic_fadvise().
>>
>> When you send the patch to Christian, you should specify
>> the dependency - it needs to be applied before the readahead
>> patch.
>
>
> I'm having a bit of a time coming up with a commit message for this
> change to fadvise...It just doesn't sound like something I would want
> to merge...
>
> "Change fadvise to return -ESPIPE for sockets.  This is a new failure
> mode that didn't previously exist.  Applications _may_ have to add new
> error handling logic to accommodate the new return value.  It needs to
> be fixed in fadvise so that readahead will also return new/unexpected
> error codes."
>
> It just doesn't feel right.  Nonetheless, here's the test results with
> the fadvise change + the v2 readahead patch...
>
> readahead01.c:54: TINFO: test_invalid_fd pipe
> readahead01.c:56: TFAIL: readahead(fd[0], 0, getpagesize()) expected EINV=
AL: ESPIPE (29)
> readahead01.c:60: TINFO: test_invalid_fd socket
> readahead01.c:62: TFAIL: readahead(fd[0], 0, getpagesize()) expected EINV=
AL: ESPIPE (29)
>
> It seems to me like I fixed something in readahead that once worked,
> readahead on block devices, and I'm now exchanging that once working
> behavior to a new failure to socket, which previously succeeded...even
> if it didn't do anything.
>
> Should I instead just check for S_ISSOCK in readahead so that both pipes
> and sockets will return EINVAL in readahead, and leave fadvise as is?
>

What you are saying makes sense.
And if we are being honest, I think that the right thing to do from the
beginning was to separate the bug fix commit from the UAPI change.

The minimal bug fix is S_ISREG || S_ISBLK, which
mentions the Fixes commit and will be picked for stable kernels.

Following up with another one or two patches that change
the behavior of posix_fadvise on socket and readahead on
socket and pipe.

The UAPI change is not something that has to go to stable
and it should be easily revertable independently of the bug fix.
Doing it otherwise would make our lives much harder if regressions
turn up from the UAPI change.

Christian, Matthew,

Do you agree?

>>
>>
>> If the readahead patch was not already in the vfs tree, you
>> would have needed to send a patch series with a cover letter,
>> where you would leave the Reviewed-by on the unchanged
>> [2/2] readahead patch.
>>
>> Sending a patch series is a good thing to practice, but it is
>> not strictly needed in this case, so I'll leave it up to you to decide.
>>

Reuben,

If there is agreement on the above, you may still get your chance
to send a patch set ;)

Thanks,
Amir.
