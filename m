Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BC2633FF83
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Mar 2021 07:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbhCRG0U (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Mar 2021 02:26:20 -0400
Received: from verein.lst.de ([213.95.11.211]:40230 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229519AbhCRG0P (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Mar 2021 02:26:15 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6211168C65; Thu, 18 Mar 2021 07:26:13 +0100 (CET)
Date:   Thu, 18 Mar 2021 07:26:13 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Christian Brauner <christian.brauner@ubuntu.com>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Vivek Goyal <vgoyal@redhat.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 1/3] fs: introduce fsuidgid_has_mapping() helper
Message-ID: <20210318062613.GA29726@lst.de>
References: <20210315145419.2612537-1-christian.brauner@ubuntu.com> <20210315145419.2612537-2-christian.brauner@ubuntu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210315145419.2612537-2-christian.brauner@ubuntu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Mar 15, 2021 at 03:54:17PM +0100, Christian Brauner wrote:
> Don't open-code the checks and instead move them into a clean little
> helper we can call. This also reduces the risk that if we ever change
> something we forget to change all locations.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
