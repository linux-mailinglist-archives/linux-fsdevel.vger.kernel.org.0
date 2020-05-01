Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD711C0D75
	for <lists+linux-fsdevel@lfdr.de>; Fri,  1 May 2020 06:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgEAEhr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 1 May 2020 00:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726153AbgEAEhr (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 1 May 2020 00:37:47 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37521C035494;
        Thu, 30 Apr 2020 21:37:47 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jUNQj-00Fc0H-H0; Fri, 01 May 2020 04:37:41 +0000
Date:   Fri, 1 May 2020 05:37:41 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-fsdevel@vger.kernel.org, willy@infradead.org,
        jlayton@kernel.org, ceph-devel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-unionfs@vger.kernel.org,
        dsterba@suse.cz
Subject: Re: [RESEND PATCH 0/1] Use inode_lock/unlock class of provided APIs
 in filesystems
Message-ID: <20200501043741.GK23230@ZenIV.linux.org.uk>
References: <20200101105248.25304-1-riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200101105248.25304-1-riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 01, 2020 at 04:22:47PM +0530, Ritesh Harjani wrote:
> Al, any comments?
> Resending this after adding Reviewed-by/Acked-by tags.

.... argh.  My apologies - that got fallen through the cracks.
Could you rebase and resend it?
