Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717C421F300
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jul 2020 15:51:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726934AbgGNNvE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 14 Jul 2020 09:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725906AbgGNNvE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 14 Jul 2020 09:51:04 -0400
Received: from ms.lwn.net (ms.lwn.net [IPv6:2600:3c01:e000:3a1::42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B057FC061755;
        Tue, 14 Jul 2020 06:51:01 -0700 (PDT)
Received: from lwn.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ms.lwn.net (Postfix) with ESMTPSA id 1A3A560C;
        Tue, 14 Jul 2020 13:51:01 +0000 (UTC)
Date:   Tue, 14 Jul 2020 07:51:00 -0600
From:   Jonathan Corbet <corbet@lwn.net>
To:     Chris Packham <chris.packham@alliedtelesis.co.nz>
Cc:     adobriyan@gmail.com, mchehab+huawei@kernel.org,
        linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] doc: filesystems: proc: Remove stray '-' preventing
 table output
Message-ID: <20200714075100.41db8cea@lwn.net>
In-Reply-To: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
References: <20200714090644.13011-1-chris.packham@alliedtelesis.co.nz>
Organization: LWN.net
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, 14 Jul 2020 21:06:43 +1200
Chris Packham <chris.packham@alliedtelesis.co.nz> wrote:

> When processing proc.rst sphinx complained
> 
>   Documentation/filesystems/proc.rst:548: WARNING: Malformed table.
>   Text in column margin in table line 29.
> 
> This caused the entire table to be dropped. Removing the stray '-'
> resolves the error and produces the desired table.
> 
> Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
> ---
>  Documentation/filesystems/proc.rst | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/Documentation/filesystems/proc.rst b/Documentation/filesystems/proc.rst
> index 996f3cfe7030..53a0230a08e2 100644
> --- a/Documentation/filesystems/proc.rst
> +++ b/Documentation/filesystems/proc.rst
> @@ -545,7 +545,7 @@ encoded manner. The codes are the following:
>      hg    huge page advise flag
>      nh    no huge page advise flag
>      mg    mergable advise flag
> -    bt  - arm64 BTI guarded page
> +    bt    arm64 BTI guarded page
>      ==    =======================================

Which tree are you looking at?  Mauro fixed this back in June...

Thanks,

jon
