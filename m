Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 574874A583C
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Feb 2022 09:06:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235241AbiBAIGV (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Feb 2022 03:06:21 -0500
Received: from verein.lst.de ([213.95.11.211]:57899 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229895AbiBAIGU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Feb 2022 03:06:20 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6726D68BEB; Tue,  1 Feb 2022 09:06:17 +0100 (CET)
Date:   Tue, 1 Feb 2022 09:06:17 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fscrypt@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Satya Tangirala <satyat@google.com>
Subject: Re: [PATCH v11 1/5] fscrypt: add functions for direct I/O support
Message-ID: <20220201080617.GA29730@lst.de>
References: <20220128233940.79464-1-ebiggers@kernel.org> <20220128233940.79464-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220128233940.79464-2-ebiggers@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
