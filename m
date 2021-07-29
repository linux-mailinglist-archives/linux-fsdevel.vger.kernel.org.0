Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D502D3DA72A
	for <lists+linux-fsdevel@lfdr.de>; Thu, 29 Jul 2021 17:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237278AbhG2PIZ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 29 Jul 2021 11:08:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:59188 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229934AbhG2PIY (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 29 Jul 2021 11:08:24 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2E90D60EBC;
        Thu, 29 Jul 2021 15:08:19 +0000 (UTC)
Date:   Thu, 29 Jul 2021 17:08:16 +0200
From:   Christian Brauner <christian.brauner@ubuntu.com>
To:     Vivek Goyal <vgoyal@redhat.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, hch@lst.de, virtio-fs@redhat.com,
        v9fs-developer@lists.sourceforge.net, stefanha@redhat.com,
        miklos@szeredi.hu
Subject: Re: [PATCH v3 0/3] support booting of arbitrary non-blockdevice file
 systems
Message-ID: <20210729150816.jg5brzgt7nndhtdi@wittgenstein>
References: <20210714202321.59729-1-vgoyal@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210714202321.59729-1-vgoyal@redhat.com>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Jul 14, 2021 at 04:23:18PM -0400, Vivek Goyal wrote:
> Hi,
> 
> This is V3 of patches. Christoph had posted V2 here.
> 
> https://lore.kernel.org/linux-fsdevel/20210621062657.3641879-1-hch@lst.de/
> 
> There was a small issue in last patch series that list_bdev_fs_names()
> did not put an extra '\0' at the end as current callers were expecting.
> 
> To fix this, I have modified list_bdev_fs_names() and split_fs_names()
> to return number of null terminated strings they have parsed. And
> modified callers to use that to loop through strings (instead of
> relying on an extra null at the end).
> 
> Christoph was finding it hard to find time so I took his patches, 
> added my changes in patch3 and reposting the patch series.
> 
> I have tested it with 9p, virtiofs and ext4 filesystems as rootfs
> and it works for me.

lgtm,
Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
