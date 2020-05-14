Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02CAC1D2FA2
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 14:26:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgENM0N (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 08:26:13 -0400
Received: from ms.lwn.net ([45.79.88.28]:47602 "EHLO ms.lwn.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725925AbgENM0N (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 08:26:13 -0400
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 7D1BC728;
        Thu, 14 May 2020 12:26:12 +0000 (UTC)
Date:   Thu, 14 May 2020 06:26:11 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Johannes Thumshirn <jth@kernel.org>
Cc:     David Sterba <dsterba@suse.cz>, linux-fsdevel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, Eric Biggers <ebiggers@google.com>,
        Richard Weinberger <richard@nod.at>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: Re: [PATCH v3 3/3] btrfs: document btrfs authentication
Message-ID: <20200514062611.563ec1ea@lwn.net>
In-Reply-To: <20200514092415.5389-4-jth@kernel.org>
References: <20200514092415.5389-1-jth@kernel.org>
        <20200514092415.5389-4-jth@kernel.org>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, 14 May 2020 11:24:15 +0200
Johannes Thumshirn <jth@kernel.org> wrote:

Quick question...

> Document the design, guarantees and limitations of an authenticated BTRFS
> file-system.
> 
> Cc: Jonathan Corbet <corbet@lwn.net>
> Signed-off-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
> ---
>  .../filesystems/btrfs-authentication.rst      | 168 ++++++++++++++++++
>  1 file changed, 168 insertions(+)
>  create mode 100644 Documentation/filesystems/btrfs-authentication.rst
> 
> diff --git a/Documentation/filesystems/btrfs-authentication.rst b/Documentation/filesystems/btrfs-authentication.rst
> new file mode 100644
> index 000000000000..f13cab248fc0
> --- /dev/null
> +++ b/Documentation/filesystems/btrfs-authentication.rst
> @@ -0,0 +1,168 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +:orphan:
> +

Why mark this "orphan" rather than just adding it to index.rst so it gets
built with the rest of the docs?

Thanks,

jon
