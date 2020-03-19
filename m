Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E18B18C12B
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 21:19:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726864AbgCSUTp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 16:19:45 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54897 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725817AbgCSUTp (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:19:45 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02JKJEjG024401
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 16:19:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 38C4F420EBA; Thu, 19 Mar 2020 16:19:14 -0400 (EDT)
Date:   Thu, 19 Mar 2020 16:19:14 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 1/4] fscrypt: add FS_IOC_GET_ENCRYPTION_NONCE ioctl
Message-ID: <20200319201914.GD1067245@mit.edu>
References: <20200314205052.93294-1-ebiggers@kernel.org>
 <20200314205052.93294-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314205052.93294-2-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 14, 2020 at 01:50:49PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add an ioctl FS_IOC_GET_ENCRYPTION_NONCE which retrieves the nonce from
> an encrypted file or directory.  The nonce is the 16-byte random value
> stored in the inode's encryption xattr.  It is normally used together
> with the master key to derive the inode's actual encryption key.
> 
> The nonces are needed by automated tests that verify the correctness of
> the ciphertext on-disk.  Except for the IV_INO_LBLK_64 case, there's no
> way to replicate a file's ciphertext without knowing that file's nonce.
> 
> The nonces aren't secret, and the existing ciphertext verification tests
> in xfstests retrieve them from disk using debugfs or dump.f2fs.  But in
> environments that lack these debugging tools, getting the nonces by
> manually parsing the filesystem structure would be very hard.
> 
> To make this important type of testing much easier, let's just add an
> ioctl that retrieves the nonce.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
