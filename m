Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1B72F3F8B
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 01:46:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731561AbhALW1P (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 12 Jan 2021 17:27:15 -0500
Received: from mail.kernel.org ([198.145.29.99]:57582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728776AbhALW1J (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 12 Jan 2021 17:27:09 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id AFEE723120;
        Tue, 12 Jan 2021 22:26:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610490387;
        bh=HkIz0HpTUapVV/p2ZBv78OcW6wacEuGAa5TYmHSHkEw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pYwOe9PAaRD+PIgNpxmhDDYFA6qj3cSaEw1CYzcu35JGayJ1VljKkvBMY6zBDQrB1
         S0kC+7kIM6G2I+OmPWrSbjrDwcYOMtKqdOimoSjKosrZ/Bq6JSa5Tdl0XUW2uVO6Tw
         fDr5YF1/GMnQhgQnngdx1CLEmSCv3/W/CN6nSZrlhIRMHZ1Pk0SqxQFLm82NHyje6C
         K2fVimwKy2yrYy4ysJCgODwEfAnBheJKq9qX8BJnOtz/oHHOwP0g4AYVayMN5nUnE+
         Wpv0jopRZTGgPf1qY3UmmILuSfQLPMGoY+mr9nQVQDYA1sNWu+oaQ0jOsT6Zbm46G8
         N4q7+sawLkvoQ==
Date:   Tue, 12 Jan 2021 14:26:26 -0800
From:   Jaegeuk Kim <jaegeuk@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org,
        Gabriel Krisman Bertazi <krisman@collabora.com>
Subject: Re: [PATCH RESEND] libfs: unexport generic_ci_d_compare() and
 generic_ci_d_hash()
Message-ID: <X/4iEjYU4+qEyA4d@google.com>
References: <20201228232529.45365-1-ebiggers@kernel.org>
 <X/30+5rc1bv39moX@sol.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <X/30+5rc1bv39moX@sol.localdomain>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 01/12, Eric Biggers wrote:
> On Mon, Dec 28, 2020 at 03:25:29PM -0800, Eric Biggers wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Now that generic_set_encrypted_ci_d_ops() has been added and ext4 and
> > f2fs are using it, it's no longer necessary to export
> > generic_ci_d_compare() and generic_ci_d_hash() to filesystems.
> > 
> > Reviewed-by: Gabriel Krisman Bertazi <krisman@collabora.com>
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > ---
> >  fs/libfs.c         | 8 +++-----
> >  include/linux/fs.h | 5 -----
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> 
> Jaegeuk, any interest in applying this given that this code came in through the
> f2fs tree in the first place?

Let me merge this. Please let me know if there's any objection.

> 
> - Eric
