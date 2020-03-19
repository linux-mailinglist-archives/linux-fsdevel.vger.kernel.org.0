Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABBD18B956
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Mar 2020 15:27:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727452AbgCSO1x (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 19 Mar 2020 10:27:53 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:54872 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgCSO1x (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 19 Mar 2020 10:27:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kvtD+UmelXQ6+UeUUM3FkPq0h6Mly9+Z00iXw2LtUKA=; b=cnqGC1jrVvb2bDxWC1xUmvT0DQ
        VJ+Ot2RjADkFQOaM4+tLx4Wqohr2gAGkxdJ+cspwGG9tSz+sYOzVSvCwbJpIpqMWpGMM/dH5ybeMq
        yVTmflvFV1QhQjV+otAvqkAiLrRK5W3EjI/aQOpwv/9WSpM2EEqy5t2/6SKhry+JWlhlo8Y3vrCKV
        7fBvOSpkRCLbqSUqKjPHF6EyStj/gce4n0+Vri8inq/mxSHyC36ECruJ7mszhF0k40g2xw/9/qoVm
        fKcaKAHR+ecmfBlohZOn4AXC2J5+WXLvsbTvL7S+0xHg9XjzY1HwuHCOlIoZxmQiNSXJgu10+Pooz
        WUjqm8bw==;
Received: from willy by bombadil.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jEw9H-0007es-6J; Thu, 19 Mar 2020 14:27:51 +0000
Date:   Thu, 19 Mar 2020 07:27:51 -0700
From:   Matthew Wilcox <willy@infradead.org>
To:     Aravind Ceyardass <aravind.pub@gmail.com>
Cc:     gregkh@linuxfoundation.org, valdis.kletnieks@vt.edu,
        linux-fsdevel@vger.kernel.org, devel@driverdev.osuosl.org
Subject: Re: [PATCH] staging: exfat: Fix checkpatch.pl camelcase issues
Message-ID: <20200319142751.GK22433@bombadil.infradead.org>
References: <20200319140647.3926-1-aravind.pub@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200319140647.3926-1-aravind.pub@gmail.com>
Sender: linux-fsdevel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Mar 19, 2020 at 10:06:47AM -0400, Aravind Ceyardass wrote:
> Fix ffsCamelCase function names and mixed case enums

This driver is now gone from staging in -next; please review the code
in fs/exfat instead.
