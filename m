Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 372B0528B0E
	for <lists+linux-fsdevel@lfdr.de>; Mon, 16 May 2022 18:51:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231331AbiEPQvM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 16 May 2022 12:51:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbiEPQuu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 16 May 2022 12:50:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219B0F5A;
        Mon, 16 May 2022 09:50:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0EABB8129E;
        Mon, 16 May 2022 16:50:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B361FC385AA;
        Mon, 16 May 2022 16:50:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1652719845;
        bh=aIoDNV2IGPxtQc7HeqOA+8QRSnifu/9FS8Wc/iA5hfQ=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=df1qswQIIJgEcyIQhacqK/okIEA7fHVo8jxT/5qsq64rB0UAD0Rvsl/8xa+kjb09y
         Fv2UkAYbbsF1J8+6DR04/kd830534h6OWuy+Mxp5GPYysLCP4HT2x3lBLiwmDIfUsA
         MNm7Oc8Wk4VNCgDgkg5ebRzNCNgtuKozCmBX9Pus=
Date:   Mon, 16 May 2022 18:50:40 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Krzysztof =?utf-8?Q?B=C5=82aszkowski?= <kb@sysmikro.com.pl>,
        Christoph Hellwig <hch@lst.de>, linux-spdx@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] freevxfs: relicense to GPLv2 only
Message-ID: <YoKA4AhEXF4tEVlZ@kroah.com>
References: <20220516133825.2810911-1-hch@lst.de>
 <1652713968.3497.416.camel@sysmikro.com.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1652713968.3497.416.camel@sysmikro.com.pl>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 16, 2022 at 05:12:48PM +0200, Krzysztof Błaszkowski wrote:
> Acked-by: Krzysztof Błaszkowski <kb@sysmikro.com.pl>

Thanks!

Christoph, want me to take this through my spdx.git tree, or are you
going to take it through some vfs tree?

thanks,

greg k-h
