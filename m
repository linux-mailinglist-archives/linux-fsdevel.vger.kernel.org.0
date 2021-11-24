Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AF78845C378
	for <lists+linux-fsdevel@lfdr.de>; Wed, 24 Nov 2021 14:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348241AbhKXNja (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 24 Nov 2021 08:39:30 -0500
Received: from mail.kernel.org ([198.145.29.99]:50198 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1347423AbhKXNff (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 24 Nov 2021 08:35:35 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 5647D61BF6;
        Wed, 24 Nov 2021 12:54:31 +0000 (UTC)
Date:   Wed, 24 Nov 2021 13:54:28 +0100
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     akpm@linux-foundation.org, adobriyan@gmail.com,
        gladkov.alexey@gmail.com, linux-kernel@vger.kernel.org,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] fs: proc: store PDE()->data into inode->i_private
Message-ID: <20211124125428.esjaqfsloq6owur6@wittgenstein>
References: <20211124081956.87711-1-songmuchun@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20211124081956.87711-1-songmuchun@bytedance.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Nov 24, 2021 at 04:19:55PM +0800, Muchun Song wrote:
> PDE_DATA(inode) is introduced to get user private data and hide the
> layout of struct proc_dir_entry. The inode->i_private is used to do
> the same thing as well. Save a copy of user private data to inode->
> i_private when proc inode is allocated. This means the user also can
> get their private data by inode->i_private.
> 
> Introduce pde_data() to wrap inode->i_private so that we can remove
> PDE_DATA() from fs/proc/generic.c and make PTE_DATE() as a wrapper
> of pde_data(). It will be easier if we decide to remove PDE_DATE()
> in the future.
> 
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
> ---

Seems like a good idea to me.
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
