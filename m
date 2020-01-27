Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1AC7914A066
	for <lists+linux-fsdevel@lfdr.de>; Mon, 27 Jan 2020 10:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgA0JDc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 27 Jan 2020 04:03:32 -0500
Received: from verein.lst.de ([213.95.11.211]:54810 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728783AbgA0JDc (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 27 Jan 2020 04:03:32 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 4DC1468BE1; Mon, 27 Jan 2020 10:03:30 +0100 (CET)
Date:   Mon, 27 Jan 2020 10:03:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Andreas Gruenbacher <agruenba@redhat.com>,
        Bob Peterson <rpeterso@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [Cluster-devel] [PATCH 05/12] gfs2: fix O_SYNC write handling
Message-ID: <20200127090330.GA31504@lst.de>
References: <20200114161225.309792-1-hch@lst.de> <20200114161225.309792-6-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200114161225.309792-6-hch@lst.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Bob and Andreas,

can you please look at this fix and the prep patch?
