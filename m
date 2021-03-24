Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C110D3470AF
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Mar 2021 06:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232824AbhCXFS6 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Mar 2021 01:18:58 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:41042 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232648AbhCXFS6 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Mar 2021 01:18:58 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lOvuz-008kp0-6V; Wed, 24 Mar 2021 05:18:57 +0000
Date:   Wed, 24 Mar 2021 05:18:57 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Miklos Szeredi <mszeredi@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/18] ovl: stack miscattr ops
Message-ID: <YFrLwbf66HSsqCDE@zeniv-ca.linux.org.uk>
References: <20210322144916.137245-1-mszeredi@redhat.com>
 <20210322144916.137245-4-mszeredi@redhat.com>
 <YFrJp5I3nL1RriTL@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFrJp5I3nL1RriTL@zeniv-ca.linux.org.uk>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 24, 2021 at 05:09:59AM +0000, Al Viro wrote:
> On Mon, Mar 22, 2021 at 03:49:01PM +0100, Miklos Szeredi wrote:

> Umm...  No equivalents of
>         /*  
>          * Prevent copy up if immutable and has no CAP_LINUX_IMMUTABLE
>          * capability.
>          */ 
>         ret = -EPERM;
>         if (!ovl_has_upperdata(inode) && IS_IMMUTABLE(inode) &&
>             !capable(CAP_LINUX_IMMUTABLE))
>                 goto unlock;
> 

Nevermind, you take care of that in the caller...
