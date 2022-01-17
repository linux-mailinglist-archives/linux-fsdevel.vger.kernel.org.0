Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6295E490067
	for <lists+linux-fsdevel@lfdr.de>; Mon, 17 Jan 2022 03:57:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236889AbiAQCzn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 16 Jan 2022 21:55:43 -0500
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:40301 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232541AbiAQCzm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 16 Jan 2022 21:55:42 -0500
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id C75AE5C0178;
        Sun, 16 Jan 2022 21:55:41 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Sun, 16 Jan 2022 21:55:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        E9QgnAUv2s26J9MTI8ndOrZNGiuEedtyCcEYZbzeGJo=; b=NwRb8bdJdaiTQKGy
        GJ2BrkhunJl1KtrPlditG7Zri29Tr+TNG8U4fXU609URd2NGKJDu35bHrhRBMI0k
        8mD773leNTSuv1LUW+UcQeitZQmqOj0RFUIMNmJRMsSrw/fFiptHcc/MwVrVIdj1
        0TQm9kZLgWY/EnBlSGXS3OZ1xfEbNt9SVLToSjgXNaGbGpIii6RTU4T4iztQvj5O
        UCOiHARXDdcaogcTMNoAcXpw/EWa+IFzZVnykQAw0Tm//JIEbtkxnAJCsQ/DR4mK
        56/LvDklAqfmZmufNTkn8gnA8GPAUNPpHkz7OUEYtkHj93NAtdRenB0pVDom2sye
        ZR+wuQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=E9QgnAUv2s26J9MTI8ndOrZNGiuEedtyCcEYZbzeG
        Jo=; b=YviPgv1/ZewuNWQT2Id+prNM1DYyFI3Xx8mv5y8zuyGIFulN+xV5xg/KC
        tazwKTGtV0Bb5MWYdxOnm/aZt6PGMT5YvNKkzB/9l0GZBVYiclKNqokKlvLCOrgb
        fsXQ1H2mJqwkAP79HLjgie2btWDQoyVacPJAEL16mw/qDHsKu/LL39iq+GqE/xXN
        tmXvS4+k6aNt/IoiOlqVwX9Hh3ZyS+ZgMrR54fl7nD+zb14QnmlFXQDmYdrfxfsN
        Qjsbk9PPOs0WlJ0QxykCQ6IzBxGX3tcF73Svorh7VOL8bzFbN7Bwf7HDJWFGAB59
        QLB1NsqjMsbeiOP1WUDslwpcKKiMw==
X-ME-Sender: <xms:rNrkYYE0HYrvUh-zueIxA3z0Hr19UMvzO9sz_fGsKWuOmh81A3CyuQ>
    <xme:rNrkYRVdfZhKm0D8QXdo92wkJm-1cfpV08RJwFNsayTUgzuK9F00I3FcUBYCNzFHk
    BpbcxTix6Ze>
X-ME-Received: <xmr:rNrkYSLYvYtY3T9HjPL504xEiIKuGnSZNvlkg9oVfEB9JH1Sm5xYdMYFobLoQv43bLSYgCThJXTfdJlA8D3twZmVihOr6-2BilkN0ovlez0N5OYBywMYDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddruddtgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:rNrkYaH-PhDhLPg8DqKK9gORapF0NpMqKWfvc7of-k6eEkRlUc7wcA>
    <xmx:rNrkYeXURhqG7mqbrqYbahDIvQU2CO8bOgeXedvI3LmEu7V0RhvPtA>
    <xmx:rNrkYdP_cC3xu4c2DHBKpNt1Kf_v5c8_8OFQFEMzcc3nOLEQ-zZL9w>
    <xmx:rdrkYQK8tCH2y3tmTRMY0L5SlRhaRM7YwMuO6UVwiFMR32ZsEZNw4A>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 16 Jan 2022 21:55:37 -0500 (EST)
Message-ID: <275358741c4ee64b5e4e008d514876ed4ec1071c.camel@themaw.net>
Subject: Re: [PATCH] vfs: check dentry is still valid in get_link()
From:   Ian Kent <raven@themaw.net>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Brian Foster <bfoster@redhat.com>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        xfs <linux-xfs@vger.kernel.org>
Date:   Mon, 17 Jan 2022 10:55:32 +0800
In-Reply-To: <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
References: <164180589176.86426.501271559065590169.stgit@mickey.themaw.net>
         <YeJr7/E+9stwEb3t@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.4 (3.40.4-2.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, 2022-01-15 at 06:38 +0000, Al Viro wrote:
> On Mon, Jan 10, 2022 at 05:11:31PM +0800, Ian Kent wrote:
> > When following a trailing symlink in rcu-walk mode it's possible
> > for
> > the dentry to become invalid between the last dentry seq lock check
> > and getting the link (eg. an unlink) leading to a backtrace similar
> > to this:
> > 
> > crash> bt
> > PID: 10964  TASK: ffff951c8aa92f80  CPU: 3   COMMAND: "TaniumCX"
> > …
> >  #7 [ffffae44d0a6fbe0] page_fault at ffffffff8d6010fe
> >     [exception RIP: unknown or invalid address]
> >     RIP: 0000000000000000  RSP: ffffae44d0a6fc90  RFLAGS: 00010246
> >     RAX: ffffffff8da3cc80  RBX: ffffae44d0a6fd30  RCX:
> > 0000000000000000
> >     RDX: ffffae44d0a6fd98  RSI: ffff951aa9af3008  RDI:
> > 0000000000000000
> >     RBP: 0000000000000000   R8: ffffae44d0a6fb94   R9:
> > 0000000000000000
> >     R10: ffff951c95d8c318  R11: 0000000000080000  R12:
> > ffffae44d0a6fd98
> >     R13: ffff951aa9af3008  R14: ffff951c8c9eb840  R15:
> > 0000000000000000
> >     ORIG_RAX: ffffffffffffffff  CS: 0010  SS: 0018
> >  #8 [ffffae44d0a6fc90] trailing_symlink at ffffffff8cf24e61
> >  #9 [ffffae44d0a6fcc8] path_lookupat at ffffffff8cf261d1
> > #10 [ffffae44d0a6fd28] filename_lookup at ffffffff8cf2a700
> > #11 [ffffae44d0a6fe40] vfs_statx at ffffffff8cf1dbc4
> > #12 [ffffae44d0a6fe98] __do_sys_newstat at ffffffff8cf1e1f9
> > #13 [ffffae44d0a6ff38] do_syscall_64 at ffffffff8cc0420b
> > 
> > Most of the time this is not a problem because the inode is
> > unchanged
> > while the rcu read lock is held.
> > 
> > But xfs can re-use inodes which can result in the inode -
> > >get_link()
> > method becoming invalid (or NULL).
> 
> Without an RCU delay?  Then we have much worse problems...

Sorry for the delay.

That was a problem that was discussed at length with the original post
of this patch that included a patch for this too (misguided though it
was).

That discussion resulted in Darrick merging the problem xfs inline
symlink handling with the xfs normal symlink handling.

Another problem with these inline syslinks was they would hand a
pointer to internal xfs storage to the VFS. Darrick's change
allocates and copies the link then hands it to the VFS to free
after use. And since there's an allocation in the symlink handler
the rcu-walk case returns -ECHILD (on passed NULL dentry) so the
VFS will call unlazy before that next call which I think is itself
enough to resolve this problem.

The only thing I think might be questionable is the VFS copy of the
inode pointer but I think the inode is rcu freed so it will be
around and the seq count will have changed so I think it should be
ok.

If I'm missing something please say so, ;)

Darrick's patch is (was last I looked) in his xfs-next tree.

Ian


