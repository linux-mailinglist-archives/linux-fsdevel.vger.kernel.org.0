Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 58D1F39F61D
	for <lists+linux-fsdevel@lfdr.de>; Tue,  8 Jun 2021 14:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhFHMOU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 8 Jun 2021 08:14:20 -0400
Received: from mail.kernel.org ([198.145.29.99]:59170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231330AbhFHMOU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 8 Jun 2021 08:14:20 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E143C61185;
        Tue,  8 Jun 2021 12:12:25 +0000 (UTC)
Date:   Tue, 8 Jun 2021 14:12:22 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHES] namei cleanups
Message-ID: <20210608121222.mqntlrepjuggtnh2@wittgenstein>
References: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YL9WwAD547fY19EE@zeniv-ca.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 08, 2021 at 11:38:40AM +0000, Al Viro wrote:
> 	Small namei.c patch series, mostly to simplify the rules
> for nameidata state.  It's in #work.namei and it's actually from
> the previous cycle - didn't post it for review in time...
> 
> 	Changes visible outside of fs/namei.c: file_open_root()
> calling conventions change, some freed bits in LOOKUP_... space.

Ah that's the follow-up to the io_uring fix from last cycle.
Nice cleanup.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
