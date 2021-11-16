Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC923452B45
	for <lists+linux-fsdevel@lfdr.de>; Tue, 16 Nov 2021 08:02:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229821AbhKPHFH (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 16 Nov 2021 02:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhKPHFE (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 16 Nov 2021 02:05:04 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9793BC061570;
        Mon, 15 Nov 2021 23:02:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=9O9LeemITfaaRw8Q1oPHpbkLMx3Z1yM41ar7YR296AA=; b=cd9NKeyx5PUacss3NkHLQ6VLLB
        PzW2oNQ8P3OkxkmNcigPBSPXbcTwT/1CiA/O1E8ZFyknhVwGAiE47zCmXgZSvTURzPCTf2yTG5eLy
        ozApMZiMh6/mp9X1cTqY7zBAzKrdMAV9rBOUDnzmlc9l9/JQy5v/9DJ9mTeWAfaZe66kKW+TKS+Wn
        q+ekqmeqdLcaemLbrVetbOLyvgt8dZQ8c9bdddTgIi+T6/cgkfzeQgIPnXmK+TmCtDEGF+vSnFycY
        qOBQ36ehR767x78XqhK4OdRXCxZUjsYAx1lPMh6LeQVzRng+a12MO6VhlDPSJTaVcBX4CbSIXPhOD
        /3H2c/jg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mmsTm-000Xi4-UO; Tue, 16 Nov 2021 07:02:06 +0000
Date:   Mon, 15 Nov 2021 23:02:06 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jubin Zhong <zhongjubin@huawei.com>
Cc:     hch@infradead.org, kechengsong@huawei.com,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org,
        viro@zeniv.linux.org.uk, wangfangpeng1@huawei.com
Subject: Re: [PATCH] fs: Fix truncate never updates m/ctime
Message-ID: <YZNXbtQg2UObtbxA@infradead.org>
References: <YZNADLcSbgKp5Znh@infradead.org>
 <1637045848-56278-1-git-send-email-zhongjubin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1637045848-56278-1-git-send-email-zhongjubin@huawei.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

> In my opinion, there are two advantages if we fix it in
> vfs_truncate():

Please actually read the comments in the xfs setattr implementation
I pointed you to first time.
