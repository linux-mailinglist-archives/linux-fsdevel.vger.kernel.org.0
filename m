Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81B856E0A4D
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 11:33:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229908AbjDMJdO (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 05:33:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjDMJdN (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 05:33:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A179F49FE;
        Thu, 13 Apr 2023 02:33:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F25A61044;
        Thu, 13 Apr 2023 09:33:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 569CCC433D2;
        Thu, 13 Apr 2023 09:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1681378390;
        bh=cX+YR4sYfHQVIin5CrjPKChz/WEarF6XYBxJ10LRQEo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YWWvQ+jtiX1gGzESly7my0AANCYLShWFTaIhzftU6GCnq/tRW8iJgSZiYNt4KLN4S
         4k1P0nHYerZzKtqIcMREW5FbW1Qt4Mjr5uPlWQymoJwaUe4PszsF8Dw+3g7g9R2EpC
         +5T54Vz4JBgzR8mVlsLhZANbNsRlcmz4Wnx3fWfSBBQCdIbtXOnKdaD82NRtWeiRW+
         OQqsPINen344018FHC4o62PEBY1AbC3h1uE3dWzdz4MbMPTDaj5O+dEibEfIqFcc6U
         P9+GIDFcNNJIr+/Le1PNx6CPFWgVOPgqJYCaCHg8hXyybT/GBDx8uneRYCUxjiFAW6
         o8vX1RlQmy7UA==
Date:   Thu, 13 Apr 2023 11:33:05 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Message-ID: <20230413-perspektive-glasur-6e2685229a95@brauner>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Wed, Apr 12, 2023 at 06:27:07PM +0000, Chuck Lever III wrote:
> I'd like to request some time for those interested specifically
> in NFSD to gather and discuss some topics. Not a network file
> system free-for-all, but specifically for NFSD, because there
> is a long list of potential topics:
> 
>     • Progress on using iomap for NFSD READ/READ_PLUS (anna)
>     • Replacing nfsd_splice_actor (all)
>     • Transition from page arrays to bvecs (dhowells, hch)
>     • tmpfs directory cookie stability (cel)
>     • timestamp resolution and i_version (jlayton)

I'd attend this one.

>     • GSS Kerberos futures (dhowells)
>     • NFS/NFSD CI (jlayton)
>     • NFSD POSIX to NFSv4 ACL translation - writing down the rules (all)

I have some experience dealing with ACLs so I'm happy to attend just in
case I may be useful.
