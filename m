Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9BF50119695
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Dec 2019 22:28:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728692AbfLJV14 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Dec 2019 16:27:56 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:32854 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728835AbfLJV1w (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Dec 2019 16:27:52 -0500
Received: by mail-io1-f67.google.com with SMTP id s25so5715100iob.0;
        Tue, 10 Dec 2019 13:27:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=H5mECpigsi5IoO0Gd/OMlOo5Xgi22xFbljTixm/LvJ8=;
        b=bbTprTIGy7WRDm/au9WDFJRyIht5M9SgTqsn/gyE+mocmzykvQab24Jh8AiBQhy9mO
         4h3/EYBeRJK+WS6KuJeUlj3PWkTwabcs2eJ0s8p6MtRiKeOKjs0DNAeEqH7loPWkP+4s
         zx8ka4wdOgAz/CrkdyCeRczY5tY1nRr+UqVb/LSdYthWiDHaD91NMzpfUfxkwzX27r7I
         g5k4TjWDvgt1R2nqF98iS3n4NdjTuEdHRAyaz4aBcx48in4266/zivrqfuVsYLvO9tlc
         OxWeHL2Ng8MMBld4JW+/gAWmupONWBbZS8/ItfF6Y4FL4/nErkmf4tFGHroQNdGx9P4i
         LLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=H5mECpigsi5IoO0Gd/OMlOo5Xgi22xFbljTixm/LvJ8=;
        b=G8MR6BmIVFjxchlQEAKbDKpMN8OBNRlk0QinptwOFqaxmoHlc+CgPDT7gJD4fO1Csw
         do+czHV0/y2LltnRJP3CTEBagTe3AmbcK8fckm33mlBZGn7ZKGhB+xNYLYju499vCvem
         1G4nJnjxa/EXJ0kltpAw3Il944svZT7CfwDJgHiW4YWzBMonC/kM3zjEsdO2AWx4YqbF
         MeabCqe3iE4NsPp22kMIN9DzYq7NCXsE7e3931UjqgaUUmj/oojtleGqZ5dRDvkGGGMe
         ZBuKowVtkAq4fG6E94Se41mC6gNIL2fqzoLDvvqEJefthJeLpcdvvUbguOpWC1WhDsQ8
         vPoA==
X-Gm-Message-State: APjAAAVL2EoiEIiVovVqBRF3fqr2T1V0hb1TQIFWKRHZd/NAp1RX3a3h
        HQkzGgBX/Gg11WhpJ/6wa/z3sOgE2XSYXTW9+KU=
X-Google-Smtp-Source: APXvYqxxlVGO15l7eYtfNXjfLTjwFKDhTrtm/h/TOVV/jLIopcfB40ClbnrIG3zGec04yiaa6oSt6D9GMyznieRnHDU=
X-Received: by 2002:a02:a915:: with SMTP id n21mr28189604jam.117.1576013271029;
 Tue, 10 Dec 2019 13:27:51 -0800 (PST)
MIME-Version: 1.0
References: <20191210102916.842-1-agruenba@redhat.com> <20191210203252.GA99875@magnolia>
 <CAHpGcMJMgttnXu48wHnP-WqdPkuXBaFd+COKV9XiRP6VrtRUVg@mail.gmail.com> <20191210212552.GC99875@magnolia>
In-Reply-To: <20191210212552.GC99875@magnolia>
From:   =?UTF-8?Q?Andreas_Gr=C3=BCnbacher?= <andreas.gruenbacher@gmail.com>
Date:   Tue, 10 Dec 2019 22:27:40 +0100
Message-ID: <CAHpGcMJxoekJvZqW3=9B7Jfpo43N1XzayY0TQc7eWLjHVwvQXg@mail.gmail.com>
Subject: Re: [PATCH] iomap: Export iomap_page_create and iomap_set_range_uptodate
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Linux FS-devel Mailing List <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        cluster-devel <cluster-devel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Am Di., 10. Dez. 2019 um 22:25 Uhr schrieb Darrick J. Wong
<darrick.wong@oracle.com>:
> On Tue, Dec 10, 2019 at 09:39:31PM +0100, Andreas Gr=C3=BCnbacher wrote:
> > Am Di., 10. Dez. 2019 um 21:33 Uhr schrieb Darrick J. Wong
> > <darrick.wong@oracle.com>:
> > > On Tue, Dec 10, 2019 at 11:29:16AM +0100, Andreas Gruenbacher wrote:
> > > > These two functions are needed by filesystems for converting inline
> > > > ("stuffed") inodes into non-inline inodes.
> > > >
> > > > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> > >
> > > Looks fine to me... this is a 5.6 change, correct?
> >
> > Yes, so there's still plenty of time to get things in place until
> > then. I'd like to hear from Christoph if he has any objections. In any
> > case, this patch isn't going to break anything.
>
> By the way, the other symbols in fs/iomap/ are all EXPORT_SYMBOL_GPL.
> Does gfs2/RH/anyone have a particular requirement for EXPORT_SYMBOL, or
> could we make the new exports _GPL to match the rest?

I don't mind EXPORT_SYMBOL_GPL.

Thanks,
Andreas
