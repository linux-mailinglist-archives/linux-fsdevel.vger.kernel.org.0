Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0777630E1EA
	for <lists+linux-fsdevel@lfdr.de>; Wed,  3 Feb 2021 19:08:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbhBCSHp (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 3 Feb 2021 13:07:45 -0500
Received: from mx2.suse.de ([195.135.220.15]:34606 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232648AbhBCSHJ (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 3 Feb 2021 13:07:09 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 6B1AFACB7;
        Wed,  3 Feb 2021 18:06:26 +0000 (UTC)
Received: by quack2.suse.cz (Postfix, from userid 1000)
        id D85D31E14C4; Wed,  3 Feb 2021 19:06:25 +0100 (CET)
Date:   Wed, 3 Feb 2021 19:06:25 +0100
From:   Jan Kara <jack@suse.cz>
To:     bingjingc <bingjingc@synology.com>
Cc:     viro@zeniv.linux.org.uk, jack@suse.com, jack@suse.cz,
        axboe@kernel.dk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, cccheng@synology.com,
        robbieko@synology.com, willy@infradead.org, rdunlap@infradead.org,
        miklos@szeredi.hu
Subject: Re: [PATCH v3 0/3] handle large user and group ID for isofs and udf
Message-ID: <20210203180625.GA20183@quack2.suse.cz>
References: <20210129045148.10155-1-bingjingc@synology.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210129045148.10155-1-bingjingc@synology.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri 29-01-21 12:51:48, bingjingc wrote:
> From: BingJing Chang <bingjingc@synology.com>
> 
> The uid/gid (unsigned int) of a domain user may be larger than INT_MAX.
> The parse_options of isofs and udf will return 0, and mount will fail
> with -EINVAL. These patches try to handle large user and group ID.
> 
> BingJing Chang (3):
>   parser: add unsigned int parser
>   isofs: handle large user and group ID
>   udf: handle large user and group ID

Thanks for the patches. I've added these three patches to my tree.

								Honza
-- 
Jan Kara <jack@suse.com>
SUSE Labs, CR
