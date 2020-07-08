Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93E70218DE4
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 Jul 2020 19:07:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgGHRHl (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 Jul 2020 13:07:41 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:40114 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730143AbgGHRHj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 Jul 2020 13:07:39 -0400
Received: from callcc.thunk.org (pool-96-230-252-158.bstnma.fios.verizon.net [96.230.252.158])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 068H7EsQ018592
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 8 Jul 2020 13:07:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 157FB420304; Wed,  8 Jul 2020 13:07:14 -0400 (EDT)
Date:   Wed, 8 Jul 2020 13:07:14 -0400
From:   tytso@mit.edu
To:     Satya Tangirala <satyat@google.com>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-ext4@vger.kernel.org,
        Eric Biggers <ebiggers@google.com>
Subject: Re: [PATCH v4 1/4] fs: introduce SB_INLINECRYPT
Message-ID: <20200708170714.GD1627842@mit.edu>
References: <20200702015607.1215430-1-satyat@google.com>
 <20200702015607.1215430-2-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200702015607.1215430-2-satyat@google.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jul 02, 2020 at 01:56:04AM +0000, Satya Tangirala wrote:
> Introduce SB_INLINECRYPT, which is set by filesystems that wish to use
> blk-crypto for file content en/decryption. This flag maps to the
> '-o inlinecrypt' mount option which multiple filesystems will implement,
> and code in fs/crypto/ needs to be able to check for this mount option
> in a filesystem-independent way.
> 
> Signed-off-by: Satya Tangirala <satyat@google.com>
> Reviewed-by: Eric Biggers <ebiggers@google.com>

Reviewed-by: Theodore Ts'o <tytso@mit.edu>
