Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0CD35F83B8
	for <lists+linux-fsdevel@lfdr.de>; Sat,  8 Oct 2022 07:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230018AbiJHF63 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Sat, 8 Oct 2022 01:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229886AbiJHF5P (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Sat, 8 Oct 2022 01:57:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9B3DD9966;
        Fri,  7 Oct 2022 22:56:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3093A60BEF;
        Sat,  8 Oct 2022 05:56:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87B57C433C1;
        Sat,  8 Oct 2022 05:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665208583;
        bh=s0LjJFfi+hfHWwyYzeazkY4sx1RI6b2GS+sMxd09+dQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QFSnyER77mdb0qwHg5PA4HkheV448oi8kv9npavvKSc+uciqbe7TxsDNYsHY+s0VL
         XnNIvoKvJLvpt4s8CQQRiWJh1MtyzzA84puETvSKPvUS4sWGXaRJQllJiRltcy8Tfq
         q//9aShAOk8zeNIBmZbyH+46LVLYr3M9z43NYPPtKUuh/LJY2VWern39oWYngvwmRS
         E6XEsEE9xIQlAmPkTBgUu3c/T29c6Tg3Dy1IlGhbmPOuzFuj9a4MC8Ja0q0M/xs0zy
         CiOA5UHCnEnaBt9rlUGgp0lm+UyXOrs+sNoml0srTYwPuxuaWMODRYWCl5n+7ySug8
         NROfNan6f27sA==
Date:   Sat, 8 Oct 2022 07:56:17 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Miklos Szeredi <miklos@szeredi.hu>,
        "Darrick J . Wong" <djwong@kernel.org>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@lst.de>,
        Seth Forshee <sforshee@kernel.org>,
        Yang Xu <xuyang2018.jy@fujitsu.com>,
        Filipe Manana <fdmanana@kernel.org>,
        linux-unionfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v2 2/5] attr: add should_remove_sgid()
Message-ID: <20221008055617.ssv7sbe4gj556oxq@wittgenstein>
References: <20221007140543.1039983-3-brauner@kernel.org>
 <202210080357.inSALqdT-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <202210080357.inSALqdT-lkp@intel.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Sat, Oct 08, 2022 at 03:16:04AM +0800, kernel test robot wrote:
> Hi Christian,
> 
> I love your patch! Perhaps something to improve:
> 
> [auto build test WARNING on mszeredi-vfs/overlayfs-next]
> [cannot apply to linus/master mszeredi-fuse/for-next v6.0 next-20221007]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use '--base' as documented in
> https://git-scm.com/docs/git-format-patch#_base_tree_information]

This isn't rebased and thus will fail to apply. There'll be a merge
conflict with changes to fs/internal.h for current master. Best to wait
until I have rebased this after v6.0-rc1 is out.
