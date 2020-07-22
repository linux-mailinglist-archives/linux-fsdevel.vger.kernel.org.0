Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 768A2229D98
	for <lists+linux-fsdevel@lfdr.de>; Wed, 22 Jul 2020 18:57:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729066AbgGVQ5f (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Jul 2020 12:57:35 -0400
Received: from mail.kernel.org ([198.145.29.99]:56990 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726736AbgGVQ5e (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Jul 2020 12:57:34 -0400
Received: from localhost (unknown [104.132.1.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2B5C0207CD;
        Wed, 22 Jul 2020 16:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595437054;
        bh=foafLTKTSs4eRv6H8DFW8ktlWYvdIzYz280w9TzcoZQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XAQyYh1QpMNzwzJvzhVIQQzkEjb96TUxGGx+IOEEUuuul6uaTDQ6wBXoBfdlrenHv
         M3vDPkxQ0CSYm7iQ9K8pcC4z2TTyTV/awLhUxetG6+hNGTSDBoJ9DsvCCFFvifzfdJ
         /c3bcsGQXknw8yBFX32wBWp5ul8DeISsD/1Z8yug=
Date:   Wed, 22 Jul 2020 09:57:33 -0700
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     Satya Tangirala <satyat@google.com>, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        linux-xfs@vger.kernel.org
Subject: Re: [PATCH v4 7/7] fscrypt: update documentation for direct I/O
 support
Message-ID: <20200722165733.GB3912099@google.com>
References: <20200720233739.824943-1-satyat@google.com>
 <20200720233739.824943-8-satyat@google.com>
 <20200721004701.GD7464@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200721004701.GD7464@sol.localdomain>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 07/20, Eric Biggers wrote:
> On Mon, Jul 20, 2020 at 11:37:39PM +0000, Satya Tangirala wrote:
> > Update fscrypt documentation to reflect the addition of direct I/O support
> > and document the necessary conditions for direct I/O on encrypted files.
> > 
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> 
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Jaegeuk Kim <jaegeuk@kernel.org>
