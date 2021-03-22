Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21B87343A31
	for <lists+linux-fsdevel@lfdr.de>; Mon, 22 Mar 2021 08:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbhCVHEv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 22 Mar 2021 03:04:51 -0400
Received: from verein.lst.de ([213.95.11.211]:53737 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229696AbhCVHEp (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 22 Mar 2021 03:04:45 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id F199D68C4E; Mon, 22 Mar 2021 08:04:41 +0100 (CET)
Date:   Mon, 22 Mar 2021 08:04:41 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH v2 3/4] fs: introduce fsuidgid_has_mapping() helper
Message-ID: <20210322070441.GC3299@lst.de>
References: <20210320122623.599086-1-christian.brauner@ubuntu.com> <20210320122623.599086-4-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210320122623.599086-4-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Mar 20, 2021 at 01:26:23PM +0100, Christian Brauner wrote:
> Don't open-code the checks and instead move them into a clean little
> helper we can call. This also reduces the risk that if we ever change
> something we forget to change all locations.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
