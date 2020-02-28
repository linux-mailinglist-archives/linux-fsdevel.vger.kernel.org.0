Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 77F1D172CD1
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Feb 2020 01:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730050AbgB1ANA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 19:13:00 -0500
Received: from new4-smtp.messagingengine.com ([66.111.4.230]:53689 "EHLO
        new4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730012AbgB1ANA (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 19:13:00 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id A495D5D51;
        Thu, 27 Feb 2020 19:12:58 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 19:12:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        w8Q1TP8cNfFZvTOV/us6+HG/JI4ZnetedhTQJKrLS0Q=; b=atFtFNYTdozH94PX
        Sn5x1jYqyJjFRHQe8WiRHd6AtqdDoijvymz+Ecl6CbG77NcebilOvx7uSvsI0OhM
        IJsC2tw42dCIeIEm2tQuu8G9FvDWKY5A+PJWtJZoHyE/7hu0vmqTxGga4FyRWAeU
        e9LlKT7GMMzoA0CgpRVtX23EUe+LtVwjPv0AKpS98AgjJuJO4cZ2i8WHHpRQtIpy
        8Gu6Q6gLRiuKgSyApdlA80QpE2OzAW6NH0XQrtgYsCHhEPAuyhOTtlLIjvmUNlUn
        Zhq6ZRYXn5n2nI7p3Bcxesun4O2ZObS6WM9Mzqk19FGsvWJj6eNoP+Iq3n8mjpHR
        93iCHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=w8Q1TP8cNfFZvTOV/us6+HG/JI4ZnetedhTQJKrLS
        0Q=; b=NThbApITPxaHuh3l01v1Q5rfeThSa7VO3ftgPi1Csm1XbGpzAlIN9Bn/O
        v4EQmRKmtzbogPCMNau+LWl+9A08DHYghPEXqFqX5169iV/7MA1t1Hx/sjx4IAJx
        whW+RXTrmdH7Sw6FAvGBS05JXsOHmFwOg4SDfvNKq0+HKLASiXdes5PkoAN3vQ1D
        qhkQFMm1koR3p6v8kIXLOINIT1j5GUlm3cLZMUCS4RZbi3Cjo9zKpGtRQeqKecsP
        nf2w2rFm0ljV83iFuUWdNNIFEpI2kG+rB3w1560ceBziaoldsb2Ign74FNj3fPrk
        PjdskSQXyaMVpYz38Vhy9HzvRk0eQ==
X-ME-Sender: <xms:CVtYXhhMibnYZG3JOibjFolgMPJ-s2Hix9OENXTo2cAcF1sNFqR6Eg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleejgddvtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:CVtYXqDmhZIR2cCU4mRDtITaOpc7gbH103p7U59DjL-nq67UqokIVQ>
    <xmx:CVtYXhsnZ9-UXyTiZL19e36hRC-FMEV-KsIabzVF7HClrYgYYanJwA>
    <xmx:CVtYXmI29ddMgqlUNuQPhd_aXZZnfgQACzMCoWvi5gbHDEIUiUpv8w>
    <xmx:CltYXnPbCfZqJYAgqZI_jNPmlCmK-quLx8hb4LThTNri3Qq44YFuuQ>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1BDBA3280059;
        Thu, 27 Feb 2020 19:12:51 -0500 (EST)
Message-ID: <ee9da02d77121ecbbdee805e0d2e0aaabdc52ed4.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Miklos Szeredi <mszeredi@redhat.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        David Howells <dhowells@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>, Karel Zak <kzak@redhat.com>,
        Lennart Poettering <lennart@poettering.net>,
        Zbigniew =?UTF-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>,
        util-linux@vger.kernel.org
Date:   Fri, 28 Feb 2020 08:12:48 +0800
In-Reply-To: <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>
         <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>
         <1582556135.3384.4.camel@HansenPartnership.com>
         <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>
         <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>
         <1582644535.3361.8.camel@HansenPartnership.com>
         <CAOssrKfaxnHswrKejedFzmYTbYivJ++cPes4c91+BJDfgH4xJA@mail.gmail.com>
         <1c8db4e2b707f958316941d8edd2073ee7e7b22c.camel@themaw.net>
         <CAJfpegtRoXnPm5_sMYPL2L6FCZU52Tn8wk7NcW-dm4_2x=dD3Q@mail.gmail.com>
         <3e656465c427487e4ea14151b77d391d52cd6bad.camel@themaw.net>
         <CAJfpegu5xLcR=QbAOnUrL49QTem6X6ok7nPU+kLFnNHdPXSh1A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 2020-02-27 at 14:45 +0100, Miklos Szeredi wrote:
> On Thu, Feb 27, 2020 at 12:34 PM Ian Kent <raven@themaw.net> wrote:
> > On Thu, 2020-02-27 at 10:36 +0100, Miklos Szeredi wrote:
> > > On Thu, Feb 27, 2020 at 6:06 AM Ian Kent <raven@themaw.net>
> > > wrote:
> > > 
> > > > At the least the question of "do we need a highly efficient way
> > > > to query the superblock parameters all at once" needs to be
> > > > extended to include mount table enumeration as well as getting
> > > > the info.
> > > > 
> > > > But this is just me thinking about mount table handling and the
> > > > quite significant problem we now have with user space scanning
> > > > the proc mount tables to get this information.
> > > 
> > > Right.
> > > 
> > > So the problem is that currently autofs needs to rescan the proc
> > > mount
> > > table on every change.   The solution to that is to
> > 
> > Actually no, that's not quite the problem I see.
> > 
> > autofs handles large mount tables fairly well (necessarily) and
> > in time I plan to remove the need to read the proc tables at all
> > (that's proven very difficult but I'll get back to that).
> > 
> > This has to be done to resolve the age old problem of autofs not
> > being able to handle large direct mount maps. But, because of
> > the large number of mounts associated with large direct mount
> > maps, other system processes are badly affected too.
> > 
> > So the problem I want to see fixed is the effect of very large
> > mount tables on other user space applications, particularly the
> > effect when a large number of mounts or umounts are performed.
> > 
> > Clearly large mount tables not only result from autofs and the
> > problems caused by them are slightly different to the mount and
> > umount problem I describe. But they are a problem nevertheless
> > in the sense that frequent notifications that lead to reading
> > a large proc mount table has significant overhead that can't be
> > avoided because the table may have changed since the last time
> > it was read.
> > 
> > It's easy to cause several system processes to peg a fair number
> > of CPU's when a large number of mounts/umounts are being performed,
> > namely systemd, udisks2 and a some others. Also I've seen couple
> > of application processes badly affected purely by the presence of
> > a large number of mounts in the proc tables, that's not quite so
> > bad though.
> > 
> > >  - add a notification mechanism   - lookup a mount based on path
> > >  - and a way to selectively query mount/superblock information
> > based on path ...
> > > right?
> > > 
> > > For the notification we have uevents in sysfs, which also
> > > supplies
> > > the
> > > changed parameters.  Taking aside namespace issues and addressing
> > > mounts would this work for autofs?
> > 
> > The parameters supplied by the notification mechanism are
> > important.
> > 
> > The place this is needed will be libmount since it catches a broad
> > number of user space applications, including those I mentioned
> > above
> > (well at least systemd, I think also udisks2, very probably
> > others).
> > 
> > So that means mount table info. needs to be maintained, whether
> > that
> > can be achieved using sysfs I don't know. Creating and maintaining
> > the sysfs tree would be a big challenge I think.
> > 
> > But before trying to work out how to use a notification mechanism
> > just having a way to get the info provided by the proc tables using
> > a path alone should give initial immediate improvement in libmount.
> 
> Adding Karel, Lennart, Zbigniew and util-linux@vger...
> 
> At a quick glance at libmount and systemd code, it appears that just
> switching out the implementation in libmount will not be enough:
> systemd is calling functions like mnt_table_parse_*() when it
> receives
> a notification that the mount table changed.

Maybe I wasn't clear, my bad, sorry about that.

There's no question that change notification handling is needed too.

I'm claiming that an initial change to use something that can get
the mount information without using the proc tables alone will give
an "initial immediate improvement".

The work needed to implement mount table change notification
handling will take much more time and exactly what changes that
will bring is not clear yet and I do plan to work on that too,
together with Karel.

Ian

