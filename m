Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ACEE41F801
	for <lists+linux-fsdevel@lfdr.de>; Sat,  2 Oct 2021 01:03:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231518AbhJAXFS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 Oct 2021 19:05:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbhJAXFP (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 Oct 2021 19:05:15 -0400
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF2AC061775;
        Fri,  1 Oct 2021 16:03:30 -0700 (PDT)
Received: by fieldses.org (Postfix, from userid 2815)
        id 7C73535BB; Fri,  1 Oct 2021 19:03:28 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 7C73535BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1633129408;
        bh=V1GHE3uavOurkDlrDPf9POqwiUwDJv9YiCuuJRnPZqE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eREhfBio/MhCmt0d7I8kIWKdS85JKtdeQJOOCDkGdWIStRptWqP51z/1y6CRYhO4r
         I+pzXjKuUTmfrSs/UZd8a03x2PDwCE4RWGdZrZtuV5sNe6gX9ffX+EGAV/b5Lj8979
         vDhJXGVPSclNJAZ0oa9r1t50gbPaHQePu2tugyfQ=
Date:   Fri, 1 Oct 2021 19:03:28 -0400
From:   "J. Bruce Fields" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     chuck.lever@oracle.com, linux-nfs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211001230328.GA13268@fieldses.org>
References: <20210929005641.60861-1-dai.ngo@oracle.com>
 <20211001205327.GN959@fieldses.org>
 <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a6c9ba13-43d7-4ea9-e05d-f454c2c9f4c2@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 01, 2021 at 02:41:55PM -0700, dai.ngo@oracle.com wrote:
> 
> On 10/1/21 1:53 PM, J. Bruce Fields wrote:
> >On Tue, Sep 28, 2021 at 08:56:39PM -0400, Dai Ngo wrote:
> >>Hi Bruce,
> >>
> >>This series of patches implement the NFSv4 Courteous Server.
> >Apologies, I keep meaning to get back to this and haven't yet.
> >
> >I do notice I'm seeing a timeout on pynfs 4.0 test OPEN18.
> 
> It's weird, this test passes on my system:
> 
> 
> [root@nfsvmf25 nfs4.0]# ./testserver.py $server --rundeps -v OPEN18
> INIT     st_setclientid.testValid                                 : RUNNING
> INIT     st_setclientid.testValid                                 : PASS
> MKFILE   st_open.testOpen                                         : RUNNING
> MKFILE   st_open.testOpen                                         : PASS
> OPEN18   st_open.testShareConflict1                               : RUNNING
> OPEN18   st_open.testShareConflict1                               : PASS
> **************************************************
> INIT     st_setclientid.testValid                                 : PASS
> OPEN18   st_open.testShareConflict1                               : PASS
> MKFILE   st_open.testOpen                                         : PASS
> **************************************************
> Command line asked for 3 of 673 tests
> Of those: 0 Skipped, 0 Failed, 0 Warned, 3 Passed
> [root@nfsvmf25 nfs4.0]#
> 
> Do you have a network trace?

Yeah, weirdly, I think it's failing only when I run it with all the
other pynfs tests, not when I run it alone.  I'll check again and see if
I can get a trace, probably next week.

--b.
