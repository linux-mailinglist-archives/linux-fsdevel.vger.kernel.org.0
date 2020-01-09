Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5813C135C30
	for <lists+linux-fsdevel@lfdr.de>; Thu,  9 Jan 2020 16:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730857AbgAIPFs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 9 Jan 2020 10:05:48 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:41998 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728346AbgAIPFs (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 9 Jan 2020 10:05:48 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ipZNZ-004vJb-Do; Thu, 09 Jan 2020 15:05:45 +0000
Date:   Thu, 9 Jan 2020 15:05:45 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de
Subject: Re: [PATCH V8 0/5] Refactor ioctl_fibmap() internal interface
Message-ID: <20200109150545.GJ8904@ZenIV.linux.org.uk>
References: <20200109133045.382356-1-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200109133045.382356-1-cmaiolino@redhat.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Jan 09, 2020 at 02:30:40PM +0100, Carlos Maiolino wrote:
> Hi,
> 
> This series refactor the internal structure of FIBMAP so that the filesystem can
> properly report errors back to VFS, and also simplifies its usage by
> standardizing all ->bmap() method usage via bmap() function.
> 
> The last patch is a bug fix for ioctl_fibmap() calls with negative block values.
> 
> 
> Viro spotted a mistake in patch 4/5 on the previous version, where bmap()
> return value was not being propagated back to userland, breaking its ABI.
> 
> So, this new version, only has a change on patch 4/5 to fix this problem.

Applied and pushed (#work.misc, #for-next)
