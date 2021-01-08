Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA9DD2EEF10
	for <lists+linux-fsdevel@lfdr.de>; Fri,  8 Jan 2021 10:04:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbhAHJDj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 8 Jan 2021 04:03:39 -0500
Received: from verein.lst.de ([213.95.11.211]:43115 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727450AbhAHJDj (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 8 Jan 2021 04:03:39 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id C4F5668BFE; Fri,  8 Jan 2021 10:02:56 +0100 (CET)
Date:   Fri, 8 Jan 2021 10:02:56 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/13] fs: pass only I_DIRTY_INODE flags to
 ->dirty_inode
Message-ID: <20210108090256.GF1438@lst.de>
References: <20210105005452.92521-1-ebiggers@kernel.org> <20210105005452.92521-7-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210105005452.92521-7-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
