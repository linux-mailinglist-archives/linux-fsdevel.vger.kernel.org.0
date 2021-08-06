Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85BD13E23E3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Aug 2021 09:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243603AbhHFHVA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Aug 2021 03:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243598AbhHFHU6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Aug 2021 03:20:58 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A9C061799
        for <linux-fsdevel@vger.kernel.org>; Fri,  6 Aug 2021 00:20:41 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id t29so4658965vsr.5
        for <linux-fsdevel@vger.kernel.org>; Fri, 06 Aug 2021 00:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OcY+NhjZCxDCc6fzI/JMYTvUJ3ohCx1BhlM5JB9bQ6c=;
        b=J3lNdliQzbk3pJH/RUiwJjKq9xf2/J7wLsjKTtnHdvLrVFVazpThcttNeuAXG5WWoh
         vAJmmVBxfe+N0fq50fwFVgkfN3aXdVmvcVwgdu1spbWh1sVx1t4Sw5FGC1Y6YmH95Vp+
         ASQe6IPEvrs/ZAlP1cyHlROienYUHOCoXc8GY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OcY+NhjZCxDCc6fzI/JMYTvUJ3ohCx1BhlM5JB9bQ6c=;
        b=L9J87XSpzR3F8SynHEbmurFWgyQshs4KniP8KKTwJUISR9s+2OVjDX+ZA4Bh+3OTYz
         kRa9/MSmN60LGpYiHGo2/i6eOe437oSQTrfeQGrc02k9coWEbo4l+eqc4ESJCaC3dQna
         NJdXOsIXFyqCy5+O2e7a/yr+6pY+7t7/UBUAbKBPgWNCrsPJtoYTqeIPOj7uMQVTAkSh
         NakukIVsCHqTbflJIWINDeyY9c39/egT84mHaNJrOh4HnLHCeQKhBQyoPSwxc8dX4BaE
         4XWBj262EwXov9mrFrS9d/1VsGEjpWdTznKBDQooefLxsaJZr+1JpoVRMsnNvLTv8kJO
         pv5w==
X-Gm-Message-State: AOAM531YgdDJ6U2lrEI0x7HLwm3mcbjsdUzV81Ae4Tp6j+Le5++YZhd6
        x6muaUL2TlTwHlVyscaelXoWFJqrLOWz3TjhwFPTYw==
X-Google-Smtp-Source: ABdhPJzTE3mmzftvUeFfpXLtrsr52EidXjI+2jHkP2Wx8+U1MSmy0ZqLrEZ6em36Vyk5Qei/P5cOrqb9hi8jpV9vS1s=
X-Received: by 2002:a05:6102:34d9:: with SMTP id a25mr7990025vst.0.1628234440687;
 Fri, 06 Aug 2021 00:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000001b19a05c85fdb77@google.com>
In-Reply-To: <00000000000001b19a05c85fdb77@google.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Fri, 6 Aug 2021 09:20:30 +0200
Message-ID: <CAJfpegs=bJZ+ekx7=LJ9nZEivyhu7PctnH22HxPAVJCNZErn9A@mail.gmail.com>
Subject: Re: [syzbot] WARNING in fuse_get_tree
To:     syzbot <syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 31 Jul 2021 at 01:48, syzbot
<syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    2265c5286967 Add linux-next specific files for 20210726
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=102c92b6300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=531dbd796dcea4b4
> dashboard link: https://syzkaller.appspot.com/bug?extid=afacc3ce1215afa24615
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14d97fca300000
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=174a53f8300000
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+afacc3ce1215afa24615@syzkaller.appspotmail.com

Fix folded into fuse.git#for-next

#syz fix: fuse: allow sharing existing sb

Thanks,
Miklos
