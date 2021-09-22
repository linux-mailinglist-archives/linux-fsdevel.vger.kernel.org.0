Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A77F4153F8
	for <lists+linux-fsdevel@lfdr.de>; Thu, 23 Sep 2021 01:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238510AbhIVXh3 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 22 Sep 2021 19:37:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbhIVXhZ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 22 Sep 2021 19:37:25 -0400
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19E6EC061574
        for <linux-fsdevel@vger.kernel.org>; Wed, 22 Sep 2021 16:35:55 -0700 (PDT)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mTBmI-006Y8s-Sm; Wed, 22 Sep 2021 23:35:50 +0000
Date:   Wed, 22 Sep 2021 23:35:50 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org, linux-doc@vger.kernel.org,
        willy@infradead.org
Subject: Re: [PATCH 1/5] initramfs: move unnecessary memcmp from hot path
Message-ID: <YUu91kH8kOcVHxyb@zeniv-ca.linux.org.uk>
References: <20210922115222.8987-1-ddiss@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210922115222.8987-1-ddiss@suse.de>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Sep 22, 2021 at 01:52:18PM +0200, David Disseldorp wrote:
> do_header() is called for each cpio entry and first checks for "newc"
> magic before parsing further. The magic check includes a special case
> error message if POSIX.1 ASCII (cpio -H odc) magic is detected. This
> special case POSIX.1 check needn't be done in the hot path, so move it
> under the non-newc-magic error path.

You keep refering to hot paths; do you have any data to support that
assertion?

How much does that series buy you on average, and what kind of dispersion
do you get before and after it?

I'm not saying I hate the patches themselves, but those references in commit
messages ping my BS detectors every time I see them ;-/
