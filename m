Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 87FCA139DDA
	for <lists+linux-fsdevel@lfdr.de>; Tue, 14 Jan 2020 01:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729271AbgANAOZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 13 Jan 2020 19:14:25 -0500
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:45697 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728641AbgANAOZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 13 Jan 2020 19:14:25 -0500
Received: from callcc.thunk.org (guestnat-104-133-0-111.corp.google.com [104.133.0.111] (may be forged))
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 00E0E7YN032266
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 13 Jan 2020 19:14:08 -0500
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id AB74C4207DF; Mon, 13 Jan 2020 19:14:07 -0500 (EST)
Date:   Mon, 13 Jan 2020 19:14:07 -0500
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, Victor Hsieh <victorhsieh@google.com>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [PATCH v2] fs-verity: implement readahead of Merkle tree pages
Message-ID: <20200114001407.GO76141@mit.edu>
References: <20200106205533.137005-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200106205533.137005-1-ebiggers@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 06, 2020 at 12:55:33PM -0800, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> When fs-verity verifies data pages, currently it reads each Merkle tree
> page synchronously using read_mapping_page().
> 
> Therefore, when the Merkle tree pages aren't already cached, fs-verity
> causes an extra 4 KiB I/O request for every 512 KiB of data (assuming
> that the Merkle tree uses SHA-256 and 4 KiB blocks).  This results in
> more I/O requests and performance loss than is strictly necessary.
> 
> Therefore, implement readahead of the Merkle tree pages.

Looks good.   Feel free to add:

Reviewed-by: Theodore Ts'o <tytso@mit.edu>

(for the ext4 and fs/verity bits)

