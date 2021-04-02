Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 62834352716
	for <lists+linux-fsdevel@lfdr.de>; Fri,  2 Apr 2021 09:49:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhDBHtm (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 2 Apr 2021 03:49:42 -0400
Received: from verein.lst.de ([213.95.11.211]:42836 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234184AbhDBHtm (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 2 Apr 2021 03:49:42 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 1C27A68BEB; Fri,  2 Apr 2021 09:49:37 +0200 (CEST)
Date:   Fri, 2 Apr 2021 09:49:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Shiyang Ruan <ruansy.fnst@fujitsu.com>, dan.j.williams@intel.com
Cc:     linux-kernel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-nvdimm@lists.01.org, linux-fsdevel@vger.kernel.org,
        darrick.wong@oracle.com, willy@infradead.org, jack@suse.cz,
        viro@zeniv.linux.org.uk, linux-btrfs@vger.kernel.org,
        ocfs2-devel@oss.oracle.com, david@fromorbit.com, hch@lst.de,
        rgoldwyn@suse.de, Shiyang Ruan <ruansy.fnst@cn.fujitsu.com>
Subject: Re: [PATCH v3 00/10] fsdax,xfs: Add reflink&dedupe support for
 fsdax
Message-ID: <20210402074936.GB7057@lst.de>
References: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210319015237.993880-1-ruansy.fnst@fujitsu.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Shiyang, Dan:

given that the whole reflink+dax thing is going to take a while and thus
not going to happen for this merge window, what about queueing up the
cleanup patches 1,2 and 3 so that we can reduce the patch load a little?
