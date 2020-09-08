Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91B2C260A67
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Sep 2020 07:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbgIHFyt (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Sep 2020 01:54:49 -0400
Received: from mail.kernel.org ([198.145.29.99]:47306 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728531AbgIHFys (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Sep 2020 01:54:48 -0400
Received: from sol.localdomain (172-10-235-113.lightspeed.sntcca.sbcglobal.net [172.10.235.113])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40B482137B;
        Tue,  8 Sep 2020 05:54:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599544488;
        bh=VvQRUqCEumUrjB1eL6fGK/9AS3T4qWtdbK1Y+v5BDek=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y48O9cyOyoz3Qp3v+QBDf8anbyuYYQUtBXPfl5qboMnFu/9pTDu0XOr1Pu6vr7JGT
         G4vXb/UQVcCAN8JHgyNZU+Isxl6uLMPJIbYfNpnna/+cTk/jb/Bvj7dcMRvS0xfOpm
         fFN8ex7NYa0CEeZTJgucmPv7RAnGxNgcDwbt/gZ0=
Date:   Mon, 7 Sep 2020 22:54:46 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-fscrypt@vger.kernel.org
Subject: Re: [RFC PATCH v2 00/18] ceph+fscrypt: context, filename and symlink
 support
Message-ID: <20200908055446.GP68127@sol.localdomain>
References: <20200904160537.76663-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200904160537.76663-1-jlayton@kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Sep 04, 2020 at 12:05:19PM -0400, Jeff Layton wrote:
> This is a second posting of the ceph+fscrypt integration work that I've
> been experimenting with. The main change with this patch is that I've
> based this on top of Eric's fscrypt-pending set. That necessitated a
> change to allocate inodes much earlier than we have traditionally, prior
> to sending an RPC instead of waiting on the reply.

FWIW, if possible you should create a git tag or branch for your patchset.
While just the mailed patches work fine for *me* for this particular patchset,
other people may not be able to figure out what the patchset applies to.
(In particular, it depends on another patchset:
https://lkml.kernel.org/r/20200824061712.195654-1-ebiggers@kernel.org)

> Note that this just covers the crypto contexts and filenames. I've also
> added a patch to encrypt symlink contents as well, but it doesn't seem to
> be working correctly.

What about symlink encryption isn't working correctly?

- Eric
