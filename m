Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9D2421A
	for <lists+linux-fsdevel@lfdr.de>; Mon, 20 May 2019 22:26:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726566AbfETUZz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 20 May 2019 16:25:55 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:55227 "EHLO
        out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725763AbfETUZz (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 20 May 2019 16:25:55 -0400
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 01A7524627;
        Mon, 20 May 2019 16:25:52 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Mon, 20 May 2019 16:25:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rath.org; h=from
        :to:cc:subject:references:date:in-reply-to:message-id
        :mime-version:content-type:content-transfer-encoding; s=fm2; bh=
        2s8insJw7SXiaaoi7n/jvMQaGaOOEQGGn9MA9sTXCzY=; b=nTVN23Gom1plLxpc
        7qd56RBh1d3zg39gxTuhjiar9f2o+0UBPe9IZOUFZwuGyCZiz0l6OEjzfyMegQRB
        kpA61V1jEC4TJQ6w/csBHq88m8rH6mzeHd9p3ib/VOh/wcURQ8E4JWe1z+rxoDJS
        riIbZmeDgi+SR5rL4zO6JYWtHsTKgQ1fgrGPdVUDNFDlAUnBW6lV7On+2rf54yIL
        98ercTcOkQk43giawKpcbz/pB31VOiezM2LsBxthPivE5C81+raWg2rB5OuMjRhP
        Bm55qTL1E09AlbLJFdhjjdOC5Zsqy2sf8CEohNnAKruGmn+Ryx6fjXLilfgFcdkx
        FyBTrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=2s8insJw7SXiaaoi7n/jvMQaGaOOEQGGn9MA9sTXC
        zY=; b=piEfKWYZVjjloiN91Gr8WKPqaq5AB5JOvYVIJFVUyuzruj6zx1inX4Ag2
        fHo2iGeXPT2KD4m5QyY9l3y/uzN6Fyc27m+oNff2mjLkQeRPRFkGgd1u2D2MKzyH
        zYPCtPggTO9+u2y2vAfbrikr2neLOK1hRytDAYPuQ4igrL2vHjYpXMVa44QF/+P8
        vi3bP/E0bYzo7EBvOpFJC+A0RMa1rxC91IOX9oU4w4fo/FPaHBzvgcB3CUZdoe0N
        dz84LaB6Wto9snsa10XIiO4I7T5RPSg7eMU3Ybmd6ND8Gx1lK4Dcwbrk+6c6GO/q
        FqfYzEaykUJxI1j2CQEHa+VHKwuIg==
X-ME-Sender: <xms:Tg3jXPSPMV2Zifntr-gXS1Wod57QlBL87TAYu2mgEZ5BEHPu6ehCIQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedgudehvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvffufhffjgfkfgggtgfgsehtqhdttddtreejnecuhfhrohhmpefpihhk
    ohhlrghushcutfgrthhhuceopfhikhholhgruhhssehrrghthhdrohhrgheqnecuffhomh
    grihhnpehgihhthhhusgdrtghomhenucfkphepudekhedrfedrleegrdduleegnecurfgr
    rhgrmhepmhgrihhlfhhrohhmpefpihhkohhlrghushesrhgrthhhrdhorhhgnecuvehluh
    hsthgvrhfuihiivgepud
X-ME-Proxy: <xmx:Tw3jXHnofyaTWPXOM2EmL4-bZccirz8aglg4Gej6SaqXedM5iw-pJA>
    <xmx:Tw3jXNxHbGqRnanASHfrQtGZr1_gLfZC5xRf-eHKyikxX1k4XJuDvg>
    <xmx:Tw3jXB0MfLetAtMWCuMMAzXvfg_2Dtfd153_MlpY0_ka-S1Cd8Pu1g>
    <xmx:Tw3jXMtNSUyYLa786PlpyrIhNLWWtCZBzCQrj1CGUaRQmT-zupvToQ>
Received: from ebox.rath.org (ebox.rath.org [185.3.94.194])
        by mail.messagingengine.com (Postfix) with ESMTPA id AA09B80061;
        Mon, 20 May 2019 16:25:50 -0400 (EDT)
Received: from vostro.rath.org (vostro [192.168.12.4])
        by ebox.rath.org (Postfix) with ESMTPS id CB17360;
        Mon, 20 May 2019 20:25:49 +0000 (UTC)
Received: by vostro.rath.org (Postfix, from userid 1000)
        id 9E565E00E1; Mon, 20 May 2019 21:25:49 +0100 (BST)
From:   Nikolaus Rath <Nikolaus@rath.org>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     Vivek Goyal <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org, stefanha@redhat.com,
        dgilbert@redhat.com, swhiteho@redhat.com
Subject: Re: [PATCH v2 02/30] fuse: Clear setuid bit even in cache=never path
References: <20190515192715.18000-1-vgoyal@redhat.com>
        <20190515192715.18000-3-vgoyal@redhat.com>
        <20190520144137.GA24093@localhost.localdomain>
        <20190520144437.GB24093@localhost.localdomain>
Mail-Copies-To: never
Mail-Followup-To: Miklos Szeredi <miklos@szeredi.hu>, Vivek Goyal
        <vgoyal@redhat.com>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        linux-nvdimm@lists.01.org, stefanha@redhat.com, dgilbert@redhat.com,
        swhiteho@redhat.com
Date:   Mon, 20 May 2019 21:25:49 +0100
In-Reply-To: <20190520144437.GB24093@localhost.localdomain> (Miklos Szeredi's
        message of "Mon, 20 May 2019 16:44:37 +0200")
Message-ID: <87k1ekub3m.fsf@vostro.rath.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On May 20 2019, Miklos Szeredi <miklos@szeredi.hu> wrote:
> On Mon, May 20, 2019 at 04:41:37PM +0200, Miklos Szeredi wrote:
>> On Wed, May 15, 2019 at 03:26:47PM -0400, Vivek Goyal wrote:
>> > If fuse daemon is started with cache=3Dnever, fuse falls back to direc=
t IO.
>> > In that write path we don't call file_remove_privs() and that means se=
tuid
>> > bit is not cleared if unpriviliged user writes to a file with setuid b=
it set.
>> >=20
>> > pjdfstest chmod test 12.t tests this and fails.
>>=20
>> I think better sulution is to tell the server if the suid bit needs to be
>> removed, so it can do so in a race free way.
>>=20
>> Here's the kernel patch, and I'll reply with the libfuse patch.
>
> Here are the patches for libfuse and passthrough_ll.

Could you also submit them as pull requests at https://github.com/libfuse/l=
ibfuse/pulls?

Best,
-Nikolaus

--=20
GPG Fingerprint: ED31 791B 2C5C 1613 AF38 8B8A D113 FCAC 3C4E 599F

             =C2=BBTime flies like an arrow, fruit flies like a Banana.=C2=
=AB
