Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DDD6E8D1EE
	for <lists+linux-fsdevel@lfdr.de>; Wed, 14 Aug 2019 13:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbfHNLQz (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 14 Aug 2019 07:16:55 -0400
Received: from verein.lst.de ([213.95.11.211]:37193 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726121AbfHNLQy (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 14 Aug 2019 07:16:54 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id AA6A568BFE; Wed, 14 Aug 2019 13:16:51 +0200 (CEST)
Date:   Wed, 14 Aug 2019 13:16:51 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, adilger@dilger.ca,
        jaegeuk@kernel.org, darrick.wong@oracle.com, miklos@szeredi.hu,
        rpeterso@redhat.com, linux-xfs@vger.kernel.org
Subject: Re: [PATCH 7/9] fiemap: Use a callback to fill fiemap extents
Message-ID: <20190814111651.GD1885@lst.de>
References: <20190808082744.31405-1-cmaiolino@redhat.com> <20190808082744.31405-8-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190808082744.31405-8-cmaiolino@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
