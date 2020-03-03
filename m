Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 863BD177516
	for <lists+linux-fsdevel@lfdr.de>; Tue,  3 Mar 2020 12:10:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728794AbgCCLJn (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 3 Mar 2020 06:09:43 -0500
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:35363 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727972AbgCCLJn (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 3 Mar 2020 06:09:43 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 792F0917;
        Tue,  3 Mar 2020 06:09:41 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 03 Mar 2020 06:09:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        5TX+uCNcQY2aavXB/mLwr/V1IcyxUJrKJUSz6Rc4B54=; b=cPtWI4rAcgAEtVhz
        YiA2svSMnAuv80t8d6DJfDrV4htEnAOzAzMcOvQgrMkNB3Q+NnGXh8y+4pgcMiu+
        O8a7uDLDcsaY43Jkf/10qJlwmpkFp8kbZMb2XyihW4qF9Fq1Evbk608wDcp42Bw5
        tE5xWqsU90mgPaLkntu+WJqXN0CLoxRu5XJvnedDU4nWGj/LA13xcVO11keLg7Z6
        1LWcThfjiSh/YHpJnZKBsftxkU9whki0egMWJBWPq5/ycY59KUBLBiAmD1RJkr74
        EDrTD+FEsi0+0ztqHb3CjKFhRuDPXpDhdMHinLC3g06SeXKK5iwzXyAJChQaOZIn
        9pHNaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=5TX+uCNcQY2aavXB/mLwr/V1IcyxUJrKJUSz6Rc4B
        54=; b=Qhb/sMzXoT71dHreZn15FCny+qul8QXE6Dq+hmbPwSMOeQIf83PkDPpeX
        KNmt0ZuQ428jqjAc4htqtnOLh/W7v2sMZTuEVHOZWdMSjTmsMLeAm8jaIoRtVo6J
        NFt1QMDJbvIo+Zkk4+LRCgQ7RL5ih61CO+kHK/1xmCSpZB1F4uxCgRcuIqwy9yeL
        5E8yQ0+qEJ/ax7f9K2e9lFwZ73IswDF05EhAOovsnyZd3uMaedVzKdryQJYPsudb
        rmNA7MlZLoWO1yx+i23v606qpptdOxEwdvQHMTyYIhQi7DkWI0SKZcWUYvOAzqN5
        rNnGwQJMR0+OZSDV3fB9l5eY7POOw==
X-ME-Sender: <xms:9DpeXvy5Ez0mQEBDUYfUXoPto1afIT6zXjTQX5c9zpyO3_pcERpzsw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedruddtiedgvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkffuhffvffgjfhgtfggggfesthejredttderjeenucfhrhhomhepkfgrnhcu
    mfgvnhhtuceorhgrvhgvnhesthhhvghmrgifrdhnvghtqeenucffohhmrghinhepjhgrnh
    gvshhtrhgvvghtrdgtohhmnecukfhppeduudekrddvtdekrddukedtrddvtddvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhgrvhgvnhesth
    hhvghmrgifrdhnvght
X-ME-Proxy: <xmx:9DpeXuGzChvI_2mxEnOFMOWIucZ7QYRl68_DAgdP6YoJcdB68IEegg>
    <xmx:9DpeXtkvAsik0zrhT3akz8u7b7WZRU3clQDRXHp5T5E12RygzwvUVw>
    <xmx:9DpeXiTZ43DPSUhn4vfmx61ucq14uEdFPQcF1QvkfvJzQOJh5Q_R0A>
    <xmx:9TpeXkXtkDC3tkVL01bw-0UGI9GC3bVbh8YDgNRu7U_JjoJJhhIk-oA7p1P23w8y>
Received: from mickey.themaw.net (unknown [118.208.180.202])
        by mail.messagingengine.com (Postfix) with ESMTPA id 863E53280062;
        Tue,  3 Mar 2020 06:09:35 -0500 (EST)
Message-ID: <7e8e4b1b1e282a11757252dbe02445171f6f9675.camel@themaw.net>
Subject: Re: [PATCH 00/17] VFS: Filesystem information and notifications
 [ver #17]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        Steven Whitehouse <swhiteho@redhat.com>
Cc:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <christian@brauner.io>,
        Jann Horn <jannh@google.com>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date:   Tue, 03 Mar 2020 19:09:31 +0800
In-Reply-To: <CAJfpegsW5S3dRhhfGyAnhLEDjBxMQRBda5fsnXQ+=S=4YR0MCA@mail.gmail.com>
References: <158230810644.2185128.16726948836367716086.stgit@warthog.procyon.org.uk>
         <1582316494.3376.45.camel@HansenPartnership.com>       
 <CAOssrKehjnTwbc6A1VagM5hG_32hy3mXZenx_PdGgcUGxYOaLQ@mail.gmail.com>   
 <1582556135.3384.4.camel@HansenPartnership.com>        
 <CAJfpegsk6BsVhUgHNwJgZrqcNP66wS0fhCXo_2sLt__goYGPWg@mail.gmail.com>   
 <a657a80e-8913-d1f3-0ffe-d582f5cb9aa2@redhat.com>      
 <1582644535.3361.8.camel@HansenPartnership.com>        
 <20200228155244.k4h4hz3dqhl7q7ks@wittgenstein> 
 <107666.1582907766@warthog.procyon.org.uk>     
 <CAJfpegu0qHBZ7iK=R4ajmmHC4g=Yz56otpKMy5w-y0UxJ1zO+Q@mail.gmail.com>   
 <0403cda7345e34c800eec8e2870a1917a8c07e5c.camel@themaw.net>    
 <CAJfpegtu6VqhPdcudu79TX3e=_NZaJ+Md3harBGV7Bg_-+fR8Q@mail.gmail.com>   
 <1509948.1583226773@warthog.procyon.org.uk>    
 <CAJfpegtOwyaWpNfjomRVOt8NKqT94O5n4-LOHTR7YZT9fadVHA@mail.gmail.com>   
 <CAJfpegtemv64mpmTRT6ViHmsWq4nNE4KQvuHkNCYozRU7dQd8Q@mail.gmail.com>   
 <06d2dbf0-4580-3812-bb14-34c6aa615747@redhat.com>      
 <CAJfpegsW5S3dRhhfGyAnhLEDjBxMQRBda5fsnXQ+=S=4YR0MCA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-03-03 at 11:32 +0100, Miklos Szeredi wrote:
> On Tue, Mar 3, 2020 at 11:22 AM Steven Whitehouse <
> swhiteho@redhat.com> wrote:
> > Hi,
> > 
> > On 03/03/2020 09:48, Miklos Szeredi wrote:
> > > On Tue, Mar 3, 2020 at 10:26 AM Miklos Szeredi <miklos@szeredi.hu
> > > > wrote:
> > > > On Tue, Mar 3, 2020 at 10:13 AM David Howells <
> > > > dhowells@redhat.com> wrote:
> > > > > Miklos Szeredi <miklos@szeredi.hu> wrote:
> > > > > 
> > > > > > I'm doing a patch.   Let's see how it fares in the face of
> > > > > > all these
> > > > > > preconceptions.
> > > > > Don't forget the efficiency criterion.  One reason for going
> > > > > with fsinfo(2) is
> > > > > that scanning /proc/mounts when there are a lot of mounts in
> > > > > the system is
> > > > > slow (not to mention the global lock that is held during the
> > > > > read).
> > > BTW, I do feel that there's room for improvement in userspace
> > > code as
> > > well.  Even quite big mount table could be scanned for *changes*
> > > very
> > > efficiently.  l.e. cache previous contents of
> > > /proc/self/mountinfo and
> > > compare with new contents, line-by-line.  Only need to parse the
> > > changed/added/removed lines.
> > > 
> > > Also it would be pretty easy to throttle the number of updates so
> > > systemd et al. wouldn't hog the system with unnecessary
> > > processing.
> > > 
> > > Thanks,
> > > Miklos
> > > 
> > 
> > At least having patches to compare would allow us to look at the
> > performance here and gain some numbers, which would be helpful to
> > frame
> > the discussions. However I'm not seeing how it would be easy to
> > throttle
> > updates... they occur at whatever rate they are generated and this
> > can
> > be fairly high. Also I'm not sure that I follow how the
> > notifications
> > and the dumping of the whole table are synchronized in this case,
> > either.
> 
> What I meant is optimizing current userspace without additional
> kernel
> infrastructure.   Since currently there's only the monolithic
> /proc/self/mountinfo, it's reasonable that if the rate of change is
> very high, then we don't re-read this table on every change, only
> within a reasonable time limit (e.g. 1s) to provide timely updates.
> Re-reading the table on every change would (does?) slow down the
> system so that the actual updates would even be slower, so throttling
> in this case very much  makes sense.

Optimizing user space is a huge task.

For example, consider this (which is related to a recent upstream
discussion I had):
https://blog.janestreet.com/troubleshooting-systemd-with-systemtap/

Working on improving libmount is really useful but that can't help
with inherently inefficient approaches to keeping info. current
which is actually needed at times.

> 
> Once we have per-mount information from the kernel, throttling
> updates
> probably does not make sense.

And can easily lead to application problems. Throttling will
lead to an inability to have up to date information upon which
application decisions are made.

I don't think it's a viable solution to the separate problem
of a large number of notifications either.

Ian

