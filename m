Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9286770D9D2
	for <lists+linux-fsdevel@lfdr.de>; Tue, 23 May 2023 12:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbjEWKD7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 23 May 2023 06:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236538AbjEWKDm (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 23 May 2023 06:03:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC51410DC
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 03:03:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5947661C39
        for <linux-fsdevel@vger.kernel.org>; Tue, 23 May 2023 10:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D57D9C4339C;
        Tue, 23 May 2023 10:03:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684836199;
        bh=4KaikA8SZdt7zWz7GfmPF1T0Vq2qKT+hszZ8VMULmvg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tlVKcW7t2pJ4KIwK9kBxMfnsH6PTo920EjHFKeHjnO/tkD6iDabgwRCLrjxCzqqY+
         3EJFfQb6nS1GfBiFVhMiEAs2e4EyopMIiOACxVN7vuuMpPXqy1qJmhE+X1iEanTZmY
         PbvOF2n3kqvSIsNzD+zNN1L/+zGUUCzF0scsTl/O5HipMQenikRJQgb6ZJRUEX6IiX
         6zjXxQDTXCQHVnkKhgTM3VywIoH1bA7nxcOZ2m7tLJ34BLwd1n4LgS0ZiL6cJda+/a
         DxACTpEzfWleyIWyMvbOPGGNXwHwPiuEy+5Tt63AhzsYL3UU5+AVflK+WqrQqM0FoN
         pfB1XyXdHptng==
Date:   Tue, 23 May 2023 12:03:14 +0200
From:   Christian Brauner <brauner@kernel.org>
To:     Andrii Nakryiko <andrii@kernel.org>
Cc:     bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
        martin.lau@kernel.org, cyphar@cyphar.com, lennart@poettering.net,
        linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH v3 bpf-next 1/4] bpf: validate BPF object in BPF_OBJ_PIN
 before calling LSM
Message-ID: <20230523-gemein-kiesgrube-3343b4dc2eb4@brauner>
References: <20230522232917.2454595-1-andrii@kernel.org>
 <20230522232917.2454595-2-andrii@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230522232917.2454595-2-andrii@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Mon, May 22, 2023 at 04:29:14PM -0700, Andrii Nakryiko wrote:
> Do a sanity check whether provided file-to-be-pinned is actually a BPF
> object (prog, map, btf) before calling security_path_mknod LSM hook. If
> it's not, LSM hook doesn't have to be triggered, as the operation has no
> chance of succeeding anyways.
> 
> Suggested-by: Christian Brauner <brauner@kernel.org>
> Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
> ---

Reviewed-by: Christian Brauner <brauner@kernel.org>
