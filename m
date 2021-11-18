Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE1294551C3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Nov 2021 01:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241985AbhKRAh5 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Nov 2021 19:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232441AbhKRAhx (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Nov 2021 19:37:53 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C4BC061570;
        Wed, 17 Nov 2021 16:34:54 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 200B66F29; Wed, 17 Nov 2021 19:34:54 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 200B66F29
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1637195694;
        bh=Eeu4rbRKl0T2p22IiAkImM73UAitliZizh9cQU4QtBY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Swg+uqhQyQuYm12D5uU2++eMndDK60w5efxr0+LOmItffVXFOu0vXY7nQIFwbedH1
         tpZ8g5jIcYfdHDPMytNwcfPhlSGQBTHFyfLO3VgEHxANeJwsVgsVR4scKZ/yM7drmU
         SdaNulErQh3cWg7mAfypJ4qoBTHQhKpzun1w9/Vw=
Date:   Wed, 17 Nov 2021 19:34:54 -0500
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211118003454.GA29787@fieldses.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
 <33c8ea5a-4187-a9fa-d507-a2dcec06416c@oracle.com>
 <20211117141433.GB24762@fieldses.org>
 <400143c8-c12a-6224-1b36-3e19f20a7ee4@oracle.com>
 <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <908ded64-6412-66d3-6ad5-429700610660@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 17, 2021 at 01:46:02PM -0800, dai.ngo@oracle.com wrote:
> 
> On 11/17/21 9:59 AM, dai.ngo@oracle.com wrote:
> >
> >On 11/17/21 6:14 AM, J. Bruce Fields wrote:
> >>On Tue, Nov 16, 2021 at 03:06:32PM -0800, dai.ngo@oracle.com wrote:
> >>>Just a reminder that this patch is still waiting for your review.
> >>Yeah, I was procrastinating and hoping yo'ud figure out the pynfs
> >>failure for me....
> >
> >Last time I ran 4.0 OPEN18 test by itself and it passed. I will run
> >all OPEN tests together with 5.15-rc7 to see if the problem you've
> >seen still there.
> 
> I ran all tests in nfsv4.1 and nfsv4.0 with courteous and non-courteous
> 5.15-rc7 server.
> 
> Nfs4.1 results are the same for both courteous and non-courteous server:
> >Of those: 0 Skipped, 0 Failed, 0 Warned, 169 Passed
> 
> Results of nfs4.0 with non-courteous server:
> >Of those: 8 Skipped, 1 Failed, 0 Warned, 577 Passed
> test failed: LOCK24
> 
> Results of nfs4.0 with courteous server:
> >Of those: 8 Skipped, 3 Failed, 0 Warned, 575 Passed
> tests failed: LOCK24, OPEN18, OPEN30
> 
> OPEN18 and OPEN30 test pass if each is run by itself.

Could well be a bug in the tests, I don't know.

> I will look into this problem.

Thanks!

--b.
