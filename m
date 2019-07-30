Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 210DB79D71
	for <lists+linux-fsdevel@lfdr.de>; Tue, 30 Jul 2019 02:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729495AbfG3Aje (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 29 Jul 2019 20:39:34 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:38217 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728107AbfG3Ajd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 29 Jul 2019 20:39:33 -0400
Received: from callcc.thunk.org (96-72-102-169-static.hfc.comcastbusiness.net [96.72.102.169] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x6U0dDC1018151
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 29 Jul 2019 20:39:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 28F7A4202F5; Mon, 29 Jul 2019 20:39:12 -0400 (EDT)
Date:   Mon, 29 Jul 2019 20:39:12 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-api@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        Paul Crowley <paulcrowley@google.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v7 15/16] ubifs: wire up new fscrypt ioctls
Message-ID: <20190730003912.GB16445@mit.edu>
References: <20190726224141.14044-1-ebiggers@kernel.org>
 <20190726224141.14044-16-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190726224141.14044-16-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 26, 2019 at 03:41:40PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Wire up the new ioctls for adding and removing fscrypt keys to/from the
> filesystem, and the new ioctl for retrieving v2 encryption policies.
> 
> FS_IOC_REMOVE_ENCRYPTION_KEY also required making UBIFS use
> fscrypt_drop_inode().
> 
> For more details see Documentation/filesystems/fscrypt.rst and the
> fscrypt patches that added the implementation of these ioctls.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

					- Ted
