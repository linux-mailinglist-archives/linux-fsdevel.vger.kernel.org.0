Return-Path: <linux-fsdevel-owner@vger.kernel.org>
X-Original-To: lists+linux-fsdevel@lfdr.de
Delivered-To: lists+linux-fsdevel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B46B349B676
	for <lists+linux-fsdevel@lfdr.de>; Tue, 25 Jan 2022 15:37:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1578813AbiAYOf7 (ORCPT <rfc822;lists+linux-fsdevel@lfdr.de>);
        Tue, 25 Jan 2022 09:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1578586AbiAYOU1 (ORCPT
        <rfc822;linux-fsdevel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:20:27 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F86C061773;
        Tue, 25 Jan 2022 06:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=7e6ehZ3tcjuLk/murL+vFWKBKotB6peub/2KlcTcXaM=; b=p8kQPCYsJkN/Hr0l7LW5uAzqWL
        eMAQHkoahF4AkBAg3QkrVqCGW8X2TDrd6Y3qJwdOfrbRqKZoiYlBdaKZ1494n5vgljTLdv3sVLMdu
        G24NkYi/vGjfffnzeVCL9P3vQ0VYNtef8sTCQn9F2ZfTa57QUxxjVIflUC+T+N3k72UtB0UiNaLoA
        wEyaeYoBMy6q43lg/vniGuxIquC+BIp2CUzEt+dU5GK0e4JQrRGG3D3iXeaQaa4CqQZFhvaDpuNyz
        dN24gfaiwDqLTs1xKpfwardTrO33U+zYvKVTTX05ztZD0uEKvyEsvaFbOg8alUP0Ezh/FvNybVElQ
        2nDCv2Zw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nCMgH-002w0r-Fy; Tue, 25 Jan 2022 14:20:21 +0000
Date:   Tue, 25 Jan 2022 14:20:21 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Howells <dhowells@redhat.com>
Cc:     smfrench@gmail.com, nspmangalore@gmail.com,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-cachefs@redhat.com, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC PATCH 1/7] cifs: Transition from ->readpages() to
 ->readahead()
Message-ID: <YfAHJcXeSsAE4uMB@casper.infradead.org>
References: <164311902471.2806745.10187041199819525677.stgit@warthog.procyon.org.uk>
 <164311906472.2806745.605202239282432844.stgit@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <164311906472.2806745.605202239282432844.stgit@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-fsdevel.vger.kernel.org>
X-Mailing-List: linux-fsdevel@vger.kernel.org

On Tue, Jan 25, 2022 at 01:57:44PM +0000, David Howells wrote:
> +	while (readahead_count(ractl) - ractl->_batch_count) {

You do understand that prefixing a structure member with an '_' means
"Don't use this", right?  If I could get the compiler to prevent you, I
would.

