Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CFB78171F5
	for <lists+linux-fsdevel@lfdr.de>; Wed,  8 May 2019 08:57:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfEHG5m (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 8 May 2019 02:57:42 -0400
Received: from verein.lst.de ([213.95.11.211]:37432 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726179AbfEHG5m (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 8 May 2019 02:57:42 -0400
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 71A2C68AFE; Wed,  8 May 2019 08:57:23 +0200 (CEST)
Date:   Wed, 8 May 2019 08:57:23 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     viro@zeniv.linux.org.uk, jlbec@evilplan.org, hch@lst.de,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2] configfs: Fix possible use-after-free in
 configfs_register_group
Message-ID: <20190508065723.GA21298@lst.de>
References: <20190505030312.26548-1-yuehaibing@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190505030312.26548-1-yuehaibing@huawei.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Thanks,

applied to the configfs tree.
