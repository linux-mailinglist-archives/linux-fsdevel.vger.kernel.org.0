Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE37C2EC6FD
	for <lists+linux-fsdevel@lfdr.de>; Thu,  7 Jan 2021 00:41:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbhAFXlS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 6 Jan 2021 18:41:18 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:60437 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726918AbhAFXlS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 6 Jan 2021 18:41:18 -0500
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id D05FD14B3;
        Wed,  6 Jan 2021 18:40:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Wed, 06 Jan 2021 18:40:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=anarazel.de; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=fm3; bh=n5SmyEUKkQ7qERAis2ZaaktUbKh
        4cYFmBEpwHyqlAFw=; b=kHvX0HT4JwMXX9ZXBdMY6+ppwTMBzcFa/noS3E7R7LA
        rIEt2BYOivw6sm3TvMXh+/Su+B8gBZMuZnASFMWzh8CmH22/QobA/cdaNoM0Nvz2
        WrR6kioaEU8vWLJpvk1bSddNc5adfWk25W+pia9dEfAofzNmZQTl+ySh+Ck6w9Gx
        yqYPkUzKIIBfB+C2M1V02ttRPH5RqstR2MkR/JQ6lqFkHVf/hCvOOy6aMou4GqAx
        zXq4kUC5/dqidzy7OVa1GmUV5mjLIkNTm2PigQXdL2HhN1nYLNNSM2kAKE6c0qpW
        mZKNSgMOQiEHpKRHthNbgzv/MnMFsTgRS0O1oIvziXw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:in-reply-to
        :message-id:mime-version:references:subject:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; bh=n5SmyE
        UKkQ7qERAis2ZaaktUbKh4cYFmBEpwHyqlAFw=; b=iv1IZft2dhtPMs6a0ZYLDL
        KhOC4nlPgNHnErGjdxhRWfrhWZOdvDZEM/YDFhWN4kcj74JcIH/LDiHSnkj7QZNg
        lMo5531yhZtV5wMdF0IyZSlif3ag33JCBPd4PlVTh7Piy6wgR2O7rCMzygyHYA1z
        YM3d4ZTjFMaONAvrHVAtyRXicMBy9fw7T0E/X79MpoIKUBdl+JTVr7KNwL1Rng9e
        Vof3W1Z9xZPj18gBRFU/4xqIFotwytro4qstNBfbeK4DFgORHNIgs/sPIBso3fz1
        jtPIF7CQGePsQ+TuSHhmY/ENvb6iRA+y9K4AjMiJuk7iojg6egRUe0L+5RpZ90/g
        ==
X-ME-Sender: <xms:W0r2X7rAzlVuas5cUtL18mZ-thcn0GqvAcKmmjA4KHAiZIdYcy0MmQ>
    <xme:W0r2X1pHnYnne3KwsaKtu4-BrJk368hozS6Hr-sodAWp7UJr5N0n-ENiR0dGIU1sB
    mTTgml4X-Y4NqR80g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedujedrvdegtddgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtvdenucfhrhhomheptehnughrvghsucfhrhgvuhhnugcuoegrnhgurhgvshesrghn
    rghrrgiivghlrdguvgeqnecuggftrfgrthhtvghrnhepudekhfekleeugeevteehleffff
    ejgeelueduleeffeeutdelffeujeffhfeuffdunecukfhppeeijedrudeitddrvddujedr
    vdehtdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grnhgurhgvshesrghnrghrrgiivghlrdguvg
X-ME-Proxy: <xmx:W0r2X4OVarAF5pkNoPPJfRSaKF5prZowNUhVQG6WJGIWmkZpOwSoGg>
    <xmx:W0r2X-7GXJMCO4u9msmbvbJKdY_jGVTuQiWjtFKEa-aVt85jmGtlGw>
    <xmx:W0r2X65L5hxClFtPVZ103Zx5xJkzd12sxACuzjbgQFCgyvjKHyYzbA>
    <xmx:W0r2X6HgoYGoUrWSu2CJ90EB_9XCqawa8ZPs2GkQxj1xI593B3ASnw>
Received: from intern.anarazel.de (c-67-160-217-250.hsd1.ca.comcast.net [67.160.217.250])
        by mail.messagingengine.com (Postfix) with ESMTPA id 0EE18240064;
        Wed,  6 Jan 2021 18:40:11 -0500 (EST)
Date:   Wed, 6 Jan 2021 15:40:09 -0800
From:   Andres Freund <andres@anarazel.de>
To:     Dave Chinner <david@fromorbit.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-block@vger.kernel.org
Subject: Re: fallocate(FALLOC_FL_ZERO_RANGE_BUT_REALLY) to avoid unwritten
 extents?
Message-ID: <20210106234009.b6gbzl7bjm2evxj6@alap3.anarazel.de>
References: <20201230062819.yinrrp6uwfegsqo3@alap3.anarazel.de>
 <20210106225201.GF331610@dread.disaster.area>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210106225201.GF331610@dread.disaster.area>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi,

On 2021-01-07 09:52:01 +1100, Dave Chinner wrote:
> On Tue, Dec 29, 2020 at 10:28:19PM -0800, Andres Freund wrote:
> > Which brings me to $subject:
> > 
> > Would it make sense to add a variant of FALLOC_FL_ZERO_RANGE that
> > doesn't convert extents into unwritten extents, but instead uses
> > blkdev_issue_zeroout() if supported?  Mostly interested in xfs/ext4
> > myself, but ...
> 
> We have explicit requests from users (think initialising large VM
> images) that FALLOC_FL_ZERO_RANGE must never fall back to writing
> zeroes manually.

That behaviour makes a lot of sense for quite a few use cases - I wasn't
trying to make it sound like it should not be available. Nor that
FALLOC_FL_ZERO_RANGE should behave differently.


> IOWs, while you might want FALLOC_FL_ZERO_RANGE to explicitly write
> zeros, we have users who explicitly don't want it to do this.

Right - which is why I was asking for a variant of FALLOC_FL_ZERO_RANGE
(jokingly named FALLOC_FL_ZERO_RANGE_BUT_REALLY in the subject), rather
than changing the behaviour.


> Perhaps we should add want FALLOC_FL_CONVERT_RANGE, which tells the
> filesystem to convert an unwritten range of zeros to a written range
> by manually writing zeros. i.e. you do FALLOC_FL_ZERO_RANGE to zero
> the range and fill holes using metadata manipulation, followed by
> FALLOC_FL_WRITE_RANGE to then convert the "metadata zeros" to real
> written zeros.

Yep, something like that would do the trick. Perhaps
FALLOC_FL_MATERIALIZE_RANGE?

Greetings,

Andres Freund
