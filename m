Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 96DCC8AAC3
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Aug 2019 00:53:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727038AbfHLWxt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 12 Aug 2019 18:53:49 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45165 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726681AbfHLWxt (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 12 Aug 2019 18:53:49 -0400
Received: from callcc.thunk.org (guestnat-104-133-9-109.corp.google.com [104.133.9.109] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id x7CMrSAa021619
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Aug 2019 18:53:30 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 3DFFB4218EF; Mon, 12 Aug 2019 18:53:28 -0400 (EDT)
Date:   Mon, 12 Aug 2019 18:53:28 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net,
        linux-mtd@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-crypto@vger.kernel.org, keyrings@vger.kernel.org,
        linux-api@vger.kernel.org, Satya Tangirala <satyat@google.com>,
        Paul Crowley <paulcrowley@google.com>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [PATCH v8 07/20] fscrypt: move v1 policy key setup to
 keysetup_v1.c
Message-ID: <20190812225328.GF28705@mit.edu>
References: <20190805162521.90882-1-ebiggers@kernel.org>
 <20190805162521.90882-8-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190805162521.90882-8-ebiggers@kernel.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Aug 05, 2019 at 09:25:08AM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> In preparation for introducing v2 encryption policies which will find
> and derive encryption keys differently from the current v1 encryption
> policies, move the v1 policy-specific key setup code from keyinfo.c into
> keysetup_v1.c.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>

Looks good, you can add

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

