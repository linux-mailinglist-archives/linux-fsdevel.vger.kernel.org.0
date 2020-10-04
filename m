Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0EEF282B2C
	for <lists+linux-fsdevel@lfdr.de>; Sun,  4 Oct 2020 16:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725868AbgJDORu (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 4 Oct 2020 10:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725827AbgJDORu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 4 Oct 2020 10:17:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8627C0613CE;
        Sun,  4 Oct 2020 07:17:49 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kP4pd-00BnMY-3s; Sun, 04 Oct 2020 14:17:45 +0000
Date:   Sun, 4 Oct 2020 15:17:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     kernel test robot <lkp@intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Marc Zyngier <maz@kernel.org>, lkp@lists.01.org
Subject: Re: [ep_insert()] 9ee1cc5666:
 WARNING:possible_recursive_locking_detected
Message-ID: <20201004141745.GP3421308@ZenIV.linux.org.uk>
References: <20201004023929.2740074-20-viro@ZenIV.linux.org.uk>
 <20201004125619.GN393@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201004125619.GN393@shao2-debian>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sun, Oct 04, 2020 at 08:56:19PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 9ee1cc56661640a2ace2f7d0b52dec56b3573c53 ("[RFC PATCH 20/27] ep_insert(): we only need tep->mtx around the insertion itself")
> url: https://github.com/0day-ci/linux/commits/Al-Viro/epoll-switch-epitem-pwqlist-to-single-linked-list/20201004-113938
> base: https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git 22fbc037cd32e4e6771d2271b565806cfb8c134c

False positive, actually - that should've been mutex_lock_nested()
with 1 for depth; will update.
