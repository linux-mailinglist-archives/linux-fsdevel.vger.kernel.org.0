Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC2C123B2AB
	for <lists+linux-fsdevel@lfdr.de>; Tue,  4 Aug 2020 04:16:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHDCP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 22:15:59 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:49735 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725975AbgHDCP6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 22:15:58 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id D0BE1109E;
        Mon,  3 Aug 2020 22:15:56 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Aug 2020 22:15:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        Yf5WKRO+L01e+K0gQ+L/XIx6I13Eu/IhzjwnU3V5dgc=; b=c6z5GPuRxHtsPtGY
        P2POfINNzW66vYofIVzYVwHi13eTDhiL2WxSOKOvbymdtptV7Mp+qlpNOL9tHc83
        7fmMAA6LyGKVnsT+O8LfiHvywmCyYJ3iVdZ1rVggs1J82fMbth7pQPw/4iZoZYZ6
        j4FhANVoVoqR3fzOjngPvn7ypuMd2gIFNfr4RUpoq6owEo8lQi9zNjuAgaoZtPC5
        z3uLb7fxv8OvYiSlmnwoCPCmR1WNcVH0VvhxPaLgvMa52OaYzMJp5MJ4nBo97rAp
        FtbgtlMsub9XfboFIqq8Z2Fn7ztP3CRkAFrIIoirO/xa4bMWi8UN8ya2RaYt9xlQ
        msCcEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=Yf5WKRO+L01e+K0gQ+L/XIx6I13Eu/IhzjwnU3V5d
        gc=; b=nFx19OQYzzZpwIHK6HpTDDfgmz5APlzGRIrPXSKbMKbCjhJLMd9hjYCV/
        nt/IqfJaZ3H6oCg9XzUyPcdbUAggHTBBdSkT2kwwlHk+xoR9jPRg17l0gHFJ9VOW
        ENJnDcKVKCq0pPnLHq4WNa+Hw5O5KS3RGu/0+G10QClUN5jMgG1uJg6EMj5JsP7Y
        2suqHnujWz3a5aeQN27H22ipANuVkaGJ4m50iCQo6g7Y0OhSM/jt5VvU4tDFhcEp
        4DLT/n/3Oh2N3lLE22sLsRoPPnplqJWHlKJxasVXH+OSSTKi82THesNcef9ixwqP
        U4QcPM9C10N9mJOycOn3BR7LLrfVg==
X-ME-Sender: <xms:28QoX9kfHU6I_-P-KFh2NCyyMhNxO0Wy56iSBdkKI5_54YoL7qltNg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeehgdehjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtkeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepgf
    elleekteehleegheeujeeuudfhueffgfelhefgvedthefhhffhhfdtudfgfeehnecukfhp
    peduudekrddvtdekrdegjedrudeiudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:28QoX42hBT_u_f-GDrU9bAY2IwY1BIl1uRaOxGt1nlKBi0UyIUYeaQ>
    <xmx:28QoXzrP5g94gMa__7eHy5VgGK6VG041qEheMqb1HaU1RwJDQiX3hA>
    <xmx:28QoX9nDz72gVMjYcV8Caf9p_0KxKhaSeU7w54d29-HZHR65WMi5Cw>
    <xmx:3MQoX9yMsQy_Sa6iqa0KFI5VWNpxAgWRegW3V-tKjokRuAyJAk3yIh4uc0w>
Received: from mickey.themaw.net (unknown [118.208.47.161])
        by mail.messagingengine.com (Postfix) with ESMTPA id D9CA2328005E;
        Mon,  3 Aug 2020 22:15:50 -0400 (EDT)
Message-ID: <ac1f5e3406abc0af4cd08d818fe920a202a67586.camel@themaw.net>
Subject: Re: [GIT PULL] Filesystem Information
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>,
        David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>, Karel Zak <kzak@redhat.com>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Tue, 04 Aug 2020 10:15:47 +0800
In-Reply-To: <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
References: <1842689.1596468469@warthog.procyon.org.uk>
         <1845353.1596469795@warthog.procyon.org.uk>
         <CAJfpegunY3fuxh486x9ysKtXbhTE0745ZCVHcaqs9Gww9RV2CQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 18:42 +0200, Miklos Szeredi wrote:
> On Mon, Aug 3, 2020 at 5:50 PM David Howells <dhowells@redhat.com>
> wrote:
> > 
> > Hi Linus,
> > 
> > Here's a set of patches that adds a system call, fsinfo(), that
> > allows
> > information about the VFS, mount topology, superblock and files to
> > be
> > retrieved.
> > 
> > The patchset is based on top of the mount notifications patchset so
> > that
> > the mount notification mechanism can be hooked to provide event
> > counters
> > that can be retrieved with fsinfo(), thereby making it a lot faster
> > to work
> > out which mounts have changed.
> > 
> > Note that there was a last minute change requested by Miklós: the
> > event
> > counter bits got moved from the mount notification patchset to this
> > one.
> > The counters got made atomic_long_t inside the kernel and __u64 in
> > the
> > UAPI.  The aggregate changes can be assessed by comparing pre-
> > change tag,
> > fsinfo-core-20200724 to the requested pull tag.
> > 
> > Karel Zak has created preliminary patches that add support to
> > libmount[*]
> > and Ian Kent has started working on making systemd use these and
> > mount
> > notifications[**].
> 
> So why are you asking to pull at this stage?
> 
> Has anyone done a review of the patchset?

I have been working with the patch set as it has evolved for quite a
while now.

I've been reading the kernel code quite a bit and forwarded questions
and minor changes to David as they arose.

As for a review, not specifically, but while the series implements a
rather large change it's surprisingly straight forward to read.

In the time I have been working with it I haven't noticed any problems
except for those few minor things that I reported to David early on (in
some cases accompanied by simple patches).

And more recently (obviously) I've been working with the mount
notifications changes and, from a readability POV, I find it's the
same as the fsinfo() code.

> 
> I think it's obvious that this API needs more work.  The integration
> work done by Ian is a good direction, but it's not quite the full
> validation and review that a complex new API needs.

Maybe but the system call is fundamental to making notifications useful
and, as I say, after working with it for quite a while I don't fell
there's missing features (that David hasn't added along the way) and
have found it provides what's needed for what I'm doing (for mount
notifications at least).

I'll be posting a github PR for systemd for discussion soon while I
get on with completing the systemd change. Like overflow handling and
meson build system changes to allow building with and without the
util-linux libmount changes.

So, ideally, I'd like to see the series merged, we've been working on
it for quite a considerable time now.

Ian

