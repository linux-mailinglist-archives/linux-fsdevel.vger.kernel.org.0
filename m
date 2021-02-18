Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D18431E789
	for <lists+linux-fsdevel@lfdr.de>; Thu, 18 Feb 2021 09:40:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhBRIfx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 18 Feb 2021 03:35:53 -0500
Received: from verein.lst.de ([213.95.11.211]:47754 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231310AbhBRId3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 18 Feb 2021 03:33:29 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id B425D6736F; Thu, 18 Feb 2021 09:32:30 +0100 (CET)
Date:   Thu, 18 Feb 2021 09:32:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Ruan Shiyang <ruansy.fnst@cn.fujitsu.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-kernel@vger.kernel.org,
        linux-xfs@vger.kernel.org, linux-nvdimm@lists.01.org,
        linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
        dm-devel@redhat.com, darrick.wong@oracle.com,
        dan.j.williams@intel.com, david@fromorbit.com, agk@redhat.com,
        snitzer@redhat.com, rgoldwyn@suse.de, qi.fuli@fujitsu.com,
        y-goto@fujitsu.com
Subject: Re: [PATCH v3 05/11] mm, fsdax: Refactor memory-failure handler
 for dax mapping
Message-ID: <20210218083230.GA17913@lst.de>
References: <20210208105530.3072869-1-ruansy.fnst@cn.fujitsu.com> <20210208105530.3072869-6-ruansy.fnst@cn.fujitsu.com> <20210210133347.GD30109@lst.de> <45a20d88-63ee-d678-ad86-6ccd8cdf7453@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45a20d88-63ee-d678-ad86-6ccd8cdf7453@cn.fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Feb 17, 2021 at 10:56:11AM +0800, Ruan Shiyang wrote:
> I'd like to confirm one thing...  I have checked all of this patchset by 
> checkpatch.pl and it did not report the overly long line warning.  So, I 
> should still obey the rule of 80 chars one line?

checkpatch.pl is completely broken, I would not rely on it.

Here is the quote from the coding style document:

"The preferred limit on the length of a single line is 80 columns.

Statements longer than 80 columns should be broken into sensible chunks,
unless exceeding 80 columns significantly increases readability and does
not hide information."
