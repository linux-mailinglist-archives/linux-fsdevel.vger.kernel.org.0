Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4720231042
	for <lists+linux-fsdevel@lfdr.de>; Tue, 28 Jul 2020 18:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731660AbgG1Q7V (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 28 Jul 2020 12:59:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:60068 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731523AbgG1Q7U (ORCPT <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 28 Jul 2020 12:59:20 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 9984220786;
        Tue, 28 Jul 2020 16:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595955560;
        bh=ST3jWuFkG0CSvKv9iyNhigR7bR7h19swnEuLsvlSNtQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=feWGph0v83Feyg1UNLeoqkFE8DHV0ZuQPJtqOqQtXfKxlYIfuo/bbvgwjzCogOGef
         LwOmfDpbimOLkdZBfrljmnaN3lxwK6Q123BKcNcpEd6nF0w67ibb9rHnyJ9eoxK2rG
         dHozXIwlwuUHq9iKal2iRKjSftyPBZsCW7m7sY0A=
Date:   Tue, 28 Jul 2020 18:59:13 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-api@vger.kernel.org
Subject: Re: [PATCH 04/23] devtmpfs: refactor devtmpfsd()
Message-ID: <20200728165913.GB42656@kroah.com>
References: <20200728163416.556521-1-hch@lst.de>
 <20200728163416.556521-5-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200728163416.556521-5-hch@lst.de>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jul 28, 2020 at 06:33:57PM +0200, Christoph Hellwig wrote:
> Split the main worker loop into a separate function.  This allows
> devtmpfsd_setup to be marked __init, which will allows us to call
> __init routines for the setup work.  devtmpfѕ itself needs a __ref
> marker for that to work, and a comment explaining why it works.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
