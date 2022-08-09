Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AED6D58DE86
	for <lists+linux-fsdevel@lfdr.de>; Tue,  9 Aug 2022 20:19:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345649AbiHISTQ (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 9 Aug 2022 14:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346445AbiHISQw (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 9 Aug 2022 14:16:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FD927FCA;
        Tue,  9 Aug 2022 11:06:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98BA9B818B9;
        Tue,  9 Aug 2022 18:06:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5641C433D7;
        Tue,  9 Aug 2022 18:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660068370;
        bh=Q/IT8TeYiHsQkDHWQCu2erTQM5zCR+hDHL0QqEBEs4U=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qo2TpBZUiSGGYZpjJrhYhCyZmBB21Enm6U32Qb9kWKV9AmiqtLMuQjVwaSpXUWnO8
         Q0/3DfnG3WLsaEqu5XcRKmRIH90xIBtdAjqcb8jEhwjyNpoa2zsX5JCGQ9zTP9QMR5
         fqUFs7/qIBN1su94fURDj1ZCIDi24h8XI46oATJFKEfEENDu2IaqbyXe9uGa+BSAmd
         /GcOB/MsNr461uB/nDZX8LTF2M/VcRdqqHyjLpIOpbPBRM0CQzjfANnM+yvGXOKvxU
         duTxHrk5Gi3qn8soyHKPcQUfE0OPUVgFzg5DT7i46MPh7SP8w4nR7Y6l9hTSyIn0TJ
         CO9e/+QbLa+mQ==
Date:   Tue, 9 Aug 2022 18:06:08 +0000
From:   Eric Biggers <ebiggers@kernel.org>
To:     Lee Jones <lee.jones@linaro.org>
Cc:     Haimin Zhang <tcs.kernel@gmail.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Haimin Zhang <tcs_kernel@tencent.com>,
        TCS Robot <tcs_robot@tencent.com>, Lee Jones <lee@kernel.org>
Subject: Re: [PATCH v2] fs/pipe: Deinitialize the watch_queue when pipe is
 freed
Message-ID: <YvKiELcu4FeGQMKI@gmail.com>
References: <20220509131726.59664-1-tcs.kernel@gmail.com>
 <Ynl+kUGRYaovLc8q@sol.localdomain>
 <YsVYQAQ8ylvMQtR2@google.com>
 <Yta5+UOcK2rgBT6q@google.com>
 <YumdcdmPxqmx3AQc@sol.localdomain>
 <YvJ/XzuyWbZT2dlO@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YvJ/XzuyWbZT2dlO@google.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 09, 2022 at 04:38:07PM +0100, Lee Jones wrote:
> > 	commit 353f7988dd8413c47718f7ca79c030b6fb62cfe5
> > 	Author: Linus Torvalds <torvalds@linux-foundation.org>
> > 	Date:   Tue Jul 19 11:09:01 2022 -0700
> > 
> > 	    watchqueue: make sure to serialize 'wqueue->defunct' properly
> 
> Thanks Eric, I'll back-port this one instead.
> 

It's already in all LTS kernels that were affected (5.10 and later).

- Eric
