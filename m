Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD0E4E518A
	for <lists+linux-fsdevel@lfdr.de>; Wed, 23 Mar 2022 12:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235930AbiCWLqr (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 23 Mar 2022 07:46:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235880AbiCWLqq (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 23 Mar 2022 07:46:46 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F9D775612;
        Wed, 23 Mar 2022 04:45:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D13E1B81E7D;
        Wed, 23 Mar 2022 11:45:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03B4FC340E9;
        Wed, 23 Mar 2022 11:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1648035914;
        bh=IxpqzFI6WpDddlfyiBF2wn59Avf/l0dP3T+qrOocd+A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=yTrCs3UHixDyJX/Led6DPpdXFOlXJxVE01dbxPBveuAhCrsqoH/gqsjSlooQX7n/V
         g4aKYNEAHUfcMowFHxXkY2NvZT/h3pGoCL+7RnymvWhXSHIeSR2RZL5I2YDtm5Lvha
         ktycQqB4uaNQt5ec+MtA8Kqr2OSmz4B9rAdbiheE=
Date:   Wed, 23 Mar 2022 12:45:11 +0100
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     =?utf-8?B?55Sw5a2Q5pmo?= <tianzichen@kuaishou.com>
Cc:     "jefflexu@linux.alibaba.com" <jefflexu@linux.alibaba.com>,
        "chao@kernel.org" <chao@kernel.org>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "gerry@linux.alibaba.com" <gerry@linux.alibaba.com>,
        "joseph.qi@linux.alibaba.com" <joseph.qi@linux.alibaba.com>,
        "linux-cachefs@redhat.com" <linux-cachefs@redhat.com>,
        "linux-erofs@lists.ozlabs.org" <linux-erofs@lists.ozlabs.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "luodaowen.backend@bytedance.com" <luodaowen.backend@bytedance.com>,
        "torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
        "willy@infradead.org" <willy@infradead.org>,
        "xiang@kernel.org" <xiang@kernel.org>
Subject: Re: [PATCH v5 00/22] fscache, erofs: fscache-based on-demand read
 semantics
Message-ID: <YjsIR886wCKosNNu@kroah.com>
References: <B6EA31D4-877C-450E-BF89-2879044B9EAD@kuaishou.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <B6EA31D4-877C-450E-BF89-2879044B9EAD@kuaishou.com>
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Mar 23, 2022 at 08:38:07AM +0000, 田子晨 wrote:
> This solution looks good, and we’ re also interested  in it ,  please accelerate its progress so we can use it.

Please test the patches and provide your feedback on it (i.e.
"Reviewed-by:" and the like.)

thanks,

greg k-h
