Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E0973D366F
	for <lists+linux-fsdevel@lfdr.de>; Fri, 23 Jul 2021 10:17:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234524AbhGWHgO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 23 Jul 2021 03:36:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:55622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234488AbhGWHgL (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 23 Jul 2021 03:36:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id DBB2560EBD;
        Fri, 23 Jul 2021 08:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627028205;
        bh=FmcsTWKVBtnIpV3kMjIYbVPEWxN8HccIeY7NweLv3fc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=p83qFCUO8L5H8TZ0pJz+hXz6JmnLt1esXuHZQ1efs1LWA9Opu0oBskpMKhw8FGdEn
         nRBdyz7JfEQ9qdkIcTf1s6jWVmXGJz0B10YnsGkoqu0Z+PT8MNdItnRK5/riqJ3n3N
         dMEmHj1FJUqoWauRhi1kqPUaFo4eMLlPmU5/k2LHvRDGmayVlV1MmoN75lE4I69XcO
         wzI4Wbxrh+pZFV+3FZfLhUXTIWs12fPDDRqUdqsH3RGGbE/sYaa1SZjPi0URUsmrV4
         MyrBojV249e4n2k4um2W07m0rzgP3013tggjYWhp30V03kOWm9xowzoMT08vWHlk2I
         2Lox9cg4HZL2A==
Date:   Fri, 23 Jul 2021 01:16:43 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Hannes Reinecke <hare@suse.de>
Subject: Re: [PATCH] fscrypt: align Base64 encoding with RFC 4648 base64url
Message-ID: <YPp667igbuyElEcD@sol.localdomain>
References: <20210718000125.59701-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210718000125.59701-1-ebiggers@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Jul 17, 2021 at 07:01:25PM -0500, Eric Biggers wrote:
> 
> There have been two attempts to copy the fscrypt Base64 code into lib/
> (https://lkml.kernel.org/r/20200821182813.52570-6-jlayton@kernel.org and
> https://lkml.kernel.org/r/20210716110428.9727-5-hare@suse.de), and both
> have been caught up by the fscrypt Base64 variant being nonstandard and
> not properly documented.  Also, the planned use of the fscrypt Base64
> code in the CephFS storage back-end will prevent it from being changed
> later (whereas currently it can still be changed), so we need to choose
> an encoding that we're happy with before it's too late.

Jeff, any thoughts on whether this is the variant of Base64 you want to use in
the CephFS fscrypt support?

- Eric
