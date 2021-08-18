Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DCFCF3F0A87
	for <lists+linux-fsdevel@lfdr.de>; Wed, 18 Aug 2021 19:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232964AbhHRRuE (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Aug 2021 13:50:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56212 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233010AbhHRRuB (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Aug 2021 13:50:01 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A28566104F;
        Wed, 18 Aug 2021 17:49:25 +0000 (UTC)
Date:   Wed, 18 Aug 2021 19:49:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     David Disseldorp <ddiss@suse.de>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 0/2] exfat: allow access to paths with trailing dots
Message-ID: <20210818174922.lmfjgree7nkaw4pp@wittgenstein>
References: <20210818111123.19818-1-ddiss@suse.de>
 <20210818124835.pdlq25wf7wdn2x57@wittgenstein>
 <20210818184016.2631aeae@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210818184016.2631aeae@suse.de>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 18, 2021 at 06:40:16PM +0200, David Disseldorp wrote:
> On Wed, 18 Aug 2021 14:48:35 +0200, Christian Brauner wrote:
> 
> > On Wed, Aug 18, 2021 at 01:11:21PM +0200, David Disseldorp wrote:
> > > This patchset adds a new exfat "keeptail" mount option, which allows
> > > users to resolve paths carrying trailing period '.' characters.
> > > I'm not a huge fan of "keeptail" as an option name, but couldn't think
> > > of anything better.  
> > 
> > I wouldn't use "period". The vfs uses "dot" and "dotdot" as seen in e.g.
> > LAST_DOT or LAST_DOTOT. Maybe "keep_last_dot"?
> 
> Works for me, although I was under the impression that underscores were
> avoided for mount options. Also, I think it'd be clearer as the plural

Oh? I' just - for unrelated reasons - looking at cifs code and I
immediately see:

min_enc_offload
max_credits
_netdev

which doesn't necessarily mean that I'm right but rather that that ship
might have sailed. :)

Christian
