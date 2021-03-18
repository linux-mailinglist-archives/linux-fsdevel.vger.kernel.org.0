Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 475F933FF8D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 07:28:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229735AbhCRG15 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 02:27:57 -0400
Received: from verein.lst.de ([213.95.11.211]:40240 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229784AbhCRG1r (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:27:47 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 33B9868C65; Thu, 18 Mar 2021 07:27:46 +0100 (CET)
Date:   Thu, 18 Mar 2021 07:27:45 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 3/3] fs: introduce two little fs{u,g}id inode
 initialization helpers
Message-ID: <20210318062745.GC29726@lst.de>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com> <20210315145419.2612537-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315145419.2612537-4-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 03:54:19PM +0100, Christian Brauner wrote:
> Give filesystem two little helpers so that do the right thing when
> initializing the i_uid and i_gid fields on idmapped and non-idmapped
> mounts. Filesystemd don't need to bother with too many details for this.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
