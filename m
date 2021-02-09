Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79A2A315391
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Feb 2021 17:16:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232234AbhBIQP0 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Feb 2021 11:15:26 -0500
Received: from mx2.suse.de ([195.135.220.15]:49338 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232198AbhBIQPQ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Feb 2021 11:15:16 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5A610AD2E;
        Tue,  9 Feb 2021 16:14:34 +0000 (UTC)
Received: by ds.suse.cz (Postfix, from userid 10065)
        id 2F430DA7C8; Tue,  9 Feb 2021 17:12:41 +0100 (CET)
Date:   Tue, 9 Feb 2021 17:12:41 +0100
From:   David Sterba <dsterba@suse.cz>
To:     Pan Bian <bianpan2016@163.com>
Cc:     David Sterba <dsterba@suse.com>, Fabian Frederick <fabf@skynet.be>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs/affs: release old buffer head on error path
Message-ID: <20210209161240.GV1993@suse.cz>
Reply-To: dsterba@suse.cz
Mail-Followup-To: dsterba@suse.cz, Pan Bian <bianpan2016@163.com>,
        David Sterba <dsterba@suse.com>, Fabian Frederick <fabf@skynet.be>,
        Al Viro <viro@zeniv.linux.org.uk>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20210120085113.118984-1-bianpan2016@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210120085113.118984-1-bianpan2016@163.com>
User-Agent: Mutt/1.5.23.1-rc1 (2014-03-12)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jan 20, 2021 at 12:51:13AM -0800, Pan Bian wrote:
> The reference count of the old buffer head should be decremented on path
> that fails to get the new buffer head.
> 
> Fixes: 6b4657667ba0 ("fs/affs: add rename exchange")
> Signed-off-by: Pan Bian <bianpan2016@163.com>

Thanks, added to affs branch. The fix is not that urgent for 5.11 so
I'll send it for the 5.12 merge window. I've added the stable tag so
it'll propagate to 4.14+.
