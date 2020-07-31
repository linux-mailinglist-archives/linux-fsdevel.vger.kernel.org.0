Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAE3D233F22
	for <lists+linux-fsdevel@lfdr.de>; Fri, 31 Jul 2020 08:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731415AbgGaGdU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 31 Jul 2020 02:33:20 -0400
Received: from verein.lst.de ([213.95.11.211]:58188 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731224AbgGaGdT (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 31 Jul 2020 02:33:19 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 881D668BEB; Fri, 31 Jul 2020 08:33:16 +0200 (CEST)
Date:   Fri, 31 Jul 2020 08:33:16 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: add file system helpers that take kernel pointers for the init
 code v4
Message-ID: <20200731063316.GA5145@lst.de>
References: <20200728163416.556521-1-hch@lst.de> <20200729195117.GE951209@ZenIV.linux.org.uk> <20200730062524.GA17980@lst.de> <20200731021424.GG1236603@ZenIV.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731021424.GG1236603@ZenIV.linux.org.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Jul 31, 2020 at 03:14:24AM +0100, Al Viro wrote:
> Christoph Hellwig (28):
> [snip]
>       initramfs: switch initramfs unpacking to struct file based APIs
>       initramfs: switch initramfs unpacking to struct file based APIs
> [snip]
> 
> It's not a bisect hazard, of course, but if you don't fold those
> together, you might at least want to give the second one a different
> commit summary...  I hadn't been able to find an analogue of #init_path on
> top of that either.
> 
> As it is, #init-user-pointers is fine (aside of that SNAFU with unfolded
> pair of commits), and so's the contents of #init_path part following what
> used to be #init-user-pointers, but it'll be an awful mess on merge in
> the current shape.
> 
> I can sort it out myself, if you don't mind that; again, I'm OK with
> the contents and I've no problem with doing reordering/folding.

I've fixed the folding issues in init-user-pointers and rebased init_path
on top of that.  Feel free to pull it.  I don't think it is worth
reposting.
