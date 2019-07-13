Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 71C8767738
	for <lists+linux-fsdevel@lfdr.de>; Sat, 13 Jul 2019 02:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727541AbfGMA1f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 12 Jul 2019 20:27:35 -0400
Received: from mail-lj1-f174.google.com ([209.85.208.174]:42311 "EHLO
        mail-lj1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727393AbfGMA1e (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 12 Jul 2019 20:27:34 -0400
Received: by mail-lj1-f174.google.com with SMTP id t28so10917527lje.9
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 17:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nfl0wnnWuYc24xUzw/EVGY+2MfERMWxbutDcZnI1BQA=;
        b=CjNajGQKwwF6Ge8LXYLMNdlEDTDz2Lqd7XOtYZTwXuzl/zfscI8s6S/wpHGG0DUgHD
         ogxbG4UCpQD9D8aJw7ND3Sw6f9EqWbP+NsgM2LUaWE4zMgqeLAM3/IwjO6cCYSy3rLa1
         aSvD/8JCjn9fsqH0aeQRhQvk0HyydNbnoQlrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nfl0wnnWuYc24xUzw/EVGY+2MfERMWxbutDcZnI1BQA=;
        b=bMOtRJHkxi+BpSPFumxOklVD2ZfnU3rL/yolxHHb1svRx60OyNm91GZKbcIa39pEQc
         GZ+FfddPURbmjWAUXdK44kcn892tUsPgd5QcAdhizyxPlleKZfwPSzF8DJaKq8/AfZrj
         /n9P/Uyhli2B7ytrDcZT/M2IQPBelwyT2dCOelWky/FEvBKwRHb/9kRGmPrayZr54EOi
         BQKfyhL52tFo1O0FXOajOyGb2VCPbjj+EvnvGQNL8HdZ9Xi/IIDNl9Qi/WPLyQI4OvLg
         f4X6IUx9RS7JRcy7C8XwHTt048X55RzzUjmh+4g01Eb7ovWn5rT9GNEwG2FLb/ILOCAc
         1t9w==
X-Gm-Message-State: APjAAAWGwMPc2laqPr2q/6DoVfOh/5GrcZZ2LjEjWpHnO12RfgYOM60U
        GPoDXpUT9dmv+CoSneynIMDkusD3EC4=
X-Google-Smtp-Source: APXvYqzSJQY2AGcLiaGYGHSft36cIbHOkpI9UJNAMZcEMQUtKRiUSNtP8XyR3xflpBRlwuVzWMEK+Q==
X-Received: by 2002:a2e:8155:: with SMTP id t21mr7417665ljg.80.1562977652309;
        Fri, 12 Jul 2019 17:27:32 -0700 (PDT)
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com. [209.85.167.43])
        by smtp.gmail.com with ESMTPSA id h10sm1301604lfp.33.2019.07.12.17.27.31
        for <linux-fsdevel@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Fri, 12 Jul 2019 17:27:31 -0700 (PDT)
Received: by mail-lf1-f43.google.com with SMTP id u10so7528949lfm.12
        for <linux-fsdevel@vger.kernel.org>; Fri, 12 Jul 2019 17:27:31 -0700 (PDT)
X-Received: by 2002:ac2:44c5:: with SMTP id d5mr6224027lfm.134.1562977651157;
 Fri, 12 Jul 2019 17:27:31 -0700 (PDT)
MIME-Version: 1.0
References: <20190712180205.GA5347@magnolia>
In-Reply-To: <20190712180205.GA5347@magnolia>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 12 Jul 2019 17:27:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
Message-ID: <CAHk-=wiK8_nYEM2B8uvPELdUziFhp_+DqPN=cNSharQqpBZ6qg@mail.gmail.com>
Subject: Re: [GIT PULL] xfs: new features for 5.3
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 12, 2019 at 11:02 AM Darrick J. Wong <djwong@kernel.org> wrote:
>
> The branch merges cleanly against this morning's HEAD and survived an
> overnight run of xfstests.  The merge was completely straightforward, so
> please let me know if you run into anything weird.

Hmm. I don't know what you merged against, but it got a (fairly
trivial) conflict for me due to

  79d08f89bb1b ("block: fix .bi_size overflow")

from the block merge (from Tuesday) touching a line next to one changed by

  a24737359667 ("xfs: simplify xfs_chain_bio")

from this pull.

So it wasn't an entirely clean merge for me.

Was it a complex merge conflict? No. I'm just confused by the "merges
cleanly against this morning's HEAD", which makes me wonder what you
tried to merge against..

            Linus
