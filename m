Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BBF323D288
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 22:14:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729610AbgHEUNr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Aug 2020 16:13:47 -0400
Received: from wnew3-smtp.messagingengine.com ([64.147.123.17]:37003 "EHLO
        wnew3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726629AbgHEQX0 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Aug 2020 12:23:26 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 37C75970;
        Wed,  5 Aug 2020 07:36:16 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 05 Aug 2020 07:36:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        TV/ywlemDl0JIUauxpySAysG0pozcgKEtLbmEq/dGCI=; b=AwFBpkUnA5Q3eZVP
        GUBhoB/ilhwXI9VqrBWf6R5OCpprqNbp8Idwbc0ORpfdwf9XRzKHxTAwASOBHloP
        C8kELv06f6HkCdmM7o/reWrBy3ZFHjtS93RPzrtwzpS9px9u0fikYwf5UfAk8BZ5
        RcJHbvLqHaFZmmEjgxmdm0rRJiF6rzz0BWYeVdJTPAjS1R2mxJunWX3eTVWhiAW/
        6Ap9JaHp1kY6tvHneM1y6nxLkgmPIl/GLPbviB/kmezKdXUMUKBQ6umnfBH0G58f
        uP7AT57ilb7hRJHyP0HqrNRGP3Aw+xdw/wbrLXYX5oE44K2eyZIzhipL3rbEpcmc
        S1RKug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=TV/ywlemDl0JIUauxpySAysG0pozcgKEtLbmEq/dG
        CI=; b=lGi918tCPuQclchc60ZkZQcFuFeLnuEaz5oFvKYw47Yf6N9duODX99vQ0
        v2wjcf/SgbslZcfvhprEmRgqBL19HB/1eb/JYzoYuP5jz2HFYgT/ak9IDUfwnhAJ
        YkJIqH/75jxgyxwt67ZoBjpJqUEoP+E/n89yydB8voI+I/O7zCc7QhLrKKOuLxd8
        vDlll4NR2YcE16zazVrfdI/a8y3gt5FGnB5CxQbKvQx0Q1/68uU+NYGdXE8gcVBZ
        bHzmSNEbRP2lrp6vbGU5+8EiHmA2mQO1uyjzA/m5uW9PHXNgxKUgFedSPlxBTu5F
        R1D43CcSiAfHDm04i23VAV+1VwUBw==
X-ME-Sender: <xms:rpkqXxIM464vxKzxo1Ps1E1MNcoGOyyXu-byRxZmcehu1oS4oiPbAg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeekgdeggecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:rpkqX9JrEnjQ0a_60B4dCHApSvALGVOSkJ8Sxj0D243ONHuAEjv0JQ>
    <xmx:rpkqX5vsriW3o_YwMp5QeyhNrGEqZvM_FMb5gGXkEH6Kldth5k2SAw>
    <xmx:rpkqXyZs1QHUmAvW5-dnVwWP92AJYBeyrGhvLg8ZW4Z58zFbXsHgqw>
    <xmx:r5kqX0T5XKAiop0pugkIzJKNdw90x3nEoU89eXDiXzbLMU5kcLe6uaYBMNU>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1578A30600B1;
        Wed,  5 Aug 2020 07:36:08 -0400 (EDT)
Message-ID: <013e9bb3cb1536c73a5b58c5ff000b3b00629561.camel@themaw.net>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and
 attribute change notifications [ver #5]
From:   Ian Kent <raven@themaw.net>
To:     Miklos Szeredi <miklos@szeredi.hu>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Casey Schaufler <casey@schaufler-ca.com>,
        Stephen Smalley <sds@tycho.nsa.gov>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Christian Brauner <christian@brauner.io>, andres@anarazel.de,
        Jeff Layton <jlayton@redhat.com>, dray@redhat.com,
        Karel Zak <kzak@redhat.com>, keyrings@vger.kernel.org,
        Linux API <linux-api@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org,
        LSM <linux-security-module@vger.kernel.org>,
        linux-kernel@vger.kernel.org
Date:   Wed, 05 Aug 2020 19:36:05 +0800
In-Reply-To: <CAJfpegvxKTy+4Zk6banvxQ83PeFV7Xnt2Qv=kkOg57rxFKqVEg@mail.gmail.com>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
         <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
         <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com>
         <c558fc4af785f62a2751be3b297d1ccbbfcfa969.camel@themaw.net>
         <CAJfpegvxKTy+4Zk6banvxQ83PeFV7Xnt2Qv=kkOg57rxFKqVEg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-08-05 at 09:43 +0200, Miklos Szeredi wrote:
> On Wed, Aug 5, 2020 at 3:54 AM Ian Kent <raven@themaw.net> wrote:
> > > > It's way more useful to have these in the notification than
> > > > obtainable
> > > > via fsinfo() IMHO.
> > > 
> > > What is it useful for?
> > 
> > Only to verify that you have seen all the notifications.
> > 
> > If you have to grab that info with a separate call then the count
> > isn't necessarily consistent because other notifications can occur
> > while you grab it.
> 
> No, no no.   The watch queue will signal an overflow, without any
> additional overhead for the normal case.  If you think of this as a
> protocol stack, then the overflow detection happens on the transport
> layer, instead of the application layer.  The application layer is
> responsible for restoring state in case of a transport layer error,
> but detection of that error is not the responsibility of the
> application layer.

I can see in the kernel code that an error is returned if the message
buffer is full when trying to add a message, I just can't see where
to get it in the libmount code.

That's not really a communication protocol problem.

Still I need to work out how to detect it, maybe it is seen by
the code in libmount already and I simply can't see what I need
to do to recognise it ...

So I'm stuck wanting to verify I have got everything that was
sent and am having trouble moving on from that.

Ian

