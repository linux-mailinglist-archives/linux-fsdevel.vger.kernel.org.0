Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA956390DF2
	for <lists+linux-fsdevel@lfdr.de>; Wed, 26 May 2021 03:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbhEZBft (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 May 2021 21:35:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:55796 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230306AbhEZBft (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 May 2021 21:35:49 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id AED7A61284;
        Wed, 26 May 2021 01:34:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621992858;
        bh=BMqhUn3QBTF7UF5p71DOXEhX1Qk67aVQmnnbST+XitQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IJrt95JJ7ujgteD7s21qN9v3nI9dtqZRLeXYOrGU2R4n6FqWaDMHMxdRtEYFa8lEG
         YdSs6j1SLHYc26ckuFRDVMOn5ps75hS/MFwpaWGDpr3gOHSyYIDLamghX265rbuLEc
         VEDEscl4Psc/ff7aSg+FCMjbefgBoE191Rf/WMVaNpergQslR1/9veVmaSbxNohy7l
         lQSXcgPAX8otgdnVTtlYRjo2XsjjvirmHTR4kPXB/pn2Gi0LxqK5Tx6Tk560byaEl5
         ioJDK2CUsT+jEtS2vXsiKDEOqaf+HFEngWZ9UCjdh47+Ixqb8lEY6PWOAory3EdM2R
         ixnTVT4bFWQoA==
Date:   Tue, 25 May 2021 18:34:18 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     Kent Overstreet <kent.overstreet@gmail.com>
Cc:     fstests@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-bcachefs@vger.kernel.org
Subject: Re: [PATCH v2 4/4] generic/269: add _check_scratch_fs
Message-ID: <20210526013418.GK202095@locust>
References: <20210525221955.265524-1-kent.overstreet@gmail.com>
 <20210525221955.265524-8-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210525221955.265524-8-kent.overstreet@gmail.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, May 25, 2021 at 06:19:55PM -0400, Kent Overstreet wrote:
> This probably should be in every test that uses the scratch device.

Um, it is -- ./check runs fsck on the test and scratch devices if you
_require_test or _require_scratch'd them (which this test does).  What
weird output did you see?

--D

> Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
> ---
>  tests/generic/269 | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/tests/generic/269 b/tests/generic/269
> index aec573c06a..484a26f89f 100755
> --- a/tests/generic/269
> +++ b/tests/generic/269
> @@ -63,5 +63,7 @@ if ! _scratch_unmount; then
>  	status=1
>  	exit
>  fi
> +
> +_check_scratch_fs
>  status=0
>  exit
> -- 
> 2.32.0.rc0
> 
