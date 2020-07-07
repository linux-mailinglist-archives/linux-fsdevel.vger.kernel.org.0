Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE4CD2175F0
	for <lists+linux-fsdevel@lfdr.de>; Tue,  7 Jul 2020 20:08:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728183AbgGGSI4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 7 Jul 2020 14:08:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:60606 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727834AbgGGSI4 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 7 Jul 2020 14:08:56 -0400
Received: from sol.localdomain (c-107-3-166-239.hsd1.ca.comcast.net [107.3.166.239])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8917E20708;
        Tue,  7 Jul 2020 18:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1594145335;
        bh=296k3vE2kk+jFGLHJR3rGPowqbR7vIAKHN05TDFqEjU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tcnxsJRqHw+W02Km31hpUvdQQVBZ3J18CWf6ryCBIr/V+IM1gdxhjl3eLzTZYSMgT
         MvODHFpSVX+Wwb0vQtNnfA2DuOghtogMd7IjxrhhrEH+I5FZjHbwJAAoDzTOcPraB2
         h8r2enGEWKOpHzfobdAqJ29kADsewKrXCBoz5j9w=
Date:   Tue, 7 Jul 2020 11:08:54 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Satya Tangirala <satyat@google.com>, Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org
Subject: Re: [PATCH v4 0/4] Inline Encryption Support for fscrypt
Message-ID: <20200707180854.GB839@sol.localdomain>
References: <20200702015607.1215430-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702015607.1215430-1-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:56:03AM +0000, Satya Tangirala wrote:
> This patch series adds support for Inline Encryption to fscrypt, f2fs
> and ext4. It builds on the inline encryption support now present in
> the block layer, and has been rebased on v5.8-rc3. Note that Patches 1 and
> 2 can be applied independently of Patches 3 and 4 (and Patches 3 and 4 can
> be applied independently of each other).
> 
> This patch series previously went though a number of iterations as part
> of the "Inline Encryption Support" patchset (last version was v13:
> https://lkml.kernel.org/r/20200514003727.69001-1-satyat@google.com).
> 
> Patch 1 introduces the SB_INLINECRYPT sb options, which filesystems
> should set if they want to use blk-crypto for file content en/decryption.
> 
> Patch 2 adds inline encryption support to fscrypt. To use inline
> encryption with fscrypt, the filesystem must set the above mentioned
> SB_INLINECRYPT sb option. When this option is set, the contents of
> encrypted files will be en/decrypted using blk-crypto.
> 
> Patches 3 and 4 wire up f2fs and ext4 respectively to fscrypt support for
> inline encryption, and e.g ensure that bios are submitted with blocks
> that not only are contiguous, but also have continuous DUNs.

I've applied patches 1-3 to fscrypt.git#master for 5.9.
Any additional reviews are still appreciated though.

Ted and Andreas, can I get your Acked-by on patch 4?

- Eric
