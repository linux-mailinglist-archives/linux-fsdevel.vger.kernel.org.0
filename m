Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D39D81D33BA
	for <lists+linux-fsdevel@lfdr.de>; Thu, 14 May 2020 16:57:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726726AbgENO5j (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 14 May 2020 10:57:39 -0400
Received: from outgoing-auth-1.mit.edu ([18.9.28.11]:59684 "EHLO
        outgoing.mit.edu" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726316AbgENO5j (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 14 May 2020 10:57:39 -0400
Received: from callcc.thunk.org (pool-100-0-195-244.bstnma.fios.verizon.net [100.0.195.244])
        (authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
        by outgoing.mit.edu (8.14.7/8.12.4) with ESMTP id 04EEvVAn008896
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 May 2020 10:57:31 -0400
Received: by callcc.thunk.org (Postfix, from userid 15806)
        id 03A1F420304; Thu, 14 May 2020 10:57:30 -0400 (EDT)
Date:   Thu, 14 May 2020 10:57:30 -0400
From:   "Theodore Y. Ts'o" <tytso@mit.edu>
To:     Jan Kara <jack@suse.cz>
Cc:     linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Sandeen <sandeen@sandeen.net>
Subject: Re: [PATCH 2/3] writeback: Export inode_io_list_del()
Message-ID: <20200514145730.GV1596452@mit.edu>
References: <20200421085445.5731-1-jack@suse.cz>
 <20200421085445.5731-3-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200421085445.5731-3-jack@suse.cz>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Apr 21, 2020 at 10:54:44AM +0200, Jan Kara wrote:
> Ext4 needs to remove inode from writeback lists after it is out of
> visibility of its journalling machinery (which can still dirty the
> inode). Export inode_io_list_del() for it.
> 
> Signed-off-by: Jan Kara <jack@suse.cz>

Applied, thanks.

					- Ted
