Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F38F49FA70
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Jan 2022 14:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244259AbiA1NRr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Jan 2022 08:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244534AbiA1NRc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Jan 2022 08:17:32 -0500
Received: from zeniv-ca.linux.org.uk (zeniv-ca.linux.org.uk [IPv6:2607:5300:60:148a::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B084BC061747;
        Fri, 28 Jan 2022 05:17:31 -0800 (PST)
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nDR7y-005VFV-G4; Fri, 28 Jan 2022 13:17:22 +0000
Date:   Fri, 28 Jan 2022 13:17:22 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Howells <dhowells@redhat.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Chaitanya Kulkarni <chaitanyak@nvidia.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Subject: Re: [PATCH v2] fs: rename S_KERNEL_FILE
Message-ID: <YfPs4hpWtFziiO2c@zeniv-ca.linux.org.uk>
References: <CAOQ4uxhRS3MGEnCUDcsB1RL0d1Oy0g0Rzm75hVFAJw2dJ7uKSA@mail.gmail.com>
 <20220128074731.1623738-1-hch@lst.de>
 <918225.1643364739@warthog.procyon.org.uk>
 <922909.1643369759@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <922909.1643369759@warthog.procyon.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:35:59AM +0000, David Howells wrote:

> > Whether deny rmdir should have its own flag or not I don't know,
> > but from ovl POV I *think* it should not be a problem to deny rmdir
> > for the ovl upper/work dirs as long as ovl is mounted(?).
> 
> What's the consequence of someone rearranging the directories directly in the
> contributing dirs whilst there's an overlay over them?

"Don't do it, then - presumably the kernel won't panic, but don't expect it to
try and invent nice semantics for the crap you are trying to pull"
