Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B734154D3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 02:51:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbhIWAxP (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 20:53:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:52858 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238631AbhIWAxP (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 20:53:15 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 81A9261038;
        Thu, 23 Sep 2021 00:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632358304;
        bh=r09GXIx4TJqwc4w8GD8ptEl/MnQuuvkMoYiq6Jhgkc0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=maE9Oim0ZBbgljDZT0AEm47Q6md+IH+RR6K8A98pBLNXDYK3gNBpA2UQ9V/ih95B0
         IHe7Q7PDJGqWqX5J99/QFN/nqQg3sabxc8h8v744rdczjv8DYGVyuzF6VqSsrQIID7
         yXMV8Vor5BoI8VLL1yPeocJlabVfivxqiNqAUtZZMBtMeiNaehuAxZFKxGO/ArDhJR
         2HOj/87q5lyZVQ4IRR1i+cFMBLZ78uZHurW6O9qu9tgMxZkRW7XJiApWBSWioQLmUP
         8KvProRI2ONuQ1D7yxXpM6qRTrwnLukTlX3DDJA+3w/3Wh65nE8ns2zO169IA4Z9Js
         ay81TJa7dwkJQ==
Date:   Wed, 22 Sep 2021 17:51:44 -0700
From:   "Darrick J. Wong" <djwong@kernel.org>
To:     jane.chu@oracle.com
Cc:     linux-xfs@vger.kernel.org, hch@infradead.org,
        dan.j.williams@intel.com, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHSET RFC v2 jane 0/5] vfs: enable userspace to reset
 damaged file storage
Message-ID: <20210923005144.GA570577@magnolia>
References: <163192864476.417973.143014658064006895.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <163192864476.417973.143014658064006895.stgit@magnolia>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

I withdraw the patchset due to spiralling complexity and the need to get
back to the other hojillion things.

Dave now suggests creating a RWF_CLEAR_POISON/IOCB_CLEAR_POISON flag to
clear poison ahead of userspace using a regular write to reset the
storage.  Honestly I only though of zero writes because I though that
would lead to the least amount of back and forth, which was clearly
wrong.

Jane, could you take over and try that?

--D
