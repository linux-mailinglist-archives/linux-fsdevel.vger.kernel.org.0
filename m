Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01292AF2F2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Sep 2019 00:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725965AbfIJWdc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Sep 2019 18:33:32 -0400
Received: from out2-smtp.messagingengine.com ([66.111.4.26]:33991 "EHLO
        out2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725916AbfIJWdb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Sep 2019 18:33:31 -0400
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 88F7921BF9;
        Tue, 10 Sep 2019 18:33:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Tue, 10 Sep 2019 18:33:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:mime-version:content-type; s=
        fm2; bh=XDXPs1E5Y1lR6vwfP96YiekAS/sJoRz/+A4CAEVd8tc=; b=U8iZasok
        ngvQDLcQdYwAcXNqcVQQRfq78Q7fVtBhtMwG84NX9yCk6DLdtG3AvQik2tTXilDe
        0mfWGXSnTT3/GPyAe3Bltf4OGAW2OVpGypiEsb/Z+TFp4lCbSzT8I/to/nVyZXLc
        S/mNyd+YIavlPvKoZmBzUpeEmfv3CzqaZ4JNwPUQeijw00+VS2mXHHbzO77ucBtA
        6k5zYetYzX1Df3SBsV7yBjH6h51zILvCFyh2Xa0hMLYbbXjjXWOI3/OrIkDpGdK4
        gu5+ArILNTfKTZZq6Q6kraNs3UxcuG+QjjNukzZLtfl/QPtgLHg1U6yvcf6XFFjX
        3ElwBwsUoKvWug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm3; bh=XDXPs1E5Y1lR6vwfP96YiekAS/sJo
        Rz/+A4CAEVd8tc=; b=qJ0uMQmFOicFBryAnVHZtUdpFRsgWNLIM78ndidOOhTC7
        YM0i83GExNMRBA5qzIEcztrbR/vns0HWGEumzBHjipemWX1Q2vzrPAcozM5fb9iq
        X38URdo9liAUEO6OVfo9vOepm5iy9Rvya+ZvRQpB6vuujWS2fn4wun7fAuh0mMtB
        czmuGOoHYDOBsvF+c3aQso4KS0yEgTvTse3xLTBdU4/22oDWd/MwhDz0DD2LxblU
        iMIvP0+vnylHpgR3p1nqJrwrKbJlqZahxJvftAAEP09a+dl9abSC8tcHDkLFYiUe
        Khb5n21zmHwjkPD75u/u5aNG1z1tnHh3iM0S6ys7Q==
X-ME-Sender: <xms:uCR4XSMoULOC12ZdW7SvvsiGvIiD6_phbOXFZyL-yPwV4HWQwCOzvw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedufedrtddugdduudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvuffkgggtugesthdtredttddtvdenucfhrhhomheptehnughrvghsucfh
    rhgvuhhnugcuoegrnhgurhgvshesrghnrghrrgiivghlrdguvgeqnecuffhomhgrihhnpe
    hkvghrnhgvlhdrohhrghenucfkphepudegkedrieelrdekhedrfeeknecurfgrrhgrmhep
    mhgrihhlfhhrohhmpegrnhgurhgvshesrghnrghrrgiivghlrdguvgenucevlhhushhtvg
    hrufhiiigvpedt
X-ME-Proxy: <xmx:uCR4XUduNh4hIjZokky8riyavceFf54K4gYjaIZ5iURmDwr_uAHlCQ>
    <xmx:uCR4XRxlxsW9_fRVTJ_1HnVVXT_w4YXoQaodOj7hu2_ax31-t2RKsQ>
    <xmx:uCR4XVjRGsAbf8FgqAkz6v7DJQfC34rpjR9nLCc_-CODn6VsVjsh7Q>
    <xmx:uiR4XTs59A1P85PunGDzbB10-EvrVQAihXlNAkd3ZD7FE3kP8frYGA>
Received: from intern.anarazel.de (unknown [148.69.85.38])
        by mail.messagingengine.com (Postfix) with ESMTPA id 48EEF80059;
        Tue, 10 Sep 2019 18:33:28 -0400 (EDT)
Date:   Tue, 10 Sep 2019 15:33:27 -0700
From:   Andres Freund <andres@anarazel.de>
To:     Goldwyn Rodrigues <rgoldwyn@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, jack@suse.com, hch@infradead.org
Subject: Odd locking pattern introduced as part of "nowait aio support"
Message-ID: <20190910223327.mnegfoggopwqqy33@alap3.anarazel.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

Especially with buffered io it's fairly easy to hit contention on the
inode lock, during writes. With something like io_uring, it's even
easier, because it currently (but see [1]) farms out buffered writes to
workers, which then can easily contend on the inode lock, even if only
one process submits writes.  But I've seen it in plenty other cases too.

Looking at the code I noticed that several parts of the "nowait aio
support" (cf 728fbc0e10b7f3) series introduced code like:

static ssize_t
ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
{
...
	if (!inode_trylock(inode)) {
		if (iocb->ki_flags & IOCB_NOWAIT)
			return -EAGAIN;
		inode_lock(inode);
	}

isn't trylocking and then locking in a blocking fashion an inefficient
pattern? I.e. I think this should be

	if (iocb->ki_flags & IOCB_NOWAIT) {
		if (!inode_trylock(inode))
			return -EAGAIN;
	}
        else
        	inode_lock(inode);

Obviously this isn't going to improve scalability to a very significant
degree. But not unnecessarily doing two atomic ops on a contended lock
can't hurt scalability either. Also, the current code just seems
confusing.

Am I missing something?

Greetings,

Andres Freund

[1] https://lore.kernel.org/linux-block/20190910164245.14625-1-axboe@kernel.dk/
