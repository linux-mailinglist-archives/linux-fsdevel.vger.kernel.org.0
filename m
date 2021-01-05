Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4BD22EA62B
	for <lists+linux-fsdevel@lfdr.de>; Tue,  5 Jan 2021 08:52:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbhAEHv2 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 5 Jan 2021 02:51:28 -0500
Received: from verein.lst.de ([213.95.11.211]:60401 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725766AbhAEHv2 (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 5 Jan 2021 02:51:28 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3B83D67373; Tue,  5 Jan 2021 08:50:46 +0100 (CET)
Date:   Tue, 5 Jan 2021 08:50:46 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Satya Tangirala <satyat@google.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fs: Fix freeze_bdev()/thaw_bdev() accounting of
 bd_fsfreeze_sb
Message-ID: <20210105075046.GB30039@lst.de>
References: <20201224044954.1349459-1-satyat@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201224044954.1349459-1-satyat@google.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
