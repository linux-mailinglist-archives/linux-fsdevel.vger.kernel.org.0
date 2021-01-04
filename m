Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B8642E91E8
	for <lists+linux-fsdevel@lfdr.de>; Mon,  4 Jan 2021 09:39:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726173AbhADIjO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 4 Jan 2021 03:39:14 -0500
Received: from verein.lst.de ([213.95.11.211]:56887 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725616AbhADIjO (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 4 Jan 2021 03:39:14 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 2E0D96736F; Mon,  4 Jan 2021 09:38:31 +0100 (CET)
Date:   Mon, 4 Jan 2021 09:38:30 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Sargun Dhillon <sargun@sargun.me>
Cc:     Christoph Hellwig <hch@lst.de>, Al Viro <viro@zeniv.linux.org.uk>,
        Kyle Anderson <kylea@netflix.com>,
        Manas Alekar <malekar@netflix.com>,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org,
        Rob Gulewich <rgulewich@netflix.com>,
        Zoran Simic <zsimic@netflix.com>, stable@vger.kernel.org
Subject: Re: [RESEND PATCH] fs: Validate flags and capabilities before
 looking up path in ksys_umount
Message-ID: <20210104083830.GA28271@lst.de>
References: <20201228204438.1726-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201228204438.1726-1-sargun@sargun.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
