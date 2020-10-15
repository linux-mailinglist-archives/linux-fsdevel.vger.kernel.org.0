Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAE0628F7F1
	for <lists+linux-fsdevel@lfdr.de>; Thu, 15 Oct 2020 19:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390574AbgJOR4n (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 15 Oct 2020 13:56:43 -0400
Received: from verein.lst.de ([213.95.11.211]:32887 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390239AbgJOR4n (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 15 Oct 2020 13:56:43 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0A7CC68B02; Thu, 15 Oct 2020 19:56:42 +0200 (CEST)
Date:   Thu, 15 Oct 2020 19:56:41 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Al Viro <viro@zeniv.linux.org.uk>
Cc:     linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 00/13] Clean up kernel_read/kernel_write
Message-ID: <20201015175641.GC23287@lst.de>
References: <20201003025534.21045-1-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201003025534.21045-1-willy@infradead.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Al,

can you pick up patches 1 and 2 to unbreak linux-next?
