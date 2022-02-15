Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF3B4B640D
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 08:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234745AbiBOHNC (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 02:13:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233306AbiBOHNC (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 02:13:02 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97F1B2510
        for <linux-fsdevel@vger.kernel.org>; Mon, 14 Feb 2022 23:12:52 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 32D0168AA6; Tue, 15 Feb 2022 08:12:49 +0100 (CET)
Date:   Tue, 15 Feb 2022 08:12:48 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Jeffle Xu <jefflexu@linux.alibaba.com>
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        vgoyal@redhat.com, hch@lst.de
Subject: Re: [PATCH] init: remove unused names parameter of split_fs_names()
Message-ID: <20220215071248.GA13301@lst.de>
References: <20220215070610.108967-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220215070610.108967-1-jefflexu@linux.alibaba.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Looks good:

Reviewed-by: Christoph Hellwig <hch@lst.de>
