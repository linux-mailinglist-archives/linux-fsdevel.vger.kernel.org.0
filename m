Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA9CB2F44D7
	for <lists+linux-fsdevel@lfdr.de>; Wed, 13 Jan 2021 08:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726377AbhAMHHs (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 13 Jan 2021 02:07:48 -0500
Received: from verein.lst.de ([213.95.11.211]:58743 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726207AbhAMHHs (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 13 Jan 2021 02:07:48 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 60C2267373; Wed, 13 Jan 2021 08:07:05 +0100 (CET)
Date:   Wed, 13 Jan 2021 08:07:05 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        Theodore Ts'o <tytso@mit.edu>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v3 11/11] ext4: simplify i_state checks in
 __ext4_update_other_inode_time()
Message-ID: <20210113070705.GA13551@lst.de>
References: <20210112190253.64307-1-ebiggers@kernel.org> <20210112190253.64307-12-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210112190253.64307-12-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
