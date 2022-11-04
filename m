Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031B3619928
	for <lists+linux-fsdevel@lfdr.de>; Fri,  4 Nov 2022 15:17:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232023AbiKDOR0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 4 Nov 2022 10:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbiKDORC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:17:02 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 684A231DEE;
        Fri,  4 Nov 2022 07:15:29 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 136so616694pga.1;
        Fri, 04 Nov 2022 07:15:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NVXIFPnkYLNtz+WK71CBaDlJ6YDcRXyyqXl+l7noR/k=;
        b=qwA2v6rw66ebOR+w/HANp8qkJWm4O+OOWYcxcWu74Sl3dae85aLACzJsPwyfwnKbnR
         fSQaOva2GIvFcMPQsmU/G/jy5FxBu8C8LNfQXgbxrwcC4Nqogd2LTWseHz3QZ2KtT78D
         d/zNYqCdWRsWUWso257zXcORsluwnpAsaCKYGLcpzbS9O7n/Qu6x5DDIyCa72vmJ2uOE
         HgHHVz44LCu2bhVTkL5YahDwjIgK895yhq4BzAtRF5n4F2etjru627LgR8jt0E1xmJKj
         g/IWqG2qXO9px2iD8kqD1XeljqXOox2OU0J3RT1ZAxk70Zo9dBfHEhHl1vnOAbe0zaN5
         g9nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NVXIFPnkYLNtz+WK71CBaDlJ6YDcRXyyqXl+l7noR/k=;
        b=dy+ZSBxFqYFO7dlplNWC1sTQUSn+PYGTeY6nYd1CZXlFMs6tGNGDG5/iqg93IUHuAA
         Ic0YyjM/xQo24EyMoJhWP5Xu7qG+hiAZPtIYGy4thXoHk+wU/PSpgECzkZnSxgDpyu5/
         ovzxYirXM7hJGW04xC1E5xEUJmeucHOYqEFBpyp+hxDoe2K+o9G0KQTj8cGCOBaTcPt+
         hFvyIoYv9jV8kP9sw3HsrhaUrzuumcLApmjbUN2jh5u9vMOWRi3BEIuS2YpxBWUydTWY
         MVilselVSz4Xc8OhJcV8rY0Y945ffZJBaBlmxYJoSFqipHWndIYoVZHaXaNztYtCSEJQ
         8JBw==
X-Gm-Message-State: ACrzQf2Pj5cK9AcJGgp9h2ylmzJF9rEHWbRxdpjvrXyyzARj1jdzQKa3
        zm8PIV6hhSb+9smHcN7E6/p2EIk17Yw=
X-Google-Smtp-Source: AMsMyM5SatMfEUAADF3uBBJMs9Fc6iZi09GGslaYwbJAh4kWKsryA9JCfgFYTHXWb84A+EuI24kS6w==
X-Received: by 2002:a65:464b:0:b0:42c:b0:9643 with SMTP id k11-20020a65464b000000b0042c00b09643mr31327212pgr.232.1667571328833;
        Fri, 04 Nov 2022 07:15:28 -0700 (PDT)
Received: from localhost ([2406:7400:63:f20b:f6ca:e236:f59f:8c18])
        by smtp.gmail.com with ESMTPSA id w65-20020a623044000000b005625ef68eecsm2808797pfw.31.2022.11.04.07.15.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 07:15:27 -0700 (PDT)
Date:   Fri, 4 Nov 2022 19:45:22 +0530
From:   "Ritesh Harjani (IBM)" <ritesh.list@gmail.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     "Darrick J. Wong" <djwong@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Dave Chinner <david@fromorbit.com>, linux-xfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        Aravinda Herle <araherle@in.ibm.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [RFC 2/2] iomap: Support subpage size dirty tracking to improve
 write performance
Message-ID: <20221104141522.upytpu7ay466uq56@riteshh-domain>
References: <cover.1666928993.git.ritesh.list@gmail.com>
 <886076cfa6f547d22765c522177d33cf621013d2.1666928993.git.ritesh.list@gmail.com>
 <20221028210422.GC3600936@dread.disaster.area>
 <Y19EXLfn8APg3adO@casper.infradead.org>
 <Y2IyTx0VwXMxzs0G@infradead.org>
 <Y2Kqahg+u2HzgeQG@magnolia>
 <Y2S+z2mFGRRy335L@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2S+z2mFGRRy335L@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 22/11/04 12:27AM, Christoph Hellwig wrote:
> On Wed, Nov 02, 2022 at 10:35:38AM -0700, Darrick J. Wong wrote:
> > Just so long as nobody imports that nonfeature of the bufferhead code
> > where dirtying an already dirty bufferhead skips marking the folio dirty
> > and writepage failures also fail to redirty the page.  That bit us hard
> > recently and I strongly prefer not to repeat that.
> 
> Yes, that absolutely needs to be avoided.

Sure, I am trying to discuss & investigate more in the same lines to avoid
the coherency problems (if any) in the other thread. 

i.e. to understand the rules between keeping the iomap->state[] dirty bitmap in 
sync with folio dirtiness (in folio_mark_dirty() / folio_cancel_dirty())
When are those required / what "external operations" could require 
folio_mark_dirty() to have a call to iomap_set_range_dirty() to dirty the
iop->state[] bitmaps.
Similary for marking it clean e.g. in folio_cancel_dirty().

In parallel I am looking into, to have a quick test case which could help me
replicate such scenario.

> 
> > > We can always optimize by having a bit for the fairly common all dirty
> > > case and only track and look at the array if that is no the case.
> > 
> > Yes, it would help to make the ranges in the bit array better defined
> > than the semi-opencoded logic there is now.  (I'm whining specifically
> > about the test_bit calls sprinkled around).
> 
> That is an absolutely requirement.  It was so obviosu to me that I
> didn't bother to restate it after two others already pointed it out :)

Yes. I will make those changes once rest of the things are sorted. 

> 
> > Once that's done it
> > shouldn't be hard to add one more bit for the all-dirty state.  Though
> > I'd want to see the numbers to prove that it saves us time anywhere.
> 
> We might be able to just use PG_private_2 in the page for now, but
> maybe just adding a flags field to the iomap_page might be a better
> idea, as the pageflags tend to have strange entanglements.

Sure, thanks for the suggestions. 

-ritesh
