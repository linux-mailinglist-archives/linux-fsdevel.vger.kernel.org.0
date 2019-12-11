Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A5FB611BC28
	for <lists+linux-fsdevel@lfdr.de>; Wed, 11 Dec 2019 19:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727237AbfLKSq4 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 11 Dec 2019 13:46:56 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:34214 "EHLO
        ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbfLKSq4 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 11 Dec 2019 13:46:56 -0500
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1if70I-0005sF-Gk; Wed, 11 Dec 2019 18:46:30 +0000
Date:   Wed, 11 Dec 2019 18:46:30 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     David Hildenbrand <david@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        "yukuai (C)" <yukuai3@huawei.com>, gregkh@linuxfoundation.org,
        rafael@kernel.org, rostedt@goodmis.org, oleg@redhat.com,
        mchehab+samsung@kernel.org, corbet@lwn.net, tytso@mit.edu,
        jmorris@namei.org, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, zhengbin13@huawei.com,
        yi.zhang@huawei.com, chenxiang66@hisilicon.com, xiexiuqi@huawei.com
Subject: Re: [PATCH V2 1/3] dcache: add a new enum type for
 'dentry_d_lock_class'
Message-ID: <20191211184630.GD4203@ZenIV.linux.org.uk>
References: <20191130020225.20239-1-yukuai3@huawei.com>
 <20191130020225.20239-2-yukuai3@huawei.com>
 <20191130034339.GI20752@bombadil.infradead.org>
 <e2e7c9f1-7152-1d74-c434-c2c4d57d0422@huawei.com>
 <20191130193615.GJ20752@bombadil.infradead.org>
 <20191208191142.GU4203@ZenIV.linux.org.uk>
 <c8a66d9d-63b6-58db-23b5-148122d606ca@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c8a66d9d-63b6-58db-23b5-148122d606ca@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Dec 11, 2019 at 04:55:56PM +0100, David Hildenbrand wrote:

[snip]

> The patch in linux-next
> 
> commit 653f0d05be0948e7610bb786e6570bb6c48a4e75 (HEAD, refs/bisect/bad)

... is no longer there.  commit a3d1e7eb5abe3aa1095bc75d1a6760d3809bd672
is; could you check if it fixes your reproducer?
