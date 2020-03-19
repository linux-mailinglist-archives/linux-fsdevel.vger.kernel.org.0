Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A6E6F18C133
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 21:19:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgCSUTt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 16:19:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:54903 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726892AbgCSUTt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 16:19:49 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02JKJWmb024512
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 19 Mar 2020 16:19:33 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id C46BC420EBA; Thu, 19 Mar 2020 16:19:32 -0400 (EDT)
Date:   Thu, 19 Mar 2020 16:19:32 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
Subject: Re: [PATCH 2/4] ext4: wire up FS_IOC_GET_ENCRYPTION_NONCE
Message-ID: <20200319201932.GE1067245@mit.edu>
References: <20200314205052.93294-1-ebiggers@kernel.org>
 <20200314205052.93294-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200314205052.93294-3-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 14, 2020 at 01:50:50PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> This new ioctl retrieves a file's encryption nonce, which is useful for
> testing.  See the corresponding fs/crypto/ patch for more details.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
