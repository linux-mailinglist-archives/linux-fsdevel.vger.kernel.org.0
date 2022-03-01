Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F42264C7F94
	for <lists+linux-fsdevel@lfdr.de>; Tue,  1 Mar 2022 01:46:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231883AbiCAAql (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Mon, 28 Feb 2022 19:46:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231889AbiCAAqj (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Mon, 28 Feb 2022 19:46:39 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D06A1EEF8;
        Mon, 28 Feb 2022 16:45:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=q7b2jxxkIoI0GODIdgrFy4hlxobPU7U3fg4glFt2E88=; b=qHhVIGCfi4auagdOHHHTskAoh4
        IEH7+8t7m5jbCVLyF3+wYxOH6HfxhhxUFN0jgaDNCStD/CNn9ZstIvnggoN5M0kFLGTYJdI9sNO1Z
        ckIIw/qQ83W7MuFtiPIsEwi6enXX89t7mWysBriuziQeJT6JO1wXo+nT/TkFhj57AKoSe19h3xof6
        2dm3xmru6SB7U2aqAp0jM8VpQvJBmuxSUf8tqUGDmA7flxYV4VhwDVzoaAaEwEQfDheR5NtKQgI9U
        4uVhl/OVf2LqGbBlfbjPwW6swKGJkU2eH7YeAvfLG7Snz8zB5AN/eIZNrlfPKFgi+eBnYHG2QQ60F
        SE/p86nQ==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nOqeI-00EWka-RU; Tue, 01 Mar 2022 00:45:54 +0000
Date:   Mon, 28 Feb 2022 16:45:54 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     James Bottomley <James.Bottomley@hansenpartnership.com>,
        lsf-pc@lists.linux-foundation.org, linux-fsdevel@vger.kernel.org,
        linux-block@vger.kernel.org, Christian Brauner <brauner@kernel.org>
Subject: Re: [LSF/MM/BPF TOPIC] configfd as a replacement for both ioctls and
 fsconfig
Message-ID: <Yh1swsJLXvLLIQ0e@bombadil.infradead.org>
References: <2ee1eb2b46a3bbdbde4244634586655247f5c676.camel@HansenPartnership.com>
 <1476917.1643724793@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1476917.1643724793@warthog.procyon.org.uk>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Feb 01, 2022 at 02:13:13PM +0000, David Howells wrote:
> James Bottomley <James.Bottomley@HansenPartnership.com> wrote:
> 
> > 
> > If the ioctl debate goes against ioctls, I think configfd would present
> > a more palatable alternative to netlink everywhere.
> 
> It'd be nice to be able to set up a 'configuration transaction' and then do a
> commit to apply it all in one go.

Can't io-uring cmd effort help here?

  Luis
