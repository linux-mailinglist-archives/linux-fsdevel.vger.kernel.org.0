Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF76218E46
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 19:34:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgGHRey (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 13:34:54 -0400
Received: from mail.kernel.org ([198.145.29.99]:45946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725810AbgGHRey (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:34:54 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id EE22B206F6;
        Wed,  8 Jul 2020 17:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594229694;
        bh=n09ugl6WfqWNGruKtsGDgvdM0O8WqlobftThyJ0oyVo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tjBbRT/biosB1x+FYkug66Yhj2kJWisFl+iImfCbRhGlPgbns+b6Uh4j/OzMF/AKW
         VcfyCcgyvEWJ2cCIBonSl2YoUxIRw/2lRpkpreN+9TTP/QpLNM15VBmodOee2mP43J
         hW7JXhguxafrj1Ttet7Lj2FtiQQXTEqFd/WGYrGc=
Date:   Wed, 8 Jul 2020 10:34:52 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     tytso@mit.edu
Cc:     Satya Tangirala <satyat@google.com>, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v4 4/4] ext4: add inline encryption support
Message-ID: <20200708173452.GA32199@sol.localdomain>
References: <20200702015607.1215430-1-satyat@google.com>
 <20200702015607.1215430-5-satyat@google.com>
 <20200708171812.GF1627842@mit.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200708171812.GF1627842@mit.edu>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 08, 2020 at 01:18:12PM -0400, tytso@mit.edu wrote:
> On Thu, Jul 02, 2020 at 01:56:07AM +0000, Satya Tangirala wrote:
> > From: Eric Biggers <ebiggers@google.com>
> > 
> > Wire up ext4 to support inline encryption via the helper functions which
> > fs/crypto/ now provides.  This includes:
> > 
> > - Adding a mount option 'inlinecrypt' which enables inline encryption
> >   on encrypted files where it can be used.
> > 
> > - Setting the bio_crypt_ctx on bios that will be submitted to an
> >   inline-encrypted file.
> > 
> >   Note: submit_bh_wbc() in fs/buffer.c also needed to be patched for
> >   this part, since ext4 sometimes uses ll_rw_block() on file data.
> > 
> > - Not adding logically discontiguous data to bios that will be submitted
> >   to an inline-encrypted file.
> > 
> > - Not doing filesystem-layer crypto on inline-encrypted files.
> > 
> > Signed-off-by: Eric Biggers <ebiggers@google.com>
> > Co-developed-by: Satya Tangirala <satyat@google.com>
> > Signed-off-by: Satya Tangirala <satyat@google.com>
> 
> Reviewed-by: Theodore Ts'o <tytso@mit.edu>
> 

Thanks Ted.  I've applied this patch to fscrypt.git#master for 5.9.

- Eric
