Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021B41FC820
	for <lists+linux-fsdevel@lfdr.de>; Wed, 17 Jun 2020 10:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726341AbgFQIDX (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 17 Jun 2020 04:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725773AbgFQIDW (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 17 Jun 2020 04:03:22 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05402C061573;
        Wed, 17 Jun 2020 01:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=NMpqp1Po11wPc+OD0tz0uL8QRWn/5SXktIpHxMSID1Q=; b=PiQQyFj3/Lid+T0g4v7zSlPeeG
        BiAy34rtFGnQNTqvQKyD+Lwnd7ZZJqzKMizujBEmc75hqT6AYHc0KIyoNmEVuSboIXk7d6RG1Vvrn
        5JWnElGaUxkljCpb9fri77myQ4TknPnTwWDi5ucSm7wYBQBHJl27K+6+fH1vkPNLT39APX465hWcQ
        U2/C72zjJB1yHdumJhntT+6Q9ByxRwdfqFPluwwt//ICEENj5GW+yeRrLS/KoHUPNHEy8Gy59RiK9
        2yHnYKI+tW7N2tC0bwEcx/EKBwiZn9i5g9jCIWxTnp9ec1z6My25Yyl+BSv+J2O7D14YzFULPuHkS
        4YfEuhHg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jlT2Q-00022O-E7; Wed, 17 Jun 2020 08:03:14 +0000
Date:   Wed, 17 Jun 2020 01:03:14 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Masayoshi Mizuma <msys.mizuma@gmail.com>
Cc:     Theodore Ts'o <tytso@mit.edu>,
        Andreas Dilger <adilger.kernel@dilger.ca>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>,
        linux-ext4@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH] fs: i_version mntopt gets visible through /proc/mounts
Message-ID: <20200617080314.GA7147@infradead.org>
References: <20200616202123.12656-1-msys.mizuma@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200616202123.12656-1-msys.mizuma@gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jun 16, 2020 at 04:21:23PM -0400, Masayoshi Mizuma wrote:
> From: Masayoshi Mizuma <m.mizuma@jp.fujitsu.com>
> 
> /proc/mounts doesn't show 'i_version' even if iversion
> mount option is set to XFS.
> 
> iversion mount option is a VFS option, not ext4 specific option.
> Move the handler to show_sb_opts() so that /proc/mounts can show
> 'i_version' on not only ext4 but also the other filesystem.

SB_I_VERSION is a kernel internal flag.  XFS doesn't have an i_version
mount option.
