Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 679D978866E
	for <lists+linux-fsdevel@lfdr.de>; Fri, 25 Aug 2023 13:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242401AbjHYLzU (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Fri, 25 Aug 2023 07:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244526AbjHYLzS (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Fri, 25 Aug 2023 07:55:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9841FD7;
        Fri, 25 Aug 2023 04:55:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7BB946517F;
        Fri, 25 Aug 2023 11:55:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E184C433C8;
        Fri, 25 Aug 2023 11:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692964515;
        bh=rFjKn4imIGwDcgITQT7lDgFSZid7uAdzqIQAzRBJVps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WdNoCmn8GmB1PE+n9uUw0mZXFEPBmuU+wz6469l8Ne02dolXREvbpuA66nglD71HZ
         D9UIbPvrECeMwrZoQmguaZCW/EmMFbyfvTlQkuwC+IV9nGjeUmBii3dO0AKgs5AHGw
         Z3lfed/Jsb70UzQgnv11l0+A8zZvIpqFXy04ktc8GmAj0vzq4BfIF2fXzqu/jjgvEp
         JFltj7Dnw2V5JiN2VFxuoBBTQ+rlXtYaIw+ppFP0qE45rkrjkN+iHi1h1KZsCdictX
         Zzd+5vLFoqXWdcup+dbKhvhXl2oZCuf1dIYHhJTuY0Qks2plNjKOTXMMYhxhM+hXT8
         yHUrolJemv00A==
Date:   Fri, 25 Aug 2023 13:55:11 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Jan Kara <jack@suse.cz>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
        Jack Wang <jinpu.wang@ionos.com>,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 06/29] rnbd-srv: Convert to use bdev_open_by_path()
Message-ID: <20230825-zusprach-reizt-ee16350d1486@brauner>
References: <20230818123232.2269-1-jack@suse.cz>
 <20230823104857.11437-6-jack@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230823104857.11437-6-jack@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Aug 23, 2023 at 12:48:17PM +0200, Jan Kara wrote:
> Convert rnbd-srv to use bdev_open_by_path() and pass the handle
> around.
> 
> CC: Jack Wang <jinpu.wang@ionos.com>
> CC: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Acked-by: "Md. Haris Iqbal" <haris.iqbal@ionos.com>
> Acked-by: Christoph Hellwig <hch@lst.de>
> Signed-off-by: Jan Kara <jack@suse.cz>
> ---

Looks good to me,
Acked-by: Christian Brauner <brauner@kernel.org>
