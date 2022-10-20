Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6464605B7D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 20 Oct 2022 11:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229870AbiJTJtk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 20 Oct 2022 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJTJtd (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 20 Oct 2022 05:49:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3137226FC;
        Thu, 20 Oct 2022 02:49:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AC31B8269E;
        Thu, 20 Oct 2022 09:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8456C433D6;
        Thu, 20 Oct 2022 09:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666259360;
        bh=7h0QGpJnCc0vidIZ0+ecsmfVGx8Hw0AmYaoBuW2o/hE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w+fAnxcTKy2pgsxndjRBGZHEkTYpANsfABAzcDnLosNy6SGsTxOdlF5psr6o+/oUb
         V8tTZO2C2zeYDvaur7X60ARuxret9TFwCG9GTfEpe8NtkhyraGjXIkELQ/7cmId/5m
         bctNPyh36nWfSP/4ygqxAvsavi1MYv+i2OWR7piw=
Date:   Thu, 20 Oct 2022 11:49:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     cuijinpeng666@gmail.com
Cc:     akpm@linux-foundation.org, liushixin2@huawei.com, deller@gmx.de,
        cui.jinpeng2@zte.com.cn, guoren@kernel.org,
        wangkefeng.wang@huawei.com, jakobkoschel@gmail.com,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: Re: [PATCH linux-next] fs/proc/kcore.c: Use strscpy() instead of
 strlcpy()
Message-ID: <Y1EZnRepnoYqEtEo@kroah.com>
References: <20221020092044.399139-1-cui.jinpeng2@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221020092044.399139-1-cui.jinpeng2@zte.com.cn>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Thu, Oct 20, 2022 at 09:20:44AM +0000, cuijinpeng666@gmail.com wrote:
> From: Jinpeng Cui <cui.jinpeng2@zte.com.cn>
> 
> The implementation of strscpy() is more robust and safer.
> 
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Jinpeng Cui <cui.jinpeng2@zte.com.cn>


Please ignore based on this response:
	https://lore.kernel.org/r/Y1EVnZS9BalesrC1@kroah.com

