Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A85946DA4F
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Dec 2021 18:45:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235864AbhLHRtB (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Dec 2021 12:49:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhLHRs7 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:48:59 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06D51C061746;
        Wed,  8 Dec 2021 09:45:28 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id B6D436EE1; Wed,  8 Dec 2021 12:45:26 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org B6D436EE1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638985526;
        bh=TU3X9930jdf2KYWi83gb5k5mnvsBsLDkX8SGaXSZjBw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xp3m5ZTgi2HxlIwJuc5iiTROgsK5GFYGLXZfckTpXo+6Pb4YpmLeA7694DImglg5I
         UyEZgGIuOp7vjescTaHcfx9Uk8oNnaZbBkxgddp5R4aKOVhnsM7aeM1accbClksk+P
         D29iRojDEH8TgJRMqgSBf0H+GzJ0OuJCx2Uw7d+Q=
Date:   Wed, 8 Dec 2021 12:45:26 -0500
From:   "bfields@fieldses.org" <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        "chuck.lever@oracle.com" <chuck.lever@oracle.com>,
        "linux-nfs@vger.kernel.org" <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v6 2/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211208174526.GB29555@fieldses.org>
References: <20211206175942.47326-1-dai.ngo@oracle.com>
 <20211206175942.47326-3-dai.ngo@oracle.com>
 <4025C4F6-258F-4A2E-8715-05FD77052275@oracle.com>
 <f6d65309-6679-602a-19b8-414ce29c691a@oracle.com>
 <ba637e0c64b6a2b53c8b5bf197ce02d239cdc0d2.camel@hammerspace.com>
 <605c2aef-3140-6e1a-4953-fd318dbcc277@oracle.com>
 <20211208163937.GA29555@fieldses.org>
 <cdf6317b-aa42-539a-bc7f-3150e83cbc60@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cdf6317b-aa42-539a-bc7f-3150e83cbc60@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 08, 2021 at 09:29:31AM -0800, dai.ngo@oracle.com wrote:
> Do you know if there is an option to specify a list of tests to run,
> instead of 'all'?

Yes, you can list the tests.  See the --help, --showflags, and
--showcodes options to testserver.py.

--b.
