Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC7F85791
	for <lists+linux-fsdevel@lfdr.de>; Thu,  8 Aug 2019 03:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389653AbfHHBVv (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Aug 2019 21:21:51 -0400
Received: from zeniv.linux.org.uk ([195.92.253.2]:49814 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389314AbfHHBVv (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Aug 2019 21:21:51 -0400
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92 #3 (Red Hat Linux))
        id 1hvX7X-0000Oj-KW; Thu, 08 Aug 2019 01:21:35 +0000
Date:   Thu, 8 Aug 2019 02:21:35 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Hugh Dickins <hughd@google.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        David Howells <dhowells@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCHv2 2/3] i915: convert to new mount API
Message-ID: <20190808012135.GJ1131@ZenIV.linux.org.uk>
References: <20190805160307.5418-1-sergey.senozhatsky@gmail.com>
 <20190805160307.5418-3-sergey.senozhatsky@gmail.com>
 <20190805181255.GH1131@ZenIV.linux.org.uk>
 <20190805182834.GI1131@ZenIV.linux.org.uk>
 <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LSU.2.11.1908060007190.1941@eggly.anvils>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 06, 2019 at 12:50:10AM -0700, Hugh Dickins wrote:

> that mapping must have been decided previously).  In Google we do use
> fcntls F_HUGEPAGE and F_NOHUGEPAGE to override on a per-file basis -
> one day I'll get to upstreaming those.

That'd be nice - we could kill the i915 wierd private shmem instance,
along with some kludges in mm/shmem.c.
