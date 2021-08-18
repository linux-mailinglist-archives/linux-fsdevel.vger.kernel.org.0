Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC983F06AA
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 16:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239042AbhHRO1A (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 10:27:00 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:55064 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238621AbhHRO1A (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 10:27:00 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMWH-00DlOr-Vq; Wed, 18 Aug 2021 14:26:18 +0000
Date:   Wed, 18 Aug 2021 14:26:17 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Gruenbacher <agruenba@redhat.com>
Subject: Re: [PATCH v2 0/2] allow overlayfs to do RCU lookups
Message-ID: <YR0YiSP3DliPCPWF@zeniv-ca.linux.org.uk>
References: <20210818133400.830078-1-mszeredi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210818133400.830078-1-mszeredi@redhat.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 03:33:58PM +0200, Miklos Szeredi wrote:
> I'd really like to fix this in some form, but not getting any response
> [1][2][3].
> 
> Al, Linus, can you please comment?
> 
> I'm happy to take this through the overlayfs tree, just need an ACK for the
> VFS API change.

Looks reasonable enough; I'm not too happy about yet another place LOOKUP_...
details get tangled into, though.  Do we want it to be more than just a
bool rcu?
