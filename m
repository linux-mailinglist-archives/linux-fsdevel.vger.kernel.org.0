Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B551C23A3BD
	for <lists+linux-fsdevel@lfdr.de>; Mon,  3 Aug 2020 14:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726276AbgHCMCY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 3 Aug 2020 08:02:24 -0400
Received: from wnew1-smtp.messagingengine.com ([64.147.123.26]:41593 "EHLO
        wnew1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726169AbgHCMBq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 3 Aug 2020 08:01:46 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.west.internal (Postfix) with ESMTP id 56B8FA21;
        Mon,  3 Aug 2020 08:01:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 03 Aug 2020 08:01:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm3; bh=
        jV+XLRC89DS9wpmSKAncS/grhCMTNZHJAC2sQikNzwk=; b=M2RCVUYDcXIGO+yj
        tSrxVD/I/F1rus6SriAtii5lKkUUXHehai4Q2qO9oIl4wTr0f4aK9Aa2nB4HNrT4
        xghuew5UlSTUmbfgPXkj1UTSUBOxuwsViGAe318Hve/zZzLXUjXloRsDdwGL39TW
        FZFniPSw/eYr/+G6SBxPeM/CSZR2BaypZbLXRTGOpbwcRUZkccnxFd8KdToeRxQ6
        qPcIh/U1tcFQ8hqeBjvSMLiAGpfgp5QuRlK9SE2+0arXi08b2guRKC5AdCx1kkLQ
        lOU88B1N+FJEPycvkqKNwGCii9egebuKnYUXhHZsrRpWYzs7xCigq3ZJU97X0dX5
        7aHW2Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm3; bh=jV+XLRC89DS9wpmSKAncS/grhCMTNZHJAC2sQikNz
        wk=; b=JB+YUZWR+YTu60lOL3nVss2Mtq0jg4xQyWZUY9IoFm6kCbdru2VOahjhJ
        F33RE4/tGXzjYrhXl9ikXPydZS9stYyDZ/TKb+7PqtiZzQNx2bYrduwft1BVCjlu
        v4KM2/F6E2Uc8YH6paP/lw6sZC1ky2WFKWBcJjY1zi8PAnJcNaidDeJ5EUq+0ZUY
        pG9F++OYdbP3B/9rfX7yIgLZQPyMyuyjXMO+frNIKWbeOUzg6nW0x6XkNj2MzQmq
        4Rb0hlMicIjZzGSNZE9srGwnwy0n3Jj3Fgy4OotZ3DWWtvnMbk10EeysHb9ZZqu6
        lI9rs++YnMVaDsQV04BOivtePdbHA==
X-ME-Sender: <xms:oPwnXys1JywhFfZT4ouleLaW19O3_TvLZJGxFqy-CeezqzN6S7meFw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduiedrjeeggdegjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecuggftrfgrthhtvghrnhepfe
    efteetvdeguddvveefveeftedtffduudehueeihfeuvefgveehffeludeggfejnecukfhp
    peehkedrjedrvdehtddrudekheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:oPwnX3dhEJw-U6MyeMO3uKKVeXGxZCjiiyW3F-Xeo2bRLOqa7-taOA>
    <xmx:oPwnX9zBni0v6lrqlgRT5q-el8IMb5h9XR1DRT9sKPnK9eHLD1CbOw>
    <xmx:oPwnX9Oed9KQM6ahx7HLJAchoIzgAA0pXJWZh7jcOFTTgp6V2GR4mQ>
    <xmx:ofwnX9X37_HcmS8vH2bN4cZiueY_Qc9e6YHTs0LK8AvV3ndOajhkR3sJcKA>
Received: from mickey.themaw.net (58-7-250-185.dyn.iinet.net.au [58.7.250.185])
        by mail.messagingengine.com (Postfix) with ESMTPA id 2DEE43280067;
        Mon,  3 Aug 2020 08:01:30 -0400 (EDT)
Message-ID: <303106be4785135446e56cb606138a6e94885887.camel@themaw.net>
Subject: Re: [PATCH 13/17] watch_queue: Implement mount topology and
 attribute change notifications [ver #5]
From:   Ian Kent <raven@themaw.net>
To:     David Howells <dhowells@redhat.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
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
Date:   Mon, 03 Aug 2020 20:01:27 +0800
In-Reply-To: <1576646.1596455376@warthog.procyon.org.uk>
References: <CAJfpeguO8Qwkzx9zfGVT7W+pT5p6fgj-_8oJqJbXX_KQBpLLEQ@mail.gmail.com>
         <1293241.1595501326@warthog.procyon.org.uk>
         <CAJfpegspWA6oUtdcYvYF=3fij=Bnq03b8VMbU9RNMKc+zzjbag@mail.gmail.com>
         <158454378820.2863966.10496767254293183123.stgit@warthog.procyon.org.uk>
         <158454391302.2863966.1884682840541676280.stgit@warthog.procyon.org.uk>
         <2003787.1595585999@warthog.procyon.org.uk>
         <865566fb800a014868a9a7e36a00a14430efb11e.camel@themaw.net>
         <2023286.1595590563@warthog.procyon.org.uk>
         <CAJfpegsT_3YqHPWCZGX7Lr+sE0NVmczWz5L6cN8CzsVz4YKLCQ@mail.gmail.com>
         <1283475.1596449889@warthog.procyon.org.uk>
         <1576646.1596455376@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, 2020-08-03 at 12:49 +0100, David Howells wrote:
> Miklos Szeredi <miklos@szeredi.hu> wrote:
> 
> > OTOH mount notification is way smaller and IMO a more mature
> > interface.  So just picking the unique ID patch into this set might
> > make sense.
> 
> But userspace can't retrieve the unique ID without fsinfo() as things
> stand.
> 
> I'm changing it so that the fields are 64-bit, but initialised with
> the
> existing mount ID in the notifications set.  The fsinfo set changes
> that to a
> unique ID.  I'm tempted to make the unique IDs start at UINT_MAX+1 to
> disambiguate them.

Mmm ... so what would I use as a mount id that's not used, like NULL
for strings?

I'm using -1 now but changing this will mean I need something
different.

Could we set aside a mount id that will never be used so it can be
used for this case?

Maybe mount ids should start at 1 instead of zero ...

Ian


