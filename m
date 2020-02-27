Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 26A03171485
	for <lists+linux-fsdevel@lfdr.de>; Thu, 27 Feb 2020 10:56:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728741AbgB0Jz4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 27 Feb 2020 04:55:56 -0500
Received: from new2-smtp.messagingengine.com ([66.111.4.224]:50321 "EHLO
        new2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728454AbgB0Jz4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 27 Feb 2020 04:55:56 -0500
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailnew.nyi.internal (Postfix) with ESMTP id 1EF9C6D80;
        Thu, 27 Feb 2020 04:55:55 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 27 Feb 2020 04:55:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=themaw.net; h=
        message-id:subject:from:to:cc:date:in-reply-to:references
        :content-type:mime-version:content-transfer-encoding; s=fm2; bh=
        dOBxBMu6sq33WTKLlcHkrfoyV1zvS7moot7PPNknccs=; b=YMBhXrnhoMVmVtu+
        0XpTyhq5MbTVZxBJ+jFB5SXvXsk05RFEEYGuTD0PWZ0RhM0KOk11DEgyyifH4Pg/
        e71CM7ljablzxuXpnXMTXH5e/Wg44XB957wkbT0BeaFEGshuEAo8kIsFFvp0WTn2
        +Zlc8021OYxa9Lo/nOv/GeQ9Y35UnSZfrr7LUSsEOOuxxi9sthdBJMp/qibeMCke
        FRmdRA0pelBNbWi2D/64WKJslPH8xlnRudvt4ajxYZTKWKztymg1cCJnUMdIVfxt
        GMu/qNJcC3Ee2Q0HbjaP3fP+BS4vl2N9i5EdjtusO2yzGlJZIBafmxh1e+1o7dyV
        pfDOZQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; bh=dOBxBMu6sq33WTKLlcHkrfoyV1zvS7moot7PPNknc
        cs=; b=YFRho0yB5hnT4D7AB1zIg9bPyfmHxf4r6cx6hR7DGXqd0tP93RxPf21MH
        K1acucU3zTdd+6t0ONsnF/of9232+iEgmfJCxm7fUWelARM1fwdRgMKutffRsCGG
        0GOXm6ooCQWxyNbhEuFRVe5Y5H2qrrvKv0DaY/dcx86k6jxYkorEKNHnRxgsRpck
        cesFa4YPPQVh9KBHBqjBVmKTdiKj1yi8/L46GnrTTuwq9xfeh1vEkYtuZgvsdf5r
        MkYcApb5N3aI8L6KzJLWSDmxavESjwBr3BkOUVe8i1ZEDaVMXLAQLu/bqWOArPrE
        kFiYPxViJ+muSwEo12sLUQybNy+Ig==
X-ME-Sender: <xms:KpJXXitWMVsTtuw_Szixin9m6lqDvMXbwpqEvSitUl02nKjjRrHZHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedugedrleeigddutdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkuffhvfffjghftggfggfgsehtjeertddtreejnecuhfhrohhmpefkrghnucfm
    vghnthcuoehrrghvvghnsehthhgvmhgrfidrnhgvtheqnecukfhppeduudekrddvtdelrd
    dukedvrdeludenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhr
    ohhmpehrrghvvghnsehthhgvmhgrfidrnhgvth
X-ME-Proxy: <xmx:KpJXXqtajhUm6_lL0JXDUt1zEvUibaGbKZriBAd28fiRvMtzvtwHzw>
    <xmx:KpJXXnPAgNtkG4mN84UnU1jI6JJA89UmX1LYcZhjmFJuNSCAlFJd8w>
    <xmx:KpJXXo2-HrFnRGSDDn0XaGshgYtpLyBsVir2_pURHqAStlocp7bvxA>
    <xmx:K5JXXsCShwB4yyPGWNumFQXq4MB-b5rd_dDmKcciX4V3ObTSO_hePA>
Received: from mickey.themaw.net (unknown [118.209.182.91])
        by mail.messagingengine.com (Postfix) with ESMTPA id 58D643280063;
        Thu, 27 Feb 2020 04:55:48 -0500 (EST)
Message-ID: <9d7b76c32d09492137a253e692624856388693db.camel@themaw.net>
Subject: Re: [PATCH 00/11] fs/dcache: Limit # of negative dentries
From:   Ian Kent <raven@themaw.net>
To:     Andreas Dilger <adilger@dilger.ca>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Waiman Long <longman@redhat.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Jonathan Corbet <corbet@lwn.net>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-doc@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        Dave Chinner <david@fromorbit.com>,
        Eric Sandeen <sandeen@redhat.com>
Date:   Thu, 27 Feb 2020 17:55:43 +0800
In-Reply-To: <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
References: <20200226161404.14136-1-longman@redhat.com>
         <20200226162954.GC24185@bombadil.infradead.org>
         <2EDB6FFC-C649-4C80-999B-945678F5CE87@dilger.ca>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.32.5 (3.32.5-1.fc30) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, 2020-02-26 at 14:28 -0700, Andreas Dilger wrote:
> On Feb 26, 2020, at 9:29 AM, Matthew Wilcox <willy@infradead.org>
> wrote:
> > On Wed, Feb 26, 2020 at 11:13:53AM -0500, Waiman Long wrote:
> > > A new sysctl parameter "dentry-dir-max" is introduced which
> > > accepts a
> > > value of 0 (default) for no limit or a positive integer 256 and
> > > up. Small
> > > dentry-dir-max numbers are forbidden to avoid excessive dentry
> > > count
> > > checking which can impact system performance.
> > 
> > This is always the wrong approach.  A sysctl is just a way of
> > blaming
> > the sysadmin for us not being very good at programming.
> > 
> > I agree that we need a way to limit the number of negative
> > dentries.
> > But that limit needs to be dynamic and depend on how the system is
> > being
> > used, not on how some overworked sysadmin has configured it.
> > 
> > So we need an initial estimate for the number of negative dentries
> > that
> > we need for good performance.  Maybe it's 1000.  It doesn't really
> > matter;
> > it's going to change dynamically.
> > 
> > Then we need a metric to let us know whether it needs to be
> > increased.
> > Perhaps that's "number of new negative dentries created in the last
> > second".  And we need to decide how much to increase it; maybe it's
> > by
> > 50% or maybe by 10%.  Perhaps somewhere between 10-100% depending
> > on
> > how high the recent rate of negative dentry creation has been.
> > 
> > We also need a metric to let us know whether it needs to be
> > decreased.
> > I'm reluctant to say that memory pressure should be that metric
> > because
> > very large systems can let the number of dentries grow in an
> > unbounded
> > way.  Perhaps that metric is "number of hits in the negative dentry
> > cache in the last ten seconds".  Again, we'll need to decide how
> > much
> > to shrink the target number by.
> 
> OK, so now instead of a single tunable parameter we need three,
> because
> these numbers are totally made up and nobody knows the right values.
> :-)
> Defaulting the limit to "disabled/no limit" also has the problem that
> 99.99% of users won't even know this tunable exists, let alone how to
> set it correctly, so they will continue to see these problems, and
> the
> code may as well not exist (i.e. pure overhead), while Waiman has a
> better idea today of what would be reasonable defaults.

Why have these at all.

Not all file systems even produce negative hashed dentries.

The most beneficial use of them is to improve performance of rapid
fire lookups for non-existent names. Longer lived negative hashed
dentries don't give much benefit at all unless they suddenly have
lots of hits and that would cost a single allocation on the first
lookup if the dentry ttl expired and the dentry discarded.

A ttl (say jiffies) set at appropriate times could be a better
choice all round, no sysctl values at all.

Ian

