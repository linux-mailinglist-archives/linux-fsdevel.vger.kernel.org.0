Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CE23790F1E
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Sep 2023 00:47:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349355AbjICWr7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 3 Sep 2023 18:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjICWr6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 3 Sep 2023 18:47:58 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1846DDA;
        Sun,  3 Sep 2023 15:47:55 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id 006d021491bc7-57325fcd970so579583eaf.1;
        Sun, 03 Sep 2023 15:47:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693781274; x=1694386074; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jTpRzKKPcflfMotZqn/EuHDpmA3Dpx0bR9KzRWNQ8CA=;
        b=MaoIxzoXeCkiJw6JUTSM5r4edBjL36206sQax/WRTXWhub4beIxp6PL7AYTq9bsYOT
         mpdXSao3zyPEY1F0RGOK3lK76VleRMkpUgvr2Id0FmjyM9DmOjNYxjX2xMyxEeIXccKj
         ebG8m0OZAAsW9vCPCi0aR+NQ02gpobP4p2/mgEHsPxySvKrHVGCly0QWoof2AnfJ0P0c
         v6oNxTxC1no3wM1rNExN282IpIb2BPeTVxIW91c126EWoKlJdxMPEr93sVH/K2+/l0LY
         RwDiTU4DBGJjQ+bgcmG/iMh69HQOO0H8ndnaGY6aarJn3hFvBQhRObICqIh9XouCEB37
         AaBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693781274; x=1694386074;
        h=cc:to:subject:message-id:date:from:references:in-reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jTpRzKKPcflfMotZqn/EuHDpmA3Dpx0bR9KzRWNQ8CA=;
        b=XdERH+oXVRrQm/j+IMSPtCteUoFLxRkCA1OUrAnDTt5+YRfjYd5E2inT1X2dN0lg6K
         AapGKV5jrM5i+DDBNVuWu9DlYqJxbZhjdDB6cLgLQBagxdsDE014Ep9BjnKH/i4FKbSr
         qAQmfqA9Z1LZ2c5zOIVVqJHGfdMrsPfqw2QfVnnzhyfRVxd18aVRotpTOAcV/WzsRu9I
         eT6pmcdaDIDzPY5yhBuF+whXq0gRnn5RZxD+F+6fjpnIWrhjvW/IqfR7a/NuVQVyOxQz
         0haah05f81KDRUU9zNnRZEeraDVl2Z6h8aJf7eW6LTsTo/ICGT7OFilbSYjU7cHyIT5/
         tFWQ==
X-Gm-Message-State: AOJu0Yxk1RfUWxFgHs1/2wrbFk2f416MSAAUF6zm8j1rhkh2aDfhlzy1
        PNiLatHqNugzHRgmFAS+IDiU1fxYhpghPAQZ9e2UZtxTCD8=
X-Google-Smtp-Source: AGHT+IHTd6MlXrnOCrfi9djKCiTH2QWP90e7G83CiNXHFAlfTnFmDirKNEOi/0fmGWMf/Ypx/Z30DjjRWhA4Zv/VtkI=
X-Received: by 2002:a4a:3410:0:b0:56d:e6:21bf with SMTP id b16-20020a4a3410000000b0056d00e621bfmr6787218ooa.0.1693781274367;
 Sun, 03 Sep 2023 15:47:54 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:60c:0:b0:4f0:1250:dd51 with HTTP; Sun, 3 Sep 2023
 15:47:53 -0700 (PDT)
In-Reply-To: <ZPUIQzsCSNlnBFHB@dread.disaster.area>
References: <000000000000e6432a06046c96a5@google.com> <ZPQYyMBFmqrfqafL@dread.disaster.area>
 <20230903083357.75mq5l43gakuc2z7@f> <ZPUIQzsCSNlnBFHB@dread.disaster.area>
From:   Mateusz Guzik <mjguzik@gmail.com>
Date:   Mon, 4 Sep 2023 00:47:53 +0200
Message-ID: <CAGudoHE_-2765EttOV_6B9EeSuOxqo1MiRCyFP9y=GbSeCMtZg@mail.gmail.com>
Subject: Re: [syzbot] [xfs?] INFO: task hung in __fdget_pos (4)
To:     Dave Chinner <david@fromorbit.com>
Cc:     syzbot <syzbot+e245f0516ee625aaa412@syzkaller.appspotmail.com>,
        brauner@kernel.org, djwong@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, llvm@lists.linux.dev, nathan@kernel.org,
        ndesaulniers@google.com, syzkaller-bugs@googlegroups.com,
        trix@redhat.com, viro@zeniv.linux.org.uk
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 9/4/23, Dave Chinner <david@fromorbit.com> wrote:
> On Sun, Sep 03, 2023 at 10:33:57AM +0200, Mateusz Guzik wrote:
>> On Sun, Sep 03, 2023 at 03:25:28PM +1000, Dave Chinner wrote:
>> > On Sat, Sep 02, 2023 at 09:11:34PM -0700, syzbot wrote:
>> > > Hello,
>> > >
>> > > syzbot found the following issue on:
>> > >
>> > > HEAD commit:    b97d64c72259 Merge tag
>> > > '6.6-rc-smb3-client-fixes-part1' of..
>> > > git tree:       upstream
>> > > console output:
>> > > https://syzkaller.appspot.com/x/log.txt?x=14136d8fa80000
>> > > kernel config:
>> > > https://syzkaller.appspot.com/x/.config?x=958c1fdc38118172
>> > > dashboard link:
>> > > https://syzkaller.appspot.com/bug?extid=e245f0516ee625aaa412
>> > > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for
>> > > Debian) 2.40
>> > >
>> > > Unfortunately, I don't have any reproducer for this issue yet.
>> >
>> > Been happening for months, apparently, yet for some reason it now
>> > thinks a locking hang in __fdget_pos() is an XFS issue?
>> >
>> > #syz set subsystems: fs
>> >
>>
>> The report does not have info necessary to figure this out -- no
>> backtrace for whichever thread which holds f_pos_lock. I clicked on a
>> bunch of other reports and it is the same story.
>
> That's true, but there's nothing that points at XFS in *any* of the
> bug reports. Indeed, log from the most recent report doesn't have
> any of the output from the time stuff hung. i.e. the log starts
> at kernel time 669.487771 seconds, and the hung task report is at:
>

I did not mean to imply this is an xfs problem.

You wrote reports have been coming in for months so it is pretty clear
nobody is investigating. I figured I'm going to change that bit.

>> Can the kernel be configured to dump backtraces from *all* threads?
>
> It already is (sysrq-t), but I'm not sure that will help - if it is
> a leaked unlock then nothing will show up at all.
>

See the other part of the thread, I roped in someone from syzkaller
along with the question if they can use sysrq t.

-- 
Mateusz Guzik <mjguzik gmail.com>
