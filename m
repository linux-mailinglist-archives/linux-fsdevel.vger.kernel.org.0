Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EB5B417897E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  4 Mar 2020 05:20:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgCDEUj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 23:20:39 -0500
Received: from new1-smtp.messagingengine.com ([66.111.4.221]:59277 "EHLO
        new1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726094AbgCDEUj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 23:20:39 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id D813D7521;
        Tue,  3 Mar 2020 23:20:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Mar 2020 23:20:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        B+ceXAX3iLBjbuYlJNN1SpAuPBs9+K7HV7ziovlTAfU=; b=k+jgLOkylqvDecL5
        1pzrpgVA9uy+I9PbmsMSZyMNQxgYxX9FHZWv1bWN+v3O4IK48d3fJQzsCeFModuZ
        /L4Nsjq3lXweCuJdZIM0RVplthaOgP5WCg3qb5hwYaeJaLs87fH8RG1g1b4bsvxJ
        PZVXvUCvZFiHFpQs+lF7YOT7bq1qBQurhk7Ga0yIY8Y1X6AnQosOjP+sF8njsfxs
        GJ+GB1szJjTtcoDoGWdXzXS5aulm/0z58Wv9hZ5TLcMRwi9EwYlh4lWwQPWNgG/K
        XM6kQE4fay9RlHPFRvgBGm1kyAnxJJFbsIpxJY9uByKvuDMdj8Uk0XQcbD5CftFB
        E/MqSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=B+ceXAX3iLBjbuYlJNN1SpAuPBs9+K7HV7ziovlTA
        fU=; b=MJiQ7iJ3sGbGMtOEFJ1/n3YsQIna4G3uRcL9WeTo0OHb76cvStgtHG0x6
        AOXR413ZFIahkWW76on7CrSvN/R4e1Z0HOyTJdzzeYexb9RJ/yFd1qPTdlMrKDGM
        WSicCcxj3PlyBCV0HlqxAA6aCV6jj3jq9AJKVUYl1Pn4Oi6vUWDm6bqayCAg3iVh
        trjsDytouyWUjFtSlVyqvd5bvWJONeK3c8X0QjhLpDayWZWGoEdp17sVIY7zntKd
        88hBcLZMT91j4h/W8DUCG9u2SikjqkX7wLEZx/fm1Topa9lbqp7yMi3oIa6JDFIA
        gUmZRhmXSxFw2nVcOkH5b55h3evQA==
X-ME-Sender: <xms:lCxfXtyH-OVcKn_rySrMCzTnzjb6i8Ebeljjmh5Hp5HuX2qGNzAoAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtjedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucfkphepuddukedrvddtke
    drudektddrvddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:lCxfXs2_z9l3DG06gppBLwWdLdz5hFmUabZhX5-C2788XR1UBHFxYg>
    <xmx:lCxfXrprPt16r_AX3sQ5hwX7TKsayitowomHe7adP67kJlM1VRspqQ>
    <xmx:lCxfXiB6tSRR5rsHvnRzP99mX6GNe2AoowbIRd-73XdTFKxaMOPzQQ>
    <xmx:lSxfXjZG69kFtpb7OWD62JfAbJ_G2IQ1uCX5sDfftl_CE5UTqrSjv-Ml3x0>
Received: from mickey.themaw.net (unknown [118.208.180.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0AAB6328005D;
        Tue,  3 Mar 2020 23:20:30 -0500 (EST)
Message-ID: <2fcc08be4dc9735e145f2a450d1b6f0896a05d61.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Karel Zak <kzak@redhat.com>, David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Date:   Wed, 04 Mar 2020 12:20:27 +0800
In-Reply-To: <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
References: <107666.1582907766@warthog.procyon.org.uk>
         <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>
         <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>
         <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>
         <1509948.1583226773@warthog.procyon.org.uk>
         <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>
         <20200303113814.rsqhljkch6tgorpu@ws.net.home>
         <20200303130347.GA2302029@kroah.com> <20200303131434.GA2373427@kroah.com>
         <CAJfpegt0aQVvoDeBXOu2xZh+atZQ+q5uQ_JRxe46E8cZ7sHRwg@mail.gmail.com>
         <20200303134316.GA2509660@kroah.com>
         <CAJfpegtFyZqSRzo3uuXp1S2_jJJ29DL=xAwKjpEGvyG7=AzabA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-03-03 at 15:10 +0100, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 2:43 PM Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
> > On Tue, Mar 03, 2020 at 02:34:42PM +0100, Miklos Szeredi wrote:
> > > If buffer is too small to fit the whole file, return error.
> > 
> > Why?  What's wrong with just returning the bytes asked for?  If
> > someone
> > only wants 5 bytes from the front of a file, it should be fine to
> > give
> > that to them, right?
> 
> I think we need to signal in some way to the caller that the result
> was truncated (see readlink(2), getxattr(2), getcwd(2)), otherwise
> the
> caller might be surprised.
> 
> > > Verify that the number of bytes read matches the file size,
> > > otherwise
> > > return error (may need to loop?).
> > 
> > No, we can't "match file size" as sysfs files do not really have a
> > sane
> > "size".  So I don't want to loop at all here, one-shot, that's all
> > you
> > get :)
> 
> Hmm.  I understand the no-size thing.  But looping until EOF (i.e.
> until read return zero) might be a good idea regardless, because
> short
> reads are allowed.

Surely a short read equates to an error.

That has to be the definition of readfile() because you can do the
looping thing with read(2) and get the entire file anyway.

If you think about it don't you arrive at the conclusion this can
be done with read(2) alone anyway because you have to loop to get
the entire file, otherwise there's no point to the syscall!

Ian

