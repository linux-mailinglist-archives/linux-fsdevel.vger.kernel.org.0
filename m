Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C7E8534AC7
	for <lists+linux-fsdevel@lfdr.de>; Thu, 26 May 2022 09:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236611AbiEZH3s (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 26 May 2022 03:29:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234551AbiEZH3r (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 26 May 2022 03:29:47 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9332C814B8;
        Thu, 26 May 2022 00:29:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3DAB9B81ED1;
        Thu, 26 May 2022 07:29:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BCC0C34116;
        Thu, 26 May 2022 07:29:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653550183;
        bh=LJyMJ2/8TUA/U2Fc1ZAQGTxCro54ddGUa76D0dKRWrw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hRx2ujSZtcY3iQWk1c9JgIEtJjkRVobrOrFiiv0chHvFGB9YVJBjZM+vKAiRrkPwJ
         nwn5BmCQyBm3G4XiQ0PunNyAjCDGhgGbuuIZ8aDuR98JF8w9Gby+o239PpgexEwAWb
         pRGsRGyT06uFbDHpXdMe3c6FVpwCIrEcaBf7sqC6QL4nwKxWkAVreS7gGb1c269w/l
         sRtaqi8uO5atAqats2JTD08oS9VWzNFOTEVVUiXBET0gaq/mLfOKDLj6ogebLTHrlv
         9WIWwDBaqu9Zk9uQt+txo3Uz+WjkeO11nJLVPhHkckCLkh1viJGfEuIgVhq1rgbVul
         G+/eEEtZGWWdw==
Date:   Thu, 26 May 2022 00:29:41 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Keith Busch <kbusch@fb.com>
Cc:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk, Kernel Team <Kernel-team@fb.com>, hch@lst.de,
        bvanassche@acm.org, damien.lemoal@opensource.wdc.com,
        pankydev8@gmail.com, Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCHv4 8/9] block: relax direct io memory alignment
Message-ID: <Yo8sZWNNTKM2Kwqm@sol.localdomain>
References: <20220526010613.4016118-1-kbusch@fb.com>
 <20220526010613.4016118-9-kbusch@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220526010613.4016118-9-kbusch@fb.com>
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, May 25, 2022 at 06:06:12PM -0700, Keith Busch wrote:
> +	/*
> +	 * Each segment in the iov is required to be a block size multiple.

Where is this enforced?

- Eric
