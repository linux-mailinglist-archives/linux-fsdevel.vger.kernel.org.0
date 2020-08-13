Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8594E2431EE
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Aug 2020 03:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726567AbgHMBBp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 12 Aug 2020 21:01:45 -0400
Received: from wnew2-smtp.messagingengine.com ([64.147.123.27]:60243 "EHLO
        wnew2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726078AbgHMBBo (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 12 Aug 2020 21:01:44 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 2FEF5B4F;
        Wed, 12 Aug 2020 21:01:42 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Wed, 12 Aug 2020 21:01:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        JG1tgGZ/mQI9+jPnvtxoNjrRjRVSVgKjSvfLuuK+16o=; b=YsGy5BPCab5tRtyn
        T6XQlYKFThZ2rbXRsDmInqLDn3V+VijsKNYx70VBFA3doBccGyS0GW3fKT/FMT7L
        CrBLO4cZrRIcshJcwe9IrNnzTbQ68p1q2X2pwGhtlBs5HglthTBZAr9KpLoQjJv2
        oi3NcyHfLBdsPSsGxsnMx9SDmhTd4aF9faRx6U0qZeJQ9XTEsd8UeWvulViu7sgz
        M4BI3M18nX91VCBQwn6GqhfMJyQl+83/+Zgn6d6HB/KuWfm3VcPRTriQhajyAxxV
        oz3FU48W8KTuaXUBTFi+LZgxdGqB1WmQTFh/FqrIUtfGRkz1Rq0PIghWQmGxto1f
        lWNgew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=JG1tgGZ/mQI9+jPnvtxoNjrRjRVSVgKjSvfLuuK+1
        6o=; b=RH5FLj2bOOLTC4WTSYiN1K8+Bst9j2gJtQjvt1s4rIUBCFWcgvSQNu7mr
        pitZlBaELSNmB5K6TdX/oxfSa6WSs86X76XCrRuzYGg2ufjODnJNYaqveT/zepbA
        BndAAner4iGUjtl59qs5PZL69w/6x+vmR9fuAcrwvpaXx0Pv6YYmESh4Ca+Hd43W
        glFdlaDtbCVVeTgI1kGiVMR0KpGy/bOtopMb+wMeycysNBh0E7KPyqGwmG2Ot6m5
        ttCYaDmLSvbz0bSoBlQlaGHIoTzdyFlF/BhEw2Tt8rA7TPEVZbT1nQ1kxycxsFzX
        /XT9WtixMxBZ6UL5iT3K+hMPRHNtQ==
X-ME-Sender: <xms:9JA0X-Fv-D3nOwj7nvd5kBrnL1tU_QBWutemZ9nnRS87eH-bFHP78A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrleefgdegfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvddtfedruddugeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:9JA0X_XkrSBnRmi74Bg3JzuS8s5qttogVC2Mn6oDIYDVmqCQx28qvg>
    <xmx:9JA0X4Ly-qQ4urlCcGK9tYnFrRqqOIwfyz55PKmNa2Zi8KWvxi28aw>
    <xmx:9JA0X4F5dUXrRhj6BYFcFd0QMbTsHSfXVHw4YEq8q7Dw4oBH4GFblg>
    <xmx:9ZA0X9MTb5f9KI-jQamiXciLjfeovByEMET6DTE8mqkLLPmnmUxzutIpcsM>
Received: from mickey.themaw.net (58-7-203-114.dyn.iinet.net.au [58.7.203.114])
        by mail.messagingengine.com (Postfix) with ESMTPA id AF46D3280065;
        Wed, 12 Aug 2020 21:01:35 -0400 (EDT)
Message-ID: <989bb93754a4af69c02a9f42b05549f7e72630b3.camel@themaw.net>
Subject: Re: file metadata via fs API
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Karel Zak <kzak@redhat.com>,
        Steven Whitehouse <swhiteho@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@redhat.com>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>,
        Lennart Poettering <lennart@poettering.net>,
        Linux API <linux-api@vger.kernel.org>,
        LSM <linux-security-module@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Date:   Thu, 13 Aug 2020 09:01:31 +0800
In-Reply-To: <131358.1597237585@warthog.procyon.org.uk>
References: <CAJfpegv4sC2zm+N5tvEmYaEFvvWJRHfdGqXUoBzbeKj81uNCvQ@mail.gmail.com>
         <CAJfpegu8omNZ613tLgUY7ukLV131tt7owR+JJ346Kombt79N0A@mail.gmail.com>
         <CAJfpegtNP8rQSS4Z14Ja4x-TOnejdhDRTsmmDD-Cccy2pkfVVw@mail.gmail.com>
         <20200811135419.GA1263716@miu.piliscsaba.redhat.com>
         <CAHk-=wjzLmMRf=QG-n+1HnxWCx4KTQn9+OhVvUSJ=ZCQd6Y1WA@mail.gmail.com>
         <52483.1597190733@warthog.procyon.org.uk>
         <CAJfpegt=cQ159kEH9zCYVHV7R_08jwMxF0jKrSUV5E=uBg4Lzw@mail.gmail.com>
         <98802.1597220949@warthog.procyon.org.uk>
         <CAJfpegsVJo9e=pHf3YGWkE16fT0QaNGhgkUdq4KUQypXaD=OgQ@mail.gmail.com>
         <d2d179c7-9b60-ca1a-0c9f-d308fc7af5ce@redhat.com>
         <CAJfpeguMjU+n-JXE6aUQQGeMpCS4bsy4HQ37NHJ8aD8Aeg2qhA@mail.gmail.com>
         <20200812112825.b52tqeuro2lquxlw@ws.net.home>
         <131358.1597237585@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-12 at 14:06 +0100, David Howells wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > That presumably means the mount ID <-> mount path mapping already
> > exists, which means it's just possible to use the open(mount_path,
> > O_PATH) to obtain the base fd.
> 
> No, you can't.  A path more correspond to multiple mounts stacked on
> top of
> each other, e.g.:
> 
> 	mount -t tmpfs none /mnt
> 	mount -t tmpfs none /mnt
> 	mount -t tmpfs none /mnt
> 
> Now you have three co-located mounts and you can't use the path to
> differentiate them.  I think this might be an issue in autofs, but
> Ian would
> need to comment on that.

It is a problem for autofs, direct mounts in particular, but also
for mount ordering at times when umounting a tree of mounts where
mounts are covered or at shutdown.

Ian

