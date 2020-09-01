Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89CE259C25
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Sep 2020 19:12:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgIAPP7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 1 Sep 2020 11:15:59 -0400
Received: from verein.lst.de ([213.95.11.211]:53795 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbgIAPP6 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 1 Sep 2020 11:15:58 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 498D768CEC; Tue,  1 Sep 2020 17:15:56 +0200 (CEST)
Date:   Tue, 1 Sep 2020 17:15:55 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, willy@infradead.org,
        kernel-team@fb.com
Subject: Re: [PATCH 6/6] sunrpc: rework proc handlers to take advantage of
 the new buffer
Message-ID: <20200901151555.GF30709@lst.de>
References: <20200813210411.905010-1-josef@toxicpanda.com> <20200813210411.905010-7-josef@toxicpanda.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200813210411.905010-7-josef@toxicpanda.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Aug 13, 2020 at 05:04:11PM -0400, Josef Bacik wrote:
> +		len = scnprintf(buffer, *lenp, "0x%04x\n", *(unsigned int *) table->data);

This adds a really hard to read overlong long line.

Otherwise looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
