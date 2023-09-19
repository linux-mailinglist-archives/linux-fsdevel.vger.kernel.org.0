Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F35F7A5CA2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 19 Sep 2023 10:34:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231533AbjISIeY (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 19 Sep 2023 04:34:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbjISIeX (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 19 Sep 2023 04:34:23 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6560115;
        Tue, 19 Sep 2023 01:34:17 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F9C5C433C7;
        Tue, 19 Sep 2023 08:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1695112457;
        bh=2IMWONZ3PoEYBFGLmyiKA96Rqy/HORjdXmx0tiDo+fs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fO0mAAw1GcnpjJGoe3tfBZ974MCjxvldo5DmH5oWBAWgXrssUkIACNI68+5gI60CK
         8RiUlCrjq68tADbfo0uLR1f5uKCHaFt5oRtqBTbnJ9A3/x30i8G2bqJPxlF4xfNbyG
         QnDLTBkKSmFfqta6MUP5YA+uwZQyG1kAHeKuaNXk=
Date:   Tue, 19 Sep 2023 10:04:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     akpm@linux-foundation.org, muchun.song@linux.dev,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, david@fromorbit.com, tkhai@ya.ru,
        vbabka@suse.cz, roman.gushchin@linux.dev, djwong@kernel.org,
        brauner@kernel.org, paulmck@kernel.org, tytso@mit.edu,
        steven.price@arm.com, cel@kernel.org, senozhatsky@chromium.org,
        yujie.liu@intel.com, Muchun Song <songmuchun@bytedance.com>
Subject: Re: [PATCH] mm: shrinker: some cleanup
Message-ID: <2023091937-claw-denote-8945@gregkh>
References: <20230911094444.68966-2-zhengqi.arch@bytedance.com>
 <20230919024607.65463-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230919024607.65463-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Sep 19, 2023 at 10:46:07AM +0800, Qi Zheng wrote:
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Reviewed-by: Muchun Song <songmuchun@bytedance.com>
> ---
> Hi Andrew, this is a cleanup patch for [PATCH v6 01/45], there will be a
> small conflict with [PATCH v6 41/45].

I know I can't take patches without any changelog text, but maybe other
maintainers are more lax.

thanks,

greg k-h
