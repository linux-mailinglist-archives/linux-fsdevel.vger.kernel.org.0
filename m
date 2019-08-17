Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BD5DB90F74
	for <lists+linux-fsdevel@lfdr.de>; Sat, 17 Aug 2019 10:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbfHQI0B (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 17 Aug 2019 04:26:01 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:36514 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfHQIZ7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 17 Aug 2019 04:25:59 -0400
Received: by mail-ot1-f66.google.com with SMTP id k18so1189628otr.3
        for <linux-fsdevel@vger.kernel.org>; Sat, 17 Aug 2019 01:25:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jvdMEsGfymC76a7uG5PwO2y4dMCW+deyQ48R7uE+/MU=;
        b=PjnmyV4R4/vE8SwVOBpYyIjUAQxwUQZNycOOwH4dCTMAuDrJ5NFo/Bs2EEZoA8ntp0
         PCSowRy1/tx3yqfDfMStceS8sZ/XBv4gCrb2eZi2NZzyxumtVsGGyWla5EWNiwZj7OvP
         eNCEqFuezIH9D+4+Q3kilgH/V0JAvFnOYST+x3NmNXFEw1yihD/ud3uK6xa0rOgIUOoa
         qGT+VwznYEj0ZA/KvEcl9UaFYQUNFAQkfPASjDdudz+OIXGtcl7YymsXp8xNaMrTXCoa
         Rm3biSpDFa7YkR9B6qguhl5L0NAfixTy8+d0WZepBgSdoLj78SrlQ5E+dBAD9exKaj+o
         4iFg==
X-Gm-Message-State: APjAAAWIb1lz3bXgOcXGQFMS7sIIDJ9EYc3YUdyxgDXQcSWNYKscpYbn
        kXVlKA5bUmbfbdeZ/r2L82JgAZsaSq4vacTL6GHF+Q==
X-Google-Smtp-Source: APXvYqx6k/zgLSMkM1rApUpsoy+RhYN5+WYZVoeoL9mCyLZ03LqU+ku6jTp1ZW1nexIw0F+l6Nz9SwoAR7hAW6uOM/I=
X-Received: by 2002:a05:6830:22f4:: with SMTP id t20mr9344290otc.58.1566030358976;
 Sat, 17 Aug 2019 01:25:58 -0700 (PDT)
MIME-Version: 1.0
References: <156444945993.2682261.3926017251626679029.stgit@magnolia>
 <20190816065229.GA28744@infradead.org> <20190817014633.GE752159@magnolia>
In-Reply-To: <20190817014633.GE752159@magnolia>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sat, 17 Aug 2019 10:25:47 +0200
Message-ID: <CAHc6FU6GzaNNT6kBw9XE20TOAFZKusR7dC2cQAnM6CQzj0T3Mw@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] iomap: lift the xfs writepage code into iomap
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>, linux-xfs@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Damien Le Moal <Damien.LeMoal@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Aug 17, 2019 at 3:46 AM Darrick J. Wong <darrick.wong@oracle.com> wrote:
>
> On Thu, Aug 15, 2019 at 11:52:29PM -0700, Christoph Hellwig wrote:
> > Darrick,
> >
> > are you going to queue this up?
>
> Yes, I'll go promote the iomap writeback branch to iomap-for-next.  I
> haven't 100% convinced myself that it's a good idea to hook up xfs to it
> yet, if nothing else because of all the other problems I've had getting
> 5.3 testing to run to completion reliably...
>
> ...I assume gfs2 and zonedfs are getting ready to send stuff based on
> that branch?

It doesn't look like the gfs2 bits are going to be ready for 5.4.

Andreas
