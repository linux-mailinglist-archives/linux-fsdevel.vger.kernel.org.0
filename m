Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB1713BA0A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 15 Jan 2020 08:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729139AbgAOHAQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 15 Jan 2020 02:00:16 -0500
Received: from bombadil.infradead.org ([198.137.202.133]:40006 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgAOHAQ (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 15 Jan 2020 02:00:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=e/HwDJPULoIYF73mp6McqVlqD1raV4CY1J/pokd3Z88=; b=RnWCULGz0F8WwEcYsM4hO5v1K
        +uB4kKjW6Ai37YFOoFp3+ik9b1pQQXl+VRmlQd5MW+129Ay98QE8ZMFX8HkX0s8djw5e0Phox9l3t
        QjZk1IKDfoG25eNE+fgpvu9L1vnAkKhaz4ZJOcRC+8IIE6vMJHNbi08C8UziSO7G4aQ9S44qW6aIa
        wWJ5mTMlAZSYQe9J4XE5RqOyBBeikZS8O3TlXHQaKh7rFnBkP3Po4p/6IpHwvkajrE4y0IdmPvrxU
        2YZJrcjfpOd0ODa4CcUdGClpg6u7+bxgL3p3f/QSCbBvRuT3dg+JtKdD1/b52bcad3IBI+UfqkCKO
        ZTQ6paXPw==;
Received: from [2601:1c0:6280:3f0::ed68]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1ircew-0002Af-G2; Wed, 15 Jan 2020 07:00:10 +0000
Subject: Re: [PATCH v7 2/2] zonefs: Add documentation
To:     Damien Le Moal <damien.lemoal@wdc.com>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Thumshirn <jth@kernel.org>,
        Naohiro Aota <naohiro.aota@wdc.com>,
        "Darrick J . Wong" <darrick.wong@oracle.com>,
        Hannes Reinecke <hare@suse.de>
References: <20200115062859.1389827-1-damien.lemoal@wdc.com>
 <20200115062859.1389827-3-damien.lemoal@wdc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <072a051e-4fbb-e662-c136-f9f27157169f@infradead.org>
Date:   Tue, 14 Jan 2020 23:00:09 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <20200115062859.1389827-3-damien.lemoal@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 1/14/20 10:28 PM, Damien Le Moal wrote:
> Add the new file Documentation/filesystems/zonefs.txt to document
> zonefs principles and user-space tool usage.
> 
> Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
> ---
>  Documentation/filesystems/zonefs.txt | 241 +++++++++++++++++++++++++++
>  MAINTAINERS                          |   1 +
>  2 files changed, 242 insertions(+)
>  create mode 100644 Documentation/filesystems/zonefs.txt

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

thanks.
-- 
~Randy
