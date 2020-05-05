Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7451C5379
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 May 2020 12:43:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgEEKnW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 May 2020 06:43:22 -0400
Received: from verein.lst.de ([213.95.11.211]:34595 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728638AbgEEKnW (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 May 2020 06:43:22 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 7AAAD68C4E; Tue,  5 May 2020 12:43:19 +0200 (CEST)
Date:   Tue, 5 May 2020 12:43:19 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-ext4@vger.kernel.org,
        viro@zeniv.linux.org.uk, jack@suse.cz, tytso@mit.edu,
        adilger@dilger.ca, amir73il@gmail.com,
        linux-fsdevel@vger.kernel.org, linux-unionfs@vger.kernel.org
Subject: Re: [PATCH 09/11] fs: handle FIEMAP_FLAG_SYNC in fiemap_prep
Message-ID: <20200505104319.GC15815@lst.de>
References: <20200427181957.1606257-1-hch@lst.de> <20200427181957.1606257-10-hch@lst.de> <20200501225232.9F1B4AE05D@d06av26.portsmouth.uk.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200501225232.9F1B4AE05D@d06av26.portsmouth.uk.ibm.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, May 02, 2020 at 04:22:31AM +0530, Ritesh Harjani wrote:
>
>
> On 4/27/20 11:49 PM, Christoph Hellwig wrote:
>> By moving FIEMAP_FLAG_SYNC handling to fiemap_prep we ensure it is
>> handled once instead of duplicated, but can still be done under fs locks,
>> like xfs/iomap intended with its duplicate handling.  Also make sure the
>> error value of filemap_write_and_wait is propagated to user space.
>
>
> Forgot to remove filemap_write_and_wait() from
> ext4_ioctl_get_es_cache() ?

Fixed.
