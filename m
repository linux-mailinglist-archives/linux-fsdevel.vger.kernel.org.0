Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFBBF6D8D15
	for <lists+linux-fsdevel@lfdr.de>; Thu,  6 Apr 2023 03:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjDFBzM (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 5 Apr 2023 21:55:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230527AbjDFBzK (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 5 Apr 2023 21:55:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59A283CA;
        Wed,  5 Apr 2023 18:54:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07C10618D7;
        Thu,  6 Apr 2023 01:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65538C433EF;
        Thu,  6 Apr 2023 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680746022;
        bh=RU0Q3vUCSoOriMTSmQ2CiAo6okbHQsDApEtyfqhB/os=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FbWqGQ0wbGurzrP9KVHM0SNw0YC9GyWApFTXwdNVcK2A0TiZtlGaba89nxCOMrOnv
         LWjeD76eOESSoHb3bjdBWreXKq9o6hYFzR7svS/T2cmmEB82GOCY4PQ4xwOErbFzpU
         hmcAghCKLKqbx4A0blihXUGzlq7+9VmymPLp1sU/9GKwTNgaMazWLz2aF2o38rqb3J
         b3LRiP0wTjMiqcG9t360E1ofmIBaOFnuhJb3uzgevc579iZR/wnVuIvdPxErd0uHqj
         plvf4gfX7jEtsbHb5zbnA4A6/Ie41UsiXOM4Khj5aTYqCMkOCJ9lIg3iiItz27lqAh
         KTIvUAvOE5HOQ==
Message-ID: <b0214d14-aa0e-f1df-4ff3-02304b710a6e@kernel.org>
Date:   Thu, 6 Apr 2023 09:53:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [f2fs-dev] [PATCH 3/5] fstests/MAINTAINERS: add supported mailing
 list
Content-Language: en-US
To:     Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
Cc:     brauner@kernel.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ebiggers@google.com, djwong@kernel.org,
        amir73il@gmail.com, linux-unionfs@vger.kernel.org,
        anand.jain@oracle.com, linux-f2fs-devel@lists.sourceforge.net,
        linux-xfs@vger.kernel.org, fdmanana@suse.com,
        ocfs2-devel@oss.oracle.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On 2023/4/5 1:14, Zorro Lang wrote:
> +F2FS
> +L:	linux-f2fs-devel@lists.sourceforge.net
> +S:	Supported
> +F:	tests/f2fs/
> +F:	common/f2fs

Acked-by: Chao Yu <chao@kernel.org>

Thanks,
