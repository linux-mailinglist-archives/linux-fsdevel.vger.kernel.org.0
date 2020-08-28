Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A33E4256281
	for <lists+linux-fsdevel@lfdr.de>; Fri, 28 Aug 2020 23:35:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726928AbgH1Vev (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 28 Aug 2020 17:34:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726033AbgH1Veu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 28 Aug 2020 17:34:50 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2976CC061264;
        Fri, 28 Aug 2020 14:34:50 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kBm1F-006cEb-JF; Fri, 28 Aug 2020 21:34:45 +0000
Date:   Fri, 28 Aug 2020 22:34:45 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Florian Margaine <florian@platform.sh>
Cc:     linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: allow do_renameat2() over bind mounts of the same
 filesystem.
Message-ID: <20200828213445.GM1236603@ZenIV.linux.org.uk>
References: <871rjqh5bw.fsf@platform.sh>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <871rjqh5bw.fsf@platform.sh>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 28, 2020 at 10:40:35PM +0200, Florian Margaine wrote:
> There's currently this seemingly unnecessary limitation that rename()
> cannot work over bind mounts of the same filesystem,

... is absolutely deliberate - that's how you set a boundary in the
tree, preventing both links and renames across it.

Incidentally, doing that would have fun effects for anyone with current
directory inside the subtree you'd moved - try and see.
