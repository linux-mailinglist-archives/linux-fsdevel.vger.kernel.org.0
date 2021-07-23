Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44FDA3D4019
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 20:01:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229539AbhGWRVD (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 13:21:03 -0400
Received: from mail.kernel.org ([198.145.29.99]:53276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229455AbhGWRVA (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 13:21:00 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id BDB5C60ED7;
        Fri, 23 Jul 2021 18:01:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627063293;
        bh=VHCSeZJjKJsnsMZa5G6+nO2ertF1iyega0AIgFlXcHw=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lexpHC2Xb8ad3XL+3ndSXyTqZCBNVOupFseIarel+Mmw5OcSv9az58MqEnExtejJS
         3kaAnuIaM57aLk4BVPWKP3Nnc8/z0ZjNlvJnmDc+4h0GnHvAgCvY3Ukm9JO4jkwjQI
         WMTA2GZxlWSQk/Ti4Q8xoYLzQEpHDiCZFfXanHEQDMOrtDhO4Q9KAgSyyemguNQD3m
         LEtDcaOqlFGMOr6ayPdTfwFtRT/2SvVwd/nbQ7i6HNGnnny1hqpLV+ldD8YekCDsA/
         fGQABKNeLLQjj9N8RSi8lbmw54ozHRvSp3dk2+pxKS7a9nV+2PSYgt1S1PpwhObLzs
         NkrLFmd/gCYVw==
Message-ID: <f456cc25cd31789cd2cdbbee1a8bb10859b849ab.camel@kernel.org>
Subject: Re: [PATCH] fscrypt: align Base64 encoding with RFC 4648 base64url
From:   Jeff Layton <jlayton@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Date:   Fri, 23 Jul 2021 14:01:31 -0400
In-Reply-To: <YPp667igbuyElEcD@sol.localdomain>
References: <20210718000125.59701-1-ebiggers@kernel.org>
         <YPp667igbuyElEcD@sol.localdomain>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, 2021-07-23 at 01:16 -0700, Eric Biggers wrote:
> On Sat, Jul 17, 2021 at 07:01:25PM -0500, Eric Biggers wrote:
> > 
> > There have been two attempts to copy the fscrypt Base64 code into lib/
> > (https://lkml.kernel.org/r/20200821182813.52570-6-jlayton@kernel.org and
> > https://lkml.kernel.org/r/20210716110428.9727-5-hare@suse.de), and both
> > have been caught up by the fscrypt Base64 variant being nonstandard and
> > not properly documented.  Also, the planned use of the fscrypt Base64
> > code in the CephFS storage back-end will prevent it from being changed
> > later (whereas currently it can still be changed), so we need to choose
> > an encoding that we're happy with before it's too late.
> 
> Jeff, any thoughts on whether this is the variant of Base64 you want to use in
> the CephFS fscrypt support?
> 

I can't do a deep review today, but this looks fine at first glance.

We're not too particular about what sort of encoding we use for ceph. We
just need something that is consistent and results in valid POSIX
filenames. Changing it to better adhere to the standard sounds like a
good thing to do.

Thanks,
-- 
Jeff Layton <jlayton@kernel.org>

