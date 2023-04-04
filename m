Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879766D7000
	for <lists+linux-fsdevel@lfdr.de>; Wed,  5 Apr 2023 00:17:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbjDDWQ7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 4 Apr 2023 18:16:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjDDWQ5 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 4 Apr 2023 18:16:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEA9E40D9;
        Tue,  4 Apr 2023 15:16:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 495E163962;
        Tue,  4 Apr 2023 22:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3400BC433EF;
        Tue,  4 Apr 2023 22:16:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680646615;
        bh=iq/IdV4ogpOzaM8KgGTnYC5Td3WCpb/PqmrSUjFcqq0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hKIBSlBctkP5bivjN4Y21mckkcqW66+dkJqVt3sV5xlPSN1yzxtbcIDAa/udoQiUM
         sYGbOLNwfOA0gXRR+Wndw2VsarlhINwbmR9rKVH1FeHvdejvWrBskWjfnQnco9YqvD
         rpI3rk+9EzaMTkMEFIRuzDVL9UMVtvyfJBQ1f5Ze4NeqUuke7n1BCeowZBAWgMngKo
         42ZuMczWbvBA3Owwg/N+nslkw274BP30Pj/y3YKUBj/353slDtMf8ZPciuUUqEM6Ip
         0wa3X6hCp3Y9aaK3d1yKPuqKpW2wz0WLI7SD2d8mkTPKHHanh741qLv7i4NdaAMa8g
         +Pz1NY60vkAcQ==
Date:   Tue, 4 Apr 2023 15:16:53 -0700
From:   Eric Biggers <ebiggers@kernel.org>
To:     Zorro Lang <zlang@kernel.org>
Cc:     fstests@vger.kernel.org, brauner@kernel.org,
        linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
        djwong@kernel.org, amir73il@gmail.com,
        linux-unionfs@vger.kernel.org, anand.jain@oracle.com,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        fdmanana@suse.com, ocfs2-devel@oss.oracle.com, jack@suse.com,
        linux-fsdevel@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Subject: Re: [PATCH 3/5] fstests/MAINTAINERS: add supported mailing list
Message-ID: <20230404221653.GC1893@sol.localdomain>
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

Hi Zorro,

On Wed, Apr 05, 2023 at 01:14:09AM +0800, Zorro Lang wrote:
> +FSVERITY
> +L:	fsverity@lists.linux.dev
> +S:	Supported
> +F:	common/verity
> +
> +FSCRYPT
> +L:      linux-fscrypt@vger.kernel.org
> +S:	Supported
> +F:	common/encrypt

Most of the encrypt and verity tests are in tests/generic/ and are in the
'encrypt' or 'verity' test groups.

These file patterns only pick up the common files, not the actual tests.

Have you considered adding a way to specify maintainers for a test group?
Something like:

    G:      encrypt

and

    G:      verity

- Eric
