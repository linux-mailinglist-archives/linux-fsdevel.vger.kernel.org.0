Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5CCBEF3
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Oct 2019 17:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389572AbfJDPTY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Oct 2019 11:19:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389461AbfJDPTY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Oct 2019 11:19:24 -0400
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id C5A482133F;
        Fri,  4 Oct 2019 15:19:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570202363;
        bh=M5+OP0C7bH8g4alRKHkF9BOu2CIDNCLVySSeuKwcpOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=b6/jzAnDjb6xpzkFpwbf9jb1gAfI7h+uV/bCk3yqqWvPCCOHFv98o3z/O+2VQoetR
         1SBzvZekcGRpybjr/NOZ4N+WGFQQpHOaS3QkgPyjU/ZW9Q+LSkJnzwiImDPJaiW/IX
         fQk720EuOH3wQLQ+wFzMMFljxxegoUD3qgLIyWKg=
Received: by mail-lf1-f48.google.com with SMTP id r22so4777009lfm.1;
        Fri, 04 Oct 2019 08:19:22 -0700 (PDT)
X-Gm-Message-State: APjAAAUoG8c+HHj9rPpoWQU71ozEDAFCktslcb3K+i6h1rEURgV4uflT
        S5ZMAd8g9r6q2GY54cIBkYAS1d+V7RFQmrCFJos=
X-Google-Smtp-Source: APXvYqzsMWLRJ8Xp3xwwJCUFKB9iLKSsHQhlyh9TGJTJDW+xLrwe2s6/G9RAIUq1kyCNWedZWpQzahnVXH+EAatAAak=
X-Received: by 2002:a19:7d55:: with SMTP id y82mr9289884lfc.106.1570202361022;
 Fri, 04 Oct 2019 08:19:21 -0700 (PDT)
MIME-Version: 1.0
References: <20191004145016.3970-1-krzk@kernel.org> <20191004151448.GA19056@nautica>
In-Reply-To: <20191004151448.GA19056@nautica>
From:   Krzysztof Kozlowski <krzk@kernel.org>
Date:   Fri, 4 Oct 2019 17:19:09 +0200
X-Gmail-Original-Message-ID: <CAJKOXPdn4j2vNcsBZOOZeO3_c4f--eJvoUzsf_1nY7LK4-uubA@mail.gmail.com>
Message-ID: <CAJKOXPdn4j2vNcsBZOOZeO3_c4f--eJvoUzsf_1nY7LK4-uubA@mail.gmail.com>
Subject: Re: [RESEND TRIVIAL] fs: Fix Kconfig indentation
To:     Dominique Martinet <asmadeus@codewreck.org>
Cc:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Miklos Szeredi <miklos@szeredi.hu>,
        Jiri Kosina <trivial@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        v9fs-developer@lists.sourceforge.net,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 4 Oct 2019 at 17:17, Dominique Martinet <asmadeus@codewreck.org> wrote:
>
> Krzysztof Kozlowski wrote on Fri, Oct 04, 2019:
> > Adjust indentation from spaces to tab (+optional two spaces) as in
> > coding style with command like:
> >     $ sed -e 's/^        /\t/' -i */Kconfig
> >
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
>
> Send this to kernel-janitors@vger.kernel.org ?
>
> I can't pick this up as a 9p maintainer and most probably everyone else
> in copy feel similar, this is stuff where they might be able to handle
> this smoothly.
>
> (I have no problem with the 9p part of the patch, so add my ack or
> whatever if you feel that is useful, but it's honestly trivial as you
> wrote yourself)

Thanks, indeed I forgot about kernel-janitors. I sent it only to Jiri
Kosina who is mentioned as handler of trivial patches.

Best regards,
Krzysztof
