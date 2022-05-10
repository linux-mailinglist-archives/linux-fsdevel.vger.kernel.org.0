Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FEBB520C2D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 May 2022 05:38:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235551AbiEJDl6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 9 May 2022 23:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235709AbiEJDkh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 9 May 2022 23:40:37 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2FFE2016C7;
        Mon,  9 May 2022 20:34:54 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 5917D3200976;
        Mon,  9 May 2022 23:34:52 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Mon, 09 May 2022 23:34:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1652153691; x=
        1652240091; bh=Wf4+GirlHr8odLVWkz1C4aI3GGmAypu/lVakO44m7ok=; b=K
        d6w/Ky9g1ONou+rs8boNzVnFBHtYNFA1WbynVGD24JKcYKLWqLU6/jX/6JNP7rak
        PHLtOTz43QnIoy5mF8GRfgKHt+ESvwLJW13bIwbI7ikNVBPAlj4zg6JAzwUnNFPN
        jGn5u15qQuWJM4OPcfg2QGSuBdFKbuBk4yAelyVa6gcBpJM3twzbBseiBTAy4Dcs
        /kfW5db8YGVUfH/Li6584SZtEKKusdFuj0ZHDQTyXmOLcxj3w8qshaXGb9E9LdrC
        RCqb2sorM7VVhmpc4aSR1kGSolhW1dU3MoAm4IL5wnrVXTA63daH729Y3LfVseIo
        FRbmIkOl+MldRigeH5ybQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1652153691; x=1652240091; bh=Wf4+GirlHr8od
        LVWkz1C4aI3GGmAypu/lVakO44m7ok=; b=z4cDqglDdqc/osHgQ2M74yL21q/ld
        on9l+ORXm2aR824S7xOaod5uSPAVxA5Aejyxb4Sf2cvRQuzghCC/TdyWxCFeeewX
        /A0f22gQbVUlyu2/fEFWAGb6aXHaXu9M+uPFDkXsn4UBgFWNjYpuaeYjuQUO/hpx
        HR217Tpo2MtH4wzCJMYaPWK5Ku8OtXiYDmq/nW7f5UMwFYwxZ9y4X+a9kxEczDHi
        KqWv5mS8iuL9A6ieNtYMLCqQYR9UVkMM0mg5DMWL/ocJ11sni2H/RUXdVBJCUtD6
        J7UZXsSTYbm7oLgZlQIVY39m0lyXOScdGjABK0D2Nk7rEpblfpf3/BI3w==
X-ME-Sender: <xms:W915YiXgOfRlxtp1jBt-bKBEGGNlhEe7beM7JojMZmEJ71Rg1ns1BA>
    <xme:W915YunJF_w0NYU0VqbbHadSvl-Pk4zNQ-Q-7xzjOGHxgwGiFfG8rzQcFSTWysIOY
    QXxh9umjVir>
X-ME-Received: <xmr:W915YmamtN3erdOvVnkmGCn6Gy-cy5252odPqGY0x5VVJexN_Z-rVOmTc0xWbl2Xxjc6V3bel9I2NiQQ69b1On3VHK1QzITp51yO_Tx4S73jrCvJcxSe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgdejvdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfevffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucggtffrrghtthgvrhhnpe
    dviefhveeifeevfedutdffkeeigedukeehvefgteeileeitdehgffggfffveejteenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehrrghvvghnse
    hthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:W915YpXpVdJCHMQJ77WMVun5-1I0IPPIXrZGxhduGFwCax5-nPHDhg>
    <xmx:W915YskWEIYjktriuuuklFjPrdw8zSMuiO1kDkdsEpMZJkEmRy19Hg>
    <xmx:W915YuflhFnjCnToJ7cyd3nhc0gd5WlgLUJTYfKotRzK0xKk2QZYAw>
    <xmx:W915Ygl0Jc82FSJuDZwWuy-mCkfNI7bvcGv92xu6y1wanURsXE5jrA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 May 2022 23:34:45 -0400 (EDT)
Message-ID: <4a712f3618835ac9ba0db8d26630f8edf209a193.camel@themaw.net>
Subject: Re: [RFC PATCH] getting misc stats/attributes via xattr API
From:   Ian Kent <raven@themaw.net>
To:     Vivek Goyal <vgoyal@redhat.com>,
        Christian Brauner <brauner@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Theodore Ts'o <tytso@mit.edu>, Karel Zak <kzak@redhat.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-man <linux-man@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        James Bottomley <James.Bottomley@hansenpartnership.com>
Date:   Tue, 10 May 2022 11:34:39 +0800
In-Reply-To: <YnmK0VJhQ4sf8AMI@redhat.com>
References: <YnEeuw6fd1A8usjj@miu.piliscsaba.redhat.com>
         <20220509124815.vb7d2xj5idhb2wq6@wittgenstein>
         <CAOQ4uxgCSJ2rpJkPy1FkP__7zhaVXO5dnZQXSzvk=fReaZH7Aw@mail.gmail.com>
         <20220509150856.cfsxn5t2tvev2njx@wittgenstein>
         <YnmK0VJhQ4sf8AMI@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2022-05-09 at 17:42 -0400, Vivek Goyal wrote:
> On Mon, May 09, 2022 at 05:08:56PM +0200, Christian Brauner wrote:
> 
> [..]
> > Having "xattr" in the system call name is just confusing. These are
> > fundamentally not "real" xattrs and we shouldn't mix semantics.
> > There
> > should be a clear distinction between traditional xattrs and this
> > vfs
> > and potentially fs information providing interface.
> > 
> > Just thinking about what the manpage would look like. We would need
> > to
> > add a paragraph to xattr(7) explaining that in addition to the
> > system.*,
> > security.*, user.* and other namespaces we now also have a set of
> > namespaces that function as ways to get information about mounts or
> > other things instead of information attached to specific inodes.
> > 
> > That's super random imho. If I were to be presented with this
> > manpage
> > I'd wonder if someone was too lazy to add a proper new system call
> > with
> > it's own semantics for this and just stuffed it into an existing
> > API
> > because it provided matching system call arguments. We can add a
> > new
> > system call. It's not that we're running out of them.
> 
> FWIW, I also felt that using xattr API to get some sort of mount info
> felt
> very non-intutive.

Yeah, people looking for this function simply wouldn't know to
look here ...

Ian
