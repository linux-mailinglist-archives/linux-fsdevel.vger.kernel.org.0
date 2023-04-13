Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F074C6E0F99
	for <lists+linux-fsdevel@lfdr.de>; Thu, 13 Apr 2023 16:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231777AbjDMOFq (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Thu, 13 Apr 2023 10:05:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231787AbjDMOFj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Thu, 13 Apr 2023 10:05:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9AA21998;
        Thu, 13 Apr 2023 07:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=K5nZUzxVeKk1nQmTaGuEG3RDdG1E5Yn25XvsNQiJyqE=; b=ZaPAxnefp4rDq9oceos/2GiCjx
        rtestyedTkBKZ8kIs1FAusiLy1rj4aIZnLldkQg2T6h8NO4z9FNH3/ch34Hx98CD0Ef6EEC6E4MCM
        6E3kCuFkYBy7j7zPbljmab20qLVESpJPvA6HWirwANvkRQp1D3hK25tBLrczwigpqg/4DO7akh3LO
        bZ4iX+0JtAYub1pTTggk00KOmkdg6QkkP8vAswuSTPqsYwyNrultE/P9zjMEZGaxK21CQ45aiPhhZ
        gb/O3xZszHszPd7HVBMPs95aBGbFvGHro80I9AfMpZalLf5v1HSShAdD9NDwlZiVVlGXC/YTCRJSr
        QW+QOhiQ==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pmxZi-007rgw-U7; Thu, 13 Apr 2023 14:05:22 +0000
Date:   Thu, 13 Apr 2023 15:05:22 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Chuck Lever III <chuck.lever@oracle.com>
Cc:     "lsf-pc@lists.linux-foundation.org" 
        <lsf-pc@lists.linux-foundation.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] BoF for nfsd
Message-ID: <ZDgMIlpCwfCKcwkx@casper.infradead.org>
References: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <FF0202C3-7500-4BB3-914B-DBAA3E0EA3D7@oracle.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
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

 - Using larger folios instead of single pages; maybe this is the same
   discussion.

>     • tmpfs directory cookie stability (cel)
>     • timestamp resolution and i_version (jlayton)
>     • GSS Kerberos futures (dhowells)
>     • NFS/NFSD CI (jlayton)
>     • NFSD POSIX to NFSv4 ACL translation - writing down the rules (all)
> 
> Some of these topics might be appealing to others not specifically
> involved with NFSD development. If there's something that should
> be moved to another track or session, please pipe up.
> 
> --
> Chuck Lever
> 
> 
