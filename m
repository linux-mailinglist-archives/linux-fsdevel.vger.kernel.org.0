Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93C541BD431
	for <lists+linux-fsdevel@lfdr.de>; Wed, 29 Apr 2020 07:47:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726598AbgD2Frc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 29 Apr 2020 01:47:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726420AbgD2Frc (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 29 Apr 2020 01:47:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD26C03C1AC;
        Tue, 28 Apr 2020 22:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=vUooDuL2DvVLTuh/RB/NviUBjBz48UVnSV7FdK3EOOc=; b=WeAZI/g3JBd9XahE9dt2d4+z8i
        vNzV3YmkB2xHTNy/4FFhrb3hUL4zmfuQoXWURVT3TJ4SVgE3m/7c5GR6wMP4UhVSh2V9/e92smdWU
        m0Pqjpu3oDXO0VmMfzwML0v7mKaMPmLjOk1UECbDRNfYL5BTRsbCZISTadQk8r3xGNkncch2omXJQ
        m/5YYd7WnCw4L6iyX6PyrRKQfWvt7qdiJlvnrZ7Z6quiViiWgXtKqKPuLwpu/iScZqYlTfxjdsqAp
        LI9lj9TrNMj5D2kD1aag4gV7ss0LuwN5HK7KFz7t50jxmiEzWX7HP037pSeB4C+thGmez8v9Vwkxg
        UMwsjwSA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jTfZ8-0000L3-LS; Wed, 29 Apr 2020 05:47:26 +0000
Subject: Re: [PATCH V11.2] Documentation/dax: Update Usage section
To:     ira.weiny@intel.com, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org,
        "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        "Theodore Y. Ts'o" <tytso@mit.edu>, Jeff Moyer <jmoyer@redhat.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org
References: <20200428222145.409961-1-ira.weiny@intel.com>
 <20200429043328.411431-1-ira.weiny@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <b8f97774-09a7-c8d1-51fd-c2285662c950@infradead.org>
Date:   Tue, 28 Apr 2020 22:47:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200429043328.411431-1-ira.weiny@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 4/28/20 9:33 PM, ira.weiny@intel.com wrote:
> From: Ira Weiny <ira.weiny@intel.com>
> 
> Update the Usage section to reflect the new individual dax selection
> functionality.
> 
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---

Acked-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  Documentation/filesystems/dax.txt | 142 +++++++++++++++++++++++++++++-
>  1 file changed, 139 insertions(+), 3 deletions(-)


-- 
~Randy
