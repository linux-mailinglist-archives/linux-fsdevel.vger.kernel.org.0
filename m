Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD65B77D79D
	for <lists+linux-fsdevel@lfdr.de>; Wed, 16 Aug 2023 03:23:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241013AbjHPBWk (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 15 Aug 2023 21:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241024AbjHPBWR (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 15 Aug 2023 21:22:17 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B35211E;
        Tue, 15 Aug 2023 18:22:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PmuPdi8/K6pjWpAa0PRvM2ZuotU5rWlA6d+bG8XAGeg=; b=1sWMc1iXD2EhA5fS0bF8rBq1yF
        O/ajvYoZuCHtExhS/gdhff5A3aXa9pg1/ODv/ZhJ1vy8vGt/WL0Y3vnBWmtYI7sxg0eD1BSMKyhGU
        ZXS4TbCDamVjR6JMc443Y4clCVUleI0oIrZFI8eTZVgUR0cX/GVd54dZfRUNeYRznTW4yCRjEc+xl
        lIxO7b2K58sC0vlcQPEa7eQL2Rv+mDX3SksLz3r2kFiN5o0kxMk1szTrvLKxPWAH6d+kshmQB73MG
        Rczab6Ai4tzea/hdW2Vwy8d3b1MM0ghJBE4cIzR0mdHKGAh50NE20Rm6wxxAE0eyL5/pKzWSjM/qi
        rSsl/Okg==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1qW5Ei-002wA5-31;
        Wed, 16 Aug 2023 01:22:12 +0000
Date:   Tue, 15 Aug 2023 18:22:12 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     "Darrick J. Wong" <djwong@kernel.org>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>, corbet@lwn.net,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        david@fromorbit.com, cem@kernel.org, sandeen@sandeen.net,
        chandan.babu@oracle.com, leah.rumancik@gmail.com, zlang@kernel.org,
        fstests@vger.kernel.org, willy@infradead.org,
        shirley.ma@oracle.com, konrad.wilk@oracle.com,
        Zorro Lang <zlang@redhat.com>
Subject: Re: [PATCH 1/3] docs: add maintainer entry profile for XFS
Message-ID: <ZNwkxD7S/6zYZ1OF@bombadil.infradead.org>
References: <169091989589.112530.11294854598557805230.stgit@frogsfrogsfrogs>
 <169091990172.112530.13872332887678504055.stgit@frogsfrogsfrogs>
 <ZNaMhgqbLJGdateQ@bombadil.infradead.org>
 <20230812000456.GA2375177@frogsfrogsfrogs>
 <CAOQ4uxibnPqE5qG9R53JyaMY1bd6j9OH0pq2eQxYpxDwf3xnGw@mail.gmail.com>
 <ZNwQT80yoHYrjvn+@bombadil.infradead.org>
 <20230816001108.GA1348949@frogsfrogsfrogs>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230816001108.GA1348949@frogsfrogsfrogs>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Aug 15, 2023 at 05:11:08PM -0700, Darrick J. Wong wrote:
> Note that we're talking about "M:" entries in the *fstests* MAINTAINERS
> file, not the kernel...

Ah, that makes much more sense :)

  Luis
