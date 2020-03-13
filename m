Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6DDD3185020
	for <lists+linux-fsdevel@lfdr.de>; Fri, 13 Mar 2020 21:18:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727326AbgCMUS2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 13 Mar 2020 16:18:28 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:34843 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726620AbgCMUS2 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 13 Mar 2020 16:18:28 -0400
Received: from callcc.thunk.org (pool-72-93-95-157.bstnma.fios.verizon.net [72.93.95.157])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 02DKID93004327
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 13 Mar 2020 16:18:14 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 9F6EF420E5E; Fri, 13 Mar 2020 16:18:13 -0400 (EDT)
Date:   Fri, 13 Mar 2020 16:18:13 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Ritesh Harjani <riteshh@linux.ibm.com>
Cc:     linux-ext4@vger.kernel.org, jack@suse.cz, adilger.kernel@dilger.ca,
        linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        hch@infradead.org, cmaiolino@redhat.com, david@fromorbit.com
Subject: Re: [PATCHv5 4/6] ext4: Make ext4_ind_map_blocks work with fiemap
Message-ID: <20200313201813.GK225435@mit.edu>
References: <cover.1582880246.git.riteshh@linux.ibm.com>
 <87fa0ddc5967fa707656212a3b66a7233425325c.1582880246.git.riteshh@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87fa0ddc5967fa707656212a3b66a7233425325c.1582880246.git.riteshh@linux.ibm.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Feb 28, 2020 at 02:56:57PM +0530, Ritesh Harjani wrote:
> For indirect block mapping if the i_block > max supported block in inode
> then ext4_ind_map_blocks() returns a -EIO error. But in case of fiemap
> this could be a valid query to ->iomap_begin call.
> So check if the offset >= s_bitmap_maxbytes in ext4_iomap_begin_report(),
> then simply skip calling ext4_map_blocks().
> 
> Signed-off-by: Ritesh Harjani <riteshh@linux.ibm.com>
> Reviewed-by: Jan Kara <jack@suse.cz>

Thanks, applied.

				- Ted
