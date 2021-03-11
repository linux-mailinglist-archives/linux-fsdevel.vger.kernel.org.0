Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ADAFA336AE3
	for <lists+linux-fsdevel@lfdr.de>; Thu, 11 Mar 2021 04:45:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230341AbhCKDoo (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 10 Mar 2021 22:44:44 -0500
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:50434 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbhCKDoj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 10 Mar 2021 22:44:39 -0500
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lKCDA-004mXI-8w; Thu, 11 Mar 2021 03:42:08 +0000
Date:   Thu, 11 Mar 2021 03:42:08 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     Joel Becker <jlbec@evilplan.org>, Christoph Hellwig <hch@lst.de>,
        linux-kernel@vger.kernel.org, chao@kernel.org,
        Daiyue Zhang <zhangdaiyue1@huawei.com>,
        Yi Chen <chenyi77@huawei.com>, Ge Qiu <qiuge@huawei.com>,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] configfs: Fix use-after-free issue in
 __configfs_open_file
Message-ID: <YEmRkGNR+aV75XRz@zeniv-ca.linux.org.uk>
References: <20210301061053.105377-1-yuchao0@huawei.com>
 <040d3680-0e12-7957-da05-39017d33edb4@huawei.com>
 <c9aa911a-aebc-37b8-67b3-b7670424226b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c9aa911a-aebc-37b8-67b3-b7670424226b@huawei.com>
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 11, 2021 at 10:16:20AM +0800, Chao Yu wrote:
> Hi Joel, Christoph, Al
> 
> Does any one have time to review this patch, ten days past...

Acked-by: Al Viro <viro@zeniv.linux.org.uk>
