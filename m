Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 318CB4B6969
	for <lists+linux-fsdevel@lfdr.de>; Tue, 15 Feb 2022 11:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiBOKhj (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Feb 2022 05:37:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236579AbiBOKhh (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Feb 2022 05:37:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7718716D9;
        Tue, 15 Feb 2022 02:37:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8047CB811E6;
        Tue, 15 Feb 2022 10:37:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C2BEC340EB;
        Tue, 15 Feb 2022 10:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644921445;
        bh=SAHwZf+C5kw7QdhTev5TQhNms75eRKLT8hrY2rJqmsg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qbdceTkRnpNHIdUqG4UWqLop7ma2y9dDgXNdXTdMf7nr4q/HjMtO3mv42YD58TquB
         Nw22GGzBmhz4W8RrYrPTlFvpxKBceI4ywfKL4yaJWunWVGQvDqjY/Kt8LoNDYh/gr+
         Q/MfGDlp/xSMAurFNlIYDzHnnMawhIdjxoFhKDVw=
Date:   Tue, 15 Feb 2022 11:37:22 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     JeffleXu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com, xiang@kernel.org,
        chao@kernel.org, linux-erofs@lists.ozlabs.org, willy@infradead.org,
        linux-kernel@vger.kernel.org, joseph.qi@linux.alibaba.com,
        linux-fsdevel@vger.kernel.org, gerry@linux.alibaba.com,
        torvalds@linux-foundation.org
Subject: Re: [PATCH v3 05/22] cachefiles: introduce new devnode for on-demand
 read mode
Message-ID: <YguCYmvdyRAOjHcP@kroah.com>
References: <20220209060108.43051-1-jefflexu@linux.alibaba.com>
 <20220209060108.43051-6-jefflexu@linux.alibaba.com>
 <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bd9cb3bb-e29c-d4b3-e9bf-915b9771b553@linux.alibaba.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 15, 2022 at 05:03:16PM +0800, JeffleXu wrote:
> Hi David,
> 
> FYI I've updated this patch on [1].
> 
> [1]
> https://github.com/lostjeffle/linux/commit/589dd838dc539aee291d1032406653a8f6269e6f.

We can not review random github links :(

