Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842D42ADE64
	for <lists+linux-fsdevel@lfdr.de>; Tue, 10 Nov 2020 19:32:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731560AbgKJScy (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 10 Nov 2020 13:32:54 -0500
Received: from verein.lst.de ([213.95.11.211]:36968 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731540AbgKJScy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 10 Nov 2020 13:32:54 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id DCBD667373; Tue, 10 Nov 2020 19:32:52 +0100 (CET)
Date:   Tue, 10 Nov 2020 19:32:52 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     "Darrick J. Wong" <darrick.wong@oracle.com>
Cc:     linux-xfs@vger.kernel.org, david@fromorbit.com, hch@lst.de,
        fdmanana@kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/3] vfs: move __sb_{start,end}_write* to fs.h
Message-ID: <20201110183252.GB29662@lst.de>
References: <160494580419.772573.9286165021627298770.stgit@magnolia> <160494582399.772573.10836748188202532335.stgit@magnolia>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <160494582399.772573.10836748188202532335.stgit@magnolia>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Nov 09, 2020 at 10:17:04AM -0800, Darrick J. Wong wrote:
> From: Darrick J. Wong <darrick.wong@oracle.com>
> 
> Now that we've straightened out the callers, move these three functions
> to fs.h since they're fairly trivial.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
