Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 237E8107359
	for <lists+linux-fsdevel@lfdr.de>; Fri, 22 Nov 2019 14:37:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726776AbfKVNh2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 22 Nov 2019 08:37:28 -0500
Received: from verein.lst.de ([213.95.11.211]:52045 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbfKVNh1 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 22 Nov 2019 08:37:27 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5938268C4E; Fri, 22 Nov 2019 14:37:26 +0100 (CET)
Date:   Fri, 22 Nov 2019 14:37:26 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Carlos Maiolino <cmaiolino@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org, hch@lst.de, darrick.wong@oracle.com,
        sandeen@sandeen.net
Subject: Re: [PATCH 2/5] cachefiles: drop direct usage of ->bmap method.
Message-ID: <20191122133726.GB25822@lst.de>
References: <20191122085320.124560-1-cmaiolino@redhat.com> <20191122085320.124560-3-cmaiolino@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191122085320.124560-3-cmaiolino@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good modulo the changelog placement.

Reviewed-by: Christoph Hellwig <hch@lst.de>
