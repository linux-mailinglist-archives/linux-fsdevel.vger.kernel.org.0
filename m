Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1514291654
	for <lists+linux-fsdevel@lfdr.de>; Sun, 18 Oct 2020 09:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726309AbgJRH2E (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sun, 18 Oct 2020 03:28:04 -0400
Received: from verein.lst.de ([213.95.11.211]:39370 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725275AbgJRH2E (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Sun, 18 Oct 2020 03:28:04 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4CCAA68B05; Sun, 18 Oct 2020 09:28:01 +0200 (CEST)
Date:   Sun, 18 Oct 2020 09:28:01 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Ian Kent <raven@themaw.net>, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        bugzilla-daemon@bugzilla.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, haxk612@gmail.com
Subject: Re: [Bug 209719] New: NULL pointer dereference
Message-ID: <20201018072801.GA15414@lst.de>
References: <bug-209719-27@https.bugzilla.kernel.org/> <20201016133301.aaff2b261a0afe5e15a32138@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201016133301.aaff2b261a0afe5e15a32138@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Oct 16, 2020 at 01:33:01PM -0700, Andrew Morton wrote:
> (switched to email.  Please respond via emailed reply-to-all, not via the
> bugzilla web interface).

This is already fixed in Al's for-next tree:

https://git.kernel.org/pub/scm/linux/kernel/git/viro/vfs.git/commit/?h=for-next&id=4c207ef48269377236cd38979197c5e1631c8c16
