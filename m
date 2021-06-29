Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 266443B77E7
	for <lists+linux-fsdevel@lfdr.de>; Tue, 29 Jun 2021 20:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235133AbhF2ShX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 29 Jun 2021 14:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbhF2ShW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 29 Jun 2021 14:37:22 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ADCC061760;
        Tue, 29 Jun 2021 11:34:54 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 4423C4F7D; Tue, 29 Jun 2021 14:34:54 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 4423C4F7D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1624991694;
        bh=YM8NDkujfPP5IsIJvA9We9ZdMH2TzJNTJJvh1RewvzM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yBi5OjHSb/ERDl1KqIOnDoANWia5Al6WzhMNXRRrl6m0hsPDyCBpnZmVGbGZEvCXD
         3TlLRi+HYSndEOIkQ3TuxBHNGOahfNG2VvGlJcL7IqEo8fTfDjJXFaTEiRQCBCvhp+
         zAvfckRQl+GP2s7lHYqbjHb1Rbk9yKyuJC/2if3s=
Date:   Tue, 29 Jun 2021 14:34:54 -0400
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     NeilBrown <neilb@suse.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "dai.ngo@oracle.com" <dai.ngo@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>
Subject: Re: automatic freeing of space on ENOSPC
Message-ID: <20210629183454.GB1926@fieldses.org>
References: <20210628194908.GB6776@fieldses.org>
 <9f1263b46d5c38b9590db1e2a04133a83772bc50.camel@hammerspace.com>
 <20210629011200.GA14733@fieldses.org>
 <162493102550.7211.15170485925982544813@noble.neil.brown.name>
 <CAOQ4uxj-YLrsvCE1d8+OEYQpfZeENK71OWR02G3JtLoZx92H1g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAOQ4uxj-YLrsvCE1d8+OEYQpfZeENK71OWR02G3JtLoZx92H1g@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 29, 2021 at 07:07:47AM +0300, Amir Goldstein wrote:
> To me, stale silly renamed files sounds like a problem worth fixing
> not as an excuse to create another similar problem.

Yeah, it's ugly, I'd like to fix it some day, but given that people have
lived with it since forever it's not the highest priority.

> w.r.t pre-ENOSPC notification, I don't know of such notification
> in filesystems. It exists for some thin-provisioned storage devices
> (thinp as well I think), but that is not very useful for nfsd.
> 
> OTOH, ENOSPC is rarely a surprising event.
> I believe you can get away with tunable for nfsd, such as
> % of available storage space that may consumed for
> "opportunistic caching".
> 
> Polling for available storage space every least time or so
> in case there are possibly forgotten unlinked files should be
> sufficient for any practical purpose IMO.

Makes sense, thanks for the perspective.

--b.
