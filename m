Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E927E492E0B
	for <lists+linux-fsdevel@lfdr.de>; Tue, 18 Jan 2022 20:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348510AbiARTAY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 18 Jan 2022 14:00:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244633AbiARTAX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 18 Jan 2022 14:00:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00E52C061574;
        Tue, 18 Jan 2022 11:00:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E0086152C;
        Tue, 18 Jan 2022 19:00:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2036C340E6;
        Tue, 18 Jan 2022 19:00:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642532422;
        bh=FOjqpugW7iHBFqdscviARPKMa6+ETkTBT3vGwr8GDsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kY+lW5knbAqjl45K6SEbMmJfEWgriOSPN0tS7tqgtbcKWlr4UkSFBfQPCaHDAmqH/
         krMP/B4LND7OjQtfOhITJk1It9IGMfp2P/XitkDBC5tNNWNEi4ynjWoFwCZCdQPR2t
         XvV+0qyYUf6DH+gi6pVp0bE0oiPEqZY8xgFGFFmaXE63Eeytp4wBRg3s4dCa2bhS/X
         e/q4NWUHRawRmYAR3leBrBJ/IsH/+6N0n2A8kd+uw5lB9jsHsBeQ8zg1bSxJmYVrwo
         tq59g8RWkMgRtOhsOaCzQRD/wz6S3ar+5lOejOaeLaJrMn8F8RMiCPZtGAsF+bPdVw
         j4oKu8Jks3l4w==
Date:   Tue, 18 Jan 2022 11:00:20 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: unicode: clean up the Kconfig symbol confusion
Message-ID: <YecORDbXEmi9cFwC@sol.localdomain>
References: <20220118065614.1241470-1-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220118065614.1241470-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 18, 2022 at 07:56:14AM +0100, Christoph Hellwig wrote:
> Turn the CONFIG_UNICODE symbol into a tristate that generates some always
> built in code and remove the confusing CONFIG_UNICODE_UTF8_DATA symbol.
> 
> Note that a lot of the IS_ENALBED() checks could be turned from cpp
> statements into normal ifs, but this change is intended to be fairly
> mechanic, so that should be cleaned up later.
> 
> Fixes: 2b3d04787012 ("unicode: Add utf8-data module")
> Reported-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me,

Reviewed-by: Eric Biggers <ebiggers@google.com>

- Eric
