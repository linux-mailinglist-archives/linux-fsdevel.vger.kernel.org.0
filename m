Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6EA2463AF3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Nov 2021 17:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239087AbhK3QIg (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 30 Nov 2021 11:08:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237992AbhK3QIf (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 30 Nov 2021 11:08:35 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 788FCC061574;
        Tue, 30 Nov 2021 08:05:14 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3F4946EEE; Tue, 30 Nov 2021 11:05:13 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3F4946EEE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638288313;
        bh=cHbL5qHnSStX2lSlAIwf+I4DfOwrhL1oM3WR9VI4S3o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yNYDEdfBfHzBqovgd7tBCIm6dUzSXokeR+upZbSJhUIoVgcTx7bpdcRFdCGL/UQvj
         /JwDQTJcjI++TJ9NdNLuVzGAI4Rv+2wMGz+nnkmuqqULy26qmCZZv76cSijX7MaS8g
         i25gWkuh4iQrPKUN5fEJKdgYxNRHGQZ/B8eUlUgY=
Date:   Tue, 30 Nov 2021 11:05:13 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     Dai Ngo <dai.ngo@oracle.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211130160513.GC8837@fieldses.org>
References: <1285F7E2-5D5F-4971-9195-BA664CAFF65F@oracle.com>
 <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <c8eef4ab9cb7acdf506d35b7910266daa9ded18c.camel@hammerspace.com>
 <0B58F7BC-A946-4FE6-8AC2-4C694A2120A3@oracle.com>
 <3afa1db55ccdf52eff7afb7b684eb961f878b68a.camel@hammerspace.com>
 <7548c291-cc0a-ed7a-ca37-63afe1d88c27@oracle.com>
 <FC3CB37C-8E5C-4DB0-B31F-0AA2B6D8B57F@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <FC3CB37C-8E5C-4DB0-B31F-0AA2B6D8B57F@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Nov 30, 2021 at 03:36:43PM +0000, Chuck Lever III wrote:
> I am a little concerned that we are trying to optimize a case
> that won't happen during practice. pynfs does not reflect any
> kind of realistic or reasonable client behavior -- it's designed
> to test very specific server operations.

I wonder how hard this problem would be to hit in normal use.  I mean, a
few hundred or a thousand clients doesn't sound that crazy.  This case
depends on an open deny, but you could hit the same problem with file
locks.  Would it be that weird to have a client trying to get a write
lock on a file read-locked by a bunch of other clients?

--b.
