Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E25DE357988
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Apr 2021 03:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbhDHBVS (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Apr 2021 21:21:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:49190 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229505AbhDHBVR (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Apr 2021 21:21:17 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 488C2610F8;
        Thu,  8 Apr 2021 01:21:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1617844867;
        bh=SZwaRz9bw31TyOFoXz91LVNrctbdlF8aOjkD1BA3KgY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIblNug5ssJgv+ZqcXo6QMNQm+wtnjTLmnuST6aXmBzm5rL56tSSXH2I+sJyd1W84
         AzwIW04UJ9iQ0eV0aPo9M7uvmY7gIGCuOxwLmPAlAUd9B0bhnKkb2zHTbdzhTMfWuk
         sdUxbQIzeOuEL6tlNhw1Jjr4BTeLz/XlSJLSxXCB7qkeC/rJqdBcrmGsxJ9HVQN0cg
         0qjD0XNMgqF6FHmxvncutlmOeSrzlWOBU0LUzMDBAcxEsmEzVb0cY1xwxgq5brQMzo
         l6rv3g//ONHe1j5VRZChMbTpoAevaf5jYM9mt2ZLqSgO/eMcAbojlrkLQXIuuM10Uq
         HpdMOATavZDaQ==
Date:   Wed, 7 Apr 2021 18:21:05 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH v5 04/19] fscrypt: add fscrypt_context_for_new_inode
Message-ID: <YG5agZ49PSJUtI7C@gmail.com>
References: <20210326173227.96363-1-jlayton@kernel.org>
 <20210326173227.96363-5-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210326173227.96363-5-jlayton@kernel.org>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Mar 26, 2021 at 01:32:12PM -0400, Jeff Layton wrote:
> CephFS will need to be able to generate a context for a new "prepared"
> inode. Add a new routine for getting the context out of an in-core
> inode.

It would be helpful to briefly mention why fscrypt_set_context() can't be used
instead (like the other filesystems do).

- Eric
