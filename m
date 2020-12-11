Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 66E152D7DCC
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 19:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392780AbgLKSM6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 13:12:58 -0500
Received: from mail.kernel.org ([198.145.29.99]:44894 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2392763AbgLKSMy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:12:54 -0500
Date:   Fri, 11 Dec 2020 10:12:12 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607710334;
        bh=mHRhHK/uPbQfjsIdHi95Bh/ntFtEmWkWCTpNoAuwNks=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=ba/F2KmiBuXm1Fa5WG+ONGi+feUdILjz3bwClOatJSHb/nxSffb7iVWbQjGQxhKJz
         hdXOxE0hvAHPzJVv9epsIPEW67tryUUuGz+VEcM6W3ohp0ceZ+Lqxs9KKbGX9wYILY
         hAxVI1TFoQq8pm7mWsoMCrkintqFcnNKVeJvovCBGol6uYP55DMRaimCzWjD5b9DTE
         IOEYIP9UC2ESaf6+gHaihtIu2OF2acSex7q+abe89VoZshfVl00zNpZjmyWn01OZhc
         OQUQJnPvRHPsjW0MNP8fttuejAGzkkhFZ20K2sQgb0jjNnLQhiSCrM/wDGsFq9ODtV
         pVBIZLy3YElyA==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v2 2/2] fuse: Support FS_IOC_GET_ENCRYPTION_POLICY_EX
Message-ID: <X9O2fJBjgKsOiIAy@sol.localdomain>
References: <20201207040303.906100-1-chirantan@chromium.org>
 <20201208093808.1572227-1-chirantan@chromium.org>
 <20201208093808.1572227-3-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208093808.1572227-3-chirantan@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 06:38:08PM +0900, Chirantan Ekbote wrote:
> Chrome OS would like to support this ioctl when passed through the fuse
> driver. However since it is dynamically sized, we can't rely on the
> length encoded in the command.  Instead check the `policy_size` field of
> the user provided parameter to get the max length of the data returned
> by the server.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>
