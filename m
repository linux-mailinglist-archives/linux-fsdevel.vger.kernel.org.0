Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 84C8A17C54B
	for <lists+linux-fsdevel@lfdr.de>; Fri,  6 Mar 2020 19:23:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726378AbgCFSXE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 6 Mar 2020 13:23:04 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:48132 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgCFSXE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 6 Mar 2020 13:23:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=gjcMLMQ0YOmlfbrWMSlcaCd1DZoiex3FbrOJcHyyxFE=; b=GZhjSqMZZbIrSju7YQjqH/WhZm
        VNdNpiUI3aY1YMngp/GkjF3q/4JSWbSwPfYhM7w5xDJKukla5piaxuN3Vw+1eUmRIkX68u/Ysheeg
        ZA9uO3/uX5q44bUuRFBgZf7HqS0095BER+6kl0UKKi4QqQOolS+ZWBZbSWGxiOMREnJc1NYvTKvPt
        nBrgkidp4c8E44KhUubrZezkZQqMXP+SDyouW2IEbeeW/B905Nb69tmfDpoD0lntnEZF2RrN16HDQ
        YPln1saxQNZl9+MJGD7p8pPYedZlPHER3FqG81dcHs8Sj18KhuO5WHHBvI2MXPHvMYaWjaVPIII32
        z1Q4TCmA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jAHck-0001KR-GL; Fri, 06 Mar 2020 18:23:02 +0000
Date:   Fri, 6 Mar 2020 10:23:02 -0800
From:   Matthew Wilcox <willy@infradead.org>
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Josef Bacik <josef@toxicpanda.com>,
        lsf-pc <lsf-pc@lists.linuxfoundation.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        linux-mm@kvack.org, linux-xfs@vger.kernel.org,
        Btrfs BTRFS <linux-btrfs@vger.kernel.org>, bpf@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: [LSFMMBPF TOPIC] Killing LSFMMBPF
Message-ID: <20200306182302.GA31215@bombadil.infradead.org>
References: <b506a373-c127-b92e-9824-16e8267fc910@toxicpanda.com>
 <20200306160548.GB25710@bombadil.infradead.org>
 <1583516279.3653.71.camel@HansenPartnership.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1583516279.3653.71.camel@HansenPartnership.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 06, 2020 at 09:37:59AM -0800, James Bottomley wrote:
> Can I just inject a dose of reality here:  The most costly thing is
> Venue rental (which comes with a F&B minimum) and the continuous Tea
> and Coffee.  Last year for Plumbers, the venue cost us $37k and the
> breaks $132k (including a lunch buffet, which was a requirement of the
> venue rental).  Given we had 500 attendees, that, alone is $340 per
> head already.  Now we could cut out the continuous tea and coffee ...
> and the espresso machines you all raved about last year cost us about
> $7 per shot.  But it's not just this, it's also AV (microphones and
> projectors) and recording, and fast internet access.  That all came to
> about $100k last year (or an extra $200 per head).  So you can see,
> running at the level Plumbers does you're already looking at $540 a
> head, which, co-incidentally is close to our attendee fee.  To get to
> $300 per head, you lot will have to give up something in addition to
> the espresso machines, what is it to be?

I was basing that on https://www.bsdcan.org/2020/registration.php
which is a ~200 person conference, charging $200 for 2 days.  They
provide morning & afternoon snacks as well as lunch and coffee.
