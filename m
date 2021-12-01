Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF646566B
	for <lists+linux-fsdevel@lfdr.de>; Wed,  1 Dec 2021 20:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352687AbhLAT3n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 1 Dec 2021 14:29:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352999AbhLAT3B (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 1 Dec 2021 14:29:01 -0500
Received: from fieldses.org (fieldses.org [IPv6:2600:3c00:e000:2f7::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEDF0C0613FD;
        Wed,  1 Dec 2021 11:25:39 -0800 (PST)
Received: by fieldses.org (Postfix, from userid 2815)
        id 3AE996EE9; Wed,  1 Dec 2021 14:25:38 -0500 (EST)
DKIM-Filter: OpenDKIM Filter v2.11.0 fieldses.org 3AE996EE9
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fieldses.org;
        s=default; t=1638386738;
        bh=p1UYy80uL5utaiaZlBfLiofBHpmuxeXPtPb9zmo0MSw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tQy9atlsw5Ir6k2o0l/Yo45zWX5B8qnf8WBm0Ihq08UUvtFR5PO8Jq24Dcr5KwQPB
         W+jUdCjokb2Le1tYTRoIN8+tn9oH2wT2DK8bUwsHZLieitOaqisxzqmjA2FWdzDzb2
         /zE5/s6i0cAPOqCDU/k3CiZ7JjeDQSzOH1DLmqXU=
Date:   Wed, 1 Dec 2021 14:25:38 -0500
From:   Bruce Fields <bfields@fieldses.org>
To:     dai.ngo@oracle.com
Cc:     Chuck Lever III <chuck.lever@oracle.com>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>
Subject: Re: [PATCH RFC v5 0/2] nfsd: Initial implementation of NFSv4
 Courteous Server
Message-ID: <20211201192538.GD26415@fieldses.org>
References: <e1093e42-2871-8810-de76-58d1ea357898@oracle.com>
 <C9C6AEC1-641C-4614-B149-5275EFF81C3D@oracle.com>
 <22000fe0-9b17-3d88-1730-c8704417cb92@oracle.com>
 <B42B0F9C-57E2-4F58-8DBD-277636B92607@oracle.com>
 <6f5a060d-17f6-ee46-6546-1217ac5dfa9c@oracle.com>
 <20211130153211.GB8837@fieldses.org>
 <f6a948a7-32d6-da9a-6808-9f2f77d5f792@oracle.com>
 <20211201143630.GB24991@fieldses.org>
 <20211201145118.GA26415@fieldses.org>
 <dbe51234-3e85-fb1d-ceb5-31b2ab9d829d@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dbe51234-3e85-fb1d-ceb5-31b2ab9d829d@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 01, 2021 at 10:47:28AM -0800, dai.ngo@oracle.com wrote:
> 
> On 12/1/21 6:51 AM, Bruce Fields wrote:
> >Do you have a public git tree with your latest patches?
> 
> No, I don't but I can push it to Chuck's public tree. I need to prepare the patch.

OK, it's not a big deal.--b.
