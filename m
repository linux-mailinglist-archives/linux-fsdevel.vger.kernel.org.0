Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 906BEA3749
	for <lists+linux-fsdevel@lfdr.de>; Fri, 30 Aug 2019 14:57:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727999AbfH3M5E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 30 Aug 2019 08:57:04 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36318 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727522AbfH3M5E (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 30 Aug 2019 08:57:04 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so7487045qtc.3;
        Fri, 30 Aug 2019 05:57:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=SFaIBBUhr4/2SlKlC0SL+JS7SwhLYOWGWRxz8fCIXxs=;
        b=V7y82OeYxHoKF2bMgFWXDxbpr5IM9dUbPZ9UDk1SoC+/u4ItFqpuSO3uNH7DB9Rx9w
         qYPTqv5OINm45mVxdoC9D0lh11juJGQX5OiDqOU8G/RdBEb6Jc97JExC74Iiwz8VQG8F
         CLoP6DRB/xEUVlZVyZWtxBBYigkOAtQiqsCght6YPNvzmX3VSplR0WUG1w37cgN17ixT
         Ap9Azd5HAYqwsPaF7NGJVvOb/8Sl9JE2f4SC1xbaDeGpYSPhHG+fFJvA+mYf0SVwnzNG
         zxhrpa1WUDa2ezgDKlDGm5itn0+RSq1w5OWNyLRf31dD0wdaTBJincXJVoL/LzwGvWNI
         Bjhw==
X-Gm-Message-State: APjAAAXGt9rQMoZLZn322xlpnh4zQagQ/XxEJ7DTM11yzOpuhVrAYn7H
        r9elxp7LZmbkW0JtwpWXkkLCB7bwywu1kciUgiE=
X-Google-Smtp-Source: APXvYqx86F6I04uUf5dj55lbh3ezYYy6ct+9ri3fU2IjZXZtb6IRyo6Yls4GC5k0q7MYBeyK3/385Tfjt0p1owjzSts=
X-Received: by 2002:ac8:117:: with SMTP id e23mr15085989qtg.18.1567169823216;
 Fri, 30 Aug 2019 05:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20190829041132.26677-1-deepa.kernel@gmail.com>
In-Reply-To: <20190829041132.26677-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 30 Aug 2019 14:56:46 +0200
Message-ID: <CAK8P3a1XjOMpuS12Xao1xqOLFOuz1Jb8dTAfrhLcE643sSkC5g@mail.gmail.com>
Subject: Re: [GIT PULL] vfs: Add support for timestamp limits
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Andreas Dilger <adilger@dilger.ca>, aivazian.tigran@gmail.com,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        David Sterba <dsterba@suse.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Jeff Layton <jlayton@kernel.org>,
        Kees Cook <keescook@chromium.org>, me@bobcopeland.com,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 29, 2019 at 6:12 AM Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>
> Hi Al, Arnd,
>
> This is a pull request for filling in min and max timestamps for filesystems.
> I've added all the acks, and dropped the adfs patch. That will be merged through
> Russell's tree.
>
> Thanks,
> Deepa
>
> The following changes since commit 5d18cb62218608a1388858880ad3ec76d6cb0d3b:
>
>   Add linux-next specific files for 20190828 (2019-08-28 19:59:14 +1000)
>
> are available in the Git repository at:
>
>   https://github.com/deepa-hub/vfs limits

Please rebase this branch on top of linux-5.3-rc6 and resend.
I can't pull a branch that contains linux-next.

Maybe drop the orangefs patch for now, at least until we have come
to a conclusion on that.

       Arnd
