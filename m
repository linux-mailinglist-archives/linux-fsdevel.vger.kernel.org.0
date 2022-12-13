Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F4364BCC0
	for <lists+linux-fsdevel@lfdr.de>; Tue, 13 Dec 2022 20:08:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236624AbiLMTIx (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 13 Dec 2022 14:08:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236646AbiLMTIu (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 13 Dec 2022 14:08:50 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14C521649F;
        Tue, 13 Dec 2022 11:08:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C7AA0B815BA;
        Tue, 13 Dec 2022 19:08:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75869C433D2;
        Tue, 13 Dec 2022 19:08:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670958527;
        bh=g5ff1zzn0nB0wgtfu2Qotg/wMW3fPzWZZijMWNAvpns=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xs6LpL0zNCAzjrlBVFlvXUtP+C8cWj7R9gJ6MMDc6jopfny4xwcYXTuagpR89H0Ek
         EjcPh52ZbB6J1i5pDBJ4guQbILiOZLldJwwYMUhO7l+Nn+dXO2b2gbJZC67FbSUaeS
         oJOdYarB+1yu2D6rVadL57ShSr1F8rYX35ROiZoP3WoT4m8iebSvexu/ZodhqJqNJU
         lg05cryNkAGU6hTSy1U+gevfIE/sFXPXZk0NkdS1Ymbu/uzpf2COua4daFdySGESk6
         7MiF3DYDrbMxWZFO9gPczMfXY2cH3u2g7y/5CrpAvgkytImNQVKUgywQzt9V97LAvg
         gnrT83zayj1Hw==
Date:   Tue, 13 Dec 2022 11:08:45 -0800
From:   Eric Biggers <ebiggers@kernel.org>
To:     Andrey Albershteyn <aalbersh@redhat.com>
Cc:     linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 10/11] xfs: add fs-verity support
Message-ID: <Y5jNvXbW1cXGRPk2@sol.localdomain>
References: <20221213172935.680971-1-aalbersh@redhat.com>
 <20221213172935.680971-11-aalbersh@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221213172935.680971-11-aalbersh@redhat.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Dec 13, 2022 at 06:29:34PM +0100, Andrey Albershteyn wrote:
> 
> Also add check that block size == PAGE_SIZE as fs-verity doesn't
> support different sizes yet.

That's coming with
https://lore.kernel.org/linux-fsdevel/20221028224539.171818-1-ebiggers@kernel.org/T/#u,
which I'll be resending soon and I hope to apply for 6.3.
Review and testing of that patchset, along with its associated xfstests update
(https://lore.kernel.org/fstests/20221211070704.341481-1-ebiggers@kernel.org/T/#u),
would be greatly appreciated.

Note, as proposed there will still be a limit of:

	merkle_tree_block_size <= fs_block_size <= page_size

Hopefully you don't need fs_block_size > page_size or
merkle_tree_block_size > fs_block_size?

- Eric
