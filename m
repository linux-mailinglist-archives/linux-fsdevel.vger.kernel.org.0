Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0685323C32E
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Aug 2020 03:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726584AbgHEByA (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Aug 2020 21:54:00 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:48731 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725904AbgHEBx7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Aug 2020 21:53:59 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id CB856601;
        Tue,  4 Aug 2020 21:53:57 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 04 Aug 2020 21:53:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        rPYF5yA8hLNR4c7pU4Df6+cNnwOEB80CCSVmFwv4puA=; b=YE+d82rIPbXuqxKn
        CXWvxCQaWgzhv0XBh1YVuS/u8Fz0WWKMS//bQaBDHULPvdD5yvCyzb+jBcSJ3Mdh
        1mUsM4K1IdFBQfkLZ0yAYYF+34SvOvlgsIs94InE758/8SOWYBZfj36o9d0cB545
        nUafKcJcssT+8CBoAFNAlVaWgAC4X7wHow2XrOFUfdVWrtSlfz7MyL4uHBh6AI2G
        ycpE8qcsRdXa90ejYNkcz5NKCUQZYBBGovcRLN+zL0L6eB7Cs7/xlZ/npofRWONZ
        1oUZqJt3HQ8033SHLXsx1sqCfRXt64zZ+zNeX6Iq2cD4lBee121EAawySjv89w5c
        nTw2fA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=rPYF5yA8hLNR4c7pU4Df6+cNnwOEB80CCSVmFwv4p
        uA=; b=jgUjtgUfMjrVXlKCmnCFFqJRatOzXD+NEJFZq47Rzhx6N0/vyRokeyTfD
        mTjr2N5w0ddJEQ1yGJWC/6+6DI9G9M218fx1WUJhn2aAzI9cAC0dFyW7vbCBWL9/
        OluyU20xC54EE0Cj0pbj49mXIG1fDRenSPdSJluKS2nQdDvCIUS7mjxxBIUH5oTh
        wJh2M5bhy4GNcwK/2qMZdvpM1V6K7A+HzDrsLSp/FtebaGTkmigfFVjKV8nVr92N
        m4LMH8JGBwkpUm+LOkmox3+ZliFks7+8Sdh8P9bUCyvbUQLP/4Dwrys5FRAf4X6m
        4wwPNlTdaggnYdC2c/HTHizozvNAg==
X-ME-Sender: <xms:NBEqXymkRrlVO5xktKBzf0ANqsZ26TDxhaukMJRmDd1jnt-UyUNGPQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeejgdehfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehhedrvddvtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:NBEqX53XUobCLoxk8ViEmFPfFVxhV4n8SkdnTKtrD2roLlpm_3zv0Q>
    <xmx:NBEqXwo0GYEBS0IXO-_Zm0V5YRX6VOjmYI6gjRgvIoEiku8QKQ7K6g>
    <xmx:NBEqX2mQl4ZOb1JottGZERsKA41UNsdkW4kNX_47B1jazMOc-geySQ>
    <xmx:NREqX2N-KA3YGhusO26WSXjOI-4EW_NPYYrRQwx1c6rLZ1aEeZrtip8tmpM>
Received: from mickey.themaw.net (58-7-255-220.dyn.iinet.net.au [58.7.255.220])
        by mail.messagingengine.com (Postfix) with ESMTPA id 94858328005D;
        Tue,  4 Aug 2020 21:53:50 -0400 (EDT)
Message-ID: <c558fc4af785f62a2751be3b297d1ccbbfcfa969.camel@themaw.net>
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
Date:   Wed, 05 Aug 2020 09:53:46 +0800
In-Reply-To: <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com>
References: <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpeguvLMCw1H8+DPsfZE_k0sEiRtA17pD9HjnceSsAvqqAZw@mail.gmail.com>
         <43c061d26ddef2aa3ca1ac726da7db9ab461e7be.camel@themaw.net>
         <CAJfpeguFkDDhz7+70pSUv_j=xY5L08ESpaE+jER9vE5p+ZmfFw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 2020-08-04 at 15:19 +0200, Miklos Szeredi wrote:
> On Tue, Aug 4, 2020 at 1:39 PM Ian Kent <raven@themaw.net> wrote:
> > On Mon, 2020-08-03 at 11:29 +0200, Miklos Szeredi wrote:
> > > On Thu, Jul 23, 2020 at 12:48 PM David Howells <
> > > dhowells@redhat.com>
> > > wrote:
> > > 
> > > > > >                 __u32   topology_changes;
> > > > > >                 __u32   attr_changes;
> > > > > >                 __u32   aux_topology_changes;
> > > > > 
> > > > > Being 32bit this introduces wraparound effects.  Is that
> > > > > really
> > > > > worth it?
> > > > 
> > > > You'd have to make 2 billion changes without whoever's
> > > > monitoring
> > > > getting a
> > > > chance to update their counters.  But maybe it's not worth it
> > > > putting them
> > > > here.  If you'd prefer, I can make the counters all 64-bit and
> > > > just
> > > > retrieve
> > > > them with fsinfo().
> > > 
> > > Yes, I think that would be preferable.
> > 
> > I think this is the source of the recommendation for removing the
> > change counters from the notification message, correct?
> > 
> > While it looks like I may not need those counters for systemd
> > message
> > buffer overflow handling myself I think removing them from the
> > notification message isn't a sensible thing to do.
> > 
> > If you need to detect missing messages, perhaps due to message
> > buffer
> > overflow, then you need change counters that are relevant to the
> > notification message itself. That's so the next time you get a
> > message
> > for that object you can be sure that change counter comparisons you
> > you make relate to object notifications you have processed.
> 
> I don't quite get it.  Change notification is just that: a
> notification.   You need to know what object that notification
> relates
> to, to be able to retrieve the up to date attributes of said object.
> 
> What happens if you get a change counter N in the notification
> message, then get a change counter N + 1 in the attribute retrieval?
> You know that another change happened, and you haven't yet processed
> the notification yet.  So when the notification with N + 1 comes in,
> you can optimize away the attribute retrieve.
> 
> Nice optimization, but it's optimizing a race condition, and I don't
> think that's warranted.  I don't see any other use for the change
> counter in the notification message.
> 
> 
> > Yes, I know it isn't quite that simple, but tallying up what you
> > have
> > processed in the current batch of messages (or in multiple batches
> > of
> > messages if more than one read has been possible) to perform the
> > check
> > is a user space responsibility. And it simply can't be done if the
> > counters consistency is in question which it would be if you need
> > to
> > perform another system call to get it.
> > 
> > It's way more useful to have these in the notification than
> > obtainable
> > via fsinfo() IMHO.
> 
> What is it useful for?

Only to verify that you have seen all the notifications.

If you have to grab that info with a separate call then the count
isn't necessarily consistent because other notifications can occur
while you grab it.

My per-object rant isn't quite right, what's needed is a consistent
way to verify you have seen everything you were supposed to.

I think your point is that if you grab the info in another call and
it doesn't match you need to refresh and that's fine but I think it's
better to be able to verify you have got everything that was sent as
you go and avoid the need for the refresh more often.

> 
> If the notification itself would contain the list of updated
> attributes and their new values, then yes, this would make sense.  If
> the notification just tells us that the object was modified, but not
> the modifications themselves, then I don't see how the change counter
> in itself could add any information (other than optimizing the race
> condition above).
> 
> Thanks,
> Miklos
> 
> Thanks,
> 
> 
> 
> > > > > >         n->watch.info & NOTIFY_MOUNT_IS_RECURSIVE if true
> > > > > > indicates that
> > > > > >         the notifcation was generated by an event (eg.
> > > > > > SETATTR)
> > > > > > that was
> > > > > >         applied recursively.  The notification is only
> > > > > > generated for the
> > > > > >         object that initially triggered it.
> > > > > 
> > > > > Unused in this patchset.  Please don't add things to the API
> > > > > which are not
> > > > > used.
> > > > 
> > > > Christian Brauner has patches for mount_setattr() that will
> > > > need to
> > > > use this.
> > > 
> > > Fine, then that patch can add the flag.
> > > 
> > > Thanks,
> > > Miklos

