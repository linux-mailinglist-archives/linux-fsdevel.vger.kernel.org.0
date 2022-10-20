Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204D7605B70
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 11:48:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbiJTJsG (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 05:48:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbiJTJsF (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:48:05 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 703CA1905C9;
        Thu, 20 Oct 2022 02:48:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1A5B3B826B4;
        Thu, 20 Oct 2022 09:48:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD33C433D7;
        Thu, 20 Oct 2022 09:48:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666259281;
        bh=Yak28Bs3nSx0EoYl1CRhGukZ6bA583kADsVGBoFftuM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=CRUJ0s0zKzfoJTTsTbVVuU9p+qn/yZxe41U1m0ldxfBpuNwS1s4PcldtbMeWBPa8x
         RNcNtkmN0UNgaxQux9zSCJZ6lzYWPY1c+cHzqr5XqpsynplaVRoxhIezXh1/RFbc7T
         SpkUaV6T9H30eyOhHYgtPtESxaFwUsNHSEEXWO0U=
Date:   Thu, 20 Oct 2022 11:47:58 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cuijinpeng666@gmail.com
Cc:     viro@zeniv.linux.org.uk, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jinpeng Cui <cui.jinpeng2@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] fs/super.c: use strscpy() is more robust and
 safer
Message-ID: <Y1EZTulMzGzgB7W9@kroah.com>
References: <20221020030915.393801-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020030915.393801-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 03:09:15AM +0000, cuijinpeng666@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>

Please ignore based on this response:
	https://lore.kernel.org/r/Y1EVnZS9BalesrC1@kroah.com

