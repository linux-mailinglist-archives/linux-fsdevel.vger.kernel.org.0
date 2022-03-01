Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F68C4C84D9
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 08:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232209AbiCAHWW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Mar 2022 02:22:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229771AbiCAHWW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Mar 2022 02:22:22 -0500
Received: from mail-vk1-xa34.google.com (mail-vk1-xa34.google.com [IPv6:2607:f8b0:4864:20::a34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BEF21EED8;
        Mon, 28 Feb 2022 23:21:42 -0800 (PST)
Received: by mail-vk1-xa34.google.com with SMTP id b64so3066344vkf.7;
        Mon, 28 Feb 2022 23:21:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yIhHbRiRsE369Y60O9So9Za6xEeWordfQYdXDUDiS1Y=;
        b=j+XVVDtX5Xt1++P52QR+lZEfQuFKMkJabOEQllcUpNHLHi7nrIrDs4eWRiVoxBpylF
         AhvmHZvhIZ54pmn3pGgcfsHrYPyBoXzAe+qwecrkWYI3XQu67FYVumFfKjE7i4vQMMHl
         r9Y6PeqKS8UC7a8iAgTNEz6Jbr7CBC1wDHCWxcz1qBpqfydgtwaSrthKd2K5njvgZ/1V
         bLcYldjP/BaNkkIo3ANGgvSMgFg7xBJEFEPF4GVwiVJK2dQOKHaB6Wr6TCH0SMpIKuzx
         n6C6iiRxy6zfzKz216PqcFAA0EfmZB0UVYdDRTKwKjyAJR7AkpE55R1S+hm1bj7b6NeZ
         E9Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yIhHbRiRsE369Y60O9So9Za6xEeWordfQYdXDUDiS1Y=;
        b=B0R7hurMvw4Vud5fsVs2SZhLuPuLoNBUx9rgcP8V9fhaGWhmfqs01wtLzZB0/W5mkE
         pW0H0ZVyTu2vzkxaR4L4TunVEzjBNASbB0yx5stE/MZ1H0/Y3Bdoj0imgKzMAVyXRXjh
         kxOHEBmOzVkIH9zTUQRSZI0HSvQMmuPAuPlMUBp3tESoaP88BOPTPTysb+mToHFbkaAY
         7HYQYLccSYpcjs2qmoereLYIJLZ8aJxe/Is2dPrTLQZ50DNpRsLFeXb28V4CE7jADHEb
         R92g9xZlPpocfOmOSEkM+QnKRego6FFR+voIsiAiCEf+rjDxtZ+707z2WMJY40ZAPapW
         YQWg==
X-Gm-Message-State: AOAM530d4fCO1GaTAl3zj8xYqpb3KxUsJbwazgIiAM9kHX82j1S+rie3
        lqf9sws5Q9JhbtHk2Zd00TNSDtrfQ9ZXVUW1mnE=
X-Google-Smtp-Source: ABdhPJx0f65q+nbNuz6F41AtV0+nlc6GVfOsX//5scKABZG+GDQ9u09qk04s4wFA4zwiR2OuLu9yu8wiED3Gqg9mXj0=
X-Received: by 2002:a05:6122:d04:b0:333:318c:1460 with SMTP id
 az4-20020a0561220d0400b00333318c1460mr4177721vkb.41.1646119301238; Mon, 28
 Feb 2022 23:21:41 -0800 (PST)
MIME-Version: 1.0
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
 <164311919732.2806745.2743328800847071763.stgit@warthog.procyon.org.uk>
 <CACdtm0YtxAUMet_PSxpg69OR9_TQbMQOzU5Kbm_5YDe_C7Nb-w@mail.gmail.com>
 <3013921.1644856403@warthog.procyon.org.uk> <CACdtm0Z4zXpbPBLJx-=AgBRd63hp_n+U-5qc0gQDQW0c2PY7gg@mail.gmail.com>
 <2498968.1646058507@warthog.procyon.org.uk>
In-Reply-To: <2498968.1646058507@warthog.procyon.org.uk>
From:   Rohith Surabattula <rohiths.msft@gmail.com>
Date:   Tue, 1 Mar 2022 12:51:30 +0530
Message-ID: <CACdtm0aZnQLyduKxr9dhcpYB_r00UFnR=WQvAnqL0DebxgbrOw@mail.gmail.com>
Subject: Re: [RFC PATCH 7/7] cifs: Use netfslib to handle reads
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, nspmangalore@gmail.com, jlayton@kernel.org,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        linux-fsdevel@vger.kernel.org
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

Hi David,

Below are traces:
              vi-9189    [001] ..... 64454.731493: fscache_acquire:
c=0000001f V=00000001 vr=31 vc=30
              vi-9189    [001] ..... 64454.739242: fscache_acquire:
c=00000020 V=00000001 vr=32 vc=31
              vi-9189    [001] ..... 64454.783474: fscache_acquire:
c=00000021 V=00000001 vr=33 vc=32
              vi-9189    [001] ..... 64454.794650: netfs_read:
R=00000007 READAHEAD c=00000000 ni=0 s=0 1000
              vi-9189    [001] ..... 64454.794652: netfs_read:
R=00000007 EXPANDED  c=00000000 ni=0 s=0 1000
              vi-9189    [001] ..... 64454.794661: netfs_sreq:
R=00000007[0] PREP  DOWN f=00 s=0 0/100000 e=0
              vi-9189    [001] ..... 64454.794662: netfs_sreq:
R=00000007[0] SUBMT DOWN f=00 s=0 0/100000 e=0
           cifsd-1390    [000] ..... 64454.817450: netfs_sreq:
R=00000007[0] TERM  DOWN f=02 s=0 100000/100000 e=0
           cifsd-1390    [000] ..... 64454.817451: netfs_rreq:
R=00000007 ASSESS f=20
           cifsd-1390    [000] ..... 64454.817452: netfs_rreq:
R=00000007 UNLOCK f=20
           cifsd-1390    [000] ..... 64454.817464: netfs_rreq:
R=00000007 DONE   f=00
           cifsd-1390    [000] ..... 64454.817464: netfs_sreq:
R=00000007[0] FREE  DOWN f=02 s=0 100000/100000 e=0
           cifsd-1390    [000] ..... 64454.817465: netfs_rreq:
R=00000007 FREE   f=00

Regards,
Rohith

On Mon, Feb 28, 2022 at 7:58 PM David Howells <dhowells@redhat.com> wrote:
>
> Rohith Surabattula <rohiths.msft@gmail.com> wrote:
>
> > R=00000006 READAHEAD c=00000000 ni=0 s=0 1000
> >               vi-1631    [000] .....  2519.247540: netfs_read:
>
> "c=00000000" would indicate that no fscache cookie was allocated for this
> inode.
>
> > COOKIE   VOLUME   REF ACT ACC S FL DEF
> > ======== ======== === === === = == ================
> > 00000002 00000001   1   0   0 - 4008 302559bec76a7924,
> > 0a13e961000000000a13e96100000000d01f4719d01f4719
> > 00000003 00000001   1   0   0 - 4000 0000000000640090,
> > 37630162000000003763016200000000e8650f119c49f411
>
> But we can see some cookies have been allocated.
>
> Can you turn on:
>
>   echo 1 >/sys/kernel/debug/tracing/events/fscache/fscache_acquire/enable
>
> David
>
