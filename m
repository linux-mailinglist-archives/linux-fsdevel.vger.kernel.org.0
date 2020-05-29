Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B09F71E8005
	for <lists+linux-fsdevel@lfdr.de>; Fri, 29 May 2020 16:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726966AbgE2OSF (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 29 May 2020 10:18:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgE2OSF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 29 May 2020 10:18:05 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60881C03E969;
        Fri, 29 May 2020 07:18:05 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jefpb-00Ha3Z-6v; Fri, 29 May 2020 14:17:55 +0000
Date:   Fri, 29 May 2020 15:17:55 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        intel-gfx@lists.freedesktop.org,
        Chris Wilson <chris@chris-wilson.co.uk>
Subject: Re: [PATCHES] uaccess i915
Message-ID: <20200529141755.GD23230@ZenIV.linux.org.uk>
References: <20200528234025.GT23230@ZenIV.linux.org.uk>
 <20200529004050.GY23230@ZenIV.linux.org.uk>
 <87ftbj1gah.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ftbj1gah.fsf@intel.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, May 29, 2020 at 08:06:14AM +0300, Jani Nikula wrote:
> On Fri, 29 May 2020, Al Viro <viro@zeniv.linux.org.uk> wrote:
> > 	Low-hanging fruit in i915 uaccess-related stuff.
> > There's some subtler stuff remaining after that; these
> > are the simple ones.
> 
> Please Cc: intel-gfx@lists.freedesktop.org for i915 changes.

Will do.  Do you want me to resend those (or post them there separately, or...)?

> Also added Chris who I believe will be able to best review the changes.

FWIW, the branch is in

git://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git #uaccess.i915
