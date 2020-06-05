Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 044F41EF9A1
	for <lists+linux-fsdevel@lfdr.de>; Fri,  5 Jun 2020 15:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727103AbgFENuR (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 5 Jun 2020 09:50:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726981AbgFENuR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 5 Jun 2020 09:50:17 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0C32C08C5C2;
        Fri,  5 Jun 2020 06:50:16 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jhCjT-003agQ-4G; Fri, 05 Jun 2020 13:50:03 +0000
Date:   Fri, 5 Jun 2020 14:50:03 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     torvalds@linux-foundation.org,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        linux-afs@lists.infradead.org, linux-ext4@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [GIT PULL] afs: Improvements for v5.8
Message-ID: <20200605135003.GH23230@ZenIV.linux.org.uk>
References: <2240660.1591289899@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2240660.1591289899@warthog.procyon.org.uk>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jun 04, 2020 at 05:58:19PM +0100, David Howells wrote:
> Hi Linus,
> 
> Is it too late to put in a pull request for AFS changes?  Apologies - I was
> holding off and hoping that I could get Al to review the changes I made to
> the core VFS change commit (first in the series) in response to his earlier
> review comments.  I have an ack for the Ext4 changes made, though.  If you
> would prefer it to be held off at this point, fair enough.
> 
> Note that the series also got rebased to -rc7 to remove the dependency on
> fix patches that got merged through the net tree.

FWIW, I can live with fs/inode.c part in its current form
