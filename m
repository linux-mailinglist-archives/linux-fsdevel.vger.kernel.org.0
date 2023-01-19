Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C270B672D42
	for <lists+linux-fsdevel@lfdr.de>; Thu, 19 Jan 2023 01:11:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjASALc (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 18 Jan 2023 19:11:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbjASALb (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 18 Jan 2023 19:11:31 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00E64FACA;
        Wed, 18 Jan 2023 16:11:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uDH2bK8rZ4EvmDZSx6d3kF4/TgoCmtCadzBucAYFowQ=; b=QUTEd/dJ/7z1fKnP3Ye0lF5pEl
        rYpY83Vt1iCuqB+LJhT734FLGDxzeqdcCsu8gOqjBwIn0La9DxSt31DI8IjZb5pM8oBxcUEAOVH5y
        0rMibr3xhjbshiwQh+Wvf0XSnNTGD6vNeCuSXjcE+utxpbfFCkxKqI4PQdNR6qy/ZDhKYJMsLcLU9
        oGCMXJDPWeRzCLLfrxayWmVhA+mvd4Z0Xus3pv9Q21IrCADev2wEtkDjBRy7+7dF0wiwAhxgkrETp
        6xG9YC2Jr6JJ9LXjl1yEt3aCXEMaEoxzTilvI5dcsCAJPrP00N23JazeVL63Qzl3DeTnXwhnYRK96
        iPfhj1PQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pIIW4-0030fE-FS; Thu, 19 Jan 2023 00:10:52 +0000
Date:   Wed, 18 Jan 2023 16:10:52 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Meng Tang <tangmeng@uniontech.com>
Cc:     keescook@chromium.org, yzaikin@google.com, ebiederm@xmission.com,
        willy@infradead.org, kbuild-all@lists.01.org,
        nixiaoming@huawei.com, nizhen@uniontech.com,
        zhanglianjie@uniontech.com, sujiaxun@uniontech.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v5 1/2] fs/proc: optimize register ctl_tables
Message-ID: <Y8iKjJYMFRSthxzn@bombadil.infradead.org>
References: <20220304112341.19528-1-tangmeng@uniontech.com>
 <202203081905.IbWENTfU-lkp@intel.com>
 <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y7xWUQQIJYLMk5fO@bombadil.infradead.org>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, Jan 09, 2023 at 10:00:49AM -0800, Luis Chamberlain wrote:
> On Tue, Mar 08, 2022 at 07:22:51PM +0800, kernel test robot wrote:
> > Hi Meng,
> > 
> > Thank you for the patch! Perhaps something to improve:
> 
> Meng, can you re-send with a fix? We're early in the merge window to
> help test stuff now.

*re-poke* if you can't work on this please let me know!

  Luis
