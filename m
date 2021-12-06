Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E5B034698E1
	for <lists+linux-fsdevel@lfdr.de>; Mon,  6 Dec 2021 15:27:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245672AbhLFOb1 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 6 Dec 2021 09:31:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234728AbhLFOb1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 6 Dec 2021 09:31:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61F4EC061746
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Dec 2021 06:27:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A9EB8612C1
        for <linux-fsdevel@vger.kernel.org>; Mon,  6 Dec 2021 14:27:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DAD2C341C5;
        Mon,  6 Dec 2021 14:27:55 +0000 (UTC)
Date:   Mon, 6 Dec 2021 15:27:52 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Christian Brauner <brauner@kernel.org>,
        Seth Forshee <sforshee@digitalocean.com>,
        Amir Goldstein <amir73il@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 00/10] Extend and tweak mapping support
Message-ID: <20211206142752.54cigi5hhdudw4x2@wittgenstein>
References: <20211203111707.3901969-1-brauner@kernel.org>
 <20211206141042.GA5488@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211206141042.GA5488@lst.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Dec 06, 2021 at 03:10:42PM +0100, Christoph Hellwig wrote:
> I think without the actual file system consumer this is a little pointless.
> Can you please post this with an actual user in a single series?

The series cleans up the semantics and naming of the low-level mapping
helpers something we started earlier this year. This just finishes that
work and generalizes the infrastructure. So I think this really should
stand on its own.

I really want to do this incrementally with the generic changes first so
we have time to watch for regressions. The series is also at its core a
semantic cleanup.
No matter if I send this in one or in two series I'd like this to be a
two-stage process where we first extend the generic infra and port
existing filesystems as we do here. Next cycle we then port overlayfs as
the first idmapped filesystem.
