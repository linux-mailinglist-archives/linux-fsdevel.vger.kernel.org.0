Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B38632592AA
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 17:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729201AbgIAPPW (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:15:22 -0400
Received: from verein.lst.de ([213.95.11.211]:53788 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729196AbgIAPPU (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:15:20 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 0B52968B05; Tue,  1 Sep 2020 17:15:19 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:15:18 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: Re: [PATCH 5/6] parport: rework procfs handlers to take advantage
 of the new buffer
Message-ID: <20200901151518.GE30709@lst.de>
References: <20200813210411.905010-1-josef@toxicpanda.com> <20200813210411.905010-6-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813210411.905010-6-josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:04:10PM -0400, Josef Bacik wrote:
> The buffer coming from higher up the stack has an extra byte to handle
> the NULL terminator in the string.  Instead of using a temporary buffer
> to sprintf into and then copying into the buffer, just scnprintf
> directly into the buffer and update lenp as appropriate.
> 
> Signed-off-by: Josef Bacik <josef@toxicpanda.com>

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
