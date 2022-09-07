Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C5345AFFF1
	for <lists+linux-fsdevel@lfdr.de>; Wed,  7 Sep 2022 11:09:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbiIGJJO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Wed, 7 Sep 2022 05:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230369AbiIGJJL (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:09:11 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56049ACA07;
        Wed,  7 Sep 2022 02:09:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C8BA0B81ADD;
        Wed,  7 Sep 2022 09:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20CB2C43140;
        Wed,  7 Sep 2022 09:09:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662541746;
        bh=626PJkIvKnC04r4L1Ir30UYXOHHnLvLYV03pC1ltMio=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PF0ZWY2OQKuqDZR1fc4EAZXGcnI/fj5AIP+EW4gn9y6nuDGpX5/YiigQL+E2SCeyv
         uhTe0nxraWrL5npEyBgEgeI3g9OaYA3dhZD/GUN20LKgpfL4n7evmTzVSsLOpZXCso
         rrWyBmIAGLE+MfLGmrM4th7cTVY4z7+cbj2vSJokL+I4oF0kGQBz5CZMMp77gYzhmk
         sakrwjsNDuMkqPzFHrjT6p34So7oNACwGNmmn8HDO0TJ2OTyrgO30PLA3ehsr92oPH
         YJ6lwKDGVIsPDStZ2LN8+CO4WehvCPiKFGYl5gBpMFsnqCCIKsEVwQgjWH8jHHNmmO
         9aO+hYpAyq5YA==
Date:   Wed, 7 Sep 2022 11:09:00 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Eric Biggers <ebiggers@kernel.org>
Cc:     linux-fsdevel@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
        linux-api@vger.kernel.org, linux-fscrypt@vger.kernel.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Keith Busch <kbusch@kernel.org>
Subject: Re: [PATCH v5 2/8] vfs: support STATX_DIOALIGN on block devices
Message-ID: <20220907090900.ji3ilhyxbftptdma@wittgenstein>
References: <20220827065851.135710-1-ebiggers@kernel.org>
 <20220827065851.135710-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220827065851.135710-3-ebiggers@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Fri, Aug 26, 2022 at 11:58:45PM -0700, Eric Biggers wrote:
> From: Eric Biggers <ebiggers@google.com>
> 
> Add support for STATX_DIOALIGN to block devices, so that direct I/O
> alignment restrictions are exposed to userspace in a generic way.
> 
> Note that this breaks the tradition of stat operating only on the block
> device node, not the block device itself.  However, it was felt that
> doing this is preferable, in order to make the interface useful and
> avoid needing separate interfaces for regular files and block devices.
> 
> Signed-off-by: Eric Biggers <ebiggers@google.com>
> ---

Looks good to me,
Reviewed-by: Christian Brauner (Microsoft) <brauner@kernel.org>
