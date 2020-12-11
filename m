Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 468DF2D7DCA
	for <lists+linux-fsdevel@lfdr.de>; Fri, 11 Dec 2020 19:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391885AbgLKSM1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 11 Dec 2020 13:12:27 -0500
Received: from mail.kernel.org ([198.145.29.99]:44520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391883AbgLKSMK (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 11 Dec 2020 13:12:10 -0500
Date:   Fri, 11 Dec 2020 10:11:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607710290;
        bh=EuItIQRWGjX54krCJ9+4dq0zGE0A/JZn1F+uuHwpfXg=;
        h=From:To:Cc:Subject:References:In-Reply-To:From;
        b=t9i/3F/MQPuFeRHn+sL+mUFuulPFN03wJau76tkopnzT/ZLY4dfKVDxB6GKK52QL1
         kd8m1R98/P6OsgnNYNungpFqrJJJw7W1EA98WFZJjSirmXlafP9Q9z/vSWKbyYHJwv
         hGHmpMZZRiS49hKKr24rb9AQ/y0j6cj6/9N2EqS1XdQTixCEuiLon9ac5tfXXcBvhC
         Y9oqQEtx+N/drwFAZgZlOvJ1cuG4U0aGV2mWhGhpSyRcZk6finLaEu+bewViEsRFJ/
         24r0eUNQKI5F6K1HXdLwBZfYw0J+NLAPTokJDOtO6v8M88X8SOQu+sxcfTZQM0Eh7v
         I+BGmM3YIEp1Q==
From:   Eric Biggers <ebiggers@kernel.org>
To:     Chirantan Ekbote <chirantan@chromium.org>
Cc:     Miklos Szeredi <miklos@szeredi.hu>, linux-fsdevel@vger.kernel.org,
        Dylan Reid <dgreid@chromium.org>,
        Suleiman Souhlal <suleiman@chromium.org>,
        fuse-devel@lists.sourceforge.net, linux-fscrypt@vger.kernel.org
Subject: Re: [PATCH v2 1/2] fuse: Move ioctl length calculation to a separate
 function
Message-ID: <X9O2UIUU+DnPEDlg@sol.localdomain>
References: <20201207040303.906100-1-chirantan@chromium.org>
 <20201208093808.1572227-1-chirantan@chromium.org>
 <20201208093808.1572227-2-chirantan@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201208093808.1572227-2-chirantan@chromium.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 08, 2020 at 06:38:07PM +0900, Chirantan Ekbote wrote:
> This will make it more readable when we add support for more ioctls.
> 
> Signed-off-by: Chirantan Ekbote <chirantan@chromium.org>

Reviewed-by: Eric Biggers <ebiggers@google.com>
