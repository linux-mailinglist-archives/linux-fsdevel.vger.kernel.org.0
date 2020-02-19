Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 37B8F164EE0
	for <lists+linux-fsdevel@lfdr.de>; Wed, 19 Feb 2020 20:26:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726756AbgBST0k (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 19 Feb 2020 14:26:40 -0500
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36187 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgBST0j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 19 Feb 2020 14:26:39 -0500
Received: by mail-lj1-f193.google.com with SMTP id r19so1611185ljg.3
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 11:26:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1fTub4GYfjONmIT82CPg1N7dCoXEnM2Sw2O8KqYucXw=;
        b=TTXA143+I9mRmEBx9/1NhLISHKMsH6waUZcmcpT1BguCNEKTR0hF7JmV5HoBZEGz3o
         db9fi0sUaay+pAz0CQoHWY2cCDHTPEMKkMTVnGzY174vOn3S+TeHtv27+wikNuljtZEX
         gzePqVGy4l+pJiMwf4qLcoz9ecA3N8Y267gYc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1fTub4GYfjONmIT82CPg1N7dCoXEnM2Sw2O8KqYucXw=;
        b=q5cIS/HjCOVlhCat1WauTOmp7AY7+ORaQp4LKvuJTvreGSx4mLLZ4u9rJLKONvsACb
         1Z3OtIblyfCionF427kkwQ1e0tvlmlWzGg8k5G7fS0dkXLx0GtGWxcN8xia95KAWz94S
         sqvWC0f0twrV/NQa9NZqj4NiKI6vF85DqI0rdp/6Za0cwJOLJJMpQaoGl/qmAiwWHOL1
         4hZvWouw9Pfjq1X3wG71wc6vJ+3fND1C+L4F0PRfC3OEmHXJjsNmyNZeQIBxgSN20Se4
         F7rr8sBzZRw39Be0jXY9yk8f7vldgCSJr5N2XcPWJhAPgz9gYMOaVm+Zu9omfnTyJ71f
         Hxtw==
X-Gm-Message-State: APjAAAVYxPyxruaEyChyYf5Qe04Lv3dyGfN7gPesv/J9B1Ai6Ihv5t5z
        Er1sK74VFnAqnSzTE7MdsEw9EX07HVk=
X-Google-Smtp-Source: APXvYqwFeZXmRM5K2/mO9TDVEOkIZvMQXG6VIHEldMmN5VNc38/VA9rqyc21yMzNCSuDwp9k97uGJw==
X-Received: by 2002:a2e:b610:: with SMTP id r16mr17365972ljn.33.1582140395853;
        Wed, 19 Feb 2020 11:26:35 -0800 (PST)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id k12sm310476lfc.33.2020.02.19.11.26.34
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 11:26:35 -0800 (PST)
Received: by mail-lj1-f175.google.com with SMTP id x14so1544793ljd.13
        for <linux-fsdevel@vger.kernel.org>; Wed, 19 Feb 2020 11:26:34 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr16050682ljg.209.1582140394436;
 Wed, 19 Feb 2020 11:26:34 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
 <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
In-Reply-To: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 11:26:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=whE0uzJy1C5z-GB-s7YioW_yhiEaes4cNa6tLJwyx19gA@mail.gmail.com>
Message-ID: <CAHk-=whE0uzJy1C5z-GB-s7YioW_yhiEaes4cNa6tLJwyx19gA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 19, 2020 at 11:07 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Actually, since this is apparently a different filetype, the _logical_
> thing to do is to use "mknod()".

Btw, don't get me wrong. I realize that you want to send other
information too in order to fill in all the metadata for what the
mountpoint then _does_.

So the "mknod()" thing would be just to create a local placeholder
(and an exclusive name) on the client - and then you do the ioctl on
that (or whatever) that sends over the metadata to the server along
with the name.

Think of it as a way to get a place to hook into things, and a (local
only) reservation for the name.

               Linus
