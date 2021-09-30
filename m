Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B480F41DC7F
	for <lists+linux-fsdevel@lfdr.de>; Thu, 30 Sep 2021 16:39:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349970AbhI3Olb (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 30 Sep 2021 10:41:31 -0400
Received: from verein.lst.de ([213.95.11.211]:59885 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1349768AbhI3Ol3 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 30 Sep 2021 10:41:29 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 9512567373; Thu, 30 Sep 2021 16:39:43 +0200 (CEST)
Date:   Thu, 30 Sep 2021 16:39:43 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Anders Roxell <anders.roxell@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel@vger.kernel.org
Subject: Re: regression: kernel panic: 9pnet_virtio: no channels available
 for device root
Message-ID: <20210930143943.GA25714@lst.de>
References: <CADYN=9KXWCA-pi8VCS5r_JScsuRyWBEKqtdBFCAGzg1vq4M5FQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADYN=9KXWCA-pi8VCS5r_JScsuRyWBEKqtdBFCAGzg1vq4M5FQ@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Sep 30, 2021 at 11:25:45AM +0200, Anders Roxell wrote:
> Hi Christoph,
> 
> I've found a boot regression when ran my allmodconfig kernel on tag v5.15-rc1
> I've bisected it down to commit f9259be6a9e7 ("init: allow mounting
> arbitrary non-blockdevice filesystems as root"), see the bisect log
> [1].

Please try a kernel with:

"init: don't panic if mount_nodev_root failed" included.
