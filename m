Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7942D7A5026
	for <lists+linux-fsdevel@lfdr.de>; Mon, 18 Sep 2023 19:00:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjIRRA2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 18 Sep 2023 13:00:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbjIRRAW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 18 Sep 2023 13:00:22 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C7A697
        for <linux-fsdevel@vger.kernel.org>; Mon, 18 Sep 2023 09:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1695056369;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BXEh9y2WIlpZ1qkBcixGcRigwMo4PIaBdg+Mgb1e5gE=;
        b=Y40dszS9fYmWS6ZoUbDGnYdtqacDYoHNbPXafzFLA2D3EXUv64LfuEmdV3qzi0rmobJkyk
        mCuhGHVI4tQNx0qMBQy9EOwuHKaHLW/L4D6zjrOxYU0jWJftWr7JGHEeI0mbQPZVgLGxcN
        JluyDKDlDU9ytSFwoDJw3+/tfm4fihs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-147-zuHtKiJ2OkyISODxxrfY9Q-1; Mon, 18 Sep 2023 10:54:50 -0400
X-MC-Unique: zuHtKiJ2OkyISODxxrfY9Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5DE6C811E8F;
        Mon, 18 Sep 2023 14:54:49 +0000 (UTC)
Received: from redhat.com (unknown [10.22.18.43])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id BE70A140273E;
        Mon, 18 Sep 2023 14:54:48 +0000 (UTC)
Date:   Mon, 18 Sep 2023 09:54:47 -0500
From:   Bill O'Donnell <bodonnel@redhat.com>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Dave Chinner <david@fromorbit.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Eric Sandeen <sandeen@sandeen.net>,
        Steven Rostedt <rostedt@goodmis.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@infradead.org>, ksummit@lists.linux.dev,
        linux-fsdevel@vger.kernel.org
Subject: Re: [MAINTAINERS/KERNEL SUMMIT] Trust and maintenance of file systems
Message-ID: <ZQhkt4YIPXrdq7Fd@redhat.com>
References: <ZPkDLp0jyteubQhh@dread.disaster.area>
 <20230906215327.18a45c89@gandalf.local.home>
 <ZPkz86RRLaYOkmx+@dread.disaster.area>
 <20230906225139.6ffe953c@gandalf.local.home>
 <ZPlFwHQhJS+Td6Cz@dread.disaster.area>
 <20230907071801.1d37a3c5@gandalf.local.home>
 <b7ca4a4e-a815-a1e8-3579-57ac783a66bf@sandeen.net>
 <CAHk-=wg=xY6id92yS3=B59UfKmTmOgq+NNv+cqCMZ1Yr=FwR9A@mail.gmail.com>
 <ZQTfIu9OWwGnIT4b@dread.disaster.area>
 <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <db57da32517e5f33d1d44564097a7cc8468a96c3.camel@HansenPartnership.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Sep 16, 2023 at 05:50:50PM -0400, James Bottomley wrote:
> On Sat, 2023-09-16 at 08:48 +1000, Dave Chinner wrote:
> > On Wed, Sep 13, 2023 at 10:03:55AM -0700, Linus Torvalds wrote:
> [...]
> > >  - "they use the buffer cache".
> > > 
> > > Waah, waah, waah.
> > 
> > .... you dismiss those concerns in the same way a 6 year old school
> > yard bully taunts his suffering victims.
> > 
> > Regardless of the merits of the observation you've made, the tone
> > and content of this response is *completely unacceptable*.  Please
> > keep to technical arguments, Linus, because this sort of response
> > has no merit what-so-ever. All it does is shut down the technical
> > discussion because no-one wants to be the target of this sort of
> > ugly abuse just for participating in a technical discussion.
> > 
> > Given the number of top level maintainers that signed off on the CoC
> > that are present in this forum, I had an expectation that this is a
> > forum where bad behaviour is not tolerated at all.  So I've waited a
> > couple of days to see if anyone in a project leadership position is
> > going to say something about this comment.....
> > 
> > <silence>
> > 
> > The deafening silence of tacit acceptance is far more damning than
> > the high pitched squeal of Linus's childish taunts.
> 
> Well, let's face it: it's a pretty low level taunt and it wasn't aimed
> at you (or indeed anyone on the thread that I could find) and it was
> backed by technical argument in the next sentence.  We all have a
> tendency to let off steam about stuff in general not at people in
> particular as you did here:
> 
> https://lore.kernel.org/ksummit/ZP+vcgAOyfqWPcXT@dread.disaster.area/
> 
> But I didn't take it as anything more than a rant about AI in general
> and syzbot in particular and certainly I didn't assume it was aimed at
> me or anyone else.
> 
> If everyone reached for the code of conduct when someone had a non-
> specific rant using colourful phraseology, we'd be knee deep in
> complaints, which is why we tend to be more circumspect when it
> happens.

It's the kind of response that intimidates some into not participating.
Thanks-
Bill

> 
> James
> 
> 

